Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21C9227B2BC
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Sep 2020 19:09:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726548AbgI1RJR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 28 Sep 2020 13:09:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726506AbgI1RJR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 28 Sep 2020 13:09:17 -0400
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [IPv6:2001:67c:2050::465:103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75609C061755
        for <linux-btrfs@vger.kernel.org>; Mon, 28 Sep 2020 10:09:17 -0700 (PDT)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:105:465:1:1:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4C0TWv0N6FzKmLl;
        Mon, 28 Sep 2020 19:09:15 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
        by spamfilter02.heinlein-hosting.de (spamfilter02.heinlein-hosting.de [80.241.56.116]) (amavisd-new, port 10030)
        with ESMTP id NnzbyAhr_ohT; Mon, 28 Sep 2020 19:09:12 +0200 (CEST)
Message-ID: <9d77e671add0d3985795da0873e1a08a3fff7179.camel@wittke-web.de>
Subject: Re: Recover from Extent Tree Corruption (maybe due to hardware
 failure)
From:   Marc Wittke <marc@wittke-web.de>
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Date:   Mon, 28 Sep 2020 14:09:07 -0300
In-Reply-To: <CAJCQCtSCRDh65+aAKs4C0t+c3n4aA8sBrE_QLsPy6JkZ0PwGmA@mail.gmail.com>
References: <5df695c82cd7f44da5e57d3a8c8549a01130d759.camel@wittke-web.de>
         <CAJCQCtSCRDh65+aAKs4C0t+c3n4aA8sBrE_QLsPy6JkZ0PwGmA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MBO-SPAM-Probability: 
X-Rspamd-Score: -4.47 / 15.00 / 15.00
X-Rspamd-Queue-Id: EFFB117DA
X-Rspamd-UID: 15dbed
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, 2020-09-28 at 09:32 -0600, Chris Murphy wrote:
> What about 'mount -o ro,usebackuproot' ?

# mount -o ro,usebackuproot /dev/sdb1 /mnt

[ 3198.709815] BTRFS info (device sdb1): trying to use backup root at mount time
[ 3198.709819] BTRFS info (device sdb1): disk space caching is enabled
[ 3198.709821] BTRFS info (device sdb1): has skinny extents

# ls -l /mnt

[ 3210.859894] BTRFS error (device sdb1): bad tree block start, want 385831682048 have 18271273693833811190
[ 3210.876871] BTRFS error (device sdb1): bad tree block start, want 385831682048 have 18271273693833811190
[ 3210.877452] BTRFS error (device sdb1): bad tree block start, want 385831682048 have 18271273693833811190
[ 3210.877776] BTRFS error (device sdb1): bad tree block start, want 385831682048 have 18271273693833811190
[ 3210.878125] BTRFS error (device sdb1): bad tree block start, want 385831682048 have 18271273693833811190
[ 3210.878434] BTRFS error (device sdb1): bad tree block start, want 385831682048 have 18271273693833811190
[ 3210.878733] BTRFS error (device sdb1): bad tree block start, want 385831682048 have 18271273693833811190
[ 3210.879036] BTRFS error (device sdb1): bad tree block start, want 385831682048 have 18271273693833811190
[ 3210.879289] BTRFS error (device sdb1): bad tree block start, want 385831682048 have 18271273693833811190
[ 3210.879574] BTRFS error (device sdb1): bad tree block start, want 385831682048 have 18271273693833811190

ls: cannot access '/mnt/home': Input/output error
ls: cannot access '/mnt/lost+found': Input/output error
ls: cannot access '/mnt/media': Input/output error
ls: cannot access '/mnt/mnt': Input/output error
ls: cannot access '/mnt/opt': Input/output error
ls: cannot access '/mnt/srv': Input/output error
ls: cannot access '/mnt/tmp': Input/output error
ls: cannot access '/mnt/usr': Input/output error
ls: cannot access '/mnt/var': Input/output error
total 16
lrwxrwxrwx. 1 root root    7 Jan 28  2020 bin -> usr/bin
drwxr-xr-x. 1 root root    0 Sep  9 22:19 boot
drwxr-xr-x. 1 root root    0 Sep  9 22:19 dev
drwxr-xr-x. 1 root root 5402 Sep 24 19:23 etc
d?????????? ? ?    ?       ?            ? home
lrwxrwxrwx. 1 root root    7 Jan 28  2020 lib -> usr/lib
lrwxrwxrwx. 1 root root    9 Jan 28  2020 lib64 -> usr/lib64
d?????????? ? ?    ?       ?            ? lost+found
d?????????? ? ?    ?       ?            ? media
d?????????? ? ?    ?       ?            ? mnt
d?????????? ? ?    ?       ?            ? opt
drwxr-xr-x. 1 root root    0 Sep  9 22:19 proc
dr-xr-x---. 1 root root  330 Sep 20 19:16 root
drwxr-xr-x. 1 root root    0 Sep  9 22:19 run
lrwxrwxrwx. 1 root root    8 Jan 28  2020 sbin -> usr/sbin
d?????????? ? ?    ?       ?            ? srv
drwxr-xr-x. 1 root root    0 Sep  9 22:19 sys
d?????????? ? ?    ?       ?            ? tmp
d?????????? ? ?    ?       ?            ? usr
d?????????? ? ?    ?       ?            ? var

> 'btrfs insp dump-s -f /dev/'

superblock: bytenr=65536, device=/dev/sdb1
---------------------------------------------------------
csum_type		0 (crc32c)
csum_size		4
csum			0xd7f04658 [match]
bytenr			65536
flags			0x1
			( WRITTEN )
magic			_BHRfS_M [match]
fsid			131112e7-6e32-474c-813a-9c1ce4292c18
metadata_uuid		131112e7-6e32-474c-813a-9c1ce4292c18
label			
generation		310285
root			1104625664
sys_array_size		97
chunk_root_generation	307101
root_level		1
chunk_root		1097728
chunk_root_level	1
log_root		0
log_root_transid	0
log_root_level		0
total_bytes		2012737437696
bytes_used		575223103488
sectorsize		4096
nodesize		16384
leafsize (deprecated)	16384
stripesize		4096
root_dir		6
num_devices		1
compat_flags		0x0
compat_ro_flags		0x0
incompat_flags		0x161
			( MIXED_BACKREF |
			  BIG_METADATA |
			  EXTENDED_IREF |
			  SKINNY_METADATA )
cache_generation	310285
uuid_tree_generation	310285
dev_item.uuid		0ca7ed2a-46e9-4234-a65b-5c25a657b8e7
dev_item.fsid		131112e7-6e32-474c-813a-9c1ce4292c18 [match]
dev_item.type		0
dev_item.total_bytes	2012737437696
dev_item.bytes_used	577694072832
dev_item.io_align	4096
dev_item.io_width	4096
dev_item.sector_size	4096
dev_item.devid		1
dev_item.dev_group	0
dev_item.seek_speed	0
dev_item.bandwidth	0
dev_item.generation	0
sys_chunk_array[2048]:
	item 0 key (FIRST_CHUNK_TREE CHUNK_ITEM 1048576)
		length 4194304 owner 2 stripe_len 65536 type SYSTEM
		io_align 4096 io_width 4096 sector_size 4096
		num_stripes 1 sub_stripes 0
			stripe 0 devid 1 offset 1048576
			dev_uuid 0ca7ed2a-46e9-4234-a65b-5c25a657b8e7
backup_roots[4]:
	backup 0:
		backup_tree_root:	1104625664	gen: 310285	level: 1
		backup_chunk_root:	1097728	gen: 307101	level: 1
		backup_extent_root:	1104642048	gen: 310285	level: 2
		backup_fs_root:		1103724544	gen: 310283	level: 3
		backup_dev_root:	1105625088	gen: 310285	level: 1
		backup_csum_root:	1106067456	gen: 310285	level: 2
		backup_total_bytes:	2012737437696
		backup_bytes_used:	575223103488
		backup_num_devices:	1

	backup 1:
		backup_tree_root:	385875853312	gen: 310282	level: 1
		backup_chunk_root:	1097728	gen: 307101	level: 1
		backup_extent_root:	385857273856	gen: 310282	level: 2
		backup_fs_root:		385788215296	gen: 310282	level: 3
		backup_dev_root:	385520975872	gen: 307101	level: 1
		backup_csum_root:	385797603328	gen: 310282	level: 2
		backup_total_bytes:	2012737437696
		backup_bytes_used:	575223103488
		backup_num_devices:	1

	backup 2:
		backup_tree_root:	1105707008	gen: 310283	level: 1
		backup_chunk_root:	1097728	gen: 307101	level: 1
		backup_extent_root:	1104625664	gen: 310283	level: 2
		backup_fs_root:		0	gen: 0	level: 0
		backup_dev_root:	1107591168	gen: 310283	level: 1
		backup_csum_root:	1106591744	gen: 310283	level: 2
		backup_total_bytes:	2012737437696
		backup_bytes_used:	575223103488
		backup_num_devices:	1

	backup 3:
		backup_tree_root:	1107755008	gen: 310284	level: 1
		backup_chunk_root:	1097728	gen: 307101	level: 1
		backup_extent_root:	1107771392	gen: 310284	level: 2
		backup_fs_root:		0	gen: 0	level: 0
		backup_dev_root:	1107591168	gen: 310283	level: 1
		backup_csum_root:	1108672512	gen: 310284	level: 2
		backup_total_bytes:	2012737437696
		backup_bytes_used:	575223103488
		backup_num_devices:	1

> 
> > # sudo btrfs restore -oi /dev/sdc1 /home/marc/rescued/
> 
> From the backup roots in the super, and also using 'btrfs-find-root'
> it might be possible to find another root tree to use.

# btrfs-find-root /dev/sdb1
Superblock thinks the generation is 310285
Superblock thinks the level is 1
Found tree root at 1104625664 gen 310285 level 1

>  This was NVMe. What were the mount options being used?
Good question, didn't fiddle around a lot with the basic setup of fedora. This is the fstab as it is recoverable from the partition
UUID=131112e7-6e32-474c-813a-9c1ce4292c18 /                       btrfs   defaults,x-systemd.device-timeout=0 0 0
UUID=106fdbec-741f-4eca-9fba-3043cb80ad87 /boot                   ext4    defaults        1 2
UUID=F291-4D24                            /boot/efi               vfat    umask=0077,shortname=winnt 0 2
/dev/mapper/lvmgroup--0-00                none                    swap    defaults,x-systemd.device-timeout=0 0 0


> Another possibility is to recover by isolating a specific snapshot.Are there any snapshots on this file system?

# btrfs restore --list-roots /dev/sdb1
 tree key (EXTENT_TREE ROOT_ITEM 0) 1104642048 level 2
 tree key (DEV_TREE ROOT_ITEM 0) 1105625088 level 1
 tree key (FS_TREE ROOT_ITEM 0) 1103724544 level 3
 tree key (CSUM_TREE ROOT_ITEM 0) 1106067456 level 2
 tree key (UUID_TREE ROOT_ITEM 0) 261371854848 level 0
 tree key (624 ROOT_ITEM 0) 1131315200 level 0
 tree key (DATA_RELOC_TREE ROOT_ITEM 0) 5390336 level 0

> 
> kinda iterative.
> Might be easier to do this on #btrfs, irc.freenode.net because it's

I joined, but "cannot send to nick/channel". Investigating... it's like 15 years that I didn't use IRC back in university days.



