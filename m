Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD41F446A29
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Nov 2021 21:50:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233863AbhKEUwk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 5 Nov 2021 16:52:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233848AbhKEUwj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 5 Nov 2021 16:52:39 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A19D2C061714
        for <linux-btrfs@vger.kernel.org>; Fri,  5 Nov 2021 13:49:59 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id bm28so9881098qkb.9
        for <linux-btrfs@vger.kernel.org>; Fri, 05 Nov 2021 13:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=R20efsTT5QsF3C+fcYSJajxr5l8SUOQ7Q4ryqTp0QoQ=;
        b=IcNJg0V9rxhe12keTK6XnV0McOYvY2s2BdzwwIENZ33wSeJVNM4yLYVLPeZFLDOqh7
         iQxFycWe8dVcbejlI9optMZ+06ktHjQRPaysfHY0O7JtFsXelI1kbDeXr05yPcekiOrn
         rhDOOyqeT49tROYoayz1hdmh6zjKIrBOzd7NkUptVX8O+nsCem4pZ7OOCDDmisDNfYv2
         iM20kKX2UOBZyTEW94pHQ8eNJ5xj1DmcBgpLjRIAXzPQm9vRomrTAYNQd2MTaS81hJTO
         w+Ibhf7tL93NPrO0vrAUGFuMkZK5lbVcW88pSzReECP1iG3W0ivCAP9xqJz+t2NXyjN3
         grkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=R20efsTT5QsF3C+fcYSJajxr5l8SUOQ7Q4ryqTp0QoQ=;
        b=2wkP9wtc0Qb3G6kA5Vv7lBGJulpwxwkIqVDF4Oyx6NxTx37hrDtZmKywMX/wZdS66p
         Nj3tf7+tanjqIH1Tglhsci6/61gPaMUiQwTcqQezqdPo71yI3DpO4rddLVRuSJBA/F15
         SJTCA7qtHLNuN6dLapxXtEmrq5GVhcM7gnKQXQU03/5Va1hJsUZphob5o6DWYZVrZPlf
         F/lWbAck5RP9ur5rXn8GGOch1MwJy0w+QWQ4J7gY3BkiGbXPad1L5B0X2vEbtBIbSlLw
         m+Iu0EKYXrJAH6Uy5d300ySZADIycGPKjP82mEHoAwYqCHHngblej8UIiuLuxw+QKaXx
         uVqA==
X-Gm-Message-State: AOAM533VMujS83jAvLCuG1iRvYFJlUgvJln9HuyB7JfD2S9aaRdYCV8V
        oqAWFH58TsdwgneSKEPaBqXfSo2ZzlHtNw==
X-Google-Smtp-Source: ABdhPJwfXLx0dYwWJ8fHVBx/qvToJtP8HUWzC6Wi9boKOBws/zW48pE5O+LSMJDyhBpJHJpTFGH2Mw==
X-Received: by 2002:a05:620a:bce:: with SMTP id s14mr48858750qki.482.1636145398393;
        Fri, 05 Nov 2021 13:49:58 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id v7sm5734130qkd.41.2021.11.05.13.49.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Nov 2021 13:49:58 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 8/8] btrfs: add support for multiple global roots
Date:   Fri,  5 Nov 2021 16:49:45 -0400
Message-Id: <a6f403691bdec22e8e052f699ae52f18875cb870.1636145221.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1636145221.git.josef@toxicpanda.com>
References: <cover.1636145221.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

With extent tree v2 you will be able to create multiple csum, extent,
and free space trees.  They will be used based on the block group, which
will now use the block_group_item->chunk_objectid to point to the set of
global roots that it will use.  When allocating new block groups we'll
simply mod the gigabyte offset of the block group against the number of
global roots we have and that will be the block groups global id.

From there we can take the bytenr that we're modifying in the respective
tree, look up the block group and get that block groups corresponding
global root id.  From there we can get to the appropriate global root
for that bytenr.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/block-group.c     | 11 +++++++--
 fs/btrfs/block-group.h     |  1 +
 fs/btrfs/ctree.h           |  2 ++
 fs/btrfs/disk-io.c         | 49 +++++++++++++++++++++++++++++++-------
 fs/btrfs/free-space-tree.c |  2 ++
 fs/btrfs/transaction.c     | 15 ++++++++++++
 fs/btrfs/tree-checker.c    | 21 ++++++++++++++--
 7 files changed, 88 insertions(+), 13 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 7eb0a8632a01..85516f2fd5da 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -2002,6 +2002,7 @@ static int read_one_block_group(struct btrfs_fs_info *info,
 	cache->length = key->offset;
 	cache->used = btrfs_stack_block_group_used(bgi);
 	cache->flags = btrfs_stack_block_group_flags(bgi);
+	cache->global_root_id = btrfs_stack_block_group_chunk_objectid(bgi);
 
 	set_free_space_tree_thresholds(cache);
 
@@ -2284,7 +2285,7 @@ static int insert_block_group_item(struct btrfs_trans_handle *trans,
 	spin_lock(&block_group->lock);
 	btrfs_set_stack_block_group_used(&bgi, block_group->used);
 	btrfs_set_stack_block_group_chunk_objectid(&bgi,
-				BTRFS_FIRST_CHUNK_TREE_OBJECTID);
+						   block_group->global_root_id);
 	btrfs_set_stack_block_group_flags(&bgi, block_group->flags);
 	key.objectid = block_group->start;
 	key.type = BTRFS_BLOCK_GROUP_ITEM_KEY;
@@ -2460,6 +2461,12 @@ struct btrfs_block_group *btrfs_make_block_group(struct btrfs_trans_handle *tran
 	cache->flags = type;
 	cache->last_byte_to_unpin = (u64)-1;
 	cache->cached = BTRFS_CACHE_FINISHED;
+	cache->global_root_id = BTRFS_FIRST_CHUNK_TREE_OBJECTID;
+
+	if (btrfs_fs_incompat(fs_info, EXTENT_TREE_V2))
+		cache->global_root_id = div64_u64(cache->start, SZ_1G) %
+			fs_info->nr_global_roots;
+
 	if (btrfs_fs_compat_ro(fs_info, FREE_SPACE_TREE))
 		cache->needs_free_space = 1;
 
@@ -2676,7 +2683,7 @@ static int update_block_group_item(struct btrfs_trans_handle *trans,
 	bi = btrfs_item_ptr_offset(leaf, path->slots[0]);
 	btrfs_set_stack_block_group_used(&bgi, cache->used);
 	btrfs_set_stack_block_group_chunk_objectid(&bgi,
-			BTRFS_FIRST_CHUNK_TREE_OBJECTID);
+						   cache->global_root_id);
 	btrfs_set_stack_block_group_flags(&bgi, cache->flags);
 	write_extent_buffer(leaf, &bgi, bi, sizeof(bgi));
 	btrfs_mark_buffer_dirty(leaf);
diff --git a/fs/btrfs/block-group.h b/fs/btrfs/block-group.h
index 5878b7ce3b78..93aabc68bb6a 100644
--- a/fs/btrfs/block-group.h
+++ b/fs/btrfs/block-group.h
@@ -68,6 +68,7 @@ struct btrfs_block_group {
 	u64 bytes_super;
 	u64 flags;
 	u64 cache_generation;
+	u64 global_root_id;
 
 	/*
 	 * If the free space extent count exceeds this number, convert the block
diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index b57367141b95..7de0cd2b87ec 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -1057,6 +1057,8 @@ struct btrfs_fs_info {
 	spinlock_t relocation_bg_lock;
 	u64 data_reloc_bg;
 
+	u64 nr_global_roots;
+
 	spinlock_t zone_active_bgs_lock;
 	struct list_head zone_active_bgs;
 
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 45b2bde43150..a8bc00d17b26 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -1295,13 +1295,33 @@ struct btrfs_root *btrfs_global_root(struct btrfs_fs_info *fs_info,
 	return root;
 }
 
+static u64 btrfs_global_root_id(struct btrfs_fs_info *fs_info, u64 bytenr)
+{
+	struct btrfs_block_group *block_group;
+	u64 ret;
+
+	if (!btrfs_fs_incompat(fs_info, EXTENT_TREE_V2))
+		return 0;
+
+	if (likely(bytenr))
+		block_group = btrfs_lookup_block_group(fs_info, bytenr);
+	else
+		block_group = btrfs_lookup_first_block_group(fs_info, bytenr);
+	ASSERT(block_group);
+	if (!block_group)
+		return 0;
+	ret = block_group->global_root_id;
+	btrfs_put_block_group(block_group);
+	return ret;
+}
+
 struct btrfs_root *btrfs_csum_root(struct btrfs_fs_info *fs_info,
 				   u64 bytenr)
 {
 	struct btrfs_key key = {
 		.objectid = BTRFS_CSUM_TREE_OBJECTID,
 		.type = BTRFS_ROOT_ITEM_KEY,
-		.offset = 0,
+		.offset = btrfs_global_root_id(fs_info, bytenr),
 	};
 
 	return btrfs_global_root(fs_info, &key);
@@ -1313,7 +1333,7 @@ struct btrfs_root *btrfs_extent_root(struct btrfs_fs_info *fs_info,
 	struct btrfs_key key = {
 		.objectid = BTRFS_EXTENT_TREE_OBJECTID,
 		.type = BTRFS_ROOT_ITEM_KEY,
-		.offset = 0,
+		.offset = btrfs_global_root_id(fs_info, bytenr),
 	};
 
 	return btrfs_global_root(fs_info, &key);
@@ -2094,7 +2114,6 @@ static void backup_super_roots(struct btrfs_fs_info *info)
 {
 	const int next_backup = info->backup_root_index;
 	struct btrfs_root_backup *root_backup;
-	struct btrfs_root *csum_root = btrfs_csum_root(info, 0);
 
 	root_backup = info->super_for_commit->super_roots + next_backup;
 
@@ -2128,6 +2147,7 @@ static void backup_super_roots(struct btrfs_fs_info *info)
 			btrfs_header_level(info->block_group_root->node));
 	} else {
 		struct btrfs_root *extent_root = btrfs_extent_root(info, 0);
+		struct btrfs_root *csum_root = btrfs_csum_root(info, 0);
 
 		btrfs_set_backup_extent_root(root_backup,
 					     extent_root->node->start);
@@ -2135,6 +2155,12 @@ static void backup_super_roots(struct btrfs_fs_info *info)
 				btrfs_header_generation(extent_root->node));
 		btrfs_set_backup_extent_root_level(root_backup,
 					btrfs_header_level(extent_root->node));
+
+		btrfs_set_backup_csum_root(root_backup, csum_root->node->start);
+		btrfs_set_backup_csum_root_gen(root_backup,
+					       btrfs_header_generation(csum_root->node));
+		btrfs_set_backup_csum_root_level(root_backup,
+						 btrfs_header_level(csum_root->node));
 	}
 
 	/*
@@ -2156,12 +2182,6 @@ static void backup_super_roots(struct btrfs_fs_info *info)
 	btrfs_set_backup_dev_root_level(root_backup,
 				       btrfs_header_level(info->dev_root->node));
 
-	btrfs_set_backup_csum_root(root_backup, csum_root->node->start);
-	btrfs_set_backup_csum_root_gen(root_backup,
-				       btrfs_header_generation(csum_root->node));
-	btrfs_set_backup_csum_root_level(root_backup,
-					 btrfs_header_level(csum_root->node));
-
 	btrfs_set_backup_total_bytes(root_backup,
 			     btrfs_super_total_bytes(info->super_copy));
 	btrfs_set_backup_bytes_used(root_backup,
@@ -2550,6 +2570,7 @@ static int load_global_roots_objectid(struct btrfs_root *tree_root,
 {
 	struct btrfs_fs_info *fs_info = tree_root->fs_info;
 	struct btrfs_root *root;
+	u64 max_global_id = 0;
 	int ret;
 	struct btrfs_key key = {
 		.objectid = objectid,
@@ -2586,6 +2607,13 @@ static int load_global_roots_objectid(struct btrfs_root *tree_root,
 			break;
 		btrfs_release_path(path);
 
+		/*
+		 * Just worry about this for extent tree, it'll be the same for
+		 * everybody.
+		 */
+		if (objectid == BTRFS_EXTENT_TREE_OBJECTID)
+			max_global_id = max(max_global_id, key.offset);
+
 		found = true;
 		root = read_tree_root_path(tree_root, path, &key);
 		if (IS_ERR(root)) {
@@ -2603,6 +2631,9 @@ static int load_global_roots_objectid(struct btrfs_root *tree_root,
 	}
 	btrfs_release_path(path);
 
+	if (objectid == BTRFS_EXTENT_TREE_OBJECTID)
+		fs_info->nr_global_roots = max_global_id + 1;
+
 	if (!found || ret) {
 		if (objectid == BTRFS_CSUM_TREE_OBJECTID)
 			set_bit(BTRFS_FS_STATE_NO_CSUMS, &fs_info->fs_state);
diff --git a/fs/btrfs/free-space-tree.c b/fs/btrfs/free-space-tree.c
index cf227450f356..60a73bcffaf1 100644
--- a/fs/btrfs/free-space-tree.c
+++ b/fs/btrfs/free-space-tree.c
@@ -24,6 +24,8 @@ static struct btrfs_root *btrfs_free_space_root(
 		.type = BTRFS_ROOT_ITEM_KEY,
 		.offset = 0,
 	};
+	if (btrfs_fs_incompat(block_group->fs_info, EXTENT_TREE_V2))
+		key.offset = block_group->global_root_id;
 	return btrfs_global_root(block_group->fs_info, &key);
 }
 
diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index ba8dd90ac3ce..e343ff8db05d 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -1827,6 +1827,14 @@ static void update_super_roots(struct btrfs_fs_info *fs_info)
 		super->cache_generation = 0;
 	if (test_bit(BTRFS_FS_UPDATE_UUID_TREE_GEN, &fs_info->flags))
 		super->uuid_tree_generation = root_item->generation;
+
+	if (btrfs_fs_incompat(fs_info, EXTENT_TREE_V2)) {
+		root_item = &fs_info->block_group_root->root_item;
+
+		super->block_group_root = root_item->bytenr;
+		super->block_group_root_generation = root_item->generation;
+		super->block_group_root_level = root_item->level;
+	}
 }
 
 int btrfs_transaction_in_commit(struct btrfs_fs_info *info)
@@ -2261,6 +2269,13 @@ int btrfs_commit_transaction(struct btrfs_trans_handle *trans)
 	list_add_tail(&fs_info->chunk_root->dirty_list,
 		      &cur_trans->switch_commits);
 
+	if (btrfs_fs_incompat(fs_info, EXTENT_TREE_V2)) {
+		btrfs_set_root_node(&fs_info->block_group_root->root_item,
+				    fs_info->block_group_root->node);
+		list_add_tail(&fs_info->block_group_root->dirty_list,
+			      &cur_trans->switch_commits);
+	}
+
 	switch_commit_roots(trans);
 
 	ASSERT(list_empty(&cur_trans->dirty_bgs));
diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
index 1c33dd0e4afc..572f52d78297 100644
--- a/fs/btrfs/tree-checker.c
+++ b/fs/btrfs/tree-checker.c
@@ -639,8 +639,10 @@ static void block_group_err(const struct extent_buffer *eb, int slot,
 static int check_block_group_item(struct extent_buffer *leaf,
 				  struct btrfs_key *key, int slot)
 {
+	struct btrfs_fs_info *fs_info = leaf->fs_info;
 	struct btrfs_block_group_item bgi;
 	u32 item_size = btrfs_item_size_nr(leaf, slot);
+	u64 chunk_objectid;
 	u64 flags;
 	u64 type;
 
@@ -663,8 +665,23 @@ static int check_block_group_item(struct extent_buffer *leaf,
 
 	read_extent_buffer(leaf, &bgi, btrfs_item_ptr_offset(leaf, slot),
 			   sizeof(bgi));
-	if (unlikely(btrfs_stack_block_group_chunk_objectid(&bgi) !=
-		     BTRFS_FIRST_CHUNK_TREE_OBJECTID)) {
+	chunk_objectid = btrfs_stack_block_group_chunk_objectid(&bgi);
+	if (btrfs_fs_incompat(fs_info, EXTENT_TREE_V2)) {
+		/*
+		 * We don't init the nr_global_roots until we load the global
+		 * roots, so this could be 0 at mount time.  If it's 0 we'll
+		 * just assume we're fine, and later we'll check against our
+		 * actual value.
+		 */
+		if (unlikely(fs_info->nr_global_roots &&
+			     chunk_objectid >= fs_info->nr_global_roots)) {
+			block_group_err(leaf, slot,
+	"invalid block group global root id, have %llu, needs to be <= %llu",
+					chunk_objectid,
+					fs_info->nr_global_roots);
+			return -EUCLEAN;
+		}
+	} else if (unlikely(chunk_objectid != BTRFS_FIRST_CHUNK_TREE_OBJECTID)) {
 		block_group_err(leaf, slot,
 		"invalid block group chunk objectid, have %llu expect %llu",
 				btrfs_stack_block_group_chunk_objectid(&bgi),
-- 
2.26.3

