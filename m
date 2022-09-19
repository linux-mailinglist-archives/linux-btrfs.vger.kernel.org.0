Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC50E5BCE03
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Sep 2022 16:07:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230226AbiISOGz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 19 Sep 2022 10:06:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230107AbiISOGy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 19 Sep 2022 10:06:54 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FA1031DF4
        for <linux-btrfs@vger.kernel.org>; Mon, 19 Sep 2022 07:06:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C3A1AB81BFA
        for <linux-btrfs@vger.kernel.org>; Mon, 19 Sep 2022 14:06:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3E5DC433D7
        for <linux-btrfs@vger.kernel.org>; Mon, 19 Sep 2022 14:06:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663596409;
        bh=AtjqDbzIinQWyL7/DyQm+AGjSgXGytU/2GltRgz+SAw=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=RzCT7Iq7x6S7NlaEOCoXUkPNSJvOqUN3P1+iyXuC/zWt9PrXOmbYsB2up+h5PhIs0
         cfr+OP4l/SM0mIzg26fajwFTGoBhLz091XwDCAMLLPDa0ou3eWjv5/kkZBSEFpWwtU
         Dm2Ew04VcysEFVn5u3zRB2Ebauohp4RsYc+Xv2j09Q+w7j0/1q/q8QshEg6rM8M5XA
         2dICavGCqrDxOO5z3o+LypPqirpLbfV/m5pz43PDBva/L4zijlQC1SGGpV0RjRLTB9
         0GF4hLMdDTBbSplRjtI2dgLHXUyqc9m73whsdH8VYizDK9iGCtLV1ufCxC00MVhZBx
         9kYBsB/r0mJVw==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 06/13] btrfs: add helper to replace extent map range with a new extent map
Date:   Mon, 19 Sep 2022 15:06:33 +0100
Message-Id: <1163349ec8f6835187c16c9af9e2d4d0abb053c2.1663594828.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1663594828.git.fdmanana@suse.com>
References: <cover.1663594828.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

We have several places that need to drop all the extent maps in a given
file range and then add a new extent map for that range. Currently they
call btrfs_drop_extent_map_range() to delete all extent maps in the range
and then keep trying to add the new extent map in a loop that keeps
retrying while the insertion of the new extent map fails with -EEXIST.

So instead of repeating this logic, add a helper to extent_map.c that
does these steps and name it btrfs_replace_extent_map_range(). Also add
a comment about why the retry loop is necessary.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/extent_map.c | 41 +++++++++++++++++++++++++++++++++++
 fs/btrfs/extent_map.h |  3 +++
 fs/btrfs/file.c       |  8 +------
 fs/btrfs/inode.c      | 50 +++++++------------------------------------
 fs/btrfs/relocation.c | 14 +++---------
 5 files changed, 56 insertions(+), 60 deletions(-)

diff --git a/fs/btrfs/extent_map.c b/fs/btrfs/extent_map.c
index 7376c0aa2bca..bef9cc8bfb2a 100644
--- a/fs/btrfs/extent_map.c
+++ b/fs/btrfs/extent_map.c
@@ -879,3 +879,44 @@ void btrfs_drop_extent_map_range(struct btrfs_inode *inode, u64 start, u64 end,
 	free_extent_map(split);
 	free_extent_map(split2);
 }
+
+/*
+ * Replace a range in the inode's extent map tree with a new extent map.
+ *
+ * @inode:      The target inode.
+ * @new_em:     The new extent map to add to the inode's extent map tree.
+ * @modified:   Indicate if the new extent map should be added to the list of
+ *              modified extents (for fast fsync tracking).
+ *
+ * Drops all the extent maps in the inode's extent map tree that intersect the
+ * range of the new extent map and adds the new extent map to the tree.
+ * The caller should have locked an appropriate file range in the inode's io
+ * tree before calling this function.
+ */
+int btrfs_replace_extent_map_range(struct btrfs_inode *inode,
+				   struct extent_map *new_em,
+				   bool modified)
+{
+	const u64 end = new_em->start + new_em->len - 1;
+	struct extent_map_tree *tree = &inode->extent_tree;
+	int ret;
+
+	ASSERT(!extent_map_in_tree(new_em));
+
+	/*
+	 * The caller has locked an appropriate file range in the inode's io
+	 * tree, but getting -EEXIST when adding the new extent map can still
+	 * happen in case there are extents that partially cover the range, and
+	 * this is due to two tasks operating on different parts of the extent.
+	 * See commit 18e83ac75bfe67 ("Btrfs: fix unexpected EEXIST from
+	 * btrfs_get_extent") for an example and details.
+	 */
+	do {
+		btrfs_drop_extent_map_range(inode, new_em->start, end, false);
+		write_lock(&tree->lock);
+		ret = add_extent_mapping(tree, new_em, modified);
+		write_unlock(&tree->lock);
+	} while (ret == -EEXIST);
+
+	return ret;
+}
diff --git a/fs/btrfs/extent_map.h b/fs/btrfs/extent_map.h
index 17f4a9bbee7f..ad311864272a 100644
--- a/fs/btrfs/extent_map.h
+++ b/fs/btrfs/extent_map.h
@@ -109,5 +109,8 @@ int btrfs_add_extent_mapping(struct btrfs_fs_info *fs_info,
 void btrfs_drop_extent_map_range(struct btrfs_inode *inode,
 				 u64 start, u64 end,
 				 bool skip_pinned);
+int btrfs_replace_extent_map_range(struct btrfs_inode *inode,
+				   struct extent_map *new_em,
+				   bool modified);
 
 #endif
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 793c95dc8df5..b5847111c783 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -2298,7 +2298,6 @@ static int fill_holes(struct btrfs_trans_handle *trans,
 	struct extent_buffer *leaf;
 	struct btrfs_file_extent_item *fi;
 	struct extent_map *hole_em;
-	struct extent_map_tree *em_tree = &inode->extent_tree;
 	struct btrfs_key key;
 	int ret;
 
@@ -2379,12 +2378,7 @@ static int fill_holes(struct btrfs_trans_handle *trans,
 		hole_em->compress_type = BTRFS_COMPRESS_NONE;
 		hole_em->generation = trans->transid;
 
-		do {
-			btrfs_drop_extent_map_range(inode, offset, end - 1, false);
-			write_lock(&em_tree->lock);
-			ret = add_extent_mapping(em_tree, hole_em, 1);
-			write_unlock(&em_tree->lock);
-		} while (ret == -EEXIST);
+		ret = btrfs_replace_extent_map_range(inode, hole_em, true);
 		free_extent_map(hole_em);
 		if (ret)
 			btrfs_set_inode_full_sync(inode);
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index f0cfa9ff5ebd..024183c7480f 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -5041,7 +5041,6 @@ int btrfs_cont_expand(struct btrfs_inode *inode, loff_t oldsize, loff_t size)
 	struct extent_io_tree *io_tree = &inode->io_tree;
 	struct extent_map *em = NULL;
 	struct extent_state *cached_state = NULL;
-	struct extent_map_tree *em_tree = &inode->extent_tree;
 	u64 hole_start = ALIGN(oldsize, fs_info->sectorsize);
 	u64 block_end = ALIGN(size, fs_info->sectorsize);
 	u64 last_byte;
@@ -5089,11 +5088,11 @@ int btrfs_cont_expand(struct btrfs_inode *inode, loff_t oldsize, loff_t size)
 			if (err)
 				break;
 
-			btrfs_drop_extent_map_range(inode, cur_offset,
-						    cur_offset + hole_size - 1,
-						    false);
 			hole_em = alloc_extent_map();
 			if (!hole_em) {
+				btrfs_drop_extent_map_range(inode, cur_offset,
+						    cur_offset + hole_size - 1,
+						    false);
 				btrfs_set_inode_full_sync(inode);
 				goto next;
 			}
@@ -5108,16 +5107,7 @@ int btrfs_cont_expand(struct btrfs_inode *inode, loff_t oldsize, loff_t size)
 			hole_em->compress_type = BTRFS_COMPRESS_NONE;
 			hole_em->generation = fs_info->generation;
 
-			while (1) {
-				write_lock(&em_tree->lock);
-				err = add_extent_mapping(em_tree, hole_em, 1);
-				write_unlock(&em_tree->lock);
-				if (err != -EEXIST)
-					break;
-				btrfs_drop_extent_map_range(inode, cur_offset,
-						    cur_offset + hole_size - 1,
-						    false);
-			}
+			err = btrfs_replace_extent_map_range(inode, hole_em, true);
 			free_extent_map(hole_em);
 		} else {
 			err = btrfs_inode_set_file_extent_range(inode,
@@ -7337,7 +7327,6 @@ static struct extent_map *create_io_em(struct btrfs_inode *inode, u64 start,
 				       u64 ram_bytes, int compress_type,
 				       int type)
 {
-	struct extent_map_tree *em_tree;
 	struct extent_map *em;
 	int ret;
 
@@ -7346,7 +7335,6 @@ static struct extent_map *create_io_em(struct btrfs_inode *inode, u64 start,
 	       type == BTRFS_ORDERED_NOCOW ||
 	       type == BTRFS_ORDERED_REGULAR);
 
-	em_tree = &inode->extent_tree;
 	em = alloc_extent_map();
 	if (!em)
 		return ERR_PTR(-ENOMEM);
@@ -7367,18 +7355,7 @@ static struct extent_map *create_io_em(struct btrfs_inode *inode, u64 start,
 		em->compress_type = compress_type;
 	}
 
-	do {
-		btrfs_drop_extent_map_range(inode, em->start,
-					    em->start + em->len - 1, false);
-		write_lock(&em_tree->lock);
-		ret = add_extent_mapping(em_tree, em, 1);
-		write_unlock(&em_tree->lock);
-		/*
-		 * The caller has taken lock_extent(), who could race with us
-		 * to add em?
-		 */
-	} while (ret == -EEXIST);
-
+	ret = btrfs_replace_extent_map_range(inode, em, true);
 	if (ret) {
 		free_extent_map(em);
 		return ERR_PTR(ret);
@@ -9877,7 +9854,6 @@ static int __btrfs_prealloc_file_range(struct inode *inode, int mode,
 				       struct btrfs_trans_handle *trans)
 {
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
-	struct extent_map_tree *em_tree = &BTRFS_I(inode)->extent_tree;
 	struct extent_map *em;
 	struct btrfs_root *root = BTRFS_I(inode)->root;
 	struct btrfs_key ins;
@@ -9933,11 +9909,10 @@ static int __btrfs_prealloc_file_range(struct inode *inode, int mode,
 			break;
 		}
 
-		btrfs_drop_extent_map_range(BTRFS_I(inode), cur_offset,
-					    cur_offset + ins.offset - 1, false);
-
 		em = alloc_extent_map();
 		if (!em) {
+			btrfs_drop_extent_map_range(BTRFS_I(inode), cur_offset,
+					    cur_offset + ins.offset - 1, false);
 			btrfs_set_inode_full_sync(BTRFS_I(inode));
 			goto next;
 		}
@@ -9952,16 +9927,7 @@ static int __btrfs_prealloc_file_range(struct inode *inode, int mode,
 		set_bit(EXTENT_FLAG_PREALLOC, &em->flags);
 		em->generation = trans->transid;
 
-		while (1) {
-			write_lock(&em_tree->lock);
-			ret = add_extent_mapping(em_tree, em, 1);
-			write_unlock(&em_tree->lock);
-			if (ret != -EEXIST)
-				break;
-			btrfs_drop_extent_map_range(BTRFS_I(inode), cur_offset,
-						    cur_offset + ins.offset - 1,
-						    false);
-		}
+		ret = btrfs_replace_extent_map_range(BTRFS_I(inode), em, true);
 		free_extent_map(em);
 next:
 		num_bytes -= ins.offset;
diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 1b4a61df5b7c..cd8adb9f6d3f 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -2890,7 +2890,6 @@ static noinline_for_stack int prealloc_file_extent_cluster(
 static noinline_for_stack int setup_relocation_extent_mapping(struct inode *inode,
 				u64 start, u64 end, u64 block_start)
 {
-	struct extent_map_tree *em_tree = &BTRFS_I(inode)->extent_tree;
 	struct extent_map *em;
 	int ret = 0;
 
@@ -2905,17 +2904,10 @@ static noinline_for_stack int setup_relocation_extent_mapping(struct inode *inod
 	set_bit(EXTENT_FLAG_PINNED, &em->flags);
 
 	lock_extent(&BTRFS_I(inode)->io_tree, start, end, NULL);
-	while (1) {
-		write_lock(&em_tree->lock);
-		ret = add_extent_mapping(em_tree, em, 0);
-		write_unlock(&em_tree->lock);
-		if (ret != -EEXIST) {
-			free_extent_map(em);
-			break;
-		}
-		btrfs_drop_extent_map_range(BTRFS_I(inode), start, end, false);
-	}
+	ret = btrfs_replace_extent_map_range(BTRFS_I(inode), em, false);
 	unlock_extent(&BTRFS_I(inode)->io_tree, start, end, NULL);
+	free_extent_map(em);
+
 	return ret;
 }
 
-- 
2.35.1

