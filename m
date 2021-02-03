Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 203A930D85F
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 Feb 2021 12:18:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234128AbhBCLSj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 3 Feb 2021 06:18:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:56564 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233972AbhBCLSe (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 3 Feb 2021 06:18:34 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3563F64F48
        for <linux-btrfs@vger.kernel.org>; Wed,  3 Feb 2021 11:17:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612351072;
        bh=LtjoSQCPGPAkC95J5GEi5Fr0JWkbMmuhZSd9Lp3Z6Vs=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=eWgb/LmsWjGcklj2NFpgzGS9TgbSMuvNxxUvKhwYHMQfJiXhwxygV2rYsNgr7kjby
         kDIjcT5DyaYOQvSObVqKsBIL+ULq5Z85L8HS7hL95U5iJOieg6b39YTmXXJsMfsMzm
         D6bNo1ma6Nt4/CjpA+CCjuP53ZT2j/4twjij965I4POtpWZJiRjQbhm77EeVrJRUD6
         PybHRtPFrzKUcjWlV74mZYtS17VaTFGcHAek1Tx7p18hUFsf4QNMUr8s7qzklAWM70
         WknzMU/VqnkNh93itSbKmYIMmFS3+am7h2yvAVopI5sxSai1Q5ALcFkpRNtiphKFoK
         nuzwQJgEIN7qA==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 2/4] btrfs: fix race between writes to swap files and scrub
Date:   Wed,  3 Feb 2021 11:17:45 +0000
Message-Id: <0da379a02fdabaf9ca295a34f7de287b5d5465f7.1612350698.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1612350698.git.fdmanana@suse.com>
References: <cover.1612350698.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

When we active a swap file, at btrfs_swap_activate(), we acquire the
exclusive operation lock to prevent the physical location of the swap
file extents to be changed by operations such as balance and device
replace/resize/remove. We also call there can_nocow_extent() which,
among other things, checks if the block group of a swap file extent is
currently RO, and if it is we can not use the extent, since a write
into it would result in COWing the extent.

However we have no protection against a scrub operation running after we
activate the swap file, which can result in the swap file extents to be
COWed while the scrub is running and operating on the respective block
group, because scrub turns a block group into RO before it processes it
and then back again to RW mode after processing it. That means an attempt
to write into a swap file extent while scrub is processing the respective
block group, will result in COWing the extent, changing its physical
location on disk.

Fix this by making sure that block groups that have extents that are used
by active swap files can not be turned into RO mode, therefore making it
not possible for a scrub to turn them into RO mode. When a scrub finds a
block group that can not be turned to RO due to the existence of extents
used by swap files, it proceeds to the next block group and logs a warning
message that mentions the block group was skipped due to active swap
files - this is the same approach we currently use for balance.

This ends up removing the need to call btrfs_extent_readonly() from
can_nocow_extent(), as btrfs_swap_activate() now checks if a block group
is RO through the new function btrfs_inc_block_group_swap_extents().

The only other caller of can_nocow_extent() is the direct IO write path,
btrfs_get_blocks_direct_write(), but that already checks if a block group
is RO through the call to btrfs_inc_nocow_writers(). In fact, after this
change we end up optimizing the direct IO write path, since we no longer
iterate the block groups rbtree twice, once with btrfs_extent_readonly(),
through can_nocow_extent(), and once again with btrfs_inc_nocow_writers().
This can save time and reduce contention on the lock that protects the
rbtree (specially because it is a spinlock and not a read/write lock) on
very large filesystems, with several thousands of allocated block groups.

Fixes: ed46ff3d42378 ("Btrfs: support swap files")
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/block-group.c | 33 ++++++++++++++++++++++++++++++++-
 fs/btrfs/block-group.h |  9 +++++++++
 fs/btrfs/ctree.h       |  5 +++++
 fs/btrfs/inode.c       | 22 ++++++++++++++++++----
 fs/btrfs/scrub.c       |  9 ++++++++-
 5 files changed, 72 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 5fa6b3d540f4..c0a8ddf92ef8 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -1150,6 +1150,11 @@ static int inc_block_group_ro(struct btrfs_block_group *cache, int force)
 	spin_lock(&sinfo->lock);
 	spin_lock(&cache->lock);
 
+	if (cache->swap_extents) {
+		ret = -ETXTBSY;
+		goto out;
+	}
+
 	if (cache->ro) {
 		cache->ro++;
 		ret = 0;
@@ -2260,7 +2265,7 @@ int btrfs_inc_block_group_ro(struct btrfs_block_group *cache,
 	}
 
 	ret = inc_block_group_ro(cache, 0);
-	if (!do_chunk_alloc)
+	if (!do_chunk_alloc || ret == -ETXTBSY)
 		goto unlock_out;
 	if (!ret)
 		goto out;
@@ -2269,6 +2274,8 @@ int btrfs_inc_block_group_ro(struct btrfs_block_group *cache,
 	if (ret < 0)
 		goto out;
 	ret = inc_block_group_ro(cache, 0);
+	if (ret == -ETXTBSY)
+		goto unlock_out;
 out:
 	if (cache->flags & BTRFS_BLOCK_GROUP_SYSTEM) {
 		alloc_flags = btrfs_get_alloc_profile(fs_info, cache->flags);
@@ -3352,6 +3359,7 @@ int btrfs_free_block_groups(struct btrfs_fs_info *info)
 		ASSERT(list_empty(&block_group->io_list));
 		ASSERT(list_empty(&block_group->bg_list));
 		ASSERT(refcount_read(&block_group->refs) == 1);
+		ASSERT(block_group->swap_extents == 0);
 		btrfs_put_block_group(block_group);
 
 		spin_lock(&info->block_group_cache_lock);
@@ -3418,3 +3426,26 @@ void btrfs_unfreeze_block_group(struct btrfs_block_group *block_group)
 		__btrfs_remove_free_space_cache(block_group->free_space_ctl);
 	}
 }
+
+bool btrfs_inc_block_group_swap_extents(struct btrfs_block_group *bg)
+{
+	bool ret = true;
+
+	spin_lock(&bg->lock);
+	if (bg->ro)
+		ret = false;
+	else
+		bg->swap_extents++;
+	spin_unlock(&bg->lock);
+
+	return ret;
+}
+
+void btrfs_dec_block_group_swap_extents(struct btrfs_block_group *bg, int amount)
+{
+	spin_lock(&bg->lock);
+	ASSERT(!bg->ro);
+	ASSERT(bg->swap_extents >= amount);
+	bg->swap_extents -= amount;
+	spin_unlock(&bg->lock);
+}
diff --git a/fs/btrfs/block-group.h b/fs/btrfs/block-group.h
index 8f74a96074f7..105094bd1821 100644
--- a/fs/btrfs/block-group.h
+++ b/fs/btrfs/block-group.h
@@ -181,6 +181,12 @@ struct btrfs_block_group {
 	 */
 	int needs_free_space;
 
+	/*
+	 * Number of extents in this block group used for swap files.
+	 * All accesses protected by the spinlock 'lock'.
+	 */
+	int swap_extents;
+
 	/* Record locked full stripes for RAID5/6 block group */
 	struct btrfs_full_stripe_locks_tree full_stripe_locks_root;
 };
@@ -296,6 +302,9 @@ static inline int btrfs_block_group_done(struct btrfs_block_group *cache)
 void btrfs_freeze_block_group(struct btrfs_block_group *cache);
 void btrfs_unfreeze_block_group(struct btrfs_block_group *cache);
 
+bool btrfs_inc_block_group_swap_extents(struct btrfs_block_group *bg);
+void btrfs_dec_block_group_swap_extents(struct btrfs_block_group *bg, int amount);
+
 #ifdef CONFIG_BTRFS_FS_RUN_SANITY_TESTS
 int btrfs_rmap_block(struct btrfs_fs_info *fs_info, u64 chunk_start,
 		     u64 physical, u64 **logical, int *naddrs, int *stripe_len);
diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index ed6bb46a2572..5269777a4fb4 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -523,6 +523,11 @@ struct btrfs_swapfile_pin {
 	 * points to a struct btrfs_device.
 	 */
 	bool is_block_group;
+	/*
+	 * Only used when 'is_block_group' is true and it is the number of
+	 * extents used by a swapfile for this block group ('ptr' field).
+	 */
+	int bg_extent_count;
 };
 
 bool btrfs_pinned_by_swapfile(struct btrfs_fs_info *fs_info, void *ptr);
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index b10fc42f9e9a..464c289c402d 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -7204,9 +7204,6 @@ noinline int can_nocow_extent(struct inode *inode, u64 offset, u64 *len,
 		*ram_bytes = btrfs_file_extent_ram_bytes(leaf, fi);
 	}
 
-	if (btrfs_extent_readonly(fs_info, disk_bytenr))
-		goto out;
-
 	num_bytes = min(offset + *len, extent_end) - offset;
 	if (!nocow && found_type == BTRFS_FILE_EXTENT_PREALLOC) {
 		u64 range_end;
@@ -9990,6 +9987,7 @@ static int btrfs_add_swapfile_pin(struct inode *inode, void *ptr,
 	sp->ptr = ptr;
 	sp->inode = inode;
 	sp->is_block_group = is_block_group;
+	sp->bg_extent_count = 1;
 
 	spin_lock(&fs_info->swapfile_pins_lock);
 	p = &fs_info->swapfile_pins.rb_node;
@@ -10003,6 +10001,8 @@ static int btrfs_add_swapfile_pin(struct inode *inode, void *ptr,
 			   (sp->ptr == entry->ptr && sp->inode > entry->inode)) {
 			p = &(*p)->rb_right;
 		} else {
+			if (is_block_group)
+				entry->bg_extent_count++;
 			spin_unlock(&fs_info->swapfile_pins_lock);
 			kfree(sp);
 			return 1;
@@ -10028,8 +10028,11 @@ static void btrfs_free_swapfile_pins(struct inode *inode)
 		sp = rb_entry(node, struct btrfs_swapfile_pin, node);
 		if (sp->inode == inode) {
 			rb_erase(&sp->node, &fs_info->swapfile_pins);
-			if (sp->is_block_group)
+			if (sp->is_block_group) {
+				btrfs_dec_block_group_swap_extents(sp->ptr,
+							   sp->bg_extent_count);
 				btrfs_put_block_group(sp->ptr);
+			}
 			kfree(sp);
 		}
 		node = next;
@@ -10244,6 +10247,17 @@ static int btrfs_swap_activate(struct swap_info_struct *sis, struct file *file,
 			goto out;
 		}
 
+		if (!btrfs_inc_block_group_swap_extents(bg)) {
+			btrfs_warn(fs_info,
+			   "block group for swapfile at %llu is read-only%s",
+			   bg->start,
+			   atomic_read(&fs_info->scrubs_running) ?
+				   " (scrub running)" : "");
+			btrfs_put_block_group(bg);
+			ret = -EINVAL;
+			goto out;
+		}
+
 		ret = btrfs_add_swapfile_pin(inode, bg, true);
 		if (ret) {
 			btrfs_put_block_group(bg);
diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 5f4f88a4d2c8..c09a494be8c6 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -3630,6 +3630,13 @@ int scrub_enumerate_chunks(struct scrub_ctx *sctx,
 			 * commit_transactions.
 			 */
 			ro_set = 0;
+		} else if (ret == -ETXTBSY) {
+			btrfs_warn(fs_info,
+		   "skipping scrub of block group %llu due to active swapfile",
+				   cache->start);
+			scrub_pause_off(fs_info);
+			ret = 0;
+			goto skip_unfreeze;
 		} else {
 			btrfs_warn(fs_info,
 				   "failed setting block group ro: %d", ret);
@@ -3719,7 +3726,7 @@ int scrub_enumerate_chunks(struct scrub_ctx *sctx,
 		} else {
 			spin_unlock(&cache->lock);
 		}
-
+skip_unfreeze:
 		btrfs_unfreeze_block_group(cache);
 		btrfs_put_block_group(cache);
 		if (ret)
-- 
2.28.0

