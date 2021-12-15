Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EB95476387
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Dec 2021 21:40:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236331AbhLOUk1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 Dec 2021 15:40:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236226AbhLOUk0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 Dec 2021 15:40:26 -0500
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75CC2C061574
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Dec 2021 12:40:26 -0800 (PST)
Received: by mail-qv1-xf33.google.com with SMTP id i13so21437135qvm.1
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Dec 2021 12:40:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=tBs8rzIxqDbFKLR6xeaSZ6Ouc4MDn3eG2F/LxoTkMfg=;
        b=OTUyAgUvB/dRjSA2BZIdgKt/Te0UNlgyN/Lf+qgwc8+MJ3o7lmBMzJ3Je2ivJy5saS
         ndGPcS5uU3Gyl77bsR6Qk40n2Lz2vC/qB2B+JgSwOVwsxgAQEnhIa465odjVDmAOPQMi
         D0mSrt/1b/oNUsMYh/739EVV/KyXYIW4X2zS1Zfyj/Qh9uNKXQ1W370S3Plk3H9cfDAZ
         CcZaljHr8LXJi/U9+32G6Elui20p7OT8uqLiSTuPtSbsM7mLO7I8y5xPaL74/K0WGmyO
         QIsofEra8WbNd2ukPwgWzceUycIj0qvYAqthkLbSHRTI2zCFEbM1QLHe8sEs29aHO7SU
         39iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tBs8rzIxqDbFKLR6xeaSZ6Ouc4MDn3eG2F/LxoTkMfg=;
        b=W4Uz/EwOuHhBHjopBdfNimZxCbFeKzmJmV1qD2C8Lhh54AxNqNjrbsTeIDUFKgw9gb
         4S23Kf1M2jG0u9qmqqqG/ZfgP7IUP7/uB8yi6pNHTTJqF4GTjhTGGycY7eBOYwRcbqw4
         TrkMMtN28WyfXqb3wpPPyR13ktcS8d+NFVn8GxlgWahLsL5tqoqj1nqe7JK1EzqbQrmx
         rrERXxQieiw1DNSLFvt+K1ew8EBn3dF1vVqUISYeFPkqlLNaPowTl+aXDSWkCvq+qoIZ
         VDShj2634hx3a0EvJiO8yO3xy9/9DdDmrxU5GEhQQVQfOu8Z50SxpEu5/isN0xQsT/LQ
         mZPw==
X-Gm-Message-State: AOAM533+9/tnP3zjTTERuG8KMrPWAMuMrpewnP0A2yn+zscx8fms1Dii
        k1aurWrWf7ARb3csCx/pDBfJGpwdD9QU+Q==
X-Google-Smtp-Source: ABdhPJx2puvRooqSTGw1qAFVXiFcrhpqvX/QF8ydSH+RopiCSg0wRAmq6Fn/XoYdpF/dJ3/cjbWiqA==
X-Received: by 2002:ad4:598f:: with SMTP id ek15mr13107043qvb.128.1639600825343;
        Wed, 15 Dec 2021 12:40:25 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id p12sm1506234qtx.56.2021.12.15.12.40.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Dec 2021 12:40:24 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 11/11] btrfs: add support for multiple global roots
Date:   Wed, 15 Dec 2021 15:40:08 -0500
Message-Id: <4bbf183895f620ff6fc6fc1b7a1288d9ab3b68ba.1639600719.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1639600719.git.josef@toxicpanda.com>
References: <cover.1639600719.git.josef@toxicpanda.com>
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
 fs/btrfs/block-group.c     | 25 +++++++++++++++++--
 fs/btrfs/block-group.h     |  1 +
 fs/btrfs/ctree.h           |  2 ++
 fs/btrfs/disk-io.c         | 49 +++++++++++++++++++++++++++++++-------
 fs/btrfs/free-space-tree.c |  2 ++
 fs/btrfs/transaction.c     | 15 ++++++++++++
 fs/btrfs/tree-checker.c    | 21 ++++++++++++++--
 7 files changed, 102 insertions(+), 13 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 1db24e6d6d90..6215bc53b219 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -1997,6 +1997,7 @@ static int read_one_block_group(struct btrfs_fs_info *info,
 	cache->length = key->offset;
 	cache->used = btrfs_stack_block_group_used(bgi);
 	cache->flags = btrfs_stack_block_group_flags(bgi);
+	cache->global_root_id = btrfs_stack_block_group_chunk_objectid(bgi);
 
 	set_free_space_tree_thresholds(cache);
 
@@ -2279,7 +2280,7 @@ static int insert_block_group_item(struct btrfs_trans_handle *trans,
 	spin_lock(&block_group->lock);
 	btrfs_set_stack_block_group_used(&bgi, block_group->used);
 	btrfs_set_stack_block_group_chunk_objectid(&bgi,
-				BTRFS_FIRST_CHUNK_TREE_OBJECTID);
+						   block_group->global_root_id);
 	btrfs_set_stack_block_group_flags(&bgi, block_group->flags);
 	key.objectid = block_group->start;
 	key.type = BTRFS_BLOCK_GROUP_ITEM_KEY;
@@ -2435,6 +2436,24 @@ void btrfs_create_pending_block_groups(struct btrfs_trans_handle *trans)
 	btrfs_trans_release_chunk_metadata(trans);
 }
 
+/*
+ * For extent tree v2 we use the block_group_item->chunk_offset to point at our
+ * global root id.  For v1 it's always set to BTRFS_FIRST_CHUNK_TREE_OBJECTID.
+ */
+static u64 calculate_global_root_id(struct btrfs_fs_info *fs_info, u64 offset)
+{
+	u64 div = SZ_1G;
+
+	if (!btrfs_fs_incompat(fs_info, EXTENT_TREE_V2))
+		return BTRFS_FIRST_CHUNK_TREE_OBJECTID;
+
+	/* If we have a smaller fs index based on 128m. */
+	if (btrfs_super_total_bytes(fs_info->super_copy) <= (SZ_1G * 10ULL))
+		div = SZ_128M;
+
+	return (div_u64(offset, div) % fs_info->nr_global_roots);
+}
+
 struct btrfs_block_group *btrfs_make_block_group(struct btrfs_trans_handle *trans,
 						 u64 bytes_used, u64 type,
 						 u64 chunk_offset, u64 size)
@@ -2455,6 +2474,8 @@ struct btrfs_block_group *btrfs_make_block_group(struct btrfs_trans_handle *tran
 	cache->flags = type;
 	cache->last_byte_to_unpin = (u64)-1;
 	cache->cached = BTRFS_CACHE_FINISHED;
+	cache->global_root_id = calculate_global_root_id(fs_info, cache->start);
+
 	if (btrfs_fs_compat_ro(fs_info, FREE_SPACE_TREE))
 		cache->needs_free_space = 1;
 
@@ -2671,7 +2692,7 @@ static int update_block_group_item(struct btrfs_trans_handle *trans,
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
index 40c1e5869cef..2a5ed393eb21 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -1056,6 +1056,8 @@ struct btrfs_fs_info {
 	spinlock_t relocation_bg_lock;
 	u64 data_reloc_bg;
 
+	u64 nr_global_roots;
+
 	spinlock_t zone_active_bgs_lock;
 	struct list_head zone_active_bgs;
 
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index b31f20a9da2f..2a70f61345aa 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -1296,12 +1296,32 @@ struct btrfs_root *btrfs_global_root(struct btrfs_fs_info *fs_info,
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
 struct btrfs_root *btrfs_csum_root(struct btrfs_fs_info *fs_info, u64 bytenr)
 {
 	struct btrfs_key key = {
 		.objectid = BTRFS_CSUM_TREE_OBJECTID,
 		.type = BTRFS_ROOT_ITEM_KEY,
-		.offset = 0,
+		.offset = btrfs_global_root_id(fs_info, bytenr),
 	};
 
 	return btrfs_global_root(fs_info, &key);
@@ -1312,7 +1332,7 @@ struct btrfs_root *btrfs_extent_root(struct btrfs_fs_info *fs_info, u64 bytenr)
 	struct btrfs_key key = {
 		.objectid = BTRFS_EXTENT_TREE_OBJECTID,
 		.type = BTRFS_ROOT_ITEM_KEY,
-		.offset = 0,
+		.offset = btrfs_global_root_id(fs_info, bytenr),
 	};
 
 	return btrfs_global_root(fs_info, &key);
@@ -2095,7 +2115,6 @@ static void backup_super_roots(struct btrfs_fs_info *info)
 {
 	const int next_backup = info->backup_root_index;
 	struct btrfs_root_backup *root_backup;
-	struct btrfs_root *csum_root = btrfs_csum_root(info, 0);
 
 	root_backup = info->super_for_commit->super_roots + next_backup;
 
@@ -2129,6 +2148,7 @@ static void backup_super_roots(struct btrfs_fs_info *info)
 			btrfs_header_level(info->block_group_root->node));
 	} else {
 		struct btrfs_root *extent_root = btrfs_extent_root(info, 0);
+		struct btrfs_root *csum_root = btrfs_csum_root(info, 0);
 
 		btrfs_set_backup_extent_root(root_backup,
 					     extent_root->node->start);
@@ -2136,6 +2156,12 @@ static void backup_super_roots(struct btrfs_fs_info *info)
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
@@ -2157,12 +2183,6 @@ static void backup_super_roots(struct btrfs_fs_info *info)
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
@@ -2585,6 +2606,13 @@ static int load_global_roots_objectid(struct btrfs_root *tree_root,
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
@@ -2602,6 +2630,9 @@ static int load_global_roots_objectid(struct btrfs_root *tree_root,
 	}
 	btrfs_release_path(path);
 
+	if (objectid == BTRFS_EXTENT_TREE_OBJECTID)
+		fs_info->nr_global_roots = max_global_id + 1;
+
 	if (!found || ret) {
 		if (objectid == BTRFS_CSUM_TREE_OBJECTID)
 			set_bit(BTRFS_FS_STATE_NO_CSUMS, &fs_info->fs_state);
diff --git a/fs/btrfs/free-space-tree.c b/fs/btrfs/free-space-tree.c
index a3eb6bce2a4d..67d723b9ce0f 100644
--- a/fs/btrfs/free-space-tree.c
+++ b/fs/btrfs/free-space-tree.c
@@ -25,6 +25,8 @@ static struct btrfs_root *btrfs_free_space_root(
 		.offset = 0,
 	};
 
+	if (btrfs_fs_incompat(block_group->fs_info, EXTENT_TREE_V2))
+		key.offset = block_group->global_root_id;
 	return btrfs_global_root(block_group->fs_info, &key);
 }
 
diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index 03de89b45f27..0b73b3ad1e57 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -1850,6 +1850,14 @@ static void update_super_roots(struct btrfs_fs_info *fs_info)
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
@@ -2269,6 +2277,13 @@ int btrfs_commit_transaction(struct btrfs_trans_handle *trans)
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
index ef7d624b0672..96b687e0f820 100644
--- a/fs/btrfs/tree-checker.c
+++ b/fs/btrfs/tree-checker.c
@@ -639,8 +639,10 @@ static void block_group_err(const struct extent_buffer *eb, int slot,
 static int check_block_group_item(struct extent_buffer *leaf,
 				  struct btrfs_key *key, int slot)
 {
+	struct btrfs_fs_info *fs_info = leaf->fs_info;
 	struct btrfs_block_group_item bgi;
 	u32 item_size = btrfs_item_size(leaf, slot);
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

