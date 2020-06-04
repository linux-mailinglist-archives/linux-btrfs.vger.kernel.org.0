Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1964C1EE2D2
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Jun 2020 12:53:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726188AbgFDKxB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 4 Jun 2020 06:53:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725854AbgFDKxA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 4 Jun 2020 06:53:00 -0400
Received: from mail-vs1-xe41.google.com (mail-vs1-xe41.google.com [IPv6:2607:f8b0:4864:20::e41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71F92C03E96D
        for <linux-btrfs@vger.kernel.org>; Thu,  4 Jun 2020 03:53:00 -0700 (PDT)
Received: by mail-vs1-xe41.google.com with SMTP id c1so3222313vsc.11
        for <linux-btrfs@vger.kernel.org>; Thu, 04 Jun 2020 03:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=XdNNPJPgXLr572u03EJmeyygylDzNPJngE3k5pHmNlE=;
        b=m5wWoTuxZm0ezVItahd8YEM42iVfUYuTXBHSw5kp4OLQp4k8LEPnFJMQcGW354MudY
         gzPJpAjriMuDSnSY4YqwRiEYAy8Q8K1IrOXPYHuMxNSn2KSs4wEOHHTdwxNtxSA7CR4z
         bGK6RnITW1Wc7IrBXx6AVDOhiXLkXLoFqVMdvL0ani3S5M+VNZUQbuiQPy41RZBf93ID
         LjMSD9LVZn22wGchxHOrDGq5hdh1J2UcTzibbeDoJxwUE5qepI0T8/SKWdt6WBeXx327
         AnVcZL9Jv+JZ384o2A561dakREJqCbiqu4BO8WRER9aMSKIXz42n9GxDNNtU+T0WZ6fd
         exng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=XdNNPJPgXLr572u03EJmeyygylDzNPJngE3k5pHmNlE=;
        b=C2TF1VBgqDOE3oogDx9P76+4Thuu6C4+rSe/oI81RGJawu+dmJ3J4b8RGXyn1ZiXCt
         jdQUlElM8arPVJZxFxahnP2s/BCqx03cCSwE1o4Gd4Y8KCZ7AQmtUvRUMEBl+PbJ38RO
         Ogw5LUwe/6QlydK/dxd2oQJOR10lkOoSpw1sADJsZRPINnZh2RzBpsK2VKWcH+tDLfi+
         KeZIh12qohwNcvOgj+7zq5NVjlyjn/Y50suhiJJWl+e3XphTzEYOi5ELfQGcdhYj6E6A
         JAT3kpltw2clJtEjrKLcFK+YG/aX+hfg8zqkUEQ/9B/QEa4zTFI6J/2bYVP5JIEgzvlM
         Pp+w==
X-Gm-Message-State: AOAM5327uRjArwxGKH3KLNwQ6WK9KfGdQoCidldAmr3pPXJgUduFJlYK
        OGhnhRv2fksq7risuS4wrNcDYu2ufv19TfXtQTsmAscX
X-Google-Smtp-Source: ABdhPJxgME01uDAuEhCox00MngKS3EAVzuRaEwC3/E5DL/cFHr7SEQBOzRsrUXyjbZu6kcWLv6rdYmkF25jUmr3yeVI=
X-Received: by 2002:a05:6102:22ca:: with SMTP id a10mr2700001vsh.152.1591267979002;
 Thu, 04 Jun 2020 03:52:59 -0700 (PDT)
MIME-Version: 1.0
References: <CABT3_pzBdRqe7SRBptM1E5MPJfwEGF6=YBovmZdj1Vxjs21iNQ@mail.gmail.com>
 <5fdc798c-c8eb-b4cf-b247-e70f5fd49fc4@gmx.com> <CABT3_pwG1CrxYBDXTzQZLVGYkLoxKpexEdyJWnm_7TCaskbOeA@mail.gmail.com>
 <1cf994f7-3efb-67ac-d5b1-22929e8ef3fd@gmx.com>
In-Reply-To: <1cf994f7-3efb-67ac-d5b1-22929e8ef3fd@gmx.com>
From:   Thorsten Rehm <thorsten.rehm@gmail.com>
Date:   Thu, 4 Jun 2020 12:52:47 +0200
Message-ID: <CABT3_pxFv0KAjO2DfmikeeT+yN-3BiDj=Mu_a=dC-K9DyL-T3w@mail.gmail.com>
Subject: Re: corrupt leaf; invalid root item size
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The disk in question is my root (/) partition. If the filesystem is
that highly damaged, I have to reinstall my system. We will see, if
it's come to that. Maybe we find something interesting on the way...
I've downloaded the latest grml daily image and started my system from
a usb stick. Here we go:

root@grml ~ # uname -r
5.6.0-2-amd64

root@grml ~ # cryptsetup open /dev/sda5 foo

                                                                  :(
Enter passphrase for /dev/sda5:

root@grml ~ # file -L -s /dev/mapper/foo
/dev/mapper/foo: BTRFS Filesystem label "slash", sectorsize 4096,
nodesize 4096, leafsize 4096,
UUID=3D65005d0f-f8ea-4f77-8372-eb8b53198685, 7815716864/123731968000
bytes used, 1 devices

root@grml ~ # btrfs check /dev/mapper/foo
Opening filesystem to check...
Checking filesystem on /dev/mapper/foo
UUID: 65005d0f-f8ea-4f77-8372-eb8b53198685
[1/7] checking root items
[2/7] checking extents
[3/7] checking free space cache
[4/7] checking fs roots
[5/7] checking only csums items (without verifying data)
[6/7] checking root refs
[7/7] checking quota groups skipped (not enabled on this FS)
found 7815716864 bytes used, no error found
total csum bytes: 6428260
total tree bytes: 175968256
total fs tree bytes: 149475328
total extent tree bytes: 16052224
btree space waste bytes: 43268911
file data blocks allocated: 10453221376
 referenced 8746053632

root@grml ~ # lsblk /dev/sda5 --fs
NAME  FSTYPE      FSVER LABEL UUID
FSAVAIL FSUSE% MOUNTPOINT
sda5  crypto_LUKS 1           d2b4fa40-8afd-4e16-b207-4d106096fd22
=E2=94=94=E2=94=80foo btrfs             slash 65005d0f-f8ea-4f77-8372-eb8b5=
3198685

root@grml ~ # mount /dev/mapper/foo /mnt
root@grml ~ # btrfs scrub start /mnt

root@grml ~ # journalctl -k --no-pager | grep BTRFS
Jun 04 10:33:04 grml kernel: BTRFS: device label slash devid 1 transid
24750795 /dev/dm-0 scanned by systemd-udevd (3233)
Jun 04 10:45:17 grml kernel: BTRFS info (device dm-0): disk space
caching is enabled
Jun 04 10:45:17 grml kernel: BTRFS critical (device dm-0): corrupt
leaf: root=3D1 block=3D54222848 slot=3D32, invalid root item size, have 239
expect 439
Jun 04 10:45:17 grml kernel: BTRFS info (device dm-0): enabling ssd
optimizations
Jun 04 10:45:17 grml kernel: BTRFS info (device dm-0): checking UUID tree
Jun 04 10:45:38 grml kernel: BTRFS info (device dm-0): scrub: started on de=
vid 1
Jun 04 10:45:49 grml kernel: BTRFS critical (device dm-0): corrupt
leaf: root=3D1 block=3D29552640 slot=3D32, invalid root item size, have 239
expect 439
Jun 04 10:46:25 grml kernel: BTRFS critical (device dm-0): corrupt
leaf: root=3D1 block=3D29741056 slot=3D32, invalid root item size, have 239
expect 439
Jun 04 10:46:31 grml kernel: BTRFS info (device dm-0): scrub: finished
on devid 1 with status: 0
Jun 04 10:46:56 grml kernel: BTRFS critical (device dm-0): corrupt
leaf: root=3D1 block=3D29974528 slot=3D32, invalid root item size, have 239
expect 439

root@grml ~ # btrfs scrub status /mnt
UUID:             65005d0f-f8ea-4f77-8372-eb8b53198685
Scrub started:    Thu Jun  4 10:45:38 2020
Status:           finished
Duration:         0:00:53
Total to scrub:   7.44GiB
Rate:             143.80MiB/s
Error summary:    no errors found


root@grml ~ # for block in 54222848 29552640 29741056 29974528; do
btrfs ins dump-tree -b $block /dev/dm-0; done
btrfs-progs v5.6
leaf 54222848 items 33 free space 1095 generation 24750795 owner ROOT_TREE
leaf 54222848 flags 0x1(WRITTEN) backref revision 1
fs uuid 65005d0f-f8ea-4f77-8372-eb8b53198685
chunk uuid 137764f6-c8e6-45b3-b275-82d8558c1ff9
    item 0 key (289 INODE_ITEM 0) itemoff 3835 itemsize 160
        generation 24703953 transid 24703953 size 262144 nbytes 8595701760
        block group 0 mode 100600 links 1 uid 0 gid 0 rdev 0
        sequence 32790 flags 0x1b(NODATASUM|NODATACOW|NOCOMPRESS|PREALLOC)
        atime 0.0 (1970-01-01 00:00:00)
        ctime 1589235096.486856306 (2020-05-11 22:11:36)
        mtime 0.0 (1970-01-01 00:00:00)
        otime 0.0 (1970-01-01 00:00:00)
    item 1 key (289 EXTENT_DATA 0) itemoff 3782 itemsize 53
        generation 24703953 type 1 (regular)
        extent data disk byte 3544403968 nr 262144
        extent data offset 0 nr 262144 ram 262144
        extent compression 0 (none)
    item 2 key (290 INODE_ITEM 0) itemoff 3622 itemsize 160
        generation 20083477 transid 20083477 size 262144 nbytes 6823346176
        block group 0 mode 100600 links 1 uid 0 gid 0 rdev 0
        sequence 26029 flags 0x1b(NODATASUM|NODATACOW|NOCOMPRESS|PREALLOC)
        atime 0.0 (1970-01-01 00:00:00)
        ctime 1587576718.255911112 (2020-04-22 17:31:58)
        mtime 0.0 (1970-01-01 00:00:00)
        otime 0.0 (1970-01-01 00:00:00)
    item 3 key (290 EXTENT_DATA 0) itemoff 3569 itemsize 53
        generation 20083477 type 1 (regular)
        extent data disk byte 3373088768 nr 262144
        extent data offset 0 nr 262144 ram 262144
        extent compression 0 (none)
    item 4 key (291 INODE_ITEM 0) itemoff 3409 itemsize 160
        generation 24712508 transid 24712508 size 262144 nbytes 5454692352
        block group 0 mode 100600 links 1 uid 0 gid 0 rdev 0
        sequence 20808 flags 0x1b(NODATASUM|NODATACOW|NOCOMPRESS|PREALLOC)
        atime 0.0 (1970-01-01 00:00:00)
        ctime 1589569287.32299836 (2020-05-15 19:01:27)
        mtime 0.0 (1970-01-01 00:00:00)
        otime 0.0 (1970-01-01 00:00:00)
    item 5 key (291 EXTENT_DATA 0) itemoff 3356 itemsize 53
        generation 24712508 type 1 (regular)
        extent data disk byte 5286600704 nr 262144
        extent data offset 0 nr 262144 ram 262144
        extent compression 0 (none)
    item 6 key (292 INODE_ITEM 0) itemoff 3196 itemsize 160
        generation 24750791 transid 24750791 size 262144 nbytes 30220264407=
04
        block group 0 mode 100600 links 1 uid 0 gid 0 rdev 0
        sequence 11528116 flags 0x1b(NODATASUM|NODATACOW|NOCOMPRESS|PREALLO=
C)
        atime 0.0 (1970-01-01 00:00:00)
        ctime 1591266423.923005453 (2020-06-04 10:27:03)
        mtime 0.0 (1970-01-01 00:00:00)
        otime 0.0 (1970-01-01 00:00:00)
    item 7 key (292 EXTENT_DATA 0) itemoff 3143 itemsize 53
        generation 24750791 type 1 (regular)
        extent data disk byte 3249909760 nr 262144
        extent data offset 0 nr 262144 ram 262144
        extent compression 0 (none)
    item 8 key (FREE_SPACE UNTYPED 29360128) itemoff 3102 itemsize 41
        location key (256 INODE_ITEM 0)
        cache generation 24750795 entries 25 bitmaps 8
    item 9 key (FREE_SPACE UNTYPED 1103101952) itemoff 3061 itemsize 41
        location key (257 INODE_ITEM 0)
        cache generation 24750794 entries 140 bitmaps 8
    item 10 key (FREE_SPACE UNTYPED 2176843776) itemoff 3020 itemsize 41
        location key (258 INODE_ITEM 0)
        cache generation 24750795 entries 31 bitmaps 8
    item 11 key (FREE_SPACE UNTYPED 3250585600) itemoff 2979 itemsize 41
        location key (259 INODE_ITEM 0)
        cache generation 24750795 entries 39 bitmaps 8
    item 12 key (FREE_SPACE UNTYPED 4324327424) itemoff 2938 itemsize 41
        location key (261 INODE_ITEM 0)
        cache generation 24750702 entries 155 bitmaps 8
    item 13 key (FREE_SPACE UNTYPED 5398069248) itemoff 2897 itemsize 41
        location key (260 INODE_ITEM 0)
        cache generation 24749493 entries 23 bitmaps 8
    item 14 key (FREE_SPACE UNTYPED 6471811072) itemoff 2856 itemsize 41
        location key (262 INODE_ITEM 0)
        cache generation 24749507 entries 72 bitmaps 8
    item 15 key (FREE_SPACE UNTYPED 7545552896) itemoff 2815 itemsize 41
        location key (263 INODE_ITEM 0)
        cache generation 24749493 entries 22 bitmaps 8
    item 16 key (FREE_SPACE UNTYPED 8619294720) itemoff 2774 itemsize 41
        location key (264 INODE_ITEM 0)
        cache generation 24729885 entries 35 bitmaps 8
    item 17 key (FREE_SPACE UNTYPED 9693036544) itemoff 2733 itemsize 41
        location key (265 INODE_ITEM 0)
        cache generation 22144003 entries 30 bitmaps 8
    item 18 key (FREE_SPACE UNTYPED 10766778368) itemoff 2692 itemsize 41
        location key (266 INODE_ITEM 0)
        cache generation 24749177 entries 148 bitmaps 4
    item 19 key (FREE_SPACE UNTYPED 11840520192) itemoff 2651 itemsize 41
        location key (267 INODE_ITEM 0)
        cache generation 24749152 entries 33 bitmaps 8
    item 20 key (FREE_SPACE UNTYPED 12914262016) itemoff 2610 itemsize 41
        location key (268 INODE_ITEM 0)
        cache generation 24706177 entries 11 bitmaps 8
    item 21 key (FREE_SPACE UNTYPED 13988003840) itemoff 2569 itemsize 41
        location key (269 INODE_ITEM 0)
        cache generation 21296150 entries 46 bitmaps 8
    item 22 key (FREE_SPACE UNTYPED 15061745664) itemoff 2528 itemsize 41
        location key (270 INODE_ITEM 0)
        cache generation 24729843 entries 58 bitmaps 8
    item 23 key (FREE_SPACE UNTYPED 16135487488) itemoff 2487 itemsize 41
        location key (271 INODE_ITEM 0)
        cache generation 20064465 entries 36 bitmaps 8
    item 24 key (FREE_SPACE UNTYPED 17209229312) itemoff 2446 itemsize 41
        location key (272 INODE_ITEM 0)
        cache generation 20079294 entries 86 bitmaps 0
    item 25 key (FREE_SPACE UNTYPED 18282971136) itemoff 2405 itemsize 41
        location key (273 INODE_ITEM 0)
        cache generation 20081218 entries 38 bitmaps 8
    item 26 key (FREE_SPACE UNTYPED 19356712960) itemoff 2364 itemsize 41
        location key (274 INODE_ITEM 0)
        cache generation 20088898 entries 22 bitmaps 4
    item 27 key (FREE_SPACE UNTYPED 20430454784) itemoff 2323 itemsize 41
        location key (275 INODE_ITEM 0)
        cache generation 20055389 entries 91 bitmaps 7
    item 28 key (FREE_SPACE UNTYPED 35462840320) itemoff 2282 itemsize 41
        location key (289 INODE_ITEM 0)
        cache generation 24703953 entries 10 bitmaps 8
    item 29 key (FREE_SPACE UNTYPED 44052774912) itemoff 2241 itemsize 41
        location key (290 INODE_ITEM 0)
        cache generation 20083477 entries 36 bitmaps 8
    item 30 key (FREE_SPACE UNTYPED 52642709504) itemoff 2200 itemsize 41
        location key (291 INODE_ITEM 0)
        cache generation 24712508 entries 9 bitmaps 8
    item 31 key (FREE_SPACE UNTYPED 54857302016) itemoff 2159 itemsize 41
        location key (292 INODE_ITEM 0)
        cache generation 24750791 entries 139 bitmaps 8
    item 32 key (DATA_RELOC_TREE ROOT_ITEM 0) itemoff 1920 itemsize 239
        generation 4 root_dirid 256 bytenr 29380608 level 0 refs 1
        lastsnap 0 byte_limit 0 bytes_used 4096 flags 0x0(none)
        drop key (0 UNKNOWN.0 0) level 0
btrfs-progs v5.6
leaf 29552640 items 33 free space 1095 generation 24750796 owner ROOT_TREE
leaf 29552640 flags 0x1(WRITTEN) backref revision 1
fs uuid 65005d0f-f8ea-4f77-8372-eb8b53198685
chunk uuid 137764f6-c8e6-45b3-b275-82d8558c1ff9
    item 0 key (289 INODE_ITEM 0) itemoff 3835 itemsize 160
        generation 24703953 transid 24703953 size 262144 nbytes 8595701760
        block group 0 mode 100600 links 1 uid 0 gid 0 rdev 0
        sequence 32790 flags 0x1b(NODATASUM|NODATACOW|NOCOMPRESS|PREALLOC)
        atime 0.0 (1970-01-01 00:00:00)
        ctime 1589235096.486856306 (2020-05-11 22:11:36)
        mtime 0.0 (1970-01-01 00:00:00)
        otime 0.0 (1970-01-01 00:00:00)
    item 1 key (289 EXTENT_DATA 0) itemoff 3782 itemsize 53
        generation 24703953 type 1 (regular)
        extent data disk byte 3544403968 nr 262144
        extent data offset 0 nr 262144 ram 262144
        extent compression 0 (none)
    item 2 key (290 INODE_ITEM 0) itemoff 3622 itemsize 160
        generation 20083477 transid 20083477 size 262144 nbytes 6823346176
        block group 0 mode 100600 links 1 uid 0 gid 0 rdev 0
        sequence 26029 flags 0x1b(NODATASUM|NODATACOW|NOCOMPRESS|PREALLOC)
        atime 0.0 (1970-01-01 00:00:00)
        ctime 1587576718.255911112 (2020-04-22 17:31:58)
        mtime 0.0 (1970-01-01 00:00:00)
        otime 0.0 (1970-01-01 00:00:00)
    item 3 key (290 EXTENT_DATA 0) itemoff 3569 itemsize 53
        generation 20083477 type 1 (regular)
        extent data disk byte 3373088768 nr 262144
        extent data offset 0 nr 262144 ram 262144
        extent compression 0 (none)
    item 4 key (291 INODE_ITEM 0) itemoff 3409 itemsize 160
        generation 24712508 transid 24712508 size 262144 nbytes 5454692352
        block group 0 mode 100600 links 1 uid 0 gid 0 rdev 0
        sequence 20808 flags 0x1b(NODATASUM|NODATACOW|NOCOMPRESS|PREALLOC)
        atime 0.0 (1970-01-01 00:00:00)
        ctime 1589569287.32299836 (2020-05-15 19:01:27)
        mtime 0.0 (1970-01-01 00:00:00)
        otime 0.0 (1970-01-01 00:00:00)
    item 5 key (291 EXTENT_DATA 0) itemoff 3356 itemsize 53
        generation 24712508 type 1 (regular)
        extent data disk byte 5286600704 nr 262144
        extent data offset 0 nr 262144 ram 262144
        extent compression 0 (none)
    item 6 key (292 INODE_ITEM 0) itemoff 3196 itemsize 160
        generation 24750791 transid 24750791 size 262144 nbytes 30220264407=
04
        block group 0 mode 100600 links 1 uid 0 gid 0 rdev 0
        sequence 11528116 flags 0x1b(NODATASUM|NODATACOW|NOCOMPRESS|PREALLO=
C)
        atime 0.0 (1970-01-01 00:00:00)
        ctime 1591266423.923005453 (2020-06-04 10:27:03)
        mtime 0.0 (1970-01-01 00:00:00)
        otime 0.0 (1970-01-01 00:00:00)
    item 7 key (292 EXTENT_DATA 0) itemoff 3143 itemsize 53
        generation 24750791 type 1 (regular)
        extent data disk byte 3249909760 nr 262144
        extent data offset 0 nr 262144 ram 262144
        extent compression 0 (none)
    item 8 key (FREE_SPACE UNTYPED 29360128) itemoff 3102 itemsize 41
        location key (256 INODE_ITEM 0)
        cache generation 24750796 entries 45 bitmaps 8
    item 9 key (FREE_SPACE UNTYPED 1103101952) itemoff 3061 itemsize 41
        location key (257 INODE_ITEM 0)
        cache generation 24750794 entries 140 bitmaps 8
    item 10 key (FREE_SPACE UNTYPED 2176843776) itemoff 3020 itemsize 41
        location key (258 INODE_ITEM 0)
        cache generation 24750796 entries 34 bitmaps 8
    item 11 key (FREE_SPACE UNTYPED 3250585600) itemoff 2979 itemsize 41
        location key (259 INODE_ITEM 0)
        cache generation 24750796 entries 37 bitmaps 8
    item 12 key (FREE_SPACE UNTYPED 4324327424) itemoff 2938 itemsize 41
        location key (261 INODE_ITEM 0)
        cache generation 24750702 entries 155 bitmaps 8
    item 13 key (FREE_SPACE UNTYPED 5398069248) itemoff 2897 itemsize 41
        location key (260 INODE_ITEM 0)
        cache generation 24749493 entries 23 bitmaps 8
    item 14 key (FREE_SPACE UNTYPED 6471811072) itemoff 2856 itemsize 41
        location key (262 INODE_ITEM 0)
        cache generation 24749507 entries 72 bitmaps 8
    item 15 key (FREE_SPACE UNTYPED 7545552896) itemoff 2815 itemsize 41
        location key (263 INODE_ITEM 0)
        cache generation 24749493 entries 22 bitmaps 8
    item 16 key (FREE_SPACE UNTYPED 8619294720) itemoff 2774 itemsize 41
        location key (264 INODE_ITEM 0)
        cache generation 24729885 entries 35 bitmaps 8
    item 17 key (FREE_SPACE UNTYPED 9693036544) itemoff 2733 itemsize 41
        location key (265 INODE_ITEM 0)
        cache generation 22144003 entries 30 bitmaps 8
    item 18 key (FREE_SPACE UNTYPED 10766778368) itemoff 2692 itemsize 41
        location key (266 INODE_ITEM 0)
        cache generation 24749177 entries 148 bitmaps 4
    item 19 key (FREE_SPACE UNTYPED 11840520192) itemoff 2651 itemsize 41
        location key (267 INODE_ITEM 0)
        cache generation 24749152 entries 33 bitmaps 8
    item 20 key (FREE_SPACE UNTYPED 12914262016) itemoff 2610 itemsize 41
        location key (268 INODE_ITEM 0)
        cache generation 24706177 entries 11 bitmaps 8
    item 21 key (FREE_SPACE UNTYPED 13988003840) itemoff 2569 itemsize 41
        location key (269 INODE_ITEM 0)
        cache generation 21296150 entries 46 bitmaps 8
    item 22 key (FREE_SPACE UNTYPED 15061745664) itemoff 2528 itemsize 41
        location key (270 INODE_ITEM 0)
        cache generation 24729843 entries 58 bitmaps 8
    item 23 key (FREE_SPACE UNTYPED 16135487488) itemoff 2487 itemsize 41
        location key (271 INODE_ITEM 0)
        cache generation 20064465 entries 36 bitmaps 8
    item 24 key (FREE_SPACE UNTYPED 17209229312) itemoff 2446 itemsize 41
        location key (272 INODE_ITEM 0)
        cache generation 20079294 entries 86 bitmaps 0
    item 25 key (FREE_SPACE UNTYPED 18282971136) itemoff 2405 itemsize 41
        location key (273 INODE_ITEM 0)
        cache generation 20081218 entries 38 bitmaps 8
    item 26 key (FREE_SPACE UNTYPED 19356712960) itemoff 2364 itemsize 41
        location key (274 INODE_ITEM 0)
        cache generation 20088898 entries 22 bitmaps 4
    item 27 key (FREE_SPACE UNTYPED 20430454784) itemoff 2323 itemsize 41
        location key (275 INODE_ITEM 0)
        cache generation 20055389 entries 91 bitmaps 7
    item 28 key (FREE_SPACE UNTYPED 35462840320) itemoff 2282 itemsize 41
        location key (289 INODE_ITEM 0)
        cache generation 24703953 entries 10 bitmaps 8
    item 29 key (FREE_SPACE UNTYPED 44052774912) itemoff 2241 itemsize 41
        location key (290 INODE_ITEM 0)
        cache generation 20083477 entries 36 bitmaps 8
    item 30 key (FREE_SPACE UNTYPED 52642709504) itemoff 2200 itemsize 41
        location key (291 INODE_ITEM 0)
        cache generation 24712508 entries 9 bitmaps 8
    item 31 key (FREE_SPACE UNTYPED 54857302016) itemoff 2159 itemsize 41
        location key (292 INODE_ITEM 0)
        cache generation 24750791 entries 139 bitmaps 8
    item 32 key (DATA_RELOC_TREE ROOT_ITEM 0) itemoff 1920 itemsize 239
        generation 4 root_dirid 256 bytenr 29380608 level 0 refs 1
        lastsnap 0 byte_limit 0 bytes_used 4096 flags 0x0(none)
        drop key (0 UNKNOWN.0 0) level 0
btrfs-progs v5.6
leaf 29741056 items 33 free space 1095 generation 24750797 owner ROOT_TREE
leaf 29741056 flags 0x1(WRITTEN) backref revision 1
fs uuid 65005d0f-f8ea-4f77-8372-eb8b53198685
chunk uuid 137764f6-c8e6-45b3-b275-82d8558c1ff9
    item 0 key (289 INODE_ITEM 0) itemoff 3835 itemsize 160
        generation 24703953 transid 24703953 size 262144 nbytes 8595701760
        block group 0 mode 100600 links 1 uid 0 gid 0 rdev 0
        sequence 32790 flags 0x1b(NODATASUM|NODATACOW|NOCOMPRESS|PREALLOC)
        atime 0.0 (1970-01-01 00:00:00)
        ctime 1589235096.486856306 (2020-05-11 22:11:36)
        mtime 0.0 (1970-01-01 00:00:00)
        otime 0.0 (1970-01-01 00:00:00)
    item 1 key (289 EXTENT_DATA 0) itemoff 3782 itemsize 53
        generation 24703953 type 1 (regular)
        extent data disk byte 3544403968 nr 262144
        extent data offset 0 nr 262144 ram 262144
        extent compression 0 (none)
    item 2 key (290 INODE_ITEM 0) itemoff 3622 itemsize 160
        generation 20083477 transid 20083477 size 262144 nbytes 6823346176
        block group 0 mode 100600 links 1 uid 0 gid 0 rdev 0
        sequence 26029 flags 0x1b(NODATASUM|NODATACOW|NOCOMPRESS|PREALLOC)
        atime 0.0 (1970-01-01 00:00:00)
        ctime 1587576718.255911112 (2020-04-22 17:31:58)
        mtime 0.0 (1970-01-01 00:00:00)
        otime 0.0 (1970-01-01 00:00:00)
    item 3 key (290 EXTENT_DATA 0) itemoff 3569 itemsize 53
        generation 20083477 type 1 (regular)
        extent data disk byte 3373088768 nr 262144
        extent data offset 0 nr 262144 ram 262144
        extent compression 0 (none)
    item 4 key (291 INODE_ITEM 0) itemoff 3409 itemsize 160
        generation 24712508 transid 24712508 size 262144 nbytes 5454692352
        block group 0 mode 100600 links 1 uid 0 gid 0 rdev 0
        sequence 20808 flags 0x1b(NODATASUM|NODATACOW|NOCOMPRESS|PREALLOC)
        atime 0.0 (1970-01-01 00:00:00)
        ctime 1589569287.32299836 (2020-05-15 19:01:27)
        mtime 0.0 (1970-01-01 00:00:00)
        otime 0.0 (1970-01-01 00:00:00)
    item 5 key (291 EXTENT_DATA 0) itemoff 3356 itemsize 53
        generation 24712508 type 1 (regular)
        extent data disk byte 5286600704 nr 262144
        extent data offset 0 nr 262144 ram 262144
        extent compression 0 (none)
    item 6 key (292 INODE_ITEM 0) itemoff 3196 itemsize 160
        generation 24750791 transid 24750791 size 262144 nbytes 30220264407=
04
        block group 0 mode 100600 links 1 uid 0 gid 0 rdev 0
        sequence 11528116 flags 0x1b(NODATASUM|NODATACOW|NOCOMPRESS|PREALLO=
C)
        atime 0.0 (1970-01-01 00:00:00)
        ctime 1591266423.923005453 (2020-06-04 10:27:03)
        mtime 0.0 (1970-01-01 00:00:00)
        otime 0.0 (1970-01-01 00:00:00)
    item 7 key (292 EXTENT_DATA 0) itemoff 3143 itemsize 53
        generation 24750791 type 1 (regular)
        extent data disk byte 3249909760 nr 262144
        extent data offset 0 nr 262144 ram 262144
        extent compression 0 (none)
    item 8 key (FREE_SPACE UNTYPED 29360128) itemoff 3102 itemsize 41
        location key (256 INODE_ITEM 0)
        cache generation 24750797 entries 60 bitmaps 8
    item 9 key (FREE_SPACE UNTYPED 1103101952) itemoff 3061 itemsize 41
        location key (257 INODE_ITEM 0)
        cache generation 24750794 entries 140 bitmaps 8
    item 10 key (FREE_SPACE UNTYPED 2176843776) itemoff 3020 itemsize 41
        location key (258 INODE_ITEM 0)
        cache generation 24750797 entries 31 bitmaps 8
    item 11 key (FREE_SPACE UNTYPED 3250585600) itemoff 2979 itemsize 41
        location key (259 INODE_ITEM 0)
        cache generation 24750797 entries 40 bitmaps 8
    item 12 key (FREE_SPACE UNTYPED 4324327424) itemoff 2938 itemsize 41
        location key (261 INODE_ITEM 0)
        cache generation 24750702 entries 155 bitmaps 8
    item 13 key (FREE_SPACE UNTYPED 5398069248) itemoff 2897 itemsize 41
        location key (260 INODE_ITEM 0)
        cache generation 24749493 entries 23 bitmaps 8
    item 14 key (FREE_SPACE UNTYPED 6471811072) itemoff 2856 itemsize 41
        location key (262 INODE_ITEM 0)
        cache generation 24749507 entries 72 bitmaps 8
    item 15 key (FREE_SPACE UNTYPED 7545552896) itemoff 2815 itemsize 41
        location key (263 INODE_ITEM 0)
        cache generation 24749493 entries 22 bitmaps 8
    item 16 key (FREE_SPACE UNTYPED 8619294720) itemoff 2774 itemsize 41
        location key (264 INODE_ITEM 0)
        cache generation 24729885 entries 35 bitmaps 8
    item 17 key (FREE_SPACE UNTYPED 9693036544) itemoff 2733 itemsize 41
        location key (265 INODE_ITEM 0)
        cache generation 22144003 entries 30 bitmaps 8
    item 18 key (FREE_SPACE UNTYPED 10766778368) itemoff 2692 itemsize 41
        location key (266 INODE_ITEM 0)
        cache generation 24749177 entries 148 bitmaps 4
    item 19 key (FREE_SPACE UNTYPED 11840520192) itemoff 2651 itemsize 41
        location key (267 INODE_ITEM 0)
        cache generation 24749152 entries 33 bitmaps 8
    item 20 key (FREE_SPACE UNTYPED 12914262016) itemoff 2610 itemsize 41
        location key (268 INODE_ITEM 0)
        cache generation 24706177 entries 11 bitmaps 8
    item 21 key (FREE_SPACE UNTYPED 13988003840) itemoff 2569 itemsize 41
        location key (269 INODE_ITEM 0)
        cache generation 21296150 entries 46 bitmaps 8
    item 22 key (FREE_SPACE UNTYPED 15061745664) itemoff 2528 itemsize 41
        location key (270 INODE_ITEM 0)
        cache generation 24729843 entries 58 bitmaps 8
    item 23 key (FREE_SPACE UNTYPED 16135487488) itemoff 2487 itemsize 41
        location key (271 INODE_ITEM 0)
        cache generation 20064465 entries 36 bitmaps 8
    item 24 key (FREE_SPACE UNTYPED 17209229312) itemoff 2446 itemsize 41
        location key (272 INODE_ITEM 0)
        cache generation 20079294 entries 86 bitmaps 0
    item 25 key (FREE_SPACE UNTYPED 18282971136) itemoff 2405 itemsize 41
        location key (273 INODE_ITEM 0)
        cache generation 20081218 entries 38 bitmaps 8
    item 26 key (FREE_SPACE UNTYPED 19356712960) itemoff 2364 itemsize 41
        location key (274 INODE_ITEM 0)
        cache generation 20088898 entries 22 bitmaps 4
    item 27 key (FREE_SPACE UNTYPED 20430454784) itemoff 2323 itemsize 41
        location key (275 INODE_ITEM 0)
        cache generation 20055389 entries 91 bitmaps 7
    item 28 key (FREE_SPACE UNTYPED 35462840320) itemoff 2282 itemsize 41
        location key (289 INODE_ITEM 0)
        cache generation 24703953 entries 10 bitmaps 8
    item 29 key (FREE_SPACE UNTYPED 44052774912) itemoff 2241 itemsize 41
        location key (290 INODE_ITEM 0)
        cache generation 20083477 entries 36 bitmaps 8
    item 30 key (FREE_SPACE UNTYPED 52642709504) itemoff 2200 itemsize 41
        location key (291 INODE_ITEM 0)
        cache generation 24712508 entries 9 bitmaps 8
    item 31 key (FREE_SPACE UNTYPED 54857302016) itemoff 2159 itemsize 41
        location key (292 INODE_ITEM 0)
        cache generation 24750791 entries 139 bitmaps 8
    item 32 key (DATA_RELOC_TREE ROOT_ITEM 0) itemoff 1920 itemsize 239
        generation 4 root_dirid 256 bytenr 29380608 level 0 refs 1
        lastsnap 0 byte_limit 0 bytes_used 4096 flags 0x0(none)
        drop key (0 UNKNOWN.0 0) level 0
btrfs-progs v5.6
leaf 29974528 items 33 free space 1095 generation 24750798 owner ROOT_TREE
leaf 29974528 flags 0x1(WRITTEN) backref revision 1
fs uuid 65005d0f-f8ea-4f77-8372-eb8b53198685
chunk uuid 137764f6-c8e6-45b3-b275-82d8558c1ff9
    item 0 key (289 INODE_ITEM 0) itemoff 3835 itemsize 160
        generation 24703953 transid 24703953 size 262144 nbytes 8595701760
        block group 0 mode 100600 links 1 uid 0 gid 0 rdev 0
        sequence 32790 flags 0x1b(NODATASUM|NODATACOW|NOCOMPRESS|PREALLOC)
        atime 0.0 (1970-01-01 00:00:00)
        ctime 1589235096.486856306 (2020-05-11 22:11:36)
        mtime 0.0 (1970-01-01 00:00:00)
        otime 0.0 (1970-01-01 00:00:00)
    item 1 key (289 EXTENT_DATA 0) itemoff 3782 itemsize 53
        generation 24703953 type 1 (regular)
        extent data disk byte 3544403968 nr 262144
        extent data offset 0 nr 262144 ram 262144
        extent compression 0 (none)
    item 2 key (290 INODE_ITEM 0) itemoff 3622 itemsize 160
        generation 20083477 transid 20083477 size 262144 nbytes 6823346176
        block group 0 mode 100600 links 1 uid 0 gid 0 rdev 0
        sequence 26029 flags 0x1b(NODATASUM|NODATACOW|NOCOMPRESS|PREALLOC)
        atime 0.0 (1970-01-01 00:00:00)
        ctime 1587576718.255911112 (2020-04-22 17:31:58)
        mtime 0.0 (1970-01-01 00:00:00)
        otime 0.0 (1970-01-01 00:00:00)
    item 3 key (290 EXTENT_DATA 0) itemoff 3569 itemsize 53
        generation 20083477 type 1 (regular)
        extent data disk byte 3373088768 nr 262144
        extent data offset 0 nr 262144 ram 262144
        extent compression 0 (none)
    item 4 key (291 INODE_ITEM 0) itemoff 3409 itemsize 160
        generation 24712508 transid 24712508 size 262144 nbytes 5454692352
        block group 0 mode 100600 links 1 uid 0 gid 0 rdev 0
        sequence 20808 flags 0x1b(NODATASUM|NODATACOW|NOCOMPRESS|PREALLOC)
        atime 0.0 (1970-01-01 00:00:00)
        ctime 1589569287.32299836 (2020-05-15 19:01:27)
        mtime 0.0 (1970-01-01 00:00:00)
        otime 0.0 (1970-01-01 00:00:00)
    item 5 key (291 EXTENT_DATA 0) itemoff 3356 itemsize 53
        generation 24712508 type 1 (regular)
        extent data disk byte 5286600704 nr 262144
        extent data offset 0 nr 262144 ram 262144
        extent compression 0 (none)
    item 6 key (292 INODE_ITEM 0) itemoff 3196 itemsize 160
        generation 24750791 transid 24750791 size 262144 nbytes 30220264407=
04
        block group 0 mode 100600 links 1 uid 0 gid 0 rdev 0
        sequence 11528116 flags 0x1b(NODATASUM|NODATACOW|NOCOMPRESS|PREALLO=
C)
        atime 0.0 (1970-01-01 00:00:00)
        ctime 1591266423.923005453 (2020-06-04 10:27:03)
        mtime 0.0 (1970-01-01 00:00:00)
        otime 0.0 (1970-01-01 00:00:00)
    item 7 key (292 EXTENT_DATA 0) itemoff 3143 itemsize 53
        generation 24750791 type 1 (regular)
        extent data disk byte 3249909760 nr 262144
        extent data offset 0 nr 262144 ram 262144
        extent compression 0 (none)
    item 8 key (FREE_SPACE UNTYPED 29360128) itemoff 3102 itemsize 41
        location key (256 INODE_ITEM 0)
        cache generation 24750798 entries 79 bitmaps 8
    item 9 key (FREE_SPACE UNTYPED 1103101952) itemoff 3061 itemsize 41
        location key (257 INODE_ITEM 0)
        cache generation 24750794 entries 140 bitmaps 8
    item 10 key (FREE_SPACE UNTYPED 2176843776) itemoff 3020 itemsize 41
        location key (258 INODE_ITEM 0)
        cache generation 24750798 entries 33 bitmaps 8
    item 11 key (FREE_SPACE UNTYPED 3250585600) itemoff 2979 itemsize 41
        location key (259 INODE_ITEM 0)
        cache generation 24750798 entries 37 bitmaps 8
    item 12 key (FREE_SPACE UNTYPED 4324327424) itemoff 2938 itemsize 41
        location key (261 INODE_ITEM 0)
        cache generation 24750702 entries 155 bitmaps 8
    item 13 key (FREE_SPACE UNTYPED 5398069248) itemoff 2897 itemsize 41
        location key (260 INODE_ITEM 0)
        cache generation 24749493 entries 23 bitmaps 8
    item 14 key (FREE_SPACE UNTYPED 6471811072) itemoff 2856 itemsize 41
        location key (262 INODE_ITEM 0)
        cache generation 24749507 entries 72 bitmaps 8
    item 15 key (FREE_SPACE UNTYPED 7545552896) itemoff 2815 itemsize 41
        location key (263 INODE_ITEM 0)
        cache generation 24749493 entries 22 bitmaps 8
    item 16 key (FREE_SPACE UNTYPED 8619294720) itemoff 2774 itemsize 41
        location key (264 INODE_ITEM 0)
        cache generation 24729885 entries 35 bitmaps 8
    item 17 key (FREE_SPACE UNTYPED 9693036544) itemoff 2733 itemsize 41
        location key (265 INODE_ITEM 0)
        cache generation 22144003 entries 30 bitmaps 8
    item 18 key (FREE_SPACE UNTYPED 10766778368) itemoff 2692 itemsize 41
        location key (266 INODE_ITEM 0)
        cache generation 24749177 entries 148 bitmaps 4
    item 19 key (FREE_SPACE UNTYPED 11840520192) itemoff 2651 itemsize 41
        location key (267 INODE_ITEM 0)
        cache generation 24749152 entries 33 bitmaps 8
    item 20 key (FREE_SPACE UNTYPED 12914262016) itemoff 2610 itemsize 41
        location key (268 INODE_ITEM 0)
        cache generation 24706177 entries 11 bitmaps 8
    item 21 key (FREE_SPACE UNTYPED 13988003840) itemoff 2569 itemsize 41
        location key (269 INODE_ITEM 0)
        cache generation 21296150 entries 46 bitmaps 8
    item 22 key (FREE_SPACE UNTYPED 15061745664) itemoff 2528 itemsize 41
        location key (270 INODE_ITEM 0)
        cache generation 24729843 entries 58 bitmaps 8
    item 23 key (FREE_SPACE UNTYPED 16135487488) itemoff 2487 itemsize 41
        location key (271 INODE_ITEM 0)
        cache generation 20064465 entries 36 bitmaps 8
    item 24 key (FREE_SPACE UNTYPED 17209229312) itemoff 2446 itemsize 41
        location key (272 INODE_ITEM 0)
        cache generation 20079294 entries 86 bitmaps 0
    item 25 key (FREE_SPACE UNTYPED 18282971136) itemoff 2405 itemsize 41
        location key (273 INODE_ITEM 0)
        cache generation 20081218 entries 38 bitmaps 8
    item 26 key (FREE_SPACE UNTYPED 19356712960) itemoff 2364 itemsize 41
        location key (274 INODE_ITEM 0)
        cache generation 20088898 entries 22 bitmaps 4
    item 27 key (FREE_SPACE UNTYPED 20430454784) itemoff 2323 itemsize 41
        location key (275 INODE_ITEM 0)
        cache generation 20055389 entries 91 bitmaps 7
    item 28 key (FREE_SPACE UNTYPED 35462840320) itemoff 2282 itemsize 41
        location key (289 INODE_ITEM 0)
        cache generation 24703953 entries 10 bitmaps 8
    item 29 key (FREE_SPACE UNTYPED 44052774912) itemoff 2241 itemsize 41
        location key (290 INODE_ITEM 0)
        cache generation 20083477 entries 36 bitmaps 8
    item 30 key (FREE_SPACE UNTYPED 52642709504) itemoff 2200 itemsize 41
        location key (291 INODE_ITEM 0)
        cache generation 24712508 entries 9 bitmaps 8
    item 31 key (FREE_SPACE UNTYPED 54857302016) itemoff 2159 itemsize 41
        location key (292 INODE_ITEM 0)
        cache generation 24750791 entries 139 bitmaps 8
    item 32 key (DATA_RELOC_TREE ROOT_ITEM 0) itemoff 1920 itemsize 239
        generation 4 root_dirid 256 bytenr 29380608 level 0 refs 1
        lastsnap 0 byte_limit 0 bytes_used 4096 flags 0x0(none)
        drop key (0 UNKNOWN.0 0) level 0

On Thu, Jun 4, 2020 at 12:00 PM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>
>
>
> On 2020/6/4 =E4=B8=8B=E5=8D=885:45, Thorsten Rehm wrote:
> > Thank you for you answer.
> > I've just updated my system, did a reboot and it's running with a
> > 5.6.0-2-amd64 now.
> > So, this is how my kern.log looks like, just right after the start:
> >
>
> >
> > There are too many blocks. I just picked three randomly:
>
> Looks like we need more result, especially some result doesn't match at a=
ll.
>
> >
> > =3D=3D=3D Block 33017856 =3D=3D=3D
> > $ btrfs ins dump-tree -b 33017856 /dev/dm-0
> > btrfs-progs v5.6
> > leaf 33017856 items 51 free space 17 generation 24749502 owner FS_TREE
> > leaf 33017856 flags 0x1(WRITTEN) backref revision 1
> > fs uuid 65005d0f-f8ea-4f77-8372-eb8b53198685
> > chunk uuid 137764f6-c8e6-45b3-b275-82d8558c1ff9
> ...
> >         item 31 key (4000670 EXTENT_DATA 1933312) itemoff 2299 itemsize=
 53
> >                 generation 24749502 type 1 (regular)
> >                 extent data disk byte 1126502400 nr 4096
> >                 extent data offset 0 nr 8192 ram 8192
> >                 extent compression 2 (lzo)
> >         item 32 key (4000670 EXTENT_DATA 1941504) itemoff 2246 itemsize=
 53
> >                 generation 24749502 type 1 (regular)
> >                 extent data disk byte 0 nr 0
> >                 extent data offset 1937408 nr 4096 ram 4194304
> >                 extent compression 0 (none)
> Not root item at all.
> At least for this copy, it looks like kernel got one completely bad
> copy, then discarded it and found a good copy.
>
> That's very strange, especially when all the other involved ones seems
> random and all at slot 32 is not a coincident.
>
>
> > =3D=3D=3D Block 44900352  =3D=3D=3D
> > btrfs ins dump-tree -b 44900352 /dev/dm-0
> > btrfs-progs v5.6
> > leaf 44900352 items 19 free space 591 generation 24749527 owner FS_TREE
> > leaf 44900352 flags 0x1(WRITTEN) backref revision 1
>
> This block doesn't even have slot 32... It only have 19 items, thus slot
> 0 ~ slot 18.
> And its owner, FS_TREE shouldn't have ROOT_ITEM.
>
> >
> >
> > =3D=3D=3D Block 55352561664 =3D=3D=3D
> > $ btrfs ins dump-tree -b 55352561664 /dev/dm-0
> > btrfs-progs v5.6
> > leaf 55352561664 items 33 free space 1095 generation 24749497 owner ROO=
T_TREE
> > leaf 55352561664 flags 0x1(WRITTEN) backref revision 1
> > fs uuid 65005d0f-f8ea-4f77-8372-eb8b53198685
> > chunk uuid 137764f6-c8e6-45b3-b275-82d8558c1ff9
> ...
> >         item 32 key (DATA_RELOC_TREE ROOT_ITEM 0) itemoff 1920 itemsize=
 239
> >                 generation 4 root_dirid 256 bytenr 29380608 level 0 ref=
s 1
> >                 lastsnap 0 byte_limit 0 bytes_used 4096 flags 0x0(none)
> >                 drop key (0 UNKNOWN.0 0) level 0
>
> This looks like the offending tree block.
> Slot 32, item size 239, which is ROOT_ITEM, but in valid size.
>
> Since you're here, I guess a btrfs check without --repair on the
> unmounted fs would help to identify the real damage.
>
> And again, the fs looks very damaged, it's highly recommended to backup
> your data asap.
>
> Thanks,
> Qu
>
> > --- snap ---
> >
> >
> >
> > On Thu, Jun 4, 2020 at 3:31 AM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote=
:
> >>
> >>
> >>
> >> On 2020/6/3 =E4=B8=8B=E5=8D=889:37, Thorsten Rehm wrote:
> >>> Hi,
> >>>
> >>> I've updated my system (Debian testing) [1] several months ago (~
> >>> December) and I noticed a lot of corrupt leaf messages flooding my
> >>> kern.log [2]. Furthermore my system had some trouble, e.g.
> >>> applications were terminated after some uptime, due to the btrfs
> >>> filesystem errors. This was with kernel 5.3.
> >>> The last time I tried was with Kernel 5.6.0-1-amd64 and the problem p=
ersists.
> >>>
> >>> I've downgraded my kernel to 4.19.0-8-amd64 from the Debian Stable
> >>> release and with this kernel there aren't any corrupt leaf messages
> >>> and the problem is gone. IMHO, it must be something coming with kerne=
l
> >>> 5.3 (or 5.x).
> >>
> >> V5.3 introduced a lot of enhanced metadata sanity checks, and they cat=
ch
> >> such *obviously* wrong metadata.
> >>>
> >>> My harddisk is a SSD which is responsible for the root partition. I'v=
e
> >>> encrypted my filesystem with LUKS and just right after I entered my
> >>> password at the boot, the first corrupt leaf errors appear.
> >>>
> >>> An error message looks like this:
> >>> May  7 14:39:34 foo kernel: [  100.162145] BTRFS critical (device
> >>> dm-0): corrupt leaf: root=3D1 block=3D35799040 slot=3D32, invalid roo=
t item
> >>> size, have 239 expect 439
> >>
> >> Btrfs root items have fixed size. This is already something very bad.
> >>
> >> Furthermore, the item size is smaller than expected, which means we ca=
n
> >> easily get garbage. I'm a little surprised that older kernel can even
> >> work without crashing the whole kernel.
> >>
> >> Some extra info could help us to find out how badly the fs is corrupte=
d.
> >> # btrfs ins dump-tree -b 35799040 /dev/dm-0
> >>
> >>>
> >>> "root=3D1", "slot=3D32", "have 239 expect 439" is always the same at =
every
> >>> error line. Only the block number changes.
> >>
> >> And dumps for the other block numbers too.
> >>
> >>>
> >>> Interestingly it's the very same as reported to the ML here [3]. I've
> >>> contacted the reporter, but he didn't have a solution for me, because
> >>> he changed to a different filesystem.
> >>>
> >>> I've already tried "btrfs scrub" and "btrfs check --readonly /" in
> >>> rescue mode, but w/o any errors. I've also checked the S.M.A.R.T.
> >>> values of the SSD, which are fine. Furthermore I've tested my RAM, bu=
t
> >>> again, w/o any errors.
> >>
> >> This doesn't look like a bit flip, so not RAM problems.
> >>
> >> Don't have any better advice until we got the dumps, but I'd recommend
> >> to backup your data since it's still possible.
> >>
> >> Thanks,
> >> Qu
> >>
> >>>
> >>> So, I have no more ideas what I can do. Could you please help me to
> >>> investigate this further? Could it be a bug?
> >>>
> >>> Thank you very much.
> >>>
> >>> Best regards,
> >>> Thorsten
> >>>
> >>>
> >>>
> >>> 1:
> >>> $ cat /etc/debian_version
> >>> bullseye/sid
> >>>
> >>> $ uname -a
> >>> [no problem with this kernel]
> >>> Linux foo 4.19.0-8-amd64 #1 SMP Debian 4.19.98-1 (2020-01-26) x86_64 =
GNU/Linux
> >>>
> >>> $ btrfs --version
> >>> btrfs-progs v5.6
> >>>
> >>> $ sudo btrfs fi show
> >>> Label: 'slash'  uuid: 65005d0f-f8ea-4f77-8372-eb8b53198685
> >>>         Total devices 1 FS bytes used 7.33GiB
> >>>         devid    1 size 115.23GiB used 26.08GiB path /dev/mapper/sda5=
_crypt
> >>>
> >>> $ btrfs fi df /
> >>> Data, single: total=3D22.01GiB, used=3D7.16GiB
> >>> System, DUP: total=3D32.00MiB, used=3D4.00KiB
> >>> System, single: total=3D4.00MiB, used=3D0.00B
> >>> Metadata, DUP: total=3D2.00GiB, used=3D168.19MiB
> >>> Metadata, single: total=3D8.00MiB, used=3D0.00B
> >>> GlobalReserve, single: total=3D25.42MiB, used=3D0.00B
> >>>
> >>>
> >>> 2:
> >>> [several messages per second]
> >>> May  7 14:39:34 foo kernel: [  100.162145] BTRFS critical (device
> >>> dm-0): corrupt leaf: root=3D1 block=3D35799040 slot=3D32, invalid roo=
t item
> >>> size, have 239 expect 439
> >>> May  7 14:39:35 foo kernel: [  100.998530] BTRFS critical (device
> >>> dm-0): corrupt leaf: root=3D1 block=3D35885056 slot=3D32, invalid roo=
t item
> >>> size, have 239 expect 439
> >>> May  7 14:39:35 foo kernel: [  101.348650] BTRFS critical (device
> >>> dm-0): corrupt leaf: root=3D1 block=3D35926016 slot=3D32, invalid roo=
t item
> >>> size, have 239 expect 439
> >>> May  7 14:39:36 foo kernel: [  101.619437] BTRFS critical (device
> >>> dm-0): corrupt leaf: root=3D1 block=3D35995648 slot=3D32, invalid roo=
t item
> >>> size, have 239 expect 439
> >>> May  7 14:39:36 foo kernel: [  101.874069] BTRFS critical (device
> >>> dm-0): corrupt leaf: root=3D1 block=3D36184064 slot=3D32, invalid roo=
t item
> >>> size, have 239 expect 439
> >>> May  7 14:39:36 foo kernel: [  102.339087] BTRFS critical (device
> >>> dm-0): corrupt leaf: root=3D1 block=3D36319232 slot=3D32, invalid roo=
t item
> >>> size, have 239 expect 439
> >>> May  7 14:39:37 foo kernel: [  102.629429] BTRFS critical (device
> >>> dm-0): corrupt leaf: root=3D1 block=3D36380672 slot=3D32, invalid roo=
t item
> >>> size, have 239 expect 439
> >>> May  7 14:39:37 foo kernel: [  102.839669] BTRFS critical (device
> >>> dm-0): corrupt leaf: root=3D1 block=3D36487168 slot=3D32, invalid roo=
t item
> >>> size, have 239 expect 439
> >>> May  7 14:39:37 foo kernel: [  103.109183] BTRFS critical (device
> >>> dm-0): corrupt leaf: root=3D1 block=3D36597760 slot=3D32, invalid roo=
t item
> >>> size, have 239 expect 439
> >>> May  7 14:39:37 foo kernel: [  103.299101] BTRFS critical (device
> >>> dm-0): corrupt leaf: root=3D1 block=3D36626432 slot=3D32, invalid roo=
t item
> >>> size, have 239 expect 439
> >>>
> >>> 3:
> >>> https://lore.kernel.org/linux-btrfs/19acbd39-475f-bd72-e280-5f6c64960=
35c@web.de/
> >>>
> >>
>
