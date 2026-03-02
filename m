Return-Path: <linux-btrfs+bounces-22153-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iCTbHTajpWngCwAAu9opvQ
	(envelope-from <linux-btrfs+bounces-22153-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Mon, 02 Mar 2026 15:48:22 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D2A01DB21B
	for <lists+linux-btrfs@lfdr.de>; Mon, 02 Mar 2026 15:48:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D0CF13030058
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Mar 2026 14:40:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C63693FFAB6;
	Mon,  2 Mar 2026 14:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="HXt5LTRE"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB62C401488
	for <linux-btrfs@vger.kernel.org>; Mon,  2 Mar 2026 14:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772462398; cv=none; b=RCXkz508jNjZ3u25Es7biZUT1p+Jcv2mSc+mAhx+/r8ySBekR60dujN7VTH1pmZ+K2wf2RagbXd8NSOL5/DZvb/lBiYp8iF96vDHp/X+aS3FCyCq1TC2rqeOfUieERdl1VCqKaxlTirlS19YVzUD2dsA7ht6Uf+fXtfCE7p6DD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772462398; c=relaxed/simple;
	bh=R2jRRZR89ZyjH2k3RcGt0wbjC/35yRHZup/v9h3wPbc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uJxdgBl/973U679tmHp9Cci05e8I1DmDBEI+7w89jEMgrYTYJapPtDbPtw8LfAaTvjSRrMc0MkaivK7C2EnaL3wl/epzqUCF81an6HICWGwVn1cXNSCXqTC1a4k4+w4Zc9SoQsmDKUFDUM2x0VIPT/SBqPLwvSJG1GicH7s8dGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=HXt5LTRE; arc=none smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1772462396; x=1803998396;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=R2jRRZR89ZyjH2k3RcGt0wbjC/35yRHZup/v9h3wPbc=;
  b=HXt5LTREWoATJ/agMsLmaQ4RpxMD168ujs8zejBz9NwAewGP6arHukiT
   PMyj3kSg5neqku8m5Q9efQNYfoonpTqDJ4WVJG8Qe3XgxHCAOspgEiE84
   XCjt50FOAIxcMVPN8FI+PRV9jRH7feeM1Fg+js2PfSD4JuaQPcHBverP0
   GZKee7Xzid6TO87a+MyYLjPn7mk59Js6W4sF838mYnT6V307m5A5W+ZDV
   fTt5zRwGnPJb5bOSzQfg7CvAjUyuFginiw3VugBBiO4bC8WnUFmE1quLN
   iRyYYmbe9iQmIqgyg/EsYzYokS8y5vvjCVaCxnmZu4ezTJStOVakFx5o1
   A==;
X-CSE-ConnectionGUID: VjRgTyWSSOW7FvjbL3rSDw==
X-CSE-MsgGUID: amn9k9osSA6HfHyvB8s8OA==
X-IronPort-AV: E=Sophos;i="6.21,320,1763395200"; 
   d="scan'208";a="141343848"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep03.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 02 Mar 2026 22:39:51 +0800
IronPort-SDR: 69a5a137_uqFbBcgStZR9ApPIRQa9EANb7oJoTQKtsF8oQSiFdqmCoWr
 g5lqL7NSqquGL4cD7Q2AX56FKuC4E8nBX2ia4gA==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep03.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 Mar 2026 06:39:51 -0800
WDCIronportException: Internal
Received: from unknown (HELO neo.wdc.com) ([10.224.28.176])
  by uls-op-cesaip01.wdc.com with ESMTP; 02 Mar 2026 06:39:50 -0800
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
To: linux-btrfs@vger.kernel.org
Cc: Naohiro Aota <naohiro.aota@wdc.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 3/3] btrfs: zoned: limit number of zones reclaimed in flush_space
Date: Mon,  2 Mar 2026 15:39:42 +0100
Message-ID: <20260302143942.115619-4-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260302143942.115619-1-johannes.thumshirn@wdc.com>
References: <20260302143942.115619-1-johannes.thumshirn@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 8D2A01DB21B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[wdc.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[wdc.com:s=dkim.wdc.com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[wdc.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22153-lists,linux-btrfs=lfdr.de];
	RCPT_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes.thumshirn@wdc.com,linux-btrfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-btrfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[wdc.com:dkim,wdc.com:email,wdc.com:mid,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action

Limit the number of zones reclaimed in flush_space()'s RECLAIM_ZONES
state.

This prevents possibly long running reclaim sweeps to block other tasks in
the system, while the system is under preassure anyways, causing the
tasks to hang.

An example of this can be seen here, triggered by fstests generic/551:

generic/551        [   27.042349] run fstests generic/551 at 2026-02-27 11:05:30
 BTRFS: device fsid 78c16e29-20d9-4c8e-bc04-7ba431be38ff devid 1 transid 8 /dev/vdb (254:16) scanned by mount (806)
 BTRFS info (device vdb): first mount of filesystem 78c16e29-20d9-4c8e-bc04-7ba431be38ff
 BTRFS info (device vdb): using crc32c checksum algorithm
 BTRFS info (device vdb): host-managed zoned block device /dev/vdb, 64 zones of 268435456 bytes
 BTRFS info (device vdb): zoned mode enabled with zone size 268435456
 BTRFS info (device vdb): checking UUID tree
 BTRFS info (device vdb): enabling free space tree
 INFO: task kworker/u38:1:90 blocked for more than 120 seconds.
       Not tainted 7.0.0-rc1+ #345
 "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
 task:kworker/u38:1   state:D stack:0     pid:90    tgid:90    ppid:2      task_flags:0x4208060 flags:0x00080000
 Workqueue: events_unbound btrfs_async_reclaim_data_space
 Call Trace:
  <TASK>
  __schedule+0x34f/0xe70
  schedule+0x41/0x140
  schedule_timeout+0xa3/0x110
  ? mark_held_locks+0x40/0x70
  ? lockdep_hardirqs_on_prepare+0xd8/0x1c0
  ? trace_hardirqs_on+0x18/0x100
  ? lockdep_hardirqs_on+0x84/0x130
  ? _raw_spin_unlock_irq+0x33/0x50
  wait_for_completion+0xa4/0x150
  ? __flush_work+0x24c/0x550
  __flush_work+0x339/0x550
  ? __pfx_wq_barrier_func+0x10/0x10
  ? wait_for_completion+0x39/0x150
  flush_space+0x243/0x660
  ? find_held_lock+0x2b/0x80
  ? kvm_sched_clock_read+0x11/0x20
  ? local_clock_noinstr+0x17/0x110
  ? local_clock+0x15/0x30
  ? lock_release+0x1b7/0x4b0
  do_async_reclaim_data_space+0xe8/0x160
  btrfs_async_reclaim_data_space+0x19/0x30
  process_one_work+0x20a/0x5f0
  ? lock_is_held_type+0xcd/0x130
  worker_thread+0x1e2/0x3c0
  ? __pfx_worker_thread+0x10/0x10
  kthread+0x103/0x150
  ? __pfx_kthread+0x10/0x10
  ret_from_fork+0x20d/0x320
  ? __pfx_kthread+0x10/0x10
  ret_from_fork_asm+0x1a/0x30
  </TASK>

 Showing all locks held in the system:
 1 lock held by khungtaskd/67:
  #0: ffffffff824d58e0 (rcu_read_lock){....}-{1:3}, at: debug_show_all_locks+0x3d/0x194
 2 locks held by kworker/u38:1/90:
  #0: ffff8881000aa158 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_one_work+0x3c4/0x5f0
  #1: ffffc90000c17e58 ((work_completion)(&fs_info->async_data_reclaim_work)){+.+.}-{0:0}, at: process_one_work+0x1c0/0x5f0
 5 locks held by kworker/u39:1/191:
  #0: ffff8881000aa158 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_one_work+0x3c4/0x5f0
  #1: ffffc90000dfbe58 ((work_completion)(&fs_info->reclaim_bgs_work)){+.+.}-{0:0}, at: process_one_work+0x1c0/0x5f0
  #2: ffff888101da0420 (sb_writers#9){.+.+}-{0:0}, at: process_one_work+0x20a/0x5f0
  #3: ffff88811040a648 (&fs_info->reclaim_bgs_lock){+.+.}-{4:4}, at: btrfs_reclaim_bgs_work+0x1de/0x770
  #4: ffff888110408a18 (&fs_info->cleaner_mutex){+.+.}-{4:4}, at: btrfs_relocate_block_group+0x95a/0x20f0
 1 lock held by aio-dio-write-v/980:
  #0: ffff888110093008 (&sb->s_type->i_mutex_key#15){++++}-{4:4}, at: btrfs_inode_lock+0x51/0xb0

 =============================================

To prevent these long running reclaims from blocking the system, only
reclaim 5 block_groups in the RECLAIM_ZONES state of flush_space(). Also
as these reclaims are now constrained, it opens up the use for a
synchronous call to brtfs_reclaim_block_groups(), eliminating the need
to place the reclaim task on a workqueue and then flushing the workqueue
again.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/block-group.c | 12 ++++++++----
 fs/btrfs/block-group.h |  1 +
 fs/btrfs/space-info.c  |  3 +--
 3 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index f0e4a1dd812f..169496d2b3c5 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -1909,7 +1909,7 @@ static bool should_reclaim_block_group(const struct btrfs_block_group *bg, u64 b
 	return true;
 }
 
-static int btrfs_reclaim_block_group(struct btrfs_block_group *bg)
+static int btrfs_reclaim_block_group(struct btrfs_block_group *bg, int *reclaimed)
 {
 	struct btrfs_fs_info *fs_info = bg->fs_info;
 	struct btrfs_space_info *space_info = bg->space_info;
@@ -2036,15 +2036,17 @@ static int btrfs_reclaim_block_group(struct btrfs_block_group *bg)
 	if (space_info->total_bytes < old_total)
 		btrfs_set_periodic_reclaim_ready(space_info, true);
 	spin_unlock(&space_info->lock);
+	(*reclaimed)++;
 
 	return ret;
 }
 
-static void btrfs_reclaim_block_groups(struct btrfs_fs_info *fs_info)
+void btrfs_reclaim_block_groups(struct btrfs_fs_info *fs_info, unsigned int limit)
 {
 	struct btrfs_block_group *bg;
 	struct btrfs_space_info *space_info;
 	LIST_HEAD(retry_list);
+	int reclaimed = 0;
 
 	if (!btrfs_should_reclaim(fs_info))
 		return;
@@ -2080,7 +2082,7 @@ static void btrfs_reclaim_block_groups(struct btrfs_fs_info *fs_info)
 
 		space_info = bg->space_info;
 		spin_unlock(&fs_info->unused_bgs_lock);
-		ret = btrfs_reclaim_block_group(bg);
+		ret = btrfs_reclaim_block_group(bg, &reclaimed);
 
 		if (ret && !READ_ONCE(space_info->periodic_reclaim))
 			btrfs_link_bg_list(bg, &retry_list);
@@ -2099,6 +2101,8 @@ static void btrfs_reclaim_block_groups(struct btrfs_fs_info *fs_info)
 		if (!mutex_trylock(&fs_info->reclaim_bgs_lock))
 			goto end;
 		spin_lock(&fs_info->unused_bgs_lock);
+		if (reclaimed >= limit)
+			break;
 	}
 	spin_unlock(&fs_info->unused_bgs_lock);
 	mutex_unlock(&fs_info->reclaim_bgs_lock);
@@ -2114,7 +2118,7 @@ void btrfs_reclaim_bgs_work(struct work_struct *work)
 	struct btrfs_fs_info *fs_info =
 		container_of(work, struct btrfs_fs_info, reclaim_bgs_work);
 
-	btrfs_reclaim_block_groups(fs_info);
+	btrfs_reclaim_block_groups(fs_info, -1);
 }
 
 void btrfs_reclaim_bgs(struct btrfs_fs_info *fs_info)
diff --git a/fs/btrfs/block-group.h b/fs/btrfs/block-group.h
index c03e04292900..0504cb357992 100644
--- a/fs/btrfs/block-group.h
+++ b/fs/btrfs/block-group.h
@@ -350,6 +350,7 @@ int btrfs_remove_block_group(struct btrfs_trans_handle *trans,
 			     struct btrfs_chunk_map *map);
 void btrfs_delete_unused_bgs(struct btrfs_fs_info *fs_info);
 void btrfs_mark_bg_unused(struct btrfs_block_group *bg);
+void btrfs_reclaim_block_groups(struct btrfs_fs_info *fs_info, unsigned int limit);
 void btrfs_reclaim_bgs_work(struct work_struct *work);
 void btrfs_reclaim_bgs(struct btrfs_fs_info *fs_info);
 void btrfs_mark_bg_to_reclaim(struct btrfs_block_group *bg);
diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 0e5274c3b988..57b74d0608ae 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -918,8 +918,7 @@ static void flush_space(struct btrfs_space_info *space_info, u64 num_bytes,
 		if (btrfs_is_zoned(fs_info)) {
 			btrfs_reclaim_sweep(fs_info);
 			btrfs_delete_unused_bgs(fs_info);
-			btrfs_reclaim_bgs(fs_info);
-			flush_work(&fs_info->reclaim_bgs_work);
+			btrfs_reclaim_block_groups(fs_info, 5);
 			ASSERT(current->journal_info == NULL);
 			ret = btrfs_commit_current_transaction(root);
 		} else {
-- 
2.53.0


