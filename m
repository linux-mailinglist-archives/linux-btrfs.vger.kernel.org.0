Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54C1A59BDDC
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Aug 2022 12:53:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233747AbiHVKwC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 22 Aug 2022 06:52:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233778AbiHVKv6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 22 Aug 2022 06:51:58 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3737A2F671
        for <linux-btrfs@vger.kernel.org>; Mon, 22 Aug 2022 03:51:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D500FB81015
        for <linux-btrfs@vger.kernel.org>; Mon, 22 Aug 2022 10:51:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C202C433D6
        for <linux-btrfs@vger.kernel.org>; Mon, 22 Aug 2022 10:51:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661165514;
        bh=jaLcy/FHpbfW0y3+KV5OJn6l5mbHgWi88hJPW1MMJso=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=XnZJ5HtYsaTqkkG1GtPJbmik/zIE+ikxKfD0m96bsh8RXXLrsj6V5TfM0GbNittu+
         H5gJpB/HmT0+GUvTqbczQ3/2K9BSnK+jEIOOZV0/XVsWWZyv13otXrYtMD7yOhshwl
         B2u6fbP175TW/pVREHIG4+/cjj6PpdCBnLSxydZW4O4c0W8piQBR4VO9S0PO7d4rMB
         QPNiGuW654Y4+lzlB0+EyMndKpNb2JabIe7afsGeXlF9ngn8SaYziw+xsD0mAc+uOW
         CxERmyPaBvZUYpbUSyQEDU87RmAu3ylP2u2/6LLCMyxN/WfZT99tJpkHNmjXXp9qTr
         jykQs3ggXMggw==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 07/15] btrfs: store index number instead of key in struct btrfs_delayed_item
Date:   Mon, 22 Aug 2022 11:51:36 +0100
Message-Id: <e2aace291bf5653451ce792ff17e83c8df9c85a0.1661165149.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1661165149.git.fdmanana@suse.com>
References: <cover.1661165149.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

All delayed items are for dir index keys, so there's really no point of
having an embedded struct btrfs_key in struct btrfs_delayed_item, which
makes the structure use more space than necessary (and adds a hole of 7
bytes).

So replace the key field with an index number (u64), which reduces the
size of struct btrfs_delayed_item from 112 bytes down to 96 bytes.

Some upcoming work will increase the structure size by 16 bytes, so this
change compensates for that future size increase.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/delayed-inode.c | 106 ++++++++++++++++++++-------------------
 fs/btrfs/delayed-inode.h |   3 +-
 2 files changed, 56 insertions(+), 53 deletions(-)

diff --git a/fs/btrfs/delayed-inode.c b/fs/btrfs/delayed-inode.c
index a080e08bbb4d..cd2f3a8c4dfd 100644
--- a/fs/btrfs/delayed-inode.c
+++ b/fs/btrfs/delayed-inode.c
@@ -302,7 +302,8 @@ static inline void btrfs_release_prepared_delayed_node(
 	__btrfs_release_delayed_node(node, 1);
 }
 
-static struct btrfs_delayed_item *btrfs_alloc_delayed_item(u32 data_len)
+static struct btrfs_delayed_item *btrfs_alloc_delayed_item(u32 data_len,
+					   struct btrfs_delayed_node *node)
 {
 	struct btrfs_delayed_item *item;
 	item = kmalloc(sizeof(*item) + data_len, GFP_NOFS);
@@ -310,7 +311,8 @@ static struct btrfs_delayed_item *btrfs_alloc_delayed_item(u32 data_len)
 		item->data_len = data_len;
 		item->ins_or_del = 0;
 		item->bytes_reserved = 0;
-		item->delayed_node = NULL;
+		item->delayed_node = node;
+		RB_CLEAR_NODE(&item->rb_node);
 		refcount_set(&item->refs, 1);
 	}
 	return item;
@@ -319,7 +321,7 @@ static struct btrfs_delayed_item *btrfs_alloc_delayed_item(u32 data_len)
 /*
  * __btrfs_lookup_delayed_item - look up the delayed item by key
  * @delayed_node: pointer to the delayed node
- * @key:	  the key to look up
+ * @index:	  the dir index value to lookup (offset of a dir index key)
  * @prev:	  used to store the prev item if the right item isn't found
  * @next:	  used to store the next item if the right item isn't found
  *
@@ -328,7 +330,7 @@ static struct btrfs_delayed_item *btrfs_alloc_delayed_item(u32 data_len)
  */
 static struct btrfs_delayed_item *__btrfs_lookup_delayed_item(
 				struct rb_root *root,
-				struct btrfs_key *key,
+				u64 index,
 				struct btrfs_delayed_item **prev,
 				struct btrfs_delayed_item **next)
 {
@@ -342,10 +344,9 @@ static struct btrfs_delayed_item *__btrfs_lookup_delayed_item(
 		delayed_item = rb_entry(node, struct btrfs_delayed_item,
 					rb_node);
 		prev_node = node;
-		ret = btrfs_comp_cpu_keys(&delayed_item->key, key);
-		if (ret < 0)
+		if (delayed_item->index < index)
 			node = node->rb_right;
-		else if (ret > 0)
+		else if (delayed_item->index > index)
 			node = node->rb_left;
 		else
 			return delayed_item;
@@ -379,9 +380,9 @@ static struct btrfs_delayed_item *__btrfs_lookup_delayed_item(
 
 static struct btrfs_delayed_item *__btrfs_lookup_delayed_insertion_item(
 					struct btrfs_delayed_node *delayed_node,
-					struct btrfs_key *key)
+					u64 index)
 {
-	return __btrfs_lookup_delayed_item(&delayed_node->ins_root.rb_root, key,
+	return __btrfs_lookup_delayed_item(&delayed_node->ins_root.rb_root, index,
 					   NULL, NULL);
 }
 
@@ -392,7 +393,6 @@ static int __btrfs_add_delayed_item(struct btrfs_delayed_node *delayed_node,
 	struct rb_node *parent_node = NULL;
 	struct rb_root_cached *root;
 	struct btrfs_delayed_item *item;
-	int cmp;
 	bool leftmost = true;
 
 	if (ins->ins_or_del == BTRFS_DELAYED_INSERTION_ITEM)
@@ -409,11 +409,10 @@ static int __btrfs_add_delayed_item(struct btrfs_delayed_node *delayed_node,
 		item = rb_entry(parent_node, struct btrfs_delayed_item,
 				 rb_node);
 
-		cmp = btrfs_comp_cpu_keys(&item->key, &ins->key);
-		if (cmp < 0) {
+		if (item->index < ins->index) {
 			p = &(*p)->rb_right;
 			leftmost = false;
-		} else if (cmp > 0) {
+		} else if (item->index > ins->index) {
 			p = &(*p)->rb_left;
 		} else {
 			return -EEXIST;
@@ -422,14 +421,10 @@ static int __btrfs_add_delayed_item(struct btrfs_delayed_node *delayed_node,
 
 	rb_link_node(node, parent_node, p);
 	rb_insert_color_cached(node, root, leftmost);
-	ins->delayed_node = delayed_node;
-
-	/* Delayed items are always for dir index items. */
-	ASSERT(ins->key.type == BTRFS_DIR_INDEX_KEY);
 
 	if (ins->ins_or_del == BTRFS_DELAYED_INSERTION_ITEM &&
-	    ins->key.offset >= delayed_node->index_cnt)
-		delayed_node->index_cnt = ins->key.offset + 1;
+	    ins->index >= delayed_node->index_cnt)
+		delayed_node->index_cnt = ins->index + 1;
 
 	delayed_node->count++;
 	atomic_inc(&delayed_node->root->fs_info->delayed_root->items);
@@ -451,9 +446,10 @@ static void __btrfs_remove_delayed_item(struct btrfs_delayed_item *delayed_item)
 	struct rb_root_cached *root;
 	struct btrfs_delayed_root *delayed_root;
 
-	/* Not associated with any delayed_node */
-	if (!delayed_item->delayed_node)
+	/* Not inserted, ignore it. */
+	if (RB_EMPTY_NODE(&delayed_item->rb_node))
 		return;
+
 	delayed_root = delayed_item->delayed_node->root->fs_info->delayed_root;
 
 	BUG_ON(!delayed_root);
@@ -466,6 +462,7 @@ static void __btrfs_remove_delayed_item(struct btrfs_delayed_item *delayed_item)
 		root = &delayed_item->delayed_node->del_root;
 
 	rb_erase_cached(&delayed_item->rb_node, root);
+	RB_CLEAR_NODE(&delayed_item->rb_node);
 	delayed_item->delayed_node->count--;
 
 	finish_one_item(delayed_root);
@@ -544,7 +541,7 @@ static int btrfs_delayed_item_reserve_metadata(struct btrfs_trans_handle *trans,
 	ret = btrfs_block_rsv_migrate(src_rsv, dst_rsv, num_bytes, true);
 	if (!ret) {
 		trace_btrfs_space_reservation(fs_info, "delayed_item",
-					      item->key.objectid,
+					      item->delayed_node->inode_id,
 					      num_bytes, 1);
 		/*
 		 * For insertions we track reserved metadata space by accounting
@@ -573,8 +570,8 @@ static void btrfs_delayed_item_release_metadata(struct btrfs_root *root,
 	 * to release/reserve qgroup space.
 	 */
 	trace_btrfs_space_reservation(fs_info, "delayed_item",
-				      item->key.objectid, item->bytes_reserved,
-				      0);
+				      item->delayed_node->inode_id,
+				      item->bytes_reserved, 0);
 	btrfs_block_rsv_release(fs_info, rsv, item->bytes_reserved, NULL);
 }
 
@@ -687,6 +684,7 @@ static int btrfs_insert_delayed_item(struct btrfs_trans_handle *trans,
 	struct btrfs_delayed_item *next;
 	const int max_size = BTRFS_LEAF_DATA_SIZE(fs_info);
 	struct btrfs_item_batch batch;
+	struct btrfs_key first_key;
 	int total_size;
 	char *ins_data = NULL;
 	int ret;
@@ -731,8 +729,7 @@ static int btrfs_insert_delayed_item(struct btrfs_trans_handle *trans,
 		 * We cannot allow gaps in the key space if we're doing log
 		 * replay.
 		 */
-		if (continuous_keys_only &&
-		    (next->key.offset != curr->key.offset + 1))
+		if (continuous_keys_only && (next->index != curr->index + 1))
 			break;
 
 		ASSERT(next->bytes_reserved == 0);
@@ -749,7 +746,10 @@ static int btrfs_insert_delayed_item(struct btrfs_trans_handle *trans,
 	}
 
 	if (batch.nr == 1) {
-		batch.keys = &first_item->key;
+		first_key.objectid = node->inode_id;
+		first_key.type = BTRFS_DIR_INDEX_KEY;
+		first_key.offset = first_item->index;
+		batch.keys = &first_key;
 		batch.data_sizes = &first_item->data_len;
 	} else {
 		struct btrfs_key *ins_keys;
@@ -767,7 +767,9 @@ static int btrfs_insert_delayed_item(struct btrfs_trans_handle *trans,
 		batch.keys = ins_keys;
 		batch.data_sizes = ins_sizes;
 		list_for_each_entry(curr, &item_list, tree_list) {
-			ins_keys[i] = curr->key;
+			ins_keys[i].objectid = node->inode_id;
+			ins_keys[i].type = BTRFS_DIR_INDEX_KEY;
+			ins_keys[i].offset = curr->index;
 			ins_sizes[i] = curr->data_len;
 			i++;
 		}
@@ -863,6 +865,7 @@ static int btrfs_batch_delete_items(struct btrfs_trans_handle *trans,
 				    struct btrfs_path *path,
 				    struct btrfs_delayed_item *item)
 {
+	const u64 ino = item->delayed_node->inode_id;
 	struct btrfs_fs_info *fs_info = root->fs_info;
 	struct btrfs_delayed_item *curr, *next;
 	struct extent_buffer *leaf = path->nodes[0];
@@ -901,7 +904,9 @@ static int btrfs_batch_delete_items(struct btrfs_trans_handle *trans,
 
 		slot++;
 		btrfs_item_key_to_cpu(leaf, &key, slot);
-		if (btrfs_comp_cpu_keys(&next->key, &key) != 0)
+		if (key.objectid != ino ||
+		    key.type != BTRFS_DIR_INDEX_KEY ||
+		    key.offset != next->index)
 			break;
 		nitems++;
 		curr = next;
@@ -919,9 +924,8 @@ static int btrfs_batch_delete_items(struct btrfs_trans_handle *trans,
 		 * Check btrfs_delayed_item_reserve_metadata() to see why we
 		 * don't need to release/reserve qgroup space.
 		 */
-		trace_btrfs_space_reservation(fs_info, "delayed_item",
-					      item->key.objectid, total_reserved_size,
-					      0);
+		trace_btrfs_space_reservation(fs_info, "delayed_item", ino,
+					      total_reserved_size, 0);
 		btrfs_block_rsv_release(fs_info, &fs_info->delayed_block_rsv,
 					total_reserved_size, NULL);
 	}
@@ -939,8 +943,12 @@ static int btrfs_delete_delayed_items(struct btrfs_trans_handle *trans,
 				      struct btrfs_root *root,
 				      struct btrfs_delayed_node *node)
 {
+	struct btrfs_key key;
 	int ret = 0;
 
+	key.objectid = node->inode_id;
+	key.type = BTRFS_DIR_INDEX_KEY;
+
 	while (ret == 0) {
 		struct btrfs_delayed_item *item;
 
@@ -951,7 +959,8 @@ static int btrfs_delete_delayed_items(struct btrfs_trans_handle *trans,
 			break;
 		}
 
-		ret = btrfs_search_slot(trans, root, &item->key, path, -1, 1);
+		key.offset = item->index;
+		ret = btrfs_search_slot(trans, root, &key, path, -1, 1);
 		if (ret > 0) {
 			/*
 			 * There's no matching item in the leaf. This means we
@@ -1456,15 +1465,14 @@ int btrfs_insert_delayed_dir_index(struct btrfs_trans_handle *trans,
 	if (IS_ERR(delayed_node))
 		return PTR_ERR(delayed_node);
 
-	delayed_item = btrfs_alloc_delayed_item(sizeof(*dir_item) + name_len);
+	delayed_item = btrfs_alloc_delayed_item(sizeof(*dir_item) + name_len,
+						delayed_node);
 	if (!delayed_item) {
 		ret = -ENOMEM;
 		goto release_node;
 	}
 
-	delayed_item->key.objectid = btrfs_ino(dir);
-	delayed_item->key.type = BTRFS_DIR_INDEX_KEY;
-	delayed_item->key.offset = index;
+	delayed_item->index = index;
 	delayed_item->ins_or_del = BTRFS_DELAYED_INSERTION_ITEM;
 
 	dir_item = (struct btrfs_dir_item *)delayed_item->data;
@@ -1536,12 +1544,12 @@ int btrfs_insert_delayed_dir_index(struct btrfs_trans_handle *trans,
 
 static int btrfs_delete_delayed_insertion_item(struct btrfs_fs_info *fs_info,
 					       struct btrfs_delayed_node *node,
-					       struct btrfs_key *key)
+					       u64 index)
 {
 	struct btrfs_delayed_item *item;
 
 	mutex_lock(&node->mutex);
-	item = __btrfs_lookup_delayed_insertion_item(node, key);
+	item = __btrfs_lookup_delayed_insertion_item(node, index);
 	if (!item) {
 		mutex_unlock(&node->mutex);
 		return 1;
@@ -1587,29 +1595,23 @@ int btrfs_delete_delayed_dir_index(struct btrfs_trans_handle *trans,
 {
 	struct btrfs_delayed_node *node;
 	struct btrfs_delayed_item *item;
-	struct btrfs_key item_key;
 	int ret;
 
 	node = btrfs_get_or_create_delayed_node(dir);
 	if (IS_ERR(node))
 		return PTR_ERR(node);
 
-	item_key.objectid = btrfs_ino(dir);
-	item_key.type = BTRFS_DIR_INDEX_KEY;
-	item_key.offset = index;
-
-	ret = btrfs_delete_delayed_insertion_item(trans->fs_info, node,
-						  &item_key);
+	ret = btrfs_delete_delayed_insertion_item(trans->fs_info, node, index);
 	if (!ret)
 		goto end;
 
-	item = btrfs_alloc_delayed_item(0);
+	item = btrfs_alloc_delayed_item(0, node);
 	if (!item) {
 		ret = -ENOMEM;
 		goto end;
 	}
 
-	item->key = item_key;
+	item->index = index;
 	item->ins_or_del = BTRFS_DELAYED_DELETION_ITEM;
 
 	ret = btrfs_delayed_item_reserve_metadata(trans, item);
@@ -1741,9 +1743,9 @@ int btrfs_should_delete_dir_index(struct list_head *del_list,
 	int ret = 0;
 
 	list_for_each_entry(curr, del_list, readdir_list) {
-		if (curr->key.offset > index)
+		if (curr->index > index)
 			break;
-		if (curr->key.offset == index) {
+		if (curr->index == index) {
 			ret = 1;
 			break;
 		}
@@ -1777,13 +1779,13 @@ int btrfs_readdir_delayed_dir_index(struct dir_context *ctx,
 	list_for_each_entry_safe(curr, next, ins_list, readdir_list) {
 		list_del(&curr->readdir_list);
 
-		if (curr->key.offset < ctx->pos) {
+		if (curr->index < ctx->pos) {
 			if (refcount_dec_and_test(&curr->refs))
 				kfree(curr);
 			continue;
 		}
 
-		ctx->pos = curr->key.offset;
+		ctx->pos = curr->index;
 
 		di = (struct btrfs_dir_item *)curr->data;
 		name = (char *)(di + 1);
diff --git a/fs/btrfs/delayed-inode.h b/fs/btrfs/delayed-inode.h
index 9795dc295a18..fd6fe785f748 100644
--- a/fs/btrfs/delayed-inode.h
+++ b/fs/btrfs/delayed-inode.h
@@ -73,7 +73,8 @@ struct btrfs_delayed_node {
 
 struct btrfs_delayed_item {
 	struct rb_node rb_node;
-	struct btrfs_key key;
+	/* Offset value of the corresponding dir index key. */
+	u64 index;
 	struct list_head tree_list;	/* used for batch insert/delete items */
 	struct list_head readdir_list;	/* used for readdir items */
 	u64 bytes_reserved;
-- 
2.35.1

