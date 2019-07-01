Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 77AAF4DA57
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Jun 2019 21:38:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726727AbfFTTi3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 20 Jun 2019 15:38:29 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:38802 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726682AbfFTTi3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 20 Jun 2019 15:38:29 -0400
Received: by mail-yw1-f66.google.com with SMTP id k125so1675682ywe.5
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Jun 2019 12:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=Y9Py8/6Ljob5cVxQWOpEVViiXXqhrBZBhO8tmSAtz7Q=;
        b=v+8Q50eutZ83l0PpWwQVxU1c/cQip32QhX5qUkImfn7sd/UmIzyucA9DW3s+wAfSfm
         Imfk2Y2tkA+YHrV3hCnHbhfDL9Py2XKehjTZBmzrvbqN+sSWEvFFga1/BvZJY0uPbFpz
         ac84d2ijDQIh0FgqUx9Yvle2fcMYCOms+gZT/tnxcKh9xVp44wvTpMD484aEBX9mr4HU
         uMCY3VHnmzGvyd79BnppvG+kJrquw6jEkqBLXVhLM1nctRA/1ZA0fF62bANVCkpZnYay
         YSdUIDWD3JCVbIJ44e6CQuEfmRnbasJ4fgaDC/UV2vb5kgmVxe+2uMaemOUkUVTmnyA+
         d5gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=Y9Py8/6Ljob5cVxQWOpEVViiXXqhrBZBhO8tmSAtz7Q=;
        b=j1j9xFrzTr8Lf/ZZA4a9BkK/PTjVd+g5ScOsLK+unw+7cuZ6gKy8U9vioS+9rzbRav
         Lwvunr3W3omhZdSauRrxO9U54IVJ2vIAe8rJxiIwdzx1iEwN7VbMjgqXrcqMp+W5zQbw
         +KUPzNINWaajarCfWUnvk16C4WTb2n4lbrcVr1U0HrXo+1EyHoAiR+wIzyvtu93MDxZ0
         smEVHZGdeJZaS59iagi+aeAwGqs8+ViA+6TFbhkAt747bWzyI9FfmGLZijcnJkiamoWG
         Dn1xSIviZ4Etz+qKL9SBeZALuu20v9jaFQ6av8pAwfqFSGr4/hPBft/ERgYYUlpsEB1h
         rCsg==
X-Gm-Message-State: APjAAAWUHo6srgnzO1e3TDrzoW61aENb+sCj2QIVAw85qdzmw28KbGN5
        7O5X/zam5xn6bvG9u/NnYxa3c9E/44sQHg==
X-Google-Smtp-Source: APXvYqw3jfVc2Gu0toJyxKkk3Tw0XDYqLaOf7akL4pJwQo25bMLxWbUjq1nHVEEBxh0n3prYELmxSA==
X-Received: by 2002:a81:6d11:: with SMTP id i17mr46676560ywc.336.1561059507285;
        Thu, 20 Jun 2019 12:38:27 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id 205sm117977yws.46.2019.06.20.12.38.26
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Jun 2019 12:38:26 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 11/25] btrfs: migrate the block group caching code
Date:   Thu, 20 Jun 2019 15:37:53 -0400
Message-Id: <20190620193807.29311-12-josef@toxicpanda.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20190620193807.29311-1-josef@toxicpanda.com>
References: <20190620193807.29311-1-josef@toxicpanda.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We can now just copy it over to block-group.c.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/block-group.c | 463 +++++++++++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/block-group.h |   2 +
 fs/btrfs/ctree.h       |   2 -
 fs/btrfs/extent-tree.c | 461 ------------------------------------------------
 4 files changed, 465 insertions(+), 463 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index aeb2c806b2b0..e87bf6cd1362 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -5,6 +5,9 @@
 #include "ctree.h"
 #include "block-group.h"
 #include "space-info.h"
+#include "disk-io.h"
+#include "free-space-cache.h"
+#include "free-space-tree.h"
 
 void btrfs_get_block_group(struct btrfs_block_group_cache *cache)
 {
@@ -204,3 +207,463 @@ void btrfs_wait_block_group_reservations(struct btrfs_block_group_cache *bg)
 
 	wait_var_event(&bg->reservations, !atomic_read(&bg->reservations));
 }
+
+struct btrfs_caching_control *
+btrfs_get_caching_control(struct btrfs_block_group_cache *cache)
+{
+	struct btrfs_caching_control *ctl;
+
+	spin_lock(&cache->lock);
+	if (!cache->caching_ctl) {
+		spin_unlock(&cache->lock);
+		return NULL;
+	}
+
+	ctl = cache->caching_ctl;
+	refcount_inc(&ctl->count);
+	spin_unlock(&cache->lock);
+	return ctl;
+}
+
+void btrfs_put_caching_control(struct btrfs_caching_control *ctl)
+{
+	if (refcount_dec_and_test(&ctl->count))
+		kfree(ctl);
+}
+
+/*
+ * when we wait for progress in the block group caching, its because
+ * our allocation attempt failed at least once.  So, we must sleep
+ * and let some progress happen before we try again.
+ *
+ * This function will sleep at least once waiting for new free space to
+ * show up, and then it will check the block group free space numbers
+ * for our min num_bytes.  Another option is to have it go ahead
+ * and look in the rbtree for a free extent of a given size, but this
+ * is a good start.
+ *
+ * Callers of this must check if cache->cached == BTRFS_CACHE_ERROR before using
+ * any of the information in this block group.
+ */
+void
+btrfs_wait_block_group_cache_progress(struct btrfs_block_group_cache *cache,
+				      u64 num_bytes)
+{
+	struct btrfs_caching_control *caching_ctl;
+
+	caching_ctl = btrfs_get_caching_control(cache);
+	if (!caching_ctl)
+		return;
+
+	wait_event(caching_ctl->wait, btrfs_block_group_cache_done(cache) ||
+		   (cache->free_space_ctl->free_space >= num_bytes));
+
+	btrfs_put_caching_control(caching_ctl);
+}
+
+int btrfs_wait_block_group_cache_done(struct btrfs_block_group_cache *cache)
+{
+	struct btrfs_caching_control *caching_ctl;
+	int ret = 0;
+
+	caching_ctl = btrfs_get_caching_control(cache);
+	if (!caching_ctl)
+		return (cache->cached == BTRFS_CACHE_ERROR) ? -EIO : 0;
+
+	wait_event(caching_ctl->wait, btrfs_block_group_cache_done(cache));
+	if (cache->cached == BTRFS_CACHE_ERROR)
+		ret = -EIO;
+	btrfs_put_caching_control(caching_ctl);
+	return ret;
+}
+
+#ifdef CONFIG_BTRFS_DEBUG
+void btrfs_fragment_free_space(struct btrfs_block_group_cache *block_group)
+{
+	struct btrfs_fs_info *fs_info = block_group->fs_info;
+	u64 start = block_group->key.objectid;
+	u64 len = block_group->key.offset;
+	u64 chunk = block_group->flags & BTRFS_BLOCK_GROUP_METADATA ?
+		fs_info->nodesize : fs_info->sectorsize;
+	u64 step = chunk << 1;
+
+	while (len > chunk) {
+		btrfs_remove_free_space(block_group, start, chunk);
+		start += step;
+		if (len < step)
+			len = 0;
+		else
+			len -= step;
+	}
+}
+#endif
+
+/*
+ * this is only called by btrfs_cache_block_group, since we could have freed
+ * extents we need to check the pinned_extents for any extents that can't be
+ * used yet since their free space will be released as soon as the transaction
+ * commits.
+ */
+u64 add_new_free_space(struct btrfs_block_group_cache *block_group,
+		       u64 start, u64 end)
+{
+	struct btrfs_fs_info *info = block_group->fs_info;
+	u64 extent_start, extent_end, size, total_added = 0;
+	int ret;
+
+	while (start < end) {
+		ret = find_first_extent_bit(info->pinned_extents, start,
+					    &extent_start, &extent_end,
+					    EXTENT_DIRTY | EXTENT_UPTODATE,
+					    NULL);
+		if (ret)
+			break;
+
+		if (extent_start <= start) {
+			start = extent_end + 1;
+		} else if (extent_start > start && extent_start < end) {
+			size = extent_start - start;
+			total_added += size;
+			ret = btrfs_add_free_space(block_group, start,
+						   size);
+			BUG_ON(ret); /* -ENOMEM or logic error */
+			start = extent_end + 1;
+		} else {
+			break;
+		}
+	}
+
+	if (start < end) {
+		size = end - start;
+		total_added += size;
+		ret = btrfs_add_free_space(block_group, start, size);
+		BUG_ON(ret); /* -ENOMEM or logic error */
+	}
+
+	return total_added;
+}
+
+static int load_extent_tree_free(struct btrfs_caching_control *caching_ctl)
+{
+	struct btrfs_block_group_cache *block_group = caching_ctl->block_group;
+	struct btrfs_fs_info *fs_info = block_group->fs_info;
+	struct btrfs_root *extent_root = fs_info->extent_root;
+	struct btrfs_path *path;
+	struct extent_buffer *leaf;
+	struct btrfs_key key;
+	u64 total_found = 0;
+	u64 last = 0;
+	u32 nritems;
+	int ret;
+	bool wakeup = true;
+
+	path = btrfs_alloc_path();
+	if (!path)
+		return -ENOMEM;
+
+	last = max_t(u64, block_group->key.objectid, BTRFS_SUPER_INFO_OFFSET);
+
+#ifdef CONFIG_BTRFS_DEBUG
+	/*
+	 * If we're fragmenting we don't want to make anybody think we can
+	 * allocate from this block group until we've had a chance to fragment
+	 * the free space.
+	 */
+	if (btrfs_should_fragment_free_space(block_group))
+		wakeup = false;
+#endif
+	/*
+	 * We don't want to deadlock with somebody trying to allocate a new
+	 * extent for the extent root while also trying to search the extent
+	 * root to add free space.  So we skip locking and search the commit
+	 * root, since its read-only
+	 */
+	path->skip_locking = 1;
+	path->search_commit_root = 1;
+	path->reada = READA_FORWARD;
+
+	key.objectid = last;
+	key.offset = 0;
+	key.type = BTRFS_EXTENT_ITEM_KEY;
+
+next:
+	ret = btrfs_search_slot(NULL, extent_root, &key, path, 0, 0);
+	if (ret < 0)
+		goto out;
+
+	leaf = path->nodes[0];
+	nritems = btrfs_header_nritems(leaf);
+
+	while (1) {
+		if (btrfs_fs_closing(fs_info) > 1) {
+			last = (u64)-1;
+			break;
+		}
+
+		if (path->slots[0] < nritems) {
+			btrfs_item_key_to_cpu(leaf, &key, path->slots[0]);
+		} else {
+			ret = btrfs_find_next_key(extent_root, path, &key, 0,
+						  0);
+			if (ret)
+				break;
+
+			if (need_resched() ||
+			    rwsem_is_contended(&fs_info->commit_root_sem)) {
+				if (wakeup)
+					caching_ctl->progress = last;
+				btrfs_release_path(path);
+				up_read(&fs_info->commit_root_sem);
+				mutex_unlock(&caching_ctl->mutex);
+				cond_resched();
+				mutex_lock(&caching_ctl->mutex);
+				down_read(&fs_info->commit_root_sem);
+				goto next;
+			}
+
+			ret = btrfs_next_leaf(extent_root, path);
+			if (ret < 0)
+				goto out;
+			if (ret)
+				break;
+			leaf = path->nodes[0];
+			nritems = btrfs_header_nritems(leaf);
+			continue;
+		}
+
+		if (key.objectid < last) {
+			key.objectid = last;
+			key.offset = 0;
+			key.type = BTRFS_EXTENT_ITEM_KEY;
+
+			if (wakeup)
+				caching_ctl->progress = last;
+			btrfs_release_path(path);
+			goto next;
+		}
+
+		if (key.objectid < block_group->key.objectid) {
+			path->slots[0]++;
+			continue;
+		}
+
+		if (key.objectid >= block_group->key.objectid +
+		    block_group->key.offset)
+			break;
+
+		if (key.type == BTRFS_EXTENT_ITEM_KEY ||
+		    key.type == BTRFS_METADATA_ITEM_KEY) {
+			total_found += add_new_free_space(block_group, last,
+							  key.objectid);
+			if (key.type == BTRFS_METADATA_ITEM_KEY)
+				last = key.objectid +
+					fs_info->nodesize;
+			else
+				last = key.objectid + key.offset;
+
+			if (total_found > CACHING_CTL_WAKE_UP) {
+				total_found = 0;
+				if (wakeup)
+					wake_up(&caching_ctl->wait);
+			}
+		}
+		path->slots[0]++;
+	}
+	ret = 0;
+
+	total_found += add_new_free_space(block_group, last,
+					  block_group->key.objectid +
+					  block_group->key.offset);
+	caching_ctl->progress = (u64)-1;
+
+out:
+	btrfs_free_path(path);
+	return ret;
+}
+
+static noinline void caching_thread(struct btrfs_work *work)
+{
+	struct btrfs_block_group_cache *block_group;
+	struct btrfs_fs_info *fs_info;
+	struct btrfs_caching_control *caching_ctl;
+	int ret;
+
+	caching_ctl = container_of(work, struct btrfs_caching_control, work);
+	block_group = caching_ctl->block_group;
+	fs_info = block_group->fs_info;
+
+	mutex_lock(&caching_ctl->mutex);
+	down_read(&fs_info->commit_root_sem);
+
+	if (btrfs_fs_compat_ro(fs_info, FREE_SPACE_TREE))
+		ret = load_free_space_tree(caching_ctl);
+	else
+		ret = load_extent_tree_free(caching_ctl);
+
+	spin_lock(&block_group->lock);
+	block_group->caching_ctl = NULL;
+	block_group->cached = ret ? BTRFS_CACHE_ERROR : BTRFS_CACHE_FINISHED;
+	spin_unlock(&block_group->lock);
+
+#ifdef CONFIG_BTRFS_DEBUG
+	if (btrfs_should_fragment_free_space(block_group)) {
+		u64 bytes_used;
+
+		spin_lock(&block_group->space_info->lock);
+		spin_lock(&block_group->lock);
+		bytes_used = block_group->key.offset -
+			btrfs_block_group_used(&block_group->item);
+		block_group->space_info->bytes_used += bytes_used >> 1;
+		spin_unlock(&block_group->lock);
+		spin_unlock(&block_group->space_info->lock);
+		btrfs_fragment_free_space(block_group);
+	}
+#endif
+
+	caching_ctl->progress = (u64)-1;
+
+	up_read(&fs_info->commit_root_sem);
+	btrfs_free_excluded_extents(block_group);
+	mutex_unlock(&caching_ctl->mutex);
+
+	wake_up(&caching_ctl->wait);
+
+	btrfs_put_caching_control(caching_ctl);
+	btrfs_put_block_group(block_group);
+}
+
+int btrfs_cache_block_group(struct btrfs_block_group_cache *cache,
+			    int load_cache_only)
+{
+	DEFINE_WAIT(wait);
+	struct btrfs_fs_info *fs_info = cache->fs_info;
+	struct btrfs_caching_control *caching_ctl;
+	int ret = 0;
+
+	caching_ctl = kzalloc(sizeof(*caching_ctl), GFP_NOFS);
+	if (!caching_ctl)
+		return -ENOMEM;
+
+	INIT_LIST_HEAD(&caching_ctl->list);
+	mutex_init(&caching_ctl->mutex);
+	init_waitqueue_head(&caching_ctl->wait);
+	caching_ctl->block_group = cache;
+	caching_ctl->progress = cache->key.objectid;
+	refcount_set(&caching_ctl->count, 1);
+	btrfs_init_work(&caching_ctl->work, btrfs_cache_helper,
+			caching_thread, NULL, NULL);
+
+	spin_lock(&cache->lock);
+	/*
+	 * This should be a rare occasion, but this could happen I think in the
+	 * case where one thread starts to load the space cache info, and then
+	 * some other thread starts a transaction commit which tries to do an
+	 * allocation while the other thread is still loading the space cache
+	 * info.  The previous loop should have kept us from choosing this block
+	 * group, but if we've moved to the state where we will wait on caching
+	 * block groups we need to first check if we're doing a fast load here,
+	 * so we can wait for it to finish, otherwise we could end up allocating
+	 * from a block group who's cache gets evicted for one reason or
+	 * another.
+	 */
+	while (cache->cached == BTRFS_CACHE_FAST) {
+		struct btrfs_caching_control *ctl;
+
+		ctl = cache->caching_ctl;
+		refcount_inc(&ctl->count);
+		prepare_to_wait(&ctl->wait, &wait, TASK_UNINTERRUPTIBLE);
+		spin_unlock(&cache->lock);
+
+		schedule();
+
+		finish_wait(&ctl->wait, &wait);
+		btrfs_put_caching_control(ctl);
+		spin_lock(&cache->lock);
+	}
+
+	if (cache->cached != BTRFS_CACHE_NO) {
+		spin_unlock(&cache->lock);
+		kfree(caching_ctl);
+		return 0;
+	}
+	WARN_ON(cache->caching_ctl);
+	cache->caching_ctl = caching_ctl;
+	cache->cached = BTRFS_CACHE_FAST;
+	spin_unlock(&cache->lock);
+
+	if (btrfs_test_opt(fs_info, SPACE_CACHE)) {
+		mutex_lock(&caching_ctl->mutex);
+		ret = load_free_space_cache(cache);
+
+		spin_lock(&cache->lock);
+		if (ret == 1) {
+			cache->caching_ctl = NULL;
+			cache->cached = BTRFS_CACHE_FINISHED;
+			cache->last_byte_to_unpin = (u64)-1;
+			caching_ctl->progress = (u64)-1;
+		} else {
+			if (load_cache_only) {
+				cache->caching_ctl = NULL;
+				cache->cached = BTRFS_CACHE_NO;
+			} else {
+				cache->cached = BTRFS_CACHE_STARTED;
+				cache->has_caching_ctl = 1;
+			}
+		}
+		spin_unlock(&cache->lock);
+#ifdef CONFIG_BTRFS_DEBUG
+		if (ret == 1 &&
+		    btrfs_should_fragment_free_space(cache)) {
+			u64 bytes_used;
+
+			spin_lock(&cache->space_info->lock);
+			spin_lock(&cache->lock);
+			bytes_used = cache->key.offset -
+				btrfs_block_group_used(&cache->item);
+			cache->space_info->bytes_used += bytes_used >> 1;
+			spin_unlock(&cache->lock);
+			spin_unlock(&cache->space_info->lock);
+			btrfs_fragment_free_space(cache);
+		}
+#endif
+		mutex_unlock(&caching_ctl->mutex);
+
+		wake_up(&caching_ctl->wait);
+		if (ret == 1) {
+			btrfs_put_caching_control(caching_ctl);
+			btrfs_free_excluded_extents(cache);
+			return 0;
+		}
+	} else {
+		/*
+		 * We're either using the free space tree or no caching at all.
+		 * Set cached to the appropriate value and wakeup any waiters.
+		 */
+		spin_lock(&cache->lock);
+		if (load_cache_only) {
+			cache->caching_ctl = NULL;
+			cache->cached = BTRFS_CACHE_NO;
+		} else {
+			cache->cached = BTRFS_CACHE_STARTED;
+			cache->has_caching_ctl = 1;
+		}
+		spin_unlock(&cache->lock);
+		wake_up(&caching_ctl->wait);
+	}
+
+	if (load_cache_only) {
+		btrfs_put_caching_control(caching_ctl);
+		return 0;
+	}
+
+	down_write(&fs_info->commit_root_sem);
+	refcount_inc(&caching_ctl->count);
+	list_add_tail(&caching_ctl->list, &fs_info->caching_block_groups);
+	up_write(&fs_info->commit_root_sem);
+
+	btrfs_get_block_group(cache);
+
+	btrfs_queue_work(fs_info->caching_workers, &caching_ctl->work);
+
+	return ret;
+}
diff --git a/fs/btrfs/block-group.h b/fs/btrfs/block-group.h
index b249237ef175..058b55cd6d29 100644
--- a/fs/btrfs/block-group.h
+++ b/fs/btrfs/block-group.h
@@ -177,6 +177,8 @@ int btrfs_cache_block_group(struct btrfs_block_group_cache *cache,
 void btrfs_put_caching_control(struct btrfs_caching_control *ctl);
 struct btrfs_caching_control *
 btrfs_get_caching_control(struct btrfs_block_group_cache *cache);
+u64 add_new_free_space(struct btrfs_block_group_cache *block_group,
+		       u64 start, u64 end);
 
 static inline int
 btrfs_block_group_cache_done(struct btrfs_block_group_cache *cache)
diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 409852f7af9f..3d6209aa4dc9 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -2614,8 +2614,6 @@ int btrfs_start_write_no_snapshotting(struct btrfs_root *root);
 void btrfs_end_write_no_snapshotting(struct btrfs_root *root);
 void btrfs_wait_for_snapshot_creation(struct btrfs_root *root);
 void check_system_chunk(struct btrfs_trans_handle *trans, const u64 type);
-u64 add_new_free_space(struct btrfs_block_group_cache *block_group,
-		       u64 start, u64 end);
 void btrfs_mark_bg_unused(struct btrfs_block_group_cache *bg);
 
 /* ctree.c */
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 06aab5ef68e7..c5ffa3db9533 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -181,421 +181,6 @@ static int exclude_super_stripes(struct btrfs_block_group_cache *cache)
 	return 0;
 }
 
-struct btrfs_caching_control *
-btrfs_get_caching_control(struct btrfs_block_group_cache *cache)
-{
-	struct btrfs_caching_control *ctl;
-
-	spin_lock(&cache->lock);
-	if (!cache->caching_ctl) {
-		spin_unlock(&cache->lock);
-		return NULL;
-	}
-
-	ctl = cache->caching_ctl;
-	refcount_inc(&ctl->count);
-	spin_unlock(&cache->lock);
-	return ctl;
-}
-
-void btrfs_put_caching_control(struct btrfs_caching_control *ctl)
-{
-	if (refcount_dec_and_test(&ctl->count))
-		kfree(ctl);
-}
-
-#ifdef CONFIG_BTRFS_DEBUG
-void btrfs_fragment_free_space(struct btrfs_block_group_cache *block_group)
-{
-	struct btrfs_fs_info *fs_info = block_group->fs_info;
-	u64 start = block_group->key.objectid;
-	u64 len = block_group->key.offset;
-	u64 chunk = block_group->flags & BTRFS_BLOCK_GROUP_METADATA ?
-		fs_info->nodesize : fs_info->sectorsize;
-	u64 step = chunk << 1;
-
-	while (len > chunk) {
-		btrfs_remove_free_space(block_group, start, chunk);
-		start += step;
-		if (len < step)
-			len = 0;
-		else
-			len -= step;
-	}
-}
-#endif
-
-/*
- * this is only called by btrfs_cache_block_group, since we could have freed
- * extents we need to check the pinned_extents for any extents that can't be
- * used yet since their free space will be released as soon as the transaction
- * commits.
- */
-u64 add_new_free_space(struct btrfs_block_group_cache *block_group,
-		       u64 start, u64 end)
-{
-	struct btrfs_fs_info *info = block_group->fs_info;
-	u64 extent_start, extent_end, size, total_added = 0;
-	int ret;
-
-	while (start < end) {
-		ret = find_first_extent_bit(info->pinned_extents, start,
-					    &extent_start, &extent_end,
-					    EXTENT_DIRTY | EXTENT_UPTODATE,
-					    NULL);
-		if (ret)
-			break;
-
-		if (extent_start <= start) {
-			start = extent_end + 1;
-		} else if (extent_start > start && extent_start < end) {
-			size = extent_start - start;
-			total_added += size;
-			ret = btrfs_add_free_space(block_group, start,
-						   size);
-			BUG_ON(ret); /* -ENOMEM or logic error */
-			start = extent_end + 1;
-		} else {
-			break;
-		}
-	}
-
-	if (start < end) {
-		size = end - start;
-		total_added += size;
-		ret = btrfs_add_free_space(block_group, start, size);
-		BUG_ON(ret); /* -ENOMEM or logic error */
-	}
-
-	return total_added;
-}
-
-static int load_extent_tree_free(struct btrfs_caching_control *caching_ctl)
-{
-	struct btrfs_block_group_cache *block_group = caching_ctl->block_group;
-	struct btrfs_fs_info *fs_info = block_group->fs_info;
-	struct btrfs_root *extent_root = fs_info->extent_root;
-	struct btrfs_path *path;
-	struct extent_buffer *leaf;
-	struct btrfs_key key;
-	u64 total_found = 0;
-	u64 last = 0;
-	u32 nritems;
-	int ret;
-	bool wakeup = true;
-
-	path = btrfs_alloc_path();
-	if (!path)
-		return -ENOMEM;
-
-	last = max_t(u64, block_group->key.objectid, BTRFS_SUPER_INFO_OFFSET);
-
-#ifdef CONFIG_BTRFS_DEBUG
-	/*
-	 * If we're fragmenting we don't want to make anybody think we can
-	 * allocate from this block group until we've had a chance to fragment
-	 * the free space.
-	 */
-	if (btrfs_should_fragment_free_space(block_group))
-		wakeup = false;
-#endif
-	/*
-	 * We don't want to deadlock with somebody trying to allocate a new
-	 * extent for the extent root while also trying to search the extent
-	 * root to add free space.  So we skip locking and search the commit
-	 * root, since its read-only
-	 */
-	path->skip_locking = 1;
-	path->search_commit_root = 1;
-	path->reada = READA_FORWARD;
-
-	key.objectid = last;
-	key.offset = 0;
-	key.type = BTRFS_EXTENT_ITEM_KEY;
-
-next:
-	ret = btrfs_search_slot(NULL, extent_root, &key, path, 0, 0);
-	if (ret < 0)
-		goto out;
-
-	leaf = path->nodes[0];
-	nritems = btrfs_header_nritems(leaf);
-
-	while (1) {
-		if (btrfs_fs_closing(fs_info) > 1) {
-			last = (u64)-1;
-			break;
-		}
-
-		if (path->slots[0] < nritems) {
-			btrfs_item_key_to_cpu(leaf, &key, path->slots[0]);
-		} else {
-			ret = btrfs_find_next_key(extent_root, path, &key, 0,
-						  0);
-			if (ret)
-				break;
-
-			if (need_resched() ||
-			    rwsem_is_contended(&fs_info->commit_root_sem)) {
-				if (wakeup)
-					caching_ctl->progress = last;
-				btrfs_release_path(path);
-				up_read(&fs_info->commit_root_sem);
-				mutex_unlock(&caching_ctl->mutex);
-				cond_resched();
-				mutex_lock(&caching_ctl->mutex);
-				down_read(&fs_info->commit_root_sem);
-				goto next;
-			}
-
-			ret = btrfs_next_leaf(extent_root, path);
-			if (ret < 0)
-				goto out;
-			if (ret)
-				break;
-			leaf = path->nodes[0];
-			nritems = btrfs_header_nritems(leaf);
-			continue;
-		}
-
-		if (key.objectid < last) {
-			key.objectid = last;
-			key.offset = 0;
-			key.type = BTRFS_EXTENT_ITEM_KEY;
-
-			if (wakeup)
-				caching_ctl->progress = last;
-			btrfs_release_path(path);
-			goto next;
-		}
-
-		if (key.objectid < block_group->key.objectid) {
-			path->slots[0]++;
-			continue;
-		}
-
-		if (key.objectid >= block_group->key.objectid +
-		    block_group->key.offset)
-			break;
-
-		if (key.type == BTRFS_EXTENT_ITEM_KEY ||
-		    key.type == BTRFS_METADATA_ITEM_KEY) {
-			total_found += add_new_free_space(block_group, last,
-							  key.objectid);
-			if (key.type == BTRFS_METADATA_ITEM_KEY)
-				last = key.objectid +
-					fs_info->nodesize;
-			else
-				last = key.objectid + key.offset;
-
-			if (total_found > CACHING_CTL_WAKE_UP) {
-				total_found = 0;
-				if (wakeup)
-					wake_up(&caching_ctl->wait);
-			}
-		}
-		path->slots[0]++;
-	}
-	ret = 0;
-
-	total_found += add_new_free_space(block_group, last,
-					  block_group->key.objectid +
-					  block_group->key.offset);
-	caching_ctl->progress = (u64)-1;
-
-out:
-	btrfs_free_path(path);
-	return ret;
-}
-
-static noinline void caching_thread(struct btrfs_work *work)
-{
-	struct btrfs_block_group_cache *block_group;
-	struct btrfs_fs_info *fs_info;
-	struct btrfs_caching_control *caching_ctl;
-	int ret;
-
-	caching_ctl = container_of(work, struct btrfs_caching_control, work);
-	block_group = caching_ctl->block_group;
-	fs_info = block_group->fs_info;
-
-	mutex_lock(&caching_ctl->mutex);
-	down_read(&fs_info->commit_root_sem);
-
-	if (btrfs_fs_compat_ro(fs_info, FREE_SPACE_TREE))
-		ret = load_free_space_tree(caching_ctl);
-	else
-		ret = load_extent_tree_free(caching_ctl);
-
-	spin_lock(&block_group->lock);
-	block_group->caching_ctl = NULL;
-	block_group->cached = ret ? BTRFS_CACHE_ERROR : BTRFS_CACHE_FINISHED;
-	spin_unlock(&block_group->lock);
-
-#ifdef CONFIG_BTRFS_DEBUG
-	if (btrfs_should_fragment_free_space(block_group)) {
-		u64 bytes_used;
-
-		spin_lock(&block_group->space_info->lock);
-		spin_lock(&block_group->lock);
-		bytes_used = block_group->key.offset -
-			btrfs_block_group_used(&block_group->item);
-		block_group->space_info->bytes_used += bytes_used >> 1;
-		spin_unlock(&block_group->lock);
-		spin_unlock(&block_group->space_info->lock);
-		btrfs_fragment_free_space(block_group);
-	}
-#endif
-
-	caching_ctl->progress = (u64)-1;
-
-	up_read(&fs_info->commit_root_sem);
-	btrfs_free_excluded_extents(block_group);
-	mutex_unlock(&caching_ctl->mutex);
-
-	wake_up(&caching_ctl->wait);
-
-	btrfs_put_caching_control(caching_ctl);
-	btrfs_put_block_group(block_group);
-}
-
-int btrfs_cache_block_group(struct btrfs_block_group_cache *cache,
-			    int load_cache_only)
-{
-	DEFINE_WAIT(wait);
-	struct btrfs_fs_info *fs_info = cache->fs_info;
-	struct btrfs_caching_control *caching_ctl;
-	int ret = 0;
-
-	caching_ctl = kzalloc(sizeof(*caching_ctl), GFP_NOFS);
-	if (!caching_ctl)
-		return -ENOMEM;
-
-	INIT_LIST_HEAD(&caching_ctl->list);
-	mutex_init(&caching_ctl->mutex);
-	init_waitqueue_head(&caching_ctl->wait);
-	caching_ctl->block_group = cache;
-	caching_ctl->progress = cache->key.objectid;
-	refcount_set(&caching_ctl->count, 1);
-	btrfs_init_work(&caching_ctl->work, btrfs_cache_helper,
-			caching_thread, NULL, NULL);
-
-	spin_lock(&cache->lock);
-	/*
-	 * This should be a rare occasion, but this could happen I think in the
-	 * case where one thread starts to load the space cache info, and then
-	 * some other thread starts a transaction commit which tries to do an
-	 * allocation while the other thread is still loading the space cache
-	 * info.  The previous loop should have kept us from choosing this block
-	 * group, but if we've moved to the state where we will wait on caching
-	 * block groups we need to first check if we're doing a fast load here,
-	 * so we can wait for it to finish, otherwise we could end up allocating
-	 * from a block group who's cache gets evicted for one reason or
-	 * another.
-	 */
-	while (cache->cached == BTRFS_CACHE_FAST) {
-		struct btrfs_caching_control *ctl;
-
-		ctl = cache->caching_ctl;
-		refcount_inc(&ctl->count);
-		prepare_to_wait(&ctl->wait, &wait, TASK_UNINTERRUPTIBLE);
-		spin_unlock(&cache->lock);
-
-		schedule();
-
-		finish_wait(&ctl->wait, &wait);
-		btrfs_put_caching_control(ctl);
-		spin_lock(&cache->lock);
-	}
-
-	if (cache->cached != BTRFS_CACHE_NO) {
-		spin_unlock(&cache->lock);
-		kfree(caching_ctl);
-		return 0;
-	}
-	WARN_ON(cache->caching_ctl);
-	cache->caching_ctl = caching_ctl;
-	cache->cached = BTRFS_CACHE_FAST;
-	spin_unlock(&cache->lock);
-
-	if (btrfs_test_opt(fs_info, SPACE_CACHE)) {
-		mutex_lock(&caching_ctl->mutex);
-		ret = load_free_space_cache(cache);
-
-		spin_lock(&cache->lock);
-		if (ret == 1) {
-			cache->caching_ctl = NULL;
-			cache->cached = BTRFS_CACHE_FINISHED;
-			cache->last_byte_to_unpin = (u64)-1;
-			caching_ctl->progress = (u64)-1;
-		} else {
-			if (load_cache_only) {
-				cache->caching_ctl = NULL;
-				cache->cached = BTRFS_CACHE_NO;
-			} else {
-				cache->cached = BTRFS_CACHE_STARTED;
-				cache->has_caching_ctl = 1;
-			}
-		}
-		spin_unlock(&cache->lock);
-#ifdef CONFIG_BTRFS_DEBUG
-		if (ret == 1 &&
-		    btrfs_should_fragment_free_space(cache)) {
-			u64 bytes_used;
-
-			spin_lock(&cache->space_info->lock);
-			spin_lock(&cache->lock);
-			bytes_used = cache->key.offset -
-				btrfs_block_group_used(&cache->item);
-			cache->space_info->bytes_used += bytes_used >> 1;
-			spin_unlock(&cache->lock);
-			spin_unlock(&cache->space_info->lock);
-			btrfs_fragment_free_space(cache);
-		}
-#endif
-		mutex_unlock(&caching_ctl->mutex);
-
-		wake_up(&caching_ctl->wait);
-		if (ret == 1) {
-			btrfs_put_caching_control(caching_ctl);
-			btrfs_free_excluded_extents(cache);
-			return 0;
-		}
-	} else {
-		/*
-		 * We're either using the free space tree or no caching at all.
-		 * Set cached to the appropriate value and wakeup any waiters.
-		 */
-		spin_lock(&cache->lock);
-		if (load_cache_only) {
-			cache->caching_ctl = NULL;
-			cache->cached = BTRFS_CACHE_NO;
-		} else {
-			cache->cached = BTRFS_CACHE_STARTED;
-			cache->has_caching_ctl = 1;
-		}
-		spin_unlock(&cache->lock);
-		wake_up(&caching_ctl->wait);
-	}
-
-	if (load_cache_only) {
-		btrfs_put_caching_control(caching_ctl);
-		return 0;
-	}
-
-	down_write(&fs_info->commit_root_sem);
-	refcount_inc(&caching_ctl->count);
-	list_add_tail(&caching_ctl->list, &fs_info->caching_block_groups);
-	up_write(&fs_info->commit_root_sem);
-
-	btrfs_get_block_group(cache);
-
-	btrfs_queue_work(fs_info->caching_workers, &caching_ctl->work);
-
-	return ret;
-}
-
-
 static u64 generic_ref_to_space_flags(struct btrfs_ref *ref)
 {
 	if (ref->type == BTRFS_REF_METADATA) {
@@ -4924,52 +4509,6 @@ int btrfs_free_extent(struct btrfs_trans_handle *trans, struct btrfs_ref *ref)
 	return ret;
 }
 
-/*
- * when we wait for progress in the block group caching, its because
- * our allocation attempt failed at least once.  So, we must sleep
- * and let some progress happen before we try again.
- *
- * This function will sleep at least once waiting for new free space to
- * show up, and then it will check the block group free space numbers
- * for our min num_bytes.  Another option is to have it go ahead
- * and look in the rbtree for a free extent of a given size, but this
- * is a good start.
- *
- * Callers of this must check if cache->cached == BTRFS_CACHE_ERROR before using
- * any of the information in this block group.
- */
-void
-btrfs_wait_block_group_cache_progress(struct btrfs_block_group_cache *cache,
-				      u64 num_bytes)
-{
-	struct btrfs_caching_control *caching_ctl;
-
-	caching_ctl = btrfs_get_caching_control(cache);
-	if (!caching_ctl)
-		return;
-
-	wait_event(caching_ctl->wait, btrfs_block_group_cache_done(cache) ||
-		   (cache->free_space_ctl->free_space >= num_bytes));
-
-	btrfs_put_caching_control(caching_ctl);
-}
-
-int btrfs_wait_block_group_cache_done(struct btrfs_block_group_cache *cache)
-{
-	struct btrfs_caching_control *caching_ctl;
-	int ret = 0;
-
-	caching_ctl = btrfs_get_caching_control(cache);
-	if (!caching_ctl)
-		return (cache->cached == BTRFS_CACHE_ERROR) ? -EIO : 0;
-
-	wait_event(caching_ctl->wait, btrfs_block_group_cache_done(cache));
-	if (cache->cached == BTRFS_CACHE_ERROR)
-		ret = -EIO;
-	btrfs_put_caching_control(caching_ctl);
-	return ret;
-}
-
 enum btrfs_loop_type {
 	LOOP_CACHING_NOWAIT = 0,
 	LOOP_CACHING_WAIT = 1,
-- 
2.14.3

