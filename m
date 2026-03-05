Return-Path: <linux-btrfs+bounces-22248-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EKagCANXqWkh5wAAu9opvQ
	(envelope-from <linux-btrfs+bounces-22248-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Thu, 05 Mar 2026 11:12:19 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D10D20F7B2
	for <lists+linux-btrfs@lfdr.de>; Thu, 05 Mar 2026 11:12:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0BCA2308AA85
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Mar 2026 10:07:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F227937C92B;
	Thu,  5 Mar 2026 10:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Fj3EtB5H"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 524D637C938
	for <linux-btrfs@vger.kernel.org>; Thu,  5 Mar 2026 10:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772705223; cv=none; b=aSzyKjJ68wGBUj1clnxNCQn48wROsfcAvLu4ermdj/ytD3xwz5UwxVcyvHUwoEe45xy/vNm6bJfj5qk7WkFyUryvokOIEdTPFgioV+U7E0KwkPJzwOBYM+ai1uSic7VKAT5bTcf+cO0XueXukksJVgKEYCm6RUVDkEuKGjO+U8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772705223; c=relaxed/simple;
	bh=cuJVnkMJjwHJaU0nr709FXEl7uTi496y3LXN9ojxeDI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t5GJAPwjV2GfjftHE5MkxIfoNes/TY0mV3vSHyjryl3cX5xBpiKSvekA11PX3cmc4Ctrlkw4fc9qTezxfaRkSRi3PAv1ZzViJqC3d20ISIFzgdIx+iR9jgeVb/QnCMV2B6fgZGbonkZV2U6hbXkABY9/SHeGugvj4lLn0tBHL0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=Fj3EtB5H; arc=none smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1772705220; x=1804241220;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cuJVnkMJjwHJaU0nr709FXEl7uTi496y3LXN9ojxeDI=;
  b=Fj3EtB5HpLUj/Kudg+tboREfG+TMsdKNR0IeY61j/UG3Y4QVEUkCEAEF
   qE4s+I7Tc3Aw73PIYDxu3b714RDFBo+NZTfGhC/V7lP168Dv957HdiwOL
   72Coa94HPhD0id9jgdtNiDCG/TKvBrCeYuNt1LY4GNM7Pl7YJvFXYaPG6
   EQ1qgzXGuh9ch4JIS6LrFrmIRrmapBhr7uZ4Ds1UPJ8Z5hDJC+2wFkqTn
   fgVD1VfLWAuu/2nGJ04WDNKSHGCK5VsLFFePgziKP5SVtI6oQxQIcCZFK
   JiilDg1WgEqa2apB+rPKd1BcfoQmiCwn60I2UoEOO/bFt6iAnKGx+QNZS
   A==;
X-CSE-ConnectionGUID: 6JSvSbFiS2Kd7GbPL7t1FA==
X-CSE-MsgGUID: Z1/0DYUoSyalZ4TNvqAtog==
X-IronPort-AV: E=Sophos;i="6.23,102,1770566400"; 
   d="scan'208";a="138339203"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 05 Mar 2026 18:06:57 +0800
IronPort-SDR: 69a955c1_xnHgkpg5skyTFwtuYTrd0QB+CScFXrZe+7UZYq1QBdTqV2v
 O+HdXrf5k2sFFv9loZzYostXHpPwGpcxNI2o7bw==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 Mar 2026 02:06:57 -0800
WDCIronportException: Internal
Received: from wdap-bnfcsfsyyt.ad.shared (HELO neo.wdc.com) ([10.224.28.182])
  by uls-op-cesaip02.wdc.com with ESMTP; 05 Mar 2026 02:06:56 -0800
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
To: linux-btrfs@vger.kernel.org
Cc: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Naohiro Aota <naohiro.aota@wdc.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Boris Burkov <boris@bur.io>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v2 3/3] btrfs: zoned: limit number of zones reclaimed in flush_space
Date: Thu,  5 Mar 2026 11:06:44 +0100
Message-ID: <20260305100644.356177-4-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260305100644.356177-1-johannes.thumshirn@wdc.com>
References: <20260305100644.356177-1-johannes.thumshirn@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 8D10D20F7B2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[wdc.com,quarantine];
	R_DKIM_ALLOW(-0.20)[wdc.com:s=dkim.wdc.com];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22248-lists,linux-btrfs=lfdr.de];
	DKIM_TRACE(0.00)[wdc.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[johannes.thumshirn@wdc.com,linux-btrfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-btrfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,wdc.com:dkim,wdc.com:email,wdc.com:mid]
X-Rspamd-Action: no action

Limit the number of zones reclaimed in flush_space()'s RECLAIM_ZONES
state.

This prevents possibly long running reclaim sweeps to block other tasks in
the system, while the system is under pressure anyways, causing the
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
 fs/btrfs/block-group.c | 13 +++++++++----
 fs/btrfs/block-group.h |  1 +
 fs/btrfs/space-info.c  |  3 +--
 3 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 72fc9b3b6dc0..fa6e49a4ba37 100644
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
@@ -2036,15 +2036,18 @@ static int btrfs_reclaim_block_group(struct btrfs_block_group *bg)
 	if (space_info->total_bytes < old_total)
 		btrfs_set_periodic_reclaim_ready(space_info, true);
 	spin_unlock(&space_info->lock);
+	if (!ret)
+		(*reclaimed)++;
 
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
@@ -2080,7 +2083,7 @@ static void btrfs_reclaim_block_groups(struct btrfs_fs_info *fs_info)
 
 		space_info = bg->space_info;
 		spin_unlock(&fs_info->unused_bgs_lock);
-		ret = btrfs_reclaim_block_group(bg);
+		ret = btrfs_reclaim_block_group(bg, &reclaimed);
 
 		if (ret && !READ_ONCE(space_info->periodic_reclaim))
 			btrfs_link_bg_list(bg, &retry_list);
@@ -2099,6 +2102,8 @@ static void btrfs_reclaim_block_groups(struct btrfs_fs_info *fs_info)
 		if (!mutex_trylock(&fs_info->reclaim_bgs_lock))
 			goto end;
 		spin_lock(&fs_info->unused_bgs_lock);
+		if (reclaimed >= limit)
+			break;
 	}
 	spin_unlock(&fs_info->unused_bgs_lock);
 	mutex_unlock(&fs_info->reclaim_bgs_lock);
@@ -2114,7 +2119,7 @@ void btrfs_reclaim_bgs_work(struct work_struct *work)
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


