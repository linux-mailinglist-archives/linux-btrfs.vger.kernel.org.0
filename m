Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C7D91C0E5C
	for <lists+linux-btrfs@lfdr.de>; Fri,  1 May 2020 08:52:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728270AbgEAGw3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 1 May 2020 02:52:29 -0400
Received: from mx2.suse.de ([195.135.220.15]:44310 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728204AbgEAGw2 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 1 May 2020 02:52:28 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 9BA9CAD11
        for <linux-btrfs@vger.kernel.org>; Fri,  1 May 2020 06:52:25 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 1/4] btrfs-progs: Sync block group item accessors from kernel
Date:   Fri,  1 May 2020 14:52:16 +0800
Message-Id: <20200501065219.484868-2-wqu@suse.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200501065219.484868-1-wqu@suse.com>
References: <20200501065219.484868-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 check/main.c                |  8 ++++----
 check/mode-lowmem.c         | 12 ++++++------
 cmds/rescue-chunk-recover.c | 10 +++++-----
 convert/common.c            |  6 +++---
 ctree.h                     | 12 ++++++------
 extent-tree.c               | 25 +++++++++++++------------
 mkfs/main.c                 |  7 +++----
 print-tree.c                |  6 +++---
 8 files changed, 43 insertions(+), 43 deletions(-)

diff --git a/check/main.c b/check/main.c
index a41117fe79f9..84c855eb0f65 100644
--- a/check/main.c
+++ b/check/main.c
@@ -5232,7 +5232,7 @@ btrfs_new_block_group_record(struct extent_buffer *leaf, struct btrfs_key *key,
 	rec->offset = key->offset;
 
 	ptr = btrfs_item_ptr(leaf, slot, struct btrfs_block_group_item);
-	rec->flags = btrfs_disk_block_group_flags(leaf, ptr);
+	rec->flags = btrfs_block_group_flags(leaf, ptr);
 
 	INIT_LIST_HEAD(&rec->list);
 
@@ -9161,10 +9161,10 @@ again:
 		if (!cache)
 			break;
 		start = cache->key.objectid + cache->key.offset;
-		btrfs_set_block_group_used(&bgi, cache->used);
-		btrfs_set_block_group_chunk_objectid(&bgi,
+		btrfs_set_stack_block_group_used(&bgi, cache->used);
+		btrfs_set_stack_block_group_chunk_objectid(&bgi,
 					BTRFS_FIRST_CHUNK_TREE_OBJECTID);
-		btrfs_set_block_group_flags(&bgi, cache->flags);
+		btrfs_set_stack_block_group_flags(&bgi, cache->flags);
 		ret = btrfs_insert_item(trans, fs_info->extent_root,
 					&cache->key, &bgi, sizeof(bgi));
 		if (ret) {
diff --git a/check/mode-lowmem.c b/check/mode-lowmem.c
index 96b6e16f9018..91be09614c51 100644
--- a/check/mode-lowmem.c
+++ b/check/mode-lowmem.c
@@ -301,7 +301,7 @@ static int modify_block_groups_cache(struct btrfs_fs_info *fs_info, u64 flags,
 		bi = btrfs_item_ptr(eb, slot, struct btrfs_block_group_item);
 		read_extent_buffer(eb, &bg_item, (unsigned long)bi,
 				   sizeof(bg_item));
-		if (btrfs_block_group_flags(&bg_item) & flags)
+		if (btrfs_stack_block_group_flags(&bg_item) & flags)
 			modify_block_group_cache(fs_info, bg_cache, cache);
 
 		ret = btrfs_next_item(root, &path);
@@ -460,7 +460,7 @@ static int is_chunk_almost_full(struct btrfs_fs_info *fs_info, u64 start)
 	total = key.offset;
 	bi = btrfs_item_ptr(eb, slot, struct btrfs_block_group_item);
 	read_extent_buffer(eb, &bg_item, (unsigned long)bi, sizeof(bg_item));
-	used = btrfs_block_group_used(&bg_item);
+	used = btrfs_stack_block_group_used(&bg_item);
 
 	/*
 	 * if the free space in the chunk is less than %10 of total,
@@ -3561,8 +3561,8 @@ static int check_block_group_item(struct btrfs_fs_info *fs_info,
 	btrfs_item_key_to_cpu(eb, &bg_key, slot);
 	bi = btrfs_item_ptr(eb, slot, struct btrfs_block_group_item);
 	read_extent_buffer(eb, &bg_item, (unsigned long)bi, sizeof(bg_item));
-	used = btrfs_block_group_used(&bg_item);
-	bg_flags = btrfs_block_group_flags(&bg_item);
+	used = btrfs_stack_block_group_used(&bg_item);
+	bg_flags = btrfs_stack_block_group_flags(&bg_item);
 
 	chunk_key.objectid = BTRFS_FIRST_CHUNK_TREE_OBJECTID;
 	chunk_key.type = BTRFS_CHUNK_ITEM_KEY;
@@ -4559,11 +4559,11 @@ static int check_chunk_item(struct btrfs_fs_info *fs_info,
 				    struct btrfs_block_group_item);
 		read_extent_buffer(leaf, &bg_item, (unsigned long)bi,
 				   sizeof(bg_item));
-		if (btrfs_block_group_flags(&bg_item) != type) {
+		if (btrfs_stack_block_group_flags(&bg_item) != type) {
 			error(
 "chunk[%llu %llu) related block group item flags mismatch, wanted: %llu, have: %llu",
 				chunk_key.offset, chunk_end, type,
-				btrfs_block_group_flags(&bg_item));
+				btrfs_stack_block_group_flags(&bg_item));
 			err |= REFERENCER_MISSING;
 		}
 	}
diff --git a/cmds/rescue-chunk-recover.c b/cmds/rescue-chunk-recover.c
index a13acc015d11..24c25b4d56a4 100644
--- a/cmds/rescue-chunk-recover.c
+++ b/cmds/rescue-chunk-recover.c
@@ -635,12 +635,12 @@ bg_check:
 	l = path.nodes[0];
 	slot = path.slots[0];
 	bg_ptr = btrfs_item_ptr(l, slot, struct btrfs_block_group_item);
-	if (chunk->type_flags != btrfs_disk_block_group_flags(l, bg_ptr)) {
+	if (chunk->type_flags != btrfs_block_group_flags(l, bg_ptr)) {
 		if (rc->verbose)
 			fprintf(stderr,
 				"Chunk[%llu, %llu]'s type(%llu) is different with Block Group's type(%llu)\n",
 				chunk->offset, chunk->length, chunk->type_flags,
-				btrfs_disk_block_group_flags(l, bg_ptr));
+				btrfs_block_group_flags(l, bg_ptr));
 		btrfs_release_path(&path);
 		return -ENOENT;
 	}
@@ -1358,9 +1358,9 @@ static int __insert_block_group(struct btrfs_trans_handle *trans,
 	struct btrfs_key key;
 	int ret = 0;
 
-	btrfs_set_block_group_used(&bg_item, used);
-	btrfs_set_block_group_chunk_objectid(&bg_item, used);
-	btrfs_set_block_group_flags(&bg_item, chunk_rec->type_flags);
+	btrfs_set_stack_block_group_used(&bg_item, used);
+	btrfs_set_stack_block_group_chunk_objectid(&bg_item, used);
+	btrfs_set_stack_block_group_flags(&bg_item, chunk_rec->type_flags);
 	key.objectid = chunk_rec->offset;
 	key.type = BTRFS_BLOCK_GROUP_ITEM_KEY;
 	key.offset = chunk_rec->length;
diff --git a/convert/common.c b/convert/common.c
index 3cb2d9d44881..0a7d2e20256a 100644
--- a/convert/common.c
+++ b/convert/common.c
@@ -679,9 +679,9 @@ static void insert_temp_block_group(struct extent_buffer *buf,
 	btrfs_set_item_offset(buf, btrfs_item_nr(*slot), *itemoff);
 	btrfs_set_item_size(buf, btrfs_item_nr(*slot), sizeof(bgi));
 
-	btrfs_set_block_group_flags(&bgi, flag);
-	btrfs_set_block_group_used(&bgi, used);
-	btrfs_set_block_group_chunk_objectid(&bgi,
+	btrfs_set_stack_block_group_flags(&bgi, flag);
+	btrfs_set_stack_block_group_used(&bgi, used);
+	btrfs_set_stack_block_group_chunk_objectid(&bgi,
 			BTRFS_FIRST_CHUNK_TREE_OBJECTID);
 	write_extent_buffer(buf, &bgi, btrfs_item_ptr_offset(buf, *slot),
 			    sizeof(bgi));
diff --git a/ctree.h b/ctree.h
index 9d69fa946079..62b77babad6e 100644
--- a/ctree.h
+++ b/ctree.h
@@ -1640,18 +1640,18 @@ static inline void btrfs_set_stripe_devid_nr(struct extent_buffer *eb,
 }
 
 /* struct btrfs_block_group_item */
-BTRFS_SETGET_STACK_FUNCS(block_group_used, struct btrfs_block_group_item,
+BTRFS_SETGET_STACK_FUNCS(stack_block_group_used, struct btrfs_block_group_item,
 			 used, 64);
-BTRFS_SETGET_FUNCS(disk_block_group_used, struct btrfs_block_group_item,
+BTRFS_SETGET_FUNCS(block_group_used, struct btrfs_block_group_item,
 			 used, 64);
-BTRFS_SETGET_STACK_FUNCS(block_group_chunk_objectid,
+BTRFS_SETGET_STACK_FUNCS(stack_block_group_chunk_objectid,
 			struct btrfs_block_group_item, chunk_objectid, 64);
 
-BTRFS_SETGET_FUNCS(disk_block_group_chunk_objectid,
+BTRFS_SETGET_FUNCS(block_group_chunk_objectid,
 		   struct btrfs_block_group_item, chunk_objectid, 64);
-BTRFS_SETGET_FUNCS(disk_block_group_flags,
+BTRFS_SETGET_FUNCS(block_group_flags,
 		   struct btrfs_block_group_item, flags, 64);
-BTRFS_SETGET_STACK_FUNCS(block_group_flags,
+BTRFS_SETGET_STACK_FUNCS(stack_block_group_flags,
 			struct btrfs_block_group_item, flags, 64);
 
 /* struct btrfs_free_space_info */
diff --git a/extent-tree.c b/extent-tree.c
index 4af8f4ba8a47..cb7691e7c101 100644
--- a/extent-tree.c
+++ b/extent-tree.c
@@ -1547,9 +1547,10 @@ static int write_one_cache_group(struct btrfs_trans_handle *trans,
 
 	leaf = path->nodes[0];
 	bi = btrfs_item_ptr_offset(leaf, path->slots[0]);
-	btrfs_set_block_group_used(&bgi, cache->used);
-	btrfs_set_block_group_flags(&bgi, cache->flags);
-	btrfs_set_block_group_chunk_objectid(&bgi, BTRFS_FIRST_CHUNK_TREE_OBJECTID);
+	btrfs_set_stack_block_group_used(&bgi, cache->used);
+	btrfs_set_stack_block_group_flags(&bgi, cache->flags);
+	btrfs_set_stack_block_group_chunk_objectid(&bgi,
+			BTRFS_FIRST_CHUNK_TREE_OBJECTID);
 	write_extent_buffer(leaf, &bgi, bi, sizeof(bgi));
 	btrfs_mark_buffer_dirty(leaf);
 	btrfs_release_path(path);
@@ -2665,8 +2666,8 @@ static int read_one_block_group(struct btrfs_fs_info *fs_info,
 	memcpy(&cache->key, &key, sizeof(key));
 	cache->cached = 0;
 	cache->pinned = 0;
-	cache->flags = btrfs_block_group_flags(&bgi);
-	cache->used = btrfs_block_group_used(&bgi);
+	cache->flags = btrfs_stack_block_group_flags(&bgi);
+	cache->used = btrfs_stack_block_group_used(&bgi);
 	INIT_LIST_HEAD(&cache->dirty_list);
 
 	set_avail_alloc_bits(fs_info, cache->flags);
@@ -2772,9 +2773,9 @@ int btrfs_make_block_group(struct btrfs_trans_handle *trans,
 
 	cache = btrfs_add_block_group(fs_info, bytes_used, type, chunk_offset,
 				      size);
-	btrfs_set_block_group_used(&bgi, cache->used);
-	btrfs_set_block_group_flags(&bgi, cache->flags);
-	btrfs_set_block_group_chunk_objectid(&bgi,
+	btrfs_set_stack_block_group_used(&bgi, cache->used);
+	btrfs_set_stack_block_group_flags(&bgi, cache->flags);
+	btrfs_set_stack_block_group_chunk_objectid(&bgi,
 			BTRFS_FIRST_CHUNK_TREE_OBJECTID);
 	ret = btrfs_insert_item(trans, extent_root, &cache->key, &bgi,
 				sizeof(bgi));
@@ -2858,9 +2859,9 @@ int btrfs_make_block_groups(struct btrfs_trans_handle *trans,
 		cache = btrfs_lookup_block_group(fs_info, cur_start);
 		BUG_ON(!cache);
 
-		btrfs_set_block_group_used(&bgi, cache->used);
-		btrfs_set_block_group_flags(&bgi, cache->flags);
-		btrfs_set_block_group_chunk_objectid(&bgi,
+		btrfs_set_stack_block_group_used(&bgi, cache->used);
+		btrfs_set_stack_block_group_flags(&bgi, cache->flags);
+		btrfs_set_stack_block_group_chunk_objectid(&bgi,
 				BTRFS_FIRST_CHUNK_TREE_OBJECTID);
 		ret = btrfs_insert_item(trans, extent_root, &cache->key, &bgi,
 					sizeof(bgi));
@@ -3180,7 +3181,7 @@ int btrfs_free_block_group(struct btrfs_trans_handle *trans,
 
 	bgi = btrfs_item_ptr(path->nodes[0], path->slots[0],
 			     struct btrfs_block_group_item);
-	if (btrfs_disk_block_group_used(path->nodes[0], bgi)) {
+	if (btrfs_block_group_used(path->nodes[0], bgi)) {
 		fprintf(stderr,
 			"WARNING: block group [%llu,%llu) is not empty\n",
 			bytenr, bytenr + len);
diff --git a/mkfs/main.c b/mkfs/main.c
index 316ea82e45c6..b659c1cbb56b 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -520,10 +520,10 @@ static int is_temp_block_group(struct extent_buffer *node,
 			       u64 data_profile, u64 meta_profile,
 			       u64 sys_profile)
 {
-	u64 flag = btrfs_disk_block_group_flags(node, bgi);
+	u64 flag = btrfs_block_group_flags(node, bgi);
 	u64 flag_type = flag & BTRFS_BLOCK_GROUP_TYPE_MASK;
 	u64 flag_profile = flag & BTRFS_BLOCK_GROUP_PROFILE_MASK;
-	u64 used = btrfs_disk_block_group_used(node, bgi);
+	u64 used = btrfs_block_group_used(node, bgi);
 
 	/*
 	 * Chunks meets all the following conditions is a temp chunk
@@ -642,8 +642,7 @@ static int cleanup_temp_chunks(struct btrfs_fs_info *fs_info,
 		if (is_temp_block_group(path.nodes[0], bgi,
 					data_profile, meta_profile,
 					sys_profile)) {
-			u64 flags = btrfs_disk_block_group_flags(path.nodes[0],
-							     bgi);
+			u64 flags = btrfs_block_group_flags(path.nodes[0], bgi);
 
 			ret = btrfs_free_block_group(trans, fs_info,
 					found_key.objectid, found_key.offset);
diff --git a/print-tree.c b/print-tree.c
index 0c63f6ca2325..27acadb22205 100644
--- a/print-tree.c
+++ b/print-tree.c
@@ -1019,10 +1019,10 @@ static void print_block_group_item(struct extent_buffer *eb,
 
 	read_extent_buffer(eb, &bg_item, (unsigned long)bgi, sizeof(bg_item));
 	memset(flags_str, 0, sizeof(flags_str));
-	bg_flags_to_str(btrfs_block_group_flags(&bg_item), flags_str);
+	bg_flags_to_str(btrfs_stack_block_group_flags(&bg_item), flags_str);
 	printf("\t\tblock group used %llu chunk_objectid %llu flags %s\n",
-		(unsigned long long)btrfs_block_group_used(&bg_item),
-		(unsigned long long)btrfs_block_group_chunk_objectid(&bg_item),
+		btrfs_stack_block_group_used(&bg_item),
+		btrfs_stack_block_group_chunk_objectid(&bg_item),
 		flags_str);
 }
 
-- 
2.26.2

