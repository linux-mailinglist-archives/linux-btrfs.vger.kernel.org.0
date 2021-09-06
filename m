Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EBA5401504
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Sep 2021 04:36:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238866AbhIFCgd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 5 Sep 2021 22:36:33 -0400
Received: from mail-40136.protonmail.ch ([185.70.40.136]:56232 "EHLO
        mail-40136.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232050AbhIFCgb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 5 Sep 2021 22:36:31 -0400
Date:   Mon, 06 Sep 2021 02:35:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me; s=protonmail;
        t=1630895723; bh=vBBFB2zTVTKdTly3FindnWd4IRk4E6HS7vJq67bg0Qc=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=pJSktkIJTY77VI2qe4Aalmy8WhMo7593t/wcRV+8WE4PfB1irFLqBzCoudebVH5G0
         VMLsQbDOjTksEHElwcgSkUKE/icMIg6jOa7TF2zwIeEvFomiMQeyXHDqTCUZ2qD6Ai
         hwX+2fyeT0rzM/m7EiSEjf40XAX2oB7Ds4x4chnl0uFxctZvXBU6FP1ATsmfbT/BH8
         9BM2fAIingykM/gt3dhSOid/5XJ2avF0uftmhSUg2OEoJ4KOv8MiU+AtAa8tYz4n9/
         oWc1vh6eYGQNVp72+bK/oWIK9Pr2Mjcb3jvKe3Ki6fq5A0f9M3PYHNuOAZLxQRKmpu
         aVeind7d9jZcQ==
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
From:   ahipp0 <ahipp0@pm.me>
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Reply-To: ahipp0 <ahipp0@pm.me>
Subject: Re: BTRFS critical: corrupt leaf; BTRFS warning csum failed, expected csum 0x00000000 on AMD Ryzen 7 4800H, Samsung SSD 970 EVO Plus
Message-ID: <ozcaaGlwEFFj_mq4ZFf_hu1RHtOGruGz8Dwb8HHPEUhCn8Sn3G5BhbJxsMefPbtwacd-dcCJmCv6TbdX1Fdx4r-J_GoHa1rAbB4L4QQWZb0=@pm.me>
In-Reply-To: <01bb7749-eccd-5a3e-eee3-3320c89ce075@gmx.com>
References: <IZ0izVVsQVN4TIg_nsujavw6xz3UG-k0C53QTbeghmAryLDm5vf13M_UyrvBZ9tgDT5Mh8VXrMKBfGNju1_FBaCksUTcqZRnfuRydexvfvA=@pm.me> <01bb7749-eccd-5a3e-eee3-3320c89ce075@gmx.com>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha512; boundary="------076d19a5de27d11b8ac345f9e8e21ced4b24bf168fb1f9bd99e81542e6c765ba"; charset=utf-8
X-Spam-Status: No, score=-1.2 required=10.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF shortcircuit=no
        autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
        mailout.protonmail.ch
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------076d19a5de27d11b8ac345f9e8e21ced4b24bf168fb1f9bd99e81542e6c765ba
Content-Type: multipart/mixed;boundary=---------------------67cc37ddd58b32695b3693e0838d7c15

-----------------------67cc37ddd58b32695b3693e0838d7c15
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;charset=utf-8

Qu,

Thank you so much for taking a look!

Please, see my comments inline below.

On Sunday, September 5th, 2021 at 9:08 PM, Qu wrote:
> On 2021/9/5 =E4=B8=8B=E5=8D=883:34, ahipp0 wrote:
> =


> > Hi!
> > =


> > I started having various fun BTRFS warnings/errors/critical messages a=
ll of a sudden
> > after downloading and extracting linux-5.14.1.tar.xz on a fairly new (=
~1TiB read/written) Samsung SSD 970 EVO Plus 500GB.
> > The laptop was resumed from suspend-to-disk ~30 minutes prior to that,=
 I think.
> > =


> > Hardware:
> > TUXEDO Pulse 14 - Gen1
> > CPU: AMD Ryzen 7 4800H
> > RAM: 32GiB
> > Disk: Samsung SSD 970 EVO Plus 500GB
> > Distro: Kubuntu 20.04.2
> > Kernel: 5.11.x
> =


> I'm pretty sure you have used the btrfs partition for a while, as the
> corrupted tree block would be rejected by kernel starting from v5.11.
> =


> Thus such corrupted tree block should not be written to disk, thus the
> problem must be there for a while before you upgrading to v5.11 kernel.
> =



Fair enough, it's been like 3 months approximately.
Looking at the logs, it seems I created the filesystem with 5.8 kernel.

6/06 -- install of 5.8.0-55.62~20.04.1  -- this is when the filesystem was=
 created
6/26 -- upgrade to 5.8.0-59.66~20.04.1
7/22 -- upgrade to 5.8.0-63.71~20.04.1
8/07 -- upgrade to 5.11.0-25.27~20.04.1
8/19 -- upgrade to 5.11.0-27.29~20.04.1

I think, a good chunk of data was written while on 5.8 kernel,
but probably 30% on 5.11 (a wild guess).

<snip>

> > =


> > In the past, I also noticed odd things like ldconfig hanging or not pi=
cking up updated libraries are suspend-to-disk.
> > Simply rebooting helped in such cases.
> > The swap partition is on the same disk. (as a separate partition, not =
a file)
> > I also started using a new power profile recently, which disables half=
 of the CPU cores when on battery power.
> > (but hibernation also offlines all non-boot CPUs while preparing for s=
uspend-to-disk)
> > What could have caused the filesystem corruption?
> =


> From the dmesg, at least one block group for metadata is corrupted, it
> may explain why one tree block can't be read, as it may point to some
> invalid location thus got all zero.
>
> I believe the problem exists way before v5.11.x, as in v5.11, btrfs has =


> the ability to detect tons of new problems and reject such incorrect
> metadata from reaching disk.

Ah, cool, that's good to know that 5.11 does a lot more sanity checking!

> Thus it should be a problem/bug caused by old kernel.
> =


> Furthermore, I didn't see any obvious bitflip, thus bad memory is less
> possible.

That's good!

> > Is there a way to repair the filesystem?
> =


> As expected, from the btrfs-check output, extent tree is corrupted.
> =


> But thankfully, the data should be all safe.
> =


> So the first thing is to backup all your important data.
> =


> Then try "btrfs check --mode=3Dlowmem" to get a more human readable erro=
r
> report, and we can start from that to determine if it can be repaired.

Sure, please see below.

$ btrfs check --mode=3Dlowmem /dev/nvme0n1p4
Opening filesystem to check...
Checking filesystem on /dev/nvme0n1p4
UUID: 2b69016b-e03b-478a-84cd-f794eddfebd5
[1/7] checking root items
[2/7] checking extents
[3/7] checking free space cache
block group 2169503744 has wrong amount of free space, free space cache ha=
s 10440704 block group has 10346496
ERROR: free space cache has more free space than block group item, this co=
uld leads to serious corruption, please contact btrfs developers
failed to load free space cache for block group 2169503744
[4/7] checking fs roots
ERROR: root 257 EXTENT_DATA[31924 5689344] csum missing, have: 36864, expe=
cted: 40960
ERROR: errors found in fs roots
found 71205916672 bytes used, error(s) found
total csum bytes: 69299516
total tree bytes: 212975616
total fs tree bytes: 113672192
total extent tree bytes: 14909440
btree space waste bytes: 42172819
file data blocks allocated: 86083526656
referenced 70815563776 =




> But so far, I'm a little optimistic about a working repair.

Makes me optimistic as well. :)

> > How safe is it to continue using this particular filesystem after/if i=
t's repaired on this drive?
> =


> It's safe to mount it read-only.
> It's not going to work well to read-write mount it, as btrfs will abort
> transaction just as you already see in the dmesg.

Oh, even after repairing it?
Or is it yet to be seen if it can be repaired?

> Thankfully with more and more sanity check introduced in recent kernels,
> btrfs can handle such corrupted fs without crashing the whole kernel.
> =


> So at least you can try to grab the data without crashing the kernel.

Yeah, that's definitely _very_ helpful as I was able to backup all the imp=
ortant stuff seemingly with no problems.


> > How safe is it to keep using BTRFS on this drive going forward (even a=
fter creating a new filesystem)?
> =


> As long as you're using v5.11 and newer kernel, btrfs is very strict on
> any data it writes back to disk, thus it can even detect quite some
> memory bitflips.
> =


> So unless there is a proof of the SSD is bad, you're pretty safe to
> continue use the disk.
> =


> And I don't see anything special related to the SSD, thus you're pretty
> safe to go.

Good to hear!

I started suspecting something with TRIM/discard support in the SSD/driver=
 after seeing these all zero checksums,
but your explanation that it's just because of the corrupt tree makes more=
 sense.

I also saw another thread on the mailing list (from Martin)
about quite a similar (from my point of view) issue on a similar system (A=
MD-based, Samsung 980 SSD) with similar usage (suspend-to-disk),
so trying to figure out if it's the drive issue, a driver issue, suspend-t=
o-disk issue, or a combination of these.
So far, suspend-to-disk seems to be the main suspect (or it somehow trigge=
rs issues elsewhere)
as I saw strange behavior upon resume from hibernation, but never on a cle=
an reboot.


> > I've backed up important files,
> > so I'll be glad to try various suggestions.
> > =


> > Also, I'll keep using ext4 on this drive for now and will keep an eye =
on it.
> > I think I was able to resolve the "corrupt leaf" issue by deleting aff=
ected files
> =


> Nope, there is no way to solve it just using the btrfs kernel module.
> =


> Btrfs refuses to read such corrupted tree block at all, thus no way to
> modify it.
> =


> Unless you're using a much older kernel, but then you lost all the new
> sanity checks in v5.11, thus not recommended.

Hm, I don't remember for sure now,
but chances are that I deleted those files when booting from a LiveUSB,
which used kernel 5.10.61.
(I didn't know that 5.11 is so much more strict, otherwise I would have fo=
und another bootable ISO)
This would explain how I could have deleted them.

But overall, I was mostly following instructions here:
https://lore.kernel.org/linux-btrfs/75c522e9-88ff-0b9d-1ede-b524388d42d1@g=
mx.com/



> Thanks,
> =


> Qu
> =


> > (the Linux kernel sources I was unpacking while I hit the issue),
> > =


> > because "btrfs ins logical-resolve" can't find the file anymore:
> > =


> > $ btrfs ins logical-resolve 1376043008 /mnt/hippo/
> > =


> > ERROR: logical ino ioctl: No such file or directory
> > =


> > However, checksum and "btrfs check" errors make me seriously worried.
> > =


> > This is the earliest BTRFS warning I see in the logs:
> > =


> > Sep 4 14:04:51 hippo-tuxedo kernel: [ 19.338196] BTRFS warning (device=
 nvme0n1p4): block group 2169503744 has wrong amount of free space
> > =


> > Sep 4 14:04:51 hippo-tuxedo kernel: [ 19.338202] BTRFS warning (device=
 nvme0n1p4): failed to load free space cache for block group 2169503744, r=
ebuilding it now
> > =


> > Here's the first "corrupt leaf" error:
> > =


> > Sep 4 23:44:25 hippo-tuxedo kernel: [ 9855.151911] BTRFS critical (dev=
ice nvme0n1p4): corrupt leaf: root=3D2 block=3D1376043008 slot=3D7 bg_star=
t=3D2169503744 bg_len=3D1073741824, invalid block group used, have 1073790=
976 expect [0, 1073741824)
> > =


> > Sep 4 23:44:25 hippo-tuxedo kernel: [ 9855.151925] BTRFS info (device =
nvme0n1p4): leaf 1376043008 gen 24254 total ptrs 121 free space 6994 owner=
 2
> > =


> > Sep 4 23:44:25 hippo-tuxedo kernel: [ 9855.151929] item 0 key (2169339=
904 169 0) itemoff 16250 itemsize 33
> > =


> > Sep 4 23:44:25 hippo-tuxedo kernel: [ 9855.151932] extent refs 1 gen 2=
0692 flags 2
> > =


> > Sep 4 23:44:25 hippo-tuxedo kernel: [ 9855.151933] ref#0: tree block b=
ackref root 7
> > =


> > Sep 4 23:44:25 hippo-tuxedo kernel: [ 9855.151936] item 1 key (2169356=
288 169 0) itemoff 16217 itemsize 33
> > =


> > Sep 4 23:44:25 hippo-tuxedo kernel: [ 9855.151938] extent refs 1 gen 2=
0692 flags 2
> > =


> > Sep 4 23:44:25 hippo-tuxedo kernel: [ 9855.151939] ref#0: tree block b=
ackref root 7
> > =


> > Sep 4 23:44:25 hippo-tuxedo kernel: [ 9855.151940] item 2 key (2169372=
672 169 0) itemoff 16184 itemsize 33
> > =


> > Sep 4 23:44:25 hippo-tuxedo kernel: [ 9855.151942] extent refs 1 gen 2=
0692 flags 2
> > =


> > Sep 4 23:44:25 hippo-tuxedo kernel: [ 9855.151943] ref#0: tree block b=
ackref root 7
> > =


> > Sep 4 23:44:25 hippo-tuxedo kernel: [ 9855.151945] item 3 key (2169405=
440 169 0) itemoff 16151 itemsize 33
> > =


> > Sep 4 23:44:25 hippo-tuxedo kernel: [ 9855.151946] extent refs 1 gen 2=
0692 flags 2
> > =


> > Sep 4 23:44:25 hippo-tuxedo kernel: [ 9855.151947] ref#0: tree block b=
ackref root 7
> > =


> > Sep 4 23:44:25 hippo-tuxedo kernel: [ 9855.151949] item 4 key (2169421=
824 169 0) itemoff 16118 itemsize 33
> > =


> > Sep 4 23:44:25 hippo-tuxedo kernel: [ 9855.151950] extent refs 1 gen 2=
0692 flags 2
> > =


> > Sep 4 23:44:25 hippo-tuxedo kernel: [ 9855.151951] ref#0: tree block b=
ackref root 7
> > =


> > Sep 4 23:44:25 hippo-tuxedo kernel: [ 9855.151953] item 5 key (2169470=
976 169 0) itemoff 16085 itemsize 33
> > =


> > Sep 4 23:44:25 hippo-tuxedo kernel: [ 9855.151954] extent refs 1 gen 2=
4164 flags 2
> > =


> > Sep 4 23:44:25 hippo-tuxedo kernel: [ 9855.151955] ref#0: tree block b=
ackref root 2
> > =


> > Sep 4 23:44:25 hippo-tuxedo kernel: [ 9855.151957] item 6 key (2169503=
744 168 16429056) itemoff 16032 itemsize 53
> > =


> > Sep 4 23:44:25 hippo-tuxedo kernel: [ 9855.151959] extent refs 1 gen 4=
7 flags 1
> > =


> > Sep 4 23:44:25 hippo-tuxedo kernel: [ 9855.151960] ref#0: extent data =
backref root 257 objectid 20379 offset 0 count 1
> > =


> > Sep 4 23:44:25 hippo-tuxedo kernel: [ 9855.151962] item 7 key (2169503=
744 192 1073741824) itemoff 16008 itemsize 24
> > =


> > Sep 4 23:44:25 hippo-tuxedo kernel: [ 9855.151964] block group used 10=
73790976 chunk_objectid 256 flags 1
> > =


> > Sep 4 23:44:25 hippo-tuxedo kernel: [ 9855.151966] item 8 key (2185932=
800 168 241664) itemoff 15955 itemsize 53
> > =


> > Sep 4 23:44:25 hippo-tuxedo kernel: [ 9855.151968] extent refs 1 gen 4=
7 flags 1
> > =


> > Sep 4 23:44:25 hippo-tuxedo kernel: [ 9855.151969] ref#0: extent data =
backref root 257 objectid 20417 offset 0 count 1
> > =


> > Sep 4 23:44:25 hippo-tuxedo kernel: [ 9855.151971] item 9 key (2186174=
464 168 299008) itemoff 15902 itemsize 53
> > =


> > Sep 4 23:44:25 hippo-tuxedo kernel: [ 9855.151973] extent refs 1 gen 4=
7 flags 1
> > =


> > Sep 4 23:44:25 hippo-tuxedo kernel: [ 9855.151974] ref#0: extent data =
backref root 257 objectid 20418 offset 0 count 1
> > =


> > Sep 4 23:44:25 hippo-tuxedo kernel: [ 9855.151976] item 10 key (218647=
3472 168 135168) itemoff 15849 itemsize 53
> > =


> > Sep 4 23:44:25 hippo-tuxedo kernel: [ 9855.151977] extent refs 1 gen 4=
7 flags 1
> > =


> > Sep 4 23:44:25 hippo-tuxedo kernel: [ 9855.151978] ref#0: extent data =
backref root 257 objectid 20419 offset 0 count 1
> > =


> > ...
> > =


> > Sep 4 23:44:25 hippo-tuxedo kernel: [ 9855.152480] item 120 key (21952=
10240 168 4096) itemoff 10019 itemsize 53
> > =


> > Sep 4 23:44:25 hippo-tuxedo kernel: [ 9855.152481] extent refs 1 gen 4=
7 flags 1
> > =


> > Sep 4 23:44:25 hippo-tuxedo kernel: [ 9855.152482] ref#0: extent data =
backref root 257 objectid 20558 offset 0 count 1
> > =


> > Sep 4 23:44:25 hippo-tuxedo kernel: [ 9855.152484] BTRFS error (device=
 nvme0n1p4): block=3D1376043008 write time tree block corruption detected
> > =


> > Sep 4 23:44:25 hippo-tuxedo kernel: [ 9855.152661] BTRFS: error (devic=
e nvme0n1p4) in btrfs_commit_transaction:2339: errno=3D-5 IO failure (Erro=
r while writing out transaction)
> > =


> > Sep 4 23:44:25 hippo-tuxedo kernel: [ 9855.152663] BTRFS info (device =
nvme0n1p4): forced readonly
> > =


> > Sep 4 23:44:25 hippo-tuxedo kernel: [ 9855.152664] BTRFS warning (devi=
ce nvme0n1p4): Skipping commit of aborted transaction.
> > =


> > Sep 4 23:44:25 hippo-tuxedo kernel: [ 9855.152665] BTRFS: error (devic=
e nvme0n1p4) in cleanup_transaction:1939: errno=3D-5 IO failure
> > =


> > I hit these csum 0x00000000 errors while trying to backup the files to=
 ext4 partition on the same disk:
> > =


> > Sep 5 00:12:26 hippo-tuxedo kernel: [ 891.475516] BTRFS info (device n=
vme0n1p4): disk space caching is enabled
> > =


> > Sep 5 00:12:26 hippo-tuxedo kernel: [ 891.475523] BTRFS info (device n=
vme0n1p4): has skinny extents
> > =


> > Sep 5 00:12:26 hippo-tuxedo kernel: [ 891.494832] BTRFS info (device n=
vme0n1p4): enabling ssd optimizations
> > =


> > Sep 5 00:16:42 hippo-tuxedo kernel: [ 1147.627577] BTRFS warning (devi=
ce nvme0n1p4): csum hole found for disk bytenr range [3111845888, 31118499=
84)
> > =


> > Sep 5 00:16:42 hippo-tuxedo kernel: [ 1147.627805] BTRFS warning (devi=
ce nvme0n1p4): csum failed root 257 ino 31924 off 5726208 csum 0x55271056 =
expected csum 0x00000000 mirror 1
> > =


> > Sep 5 00:16:42 hippo-tuxedo kernel: [ 1147.627814] BTRFS error (device=
 nvme0n1p4): bdev /dev/nvme0n1p4 errs: wr 0, rd 0, flush 0, corrupt 1, gen=
 0
> > =


> > Sep 5 00:16:42 hippo-tuxedo kernel: [ 1147.628316] BTRFS warning (devi=
ce nvme0n1p4): csum hole found for disk bytenr range [3112013824, 31120179=
20)
> > =


> > Sep 5 00:16:42 hippo-tuxedo kernel: [ 1147.628931] BTRFS warning (devi=
ce nvme0n1p4): csum hole found for disk bytenr range [3112058880, 31120629=
76)
> > =


> > Sep 5 00:16:42 hippo-tuxedo kernel: [ 1147.628943] BTRFS warning (devi=
ce nvme0n1p4): csum hole found for disk bytenr range [3112083456, 31120875=
52)
> > =


> > Sep 5 00:16:42 hippo-tuxedo kernel: [ 1147.629210] BTRFS warning (devi=
ce nvme0n1p4): csum failed root 257 ino 31924 off 5894144 csum 0x45d7e010 =
expected csum 0x00000000 mirror 1
> > =


> > Sep 5 00:16:42 hippo-tuxedo kernel: [ 1147.629214] BTRFS error (device=
 nvme0n1p4): bdev /dev/nvme0n1p4 errs: wr 0, rd 0, flush 0, corrupt 2, gen=
 0
> > =


> > Sep 5 00:16:42 hippo-tuxedo kernel: [ 1147.629238] BTRFS warning (devi=
ce nvme0n1p4): csum failed root 257 ino 31924 off 5963776 csum 0x95b8b716 =
expected csum 0x00000000 mirror 1
> > =


> > Sep 5 00:16:42 hippo-tuxedo kernel: [ 1147.630311] BTRFS error (device=
 nvme0n1p4): bdev /dev/nvme0n1p4 errs: wr 0, rd 0, flush 0, corrupt 3, gen=
 0
> > =


> > Sep 5 00:16:42 hippo-tuxedo kernel: [ 1147.648130] BTRFS warning (devi=
ce nvme0n1p4): csum hole found for disk bytenr range [3111845888, 31118499=
84)
> > =


> > Sep 5 00:16:42 hippo-tuxedo kernel: [ 1147.648226] BTRFS warning (devi=
ce nvme0n1p4): csum failed root 257 ino 31924 off 5726208 csum 0x55271056 =
expected csum 0x00000000 mirror 1
> > =


> > Sep 5 00:16:42 hippo-tuxedo kernel: [ 1147.648234] BTRFS error (device=
 nvme0n1p4): bdev /dev/nvme0n1p4 errs: wr 0, rd 0, flush 0, corrupt 4, gen=
 0
> > =


> > Sep 5 00:16:42 hippo-tuxedo kernel: [ 1147.649275] BTRFS warning (devi=
ce nvme0n1p4): csum hole found for disk bytenr range [3111845888, 31118499=
84)
> > =


> > Sep 5 00:16:42 hippo-tuxedo kernel: [ 1147.649353] BTRFS warning (devi=
ce nvme0n1p4): csum failed root 257 ino 31924 off 5726208 csum 0x55271056 =
expected csum 0x00000000 mirror 1
> > =


> > Sep 5 00:16:42 hippo-tuxedo kernel: [ 1147.649357] BTRFS error (device=
 nvme0n1p4): bdev /dev/nvme0n1p4 errs: wr 0, rd 0, flush 0, corrupt 5, gen=
 0
> > =


> > Sep 5 00:16:42 hippo-tuxedo kernel: [ 1147.650397] BTRFS warning (devi=
ce nvme0n1p4): csum hole found for disk bytenr range [3111845888, 31118499=
84)
> > =


> > Sep 5 00:16:42 hippo-tuxedo kernel: [ 1147.650475] BTRFS warning (devi=
ce nvme0n1p4): csum failed root 257 ino 31924 off 5726208 csum 0x55271056 =
expected csum 0x00000000 mirror 1
> > =


> > Sep 5 00:16:42 hippo-tuxedo kernel: [ 1147.650478] BTRFS error (device=
 nvme0n1p4): bdev /dev/nvme0n1p4 errs: wr 0, rd 0, flush 0, corrupt 6, gen=
 0
> > =


> > Sep 5 00:16:42 hippo-tuxedo kernel: [ 1147.678142] BTRFS warning (devi=
ce nvme0n1p4): csum hole found for disk bytenr range [3111124992, 31111290=
88)
> > =


> > Sep 5 00:16:42 hippo-tuxedo kernel: [ 1147.678149] BTRFS warning (devi=
ce nvme0n1p4): csum hole found for disk bytenr range [3111276544, 31112806=
40)
> > =


> > Sep 5 00:16:42 hippo-tuxedo kernel: [ 1147.678151] BTRFS warning (devi=
ce nvme0n1p4): csum hole found for disk bytenr range [3111346176, 31113502=
72)
> > =


> > Sep 5 00:16:42 hippo-tuxedo kernel: [ 1147.680593] BTRFS warning (devi=
ce nvme0n1p4): csum failed root 257 ino 32063 off 39395328 csum 0xeeab29ce=
 expected csum 0x00000000 mirror 1
> > =


> > Sep 5 00:16:42 hippo-tuxedo kernel: [ 1147.680604] BTRFS error (device=
 nvme0n1p4): bdev /dev/nvme0n1p4 errs: wr 0, rd 0, flush 0, corrupt 7, gen=
 0
> > =


> > Sep 5 00:16:42 hippo-tuxedo kernel: [ 1147.686438] BTRFS warning (devi=
ce nvme0n1p4): csum failed root 257 ino 32063 off 39395328 csum 0xeeab29ce=
 expected csum 0x00000000 mirror 1
> > =


> > Sep 5 00:16:42 hippo-tuxedo kernel: [ 1147.686449] BTRFS error (device=
 nvme0n1p4): bdev /dev/nvme0n1p4 errs: wr 0, rd 0, flush 0, corrupt 8, gen=
 0
> > =


> > Sep 5 00:16:42 hippo-tuxedo kernel: [ 1147.687671] BTRFS warning (devi=
ce nvme0n1p4): csum failed root 257 ino 32063 off 39395328 csum 0xeeab29ce=
 expected csum 0x00000000 mirror 1
> > =


> > Sep 5 00:16:42 hippo-tuxedo kernel: [ 1147.687683] BTRFS error (device=
 nvme0n1p4): bdev /dev/nvme0n1p4 errs: wr 0, rd 0, flush 0, corrupt 9, gen=
 0
> > =


> > Sep 5 00:16:42 hippo-tuxedo kernel: [ 1147.688871] BTRFS warning (devi=
ce nvme0n1p4): csum failed root 257 ino 32063 off 39395328 csum 0xeeab29ce=
 expected csum 0x00000000 mirror 1
> > =


> > Sep 5 00:16:42 hippo-tuxedo kernel: [ 1147.688876] BTRFS error (device=
 nvme0n1p4): bdev /dev/nvme0n1p4 errs: wr 0, rd 0, flush 0, corrupt 10, ge=
n 0
> > =


> > Sep 5 00:17:05 hippo-tuxedo kernel: [ 1170.527686] BTRFS warning (devi=
ce nvme0n1p4): block group 2169503744 has wrong amount of free space
> > =


> > Sep 5 00:17:05 hippo-tuxedo kernel: [ 1170.527695] BTRFS warning (devi=
ce nvme0n1p4): failed to load free space cache for block group 2169503744,=
 rebuilding it now
> > =


> > $ uname -a
> > =


> > Linux hippo-tuxedo 5.11.0-27-generic #29~20.04.1-Ubuntu SMP Wed Aug 11=
 15:58:17 UTC 2021 x86_64 x86_64 x86_64 GNU/Linux
> > =


> > $ btrfs --version
> > =


> > btrfs-progs v5.4.1
> > =


> > $ btrfs fi show
> > =


> > Label: 'HIPPO' uuid: 2b69016b-e03b-478a-84cd-f794eddfebd5
> > =


> > Total devices 1 FS bytes used 66.32GiB
> > =


> > devid 1 size 256.00GiB used 95.02GiB path /dev/nvme0n1p4
> > =


> > $ btrfs fi df /mnt/hippo/
> > =


> > Data, single: total=3D94.01GiB, used=3D66.12GiB
> > =


> > System, single: total=3D4.00MiB, used=3D16.00KiB
> > =


> > Metadata, single: total=3D1.01GiB, used=3D203.09MiB
> > =


> > GlobalReserve, single: total=3D94.59MiB, used=3D0.00B
> > =


> > $ cat /etc/lsb-release
> > =


> > DISTRIB_ID=3DUbuntu
> > =


> > DISTRIB_RELEASE=3D20.04
> > =


> > DISTRIB_CODENAME=3Dfocal
> > =


> > DISTRIB_DESCRIPTION=3D"Ubuntu 20.04.2 LTS"
> > =


> > Mount options:
> > =


> > relatime,ssd,space_cache,subvolid=3D5,subvol=3Dandrey
> > =


> > $ btrfs check --readonly /dev/nvme0n1p4
> > =


> > Opening filesystem to check...
> > =


> > Checking filesystem on /dev/nvme0n1p4
> > =


> > UUID: 2b69016b-e03b-478a-84cd-f794eddfebd5
> > =


> > [1/7] checking root items
> > =


> > [2/7] checking extents
> > =


> > extent item 3109511168 has multiple extent items
> > =


> > ref mismatch on [3109511168 2105344] extent item 1, found 5
> > =


> > backref disk bytenr does not match extent record, bytenr=3D3109511168,=
 ref bytenr=3D3111489536
> > =


> > backref bytes do not match extent backref, bytenr=3D3109511168, ref by=
tes=3D2105344, backref bytes=3D8192
> > =


> > backref disk bytenr does not match extent record, bytenr=3D3109511168,=
 ref bytenr=3D3111436288
> > =


> > backref bytes do not match extent backref, bytenr=3D3109511168, ref by=
tes=3D2105344, backref bytes=3D16384
> > =


> > backref disk bytenr does not match extent record, bytenr=3D3109511168,=
 ref bytenr=3D3111260160
> > =


> > backref bytes do not match extent backref, bytenr=3D3109511168, ref by=
tes=3D2105344, backref bytes=3D8192
> > =


> > backref disk bytenr does not match extent record, bytenr=3D3109511168,=
 ref bytenr=3D3111411712
> > =


> > backref bytes do not match extent backref, bytenr=3D3109511168, ref by=
tes=3D2105344, backref bytes=3D12288
> > =


> > backpointer mismatch on [3109511168 2105344]
> > =


> > extent item 3111616512 has multiple extent items
> > =


> > ref mismatch on [3111616512 638976] extent item 25, found 26
> > =


> > backref disk bytenr does not match extent record, bytenr=3D3111616512,=
 ref bytenr=3D3112091648
> > =


> > backref bytes do not match extent backref, bytenr=3D3111616512, ref by=
tes=3D638976, backref bytes=3D8192
> > =


> > backpointer mismatch on [3111616512 638976]
> > =


> > extent item 3121950720 has multiple extent items
> > =


> > ref mismatch on [3121950720 2220032] extent item 1, found 4
> > =


> > backref disk bytenr does not match extent record, bytenr=3D3121950720,=
 ref bytenr=3D3124080640
> > =


> > backref bytes do not match extent backref, bytenr=3D3121950720, ref by=
tes=3D2220032, backref bytes=3D8192
> > =


> > backref disk bytenr does not match extent record, bytenr=3D3121950720,=
 ref bytenr=3D3124051968
> > =


> > backref bytes do not match extent backref, bytenr=3D3121950720, ref by=
tes=3D2220032, backref bytes=3D12288
> > =


> > backref disk bytenr does not match extent record, bytenr=3D3121950720,=
 ref bytenr=3D3123773440
> > =


> > backref bytes do not match extent backref, bytenr=3D3121950720, ref by=
tes=3D2220032, backref bytes=3D8192
> > =


> > backpointer mismatch on [3121950720 2220032]
> > =


> > extent item 3124252672 has multiple extent items
> > =


> > ref mismatch on [3124252672 208896] extent item 12, found 13
> > =


> > backref disk bytenr does not match extent record, bytenr=3D3124252672,=
 ref bytenr=3D3124428800
> > =


> > backref bytes do not match extent backref, bytenr=3D3124252672, ref by=
tes=3D208896, backref bytes=3D12288
> > =


> > backpointer mismatch on [3124252672 208896]
> > =


> > ERROR: errors found in extent allocation tree or chunk allocation
> > =


> > [3/7] checking free space cache
> > =


> > block group 2169503744 has wrong amount of free space, free space cach=
e has 10440704 block group has 10346496
> > =


> > ERROR: free space cache has more free space than block group item, thi=
s could leads to serious corruption, please contact btrfs developers
> > =


> > failed to load free space cache for block group 2169503744
> > =


> > [4/7] checking fs roots
> > =


> > root 257 inode 31924 errors 1000, some csum missing
> > =


> > ERROR: errors found in fs roots
> > =


> > found 71205822464 bytes used, error(s) found
> > =


> > total csum bytes: 69299516
> > =


> > total tree bytes: 212975616
> > =


> > total fs tree bytes: 113672192
> > =


> > total extent tree bytes: 14909440
> > =


> > btree space waste bytes: 42172819
> > =


> > file data blocks allocated: 86083526656
> > =


> > referenced 70815563776
> > =


> > $ smartctl --all /dev/nvme0
> > =


> > smartctl 7.1 2019-12-30 r5022 [x86_64-linux-5.11.0-27-generic] (local =
build)
> > =


> > Copyright (C) 2002-19, Bruce Allen, Christian Franke, www.smartmontool=
s.org
> > =


> > =3D=3D=3D START OF INFORMATION SECTION =3D=3D=3D
> > =


> > Model Number: Samsung SSD 970 EVO Plus 500GB
> > =


> > Serial Number: S4EVNX0NB29088Y
> > =


> > Firmware Version: 2B2QEXM7
> > =


> > PCI Vendor/Subsystem ID: 0x144d
> > =


> > IEEE OUI Identifier: 0x002538
> > =


> > Total NVM Capacity: 500,107,862,016 [500 GB]
> > =


> > Unallocated NVM Capacity: 0
> > =


> > Controller ID: 4
> > =


> > Number of Namespaces: 1
> > =


> > Namespace 1 Size/Capacity: 500,107,862,016 [500 GB]
> > =


> > Namespace 1 Utilization: 133,526,691,840 [133 GB]
> > =


> > Namespace 1 Formatted LBA Size: 512
> > =


> > Namespace 1 IEEE EUI-64: 002538 5b01b07633
> > =


> > Local Time is: Sun Sep 5 03:08:29 2021 EDT
> > =


> > Firmware Updates (0x16): 3 Slots, no Reset required
> > =


> > Optional Admin Commands (0x0017): Security Format Frmw_DL Self_Test
> > =


> > Optional NVM Commands (0x005f): Comp Wr_Unc DS_Mngmt Wr_Zero Sav/Sel_F=
eat Timestmp
> > =


> > Maximum Data Transfer Size: 512 Pages
> > =


> > Warning Comp. Temp. Threshold: 85 Celsius
> > =


> > Critical Comp. Temp. Threshold: 85 Celsius
> > =


> > Supported Power States
> > =


> > St Op Max Active Idle RL RT WL WT Ent_Lat Ex_Lat
> > =


> > 0 + 7.80W - - 0 0 0 0 0 0
> > =


> > 1 + 6.00W - - 1 1 1 1 0 0
> > =


> > 2 + 3.40W - - 2 2 2 2 0 0
> > =


> > 3 - 0.0700W - - 3 3 3 3 210 1200
> > =


> > 4 - 0.0100W - - 4 4 4 4 2000 8000
> > =


> > Supported LBA Sizes (NSID 0x1)
> > =


> > Id Fmt Data Metadt Rel_Perf
> > =


> > 0 + 512 0 0
> > =


> > =3D=3D=3D START OF SMART DATA SECTION =3D=3D=3D
> > =


> > SMART overall-health self-assessment test result: PASSED
> > =


> > SMART/Health Information (NVMe Log 0x02)
> > =


> > Critical Warning: 0x00
> > =


> > Temperature: 33 Celsius
> > =


> > Available Spare: 100%
> > =


> > Available Spare Threshold: 10%
> > =


> > Percentage Used: 0%
> > =


> > Data Units Read: 1,263,056 [646 GB]
> > =


> > Data Units Written: 1,381,709 [707 GB]
> > =


> > Host Read Commands: 27,814,722
> > =


> > Host Write Commands: 29,580,959
> > =


> > Controller Busy Time: 37
> > =


> > Power Cycles: 132
> > =


> > Power On Hours: 47
> > =


> > Unsafe Shutdowns: 13
> > =


> > Media and Data Integrity Errors: 0
> > =


> > Error Information Log Entries: 35
> > =


> > Warning Comp. Temperature Time: 0
> > =


> > Critical Comp. Temperature Time: 0
> > =


> > Temperature Sensor 1: 33 Celsius
> > =


> > Temperature Sensor 2: 30 Celsius
> > =


> > Error Information (NVMe Log 0x01, max 64 entries)
> > =


> > No Errors Logged
-----------------------67cc37ddd58b32695b3693e0838d7c15--

--------076d19a5de27d11b8ac345f9e8e21ced4b24bf168fb1f9bd99e81542e6c765ba
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wnUEARYKAAYFAmE1flgAIQkQansmvPyL2SsWIQSmC4s1WhXLLzG+OkVqeya8
/IvZK6orAP4taEzPrhLz4UF8F+LrbGTveTgcVDfzoNIAnzwYCEx1ogEA+mU8
mC7jL2izn1TcauSl06EnpPUdPpyWy6A4F5K8zwE=
=r/K8
-----END PGP SIGNATURE-----


--------076d19a5de27d11b8ac345f9e8e21ced4b24bf168fb1f9bd99e81542e6c765ba--

