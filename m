Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1108899FA5
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Aug 2019 21:16:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391813AbfHVTOj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 22 Aug 2019 15:14:39 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:39320 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389212AbfHVTOj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 22 Aug 2019 15:14:39 -0400
Received: by mail-yw1-f68.google.com with SMTP id x74so2846513ywx.6
        for <linux-btrfs@vger.kernel.org>; Thu, 22 Aug 2019 12:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EgFj0oroXc0p5u6u8mEth1jJe/aXteHiupe5q4MOlxY=;
        b=Iul1cjXGGsGytNi5Uug2rxK/jd/bLt4b/lg87bqPl4GiYcsD1lHXVKi6uIC1dD/hyB
         AY9yHUxHnycT3VA+Z5hCsYiCCRm7Zr+2TWyALj9gdZ1a00wMX4qaXEMXPF0p0lA+pSQn
         7ZdsiiYMR4W4C9ya/NxJ9VHicJ8LaLC7F5VPCW6tnKTIeskwNlOVRxZ5mVS84qnHX7/F
         HoSHlwPDEH5WmR0+EtAncpZWKe5ytJnNrwFEtImx/mp4hblJIiBXzXmt5PXykgQWNdAg
         NX31ofEiu2Q7UqFkW6FssEehaJXCG2x8KOcOGgvEgDknHpcwvmvpWssRD7zAmwz3bfRw
         mnxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EgFj0oroXc0p5u6u8mEth1jJe/aXteHiupe5q4MOlxY=;
        b=CibnYDk7+uA10GQS48oIDxOzUuM5UIEW8qwbNC/XFKoxkxMXJtlgZ2mTXMJ67v2+8+
         yEIkiXvLh9UPj+RuZfK6RE4tPpO9Q+nKlPC+lsy2TBlZ/tSG7ESqVBiKo6m7xKKjlvHH
         PxXke4G3399O9apl7fbCsL5cCdW0k0YJHzKXe4sQ5Tt/MVksVXgJ72MCodj7+hYupsI4
         sHUx2o+PdS1VBmgBSMfM4G5bsHPcVldU6Ffrxjeymm2z1LRZov9mkf2bYJBAwNZHtpGH
         eTqq9HXRSfhrN4tQRFARMrtpOwKRK9f6iTY1ETAvXufTIPPlhe3kSvYNi6xaQWVxQb2r
         i/Ow==
X-Gm-Message-State: APjAAAU4QDbWl8bGxDjrATiGSz61bq7s6mlpcD7/lxiDnE+/5R/PuP9i
        fQTivszEWwGJ/LCSt61bL/5xIw==
X-Google-Smtp-Source: APXvYqyNgvKJHL/w/nGUOkzZ5YgPhihbZNL+/kx8t8Dg1prO42/NGXEQgw5n7hI64MmgIQIRioVn5g==
X-Received: by 2002:a81:9889:: with SMTP id p131mr663138ywg.127.1566501278542;
        Thu, 22 Aug 2019 12:14:38 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id b142sm246341ywa.86.2019.08.22.12.14.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2019 12:14:37 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     kernel-team@fb.com, linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 1/2] btrfs: rename the btrfs_calc_*_metadata_size helpers
Date:   Thu, 22 Aug 2019 15:14:33 -0400
Message-Id: <20190822191434.13800-2-josef@toxicpanda.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190822191434.13800-1-josef@toxicpanda.com>
References: <20190822191434.13800-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

btrfs_calc_trunc_metadata_size differs from trans_metadata_size in that
it doesn't take into account any splitting at the levels, because
truncate will never split nodes.  However truncate _and_ changing will
never split nodes, so rename btrfs_calc_trunc_metadata_size to
btrfs_calc_metadata_size.  Also btrfs_calc_trans_metadata_size is purely
for inserting items, so rename this to btrfs_calc_insert_metadata_size.
Making these clearer will help when I start using them differently in
upcoming patches.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/block-group.c      |  4 ++--
 fs/btrfs/ctree.h            | 14 +++++++++-----
 fs/btrfs/delalloc-space.c   |  8 ++++----
 fs/btrfs/delayed-inode.c    |  4 ++--
 fs/btrfs/delayed-ref.c      |  8 ++++----
 fs/btrfs/file.c             |  4 ++--
 fs/btrfs/free-space-cache.c |  4 ++--
 fs/btrfs/inode-map.c        |  2 +-
 fs/btrfs/inode.c            |  6 +++---
 fs/btrfs/props.c            |  2 +-
 fs/btrfs/root-tree.c        |  2 +-
 fs/btrfs/space-info.c       |  2 +-
 fs/btrfs/transaction.c      |  4 ++--
 13 files changed, 34 insertions(+), 30 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index afae5c731904..3147e840f839 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -3014,8 +3014,8 @@ void check_system_chunk(struct btrfs_trans_handle *trans, u64 type)
 	num_devs = get_profile_num_devs(fs_info, type);
 
 	/* num_devs device items to update and 1 chunk item to add or remove */
-	thresh = btrfs_calc_trunc_metadata_size(fs_info, num_devs) +
-		btrfs_calc_trans_metadata_size(fs_info, 1);
+	thresh = btrfs_calc_metadata_size(fs_info, num_devs) +
+		btrfs_calc_insert_metadata_size(fs_info, 1);
 
 	if (left < thresh && btrfs_test_opt(fs_info, ENOSPC_DEBUG)) {
 		btrfs_info(fs_info, "left=%llu, need=%llu, flags=%llu",
diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index b161224b5a0b..66fb41cadbfa 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -2450,17 +2450,21 @@ int btrfs_get_extent_inline_ref_type(const struct extent_buffer *eb,
 
 u64 btrfs_csum_bytes_to_leaves(struct btrfs_fs_info *fs_info, u64 csum_bytes);
 
-static inline u64 btrfs_calc_trans_metadata_size(struct btrfs_fs_info *fs_info,
-						 unsigned num_items)
+/*
+ * Use this if we would be adding new items, as we could split nodes as we cow
+ * down the tree.
+ */
+static inline u64 btrfs_calc_insert_metadata_size(struct btrfs_fs_info *fs_info,
+						  unsigned num_items)
 {
 	return (u64)fs_info->nodesize * BTRFS_MAX_LEVEL * 2 * num_items;
 }
 
 /*
- * Doing a truncate won't result in new nodes or leaves, just what we need for
- * COW.
+ * Doing a truncate or a modification won't result in new nodes or leaves, just
+ * what we need for COW.
  */
-static inline u64 btrfs_calc_trunc_metadata_size(struct btrfs_fs_info *fs_info,
+static inline u64 btrfs_calc_metadata_size(struct btrfs_fs_info *fs_info,
 						 unsigned num_items)
 {
 	return (u64)fs_info->nodesize * BTRFS_MAX_LEVEL * num_items;
diff --git a/fs/btrfs/delalloc-space.c b/fs/btrfs/delalloc-space.c
index 1fc6bef3ccdf..2412be4a3de2 100644
--- a/fs/btrfs/delalloc-space.c
+++ b/fs/btrfs/delalloc-space.c
@@ -252,12 +252,12 @@ static void btrfs_calculate_inode_block_rsv_size(struct btrfs_fs_info *fs_info,
 	lockdep_assert_held(&inode->lock);
 	outstanding_extents = inode->outstanding_extents;
 	if (outstanding_extents)
-		reserve_size = btrfs_calc_trans_metadata_size(fs_info,
+		reserve_size = btrfs_calc_insert_metadata_size(fs_info,
 						outstanding_extents + 1);
 	csum_leaves = btrfs_csum_bytes_to_leaves(fs_info,
 						 inode->csum_bytes);
-	reserve_size += btrfs_calc_trans_metadata_size(fs_info,
-						       csum_leaves);
+	reserve_size += btrfs_calc_insert_metadata_size(fs_info,
+							csum_leaves);
 	/*
 	 * For qgroup rsv, the calculation is very simple:
 	 * account one nodesize for each outstanding extent
@@ -280,7 +280,7 @@ static void calc_inode_reservations(struct btrfs_fs_info *fs_info,
 	u64 csum_leaves = btrfs_csum_bytes_to_leaves(fs_info, num_bytes);
 
 	/* We add one for the inode update at finish ordered time */
-	*meta_reserve = btrfs_calc_trans_metadata_size(fs_info,
+	*meta_reserve = btrfs_calc_insert_metadata_size(fs_info,
 						nr_extents + csum_leaves + 1);
 	*qgroup_reserve = nr_extents * fs_info->nodesize;
 }
diff --git a/fs/btrfs/delayed-inode.c b/fs/btrfs/delayed-inode.c
index 6858a05606dd..de87ea7ce84d 100644
--- a/fs/btrfs/delayed-inode.c
+++ b/fs/btrfs/delayed-inode.c
@@ -558,7 +558,7 @@ static int btrfs_delayed_item_reserve_metadata(struct btrfs_trans_handle *trans,
 	src_rsv = trans->block_rsv;
 	dst_rsv = &fs_info->delayed_block_rsv;
 
-	num_bytes = btrfs_calc_trans_metadata_size(fs_info, 1);
+	num_bytes = btrfs_calc_insert_metadata_size(fs_info, 1);
 
 	/*
 	 * Here we migrate space rsv from transaction rsv, since have already
@@ -612,7 +612,7 @@ static int btrfs_delayed_inode_reserve_metadata(
 	src_rsv = trans->block_rsv;
 	dst_rsv = &fs_info->delayed_block_rsv;
 
-	num_bytes = btrfs_calc_trans_metadata_size(fs_info, 1);
+	num_bytes = btrfs_calc_insert_metadata_size(fs_info, 1);
 
 	/*
 	 * btrfs_dirty_inode will update the inode under btrfs_join_transaction
diff --git a/fs/btrfs/delayed-ref.c b/fs/btrfs/delayed-ref.c
index 3822edbf54a7..df3bd880061d 100644
--- a/fs/btrfs/delayed-ref.c
+++ b/fs/btrfs/delayed-ref.c
@@ -79,7 +79,7 @@ int btrfs_should_throttle_delayed_refs(struct btrfs_trans_handle *trans)
 void btrfs_delayed_refs_rsv_release(struct btrfs_fs_info *fs_info, int nr)
 {
 	struct btrfs_block_rsv *block_rsv = &fs_info->delayed_refs_rsv;
-	u64 num_bytes = btrfs_calc_trans_metadata_size(fs_info, nr);
+	u64 num_bytes = btrfs_calc_insert_metadata_size(fs_info, nr);
 	u64 released = 0;
 
 	released = __btrfs_block_rsv_release(fs_info, block_rsv, num_bytes,
@@ -105,8 +105,8 @@ void btrfs_update_delayed_refs_rsv(struct btrfs_trans_handle *trans)
 	if (!trans->delayed_ref_updates)
 		return;
 
-	num_bytes = btrfs_calc_trans_metadata_size(fs_info,
-						   trans->delayed_ref_updates);
+	num_bytes = btrfs_calc_insert_metadata_size(fs_info,
+						    trans->delayed_ref_updates);
 	spin_lock(&delayed_rsv->lock);
 	delayed_rsv->size += num_bytes;
 	delayed_rsv->full = 0;
@@ -174,7 +174,7 @@ int btrfs_delayed_refs_rsv_refill(struct btrfs_fs_info *fs_info,
 				  enum btrfs_reserve_flush_enum flush)
 {
 	struct btrfs_block_rsv *block_rsv = &fs_info->delayed_refs_rsv;
-	u64 limit = btrfs_calc_trans_metadata_size(fs_info, 1);
+	u64 limit = btrfs_calc_insert_metadata_size(fs_info, 1);
 	u64 num_bytes = 0;
 	int ret = -ENOSPC;
 
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index b31991f0f440..1cb694c96500 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -2511,7 +2511,7 @@ int btrfs_punch_hole_range(struct inode *inode, struct btrfs_path *path,
 			   struct btrfs_trans_handle **trans_out)
 {
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
-	u64 min_size = btrfs_calc_trans_metadata_size(fs_info, 1);
+	u64 min_size = btrfs_calc_insert_metadata_size(fs_info, 1);
 	u64 ino_size = round_up(inode->i_size, fs_info->sectorsize);
 	struct btrfs_root *root = BTRFS_I(inode)->root;
 	struct btrfs_trans_handle *trans = NULL;
@@ -2530,7 +2530,7 @@ int btrfs_punch_hole_range(struct inode *inode, struct btrfs_path *path,
 		ret = -ENOMEM;
 		goto out;
 	}
-	rsv->size = btrfs_calc_trans_metadata_size(fs_info, 1);
+	rsv->size = btrfs_calc_insert_metadata_size(fs_info, 1);
 	rsv->failfast = 1;
 
 	/*
diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index faaf57a7c289..265dc75f7a7a 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -211,8 +211,8 @@ int btrfs_check_trunc_cache_free_space(struct btrfs_fs_info *fs_info,
 	int ret;
 
 	/* 1 for slack space, 1 for updating the inode */
-	needed_bytes = btrfs_calc_trunc_metadata_size(fs_info, 1) +
-		btrfs_calc_trans_metadata_size(fs_info, 1);
+	needed_bytes = btrfs_calc_insert_metadata_size(fs_info, 1) +
+		btrfs_calc_metadata_size(fs_info, 1);
 
 	spin_lock(&rsv->lock);
 	if (rsv->reserved < needed_bytes)
diff --git a/fs/btrfs/inode-map.c b/fs/btrfs/inode-map.c
index 86031cdfc356..63cad7865d75 100644
--- a/fs/btrfs/inode-map.c
+++ b/fs/btrfs/inode-map.c
@@ -436,7 +436,7 @@ int btrfs_save_ino_cache(struct btrfs_root *root,
 	 * 1 item for free space object
 	 * 3 items for pre-allocation
 	 */
-	trans->bytes_reserved = btrfs_calc_trans_metadata_size(fs_info, 10);
+	trans->bytes_reserved = btrfs_calc_insert_metadata_size(fs_info, 10);
 	ret = btrfs_block_rsv_add(root, trans->block_rsv,
 				  trans->bytes_reserved,
 				  BTRFS_RESERVE_NO_FLUSH);
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index e12fcd3adcc8..aece5dd0e7a8 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -5373,7 +5373,7 @@ static struct btrfs_trans_handle *evict_refill_and_join(struct btrfs_root *root,
 	struct btrfs_fs_info *fs_info = root->fs_info;
 	struct btrfs_block_rsv *global_rsv = &fs_info->global_block_rsv;
 	struct btrfs_trans_handle *trans;
-	u64 delayed_refs_extra = btrfs_calc_trans_metadata_size(fs_info, 1);
+	u64 delayed_refs_extra = btrfs_calc_insert_metadata_size(fs_info, 1);
 	int ret;
 
 	/*
@@ -5462,7 +5462,7 @@ void btrfs_evict_inode(struct inode *inode)
 	rsv = btrfs_alloc_block_rsv(fs_info, BTRFS_BLOCK_RSV_TEMP);
 	if (!rsv)
 		goto no_delete;
-	rsv->size = btrfs_calc_trunc_metadata_size(fs_info, 1);
+	rsv->size = btrfs_calc_metadata_size(fs_info, 1);
 	rsv->failfast = 1;
 
 	btrfs_i_size_write(BTRFS_I(inode), 0);
@@ -9076,7 +9076,7 @@ static int btrfs_truncate(struct inode *inode, bool skip_writeback)
 	int ret;
 	struct btrfs_trans_handle *trans;
 	u64 mask = fs_info->sectorsize - 1;
-	u64 min_size = btrfs_calc_trunc_metadata_size(fs_info, 1);
+	u64 min_size = btrfs_calc_metadata_size(fs_info, 1);
 
 	if (!skip_writeback) {
 		ret = btrfs_wait_ordered_range(inode, inode->i_size & (~mask),
diff --git a/fs/btrfs/props.c b/fs/btrfs/props.c
index e0469816c678..1e664e0b59b8 100644
--- a/fs/btrfs/props.c
+++ b/fs/btrfs/props.c
@@ -362,7 +362,7 @@ static int inherit_props(struct btrfs_trans_handle *trans,
 		 * reservations if we do add more properties in the future.
 		 */
 		if (need_reserve) {
-			num_bytes = btrfs_calc_trans_metadata_size(fs_info, 1);
+			num_bytes = btrfs_calc_insert_metadata_size(fs_info, 1);
 			ret = btrfs_block_rsv_add(root, trans->block_rsv,
 					num_bytes, BTRFS_RESERVE_NO_FLUSH);
 			if (ret)
diff --git a/fs/btrfs/root-tree.c b/fs/btrfs/root-tree.c
index 47733fb55df7..3b17b647d002 100644
--- a/fs/btrfs/root-tree.c
+++ b/fs/btrfs/root-tree.c
@@ -533,7 +533,7 @@ int btrfs_subvolume_reserve_metadata(struct btrfs_root *root,
 			return ret;
 	}
 
-	num_bytes = btrfs_calc_trans_metadata_size(fs_info, items);
+	num_bytes = btrfs_calc_insert_metadata_size(fs_info, items);
 	rsv->space_info = btrfs_find_space_info(fs_info,
 					    BTRFS_BLOCK_GROUP_METADATA);
 	ret = btrfs_block_rsv_add(root, rsv, num_bytes,
diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index c5939c24c963..a43f6287074b 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -348,7 +348,7 @@ static inline u64 calc_reclaim_items_nr(struct btrfs_fs_info *fs_info,
 	u64 bytes;
 	u64 nr;
 
-	bytes = btrfs_calc_trans_metadata_size(fs_info, 1);
+	bytes = btrfs_calc_insert_metadata_size(fs_info, 1);
 	nr = div64_u64(to_reclaim, bytes);
 	if (!nr)
 		nr = 1;
diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index 2e3f6778bfa3..f21416d68c2c 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -485,7 +485,7 @@ start_transaction(struct btrfs_root *root, unsigned int num_items,
 		 * worth of delayed refs updates in this trans handle, and
 		 * refill that amount for whatever is missing in the reserve.
 		 */
-		num_bytes = btrfs_calc_trans_metadata_size(fs_info, num_items);
+		num_bytes = btrfs_calc_insert_metadata_size(fs_info, num_items);
 		if (delayed_refs_rsv->full == 0) {
 			delayed_refs_bytes = num_bytes;
 			num_bytes <<= 1;
@@ -636,7 +636,7 @@ struct btrfs_trans_handle *btrfs_start_transaction_fallback_global_rsv(
 	if (IS_ERR(trans))
 		return trans;
 
-	num_bytes = btrfs_calc_trans_metadata_size(fs_info, num_items);
+	num_bytes = btrfs_calc_insert_metadata_size(fs_info, num_items);
 	ret = btrfs_cond_migrate_bytes(fs_info, &fs_info->trans_block_rsv,
 				       num_bytes, min_factor);
 	if (ret) {
-- 
2.21.0

