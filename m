Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 641801C4AD1
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 May 2020 02:02:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728351AbgEEACl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 4 May 2020 20:02:41 -0400
Received: from mx2.suse.de ([195.135.220.15]:38734 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728223AbgEEACl (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 4 May 2020 20:02:41 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 7A475AF0B
        for <linux-btrfs@vger.kernel.org>; Tue,  5 May 2020 00:02:41 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v4 03/11] btrfs-progs: Rename btrfs_remove_block_group() and free_block_group_item()
Date:   Tue,  5 May 2020 08:02:22 +0800
Message-Id: <20200505000230.4454-4-wqu@suse.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200505000230.4454-1-wqu@suse.com>
References: <20200505000230.4454-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

To sync with the refactored kernel code.

Also since we're here, sync the function parameters with kernel too.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 ctree.h       |  4 +--
 extent-tree.c | 80 +++++++++++++++++----------------------------------
 mkfs/main.c   |  2 +-
 3 files changed, 30 insertions(+), 56 deletions(-)

diff --git a/ctree.h b/ctree.h
index 0256b0e6bc3d..7c7c992cd885 100644
--- a/ctree.h
+++ b/ctree.h
@@ -2597,8 +2597,8 @@ int btrfs_record_file_extent(struct btrfs_trans_handle *trans,
 			      struct btrfs_inode_item *inode,
 			      u64 file_pos, u64 disk_bytenr,
 			      u64 num_bytes);
-int btrfs_free_block_group(struct btrfs_trans_handle *trans,
-			   struct btrfs_fs_info *fs_info, u64 bytenr, u64 len);
+int btrfs_remove_block_group(struct btrfs_trans_handle *trans,
+			     u64 bytenr, u64 len);
 void free_excluded_extents(struct btrfs_fs_info *fs_info,
 			   struct btrfs_block_group *cache);
 int exclude_super_stripes(struct btrfs_fs_info *fs_info,
diff --git a/extent-tree.c b/extent-tree.c
index 5fc4308336dd..3de95052a645 100644
--- a/extent-tree.c
+++ b/extent-tree.c
@@ -2907,35 +2907,26 @@ int btrfs_update_block_group(struct btrfs_trans_handle *trans,
  * Caller should ensure the block group is empty and all space is pinned.
  * Or new tree block/data may be allocated into it.
  */
-static int free_block_group_item(struct btrfs_trans_handle *trans,
-				 struct btrfs_fs_info *fs_info,
-				 u64 bytenr, u64 len)
+static int remove_block_group_item(struct btrfs_trans_handle *trans,
+				   struct btrfs_path *path,
+				   struct btrfs_block_group *block_group)
 {
-	struct btrfs_path *path;
-	struct btrfs_key key;
+	struct btrfs_fs_info *fs_info = trans->fs_info;
 	struct btrfs_root *root = fs_info->extent_root;
+	struct btrfs_key key;
 	int ret = 0;
 
-	key.objectid = bytenr;
-	key.offset = len;
+	key.objectid = block_group->start;
+	key.offset = block_group->length;
 	key.type = BTRFS_BLOCK_GROUP_ITEM_KEY;
 
-	path = btrfs_alloc_path();
-	if (!path)
-		return -ENOMEM;
-
 	ret = btrfs_search_slot(trans, root, &key, path, -1, 1);
-	if (ret > 0) {
+	if (ret > 0)
 		ret = -ENOENT;
-		goto out;
-	}
 	if (ret < 0)
-		goto out;
+		return ret;
 
-	ret = btrfs_del_item(trans, root, path);
-out:
-	btrfs_free_path(path);
-	return ret;
+	return btrfs_del_item(trans, root, path);
 }
 
 static int free_dev_extent_item(struct btrfs_trans_handle *trans,
@@ -3176,42 +3167,25 @@ out:
 	return ret;
 }
 
-int btrfs_free_block_group(struct btrfs_trans_handle *trans,
-			   struct btrfs_fs_info *fs_info, u64 bytenr, u64 len)
+int btrfs_remove_block_group(struct btrfs_trans_handle *trans,
+			     u64 bytenr, u64 len)
 {
-	struct btrfs_root *extent_root = fs_info->extent_root;
-	struct btrfs_path *path;
-	struct btrfs_block_group_item *bgi;
-	struct btrfs_key key;
+	struct btrfs_fs_info *fs_info = trans->fs_info;
+	struct btrfs_block_group *block_group;
+	struct btrfs_path path;
 	int ret = 0;
 
-	path = btrfs_alloc_path();
-	if (!path)
-		return -ENOMEM;
-
-	key.objectid = bytenr;
-	key.type = BTRFS_BLOCK_GROUP_ITEM_KEY;
-	key.offset = len;
-
+	block_group = btrfs_lookup_block_group(fs_info, bytenr);
+	if (!block_group || block_group->start != bytenr ||
+	    block_group->length != len)
+		return -ENOENT;
 	/* Double check the block group to ensure it's empty */
-	ret = btrfs_search_slot(trans, extent_root, &key, path, 0, 0);
-	if (ret > 0) {
-		ret = -ENONET;
-		goto out;
-	}
-	if (ret < 0)
-		goto out;
-
-	bgi = btrfs_item_ptr(path->nodes[0], path->slots[0],
-			     struct btrfs_block_group_item);
-	if (btrfs_block_group_used(path->nodes[0], bgi)) {
+	if (block_group->used) {
 		fprintf(stderr,
 			"WARNING: block group [%llu,%llu) is not empty\n",
 			bytenr, bytenr + len);
-		ret = -EINVAL;
-		goto out;
+		return -EUCLEAN;
 	}
-	btrfs_release_path(path);
 
 	/*
 	 * Now pin all space in the block group, to prevent further transaction
@@ -3220,14 +3194,16 @@ int btrfs_free_block_group(struct btrfs_trans_handle *trans,
 	 */
 	btrfs_pin_extent(fs_info, bytenr, len);
 
+	btrfs_init_path(&path);
 	/* delete block group item and chunk item */
-	ret = free_block_group_item(trans, fs_info, bytenr, len);
+	ret = remove_block_group_item(trans, &path, block_group);
+	btrfs_release_path(&path);
 	if (ret < 0) {
 		fprintf(stderr,
 			"failed to free block group item for [%llu,%llu)\n",
 			bytenr, bytenr + len);
 		btrfs_unpin_extent(fs_info, bytenr, len);
-		goto out;
+		return ret;
 	}
 
 	ret = free_chunk_dev_extent_items(trans, fs_info, bytenr);
@@ -3236,7 +3212,7 @@ int btrfs_free_block_group(struct btrfs_trans_handle *trans,
 			"failed to dev extents belongs to [%llu,%llu)\n",
 			bytenr, bytenr + len);
 		btrfs_unpin_extent(fs_info, bytenr, len);
-		goto out;
+		return ret;
 	}
 	ret = free_chunk_item(trans, fs_info, bytenr);
 	if (ret < 0) {
@@ -3244,15 +3220,13 @@ int btrfs_free_block_group(struct btrfs_trans_handle *trans,
 			"failed to free chunk for [%llu,%llu)\n",
 			bytenr, bytenr + len);
 		btrfs_unpin_extent(fs_info, bytenr, len);
-		goto out;
+		return ret;
 	}
 
 	/* Now release the block_group_cache */
 	ret = free_block_group_cache(trans, fs_info, bytenr, len);
 	btrfs_unpin_extent(fs_info, bytenr, len);
 
-out:
-	btrfs_free_path(path);
 	return ret;
 }
 
diff --git a/mkfs/main.c b/mkfs/main.c
index 89f3877fa3b2..2c28d0b159a6 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -644,7 +644,7 @@ static int cleanup_temp_chunks(struct btrfs_fs_info *fs_info,
 					sys_profile)) {
 			u64 flags = btrfs_block_group_flags(path.nodes[0], bgi);
 
-			ret = btrfs_free_block_group(trans, fs_info,
+			ret = btrfs_remove_block_group(trans,
 					found_key.objectid, found_key.offset);
 			if (ret < 0)
 				goto out;
-- 
2.26.2

