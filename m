Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 565422970FC
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Oct 2020 15:58:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S373794AbgJWN6Y (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 23 Oct 2020 09:58:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S373787AbgJWN6X (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 23 Oct 2020 09:58:23 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19122C0613D2
        for <linux-btrfs@vger.kernel.org>; Fri, 23 Oct 2020 06:58:23 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id a23so1157497qkg.13
        for <linux-btrfs@vger.kernel.org>; Fri, 23 Oct 2020 06:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=2PkB/qMj06MsTyF4+Cotlo+Y3zPH84MKH4FKFqFuDsA=;
        b=LlbRzB3078v3rp7kaPpXO9kbQ+L5qayh6KZdwxY5/0ELKTBHOzxOyjsHJO8xcoZm0H
         KiJjTaLrma4HQyAeeK4j/gpRbUaRPwZ9/pTIcrtF0XQ6GexGbB/PKCk/Yy3kzNG//rGJ
         /gcJHL4UTo/+zWuCBEn9fd3QgpbT8EVpBDXRG0T2dUdyCJ3HV0b2/AGXWOsIRsgz6Qxe
         F4xS35XgGqUTke1EoBVwOQFSZMgPByXrxBmenmzeZ/B5xBWWQWZhrThWsGIngtfc5Vjq
         o94rbwiK9CK/2XiZnIOgJ26R0jUMr4B4ZwaqgZAzbb/3lchA2XWE7h/Sdmd8b7UCl7vS
         4EXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2PkB/qMj06MsTyF4+Cotlo+Y3zPH84MKH4FKFqFuDsA=;
        b=d/agbJURZnX5V4nrRInjn0PyTiF+6kYjmix9XKzibW6OT6Vwinl1UiI8rWB35jgPpy
         u8rSkh/2jOqqH9f39F0/LDWTp6g8+OMQG4IwsHTsHkPZA0s5HfH2+AzwiJSapjy4rDp1
         Bd49I6fq7wWUDHTOb+39JG0aUBWMpuMfwLV+ThhzsDPoAlz2N+vflqiqdWmj01aEYKmK
         NX+7BQlb9wgbuQhzdbZjbLLCeclO1hRWjxqpyn37ZUiEIkiAc79J+TSOT1xvQt8ajppa
         0T1I+NJEEZ47gOVDyFlP+BTEJtLZsT68pdg/GYyVEEoapFm+FMgiGxdIEP3dhZjibgWO
         UAmQ==
X-Gm-Message-State: AOAM530ETiYGCtkCePM0Q6WbOkZbhnF489gY7vv4vw5dyDmhiD5lvNJo
        PsRKJCQCf9Ctc5hsM8jDBiPJUKBBcg/uUZdn
X-Google-Smtp-Source: ABdhPJzTSCBeYvwMHpZONuEv0zaZNiqrnhbko6vgUnI9j/vt85rPgJS6RBPz8+S1BJhT1R5CFiUMkQ==
X-Received: by 2002:a05:620a:1221:: with SMTP id v1mr2266038qkj.98.1603461501723;
        Fri, 23 Oct 2020 06:58:21 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id g27sm754928qkk.135.2020.10.23.06.58.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2020 06:58:21 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 5/8] btrfs: load free space cache into a temporary ctl
Date:   Fri, 23 Oct 2020 09:58:08 -0400
Message-Id: <a21f2834a44901bc2b685bc3d19db831eca7b8f1.1603460665.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1603460665.git.josef@toxicpanda.com>
References: <cover.1603460665.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The free space cache has been special in that we would load it right
away instead of farming the work off to a worker thread.  This resulted
in some weirdness that had to be taken into account for this fact,
namely that if we every found a block group being cached the fast way we
had to wait for it to finish, because we could get the cache before it
had been validated and we may throw the cache away.

To handle this particular case instead create a temporary
btrfs_free_space_ctl to load the free space cache into.  Then once we've
validated that it makes sense, copy it's contents into the actual
block_group->free_space_ctl.  This allows us to avoid the problems of
needing to wait for the caching to complete, we can clean up the discard
extent handling stuff in __load_free_space_cache, and we no longer need
to do the merge_space_tree() because the space is added one by one into
the real free_space_ctl.  This will allow further reworks of how we
handle loading the free space cache.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/block-group.c       |  29 +------
 fs/btrfs/free-space-cache.c  | 155 +++++++++++++++--------------------
 fs/btrfs/free-space-cache.h  |   3 +-
 fs/btrfs/tests/btrfs-tests.c |   2 +-
 4 files changed, 70 insertions(+), 119 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index bb6685711824..adbd18dc08a1 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -695,33 +695,6 @@ int btrfs_cache_block_group(struct btrfs_block_group *cache, int load_cache_only
 	btrfs_init_work(&caching_ctl->work, caching_thread, NULL, NULL);
 
 	spin_lock(&cache->lock);
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
 	if (cache->cached != BTRFS_CACHE_NO) {
 		spin_unlock(&cache->lock);
 		kfree(caching_ctl);
@@ -1805,7 +1778,7 @@ static struct btrfs_block_group *btrfs_create_block_group_cache(
 	INIT_LIST_HEAD(&cache->discard_list);
 	INIT_LIST_HEAD(&cache->dirty_list);
 	INIT_LIST_HEAD(&cache->io_list);
-	btrfs_init_free_space_ctl(cache);
+	btrfs_init_free_space_ctl(cache, cache->free_space_ctl);
 	atomic_set(&cache->frozen, 0);
 	mutex_init(&cache->free_space_lock);
 	btrfs_init_full_stripe_locks_tree(&cache->full_stripe_locks_root);
diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index 0787339c7b93..58bd2d3e54db 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -33,8 +33,6 @@ struct btrfs_trim_range {
 	struct list_head list;
 };
 
-static int count_bitmap_extents(struct btrfs_free_space_ctl *ctl,
-				struct btrfs_free_space *bitmap_info);
 static int link_free_space(struct btrfs_free_space_ctl *ctl,
 			   struct btrfs_free_space *info);
 static void unlink_free_space(struct btrfs_free_space_ctl *ctl,
@@ -43,6 +41,14 @@ static int btrfs_wait_cache_io_root(struct btrfs_root *root,
 			     struct btrfs_trans_handle *trans,
 			     struct btrfs_io_ctl *io_ctl,
 			     struct btrfs_path *path);
+static int search_bitmap(struct btrfs_free_space_ctl *ctl,
+			 struct btrfs_free_space *bitmap_info, u64 *offset,
+			 u64 *bytes, bool for_alloc);
+static void free_bitmap(struct btrfs_free_space_ctl *ctl,
+			struct btrfs_free_space *bitmap_info);
+static void bitmap_clear_bits(struct btrfs_free_space_ctl *ctl,
+			      struct btrfs_free_space *info, u64 offset,
+			      u64 bytes);
 
 static struct inode *__lookup_free_space_inode(struct btrfs_root *root,
 					       struct btrfs_path *path,
@@ -625,44 +631,6 @@ static int io_ctl_read_bitmap(struct btrfs_io_ctl *io_ctl,
 	return 0;
 }
 
-/*
- * Since we attach pinned extents after the fact we can have contiguous sections
- * of free space that are split up in entries.  This poses a problem with the
- * tree logging stuff since it could have allocated across what appears to be 2
- * entries since we would have merged the entries when adding the pinned extents
- * back to the free space cache.  So run through the space cache that we just
- * loaded and merge contiguous entries.  This will make the log replay stuff not
- * blow up and it will make for nicer allocator behavior.
- */
-static void merge_space_tree(struct btrfs_free_space_ctl *ctl)
-{
-	struct btrfs_free_space *e, *prev = NULL;
-	struct rb_node *n;
-
-again:
-	spin_lock(&ctl->tree_lock);
-	for (n = rb_first(&ctl->free_space_offset); n; n = rb_next(n)) {
-		e = rb_entry(n, struct btrfs_free_space, offset_index);
-		if (!prev)
-			goto next;
-		if (e->bitmap || prev->bitmap)
-			goto next;
-		if (prev->offset + prev->bytes == e->offset) {
-			unlink_free_space(ctl, prev);
-			unlink_free_space(ctl, e);
-			prev->bytes += e->bytes;
-			kmem_cache_free(btrfs_free_space_cachep, e);
-			link_free_space(ctl, prev);
-			prev = NULL;
-			spin_unlock(&ctl->tree_lock);
-			goto again;
-		}
-next:
-		prev = e;
-	}
-	spin_unlock(&ctl->tree_lock);
-}
-
 static int __load_free_space_cache(struct btrfs_root *root, struct inode *inode,
 				   struct btrfs_free_space_ctl *ctl,
 				   struct btrfs_path *path, u64 offset)
@@ -753,16 +721,6 @@ static int __load_free_space_cache(struct btrfs_root *root, struct inode *inode,
 			goto free_cache;
 		}
 
-		/*
-		 * Sync discard ensures that the free space cache is always
-		 * trimmed.  So when reading this in, the state should reflect
-		 * that.  We also do this for async as a stop gap for lack of
-		 * persistence.
-		 */
-		if (btrfs_test_opt(fs_info, DISCARD_SYNC) ||
-		    btrfs_test_opt(fs_info, DISCARD_ASYNC))
-			e->trim_state = BTRFS_TRIM_STATE_TRIMMED;
-
 		if (!e->bytes) {
 			kmem_cache_free(btrfs_free_space_cachep, e);
 			goto free_cache;
@@ -816,16 +774,9 @@ static int __load_free_space_cache(struct btrfs_root *root, struct inode *inode,
 		ret = io_ctl_read_bitmap(&io_ctl, e);
 		if (ret)
 			goto free_cache;
-		e->bitmap_extents = count_bitmap_extents(ctl, e);
-		if (!btrfs_free_space_trimmed(e)) {
-			ctl->discardable_extents[BTRFS_STAT_CURR] +=
-				e->bitmap_extents;
-			ctl->discardable_bytes[BTRFS_STAT_CURR] += e->bytes;
-		}
 	}
 
 	io_ctl_drop_pages(&io_ctl);
-	merge_space_tree(ctl);
 	ret = 1;
 out:
 	io_ctl_free(&io_ctl);
@@ -836,16 +787,59 @@ static int __load_free_space_cache(struct btrfs_root *root, struct inode *inode,
 	goto out;
 }
 
+static int copy_free_space_cache(struct btrfs_block_group *block_group,
+				 struct btrfs_free_space_ctl *ctl)
+{
+	struct btrfs_free_space *info;
+	struct rb_node *n;
+	int ret = 0;
+
+	while (!ret && (n = rb_first(&ctl->free_space_offset)) != NULL) {
+		info = rb_entry(n, struct btrfs_free_space, offset_index);
+		if (!info->bitmap) {
+			unlink_free_space(ctl, info);
+			ret = btrfs_add_free_space(block_group, info->offset,
+						   info->bytes);
+			kmem_cache_free(btrfs_free_space_cachep, info);
+		} else {
+			u64 offset = info->offset;
+			u64 bytes = ctl->unit;
+
+			while (search_bitmap(ctl, info, &offset, &bytes,
+					     false) == 0) {
+				ret = btrfs_add_free_space(block_group, offset,
+							   bytes);
+				if (ret)
+					break;
+				bitmap_clear_bits(ctl, info, offset, bytes);
+				offset = info->offset;
+				bytes = ctl->unit;
+			}
+			free_bitmap(ctl, info);
+		}
+		cond_resched();
+	}
+	return ret;
+}
+
 int load_free_space_cache(struct btrfs_block_group *block_group)
 {
 	struct btrfs_fs_info *fs_info = block_group->fs_info;
 	struct btrfs_free_space_ctl *ctl = block_group->free_space_ctl;
+	struct btrfs_free_space_ctl tmp_ctl = {};
 	struct inode *inode;
 	struct btrfs_path *path;
 	int ret = 0;
 	bool matched;
 	u64 used = block_group->used;
 
+	/*
+	 * Because we could potentially discard our loaded free space, we want
+	 * to load everything into a temporary structure first, and then if it's
+	 * valid copy it all into the actual free space ctl.
+	 */
+	btrfs_init_free_space_ctl(block_group, &tmp_ctl);
+
 	/*
 	 * If this block group has been marked to be cleared for one reason or
 	 * another then we can't trust the on disk cache, so just return.
@@ -897,19 +891,25 @@ int load_free_space_cache(struct btrfs_block_group *block_group)
 	}
 	spin_unlock(&block_group->lock);
 
-	ret = __load_free_space_cache(fs_info->tree_root, inode, ctl,
+	ret = __load_free_space_cache(fs_info->tree_root, inode, &tmp_ctl,
 				      path, block_group->start);
 	btrfs_free_path(path);
 	if (ret <= 0)
 		goto out;
 
-	spin_lock(&ctl->tree_lock);
-	matched = (ctl->free_space == (block_group->length - used -
-				       block_group->bytes_super));
-	spin_unlock(&ctl->tree_lock);
+	matched = (tmp_ctl.free_space == (block_group->length - used -
+					  block_group->bytes_super));
 
-	if (!matched) {
-		__btrfs_remove_free_space_cache(ctl);
+	if (matched) {
+		ret = copy_free_space_cache(block_group, &tmp_ctl);
+		/*
+		 * ret == 1 means we successfully loaded the free space cache,
+		 * so we need to re-set it here.
+		 */
+		if (ret == 0)
+			ret = 1;
+	} else {
+		__btrfs_remove_free_space_cache(&tmp_ctl);
 		btrfs_warn(fs_info,
 			   "block group %llu has wrong amount of free space",
 			   block_group->start);
@@ -1914,29 +1914,6 @@ find_free_space(struct btrfs_free_space_ctl *ctl, u64 *offset, u64 *bytes,
 	return NULL;
 }
 
-static int count_bitmap_extents(struct btrfs_free_space_ctl *ctl,
-				struct btrfs_free_space *bitmap_info)
-{
-	struct btrfs_block_group *block_group = ctl->private;
-	u64 bytes = bitmap_info->bytes;
-	unsigned int rs, re;
-	int count = 0;
-
-	if (!block_group || !bytes)
-		return count;
-
-	bitmap_for_each_set_region(bitmap_info->bitmap, rs, re, 0,
-				   BITS_PER_BITMAP) {
-		bytes -= (rs - re) * ctl->unit;
-		count++;
-
-		if (!bytes)
-			break;
-	}
-
-	return count;
-}
-
 static void add_new_bitmap(struct btrfs_free_space_ctl *ctl,
 			   struct btrfs_free_space *info, u64 offset)
 {
@@ -2676,10 +2653,10 @@ void btrfs_dump_free_space(struct btrfs_block_group *block_group,
 		   "%d blocks of free space at or bigger than bytes is", count);
 }
 
-void btrfs_init_free_space_ctl(struct btrfs_block_group *block_group)
+void btrfs_init_free_space_ctl(struct btrfs_block_group *block_group,
+			       struct btrfs_free_space_ctl *ctl)
 {
 	struct btrfs_fs_info *fs_info = block_group->fs_info;
-	struct btrfs_free_space_ctl *ctl = block_group->free_space_ctl;
 
 	spin_lock_init(&ctl->tree_lock);
 	ctl->unit = fs_info->sectorsize;
diff --git a/fs/btrfs/free-space-cache.h b/fs/btrfs/free-space-cache.h
index e3d5e0ad8f8e..bf8d127d2407 100644
--- a/fs/btrfs/free-space-cache.h
+++ b/fs/btrfs/free-space-cache.h
@@ -109,7 +109,8 @@ int btrfs_write_out_ino_cache(struct btrfs_root *root,
 			      struct btrfs_path *path,
 			      struct inode *inode);
 
-void btrfs_init_free_space_ctl(struct btrfs_block_group *block_group);
+void btrfs_init_free_space_ctl(struct btrfs_block_group *block_group,
+			       struct btrfs_free_space_ctl *ctl);
 int __btrfs_add_free_space(struct btrfs_fs_info *fs_info,
 			   struct btrfs_free_space_ctl *ctl,
 			   u64 bytenr, u64 size,
diff --git a/fs/btrfs/tests/btrfs-tests.c b/fs/btrfs/tests/btrfs-tests.c
index 999c14e5d0bd..8519f7746b2e 100644
--- a/fs/btrfs/tests/btrfs-tests.c
+++ b/fs/btrfs/tests/btrfs-tests.c
@@ -224,7 +224,7 @@ btrfs_alloc_dummy_block_group(struct btrfs_fs_info *fs_info,
 	INIT_LIST_HEAD(&cache->list);
 	INIT_LIST_HEAD(&cache->cluster_list);
 	INIT_LIST_HEAD(&cache->bg_list);
-	btrfs_init_free_space_ctl(cache);
+	btrfs_init_free_space_ctl(cache, cache->free_space_ctl);
 	mutex_init(&cache->free_space_lock);
 
 	return cache;
-- 
2.26.2

