Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C8B08836D3
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Aug 2019 18:29:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387928AbfHFQ3C (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 6 Aug 2019 12:29:02 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:45947 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387914AbfHFQ3B (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 6 Aug 2019 12:29:01 -0400
Received: by mail-qt1-f193.google.com with SMTP id x22so11747776qtp.12
        for <linux-btrfs@vger.kernel.org>; Tue, 06 Aug 2019 09:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=xdfns8kCVvt7j6WEKWO00KkAsXpj7Lh9vLXnakc+0Xs=;
        b=GeI2grAXtOi0YrtmqYj3lJgstQqusKBXmyRnXwFmBmhaYP6YMYyjpdYqUv3oRzflnI
         31hkyhVStcsrDJn0g+lwf7EWGjaziHLVFsYL9GcxLda0LNQRVD3YMyw6TM83gQZIG7Jt
         tP3e6HAeNjT7PbNvH19vdZWrpnco8yxPw9CUke6jwe6ZEBsZdqiMut65fNHROUmlqUzv
         Su3fpCuQFHn0wHC1CdLPkq2Rxc0V9MTvm9f0Unl0I6VWoqPWMCArEbmWHHOXg2PPNF6g
         R9DOiljmtl8imhwllJvd7tc+Ys8wO2N9RGExPZf2ME/yCPH30gBlpY0zLEvdlUmYnQyO
         MENw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xdfns8kCVvt7j6WEKWO00KkAsXpj7Lh9vLXnakc+0Xs=;
        b=jaIIdYR7EfNTw8YS3Tii3AmCIFOoz+VrBK8BMvKpdDhM+mbLH46aIqZNCq/qmUGBE0
         vmqjS9jfx+H9lqylg9rP6GuKD7bycd7mBst+4wXI5rsGyyCe8xu0RlzB3LWKLM47QvaH
         JOYy97+Zah+s2jWR/LRHeToWveVIjM29FRfCjsyGV/hX4LjoLGOKLok3W2xLkqLd49i7
         kzVc0G3dXxryGKErEmS3XrQxv25oNZ75iRobKjgvDZAKQkWrID7Hq244/ji5rGsEkhcA
         tVMtnIOtYUYBqSjsFV0Qf5q+vKrWdXa9lyn75nTGHyQyJqT0i/hwQ9XNZyDc6x+CJfCt
         P2ig==
X-Gm-Message-State: APjAAAXxgz+rLBPEg2vSgXvY03+zsmQCqjobnAqICngKqDYgIrO8Fqjx
        lf6gPkbrCnBdzS0+XmTyfKTxLDIrxLUkgw==
X-Google-Smtp-Source: APXvYqzz9jOYM+AsgaOLO1p5v5W7nkKWAgsXrLs7Nc6WFh7kanFRusphQoTOnz1sS+swWPSaQmBW+Q==
X-Received: by 2002:ac8:3907:: with SMTP id s7mr4027494qtb.374.1565108939948;
        Tue, 06 Aug 2019 09:28:59 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id y67sm39753883qkd.40.2019.08.06.09.28.59
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 06 Aug 2019 09:28:59 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     kernel-team@fb.com, linux-btrfs@vger.kernel.org
Subject: [PATCH 11/15] btrfs: migrate the chunk allocation code
Date:   Tue,  6 Aug 2019 12:28:33 -0400
Message-Id: <20190806162837.15840-12-josef@toxicpanda.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190806162837.15840-1-josef@toxicpanda.com>
References: <20190806162837.15840-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This feels more at home in block-group.c than in extent-tree.c.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/block-group.c    | 245 ++++++++++++++++++++++++++++++++++++++
 fs/btrfs/block-group.h    |  24 ++++
 fs/btrfs/ctree.h          |  24 ----
 fs/btrfs/delalloc-space.c |   1 +
 fs/btrfs/extent-tree.c    | 244 -------------------------------------
 5 files changed, 270 insertions(+), 268 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 5c2995d9b572..0221c8c6c7d4 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -13,6 +13,7 @@
 #include "sysfs.h"
 #include "tree-log.h"
 #include "delalloc-space.h"
+#include "math.h"
 
 void btrfs_get_block_group(struct btrfs_block_group_cache *cache)
 {
@@ -2708,3 +2709,247 @@ void btrfs_free_reserved_bytes(struct btrfs_block_group_cache *cache,
 	spin_unlock(&cache->lock);
 	spin_unlock(&space_info->lock);
 }
+
+static void force_metadata_allocation(struct btrfs_fs_info *info)
+{
+	struct list_head *head = &info->space_info;
+	struct btrfs_space_info *found;
+
+	rcu_read_lock();
+	list_for_each_entry_rcu(found, head, list) {
+		if (found->flags & BTRFS_BLOCK_GROUP_METADATA)
+			found->force_alloc = CHUNK_ALLOC_FORCE;
+	}
+	rcu_read_unlock();
+}
+
+static int should_alloc_chunk(struct btrfs_fs_info *fs_info,
+			      struct btrfs_space_info *sinfo, int force)
+{
+	u64 bytes_used = btrfs_space_info_used(sinfo, false);
+	u64 thresh;
+
+	if (force == CHUNK_ALLOC_FORCE)
+		return 1;
+
+	/*
+	 * in limited mode, we want to have some free space up to
+	 * about 1% of the FS size.
+	 */
+	if (force == CHUNK_ALLOC_LIMITED) {
+		thresh = btrfs_super_total_bytes(fs_info->super_copy);
+		thresh = max_t(u64, SZ_64M, div_factor_fine(thresh, 1));
+
+		if (sinfo->total_bytes - bytes_used < thresh)
+			return 1;
+	}
+
+	if (bytes_used + SZ_2M < div_factor(sinfo->total_bytes, 8))
+		return 0;
+	return 1;
+}
+
+static u64 get_profile_num_devs(struct btrfs_fs_info *fs_info, u64 type)
+{
+	u64 num_dev;
+
+	num_dev = btrfs_raid_array[btrfs_bg_flags_to_raid_index(type)].devs_max;
+	if (!num_dev)
+		num_dev = fs_info->fs_devices->rw_devices;
+
+	return num_dev;
+}
+
+/*
+ * If @is_allocation is true, reserve space in the system space info necessary
+ * for allocating a chunk, otherwise if it's false, reserve space necessary for
+ * removing a chunk.
+ */
+void check_system_chunk(struct btrfs_trans_handle *trans, u64 type)
+{
+	struct btrfs_fs_info *fs_info = trans->fs_info;
+	struct btrfs_space_info *info;
+	u64 left;
+	u64 thresh;
+	int ret = 0;
+	u64 num_devs;
+
+	/*
+	 * Needed because we can end up allocating a system chunk and for an
+	 * atomic and race free space reservation in the chunk block reserve.
+	 */
+	lockdep_assert_held(&fs_info->chunk_mutex);
+
+	info = btrfs_find_space_info(fs_info, BTRFS_BLOCK_GROUP_SYSTEM);
+	spin_lock(&info->lock);
+	left = info->total_bytes - btrfs_space_info_used(info, true);
+	spin_unlock(&info->lock);
+
+	num_devs = get_profile_num_devs(fs_info, type);
+
+	/* num_devs device items to update and 1 chunk item to add or remove */
+	thresh = btrfs_calc_trunc_metadata_size(fs_info, num_devs) +
+		btrfs_calc_trans_metadata_size(fs_info, 1);
+
+	if (left < thresh && btrfs_test_opt(fs_info, ENOSPC_DEBUG)) {
+		btrfs_info(fs_info, "left=%llu, need=%llu, flags=%llu",
+			   left, thresh, type);
+		btrfs_dump_space_info(fs_info, info, 0, 0);
+	}
+
+	if (left < thresh) {
+		u64 flags = btrfs_system_alloc_profile(fs_info);
+
+		/*
+		 * Ignore failure to create system chunk. We might end up not
+		 * needing it, as we might not need to COW all nodes/leafs from
+		 * the paths we visit in the chunk tree (they were already COWed
+		 * or created in the current transaction for example).
+		 */
+		ret = btrfs_alloc_chunk(trans, flags);
+	}
+
+	if (!ret) {
+		ret = btrfs_block_rsv_add(fs_info->chunk_root,
+					  &fs_info->chunk_block_rsv,
+					  thresh, BTRFS_RESERVE_NO_FLUSH);
+		if (!ret)
+			trans->chunk_bytes_reserved += thresh;
+	}
+}
+
+int btrfs_force_chunk_alloc(struct btrfs_trans_handle *trans, u64 type)
+{
+	u64 alloc_flags = btrfs_get_alloc_profile(trans->fs_info, type);
+
+	return btrfs_chunk_alloc(trans, alloc_flags, CHUNK_ALLOC_FORCE);
+}
+
+/*
+ * If force is CHUNK_ALLOC_FORCE:
+ *    - return 1 if it successfully allocates a chunk,
+ *    - return errors including -ENOSPC otherwise.
+ * If force is NOT CHUNK_ALLOC_FORCE:
+ *    - return 0 if it doesn't need to allocate a new chunk,
+ *    - return 1 if it successfully allocates a chunk,
+ *    - return errors including -ENOSPC otherwise.
+ */
+int btrfs_chunk_alloc(struct btrfs_trans_handle *trans, u64 flags,
+		      enum btrfs_chunk_alloc_enum force)
+{
+	struct btrfs_fs_info *fs_info = trans->fs_info;
+	struct btrfs_space_info *space_info;
+	bool wait_for_alloc = false;
+	bool should_alloc = false;
+	int ret = 0;
+
+	/* Don't re-enter if we're already allocating a chunk */
+	if (trans->allocating_chunk)
+		return -ENOSPC;
+
+	space_info = btrfs_find_space_info(fs_info, flags);
+	ASSERT(space_info);
+
+	do {
+		spin_lock(&space_info->lock);
+		if (force < space_info->force_alloc)
+			force = space_info->force_alloc;
+		should_alloc = should_alloc_chunk(fs_info, space_info, force);
+		if (space_info->full) {
+			/* No more free physical space */
+			if (should_alloc)
+				ret = -ENOSPC;
+			else
+				ret = 0;
+			spin_unlock(&space_info->lock);
+			return ret;
+		} else if (!should_alloc) {
+			spin_unlock(&space_info->lock);
+			return 0;
+		} else if (space_info->chunk_alloc) {
+			/*
+			 * Someone is already allocating, so we need to block
+			 * until this someone is finished and then loop to
+			 * recheck if we should continue with our allocation
+			 * attempt.
+			 */
+			wait_for_alloc = true;
+			spin_unlock(&space_info->lock);
+			mutex_lock(&fs_info->chunk_mutex);
+			mutex_unlock(&fs_info->chunk_mutex);
+		} else {
+			/* Proceed with allocation */
+			space_info->chunk_alloc = 1;
+			wait_for_alloc = false;
+			spin_unlock(&space_info->lock);
+		}
+
+		cond_resched();
+	} while (wait_for_alloc);
+
+	mutex_lock(&fs_info->chunk_mutex);
+	trans->allocating_chunk = true;
+
+	/*
+	 * If we have mixed data/metadata chunks we want to make sure we keep
+	 * allocating mixed chunks instead of individual chunks.
+	 */
+	if (btrfs_mixed_space_info(space_info))
+		flags |= (BTRFS_BLOCK_GROUP_DATA | BTRFS_BLOCK_GROUP_METADATA);
+
+	/*
+	 * if we're doing a data chunk, go ahead and make sure that
+	 * we keep a reasonable number of metadata chunks allocated in the
+	 * FS as well.
+	 */
+	if (flags & BTRFS_BLOCK_GROUP_DATA && fs_info->metadata_ratio) {
+		fs_info->data_chunk_allocations++;
+		if (!(fs_info->data_chunk_allocations %
+		      fs_info->metadata_ratio))
+			force_metadata_allocation(fs_info);
+	}
+
+	/*
+	 * Check if we have enough space in SYSTEM chunk because we may need
+	 * to update devices.
+	 */
+	check_system_chunk(trans, flags);
+
+	ret = btrfs_alloc_chunk(trans, flags);
+	trans->allocating_chunk = false;
+
+	spin_lock(&space_info->lock);
+	if (ret < 0) {
+		if (ret == -ENOSPC)
+			space_info->full = 1;
+		else
+			goto out;
+	} else {
+		ret = 1;
+		space_info->max_extent_size = 0;
+	}
+
+	space_info->force_alloc = CHUNK_ALLOC_NO_FORCE;
+out:
+	space_info->chunk_alloc = 0;
+	spin_unlock(&space_info->lock);
+	mutex_unlock(&fs_info->chunk_mutex);
+	/*
+	 * When we allocate a new chunk we reserve space in the chunk block
+	 * reserve to make sure we can COW nodes/leafs in the chunk tree or
+	 * add new nodes/leafs to it if we end up needing to do it when
+	 * inserting the chunk item and updating device items as part of the
+	 * second phase of chunk allocation, performed by
+	 * btrfs_finish_chunk_alloc(). So make sure we don't accumulate a
+	 * large number of new block groups to create in our transaction
+	 * handle's new_bgs list to avoid exhausting the chunk block reserve
+	 * in extreme cases - like having a single transaction create many new
+	 * block groups when starting to write out the free space caches of all
+	 * the block groups that were made dirty during the lifetime of the
+	 * transaction.
+	 */
+	if (trans->chunk_bytes_reserved >= (u64)SZ_2M)
+		btrfs_create_pending_block_groups(trans);
+
+	return ret;
+}
diff --git a/fs/btrfs/block-group.h b/fs/btrfs/block-group.h
index e17effab028f..4b8ac8e9323c 100644
--- a/fs/btrfs/block-group.h
+++ b/fs/btrfs/block-group.h
@@ -10,6 +10,26 @@ enum btrfs_disk_cache_state {
 	BTRFS_DC_SETUP,
 };
 
+/*
+ * control flags for do_chunk_alloc's force field
+ * CHUNK_ALLOC_NO_FORCE means to only allocate a chunk
+ * if we really need one.
+ *
+ * CHUNK_ALLOC_LIMITED means to only try and allocate one
+ * if we have very few chunks already allocated.  This is
+ * used as part of the clustering code to help make sure
+ * we have a good pool of storage to cluster in, without
+ * filling the FS with empty chunks
+ *
+ * CHUNK_ALLOC_FORCE means it must try to allocate one
+ *
+ */
+enum btrfs_chunk_alloc_enum {
+	CHUNK_ALLOC_NO_FORCE,
+	CHUNK_ALLOC_LIMITED,
+	CHUNK_ALLOC_FORCE,
+};
+
 struct btrfs_caching_control {
 	struct list_head list;
 	struct mutex mutex;
@@ -199,6 +219,10 @@ int btrfs_add_reserved_bytes(struct btrfs_block_group_cache *cache,
 			     u64 ram_bytes, u64 num_bytes, int delalloc);
 void btrfs_free_reserved_bytes(struct btrfs_block_group_cache *cache,
 			       u64 num_bytes, int delalloc);
+int btrfs_chunk_alloc(struct btrfs_trans_handle *trans, u64 flags,
+		      enum btrfs_chunk_alloc_enum force);
+int btrfs_force_chunk_alloc(struct btrfs_trans_handle *trans, u64 type);
+void check_system_chunk(struct btrfs_trans_handle *trans, const u64 type);
 
 static inline int btrfs_block_group_cache_done(
 		struct btrfs_block_group_cache *cache)
diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 2a41e09727c3..db56a1c81843 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -2556,28 +2556,6 @@ enum btrfs_flush_state {
 	COMMIT_TRANS		=	10,
 };
 
-/*
- * control flags for do_chunk_alloc's force field
- * CHUNK_ALLOC_NO_FORCE means to only allocate a chunk
- * if we really need one.
- *
- * CHUNK_ALLOC_LIMITED means to only try and allocate one
- * if we have very few chunks already allocated.  This is
- * used as part of the clustering code to help make sure
- * we have a good pool of storage to cluster in, without
- * filling the FS with empty chunks
- *
- * CHUNK_ALLOC_FORCE means it must try to allocate one
- *
- */
-enum btrfs_chunk_alloc_enum {
-	CHUNK_ALLOC_NO_FORCE,
-	CHUNK_ALLOC_LIMITED,
-	CHUNK_ALLOC_FORCE,
-};
-
-int btrfs_chunk_alloc(struct btrfs_trans_handle *trans, u64 flags,
-		      enum btrfs_chunk_alloc_enum force);
 int btrfs_subvolume_reserve_metadata(struct btrfs_root *root,
 				     struct btrfs_block_rsv *rsv,
 				     int nitems, bool use_global_rsv);
@@ -2593,7 +2571,6 @@ int btrfs_error_unpin_extent_range(struct btrfs_fs_info *fs_info,
 				   u64 start, u64 end);
 int btrfs_discard_extent(struct btrfs_fs_info *fs_info, u64 bytenr,
 			 u64 num_bytes, u64 *actual_bytes);
-int btrfs_force_chunk_alloc(struct btrfs_trans_handle *trans, u64 type);
 int btrfs_trim_fs(struct btrfs_fs_info *fs_info, struct fstrim_range *range);
 
 int btrfs_init_space_info(struct btrfs_fs_info *fs_info);
@@ -2602,7 +2579,6 @@ int btrfs_delayed_refs_qgroup_accounting(struct btrfs_trans_handle *trans,
 int btrfs_start_write_no_snapshotting(struct btrfs_root *root);
 void btrfs_end_write_no_snapshotting(struct btrfs_root *root);
 void btrfs_wait_for_snapshot_creation(struct btrfs_root *root);
-void check_system_chunk(struct btrfs_trans_handle *trans, const u64 type);
 
 /* ctree.c */
 int btrfs_bin_search(struct extent_buffer *eb, const struct btrfs_key *key,
diff --git a/fs/btrfs/delalloc-space.c b/fs/btrfs/delalloc-space.c
index 17f7c0d38768..d2dfc201b2e1 100644
--- a/fs/btrfs/delalloc-space.c
+++ b/fs/btrfs/delalloc-space.c
@@ -7,6 +7,7 @@
 #include "space-info.h"
 #include "transaction.h"
 #include "qgroup.h"
+#include "block-group.h"
 
 int btrfs_alloc_data_chunk_ondemand(struct btrfs_inode *inode, u64 bytes)
 {
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 7e694d4837ad..a218f2187ebe 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -2677,243 +2677,6 @@ u64 btrfs_system_alloc_profile(struct btrfs_fs_info *fs_info)
 	return btrfs_get_alloc_profile(fs_info, BTRFS_BLOCK_GROUP_SYSTEM);
 }
 
-static void force_metadata_allocation(struct btrfs_fs_info *info)
-{
-	struct list_head *head = &info->space_info;
-	struct btrfs_space_info *found;
-
-	rcu_read_lock();
-	list_for_each_entry_rcu(found, head, list) {
-		if (found->flags & BTRFS_BLOCK_GROUP_METADATA)
-			found->force_alloc = CHUNK_ALLOC_FORCE;
-	}
-	rcu_read_unlock();
-}
-
-static int should_alloc_chunk(struct btrfs_fs_info *fs_info,
-			      struct btrfs_space_info *sinfo, int force)
-{
-	u64 bytes_used = btrfs_space_info_used(sinfo, false);
-	u64 thresh;
-
-	if (force == CHUNK_ALLOC_FORCE)
-		return 1;
-
-	/*
-	 * in limited mode, we want to have some free space up to
-	 * about 1% of the FS size.
-	 */
-	if (force == CHUNK_ALLOC_LIMITED) {
-		thresh = btrfs_super_total_bytes(fs_info->super_copy);
-		thresh = max_t(u64, SZ_64M, div_factor_fine(thresh, 1));
-
-		if (sinfo->total_bytes - bytes_used < thresh)
-			return 1;
-	}
-
-	if (bytes_used + SZ_2M < div_factor(sinfo->total_bytes, 8))
-		return 0;
-	return 1;
-}
-
-static u64 get_profile_num_devs(struct btrfs_fs_info *fs_info, u64 type)
-{
-	u64 num_dev;
-
-	num_dev = btrfs_raid_array[btrfs_bg_flags_to_raid_index(type)].devs_max;
-	if (!num_dev)
-		num_dev = fs_info->fs_devices->rw_devices;
-
-	return num_dev;
-}
-
-/*
- * If @is_allocation is true, reserve space in the system space info necessary
- * for allocating a chunk, otherwise if it's false, reserve space necessary for
- * removing a chunk.
- */
-void check_system_chunk(struct btrfs_trans_handle *trans, u64 type)
-{
-	struct btrfs_fs_info *fs_info = trans->fs_info;
-	struct btrfs_space_info *info;
-	u64 left;
-	u64 thresh;
-	int ret = 0;
-	u64 num_devs;
-
-	/*
-	 * Needed because we can end up allocating a system chunk and for an
-	 * atomic and race free space reservation in the chunk block reserve.
-	 */
-	lockdep_assert_held(&fs_info->chunk_mutex);
-
-	info = btrfs_find_space_info(fs_info, BTRFS_BLOCK_GROUP_SYSTEM);
-	spin_lock(&info->lock);
-	left = info->total_bytes - btrfs_space_info_used(info, true);
-	spin_unlock(&info->lock);
-
-	num_devs = get_profile_num_devs(fs_info, type);
-
-	/* num_devs device items to update and 1 chunk item to add or remove */
-	thresh = btrfs_calc_trunc_metadata_size(fs_info, num_devs) +
-		btrfs_calc_trans_metadata_size(fs_info, 1);
-
-	if (left < thresh && btrfs_test_opt(fs_info, ENOSPC_DEBUG)) {
-		btrfs_info(fs_info, "left=%llu, need=%llu, flags=%llu",
-			   left, thresh, type);
-		btrfs_dump_space_info(fs_info, info, 0, 0);
-	}
-
-	if (left < thresh) {
-		u64 flags = btrfs_system_alloc_profile(fs_info);
-
-		/*
-		 * Ignore failure to create system chunk. We might end up not
-		 * needing it, as we might not need to COW all nodes/leafs from
-		 * the paths we visit in the chunk tree (they were already COWed
-		 * or created in the current transaction for example).
-		 */
-		ret = btrfs_alloc_chunk(trans, flags);
-	}
-
-	if (!ret) {
-		ret = btrfs_block_rsv_add(fs_info->chunk_root,
-					  &fs_info->chunk_block_rsv,
-					  thresh, BTRFS_RESERVE_NO_FLUSH);
-		if (!ret)
-			trans->chunk_bytes_reserved += thresh;
-	}
-}
-
-/*
- * If force is CHUNK_ALLOC_FORCE:
- *    - return 1 if it successfully allocates a chunk,
- *    - return errors including -ENOSPC otherwise.
- * If force is NOT CHUNK_ALLOC_FORCE:
- *    - return 0 if it doesn't need to allocate a new chunk,
- *    - return 1 if it successfully allocates a chunk,
- *    - return errors including -ENOSPC otherwise.
- */
-int btrfs_chunk_alloc(struct btrfs_trans_handle *trans, u64 flags,
-		      enum btrfs_chunk_alloc_enum force)
-{
-	struct btrfs_fs_info *fs_info = trans->fs_info;
-	struct btrfs_space_info *space_info;
-	bool wait_for_alloc = false;
-	bool should_alloc = false;
-	int ret = 0;
-
-	/* Don't re-enter if we're already allocating a chunk */
-	if (trans->allocating_chunk)
-		return -ENOSPC;
-
-	space_info = btrfs_find_space_info(fs_info, flags);
-	ASSERT(space_info);
-
-	do {
-		spin_lock(&space_info->lock);
-		if (force < space_info->force_alloc)
-			force = space_info->force_alloc;
-		should_alloc = should_alloc_chunk(fs_info, space_info, force);
-		if (space_info->full) {
-			/* No more free physical space */
-			if (should_alloc)
-				ret = -ENOSPC;
-			else
-				ret = 0;
-			spin_unlock(&space_info->lock);
-			return ret;
-		} else if (!should_alloc) {
-			spin_unlock(&space_info->lock);
-			return 0;
-		} else if (space_info->chunk_alloc) {
-			/*
-			 * Someone is already allocating, so we need to block
-			 * until this someone is finished and then loop to
-			 * recheck if we should continue with our allocation
-			 * attempt.
-			 */
-			wait_for_alloc = true;
-			spin_unlock(&space_info->lock);
-			mutex_lock(&fs_info->chunk_mutex);
-			mutex_unlock(&fs_info->chunk_mutex);
-		} else {
-			/* Proceed with allocation */
-			space_info->chunk_alloc = 1;
-			wait_for_alloc = false;
-			spin_unlock(&space_info->lock);
-		}
-
-		cond_resched();
-	} while (wait_for_alloc);
-
-	mutex_lock(&fs_info->chunk_mutex);
-	trans->allocating_chunk = true;
-
-	/*
-	 * If we have mixed data/metadata chunks we want to make sure we keep
-	 * allocating mixed chunks instead of individual chunks.
-	 */
-	if (btrfs_mixed_space_info(space_info))
-		flags |= (BTRFS_BLOCK_GROUP_DATA | BTRFS_BLOCK_GROUP_METADATA);
-
-	/*
-	 * if we're doing a data chunk, go ahead and make sure that
-	 * we keep a reasonable number of metadata chunks allocated in the
-	 * FS as well.
-	 */
-	if (flags & BTRFS_BLOCK_GROUP_DATA && fs_info->metadata_ratio) {
-		fs_info->data_chunk_allocations++;
-		if (!(fs_info->data_chunk_allocations %
-		      fs_info->metadata_ratio))
-			force_metadata_allocation(fs_info);
-	}
-
-	/*
-	 * Check if we have enough space in SYSTEM chunk because we may need
-	 * to update devices.
-	 */
-	check_system_chunk(trans, flags);
-
-	ret = btrfs_alloc_chunk(trans, flags);
-	trans->allocating_chunk = false;
-
-	spin_lock(&space_info->lock);
-	if (ret < 0) {
-		if (ret == -ENOSPC)
-			space_info->full = 1;
-		else
-			goto out;
-	} else {
-		ret = 1;
-		space_info->max_extent_size = 0;
-	}
-
-	space_info->force_alloc = CHUNK_ALLOC_NO_FORCE;
-out:
-	space_info->chunk_alloc = 0;
-	spin_unlock(&space_info->lock);
-	mutex_unlock(&fs_info->chunk_mutex);
-	/*
-	 * When we allocate a new chunk we reserve space in the chunk block
-	 * reserve to make sure we can COW nodes/leafs in the chunk tree or
-	 * add new nodes/leafs to it if we end up needing to do it when
-	 * inserting the chunk item and updating device items as part of the
-	 * second phase of chunk allocation, performed by
-	 * btrfs_finish_chunk_alloc(). So make sure we don't accumulate a
-	 * large number of new block groups to create in our transaction
-	 * handle's new_bgs list to avoid exhausting the chunk block reserve
-	 * in extreme cases - like having a single transaction create many new
-	 * block groups when starting to write out the free space caches of all
-	 * the block groups that were made dirty during the lifetime of the
-	 * transaction.
-	 */
-	if (trans->chunk_bytes_reserved >= (u64)SZ_2M)
-		btrfs_create_pending_block_groups(trans);
-
-	return ret;
-}
-
 static u64 first_logical_byte(struct btrfs_fs_info *fs_info, u64 search_start)
 {
 	struct btrfs_block_group_cache *cache;
@@ -5971,13 +5734,6 @@ int btrfs_drop_subtree(struct btrfs_trans_handle *trans,
 	return ret;
 }
 
-int btrfs_force_chunk_alloc(struct btrfs_trans_handle *trans, u64 type)
-{
-	u64 alloc_flags = btrfs_get_alloc_profile(trans->fs_info, type);
-
-	return btrfs_chunk_alloc(trans, alloc_flags, CHUNK_ALLOC_FORCE);
-}
-
 /*
  * helper to account the unused space of all the readonly block group in the
  * space_info. takes mirrors into account.
-- 
2.21.0

