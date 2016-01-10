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

This week, I had a need for a simple JSON reader. &nbsp;I have re-used this pattern several times now so I figured that I would share it now.&nbsp;

Header file:

&nbsp;