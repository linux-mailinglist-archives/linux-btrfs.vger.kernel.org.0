Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A6A0400E96
	for <lists+linux-btrfs@lfdr.de>; Sun,  5 Sep 2021 09:34:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232304AbhIEHfZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 5 Sep 2021 03:35:25 -0400
Received: from mail-0301.mail-europe.com ([188.165.51.139]:53864 "EHLO
        mail-0301.mail-europe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbhIEHfY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 5 Sep 2021 03:35:24 -0400
Date:   Sun, 05 Sep 2021 07:34:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me; s=protonmail;
        t=1630827257; bh=13nHrFpXL/q6OV3lYd6S9fcpiJvNmq8naxjktz/l3Y8=;
        h=Date:To:From:Reply-To:Subject:From;
        b=B0xFNQbNEApMT54zuFseNPEaE+BeVpSrNRoBeyGGp5KsXb4NXGBApBQ4yx3uBo2v5
         gQl+DON6UHxbpZ6gnL6SyRfQds3zFLH4fbRavx4eeulcAM3dGF1YUWRDKwYiUH33KH
         Ka5dK1vI3VgSEJSUK2uy8vWci4TYTAuo1v2m3se3X3oL0Pq6vErdL9Z+OhS0xuSzsZ
         lMoZMX21iwKDviDWpQO2CArIoTRuKKANxdde/iRy0ltoksKiSQN+1jhJs55LzqQDIM
         mI83Pe3cVPmqpUrBBDIqcLnQ6BjDwxkUO0lL89Xvcc3dymYssWV4whzaZteqdvUAdR
         jBqASNASJZgPw==
To:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
From:   ahipp0 <ahipp0@pm.me>
Reply-To: ahipp0 <ahipp0@pm.me>
Subject: BTRFS critical: corrupt leaf; BTRFS warning csum failed, expected csum 0x00000000 on AMD Ryzen 7 4800H, Samsung SSD 970 EVO Plus
Message-ID: <IZ0izVVsQVN4TIg_nsujavw6xz3UG-k0C53QTbeghmAryLDm5vf13M_UyrvBZ9tgDT5Mh8VXrMKBfGNju1_FBaCksUTcqZRnfuRydexvfvA=@pm.me>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha512; boundary="------f7798869d4c97a4e0d18780704f782207f394c98d87c392d2145b43e3fd19658"; charset=utf-8
X-Spam-Status: No, score=-1.2 required=10.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF shortcircuit=no
        autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
        mailout.protonmail.ch
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------f7798869d4c97a4e0d18780704f782207f394c98d87c392d2145b43e3fd19658
Content-Type: multipart/mixed;boundary=---------------------bc54c2eb618a03b9fa5ba0bd51d296e2

-----------------------bc54c2eb618a03b9fa5ba0bd51d296e2
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;charset=utf-8

Hi!

I started having various fun BTRFS warnings/errors/critical messages all o=
f a sudden
after downloading and extracting linux-5.14.1.tar.xz on a fairly new (~1Ti=
B read/written) Samsung SSD 970 EVO Plus 500GB.

The laptop was resumed from suspend-to-disk ~30 minutes prior to that, I t=
hink.

Hardware:
TUXEDO Pulse 14 - Gen1
CPU: AMD Ryzen 7 4800H =


RAM: 32GiB
Disk: Samsung SSD 970 EVO Plus 500GB
Distro: Kubuntu 20.04.2
Kernel: 5.11.x

BTRFS is used on top of a regular GPT partition.
(luckily, not the rootfs, otherwise I wouldn't be able to write this email=
 that easily)
No LVM, no dm-crypt.

Please, see more information below.
Full kernel log for the past day is attached.

In the past, I also noticed odd things like ldconfig hanging or not pickin=
g up updated libraries are suspend-to-disk.
Simply rebooting helped in such cases.
The swap partition is on the same disk. (as a separate partition, not a fi=
le)

I also started using a new power profile recently, which disables half of =
the CPU cores when on battery power.
(but hibernation also offlines all non-boot CPUs while preparing for suspe=
nd-to-disk)

What could have caused the filesystem corruption?
Is there a way to repair the filesystem?
How safe is it to continue using this particular filesystem after/if it's =
repaired on this drive?
How safe is it to keep using BTRFS on this drive going forward (even after=
 creating a new filesystem)?

I've backed up important files,
so I'll be glad to try various suggestions.
Also, I'll keep using ext4 on this drive for now and will keep an eye on i=
t.

I think I was able to resolve the "corrupt leaf" issue by deleting affecte=
d files
(the Linux kernel sources I was unpacking while I hit the issue),
because "btrfs ins logical-resolve" can't find the file anymore:
$ btrfs ins logical-resolve 1376043008 /mnt/hippo/
ERROR: logical ino ioctl: No such file or directory

However, checksum and "btrfs check" errors make me seriously worried.

This is the earliest BTRFS warning I see in the logs:

Sep  4 14:04:51 hippo-tuxedo kernel: [   19.338196] BTRFS warning (device =
nvme0n1p4): block group 2169503744 has wrong amount of free space
Sep  4 14:04:51 hippo-tuxedo kernel: [   19.338202] BTRFS warning (device =
nvme0n1p4): failed to load free space cache for block group 2169503744, re=
building it now


Here's the first "corrupt leaf" error:

Sep  4 23:44:25 hippo-tuxedo kernel: [ 9855.151911] BTRFS critical (device=
 nvme0n1p4): corrupt leaf: root=3D2 block=3D1376043008 slot=3D7 bg_start=3D=
2169503744 bg_len=3D1073741824, invalid block group used, have 1073790976=
 expect [0, 1073741824)
Sep  4 23:44:25 hippo-tuxedo kernel: [ 9855.151925] BTRFS info (device nvm=
e0n1p4): leaf 1376043008 gen 24254 total ptrs 121 free space 6994 owner 2
Sep  4 23:44:25 hippo-tuxedo kernel: [ 9855.151929]     item 0 key (216933=
9904 169 0) itemoff 16250 itemsize 33
Sep  4 23:44:25 hippo-tuxedo kernel: [ 9855.151932]             extent ref=
s 1 gen 20692 flags 2
Sep  4 23:44:25 hippo-tuxedo kernel: [ 9855.151933]             ref#0: tre=
e block backref root 7
Sep  4 23:44:25 hippo-tuxedo kernel: [ 9855.151936]     item 1 key (216935=
6288 169 0) itemoff 16217 itemsize 33
Sep  4 23:44:25 hippo-tuxedo kernel: [ 9855.151938]             extent ref=
s 1 gen 20692 flags 2
Sep  4 23:44:25 hippo-tuxedo kernel: [ 9855.151939]             ref#0: tre=
e block backref root 7
Sep  4 23:44:25 hippo-tuxedo kernel: [ 9855.151940]     item 2 key (216937=
2672 169 0) itemoff 16184 itemsize 33
Sep  4 23:44:25 hippo-tuxedo kernel: [ 9855.151942]             extent ref=
s 1 gen 20692 flags 2
Sep  4 23:44:25 hippo-tuxedo kernel: [ 9855.151943]             ref#0: tre=
e block backref root 7
Sep  4 23:44:25 hippo-tuxedo kernel: [ 9855.151945]     item 3 key (216940=
5440 169 0) itemoff 16151 itemsize 33
Sep  4 23:44:25 hippo-tuxedo kernel: [ 9855.151946]             extent ref=
s 1 gen 20692 flags 2
Sep  4 23:44:25 hippo-tuxedo kernel: [ 9855.151947]             ref#0: tre=
e block backref root 7
Sep  4 23:44:25 hippo-tuxedo kernel: [ 9855.151949]     item 4 key (216942=
1824 169 0) itemoff 16118 itemsize 33
Sep  4 23:44:25 hippo-tuxedo kernel: [ 9855.151950]             extent ref=
s 1 gen 20692 flags 2
Sep  4 23:44:25 hippo-tuxedo kernel: [ 9855.151951]             ref#0: tre=
e block backref root 7
Sep  4 23:44:25 hippo-tuxedo kernel: [ 9855.151953]     item 5 key (216947=
0976 169 0) itemoff 16085 itemsize 33
Sep  4 23:44:25 hippo-tuxedo kernel: [ 9855.151954]             extent ref=
s 1 gen 24164 flags 2
Sep  4 23:44:25 hippo-tuxedo kernel: [ 9855.151955]             ref#0: tre=
e block backref root 2
Sep  4 23:44:25 hippo-tuxedo kernel: [ 9855.151957]     item 6 key (216950=
3744 168 16429056) itemoff 16032 itemsize 53
Sep  4 23:44:25 hippo-tuxedo kernel: [ 9855.151959]             extent ref=
s 1 gen 47 flags 1
Sep  4 23:44:25 hippo-tuxedo kernel: [ 9855.151960]             ref#0: ext=
ent data backref root 257 objectid 20379 offset 0 count 1
Sep  4 23:44:25 hippo-tuxedo kernel: [ 9855.151962]     item 7 key (216950=
3744 192 1073741824) itemoff 16008 itemsize 24
Sep  4 23:44:25 hippo-tuxedo kernel: [ 9855.151964]             block grou=
p used 1073790976 chunk_objectid 256 flags 1
Sep  4 23:44:25 hippo-tuxedo kernel: [ 9855.151966]     item 8 key (218593=
2800 168 241664) itemoff 15955 itemsize 53
Sep  4 23:44:25 hippo-tuxedo kernel: [ 9855.151968]             extent ref=
s 1 gen 47 flags 1
Sep  4 23:44:25 hippo-tuxedo kernel: [ 9855.151969]             ref#0: ext=
ent data backref root 257 objectid 20417 offset 0 count 1
Sep  4 23:44:25 hippo-tuxedo kernel: [ 9855.151971]     item 9 key (218617=
4464 168 299008) itemoff 15902 itemsize 53
Sep  4 23:44:25 hippo-tuxedo kernel: [ 9855.151973]             extent ref=
s 1 gen 47 flags 1
Sep  4 23:44:25 hippo-tuxedo kernel: [ 9855.151974]             ref#0: ext=
ent data backref root 257 objectid 20418 offset 0 count 1
Sep  4 23:44:25 hippo-tuxedo kernel: [ 9855.151976]     item 10 key (21864=
73472 168 135168) itemoff 15849 itemsize 53
Sep  4 23:44:25 hippo-tuxedo kernel: [ 9855.151977]             extent ref=
s 1 gen 47 flags 1
Sep  4 23:44:25 hippo-tuxedo kernel: [ 9855.151978]             ref#0: ext=
ent data backref root 257 objectid 20419 offset 0 count 1
...
Sep  4 23:44:25 hippo-tuxedo kernel: [ 9855.152480]     item 120 key (2195=
210240 168 4096) itemoff 10019 itemsize 53
Sep  4 23:44:25 hippo-tuxedo kernel: [ 9855.152481]             extent ref=
s 1 gen 47 flags 1
Sep  4 23:44:25 hippo-tuxedo kernel: [ 9855.152482]             ref#0: ext=
ent data backref root 257 objectid 20558 offset 0 count 1
Sep  4 23:44:25 hippo-tuxedo kernel: [ 9855.152484] BTRFS error (device nv=
me0n1p4): block=3D1376043008 write time tree block corruption detected
Sep  4 23:44:25 hippo-tuxedo kernel: [ 9855.152661] BTRFS: error (device n=
vme0n1p4) in btrfs_commit_transaction:2339: errno=3D-5 IO failure (Error w=
hile writing out transaction)
Sep  4 23:44:25 hippo-tuxedo kernel: [ 9855.152663] BTRFS info (device nvm=
e0n1p4): forced readonly
Sep  4 23:44:25 hippo-tuxedo kernel: [ 9855.152664] BTRFS warning (device =
nvme0n1p4): Skipping commit of aborted transaction.
Sep  4 23:44:25 hippo-tuxedo kernel: [ 9855.152665] BTRFS: error (device n=
vme0n1p4) in cleanup_transaction:1939: errno=3D-5 IO failure


I hit these csum 0x00000000 errors while trying to backup the files to ext=
4 partition on the same disk:

Sep  5 00:12:26 hippo-tuxedo kernel: [  891.475516] BTRFS info (device nvm=
e0n1p4): disk space caching is enabled
Sep  5 00:12:26 hippo-tuxedo kernel: [  891.475523] BTRFS info (device nvm=
e0n1p4): has skinny extents
Sep  5 00:12:26 hippo-tuxedo kernel: [  891.494832] BTRFS info (device nvm=
e0n1p4): enabling ssd optimizations
Sep  5 00:16:42 hippo-tuxedo kernel: [ 1147.627577] BTRFS warning (device =
nvme0n1p4): csum hole found for disk bytenr range [3111845888, 3111849984)
Sep  5 00:16:42 hippo-tuxedo kernel: [ 1147.627805] BTRFS warning (device =
nvme0n1p4): csum failed root 257 ino 31924 off 5726208 csum 0x55271056 exp=
ected csum 0x00000000 mirror 1
Sep  5 00:16:42 hippo-tuxedo kernel: [ 1147.627814] BTRFS error (device nv=
me0n1p4): bdev /dev/nvme0n1p4 errs: wr 0, rd 0, flush 0, corrupt 1, gen 0
Sep  5 00:16:42 hippo-tuxedo kernel: [ 1147.628316] BTRFS warning (device =
nvme0n1p4): csum hole found for disk bytenr range [3112013824, 3112017920)
Sep  5 00:16:42 hippo-tuxedo kernel: [ 1147.628931] BTRFS warning (device =
nvme0n1p4): csum hole found for disk bytenr range [3112058880, 3112062976)
Sep  5 00:16:42 hippo-tuxedo kernel: [ 1147.628943] BTRFS warning (device =
nvme0n1p4): csum hole found for disk bytenr range [3112083456, 3112087552)
Sep  5 00:16:42 hippo-tuxedo kernel: [ 1147.629210] BTRFS warning (device =
nvme0n1p4): csum failed root 257 ino 31924 off 5894144 csum 0x45d7e010 exp=
ected csum 0x00000000 mirror 1
Sep  5 00:16:42 hippo-tuxedo kernel: [ 1147.629214] BTRFS error (device nv=
me0n1p4): bdev /dev/nvme0n1p4 errs: wr 0, rd 0, flush 0, corrupt 2, gen 0
Sep  5 00:16:42 hippo-tuxedo kernel: [ 1147.629238] BTRFS warning (device =
nvme0n1p4): csum failed root 257 ino 31924 off 5963776 csum 0x95b8b716 exp=
ected csum 0x00000000 mirror 1
Sep  5 00:16:42 hippo-tuxedo kernel: [ 1147.630311] BTRFS error (device nv=
me0n1p4): bdev /dev/nvme0n1p4 errs: wr 0, rd 0, flush 0, corrupt 3, gen 0
Sep  5 00:16:42 hippo-tuxedo kernel: [ 1147.648130] BTRFS warning (device =
nvme0n1p4): csum hole found for disk bytenr range [3111845888, 3111849984)
Sep  5 00:16:42 hippo-tuxedo kernel: [ 1147.648226] BTRFS warning (device =
nvme0n1p4): csum failed root 257 ino 31924 off 5726208 csum 0x55271056 exp=
ected csum 0x00000000 mirror 1
Sep  5 00:16:42 hippo-tuxedo kernel: [ 1147.648234] BTRFS error (device nv=
me0n1p4): bdev /dev/nvme0n1p4 errs: wr 0, rd 0, flush 0, corrupt 4, gen 0
Sep  5 00:16:42 hippo-tuxedo kernel: [ 1147.649275] BTRFS warning (device =
nvme0n1p4): csum hole found for disk bytenr range [3111845888, 3111849984)
Sep  5 00:16:42 hippo-tuxedo kernel: [ 1147.649353] BTRFS warning (device =
nvme0n1p4): csum failed root 257 ino 31924 off 5726208 csum 0x55271056 exp=
ected csum 0x00000000 mirror 1
Sep  5 00:16:42 hippo-tuxedo kernel: [ 1147.649357] BTRFS error (device nv=
me0n1p4): bdev /dev/nvme0n1p4 errs: wr 0, rd 0, flush 0, corrupt 5, gen 0
Sep  5 00:16:42 hippo-tuxedo kernel: [ 1147.650397] BTRFS warning (device =
nvme0n1p4): csum hole found for disk bytenr range [3111845888, 3111849984)
Sep  5 00:16:42 hippo-tuxedo kernel: [ 1147.650475] BTRFS warning (device =
nvme0n1p4): csum failed root 257 ino 31924 off 5726208 csum 0x55271056 exp=
ected csum 0x00000000 mirror 1
Sep  5 00:16:42 hippo-tuxedo kernel: [ 1147.650478] BTRFS error (device nv=
me0n1p4): bdev /dev/nvme0n1p4 errs: wr 0, rd 0, flush 0, corrupt 6, gen 0
Sep  5 00:16:42 hippo-tuxedo kernel: [ 1147.678142] BTRFS warning (device =
nvme0n1p4): csum hole found for disk bytenr range [3111124992, 3111129088)
Sep  5 00:16:42 hippo-tuxedo kernel: [ 1147.678149] BTRFS warning (device =
nvme0n1p4): csum hole found for disk bytenr range [3111276544, 3111280640)
Sep  5 00:16:42 hippo-tuxedo kernel: [ 1147.678151] BTRFS warning (device =
nvme0n1p4): csum hole found for disk bytenr range [3111346176, 3111350272)
Sep  5 00:16:42 hippo-tuxedo kernel: [ 1147.680593] BTRFS warning (device =
nvme0n1p4): csum failed root 257 ino 32063 off 39395328 csum 0xeeab29ce ex=
pected csum 0x00000000 mirror 1
Sep  5 00:16:42 hippo-tuxedo kernel: [ 1147.680604] BTRFS error (device nv=
me0n1p4): bdev /dev/nvme0n1p4 errs: wr 0, rd 0, flush 0, corrupt 7, gen 0
Sep  5 00:16:42 hippo-tuxedo kernel: [ 1147.686438] BTRFS warning (device =
nvme0n1p4): csum failed root 257 ino 32063 off 39395328 csum 0xeeab29ce ex=
pected csum 0x00000000 mirror 1
Sep  5 00:16:42 hippo-tuxedo kernel: [ 1147.686449] BTRFS error (device nv=
me0n1p4): bdev /dev/nvme0n1p4 errs: wr 0, rd 0, flush 0, corrupt 8, gen 0
Sep  5 00:16:42 hippo-tuxedo kernel: [ 1147.687671] BTRFS warning (device =
nvme0n1p4): csum failed root 257 ino 32063 off 39395328 csum 0xeeab29ce ex=
pected csum 0x00000000 mirror 1
Sep  5 00:16:42 hippo-tuxedo kernel: [ 1147.687683] BTRFS error (device nv=
me0n1p4): bdev /dev/nvme0n1p4 errs: wr 0, rd 0, flush 0, corrupt 9, gen 0
Sep  5 00:16:42 hippo-tuxedo kernel: [ 1147.688871] BTRFS warning (device =
nvme0n1p4): csum failed root 257 ino 32063 off 39395328 csum 0xeeab29ce ex=
pected csum 0x00000000 mirror 1
Sep  5 00:16:42 hippo-tuxedo kernel: [ 1147.688876] BTRFS error (device nv=
me0n1p4): bdev /dev/nvme0n1p4 errs: wr 0, rd 0, flush 0, corrupt 10, gen 0
Sep  5 00:17:05 hippo-tuxedo kernel: [ 1170.527686] BTRFS warning (device =
nvme0n1p4): block group 2169503744 has wrong amount of free space
Sep  5 00:17:05 hippo-tuxedo kernel: [ 1170.527695] BTRFS warning (device =
nvme0n1p4): failed to load free space cache for block group 2169503744, re=
building it now


$ uname -a
Linux hippo-tuxedo 5.11.0-27-generic #29~20.04.1-Ubuntu SMP Wed Aug 11 15:=
58:17 UTC 2021 x86_64 x86_64 x86_64 GNU/Linux

$ btrfs --version
btrfs-progs v5.4.1

$ btrfs fi show
Label: 'HIPPO'  uuid: 2b69016b-e03b-478a-84cd-f794eddfebd5
Total devices 1 FS bytes used 66.32GiB
devid    1 size 256.00GiB used 95.02GiB path /dev/nvme0n1p4

$ btrfs fi df /mnt/hippo/
Data, single: total=3D94.01GiB, used=3D66.12GiB
System, single: total=3D4.00MiB, used=3D16.00KiB
Metadata, single: total=3D1.01GiB, used=3D203.09MiB
GlobalReserve, single: total=3D94.59MiB, used=3D0.00B

$ cat /etc/lsb-release
DISTRIB_ID=3DUbuntu
DISTRIB_RELEASE=3D20.04
DISTRIB_CODENAME=3Dfocal
DISTRIB_DESCRIPTION=3D"Ubuntu 20.04.2 LTS"

Mount options:
relatime,ssd,space_cache,subvolid=3D5,subvol=3Dandrey

$ btrfs check --readonly /dev/nvme0n1p4
Opening filesystem to check...
Checking filesystem on /dev/nvme0n1p4
UUID: 2b69016b-e03b-478a-84cd-f794eddfebd5
[1/7] checking root items
[2/7] checking extents
extent item 3109511168 has multiple extent items
ref mismatch on [3109511168 2105344] extent item 1, found 5
backref disk bytenr does not match extent record, bytenr=3D3109511168, ref=
 bytenr=3D3111489536
backref bytes do not match extent backref, bytenr=3D3109511168, ref bytes=3D=
2105344, backref bytes=3D8192
backref disk bytenr does not match extent record, bytenr=3D3109511168, ref=
 bytenr=3D3111436288
backref bytes do not match extent backref, bytenr=3D3109511168, ref bytes=3D=
2105344, backref bytes=3D16384
backref disk bytenr does not match extent record, bytenr=3D3109511168, ref=
 bytenr=3D3111260160
backref bytes do not match extent backref, bytenr=3D3109511168, ref bytes=3D=
2105344, backref bytes=3D8192
backref disk bytenr does not match extent record, bytenr=3D3109511168, ref=
 bytenr=3D3111411712
backref bytes do not match extent backref, bytenr=3D3109511168, ref bytes=3D=
2105344, backref bytes=3D12288
backpointer mismatch on [3109511168 2105344]
extent item 3111616512 has multiple extent items
ref mismatch on [3111616512 638976] extent item 25, found 26
backref disk bytenr does not match extent record, bytenr=3D3111616512, ref=
 bytenr=3D3112091648
backref bytes do not match extent backref, bytenr=3D3111616512, ref bytes=3D=
638976, backref bytes=3D8192
backpointer mismatch on [3111616512 638976]
extent item 3121950720 has multiple extent items
ref mismatch on [3121950720 2220032] extent item 1, found 4
backref disk bytenr does not match extent record, bytenr=3D3121950720, ref=
 bytenr=3D3124080640
backref bytes do not match extent backref, bytenr=3D3121950720, ref bytes=3D=
2220032, backref bytes=3D8192
backref disk bytenr does not match extent record, bytenr=3D3121950720, ref=
 bytenr=3D3124051968
backref bytes do not match extent backref, bytenr=3D3121950720, ref bytes=3D=
2220032, backref bytes=3D12288
backref disk bytenr does not match extent record, bytenr=3D3121950720, ref=
 bytenr=3D3123773440
backref bytes do not match extent backref, bytenr=3D3121950720, ref bytes=3D=
2220032, backref bytes=3D8192
backpointer mismatch on [3121950720 2220032]
extent item 3124252672 has multiple extent items
ref mismatch on [3124252672 208896] extent item 12, found 13
backref disk bytenr does not match extent record, bytenr=3D3124252672, ref=
 bytenr=3D3124428800
backref bytes do not match extent backref, bytenr=3D3124252672, ref bytes=3D=
208896, backref bytes=3D12288
backpointer mismatch on [3124252672 208896]
ERROR: errors found in extent allocation tree or chunk allocation
[3/7] checking free space cache
block group 2169503744 has wrong amount of free space, free space cache ha=
s 10440704 block group has 10346496
ERROR: free space cache has more free space than block group item, this co=
uld leads to serious corruption, please contact btrfs developers
failed to load free space cache for block group 2169503744
[4/7] checking fs roots
root 257 inode 31924 errors 1000, some csum missing
ERROR: errors found in fs roots
found 71205822464 bytes used, error(s) found
total csum bytes: 69299516
total tree bytes: 212975616
total fs tree bytes: 113672192
total extent tree bytes: 14909440
btree space waste bytes: 42172819
file data blocks allocated: 86083526656
 referenced 70815563776

$ smartctl --all /dev/nvme0
smartctl 7.1 2019-12-30 r5022 [x86_64-linux-5.11.0-27-generic] (local buil=
d)
Copyright (C) 2002-19, Bruce Allen, Christian Franke, www.smartmontools.or=
g

=3D=3D=3D START OF INFORMATION SECTION =3D=3D=3D
Model Number:                       Samsung SSD 970 EVO Plus 500GB
Serial Number:                      S4EVNX0NB29088Y
Firmware Version:                   2B2QEXM7
PCI Vendor/Subsystem ID:            0x144d
IEEE OUI Identifier:                0x002538
Total NVM Capacity:                 500,107,862,016 [500 GB]
Unallocated NVM Capacity:           0
Controller ID:                      4
Number of Namespaces:               1
Namespace 1 Size/Capacity:          500,107,862,016 [500 GB]
Namespace 1 Utilization:            133,526,691,840 [133 GB]
Namespace 1 Formatted LBA Size:     512
Namespace 1 IEEE EUI-64:            002538 5b01b07633
Local Time is:                      Sun Sep  5 03:08:29 2021 EDT
Firmware Updates (0x16):            3 Slots, no Reset required
Optional Admin Commands (0x0017):   Security Format Frmw_DL Self_Test
Optional NVM Commands (0x005f):     Comp Wr_Unc DS_Mngmt Wr_Zero Sav/Sel_F=
eat Timestmp
Maximum Data Transfer Size:         512 Pages
Warning  Comp. Temp. Threshold:     85 Celsius
Critical Comp. Temp. Threshold:     85 Celsius

Supported Power States
St Op     Max   Active     Idle   RL RT WL WT  Ent_Lat  Ex_Lat
0 +     7.80W       -        -    0  0  0  0        0       0
1 +     6.00W       -        -    1  1  1  1        0       0
2 +     3.40W       -        -    2  2  2  2        0       0
3 -   0.0700W       -        -    3  3  3  3      210    1200
4 -   0.0100W       -        -    4  4  4  4     2000    8000

Supported LBA Sizes (NSID 0x1)
Id Fmt  Data  Metadt  Rel_Perf
0 +     512       0         0

=3D=3D=3D START OF SMART DATA SECTION =3D=3D=3D
SMART overall-health self-assessment test result: PASSED

SMART/Health Information (NVMe Log 0x02)
Critical Warning:                   0x00
Temperature:                        33 Celsius
Available Spare:                    100%
Available Spare Threshold:          10%
Percentage Used:                    0%
Data Units Read:                    1,263,056 [646 GB]
Data Units Written:                 1,381,709 [707 GB]
Host Read Commands:                 27,814,722
Host Write Commands:                29,580,959
Controller Busy Time:               37
Power Cycles:                       132
Power On Hours:                     47
Unsafe Shutdowns:                   13
Media and Data Integrity Errors:    0
Error Information Log Entries:      35
Warning  Comp. Temperature Time:    0
Critical Comp. Temperature Time:    0
Temperature Sensor 1:               33 Celsius
Temperature Sensor 2:               30 Celsius

Error Information (NVMe Log 0x01, max 64 entries)
No Errors Logged


Thank you,
Andrey
-----------------------bc54c2eb618a03b9fa5ba0bd51d296e2
Content-Type: application/x-xz; filename="btrfs-errors-kern.log.xz"; name="btrfs-errors-kern.log.xz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="btrfs-errors-kern.log.xz"; name="btrfs-errors-kern.log.xz"

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
Z/sCAAAAAARZWg==
-----------------------bc54c2eb618a03b9fa5ba0bd51d296e2--

--------f7798869d4c97a4e0d18780704f782207f394c98d87c392d2145b43e3fd19658
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wnUEARYKAAYFAmE0cuYAIQkQansmvPyL2SsWIQSmC4s1WhXLLzG+OkVqeya8
/IvZKx5OAP9S3uavKgHjeIInXq1BhO3L2dG4BQu8KY32dmRJ1X+g3wEAs1Q5
qreVxpEsW/bM1Dm6b4IDl+qbOzU5dVlVvzvbmgY=
=QHbM
-----END PGP SIGNATURE-----


--------f7798869d4c97a4e0d18780704f782207f394c98d87c392d2145b43e3fd19658--

