---
layout: post
title: 01-10-2016 Creating a Dead Simple JSON Configuration Reader
comments: true
permalink: 01102016-json-reader
tags:
  - cpp
  - boost
  - json
---

<div><!-- <a href="https://twitter.com/share" class="twitter-share-button" data-via="__shenderson__">Tweet</a> --><a class="twitter-follow-button" data-show-count="false" href="https://twitter.com/__shenderson__">Follow @__shenderson__</a> <script>!function(d,s,id){var js,fjs=d.getElementsByTagName(s)[0],p=/^http:/.test(d.location)?'http':'https';if(!d.getElementById(id)){js=d.createElement(s);js.id=id;js.src=p+'://platform.twitter.com/widgets.js';fjs.parentNode.insertBefore(js,fjs);}}(document, 'script', 'twitter-wjs');</script></div>

<script>!function(d,s,id){var js,fjs=d.getElementsByTagName(s)[0];if(!d.getElementById(id)){js=d.createElement(s);js.id=id;js.src="//platform.twitter.com/widgets.js";fjs.parentNode.insertBefore(js,fjs);}}(document,"script","twitter-wjs");</script>

&nbsp;

![](/uploads/versions/vader_water---x----283-400x---.jpg)

Blog posts of the week:

* [C++ Status at the end of 2015](http://www.bfilipek.com/2015/12/c-status-at-end-of-2015.html)
* [Levels of Exception Safety](http://arne-mertz.de/2015/12/levels-of-exception-safety/)
* [Incorporating and accessing binary data into a C program](http://smackerelofopinion.blogspot.de/2015/12/incorporating-and-accesses-binary-data.html?utm_content=buffercdd33&amp;utm_medium=social&amp;utm_source=twitter.com&amp;utm_campaign=buffer)
* [a problem with LLVM's undef](http://www.playingwithpointers.com/problem-with-undef.html?utm_content=buffer7c2d6&amp;utm_medium=social&amp;utm_source=twitter.com&amp;utm_campaign=buffer)
* [Embedded Programming with the GNU Toolchain](http://www.bravegnu.org/gnu-eprog/?utm_content=bufferfdd2a&amp;utm_medium=social&amp;utm_source=twitter.com&amp;utm_campaign=buffer)
* [Getting your C++ to the Web with Node.js](http://blog.scottfrees.com/getting-your-c-to-the-web-with-node-js?utm_content=buffera86bb&amp;utm_medium=social&amp;utm_source=twitter.com&amp;utm_campaign=buffer)
* [ENUM CLASS. WHY SHOULD YOU CARE?](https://katecpp.wordpress.com/2015/12/28/enum-class/?utm_content=buffer65f82&amp;utm_medium=social&amp;utm_source=twitter.com&amp;utm_campaign=buffer)
* [Moore's law hits the roof](http://www.agner.org/optimize/blog/read.php?i=417)
* [Lessons learnt from 10+ years with actors in C++](http://sourceforge.net/p/sobjectizer/wiki/Lessons%20learnt%20from%2010+%20years%20with%20actors%20in%20C++/?utm_content=buffere6cf9&amp;utm_medium=social&amp;utm_source=twitter.com&amp;utm_campaign=buffer)
* [Optimizing C++ Const Objects in LLVM](https://docs.google.com/document/d/112O-Q_XrbrU1I4P-oiLCN9u86Qg_BYBdcDsmh7Pn9Nw/mobilebasic?pref=2&amp;pli=1&amp;utm_content=buffercfc09&amp;utm_medium=social&amp;utm_source=twitter.com&amp;utm_campaign=buffer)
* [Sizeof, memset, memcpy](http://dorinlazar.ro/sizeof-memset-memcpy/?utm_content=buffer65f7a&amp;utm_medium=social&amp;utm_source=twitter.com&amp;utm_campaign=buffer)
* [Implementing the standard variant](https://thenewcpp.wordpress.com/2015/12/22/implementing-the-standard-variant/?utm_content=buffer8052f&amp;utm_medium=social&amp;utm_source=twitter.com&amp;utm_campaign=buffer)
* [Quickly Loading Things From Disk](http://probablydance.com/2015/12/19/quickly-loading-things-from-disk/?utm_content=buffer37cf2&amp;utm_medium=social&amp;utm_source=twitter.com&amp;utm_campaign=buffer)


Repos of the week:

* [Elemental](https://github.com/elemental/Elemental?utm_content=buffer83b26&amp;utm_medium=social&amp;utm_source=twitter.com&amp;utm_campaign=buffer)
* [Hashcat](https://github.com/hashcat/?utm_content=buffer417b0&amp;utm_medium=social&amp;utm_source=twitter.com&amp;utm_campaign=buffer)