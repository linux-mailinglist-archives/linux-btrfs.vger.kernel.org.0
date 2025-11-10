Return-Path: <linux-btrfs+bounces-18833-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 86689C4845C
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Nov 2025 18:20:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B149C4F3A76
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Nov 2025 17:15:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D52429B233;
	Mon, 10 Nov 2025 17:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=harmstone.com header.i=@harmstone.com header.b="Ff2KwC0E"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail.burntcomma.com (mail2.burntcomma.com [217.169.27.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A81FD299928
	for <linux-btrfs@vger.kernel.org>; Mon, 10 Nov 2025 17:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.169.27.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762794929; cv=none; b=aNgJYHWuyd898uNqhYi0XC5D8fqzh6zx4vo5WlI1Vb3E+qLzIIeJGVjyhGUNOEsBiSCrSeCYnMACCW1v5+wsgLWJJBkI17QKxKTL9LXtNbWQs0Q/14ebxH5YhU9+ZnNSkSN3y+iiiNgPwS7QoOwDkumrAysPKpC8y6I/vKzeSuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762794929; c=relaxed/simple;
	bh=pxxeOghhYxlzs3T7Xv0JawYobyKH7I4gqCbc+2F8t/M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Mime-Version; b=vCVhkBih1x4OGgOH+ywGfmLeLXwgLEXgiRcif1/fDis6MeTwKsW7ysiYbNw3DzCUORw+Y1S+LBa7+mf470r9rLFLqpxyRmcYDikmJK2Nbr/cKffJPScgeKTDRM1AGDZVGxsA6vE32t44KF3HbHW6MiDa0s9I0mC4h7iyDnNqtaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=harmstone.com; spf=pass smtp.mailfrom=harmstone.com; dkim=pass (1024-bit key) header.d=harmstone.com header.i=@harmstone.com header.b=Ff2KwC0E; arc=none smtp.client-ip=217.169.27.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=harmstone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=harmstone.com
Received: from beren (beren.burntcomma.com [IPv6:2a02:8012:8cf0:0:ce28:aaff:fe0d:6db2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.burntcomma.com (Postfix) with ESMTPSA id D32F12D8F8D;
	Mon, 10 Nov 2025 17:15:14 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=harmstone.com;
	s=mail; t=1762794914;
	bh=+1Y5EO506xp/N1lUt64Y/kBe9QBWtZVnlTOOkuXyB9I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Ff2KwC0EwRkOi9q/P5G371KrOX0MjKZreaBt69a33/1aJN0IUZy4VAStkFHgnBBZl
	 uBXhF5GL8LEY6+RMt/0Wm8JO2GCXCtChTv5TI0ghg1QabBkZXiKmjsMSoOEEh4H28j
	 8zgycqJEehQR8fDlR2NkZy4T8dM0wcMH+6fBgGO4=
From: Mark Harmstone <mark@harmstone.com>
To: linux-btrfs@vger.kernel.org
Cc: Mark Harmstone <mark@harmstone.com>,
	Boris Burkov <boris@bur.io>
Subject: [PATCH v5 05/16] btrfs: don't add metadata items for the remap tree to the extent tree
Date: Mon, 10 Nov 2025 17:14:29 +0000
Message-ID: <20251110171511.20900-6-mark@harmstone.com>
In-Reply-To: <20251110171511.20900-1-mark@harmstone.com>
References: <20251110171511.20900-1-mark@harmstone.com>
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
index 22f3d4f9a3e0..9348f57a8653 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -3046,6 +3046,9 @@ int btrfs_start_pre_rw_mount(struct btrfs_fs_info *fs_info)
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
index 86004b8daa96..383f6fce0079 100644
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
@@ -4894,6 +4919,9 @@ static int alloc_reserved_tree_block(struct btrfs_trans_handle *trans,
 	int level = btrfs_delayed_ref_owner(node);
 	bool skinny_metadata = btrfs_fs_incompat(fs_info, SKINNY_METADATA);
 
+	if (unlikely(node->ref_root == BTRFS_REMAP_TREE_OBJECTID))
+		goto skip;
+
 	extent_key.objectid = node->bytenr;
 	if (skinny_metadata) {
 		/* The owner of a tree block is the level. */
@@ -4946,6 +4974,7 @@ static int alloc_reserved_tree_block(struct btrfs_trans_handle *trans,
 
 	btrfs_free_path(path);
 
+skip:
 	return alloc_reserved_extent(trans, node->bytenr, fs_info->nodesize);
 }
 
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index ca3bbbd3b213..453e8581650e 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -3971,6 +3971,9 @@ static bool should_balance_chunk(struct extent_buffer *leaf, struct btrfs_chunk
 	struct btrfs_balance_args *bargs = NULL;
 	u64 chunk_type = btrfs_chunk_type(leaf, chunk);
 
+	if (chunk_type & BTRFS_BLOCK_GROUP_REMAP)
+		return false;
+
 	/* type filter */
 	if (!((chunk_type & BTRFS_BLOCK_GROUP_TYPE_MASK) &
 	      (bctl->flags & BTRFS_BALANCE_TYPE_MASK))) {
-- 
2.51.0


