Return-Path: <linux-btrfs+bounces-21313-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qMxECmvzgWkMNAMAu9opvQ
	(envelope-from <linux-btrfs+bounces-21313-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Tue, 03 Feb 2026 14:08:59 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D422D9AD9
	for <lists+linux-btrfs@lfdr.de>; Tue, 03 Feb 2026 14:08:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A8A0E313A60D
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Feb 2026 13:03:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9253234BA42;
	Tue,  3 Feb 2026 13:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s4emBvuU"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDA6634EEE3
	for <linux-btrfs@vger.kernel.org>; Tue,  3 Feb 2026 13:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770123756; cv=none; b=L1WJ1/b8lV4NPbWLv27+nGT0Y74KZZTMb/KvGVZ1TV6xq1Kalubvhak1qYx1KU4c1eWL3CD0R/mcuv12w1UxvgXegwYR+9TW9iVEg151VWEkm6+aMVUfEM52eNTUtluptdpZRk0zog3XRHOghImDqMjM1gxKk01LC7vu/CDEjcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770123756; c=relaxed/simple;
	bh=LGy4hhFFSe1eePeThBpPBiezU37WXEDcR43mUhCpgLI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UR+3npoL2G+GBn292f37Q1V3nwIS+I41TOcjdDhggiPMNS61bIyxEilSQOItM0rzRyRK25sYmGM4sIkLCl+NhaAw/ozwYRXNAr9JenRg7hFpBgbul1ZH/dNIoxNVcUaCl3g6fJmSP3ndSBdZfHEI72SNUjWw1uottgg9J6Ga8mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s4emBvuU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42131C19421
	for <linux-btrfs@vger.kernel.org>; Tue,  3 Feb 2026 13:02:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770123756;
	bh=LGy4hhFFSe1eePeThBpPBiezU37WXEDcR43mUhCpgLI=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=s4emBvuUrBnBEcjy1CPQ6qWYAZo0TXNxzVXe+W1UxUaxPqecOOYw/YYh2C+WQ3n4X
	 RE4ftel+ZzYugjvE6YX/nR1dSAx83Dt8B8qJAPC10UHtE5Zo308tnYAa70tQ9yauct
	 N2SsMajGMczw2eRFYOk7y20LVoeYfggst3rLnAvPWgMjmzn7qsH32GusZb6m5c/CkB
	 wWP5f+wsprPo/P2wtwL+JTAbjzSGLT8Jum52gs3DmGQdYUeO8zWrKtn/frOlM0LdBR
	 mCkpSNaVyIly+VOtOs9iOUWpNrd0NgKn0A53HQdCGI/PLMhjLEJu2NZpBiazz6ItTf
	 v5Wwalr23V1/w==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 1/3] btrfs: be less agressive with metadata overcommit when we can do full flushing
Date: Tue,  3 Feb 2026 13:02:31 +0000
Message-ID: <213736b4ab22e6ecdd6a10513eaed5d85b4053bc.1770123545.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.1770123544.git.fdmanana@suse.com>
References: <cover.1770123544.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_ONE(0.00)[1];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-21313-lists,linux-btrfs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fdmanana@kernel.org,linux-btrfs@vger.kernel.org];
	FROM_NO_DN(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,suse.com:mid,suse.com:email,belden.com:email]
X-Rspamd-Queue-Id: 8D422D9AD9
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

Reported-by: Aleksandar Gerasimovski <Aleksandar.Gerasimovski@belden.com>
Link: https://lore.kernel.org/linux-btrfs/SA1PR18MB56922F690C5EC2D85371408B998FA@SA1PR18MB5692.namprd18.prod.outlook.com/
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


