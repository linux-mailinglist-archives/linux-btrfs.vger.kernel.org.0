Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C36E596D78
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Aug 2022 13:25:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234668AbiHQLXK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 17 Aug 2022 07:23:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233652AbiHQLXH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 17 Aug 2022 07:23:07 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C31F13A
        for <linux-btrfs@vger.kernel.org>; Wed, 17 Aug 2022 04:23:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 339FAB81D49
        for <linux-btrfs@vger.kernel.org>; Wed, 17 Aug 2022 11:23:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E7D9C433B5
        for <linux-btrfs@vger.kernel.org>; Wed, 17 Aug 2022 11:23:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660735382;
        bh=XAjRUc5ZNSsZzCrt6EIX3dg5fzXqfiHqjN3lYLoAecU=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=EOTvQZAvVyFdJ+aE+35p4HlPBVqXhTydHkbxC9tutWZwrPhlmjKRFxaO+rw9b4JRd
         xxOT6sm7r87T6dy1/4dlKoQSVgFGPKrAtHQD8Lpqiy8gaZKLx0NJQmKPXKO5pNrQ1P
         HwvXyU0HQoXTnflFCrrZdDLcmJk8CPhD/isHnt/ip/Zr64M5heZCzhpJn8xc3NOP1d
         1ft6mX5jW3iB2TLMvnD7uHDOwbD55ATYefi1BYA8BMRdeTJiVmph4mdMmap0JMzNrB
         SoAkht3Ftnz0+k05p8ncPVG9lXJ9FjcPgjQ3L3vX20p5iFFlglfMxv7v9Fs0ruYLYO
         3iCnH1a6b9GyQ==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 09/15] btrfs: shrink the size of struct btrfs_delayed_item
Date:   Wed, 17 Aug 2022 12:22:42 +0100
Message-Id: <bd1d34e39a5fe9d226da167f8b970527f980846d.1660735025.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1660735024.git.fdmanana@suse.com>
References: <cover.1660735024.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

Currently struct btrfs_delayed_item has a base size of 96 bytes, but its
size can be decreased by doing the following 2 tweaks:

1) Change data_len from u32 to u16. Our maximum possible leaf size is 64K,
   so the data_len can never be larger than that, and in fact it is always
   much smaller than that. The max length for a dentry's name is ensured
   at the VFS level (PATH_MAX, 4096 bytes) and in struct btrfs_inode_ref
   and btrfs_dir_item we use a u16 to store the name's length;

2) Change 'ins_or_del' to a 1 bit enum, which is all we need since it
   can only have 2 values. After this there's also no longer the need to
   BUG_ON() before using 'ins_or_del' in several places. Also rename the
   field from 'ins_or_del' to 'type', which is more clear.

These two tweaks decrease the size of struct btrfs_delayed_item from 96
bytes down to 88 bytes. A previous patch already reduced the size of this
structure by 16 bytes, but an upcoming change will increase its size by
16 bytes (adding a struct list_head element).

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/delayed-inode.c | 37 ++++++++++++++++++-------------------
 fs/btrfs/delayed-inode.h | 12 +++++++-----
 2 files changed, 25 insertions(+), 24 deletions(-)

diff --git a/fs/btrfs/delayed-inode.c b/fs/btrfs/delayed-inode.c
index a8947ac00681..b35eddcac846 100644
--- a/fs/btrfs/delayed-inode.c
+++ b/fs/btrfs/delayed-inode.c
@@ -302,14 +302,16 @@ static inline void btrfs_release_prepared_delayed_node(
 	__btrfs_release_delayed_node(node, 1);
 }
 
-static struct btrfs_delayed_item *btrfs_alloc_delayed_item(u32 data_len,
-					   struct btrfs_delayed_node *node)
+static struct btrfs_delayed_item *btrfs_alloc_delayed_item(u16 data_len,
+					   struct btrfs_delayed_node *node,
+					   enum btrfs_delayed_item_type type)
 {
 	struct btrfs_delayed_item *item;
+
 	item = kmalloc(sizeof(*item) + data_len, GFP_NOFS);
 	if (item) {
 		item->data_len = data_len;
-		item->ins_or_del = 0;
+		item->type = type;
 		item->bytes_reserved = 0;
 		item->delayed_node = node;
 		RB_CLEAR_NODE(&item->rb_node);
@@ -356,12 +358,11 @@ static int __btrfs_add_delayed_item(struct btrfs_delayed_node *delayed_node,
 	struct btrfs_delayed_item *item;
 	bool leftmost = true;
 
-	if (ins->ins_or_del == BTRFS_DELAYED_INSERTION_ITEM)
+	if (ins->type == BTRFS_DELAYED_INSERTION_ITEM)
 		root = &delayed_node->ins_root;
-	else if (ins->ins_or_del == BTRFS_DELAYED_DELETION_ITEM)
-		root = &delayed_node->del_root;
 	else
-		BUG();
+		root = &delayed_node->del_root;
+
 	p = &root->rb_root.rb_node;
 	node = &ins->rb_node;
 
@@ -383,7 +384,7 @@ static int __btrfs_add_delayed_item(struct btrfs_delayed_node *delayed_node,
 	rb_link_node(node, parent_node, p);
 	rb_insert_color_cached(node, root, leftmost);
 
-	if (ins->ins_or_del == BTRFS_DELAYED_INSERTION_ITEM &&
+	if (ins->type == BTRFS_DELAYED_INSERTION_ITEM &&
 	    ins->index >= delayed_node->index_cnt)
 		delayed_node->index_cnt = ins->index + 1;
 
@@ -414,10 +415,8 @@ static void __btrfs_remove_delayed_item(struct btrfs_delayed_item *delayed_item)
 	delayed_root = delayed_item->delayed_node->root->fs_info->delayed_root;
 
 	BUG_ON(!delayed_root);
-	BUG_ON(delayed_item->ins_or_del != BTRFS_DELAYED_DELETION_ITEM &&
-	       delayed_item->ins_or_del != BTRFS_DELAYED_INSERTION_ITEM);
 
-	if (delayed_item->ins_or_del == BTRFS_DELAYED_INSERTION_ITEM)
+	if (delayed_item->type == BTRFS_DELAYED_INSERTION_ITEM)
 		root = &delayed_item->delayed_node->ins_root;
 	else
 		root = &delayed_item->delayed_node->del_root;
@@ -509,7 +508,7 @@ static int btrfs_delayed_item_reserve_metadata(struct btrfs_trans_handle *trans,
 		 * for the number of leaves that will be used, based on the delayed
 		 * node's index_items_size field.
 		 */
-		if (item->ins_or_del == BTRFS_DELAYED_DELETION_ITEM)
+		if (item->type == BTRFS_DELAYED_DELETION_ITEM)
 			item->bytes_reserved = num_bytes;
 	}
 
@@ -646,6 +645,7 @@ static int btrfs_insert_delayed_item(struct btrfs_trans_handle *trans,
 	const int max_size = BTRFS_LEAF_DATA_SIZE(fs_info);
 	struct btrfs_item_batch batch;
 	struct btrfs_key first_key;
+	const u32 first_data_size = first_item->data_len;
 	int total_size;
 	char *ins_data = NULL;
 	int ret;
@@ -674,9 +674,9 @@ static int btrfs_insert_delayed_item(struct btrfs_trans_handle *trans,
 	ASSERT(first_item->bytes_reserved == 0);
 
 	list_add_tail(&first_item->tree_list, &item_list);
-	batch.total_data_size = first_item->data_len;
+	batch.total_data_size = first_data_size;
 	batch.nr = 1;
-	total_size = first_item->data_len + sizeof(struct btrfs_item);
+	total_size = first_data_size + sizeof(struct btrfs_item);
 	curr = first_item;
 
 	while (true) {
@@ -711,7 +711,7 @@ static int btrfs_insert_delayed_item(struct btrfs_trans_handle *trans,
 		first_key.type = BTRFS_DIR_INDEX_KEY;
 		first_key.offset = first_item->index;
 		batch.keys = &first_key;
-		batch.data_sizes = &first_item->data_len;
+		batch.data_sizes = &first_data_size;
 	} else {
 		struct btrfs_key *ins_keys;
 		u32 *ins_sizes;
@@ -1427,14 +1427,14 @@ int btrfs_insert_delayed_dir_index(struct btrfs_trans_handle *trans,
 		return PTR_ERR(delayed_node);
 
 	delayed_item = btrfs_alloc_delayed_item(sizeof(*dir_item) + name_len,
-						delayed_node);
+						delayed_node,
+						BTRFS_DELAYED_INSERTION_ITEM);
 	if (!delayed_item) {
 		ret = -ENOMEM;
 		goto release_node;
 	}
 
 	delayed_item->index = index;
-	delayed_item->ins_or_del = BTRFS_DELAYED_INSERTION_ITEM;
 
 	dir_item = (struct btrfs_dir_item *)delayed_item->data;
 	dir_item->location = *disk_key;
@@ -1566,14 +1566,13 @@ int btrfs_delete_delayed_dir_index(struct btrfs_trans_handle *trans,
 	if (!ret)
 		goto end;
 
-	item = btrfs_alloc_delayed_item(0, node);
+	item = btrfs_alloc_delayed_item(0, node, BTRFS_DELAYED_DELETION_ITEM);
 	if (!item) {
 		ret = -ENOMEM;
 		goto end;
 	}
 
 	item->index = index;
-	item->ins_or_del = BTRFS_DELAYED_DELETION_ITEM;
 
 	ret = btrfs_delayed_item_reserve_metadata(trans, item);
 	/*
diff --git a/fs/btrfs/delayed-inode.h b/fs/btrfs/delayed-inode.h
index fd6fe785f748..729d352ca8a1 100644
--- a/fs/btrfs/delayed-inode.h
+++ b/fs/btrfs/delayed-inode.h
@@ -16,9 +16,10 @@
 #include <linux/refcount.h>
 #include "ctree.h"
 
-/* types of the delayed item */
-#define BTRFS_DELAYED_INSERTION_ITEM	1
-#define BTRFS_DELAYED_DELETION_ITEM	2
+enum btrfs_delayed_item_type {
+	BTRFS_DELAYED_INSERTION_ITEM,
+	BTRFS_DELAYED_DELETION_ITEM
+};
 
 struct btrfs_delayed_root {
 	spinlock_t lock;
@@ -80,8 +81,9 @@ struct btrfs_delayed_item {
 	u64 bytes_reserved;
 	struct btrfs_delayed_node *delayed_node;
 	refcount_t refs;
-	int ins_or_del;
-	u32 data_len;
+	enum btrfs_delayed_item_type type:1;
+	/* The maximum leaf size is 64K, so u16 is more than enough. */
+	u16 data_len;
 	char data[];
 };
 
-- 
2.35.1

