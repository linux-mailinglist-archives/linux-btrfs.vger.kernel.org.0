Return-Path: <linux-btrfs+bounces-14924-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 92995AE69C3
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Jun 2025 16:56:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0E904E1865
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Jun 2025 14:49:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDE102E11B7;
	Tue, 24 Jun 2025 14:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A5qfjjp/"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BB432E11B0
	for <linux-btrfs@vger.kernel.org>; Tue, 24 Jun 2025 14:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750776155; cv=none; b=LgbM6EmNYeRBx/UzrZMcSQpC/Kf/18+nAtR2CtYJ7rCL4jYiXmgD8p3TWRS71wSD1DnOtBhkMywFqkzD7R3i4pEV0CKxaXXuaYUWmgcsQnDooVoVqCuVhj2iHyANPkg0MoG/S2czCzrr4NQbzNgSub8b7O8DxxBKN0JSVg+MUGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750776155; c=relaxed/simple;
	bh=0bDy2D8pqudXsBqNla3Fg3U7t68w7/VltUAZlltQ+iI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U0CWK42aw3PKXxoj9MLCwHP0lOiknbLQ8d3VIRQMMLmgqo4SUG1yGj6qCZDXAOJeVoeazS/nVpmJaegjjd6Q/75m2cgqDLKupWnA0KV8AKYLHbTE06s4ooRVxOvkpcSb2NjJO9gGdub7lFpQDBC7yGbRSx7pmbH+kpNtVqN854Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A5qfjjp/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D201C4CEE3
	for <linux-btrfs@vger.kernel.org>; Tue, 24 Jun 2025 14:42:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750776154;
	bh=0bDy2D8pqudXsBqNla3Fg3U7t68w7/VltUAZlltQ+iI=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=A5qfjjp/w4k9BIpbIMRDAyeEp+tepbXhDASR9e3lxXBjeTRWlCVYnPoHWi9eVsApF
	 wqwQNptAR/wQQOAkE5hYUcyoeBqo+xToJ3EpLZOKJniPl5cM2NuNNeZ5m3glv5NQPX
	 rntFKWZBRUcEJkJyobzVxXRg1+FwrzJ/FskEe0UoJltBF6teC9c9gxxzHu6xqqdH1H
	 wFwHFwxHjimL/yzQ3rxdeAtfUCJDFPstbbu44e+qolOiOo5bi90e5aSB6/RhCiHkv9
	 YoFv6cKtIM2WtrR43zyb+BLIh++vBepVg7/LTLh9Bk6BOE5kwm06wr8/O16XXrHFKd
	 tEJZCADDZOpew==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 08/12] btrfs: use btrfs inodes in btrfs_rmdir() to avoid so much usage of BTRFS_I()
Date: Tue, 24 Jun 2025 15:42:18 +0100
Message-ID: <461dd2e6771f1000bab3948e841c24be84b74966.1750709411.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.1750709410.git.fdmanana@suse.com>
References: <cover.1750709410.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

Almost everywhere we want to use a btrfs inode and therefore we have a
lot of calls to BTRFS_I(), making the code more verbose. Instead use btrfs
inode local variables to avoid so much use of BTRFS_I().

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/inode.c | 31 ++++++++++++++++---------------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index f8e4651fe60b..6df7ef1b869b 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -4701,32 +4701,33 @@ int btrfs_delete_subvolume(struct btrfs_inode *dir, struct dentry *dentry)
 	return ret;
 }
 
-static int btrfs_rmdir(struct inode *dir, struct dentry *dentry)
+static int btrfs_rmdir(struct inode *vfs_dir, struct dentry *dentry)
 {
-	struct inode *inode = d_inode(dentry);
-	struct btrfs_fs_info *fs_info = BTRFS_I(inode)->root->fs_info;
+	struct btrfs_inode *dir = BTRFS_I(vfs_dir);
+	struct btrfs_inode *inode = BTRFS_I(d_inode(dentry));
+	struct btrfs_fs_info *fs_info = inode->root->fs_info;
 	int ret = 0;
 	struct btrfs_trans_handle *trans;
 	struct fscrypt_name fname;
 
-	if (inode->i_size > BTRFS_EMPTY_DIR_SIZE)
+	if (inode->vfs_inode.i_size > BTRFS_EMPTY_DIR_SIZE)
 		return -ENOTEMPTY;
-	if (btrfs_ino(BTRFS_I(inode)) == BTRFS_FIRST_FREE_OBJECTID) {
+	if (btrfs_ino(inode) == BTRFS_FIRST_FREE_OBJECTID) {
 		if (unlikely(btrfs_fs_incompat(fs_info, EXTENT_TREE_V2))) {
 			btrfs_err(fs_info,
 			"extent tree v2 doesn't support snapshot deletion yet");
 			return -EOPNOTSUPP;
 		}
-		return btrfs_delete_subvolume(BTRFS_I(dir), dentry);
+		return btrfs_delete_subvolume(dir, dentry);
 	}
 
-	ret = fscrypt_setup_filename(dir, &dentry->d_name, 1, &fname);
+	ret = fscrypt_setup_filename(vfs_dir, &dentry->d_name, 1, &fname);
 	if (ret)
 		return ret;
 
 	/* This needs to handle no-key deletions later on */
 
-	trans = __unlink_start_trans(BTRFS_I(dir));
+	trans = __unlink_start_trans(dir);
 	if (IS_ERR(trans)) {
 		ret = PTR_ERR(trans);
 		goto out_notrans;
@@ -4746,22 +4747,22 @@ static int btrfs_rmdir(struct inode *dir, struct dentry *dentry)
 	 * This is because we can't unlink other roots when replaying the dir
 	 * deletes for directory foo.
 	 */
-	if (BTRFS_I(inode)->last_unlink_trans >= trans->transid)
-		btrfs_record_snapshot_destroy(trans, BTRFS_I(dir));
+	if (inode->last_unlink_trans >= trans->transid)
+		btrfs_record_snapshot_destroy(trans, dir);
 
-	if (unlikely(btrfs_ino(BTRFS_I(inode)) == BTRFS_EMPTY_SUBVOL_DIR_OBJECTID)) {
-		ret = btrfs_unlink_subvol(trans, BTRFS_I(dir), dentry);
+	if (unlikely(btrfs_ino(inode) == BTRFS_EMPTY_SUBVOL_DIR_OBJECTID)) {
+		ret = btrfs_unlink_subvol(trans, dir, dentry);
 		goto out;
 	}
 
-	ret = btrfs_orphan_add(trans, BTRFS_I(inode));
+	ret = btrfs_orphan_add(trans, inode);
 	if (ret)
 		goto out;
 
 	/* now the directory is empty */
-	ret = btrfs_unlink_inode(trans, BTRFS_I(dir), BTRFS_I(inode), &fname.disk_name);
+	ret = btrfs_unlink_inode(trans, dir, inode, &fname.disk_name);
 	if (!ret)
-		btrfs_i_size_write(BTRFS_I(inode), 0);
+		btrfs_i_size_write(inode, 0);
 out:
 	btrfs_end_transaction(trans);
 out_notrans:
-- 
2.47.2


