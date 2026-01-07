Return-Path: <linux-btrfs+bounces-20197-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E9AFECFE359
	for <lists+linux-btrfs@lfdr.de>; Wed, 07 Jan 2026 15:13:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F1BBF3068373
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Jan 2026 14:10:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 297B2330655;
	Wed,  7 Jan 2026 14:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=harmstone.com header.i=@harmstone.com header.b="NSOm7KCp"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail.burntcomma.com (mail2.burntcomma.com [217.169.27.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47F5832E72F
	for <linux-btrfs@vger.kernel.org>; Wed,  7 Jan 2026 14:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.169.27.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767795033; cv=none; b=IipjHGZWGUf4y4MTJSzgJnkfDel3qvj9yo0pvSB32C1hImNEU2C6WDDqy9VRjXHxQFVjB/gB0wJUiIxSUuZY9FWQ1RDsYjv1JW/H2jMxmfarxRQ/A8EO3SNfsaPyKPBjBTW1N+Cla9sTG3xkwhpF+raWcrMfpt6ZU4StPDSNFnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767795033; c=relaxed/simple;
	bh=pJwg6SzA30/m18mJ7+/wHNuhVmrzwx6lAIoiFSW+oKY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Mime-Version; b=nPA1QOT0R3IfUS9bWq7oMQFmzQjrqVHLOpVbisqtE03w+3FXQpJxsdhL6TgxvR58hlxYYXZ+eoStaMXadxHgKb049EDYEMjy55qqiXUEUi4/WLvFztwckfKNnBPpjy1x2Z4j6VXkBRAGMgIHmQsSrUF0iAiLJ4J7WJMVu0QXYI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=harmstone.com; spf=pass smtp.mailfrom=harmstone.com; dkim=pass (1024-bit key) header.d=harmstone.com header.i=@harmstone.com header.b=NSOm7KCp; arc=none smtp.client-ip=217.169.27.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=harmstone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=harmstone.com
Received: from beren (beren.burntcomma.com [IPv6:2a02:8012:8cf0:0:ce28:aaff:fe0d:6db2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.burntcomma.com (Postfix) with ESMTPSA id 5D8FD2F186D;
	Wed,  7 Jan 2026 14:10:18 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=harmstone.com;
	s=mail; t=1767795018;
	bh=owHG6NyJoZ8cgruhvv8Qzm3YVKLzREa80rufV0n8CVs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NSOm7KCpu1fZ3odUIGR3eXPkyAAHh7brv60xuGZF7ntHnedr3Ylyw48FN0ExH9QqH
	 Ekc5fU+jk9kCmv60nRNRtXVk/NSJW0dyBFRnwxnKQH+60I+RB0QZyQBavsbhsbAz13
	 kWUAAY1+IdmUGDl+N6ynaynDzyfErPzHH8ElC1CY=
From: Mark Harmstone <mark@harmstone.com>
To: linux-btrfs@vger.kernel.org
Cc: Mark Harmstone <mark@harmstone.com>,
	Boris Burkov <boris@bur.io>
Subject: [PATCH v8 07/17] btrfs: add extended version of struct block_group_item
Date: Wed,  7 Jan 2026 14:09:07 +0000
Message-ID: <20260107141015.25819-8-mark@harmstone.com>
In-Reply-To: <20260107141015.25819-1-mark@harmstone.com>
References: <20260107141015.25819-1-mark@harmstone.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a struct btrfs_block_group_item_v2, which is used in the block group
tree if the remap-tree incompat flag is set.

This adds two new fields to the block group item: `remap_bytes` and
`identity_remap_count`.

`remap_bytes` records the amount of data that's physically within this
block group, but nominally in another, remapped block group. This is
necessary because this data will need to be moved first if this block
group is itself relocated. If `remap_bytes` > 0, this is an indicator to
the relocation thread that it will need to search the remap-tree for
backrefs. A block group must also have `remap_bytes` == 0 before it can
be dropped.

`identity_remap_count` records how many identity remap items are located
in the remap tree for this block group. When relocation is begun for
this block group, this is set to the number of holes in the free-space
tree for this range. As identity remaps are converted into actual remaps
by the relocation process, this number is decreased. Once it reaches 0,
either because of relocation or because extents have been deleted, the
block group has been fully remapped and its chunk's device extents are
removed.

Signed-off-by: Mark Harmstone <mark@harmstone.com>
Reviewed-by: Boris Burkov <boris@bur.io>
---
 fs/btrfs/accessors.h            |  20 +++++++
 fs/btrfs/block-group.c          | 100 ++++++++++++++++++++++++--------
 fs/btrfs/block-group.h          |  14 ++++-
 fs/btrfs/discard.c              |   2 +-
 fs/btrfs/tree-checker.c         |  10 +++-
 include/uapi/linux/btrfs_tree.h |   8 +++
 6 files changed, 126 insertions(+), 28 deletions(-)

diff --git a/fs/btrfs/accessors.h b/fs/btrfs/accessors.h
index 09cdd6bfddf5..9797f9e8d4e5 100644
--- a/fs/btrfs/accessors.h
+++ b/fs/btrfs/accessors.h
@@ -240,6 +240,26 @@ BTRFS_SETGET_FUNCS(block_group_flags, struct btrfs_block_group_item, flags, 64);
 BTRFS_SETGET_STACK_FUNCS(stack_block_group_flags,
 			struct btrfs_block_group_item, flags, 64);
 
+/* struct btrfs_block_group_item_v2 */
+BTRFS_SETGET_STACK_FUNCS(stack_block_group_v2_used, struct btrfs_block_group_item_v2,
+			 used, 64);
+BTRFS_SETGET_FUNCS(block_group_v2_used, struct btrfs_block_group_item_v2, used, 64);
+BTRFS_SETGET_STACK_FUNCS(stack_block_group_v2_chunk_objectid,
+			 struct btrfs_block_group_item_v2, chunk_objectid, 64);
+BTRFS_SETGET_FUNCS(block_group_v2_chunk_objectid,
+		   struct btrfs_block_group_item_v2, chunk_objectid, 64);
+BTRFS_SETGET_STACK_FUNCS(stack_block_group_v2_flags,
+			 struct btrfs_block_group_item_v2, flags, 64);
+BTRFS_SETGET_FUNCS(block_group_v2_flags, struct btrfs_block_group_item_v2, flags, 64);
+BTRFS_SETGET_STACK_FUNCS(stack_block_group_v2_remap_bytes,
+			 struct btrfs_block_group_item_v2, remap_bytes, 64);
+BTRFS_SETGET_FUNCS(block_group_v2_remap_bytes, struct btrfs_block_group_item_v2,
+		   remap_bytes, 64);
+BTRFS_SETGET_STACK_FUNCS(stack_block_group_v2_identity_remap_count,
+			 struct btrfs_block_group_item_v2, identity_remap_count, 32);
+BTRFS_SETGET_FUNCS(block_group_v2_identity_remap_count, struct btrfs_block_group_item_v2,
+		   identity_remap_count, 32);
+
 /* struct btrfs_free_space_info */
 BTRFS_SETGET_FUNCS(free_space_extent_count, struct btrfs_free_space_info,
 		   extent_count, 32);
diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 822c5306a7a4..4962d17a175e 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -2372,7 +2372,7 @@ static int check_chunk_block_group_mappings(struct btrfs_fs_info *fs_info)
 }
 
 static int read_one_block_group(struct btrfs_fs_info *info,
-				struct btrfs_block_group_item *bgi,
+				struct btrfs_block_group_item_v2 *bgi,
 				const struct btrfs_key *key,
 				int need_clear)
 {
@@ -2387,11 +2387,16 @@ static int read_one_block_group(struct btrfs_fs_info *info,
 		return -ENOMEM;
 
 	cache->length = key->offset;
-	cache->used = btrfs_stack_block_group_used(bgi);
+	cache->used = btrfs_stack_block_group_v2_used(bgi);
 	cache->last_used = cache->used;
-	cache->flags = btrfs_stack_block_group_flags(bgi);
-	cache->global_root_id = btrfs_stack_block_group_chunk_objectid(bgi);
+	cache->flags = btrfs_stack_block_group_v2_flags(bgi);
+	cache->global_root_id = btrfs_stack_block_group_v2_chunk_objectid(bgi);
 	cache->space_info = btrfs_find_space_info(info, cache->flags);
+	cache->remap_bytes = btrfs_stack_block_group_v2_remap_bytes(bgi);
+	cache->last_remap_bytes = cache->remap_bytes;
+	cache->identity_remap_count =
+		btrfs_stack_block_group_v2_identity_remap_count(bgi);
+	cache->last_identity_remap_count = cache->identity_remap_count;
 
 	btrfs_set_free_space_tree_thresholds(cache);
 
@@ -2456,7 +2461,7 @@ static int read_one_block_group(struct btrfs_fs_info *info,
 	} else if (cache->length == cache->used) {
 		cache->cached = BTRFS_CACHE_FINISHED;
 		btrfs_free_excluded_extents(cache);
-	} else if (cache->used == 0) {
+	} else if (cache->used == 0 && cache->remap_bytes == 0) {
 		cache->cached = BTRFS_CACHE_FINISHED;
 		ret = btrfs_add_new_free_space(cache, cache->start,
 					       cache->start + cache->length, NULL);
@@ -2476,7 +2481,7 @@ static int read_one_block_group(struct btrfs_fs_info *info,
 
 	set_avail_alloc_bits(info, cache->flags);
 	if (btrfs_chunk_writeable(info, cache->start)) {
-		if (cache->used == 0) {
+		if (cache->used == 0 && cache->remap_bytes == 0) {
 			ASSERT(list_empty(&cache->bg_list));
 			if (btrfs_test_opt(info, DISCARD_ASYNC))
 				btrfs_discard_queue_work(&info->discard_ctl, cache);
@@ -2580,9 +2585,10 @@ int btrfs_read_block_groups(struct btrfs_fs_info *info)
 		need_clear = 1;
 
 	while (1) {
-		struct btrfs_block_group_item bgi;
+		struct btrfs_block_group_item_v2 bgi;
 		struct extent_buffer *leaf;
 		int slot;
+		size_t size;
 
 		ret = find_first_block_group(info, path, &key);
 		if (ret > 0)
@@ -2593,8 +2599,16 @@ int btrfs_read_block_groups(struct btrfs_fs_info *info)
 		leaf = path->nodes[0];
 		slot = path->slots[0];
 
+		if (btrfs_fs_incompat(info, REMAP_TREE)) {
+			size = sizeof(struct btrfs_block_group_item_v2);
+		} else {
+			size = sizeof(struct btrfs_block_group_item);
+			btrfs_set_stack_block_group_v2_remap_bytes(&bgi, 0);
+			btrfs_set_stack_block_group_v2_identity_remap_count(&bgi, 0);
+		}
+
 		read_extent_buffer(leaf, &bgi, btrfs_item_ptr_offset(leaf, slot),
-				   sizeof(bgi));
+				   size);
 
 		btrfs_item_key_to_cpu(leaf, &key, slot);
 		btrfs_release_path(path);
@@ -2664,25 +2678,38 @@ static int insert_block_group_item(struct btrfs_trans_handle *trans,
 				   struct btrfs_block_group *block_group)
 {
 	struct btrfs_fs_info *fs_info = trans->fs_info;
-	struct btrfs_block_group_item bgi;
+	struct btrfs_block_group_item_v2 bgi;
 	struct btrfs_root *root = btrfs_block_group_root(fs_info);
 	struct btrfs_key key;
 	u64 old_last_used;
+	size_t size;
 	int ret;
 
 	spin_lock(&block_group->lock);
-	btrfs_set_stack_block_group_used(&bgi, block_group->used);
-	btrfs_set_stack_block_group_chunk_objectid(&bgi,
-						   block_group->global_root_id);
-	btrfs_set_stack_block_group_flags(&bgi, block_group->flags);
+	btrfs_set_stack_block_group_v2_used(&bgi, block_group->used);
+	btrfs_set_stack_block_group_v2_chunk_objectid(&bgi,
+						      block_group->global_root_id);
+	btrfs_set_stack_block_group_v2_flags(&bgi, block_group->flags);
+	btrfs_set_stack_block_group_v2_remap_bytes(&bgi,
+						   block_group->remap_bytes);
+	btrfs_set_stack_block_group_v2_identity_remap_count(&bgi,
+					block_group->identity_remap_count);
 	old_last_used = block_group->last_used;
 	block_group->last_used = block_group->used;
+	block_group->last_remap_bytes = block_group->remap_bytes;
+	block_group->last_identity_remap_count =
+		block_group->identity_remap_count;
 	key.objectid = block_group->start;
 	key.type = BTRFS_BLOCK_GROUP_ITEM_KEY;
 	key.offset = block_group->length;
 	spin_unlock(&block_group->lock);
 
-	ret = btrfs_insert_item(trans, root, &key, &bgi, sizeof(bgi));
+	if (btrfs_fs_incompat(fs_info, REMAP_TREE))
+		size = sizeof(struct btrfs_block_group_item_v2);
+	else
+		size = sizeof(struct btrfs_block_group_item);
+
+	ret = btrfs_insert_item(trans, root, &key, &bgi, size);
 	if (ret < 0) {
 		spin_lock(&block_group->lock);
 		block_group->last_used = old_last_used;
@@ -3137,10 +3164,12 @@ static int update_block_group_item(struct btrfs_trans_handle *trans,
 	struct btrfs_root *root = btrfs_block_group_root(fs_info);
 	unsigned long bi;
 	struct extent_buffer *leaf;
-	struct btrfs_block_group_item bgi;
+	struct btrfs_block_group_item_v2 bgi;
 	struct btrfs_key key;
-	u64 old_last_used;
-	u64 used;
+	u64 old_last_used, old_last_remap_bytes;
+	u32 old_last_identity_remap_count;
+	u64 used, remap_bytes;
+	u32 identity_remap_count;
 
 	/*
 	 * Block group items update can be triggered out of commit transaction
@@ -3150,13 +3179,21 @@ static int update_block_group_item(struct btrfs_trans_handle *trans,
 	 */
 	spin_lock(&cache->lock);
 	old_last_used = cache->last_used;
+	old_last_remap_bytes = cache->last_remap_bytes;
+	old_last_identity_remap_count = cache->last_identity_remap_count;
 	used = cache->used;
-	/* No change in used bytes, can safely skip it. */
-	if (cache->last_used == used) {
+	remap_bytes = cache->remap_bytes;
+	identity_remap_count = cache->identity_remap_count;
+	/* No change in values, can safely skip it. */
+	if (cache->last_used == used &&
+	    cache->last_remap_bytes == remap_bytes &&
+	    cache->last_identity_remap_count == identity_remap_count) {
 		spin_unlock(&cache->lock);
 		return 0;
 	}
 	cache->last_used = used;
+	cache->last_remap_bytes = remap_bytes;
+	cache->last_identity_remap_count = identity_remap_count;
 	spin_unlock(&cache->lock);
 
 	key.objectid = cache->start;
@@ -3172,11 +3209,23 @@ static int update_block_group_item(struct btrfs_trans_handle *trans,
 
 	leaf = path->nodes[0];
 	bi = btrfs_item_ptr_offset(leaf, path->slots[0]);
-	btrfs_set_stack_block_group_used(&bgi, used);
-	btrfs_set_stack_block_group_chunk_objectid(&bgi,
-						   cache->global_root_id);
-	btrfs_set_stack_block_group_flags(&bgi, cache->flags);
-	write_extent_buffer(leaf, &bgi, bi, sizeof(bgi));
+	btrfs_set_stack_block_group_v2_used(&bgi, used);
+	btrfs_set_stack_block_group_v2_chunk_objectid(&bgi,
+						      cache->global_root_id);
+	btrfs_set_stack_block_group_v2_flags(&bgi, cache->flags);
+
+	if (btrfs_fs_incompat(fs_info, REMAP_TREE)) {
+		btrfs_set_stack_block_group_v2_remap_bytes(&bgi,
+							   cache->remap_bytes);
+		btrfs_set_stack_block_group_v2_identity_remap_count(&bgi,
+						cache->identity_remap_count);
+		write_extent_buffer(leaf, &bgi, bi,
+				    sizeof(struct btrfs_block_group_item_v2));
+	} else {
+		write_extent_buffer(leaf, &bgi, bi,
+				    sizeof(struct btrfs_block_group_item));
+	}
+
 fail:
 	btrfs_release_path(path);
 	/*
@@ -3191,6 +3240,9 @@ static int update_block_group_item(struct btrfs_trans_handle *trans,
 	if (ret < 0 && ret != -ENOENT) {
 		spin_lock(&cache->lock);
 		cache->last_used = old_last_used;
+		cache->last_remap_bytes = old_last_remap_bytes;
+		cache->last_identity_remap_count =
+			old_last_identity_remap_count;
 		spin_unlock(&cache->lock);
 	}
 	return ret;
diff --git a/fs/btrfs/block-group.h b/fs/btrfs/block-group.h
index 01401e9959c1..4cee3448ded3 100644
--- a/fs/btrfs/block-group.h
+++ b/fs/btrfs/block-group.h
@@ -129,6 +129,8 @@ struct btrfs_block_group {
 	u64 flags;
 	u64 cache_generation;
 	u64 global_root_id;
+	u64 remap_bytes;
+	u32 identity_remap_count;
 
 	/*
 	 * The last committed used bytes of this block group, if the above @used
@@ -136,6 +138,15 @@ struct btrfs_block_group {
 	 * group item of this block group.
 	 */
 	u64 last_used;
+	/*
+	 * The last committed remap_bytes value of this block group.
+	 */
+	u64 last_remap_bytes;
+	/*
+	 * The last commited identity_remap_count value of this block group.
+	 */
+	u32 last_identity_remap_count;
+
 	/*
 	 * If the free space extent count exceeds this number, convert the block
 	 * group to bitmaps.
@@ -282,7 +293,8 @@ static inline bool btrfs_is_block_group_used(const struct btrfs_block_group *bg)
 {
 	lockdep_assert_held(&bg->lock);
 
-	return (bg->used > 0 || bg->reserved > 0 || bg->pinned > 0);
+	return (bg->used > 0 || bg->reserved > 0 || bg->pinned > 0 ||
+		bg->remap_bytes > 0);
 }
 
 static inline bool btrfs_is_block_group_data_only(const struct btrfs_block_group *block_group)
diff --git a/fs/btrfs/discard.c b/fs/btrfs/discard.c
index 89fe85778115..ee5f5b2788e1 100644
--- a/fs/btrfs/discard.c
+++ b/fs/btrfs/discard.c
@@ -373,7 +373,7 @@ void btrfs_discard_queue_work(struct btrfs_discard_ctl *discard_ctl,
 	if (!block_group || !btrfs_test_opt(block_group->fs_info, DISCARD_ASYNC))
 		return;
 
-	if (block_group->used == 0)
+	if (block_group->used == 0 && block_group->remap_bytes == 0)
 		add_to_discard_unused_list(discard_ctl, block_group);
 	else
 		add_to_discard_list(discard_ctl, block_group);
diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
index 4e390d6517a3..d524fd4c3898 100644
--- a/fs/btrfs/tree-checker.c
+++ b/fs/btrfs/tree-checker.c
@@ -688,6 +688,7 @@ static int check_block_group_item(struct extent_buffer *leaf,
 	u64 chunk_objectid;
 	u64 flags;
 	u64 type;
+	size_t exp_size;
 
 	/*
 	 * Here we don't really care about alignment since extent allocator can
@@ -699,10 +700,15 @@ static int check_block_group_item(struct extent_buffer *leaf,
 		return -EUCLEAN;
 	}
 
-	if (unlikely(item_size != sizeof(bgi))) {
+	if (btrfs_fs_incompat(fs_info, REMAP_TREE))
+		exp_size = sizeof(struct btrfs_block_group_item_v2);
+	else
+		exp_size = sizeof(struct btrfs_block_group_item);
+
+	if (unlikely(item_size != exp_size)) {
 		block_group_err(leaf, slot,
 			"invalid item size, have %u expect %zu",
-				item_size, sizeof(bgi));
+				item_size, exp_size);
 		return -EUCLEAN;
 	}
 
diff --git a/include/uapi/linux/btrfs_tree.h b/include/uapi/linux/btrfs_tree.h
index 76578426671c..86820a9644e8 100644
--- a/include/uapi/linux/btrfs_tree.h
+++ b/include/uapi/linux/btrfs_tree.h
@@ -1229,6 +1229,14 @@ struct btrfs_block_group_item {
 	__le64 flags;
 } __attribute__ ((__packed__));
 
+struct btrfs_block_group_item_v2 {
+	__le64 used;
+	__le64 chunk_objectid;
+	__le64 flags;
+	__le64 remap_bytes;
+	__le32 identity_remap_count;
+} __attribute__ ((__packed__));
+
 struct btrfs_free_space_info {
 	__le32 extent_count;
 	__le32 flags;
-- 
2.51.2


