Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6C961C4AD9
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 May 2020 02:02:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728497AbgEEACx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 4 May 2020 20:02:53 -0400
Received: from mx2.suse.de ([195.135.220.15]:38792 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728491AbgEEACw (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 4 May 2020 20:02:52 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 70A06AF0B
        for <linux-btrfs@vger.kernel.org>; Tue,  5 May 2020 00:02:52 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v4 09/11] btrfs-progs: check: Introduce support for bg-tree feature
Date:   Tue,  5 May 2020 08:02:28 +0800
Message-Id: <20200505000230.4454-10-wqu@suse.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200505000230.4454-1-wqu@suse.com>
References: <20200505000230.4454-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Just some minor modification.

- original mode:
  * skinny block group item can only occur in bg tree
  * check skinny block group item
    Introduce a new function, process_skinny_bgi(), for this check.
- lowmem mode:
  * search skinny block group items in bg tree if SKINNY_BG_TREE feature is set.
  * check skinny block group item
    This is done by reusing check_block_group_item().

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 check/common.h              |  4 +--
 check/main.c                | 60 ++++++++++++++++++++++++++-------
 check/mode-lowmem.c         | 66 +++++++++++++++++++++++++++++++------
 cmds/rescue-chunk-recover.c |  5 ++-
 4 files changed, 111 insertions(+), 24 deletions(-)

diff --git a/check/common.h b/check/common.h
index 62cdc1d934c7..060920f149d4 100644
--- a/check/common.h
+++ b/check/common.h
@@ -166,8 +166,8 @@ struct chunk_record *btrfs_new_chunk_record(struct extent_buffer *leaf,
 					    struct btrfs_key *key,
 					    int slot);
 struct block_group_record *
-btrfs_new_block_group_record(struct extent_buffer *leaf, struct btrfs_key *key,
-			     int slot);
+btrfs_new_block_group_record(struct extent_buffer *leaf, u64 start, u64 length,
+			     u64 flags);
 struct device_extent_record *
 btrfs_new_device_extent_record(struct extent_buffer *leaf,
 			       struct btrfs_key *key, int slot);
diff --git a/check/main.c b/check/main.c
index e7288e042dba..03b269404ba5 100644
--- a/check/main.c
+++ b/check/main.c
@@ -5210,10 +5210,9 @@ static int process_device_item(struct rb_root *dev_cache,
 }
 
 struct block_group_record *
-btrfs_new_block_group_record(struct extent_buffer *leaf, struct btrfs_key *key,
-			     int slot)
+btrfs_new_block_group_record(struct extent_buffer *leaf, u64 start, u64 length,
+			     u64 flags)
 {
-	struct btrfs_block_group_item *ptr;
 	struct block_group_record *rec;
 
 	rec = calloc(1, sizeof(*rec));
@@ -5222,17 +5221,16 @@ btrfs_new_block_group_record(struct extent_buffer *leaf, struct btrfs_key *key,
 		exit(-1);
 	}
 
-	rec->cache.start = key->objectid;
-	rec->cache.size = key->offset;
+	rec->cache.start = start;
+	rec->cache.size = length;
 
 	rec->generation = btrfs_header_generation(leaf);
 
-	rec->objectid = key->objectid;
-	rec->type = key->type;
-	rec->offset = key->offset;
+	rec->objectid = start;
+	rec->type = BTRFS_BLOCK_GROUP_ITEM_KEY;
+	rec->offset = length;
 
-	ptr = btrfs_item_ptr(leaf, slot, struct btrfs_block_group_item);
-	rec->flags = btrfs_block_group_flags(leaf, ptr);
+	rec->flags = flags;
 
 	INIT_LIST_HEAD(&rec->list);
 
@@ -5243,10 +5241,13 @@ static int process_block_group_item(struct block_group_tree *block_group_cache,
 				    struct btrfs_key *key,
 				    struct extent_buffer *eb, int slot)
 {
+	struct btrfs_block_group_item *bgi;
 	struct block_group_record *rec;
 	int ret = 0;
 
-	rec = btrfs_new_block_group_record(eb, key, slot);
+	bgi = btrfs_item_ptr(eb, slot, struct btrfs_block_group_item);
+	rec = btrfs_new_block_group_record(eb, key->objectid, key->offset,
+				btrfs_block_group_flags(eb, bgi));
 	ret = insert_block_group_record(block_group_cache, rec);
 	if (ret) {
 		fprintf(stderr, "Block Group[%llu, %llu] existed.\n",
@@ -5257,6 +5258,32 @@ static int process_block_group_item(struct block_group_tree *block_group_cache,
 	return ret;
 }
 
+static int process_skinny_bgi(struct block_group_tree *block_group_cache,
+			      struct btrfs_key *key, struct extent_buffer *eb)
+{
+	struct btrfs_mapping_tree *map_tree = &global_info->mapping_tree;
+	struct block_group_record *rec;
+	struct cache_extent *ce;
+	struct map_lookup *map;
+	int ret;
+
+	ce = search_cache_extent(&map_tree->cache_tree, key->objectid);
+	/* For mismatch case, we just skip this bgi */
+	if (ce->start != key->objectid)
+		return 0;
+
+	map = container_of(ce, struct map_lookup, ce);
+	rec = btrfs_new_block_group_record(eb, key->objectid, ce->size,
+					   map->type);
+	ret = insert_block_group_record(block_group_cache, rec);
+	if (ret) {
+		error("block group [%llu, %llu) existed.",
+			ce->start, ce->start + ce->size);
+		free(rec);
+	}
+	return ret;
+}
+
 struct device_extent_record *
 btrfs_new_device_extent_record(struct extent_buffer *leaf,
 			       struct btrfs_key *key, int slot)
@@ -6124,6 +6151,10 @@ static int check_type_with_root(u64 rootid, u8 key_type)
 		if (rootid != BTRFS_EXTENT_TREE_OBJECTID)
 			goto err;
 		break;
+	case BTRFS_SKINNY_BLOCK_GROUP_ITEM_KEY:
+		if (rootid != BTRFS_BLOCK_GROUP_TREE_OBJECTID)
+			goto err;
+		break;
 	case BTRFS_ROOT_ITEM_KEY:
 		if (rootid != BTRFS_ROOT_TREE_OBJECTID)
 			goto err;
@@ -6330,6 +6361,13 @@ static int run_next_block(struct btrfs_root *root,
 					&key, buf, i);
 				continue;
 			}
+			if (key.type == BTRFS_SKINNY_BLOCK_GROUP_ITEM_KEY) {
+				ret = process_skinny_bgi(block_group_cache,
+							 &key, buf);
+				if (ret < 0)
+					goto out;
+				continue;
+			}
 			if (key.type == BTRFS_DEV_EXTENT_KEY) {
 				process_device_extent_item(dev_extent_cache,
 					&key, buf, i);
diff --git a/check/mode-lowmem.c b/check/mode-lowmem.c
index dbb90895127d..828358d9b2c9 100644
--- a/check/mode-lowmem.c
+++ b/check/mode-lowmem.c
@@ -3553,16 +3553,39 @@ static int check_block_group_item(struct btrfs_fs_info *fs_info,
 	u32 nodesize = btrfs_super_nodesize(fs_info->super_copy);
 	u64 flags;
 	u64 bg_flags;
+	u64 bg_len;
 	u64 used;
 	u64 total = 0;
 	int ret;
 	int err = 0;
 
 	btrfs_item_key_to_cpu(eb, &bg_key, slot);
-	bi = btrfs_item_ptr(eb, slot, struct btrfs_block_group_item);
-	read_extent_buffer(eb, &bg_item, (unsigned long)bi, sizeof(bg_item));
-	used = btrfs_stack_block_group_used(&bg_item);
-	bg_flags = btrfs_stack_block_group_flags(&bg_item);
+	if (bg_key.type == BTRFS_BLOCK_GROUP_ITEM_KEY) {
+		bi = btrfs_item_ptr(eb, slot, struct btrfs_block_group_item);
+		read_extent_buffer(eb, &bg_item, (unsigned long)bi, sizeof(bg_item));
+		used = btrfs_stack_block_group_used(&bg_item);
+		bg_flags = btrfs_stack_block_group_flags(&bg_item);
+		bg_len = bg_key.offset;
+	} else {
+		struct btrfs_mapping_tree *map_tree = &fs_info->mapping_tree;
+		struct cache_extent *ce;
+		struct map_lookup *map;
+
+		ce = search_cache_extent(&map_tree->cache_tree,
+					 bg_key.objectid);
+		if (!ce || ce->start != bg_key.objectid) {
+			error(
+		"block group[%llu] did not find the related chunk item",
+				bg_key.objectid);
+			err |= REFERENCER_MISSING;
+			return err;
+		} else {
+			map = container_of(ce, struct map_lookup, ce);
+			bg_flags = map->type;
+		}
+		used = bg_key.offset;
+		bg_len = ce->size;
+	}
 
 	chunk_key.objectid = BTRFS_FIRST_CHUNK_TREE_OBJECTID;
 	chunk_key.type = BTRFS_CHUNK_ITEM_KEY;
@@ -3574,16 +3597,15 @@ static int check_block_group_item(struct btrfs_fs_info *fs_info,
 	if (ret) {
 		error(
 		"block group[%llu %llu] did not find the related chunk item",
-			bg_key.objectid, bg_key.offset);
+			bg_key.objectid, bg_len);
 		err |= REFERENCER_MISSING;
 	} else {
 		chunk = btrfs_item_ptr(path.nodes[0], path.slots[0],
 					struct btrfs_chunk);
-		if (btrfs_chunk_length(path.nodes[0], chunk) !=
-						bg_key.offset) {
+		if (btrfs_chunk_length(path.nodes[0], chunk) != bg_len) {
 			error(
 	"block group[%llu %llu] related chunk item length does not match",
-				bg_key.objectid, bg_key.offset);
+				bg_key.objectid, bg_len);
 			err |= REFERENCER_MISMATCH;
 		}
 	}
@@ -3608,7 +3630,7 @@ static int check_block_group_item(struct btrfs_fs_info *fs_info,
 			goto next;
 
 		btrfs_item_key_to_cpu(leaf, &extent_key, path.slots[0]);
-		if (extent_key.objectid >= bg_key.objectid + bg_key.offset)
+		if (extent_key.objectid >= bg_key.objectid + bg_len)
 			break;
 
 		if (extent_key.type != BTRFS_METADATA_ITEM_KEY &&
@@ -3655,7 +3677,7 @@ out:
 	if (total != used) {
 		error(
 		"block group[%llu %llu] used %llu but extent items used %llu",
-			bg_key.objectid, bg_key.offset, used, total);
+			bg_key.objectid, bg_len, used, total);
 		err |= BG_ACCOUNTING_ERROR;
 	}
 	return err;
@@ -4514,6 +4536,29 @@ static int find_block_group_item(struct btrfs_fs_info *fs_info,
 	struct btrfs_key key;
 	int ret;
 
+	if (btrfs_fs_incompat(fs_info, SKINNY_BG_TREE)) {
+		key.objectid = bytenr;
+		key.type = BTRFS_SKINNY_BLOCK_GROUP_ITEM_KEY;
+		key.offset = (u64)-1;
+
+		ret = btrfs_search_slot(NULL, fs_info->bg_root, &key, path, 0, 0);
+		if (ret < 0)
+			return ret;
+		if (ret == 0) {
+			ret = -EUCLEAN;
+			error("invalid skinny bg item found for chunk [%llu, %llu)",
+				bytenr, bytenr + len);
+			goto out;
+		}
+		ret = btrfs_previous_item(fs_info->bg_root, path, bytenr,
+					  BTRFS_SKINNY_BLOCK_GROUP_ITEM_KEY);
+		if (ret > 0) {
+			ret = -ENOENT;
+			error("can't find skinny bg item for chunk [%llu, %llu)",
+				bytenr, bytenr + len);
+		}
+		goto out;
+	}
 	key.objectid = bytenr;
 	key.type = BTRFS_BLOCK_GROUP_ITEM_KEY;
 	key.offset = len;
@@ -4722,6 +4767,7 @@ again:
 		err |= ret;
 		break;
 	case BTRFS_BLOCK_GROUP_ITEM_KEY:
+	case BTRFS_SKINNY_BLOCK_GROUP_ITEM_KEY:
 		ret = check_block_group_item(fs_info, eb, slot);
 		if (repair &&
 		    ret & REFERENCER_MISSING)
diff --git a/cmds/rescue-chunk-recover.c b/cmds/rescue-chunk-recover.c
index 8732324e7da0..6a7dba3bc8b8 100644
--- a/cmds/rescue-chunk-recover.c
+++ b/cmds/rescue-chunk-recover.c
@@ -226,12 +226,15 @@ static int process_block_group_item(struct block_group_tree *bg_cache,
 				    struct extent_buffer *leaf,
 				    struct btrfs_key *key, int slot)
 {
+	struct btrfs_block_group_item *bgi;
 	struct block_group_record *rec;
 	struct block_group_record *exist;
 	struct cache_extent *cache;
 	int ret = 0;
 
-	rec = btrfs_new_block_group_record(leaf, key, slot);
+	bgi = btrfs_item_ptr(leaf, slot, struct btrfs_block_group_item);
+	rec = btrfs_new_block_group_record(leaf, key->objectid, key->offset,
+				btrfs_block_group_flags(leaf, bgi));
 	if (!rec->cache.size)
 		goto free_out;
 again:
-- 
2.26.2

