Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 012FB3B736B
	for <lists+linux-btrfs@lfdr.de>; Tue, 29 Jun 2021 15:43:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234150AbhF2Npn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 29 Jun 2021 09:45:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:59546 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234135AbhF2Npl (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 29 Jun 2021 09:45:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8F4C361DCB;
        Tue, 29 Jun 2021 13:43:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624974194;
        bh=lgat5IwWX8vIQ6Xd/DIiFfVf1mzutq1YvBQwdry7UWg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HWi/LsUiCmgAbRzRpG/+qRJpw4ohhcsVzFUFLNYh+QR5+2vSqWJkR4e9CteO1sx1o
         Bqr5mE9McgKB4gwmfs3DvX5dDEv2iA5pctGojOA5IsmJHJl/68oKLxwfsXS7tPgggI
         U0Y659YGoFeuK1Z8p0Q2ggd/cNyK4JM3ODfxfEUtSXbMoNOQ9J7zF7t6egNGt8Oo84
         V1D7rhp0+UuRJ9BilQGsLQcQZDovLCoexF6IyGfkGogFTW/9CC3iAv+r2aNznuQbdj
         Ot4Sn9c7XBaHp3qKb48PI6RNqPzhR30muC5L3Z7qwt7OYYumnNmoICXBptuH+b0csQ
         loVIxqeGBafXg==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Cc:     naohiro.aota@wdc.com, Filipe Manana <fdmanana@suse.com>
Subject: [PATCH 2/2] btrfs: rework chunk allocation to avoid exhaustion of the system chunk array
Date:   Tue, 29 Jun 2021 14:43:06 +0100
Message-Id: <6a715978a2539344e0c795754817746e06b73438.1624973480.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1624973480.git.fdmanana@suse.com>
References: <cover.1624973480.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

Commit eafa4fd0ad0607 ("btrfs: fix exhaustion of the system chunk array
due to concurrent allocations") fixed a problem that resulted in
exhausting the system chunk array in the superblock when there are many
tasks allocating chunks in parallel. Basically too many tasks enter the
first phase of chunk allocation without previous tasks having finished
their second phase of allocation, resulting in too many system chunks
being allocated. That was originally observed when running the fallocate
tests of stress-ng on a PowerPC machine, using a node size of 64K.

However that commit also introduced a deadlock where a task in phase 1 of
the chunk allocation waited for another task that had allocated a system
chunk to finish its phase 2, but that other task was waiting on an extent
buffer lock held by the first task, therefore resulting in both tasks not
making any progress. That change was later reverted by a patch with the
subject "btrfs: fix deadlock with concurrent chunk allocations involving
system chunks", since there is no simple and short solution to address it
and the deadlock is relatively easy to trigger on zoned filesystems, while
the system chunk array exhaustion is not so common.

This change reworks the chunk allocation to avoid the system chunk array
exhaustion. It accomplishes that by making the first phase of chunk
allocation do the updates of the device items in the chunk btree and the
insertion of the new chunk item in the chunk btree. This is done while
under the protection of the chunk mutex (fs_info->chunk_mutex), in the
same critical section that checks for available system space, allocates
a new system chunk if needed and reserves system chunk space. This way
we do not have chunk space reserved until the second phase completes.

The same logic is applied to chunk removal as well, since it keeps
reserved system space long after it is done updating the chunk btree.

For direct allocation of system chunks, the previous behaviour remains,
because otherwise we would deadlock on extent buffers of the chunk btree.
Changes to the chunk btree are by large done by chunk allocation and chunk
removal, which first reserve chunk system space and then later do changes
to the chunk btree. The other remaining cases are uncommon and correspond
to adding a device, removing a device and resizing a device. All these
other cases do not pre-reserve system space, they modify the chunk btree
right away, so they don't hold reserved space for a long period like chunk
allocation and chunk removal do.

The diff of this change is huge, but more than half of it is just addition
of comments describing both how things work regarding chunk allocation and
removal, including both the new behavior and the parts of the old behavior
that did not change.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/block-group.c | 285 ++++++++++++++++++++++++++++-----
 fs/btrfs/block-group.h |   6 +-
 fs/btrfs/ctree.c       |  67 ++------
 fs/btrfs/transaction.c |  10 +-
 fs/btrfs/transaction.h |   2 +-
 fs/btrfs/volumes.c     | 355 +++++++++++++++++++++++++++++++----------
 fs/btrfs/volumes.h     |   5 +-
 7 files changed, 546 insertions(+), 184 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 9aaa9af0ecaf..f376439a3340 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -2197,6 +2197,13 @@ int btrfs_read_block_groups(struct btrfs_fs_info *info)
 	return ret;
 }
 
+/*
+ * This function, insert_block_group_item(), belongs to the phase 2 of chunk
+ * allocation.
+ *
+ * See the comment at btrfs_chunk_alloc() for details about the chunk allocation
+ * phases.
+ */
 static int insert_block_group_item(struct btrfs_trans_handle *trans,
 				   struct btrfs_block_group *block_group)
 {
@@ -2219,15 +2226,19 @@ static int insert_block_group_item(struct btrfs_trans_handle *trans,
 	return btrfs_insert_item(trans, root, &key, &bgi, sizeof(bgi));
 }
 
+/*
+ * This function, btrfs_create_pending_block_groups(), belongs to the phase 2 of
+ * chunk allocation.
+ *
+ * See the comment at btrfs_chunk_alloc() for details about the chunk allocation
+ * phases.
+ */
 void btrfs_create_pending_block_groups(struct btrfs_trans_handle *trans)
 {
 	struct btrfs_fs_info *fs_info = trans->fs_info;
 	struct btrfs_block_group *block_group;
 	int ret = 0;
 
-	if (!trans->can_flush_pending_bgs)
-		return;
-
 	while (!list_empty(&trans->new_bgs)) {
 		int index;
 
@@ -2242,6 +2253,13 @@ void btrfs_create_pending_block_groups(struct btrfs_trans_handle *trans)
 		ret = insert_block_group_item(trans, block_group);
 		if (ret)
 			btrfs_abort_transaction(trans, ret);
+		if (!block_group->chunk_item_inserted) {
+			mutex_lock(&fs_info->chunk_mutex);
+			ret = btrfs_chunk_alloc_add_chunk_item(trans, block_group);
+			mutex_unlock(&fs_info->chunk_mutex);
+			if (ret)
+				btrfs_abort_transaction(trans, ret);
+		}
 		ret = btrfs_finish_chunk_alloc(trans, block_group->start,
 					block_group->length);
 		if (ret)
@@ -2265,8 +2283,9 @@ void btrfs_create_pending_block_groups(struct btrfs_trans_handle *trans)
 	btrfs_trans_release_chunk_metadata(trans);
 }
 
-int btrfs_make_block_group(struct btrfs_trans_handle *trans, u64 bytes_used,
-			   u64 type, u64 chunk_offset, u64 size)
+struct btrfs_block_group *btrfs_make_block_group(struct btrfs_trans_handle *trans,
+						 u64 bytes_used, u64 type,
+						 u64 chunk_offset, u64 size)
 {
 	struct btrfs_fs_info *fs_info = trans->fs_info;
 	struct btrfs_block_group *cache;
@@ -2276,7 +2295,7 @@ int btrfs_make_block_group(struct btrfs_trans_handle *trans, u64 bytes_used,
 
 	cache = btrfs_create_block_group_cache(fs_info, chunk_offset);
 	if (!cache)
-		return -ENOMEM;
+		return ERR_PTR(-ENOMEM);
 
 	cache->length = size;
 	set_free_space_tree_thresholds(cache);
@@ -2290,7 +2309,7 @@ int btrfs_make_block_group(struct btrfs_trans_handle *trans, u64 bytes_used,
 	ret = btrfs_load_block_group_zone_info(cache, true);
 	if (ret) {
 		btrfs_put_block_group(cache);
-		return ret;
+		return ERR_PTR(ret);
 	}
 
 	ret = exclude_super_stripes(cache);
@@ -2298,7 +2317,7 @@ int btrfs_make_block_group(struct btrfs_trans_handle *trans, u64 bytes_used,
 		/* We may have excluded something, so call this just in case */
 		btrfs_free_excluded_extents(cache);
 		btrfs_put_block_group(cache);
-		return ret;
+		return ERR_PTR(ret);
 	}
 
 	add_new_free_space(cache, chunk_offset, chunk_offset + size);
@@ -2325,7 +2344,7 @@ int btrfs_make_block_group(struct btrfs_trans_handle *trans, u64 bytes_used,
 	if (ret) {
 		btrfs_remove_free_space_cache(cache);
 		btrfs_put_block_group(cache);
-		return ret;
+		return ERR_PTR(ret);
 	}
 
 	/*
@@ -2344,7 +2363,7 @@ int btrfs_make_block_group(struct btrfs_trans_handle *trans, u64 bytes_used,
 	btrfs_update_delayed_refs_rsv(trans);
 
 	set_avail_alloc_bits(fs_info, type);
-	return 0;
+	return cache;
 }
 
 /*
@@ -3222,11 +3241,203 @@ int btrfs_force_chunk_alloc(struct btrfs_trans_handle *trans, u64 type)
 	return btrfs_chunk_alloc(trans, alloc_flags, CHUNK_ALLOC_FORCE);
 }
 
+static int do_chunk_alloc(struct btrfs_trans_handle *trans, u64 flags)
+{
+	struct btrfs_block_group *bg;
+	int ret;
+
+	/*
+	 * Check if we have enough space in the system space info because we
+	 * will need to update device items in the chunk btree and insert a new
+	 * chunk item in the chunk btree as well. This will allocate a new
+	 * system block group if needed.
+	 */
+	check_system_chunk(trans, flags);
+
+	bg = btrfs_alloc_chunk(trans, flags);
+	if (IS_ERR(bg)) {
+		ret = PTR_ERR(bg);
+		goto out;
+	}
+
+	/*
+	 * If this is a system chunk allocation then stop right here and do not
+	 * add the chunk item to the chunk btree. This is to prevent a deadlock
+	 * because this system chunk allocation can be triggered while COWing
+	 * some extent buffer of the chunk btree and while holding a lock on a
+	 * parent extent buffer, in which case attempting to insert the chunk
+	 * item (or update the device item) would result in a deadlock on that
+	 * parent extent buffer. In this case defer the chunk btree updates to
+	 * the second phase of chunk allocation and keep our reservation until
+	 * the second phase completes.
+	 *
+	 * This is a rare case and can only be triggered by the very few cases
+	 * we have where we need to touch the chunk btree outside chunk allocation
+	 * and chunk removal. These cases are basically adding a device, removing
+	 * a device or resizing a device.
+	 */
+	if (flags & BTRFS_BLOCK_GROUP_SYSTEM)
+		return 0;
+
+	ret = btrfs_chunk_alloc_add_chunk_item(trans, bg);
+	/*
+	 * Normally we are not expected to fail with -ENOSPC here, since we have
+	 * previously reserved space in the system space_info and allocated one
+	 * new system chunk if necessary. However there are two exceptions:
+	 *
+	 * 1) We may have enough free space in the system space_info but all the
+	 *    existing system block groups have a profile which can not be used
+	 *    for extent allocation.
+	 *
+	 *    This happens when mounting in degraded mode. For example we have a
+	 *    RAID1 filesystem with 2 devices, lose one device and mount the fs
+	 *    using the other device in degraded mode. If we then allocate a chunk,
+	 *    we may have enough free space in the existing system space_info, but
+	 *    none of the block groups can be used for extent allocation since they
+	 *    have a RAID1 profile, and because we are in degraded mode with a
+	 *    single device, we are forced to allocate a new system chunk with a
+	 *    SINGLE profile. Making check_system_chunk() iterate over all system
+	 *    block groups and check if they have a usable profile and enough space
+	 *    can be slow on very large filesystems, so we tolerate the -ENOSPC and
+	 *    try again after forcing allocation of a new system chunk. Like this
+	 *    we avoid paying the cost of that search in normal circumstances, when
+	 *    we were not mounted in degraded mode;
+	 *
+	 * 2) We had enough free space info the system space_info, and one suitable
+	 *    block group to allocate from when we called check_system_chunk()
+	 *    above. However right after we called it, the only system block group
+	 *    with enough free space got turned into RO mode by a running scrub,
+	 *    and in this case we have to allocate a new one and retry. We only
+	 *    need do this allocate and retry once, since we have a transaction
+	 *    handle and scrub uses the commit root to search for block groups.
+	 */
+	if (ret == -ENOSPC) {
+		const u64 sys_flags = btrfs_system_alloc_profile(trans->fs_info);
+		struct btrfs_block_group *sys_bg;
+
+		sys_bg = btrfs_alloc_chunk(trans, sys_flags);
+		if (IS_ERR(sys_bg)) {
+			ret = PTR_ERR(sys_bg);
+			btrfs_abort_transaction(trans, ret);
+			goto out;
+		}
+
+		ret = btrfs_chunk_alloc_add_chunk_item(trans, sys_bg);
+		if (ret) {
+			btrfs_abort_transaction(trans, ret);
+			goto out;
+		}
+
+		ret = btrfs_chunk_alloc_add_chunk_item(trans, bg);
+		if (ret) {
+			btrfs_abort_transaction(trans, ret);
+			goto out;
+		}
+	} else if (ret) {
+		btrfs_abort_transaction(trans, ret);
+		goto out;
+	}
+out:
+	btrfs_trans_release_chunk_metadata(trans);
+
+	return ret;
+}
+
 /*
- * If force is CHUNK_ALLOC_FORCE:
+ * Chunk allocation is done in 2 phases:
+ *
+ * 1) Phase 1 - through btrfs_chunk_alloc() we allocate device extents for
+ *    the chunk, the chunk mapping, create its block group and add the items
+ *    that belong in the chunk btree to it - more specifically, we need to
+ *    update device items in the chunk btree and add a new chunk item to it.
+ *
+ * 2) Phase 2 - through btrfs_create_pending_block_groups(), we add the block
+ *    group item to the extent btree and the device extent items to the devices
+ *    btree.
+ *
+ * This is done to prevent deadlocks. For example when COWing a node from the
+ * extent btree we are holding a write lock on the node's parent and if we
+ * trigger chunk allocation and attempted to insert the new block group item
+ * in the extent btree right way, we could deadlock because the path for the
+ * insertion can include that parent node. At first glance it seems impossible
+ * to trigger chunk allocation after starting a transaction since tasks should
+ * reserve enough transaction units (metadata space), however while that is true
+ * most of the time, chunk allocation may still be triggered for several reasons:
+ *
+ * 1) When reserving metadata, we check if there is enough free space in the
+ *    metadata space_info and therefore don't trigger allocation of a new chunk.
+ *    However later when the task actually tries to COW an extent buffer from
+ *    the extent btree or from the device btree for example, it is forced to
+ *    allocate a new block group (chunk) because the only one that had enough
+ *    free space was just turned to RO mode by a running scrub for example (or
+ *    device replace, block group reclaim thread, etc), so we can not use it
+ *    for allocating an extent and end up being forced to allocate a new one;
+ *
+ * 2) Because we only check that the metadata space_info has enough free bytes,
+ *    we end up not allocating a new metadata chunk in that case. However if
+ *    the filesystem was mounted in degraded mode, none of the existing block
+ *    groups might be suitable for extent allocation due to their incompatible
+ *    profile (for e.g. mounting a 2 devices filesystem, where all block groups
+ *    use a RAID1 profile, in degraded mode using a single device). In this case
+ *    when the task attempts to COW some extent buffer of the extent btree for
+ *    example, it will trigger allocation of a new metadata block group with a
+ *    suitible profile (SINGLE profile in the example of the degraded mount of
+ *    the RAID1 filesystem);
+ *
+ * 3) The task has reserved enough transaction units / metadata space, but when
+ *    it attempts to COW an extent buffer from the extent or device btree for
+ *    example, it does not find any free extent in any metadata block group,
+ *    therefore forced to try to allocate a new metadata block group.
+ *    This is because some other task allocated all available extents in the
+ *    meanwhile - this typically happens with tasks that don't reserve space
+ *    properly, either intentionally or as a bug. One example where this is
+ *    done intentionally is fsync, as it does not reserve any transaction units
+ *    and ends up allocating a variable number of metadata extents for log
+ *    tree extent buffers.
+ *
+ * We also need this 2 phases setup when adding a device to a filesystem with
+ * a seed device - we must create new metadata and system chunks without adding
+ * any of the block group items to the chunk, extent and device btrees. If we
+ * did not do it this way, we would get ENOSPC when attempting to update those
+ * btrees, since all the chunks from the seed device are read-only.
+ *
+ * Phase 1 does the updates and insertions to the chunk btree because if we had
+ * it done in phase 2 and have a thundering herd of tasks allocating chunks in
+ * parallel, we risk having too many system chunks allocated by many tasks if
+ * many tasks reach phase 1 without the previous ones completing phase 2. In the
+ * extreme case this leads to exhaustion of the system chunk array in the
+ * superblock. This is easier to trigger if using a btree node/leaf size of 64K
+ * and with RAID filesystems (so we have more device items in the chunk btree).
+ * This has happened before and commit eafa4fd0ad0607 ("btrfs: fix exhaustion of
+ * the system chunk array due to concurrent allocations") provides more details.
+ *
+ * For allocation of system chunks, we defer the updates and insertions into the
+ * chunk btree to phase 2. This is to prevent deadlocks on extent buffers because
+ * if the chunk allocation is triggered while COWing an extent buffer of the
+ * chunk btree, we are holding a lock on the parent of that extent buffer and
+ * doing the chunk btree updates and insertions can require locking that parent.
+ * This is for the very few and rare cases where we update the chunk btree that
+ * are not chunk allocation or chunk removal: adding a device, removing a device
+ * or resizing a device.
+ *
+ * The reservation of system space, done through check_system_chunk(), as well
+ * as all the updates and insertions into the chunk btree must be done while
+ * holding fs_info->chunk_mutex. This is important to guarantee that while COWing
+ * an extent buffer from the chunks btree we never trigger allocation of a new
+ * system chunk, which would result in a deadlock (trying to lock twice an
+ * extent buffer of the chunk btree, first time before triggering the chunk
+ * allocation and the second time during chunk allocation while attempting to
+ * update the chunks btree). The system chunk array is also updated while holding
+ * that mutex. The same logic applies to removing chunks - we must reserve system
+ * space, update the chunk btree and the system chunk array in the superblock
+ * while holding fs_info->chunk_mutex.
+ *
+ * This function, btrfs_chunk_alloc(), belongs to phase 1.
+ *
+ * If @force is CHUNK_ALLOC_FORCE:
  *    - return 1 if it successfully allocates a chunk,
  *    - return errors including -ENOSPC otherwise.
- * If force is NOT CHUNK_ALLOC_FORCE:
+ * If @force is NOT CHUNK_ALLOC_FORCE:
  *    - return 0 if it doesn't need to allocate a new chunk,
  *    - return 1 if it successfully allocates a chunk,
  *    - return errors including -ENOSPC otherwise.
@@ -3243,6 +3454,13 @@ int btrfs_chunk_alloc(struct btrfs_trans_handle *trans, u64 flags,
 	/* Don't re-enter if we're already allocating a chunk */
 	if (trans->allocating_chunk)
 		return -ENOSPC;
+	/*
+	 * If we are removing a chunk, don't re-enter or we would deadlock.
+	 * System space reservation and system chunk allocation is done by the
+	 * chunk remove operation (btrfs_remove_chunk()).
+	 */
+	if (trans->removing_chunk)
+		return -ENOSPC;
 
 	space_info = btrfs_find_space_info(fs_info, flags);
 	ASSERT(space_info);
@@ -3306,13 +3524,7 @@ int btrfs_chunk_alloc(struct btrfs_trans_handle *trans, u64 flags,
 			force_metadata_allocation(fs_info);
 	}
 
-	/*
-	 * Check if we have enough space in SYSTEM chunk because we may need
-	 * to update devices.
-	 */
-	check_system_chunk(trans, flags);
-
-	ret = btrfs_alloc_chunk(trans, flags);
+	ret = do_chunk_alloc(trans, flags);
 	trans->allocating_chunk = false;
 
 	spin_lock(&space_info->lock);
@@ -3331,22 +3543,6 @@ int btrfs_chunk_alloc(struct btrfs_trans_handle *trans, u64 flags,
 	space_info->chunk_alloc = 0;
 	spin_unlock(&space_info->lock);
 	mutex_unlock(&fs_info->chunk_mutex);
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
 
 	return ret;
 }
@@ -3399,14 +3595,31 @@ void check_system_chunk(struct btrfs_trans_handle *trans, u64 type)
 
 	if (left < thresh) {
 		u64 flags = btrfs_system_alloc_profile(fs_info);
+		struct btrfs_block_group *bg;
 
 		/*
 		 * Ignore failure to create system chunk. We might end up not
 		 * needing it, as we might not need to COW all nodes/leafs from
 		 * the paths we visit in the chunk tree (they were already COWed
 		 * or created in the current transaction for example).
+		 *
+		 * Also, if our caller is allocating a system chunk, do not
+		 * attempt to insert the chunk item in the chunk btree, as we
+		 * could deadlock on an extent buffer since our caller may be
+		 * COWing an extent buffer from the chunk btree.
 		 */
-		ret = btrfs_alloc_chunk(trans, flags);
+		bg = btrfs_alloc_chunk(trans, flags);
+		if (IS_ERR(bg)) {
+			ret = PTR_ERR(bg);
+		} else if (!(type & BTRFS_BLOCK_GROUP_SYSTEM)) {
+			/*
+			 * If we fail to add the chunk item here, we end up
+			 * trying again at phase 2 of chunk allocation, at
+			 * btrfs_create_pending_block_groups(). So ignore
+			 * any error here.
+			 */
+			btrfs_chunk_alloc_add_chunk_item(trans, bg);
+		}
 	}
 
 	if (!ret) {
diff --git a/fs/btrfs/block-group.h b/fs/btrfs/block-group.h
index 7b927425dc71..c72a71efcb18 100644
--- a/fs/btrfs/block-group.h
+++ b/fs/btrfs/block-group.h
@@ -97,6 +97,7 @@ struct btrfs_block_group {
 	unsigned int removed:1;
 	unsigned int to_copy:1;
 	unsigned int relocating_repair:1;
+	unsigned int chunk_item_inserted:1;
 
 	int disk_cache_state;
 
@@ -268,8 +269,9 @@ void btrfs_reclaim_bgs_work(struct work_struct *work);
 void btrfs_reclaim_bgs(struct btrfs_fs_info *fs_info);
 void btrfs_mark_bg_to_reclaim(struct btrfs_block_group *bg);
 int btrfs_read_block_groups(struct btrfs_fs_info *info);
-int btrfs_make_block_group(struct btrfs_trans_handle *trans, u64 bytes_used,
-			   u64 type, u64 chunk_offset, u64 size);
+struct btrfs_block_group *btrfs_make_block_group(struct btrfs_trans_handle *trans,
+						 u64 bytes_used, u64 type,
+						 u64 chunk_offset, u64 size);
 void btrfs_create_pending_block_groups(struct btrfs_trans_handle *trans);
 int btrfs_inc_block_group_ro(struct btrfs_block_group *cache,
 			     bool do_chunk_alloc);
diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index 4bc3ca2cbd7d..c5c08c87e130 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -364,49 +364,6 @@ static noinline int update_ref_for_cow(struct btrfs_trans_handle *trans,
 	return 0;
 }
 
-static struct extent_buffer *alloc_tree_block_no_bg_flush(
-					  struct btrfs_trans_handle *trans,
-					  struct btrfs_root *root,
-					  u64 parent_start,
-					  const struct btrfs_disk_key *disk_key,
-					  int level,
-					  u64 hint,
-					  u64 empty_size,
-					  enum btrfs_lock_nesting nest)
-{
-	struct btrfs_fs_info *fs_info = root->fs_info;
-	struct extent_buffer *ret;
-
-	/*
-	 * If we are COWing a node/leaf from the extent, chunk, device or free
-	 * space trees, make sure that we do not finish block group creation of
-	 * pending block groups. We do this to avoid a deadlock.
-	 * COWing can result in allocation of a new chunk, and flushing pending
-	 * block groups (btrfs_create_pending_block_groups()) can be triggered
-	 * when finishing allocation of a new chunk. Creation of a pending block
-	 * group modifies the extent, chunk, device and free space trees,
-	 * therefore we could deadlock with ourselves since we are holding a
-	 * lock on an extent buffer that btrfs_create_pending_block_groups() may
-	 * try to COW later.
-	 * For similar reasons, we also need to delay flushing pending block
-	 * groups when splitting a leaf or node, from one of those trees, since
-	 * we are holding a write lock on it and its parent or when inserting a
-	 * new root node for one of those trees.
-	 */
-	if (root == fs_info->extent_root ||
-	    root == fs_info->chunk_root ||
-	    root == fs_info->dev_root ||
-	    root == fs_info->free_space_root)
-		trans->can_flush_pending_bgs = false;
-
-	ret = btrfs_alloc_tree_block(trans, root, parent_start,
-				     root->root_key.objectid, disk_key, level,
-				     hint, empty_size, nest);
-	trans->can_flush_pending_bgs = true;
-
-	return ret;
-}
-
 /*
  * does the dirty work in cow of a single block.  The parent block (if
  * supplied) is updated to point to the new cow copy.  The new buffer is marked
@@ -455,8 +412,9 @@ static noinline int __btrfs_cow_block(struct btrfs_trans_handle *trans,
 	if ((root->root_key.objectid == BTRFS_TREE_RELOC_OBJECTID) && parent)
 		parent_start = parent->start;
 
-	cow = alloc_tree_block_no_bg_flush(trans, root, parent_start, &disk_key,
-					   level, search_start, empty_size, nest);
+	cow = btrfs_alloc_tree_block(trans, root, parent_start,
+				     root->root_key.objectid, &disk_key, level,
+				     search_start, empty_size, nest);
 	if (IS_ERR(cow))
 		return PTR_ERR(cow);
 
@@ -2458,9 +2416,9 @@ static noinline int insert_new_root(struct btrfs_trans_handle *trans,
 	else
 		btrfs_node_key(lower, &lower_key, 0);
 
-	c = alloc_tree_block_no_bg_flush(trans, root, 0, &lower_key, level,
-					 root->node->start, 0,
-					 BTRFS_NESTING_NEW_ROOT);
+	c = btrfs_alloc_tree_block(trans, root, 0, root->root_key.objectid,
+				   &lower_key, level, root->node->start, 0,
+				   BTRFS_NESTING_NEW_ROOT);
 	if (IS_ERR(c))
 		return PTR_ERR(c);
 
@@ -2589,8 +2547,9 @@ static noinline int split_node(struct btrfs_trans_handle *trans,
 	mid = (c_nritems + 1) / 2;
 	btrfs_node_key(c, &disk_key, mid);
 
-	split = alloc_tree_block_no_bg_flush(trans, root, 0, &disk_key, level,
-					     c->start, 0, BTRFS_NESTING_SPLIT);
+	split = btrfs_alloc_tree_block(trans, root, 0, root->root_key.objectid,
+				       &disk_key, level, c->start, 0,
+				       BTRFS_NESTING_SPLIT);
 	if (IS_ERR(split))
 		return PTR_ERR(split);
 
@@ -3381,10 +3340,10 @@ static noinline int split_leaf(struct btrfs_trans_handle *trans,
 	 * BTRFS_NESTING_SPLIT_THE_SPLITTENING if we need to, but for now just
 	 * use BTRFS_NESTING_NEW_ROOT.
 	 */
-	right = alloc_tree_block_no_bg_flush(trans, root, 0, &disk_key, 0,
-					     l->start, 0, num_doubles ?
-					     BTRFS_NESTING_NEW_ROOT :
-					     BTRFS_NESTING_SPLIT);
+	right = btrfs_alloc_tree_block(trans, root, 0, root->root_key.objectid,
+				       &disk_key, 0, l->start, 0,
+				       num_doubles ? BTRFS_NESTING_NEW_ROOT :
+				       BTRFS_NESTING_SPLIT);
 	if (IS_ERR(right))
 		return PTR_ERR(right);
 
diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index 443c348bc6f3..14b9fdc8aaa9 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -254,8 +254,11 @@ static inline int extwriter_counter_read(struct btrfs_transaction *trans)
 }
 
 /*
- * To be called after all the new block groups attached to the transaction
- * handle have been created (btrfs_create_pending_block_groups()).
+ * To be called after doing the chunk btree updates right after allocating a new
+ * chunk (after btrfs_chunk_alloc_add_chunk_item() is called), when removing a
+ * chunk after all chunk btree updates and after finishing the second phase of
+ * chunk allocation (btrfs_create_pending_block_groups()) in case some block
+ * group had its chunk item insertion delayed to the second phase.
  */
 void btrfs_trans_release_chunk_metadata(struct btrfs_trans_handle *trans)
 {
@@ -264,8 +267,6 @@ void btrfs_trans_release_chunk_metadata(struct btrfs_trans_handle *trans)
 	if (!trans->chunk_bytes_reserved)
 		return;
 
-	WARN_ON_ONCE(!list_empty(&trans->new_bgs));
-
 	btrfs_block_rsv_release(fs_info, &fs_info->chunk_block_rsv,
 				trans->chunk_bytes_reserved, NULL);
 	trans->chunk_bytes_reserved = 0;
@@ -696,7 +697,6 @@ start_transaction(struct btrfs_root *root, unsigned int num_items,
 	h->fs_info = root->fs_info;
 
 	h->type = type;
-	h->can_flush_pending_bgs = true;
 	INIT_LIST_HEAD(&h->new_bgs);
 
 	smp_mb();
diff --git a/fs/btrfs/transaction.h b/fs/btrfs/transaction.h
index a18d67796b54..ba45065f9451 100644
--- a/fs/btrfs/transaction.h
+++ b/fs/btrfs/transaction.h
@@ -132,7 +132,7 @@ struct btrfs_trans_handle {
 	short aborted;
 	bool adding_csums;
 	bool allocating_chunk;
-	bool can_flush_pending_bgs;
+	bool removing_chunk;
 	bool reloc_reserved;
 	bool in_fsync;
 	struct btrfs_root *root;
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 782e16795bc4..ddd93c632d79 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -1745,19 +1745,14 @@ static int btrfs_free_dev_extent(struct btrfs_trans_handle *trans,
 		extent = btrfs_item_ptr(leaf, path->slots[0],
 					struct btrfs_dev_extent);
 	} else {
-		btrfs_handle_fs_error(fs_info, ret, "Slot search failed");
 		goto out;
 	}
 
 	*dev_extent_len = btrfs_dev_extent_length(leaf, extent);
 
 	ret = btrfs_del_item(trans, root, path);
-	if (ret) {
-		btrfs_handle_fs_error(fs_info, ret,
-				      "Failed to remove dev extent item");
-	} else {
+	if (ret == 0)
 		set_bit(BTRFS_TRANS_HAVE_FREE_BGS, &trans->transaction->flags);
-	}
 out:
 	btrfs_free_path(path);
 	return ret;
@@ -2942,7 +2937,7 @@ static int btrfs_del_sys_chunk(struct btrfs_fs_info *fs_info, u64 chunk_offset)
 	u32 cur;
 	struct btrfs_key key;
 
-	mutex_lock(&fs_info->chunk_mutex);
+	lockdep_assert_held(&fs_info->chunk_mutex);
 	array_size = btrfs_super_sys_array_size(super_copy);
 
 	ptr = super_copy->sys_chunk_array;
@@ -2972,7 +2967,6 @@ static int btrfs_del_sys_chunk(struct btrfs_fs_info *fs_info, u64 chunk_offset)
 			cur += len;
 		}
 	}
-	mutex_unlock(&fs_info->chunk_mutex);
 	return ret;
 }
 
@@ -3012,6 +3006,29 @@ struct extent_map *btrfs_get_chunk_map(struct btrfs_fs_info *fs_info,
 	return em;
 }
 
+static int remove_chunk_item(struct btrfs_trans_handle *trans,
+			     struct map_lookup *map, u64 chunk_offset)
+{
+	int i;
+
+	/*
+	 * Removing chunk items and updating the device items in the chunks btree
+	 * requires holding the chunk_mutex.
+	 * See the comment at btrfs_chunk_alloc() for the details.
+	 */
+	lockdep_assert_held(&trans->fs_info->chunk_mutex);
+
+	for (i = 0; i < map->num_stripes; i++) {
+		int ret;
+
+		ret = btrfs_update_device(trans, map->stripes[i].dev);
+		if (ret)
+			return ret;
+	}
+
+	return btrfs_free_chunk(trans, chunk_offset);
+}
+
 int btrfs_remove_chunk(struct btrfs_trans_handle *trans, u64 chunk_offset)
 {
 	struct btrfs_fs_info *fs_info = trans->fs_info;
@@ -3032,14 +3049,16 @@ int btrfs_remove_chunk(struct btrfs_trans_handle *trans, u64 chunk_offset)
 		return PTR_ERR(em);
 	}
 	map = em->map_lookup;
-	mutex_lock(&fs_info->chunk_mutex);
-	check_system_chunk(trans, map->type);
-	mutex_unlock(&fs_info->chunk_mutex);
 
 	/*
-	 * Take the device list mutex to prevent races with the final phase of
-	 * a device replace operation that replaces the device object associated
-	 * with map stripes (dev-replace.c:btrfs_dev_replace_finishing()).
+	 * First delete the device extent items from the devices btree.
+	 * We take the device_list_mutex to avoid racing with the finishing phase
+	 * of a device replace operation. See the comment below before acquiring
+	 * fs_info->chunk_mutex. Note that here we do not acquire the chunk_mutex
+	 * because that can result in a deadlock when deleting the device extent
+	 * items from the devices btree - COWing an extent buffer from the btree
+	 * may result in allocating a new metadata chunk, which would attempt to
+	 * lock again fs_info->chunk_mutex.
 	 */
 	mutex_lock(&fs_devices->device_list_mutex);
 	for (i = 0; i < map->num_stripes; i++) {
@@ -3061,18 +3080,73 @@ int btrfs_remove_chunk(struct btrfs_trans_handle *trans, u64 chunk_offset)
 			btrfs_clear_space_info_full(fs_info);
 			mutex_unlock(&fs_info->chunk_mutex);
 		}
+	}
+	mutex_unlock(&fs_devices->device_list_mutex);
 
-		ret = btrfs_update_device(trans, device);
+	/*
+	 * We acquire fs_info->chunk_mutex for 2 reasons:
+	 *
+	 * 1) Just like with the first phase of the chunk allocation, we must
+	 *    reserve system space, do all chunk btree updates and deletions, and
+	 *    update the system chunk array in the superblock while holding this
+	 *    mutex. This is for similar reasons as explained on the comment at
+	 *    the top of btrfs_chunk_alloc();
+	 *
+	 * 2) Prevent races with the final phase of a device replace operation
+	 *    that replaces the device object associated with the map's stripes,
+	 *    because the device object's id can change at any time during that
+	 *    final phase of the device replace operation
+	 *    (dev-replace.c:btrfs_dev_replace_finishing()), so we could grab the
+	 *    replaced device and then see it with an ID of
+	 *    BTRFS_DEV_REPLACE_DEVID, which would cause a failure when updating
+	 *    the device item, which does not exists on the chunk btree.
+	 *    The finishing phase of device replace acquires both the
+	 *    device_list_mutex and the chunk_mutex, in that order, so we are
+	 *    safe by just acquiring the chunk_mutex.
+	 */
+	trans->removing_chunk = true;
+	mutex_lock(&fs_info->chunk_mutex);
+
+	check_system_chunk(trans, map->type);
+
+	ret = remove_chunk_item(trans, map, chunk_offset);
+	/*
+	 * Normally we should not get -ENOSPC since we reserved space before
+	 * through the call to check_system_chunk().
+	 *
+	 * Despite our system space_info having enough free space, we may not
+	 * be able to allocate extents from its block groups, because all have
+	 * an incompatible profile, which will force us to allocate a new system
+	 * block group with the right profile, or right after we called
+	 * check_system_space() above, a scrub turned the only system block group
+	 * with enough free space into RO mode.
+	 * This is explained with more detail at do_chunk_alloc().
+	 *
+	 * So if we get -ENOSPC, allocate a new system chunk and retry once.
+	 */
+	if (ret == -ENOSPC) {
+		const u64 sys_flags = btrfs_system_alloc_profile(fs_info);
+		struct btrfs_block_group *sys_bg;
+
+		sys_bg = btrfs_alloc_chunk(trans, sys_flags);
+		if (IS_ERR(sys_bg)) {
+			ret = PTR_ERR(sys_bg);
+			btrfs_abort_transaction(trans, ret);
+			goto out;
+		}
+
+		ret = btrfs_chunk_alloc_add_chunk_item(trans, sys_bg);
 		if (ret) {
-			mutex_unlock(&fs_devices->device_list_mutex);
 			btrfs_abort_transaction(trans, ret);
 			goto out;
 		}
-	}
-	mutex_unlock(&fs_devices->device_list_mutex);
 
-	ret = btrfs_free_chunk(trans, chunk_offset);
-	if (ret) {
+		ret = remove_chunk_item(trans, map, chunk_offset);
+		if (ret) {
+			btrfs_abort_transaction(trans, ret);
+			goto out;
+		}
+	} else if (ret) {
 		btrfs_abort_transaction(trans, ret);
 		goto out;
 	}
@@ -3087,6 +3161,15 @@ int btrfs_remove_chunk(struct btrfs_trans_handle *trans, u64 chunk_offset)
 		}
 	}
 
+	mutex_unlock(&fs_info->chunk_mutex);
+	trans->removing_chunk = false;
+
+	/*
+	 * We are done with chunk btree upates and deletions, so release the
+	 * system space we previously reserved (with check_system_chunk()).
+	 */
+	btrfs_trans_release_chunk_metadata(trans);
+
 	ret = btrfs_remove_block_group(trans, chunk_offset, em);
 	if (ret) {
 		btrfs_abort_transaction(trans, ret);
@@ -3094,6 +3177,10 @@ int btrfs_remove_chunk(struct btrfs_trans_handle *trans, u64 chunk_offset)
 	}
 
 out:
+	if (trans->removing_chunk) {
+		mutex_unlock(&fs_info->chunk_mutex);
+		trans->removing_chunk = false;
+	}
 	/* once for us */
 	free_extent_map(em);
 	return ret;
@@ -4860,13 +4947,12 @@ static int btrfs_add_system_chunk(struct btrfs_fs_info *fs_info,
 	u32 array_size;
 	u8 *ptr;
 
-	mutex_lock(&fs_info->chunk_mutex);
+	lockdep_assert_held(&fs_info->chunk_mutex);
+
 	array_size = btrfs_super_sys_array_size(super_copy);
 	if (array_size + item_size + sizeof(disk_key)
-			> BTRFS_SYSTEM_CHUNK_ARRAY_SIZE) {
-		mutex_unlock(&fs_info->chunk_mutex);
+			> BTRFS_SYSTEM_CHUNK_ARRAY_SIZE)
 		return -EFBIG;
-	}
 
 	ptr = super_copy->sys_chunk_array + array_size;
 	btrfs_cpu_key_to_disk(&disk_key, key);
@@ -4875,7 +4961,6 @@ static int btrfs_add_system_chunk(struct btrfs_fs_info *fs_info,
 	memcpy(ptr, chunk, item_size);
 	item_size += sizeof(disk_key);
 	btrfs_set_super_sys_array_size(super_copy, array_size + item_size);
-	mutex_unlock(&fs_info->chunk_mutex);
 
 	return 0;
 }
@@ -5225,13 +5310,14 @@ static int decide_stripe_size(struct btrfs_fs_devices *fs_devices,
 	}
 }
 
-static int create_chunk(struct btrfs_trans_handle *trans,
+static struct btrfs_block_group *create_chunk(struct btrfs_trans_handle *trans,
 			struct alloc_chunk_ctl *ctl,
 			struct btrfs_device_info *devices_info)
 {
 	struct btrfs_fs_info *info = trans->fs_info;
 	struct map_lookup *map = NULL;
 	struct extent_map_tree *em_tree;
+	struct btrfs_block_group *block_group;
 	struct extent_map *em;
 	u64 start = ctl->start;
 	u64 type = ctl->type;
@@ -5241,7 +5327,7 @@ static int create_chunk(struct btrfs_trans_handle *trans,
 
 	map = kmalloc(map_lookup_size(ctl->num_stripes), GFP_NOFS);
 	if (!map)
-		return -ENOMEM;
+		return ERR_PTR(-ENOMEM);
 	map->num_stripes = ctl->num_stripes;
 
 	for (i = 0; i < ctl->ndevs; ++i) {
@@ -5263,7 +5349,7 @@ static int create_chunk(struct btrfs_trans_handle *trans,
 	em = alloc_extent_map();
 	if (!em) {
 		kfree(map);
-		return -ENOMEM;
+		return ERR_PTR(-ENOMEM);
 	}
 	set_bit(EXTENT_FLAG_FS_MAPPING, &em->flags);
 	em->map_lookup = map;
@@ -5279,12 +5365,12 @@ static int create_chunk(struct btrfs_trans_handle *trans,
 	if (ret) {
 		write_unlock(&em_tree->lock);
 		free_extent_map(em);
-		return ret;
+		return ERR_PTR(ret);
 	}
 	write_unlock(&em_tree->lock);
 
-	ret = btrfs_make_block_group(trans, 0, type, start, ctl->chunk_size);
-	if (ret)
+	block_group = btrfs_make_block_group(trans, 0, type, start, ctl->chunk_size);
+	if (IS_ERR(block_group))
 		goto error_del_extent;
 
 	for (i = 0; i < map->num_stripes; i++) {
@@ -5304,7 +5390,7 @@ static int create_chunk(struct btrfs_trans_handle *trans,
 	check_raid56_incompat_flag(info, type);
 	check_raid1c34_incompat_flag(info, type);
 
-	return 0;
+	return block_group;
 
 error_del_extent:
 	write_lock(&em_tree->lock);
@@ -5316,34 +5402,36 @@ static int create_chunk(struct btrfs_trans_handle *trans,
 	/* One for the tree reference */
 	free_extent_map(em);
 
-	return ret;
+	return block_group;
 }
 
-int btrfs_alloc_chunk(struct btrfs_trans_handle *trans, u64 type)
+struct btrfs_block_group *btrfs_alloc_chunk(struct btrfs_trans_handle *trans,
+					    u64 type)
 {
 	struct btrfs_fs_info *info = trans->fs_info;
 	struct btrfs_fs_devices *fs_devices = info->fs_devices;
 	struct btrfs_device_info *devices_info = NULL;
 	struct alloc_chunk_ctl ctl;
+	struct btrfs_block_group *block_group;
 	int ret;
 
 	lockdep_assert_held(&info->chunk_mutex);
 
 	if (!alloc_profile_is_valid(type, 0)) {
 		ASSERT(0);
-		return -EINVAL;
+		return ERR_PTR(-EINVAL);
 	}
 
 	if (list_empty(&fs_devices->alloc_list)) {
 		if (btrfs_test_opt(info, ENOSPC_DEBUG))
 			btrfs_debug(info, "%s: no writable device", __func__);
-		return -ENOSPC;
+		return ERR_PTR(-ENOSPC);
 	}
 
 	if (!(type & BTRFS_BLOCK_GROUP_TYPE_MASK)) {
 		btrfs_err(info, "invalid chunk type 0x%llx requested", type);
 		ASSERT(0);
-		return -EINVAL;
+		return ERR_PTR(-EINVAL);
 	}
 
 	ctl.start = find_next_chunk(info);
@@ -5353,46 +5441,43 @@ int btrfs_alloc_chunk(struct btrfs_trans_handle *trans, u64 type)
 	devices_info = kcalloc(fs_devices->rw_devices, sizeof(*devices_info),
 			       GFP_NOFS);
 	if (!devices_info)
-		return -ENOMEM;
+		return ERR_PTR(-ENOMEM);
 
 	ret = gather_device_info(fs_devices, &ctl, devices_info);
-	if (ret < 0)
+	if (ret < 0) {
+		block_group = ERR_PTR(ret);
 		goto out;
+	}
 
 	ret = decide_stripe_size(fs_devices, &ctl, devices_info);
-	if (ret < 0)
+	if (ret < 0) {
+		block_group = ERR_PTR(ret);
 		goto out;
+	}
 
-	ret = create_chunk(trans, &ctl, devices_info);
+	block_group = create_chunk(trans, &ctl, devices_info);
 
 out:
 	kfree(devices_info);
-	return ret;
+	return block_group;
 }
 
 /*
- * Chunk allocation falls into two parts. The first part does work
- * that makes the new allocated chunk usable, but does not do any operation
- * that modifies the chunk tree. The second part does the work that
- * requires modifying the chunk tree. This division is important for the
- * bootstrap process of adding storage to a seed btrfs.
+ * This function, btrfs_finish_chunk_alloc(), belongs to phase 2.
+ *
+ * See the comment at btrfs_chunk_alloc() for details about the chunk allocation
+ * phases.
  */
 int btrfs_finish_chunk_alloc(struct btrfs_trans_handle *trans,
 			     u64 chunk_offset, u64 chunk_size)
 {
 	struct btrfs_fs_info *fs_info = trans->fs_info;
-	struct btrfs_root *extent_root = fs_info->extent_root;
-	struct btrfs_root *chunk_root = fs_info->chunk_root;
-	struct btrfs_key key;
 	struct btrfs_device *device;
-	struct btrfs_chunk *chunk;
-	struct btrfs_stripe *stripe;
 	struct extent_map *em;
 	struct map_lookup *map;
-	size_t item_size;
 	u64 dev_offset;
 	u64 stripe_size;
-	int i = 0;
+	int i;
 	int ret = 0;
 
 	em = btrfs_get_chunk_map(fs_info, chunk_offset, chunk_size);
@@ -5400,53 +5485,117 @@ int btrfs_finish_chunk_alloc(struct btrfs_trans_handle *trans,
 		return PTR_ERR(em);
 
 	map = em->map_lookup;
-	item_size = btrfs_chunk_item_size(map->num_stripes);
 	stripe_size = em->orig_block_len;
 
-	chunk = kzalloc(item_size, GFP_NOFS);
-	if (!chunk) {
-		ret = -ENOMEM;
-		goto out;
-	}
-
 	/*
 	 * Take the device list mutex to prevent races with the final phase of
 	 * a device replace operation that replaces the device object associated
 	 * with the map's stripes, because the device object's id can change
 	 * at any time during that final phase of the device replace operation
-	 * (dev-replace.c:btrfs_dev_replace_finishing()).
+	 * (dev-replace.c:btrfs_dev_replace_finishing()), so we could grab the
+	 * replaced device and then see it with an ID of BTRFS_DEV_REPLACE_DEVID,
+	 * resulting in persisting a device extent item with such ID.
 	 */
 	mutex_lock(&fs_info->fs_devices->device_list_mutex);
 	for (i = 0; i < map->num_stripes; i++) {
 		device = map->stripes[i].dev;
 		dev_offset = map->stripes[i].physical;
 
-		ret = btrfs_update_device(trans, device);
-		if (ret)
-			break;
 		ret = btrfs_alloc_dev_extent(trans, device, chunk_offset,
 					     dev_offset, stripe_size);
 		if (ret)
 			break;
 	}
-	if (ret) {
-		mutex_unlock(&fs_info->fs_devices->device_list_mutex);
+	mutex_unlock(&fs_info->fs_devices->device_list_mutex);
+
+	free_extent_map(em);
+	return ret;
+}
+
+/*
+ * This function, btrfs_chunk_alloc_add_chunk_item(), typically belongs to the
+ * phase 1 of chunk allocation. It belongs to phase 2 only when allocating system
+ * chunks.
+ *
+ * See the comment at btrfs_chunk_alloc() for details about the chunk allocation
+ * phases.
+ */
+int btrfs_chunk_alloc_add_chunk_item(struct btrfs_trans_handle *trans,
+				     struct btrfs_block_group *bg)
+{
+	struct btrfs_fs_info *fs_info = trans->fs_info;
+	struct btrfs_root *extent_root = fs_info->extent_root;
+	struct btrfs_root *chunk_root = fs_info->chunk_root;
+	struct btrfs_key key;
+	struct btrfs_chunk *chunk;
+	struct btrfs_stripe *stripe;
+	struct extent_map *em;
+	struct map_lookup *map;
+	size_t item_size;
+	int i;
+	int ret;
+
+	/*
+	 * We take the chunk_mutex for 2 reasons:
+	 *
+	 * 1) Updates and insertions in the chunk btree must be done while holding
+	 *    the chunk_mutex, as well as updating the system chunk array in the
+	 *    superblock. See the comment on top of btrfs_chunk_alloc() for the
+	 *    details;
+	 *
+	 * 2) To prevent races with the final phase of a device replace operation
+	 *    that replaces the device object associated with the map's stripes,
+	 *    because the device object's id can change at any time during that
+	 *    final phase of the device replace operation
+	 *    (dev-replace.c:btrfs_dev_replace_finishing()), so we could grab the
+	 *    replaced device and then see it with an ID of BTRFS_DEV_REPLACE_DEVID,
+	 *    which would cause a failure when updating the device item, which does
+	 *    not exists, or persisting a stripe of the chunk item with such ID.
+	 *    Here we can't use the device_list_mutex because our caller already
+	 *    has locked the chunk_mutex, and the final phase of device replace
+	 *    acquires both mutexes - first the device_list_mutex and then the
+	 *    chunk_mutex. Using any of those two mutexes protects us from a
+	 *    concurrent device replace.
+	 */
+	lockdep_assert_held(&fs_info->chunk_mutex);
+
+	em = btrfs_get_chunk_map(fs_info, bg->start, bg->length);
+	if (IS_ERR(em)) {
+		ret = PTR_ERR(em);
+		btrfs_abort_transaction(trans, ret);
+		return ret;
+	}
+
+	map = em->map_lookup;
+	item_size = btrfs_chunk_item_size(map->num_stripes);
+
+	chunk = kzalloc(item_size, GFP_NOFS);
+	if (!chunk) {
+		ret = -ENOMEM;
+		btrfs_abort_transaction(trans, ret);
 		goto out;
 	}
 
+	for (i = 0; i < map->num_stripes; i++) {
+		struct btrfs_device *device = map->stripes[i].dev;
+
+		ret = btrfs_update_device(trans, device);
+		if (ret)
+			goto out;
+	}
+
 	stripe = &chunk->stripe;
 	for (i = 0; i < map->num_stripes; i++) {
-		device = map->stripes[i].dev;
-		dev_offset = map->stripes[i].physical;
+		struct btrfs_device *device = map->stripes[i].dev;
+		const u64 dev_offset = map->stripes[i].physical;
 
 		btrfs_set_stack_stripe_devid(stripe, device->devid);
 		btrfs_set_stack_stripe_offset(stripe, dev_offset);
 		memcpy(stripe->dev_uuid, device->uuid, BTRFS_UUID_SIZE);
 		stripe++;
 	}
-	mutex_unlock(&fs_info->fs_devices->device_list_mutex);
 
-	btrfs_set_stack_chunk_length(chunk, chunk_size);
+	btrfs_set_stack_chunk_length(chunk, bg->length);
 	btrfs_set_stack_chunk_owner(chunk, extent_root->root_key.objectid);
 	btrfs_set_stack_chunk_stripe_len(chunk, map->stripe_len);
 	btrfs_set_stack_chunk_type(chunk, map->type);
@@ -5458,15 +5607,18 @@ int btrfs_finish_chunk_alloc(struct btrfs_trans_handle *trans,
 
 	key.objectid = BTRFS_FIRST_CHUNK_TREE_OBJECTID;
 	key.type = BTRFS_CHUNK_ITEM_KEY;
-	key.offset = chunk_offset;
+	key.offset = bg->start;
 
 	ret = btrfs_insert_item(trans, chunk_root, &key, chunk, item_size);
-	if (ret == 0 && map->type & BTRFS_BLOCK_GROUP_SYSTEM) {
-		/*
-		 * TODO: Cleanup of inserted chunk root in case of
-		 * failure.
-		 */
+	if (ret)
+		goto out;
+
+	bg->chunk_item_inserted = 1;
+
+	if (map->type & BTRFS_BLOCK_GROUP_SYSTEM) {
 		ret = btrfs_add_system_chunk(fs_info, &key, chunk, item_size);
+		if (ret)
+			goto out;
 	}
 
 out:
@@ -5479,16 +5631,41 @@ static noinline int init_first_rw_device(struct btrfs_trans_handle *trans)
 {
 	struct btrfs_fs_info *fs_info = trans->fs_info;
 	u64 alloc_profile;
-	int ret;
+	struct btrfs_block_group *meta_bg;
+	struct btrfs_block_group *sys_bg;
+
+	/*
+	 * When adding a new device for sprouting, the seed device is read-only
+	 * so we must first allocate a metadata and a system chunk. But before
+	 * adding the block group items to the extent, device and chunk btrees,
+	 * we must first:
+	 *
+	 * 1) Create both chunks without doing any changes to the btrees, as
+	 *    otherwise we would get -ENOSPC since the block groups from the
+	 *    seed device are read-only;
+	 *
+	 * 2) Add the device item for the new sprout device - finishing the setup
+	 *    of a new block group requires updating the device item in the chunk
+	 *    btree, so it must exist when we attempt to do it. The previous step
+	 *    ensures this does not fail with -ENOSPC.
+	 *
+	 * After that we can add the block group items to their btrees:
+	 * update existing device item in the chunk btree, add a new block group
+	 * item to the extent btree, add a new chunk item to the chunk btree and
+	 * finally add the new device extent items to the devices btree.
+	 */
 
 	alloc_profile = btrfs_metadata_alloc_profile(fs_info);
-	ret = btrfs_alloc_chunk(trans, alloc_profile);
-	if (ret)
-		return ret;
+	meta_bg = btrfs_alloc_chunk(trans, alloc_profile);
+	if (IS_ERR(meta_bg))
+		return PTR_ERR(meta_bg);
 
 	alloc_profile = btrfs_system_alloc_profile(fs_info);
-	ret = btrfs_alloc_chunk(trans, alloc_profile);
-	return ret;
+	sys_bg = btrfs_alloc_chunk(trans, alloc_profile);
+	if (IS_ERR(sys_bg))
+		return PTR_ERR(sys_bg);
+
+	return 0;
 }
 
 static inline int btrfs_chunk_max_errors(struct map_lookup *map)
@@ -7415,10 +7592,18 @@ int btrfs_read_chunk_tree(struct btrfs_fs_info *fs_info)
 			total_dev++;
 		} else if (found_key.type == BTRFS_CHUNK_ITEM_KEY) {
 			struct btrfs_chunk *chunk;
+
+			/*
+			 * We are only called at mount time, so no need to take
+			 * fs_info->chunk_mutex. Plus, to avoid lockdep warnings,
+			 * we always lock first fs_info->chunk_mutex before
+			 * acquiring any locks on the chunk tree. This is a
+			 * requirement for chunk allocation, see the comment on
+			 * top of btrfs_chunk_alloc() for details.
+			 */
+			ASSERT(!test_bit(BTRFS_FS_OPEN, &fs_info->flags));
 			chunk = btrfs_item_ptr(leaf, slot, struct btrfs_chunk);
-			mutex_lock(&fs_info->chunk_mutex);
 			ret = read_one_chunk(&found_key, leaf, chunk);
-			mutex_unlock(&fs_info->chunk_mutex);
 			if (ret)
 				goto error;
 		}
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index c7fc7caf575c..55a8ba244716 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -450,7 +450,8 @@ int btrfs_get_io_geometry(struct btrfs_fs_info *fs_info, struct extent_map *map,
 			  struct btrfs_io_geometry *io_geom);
 int btrfs_read_sys_array(struct btrfs_fs_info *fs_info);
 int btrfs_read_chunk_tree(struct btrfs_fs_info *fs_info);
-int btrfs_alloc_chunk(struct btrfs_trans_handle *trans, u64 type);
+struct btrfs_block_group *btrfs_alloc_chunk(struct btrfs_trans_handle *trans,
+					    u64 type);
 void btrfs_mapping_tree_free(struct extent_map_tree *tree);
 blk_status_t btrfs_map_bio(struct btrfs_fs_info *fs_info, struct bio *bio,
 			   int mirror_num);
@@ -509,6 +510,8 @@ unsigned long btrfs_full_stripe_len(struct btrfs_fs_info *fs_info,
 				    u64 logical);
 int btrfs_finish_chunk_alloc(struct btrfs_trans_handle *trans,
 			     u64 chunk_offset, u64 chunk_size);
+int btrfs_chunk_alloc_add_chunk_item(struct btrfs_trans_handle *trans,
+				     struct btrfs_block_group *bg);
 int btrfs_remove_chunk(struct btrfs_trans_handle *trans, u64 chunk_offset);
 struct extent_map *btrfs_get_chunk_map(struct btrfs_fs_info *fs_info,
 				       u64 logical, u64 length);
-- 
2.28.0

