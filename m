Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6627344F9FC
	for <lists+linux-btrfs@lfdr.de>; Sun, 14 Nov 2021 19:46:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234526AbhKNStF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 14 Nov 2021 13:49:05 -0500
Received: from mail-4018.proton.ch ([185.70.40.18]:36261 "EHLO
        mail-4018.proton.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231128AbhKNStC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 14 Nov 2021 13:49:02 -0500
Date:   Sun, 14 Nov 2021 18:45:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=spliethoever.de;
        s=protonmail2; t=1636915565;
        bh=fM/KEPhu0W+rZX6SxGOZqnxD3v7j9FvYQ9NawPIObN4=;
        h=Date:To:From:Reply-To:Subject:In-Reply-To:References:From;
        b=GAi2FqsurlKjZKVE9TixcnZY5V2I9xT4ANHAnS0lYcgUdAagAWK91cQJruT4s2T80
         CjEyBzzL8omqAU701vLiBvP6zWqZ+yCF3etXnlCBCQvJFOmYvWgcQ32UFffd126eTF
         /jmYo2DXRldDQmjLw3q8gBN1jYyu8khZPkwm6zXnAOj/kPzvklPx/vUvMsdXRX3K/L
         rqUg5bFukKYRUFJGI6v9QyBBvmBW1lbsWOI207JsnXvUHeAmA2JyQkiFXtMF1aG0eq
         c/fjc5u8tcjHGfIQhUKmLg9FhBmIzM67ZBnBcENLNjgro/7VQSZE9+U2d5Yz+sWyT8
         iCVtb7ImUe2aA==
To:     Joshua <joshua@mailmag.net>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
From:   =?utf-8?Q?Max_Splieth=C3=B6ver?= <max@spliethoever.de>
Reply-To: =?utf-8?Q?Max_Splieth=C3=B6ver?= <max@spliethoever.de>
Subject: Re: Large BTRFS array suddenly says 53TiB Free, usage inconsistent
Message-ID: <b219d9de-ac42-1ec4-0fff-c8be2c36bfae@spliethoever.de>
In-Reply-To: <2f87defb6b4c199de7ce0ba85ec6b690@mailmag.net>
References: <2f87defb6b4c199de7ce0ba85ec6b690@mailmag.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=10.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF shortcircuit=no
        autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
        mailout.protonmail.ch
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello everyone.
I observed the exact same behavior on my 2x4TB RAID1. After an update of my=
 server that runs a btrfs RAID1 as data storage (root fs runs on different,=
 non-btrfs disks) and running `sudo btrfs filesystem usage /tank`, I realiz=
ed that the "Data ratio" and "Metadata ratio" had dropped from 2.00 (before=
 upgrade) to 1.00 and that the Unallocated space on both drives jumped from=
 ~550GB to 2.10TB. I sporadically checked the files and everything seems to=
 be still there.

I would appreciate any help with explaining what happened and how to possib=
ly fix this issue. Below I provided some information. If further outputs ar=
e required, please let me know.

```
$ sudo btrfs filesystem usage /tank
Overall:
     Device size:                   7.28TiB
     Device allocated:              3.07TiB
     Device unallocated:            4.21TiB
     Device missing:                  0.00B
     Used:                          3.07TiB
     Free (estimated):              4.21TiB      (min: 4.21TiB)
     Free (statfs, df):           582.54GiB
     Data ratio:                       1.00
     Metadata ratio:                   1.00
     Global reserve:              512.00MiB      (used: 0.00B)
     Multiple profiles:                  no

Data,RAID1: Size:3.07TiB, Used:3.06TiB (99.95%)
    /dev/sdd1       1.53TiB
    /dev/sde1       1.53TiB

Metadata,RAID1: Size:5.00GiB, Used:4.13GiB (82.59%)
    /dev/sdd1       2.50GiB
    /dev/sde1       2.50GiB

System,RAID1: Size:32.00MiB, Used:464.00KiB (1.42%)
    /dev/sdd1      16.00MiB
    /dev/sde1      16.00MiB

Unallocated:
    /dev/sdd1       2.10TiB
    /dev/sde1       2.10TiB
```


Also, `dmesg` and `btrfs check` do not show any errors.

```
$ sudo dmesg | grep BTRFS
[    4.161867] BTRFS: device label tank devid 2 transid 204379 /dev/sde1 sc=
anned by systemd-udevd (252)
[    4.163715] BTRFS: device label tank devid 1 transid 204379 /dev/sdd1 sc=
anned by systemd-udevd (234)
[  300.416174] BTRFS info (device sdd1): flagging fs with big metadata feat=
ure
[  300.416179] BTRFS info (device sdd1): disk space caching is enabled
[  300.416181] BTRFS info (device sdd1): has skinny extents


$ sudo btrfs check -p /dev/sdd1
Opening filesystem to check...
Checking filesystem on /dev/sdd1
UUID: 37ce3698-b9d4-4475-8569-fc440c54ad82
[1/7] checking root items                      (0:00:11 elapsed, 698424 ite=
ms checked)
[2/7] checking extents                         (0:00:42 elapsed, 270676 ite=
ms checked)
[3/7] checking free space cache                (0:00:02 elapsed, 3147 items=
 checked)
[4/7] checking fs roots                        (0:00:11 elapsed, 22115 item=
s checked)
[5/7] checking csums (without verifying data)  (0:00:02 elapsed, 1439154 it=
ems checked)
[6/7] checking root refs                       (0:00:00 elapsed, 13 items c=
hecked)
[7/7] checking quota groups skipped (not enabled on this FS)
found 3374319136768 bytes used, no error found
total csum bytes: 3290097884
total tree bytes: 4434460672
total fs tree bytes: 363446272
total extent tree bytes: 62717952
btree space waste bytes: 721586744
file data blocks allocated: 4579386322944
  referenced 4576433889280


$ sudo btrfs check -p /dev/sde1
Opening filesystem to check...
Checking filesystem on /dev/sde1
UUID: 37ce3698-b9d4-4475-8569-fc440c54ad82
[1/7] checking root items                      (0:00:11 elapsed, 698424 ite=
ms checked)
[2/7] checking extents                         (0:00:43 elapsed, 270676 ite=
ms checked)
[3/7] checking free space cache                (0:00:02 elapsed, 3147 items=
 checked)
[4/7] checking fs roots                        (0:00:11 elapsed, 22115 item=
s checked)
[5/7] checking csums (without verifying data)  (0:00:02 elapsed, 1439154 it=
ems checked)
[6/7] checking root refs                       (0:00:00 elapsed, 13 items c=
hecked)
[7/7] checking quota groups skipped (not enabled on this FS)
found 3374319136768 bytes used, no error found
total csum bytes: 3290097884
total tree bytes: 4434460672
total fs tree bytes: 363446272
total extent tree bytes: 62717952
btree space waste bytes: 721586744
file data blocks allocated: 4579386322944
  referenced 4576433889280
```


Below, you can find some more useful outputs.

```
$ sudo btrfs fi show
Label: 'tank'  uuid: 37ce3698-b9d4-4475-8569-fc440c54ad82
         Total devices 2 FS bytes used 3.07TiB
         devid    1 size 3.64TiB used 3.07TiB path /dev/sdd1
         devid    2 size 3.64TiB used 3.07TiB path /dev/sde1

$ btrfs --version
btrfs-progs v5.15

$ uname -r
5.15.2-arch1-1
```


-Max

On 11/14/21 06:48, Joshua wrote:
> I have a large multi-device BTRFS array. (13 devices / 96TiB total usable=
 space)
>
> As of yesterday, it had a little over 5 TiB reported as estimated free by=
 'btrfs fi usage'
>
> At exactly 7am this morning, my reporting tool reports that the "Free (es=
timated)" line of 'btrfs
> fi usage' jumped to 53TiB.
>
> Now I do use snapshots, managed by btrbk. I currently have 80 snapshots, =
and it is possible old
> snapshots were deleted at midnight, freeing up data.  Perhaps the deletio=
ns didn't finish committing until 7am?
>
> However, the current state of the array is concerning to me:
>
> #> btrfs fi usage /mnt
> Overall:
> Device size: 96.42TiB
> Device allocated: 43.16TiB
> Device unallocated: 53.26TiB
> Device missing: 0.00B
> Used: 43.15TiB
> Free (estimated): 53.27TiB (min: 53.27TiB)
> Free (statfs, df): 4.71TiB
> Data ratio: 1.00
> Metadata ratio: 1.00
> Global reserve: 512.00MiB (used: 0.00B)
> Multiple profiles: no
>
> Data,RAID1: Size:43.10TiB, Used:43.09TiB (99.98%)
> {snip}
> Metadata,RAID1C3: Size:66.00GiB, Used:62.51GiB (94.71%)
> {snip}
> System,RAID1C3: Size:32.00MiB, Used:7.12MiB (22.27%)
> {snip}
> Unallocated:
> {snip}
>
> As you can see, it's showing all my data is Raid1 as it should be, and al=
l my metadata is raid1c3
> as it should be.
> BUT it's showing data ratio: 1 and metadata ratio: 1
> Also, the allocated space is showing 43 TiB, which I know to be around th=
e actual amount of used
> data by files. Since Raid1 is in use, Allocated data should be around 86.=
...
>
> Any ideas as to what happened, why it's showing this erroneous data, or i=
f I should be worried
> about my data in any way?
> As of right now, everything appears intact....
>
> --Joshua Villwock
>

