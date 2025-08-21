Return-Path: <linux-btrfs+bounces-16195-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 71560B2FA32
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Aug 2025 15:23:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FF711CE7802
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Aug 2025 13:17:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A57CF335BC6;
	Thu, 21 Aug 2025 13:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Csjz4BCp"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com [209.85.214.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92B0032A3ED
	for <linux-btrfs@vger.kernel.org>; Thu, 21 Aug 2025 13:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755782198; cv=none; b=uC9S+60zUT6J8cKaaxZNTEsYafto3bdIfkibDDVEgOrpMzYllEZo2PjgId+lX+0oRj/0uSUwsoNlBS/dfJa8eo5PkPlbwnALv/0tD93+Y+3s4iSCrgTexHcbSdPTElNCsArwKKwA+j4FnREf+Dsi0JTDxaO7d4RZ/xLULNOCmco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755782198; c=relaxed/simple;
	bh=uVsH76Icfb8xColNF5QjysySe+SLK/J9sSpDKBIqXbo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bY2ECfFQukvx6Jk+Y1MCTc/XMPDvo+wo7cRQbsvGP5X8tMmlbKXLZnR+96CVUy+fnJLUzKcw5a02AskeMAr8ymXsHFloJRsLBnJSmY9Bq7uNHYA2CARKNRodmoJy7+ffXAPOnhRNujR+tj3pgQAqdv1YMDJL2NdtHFn+e9GgVN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Csjz4BCp; arc=none smtp.client-ip=209.85.214.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f194.google.com with SMTP id d9443c01a7336-244581cd020so1412775ad.2
        for <linux-btrfs@vger.kernel.org>; Thu, 21 Aug 2025 06:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755782195; x=1756386995; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kDgpqUowuQS2PxRmZDUoomMax0aAAmxX1YOziVELQAE=;
        b=Csjz4BCpJW2EEFmRkM0fKdu3MWY3ATkPz5QIwHRIgqhTTxcY/irm9d3/MCzResrlD1
         oe8fZoCc6D6eZ91tEd8tiXPourHfBYe5k6GgkDc6y1DFPH1rYYiXs3Y5ibYHTqUu4ovq
         Mdh2r8MoQEd6ndsut7GllA3iMQSiUAQQ9yhKJP1fMyI52CYLOPooDMrpXTZ/J2sPuF0Z
         NM20yFRxtvXYdinLULpIVoeHXZb9Qed0y46pVv8qSW0yzmyyvQVuC8UsZLvOPVhdD+H2
         CNuvraVjiqBId2mNt57gi91crtJdUkFlwO7EOv4ShNRl36utram9zoHzso1eA3DLOLGM
         6Mug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755782195; x=1756386995;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kDgpqUowuQS2PxRmZDUoomMax0aAAmxX1YOziVELQAE=;
        b=jqw3nFLOAAcsiCvb/qTf/4S3JV9J/6kzCLkwQzNbnjkQS+lSq+1ZFfH488gMBI1KDI
         EZnb506qXZuu9c9VLxajzxWO8VQzl+g9fqU2BRalNo8r47GBFJSxXEvcqjm8pYx+4avq
         S9cgN7DRtlUMEA+uygVGzTAhUXQiR2X5nn8w9KOMkQ5rmfG2rXxS40gUdKawywp8jst7
         gRRodwCJ7j2Pm9FO+X7fFRNF9wr9MJq3YRVqlFt86EdKqR+VMkvar0OKYpmKi5CUjaq8
         Onii1z27/0h1OnJlePeLys1jPgh3tGf2C43TQpJc/NRxvsfv8CgC6C/PZMUT3V0QGT2Q
         A63g==
X-Gm-Message-State: AOJu0Yz+QNFOs20rM0OLeCxD5uqzP9acnE0Y3nSZ7epqxCAtUW+IHdmO
	USNo3ZSS0iwSOaflly2NKPUj/txyrGa6xbc2khmpFed6weZBVi0VZ7dYPc1W4xWmRqcwaw==
X-Gm-Gg: ASbGncuRju5hFN1V+Q1/H+H1cSvm8YFX+5TSdlP7tYgPTGeAdHTthhwLsoer0W3ANnY
	eAKZ3BApn81WWEZfd1D9h9sqKs5dC+PZCDNKSsERo+8R8ITRyaRhFsg4OrckH+nEp2CyK9vjwki
	vo8L+oOpBggmqiu9AYZerj3F4e2U5V5nPUMhuu0WNN2BHF9aUT8gHQn8d3OJUJeXDpJX2bF/HYc
	GIbzRcnLOeE2ewLL3DkWp8ZqKqi2LetnziNBN752MAwCayz3wtNJFXmqHc2KOr/TPjTAyKQczdi
	GO1SD0p5TqU6DhuguBdtkb2abqVSZk1O6I7yPvLo10B0HfnNVibZzDxsYr2x8Xr+ib2whFWAesy
	Ig8wZAWPI8DhGCitg9wix3mBurF4qjZb25+M=
X-Google-Smtp-Source: AGHT+IH3gpKYDo4I4W6vZUviFUykeYLQXJ8SQtcC29cIAP/LO5YVniTKS6ifnGSkSpKUYCTgTq98SA==
X-Received: by 2002:a17:903:2450:b0:240:8fd6:f798 with SMTP id d9443c01a7336-245febf32c3mr20200985ad.4.1755782194288;
        Thu, 21 Aug 2025 06:16:34 -0700 (PDT)
Received: from SaltyKitkat ([2602:fa4f:a30:6b83:f365:7bd1:5b7a:f317])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-245ed33df68sm55884335ad.21.2025.08.21.06.16.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 06:16:33 -0700 (PDT)
From: Sun YangKai <sunk67188@gmail.com>
To: linux-btrfs@vger.kernel.org
Cc: Sun YangKai <sunk67188@gmail.com>
Subject: [PATCH 2/2] btrfs: more trivial BTRFS_PATH_AUTO_FREE conversions
Date: Thu, 21 Aug 2025 21:12:24 +0800
Message-ID: <20250821131557.5185-3-sunk67188@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250821131557.5185-1-sunk67188@gmail.com>
References: <20250821131557.5185-1-sunk67188@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Trival pattern for the auto freeing with goto -> return convertions
if possible. No other function cleanup.

Signed-off-by: Sun YangKai <sunk67188@gmail.com>
---
 fs/btrfs/raid-stripe-tree.c |  16 +-
 fs/btrfs/ref-verify.c       |   3 +-
 fs/btrfs/reflink.c          |   3 +-
 fs/btrfs/relocation.c       |  66 +++-----
 fs/btrfs/root-tree.c        |  49 +++---
 fs/btrfs/scrub.c            |  11 +-
 fs/btrfs/send.c             | 307 +++++++++++++-----------------------
 fs/btrfs/super.c            |   9 +-
 fs/btrfs/tree-log.c         | 124 +++++----------
 9 files changed, 204 insertions(+), 384 deletions(-)

diff --git a/fs/btrfs/raid-stripe-tree.c b/fs/btrfs/raid-stripe-tree.c
index cab0b291088c..231107cafab2 100644
--- a/fs/btrfs/raid-stripe-tree.c
+++ b/fs/btrfs/raid-stripe-tree.c
@@ -67,7 +67,7 @@ int btrfs_delete_raid_extent(struct btrfs_trans_handle *trans, u64 start, u64 le
 {
 	struct btrfs_fs_info *fs_info = trans->fs_info;
 	struct btrfs_root *stripe_root = fs_info->stripe_root;
-	struct btrfs_path *path;
+	BTRFS_PATH_AUTO_FREE(path);
 	struct btrfs_key key;
 	struct extent_buffer *leaf;
 	u64 found_start;
@@ -260,7 +260,6 @@ int btrfs_delete_raid_extent(struct btrfs_trans_handle *trans, u64 start, u64 le
 		btrfs_release_path(path);
 	}
 
-	btrfs_free_path(path);
 	return ret;
 }
 
@@ -269,7 +268,7 @@ static int update_raid_extent_item(struct btrfs_trans_handle *trans,
 				   struct btrfs_stripe_extent *stripe_extent,
 				   const size_t item_size)
 {
-	struct btrfs_path *path;
+	BTRFS_PATH_AUTO_FREE(path);
 	struct extent_buffer *leaf;
 	int ret;
 	int slot;
@@ -288,7 +287,6 @@ static int update_raid_extent_item(struct btrfs_trans_handle *trans,
 
 	write_extent_buffer(leaf, stripe_extent, btrfs_item_ptr_offset(leaf, slot),
 			    item_size);
-	btrfs_free_path(path);
 
 	return ret;
 }
@@ -376,7 +374,7 @@ int btrfs_get_raid_extent_offset(struct btrfs_fs_info *fs_info,
 	struct btrfs_stripe_extent *stripe_extent;
 	struct btrfs_key stripe_key;
 	struct btrfs_key found_key;
-	struct btrfs_path *path;
+	BTRFS_PATH_AUTO_FREE(path);
 	struct extent_buffer *leaf;
 	const u64 end = logical + *length;
 	int num_stripes;
@@ -402,7 +400,7 @@ int btrfs_get_raid_extent_offset(struct btrfs_fs_info *fs_info,
 
 	ret = btrfs_search_slot(NULL, stripe_root, &stripe_key, path, 0, 0);
 	if (ret < 0)
-		goto free_path;
+		return ret;
 	if (ret) {
 		if (path->slots[0] != 0)
 			path->slots[0]--;
@@ -459,8 +457,7 @@ int btrfs_get_raid_extent_offset(struct btrfs_fs_info *fs_info,
 		trace_btrfs_get_raid_extent_offset(fs_info, logical, *length,
 						   stripe->physical, devid);
 
-		ret = 0;
-		goto free_path;
+		return 0;
 	}
 
 	/* If we're here, we haven't found the requested devid in the stripe. */
@@ -474,8 +471,5 @@ int btrfs_get_raid_extent_offset(struct btrfs_fs_info *fs_info,
 			  logical, logical + *length, stripe->dev->devid,
 			  btrfs_bg_type_to_raid_name(map_type));
 	}
-free_path:
-	btrfs_free_path(path);
-
 	return ret;
 }
diff --git a/fs/btrfs/ref-verify.c b/fs/btrfs/ref-verify.c
index 3871c3a6c743..cba14eb75c0a 100644
--- a/fs/btrfs/ref-verify.c
+++ b/fs/btrfs/ref-verify.c
@@ -971,7 +971,7 @@ void btrfs_free_ref_tree_range(struct btrfs_fs_info *fs_info, u64 start,
 int btrfs_build_ref_tree(struct btrfs_fs_info *fs_info)
 {
 	struct btrfs_root *extent_root;
-	struct btrfs_path *path;
+	BTRFS_PATH_AUTO_FREE(path);
 	struct extent_buffer *eb;
 	int tree_block_level = 0;
 	u64 bytenr = 0, num_bytes = 0;
@@ -1014,6 +1014,5 @@ int btrfs_build_ref_tree(struct btrfs_fs_info *fs_info)
 		btrfs_free_ref_cache(fs_info);
 		btrfs_clear_opt(fs_info->mount_opt, REF_VERIFY);
 	}
-	btrfs_free_path(path);
 	return ret;
 }
diff --git a/fs/btrfs/reflink.c b/fs/btrfs/reflink.c
index ce25ab7f0e99..98def02ce5cc 100644
--- a/fs/btrfs/reflink.c
+++ b/fs/btrfs/reflink.c
@@ -340,7 +340,7 @@ static int btrfs_clone(struct inode *src, struct inode *inode,
 		       const u64 destoff, int no_time_update)
 {
 	struct btrfs_fs_info *fs_info = inode_to_fs_info(inode);
-	struct btrfs_path *path = NULL;
+	BTRFS_PATH_AUTO_FREE(path);
 	struct extent_buffer *leaf;
 	struct btrfs_trans_handle *trans;
 	char *buf = NULL;
@@ -611,7 +611,6 @@ static int btrfs_clone(struct inode *src, struct inode *inode,
 	}
 
 out:
-	btrfs_free_path(path);
 	kvfree(buf);
 	clear_bit(BTRFS_INODE_NO_DELALLOC_FLUSH, &BTRFS_I(inode)->runtime_flags);
 
diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 7256f6748c8f..8b08d6e4cb2b 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -409,7 +409,7 @@ static noinline_for_stack struct btrfs_backref_node *build_backref_tree(
 	struct btrfs_backref_iter *iter;
 	struct btrfs_backref_cache *cache = &rc->backref_cache;
 	/* For searching parent of TREE_BLOCK_REF */
-	struct btrfs_path *path;
+	BTRFS_PATH_AUTO_FREE(path);
 	struct btrfs_backref_node *cur;
 	struct btrfs_backref_node *node = NULL;
 	struct btrfs_backref_edge *edge;
@@ -461,7 +461,6 @@ static noinline_for_stack struct btrfs_backref_node *build_backref_tree(
 out:
 	btrfs_free_path(iter->path);
 	kfree(iter);
-	btrfs_free_path(path);
 	if (ret) {
 		btrfs_backref_error_cleanup(cache, node);
 		return ERR_PTR(ret);
@@ -821,7 +820,7 @@ static int get_new_location(struct inode *reloc_inode, u64 *new_bytenr,
 			    u64 bytenr, u64 num_bytes)
 {
 	struct btrfs_root *root = BTRFS_I(reloc_inode)->root;
-	struct btrfs_path *path;
+	BTRFS_PATH_AUTO_FREE(path);
 	struct btrfs_file_extent_item *fi;
 	struct extent_buffer *leaf;
 	int ret;
@@ -834,11 +833,9 @@ static int get_new_location(struct inode *reloc_inode, u64 *new_bytenr,
 	ret = btrfs_lookup_file_extent(NULL, root, path,
 			btrfs_ino(BTRFS_I(reloc_inode)), bytenr, 0);
 	if (ret < 0)
-		goto out;
-	if (ret > 0) {
-		ret = -ENOENT;
-		goto out;
-	}
+		return ret;
+	if (ret > 0)
+		return -ENOENT;
 
 	leaf = path->nodes[0];
 	fi = btrfs_item_ptr(leaf, path->slots[0],
@@ -849,16 +846,11 @@ static int get_new_location(struct inode *reloc_inode, u64 *new_bytenr,
 	       btrfs_file_extent_encryption(leaf, fi) ||
 	       btrfs_file_extent_other_encoding(leaf, fi));
 
-	if (num_bytes != btrfs_file_extent_disk_num_bytes(leaf, fi)) {
-		ret = -EINVAL;
-		goto out;
-	}
+	if (num_bytes != btrfs_file_extent_disk_num_bytes(leaf, fi))
+		return -EINVAL;
 
 	*new_bytenr = btrfs_file_extent_disk_bytenr(leaf, fi);
-	ret = 0;
-out:
-	btrfs_free_path(path);
-	return ret;
+	return 0;
 }
 
 /*
@@ -1524,7 +1516,7 @@ static noinline_for_stack int merge_reloc_root(struct reloc_control *rc,
 	struct btrfs_trans_handle *trans = NULL;
 	struct btrfs_root *reloc_root;
 	struct btrfs_root_item *root_item;
-	struct btrfs_path *path;
+	BTRFS_PATH_AUTO_FREE(path);
 	struct extent_buffer *leaf;
 	int reserve_level;
 	int level;
@@ -1554,10 +1546,8 @@ static noinline_for_stack int merge_reloc_root(struct reloc_control *rc,
 		path->lowest_level = level;
 		ret = btrfs_search_slot(NULL, reloc_root, &key, path, 0, 0);
 		path->lowest_level = 0;
-		if (ret < 0) {
-			btrfs_free_path(path);
+		if (ret < 0)
 			return ret;
-		}
 
 		btrfs_node_key_to_cpu(path->nodes[level], &next_key,
 				      path->slots[level]);
@@ -1661,8 +1651,6 @@ static noinline_for_stack int merge_reloc_root(struct reloc_control *rc,
 	btrfs_tree_unlock(leaf);
 	free_extent_buffer(leaf);
 out:
-	btrfs_free_path(path);
-
 	if (ret == 0) {
 		ret = insert_dirty_subvol(trans, rc, root);
 		if (ret)
@@ -2608,7 +2596,7 @@ int relocate_tree_blocks(struct btrfs_trans_handle *trans,
 {
 	struct btrfs_fs_info *fs_info = rc->extent_root->fs_info;
 	struct btrfs_backref_node *node;
-	struct btrfs_path *path;
+	BTRFS_PATH_AUTO_FREE(path);
 	struct tree_block *block;
 	struct tree_block *next;
 	int ret = 0;
@@ -2632,7 +2620,7 @@ int relocate_tree_blocks(struct btrfs_trans_handle *trans,
 		if (!block->key_ready) {
 			ret = get_tree_block_key(fs_info, block);
 			if (ret)
-				goto out_free_path;
+				goto out_free_blocks;
 		}
 	}
 
@@ -2667,8 +2655,6 @@ int relocate_tree_blocks(struct btrfs_trans_handle *trans,
 out:
 	ret = finish_pending_nodes(trans, rc, path, ret);
 
-out_free_path:
-	btrfs_free_path(path);
 out_free_blocks:
 	free_block_list(blocks);
 	return ret;
@@ -3158,7 +3144,7 @@ static int __add_tree_block(struct reloc_control *rc,
 			    struct rb_root *blocks)
 {
 	struct btrfs_fs_info *fs_info = rc->extent_root->fs_info;
-	struct btrfs_path *path;
+	BTRFS_PATH_AUTO_FREE(path);
 	struct btrfs_key key;
 	int ret;
 	bool skinny = btrfs_fs_incompat(fs_info, SKINNY_METADATA);
@@ -3186,7 +3172,7 @@ static int __add_tree_block(struct reloc_control *rc,
 	path->skip_locking = 1;
 	ret = btrfs_search_slot(NULL, rc->extent_root, &key, path, 0, 0);
 	if (ret < 0)
-		goto out;
+		return ret;
 
 	if (ret > 0 && skinny) {
 		if (path->slots[0]) {
@@ -3213,14 +3199,10 @@ static int __add_tree_block(struct reloc_control *rc,
 	     "tree block extent item (%llu) is not found in extent tree",
 		     bytenr);
 		WARN_ON(1);
-		ret = -EINVAL;
-		goto out;
+		return -EINVAL;
 	}
 
-	ret = add_tree_block(rc, &key, path, blocks);
-out:
-	btrfs_free_path(path);
-	return ret;
+	return add_tree_block(rc, &key, path, blocks);
 }
 
 static int delete_block_group_cache(struct btrfs_block_group *block_group,
@@ -3510,7 +3492,7 @@ static noinline_for_stack int relocate_block_group(struct reloc_control *rc)
 	struct rb_root blocks = RB_ROOT;
 	struct btrfs_key key;
 	struct btrfs_trans_handle *trans = NULL;
-	struct btrfs_path *path;
+	BTRFS_PATH_AUTO_FREE(path);
 	struct btrfs_extent_item *ei;
 	u64 flags;
 	int ret;
@@ -3679,14 +3661,13 @@ static noinline_for_stack int relocate_block_group(struct reloc_control *rc)
 	if (ret < 0 && !err)
 		err = ret;
 	btrfs_free_block_rsv(fs_info, rc->block_rsv);
-	btrfs_free_path(path);
 	return err;
 }
 
 static int __insert_orphan_inode(struct btrfs_trans_handle *trans,
 				 struct btrfs_root *root, u64 objectid)
 {
-	struct btrfs_path *path;
+	BTRFS_PATH_AUTO_FREE(path);
 	struct btrfs_inode_item *item;
 	struct extent_buffer *leaf;
 	int ret;
@@ -3697,7 +3678,7 @@ static int __insert_orphan_inode(struct btrfs_trans_handle *trans,
 
 	ret = btrfs_insert_empty_inode(trans, root, path, objectid);
 	if (ret)
-		goto out;
+		return ret;
 
 	leaf = path->nodes[0];
 	item = btrfs_item_ptr(leaf, path->slots[0], struct btrfs_inode_item);
@@ -3707,15 +3688,13 @@ static int __insert_orphan_inode(struct btrfs_trans_handle *trans,
 	btrfs_set_inode_mode(leaf, item, S_IFREG | 0600);
 	btrfs_set_inode_flags(leaf, item, BTRFS_INODE_NOCOMPRESS |
 					  BTRFS_INODE_PREALLOC);
-out:
-	btrfs_free_path(path);
 	return ret;
 }
 
 static void delete_orphan_inode(struct btrfs_trans_handle *trans,
 				struct btrfs_root *root, u64 objectid)
 {
-	struct btrfs_path *path;
+	BTRFS_PATH_AUTO_FREE(path);
 	struct btrfs_key key;
 	int ret = 0;
 
@@ -3738,7 +3717,6 @@ static void delete_orphan_inode(struct btrfs_trans_handle *trans,
 out:
 	if (ret)
 		btrfs_abort_transaction(trans, ret);
-	btrfs_free_path(path);
 }
 
 /*
@@ -4080,7 +4058,7 @@ int btrfs_recover_relocation(struct btrfs_fs_info *fs_info)
 	struct btrfs_key key;
 	struct btrfs_root *fs_root;
 	struct btrfs_root *reloc_root;
-	struct btrfs_path *path;
+	BTRFS_PATH_AUTO_FREE(path);
 	struct extent_buffer *leaf;
 	struct reloc_control *rc = NULL;
 	struct btrfs_trans_handle *trans;
@@ -4229,8 +4207,6 @@ int btrfs_recover_relocation(struct btrfs_fs_info *fs_info)
 out:
 	free_reloc_roots(&reloc_roots);
 
-	btrfs_free_path(path);
-
 	if (ret == 0) {
 		/* cleanup orphan inode in data relocation tree */
 		fs_root = btrfs_grab_root(fs_info->data_reloc_root);
diff --git a/fs/btrfs/root-tree.c b/fs/btrfs/root-tree.c
index e22e6b06927a..b7bbcab6c12b 100644
--- a/fs/btrfs/root-tree.c
+++ b/fs/btrfs/root-tree.c
@@ -130,7 +130,7 @@ int btrfs_update_root(struct btrfs_trans_handle *trans, struct btrfs_root
 		      *item)
 {
 	struct btrfs_fs_info *fs_info = root->fs_info;
-	struct btrfs_path *path;
+	BTRFS_PATH_AUTO_FREE(path);
 	struct extent_buffer *l;
 	int ret;
 	int slot;
@@ -143,7 +143,7 @@ int btrfs_update_root(struct btrfs_trans_handle *trans, struct btrfs_root
 
 	ret = btrfs_search_slot(trans, root, key, path, 0, 1);
 	if (ret < 0)
-		goto out;
+		return ret;
 
 	if (ret > 0) {
 		btrfs_crit(fs_info,
@@ -151,7 +151,7 @@ int btrfs_update_root(struct btrfs_trans_handle *trans, struct btrfs_root
 			key->objectid, key->type, key->offset, btrfs_root_id(root));
 		ret = -EUCLEAN;
 		btrfs_abort_transaction(trans, ret);
-		goto out;
+		return ret;
 	}
 
 	l = path->nodes[0];
@@ -170,20 +170,20 @@ int btrfs_update_root(struct btrfs_trans_handle *trans, struct btrfs_root
 				-1, 1);
 		if (ret < 0) {
 			btrfs_abort_transaction(trans, ret);
-			goto out;
+			return ret;
 		}
 
 		ret = btrfs_del_item(trans, root, path);
 		if (ret < 0) {
 			btrfs_abort_transaction(trans, ret);
-			goto out;
+			return ret;
 		}
 		btrfs_release_path(path);
 		ret = btrfs_insert_empty_item(trans, root, path,
 				key, sizeof(*item));
 		if (ret < 0) {
 			btrfs_abort_transaction(trans, ret);
-			goto out;
+			return ret;
 		}
 		l = path->nodes[0];
 		slot = path->slots[0];
@@ -197,8 +197,6 @@ int btrfs_update_root(struct btrfs_trans_handle *trans, struct btrfs_root
 	btrfs_set_root_generation_v2(item, btrfs_root_generation(item));
 
 	write_extent_buffer(l, item, ptr, sizeof(*item));
-out:
-	btrfs_free_path(path);
 	return ret;
 }
 
@@ -216,7 +214,7 @@ int btrfs_find_orphan_roots(struct btrfs_fs_info *fs_info)
 {
 	struct btrfs_root *tree_root = fs_info->tree_root;
 	struct extent_buffer *leaf;
-	struct btrfs_path *path;
+	BTRFS_PATH_AUTO_FREE(path);
 	struct btrfs_key key;
 	struct btrfs_root *root;
 	int err = 0;
@@ -309,7 +307,6 @@ int btrfs_find_orphan_roots(struct btrfs_fs_info *fs_info)
 		btrfs_put_root(root);
 	}
 
-	btrfs_free_path(path);
 	return err;
 }
 
@@ -318,7 +315,7 @@ int btrfs_del_root(struct btrfs_trans_handle *trans,
 		   const struct btrfs_key *key)
 {
 	struct btrfs_root *root = trans->fs_info->tree_root;
-	struct btrfs_path *path;
+	BTRFS_PATH_AUTO_FREE(path);
 	int ret;
 
 	path = btrfs_alloc_path();
@@ -326,17 +323,14 @@ int btrfs_del_root(struct btrfs_trans_handle *trans,
 		return -ENOMEM;
 	ret = btrfs_search_slot(trans, root, key, path, -1, 1);
 	if (ret < 0)
-		goto out;
+		return ret;
 	if (ret != 0) {
 		/* The root must exist but we did not find it by the key. */
 		ret = -EUCLEAN;
-		goto out;
+		return ret;
 	}
 
-	ret = btrfs_del_item(trans, root, path);
-out:
-	btrfs_free_path(path);
-	return ret;
+	return btrfs_del_item(trans, root, path);
 }
 
 int btrfs_del_root_ref(struct btrfs_trans_handle *trans, u64 root_id,
@@ -344,7 +338,7 @@ int btrfs_del_root_ref(struct btrfs_trans_handle *trans, u64 root_id,
 		       const struct fscrypt_str *name)
 {
 	struct btrfs_root *tree_root = trans->fs_info->tree_root;
-	struct btrfs_path *path;
+	BTRFS_PATH_AUTO_FREE(path);
 	struct btrfs_root_ref *ref;
 	struct extent_buffer *leaf;
 	struct btrfs_key key;
@@ -361,7 +355,7 @@ int btrfs_del_root_ref(struct btrfs_trans_handle *trans, u64 root_id,
 again:
 	ret = btrfs_search_slot(trans, tree_root, &key, path, -1, 1);
 	if (ret < 0) {
-		goto out;
+		return ret;
 	} else if (ret == 0) {
 		leaf = path->nodes[0];
 		ref = btrfs_item_ptr(leaf, path->slots[0],
@@ -370,18 +364,15 @@ int btrfs_del_root_ref(struct btrfs_trans_handle *trans, u64 root_id,
 		if ((btrfs_root_ref_dirid(leaf, ref) != dirid) ||
 		    (btrfs_root_ref_name_len(leaf, ref) != name->len) ||
 		    memcmp_extent_buffer(leaf, name->name, ptr, name->len)) {
-			ret = -ENOENT;
-			goto out;
+			return -ENOENT;
 		}
 		*sequence = btrfs_root_ref_sequence(leaf, ref);
 
 		ret = btrfs_del_item(trans, tree_root, path);
 		if (ret)
-			goto out;
-	} else {
-		ret = -ENOENT;
-		goto out;
-	}
+			return ret;
+	} else
+		return -ENOENT;
 
 	if (key.type == BTRFS_ROOT_BACKREF_KEY) {
 		btrfs_release_path(path);
@@ -391,8 +382,6 @@ int btrfs_del_root_ref(struct btrfs_trans_handle *trans, u64 root_id,
 		goto again;
 	}
 
-out:
-	btrfs_free_path(path);
 	return ret;
 }
 
@@ -418,7 +407,7 @@ int btrfs_add_root_ref(struct btrfs_trans_handle *trans, u64 root_id,
 	struct btrfs_root *tree_root = trans->fs_info->tree_root;
 	struct btrfs_key key;
 	int ret;
-	struct btrfs_path *path;
+	BTRFS_PATH_AUTO_FREE(path);
 	struct btrfs_root_ref *ref;
 	struct extent_buffer *leaf;
 	unsigned long ptr;
@@ -435,7 +424,6 @@ int btrfs_add_root_ref(struct btrfs_trans_handle *trans, u64 root_id,
 				      sizeof(*ref) + name->len);
 	if (ret) {
 		btrfs_abort_transaction(trans, ret);
-		btrfs_free_path(path);
 		return ret;
 	}
 
@@ -455,7 +443,6 @@ int btrfs_add_root_ref(struct btrfs_trans_handle *trans, u64 root_id,
 		goto again;
 	}
 
-	btrfs_free_path(path);
 	return 0;
 }
 
diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 6776e6ab8d10..025a91d267b4 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -585,7 +585,7 @@ static void scrub_print_common_warning(const char *errstr, struct btrfs_device *
 				       bool is_super, u64 logical, u64 physical)
 {
 	struct btrfs_fs_info *fs_info = dev->fs_info;
-	struct btrfs_path *path;
+	BTRFS_PATH_AUTO_FREE(path);
 	struct btrfs_key found_key;
 	struct extent_buffer *eb;
 	struct btrfs_extent_item *ei;
@@ -612,7 +612,7 @@ static void scrub_print_common_warning(const char *errstr, struct btrfs_device *
 	ret = extent_from_logical(fs_info, swarn.logical, path, &found_key,
 				  &flags);
 	if (ret < 0)
-		goto out;
+		return;
 
 	swarn.extent_item_size = found_key.offset;
 
@@ -658,9 +658,6 @@ static void scrub_print_common_warning(const char *errstr, struct btrfs_device *
 
 		iterate_extent_inodes(&ctx, true, scrub_print_warning_inode, &swarn);
 	}
-
-out:
-	btrfs_free_path(path);
 }
 
 static int fill_writer_pointer_gap(struct scrub_ctx *sctx, u64 physical)
@@ -2586,7 +2583,7 @@ int scrub_enumerate_chunks(struct scrub_ctx *sctx,
 			   struct btrfs_device *scrub_dev, u64 start, u64 end)
 {
 	struct btrfs_dev_extent *dev_extent = NULL;
-	struct btrfs_path *path;
+	BTRFS_PATH_AUTO_FREE(path);
 	struct btrfs_fs_info *fs_info = sctx->fs_info;
 	struct btrfs_root *root = fs_info->dev_root;
 	u64 chunk_offset;
@@ -2872,8 +2869,6 @@ int scrub_enumerate_chunks(struct scrub_ctx *sctx,
 		btrfs_release_path(path);
 	}
 
-	btrfs_free_path(path);
-
 	return ret;
 }
 
diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index 5010d17878f9..fd586151068a 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -909,7 +909,7 @@ static int get_inode_info(struct btrfs_root *root, u64 ino,
 			  struct btrfs_inode_info *info)
 {
 	int ret;
-	struct btrfs_path *path;
+	BTRFS_PATH_AUTO_FREE(path);
 	struct btrfs_inode_item *ii;
 	struct btrfs_key key;
 
@@ -927,7 +927,7 @@ static int get_inode_info(struct btrfs_root *root, u64 ino,
 	if (ret) {
 		if (ret > 0)
 			ret = -ENOENT;
-		goto out;
+		return ret;
 	}
 
 	ii = btrfs_item_ptr(path->nodes[0], path->slots[0],
@@ -945,9 +945,7 @@ static int get_inode_info(struct btrfs_root *root, u64 ino,
 	 */
 	info->fileattr = btrfs_inode_flags(path->nodes[0], ii);
 
-out:
-	btrfs_free_path(path);
-	return ret;
+	return 0;
 }
 
 static int get_inode_gen(struct btrfs_root *root, u64 ino, u64 *gen)
@@ -979,7 +977,7 @@ static int iterate_inode_ref(struct btrfs_root *root, struct btrfs_path *path,
 	struct extent_buffer *eb = path->nodes[0];
 	struct btrfs_inode_ref *iref;
 	struct btrfs_inode_extref *extref;
-	struct btrfs_path *tmp_path;
+	BTRFS_PATH_AUTO_FREE(tmp_path);
 	struct fs_path *p;
 	u32 cur = 0;
 	u32 total;
@@ -1076,7 +1074,6 @@ static int iterate_inode_ref(struct btrfs_root *root, struct btrfs_path *path,
 	}
 
 out:
-	btrfs_free_path(tmp_path);
 	fs_path_free(p);
 	return ret;
 }
@@ -1224,7 +1221,7 @@ static int get_inode_path(struct btrfs_root *root,
 {
 	int ret;
 	struct btrfs_key key, found_key;
-	struct btrfs_path *p;
+	BTRFS_PATH_AUTO_FREE(p);
 
 	p = alloc_path_for_send();
 	if (!p)
@@ -1238,28 +1235,22 @@ static int get_inode_path(struct btrfs_root *root,
 
 	ret = btrfs_search_slot_for_read(root, &key, p, 1, 0);
 	if (ret < 0)
-		goto out;
-	if (ret) {
-		ret = 1;
-		goto out;
-	}
+		return ret;
+	if (ret)
+		return 1;
+
 	btrfs_item_key_to_cpu(p->nodes[0], &found_key, p->slots[0]);
 	if (found_key.objectid != ino ||
 	    (found_key.type != BTRFS_INODE_REF_KEY &&
 	     found_key.type != BTRFS_INODE_EXTREF_KEY)) {
-		ret = -ENOENT;
-		goto out;
+		return -ENOENT;
 	}
 
 	ret = iterate_inode_ref(root, p, &found_key, 1,
 				__copy_first_ref, path);
 	if (ret < 0)
-		goto out;
-	ret = 0;
-
-out:
-	btrfs_free_path(p);
-	return ret;
+		return ret;
+	return 0;
 }
 
 struct backref_ctx {
@@ -1716,7 +1707,7 @@ static int read_symlink(struct btrfs_root *root,
 			struct fs_path *dest)
 {
 	int ret;
-	struct btrfs_path *path;
+	BTRFS_PATH_AUTO_FREE(path);
 	struct btrfs_key key;
 	struct btrfs_file_extent_item *ei;
 	u8 type;
@@ -1733,7 +1724,7 @@ static int read_symlink(struct btrfs_root *root,
 	key.offset = 0;
 	ret = btrfs_search_slot(NULL, root, &key, path, 0, 0);
 	if (ret < 0)
-		goto out;
+		return ret;
 	if (ret) {
 		/*
 		 * An empty symlink inode. Can happen in rare error paths when
@@ -1746,8 +1737,7 @@ static int read_symlink(struct btrfs_root *root,
 		btrfs_err(root->fs_info,
 			  "Found empty symlink inode %llu at root %llu",
 			  ino, btrfs_root_id(root));
-		ret = -EIO;
-		goto out;
+		return -EIO;
 	}
 
 	ei = btrfs_item_ptr(path->nodes[0], path->slots[0],
@@ -1758,7 +1748,7 @@ static int read_symlink(struct btrfs_root *root,
 		btrfs_crit(root->fs_info,
 "send: found symlink extent that is not inline, ino %llu root %llu extent type %d",
 			   ino, btrfs_root_id(root), type);
-		goto out;
+		return ret;
 	}
 	compression = btrfs_file_extent_compression(path->nodes[0], ei);
 	if (unlikely(compression != BTRFS_COMPRESS_NONE)) {
@@ -1766,17 +1756,13 @@ static int read_symlink(struct btrfs_root *root,
 		btrfs_crit(root->fs_info,
 "send: found symlink extent with compression, ino %llu root %llu compression type %d",
 			   ino, btrfs_root_id(root), compression);
-		goto out;
+		return ret;
 	}
 
 	off = btrfs_file_extent_inline_start(ei);
 	len = btrfs_file_extent_ram_bytes(path->nodes[0], ei);
 
-	ret = fs_path_add_from_extent_buffer(dest, path->nodes[0], off, len);
-
-out:
-	btrfs_free_path(path);
-	return ret;
+	return fs_path_add_from_extent_buffer(dest, path->nodes[0], off, len);
 }
 
 /*
@@ -1787,8 +1773,7 @@ static int gen_unique_name(struct send_ctx *sctx,
 			   u64 ino, u64 gen,
 			   struct fs_path *dest)
 {
-	int ret = 0;
-	struct btrfs_path *path;
+	BTRFS_PATH_AUTO_FREE(path);
 	struct btrfs_dir_item *di;
 	char tmp[64];
 	int len;
@@ -1811,10 +1796,8 @@ static int gen_unique_name(struct send_ctx *sctx,
 				path, BTRFS_FIRST_FREE_OBJECTID,
 				&tmp_name, 0);
 		btrfs_release_path(path);
-		if (IS_ERR(di)) {
-			ret = PTR_ERR(di);
-			goto out;
-		}
+		if (IS_ERR(di))
+			return PTR_ERR(di);
 		if (di) {
 			/* not unique, try again */
 			idx++;
@@ -1823,7 +1806,6 @@ static int gen_unique_name(struct send_ctx *sctx,
 
 		if (!sctx->parent_root) {
 			/* unique */
-			ret = 0;
 			break;
 		}
 
@@ -1831,10 +1813,8 @@ static int gen_unique_name(struct send_ctx *sctx,
 				path, BTRFS_FIRST_FREE_OBJECTID,
 				&tmp_name, 0);
 		btrfs_release_path(path);
-		if (IS_ERR(di)) {
-			ret = PTR_ERR(di);
-			goto out;
-		}
+		if (IS_ERR(di))
+			return PTR_ERR(di);
 		if (di) {
 			/* not unique, try again */
 			idx++;
@@ -1844,11 +1824,7 @@ static int gen_unique_name(struct send_ctx *sctx,
 		break;
 	}
 
-	ret = fs_path_add(dest, tmp, len);
-
-out:
-	btrfs_free_path(path);
-	return ret;
+	return fs_path_add(dest, tmp, len);
 }
 
 enum inode_state {
@@ -1960,7 +1936,7 @@ static int lookup_dir_item_inode(struct btrfs_root *root,
 	int ret = 0;
 	struct btrfs_dir_item *di;
 	struct btrfs_key key;
-	struct btrfs_path *path;
+	BTRFS_PATH_AUTO_FREE(path);
 	struct fscrypt_str name_str = FSTR_INIT((char *)name, name_len);
 
 	path = alloc_path_for_send();
@@ -1968,19 +1944,15 @@ static int lookup_dir_item_inode(struct btrfs_root *root,
 		return -ENOMEM;
 
 	di = btrfs_lookup_dir_item(NULL, root, path, dir, &name_str, 0);
-	if (IS_ERR_OR_NULL(di)) {
-		ret = di ? PTR_ERR(di) : -ENOENT;
-		goto out;
-	}
+	if (IS_ERR_OR_NULL(di))
+		return di ? PTR_ERR(di) : -ENOENT;
+
 	btrfs_dir_item_key_to_cpu(path->nodes[0], di, &key);
-	if (key.type == BTRFS_ROOT_ITEM_KEY) {
-		ret = -ENOENT;
-		goto out;
-	}
+	if (key.type == BTRFS_ROOT_ITEM_KEY)
+		return -ENOENT;
+
 	*found_inode = key.objectid;
 
-out:
-	btrfs_free_path(path);
 	return ret;
 }
 
@@ -1994,7 +1966,7 @@ static int get_first_ref(struct btrfs_root *root, u64 ino,
 	int ret;
 	struct btrfs_key key;
 	struct btrfs_key found_key;
-	struct btrfs_path *path;
+	BTRFS_PATH_AUTO_FREE(path);
 	int len;
 	u64 parent_dir;
 
@@ -2008,15 +1980,14 @@ static int get_first_ref(struct btrfs_root *root, u64 ino,
 
 	ret = btrfs_search_slot_for_read(root, &key, path, 1, 0);
 	if (ret < 0)
-		goto out;
+		return ret;
 	if (!ret)
 		btrfs_item_key_to_cpu(path->nodes[0], &found_key,
 				path->slots[0]);
 	if (ret || found_key.objectid != ino ||
 	    (found_key.type != BTRFS_INODE_REF_KEY &&
 	     found_key.type != BTRFS_INODE_EXTREF_KEY)) {
-		ret = -ENOENT;
-		goto out;
+		return -ENOENT;
 	}
 
 	if (found_key.type == BTRFS_INODE_REF_KEY) {
@@ -2038,19 +2009,17 @@ static int get_first_ref(struct btrfs_root *root, u64 ino,
 		parent_dir = btrfs_inode_extref_parent(path->nodes[0], extref);
 	}
 	if (ret < 0)
-		goto out;
+		return ret;
 	btrfs_release_path(path);
 
 	if (dir_gen) {
 		ret = get_inode_gen(root, parent_dir, dir_gen);
 		if (ret < 0)
-			goto out;
+			return ret;
 	}
 
 	*dir = parent_dir;
 
-out:
-	btrfs_free_path(path);
 	return ret;
 }
 
@@ -2486,7 +2455,7 @@ static int send_subvol_begin(struct send_ctx *sctx)
 	int ret;
 	struct btrfs_root *send_root = sctx->send_root;
 	struct btrfs_root *parent_root = sctx->parent_root;
-	struct btrfs_path *path;
+	BTRFS_PATH_AUTO_FREE(path);
 	struct btrfs_key key;
 	struct btrfs_root_ref *ref;
 	struct extent_buffer *leaf;
@@ -2499,7 +2468,6 @@ static int send_subvol_begin(struct send_ctx *sctx)
 
 	name = kmalloc(BTRFS_PATH_NAME_MAX, GFP_KERNEL);
 	if (!name) {
-		btrfs_free_path(path);
 		return -ENOMEM;
 	}
 
@@ -2564,7 +2532,6 @@ static int send_subvol_begin(struct send_ctx *sctx)
 
 tlv_put_failure:
 out:
-	btrfs_free_path(path);
 	kfree(name);
 	return ret;
 }
@@ -2715,7 +2682,7 @@ static int send_utimes(struct send_ctx *sctx, u64 ino, u64 gen)
 	int ret = 0;
 	struct fs_path *p = NULL;
 	struct btrfs_inode_item *ii;
-	struct btrfs_path *path = NULL;
+	BTRFS_PATH_AUTO_FREE(path);
 	struct extent_buffer *eb;
 	struct btrfs_key key;
 	int slot;
@@ -2759,7 +2726,6 @@ static int send_utimes(struct send_ctx *sctx, u64 ino, u64 gen)
 tlv_put_failure:
 out:
 	free_path_for_command(sctx, p);
-	btrfs_free_path(path);
 	return ret;
 }
 
@@ -2930,7 +2896,7 @@ static int did_create_dir(struct send_ctx *sctx, u64 dir)
 {
 	int ret = 0;
 	int iter_ret = 0;
-	struct btrfs_path *path = NULL;
+	BTRFS_PATH_AUTO_FREE(path);
 	struct btrfs_key key;
 	struct btrfs_key found_key;
 	struct btrfs_key di_key;
@@ -2970,7 +2936,6 @@ static int did_create_dir(struct send_ctx *sctx, u64 dir)
 	if (iter_ret < 0)
 		ret = iter_ret;
 
-	btrfs_free_path(path);
 	return ret;
 }
 
@@ -3185,7 +3150,7 @@ static int can_rmdir(struct send_ctx *sctx, u64 dir, u64 dir_gen)
 	int ret = 0;
 	int iter_ret = 0;
 	struct btrfs_root *root = sctx->parent_root;
-	struct btrfs_path *path;
+	BTRFS_PATH_AUTO_FREE(path);
 	struct btrfs_key key;
 	struct btrfs_key found_key;
 	struct btrfs_key loc;
@@ -3293,8 +3258,6 @@ static int can_rmdir(struct send_ctx *sctx, u64 dir, u64 dir_gen)
 	ret = 1;
 
 out:
-	btrfs_free_path(path);
-
 	if (ret)
 		return ret;
 
@@ -3750,7 +3713,7 @@ static int wait_for_dest_dir_move(struct send_ctx *sctx,
 				  struct recorded_ref *parent_ref,
 				  const bool is_orphan)
 {
-	struct btrfs_path *path;
+	BTRFS_PATH_AUTO_FREE(path);
 	struct btrfs_key key;
 	struct btrfs_key di_key;
 	struct btrfs_dir_item *di;
@@ -3771,19 +3734,15 @@ static int wait_for_dest_dir_move(struct send_ctx *sctx,
 	key.offset = btrfs_name_hash(parent_ref->name, parent_ref->name_len);
 
 	ret = btrfs_search_slot(NULL, sctx->parent_root, &key, path, 0, 0);
-	if (ret < 0) {
-		goto out;
-	} else if (ret > 0) {
-		ret = 0;
-		goto out;
-	}
+	if (ret < 0)
+		return ret;
+	if (ret > 0)
+		return 0;
 
 	di = btrfs_match_dir_item_name(path, parent_ref->name,
 				       parent_ref->name_len);
-	if (!di) {
-		ret = 0;
-		goto out;
-	}
+	if (!di)
+		return 0;
 	/*
 	 * di_key.objectid has the number of the inode that has a dentry in the
 	 * parent directory with the same name that sctx->cur_ino is being
@@ -3793,26 +3752,22 @@ static int wait_for_dest_dir_move(struct send_ctx *sctx,
 	 * that it happens after that other inode is renamed.
 	 */
 	btrfs_dir_item_key_to_cpu(path->nodes[0], di, &di_key);
-	if (di_key.type != BTRFS_INODE_ITEM_KEY) {
-		ret = 0;
-		goto out;
-	}
+	if (di_key.type != BTRFS_INODE_ITEM_KEY)
+		return 0;
 
 	ret = get_inode_gen(sctx->parent_root, di_key.objectid, &left_gen);
 	if (ret < 0)
-		goto out;
+		return ret;
 	ret = get_inode_gen(sctx->send_root, di_key.objectid, &right_gen);
 	if (ret < 0) {
 		if (ret == -ENOENT)
 			ret = 0;
-		goto out;
+		return ret;
 	}
 
 	/* Different inode, no need to delay the rename of sctx->cur_ino */
-	if (right_gen != left_gen) {
-		ret = 0;
-		goto out;
-	}
+	if (right_gen != left_gen)
+		return 0;
 
 	wdm = get_waiting_dir_move(sctx, di_key.objectid);
 	if (wdm && !wdm->orphanized) {
@@ -3826,8 +3781,6 @@ static int wait_for_dest_dir_move(struct send_ctx *sctx,
 		if (!ret)
 			ret = 1;
 	}
-out:
-	btrfs_free_path(path);
 	return ret;
 }
 
@@ -3877,7 +3830,7 @@ static int is_ancestor(struct btrfs_root *root,
 	bool free_fs_path = false;
 	int ret = 0;
 	int iter_ret = 0;
-	struct btrfs_path *path = NULL;
+	BTRFS_PATH_AUTO_FREE(path);
 	struct btrfs_key key;
 
 	if (!fs_path) {
@@ -3945,7 +3898,6 @@ static int is_ancestor(struct btrfs_root *root,
 		ret = iter_ret;
 
 out:
-	btrfs_free_path(path);
 	if (free_fs_path)
 		fs_path_free(fs_path);
 	return ret;
@@ -4803,7 +4755,7 @@ static int process_all_refs(struct send_ctx *sctx,
 	int ret = 0;
 	int iter_ret = 0;
 	struct btrfs_root *root;
-	struct btrfs_path *path;
+	BTRFS_PATH_AUTO_FREE(path);
 	struct btrfs_key key;
 	struct btrfs_key found_key;
 	iterate_inode_ref_t cb;
@@ -4822,8 +4774,7 @@ static int process_all_refs(struct send_ctx *sctx,
 	} else {
 		btrfs_err(sctx->send_root->fs_info,
 				"Wrong command %d in process_all_refs", cmd);
-		ret = -EINVAL;
-		goto out;
+		return -EINVAL;
 	}
 
 	key.objectid = sctx->cmp_key->objectid;
@@ -4837,13 +4788,12 @@ static int process_all_refs(struct send_ctx *sctx,
 
 		ret = iterate_inode_ref(root, path, &found_key, 0, cb, sctx);
 		if (ret < 0)
-			goto out;
+			return ret;
 	}
 	/* Catch error found during iteration */
-	if (iter_ret < 0) {
-		ret = iter_ret;
-		goto out;
-	}
+	if (iter_ret < 0)
+		return iter_ret;
+
 	btrfs_release_path(path);
 
 	/*
@@ -4851,10 +4801,7 @@ static int process_all_refs(struct send_ctx *sctx,
 	 * re-creating this inode and will be rename'ing it into place once we
 	 * rename the parent directory.
 	 */
-	ret = process_recorded_refs(sctx, &pending_move);
-out:
-	btrfs_free_path(path);
-	return ret;
+	return process_recorded_refs(sctx, &pending_move);
 }
 
 static int send_set_xattr(struct send_ctx *sctx,
@@ -5080,7 +5027,7 @@ static int process_all_new_xattrs(struct send_ctx *sctx)
 	int ret = 0;
 	int iter_ret = 0;
 	struct btrfs_root *root;
-	struct btrfs_path *path;
+	BTRFS_PATH_AUTO_FREE(path);
 	struct btrfs_key key;
 	struct btrfs_key found_key;
 
@@ -5108,7 +5055,6 @@ static int process_all_new_xattrs(struct send_ctx *sctx)
 	if (iter_ret < 0)
 		ret = iter_ret;
 
-	btrfs_free_path(path);
 	return ret;
 }
 
@@ -5766,7 +5712,7 @@ static int send_extent_data(struct send_ctx *sctx, struct btrfs_path *path,
  */
 static int send_capabilities(struct send_ctx *sctx)
 {
-	struct btrfs_path *path;
+	BTRFS_PATH_AUTO_FREE(path);
 	struct btrfs_dir_item *di;
 	struct extent_buffer *leaf;
 	unsigned long data_ptr;
@@ -5804,7 +5750,6 @@ static int send_capabilities(struct send_ctx *sctx)
 			strlen(XATTR_NAME_CAPS), buf, buf_len);
 out:
 	kfree(buf);
-	btrfs_free_path(path);
 	return ret;
 }
 
@@ -5812,7 +5757,7 @@ static int clone_range(struct send_ctx *sctx, struct btrfs_path *dst_path,
 		       struct clone_root *clone_root, const u64 disk_byte,
 		       u64 data_offset, u64 offset, u64 len)
 {
-	struct btrfs_path *path;
+	BTRFS_PATH_AUTO_FREE(path);
 	struct btrfs_key key;
 	int ret;
 	struct btrfs_inode_info info;
@@ -5848,7 +5793,7 @@ static int clone_range(struct send_ctx *sctx, struct btrfs_path *dst_path,
 	ret = get_inode_info(clone_root->root, clone_root->ino, &info);
 	btrfs_release_path(path);
 	if (ret < 0)
-		goto out;
+		return ret;
 	clone_src_i_size = info.size;
 
 	/*
@@ -5878,7 +5823,7 @@ static int clone_range(struct send_ctx *sctx, struct btrfs_path *dst_path,
 	key.offset = clone_root->offset;
 	ret = btrfs_search_slot(NULL, clone_root->root, &key, path, 0, 0);
 	if (ret < 0)
-		goto out;
+		return ret;
 	if (ret > 0 && path->slots[0] > 0) {
 		btrfs_item_key_to_cpu(path->nodes[0], &key, path->slots[0] - 1);
 		if (key.objectid == clone_root->ino &&
@@ -5899,8 +5844,8 @@ static int clone_range(struct send_ctx *sctx, struct btrfs_path *dst_path,
 		if (slot >= btrfs_header_nritems(leaf)) {
 			ret = btrfs_next_leaf(clone_root->root, path);
 			if (ret < 0)
-				goto out;
-			else if (ret > 0)
+				return ret;
+			if (ret > 0)
 				break;
 			continue;
 		}
@@ -5936,7 +5881,7 @@ static int clone_range(struct send_ctx *sctx, struct btrfs_path *dst_path,
 			ret = send_extent_data(sctx, dst_path, offset,
 					       hole_len);
 			if (ret < 0)
-				goto out;
+				return ret;
 
 			len -= hole_len;
 			if (len == 0)
@@ -6007,7 +5952,7 @@ static int clone_range(struct send_ctx *sctx, struct btrfs_path *dst_path,
 					ret = send_clone(sctx, offset, slen,
 							 clone_root);
 					if (ret < 0)
-						goto out;
+						return ret;
 				}
 				ret = send_extent_data(sctx, dst_path,
 						       offset + slen,
@@ -6041,7 +5986,7 @@ static int clone_range(struct send_ctx *sctx, struct btrfs_path *dst_path,
 		}
 
 		if (ret < 0)
-			goto out;
+			return ret;
 
 		len -= clone_len;
 		if (len == 0)
@@ -6072,8 +6017,6 @@ static int clone_range(struct send_ctx *sctx, struct btrfs_path *dst_path,
 		ret = send_extent_data(sctx, dst_path, offset, len);
 	else
 		ret = 0;
-out:
-	btrfs_free_path(path);
 	return ret;
 }
 
@@ -6162,7 +6105,7 @@ static int is_extent_unchanged(struct send_ctx *sctx,
 {
 	int ret = 0;
 	struct btrfs_key key;
-	struct btrfs_path *path = NULL;
+	BTRFS_PATH_AUTO_FREE(path);
 	struct extent_buffer *eb;
 	int slot;
 	struct btrfs_key found_key;
@@ -6188,10 +6131,9 @@ static int is_extent_unchanged(struct send_ctx *sctx,
 	ei = btrfs_item_ptr(eb, slot, struct btrfs_file_extent_item);
 	left_type = btrfs_file_extent_type(eb, ei);
 
-	if (left_type != BTRFS_FILE_EXTENT_REG) {
-		ret = 0;
-		goto out;
-	}
+	if (left_type != BTRFS_FILE_EXTENT_REG)
+		return 0;
+
 	left_disknr = btrfs_file_extent_disk_bytenr(eb, ei);
 	left_len = btrfs_file_extent_num_bytes(eb, ei);
 	left_offset = btrfs_file_extent_offset(eb, ei);
@@ -6223,11 +6165,9 @@ static int is_extent_unchanged(struct send_ctx *sctx,
 	key.offset = ekey->offset;
 	ret = btrfs_search_slot_for_read(sctx->parent_root, &key, path, 0, 0);
 	if (ret < 0)
-		goto out;
-	if (ret) {
-		ret = 0;
-		goto out;
-	}
+		return ret;
+	if (ret)
+		return 0;
 
 	/*
 	 * Handle special case where the right side has no extents at all.
@@ -6236,11 +6176,9 @@ static int is_extent_unchanged(struct send_ctx *sctx,
 	slot = path->slots[0];
 	btrfs_item_key_to_cpu(eb, &found_key, slot);
 	if (found_key.objectid != key.objectid ||
-	    found_key.type != key.type) {
+	    found_key.type != key.type)
 		/* If we're a hole then just pretend nothing changed */
-		ret = (left_disknr) ? 0 : 1;
-		goto out;
-	}
+		return (left_disknr) ? 0 : 1;
 
 	/*
 	 * We're now on 2a, 2b or 7.
@@ -6250,10 +6188,8 @@ static int is_extent_unchanged(struct send_ctx *sctx,
 		ei = btrfs_item_ptr(eb, slot, struct btrfs_file_extent_item);
 		right_type = btrfs_file_extent_type(eb, ei);
 		if (right_type != BTRFS_FILE_EXTENT_REG &&
-		    right_type != BTRFS_FILE_EXTENT_INLINE) {
-			ret = 0;
-			goto out;
-		}
+		    right_type != BTRFS_FILE_EXTENT_INLINE)
+			return 0;
 
 		if (right_type == BTRFS_FILE_EXTENT_INLINE) {
 			right_len = btrfs_file_extent_ram_bytes(eb, ei);
@@ -6266,11 +6202,9 @@ static int is_extent_unchanged(struct send_ctx *sctx,
 		 * Are we at extent 8? If yes, we know the extent is changed.
 		 * This may only happen on the first iteration.
 		 */
-		if (found_key.offset + right_len <= ekey->offset) {
+		if (found_key.offset + right_len <= ekey->offset)
 			/* If we're a hole just pretend nothing changed */
-			ret = (left_disknr) ? 0 : 1;
-			goto out;
-		}
+			return (left_disknr) ? 0 : 1;
 
 		/*
 		 * We just wanted to see if when we have an inline extent, what
@@ -6280,10 +6214,8 @@ static int is_extent_unchanged(struct send_ctx *sctx,
 		 * compressed extent representing data with a size matching
 		 * the page size (currently the same as sector size).
 		 */
-		if (right_type == BTRFS_FILE_EXTENT_INLINE) {
-			ret = 0;
-			goto out;
-		}
+		if (right_type == BTRFS_FILE_EXTENT_INLINE)
+			return 0;
 
 		right_disknr = btrfs_file_extent_disk_bytenr(eb, ei);
 		right_offset = btrfs_file_extent_offset(eb, ei);
@@ -6303,17 +6235,15 @@ static int is_extent_unchanged(struct send_ctx *sctx,
 		 */
 		if (left_disknr != right_disknr ||
 		    left_offset_fixed != right_offset ||
-		    left_gen != right_gen) {
-			ret = 0;
-			goto out;
-		}
+		    left_gen != right_gen)
+			return 0;
 
 		/*
 		 * Go to the next extent.
 		 */
 		ret = btrfs_next_item(sctx->parent_root, path);
 		if (ret < 0)
-			goto out;
+			return ret;
 		if (!ret) {
 			eb = path->nodes[0];
 			slot = path->slots[0];
@@ -6324,10 +6254,9 @@ static int is_extent_unchanged(struct send_ctx *sctx,
 			key.offset += right_len;
 			break;
 		}
-		if (found_key.offset != key.offset + right_len) {
-			ret = 0;
-			goto out;
-		}
+		if (found_key.offset != key.offset + right_len)
+			return 0;
+
 		key = found_key;
 	}
 
@@ -6340,15 +6269,12 @@ static int is_extent_unchanged(struct send_ctx *sctx,
 	else
 		ret = 0;
 
-
-out:
-	btrfs_free_path(path);
 	return ret;
 }
 
 static int get_last_extent(struct send_ctx *sctx, u64 offset)
 {
-	struct btrfs_path *path;
+	BTRFS_PATH_AUTO_FREE(path);
 	struct btrfs_root *root = sctx->send_root;
 	struct btrfs_key key;
 	int ret;
@@ -6364,15 +6290,13 @@ static int get_last_extent(struct send_ctx *sctx, u64 offset)
 	key.offset = offset;
 	ret = btrfs_search_slot_for_read(root, &key, path, 0, 1);
 	if (ret < 0)
-		goto out;
+		return ret;
 	ret = 0;
 	btrfs_item_key_to_cpu(path->nodes[0], &key, path->slots[0]);
 	if (key.objectid != sctx->cur_ino || key.type != BTRFS_EXTENT_DATA_KEY)
-		goto out;
+		return ret;
 
 	sctx->cur_inode_last_extent = btrfs_file_extent_end(path);
-out:
-	btrfs_free_path(path);
 	return ret;
 }
 
@@ -6380,7 +6304,7 @@ static int range_is_hole_in_parent(struct send_ctx *sctx,
 				   const u64 start,
 				   const u64 end)
 {
-	struct btrfs_path *path;
+	BTRFS_PATH_AUTO_FREE(path);
 	struct btrfs_key key;
 	struct btrfs_root *root = sctx->parent_root;
 	u64 search_start = start;
@@ -6395,7 +6319,7 @@ static int range_is_hole_in_parent(struct send_ctx *sctx,
 	key.offset = search_start;
 	ret = btrfs_search_slot(NULL, root, &key, path, 0, 0);
 	if (ret < 0)
-		goto out;
+		return ret;
 	if (ret > 0 && path->slots[0] > 0)
 		path->slots[0]--;
 
@@ -6408,8 +6332,8 @@ static int range_is_hole_in_parent(struct send_ctx *sctx,
 		if (slot >= btrfs_header_nritems(leaf)) {
 			ret = btrfs_next_leaf(root, path);
 			if (ret < 0)
-				goto out;
-			else if (ret > 0)
+				return ret;
+			if (ret > 0)
 				break;
 			continue;
 		}
@@ -6431,15 +6355,11 @@ static int range_is_hole_in_parent(struct send_ctx *sctx,
 			search_start = extent_end;
 			goto next;
 		}
-		ret = 0;
-		goto out;
+		return 0;
 next:
 		path->slots[0]++;
 	}
-	ret = 1;
-out:
-	btrfs_free_path(path);
-	return ret;
+	return 1;
 }
 
 static int maybe_send_hole(struct send_ctx *sctx, struct btrfs_path *path,
@@ -6547,7 +6467,7 @@ static int process_all_extents(struct send_ctx *sctx)
 	int ret = 0;
 	int iter_ret = 0;
 	struct btrfs_root *root;
-	struct btrfs_path *path;
+	BTRFS_PATH_AUTO_FREE(path);
 	struct btrfs_key key;
 	struct btrfs_key found_key;
 
@@ -6574,7 +6494,6 @@ static int process_all_extents(struct send_ctx *sctx)
 	if (iter_ret < 0)
 		ret = iter_ret;
 
-	btrfs_free_path(path);
 	return ret;
 }
 
@@ -7324,7 +7243,7 @@ static int full_send_tree(struct send_ctx *sctx)
 	struct btrfs_root *send_root = sctx->send_root;
 	struct btrfs_key key;
 	struct btrfs_fs_info *fs_info = send_root->fs_info;
-	struct btrfs_path *path;
+	BTRFS_PATH_AUTO_FREE(path);
 
 	path = alloc_path_for_send();
 	if (!path)
@@ -7341,7 +7260,7 @@ static int full_send_tree(struct send_ctx *sctx)
 
 	ret = btrfs_search_slot_for_read(send_root, &key, path, 1, 0);
 	if (ret < 0)
-		goto out;
+		return ret;
 	if (ret)
 		goto out_finish;
 
@@ -7351,7 +7270,7 @@ static int full_send_tree(struct send_ctx *sctx)
 		ret = changed_cb(path, NULL, &key,
 				 BTRFS_COMPARE_TREE_NEW, sctx);
 		if (ret < 0)
-			goto out;
+			return ret;
 
 		down_read(&fs_info->commit_root_sem);
 		if (fs_info->last_reloc_trans > sctx->last_reloc_trans) {
@@ -7370,14 +7289,14 @@ static int full_send_tree(struct send_ctx *sctx)
 			btrfs_release_path(path);
 			ret = search_key_again(sctx, send_root, path, &key);
 			if (ret < 0)
-				goto out;
+				return ret;
 		} else {
 			up_read(&fs_info->commit_root_sem);
 		}
 
 		ret = btrfs_next_item(send_root, path);
 		if (ret < 0)
-			goto out;
+			return ret;
 		if (ret) {
 			ret  = 0;
 			break;
@@ -7385,11 +7304,7 @@ static int full_send_tree(struct send_ctx *sctx)
 	}
 
 out_finish:
-	ret = finish_inode_if_needed(sctx, 1);
-
-out:
-	btrfs_free_path(path);
-	return ret;
+	return finish_inode_if_needed(sctx, 1);
 }
 
 static int replace_node_with_clone(struct btrfs_path *path, int level)
@@ -7644,8 +7559,8 @@ static int btrfs_compare_trees(struct btrfs_root *left_root,
 	struct btrfs_fs_info *fs_info = left_root->fs_info;
 	int ret;
 	int cmp;
-	struct btrfs_path *left_path = NULL;
-	struct btrfs_path *right_path = NULL;
+	BTRFS_PATH_AUTO_FREE(left_path);
+	BTRFS_PATH_AUTO_FREE(right_path);
 	struct btrfs_key left_key;
 	struct btrfs_key right_key;
 	char *tmp_buf = NULL;
@@ -7918,8 +7833,6 @@ static int btrfs_compare_trees(struct btrfs_root *left_root,
 out_unlock:
 	up_read(&fs_info->commit_root_sem);
 out:
-	btrfs_free_path(left_path);
-	btrfs_free_path(right_path);
 	kvfree(tmp_buf);
 	return ret;
 }
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index a262b494a89f..5e6eccd11fbe 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -794,7 +794,7 @@ char *btrfs_get_subvol_name_from_objectid(struct btrfs_fs_info *fs_info,
 	struct btrfs_root_ref *root_ref;
 	struct btrfs_inode_ref *inode_ref;
 	struct btrfs_key key;
-	struct btrfs_path *path = NULL;
+	BTRFS_PATH_AUTO_FREE(path);
 	char *name = NULL, *ptr;
 	u64 dirid;
 	int len;
@@ -892,7 +892,6 @@ char *btrfs_get_subvol_name_from_objectid(struct btrfs_fs_info *fs_info,
 		fs_root = NULL;
 	}
 
-	btrfs_free_path(path);
 	if (ptr == name + PATH_MAX - 1) {
 		name[0] = '/';
 		name[1] = '\0';
@@ -903,7 +902,6 @@ char *btrfs_get_subvol_name_from_objectid(struct btrfs_fs_info *fs_info,
 
 err:
 	btrfs_put_root(fs_root);
-	btrfs_free_path(path);
 	kfree(name);
 	return ERR_PTR(ret);
 }
@@ -912,7 +910,7 @@ static int get_default_subvol_objectid(struct btrfs_fs_info *fs_info, u64 *objec
 {
 	struct btrfs_root *root = fs_info->tree_root;
 	struct btrfs_dir_item *di;
-	struct btrfs_path *path;
+	BTRFS_PATH_AUTO_FREE(path);
 	struct btrfs_key location;
 	struct fscrypt_str name = FSTR_INIT("default", 7);
 	u64 dir_id;
@@ -929,7 +927,6 @@ static int get_default_subvol_objectid(struct btrfs_fs_info *fs_info, u64 *objec
 	dir_id = btrfs_super_root_dir(fs_info->super_copy);
 	di = btrfs_lookup_dir_item(NULL, root, path, dir_id, &name, 0);
 	if (IS_ERR(di)) {
-		btrfs_free_path(path);
 		return PTR_ERR(di);
 	}
 	if (!di) {
@@ -938,13 +935,11 @@ static int get_default_subvol_objectid(struct btrfs_fs_info *fs_info, u64 *objec
 		 * it's always been there, but don't freak out, just try and
 		 * mount the top-level subvolume.
 		 */
-		btrfs_free_path(path);
 		*objectid = BTRFS_FS_TREE_OBJECTID;
 		return 0;
 	}
 
 	btrfs_dir_item_key_to_cpu(path->nodes[0], di, &location);
-	btrfs_free_path(path);
 	*objectid = location.objectid;
 	return 0;
 }
diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 69e11557fd13..7c46cf07f2ab 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -1013,7 +1013,7 @@ static noinline int backref_in_log(struct btrfs_root *log,
 				   u64 ref_objectid,
 				   const struct fscrypt_str *name)
 {
-	struct btrfs_path *path;
+	BTRFS_PATH_AUTO_FREE(path);
 	int ret;
 
 	path = btrfs_alloc_path();
@@ -1021,12 +1021,10 @@ static noinline int backref_in_log(struct btrfs_root *log,
 		return -ENOMEM;
 
 	ret = btrfs_search_slot(NULL, log, key, path, 0, 0);
-	if (ret < 0) {
-		goto out;
-	} else if (ret == 1) {
-		ret = 0;
-		goto out;
-	}
+	if (ret < 0)
+		return ret;
+	if (ret == 1)
+		return 0;
 
 	if (key->type == BTRFS_INODE_EXTREF_KEY)
 		ret = !!btrfs_find_name_in_ext_backref(path->nodes[0],
@@ -1035,8 +1033,6 @@ static noinline int backref_in_log(struct btrfs_root *log,
 	else
 		ret = !!btrfs_find_name_in_backref(path->nodes[0],
 						   path->slots[0], name);
-out:
-	btrfs_free_path(path);
 	return ret;
 }
 
@@ -1646,7 +1642,7 @@ static noinline int fixup_inode_link_count(struct btrfs_trans_handle *trans,
 					   struct btrfs_inode *inode)
 {
 	struct btrfs_root *root = inode->root;
-	struct btrfs_path *path;
+	BTRFS_PATH_AUTO_FREE(path);
 	int ret;
 	u64 nlink = 0;
 	const u64 ino = btrfs_ino(inode);
@@ -1657,13 +1653,13 @@ static noinline int fixup_inode_link_count(struct btrfs_trans_handle *trans,
 
 	ret = count_inode_refs(inode, path);
 	if (ret < 0)
-		goto out;
+		return ret;
 
 	nlink = ret;
 
 	ret = count_inode_extrefs(inode, path);
 	if (ret < 0)
-		goto out;
+		return ret;
 
 	nlink += ret;
 
@@ -1673,7 +1669,7 @@ static noinline int fixup_inode_link_count(struct btrfs_trans_handle *trans,
 		set_nlink(&inode->vfs_inode, nlink);
 		ret = btrfs_update_inode(trans, inode);
 		if (ret)
-			goto out;
+			return ret;
 	}
 	if (S_ISDIR(inode->vfs_inode.i_mode))
 		inode->index_cnt = (u64)-1;
@@ -1682,15 +1678,13 @@ static noinline int fixup_inode_link_count(struct btrfs_trans_handle *trans,
 		if (S_ISDIR(inode->vfs_inode.i_mode)) {
 			ret = replay_dir_deletes(trans, root, NULL, path, ino, true);
 			if (ret)
-				goto out;
+				return ret;
 		}
 		ret = btrfs_insert_orphan_item(trans, root, ino);
 		if (ret == -EEXIST)
 			ret = 0;
 	}
 
-out:
-	btrfs_free_path(path);
 	return ret;
 }
 
@@ -2227,7 +2221,7 @@ static int replay_xattr_deletes(struct btrfs_trans_handle *trans,
 			      const u64 ino)
 {
 	struct btrfs_key search_key;
-	struct btrfs_path *log_path;
+	BTRFS_PATH_AUTO_FREE(log_path);
 	int i;
 	int nritems;
 	int ret;
@@ -2312,7 +2306,6 @@ static int replay_xattr_deletes(struct btrfs_trans_handle *trans,
 	else if (ret == 0)
 		goto process_leaf;
 out:
-	btrfs_free_path(log_path);
 	btrfs_release_path(path);
 	return ret;
 }
@@ -2339,7 +2332,7 @@ static noinline int replay_dir_deletes(struct btrfs_trans_handle *trans,
 	int ret = 0;
 	struct btrfs_key dir_key;
 	struct btrfs_key found_key;
-	struct btrfs_path *log_path;
+	BTRFS_PATH_AUTO_FREE(log_path);
 	struct btrfs_inode *dir;
 
 	dir_key.objectid = dirid;
@@ -2354,7 +2347,6 @@ static noinline int replay_dir_deletes(struct btrfs_trans_handle *trans,
 	 * we replay the deletes before we copy in the inode item from the log.
 	 */
 	if (IS_ERR(dir)) {
-		btrfs_free_path(log_path);
 		ret = PTR_ERR(dir);
 		if (ret == -ENOENT)
 			ret = 0;
@@ -2419,7 +2411,6 @@ static noinline int replay_dir_deletes(struct btrfs_trans_handle *trans,
 	ret = 0;
 out:
 	btrfs_release_path(path);
-	btrfs_free_path(log_path);
 	iput(&dir->vfs_inode);
 	return ret;
 }
@@ -2443,7 +2434,7 @@ static int replay_one_buffer(struct btrfs_root *log, struct extent_buffer *eb,
 		.transid = gen,
 		.level = level
 	};
-	struct btrfs_path *path;
+	BTRFS_PATH_AUTO_FREE(path);
 	struct btrfs_root *root = wc->replay_dest;
 	struct btrfs_key key;
 	int i;
@@ -2598,7 +2589,6 @@ static int replay_one_buffer(struct btrfs_root *log, struct extent_buffer *eb,
 		 * older kernel with such keys, ignore them.
 		 */
 	}
-	btrfs_free_path(path);
 	return ret;
 }
 
@@ -2768,7 +2758,7 @@ static int walk_log_tree(struct btrfs_trans_handle *trans,
 	int ret = 0;
 	int wret;
 	int level;
-	struct btrfs_path *path;
+	BTRFS_PATH_AUTO_FREE(path);
 	int orig_level;
 
 	path = btrfs_alloc_path();
@@ -2785,18 +2775,14 @@ static int walk_log_tree(struct btrfs_trans_handle *trans,
 		wret = walk_down_log_tree(trans, log, path, &level, wc);
 		if (wret > 0)
 			break;
-		if (wret < 0) {
-			ret = wret;
-			goto out;
-		}
+		if (wret < 0)
+			return wret;
 
 		wret = walk_up_log_tree(trans, log, path, &level, wc);
 		if (wret > 0)
 			break;
-		if (wret < 0) {
-			ret = wret;
-			goto out;
-		}
+		if (wret < 0)
+			return wret;
 	}
 
 	/* was the root node processed? if not, catch it here */
@@ -2805,13 +2791,11 @@ static int walk_log_tree(struct btrfs_trans_handle *trans,
 			 btrfs_header_generation(path->nodes[orig_level]),
 			 orig_level);
 		if (ret)
-			goto out;
+			return ret;
 		if (wc->free)
 			ret = clean_log_buffer(trans, path->nodes[orig_level]);
 	}
 
-out:
-	btrfs_free_path(path);
 	return ret;
 }
 
@@ -3519,7 +3503,7 @@ void btrfs_del_dir_entries_in_log(struct btrfs_trans_handle *trans,
 				  const struct fscrypt_str *name,
 				  struct btrfs_inode *dir, u64 index)
 {
-	struct btrfs_path *path;
+	BTRFS_PATH_AUTO_FREE(path);
 	int ret;
 
 	ret = inode_logged(trans, dir, NULL);
@@ -3539,7 +3523,7 @@ void btrfs_del_dir_entries_in_log(struct btrfs_trans_handle *trans,
 	ret = join_running_log_trans(root);
 	ASSERT(ret == 0, "join_running_log_trans() ret=%d", ret);
 	if (WARN_ON(ret))
-		goto out;
+		return;
 
 	mutex_lock(&dir->log_mutex);
 
@@ -3549,8 +3533,6 @@ void btrfs_del_dir_entries_in_log(struct btrfs_trans_handle *trans,
 	if (ret < 0)
 		btrfs_set_log_full_commit(trans);
 	btrfs_end_log_trans(root);
-out:
-	btrfs_free_path(path);
 }
 
 /* see comments for btrfs_del_dir_entries_in_log */
@@ -5320,7 +5302,7 @@ static int btrfs_check_ref_name_override(struct extent_buffer *eb,
 					 u64 *other_ino, u64 *other_parent)
 {
 	int ret;
-	struct btrfs_path *search_path;
+	BTRFS_PATH_AUTO_FREE(search_path);
 	char *name = NULL;
 	u32 name_len = 0;
 	u32 item_size = btrfs_item_size(eb, slot);
@@ -5405,7 +5387,6 @@ static int btrfs_check_ref_name_override(struct extent_buffer *eb,
 	}
 	ret = 0;
 out:
-	btrfs_free_path(search_path);
 	kfree(name);
 	return ret;
 }
@@ -5491,7 +5472,7 @@ static int log_new_dir_dentries(struct btrfs_trans_handle *trans,
 				struct btrfs_log_ctx *ctx)
 {
 	struct btrfs_root *root = start_inode->root;
-	struct btrfs_path *path;
+	BTRFS_PATH_AUTO_FREE(path);
 	LIST_HEAD(dir_list);
 	struct btrfs_dir_list *dir_elem;
 	u64 ino = btrfs_ino(start_inode);
@@ -5616,7 +5597,6 @@ static int log_new_dir_dentries(struct btrfs_trans_handle *trans,
 		}
 	}
 out:
-	btrfs_free_path(path);
 	if (curr_inode)
 		btrfs_add_delayed_iput(curr_inode);
 
@@ -6441,8 +6421,8 @@ static int btrfs_log_inode(struct btrfs_trans_handle *trans,
 			   int inode_only,
 			   struct btrfs_log_ctx *ctx)
 {
-	struct btrfs_path *path;
-	struct btrfs_path *dst_path;
+	BTRFS_PATH_AUTO_FREE(path);
+	BTRFS_PATH_AUTO_FREE(dst_path);
 	struct btrfs_key min_key;
 	struct btrfs_key max_key;
 	struct btrfs_root *log = inode->root->log_root;
@@ -6462,10 +6442,8 @@ static int btrfs_log_inode(struct btrfs_trans_handle *trans,
 	if (!path)
 		return -ENOMEM;
 	dst_path = btrfs_alloc_path();
-	if (!dst_path) {
-		btrfs_free_path(path);
+	if (!dst_path)
 		return -ENOMEM;
-	}
 
 	min_key.objectid = ino;
 	min_key.type = BTRFS_INODE_ITEM_KEY;
@@ -6763,9 +6741,6 @@ static int btrfs_log_inode(struct btrfs_trans_handle *trans,
 out_unlock:
 	mutex_unlock(&inode->log_mutex);
 out:
-	btrfs_free_path(path);
-	btrfs_free_path(dst_path);
-
 	if (ret)
 		free_conflicting_inodes(ctx);
 	else
@@ -6788,7 +6763,7 @@ static int btrfs_log_all_parents(struct btrfs_trans_handle *trans,
 				 struct btrfs_log_ctx *ctx)
 {
 	int ret;
-	struct btrfs_path *path;
+	BTRFS_PATH_AUTO_FREE(path);
 	struct btrfs_key key;
 	struct btrfs_root *root = inode->root;
 	const u64 ino = btrfs_ino(inode);
@@ -6804,7 +6779,7 @@ static int btrfs_log_all_parents(struct btrfs_trans_handle *trans,
 	key.offset = 0;
 	ret = btrfs_search_slot(NULL, root, &key, path, 0, 0);
 	if (ret < 0)
-		goto out;
+		return ret;
 
 	while (true) {
 		struct extent_buffer *leaf = path->nodes[0];
@@ -6816,8 +6791,8 @@ static int btrfs_log_all_parents(struct btrfs_trans_handle *trans,
 		if (slot >= btrfs_header_nritems(leaf)) {
 			ret = btrfs_next_leaf(root, path);
 			if (ret < 0)
-				goto out;
-			else if (ret > 0)
+				return ret;
+			if (ret > 0)
 				break;
 			continue;
 		}
@@ -6875,10 +6850,8 @@ static int btrfs_log_all_parents(struct btrfs_trans_handle *trans,
 			 * at both parents and the old parent B would still
 			 * exist.
 			 */
-			if (IS_ERR(dir_inode)) {
-				ret = PTR_ERR(dir_inode);
-				goto out;
-			}
+			if (IS_ERR(dir_inode))
+				return PTR_ERR(dir_inode);
 
 			if (!need_log_inode(trans, dir_inode)) {
 				btrfs_add_delayed_iput(dir_inode);
@@ -6891,14 +6864,11 @@ static int btrfs_log_all_parents(struct btrfs_trans_handle *trans,
 				ret = log_new_dir_dentries(trans, dir_inode, ctx);
 			btrfs_add_delayed_iput(dir_inode);
 			if (ret)
-				goto out;
+				return ret;
 		}
 		path->slots[0]++;
 	}
-	ret = 0;
-out:
-	btrfs_free_path(path);
-	return ret;
+	return 0;
 }
 
 static int log_new_ancestors(struct btrfs_trans_handle *trans,
@@ -7009,7 +6979,7 @@ static int log_all_new_ancestors(struct btrfs_trans_handle *trans,
 {
 	struct btrfs_root *root = inode->root;
 	const u64 ino = btrfs_ino(inode);
-	struct btrfs_path *path;
+	BTRFS_PATH_AUTO_FREE(path);
 	struct btrfs_key search_key;
 	int ret;
 
@@ -7030,7 +7000,7 @@ static int log_all_new_ancestors(struct btrfs_trans_handle *trans,
 again:
 	ret = btrfs_search_slot(NULL, root, &search_key, path, 0, 0);
 	if (ret < 0)
-		goto out;
+		return ret;
 	if (ret == 0)
 		path->slots[0]++;
 
@@ -7042,8 +7012,8 @@ static int log_all_new_ancestors(struct btrfs_trans_handle *trans,
 		if (slot >= btrfs_header_nritems(leaf)) {
 			ret = btrfs_next_leaf(root, path);
 			if (ret < 0)
-				goto out;
-			else if (ret > 0)
+				return ret;
+			if (ret > 0)
 				break;
 			continue;
 		}
@@ -7060,10 +7030,8 @@ static int log_all_new_ancestors(struct btrfs_trans_handle *trans,
 		 * this loop, etc). So just return some error to fallback to
 		 * a transaction commit.
 		 */
-		if (found_key.type == BTRFS_INODE_EXTREF_KEY) {
-			ret = -EMLINK;
-			goto out;
-		}
+		if (found_key.type == BTRFS_INODE_EXTREF_KEY)
+			return -EMLINK;
 
 		/*
 		 * Logging ancestors needs to do more searches on the fs/subvol
@@ -7075,14 +7043,11 @@ static int log_all_new_ancestors(struct btrfs_trans_handle *trans,
 
 		ret = log_new_ancestors(trans, root, path, ctx);
 		if (ret)
-			goto out;
+			return ret;
 		btrfs_release_path(path);
 		goto again;
 	}
-	ret = 0;
-out:
-	btrfs_free_path(path);
-	return ret;
+	return 0;
 }
 
 /*
@@ -7240,7 +7205,7 @@ int btrfs_log_dentry_safe(struct btrfs_trans_handle *trans,
 int btrfs_recover_log_trees(struct btrfs_root *log_root_tree)
 {
 	int ret;
-	struct btrfs_path *path;
+	BTRFS_PATH_AUTO_FREE(path);
 	struct btrfs_trans_handle *trans;
 	struct btrfs_key key;
 	struct btrfs_fs_info *fs_info = log_root_tree->fs_info;
@@ -7397,8 +7362,6 @@ int btrfs_recover_log_trees(struct btrfs_root *log_root_tree)
 		goto again;
 	}
 
-	btrfs_free_path(path);
-
 	/* step 4: commit the transaction, which also unpins the blocks */
 	ret = btrfs_commit_transaction(trans);
 	if (ret)
@@ -7413,7 +7376,6 @@ int btrfs_recover_log_trees(struct btrfs_root *log_root_tree)
 	if (wc.trans)
 		btrfs_end_transaction(wc.trans);
 	clear_bit(BTRFS_FS_LOG_RECOVERING, &fs_info->flags);
-	btrfs_free_path(path);
 	return ret;
 }
 
-- 
2.50.1


