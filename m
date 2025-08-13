Return-Path: <linux-btrfs+bounces-16064-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ACE9DB24C1B
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Aug 2025 16:39:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 916437BC5C9
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Aug 2025 14:36:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E99EE305E39;
	Wed, 13 Aug 2025 14:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=harmstone.com header.i=@harmstone.com header.b="GtmxCvRd"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail.burntcomma.com (mail2.burntcomma.com [217.169.27.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4BFC2FFDD4
	for <linux-btrfs@vger.kernel.org>; Wed, 13 Aug 2025 14:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.169.27.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755095730; cv=none; b=PA/3jQhnYOi5DTnzSnmejCimgoZJpxAXLIgQEJqVVhD+xN+vsTduW8CgOxiXfTGKobX3IDNSVOFwOoCV6Cw+W0C/i3l1m1FTelQPvy0TyH+uildXS1DMGGb2tKks95vbokURj8umZNZflj/Fj3E+9HNMKopqShSQNUWz6uw1eBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755095730; c=relaxed/simple;
	bh=hajR+y+ThrC1uXhEeGtFkPwsoX5BODNCOXV74LIWahM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Mime-Version; b=TSov/z4pBaHYUTy5dGmUEovum/7MQGd0zhD7QQ4emZTjhcdUNz62xb9bir8MxQsbiHBSsN1l2QOmDR0ko5ZqsRamImJ4gARrffRZ8vUZVFqAXzADFYC9pNZJl/nv8zhgqTvF1MrInnFx+/gioFn4QC1Yy0RCO2QORGPWU8uk4rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=harmstone.com; spf=pass smtp.mailfrom=harmstone.com; dkim=pass (1024-bit key) header.d=harmstone.com header.i=@harmstone.com header.b=GtmxCvRd; arc=none smtp.client-ip=217.169.27.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=harmstone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=harmstone.com
Received: from localhost.localdomain (beren.burntcomma.com [IPv6:2a02:8012:8cf0:0:ce28:aaff:fe0d:6db2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.burntcomma.com (Postfix) with ESMTPSA id 876E12A759C;
	Wed, 13 Aug 2025 15:35:13 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=harmstone.com;
	s=mail; t=1755095713;
	bh=TwWlrXUlcd9PYzv1SMIFRLyuqpfqzHuYeBHr0hBuglY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GtmxCvRdaSrs+BVY+2jyHaQpMuDHyY8e0blCuEnY0vX/t00h/7z27LzVMRfpMHp+a
	 ZTlC6zTLETLUWx7wIluiDjj4t1g5QP7iHi0k7VVnXQIK3YUSe+roPPA8oE4q5ch6SP
	 WwXvUJXdRaHSfj0LmlavAzzejUt52woAMLR43R/U=
From: Mark Harmstone <mark@harmstone.com>
To: linux-btrfs@vger.kernel.org
Cc: Mark Harmstone <mark@harmstone.com>
Subject: [PATCH v2 13/16] btrfs: replace identity maps with actual remaps when doing relocations
Date: Wed, 13 Aug 2025 15:34:55 +0100
Message-ID: <20250813143509.31073-14-mark@harmstone.com>
In-Reply-To: <20250813143509.31073-1-mark@harmstone.com>
References: <20250813143509.31073-1-mark@harmstone.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a function do_remap_tree_reloc(), which does the actual work of
doing a relocation using the remap tree.

In a loop we call do_remap_tree_reloc_trans(), which searches for the
first identity remap for the block group. We call btrfs_reserve_extent()
to find space elsewhere for it, and read the data into memory and write
it to the new location. We then carve out the identity remap and replace
it with an actual remap, which points to the new location in which to
look.

Once the last identity remap has been removed we call
last_identity_remap_gone(), which, as with deletions, removes the
chunk's stripes and device extents.

Signed-off-by: Mark Harmstone <mark@harmstone.com>
---
 fs/btrfs/relocation.c | 335 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 335 insertions(+)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index c4d758d016e2..84ff59866e96 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -4692,6 +4692,61 @@ static int mark_bg_remapped(struct btrfs_trans_handle *trans,
 	return ret;
 }
 
+static int find_next_identity_remap(struct btrfs_trans_handle *trans,
+				    struct btrfs_path *path, u64 bg_end,
+				    u64 last_start, u64 *start,
+				    u64 *length)
+{
+	int ret;
+	struct btrfs_key key, found_key;
+	struct btrfs_root *remap_root = trans->fs_info->remap_root;
+	struct extent_buffer *leaf;
+
+	key.objectid = last_start;
+	key.type = BTRFS_IDENTITY_REMAP_KEY;
+	key.offset = 0;
+
+	ret = btrfs_search_slot(trans, remap_root, &key, path, 0, 0);
+	if (ret < 0)
+		goto out;
+
+	leaf = path->nodes[0];
+	while (true) {
+		if (path->slots[0] >= btrfs_header_nritems(leaf)) {
+			ret = btrfs_next_leaf(remap_root, path);
+
+			if (ret != 0) {
+				if (ret == 1)
+					ret = -ENOENT;
+				goto out;
+			}
+
+			leaf = path->nodes[0];
+		}
+
+		btrfs_item_key_to_cpu(leaf, &found_key, path->slots[0]);
+
+		if (found_key.objectid >= bg_end) {
+			ret = -ENOENT;
+			goto out;
+		}
+
+		if (found_key.type == BTRFS_IDENTITY_REMAP_KEY) {
+			*start = found_key.objectid;
+			*length = found_key.offset;
+			ret = 0;
+			goto out;
+		}
+
+		path->slots[0]++;
+	}
+
+out:
+	btrfs_release_path(path);
+
+	return ret;
+}
+
 static int remove_chunk_stripes(struct btrfs_trans_handle *trans,
 				struct btrfs_chunk_map *chunk,
 				struct btrfs_path *path)
@@ -4809,6 +4864,98 @@ static int adjust_identity_remap_count(struct btrfs_trans_handle *trans,
 	return ret;
 }
 
+static int add_remap_entry(struct btrfs_trans_handle *trans,
+			   struct btrfs_path *path,
+			   struct btrfs_block_group *src_bg, u64 old_addr,
+			   u64 new_addr, u64 length)
+{
+	struct btrfs_fs_info *fs_info = trans->fs_info;
+	struct btrfs_key key, new_key;
+	int ret;
+	int identity_count_delta = 0;
+
+	key.objectid = old_addr;
+	key.type = (u8)-1;
+	key.offset = (u64)-1;
+
+	ret = btrfs_search_slot(trans, fs_info->remap_root, &key, path, -1, 1);
+	if (ret < 0)
+		goto end;
+
+	if (path->slots[0] == 0) {
+		ret = -ENOENT;
+		goto end;
+	}
+
+	path->slots[0]--;
+
+	btrfs_item_key_to_cpu(path->nodes[0], &key, path->slots[0]);
+
+	if (key.type != BTRFS_IDENTITY_REMAP_KEY ||
+	    key.objectid > old_addr ||
+	    key.objectid + key.offset <= old_addr) {
+		ret = -ENOENT;
+		goto end;
+	}
+
+	/* Shorten or delete identity mapping entry. */
+
+	if (key.objectid == old_addr) {
+		ret = btrfs_del_item(trans, fs_info->remap_root, path);
+		if (ret)
+			goto end;
+
+		identity_count_delta--;
+	} else {
+		new_key.objectid = key.objectid;
+		new_key.type = BTRFS_IDENTITY_REMAP_KEY;
+		new_key.offset = old_addr - key.objectid;
+
+		btrfs_set_item_key_safe(trans, path, &new_key);
+	}
+
+	btrfs_release_path(path);
+
+	/* Create new remap entry. */
+
+	ret = add_remap_item(trans, path, new_addr, length, old_addr);
+	if (ret)
+		goto end;
+
+	/* Add entry for remainder of identity mapping, if necessary. */
+
+	if (key.objectid + key.offset != old_addr + length) {
+		new_key.objectid = old_addr + length;
+		new_key.type = BTRFS_IDENTITY_REMAP_KEY;
+		new_key.offset = key.objectid + key.offset - old_addr - length;
+
+		ret = btrfs_insert_empty_item(trans, fs_info->remap_root,
+					      path, &new_key, 0);
+		if (ret)
+			goto end;
+
+		btrfs_release_path(path);
+
+		identity_count_delta++;
+	}
+
+	/* Add backref. */
+
+	ret = add_remap_backref_item(trans, path, new_addr, length, old_addr);
+	if (ret)
+		goto end;
+
+	if (identity_count_delta != 0) {
+		ret = adjust_identity_remap_count(trans, path, src_bg,
+						  identity_count_delta);
+	}
+
+end:
+	btrfs_release_path(path);
+
+	return ret;
+}
+
 static int mark_chunk_remapped(struct btrfs_trans_handle *trans,
 			       struct btrfs_path *path, uint64_t start)
 {
@@ -4858,6 +5005,186 @@ static int mark_chunk_remapped(struct btrfs_trans_handle *trans,
 	return ret;
 }
 
+static int do_remap_tree_reloc_trans(struct btrfs_fs_info *fs_info,
+				     struct btrfs_block_group *src_bg,
+				     struct btrfs_path *path, u64 *last_start)
+{
+	struct btrfs_trans_handle *trans;
+	struct btrfs_root *extent_root;
+	struct btrfs_key ins;
+	struct btrfs_block_group *dest_bg = NULL;
+	struct btrfs_chunk_map *chunk;
+	u64 start, remap_length, length, new_addr, min_size;
+	int ret;
+	bool no_more = false;
+	bool is_data = src_bg->flags & BTRFS_BLOCK_GROUP_DATA;
+	bool made_reservation = false, bg_needs_free_space;
+	struct btrfs_space_info *sinfo = src_bg->space_info;
+
+	extent_root = btrfs_extent_root(fs_info, src_bg->start);
+
+	trans = btrfs_start_transaction(extent_root, 0);
+	if (IS_ERR(trans))
+		return PTR_ERR(trans);
+
+	mutex_lock(&fs_info->remap_mutex);
+
+	ret = find_next_identity_remap(trans, path, src_bg->start + src_bg->length,
+				       *last_start, &start, &remap_length);
+	if (ret == -ENOENT) {
+		no_more = true;
+		goto next;
+	} else if (ret) {
+		mutex_unlock(&fs_info->remap_mutex);
+		btrfs_end_transaction(trans);
+		return ret;
+	}
+
+	/* Try to reserve enough space for block. */
+
+	spin_lock(&sinfo->lock);
+	btrfs_space_info_update_bytes_may_use(sinfo, remap_length);
+	spin_unlock(&sinfo->lock);
+
+	if (is_data)
+		min_size = fs_info->sectorsize;
+	else
+		min_size = fs_info->nodesize;
+
+	ret = btrfs_reserve_extent(fs_info->fs_root, remap_length,
+				   remap_length, min_size,
+				   0, 0, &ins, is_data, false);
+	if (ret) {
+		spin_lock(&sinfo->lock);
+		btrfs_space_info_update_bytes_may_use(sinfo, -remap_length);
+		spin_unlock(&sinfo->lock);
+
+		mutex_unlock(&fs_info->remap_mutex);
+		btrfs_end_transaction(trans);
+		return ret;
+	}
+
+	made_reservation = true;
+
+	new_addr = ins.objectid;
+	length = ins.offset;
+
+	if (!is_data && !IS_ALIGNED(length, fs_info->nodesize)) {
+		u64 new_length = ALIGN_DOWN(length, fs_info->nodesize);
+
+		btrfs_free_reserved_extent(fs_info, new_addr + new_length,
+					   length - new_length, 0);
+
+		length = new_length;
+	}
+
+	dest_bg = btrfs_lookup_block_group(fs_info, new_addr);
+
+	mutex_lock(&dest_bg->free_space_lock);
+	bg_needs_free_space = test_bit(BLOCK_GROUP_FLAG_NEEDS_FREE_SPACE,
+				       &dest_bg->runtime_flags);
+	mutex_unlock(&dest_bg->free_space_lock);
+
+	if (bg_needs_free_space) {
+		ret = btrfs_add_block_group_free_space(trans, dest_bg);
+		if (ret)
+			goto fail;
+	}
+
+	ret = do_copy(fs_info, start, new_addr, length);
+	if (ret)
+		goto fail;
+
+	ret = btrfs_remove_from_free_space_tree(trans, new_addr, length);
+	if (ret)
+		goto fail;
+
+	ret = add_remap_entry(trans, path, src_bg, start, new_addr, length);
+	if (ret) {
+		btrfs_add_to_free_space_tree(trans, new_addr, length);
+		goto fail;
+	}
+
+	adjust_block_group_remap_bytes(trans, dest_bg, length);
+	btrfs_free_reserved_bytes(dest_bg, length, 0);
+
+	spin_lock(&sinfo->lock);
+	sinfo->bytes_readonly += length;
+	spin_unlock(&sinfo->lock);
+
+next:
+	if (dest_bg)
+		btrfs_put_block_group(dest_bg);
+
+	if (made_reservation)
+		btrfs_dec_block_group_reservations(fs_info, new_addr);
+
+	if (src_bg->used == 0 && src_bg->remap_bytes == 0) {
+		chunk = btrfs_find_chunk_map(fs_info, src_bg->start, 1);
+		if (!chunk) {
+			mutex_unlock(&fs_info->remap_mutex);
+			btrfs_end_transaction(trans);
+			return -ENOENT;
+		}
+
+		ret = last_identity_remap_gone(trans, chunk, src_bg, path);
+		if (ret) {
+			btrfs_free_chunk_map(chunk);
+			mutex_unlock(&fs_info->remap_mutex);
+			btrfs_end_transaction(trans);
+			return ret;
+		}
+
+		btrfs_free_chunk_map(chunk);
+	}
+
+	mutex_unlock(&fs_info->remap_mutex);
+
+	ret = btrfs_end_transaction(trans);
+	if (ret)
+		return ret;
+
+	if (no_more)
+		return 1;
+
+	*last_start = start;
+
+	return 0;
+
+fail:
+	if (dest_bg)
+		btrfs_put_block_group(dest_bg);
+
+	btrfs_free_reserved_extent(fs_info, new_addr, length, 0);
+
+	mutex_unlock(&fs_info->remap_mutex);
+	btrfs_end_transaction(trans);
+
+	return ret;
+}
+
+static int do_remap_tree_reloc(struct btrfs_fs_info *fs_info,
+			       struct btrfs_path *path,
+			       struct btrfs_block_group *bg)
+{
+	u64 last_start;
+	int ret;
+
+	last_start = bg->start;
+
+	while (true) {
+		ret = do_remap_tree_reloc_trans(fs_info, bg, path,
+						&last_start);
+		if (ret) {
+			if (ret == 1)
+				ret = 0;
+			break;
+		}
+	}
+
+	return ret;
+}
+
 int btrfs_translate_remap(struct btrfs_fs_info *fs_info, u64 *logical,
 			  u64 *length, bool nolock)
 {
@@ -5100,6 +5427,14 @@ int btrfs_relocate_block_group(struct btrfs_fs_info *fs_info, u64 group_start,
 		}
 
 		err = start_block_group_remapping(fs_info, path, bg);
+		if (err)
+			goto out;
+
+		err = do_remap_tree_reloc(fs_info, path, rc->block_group);
+		if (err)
+			goto out;
+
+		btrfs_delete_unused_bgs(fs_info);
 
 		goto out;
 	}
-- 
2.49.1


