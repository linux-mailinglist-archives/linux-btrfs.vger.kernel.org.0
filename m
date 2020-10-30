Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F4DD2A0FE7
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 Oct 2020 22:03:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727743AbgJ3VDg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 30 Oct 2020 17:03:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726917AbgJ3VDg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 30 Oct 2020 17:03:36 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2BECC0613CF
        for <linux-btrfs@vger.kernel.org>; Fri, 30 Oct 2020 14:03:34 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id s39so5171016qtb.2
        for <linux-btrfs@vger.kernel.org>; Fri, 30 Oct 2020 14:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=/r/I+VsSzk0lIq2a7CMlUV12p+ExOV3xq+9TM7jXnBM=;
        b=p8eyVHCS/GhIuPn8Rke+9alQG14NjF08FJg/YPTxwiiUX72Ex/S79Y49ixzDGDcDe2
         6M8ULbhAxxO8jXf9arUsYpweA8tMQpNduEX+V++WRy9W0YiTf8LMHdoodfAz9NYZzrci
         ovZHqG96Gqu+l0W4EAuyR6S7xlZQ8tpOW93Xngs0a5HjTszo0isFgvYjgTAt/YPPJz7r
         SqoPSqIuuBqgMe7MWxzfxHBB35tYDAidXnnxiW+OnDuF9Wzg92tssX36ikUm4cRP8UIH
         dOvCfG3Bh8Ho/KlXPULGdU4IFOElcPZPxg2DfHoXM6NmTAM0atbdGsVlBPmM5YrrhXj7
         B0Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/r/I+VsSzk0lIq2a7CMlUV12p+ExOV3xq+9TM7jXnBM=;
        b=qnOJ7BbMx4aEELKgv3wT9tH/0vPPcmhK+ZQFxy2kReCjZO1QTglFpQwWA8FP2OCDJu
         Vzs2d9Q26XGhXcdx2GIorh0pKtH4KmXoNIDZwjjk/LD/8xz0b4NRKMINiKMtgiih0aZk
         6Mn8nOiW0XsC5NY2cuP2hL7wj24LPSKFA9DkJITP/TWa46O9Ac/pTVgoyt4JKUQUFPji
         Al78Fjx4k8JNsajkwNQCPFeoBOJiiImmqDQERFTvByEFS/AaSfG5k8hAnJkIy95uADjc
         teIqpp+M2qWalqh9te8WCYbc8iYtENEjHGYbkBdCBIktfmyhec4+j1kpjhlJBa4rn7wT
         fmZQ==
X-Gm-Message-State: AOAM533lr3rwlj0ZevYUxn5wBKW5vettYe0togn5x/Okt7+o4VWjS27M
        WcOEtP8Ou8P6Q2hLe0dDCqN2azLWmWc2PPDz
X-Google-Smtp-Source: ABdhPJz5PjJHUC9nGD9q87fY1rWMofOLJpCgV2koPEqdwX9b6U176g/wui3U/cVR9rVU/RYUhPrf0g==
X-Received: by 2002:ac8:7758:: with SMTP id g24mr4104964qtu.307.1604091813428;
        Fri, 30 Oct 2020 14:03:33 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id t45sm1175985qte.44.2020.10.30.14.03.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2020 14:03:32 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 13/14] btrfs: pass the owner_root and level to alloc_extent_buffer
Date:   Fri, 30 Oct 2020 17:03:05 -0400
Message-Id: <c475f5e160cf156bd65e88a8aae2233e535eb7fc.1604091530.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1604091530.git.josef@toxicpanda.com>
References: <cover.1604091530.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Now that we've plumbed all of the callers to have the owner root and the
level, plumb it down into alloc_extent_buffer().

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/disk-io.c     |  7 ++++---
 fs/btrfs/disk-io.h     |  3 ++-
 fs/btrfs/extent-tree.c |  6 ++++--
 fs/btrfs/extent_io.c   | 13 +++++++++----
 fs/btrfs/extent_io.h   |  5 +++--
 fs/btrfs/reada.c       |  8 +++++---
 fs/btrfs/relocation.c  |  3 ++-
 fs/btrfs/tree-log.c    |  4 +++-
 fs/btrfs/volumes.c     |  3 ++-
 9 files changed, 34 insertions(+), 18 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 8a7f2b26e98a..989412501a92 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -948,11 +948,12 @@ static const struct address_space_operations btree_aops = {
 
 struct extent_buffer *btrfs_find_create_tree_block(
 						struct btrfs_fs_info *fs_info,
-						u64 bytenr)
+						u64 bytenr, u64 owner_root,
+						int level)
 {
 	if (btrfs_is_testing(fs_info))
 		return alloc_test_extent_buffer(fs_info, bytenr);
-	return alloc_extent_buffer(fs_info, bytenr);
+	return alloc_extent_buffer(fs_info, bytenr, owner_root, level);
 }
 
 /*
@@ -971,7 +972,7 @@ struct extent_buffer *read_tree_block(struct btrfs_fs_info *fs_info, u64 bytenr,
 	struct extent_buffer *buf = NULL;
 	int ret;
 
-	buf = btrfs_find_create_tree_block(fs_info, bytenr);
+	buf = btrfs_find_create_tree_block(fs_info, bytenr, owner_root, level);
 	if (IS_ERR(buf))
 		return buf;
 
diff --git a/fs/btrfs/disk-io.h b/fs/btrfs/disk-io.h
index f3bc5ff8a8cf..740667700e6c 100644
--- a/fs/btrfs/disk-io.h
+++ b/fs/btrfs/disk-io.h
@@ -47,7 +47,8 @@ struct extent_buffer *read_tree_block(struct btrfs_fs_info *fs_info, u64 bytenr,
 				      int level, struct btrfs_key *first_key);
 struct extent_buffer *btrfs_find_create_tree_block(
 						struct btrfs_fs_info *fs_info,
-						u64 bytenr);
+						u64 bytenr, u64 owner_root,
+						int level);
 void btrfs_clean_tree_block(struct extent_buffer *buf);
 int __cold open_ctree(struct super_block *sb,
 	       struct btrfs_fs_devices *fs_devices,
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 898b26f1a391..a2c611a83057 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -4662,7 +4662,7 @@ btrfs_init_new_buffer(struct btrfs_trans_handle *trans, struct btrfs_root *root,
 	struct btrfs_fs_info *fs_info = root->fs_info;
 	struct extent_buffer *buf;
 
-	buf = btrfs_find_create_tree_block(fs_info, bytenr);
+	buf = btrfs_find_create_tree_block(fs_info, bytenr, owner, level);
 	if (IS_ERR(buf))
 		return buf;
 
@@ -5064,7 +5064,9 @@ static noinline int do_walk_down(struct btrfs_trans_handle *trans,
 
 	next = find_extent_buffer(fs_info, bytenr);
 	if (!next) {
-		next = btrfs_find_create_tree_block(fs_info, bytenr);
+		next = btrfs_find_create_tree_block(fs_info, bytenr,
+						    root->root_key.objectid,
+						    level - 1);
 		if (IS_ERR(next))
 			return PTR_ERR(next);
 
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 654e2e517f3d..0af8333ccca1 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -5163,7 +5163,7 @@ struct extent_buffer *alloc_test_extent_buffer(struct btrfs_fs_info *fs_info,
 #endif
 
 struct extent_buffer *alloc_extent_buffer(struct btrfs_fs_info *fs_info,
-					  u64 start)
+					  u64 start, u64 owner_root, int level)
 {
 	unsigned long len = fs_info->nodesize;
 	int num_pages;
@@ -6111,19 +6111,22 @@ int try_release_extent_buffer(struct page *page)
  * btrfs_readahead_tree_block - attempt to readahead a child block.
  * @fs_info - the fs_info for the fs.
  * @bytenr - the bytenr to read.
+ * @owner_root - the objectid of the root that owns this eb.
  * @gen - the generation for the uptodate check, can be 0.
+ * @level - the level for the eb.
  *
  * Attempt to readahead a tree block at @bytenr.  If @gen is 0 then we do a
  * normal uptodate check of the eb, without checking the generation.  If we have
  * to read the block we will not block on anything.
  */
 void btrfs_readahead_tree_block(struct btrfs_fs_info *fs_info,
-				u64 bytenr, u64 gen)
+				u64 bytenr, u64 owner_root, u64 gen,
+				int level)
 {
 	struct extent_buffer *eb;
 	int ret;
 
-	eb = btrfs_find_create_tree_block(fs_info, bytenr);
+	eb = btrfs_find_create_tree_block(fs_info, bytenr, owner_root, level);
 	if (IS_ERR(eb))
 		return;
 
@@ -6151,5 +6154,7 @@ void btrfs_readahead_node_child(struct extent_buffer *node, int slot)
 {
 	btrfs_readahead_tree_block(node->fs_info,
 				   btrfs_node_blockptr(node, slot),
-				   btrfs_node_ptr_generation(node, slot));
+				   btrfs_header_owner(node),
+				   btrfs_node_ptr_generation(node, slot),
+				   btrfs_header_level(node) - 1);
 }
diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
index 4f95b087a901..9e97d28f2d8f 100644
--- a/fs/btrfs/extent_io.h
+++ b/fs/btrfs/extent_io.h
@@ -182,7 +182,7 @@ int extent_fiemap(struct btrfs_inode *inode, struct fiemap_extent_info *fieinfo,
 void set_page_extent_mapped(struct page *page);
 
 struct extent_buffer *alloc_extent_buffer(struct btrfs_fs_info *fs_info,
-					  u64 start);
+					  u64 start, u64 owner_root, int level);
 struct extent_buffer *__alloc_dummy_extent_buffer(struct btrfs_fs_info *fs_info,
 						  u64 start, unsigned long len);
 struct extent_buffer *alloc_dummy_extent_buffer(struct btrfs_fs_info *fs_info,
@@ -199,7 +199,8 @@ int read_extent_buffer_pages(struct extent_buffer *eb, int wait,
 			     int mirror_num);
 void wait_on_extent_buffer_writeback(struct extent_buffer *eb);
 void btrfs_readahead_tree_block(struct btrfs_fs_info *fs_info,
-				u64 bytenr, u64 gen);
+				u64 bytenr, u64 owner_root, u64 gen,
+				int level);
 void btrfs_readahead_node_child(struct extent_buffer *node, int slot);
 
 static inline int num_extent_pages(const struct extent_buffer *eb)
diff --git a/fs/btrfs/reada.c b/fs/btrfs/reada.c
index 83f4e6c53e46..8f26b3b22308 100644
--- a/fs/btrfs/reada.c
+++ b/fs/btrfs/reada.c
@@ -656,12 +656,13 @@ static int reada_pick_zone(struct btrfs_device *dev)
 }
 
 static int reada_tree_block_flagged(struct btrfs_fs_info *fs_info, u64 bytenr,
-				    int mirror_num, struct extent_buffer **eb)
+				    u64 owner_root, int level, int mirror_num,
+				    struct extent_buffer **eb)
 {
 	struct extent_buffer *buf = NULL;
 	int ret;
 
-	buf = btrfs_find_create_tree_block(fs_info, bytenr);
+	buf = btrfs_find_create_tree_block(fs_info, bytenr, owner_root, level);
 	if (IS_ERR(buf))
 		return 0;
 
@@ -749,7 +750,8 @@ static int reada_start_machine_dev(struct btrfs_device *dev)
 	logical = re->logical;
 
 	atomic_inc(&dev->reada_in_flight);
-	ret = reada_tree_block_flagged(fs_info, logical, mirror_num, &eb);
+	ret = reada_tree_block_flagged(fs_info, logical, re->owner_root,
+				       re->level, mirror_num, &eb);
 	if (ret)
 		__readahead_hook(fs_info, re, NULL, ret);
 	else if (eb)
diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 48a95a115149..7954f2389d70 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -2518,7 +2518,8 @@ int relocate_tree_blocks(struct btrfs_trans_handle *trans,
 	rbtree_postorder_for_each_entry_safe(block, next, blocks, rb_node) {
 		if (!block->key_ready)
 			btrfs_readahead_tree_block(fs_info,
-						   block->bytenr, 0);
+						   block->bytenr, 0, 0,
+						   block->level);
 	}
 
 	/* Get first keys */
diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 135cb40295c1..0db96c263c94 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -2699,7 +2699,9 @@ static noinline int walk_down_log_tree(struct btrfs_trans_handle *trans,
 		btrfs_node_key_to_cpu(cur, &first_key, path->slots[*level]);
 		blocksize = fs_info->nodesize;
 
-		next = btrfs_find_create_tree_block(fs_info, bytenr);
+		next = btrfs_find_create_tree_block(fs_info, bytenr,
+						    btrfs_header_owner(cur),
+						    *level - 1);
 		if (IS_ERR(next))
 			return PTR_ERR(next);
 
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 75350c78ca02..9ef1a51379e9 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -6909,7 +6909,8 @@ int btrfs_read_sys_array(struct btrfs_fs_info *fs_info)
 	 * fixed to BTRFS_SUPER_INFO_SIZE. If nodesize > sb size, this will
 	 * overallocate but we can keep it as-is, only the first page is used.
 	 */
-	sb = btrfs_find_create_tree_block(fs_info, BTRFS_SUPER_INFO_OFFSET);
+	sb = btrfs_find_create_tree_block(fs_info, BTRFS_SUPER_INFO_OFFSET,
+					  root->root_key.objectid, 0);
 	if (IS_ERR(sb))
 		return PTR_ERR(sb);
 	set_extent_buffer_uptodate(sb);
-- 
2.26.2

