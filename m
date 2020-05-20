Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F1431DC123
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 May 2020 23:14:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728553AbgETVOc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 20 May 2020 17:14:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728117AbgETVOc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 20 May 2020 17:14:32 -0400
X-Greylist: delayed 96 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 20 May 2020 14:14:31 PDT
Received: from mxa1.seznam.cz (mxa1.seznam.cz [IPv6:2a02:598:a::78:90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E833C061A0E
        for <linux-btrfs@vger.kernel.org>; Wed, 20 May 2020 14:14:31 -0700 (PDT)
Received: from email.seznam.cz
        by email-smtpc12a.ko.seznam.cz (email-smtpc12a.ko.seznam.cz [10.53.11.105])
        id 7761e1050d958bd47761e372;
        Wed, 20 May 2020 23:14:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seznam.cz; s=beta;
        t=1590009270; bh=bDOEEDXrsRViZfun5AB4AKzITfS4EqqcSQgfdgZRWek=;
        h=Received:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
         References:Content-Type:X-Mailer:Mime-Version:
         Content-Transfer-Encoding;
        b=FPwF0AVFQvpWOOTvX1JD0+/tFKR0oQS5PIKEJ7chv2IuyUDQdwvCZJ+OZHb5RUjPq
         Cu0iwRgbmtqEMuXsjooDZWIS3lz3TJ8PIQCzMcgsz/FbCAoUtmtu4TPbvLNEd+/Pse
         ZSkYW3DofJSlrA06p7WK6IAoYZYqQ628OE6BrAXM=
Received: from lisicky.cdnet.czf (unknown [82.150.191.10])
        by email-relay23.ko.seznam.cz (Seznam SMTPD 1.3.114) with ESMTP;
        Wed, 20 May 2020 23:12:48 +0200 (CEST)  
Message-ID: <139f40a70cf37da2fef682c5c3d660671d8af88d.camel@seznam.cz>
Subject: Re: I can't mount image
From:   =?UTF-8?Q?Ji=C5=99=C3=AD_Lisick=C3=BD?= <jiri_lisicky@seznam.cz>
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Date:   Wed, 20 May 2020 23:12:45 +0200
In-Reply-To: <CAJCQCtSWX0J69SokSOgAhdcQ6qkKHfaPVhbF4anjCtVFACOVnQ@mail.gmail.com>
References: <1e6bc0e299901f90613550570446777fbccdc21e.camel@seznam.cz>
         <CAJCQCtSWX0J69SokSOgAhdcQ6qkKHfaPVhbF4anjCtVFACOVnQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-8.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Chris Murphy píše v Po 18. 05. 2020 v 17:45 -0600:
> On Sun, May 17, 2020 at 1:54 PM Jiří Lisický <jiri_lisicky@seznam.cz> wrote:
> > 
> > Hi, I have Jolla 1 Phone, which use btrfs. With bad battery, phone x times suddenly turned off. Now is bricked. I go into recovery mode
> > and copy image to my PC with Fedora Live 31 with kernel 5.6.6.
> > 
> > ~ # losetup --find --show /home/jirka/tmp/jolla.img
> > /dev/loop0
> > 
> > ~ # btrfs fi show
> > Label: 'sailfish'  uuid: 86180ca0-d351-4551-b262-22b49e1adf47
> >  Total devices 1 FS bytes used 4.73GiB
> >   devid    1 size 13.75GiB used 13.75GiB path /dev/loop0
> > 
> > ~ # mount -t btrfs /dev/loop0 ~/mnt
> > mount: /dev/loop0: can't read superblock
> > 
> > ~ # mount -t btrfs -o usebackuproot /dev/loop0 ~/mnt
> > mount: /dev/loop0: can't read superblock
> > 
> > ~ # btrfs rescue super-recover /dev/loop0
> > All supers are valid, no need to recover
> 
> Weird. How does it not read the superblock, but all superblocks are
> valid? What do you get for
> 
> btrfs insp dump-s -fa /dev/loop0
OK, I made new copy of original image:
cp jolla-orig.img jolla1.img

Again mount (now as loop4)
losetup --find --show /home/jirka/tmp/jolla1.img
/dev/loop4

btrfs insp dump-s -fa /dev/loop4

superblock: bytenr=65536, device=/dev/loop4
---------------------------------------------------------
csum_type		0 (crc32c)
csum_size		4
csum			0xdc2c003a [match]
bytenr			65536
flags			0x1
			( WRITTEN )
magic			_BHRfS_M [match]
fsid			86180ca0-d351-4551-b262-22b49e1adf47
metadata_uuid		86180ca0-d351-4551-b262-22b49e1adf47
label			sailfish
generation		2727499
root			30703616
sys_array_size		226
chunk_root_generation	2342945
root_level		1
chunk_root		20971520
chunk_root_level	0
log_root		94920704
log_root_transid	0
log_root_level		0
total_bytes		14761832448
bytes_used		5075300352
sectorsize		4096
nodesize		4096
leafsize (deprecated)	4096
stripesize		4096
root_dir		6
num_devices		1
compat_flags		0x0
compat_ro_flags		0x0
incompat_flags		0x3
			( MIXED_BACKREF |
			  DEFAULT_SUBVOL )
cache_generation	2727498
uuid_tree_generation	0
dev_item.uuid		bb3ff90e-e471-48d6-af4e-add19a0a532d
dev_item.fsid		86180ca0-d351-4551-b262-22b49e1adf47 [match]
dev_item.type		0
dev_item.total_bytes	14761832448
dev_item.bytes_used	14761787392
dev_item.io_align	4096
dev_item.io_width	4096
dev_item.sector_size	4096
dev_item.devid		1
dev_item.dev_group	0
dev_item.seek_speed	0
dev_item.bandwidth	0
dev_item.generation	0
sys_chunk_array[2048]:
	item 0 key (FIRST_CHUNK_TREE CHUNK_ITEM 0)
		length 4194304 owner 2 stripe_len 65536 type SYSTEM
		io_align 4096 io_width 4096 sector_size 4096
		num_stripes 1 sub_stripes 0
			stripe 0 devid 1 offset 0
			dev_uuid bb3ff90e-e471-48d6-af4e-add19a0a532d
	item 1 key (FIRST_CHUNK_TREE CHUNK_ITEM 20971520)
		length 8388608 owner 2 stripe_len 65536 type SYSTEM|DUP
		io_align 65536 io_width 65536 sector_size 4096
		num_stripes 2 sub_stripes 0
			stripe 0 devid 1 offset 20971520
			dev_uuid bb3ff90e-e471-48d6-af4e-add19a0a532d
			stripe 1 devid 1 offset 29360128
			dev_uuid bb3ff90e-e471-48d6-af4e-add19a0a532d
backup_roots[4]:
	backup 0:
		backup_tree_root:	114339840	gen: 2727497	level: 1
		backup_chunk_root:	20971520	gen: 2342945	level: 0
		backup_extent_root:	117129216	gen: 2727498	level: 2
		backup_fs_root:		88788992	gen: 1765467	level: 0
		backup_dev_root:	49008640	gen: 2727493	level: 0
		backup_csum_root:	116412416	gen: 2727498	level: 2
		backup_total_bytes:	14761832448
		backup_bytes_used:	5075410944
		backup_num_devices:	1

	backup 1:
		backup_tree_root:	48250880	gen: 2727498	level: 1
		backup_chunk_root:	20971520	gen: 2342945	level: 0
		backup_extent_root:	89980928	gen: 2727499	level: 2
		backup_fs_root:		88788992	gen: 1765467	level: 0
		backup_dev_root:	49008640	gen: 2727493	level: 0
		backup_csum_root:	89243648	gen: 2727499	level: 2
		backup_total_bytes:	14761832448
		backup_bytes_used:	5075365888
		backup_num_devices:	1

	backup 2:
		backup_tree_root:	90173440	gen: 2727495	level: 1
		backup_chunk_root:	20971520	gen: 2342945	level: 0
		backup_extent_root:	84922368	gen: 2727495	level: 2
		backup_fs_root:		88788992	gen: 1765467	level: 0
		backup_dev_root:	49008640	gen: 2727493	level: 0
		backup_csum_root:	94969856	gen: 2727496	level: 2
		backup_total_bytes:	14761832448
		backup_bytes_used:	5075275776
		backup_num_devices:	1

	backup 3:
		backup_tree_root:	102043648	gen: 2727496	level: 1
		backup_chunk_root:	20971520	gen: 2342945	level: 0
		backup_extent_root:	98189312	gen: 2727496	level: 2
		backup_fs_root:		88788992	gen: 1765467	level: 0
		backup_dev_root:	49008640	gen: 2727493	level: 0
		backup_csum_root:	97951744	gen: 2727496	level: 2
		backup_total_bytes:	14761832448
		backup_bytes_used:	5075275776
		backup_num_devices:	1


superblock: bytenr=67108864, device=/dev/loop4
---------------------------------------------------------
csum_type		0 (crc32c)
csum_size		4
csum			0x7c4d28f4 [match]
bytenr			67108864
flags			0x1
			( WRITTEN )
magic			_BHRfS_M [match]
fsid			86180ca0-d351-4551-b262-22b49e1adf47
metadata_uuid		86180ca0-d351-4551-b262-22b49e1adf47
label			sailfish
generation		2727499
root			30703616
sys_array_size		226
chunk_root_generation	2342945
root_level		1
chunk_root		20971520
chunk_root_level	0
log_root		94920704
log_root_transid	0
log_root_level		0
total_bytes		14761832448
bytes_used		5075300352
sectorsize		4096
nodesize		4096
leafsize (deprecated)	4096
stripesize		4096
root_dir		6
num_devices		1
compat_flags		0x0
compat_ro_flags		0x0
incompat_flags		0x3
			( MIXED_BACKREF |
			  DEFAULT_SUBVOL )
cache_generation	2727498
uuid_tree_generation	0
dev_item.uuid		bb3ff90e-e471-48d6-af4e-add19a0a532d
dev_item.fsid		86180ca0-d351-4551-b262-22b49e1adf47 [match]
dev_item.type		0
dev_item.total_bytes	14761832448
dev_item.bytes_used	14761787392
dev_item.io_align	4096
dev_item.io_width	4096
dev_item.sector_size	4096
dev_item.devid		1
dev_item.dev_group	0
dev_item.seek_speed	0
dev_item.bandwidth	0
dev_item.generation	0
sys_chunk_array[2048]:
	item 0 key (FIRST_CHUNK_TREE CHUNK_ITEM 0)
		length 4194304 owner 2 stripe_len 65536 type SYSTEM
		io_align 4096 io_width 4096 sector_size 4096
		num_stripes 1 sub_stripes 0
			stripe 0 devid 1 offset 0
			dev_uuid bb3ff90e-e471-48d6-af4e-add19a0a532d
	item 1 key (FIRST_CHUNK_TREE CHUNK_ITEM 20971520)
		length 8388608 owner 2 stripe_len 65536 type SYSTEM|DUP
		io_align 65536 io_width 65536 sector_size 4096
		num_stripes 2 sub_stripes 0
			stripe 0 devid 1 offset 20971520
			dev_uuid bb3ff90e-e471-48d6-af4e-add19a0a532d
			stripe 1 devid 1 offset 29360128
			dev_uuid bb3ff90e-e471-48d6-af4e-add19a0a532d
backup_roots[4]:
	backup 0:
		backup_tree_root:	114339840	gen: 2727497	level: 1
		backup_chunk_root:	20971520	gen: 2342945	level: 0
		backup_extent_root:	117129216	gen: 2727498	level: 2
		backup_fs_root:		88788992	gen: 1765467	level: 0
		backup_dev_root:	49008640	gen: 2727493	level: 0
		backup_csum_root:	116412416	gen: 2727498	level: 2
		backup_total_bytes:	14761832448
		backup_bytes_used:	5075410944
		backup_num_devices:	1

	backup 1:
		backup_tree_root:	48250880	gen: 2727498	level: 1
		backup_chunk_root:	20971520	gen: 2342945	level: 0
		backup_extent_root:	89980928	gen: 2727499	level: 2
		backup_fs_root:		88788992	gen: 1765467	level: 0
		backup_dev_root:	49008640	gen: 2727493	level: 0
		backup_csum_root:	89243648	gen: 2727499	level: 2
		backup_total_bytes:	14761832448
		backup_bytes_used:	5075365888
		backup_num_devices:	1

	backup 2:
		backup_tree_root:	90173440	gen: 2727495	level: 1
		backup_chunk_root:	20971520	gen: 2342945	level: 0
		backup_extent_root:	84922368	gen: 2727495	level: 2
		backup_fs_root:		88788992	gen: 1765467	level: 0
		backup_dev_root:	49008640	gen: 2727493	level: 0
		backup_csum_root:	94969856	gen: 2727496	level: 2
		backup_total_bytes:	14761832448
		backup_bytes_used:	5075275776
		backup_num_devices:	1

	backup 3:
		backup_tree_root:	102043648	gen: 2727496	level: 1
		backup_chunk_root:	20971520	gen: 2342945	level: 0
		backup_extent_root:	98189312	gen: 2727496	level: 2
		backup_fs_root:		88788992	gen: 1765467	level: 0
		backup_dev_root:	49008640	gen: 2727493	level: 0
		backup_csum_root:	97951744	gen: 2727496	level: 2
		backup_total_bytes:	14761832448
		backup_bytes_used:	5075275776
		backup_num_devices:	1

> 
> > ~ # LC_ALL=C btrfs rescue zero-log /dev/loop0
> > Clearing log on /dev/loop0, previous log_root 0, level 0
> 
> This is not advised except in specific cases which the man page gives
> examples of.
> 
> 
> > ~ # btrfs fi df ~/mnt
> > Data, single: total=13.08GiB, used=4.51GiB
> > System, DUP: total=8.00MiB, used=4.00KiB
> > System, single: total=4.00MiB, used=0.00B
> > Metadata, DUP: total=330.00MiB, used=224.30MiB
> > Metadata, single: total=8.00MiB, used=0.00B
> > GlobalReserve, single: total=512.00MiB, used=406.37MiB
> > 
> > ~ # truncate --size=2GB ~/tmp/space
> > ~ # losetup --find --show ~/tmp/space
> > /dev/loop1
> > 
> > ~ # btrfs device add /dev/loop1 ~/mnt/
> > Performing full device TRIM /dev/loop1 (1.86GiB) ...
> > ERROR: error adding device '/dev/loop1': Read-only file system
> > 
> > When I mount, in syslog appears:
> > BTRFS info (device loop0): disk space caching is enabled
> > BTRFS info (device loop0): creating UUID tree
> > BTRFS warning (device loop0): block group 144703488 has wrong amount of free space
> > BTRFS warning (device loop0): failed to load free space cache for block group 144703488, rebuilding it now
> > BTRFS warning (device loop0): failed to create the UUID tree: -28
> > BTRFS: open_ctree failed
> > 
> > So now I can mount readonly, but is there any way to repair this filesystem?
> 
> Definitely get things off of it now while you can.
Yes, I already did.


> Fedora 31 has btrfs-progs 5.6 current. 
For clarification I would like to add info from jolla phone (recovery
mode):

/ # uname -a
Linux (none) 3.4.108.20190506.1 #1 SMP PREEMPT Sat Nov 30 21:25:45 UTC
2019 armv7l GNU/Linux
/ # btrfs --version
Btrfs v3.16


> I suggest posting the output from
> 
> # btrfs check --readonly /dev/

btrfs check --readonly /dev/loop4

Opening filesystem to check...
parent transid verify failed on 94920704 wanted 2727500 found 2727499
parent transid verify failed on 94920704 wanted 2727500 found 2727499
parent transid verify failed on 94920704 wanted 2727500 found 2727499
Ignoring transid failure
Checking filesystem on /dev/loop4
UUID: 86180ca0-d351-4551-b262-22b49e1adf47
[1/7] checking root items
[2/7] checking extents
[3/7] checking free space cache
cache and super generation don't match, space cache will be invalidated
[4/7] checking fs roots
[5/7] checking only csums items (without verifying data)
[6/7] checking root refs
[7/7] checking quota groups
Rescan hasn't been initialized, a difference in qgroup accounting is
expected
Counts for qgroup id: 0/264 are different
our:		referenced 876449792 referenced compressed 876449792
disk:		referenced 876449792 referenced compressed 876449792
our:		exclusive 872464384 exclusive compressed 872464384
disk:		exclusive 4096 exclusive compressed 4096
diff:		exclusive 872460288 exclusive compressed 872460288
Counts for qgroup id: 0/265 are different
our:		referenced 73646080 referenced compressed 73646080
disk:		referenced 73646080 referenced compressed 73646080
our:		exclusive 15380480 exclusive compressed 15380480
disk:		exclusive 4096 exclusive compressed 4096
diff:		exclusive 15376384 exclusive compressed 15376384
ERROR: transid errors in file system
found 5075300352 bytes used, error(s) found
total csum bytes: 4715584
total tree bytes: 235204608
total fs tree bytes: 214499328
total extent tree bytes: 12795904
btree space waste bytes: 70058462
file data blocks allocated: 4970160128
 referenced 4793737216

I don't know if adding attachments is allowed, so it's embedded.
Thanks Jirka

