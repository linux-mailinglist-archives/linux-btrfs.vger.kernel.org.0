Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7659425EC12
	for <lists+linux-btrfs@lfdr.de>; Sun,  6 Sep 2020 03:48:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728751AbgIFBnM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 5 Sep 2020 21:43:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728704AbgIFBnL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sat, 5 Sep 2020 21:43:11 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1922C061573
        for <linux-btrfs@vger.kernel.org>; Sat,  5 Sep 2020 18:43:10 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id q8so5775972lfb.6
        for <linux-btrfs@vger.kernel.org>; Sat, 05 Sep 2020 18:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fandingo-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ckB2DvKAjCjotFsp+FMqeOmxw6a8yS9St1pYrqLqWAA=;
        b=GxWsdjFTCJwlGgzM+fJn5lhQkXhEBQv6y8nHHYJW7ruMVOoKFNBArlgWOe+Xme36B3
         JBDmGIt8Trl41UNpUfIpWRk16fP7TYV5t6qZi1NoFW36s2MiDdWtyzcnHxPz446K1+YU
         2y/BFwdtHWYFLiiQEi5DhF2hXXM6xE/1S+XX6j51AtB4/YVTDRCATtdYD3Lww25ebpi8
         hG0JJYx8aJo6MIOaz788wgMONut02VyVIoSpxI1ijMgNX7SKDacNqwl/VRuVqfoQMTZS
         zEufh2/Phst0XEW0uicTzIYOKfpkUzW4r2hG8PJRcxn8PZUYZmv3YsE3vtH6A/PU/p7H
         RIew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ckB2DvKAjCjotFsp+FMqeOmxw6a8yS9St1pYrqLqWAA=;
        b=d+ROGfJyJEKZI5q5QO4nIjlE/olEW4V2EOtxhClTB45b3+ToR8fUAiJLZeZTjBVHpa
         COsj7q/okXHSK4LK1g21POiix/UgCc9FL5nlJ8Prv12C8pLWbF0GxphfNpfwuhXc56oa
         jWrlyUk6mUdoMK9DMO+XVhXYVf9qbACfoJbk6HTk7YBSIzNameX4n2Yu8vhHJZuU/2ry
         KKAO2YtaKf9zQp5eYuCsvCiZJ8S6DDQoVbEoVOAhrVw2R6+PQ+rEQFOUh46udiEnyrAJ
         6pOyPGNBPKlOGnOpn1HhdU7CUDhCJiuLEp9vLGU6gZaHm1tfvjQYddgFhrhUkmjZZZHh
         Yg9g==
X-Gm-Message-State: AOAM5327CutHC0alpw+8SHIKxeyoO9ENLLXcw7lzAvJZiW/Q9zXW0JVv
        Edki1x+02TX2+2cyIkj5DEjaL9HaGdoi4KpiiUabUg==
X-Google-Smtp-Source: ABdhPJwQzYquRdghvsLZjATxvc8aGb7jA9NIx7LclVUr8lCwmKQ3c/6nJ1ILSa6yAODCWT0ME1JYBcFS6jhstW3owMY=
X-Received: by 2002:ac2:4d10:: with SMTP id r16mr7175156lfi.58.1599356588228;
 Sat, 05 Sep 2020 18:43:08 -0700 (PDT)
MIME-Version: 1.0
References: <CAKZK7uwRs_tf6htRtJvw3kNhyNPMJ-juA6_WSJo+PbQA7f40Cg@mail.gmail.com>
 <8e17a4d1-6555-15ba-808c-dd867d7ecbcb@gmx.com> <4f21b4c4-430e-59eb-068c-231cf3bc492d@gmx.com>
 <CAKZK7uzmg19NDjGPPAxXKu7LJ-7ZdHu2cad22csj_chr2qxMJg@mail.gmail.com>
 <2061ec67-a5a4-07c6-fe5e-8464feb272aa@gmx.com> <CAKZK7uwFFpxiwA=Ye1VpqvkonAER=T-a2i_h_yGwpkieaeXcjg@mail.gmail.com>
 <bd921a29-cd4a-62dc-4e14-708e617ec156@gmx.com>
In-Reply-To: <bd921a29-cd4a-62dc-4e14-708e617ec156@gmx.com>
From:   Justin Brown <Justin.Brown@fandingo.org>
Date:   Sat, 5 Sep 2020 20:42:56 -0500
Message-ID: <CAKZK7uxBUa+X_r+wH=pe-BNowvQLpfs0+LVhhm0PzucHQMC6gA@mail.gmail.com>
Subject: Re: Access Beyond End of Device & Input/Output Errors
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi Qu,

Sorry for the late reply. I've had this system powered off since we
last talked, so no actions taken.

Yes, /dev/sde is dropping out occasionally, but these errors happen
regardless of whether it's in the array or not. Once the disk drops
out, it's completely gone until a reboot (no response from fdisk -l
info, brtfs dev scan, etc.).

The disk was manufactured in 2014, so it's quite old, and the
motherboard/cpu/integrated SATA controller) are about a year older
than that. SMART data on that disk don't indicate any serious
failures. I should probably replace that disk, or maybe just drop it
from the array . However, I'm concerned about the migration path. Any
sort of btrfs remove and btrfs add for new disks will require a btrfs
balance to maintain redundancy. The "access beyond end of device"
errors have shown different disks, not just /dev/sde (most kernel
messages are about sdf, but maybe that's just how messages are
logged), which makes me concerned my problem isn't related to a single
disk and any attempt at a balance could be catastrophic.

What's the best way to get this FS back to a healthy state?

Thanks,
Justin


On Sat, Aug 1, 2020 at 6:30 PM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>
>
>
> On 2020/8/1 =E4=B8=8B=E5=8D=887:56, Justin Brown wrote:
> > Hi Qu,
> >
> > Thanks for your continued help.
> >
> > dump-super:
> >
> > for i in a b d e f g; do x=3D$(sudo btrfs ins dump-super /dev/sd${i}1 |
> > grep dev_item.uuid | cut -f 3); echo "/dev/sd${i}1 $x"; done
> > /dev/sda1 cc3f9a00-bd69-4ceb-b6e5-4fb874be2aaf
> > /dev/sdb1 27e1cf24-9349-4f72-a23b-86668b2a9e78
> > /dev/sdd1 601d409e-8ffd-489c-91af-daf3e0cc9bd2
> > /dev/sde1 2908ebfb-e6b5-4991-b25d-32d1487ff6a4
> > /dev/sdf1 cb05aae6-6c03-49d3-b46d-bf51a0eb8cd0
>
> They match with the device size. So no chunk item beyond device boundary.
>
> >
> > btrfs check:
> >
> > sudo btrfs check /dev/sda1
> > Opening filesystem to check...
> > Checking filesystem on /dev/sda1
> > UUID: 51eef0c7-2977-4037-b271-3270ea22c7d9
> > [1/7] checking root items
> > [2/7] checking extents
> ...
> > failed to load free space cache for block group 92568662507520
> > failed to load free space cache for block group 92574031216640
> > ...
> > failed to load free space cache for block group 97722656817152
> > failed to load free space cache for block group 97728025526272
>
> This is interesting. Maybe that's related to the problem?
>
> > [4/7] checking fs roots
> > [5/7] checking only csums items (without verifying data)
> > [6/7] checking root refs
> > [7/7] checking quota groups skipped (not enabled on this FS)
>
> Great that all metadata are fine.
>
> > found 5148381876224 bytes used, no error found
> > total csum bytes: 4998903140
> > total tree bytes: 5301813248
> > total fs tree bytes: 96894976
> > total extent tree bytes: 41910272
> > btree space waste bytes: 135561977
> > file data blocks allocated: 8972043898880
> > referenced 5113155596288
> >
> > The alignment issue would be confined to performance, correct?
>
> Yep, only related to performance and some noisy warning for newer kernel.
> Not a big problem yet.
>
> Since btrfs-check reports no obvious problem but free space cache
> problems, maybe btrfs repair --clear-space-cache v1 is worthy trying.
>
> BTW, since current kernel and btrfs-progs doesn't do restrict chunk
> check against device boundary, I'll add such checks to both kernel and
> progs soon.
>
> In the mean time, I also see the following dmesg showing that kernel
> failed to detect one device:
>
>   Aug 01 01:15:26 spaceman.fandingo.org kernel: BTRFS warning (device
>   sde1): devid 1 uuid cb05aae6-6c03-49d3-b46d-bf51a0eb8cd0 is missing
>
> Can you reproduce that problem? And if so, maybe try "btrfs device scan"
> and then mount again?
>
> Thanks,
> Qu
>
> >
> > Thanks,
> > Justin
> >
> > /dev/sdg1 1b938c84-eafd-4396-b06c-8a5bf1339840On Sat, Aug 1, 2020 at
> > 4:31 AM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
> >>
> >>
> >>
> >> On 2020/8/1 =E4=B8=8B=E5=8D=884:30, Justin Brown wrote:
> >>> Hi Qu,
> >>>
> >>> Thanks for the help.
> >>>
> >>> Here's is the lsblk -b:
> >>>
> >>> NAME MAJ:MIN RM SIZE RO TYPE MOUNTPOINT
> >>> sda 8:0 0 2000398934016 0 disk
> >>> =E2=94=94=E2=94=80sda1 8:1 0 2000397868544 0 part
> >>> sdb 8:16 0 8001563222016 0 disk
> >>> =E2=94=94=E2=94=80sdb1 8:17 0 8001562156544 0 part
> >>> sdc 8:32 0 120034123776 0 disk
> >>> =E2=94=9C=E2=94=80sdc1 8:33 0 1048576 0 part
> >>> =E2=94=9C=E2=94=80sdc2 8:34 0 524288000 0 part /boot
> >>> =E2=94=94=E2=94=80sdc3 8:35 0 119507255296 0 part /home
> >>> sdd 8:48 0 8001563222016 0 disk
> >>> =E2=94=94=E2=94=80sdd1 8:49 0 8001562156544 0 part
> >>> sde 8:64 0 2000398934016 0 disk
> >>> =E2=94=94=E2=94=80sde1 8:65 0 2000397868544 0 part
> >>> sdf 8:80 0 2000398934016 0 disk
> >>> =E2=94=94=E2=94=80sdf1 8:81 0 2000397868544 0 part /var/media
> >>> sdg 8:96 1 2000398934016 0 disk
> >>> =E2=94=94=E2=94=80sdg1 8:97 1 2000397868544 0 part
> >>>
> >>> The `btrfs ins...` output is quite long. I've attached it as a txt an=
d
> >>> also uploaded it at
> >>> https://gist.github.com/fandingo/aa345d6c6fa97162f810e86c9ab20d6a
> >>
> >>
> >> Thanks, this already shows some device size difference.
> >>
> >> But all of them are in fact just a little smaller than device size, th=
us
> >> it should be fine.
> >>
> >> Another problem I found is, it looks like either size or start of some
> >> partitions are not aligned to 4K.
> >>
> >> It may be a problem for 4K aligned hard disks, so it may worthy some
> >> concern after solving the btrfs problem.
> >>
> >> Would you please also provide some extra dump?
> >> - btrfs check /dev/sda1
> >>   It should detect any problems I missed
> >>
> >> - btrfs ins dump-super <device> | grep dev_item.uuid
> >>   It's a little hard to find which device owns to which device id.
> >>   So we need this dump of each btrfs device to make sure.
> >>
> >> Thanks,
> >> Qu
> >>
> >>
> >>>
> >>> Thanks,
> >>> Justin
> >>>
> >>> On Sat, Aug 1, 2020 at 2:02 AM Qu Wenruo <quwenruo.btrfs@gmx.com> wro=
te:
> >>>>
> >>>>
> >>>>
> >>>> On 2020/8/1 =E4=B8=8B=E5=8D=882:58, Qu Wenruo wrote:
> >>>>>
> >>>>>
> >>>>> On 2020/8/1 =E4=B8=8B=E5=8D=882:51, Justin Brown wrote:
> >>>>>> Hello,
> >>>>>>
> >>>>>> I've run into a strange problem that I haven't seen before, and I =
need
> >>>>>> some help. I started getting generic "input/output" errors on a co=
uple
> >>>>>> of files, and when I looked deeper, the kernel logs are full of
> >>>>>> messages like:
> >>>>>>
> >>>>>>     sd 5:0:0:0: [sdf] tag#29 access beyond end of device
> >>>>>
> >>>>> We had a new fix for trim. But according to your kernel message, it
> >>>>> doesn't look like the case.
> >>>>>
> >>>>> (No obvious tag showing it's trim/discard)
> >>>>>
> >>>>>>
> >>>>>> I've never seen anything like this before with any FS, so I figure=
d it
> >>>>>> was worth asking before I consider running the standard btrfs tool=
s.
> >>>>>> (I briefly started a scrub, but it was going crazy with uncorrecta=
ble
> >>>>>> errors, so I cancelled it.)
> >>>>>>
> >>>>>> Here's my system info:
> >>>>>>
> >>>>>> Fedora 32, kernel 5.7.7-200.fc32.x86_64
> >>>>>> btrfs-progs v5.7
> >>>>>>
> >>>>>> /etc/fstab entry:
> >>>>>> LABEL=3Dmedia /var/media btrfs subvol=3Dmedia,discard 0 2
> >>>>>>
> >>>>>> btrfs fi show /var/media/
> >>>>>> Label: 'media' uuid: 51eef0c7-2977-4037-b271-3270ea22c7d9
> >>>>>> Total devices 6 FS bytes used 4.68TiB
> >>>>>> devid 1 size 1.82TiB used 963.00GiB path /dev/sdf1
> >>>>>> devid 2 size 1.82TiB used 962.00GiB path /dev/sde1
> >>>>>> devid 4 size 1.82TiB used 963.00GiB path /dev/sdg1
> >>>>>> devid 6 size 1.82TiB used 962.03GiB path /dev/sda1
> >>>>>> devid 7 size 7.28TiB used 967.03GiB path /dev/sdb1
> >>>>>> devid 8 size 7.28TiB used 967.03GiB path /dev/sdd1
> >>>>>>
> >>>>>> btrfs fi df /var/media/
> >>>>>> Data, RAID5: total=3D4.69TiB, used=3D4.68TiB
> >>>>>> System, RAID1C3: total=3D32.00MiB, used=3D304.00KiB
> >>>>>> Metadata, RAID1C3: total=3D6.00GiB, used=3D4.94GiB
> >>>>>> GlobalReserve, single: total=3D512.00MiB, used=3D0.00B
> >>>>>>
> >>>>>> I can only mount -o degraded now. Here are the logs when mounting:
> >>>>>>
> >>>>>> Aug 01 01:15:26 spaceman.fandingo.org sudo[275572]: justin : TTY=
=3Dpts/0
> >>>>>> ; PWD=3D/home/justin ; USER=3Droot ; COMMAND=3D/usr/bin/mount -t b=
trfs -o
> >>>>>> degraded /dev/sda1 /var/media/
> >>>>>> Aug 01 01:15:26 spaceman.fandingo.org kernel: sd 5:0:0:0: [sdf] ta=
g#30
> >>>>>> access beyond end of device
> >>>>>> Aug 01 01:15:26 spaceman.fandingo.org kernel: blk_update_request: =
I/O
> >>>>>> error, dev sdf, sector 2176 op 0x0:(READ) flags 0x0 phys_seg 1 pri=
o
> >>>>>> class 0
> >>>>>
> >>>>> OK, it's read, not DISCARD, thus a completely different problem.
> >>>>>
> >>>>>
> >>>>>> Aug 01 01:15:26 spaceman.fandingo.org kernel: Buffer I/O error on =
dev
> >>>>>> sdf1, logical block 16, async page read
> >>>>>> Aug 01 01:15:26 spaceman.fandingo.org kernel: BTRFS info (device
> >>>>>> sde1): allowing degraded mounts
> >>>>>> Aug 01 01:15:26 spaceman.fandingo.org kernel: BTRFS info (device
> >>>>>> sde1): disk space caching is enabled
> >>>>>> Aug 01 01:15:26 spaceman.fandingo.org kernel: BTRFS warning (devic=
e
> >>>>>> sde1): devid 1 uuid cb05aae6-6c03-49d3-b46d-bf51a0eb8cd0 is missin=
g
> >>>>>> Aug 01 01:15:26 spaceman.fandingo.org kernel: BTRFS info (device
> >>>>>> sde1): bdev /dev/sdf1 errs: wr 4458026, rd 14571, flush 0, corrupt=
 0,
> >>>>>> gen 0
> >>>>>>
> >>>>>> It seems like only relatively recently written files are encounter=
ing
> >>>>>> I/O errors. If I `cat` one of the problematic files when the FS is
> >>>>>> mounted normally, I see a ton of this:
> >>>>>>
> >>>>>> Aug 01 01:13:49 spaceman.fandingo.org kernel: sd 5:0:0:0: [sdf] ta=
g#26
> >>>>>> access beyond end of device
> >>>>>> Aug 01 01:13:49 spaceman.fandingo.org kernel: sd 5:0:0:0: [sdf] ta=
g#27
> >>>>>> access beyond end of device
> >>>>>> Aug 01 01:13:49 spaceman.fandingo.org kernel: sd 5:0:0:0: [sdf] ta=
g#28
> >>>>>> access beyond end of device
> >>>>>> Aug 01 01:13:49 spaceman.fandingo.org kernel: sd 5:0:0:0: [sdf] ta=
g#29
> >>>>>> access beyond end of device
> >>>>>> Aug 01 01:13:49 spaceman.fandingo.org kernel: sd 5:0:0:0: [sdf] ta=
g#30
> >>>>>> access beyond end of device
> >>>>>> Aug 01 01:13:49 spaceman.fandingo.org kernel: sd 5:0:0:0: [sdf] ta=
g#0
> >>>>>> access beyond end of device
> >>>>>> Aug 01 01:13:49 spaceman.fandingo.org kernel: sd 5:0:0:0: [sdf] ta=
g#1
> >>>>>> access beyond end of device
> >>>>>> Aug 01 01:13:49 spaceman.fandingo.org kernel: sd 5:0:0:0: [sdf] ta=
g#13
> >>>>>> access beyond end of device
> >>>>>> Aug 01 01:13:49 spaceman.fandingo.org kernel: sd 5:0:0:0: [sdf] ta=
g#2
> >>>>>> access beyond end of device
> >>>>>>
> >>>>>> Now that I'm remounted in -o degraded, I'm getting more comprehens=
ible
> >>>>>> warnings, but it still results in I/O read failures:
> >>>>>>
> >>>>>> Aug 01 01:31:53 spaceman.fandingo.org kernel: BTRFS warning (devic=
e
> >>>>>> sde1): csum failed root 2820 ino 747435 off 99942400 csum 0x8941f9=
98
> >>>>>> expected csum 0xbe3f80a4 mirror 2
> >>>>>> Aug 01 01:31:53 spaceman.fandingo.org kernel: BTRFS warning (devic=
e
> >>>>>> sde1): csum failed root 2820 ino 747435 off 99946496 csum 0x8941f9=
98
> >>>>>> expected csum 0x9c36a6b4 mirror 2
> >>>>>> Aug 01 01:31:53 spaceman.fandingo.org kernel: BTRFS warning (devic=
e
> >>>>>> sde1): csum failed root 2820 ino 747435 off 99950592 csum 0x8941f9=
98
> >>>>>> expected csum 0x44d30ca2 mirror 2
> >>>>>> Aug 01 01:31:53 spaceman.fandingo.org kernel: BTRFS warning (devic=
e
> >>>>>> sde1): csum failed root 2820 ino 747435 off 99958784 csum 0x8941f9=
98
> >>>>>> expected csum 0xc0f08acc mirror 2
> >>>>>> Aug 01 01:31:53 spaceman.fandingo.org kernel: BTRFS warning (devic=
e
> >>>>>> sde1): csum failed root 2820 ino 747435 off 99954688 csum 0x8941f9=
98
> >>>>>> expected csum 0xcb11db59 mirror 2
> >>>>>> Aug 01 01:31:53 spaceman.fandingo.org kernel: BTRFS warning (devic=
e
> >>>>>> sde1): csum failed root 2820 ino 747435 off 99962880 csum 0x8941f9=
98
> >>>>>> expected csum 0x8a4ee0aa mirror 2
> >>>>>> Aug 01 01:31:53 spaceman.fandingo.org kernel: BTRFS warning (devic=
e
> >>>>>> sde1): csum failed root 2820 ino 747435 off 99971072 csum 0x8941f9=
98
> >>>>>> expected csum 0xdfb79e85 mirror 2
> >>>>>> Aug 01 01:31:53 spaceman.fandingo.org kernel: BTRFS warning (devic=
e
> >>>>>> sde1): csum failed root 2820 ino 747435 off 99966976 csum 0x8941f9=
98
> >>>>>> expected csum 0xc14921a0 mirror 2
> >>>>>> Aug 01 01:31:53 spaceman.fandingo.org kernel: BTRFS warning (devic=
e
> >>>>>> sde1): csum failed root 2820 ino 747435 off 99975168 csum 0x8941f9=
98
> >>>>>> expected csum 0xf2fe8774 mirror 2
> >>>>>> Aug 01 01:31:53 spaceman.fandingo.org kernel: BTRFS warning (devic=
e
> >>>>>> sde1): csum failed root 2820 ino 747435 off 99979264 csum 0x8941f9=
98
> >>>>>> expected csum 0xae1cafd6 mirror 2
> >>>>>>
> >>>>>> Why trying to research this problem, I came across a Github issue
> >>>>>> https://github.com/kdave/btrfs-progs/issues/282 and a patch from Q=
u
> >>>>>> from yesterday ([PATCH] btrfs: trim: fix underflow in trim length =
to
> >>>>>> prevent access beyond device boundary). I do use the discard mount
> >>>>>> option, and I have a weekly fstrim.timer enabled. I did replace 2x=
2TB
> >>>>>> drives with the 2x8TB drives about 1 month ago, which involved a
> >>>>>> conversion to -d raid5 -m raid1c3, which I suppose could hit the s=
ame
> >>>>>> code paths that resize2fs would?
> >>>>>
> >>>>> The problem doesn't look like a trim one, but more likely some devi=
ce
> >>>>> boundary bug.
> >>>>>
> >>>>> Would you please provide the following info?
> >>>>> - btrfs ins dump-tree -t chunk /dev/sde1
> >>>>>   This contains the device info and chunk tree dump. Doesn't contai=
n
> >>>>>   any confidential info.
> >>>>>   We can use this info to determine if there is some chunk really b=
eyond
> >>>>>   device boundary.
> >>>>>   I guess some chunks are already beyond device boundary by somehow=
.
> >>>>
> >>>> And `lsblk -b` output.
> >>>>
> >>>> It may be possible that device size in btrfs doesn't match with the =
real
> >>>> device...
> >>>>>
> >>>>> Thanks,
> >>>>> Qu
> >>>>>
> >>>>>>
> >>>>>> Any advice on how to proceed would be greatly appreciated.
> >>>>>>
> >>>>>> Thanks,
> >>>>>> Justin
> >>>>>>
> >>>>>
> >>>>
> >>
>
