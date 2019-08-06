Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0DA4A836BA
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Aug 2019 18:29:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387866AbfHFQ2s (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 6 Aug 2019 12:28:48 -0400
Received: from mail-qk1-f171.google.com ([209.85.222.171]:47053 "EHLO
        mail-qk1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387676AbfHFQ2r (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 6 Aug 2019 12:28:47 -0400
Received: by mail-qk1-f171.google.com with SMTP id r4so63258185qkm.13
        for <linux-btrfs@vger.kernel.org>; Tue, 06 Aug 2019 09:28:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=azog9jSAGWLQHgdaNv5pkQOAIPtOIepEtDoh36fPuPY=;
        b=Fn5zNZlcyvELzO2R9v5vIwKn6VtqwyuVxAaIEhCerh5Nz5yzsulPPGG4d0KDyFkc+8
         QWymVj0p0VxP/PTuwoKZ2AXdLqOlUFOMJx6+8TqyBeSPwNSiFVVEEiKBAGHigTVAK0vq
         d3RisWyivlTKXclCc91x/u0+fhA+JJ8mxBs+lcGvsw3eGSBsNGV2mBcMwD0eHTSq8AMD
         8zqtkQc1TS7ydBOVTlxfLaIEXzbDqc7c8XRPT16yMWc21eTBMta+VWWAUdp5oyoyLCdJ
         B43pxU0Z410NLOo3eD586IBOI8dVTP56Izz6JuWPLBXuLjiClrhJrV58ziIvXTlYLInK
         ddoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=azog9jSAGWLQHgdaNv5pkQOAIPtOIepEtDoh36fPuPY=;
        b=jOkWALLyvjo6jQj0JQP6ZIEcg1FL3QfBvSG33N5qlwRYtzqLHO1VcpjXxTCe57Wybo
         8zqaNAOaiDZ/E43iQTLL/veUl/wr/cOQOCx5CsGejs8qOfKKBCmwhMqsO/UgraQFbWgq
         xqH8zWUWsMIXNUjQBRROdsAL3p5/thgicTtgEh5NGFW+XschgvPdkVFouD2YHN+UJHvW
         1jpBFgQBtKpMHbg/P7lgInN7QVWUipGOZlk/V4XxeRkWFV5qaxcL4Vni0gGsYQh15ORA
         pzlIqLY0/RT2SfYu9dpDKpBODX02qdu/41m0cvdCLECIbu62JXW6ooWDIMZ/K79q3+rA
         NsvA==
X-Gm-Message-State: APjAAAUWp5dY+24gV0bFaBZ8n+FmMqRNvz5b1CH2o13g/8mQ8hj59d/l
        Zlw6nrb4BySjSvPeUn/074DDBw==
X-Google-Smtp-Source: APXvYqwWnWnMYncJxlGXUwuuUfTgSnLqGo4ZEhxnFtK1PEGK0cgNxCuXsWK6DrfiT8FagKxzcLChdg==
X-Received: by 2002:a37:b82:: with SMTP id 124mr3533924qkl.260.1565108925476;
        Tue, 06 Aug 2019 09:28:45 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id p23sm38609368qke.44.2019.08.06.09.28.44
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 06 Aug 2019 09:28:44 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     kernel-team@fb.com, linux-btrfs@vger.kernel.org
Subject: [PATCH 03/15] btrfs: migrate the block group removal code
Date:   Tue,  6 Aug 2019 12:28:25 -0400
Message-Id: <20190806162837.15840-4-josef@toxicpanda.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190806162837.15840-1-josef@toxicpanda.com>
References: <20190806162837.15840-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is the removal code and the unused bgs code.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/block-group.c | 541 +++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/block-group.h |   7 +
 fs/btrfs/ctree.h       |   7 -
 fs/btrfs/extent-tree.c | 537 ----------------------------------------
 4 files changed, 548 insertions(+), 544 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index e8c29045e1b9..0bc51bfe4904 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -6,6 +6,10 @@
 #include "disk-io.h"
 #include "free-space-cache.h"
 #include "free-space-tree.h"
+#include "disk-io.h"
+#include "volumes.h"
+#include "transaction.h"
+#include "ref-verify.h"
 
 void btrfs_get_block_group(struct btrfs_block_group_cache *cache)
 {
@@ -663,3 +667,540 @@ int btrfs_cache_block_group(struct btrfs_block_group_cache *cache,
 
 	return ret;
 }
+
+static void clear_avail_alloc_bits(struct btrfs_fs_info *fs_info, u64 flags)
+{
+	u64 extra_flags = chunk_to_extended(flags) &
+				BTRFS_EXTENDED_PROFILE_MASK;
+
+	write_seqlock(&fs_info->profiles_lock);
+	if (flags & BTRFS_BLOCK_GROUP_DATA)
+		fs_info->avail_data_alloc_bits &= ~extra_flags;
+	if (flags & BTRFS_BLOCK_GROUP_METADATA)
+		fs_info->avail_metadata_alloc_bits &= ~extra_flags;
+	if (flags & BTRFS_BLOCK_GROUP_SYSTEM)
+		fs_info->avail_system_alloc_bits &= ~extra_flags;
+	write_sequnlock(&fs_info->profiles_lock);
+}
+
+/*
+ * Clear incompat bits for the following feature(s):
+ *
+ * - RAID56 - in case there's neither RAID5 nor RAID6 profile block group
+ *            in the whole filesystem
+ */
+static void clear_incompat_bg_bits(struct btrfs_fs_info *fs_info, u64 flags)
+{
+	if (flags & BTRFS_BLOCK_GROUP_RAID56_MASK) {
+		struct list_head *head = &fs_info->space_info;
+		struct btrfs_space_info *sinfo;
+
+		list_for_each_entry_rcu(sinfo, head, list) {
+			bool found = false;
+
+			down_read(&sinfo->groups_sem);
+			if (!list_empty(&sinfo->block_groups[BTRFS_RAID_RAID5]))
+				found = true;
+			if (!list_empty(&sinfo->block_groups[BTRFS_RAID_RAID6]))
+				found = true;
+			up_read(&sinfo->groups_sem);
+
+			if (found)
+				return;
+		}
+		btrfs_clear_fs_incompat(fs_info, RAID56);
+	}
+}
+
+int btrfs_remove_block_group(struct btrfs_trans_handle *trans,
+			     u64 group_start, struct extent_map *em)
+{
+	struct btrfs_fs_info *fs_info = trans->fs_info;
+	struct btrfs_root *root = fs_info->extent_root;
+	struct btrfs_path *path;
+	struct btrfs_block_group_cache *block_group;
+	struct btrfs_free_cluster *cluster;
+	struct btrfs_root *tree_root = fs_info->tree_root;
+	struct btrfs_key key;
+	struct inode *inode;
+	struct kobject *kobj = NULL;
+	int ret;
+	int index;
+	int factor;
+	struct btrfs_caching_control *caching_ctl = NULL;
+	bool remove_em;
+	bool remove_rsv = false;
+
+	block_group = btrfs_lookup_block_group(fs_info, group_start);
+	BUG_ON(!block_group);
+	BUG_ON(!block_group->ro);
+
+	trace_btrfs_remove_block_group(block_group);
+	/*
+	 * Free the reserved super bytes from this block group before
+	 * remove it.
+	 */
+	btrfs_free_excluded_extents(block_group);
+	btrfs_free_ref_tree_range(fs_info, block_group->key.objectid,
+				  block_group->key.offset);
+
+	memcpy(&key, &block_group->key, sizeof(key));
+	index = btrfs_bg_flags_to_raid_index(block_group->flags);
+	factor = btrfs_bg_type_to_factor(block_group->flags);
+
+	/* make sure this block group isn't part of an allocation cluster */
+	cluster = &fs_info->data_alloc_cluster;
+	spin_lock(&cluster->refill_lock);
+	btrfs_return_cluster_to_free_space(block_group, cluster);
+	spin_unlock(&cluster->refill_lock);
+
+	/*
+	 * make sure this block group isn't part of a metadata
+	 * allocation cluster
+	 */
+	cluster = &fs_info->meta_alloc_cluster;
+	spin_lock(&cluster->refill_lock);
+	btrfs_return_cluster_to_free_space(block_group, cluster);
+	spin_unlock(&cluster->refill_lock);
+
+	path = btrfs_alloc_path();
+	if (!path) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	/*
+	 * get the inode first so any iput calls done for the io_list
+	 * aren't the final iput (no unlinks allowed now)
+	 */
+	inode = lookup_free_space_inode(block_group, path);
+
+	mutex_lock(&trans->transaction->cache_write_mutex);
+	/*
+	 * Make sure our free space cache IO is done before removing the
+	 * free space inode
+	 */
+	spin_lock(&trans->transaction->dirty_bgs_lock);
+	if (!list_empty(&block_group->io_list)) {
+		list_del_init(&block_group->io_list);
+
+		WARN_ON(!IS_ERR(inode) && inode != block_group->io_ctl.inode);
+
+		spin_unlock(&trans->transaction->dirty_bgs_lock);
+		btrfs_wait_cache_io(trans, block_group, path);
+		btrfs_put_block_group(block_group);
+		spin_lock(&trans->transaction->dirty_bgs_lock);
+	}
+
+	if (!list_empty(&block_group->dirty_list)) {
+		list_del_init(&block_group->dirty_list);
+		remove_rsv = true;
+		btrfs_put_block_group(block_group);
+	}
+	spin_unlock(&trans->transaction->dirty_bgs_lock);
+	mutex_unlock(&trans->transaction->cache_write_mutex);
+
+	if (!IS_ERR(inode)) {
+		ret = btrfs_orphan_add(trans, BTRFS_I(inode));
+		if (ret) {
+			btrfs_add_delayed_iput(inode);
+			goto out;
+		}
+		clear_nlink(inode);
+		/* One for the block groups ref */
+		spin_lock(&block_group->lock);
+		if (block_group->iref) {
+			block_group->iref = 0;
+			block_group->inode = NULL;
+			spin_unlock(&block_group->lock);
+			iput(inode);
+		} else {
+			spin_unlock(&block_group->lock);
+		}
+		/* One for our lookup ref */
+		btrfs_add_delayed_iput(inode);
+	}
+
+	key.objectid = BTRFS_FREE_SPACE_OBJECTID;
+	key.offset = block_group->key.objectid;
+	key.type = 0;
+
+	ret = btrfs_search_slot(trans, tree_root, &key, path, -1, 1);
+	if (ret < 0)
+		goto out;
+	if (ret > 0)
+		btrfs_release_path(path);
+	if (ret == 0) {
+		ret = btrfs_del_item(trans, tree_root, path);
+		if (ret)
+			goto out;
+		btrfs_release_path(path);
+	}
+
+	spin_lock(&fs_info->block_group_cache_lock);
+	rb_erase(&block_group->cache_node,
+		 &fs_info->block_group_cache_tree);
+	RB_CLEAR_NODE(&block_group->cache_node);
+
+	if (fs_info->first_logical_byte == block_group->key.objectid)
+		fs_info->first_logical_byte = (u64)-1;
+	spin_unlock(&fs_info->block_group_cache_lock);
+
+	down_write(&block_group->space_info->groups_sem);
+	/*
+	 * we must use list_del_init so people can check to see if they
+	 * are still on the list after taking the semaphore
+	 */
+	list_del_init(&block_group->list);
+	if (list_empty(&block_group->space_info->block_groups[index])) {
+		kobj = block_group->space_info->block_group_kobjs[index];
+		block_group->space_info->block_group_kobjs[index] = NULL;
+		clear_avail_alloc_bits(fs_info, block_group->flags);
+	}
+	up_write(&block_group->space_info->groups_sem);
+	clear_incompat_bg_bits(fs_info, block_group->flags);
+	if (kobj) {
+		kobject_del(kobj);
+		kobject_put(kobj);
+	}
+
+	if (block_group->has_caching_ctl)
+		caching_ctl = btrfs_get_caching_control(block_group);
+	if (block_group->cached == BTRFS_CACHE_STARTED)
+		btrfs_wait_block_group_cache_done(block_group);
+	if (block_group->has_caching_ctl) {
+		down_write(&fs_info->commit_root_sem);
+		if (!caching_ctl) {
+			struct btrfs_caching_control *ctl;
+
+			list_for_each_entry(ctl,
+				    &fs_info->caching_block_groups, list)
+				if (ctl->block_group == block_group) {
+					caching_ctl = ctl;
+					refcount_inc(&caching_ctl->count);
+					break;
+				}
+		}
+		if (caching_ctl)
+			list_del_init(&caching_ctl->list);
+		up_write(&fs_info->commit_root_sem);
+		if (caching_ctl) {
+			/* Once for the caching bgs list and once for us. */
+			btrfs_put_caching_control(caching_ctl);
+			btrfs_put_caching_control(caching_ctl);
+		}
+	}
+
+	spin_lock(&trans->transaction->dirty_bgs_lock);
+	WARN_ON(!list_empty(&block_group->dirty_list));
+	WARN_ON(!list_empty(&block_group->io_list));
+	spin_unlock(&trans->transaction->dirty_bgs_lock);
+
+	btrfs_remove_free_space_cache(block_group);
+
+	spin_lock(&block_group->space_info->lock);
+	list_del_init(&block_group->ro_list);
+
+	if (btrfs_test_opt(fs_info, ENOSPC_DEBUG)) {
+		WARN_ON(block_group->space_info->total_bytes
+			< block_group->key.offset);
+		WARN_ON(block_group->space_info->bytes_readonly
+			< block_group->key.offset);
+		WARN_ON(block_group->space_info->disk_total
+			< block_group->key.offset * factor);
+	}
+	block_group->space_info->total_bytes -= block_group->key.offset;
+	block_group->space_info->bytes_readonly -= block_group->key.offset;
+	block_group->space_info->disk_total -= block_group->key.offset * factor;
+
+	spin_unlock(&block_group->space_info->lock);
+
+	memcpy(&key, &block_group->key, sizeof(key));
+
+	mutex_lock(&fs_info->chunk_mutex);
+	spin_lock(&block_group->lock);
+	block_group->removed = 1;
+	/*
+	 * At this point trimming can't start on this block group, because we
+	 * removed the block group from the tree fs_info->block_group_cache_tree
+	 * so no one can't find it anymore and even if someone already got this
+	 * block group before we removed it from the rbtree, they have already
+	 * incremented block_group->trimming - if they didn't, they won't find
+	 * any free space entries because we already removed them all when we
+	 * called btrfs_remove_free_space_cache().
+	 *
+	 * And we must not remove the extent map from the fs_info->mapping_tree
+	 * to prevent the same logical address range and physical device space
+	 * ranges from being reused for a new block group. This is because our
+	 * fs trim operation (btrfs_trim_fs() / btrfs_ioctl_fitrim()) is
+	 * completely transactionless, so while it is trimming a range the
+	 * currently running transaction might finish and a new one start,
+	 * allowing for new block groups to be created that can reuse the same
+	 * physical device locations unless we take this special care.
+	 *
+	 * There may also be an implicit trim operation if the file system
+	 * is mounted with -odiscard. The same protections must remain
+	 * in place until the extents have been discarded completely when
+	 * the transaction commit has completed.
+	 */
+	remove_em = (atomic_read(&block_group->trimming) == 0);
+	spin_unlock(&block_group->lock);
+
+	mutex_unlock(&fs_info->chunk_mutex);
+
+	ret = remove_block_group_free_space(trans, block_group);
+	if (ret)
+		goto out;
+
+	btrfs_put_block_group(block_group);
+	btrfs_put_block_group(block_group);
+
+	ret = btrfs_search_slot(trans, root, &key, path, -1, 1);
+	if (ret > 0)
+		ret = -EIO;
+	if (ret < 0)
+		goto out;
+
+	ret = btrfs_del_item(trans, root, path);
+	if (ret)
+		goto out;
+
+	if (remove_em) {
+		struct extent_map_tree *em_tree;
+
+		em_tree = &fs_info->mapping_tree;
+		write_lock(&em_tree->lock);
+		remove_extent_mapping(em_tree, em);
+		write_unlock(&em_tree->lock);
+		/* once for the tree */
+		free_extent_map(em);
+	}
+out:
+	if (remove_rsv)
+		btrfs_delayed_refs_rsv_release(fs_info, 1);
+	btrfs_free_path(path);
+	return ret;
+}
+
+struct btrfs_trans_handle *
+btrfs_start_trans_remove_block_group(struct btrfs_fs_info *fs_info,
+				     const u64 chunk_offset)
+{
+	struct extent_map_tree *em_tree = &fs_info->mapping_tree;
+	struct extent_map *em;
+	struct map_lookup *map;
+	unsigned int num_items;
+
+	read_lock(&em_tree->lock);
+	em = lookup_extent_mapping(em_tree, chunk_offset, 1);
+	read_unlock(&em_tree->lock);
+	ASSERT(em && em->start == chunk_offset);
+
+	/*
+	 * We need to reserve 3 + N units from the metadata space info in order
+	 * to remove a block group (done at btrfs_remove_chunk() and at
+	 * btrfs_remove_block_group()), which are used for:
+	 *
+	 * 1 unit for adding the free space inode's orphan (located in the tree
+	 * of tree roots).
+	 * 1 unit for deleting the block group item (located in the extent
+	 * tree).
+	 * 1 unit for deleting the free space item (located in tree of tree
+	 * roots).
+	 * N units for deleting N device extent items corresponding to each
+	 * stripe (located in the device tree).
+	 *
+	 * In order to remove a block group we also need to reserve units in the
+	 * system space info in order to update the chunk tree (update one or
+	 * more device items and remove one chunk item), but this is done at
+	 * btrfs_remove_chunk() through a call to check_system_chunk().
+	 */
+	map = em->map_lookup;
+	num_items = 3 + map->num_stripes;
+	free_extent_map(em);
+
+	return btrfs_start_transaction_fallback_global_rsv(fs_info->extent_root,
+							   num_items, 1);
+}
+
+/*
+ * Process the unused_bgs list and remove any that don't have any allocated
+ * space inside of them.
+ */
+void btrfs_delete_unused_bgs(struct btrfs_fs_info *fs_info)
+{
+	struct btrfs_block_group_cache *block_group;
+	struct btrfs_space_info *space_info;
+	struct btrfs_trans_handle *trans;
+	int ret = 0;
+
+	if (!test_bit(BTRFS_FS_OPEN, &fs_info->flags))
+		return;
+
+	spin_lock(&fs_info->unused_bgs_lock);
+	while (!list_empty(&fs_info->unused_bgs)) {
+		u64 start, end;
+		int trimming;
+
+		block_group = list_first_entry(&fs_info->unused_bgs,
+					       struct btrfs_block_group_cache,
+					       bg_list);
+		list_del_init(&block_group->bg_list);
+
+		space_info = block_group->space_info;
+
+		if (ret || btrfs_mixed_space_info(space_info)) {
+			btrfs_put_block_group(block_group);
+			continue;
+		}
+		spin_unlock(&fs_info->unused_bgs_lock);
+
+		mutex_lock(&fs_info->delete_unused_bgs_mutex);
+
+		/* Don't want to race with allocators so take the groups_sem */
+		down_write(&space_info->groups_sem);
+		spin_lock(&block_group->lock);
+		if (block_group->reserved || block_group->pinned ||
+		    btrfs_block_group_used(&block_group->item) ||
+		    block_group->ro ||
+		    list_is_singular(&block_group->list)) {
+			/*
+			 * We want to bail if we made new allocations or have
+			 * outstanding allocations in this block group.  We do
+			 * the ro check in case balance is currently acting on
+			 * this block group.
+			 */
+			trace_btrfs_skip_unused_block_group(block_group);
+			spin_unlock(&block_group->lock);
+			up_write(&space_info->groups_sem);
+			goto next;
+		}
+		spin_unlock(&block_group->lock);
+
+		/* We don't want to force the issue, only flip if it's ok. */
+		ret = __btrfs_inc_block_group_ro(block_group, 0);
+		up_write(&space_info->groups_sem);
+		if (ret < 0) {
+			ret = 0;
+			goto next;
+		}
+
+		/*
+		 * Want to do this before we do anything else so we can recover
+		 * properly if we fail to join the transaction.
+		 */
+		trans = btrfs_start_trans_remove_block_group(fs_info,
+						     block_group->key.objectid);
+		if (IS_ERR(trans)) {
+			btrfs_dec_block_group_ro(block_group);
+			ret = PTR_ERR(trans);
+			goto next;
+		}
+
+		/*
+		 * We could have pending pinned extents for this block group,
+		 * just delete them, we don't care about them anymore.
+		 */
+		start = block_group->key.objectid;
+		end = start + block_group->key.offset - 1;
+		/*
+		 * Hold the unused_bg_unpin_mutex lock to avoid racing with
+		 * btrfs_finish_extent_commit(). If we are at transaction N,
+		 * another task might be running finish_extent_commit() for the
+		 * previous transaction N - 1, and have seen a range belonging
+		 * to the block group in freed_extents[] before we were able to
+		 * clear the whole block group range from freed_extents[]. This
+		 * means that task can lookup for the block group after we
+		 * unpinned it from freed_extents[] and removed it, leading to
+		 * a BUG_ON() at btrfs_unpin_extent_range().
+		 */
+		mutex_lock(&fs_info->unused_bg_unpin_mutex);
+		ret = clear_extent_bits(&fs_info->freed_extents[0], start, end,
+				  EXTENT_DIRTY);
+		if (ret) {
+			mutex_unlock(&fs_info->unused_bg_unpin_mutex);
+			btrfs_dec_block_group_ro(block_group);
+			goto end_trans;
+		}
+		ret = clear_extent_bits(&fs_info->freed_extents[1], start, end,
+				  EXTENT_DIRTY);
+		if (ret) {
+			mutex_unlock(&fs_info->unused_bg_unpin_mutex);
+			btrfs_dec_block_group_ro(block_group);
+			goto end_trans;
+		}
+		mutex_unlock(&fs_info->unused_bg_unpin_mutex);
+
+		/* Reset pinned so btrfs_put_block_group doesn't complain */
+		spin_lock(&space_info->lock);
+		spin_lock(&block_group->lock);
+
+		btrfs_space_info_update_bytes_pinned(fs_info, space_info,
+						     -block_group->pinned);
+		space_info->bytes_readonly += block_group->pinned;
+		percpu_counter_add_batch(&space_info->total_bytes_pinned,
+				   -block_group->pinned,
+				   BTRFS_TOTAL_BYTES_PINNED_BATCH);
+		block_group->pinned = 0;
+
+		spin_unlock(&block_group->lock);
+		spin_unlock(&space_info->lock);
+
+		/* DISCARD can flip during remount */
+		trimming = btrfs_test_opt(fs_info, DISCARD);
+
+		/* Implicit trim during transaction commit. */
+		if (trimming)
+			btrfs_get_block_group_trimming(block_group);
+
+		/*
+		 * Btrfs_remove_chunk will abort the transaction if things go
+		 * horribly wrong.
+		 */
+		ret = btrfs_remove_chunk(trans, block_group->key.objectid);
+
+		if (ret) {
+			if (trimming)
+				btrfs_put_block_group_trimming(block_group);
+			goto end_trans;
+		}
+
+		/*
+		 * If we're not mounted with -odiscard, we can just forget
+		 * about this block group. Otherwise we'll need to wait
+		 * until transaction commit to do the actual discard.
+		 */
+		if (trimming) {
+			spin_lock(&fs_info->unused_bgs_lock);
+			/*
+			 * A concurrent scrub might have added us to the list
+			 * fs_info->unused_bgs, so use a list_move operation
+			 * to add the block group to the deleted_bgs list.
+			 */
+			list_move(&block_group->bg_list,
+				  &trans->transaction->deleted_bgs);
+			spin_unlock(&fs_info->unused_bgs_lock);
+			btrfs_get_block_group(block_group);
+		}
+end_trans:
+		btrfs_end_transaction(trans);
+next:
+		mutex_unlock(&fs_info->delete_unused_bgs_mutex);
+		btrfs_put_block_group(block_group);
+		spin_lock(&fs_info->unused_bgs_lock);
+	}
+	spin_unlock(&fs_info->unused_bgs_lock);
+}
+
+void btrfs_mark_bg_unused(struct btrfs_block_group_cache *bg)
+{
+	struct btrfs_fs_info *fs_info = bg->fs_info;
+
+	spin_lock(&fs_info->unused_bgs_lock);
+	if (list_empty(&bg->bg_list)) {
+		btrfs_get_block_group(bg);
+		trace_btrfs_add_unused_block_group(bg);
+		list_add_tail(&bg->bg_list, &fs_info->unused_bgs);
+	}
+	spin_unlock(&fs_info->unused_bgs_lock);
+}
diff --git a/fs/btrfs/block-group.h b/fs/btrfs/block-group.h
index 26c5bf876737..5ee2ea695ab0 100644
--- a/fs/btrfs/block-group.h
+++ b/fs/btrfs/block-group.h
@@ -176,6 +176,13 @@ struct btrfs_caching_control *btrfs_get_caching_control(
 		struct btrfs_block_group_cache *cache);
 u64 add_new_free_space(struct btrfs_block_group_cache *block_group,
 		       u64 start, u64 end);
+struct btrfs_trans_handle *btrfs_start_trans_remove_block_group(
+				struct btrfs_fs_info *fs_info,
+				const u64 chunk_offset);
+int btrfs_remove_block_group(struct btrfs_trans_handle *trans,
+			     u64 group_start, struct extent_map *em);
+void btrfs_delete_unused_bgs(struct btrfs_fs_info *fs_info);
+void btrfs_mark_bg_unused(struct btrfs_block_group_cache *bg);
 
 static inline int btrfs_block_group_cache_done(
 		struct btrfs_block_group_cache *cache)
diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 28c90916a8ae..266c3cb5f3c9 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -2530,12 +2530,6 @@ int btrfs_read_block_groups(struct btrfs_fs_info *info);
 int btrfs_make_block_group(struct btrfs_trans_handle *trans,
 			   u64 bytes_used, u64 type, u64 chunk_offset,
 			   u64 size);
-struct btrfs_trans_handle *btrfs_start_trans_remove_block_group(
-				struct btrfs_fs_info *fs_info,
-				const u64 chunk_offset);
-int btrfs_remove_block_group(struct btrfs_trans_handle *trans,
-			     u64 group_start, struct extent_map *em);
-void btrfs_delete_unused_bgs(struct btrfs_fs_info *fs_info);
 void btrfs_get_block_group_trimming(struct btrfs_block_group_cache *cache);
 void btrfs_put_block_group_trimming(struct btrfs_block_group_cache *cache);
 void btrfs_create_pending_block_groups(struct btrfs_trans_handle *trans);
@@ -2618,7 +2612,6 @@ int btrfs_start_write_no_snapshotting(struct btrfs_root *root);
 void btrfs_end_write_no_snapshotting(struct btrfs_root *root);
 void btrfs_wait_for_snapshot_creation(struct btrfs_root *root);
 void check_system_chunk(struct btrfs_trans_handle *trans, const u64 type);
-void btrfs_mark_bg_unused(struct btrfs_block_group_cache *bg);
 
 /* ctree.c */
 int btrfs_bin_search(struct extent_buffer *eb, const struct btrfs_key *key,
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 54dc910eb6c8..d28e736fdef2 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -7642,530 +7642,6 @@ int btrfs_make_block_group(struct btrfs_trans_handle *trans, u64 bytes_used,
 	return 0;
 }
 
-static void clear_avail_alloc_bits(struct btrfs_fs_info *fs_info, u64 flags)
-{
-	u64 extra_flags = chunk_to_extended(flags) &
-				BTRFS_EXTENDED_PROFILE_MASK;
-
-	write_seqlock(&fs_info->profiles_lock);
-	if (flags & BTRFS_BLOCK_GROUP_DATA)
-		fs_info->avail_data_alloc_bits &= ~extra_flags;
-	if (flags & BTRFS_BLOCK_GROUP_METADATA)
-		fs_info->avail_metadata_alloc_bits &= ~extra_flags;
-	if (flags & BTRFS_BLOCK_GROUP_SYSTEM)
-		fs_info->avail_system_alloc_bits &= ~extra_flags;
-	write_sequnlock(&fs_info->profiles_lock);
-}
-
-/*
- * Clear incompat bits for the following feature(s):
- *
- * - RAID56 - in case there's neither RAID5 nor RAID6 profile block group
- *            in the whole filesystem
- */
-static void clear_incompat_bg_bits(struct btrfs_fs_info *fs_info, u64 flags)
-{
-	if (flags & BTRFS_BLOCK_GROUP_RAID56_MASK) {
-		struct list_head *head = &fs_info->space_info;
-		struct btrfs_space_info *sinfo;
-
-		list_for_each_entry_rcu(sinfo, head, list) {
-			bool found = false;
-
-			down_read(&sinfo->groups_sem);
-			if (!list_empty(&sinfo->block_groups[BTRFS_RAID_RAID5]))
-				found = true;
-			if (!list_empty(&sinfo->block_groups[BTRFS_RAID_RAID6]))
-				found = true;
-			up_read(&sinfo->groups_sem);
-
-			if (found)
-				return;
-		}
-		btrfs_clear_fs_incompat(fs_info, RAID56);
-	}
-}
-
-int btrfs_remove_block_group(struct btrfs_trans_handle *trans,
-			     u64 group_start, struct extent_map *em)
-{
-	struct btrfs_fs_info *fs_info = trans->fs_info;
-	struct btrfs_root *root = fs_info->extent_root;
-	struct btrfs_path *path;
-	struct btrfs_block_group_cache *block_group;
-	struct btrfs_free_cluster *cluster;
-	struct btrfs_root *tree_root = fs_info->tree_root;
-	struct btrfs_key key;
-	struct inode *inode;
-	struct kobject *kobj = NULL;
-	int ret;
-	int index;
-	int factor;
-	struct btrfs_caching_control *caching_ctl = NULL;
-	bool remove_em;
-	bool remove_rsv = false;
-
-	block_group = btrfs_lookup_block_group(fs_info, group_start);
-	BUG_ON(!block_group);
-	BUG_ON(!block_group->ro);
-
-	trace_btrfs_remove_block_group(block_group);
-	/*
-	 * Free the reserved super bytes from this block group before
-	 * remove it.
-	 */
-	btrfs_free_excluded_extents(block_group);
-	btrfs_free_ref_tree_range(fs_info, block_group->key.objectid,
-				  block_group->key.offset);
-
-	memcpy(&key, &block_group->key, sizeof(key));
-	index = btrfs_bg_flags_to_raid_index(block_group->flags);
-	factor = btrfs_bg_type_to_factor(block_group->flags);
-
-	/* make sure this block group isn't part of an allocation cluster */
-	cluster = &fs_info->data_alloc_cluster;
-	spin_lock(&cluster->refill_lock);
-	btrfs_return_cluster_to_free_space(block_group, cluster);
-	spin_unlock(&cluster->refill_lock);
-
-	/*
-	 * make sure this block group isn't part of a metadata
-	 * allocation cluster
-	 */
-	cluster = &fs_info->meta_alloc_cluster;
-	spin_lock(&cluster->refill_lock);
-	btrfs_return_cluster_to_free_space(block_group, cluster);
-	spin_unlock(&cluster->refill_lock);
-
-	path = btrfs_alloc_path();
-	if (!path) {
-		ret = -ENOMEM;
-		goto out;
-	}
-
-	/*
-	 * get the inode first so any iput calls done for the io_list
-	 * aren't the final iput (no unlinks allowed now)
-	 */
-	inode = lookup_free_space_inode(block_group, path);
-
-	mutex_lock(&trans->transaction->cache_write_mutex);
-	/*
-	 * Make sure our free space cache IO is done before removing the
-	 * free space inode
-	 */
-	spin_lock(&trans->transaction->dirty_bgs_lock);
-	if (!list_empty(&block_group->io_list)) {
-		list_del_init(&block_group->io_list);
-
-		WARN_ON(!IS_ERR(inode) && inode != block_group->io_ctl.inode);
-
-		spin_unlock(&trans->transaction->dirty_bgs_lock);
-		btrfs_wait_cache_io(trans, block_group, path);
-		btrfs_put_block_group(block_group);
-		spin_lock(&trans->transaction->dirty_bgs_lock);
-	}
-
-	if (!list_empty(&block_group->dirty_list)) {
-		list_del_init(&block_group->dirty_list);
-		remove_rsv = true;
-		btrfs_put_block_group(block_group);
-	}
-	spin_unlock(&trans->transaction->dirty_bgs_lock);
-	mutex_unlock(&trans->transaction->cache_write_mutex);
-
-	if (!IS_ERR(inode)) {
-		ret = btrfs_orphan_add(trans, BTRFS_I(inode));
-		if (ret) {
-			btrfs_add_delayed_iput(inode);
-			goto out;
-		}
-		clear_nlink(inode);
-		/* One for the block groups ref */
-		spin_lock(&block_group->lock);
-		if (block_group->iref) {
-			block_group->iref = 0;
-			block_group->inode = NULL;
-			spin_unlock(&block_group->lock);
-			iput(inode);
-		} else {
-			spin_unlock(&block_group->lock);
-		}
-		/* One for our lookup ref */
-		btrfs_add_delayed_iput(inode);
-	}
-
-	key.objectid = BTRFS_FREE_SPACE_OBJECTID;
-	key.offset = block_group->key.objectid;
-	key.type = 0;
-
-	ret = btrfs_search_slot(trans, tree_root, &key, path, -1, 1);
-	if (ret < 0)
-		goto out;
-	if (ret > 0)
-		btrfs_release_path(path);
-	if (ret == 0) {
-		ret = btrfs_del_item(trans, tree_root, path);
-		if (ret)
-			goto out;
-		btrfs_release_path(path);
-	}
-
-	spin_lock(&fs_info->block_group_cache_lock);
-	rb_erase(&block_group->cache_node,
-		 &fs_info->block_group_cache_tree);
-	RB_CLEAR_NODE(&block_group->cache_node);
-
-	if (fs_info->first_logical_byte == block_group->key.objectid)
-		fs_info->first_logical_byte = (u64)-1;
-	spin_unlock(&fs_info->block_group_cache_lock);
-
-	down_write(&block_group->space_info->groups_sem);
-	/*
-	 * we must use list_del_init so people can check to see if they
-	 * are still on the list after taking the semaphore
-	 */
-	list_del_init(&block_group->list);
-	if (list_empty(&block_group->space_info->block_groups[index])) {
-		kobj = block_group->space_info->block_group_kobjs[index];
-		block_group->space_info->block_group_kobjs[index] = NULL;
-		clear_avail_alloc_bits(fs_info, block_group->flags);
-	}
-	up_write(&block_group->space_info->groups_sem);
-	clear_incompat_bg_bits(fs_info, block_group->flags);
-	if (kobj) {
-		kobject_del(kobj);
-		kobject_put(kobj);
-	}
-
-	if (block_group->has_caching_ctl)
-		caching_ctl = btrfs_get_caching_control(block_group);
-	if (block_group->cached == BTRFS_CACHE_STARTED)
-		btrfs_wait_block_group_cache_done(block_group);
-	if (block_group->has_caching_ctl) {
-		down_write(&fs_info->commit_root_sem);
-		if (!caching_ctl) {
-			struct btrfs_caching_control *ctl;
-
-			list_for_each_entry(ctl,
-				    &fs_info->caching_block_groups, list)
-				if (ctl->block_group == block_group) {
-					caching_ctl = ctl;
-					refcount_inc(&caching_ctl->count);
-					break;
-				}
-		}
-		if (caching_ctl)
-			list_del_init(&caching_ctl->list);
-		up_write(&fs_info->commit_root_sem);
-		if (caching_ctl) {
-			/* Once for the caching bgs list and once for us. */
-			btrfs_put_caching_control(caching_ctl);
-			btrfs_put_caching_control(caching_ctl);
-		}
-	}
-
-	spin_lock(&trans->transaction->dirty_bgs_lock);
-	WARN_ON(!list_empty(&block_group->dirty_list));
-	WARN_ON(!list_empty(&block_group->io_list));
-	spin_unlock(&trans->transaction->dirty_bgs_lock);
-
-	btrfs_remove_free_space_cache(block_group);
-
-	spin_lock(&block_group->space_info->lock);
-	list_del_init(&block_group->ro_list);
-
-	if (btrfs_test_opt(fs_info, ENOSPC_DEBUG)) {
-		WARN_ON(block_group->space_info->total_bytes
-			< block_group->key.offset);
-		WARN_ON(block_group->space_info->bytes_readonly
-			< block_group->key.offset);
-		WARN_ON(block_group->space_info->disk_total
-			< block_group->key.offset * factor);
-	}
-	block_group->space_info->total_bytes -= block_group->key.offset;
-	block_group->space_info->bytes_readonly -= block_group->key.offset;
-	block_group->space_info->disk_total -= block_group->key.offset * factor;
-
-	spin_unlock(&block_group->space_info->lock);
-
-	memcpy(&key, &block_group->key, sizeof(key));
-
-	mutex_lock(&fs_info->chunk_mutex);
-	spin_lock(&block_group->lock);
-	block_group->removed = 1;
-	/*
-	 * At this point trimming can't start on this block group, because we
-	 * removed the block group from the tree fs_info->block_group_cache_tree
-	 * so no one can't find it anymore and even if someone already got this
-	 * block group before we removed it from the rbtree, they have already
-	 * incremented block_group->trimming - if they didn't, they won't find
-	 * any free space entries because we already removed them all when we
-	 * called btrfs_remove_free_space_cache().
-	 *
-	 * And we must not remove the extent map from the fs_info->mapping_tree
-	 * to prevent the same logical address range and physical device space
-	 * ranges from being reused for a new block group. This is because our
-	 * fs trim operation (btrfs_trim_fs() / btrfs_ioctl_fitrim()) is
-	 * completely transactionless, so while it is trimming a range the
-	 * currently running transaction might finish and a new one start,
-	 * allowing for new block groups to be created that can reuse the same
-	 * physical device locations unless we take this special care.
-	 *
-	 * There may also be an implicit trim operation if the file system
-	 * is mounted with -odiscard. The same protections must remain
-	 * in place until the extents have been discarded completely when
-	 * the transaction commit has completed.
-	 */
-	remove_em = (atomic_read(&block_group->trimming) == 0);
-	spin_unlock(&block_group->lock);
-
-	mutex_unlock(&fs_info->chunk_mutex);
-
-	ret = remove_block_group_free_space(trans, block_group);
-	if (ret)
-		goto out;
-
-	btrfs_put_block_group(block_group);
-	btrfs_put_block_group(block_group);
-
-	ret = btrfs_search_slot(trans, root, &key, path, -1, 1);
-	if (ret > 0)
-		ret = -EIO;
-	if (ret < 0)
-		goto out;
-
-	ret = btrfs_del_item(trans, root, path);
-	if (ret)
-		goto out;
-
-	if (remove_em) {
-		struct extent_map_tree *em_tree;
-
-		em_tree = &fs_info->mapping_tree;
-		write_lock(&em_tree->lock);
-		remove_extent_mapping(em_tree, em);
-		write_unlock(&em_tree->lock);
-		/* once for the tree */
-		free_extent_map(em);
-	}
-out:
-	if (remove_rsv)
-		btrfs_delayed_refs_rsv_release(fs_info, 1);
-	btrfs_free_path(path);
-	return ret;
-}
-
-struct btrfs_trans_handle *
-btrfs_start_trans_remove_block_group(struct btrfs_fs_info *fs_info,
-				     const u64 chunk_offset)
-{
-	struct extent_map_tree *em_tree = &fs_info->mapping_tree;
-	struct extent_map *em;
-	struct map_lookup *map;
-	unsigned int num_items;
-
-	read_lock(&em_tree->lock);
-	em = lookup_extent_mapping(em_tree, chunk_offset, 1);
-	read_unlock(&em_tree->lock);
-	ASSERT(em && em->start == chunk_offset);
-
-	/*
-	 * We need to reserve 3 + N units from the metadata space info in order
-	 * to remove a block group (done at btrfs_remove_chunk() and at
-	 * btrfs_remove_block_group()), which are used for:
-	 *
-	 * 1 unit for adding the free space inode's orphan (located in the tree
-	 * of tree roots).
-	 * 1 unit for deleting the block group item (located in the extent
-	 * tree).
-	 * 1 unit for deleting the free space item (located in tree of tree
-	 * roots).
-	 * N units for deleting N device extent items corresponding to each
-	 * stripe (located in the device tree).
-	 *
-	 * In order to remove a block group we also need to reserve units in the
-	 * system space info in order to update the chunk tree (update one or
-	 * more device items and remove one chunk item), but this is done at
-	 * btrfs_remove_chunk() through a call to check_system_chunk().
-	 */
-	map = em->map_lookup;
-	num_items = 3 + map->num_stripes;
-	free_extent_map(em);
-
-	return btrfs_start_transaction_fallback_global_rsv(fs_info->extent_root,
-							   num_items, 1);
-}
-
-/*
- * Process the unused_bgs list and remove any that don't have any allocated
- * space inside of them.
- */
-void btrfs_delete_unused_bgs(struct btrfs_fs_info *fs_info)
-{
-	struct btrfs_block_group_cache *block_group;
-	struct btrfs_space_info *space_info;
-	struct btrfs_trans_handle *trans;
-	int ret = 0;
-
-	if (!test_bit(BTRFS_FS_OPEN, &fs_info->flags))
-		return;
-
-	spin_lock(&fs_info->unused_bgs_lock);
-	while (!list_empty(&fs_info->unused_bgs)) {
-		u64 start, end;
-		int trimming;
-
-		block_group = list_first_entry(&fs_info->unused_bgs,
-					       struct btrfs_block_group_cache,
-					       bg_list);
-		list_del_init(&block_group->bg_list);
-
-		space_info = block_group->space_info;
-
-		if (ret || btrfs_mixed_space_info(space_info)) {
-			btrfs_put_block_group(block_group);
-			continue;
-		}
-		spin_unlock(&fs_info->unused_bgs_lock);
-
-		mutex_lock(&fs_info->delete_unused_bgs_mutex);
-
-		/* Don't want to race with allocators so take the groups_sem */
-		down_write(&space_info->groups_sem);
-		spin_lock(&block_group->lock);
-		if (block_group->reserved || block_group->pinned ||
-		    btrfs_block_group_used(&block_group->item) ||
-		    block_group->ro ||
-		    list_is_singular(&block_group->list)) {
-			/*
-			 * We want to bail if we made new allocations or have
-			 * outstanding allocations in this block group.  We do
-			 * the ro check in case balance is currently acting on
-			 * this block group.
-			 */
-			trace_btrfs_skip_unused_block_group(block_group);
-			spin_unlock(&block_group->lock);
-			up_write(&space_info->groups_sem);
-			goto next;
-		}
-		spin_unlock(&block_group->lock);
-
-		/* We don't want to force the issue, only flip if it's ok. */
-		ret = __btrfs_inc_block_group_ro(block_group, 0);
-		up_write(&space_info->groups_sem);
-		if (ret < 0) {
-			ret = 0;
-			goto next;
-		}
-
-		/*
-		 * Want to do this before we do anything else so we can recover
-		 * properly if we fail to join the transaction.
-		 */
-		trans = btrfs_start_trans_remove_block_group(fs_info,
-						     block_group->key.objectid);
-		if (IS_ERR(trans)) {
-			btrfs_dec_block_group_ro(block_group);
-			ret = PTR_ERR(trans);
-			goto next;
-		}
-
-		/*
-		 * We could have pending pinned extents for this block group,
-		 * just delete them, we don't care about them anymore.
-		 */
-		start = block_group->key.objectid;
-		end = start + block_group->key.offset - 1;
-		/*
-		 * Hold the unused_bg_unpin_mutex lock to avoid racing with
-		 * btrfs_finish_extent_commit(). If we are at transaction N,
-		 * another task might be running finish_extent_commit() for the
-		 * previous transaction N - 1, and have seen a range belonging
-		 * to the block group in freed_extents[] before we were able to
-		 * clear the whole block group range from freed_extents[]. This
-		 * means that task can lookup for the block group after we
-		 * unpinned it from freed_extents[] and removed it, leading to
-		 * a BUG_ON() at btrfs_unpin_extent_range().
-		 */
-		mutex_lock(&fs_info->unused_bg_unpin_mutex);
-		ret = clear_extent_bits(&fs_info->freed_extents[0], start, end,
-				  EXTENT_DIRTY);
-		if (ret) {
-			mutex_unlock(&fs_info->unused_bg_unpin_mutex);
-			btrfs_dec_block_group_ro(block_group);
-			goto end_trans;
-		}
-		ret = clear_extent_bits(&fs_info->freed_extents[1], start, end,
-				  EXTENT_DIRTY);
-		if (ret) {
-			mutex_unlock(&fs_info->unused_bg_unpin_mutex);
-			btrfs_dec_block_group_ro(block_group);
-			goto end_trans;
-		}
-		mutex_unlock(&fs_info->unused_bg_unpin_mutex);
-
-		/* Reset pinned so btrfs_put_block_group doesn't complain */
-		spin_lock(&space_info->lock);
-		spin_lock(&block_group->lock);
-
-		btrfs_space_info_update_bytes_pinned(fs_info, space_info,
-						     -block_group->pinned);
-		space_info->bytes_readonly += block_group->pinned;
-		percpu_counter_add_batch(&space_info->total_bytes_pinned,
-				   -block_group->pinned,
-				   BTRFS_TOTAL_BYTES_PINNED_BATCH);
-		block_group->pinned = 0;
-
-		spin_unlock(&block_group->lock);
-		spin_unlock(&space_info->lock);
-
-		/* DISCARD can flip during remount */
-		trimming = btrfs_test_opt(fs_info, DISCARD);
-
-		/* Implicit trim during transaction commit. */
-		if (trimming)
-			btrfs_get_block_group_trimming(block_group);
-
-		/*
-		 * Btrfs_remove_chunk will abort the transaction if things go
-		 * horribly wrong.
-		 */
-		ret = btrfs_remove_chunk(trans, block_group->key.objectid);
-
-		if (ret) {
-			if (trimming)
-				btrfs_put_block_group_trimming(block_group);
-			goto end_trans;
-		}
-
-		/*
-		 * If we're not mounted with -odiscard, we can just forget
-		 * about this block group. Otherwise we'll need to wait
-		 * until transaction commit to do the actual discard.
-		 */
-		if (trimming) {
-			spin_lock(&fs_info->unused_bgs_lock);
-			/*
-			 * A concurrent scrub might have added us to the list
-			 * fs_info->unused_bgs, so use a list_move operation
-			 * to add the block group to the deleted_bgs list.
-			 */
-			list_move(&block_group->bg_list,
-				  &trans->transaction->deleted_bgs);
-			spin_unlock(&fs_info->unused_bgs_lock);
-			btrfs_get_block_group(block_group);
-		}
-end_trans:
-		btrfs_end_transaction(trans);
-next:
-		mutex_unlock(&fs_info->delete_unused_bgs_mutex);
-		btrfs_put_block_group(block_group);
-		spin_lock(&fs_info->unused_bgs_lock);
-	}
-	spin_unlock(&fs_info->unused_bgs_lock);
-}
-
 int btrfs_error_unpin_extent_range(struct btrfs_fs_info *fs_info,
 				   u64 start, u64 end)
 {
@@ -8370,16 +7846,3 @@ int btrfs_trim_fs(struct btrfs_fs_info *fs_info, struct fstrim_range *range)
  * operations while snapshotting is ongoing and that cause the snapshot to be
  * inconsistent (writes followed by expanding truncates for example).
  */
-
-void btrfs_mark_bg_unused(struct btrfs_block_group_cache *bg)
-{
-	struct btrfs_fs_info *fs_info = bg->fs_info;
-
-	spin_lock(&fs_info->unused_bgs_lock);
-	if (list_empty(&bg->bg_list)) {
-		btrfs_get_block_group(bg);
-		trace_btrfs_add_unused_block_group(bg);
-		list_add_tail(&bg->bg_list, &fs_info->unused_bgs);
-	}
-	spin_unlock(&fs_info->unused_bgs_lock);
-}
-- 
2.21.0

