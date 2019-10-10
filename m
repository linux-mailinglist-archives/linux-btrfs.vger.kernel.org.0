Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6C51AD20E1
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Oct 2019 08:42:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732902AbfJJGmG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 10 Oct 2019 02:42:06 -0400
Received: from mx2.suse.de ([195.135.220.15]:42340 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732735AbfJJGmF (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 10 Oct 2019 02:42:05 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 3E025AC12
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Oct 2019 06:42:02 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v3 2/7] btrfs-progs: Refactor btrfs_read_block_groups()
Date:   Thu, 10 Oct 2019 14:41:51 +0800
Message-Id: <20191010064156.31782-3-wqu@suse.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191010064156.31782-1-wqu@suse.com>
References: <20191010064156.31782-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This patch does the following refactor:
- Refactor parameter from @root to @fs_info

- Refactor the large loop body into another function
  Now we have a helper function, read_one_block_group(), to handle
  block group cache and space info related routine.

- Refactor the return value
  Even we have the code handling ret > 0 from find_first_block_group(),
  it never works, as when there is no more block group,
  find_first_block_group() just return -ENOENT other than 1.

  This is super confusing, it's almost a mircle it even works.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 ctree.h       |   2 +-
 disk-io.c     |   9 ++-
 extent-tree.c | 160 ++++++++++++++++++++++++++++----------------------
 3 files changed, 97 insertions(+), 74 deletions(-)

diff --git a/ctree.h b/ctree.h
index 8c7b3cb40151..2899de358613 100644
--- a/ctree.h
+++ b/ctree.h
@@ -2550,7 +2550,7 @@ int update_space_info(struct btrfs_fs_info *info, u64 flags,
 		      u64 total_bytes, u64 bytes_used,
 		      struct btrfs_space_info **space_info);
 int btrfs_free_block_groups(struct btrfs_fs_info *info);
-int btrfs_read_block_groups(struct btrfs_root *root);
+int btrfs_read_block_groups(struct btrfs_fs_info *info);
 struct btrfs_block_group_cache *
 btrfs_add_block_group(struct btrfs_fs_info *fs_info, u64 bytes_used, u64 type,
 		      u64 chunk_offset, u64 size);
diff --git a/disk-io.c b/disk-io.c
index be44eead5cef..8978f0cb60c7 100644
--- a/disk-io.c
+++ b/disk-io.c
@@ -983,14 +983,17 @@ int btrfs_setup_all_roots(struct btrfs_fs_info *fs_info, u64 root_tree_bytenr,
 	fs_info->last_trans_committed = generation;
 	if (extent_buffer_uptodate(fs_info->extent_root->node) &&
 	    !(flags & OPEN_CTREE_NO_BLOCK_GROUPS)) {
-		ret = btrfs_read_block_groups(fs_info->tree_root);
+		ret = btrfs_read_block_groups(fs_info);
 		/*
 		 * If we don't find any blockgroups (ENOENT) we're either
 		 * restoring or creating the filesystem, where it's expected,
 		 * anything else is error
 		 */
-		if (ret != -ENOENT)
-			return -EIO;
+		if (ret < 0 && ret != -ENOENT) {
+			errno = -ret;
+			error("failed to read block groups: %m");
+			return ret;
+		}
 	}
 
 	key.objectid = BTRFS_FS_TREE_OBJECTID;
diff --git a/extent-tree.c b/extent-tree.c
index 19d1ea0df570..9713d627764c 100644
--- a/extent-tree.c
+++ b/extent-tree.c
@@ -2607,6 +2607,13 @@ int btrfs_free_block_groups(struct btrfs_fs_info *info)
 	return 0;
 }
 
+/*
+ * Find a block group which starts >= @key->objectid in extent tree.
+ *
+ * Return 0 for found
+ * Retrun >0 for not found
+ * Return <0 for error
+ */
 static int find_first_block_group(struct btrfs_root *root,
 		struct btrfs_path *path, struct btrfs_key *key)
 {
@@ -2636,36 +2643,95 @@ static int find_first_block_group(struct btrfs_root *root,
 			return 0;
 		path->slots[0]++;
 	}
-	ret = -ENOENT;
+	ret = 1;
 error:
 	return ret;
 }
 
-int btrfs_read_block_groups(struct btrfs_root *root)
+/*
+ * Helper function to read out one BLOCK_GROUP_ITEM and insert it into
+ * block group cache.
+ *
+ * Return 0 if nothing wrong (either insert the bg cache or skip 0 sized bg)
+ * Return <0 for error.
+ */
+static int read_one_block_group(struct btrfs_fs_info *fs_info,
+				 struct btrfs_path *path)
 {
-	struct btrfs_path *path;
-	int ret;
-	int bit;
-	struct btrfs_block_group_cache *cache;
-	struct btrfs_fs_info *info = root->fs_info;
+	struct extent_io_tree *block_group_cache = &fs_info->block_group_cache;
+	struct extent_buffer *leaf = path->nodes[0];
 	struct btrfs_space_info *space_info;
-	struct extent_io_tree *block_group_cache;
+	struct btrfs_block_group_cache *cache;
 	struct btrfs_key key;
-	struct btrfs_key found_key;
-	struct extent_buffer *leaf;
+	int slot = path->slots[0];
+	int bit = 0;
+	int ret;
 
-	block_group_cache = &info->block_group_cache;
+	btrfs_item_key_to_cpu(leaf, &key, slot);
+	ASSERT(key.type == BTRFS_BLOCK_GROUP_ITEM_KEY);
+
+	/*
+	 * Skip 0 sized block group, don't insert them into block
+	 * group cache tree, as its length is 0, it won't get
+	 * freed at close_ctree() time.
+	 */
+	if (key.offset == 0)
+		return 0;
+
+	cache = kzalloc(sizeof(*cache), GFP_NOFS);
+	if (!cache)
+		return -ENOMEM;
+	read_extent_buffer(leaf, &cache->item,
+			   btrfs_item_ptr_offset(leaf, slot),
+			   sizeof(cache->item));
+	memcpy(&cache->key, &key, sizeof(key));
+	cache->cached = 0;
+	cache->pinned = 0;
+	cache->flags = btrfs_block_group_flags(&cache->item);
+	if (cache->flags & BTRFS_BLOCK_GROUP_DATA) {
+		bit = BLOCK_GROUP_DATA;
+	} else if (cache->flags & BTRFS_BLOCK_GROUP_SYSTEM) {
+		bit = BLOCK_GROUP_SYSTEM;
+	} else if (cache->flags & BTRFS_BLOCK_GROUP_METADATA) {
+		bit = BLOCK_GROUP_METADATA;
+	}
+	set_avail_alloc_bits(fs_info, cache->flags);
+	if (btrfs_chunk_readonly(fs_info, cache->key.objectid))
+		cache->ro = 1;
+	exclude_super_stripes(fs_info, cache);
+
+	ret = update_space_info(fs_info, cache->flags, cache->key.offset,
+				btrfs_block_group_used(&cache->item),
+				&space_info);
+	if (ret < 0) {
+		free(cache);
+		return ret;
+	}
+	cache->space_info = space_info;
+
+	set_extent_bits(block_group_cache, cache->key.objectid,
+			cache->key.objectid + cache->key.offset - 1,
+			bit | EXTENT_LOCKED);
+	set_state_private(block_group_cache, cache->key.objectid,
+			  (unsigned long)cache);
+	return 0;
+}
 
-	root = info->extent_root;
+int btrfs_read_block_groups(struct btrfs_fs_info *fs_info)
+{
+	struct btrfs_path path;
+	struct btrfs_root *root;
+	int ret;
+	struct btrfs_key key;
+
+	root = fs_info->extent_root;
 	key.objectid = 0;
 	key.offset = 0;
 	key.type = BTRFS_BLOCK_GROUP_ITEM_KEY;
-	path = btrfs_alloc_path();
-	if (!path)
-		return -ENOMEM;
+	btrfs_init_path(&path);
 
 	while(1) {
-		ret = find_first_block_group(root, path, &key);
+		ret = find_first_block_group(root, &path, &key);
 		if (ret > 0) {
 			ret = 0;
 			goto error;
@@ -2673,67 +2739,21 @@ int btrfs_read_block_groups(struct btrfs_root *root)
 		if (ret != 0) {
 			goto error;
 		}
-		leaf = path->nodes[0];
-		btrfs_item_key_to_cpu(leaf, &found_key, path->slots[0]);
+		btrfs_item_key_to_cpu(path.nodes[0], &key, path.slots[0]);
 
-		cache = kzalloc(sizeof(*cache), GFP_NOFS);
-		if (!cache) {
-			ret = -ENOMEM;
+		ret = read_one_block_group(fs_info, &path);
+		if (ret < 0)
 			goto error;
-		}
 
-		read_extent_buffer(leaf, &cache->item,
-				   btrfs_item_ptr_offset(leaf, path->slots[0]),
-				   sizeof(cache->item));
-		memcpy(&cache->key, &found_key, sizeof(found_key));
-		cache->cached = 0;
-		cache->pinned = 0;
-		key.objectid = found_key.objectid + found_key.offset;
-		if (found_key.offset == 0)
+		if (key.offset == 0)
 			key.objectid++;
-		btrfs_release_path(path);
-
-		/*
-		 * Skip 0 sized block group, don't insert them into block
-		 * group cache tree, as its length is 0, it won't get
-		 * freed at close_ctree() time.
-		 */
-		if (found_key.offset == 0) {
-			free(cache);
-			continue;
-		}
-
-		cache->flags = btrfs_block_group_flags(&cache->item);
-		bit = 0;
-		if (cache->flags & BTRFS_BLOCK_GROUP_DATA) {
-			bit = BLOCK_GROUP_DATA;
-		} else if (cache->flags & BTRFS_BLOCK_GROUP_SYSTEM) {
-			bit = BLOCK_GROUP_SYSTEM;
-		} else if (cache->flags & BTRFS_BLOCK_GROUP_METADATA) {
-			bit = BLOCK_GROUP_METADATA;
-		}
-		set_avail_alloc_bits(info, cache->flags);
-		if (btrfs_chunk_readonly(info, cache->key.objectid))
-			cache->ro = 1;
-
-		exclude_super_stripes(info, cache);
-
-		ret = update_space_info(info, cache->flags, found_key.offset,
-					btrfs_block_group_used(&cache->item),
-					&space_info);
-		BUG_ON(ret);
-		cache->space_info = space_info;
-
-		/* use EXTENT_LOCKED to prevent merging */
-		set_extent_bits(block_group_cache, found_key.objectid,
-				found_key.objectid + found_key.offset - 1,
-				bit | EXTENT_LOCKED);
-		set_state_private(block_group_cache, found_key.objectid,
-				  (unsigned long)cache);
+		else
+			key.objectid = key.objectid + key.offset;
+		btrfs_release_path(&path);
 	}
 	ret = 0;
 error:
-	btrfs_free_path(path);
+	btrfs_release_path(&path);
 	return ret;
 }
 
-- 
2.23.0

