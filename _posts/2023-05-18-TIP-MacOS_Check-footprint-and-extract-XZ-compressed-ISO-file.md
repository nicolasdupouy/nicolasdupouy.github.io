---
layout:             tip
title:              "[MacOS] Check footprint and extract XZ compressed ISO file"
type:               "TIP"
date-publication:   2023-05-18 09:00:00 +0200
categories:         [MacOS command line terminal XZ ISO]
permalink:          /2023-05-18-TIP-MacOS_Check-footprint-and-extract-XZ-compressed-ISO-file/
toc: true
---

**Table of Contents**
* TOC
{:toc}

<BR>

## Goal

You want to get an ISO file to ultimately install it. But as you want to ensure the version hasn't been tampered, you can follow these checklist:

1. download an ISO file,
2. check its validity
3. extract it (if compressed)
4. burn it on a flash drive

For the example, let's focus on a [FreeBSD](https://www.freebsd.org/) ISO file name `FreeBSD-13.1-RELEASE-amd64-dvd1.iso.xz` that you will get [here](https://download.freebsd.org/releases/ISO-IMAGES/13.1/):

*NB:* You may consider using the ***bootonly*** version as it is way smaller and however sufficient. The missing packages will be retrieved during the installation process.

![screenshot 1][screenshot 1]

## Download

You may fetch a compressed version to get some time and bandwidth improvement. In the case where you take `FreeBSD-13.1-RELEASE-amd64-dvd1.iso.xz` instead of `FreeBSD-13.1-RELEASE-amd64-dvd1.iso` you will retrieve a file 26% smaller.

### option 1
```shell
curl https://download.freebsd.org/releases/ISO-IMAGES/13.1/FreeBSD-13.1-RELEASE-amd64-dvd1.iso.xz --output FreeBSD-13.1-RELEASE-amd64-dvd1.iso.xz
```

### option 2
```shell
wget https://download.freebsd.org/releases/ISO-IMAGES/13.1/FreeBSD-13.1-RELEASE-amd64-dvd1.iso.xz
```

## Check file checksum
As you can see in the screenshot, there is two checksums file that you can get, depending on the SHA algorithm 
 - ***SHA265***: `CHECKSUM.SHA256-FreeBSD-13.1-RELEASE-amd64`
 - ***SHA512***: `CHECKSUM.SHA512-FreeBSD-13.1-RELEASE-amd64`

Let's use the `SHA512` one:

```shell
wget https://download.freebsd.org/releases/ISO-IMAGES/13.1/CHECKSUM.SHA512-FreeBSD-13.1-RELEASE-amd64
```

Check the file hasn't been tampered:

```shell
> shasum -a 512 FreeBSD-13.1-RELEASE-amd64-dvd1.iso.xz --check CHECKSUM.SHA512-FreeBSD-13.1-RELEASE-amd64 2>/dev/null | grep FreeBSD-13.1-RELEASE-amd64-dvd1.iso.xz
FreeBSD-13.1-RELEASE-amd64-dvd1.iso.xz: OK
```

## Extract

```shell
xz -d FreeBSD-13.1-RELEASE-amd64-dvd1.iso.xz
```

You may use `tar -xJvf FreeBSD-13.1-RELEASE-amd64-dvd1.iso.xz` but it would extract the hierarchy contained into the ISO file.

## Burn it

Follow these instructions: [[MacOS] Burn ISO to flash drive or CD/DVD disk](/2023-05-14-TIP_MacOS-Burn-ISO-to-flash-drive-or-cd-dvd-disk)



[screenshot 1]: /assets/2023-05-18-TIP-MacOS_Check-footprint-and-extract-XZ-compressed-ISO-file/download.freebsd.org-releases-ISO-IMAGES-13.1.png
