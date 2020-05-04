Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 146E51C4AC6
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 May 2020 01:58:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728467AbgEDX6f (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 4 May 2020 19:58:35 -0400
Received: from mx2.suse.de ([195.135.220.15]:37894 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728278AbgEDX6e (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 4 May 2020 19:58:34 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 043BDABAD
        for <linux-btrfs@vger.kernel.org>; Mon,  4 May 2020 23:58:34 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v4 2/7] btrfs: block-group: Refactor how we read one block group item
Date:   Tue,  5 May 2020 07:58:20 +0800
Message-Id: <20200504235825.4199-3-wqu@suse.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200504235825.4199-1-wqu@suse.com>
References: <20200504235825.4199-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Structure btrfs_block_group has the following members which are
currently read from on-disk block group item and key:
- Length
  From item key.
- Used
- Flags
  From block group item.

However for incoming skinny block group tree, we are going to read those
members from different sources.

This patch will refactor such read by:
- Don't initialize btrfs_block_group::length at allocation
  Caller should initialize them manually.
  Also to avoid possible (well, only two callers) missing
  initialization, add extra ASSERT() in btrfs_add_block_group_cache().

- Refactor length/used/flags initialization into one function
  The new function, fill_one_block_group() will handle the
  initialization of such members.

- Use btrfs_block_group::length to replace key::offset
  Since skinny block group item would have a different meaning for its
  key offset.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/block-group.c | 47 ++++++++++++++++++++++++++++--------------
 1 file changed, 32 insertions(+), 15 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 42dae6473354..57483ea07d51 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -161,6 +161,8 @@ static int btrfs_add_block_group_cache(struct btrfs_fs_info *info,
 	struct rb_node *parent = NULL;
 	struct btrfs_block_group *cache;
 
+	ASSERT(block_group->length != 0);
+
 	spin_lock(&info->block_group_cache_lock);
 	p = &info->block_group_cache_tree.rb_node;
 
@@ -1768,7 +1770,7 @@ static void link_block_group(struct btrfs_block_group *cache)
 }
 
 static struct btrfs_block_group *btrfs_create_block_group_cache(
-		struct btrfs_fs_info *fs_info, u64 start, u64 size)
+		struct btrfs_fs_info *fs_info, u64 start)
 {
 	struct btrfs_block_group *cache;
 
@@ -1784,7 +1786,6 @@ static struct btrfs_block_group *btrfs_create_block_group_cache(
 	}
 
 	cache->start = start;
-	cache->length = size;
 
 	cache->fs_info = fs_info;
 	cache->full_stripe_len = btrfs_full_stripe_len(fs_info, start);
@@ -1864,25 +1865,44 @@ static int check_chunk_block_group_mappings(struct btrfs_fs_info *fs_info)
 	return ret;
 }
 
+static int read_block_group_item(struct btrfs_block_group *cache,
+				 struct btrfs_path *path,
+				 const struct btrfs_key *key)
+{
+	struct extent_buffer *leaf = path->nodes[0];
+	struct btrfs_block_group_item bgi;
+	int slot = path->slots[0];
+
+	cache->length = key->offset;
+
+	read_extent_buffer(leaf, &bgi, btrfs_item_ptr_offset(leaf, slot),
+			sizeof(bgi));
+	cache->used = btrfs_stack_block_group_used(&bgi);
+	cache->flags = btrfs_stack_block_group_flags(&bgi);
+
+	return 0;
+}
+
 static int read_one_block_group(struct btrfs_fs_info *info,
 				struct btrfs_path *path,
 				const struct btrfs_key *key,
 				int need_clear)
 {
-	struct extent_buffer *leaf = path->nodes[0];
 	struct btrfs_block_group *cache;
 	struct btrfs_space_info *space_info;
-	struct btrfs_block_group_item bgi;
 	const bool mixed = btrfs_fs_incompat(info, MIXED_GROUPS);
-	int slot = path->slots[0];
 	int ret;
 
 	ASSERT(key->type == BTRFS_BLOCK_GROUP_ITEM_KEY);
 
-	cache = btrfs_create_block_group_cache(info, key->objectid, key->offset);
+	cache = btrfs_create_block_group_cache(info, key->objectid);
 	if (!cache)
 		return -ENOMEM;
 
+	ret = read_block_group_item(cache, path, key);
+	if (ret < 0)
+		goto error;
+
 	if (need_clear) {
 		/*
 		 * When we mount with old space cache, we need to
@@ -1897,10 +1917,6 @@ static int read_one_block_group(struct btrfs_fs_info *info,
 		if (btrfs_test_opt(info, SPACE_CACHE))
 			cache->disk_cache_state = BTRFS_DC_CLEAR;
 	}
-	read_extent_buffer(leaf, &bgi, btrfs_item_ptr_offset(leaf, slot),
-			   sizeof(bgi));
-	cache->used = btrfs_stack_block_group_used(&bgi);
-	cache->flags = btrfs_stack_block_group_flags(&bgi);
 	if (!mixed && ((cache->flags & BTRFS_BLOCK_GROUP_METADATA) &&
 	    (cache->flags & BTRFS_BLOCK_GROUP_DATA))) {
 			btrfs_err(info,
@@ -1928,15 +1944,15 @@ static int read_one_block_group(struct btrfs_fs_info *info,
 	 * are empty, and we can just add all the space in and be done with it.
 	 * This saves us _a_lot_ of time, particularly in the full case.
 	 */
-	if (key->offset == cache->used) {
+	if (cache->length == cache->used) {
 		cache->last_byte_to_unpin = (u64)-1;
 		cache->cached = BTRFS_CACHE_FINISHED;
 		btrfs_free_excluded_extents(cache);
 	} else if (cache->used == 0) {
 		cache->last_byte_to_unpin = (u64)-1;
 		cache->cached = BTRFS_CACHE_FINISHED;
-		add_new_free_space(cache, key->objectid,
-				   key->objectid + key->offset);
+		add_new_free_space(cache, cache->start,
+				   cache->start + cache->length);
 		btrfs_free_excluded_extents(cache);
 	}
 
@@ -1946,7 +1962,7 @@ static int read_one_block_group(struct btrfs_fs_info *info,
 		goto error;
 	}
 	trace_btrfs_add_block_group(info, cache, 0);
-	btrfs_update_space_info(info, cache->flags, key->offset,
+	btrfs_update_space_info(info, cache->flags, cache->length,
 				cache->used, cache->bytes_super, &space_info);
 
 	cache->space_info = space_info;
@@ -2093,10 +2109,11 @@ int btrfs_make_block_group(struct btrfs_trans_handle *trans, u64 bytes_used,
 
 	btrfs_set_log_full_commit(trans);
 
-	cache = btrfs_create_block_group_cache(fs_info, chunk_offset, size);
+	cache = btrfs_create_block_group_cache(fs_info, chunk_offset);
 	if (!cache)
 		return -ENOMEM;
 
+	cache->length = size;
 	cache->used = bytes_used;
 	cache->flags = type;
 	cache->last_byte_to_unpin = (u64)-1;
-- 
2.26.2

