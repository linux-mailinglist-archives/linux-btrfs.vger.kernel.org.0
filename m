Return-Path: <linux-btrfs+bounces-4896-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 211A58C2952
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 May 2024 19:33:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B287FB251C2
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 May 2024 17:33:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AF6A1D6A8;
	Fri, 10 May 2024 17:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z43RmwPB"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5F531C69A
	for <linux-btrfs@vger.kernel.org>; Fri, 10 May 2024 17:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715362383; cv=none; b=BimiZyNI6yTiYTH26vWEITH0V5ELG+KyyDbtPdA1EdI681gadca18f9Z3QlY8i+6/aAxSA2VVSmUtB/jO+gZH3+6mfY6d7vyXtOoWVBWAh2h5zZHaXcP3l7erEP8/pWXtWTS6p1A3+AlU2AmP9uictz+P1vuDGQz8IzlYdWcRbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715362383; c=relaxed/simple;
	bh=WOJ3VG1kjcqAtvx9qo9VdsR2wUUJ5FXa+6V2LwgdB48=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QcHR7W6C7dY5tC/FIx5BHLeaYY5wWEZXr7RLtJAMyDLi/mEqk+F3tNPzn2Z0sTyP4a+YvkknpmivlN30vOU17YGL0KimQtXL44YVco2f2GB4YpY40DAng+WsDWyT6N447uYnNSqXM8P+oWqrZlu5tI93d1jDo5/Nzi+Dwo3XVfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z43RmwPB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 071F3C113CC
	for <linux-btrfs@vger.kernel.org>; Fri, 10 May 2024 17:33:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715362383;
	bh=WOJ3VG1kjcqAtvx9qo9VdsR2wUUJ5FXa+6V2LwgdB48=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=Z43RmwPBS16UJc9b4CtguXsBrh9QsfyHXjwVuBmoi+QEN0jRERMzEgyvr+McQNdYU
	 TXmE7WvXOXlHeqy1e/Wu3IGNQhIbUhELx0o+RMJlbFYCW7m9YsLKeJm8qgLkfbKyUl
	 wpYeCP1PfZ59j7CsgZVGSuHQC1cg5Hl2hfPPX8BzvPzJ/EV5zn+JGZWhP0TAfCOcUX
	 WjLty9At7uMZ78iwHnQ1oT73DbErM2miNgoAYo9vs10Y7yJkSMvSvFkFjWSVTDlsMk
	 hVpBjeGaVp0GdYT+UjxdHsEYCmqBWeI+ajDWNtoR9RdcCEVkUK7YrGAy4WDK1uwAVW
	 ysK+3swj9j7Kg==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 02/10] btrfs: preallocate inodes xarray entry to avoid transaction abort
Date: Fri, 10 May 2024 18:32:50 +0100
Message-Id: <9cf8f37a2b6c61c0532ae060a917f7d232acd5e1.1715362104.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1715362104.git.fdmanana@suse.com>
References: <cover.1715362104.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

When creating a new inode, at btrfs_create_new_inode(), one of the very
last steps is to add the inode to the root's inodes xarray. This often
requires allocating memory which may fail (even though xarrays have a
dedicated kmem_cache which make it less likely to fail), and at that point
we are forced to abort the current transaction (as some, but not all, of
the inode metadata was added to its subvolume btree).

To avoid a transaction abort, preallocate memory for the xarray early at
btrfs_create_new_inode(), so that if we fail we don't need to abort the
transaction and the insertion into the xarray is guaranteed to succeed.

Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/inode.c | 26 +++++++++++++++++++-------
 1 file changed, 19 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 450fe1582f1d..85dbc19c2f6f 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -5493,7 +5493,7 @@ static int fixup_tree_root_location(struct btrfs_fs_info *fs_info,
 	return err;
 }
 
-static int btrfs_add_inode_to_root(struct btrfs_inode *inode)
+static int btrfs_add_inode_to_root(struct btrfs_inode *inode, bool prealloc)
 {
 	struct btrfs_root *root = inode->root;
 	struct btrfs_inode *existing;
@@ -5503,9 +5503,11 @@ static int btrfs_add_inode_to_root(struct btrfs_inode *inode)
 	if (inode_unhashed(&inode->vfs_inode))
 		return 0;
 
-	ret = xa_reserve(&root->inodes, ino, GFP_NOFS);
-	if (ret)
-		return ret;
+	if (prealloc) {
+		ret = xa_reserve(&root->inodes, ino, GFP_NOFS);
+		if (ret)
+			return ret;
+	}
 
 	spin_lock(&root->inode_lock);
 	existing = xa_store(&root->inodes, ino, inode, GFP_ATOMIC);
@@ -5606,7 +5608,7 @@ struct inode *btrfs_iget_path(struct super_block *s, u64 ino,
 
 		ret = btrfs_read_locked_inode(inode, path);
 		if (!ret) {
-			ret = btrfs_add_inode_to_root(BTRFS_I(inode));
+			ret = btrfs_add_inode_to_root(BTRFS_I(inode), true);
 			if (ret) {
 				iget_failed(inode);
 				inode = ERR_PTR(ret);
@@ -6237,6 +6239,7 @@ int btrfs_create_new_inode(struct btrfs_trans_handle *trans,
 	struct btrfs_item_batch batch;
 	unsigned long ptr;
 	int ret;
+	bool xa_reserved = false;
 
 	path = btrfs_alloc_path();
 	if (!path)
@@ -6251,6 +6254,11 @@ int btrfs_create_new_inode(struct btrfs_trans_handle *trans,
 		goto out;
 	inode->i_ino = objectid;
 
+	ret = xa_reserve(&root->inodes, objectid, GFP_NOFS);
+	if (ret)
+		goto out;
+	xa_reserved = true;
+
 	if (args->orphan) {
 		/*
 		 * O_TMPFILE, set link count to 0, so that after this point, we
@@ -6424,8 +6432,9 @@ int btrfs_create_new_inode(struct btrfs_trans_handle *trans,
 		}
 	}
 
-	ret = btrfs_add_inode_to_root(BTRFS_I(inode));
-	if (ret) {
+	ret = btrfs_add_inode_to_root(BTRFS_I(inode), false);
+	if (WARN_ON(ret)) {
+		/* Shouldn't happen, we used xa_reserve() before. */
 		btrfs_abort_transaction(trans, ret);
 		goto discard;
 	}
@@ -6456,6 +6465,9 @@ int btrfs_create_new_inode(struct btrfs_trans_handle *trans,
 	ihold(inode);
 	discard_new_inode(inode);
 out:
+	if (xa_reserved)
+		xa_release(&root->inodes, objectid);
+
 	btrfs_free_path(path);
 	return ret;
 }
-- 
2.43.0


