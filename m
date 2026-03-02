Return-Path: <linux-btrfs+bounces-22152-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mFWYGheipWngCwAAu9opvQ
	(envelope-from <linux-btrfs+bounces-22152-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Mon, 02 Mar 2026 15:43:35 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BF58E1DB152
	for <lists+linux-btrfs@lfdr.de>; Mon, 02 Mar 2026 15:43:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 045B8305A226
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Mar 2026 14:40:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01C1B40149A;
	Mon,  2 Mar 2026 14:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="GQ7te32g"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D9C73FFAB5
	for <linux-btrfs@vger.kernel.org>; Mon,  2 Mar 2026 14:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772462397; cv=none; b=LkzoEejZnijlkg7sWf5IodpRWhiICS3NXG3TWACBwfONdCDxS1+tQA+wIOtYgadDgJMiVi27H77jgRwAtjJz1rHiL+ZIKb6cjtvTMIySGe/n+DxxNQTDtjQzfeBWWMe40jNZ9lStnCtQuVAENwM1oa8/e3d4+tdim2EhWoFdcuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772462397; c=relaxed/simple;
	bh=b0SotLApMfRNGpP/Hr/k9FjSEkEyG+NKCzM2o19V0WU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ApzHDsyaeeLIvhpJGplHYE6QZRb2sCezI82Mt37RCiWpZmKIQdouo8r8nh/fRJVO7Vt6KINqS2XA53tB3Raa5JGoFBpG2xdp4bqqHO/fWRwrSIcjBlTdqtgXBXIxSp690mv/WDzDAtd5KhSUvabDGXhg7aW/n0BsfcJF4m7Ddyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=GQ7te32g; arc=none smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1772462395; x=1803998395;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=b0SotLApMfRNGpP/Hr/k9FjSEkEyG+NKCzM2o19V0WU=;
  b=GQ7te32gCytLoE1ndioP8w0gWmRXaO6gmr0FFHA5J0aLFTD/fqS8maY6
   0T7TLGRk5NLS/qCDTslC5zfUQeWhBP9U3yq2tdQBAIOCUW5XdbrhO1fPp
   rZeonqG17XBVhADeIQYTZ/eGx/LMoaqWX+9HZH12S3Kz39Qr75UCOyob8
   NBy7v0da+x/GfltLG7cz2O89p4mnNqOa8+Nnn6X/aV34P//3h+P1Jd2Pk
   d76Conpy4RzadItrJS2jT4OWKI6qvmL6jeBojAwttJPXJjmLLNDbYU0aa
   e3DwC9JNPsU8SPpWLqgjLd3oh8P1btvlehn4oaKLk/rKr88J5uclzsYrc
   w==;
X-CSE-ConnectionGUID: OBcvK0UnSfOzfEZbeFmg4A==
X-CSE-MsgGUID: LGFeNzDgRNeKRSAMlUgvMQ==
X-IronPort-AV: E=Sophos;i="6.21,320,1763395200"; 
   d="scan'208";a="141343844"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep03.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 02 Mar 2026 22:39:47 +0800
IronPort-SDR: 69a5a133_qm7m9NPKeJeZBmRuQ9LCeKD8/jZE39O5P1MB+tpjNip1LEg
 IxuU67QfbHaBwZ8HLC36A00eUOwAp6GFJEWVk9A==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep03.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 Mar 2026 06:39:48 -0800
WDCIronportException: Internal
Received: from unknown (HELO neo.wdc.com) ([10.224.28.176])
  by uls-op-cesaip01.wdc.com with ESMTP; 02 Mar 2026 06:39:47 -0800
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
To: linux-btrfs@vger.kernel.org
Cc: Naohiro Aota <naohiro.aota@wdc.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 1/3] btrfs: move reclaiming of a single block group into its own function
Date: Mon,  2 Mar 2026 15:39:40 +0100
Message-ID: <20260302143942.115619-2-johannes.thumshirn@wdc.com>
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
X-Rspamd-Queue-Id: BF58E1DB152
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[wdc.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[wdc.com:s=dkim.wdc.com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[wdc.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22152-lists,linux-btrfs=lfdr.de];
	RCPT_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes.thumshirn@wdc.com,linux-btrfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-btrfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[wdc.com:dkim,wdc.com:email,wdc.com:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

The main work of reclaiming a single block-group in
btrfs_reclaim_bgs_work() is done inside the loop iterating over all the
block_groups in the fs_info->reclaim_bgs list.

Factor out reclaim of a single block group from the loop to improve
readability.

No functional change intented.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/block-group.c | 256 +++++++++++++++++++++--------------------
 1 file changed, 133 insertions(+), 123 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 896737cc432e..e95f68d246c6 100644
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


