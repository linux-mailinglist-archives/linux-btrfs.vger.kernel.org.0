Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4F872C550D
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Nov 2020 14:12:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390078AbgKZNKq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 26 Nov 2020 08:10:46 -0500
Received: from mx2.suse.de ([195.135.220.15]:58940 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389868AbgKZNKp (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 26 Nov 2020 08:10:45 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1606396242; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=C3hSf4d/90nT3M9khltGXtNLFPNkVvx1q7X7L209MjI=;
        b=AocscKWj3CwrnwwMLHwJ0hOfArBjs651FRhm4iawBgiBmZvpkV0sWwwU6WDg0Levi5QX0U
        XXyqJU2jzgzmYpcOyDcm4qEXC5vxd+Es8oVf06+czpQXEB2lhrx/TQiB1InZ77Kb3Ef4kK
        zIMmt+RyYUy04Lt5lNTMG5uHqTfE9FQ=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id EAEDAAD89;
        Thu, 26 Nov 2020 13:10:41 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 3/3] btrfs: Remove inode cache feature
Date:   Thu, 26 Nov 2020 15:10:39 +0200
Message-Id: <20201126131039.3441290-4-nborisov@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201126131039.3441290-1-nborisov@suse.com>
References: <20201126131039.3441290-1-nborisov@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

It's been deprecated and never really used so simply remove it.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/Makefile           |   2 +-
 fs/btrfs/ctree.h            |  15 +-
 fs/btrfs/disk-io.c          |  23 --
 fs/btrfs/free-space-cache.c | 177 ------------
 fs/btrfs/free-space-cache.h |   6 -
 fs/btrfs/inode-map.c        | 527 ------------------------------------
 fs/btrfs/inode-map.h        |  14 -
 fs/btrfs/inode.c            |  11 -
 fs/btrfs/ioctl.c            |   1 -
 fs/btrfs/relocation.c       |   1 -
 fs/btrfs/super.c            |   8 -
 fs/btrfs/transaction.c      |  19 --
 fs/btrfs/tree-log.c         |   1 -
 13 files changed, 3 insertions(+), 802 deletions(-)
 delete mode 100644 fs/btrfs/inode-map.c
 delete mode 100644 fs/btrfs/inode-map.h

diff --git a/fs/btrfs/Makefile b/fs/btrfs/Makefile
index e738f6206ea5..b8290e0f62e2 100644
--- a/fs/btrfs/Makefile
+++ b/fs/btrfs/Makefile
@@ -3,7 +3,7 @@
 obj-$(CONFIG_BTRFS_FS) := btrfs.o
 
 btrfs-y += super.o ctree.o extent-tree.o print-tree.o root-tree.o dir-item.o \
-	   file-item.o inode-item.o inode-map.o disk-io.o \
+	   file-item.o inode-item.o disk-io.o \
 	   transaction.o inode.o file.o tree-defrag.o \
 	   extent_map.o sysfs.o struct-funcs.o xattr.o ordered-data.o \
 	   extent_io.o volumes.o async-thread.o ioctl.o locking.o orphan.o \
diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 9a186b2433ac..5e2eeadedbe5 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -1066,15 +1066,6 @@ struct btrfs_root {
 	spinlock_t accounting_lock;
 	struct btrfs_block_rsv *block_rsv;
 
-	/* free ino cache stuff */
-	struct btrfs_free_space_ctl *free_ino_ctl;
-	enum btrfs_caching_type ino_cache_state;
-	spinlock_t ino_cache_lock;
-	wait_queue_head_t ino_cache_wait;
-	struct btrfs_free_space_ctl *free_ino_pinned;
-	u64 ino_cache_progress;
-	struct inode *ino_cache_inode;
-
 	struct mutex log_mutex;
 	wait_queue_head_t log_writer_wait;
 	wait_queue_head_t log_commit_wait[2];
@@ -1348,7 +1339,7 @@ static inline u32 BTRFS_MAX_XATTR_SIZE(const struct btrfs_fs_info *info)
 #define BTRFS_MOUNT_USER_SUBVOL_RM_ALLOWED (1 << 14)
 #define BTRFS_MOUNT_ENOSPC_DEBUG	 (1 << 15)
 #define BTRFS_MOUNT_AUTO_DEFRAG		(1 << 16)
-#define BTRFS_MOUNT_INODE_MAP_CACHE	(1 << 17)
+/* bit 17 is free */
 #define BTRFS_MOUNT_USEBACKUPROOT	(1 << 18)
 #define BTRFS_MOUNT_SKIP_BALANCE	(1 << 19)
 #define BTRFS_MOUNT_CHECK_INTEGRITY	(1 << 20)
@@ -1395,9 +1386,7 @@ do {									\
  * transaction commit)
  */
 
-#define BTRFS_PENDING_SET_INODE_MAP_CACHE	(0)
-#define BTRFS_PENDING_CLEAR_INODE_MAP_CACHE	(1)
-#define BTRFS_PENDING_COMMIT			(2)
+#define BTRFS_PENDING_COMMIT			(0)
 
 #define btrfs_test_pending(info, opt)	\
 	test_bit(BTRFS_PENDING_##opt, &(info)->pending_changes)
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index f97ed0dc179d..6d8cd9fef1ea 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -29,7 +29,6 @@
 #include "tree-log.h"
 #include "free-space-cache.h"
 #include "free-space-tree.h"
-#include "inode-map.h"
 #include "check-integrity.h"
 #include "rcu-string.h"
 #include "dev-replace.h"
@@ -1335,14 +1334,6 @@ static int btrfs_init_fs_root(struct btrfs_root *root, dev_t anon_dev)
 	int ret;
 	unsigned int nofs_flag;
 
-	root->free_ino_ctl = kzalloc(sizeof(*root->free_ino_ctl), GFP_NOFS);
-	root->free_ino_pinned = kzalloc(sizeof(*root->free_ino_pinned),
-					GFP_NOFS);
-	if (!root->free_ino_pinned || !root->free_ino_ctl) {
-		ret = -ENOMEM;
-		goto fail;
-	}
-
 	/*
 	 * We might be called under a transaction (e.g. indirect backref
 	 * resolution) which could deadlock if it triggers memory reclaim
@@ -1359,10 +1350,6 @@ static int btrfs_init_fs_root(struct btrfs_root *root, dev_t anon_dev)
 		btrfs_check_and_init_root_item(&root->root_item);
 	}
 
-	btrfs_init_free_ino_ctl(root);
-	spin_lock_init(&root->ino_cache_lock);
-	init_waitqueue_head(&root->ino_cache_wait);
-
 	/*
 	 * Don't assign anonymous block device to roots that are not exposed to
 	 * userspace, the id pool is limited to 1M
@@ -2032,8 +2019,6 @@ void btrfs_put_root(struct btrfs_root *root)
 			free_anon_bdev(root->anon_dev);
 		btrfs_drew_lock_destroy(&root->snapshot_lock);
 		free_root_extent_buffers(root);
-		kfree(root->free_ino_ctl);
-		kfree(root->free_ino_pinned);
 #ifdef CONFIG_BTRFS_DEBUG
 		spin_lock(&root->fs_info->fs_roots_radix_lock);
 		list_del_init(&root->leak_list);
@@ -3950,14 +3935,6 @@ void btrfs_drop_and_free_fs_root(struct btrfs_fs_info *fs_info,
 		}
 	}
 
-	if (root->free_ino_pinned)
-		__btrfs_remove_free_space_cache(root->free_ino_pinned);
-	if (root->free_ino_ctl)
-		__btrfs_remove_free_space_cache(root->free_ino_ctl);
-	if (root->ino_cache_inode) {
-		iput(root->ino_cache_inode);
-		root->ino_cache_inode = NULL;
-	}
 	if (drop_ref)
 		btrfs_put_root(root);
 }
diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index 572c75d2169b..7d1ceeeb3067 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -16,7 +16,6 @@
 #include "transaction.h"
 #include "disk-io.h"
 #include "extent_io.h"
-#include "inode-map.h"
 #include "volumes.h"
 #include "space-info.h"
 #include "delalloc-space.h"
@@ -37,10 +36,6 @@ static int link_free_space(struct btrfs_free_space_ctl *ctl,
 			   struct btrfs_free_space *info);
 static void unlink_free_space(struct btrfs_free_space_ctl *ctl,
 			      struct btrfs_free_space *info);
-static int btrfs_wait_cache_io_root(struct btrfs_root *root,
-			     struct btrfs_trans_handle *trans,
-			     struct btrfs_io_ctl *io_ctl,
-			     struct btrfs_path *path);
 static int search_bitmap(struct btrfs_free_space_ctl *ctl,
 			 struct btrfs_free_space *bitmap_info, u64 *offset,
 			 u64 *bytes, bool for_alloc);
@@ -1222,14 +1217,6 @@ static int __btrfs_wait_cache_io(struct btrfs_root *root,
 
 }
 
-static int btrfs_wait_cache_io_root(struct btrfs_root *root,
-				    struct btrfs_trans_handle *trans,
-				    struct btrfs_io_ctl *io_ctl,
-				    struct btrfs_path *path)
-{
-	return __btrfs_wait_cache_io(root, trans, NULL, io_ctl, path, 0);
-}
-
 int btrfs_wait_cache_io(struct btrfs_trans_handle *trans,
 			struct btrfs_block_group *block_group,
 			struct btrfs_path *path)
@@ -3807,170 +3794,6 @@ int btrfs_trim_block_group_bitmaps(struct btrfs_block_group *block_group,
 	return ret;
 }
 
-/*
- * Find the left-most item in the cache tree, and then return the
- * smallest inode number in the item.
- *
- * Note: the returned inode number may not be the smallest one in
- * the tree, if the left-most item is a bitmap.
- */
-u64 btrfs_find_ino_for_alloc(struct btrfs_root *fs_root)
-{
-	struct btrfs_free_space_ctl *ctl = fs_root->free_ino_ctl;
-	struct btrfs_free_space *entry = NULL;
-	u64 ino = 0;
-
-	spin_lock(&ctl->tree_lock);
-
-	if (RB_EMPTY_ROOT(&ctl->free_space_offset))
-		goto out;
-
-	entry = rb_entry(rb_first(&ctl->free_space_offset),
-			 struct btrfs_free_space, offset_index);
-
-	if (!entry->bitmap) {
-		ino = entry->offset;
-
-		unlink_free_space(ctl, entry);
-		entry->offset++;
-		entry->bytes--;
-		if (!entry->bytes)
-			kmem_cache_free(btrfs_free_space_cachep, entry);
-		else
-			link_free_space(ctl, entry);
-	} else {
-		u64 offset = 0;
-		u64 count = 1;
-		int ret;
-
-		ret = search_bitmap(ctl, entry, &offset, &count, true);
-		/* Logic error; Should be empty if it can't find anything */
-		ASSERT(!ret);
-
-		ino = offset;
-		bitmap_clear_bits(ctl, entry, offset, 1);
-		if (entry->bytes == 0)
-			free_bitmap(ctl, entry);
-	}
-out:
-	spin_unlock(&ctl->tree_lock);
-
-	return ino;
-}
-
-struct inode *lookup_free_ino_inode(struct btrfs_root *root,
-				    struct btrfs_path *path)
-{
-	struct inode *inode = NULL;
-
-	spin_lock(&root->ino_cache_lock);
-	if (root->ino_cache_inode)
-		inode = igrab(root->ino_cache_inode);
-	spin_unlock(&root->ino_cache_lock);
-	if (inode)
-		return inode;
-
-	inode = __lookup_free_space_inode(root, path, 0);
-	if (IS_ERR(inode))
-		return inode;
-
-	spin_lock(&root->ino_cache_lock);
-	if (!btrfs_fs_closing(root->fs_info))
-		root->ino_cache_inode = igrab(inode);
-	spin_unlock(&root->ino_cache_lock);
-
-	return inode;
-}
-
-int create_free_ino_inode(struct btrfs_root *root,
-			  struct btrfs_trans_handle *trans,
-			  struct btrfs_path *path)
-{
-	return __create_free_space_inode(root, trans, path,
-					 BTRFS_FREE_INO_OBJECTID, 0);
-}
-
-int load_free_ino_cache(struct btrfs_fs_info *fs_info, struct btrfs_root *root)
-{
-	struct btrfs_free_space_ctl *ctl = root->free_ino_ctl;
-	struct btrfs_path *path;
-	struct inode *inode;
-	int ret = 0;
-	u64 root_gen = btrfs_root_generation(&root->root_item);
-
-	if (!btrfs_test_opt(fs_info, INODE_MAP_CACHE))
-		return 0;
-
-	/*
-	 * If we're unmounting then just return, since this does a search on the
-	 * normal root and not the commit root and we could deadlock.
-	 */
-	if (btrfs_fs_closing(fs_info))
-		return 0;
-
-	path = btrfs_alloc_path();
-	if (!path)
-		return 0;
-
-	inode = lookup_free_ino_inode(root, path);
-	if (IS_ERR(inode))
-		goto out;
-
-	if (root_gen != BTRFS_I(inode)->generation)
-		goto out_put;
-
-	ret = __load_free_space_cache(root, inode, ctl, path, 0);
-
-	if (ret < 0)
-		btrfs_err(fs_info,
-			"failed to load free ino cache for root %llu",
-			root->root_key.objectid);
-out_put:
-	iput(inode);
-out:
-	btrfs_free_path(path);
-	return ret;
-}
-
-int btrfs_write_out_ino_cache(struct btrfs_root *root,
-			      struct btrfs_trans_handle *trans,
-			      struct btrfs_path *path,
-			      struct inode *inode)
-{
-	struct btrfs_fs_info *fs_info = root->fs_info;
-	struct btrfs_free_space_ctl *ctl = root->free_ino_ctl;
-	int ret;
-	struct btrfs_io_ctl io_ctl;
-	bool release_metadata = true;
-
-	if (!btrfs_test_opt(fs_info, INODE_MAP_CACHE))
-		return 0;
-
-	memset(&io_ctl, 0, sizeof(io_ctl));
-	ret = __btrfs_write_out_cache(root, inode, ctl, NULL, &io_ctl, trans);
-	if (!ret) {
-		/*
-		 * At this point writepages() didn't error out, so our metadata
-		 * reservation is released when the writeback finishes, at
-		 * inode.c:btrfs_finish_ordered_io(), regardless of it finishing
-		 * with or without an error.
-		 */
-		release_metadata = false;
-		ret = btrfs_wait_cache_io_root(root, trans, &io_ctl, path);
-	}
-
-	if (ret) {
-		if (release_metadata)
-			btrfs_delalloc_release_metadata(BTRFS_I(inode),
-					inode->i_size, true);
-		btrfs_debug(fs_info,
-			  "failed to write free ino cache for root %llu error %d",
-			  root->root_key.objectid, ret);
-	}
-
-	return ret;
-}
-
 #ifdef CONFIG_BTRFS_FS_RUN_SANITY_TESTS
 /*
  * Use this if you need to make a bitmap or extent entry specifically, it
diff --git a/fs/btrfs/free-space-cache.h b/fs/btrfs/free-space-cache.h
index bf8d127d2407..50d6ce1b25eb 100644
--- a/fs/btrfs/free-space-cache.h
+++ b/fs/btrfs/free-space-cache.h
@@ -99,11 +99,6 @@ int btrfs_write_out_cache(struct btrfs_trans_handle *trans,
 			  struct btrfs_path *path);
 struct inode *lookup_free_ino_inode(struct btrfs_root *root,
 				    struct btrfs_path *path);
-int create_free_ino_inode(struct btrfs_root *root,
-			  struct btrfs_trans_handle *trans,
-			  struct btrfs_path *path);
-int load_free_ino_cache(struct btrfs_fs_info *fs_info,
-			struct btrfs_root *root);
 int btrfs_write_out_ino_cache(struct btrfs_root *root,
 			      struct btrfs_trans_handle *trans,
 			      struct btrfs_path *path,
@@ -127,7 +122,6 @@ bool btrfs_is_free_space_trimmed(struct btrfs_block_group *block_group);
 u64 btrfs_find_space_for_alloc(struct btrfs_block_group *block_group,
 			       u64 offset, u64 bytes, u64 empty_size,
 			       u64 *max_extent_size);
-u64 btrfs_find_ino_for_alloc(struct btrfs_root *fs_root);
 void btrfs_dump_free_space(struct btrfs_block_group *block_group,
 			   u64 bytes);
 int btrfs_find_space_cluster(struct btrfs_block_group *block_group,
diff --git a/fs/btrfs/inode-map.c b/fs/btrfs/inode-map.c
deleted file mode 100644
index 2bc342fc5d7e..000000000000
--- a/fs/btrfs/inode-map.c
+++ /dev/null
@@ -1,527 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Copyright (C) 2007 Oracle.  All rights reserved.
- */
-
-#include <linux/kthread.h>
-#include <linux/pagemap.h>
-
-#include "ctree.h"
-#include "disk-io.h"
-#include "free-space-cache.h"
-#include "inode-map.h"
-#include "transaction.h"
-#include "delalloc-space.h"
-
-static void fail_caching_thread(struct btrfs_root *root)
-{
-	struct btrfs_fs_info *fs_info = root->fs_info;
-
-	btrfs_warn(fs_info, "failed to start inode caching task");
-	btrfs_clear_pending_and_info(fs_info, INODE_MAP_CACHE,
-				     "disabling inode map caching");
-	spin_lock(&root->ino_cache_lock);
-	root->ino_cache_state = BTRFS_CACHE_ERROR;
-	spin_unlock(&root->ino_cache_lock);
-	wake_up(&root->ino_cache_wait);
-}
-
-static int caching_kthread(void *data)
-{
-	struct btrfs_root *root = data;
-	struct btrfs_fs_info *fs_info = root->fs_info;
-	struct btrfs_free_space_ctl *ctl = root->free_ino_ctl;
-	struct btrfs_key key;
-	struct btrfs_path *path;
-	struct extent_buffer *leaf;
-	u64 last = (u64)-1;
-	int slot;
-	int ret;
-
-	if (!btrfs_test_opt(fs_info, INODE_MAP_CACHE))
-		return 0;
-
-	path = btrfs_alloc_path();
-	if (!path) {
-		fail_caching_thread(root);
-		return -ENOMEM;
-	}
-
-	/* Since the commit root is read-only, we can safely skip locking. */
-	path->skip_locking = 1;
-	path->search_commit_root = 1;
-	path->reada = READA_FORWARD;
-
-	key.objectid = BTRFS_FIRST_FREE_OBJECTID;
-	key.offset = 0;
-	key.type = BTRFS_INODE_ITEM_KEY;
-again:
-	/* need to make sure the commit_root doesn't disappear */
-	down_read(&fs_info->commit_root_sem);
-
-	ret = btrfs_search_slot(NULL, root, &key, path, 0, 0);
-	if (ret < 0)
-		goto out;
-
-	while (1) {
-		if (btrfs_fs_closing(fs_info))
-			goto out;
-
-		leaf = path->nodes[0];
-		slot = path->slots[0];
-		if (slot >= btrfs_header_nritems(leaf)) {
-			ret = btrfs_next_leaf(root, path);
-			if (ret < 0)
-				goto out;
-			else if (ret > 0)
-				break;
-
-			if (need_resched() ||
-			    btrfs_transaction_in_commit(fs_info)) {
-				leaf = path->nodes[0];
-
-				if (WARN_ON(btrfs_header_nritems(leaf) == 0))
-					break;
-
-				/*
-				 * Save the key so we can advances forward
-				 * in the next search.
-				 */
-				btrfs_item_key_to_cpu(leaf, &key, 0);
-				btrfs_release_path(path);
-				root->ino_cache_progress = last;
-				up_read(&fs_info->commit_root_sem);
-				schedule_timeout(1);
-				goto again;
-			} else
-				continue;
-		}
-
-		btrfs_item_key_to_cpu(leaf, &key, slot);
-
-		if (key.type != BTRFS_INODE_ITEM_KEY)
-			goto next;
-
-		if (key.objectid >= root->highest_objectid)
-			break;
-
-		if (last != (u64)-1 && last + 1 != key.objectid) {
-			__btrfs_add_free_space(fs_info, ctl, last + 1,
-					       key.objectid - last - 1, 0);
-			wake_up(&root->ino_cache_wait);
-		}
-
-		last = key.objectid;
-next:
-		path->slots[0]++;
-	}
-
-	if (last < root->highest_objectid - 1) {
-		__btrfs_add_free_space(fs_info, ctl, last + 1,
-				       root->highest_objectid - last - 1, 0);
-	}
-
-	spin_lock(&root->ino_cache_lock);
-	root->ino_cache_state = BTRFS_CACHE_FINISHED;
-	spin_unlock(&root->ino_cache_lock);
-
-	root->ino_cache_progress = (u64)-1;
-	btrfs_unpin_free_ino(root);
-out:
-	wake_up(&root->ino_cache_wait);
-	up_read(&fs_info->commit_root_sem);
-
-	btrfs_free_path(path);
-
-	return ret;
-}
-
-static void start_caching(struct btrfs_root *root)
-{
-	struct btrfs_fs_info *fs_info = root->fs_info;
-	struct btrfs_free_space_ctl *ctl = root->free_ino_ctl;
-	struct task_struct *tsk;
-	int ret;
-	u64 objectid;
-
-	if (!btrfs_test_opt(fs_info, INODE_MAP_CACHE))
-		return;
-
-	spin_lock(&root->ino_cache_lock);
-	if (root->ino_cache_state != BTRFS_CACHE_NO) {
-		spin_unlock(&root->ino_cache_lock);
-		return;
-	}
-
-	root->ino_cache_state = BTRFS_CACHE_STARTED;
-	spin_unlock(&root->ino_cache_lock);
-
-	ret = load_free_ino_cache(fs_info, root);
-	if (ret == 1) {
-		spin_lock(&root->ino_cache_lock);
-		root->ino_cache_state = BTRFS_CACHE_FINISHED;
-		spin_unlock(&root->ino_cache_lock);
-		wake_up(&root->ino_cache_wait);
-		return;
-	}
-
-	/*
-	 * It can be quite time-consuming to fill the cache by searching
-	 * through the extent tree, and this can keep ino allocation path
-	 * waiting. Therefore at start we quickly find out the highest
-	 * inode number and we know we can use inode numbers which fall in
-	 * [highest_ino + 1, BTRFS_LAST_FREE_OBJECTID].
-	 */
-	ret = btrfs_find_free_objectid(root, &objectid);
-	if (!ret && objectid <= BTRFS_LAST_FREE_OBJECTID) {
-		__btrfs_add_free_space(fs_info, ctl, objectid,
-				       BTRFS_LAST_FREE_OBJECTID - objectid + 1,
-				       0);
-		wake_up(&root->ino_cache_wait);
-	}
-
-	tsk = kthread_run(caching_kthread, root, "btrfs-ino-cache-%llu",
-			  root->root_key.objectid);
-	if (IS_ERR(tsk))
-		fail_caching_thread(root);
-}
-
-int btrfs_find_free_ino(struct btrfs_root *root, u64 *objectid)
-{
-	if (!btrfs_test_opt(root->fs_info, INODE_MAP_CACHE))
-		return btrfs_find_free_objectid(root, objectid);
-
-again:
-	*objectid = btrfs_find_ino_for_alloc(root);
-
-	if (*objectid != 0)
-		return 0;
-
-	start_caching(root);
-
-	wait_event(root->ino_cache_wait,
-		   root->ino_cache_state == BTRFS_CACHE_FINISHED ||
-		   root->ino_cache_state == BTRFS_CACHE_ERROR ||
-		   root->free_ino_ctl->free_space > 0);
-
-	if (root->ino_cache_state == BTRFS_CACHE_FINISHED &&
-	    root->free_ino_ctl->free_space == 0)
-		return -ENOSPC;
-	else if (root->ino_cache_state == BTRFS_CACHE_ERROR)
-		return btrfs_find_free_objectid(root, objectid);
-	else
-		goto again;
-}
-
-void btrfs_return_ino(struct btrfs_root *root, u64 objectid)
-{
-	struct btrfs_fs_info *fs_info = root->fs_info;
-	struct btrfs_free_space_ctl *pinned = root->free_ino_pinned;
-
-	if (!btrfs_test_opt(fs_info, INODE_MAP_CACHE))
-		return;
-again:
-	if (root->ino_cache_state == BTRFS_CACHE_FINISHED) {
-		__btrfs_add_free_space(fs_info, pinned, objectid, 1, 0);
-	} else {
-		down_write(&fs_info->commit_root_sem);
-		spin_lock(&root->ino_cache_lock);
-		if (root->ino_cache_state == BTRFS_CACHE_FINISHED) {
-			spin_unlock(&root->ino_cache_lock);
-			up_write(&fs_info->commit_root_sem);
-			goto again;
-		}
-		spin_unlock(&root->ino_cache_lock);
-
-		start_caching(root);
-
-		__btrfs_add_free_space(fs_info, pinned, objectid, 1, 0);
-
-		up_write(&fs_info->commit_root_sem);
-	}
-}
-
-/*
- * When a transaction is committed, we'll move those inode numbers which are
- * smaller than root->ino_cache_progress from pinned tree to free_ino tree, and
- * others will just be dropped, because the commit root we were searching has
- * changed.
- *
- * Must be called with root->fs_info->commit_root_sem held
- */
-void btrfs_unpin_free_ino(struct btrfs_root *root)
-{
-	struct btrfs_free_space_ctl *ctl = root->free_ino_ctl;
-	struct rb_root *rbroot = &root->free_ino_pinned->free_space_offset;
-	spinlock_t *rbroot_lock = &root->free_ino_pinned->tree_lock;
-	struct btrfs_free_space *info;
-	struct rb_node *n;
-	u64 count;
-
-	if (!btrfs_test_opt(root->fs_info, INODE_MAP_CACHE))
-		return;
-
-	while (1) {
-		spin_lock(rbroot_lock);
-		n = rb_first(rbroot);
-		if (!n) {
-			spin_unlock(rbroot_lock);
-			break;
-		}
-
-		info = rb_entry(n, struct btrfs_free_space, offset_index);
-		BUG_ON(info->bitmap); /* Logic error */
-
-		if (info->offset > root->ino_cache_progress)
-			count = 0;
-		else
-			count = min(root->ino_cache_progress - info->offset + 1,
-				    info->bytes);
-
-		rb_erase(&info->offset_index, rbroot);
-		spin_unlock(rbroot_lock);
-		if (count)
-			__btrfs_add_free_space(root->fs_info, ctl,
-					       info->offset, count, 0);
-		kmem_cache_free(btrfs_free_space_cachep, info);
-	}
-}
-
-#define INIT_THRESHOLD	((SZ_32K / 2) / sizeof(struct btrfs_free_space))
-#define INODES_PER_BITMAP (PAGE_SIZE * 8)
-
-/*
- * The goal is to keep the memory used by the free_ino tree won't
- * exceed the memory if we use bitmaps only.
- */
-static void recalculate_thresholds(struct btrfs_free_space_ctl *ctl)
-{
-	struct btrfs_free_space *info;
-	struct rb_node *n;
-	int max_ino;
-	int max_bitmaps;
-
-	n = rb_last(&ctl->free_space_offset);
-	if (!n) {
-		ctl->extents_thresh = INIT_THRESHOLD;
-		return;
-	}
-	info = rb_entry(n, struct btrfs_free_space, offset_index);
-
-	/*
-	 * Find the maximum inode number in the filesystem. Note we
-	 * ignore the fact that this can be a bitmap, because we are
-	 * not doing precise calculation.
-	 */
-	max_ino = info->bytes - 1;
-
-	max_bitmaps = ALIGN(max_ino, INODES_PER_BITMAP) / INODES_PER_BITMAP;
-	if (max_bitmaps <= ctl->total_bitmaps) {
-		ctl->extents_thresh = 0;
-		return;
-	}
-
-	ctl->extents_thresh = (max_bitmaps - ctl->total_bitmaps) *
-				PAGE_SIZE / sizeof(*info);
-}
-
-/*
- * We don't fall back to bitmap, if we are below the extents threshold
- * or this chunk of inode numbers is a big one.
- */
-static bool use_bitmap(struct btrfs_free_space_ctl *ctl,
-		       struct btrfs_free_space *info)
-{
-	if (ctl->free_extents < ctl->extents_thresh ||
-	    info->bytes > INODES_PER_BITMAP / 10)
-		return false;
-
-	return true;
-}
-
-static const struct btrfs_free_space_op free_ino_op = {
-	.recalc_thresholds	= recalculate_thresholds,
-	.use_bitmap		= use_bitmap,
-};
-
-static void pinned_recalc_thresholds(struct btrfs_free_space_ctl *ctl)
-{
-}
-
-static bool pinned_use_bitmap(struct btrfs_free_space_ctl *ctl,
-			      struct btrfs_free_space *info)
-{
-	/*
-	 * We always use extents for two reasons:
-	 *
-	 * - The pinned tree is only used during the process of caching
-	 *   work.
-	 * - Make code simpler. See btrfs_unpin_free_ino().
-	 */
-	return false;
-}
-
-static const struct btrfs_free_space_op pinned_free_ino_op = {
-	.recalc_thresholds	= pinned_recalc_thresholds,
-	.use_bitmap		= pinned_use_bitmap,
-};
-
-void btrfs_init_free_ino_ctl(struct btrfs_root *root)
-{
-	struct btrfs_free_space_ctl *ctl = root->free_ino_ctl;
-	struct btrfs_free_space_ctl *pinned = root->free_ino_pinned;
-
-	spin_lock_init(&ctl->tree_lock);
-	ctl->unit = 1;
-	ctl->start = 0;
-	ctl->private = NULL;
-	ctl->op = &free_ino_op;
-	INIT_LIST_HEAD(&ctl->trimming_ranges);
-	mutex_init(&ctl->cache_writeout_mutex);
-
-	/*
-	 * Initially we allow to use 16K of ram to cache chunks of
-	 * inode numbers before we resort to bitmaps. This is somewhat
-	 * arbitrary, but it will be adjusted in runtime.
-	 */
-	ctl->extents_thresh = INIT_THRESHOLD;
-
-	spin_lock_init(&pinned->tree_lock);
-	pinned->unit = 1;
-	pinned->start = 0;
-	pinned->private = NULL;
-	pinned->extents_thresh = 0;
-	pinned->op = &pinned_free_ino_op;
-}
-
-int btrfs_save_ino_cache(struct btrfs_root *root,
-			 struct btrfs_trans_handle *trans)
-{
-	struct btrfs_fs_info *fs_info = root->fs_info;
-	struct btrfs_free_space_ctl *ctl = root->free_ino_ctl;
-	struct btrfs_path *path;
-	struct inode *inode;
-	struct btrfs_block_rsv *rsv;
-	struct extent_changeset *data_reserved = NULL;
-	u64 num_bytes;
-	u64 alloc_hint = 0;
-	int ret;
-	int prealloc;
-	bool retry = false;
-
-	/* only fs tree and subvol/snap needs ino cache */
-	if (root->root_key.objectid != BTRFS_FS_TREE_OBJECTID &&
-	    (root->root_key.objectid < BTRFS_FIRST_FREE_OBJECTID ||
-	     root->root_key.objectid > BTRFS_LAST_FREE_OBJECTID))
-		return 0;
-
-	/* Don't save inode cache if we are deleting this root */
-	if (btrfs_root_refs(&root->root_item) == 0)
-		return 0;
-
-	if (!btrfs_test_opt(fs_info, INODE_MAP_CACHE))
-		return 0;
-
-	path = btrfs_alloc_path();
-	if (!path)
-		return -ENOMEM;
-
-	rsv = trans->block_rsv;
-	trans->block_rsv = &fs_info->trans_block_rsv;
-
-	num_bytes = trans->bytes_reserved;
-	/*
-	 * 1 item for inode item insertion if need
-	 * 4 items for inode item update (in the worst case)
-	 * 1 items for slack space if we need do truncation
-	 * 1 item for free space object
-	 * 3 items for pre-allocation
-	 */
-	trans->bytes_reserved = btrfs_calc_insert_metadata_size(fs_info, 10);
-	ret = btrfs_block_rsv_add(root, trans->block_rsv,
-				  trans->bytes_reserved,
-				  BTRFS_RESERVE_NO_FLUSH);
-	if (ret)
-		goto out;
-	trace_btrfs_space_reservation(fs_info, "ino_cache", trans->transid,
-				      trans->bytes_reserved, 1);
-again:
-	inode = lookup_free_ino_inode(root, path);
-	if (IS_ERR(inode) && (PTR_ERR(inode) != -ENOENT || retry)) {
-		ret = PTR_ERR(inode);
-		goto out_release;
-	}
-
-	if (IS_ERR(inode)) {
-		BUG_ON(retry); /* Logic error */
-		retry = true;
-
-		ret = create_free_ino_inode(root, trans, path);
-		if (ret)
-			goto out_release;
-		goto again;
-	}
-
-	BTRFS_I(inode)->generation = 0;
-	ret = btrfs_update_inode(trans, root, BTRFS_I(inode));
-	if (ret) {
-		btrfs_abort_transaction(trans, ret);
-		goto out_put;
-	}
-
-	if (i_size_read(inode) > 0) {
-		ret = btrfs_truncate_free_space_cache(trans, NULL, inode);
-		if (ret) {
-			if (ret != -ENOSPC)
-				btrfs_abort_transaction(trans, ret);
-			goto out_put;
-		}
-	}
-
-	spin_lock(&root->ino_cache_lock);
-	if (root->ino_cache_state != BTRFS_CACHE_FINISHED) {
-		ret = -1;
-		spin_unlock(&root->ino_cache_lock);
-		goto out_put;
-	}
-	spin_unlock(&root->ino_cache_lock);
-
-	spin_lock(&ctl->tree_lock);
-	prealloc = sizeof(struct btrfs_free_space) * ctl->free_extents;
-	prealloc = ALIGN(prealloc, PAGE_SIZE);
-	prealloc += ctl->total_bitmaps * PAGE_SIZE;
-	spin_unlock(&ctl->tree_lock);
-
-	/* Just to make sure we have enough space */
-	prealloc += 8 * PAGE_SIZE;
-
-	ret = btrfs_delalloc_reserve_space(BTRFS_I(inode), &data_reserved, 0,
-					   prealloc);
-	if (ret)
-		goto out_put;
-
-	ret = btrfs_prealloc_file_range_trans(inode, trans, 0, 0, prealloc,
-					      prealloc, prealloc, &alloc_hint);
-	if (ret) {
-		btrfs_delalloc_release_extents(BTRFS_I(inode), prealloc);
-		btrfs_delalloc_release_metadata(BTRFS_I(inode), prealloc, true);
-		goto out_put;
-	}
-
-	ret = btrfs_write_out_ino_cache(root, trans, path, inode);
-	btrfs_delalloc_release_extents(BTRFS_I(inode), prealloc);
-out_put:
-	iput(inode);
-out_release:
-	trace_btrfs_space_reservation(fs_info, "ino_cache", trans->transid,
-				      trans->bytes_reserved, 0);
-	btrfs_block_rsv_release(fs_info, trans->block_rsv,
-				trans->bytes_reserved, NULL);
-out:
-	trans->block_rsv = rsv;
-	trans->bytes_reserved = num_bytes;
-
-	btrfs_free_path(path);
-	extent_changeset_free(data_reserved);
-	return ret;
-}
diff --git a/fs/btrfs/inode-map.h b/fs/btrfs/inode-map.h
deleted file mode 100644
index 5f6d8b3c65c2..000000000000
--- a/fs/btrfs/inode-map.h
+++ /dev/null
@@ -1,14 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-
-#ifndef BTRFS_INODE_MAP_H
-#define BTRFS_INODE_MAP_H
-
-void btrfs_init_free_ino_ctl(struct btrfs_root *root);
-void btrfs_unpin_free_ino(struct btrfs_root *root);
-void btrfs_return_ino(struct btrfs_root *root, u64 objectid);
-int btrfs_find_free_ino(struct btrfs_root *root, u64 *objectid);
-int btrfs_save_ino_cache(struct btrfs_root *root,
-			 struct btrfs_trans_handle *trans);
-
-
-#endif
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 70d964170497..4426795b0b2f 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -45,7 +45,6 @@
 #include "compression.h"
 #include "locking.h"
 #include "free-space-cache.h"
-#include "inode-map.h"
 #include "props.h"
 #include "qgroup.h"
 #include "delalloc-space.h"
@@ -4199,12 +4198,6 @@ int btrfs_delete_subvolume(struct inode *dir, struct dentry *dentry)
 		d_invalidate(dentry);
 		btrfs_prune_dentries(dest);
 		ASSERT(dest->send_in_progress == 0);
-
-		/* the last ref */
-		if (dest->ino_cache_inode) {
-			iput(dest->ino_cache_inode);
-			dest->ino_cache_inode = NULL;
-		}
 	}
 
 	return ret;
@@ -5280,10 +5273,6 @@ void btrfs_evict_inode(struct inode *inode)
 		btrfs_end_transaction(trans);
 	}
 
-	if (!(root == fs_info->tree_root ||
-	      root->root_key.objectid == BTRFS_TREE_RELOC_OBJECTID))
-		btrfs_return_ino(root, btrfs_ino(BTRFS_I(inode)));
-
 free_rsv:
 	btrfs_free_block_rsv(fs_info, rsv);
 no_delete:
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 6aea52828742..e3859662cfcf 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -34,7 +34,6 @@
 #include "print-tree.h"
 #include "volumes.h"
 #include "locking.h"
-#include "inode-map.h"
 #include "backref.h"
 #include "rcu-string.h"
 #include "send.h"
diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 6e7e5fe2e277..19b7db8b2117 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -18,7 +18,6 @@
 #include "btrfs_inode.h"
 #include "async-thread.h"
 #include "free-space-cache.h"
-#include "inode-map.h"
 #include "qgroup.h"
 #include "print-tree.h"
 #include "delalloc-space.h"
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 348f8899f4f4..99e4f6ddec1a 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -874,12 +874,6 @@ int btrfs_parse_options(struct btrfs_fs_info *info, char *options,
 		case Opt_inode_cache:
 			btrfs_warn(info,
 	"the 'inode_cache' option is deprecated and will have no effect from 5.11");
-			btrfs_set_pending_and_info(info, INODE_MAP_CACHE,
-					   "enabling inode map caching");
-			break;
-		case Opt_noinode_cache:
-			btrfs_clear_pending_and_info(info, INODE_MAP_CACHE,
-					     "disabling inode map caching");
 			break;
 		case Opt_clear_cache:
 			btrfs_set_and_info(info, CLEAR_CACHE,
@@ -1496,8 +1490,6 @@ static int btrfs_show_options(struct seq_file *seq, struct dentry *dentry)
 		seq_puts(seq, ",enospc_debug");
 	if (btrfs_test_opt(info, AUTO_DEFRAG))
 		seq_puts(seq, ",autodefrag");
-	if (btrfs_test_opt(info, INODE_MAP_CACHE))
-		seq_puts(seq, ",inode_cache");
 	if (btrfs_test_opt(info, SKIP_BALANCE))
 		seq_puts(seq, ",skip_balance");
 #ifdef CONFIG_BTRFS_FS_CHECK_INTEGRITY
diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index e425451c5811..7c32ef22dc5a 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -16,7 +16,6 @@
 #include "transaction.h"
 #include "locking.h"
 #include "tree-log.h"
-#include "inode-map.h"
 #include "volumes.h"
 #include "dev-replace.h"
 #include "qgroup.h"
@@ -163,8 +162,6 @@ static noinline void switch_commit_roots(struct btrfs_trans_handle *trans)
 		list_del_init(&root->dirty_list);
 		free_extent_buffer(root->commit_root);
 		root->commit_root = btrfs_root_node(root);
-		if (is_fstree(root->root_key.objectid))
-			btrfs_unpin_free_ino(root);
 		extent_io_tree_release(&root->dirty_log_pages);
 		btrfs_qgroup_clean_swapped_blocks(root);
 	}
@@ -1342,8 +1339,6 @@ static noinline int commit_fs_roots(struct btrfs_trans_handle *trans)
 			btrfs_free_log(trans, root);
 			btrfs_update_reloc_root(trans, root);
 
-			btrfs_save_ino_cache(root, trans);
-
 			/* see comments in should_cow_block() */
 			clear_bit(BTRFS_ROOT_FORCE_COW, &root->state);
 			smp_mb__after_atomic();
@@ -2435,10 +2430,6 @@ int btrfs_clean_one_deleted_snapshot(struct btrfs_root *root)
 	btrfs_debug(fs_info, "cleaner removing %llu", root->root_key.objectid);
 
 	btrfs_kill_all_delayed_nodes(root);
-	if (root->ino_cache_inode) {
-		iput(root->ino_cache_inode);
-		root->ino_cache_inode = NULL;
-	}
 
 	if (btrfs_header_backref_rev(root->node) <
 			BTRFS_MIXED_BACKREF_REV)
@@ -2459,16 +2450,6 @@ void btrfs_apply_pending_changes(struct btrfs_fs_info *fs_info)
 	if (!prev)
 		return;
 
-	bit = 1 << BTRFS_PENDING_SET_INODE_MAP_CACHE;
-	if (prev & bit)
-		btrfs_set_opt(fs_info->mount_opt, INODE_MAP_CACHE);
-	prev &= ~bit;
-
-	bit = 1 << BTRFS_PENDING_CLEAR_INODE_MAP_CACHE;
-	if (prev & bit)
-		btrfs_clear_opt(fs_info->mount_opt, INODE_MAP_CACHE);
-	prev &= ~bit;
-
 	bit = 1 << BTRFS_PENDING_COMMIT;
 	if (prev & bit)
 		btrfs_debug(fs_info, "pending commit done");
diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 80cf496226c2..485267ee5bc6 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -17,7 +17,6 @@
 #include "backref.h"
 #include "compression.h"
 #include "qgroup.h"
-#include "inode-map.h"
 #include "block-group.h"
 #include "space-info.h"
 
-- 
2.25.1

