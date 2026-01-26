Return-Path: <linux-btrfs+bounces-21046-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MJ47N+TzdmkzZgEAu9opvQ
	(envelope-from <linux-btrfs+bounces-21046-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Jan 2026 05:56:04 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 8089A840C1
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Jan 2026 05:56:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E35783001014
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Jan 2026 04:56:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 467AF30DEB0;
	Mon, 26 Jan 2026 04:56:00 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1371720E31C
	for <linux-btrfs@vger.kernel.org>; Mon, 26 Jan 2026 04:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769403359; cv=none; b=isuOUYxNxsMGA0B1HHbssr6+LPN3hHnog5d8TK+QU3k9MYJJOGxaTvZ6JKQkmjfVScnl/dN5O49f0mHeLAPGH+4IRtX6OsHPzwfH+pe6za6FbzBIZ0/zwcjpsLqc3cGKNlv8ZkehNmIebgocXQTL6J621i7vPMbL6rIeZLO0QgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769403359; c=relaxed/simple;
	bh=T4tXQwkxWhAuC2FXp/NUGSyvCd8xwXBLlJvEUOFafrU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=aTUFHXCpcaC+rDtsyygoRqBkvRRCpeOEXbdKLGXlONdkg1/jmFJk90YWJY6PM3x8abzqV3MvGjWysyicInxFQWmrPYUxlQSXCXPGEceen8wBSnaxvwcUYLtnKeDWlXYVq3+WcZPUM189gPVEpiK2OFNVd2gVif6L/q9Fma440WY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id C7410227A88; Mon, 26 Jan 2026 05:55:55 +0100 (CET)
Date: Mon, 26 Jan 2026 05:55:55 +0100
From: Christoph Hellwig <hch@lst.de>
To: David Sterba <dsterba@suse.com>
Cc: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Subject: btrfs/124 assert failure / crash
Message-ID: <20260126045555.GB31641@lst.de>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[lst.de : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[linux-btrfs];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	R_DKIM_NA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,lst.de:mid,qemu.org:url];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@lst.de,linux-btrfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21046-lists,linux-btrfs=lfdr.de];
	RCPT_COUNT_THREE(0.00)[3]
X-Rspamd-Queue-Id: 8089A840C1
X-Rspamd-Action: no action

When running xfstets on btrfs with SCRATCH_DEV_POOL enabled, I the
warning below pretty much every time, and then the assert fail crashing
the kernel after it (also in the log below) about every second run.

This is current Linus' tree as of yesterday.

btrfs/124          [  803.258963] run fstests btrfs/124 at 2026-01-24 15:53:31
[  803.459709] BTRFS: device fsid 791f1a52-bc19-4383-b042-6a488112d43c devid 1 transid 60 /dev/vdb (254:16) scanned by mount (383521)
[  803.460698] BTRFS info (device vdb): first mount of filesystem 791f1a52-bc19-4383-b042-6a488112d43c
[  803.461176] BTRFS info (device vdb): using crc32c (crc32c-lib) checksum algorithm
[  803.464844] BTRFS info (device vdb): turning on async discard
[  803.465179] BTRFS info (device vdb): enabling free space tree
[  803.651482] BTRFS info (device vdb): last unmount of filesystem 791f1a52-bc19-4383-b042-6a488112d43c
[  803.705448] BTRFS: device fsid e8352875-c6cb-4da6-8eb2-e1c359bcc4e0 devid 1 transid 6 /dev/vdc (254:32) scanned by mkfs.btrfs (383755)
[  803.706956] BTRFS: device fsid e8352875-c6cb-4da6-8eb2-e1c359bcc4e0 devid 2 transid 6 /dev/nvme0n1 (259:1) scanned by mkfs.btrfs (383755)
[  803.712173] BTRFS info (device vdc): first mount of filesystem e8352875-c6cb-4da6-8eb2-e1c359bcc4e0
[  803.712823] BTRFS info (device vdc): using crc32c (crc32c-lib) checksum algorithm
[  803.717493] BTRFS info (device vdc): checking UUID tree
[  803.718320] BTRFS info (device vdc): turning on async discard
[  803.718662] BTRFS info (device vdc): enabling free space tree
[  803.949121] BTRFS info (device vdc): last unmount of filesystem e8352875-c6cb-4da6-8eb2-e1c359bcc4e0
[  803.960021] BTRFS: device fsid e8352875-c6cb-4da6-8eb2-e1c359bcc4e0 devid 1 transid 7 /dev/vdc (254:32) scanned by mount (383794)
[  803.960973] BTRFS info (device vdc): first mount of filesystem e8352875-c6cb-4da6-8eb2-e1c359bcc4e0
[  803.961489] BTRFS info (device vdc): using crc32c (crc32c-lib) checksum algorithm
[  803.962808] BTRFS warning (device vdc): devid 2 uuid a4f0f038-a059-4f84-87ad-08633e38f9a1 is missing
[  803.963440] BTRFS warning (device vdc): devid 2 uuid a4f0f038-a059-4f84-87ad-08633e38f9a1 is missing
[  803.966467] BTRFS info (device vdc): allowing degraded mounts
[  803.966774] BTRFS info (device vdc): turning on async discard
[  803.967059] BTRFS info (device vdc): enabling free space tree
[  807.379299] BTRFS info (device vdc): last unmount of filesystem e8352875-c6cb-4da6-8eb2-e1c359bcc4e0
[  807.617408] BTRFS info (device vdc): first mount of filesystem e8352875-c6cb-4da6-8eb2-e1c359bcc4e0
[  807.617908] BTRFS info (device vdc): using crc32c (crc32c-lib) checksum algorithm
[  807.620685] BTRFS info (device vdc): turning on async discard
[  807.621015] BTRFS info (device vdc): enabling free space tree
[  807.808679] BTRFS info (device vdc): balance: start -d -m -s
[  807.809220] BTRFS info (device vdc): relocating block group 1808793600 flags data
[  808.017398] BTRFS info (device vdc): found 1 extents, stage: move data extents
[  808.021382] BTRFS info (device vdc): found 1 extents, stage: update data pointers
[  808.023658] BTRFS info (device vdc): relocating block group 1590689792 flags data
[  808.247363] BTRFS info (device vdc): found 1 extents, stage: move data extents
[  808.252635] BTRFS info (device vdc): found 1 extents, stage: update data pointers
[  808.256882] BTRFS info (device vdc): relocating block group 1372585984 flags data
[  808.569603] BTRFS info (device vdc): found 2 extents, stage: move data extents
[  808.573668] BTRFS info (device vdc): found 2 extents, stage: update data pointers
[  808.576237] BTRFS info (device vdc): relocating block group 298844160 flags data|raid1
[  808.579486] BTRFS info (device vdc): relocating block group 30408704 flags metadata|raid1
[  808.579936] ------------[ cut here ]------------
[  808.580175] BTRFS: Transaction aborted (error -28)
[  808.580422] WARNING: fs/btrfs/extent-tree.c:3235 at __btrfs_free_extent.isra.0+0x453/0xfd0, CPU#1: btrfs/383844
[  808.580930] Modules linked in: kvm_intel kvm irqbypass
[  808.581195] CPU: 1 UID: 0 PID: 383844 Comm: btrfs Tainted: G                 N  6.19.0-rc6+ #4788 PREEMPT(full) 
[  808.581713] Tainted: [N]=TEST
[  808.581884] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.17.0-0-gb52ca86e094d-prebuilt.qemu.org 04/01/2014
[  808.582535] RIP: 0010:__btrfs_free_extent.isra.0+0x457/0xfd0
[  808.582839] Code: 00 00 00 5b 5d 41 5c 41 5d 41 5e 41 5f c3 cc cc cc cc 4d 8b 6e 60 4d 8b 66 68 e9 1e fc ff ff 48 8d 3d 3d b1 09 02 8b 74 24 14 <67> 48 0f b9 3a e9 a9 fd ff ff 8b 4c 24 28 48 8b 74 24 20 4c 89 fa
[  808.583795] RSP: 0018:ffffc9000a34b968 EFLAGS: 00010292
[  808.584069] RAX: 0000000000000002 RBX: 0000000002124000 RCX: 0000000000000000
[  808.584432] RDX: 0000000002040001 RSI: 00000000ffffffe4 RDI: ffffffff83c5bae0
[  808.584799] RBP: 0000000000000000 R08: 0000000000000000 R09: 00000000ffffffe4
[  808.585147] R10: ffff888168b8a000 R11: ffff88810fa97940 R12: 0000000000000000
[  808.585531] R13: 0000000000000000 R14: ffff88810df660d8 R15: ffff88812d2dcdd8
[  808.585899] FS:  00007ff8bb7af3c0(0000) GS:ffff8885e762c000(0000) knlGS:0000000000000000
[  808.586347] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  808.586630] CR2: 00007ff8bb94b8f5 CR3: 00000001692ff004 CR4: 0000000000772ef0
[  808.586979] PKRU: 55555554
[  808.587119] Call Trace:
[  808.587250]  <TASK>
[  808.587364]  ? btrfs_tree_mod_log_lowest_seq+0x43/0x50
[  808.587620]  ? btrfs_merge_delayed_refs+0x1b5/0x290
[  808.587866]  ? _raw_spin_unlock+0x13/0x30
[  808.588070]  __btrfs_run_delayed_refs+0x2fa/0xf70
[  808.588312]  ? need_preemptive_reclaim+0x2e/0x180
[  808.588583]  ? start_transaction+0x151/0x870
[  808.588827]  ? __slab_alloc.isra.0+0x67/0xc0
[  808.589069]  btrfs_run_delayed_refs+0x36/0x130
[  808.589329]  btrfs_commit_transaction+0x74/0xd30
[  808.589589]  ? start_transaction+0x227/0x870
[  808.589830]  prepare_to_relocate+0x12f/0x1c0
[  808.590069]  relocate_block_group+0x4f/0x520
[  808.590352]  btrfs_relocate_block_group+0x257/0x390
[  808.590624]  btrfs_relocate_chunk+0x3f/0x170
[  808.590857]  btrfs_balance+0x974/0x1320
[  808.591070]  ? __slab_alloc.isra.0+0x67/0xc0
[  808.591306]  ? __kmalloc_cache_noprof+0x378/0x410
[  808.591559]  btrfs_ioctl+0x2b6e/0x3060
[  808.591767]  ? init_object+0x3d/0xc0
[  808.591966]  ? free_to_partial_list+0xb3/0x520
[  808.592208]  ? __x64_sys_close+0x38/0x80
[  808.592425]  ? _raw_spin_unlock_irqrestore+0x1d/0x40
[  808.592697]  __x64_sys_ioctl+0x91/0xe0
[  808.592900]  do_syscall_64+0x50/0xf80
[  808.593090]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  808.593356] RIP: 0033:0x7ff8bb8c88db
[  808.593544] Code: 00 48 89 44 24 18 31 c0 48 8d 44 24 60 c7 04 24 10 00 00 00 48 89 44 24 08 48 8d 44 24 20 48 89 44 24 10 b8 10 00 00 00 0f 05 <89> c2 3d 00 f0 ff ff 77 1c 48 8b 44 24 18 64 48 2b 04 25 28 00 00
[  808.594491] RSP: 002b:00007ffe4409c590 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
[  808.594870] RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007ff8bb8c88db
[  808.595229] RDX: 00007ffe4409c680 RSI: 00000000c4009420 RDI: 0000000000000003
[  808.595588] RBP: 00007ffe4409eaca R08: 0000000000000000 R09: 0000000000000000
[  808.595947] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
[  808.596315] R13: 00007ffe4409c680 R14: 0000000000000000 R15: 0000000000000002
[  808.596716]  </TASK>
[  808.596846] ---[ end trace 0000000000000000 ]---
[  808.597095] BTRFS info (device vdc state A): dumping space info:
[  808.597424] BTRFS info (device vdc state A): space_info DATA (sub-group id 0) has 610271232 free, is full
[  808.597941] BTRFS info (device vdc state A): space_info total=1869611008, used=1259339776, pinned=0, reserved=0, may_use=0, readonly=0 zone_unusable=0
[  808.598681] BTRFS info (device vdc state A): space_info METADATA (sub-group id 0) has -11010048 free, is full
[  808.599203] BTRFS info (device vdc state A): space_info total=268435456, used=1409024, pinned=0, reserved=16384, may_use=11010048, readonly=267010048 zone_unusable=0
[  808.599994] BTRFS info (device vdc state A): space_info SYSTEM (sub-group id 0) has 8372224 free, is not full
[  808.600522] BTRFS info (device vdc state A): space_info total=8388608, used=16384, pinned=0, reserved=0, may_use=0, readonly=0 zone_unusable=0
[  808.601199] BTRFS info (device vdc state A): global_block_rsv: size 5767168 reserved 5767168
[  808.601639] BTRFS info (device vdc state A): trans_block_rsv: size 0 reserved 0
[  808.602017] BTRFS info (device vdc state A): chunk_block_rsv: size 0 reserved 0
[  808.602418] BTRFS info (device vdc state A): delayed_block_rsv: size 0 reserved 0
[  808.602795] BTRFS info (device vdc state A): delayed_refs_rsv: size 1048576 reserved 1048576
[  808.603220] BTRFS: error (device vdc state A) in __btrfs_free_extent:3235: errno=-28 No space left
[  808.603688] BTRFS info (device vdc state EA): forced readonly
[  808.603994] BTRFS error (device vdc state EA): failed to run delayed ref for logical 34750464 num_bytes 16384 type 176 action 2 ref_mod 1: -28
[  808.604636] BTRFS: error (device vdc state EA) in btrfs_run_delayed_refs:2162: errno=-28 No space left
[  808.605164] BTRFS info (device vdc state EA): 2 enospc errors during balance
[  808.605567] BTRFS info (device vdc state EA): balance: ended with status: -30
[  809.103161] BTRFS error (device vdc state EA): parent transid verify failed on logical 30556160 mirror 2 wanted 8 found 6
[  809.114326] BTRFS error (device vdc state EA): parent transid verify failed on logical 30588928 mirror 2 wanted 8 found 6
[  809.126031] BTRFS warning (device vdc state EA): csum failed root 5 ino 258 off 423231488 csum 0x624836f2 expected csum 0x8941f998 mirror 2
[  809.126176] BTRFS warning (device vdc state EA): csum failed root 5 ino 258 off 422576128 csum 0x33f2863b expected csum 0x8941f998 mirror 2
[  809.126877] btrfs_dev_stat_inc_and_print: 67333 callbacks suppressed
[  809.126878] BTRFS error (device vdc state EA): bdev /dev/nvme0n1 errs: wr 0, rd 0, flush 0, corrupt 1, gen 0
[  809.126896] BTRFS warning (device vdc state EA): csum failed root 5 ino 258 off 425328640 csum 0xe90a7889 expected csum 0x8941f998 mirror 2
[  809.127540] BTRFS error (device vdc state EA): bdev /dev/nvme0n1 errs: wr 0, rd 0, flush 0, corrupt 2, gen 0
[  809.127873] BTRFS error (device vdc state EA): bdev /dev/nvme0n1 errs: wr 0, rd 0, flush 0, corrupt 3, gen 0
[  809.128397] BTRFS warning (device vdc state EA): csum failed root 5 ino 258 off 422580224 csum 0x7f6b1842 expected csum 0x8941f998 mirror 2
[  809.129104] BTRFS warning (device vdc state EA): csum failed root 5 ino 258 off 425332736 csum 0xe90a7889 expected csum 0x8941f998 mirror 2
[  809.129638] BTRFS error (device vdc state EA): bdev /dev/nvme0n1 errs: wr 0, rd 0, flush 0, corrupt 4, gen 0
[  809.130137] BTRFS error (device vdc state EA): bdev /dev/nvme0n1 errs: wr 0, rd 0, flush 0, corrupt 5, gen 0
[  809.132576] BTRFS warning (device vdc state EA): csum failed root 5 ino 258 off 423235584 csum 0x624836f2 expected csum 0x8941f998 mirror 2
[  809.133320] BTRFS error (device vdc state EA): bdev /dev/nvme0n1 errs: wr 0, rd 0, flush 0, corrupt 6, gen 0
[  809.133862] BTRFS warning (device vdc state EA): csum failed root 5 ino 258 off 423239680 csum 0x624836f2 expected csum 0x8941f998 mirror 2
[  809.134300] BTRFS warning (device vdc state EA): csum failed root 5 ino 258 off 422584320 csum 0x7f6b1842 expected csum 0x8941f998 mirror 2
[  809.134603] BTRFS warning (device vdc state EA): csum failed root 5 ino 258 off 424280064 csum 0xa45e27b2 expected csum 0x8941f998 mirror 2
[  809.135880] BTRFS error (device vdc state EA): bdev /dev/nvme0n1 errs: wr 0, rd 0, flush 0, corrupt 7, gen 0
[  809.136402] BTRFS warning (device vdc state EA): csum failed root 5 ino 258 off 424284160 csum 0x9b0a6b95 expected csum 0x8941f998 mirror 2
[  809.137102] BTRFS error (device vdc state EA): bdev /dev/nvme0n1 errs: wr 0, rd 0, flush 0, corrupt 8, gen 0
[  809.137641] BTRFS error (device vdc state EA): bdev /dev/nvme0n1 errs: wr 0, rd 0, flush 0, corrupt 9, gen 0
[  809.138214] BTRFS error (device vdc state EA): bdev /dev/nvme0n1 errs: wr 0, rd 0, flush 0, corrupt 10, gen 0
[  809.143190] assertion failed: !(fs_info->sb->s_flags & SB_RDONLY) :: 0, in fs/btrfs/bio.c:938
[  809.144241] ------------[ cut here ]------------
[  809.144747] assertion failed: !(fs_info->sb->s_flags & SB_RDONLY) :: 0, in fs/btrfs/bio.c:938
[  809.144830] kernel BUG at fs/btrfs/bio.c:938!
[  809.144835] Oops: invalid opcode: 0000 [#1] SMP NOPTI
[  809.144837] CPU: 0 UID: 0 PID: 868 Comm: kworker/u8:13 Tainted: G        W        N  6.19.0-rc6+ #4788 PREEMPT(full) 
[  809.144839] Tainted: [W]=WARN, [N]=TEST
[  809.144840] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.17.0-0-gb52ca86e094d-prebuilt.qemu.org 04/01/2014
[  809.144841] Workqueue: btrfs-endio simple_end_io_work
[  809.144844] RIP: 0010:btrfs_repair_io_failure.cold+0xb2/0x120
[  809.144847] Code: 82 e8 18 52 fc ff 0f 0b 41 b8 aa 03 00 00 48 c7 c1 f7 2b 07 83 31 d2 48 c7 c6 88 68 fb 82 48 c7 c7 f0 54 fa 82 e8 f4 51 fc ff <0f> 0b 41 b8 b4 03 00 00 48 c7 c1 f7 2b 07 83 31 d2 48 c7 c6 3d 2c
[  809.144848] RSP: 0000:ffffc90001d2bcf0 EFLAGS: 00010246
[  809.144849] RAX: 0000000000000051 RBX: 0000000000001000 RCX: 0000000000000000
[  809.144850] RDX: 0000000000000000 RSI: ffffffff8305cf42 RDI: 00000000ffffffff
[  809.144850] RBP: 0000000000000002 R08: 00000000fffeffff R09: ffffffff837fa988
[  809.144851] R10: ffffffff8327a9e0 R11: 6f69747265737361 R12: ffff88813018d310
[  809.144851] R13: ffff888168b8a000 R14: ffffc90001d2bd90 R15: ffff88810a169000
[  809.144852] FS:  0000000000000000(0000) GS:ffff8885e752c000(0000) knlGS:0000000000000000
[  809.144854] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  809.145320] ------------[ cut here ]------------
[  809.145542] CR2: 00007fee38baa000 CR3: 0000000106f7f006 CR4: 0000000000772ef0
[  809.145807] kernel BUG at fs/btrfs/bio.c:938!
[  809.146282] PKRU: 55555554
[  809.146282] Call Trace:
[  809.146282]  <TASK>
[  809.146282]  btrfs_end_repair_bio+0x189/0x280
[  809.146282]  ? _raw_spin_unlock+0x13/0x30
[  809.146282]  ? move_linked_works+0x6b/0xa0
[  809.146282]  process_one_work+0x16c/0x330
[  809.146282]  worker_thread+0x254/0x3a0
[  809.146282]  ? __pfx_worker_thread+0x10/0x10
[  809.146282]  kthread+0x117/0x230
[  809.146282]  ? __pfx_kthread+0x10/0x10
[  809.146282]  ? __pfx_kthread+0x10/0x10
[  809.146282]  ret_from_fork+0x1b6/0x200
[  809.146282]  ? __pfx_kthread+0x10/0x10
[  809.146282]  ret_from_fork_asm+0x1a/0x30
[  809.146282]  </TASK>
[  809.146282] Modules linked in:
[  809.147371] assertion failed: !(fs_info->sb->s_flags & SB_RDONLY) :: 0, in fs/btrfs/bio.c:938
[  809.146282]  kvm_intel kvm irqbypass
[  809.147585] ---[ end trace 0000000000000000 ]---
[  809.147921] ------------[ cut here ]------------


