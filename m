Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 317F748F716
	for <lists+linux-btrfs@lfdr.de>; Sat, 15 Jan 2022 14:18:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231809AbiAONRD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 15 Jan 2022 08:17:03 -0500
Received: from mout02.posteo.de ([185.67.36.66]:51585 "EHLO mout02.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231788AbiAONRD (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 15 Jan 2022 08:17:03 -0500
Received: from submission (posteo.de [89.146.220.130]) 
        by mout02.posteo.de (Postfix) with ESMTPS id CACF4240106
        for <linux-btrfs@vger.kernel.org>; Sat, 15 Jan 2022 14:17:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.de; s=2017;
        t=1642252621; bh=B97ET/Nbsu2TmoQwOsjwlmK1/XoZQMS66jGQaoSt5QY=;
        h=From:Subject:To:Date:From;
        b=OkLSIAt/W8B9jvVXPo21/NJXm1kVdDRisij3iYmSYQ+ytmq3WpHun8n7JvksUHYjg
         ps2O0SdqplJ7Pde1shTVL/dfn3lFUVJwWDL0dS3zpV3dchZ3UR96JWEyDOampjP5C7
         Na7MvT+FOqhtf8ZYkc5F3uLTdhGybyflikbkQhpbsnZW5DSro/Djk4kA3bmXc4xWPL
         RNCPUahjt0HuAo2fYyAXwJgoEu7smBhZPvgQOTmjgdibdo58ATQCsKJRe31DAELmVP
         ++A3V8cwuyR9uQpFH3sHCnCA6HzAa6/UEyjAO3XD6iPkfQZGHB52nbr1fBfwUypOmg
         TyAiZWXezoATA==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4Jbdx93V46z6tmc
        for <linux-btrfs@vger.kernel.org>; Sat, 15 Jan 2022 14:17:01 +0100 (CET)
From:   Stickstoff <stickstoff@posteo.de>
Subject: 'btrfs check' doesn't find errors in corrupted old btrfs (corrupt
 leaf, invalid tree level)
To:     linux-btrfs@vger.kernel.org
Message-ID: <6ed4cd5a-7430-f326-4056-25ae7eb44416@posteo.de>
Date:   Sat, 15 Jan 2022 13:16:58 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Dear btrfs-mailinglist,

I upgraded a machine from Debian Stretch (kernel 4.9, btrfs-progs
v4.7.3) to Debian Buster (kernel 4.19, btrfs-progs v4.20.1) to Debian
Bullseye (kernel 5.10, btrfs-progs v5.10.1) in one go, with a
few clean reboots in the process.
No (other) traumatic events (like hard shutdown) happened in the last
months.

Now I got an
> 'read time tree block corruption' and
> 'corrupt leaf: block=934474399744 slot=68 extent bytenr=425173254144 len=16384 invalid tree level, have 33554432 expect [0, 7]'
error.

The filesystem mounts and works, after a while this error shows up and sometimes the fs is then forced read-only.
A scrub quits after a few minutes with the exact same error.

The filesystem is on a two drive raid-1, created via "mkfs.btrfs -m raid1 -d raid1", probably
with "btrfs-progs v4.1.2" in 2015. The filesystem is only used for data storage, the OS is on
another drive. The filesystem only has one volume, and extensively uses snapshotting.

After consulting the IRC (thank you again for your help!) I tried "btrfs check --readonly"
and "btrfs check --repair" both with the stock btrfs-progs v5.10 and v5.16 from kdave's git.
All runs found no errors or problems and did not fix the corruption.

One possible explanation from IRC was that the corruption might have existed for a long time, and was only caught
when the newer 5.x btrfs started to first check these parts of the fs.
The corruption itself might have been caused by bitrot, bad memory or some random event, the machine is a consumer grade PC with
regular non-ECC memory. I noticed maybe two, three unexplained program/daemon crashes since 2015.


I very much appreciate any help or hints, thank you in advance.
Please let me know if I can supply any more information on this.


Sincerely,

Stickstoff




uname -a
Linux <> 5.10.0-10-amd64 #1 SMP Debian 5.10.84-1 (2021-12-08) x86_64 GNU/Linux


default btrfs:
btrfs --version
btrfs-progs v5.10.1


btrfs fi show
Label: 'root'
Label: '<>'
Label: 'raid'  uuid: <>
	Total devices 2 FS bytes used 6.13TiB
	devid    1 size 7.28TiB used 6.79TiB path /dev/mapper/123
	devid    2 size 7.28TiB used 6.79TiB path /dev/mapper/456


btrfs fi df /media/raid
Data, RAID1: total=6.77TiB, used=6.12TiB
System, RAID1: total=32.00MiB, used=1.08MiB
Metadata, RAID1: total=14.00GiB, used=11.09GiB
GlobalReserve, single: total=512.00MiB, used=0.00B


mounting/syslog:
mount /dev/mapper/123 /media/raid/ -o noatime -o nodiratime
[Sat Jan 15 13:34:44 2022] BTRFS info (device dm-1): flagging fs with big metadata feature
[Sat Jan 15 13:34:44 2022] BTRFS info (device dm-1): disk space caching is enabled
[Sat Jan 15 13:34:44 2022] BTRFS info (device dm-1): has skinny extents
[Sat Jan 15 13:34:45 2022] BTRFS info (device dm-1): bdev /dev/mapper/123 errs: wr 0, rd 77, flush 0, corrupt 0, gen 0
[Sat Jan 15 13:34:50 2022] BTRFS info (device dm-1): checking UUID tree
[Sat Jan 15 13:35:31 2022] BTRFS critical (device dm-1): corrupt leaf: block=934474399744 slot=68 extent bytenr=425173254144 len=16384 invalid tree level, have 33554432 expect [0, 7]
[Sat Jan 15 13:35:31 2022] BTRFS error (device dm-1): block=934474399744 read time tree block corruption detected
[Sat Jan 15 13:35:31 2022] BTRFS critical (device dm-1): corrupt leaf: block=934474399744 slot=68 extent bytenr=425173254144 len=16384 invalid tree level, have 33554432 expect [0, 7]
[Sat Jan 15 13:35:31 2022] BTRFS error (device dm-1): block=934474399744 read time tree block corruption detected


btrfs from git:
./btrfs --version
btrfs-progs v5.16


./btrfs check --readonly /dev/mapper/123
Opening filesystem to check...
Checking filesystem on /dev/mapper/123
UUID: <>
[1/7] checking root items
[2/7] checking extents
[3/7] checking free space cache
cache and super generation don't match, space cache will be invalidated
[4/7] checking fs roots
[5/7] checking only csums items (without verifying data)
[6/7] checking root refs
[7/7] checking quota groups skipped (not enabled on this FS)
found 6738595422325 bytes used, no error found
total csum bytes: 6567658048
total tree bytes: 11910365184
total fs tree bytes: 4002922496
total extent tree bytes: 362053632
btree space waste bytes: 1502595546
file data blocks allocated: 30328216862720
  referenced 18299870355456


btrfs check --repair /dev/mapper/123
enabling repair mode
WARNING:
	Do not use --repair unless you are advised to do so by a developer
	or an experienced user, and then only after having accepted that no
	fsck can successfully repair all types of filesystem corruption. Eg.
	some software or hardware bugs can fatally damage a volume.
	The operation will start in 10 seconds.
	Use Ctrl-C to stop it.
10 9 8 7 6 5 4 3 2 1
Starting repair.
Opening filesystem to check...
Checking filesystem on /dev/mapper/123
UUID: <>
[1/7] checking root items
Fixed 0 roots.
[2/7] checking extents
No device size related problem found
[3/7] checking free space cache
cache and super generation don't match, space cache will be invalidated
[4/7] checking fs roots
[5/7] checking only csums items (without verifying data)
[6/7] checking root refs
[7/7] checking quota groups skipped (not enabled on this FS)
found 6738729926769 bytes used, no error found
total csum bytes: 6567658048
total tree bytes: 11910283264
total fs tree bytes: 4002922496
total extent tree bytes: 361971712
btree space waste bytes: 1502514586
file data blocks allocated: 30328216862720
  referenced 18299870355456
