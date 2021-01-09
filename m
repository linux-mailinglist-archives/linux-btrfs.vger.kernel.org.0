Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6854E2F03DF
	for <lists+linux-btrfs@lfdr.de>; Sat,  9 Jan 2021 22:41:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726195AbhAIVlN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 9 Jan 2021 16:41:13 -0500
Received: from james.kirk.hungrycats.org ([174.142.39.145]:44146 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726001AbhAIVlN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sat, 9 Jan 2021 16:41:13 -0500
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id 7A4469313DA; Sat,  9 Jan 2021 16:40:32 -0500 (EST)
Date:   Sat, 9 Jan 2021 16:40:32 -0500
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Andrea Gelmini <andrea.gelmini@gmail.com>
Cc:     Cedric.dewijs@eclipso.eu, Linux BTRFS <linux-btrfs@vger.kernel.org>
Subject: Re: Re: Raid1 of a slow hdd and a fast(er) SSD, howto to prioritize
 the SSD?
Message-ID: <20210109214032.GC31381@hungrycats.org>
References: <28232f6c03d8ae635d2ddffe29c82fac@mail.eclipso.de>
 <CAK-xaQZS+ANoD+QbPTHwL-ErapA-7PDZe_z=OOWq_axAyR1KfA@mail.gmail.com>
 <eb0f5e05a563009af95439f446659cf3@mail.eclipso.de>
 <CAK-xaQbQPSS7=cH1qmb9S51CL34VRfyE_=eNwb-GhSL1b8Yz2g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK-xaQbQPSS7=cH1qmb9S51CL34VRfyE_=eNwb-GhSL1b8Yz2g@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jan 08, 2021 at 08:29:45PM +0100, Andrea Gelmini wrote:
> Il giorno ven 8 gen 2021 alle ore 09:36 <Cedric.dewijs@eclipso.eu> ha scritto:
> > What happens when I poison one of the drives in the mdadm array using this command? Will all data come out OK?
> > dd if=/dev/urandom of=/dev/dev/sdb1 bs=1M count = 100?
> 
> <smiling>
> Well, (happens) the same thing when your laptop is stolen or you read
> "open_ctree failed"...You restore backup...
> </smiling>
> 
> I have a few idea, but it's much more quicker to try it. Let's see:
> 
> truncate -s 5G dev1
> truncate -s 5G dev2
> losetup /dev/loop31 dev1
> losetup /dev/loop32 dev2
> mdadm --create --verbose --assume-clean /dev/md0 --level=1
> --raid-devices=2 /dev/loop31 --write-mostly /dev/loop32

Note that with --write-mostly here, total filesystem loss is no longer
random: mdadm will always pick loop31 over loop32 while loop31 exists.

> mkfs.btrfs /dev/md0
> mount -o compress=lzo /dev/md0 /mnt/sg10/
> cd /mnt/sg10/
> cp -af /home/gelma/dev/kernel/ .
> root@glet:/mnt/sg10# dmesg -T
> [Fri Jan  8 19:51:33 2021] md/raid1:md0: active with 2 out of 2 mirrors
> [Fri Jan  8 19:51:33 2021] md0: detected capacity change from 0 to 5363466240
> [Fri Jan  8 19:51:53 2021] BTRFS: device fsid
> 2fe43610-20e5-48de-873d-d1a6c2db2a6a devid 1 transid 5 /dev/md0
> scanned by mkfs.btrfs (512004)
> [Fri Jan  8 19:51:53 2021] md: data-check of RAID array md0
> [Fri Jan  8 19:52:19 2021] md: md0: data-check done.
> [Fri Jan  8 19:53:13 2021] BTRFS info (device md0): setting incompat
> feature flag for COMPRESS_LZO (0x8)
> [Fri Jan  8 19:53:13 2021] BTRFS info (device md0): use lzo compression, level 0
> [Fri Jan  8 19:53:13 2021] BTRFS info (device md0): disk space caching
> is enabled
> [Fri Jan  8 19:53:13 2021] BTRFS info (device md0): has skinny extents
> [Fri Jan  8 19:53:13 2021] BTRFS info (device md0): flagging fs with
> big metadata feature
> [Fri Jan  8 19:53:13 2021] BTRFS info (device md0): enabling ssd optimizations
> [Fri Jan  8 19:53:13 2021] BTRFS info (device md0): checking UUID tree
> 
> root@glet:/mnt/sg10# btrfs scrub start -B .
> scrub done for 2fe43610-20e5-48de-873d-d1a6c2db2a6a
> Scrub started:    Fri Jan  8 20:01:59 2021
> Status:           finished
> Duration:         0:00:04
> Total to scrub:   4.99GiB
> Rate:             1.23GiB/s
> Error summary:    no errors found
> 
> We check the array is in sync:
> 
> root@glet:/mnt/sg10# cat /proc/mdstat
> Personalities : [linear] [multipath] [raid0] [raid1] [raid6] [raid5]
> [raid4] [raid10]
> md0 : active raid1 loop32[1](W) loop31[0]
>      5237760 blocks super 1.2 [2/2] [UU]

You have used --assume-clean and didn't tell mdadm otherwise since,
so this test didn't provide any information.

On real disks a mdadm integrity check at this point fail very hard since
the devices have never been synced (unless they are both blank devices
filled with the same formatting test pattern or zeros).

> unused devices: <none>
> 
> Now we wipe the storage;
> root@glet:/mnt/sg10# dd if=/dev/urandom of=/dev/loop32 bs=1M count=100

With --write-mostly, the above deterministically works, and

	dd if=/dev/urandom of=/dev/loop31 bs=1M count=100

deterministically damages or destroys the filesystem.

With real disk failures you don't get to pick which drive is corrupted
or when.  If it's the remote drive, you have no backup and have no way
to _know_ you have no backup.  If it's the local drive, you can recover
it if you read from the backup in time; otherise, you lose your data
permanently on the next mdadm resync.

> 100+0 records in
> 100+0 records out
> 104857600 bytes (105 MB, 100 MiB) copied, 0.919025 s, 114 MB/s
> 
> sync
> 
> echo 3 > /proc/sys/vm/drop_caches
> 
> I do rm to force write i/o:
> 
> root@glet:/mnt/sg10# rm kernel/v5.11/ -rf
> 
> root@glet:/mnt/sg10# btrfs scrub start -B .
> scrub done for 2fe43610-20e5-48de-873d-d1a6c2db2a6a
> Scrub started:    Fri Jan  8 20:11:21 2021
> Status:           finished
> Duration:         0:00:03
> Total to scrub:   4.77GiB
> Rate:             1.54GiB/s
> Error summary:    no errors found

This scrub will never detect corruption on the remote filesystem because
of --write-mostly, so you have no way to know whether it has bitrotted
away (or is just missing a whole lot of updates).

> Now, I stop the array and re-assembly:
> mdadm -Ss
> 
> root@glet:/# mdadm --assemble /dev/md0 /dev/loop31 /dev/loop32
> mdadm: /dev/md0 has been started with 2 drives.
> 
> root@glet:/# mount /dev/md0 /mnt/sg10/
> root@glet:/# btrfs scrub start -B  /mnt/sg10/
> scrub done for 2fe43610-20e5-48de-873d-d1a6c2db2a6a
> Scrub started:    Fri Jan  8 20:15:16 2021
> Status:           finished
> Duration:         0:00:03
> Total to scrub:   4.77GiB
> Rate:             1.54GiB/s
> Error summary:    no errors found
> 
> Ciao,
> Gelma
