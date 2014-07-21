---
title: "Solaris Vagrant Packer and the base box"
layout: "post"
permalink: "/2014/02/solaris-vagrant-packer-and-base-box.html"
uuid: "6018867675575931315"
guid: "tag:blogger.com,1999:blog-8745734052417186264.post-6018867675575931315"
date: "2014-02-16 12:06:00"
updated: "2014-02-18 23:30:19"
description: 
blogger:
    siteid: "8745734052417186264"
    postid: "6018867675575931315"
    comments: "0"
categories: [blog, virtualbox, vagrant, Solaris 11, solaris]
tags: [virtualbox, vagrant, Solaris 11, solaris]
author: 
    name: "Alan Chalmers"
    url: "https://plus.google.com/109008868852571463084?rel=author"
    image: "//lh6.googleusercontent.com/-vRVdiWd12ak/AAAAAAAAAAI/AAAAAAAAHKc/wXgK4dFefp8/s512-c/photo.jpg"
---
<div class="separator" style="clear: both; text-align: center;"><a href="http://2.bp.blogspot.com/-12tlyaN7z5w/UwIO3uI8LGI/AAAAAAAACZ8/J6qimnEh3Io/s1600/V.png" imageanchor="1" style="clear: left; float: left; margin-bottom: 1em; margin-right: 1em;"><img borde    r="0" src="http://2.bp.blogspot.com/-12tlyaN7z5w/UwIO3uI8LGI/AAAAAAAACZ8/J6qimnEh3Io/s1600/V.png" height="200" width="164" /></a></div>
If you haven't used [Vagrant](http://www.vagrantup.com/) then go check it out. It's certainly come a long way since the early days and expanded beyond just [VirtualBox](https://www.virtualbox.org/). Targeted early at developers its certainly a tool that has different uses to different folk, as a system admin I find it handy to test and build SOE's, deployment scripts and an assortment of sandbox stuff.

There are countless base box's available on line if your are not inclined/interested in building your own. There is however not a lot of Solaris base boxes about , mostly I'd guess due to distribution restrictions, or lack of demand. I've experimented with [veewee](https://github.com/jedi4ever/veewee) and [bento](https://github.com/opscode/bento) but [packer](http://www.packer.io/) the new kid on the block seems to fit the bill. Since there is no shortage of info on building Linux base boxes I decided if I was going to kick the tires on packer then I'd make it useful and build a Solaris 11 base box.

What you'll need, [VirtualBox](https://www.virtualbox.org/) or VMware Fusion (Workstation) , [Solaris 11.1 image](http://www.oracle.com/technetwork/server-storage/solaris11/downloads/index.html) , I went for the text base installer just because I like to make my life a little more difficult, and [Packer](http://www.packer.io/).

The [Packer](http://www.packer.io/) json config file contains three main parts; builders, provisioners, and post-processors the latter two are optional but used often.

#### The builder

Most obviously this is where the heavy lifting is done. This contains mostly information about what we are building, guest type weather we have VirtualBox or VMware or other , how big the machine is, user name's password etc etc. Note line 10 iso_url refers to a local file location I have download the ISO image too since I can't have a direct URL to the Oracle site. 

```json
{
  "builders": [
    {
      "boot_command": [ boot command goes here]
      "boot_wait": "95s",
      "disk_size": 40960,
      "guest_os_type": "OpenSolaris_64",
      "iso_checksum": "1d0efbffe1b194959c1a3d3c8b8d801411c54278",
      "iso_checksum_type": "sha1",
      "iso_url": "file:///ISO/Oracle/sol-11_1-text-x86.iso",
      "output_directory": "packer-solaris11-virtualbox",
      "shutdown_command": "sudo /usr/sbin/shutdown -g 0 -y -i 5",
      "ssh_password": "1vagrant",
      "ssh_port": 22,
      "ssh_username": "vagrant",
      "type": "virtualbox-iso",
      "vboxmanage": [
        [
          "modifyvm",
          "{{.Name}}",
          "--memory",
          "1024"
        ],
        [
          "modifyvm",
          "{{.Name}}",
          "--cpus",
          "1"
        ]
      ],
      "virtualbox_version_file": ".vbox_version",
      "vm_name": "packer-solaris-11"
    }
}
```

For our Solaris machine the boot command is a little more complex than the average Linux build hence in the above example "boot command goes here". The boot command for Linux is usually just a simple boot and use this kickstart file served from packer's build in http server. The Solaris 11 equivalent would be the boot and use the AI server, well no surprises [Packer](http://www.packer.io/) has no built in AI server.

The boot command for our Solaris example contains all the key strokes required to be sent to the virtual-box console to install and reboot the OS. Note there is no key buffer in the console so the strategically placed wait statements are important. With the vnc connection used in VMware this is a little less important.

{% gist 6219d41bcc08c3e266c0 %}

As root is a role in Solaris 11 you can't login as root , so it is important to ensure the vagrant account can sudo to root without password so our post provisioning can finish hence lines 42-47.

#### The provisioner

Simply put this is where we do some stuff to the machine before we turn it into a base box file. Very simple in this case it is running some shell scripts. One to install the required VirtualBox tools the other some minor adjustments to the build, most notable are to place the standard Vagrant ssh keys into the vagrant user account.

{% gist 0b8e9f8564a94f1164c5 %}

#### The post-processor

Compress and export the image the base box image.

{% gist 6e6fcb7da5c01f03a1c2 %}

#### The wrap up
Once your config file is all done it's a matter of telling packer to go build it, and go and have a coffee or two.

```nix
packer build -only=virtualbox-iso solaris11.json
```
So while I can't share you the resulting base box I can share you the code on how to build your own. Get the [files used from github ](https://github.com/AlanC-au/packer)and enjoy, if there are any fixes just submit them to github. Just a point to remember the wait statements timing worked for me on my moderately busy moderately spec'd Mac Mini, hopefully they will work for you but they made need adjusting.
