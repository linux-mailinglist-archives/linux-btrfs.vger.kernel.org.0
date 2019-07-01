Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1B94E4DA5E
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Jun 2019 21:38:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726798AbfFTTil (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 20 Jun 2019 15:38:41 -0400
Received: from mail-yb1-f193.google.com ([209.85.219.193]:35643 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726506AbfFTTil (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 20 Jun 2019 15:38:41 -0400
Received: by mail-yb1-f193.google.com with SMTP id v17so1684701ybm.2
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Jun 2019 12:38:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=V39doRn3Mc6B0zjGtRtDv4JE55EIiLZ1a1fz9TV0NnQ=;
        b=oSrqm3Wb6oz016WkmkRMkwHIiRTjpBur6rugXXV3huVsy60AqW5zULg82zfyDRsxrp
         SA3fwPAIgjgzLA6Bs8du57YNlhWarmIENKMgqgL+Han1gap+BDobkKbTuHiKBp3Z0V92
         qFs65OE8NDA+6qQai+pX9LpV1ZoQa8crNT20g/P9I7ZZBsOEaoPMVGMwAwTZlfXnAtXM
         e3TY7ogSnJygHyUDEGgdD+61mJ4gopkPJn6+g8cEzidUkoVomrpnPFx+MZXnF7GCuJeQ
         wUQeIMecgLVNWtODNjddehg55s3HGCkz8j1HSpG9QnAaDYHLrtryR1Nvq55yGGIgm8Zc
         wRIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=V39doRn3Mc6B0zjGtRtDv4JE55EIiLZ1a1fz9TV0NnQ=;
        b=Z+f0g44HOMTKlBSxqCJvAZBgpQgzbijfuHYNrEO0sV9yc7mUKdqRWRQY1mKtky61O4
         ZWOj/1uNTTb/JQ/8LKmc8BO8Cco//30rEx5/g5ALXhTabFzATwv+v/qLAtnUmAm+E4oL
         V4o5B4kWbDdBnu71qBSgwkyT+hFayVQ5WBDAjCUy+2RyAjsJMP0ZosUiQbHQ212tYmFH
         HJ4sgPGaE96ujc53r105WNIN3tpvwKiHwKJwxX4WkH442m0ykX0wCij0YthN0pT4fFQ+
         igZolE+CzZ1fWWchesbKvwizXSCaqi4p5nncFAziesfYG7ibHceEhf12y6vJbC3G4tkT
         FolA==
X-Gm-Message-State: APjAAAX+UrFhIrPIcABBkPIPCCxa8TBSfWoQvyQtae2O2ZHMHBgXpkxq
        l18YinthZhkgzBgbb+WKtvmU33+VsACo6A==
X-Google-Smtp-Source: APXvYqxZI1clYXKz5StKZKyyxhHuYwagcpgT1MkmToG2URleGNn585YxG1UfXWvqSy/U/Tm1tvuPfw==
X-Received: by 2002:a5b:f07:: with SMTP id x7mr973729ybr.521.1561059518919;
        Thu, 20 Jun 2019 12:38:38 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id v135sm116786ywc.53.2019.06.20.12.38.38
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Jun 2019 12:38:38 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 18/25] btrfs: migrate the dirty bg writeout code
Date:   Thu, 20 Jun 2019 15:38:00 -0400
Message-Id: <20190620193807.29311-19-josef@toxicpanda.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20190620193807.29311-1-josef@toxicpanda.com>
References: <20190620193807.29311-1-josef@toxicpanda.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This can be easily migrated over now.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/block-group.c | 520 +++++++++++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/block-group.h |   3 +
 fs/btrfs/ctree.h       |   3 -
 fs/btrfs/extent-tree.c | 518 ------------------------------------------------
 4 files changed, 523 insertions(+), 521 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index cc69a6a14bc9..540dc7219f48 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -14,6 +14,7 @@
 #include "ref-verify.h"
 #include "sysfs.h"
 #include "tree-log.h"
+#include "delalloc-space.h"
 
 void btrfs_get_block_group(struct btrfs_block_group_cache *cache)
 {
@@ -1985,3 +1986,522 @@ void btrfs_dec_block_group_ro(struct btrfs_block_group_cache *cache)
 	spin_unlock(&cache->lock);
 	spin_unlock(&sinfo->lock);
 }
+
+static int write_one_cache_group(struct btrfs_trans_handle *trans,
+				 struct btrfs_path *path,
+				 struct btrfs_block_group_cache *cache)
+{
+	struct btrfs_fs_info *fs_info = trans->fs_info;
+	int ret;
+	struct btrfs_root *extent_root = fs_info->extent_root;
+	unsigned long bi;
+	struct extent_buffer *leaf;
+
+	ret = btrfs_search_slot(trans, extent_root, &cache->key, path, 0, 1);
+	if (ret) {
+		if (ret > 0)
+			ret = -ENOENT;
+		goto fail;
+	}
+
+	leaf = path->nodes[0];
+	bi = btrfs_item_ptr_offset(leaf, path->slots[0]);
+	write_extent_buffer(leaf, &cache->item, bi, sizeof(cache->item));
+	btrfs_mark_buffer_dirty(leaf);
+fail:
+	btrfs_release_path(path);
+	return ret;
+
+}
+
+static int cache_save_setup(struct btrfs_block_group_cache *block_group,
+			    struct btrfs_trans_handle *trans,
+			    struct btrfs_path *path)
+{
+	struct btrfs_fs_info *fs_info = block_group->fs_info;
+	struct btrfs_root *root = fs_info->tree_root;
+	struct inode *inode = NULL;
+	struct extent_changeset *data_reserved = NULL;
+	u64 alloc_hint = 0;
+	int dcs = BTRFS_DC_ERROR;
+	u64 num_pages = 0;
+	int retries = 0;
+	int ret = 0;
+
+	/*
+	 * If this block group is smaller than 100 megs don't bother caching the
+	 * block group.
+	 */
+	if (block_group->key.offset < (100 * SZ_1M)) {
+		spin_lock(&block_group->lock);
+		block_group->disk_cache_state = BTRFS_DC_WRITTEN;
+		spin_unlock(&block_group->lock);
+		return 0;
+	}
+
+	if (trans->aborted)
+		return 0;
+again:
+	inode = lookup_free_space_inode(block_group, path);
+	if (IS_ERR(inode) && PTR_ERR(inode) != -ENOENT) {
+		ret = PTR_ERR(inode);
+		btrfs_release_path(path);
+		goto out;
+	}
+
+	if (IS_ERR(inode)) {
+		BUG_ON(retries);
+		retries++;
+
+		if (block_group->ro)
+			goto out_free;
+
+		ret = create_free_space_inode(trans, block_group, path);
+		if (ret)
+			goto out_free;
+		goto again;
+	}
+
+	/*
+	 * We want to set the generation to 0, that way if anything goes wrong
+	 * from here on out we know not to trust this cache when we load up next
+	 * time.
+	 */
+	BTRFS_I(inode)->generation = 0;
+	ret = btrfs_update_inode(trans, root, inode);
+	if (ret) {
+		/*
+		 * So theoretically we could recover from this, simply set the
+		 * super cache generation to 0 so we know to invalidate the
+		 * cache, but then we'd have to keep track of the block groups
+		 * that fail this way so we know we _have_ to reset this cache
+		 * before the next commit or risk reading stale cache.  So to
+		 * limit our exposure to horrible edge cases lets just abort the
+		 * transaction, this only happens in really bad situations
+		 * anyway.
+		 */
+		btrfs_abort_transaction(trans, ret);
+		goto out_put;
+	}
+	WARN_ON(ret);
+
+	/* We've already setup this transaction, go ahead and exit */
+	if (block_group->cache_generation == trans->transid &&
+	    i_size_read(inode)) {
+		dcs = BTRFS_DC_SETUP;
+		goto out_put;
+	}
+
+	if (i_size_read(inode) > 0) {
+		ret = btrfs_check_trunc_cache_free_space(fs_info,
+					&fs_info->global_block_rsv);
+		if (ret)
+			goto out_put;
+
+		ret = btrfs_truncate_free_space_cache(trans, NULL, inode);
+		if (ret)
+			goto out_put;
+	}
+
+	spin_lock(&block_group->lock);
+	if (block_group->cached != BTRFS_CACHE_FINISHED ||
+	    !btrfs_test_opt(fs_info, SPACE_CACHE)) {
+		/*
+		 * don't bother trying to write stuff out _if_
+		 * a) we're not cached,
+		 * b) we're with nospace_cache mount option,
+		 * c) we're with v2 space_cache (FREE_SPACE_TREE).
+		 */
+		dcs = BTRFS_DC_WRITTEN;
+		spin_unlock(&block_group->lock);
+		goto out_put;
+	}
+	spin_unlock(&block_group->lock);
+
+	/*
+	 * We hit an ENOSPC when setting up the cache in this transaction, just
+	 * skip doing the setup, we've already cleared the cache so we're safe.
+	 */
+	if (test_bit(BTRFS_TRANS_CACHE_ENOSPC, &trans->transaction->flags)) {
+		ret = -ENOSPC;
+		goto out_put;
+	}
+
+	/*
+	 * Try to preallocate enough space based on how big the block group is.
+	 * Keep in mind this has to include any pinned space which could end up
+	 * taking up quite a bit since it's not folded into the other space
+	 * cache.
+	 */
+	num_pages = div_u64(block_group->key.offset, SZ_256M);
+	if (!num_pages)
+		num_pages = 1;
+
+	num_pages *= 16;
+	num_pages *= PAGE_SIZE;
+
+	ret = btrfs_check_data_free_space(inode, &data_reserved, 0, num_pages);
+	if (ret)
+		goto out_put;
+
+	ret = btrfs_prealloc_file_range_trans(inode, trans, 0, 0, num_pages,
+					      num_pages, num_pages,
+					      &alloc_hint);
+	/*
+	 * Our cache requires contiguous chunks so that we don't modify a bunch
+	 * of metadata or split extents when writing the cache out, which means
+	 * we can enospc if we are heavily fragmented in addition to just normal
+	 * out of space conditions.  So if we hit this just skip setting up any
+	 * other block groups for this transaction, maybe we'll unpin enough
+	 * space the next time around.
+	 */
+	if (!ret)
+		dcs = BTRFS_DC_SETUP;
+	else if (ret == -ENOSPC)
+		set_bit(BTRFS_TRANS_CACHE_ENOSPC, &trans->transaction->flags);
+
+out_put:
+	iput(inode);
+out_free:
+	btrfs_release_path(path);
+out:
+	spin_lock(&block_group->lock);
+	if (!ret && dcs == BTRFS_DC_SETUP)
+		block_group->cache_generation = trans->transid;
+	block_group->disk_cache_state = dcs;
+	spin_unlock(&block_group->lock);
+
+	extent_changeset_free(data_reserved);
+	return ret;
+}
+
+int btrfs_setup_space_cache(struct btrfs_trans_handle *trans)
+{
+	struct btrfs_fs_info *fs_info = trans->fs_info;
+	struct btrfs_block_group_cache *cache, *tmp;
+	struct btrfs_transaction *cur_trans = trans->transaction;
+	struct btrfs_path *path;
+
+	if (list_empty(&cur_trans->dirty_bgs) ||
+	    !btrfs_test_opt(fs_info, SPACE_CACHE))
+		return 0;
+
+	path = btrfs_alloc_path();
+	if (!path)
+		return -ENOMEM;
+
+	/* Could add new block groups, use _safe just in case */
+	list_for_each_entry_safe(cache, tmp, &cur_trans->dirty_bgs,
+				 dirty_list) {
+		if (cache->disk_cache_state == BTRFS_DC_CLEAR)
+			cache_save_setup(cache, trans, path);
+	}
+
+	btrfs_free_path(path);
+	return 0;
+}
+
+/*
+ * transaction commit does final block group cache writeback during a
+ * critical section where nothing is allowed to change the FS.  This is
+ * required in order for the cache to actually match the block group,
+ * but can introduce a lot of latency into the commit.
+ *
+ * So, btrfs_start_dirty_block_groups is here to kick off block group
+ * cache IO.  There's a chance we'll have to redo some of it if the
+ * block group changes again during the commit, but it greatly reduces
+ * the commit latency by getting rid of the easy block groups while
+ * we're still allowing others to join the commit.
+ */
+int btrfs_start_dirty_block_groups(struct btrfs_trans_handle *trans)
+{
+	struct btrfs_fs_info *fs_info = trans->fs_info;
+	struct btrfs_block_group_cache *cache;
+	struct btrfs_transaction *cur_trans = trans->transaction;
+	int ret = 0;
+	int should_put;
+	struct btrfs_path *path = NULL;
+	LIST_HEAD(dirty);
+	struct list_head *io = &cur_trans->io_bgs;
+	int num_started = 0;
+	int loops = 0;
+
+	spin_lock(&cur_trans->dirty_bgs_lock);
+	if (list_empty(&cur_trans->dirty_bgs)) {
+		spin_unlock(&cur_trans->dirty_bgs_lock);
+		return 0;
+	}
+	list_splice_init(&cur_trans->dirty_bgs, &dirty);
+	spin_unlock(&cur_trans->dirty_bgs_lock);
+
+again:
+	/*
+	 * make sure all the block groups on our dirty list actually
+	 * exist
+	 */
+	btrfs_create_pending_block_groups(trans);
+
+	if (!path) {
+		path = btrfs_alloc_path();
+		if (!path)
+			return -ENOMEM;
+	}
+
+	/*
+	 * cache_write_mutex is here only to save us from balance or automatic
+	 * removal of empty block groups deleting this block group while we are
+	 * writing out the cache
+	 */
+	mutex_lock(&trans->transaction->cache_write_mutex);
+	while (!list_empty(&dirty)) {
+		bool drop_reserve = true;
+
+		cache = list_first_entry(&dirty,
+					 struct btrfs_block_group_cache,
+					 dirty_list);
+		/*
+		 * this can happen if something re-dirties a block
+		 * group that is already under IO.  Just wait for it to
+		 * finish and then do it all again
+		 */
+		if (!list_empty(&cache->io_list)) {
+			list_del_init(&cache->io_list);
+			btrfs_wait_cache_io(trans, cache, path);
+			btrfs_put_block_group(cache);
+		}
+
+
+		/*
+		 * btrfs_wait_cache_io uses the cache->dirty_list to decide
+		 * if it should update the cache_state.  Don't delete
+		 * until after we wait.
+		 *
+		 * Since we're not running in the commit critical section
+		 * we need the dirty_bgs_lock to protect from update_block_group
+		 */
+		spin_lock(&cur_trans->dirty_bgs_lock);
+		list_del_init(&cache->dirty_list);
+		spin_unlock(&cur_trans->dirty_bgs_lock);
+
+		should_put = 1;
+
+		cache_save_setup(cache, trans, path);
+
+		if (cache->disk_cache_state == BTRFS_DC_SETUP) {
+			cache->io_ctl.inode = NULL;
+			ret = btrfs_write_out_cache(trans, cache, path);
+			if (ret == 0 && cache->io_ctl.inode) {
+				num_started++;
+				should_put = 0;
+
+				/*
+				 * The cache_write_mutex is protecting the
+				 * io_list, also refer to the definition of
+				 * btrfs_transaction::io_bgs for more details
+				 */
+				list_add_tail(&cache->io_list, io);
+			} else {
+				/*
+				 * if we failed to write the cache, the
+				 * generation will be bad and life goes on
+				 */
+				ret = 0;
+			}
+		}
+		if (!ret) {
+			ret = write_one_cache_group(trans, path, cache);
+			/*
+			 * Our block group might still be attached to the list
+			 * of new block groups in the transaction handle of some
+			 * other task (struct btrfs_trans_handle->new_bgs). This
+			 * means its block group item isn't yet in the extent
+			 * tree. If this happens ignore the error, as we will
+			 * try again later in the critical section of the
+			 * transaction commit.
+			 */
+			if (ret == -ENOENT) {
+				ret = 0;
+				spin_lock(&cur_trans->dirty_bgs_lock);
+				if (list_empty(&cache->dirty_list)) {
+					list_add_tail(&cache->dirty_list,
+						      &cur_trans->dirty_bgs);
+					btrfs_get_block_group(cache);
+					drop_reserve = false;
+				}
+				spin_unlock(&cur_trans->dirty_bgs_lock);
+			} else if (ret) {
+				btrfs_abort_transaction(trans, ret);
+			}
+		}
+
+		/* if it's not on the io list, we need to put the block group */
+		if (should_put)
+			btrfs_put_block_group(cache);
+		if (drop_reserve)
+			btrfs_delayed_refs_rsv_release(fs_info, 1);
+
+		if (ret)
+			break;
+
+		/*
+		 * Avoid blocking other tasks for too long. It might even save
+		 * us from writing caches for block groups that are going to be
+		 * removed.
+		 */
+		mutex_unlock(&trans->transaction->cache_write_mutex);
+		mutex_lock(&trans->transaction->cache_write_mutex);
+	}
+	mutex_unlock(&trans->transaction->cache_write_mutex);
+
+	/*
+	 * go through delayed refs for all the stuff we've just kicked off
+	 * and then loop back (just once)
+	 */
+	ret = btrfs_run_delayed_refs(trans, 0);
+	if (!ret && loops == 0) {
+		loops++;
+		spin_lock(&cur_trans->dirty_bgs_lock);
+		list_splice_init(&cur_trans->dirty_bgs, &dirty);
+		/*
+		 * dirty_bgs_lock protects us from concurrent block group
+		 * deletes too (not just cache_write_mutex).
+		 */
+		if (!list_empty(&dirty)) {
+			spin_unlock(&cur_trans->dirty_bgs_lock);
+			goto again;
+		}
+		spin_unlock(&cur_trans->dirty_bgs_lock);
+	} else if (ret < 0) {
+		btrfs_cleanup_dirty_bgs(cur_trans, fs_info);
+	}
+
+	btrfs_free_path(path);
+	return ret;
+}
+
+int btrfs_write_dirty_block_groups(struct btrfs_trans_handle *trans)
+{
+	struct btrfs_fs_info *fs_info = trans->fs_info;
+	struct btrfs_block_group_cache *cache;
+	struct btrfs_transaction *cur_trans = trans->transaction;
+	int ret = 0;
+	int should_put;
+	struct btrfs_path *path;
+	struct list_head *io = &cur_trans->io_bgs;
+	int num_started = 0;
+
+	path = btrfs_alloc_path();
+	if (!path)
+		return -ENOMEM;
+
+	/*
+	 * Even though we are in the critical section of the transaction commit,
+	 * we can still have concurrent tasks adding elements to this
+	 * transaction's list of dirty block groups. These tasks correspond to
+	 * endio free space workers started when writeback finishes for a
+	 * space cache, which run inode.c:btrfs_finish_ordered_io(), and can
+	 * allocate new block groups as a result of COWing nodes of the root
+	 * tree when updating the free space inode. The writeback for the space
+	 * caches is triggered by an earlier call to
+	 * btrfs_start_dirty_block_groups() and iterations of the following
+	 * loop.
+	 * Also we want to do the cache_save_setup first and then run the
+	 * delayed refs to make sure we have the best chance at doing this all
+	 * in one shot.
+	 */
+	spin_lock(&cur_trans->dirty_bgs_lock);
+	while (!list_empty(&cur_trans->dirty_bgs)) {
+		cache = list_first_entry(&cur_trans->dirty_bgs,
+					 struct btrfs_block_group_cache,
+					 dirty_list);
+
+		/*
+		 * this can happen if cache_save_setup re-dirties a block
+		 * group that is already under IO.  Just wait for it to
+		 * finish and then do it all again
+		 */
+		if (!list_empty(&cache->io_list)) {
+			spin_unlock(&cur_trans->dirty_bgs_lock);
+			list_del_init(&cache->io_list);
+			btrfs_wait_cache_io(trans, cache, path);
+			btrfs_put_block_group(cache);
+			spin_lock(&cur_trans->dirty_bgs_lock);
+		}
+
+		/*
+		 * don't remove from the dirty list until after we've waited
+		 * on any pending IO
+		 */
+		list_del_init(&cache->dirty_list);
+		spin_unlock(&cur_trans->dirty_bgs_lock);
+		should_put = 1;
+
+		cache_save_setup(cache, trans, path);
+
+		if (!ret)
+			ret = btrfs_run_delayed_refs(trans,
+						     (unsigned long) -1);
+
+		if (!ret && cache->disk_cache_state == BTRFS_DC_SETUP) {
+			cache->io_ctl.inode = NULL;
+			ret = btrfs_write_out_cache(trans, cache, path);
+			if (ret == 0 && cache->io_ctl.inode) {
+				num_started++;
+				should_put = 0;
+				list_add_tail(&cache->io_list, io);
+			} else {
+				/*
+				 * if we failed to write the cache, the
+				 * generation will be bad and life goes on
+				 */
+				ret = 0;
+			}
+		}
+		if (!ret) {
+			ret = write_one_cache_group(trans, path, cache);
+			/*
+			 * One of the free space endio workers might have
+			 * created a new block group while updating a free space
+			 * cache's inode (at inode.c:btrfs_finish_ordered_io())
+			 * and hasn't released its transaction handle yet, in
+			 * which case the new block group is still attached to
+			 * its transaction handle and its creation has not
+			 * finished yet (no block group item in the extent tree
+			 * yet, etc). If this is the case, wait for all free
+			 * space endio workers to finish and retry. This is a
+			 * a very rare case so no need for a more efficient and
+			 * complex approach.
+			 */
+			if (ret == -ENOENT) {
+				wait_event(cur_trans->writer_wait,
+				   atomic_read(&cur_trans->num_writers) == 1);
+				ret = write_one_cache_group(trans, path, cache);
+			}
+			if (ret)
+				btrfs_abort_transaction(trans, ret);
+		}
+
+		/* if its not on the io list, we need to put the block group */
+		if (should_put)
+			btrfs_put_block_group(cache);
+		btrfs_delayed_refs_rsv_release(fs_info, 1);
+		spin_lock(&cur_trans->dirty_bgs_lock);
+	}
+	spin_unlock(&cur_trans->dirty_bgs_lock);
+
+	/*
+	 * Refer to the definition of io_bgs member for details why it's safe
+	 * to use it without any locking
+	 */
+	while (!list_empty(io)) {
+		cache = list_first_entry(io, struct btrfs_block_group_cache,
+					 io_list);
+		list_del_init(&cache->io_list);
+		btrfs_wait_cache_io(trans, cache, path);
+		btrfs_put_block_group(cache);
+	}
+
+	btrfs_free_path(path);
+	return ret;
+}
+
diff --git a/fs/btrfs/block-group.h b/fs/btrfs/block-group.h
index bccf2b02908a..b093b19696aa 100644
--- a/fs/btrfs/block-group.h
+++ b/fs/btrfs/block-group.h
@@ -193,6 +193,9 @@ int btrfs_make_block_group(struct btrfs_trans_handle *trans,
 void btrfs_create_pending_block_groups(struct btrfs_trans_handle *trans);
 int btrfs_inc_block_group_ro(struct btrfs_block_group_cache *cache);
 void btrfs_dec_block_group_ro(struct btrfs_block_group_cache *cache);
+int btrfs_start_dirty_block_groups(struct btrfs_trans_handle *trans);
+int btrfs_write_dirty_block_groups(struct btrfs_trans_handle *trans);
+int btrfs_setup_space_cache(struct btrfs_trans_handle *trans);
 
 static inline int
 btrfs_block_group_cache_done(struct btrfs_block_group_cache *cache)
diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index b609ec239cc7..15ab2d5f7cd7 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -2518,9 +2518,6 @@ int btrfs_finish_extent_commit(struct btrfs_trans_handle *trans);
 int btrfs_inc_extent_ref(struct btrfs_trans_handle *trans,
 			 struct btrfs_ref *generic_ref);
 
-int btrfs_start_dirty_block_groups(struct btrfs_trans_handle *trans);
-int btrfs_write_dirty_block_groups(struct btrfs_trans_handle *trans);
-int btrfs_setup_space_cache(struct btrfs_trans_handle *trans);
 int btrfs_extent_readonly(struct btrfs_fs_info *fs_info, u64 bytenr);
 int btrfs_free_block_groups(struct btrfs_fs_info *info);
 int btrfs_can_relocate(struct btrfs_fs_info *fs_info, u64 bytenr);
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 129bc04fcffd..b895380e60b2 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -2511,524 +2511,6 @@ int btrfs_dec_ref(struct btrfs_trans_handle *trans, struct btrfs_root *root,
 	return __btrfs_mod_ref(trans, root, buf, full_backref, 0);
 }
 
-static int write_one_cache_group(struct btrfs_trans_handle *trans,
-				 struct btrfs_path *path,
-				 struct btrfs_block_group_cache *cache)
-{
-	struct btrfs_fs_info *fs_info = trans->fs_info;
-	int ret;
-	struct btrfs_root *extent_root = fs_info->extent_root;
-	unsigned long bi;
-	struct extent_buffer *leaf;
-
-	ret = btrfs_search_slot(trans, extent_root, &cache->key, path, 0, 1);
-	if (ret) {
-		if (ret > 0)
-			ret = -ENOENT;
-		goto fail;
-	}
-
-	leaf = path->nodes[0];
-	bi = btrfs_item_ptr_offset(leaf, path->slots[0]);
-	write_extent_buffer(leaf, &cache->item, bi, sizeof(cache->item));
-	btrfs_mark_buffer_dirty(leaf);
-fail:
-	btrfs_release_path(path);
-	return ret;
-
-}
-
-static int cache_save_setup(struct btrfs_block_group_cache *block_group,
-			    struct btrfs_trans_handle *trans,
-			    struct btrfs_path *path)
-{
-	struct btrfs_fs_info *fs_info = block_group->fs_info;
-	struct btrfs_root *root = fs_info->tree_root;
-	struct inode *inode = NULL;
-	struct extent_changeset *data_reserved = NULL;
-	u64 alloc_hint = 0;
-	int dcs = BTRFS_DC_ERROR;
-	u64 num_pages = 0;
-	int retries = 0;
-	int ret = 0;
-
-	/*
-	 * If this block group is smaller than 100 megs don't bother caching the
-	 * block group.
-	 */
-	if (block_group->key.offset < (100 * SZ_1M)) {
-		spin_lock(&block_group->lock);
-		block_group->disk_cache_state = BTRFS_DC_WRITTEN;
-		spin_unlock(&block_group->lock);
-		return 0;
-	}
-
-	if (trans->aborted)
-		return 0;
-again:
-	inode = lookup_free_space_inode(block_group, path);
-	if (IS_ERR(inode) && PTR_ERR(inode) != -ENOENT) {
-		ret = PTR_ERR(inode);
-		btrfs_release_path(path);
-		goto out;
-	}
-
-	if (IS_ERR(inode)) {
-		BUG_ON(retries);
-		retries++;
-
-		if (block_group->ro)
-			goto out_free;
-
-		ret = create_free_space_inode(trans, block_group, path);
-		if (ret)
-			goto out_free;
-		goto again;
-	}
-
-	/*
-	 * We want to set the generation to 0, that way if anything goes wrong
-	 * from here on out we know not to trust this cache when we load up next
-	 * time.
-	 */
-	BTRFS_I(inode)->generation = 0;
-	ret = btrfs_update_inode(trans, root, inode);
-	if (ret) {
-		/*
-		 * So theoretically we could recover from this, simply set the
-		 * super cache generation to 0 so we know to invalidate the
-		 * cache, but then we'd have to keep track of the block groups
-		 * that fail this way so we know we _have_ to reset this cache
-		 * before the next commit or risk reading stale cache.  So to
-		 * limit our exposure to horrible edge cases lets just abort the
-		 * transaction, this only happens in really bad situations
-		 * anyway.
-		 */
-		btrfs_abort_transaction(trans, ret);
-		goto out_put;
-	}
-	WARN_ON(ret);
-
-	/* We've already setup this transaction, go ahead and exit */
-	if (block_group->cache_generation == trans->transid &&
-	    i_size_read(inode)) {
-		dcs = BTRFS_DC_SETUP;
-		goto out_put;
-	}
-
-	if (i_size_read(inode) > 0) {
-		ret = btrfs_check_trunc_cache_free_space(fs_info,
-					&fs_info->global_block_rsv);
-		if (ret)
-			goto out_put;
-
-		ret = btrfs_truncate_free_space_cache(trans, NULL, inode);
-		if (ret)
-			goto out_put;
-	}
-
-	spin_lock(&block_group->lock);
-	if (block_group->cached != BTRFS_CACHE_FINISHED ||
-	    !btrfs_test_opt(fs_info, SPACE_CACHE)) {
-		/*
-		 * don't bother trying to write stuff out _if_
-		 * a) we're not cached,
-		 * b) we're with nospace_cache mount option,
-		 * c) we're with v2 space_cache (FREE_SPACE_TREE).
-		 */
-		dcs = BTRFS_DC_WRITTEN;
-		spin_unlock(&block_group->lock);
-		goto out_put;
-	}
-	spin_unlock(&block_group->lock);
-
-	/*
-	 * We hit an ENOSPC when setting up the cache in this transaction, just
-	 * skip doing the setup, we've already cleared the cache so we're safe.
-	 */
-	if (test_bit(BTRFS_TRANS_CACHE_ENOSPC, &trans->transaction->flags)) {
-		ret = -ENOSPC;
-		goto out_put;
-	}
-
-	/*
-	 * Try to preallocate enough space based on how big the block group is.
-	 * Keep in mind this has to include any pinned space which could end up
-	 * taking up quite a bit since it's not folded into the other space
-	 * cache.
-	 */
-	num_pages = div_u64(block_group->key.offset, SZ_256M);
-	if (!num_pages)
-		num_pages = 1;
-
-	num_pages *= 16;
-	num_pages *= PAGE_SIZE;
-
-	ret = btrfs_check_data_free_space(inode, &data_reserved, 0, num_pages);
-	if (ret)
-		goto out_put;
-
-	ret = btrfs_prealloc_file_range_trans(inode, trans, 0, 0, num_pages,
-					      num_pages, num_pages,
-					      &alloc_hint);
-	/*
-	 * Our cache requires contiguous chunks so that we don't modify a bunch
-	 * of metadata or split extents when writing the cache out, which means
-	 * we can enospc if we are heavily fragmented in addition to just normal
-	 * out of space conditions.  So if we hit this just skip setting up any
-	 * other block groups for this transaction, maybe we'll unpin enough
-	 * space the next time around.
-	 */
-	if (!ret)
-		dcs = BTRFS_DC_SETUP;
-	else if (ret == -ENOSPC)
-		set_bit(BTRFS_TRANS_CACHE_ENOSPC, &trans->transaction->flags);
-
-out_put:
-	iput(inode);
-out_free:
-	btrfs_release_path(path);
-out:
-	spin_lock(&block_group->lock);
-	if (!ret && dcs == BTRFS_DC_SETUP)
-		block_group->cache_generation = trans->transid;
-	block_group->disk_cache_state = dcs;
-	spin_unlock(&block_group->lock);
-
-	extent_changeset_free(data_reserved);
-	return ret;
-}
-
-int btrfs_setup_space_cache(struct btrfs_trans_handle *trans)
-{
-	struct btrfs_fs_info *fs_info = trans->fs_info;
-	struct btrfs_block_group_cache *cache, *tmp;
-	struct btrfs_transaction *cur_trans = trans->transaction;
-	struct btrfs_path *path;
-
-	if (list_empty(&cur_trans->dirty_bgs) ||
-	    !btrfs_test_opt(fs_info, SPACE_CACHE))
-		return 0;
-
-	path = btrfs_alloc_path();
-	if (!path)
-		return -ENOMEM;
-
-	/* Could add new block groups, use _safe just in case */
-	list_for_each_entry_safe(cache, tmp, &cur_trans->dirty_bgs,
-				 dirty_list) {
-		if (cache->disk_cache_state == BTRFS_DC_CLEAR)
-			cache_save_setup(cache, trans, path);
-	}
-
-	btrfs_free_path(path);
-	return 0;
-}
-
-/*
- * transaction commit does final block group cache writeback during a
- * critical section where nothing is allowed to change the FS.  This is
- * required in order for the cache to actually match the block group,
- * but can introduce a lot of latency into the commit.
- *
- * So, btrfs_start_dirty_block_groups is here to kick off block group
- * cache IO.  There's a chance we'll have to redo some of it if the
- * block group changes again during the commit, but it greatly reduces
- * the commit latency by getting rid of the easy block groups while
- * we're still allowing others to join the commit.
- */
-int btrfs_start_dirty_block_groups(struct btrfs_trans_handle *trans)
-{
-	struct btrfs_fs_info *fs_info = trans->fs_info;
-	struct btrfs_block_group_cache *cache;
-	struct btrfs_transaction *cur_trans = trans->transaction;
-	int ret = 0;
-	int should_put;
-	struct btrfs_path *path = NULL;
-	LIST_HEAD(dirty);
-	struct list_head *io = &cur_trans->io_bgs;
-	int num_started = 0;
-	int loops = 0;
-
-	spin_lock(&cur_trans->dirty_bgs_lock);
-	if (list_empty(&cur_trans->dirty_bgs)) {
-		spin_unlock(&cur_trans->dirty_bgs_lock);
-		return 0;
-	}
-	list_splice_init(&cur_trans->dirty_bgs, &dirty);
-	spin_unlock(&cur_trans->dirty_bgs_lock);
-
-again:
-	/*
-	 * make sure all the block groups on our dirty list actually
-	 * exist
-	 */
-	btrfs_create_pending_block_groups(trans);
-
-	if (!path) {
-		path = btrfs_alloc_path();
-		if (!path)
-			return -ENOMEM;
-	}
-
-	/*
-	 * cache_write_mutex is here only to save us from balance or automatic
-	 * removal of empty block groups deleting this block group while we are
-	 * writing out the cache
-	 */
-	mutex_lock(&trans->transaction->cache_write_mutex);
-	while (!list_empty(&dirty)) {
-		bool drop_reserve = true;
-
-		cache = list_first_entry(&dirty,
-					 struct btrfs_block_group_cache,
-					 dirty_list);
-		/*
-		 * this can happen if something re-dirties a block
-		 * group that is already under IO.  Just wait for it to
-		 * finish and then do it all again
-		 */
-		if (!list_empty(&cache->io_list)) {
-			list_del_init(&cache->io_list);
-			btrfs_wait_cache_io(trans, cache, path);
-			btrfs_put_block_group(cache);
-		}
-
-
-		/*
-		 * btrfs_wait_cache_io uses the cache->dirty_list to decide
-		 * if it should update the cache_state.  Don't delete
-		 * until after we wait.
-		 *
-		 * Since we're not running in the commit critical section
-		 * we need the dirty_bgs_lock to protect from update_block_group
-		 */
-		spin_lock(&cur_trans->dirty_bgs_lock);
-		list_del_init(&cache->dirty_list);
-		spin_unlock(&cur_trans->dirty_bgs_lock);
-
-		should_put = 1;
-
-		cache_save_setup(cache, trans, path);
-
-		if (cache->disk_cache_state == BTRFS_DC_SETUP) {
-			cache->io_ctl.inode = NULL;
-			ret = btrfs_write_out_cache(trans, cache, path);
-			if (ret == 0 && cache->io_ctl.inode) {
-				num_started++;
-				should_put = 0;
-
-				/*
-				 * The cache_write_mutex is protecting the
-				 * io_list, also refer to the definition of
-				 * btrfs_transaction::io_bgs for more details
-				 */
-				list_add_tail(&cache->io_list, io);
-			} else {
-				/*
-				 * if we failed to write the cache, the
-				 * generation will be bad and life goes on
-				 */
-				ret = 0;
-			}
-		}
-		if (!ret) {
-			ret = write_one_cache_group(trans, path, cache);
-			/*
-			 * Our block group might still be attached to the list
-			 * of new block groups in the transaction handle of some
-			 * other task (struct btrfs_trans_handle->new_bgs). This
-			 * means its block group item isn't yet in the extent
-			 * tree. If this happens ignore the error, as we will
-			 * try again later in the critical section of the
-			 * transaction commit.
-			 */
-			if (ret == -ENOENT) {
-				ret = 0;
-				spin_lock(&cur_trans->dirty_bgs_lock);
-				if (list_empty(&cache->dirty_list)) {
-					list_add_tail(&cache->dirty_list,
-						      &cur_trans->dirty_bgs);
-					btrfs_get_block_group(cache);
-					drop_reserve = false;
-				}
-				spin_unlock(&cur_trans->dirty_bgs_lock);
-			} else if (ret) {
-				btrfs_abort_transaction(trans, ret);
-			}
-		}
-
-		/* if it's not on the io list, we need to put the block group */
-		if (should_put)
-			btrfs_put_block_group(cache);
-		if (drop_reserve)
-			btrfs_delayed_refs_rsv_release(fs_info, 1);
-
-		if (ret)
-			break;
-
-		/*
-		 * Avoid blocking other tasks for too long. It might even save
-		 * us from writing caches for block groups that are going to be
-		 * removed.
-		 */
-		mutex_unlock(&trans->transaction->cache_write_mutex);
-		mutex_lock(&trans->transaction->cache_write_mutex);
-	}
-	mutex_unlock(&trans->transaction->cache_write_mutex);
-
-	/*
-	 * go through delayed refs for all the stuff we've just kicked off
-	 * and then loop back (just once)
-	 */
-	ret = btrfs_run_delayed_refs(trans, 0);
-	if (!ret && loops == 0) {
-		loops++;
-		spin_lock(&cur_trans->dirty_bgs_lock);
-		list_splice_init(&cur_trans->dirty_bgs, &dirty);
-		/*
-		 * dirty_bgs_lock protects us from concurrent block group
-		 * deletes too (not just cache_write_mutex).
-		 */
-		if (!list_empty(&dirty)) {
-			spin_unlock(&cur_trans->dirty_bgs_lock);
-			goto again;
-		}
-		spin_unlock(&cur_trans->dirty_bgs_lock);
-	} else if (ret < 0) {
-		btrfs_cleanup_dirty_bgs(cur_trans, fs_info);
-	}
-
-	btrfs_free_path(path);
-	return ret;
-}
-
-int btrfs_write_dirty_block_groups(struct btrfs_trans_handle *trans)
-{
-	struct btrfs_fs_info *fs_info = trans->fs_info;
-	struct btrfs_block_group_cache *cache;
-	struct btrfs_transaction *cur_trans = trans->transaction;
-	int ret = 0;
-	int should_put;
-	struct btrfs_path *path;
-	struct list_head *io = &cur_trans->io_bgs;
-	int num_started = 0;
-
-	path = btrfs_alloc_path();
-	if (!path)
-		return -ENOMEM;
-
-	/*
-	 * Even though we are in the critical section of the transaction commit,
-	 * we can still have concurrent tasks adding elements to this
-	 * transaction's list of dirty block groups. These tasks correspond to
-	 * endio free space workers started when writeback finishes for a
-	 * space cache, which run inode.c:btrfs_finish_ordered_io(), and can
-	 * allocate new block groups as a result of COWing nodes of the root
-	 * tree when updating the free space inode. The writeback for the space
-	 * caches is triggered by an earlier call to
-	 * btrfs_start_dirty_block_groups() and iterations of the following
-	 * loop.
-	 * Also we want to do the cache_save_setup first and then run the
-	 * delayed refs to make sure we have the best chance at doing this all
-	 * in one shot.
-	 */
-	spin_lock(&cur_trans->dirty_bgs_lock);
-	while (!list_empty(&cur_trans->dirty_bgs)) {
-		cache = list_first_entry(&cur_trans->dirty_bgs,
-					 struct btrfs_block_group_cache,
-					 dirty_list);
-
-		/*
-		 * this can happen if cache_save_setup re-dirties a block
-		 * group that is already under IO.  Just wait for it to
-		 * finish and then do it all again
-		 */
-		if (!list_empty(&cache->io_list)) {
-			spin_unlock(&cur_trans->dirty_bgs_lock);
-			list_del_init(&cache->io_list);
-			btrfs_wait_cache_io(trans, cache, path);
-			btrfs_put_block_group(cache);
-			spin_lock(&cur_trans->dirty_bgs_lock);
-		}
-
-		/*
-		 * don't remove from the dirty list until after we've waited
-		 * on any pending IO
-		 */
-		list_del_init(&cache->dirty_list);
-		spin_unlock(&cur_trans->dirty_bgs_lock);
-		should_put = 1;
-
-		cache_save_setup(cache, trans, path);
-
-		if (!ret)
-			ret = btrfs_run_delayed_refs(trans,
-						     (unsigned long) -1);
-
-		if (!ret && cache->disk_cache_state == BTRFS_DC_SETUP) {
-			cache->io_ctl.inode = NULL;
-			ret = btrfs_write_out_cache(trans, cache, path);
-			if (ret == 0 && cache->io_ctl.inode) {
-				num_started++;
-				should_put = 0;
-				list_add_tail(&cache->io_list, io);
-			} else {
-				/*
-				 * if we failed to write the cache, the
-				 * generation will be bad and life goes on
-				 */
-				ret = 0;
-			}
-		}
-		if (!ret) {
-			ret = write_one_cache_group(trans, path, cache);
-			/*
-			 * One of the free space endio workers might have
-			 * created a new block group while updating a free space
-			 * cache's inode (at inode.c:btrfs_finish_ordered_io())
-			 * and hasn't released its transaction handle yet, in
-			 * which case the new block group is still attached to
-			 * its transaction handle and its creation has not
-			 * finished yet (no block group item in the extent tree
-			 * yet, etc). If this is the case, wait for all free
-			 * space endio workers to finish and retry. This is a
-			 * a very rare case so no need for a more efficient and
-			 * complex approach.
-			 */
-			if (ret == -ENOENT) {
-				wait_event(cur_trans->writer_wait,
-				   atomic_read(&cur_trans->num_writers) == 1);
-				ret = write_one_cache_group(trans, path, cache);
-			}
-			if (ret)
-				btrfs_abort_transaction(trans, ret);
-		}
-
-		/* if its not on the io list, we need to put the block group */
-		if (should_put)
-			btrfs_put_block_group(cache);
-		btrfs_delayed_refs_rsv_release(fs_info, 1);
-		spin_lock(&cur_trans->dirty_bgs_lock);
-	}
-	spin_unlock(&cur_trans->dirty_bgs_lock);
-
-	/*
-	 * Refer to the definition of io_bgs member for details why it's safe
-	 * to use it without any locking
-	 */
-	while (!list_empty(io)) {
-		cache = list_first_entry(io, struct btrfs_block_group_cache,
-					 io_list);
-		list_del_init(&cache->io_list);
-		btrfs_wait_cache_io(trans, cache, path);
-		btrfs_put_block_group(cache);
-	}
-
-	btrfs_free_path(path);
-	return ret;
-}
-
 int btrfs_extent_readonly(struct btrfs_fs_info *fs_info, u64 bytenr)
 {
 	struct btrfs_block_group_cache *block_group;
-- 
2.14.3

