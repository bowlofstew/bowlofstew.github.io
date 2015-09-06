---
layout: post
title: "Dockerizing Phabricator for code reviews"
comments: true
permalink: dockerizing-phabricator
layout: post
tags: [docker, phabricator]
---

<div>
<!-- <a href="https://twitter.com/share" class="twitter-share-button" data-via="__shenderson__">Tweet</a> -->
 
<a href="https://twitter.com/__shenderson__" class="twitter-follow-button" data-show-count="false">Follow @__shenderson__</a>
<script>!function(d,s,id){var js,fjs=d.getElementsByTagName(s)[0],p=/^http:/.test(d.location)?'http':'https';if(!d.getElementById(id)){js=d.createElement(s);js.id=id;js.src=p+'://platform.twitter.com/widgets.js';fjs.parentNode.insertBefore(js,fjs);}}(document, 'script', 'twitter-wjs');</script>
 
 </div>

<!-- Put this just before the closing body tag -->
<script>!function(d,s,id){var js,fjs=d.getElementsByTagName(s)[0];if(!d.getElementById(id)){js=d.createElement(s);js.id=id;js.src="//platform.twitter.com/widgets.js";fjs.parentNode.insertBefore(js,fjs);}}(document,"script","twitter-wjs");</script>

At work, we have been using Github for reviews.  I along with several co-workers have found it painful for many reasons such as the lack of ability to open discrete issues on a request or multi-line comments.  Other code review tools such as ReviewBoard and Phabricator allow for these and other items.  We can easily spin an instance of Phabricator up in docker using a recipe from [Github] (https://github.com/bowlofstew/docker-phabricator-1).

Simply do the following (assuming you have already installed docker & docker-compose):

  * git clone https://github.com/bowlofstew/docker-phabricator-1.git

  * cd docker-phabricator-1

  * docker-compose up

  * get the IP address for your docker; for example, boot2docker ip on OSX

  * open a web browser and navigate to http://{boot2docker ip from above}:8081

  ![Picture description](/assets/phabricator.png)

Now its time to do some setup work for the basics:

  * After you open Phabricator, go to the top bar and click you see the "+" and "Create New Project".  Create a project to correspond to the code project that you want to review.

  * Next, on the client machine that is going to be submitting the review, install [arcanist] (https://secure.phabricator.com/book/phabricator/article/arcanist/).  As a shortcut on OSX, you can install via:

  ```bash
  bash -c "$(curl -fsSL https://gist.githubusercontent.com/tals/8414170/raw/a7b00372d03b3d7f1fe12c8bcc32420a747b3d6c/install_arcanist.bash)"
  ```

  * Prepare your [arc client] (https://phab.enlightenment.org/w/arcanist/), code and submit your reviews :)
