Return-Path: <linux-btrfs+bounces-16065-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22193B24C34
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Aug 2025 16:42:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A53556211C
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Aug 2025 14:38:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3557530748D;
	Wed, 13 Aug 2025 14:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=harmstone.com header.i=@harmstone.com header.b="Ks/GALdK"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail.burntcomma.com (mail2.burntcomma.com [217.169.27.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB81C302CB8
	for <linux-btrfs@vger.kernel.org>; Wed, 13 Aug 2025 14:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.169.27.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755095731; cv=none; b=kXQMSKmiFJq9ZzioLnek5Q88iaPQJUR9bl0odx2ELk9X462zzWwCLLG9HAvjfEe7HePEv5c3wxn+/8tjhlgqst4NjrR/o7E1yL5UfUd3YUo9k1gk7UU8FCI4hmRpag+4fafywjvtRfB/mGjB4e6j/AvYYz0nbiBibFR+5R3q/aE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755095731; c=relaxed/simple;
	bh=7S0+89rmkcLw8j1Milq2FOO3xGjrC20nJ5qZMYHI/vQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Mime-Version; b=eGGW7FQvFfbC0TBxBmWTMZiLf4RSGYAPpomQAEQWQwiTJsFsOuhH2PGxhomjO/WKeqIJaUvAEFGpy99+wb3pjg3pjvDhiEuDb1EBRIUyXZEalADRDTI+eL/5Pu1oPmFrnACLYNDqZuCIeNYM1tpAe5dcGMqqg64ZHR7i0PUxoXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=harmstone.com; spf=pass smtp.mailfrom=harmstone.com; dkim=pass (1024-bit key) header.d=harmstone.com header.i=@harmstone.com header.b=Ks/GALdK; arc=none smtp.client-ip=217.169.27.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=harmstone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=harmstone.com
Received: from localhost.localdomain (beren.burntcomma.com [IPv6:2a02:8012:8cf0:0:ce28:aaff:fe0d:6db2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.burntcomma.com (Postfix) with ESMTPSA id A0D252A759F;
	Wed, 13 Aug 2025 15:35:13 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=harmstone.com;
	s=mail; t=1755095713;
	bh=ovSdMWWLel8g4jy3qGqymYyuMc9kZSOgMyvkZJZn+v4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Ks/GALdKQiiniNR2i/PA6GFo8tEHDjXIa8FPnpAukMNCzYOMLV7ZLSYHYifNGy/k5
	 vPMbIRsetb9kouz3Bo5EJbifZA62ifbA8HqCRQ/zwSnUHmH7qMGMvQLJ+EsCQ+g7xF
	 y1cSzqcXCawi3yc6FWyFeAIsb5jWsfFf0BkBPkCQ=
From: Mark Harmstone <mark@harmstone.com>
To: linux-btrfs@vger.kernel.org
Cc: Mark Harmstone <mark@harmstone.com>
Subject: [PATCH v2 16/16] btrfs: allow balancing remap tree
Date: Wed, 13 Aug 2025 15:34:58 +0100
Message-ID: <20250813143509.31073-17-mark@harmstone.com>
In-Reply-To: <20250813143509.31073-1-mark@harmstone.com>
References: <20250813143509.31073-1-mark@harmstone.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit

Balancing the REMAP chunk, i.e. the chunk in which the remap tree lives,
is a special case.

We can't use the remap tree itself for this, as then we'd have no way to
boostrap it on mount. And we can't use the pre-remap tree code for this
as it relies on walking the extent tree, and we're not creating backrefs
for REMAP chunks.

So instead, if a balance would relocate any REMAP block groups, mark
those block groups as readonly and COW every leaf of the remap tree.

There's more sophisticated ways of doing this, such as only COWing nodes
within a block group that's to be relocated, but they're fiddly and with
lots of edge cases. Plus it's not anticipated that a) the number of
REMAP chunks is going to be particularly large, or b) that users will
want to only relocate some of these chunks - the main use case here is
to unbreak RAID conversion and device removal.

Signed-off-by: Mark Harmstone <mark@harmstone.com>
---
 fs/btrfs/volumes.c | 161 +++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 157 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index e13f16a7a904..dc535ed90ae0 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -4011,8 +4011,11 @@ static bool should_balance_chunk(struct extent_buffer *leaf, struct btrfs_chunk
 	struct btrfs_balance_args *bargs = NULL;
 	u64 chunk_type = btrfs_chunk_type(leaf, chunk);
 
-	if (chunk_type & BTRFS_BLOCK_GROUP_REMAP)
-		return false;
+	/* treat REMAP chunks as METADATA */
+	if (chunk_type & BTRFS_BLOCK_GROUP_REMAP) {
+		chunk_type &= ~BTRFS_BLOCK_GROUP_REMAP;
+		chunk_type |= BTRFS_BLOCK_GROUP_METADATA;
+	}
 
 	/* type filter */
 	if (!((chunk_type & BTRFS_BLOCK_GROUP_TYPE_MASK) &
@@ -4095,6 +4098,113 @@ static bool should_balance_chunk(struct extent_buffer *leaf, struct btrfs_chunk
 	return true;
 }
 
+struct remap_chunk_info {
+	struct list_head list;
+	u64 offset;
+	struct btrfs_block_group *bg;
+	bool made_ro;
+};
+
+static int cow_remap_tree(struct btrfs_trans_handle *trans,
+			  struct btrfs_path *path)
+{
+	struct btrfs_fs_info *fs_info = trans->fs_info;
+	struct btrfs_key key = { 0 };
+	int ret;
+
+	ret = btrfs_search_slot(trans, fs_info->remap_root, &key, path, 0, 1);
+	if (ret < 0)
+		return ret;
+
+	while (true) {
+		ret = btrfs_next_leaf(fs_info->remap_root, path);
+		if (ret < 0) {
+			return ret;
+		} else if (ret > 0) {
+			ret = 0;
+			break;
+		}
+
+		btrfs_item_key_to_cpu(path->nodes[0], &key, path->slots[0]);
+
+		btrfs_release_path(path);
+
+		ret = btrfs_search_slot(trans, fs_info->remap_root, &key, path,
+					0, 1);
+		if (ret < 0)
+			break;
+	}
+
+	return ret;
+}
+
+static int balance_remap_chunks(struct btrfs_fs_info *fs_info,
+				struct btrfs_path *path,
+				struct list_head *chunks)
+{
+	struct remap_chunk_info *rci, *tmp;
+	struct btrfs_trans_handle *trans;
+	int ret;
+
+	list_for_each_entry_safe(rci, tmp, chunks, list) {
+		rci->bg = btrfs_lookup_block_group(fs_info, rci->offset);
+		if (!rci->bg) {
+			list_del(&rci->list);
+			kfree(rci);
+			continue;
+		}
+
+		ret = btrfs_inc_block_group_ro(rci->bg, false);
+		if (ret)
+			goto end;
+
+		rci->made_ro = true;
+	}
+
+	if (list_empty(chunks))
+		return 0;
+
+	trans = btrfs_start_transaction(fs_info->remap_root, 0);
+	if (IS_ERR(trans)) {
+		ret = PTR_ERR(trans);
+		goto end;
+	}
+
+	mutex_lock(&fs_info->remap_mutex);
+
+	ret = cow_remap_tree(trans, path);
+
+	btrfs_release_path(path);
+
+	mutex_unlock(&fs_info->remap_mutex);
+
+	btrfs_commit_transaction(trans);
+
+end:
+	while (!list_empty(chunks)) {
+		bool unused;
+
+		rci = list_first_entry(chunks, struct remap_chunk_info, list);
+
+		spin_lock(&rci->bg->lock);
+		unused = !btrfs_is_block_group_used(rci->bg);
+		spin_unlock(&rci->bg->lock);
+
+		if (unused)
+			btrfs_mark_bg_unused(rci->bg);
+
+		if (rci->made_ro)
+			btrfs_dec_block_group_ro(rci->bg);
+
+		btrfs_put_block_group(rci->bg);
+
+		list_del(&rci->list);
+		kfree(rci);
+	}
+
+	return ret;
+}
+
 static int __btrfs_balance(struct btrfs_fs_info *fs_info)
 {
 	struct btrfs_balance_control *bctl = fs_info->balance_ctl;
@@ -4117,6 +4227,9 @@ static int __btrfs_balance(struct btrfs_fs_info *fs_info)
 	u32 count_meta = 0;
 	u32 count_sys = 0;
 	int chunk_reserved = 0;
+	struct remap_chunk_info *rci;
+	unsigned int num_remap_chunks = 0;
+	LIST_HEAD(remap_chunks);
 
 	path = btrfs_alloc_path();
 	if (!path) {
@@ -4215,7 +4328,8 @@ static int __btrfs_balance(struct btrfs_fs_info *fs_info)
 				count_data++;
 			else if (chunk_type & BTRFS_BLOCK_GROUP_SYSTEM)
 				count_sys++;
-			else if (chunk_type & BTRFS_BLOCK_GROUP_METADATA)
+			else if (chunk_type & (BTRFS_BLOCK_GROUP_METADATA |
+					       BTRFS_BLOCK_GROUP_REMAP))
 				count_meta++;
 
 			goto loop;
@@ -4235,6 +4349,30 @@ static int __btrfs_balance(struct btrfs_fs_info *fs_info)
 			goto loop;
 		}
 
+		/*
+		 * Balancing REMAP chunks takes place separately - add the
+		 * details to a list so it can be processed later.
+		 */
+		if (chunk_type & BTRFS_BLOCK_GROUP_REMAP) {
+			mutex_unlock(&fs_info->reclaim_bgs_lock);
+
+			rci = kmalloc(sizeof(struct remap_chunk_info),
+				      GFP_NOFS);
+			if (!rci) {
+				ret = -ENOMEM;
+				goto error;
+			}
+
+			rci->offset = found_key.offset;
+			rci->bg = NULL;
+			rci->made_ro = false;
+			list_add_tail(&rci->list, &remap_chunks);
+
+			num_remap_chunks++;
+
+			goto loop;
+		}
+
 		if (!chunk_reserved) {
 			/*
 			 * We may be relocating the only data chunk we have,
@@ -4274,11 +4412,26 @@ static int __btrfs_balance(struct btrfs_fs_info *fs_info)
 		key.offset = found_key.offset - 1;
 	}
 
+	btrfs_release_path(path);
+
 	if (counting) {
-		btrfs_release_path(path);
 		counting = false;
 		goto again;
 	}
+
+	if (!list_empty(&remap_chunks)) {
+		ret = balance_remap_chunks(fs_info, path, &remap_chunks);
+		if (ret == -ENOSPC)
+			enospc_errors++;
+
+		if (!ret) {
+			btrfs_delete_unused_bgs(fs_info);
+
+			spin_lock(&fs_info->balance_lock);
+			bctl->stat.completed += num_remap_chunks;
+			spin_unlock(&fs_info->balance_lock);
+		}
+	}
 error:
 	btrfs_free_path(path);
 	if (enospc_errors) {
-- 
2.49.1


