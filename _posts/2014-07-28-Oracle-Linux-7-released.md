---
title: "Oracle Linux 7 released"
layout: "post"
categories: [ blog ]
tags: [blog, Oracle, Linux, packer]
author: 
    name: "Alan Chalmers"
comments: True
---
<div class="separator" style="clear: left; float: left; margin-bottom: 1em; margin-right: 1em;"><img border="0" src="http://www.oracle.com/us/assets/im07t1-linux-7-2245828.png"  width="150" /></div> 

Oracle Linux 7 was [released this last week](http://www.oracle.com/us/corporate/press/2245947) 2nd of RHEL directives to make a GA release, [CentOS](http://seven.centos.org/2014/07/release-announcement-for-centos-7x86_64/) being the first and [Scientific Linux](https://www.scientificlinux.org/) still to come, currently in alpha.

No real surprises here, now comes with the UEK, `3.8.13-35.3.1.el7uek.x86_64`, kernel as default. If you what to test it out and take it for a spin it's pretty easy to using the my [lunchbox](https://github.com/AlanC-au/lunchbox) set of [packer](http://www.packer.io/) templates files which have been updated to support OEL 7.0.

Features include:

* Btrfs
* XFS 
* Linux Containers (LXC) 
* DTrace
* Ksplice for zero-downtime kernel security updates and bug fixes 
* Unbreakable Enterprise Kernel (UEK) Release 3 
* systemd, a new service and system manager 
* Grub2 as the default boot loader with support for additional firmware types, such as UEFI 
* Support for in-place upgrades from OEL 6.5 to OEL 7 

You will need to download the ISO via the [Oracle Edelivery site](https://edelivery.oracle.com/linux/)