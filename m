Return-Path: <linux-btrfs+bounces-12854-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A09ADA7E8C3
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Apr 2025 19:45:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42439189F4D2
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Apr 2025 17:41:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9507A21B191;
	Mon,  7 Apr 2025 17:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EGiOGNPK"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB8B6253F23
	for <linux-btrfs@vger.kernel.org>; Mon,  7 Apr 2025 17:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744047403; cv=none; b=LJJ7ry++feoijRzBQz7CljYTMXu4Xir3XtmRrbCtVCxBHGWEI2yr0KQGSFmgs0ss1eTgXJyNeHWXWlFqsEXn3oCanuS5wiD5vtlDVCx8bqCDQCv5RYZdP+mGY2oWxMzP3rJxWdmaksDFUlew/RGTcSm0xBMIOUz1AJGLt7XDnfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744047403; c=relaxed/simple;
	bh=DZKc7B27JRWoe1B8X8W+fcc5l/ct9e+BNiiO0fJ99i4=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PBdoabZHqNF4f6svEMJZAlIdFsddlpgpHfSnCCCd5Uds+zEj/OGCME9u56+n7KpWuZcptrKPpzubbSFwq+3UkWrgofqZlHPga51GACFND2iJx8hWCkeZUeASWs/ltc67l01dI4z4JKP1LOQamg+wY4veV/Zh5MxikE4R8I+EhD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EGiOGNPK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3BB8C4CEE7
	for <linux-btrfs@vger.kernel.org>; Mon,  7 Apr 2025 17:36:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744047403;
	bh=DZKc7B27JRWoe1B8X8W+fcc5l/ct9e+BNiiO0fJ99i4=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=EGiOGNPKxX7zpdGB+iRI7zElIg/MQEGR/lEr6vhIGYTaiVCUw2TFItGugDgiUk8tF
	 4pw/HCEMCuoojcRhICuP3kq9pxAY1QT8H+rzMbIYGi/EiP+EsG3whrLw2xkeoLB+Hd
	 fT5IFA3Hu5Yx03S4IGiutzlNF8yEan9aTW5RWNl/8q812W08yvpe6ukq/x6To7v+To
	 n+LIbkg25PEa+sLJPFjSBwGK5QLX4nk+7WBj3DnzB6wIVCJCXNyUZ/LeMy2ww4tXxk
	 8eXs7HpjMJUVSPNed1IQZgrr+wwZzIQv9xvR2zVnh+Z+CPlhRN4nTx9ZcgnZprRjSW
	 V1vcYDLsBtLRg==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 16/16] btrfs: make btrfs_find_contiguous_extent_bit() return bool instead of int
Date: Mon,  7 Apr 2025 18:36:23 +0100
Message-Id: <32b70227272884c4757cef3a8c2e0e9cfe8ead13.1744046765.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1744046765.git.fdmanana@suse.com>
References: <cover.1744046765.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

The function needs only to return true or false, so there's no need to
return an integer. Currently it returns 0 when a range with the given
bits is set and 1 when not found, which is a bit counter intuitive too.
So change the function to return a bool instead, returning true when a
range is found and false otherwise. Update the function's documentation
to mention the return value too.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/extent-io-tree.c | 11 +++++++----
 fs/btrfs/extent-io-tree.h |  4 ++--
 fs/btrfs/file-item.c      |  8 ++++----
 3 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/fs/btrfs/extent-io-tree.c b/fs/btrfs/extent-io-tree.c
index 11f2e195ef8d..cae3980f4291 100644
--- a/fs/btrfs/extent-io-tree.c
+++ b/fs/btrfs/extent-io-tree.c
@@ -928,12 +928,15 @@ bool btrfs_find_first_extent_bit(struct extent_io_tree *tree, u64 start,
  * contiguous area for given bits.  We will search to the first bit we find, and
  * then walk down the tree until we find a non-contiguous area.  The area
  * returned will be the full contiguous area with the bits set.
+ *
+ * Returns true if we found a range with the given bits set, in which case
+ * @start_ret and @end_ret are updated, or false if no range was found.
  */
-int btrfs_find_contiguous_extent_bit(struct extent_io_tree *tree, u64 start,
-				     u64 *start_ret, u64 *end_ret, u32 bits)
+bool btrfs_find_contiguous_extent_bit(struct extent_io_tree *tree, u64 start,
+				      u64 *start_ret, u64 *end_ret, u32 bits)
 {
 	struct extent_state *state;
-	int ret = 1;
+	bool ret = false;
 
 	ASSERT(!btrfs_fs_incompat(btrfs_extent_io_tree_to_fs_info(tree), NO_HOLES));
 
@@ -947,7 +950,7 @@ int btrfs_find_contiguous_extent_bit(struct extent_io_tree *tree, u64 start,
 				break;
 			*end_ret = state->end;
 		}
-		ret = 0;
+		ret = true;
 	}
 	spin_unlock(&tree->lock);
 	return ret;
diff --git a/fs/btrfs/extent-io-tree.h b/fs/btrfs/extent-io-tree.h
index 625f4cd3debd..d8c01d857667 100644
--- a/fs/btrfs/extent-io-tree.h
+++ b/fs/btrfs/extent-io-tree.h
@@ -219,8 +219,8 @@ bool btrfs_find_first_extent_bit(struct extent_io_tree *tree, u64 start,
 				 struct extent_state **cached_state);
 void btrfs_find_first_clear_extent_bit(struct extent_io_tree *tree, u64 start,
 				       u64 *start_ret, u64 *end_ret, u32 bits);
-int btrfs_find_contiguous_extent_bit(struct extent_io_tree *tree, u64 start,
-				     u64 *start_ret, u64 *end_ret, u32 bits);
+bool btrfs_find_contiguous_extent_bit(struct extent_io_tree *tree, u64 start,
+				      u64 *start_ret, u64 *end_ret, u32 bits);
 bool btrfs_find_delalloc_range(struct extent_io_tree *tree, u64 *start,
 			       u64 *end, u64 max_bytes,
 			       struct extent_state **cached_state);
diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
index d2ea830ad244..c5fb4b357100 100644
--- a/fs/btrfs/file-item.c
+++ b/fs/btrfs/file-item.c
@@ -46,7 +46,7 @@
 void btrfs_inode_safe_disk_i_size_write(struct btrfs_inode *inode, u64 new_i_size)
 {
 	u64 start, end, i_size;
-	int ret;
+	bool found;
 
 	spin_lock(&inode->lock);
 	i_size = new_i_size ?: i_size_read(&inode->vfs_inode);
@@ -55,9 +55,9 @@ void btrfs_inode_safe_disk_i_size_write(struct btrfs_inode *inode, u64 new_i_siz
 		goto out_unlock;
 	}
 
-	ret = btrfs_find_contiguous_extent_bit(inode->file_extent_tree, 0, &start,
-					       &end, EXTENT_DIRTY);
-	if (!ret && start == 0)
+	found = btrfs_find_contiguous_extent_bit(inode->file_extent_tree, 0, &start,
+						 &end, EXTENT_DIRTY);
+	if (found && start == 0)
 		i_size = min(i_size, end + 1);
 	else
 		i_size = 0;
-- 
2.45.2


