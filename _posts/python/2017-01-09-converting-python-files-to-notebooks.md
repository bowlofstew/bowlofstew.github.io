---
layout: post
title: "Converting Python files to notebooks"
permalink: python-file-to-notebooks
layout: post
tags: [python, notebooks]
categories: python
---
*Python Notebooks?*
-----

I commonly get requests from end users to convert quantitative models 
into [Python Notebooks](https://ipython.org/notebook.html) for others 
to perform testing on.  This become tedious so here is a brief script to 
perform the operation:

{% gist 7af8084a3065f321368c49717901373e %}

This script relies on the `nbformat` library.  You can install this with 
the following command in your terminal (pip required):

```
pip install nbformat
```