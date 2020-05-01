Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C13E71C0E5F
	for <lists+linux-btrfs@lfdr.de>; Fri,  1 May 2020 08:52:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728295AbgEAGwg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 1 May 2020 02:52:36 -0400
Received: from mx2.suse.de ([195.135.220.15]:44330 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728282AbgEAGwg (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 1 May 2020 02:52:36 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id B0FCFAD65
        for <linux-btrfs@vger.kernel.org>; Fri,  1 May 2020 06:52:32 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 4/4] btrfs-progs: Rename btrfs_block_group_cache to btrfs_block_group
Date:   Fri,  1 May 2020 14:52:19 +0800
Message-Id: <20200501065219.484868-5-wqu@suse.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200501065219.484868-1-wqu@suse.com>
References: <20200501065219.484868-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

To keep the same naming across kernel and btrfs-progs.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 check/main.c                    | 14 +++---
 check/mode-common.c             |  2 +-
 check/mode-lowmem.c             |  6 +--
 cmds/rescue-chunk-recover.c     |  2 +-
 convert/main.c                  |  2 +-
 convert/source-fs.c             |  2 +-
 ctree.h                         | 17 ++++----
 extent-tree.c                   | 76 ++++++++++++++++-----------------
 free-space-cache.c              | 10 ++---
 free-space-cache.h              | 12 +++---
 image/main.c                    |  2 +-
 kernel-shared/free-space-tree.c | 40 ++++++++---------
 kernel-shared/free-space-tree.h |  6 +--
 mkfs/main.c                     |  2 +-
 transaction.h                   |  2 +-
 volumes.h                       |  2 +-
 16 files changed, 97 insertions(+), 100 deletions(-)

diff --git a/check/main.c b/check/main.c
index 2610220e5b6d..e7288e042dba 100644
--- a/check/main.c
+++ b/check/main.c
@@ -4541,7 +4541,7 @@ static struct data_backref *alloc_data_backref(struct extent_record *rec,
 /* Check if the type of extent matches with its chunk */
 static void check_extent_type(struct extent_record *rec)
 {
-	struct btrfs_block_group_cache *bg_cache;
+	struct btrfs_block_group *bg_cache;
 
 	bg_cache = btrfs_lookup_first_block_group(global_info, rec->start);
 	if (!bg_cache)
@@ -5443,7 +5443,7 @@ out:
 }
 
 static int check_cache_range(struct btrfs_root *root,
-			     struct btrfs_block_group_cache *cache,
+			     struct btrfs_block_group *cache,
 			     u64 offset, u64 bytes)
 {
 	struct btrfs_free_space *entry;
@@ -5537,7 +5537,7 @@ static int check_cache_range(struct btrfs_root *root,
 }
 
 static int verify_space_cache(struct btrfs_root *root,
-			      struct btrfs_block_group_cache *cache)
+			      struct btrfs_block_group *cache)
 {
 	struct btrfs_path path;
 	struct extent_buffer *leaf;
@@ -5616,7 +5616,7 @@ out:
 
 static int check_space_cache(struct btrfs_root *root)
 {
-	struct btrfs_block_group_cache *cache;
+	struct btrfs_block_group *cache;
 	u64 start = BTRFS_SUPER_INFO_OFFSET + BTRFS_SUPER_INFO_SIZE;
 	int ret;
 	int error = 0;
@@ -8908,7 +8908,7 @@ static int btrfs_fsck_reinit_root(struct btrfs_trans_handle *trans,
 
 static int reset_block_groups(struct btrfs_fs_info *fs_info)
 {
-	struct btrfs_block_group_cache *cache;
+	struct btrfs_block_group *cache;
 	struct btrfs_path path;
 	struct extent_buffer *leaf;
 	struct btrfs_chunk *chunk;
@@ -9154,7 +9154,7 @@ again:
 	 */
 	while (1) {
 		struct btrfs_block_group_item bgi;
-		struct btrfs_block_group_cache *cache;
+		struct btrfs_block_group *cache;
 		struct btrfs_key key;
 
 		cache = btrfs_lookup_first_block_group(fs_info, start);
@@ -9806,7 +9806,7 @@ out:
 static int clear_free_space_cache(struct btrfs_fs_info *fs_info)
 {
 	struct btrfs_trans_handle *trans;
-	struct btrfs_block_group_cache *bg_cache;
+	struct btrfs_block_group *bg_cache;
 	u64 current = 0;
 	int ret = 0;
 
diff --git a/check/mode-common.c b/check/mode-common.c
index 73b2622dd674..aa45c5c2b8a3 100644
--- a/check/mode-common.c
+++ b/check/mode-common.c
@@ -582,7 +582,7 @@ int check_child_node(struct extent_buffer *parent, int slot,
 
 void reset_cached_block_groups(struct btrfs_fs_info *fs_info)
 {
-	struct btrfs_block_group_cache *cache;
+	struct btrfs_block_group *cache;
 	u64 start, end;
 	int ret;
 
diff --git a/check/mode-lowmem.c b/check/mode-lowmem.c
index b47963a46d80..821ebc57c8ed 100644
--- a/check/mode-lowmem.c
+++ b/check/mode-lowmem.c
@@ -239,7 +239,7 @@ static int update_nodes_refs(struct btrfs_root *root, u64 bytenr,
  * according to @cache.
  */
 static int modify_block_group_cache(struct btrfs_fs_info *fs_info,
-		    struct btrfs_block_group_cache *block_group, int cache)
+		    struct btrfs_block_group *block_group, int cache)
 {
 	struct extent_io_tree *free_space_cache = &fs_info->free_space_cache;
 	u64 start = block_group->start;
@@ -269,7 +269,7 @@ static int modify_block_groups_cache(struct btrfs_fs_info *fs_info, u64 flags,
 	struct btrfs_root *root = fs_info->extent_root;
 	struct btrfs_key key;
 	struct btrfs_path path;
-	struct btrfs_block_group_cache *bg_cache;
+	struct btrfs_block_group *bg_cache;
 	struct btrfs_block_group_item *bi;
 	struct btrfs_block_group_item bg_item;
 	struct extent_buffer *eb;
@@ -367,7 +367,7 @@ out:
 static int force_cow_in_new_chunk(struct btrfs_fs_info *fs_info,
 				  u64 *start_ret)
 {
-	struct btrfs_block_group_cache *bg;
+	struct btrfs_block_group *bg;
 	u64 start;
 	u64 nbytes;
 	u64 alloc_profile;
diff --git a/cmds/rescue-chunk-recover.c b/cmds/rescue-chunk-recover.c
index 101b32700b0d..8732324e7da0 100644
--- a/cmds/rescue-chunk-recover.c
+++ b/cmds/rescue-chunk-recover.c
@@ -1087,7 +1087,7 @@ err:
 static int block_group_free_all_extent(struct btrfs_trans_handle *trans,
 				       struct block_group_record *bg)
 {
-	struct btrfs_block_group_cache *cache;
+	struct btrfs_block_group *cache;
 	struct btrfs_fs_info *info;
 	u64 start;
 	u64 end;
diff --git a/convert/main.c b/convert/main.c
index 62d839b7262c..9b2d2cfc8a28 100644
--- a/convert/main.c
+++ b/convert/main.c
@@ -202,7 +202,7 @@ static int create_image_file_range(struct btrfs_trans_handle *trans,
 				      u32 convert_flags)
 {
 	struct cache_extent *cache;
-	struct btrfs_block_group_cache *bg_cache;
+	struct btrfs_block_group *bg_cache;
 	u64 len = *ret_len;
 	u64 disk_bytenr;
 	int i;
diff --git a/convert/source-fs.c b/convert/source-fs.c
index a4e49b774958..f7fd3d6055b7 100644
--- a/convert/source-fs.c
+++ b/convert/source-fs.c
@@ -90,7 +90,7 @@ int block_iterate_proc(u64 disk_block, u64 file_block,
 	u64 reserved_boundary;
 	int do_barrier;
 	struct btrfs_root *root = idata->root;
-	struct btrfs_block_group_cache *cache;
+	struct btrfs_block_group *cache;
 	u32 sectorsize = root->fs_info->sectorsize;
 	u64 bytenr = disk_block * sectorsize;
 
diff --git a/ctree.h b/ctree.h
index 6ebd4ea61ee5..0256b0e6bc3d 100644
--- a/ctree.h
+++ b/ctree.h
@@ -1104,7 +1104,7 @@ struct btrfs_space_info {
 	struct list_head list;
 };
 
-struct btrfs_block_group_cache {
+struct btrfs_block_group {
 	struct btrfs_space_info *space_info;
 	struct btrfs_free_space_ctl *free_space_ctl;
 	u64 start;
@@ -2539,10 +2539,9 @@ int btrfs_fix_block_accounting(struct btrfs_trans_handle *trans);
 void btrfs_pin_extent(struct btrfs_fs_info *fs_info, u64 bytenr, u64 num_bytes);
 void btrfs_unpin_extent(struct btrfs_fs_info *fs_info,
 			u64 bytenr, u64 num_bytes);
-struct btrfs_block_group_cache *btrfs_lookup_block_group(struct
-							 btrfs_fs_info *info,
-							 u64 bytenr);
-struct btrfs_block_group_cache *btrfs_lookup_first_block_group(struct
+struct btrfs_block_group *btrfs_lookup_block_group(struct btrfs_fs_info *info,
+						   u64 bytenr);
+struct btrfs_block_group *btrfs_lookup_first_block_group(struct
 						       btrfs_fs_info *info,
 						       u64 bytenr);
 struct extent_buffer *btrfs_alloc_free_block(struct btrfs_trans_handle *trans,
@@ -2583,7 +2582,7 @@ int update_space_info(struct btrfs_fs_info *info, u64 flags,
 		      struct btrfs_space_info **space_info);
 int btrfs_free_block_groups(struct btrfs_fs_info *info);
 int btrfs_read_block_groups(struct btrfs_fs_info *info);
-struct btrfs_block_group_cache *
+struct btrfs_block_group *
 btrfs_add_block_group(struct btrfs_fs_info *fs_info, u64 bytes_used, u64 type,
 		      u64 chunk_offset, u64 size);
 int btrfs_make_block_group(struct btrfs_trans_handle *trans,
@@ -2601,10 +2600,10 @@ int btrfs_record_file_extent(struct btrfs_trans_handle *trans,
 int btrfs_free_block_group(struct btrfs_trans_handle *trans,
 			   struct btrfs_fs_info *fs_info, u64 bytenr, u64 len);
 void free_excluded_extents(struct btrfs_fs_info *fs_info,
-			   struct btrfs_block_group_cache *cache);
+			   struct btrfs_block_group *cache);
 int exclude_super_stripes(struct btrfs_fs_info *fs_info,
-			  struct btrfs_block_group_cache *cache);
-u64 add_new_free_space(struct btrfs_block_group_cache *block_group,
+			  struct btrfs_block_group *cache);
+u64 add_new_free_space(struct btrfs_block_group *block_group,
 		       struct btrfs_fs_info *info, u64 start, u64 end);
 u64 hash_extent_data_ref(u64 root_objectid, u64 owner, u64 offset);
 
diff --git a/extent-tree.c b/extent-tree.c
index aee859af5d98..bd7dbf551876 100644
--- a/extent-tree.c
+++ b/extent-tree.c
@@ -50,12 +50,12 @@ static int __free_extent(struct btrfs_trans_handle *trans,
 			 u64 bytenr, u64 num_bytes, u64 parent,
 			 u64 root_objectid, u64 owner_objectid,
 			 u64 owner_offset, int refs_to_drop);
-static struct btrfs_block_group_cache *
-btrfs_find_block_group(struct btrfs_root *root, struct btrfs_block_group_cache
+static struct btrfs_block_group *
+btrfs_find_block_group(struct btrfs_root *root, struct btrfs_block_group
 		       *hint, u64 search_start, int data, int owner);
 
 static int remove_sb_from_cache(struct btrfs_root *root,
-				struct btrfs_block_group_cache *cache)
+				struct btrfs_block_group *cache)
 {
 	u64 bytenr;
 	u64 *logical;
@@ -80,7 +80,7 @@ static int remove_sb_from_cache(struct btrfs_root *root,
 }
 
 static int cache_block_group(struct btrfs_root *root,
-			     struct btrfs_block_group_cache *block_group)
+			     struct btrfs_block_group *block_group)
 {
 	struct btrfs_path *path;
 	int ret;
@@ -166,17 +166,17 @@ err:
  * This adds the block group to the fs_info rb tree for the block group cache
  */
 static int btrfs_add_block_group_cache(struct btrfs_fs_info *info,
-				struct btrfs_block_group_cache *block_group)
+				struct btrfs_block_group *block_group)
 {
 	struct rb_node **p;
 	struct rb_node *parent = NULL;
-	struct btrfs_block_group_cache *cache;
+	struct btrfs_block_group *cache;
 
 	p = &info->block_group_cache_tree.rb_node;
 
 	while (*p) {
 		parent = *p;
-		cache = rb_entry(parent, struct btrfs_block_group_cache,
+		cache = rb_entry(parent, struct btrfs_block_group,
 				 cache_node);
 		if (block_group->start < cache->start)
 			p = &(*p)->rb_left;
@@ -201,17 +201,17 @@ static int btrfs_add_block_group_cache(struct btrfs_fs_info *info,
  *   if 0, return NULL if there's no block group containing the bytenr.
  *   if 1, return the block group which starts after @bytenr.
  */
-static struct btrfs_block_group_cache *block_group_cache_tree_search(
+static struct btrfs_block_group *block_group_cache_tree_search(
 		struct btrfs_fs_info *info, u64 bytenr, int next)
 {
-	struct btrfs_block_group_cache *cache, *ret = NULL;
+	struct btrfs_block_group *cache, *ret = NULL;
 	struct rb_node *n;
 	u64 end, start;
 
 	n = info->block_group_cache_tree.rb_node;
 
 	while (n) {
-		cache = rb_entry(n, struct btrfs_block_group_cache,
+		cache = rb_entry(n, struct btrfs_block_group,
 				 cache_node);
 		end = cache->start + cache->length - 1;
 		start = cache->start;
@@ -239,7 +239,7 @@ static struct btrfs_block_group_cache *block_group_cache_tree_search(
  * Return the block group that contains @bytenr, otherwise return the next one
  * that starts after @bytenr
  */
-struct btrfs_block_group_cache *btrfs_lookup_first_block_group(
+struct btrfs_block_group *btrfs_lookup_first_block_group(
 		struct btrfs_fs_info *info, u64 bytenr)
 {
 	return block_group_cache_tree_search(info, bytenr, 1);
@@ -248,23 +248,23 @@ struct btrfs_block_group_cache *btrfs_lookup_first_block_group(
 /*
  * Return the block group that contains the given bytenr
  */
-struct btrfs_block_group_cache *btrfs_lookup_block_group(
+struct btrfs_block_group *btrfs_lookup_block_group(
 		struct btrfs_fs_info *info, u64 bytenr)
 {
 	return block_group_cache_tree_search(info, bytenr, 0);
 }
 
-static int block_group_bits(struct btrfs_block_group_cache *cache, u64 bits)
+static int block_group_bits(struct btrfs_block_group *cache, u64 bits)
 {
 	return (cache->flags & bits) == bits;
 }
 
 static int noinline find_search_start(struct btrfs_root *root,
-			      struct btrfs_block_group_cache **cache_ret,
+			      struct btrfs_block_group **cache_ret,
 			      u64 *start_ret, int num, int data)
 {
 	int ret;
-	struct btrfs_block_group_cache *cache = *cache_ret;
+	struct btrfs_block_group *cache = *cache_ret;
 	u64 last = *start_ret;
 	u64 start = 0;
 	u64 end = 0;
@@ -326,12 +326,12 @@ wrapped:
 	goto again;
 }
 
-static struct btrfs_block_group_cache *
-btrfs_find_block_group(struct btrfs_root *root, struct btrfs_block_group_cache
+static struct btrfs_block_group *
+btrfs_find_block_group(struct btrfs_root *root, struct btrfs_block_group
 		       *hint, u64 search_start, int data, int owner)
 {
-	struct btrfs_block_group_cache *cache;
-	struct btrfs_block_group_cache *found_group = NULL;
+	struct btrfs_block_group *cache;
+	struct btrfs_block_group *found_group = NULL;
 	struct btrfs_fs_info *info = root->fs_info;
 	u64 used;
 	u64 last = 0;
@@ -344,7 +344,7 @@ btrfs_find_block_group(struct btrfs_root *root, struct btrfs_block_group_cache
 		factor = 10;
 
 	if (search_start) {
-		struct btrfs_block_group_cache *shint;
+		struct btrfs_block_group *shint;
 		shint = btrfs_lookup_block_group(info, search_start);
 		if (shint && !shint->ro && block_group_bits(shint, data)) {
 			used = shint->used;
@@ -1528,7 +1528,7 @@ int btrfs_dec_ref(struct btrfs_trans_handle *trans, struct btrfs_root *root,
 
 static int write_one_cache_group(struct btrfs_trans_handle *trans,
 				 struct btrfs_path *path,
-				 struct btrfs_block_group_cache *cache)
+				 struct btrfs_block_group *cache)
 {
 	int ret;
 	struct btrfs_root *extent_root = trans->fs_info->extent_root;
@@ -1564,7 +1564,7 @@ fail:
 
 int btrfs_write_dirty_block_groups(struct btrfs_trans_handle *trans)
 {
-	struct btrfs_block_group_cache *cache;
+	struct btrfs_block_group *cache;
 	struct btrfs_path *path;
 	int ret = 0;
 
@@ -1574,7 +1574,7 @@ int btrfs_write_dirty_block_groups(struct btrfs_trans_handle *trans)
 
 	while (!list_empty(&trans->dirty_bgs)) {
 		cache = list_first_entry(&trans->dirty_bgs,
-				 struct btrfs_block_group_cache, dirty_list);
+				 struct btrfs_block_group, dirty_list);
 		list_del_init(&cache->dirty_list);
 		ret = write_one_cache_group(trans, path, cache);
 		if (ret)
@@ -1744,7 +1744,7 @@ static int update_block_group(struct btrfs_trans_handle *trans, u64 bytenr,
 			      u64 num_bytes, int alloc, int mark_free)
 {
 	struct btrfs_fs_info *info = trans->fs_info;
-	struct btrfs_block_group_cache *cache;
+	struct btrfs_block_group *cache;
 	u64 total = num_bytes;
 	u64 old_val;
 	u64 byte_in_group;
@@ -1791,7 +1791,7 @@ static int update_pinned_extents(struct btrfs_fs_info *fs_info,
 				u64 bytenr, u64 num, int pin)
 {
 	u64 len;
-	struct btrfs_block_group_cache *cache;
+	struct btrfs_block_group *cache;
 
 	if (pin) {
 		set_extent_dirty(&fs_info->pinned_extents,
@@ -2178,7 +2178,7 @@ static int noinline find_free_extent(struct btrfs_trans_handle *trans,
 	struct btrfs_root * root = orig_root->fs_info->extent_root;
 	struct btrfs_fs_info *info = root->fs_info;
 	u64 total_needed = num_bytes;
-	struct btrfs_block_group_cache *block_group;
+	struct btrfs_block_group *block_group;
 	int full_scan = 0;
 	int wrapped = 0;
 
@@ -2251,7 +2251,7 @@ check_failed:
 
 	if (!(data & BTRFS_BLOCK_GROUP_DATA)) {
 		if (check_crossing_stripes(info, ins->objectid, num_bytes)) {
-			struct btrfs_block_group_cache *bg_cache;
+			struct btrfs_block_group *bg_cache;
 			u64 bg_offset;
 
 			bg_cache = btrfs_lookup_block_group(info, ins->objectid);
@@ -2551,7 +2551,7 @@ struct extent_buffer *btrfs_alloc_free_block(struct btrfs_trans_handle *trans,
 int btrfs_free_block_groups(struct btrfs_fs_info *info)
 {
 	struct btrfs_space_info *sinfo;
-	struct btrfs_block_group_cache *cache, *next;
+	struct btrfs_block_group *cache, *next;
 	u64 start;
 	u64 end;
 	int ret;
@@ -2641,7 +2641,7 @@ static int read_one_block_group(struct btrfs_fs_info *fs_info,
 {
 	struct extent_buffer *leaf = path->nodes[0];
 	struct btrfs_space_info *space_info;
-	struct btrfs_block_group_cache *cache;
+	struct btrfs_block_group *cache;
 	struct btrfs_block_group_item bgi;
 	struct btrfs_key key;
 	int slot = path->slots[0];
@@ -2733,12 +2733,12 @@ error:
 	return ret;
 }
 
-struct btrfs_block_group_cache *
+struct btrfs_block_group *
 btrfs_add_block_group(struct btrfs_fs_info *fs_info, u64 bytes_used, u64 type,
 		      u64 chunk_offset, u64 size)
 {
 	int ret;
-	struct btrfs_block_group_cache *cache;
+	struct btrfs_block_group *cache;
 
 	cache = kzalloc(sizeof(*cache), GFP_NOFS);
 	BUG_ON(!cache);
@@ -2767,7 +2767,7 @@ int btrfs_make_block_group(struct btrfs_trans_handle *trans,
 {
 	int ret;
 	struct btrfs_root *extent_root = fs_info->extent_root;
-	struct btrfs_block_group_cache *cache;
+	struct btrfs_block_group *cache;
 	struct btrfs_block_group_item bgi;
 	struct btrfs_key key;
 
@@ -2805,7 +2805,7 @@ int btrfs_make_block_groups(struct btrfs_trans_handle *trans,
 	u64 total_metadata = 0;
 	int ret;
 	struct btrfs_root *extent_root = fs_info->extent_root;
-	struct btrfs_block_group_cache *cache;
+	struct btrfs_block_group *cache;
 
 	total_bytes = btrfs_super_total_bytes(fs_info->super_copy);
 	group_align = 64 * fs_info->sectorsize;
@@ -3112,7 +3112,7 @@ static int free_block_group_cache(struct btrfs_trans_handle *trans,
 				  struct btrfs_fs_info *fs_info,
 				  u64 bytenr, u64 len)
 {
-	struct btrfs_block_group_cache *cache;
+	struct btrfs_block_group *cache;
 	struct cache_extent *ce;
 	struct map_lookup *map;
 	int ret;
@@ -3251,7 +3251,7 @@ int btrfs_fix_block_accounting(struct btrfs_trans_handle *trans)
 	struct btrfs_path path;
 	struct btrfs_key key;
 	struct extent_buffer *leaf;
-	struct btrfs_block_group_cache *cache;
+	struct btrfs_block_group *cache;
 	struct btrfs_fs_info *fs_info = trans->fs_info;
 	struct btrfs_root *root = fs_info->extent_root;
 
@@ -3546,7 +3546,7 @@ static int add_excluded_extent(struct btrfs_fs_info *fs_info,
 }
 
 void free_excluded_extents(struct btrfs_fs_info *fs_info,
-			   struct btrfs_block_group_cache *cache)
+			   struct btrfs_block_group *cache)
 {
 	u64 start, end;
 
@@ -3558,7 +3558,7 @@ void free_excluded_extents(struct btrfs_fs_info *fs_info,
 }
 
 int exclude_super_stripes(struct btrfs_fs_info *fs_info,
-			  struct btrfs_block_group_cache *cache)
+			  struct btrfs_block_group *cache)
 {
 	u64 bytenr;
 	u64 *logical;
@@ -3611,7 +3611,7 @@ int exclude_super_stripes(struct btrfs_fs_info *fs_info,
 	return 0;
 }
 
-u64 add_new_free_space(struct btrfs_block_group_cache *block_group,
+u64 add_new_free_space(struct btrfs_block_group *block_group,
 		       struct btrfs_fs_info *info, u64 start, u64 end)
 {
 	u64 extent_start, extent_end, size, total_added = 0;
diff --git a/free-space-cache.c b/free-space-cache.c
index 1523dbed018a..a9e0f8dd2e9e 100644
--- a/free-space-cache.c
+++ b/free-space-cache.c
@@ -432,7 +432,7 @@ free_cache:
 }
 
 int load_free_space_cache(struct btrfs_fs_info *fs_info,
-			  struct btrfs_block_group_cache *block_group)
+			  struct btrfs_block_group *block_group)
 {
 	struct btrfs_free_space_ctl *ctl = block_group->free_space_ctl;
 	struct btrfs_path *path;
@@ -766,7 +766,7 @@ static void try_merge_free_space(struct btrfs_free_space_ctl *ctl,
 	}
 }
 
-void btrfs_dump_free_space(struct btrfs_block_group_cache *block_group,
+void btrfs_dump_free_space(struct btrfs_block_group *block_group,
 			   u64 bytes)
 {
 	struct btrfs_free_space_ctl *ctl = block_group->free_space_ctl;
@@ -786,7 +786,7 @@ void btrfs_dump_free_space(struct btrfs_block_group_cache *block_group,
 	printk("%d blocks of free space at or bigger than bytes is \n", count);
 }
 
-int btrfs_init_free_space_ctl(struct btrfs_block_group_cache *block_group,
+int btrfs_init_free_space_ctl(struct btrfs_block_group *block_group,
 			      int sectorsize)
 {
 	struct btrfs_free_space_ctl *ctl;
@@ -817,7 +817,7 @@ void __btrfs_remove_free_space_cache(struct btrfs_free_space_ctl *ctl)
 	}
 }
 
-void btrfs_remove_free_space_cache(struct btrfs_block_group_cache *block_group)
+void btrfs_remove_free_space_cache(struct btrfs_block_group *block_group)
 {
 	__btrfs_remove_free_space_cache(block_group->free_space_ctl);
 }
@@ -896,7 +896,7 @@ next:
 }
 
 int btrfs_clear_free_space_cache(struct btrfs_fs_info *fs_info,
-				 struct btrfs_block_group_cache *bg)
+				 struct btrfs_block_group *bg)
 {
 	struct btrfs_trans_handle *trans;
 	struct btrfs_root *tree_root = fs_info->tree_root;
diff --git a/free-space-cache.h b/free-space-cache.h
index fb552cfd9e98..36ce29933c37 100644
--- a/free-space-cache.h
+++ b/free-space-cache.h
@@ -44,21 +44,19 @@ struct btrfs_free_space_ctl {
 };
 
 int load_free_space_cache(struct btrfs_fs_info *fs_info,
-			  struct btrfs_block_group_cache *block_group);
+			  struct btrfs_block_group *block_group);
 
 void __btrfs_remove_free_space_cache(struct btrfs_free_space_ctl *ctl);
-void btrfs_remove_free_space_cache(struct btrfs_block_group_cache
-				     *block_group);
-void btrfs_dump_free_space(struct btrfs_block_group_cache *block_group,
-			   u64 bytes);
+void btrfs_remove_free_space_cache(struct btrfs_block_group *block_group);
+void btrfs_dump_free_space(struct btrfs_block_group *block_group, u64 bytes);
 struct btrfs_free_space *
 btrfs_find_free_space(struct btrfs_free_space_ctl *ctl, u64 offset, u64 bytes);
-int btrfs_init_free_space_ctl(struct btrfs_block_group_cache *block_group,
+int btrfs_init_free_space_ctl(struct btrfs_block_group *block_group,
 			      int sectorsize);
 void unlink_free_space(struct btrfs_free_space_ctl *ctl,
 		       struct btrfs_free_space *info);
 int btrfs_add_free_space(struct btrfs_free_space_ctl *ctl, u64 offset,
 			 u64 bytes);
 int btrfs_clear_free_space_cache(struct btrfs_fs_info *fs_info,
-				 struct btrfs_block_group_cache *bg);
+				 struct btrfs_block_group *bg);
 #endif
diff --git a/image/main.c b/image/main.c
index 0d286b8f2ad9..10f6182e0eac 100644
--- a/image/main.c
+++ b/image/main.c
@@ -2341,7 +2341,7 @@ again:
 static void fixup_block_groups(struct btrfs_trans_handle *trans)
 {
 	struct btrfs_fs_info *fs_info = trans->fs_info;
-	struct btrfs_block_group_cache *bg;
+	struct btrfs_block_group *bg;
 	struct btrfs_mapping_tree *map_tree = &fs_info->mapping_tree;
 	struct cache_extent *ce;
 	struct map_lookup *map;
diff --git a/kernel-shared/free-space-tree.c b/kernel-shared/free-space-tree.c
index 6ed5b76a03d9..5ca237722965 100644
--- a/kernel-shared/free-space-tree.c
+++ b/kernel-shared/free-space-tree.c
@@ -28,7 +28,7 @@
 static struct btrfs_free_space_info *
 search_free_space_info(struct btrfs_trans_handle *trans,
 		       struct btrfs_fs_info *fs_info,
-		       struct btrfs_block_group_cache *block_group,
+		       struct btrfs_block_group *block_group,
 		       struct btrfs_path *path, int cow)
 {
 	struct btrfs_root *root = fs_info->free_space_root;
@@ -49,7 +49,7 @@ search_free_space_info(struct btrfs_trans_handle *trans,
 			      struct btrfs_free_space_info);
 }
 
-static int free_space_test_bit(struct btrfs_block_group_cache *block_group,
+static int free_space_test_bit(struct btrfs_block_group *block_group,
 			       struct btrfs_path *path, u64 offset)
 {
 	struct extent_buffer *leaf;
@@ -100,7 +100,7 @@ static int btrfs_search_prev_slot(struct btrfs_trans_handle *trans,
 }
 
 static int add_new_free_space_info(struct btrfs_trans_handle *trans,
-				   struct btrfs_block_group_cache *block_group,
+				   struct btrfs_block_group *block_group,
 				   struct btrfs_path *path)
 {
 	struct btrfs_root *root = trans->fs_info->free_space_root;
@@ -175,7 +175,7 @@ static void le_bitmap_set(unsigned long *map, unsigned int start, int len)
 }
 
 static int convert_free_space_to_bitmaps(struct btrfs_trans_handle *trans,
-				  struct btrfs_block_group_cache *block_group,
+				  struct btrfs_block_group *block_group,
 				  struct btrfs_path *path)
 {
 	struct btrfs_fs_info *fs_info = trans->fs_info;
@@ -314,7 +314,7 @@ out:
 }
 
 static int convert_free_space_to_extents(struct btrfs_trans_handle *trans,
-				  struct btrfs_block_group_cache *block_group,
+				  struct btrfs_block_group *block_group,
 				  struct btrfs_path *path)
 {
 	struct btrfs_fs_info *fs_info = trans->fs_info;
@@ -447,7 +447,7 @@ out:
 }
 
 static int update_free_space_extent_count(struct btrfs_trans_handle *trans,
-					  struct btrfs_block_group_cache *block_group,
+					  struct btrfs_block_group *block_group,
 					  struct btrfs_path *path,
 					  int new_extents)
 {
@@ -487,7 +487,7 @@ out:
 }
 
 
-static void free_space_set_bits(struct btrfs_block_group_cache *block_group,
+static void free_space_set_bits(struct btrfs_block_group *block_group,
 				struct btrfs_path *path, u64 *start, u64 *size,
 				int bit)
 {
@@ -554,7 +554,7 @@ static int free_space_next_bitmap(struct btrfs_trans_handle *trans,
  * the bitmap.
  */
 static int modify_free_space_bitmap(struct btrfs_trans_handle *trans,
-				    struct btrfs_block_group_cache *block_group,
+				    struct btrfs_block_group *block_group,
 				    struct btrfs_path *path,
 				    u64 start, u64 size, int remove)
 {
@@ -667,7 +667,7 @@ out:
 }
 
 static int remove_free_space_extent(struct btrfs_trans_handle *trans,
-				    struct btrfs_block_group_cache *block_group,
+				    struct btrfs_block_group *block_group,
 				    struct btrfs_path *path,
 				    u64 start, u64 size)
 {
@@ -753,7 +753,7 @@ out:
 }
 
 static int __remove_from_free_space_tree(struct btrfs_trans_handle *trans,
-				  struct btrfs_block_group_cache *block_group,
+				  struct btrfs_block_group *block_group,
 				  struct btrfs_path *path, u64 start, u64 size)
 {
 	struct btrfs_free_space_info *info;
@@ -777,7 +777,7 @@ static int __remove_from_free_space_tree(struct btrfs_trans_handle *trans,
 int remove_from_free_space_tree(struct btrfs_trans_handle *trans, u64 start,
 		u64 size)
 {
-	struct btrfs_block_group_cache *block_group;
+	struct btrfs_block_group *block_group;
 	struct btrfs_path *path;
 	int ret;
 
@@ -807,7 +807,7 @@ out:
 }
 
 static int add_free_space_extent(struct btrfs_trans_handle *trans,
-				 struct btrfs_block_group_cache *block_group,
+				 struct btrfs_block_group *block_group,
 				 struct btrfs_path *path,
 				 u64 start, u64 size)
 {
@@ -933,7 +933,7 @@ out:
 }
 
 static int __add_to_free_space_tree(struct btrfs_trans_handle *trans,
-			     struct btrfs_block_group_cache *block_group,
+			     struct btrfs_block_group *block_group,
 			     struct btrfs_path *path, u64 start, u64 size)
 {
 	struct btrfs_fs_info *fs_info = trans->fs_info;
@@ -958,7 +958,7 @@ static int __add_to_free_space_tree(struct btrfs_trans_handle *trans,
 int add_to_free_space_tree(struct btrfs_trans_handle *trans, u64 start,
 		u64 size)
 {
-	struct btrfs_block_group_cache *block_group;
+	struct btrfs_block_group *block_group;
 	struct btrfs_path *path;
 	int ret;
 
@@ -987,7 +987,7 @@ out:
 }
 
 int populate_free_space_tree(struct btrfs_trans_handle *trans,
-			     struct btrfs_block_group_cache *block_group)
+			     struct btrfs_block_group *block_group)
 {
 	struct btrfs_root *extent_root = trans->fs_info->extent_root;
 	struct btrfs_path *path, *path2;
@@ -1074,7 +1074,7 @@ out:
 }
 
 int remove_block_group_free_space(struct btrfs_trans_handle *trans,
-				  struct btrfs_block_group_cache *block_group)
+				  struct btrfs_block_group *block_group)
 {
 	struct btrfs_root *root = trans->fs_info->free_space_root;
 	struct btrfs_path *path;
@@ -1227,7 +1227,7 @@ abort:
 }
 
 static int load_free_space_bitmaps(struct btrfs_fs_info *fs_info,
-				   struct btrfs_block_group_cache *block_group,
+				   struct btrfs_block_group *block_group,
 				   struct btrfs_path *path,
 				   u32 expected_extent_count,
 				   int *errors)
@@ -1307,7 +1307,7 @@ out:
 }
 
 static int load_free_space_extents(struct btrfs_fs_info *fs_info,
-				   struct btrfs_block_group_cache *block_group,
+				   struct btrfs_block_group *block_group,
 				   struct btrfs_path *path,
 				   u32 expected_extent_count,
 				   int *errors)
@@ -1418,7 +1418,7 @@ int btrfs_create_free_space_tree(struct btrfs_fs_info *fs_info)
 	struct btrfs_trans_handle *trans;
 	struct btrfs_root *tree_root = fs_info->tree_root;
 	struct btrfs_root *free_space_root;
-	struct btrfs_block_group_cache *block_group;
+	struct btrfs_block_group *block_group;
 	u64 start = BTRFS_SUPER_INFO_OFFSET + BTRFS_SUPER_INFO_SIZE;
 	int ret;
 
@@ -1459,7 +1459,7 @@ abort:
 }
 
 int load_free_space_tree(struct btrfs_fs_info *fs_info,
-			 struct btrfs_block_group_cache *block_group)
+			 struct btrfs_block_group *block_group)
 {
 	struct btrfs_free_space_info *info;
 	struct btrfs_path *path;
diff --git a/kernel-shared/free-space-tree.h b/kernel-shared/free-space-tree.h
index 1af12a81022a..3d32e167fd58 100644
--- a/kernel-shared/free-space-tree.h
+++ b/kernel-shared/free-space-tree.h
@@ -24,11 +24,11 @@
 
 int btrfs_clear_free_space_tree(struct btrfs_fs_info *fs_info);
 int load_free_space_tree(struct btrfs_fs_info *fs_info,
-			 struct btrfs_block_group_cache *block_group);
+			 struct btrfs_block_group *block_group);
 int populate_free_space_tree(struct btrfs_trans_handle *trans,
-			     struct btrfs_block_group_cache *block_group);
+			     struct btrfs_block_group *block_group);
 int remove_block_group_free_space(struct btrfs_trans_handle *trans,
-				  struct btrfs_block_group_cache *block_group);
+				  struct btrfs_block_group *block_group);
 int add_to_free_space_tree(struct btrfs_trans_handle *trans, u64 start,
 			   u64 size);
 int remove_from_free_space_tree(struct btrfs_trans_handle *trans, u64 start,
diff --git a/mkfs/main.c b/mkfs/main.c
index 5f7b693749b3..89f3877fa3b2 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -680,7 +680,7 @@ out:
 static void update_chunk_allocation(struct btrfs_fs_info *fs_info,
 				    struct mkfs_allocation *allocation)
 {
-	struct btrfs_block_group_cache *bg_cache;
+	struct btrfs_block_group *bg_cache;
 	const u64 mixed_flag = BTRFS_BLOCK_GROUP_DATA | BTRFS_BLOCK_GROUP_METADATA;
 	u64 search_start = 0;
 
diff --git a/transaction.h b/transaction.h
index c9ea545aca07..f2c96b17374f 100644
--- a/transaction.h
+++ b/transaction.h
@@ -34,7 +34,7 @@ struct btrfs_trans_handle {
 	u64 delayed_ref_updates;
 	unsigned long blocks_reserved;
 	unsigned long blocks_used;
-	struct btrfs_block_group_cache *block_group;
+	struct btrfs_block_group *block_group;
 	struct btrfs_delayed_ref_root delayed_refs;
 	struct list_head dirty_bgs;
 };
diff --git a/volumes.h b/volumes.h
index 2387e088ab5d..31c756607735 100644
--- a/volumes.h
+++ b/volumes.h
@@ -206,7 +206,7 @@ static inline enum btrfs_raid_types btrfs_bg_flags_to_raid_index(u64 flags)
 static inline int check_crossing_stripes(struct btrfs_fs_info *fs_info,
 					 u64 start, u64 len)
 {
-	struct btrfs_block_group_cache *bg_cache;
+	struct btrfs_block_group *bg_cache;
 	u64 bg_offset;
 
 	bg_cache = btrfs_lookup_block_group(fs_info, start);
-- 
2.26.2

