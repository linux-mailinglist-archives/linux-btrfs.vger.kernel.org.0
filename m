Return-Path: <linux-btrfs+bounces-15205-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 19F27AF5D71
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Jul 2025 17:42:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31C3C3AE52D
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Jul 2025 15:40:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF7702F19B7;
	Wed,  2 Jul 2025 15:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GrUddS/a"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02E762F1991
	for <linux-btrfs@vger.kernel.org>; Wed,  2 Jul 2025 15:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751470720; cv=none; b=uZ3e9jQR3bh+fFu5v1yzFbyqF9DfRZ6lcXiR2bycNNEumg+XBcicn0duj9PkMGCc0Rzrg2aJrsqW/Rxw2YeHwlEeRvZCQH9KvnHc8O1t5PN1sQr07rKVLujo7be85oCGjWzt8rMFXwTPFsnO8UJ74Sbz2M2tQGfBakKo8oWl5cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751470720; c=relaxed/simple;
	bh=7PvH9FsmNL1B6gmW4y0iuXMUxnkiXG7BlZjHxRf3TrE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D6+vqYUqKzCqjLbcJloo1lxcD7Z1h3Z+ZOt/sNXn1AzkUkAVlrZ9jkoFjqkjwHMD7WEygqR/ASCezxGINpinhaxQ2XmA9+y/5lwMWoYVXbdlXmlPDVoleFn1E4/4vpW7ZRUCKoAhQfMeM8szoWkaG09hKHTgEXTInA/ePeuRnfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GrUddS/a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11C6AC4CEF3
	for <linux-btrfs@vger.kernel.org>; Wed,  2 Jul 2025 15:38:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751470719;
	bh=7PvH9FsmNL1B6gmW4y0iuXMUxnkiXG7BlZjHxRf3TrE=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=GrUddS/aXxLzQ4CD0tbq+MygTQE9CGKTPbe9qtEyl0KodxzJi+VjRv8xe6TeAcO5A
	 uNcAjaet6q3G3gQEksy8zXm0iJOqXXpYpZGQCZWnP1IFMhgzTOnzifCl1UMInjYFMY
	 ExeREydE2dQgIrEkyUJMBvvz6NIfPhChajjuPI4GUt2NjT8Zb6e6cN0sf3PdGaQiV4
	 41GsPMM0UdHweCw7tWll5RNWY+ivvMJTXnokUCIHKwtaodoXHpVmY86IlRYvl8Bi82
	 z7nmybgxqDhwE0l9bWjEynp02xzTouwvTeCfdEVhEQpU2Qg3QJudmgi8Cu6favuOM8
	 +OlzxZpAtcQGQ==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 3/3] btrfs: set search_commit_root to false in iterate_inodes_from_logical()
Date: Wed,  2 Jul 2025 16:38:32 +0100
Message-ID: <4e7a7f5f5d2e282b6179f292b9afd6eaf9261967.1751460099.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.1751460099.git.fdmanana@suse.com>
References: <cover.1751460099.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

There's no point in checking at iterate_inodes_from_logical() if the path
has search_commit_root set, the only caller never sets search_commit_root
to true and it doesn't make sense for it ever to be true for the current
use case (logical_to_ino ioctl). So stop checking for that and since the
only caller allocates the path just for it to be used by
iterate_inodes_from_logical(), move the path allocation into that function.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/backref.c | 12 +++++++-----
 fs/btrfs/backref.h |  3 +--
 fs/btrfs/ioctl.c   | 10 +---------
 3 files changed, 9 insertions(+), 16 deletions(-)

diff --git a/fs/btrfs/backref.c b/fs/btrfs/backref.c
index 2e0d959092f5..6a450be293b1 100644
--- a/fs/btrfs/backref.c
+++ b/fs/btrfs/backref.c
@@ -2546,17 +2546,20 @@ static int build_ino_list(u64 inum, u64 offset, u64 num_bytes, u64 root, void *c
 }
 
 int iterate_inodes_from_logical(u64 logical, struct btrfs_fs_info *fs_info,
-				struct btrfs_path *path,
 				void *ctx, bool ignore_offset)
 {
 	struct btrfs_backref_walk_ctx walk_ctx = { 0 };
 	int ret;
 	u64 flags = 0;
 	struct btrfs_key found_key;
-	int search_commit_root = path->search_commit_root;
+	struct btrfs_path *path;
+
+	path = btrfs_alloc_path();
+	if (!path)
+		return -ENOMEM;
 
 	ret = extent_from_logical(fs_info, logical, path, &found_key, &flags);
-	btrfs_release_path(path);
+	btrfs_free_path(path);
 	if (ret < 0)
 		return ret;
 	if (flags & BTRFS_EXTENT_FLAG_TREE_BLOCK)
@@ -2569,8 +2572,7 @@ int iterate_inodes_from_logical(u64 logical, struct btrfs_fs_info *fs_info,
 		walk_ctx.extent_item_pos = logical - found_key.objectid;
 	walk_ctx.fs_info = fs_info;
 
-	return iterate_extent_inodes(&walk_ctx, search_commit_root,
-				     build_ino_list, ctx);
+	return iterate_extent_inodes(&walk_ctx, false, build_ino_list, ctx);
 }
 
 static int inode_to_path(u64 inum, u32 name_len, unsigned long name_off,
diff --git a/fs/btrfs/backref.h b/fs/btrfs/backref.h
index 61f53825226d..34b0193a181c 100644
--- a/fs/btrfs/backref.h
+++ b/fs/btrfs/backref.h
@@ -226,8 +226,7 @@ int iterate_extent_inodes(struct btrfs_backref_walk_ctx *ctx,
 			  iterate_extent_inodes_t *iterate, void *user_ctx);
 
 int iterate_inodes_from_logical(u64 logical, struct btrfs_fs_info *fs_info,
-				struct btrfs_path *path, void *ctx,
-				bool ignore_offset);
+				void *ctx, bool ignore_offset);
 
 int paths_from_inode(u64 inum, struct inode_fs_paths *ipath);
 
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 503c469249e5..680c4e794e67 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -3353,7 +3353,6 @@ static long btrfs_ioctl_logical_to_ino(struct btrfs_fs_info *fs_info,
 	int size;
 	struct btrfs_ioctl_logical_ino_args *loi;
 	struct btrfs_data_container *inodes = NULL;
-	struct btrfs_path *path = NULL;
 	bool ignore_offset;
 
 	if (!capable(CAP_SYS_ADMIN))
@@ -3387,14 +3386,7 @@ static long btrfs_ioctl_logical_to_ino(struct btrfs_fs_info *fs_info,
 		goto out_loi;
 	}
 
-	path = btrfs_alloc_path();
-	if (!path) {
-		ret = -ENOMEM;
-		goto out;
-	}
-	ret = iterate_inodes_from_logical(loi->logical, fs_info, path,
-					  inodes, ignore_offset);
-	btrfs_free_path(path);
+	ret = iterate_inodes_from_logical(loi->logical, fs_info, inodes, ignore_offset);
 	if (ret == -EINVAL)
 		ret = -ENOENT;
 	if (ret < 0)
-- 
2.47.2


