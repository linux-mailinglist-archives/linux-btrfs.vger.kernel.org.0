Return-Path: <linux-btrfs+bounces-20203-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 12524CFE300
	for <lists+linux-btrfs@lfdr.de>; Wed, 07 Jan 2026 15:11:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8489B30049EF
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Jan 2026 14:11:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75B4B331A5B;
	Wed,  7 Jan 2026 14:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=harmstone.com header.i=@harmstone.com header.b="OXC0WtHp"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail.burntcomma.com (mail2.burntcomma.com [217.169.27.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 894D632ED29
	for <linux-btrfs@vger.kernel.org>; Wed,  7 Jan 2026 14:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.169.27.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767795034; cv=none; b=YNeiH/rnvvphxnt5L1SuseH5QrlxRBoeq3Z703V6r7Ndyv3xbFnv6MPfcbmZI9HP8Dtoxp5/qeusEmgjGPcs8OVZtPONlykBG5pQ/TpNdZSjDsYWhTuEN7g3Qbl4JY/hAe5e8l5fsBwOapxVdon8rrlUrJvbw+n0uY1b8Prfp2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767795034; c=relaxed/simple;
	bh=gT/CinN3fVQjDtbD44rnLYlWcRHhGV8VEmT8eS66ipw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Mime-Version; b=pgMVhWpmRCLjJidPZh0G1SDf/IGS+GYKitSMr2FyJcutaoZ6nEtZpZ5In0yqD2jFeu2cdalPA70DXpcaNnpf0JLpQzBt2MeC5jj4pRpRJf9YUSFV+RAR5kZBG/yOuf888vrJGQLJ10OKYTvlh55vg1ebBZI5upzTt69xT6S62Z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=harmstone.com; spf=pass smtp.mailfrom=harmstone.com; dkim=pass (1024-bit key) header.d=harmstone.com header.i=@harmstone.com header.b=OXC0WtHp; arc=none smtp.client-ip=217.169.27.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=harmstone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=harmstone.com
Received: from beren (beren.burntcomma.com [IPv6:2a02:8012:8cf0:0:ce28:aaff:fe0d:6db2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.burntcomma.com (Postfix) with ESMTPSA id 4A49C2F186B;
	Wed,  7 Jan 2026 14:10:18 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=harmstone.com;
	s=mail; t=1767795018;
	bh=t16FBCCrk9dpPhAWZtgvTe+NBkjsQz0JfrvHTusg2NA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OXC0WtHpupXW6SDBU2pT5qd6USySHRmW1CVS0n9bXpBhpnvhof0wF67+OCMvB3JnR
	 3zsWifjorT9AXW4vX7UkSMk4muGCwvj2Hcf/+XQL1GfQCiuijzhcP4Tx+iI/GHk64Y
	 lgqSYKC1otyYg4h9y1BE8lfVXRbLcxFqMtcWmaNw=
From: Mark Harmstone <mark@harmstone.com>
To: linux-btrfs@vger.kernel.org
Cc: Mark Harmstone <mark@harmstone.com>,
	Boris Burkov <boris@bur.io>
Subject: [PATCH v8 05/17] btrfs: don't add metadata items for the remap tree to the extent tree
Date: Wed,  7 Jan 2026 14:09:05 +0000
Message-ID: <20260107141015.25819-6-mark@harmstone.com>
In-Reply-To: <20260107141015.25819-1-mark@harmstone.com>
References: <20260107141015.25819-1-mark@harmstone.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit

There is the following potential problem with the remap tree and delayed refs:

* Remapped extent freed in a delayed ref, which removes an entry from the
  remap tree
* Remap tree now small enough to fit in a single leaf
* Corruption as we now have a level-0 block with a level-1 metadata item
  in the extent tree

One solution to this would be to rework the remap tree code so that it operates
via delayed refs. But as we're hoping to remove cow-only metadata items in the
future anyway, change things so that the remap tree doesn't have any entries in
the extent tree. This also has the benefit of reducing write amplification.

We also make it so that the clear_cache mount option is a no-op, as with the
extent tree v2, as the free-space tree can no longer be recreated from the
extent tree.

Finally disable relocating the remap tree itself, which is added back in
a later patch. As it is we would get corruption as the traditional
relocation method walks the extent tree, and we're removing its metadata
items.

Signed-off-by: Mark Harmstone <mark@harmstone.com>
Reviewed-by: Boris Burkov <boris@bur.io>
---
 fs/btrfs/disk-io.c     |  3 +++
 fs/btrfs/extent-tree.c | 31 ++++++++++++++++++++++++++++++-
 fs/btrfs/volumes.c     |  3 +++
 3 files changed, 36 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index cbfb7127b528..c36367f9017f 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -3007,6 +3007,9 @@ int btrfs_start_pre_rw_mount(struct btrfs_fs_info *fs_info)
 		if (btrfs_fs_incompat(fs_info, EXTENT_TREE_V2))
 			btrfs_warn(fs_info,
 				   "'clear_cache' option is ignored with extent tree v2");
+		else if (btrfs_fs_incompat(fs_info, REMAP_TREE))
+			btrfs_warn(fs_info,
+				   "'clear_cache' option is ignored with remap tree");
 		else
 			rebuild_free_space_tree = true;
 	} else if (btrfs_fs_compat_ro(fs_info, FREE_SPACE_TREE) &&
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 1dcd69fe97ed..43473a6d91d7 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -1553,6 +1553,28 @@ static void free_head_ref_squota_rsv(struct btrfs_fs_info *fs_info,
 				  BTRFS_QGROUP_RSV_DATA);
 }
 
+static int drop_remap_tree_ref(struct btrfs_trans_handle *trans,
+			       const struct btrfs_delayed_ref_node *node)
+{
+	u64 bytenr = node->bytenr;
+	u64 num_bytes = node->num_bytes;
+	int ret;
+
+	ret = btrfs_add_to_free_space_tree(trans, bytenr, num_bytes);
+	if (unlikely(ret)) {
+		btrfs_abort_transaction(trans, ret);
+		return ret;
+	}
+
+	ret = btrfs_update_block_group(trans, bytenr, num_bytes, false);
+	if (unlikely(ret)) {
+		btrfs_abort_transaction(trans, ret);
+		return ret;
+	}
+
+	return 0;
+}
+
 static int run_delayed_data_ref(struct btrfs_trans_handle *trans,
 				struct btrfs_delayed_ref_head *href,
 				const struct btrfs_delayed_ref_node *node,
@@ -1747,7 +1769,10 @@ static int run_delayed_tree_ref(struct btrfs_trans_handle *trans,
 	} else if (node->action == BTRFS_ADD_DELAYED_REF) {
 		ret = __btrfs_inc_extent_ref(trans, node, extent_op);
 	} else if (node->action == BTRFS_DROP_DELAYED_REF) {
-		ret = __btrfs_free_extent(trans, href, node, extent_op);
+		if (node->ref_root == BTRFS_REMAP_TREE_OBJECTID)
+			ret = drop_remap_tree_ref(trans, node);
+		else
+			ret = __btrfs_free_extent(trans, href, node, extent_op);
 	} else {
 		BUG();
 	}
@@ -4886,6 +4911,9 @@ static int alloc_reserved_tree_block(struct btrfs_trans_handle *trans,
 	int level = btrfs_delayed_ref_owner(node);
 	bool skinny_metadata = btrfs_fs_incompat(fs_info, SKINNY_METADATA);
 
+	if (unlikely(node->ref_root == BTRFS_REMAP_TREE_OBJECTID))
+		goto skip;
+
 	extent_key.objectid = node->bytenr;
 	if (skinny_metadata) {
 		/* The owner of a tree block is the level. */
@@ -4938,6 +4966,7 @@ static int alloc_reserved_tree_block(struct btrfs_trans_handle *trans,
 
 	btrfs_free_path(path);
 
+skip:
 	return alloc_reserved_extent(trans, node->bytenr, fs_info->nodesize);
 }
 
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 070efac46a81..d6060e0e2144 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -3970,6 +3970,9 @@ static bool should_balance_chunk(struct extent_buffer *leaf, struct btrfs_chunk
 	struct btrfs_balance_args *bargs = NULL;
 	u64 chunk_type = btrfs_chunk_type(leaf, chunk);
 
+	if (chunk_type & BTRFS_BLOCK_GROUP_METADATA_REMAP)
+		return false;
+
 	/* type filter */
 	if (!((chunk_type & BTRFS_BLOCK_GROUP_TYPE_MASK) &
 	      (bctl->flags & BTRFS_BALANCE_TYPE_MASK))) {
-- 
2.51.2


