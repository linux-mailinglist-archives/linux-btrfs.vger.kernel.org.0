Return-Path: <linux-btrfs+bounces-12089-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4306EA5693A
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Mar 2025 14:44:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 331D53A96D9
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Mar 2025 13:44:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1812921ABBD;
	Fri,  7 Mar 2025 13:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m2zu+FDb"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FF3321ABCA
	for <linux-btrfs@vger.kernel.org>; Fri,  7 Mar 2025 13:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741355072; cv=none; b=SUo/42oy97OLoZOwxVYs7TjxN7ZlDlSzZ8A0PXH/jo57xq0aHRLp2M54llHZyAkEA7q4AI4DlGITQdP6ahQLC5CB3XbWGa+t0L+1l8fuZ3GudfK1yOm6WGFSA8aL/iQLQGinja8ZCGNvpU0pYulJdzz1ugsbisfVrsjUzgfbzVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741355072; c=relaxed/simple;
	bh=2ncE/Tv+foZaD8H+fNvfP5tR4RIFdYUcMdheCrR1iSk=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oUdFoeYEqt3P7bcL2F1xiZuGeIioedLI9UuvC4rhwcaC7L6FemxLC7S1xjI2ESrs/Yr6mZlutHskLApRTvCgk12FlSaxKDKWvzQW6tuhHSXjnB/atcalkHxa71MQ03fZ4ylB4cBOVyc3N9wu/B3HY6+l8smTqcOF/d9Df8MD0AM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m2zu+FDb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C9AEC4CEE5
	for <linux-btrfs@vger.kernel.org>; Fri,  7 Mar 2025 13:44:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741355071;
	bh=2ncE/Tv+foZaD8H+fNvfP5tR4RIFdYUcMdheCrR1iSk=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=m2zu+FDbwrZpXceWxLip0IKjtKKH7UxiYNcgaXRsAvTC7wiCpSP98W/J7WSHgDWMJ
	 ZYZwH/eyLj12IhZb2/4qJsktBH+jtT/ck3BWIV4w+jAXK9V8qUvGSj9q2pWQVtp3Ui
	 UmYHs3LJ7Mq+T9XVWeO9XW/3WWpdXl9FL6mGUe02fnJ9z5k/uvMD9c+NWf8XRMEY3J
	 FCsRfQl7iqSPz876LJMIDBu6GQPVx5amHQUsGQyTocl5+y77YTJ5RNSHLHBYta764i
	 SBC4z+6ru6KBCWIP2eiADdWVkMQCgYtCBNsEadhZlSAw9OaZ0vWM6wtXcg/XM3aPE/
	 X1bK0DCXcNV6A==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 3/8] btrfs: pass a btrfs_inode to fixup_inode_link_count()
Date: Fri,  7 Mar 2025 13:44:20 +0000
Message-Id: <94678299e4a023e8e8322889cced2b701dc793e6.1741354479.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1741354476.git.fdmanana@suse.com>
References: <cover.1741354476.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

fixup_inode_link_count() mostly wants to use a btrfs_inode, plus it's an
internal function so it should take btrfs_inode instead of a VFS inode.
Change the argument type to btrfs_inode, avoiding several BTRFS_I() calls
too.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/tree-log.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 0df356e23762..349c9482e9b9 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -1610,25 +1610,25 @@ static int count_inode_refs(struct btrfs_inode *inode, struct btrfs_path *path)
  * will free the inode.
  */
 static noinline int fixup_inode_link_count(struct btrfs_trans_handle *trans,
-					   struct inode *inode)
+					   struct btrfs_inode *inode)
 {
-	struct btrfs_root *root = BTRFS_I(inode)->root;
+	struct btrfs_root *root = inode->root;
 	struct btrfs_path *path;
 	int ret;
 	u64 nlink = 0;
-	u64 ino = btrfs_ino(BTRFS_I(inode));
+	const u64 ino = btrfs_ino(inode);
 
 	path = btrfs_alloc_path();
 	if (!path)
 		return -ENOMEM;
 
-	ret = count_inode_refs(BTRFS_I(inode), path);
+	ret = count_inode_refs(inode, path);
 	if (ret < 0)
 		goto out;
 
 	nlink = ret;
 
-	ret = count_inode_extrefs(BTRFS_I(inode), path);
+	ret = count_inode_extrefs(inode, path);
 	if (ret < 0)
 		goto out;
 
@@ -1636,17 +1636,17 @@ static noinline int fixup_inode_link_count(struct btrfs_trans_handle *trans,
 
 	ret = 0;
 
-	if (nlink != inode->i_nlink) {
-		set_nlink(inode, nlink);
-		ret = btrfs_update_inode(trans, BTRFS_I(inode));
+	if (nlink != inode->vfs_inode.i_nlink) {
+		set_nlink(&inode->vfs_inode, nlink);
+		ret = btrfs_update_inode(trans, inode);
 		if (ret)
 			goto out;
 	}
-	if (S_ISDIR(inode->i_mode))
-		BTRFS_I(inode)->index_cnt = (u64)-1;
+	if (S_ISDIR(inode->vfs_inode.i_mode))
+		inode->index_cnt = (u64)-1;
 
-	if (inode->i_nlink == 0) {
-		if (S_ISDIR(inode->i_mode)) {
+	if (inode->vfs_inode.i_nlink == 0) {
+		if (S_ISDIR(inode->vfs_inode.i_mode)) {
 			ret = replay_dir_deletes(trans, root, NULL, path,
 						 ino, 1);
 			if (ret)
@@ -1702,7 +1702,7 @@ static noinline int fixup_inode_link_counts(struct btrfs_trans_handle *trans,
 			break;
 		}
 
-		ret = fixup_inode_link_count(trans, &inode->vfs_inode);
+		ret = fixup_inode_link_count(trans, inode);
 		iput(&inode->vfs_inode);
 		if (ret)
 			break;
-- 
2.45.2


