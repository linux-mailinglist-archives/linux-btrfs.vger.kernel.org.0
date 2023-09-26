Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7897E7AED21
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Sep 2023 14:45:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234363AbjIZMpk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 26 Sep 2023 08:45:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234691AbjIZMpi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 26 Sep 2023 08:45:38 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA54A101
        for <linux-btrfs@vger.kernel.org>; Tue, 26 Sep 2023 05:45:31 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F4134C433CA
        for <linux-btrfs@vger.kernel.org>; Tue, 26 Sep 2023 12:45:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695732331;
        bh=hg6qDh3iNkiYUEYTi2dvs1eRUDVr4++7lKD2sLrT/to=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=r0g2R7jR911/1ur15PXNd9nl8kaIXSYV6UcjUHKrTxRv6e7qf5MJ3NB9/JMyYr+DU
         +a4zUcWeaBcJubkOUjhHWqYO0DB6XMgGiyK3PyaKX87llrwEbOgopAhQdH0dQ59QdZ
         UsZ55QV661WHmH714Vr4PAfJyF5BtO/DGKfu+6sZd4ThFxwPF3QwetuC1/oRwPCzJ5
         YKYUBkbm7j1/Hh+4QweX6MNdbqQjApbgidtlE2ElGilOXjPLQ8+E8hhMlOdyy3dLBy
         8WTo3UCFs3FycTiM6G9DnHOV0KgNPRV4Hd8Q+1vrWYMP82bcQEYDedEe6VczAIJ35f
         KRTV9gqKmk6BA==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 8/8] btrfs: move btrfs_realloc_node() from ctree.c into defrag.h
Date:   Tue, 26 Sep 2023 13:45:20 +0100
Message-Id: <935d5f7d09c31b38be102d066957ad6bbe0b4b2f.1695731845.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1695731838.git.fdmanana@suse.com>
References: <cover.1695731838.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

btrfs_realloc_node() is only used by the defrag code. Nowadays we have a
defrag.c file, so move it, and its helper close_blocks(), into defrag.c.

During the move also do a few minor cosmetic changes:

1) Change the return value of close_blocks() from int to bool;

2) Use SZ_32K instead of 32768 at close_blocks();

3) Make some variables const in btrfs_realloc_node(), 'blocksize' and
   'end_slot';

4) Get rid of 'parent_nritems' variable, in both places where it was
   used it could be replaced by calling btrfs_header_nritems(parent);

5) Change the type of a couple variables from int to bool;

6) Rename variable 'err' to 'ret', as that's the most common name we
   use to track the return value of a function;

7) Move some variables from the top scope to the scope of the for loop
   where they are used.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/ctree.c  | 112 ----------------------------------------------
 fs/btrfs/ctree.h  |   4 --
 fs/btrfs/defrag.c | 106 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 106 insertions(+), 116 deletions(-)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index f584e79c29e9..6cbebe8c416d 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -730,19 +730,6 @@ int btrfs_cow_block(struct btrfs_trans_handle *trans,
 }
 ALLOW_ERROR_INJECTION(btrfs_cow_block, ERRNO);
 
-/*
- * helper function for defrag to decide if two blocks pointed to by a
- * node are actually close by
- */
-static int close_blocks(u64 blocknr, u64 other, u32 blocksize)
-{
-	if (blocknr < other && other - (blocknr + blocksize) < 32768)
-		return 1;
-	if (blocknr > other && blocknr - (other + blocksize) < 32768)
-		return 1;
-	return 0;
-}
-
 /*
  * same as comp_keys only with two btrfs_key's
  */
@@ -763,105 +750,6 @@ int __pure btrfs_comp_cpu_keys(const struct btrfs_key *k1, const struct btrfs_ke
 	return 0;
 }
 
-/*
- * this is used by the defrag code to go through all the
- * leaves pointed to by a node and reallocate them so that
- * disk order is close to key order
- */
-int btrfs_realloc_node(struct btrfs_trans_handle *trans,
-		       struct btrfs_root *root, struct extent_buffer *parent,
-		       int start_slot, u64 *last_ret,
-		       struct btrfs_key *progress)
-{
-	struct btrfs_fs_info *fs_info = root->fs_info;
-	struct extent_buffer *cur;
-	u64 blocknr;
-	u64 search_start = *last_ret;
-	u64 last_block = 0;
-	u64 other;
-	u32 parent_nritems;
-	int end_slot;
-	int i;
-	int err = 0;
-	u32 blocksize;
-	int progress_passed = 0;
-	struct btrfs_disk_key disk_key;
-
-	/*
-	 * COWing must happen through a running transaction, which always
-	 * matches the current fs generation (it's a transaction with a state
-	 * less than TRANS_STATE_UNBLOCKED). If it doesn't, then turn the fs
-	 * into error state to prevent the commit of any transaction.
-	 */
-	if (unlikely(trans->transaction != fs_info->running_transaction ||
-		     trans->transid != fs_info->generation)) {
-		btrfs_handle_fs_error(fs_info, -EUCLEAN,
-"unexpected transaction when attempting to reallocate parent %llu for root %llu, transaction %llu running transaction %llu fs generation %llu",
-				      parent->start, btrfs_root_id(root),
-				      trans->transid,
-				      fs_info->running_transaction->transid,
-				      fs_info->generation);
-		return -EUCLEAN;
-	}
-
-	parent_nritems = btrfs_header_nritems(parent);
-	blocksize = fs_info->nodesize;
-	end_slot = parent_nritems - 1;
-
-	if (parent_nritems <= 1)
-		return 0;
-
-	for (i = start_slot; i <= end_slot; i++) {
-		int close = 1;
-
-		btrfs_node_key(parent, &disk_key, i);
-		if (!progress_passed && btrfs_comp_keys(&disk_key, progress) < 0)
-			continue;
-
-		progress_passed = 1;
-		blocknr = btrfs_node_blockptr(parent, i);
-		if (last_block == 0)
-			last_block = blocknr;
-
-		if (i > 0) {
-			other = btrfs_node_blockptr(parent, i - 1);
-			close = close_blocks(blocknr, other, blocksize);
-		}
-		if (!close && i < end_slot) {
-			other = btrfs_node_blockptr(parent, i + 1);
-			close = close_blocks(blocknr, other, blocksize);
-		}
-		if (close) {
-			last_block = blocknr;
-			continue;
-		}
-
-		cur = btrfs_read_node_slot(parent, i);
-		if (IS_ERR(cur))
-			return PTR_ERR(cur);
-		if (search_start == 0)
-			search_start = last_block;
-
-		btrfs_tree_lock(cur);
-		err = btrfs_force_cow_block(trans, root, cur, parent, i,
-					    &cur, search_start,
-					    min(16 * blocksize,
-						(end_slot - i) * blocksize),
-					    BTRFS_NESTING_COW);
-		if (err) {
-			btrfs_tree_unlock(cur);
-			free_extent_buffer(cur);
-			break;
-		}
-		search_start = cur->start;
-		last_block = cur->start;
-		*last_ret = search_start;
-		btrfs_tree_unlock(cur);
-		free_extent_buffer(cur);
-	}
-	return err;
-}
-
 /*
  * Search for a key in the given extent_buffer.
  *
diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index e6d982c3ea11..353ba4821f25 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -553,10 +553,6 @@ int btrfs_search_slot_for_read(struct btrfs_root *root,
 			       const struct btrfs_key *key,
 			       struct btrfs_path *p, int find_higher,
 			       int return_any);
-int btrfs_realloc_node(struct btrfs_trans_handle *trans,
-		       struct btrfs_root *root, struct extent_buffer *parent,
-		       int start_slot, u64 *last_ret,
-		       struct btrfs_key *progress);
 void btrfs_release_path(struct btrfs_path *p);
 struct btrfs_path *btrfs_alloc_path(void);
 void btrfs_free_path(struct btrfs_path *p);
diff --git a/fs/btrfs/defrag.c b/fs/btrfs/defrag.c
index 53544787c348..ad084c295378 100644
--- a/fs/btrfs/defrag.c
+++ b/fs/btrfs/defrag.c
@@ -337,6 +337,112 @@ int btrfs_run_defrag_inodes(struct btrfs_fs_info *fs_info)
 	return 0;
 }
 
+/*
+ * Helper function for defrag to decide if two blocks pointed to by a node are
+ * actually close by.
+ */
+static bool close_blocks(u64 blocknr, u64 other, u32 blocksize)
+{
+	if (blocknr < other && other - (blocknr + blocksize) < SZ_32K)
+		return true;
+	if (blocknr > other && blocknr - (other + blocksize) < SZ_32K)
+		return true;
+	return false;
+}
+
+/*
+ * This is used by the defrag code to go through all the leaves pointed to by a
+ * node and reallocate them so that disk order is close to key order.
+ */
+static int btrfs_realloc_node(struct btrfs_trans_handle *trans,
+			      struct btrfs_root *root,
+			      struct extent_buffer *parent,
+			      int start_slot, u64 *last_ret,
+			      struct btrfs_key *progress)
+{
+	struct btrfs_fs_info *fs_info = root->fs_info;
+	const u32 blocksize = fs_info->nodesize;
+	const int end_slot = btrfs_header_nritems(parent) - 1;
+	u64 search_start = *last_ret;
+	u64 last_block = 0;
+	int ret = 0;
+	bool progress_passed = false;
+
+	/*
+	 * COWing must happen through a running transaction, which always
+	 * matches the current fs generation (it's a transaction with a state
+	 * less than TRANS_STATE_UNBLOCKED). If it doesn't, then turn the fs
+	 * into error state to prevent the commit of any transaction.
+	 */
+	if (unlikely(trans->transaction != fs_info->running_transaction ||
+		     trans->transid != fs_info->generation)) {
+		btrfs_handle_fs_error(fs_info, -EUCLEAN,
+"unexpected transaction when attempting to reallocate parent %llu for root %llu, transaction %llu running transaction %llu fs generation %llu",
+				      parent->start, btrfs_root_id(root),
+				      trans->transid,
+				      fs_info->running_transaction->transid,
+				      fs_info->generation);
+		return -EUCLEAN;
+	}
+
+	if (btrfs_header_nritems(parent) <= 1)
+		return 0;
+
+	for (int i = start_slot; i <= end_slot; i++) {
+		struct extent_buffer *cur;
+		struct btrfs_disk_key disk_key;
+		u64 blocknr;
+		u64 other;
+		bool close = true;
+
+		btrfs_node_key(parent, &disk_key, i);
+		if (!progress_passed && btrfs_comp_keys(&disk_key, progress) < 0)
+			continue;
+
+		progress_passed = true;
+		blocknr = btrfs_node_blockptr(parent, i);
+		if (last_block == 0)
+			last_block = blocknr;
+
+		if (i > 0) {
+			other = btrfs_node_blockptr(parent, i - 1);
+			close = close_blocks(blocknr, other, blocksize);
+		}
+		if (!close && i < end_slot) {
+			other = btrfs_node_blockptr(parent, i + 1);
+			close = close_blocks(blocknr, other, blocksize);
+		}
+		if (close) {
+			last_block = blocknr;
+			continue;
+		}
+
+		cur = btrfs_read_node_slot(parent, i);
+		if (IS_ERR(cur))
+			return PTR_ERR(cur);
+		if (search_start == 0)
+			search_start = last_block;
+
+		btrfs_tree_lock(cur);
+		ret = btrfs_force_cow_block(trans, root, cur, parent, i,
+					    &cur, search_start,
+					    min(16 * blocksize,
+						(end_slot - i) * blocksize),
+					    BTRFS_NESTING_COW);
+		if (ret) {
+			btrfs_tree_unlock(cur);
+			free_extent_buffer(cur);
+			break;
+		}
+		search_start = cur->start;
+		last_block = cur->start;
+		*last_ret = search_start;
+		btrfs_tree_unlock(cur);
+		free_extent_buffer(cur);
+	}
+	return ret;
+}
+
 /*
  * Defrag all the leaves in a given btree.
  * Read all the leaves and try to get key order to
-- 
2.40.1

