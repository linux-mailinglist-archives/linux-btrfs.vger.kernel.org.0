Return-Path: <linux-btrfs+bounces-17580-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6310CBC8D04
	for <lists+linux-btrfs@lfdr.de>; Thu, 09 Oct 2025 13:29:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31BBB1A60583
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Oct 2025 11:29:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 635CC2E2DDE;
	Thu,  9 Oct 2025 11:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=harmstone.com header.i=@harmstone.com header.b="SWU9ycWX"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail.burntcomma.com (unknown [62.3.69.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6012E2E0939
	for <linux-btrfs@vger.kernel.org>; Thu,  9 Oct 2025 11:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.3.69.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760009302; cv=none; b=iWDtoUjHd6r1QOd4M+GqS2MFdLkRHUWPWKww4CN2WW0zbk+eYQwmiSZldQvDV1Ww/W2yzyaH9ung3qKYy+Kc/VonxiHSHjPn5dtqcP3LEUAcCfOpzwywck1xwSuq+d4/y48ahDtb3SpGcZ6SbtgCeAx1Q9Lq5KExBnh79wb6c6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760009302; c=relaxed/simple;
	bh=vmBq25o0k42FuvB4nqvubVaEnvzC2NszJ8dqC15kWiY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Mime-Version; b=WKezovaDYJ/iyPeLgIzZTg4RRugY9ncSlyUV+FhZKXNsXcx3J9s8rYcuIYR1Nz8KQ9+VmwMg4GH9vvE9CEYUhHTDPfEEDftDEpN2lBRstiY0+kg+CpfIekbZcbB5mCX1mEYrzQ8Z6vL6+XOEepCIb9bB9aMhnSi0aUlDUZSGPaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=harmstone.com; spf=fail smtp.mailfrom=harmstone.com; dkim=pass (1024-bit key) header.d=harmstone.com header.i=@harmstone.com header.b=SWU9ycWX; arc=none smtp.client-ip=62.3.69.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=harmstone.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=harmstone.com
Received: from localhost.localdomain (beren.burntcomma.com [IPv6:2a02:8012:8cf0:0:ce28:aaff:fe0d:6db2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.burntcomma.com (Postfix) with ESMTPSA id 737752C5652;
	Thu,  9 Oct 2025 12:28:08 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=harmstone.com;
	s=mail; t=1760009288;
	bh=vBD5D9LbHi0Aulpt2YiN/CDblgMFTNs+Ueo5AnpSClo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SWU9ycWXHDqlE3VEPyH7NyuSCxzUoY5GuMDV9P1L0wZFAsi5sURijcLHKqcLyJ14j
	 ifBitdABC1tv0cEufauavtGvSxgLWw9BE1FGMoy6OhtLjSW2OgSwliUWYyV8myZxzm
	 MCB+oUrpbXTKTjEYB4QQ0gN++c93mvyssdsFxggY=
From: Mark Harmstone <mark@harmstone.com>
To: linux-btrfs@vger.kernel.org
Cc: Mark Harmstone <mark@harmstone.com>,
	Boris Burkov <boris@bur.io>
Subject: [PATCH v3 05/17] btrfs: don't add metadata items for the remap tree to the extent tree
Date: Thu,  9 Oct 2025 12:28:00 +0100
Message-ID: <20251009112814.13942-6-mark@harmstone.com>
In-Reply-To: <20251009112814.13942-1-mark@harmstone.com>
References: <20251009112814.13942-1-mark@harmstone.com>
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
index 102e5e0ad10c..92cb789957b4 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -3049,6 +3049,9 @@ int btrfs_start_pre_rw_mount(struct btrfs_fs_info *fs_info)
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
index dc4ca98c3780..d964147b8097 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -1552,6 +1552,28 @@ static void free_head_ref_squota_rsv(struct btrfs_fs_info *fs_info,
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
+	if (ret) {
+		btrfs_abort_transaction(trans, ret);
+		return ret;
+	}
+
+	ret = btrfs_update_block_group(trans, bytenr, num_bytes, false);
+	if (ret) {
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
@@ -1746,7 +1768,10 @@ static int run_delayed_tree_ref(struct btrfs_trans_handle *trans,
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
@@ -4896,6 +4921,9 @@ static int alloc_reserved_tree_block(struct btrfs_trans_handle *trans,
 	int level = btrfs_delayed_ref_owner(node);
 	bool skinny_metadata = btrfs_fs_incompat(fs_info, SKINNY_METADATA);
 
+	if (unlikely(node->ref_root == BTRFS_REMAP_TREE_OBJECTID))
+		goto skip;
+
 	extent_key.objectid = node->bytenr;
 	if (skinny_metadata) {
 		/* The owner of a tree block is the level. */
@@ -4948,6 +4976,7 @@ static int alloc_reserved_tree_block(struct btrfs_trans_handle *trans,
 
 	btrfs_free_path(path);
 
+skip:
 	return alloc_reserved_extent(trans, node->bytenr, fs_info->nodesize);
 }
 
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 6750f6f0af59..0abe02a7072f 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -3998,6 +3998,9 @@ static bool should_balance_chunk(struct extent_buffer *leaf, struct btrfs_chunk
 	struct btrfs_balance_args *bargs = NULL;
 	u64 chunk_type = btrfs_chunk_type(leaf, chunk);
 
+	if (chunk_type & BTRFS_BLOCK_GROUP_REMAP)
+		return false;
+
 	/* type filter */
 	if (!((chunk_type & BTRFS_BLOCK_GROUP_TYPE_MASK) &
 	      (bctl->flags & BTRFS_BALANCE_TYPE_MASK))) {
-- 
2.49.1


