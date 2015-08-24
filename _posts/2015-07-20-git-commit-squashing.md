---
layout: post
title: "GIT commit squashing"
comments: true
permalink: git-commit-squashing
layout: post
tags: [git, history]
---
*Squash 'dem commits!*
-----

<div>
<!-- <a href="https://twitter.com/share" class="twitter-share-button" data-via="__shenderson__">Tweet</a> -->
 
<a href="https://twitter.com/__shenderson__" class="twitter-follow-button" data-show-count="false">Follow @__shenderson__</a>
<script>!function(d,s,id){var js,fjs=d.getElementsByTagName(s)[0],p=/^http:/.test(d.location)?'http':'https';if(!d.getElementById(id)){js=d.createElement(s);js.id=id;js.src=p+'://platform.twitter.com/widgets.js';fjs.parentNode.insertBefore(js,fjs);}}(document, 'script', 'twitter-wjs');</script>
 
 </div>

<!-- Put this just before the closing body tag -->
<script>!function(d,s,id){var js,fjs=d.getElementsByTagName(s)[0];if(!d.getElementById(id)){js=d.createElement(s);js.id=id;js.src="//platform.twitter.com/widgets.js";fjs.parentNode.insertBefore(js,fjs);}}(document,"script","twitter-wjs");</script>

I usually get pulled into several code review each week.  You can usually tell how much of the stuggle it was for a developer given the GIT commit history:

| commit history | description              							|
|----------------|------------------------------------------------------|
| 0				 | master												|
| 1				 | initial commit on branch 							|
| 2			     | added feature										|
| 3				 | code review feedback - forgot to add tests   	   	|
| 4			     | code review feedback - forgot to add documentation   |

When the developer is ready to bring this up for review, they probably rather squash (condense) these commits down into something more like:

| commit history | description              							|
|----------------|------------------------------------------------------|
| 0				 | master												|
| 1				 | added feature on branch 					      		|

You can perform this on your branch by using the following terminal commands:

  * git reset $(git merge-base master YOUR_BRANCH_NAME_GOES_HERE)

  *  git add -A

  * git commit -m ’SOME_COMMIT_HERE'

  * git push -f origin YOUR_BRANCH_NAME_GOES_HERE

The reset when your code comes back to the main branch of development....bliss.

BONUS:

It often pays to have usable commit history in your terminal and here is how to make that happen:

  * Create a .gitconfig file in your home directory if one doesn't exist.  touch ~/.gitconfig

  * Add the following alias to it:

  ```
  [alias]
  lg1 = log --graph --abbrev-commit --decorate --date=relative --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(bold yellow)%d%C(reset)' --all

  lg2 = log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold cyan)%aD%C(reset) %C(bold green)(%ar)%C(reset)%C(bold yellow)%d%C(reset)%n''          %C(white)%s%C(reset) %C(dim white)- %an%C(reset)' --all

  lg = !"git lg1"
  ```

  Next time you type in `git lg1` ot `git lg2` in the terminal, it is easier to follow.  I picked this alias up from [StackOverflow] (http://stackoverflow.com/questions/1057564/pretty-git-branch-graphs) to replace mine and have been happy with it.

