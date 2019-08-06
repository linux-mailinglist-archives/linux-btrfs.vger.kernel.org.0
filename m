Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8294B836EA
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Aug 2019 18:30:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732766AbfHFQ3a (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 6 Aug 2019 12:29:30 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:39135 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387947AbfHFQ3E (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 6 Aug 2019 12:29:04 -0400
Received: by mail-qt1-f194.google.com with SMTP id l9so85089643qtu.6
        for <linux-btrfs@vger.kernel.org>; Tue, 06 Aug 2019 09:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=58sDT4y4QgzE83sglx0MDv0TvhWsxtp73xw/AiYvZGw=;
        b=wJNqnm+qaW+93ltN3s07C5FOqFJPq/XIZre7WUbOsh2IPjEMyd2ALR2mS0xGN/g86A
         NRsJXrbEbtpZ66cQbKwdYV7ALj0DoieY5wKjNYlT6l20XEiWn99gwzAMGxSPCF1UKD2P
         15O/BrAGTKTHM9DNbhg3j8WBQIkM85187W4xBwhz18+NnSO8PzkubcupHNFXhic7lWXn
         ovJfu9uT7IpOKOh9jSylU4uYmhIN+MQA5vkK+rO3WqmIDagpb6KJGEVfkWW38W3KWGyu
         nfVJ1fRmJGeai+cppH7BXcnWXlWt3Aah8WkP4Wf0bL/yq81rpnowY3mg+WSiiV3353LK
         +wwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=58sDT4y4QgzE83sglx0MDv0TvhWsxtp73xw/AiYvZGw=;
        b=l/KlmTC0Q+sX/llvW5l6Xskhyr+PemD2WJ/W1YwT6qwut+xk/k80idC3Hk3nRzdKCV
         +OxVGQxkBlzdAoAxLpM5AU0e4c68Z6LzK7rIBGLn6pN9QR+/8n2Vk4VUvVP/JYzEE30x
         Qt2zMbg+pR0GNbu5isAekGyv3E7756bQALCGvBVFbuGQNijZcz6yqmyMUwdHa7owiS/I
         1af9Isf7h08/+kTBDnpyFL7YSwtwTubORMZiw4ehQEd49mC+v9uWU59LGiJs/4DTJeeG
         sQ16TKCTHnJ+BKM35UZ0vq/Ip4lQ48VMBEv7YTi+RzOk/pLE8AKmgVJjP/vnTaH+FPcp
         Dzlw==
X-Gm-Message-State: APjAAAWz9j2YHRFptHICKhgF6tbUEg2MHFQ+55HFnBk4N4q8tLc5mH9i
        q6sY7ZaJzXDZW70+OpubPoyOt/Wa0obevQ==
X-Google-Smtp-Source: APXvYqz04NIfR3Mx+qiH85Fb1SjjHdFmpu7F4eVGRWFpFKlAjtAJ3QfnzD+/mXxagtIRrXfup2yoZg==
X-Received: by 2002:ac8:1a7d:: with SMTP id q58mr3763634qtk.310.1565108943310;
        Tue, 06 Aug 2019 09:29:03 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id n3sm36043333qkk.54.2019.08.06.09.29.02
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 06 Aug 2019 09:29:02 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     kernel-team@fb.com, linux-btrfs@vger.kernel.org
Subject: [PATCH 13/15] btrfs: migrate the block group cleanup code
Date:   Tue,  6 Aug 2019 12:28:35 -0400
Message-Id: <20190806162837.15840-14-josef@toxicpanda.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190806162837.15840-1-josef@toxicpanda.com>
References: <20190806162837.15840-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This can now be easily migrated as well.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/block-group.c | 128 +++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/block-group.h |   2 +
 fs/btrfs/ctree.h       |   2 -
 fs/btrfs/extent-tree.c | 128 -----------------------------------------
 4 files changed, 130 insertions(+), 130 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 330f96134ffb..451dfd64ed36 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -3053,3 +3053,131 @@ int btrfs_chunk_alloc(struct btrfs_trans_handle *trans, u64 flags,
 
 	return ret;
 }
+
+void btrfs_put_block_group_cache(struct btrfs_fs_info *info)
+{
+	struct btrfs_block_group_cache *block_group;
+	u64 last = 0;
+
+	while (1) {
+		struct inode *inode;
+
+		block_group = btrfs_lookup_first_block_group(info, last);
+		while (block_group) {
+			btrfs_wait_block_group_cache_done(block_group);
+			spin_lock(&block_group->lock);
+			if (block_group->iref)
+				break;
+			spin_unlock(&block_group->lock);
+			block_group = btrfs_next_block_group(block_group);
+		}
+		if (!block_group) {
+			if (last == 0)
+				break;
+			last = 0;
+			continue;
+		}
+
+		inode = block_group->inode;
+		block_group->iref = 0;
+		block_group->inode = NULL;
+		spin_unlock(&block_group->lock);
+		ASSERT(block_group->io_ctl.inode == NULL);
+		iput(inode);
+		last = block_group->key.objectid + block_group->key.offset;
+		btrfs_put_block_group(block_group);
+	}
+}
+
+/*
+ * Must be called only after stopping all workers, since we could have block
+ * group caching kthreads running, and therefore they could race with us if we
+ * freed the block groups before stopping them.
+ */
+int btrfs_free_block_groups(struct btrfs_fs_info *info)
+{
+	struct btrfs_block_group_cache *block_group;
+	struct btrfs_space_info *space_info;
+	struct btrfs_caching_control *caching_ctl;
+	struct rb_node *n;
+
+	down_write(&info->commit_root_sem);
+	while (!list_empty(&info->caching_block_groups)) {
+		caching_ctl = list_entry(info->caching_block_groups.next,
+					 struct btrfs_caching_control, list);
+		list_del(&caching_ctl->list);
+		btrfs_put_caching_control(caching_ctl);
+	}
+	up_write(&info->commit_root_sem);
+
+	spin_lock(&info->unused_bgs_lock);
+	while (!list_empty(&info->unused_bgs)) {
+		block_group = list_first_entry(&info->unused_bgs,
+					       struct btrfs_block_group_cache,
+					       bg_list);
+		list_del_init(&block_group->bg_list);
+		btrfs_put_block_group(block_group);
+	}
+	spin_unlock(&info->unused_bgs_lock);
+
+	spin_lock(&info->block_group_cache_lock);
+	while ((n = rb_last(&info->block_group_cache_tree)) != NULL) {
+		block_group = rb_entry(n, struct btrfs_block_group_cache,
+				       cache_node);
+		rb_erase(&block_group->cache_node,
+			 &info->block_group_cache_tree);
+		RB_CLEAR_NODE(&block_group->cache_node);
+		spin_unlock(&info->block_group_cache_lock);
+
+		down_write(&block_group->space_info->groups_sem);
+		list_del(&block_group->list);
+		up_write(&block_group->space_info->groups_sem);
+
+		/*
+		 * We haven't cached this block group, which means we could
+		 * possibly have excluded extents on this block group.
+		 */
+		if (block_group->cached == BTRFS_CACHE_NO ||
+		    block_group->cached == BTRFS_CACHE_ERROR)
+			btrfs_free_excluded_extents(block_group);
+
+		btrfs_remove_free_space_cache(block_group);
+		ASSERT(block_group->cached != BTRFS_CACHE_STARTED);
+		ASSERT(list_empty(&block_group->dirty_list));
+		ASSERT(list_empty(&block_group->io_list));
+		ASSERT(list_empty(&block_group->bg_list));
+		ASSERT(atomic_read(&block_group->count) == 1);
+		btrfs_put_block_group(block_group);
+
+		spin_lock(&info->block_group_cache_lock);
+	}
+	spin_unlock(&info->block_group_cache_lock);
+
+	/* now that all the block groups are freed, go through and
+	 * free all the space_info structs.  This is only called during
+	 * the final stages of unmount, and so we know nobody is
+	 * using them.  We call synchronize_rcu() once before we start,
+	 * just to be on the safe side.
+	 */
+	synchronize_rcu();
+
+	btrfs_release_global_block_rsv(info);
+
+	while (!list_empty(&info->space_info)) {
+		space_info = list_entry(info->space_info.next,
+					struct btrfs_space_info,
+					list);
+
+		/*
+		 * Do not hide this behind enospc_debug, this is actually
+		 * important and indicates a real bug if this happens.
+		 */
+		if (WARN_ON(space_info->bytes_pinned > 0 ||
+			    space_info->bytes_reserved > 0 ||
+			    space_info->bytes_may_use > 0))
+			btrfs_dump_space_info(info, space_info, 0, 0);
+		list_del(&space_info->list);
+		btrfs_sysfs_remove_space_info(space_info);
+	}
+	return 0;
+}
diff --git a/fs/btrfs/block-group.h b/fs/btrfs/block-group.h
index ab5434ddd7f4..2647c0aa76b8 100644
--- a/fs/btrfs/block-group.h
+++ b/fs/btrfs/block-group.h
@@ -224,6 +224,8 @@ int btrfs_chunk_alloc(struct btrfs_trans_handle *trans, u64 flags,
 int btrfs_force_chunk_alloc(struct btrfs_trans_handle *trans, u64 type);
 void check_system_chunk(struct btrfs_trans_handle *trans, const u64 type);
 u64 btrfs_get_alloc_profile(struct btrfs_fs_info *fs_info, u64 orig_flags);
+void btrfs_put_block_group_cache(struct btrfs_fs_info *info);
+int btrfs_free_block_groups(struct btrfs_fs_info *info);
 
 static inline u64 btrfs_data_alloc_profile(struct btrfs_fs_info *fs_info)
 {
diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index fab6e9792d23..00c52b4a4dc6 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -2522,7 +2522,6 @@ int btrfs_inc_extent_ref(struct btrfs_trans_handle *trans,
 			 struct btrfs_ref *generic_ref);
 
 int btrfs_extent_readonly(struct btrfs_fs_info *fs_info, u64 bytenr);
-int btrfs_free_block_groups(struct btrfs_fs_info *info);
 void btrfs_get_block_group_trimming(struct btrfs_block_group_cache *cache);
 void btrfs_put_block_group_trimming(struct btrfs_block_group_cache *cache);
 void btrfs_clear_space_info_full(struct btrfs_fs_info *info);
@@ -2561,7 +2560,6 @@ void btrfs_delalloc_release_extents(struct btrfs_inode *inode, u64 num_bytes,
 				    bool qgroup_free);
 
 int btrfs_delalloc_reserve_metadata(struct btrfs_inode *inode, u64 num_bytes);
-void btrfs_put_block_group_cache(struct btrfs_fs_info *info);
 u64 btrfs_account_ro_block_groups_free_space(struct btrfs_space_info *sinfo);
 int btrfs_error_unpin_extent_range(struct btrfs_fs_info *fs_info,
 				   u64 start, u64 end);
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 40e4f2ce4952..f483345715b1 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -5654,134 +5654,6 @@ u64 btrfs_account_ro_block_groups_free_space(struct btrfs_space_info *sinfo)
 	return free_bytes;
 }
 
-void btrfs_put_block_group_cache(struct btrfs_fs_info *info)
-{
-	struct btrfs_block_group_cache *block_group;
-	u64 last = 0;
-
-	while (1) {
-		struct inode *inode;
-
-		block_group = btrfs_lookup_first_block_group(info, last);
-		while (block_group) {
-			btrfs_wait_block_group_cache_done(block_group);
-			spin_lock(&block_group->lock);
-			if (block_group->iref)
-				break;
-			spin_unlock(&block_group->lock);
-			block_group = btrfs_next_block_group(block_group);
-		}
-		if (!block_group) {
-			if (last == 0)
-				break;
-			last = 0;
-			continue;
-		}
-
-		inode = block_group->inode;
-		block_group->iref = 0;
-		block_group->inode = NULL;
-		spin_unlock(&block_group->lock);
-		ASSERT(block_group->io_ctl.inode == NULL);
-		iput(inode);
-		last = block_group->key.objectid + block_group->key.offset;
-		btrfs_put_block_group(block_group);
-	}
-}
-
-/*
- * Must be called only after stopping all workers, since we could have block
- * group caching kthreads running, and therefore they could race with us if we
- * freed the block groups before stopping them.
- */
-int btrfs_free_block_groups(struct btrfs_fs_info *info)
-{
-	struct btrfs_block_group_cache *block_group;
-	struct btrfs_space_info *space_info;
-	struct btrfs_caching_control *caching_ctl;
-	struct rb_node *n;
-
-	down_write(&info->commit_root_sem);
-	while (!list_empty(&info->caching_block_groups)) {
-		caching_ctl = list_entry(info->caching_block_groups.next,
-					 struct btrfs_caching_control, list);
-		list_del(&caching_ctl->list);
-		btrfs_put_caching_control(caching_ctl);
-	}
-	up_write(&info->commit_root_sem);
-
-	spin_lock(&info->unused_bgs_lock);
-	while (!list_empty(&info->unused_bgs)) {
-		block_group = list_first_entry(&info->unused_bgs,
-					       struct btrfs_block_group_cache,
-					       bg_list);
-		list_del_init(&block_group->bg_list);
-		btrfs_put_block_group(block_group);
-	}
-	spin_unlock(&info->unused_bgs_lock);
-
-	spin_lock(&info->block_group_cache_lock);
-	while ((n = rb_last(&info->block_group_cache_tree)) != NULL) {
-		block_group = rb_entry(n, struct btrfs_block_group_cache,
-				       cache_node);
-		rb_erase(&block_group->cache_node,
-			 &info->block_group_cache_tree);
-		RB_CLEAR_NODE(&block_group->cache_node);
-		spin_unlock(&info->block_group_cache_lock);
-
-		down_write(&block_group->space_info->groups_sem);
-		list_del(&block_group->list);
-		up_write(&block_group->space_info->groups_sem);
-
-		/*
-		 * We haven't cached this block group, which means we could
-		 * possibly have excluded extents on this block group.
-		 */
-		if (block_group->cached == BTRFS_CACHE_NO ||
-		    block_group->cached == BTRFS_CACHE_ERROR)
-			btrfs_free_excluded_extents(block_group);
-
-		btrfs_remove_free_space_cache(block_group);
-		ASSERT(block_group->cached != BTRFS_CACHE_STARTED);
-		ASSERT(list_empty(&block_group->dirty_list));
-		ASSERT(list_empty(&block_group->io_list));
-		ASSERT(list_empty(&block_group->bg_list));
-		ASSERT(atomic_read(&block_group->count) == 1);
-		btrfs_put_block_group(block_group);
-
-		spin_lock(&info->block_group_cache_lock);
-	}
-	spin_unlock(&info->block_group_cache_lock);
-
-	/* now that all the block groups are freed, go through and
-	 * free all the space_info structs.  This is only called during
-	 * the final stages of unmount, and so we know nobody is
-	 * using them.  We call synchronize_rcu() once before we start,
-	 * just to be on the safe side.
-	 */
-	synchronize_rcu();
-
-	btrfs_release_global_block_rsv(info);
-
-	while (!list_empty(&info->space_info)) {
-		space_info = list_entry(info->space_info.next,
-					struct btrfs_space_info,
-					list);
-
-		/*
-		 * Do not hide this behind enospc_debug, this is actually
-		 * important and indicates a real bug if this happens.
-		 */
-		if (WARN_ON(space_info->bytes_pinned > 0 ||
-			    space_info->bytes_reserved > 0 ||
-			    space_info->bytes_may_use > 0))
-			btrfs_dump_space_info(info, space_info, 0, 0);
-		list_del(&space_info->list);
-		btrfs_sysfs_remove_space_info(space_info);
-	}
-	return 0;
-}
-
 int btrfs_error_unpin_extent_range(struct btrfs_fs_info *fs_info,
 				   u64 start, u64 end)
 {
-- 
2.21.0

