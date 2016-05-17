---
layout: post
title: 05-17-2016 Securing OSX
comments: true
permalink: 05172016-securing-osx
tags:
  - OSX
  - Apple
  - Security
---

<div><!-- <a href="https://twitter.com/share" class="twitter-share-button" data-via="__shenderson__">Tweet</a> --><a class="twitter-follow-button" data-show-count="false" href="https://twitter.com/__shenderson__">Follow @__shenderson__</a> <script>!function(d,s,id){var js,fjs=d.getElementsByTagName(s)[0],p=/^http:/.test(d.location)?'http':'https';if(!d.getElementById(id)){js=d.createElement(s);js.id=id;js.src=p+'://platform.twitter.com/widgets.js';fjs.parentNode.insertBefore(js,fjs);}}(document, 'script', 'twitter-wjs');</script></div>

<script>!function(d,s,id){var js,fjs=d.getElementsByTagName(s)[0];if(!d.getElementById(id)){js=d.createElement(s);js.id=id;js.src="//platform.twitter.com/widgets.js";fjs.parentNode.insertBefore(js,fjs);}}(document,"script","twitter-wjs");</script>

&nbsp;

It is time again for my annual system security tune-up across every device I own or manage.  For the OSX based systems, I found [this](https://github.com/drduh/OS-X-Security-and-Privacy-Guide) guide to be very helpful.  Here are the high-points:

  * VPN -> [CyberGhost](http://www.cyberghostvpn.com)

  * Browser -> [Firefox](https://www.mozilla.org/en-US/firefox/new/).  More on this later as I tweaked it out pretty hard.

  * DNS -> [DNSCrypt](https://github.com/alterstep/dnscrypt-osxclient)

  * Full disk encryption, turn it on

  * Install hosts file level blocking, [source](https://github.com/StevenBlack/hosts)

  * Anti-virus -> nope, nope, nope.

  * Instant messaging -> Adium w/OTR &

  * Password manager -> [Pass](https://www.passwordstore.org/)

  * Backups -> [Arq Backup](https://www.arqbackup.com/) with encryption

There are many good settings in the first mentioned article that you should consider applying.  I have tweaked my setup with them and have only covered the high points here. 
