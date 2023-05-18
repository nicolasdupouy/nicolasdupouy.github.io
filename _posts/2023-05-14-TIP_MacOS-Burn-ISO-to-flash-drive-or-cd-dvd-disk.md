---
layout:             tip
title:              "[MacOS] Burn ISO to flash drive or CD/DVD disk"
type:               "TIP"
date-publication:   2023-05-14 20:00:00 +0200
categories:         [MacOS command line terminal diskutil dd hdiutil]
permalink:          /2023-05-14-TIP_MacOS-Burn-ISO-to-flash-drive-or-cd-dvd-disk/
toc: true
---

**Table of Contents**
* TOC
{:toc}

## Goal

You have an ISO file and need to burn it on a flash drive or a CD/DVD disk.

## Flash Drive

### Find the device name
The first step is to find the device name corresponding to the USB key. Here it is `/dev/disk6`.

```shell
> diskutil list
/dev/disk0 (internal, physical):
   #:                       TYPE NAME                    SIZE       IDENTIFIER
   0:      GUID_partition_scheme                        *4.0 TB     disk0
   1:             Apple_APFS_ISC Container disk2         524.3 MB   disk0s1
   2:                 Apple_APFS Container disk3         4.0 TB     disk0s2
   3:        Apple_APFS_Recovery Container disk1         5.4 GB     disk0s3

/dev/disk3 (synthesized):
   #:                       TYPE NAME                    SIZE       IDENTIFIER
   0:      APFS Container Scheme -                      +4.0 TB     disk3
                                 Physical Store disk0s2
   1:                APFS Volume Macintosh HD            11.9 GB    disk3s1
   2:              APFS Snapshot com.apple.os.update-... 11.9 GB    disk3s1s1
   3:                APFS Volume Preboot                 9.4 GB     disk3s2
   4:                APFS Volume Recovery                1.6 GB     disk3s3
   5:                APFS Volume Data                    300.0 GB   disk3s5
   6:                APFS Volume VM                      20.5 KB    disk3s6

/dev/disk6 (external, physical):
   #:                       TYPE NAME                    SIZE       IDENTIFIER
   0:                            CCCOMA_X64FRE_EN-US... *123.1 GB   disk6
```

In this case, there was only one partition `/dev/disk6`.

But you may also have multiple partitions on your USB key. The important information you need here is the device representing the disk: `/dev/disk4`

```shell
> diskutil list
/dev/disk0 (internal, physical):
   #:                       TYPE NAME                    SIZE       IDENTIFIER
   0:      GUID_partition_scheme                        *4.0 TB     disk0
   1:             Apple_APFS_ISC Container disk1         524.3 MB   disk0s1
   2:                 Apple_APFS Container disk3         4.0 TB     disk0s2
   3:        Apple_APFS_Recovery Container disk2         5.4 GB     disk0s3

/dev/disk3 (synthesized):
   #:                       TYPE NAME                    SIZE       IDENTIFIER
   0:      APFS Container Scheme -                      +4.0 TB     disk3
                                 Physical Store disk0s2
   1:                APFS Volume Macintosh HD            12.8 GB    disk3s1
   2:              APFS Snapshot com.apple.os.update-... 12.8 GB    disk3s1s1
   3:                APFS Volume Preboot                 9.7 GB     disk3s2
   4:                APFS Volume Recovery                1.6 GB     disk3s3
   5:                APFS Volume Data                    328.2 GB   disk3s5
   6:                APFS Volume VM                      20.5 KB    disk3s6

/dev/disk4 (external, physical):
   #:                       TYPE NAME                    SIZE       IDENTIFIER
   0:     FDisk_partition_scheme                        *4.0 GB     disk4
   1:                 DOS_FAT_32 NO NAME                 4.0 GB     disk4s1
```

### Burn

```shell
 sudo dd if=Downloads/Win11_22H2_English_x64v1.iso of=/dev/disk6 bs=1m                                                                                                       
Password:
5299+1 records in
5299+1 records out
5557432320 bytes transferred in 864.412104 secs (6429147 bytes/sec)
```

#### Troubleshoot: Resource busy
You may encounter the `Resource busy` error

```shell
 > sudo dd if=FreeBSD-13.1-RELEASE-amd64-dvd1.iso of=/dev/disk4 bs=1m
dd: /dev/disk4: Resource busy
```

In that case, you need to umount the disk:
```shell
 > sudo diskutil umountDisk /dev/disk4
Unmount of all volumes on disk4 was successful
```

And relaunch the `dd` command:
```shell
 sudo dd if=FreeBSD-13.1-RELEASE-amd64-dvd1.iso of=/dev/disk4 bs=1m
dd: /dev/disk4: end of device
3828+0 records in
3827+1 records out
4012916736 bytes transferred in 854.986172 secs (4693546 bytes/sec)
```

As the process may be long, depending of the ISO file. You may add the `status=progress` option. It prints basic transfer statistics once per second.

### Umount
Umount the disk and unplug the USB key:

```shell
 sudo diskutil umountDisk /dev/disk4
Password:
Unmount of all volumes on disk4 was successful
```

## CD/DVD Disc
### Burn

```shell
 hdiutil burn Downloads/Win11_22H2_English_x64v1.iso
Preparing data for burn
Opening session
Opening track
Writing track
............................................................................................................................................................................
Closing track
............................................................................................................................................................................
Closing session
............................................................................................................................................................................
Finishing burn
Verifying burn…
Verifying
............................................................................................................................................................................
Burn completed successfully
............................................................................................................................................................................
hdiutil: burn: completed
```

