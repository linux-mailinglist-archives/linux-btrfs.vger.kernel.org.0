Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 466051230B3
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Dec 2019 16:44:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727483AbfLQPoN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 17 Dec 2019 10:44:13 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:44822 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727161AbfLQPoM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 17 Dec 2019 10:44:12 -0500
Received: by mail-qk1-f194.google.com with SMTP id w127so8589870qkb.11
        for <linux-btrfs@vger.kernel.org>; Tue, 17 Dec 2019 07:44:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=+gRKu5fNYfKe8jJXEn6okgnklhLMYyfXVRasRZUFPsg=;
        b=SZbTqjCV3KoyUkhGuhhKsB/DaTXB9BBMJbKoYyeTljGjXHs7Mkztcw0T9HLrq5m4kG
         8/VaLptKhS1d8prAMJg3drUhPgX4O0LCi5ZBW+iv9tsOmy1iD5EjinPBynrA//j/PB6O
         dnQNDPLw2NLuqkg1ldJMzwEXo8E3vfrcLLysQOU379vh/Hst8B3mFjoMr2wsrMXuhBwr
         qqyFh0DPcXBVKuijxGmfMliVvYVv/Zsmu5grgRU03LHHgvdVKSvCgp96P6jo1L/c0/yV
         /NKPU7FcQyefJPWqNhvQVAc90FpBfD90U28vIzw4Q9HbolADVOdQckA2tepuLJRHket+
         V3bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+gRKu5fNYfKe8jJXEn6okgnklhLMYyfXVRasRZUFPsg=;
        b=jxP1Si7b3xp1xkEeVHB+9lXTPcWq8kRvXhryLTKPoYP0qKjWm9Nx0oVu/kBe10DbRL
         5gzE2/EP5/0Y9HmxwX1sJ16vSih6+y8zAV2ZJriUIT7EYo/ziO3Zur/iTwQnZjo9S0dS
         nkCpBI9GlnmmG562ey/UIS8qBwURI57vt2ynGDI1oNBjrEpNtHAtncGWYVex81XBMMud
         hIUMgZQDgmxW0Q+Dl/7guRfBgLCIIk5cMClvUgLVNA15/0/OGE0yyM/w7rSpHRq6nLsy
         w6rnVOxt5pzv4tSsml0R4pkrVL3waRpLB+tcvXUVAzPt0R6X8eS+hLXLuoxTokhIN1OU
         LtEA==
X-Gm-Message-State: APjAAAVpb2lvEV6YzymC8U9W+48JHY0JGZyPyMhQnOepxPViKtXr03/N
        IhQcN4V3P0Z94iZeW/HdRjNzj3kBo5xYxw==
X-Google-Smtp-Source: APXvYqwkYvDvGMY0nahZjWM2w7l2OXzp+qbDR1hOfTNAKpKFe15sFvlZqGAmPECkYLQb8zbhgbQn7A==
X-Received: by 2002:ae9:eb13:: with SMTP id b19mr5607016qkg.6.1576597450817;
        Tue, 17 Dec 2019 07:44:10 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id k4sm5530074qtj.74.2019.12.17.07.44.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2019 07:44:10 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 2/7] btrfs: move the root freeing stuff into btrfs_put_root
Date:   Tue, 17 Dec 2019 10:43:59 -0500
Message-Id: <20191217154404.44831-3-josef@toxicpanda.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191217154404.44831-1-josef@toxicpanda.com>
References: <20191217154404.44831-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

There are a few different ways to free roots, either you allocated them
yourself and you just do

free_extent_buffer(root->node);
free_extent_buffer(root->commit_node);
btrfs_put_root(root);

Which is the pattern for log roots.  Or for snapshots/subvolumes that
are being dropped you simply call btrfs_free_fs_root() which does all
the cleanup for you.

Unify this all into btrfs_put_root(), so that we don't free up things
associated with the root until the last reference is dropped.  This
makes the root freeing code much more significant.

The only caveat is at close_ctree() time we have to free the extent
buffers for all of our main roots (extent_root, chunk_root, etc) because
we have to drop the btree_inode and we'll run into issues if we hold
onto those nodes until ->kill_sb() time.  This will be addressed in the
future when we kill the btree_inode.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/disk-io.c           | 66 ++++++++++++++++++------------------
 fs/btrfs/disk-io.h           | 16 +--------
 fs/btrfs/extent-tree.c       |  7 ++--
 fs/btrfs/extent_io.c         | 16 +++++++--
 fs/btrfs/free-space-tree.c   |  2 --
 fs/btrfs/qgroup.c            |  7 +---
 fs/btrfs/relocation.c        |  4 ---
 fs/btrfs/tests/btrfs-tests.c |  5 +--
 fs/btrfs/tree-log.c          |  6 ----
 9 files changed, 51 insertions(+), 78 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 3ab285f7ce84..c77a4da2a62e 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -1306,11 +1306,8 @@ struct btrfs_root *btrfs_create_tree(struct btrfs_trans_handle *trans,
 	return root;
 
 fail:
-	if (leaf) {
+	if (leaf)
 		btrfs_tree_unlock(leaf);
-		free_extent_buffer(root->commit_root);
-		free_extent_buffer(leaf);
-	}
 	btrfs_put_root(root);
 
 	return ERR_PTR(ret);
@@ -1433,10 +1430,10 @@ struct btrfs_root *btrfs_read_tree_root(struct btrfs_root *tree_root,
 				     generation, level, NULL);
 	if (IS_ERR(root->node)) {
 		ret = PTR_ERR(root->node);
+		root->node = NULL;
 		goto find_fail;
 	} else if (!btrfs_buffer_uptodate(root->node, generation, 0)) {
 		ret = -EIO;
-		free_extent_buffer(root->node);
 		goto find_fail;
 	}
 	root->commit_root = btrfs_root_node(root);
@@ -1665,14 +1662,14 @@ struct btrfs_root *btrfs_get_fs_root(struct btrfs_fs_info *fs_info,
 	if (ret) {
 		btrfs_put_root(root);
 		if (ret == -EEXIST) {
-			btrfs_free_fs_root(root);
+			btrfs_put_root(root);
 			goto again;
 		}
 		goto fail;
 	}
 	return root;
 fail:
-	btrfs_free_fs_root(root);
+	btrfs_put_root(root);
 	return ERR_PTR(ret);
 }
 
@@ -2042,11 +2039,36 @@ static void free_root_pointers(struct btrfs_fs_info *info, bool free_chunk_root)
 	free_root_extent_buffers(info->csum_root);
 	free_root_extent_buffers(info->quota_root);
 	free_root_extent_buffers(info->uuid_root);
+	free_root_extent_buffers(info->fs_root);
 	if (free_chunk_root)
 		free_root_extent_buffers(info->chunk_root);
 	free_root_extent_buffers(info->free_space_root);
 }
 
+void btrfs_put_root(struct btrfs_root *root)
+{
+	if (!root)
+		return;
+	if (refcount_dec_and_test(&root->refs)) {
+		iput(root->ino_cache_inode);
+		WARN_ON(!RB_EMPTY_ROOT(&root->inode_tree));
+		if (root->anon_dev)
+			free_anon_bdev(root->anon_dev);
+		if (root->subv_writers)
+			btrfs_free_subvolume_writers(root->subv_writers);
+		free_extent_buffer(root->node);
+		free_extent_buffer(root->commit_root);
+		kfree(root->free_ino_ctl);
+		kfree(root->free_ino_pinned);
+#ifdef CONFIG_BTRFS_DEBUG
+		spin_lock(&root->fs_info->fs_roots_radix_lock);
+		list_del_init(&root->leak_list);
+		spin_unlock(&root->fs_info->fs_roots_radix_lock);
+#endif
+		kfree(root);
+	}
+}
+
 void btrfs_free_fs_roots(struct btrfs_fs_info *fs_info)
 {
 	int ret;
@@ -2058,13 +2080,10 @@ void btrfs_free_fs_roots(struct btrfs_fs_info *fs_info)
 				     struct btrfs_root, root_list);
 		list_del(&gang[0]->root_list);
 
-		if (test_bit(BTRFS_ROOT_IN_RADIX, &gang[0]->state)) {
+		if (test_bit(BTRFS_ROOT_IN_RADIX, &gang[0]->state))
 			btrfs_drop_and_free_fs_root(fs_info, gang[0]);
-		} else {
-			free_extent_buffer(gang[0]->node);
-			free_extent_buffer(gang[0]->commit_root);
+		else
 			btrfs_put_root(gang[0]);
-		}
 	}
 
 	while (1) {
@@ -2268,11 +2287,11 @@ static int btrfs_replay_log(struct btrfs_fs_info *fs_info,
 	if (IS_ERR(log_tree_root->node)) {
 		btrfs_warn(fs_info, "failed to read log tree");
 		ret = PTR_ERR(log_tree_root->node);
+		log_tree_root->node = NULL;
 		btrfs_put_root(log_tree_root);
 		return ret;
 	} else if (!extent_buffer_uptodate(log_tree_root->node)) {
 		btrfs_err(fs_info, "failed to read log tree");
-		free_extent_buffer(log_tree_root->node);
 		btrfs_put_root(log_tree_root);
 		return -EIO;
 	}
@@ -2281,7 +2300,6 @@ static int btrfs_replay_log(struct btrfs_fs_info *fs_info,
 	if (ret) {
 		btrfs_handle_fs_error(fs_info, ret,
 				      "Failed to recover log tree");
-		free_extent_buffer(log_tree_root->node);
 		btrfs_put_root(log_tree_root);
 		return ret;
 	}
@@ -3894,8 +3912,6 @@ void btrfs_drop_and_free_fs_root(struct btrfs_fs_info *fs_info,
 	if (test_bit(BTRFS_FS_STATE_ERROR, &fs_info->fs_state)) {
 		btrfs_free_log(NULL, root);
 		if (root->reloc_root) {
-			free_extent_buffer(root->reloc_root->node);
-			free_extent_buffer(root->reloc_root->commit_root);
 			btrfs_put_root(root->reloc_root);
 			root->reloc_root = NULL;
 		}
@@ -3905,21 +3921,6 @@ void btrfs_drop_and_free_fs_root(struct btrfs_fs_info *fs_info,
 		__btrfs_remove_free_space_cache(root->free_ino_pinned);
 	if (root->free_ino_ctl)
 		__btrfs_remove_free_space_cache(root->free_ino_ctl);
-	btrfs_free_fs_root(root);
-}
-
-void btrfs_free_fs_root(struct btrfs_root *root)
-{
-	iput(root->ino_cache_inode);
-	WARN_ON(!RB_EMPTY_ROOT(&root->inode_tree));
-	if (root->anon_dev)
-		free_anon_bdev(root->anon_dev);
-	if (root->subv_writers)
-		btrfs_free_subvolume_writers(root->subv_writers);
-	free_extent_buffer(root->node);
-	free_extent_buffer(root->commit_root);
-	kfree(root->free_ino_ctl);
-	kfree(root->free_ino_pinned);
 	btrfs_put_root(root);
 }
 
@@ -4068,8 +4069,6 @@ void __cold close_ctree(struct btrfs_fs_info *fs_info)
 	btrfs_sysfs_remove_mounted(fs_info);
 	btrfs_sysfs_remove_fsid(fs_info->fs_devices);
 
-	btrfs_free_fs_roots(fs_info);
-
 	btrfs_put_block_group_cache(fs_info);
 
 	/*
@@ -4083,6 +4082,7 @@ void __cold close_ctree(struct btrfs_fs_info *fs_info)
 
 	clear_bit(BTRFS_FS_OPEN, &fs_info->flags);
 	free_root_pointers(fs_info, true);
+	btrfs_free_fs_roots(fs_info);
 
 	iput(fs_info->btree_inode);
 
diff --git a/fs/btrfs/disk-io.h b/fs/btrfs/disk-io.h
index 37e62cda2f52..17d1df3341ed 100644
--- a/fs/btrfs/disk-io.h
+++ b/fs/btrfs/disk-io.h
@@ -76,7 +76,6 @@ void btrfs_btree_balance_dirty(struct btrfs_fs_info *fs_info);
 void btrfs_btree_balance_dirty_nodelay(struct btrfs_fs_info *fs_info);
 void btrfs_drop_and_free_fs_root(struct btrfs_fs_info *fs_info,
 				 struct btrfs_root *root);
-void btrfs_free_fs_root(struct btrfs_root *root);
 
 #ifdef CONFIG_BTRFS_FS_RUN_SANITY_TESTS
 struct btrfs_root *btrfs_alloc_dummy_root(struct btrfs_fs_info *fs_info);
@@ -98,20 +97,7 @@ static inline struct btrfs_root *btrfs_grab_root(struct btrfs_root *root)
 	return NULL;
 }
 
-static inline void btrfs_put_root(struct btrfs_root *root)
-{
-	if (!root)
-		return;
-	if (refcount_dec_and_test(&root->refs)) {
-#ifdef CONFIG_BTRFS_DEBUG
-		spin_lock(&root->fs_info->fs_roots_radix_lock);
-		list_del_init(&root->leak_list);
-		spin_unlock(&root->fs_info->fs_roots_radix_lock);
-#endif
-		kfree(root);
-	}
-}
-
+void btrfs_put_root(struct btrfs_root *root);
 void btrfs_mark_buffer_dirty(struct extent_buffer *buf);
 int btrfs_buffer_uptodate(struct extent_buffer *buf, u64 parent_transid,
 			  int atomic);
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 04ad2100ecc1..9f105acd8cbb 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -5410,13 +5410,10 @@ int btrfs_drop_snapshot(struct btrfs_root *root,
 		}
 	}
 
-	if (test_bit(BTRFS_ROOT_IN_RADIX, &root->state)) {
+	if (test_bit(BTRFS_ROOT_IN_RADIX, &root->state))
 		btrfs_add_dropped_root(trans, root);
-	} else {
-		free_extent_buffer(root->node);
-		free_extent_buffer(root->commit_root);
+	else
 		btrfs_put_root(root);
-	}
 	root_dropped = true;
 out_end_trans:
 	btrfs_end_transaction_throttle(trans);
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 3057d4934206..e374411ed08c 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -64,12 +64,20 @@ void btrfs_extent_buffer_leak_debug_check(struct btrfs_fs_info *fs_info)
 	struct extent_buffer *eb;
 	unsigned long flags;
 
+	/*
+	 * If we didn't get into open_ctree our alloced_ebs will not be init'ed,
+	 * so just skip this.
+	 */
+	if (fs_info->alloced_ebs.next == NULL)
+		return;
+
 	spin_lock_irqsave(&fs_info->eb_leak_lock, flags);
 	while (!list_empty(&fs_info->alloced_ebs)) {
 		eb = list_first_entry(&fs_info->alloced_ebs,
 				      struct extent_buffer, leak_list);
-		pr_err("BTRFS: buffer leak start %llu len %lu refs %d bflags %lu\n",
-		       eb->start, eb->len, atomic_read(&eb->refs), eb->bflags);
+		pr_err("BTRFS: buffer leak start %llu len %lu refs %d bflags %lu owner %llu\n",
+		       eb->start, eb->len, atomic_read(&eb->refs), eb->bflags,
+		       btrfs_header_owner(eb));
 		list_del(&eb->leak_list);
 		kmem_cache_free(extent_buffer_cache, eb);
 	}
@@ -4806,7 +4814,6 @@ int extent_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 
 static void __free_extent_buffer(struct extent_buffer *eb)
 {
-	btrfs_leak_debug_del(&eb->fs_info->eb_leak_lock, &eb->leak_list);
 	kmem_cache_free(extent_buffer_cache, eb);
 }
 
@@ -4872,6 +4879,7 @@ static void btrfs_release_extent_buffer_pages(struct extent_buffer *eb)
 static inline void btrfs_release_extent_buffer(struct extent_buffer *eb)
 {
 	btrfs_release_extent_buffer_pages(eb);
+	btrfs_leak_debug_del(&eb->fs_info->eb_leak_lock, &eb->leak_list);
 	__free_extent_buffer(eb);
 }
 
@@ -5257,6 +5265,8 @@ static int release_extent_buffer(struct extent_buffer *eb)
 			spin_unlock(&eb->refs_lock);
 		}
 
+		btrfs_leak_debug_del(&eb->fs_info->eb_leak_lock,
+				     &eb->leak_list);
 		/* Should be safe to release our pages at this point */
 		btrfs_release_extent_buffer_pages(eb);
 #ifdef CONFIG_BTRFS_FS_RUN_SANITY_TESTS
diff --git a/fs/btrfs/free-space-tree.c b/fs/btrfs/free-space-tree.c
index bc43950eb32f..8b1f5c8897b7 100644
--- a/fs/btrfs/free-space-tree.c
+++ b/fs/btrfs/free-space-tree.c
@@ -1251,8 +1251,6 @@ int btrfs_clear_free_space_tree(struct btrfs_fs_info *fs_info)
 	btrfs_free_tree_block(trans, free_space_root, free_space_root->node,
 			      0, 1);
 
-	free_extent_buffer(free_space_root->node);
-	free_extent_buffer(free_space_root->commit_root);
 	btrfs_put_root(free_space_root);
 
 	return btrfs_commit_transaction(trans);
diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index 8fb576495be9..73b2e1c652c3 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -1037,11 +1037,8 @@ int btrfs_quota_enable(struct btrfs_fs_info *fs_info)
 out_free_path:
 	btrfs_free_path(path);
 out_free_root:
-	if (ret) {
-		free_extent_buffer(quota_root->node);
-		free_extent_buffer(quota_root->commit_root);
+	if (ret)
 		btrfs_put_root(quota_root);
-	}
 out:
 	if (ret) {
 		ulist_free(fs_info->qgroup_ulist);
@@ -1104,8 +1101,6 @@ int btrfs_quota_disable(struct btrfs_fs_info *fs_info)
 	btrfs_tree_unlock(quota_root->node);
 	btrfs_free_tree_block(trans, quota_root, quota_root->node, 0, 1);
 
-	free_extent_buffer(quota_root->node);
-	free_extent_buffer(quota_root->commit_root);
 	btrfs_put_root(quota_root);
 
 end_trans:
diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 754f18e8019b..705d12d4b631 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -2462,10 +2462,6 @@ void free_reloc_roots(struct list_head *list)
 		reloc_root = list_entry(list->next, struct btrfs_root,
 					root_list);
 		__del_reloc_root(reloc_root);
-		free_extent_buffer(reloc_root->node);
-		free_extent_buffer(reloc_root->commit_root);
-		reloc_root->node = NULL;
-		reloc_root->commit_root = NULL;
 	}
 }
 
diff --git a/fs/btrfs/tests/btrfs-tests.c b/fs/btrfs/tests/btrfs-tests.c
index c1a541fa272a..c077f1011797 100644
--- a/fs/btrfs/tests/btrfs-tests.c
+++ b/fs/btrfs/tests/btrfs-tests.c
@@ -165,6 +165,7 @@ void btrfs_free_dummy_fs_info(struct btrfs_fs_info *fs_info)
 	cleanup_srcu_struct(&fs_info->subvol_srcu);
 	kfree(fs_info->super_copy);
 	btrfs_check_leaked_roots(fs_info);
+	btrfs_extent_buffer_leak_debug_check(fs_info);
 	kfree(fs_info->fs_devices);
 	kfree(fs_info);
 }
@@ -176,10 +177,6 @@ void btrfs_free_dummy_root(struct btrfs_root *root)
 	/* Will be freed by btrfs_free_fs_roots */
 	if (WARN_ON(test_bit(BTRFS_ROOT_IN_RADIX, &root->state)))
 		return;
-	if (root->node) {
-		/* One for allocate_extent_buffer */
-		free_extent_buffer(root->node);
-	}
 	btrfs_put_root(root);
 }
 
diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 968605b901ed..19364940f9a1 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -3295,7 +3295,6 @@ static void free_log_tree(struct btrfs_trans_handle *trans,
 
 	clear_extent_bits(&log->dirty_log_pages, 0, (u64)-1,
 			  EXTENT_DIRTY | EXTENT_NEW | EXTENT_NEED_WAIT);
-	free_extent_buffer(log->node);
 	btrfs_put_root(log);
 }
 
@@ -6310,8 +6309,6 @@ int btrfs_recover_log_trees(struct btrfs_root *log_root_tree)
 				ret = btrfs_pin_extent_for_log_replay(fs_info,
 							log->node->start,
 							log->node->len);
-			free_extent_buffer(log->node);
-			free_extent_buffer(log->commit_root);
 			btrfs_put_root(log);
 
 			if (!ret)
@@ -6349,8 +6346,6 @@ int btrfs_recover_log_trees(struct btrfs_root *log_root_tree)
 
 		wc.replay_dest->log_root = NULL;
 		btrfs_put_root(wc.replay_dest);
-		free_extent_buffer(log->node);
-		free_extent_buffer(log->commit_root);
 		btrfs_put_root(log);
 
 		if (ret)
@@ -6382,7 +6377,6 @@ int btrfs_recover_log_trees(struct btrfs_root *log_root_tree)
 	if (ret)
 		return ret;
 
-	free_extent_buffer(log_root_tree->node);
 	log_root_tree->log_root = NULL;
 	clear_bit(BTRFS_FS_LOG_RECOVERING, &fs_info->flags);
 	btrfs_put_root(log_root_tree);
-- 
2.23.0

