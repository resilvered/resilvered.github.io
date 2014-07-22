---
title: "Running Ansible on Windows"
layout: "post"
permalink: "/2014/04/running-ansible-on-windows.html"
uuid: "4874240834498484597"
guid: "tag:blogger.com,1999:blog-8745734052417186264.post-4874240834498484597"
date: "2014-04-08 06:42:00"
updated: "2014-04-08 06:42:38"
description: 
blogger:
    siteid: "8745734052417186264"
    postid: "4874240834498484597"
    comments: "0"
categories: [ blog, work, windows, ansible, configuration management]
tags: [work, windows, ansible, configuration management]
author: 
    name: "Alan Chalmers"
    url: "https://plus.google.com/109008868852571463084?rel=author"
    image: "//lh6.googleusercontent.com/-vRVdiWd12ak/AAAAAAAAAAI/AAAAAAAAHKc/wXgK4dFefp8/s512-c/photo.jpg"
comments: True
---
<div class="separator" style="clear: both; text-align: center;"><a href="http://4.bp.blogspot.com/-pVUyN4PakG8/U0OXhJXE4lI/AAAAAAAAIE8/tnAYdhmpQXs/s1600/ansible_badge.png" imageanchor="1" style="clear: left; float: left; margin-bottom: 1em; margin-right: 1em;"><img border="0" src="http://4.bp.blogspot.com/-pVUyN4PakG8/U0OXhJXE4lI/AAAAAAAAIE8/tnAYdhmpQXs/s1600/ansible_badge.png" height="150" width="150" /></a></div> Some times you just have to make do with what you have. So I considered this morning why is it as IT professional we are often told what tool we need to use to do our job. I mean does a carpenter get told what type of saw he need to use?

My tool of the trade is a Mac, not because I'm an Apple fan boy ,far from it, but as a functional computer it really does just work. Has access to the tools I need due to it's Unix heritage, and provides and usable graphical interface for the less technical in the family.

It's 2014 and it still astounds me that Windows can't ship with a decent terminal/ command shell and ssh. Plenty of after mark products about but they really are just all flawed in subtlety different ways. My current engagement finds them doing their very best to make my life as hard as possible to achieve any real outcome. I have a bunch of work to do that needs to be repeated across a number of servers, knowing full well I have better chance of being the next flight to the space station than getting Puppet or Chef installed, I've opted for Ansible.

So if like myself you find yourself in a position to need to run some ansible from a Windows PC that you don;t have admin rights on then read on if not then arrivederci.

First up go grab yourself a copy of [cygwin](http://cygwin.com/install.html)

So no admin rights on this box either open cmd and run **setup-x86_64.exe --no-admin** or create a shortcut on the Desktop and add the **\--no-admin** option. Handy as you may need to run this again later for some other installation.

So when you get a chance you are going to need to install the following:

  * wget
  * python
  * python-crypto
  * python-openssl
  * python-setuptools
  * git
  * vim
  * openssh
  * openssl
  * openssl-devel
  * libsasl2
  * ca-certificates

There will be a bunch of dependent packages that are required the install should figure them out and you should accept them.

So pretty good chance you'll be behind a proxy so when you open the cygwin terminal you might want to set this up.

    export http_proxy=http://user:passwd@my.corporate.proxy:80/
    export https_proxy=https://user:passwd@my.corporate.proxy:80/

Probably drop them in your .bash_profile for later use.

Next you going to need PyYAML and Jinja2 for Ansible and these aren't available in the [cygwin](http://cygwin.com/install.html) installer.

Grab PyYAML:

```sh
wget https://pypi.python.org/packages/source/P/PyYAML/PyYAML-3.10.tar.gz
tar -xvf PyYAML-3.10.tar.gz
cd PyYAML-3.10
python setup.py install
cd ..
```

Now grab Jinja2 and rinse repeat:

```sh
wget https://pypi.python.org/packages/source/J/Jinja2/Jinja2-2.6.tar.gz
tar -xvf Jinja2-2.6.tar.gz
cd Jinja2-2.6
python setup.py install
cd ..
```

If you don't already have an ssh key the generate one. I would recommend setting a password and having a key agent installed also, ssh-keygen is what you are looking for

Behind the corporate firewall git will need a hand also.

    git config –global http.proxy $http_proxy

Now you can clone [ansible](http://www.ansible.com/) from [GitHub](https://github.com/): 

    git clone https://github.com/ansible/ansible /opt/ansible

Setup some path stuff , you probably want to drop these in your .bash_profile also

```sh
ANSIBLE=/opt/ansible
export PATH=$PATH:$ANSIBLE/bin
export PYTHONPATH=$ANSIBLE/lib
export ANSIBLE_LIBRARY=$ANSIBLE/library
```
and your ready to rumble, or at least I though I was. Turns out there is an issue with the cygwin openssh and control master so make sure you add this line.

```sh
export ANSIBLE_SSH_ARGS="-o ControlMaster=no"
