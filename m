Return-Path: <linux-btrfs+bounces-5882-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A1E8912217
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Jun 2024 12:18:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B27628814B
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Jun 2024 10:18:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54D3E171068;
	Fri, 21 Jun 2024 10:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J5G472CD"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79D9416DEA8
	for <linux-btrfs@vger.kernel.org>; Fri, 21 Jun 2024 10:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718964999; cv=none; b=rZVThHsDFuKxIhOYRq5cIJZYT252mABQ7JtO2hgg/YQex0p0ujPGo33U1v4yucRrvxtmc+/kqYbJohwbpR8nMtpmprmkUGnVaems0ceoLJ4r4xk5eeQ3y1PAaFFenUVqxHoo4RfAadJFQDXdzuz6ggdeEAl32V2tk1WLsQiV0Rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718964999; c=relaxed/simple;
	bh=ErEgcnUJT4DoP2ErjfhC2Gfitv0TOFtfsi4KGvc6c0g=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=GLNnQw5dNQApGvLEh8MCUIg6/iVpL3GXNQSw3UhRqlXfnhPW16+8bHk8PlQemMuDM228RwBFwn9AJXIvYVmwV9CQO3zS5KUEdDd75NY/i2WfGhNa8EShxCdr4JvtwrhwKTDtCEFZSjz5oqF2ypiZr3L+Tn7nrfqi3yXp/KrArDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J5G472CD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E9D4C32781
	for <linux-btrfs@vger.kernel.org>; Fri, 21 Jun 2024 10:16:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718964999;
	bh=ErEgcnUJT4DoP2ErjfhC2Gfitv0TOFtfsi4KGvc6c0g=;
	h=From:To:Subject:Date:From;
	b=J5G472CDMK04tNcyjdKDjWlUmIsx+gz2VHmp5KbsAqfbRoXx7lqHxf6Hd1px4Fo5b
	 dkRTEQyP1xOtDJ2dY8soVyGBMrJQO6fY/UOBF7pdKuu4n8pNn6i0zo87siyjshesjA
	 5T2mfVZmynAv8SumYzVWZMMvFSTxKTnrehWXS6rjIBX/yVCKUkKsuJlDVbD/h5djTw
	 Xvt/nNk2v+lEcFLw7wZoQOILKmG4D0B+/KWq8dKoYaYlRSgM+CqnAaNCpZtYLhrKU3
	 CS6lFwGljrAR/5og2F0uWs9Kr3z2cnbMDC35TO8GQWodbT4oB8BbbAsQU+mwEWHl9E
	 dCXpXJrPP5zdQ==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: avoid allocating and running pointless delayed extent operations
Date: Fri, 21 Jun 2024 11:16:29 +0100
Message-Id: <87618653fb07d2f6307babd128b626da36dd33e8.1718964587.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

We always allocate a delayed extent op structure when allocating a tree
block (except for log trees), but most of the time we don't need it as
we only need to set the BTRFS_BLOCK_FLAG_FULL_BACKREF if we're dealing
with a relocation tree and we only need to set the key of a tree block
in a btrfs_tree_block_info structure if we are not using skinny metadata
(feature enabled by default since btrfs-progs 3.18 and available as of
kernel 3.10).

In these cases, where we don't need neither to update flags nor to set
the key, we only use the delayed extent op structure to set the tree
block's level. This is a waste of memory and besides that, the memory
allocation can fail and can add additional latency.

Instead of using a delayed extent op structure to store the level of
the tree block, use the delayed ref head to store it. This doesn't
change the size of neither structure and helps us avoid allocating
delayed extent ops structures when using the skinny metadata feature
and there's no relocation going on. This also gets rid of a BUG_ON().

For example, for a fs_mark run, with 5 iterations, 8 threads and 100K
files per iteration, before this patch there were 118109 allocations
of delayed extent op structures and after it there were none.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/delayed-ref.c |  9 +++++-
 fs/btrfs/delayed-ref.h |  6 ++--
 fs/btrfs/extent-tree.c | 63 ++++++++++++++++++------------------------
 3 files changed, 39 insertions(+), 39 deletions(-)

diff --git a/fs/btrfs/delayed-ref.c b/fs/btrfs/delayed-ref.c
index 6b4296ab651f..2ac9296edccb 100644
--- a/fs/btrfs/delayed-ref.c
+++ b/fs/btrfs/delayed-ref.c
@@ -819,6 +819,12 @@ static void init_delayed_ref_head(struct btrfs_delayed_ref_head *head_ref,
 	spin_lock_init(&head_ref->lock);
 	mutex_init(&head_ref->mutex);
 
+	/* If not metadata set an impossible level to help debugging. */
+	if (generic_ref->type == BTRFS_REF_METADATA)
+		head_ref->level = generic_ref->tree_ref.level;
+	else
+		head_ref->level = U8_MAX;
+
 	if (qrecord) {
 		if (generic_ref->ref_root && reserved) {
 			qrecord->data_rsv = reserved;
@@ -1072,7 +1078,7 @@ int btrfs_add_delayed_data_ref(struct btrfs_trans_handle *trans,
 }
 
 int btrfs_add_delayed_extent_op(struct btrfs_trans_handle *trans,
-				u64 bytenr, u64 num_bytes,
+				u64 bytenr, u64 num_bytes, u8 level,
 				struct btrfs_delayed_extent_op *extent_op)
 {
 	struct btrfs_delayed_ref_head *head_ref;
@@ -1082,6 +1088,7 @@ int btrfs_add_delayed_extent_op(struct btrfs_trans_handle *trans,
 		.action = BTRFS_UPDATE_DELAYED_HEAD,
 		.bytenr = bytenr,
 		.num_bytes = num_bytes,
+		.tree_ref.level = level,
 	};
 
 	head_ref = kmem_cache_alloc(btrfs_delayed_ref_head_cachep, GFP_NOFS);
diff --git a/fs/btrfs/delayed-ref.h b/fs/btrfs/delayed-ref.h
index 405be46c420f..ef15e998be03 100644
--- a/fs/btrfs/delayed-ref.h
+++ b/fs/btrfs/delayed-ref.h
@@ -108,7 +108,6 @@ struct btrfs_delayed_ref_node {
 
 struct btrfs_delayed_extent_op {
 	struct btrfs_disk_key key;
-	u8 level;
 	bool update_key;
 	bool update_flags;
 	u64 flags_to_set;
@@ -172,6 +171,9 @@ struct btrfs_delayed_ref_head {
 	 */
 	u64 reserved_bytes;
 
+	/* Tree block level, for metadata only. */
+	u8 level;
+
 	/*
 	 * when a new extent is allocated, it is just reserved in memory
 	 * The actual extent isn't inserted into the extent allocation tree
@@ -355,7 +357,7 @@ int btrfs_add_delayed_data_ref(struct btrfs_trans_handle *trans,
 			       struct btrfs_ref *generic_ref,
 			       u64 reserved);
 int btrfs_add_delayed_extent_op(struct btrfs_trans_handle *trans,
-				u64 bytenr, u64 num_bytes,
+				u64 bytenr, u64 num_bytes, u8 level,
 				struct btrfs_delayed_extent_op *extent_op);
 void btrfs_merge_delayed_refs(struct btrfs_fs_info *fs_info,
 			      struct btrfs_delayed_ref_root *delayed_refs,
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 23a7cac108eb..250623f3b094 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -200,19 +200,8 @@ int btrfs_lookup_extent_info(struct btrfs_trans_handle *trans,
 			goto search_again;
 		}
 		spin_lock(&head->lock);
-		if (head->extent_op && head->extent_op->update_flags) {
+		if (head->extent_op && head->extent_op->update_flags)
 			extent_flags |= head->extent_op->flags_to_set;
-		} else if (unlikely(num_refs == 0)) {
-			spin_unlock(&head->lock);
-			mutex_unlock(&head->mutex);
-			spin_unlock(&delayed_refs->lock);
-			ret = -EUCLEAN;
-			btrfs_err(fs_info,
-			  "unexpected zero reference count for extent %llu (%s)",
-				  bytenr, metadata ? "metadata" : "data");
-			btrfs_abort_transaction(trans, ret);
-			goto out_free;
-		}
 
 		num_refs += head->ref_mod;
 		spin_unlock(&head->lock);
@@ -1632,7 +1621,7 @@ static int run_delayed_extent_op(struct btrfs_trans_handle *trans,
 
 	if (metadata) {
 		key.type = BTRFS_METADATA_ITEM_KEY;
-		key.offset = extent_op->level;
+		key.offset = head->level;
 	} else {
 		key.type = BTRFS_EXTENT_ITEM_KEY;
 		key.offset = head->num_bytes;
@@ -1667,7 +1656,7 @@ static int run_delayed_extent_op(struct btrfs_trans_handle *trans,
 			ret = -EUCLEAN;
 			btrfs_err(fs_info,
 		  "missing extent item for extent %llu num_bytes %llu level %d",
-				  head->bytenr, head->num_bytes, extent_op->level);
+				  head->bytenr, head->num_bytes, head->level);
 			goto out;
 		}
 	}
@@ -1726,7 +1715,6 @@ static int run_delayed_tree_ref(struct btrfs_trans_handle *trans,
 			.generation = trans->transid,
 		};
 
-		BUG_ON(!extent_op || !extent_op->update_flags);
 		ret = alloc_reserved_tree_block(trans, node, extent_op);
 		if (!ret)
 			btrfs_record_squota_delta(fs_info, &delta);
@@ -2233,7 +2221,6 @@ int btrfs_set_disk_extent_flags(struct btrfs_trans_handle *trans,
 				struct extent_buffer *eb, u64 flags)
 {
 	struct btrfs_delayed_extent_op *extent_op;
-	int level = btrfs_header_level(eb);
 	int ret;
 
 	extent_op = btrfs_alloc_delayed_extent_op();
@@ -2243,9 +2230,9 @@ int btrfs_set_disk_extent_flags(struct btrfs_trans_handle *trans,
 	extent_op->flags_to_set = flags;
 	extent_op->update_flags = true;
 	extent_op->update_key = false;
-	extent_op->level = level;
 
-	ret = btrfs_add_delayed_extent_op(trans, eb->start, eb->len, extent_op);
+	ret = btrfs_add_delayed_extent_op(trans, eb->start, eb->len,
+					  btrfs_header_level(eb), extent_op);
 	if (ret)
 		btrfs_free_delayed_extent_op(extent_op);
 	return ret;
@@ -4866,7 +4853,7 @@ static int alloc_reserved_tree_block(struct btrfs_trans_handle *trans,
 	struct btrfs_path *path;
 	struct extent_buffer *leaf;
 	u32 size = sizeof(*extent_item) + sizeof(*iref);
-	u64 flags = extent_op->flags_to_set;
+	const u64 flags = (extent_op ? extent_op->flags_to_set : 0);
 	/* The owner of a tree block is the level. */
 	int level = btrfs_delayed_ref_owner(node);
 	bool skinny_metadata = btrfs_fs_incompat(fs_info, SKINNY_METADATA);
@@ -5123,7 +5110,6 @@ struct extent_buffer *btrfs_alloc_tree_block(struct btrfs_trans_handle *trans,
 	struct btrfs_key ins;
 	struct btrfs_block_rsv *block_rsv;
 	struct extent_buffer *buf;
-	struct btrfs_delayed_extent_op *extent_op;
 	u64 flags = 0;
 	int ret;
 	u32 blocksize = fs_info->nodesize;
@@ -5166,6 +5152,7 @@ struct extent_buffer *btrfs_alloc_tree_block(struct btrfs_trans_handle *trans,
 		BUG_ON(parent > 0);
 
 	if (root_objectid != BTRFS_TREE_LOG_OBJECTID) {
+		struct btrfs_delayed_extent_op *extent_op;
 		struct btrfs_ref generic_ref = {
 			.action = BTRFS_ADD_DELAYED_EXTENT,
 			.bytenr = ins.objectid,
@@ -5174,30 +5161,34 @@ struct extent_buffer *btrfs_alloc_tree_block(struct btrfs_trans_handle *trans,
 			.owning_root = owning_root,
 			.ref_root = root_objectid,
 		};
-		extent_op = btrfs_alloc_delayed_extent_op();
-		if (!extent_op) {
-			ret = -ENOMEM;
-			goto out_free_buf;
+
+		if (!skinny_metadata || flags != 0) {
+			extent_op = btrfs_alloc_delayed_extent_op();
+			if (!extent_op) {
+				ret = -ENOMEM;
+				goto out_free_buf;
+			}
+			if (key)
+				memcpy(&extent_op->key, key, sizeof(extent_op->key));
+			else
+				memset(&extent_op->key, 0, sizeof(extent_op->key));
+			extent_op->flags_to_set = flags;
+			extent_op->update_key = skinny_metadata ? false : true;
+			extent_op->update_flags = (flags != 0);
+		} else {
+			extent_op = NULL;
 		}
-		if (key)
-			memcpy(&extent_op->key, key, sizeof(extent_op->key));
-		else
-			memset(&extent_op->key, 0, sizeof(extent_op->key));
-		extent_op->flags_to_set = flags;
-		extent_op->update_key = skinny_metadata ? false : true;
-		extent_op->update_flags = true;
-		extent_op->level = level;
 
 		btrfs_init_tree_ref(&generic_ref, level, btrfs_root_id(root), false);
 		btrfs_ref_tree_mod(fs_info, &generic_ref);
 		ret = btrfs_add_delayed_tree_ref(trans, &generic_ref, extent_op);
-		if (ret)
-			goto out_free_delayed;
+		if (ret) {
+			btrfs_free_delayed_extent_op(extent_op);
+			goto out_free_buf;
+		}
 	}
 	return buf;
 
-out_free_delayed:
-	btrfs_free_delayed_extent_op(extent_op);
 out_free_buf:
 	btrfs_tree_unlock(buf);
 	free_extent_buffer(buf);
-- 
2.43.0


