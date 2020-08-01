Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 676FC2351F1
	for <lists+linux-btrfs@lfdr.de>; Sat,  1 Aug 2020 13:57:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728628AbgHAL5C (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 1 Aug 2020 07:57:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728505AbgHAL5C (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sat, 1 Aug 2020 07:57:02 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6339C06174A
        for <linux-btrfs@vger.kernel.org>; Sat,  1 Aug 2020 04:57:01 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id t6so22073541ljk.9
        for <linux-btrfs@vger.kernel.org>; Sat, 01 Aug 2020 04:57:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fandingo-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=UfsSel88aQKfw8qHmBIKAp/m6KToT9JOEp4PPQAImts=;
        b=RHDHQ823w5BGvtOEZaGutdtWaI02zwpD26mQBynrhYHp5G4ptRfAMNpZB8Geiq3Zv7
         BdGeyvh+0zWBayH2ebOWhqGvpI7g9V1h8PMPwbjpA80SoGbI8aNjBd2wt8xt8HCXNRZU
         fA/VORU+skkziyt1ZXAUZG7auN0GXwMTGvNVjeiofoNeAvpc/5s9nqEUYJrNbIPWPyXo
         D3F2nFZdCLhZdXGRQ2i1Em7ldxlWZ8Wvj567jcb732jSkOvbXRcpHPUNRdtURwEV1klV
         x72yB0fnVrm361sF9FeBMXQ2F8LthyEhes7mmxyLvmj9RZkVIR3xF+4gh9qzDLRfBnWg
         db7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=UfsSel88aQKfw8qHmBIKAp/m6KToT9JOEp4PPQAImts=;
        b=Wr4/PAcCwNR4C0+Ex7Haamlha+xPOZhIQ+UTPikiK9Ep227aM+iRcMhF3B+BD7E7qP
         Zg5BcHEySNbryp3sOlQgWYYh5ZHQXJMxrS/4JJGhWqIfhb3txtQLCoJGiHKFCDpErNml
         GXPOdTTl9XvjoOB4i2k2HKexuwYTLHpd+F+RFnxg0/1NO9TUUgVhug3GlVWhtEIjRcVN
         57NkVZSjOpbMYcJsHkP2X/oBzqJP1+SvZQ6N6+OXIKMIV1nRDT4u7tbgXQpEW+4iqr55
         er3tkCta5U+CIEkpAHjEfRHAuRvCp7mk2TBCSrIk0airyeTOvOxuWTw8JzD1zzSQQB+K
         9Oag==
X-Gm-Message-State: AOAM532OgIC5BVhNxc7glN7qePpaKK0Y6KYuzmsHkf9gXtzMzHkla4oZ
        3tuhf6HnNDdFimKAfKIUYfh5ptz6Ya3bBipLWH/uxPmtG8k=
X-Google-Smtp-Source: ABdhPJwuSk9ZFsIPsJeOdK9COheFzMcM6ZhxOLlqY3Yn/tpdliEntkW265VXBs3nyFH9zrP/xGFKuvvvpKpqk2jPHv8=
X-Received: by 2002:a2e:7210:: with SMTP id n16mr4009509ljc.262.1596283019872;
 Sat, 01 Aug 2020 04:56:59 -0700 (PDT)
MIME-Version: 1.0
References: <CAKZK7uwRs_tf6htRtJvw3kNhyNPMJ-juA6_WSJo+PbQA7f40Cg@mail.gmail.com>
 <8e17a4d1-6555-15ba-808c-dd867d7ecbcb@gmx.com> <4f21b4c4-430e-59eb-068c-231cf3bc492d@gmx.com>
 <CAKZK7uzmg19NDjGPPAxXKu7LJ-7ZdHu2cad22csj_chr2qxMJg@mail.gmail.com> <2061ec67-a5a4-07c6-fe5e-8464feb272aa@gmx.com>
In-Reply-To: <2061ec67-a5a4-07c6-fe5e-8464feb272aa@gmx.com>
From:   Justin Brown <Justin.Brown@fandingo.org>
Date:   Sat, 1 Aug 2020 06:56:46 -0500
Message-ID: <CAKZK7uwFFpxiwA=Ye1VpqvkonAER=T-a2i_h_yGwpkieaeXcjg@mail.gmail.com>
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

Thanks for your continued help.

dump-super:

for i in a b d e f g; do x=3D$(sudo btrfs ins dump-super /dev/sd${i}1 |
grep dev_item.uuid | cut -f 3); echo "/dev/sd${i}1 $x"; done
/dev/sda1 cc3f9a00-bd69-4ceb-b6e5-4fb874be2aaf
/dev/sdb1 27e1cf24-9349-4f72-a23b-86668b2a9e78
/dev/sdd1 601d409e-8ffd-489c-91af-daf3e0cc9bd2
/dev/sde1 2908ebfb-e6b5-4991-b25d-32d1487ff6a4
/dev/sdf1 cb05aae6-6c03-49d3-b46d-bf51a0eb8cd0

btrfs check:

sudo btrfs check /dev/sda1
Opening filesystem to check...
Checking filesystem on /dev/sda1
UUID: 51eef0c7-2977-4037-b271-3270ea22c7d9
[1/7] checking root items
[2/7] checking extents
WARNING: unaligned total_bytes detected for devid 2, have
2000397868544 should be aligned to 4096
WARNING: this is OK for older kernel, but may cause kernel warning for
newer kernels
WARNING: this can be fixed by 'btrfs rescue fix-device-size'
WARNING: unaligned total_bytes detected for devid 4, have
2000397868544 should be aligned to 4096
WARNING: this is OK for older kernel, but may cause kernel warning for
newer kernels
WARNING: this can be fixed by 'btrfs rescue fix-device-size'
WARNING: unaligned total_bytes detected for devid 6, have
2000397868544 should be aligned to 4096
WARNING: this is OK for older kernel, but may cause kernel warning for
newer kernels
WARNING: this can be fixed by 'btrfs rescue fix-device-size'
WARNING: minor unaligned/mismatch device size detected
WARNING: recommended to use 'btrfs rescue fix-device-size' to fix it
failed to load free space cache for block group 92568662507520
failed to load free space cache for block group 92574031216640
...
failed to load free space cache for block group 97722656817152
failed to load free space cache for block group 97728025526272
[4/7] checking fs roots
[5/7] checking only csums items (without verifying data)
[6/7] checking root refs
[7/7] checking quota groups skipped (not enabled on this FS)
found 5148381876224 bytes used, no error found
total csum bytes: 4998903140
total tree bytes: 5301813248
total fs tree bytes: 96894976
total extent tree bytes: 41910272
btree space waste bytes: 135561977
file data blocks allocated: 8972043898880
referenced 5113155596288

The alignment issue would be confined to performance, correct?

Thanks,
Justin

/dev/sdg1 1b938c84-eafd-4396-b06c-8a5bf1339840On Sat, Aug 1, 2020 at
4:31 AM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>
>
>
> On 2020/8/1 =E4=B8=8B=E5=8D=884:30, Justin Brown wrote:
> > Hi Qu,
> >
> > Thanks for the help.
> >
> > Here's is the lsblk -b:
> >
> > NAME MAJ:MIN RM SIZE RO TYPE MOUNTPOINT
> > sda 8:0 0 2000398934016 0 disk
> > =E2=94=94=E2=94=80sda1 8:1 0 2000397868544 0 part
> > sdb 8:16 0 8001563222016 0 disk
> > =E2=94=94=E2=94=80sdb1 8:17 0 8001562156544 0 part
> > sdc 8:32 0 120034123776 0 disk
> > =E2=94=9C=E2=94=80sdc1 8:33 0 1048576 0 part
> > =E2=94=9C=E2=94=80sdc2 8:34 0 524288000 0 part /boot
> > =E2=94=94=E2=94=80sdc3 8:35 0 119507255296 0 part /home
> > sdd 8:48 0 8001563222016 0 disk
> > =E2=94=94=E2=94=80sdd1 8:49 0 8001562156544 0 part
> > sde 8:64 0 2000398934016 0 disk
> > =E2=94=94=E2=94=80sde1 8:65 0 2000397868544 0 part
> > sdf 8:80 0 2000398934016 0 disk
> > =E2=94=94=E2=94=80sdf1 8:81 0 2000397868544 0 part /var/media
> > sdg 8:96 1 2000398934016 0 disk
> > =E2=94=94=E2=94=80sdg1 8:97 1 2000397868544 0 part
> >
> > The `btrfs ins...` output is quite long. I've attached it as a txt and
> > also uploaded it at
> > https://gist.github.com/fandingo/aa345d6c6fa97162f810e86c9ab20d6a
>
>
> Thanks, this already shows some device size difference.
>
> But all of them are in fact just a little smaller than device size, thus
> it should be fine.
>
> Another problem I found is, it looks like either size or start of some
> partitions are not aligned to 4K.
>
> It may be a problem for 4K aligned hard disks, so it may worthy some
> concern after solving the btrfs problem.
>
> Would you please also provide some extra dump?
> - btrfs check /dev/sda1
>   It should detect any problems I missed
>
> - btrfs ins dump-super <device> | grep dev_item.uuid
>   It's a little hard to find which device owns to which device id.
>   So we need this dump of each btrfs device to make sure.
>
> Thanks,
> Qu
>
>
> >
> > Thanks,
> > Justin
> >
> > On Sat, Aug 1, 2020 at 2:02 AM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote=
:
> >>
> >>
> >>
> >> On 2020/8/1 =E4=B8=8B=E5=8D=882:58, Qu Wenruo wrote:
> >>>
> >>>
> >>> On 2020/8/1 =E4=B8=8B=E5=8D=882:51, Justin Brown wrote:
> >>>> Hello,
> >>>>
> >>>> I've run into a strange problem that I haven't seen before, and I ne=
ed
> >>>> some help. I started getting generic "input/output" errors on a coup=
le
> >>>> of files, and when I looked deeper, the kernel logs are full of
> >>>> messages like:
> >>>>
> >>>>     sd 5:0:0:0: [sdf] tag#29 access beyond end of device
> >>>
> >>> We had a new fix for trim. But according to your kernel message, it
> >>> doesn't look like the case.
> >>>
> >>> (No obvious tag showing it's trim/discard)
> >>>
> >>>>
> >>>> I've never seen anything like this before with any FS, so I figured =
it
> >>>> was worth asking before I consider running the standard btrfs tools.
> >>>> (I briefly started a scrub, but it was going crazy with uncorrectabl=
e
> >>>> errors, so I cancelled it.)
> >>>>
> >>>> Here's my system info:
> >>>>
> >>>> Fedora 32, kernel 5.7.7-200.fc32.x86_64
> >>>> btrfs-progs v5.7
> >>>>
> >>>> /etc/fstab entry:
> >>>> LABEL=3Dmedia /var/media btrfs subvol=3Dmedia,discard 0 2
> >>>>
> >>>> btrfs fi show /var/media/
> >>>> Label: 'media' uuid: 51eef0c7-2977-4037-b271-3270ea22c7d9
> >>>> Total devices 6 FS bytes used 4.68TiB
> >>>> devid 1 size 1.82TiB used 963.00GiB path /dev/sdf1
> >>>> devid 2 size 1.82TiB used 962.00GiB path /dev/sde1
> >>>> devid 4 size 1.82TiB used 963.00GiB path /dev/sdg1
> >>>> devid 6 size 1.82TiB used 962.03GiB path /dev/sda1
> >>>> devid 7 size 7.28TiB used 967.03GiB path /dev/sdb1
> >>>> devid 8 size 7.28TiB used 967.03GiB path /dev/sdd1
> >>>>
> >>>> btrfs fi df /var/media/
> >>>> Data, RAID5: total=3D4.69TiB, used=3D4.68TiB
> >>>> System, RAID1C3: total=3D32.00MiB, used=3D304.00KiB
> >>>> Metadata, RAID1C3: total=3D6.00GiB, used=3D4.94GiB
> >>>> GlobalReserve, single: total=3D512.00MiB, used=3D0.00B
> >>>>
> >>>> I can only mount -o degraded now. Here are the logs when mounting:
> >>>>
> >>>> Aug 01 01:15:26 spaceman.fandingo.org sudo[275572]: justin : TTY=3Dp=
ts/0
> >>>> ; PWD=3D/home/justin ; USER=3Droot ; COMMAND=3D/usr/bin/mount -t btr=
fs -o
> >>>> degraded /dev/sda1 /var/media/
> >>>> Aug 01 01:15:26 spaceman.fandingo.org kernel: sd 5:0:0:0: [sdf] tag#=
30
> >>>> access beyond end of device
> >>>> Aug 01 01:15:26 spaceman.fandingo.org kernel: blk_update_request: I/=
O
> >>>> error, dev sdf, sector 2176 op 0x0:(READ) flags 0x0 phys_seg 1 prio
> >>>> class 0
> >>>
> >>> OK, it's read, not DISCARD, thus a completely different problem.
> >>>
> >>>
> >>>> Aug 01 01:15:26 spaceman.fandingo.org kernel: Buffer I/O error on de=
v
> >>>> sdf1, logical block 16, async page read
> >>>> Aug 01 01:15:26 spaceman.fandingo.org kernel: BTRFS info (device
> >>>> sde1): allowing degraded mounts
> >>>> Aug 01 01:15:26 spaceman.fandingo.org kernel: BTRFS info (device
> >>>> sde1): disk space caching is enabled
> >>>> Aug 01 01:15:26 spaceman.fandingo.org kernel: BTRFS warning (device
> >>>> sde1): devid 1 uuid cb05aae6-6c03-49d3-b46d-bf51a0eb8cd0 is missing
> >>>> Aug 01 01:15:26 spaceman.fandingo.org kernel: BTRFS info (device
> >>>> sde1): bdev /dev/sdf1 errs: wr 4458026, rd 14571, flush 0, corrupt 0=
,
> >>>> gen 0
> >>>>
> >>>> It seems like only relatively recently written files are encounterin=
g
> >>>> I/O errors. If I `cat` one of the problematic files when the FS is
> >>>> mounted normally, I see a ton of this:
> >>>>
> >>>> Aug 01 01:13:49 spaceman.fandingo.org kernel: sd 5:0:0:0: [sdf] tag#=
26
> >>>> access beyond end of device
> >>>> Aug 01 01:13:49 spaceman.fandingo.org kernel: sd 5:0:0:0: [sdf] tag#=
27
> >>>> access beyond end of device
> >>>> Aug 01 01:13:49 spaceman.fandingo.org kernel: sd 5:0:0:0: [sdf] tag#=
28
> >>>> access beyond end of device
> >>>> Aug 01 01:13:49 spaceman.fandingo.org kernel: sd 5:0:0:0: [sdf] tag#=
29
> >>>> access beyond end of device
> >>>> Aug 01 01:13:49 spaceman.fandingo.org kernel: sd 5:0:0:0: [sdf] tag#=
30
> >>>> access beyond end of device
> >>>> Aug 01 01:13:49 spaceman.fandingo.org kernel: sd 5:0:0:0: [sdf] tag#=
0
> >>>> access beyond end of device
> >>>> Aug 01 01:13:49 spaceman.fandingo.org kernel: sd 5:0:0:0: [sdf] tag#=
1
> >>>> access beyond end of device
> >>>> Aug 01 01:13:49 spaceman.fandingo.org kernel: sd 5:0:0:0: [sdf] tag#=
13
> >>>> access beyond end of device
> >>>> Aug 01 01:13:49 spaceman.fandingo.org kernel: sd 5:0:0:0: [sdf] tag#=
2
> >>>> access beyond end of device
> >>>>
> >>>> Now that I'm remounted in -o degraded, I'm getting more comprehensib=
le
> >>>> warnings, but it still results in I/O read failures:
> >>>>
> >>>> Aug 01 01:31:53 spaceman.fandingo.org kernel: BTRFS warning (device
> >>>> sde1): csum failed root 2820 ino 747435 off 99942400 csum 0x8941f998
> >>>> expected csum 0xbe3f80a4 mirror 2
> >>>> Aug 01 01:31:53 spaceman.fandingo.org kernel: BTRFS warning (device
> >>>> sde1): csum failed root 2820 ino 747435 off 99946496 csum 0x8941f998
> >>>> expected csum 0x9c36a6b4 mirror 2
> >>>> Aug 01 01:31:53 spaceman.fandingo.org kernel: BTRFS warning (device
> >>>> sde1): csum failed root 2820 ino 747435 off 99950592 csum 0x8941f998
> >>>> expected csum 0x44d30ca2 mirror 2
> >>>> Aug 01 01:31:53 spaceman.fandingo.org kernel: BTRFS warning (device
> >>>> sde1): csum failed root 2820 ino 747435 off 99958784 csum 0x8941f998
> >>>> expected csum 0xc0f08acc mirror 2
> >>>> Aug 01 01:31:53 spaceman.fandingo.org kernel: BTRFS warning (device
> >>>> sde1): csum failed root 2820 ino 747435 off 99954688 csum 0x8941f998
> >>>> expected csum 0xcb11db59 mirror 2
> >>>> Aug 01 01:31:53 spaceman.fandingo.org kernel: BTRFS warning (device
> >>>> sde1): csum failed root 2820 ino 747435 off 99962880 csum 0x8941f998
> >>>> expected csum 0x8a4ee0aa mirror 2
> >>>> Aug 01 01:31:53 spaceman.fandingo.org kernel: BTRFS warning (device
> >>>> sde1): csum failed root 2820 ino 747435 off 99971072 csum 0x8941f998
> >>>> expected csum 0xdfb79e85 mirror 2
> >>>> Aug 01 01:31:53 spaceman.fandingo.org kernel: BTRFS warning (device
> >>>> sde1): csum failed root 2820 ino 747435 off 99966976 csum 0x8941f998
> >>>> expected csum 0xc14921a0 mirror 2
> >>>> Aug 01 01:31:53 spaceman.fandingo.org kernel: BTRFS warning (device
> >>>> sde1): csum failed root 2820 ino 747435 off 99975168 csum 0x8941f998
> >>>> expected csum 0xf2fe8774 mirror 2
> >>>> Aug 01 01:31:53 spaceman.fandingo.org kernel: BTRFS warning (device
> >>>> sde1): csum failed root 2820 ino 747435 off 99979264 csum 0x8941f998
> >>>> expected csum 0xae1cafd6 mirror 2
> >>>>
> >>>> Why trying to research this problem, I came across a Github issue
> >>>> https://github.com/kdave/btrfs-progs/issues/282 and a patch from Qu
> >>>> from yesterday ([PATCH] btrfs: trim: fix underflow in trim length to
> >>>> prevent access beyond device boundary). I do use the discard mount
> >>>> option, and I have a weekly fstrim.timer enabled. I did replace 2x2T=
B
> >>>> drives with the 2x8TB drives about 1 month ago, which involved a
> >>>> conversion to -d raid5 -m raid1c3, which I suppose could hit the sam=
e
> >>>> code paths that resize2fs would?
> >>>
> >>> The problem doesn't look like a trim one, but more likely some device
> >>> boundary bug.
> >>>
> >>> Would you please provide the following info?
> >>> - btrfs ins dump-tree -t chunk /dev/sde1
> >>>   This contains the device info and chunk tree dump. Doesn't contain
> >>>   any confidential info.
> >>>   We can use this info to determine if there is some chunk really bey=
ond
> >>>   device boundary.
> >>>   I guess some chunks are already beyond device boundary by somehow.
> >>
> >> And `lsblk -b` output.
> >>
> >> It may be possible that device size in btrfs doesn't match with the re=
al
> >> device...
> >>>
> >>> Thanks,
> >>> Qu
> >>>
> >>>>
> >>>> Any advice on how to proceed would be greatly appreciated.
> >>>>
> >>>> Thanks,
> >>>> Justin
> >>>>
> >>>
> >>
>
