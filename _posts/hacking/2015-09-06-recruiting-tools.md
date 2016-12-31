---
layout: post
title: "Developing recruiting tools"
comments: true
permalink: recruiting-tools
layout: post
tags: [github, git, bash]
categories: hacking
---

Finding employees can be a hard problem for most tech companies.  How does one find stellar employees?  Word of mouth, open source projects, StackOverlow, campus events?

Recently I put together a system for some recruiter friends that does the following:

  * git clone several open source projects 

  * Perform the following GIT query for names and emails

~~~
  git log --format='%aN <%aE>' | awk '{arr[$0]++} END{for (i in arr){print arr[i], i;}}' | sort -rn | cut -d\  -f2-  
~~~
{: .language-bash}
&nbsp;

  * Collect those results into a collection

  * For each of those queries, query the GitHub interface for [statistics](https://developer.github.com/v3/repos/statistics/) about the author.

  * Future work: Cross reference emails against StackOverlow....need to investigate the methods for doing so there.

If you want to try something similar, here is a small PoC to get users for a repo:

~~~
#!/usr/bin/env bash

function getAuthors(){
  git clone -q $1 /tmp/_git
  cd /tmp/_git
  git log --format='%aN <%aE>' | awk '{arr[$0]++} END{for (i in arr){print arr[i], i;}}' | sort -rn | cut -d\  -f2-  
  rm -rf /tmp/_git
}

getAuthors $1

~~~
{: .language-bash}

You can use it by passing a GIT URL to the script like so:

~~~
./getAuthors.sh https://github.com/boostorg/asio.git
~~~
{: .language-bash}

Which will find the authors and emails of those who have contributed to Boost ASIO.

  Christopher Kohlhoff <chris@kohlhoff.com>

  Troy D. Straszheim <troy@resophonic.com>

  John Maddock <john@johnmaddock.co.uk>

  Beman Dawes <bdawes@acm.org>

  Stephen Kelly <steveire@gmail.com>

  Michael A. Jackson <mike.jackson@bluequartz.net>

  Daniel James <daniel@calamity.org.uk>

  Vladimir Prus <ghost@cs.msu.su>

  Bryce Adelstein-Lelbach <blelbach@cct.lsu.edu>

  Vicente J. Botet Escriba <vicente.botet@wanadoo.fr>

  Steven Watanabe <steven@providere-consulting.com>

  Nicola Musatti <nicola.musatti@gmail.com>

  Hartmut Kaiser <hartmut.kaiser@gmail.com>

For this bear in mind that GIT commits are malleable and can be manipulated as anyone can do this for fun:

~~~
export GIT_AUTHOR_NAME="Linus Torvalds"
export GIT_AUTHOR_EMAIL="torvalds@linux-foundation.org"
export GIT_COMMITTER_NAME="$GIT_AUTHOR_NAME"
export GIT_COMMITTER_EMAIL="$GIT_AUTHOR_EMAIL"
git commit -m "Enjoy!"
~~~
{: .language-bash}

&nbsp;

 That is why it is important to verify against say the GitHub statistics API.

  [Source](https://github.com/amoffat/masquerade/commit/9b0562595cc479ac8696110cb0a2d33f8f2b7d29?short_path=04c6e90#diff-04c6e90faac2675aa89e2176d2eec7d8)

  I'm leaving that stage of the process out for now as I am still finalizing the design.
