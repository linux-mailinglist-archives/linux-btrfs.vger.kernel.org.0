Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D24B54DA63
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Jun 2019 21:38:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726871AbfFTTit (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 20 Jun 2019 15:38:49 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:46184 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726834AbfFTTir (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 20 Jun 2019 15:38:47 -0400
Received: by mail-yw1-f67.google.com with SMTP id z197so1655547ywd.13
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Jun 2019 12:38:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=3Djb1VJlpDW68bjGzCWXbs9xypFxoqiJwUdTmFiEcF0=;
        b=C0sQwraTbPs/2FeNIvtyphgsLyGcjCd7L5Og8AjPKK6tdKmJPZ4xfeoPUS7jHNb0M7
         MAjMBI0CjbApVKoO3bHBp4kSDESkTo5VB86xzQR+7Chv6YVqc/GfoLUoZQSQQnLlqwwt
         y0WpN5K8CEp4JyDgiGBS5jD48E9fjaZ8nnghDxBRQbvFLctb69U9V7cxgf0xGfGyE6//
         VUamajHpgw7nWvPm+WZSzlaYFTHgH7H8A4V3W8hAAHeqAO/0o7qxCIcFbVUJlYrlnPYR
         wtlusimynJIkfK3dccqZADLHyaUtzx9tQsPbXr6NAEABJxlV0q3nRNqD3EDPEmTyA/H4
         NvKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=3Djb1VJlpDW68bjGzCWXbs9xypFxoqiJwUdTmFiEcF0=;
        b=SKl+70yXaM74c+2qLddwgvcIV+Gt1jrsdHrT5Lf3vZ2gMngpFainOfZhhSajrRKzGT
         JEWiaA8ohYU3S2nP6IzKSctOt2zpwWfwtLQ4l+thYaWj6kqiy61DewwNojkkEkuKO7/R
         4XrXbwTaYzbb1uCtqwq7Wmx2wyewplEtfO4T8lW4K7J2YgJNJ7hcSiDC+koL1jk8+EX9
         A/3++4Xv1IlSowkNUQa9Goe17xR7sUYLUaAs/oPqjksBno+okEYzLu/qDsp2gS6ylgYH
         0KY3I/SdYxU8JLXdnHTVR583lcMqrKFOu8+FJivI4MiSTVnxfi9XW9RwbwPd2M/z9EZx
         H+gg==
X-Gm-Message-State: APjAAAVV6kyo2avf2xvU4ymE09HTPItMmt4y+WAIlPihY0WoMfYQMHhT
        FFCLe/6tsCmy03tQ1Fgqw+TTynDkWAIhiw==
X-Google-Smtp-Source: APXvYqzzfKxUxemFZuoJW1hzpWLtObz3unQo9RsCVQCWh6z6R8L0jsFVSVkAlZR87X7r48vTgPosbA==
X-Received: by 2002:a81:6987:: with SMTP id e129mr62814245ywc.283.1561059525278;
        Thu, 20 Jun 2019 12:38:45 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id l5sm114484ywf.11.2019.06.20.12.38.44
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Jun 2019 12:38:44 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 22/25] btrfs: migrate the chunk allocation code
Date:   Thu, 20 Jun 2019 15:38:04 -0400
Message-Id: <20190620193807.29311-23-josef@toxicpanda.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20190620193807.29311-1-josef@toxicpanda.com>
References: <20190620193807.29311-1-josef@toxicpanda.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This feels more at home in block-group.c than in extent-tree.c.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/block-group.c    | 247 ++++++++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/block-group.h    |  24 +++++
 fs/btrfs/ctree.h          |  24 -----
 fs/btrfs/delalloc-space.c |   1 +
 fs/btrfs/extent-tree.c    | 246 ---------------------------------------------
 5 files changed, 272 insertions(+), 270 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 4d029089ec32..942763738457 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -15,6 +15,7 @@
 #include "sysfs.h"
 #include "tree-log.h"
 #include "delalloc-space.h"
+#include "math.h"
 
 void btrfs_get_block_group(struct btrfs_block_group_cache *cache)
 {
@@ -2820,3 +2821,249 @@ int btrfs_can_relocate(struct btrfs_fs_info *fs_info, u64 bytenr)
 	btrfs_put_block_group(block_group);
 	return ret;
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
+	int orig_force = force;
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
+			force = orig_force;
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
diff --git a/fs/btrfs/block-group.h b/fs/btrfs/block-group.h
index 328cbffc5ce8..ee34d4e9d0b7 100644
--- a/fs/btrfs/block-group.h
+++ b/fs/btrfs/block-group.h
@@ -13,6 +13,26 @@ enum btrfs_disk_cache_state {
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
+	CHUNK_ALLOC_NO_FORCE = 0,
+	CHUNK_ALLOC_LIMITED = 1,
+	CHUNK_ALLOC_FORCE = 2,
+};
+
 struct btrfs_caching_control {
 	struct list_head list;
 	struct mutex mutex;
@@ -203,6 +223,10 @@ int btrfs_add_reserved_bytes(struct btrfs_block_group_cache *cache,
 void btrfs_free_reserved_bytes(struct btrfs_block_group_cache *cache,
 			       u64 num_bytes, int delalloc);
 int btrfs_can_relocate(struct btrfs_fs_info *fs_info, u64 bytenr);
+int btrfs_chunk_alloc(struct btrfs_trans_handle *trans, u64 flags,
+		      enum btrfs_chunk_alloc_enum force);
+int btrfs_force_chunk_alloc(struct btrfs_trans_handle *trans, u64 type);
+void check_system_chunk(struct btrfs_trans_handle *trans, const u64 type);
 
 static inline int
 btrfs_block_group_cache_done(struct btrfs_block_group_cache *cache)
diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index e6b32c0fcbb4..1cf7f47484b6 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -2551,28 +2551,6 @@ enum btrfs_flush_state {
 	COMMIT_TRANS		=	9,
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
-	CHUNK_ALLOC_NO_FORCE = 0,
-	CHUNK_ALLOC_LIMITED = 1,
-	CHUNK_ALLOC_FORCE = 2,
-};
-
-int btrfs_chunk_alloc(struct btrfs_trans_handle *trans, u64 flags,
-		      enum btrfs_chunk_alloc_enum force);
 int btrfs_subvolume_reserve_metadata(struct btrfs_root *root,
 				     struct btrfs_block_rsv *rsv,
 				     int nitems, bool use_global_rsv);
@@ -2588,7 +2566,6 @@ int btrfs_error_unpin_extent_range(struct btrfs_fs_info *fs_info,
 				   u64 start, u64 end);
 int btrfs_discard_extent(struct btrfs_fs_info *fs_info, u64 bytenr,
 			 u64 num_bytes, u64 *actual_bytes);
-int btrfs_force_chunk_alloc(struct btrfs_trans_handle *trans, u64 type);
 int btrfs_trim_fs(struct btrfs_fs_info *fs_info, struct fstrim_range *range);
 
 int btrfs_init_space_info(struct btrfs_fs_info *fs_info);
@@ -2597,7 +2574,6 @@ int btrfs_delayed_refs_qgroup_accounting(struct btrfs_trans_handle *trans,
 int btrfs_start_write_no_snapshotting(struct btrfs_root *root);
 void btrfs_end_write_no_snapshotting(struct btrfs_root *root);
 void btrfs_wait_for_snapshot_creation(struct btrfs_root *root);
-void check_system_chunk(struct btrfs_trans_handle *trans, const u64 type);
 
 /* ctree.c */
 int btrfs_bin_search(struct extent_buffer *eb, const struct btrfs_key *key,
diff --git a/fs/btrfs/delalloc-space.c b/fs/btrfs/delalloc-space.c
index 260c152d0d84..764ef6b6e58a 100644
--- a/fs/btrfs/delalloc-space.c
+++ b/fs/btrfs/delalloc-space.c
@@ -10,6 +10,7 @@
 #include "space-info.h"
 #include "transaction.h"
 #include "qgroup.h"
+#include "block-group.h"
 
 int btrfs_alloc_data_chunk_ondemand(struct btrfs_inode *inode, u64 bytes)
 {
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index b72bc622cb9a..70f6d5fce42e 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -2656,245 +2656,6 @@ u64 btrfs_system_alloc_profile(struct btrfs_fs_info *fs_info)
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
-	int orig_force = force;
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
-			force = orig_force;
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
@@ -5831,13 +5592,6 @@ int btrfs_drop_subtree(struct btrfs_trans_handle *trans,
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
2.14.3

