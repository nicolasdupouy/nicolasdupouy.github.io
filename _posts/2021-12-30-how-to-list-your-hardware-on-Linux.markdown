---
layout:             post
title:              "How to list your hardware on Linux"
date-publication:   2021-12-30 10:00:00 +0200
categories:         gnu linux hardware terminal command line lsblk blkid lshw
permalink:          /2021-12-30-how-to-list-your-hardware-on-Linux/
toc: true
---

**Table of Contents**
* TOC
{:toc}

<BR>




## Zoom on disks
### `lsblk`

If you want to inspect your available disks, a good start is the `lsblk` command (as they are block devices).

{% highlight conf %}
❯ lsblk
NAME   MAJ:MIN RM   SIZE RO TYPE MOUNTPOINT
sda      8:0    0 232.9G  0 disk
|-sda3   8:3    0    32G  0 part /
|-sda4   8:4    0     1K  0 part
|-sda5   8:5    0   7.9G  0 part [SWAP]
`-sda6   8:6    0   380M  0 part
sdb      8:16   0 465.8G  0 disk
|-sdb1   8:17   0 260.8G  0 part /opt
`-sdb2   8:18   0   205G  0 part /home
sdc      8:32   0   3.6T  0 disk
`-sdc1   8:33   0   3.6T  0 part /mnt/4To
sr0     11:0    1  1024M  0 rom
{% endhighlight %}

This command is often used with the `--fs` option as it provides more information like the filesystem types, the percentage of disk used and the percentage of disk available.

{% highlight conf %}
❯ lsblk --fs
NAME   FSTYPE FSVER LABEL          UUID                                 FSAVAIL FSUSE% MOUNTPOINT
sda
|-sda3 ext4   1.0                  45241cf1-4fe9-4357-b752-76d11945eaa2    6.6G    74% /
|-sda4
|-sda5 swap   1                    58e2c542-dd60-41f5-b126-8edebbb58914                [SWAP]
`-sda6 ext4   1.0                  bc936528-0e1d-4570-bbfe-d08a8dcee118
sdb
|-sdb1 ext4   1.0                  66c37c68-da96-4b71-b17d-5cbe49c9f66c  172.7G    27% /opt
`-sdb2 ext4   1.0                  9d92cbcd-7108-47c6-9ae1-044e345ffa6a   96.1G    47% /home
sdc
`-sdc1 ext4   1.0   data-partition 68f066c6-181c-4be0-b2f6-af927705cf8a    2.1T    37% /mnt/4To
sr0
{% endhighlight %}

It gives in particular the UUID of your partitions which is useful if you want to use them in your file system table `/etc/fstab`.

As you can see on my own :
![/etc/fstab][/etc/fstab]

### `blkid`

NB: The partition UUID can also be find with the `blkid` command:

{% highlight conf %}
❯ sudo blkid
/dev/sdb1: UUID="66c37c68-da96-4b71-b17d-5cbe49c9f66c" BLOCK_SIZE="4096" TYPE="ext4" PARTUUID="fb2fdeb1-5f58-6e42-88c4-829b5b2ab449"
/dev/sdb2: UUID="9d92cbcd-7108-47c6-9ae1-044e345ffa6a" BLOCK_SIZE="4096" TYPE="ext4" PARTUUID="141b9423-d3ba-4b49-bbf7-e2779e5553ee"
/dev/sda3: UUID="45241cf1-4fe9-4357-b752-76d11945eaa2" BLOCK_SIZE="4096" TYPE="ext4" PARTUUID="89a6622e-03"
/dev/sda5: UUID="58e2c542-dd60-41f5-b126-8edebbb58914" TYPE="swap" PARTUUID="89a6622e-05"
/dev/sda6: UUID="bc936528-0e1d-4570-bbfe-d08a8dcee118" BLOCK_SIZE="1024" TYPE="ext4" PARTUUID="89a6622e-06"
/dev/sdc1: LABEL="data-partition" UUID="68f066c6-181c-4be0-b2f6-af927705cf8a" BLOCK_SIZE="4096" TYPE="ext4" PARTLABEL="primary" PARTUUID="6e57131a-17c4-4191-8e5d-e905acb5a019"
{% endhighlight %}

Other commands exists. Let's discover some of it.

### `findmnt`

`findmnt` will list all mounted filesystems.

{% highlight conf %}
❯ findmnt
TARGET                         SOURCE      FSTYPE      OPTIONS
/                              /dev/sda3   ext4        rw,relatime,errors=remount-ro
├─/sys                         sysfs       sysfs       rw,nosuid,nodev,noexec,relatime
│ ├─/sys/kernel/security       securityfs  securityfs  rw,nosuid,nodev,noexec,relatime
│ ├─/sys/fs/cgroup             cgroup2     cgroup2     rw,nosuid,nodev,noexec,relatime,nsdelegate,memory_recursiveprot
│ ├─/sys/fs/pstore             pstore      pstore      rw,nosuid,nodev,noexec,relatime
│ ├─/sys/fs/bpf                none        bpf         rw,nosuid,nodev,noexec,relatime,mode=700
│ ├─/sys/kernel/debug          debugfs     debugfs     rw,nosuid,nodev,noexec,relatime
│ ├─/sys/kernel/tracing        tracefs     tracefs     rw,nosuid,nodev,noexec,relatime
│ ├─/sys/kernel/config         configfs    configfs    rw,nosuid,nodev,noexec,relatime
│ └─/sys/fs/fuse/connections   fusectl     fusectl     rw,nosuid,nodev,noexec,relatime
├─/proc                        proc        proc        rw,nosuid,nodev,noexec,relatime
│ └─/proc/sys/fs/binfmt_misc   systemd-1   autofs      rw,relatime,fd=29,pgrp=1,timeout=0,minproto=5,maxproto=5,direct,pipe_ino=13551
│   └─/proc/sys/fs/binfmt_misc binfmt_misc binfmt_misc rw,nosuid,nodev,noexec,relatime
├─/dev                         udev        devtmpfs    rw,nosuid,relatime,size=10203524k,nr_inodes=2550881,mode=755
│ ├─/dev/pts                   devpts      devpts      rw,nosuid,noexec,relatime,gid=5,mode=620,ptmxmode=000
│ ├─/dev/shm                   tmpfs       tmpfs       rw,nosuid,nodev
│ ├─/dev/hugepages             hugetlbfs   hugetlbfs   rw,relatime,pagesize=2M
│ └─/dev/mqueue                mqueue      mqueue      rw,nosuid,nodev,noexec,relatime
├─/run                         tmpfs       tmpfs       rw,nosuid,nodev,noexec,relatime,size=2047848k,mode=755
│ ├─/run/lock                  tmpfs       tmpfs       rw,nosuid,nodev,noexec,relatime,size=5120k
│ └─/run/user/1000             tmpfs       tmpfs       rw,nosuid,nodev,relatime,size=2047844k,nr_inodes=511961,mode=700,uid=1000,gid=1000
│   └─/run/user/1000/doc       portal      fuse.portal rw,nosuid,nodev,relatime,user_id=1000,group_id=1000
├─/home                        /dev/sdb2   ext4        rw,relatime
├─/opt                         /dev/sdb1   ext4        rw,relatime
└─/mnt/4To                     /dev/sdc1   ext4        rw,relatime
{% endhighlight %}

As you can see, it is not limited to the physical disks.
To stick a bit more to what we were looking at with the previous command, we could filter on a filesystem type.

{% highlight conf %}
❯ findmnt -t ext4
TARGET     SOURCE    FSTYPE OPTIONS
/          /dev/sda3 ext4   rw,relatime,errors=remount-ro
├─/home    /dev/sdb2 ext4   rw,relatime
├─/opt     /dev/sdb1 ext4   rw,relatime
└─/mnt/4To /dev/sdc1 ext4   rw,relatime
{% endhighlight %}

Or ask for a straight list.

{% highlight conf %}
❯ findmnt -t ext4 -l
TARGET   SOURCE    FSTYPE OPTIONS
/        /dev/sda3 ext4   rw,relatime,errors=remount-ro
/home    /dev/sdb2 ext4   rw,relatime
/opt     /dev/sdb1 ext4   rw,relatime
/mnt/4To /dev/sdc1 ext4   rw,relatime
{% endhighlight %}


### `hwinfo`

`hwinfo` focus on the hardware, not how it is used. For example, you won't have information on the partitions presents on your disks.
For info, it is by default not installed on my Debian base system. And may not be installed with your distribution.

So first, install it:

{% highlight console %}
❯ sudo apt-get install hwinfo
{% endhighlight %}

Like `lshw` that we will see later, the output of this command is verbose. I mean really verbose !
For the sake of the readability, I will focus on the disks output with the `--disk` option.

{% highlight conf %}
❯ sudo hwinfo --disk
25: IDE 201.0: 10600 Disk
[Created at block.245]
Unique ID: WZeP.58v_ZBYayE1
Parent ID: w7Y8.0iikP2qMHRD
SysFS ID: /class/block/sdb
SysFS BusID: 2:0:1:0
SysFS Device Link: /devices/pci0000:00/0000:00:1f.2/ata3/host2/target2:0:1/2:0:1:0
Hardware Class: disk
Model: "Samsung SSD 860"
Vendor: "Samsung"
Device: "SSD 860"
Revision: "1B6Q"
Serial ID: "S3Z2NB0K938341W"
Driver: "ata_piix", "sd"
Driver Modules: "ata_piix", "sd_mod"
Device File: /dev/sdb
Device Number: block 8:16-8:31
Geometry (Logical): CHS 60801/255/63
Size: 976773168 sectors a 512 bytes
Capacity: 465 GB (500107862016 bytes)
Config Status: cfg=new, avail=yes, need=no, active=unknown
Attached to: #2 (IDE interface)

26: IDE 400.0: 10600 Disk
[Created at block.245]
Unique ID: _kuT.ik+ULzuWpw8
Parent ID: W60f._7e2gtd+2K9
SysFS ID: /class/block/sdc
SysFS BusID: 4:0:0:0
SysFS Device Link: /devices/pci0000:00/0000:00:1f.5/ata5/host4/target4:0:0/4:0:0:0
Hardware Class: disk
Model: "ST4000DM004-2CV1"
Device: "ST4000DM004-2CV1"
Revision: "0001"
Serial ID: "WFN0DNST"
Driver: "ata_piix", "sd"
Driver Modules: "ata_piix", "sd_mod"
Device File: /dev/sdc
Device Number: block 8:32-8:47
Geometry (Logical): CHS 486401/255/63
Size: 7814037168 sectors a 512 bytes
Capacity: 3726 GB (4000787030016 bytes)
Config Status: cfg=new, avail=yes, need=no, active=unknown
Attached to: #13 (IDE interface)

27: IDE 200.0: 10600 Disk
[Created at block.245]
Unique ID: 3OOL.2CfeXKYl9DC
Parent ID: w7Y8.0iikP2qMHRD
SysFS ID: /class/block/sda
SysFS BusID: 2:0:0:0
SysFS Device Link: /devices/pci0000:00/0000:00:1f.2/ata3/host2/target2:0:0/2:0:0:0
Hardware Class: disk
Model: "Samsung SSD 840"
Vendor: "Samsung"
Device: "SSD 840"
Revision: "BB6Q"
Serial ID: "S1DBNSBF775887Z"
Driver: "ata_piix", "sd"
Driver Modules: "ata_piix", "sd_mod"
Device File: /dev/sda
Device Number: block 8:0-8:15
Geometry (Logical): CHS 30401/255/63
Size: 488397168 sectors a 512 bytes
Capacity: 232 GB (250059350016 bytes)
Config Status: cfg=new, avail=yes, need=no, active=unknown
Attached to: #2 (IDE interface)
{% endhighlight %}

Or even more concise:
{% highlight conf %}
❯ sudo hwinfo --disk --short
disk:
/dev/sdb             Samsung SSD 860
/dev/sdc             ST4000DM004-2CV1
/dev/sda             Samsung SSD 840
{% endhighlight %}



### `df`
A widely used command to report file system disk space usage on your partitions is `df`. You will get the *devices*, what are their *mount points*, the *sizes*, etc.
The issue here is that only the mounted partitions will be displayed.

To get a human readable output, use the `-h` option.
{% highlight conf %}
❯ df -h
Filesystem      Size  Used Avail Use% Mounted on
udev            9.8G     0  9.8G   0% /dev
tmpfs           2.0G  3.0M  2.0G   1% /run
/dev/sda3        32G   24G  6.6G  78% /
tmpfs           9.8G  157M  9.7G   2% /dev/shm
tmpfs           5.0M  4.0K  5.0M   1% /run/lock
/dev/sdb2       201G   95G   96G  50% /home
/dev/sdb1       256G   70G  173G  29% /opt
/dev/sdc1       3.6T  1.4T  2.1T  39% /mnt/4To
tmpfs           2.0G  128K  2.0G   1% /run/user/100
{% endhighlight %}

It won't focus on the *real* physical disk partitions. This is why in my case it display *tmpfs* type partitions.


### Other commands

You can also analyse your disks with command line programs to manipulate disk partitions like `fdisk`, `cfdisk` or `parted` but we won't cover it.

Of course, there is also the GUI programs like `gnome-disks` (*"Disks"* in the application list) and `gnome-system-monitor` (*"System Monitor"* in the application list -tab *"File Systems"*-). but we won't cover it either.

## Hardware general overview
To have a more general overview, the `lshw` command can extract detailed information on the hardware configuration of the machine.
this command should be run as root if you want to have a complete overview on your hardware.

<u>Two options are particularly interesting:</u>
1. `-short` to have a quick overview
2. `-class A_CLASS` to filter on a specific class of device.

{% highlight conf %}
❯ sudo lshw -short
H/W path               Device           Class          Description
==================================================================
system         System Product Name (SKU)
/0                                      bus            P8H67
/0/0                                    memory         64KiB BIOS
/0/4                                    processor      Intel(R) Core(TM) i5-2500K CPU @ 3.30GHz
/0/4/5                                  memory         256KiB L1 cache
/0/4/6                                  memory         1MiB L2 cache
/0/4/7                                  memory         6MiB L3 cache
/0/2a                                   memory         20GiB System Memory
/0/2a/0                                 memory         2GiB DIMM DDR3 Synchronous 1333 MHz (0.8 ns)
/0/2a/1                                 memory         8GiB DIMM DDR3 Synchronous 1333 MHz (0.8 ns)
/0/2a/2                                 memory         2GiB DIMM DDR3 Synchronous 1333 MHz (0.8 ns)
/0/2a/3                                 memory         8GiB DIMM DDR3 Synchronous 1333 MHz (0.8 ns)
/0/100                                  bridge         2nd Generation Core Processor Family DRAM Controller
/0/100/1                                bridge         Xeon E3-1200/2nd Generation Core Processor Family PCI Express Root Port
/0/100/1/0                              display        GP108 [GeForce GT 1030]
/0/100/1/0.1                            multimedia     GP108 High Definition Audio Controller
/0/100/16                               communication  6 Series/C200 Series Chipset Family MEI Controller #1
/0/100/1a                               bus            6 Series/C200 Series Chipset Family USB Enhanced Host Controller #2
/0/100/1a/1            usb1             bus            EHCI Host Controller
/0/100/1a/1/1                           bus            Integrated Rate Matching Hub
/0/100/1a/1/1/3                         generic        BCM20702A0
/0/100/1b                               multimedia     6 Series/C200 Series Chipset Family High Definition Audio Controller
/0/100/1c                               bridge         6 Series/C200 Series Chipset Family PCI Express Root Port 1
/0/100/1c.2                             bridge         6 Series/C200 Series Chipset Family PCI Express Root Port 3
/0/100/1c.3                             bridge         6 Series/C200 Series Chipset Family PCI Express Root Port 4
/0/100/1c.4                             bridge         82801 PCI Bridge
/0/100/1c.4/0                           bridge         ASM1083/1085 PCIe to PCI Bridge
/0/100/1c.5                             bridge         6 Series/C200 Series Chipset Family PCI Express Root Port 6
/0/100/1c.5/0                           storage        VT6415 PATA IDE Host Controller
/0/100/1c.6                             bridge         6 Series/C200 Series Chipset Family PCI Express Root Port 7
/0/100/1c.6/0          enp8s0           network        RTL8111/8168/8411 PCI Express Gigabit Ethernet Controller
/0/100/1c.7                             bridge         6 Series/C200 Series Chipset Family PCI Express Root Port 8
/0/100/1c.7/0                           bus            ASM1042 SuperSpeed USB Host Controller
/0/100/1c.7/0/0        usb2             bus            xHCI Host Controller
/0/100/1c.7/0/1        usb3             bus            xHCI Host Controller
/0/100/1d                               bus            6 Series/C200 Series Chipset Family USB Enhanced Host Controller #1
/0/100/1d/1            usb4             bus            EHCI Host Controller
/0/100/1d/1/1                           bus            Integrated Rate Matching Hub
/0/100/1d/1/1/2                         generic        EPSON Scanner
/0/100/1d/1/1/4                         bus            USB hub
/0/100/1d/1/1/4/5                       input          Human interface device
/0/100/1d/1/1/4/6                       generic        Generic USB device
/0/100/1d/1/1/5                         bus            USB hub
/0/100/1d/1/1/5/1                       bus            USB hub
/0/100/1d/1/1/5/3                       input          Ducky One2 Mini RGB
/0/100/1d/1/1/5/4                       input          Razer Mamba Charging Dock
/0/100/1d/1/1/6                         bus            USB2.0 Hub
/0/100/1f                               bridge         H67 Express Chipset LPC Controller
/0/100/1f.2            scsi2            storage        6 Series/C200 Series Chipset Family Desktop SATA Controller (IDE mode, ports 0-3)
/0/100/1f.2/0.0.0      /dev/sda         disk           250GB Samsung SSD 840
/0/100/1f.2/0.0.0/3    /dev/sda3        volume         31GiB EXT4 volume
/0/100/1f.2/0.0.0/4    /dev/sda4        volume         107GiB Extended partition
/0/100/1f.2/0.0.0/4/5  /dev/sda5        volume         8105MiB Linux swap volume
/0/100/1f.2/0.0.0/4/6  /dev/sda6        volume         380MiB EXT4 volume
/0/100/1f.2/0.1.0      /dev/sdb         disk           500GB Samsung SSD 860
/0/100/1f.2/0.1.0/1    /dev/sdb1        volume         260GiB EXT4 volume
/0/100/1f.2/0.1.0/2    /dev/sdb2        volume         204GiB EXT4 volume
/0/100/1f.3                             bus            6 Series/C200 Series Chipset Family SMBus Controller
/0/100/1f.5            scsi4            storage        6 Series/C200 Series Chipset Family Desktop SATA Controller (IDE mode, ports 4-5)
/0/100/1f.5/0          /dev/sdc         disk           4TB ST4000DM004-2CV1
/0/100/1f.5/0/1        /dev/sdc1        volume         3726GiB EXT4 volume
/0/100/1f.5/1          /dev/cdrom       disk           DVDR   PX-880SA
/0/1                                    system         PnP device PNP0c01
/0/2                                    system         PnP device PNP0c02
/0/3                                    system         PnP device PNP0b00
/0/5                                    system         PnP device PNP0c02
/0/6                                    system         PnP device PNP0c01
/0/7                                    generic        PnP device INT3f0d
/1                                      power          To Be Filled By O.E.M.
/2                                      power          To Be Filled By O.E.M.
/3                     docker0          network        Ethernet interface
/4                     br-c76cfd04d359  network        Ethernet interface
{% endhighlight %}

The class name can be found in the previous output.

{% highlight conf %}
❯ sudo lshw -class disk
*-disk:0
    description: ATA Disk
    product: Samsung SSD 840
    physical id: 0.0.0
    bus info: scsi@2:0.0.0
    logical name: /dev/sda
    version: BB6Q
    serial: S1DBNSBF775887Z
    size: 232GiB (250GB)
    capabilities: partitioned partitioned:dos
    configuration: ansiversion=5 logicalsectorsize=512 sectorsize=512 signature=89a6622e
*-disk:1
    description: ATA Disk
    product: Samsung SSD 860
    physical id: 0.1.0
    bus info: scsi@2:0.1.0
    logical name: /dev/sdb
    version: 1B6Q
    serial: S3Z2NB0K938341W
    size: 465GiB (500GB)
    capabilities: gpt-1.00 partitioned partitioned:gpt
    configuration: ansiversion=5 guid=d40f19f8-6772-4054-a57a-9b3c8469ab00 logicalsectorsize=512 sectorsize=512
*-disk
    description: ATA Disk
    product: ST4000DM004-2CV1
    physical id: 0
    bus info: scsi@4:0.0.0
    logical name: /dev/sdc
    version: 0001
    serial: WFN0DNST
    size: 3726GiB (4TB)
    capabilities: gpt-1.00 partitioned partitioned:gpt
    configuration: ansiversion=5 guid=b43fd6a8-e22a-4d68-9a97-31f95e01c988 logicalsectorsize=512 sectorsize=4096
*-cdrom
    description: DVD-RAM writer
    product: DVDR   PX-880SA
    vendor: PLEXTOR
    physical id: 1
    bus info: scsi@5:0.0.0
    logical name: /dev/cdrom
    logical name: /dev/cdrw
    logical name: /dev/dvd
    logical name: /dev/dvdrw
    logical name: /dev/sr0
    version: 1.12
    capabilities: removable audio cd-r cd-rw dvd dvd-r dvd-ram
    configuration: ansiversion=5 status=nodisc
{% endhighlight %}


[/etc/fstab]: /assets/2021-12-30-how-to-list-your-hardware-on-Linux/etc-fstab.png