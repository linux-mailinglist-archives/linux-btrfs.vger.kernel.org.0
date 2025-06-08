Return-Path: <linux-btrfs+bounces-14549-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CAEEAAD1552
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Jun 2025 00:44:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 096711884F46
	for <lists+linux-btrfs@lfdr.de>; Sun,  8 Jun 2025 22:44:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 709BD25D202;
	Sun,  8 Jun 2025 22:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JAa8x7S3"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B934325A2C9
	for <linux-btrfs@vger.kernel.org>; Sun,  8 Jun 2025 22:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749422622; cv=none; b=NSYwgWlDnP4YSDp/1oBfSV4FHRIj52zJ6DAQvCYulJkA/bitBTyH2XRFb6OIfqjDYziT55ih+e+OLmTjZ1Cq+5JjI21JIcA2R5uHzlV2DI/ORd4/5pYcZ0YJJ0PAVzJaBFbL4pveIHJxDBAIe1Lx1OJzFWDSSTaKg/qYAkV3z/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749422622; c=relaxed/simple;
	bh=68qiLTYsg1xT8D7eVRtT3UQVT6GPsNXjt8X5cH/HPfE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=is83l3UMDU2OyXo84NUffstHEQIinbHw9jxLR9NwmgSIOMCcVXaqX47dg2UlfI9tRtMd5BomNeleAhmB/y+XuW3tPIGQ5XV+bRZlguPD2OiiXBk4gNAzq6QSDC/8ID+BuRVV1TEjBj/kUP3Lqy19Qwka2j+KwYZjMawYCFA4Xuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JAa8x7S3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A83D8C4CEEF
	for <linux-btrfs@vger.kernel.org>; Sun,  8 Jun 2025 22:43:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749422622;
	bh=68qiLTYsg1xT8D7eVRtT3UQVT6GPsNXjt8X5cH/HPfE=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=JAa8x7S3hZz7V0dfVBt1bsh3+4BYGNeXlIIOLcn0uTQXslXIR9XhOg1szZUn6wBZz
	 oCDSDqkH2pi8kitUK5xVrqvF09uYwItgTHnSy1do1fjHreXOjolR2fUYal0k3dJLpL
	 yOOZ8lrOSl6OqKH4YCwTAAPOIdtosxGYn+n1xv35DWeJ6N6uLEMSOpom1bAcDs86+Z
	 3FZzlJ8OHlw7icp+EEQms6pX3oCfeHxRYwx0dMckkxLy1/+9yMGFd/TA1d4YzXslWW
	 OdeJgqULnRZw34hCY6m0Cqtk1eHcNex8NYS3rv2EZrsRrRibSPZSXqcxk8I1Gl2Wi9
	 HUcNIudTLBvXQ==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 3/3] btrfs: check BLOCK_GROUP_FLAG_NEEDS_FREE_SPACE at __add_block_group_free_space()
Date: Sun,  8 Jun 2025 23:43:34 +0100
Message-ID: <40dd299a0b7551fb8163da00a6ed716a8f8c3d46.1749421865.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.1749421865.git.fdmanana@suse.com>
References: <cover.1749421865.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

Every caller of __add_block_group_free_space() is checking if the flag
BLOCK_GROUP_FLAG_NEEDS_FREE_SPACE is set before calling it. This is
duplicate code and it's prone to some mistake in case we add more callers
in the future. So move the check for that flag into the start of
__add_block_group_free_space().

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/free-space-tree.c | 58 ++++++++++++++++++--------------------
 1 file changed, 28 insertions(+), 30 deletions(-)

diff --git a/fs/btrfs/free-space-tree.c b/fs/btrfs/free-space-tree.c
index af005fb4b676..f03f3610b713 100644
--- a/fs/btrfs/free-space-tree.c
+++ b/fs/btrfs/free-space-tree.c
@@ -816,11 +816,9 @@ int __remove_from_free_space_tree(struct btrfs_trans_handle *trans,
 	u32 flags;
 	int ret;
 
-	if (test_bit(BLOCK_GROUP_FLAG_NEEDS_FREE_SPACE, &block_group->runtime_flags)) {
-		ret = __add_block_group_free_space(trans, block_group, path);
-		if (ret)
-			return ret;
-	}
+	ret = __add_block_group_free_space(trans, block_group, path);
+	if (ret)
+		return ret;
 
 	info = search_free_space_info(NULL, block_group, path, 0);
 	if (IS_ERR(info))
@@ -1011,11 +1009,9 @@ int __add_to_free_space_tree(struct btrfs_trans_handle *trans,
 	u32 flags;
 	int ret;
 
-	if (test_bit(BLOCK_GROUP_FLAG_NEEDS_FREE_SPACE, &block_group->runtime_flags)) {
-		ret = __add_block_group_free_space(trans, block_group, path);
-		if (ret)
-			return ret;
-	}
+	ret = __add_block_group_free_space(trans, block_group, path);
+	if (ret)
+		return ret;
 
 	info = search_free_space_info(NULL, block_group, path, 0);
 	if (IS_ERR(info))
@@ -1403,9 +1399,12 @@ static int __add_block_group_free_space(struct btrfs_trans_handle *trans,
 					struct btrfs_block_group *block_group,
 					struct btrfs_path *path)
 {
+	bool own_path = false;
 	int ret;
 
-	clear_bit(BLOCK_GROUP_FLAG_NEEDS_FREE_SPACE, &block_group->runtime_flags);
+	if (!test_and_clear_bit(BLOCK_GROUP_FLAG_NEEDS_FREE_SPACE,
+				&block_group->runtime_flags))
+		return 0;
 
 	/*
 	 * While rebuilding the free space tree we may allocate new metadata
@@ -1430,10 +1429,19 @@ static int __add_block_group_free_space(struct btrfs_trans_handle *trans,
 	 */
 	set_bit(BLOCK_GROUP_FLAG_FREE_SPACE_ADDED, &block_group->runtime_flags);
 
+	if (!path) {
+		path = btrfs_alloc_path();
+		if (!path) {
+			btrfs_abort_transaction(trans, -ENOMEM);
+			return -ENOMEM;
+		}
+		own_path = true;
+	}
+
 	ret = add_new_free_space_info(trans, block_group, path);
 	if (ret) {
 		btrfs_abort_transaction(trans, ret);
-		return ret;
+		goto out;
 	}
 
 	ret = __add_to_free_space_tree(trans, block_group, path,
@@ -1441,33 +1449,23 @@ static int __add_block_group_free_space(struct btrfs_trans_handle *trans,
 	if (ret)
 		btrfs_abort_transaction(trans, ret);
 
-	return 0;
+out:
+	if (own_path)
+		btrfs_free_path(path);
+
+	return ret;
 }
 
 int add_block_group_free_space(struct btrfs_trans_handle *trans,
 			       struct btrfs_block_group *block_group)
 {
-	struct btrfs_fs_info *fs_info = trans->fs_info;
-	struct btrfs_path *path = NULL;
-	int ret = 0;
+	int ret;
 
-	if (!btrfs_fs_compat_ro(fs_info, FREE_SPACE_TREE))
+	if (!btrfs_fs_compat_ro(trans->fs_info, FREE_SPACE_TREE))
 		return 0;
 
 	mutex_lock(&block_group->free_space_lock);
-	if (!test_bit(BLOCK_GROUP_FLAG_NEEDS_FREE_SPACE, &block_group->runtime_flags))
-		goto out;
-
-	path = btrfs_alloc_path();
-	if (!path) {
-		ret = -ENOMEM;
-		btrfs_abort_transaction(trans, ret);
-		goto out;
-	}
-
-	ret = __add_block_group_free_space(trans, block_group, path);
-out:
-	btrfs_free_path(path);
+	ret = __add_block_group_free_space(trans, block_group, NULL);
 	mutex_unlock(&block_group->free_space_lock);
 	return ret;
 }
-- 
2.47.2


