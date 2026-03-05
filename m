Return-Path: <linux-btrfs+bounces-22246-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SCEBCX1WqWkh5wAAu9opvQ
	(envelope-from <linux-btrfs+bounces-22246-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Thu, 05 Mar 2026 11:10:05 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 75DFA20F722
	for <lists+linux-btrfs@lfdr.de>; Thu, 05 Mar 2026 11:10:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5161B300B9F9
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Mar 2026 10:07:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AADAD37D131;
	Thu,  5 Mar 2026 10:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="pKET6e3C"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDF93366064
	for <linux-btrfs@vger.kernel.org>; Thu,  5 Mar 2026 10:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772705221; cv=none; b=lzZjb9/6JVK+5JJK+BB24JEnFjT1T+mNiXC5AdT+WdJok1ZNEIHJQfUocpYl9r7CZwP0CK6AdnNg6ohV21zb/+Gw/LnskKhRfg1jvlnG0+Dbo3B+jZM0YGnMXYWXSp5lL2fcOXQl07Sr+K3MdZtjE+7+BtXpoiwYUnOnOyru+eM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772705221; c=relaxed/simple;
	bh=fl9l29d8p2zmkEzhZNZuBnWowPpdz4wgPIK91STsisM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JNXkoGRZzwofvqdOf2HYjPzn/zc881gqmm7mrhkOTUPR1fNUsfB1nXHt5xLaq/tEdcn/mz49tTwLJN4KE+yawh3+xUGzZg3mit9Rq60RUl+6zsbPYctk+PQBdG54vVGxbpT9XboEiU51424RPZ3VzQnNbqCnHiX/VMDsJpR0BJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=pKET6e3C; arc=none smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1772705218; x=1804241218;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fl9l29d8p2zmkEzhZNZuBnWowPpdz4wgPIK91STsisM=;
  b=pKET6e3CJ4fzY01j6fD6WNkHhCbqsJuUEECQC61dDquykOWw6N2XO6gn
   zzmsevbBE9/uU/MtX9n4vc+ChTJJ2qpfKCszq/2qhRYVxYj6Ze1XtGsbO
   obQT5aT9ab5pDhS5+iGsnMzI62UDzSAJDIG3Jmrd508Q2X+cH/6Zl85NR
   CKfwWYGJv7K7oYmWfEfwIWpHDgDpgetmq+Z7vxLdIZDRCJn+/pVitlfc2
   b+KYLFddkUBsQgodrzgyKI/6SCLQ6UHOD9avC4pC5+vaGlx60DrNMIdcx
   MyIJCfB+HmxOn/EOXsPX3BiPOY+hmQvFx4xvdFbckze1iLvhw2PAZSYwt
   A==;
X-CSE-ConnectionGUID: m3b8eQwXQz2+LcOGqUkAYg==
X-CSE-MsgGUID: WYbdfiQ9Tt2+VEO4hEEnLg==
X-IronPort-AV: E=Sophos;i="6.23,102,1770566400"; 
   d="scan'208";a="138339196"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 05 Mar 2026 18:06:52 +0800
IronPort-SDR: 69a955bc_wTLdMAd+4DrdjOb4QNeFIlFmZRNMFsxLKkKu5C/Msagjxqn
 RpPe2CQnx9Ht/lo4D1JWzj5+GA1qqQ4xgRpWcxw==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 Mar 2026 02:06:52 -0800
WDCIronportException: Internal
Received: from wdap-bnfcsfsyyt.ad.shared (HELO neo.wdc.com) ([10.224.28.182])
  by uls-op-cesaip02.wdc.com with ESMTP; 05 Mar 2026 02:06:51 -0800
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
To: linux-btrfs@vger.kernel.org
Cc: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Naohiro Aota <naohiro.aota@wdc.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Boris Burkov <boris@bur.io>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v2 1/3] btrfs: move reclaiming of a single block group into its own function
Date: Thu,  5 Mar 2026 11:06:42 +0100
Message-ID: <20260305100644.356177-2-johannes.thumshirn@wdc.com>
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
X-Rspamd-Queue-Id: 75DFA20F722
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[wdc.com,quarantine];
	R_DKIM_ALLOW(-0.20)[wdc.com:s=dkim.wdc.com];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22246-lists,linux-btrfs=lfdr.de];
	DKIM_TRACE(0.00)[wdc.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[johannes.thumshirn@wdc.com,linux-btrfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-btrfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,wdc.com:dkim,wdc.com:email,wdc.com:mid]
X-Rspamd-Action: no action

The main work of reclaiming a single block-group in
btrfs_reclaim_bgs_work() is done inside the loop iterating over all the
block_groups in the fs_info->reclaim_bgs list.

Factor out reclaim of a single block group from the loop to improve
readability.

No functional change intented.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/block-group.c | 256 +++++++++++++++++++++--------------------
 1 file changed, 133 insertions(+), 123 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index b5c274715809..4df076bd93f5 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -1909,6 +1909,137 @@ static bool should_reclaim_block_group(const struct btrfs_block_group *bg, u64 b
 	return true;
 }
 
+static int btrfs_reclaim_block_group(struct btrfs_block_group *bg)
+{
+	struct btrfs_fs_info *fs_info = bg->fs_info;
+	struct btrfs_space_info *space_info = bg->space_info;
+	u64 used;
+	u64 reserved;
+	u64 old_total;
+	int ret = 0;
+
+	/* Don't race with allocators so take the groups_sem */
+	down_write(&space_info->groups_sem);
+
+	spin_lock(&space_info->lock);
+	spin_lock(&bg->lock);
+	if (bg->reserved || bg->pinned || bg->ro) {
+		/*
+		 * We want to bail if we made new allocations or have
+		 * outstanding allocations in this block group.  We do
+		 * the ro check in case balance is currently acting on
+		 * this block group.
+		 */
+		spin_unlock(&bg->lock);
+		spin_unlock(&space_info->lock);
+		up_write(&space_info->groups_sem);
+		return 0;
+	}
+
+	if (bg->used == 0) {
+		/*
+		 * It is possible that we trigger relocation on a block
+		 * group as its extents are deleted and it first goes
+		 * below the threshold, then shortly after goes empty.
+		 *
+		 * In this case, relocating it does delete it, but has
+		 * some overhead in relocation specific metadata, looking
+		 * for the non-existent extents and running some extra
+		 * transactions, which we can avoid by using one of the
+		 * other mechanisms for dealing with empty block groups.
+		 */
+		if (!btrfs_test_opt(fs_info, DISCARD_ASYNC))
+			btrfs_mark_bg_unused(bg);
+		spin_unlock(&bg->lock);
+		spin_unlock(&space_info->lock);
+		up_write(&space_info->groups_sem);
+		return 0;
+	}
+
+	/*
+	 * The block group might no longer meet the reclaim condition by
+	 * the time we get around to reclaiming it, so to avoid
+	 * reclaiming overly full block_groups, skip reclaiming them.
+	 *
+	 * Since the decision making process also depends on the amount
+	 * being freed, pass in a fake giant value to skip that extra
+	 * check, which is more meaningful when adding to the list in
+	 * the first place.
+	 */
+	if (!should_reclaim_block_group(bg, bg->length)) {
+		spin_unlock(&bg->lock);
+		spin_unlock(&space_info->lock);
+		up_write(&space_info->groups_sem);
+		return 0;
+	}
+
+	spin_unlock(&bg->lock);
+	old_total = space_info->total_bytes;
+	spin_unlock(&space_info->lock);
+
+	/*
+	 * Get out fast, in case we're read-only or unmounting the
+	 * filesystem. It is OK to drop block groups from the list even
+	 * for the read-only case. As we did take the super write lock,
+	 * "mount -o remount,ro" won't happen and read-only filesystem
+	 * means it is forced read-only due to a fatal error. So, it
+	 * never gets back to read-write to let us reclaim again.
+	 */
+	if (btrfs_need_cleaner_sleep(fs_info)) {
+		up_write(&space_info->groups_sem);
+		return 0;
+	}
+
+	ret = inc_block_group_ro(bg, false);
+	up_write(&space_info->groups_sem);
+	if (ret < 0)
+		return ret;
+
+	/*
+	 * The amount of bytes reclaimed corresponds to the sum of the
+	 * "used" and "reserved" counters. We have set the block group
+	 * to RO above, which prevents reservations from happening but
+	 * we may have existing reservations for which allocation has
+	 * not yet been done - btrfs_update_block_group() was not yet
+	 * called, which is where we will transfer a reserved extent's
+	 * size from the "reserved" counter to the "used" counter - this
+	 * happens when running delayed references. When we relocate the
+	 * chunk below, relocation first flushes delalloc, waits for
+	 * ordered extent completion (which is where we create delayed
+	 * references for data extents) and commits the current
+	 * transaction (which runs delayed references), and only after
+	 * it does the actual work to move extents out of the block
+	 * group. So the reported amount of reclaimed bytes is
+	 * effectively the sum of the 'used' and 'reserved' counters.
+	 */
+	spin_lock(&bg->lock);
+	used = bg->used;
+	reserved = bg->reserved;
+	spin_unlock(&bg->lock);
+
+	trace_btrfs_reclaim_block_group(bg);
+	ret = btrfs_relocate_chunk(fs_info, bg->start, false);
+	if (ret) {
+		btrfs_dec_block_group_ro(bg);
+		btrfs_err(fs_info, "error relocating chunk %llu",
+			  bg->start);
+		used = 0;
+		reserved = 0;
+		spin_lock(&space_info->lock);
+		space_info->reclaim_errors++;
+		spin_unlock(&space_info->lock);
+	}
+	spin_lock(&space_info->lock);
+	space_info->reclaim_count++;
+	space_info->reclaim_bytes += used;
+	space_info->reclaim_bytes += reserved;
+	if (space_info->total_bytes < old_total)
+		btrfs_set_periodic_reclaim_ready(space_info, true);
+	spin_unlock(&space_info->lock);
+
+	return ret;
+}
+
 void btrfs_reclaim_bgs_work(struct work_struct *work)
 {
 	struct btrfs_fs_info *fs_info =
@@ -1942,10 +2073,7 @@ void btrfs_reclaim_bgs_work(struct work_struct *work)
 	 */
 	list_sort(NULL, &fs_info->reclaim_bgs, reclaim_bgs_cmp);
 	while (!list_empty(&fs_info->reclaim_bgs)) {
-		u64 used;
-		u64 reserved;
-		u64 old_total;
-		int ret = 0;
+		int ret;
 
 		bg = list_first_entry(&fs_info->reclaim_bgs,
 				      struct btrfs_block_group,
@@ -1954,126 +2082,8 @@ void btrfs_reclaim_bgs_work(struct work_struct *work)
 
 		space_info = bg->space_info;
 		spin_unlock(&fs_info->unused_bgs_lock);
+		ret = btrfs_reclaim_block_group(bg);
 
-		/* Don't race with allocators so take the groups_sem */
-		down_write(&space_info->groups_sem);
-
-		spin_lock(&space_info->lock);
-		spin_lock(&bg->lock);
-		if (bg->reserved || bg->pinned || bg->ro) {
-			/*
-			 * We want to bail if we made new allocations or have
-			 * outstanding allocations in this block group.  We do
-			 * the ro check in case balance is currently acting on
-			 * this block group.
-			 */
-			spin_unlock(&bg->lock);
-			spin_unlock(&space_info->lock);
-			up_write(&space_info->groups_sem);
-			goto next;
-		}
-		if (bg->used == 0) {
-			/*
-			 * It is possible that we trigger relocation on a block
-			 * group as its extents are deleted and it first goes
-			 * below the threshold, then shortly after goes empty.
-			 *
-			 * In this case, relocating it does delete it, but has
-			 * some overhead in relocation specific metadata, looking
-			 * for the non-existent extents and running some extra
-			 * transactions, which we can avoid by using one of the
-			 * other mechanisms for dealing with empty block groups.
-			 */
-			if (!btrfs_test_opt(fs_info, DISCARD_ASYNC))
-				btrfs_mark_bg_unused(bg);
-			spin_unlock(&bg->lock);
-			spin_unlock(&space_info->lock);
-			up_write(&space_info->groups_sem);
-			goto next;
-
-		}
-		/*
-		 * The block group might no longer meet the reclaim condition by
-		 * the time we get around to reclaiming it, so to avoid
-		 * reclaiming overly full block_groups, skip reclaiming them.
-		 *
-		 * Since the decision making process also depends on the amount
-		 * being freed, pass in a fake giant value to skip that extra
-		 * check, which is more meaningful when adding to the list in
-		 * the first place.
-		 */
-		if (!should_reclaim_block_group(bg, bg->length)) {
-			spin_unlock(&bg->lock);
-			spin_unlock(&space_info->lock);
-			up_write(&space_info->groups_sem);
-			goto next;
-		}
-
-		spin_unlock(&bg->lock);
-		old_total = space_info->total_bytes;
-		spin_unlock(&space_info->lock);
-
-		/*
-		 * Get out fast, in case we're read-only or unmounting the
-		 * filesystem. It is OK to drop block groups from the list even
-		 * for the read-only case. As we did take the super write lock,
-		 * "mount -o remount,ro" won't happen and read-only filesystem
-		 * means it is forced read-only due to a fatal error. So, it
-		 * never gets back to read-write to let us reclaim again.
-		 */
-		if (btrfs_need_cleaner_sleep(fs_info)) {
-			up_write(&space_info->groups_sem);
-			goto next;
-		}
-
-		ret = inc_block_group_ro(bg, false);
-		up_write(&space_info->groups_sem);
-		if (ret < 0)
-			goto next;
-
-		/*
-		 * The amount of bytes reclaimed corresponds to the sum of the
-		 * "used" and "reserved" counters. We have set the block group
-		 * to RO above, which prevents reservations from happening but
-		 * we may have existing reservations for which allocation has
-		 * not yet been done - btrfs_update_block_group() was not yet
-		 * called, which is where we will transfer a reserved extent's
-		 * size from the "reserved" counter to the "used" counter - this
-		 * happens when running delayed references. When we relocate the
-		 * chunk below, relocation first flushes delalloc, waits for
-		 * ordered extent completion (which is where we create delayed
-		 * references for data extents) and commits the current
-		 * transaction (which runs delayed references), and only after
-		 * it does the actual work to move extents out of the block
-		 * group. So the reported amount of reclaimed bytes is
-		 * effectively the sum of the 'used' and 'reserved' counters.
-		 */
-		spin_lock(&bg->lock);
-		used = bg->used;
-		reserved = bg->reserved;
-		spin_unlock(&bg->lock);
-
-		trace_btrfs_reclaim_block_group(bg);
-		ret = btrfs_relocate_chunk(fs_info, bg->start, false);
-		if (ret) {
-			btrfs_dec_block_group_ro(bg);
-			btrfs_err(fs_info, "error relocating chunk %llu",
-				  bg->start);
-			used = 0;
-			reserved = 0;
-			spin_lock(&space_info->lock);
-			space_info->reclaim_errors++;
-			spin_unlock(&space_info->lock);
-		}
-		spin_lock(&space_info->lock);
-		space_info->reclaim_count++;
-		space_info->reclaim_bytes += used;
-		space_info->reclaim_bytes += reserved;
-		if (space_info->total_bytes < old_total)
-			btrfs_set_periodic_reclaim_ready(space_info, true);
-		spin_unlock(&space_info->lock);
-
-next:
 		if (ret && !READ_ONCE(space_info->periodic_reclaim))
 			btrfs_link_bg_list(bg, &retry_list);
 		btrfs_put_block_group(bg);
-- 
2.53.0


