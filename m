Return-Path: <linux-btrfs+bounces-14744-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 556DCADD5EC
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Jun 2025 18:28:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 56A717AE881
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Jun 2025 16:19:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D01E2F948A;
	Tue, 17 Jun 2025 16:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SgkWOnlL"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46CF92F7439
	for <linux-btrfs@vger.kernel.org>; Tue, 17 Jun 2025 16:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750176807; cv=none; b=Z/mdzhHrH/i+4BCmtElaQXnJt04KN/oKEMBXd9oaloCqNrSyG0K1S5UAetm5B1XuxpYvYOBx/Gw1OD84AbnSs3BwGx7hgaiJna2kJW+GINcms2PsFtjWXKT9SRJIPey2GZUxgRrh7q9FPcv3wWdlRDsv1p6klJSQjMQl8rIvvH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750176807; c=relaxed/simple;
	bh=lVXgKWHYfyqSOruPLjl2mK/giK/7ET0m65upuSWQGog=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TlUiH9j2bS3inqrAqi3oShH0CVGhLFFMaLJRWwl9ULkLgfzjwtt8AgQ9bl7REERw7jHkAwUXeeqDNB7CMJ9OVA4rsJzlLVIgIo451qjO//ZMgvtqt/G10upqnMu+mu4nawUxqnx/F2J1Ik/YVBStJdiQMVBMawzl86v8gQHyFto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SgkWOnlL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56CB8C4CEE3
	for <linux-btrfs@vger.kernel.org>; Tue, 17 Jun 2025 16:13:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750176806;
	bh=lVXgKWHYfyqSOruPLjl2mK/giK/7ET0m65upuSWQGog=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=SgkWOnlLUPHiwCYpzeQ7EnBNgl3vg4Au6IWz1bP/XHsNb1NUtVUgkXBrkrvitrw7p
	 NhkCKd6/SoScLoL8jFREJpbcFKAlyQppkGP9ZHus8caxp+BotDDk1Zp327/1YLkf58
	 LEc5AbGBEAJFuhr/tvtItIJ6wP0bN6eIVqw5S73vRRcLLU7ohn2H+ii8nCdR/mOLwG
	 Cg91o5aC6uEYtjVYdAwPwE2JEldCClIOFLxS34xmxGtZOgrRN718PUHFjbaE4Tyzcf
	 N1ozmoSsLeFykO/Ot70y+YQpycS3XPsM8xfSa0Prkn7VsxNJZ4NB8lYlrQrFBJADd2
	 tMjxBbU8Ug0Sw==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 15/16] btrfs: add and use helper to determine if using bitmaps in free space tree
Date: Tue, 17 Jun 2025 17:13:10 +0100
Message-ID: <3a6d4004a9bda4c4596d559c7c43b98e74151f11.1750075579.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.1750075579.git.fdmanana@suse.com>
References: <cover.1750075579.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

When adding and removing free space to the free space tree, we need to
lookup the respective block group's free info item in the free space tree,
check its flags for the BTRFS_FREE_SPACE_USING_BITMAPS bit and then
release the path.

Move these steps into a helper function and use it in both sites.
This will also help avoiding duplicate code in a subsequent change.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/free-space-tree.c | 50 ++++++++++++++++++++------------------
 1 file changed, 26 insertions(+), 24 deletions(-)

diff --git a/fs/btrfs/free-space-tree.c b/fs/btrfs/free-space-tree.c
index c85ca7ce2683..3c8bb95fa044 100644
--- a/fs/btrfs/free-space-tree.c
+++ b/fs/btrfs/free-space-tree.c
@@ -791,32 +791,40 @@ static int remove_free_space_extent(struct btrfs_trans_handle *trans,
 	return update_free_space_extent_count(trans, block_group, path, new_extents);
 }
 
+static int use_bitmaps(struct btrfs_block_group *bg, struct btrfs_path *path)
+{
+	struct btrfs_free_space_info *info;
+	u32 flags;
+
+	info = btrfs_search_free_space_info(NULL, bg, path, 0);
+	if (IS_ERR(info))
+		return PTR_ERR(info);
+	flags = btrfs_free_space_flags(path->nodes[0], info);
+	btrfs_release_path(path);
+
+	return (flags & BTRFS_FREE_SPACE_USING_BITMAPS) ? 1 : 0;
+}
+
 EXPORT_FOR_TESTS
 int __btrfs_remove_from_free_space_tree(struct btrfs_trans_handle *trans,
 					struct btrfs_block_group *block_group,
 					struct btrfs_path *path, u64 start, u64 size)
 {
-	struct btrfs_free_space_info *info;
-	u32 flags;
 	int ret;
 
 	ret = __add_block_group_free_space(trans, block_group, path);
 	if (ret)
 		return ret;
 
-	info = btrfs_search_free_space_info(NULL, block_group, path, 0);
-	if (IS_ERR(info))
-		return PTR_ERR(info);
-	flags = btrfs_free_space_flags(path->nodes[0], info);
-	btrfs_release_path(path);
+	ret = use_bitmaps(block_group, path);
+	if (ret < 0)
+		return ret;
 
-	if (flags & BTRFS_FREE_SPACE_USING_BITMAPS) {
+	if (ret)
 		return modify_free_space_bitmap(trans, block_group, path,
 						start, size, true);
-	} else {
-		return remove_free_space_extent(trans, block_group, path,
-						start, size);
-	}
+
+	return remove_free_space_extent(trans, block_group, path, start, size);
 }
 
 int btrfs_remove_from_free_space_tree(struct btrfs_trans_handle *trans,
@@ -984,27 +992,21 @@ int __btrfs_add_to_free_space_tree(struct btrfs_trans_handle *trans,
 				   struct btrfs_block_group *block_group,
 				   struct btrfs_path *path, u64 start, u64 size)
 {
-	struct btrfs_free_space_info *info;
-	u32 flags;
 	int ret;
 
 	ret = __add_block_group_free_space(trans, block_group, path);
 	if (ret)
 		return ret;
 
-	info = btrfs_search_free_space_info(NULL, block_group, path, 0);
-	if (IS_ERR(info))
-		return PTR_ERR(info);
-	flags = btrfs_free_space_flags(path->nodes[0], info);
-	btrfs_release_path(path);
+	ret = use_bitmaps(block_group, path);
+	if (ret < 0)
+		return ret;
 
-	if (flags & BTRFS_FREE_SPACE_USING_BITMAPS) {
+	if (ret)
 		return modify_free_space_bitmap(trans, block_group, path,
 						start, size, false);
-	} else {
-		return add_free_space_extent(trans, block_group, path, start,
-					     size);
-	}
+
+	return add_free_space_extent(trans, block_group, path, start, size);
 }
 
 int btrfs_add_to_free_space_tree(struct btrfs_trans_handle *trans,
-- 
2.47.2


