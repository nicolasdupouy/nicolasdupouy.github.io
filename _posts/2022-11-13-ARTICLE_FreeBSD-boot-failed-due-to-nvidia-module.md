---
layout:             post
title:              "[FreeBSD] boot failed due to nvidia module"
type:               "ARTICLE"
date-publication:   2022-11-13 21:00:00 +0200
categories:         FreeBSD BSD kernel hardware terminal boot nvidia
permalink:          /2022-11-13-FreeBSD-boot-failed-due-to-nvidia-module/
toc: true
---

**Table of Contents**
* TOC
{:toc}

<BR>

## Brief
I recently bought a new computer and installed [FreeBSD][FreeBSD] on it. But it didn't go so well with the Nvidia module.

## Hardware
As I already had a graphic card with an Nvidia chip on my previous computer, which also runned on FreeBSD. I decided to buy this [one](https://www.amazon.fr/gp/product/B096Y2TYKV/ref=ppx_yo_dt_b_asin_title_o02_s00?ie=UTF8&psc=1): 
![Graphic card](/assets/2022-11-13-FreeBSD-boot-failed-due-to-nvidia-module/Gigabyte-Nvidia-GeForce-RTX-3060.jpg)
One of the big pluses of this card is that it has 4 video outputs. Which suits me perfectly to connect my three screens (there's no point in skimping !).

Here is my card diagnostic:
```shell
> pciconf -lv | grep -B3 display
vgapci0@pci0:7:0:0:	class=0x030000 rev=0xa1 hdr=0x00 vendor=0x10de device=0x2504 subvendor=0x1458 subdevice=0x4074
    vendor     = 'NVIDIA Corporation'
    device     = 'GA106 [GeForce RTX 3060 Lite Hash Rate]'
    class      = display
```

## Installation
After the installation of the base system, I quickly installed `Xorg` and the Nvidia drivers:

```shell
pkg add xorg
pkg add nvidia-driver
```

## Stupidity, Setup & Problem

The issue is that I wanted so bad a graphic interface that I immediately change my `/boot/loader.conf` to add:
```text
nvidia_load="YES"
nvidia-modeset_load="YES"
```

I restarted [FreeBSD][FreeBSD] and saw this:

```text
Loading kernel...
/boot/kernel/kernel text=0x189e58 text=0xe16108 text=0x6bb35c data=0x140 data=0x1bc
Loading configured modules...
/boot/modules/nvidia.ko size 0x2b624f8 at 0x2353000
loading required module 'linux_common'
/boot/modules/linux_common.ko size 0x1cc10 at 0x4eb6000
loading required module 'linux'
/boot/modules/linux.ko size 0x677b8 at 0x4ed3000
loading required module 'kernel'
module 'kernel' exists but with wrong version
```

![problem](/assets/2022-11-13-FreeBSD-boot-failed-due-to-nvidia-module/1-problem.png)

It would have been smarter to use [kldload][kldload] instead but it was too late !


## Fix

To repair, I choose the option **"3. Escape to loader prompt"** at the startup.
You can see it displayed before the error in the previous picture.

And I created a `module_blacklist` variable with the two modules I wanted to remove from the loading phase:

```shell
set module_blacklist="nvidia nvidia-modeset"
```

![resolution](/assets/2022-11-13-FreeBSD-boot-failed-due-to-nvidia-module/2-resolution.png)

To be sure of the name I needed I used the command `help` to display the available commands in this loader prompt and `more` to look at the content of the `/boot/loader.conf`:

```shell
help

more /boot/loader.conf 
```

After this little changes, I just had to type `boot` and start over.
In fact, my install with `pkg` was not ok, so I just had to remove it and re-installed with the [ports](https://www.freebsd.org/ports/).

## Credits

To solve this issue, I found help [here][freebsd_forums_help] in the FreeBSD forums. Thanks for the tip [mcochris](https://forums.freebsd.org/members/mcochris.34558/).

[FreeBSD]: https://www.freebsd.org/
[kldload]: https://www.freebsd.org/cgi/man.cgi?kldload(8)
[freebsd_forums_help]: https://forums.freebsd.org/threads/how-to-boot-with-messed-up-boot-loader-conf.64019/
