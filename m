Return-Path: <linux-btrfs+bounces-21344-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6EGyLRyHgmnDVwMAu9opvQ
	(envelope-from <linux-btrfs+bounces-21344-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Wed, 04 Feb 2026 00:39:08 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 579EFDFC9A
	for <lists+linux-btrfs@lfdr.de>; Wed, 04 Feb 2026 00:39:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4354C302F893
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Feb 2026 23:39:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E2F5330665;
	Tue,  3 Feb 2026 23:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mj1oXlNa"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9227832C925
	for <linux-btrfs@vger.kernel.org>; Tue,  3 Feb 2026 23:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770161945; cv=none; b=tV5Jm9sPEGGfd/oBuisp4O6FY3ZunfbzTUMomspQQm/j584LrTQ6uOxa3n0IB/9PIGo3/DFuEjkDEpybur2YqbVHqblFbqNufX3kGDnlEAIGPK2xzCn5ydJUB8/vq2AEpGR2Q2ofOxwTHEvt7ftg1bhx7Wm4l5VMhmSWfgvRXD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770161945; c=relaxed/simple;
	bh=J4ubFeOMvTyNuzKMVjFE/7a10YJRNIcGY0C8ZGpYcUo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I3hFl0RlUJ7F581bQi6pgA/+yHkMOPLhds0/mmFMReOymqnYt8Er7Ym2GNhxBGbx/Ouj79Qlk/tOWBLH/x8dc0Z++5DHxpK1A59KLfJh+spBIRn4oMumD4zR38CIWvuq4/yXjm/JdOWARuXqLRtAbsx/dCe4eTCpq2SoGDHD/Vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mj1oXlNa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0338DC19425
	for <linux-btrfs@vger.kernel.org>; Tue,  3 Feb 2026 23:39:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770161945;
	bh=J4ubFeOMvTyNuzKMVjFE/7a10YJRNIcGY0C8ZGpYcUo=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=mj1oXlNa/jHLRaRfk2rkcfgniiCDX2CP7rAZQHsQWYYXv+wfvvdAeQMu6LYwqHdye
	 DwM9JqkfGzIEn8LsZi+pxnbr7QvSUPVixPO+RVVC/xjSF2HKDIrTuTwz5qalulZsaQ
	 bPcebXUBCxudd+1mj2bROWAEYjqgbpfYSAp/Oh8t0m9NY7egvVG9QT5LtAAtW+BVyW
	 SaHW9kF2KtLkotG9D+mJ+1tJk9Eftiu83VIWfLEs+gtVtlbWJh8LRJwkr12nvpRItn
	 VD4RkqDcrQ2oOWBxbfCLYNxsqU5hm6cGvOunpeat+fUMQLK5c0+K5V+ELtNu1GavfK
	 ruIgtMq6OuZAA==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 1/3] btrfs: be less agressive with metadata overcommit when we can do full flushing
Date: Tue,  3 Feb 2026 23:38:59 +0000
Message-ID: <c515344cea712e174e3cd8c0e6994adcc9f2ce35.1770161798.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.1770161798.git.fdmanana@suse.com>
References: <cover.1770161798.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.94 / 15.00];
	SUSPICIOUS_URL_IN_SUSPICIOUS_MESSAGE(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	URIBL_RED(0.50)[test.sh:url];
	MAILLIST(-0.15)[generic];
	BAD_REP_POLICIES(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_ANON_DOMAIN(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21344-lists,linux-btrfs=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[fdmanana@kernel.org,linux-btrfs@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	R_DKIM_ALLOW(0.00)[kernel.org:s=k20201202];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_ONE(0.00)[1];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_SPAM(0.00)[0.967];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	R_SPF_ALLOW(0.00)[+ip6:2600:3c09:e001:a7::/64:c];
	TAGGED_RCPT(0.00)[linux-btrfs];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email,qemu.org:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,test.sh:url,belden.com:email]
X-Rspamd-Queue-Id: 579EFDFC9A
X-Rspamd-Action: no action

From: Filipe Manana <fdmanana@suse.com>

Over the years we often get reports of some -ENOSPC failure while updating
metadata that leads to a transaction abort. I have seen this happen for
filesystems of all sizes and with workloads that are very user/customer
specific and unable to reproduce, but Aleksandar recently reported a
simple way to reproduce this with a 1G filesystem and using the bonnie++
benchmark tool. The following test script reproduces the failure:

    $ cat test.sh
    #!/bin/bash

    # Create and use a 1G null block device, memory backed, otherwise
    # the test takes a very long time.
    modprobe null_blk nr_devices="0"
    null_dev="/sys/kernel/config/nullb/nullb0"
    mkdir "$null_dev"
    size=$((1 * 1024)) # in MB
    echo 2 > "$null_dev/submit_queues"
    echo "$size" > "$null_dev/size"
    echo 1 > "$null_dev/memory_backed"
    echo 1 > "$null_dev/discard"
    echo 1 > "$null_dev/power"

    DEV=/dev/nullb0
    MNT=/mnt/nullb0

    mkfs.btrfs -f $DEV
    mount $DEV $MNT

    mkdir $MNT/test/
    bonnie++ -d $MNT/test/ -m BTRFS -u 0 -s 256M -r 128M -b

    umount $MNT

    echo 0 > "$null_dev/power"
    rmdir "$null_dev"

When running this bonnie++ fails in the phase where it deletes test
directories and files:

    $ ./test.sh
    (...)
    Using uid:0, gid:0.
    Writing a byte at a time...done
    Writing intelligently...done
    Rewriting...done
    Reading a byte at a time...done
    Reading intelligently...done
    start 'em...done...done...done...done...done...
    Create files in sequential order...done.
    Stat files in sequential order...done.
    Delete files in sequential order...done.
    Create files in random order...done.
    Stat files in random order...done.
    Delete files in random order...Can't sync directory, turning off dir-sync.
    Can't delete file 9Bq7sr0000000338
    Cleaning up test directory after error.
    Bonnie: drastic I/O error (rmdir): Read-only file system

And in the syslog/dmesg we can see the following transaction abort trace:

    [161915.501506] BTRFS warning (device nullb0): Skipping commit of aborted transaction.
    [161915.502983] ------------[ cut here ]------------
    [161915.503832] BTRFS: Transaction aborted (error -28)
    [161915.504748] WARNING: fs/btrfs/transaction.c:2045 at btrfs_commit_transaction+0xa21/0xd30 [btrfs], CPU#11: bonnie++/3377975
    [161915.506786] Modules linked in: btrfs dm_zero dm_snapshot (...)
    [161915.518759] CPU: 11 UID: 0 PID: 3377975 Comm: bonnie++ Tainted: G        W           6.19.0-rc7-btrfs-next-224+ #4 PREEMPT(full)
    [161915.520857] Tainted: [W]=WARN
    [161915.521405] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.2-0-gea1b7a073390-prebuilt.qemu.org 04/01/2014
    [161915.523414] RIP: 0010:btrfs_commit_transaction+0xa24/0xd30 [btrfs]
    [161915.524630] Code: 48 8b 7c 24 (...)
    [161915.526982] RSP: 0018:ffffd3fe8206fda8 EFLAGS: 00010292
    [161915.527707] RAX: 0000000000000002 RBX: ffff8f4886d3c000 RCX: 0000000000000000
    [161915.528723] RDX: 0000000002040001 RSI: 00000000ffffffe4 RDI: ffffffffc088f780
    [161915.529691] RBP: ffff8f4f5adae7e0 R08: 0000000000000000 R09: ffffd3fe8206fb90
    [161915.530842] R10: ffff8f4f9c1fffa8 R11: 0000000000000003 R12: 00000000ffffffe4
    [161915.532027] R13: ffff8f4ef2cf2400 R14: ffff8f4f5adae708 R15: ffff8f4f62d18000
    [161915.533229] FS:  00007ff93112a780(0000) GS:ffff8f4ff63ee000(0000) knlGS:0000000000000000
    [161915.534611] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
    [161915.535575] CR2: 00005571b3072000 CR3: 0000000176080005 CR4: 0000000000370ef0
    [161915.536758] Call Trace:
    [161915.537185]  <TASK>
    [161915.537575]  btrfs_sync_file+0x431/0x530 [btrfs]
    [161915.538473]  do_fsync+0x39/0x80
    [161915.539042]  __x64_sys_fsync+0xf/0x20
    [161915.539750]  do_syscall_64+0x50/0xf20
    [161915.540396]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
    [161915.541301] RIP: 0033:0x7ff930ca49ee
    [161915.541904] Code: 08 0f 85 f5 (...)
    [161915.544830] RSP: 002b:00007ffd94291f38 EFLAGS: 00000246 ORIG_RAX: 000000000000004a
    [161915.546152] RAX: ffffffffffffffda RBX: 00007ff93112a780 RCX: 00007ff930ca49ee
    [161915.547263] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000003
    [161915.548383] RBP: 0000000000000dab R08: 0000000000000000 R09: 0000000000000000
    [161915.549853] R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffd94291fb0
    [161915.551196] R13: 00007ffd94292350 R14: 0000000000000001 R15: 00007ffd94292340
    [161915.552161]  </TASK>
    [161915.552457] ---[ end trace 0000000000000000 ]---
    [161915.553232] BTRFS info (device nullb0 state A): dumping space info:
    [161915.553236] BTRFS info (device nullb0 state A): space_info DATA (sub-group id 0) has 12582912 free, is not full
    [161915.553239] BTRFS info (device nullb0 state A): space_info total=12582912, used=0, pinned=0, reserved=0, may_use=0, readonly=0 zone_unusable=0
    [161915.553243] BTRFS info (device nullb0 state A): space_info METADATA (sub-group id 0) has -5767168 free, is full
    [161915.553245] BTRFS info (device nullb0 state A): space_info total=53673984, used=6635520, pinned=46956544, reserved=16384, may_use=5767168, readonly=65536 zone_unusable=0
    [161915.553251] BTRFS info (device nullb0 state A): space_info SYSTEM (sub-group id 0) has 8355840 free, is not full
    [161915.553254] BTRFS info (device nullb0 state A): space_info total=8388608, used=16384, pinned=16384, reserved=0, may_use=0, readonly=0 zone_unusable=0
    [161915.553257] BTRFS info (device nullb0 state A): global_block_rsv: size 5767168 reserved 5767168
    [161915.553261] BTRFS info (device nullb0 state A): trans_block_rsv: size 0 reserved 0
    [161915.553263] BTRFS info (device nullb0 state A): chunk_block_rsv: size 0 reserved 0
    [161915.553265] BTRFS info (device nullb0 state A): remap_block_rsv: size 0 reserved 0
    [161915.553268] BTRFS info (device nullb0 state A): delayed_block_rsv: size 0 reserved 0
    [161915.553270] BTRFS info (device nullb0 state A): delayed_refs_rsv: size 0 reserved 0
    [161915.553272] BTRFS: error (device nullb0 state A) in cleanup_transaction:2045: errno=-28 No space left
    [161915.554463] BTRFS info (device nullb0 state EA): forced readonly

The problem is that we allow for a very agressive metadata overcommit,
about 1/8th of the currently available space, even when the task
attempting the reservation allows for full flushing. Over time this allows
more and more tasks to overcommit without getting a transaction commit to
release pinned extents, joining the same transaction and eventually lead
to the transaction abort when attempting some tree update, as the extent
allocator is not able to find any available metadata extent and it's not
able to allocate a new metadata block group either (not enough unallocated
space for that).

Fix this by allowing the overcommit to be up to 1/64th of the available
(unallocated) space instead and for that limit to apply to both types of
full flushing, BTRFS_RESERVE_FLUSH_ALL and BTRFS_RESERVE_FLUSH_ALL_STEAL.
This way we get more frequent transaction commits to release pinned
extents in case our caller is in a context where full flushing is allowed.

Note that the space infos dump in the dmesg/syslog right after the
transaction abort give the wrong idea that we have plenty of unallocated
space when the abort happened. During the bonnie++ workload we had a
metadata chunk allocaton attempt and it failed with -ENOSPC because at
that time we had a bunch of data block groups allocated, which then became
empty and got deleted by the cleaner kthread after the metadata chunk
allocation failed with -ENOSPC and before the transaction abort happened
and dumped the space infos.

The custom tracing (some trace_printk() calls spread in strategic places)
used to check that:

  mount-1793735 [011] ...1. 28877.261096: btrfs_add_bg_to_space_info: added bg offset 13631488 length 8388608 flags 1 to space_info->flags 1 total_bytes 8388608 bytes_used 0 bytes_may_use 0
  mount-1793735 [011] ...1. 28877.261098: btrfs_add_bg_to_space_info: added bg offset 22020096 length 8388608 flags 34 to space_info->flags 2 total_bytes 8388608 bytes_used 16384 bytes_may_use 0
  mount-1793735 [011] ...1. 28877.261100: btrfs_add_bg_to_space_info: added bg offset 30408704 length 53673984 flags 36 to space_info->flags 4 total_bytes 53673984 bytes_used 131072 bytes_may_use 0

These are from loading the block groups created by mkfs during mount.

Then when bonnie++ starts doing its thing:

  kworker/u48:5-1792004 [011] ..... 28886.122050: btrfs_create_chunk: gather_device_info 1 ctl->dev_extent_min = 65536 dev_extent_want 1073741824
  kworker/u48:5-1792004 [011] ..... 28886.122053: btrfs_create_chunk: gather_device_info 2 ctl->dev_extent_min = 65536 dev_extent_want 1073741824 max_avail 927596544
  kworker/u48:5-1792004 [011] ..... 28886.122055: btrfs_make_block_group: make bg offset 84082688 size 117440512 type 1
  kworker/u48:5-1792004 [011] ...1. 28886.122064: btrfs_add_bg_to_space_info: added bg offset 84082688 length 117440512 flags 1 to space_info->flags 1 total_bytes 125829120 bytes_used 0 bytes_may_use 5251072

First allocation of a data block group of 112M.

  kworker/u48:5-1792004 [011] ..... 28886.192408: btrfs_create_chunk: gather_device_info 1 ctl->dev_extent_min = 65536 dev_extent_want 1073741824
  kworker/u48:5-1792004 [011] ..... 28886.192413: btrfs_create_chunk: gather_device_info 2 ctl->dev_extent_min = 65536 dev_extent_want 1073741824 max_avail 810156032
  kworker/u48:5-1792004 [011] ..... 28886.192415: btrfs_make_block_group: make bg offset 201523200 size 117440512 type 1
  kworker/u48:5-1792004 [011] ...1. 28886.192425: btrfs_add_bg_to_space_info: added bg offset 201523200 length 117440512 flags 1 to space_info->flags 1 total_bytes 243269632 bytes_used 0 bytes_may_use 122691584

Another 112M data block group allocated.

  kworker/u48:5-1792004 [011] ..... 28886.260935: btrfs_create_chunk: gather_device_info 1 ctl->dev_extent_min = 65536 dev_extent_want 1073741824
  kworker/u48:5-1792004 [011] ..... 28886.260941: btrfs_create_chunk: gather_device_info 2 ctl->dev_extent_min = 65536 dev_extent_want 1073741824 max_avail 692715520
  kworker/u48:5-1792004 [011] ..... 28886.260943: btrfs_make_block_group: make bg offset 318963712 size 117440512 type 1
  kworker/u48:5-1792004 [011] ...1. 28886.260954: btrfs_add_bg_to_space_info: added bg offset 318963712 length 117440512 flags 1 to space_info->flags 1 total_bytes 360710144 bytes_used 0 bytes_may_use 240132096

Yet another one.

  bonnie++-1793755 [010] ..... 28886.280407: btrfs_create_chunk: gather_device_info 1 ctl->dev_extent_min = 65536 dev_extent_want 1073741824
  bonnie++-1793755 [010] ..... 28886.280412: btrfs_create_chunk: gather_device_info 2 ctl->dev_extent_min = 65536 dev_extent_want 1073741824 max_avail 575275008
  bonnie++-1793755 [010] ..... 28886.280414: btrfs_make_block_group: make bg offset 436404224 size 117440512 type 1
  bonnie++-1793755 [010] ...1. 28886.280419: btrfs_add_bg_to_space_info: added bg offset 436404224 length 117440512 flags 1 to space_info->flags 1 total_bytes 478150656 bytes_used 0 bytes_may_use 268435456

One more.

  kworker/u48:5-1792004 [011] ..... 28886.566233: btrfs_create_chunk: gather_device_info 1 ctl->dev_extent_min = 65536 dev_extent_want 1073741824
  kworker/u48:5-1792004 [011] ..... 28886.566238: btrfs_create_chunk: gather_device_info 2 ctl->dev_extent_min = 65536 dev_extent_want 1073741824 max_avail 457834496
  kworker/u48:5-1792004 [011] ..... 28886.566241: btrfs_make_block_group: make bg offset 553844736 size 117440512 type 1
  kworker/u48:5-1792004 [011] ...1. 28886.566250: btrfs_add_bg_to_space_info: added bg offset 553844736 length 117440512 flags 1 to space_info->flags 1 total_bytes 595591168 bytes_used 268435456 bytes_may_use 209723392

Another one.

  bonnie++-1793755 [009] ..... 28886.613446: btrfs_create_chunk: gather_device_info 1 ctl->dev_extent_min = 65536 dev_extent_want 1073741824
  bonnie++-1793755 [009] ..... 28886.613451: btrfs_create_chunk: gather_device_info 2 ctl->dev_extent_min = 65536 dev_extent_want 1073741824 max_avail 340393984
  bonnie++-1793755 [009] ..... 28886.613453: btrfs_make_block_group: make bg offset 671285248 size 117440512 type 1
  bonnie++-1793755 [009] ...1. 28886.613458: btrfs_add_bg_to_space_info: added bg offset 671285248 length 117440512 flags 1 to space_info->flags 1 total_bytes 713031680 bytes_used 268435456 bytes_may_use 2 68435456

Another one.

  bonnie++-1793755 [009] ..... 28886.674953: btrfs_create_chunk: gather_device_info 1 ctl->dev_extent_min = 65536 dev_extent_want 1073741824
  bonnie++-1793755 [009] ..... 28886.674957: btrfs_create_chunk: gather_device_info 2 ctl->dev_extent_min = 65536 dev_extent_want 1073741824 max_avail 222953472
  bonnie++-1793755 [009] ..... 28886.674959: btrfs_make_block_group: make bg offset 788725760 size 117440512 type 1
  bonnie++-1793755 [009] ...1. 28886.674963: btrfs_add_bg_to_space_info: added bg offset 788725760 length 117440512 flags 1 to space_info->flags 1 total_bytes 830472192 bytes_used 268435456 bytes_may_use 1 34217728

Another one.

  bonnie++-1793755 [009] ..... 28886.674981: btrfs_create_chunk: gather_device_info 1 ctl->dev_extent_min = 65536 dev_extent_want 1073741824
  bonnie++-1793755 [009] ..... 28886.674982: btrfs_create_chunk: gather_device_info 2 ctl->dev_extent_min = 65536 dev_extent_want 1073741824 max_avail 105512960
  bonnie++-1793755 [009] ..... 28886.674983: btrfs_make_block_group: make bg offset 906166272 size 105512960 type 1
  bonnie++-1793755 [009] ...1. 28886.674984: btrfs_add_bg_to_space_info: added bg offset 906166272 length 105512960 flags 1 to space_info->flags 1 total_bytes 935985152 bytes_used 268435456 bytes_may_use 67108864

Another one, but a bit smaller (~100.6M) since we now have less space.

  bonnie++-1793758 [009] ..... 28891.962096: btrfs_create_chunk: gather_device_info 1 ctl->dev_extent_min = 65536 dev_extent_want 1073741824
  bonnie++-1793758 [009] ..... 28891.962103: btrfs_create_chunk: gather_device_info 2 ctl->dev_extent_min = 65536 dev_extent_want 1073741824 max_avail 12582912
  bonnie++-1793758 [009] ..... 28891.962105: btrfs_make_block_group: make bg offset 1011679232 size 12582912 type 1
  bonnie++-1793758 [009] ...1. 28891.962114: btrfs_add_bg_to_space_info: added bg offset 1011679232 length 12582912 flags 1 to space_info->flags 1 total_bytes 948568064 bytes_used 268435456 bytes_may_use 8192

Another one, this one even smaller (12M).

   kworker/u48:5-1792004 [011] ..... 28892.112802: btrfs_chunk_alloc: enter first metadata chunk alloc attempt
   kworker/u48:5-1792004 [011] ..... 28892.112805: btrfs_create_chunk: gather_device_info 1 ctl->dev_extent_min = 131072 dev_extent_want 536870912
   kworker/u48:5-1792004 [011] ..... 28892.112806: btrfs_create_chunk: gather_device_info 2 ctl->dev_extent_min = 131072 dev_extent_want 536870912 max_avail 0

536870912 is 512M, the standard 256M metadata chunk size times 2 because
of the DUP profile for metadata.
'max_avail' is what find_free_dev_extent() returns to us in
gather_device_info().

As a result, gather_device_info() sets ctl->ndevs to 0, making
decide_stripe_size() fail with -ENOSPC, and therefore metadata chunk
allocation fails while we are attempting to run delayed items during
the transaction commit.

   kworker/u48:5-1792004 [011] ..... 28892.112807: btrfs_create_chunk:
decide_stripe_size fail -ENOSPC

In the syslog/dmesg pasted above, which happened after the transaction was
aborted, the space info dumps did not account for all these data block
groups that were allocated during bonnie++'s workload. And that is because
after the metadata chunk allocation failed with -ENOSPC and before the
transaction abort happened, most of the data block groups had become empty
and got deleted by by the cleaner kthread - when the abort happened, we
had bonnie++ in the middle of deleting the files it created.

But dumping the space infos right after the metdata chunk allocation fails
by adding a call to btrfs_dump_space_info_for_trans_abort() in
decide_stripe_size() when it returns -ENOSPC, we get:

  [29972.409295] BTRFS info (device nullb0): dumping space info:
  [29972.409300] BTRFS info (device nullb0): space_info DATA (sub-group id 0) has 673341440 free, is not full
  [29972.409303] BTRFS info (device nullb0): space_info total=948568064, used=0, pinned=275226624, reserved=0, may_use=0, readonly=0 zone_unusable=0
  [29972.409305] BTRFS info (device nullb0): space_info METADATA (sub-group id 0) has 3915776 free, is not full
  [29972.409306] BTRFS info (device nullb0): space_info total=53673984, used=163840, pinned=42827776, reserved=147456, may_use=6553600, readonly=65536 zone_unusable=0
  [29972.409308] BTRFS info (device nullb0): space_info SYSTEM (sub-group id 0) has 7979008 free, is not full
  [29972.409310] BTRFS info (device nullb0): space_info total=8388608, used=16384, pinned=0, reserved=0, may_use=393216, readonly=0 zone_unusable=0
  [29972.409311] BTRFS info (device nullb0): global_block_rsv: size 5767168 reserved 5767168
  [29972.409313] BTRFS info (device nullb0): trans_block_rsv: size 0 reserved 0
  [29972.409314] BTRFS info (device nullb0): chunk_block_rsv: size 393216 reserved 393216
  [29972.409315] BTRFS info (device nullb0): remap_block_rsv: size 0 reserved 0
  [29972.409316] BTRFS info (device nullb0): delayed_block_rsv: size 0 reserved 0

So here we see there's ~904.6M of data space, ~51.2M of metdata space and
8M of system space, making a total of 963.8M.

Reported-by: Aleksandar Gerasimovski <Aleksandar.Gerasimovski@belden.com>
Link: https://lore.kernel.org/linux-btrfs/SA1PR18MB56922F690C5EC2D85371408B998FA@SA1PR18MB5692.namprd18.prod.outlook.com/
Link: https://lore.kernel.org/linux-btrfs/CAL3q7H61vZ3_+eqJ1A9po2WcgNJJjUu9MJQoYB2oDSAAecHaug@mail.gmail.com/
Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/space-info.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index bb5aac7ee9d2..8192edf92d26 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -489,10 +489,11 @@ static u64 calc_available_free_space(const struct btrfs_space_info *space_info,
 	/*
 	 * If we aren't flushing all things, let us overcommit up to
 	 * 1/2th of the space. If we can flush, don't let us overcommit
-	 * too much, let it overcommit up to 1/8 of the space.
+	 * too much, let it overcommit up to 1/64th of the space.
 	 */
-	if (flush == BTRFS_RESERVE_FLUSH_ALL)
-		avail >>= 3;
+	if (flush == BTRFS_RESERVE_FLUSH_ALL ||
+	    flush == BTRFS_RESERVE_FLUSH_ALL_STEAL)
+		avail >>= 6;
 	else
 		avail >>= 1;
 
-- 
2.47.2


