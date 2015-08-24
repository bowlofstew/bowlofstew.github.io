---
layout: post
title: "Modern C++ compilation, docker'd"
comments: true
permalink: modern-cpp-docker
layout: post
tags: [cpp, docker, clang, gcc, cmake, ninja]
---
*Dockerize it*
-----

<div>
<!-- <a href="https://twitter.com/share" class="twitter-share-button" data-via="__shenderson__">Tweet</a> -->
 
<a href="https://twitter.com/__shenderson__" class="twitter-follow-button" data-show-count="false">Follow @__shenderson__</a>
<script>!function(d,s,id){var js,fjs=d.getElementsByTagName(s)[0],p=/^http:/.test(d.location)?'http':'https';if(!d.getElementById(id)){js=d.createElement(s);js.id=id;js.src=p+'://platform.twitter.com/widgets.js';fjs.parentNode.insertBefore(js,fjs);}}(document, 'script', 'twitter-wjs');</script>
 
 </div>

<!-- Put this just before the closing body tag -->
<script>!function(d,s,id){var js,fjs=d.getElementsByTagName(s)[0];if(!d.getElementById(id)){js=d.createElement(s);js.id=id;js.src="//platform.twitter.com/widgets.js";fjs.parentNode.insertBefore(js,fjs);}}(document,"script","twitter-wjs");</script>

Having a dedicated build environment is great but hard to come by...or is it?  This week, I put together a docker file to create a 
pristine compilation environment for C/C++ projects.  I have pushed the source code to [github] (https://github.com/bowlofstew/modern-cpp-docker) and the image to the [docker registry] (https://registry.hub.docker.com/u/bowlofstew/modern-cpp).

Need docker on your machine?

  * [Ubuntu Trusty] (http://buildvirtual.net/docker-installing-docker-on-ubuntu-trusty-14-04/)

  * [Redhat] (http://www.itzgeek.com/how-tos/linux/centos-how-tos/installing-docker-on-centos-7-rhel-7-fedora-21.html#axzz3htx4zKNM)

  * [OSX] (https://docs.docker.com/installation/mac/)

  * [Windows] (https://docs.docker.com/installation/windows/)

Once you install Docker, fire up a terminal and execute `docker pull bowlofstew/modern-cpp`.  This will pull the image from the Docker registry to your local host.  Afterwards, you can execute `docker run -it bowlofstew/modern-cpp`. That will start the docker container and
provide you with a command prompt.  Inside this container, you get:

  * git

  * cmake

  * ninja

  * scons

  * g++ 4.9

  * clang 3.4

Next post, I'll show you how to create an inherited image that adds in a local source directory, vim with plugins, and private key to commit from your container.