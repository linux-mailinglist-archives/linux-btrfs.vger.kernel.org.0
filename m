Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EFDC2D7A0F
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Oct 2019 17:43:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731093AbfJOPmy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 15 Oct 2019 11:42:54 -0400
Received: from mx2.suse.de ([195.135.220.15]:44486 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731230AbfJOPmy (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Oct 2019 11:42:54 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 41AC6B4C5;
        Tue, 15 Oct 2019 15:42:52 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 1/2] btrfs-progs: corrupt-block: Refactor tree block corruption code
Date:   Tue, 15 Oct 2019 18:42:48 +0300
Message-Id: <20191015154249.21615-2-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191015154249.21615-1-nborisov@suse.com>
References: <20191015154249.21615-1-nborisov@suse.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

As progs' transaction/CoW logic evolved over the years the metadata block
corruption code failed to do so. It's currently impossible to corrupt
the generation because the CoW logic will not only set it to the value
of the currently running transaction (__btrfs_cow_block) but the
current code will ASSERT due to the following check in __btrfs_cow_block:

   WARN_ON(!(buf->flags & EXTENT_BAD_TRANSID) &&
                   btrfs_header_generation(buf) > trans->transid);

Fix this by making the generation corruption code directly write
the modified block, outside of the transaction mechanism. At the same
time move the old code into BTRFS_METADATA_BLOCK_SHIFT_ITEMS handling
case, essentially leaving it unchanged.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 btrfs-corrupt-block.c | 108 ++++++++++++++++++++++++++------------------------
 1 file changed, 57 insertions(+), 51 deletions(-)

diff --git a/btrfs-corrupt-block.c b/btrfs-corrupt-block.c
index 716439a5ea7c..dc5b81ffca3a 100644
--- a/btrfs-corrupt-block.c
+++ b/btrfs-corrupt-block.c
@@ -746,15 +746,8 @@ static void shift_items(struct btrfs_root *root, struct extent_buffer *eb)
 static int corrupt_metadata_block(struct btrfs_fs_info *fs_info, u64 block,
 				  char *field)
 {
-	struct btrfs_trans_handle *trans;
-	struct btrfs_root *root;
-	struct btrfs_path *path;
 	struct extent_buffer *eb;
-	struct btrfs_key key, root_key;
 	enum btrfs_metadata_block_field corrupt_field;
-	u64 root_objectid;
-	u64 orig, bogus;
-	u8 level;
 	int ret;
 
 	corrupt_field = convert_metadata_block_field(field);
@@ -768,63 +761,76 @@ static int corrupt_metadata_block(struct btrfs_fs_info *fs_info, u64 block,
 		fprintf(stderr, "Couldn't read in tree block %s\n", field);
 		return -EINVAL;
 	}
-	root_objectid = btrfs_header_owner(eb);
-	level = btrfs_header_level(eb);
-	if (level)
-		btrfs_node_key_to_cpu(eb, &key, 0);
-	else
-		btrfs_item_key_to_cpu(eb, &key, 0);
-	free_extent_buffer(eb);
-
-	root_key.objectid = root_objectid;
-	root_key.type = BTRFS_ROOT_ITEM_KEY;
-	root_key.offset = (u64)-1;
-
-	root = btrfs_read_fs_root(fs_info, &root_key);
-	if (IS_ERR(root)) {
-		fprintf(stderr, "Couldn't find owner root %llu\n",
-			key.objectid);
-		return PTR_ERR(root);
-	}
-
-	path = btrfs_alloc_path();
-	if (!path)
-		return -ENOMEM;
-
-	trans = btrfs_start_transaction(root, 1);
-	if (IS_ERR(trans)) {
-		btrfs_free_path(path);
-		fprintf(stderr, "Couldn't start transaction %ld\n",
-			PTR_ERR(trans));
-		return PTR_ERR(trans);
-	}
-
-	path->lowest_level = level;
-	ret = btrfs_search_slot(trans, root, &key, path, 0, 1);
-	if (ret < 0) {
-		fprintf(stderr, "Error searching to node %d\n", ret);
-		goto out;
-	}
-	eb = path->nodes[level];
 
 	ret = 0;
 	switch (corrupt_field) {
 	case BTRFS_METADATA_BLOCK_GENERATION:
-		orig = btrfs_header_generation(eb);
-		bogus = generate_u64(orig);
+		{
+		u64 orig = btrfs_header_generation(eb);
+		u64 bogus = generate_u64(orig);
 		btrfs_set_header_generation(eb, bogus);
+		write_and_map_eb(fs_info, eb);
+		free_extent_buffer(eb);
 		break;
+		}
 	case BTRFS_METADATA_BLOCK_SHIFT_ITEMS:
+		{
+		struct btrfs_trans_handle *trans;
+		struct btrfs_root *root;
+		struct btrfs_path *path;
+		struct btrfs_key key, root_key;
+		u64 root_objectid;
+		u8 level;
+		root_objectid = btrfs_header_owner(eb);
+		level = btrfs_header_level(eb);
+		if (level)
+			btrfs_node_key_to_cpu(eb, &key, 0);
+		else
+			btrfs_item_key_to_cpu(eb, &key, 0);
+		free_extent_buffer(eb);
+
+		root_key.objectid = root_objectid;
+		root_key.type = BTRFS_ROOT_ITEM_KEY;
+		root_key.offset = (u64)-1;
+
+		root = btrfs_read_fs_root(fs_info, &root_key);
+		if (IS_ERR(root)) {
+			fprintf(stderr, "Couldn't find owner root %llu\n",
+				key.objectid);
+			return PTR_ERR(root);
+		}
+
+		path = btrfs_alloc_path();
+		if (!path)
+			return -ENOMEM;
+
+		trans = btrfs_start_transaction(root, 1);
+		if (IS_ERR(trans)) {
+			btrfs_free_path(path);
+			fprintf(stderr, "Couldn't start transaction %ld\n",
+				PTR_ERR(trans));
+			return PTR_ERR(trans);
+		}
+
+		path->lowest_level = level;
+		ret = btrfs_search_slot(trans, root, &key, path, 0, 1);
+		if (ret < 0) {
+			fprintf(stderr, "Error searching to node %d\n", ret);
+			btrfs_free_path(path);
+			btrfs_abort_transaction(trans, ret);
+			return ret;
+		}
+		eb = path->nodes[level];
 		shift_items(root, path->nodes[level]);
+		btrfs_mark_buffer_dirty(path->nodes[level]);
+		btrfs_commit_transaction(trans, root);
 		break;
+		}
 	default:
 		ret = -EINVAL;
 		break;
 	}
-	btrfs_mark_buffer_dirty(path->nodes[level]);
-out:
-	btrfs_commit_transaction(trans, root);
-	btrfs_free_path(path);
+
 	return ret;
 }
 
-- 
2.7.4

