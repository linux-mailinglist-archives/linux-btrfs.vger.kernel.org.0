Return-Path: <linux-btrfs+bounces-8505-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EDD9898F2FD
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Oct 2024 17:45:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CA9D1F2140D
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Oct 2024 15:45:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 281D71AAE11;
	Thu,  3 Oct 2024 15:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="uTDSbkQW"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8F781AAE10
	for <linux-btrfs@vger.kernel.org>; Thu,  3 Oct 2024 15:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727970210; cv=none; b=SlZZ1aqPGdfv5luiJ8RzSRQ7wW8JDhK3XjNZG2FyoK5x4ZWWmrTOjfGfwt+FO4HAxfcm7XHU1uPuRsVGV+iLyPqjkcRyl4KmevJazjZLo3EPOuzc/t0bsKg6RzEiA0lmTTcy70XPh6h3MeHRUFP+ZcaD/6b2bWtZZhjhx3X8iaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727970210; c=relaxed/simple;
	bh=V24IqdDBUYn2fM6CVto6YgnppgMse5k/u1p/OwFGx7E=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EoMXKI82BW7uSp2wdOXR67+LXkLIPtdMogZcRb8wGhHJbqAu1yj4gphbGmYo5b+aMxAwHH4MZgo2umTb/iFR6hGRHvfwV0ldl3ihZ61H0fM9Mhy3ZkWdFx33iMYscVP17gnCLVNbV47KnatcTuciNS1E80+L9IOyrsPAKhsFgjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=uTDSbkQW; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-6e21ac45b70so9703247b3.1
        for <linux-btrfs@vger.kernel.org>; Thu, 03 Oct 2024 08:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1727970207; x=1728575007; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rhx3NGH5C3TspfJhJ+Fa6gcCNwulVq5I0DMntDidSMk=;
        b=uTDSbkQWB4uyUP/AH0YKIduoaF5CiQFxgU4SG6mMpsgL6aixvWppzdX3l0JC4mOYj4
         rkrGUjqfSJnWmn2qZQzL1D0zrx87l9iJw/4SCGw9eWb2022vWTVTzZFfE2llNp63gmRc
         4Gj+C8IpT8v1vD2ntdcKDtU3O51wLgJdHgP7WG7I5kh3UM1pOTR5mX6Pm7VTmriXJoR4
         fNksSb8iGJBXaffjSg6lMtK9mubqmBKtLnfycuxSnr+mxdh9mdiy2yJqSn+bMynkyxjZ
         qZCS1rd2357MOlaEF4DquWzmrNADgu33fzYFJm2pgxrvNRRA4V9XlJNGg0vFkxbW1iz4
         eyiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727970207; x=1728575007;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rhx3NGH5C3TspfJhJ+Fa6gcCNwulVq5I0DMntDidSMk=;
        b=XgMiqO+AhnlSY2YXqm5DrEyK1WdH9nk0TU1EEzs/wypYW5AQh3TcfI8r7TfwTsT52a
         mxECy9TlpUgJYyeVpBbY+gl4Te3hMn0SEhvH2eXo5sPpgJcyK7sZ+sAThm4+n43jBk/n
         /E7GGAtn5OJWA2mCVoHHIwN8wFhOkXG6h7UAMt/sb8MUKFvdeCJcyYzUx6lH6m+Reknf
         PnxlF2O23gh655H5uDEr09BcZ99bMc/BL/k5EjotVD5OK+/PO28B6mXOBEBX2xG8kKkz
         enQnFCswwkXldCf/bW502Lr1MqwKW0qE9w1VMaaYd5aM8zvnrygGs+PLOTyAtsQSegcE
         uFQg==
X-Gm-Message-State: AOJu0YxXbGenb6gyeVlFb9DBfc0fuzlyWjrnkBkF1o5Xa1jBfpAE3tbk
	heuEy07fDDVkWOZSb6RI00gAtniHVSKR7mZjv7B2/iOlCk0lAvbQb01SYfxTyduCYYMopQt/iCF
	z
X-Google-Smtp-Source: AGHT+IHy4vQ50hubOvToBMFsuahUqF52FDe5zhgYKxA4xZHGvZ2LS0neksMgQyxD6RkJ2y43lj8glg==
X-Received: by 2002:a05:690c:6710:b0:6b1:735c:a2fc with SMTP id 00721157ae682-6e2a2b61896mr70489007b3.27.1727970207320;
        Thu, 03 Oct 2024 08:43:27 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cb937d1b86sm7506636d6.77.2024.10.03.08.43.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2024 08:43:26 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH 06/10] btrfs: don't build backref tree for cowonly blocks
Date: Thu,  3 Oct 2024 11:43:08 -0400
Message-ID: <b92ec1ed0dc070a6c07f0a42197ea71fc34fdf05.1727970063.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1727970062.git.josef@toxicpanda.com>
References: <cover.1727970062.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We already determine the owner for any blocks we find when we're
relocating, and for cowonly blocks (and the data reloc tree) we cow down
to the block and call it good enough.  However we still build a whole
backref tree for them, even though we're not going to use it, and then
just don't put these blocks in the cache.

Rework the code to check if the block belongs to a cowonly root or the
data reloc root, and then just cow down to the block, skipping the
backref cache generation.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/relocation.c | 89 ++++++++++++++++++++++++++++++++++---------
 1 file changed, 70 insertions(+), 19 deletions(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 7de94e55234c..db5f6bda93c9 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -2136,17 +2136,11 @@ static noinline_for_stack u64 calcu_metadata_size(struct reloc_control *rc,
 	return num_bytes;
 }
 
-static int reserve_metadata_space(struct btrfs_trans_handle *trans,
-				  struct reloc_control *rc,
-				  struct btrfs_backref_node *node)
+static int refill_metadata_space(struct btrfs_trans_handle *trans,
+				 struct reloc_control *rc, u64 num_bytes)
 {
-	struct btrfs_root *root = rc->extent_root;
-	struct btrfs_fs_info *fs_info = root->fs_info;
-	u64 num_bytes;
+	struct btrfs_fs_info *fs_info = trans->fs_info;
 	int ret;
-	u64 tmp;
-
-	num_bytes = calcu_metadata_size(rc, node) * 2;
 
 	trans->block_rsv = rc->block_rsv;
 	rc->reserved_bytes += num_bytes;
@@ -2159,7 +2153,7 @@ static int reserve_metadata_space(struct btrfs_trans_handle *trans,
 	ret = btrfs_block_rsv_refill(fs_info, rc->block_rsv, num_bytes,
 				     BTRFS_RESERVE_FLUSH_LIMIT);
 	if (ret) {
-		tmp = fs_info->nodesize * RELOCATION_RESERVED_NODES;
+		u64 tmp = fs_info->nodesize * RELOCATION_RESERVED_NODES;
 		while (tmp <= rc->reserved_bytes)
 			tmp <<= 1;
 		/*
@@ -2177,6 +2171,16 @@ static int reserve_metadata_space(struct btrfs_trans_handle *trans,
 	return 0;
 }
 
+static int reserve_metadata_space(struct btrfs_trans_handle *trans,
+				  struct reloc_control *rc,
+				  struct btrfs_backref_node *node)
+{
+	u64 num_bytes;
+
+	num_bytes = calcu_metadata_size(rc, node) * 2;
+	return refill_metadata_space(trans, rc, num_bytes);
+}
+
 /*
  * relocate a block tree, and then update pointers in upper level
  * blocks that reference the block to point to the new location.
@@ -2528,15 +2532,11 @@ static int relocate_tree_block(struct btrfs_trans_handle *trans,
 			node->root = btrfs_grab_root(root);
 			ASSERT(node->root);
 		} else {
-			path->lowest_level = node->level;
-			if (root == root->fs_info->chunk_root)
-				btrfs_reserve_chunk_metadata(trans, false);
-			ret = btrfs_search_slot(trans, root, key, path, 0, 1);
-			btrfs_release_path(path);
-			if (root == root->fs_info->chunk_root)
-				btrfs_trans_release_chunk_metadata(trans);
-			if (ret > 0)
-				ret = 0;
+			btrfs_err(root->fs_info,
+				  "bytenr %llu resolved to a non-shareable root",
+				  node->bytenr);
+			ret = -EUCLEAN;
+			goto out;
 		}
 		if (!ret)
 			update_processed_blocks(rc, node);
@@ -2549,6 +2549,43 @@ static int relocate_tree_block(struct btrfs_trans_handle *trans,
 	return ret;
 }
 
+static noinline_for_stack
+int relocate_cowonly_block(struct btrfs_trans_handle *trans,
+			   struct reloc_control *rc, struct tree_block *block,
+			   struct btrfs_path *path)
+{
+	struct btrfs_fs_info *fs_info = trans->fs_info;
+	struct btrfs_root *root;
+	u64 num_bytes;
+	int nr_levels;
+	int ret;
+
+	root = btrfs_get_fs_root(fs_info, block->owner, true);
+	if (IS_ERR(root))
+		return PTR_ERR(root);
+
+	nr_levels = max(btrfs_header_level(root->node) - block->level, 0) + 1;
+
+	num_bytes = fs_info->nodesize * nr_levels;
+	ret = refill_metadata_space(trans, rc, num_bytes);
+	if (ret) {
+		btrfs_put_root(root);
+		return ret;
+	}
+	path->lowest_level = block->level;
+	if (root == root->fs_info->chunk_root)
+		btrfs_reserve_chunk_metadata(trans, false);
+	ret = btrfs_search_slot(trans, root, &block->key, path, 0, 1);
+	path->lowest_level = 0;
+	btrfs_release_path(path);
+	if (root == root->fs_info->chunk_root)
+		btrfs_trans_release_chunk_metadata(trans);
+	if (ret > 0)
+		ret = 0;
+	btrfs_put_root(root);
+	return ret;
+}
+
 /*
  * relocate a list of blocks
  */
@@ -2588,6 +2625,20 @@ int relocate_tree_blocks(struct btrfs_trans_handle *trans,
 
 	/* Do tree relocation */
 	rbtree_postorder_for_each_entry_safe(block, next, blocks, rb_node) {
+		/*
+		 * For cowonly blocks, or the data reloc tree, we only need to
+		 * cow down to the block, there's no need to generate a backref
+		 * tree.
+		 */
+		if (block->owner &&
+		    (!is_fstree(block->owner) ||
+		     block->owner == BTRFS_DATA_RELOC_TREE_OBJECTID)) {
+			ret = relocate_cowonly_block(trans, rc, block, path);
+			if (ret)
+				break;
+			continue;
+		}
+
 		node = build_backref_tree(trans, rc, &block->key,
 					  block->level, block->bytenr);
 		if (IS_ERR(node)) {
-- 
2.43.0


