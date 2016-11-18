---
layout: post
title: "Modern C++ compilation - part 2, docker'd"
comments: true
permalink: modern-cpp-docker
layout: post
tags: [cpp, docker, clang, gcc, cmake, ninja]
---
*Dockerize it*
-----

In the last post, we covered creating a modern build environment and since then, I added [Boost](https://github.com/bowlofstew/modern-cpp-docker/commit/824eaadbdd63a5c6bc08a7a78d5b835db378d4b0) and [Google Bazel](https://github.com/bowlofstew/modern-cpp-docker/commit/1a5d35620d10cb5d83818f31fa98944758691c4d) to the image.  Bazel is the open source version of Google's Blaze build system.  It is pretty cool to use so I added it to the docker image to make it easy to use.  Additionally a separate docker image was created that builds a [Hello Blaze](https://github.com/bowlofstew/hello-bazel) project.

  * [Bazel C++ getting started](http://bazel.io/docs/cpp.html)

But what the heck is Bazel?

"Bazel is a build tool, i.e. a tool that will run compilers and tests to assemble your software, similar to Make, Ant, Gradle, Buck, Pants, and Maven."  [Reference](http://bazel.io/faq.html)...more info [here](http://google-engtools.blogspot.com/2011/08/build-in-cloud-how-build-system-works.html)

Run it!

  * git clone git@github.com:bowlofstew/hello-bazel.git

  * cd hello-bazel

  * docker build -t hello-bazel .

  * docker -it hello-bazel

  * cd /project && bazel build //b
