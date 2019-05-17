Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1806721666
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 May 2019 11:42:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728982AbfEQJmU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 May 2019 05:42:20 -0400
Received: from mx2.suse.de ([195.135.220.15]:33278 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727338AbfEQJmU (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 May 2019 05:42:20 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 62D9DAEDB
        for <linux-btrfs@vger.kernel.org>; Fri, 17 May 2019 09:42:18 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id EEEDEDA871; Fri, 17 May 2019 11:43:17 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 03/15] btrfs: remove mapping tree structures indirection
Date:   Fri, 17 May 2019 11:43:17 +0200
Message-Id: <36516fe5118e1d4ee3ae930b41bbbbc67c32c94b.1558085801.git.dsterba@suse.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1558085801.git.dsterba@suse.com>
References: <cover.1558085801.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

fs_info::mapping_tree is the physical<->logical mapping tree and uses
the same underlying structure as extents, but is embedded to another
structure. There are no other members and this indirection is useless.
No functional change.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/ctree.h            |  6 +----
 fs/btrfs/dev-replace.c      |  2 +-
 fs/btrfs/disk-io.c          |  2 +-
 fs/btrfs/extent-tree.c      | 14 +++++-----
 fs/btrfs/free-space-cache.c |  2 +-
 fs/btrfs/scrub.c            |  8 +++---
 fs/btrfs/volumes.c          | 53 +++++++++++++++++--------------------
 fs/btrfs/volumes.h          |  3 +--
 8 files changed, 40 insertions(+), 50 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 0a61dff27f57..a2130cf0e03b 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -99,10 +99,6 @@ static inline u32 count_max_extents(u64 size)
 	return div_u64(size + BTRFS_MAX_EXTENT_SIZE - 1, BTRFS_MAX_EXTENT_SIZE);
 }
 
-struct btrfs_mapping_tree {
-	struct extent_map_tree map_tree;
-};
-
 static inline unsigned long btrfs_chunk_item_size(int num_stripes)
 {
 	BUG_ON(num_stripes == 0);
@@ -824,7 +820,7 @@ struct btrfs_fs_info {
 	struct extent_io_tree *pinned_extents;
 
 	/* logical->physical extent mapping */
-	struct btrfs_mapping_tree mapping_tree;
+	struct extent_map_tree mapping_tree;
 
 	/*
 	 * block reservation for extent, checksum, root tree and
diff --git a/fs/btrfs/dev-replace.c b/fs/btrfs/dev-replace.c
index 55c15f31d00d..6cda52203171 100644
--- a/fs/btrfs/dev-replace.c
+++ b/fs/btrfs/dev-replace.c
@@ -713,7 +713,7 @@ static void btrfs_dev_replace_update_device_in_mapping_tree(
 						struct btrfs_device *srcdev,
 						struct btrfs_device *tgtdev)
 {
-	struct extent_map_tree *em_tree = &fs_info->mapping_tree.map_tree;
+	struct extent_map_tree *em_tree = &fs_info->mapping_tree;
 	struct extent_map *em;
 	struct map_lookup *map;
 	u64 start = 0;
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index deb74a8c191a..cdd6e7ee76b6 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -2689,7 +2689,7 @@ int open_ctree(struct super_block *sb,
 	INIT_LIST_HEAD(&fs_info->space_info);
 	INIT_LIST_HEAD(&fs_info->tree_mod_seq_list);
 	INIT_LIST_HEAD(&fs_info->unused_bgs);
-	btrfs_mapping_init(&fs_info->mapping_tree);
+	extent_map_tree_init(&fs_info->mapping_tree);
 	btrfs_init_block_rsv(&fs_info->global_block_rsv,
 			     BTRFS_BLOCK_RSV_GLOBAL);
 	btrfs_init_block_rsv(&fs_info->trans_block_rsv, BTRFS_BLOCK_RSV_TRANS);
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index f79e477a378e..12889a7a1bb1 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -9948,7 +9948,7 @@ static int find_first_block_group(struct btrfs_fs_info *fs_info,
 			struct extent_map_tree *em_tree;
 			struct extent_map *em;
 
-			em_tree = &root->fs_info->mapping_tree.map_tree;
+			em_tree = &root->fs_info->mapping_tree;
 			read_lock(&em_tree->lock);
 			em = lookup_extent_mapping(em_tree, found_key.objectid,
 						   found_key.offset);
@@ -10242,21 +10242,21 @@ btrfs_create_block_group_cache(struct btrfs_fs_info *fs_info,
  */
 static int check_chunk_block_group_mappings(struct btrfs_fs_info *fs_info)
 {
-	struct btrfs_mapping_tree *map_tree = &fs_info->mapping_tree;
+	struct extent_map_tree *map_tree = &fs_info->mapping_tree;
 	struct extent_map *em;
 	struct btrfs_block_group_cache *bg;
 	u64 start = 0;
 	int ret = 0;
 
 	while (1) {
-		read_lock(&map_tree->map_tree.lock);
+		read_lock(&map_tree->lock);
 		/*
 		 * lookup_extent_mapping will return the first extent map
 		 * intersecting the range, so setting @len to 1 is enough to
 		 * get the first chunk.
 		 */
-		em = lookup_extent_mapping(&map_tree->map_tree, start, 1);
-		read_unlock(&map_tree->map_tree.lock);
+		em = lookup_extent_mapping(map_tree, start, 1);
+		read_unlock(&map_tree->lock);
 		if (!em)
 			break;
 
@@ -10833,7 +10833,7 @@ int btrfs_remove_block_group(struct btrfs_trans_handle *trans,
 	if (remove_em) {
 		struct extent_map_tree *em_tree;
 
-		em_tree = &fs_info->mapping_tree.map_tree;
+		em_tree = &fs_info->mapping_tree;
 		write_lock(&em_tree->lock);
 		remove_extent_mapping(em_tree, em);
 		write_unlock(&em_tree->lock);
@@ -10868,7 +10868,7 @@ struct btrfs_trans_handle *
 btrfs_start_trans_remove_block_group(struct btrfs_fs_info *fs_info,
 				     const u64 chunk_offset)
 {
-	struct extent_map_tree *em_tree = &fs_info->mapping_tree.map_tree;
+	struct extent_map_tree *em_tree = &fs_info->mapping_tree;
 	struct extent_map *em;
 	struct map_lookup *map;
 	unsigned int num_items;
diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index f74dc259307b..c2f6ea14d74a 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -3358,7 +3358,7 @@ void btrfs_put_block_group_trimming(struct btrfs_block_group_cache *block_group)
 
 	if (cleanup) {
 		mutex_lock(&fs_info->chunk_mutex);
-		em_tree = &fs_info->mapping_tree.map_tree;
+		em_tree = &fs_info->mapping_tree;
 		write_lock(&em_tree->lock);
 		em = lookup_extent_mapping(em_tree, block_group->key.objectid,
 					   1);
diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index f7b29f9db5e2..0827bdf4faf1 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -3410,15 +3410,15 @@ static noinline_for_stack int scrub_chunk(struct scrub_ctx *sctx,
 					  struct btrfs_block_group_cache *cache)
 {
 	struct btrfs_fs_info *fs_info = sctx->fs_info;
-	struct btrfs_mapping_tree *map_tree = &fs_info->mapping_tree;
+	struct extent_map_tree *map_tree = &fs_info->mapping_tree;
 	struct map_lookup *map;
 	struct extent_map *em;
 	int i;
 	int ret = 0;
 
-	read_lock(&map_tree->map_tree.lock);
-	em = lookup_extent_mapping(&map_tree->map_tree, chunk_offset, 1);
-	read_unlock(&map_tree->map_tree.lock);
+	read_lock(&map_tree->lock);
+	em = lookup_extent_mapping(map_tree, chunk_offset, 1);
+	read_unlock(&map_tree->lock);
 
 	if (!em) {
 		/*
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 10f7de0cc7e6..a3fa741c8534 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -1818,7 +1818,7 @@ static u64 find_next_chunk(struct btrfs_fs_info *fs_info)
 	struct rb_node *n;
 	u64 ret = 0;
 
-	em_tree = &fs_info->mapping_tree.map_tree;
+	em_tree = &fs_info->mapping_tree;
 	read_lock(&em_tree->lock);
 	n = rb_last(&em_tree->map.rb_root);
 	if (n) {
@@ -2941,7 +2941,7 @@ struct extent_map *btrfs_get_chunk_map(struct btrfs_fs_info *fs_info,
 	struct extent_map_tree *em_tree;
 	struct extent_map *em;
 
-	em_tree = &fs_info->mapping_tree.map_tree;
+	em_tree = &fs_info->mapping_tree;
 	read_lock(&em_tree->lock);
 	em = lookup_extent_mapping(em_tree, logical, length);
 	read_unlock(&em_tree->lock);
@@ -5144,7 +5144,7 @@ static int __btrfs_alloc_chunk(struct btrfs_trans_handle *trans,
 	em->block_len = em->len;
 	em->orig_block_len = stripe_size;
 
-	em_tree = &info->mapping_tree.map_tree;
+	em_tree = &info->mapping_tree;
 	write_lock(&em_tree->lock);
 	ret = add_extent_mapping(em_tree, em, 0);
 	if (ret) {
@@ -5378,21 +5378,16 @@ int btrfs_chunk_readonly(struct btrfs_fs_info *fs_info, u64 chunk_offset)
 	return readonly;
 }
 
-void btrfs_mapping_init(struct btrfs_mapping_tree *tree)
-{
-	extent_map_tree_init(&tree->map_tree);
-}
-
-void btrfs_mapping_tree_free(struct btrfs_mapping_tree *tree)
+void btrfs_mapping_tree_free(struct extent_map_tree *tree)
 {
 	struct extent_map *em;
 
 	while (1) {
-		write_lock(&tree->map_tree.lock);
-		em = lookup_extent_mapping(&tree->map_tree, 0, (u64)-1);
+		write_lock(&tree->lock);
+		em = lookup_extent_mapping(tree, 0, (u64)-1);
 		if (em)
-			remove_extent_mapping(&tree->map_tree, em);
-		write_unlock(&tree->map_tree.lock);
+			remove_extent_mapping(tree, em);
+		write_unlock(&tree->lock);
 		if (!em)
 			break;
 		/* once for us */
@@ -6687,7 +6682,7 @@ static int read_one_chunk(struct btrfs_key *key, struct extent_buffer *leaf,
 			  struct btrfs_chunk *chunk)
 {
 	struct btrfs_fs_info *fs_info = leaf->fs_info;
-	struct btrfs_mapping_tree *map_tree = &fs_info->mapping_tree;
+	struct extent_map_tree *map_tree = &fs_info->mapping_tree;
 	struct map_lookup *map;
 	struct extent_map *em;
 	u64 logical;
@@ -6712,9 +6707,9 @@ static int read_one_chunk(struct btrfs_key *key, struct extent_buffer *leaf,
 			return ret;
 	}
 
-	read_lock(&map_tree->map_tree.lock);
-	em = lookup_extent_mapping(&map_tree->map_tree, logical, 1);
-	read_unlock(&map_tree->map_tree.lock);
+	read_lock(&map_tree->lock);
+	em = lookup_extent_mapping(map_tree, logical, 1);
+	read_unlock(&map_tree->lock);
 
 	/* already mapped? */
 	if (em && em->start <= logical && em->start + em->len > logical) {
@@ -6783,9 +6778,9 @@ static int read_one_chunk(struct btrfs_key *key, struct extent_buffer *leaf,
 
 	}
 
-	write_lock(&map_tree->map_tree.lock);
-	ret = add_extent_mapping(&map_tree->map_tree, em, 0);
-	write_unlock(&map_tree->map_tree.lock);
+	write_lock(&map_tree->lock);
+	ret = add_extent_mapping(map_tree, em, 0);
+	write_unlock(&map_tree->lock);
 	if (ret < 0) {
 		btrfs_err(fs_info,
 			  "failed to add chunk map, start=%llu len=%llu: %d",
@@ -7103,14 +7098,14 @@ int btrfs_read_sys_array(struct btrfs_fs_info *fs_info)
 bool btrfs_check_rw_degradable(struct btrfs_fs_info *fs_info,
 					struct btrfs_device *failing_dev)
 {
-	struct btrfs_mapping_tree *map_tree = &fs_info->mapping_tree;
+	struct extent_map_tree *map_tree = &fs_info->mapping_tree;
 	struct extent_map *em;
 	u64 next_start = 0;
 	bool ret = true;
 
-	read_lock(&map_tree->map_tree.lock);
-	em = lookup_extent_mapping(&map_tree->map_tree, 0, (u64)-1);
-	read_unlock(&map_tree->map_tree.lock);
+	read_lock(&map_tree->lock);
+	em = lookup_extent_mapping(map_tree, 0, (u64)-1);
+	read_unlock(&map_tree->lock);
 	/* No chunk at all? Return false anyway */
 	if (!em) {
 		ret = false;
@@ -7148,10 +7143,10 @@ bool btrfs_check_rw_degradable(struct btrfs_fs_info *fs_info,
 		next_start = extent_map_end(em);
 		free_extent_map(em);
 
-		read_lock(&map_tree->map_tree.lock);
-		em = lookup_extent_mapping(&map_tree->map_tree, next_start,
+		read_lock(&map_tree->lock);
+		em = lookup_extent_mapping(map_tree, next_start,
 					   (u64)(-1) - next_start);
-		read_unlock(&map_tree->map_tree.lock);
+		read_unlock(&map_tree->lock);
 	}
 out:
 	return ret;
@@ -7612,7 +7607,7 @@ static int verify_one_dev_extent(struct btrfs_fs_info *fs_info,
 				 u64 chunk_offset, u64 devid,
 				 u64 physical_offset, u64 physical_len)
 {
-	struct extent_map_tree *em_tree = &fs_info->mapping_tree.map_tree;
+	struct extent_map_tree *em_tree = &fs_info->mapping_tree;
 	struct extent_map *em;
 	struct map_lookup *map;
 	struct btrfs_device *dev;
@@ -7701,7 +7696,7 @@ static int verify_one_dev_extent(struct btrfs_fs_info *fs_info,
 
 static int verify_chunk_dev_extent_mapping(struct btrfs_fs_info *fs_info)
 {
-	struct extent_map_tree *em_tree = &fs_info->mapping_tree.map_tree;
+	struct extent_map_tree *em_tree = &fs_info->mapping_tree;
 	struct extent_map *em;
 	struct rb_node *node;
 	int ret = 0;
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index 136a3eb64604..07156d974ac4 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -413,8 +413,7 @@ int btrfs_rmap_block(struct btrfs_fs_info *fs_info, u64 chunk_start,
 int btrfs_read_sys_array(struct btrfs_fs_info *fs_info);
 int btrfs_read_chunk_tree(struct btrfs_fs_info *fs_info);
 int btrfs_alloc_chunk(struct btrfs_trans_handle *trans, u64 type);
-void btrfs_mapping_init(struct btrfs_mapping_tree *tree);
-void btrfs_mapping_tree_free(struct btrfs_mapping_tree *tree);
+void btrfs_mapping_tree_free(struct extent_map_tree *tree);
 blk_status_t btrfs_map_bio(struct btrfs_fs_info *fs_info, struct bio *bio,
 			   int mirror_num, int async_submit);
 int btrfs_open_devices(struct btrfs_fs_devices *fs_devices,
-- 
2.21.0

