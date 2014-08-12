---
title: "Installing HHVM 3.2.0 on CentOS 6.5"
layout: "post"
categories: [ blog ]
tags: [ HHVM, Linux, CentOS, PHP, Hack]
meta-description: "How to install HHVM on Centos 6.5 from binary rpms"
author: 
    name: "Alan Chalmers"
comments: True
---
<img src="/assets/images/hhvm.jpeg" width="100%" height="100">
[HHVM] is a virtual machine for Hack and PHP it uses JIT to improve performance. Installation on a less than bleeding edge OS can prove a little challenging. What follows is what I did to get it up and going quickly for our developers in our CentOS 6.5 environment. It may work for you too.

Packages were sourced from two repo's http://yum.gleez.com/ and http://remi.conetix.com.au/

Things boiled down to these 11 packages that were signed and added to our local yum repo:

    boost-filesystem-1.54.0-9.el6.x86_64.rpm
    boost-program-options-1.54.0-9.el6.x86_64.rpm
    boost-regex-1.54.0-9.el6.x86_64.rpm
    boost-system-1.54.0-9.el6.x86_64.rpm
    boost-thread-1.54.0-9.el6.x86_64.rpm
    compat-mysql55-5.5.38-1.el6.remi.x86_64.rpm
    hhvm-3.2.0-10.el6.x86_64.rpm
    libbson-0.6.6-1.el6.x86_64.rpm
    libstdc++48-4.8.2-10.el6.x86_64.rpm
    libwebp-0.3.1-2.el6.remi.x86_64.rpm
    tbb-4.1-2.20130116.el6.x86_64.rpm

The only "*gotcha*" was the fact we have postfix installed and it was looking to use mysql-libs and [HHVM] wanted mysql55-libs to resolve some of it's dependencies. This created some incompatibilities with postfix.

The issue was resolved using compat-mysql55, while there are a few places to find that rpm the only one contained libmysqlclient.so.18.0.0 version of the library that was needed was the [Remi] site.

If you have mysql55-libs available in your repos then you will need to install the compact library first

    yum install compat-mysql55
    yum install hhvm

If you don't then you can go right ahead

    yum install hhvm

For more info take a look at:

- https://github.com/facebook/hhvm/issues/3360
- https://github.com/facebook/hhvm/wiki/Prebuilt-Packages-on-Centos-6.x 


[HHVM]:https://github.com/facebook/hhvm/
[Remi]:http://remi.conetix.com.au/
