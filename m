Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AD4F48707C
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Jan 2022 03:34:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344758AbiAGCew (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 6 Jan 2022 21:34:52 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:45700 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344743AbiAGCev (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 6 Jan 2022 21:34:51 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 91338212BD
        for <linux-btrfs@vger.kernel.org>; Fri,  7 Jan 2022 02:34:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1641522890; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=p6vAXkrieDHBQy8yiKLjtQwBWayv5D0p3WSFOCcbXo0=;
        b=boSFeXUCKbbLTCmmkE1cul6lqNdvA112xmh7ng1BSImiznQRpuOmykGmKQ5eyZCePDDziI
        mButRBxS1wsIBzpqnkkJoVDiL++pU4RykrTeOnucuACdKyzH5nquUlM+0sBDvAvYX1qagF
        p+ItncFbkmpP6bmxF7ogis4hQFnxWF0=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E64E513C9D
        for <linux-btrfs@vger.kernel.org>; Fri,  7 Jan 2022 02:34:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id YMjOK8mm12FTUgAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Fri, 07 Jan 2022 02:34:49 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 2/4] btrfs: introduce dedicated helper to scrub simple-mirror based range
Date:   Fri,  7 Jan 2022 10:34:28 +0800
Message-Id: <20220107023430.28288-3-wqu@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220107023430.28288-1-wqu@suse.com>
References: <20220107023430.28288-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The new helper, scrub_simple_mirror(), will scrub all extents inside a range
which only has simple mirror based duplication.

This covers every range of SINGLE/DUP/RAID1/RAID1C*, and inside each
data stripe for RAID0/RAID10.

Currently we will use this function to scrub SINGLE/DUP/RAID1/RAID1C*
profiles.
As one can see, the new entrance for those simple-mirror based profiles
can be small enough (with comments, just reach 100 lines).

This function will be the basis for the incoming scrub refactor.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/scrub.c | 190 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 190 insertions(+)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index ee179eb2ea17..7b39705502b4 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -2990,6 +2990,26 @@ static int find_first_extent_item(struct btrfs_root *extent_root,
 	return 1;
 }
 
+static void get_extent_info(struct btrfs_path *path, u64 *extent_start_ret,
+			    u64 *size_ret, u64 *flags_ret, u64 *generation_ret)
+{
+	struct btrfs_key key;
+	struct btrfs_extent_item *ei;
+
+	btrfs_item_key_to_cpu(path->nodes[0], &key, path->slots[0]);
+	ASSERT(key.type == BTRFS_METADATA_ITEM_KEY ||
+	       key.type == BTRFS_EXTENT_ITEM_KEY);
+	*extent_start_ret = key.objectid;
+	if (key.type == BTRFS_METADATA_ITEM_KEY)
+		*size_ret = path->nodes[0]->fs_info->nodesize;
+	else
+		*size_ret = key.offset;
+	ei = btrfs_item_ptr(path->nodes[0], path->slots[0],
+			    struct btrfs_extent_item);
+	*flags_ret = btrfs_extent_flags(path->nodes[0], ei);
+	*generation_ret = btrfs_extent_generation(path->nodes[0], ei);
+}
+
 static noinline_for_stack int scrub_raid56_parity(struct scrub_ctx *sctx,
 						  struct map_lookup *map,
 						  struct btrfs_device *sdev,
@@ -3273,6 +3293,152 @@ static int sync_write_pointer_for_zoned(struct scrub_ctx *sctx, u64 logical,
 	return ret;
 }
 
+static bool does_range_cross_boundary(u64 extent_start, u64 extent_len,
+				      u64 boundary_start, u64 boudary_len)
+{
+	return (extent_start < boundary_start &&
+		extent_start + extent_len > boundary_start) ||
+	       (extent_start < boundary_start + boudary_len &&
+		extent_start + extent_len > boundary_start + boudary_len);
+}
+
+/*
+ * Scrub one range which can only has simple mirror based profile.
+ * (Including all range in SINGLE/DUP/RAID1/RAID1C*, and each stripe in
+ *  RAID0/RAID10).
+ *
+ * Since we may need to handle a subset of block group, we need @logical_start
+ * and @logical_length parameter.
+ */
+static int scrub_simple_mirror(struct scrub_ctx *sctx,
+				struct btrfs_root *extent_root,
+				struct btrfs_root *csum_root,
+				struct btrfs_block_group *bg,
+				struct map_lookup *map,
+				u64 logical_start, u64 logical_length,
+				struct btrfs_device *device,
+				u64 physical, int mirror_num)
+{
+	struct btrfs_fs_info *fs_info = sctx->fs_info;
+	const u64 logical_end = logical_start + logical_length;
+	/* An artificial limit, inherit from old scrub behavior */
+	const u32 max_length = SZ_64K;
+	struct btrfs_path path = {};
+	u64 cur_logical = logical_start;
+	int ret;
+
+	/* The range must be inside the bg */
+	ASSERT(logical_start >= bg->start &&
+	       logical_end <= bg->start + bg->length);
+
+	path.search_commit_root = 1;
+	path.skip_locking = 1;
+	/* Go through each */
+	while (cur_logical < logical_end) {
+		int cur_mirror = mirror_num;
+		struct btrfs_device *target_dev = device;
+		u64 extent_start;
+		u64 extent_len;
+		u64 extent_flags;
+		u64 extent_gen;
+		u64 scrub_len;
+		u64 cur_physical;
+
+		/* Canceled ? */
+		if (atomic_read(&fs_info->scrub_cancel_req) ||
+		    atomic_read(&sctx->cancel_req)) {
+			ret = -ECANCELED;
+			break;
+		}
+		/* Paused ? */
+		if (atomic_read(&fs_info->scrub_pause_req)) {
+			/* Push queued extents */
+			sctx->flush_all_writes = true;
+			scrub_submit(sctx);
+			mutex_lock(&sctx->wr_lock);
+			scrub_wr_submit(sctx);
+			mutex_unlock(&sctx->wr_lock);
+			wait_event(sctx->list_wait,
+				   atomic_read(&sctx->bios_in_flight) == 0);
+			sctx->flush_all_writes = false;
+			scrub_blocked_if_needed(fs_info);
+		}
+		/* Block group removed? */
+		spin_lock(&bg->lock);
+		if (bg->removed) {
+			spin_unlock(&bg->lock);
+			ret = 0;
+			break;
+		}
+		spin_unlock(&bg->lock);
+
+		ret = find_first_extent_item(extent_root, &path, cur_logical,
+					     logical_end - cur_logical);
+		if (ret > 0) {
+			/* No more extent, just update the accounting */
+			sctx->stat.last_physical = physical + logical_length;
+			ret = 0;
+			break;
+		}
+		if (ret < 0)
+			break;
+		get_extent_info(&path, &extent_start, &extent_len,
+				&extent_flags, &extent_gen);
+		/* Skip hole range which doesn't have any extent */
+		cur_logical = max(extent_start, cur_logical);
+
+		/*
+		 * Scrub len has three limits:
+		 * - Extent size limit
+		 * - Scrub range limit
+		 *   This is especially imporatant for RAID0/RAID10 to reuse
+		 *   this function
+		 * - Max scrub size limit
+		 */
+		scrub_len = min(min(extent_start + extent_len,
+				    logical_end), cur_logical + max_length) -
+			    cur_logical;
+		cur_physical = cur_logical - logical_start + physical;
+
+		if (sctx->is_dev_replace)
+			scrub_remap_extent(fs_info, cur_logical, scrub_len,
+					   &cur_physical, &target_dev, &cur_mirror);
+		if (extent_flags & BTRFS_EXTENT_FLAG_DATA) {
+			ret = btrfs_lookup_csums_range(csum_root, cur_logical,
+					cur_logical + scrub_len - 1,
+					&sctx->csum_list, 1);
+			if (ret)
+				break;
+		}
+		if ((extent_flags & BTRFS_EXTENT_FLAG_TREE_BLOCK) &&
+		    does_range_cross_boundary(extent_start, extent_len,
+			    		      logical_start, logical_length)) {
+			btrfs_err(fs_info,
+"scrub: tree block %llu spanning boundaries, ignored. boundary=[%llu, %llu)",
+				  extent_start, logical_start, logical_end);
+			spin_lock(&sctx->stat_lock);
+			sctx->stat.uncorrectable_errors++;
+			spin_unlock(&sctx->stat_lock);
+			cur_logical += scrub_len;
+			continue;
+		}
+		ret = scrub_extent(sctx, map, cur_logical, scrub_len, cur_physical,
+				   target_dev, extent_flags, extent_gen,
+				   cur_mirror, cur_logical - logical_start +
+				   physical);
+		scrub_free_csums(sctx);
+		if (ret)
+			break;
+		if (sctx->is_dev_replace)
+			sync_replace_for_zoned(sctx);
+		cur_logical += scrub_len;
+		/* Don't hold CPU for too long time */
+		cond_resched();
+	}
+	btrfs_release_path(&path);
+	return ret;
+}
+
 static noinline_for_stack int scrub_stripe(struct scrub_ctx *sctx,
 					   struct btrfs_block_group *bg,
 					   struct map_lookup *map,
@@ -3285,6 +3451,7 @@ static noinline_for_stack int scrub_stripe(struct scrub_ctx *sctx,
 	struct btrfs_root *csum_root;
 	struct btrfs_extent_item *extent;
 	struct blk_plug plug;
+	const u64 profile = map->type & BTRFS_BLOCK_GROUP_PROFILE_MASK;
 	const u64 chunk_logical = bg->start;
 	u64 flags;
 	int ret;
@@ -3379,6 +3546,29 @@ static noinline_for_stack int scrub_stripe(struct scrub_ctx *sctx,
 		sctx->flush_all_writes = true;
 	}
 
+	/*
+	 * There used to be a big double loop to handle all profiles using the
+	 * same routine, which grows larger and more gross over time.
+	 *
+	 * So here we handle each profile differently, so simpler profiles
+	 * have simpler scrubing function.
+	 */
+	if (!(profile & (BTRFS_BLOCK_GROUP_RAID0 | BTRFS_BLOCK_GROUP_RAID10 |
+			 BTRFS_BLOCK_GROUP_RAID56_MASK))) {
+		/*
+		 * Above check rules out all complex profile, the remaining
+		 * profiles are SINGLE|DUP|RAID1|RAID1C*, which is simple
+		 * mirrored duplication without stripe.
+		 *
+		 * Only @phsyical and @mirror_num needs to calculated using
+		 * @stripe_index.
+		 */
+		ret = scrub_simple_mirror(sctx, root, csum_root, bg, map,
+				bg->start, bg->length, scrub_dev,
+				map->stripes[stripe_index].physical,
+				stripe_index + 1);
+		goto out;
+	}
 	/*
 	 * now find all extents for each stripe and scrub them
 	 */
-- 
2.34.1

