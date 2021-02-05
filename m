Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A322C310B77
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Feb 2021 14:00:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232435AbhBEM7P (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 5 Feb 2021 07:59:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:45390 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232102AbhBEM4Y (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 5 Feb 2021 07:56:24 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 817FA64FBC
        for <linux-btrfs@vger.kernel.org>; Fri,  5 Feb 2021 12:55:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612529743;
        bh=elGA30mj+s5Jv0ddtAUnuw9drTrAfMp9UGqjj0kmIrA=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=GsJD5Sk6T/eh+EQu9aF8n9wV8kU7DXQhf9tJC8U98jeQfIIKTiU4WeGjIEpZnjRHx
         hkWDrY8BfOFthNh6djJDsRw976lGTVocdmJs1DEjYE7LyLydFXZ/EtmQx2wqGyU7ew
         Uq14hs1drrjubCi0z6+hFHngqz4FvXQbvlTUG6nOkuCqBpol2mS5t8ivp8RdbRDKMC
         nf6ktMeP4XbSELxorcGN3NsF9Cumb54vpDvrF5Wyj8Pb8Zo5c8Nn25mGjxCc4iGnLL
         gRvsipDrP0EqcDOV7joUPlvXEAfj4Uhxecz1HXqJlvNQZeJ+yNRYNXJmPHIhrcMOne
         vJrR6y7R5u3Ow==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 2/3] btrfs: fix race between writes to swap files and scrub
Date:   Fri,  5 Feb 2021 12:55:37 +0000
Message-Id: <e89b5c5bf4518471558237f359590118ae9c2145.1612529182.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1612529182.git.fdmanana@suse.com>
References: <cover.1612529182.git.fdmanana@suse.com>
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

Fixes: ed46ff3d42378 ("Btrfs: support swap files")
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/block-group.c | 33 ++++++++++++++++++++++++++++++++-
 fs/btrfs/block-group.h |  9 +++++++++
 fs/btrfs/ctree.h       |  5 +++++
 fs/btrfs/inode.c       | 19 ++++++++++++++++++-
 fs/btrfs/scrub.c       |  9 ++++++++-
 5 files changed, 72 insertions(+), 3 deletions(-)

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
index a9b0521d9e89..0597e85ab38c 100644
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
index 76a0151ef05a..715ae1320383 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -10010,6 +10010,7 @@ static int btrfs_add_swapfile_pin(struct inode *inode, void *ptr,
 	sp->ptr = ptr;
 	sp->inode = inode;
 	sp->is_block_group = is_block_group;
+	sp->bg_extent_count = 1;
 
 	spin_lock(&fs_info->swapfile_pins_lock);
 	p = &fs_info->swapfile_pins.rb_node;
@@ -10023,6 +10024,8 @@ static int btrfs_add_swapfile_pin(struct inode *inode, void *ptr,
 			   (sp->ptr == entry->ptr && sp->inode > entry->inode)) {
 			p = &(*p)->rb_right;
 		} else {
+			if (is_block_group)
+				entry->bg_extent_count++;
 			spin_unlock(&fs_info->swapfile_pins_lock);
 			kfree(sp);
 			return 1;
@@ -10048,8 +10051,11 @@ static void btrfs_free_swapfile_pins(struct inode *inode)
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
@@ -10264,6 +10270,17 @@ static int btrfs_swap_activate(struct swap_info_struct *sis, struct file *file,
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

