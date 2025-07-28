Return-Path: <linux-btrfs+bounces-15711-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1DF5B137A8
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Jul 2025 11:40:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 147F7178B1F
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Jul 2025 09:40:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB10A253F07;
	Mon, 28 Jul 2025 09:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HDaIbK2m"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F2EB253B43
	for <linux-btrfs@vger.kernel.org>; Mon, 28 Jul 2025 09:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753695595; cv=none; b=JWLoALctAZy8YgtfK7ns3TCPC+c/DwLD596vI5hSVoOfvWUWRYw7aV0nGS5jRXsbJH3aErAnNJeQPO4YOkzS+66eWrm+eV9SLasBS+jky93c2XvOUhfsxxGRsixQ60Ra7CdGfS3N6j9h0HqfaFRdBKWqgdKlhQf22jaWIXaJ1x4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753695595; c=relaxed/simple;
	bh=n0+DoSfJHc1lvNjVPK0VexWifT2fZK1IAHbxxDE2AMo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=crPjAADREMmnr6pC9slxfG1D3HCDYSvRt+L/e3+wiw4U7IXq6hUncYkptgECFup47Hel2JF2ugdEDioGqLubIC5feB1TRk63Aq8upJLKqJsVwCup52MxKgNQOwJVZK4EDB6je4WSp0uCh4D7HHTRpXnrLMS3eBZQrrroAqGk4bE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HDaIbK2m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F422C4CEF7
	for <linux-btrfs@vger.kernel.org>; Mon, 28 Jul 2025 09:39:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753695594;
	bh=n0+DoSfJHc1lvNjVPK0VexWifT2fZK1IAHbxxDE2AMo=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=HDaIbK2m9c6Kgxouh9L7BjJHyT30cNg1nxJ2N6fFplbd6iY5cIFNXmXXmm+HeFCVQ
	 hTxHmzOeJ4csTfRqCRgaWxyMd/u9UO5XrIZik6YZdaP5BSGHxjeEoJ6vM9qVwCOkW8
	 w4El3oQgzB+q3fWCuHYtjtllD4I4bieSZaugciFdGfkeT3966cvMXgiuWk2oxLgLVO
	 suDsyWJLwadi934d8owgTF36Zruzen5f0/9W26x0vCGNzLrK5zgBASrAd3yvBNRY4Q
	 +aIXEDRFe/xBleFKgbxZuV/lNlYZHYA0G6TNaB9BkSc1nKVcU4hdjntcjLh1Remn0/
	 5zJMbrWRrm95A==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 3/3] btrfs: simplify error handling logic for btrfs_link()
Date: Mon, 28 Jul 2025 10:39:48 +0100
Message-ID: <fcedbeb4d8f0c9afbd99d0c768ad181842b41dad.1753469763.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.1753469762.git.fdmanana@suse.com>
References: <cover.1753469762.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

Instead of incrementing the inode's link count and refcount early before
adding the link, updating the inode and deleting orphan item, do it after
all those steps succeeded right before calling d_instantiate(). This makes
the error handling logic simpler by avoiding the need for the 'drop_inode'
variable to signal if we need to undo the link count increment and the
inode refcount increase under the 'fail' label.

This also reduces the level of indentation by one, making the code easier
to read.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/inode.c | 45 +++++++++++++++++++--------------------------
 1 file changed, 19 insertions(+), 26 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 46675783578e..af47cbeadeaa 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -6798,7 +6798,6 @@ static int btrfs_link(struct dentry *old_dentry, struct inode *dir,
 	struct fscrypt_name fname;
 	u64 index;
 	int ret;
-	int drop_inode = 0;
 
 	/* do not allow sys_link's with other subvols of the same device */
 	if (btrfs_root_id(root) != btrfs_root_id(BTRFS_I(inode)->root))
@@ -6830,50 +6829,44 @@ static int btrfs_link(struct dentry *old_dentry, struct inode *dir,
 
 	/* There are several dir indexes for this inode, clear the cache. */
 	BTRFS_I(inode)->dir_index = 0ULL;
-	inc_nlink(inode);
 	inode_inc_iversion(inode);
 	inode_set_ctime_current(inode);
-	ihold(inode);
 	set_bit(BTRFS_INODE_COPY_EVERYTHING, &BTRFS_I(inode)->runtime_flags);
 
 	ret = btrfs_add_link(trans, BTRFS_I(dir), BTRFS_I(inode),
 			     &fname.disk_name, 1, index);
+	if (ret)
+		goto fail;
 
+	/* Link added now we update the inode item with the new link count. */
+	inc_nlink(inode);
+	ret = btrfs_update_inode(trans, BTRFS_I(inode));
 	if (ret) {
-		drop_inode = 1;
-	} else {
-		struct dentry *parent = dentry->d_parent;
+		btrfs_abort_transaction(trans, ret);
+		goto fail;
+	}
 
-		ret = btrfs_update_inode(trans, BTRFS_I(inode));
+	if (inode->i_nlink == 1) {
+		/*
+		 * If the new hard link count is 1, it's a file created with the
+		 * open(2) O_TMPFILE flag.
+		 */
+		ret = btrfs_orphan_del(trans, BTRFS_I(inode));
 		if (ret) {
 			btrfs_abort_transaction(trans, ret);
-			drop_inode = 1;
 			goto fail;
 		}
-		if (inode->i_nlink == 1) {
-			/*
-			 * If new hard link count is 1, it's a file created
-			 * with open(2) O_TMPFILE flag.
-			 */
-			ret = btrfs_orphan_del(trans, BTRFS_I(inode));
-			if (ret) {
-				btrfs_abort_transaction(trans, ret);
-				drop_inode = 1;
-				goto fail;
-			}
-		}
-		d_instantiate(dentry, inode);
-		btrfs_log_new_name(trans, old_dentry, NULL, 0, parent);
 	}
 
+	/* Grab reference for the new dentry passed to d_instantiate(). */
+	ihold(inode);
+	d_instantiate(dentry, inode);
+	btrfs_log_new_name(trans, old_dentry, NULL, 0, dentry->d_parent);
+
 fail:
 	fscrypt_free_filename(&fname);
 	if (trans)
 		btrfs_end_transaction(trans);
-	if (drop_inode) {
-		inode_dec_link_count(inode);
-		iput(inode);
-	}
 	btrfs_btree_balance_dirty(fs_info);
 	return ret;
 }
-- 
2.47.2


