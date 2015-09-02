---
layout: post
title: "Building Thrift and Scribe with docker"
comments: true
permalink: dockerizing-thrift-docker
layout: post
tags: [scribe, cpp, thrift, docker]
---

<div>
<!-- <a href="https://twitter.com/share" class="twitter-share-button" data-via="__shenderson__">Tweet</a> -->
 
<a href="https://twitter.com/__shenderson__" class="twitter-follow-button" data-show-count="false">Follow @__shenderson__</a>
<script>!function(d,s,id){var js,fjs=d.getElementsByTagName(s)[0],p=/^http:/.test(d.location)?'http':'https';if(!d.getElementById(id)){js=d.createElement(s);js.id=id;js.src=p+'://platform.twitter.com/widgets.js';fjs.parentNode.insertBefore(js,fjs);}}(document, 'script', 'twitter-wjs');</script>
 
 </div>

<!-- Put this just before the closing body tag -->
<script>!function(d,s,id){var js,fjs=d.getElementsByTagName(s)[0];if(!d.getElementById(id)){js=d.createElement(s);js.id=id;js.src="//platform.twitter.com/widgets.js";fjs.parentNode.insertBefore(js,fjs);}}(document,"script","twitter-wjs");</script>

I recently read an article about how Dropbox rewrote a product called [Scribe] (https://blogs.dropbox.com/tech/2015/05/how-to-write-a-better-scribe/).  Facebook open sourced the [software](https://github.com/facebookarchive/scribe).  This was during the era when Facebook open sourced projects then let them die on GitHub hence the facebookarchive account used in GitHub.  There is some rumor that they still use it though.  It appears that Dropbox liked the design enough to rewrite a large chunk of it though.

So what is Scribe?  Directly from the horses's [mouth](https://www.facebook.com/notes/facebook-engineering/facebooks-scribe-technology-now-open-source/32008268919).

```
Here at Facebook, we're constantly facing scaling challanges because of our enormous growth. One particular problem we encountered a couple of years ago was collection of data from our servers. We were collecting a few billion messages a day (which seemed like a lot at the time) for everything from access logs to performance statistics to actions that went to News Feed. We used a variety of different technologies for the different use cases, and all of them were bursting at the seams. We decided to build a unified system (called Scribe) to handle all of these cases, and do it in a way that would scale with Facebook's growth. The system we built turned out to be enormously useful, handling over 100 use cases and tens of billions of messages a day.
```

After I read the Dropbox article, I read the requirements for building this software from the graveyard.

  * libevent

  * boost

  * thrift

  * fb303, included in Thrift

  * optional - hadoop

Thinking about it, I wondered how bad will it fail in compilation given the newest version of boost, thrift, a modern compiler, and a newer version of Ubuntu?  Since I run on OSX as my primary, let's docker it up....what could possibly go wrong?

First up, I created a base image to build thrift from using a modern-cpp base image that I had created for another project.  The modern-cpp base image contains modern cpp compilers, make systems, and the newest version of boost.  This image then pulls down thrift 0.9.2 tag, compiles it, then installs it.  After that, I pushed this tag to the docker hub.  Next, I created a second docker image that inherits the thrift image, pulls down the scribe source from the Facebook graveyard, then compiles it.  Unsurprisinly, it blew up! I'm going to fork the Scribe repo, update to a modern build system (probably CMake), fix any other issues, and docker-fy the build.  

I have published all the revelent code in Github and the Docker Hub so here ya go!

  * [scribe docker ode] (https://github.com/bowlofstew/docker-scribe)

  * [thrift docker code] (https://github.com/bowlofstew/docker-thrift)

  * [scribe docker image] (https://hub.docker.com/r/bowlofstew/thrift/)

  * [thrift docker image] (https://hub.docker.com/r/bowlofstew/scribe/)

  If you have `docker` installed, you can merely do a `docker pull bowlofstew/thrift` or `docker pull bowlofstew/scribe` to get the images from the Docker Hub.