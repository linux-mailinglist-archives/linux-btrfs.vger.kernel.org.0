Return-Path: <linux-btrfs+bounces-4834-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 488258BFCF7
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 May 2024 14:17:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD9AB1F242FD
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 May 2024 12:17:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B1DD84047;
	Wed,  8 May 2024 12:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qipN3iFi"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B1BB83CBE
	for <linux-btrfs@vger.kernel.org>; Wed,  8 May 2024 12:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715170656; cv=none; b=BUb9cJTtMI76KB/fn6TL+h7O456E6TUZ3nHNfovjfb4DbQf6ofdvr5xF/d+8mpQqGc52O4Ik+Oz0sPvp5hzolBhBsm2ySXjaY+OD6bzPkOZAQGiVZVViucW7Udj0UwRjWvD3EbBG389p3HLx5N52GFwUwcElQjLLoqvf7lDJSHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715170656; c=relaxed/simple;
	bh=7k6Yg+N7w1RI3Eak9CJ7F8XP9uvtAz94b4glfhcsF+8=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ua24N7hJb8rZ1bjbsqodk/3L1tioKh+OaHFhe74RgZ/uXr2orKV4DHh0aB1/JTp1UDuIxLW7FLEAg1cUxCisgZCg8i6WCvbJneMbq2K+z5zC3/EiOjnPjFWDdUCyL8taBVexfelzZAsk6Od0bgl46KvC6UewHxN95x2ffZorAZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qipN3iFi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80D72C4AF17
	for <linux-btrfs@vger.kernel.org>; Wed,  8 May 2024 12:17:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715170656;
	bh=7k6Yg+N7w1RI3Eak9CJ7F8XP9uvtAz94b4glfhcsF+8=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=qipN3iFiFUfPfpKggTdB+2dcvxko70NLIyGUFrg2cZOa2oUBLH8/RI9yxz3Ws4eF2
	 tkDTCvBssbMLLf5izQm6zihenSxWueaF8SrTUoV6788nsBQfBSQq2/76y8dWnAWV5g
	 Tr76ADIR4zJ4HdGcBvNN5PLbcSYPRJXZkc2HTWu0iuMy74/0ILCYEsdAR6iFhfnwev
	 NUpceOVtnNN84LMk0JpJvPswGvTqfpp3K6MKwQdZGWYcDmnQI5Afph4YGySAkhSZoi
	 k6hId0rgxZ+K6JnBSDHVRRaTn44JruAGSkz8p8k6MawV37n3QszCM5R3/Ux3nec//3
	 30zb53qUgmL4w==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 2/8] btrfs: preallocate inodes xarray entry to avoid transaction abort
Date: Wed,  8 May 2024 13:17:25 +0100
Message-Id: <b9b409c79af85d0fe336ebec2800c36399c8f515.1715169723.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1715169723.git.fdmanana@suse.com>
References: <cover.1715169723.git.fdmanana@suse.com>
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


