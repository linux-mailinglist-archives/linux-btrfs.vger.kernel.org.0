Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 76989EDFA4
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Nov 2019 13:04:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728828AbfKDME0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 4 Nov 2019 07:04:26 -0500
Received: from mx2.suse.de ([195.135.220.15]:44112 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728812AbfKDME0 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 4 Nov 2019 07:04:26 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 811D1AF7E
        for <linux-btrfs@vger.kernel.org>; Mon,  4 Nov 2019 12:04:23 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH RFC 6/7] btrfs-progs: check: Introduce support for bg-tree feature
Date:   Mon,  4 Nov 2019 20:04:00 +0800
Message-Id: <20191104120401.56408-7-wqu@suse.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191104120401.56408-1-wqu@suse.com>
References: <20191104120401.56408-1-wqu@suse.com>
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
 check/main.c        | 38 +++++++++++++++++++++++++++
 check/mode-lowmem.c | 63 +++++++++++++++++++++++++++++++++++++++------
 2 files changed, 93 insertions(+), 8 deletions(-)

diff --git a/check/main.c b/check/main.c
index a1261ce0ebe7..066d9574a556 100644
--- a/check/main.c
+++ b/check/main.c
@@ -5241,6 +5241,32 @@ static int process_block_group_item(struct block_group_tree *block_group_cache,
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
@@ -6106,6 +6132,10 @@ static int check_type_with_root(u64 rootid, u8 key_type)
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
@@ -6309,6 +6339,14 @@ static int run_next_block(struct btrfs_root *root,
 					&key, buf, i);
 				continue;
 			}
+			if (key.type == BTRFS_SKINNY_BLOCK_GROUP_ITEM_KEY) {
+				ret = process_skinny_bgi(block_group_cache,
+							 &key, buf);
+				/* -ENOMEM */
+				if (ret < 0)
+					goto out;
+				continue;
+			}
 			if (key.type == BTRFS_DEV_EXTENT_KEY) {
 				process_device_extent_item(dev_extent_cache,
 					&key, buf, i);
diff --git a/check/mode-lowmem.c b/check/mode-lowmem.c
index 7ecf95ed0170..26ae07ccb007 100644
--- a/check/mode-lowmem.c
+++ b/check/mode-lowmem.c
@@ -3536,16 +3536,39 @@ static int check_block_group_item(struct btrfs_fs_info *fs_info,
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
-	used = btrfs_block_group_used(&bg_item);
-	bg_flags = btrfs_block_group_flags(&bg_item);
+	if (bg_key.type == BTRFS_BLOCK_GROUP_ITEM_KEY) {
+		bi = btrfs_item_ptr(eb, slot, struct btrfs_block_group_item);
+		read_extent_buffer(eb, &bg_item, (unsigned long)bi, sizeof(bg_item));
+		used = btrfs_block_group_used(&bg_item);
+		bg_flags = btrfs_block_group_flags(&bg_item);
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
+		"block group[%llu %llu] did not find the related chunk item",
+				bg_key.objectid, bg_key.offset);
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
@@ -3563,10 +3586,10 @@ static int check_block_group_item(struct btrfs_fs_info *fs_info,
 		chunk = btrfs_item_ptr(path.nodes[0], path.slots[0],
 					struct btrfs_chunk);
 		if (btrfs_chunk_length(path.nodes[0], chunk) !=
-						bg_key.offset) {
+						bg_len) {
 			error(
 	"block group[%llu %llu] related chunk item length does not match",
-				bg_key.objectid, bg_key.offset);
+				bg_key.objectid, bg_len);
 			err |= REFERENCER_MISMATCH;
 		}
 	}
@@ -3591,7 +3614,7 @@ static int check_block_group_item(struct btrfs_fs_info *fs_info,
 			goto next;
 
 		btrfs_item_key_to_cpu(leaf, &extent_key, path.slots[0]);
-		if (extent_key.objectid >= bg_key.objectid + bg_key.offset)
+		if (extent_key.objectid >= bg_key.objectid + bg_len)
 			break;
 
 		if (extent_key.type != BTRFS_METADATA_ITEM_KEY &&
@@ -3638,7 +3661,7 @@ out:
 	if (total != used) {
 		error(
 		"block group[%llu %llu] used %llu but extent items used %llu",
-			bg_key.objectid, bg_key.offset, used, total);
+			bg_key.objectid, bg_len, used, total);
 		err |= BG_ACCOUNTING_ERROR;
 	}
 	return err;
@@ -4487,6 +4510,29 @@ static int find_block_group_item(struct btrfs_fs_info *fs_info,
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
@@ -4694,6 +4740,7 @@ again:
 			ret = repair_extent_data_item(root, path, nrefs, ret);
 		err |= ret;
 		break;
+	case BTRFS_SKINNY_BLOCK_GROUP_ITEM_KEY:
 	case BTRFS_BLOCK_GROUP_ITEM_KEY:
 		ret = check_block_group_item(fs_info, eb, slot);
 		if (repair &&
-- 
2.23.0

