Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05ED779E690
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Sep 2023 13:23:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239722AbjIMLX1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 13 Sep 2023 07:23:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236689AbjIMLX0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 13 Sep 2023 07:23:26 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B88B01BD1
        for <linux-btrfs@vger.kernel.org>; Wed, 13 Sep 2023 04:23:22 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D12F9C433C7
        for <linux-btrfs@vger.kernel.org>; Wed, 13 Sep 2023 11:23:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694604202;
        bh=gSXEvFP3axoMJWWxToOju1Yy097ogBenyTY0rC35aWU=;
        h=From:To:Subject:Date:From;
        b=Z6IScaZxW8hmCeUgV8eI4WFXO7aYEWSImGtLbvJkb/ZE/L2G0noqnXm+Kt/u57zVW
         BetWC+f9PiE2joDLxyYNV4NMbjCMXeIBFNbLXDmrxXaYfoYSgAYA8pqCmiUnOHCjuu
         rlZ6tiD4ZoGGq4MpWdUccEYWoKn6mwUg0Y63IxnW9lOD/cT4uo24TLqTSThnBB6zqc
         Hy25ngs+056lSiPliAEbdhSAALopzQM/qRmZdTcw9rYQNQnQxVMi0e0ZCailvjwoJ6
         pORZMNPndIN/4X5AQmzPZ6wyzFFDUtwYjSVLmZIJJRMp5ofNHINY9nsfM5pcpbdERn
         Dup9YXifuNegg==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: remove pointless loop from btrfs_update_block_group()
Date:   Wed, 13 Sep 2023 12:23:18 +0100
Message-Id: <cc34f95eab414767ea9c95bfbbd1700267ef1dd0.1694604142.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

When an extent is allocated or freed, we call btrfs_update_block_group()
to update its block group and space info. An extent always belongs to a
single block group, it can never span multiple block groups, so the loop
we have at btrfs_update_block_group() is pointless, as it always has a
single iteration. The loop was added in the very early days, 2007, when
the block group code was added in commit 9078a3e1e4e4 ("Btrfs: start of
block group code"), but even back then it seemed pointless.

So remove the loop and assert the block group containg the start offset
of the extent also contains the whole extent.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/block-group.c | 147 +++++++++++++++++++----------------------
 1 file changed, 67 insertions(+), 80 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 5ba57ea03f42..72dbfb410e42 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -3542,12 +3542,11 @@ int btrfs_update_block_group(struct btrfs_trans_handle *trans,
 			     u64 bytenr, u64 num_bytes, bool alloc)
 {
 	struct btrfs_fs_info *info = trans->fs_info;
-	struct btrfs_block_group *cache = NULL;
-	u64 total = num_bytes;
+	struct btrfs_space_info *space_info;
+	struct btrfs_block_group *cache;
 	u64 old_val;
-	u64 byte_in_group;
+	bool reclaim = false;
 	int factor;
-	int ret = 0;
 
 	/* Block accounting for super block */
 	spin_lock(&info->delalloc_root_lock);
@@ -3559,97 +3558,85 @@ int btrfs_update_block_group(struct btrfs_trans_handle *trans,
 	btrfs_set_super_bytes_used(info->super_copy, old_val);
 	spin_unlock(&info->delalloc_root_lock);
 
-	while (total) {
-		struct btrfs_space_info *space_info;
-		bool reclaim = false;
-
-		cache = btrfs_lookup_block_group(info, bytenr);
-		if (!cache) {
-			ret = -ENOENT;
-			break;
-		}
-		space_info = cache->space_info;
-		factor = btrfs_bg_type_to_factor(cache->flags);
+	cache = btrfs_lookup_block_group(info, bytenr);
+	if (!cache)
+		return -ENOENT;
 
-		/*
-		 * If this block group has free space cache written out, we
-		 * need to make sure to load it if we are removing space.  This
-		 * is because we need the unpinning stage to actually add the
-		 * space back to the block group, otherwise we will leak space.
-		 */
-		if (!alloc && !btrfs_block_group_done(cache))
-			btrfs_cache_block_group(cache, true);
+	/* An extent can not span multiple block groups. */
+	ASSERT(bytenr + num_bytes <= cache->start + cache->length);
 
-		byte_in_group = bytenr - cache->start;
-		WARN_ON(byte_in_group > cache->length);
+	space_info = cache->space_info;
+	factor = btrfs_bg_type_to_factor(cache->flags);
 
-		spin_lock(&space_info->lock);
-		spin_lock(&cache->lock);
+	/*
+	 * If this block group has free space cache written out, we need to make
+	 * sure to load it if we are removing space.  This is because we need
+	 * the unpinning stage to actually add the space back to the block group,
+	 * otherwise we will leak space.
+	 */
+	if (!alloc && !btrfs_block_group_done(cache))
+		btrfs_cache_block_group(cache, true);
 
-		if (btrfs_test_opt(info, SPACE_CACHE) &&
-		    cache->disk_cache_state < BTRFS_DC_CLEAR)
-			cache->disk_cache_state = BTRFS_DC_CLEAR;
+	spin_lock(&space_info->lock);
+	spin_lock(&cache->lock);
 
-		old_val = cache->used;
-		num_bytes = min(total, cache->length - byte_in_group);
-		if (alloc) {
-			old_val += num_bytes;
-			cache->used = old_val;
-			cache->reserved -= num_bytes;
-			space_info->bytes_reserved -= num_bytes;
-			space_info->bytes_used += num_bytes;
-			space_info->disk_used += num_bytes * factor;
-			spin_unlock(&cache->lock);
-			spin_unlock(&space_info->lock);
-		} else {
-			old_val -= num_bytes;
-			cache->used = old_val;
-			cache->pinned += num_bytes;
-			btrfs_space_info_update_bytes_pinned(info, space_info,
-							     num_bytes);
-			space_info->bytes_used -= num_bytes;
-			space_info->disk_used -= num_bytes * factor;
+	if (btrfs_test_opt(info, SPACE_CACHE) &&
+	    cache->disk_cache_state < BTRFS_DC_CLEAR)
+		cache->disk_cache_state = BTRFS_DC_CLEAR;
 
-			reclaim = should_reclaim_block_group(cache, num_bytes);
+	old_val = cache->used;
+	if (alloc) {
+		old_val += num_bytes;
+		cache->used = old_val;
+		cache->reserved -= num_bytes;
+		space_info->bytes_reserved -= num_bytes;
+		space_info->bytes_used += num_bytes;
+		space_info->disk_used += num_bytes * factor;
+		spin_unlock(&cache->lock);
+		spin_unlock(&space_info->lock);
+	} else {
+		old_val -= num_bytes;
+		cache->used = old_val;
+		cache->pinned += num_bytes;
+		btrfs_space_info_update_bytes_pinned(info, space_info, num_bytes);
+		space_info->bytes_used -= num_bytes;
+		space_info->disk_used -= num_bytes * factor;
 
-			spin_unlock(&cache->lock);
-			spin_unlock(&space_info->lock);
+		reclaim = should_reclaim_block_group(cache, num_bytes);
 
-			set_extent_bit(&trans->transaction->pinned_extents,
-				       bytenr, bytenr + num_bytes - 1,
-				       EXTENT_DIRTY, NULL);
-		}
+		spin_unlock(&cache->lock);
+		spin_unlock(&space_info->lock);
 
-		spin_lock(&trans->transaction->dirty_bgs_lock);
-		if (list_empty(&cache->dirty_list)) {
-			list_add_tail(&cache->dirty_list,
-				      &trans->transaction->dirty_bgs);
-			trans->delayed_ref_updates++;
-			btrfs_get_block_group(cache);
-		}
-		spin_unlock(&trans->transaction->dirty_bgs_lock);
+		set_extent_bit(&trans->transaction->pinned_extents, bytenr,
+			       bytenr + num_bytes - 1, EXTENT_DIRTY, NULL);
+	}
 
-		/*
-		 * No longer have used bytes in this block group, queue it for
-		 * deletion. We do this after adding the block group to the
-		 * dirty list to avoid races between cleaner kthread and space
-		 * cache writeout.
-		 */
-		if (!alloc && old_val == 0) {
-			if (!btrfs_test_opt(info, DISCARD_ASYNC))
-				btrfs_mark_bg_unused(cache);
-		} else if (!alloc && reclaim) {
-			btrfs_mark_bg_to_reclaim(cache);
-		}
+	spin_lock(&trans->transaction->dirty_bgs_lock);
+	if (list_empty(&cache->dirty_list)) {
+		list_add_tail(&cache->dirty_list, &trans->transaction->dirty_bgs);
+		trans->delayed_ref_updates++;
+		btrfs_get_block_group(cache);
+	}
+	spin_unlock(&trans->transaction->dirty_bgs_lock);
 
-		btrfs_put_block_group(cache);
-		total -= num_bytes;
-		bytenr += num_bytes;
+	/*
+	 * No longer have used bytes in this block group, queue it for deletion.
+	 * We do this after adding the block group to the dirty list to avoid
+	 * races between cleaner kthread and space cache writeout.
+	 */
+	if (!alloc && old_val == 0) {
+		if (!btrfs_test_opt(info, DISCARD_ASYNC))
+			btrfs_mark_bg_unused(cache);
+	} else if (!alloc && reclaim) {
+		btrfs_mark_bg_to_reclaim(cache);
 	}
 
+	btrfs_put_block_group(cache);
+
 	/* Modified block groups are accounted for in the delayed_refs_rsv. */
 	btrfs_update_delayed_refs_rsv(trans);
-	return ret;
+
+	return 0;
 }
 
 /*
-- 
2.40.1

