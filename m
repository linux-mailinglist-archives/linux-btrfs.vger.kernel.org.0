Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E998B113AD7
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Dec 2019 05:30:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728966AbfLEE36 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 4 Dec 2019 23:29:58 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:42398 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728374AbfLEE36 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 4 Dec 2019 23:29:58 -0500
Received: by mail-lj1-f196.google.com with SMTP id e28so1860944ljo.9
        for <linux-btrfs@vger.kernel.org>; Wed, 04 Dec 2019 20:29:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0Avc27aOeg+ZzuTSnDAeZo9DepxGHXQTs4ne2eOmewo=;
        b=J5DzMRGIYUhEJbzZ3SHRt5kyE7Xj0dYC2ozicxfb+s667H/zl65VD96wnTwQP1qBO5
         0Ry1cJnN9NugtmFTU0XWKVeqdVKPLpoOTz0WejnMRwQPiKHq00N5e/HgkC45IA7aMGF2
         M4wkgQpGD21oswXJbxPdqXILKUONTYoUyB763ffJtGjQRBsNmBJANRw5m4o3qdUZWHGF
         KxRl9VFY7duUqw2FD0fPDcbAp6lITlPZ7T/oZCHY8EKMSea4q/8WH10PAYSch4GhCf67
         wp/dKcxPpyCpaKvAJAtyA78ej+INsG/mXSyggPdKxWWiVd7xR/OHTQhkCdqnEDMXcptl
         Y4/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0Avc27aOeg+ZzuTSnDAeZo9DepxGHXQTs4ne2eOmewo=;
        b=nB8/HTQRvKXq6BTfe+LHNUvhztWHsbvQKA5H4hrqNRbSN7p/P6/RFmlgE6seXCA3kN
         NGvK9ciSwF7sxCvdAgBtgYDiNMl76Y1c8QVOvK0iaNKWxxP8AGMQlWBImPzeJFosNUiF
         Vd2RwpTOkVO6Q9ZXEpO+zApSN83T1B+PmgLzoewMOiIo2cclkSqxO5blVlT/CbPsqx+r
         tOT6KKsoOyHHGh8Kv6/Lmklt5xW3MvddssO6OxC+fBv95EwMeBytC7vthNnkrHfKA9aT
         r4WeMwgW3UvM+gFOIxn5gMSb+XpYeATqqtcKj8M7C7pgRPQoZi0oac6+CF/HTipfHMqX
         gj3A==
X-Gm-Message-State: APjAAAVjkkB0I6xLuaMvpf/9xoQRomnfSPxI4BIgaxi5hH019WfPTfu1
        GNjKB56uCC4kTrG/kQN9ujxI4QZTXw4=
X-Google-Smtp-Source: APXvYqwAuoJ8EN03ZtsqGLAqvmHSCH87HU37s3H1Dn/h0O/Etf7xTPgDRUhnwa0jlGQaQD+Jp0O1vA==
X-Received: by 2002:a05:651c:2011:: with SMTP id s17mr3907238ljo.43.1575520193693;
        Wed, 04 Dec 2019 20:29:53 -0800 (PST)
Received: from p.lan (95.246.92.34.bc.googleusercontent.com. [34.92.246.95])
        by smtp.gmail.com with ESMTPSA id c23sm4170865ljj.78.2019.12.04.20.29.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Dec 2019 20:29:53 -0800 (PST)
From:   damenly.su@gmail.com
X-Google-Original-From: Damenly_Su@gmx.com
To:     linux-btrfs@vger.kernel.org
Cc:     Su Yue <Damenly_Su@gmx.com>
Subject: [PATCH 09/10] btrfs-progs: refrom block groups caches structure
Date:   Thu,  5 Dec 2019 12:29:20 +0800
Message-Id: <20191205042921.25316-10-Damenly_Su@gmx.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122.2)
In-Reply-To: <20191205042921.25316-1-Damenly_Su@gmx.com>
References: <20191205042921.25316-1-Damenly_Su@gmx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Su Yue <Damenly_Su@gmx.com>

This commit organises block groups cache in
btrfs_fs_info::block_group_cache_tree. And any dirty block groups are
linked in transaction_handle::dirty_bgs.

To keep coherence of bisect, it does almost replace in place:
1. Replace the old btrfs group lookup functions with new functions
introduced in former commits.
2. set_extent_bits(..., BLOCK_GROUP_DIRYT) things are replaced by linking
the block group cache into trans::dirty_bgs. Checking and clearing bits
are transformed too.
3. set_extent_bits(..., bit | EXTENT_LOCKED) things are replaced by
new the btrfs_add_block_group_cache() which inserts caches into
btrfs_fs_info::block_group_cache_tree directly. Other operations are
converted to tree operations.

Signed-off-by: Su Yue <Damenly_Su@gmx.com>
---
 cmds/rescue-chunk-recover.c |   4 +-
 extent-tree.c               | 211 ++++++------------------------------
 image/main.c                |   5 +-
 transaction.c               |   3 +-
 4 files changed, 38 insertions(+), 185 deletions(-)

diff --git a/cmds/rescue-chunk-recover.c b/cmds/rescue-chunk-recover.c
index 461b66c6e13b..a13acc015d11 100644
--- a/cmds/rescue-chunk-recover.c
+++ b/cmds/rescue-chunk-recover.c
@@ -1100,8 +1100,8 @@ static int block_group_free_all_extent(struct btrfs_trans_handle *trans,
 	start = cache->key.objectid;
 	end = start + cache->key.offset - 1;
 
-	set_extent_bits(&info->block_group_cache, start, end,
-			BLOCK_GROUP_DIRTY);
+	if (list_empty(&cache->dirty_list))
+		list_add_tail(&cache->dirty_list, &trans->dirty_bgs);
 	set_extent_dirty(&info->free_space_cache, start, end);
 
 	cache->used = 0;
diff --git a/extent-tree.c b/extent-tree.c
index f012fd5bf6b6..e227c4db51cf 100644
--- a/extent-tree.c
+++ b/extent-tree.c
@@ -164,31 +164,10 @@ err:
 	return 0;
 }
 
-static int btrfs_add_block_group_cache(struct btrfs_fs_info *info,
-				       struct btrfs_block_group_cache *cache,
-				       int bits)
-{
-	int ret;
-
-	ret = set_extent_bits(&info->block_group_cache, cache->key.objectid,
-			      cache->key.objectid + cache->key.offset - 1,
-			      bits);
-	if (ret)
-		return ret;
-
-	ret = set_state_private(&info->block_group_cache, cache->key.objectid,
-				(unsigned long)cache);
-	if (ret)
-		clear_extent_bits(&info->block_group_cache, cache->key.objectid,
-				  cache->key.objectid + cache->key.offset - 1,
-				  bits);
-	return ret;
-}
-
 /*
  * This adds the block group to the fs_info rb tree for the block group cache
  */
-static int btrfs_add_block_group_cache_kernel(struct btrfs_fs_info *info,
+static int btrfs_add_block_group_cache(struct btrfs_fs_info *info,
 				struct btrfs_block_group_cache *block_group)
 {
 	struct rb_node **p;
@@ -267,7 +246,7 @@ static struct btrfs_block_group_cache *block_group_cache_tree_search(
  * Return the block group that contains @bytenr, otherwise return the next one
  * that starts after @bytenr
  */
-struct btrfs_block_group_cache *btrfs_lookup_first_block_group_kernel(
+struct btrfs_block_group_cache *btrfs_lookup_first_block_group(
 		struct btrfs_fs_info *info, u64 bytenr)
 {
 	return block_group_cache_tree_search(info, bytenr, 2);
@@ -276,78 +255,12 @@ struct btrfs_block_group_cache *btrfs_lookup_first_block_group_kernel(
 /*
  * Return the block group that contains the given bytenr
  */
-struct btrfs_block_group_cache *btrfs_lookup_block_group_kernel(
+struct btrfs_block_group_cache *btrfs_lookup_block_group(
 		struct btrfs_fs_info *info, u64 bytenr)
 {
 	return block_group_cache_tree_search(info, bytenr, 1);
 }
 
-/*
- * Return the block group that contains @bytenr, otherwise return the next one
- * that starts after @bytenr
- */
-struct btrfs_block_group_cache *btrfs_lookup_first_block_group(struct
-						       btrfs_fs_info *info,
-						       u64 bytenr)
-{
-	struct extent_io_tree *block_group_cache;
-	struct btrfs_block_group_cache *block_group = NULL;
-	u64 ptr;
-	u64 start;
-	u64 end;
-	int ret;
-
-	bytenr = max_t(u64, bytenr,
-		       BTRFS_SUPER_INFO_OFFSET + BTRFS_SUPER_INFO_SIZE);
-	block_group_cache = &info->block_group_cache;
-	ret = find_first_extent_bit(block_group_cache,
-				    bytenr, &start, &end,
-				    BLOCK_GROUP_DATA | BLOCK_GROUP_METADATA |
-				    BLOCK_GROUP_SYSTEM);
-	if (ret) {
-		return NULL;
-	}
-	ret = get_state_private(block_group_cache, start, &ptr);
-	if (ret)
-		return NULL;
-
-	block_group = (struct btrfs_block_group_cache *)(unsigned long)ptr;
-	return block_group;
-}
-
-/*
- * Return the block group that contains the given @bytenr
- */
-struct btrfs_block_group_cache *btrfs_lookup_block_group(struct
-							 btrfs_fs_info *info,
-							 u64 bytenr)
-{
-	struct extent_io_tree *block_group_cache;
-	struct btrfs_block_group_cache *block_group = NULL;
-	u64 ptr;
-	u64 start;
-	u64 end;
-	int ret;
-
-	block_group_cache = &info->block_group_cache;
-	ret = find_first_extent_bit(block_group_cache,
-				    bytenr, &start, &end,
-				    BLOCK_GROUP_DATA | BLOCK_GROUP_METADATA |
-				    BLOCK_GROUP_SYSTEM);
-	if (ret) {
-		return NULL;
-	}
-	ret = get_state_private(block_group_cache, start, &ptr);
-	if (ret)
-		return NULL;
-
-	block_group = (struct btrfs_block_group_cache *)(unsigned long)ptr;
-	if (block_group->key.objectid <= bytenr && bytenr <
-	    block_group->key.objectid + block_group->key.offset)
-		return block_group;
-	return NULL;
-}
-
 static int block_group_bits(struct btrfs_block_group_cache *cache, u64 bits)
 {
 	return (cache->flags & bits) == bits;
@@ -437,28 +350,18 @@ btrfs_find_block_group(struct btrfs_root *root, struct btrfs_block_group_cache
 		       *hint, u64 search_start, int data, int owner)
 {
 	struct btrfs_block_group_cache *cache;
-	struct extent_io_tree *block_group_cache;
 	struct btrfs_block_group_cache *found_group = NULL;
 	struct btrfs_fs_info *info = root->fs_info;
 	u64 used;
 	u64 last = 0;
 	u64 hint_last;
-	u64 start;
-	u64 end;
 	u64 free_check;
-	u64 ptr;
-	int bit;
-	int ret;
 	int full_search = 0;
 	int factor = 10;
 
-	block_group_cache = &info->block_group_cache;
-
 	if (!owner)
 		factor = 10;
 
-	bit = block_group_state_bits(data);
-
 	if (search_start) {
 		struct btrfs_block_group_cache *shint;
 		shint = btrfs_lookup_block_group(info, search_start);
@@ -488,16 +391,10 @@ btrfs_find_block_group(struct btrfs_root *root, struct btrfs_block_group_cache
 	}
 again:
 	while(1) {
-		ret = find_first_extent_bit(block_group_cache, last,
-					    &start, &end, bit);
-		if (ret)
-			break;
-
-		ret = get_state_private(block_group_cache, start, &ptr);
-		if (ret)
+		cache = btrfs_lookup_first_block_group(info, last);
+		if (!cache)
 			break;
 
-		cache = (struct btrfs_block_group_cache *)(unsigned long)ptr;
 		last = cache->key.objectid + cache->key.offset;
 		used = cache->used;
 
@@ -1681,38 +1578,18 @@ fail:
 
 int btrfs_write_dirty_block_groups(struct btrfs_trans_handle *trans)
 {
-	struct extent_io_tree *block_group_cache;
 	struct btrfs_block_group_cache *cache;
-	int ret;
 	struct btrfs_path *path;
-	u64 last = 0;
-	u64 start;
-	u64 end;
-	u64 ptr;
+	int ret;
 
-	block_group_cache = &trans->fs_info->block_group_cache;
 	path = btrfs_alloc_path();
 	if (!path)
 		return -ENOMEM;
 
-	while(1) {
-		ret = find_first_extent_bit(block_group_cache, last,
-					    &start, &end, BLOCK_GROUP_DIRTY);
-		if (ret) {
-			if (last == 0)
-				break;
-			last = 0;
-			continue;
-		}
-
-		last = end + 1;
-		ret = get_state_private(block_group_cache, start, &ptr);
-		BUG_ON(ret);
-
-		clear_extent_bits(block_group_cache, start, end,
-				  BLOCK_GROUP_DIRTY);
-
-		cache = (struct btrfs_block_group_cache *)(unsigned long)ptr;
+	while (!list_empty(&trans->dirty_bgs)) {
+		cache = list_first_entry(&trans->dirty_bgs,
+				 struct btrfs_block_group_cache, dirty_list);
+		list_del_init(&cache->dirty_list);
 		ret = write_one_cache_group(trans, path, cache);
 		if (ret)
 			break;
@@ -1885,8 +1762,6 @@ static int update_block_group(struct btrfs_trans_handle *trans, u64 bytenr,
 	u64 total = num_bytes;
 	u64 old_val;
 	u64 byte_in_group;
-	u64 start;
-	u64 end;
 
 	/* block accounting for super block */
 	old_val = btrfs_super_bytes_used(info->super_copy);
@@ -1903,11 +1778,8 @@ static int update_block_group(struct btrfs_trans_handle *trans, u64 bytenr,
 		}
 		byte_in_group = bytenr - cache->key.objectid;
 		WARN_ON(byte_in_group > cache->key.offset);
-		start = cache->key.objectid;
-		end = start + cache->key.offset - 1;
-		set_extent_bits(&info->block_group_cache, start, end,
-				BLOCK_GROUP_DIRTY);
-
+		if (list_empty(&cache->dirty_list))
+			list_add_tail(&cache->dirty_list, &trans->dirty_bgs);
 		old_val = cache->used;
 		num_bytes = min(total, cache->key.offset - byte_in_group);
 
@@ -2699,25 +2571,22 @@ int btrfs_free_block_groups(struct btrfs_fs_info *info)
 	struct btrfs_block_group_cache *cache;
 	u64 start;
 	u64 end;
-	u64 ptr;
 	int ret;
 
-	while(1) {
-		ret = find_first_extent_bit(&info->block_group_cache, 0,
-					    &start, &end, (unsigned int)-1);
-		if (ret)
+	while (rb_first(&info->block_group_cache_tree)) {
+		cache = btrfs_lookup_first_block_group(info, 0);
+		if (!cache)
 			break;
-		ret = get_state_private(&info->block_group_cache, start, &ptr);
-		if (!ret) {
-			cache = u64_to_ptr(ptr);
-			if (cache->free_space_ctl) {
-				btrfs_remove_free_space_cache(cache);
-				kfree(cache->free_space_ctl);
-			}
-			kfree(cache);
+
+		if (!list_empty(&cache->dirty_list))
+			list_del_init(&cache->dirty_list);
+		rb_erase(&cache->cache_node, &info->block_group_cache_tree);
+		RB_CLEAR_NODE(&cache->cache_node);
+		if (cache->free_space_ctl) {
+			btrfs_remove_free_space_cache(cache);
+			kfree(cache->free_space_ctl);
 		}
-		clear_extent_bits(&info->block_group_cache, start,
-				  end, (unsigned int)-1);
+		kfree(cache);
 	}
 	while(1) {
 		ret = find_first_extent_bit(&info->free_space_cache, 0,
@@ -2796,7 +2665,6 @@ static int read_one_block_group(struct btrfs_fs_info *fs_info,
 	struct btrfs_block_group_item bgi;
 	struct btrfs_key key;
 	int slot = path->slots[0];
-	int bit = 0;
 	int ret;
 
 	btrfs_item_key_to_cpu(leaf, &key, slot);
@@ -2821,13 +2689,6 @@ static int read_one_block_group(struct btrfs_fs_info *fs_info,
 	cache->used = btrfs_block_group_used(&bgi);
 	INIT_LIST_HEAD(&cache->dirty_list);
 
-	if (cache->flags & BTRFS_BLOCK_GROUP_DATA) {
-		bit = BLOCK_GROUP_DATA;
-	} else if (cache->flags & BTRFS_BLOCK_GROUP_SYSTEM) {
-		bit = BLOCK_GROUP_SYSTEM;
-	} else if (cache->flags & BTRFS_BLOCK_GROUP_METADATA) {
-		bit = BLOCK_GROUP_METADATA;
-	}
 	set_avail_alloc_bits(fs_info, cache->flags);
 	if (btrfs_chunk_readonly(fs_info, cache->key.objectid))
 		cache->ro = 1;
@@ -2841,7 +2702,7 @@ static int read_one_block_group(struct btrfs_fs_info *fs_info,
 	}
 	cache->space_info = space_info;
 
-	btrfs_add_block_group_cache(fs_info, cache, bit | EXTENT_LOCKED);
+	btrfs_add_block_group_cache(fs_info, cache);
 	return 0;
 }
 
@@ -2891,7 +2752,6 @@ btrfs_add_block_group(struct btrfs_fs_info *fs_info, u64 bytes_used, u64 type,
 		      u64 chunk_offset, u64 size)
 {
 	int ret;
-	int bit = 0;
 	struct btrfs_block_group_cache *cache;
 
 	cache = kzalloc(sizeof(*cache), GFP_NOFS);
@@ -2909,9 +2769,7 @@ btrfs_add_block_group(struct btrfs_fs_info *fs_info, u64 bytes_used, u64 type,
 				&cache->space_info);
 	BUG_ON(ret);
 
-	bit = block_group_state_bits(type);
-
-	ret = btrfs_add_block_group_cache(fs_info, cache, bit | EXTENT_LOCKED);
+	ret = btrfs_add_block_group_cache(fs_info, cache);
 	BUG_ON(ret);
 	set_avail_alloc_bits(fs_info, type);
 
@@ -2958,7 +2816,6 @@ int btrfs_make_block_groups(struct btrfs_trans_handle *trans,
 	u64 total_data = 0;
 	u64 total_metadata = 0;
 	int ret;
-	int bit;
 	struct btrfs_root *extent_root = fs_info->extent_root;
 	struct btrfs_block_group_cache *cache;
 
@@ -2970,7 +2827,6 @@ int btrfs_make_block_groups(struct btrfs_trans_handle *trans,
 		group_size = total_bytes / 12;
 		group_size = min_t(u64, group_size, total_bytes - cur_start);
 		if (cur_start == 0) {
-			bit = BLOCK_GROUP_SYSTEM;
 			group_type = BTRFS_BLOCK_GROUP_SYSTEM;
 			group_size /= 4;
 			group_size &= ~(group_align - 1);
@@ -3006,8 +2862,7 @@ int btrfs_make_block_groups(struct btrfs_trans_handle *trans,
 					0, &cache->space_info);
 		BUG_ON(ret);
 		set_avail_alloc_bits(fs_info, group_type);
-		btrfs_add_block_group_cache(fs_info, cache,
-					    bit | EXTENT_LOCKED);
+		btrfs_add_block_group_cache(fs_info, cache);
 		cur_start += group_size;
 	}
 	/* then insert all the items */
@@ -3283,8 +3138,9 @@ static int free_block_group_cache(struct btrfs_trans_handle *trans,
 		btrfs_remove_free_space_cache(cache);
 		kfree(cache->free_space_ctl);
 	}
-	clear_extent_bits(&fs_info->block_group_cache, bytenr, bytenr + len - 1,
-			  (unsigned int)-1);
+	if (!list_empty(&cache->dirty_list))
+		list_del(&cache->dirty_list);
+	rb_erase(&cache->cache_node, &fs_info->block_group_cache_tree);
 	ret = free_space_info(fs_info, flags, len, 0, NULL);
 	if (ret < 0)
 		goto out;
@@ -3417,13 +3273,12 @@ int btrfs_fix_block_accounting(struct btrfs_trans_handle *trans)
 		cache = btrfs_lookup_first_block_group(fs_info, start);
 		if (!cache)
 			break;
+
 		start = cache->key.objectid + cache->key.offset;
 		cache->used = 0;
 		cache->space_info->bytes_used = 0;
-		set_extent_bits(&root->fs_info->block_group_cache,
-				cache->key.objectid,
-				cache->key.objectid + cache->key.offset -1,
-				BLOCK_GROUP_DIRTY);
+		if (list_empty(&cache->dirty_list))
+			list_add_tail(&cache->dirty_list, &trans->dirty_bgs);
 	}
 
 	btrfs_init_path(&path);
diff --git a/image/main.c b/image/main.c
index f88ffb16bafe..95eb3cc3d4de 100644
--- a/image/main.c
+++ b/image/main.c
@@ -2365,9 +2365,8 @@ static void fixup_block_groups(struct btrfs_trans_handle *trans)
 
 		/* Update the block group item and mark the bg dirty */
 		bg->flags = map->type;
-		set_extent_bits(&fs_info->block_group_cache, ce->start,
-				ce->start + ce->size - 1, BLOCK_GROUP_DIRTY);
-
+		if (list_empty(&bg->dirty_list))
+			list_add_tail(&bg->dirty_list, &trans->dirty_bgs);
 		/*
 		 * Chunk and bg flags can be different, changing bg flags
 		 * without update avail_data/meta_alloc_bits will lead to
diff --git a/transaction.c b/transaction.c
index 269e52c01d29..b6b81b2178c8 100644
--- a/transaction.c
+++ b/transaction.c
@@ -203,8 +203,7 @@ commit_tree:
 	 * again, we need to exhause both dirty blocks and delayed refs
 	 */
 	while (!RB_EMPTY_ROOT(&trans->delayed_refs.href_root) ||
-	       test_range_bit(&fs_info->block_group_cache, 0, (u64)-1,
-			      BLOCK_GROUP_DIRTY, 0)) {
+	       !list_empty(&trans->dirty_bgs)) {
 		ret = btrfs_write_dirty_block_groups(trans);
 		if (ret < 0)
 			goto error;
-- 
2.21.0 (Apple Git-122)

