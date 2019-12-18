Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1CA86123ECF
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Dec 2019 06:19:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726623AbfLRFTN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 18 Dec 2019 00:19:13 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:40767 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725797AbfLRFTN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 18 Dec 2019 00:19:13 -0500
Received: by mail-pj1-f65.google.com with SMTP id n67so313374pjb.5
        for <linux-btrfs@vger.kernel.org>; Tue, 17 Dec 2019 21:19:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=llLvqgvRX590nLHzd0G56l89vCH85CRMpmzEoS3GJ+A=;
        b=da94BLCtwGRzaPARWisAkkhOALqDVGnqzBy4JiUNjC2Eucw0cq6xlUSaEz2/TSdOS+
         pQIZpR/eMochkxNGKsrRia/f1JfLLbdsnvcMl2qysSqmvSh1roDVxNvO7SlLN/nnBO25
         sjwa+AFKHRgpSbXmms61SgtRuQmwxb6g42tLfPjeexzGnFKsk7iqt6EqOkX+MJy5Hwqy
         nGutT+ioVWRurS7p+cHvL28OTubrbtLTqsqCX5Xde83x0+fJLIzXqqiwniK6jBOM8JUO
         pgobV873eXP5kaAKi9YBk2p9xz3aRrWg0xkPuQpzOtQKp4AhTeVP9Tn+g80DGwXqfqL0
         K4Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=llLvqgvRX590nLHzd0G56l89vCH85CRMpmzEoS3GJ+A=;
        b=AOurHubefc6owBv3NA4c/CqDWhBDHAkqE1LH8CTjbaZPviUwtg4KWYYliD0RTzt6ws
         U4owX33jUkInmFnphE4+ajJtN0vMyDakaeuH9vNiKa9m3gRKYuGFj4Jp0wVhoNIPBoyN
         P84vUA+C2NHfsfWXfLm+/5FDhxfvPoJmCdKRtxO01iCfXbYE2ENMajMYP/6BuuL4VCfe
         Oea22S0nwcGLgGyT8Au63oRxhhoVirPY1Wh4y830NG2L9OFbRgg2ippdtAi7Z5pnqarG
         tcgDZozx8DFaA1v8X273B4uHA3fFuCCQrIjBLSGX02DCqXVUImsVJberUPQDL0euB80Z
         1Z3w==
X-Gm-Message-State: APjAAAU69wGwLBm9bPoPPRzJb3V/Abq/4HhxH56IlqA6Z/6X1OPEZV9Q
        4O0sYf2jTeocoTL8w2Xf7TyL3+8def0=
X-Google-Smtp-Source: APXvYqxhbrtd37oMyvH8e8MMRx+Rl/CYrMfyHrUUeOjXg4WL4Oabhyda+vXA1nfZFEIgoSlRVSQmcg==
X-Received: by 2002:a17:902:bf47:: with SMTP id u7mr533429pls.259.1576646352250;
        Tue, 17 Dec 2019 21:19:12 -0800 (PST)
Received: from p.lan (81.249.92.34.bc.googleusercontent.com. [34.92.249.81])
        by smtp.gmail.com with ESMTPSA id e2sm1014781pfh.84.2019.12.17.21.19.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Dec 2019 21:19:11 -0800 (PST)
From:   damenly.su@gmail.com
X-Google-Original-From: Damenly_Su@gmx.com
To:     linux-btrfs@vger.kernel.org
Cc:     Su Yue <Damenly_Su@gmx.com>
Subject: [PATCH V2 09/10] btrfs-progs: reform block groups caches structure
Date:   Wed, 18 Dec 2019 13:18:48 +0800
Message-Id: <20191218051849.2587-10-Damenly_Su@gmx.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122.2)
In-Reply-To: <20191218051849.2587-1-Damenly_Su@gmx.com>
References: <20191218051849.2587-1-Damenly_Su@gmx.com>
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
 extent-tree.c               | 214 ++++++------------------------------
 image/main.c                |   5 +-
 transaction.c               |   3 +-
 4 files changed, 39 insertions(+), 187 deletions(-)

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
index f50d1c8b0a77..b7d5aa104a37 100644
--- a/extent-tree.c
+++ b/extent-tree.c
@@ -24,6 +24,7 @@
 #include "kernel-lib/radix-tree.h"
 #include "ctree.h"
 #include "disk-io.h"
+#include "kernel-lib/rbtree.h"
 #include "print-tree.h"
 #include "transaction.h"
 #include "crypto/crc32c.h"
@@ -164,31 +165,10 @@ err:
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
@@ -262,7 +242,7 @@ static struct btrfs_block_group_cache *block_group_cache_tree_search(
  * Return the block group that contains @bytenr, otherwise return the next one
  * that starts after @bytenr
  */
-struct btrfs_block_group_cache *btrfs_lookup_first_block_group_kernel(
+struct btrfs_block_group_cache *btrfs_lookup_first_block_group(
 		struct btrfs_fs_info *info, u64 bytenr)
 {
 	return block_group_cache_tree_search(info, bytenr, 1);
@@ -271,78 +251,12 @@ struct btrfs_block_group_cache *btrfs_lookup_first_block_group_kernel(
 /*
  * Return the block group that contains the given bytenr
  */
-struct btrfs_block_group_cache *btrfs_lookup_block_group_kernel(
+struct btrfs_block_group_cache *btrfs_lookup_block_group(
 		struct btrfs_fs_info *info, u64 bytenr)
 {
 	return block_group_cache_tree_search(info, bytenr, 0);
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
@@ -432,28 +346,18 @@ btrfs_find_block_group(struct btrfs_root *root, struct btrfs_block_group_cache
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
@@ -483,16 +387,10 @@ btrfs_find_block_group(struct btrfs_root *root, struct btrfs_block_group_cache
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
 
@@ -1676,38 +1574,18 @@ fail:
 
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
@@ -1880,8 +1758,6 @@ static int update_block_group(struct btrfs_trans_handle *trans, u64 bytenr,
 	u64 total = num_bytes;
 	u64 old_val;
 	u64 byte_in_group;
-	u64 start;
-	u64 end;
 
 	/* block accounting for super block */
 	old_val = btrfs_super_bytes_used(info->super_copy);
@@ -1898,11 +1774,8 @@ static int update_block_group(struct btrfs_trans_handle *trans, u64 bytenr,
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
 
@@ -2691,29 +2564,24 @@ struct extent_buffer *btrfs_alloc_free_block(struct btrfs_trans_handle *trans,
 int btrfs_free_block_groups(struct btrfs_fs_info *info)
 {
 	struct btrfs_space_info *sinfo;
-	struct btrfs_block_group_cache *cache;
+	struct btrfs_block_group_cache *cache, *next;
 	u64 start;
 	u64 end;
-	u64 ptr;
 	int ret;
 
-	while(1) {
-		ret = find_first_extent_bit(&info->block_group_cache, 0,
-					    &start, &end, (unsigned int)-1);
-		if (ret)
-			break;
-		ret = get_state_private(&info->block_group_cache, start, &ptr);
-		if (!ret) {
-			cache = u64_to_ptr(ptr);
-			if (cache->free_space_ctl) {
-				btrfs_remove_free_space_cache(cache);
-				kfree(cache->free_space_ctl);
-			}
-			kfree(cache);
+	rbtree_postorder_for_each_entry_safe(cache, next,
+			     &info->block_group_cache_tree, cache_node) {
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
+
 	while(1) {
 		ret = find_first_extent_bit(&info->free_space_cache, 0,
 					    &start, &end, EXTENT_DIRTY);
@@ -2791,7 +2659,6 @@ static int read_one_block_group(struct btrfs_fs_info *fs_info,
 	struct btrfs_block_group_item bgi;
 	struct btrfs_key key;
 	int slot = path->slots[0];
-	int bit = 0;
 	int ret;
 
 	btrfs_item_key_to_cpu(leaf, &key, slot);
@@ -2816,13 +2683,6 @@ static int read_one_block_group(struct btrfs_fs_info *fs_info,
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
@@ -2836,7 +2696,7 @@ static int read_one_block_group(struct btrfs_fs_info *fs_info,
 	}
 	cache->space_info = space_info;
 
-	btrfs_add_block_group_cache(fs_info, cache, bit | EXTENT_LOCKED);
+	btrfs_add_block_group_cache(fs_info, cache);
 	return 0;
 }
 
@@ -2886,7 +2746,6 @@ btrfs_add_block_group(struct btrfs_fs_info *fs_info, u64 bytes_used, u64 type,
 		      u64 chunk_offset, u64 size)
 {
 	int ret;
-	int bit = 0;
 	struct btrfs_block_group_cache *cache;
 
 	cache = kzalloc(sizeof(*cache), GFP_NOFS);
@@ -2904,9 +2763,7 @@ btrfs_add_block_group(struct btrfs_fs_info *fs_info, u64 bytes_used, u64 type,
 				&cache->space_info);
 	BUG_ON(ret);
 
-	bit = block_group_state_bits(type);
-
-	ret = btrfs_add_block_group_cache(fs_info, cache, bit | EXTENT_LOCKED);
+	ret = btrfs_add_block_group_cache(fs_info, cache);
 	BUG_ON(ret);
 	set_avail_alloc_bits(fs_info, type);
 
@@ -2953,7 +2810,6 @@ int btrfs_make_block_groups(struct btrfs_trans_handle *trans,
 	u64 total_data = 0;
 	u64 total_metadata = 0;
 	int ret;
-	int bit;
 	struct btrfs_root *extent_root = fs_info->extent_root;
 	struct btrfs_block_group_cache *cache;
 
@@ -2965,7 +2821,6 @@ int btrfs_make_block_groups(struct btrfs_trans_handle *trans,
 		group_size = total_bytes / 12;
 		group_size = min_t(u64, group_size, total_bytes - cur_start);
 		if (cur_start == 0) {
-			bit = BLOCK_GROUP_SYSTEM;
 			group_type = BTRFS_BLOCK_GROUP_SYSTEM;
 			group_size /= 4;
 			group_size &= ~(group_align - 1);
@@ -3001,8 +2856,7 @@ int btrfs_make_block_groups(struct btrfs_trans_handle *trans,
 					0, &cache->space_info);
 		BUG_ON(ret);
 		set_avail_alloc_bits(fs_info, group_type);
-		btrfs_add_block_group_cache(fs_info, cache,
-					    bit | EXTENT_LOCKED);
+		btrfs_add_block_group_cache(fs_info, cache);
 		cur_start += group_size;
 	}
 	/* then insert all the items */
@@ -3278,8 +3132,9 @@ static int free_block_group_cache(struct btrfs_trans_handle *trans,
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
@@ -3412,13 +3267,12 @@ int btrfs_fix_block_accounting(struct btrfs_trans_handle *trans)
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
2.21.0 (Apple Git-122.2)

