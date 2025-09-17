Return-Path: <linux-btrfs+bounces-16894-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CC4DB813E8
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Sep 2025 19:54:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7771627C9B
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Sep 2025 17:54:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70B632FE599;
	Wed, 17 Sep 2025 17:54:20 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB4A9235C17
	for <linux-btrfs@vger.kernel.org>; Wed, 17 Sep 2025 17:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758131660; cv=none; b=Uz+uS7VIJIYHzsDZMmr4x6/pLhgiQ2IrVLQNd+PcmiQjcR+P5iopc5uXUcmr1TNJsHZ2I95whoeG7DKWcw8iNBdBDGiRTLtXKPvKI9aFB07eO2rYJN2PXEmg05R+B5kbqpqy417X+qvfjTX7RtEpzN5F7gSJK2imzWRQgb1YcMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758131660; c=relaxed/simple;
	bh=gu4DzUzACaiOmBJTeEyOzK07PABkOfBQ2L0aoOKu5XU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UBE8z4hFxt9a13RlhmqAuDN/BJ2O2lzpd56zePTI6nkNTZkfTWXxJ6P5UsxwPU+Ql787mnST2haBw7VcfBVNPJbk8DPL58Ye6Vno5ScECVeazArQbDMt6WLT3hjXT3vgjHQwYrJJmrgjRH7cp7n4KiT1vfVqnUi+znQ6ebhzIxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7F99921EFF;
	Wed, 17 Sep 2025 17:54:08 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 784E1137C3;
	Wed, 17 Sep 2025 17:54:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id MC1cHcD1ymiFSgAAD6G6ig
	(envelope-from <dsterba@suse.com>); Wed, 17 Sep 2025 17:54:08 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 1/3] btrfs: add unlikely annotations to branches leading to EUCLEAN
Date: Wed, 17 Sep 2025 19:53:54 +0200
Message-ID: <b4c1c57f4551c9dcf0c8a7dcbf29ad389c3133c1.1758130856.git.dsterba@suse.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1758130856.git.dsterba@suse.com>
References: <cover.1758130856.git.dsterba@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spam-Level: 
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: 7F99921EFF
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -4.00

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/backref.c     | 20 ++++++++++----------
 fs/btrfs/block-group.c | 14 +++++++-------
 fs/btrfs/ctree.c       | 10 +++++-----
 fs/btrfs/dev-replace.c |  4 ++--
 fs/btrfs/disk-io.c     | 24 ++++++++++++------------
 fs/btrfs/export.c      |  2 +-
 fs/btrfs/extent-tree.c | 26 +++++++++++++-------------
 fs/btrfs/inode.c       | 10 +++++-----
 fs/btrfs/ioctl.c       |  6 +++---
 fs/btrfs/lzo.c         |  6 +++---
 fs/btrfs/qgroup.c      | 14 +++++++-------
 fs/btrfs/relocation.c  |  8 ++++----
 fs/btrfs/root-tree.c   |  6 +++---
 fs/btrfs/scrub.c       |  4 ++--
 fs/btrfs/send.c        |  2 +-
 fs/btrfs/super.c       |  6 +++---
 fs/btrfs/verity.c      |  4 ++--
 fs/btrfs/volumes.c     | 30 +++++++++++++++---------------
 fs/btrfs/zoned.c       | 14 +++++++-------
 19 files changed, 105 insertions(+), 105 deletions(-)

diff --git a/fs/btrfs/backref.c b/fs/btrfs/backref.c
index c6573e845e43f6..650083e0f1cb8b 100644
--- a/fs/btrfs/backref.c
+++ b/fs/btrfs/backref.c
@@ -1062,7 +1062,7 @@ static int add_inline_refs(struct btrfs_backref_walk_ctx *ctx,
 		iref = (struct btrfs_extent_inline_ref *)ptr;
 		type = btrfs_get_extent_inline_ref_type(leaf, iref,
 							BTRFS_REF_TYPE_ANY);
-		if (type == BTRFS_REF_TYPE_INVALID)
+		if (unlikely(type == BTRFS_REF_TYPE_INVALID))
 			return -EUCLEAN;
 
 		offset = btrfs_extent_inline_ref_offset(leaf, iref);
@@ -1422,7 +1422,7 @@ static int find_parent_nodes(struct btrfs_backref_walk_ctx *ctx,
 	ret = btrfs_search_slot(NULL, root, &key, path, 0, 0);
 	if (ret < 0)
 		goto out;
-	if (ret == 0) {
+	if (unlikely(ret == 0)) {
 		/*
 		 * Key with offset -1 found, there would have to exist an extent
 		 * item with such offset, but this is out of the valid range.
@@ -1652,7 +1652,7 @@ static int find_parent_nodes(struct btrfs_backref_walk_ctx *ctx,
 				 * case.
 				 */
 				ASSERT(eie);
-				if (!eie) {
+				if (unlikely(!eie)) {
 					ret = -EUCLEAN;
 					goto out;
 				}
@@ -2215,7 +2215,7 @@ int extent_from_logical(struct btrfs_fs_info *fs_info, u64 logical,
 	ret = btrfs_search_slot(NULL, extent_root, &key, path, 0, 0);
 	if (ret < 0)
 		return ret;
-	if (ret == 0) {
+	if (unlikely(ret == 0)) {
 		/*
 		 * Key with offset -1 found, there would have to exist an extent
 		 * item with such offset, but this is out of the valid range.
@@ -2312,7 +2312,7 @@ static int get_extent_inline_ref(unsigned long *ptr,
 	*out_eiref = (struct btrfs_extent_inline_ref *)(*ptr);
 	*out_type = btrfs_get_extent_inline_ref_type(eb, *out_eiref,
 						     BTRFS_REF_TYPE_ANY);
-	if (*out_type == BTRFS_REF_TYPE_INVALID)
+	if (unlikely(*out_type == BTRFS_REF_TYPE_INVALID))
 		return -EUCLEAN;
 
 	*ptr += btrfs_extent_inline_ref_size(*out_type);
@@ -2868,7 +2868,7 @@ int btrfs_backref_iter_start(struct btrfs_backref_iter *iter, u64 bytenr)
 	ret = btrfs_search_slot(NULL, extent_root, &key, path, 0, 0);
 	if (ret < 0)
 		return ret;
-	if (ret == 0) {
+	if (unlikely(ret == 0)) {
 		/*
 		 * Key with offset -1 found, there would have to exist an extent
 		 * item with such offset, but this is out of the valid range.
@@ -2876,7 +2876,7 @@ int btrfs_backref_iter_start(struct btrfs_backref_iter *iter, u64 bytenr)
 		ret = -EUCLEAN;
 		goto release;
 	}
-	if (path->slots[0] == 0) {
+	if (unlikely(path->slots[0] == 0)) {
 		DEBUG_WARN();
 		ret = -EUCLEAN;
 		goto release;
@@ -3457,7 +3457,7 @@ int btrfs_backref_add_tree_node(struct btrfs_trans_handle *trans,
 		if (ret < 0)
 			goto out;
 		/* No extra backref? This means the tree block is corrupted */
-		if (ret > 0) {
+		if (unlikely(ret > 0)) {
 			ret = -EUCLEAN;
 			goto out;
 		}
@@ -3500,7 +3500,7 @@ int btrfs_backref_add_tree_node(struct btrfs_trans_handle *trans,
 				((unsigned long)iter->cur_ptr);
 			type = btrfs_get_extent_inline_ref_type(eb, iref,
 							BTRFS_REF_TYPE_BLOCK);
-			if (type == BTRFS_REF_TYPE_INVALID) {
+			if (unlikely(type == BTRFS_REF_TYPE_INVALID)) {
 				ret = -EUCLEAN;
 				goto out;
 			}
@@ -3612,7 +3612,7 @@ int btrfs_backref_finish_upper_links(struct btrfs_backref_cache *cache,
 		}
 
 		/* Sanity check, we shouldn't have any unchecked nodes */
-		if (!upper->checked) {
+		if (unlikely(!upper->checked)) {
 			DEBUG_WARN("we should not have any unchecked nodes");
 			return -EUCLEAN;
 		}
diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 548483a84466b6..6f7974060a1ab5 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -2071,7 +2071,7 @@ static int read_bg_from_eb(struct btrfs_fs_info *fs_info, const struct btrfs_key
 		return -ENOENT;
 	}
 
-	if (map->start != key->objectid || map->chunk_len != key->offset) {
+	if (unlikely(map->start != key->objectid || map->chunk_len != key->offset)) {
 		btrfs_err(fs_info,
 			"block group %llu len %llu mismatch with chunk %llu len %llu",
 			  key->objectid, key->offset, map->start, map->chunk_len);
@@ -2084,7 +2084,7 @@ static int read_bg_from_eb(struct btrfs_fs_info *fs_info, const struct btrfs_key
 	flags = btrfs_stack_block_group_flags(&bg) &
 		BTRFS_BLOCK_GROUP_TYPE_MASK;
 
-	if (flags != (map->type & BTRFS_BLOCK_GROUP_TYPE_MASK)) {
+	if (unlikely(flags != (map->type & BTRFS_BLOCK_GROUP_TYPE_MASK))) {
 		btrfs_err(fs_info,
 "block group %llu len %llu type flags 0x%llx mismatch with chunk type flags 0x%llx",
 			  key->objectid, key->offset, flags,
@@ -2245,7 +2245,7 @@ static int exclude_super_stripes(struct btrfs_block_group *cache)
 			return ret;
 
 		/* Shouldn't have super stripes in sequential zones */
-		if (zoned && nr) {
+		if (unlikely(zoned && nr)) {
 			kfree(logical);
 			btrfs_err(fs_info,
 			"zoned: block group %llu must not contain super block",
@@ -2336,7 +2336,7 @@ static int check_chunk_block_group_mappings(struct btrfs_fs_info *fs_info)
 			break;
 
 		bg = btrfs_lookup_block_group(fs_info, map->start);
-		if (!bg) {
+		if (unlikely(!bg)) {
 			btrfs_err(fs_info,
 	"chunk start=%llu len=%llu doesn't have corresponding block group",
 				     map->start, map->chunk_len);
@@ -2344,9 +2344,9 @@ static int check_chunk_block_group_mappings(struct btrfs_fs_info *fs_info)
 			btrfs_free_chunk_map(map);
 			break;
 		}
-		if (bg->start != map->start || bg->length != map->chunk_len ||
-		    (bg->flags & BTRFS_BLOCK_GROUP_TYPE_MASK) !=
-		    (map->type & BTRFS_BLOCK_GROUP_TYPE_MASK)) {
+		if (unlikely(bg->start != map->start || bg->length != map->chunk_len ||
+			     (bg->flags & BTRFS_BLOCK_GROUP_TYPE_MASK) !=
+			     (map->type & BTRFS_BLOCK_GROUP_TYPE_MASK))) {
 			btrfs_err(fs_info,
 "chunk start=%llu len=%llu flags=0x%llx doesn't match block group start=%llu len=%llu flags=0x%llx",
 				map->start, map->chunk_len,
diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index 6f9465d4ce54ce..1b6c3c0273f5dd 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -1490,7 +1490,7 @@ read_block_for_search(struct btrfs_root *root, struct btrfs_path *p,
 			 * being cached, read from scrub, or have multiple
 			 * parents (shared tree blocks).
 			 */
-			if (btrfs_verify_level_key(tmp, &check)) {
+			if (unlikely(btrfs_verify_level_key(tmp, &check))) {
 				ret = -EUCLEAN;
 				goto out;
 			}
@@ -2722,7 +2722,7 @@ static int push_node_left(struct btrfs_trans_handle *trans,
 		push_items = min(src_nritems - 8, push_items);
 
 	/* dst is the left eb, src is the middle eb */
-	if (check_sibling_keys(dst, src)) {
+	if (unlikely(check_sibling_keys(dst, src))) {
 		ret = -EUCLEAN;
 		btrfs_abort_transaction(trans, ret);
 		return ret;
@@ -2796,7 +2796,7 @@ static int balance_node_right(struct btrfs_trans_handle *trans,
 		push_items = max_push;
 
 	/* dst is the right eb, src is the middle eb */
-	if (check_sibling_keys(src, dst)) {
+	if (unlikely(check_sibling_keys(src, dst))) {
 		ret = -EUCLEAN;
 		btrfs_abort_transaction(trans, ret);
 		return ret;
@@ -3278,7 +3278,7 @@ static int push_leaf_right(struct btrfs_trans_handle *trans, struct btrfs_root
 	if (left_nritems == 0)
 		goto out_unlock;
 
-	if (check_sibling_keys(left, right)) {
+	if (unlikely(check_sibling_keys(left, right))) {
 		ret = -EUCLEAN;
 		btrfs_abort_transaction(trans, ret);
 		btrfs_tree_unlock(right);
@@ -3494,7 +3494,7 @@ static int push_leaf_left(struct btrfs_trans_handle *trans, struct btrfs_root
 		goto out;
 	}
 
-	if (check_sibling_keys(left, right)) {
+	if (unlikely(check_sibling_keys(left, right))) {
 		ret = -EUCLEAN;
 		btrfs_abort_transaction(trans, ret);
 		goto out;
diff --git a/fs/btrfs/dev-replace.c b/fs/btrfs/dev-replace.c
index ed3b07fdaab87b..b37e9a893b918a 100644
--- a/fs/btrfs/dev-replace.c
+++ b/fs/btrfs/dev-replace.c
@@ -98,7 +98,7 @@ int btrfs_init_dev_replace(struct btrfs_fs_info *fs_info)
 		 * We don't have a replace item or it's corrupted.  If there is
 		 * a replace target, fail the mount.
 		 */
-		if (btrfs_find_device(fs_info->fs_devices, &args)) {
+		if (unlikely(btrfs_find_device(fs_info->fs_devices, &args))) {
 			btrfs_err(fs_info,
 			"found replace target device without a valid replace item");
 			return -EUCLEAN;
@@ -158,7 +158,7 @@ int btrfs_init_dev_replace(struct btrfs_fs_info *fs_info)
 		 * We don't have an active replace item but if there is a
 		 * replace target, fail the mount.
 		 */
-		if (btrfs_find_device(fs_info->fs_devices, &args)) {
+		if (unlikely(btrfs_find_device(fs_info->fs_devices, &args))) {
 			btrfs_err(fs_info,
 "replace without active item, run 'device scan --forget' on the target device");
 			ret = -EUCLEAN;
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index a9e82e062bd588..5c4996a5269832 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -404,7 +404,7 @@ int btrfs_validate_extent_buffer(struct extent_buffer *eb,
 			      CSUM_FMT_VALUE(csum_size, result),
 			      btrfs_header_level(eb),
 			      ignore_csum ? ", ignored" : "");
-		if (!ignore_csum) {
+		if (unlikely(!ignore_csum)) {
 			ret = -EUCLEAN;
 			goto out;
 		}
@@ -1056,10 +1056,10 @@ static struct btrfs_root *read_tree_root_path(struct btrfs_root *tree_root,
 	 * For real fs, and not log/reloc trees, root owner must
 	 * match its root node owner
 	 */
-	if (!btrfs_is_testing(fs_info) &&
-	    btrfs_root_id(root) != BTRFS_TREE_LOG_OBJECTID &&
-	    btrfs_root_id(root) != BTRFS_TREE_RELOC_OBJECTID &&
-	    btrfs_root_id(root) != btrfs_header_owner(root->node)) {
+	if (unlikely(!btrfs_is_testing(fs_info) &&
+		     btrfs_root_id(root) != BTRFS_TREE_LOG_OBJECTID &&
+		     btrfs_root_id(root) != BTRFS_TREE_RELOC_OBJECTID &&
+		     btrfs_root_id(root) != btrfs_header_owner(root->node))) {
 		btrfs_crit(fs_info,
 "root=%llu block=%llu, tree root owner mismatch, have %llu expect %llu",
 			   btrfs_root_id(root), root->node->start,
@@ -2325,7 +2325,7 @@ static int validate_sys_chunk_array(const struct btrfs_fs_info *fs_info,
 	const u32 sectorsize = btrfs_super_sectorsize(sb);
 	u32 sys_array_size = btrfs_super_sys_array_size(sb);
 
-	if (sys_array_size > BTRFS_SYSTEM_CHUNK_ARRAY_SIZE) {
+	if (unlikely(sys_array_size > BTRFS_SYSTEM_CHUNK_ARRAY_SIZE)) {
 		btrfs_err(fs_info, "system chunk array too big %u > %u",
 			  sys_array_size, BTRFS_SYSTEM_CHUNK_ARRAY_SIZE);
 		return -EUCLEAN;
@@ -2348,7 +2348,7 @@ static int validate_sys_chunk_array(const struct btrfs_fs_info *fs_info,
 		cur += len;
 
 		btrfs_disk_key_to_cpu(&key, disk_key);
-		if (key.type != BTRFS_CHUNK_ITEM_KEY) {
+		if (unlikely(key.type != BTRFS_CHUNK_ITEM_KEY)) {
 			btrfs_err(fs_info,
 			    "unexpected item type %u in sys_array at offset %u",
 				  key.type, cur);
@@ -2359,7 +2359,7 @@ static int validate_sys_chunk_array(const struct btrfs_fs_info *fs_info,
 		if (cur + btrfs_chunk_item_size(num_stripes) > sys_array_size)
 			goto short_read;
 		type = btrfs_stack_chunk_type(chunk);
-		if (!(type & BTRFS_BLOCK_GROUP_SYSTEM)) {
+		if (unlikely(!(type & BTRFS_BLOCK_GROUP_SYSTEM))) {
 			btrfs_err(fs_info,
 			"invalid chunk type %llu in sys_array at offset %u",
 				  type, cur);
@@ -2606,13 +2606,13 @@ static int btrfs_validate_write_super(struct btrfs_fs_info *fs_info,
 	ret = btrfs_validate_super(fs_info, sb, -1);
 	if (ret < 0)
 		goto out;
-	if (!btrfs_supported_super_csum(btrfs_super_csum_type(sb))) {
+	if (unlikely(!btrfs_supported_super_csum(btrfs_super_csum_type(sb)))) {
 		ret = -EUCLEAN;
 		btrfs_err(fs_info, "invalid csum type, has %u want %u",
 			  btrfs_super_csum_type(sb), BTRFS_CSUM_TYPE_CRC32);
 		goto out;
 	}
-	if (btrfs_super_incompat_flags(sb) & ~BTRFS_FEATURE_INCOMPAT_SUPP) {
+	if (unlikely(btrfs_super_incompat_flags(sb) & ~BTRFS_FEATURE_INCOMPAT_SUPP)) {
 		ret = -EUCLEAN;
 		btrfs_err(fs_info,
 		"invalid incompat flags, has 0x%llx valid mask 0x%llx",
@@ -4056,7 +4056,7 @@ int write_all_supers(struct btrfs_fs_info *fs_info, int max_mirrors)
 		btrfs_set_super_flags(sb, flags | BTRFS_HEADER_FLAG_WRITTEN);
 
 		ret = btrfs_validate_write_super(fs_info, sb);
-		if (ret < 0) {
+		if (unlikely(ret < 0)) {
 			mutex_unlock(&fs_info->fs_devices->device_list_mutex);
 			btrfs_handle_fs_error(fs_info, -EUCLEAN,
 				"unexpected superblock corruption detected");
@@ -4872,7 +4872,7 @@ int btrfs_init_root_free_objectid(struct btrfs_root *root)
 	ret = btrfs_search_slot(NULL, root, &search_key, path, 0, 0);
 	if (ret < 0)
 		return ret;
-	if (ret == 0) {
+	if (unlikely(ret == 0)) {
 		/*
 		 * Key with offset -1 found, there would have to exist a root
 		 * with such id, but this is out of valid range.
diff --git a/fs/btrfs/export.c b/fs/btrfs/export.c
index 7fc8a3200b4005..d062ac521051b8 100644
--- a/fs/btrfs/export.c
+++ b/fs/btrfs/export.c
@@ -174,7 +174,7 @@ struct dentry *btrfs_get_parent(struct dentry *child)
 	ret = btrfs_search_slot(NULL, root, &key, path, 0, 0);
 	if (ret < 0)
 		goto fail;
-	if (ret == 0) {
+	if (unlikely(ret == 0)) {
 		/*
 		 * Key with offset of -1 found, there would have to exist an
 		 * inode with such number or a root with such id.
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index a4416c451b250b..df3ac2fa600000 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -879,7 +879,7 @@ int lookup_inline_extent_backref(struct btrfs_trans_handle *trans,
 			ptr += btrfs_extent_inline_ref_size(type);
 			continue;
 		}
-		if (type == BTRFS_REF_TYPE_INVALID) {
+		if (unlikely(type == BTRFS_REF_TYPE_INVALID)) {
 			ret = -EUCLEAN;
 			goto out;
 		}
@@ -1210,7 +1210,7 @@ int insert_inline_extent_backref(struct btrfs_trans_handle *trans,
 		 * We're adding refs to a tree block we already own, this
 		 * should not happen at all.
 		 */
-		if (owner < BTRFS_FIRST_FREE_OBJECTID) {
+		if (unlikely(owner < BTRFS_FIRST_FREE_OBJECTID)) {
 			btrfs_print_leaf(path->nodes[0]);
 			btrfs_crit(trans->fs_info,
 "adding refs to an existing tree ref, bytenr %llu num_bytes %llu root_objectid %llu slot %u",
@@ -2355,7 +2355,7 @@ static noinline int check_committed_ref(struct btrfs_inode *inode,
 	ret = btrfs_search_slot(NULL, extent_root, &key, path, 0, 0);
 	if (ret < 0)
 		return ret;
-	if (ret == 0) {
+	if (unlikely(ret == 0)) {
 		/*
 		 * Key with offset -1 found, there would have to exist an extent
 		 * item with such offset, but this is out of the valid range.
@@ -2760,7 +2760,7 @@ static int unpin_extent_range(struct btrfs_fs_info *fs_info,
 				btrfs_put_block_group(cache);
 			total_unpinned = 0;
 			cache = btrfs_lookup_block_group(fs_info, start);
-			if (cache == NULL) {
+			if (unlikely(cache == NULL)) {
 				/* Logic error, something removed the block group. */
 				ret = -EUCLEAN;
 				goto out;
@@ -3162,7 +3162,7 @@ static int __btrfs_free_extent(struct btrfs_trans_handle *trans,
 		}
 
 		if (!found_extent) {
-			if (iref) {
+			if (unlikely(iref)) {
 				abort_and_dump(trans, path,
 "invalid iref slot %u, no EXTENT/METADATA_ITEM found but has inline extent ref",
 					   path->slots[0]);
@@ -3254,7 +3254,7 @@ static int __btrfs_free_extent(struct btrfs_trans_handle *trans,
 	    key.type == BTRFS_EXTENT_ITEM_KEY) {
 		struct btrfs_tree_block_info *bi;
 
-		if (item_size < sizeof(*ei) + sizeof(*bi)) {
+		if (unlikely(item_size < sizeof(*ei) + sizeof(*bi))) {
 			abort_and_dump(trans, path,
 "invalid extent item size for key (%llu, %u, %llu) slot %u owner %llu, has %u expect >= %zu",
 				       key.objectid, key.type, key.offset,
@@ -3268,7 +3268,7 @@ static int __btrfs_free_extent(struct btrfs_trans_handle *trans,
 	}
 
 	refs = btrfs_extent_refs(leaf, ei);
-	if (refs < refs_to_drop) {
+	if (unlikely(refs < refs_to_drop)) {
 		abort_and_dump(trans, path,
 		"trying to drop %d refs but we only have %llu for bytenr %llu slot %u",
 			       refs_to_drop, refs, bytenr, path->slots[0]);
@@ -3285,7 +3285,7 @@ static int __btrfs_free_extent(struct btrfs_trans_handle *trans,
 		 * be updated by remove_extent_backref
 		 */
 		if (iref) {
-			if (!found_extent) {
+			if (unlikely(!found_extent)) {
 				abort_and_dump(trans, path,
 "invalid iref, got inlined extent ref but no EXTENT/METADATA_ITEM found, slot %u",
 					       path->slots[0]);
@@ -3314,8 +3314,8 @@ static int __btrfs_free_extent(struct btrfs_trans_handle *trans,
 
 		/* In this branch refs == 1 */
 		if (found_extent) {
-			if (is_data && refs_to_drop !=
-			    extent_data_ref_count(path, iref)) {
+			if (unlikely(is_data && refs_to_drop !=
+				     extent_data_ref_count(path, iref))) {
 				abort_and_dump(trans, path,
 		"invalid refs_to_drop, current refs %u refs_to_drop %u slot %u",
 					       extent_data_ref_count(path, iref),
@@ -3324,7 +3324,7 @@ static int __btrfs_free_extent(struct btrfs_trans_handle *trans,
 				goto out;
 			}
 			if (iref) {
-				if (path->slots[0] != extent_slot) {
+				if (unlikely(path->slots[0] != extent_slot)) {
 					abort_and_dump(trans, path,
 "invalid iref, extent item key (%llu %u %llu) slot %u doesn't have wanted iref",
 						       key.objectid, key.type,
@@ -3339,7 +3339,7 @@ static int __btrfs_free_extent(struct btrfs_trans_handle *trans,
 				 * |	extent_slot	  ||extent_slot + 1|
 				 * [ EXTENT/METADATA_ITEM ][ SHARED_* ITEM ]
 				 */
-				if (path->slots[0] != extent_slot + 1) {
+				if (unlikely(path->slots[0] != extent_slot + 1)) {
 					abort_and_dump(trans, path,
 	"invalid SHARED_* item slot %u, previous item is not EXTENT/METADATA_ITEM",
 						       path->slots[0]);
@@ -5063,7 +5063,7 @@ btrfs_init_new_buffer(struct btrfs_trans_handle *trans, struct btrfs_root *root,
 	if (IS_ERR(buf))
 		return buf;
 
-	if (check_eb_lock_owner(buf)) {
+	if (unlikely(check_eb_lock_owner(buf))) {
 		free_extent_buffer(buf);
 		return ERR_PTR(-EUCLEAN);
 	}
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 5fad6af5794466..6e7cf240d8ae9b 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -4549,7 +4549,7 @@ static noinline int may_destroy_subvol(struct btrfs_root *root)
 	ret = btrfs_search_slot(NULL, fs_info->tree_root, &key, path, 0, 0);
 	if (ret < 0)
 		return ret;
-	if (ret == 0) {
+	if (unlikely(ret == 0)) {
 		/*
 		 * Key with offset -1 found, there would have to exist a root
 		 * with such id, but this is out of valid range.
@@ -5624,8 +5624,8 @@ static int btrfs_inode_by_name(struct btrfs_inode *dir, struct dentry *dentry,
 	}
 
 	btrfs_dir_item_key_to_cpu(path->nodes[0], di, location);
-	if (location->type != BTRFS_INODE_ITEM_KEY &&
-	    location->type != BTRFS_ROOT_ITEM_KEY) {
+	if (unlikely(location->type != BTRFS_INODE_ITEM_KEY &&
+		     location->type != BTRFS_ROOT_ITEM_KEY)) {
 		ret = -EUCLEAN;
 		btrfs_warn(root->fs_info,
 "%s gets something invalid in DIR_ITEM (name %s, directory ino %llu, location(%llu %u %llu))",
@@ -5916,7 +5916,7 @@ struct inode *btrfs_lookup_dentry(struct inode *dir, struct dentry *dentry)
 			return ERR_CAST(inode);
 
 		/* Do extra check against inode mode with di_type */
-		if (btrfs_inode_type(inode) != di_type) {
+		if (unlikely(btrfs_inode_type(inode) != di_type)) {
 			btrfs_crit(fs_info,
 "inode mode mismatch with dir: inode mode=0%o btrfs type=%u dir type=%u",
 				  inode->vfs_inode.i_mode, btrfs_inode_type(inode),
@@ -7100,7 +7100,7 @@ struct extent_map *btrfs_get_extent(struct btrfs_inode *inode,
 	if (extent_type == BTRFS_FILE_EXTENT_REG ||
 	    extent_type == BTRFS_FILE_EXTENT_PREALLOC) {
 		/* Only regular file could have regular/prealloc extent */
-		if (!S_ISREG(inode->vfs_inode.i_mode)) {
+		if (unlikely(!S_ISREG(inode->vfs_inode.i_mode))) {
 			ret = -EUCLEAN;
 			btrfs_crit(fs_info,
 		"regular/prealloc extent found for non-regular inode %llu",
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 063291519b363b..93d35eb428a697 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -2133,7 +2133,7 @@ static int btrfs_ioctl_get_subvol_info(struct inode *inode, void __user *argp)
 			ret = btrfs_next_leaf(fs_info->tree_root, path);
 			if (ret < 0) {
 				goto out;
-			} else if (ret > 0) {
+			} else if (unlikely(ret > 0)) {
 				ret = -EUCLEAN;
 				goto out;
 			}
@@ -2216,7 +2216,7 @@ static int btrfs_ioctl_get_subvol_rootref(struct btrfs_root *root,
 		ret = btrfs_next_leaf(root, path);
 		if (ret < 0) {
 			goto out;
-		} else if (ret > 0) {
+		} else if (unlikely(ret > 0)) {
 			ret = -EUCLEAN;
 			goto out;
 		}
@@ -2245,7 +2245,7 @@ static int btrfs_ioctl_get_subvol_rootref(struct btrfs_root *root,
 		ret = btrfs_next_item(root, path);
 		if (ret < 0) {
 			goto out;
-		} else if (ret > 0) {
+		} else if (unlikely(ret > 0)) {
 			ret = -EUCLEAN;
 			goto out;
 		}
diff --git a/fs/btrfs/lzo.c b/fs/btrfs/lzo.c
index 047d90e216f6ae..4f013915c2c1e9 100644
--- a/fs/btrfs/lzo.c
+++ b/fs/btrfs/lzo.c
@@ -453,16 +453,16 @@ int lzo_decompress(struct list_head *ws, const u8 *data_in,
 	size_t max_segment_len = workspace_buf_length(fs_info);
 	int ret = 0;
 
-	if (srclen < LZO_LEN || srclen > max_segment_len + LZO_LEN * 2)
+	if (unlikely(srclen < LZO_LEN || srclen > max_segment_len + LZO_LEN * 2))
 		return -EUCLEAN;
 
 	in_len = read_compress_length(data_in);
-	if (in_len != srclen)
+	if (unlikely(in_len != srclen))
 		return -EUCLEAN;
 	data_in += LZO_LEN;
 
 	in_len = read_compress_length(data_in);
-	if (in_len != srclen - LZO_LEN * 2) {
+	if (unlikely(in_len != srclen - LZO_LEN * 2)) {
 		ret = -EUCLEAN;
 		goto out;
 	}
diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index 2d8667cc609a2b..8154393449b841 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -2426,9 +2426,9 @@ static int qgroup_trace_new_subtree_blocks(struct btrfs_trans_handle* trans,
 	int i;
 
 	/* Level sanity check */
-	if (cur_level < 0 || cur_level >= BTRFS_MAX_LEVEL - 1 ||
-	    root_level < 0 || root_level >= BTRFS_MAX_LEVEL - 1 ||
-	    root_level < cur_level) {
+	if (unlikely(cur_level < 0 || cur_level >= BTRFS_MAX_LEVEL - 1 ||
+		     root_level < 0 || root_level >= BTRFS_MAX_LEVEL - 1 ||
+		     root_level < cur_level)) {
 		btrfs_err_rl(fs_info,
 			"%s: bad levels, cur_level=%d root_level=%d",
 			__func__, cur_level, root_level);
@@ -2444,7 +2444,7 @@ static int qgroup_trace_new_subtree_blocks(struct btrfs_trans_handle* trans,
 		 * dst_path->nodes[root_level] must be initialized before
 		 * calling this function.
 		 */
-		if (cur_level == root_level) {
+		if (unlikely(cur_level == root_level)) {
 			btrfs_err_rl(fs_info,
 	"%s: dst_path->nodes[%d] not initialized, root_level=%d cur_level=%d",
 				__func__, root_level, root_level, cur_level);
@@ -2530,7 +2530,7 @@ static int qgroup_trace_subtree_swap(struct btrfs_trans_handle *trans,
 		return 0;
 
 	/* Wrong parameter order */
-	if (btrfs_header_generation(src_eb) > btrfs_header_generation(dst_eb)) {
+	if (unlikely(btrfs_header_generation(src_eb) > btrfs_header_generation(dst_eb))) {
 		btrfs_err_rl(fs_info,
 		"%s: bad parameter order, src_gen=%llu dst_gen=%llu", __func__,
 			     btrfs_header_generation(src_eb),
@@ -4710,8 +4710,8 @@ int btrfs_qgroup_add_swapped_blocks(struct btrfs_root *subvol_root,
 	if (!btrfs_qgroup_full_accounting(fs_info))
 		return 0;
 
-	if (btrfs_node_ptr_generation(subvol_parent, subvol_slot) >
-	    btrfs_node_ptr_generation(reloc_parent, reloc_slot)) {
+	if (unlikely(btrfs_node_ptr_generation(subvol_parent, subvol_slot) >
+		     btrfs_node_ptr_generation(reloc_parent, reloc_slot))) {
 		btrfs_err_rl(fs_info,
 		"%s: bad parameter order, subvol_gen=%llu reloc_gen=%llu",
 			__func__,
diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 8bd97b24f375fd..6c9ac749d7dc1c 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -1960,7 +1960,7 @@ static int record_reloc_root_in_trans(struct btrfs_trans_handle *trans,
 		DEBUG_WARN("error %ld reading root for reloc root", PTR_ERR(root));
 		return PTR_ERR(root);
 	}
-	if (root->reloc_root != reloc_root) {
+	if (unlikely(root->reloc_root != reloc_root)) {
 		DEBUG_WARN("unexpected reloc root found");
 		btrfs_err(fs_info,
 			  "root %llu has two reloc roots associated with it",
@@ -2031,7 +2031,7 @@ struct btrfs_root *select_reloc_root(struct btrfs_trans_handle *trans,
 	if (!root)
 		return ERR_PTR(-ENOENT);
 
-	if (next->new_bytenr) {
+	if (unlikely(next->new_bytenr)) {
 		/*
 		 * We just created the reloc root, so we shouldn't have
 		 * ->new_bytenr set yet. If it is then we have multiple roots
@@ -2090,7 +2090,7 @@ struct btrfs_root *select_one_root(struct btrfs_backref_node *node)
 		 * This can occur if we have incomplete extent refs leading all
 		 * the way up a particular path, in this case return -EUCLEAN.
 		 */
-		if (!root)
+		if (unlikely(!root))
 			return ERR_PTR(-EUCLEAN);
 
 		/* No other choice for non-shareable tree */
@@ -2519,7 +2519,7 @@ static int relocate_tree_block(struct btrfs_trans_handle *trans,
 			 * normal user in the case of corruption.
 			 */
 			ASSERT(node->new_bytenr == 0);
-			if (node->new_bytenr) {
+			if (unlikely(node->new_bytenr)) {
 				btrfs_err(root->fs_info,
 				  "bytenr %llu has improper references to it",
 					  node->bytenr);
diff --git a/fs/btrfs/root-tree.c b/fs/btrfs/root-tree.c
index e22e6b06927ab3..62b694667d4dba 100644
--- a/fs/btrfs/root-tree.c
+++ b/fs/btrfs/root-tree.c
@@ -85,7 +85,7 @@ int btrfs_find_root(struct btrfs_root *root, const struct btrfs_key *search_key,
 		 * Key with offset -1 found, there would have to exist a root
 		 * with such id, but this is out of the valid range.
 		 */
-		if (ret == 0) {
+		if (unlikely(ret == 0)) {
 			ret = -EUCLEAN;
 			goto out;
 		}
@@ -145,7 +145,7 @@ int btrfs_update_root(struct btrfs_trans_handle *trans, struct btrfs_root
 	if (ret < 0)
 		goto out;
 
-	if (ret > 0) {
+	if (unlikely(ret > 0)) {
 		btrfs_crit(fs_info,
 			"unable to find root key (%llu %u %llu) in tree %llu",
 			key->objectid, key->type, key->offset, btrfs_root_id(root));
@@ -327,7 +327,7 @@ int btrfs_del_root(struct btrfs_trans_handle *trans,
 	ret = btrfs_search_slot(trans, root, key, path, -1, 1);
 	if (ret < 0)
 		goto out;
-	if (ret != 0) {
+	if (unlikely(ret != 0)) {
 		/* The root must exist but we did not find it by the key. */
 		ret = -EUCLEAN;
 		goto out;
diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index cef260ed854c15..1b0f57c68226b4 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -1526,7 +1526,7 @@ static int find_first_extent_item(struct btrfs_root *extent_root,
 	ret = btrfs_search_slot(NULL, extent_root, &key, path, 0, 0);
 	if (ret < 0)
 		return ret;
-	if (ret == 0) {
+	if (unlikely(ret == 0)) {
 		/*
 		 * Key with offset -1 found, there would have to exist an extent
 		 * item with such offset, but this is out of the valid range.
@@ -2908,7 +2908,7 @@ static int scrub_one_super(struct scrub_ctx *sctx, struct btrfs_device *dev,
 			physical, dev->devid);
 		return -EIO;
 	}
-	if (btrfs_super_generation(sb) != generation) {
+	if (unlikely(btrfs_super_generation(sb) != generation)) {
 		btrfs_err_rl(fs_info,
 "scrub: super block at physical %llu devid %llu has bad generation %llu expect %llu",
 			     physical, dev->devid,
diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index 32653fc44a7583..a4b88f58f6b421 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -7302,7 +7302,7 @@ static int search_key_again(const struct send_ctx *sctx,
 	 */
 	ret = btrfs_search_slot(NULL, root, key, path, 0, 0);
 	ASSERT(ret <= 0);
-	if (ret > 0) {
+	if (unlikely(ret > 0)) {
 		btrfs_print_tree(path->nodes[path->lowest_level], false);
 		btrfs_err(root->fs_info,
 "send: key (%llu %u %llu) not found in %s root %llu, lowest_level %d, slot %d",
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 25df563abc6cbb..95fcd0e12b5666 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -2317,14 +2317,14 @@ static int check_dev_super(struct btrfs_device *dev)
 
 	/* Verify the checksum. */
 	csum_type = btrfs_super_csum_type(sb);
-	if (csum_type != btrfs_super_csum_type(fs_info->super_copy)) {
+	if (unlikely(csum_type != btrfs_super_csum_type(fs_info->super_copy))) {
 		btrfs_err(fs_info, "csum type changed, has %u expect %u",
 			  csum_type, btrfs_super_csum_type(fs_info->super_copy));
 		ret = -EUCLEAN;
 		goto out;
 	}
 
-	if (btrfs_check_super_csum(fs_info, sb)) {
+	if (unlikely(btrfs_check_super_csum(fs_info, sb))) {
 		btrfs_err(fs_info, "csum for on-disk super block no longer matches");
 		ret = -EUCLEAN;
 		goto out;
@@ -2336,7 +2336,7 @@ static int check_dev_super(struct btrfs_device *dev)
 		goto out;
 
 	last_trans = btrfs_get_last_trans_committed(fs_info);
-	if (btrfs_super_generation(sb) != last_trans) {
+	if (unlikely(btrfs_super_generation(sb) != last_trans)) {
 		btrfs_err(fs_info, "transid mismatch, has %llu expect %llu",
 			  btrfs_super_generation(sb), last_trans);
 		ret = -EUCLEAN;
diff --git a/fs/btrfs/verity.c b/fs/btrfs/verity.c
index b7a96a005487e1..0bd7ea2c58ec6a 100644
--- a/fs/btrfs/verity.c
+++ b/fs/btrfs/verity.c
@@ -676,11 +676,11 @@ int btrfs_get_verity_descriptor(struct inode *inode, void *buf, size_t buf_size)
 	if (ret < 0)
 		return ret;
 
-	if (item.reserved[0] != 0 || item.reserved[1] != 0)
+	if (unlikely(item.reserved[0] != 0 || item.reserved[1] != 0))
 		return -EUCLEAN;
 
 	true_size = btrfs_stack_verity_descriptor_size(&item);
-	if (true_size > INT_MAX)
+	if (unlikely(true_size > INT_MAX))
 		return -EUCLEAN;
 
 	if (buf_size == 0)
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 4f20c25a39c81d..897294519a99c0 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -1911,7 +1911,7 @@ static noinline int find_next_devid(struct btrfs_fs_info *fs_info,
 	if (ret < 0)
 		goto error;
 
-	if (ret == 0) {
+	if (unlikely(ret == 0)) {
 		/* Corruption */
 		btrfs_err(fs_info, "corrupted chunk tree devid -1 matched");
 		ret = -EUCLEAN;
@@ -3049,7 +3049,7 @@ static int btrfs_free_chunk(struct btrfs_trans_handle *trans, u64 chunk_offset)
 	ret = btrfs_search_slot(trans, root, &key, path, -1, 1);
 	if (ret < 0)
 		goto out;
-	else if (ret > 0) { /* Logic error or corruption */
+	else if (unlikely(ret > 0)) { /* Logic error or corruption */
 		btrfs_err(fs_info, "failed to lookup chunk %llu when freeing",
 			  chunk_offset);
 		btrfs_abort_transaction(trans, -ENOENT);
@@ -3527,7 +3527,7 @@ static int btrfs_relocate_sys_chunks(struct btrfs_fs_info *fs_info)
 			mutex_unlock(&fs_info->reclaim_bgs_lock);
 			goto error;
 		}
-		if (ret == 0) {
+		if (unlikely(ret == 0)) {
 			/*
 			 * On the first search we would find chunk tree with
 			 * offset -1, which is not possible. On subsequent
@@ -7932,7 +7932,7 @@ static int verify_one_dev_extent(struct btrfs_fs_info *fs_info,
 	int i;
 
 	map = btrfs_find_chunk_map(fs_info, chunk_offset, 1);
-	if (!map) {
+	if (unlikely(!map)) {
 		btrfs_err(fs_info,
 "dev extent physical offset %llu on devid %llu doesn't have corresponding chunk",
 			  physical_offset, devid);
@@ -7941,7 +7941,7 @@ static int verify_one_dev_extent(struct btrfs_fs_info *fs_info,
 	}
 
 	stripe_len = btrfs_calc_stripe_length(map);
-	if (physical_len != stripe_len) {
+	if (unlikely(physical_len != stripe_len)) {
 		btrfs_err(fs_info,
 "dev extent physical offset %llu on devid %llu length doesn't match chunk %llu, have %llu expect %llu",
 			  physical_offset, devid, map->start, physical_len,
@@ -7961,8 +7961,8 @@ static int verify_one_dev_extent(struct btrfs_fs_info *fs_info,
 			   devid, physical_offset, physical_len);
 
 	for (i = 0; i < map->num_stripes; i++) {
-		if (map->stripes[i].dev->devid == devid &&
-		    map->stripes[i].physical == physical_offset) {
+		if (unlikely(map->stripes[i].dev->devid == devid &&
+			     map->stripes[i].physical == physical_offset)) {
 			found = true;
 			if (map->verified_stripes >= map->num_stripes) {
 				btrfs_err(fs_info,
@@ -7975,7 +7975,7 @@ static int verify_one_dev_extent(struct btrfs_fs_info *fs_info,
 			break;
 		}
 	}
-	if (!found) {
+	if (unlikely(!found)) {
 		btrfs_err(fs_info,
 	"dev extent physical offset %llu devid %llu has no corresponding chunk",
 			physical_offset, devid);
@@ -7984,13 +7984,13 @@ static int verify_one_dev_extent(struct btrfs_fs_info *fs_info,
 
 	/* Make sure no dev extent is beyond device boundary */
 	dev = btrfs_find_device(fs_info->fs_devices, &args);
-	if (!dev) {
+	if (unlikely(!dev)) {
 		btrfs_err(fs_info, "failed to find devid %llu", devid);
 		ret = -EUCLEAN;
 		goto out;
 	}
 
-	if (physical_offset + physical_len > dev->disk_total_bytes) {
+	if (unlikely(physical_offset + physical_len > dev->disk_total_bytes)) {
 		btrfs_err(fs_info,
 "dev extent devid %llu physical offset %llu len %llu is beyond device boundary %llu",
 			  devid, physical_offset, physical_len,
@@ -8002,8 +8002,8 @@ static int verify_one_dev_extent(struct btrfs_fs_info *fs_info,
 	if (dev->zone_info) {
 		u64 zone_size = dev->zone_info->zone_size;
 
-		if (!IS_ALIGNED(physical_offset, zone_size) ||
-		    !IS_ALIGNED(physical_len, zone_size)) {
+		if (unlikely(!IS_ALIGNED(physical_offset, zone_size) ||
+			     !IS_ALIGNED(physical_len, zone_size))) {
 			btrfs_err(fs_info,
 "zoned: dev extent devid %llu physical offset %llu len %llu is not aligned to device zone",
 				  devid, physical_offset, physical_len);
@@ -8027,7 +8027,7 @@ static int verify_chunk_dev_extent_mapping(struct btrfs_fs_info *fs_info)
 		struct btrfs_chunk_map *map;
 
 		map = rb_entry(node, struct btrfs_chunk_map, rb_node);
-		if (map->num_stripes != map->verified_stripes) {
+		if (unlikely(map->num_stripes != map->verified_stripes)) {
 			btrfs_err(fs_info,
 			"chunk %llu has missing dev extent, have %d expect %d",
 				  map->start, map->verified_stripes, map->num_stripes);
@@ -8087,7 +8087,7 @@ int btrfs_verify_dev_extents(struct btrfs_fs_info *fs_info)
 		if (ret < 0)
 			goto out;
 		/* No dev extents at all? Not good */
-		if (ret > 0) {
+		if (unlikely(ret > 0)) {
 			ret = -EUCLEAN;
 			goto out;
 		}
@@ -8112,7 +8112,7 @@ int btrfs_verify_dev_extents(struct btrfs_fs_info *fs_info)
 		physical_len = btrfs_dev_extent_length(leaf, dext);
 
 		/* Check if this dev extent overlaps with the previous one */
-		if (devid == prev_devid && physical_offset < prev_dev_ext_end) {
+		if (unlikely(devid == prev_devid && physical_offset < prev_dev_ext_end)) {
 			btrfs_err(fs_info,
 "dev extent devid %llu physical offset %llu overlap with previous dev extent end %llu",
 				  devid, physical_offset, prev_dev_ext_end);
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index ba444e412613f2..746ddc76100301 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -315,7 +315,7 @@ static int calculate_emulated_zone_size(struct btrfs_fs_info *fs_info)
 		if (ret < 0)
 			return ret;
 		/* No dev extents at all? Not good */
-		if (ret > 0)
+		if (unlikely(ret > 0))
 			return -EUCLEAN;
 	}
 
@@ -544,7 +544,7 @@ int btrfs_get_dev_zone_info(struct btrfs_device *device, bool populate_cache)
 		if (ret)
 			goto out;
 
-		if (nr_zones != BTRFS_NR_SB_LOG_ZONES) {
+		if (unlikely(nr_zones != BTRFS_NR_SB_LOG_ZONES)) {
 			btrfs_err(device->fs_info,
 	"zoned: failed to read super block log zone info at devid %llu zone %u",
 					 device->devid, sb_zone);
@@ -562,7 +562,7 @@ int btrfs_get_dev_zone_info(struct btrfs_device *device, bool populate_cache)
 
 		ret = sb_write_pointer(device->bdev,
 				       &zone_info->sb_zones[sb_pos], &sb_wp);
-		if (ret != -ENOENT && ret) {
+		if (unlikely(ret != -ENOENT && ret)) {
 			btrfs_err(device->fs_info,
 			"zoned: super block log zone corrupted devid %llu zone %u",
 					 device->devid, sb_zone);
@@ -1247,7 +1247,7 @@ static int calculate_alloc_pointer(struct btrfs_block_group *cache,
 	root = btrfs_extent_root(fs_info, key.objectid);
 	ret = btrfs_search_slot(NULL, root, &key, path, 0, 0);
 	/* We should not find the exact match */
-	if (!ret)
+	if (unlikely(!ret))
 		ret = -EUCLEAN;
 	if (ret < 0)
 		return ret;
@@ -1268,8 +1268,8 @@ static int calculate_alloc_pointer(struct btrfs_block_group *cache,
 	else
 		length = fs_info->nodesize;
 
-	if (!(found_key.objectid >= cache->start &&
-	       found_key.objectid + length <= cache->start + cache->length)) {
+	if (unlikely(!(found_key.objectid >= cache->start &&
+		       found_key.objectid + length <= cache->start + cache->length))) {
 		return -EUCLEAN;
 	}
 	*offset_ret = found_key.objectid + length - cache->start;
@@ -2139,7 +2139,7 @@ int btrfs_sync_zone_write_pointer(struct btrfs_device *tgt_dev, u64 logical,
 	if (physical_pos == wp)
 		return 0;
 
-	if (physical_pos > wp)
+	if (unlikely(physical_pos > wp))
 		return -EUCLEAN;
 
 	length = wp - physical_pos;
-- 
2.51.0


