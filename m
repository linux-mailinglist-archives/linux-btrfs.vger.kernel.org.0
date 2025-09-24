Return-Path: <linux-btrfs+bounces-17138-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B4F9B9AEDB
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Sep 2025 18:55:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1C0C3A8024
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Sep 2025 16:55:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56131314A95;
	Wed, 24 Sep 2025 16:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QDkhMECV"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A534313D68
	for <linux-btrfs@vger.kernel.org>; Wed, 24 Sep 2025 16:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758732902; cv=none; b=l8Ddo4wIdQg5DYarEQtfIKiRIfQByORZ67K1vDfko5cjMbLkIRZbNDb1vLMoLBcpJr4RdZb1Mvpekt9hsEsRyLMAa5vK9UTFHSiLD+6/0oSidz+AfC68kWqGIW2UxV12IaV3tRkj13Gj5m9hV/wRL3OrHk0ltoTDZyAH/zEG+oI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758732902; c=relaxed/simple;
	bh=sY+3y8Po4xtw5ZS/Bl3E29JuikGFYS/jLI8n4LSbRVk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jl8tE4lG79ZY1Li9nBoD13brWDiGHMvLNmKUbFK7Sm901eHMhU/KCOlJuIYv249RJArTRM90JEN5UBGV9AJ4pTXHCBmb48mbSxUoaW41SVBU9pDG01J84VAOkDrgeGiNYVAddlk++DaoQr4aU5TsvOJg1Aug0nkdcCT4MPyK/HM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QDkhMECV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4B1AC4CEF4
	for <linux-btrfs@vger.kernel.org>; Wed, 24 Sep 2025 16:55:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758732902;
	bh=sY+3y8Po4xtw5ZS/Bl3E29JuikGFYS/jLI8n4LSbRVk=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=QDkhMECVQaoeXZ7Kf2vfcHmpM2E8mBKiL+r76fCH2B0rDBUo2t6ZoXkJI3bH8L5me
	 7lILSkK5rk9njbMoevBplquruBBbJyBJPvRqUAhM+ZNfjxNyVqV3pC29Knv3N/5zcb
	 c9om9nUAfEWdZToqig5vuiApaXB4dWVru6TpN4cHeDCDGZVIWtnO8l3XvyyYmq761O
	 v5ZnIgLqBLOmNXYmY8Gk41lOt0mtCGmqQZpXfusmn6gd74pn7su+g06cEP19jX/B5i
	 vFEmmiFtPyfIz+xB2DW8MTo9natDcSH813qnXMFaZC+1020Y3HVCBjaHW+CkRScFig
	 PSWM+/vpIh1eQ==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 2/2] btrfs: use single return value variable in btrfs_relocate_block_group()
Date: Wed, 24 Sep 2025 17:54:56 +0100
Message-ID: <946f642cd146d5af0e7f24355023c8c276c15745.1758732655.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.1758732655.git.fdmanana@suse.com>
References: <cover.1758732655.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

We are using 'ret' and 'err' variables to track return values and errors,
which is pattern that is error prone and we had quite some bugs due to
this pattern in the past.

Simplify this and use a single variable, named 'ret', to track errors and
the return value.

Also rename the variable 'rw' to 'bg_is_ro' which is more meaningful name,
and change its type from int to bool.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/relocation.c | 39 ++++++++++++++++-----------------------
 1 file changed, 16 insertions(+), 23 deletions(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index acce4d813153..16f625aaaf69 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -3881,8 +3881,7 @@ int btrfs_relocate_block_group(struct btrfs_fs_info *fs_info, u64 group_start,
 	struct inode *inode;
 	struct btrfs_path *path;
 	int ret;
-	int rw = 0;
-	int err = 0;
+	bool bg_is_ro = false;
 
 	/*
 	 * This only gets set if we had a half-deleted snapshot on mount.  We
@@ -3924,24 +3923,20 @@ int btrfs_relocate_block_group(struct btrfs_fs_info *fs_info, u64 group_start,
 	}
 
 	ret = reloc_chunk_start(fs_info);
-	if (ret < 0) {
-		err = ret;
+	if (ret < 0)
 		goto out_put_bg;
-	}
 
 	rc->extent_root = extent_root;
 	rc->block_group = bg;
 
 	ret = btrfs_inc_block_group_ro(rc->block_group, true);
-	if (ret) {
-		err = ret;
+	if (ret)
 		goto out;
-	}
-	rw = 1;
+	bg_is_ro = true;
 
 	path = btrfs_alloc_path();
 	if (!path) {
-		err = -ENOMEM;
+		ret = -ENOMEM;
 		goto out;
 	}
 
@@ -3953,14 +3948,12 @@ int btrfs_relocate_block_group(struct btrfs_fs_info *fs_info, u64 group_start,
 	else
 		ret = PTR_ERR(inode);
 
-	if (ret && ret != -ENOENT) {
-		err = ret;
+	if (ret && ret != -ENOENT)
 		goto out;
-	}
 
 	rc->data_inode = create_reloc_inode(rc->block_group);
 	if (IS_ERR(rc->data_inode)) {
-		err = PTR_ERR(rc->data_inode);
+		ret = PTR_ERR(rc->data_inode);
 		rc->data_inode = NULL;
 		goto out;
 	}
@@ -3981,8 +3974,6 @@ int btrfs_relocate_block_group(struct btrfs_fs_info *fs_info, u64 group_start,
 		mutex_lock(&fs_info->cleaner_mutex);
 		ret = relocate_block_group(rc);
 		mutex_unlock(&fs_info->cleaner_mutex);
-		if (ret < 0)
-			err = ret;
 
 		finishes_stage = rc->stage;
 		/*
@@ -3995,16 +3986,18 @@ int btrfs_relocate_block_group(struct btrfs_fs_info *fs_info, u64 group_start,
 		 * out of the loop if we hit an error.
 		 */
 		if (rc->stage == MOVE_DATA_EXTENTS && rc->found_file_extent) {
-			ret = btrfs_wait_ordered_range(BTRFS_I(rc->data_inode), 0,
-						       (u64)-1);
-			if (ret)
-				err = ret;
+			int wb_ret;
+
+			wb_ret = btrfs_wait_ordered_range(BTRFS_I(rc->data_inode), 0,
+							  (u64)-1);
+			if (wb_ret && ret == 0)
+				ret = wb_ret;
 			invalidate_mapping_pages(rc->data_inode->i_mapping,
 						 0, -1);
 			rc->stage = UPDATE_DATA_PTRS;
 		}
 
-		if (err < 0)
+		if (ret < 0)
 			goto out;
 
 		if (rc->extents_found == 0)
@@ -4020,14 +4013,14 @@ int btrfs_relocate_block_group(struct btrfs_fs_info *fs_info, u64 group_start,
 	WARN_ON(rc->block_group->reserved > 0);
 	WARN_ON(rc->block_group->used > 0);
 out:
-	if (err && rw)
+	if (ret && bg_is_ro)
 		btrfs_dec_block_group_ro(rc->block_group);
 	iput(rc->data_inode);
 	reloc_chunk_end(fs_info);
 out_put_bg:
 	btrfs_put_block_group(bg);
 	free_reloc_control(rc);
-	return err;
+	return ret;
 }
 
 static noinline_for_stack int mark_garbage_root(struct btrfs_root *root)
-- 
2.47.2


