Return-Path: <linux-btrfs+bounces-17583-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 40005BC8D2E
	for <lists+linux-btrfs@lfdr.de>; Thu, 09 Oct 2025 13:30:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4B0114E2732
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Oct 2025 11:29:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B4E12E542C;
	Thu,  9 Oct 2025 11:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=harmstone.com header.i=@harmstone.com header.b="N/59A4K9"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail.burntcomma.com (unknown [62.3.69.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF0592E0417
	for <linux-btrfs@vger.kernel.org>; Thu,  9 Oct 2025 11:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.3.69.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760009303; cv=none; b=OCXF8hOsA3jWLDuqP9jeI4QOCHMbRGRfIGVa5t/n3ZHimMGT63MaCnkOps3VomttcMX4BaYuh2Miza2XF4YfD2QsUOMXVIXIRzZHLQy4WNWKyloZcUnj1BEV3DsQ9z+nXD+REB3W7Jczi/NWNiKB6J+HgxCkmMpl1p/FePzmLC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760009303; c=relaxed/simple;
	bh=nNFXd+W0bbe3oZRMWo5NeZNDhuGhPN9KSohLrfJ1TUk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Mime-Version; b=SoK6f411h7bLgp8BYXdgqm0TkCQ7ub5+A5gL4fpRr2x/VGyG9lFPTrpO6PRde/53NkyuvmcYcM30TGd0gBNBodV43LFoU9pCVgxh9YBKDpROob0eyrsEX9jMT1eVUOttsZiIwj+6jduvWQ+LFVXHlEnQG+OjBgEcpmNCanOEfSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=harmstone.com; spf=fail smtp.mailfrom=harmstone.com; dkim=pass (1024-bit key) header.d=harmstone.com header.i=@harmstone.com header.b=N/59A4K9; arc=none smtp.client-ip=62.3.69.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=harmstone.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=harmstone.com
Received: from localhost.localdomain (beren.burntcomma.com [IPv6:2a02:8012:8cf0:0:ce28:aaff:fe0d:6db2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.burntcomma.com (Postfix) with ESMTPSA id BC5AA2C5659;
	Thu,  9 Oct 2025 12:28:08 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=harmstone.com;
	s=mail; t=1760009288;
	bh=2PdcXLo98klAQeI5sQ3gi945xmkquDXhmwq0AJRNqJA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=N/59A4K9CPw6141xHig8sOb5M8mrYWO9gXgq5G6TDF3dz2YA961Y6sBY7jvxMh5Ma
	 nFlFNxJoTPoQjZc2fZrirL6gSk5B0L4Nik3QF4rSPWBBszBedqMLUFm/64ZYZDTwiO
	 uDgFkT3GgmgDv2DWzCjC7vsMrBl+q9hcsC+pPoH4=
From: Mark Harmstone <mark@harmstone.com>
To: linux-btrfs@vger.kernel.org
Cc: Mark Harmstone <mark@harmstone.com>
Subject: [PATCH v3 12/17] btrfs: move existing remaps before relocating block group
Date: Thu,  9 Oct 2025 12:28:07 +0100
Message-ID: <20251009112814.13942-13-mark@harmstone.com>
In-Reply-To: <20251009112814.13942-1-mark@harmstone.com>
References: <20251009112814.13942-1-mark@harmstone.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit

If when relocating a block group we find that `remap_bytes` > 0 in its
block group item, that means that it has been the destination block
group for another that has been remapped.

We need to seach the remap tree for any remap backrefs within this
range, and move the data to a third block group. This is because
otherwise btrfs_translate_remap() could end up following an unbounded
chain of remaps, which would only get worse over time.

We only relocate one block group at a time, so `remap_bytes` will only
ever go down while we are doing this. Once we're finished we set the
REMAPPED flag on the block group, which will permanently prevent any
other data from being moved to within it.

Signed-off-by: Mark Harmstone <mark@harmstone.com>
---
 fs/btrfs/extent-tree.c |   6 +-
 fs/btrfs/relocation.c  | 481 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 485 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 60287aca283d..469b083f11ea 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -4545,7 +4545,8 @@ static noinline int find_free_extent(struct btrfs_root *root,
 		    block_group->cached != BTRFS_CACHE_NO) {
 			down_read(&space_info->groups_sem);
 			if (list_empty(&block_group->list) ||
-			    block_group->ro) {
+			    block_group->ro ||
+			    block_group->flags & BTRFS_BLOCK_GROUP_REMAPPED) {
 				/*
 				 * someone is removing this block group,
 				 * we can't jump into the have_block_group
@@ -4579,7 +4580,8 @@ static noinline int find_free_extent(struct btrfs_root *root,
 
 		ffe_ctl->hinted = false;
 		/* If the block group is read-only, we can skip it entirely. */
-		if (unlikely(block_group->ro)) {
+		if (unlikely(block_group->ro) ||
+		    block_group->flags & BTRFS_BLOCK_GROUP_REMAPPED) {
 			if (ffe_ctl->for_treelog)
 				btrfs_clear_treelog_bg(block_group);
 			if (ffe_ctl->for_data_reloc)
diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 44614e149016..307d68d93259 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -3980,6 +3980,481 @@ static void adjust_block_group_remap_bytes(struct btrfs_trans_handle *trans,
 		btrfs_inc_delayed_refs_rsv_bg_updates(fs_info);
 }
 
+struct reloc_io_private {
+	struct completion done;
+	refcount_t pending_refs;
+	blk_status_t status;
+};
+
+static void reloc_endio(struct btrfs_bio *bbio)
+{
+	struct reloc_io_private *priv = bbio->private;
+
+	if (bbio->bio.bi_status)
+		WRITE_ONCE(priv->status, bbio->bio.bi_status);
+
+	if (refcount_dec_and_test(&priv->pending_refs))
+		complete(&priv->done);
+
+	bio_put(&bbio->bio);
+}
+
+static int copy_remapped_data_io(struct btrfs_fs_info *fs_info,
+				 struct reloc_io_private *priv,
+				 struct page **pages, u64 addr, u64 length,
+				 bool do_write)
+{
+	struct btrfs_bio *bbio;
+	unsigned long i = 0;
+	blk_opf_t op = do_write ? REQ_OP_WRITE : REQ_OP_READ;
+
+	init_completion(&priv->done);
+	refcount_set(&priv->pending_refs, 1);
+	priv->status = 0;
+
+	bbio = btrfs_bio_alloc(BIO_MAX_VECS, op, fs_info, reloc_endio,
+			       priv);
+	bbio->bio.bi_iter.bi_sector = addr >> SECTOR_SHIFT;
+
+	do {
+		size_t bytes = min_t(u64, length, PAGE_SIZE);
+
+		if (bio_add_page(&bbio->bio, pages[i], bytes, 0) < bytes) {
+			refcount_inc(&priv->pending_refs);
+			btrfs_submit_bbio(bbio, 0);
+
+			bbio = btrfs_bio_alloc(BIO_MAX_VECS, op, fs_info,
+					       reloc_endio, priv);
+			bbio->bio.bi_iter.bi_sector = addr >> SECTOR_SHIFT;
+			continue;
+		}
+
+		i++;
+		addr += bytes;
+		length -= bytes;
+	} while (length);
+
+	refcount_inc(&priv->pending_refs);
+	btrfs_submit_bbio(bbio, 0);
+
+	if (!refcount_dec_and_test(&priv->pending_refs))
+		wait_for_completion_io(&priv->done);
+
+	return blk_status_to_errno(READ_ONCE(priv->status));
+}
+
+static int copy_remapped_data(struct btrfs_fs_info *fs_info, u64 old_addr,
+			      u64 new_addr, u64 length)
+{
+	int ret;
+	struct page **pages;
+	unsigned int nr_pages;
+	struct reloc_io_private priv;
+
+	nr_pages = DIV_ROUND_UP(length, PAGE_SIZE);
+	pages = kcalloc(nr_pages, sizeof(struct page *), GFP_NOFS);
+	if (!pages)
+		return -ENOMEM;
+	ret = btrfs_alloc_page_array(nr_pages, pages, 0);
+	if (ret) {
+		ret = -ENOMEM;
+		goto end;
+	}
+
+	ret = copy_remapped_data_io(fs_info, &priv, pages, old_addr, length,
+				    false);
+	if (ret)
+		goto end;
+
+	ret = copy_remapped_data_io(fs_info, &priv, pages, new_addr, length,
+				    true);
+
+end:
+	for (unsigned int i = 0; i < nr_pages; i++) {
+		if (pages[i])
+			__free_page(pages[i]);
+	}
+	kfree(pages);
+
+	return ret;
+}
+
+static int do_copy(struct btrfs_fs_info *fs_info, u64 old_addr, u64 new_addr,
+		   u64 length)
+{
+	int ret;
+
+	/* Copy 1MB at a time, to avoid using too much memory. */
+
+	do {
+		u64 to_copy = min_t(u64, length, SZ_1M);
+
+		ret = copy_remapped_data(fs_info, old_addr, new_addr,
+					 to_copy);
+		if (ret)
+			return ret;
+
+		if (to_copy == length)
+			break;
+
+		old_addr += to_copy;
+		new_addr += to_copy;
+		length -= to_copy;
+	} while (true);
+
+	return 0;
+}
+
+static int add_remap_item(struct btrfs_trans_handle *trans,
+			  struct btrfs_path *path, u64 new_addr, u64 length,
+			  u64 old_addr)
+{
+	struct btrfs_fs_info *fs_info = trans->fs_info;
+	struct btrfs_remap remap;
+	struct btrfs_key key;
+	struct extent_buffer *leaf;
+	int ret;
+
+	key.objectid = old_addr;
+	key.type = BTRFS_REMAP_KEY;
+	key.offset = length;
+
+	ret = btrfs_insert_empty_item(trans, fs_info->remap_root, path,
+				      &key, sizeof(struct btrfs_remap));
+	if (ret)
+		return ret;
+
+	leaf = path->nodes[0];
+
+	btrfs_set_stack_remap_address(&remap, new_addr);
+
+	write_extent_buffer(leaf, &remap,
+			    btrfs_item_ptr_offset(leaf, path->slots[0]),
+			    sizeof(struct btrfs_remap));
+
+	btrfs_release_path(path);
+
+	return 0;
+}
+
+static int add_remap_backref_item(struct btrfs_trans_handle *trans,
+				  struct btrfs_path *path, u64 new_addr,
+				  u64 length, u64 old_addr)
+{
+	struct btrfs_fs_info *fs_info = trans->fs_info;
+	struct btrfs_remap remap;
+	struct btrfs_key key;
+	struct extent_buffer *leaf;
+	int ret;
+
+	key.objectid = new_addr;
+	key.type = BTRFS_REMAP_BACKREF_KEY;
+	key.offset = length;
+
+	ret = btrfs_insert_empty_item(trans, fs_info->remap_root,
+				      path, &key, sizeof(struct btrfs_remap));
+	if (ret)
+		return ret;
+
+	leaf = path->nodes[0];
+
+	btrfs_set_stack_remap_address(&remap, old_addr);
+
+	write_extent_buffer(leaf, &remap,
+			    btrfs_item_ptr_offset(leaf, path->slots[0]),
+			    sizeof(struct btrfs_remap));
+
+	btrfs_release_path(path);
+
+	return 0;
+}
+
+static int move_existing_remap(struct btrfs_fs_info *fs_info,
+			       struct btrfs_path *path,
+			       struct btrfs_block_group *bg, u64 new_addr,
+			       u64 length, u64 old_addr)
+{
+	struct btrfs_trans_handle *trans;
+	struct extent_buffer *leaf;
+	struct btrfs_remap *remap_ptr, remap;
+	struct btrfs_key key, ins;
+	u64 dest_addr, dest_length, min_size;
+	struct btrfs_block_group *dest_bg;
+	int ret;
+	bool is_data = bg->flags & BTRFS_BLOCK_GROUP_DATA;
+	struct btrfs_space_info *sinfo = bg->space_info;
+	bool mutex_taken = false, bg_needs_free_space;
+
+	spin_lock(&sinfo->lock);
+	btrfs_space_info_update_bytes_may_use(sinfo, length);
+	spin_unlock(&sinfo->lock);
+
+	if (is_data)
+		min_size = fs_info->sectorsize;
+	else
+		min_size = fs_info->nodesize;
+
+	ret = btrfs_reserve_extent(fs_info->fs_root, length, length, min_size,
+				   0, 0, &ins, is_data, false);
+	if (ret) {
+		spin_lock(&sinfo->lock);
+		btrfs_space_info_update_bytes_may_use(sinfo, -length);
+		spin_unlock(&sinfo->lock);
+		return ret;
+	}
+
+	dest_addr = ins.objectid;
+	dest_length = ins.offset;
+
+	if (!is_data && !IS_ALIGNED(dest_length, fs_info->nodesize)) {
+		u64 new_length = ALIGN_DOWN(dest_length, fs_info->nodesize);
+
+		btrfs_free_reserved_extent(fs_info, dest_addr + new_length,
+					   dest_length - new_length, 0);
+
+		dest_length = new_length;
+	}
+
+	trans = btrfs_join_transaction(fs_info->remap_root);
+	if (IS_ERR(trans)) {
+		ret = PTR_ERR(trans);
+		trans = NULL;
+		goto end;
+	}
+
+	mutex_lock(&fs_info->remap_mutex);
+	mutex_taken = true;
+
+	/* Find old remap entry. */
+
+	key.objectid = old_addr;
+	key.type = BTRFS_REMAP_KEY;
+	key.offset = length;
+
+	ret = btrfs_search_slot(trans, fs_info->remap_root, &key,
+				path, 0, 1);
+	if (ret == 1) {
+		/*
+		 * Not a problem if the remap entry wasn't found: that means
+		 * that another transaction has deallocated the data.
+		 * move_existing_remaps() loops until the BG contains no
+		 * remaps, so we can just return 0 in this case.
+		 */
+		btrfs_release_path(path);
+		ret = 0;
+		goto end;
+	} else if (ret) {
+		goto end;
+	}
+
+	ret = do_copy(fs_info, new_addr, dest_addr, dest_length);
+	if (ret)
+		goto end;
+
+	/* Change data of old remap entry. */
+
+	leaf = path->nodes[0];
+
+	remap_ptr = btrfs_item_ptr(leaf, path->slots[0], struct btrfs_remap);
+	btrfs_set_remap_address(leaf, remap_ptr, dest_addr);
+
+	btrfs_mark_buffer_dirty(trans, leaf);
+
+	if (dest_length != length) {
+		key.offset = dest_length;
+		btrfs_set_item_key_safe(trans, path, &key);
+	}
+
+	btrfs_release_path(path);
+
+	if (dest_length != length) {
+		/* Add remap item for remainder. */
+
+		ret = add_remap_item(trans, path, new_addr + dest_length,
+				     length - dest_length,
+				     old_addr + dest_length);
+		if (ret)
+			goto end;
+	}
+
+	/* Change or remove old backref. */
+
+	key.objectid = new_addr;
+	key.type = BTRFS_REMAP_BACKREF_KEY;
+	key.offset = length;
+
+	ret = btrfs_search_slot(trans, fs_info->remap_root, &key,
+				path, -1, 1);
+	if (ret) {
+		if (ret == 1) {
+			btrfs_release_path(path);
+			ret = -ENOENT;
+		}
+		goto end;
+	}
+
+	leaf = path->nodes[0];
+
+	if (dest_length == length) {
+		ret = btrfs_del_item(trans, fs_info->remap_root, path);
+		if (ret) {
+			btrfs_release_path(path);
+			goto end;
+		}
+	} else {
+		key.objectid += dest_length;
+		key.offset -= dest_length;
+		btrfs_set_item_key_safe(trans, path, &key);
+
+		btrfs_set_stack_remap_address(&remap, old_addr + dest_length);
+
+		write_extent_buffer(leaf, &remap,
+				    btrfs_item_ptr_offset(leaf, path->slots[0]),
+				    sizeof(struct btrfs_remap));
+	}
+
+	btrfs_release_path(path);
+
+	/* Add new backref. */
+
+	ret = add_remap_backref_item(trans, path, dest_addr, dest_length,
+				     old_addr);
+	if (ret)
+		goto end;
+
+	adjust_block_group_remap_bytes(trans, bg, -dest_length);
+
+	ret = btrfs_add_to_free_space_tree(trans, new_addr, dest_length);
+	if (ret)
+		goto end;
+
+	dest_bg = btrfs_lookup_block_group(fs_info, dest_addr);
+
+	adjust_block_group_remap_bytes(trans, dest_bg, dest_length);
+
+	mutex_lock(&dest_bg->free_space_lock);
+	bg_needs_free_space = test_bit(BLOCK_GROUP_FLAG_NEEDS_FREE_SPACE,
+				       &dest_bg->runtime_flags);
+	mutex_unlock(&dest_bg->free_space_lock);
+	btrfs_put_block_group(dest_bg);
+
+	if (bg_needs_free_space) {
+		ret = btrfs_add_block_group_free_space(trans, dest_bg);
+		if (ret)
+			goto end;
+	}
+
+	ret = btrfs_remove_from_free_space_tree(trans, dest_addr, dest_length);
+	if (ret) {
+		btrfs_remove_from_free_space_tree(trans, new_addr,
+						  dest_length);
+		goto end;
+	}
+
+	ret = 0;
+
+end:
+	if (mutex_taken)
+		mutex_unlock(&fs_info->remap_mutex);
+
+	btrfs_dec_block_group_reservations(fs_info, dest_addr);
+
+	if (ret) {
+		btrfs_free_reserved_extent(fs_info, dest_addr, dest_length, 0);
+
+		if (trans) {
+			btrfs_abort_transaction(trans, ret);
+			btrfs_end_transaction(trans);
+		}
+	} else {
+		dest_bg = btrfs_lookup_block_group(fs_info, dest_addr);
+		btrfs_free_reserved_bytes(dest_bg, dest_length, 0);
+		btrfs_put_block_group(dest_bg);
+
+		ret = btrfs_commit_transaction(trans);
+	}
+
+	return ret;
+}
+
+static int move_existing_remaps(struct btrfs_fs_info *fs_info,
+				struct btrfs_block_group *bg,
+				struct btrfs_path *path)
+{
+	int ret;
+	struct btrfs_key key;
+	struct extent_buffer *leaf;
+	struct btrfs_remap *remap;
+	u64 old_addr;
+
+	/* Look for backrefs in remap tree. */
+
+	while (bg->remap_bytes > 0) {
+		key.objectid = bg->start;
+		key.type = BTRFS_REMAP_BACKREF_KEY;
+		key.offset = 0;
+
+		ret = btrfs_search_slot(NULL, fs_info->remap_root, &key, path,
+					0, 0);
+		if (ret < 0)
+			return ret;
+
+		leaf = path->nodes[0];
+
+		if (path->slots[0] >= btrfs_header_nritems(leaf)) {
+			ret = btrfs_next_leaf(fs_info->remap_root, path);
+			if (ret < 0) {
+				btrfs_release_path(path);
+				return ret;
+			}
+
+			if (ret) {
+				btrfs_release_path(path);
+				break;
+			}
+
+			leaf = path->nodes[0];
+		}
+
+		btrfs_item_key_to_cpu(leaf, &key, path->slots[0]);
+
+		if (key.type != BTRFS_REMAP_BACKREF_KEY) {
+			path->slots[0]++;
+
+			if (path->slots[0] >= btrfs_header_nritems(leaf)) {
+				ret = btrfs_next_leaf(fs_info->remap_root, path);
+				if (ret < 0) {
+					btrfs_release_path(path);
+					return ret;
+				}
+
+				if (ret) {
+					btrfs_release_path(path);
+					break;
+				}
+
+				leaf = path->nodes[0];
+			}
+		}
+
+		remap = btrfs_item_ptr(leaf, path->slots[0],
+				       struct btrfs_remap);
+
+		old_addr = btrfs_remap_address(leaf, remap);
+
+		btrfs_release_path(path);
+
+		ret = move_existing_remap(fs_info, path, bg, key.objectid,
+					  key.offset, old_addr);
+		if (ret)
+			return ret;
+	}
+
+	BUG_ON(bg->remap_bytes > 0);
+
+	return 0;
+}
+
 static int create_remap_tree_entries(struct btrfs_trans_handle *trans,
 				     struct btrfs_path *path,
 				     struct btrfs_block_group *bg)
@@ -4551,6 +5026,12 @@ int btrfs_relocate_block_group(struct btrfs_fs_info *fs_info, u64 group_start,
 	WARN_ON(ret && ret != -EAGAIN);
 
 	if (*using_remap_tree) {
+		if (bg->remap_bytes != 0) {
+			ret = move_existing_remaps(fs_info, bg, path);
+			if (ret)
+				goto out;
+		}
+
 		ret = start_block_group_remapping(fs_info, path, bg);
 		goto out;
 	}
-- 
2.49.1


