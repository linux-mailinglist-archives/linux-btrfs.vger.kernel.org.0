Return-Path: <linux-btrfs+bounces-18303-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EB56DC07A89
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Oct 2025 20:13:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 601C050053A
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Oct 2025 18:13:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6038834845D;
	Fri, 24 Oct 2025 18:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=harmstone.com header.i=@harmstone.com header.b="1SAJo3RF"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail.burntcomma.com (mail2.burntcomma.com [217.169.27.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57A2E347FC7
	for <linux-btrfs@vger.kernel.org>; Fri, 24 Oct 2025 18:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.169.27.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761329565; cv=none; b=SROgCQWo//enqu5Q81XohrwRXxm4RRAStR0U/E5RkCIKQGSvtdx1nxCIVND5lVYvircbJNO4eth8BfzyUjNdl0/fACIxCf3EVEy5D6RYq5YQqZA031Fyov+T4EZThgGXTRiUJo51lm0z2aljTy7Fvui0iDjSkZqQCfPplEYlk4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761329565; c=relaxed/simple;
	bh=xaLSVrt7SKxCtLXe8hg5IQpuFjtYgrONZBhQHB9KEXo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Mime-Version; b=Rs6RK/psefxI6AZt0LOqaVVzu79jbiWQbXg+J7Q67hUmz8w9K2U4pZTkuW0ipwZvIK7VVe6nqbTpXou9xa+yn/T6QQKjk7zW4DeC7gx24kvOn+xIiE4hhcGm2e8T14m/51Hi5d6xppxlC/AfyuQ8Yx/Asxkva5UznsfFPjcDxLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=harmstone.com; spf=pass smtp.mailfrom=harmstone.com; dkim=pass (1024-bit key) header.d=harmstone.com header.i=@harmstone.com header.b=1SAJo3RF; arc=none smtp.client-ip=217.169.27.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=harmstone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=harmstone.com
Received: from localhost.localdomain (beren.burntcomma.com [IPv6:2a02:8012:8cf0:0:ce28:aaff:fe0d:6db2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.burntcomma.com (Postfix) with ESMTPSA id 82F422CFE4A;
	Fri, 24 Oct 2025 19:12:30 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=harmstone.com;
	s=mail; t=1761329550;
	bh=TAKjxMMFn+LbriOmY0Dhu5M14kXRXUwwhRjliMlgqXw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=1SAJo3RFBzs8aN/0qKH278ZXeRBrZ1TUxWuiZHSHgKLXzxmbgJ+cEUNpW6q8oiQ2Q
	 /lmC6PJBz8cWNH4CD2XZqSBtW7A5+wb9c/U9otNh8bVp4rBIw9+Zv8NCmyNxGCgqVB
	 dBe9pbGKMAe3FzgHr1DFa14+qWTkle0SEyYAvQtw=
From: Mark Harmstone <mark@harmstone.com>
To: linux-btrfs@vger.kernel.org
Cc: Mark Harmstone <mark@harmstone.com>,
	Boris Burkov <boris@bur.io>
Subject: [PATCH v4 05/16] btrfs: don't add metadata items for the remap tree to the extent tree
Date: Fri, 24 Oct 2025 19:12:06 +0100
Message-ID: <20251024181227.32228-6-mark@harmstone.com>
In-Reply-To: <20251024181227.32228-1-mark@harmstone.com>
References: <20251024181227.32228-1-mark@harmstone.com>
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
index 0bf78ae2060d..13d9a9ece3ca 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -3050,6 +3050,9 @@ int btrfs_start_pre_rw_mount(struct btrfs_fs_info *fs_info)
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
index ae2c3dc9957e..871a63799311 100644
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
@@ -4895,6 +4920,9 @@ static int alloc_reserved_tree_block(struct btrfs_trans_handle *trans,
 	int level = btrfs_delayed_ref_owner(node);
 	bool skinny_metadata = btrfs_fs_incompat(fs_info, SKINNY_METADATA);
 
+	if (unlikely(node->ref_root == BTRFS_REMAP_TREE_OBJECTID))
+		goto skip;
+
 	extent_key.objectid = node->bytenr;
 	if (skinny_metadata) {
 		/* The owner of a tree block is the level. */
@@ -4947,6 +4975,7 @@ static int alloc_reserved_tree_block(struct btrfs_trans_handle *trans,
 
 	btrfs_free_path(path);
 
+skip:
 	return alloc_reserved_extent(trans, node->bytenr, fs_info->nodesize);
 }
 
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 8a9bff0426ae..7b2bec28dbd7 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -3972,6 +3972,9 @@ static bool should_balance_chunk(struct extent_buffer *leaf, struct btrfs_chunk
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


