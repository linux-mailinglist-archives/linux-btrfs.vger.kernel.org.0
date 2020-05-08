Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 796421CA7CA
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 May 2020 12:02:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726627AbgEHKCC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 8 May 2020 06:02:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:34306 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725825AbgEHKCB (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 8 May 2020 06:02:01 -0400
Received: from debian6.Home (bl8-197-74.dsl.telepac.pt [85.241.197.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E660B215A4
        for <linux-btrfs@vger.kernel.org>; Fri,  8 May 2020 10:02:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588932121;
        bh=xeW4+QENnXahKSq1l9Uy3C4pxzX78KmxIf9QQhuLATU=;
        h=From:To:Subject:Date:From;
        b=u3V002QfvMrmrugoiVG1a3lfMQxxa/E8QO7TFXFH0Wrb8dUY5f9andqog4oiD81m1
         UiSN29g3Bz1lN9vNb2J9iH+/8XmAYgPqVFevXdSnRjDFdUMxfjqCpHqtxvBLTVSZ/O
         BtdaTrdkANC3ARXssPgwKNChMmQHY1sR6BFxxiIs=
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 3/4] Btrfs: move the block group freeze/unfreeze helpers into block-group.c
Date:   Fri,  8 May 2020 11:01:59 +0100
Message-Id: <20200508100159.8593-1-fdmanana@kernel.org>
X-Mailer: git-send-email 2.11.0
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

The helpers btrfs_freeze_block_group() and btrfs_unfreeze_block_group()
used to be named btrfs_get_block_group_trimming() and
btrfs_put_block_group_trimming() respectively.

At the time they were added to free-space-cache.c, by commit e33e17ee1098
("btrfs: add missing discards when unpinning extents with -o discard")
because all the trimming related functions were in free-space-cache.c.

Now that the helpers were renamed and are used in scrub context as well,
move them to block-group.c, a much more logical location for them.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/block-group.c      | 41 +++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/block-group.h      |  3 +++
 fs/btrfs/ctree.h            |  2 --
 fs/btrfs/free-space-cache.c | 41 -----------------------------------------
 4 files changed, 44 insertions(+), 43 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 138d9c6a84a2..aa83d77e81cb 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -3377,3 +3377,44 @@ int btrfs_free_block_groups(struct btrfs_fs_info *info)
 	}
 	return 0;
 }
+
+void btrfs_freeze_block_group(struct btrfs_block_group *cache)
+{
+	atomic_inc(&cache->frozen);
+}
+
+void btrfs_unfreeze_block_group(struct btrfs_block_group *block_group)
+{
+	struct btrfs_fs_info *fs_info = block_group->fs_info;
+	struct extent_map_tree *em_tree;
+	struct extent_map *em;
+	bool cleanup;
+
+	spin_lock(&block_group->lock);
+	cleanup = (atomic_dec_and_test(&block_group->frozen) &&
+		   block_group->removed);
+	spin_unlock(&block_group->lock);
+
+	if (cleanup) {
+		mutex_lock(&fs_info->chunk_mutex);
+		em_tree = &fs_info->mapping_tree;
+		write_lock(&em_tree->lock);
+		em = lookup_extent_mapping(em_tree, block_group->start,
+					   1);
+		BUG_ON(!em); /* logic error, can't happen */
+		remove_extent_mapping(em_tree, em);
+		write_unlock(&em_tree->lock);
+		mutex_unlock(&fs_info->chunk_mutex);
+
+		/* once for us and once for the tree */
+		free_extent_map(em);
+		free_extent_map(em);
+
+		/*
+		 * We may have left one free space entry and other possible
+		 * tasks trimming this block group have left 1 entry each one.
+		 * Free them if any.
+		 */
+		__btrfs_remove_free_space_cache(block_group->free_space_ctl);
+	}
+}
diff --git a/fs/btrfs/block-group.h b/fs/btrfs/block-group.h
index 04967ea7ba2c..b6ee70a039c7 100644
--- a/fs/btrfs/block-group.h
+++ b/fs/btrfs/block-group.h
@@ -292,6 +292,9 @@ static inline int btrfs_block_group_done(struct btrfs_block_group *cache)
 		cache->cached == BTRFS_CACHE_ERROR;
 }
 
+void btrfs_freeze_block_group(struct btrfs_block_group *cache);
+void btrfs_unfreeze_block_group(struct btrfs_block_group *cache);
+
 #ifdef CONFIG_BTRFS_FS_RUN_SANITY_TESTS
 int btrfs_rmap_block(struct btrfs_fs_info *fs_info, u64 chunk_start,
 		     u64 physical, u64 **logical, int *naddrs, int *stripe_len);
diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index bc10747d1a74..e2ae26f6b9d0 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -2498,8 +2498,6 @@ int btrfs_inc_extent_ref(struct btrfs_trans_handle *trans,
 			 struct btrfs_ref *generic_ref);
 
 int btrfs_extent_readonly(struct btrfs_fs_info *fs_info, u64 bytenr);
-void btrfs_freeze_block_group(struct btrfs_block_group *cache);
-void btrfs_unfreeze_block_group(struct btrfs_block_group *cache);
 void btrfs_clear_space_info_full(struct btrfs_fs_info *info);
 
 enum btrfs_reserve_flush_enum {
diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index e9cfe9da6bbe..3c353a337b91 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -3762,47 +3762,6 @@ static int trim_bitmaps(struct btrfs_block_group *block_group,
 	return ret;
 }
 
-void btrfs_freeze_block_group(struct btrfs_block_group *cache)
-{
-	atomic_inc(&cache->frozen);
-}
-
-void btrfs_unfreeze_block_group(struct btrfs_block_group *block_group)
-{
-	struct btrfs_fs_info *fs_info = block_group->fs_info;
-	struct extent_map_tree *em_tree;
-	struct extent_map *em;
-	bool cleanup;
-
-	spin_lock(&block_group->lock);
-	cleanup = (atomic_dec_and_test(&block_group->frozen) &&
-		   block_group->removed);
-	spin_unlock(&block_group->lock);
-
-	if (cleanup) {
-		mutex_lock(&fs_info->chunk_mutex);
-		em_tree = &fs_info->mapping_tree;
-		write_lock(&em_tree->lock);
-		em = lookup_extent_mapping(em_tree, block_group->start,
-					   1);
-		BUG_ON(!em); /* logic error, can't happen */
-		remove_extent_mapping(em_tree, em);
-		write_unlock(&em_tree->lock);
-		mutex_unlock(&fs_info->chunk_mutex);
-
-		/* once for us and once for the tree */
-		free_extent_map(em);
-		free_extent_map(em);
-
-		/*
-		 * We may have left one free space entry and other possible
-		 * tasks trimming this block group have left 1 entry each one.
-		 * Free them if any.
-		 */
-		__btrfs_remove_free_space_cache(block_group->free_space_ctl);
-	}
-}
-
 int btrfs_trim_block_group(struct btrfs_block_group *block_group,
 			   u64 *trimmed, u64 start, u64 end, u64 minlen)
 {
-- 
2.11.0

