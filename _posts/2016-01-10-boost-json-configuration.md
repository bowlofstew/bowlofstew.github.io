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

&nbsp;

This week, I had a need for a simple JSON reader. &nbsp;I have re-used this pattern several times now so I figured that I would share it now.&nbsp;

Header file: JsonConfig.hpp

{% gist d42d3d7bd9814d573acf %}

Source file: JsonConfig.cpp

{% gist ec4c06be2d05c195d87a %}

This file uses the [Boost property tree](http://www.boost.org/doc/libs/1_60_0/doc/html/property_tree.html) object to do the configuration parsing. &nbsp;An example consumer of this code is:

{% gist 5545312b7c21b97eaea5 %}

BOOM, that was easy!

&nbsp;