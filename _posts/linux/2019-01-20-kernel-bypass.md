---
layout: post
title: "Real-time Kernel Patching"
comments: false
permalink: rt-patching
layout: post
tags: [kernel, rt, patch, jitter, latency, installation]
categories: linux
---
Installing the Real-time Kernel Patch on CentOS 7
-----

In high-performance applications such as high-frequency trading, graphics, and other high-performance environments, it is critical to utilize a real-time kernel.  The reason for this is real-time scheduling is critical for latency sensitive applications.  There are many such kernels available which I will cover soon.  This posting will cover the `CONFIG PREMPT RT` Patch.  This patch when applied to the Linux kernel:
  * Allows the kernel to be prempted except in raw spinlock critical regions
  * Replaces the majority of the [kernel spinlock objects](https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git/tree/kernel/locking/spinlock.c?h=linux-4.19.y-rt-rebase&id=0a367666ad2a4939c6cc197dafba983b447920f1) with [mutexes that support priority inheritance](https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git/tree/kernel/locking/rtmutex.c?h=linux-4.19.y-rt-rebase&id=0a367666ad2a4939c6cc197dafba983b447920f1).  The priority inheritance implementation is covered more in appendix A.

## Real-time Concepts [reference 4]:
  * Deadline: An action must happen in a certain point in time. This time is called a deadline. In a hard real-time application every deadline must be met.
  * Latency: Latency is the time diﬀerence between the time when something should happen and when it actually happens. In an ideal system the latency is zero.
  * Jitter: The variance of latency.
  * Predictability: Predictability means that the execution time of an operation is known beforehand. The operation is allowed to use the required time to complete.
  * Worst case: When latency and jitter are known and the time is allocated in such a way that there is room for the worst amount of jitter, the system behaviour can be predicted.
  * Periodic tasks: A periodic task needs to be executed at predeﬁned intervals. The intervals are the same for the lifetime of the task.

## Installation Overview

  1. Download the kernel sources
  2. Download the real-time (RT) patch
  3. Unpack the kernel source and RT patch
  4. Apply the RT patch to the kernel sources
  5. Compile the kernel, kernel modules, and the RT libraries
  6. Install the new kernel
  7. Reboot and verify the RT installation.

## CentOS 7 Example

  1.  CERN [hosts](http://linuxsoft.cern.ch/) the both Scientific Linux (SLC) 5/6 and CentOS 7 source sets.  For the case of CentOS 7, you can add this to the `yum-config-manager` via
  ```
  sudo yum-config-manager --add-repo=http://linuxsoft.cern.ch/cern/centos/7/rt/CentOS-RT.repo
  ```
  2.  Set gpgcheck=1 to gpgcheck=0 for each entry in `/etc/yum.repos.d/CentOS-RT.repo`
  2.  Install the yum group `RealTime` via
  ```
  sudo yum group install -y RealTime
  ```
  [RealTime Group Contents](http://linuxsoft.cern.ch/cern/centos/7/rt/x86_64/repoview/RT.group.html)

  3. Reboot
  4. Check your kernel version, `name -a`

  *NOTE*: You may have to adjust the installed kernel to be the default in `grub2-mkconfig -o /boot/grub2/grub.cfg` via the `GRUB_DEFAULT` variable.

## Verification by Measurement

You may track many of the changes in real-time concepts defined above by utilizing the tools in the `rt-tests` codebase.  There are available [here](https://git.kernel.org/pub/scm/linux/kernel/git/clrkwllms/rt-tests.git/tree/).

System jitter can be measured using tooling provided by OpenOnload called `sysjitter`.  Is is available [here](https://www.openonload.org/download/sysjitter/).

### References

1.  [A realtime preemption overview](https://lwn.net/Articles/146861/)
2.  [Priority Inheritance](https://rt.wiki.kernel.org/index.php/Priority_inheritance)
3.  [Linux RT Source Code](https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git/tree/)
4.  [Lietzen, J.  "Linux Scheduling in Embedded Systems".](https://wiki.aalto.fi/display/EmbeddedLinux/Linux+scheduling+in+embedded+systems?preview=/84748707/89686177/scheduling_final.pdf)
5.  [yum-config-manager](https://www.systutorials.com/docs/linux/man/1-yum-config-manager/)

### Appendix A: Implementation Details

Interesting Areas of the Implementation:

[Adjustment of the RT Mutex Priority Chain](https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git/tree/kernel/locking/rtmutex.c?h=linux-4.19.y-rt-rebase&id=0a367666ad2a4939c6cc197dafba983b447920f1#n428):
```
/*
 * Adjust the priority chain. Also used for deadlock detection.
 * Decreases task's usage by one - may thus free the task.
 *
 * @task:	the task owning the mutex (owner) for which a chain walk is
 *		probably needed
 * @chwalk:	do we have to carry out deadlock detection?
 * @orig_lock:	the mutex (can be NULL if we are walking the chain to recheck
 *		things for a task that has just got its priority adjusted, and
 *		is waiting on a mutex)
 * @next_lock:	the mutex on which the owner of @orig_lock was blocked before
 *		we dropped its pi_lock. Is never dereferenced, only used for
 *		comparison to detect lock chain changes.
 * @orig_waiter: rt_mutex_waiter struct for the task that has just donated
 *		its priority to the mutex owner (can be NULL in the case
 *		depicted above or if the top waiter is gone away and we are
 *		actually deboosting the owner)
 * @top_task:	the current top waiter
 *
 * Returns 0 or -EDEADLK.
 *
 * Chain walk basics and protection scope
 *
 * [R] refcount on task
 * [P] task->pi_lock held
 * [L] rtmutex->wait_lock held
 *
 * Step	Description				Protected by
 *	function arguments:
 *	@task					[R]
 *	@orig_lock if != NULL			@top_task is blocked on it
 *	@next_lock				Unprotected. Cannot be
 *						dereferenced. Only used for
 *						comparison.
 *	@orig_waiter if != NULL			@top_task is blocked on it
 *	@top_task				current, or in case of proxy
 *						locking protected by calling
 *						code
 *	again:
 *	  loop_sanity_check();
 *	retry:
 * [1]	  lock(task->pi_lock);			[R] acquire [P]
 * [2]	  waiter = task->pi_blocked_on;		[P]
 * [3]	  check_exit_conditions_1();		[P]
 * [4]	  lock = waiter->lock;			[P]
 * [5]	  if (!try_lock(lock->wait_lock)) {	[P] try to acquire [L]
 *	    unlock(task->pi_lock);		release [P]
 *	    goto retry;
 *	  }
 * [6]	  check_exit_conditions_2();		[P] + [L]
 * [7]	  requeue_lock_waiter(lock, waiter);	[P] + [L]
 * [8]	  unlock(task->pi_lock);		release [P]
 *	  put_task_struct(task);		release [R]
 * [9]	  check_exit_conditions_3();		[L]
 * [10]	  task = owner(lock);			[L]
 *	  get_task_struct(task);		[L] acquire [R]
 *	  lock(task->pi_lock);			[L] acquire [P]
 * [11]	  requeue_pi_waiter(tsk, waiters(lock));[P] + [L]
 * [12]	  check_exit_conditions_4();		[P] + [L]
 * [13]	  unlock(task->pi_lock);		release [P]
 *	  unlock(lock->wait_lock);		release [L]
 *	  goto again;
 */
static int rt_mutex_adjust_prio_chain(struct task_struct *task,
				      enum rtmutex_chainwalk chwalk,
				      struct rt_mutex *orig_lock,
				      struct rt_mutex *next_lock,
				      struct rt_mutex_waiter *orig_waiter,
				      struct task_struct *top_task)
{
	struct rt_mutex_waiter *waiter, *top_waiter = orig_waiter;
	struct rt_mutex_waiter *prerequeue_top_waiter;
	int ret = 0, depth = 0;
	struct rt_mutex *lock;
	bool detect_deadlock;
	bool requeue = true;

	detect_deadlock = rt_mutex_cond_detect_deadlock(orig_waiter, chwalk);

	/*
	 * The (de)boosting is a step by step approach with a lot of
	 * pitfalls. We want this to be preemptible and we want hold a
	 * maximum of two locks per step. So we have to check
	 * carefully whether things change under us.
	 */
 again:
	/*
	 * We limit the lock chain length for each invocation.
	 */
	if (++depth > max_lock_depth) {
		static int prev_max;

		/*
		 * Print this only once. If the admin changes the limit,
		 * print a new message when reaching the limit again.
		 */
		if (prev_max != max_lock_depth) {
			prev_max = max_lock_depth;
			printk(KERN_WARNING "Maximum lock depth %d reached "
			       "task: %s (%d)\n", max_lock_depth,
			       top_task->comm, task_pid_nr(top_task));
		}
		put_task_struct(task);

		return -EDEADLK;
	}

	/*
	 * We are fully preemptible here and only hold the refcount on
	 * @task. So everything can have changed under us since the
	 * caller or our own code below (goto retry/again) dropped all
	 * locks.
	 */
 retry:
	/*
	 * [1] Task cannot go away as we did a get_task() before !
	 */
	raw_spin_lock_irq(&task->pi_lock);

	/*
	 * [2] Get the waiter on which @task is blocked on.
	 */
	waiter = task->pi_blocked_on;

	/*
	 * [3] check_exit_conditions_1() protected by task->pi_lock.
	 */

	/*
	 * Check whether the end of the boosting chain has been
	 * reached or the state of the chain has changed while we
	 * dropped the locks.
	 */
	if (!rt_mutex_real_waiter(waiter))
		goto out_unlock_pi;

	/*
	 * Check the orig_waiter state. After we dropped the locks,
	 * the previous owner of the lock might have released the lock.
	 */
	if (orig_waiter && !rt_mutex_owner(orig_lock))
		goto out_unlock_pi;

	/*
	 * We dropped all locks after taking a refcount on @task, so
	 * the task might have moved on in the lock chain or even left
	 * the chain completely and blocks now on an unrelated lock or
	 * on @orig_lock.
	 *
	 * We stored the lock on which @task was blocked in @next_lock,
	 * so we can detect the chain change.
	 */
	if (next_lock != waiter->lock)
		goto out_unlock_pi;

	/*
	 * Drop out, when the task has no waiters. Note,
	 * top_waiter can be NULL, when we are in the deboosting
	 * mode!
	 */
	if (top_waiter) {
		if (!task_has_pi_waiters(task))
			goto out_unlock_pi;
		/*
		 * If deadlock detection is off, we stop here if we
		 * are not the top pi waiter of the task. If deadlock
		 * detection is enabled we continue, but stop the
		 * requeueing in the chain walk.
		 */
		if (top_waiter != task_top_pi_waiter(task)) {
			if (!detect_deadlock)
				goto out_unlock_pi;
			else
				requeue = false;
		}
	}

	/*
	 * If the waiter priority is the same as the task priority
	 * then there is no further priority adjustment necessary.  If
	 * deadlock detection is off, we stop the chain walk. If its
	 * enabled we continue, but stop the requeueing in the chain
	 * walk.
	 */
	if (rt_mutex_waiter_equal(waiter, task_to_waiter(task))) {
		if (!detect_deadlock)
			goto out_unlock_pi;
		else
			requeue = false;
	}

	/*
	 * [4] Get the next lock
	 */
	lock = waiter->lock;
	/*
	 * [5] We need to trylock here as we are holding task->pi_lock,
	 * which is the reverse lock order versus the other rtmutex
	 * operations.
	 */
	if (!raw_spin_trylock(&lock->wait_lock)) {
		raw_spin_unlock_irq(&task->pi_lock);
		cpu_relax();
		goto retry;
	}

	/*
	 * [6] check_exit_conditions_2() protected by task->pi_lock and
	 * lock->wait_lock.
	 *
	 * Deadlock detection. If the lock is the same as the original
	 * lock which caused us to walk the lock chain or if the
	 * current lock is owned by the task which initiated the chain
	 * walk, we detected a deadlock.
	 */
	if (lock == orig_lock || rt_mutex_owner(lock) == top_task) {
		debug_rt_mutex_deadlock(chwalk, orig_waiter, lock);
		raw_spin_unlock(&lock->wait_lock);
		ret = -EDEADLK;
		goto out_unlock_pi;
	}

	/*
	 * If we just follow the lock chain for deadlock detection, no
	 * need to do all the requeue operations. To avoid a truckload
	 * of conditionals around the various places below, just do the
	 * minimum chain walk checks.
	 */
	if (!requeue) {
		/*
		 * No requeue[7] here. Just release @task [8]
		 */
		raw_spin_unlock(&task->pi_lock);
		put_task_struct(task);

		/*
		 * [9] check_exit_conditions_3 protected by lock->wait_lock.
		 * If there is no owner of the lock, end of chain.
		 */
		if (!rt_mutex_owner(lock)) {
			raw_spin_unlock_irq(&lock->wait_lock);
			return 0;
		}

		/* [10] Grab the next task, i.e. owner of @lock */
		task = rt_mutex_owner(lock);
		get_task_struct(task);
		raw_spin_lock(&task->pi_lock);

		/*
		 * No requeue [11] here. We just do deadlock detection.
		 *
		 * [12] Store whether owner is blocked
		 * itself. Decision is made after dropping the locks
		 */
		next_lock = task_blocked_on_lock(task);
		/*
		 * Get the top waiter for the next iteration
		 */
		top_waiter = rt_mutex_top_waiter(lock);

		/* [13] Drop locks */
		raw_spin_unlock(&task->pi_lock);
		raw_spin_unlock_irq(&lock->wait_lock);

		/* If owner is not blocked, end of chain. */
		if (!next_lock)
			goto out_put_task;
		goto again;
	}

	/*
	 * Store the current top waiter before doing the requeue
	 * operation on @lock. We need it for the boost/deboost
	 * decision below.
	 */
	prerequeue_top_waiter = rt_mutex_top_waiter(lock);

	/* [7] Requeue the waiter in the lock waiter tree. */
	rt_mutex_dequeue(lock, waiter);

	/*
	 * Update the waiter prio fields now that we're dequeued.
	 *
	 * These values can have changed through either:
	 *
	 *   sys_sched_set_scheduler() / sys_sched_setattr()
	 *
	 * or
	 *
	 *   DL CBS enforcement advancing the effective deadline.
	 *
	 * Even though pi_waiters also uses these fields, and that tree is only
	 * updated in [11], we can do this here, since we hold [L], which
	 * serializes all pi_waiters access and rb_erase() does not care about
	 * the values of the node being removed.
	 */
	waiter->prio = task->prio;
	waiter->deadline = task->dl.deadline;

	rt_mutex_enqueue(lock, waiter);

	/* [8] Release the task */
	raw_spin_unlock(&task->pi_lock);
	put_task_struct(task);

	/*
	 * [9] check_exit_conditions_3 protected by lock->wait_lock.
	 *
	 * We must abort the chain walk if there is no lock owner even
	 * in the dead lock detection case, as we have nothing to
	 * follow here. This is the end of the chain we are walking.
	 */
	if (!rt_mutex_owner(lock)) {
		struct rt_mutex_waiter *lock_top_waiter;

		/*
		 * If the requeue [7] above changed the top waiter,
		 * then we need to wake the new top waiter up to try
		 * to get the lock.
		 */
		lock_top_waiter = rt_mutex_top_waiter(lock);
		if (prerequeue_top_waiter != lock_top_waiter)
			rt_mutex_wake_waiter(lock_top_waiter);
		raw_spin_unlock_irq(&lock->wait_lock);
		return 0;
	}

	/* [10] Grab the next task, i.e. the owner of @lock */
	task = rt_mutex_owner(lock);
	get_task_struct(task);
	raw_spin_lock(&task->pi_lock);

	/* [11] requeue the pi waiters if necessary */
	if (waiter == rt_mutex_top_waiter(lock)) {
		/*
		 * The waiter became the new top (highest priority)
		 * waiter on the lock. Replace the previous top waiter
		 * in the owner tasks pi waiters tree with this waiter
		 * and adjust the priority of the owner.
		 */
		rt_mutex_dequeue_pi(task, prerequeue_top_waiter);
		rt_mutex_enqueue_pi(task, waiter);
		rt_mutex_adjust_prio(task);

	} else if (prerequeue_top_waiter == waiter) {
		/*
		 * The waiter was the top waiter on the lock, but is
		 * no longer the top prority waiter. Replace waiter in
		 * the owner tasks pi waiters tree with the new top
		 * (highest priority) waiter and adjust the priority
		 * of the owner.
		 * The new top waiter is stored in @waiter so that
		 * @waiter == @top_waiter evaluates to true below and
		 * we continue to deboost the rest of the chain.
		 */
		rt_mutex_dequeue_pi(task, waiter);
		waiter = rt_mutex_top_waiter(lock);
		rt_mutex_enqueue_pi(task, waiter);
		rt_mutex_adjust_prio(task);
	} else {
		/*
		 * Nothing changed. No need to do any priority
		 * adjustment.
		 */
	}

	/*
	 * [12] check_exit_conditions_4() protected by task->pi_lock
	 * and lock->wait_lock. The actual decisions are made after we
	 * dropped the locks.
	 *
	 * Check whether the task which owns the current lock is pi
	 * blocked itself. If yes we store a pointer to the lock for
	 * the lock chain change detection above. After we dropped
	 * task->pi_lock next_lock cannot be dereferenced anymore.
	 */
	next_lock = task_blocked_on_lock(task);
	/*
	 * Store the top waiter of @lock for the end of chain walk
	 * decision below.
	 */
	top_waiter = rt_mutex_top_waiter(lock);

	/* [13] Drop the locks */
	raw_spin_unlock(&task->pi_lock);
	raw_spin_unlock_irq(&lock->wait_lock);

	/*
	 * Make the actual exit decisions [12], based on the stored
	 * values.
	 *
	 * We reached the end of the lock chain. Stop right here. No
	 * point to go back just to figure that out.
	 */
	if (!next_lock)
		goto out_put_task;

	/*
	 * If the current waiter is not the top waiter on the lock,
	 * then we can stop the chain walk here if we are not in full
	 * deadlock detection mode.
	 */
	if (!detect_deadlock && waiter != top_waiter)
		goto out_put_task;

	goto again;

 out_unlock_pi:
	raw_spin_unlock_irq(&task->pi_lock);
 out_put_task:
	put_task_struct(task);

	return ret;
}
```