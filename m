Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C87734BCFA
	for <lists+linux-btrfs@lfdr.de>; Sun, 28 Mar 2021 17:41:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230447AbhC1Pkj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 28 Mar 2021 11:40:39 -0400
Received: from mout.web.de ([212.227.15.3]:44531 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230395AbhC1Pkh (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 28 Mar 2021 11:40:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1616946036;
        bh=67Hj4gKMdI/kWpA2URC850oGokxsZS3GG8FS0xloNx0=;
        h=X-UI-Sender-Class:From:To:Subject:Date;
        b=Ntd4wDc2XqPLNuqD/qTjaM3Z5CyynNQxyUzqNnpWHFPcliL267D2BfDAla4v/NNlx
         pBVbRofD59hpjFO2EXyoQwEf01Xox2Ch57x8R0kizwyGh8Gn4SXOZby0w5D5W5sSSW
         1rEcjbHwY9P3tbodhARYfsuVlq2ah77tLsbS12ng=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [62.216.205.228] ([62.216.205.228]) by web-mail.web.de
 (3c-app-webde-bs48.server.lan [172.19.170.48]) (via HTTP); Sun, 28 Mar 2021
 17:40:36 +0200
MIME-Version: 1.0
Message-ID: <trinity-ed62f670-6e98-4395-85c0-2a7ea4415ee4-1616946036541@3c-app-webde-bs48>
From:   B A <chris.std@web.de>
To:     linux-btrfs@vger.kernel.org
Subject: Help needed with filesystem errors: parent transid verify failed
Content-Type: multipart/mixed;
 boundary=abmob-0000599d-1bd9-4a4f-9790-6469d72aa986
Date:   Sun, 28 Mar 2021 17:40:36 +0200
Importance: normal
Sensitivity: Normal
X-Priority: 3
X-Provags-ID: V03:K1:6ZoV4UgK//0Be1P+EkSGRnwZcbNulA8VuH5HdHEKiFOcKFGg21EJ3l0pnf4LjbD0KJypD
 NSXsmbab1GYPHzOQptxAB8RDdUNAxEUOva9w/PszOxGVN3WiuqXkfuJMWHN9lchJUf2+Sqz1CVD3
 Fsl2bIOcHQsWFE9z2/N9HqJe7z7tTgy5450IzvmZmXn+yY4TQ+0okn6M3zzmmwZR2oObMXF0tB9S
 ZyL33ah65cqHDd0RKUAOfso/xec5hxNv4EQ4HaKY8DUgd3fAYjOcSa2rUtht757KIulPVjcrbWj+
 qA=
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:OGcPOX3g4+Y=:GvDUtPEuRY7vyS/b7hdKxT
 Sbhjmk9EzspU6RR5xs71J8Bz+bZmWukYJprVIbwpFdUyY5AjNQ1N3pX08x8aIB4ZNA4PorWEe
 MmCx0CM5YSS0epQ1vyvgbnU9EA9rfeoxyKwqIfVVAHQRW8SXnajo8AB2j+nzCBSjjm7VXzcKt
 3IFemIUJjg0EA9Q0EjgpuasikAYt2wiKHLJRee8DE9igSymzzSwOQbxog1t545Il+BFyAfm2v
 pTB3Rl7F6kuFolzjuj+CvxK0G6cSLis4BVI1mHVDUKk9CG7UTAudJW5a6dg13Pl8uIrqSuXgK
 J2nfkivvy9XMs46GBosZSdrkxC+A0JQOonfX/4eKfeANguD3Fktfa0GAjWc5q8N7VC61ctV/l
 LuGaaQlYrArbHTyFAXHelxTORE4jLLoA1M0x4o57UwoZBfgYxlz4R9oX9VZnfrnJrSrcuzWBF
 zaZ/9vaFbGbGZbf3K8HF69sBkQRHDOcP/uW3TdXRkFSbqjj+Wv6liLUSK0VwwJX87JHwsWBkr
 VlFl/+TSRAmOt7XI0MvvhrFk2+CDDX+K5l26Za3z0IjwzSpz+orJJhrjMCxwGN03PdZzhRg9I
 BNuAk/XbFz3S43A9F7XFqbuvlGLAJFLoDOn8vf2DK41do0ZUhNhwSJgZFr3nWENp06/X6ARoN
 DWYaeJqVOhuOK5RFfdXgV+LIuU5vefhczJaH4GD8MbLt8sWA9KtMc8+FyuaZyC6oJwU55BjQF
 1qXSCjOGjPIJOLQ8ZDKKScsncm+lBoOxmr7dn20rsnHpsXCi8fliPE8ePixuACWCvz6yn99qq
 A09OkP3iYWm/H7SOqqWh2QL//RyMw5e5D8sLRWzNNqW0pUeT4jQV5wi0r3WFl23l0HZraeado
 JgO8U5QYKru6VIF0kQ27jYeKAsfOheb5d3WH6I6QqceEwPxjlDrG827EoFnLhv
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

--abmob-0000599d-1bd9-4a4f-9790-6469d72aa986
Content-Type: text/plain; charset=UTF-8

Dear btrfs experts,


On my desktop PC, I have 1 btrfs partition on a single SSD device with 3 subvolumes (/, /home, /var). Whenever I boot my PC, after logging in to GNOME, the btrfs partition is being remounted as ro due to errors. This is the dmesg output at that time:

> [  616.155392] BTRFS error (device dm-0): parent transid verify failed on 1144783093760 wanted 2734307 found 2734305
> [  616.155650] BTRFS error (device dm-0): parent transid verify failed on 1144783093760 wanted 2734307 found 2734305
> [  616.155657] BTRFS: error (device dm-0) in __btrfs_free_extent:3054: errno=-5 IO failure
> [  616.155662] BTRFS info (device dm-0): forced readonly
> [  616.155665] BTRFS: error (device dm-0) in btrfs_run_delayed_refs:2124: errno=-5 IO failure

The issue started to happen today after login. Yesterday everything works fine. I suggest something went wrong on last shutdown but I don't know for sure because as this disk also has my logs, I don't see any errors on that shutdown in my logs.

System info:
* Fedora 33 x86_64
* kernel: Linux 5.11.10-200.fc33.x86_64 #1 SMP
* btrfs-progs v5.10 (5.10-1.fc33.x86_64)
* Samsung 840 series SSD (SMART data looks fine)

What happens:
1. I boot my PC including mounting the root partition
2. Everything works fine.
3. I can log in as root or my user on tty and do basic stuff there and it works
4. I log in to my user account (gdm, GNOME shell). Alternatively, running e.g. `dnf history info last` also triggers the dmesg output shown above.
5. Many applications don't work any more. The common root cause seems to be that the filesystem is remounted readonly due to the errors noted above.

Basic info: see attached file "dmesg info.txt" (generated from Fedora live system)

What I've tried so far:
1. I ran `btrfs scrub` from live system. This errors out:

> [root@localhost-live liveuser]# btrfs scrub start -B /mnt
> ERROR: scrubbing /mnt failed for device id 1: ret=-1, errno=5 (Input/output error)
> scrub canceled for 1a149bda-057d-4775-ba66-1bf259fce9a5
> Scrub started:    Sun Mar 28 07:20:07 2021
> Status:           aborted
> Duration:         0:13:00
> Total to scrub:   269.06GiB
> Rate:             252.24MiB/s
> Error summary:    no errors found

At the same time, in `dmesg`, I see this:

> [ 7878.612534] BTRFS error (device dm-2): parent transid verify failed on 1144783093760 wanted 2734307 found 2734305
> [ 7878.637673] BTRFS error (device dm-2): parent transid verify failed on 1144783093760 wanted 2734307 found 2734305
> [ 7878.639459] BTRFS info (device dm-2): scrub: not finished on devid 1 with status: -5

2. I ran `btrfs check` (without repair) from live system. This also shows errors (see attached file "btrfs check.txt".


Side note: There is also a rare chance that this issue is triggered by a software update I did yesterday. This includes an update of systemd-246.10 to systemd-246.13 and kernel-5.11.8 to kernel-5.11.10.
Changes in systemd: https://src.fedoraproject.org/rpms/systemd/commits/f33
Changes in kernel: https://src.fedoraproject.org/rpms/kernel/commits/f33
Since this update has also been deployed to many other users (I am using stable channel) and I have not seen any related issues in Fedora's bugzilla and discourse, so I doubt this is related.


What shall I do now? Do I need any of the invasive methods (`btrfs rescue` or `btrfs check --repair`) and if yes, which method do I choose?

Kind regards,
Chris
--abmob-0000599d-1bd9-4a4f-9790-6469d72aa986
Content-Type: text/plain
Content-Disposition: attachment; filename="btrfs check.txt"

[root@localhost-live liveuser]# btrfs check /dev/mapper/luks-ff6e174f-4cd3-42a7-8ee5-47005dd077dc
Opening filesystem to check...
ERROR: /dev/mapper/luks-ff6e174f-4cd3-42a7-8ee5-47005dd077dc is currently mounted, use --force if you really intend to check the filesystem
[root@localhost-live liveuser]# btrfs check /dev/mapper/luks-ff6e174f-4cd3-42a7-8ee5-47005dd077dc
Opening filesystem to check...
Checking filesystem on /dev/mapper/luks-ff6e174f-4cd3-42a7-8ee5-47005dd077dc
UUID: 1a149bda-057d-4775-ba66-1bf259fce9a5
[1/7] checking root items
parent transid verify failed on 1144783093760 wanted 2734307 found 2734305
parent transid verify failed on 1144783093760 wanted 2734307 found 2734305
parent transid verify failed on 1144783093760 wanted 2734307 found 2734305
Ignoring transid failure
ERROR: child eb corrupted: parent bytenr=1144881201152 item=14 parent level=1 child level=2
ERROR: failed to repair root items: Input/output error
[2/7] checking extents
parent transid verify failed on 1144783093760 wanted 2734307 found 2734305
Ignoring transid failure
bad block 1144783093760
ERROR: errors found in extent allocation tree or chunk allocation
[3/7] checking free space cache
parent transid verify failed on 1144783093760 wanted 2734307 found 2734305
Ignoring transid failure
ERROR: child eb corrupted: parent bytenr=1144881201152 item=14 parent level=1 child level=2
cache appears valid but isn't 1062040764416
[4/7] checking fs roots
[5/7] checking only csums items (without verifying data)
parent transid verify failed on 1144783093760 wanted 2734307 found 2734305
Ignoring transid failure
ERROR: child eb corrupted: parent bytenr=1144881201152 item=14 parent level=1 child level=2
Error going to next leaf -5
csum exists for 1062926516224-1062935089152 but there is no extent record
ERROR: errors found in csum tree
[6/7] checking root refs
[7/7] checking quota groups skipped (not enabled on this FS)
ERROR: transid errors in file system
found 11738640384 bytes used, error(s) found
total csum bytes: 0
total tree bytes: 3719168
total fs tree bytes: 0
total extent tree bytes: 3522560
btree space waste bytes: 1056895
file data blocks allocated: 69992448
 referenced 69992448


--abmob-0000599d-1bd9-4a4f-9790-6469d72aa986
Content-Type: text/plain
Content-Disposition: attachment; filename="btrfs info.txt"
Content-Transfer-Encoding: quoted-printable

[root@localhost-live liveuser]# btrfs --version
btrfs-progs v5.7
[root@localhost-live liveuser]# btrfs fi show
Label: 'fedora_chstpc-2'  uuid: 1a149bda-057d-4775-ba66-1bf259fce9a5
	Total devices 1 FS bytes used 230.46GiB
	devid    1 size 300.00GiB used 269.06GiB path /dev/mapper/luks-ff6e174f-4=
cd3-42a7-8ee5-47005dd077dc

[root@localhost-live liveuser]# btrfs fi df /mnt
Data, single: total=3D263.00GiB, used=3D228.47GiB
System, DUP: total=3D32.00MiB, used=3D48.00KiB
Metadata, DUP: total=3D3.00GiB, used=3D1.99GiB
GlobalReserve, single: total=3D397.25MiB, used=3D0.00B


--abmob-0000599d-1bd9-4a4f-9790-6469d72aa986--

