Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E675A7E30A9
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Nov 2023 00:07:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233411AbjKFXHV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 6 Nov 2023 18:07:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233427AbjKFXHL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 6 Nov 2023 18:07:11 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DD9810F0;
        Mon,  6 Nov 2023 15:07:05 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 746FAC433C7;
        Mon,  6 Nov 2023 23:07:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699312024;
        bh=PrcGE4hW1LYL/nBAdlm0ZDZZU8S2r+iUT56yCKjvy+c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iSFXLnkDINyWwdrO34FDAi1loPn56xXcc22IBieq/LO9Cp/uGx0OrxMuDuWG/bTz2
         n//Ox9xWAF1N7uNk8satrSZE8uGLo4ja6vSxvfu8siQxztbJsvC8mJRFLFv4yveEgg
         2AtVn8sThtbu97+l5hdKmJ7j2Vw34w2zsMhCbzankEiuqbnY96C3oi5hqp49i41TcI
         qGNMt8WJVib6JyBGcFwLGnG5RXGo3jwll6RIyg9H7ODKRItZme30ZTFuna5KbTB9f/
         NjhMHcxFjhT01tVJo/mLm2HgAdB96mg4EC4b5WRJAD6mxCBAy274tAtkLDAdQg3l4n
         JDo+EEflZjddQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Filipe Manana <fdmanana@suse.com>, David Sterba <dsterba@suse.com>,
        Sasha Levin <sashal@kernel.org>, clm@fb.com,
        josef@toxicpanda.com, anand.jain@oracle.com, wqu@suse.com,
        linux-btrfs@vger.kernel.org
Subject: [PATCH AUTOSEL 6.5 3/5] btrfs: abort transaction on generation mismatch when marking eb as dirty
Date:   Mon,  6 Nov 2023 18:06:40 -0500
Message-ID: <20231106230651.3734359-3-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231106230651.3734359-1-sashal@kernel.org>
References: <20231106230651.3734359-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.5.10
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

[ Upstream commit 50564b651d01c19ce732819c5b3c3fd60707188e ]

When marking an extent buffer as dirty, at btrfs_mark_buffer_dirty(),
we check if its generation matches the running transaction and if not we
just print a warning. Such mismatch is an indicator that something really
went wrong and only printing a warning message (and stack trace) is not
enough to prevent a corruption. Allowing a transaction to commit with such
an extent buffer will trigger an error if we ever try to read it from disk
due to a generation mismatch with its parent generation.

So abort the current transaction with -EUCLEAN if we notice a generation
mismatch. For this we need to pass a transaction handle to
btrfs_mark_buffer_dirty() which is always available except in test code,
in which case we can pass NULL since it operates on dummy extent buffers
and all test roots have a single node/leaf (root node at level 0).

Signed-off-by: Filipe Manana <fdmanana@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/block-group.c               |   4 +-
 fs/btrfs/ctree.c                     | 109 +++++++++++++++------------
 fs/btrfs/ctree.h                     |  11 ++-
 fs/btrfs/delayed-inode.c             |   2 +-
 fs/btrfs/dev-replace.c               |   2 +-
 fs/btrfs/dir-item.c                  |   8 +-
 fs/btrfs/disk-io.c                   |  13 +++-
 fs/btrfs/disk-io.h                   |   3 +-
 fs/btrfs/extent-tree.c               |  36 +++++----
 fs/btrfs/file-item.c                 |  17 +++--
 fs/btrfs/file.c                      |  34 ++++-----
 fs/btrfs/free-space-cache.c          |   6 +-
 fs/btrfs/free-space-tree.c           |  17 +++--
 fs/btrfs/inode-item.c                |  16 ++--
 fs/btrfs/inode.c                     |  10 +--
 fs/btrfs/ioctl.c                     |   4 +-
 fs/btrfs/qgroup.c                    |  14 ++--
 fs/btrfs/relocation.c                |  10 +--
 fs/btrfs/root-tree.c                 |   4 +-
 fs/btrfs/tests/extent-buffer-tests.c |   6 +-
 fs/btrfs/tests/inode-tests.c         |  12 ++-
 fs/btrfs/tree-log.c                  |  12 +--
 fs/btrfs/uuid-tree.c                 |   6 +-
 fs/btrfs/volumes.c                   |  10 +--
 fs/btrfs/xattr.c                     |   8 +-
 25 files changed, 205 insertions(+), 169 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 5e7a19fca79c4..bf65f801d8439 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -2587,7 +2587,7 @@ static int insert_dev_extent(struct btrfs_trans_handle *trans,
 	btrfs_set_dev_extent_chunk_offset(leaf, extent, chunk_offset);
 
 	btrfs_set_dev_extent_length(leaf, extent, num_bytes);
-	btrfs_mark_buffer_dirty(leaf);
+	btrfs_mark_buffer_dirty(trans, leaf);
 out:
 	btrfs_free_path(path);
 	return ret;
@@ -3011,7 +3011,7 @@ static int update_block_group_item(struct btrfs_trans_handle *trans,
 						   cache->global_root_id);
 	btrfs_set_stack_block_group_flags(&bgi, cache->flags);
 	write_extent_buffer(leaf, &bgi, bi, sizeof(bgi));
-	btrfs_mark_buffer_dirty(leaf);
+	btrfs_mark_buffer_dirty(trans, leaf);
 fail:
 	btrfs_release_path(path);
 	/*
diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index da519c1b6ad08..721577a30d0dd 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -359,7 +359,7 @@ int btrfs_copy_root(struct btrfs_trans_handle *trans,
 		return ret;
 	}
 
-	btrfs_mark_buffer_dirty(cow);
+	btrfs_mark_buffer_dirty(trans, cow);
 	*cow_ret = cow;
 	return 0;
 }
@@ -616,7 +616,7 @@ static noinline int __btrfs_cow_block(struct btrfs_trans_handle *trans,
 					cow->start);
 		btrfs_set_node_ptr_generation(parent, parent_slot,
 					      trans->transid);
-		btrfs_mark_buffer_dirty(parent);
+		btrfs_mark_buffer_dirty(trans, parent);
 		if (last_ref) {
 			ret = btrfs_tree_mod_log_free_eb(buf);
 			if (ret) {
@@ -632,7 +632,7 @@ static noinline int __btrfs_cow_block(struct btrfs_trans_handle *trans,
 	if (unlock_orig)
 		btrfs_tree_unlock(buf);
 	free_extent_buffer_stale(buf);
-	btrfs_mark_buffer_dirty(cow);
+	btrfs_mark_buffer_dirty(trans, cow);
 	*cow_ret = cow;
 	return 0;
 }
@@ -1186,7 +1186,7 @@ static noinline int balance_level(struct btrfs_trans_handle *trans,
 				goto out;
 			}
 			btrfs_set_node_key(parent, &right_key, pslot + 1);
-			btrfs_mark_buffer_dirty(parent);
+			btrfs_mark_buffer_dirty(trans, parent);
 		}
 	}
 	if (btrfs_header_nritems(mid) == 1) {
@@ -1244,7 +1244,7 @@ static noinline int balance_level(struct btrfs_trans_handle *trans,
 			goto out;
 		}
 		btrfs_set_node_key(parent, &mid_key, pslot);
-		btrfs_mark_buffer_dirty(parent);
+		btrfs_mark_buffer_dirty(trans, parent);
 	}
 
 	/* update the path */
@@ -1351,7 +1351,7 @@ static noinline int push_nodes_for_insert(struct btrfs_trans_handle *trans,
 				return ret;
 			}
 			btrfs_set_node_key(parent, &disk_key, pslot);
-			btrfs_mark_buffer_dirty(parent);
+			btrfs_mark_buffer_dirty(trans, parent);
 			if (btrfs_header_nritems(left) > orig_slot) {
 				path->nodes[level] = left;
 				path->slots[level + 1] -= 1;
@@ -1411,7 +1411,7 @@ static noinline int push_nodes_for_insert(struct btrfs_trans_handle *trans,
 				return ret;
 			}
 			btrfs_set_node_key(parent, &disk_key, pslot + 1);
-			btrfs_mark_buffer_dirty(parent);
+			btrfs_mark_buffer_dirty(trans, parent);
 
 			if (btrfs_header_nritems(mid) <= orig_slot) {
 				path->nodes[level] = right;
@@ -2667,7 +2667,8 @@ int btrfs_get_next_valid_item(struct btrfs_root *root, struct btrfs_key *key,
  * higher levels
  *
  */
-static void fixup_low_keys(struct btrfs_path *path,
+static void fixup_low_keys(struct btrfs_trans_handle *trans,
+			   struct btrfs_path *path,
 			   struct btrfs_disk_key *key, int level)
 {
 	int i;
@@ -2684,7 +2685,7 @@ static void fixup_low_keys(struct btrfs_path *path,
 						    BTRFS_MOD_LOG_KEY_REPLACE);
 		BUG_ON(ret < 0);
 		btrfs_set_node_key(t, key, tslot);
-		btrfs_mark_buffer_dirty(path->nodes[i]);
+		btrfs_mark_buffer_dirty(trans, path->nodes[i]);
 		if (tslot != 0)
 			break;
 	}
@@ -2696,10 +2697,11 @@ static void fixup_low_keys(struct btrfs_path *path,
  * This function isn't completely safe. It's the caller's responsibility
  * that the new key won't break the order
  */
-void btrfs_set_item_key_safe(struct btrfs_fs_info *fs_info,
+void btrfs_set_item_key_safe(struct btrfs_trans_handle *trans,
 			     struct btrfs_path *path,
 			     const struct btrfs_key *new_key)
 {
+	struct btrfs_fs_info *fs_info = trans->fs_info;
 	struct btrfs_disk_key disk_key;
 	struct extent_buffer *eb;
 	int slot;
@@ -2737,9 +2739,9 @@ void btrfs_set_item_key_safe(struct btrfs_fs_info *fs_info,
 
 	btrfs_cpu_key_to_disk(&disk_key, new_key);
 	btrfs_set_item_key(eb, &disk_key, slot);
-	btrfs_mark_buffer_dirty(eb);
+	btrfs_mark_buffer_dirty(trans, eb);
 	if (slot == 0)
-		fixup_low_keys(path, &disk_key, 1);
+		fixup_low_keys(trans, path, &disk_key, 1);
 }
 
 /*
@@ -2870,8 +2872,8 @@ static int push_node_left(struct btrfs_trans_handle *trans,
 	}
 	btrfs_set_header_nritems(src, src_nritems - push_items);
 	btrfs_set_header_nritems(dst, dst_nritems + push_items);
-	btrfs_mark_buffer_dirty(src);
-	btrfs_mark_buffer_dirty(dst);
+	btrfs_mark_buffer_dirty(trans, src);
+	btrfs_mark_buffer_dirty(trans, dst);
 
 	return ret;
 }
@@ -2946,8 +2948,8 @@ static int balance_node_right(struct btrfs_trans_handle *trans,
 	btrfs_set_header_nritems(src, src_nritems - push_items);
 	btrfs_set_header_nritems(dst, dst_nritems + push_items);
 
-	btrfs_mark_buffer_dirty(src);
-	btrfs_mark_buffer_dirty(dst);
+	btrfs_mark_buffer_dirty(trans, src);
+	btrfs_mark_buffer_dirty(trans, dst);
 
 	return ret;
 }
@@ -2996,7 +2998,7 @@ static noinline int insert_new_root(struct btrfs_trans_handle *trans,
 
 	btrfs_set_node_ptr_generation(c, 0, lower_gen);
 
-	btrfs_mark_buffer_dirty(c);
+	btrfs_mark_buffer_dirty(trans, c);
 
 	old = root->node;
 	ret = btrfs_tree_mod_log_insert_root(root->node, c, false);
@@ -3068,7 +3070,7 @@ static int insert_ptr(struct btrfs_trans_handle *trans,
 	WARN_ON(trans->transid == 0);
 	btrfs_set_node_ptr_generation(lower, slot, trans->transid);
 	btrfs_set_header_nritems(lower, nritems + 1);
-	btrfs_mark_buffer_dirty(lower);
+	btrfs_mark_buffer_dirty(trans, lower);
 
 	return 0;
 }
@@ -3147,8 +3149,8 @@ static noinline int split_node(struct btrfs_trans_handle *trans,
 	btrfs_set_header_nritems(split, c_nritems - mid);
 	btrfs_set_header_nritems(c, mid);
 
-	btrfs_mark_buffer_dirty(c);
-	btrfs_mark_buffer_dirty(split);
+	btrfs_mark_buffer_dirty(trans, c);
+	btrfs_mark_buffer_dirty(trans, split);
 
 	ret = insert_ptr(trans, path, &disk_key, split->start,
 			 path->slots[level + 1] + 1, level + 1);
@@ -3314,15 +3316,15 @@ static noinline int __push_leaf_right(struct btrfs_trans_handle *trans,
 	btrfs_set_header_nritems(left, left_nritems);
 
 	if (left_nritems)
-		btrfs_mark_buffer_dirty(left);
+		btrfs_mark_buffer_dirty(trans, left);
 	else
 		btrfs_clear_buffer_dirty(trans, left);
 
-	btrfs_mark_buffer_dirty(right);
+	btrfs_mark_buffer_dirty(trans, right);
 
 	btrfs_item_key(right, &disk_key, 0);
 	btrfs_set_node_key(upper, &disk_key, slot + 1);
-	btrfs_mark_buffer_dirty(upper);
+	btrfs_mark_buffer_dirty(trans, upper);
 
 	/* then fixup the leaf pointer in the path */
 	if (path->slots[0] >= left_nritems) {
@@ -3534,14 +3536,14 @@ static noinline int __push_leaf_left(struct btrfs_trans_handle *trans,
 		btrfs_set_token_item_offset(&token, i, push_space);
 	}
 
-	btrfs_mark_buffer_dirty(left);
+	btrfs_mark_buffer_dirty(trans, left);
 	if (right_nritems)
-		btrfs_mark_buffer_dirty(right);
+		btrfs_mark_buffer_dirty(trans, right);
 	else
 		btrfs_clear_buffer_dirty(trans, right);
 
 	btrfs_item_key(right, &disk_key, 0);
-	fixup_low_keys(path, &disk_key, 1);
+	fixup_low_keys(trans, path, &disk_key, 1);
 
 	/* then fixup the leaf pointer in the path */
 	if (path->slots[0] < push_items) {
@@ -3672,8 +3674,8 @@ static noinline int copy_for_split(struct btrfs_trans_handle *trans,
 	if (ret < 0)
 		return ret;
 
-	btrfs_mark_buffer_dirty(right);
-	btrfs_mark_buffer_dirty(l);
+	btrfs_mark_buffer_dirty(trans, right);
+	btrfs_mark_buffer_dirty(trans, l);
 	BUG_ON(path->slots[0] != slot);
 
 	if (mid <= slot) {
@@ -3914,7 +3916,7 @@ static noinline int split_leaf(struct btrfs_trans_handle *trans,
 			path->nodes[0] = right;
 			path->slots[0] = 0;
 			if (path->slots[1] == 0)
-				fixup_low_keys(path, &disk_key, 1);
+				fixup_low_keys(trans, path, &disk_key, 1);
 		}
 		/*
 		 * We create a new leaf 'right' for the required ins_len and
@@ -4013,7 +4015,8 @@ static noinline int setup_leaf_for_split(struct btrfs_trans_handle *trans,
 	return ret;
 }
 
-static noinline int split_item(struct btrfs_path *path,
+static noinline int split_item(struct btrfs_trans_handle *trans,
+			       struct btrfs_path *path,
 			       const struct btrfs_key *new_key,
 			       unsigned long split_offset)
 {
@@ -4072,7 +4075,7 @@ static noinline int split_item(struct btrfs_path *path,
 	write_extent_buffer(leaf, buf + split_offset,
 			    btrfs_item_ptr_offset(leaf, slot),
 			    item_size - split_offset);
-	btrfs_mark_buffer_dirty(leaf);
+	btrfs_mark_buffer_dirty(trans, leaf);
 
 	BUG_ON(btrfs_leaf_free_space(leaf) < 0);
 	kfree(buf);
@@ -4106,7 +4109,7 @@ int btrfs_split_item(struct btrfs_trans_handle *trans,
 	if (ret)
 		return ret;
 
-	ret = split_item(path, new_key, split_offset);
+	ret = split_item(trans, path, new_key, split_offset);
 	return ret;
 }
 
@@ -4116,7 +4119,8 @@ int btrfs_split_item(struct btrfs_trans_handle *trans,
  * off the end of the item or if we shift the item to chop bytes off
  * the front.
  */
-void btrfs_truncate_item(struct btrfs_path *path, u32 new_size, int from_end)
+void btrfs_truncate_item(struct btrfs_trans_handle *trans,
+			 struct btrfs_path *path, u32 new_size, int from_end)
 {
 	int slot;
 	struct extent_buffer *leaf;
@@ -4192,11 +4196,11 @@ void btrfs_truncate_item(struct btrfs_path *path, u32 new_size, int from_end)
 		btrfs_set_disk_key_offset(&disk_key, offset + size_diff);
 		btrfs_set_item_key(leaf, &disk_key, slot);
 		if (slot == 0)
-			fixup_low_keys(path, &disk_key, 1);
+			fixup_low_keys(trans, path, &disk_key, 1);
 	}
 
 	btrfs_set_item_size(leaf, slot, new_size);
-	btrfs_mark_buffer_dirty(leaf);
+	btrfs_mark_buffer_dirty(trans, leaf);
 
 	if (btrfs_leaf_free_space(leaf) < 0) {
 		btrfs_print_leaf(leaf);
@@ -4207,7 +4211,8 @@ void btrfs_truncate_item(struct btrfs_path *path, u32 new_size, int from_end)
 /*
  * make the item pointed to by the path bigger, data_size is the added size.
  */
-void btrfs_extend_item(struct btrfs_path *path, u32 data_size)
+void btrfs_extend_item(struct btrfs_trans_handle *trans,
+		       struct btrfs_path *path, u32 data_size)
 {
 	int slot;
 	struct extent_buffer *leaf;
@@ -4257,7 +4262,7 @@ void btrfs_extend_item(struct btrfs_path *path, u32 data_size)
 	data_end = old_data;
 	old_size = btrfs_item_size(leaf, slot);
 	btrfs_set_item_size(leaf, slot, old_size + data_size);
-	btrfs_mark_buffer_dirty(leaf);
+	btrfs_mark_buffer_dirty(trans, leaf);
 
 	if (btrfs_leaf_free_space(leaf) < 0) {
 		btrfs_print_leaf(leaf);
@@ -4268,6 +4273,7 @@ void btrfs_extend_item(struct btrfs_path *path, u32 data_size)
 /*
  * Make space in the node before inserting one or more items.
  *
+ * @trans:	transaction handle
  * @root:	root we are inserting items to
  * @path:	points to the leaf/slot where we are going to insert new items
  * @batch:      information about the batch of items to insert
@@ -4275,7 +4281,8 @@ void btrfs_extend_item(struct btrfs_path *path, u32 data_size)
  * Main purpose is to save stack depth by doing the bulk of the work in a
  * function that doesn't call btrfs_search_slot
  */
-static void setup_items_for_insert(struct btrfs_root *root, struct btrfs_path *path,
+static void setup_items_for_insert(struct btrfs_trans_handle *trans,
+				   struct btrfs_root *root, struct btrfs_path *path,
 				   const struct btrfs_item_batch *batch)
 {
 	struct btrfs_fs_info *fs_info = root->fs_info;
@@ -4295,7 +4302,7 @@ static void setup_items_for_insert(struct btrfs_root *root, struct btrfs_path *p
 	 */
 	if (path->slots[0] == 0) {
 		btrfs_cpu_key_to_disk(&disk_key, &batch->keys[0]);
-		fixup_low_keys(path, &disk_key, 1);
+		fixup_low_keys(trans, path, &disk_key, 1);
 	}
 	btrfs_unlock_up_safe(path, 1);
 
@@ -4354,7 +4361,7 @@ static void setup_items_for_insert(struct btrfs_root *root, struct btrfs_path *p
 	}
 
 	btrfs_set_header_nritems(leaf, nritems + batch->nr);
-	btrfs_mark_buffer_dirty(leaf);
+	btrfs_mark_buffer_dirty(trans, leaf);
 
 	if (btrfs_leaf_free_space(leaf) < 0) {
 		btrfs_print_leaf(leaf);
@@ -4365,12 +4372,14 @@ static void setup_items_for_insert(struct btrfs_root *root, struct btrfs_path *p
 /*
  * Insert a new item into a leaf.
  *
+ * @trans:     Transaction handle.
  * @root:      The root of the btree.
  * @path:      A path pointing to the target leaf and slot.
  * @key:       The key of the new item.
  * @data_size: The size of the data associated with the new key.
  */
-void btrfs_setup_item_for_insert(struct btrfs_root *root,
+void btrfs_setup_item_for_insert(struct btrfs_trans_handle *trans,
+				 struct btrfs_root *root,
 				 struct btrfs_path *path,
 				 const struct btrfs_key *key,
 				 u32 data_size)
@@ -4382,7 +4391,7 @@ void btrfs_setup_item_for_insert(struct btrfs_root *root,
 	batch.total_data_size = data_size;
 	batch.nr = 1;
 
-	setup_items_for_insert(root, path, &batch);
+	setup_items_for_insert(trans, root, path, &batch);
 }
 
 /*
@@ -4408,7 +4417,7 @@ int btrfs_insert_empty_items(struct btrfs_trans_handle *trans,
 	slot = path->slots[0];
 	BUG_ON(slot < 0);
 
-	setup_items_for_insert(root, path, batch);
+	setup_items_for_insert(trans, root, path, batch);
 	return 0;
 }
 
@@ -4433,7 +4442,7 @@ int btrfs_insert_item(struct btrfs_trans_handle *trans, struct btrfs_root *root,
 		leaf = path->nodes[0];
 		ptr = btrfs_item_ptr_offset(leaf, path->slots[0]);
 		write_extent_buffer(leaf, data, ptr, data_size);
-		btrfs_mark_buffer_dirty(leaf);
+		btrfs_mark_buffer_dirty(trans, leaf);
 	}
 	btrfs_free_path(path);
 	return ret;
@@ -4464,7 +4473,7 @@ int btrfs_duplicate_item(struct btrfs_trans_handle *trans,
 		return ret;
 
 	path->slots[0]++;
-	btrfs_setup_item_for_insert(root, path, new_key, item_size);
+	btrfs_setup_item_for_insert(trans, root, path, new_key, item_size);
 	leaf = path->nodes[0];
 	memcpy_extent_buffer(leaf,
 			     btrfs_item_ptr_offset(leaf, path->slots[0]),
@@ -4522,9 +4531,9 @@ int btrfs_del_ptr(struct btrfs_trans_handle *trans, struct btrfs_root *root,
 		struct btrfs_disk_key disk_key;
 
 		btrfs_node_key(parent, &disk_key, 0);
-		fixup_low_keys(path, &disk_key, level + 1);
+		fixup_low_keys(trans, path, &disk_key, level + 1);
 	}
-	btrfs_mark_buffer_dirty(parent);
+	btrfs_mark_buffer_dirty(trans, parent);
 	return 0;
 }
 
@@ -4621,7 +4630,7 @@ int btrfs_del_items(struct btrfs_trans_handle *trans, struct btrfs_root *root,
 			struct btrfs_disk_key disk_key;
 
 			btrfs_item_key(leaf, &disk_key, 0);
-			fixup_low_keys(path, &disk_key, 1);
+			fixup_low_keys(trans, path, &disk_key, 1);
 		}
 
 		/*
@@ -4686,11 +4695,11 @@ int btrfs_del_items(struct btrfs_trans_handle *trans, struct btrfs_root *root,
 				 * dirtied this buffer
 				 */
 				if (path->nodes[0] == leaf)
-					btrfs_mark_buffer_dirty(leaf);
+					btrfs_mark_buffer_dirty(trans, leaf);
 				free_extent_buffer(leaf);
 			}
 		} else {
-			btrfs_mark_buffer_dirty(leaf);
+			btrfs_mark_buffer_dirty(trans, leaf);
 		}
 	}
 	return ret;
diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 9419f4e37a58c..c15fb3ec3c907 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -518,7 +518,7 @@ int btrfs_previous_item(struct btrfs_root *root,
 			int type);
 int btrfs_previous_extent_item(struct btrfs_root *root,
 			struct btrfs_path *path, u64 min_objectid);
-void btrfs_set_item_key_safe(struct btrfs_fs_info *fs_info,
+void btrfs_set_item_key_safe(struct btrfs_trans_handle *trans,
 			     struct btrfs_path *path,
 			     const struct btrfs_key *new_key);
 struct extent_buffer *btrfs_root_node(struct btrfs_root *root);
@@ -544,8 +544,10 @@ int btrfs_block_can_be_shared(struct btrfs_root *root,
 			      struct extent_buffer *buf);
 int btrfs_del_ptr(struct btrfs_trans_handle *trans, struct btrfs_root *root,
 		  struct btrfs_path *path, int level, int slot);
-void btrfs_extend_item(struct btrfs_path *path, u32 data_size);
-void btrfs_truncate_item(struct btrfs_path *path, u32 new_size, int from_end);
+void btrfs_extend_item(struct btrfs_trans_handle *trans,
+		       struct btrfs_path *path, u32 data_size);
+void btrfs_truncate_item(struct btrfs_trans_handle *trans,
+			 struct btrfs_path *path, u32 new_size, int from_end);
 int btrfs_split_item(struct btrfs_trans_handle *trans,
 		     struct btrfs_root *root,
 		     struct btrfs_path *path,
@@ -609,7 +611,8 @@ struct btrfs_item_batch {
 	int nr;
 };
 
-void btrfs_setup_item_for_insert(struct btrfs_root *root,
+void btrfs_setup_item_for_insert(struct btrfs_trans_handle *trans,
+				 struct btrfs_root *root,
 				 struct btrfs_path *path,
 				 const struct btrfs_key *key,
 				 u32 data_size);
diff --git a/fs/btrfs/delayed-inode.c b/fs/btrfs/delayed-inode.c
index 142e0a0f6a9fe..5d3229b42b3e2 100644
--- a/fs/btrfs/delayed-inode.c
+++ b/fs/btrfs/delayed-inode.c
@@ -1030,7 +1030,7 @@ static int __btrfs_update_delayed_inode(struct btrfs_trans_handle *trans,
 				    struct btrfs_inode_item);
 	write_extent_buffer(leaf, &node->inode_item, (unsigned long)inode_item,
 			    sizeof(struct btrfs_inode_item));
-	btrfs_mark_buffer_dirty(leaf);
+	btrfs_mark_buffer_dirty(trans, leaf);
 
 	if (!test_bit(BTRFS_DELAYED_NODE_DEL_IREF, &node->flags))
 		goto out;
diff --git a/fs/btrfs/dev-replace.c b/fs/btrfs/dev-replace.c
index 5f10965fd72bf..5549cbd9bdf6a 100644
--- a/fs/btrfs/dev-replace.c
+++ b/fs/btrfs/dev-replace.c
@@ -442,7 +442,7 @@ int btrfs_run_dev_replace(struct btrfs_trans_handle *trans)
 	dev_replace->item_needs_writeback = 0;
 	up_write(&dev_replace->rwsem);
 
-	btrfs_mark_buffer_dirty(eb);
+	btrfs_mark_buffer_dirty(trans, eb);
 
 out:
 	btrfs_free_path(path);
diff --git a/fs/btrfs/dir-item.c b/fs/btrfs/dir-item.c
index 082eb0e195981..9c07d5c3e5ad2 100644
--- a/fs/btrfs/dir-item.c
+++ b/fs/btrfs/dir-item.c
@@ -38,7 +38,7 @@ static struct btrfs_dir_item *insert_with_overflow(struct btrfs_trans_handle
 		di = btrfs_match_dir_item_name(fs_info, path, name, name_len);
 		if (di)
 			return ERR_PTR(-EEXIST);
-		btrfs_extend_item(path, data_size);
+		btrfs_extend_item(trans, path, data_size);
 	} else if (ret < 0)
 		return ERR_PTR(ret);
 	WARN_ON(ret > 0);
@@ -93,7 +93,7 @@ int btrfs_insert_xattr_item(struct btrfs_trans_handle *trans,
 
 	write_extent_buffer(leaf, name, name_ptr, name_len);
 	write_extent_buffer(leaf, data, data_ptr, data_len);
-	btrfs_mark_buffer_dirty(path->nodes[0]);
+	btrfs_mark_buffer_dirty(trans, path->nodes[0]);
 
 	return ret;
 }
@@ -153,7 +153,7 @@ int btrfs_insert_dir_item(struct btrfs_trans_handle *trans,
 	name_ptr = (unsigned long)(dir_item + 1);
 
 	write_extent_buffer(leaf, name->name, name_ptr, name->len);
-	btrfs_mark_buffer_dirty(leaf);
+	btrfs_mark_buffer_dirty(trans, leaf);
 
 second_insert:
 	/* FIXME, use some real flag for selecting the extra index */
@@ -439,7 +439,7 @@ int btrfs_delete_one_dir_name(struct btrfs_trans_handle *trans,
 		start = btrfs_item_ptr_offset(leaf, path->slots[0]);
 		memmove_extent_buffer(leaf, ptr, ptr + sub_item_len,
 			item_len - (ptr + sub_item_len - start));
-		btrfs_truncate_item(path, item_len - sub_item_len, 1);
+		btrfs_truncate_item(trans, path, item_len - sub_item_len, 1);
 	}
 	return ret;
 }
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 681594df7334f..1ae781f533582 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -872,7 +872,7 @@ struct btrfs_root *btrfs_create_tree(struct btrfs_trans_handle *trans,
 	}
 
 	root->node = leaf;
-	btrfs_mark_buffer_dirty(leaf);
+	btrfs_mark_buffer_dirty(trans, leaf);
 
 	root->commit_root = btrfs_root_node(root);
 	set_bit(BTRFS_ROOT_TRACK_DIRTY, &root->state);
@@ -947,7 +947,7 @@ int btrfs_alloc_log_tree_node(struct btrfs_trans_handle *trans,
 
 	root->node = leaf;
 
-	btrfs_mark_buffer_dirty(root->node);
+	btrfs_mark_buffer_dirty(trans, root->node);
 	btrfs_tree_unlock(root->node);
 
 	return 0;
@@ -4426,7 +4426,8 @@ void __cold close_ctree(struct btrfs_fs_info *fs_info)
 	btrfs_close_devices(fs_info->fs_devices);
 }
 
-void btrfs_mark_buffer_dirty(struct extent_buffer *buf)
+void btrfs_mark_buffer_dirty(struct btrfs_trans_handle *trans,
+			     struct extent_buffer *buf)
 {
 	struct btrfs_fs_info *fs_info = buf->fs_info;
 	u64 transid = btrfs_header_generation(buf);
@@ -4440,10 +4441,14 @@ void btrfs_mark_buffer_dirty(struct extent_buffer *buf)
 	if (unlikely(test_bit(EXTENT_BUFFER_UNMAPPED, &buf->bflags)))
 		return;
 #endif
+	/* This is an active transaction (its state < TRANS_STATE_UNBLOCKED). */
+	ASSERT(trans->transid == fs_info->generation);
 	btrfs_assert_tree_write_locked(buf);
-	if (transid != fs_info->generation)
+	if (transid != fs_info->generation) {
 		WARN(1, KERN_CRIT "btrfs transid mismatch buffer %llu, found %llu running %llu\n",
 			buf->start, transid, fs_info->generation);
+		btrfs_abort_transaction(trans, -EUCLEAN);
+	}
 	set_extent_buffer_dirty(buf);
 #ifdef CONFIG_BTRFS_FS_CHECK_INTEGRITY
 	/*
diff --git a/fs/btrfs/disk-io.h b/fs/btrfs/disk-io.h
index b03767f4d7edf..e5bdb96912438 100644
--- a/fs/btrfs/disk-io.h
+++ b/fs/btrfs/disk-io.h
@@ -105,7 +105,8 @@ static inline struct btrfs_root *btrfs_grab_root(struct btrfs_root *root)
 }
 
 void btrfs_put_root(struct btrfs_root *root);
-void btrfs_mark_buffer_dirty(struct extent_buffer *buf);
+void btrfs_mark_buffer_dirty(struct btrfs_trans_handle *trans,
+			     struct extent_buffer *buf);
 int btrfs_buffer_uptodate(struct extent_buffer *buf, u64 parent_transid,
 			  int atomic);
 int btrfs_read_extent_buffer(struct extent_buffer *buf,
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 2cf8d646085c2..6ab349422f765 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -594,7 +594,7 @@ static noinline int insert_extent_data_ref(struct btrfs_trans_handle *trans,
 			btrfs_set_extent_data_ref_count(leaf, ref, num_refs);
 		}
 	}
-	btrfs_mark_buffer_dirty(leaf);
+	btrfs_mark_buffer_dirty(trans, leaf);
 	ret = 0;
 fail:
 	btrfs_release_path(path);
@@ -642,7 +642,7 @@ static noinline int remove_extent_data_ref(struct btrfs_trans_handle *trans,
 			btrfs_set_extent_data_ref_count(leaf, ref1, num_refs);
 		else if (key.type == BTRFS_SHARED_DATA_REF_KEY)
 			btrfs_set_shared_data_ref_count(leaf, ref2, num_refs);
-		btrfs_mark_buffer_dirty(leaf);
+		btrfs_mark_buffer_dirty(trans, leaf);
 	}
 	return ret;
 }
@@ -994,7 +994,7 @@ int lookup_inline_extent_backref(struct btrfs_trans_handle *trans,
  * helper to add new inline back ref
  */
 static noinline_for_stack
-void setup_inline_extent_backref(struct btrfs_fs_info *fs_info,
+void setup_inline_extent_backref(struct btrfs_trans_handle *trans,
 				 struct btrfs_path *path,
 				 struct btrfs_extent_inline_ref *iref,
 				 u64 parent, u64 root_objectid,
@@ -1017,7 +1017,7 @@ void setup_inline_extent_backref(struct btrfs_fs_info *fs_info,
 	type = extent_ref_type(parent, owner);
 	size = btrfs_extent_inline_ref_size(type);
 
-	btrfs_extend_item(path, size);
+	btrfs_extend_item(trans, path, size);
 
 	ei = btrfs_item_ptr(leaf, path->slots[0], struct btrfs_extent_item);
 	refs = btrfs_extent_refs(leaf, ei);
@@ -1051,7 +1051,7 @@ void setup_inline_extent_backref(struct btrfs_fs_info *fs_info,
 	} else {
 		btrfs_set_extent_inline_ref_offset(leaf, iref, root_objectid);
 	}
-	btrfs_mark_buffer_dirty(leaf);
+	btrfs_mark_buffer_dirty(trans, leaf);
 }
 
 static int lookup_extent_backref(struct btrfs_trans_handle *trans,
@@ -1084,7 +1084,9 @@ static int lookup_extent_backref(struct btrfs_trans_handle *trans,
 /*
  * helper to update/remove inline back ref
  */
-static noinline_for_stack int update_inline_extent_backref(struct btrfs_path *path,
+static noinline_for_stack int update_inline_extent_backref(
+				  struct btrfs_trans_handle *trans,
+				  struct btrfs_path *path,
 				  struct btrfs_extent_inline_ref *iref,
 				  int refs_to_mod,
 				  struct btrfs_delayed_extent_op *extent_op)
@@ -1192,9 +1194,9 @@ static noinline_for_stack int update_inline_extent_backref(struct btrfs_path *pa
 			memmove_extent_buffer(leaf, ptr, ptr + size,
 					      end - ptr - size);
 		item_size -= size;
-		btrfs_truncate_item(path, item_size, 1);
+		btrfs_truncate_item(trans, path, item_size, 1);
 	}
-	btrfs_mark_buffer_dirty(leaf);
+	btrfs_mark_buffer_dirty(trans, leaf);
 	return 0;
 }
 
@@ -1224,9 +1226,10 @@ int insert_inline_extent_backref(struct btrfs_trans_handle *trans,
 				   bytenr, num_bytes, root_objectid, path->slots[0]);
 			return -EUCLEAN;
 		}
-		ret = update_inline_extent_backref(path, iref, refs_to_add, extent_op);
+		ret = update_inline_extent_backref(trans, path, iref,
+						   refs_to_add, extent_op);
 	} else if (ret == -ENOENT) {
-		setup_inline_extent_backref(trans->fs_info, path, iref, parent,
+		setup_inline_extent_backref(trans, path, iref, parent,
 					    root_objectid, owner, offset,
 					    refs_to_add, extent_op);
 		ret = 0;
@@ -1244,7 +1247,8 @@ static int remove_extent_backref(struct btrfs_trans_handle *trans,
 
 	BUG_ON(!is_data && refs_to_drop != 1);
 	if (iref)
-		ret = update_inline_extent_backref(path, iref, -refs_to_drop, NULL);
+		ret = update_inline_extent_backref(trans, path, iref,
+						   -refs_to_drop, NULL);
 	else if (is_data)
 		ret = remove_extent_data_ref(trans, root, path, refs_to_drop);
 	else
@@ -1528,7 +1532,7 @@ static int __btrfs_inc_extent_ref(struct btrfs_trans_handle *trans,
 	if (extent_op)
 		__run_delayed_extent_op(extent_op, leaf, item);
 
-	btrfs_mark_buffer_dirty(leaf);
+	btrfs_mark_buffer_dirty(trans, leaf);
 	btrfs_release_path(path);
 
 	/* now insert the actual backref */
@@ -1692,7 +1696,7 @@ static int run_delayed_extent_op(struct btrfs_trans_handle *trans,
 	ei = btrfs_item_ptr(leaf, path->slots[0], struct btrfs_extent_item);
 	__run_delayed_extent_op(extent_op, leaf, ei);
 
-	btrfs_mark_buffer_dirty(leaf);
+	btrfs_mark_buffer_dirty(trans, leaf);
 out:
 	btrfs_free_path(path);
 	return err;
@@ -3164,7 +3168,7 @@ static int __btrfs_free_extent(struct btrfs_trans_handle *trans,
 			}
 		} else {
 			btrfs_set_extent_refs(leaf, ei, refs);
-			btrfs_mark_buffer_dirty(leaf);
+			btrfs_mark_buffer_dirty(trans, leaf);
 		}
 		if (found_extent) {
 			ret = remove_extent_backref(trans, extent_root, path,
@@ -4672,7 +4676,7 @@ static int alloc_reserved_file_extent(struct btrfs_trans_handle *trans,
 		btrfs_set_extent_data_ref_count(leaf, ref, ref_mod);
 	}
 
-	btrfs_mark_buffer_dirty(path->nodes[0]);
+	btrfs_mark_buffer_dirty(trans, path->nodes[0]);
 	btrfs_free_path(path);
 
 	return alloc_reserved_extent(trans, ins->objectid, ins->offset);
@@ -4747,7 +4751,7 @@ static int alloc_reserved_tree_block(struct btrfs_trans_handle *trans,
 		btrfs_set_extent_inline_ref_offset(leaf, iref, ref->root);
 	}
 
-	btrfs_mark_buffer_dirty(leaf);
+	btrfs_mark_buffer_dirty(trans, leaf);
 	btrfs_free_path(path);
 
 	return alloc_reserved_extent(trans, node->bytenr, fs_info->nodesize);
diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
index 1ce5dd1544995..45cae356e89ba 100644
--- a/fs/btrfs/file-item.c
+++ b/fs/btrfs/file-item.c
@@ -194,7 +194,7 @@ int btrfs_insert_hole_extent(struct btrfs_trans_handle *trans,
 	btrfs_set_file_extent_encryption(leaf, item, 0);
 	btrfs_set_file_extent_other_encoding(leaf, item, 0);
 
-	btrfs_mark_buffer_dirty(leaf);
+	btrfs_mark_buffer_dirty(trans, leaf);
 out:
 	btrfs_free_path(path);
 	return ret;
@@ -811,11 +811,12 @@ blk_status_t btrfs_alloc_dummy_sum(struct btrfs_bio *bbio)
  * This calls btrfs_truncate_item with the correct args based on the overlap,
  * and fixes up the key as required.
  */
-static noinline void truncate_one_csum(struct btrfs_fs_info *fs_info,
+static noinline void truncate_one_csum(struct btrfs_trans_handle *trans,
 				       struct btrfs_path *path,
 				       struct btrfs_key *key,
 				       u64 bytenr, u64 len)
 {
+	struct btrfs_fs_info *fs_info = trans->fs_info;
 	struct extent_buffer *leaf;
 	const u32 csum_size = fs_info->csum_size;
 	u64 csum_end;
@@ -836,7 +837,7 @@ static noinline void truncate_one_csum(struct btrfs_fs_info *fs_info,
 		 */
 		u32 new_size = (bytenr - key->offset) >> blocksize_bits;
 		new_size *= csum_size;
-		btrfs_truncate_item(path, new_size, 1);
+		btrfs_truncate_item(trans, path, new_size, 1);
 	} else if (key->offset >= bytenr && csum_end > end_byte &&
 		   end_byte > key->offset) {
 		/*
@@ -848,10 +849,10 @@ static noinline void truncate_one_csum(struct btrfs_fs_info *fs_info,
 		u32 new_size = (csum_end - end_byte) >> blocksize_bits;
 		new_size *= csum_size;
 
-		btrfs_truncate_item(path, new_size, 0);
+		btrfs_truncate_item(trans, path, new_size, 0);
 
 		key->offset = end_byte;
-		btrfs_set_item_key_safe(fs_info, path, key);
+		btrfs_set_item_key_safe(trans, path, key);
 	} else {
 		BUG();
 	}
@@ -994,7 +995,7 @@ int btrfs_del_csums(struct btrfs_trans_handle *trans,
 
 			key.offset = end_byte - 1;
 		} else {
-			truncate_one_csum(fs_info, path, &key, bytenr, len);
+			truncate_one_csum(trans, path, &key, bytenr, len);
 			if (key.offset < bytenr)
 				break;
 		}
@@ -1202,7 +1203,7 @@ int btrfs_csum_file_blocks(struct btrfs_trans_handle *trans,
 		diff /= csum_size;
 		diff *= csum_size;
 
-		btrfs_extend_item(path, diff);
+		btrfs_extend_item(trans, path, diff);
 		ret = 0;
 		goto csum;
 	}
@@ -1249,7 +1250,7 @@ int btrfs_csum_file_blocks(struct btrfs_trans_handle *trans,
 	ins_size /= csum_size;
 	total_bytes += ins_size * fs_info->sectorsize;
 
-	btrfs_mark_buffer_dirty(path->nodes[0]);
+	btrfs_mark_buffer_dirty(trans, path->nodes[0]);
 	if (total_bytes < sums->len) {
 		btrfs_release_path(path);
 		cond_resched();
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index eae9175f2c29b..a407af38a9237 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -368,7 +368,7 @@ int btrfs_drop_extents(struct btrfs_trans_handle *trans,
 			btrfs_set_file_extent_offset(leaf, fi, extent_offset);
 			btrfs_set_file_extent_num_bytes(leaf, fi,
 							extent_end - args->start);
-			btrfs_mark_buffer_dirty(leaf);
+			btrfs_mark_buffer_dirty(trans, leaf);
 
 			if (update_refs && disk_bytenr > 0) {
 				btrfs_init_generic_ref(&ref,
@@ -405,13 +405,13 @@ int btrfs_drop_extents(struct btrfs_trans_handle *trans,
 
 			memcpy(&new_key, &key, sizeof(new_key));
 			new_key.offset = args->end;
-			btrfs_set_item_key_safe(fs_info, path, &new_key);
+			btrfs_set_item_key_safe(trans, path, &new_key);
 
 			extent_offset += args->end - key.offset;
 			btrfs_set_file_extent_offset(leaf, fi, extent_offset);
 			btrfs_set_file_extent_num_bytes(leaf, fi,
 							extent_end - args->end);
-			btrfs_mark_buffer_dirty(leaf);
+			btrfs_mark_buffer_dirty(trans, leaf);
 			if (update_refs && disk_bytenr > 0)
 				args->bytes_found += args->end - key.offset;
 			break;
@@ -431,7 +431,7 @@ int btrfs_drop_extents(struct btrfs_trans_handle *trans,
 
 			btrfs_set_file_extent_num_bytes(leaf, fi,
 							args->start - key.offset);
-			btrfs_mark_buffer_dirty(leaf);
+			btrfs_mark_buffer_dirty(trans, leaf);
 			if (update_refs && disk_bytenr > 0)
 				args->bytes_found += extent_end - args->start;
 			if (args->end == extent_end)
@@ -536,7 +536,8 @@ int btrfs_drop_extents(struct btrfs_trans_handle *trans,
 			if (btrfs_comp_cpu_keys(&key, &slot_key) > 0)
 				path->slots[0]++;
 		}
-		btrfs_setup_item_for_insert(root, path, &key, args->extent_item_size);
+		btrfs_setup_item_for_insert(trans, root, path, &key,
+					    args->extent_item_size);
 		args->extent_inserted = true;
 	}
 
@@ -593,7 +594,6 @@ static int extent_mergeable(struct extent_buffer *leaf, int slot,
 int btrfs_mark_extent_written(struct btrfs_trans_handle *trans,
 			      struct btrfs_inode *inode, u64 start, u64 end)
 {
-	struct btrfs_fs_info *fs_info = trans->fs_info;
 	struct btrfs_root *root = inode->root;
 	struct extent_buffer *leaf;
 	struct btrfs_path *path;
@@ -664,7 +664,7 @@ int btrfs_mark_extent_written(struct btrfs_trans_handle *trans,
 				     ino, bytenr, orig_offset,
 				     &other_start, &other_end)) {
 			new_key.offset = end;
-			btrfs_set_item_key_safe(fs_info, path, &new_key);
+			btrfs_set_item_key_safe(trans, path, &new_key);
 			fi = btrfs_item_ptr(leaf, path->slots[0],
 					    struct btrfs_file_extent_item);
 			btrfs_set_file_extent_generation(leaf, fi,
@@ -679,7 +679,7 @@ int btrfs_mark_extent_written(struct btrfs_trans_handle *trans,
 							 trans->transid);
 			btrfs_set_file_extent_num_bytes(leaf, fi,
 							end - other_start);
-			btrfs_mark_buffer_dirty(leaf);
+			btrfs_mark_buffer_dirty(trans, leaf);
 			goto out;
 		}
 	}
@@ -698,7 +698,7 @@ int btrfs_mark_extent_written(struct btrfs_trans_handle *trans,
 							 trans->transid);
 			path->slots[0]++;
 			new_key.offset = start;
-			btrfs_set_item_key_safe(fs_info, path, &new_key);
+			btrfs_set_item_key_safe(trans, path, &new_key);
 
 			fi = btrfs_item_ptr(leaf, path->slots[0],
 					    struct btrfs_file_extent_item);
@@ -708,7 +708,7 @@ int btrfs_mark_extent_written(struct btrfs_trans_handle *trans,
 							other_end - start);
 			btrfs_set_file_extent_offset(leaf, fi,
 						     start - orig_offset);
-			btrfs_mark_buffer_dirty(leaf);
+			btrfs_mark_buffer_dirty(trans, leaf);
 			goto out;
 		}
 	}
@@ -742,7 +742,7 @@ int btrfs_mark_extent_written(struct btrfs_trans_handle *trans,
 		btrfs_set_file_extent_offset(leaf, fi, split - orig_offset);
 		btrfs_set_file_extent_num_bytes(leaf, fi,
 						extent_end - split);
-		btrfs_mark_buffer_dirty(leaf);
+		btrfs_mark_buffer_dirty(trans, leaf);
 
 		btrfs_init_generic_ref(&ref, BTRFS_ADD_DELAYED_REF, bytenr,
 				       num_bytes, 0);
@@ -814,7 +814,7 @@ int btrfs_mark_extent_written(struct btrfs_trans_handle *trans,
 		btrfs_set_file_extent_type(leaf, fi,
 					   BTRFS_FILE_EXTENT_REG);
 		btrfs_set_file_extent_generation(leaf, fi, trans->transid);
-		btrfs_mark_buffer_dirty(leaf);
+		btrfs_mark_buffer_dirty(trans, leaf);
 	} else {
 		fi = btrfs_item_ptr(leaf, del_slot - 1,
 			   struct btrfs_file_extent_item);
@@ -823,7 +823,7 @@ int btrfs_mark_extent_written(struct btrfs_trans_handle *trans,
 		btrfs_set_file_extent_generation(leaf, fi, trans->transid);
 		btrfs_set_file_extent_num_bytes(leaf, fi,
 						extent_end - key.offset);
-		btrfs_mark_buffer_dirty(leaf);
+		btrfs_mark_buffer_dirty(trans, leaf);
 
 		ret = btrfs_del_items(trans, root, path, del_slot, del_nr);
 		if (ret < 0) {
@@ -2103,7 +2103,7 @@ static int fill_holes(struct btrfs_trans_handle *trans,
 		btrfs_set_file_extent_ram_bytes(leaf, fi, num_bytes);
 		btrfs_set_file_extent_offset(leaf, fi, 0);
 		btrfs_set_file_extent_generation(leaf, fi, trans->transid);
-		btrfs_mark_buffer_dirty(leaf);
+		btrfs_mark_buffer_dirty(trans, leaf);
 		goto out;
 	}
 
@@ -2111,7 +2111,7 @@ static int fill_holes(struct btrfs_trans_handle *trans,
 		u64 num_bytes;
 
 		key.offset = offset;
-		btrfs_set_item_key_safe(fs_info, path, &key);
+		btrfs_set_item_key_safe(trans, path, &key);
 		fi = btrfs_item_ptr(leaf, path->slots[0],
 				    struct btrfs_file_extent_item);
 		num_bytes = btrfs_file_extent_num_bytes(leaf, fi) + end -
@@ -2120,7 +2120,7 @@ static int fill_holes(struct btrfs_trans_handle *trans,
 		btrfs_set_file_extent_ram_bytes(leaf, fi, num_bytes);
 		btrfs_set_file_extent_offset(leaf, fi, 0);
 		btrfs_set_file_extent_generation(leaf, fi, trans->transid);
-		btrfs_mark_buffer_dirty(leaf);
+		btrfs_mark_buffer_dirty(trans, leaf);
 		goto out;
 	}
 	btrfs_release_path(path);
@@ -2272,7 +2272,7 @@ static int btrfs_insert_replace_extent(struct btrfs_trans_handle *trans,
 	btrfs_set_file_extent_num_bytes(leaf, extent, replace_len);
 	if (extent_info->is_new_extent)
 		btrfs_set_file_extent_generation(leaf, extent, trans->transid);
-	btrfs_mark_buffer_dirty(leaf);
+	btrfs_mark_buffer_dirty(trans, leaf);
 	btrfs_release_path(path);
 
 	ret = btrfs_inode_set_file_extent_range(inode, extent_info->file_offset,
diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index 8808004180759..6b7383ae5a70c 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -195,7 +195,7 @@ static int __create_free_space_inode(struct btrfs_root *root,
 	btrfs_set_inode_nlink(leaf, inode_item, 1);
 	btrfs_set_inode_transid(leaf, inode_item, trans->transid);
 	btrfs_set_inode_block_group(leaf, inode_item, offset);
-	btrfs_mark_buffer_dirty(leaf);
+	btrfs_mark_buffer_dirty(trans, leaf);
 	btrfs_release_path(path);
 
 	key.objectid = BTRFS_FREE_SPACE_OBJECTID;
@@ -213,7 +213,7 @@ static int __create_free_space_inode(struct btrfs_root *root,
 				struct btrfs_free_space_header);
 	memzero_extent_buffer(leaf, (unsigned long)header, sizeof(*header));
 	btrfs_set_free_space_key(leaf, header, &disk_key);
-	btrfs_mark_buffer_dirty(leaf);
+	btrfs_mark_buffer_dirty(trans, leaf);
 	btrfs_release_path(path);
 
 	return 0;
@@ -1185,7 +1185,7 @@ update_cache_item(struct btrfs_trans_handle *trans,
 	btrfs_set_free_space_entries(leaf, header, entries);
 	btrfs_set_free_space_bitmaps(leaf, header, bitmaps);
 	btrfs_set_free_space_generation(leaf, header, trans->transid);
-	btrfs_mark_buffer_dirty(leaf);
+	btrfs_mark_buffer_dirty(trans, leaf);
 	btrfs_release_path(path);
 
 	return 0;
diff --git a/fs/btrfs/free-space-tree.c b/fs/btrfs/free-space-tree.c
index f169378e2ca6e..ae060a26e1191 100644
--- a/fs/btrfs/free-space-tree.c
+++ b/fs/btrfs/free-space-tree.c
@@ -89,7 +89,7 @@ static int add_new_free_space_info(struct btrfs_trans_handle *trans,
 			      struct btrfs_free_space_info);
 	btrfs_set_free_space_extent_count(leaf, info, 0);
 	btrfs_set_free_space_flags(leaf, info, 0);
-	btrfs_mark_buffer_dirty(leaf);
+	btrfs_mark_buffer_dirty(trans, leaf);
 
 	ret = 0;
 out:
@@ -287,7 +287,7 @@ int convert_free_space_to_bitmaps(struct btrfs_trans_handle *trans,
 	flags |= BTRFS_FREE_SPACE_USING_BITMAPS;
 	btrfs_set_free_space_flags(leaf, info, flags);
 	expected_extent_count = btrfs_free_space_extent_count(leaf, info);
-	btrfs_mark_buffer_dirty(leaf);
+	btrfs_mark_buffer_dirty(trans, leaf);
 	btrfs_release_path(path);
 
 	if (extent_count != expected_extent_count) {
@@ -324,7 +324,7 @@ int convert_free_space_to_bitmaps(struct btrfs_trans_handle *trans,
 		ptr = btrfs_item_ptr_offset(leaf, path->slots[0]);
 		write_extent_buffer(leaf, bitmap_cursor, ptr,
 				    data_size);
-		btrfs_mark_buffer_dirty(leaf);
+		btrfs_mark_buffer_dirty(trans, leaf);
 		btrfs_release_path(path);
 
 		i += extent_size;
@@ -430,7 +430,7 @@ int convert_free_space_to_extents(struct btrfs_trans_handle *trans,
 	flags &= ~BTRFS_FREE_SPACE_USING_BITMAPS;
 	btrfs_set_free_space_flags(leaf, info, flags);
 	expected_extent_count = btrfs_free_space_extent_count(leaf, info);
-	btrfs_mark_buffer_dirty(leaf);
+	btrfs_mark_buffer_dirty(trans, leaf);
 	btrfs_release_path(path);
 
 	nrbits = block_group->length >> block_group->fs_info->sectorsize_bits;
@@ -495,7 +495,7 @@ static int update_free_space_extent_count(struct btrfs_trans_handle *trans,
 
 	extent_count += new_extents;
 	btrfs_set_free_space_extent_count(path->nodes[0], info, extent_count);
-	btrfs_mark_buffer_dirty(path->nodes[0]);
+	btrfs_mark_buffer_dirty(trans, path->nodes[0]);
 	btrfs_release_path(path);
 
 	if (!(flags & BTRFS_FREE_SPACE_USING_BITMAPS) &&
@@ -533,7 +533,8 @@ int free_space_test_bit(struct btrfs_block_group *block_group,
 	return !!extent_buffer_test_bit(leaf, ptr, i);
 }
 
-static void free_space_set_bits(struct btrfs_block_group *block_group,
+static void free_space_set_bits(struct btrfs_trans_handle *trans,
+				struct btrfs_block_group *block_group,
 				struct btrfs_path *path, u64 *start, u64 *size,
 				int bit)
 {
@@ -563,7 +564,7 @@ static void free_space_set_bits(struct btrfs_block_group *block_group,
 		extent_buffer_bitmap_set(leaf, ptr, first, last - first);
 	else
 		extent_buffer_bitmap_clear(leaf, ptr, first, last - first);
-	btrfs_mark_buffer_dirty(leaf);
+	btrfs_mark_buffer_dirty(trans, leaf);
 
 	*size -= end - *start;
 	*start = end;
@@ -656,7 +657,7 @@ static int modify_free_space_bitmap(struct btrfs_trans_handle *trans,
 	cur_start = start;
 	cur_size = size;
 	while (1) {
-		free_space_set_bits(block_group, path, &cur_start, &cur_size,
+		free_space_set_bits(trans, block_group, path, &cur_start, &cur_size,
 				    !remove);
 		if (cur_size == 0)
 			break;
diff --git a/fs/btrfs/inode-item.c b/fs/btrfs/inode-item.c
index 4c322b720a80a..d3ff97374d48a 100644
--- a/fs/btrfs/inode-item.c
+++ b/fs/btrfs/inode-item.c
@@ -167,7 +167,7 @@ static int btrfs_del_inode_extref(struct btrfs_trans_handle *trans,
 	memmove_extent_buffer(leaf, ptr, ptr + del_len,
 			      item_size - (ptr + del_len - item_start));
 
-	btrfs_truncate_item(path, item_size - del_len, 1);
+	btrfs_truncate_item(trans, path, item_size - del_len, 1);
 
 out:
 	btrfs_free_path(path);
@@ -229,7 +229,7 @@ int btrfs_del_inode_ref(struct btrfs_trans_handle *trans,
 	item_start = btrfs_item_ptr_offset(leaf, path->slots[0]);
 	memmove_extent_buffer(leaf, ptr, ptr + sub_item_len,
 			      item_size - (ptr + sub_item_len - item_start));
-	btrfs_truncate_item(path, item_size - sub_item_len, 1);
+	btrfs_truncate_item(trans, path, item_size - sub_item_len, 1);
 out:
 	btrfs_free_path(path);
 
@@ -282,7 +282,7 @@ static int btrfs_insert_inode_extref(struct btrfs_trans_handle *trans,
 						   name))
 			goto out;
 
-		btrfs_extend_item(path, ins_len);
+		btrfs_extend_item(trans, path, ins_len);
 		ret = 0;
 	}
 	if (ret < 0)
@@ -299,7 +299,7 @@ static int btrfs_insert_inode_extref(struct btrfs_trans_handle *trans,
 
 	ptr = (unsigned long)&extref->name;
 	write_extent_buffer(path->nodes[0], name->name, ptr, name->len);
-	btrfs_mark_buffer_dirty(path->nodes[0]);
+	btrfs_mark_buffer_dirty(trans, path->nodes[0]);
 
 out:
 	btrfs_free_path(path);
@@ -338,7 +338,7 @@ int btrfs_insert_inode_ref(struct btrfs_trans_handle *trans,
 			goto out;
 
 		old_size = btrfs_item_size(path->nodes[0], path->slots[0]);
-		btrfs_extend_item(path, ins_len);
+		btrfs_extend_item(trans, path, ins_len);
 		ref = btrfs_item_ptr(path->nodes[0], path->slots[0],
 				     struct btrfs_inode_ref);
 		ref = (struct btrfs_inode_ref *)((unsigned long)ref + old_size);
@@ -364,7 +364,7 @@ int btrfs_insert_inode_ref(struct btrfs_trans_handle *trans,
 		ptr = (unsigned long)(ref + 1);
 	}
 	write_extent_buffer(path->nodes[0], name->name, ptr, name->len);
-	btrfs_mark_buffer_dirty(path->nodes[0]);
+	btrfs_mark_buffer_dirty(trans, path->nodes[0]);
 
 out:
 	btrfs_free_path(path);
@@ -591,7 +591,7 @@ int btrfs_truncate_inode_items(struct btrfs_trans_handle *trans,
 				num_dec = (orig_num_bytes - extent_num_bytes);
 				if (extent_start != 0)
 					control->sub_bytes += num_dec;
-				btrfs_mark_buffer_dirty(leaf);
+				btrfs_mark_buffer_dirty(trans, leaf);
 			} else {
 				extent_num_bytes =
 					btrfs_file_extent_disk_num_bytes(leaf, fi);
@@ -617,7 +617,7 @@ int btrfs_truncate_inode_items(struct btrfs_trans_handle *trans,
 
 				btrfs_set_file_extent_ram_bytes(leaf, fi, size);
 				size = btrfs_file_extent_calc_inline_size(size);
-				btrfs_truncate_item(path, size, 1);
+				btrfs_truncate_item(trans, path, size, 1);
 			} else if (!del_item) {
 				/*
 				 * We have to bail so the last_size is set to
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 0f4498dfa30c9..58e104f118f96 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -573,7 +573,7 @@ static int insert_inline_extent(struct btrfs_trans_handle *trans,
 		kunmap_local(kaddr);
 		put_page(page);
 	}
-	btrfs_mark_buffer_dirty(leaf);
+	btrfs_mark_buffer_dirty(trans, leaf);
 	btrfs_release_path(path);
 
 	/*
@@ -3072,7 +3072,7 @@ static int insert_reserved_file_extent(struct btrfs_trans_handle *trans,
 			btrfs_item_ptr_offset(leaf, path->slots[0]),
 			sizeof(struct btrfs_file_extent_item));
 
-	btrfs_mark_buffer_dirty(leaf);
+	btrfs_mark_buffer_dirty(trans, leaf);
 	btrfs_release_path(path);
 
 	/*
@@ -4134,7 +4134,7 @@ static noinline int btrfs_update_inode_item(struct btrfs_trans_handle *trans,
 				    struct btrfs_inode_item);
 
 	fill_inode_item(trans, leaf, inode_item, &inode->vfs_inode);
-	btrfs_mark_buffer_dirty(leaf);
+	btrfs_mark_buffer_dirty(trans, leaf);
 	btrfs_set_inode_last_trans(trans, inode);
 	ret = 0;
 failed:
@@ -6476,7 +6476,7 @@ int btrfs_create_new_inode(struct btrfs_trans_handle *trans,
 		}
 	}
 
-	btrfs_mark_buffer_dirty(path->nodes[0]);
+	btrfs_mark_buffer_dirty(trans, path->nodes[0]);
 	/*
 	 * We don't need the path anymore, plus inheriting properties, adding
 	 * ACLs, security xattrs, orphan item or adding the link, will result in
@@ -9630,7 +9630,7 @@ static int btrfs_symlink(struct mnt_idmap *idmap, struct inode *dir,
 
 	ptr = btrfs_file_extent_inline_start(ei);
 	write_extent_buffer(leaf, symname, ptr, name_len);
-	btrfs_mark_buffer_dirty(leaf);
+	btrfs_mark_buffer_dirty(trans, leaf);
 	btrfs_free_path(path);
 
 	d_instantiate_new(dentry, inode);
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index bf35b6fce8f07..74f6b1dff5a90 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -663,7 +663,7 @@ static noinline int create_subvol(struct mnt_idmap *idmap,
 		goto out;
 	}
 
-	btrfs_mark_buffer_dirty(leaf);
+	btrfs_mark_buffer_dirty(trans, leaf);
 
 	inode_item = &root_item->inode;
 	btrfs_set_stack_inode_generation(inode_item, 1);
@@ -2947,7 +2947,7 @@ static long btrfs_ioctl_default_subvol(struct file *file, void __user *argp)
 
 	btrfs_cpu_key_to_disk(&disk_key, &new_root->root_key);
 	btrfs_set_dir_item_key(path->nodes[0], di, &disk_key);
-	btrfs_mark_buffer_dirty(path->nodes[0]);
+	btrfs_mark_buffer_dirty(trans, path->nodes[0]);
 	btrfs_release_path(path);
 
 	btrfs_set_fs_incompat(fs_info, DEFAULT_SUBVOL);
diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index 2637d6b157ff9..74cabaa59be71 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -622,7 +622,7 @@ static int add_qgroup_relation_item(struct btrfs_trans_handle *trans, u64 src,
 
 	ret = btrfs_insert_empty_item(trans, quota_root, path, &key, 0);
 
-	btrfs_mark_buffer_dirty(path->nodes[0]);
+	btrfs_mark_buffer_dirty(trans, path->nodes[0]);
 
 	btrfs_free_path(path);
 	return ret;
@@ -700,7 +700,7 @@ static int add_qgroup_item(struct btrfs_trans_handle *trans,
 	btrfs_set_qgroup_info_excl(leaf, qgroup_info, 0);
 	btrfs_set_qgroup_info_excl_cmpr(leaf, qgroup_info, 0);
 
-	btrfs_mark_buffer_dirty(leaf);
+	btrfs_mark_buffer_dirty(trans, leaf);
 
 	btrfs_release_path(path);
 
@@ -719,7 +719,7 @@ static int add_qgroup_item(struct btrfs_trans_handle *trans,
 	btrfs_set_qgroup_limit_rsv_rfer(leaf, qgroup_limit, 0);
 	btrfs_set_qgroup_limit_rsv_excl(leaf, qgroup_limit, 0);
 
-	btrfs_mark_buffer_dirty(leaf);
+	btrfs_mark_buffer_dirty(trans, leaf);
 
 	ret = 0;
 out:
@@ -808,7 +808,7 @@ static int update_qgroup_limit_item(struct btrfs_trans_handle *trans,
 	btrfs_set_qgroup_limit_rsv_rfer(l, qgroup_limit, qgroup->rsv_rfer);
 	btrfs_set_qgroup_limit_rsv_excl(l, qgroup_limit, qgroup->rsv_excl);
 
-	btrfs_mark_buffer_dirty(l);
+	btrfs_mark_buffer_dirty(trans, l);
 
 out:
 	btrfs_free_path(path);
@@ -854,7 +854,7 @@ static int update_qgroup_info_item(struct btrfs_trans_handle *trans,
 	btrfs_set_qgroup_info_excl(l, qgroup_info, qgroup->excl);
 	btrfs_set_qgroup_info_excl_cmpr(l, qgroup_info, qgroup->excl_cmpr);
 
-	btrfs_mark_buffer_dirty(l);
+	btrfs_mark_buffer_dirty(trans, l);
 
 out:
 	btrfs_free_path(path);
@@ -896,7 +896,7 @@ static int update_qgroup_status_item(struct btrfs_trans_handle *trans)
 	btrfs_set_qgroup_status_rescan(l, ptr,
 				fs_info->qgroup_rescan_progress.objectid);
 
-	btrfs_mark_buffer_dirty(l);
+	btrfs_mark_buffer_dirty(trans, l);
 
 out:
 	btrfs_free_path(path);
@@ -1069,7 +1069,7 @@ int btrfs_quota_enable(struct btrfs_fs_info *fs_info)
 				      BTRFS_QGROUP_STATUS_FLAGS_MASK);
 	btrfs_set_qgroup_status_rescan(leaf, ptr, 0);
 
-	btrfs_mark_buffer_dirty(leaf);
+	btrfs_mark_buffer_dirty(trans, leaf);
 
 	key.objectid = 0;
 	key.type = BTRFS_ROOT_REF_KEY;
diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 5f4ff7d5b5c19..4b7ced217d3e2 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -1180,7 +1180,7 @@ int replace_file_extents(struct btrfs_trans_handle *trans,
 		}
 	}
 	if (dirty)
-		btrfs_mark_buffer_dirty(leaf);
+		btrfs_mark_buffer_dirty(trans, leaf);
 	if (inode)
 		btrfs_add_delayed_iput(BTRFS_I(inode));
 	return ret;
@@ -1373,13 +1373,13 @@ int replace_path(struct btrfs_trans_handle *trans, struct reloc_control *rc,
 		 */
 		btrfs_set_node_blockptr(parent, slot, new_bytenr);
 		btrfs_set_node_ptr_generation(parent, slot, new_ptr_gen);
-		btrfs_mark_buffer_dirty(parent);
+		btrfs_mark_buffer_dirty(trans, parent);
 
 		btrfs_set_node_blockptr(path->nodes[level],
 					path->slots[level], old_bytenr);
 		btrfs_set_node_ptr_generation(path->nodes[level],
 					      path->slots[level], old_ptr_gen);
-		btrfs_mark_buffer_dirty(path->nodes[level]);
+		btrfs_mark_buffer_dirty(trans, path->nodes[level]);
 
 		btrfs_init_generic_ref(&ref, BTRFS_ADD_DELAYED_REF, old_bytenr,
 				       blocksize, path->nodes[level]->start);
@@ -2516,7 +2516,7 @@ static int do_relocation(struct btrfs_trans_handle *trans,
 						node->eb->start);
 			btrfs_set_node_ptr_generation(upper->eb, slot,
 						      trans->transid);
-			btrfs_mark_buffer_dirty(upper->eb);
+			btrfs_mark_buffer_dirty(trans, upper->eb);
 
 			btrfs_init_generic_ref(&ref, BTRFS_ADD_DELAYED_REF,
 					       node->eb->start, blocksize,
@@ -3831,7 +3831,7 @@ static int __insert_orphan_inode(struct btrfs_trans_handle *trans,
 	btrfs_set_inode_mode(leaf, item, S_IFREG | 0600);
 	btrfs_set_inode_flags(leaf, item, BTRFS_INODE_NOCOMPRESS |
 					  BTRFS_INODE_PREALLOC);
-	btrfs_mark_buffer_dirty(leaf);
+	btrfs_mark_buffer_dirty(trans, leaf);
 out:
 	btrfs_free_path(path);
 	return ret;
diff --git a/fs/btrfs/root-tree.c b/fs/btrfs/root-tree.c
index 859874579456f..5b0f1bccc409c 100644
--- a/fs/btrfs/root-tree.c
+++ b/fs/btrfs/root-tree.c
@@ -191,7 +191,7 @@ int btrfs_update_root(struct btrfs_trans_handle *trans, struct btrfs_root
 	btrfs_set_root_generation_v2(item, btrfs_root_generation(item));
 
 	write_extent_buffer(l, item, ptr, sizeof(*item));
-	btrfs_mark_buffer_dirty(path->nodes[0]);
+	btrfs_mark_buffer_dirty(trans, path->nodes[0]);
 out:
 	btrfs_free_path(path);
 	return ret;
@@ -438,7 +438,7 @@ int btrfs_add_root_ref(struct btrfs_trans_handle *trans, u64 root_id,
 	btrfs_set_root_ref_name_len(leaf, ref, name->len);
 	ptr = (unsigned long)(ref + 1);
 	write_extent_buffer(leaf, name->name, ptr, name->len);
-	btrfs_mark_buffer_dirty(leaf);
+	btrfs_mark_buffer_dirty(trans, leaf);
 
 	if (key.type == BTRFS_ROOT_BACKREF_KEY) {
 		btrfs_release_path(path);
diff --git a/fs/btrfs/tests/extent-buffer-tests.c b/fs/btrfs/tests/extent-buffer-tests.c
index 5ef0b90e25c3b..6a43a64ba55ad 100644
--- a/fs/btrfs/tests/extent-buffer-tests.c
+++ b/fs/btrfs/tests/extent-buffer-tests.c
@@ -61,7 +61,11 @@ static int test_btrfs_split_item(u32 sectorsize, u32 nodesize)
 	key.type = BTRFS_EXTENT_CSUM_KEY;
 	key.offset = 0;
 
-	btrfs_setup_item_for_insert(root, path, &key, value_len);
+	/*
+	 * Passing a NULL trans handle is fine here, we have a dummy root eb
+	 * and the tree is a single node (level 0).
+	 */
+	btrfs_setup_item_for_insert(NULL, root, path, &key, value_len);
 	write_extent_buffer(eb, value, btrfs_item_ptr_offset(eb, 0),
 			    value_len);
 
diff --git a/fs/btrfs/tests/inode-tests.c b/fs/btrfs/tests/inode-tests.c
index 05b03f5eab83b..492d69d2fa737 100644
--- a/fs/btrfs/tests/inode-tests.c
+++ b/fs/btrfs/tests/inode-tests.c
@@ -34,7 +34,11 @@ static void insert_extent(struct btrfs_root *root, u64 start, u64 len,
 	key.type = BTRFS_EXTENT_DATA_KEY;
 	key.offset = start;
 
-	btrfs_setup_item_for_insert(root, &path, &key, value_len);
+	/*
+	 * Passing a NULL trans handle is fine here, we have a dummy root eb
+	 * and the tree is a single node (level 0).
+	 */
+	btrfs_setup_item_for_insert(NULL, root, &path, &key, value_len);
 	fi = btrfs_item_ptr(leaf, slot, struct btrfs_file_extent_item);
 	btrfs_set_file_extent_generation(leaf, fi, 1);
 	btrfs_set_file_extent_type(leaf, fi, type);
@@ -64,7 +68,11 @@ static void insert_inode_item_key(struct btrfs_root *root)
 	key.type = BTRFS_INODE_ITEM_KEY;
 	key.offset = 0;
 
-	btrfs_setup_item_for_insert(root, &path, &key, value_len);
+	/*
+	 * Passing a NULL trans handle is fine here, we have a dummy root eb
+	 * and the tree is a single node (level 0).
+	 */
+	btrfs_setup_item_for_insert(NULL, root, &path, &key, value_len);
 }
 
 /*
diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index a00e7a0bc713d..ad0d934991741 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -504,9 +504,9 @@ static int overwrite_item(struct btrfs_trans_handle *trans,
 		found_size = btrfs_item_size(path->nodes[0],
 						path->slots[0]);
 		if (found_size > item_size)
-			btrfs_truncate_item(path, item_size, 1);
+			btrfs_truncate_item(trans, path, item_size, 1);
 		else if (found_size < item_size)
-			btrfs_extend_item(path, item_size - found_size);
+			btrfs_extend_item(trans, path, item_size - found_size);
 	} else if (ret) {
 		return ret;
 	}
@@ -574,7 +574,7 @@ static int overwrite_item(struct btrfs_trans_handle *trans,
 		}
 	}
 no_copy:
-	btrfs_mark_buffer_dirty(path->nodes[0]);
+	btrfs_mark_buffer_dirty(trans, path->nodes[0]);
 	btrfs_release_path(path);
 	return 0;
 }
@@ -3530,7 +3530,7 @@ static noinline int insert_dir_log_key(struct btrfs_trans_handle *trans,
 		last_offset = max(last_offset, curr_end);
 	}
 	btrfs_set_dir_log_end(path->nodes[0], item, last_offset);
-	btrfs_mark_buffer_dirty(path->nodes[0]);
+	btrfs_mark_buffer_dirty(trans, path->nodes[0]);
 	btrfs_release_path(path);
 	return 0;
 }
@@ -4488,7 +4488,7 @@ static noinline int copy_items(struct btrfs_trans_handle *trans,
 		dst_index++;
 	}
 
-	btrfs_mark_buffer_dirty(dst_path->nodes[0]);
+	btrfs_mark_buffer_dirty(trans, dst_path->nodes[0]);
 	btrfs_release_path(dst_path);
 out:
 	kfree(ins_data);
@@ -4693,7 +4693,7 @@ static int log_one_extent(struct btrfs_trans_handle *trans,
 	write_extent_buffer(leaf, &fi,
 			    btrfs_item_ptr_offset(leaf, path->slots[0]),
 			    sizeof(fi));
-	btrfs_mark_buffer_dirty(leaf);
+	btrfs_mark_buffer_dirty(trans, leaf);
 
 	btrfs_release_path(path);
 
diff --git a/fs/btrfs/uuid-tree.c b/fs/btrfs/uuid-tree.c
index 7c7001f42b14c..5be74f9e47ebf 100644
--- a/fs/btrfs/uuid-tree.c
+++ b/fs/btrfs/uuid-tree.c
@@ -124,7 +124,7 @@ int btrfs_uuid_tree_add(struct btrfs_trans_handle *trans, u8 *uuid, u8 type,
 		 * An item with that type already exists.
 		 * Extend the item and store the new subid at the end.
 		 */
-		btrfs_extend_item(path, sizeof(subid_le));
+		btrfs_extend_item(trans, path, sizeof(subid_le));
 		eb = path->nodes[0];
 		slot = path->slots[0];
 		offset = btrfs_item_ptr_offset(eb, slot);
@@ -139,7 +139,7 @@ int btrfs_uuid_tree_add(struct btrfs_trans_handle *trans, u8 *uuid, u8 type,
 	ret = 0;
 	subid_le = cpu_to_le64(subid_cpu);
 	write_extent_buffer(eb, &subid_le, offset, sizeof(subid_le));
-	btrfs_mark_buffer_dirty(eb);
+	btrfs_mark_buffer_dirty(trans, eb);
 
 out:
 	btrfs_free_path(path);
@@ -221,7 +221,7 @@ int btrfs_uuid_tree_remove(struct btrfs_trans_handle *trans, u8 *uuid, u8 type,
 	move_src = offset + sizeof(subid);
 	move_len = item_size - (move_src - btrfs_item_ptr_offset(eb, slot));
 	memmove_extent_buffer(eb, move_dst, move_src, move_len);
-	btrfs_truncate_item(path, item_size - sizeof(subid), 1);
+	btrfs_truncate_item(trans, path, item_size - sizeof(subid), 1);
 
 out:
 	btrfs_free_path(path);
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 5019e9244d2d2..1df496c809376 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -1908,7 +1908,7 @@ static int btrfs_add_dev_item(struct btrfs_trans_handle *trans,
 	ptr = btrfs_device_fsid(dev_item);
 	write_extent_buffer(leaf, trans->fs_info->fs_devices->metadata_uuid,
 			    ptr, BTRFS_FSID_SIZE);
-	btrfs_mark_buffer_dirty(leaf);
+	btrfs_mark_buffer_dirty(trans, leaf);
 
 	ret = 0;
 out:
@@ -2613,7 +2613,7 @@ static int btrfs_finish_sprout(struct btrfs_trans_handle *trans)
 		if (device->fs_devices->seeding) {
 			btrfs_set_device_generation(leaf, dev_item,
 						    device->generation);
-			btrfs_mark_buffer_dirty(leaf);
+			btrfs_mark_buffer_dirty(trans, leaf);
 		}
 
 		path->slots[0]++;
@@ -2911,7 +2911,7 @@ static noinline int btrfs_update_device(struct btrfs_trans_handle *trans,
 				     btrfs_device_get_disk_total_bytes(device));
 	btrfs_set_device_bytes_used(leaf, dev_item,
 				    btrfs_device_get_bytes_used(device));
-	btrfs_mark_buffer_dirty(leaf);
+	btrfs_mark_buffer_dirty(trans, leaf);
 
 out:
 	btrfs_free_path(path);
@@ -3499,7 +3499,7 @@ static int insert_balance_item(struct btrfs_fs_info *fs_info,
 
 	btrfs_set_balance_flags(leaf, item, bctl->flags);
 
-	btrfs_mark_buffer_dirty(leaf);
+	btrfs_mark_buffer_dirty(trans, leaf);
 out:
 	btrfs_free_path(path);
 	err = btrfs_commit_transaction(trans);
@@ -7513,7 +7513,7 @@ static int update_dev_stat_item(struct btrfs_trans_handle *trans,
 	for (i = 0; i < BTRFS_DEV_STAT_VALUES_MAX; i++)
 		btrfs_set_dev_stats_value(eb, ptr, i,
 					  btrfs_dev_stat_read(device, i));
-	btrfs_mark_buffer_dirty(eb);
+	btrfs_mark_buffer_dirty(trans, eb);
 
 out:
 	btrfs_free_path(path);
diff --git a/fs/btrfs/xattr.c b/fs/btrfs/xattr.c
index fc4b20c2688a0..c454b8ce6babe 100644
--- a/fs/btrfs/xattr.c
+++ b/fs/btrfs/xattr.c
@@ -188,15 +188,15 @@ int btrfs_setxattr(struct btrfs_trans_handle *trans, struct inode *inode,
 		if (old_data_len + name_len + sizeof(*di) == item_size) {
 			/* No other xattrs packed in the same leaf item. */
 			if (size > old_data_len)
-				btrfs_extend_item(path, size - old_data_len);
+				btrfs_extend_item(trans, path, size - old_data_len);
 			else if (size < old_data_len)
-				btrfs_truncate_item(path, data_size, 1);
+				btrfs_truncate_item(trans, path, data_size, 1);
 		} else {
 			/* There are other xattrs packed in the same item. */
 			ret = btrfs_delete_one_dir_name(trans, root, path, di);
 			if (ret)
 				goto out;
-			btrfs_extend_item(path, data_size);
+			btrfs_extend_item(trans, path, data_size);
 		}
 
 		ptr = btrfs_item_ptr(leaf, slot, char);
@@ -205,7 +205,7 @@ int btrfs_setxattr(struct btrfs_trans_handle *trans, struct inode *inode,
 		btrfs_set_dir_data_len(leaf, di, size);
 		data_ptr = ((unsigned long)(di + 1)) + name_len;
 		write_extent_buffer(leaf, value, data_ptr, size);
-		btrfs_mark_buffer_dirty(leaf);
+		btrfs_mark_buffer_dirty(trans, leaf);
 	} else {
 		/*
 		 * Insert, and we had space for the xattr, so path->slots[0] is
-- 
2.42.0

