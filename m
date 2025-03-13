Return-Path: <linux-btrfs+bounces-12276-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55C25A5FEAC
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Mar 2025 18:56:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A5DD17C98F
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Mar 2025 17:56:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F117D1EEA51;
	Thu, 13 Mar 2025 17:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V+3XtUqJ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43E6B1E9B03
	for <linux-btrfs@vger.kernel.org>; Thu, 13 Mar 2025 17:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741888548; cv=none; b=oa2wv6tKP7g15keT90Axq9EG6jAxBsYLEw4Rs4hLUB2z7+mfwQMYAu8OaxPFVqvM0oClqK/ps0YFnj1flSlmgnUoAf9lJz1x/DGZBo0rpyF6hdYSpf0gnjeR1iMnzDRVINv474zKmNQNgYCXgwDw7v9V9b6MWa8DGYcp5PoK3rI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741888548; c=relaxed/simple;
	bh=nOaoOzUG+UuZp3b1Q0pDG9qarC1xRMuvWMcuJeOhByc=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QfClizEgnJqJZnZNrr2rGWPiAweV3FUqnSpbEk2kP5NjDgh9+FO0iPhcXyCbFqoKn8oQMRxPKWdy3v11WeqLiSUojAggLs/QKHxd2xM/gUn6oqPmIWUsiwbT6GufKWq8MVHchCorkTbBpsqz+AI6fCpxLrxkffWWAh+PPXfoO8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V+3XtUqJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36EBCC4CEDD
	for <linux-btrfs@vger.kernel.org>; Thu, 13 Mar 2025 17:55:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741888547;
	bh=nOaoOzUG+UuZp3b1Q0pDG9qarC1xRMuvWMcuJeOhByc=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=V+3XtUqJSAkv4HDObKeMULZImdWcJTQmxmdIzllkBQZACO7I8IJ6KSk/kN1RXQ3mN
	 ODKSAkZ/5d3WUM1Wvi6Le14OlyFQLqweqyLmrxPcr4zqUj+LJxH5gI4I7DO2EGXTI/
	 Kpu8CIyrq74ZKFvFGQouAKFNr0E/ru86L1XGAco51oQtE5UMGiMt1AbvBzG+wwm6Q2
	 2ay53WxcekVZUKaf3ctv+M3IyjD+tj+t9D4NeW3YiLmuDX6PFbnLrjVljGvobPMc9L
	 HeXW9YxelF6IGcym8m0kQ3AppRLnQKt2o5t506mQ9D2By/a/+GzXfJqBt0lRZECTnm
	 M3/PLn4JfWDjg==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 7/7] btrfs: remove end_no_trans label from btrfs_log_inode_parent()
Date: Thu, 13 Mar 2025 17:55:37 +0000
Message-Id: <97d14290bfd4ad71700c43e73ac887a92f745bd1.1741887950.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1741887949.git.fdmanana@suse.com>
References: <cover.1741887949.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

It's a pointless label as we don't have to do anything under it other
than return from the function. So remove it and directly return from the
function where we used to goto.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/tree-log.c | 28 ++++++++++------------------
 1 file changed, 10 insertions(+), 18 deletions(-)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 6bc9f5f32393..90dc094cfa5e 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -7038,24 +7038,18 @@ static int btrfs_log_inode_parent(struct btrfs_trans_handle *trans,
 	int ret = 0;
 	bool log_dentries;
 
-	if (btrfs_test_opt(fs_info, NOTREELOG)) {
-		ret = BTRFS_LOG_FORCE_COMMIT;
-		goto end_no_trans;
-	}
+	if (btrfs_test_opt(fs_info, NOTREELOG))
+		return BTRFS_LOG_FORCE_COMMIT;
 
-	if (btrfs_root_refs(&root->root_item) == 0) {
-		ret = BTRFS_LOG_FORCE_COMMIT;
-		goto end_no_trans;
-	}
+	if (btrfs_root_refs(&root->root_item) == 0)
+		return BTRFS_LOG_FORCE_COMMIT;
 
 	/*
 	 * If we're logging an inode from a subvolume created in the current
 	 * transaction we must force a commit since the root is not persisted.
 	 */
-	if (btrfs_root_generation(&root->root_item) == trans->transid) {
-		ret = BTRFS_LOG_FORCE_COMMIT;
-		goto end_no_trans;
-	}
+	if (btrfs_root_generation(&root->root_item) == trans->transid)
+		return BTRFS_LOG_FORCE_COMMIT;
 
 	/*
 	 * Skip already logged inodes or inodes corresponding to tmpfiles
@@ -7064,14 +7058,12 @@ static int btrfs_log_inode_parent(struct btrfs_trans_handle *trans,
 	 */
 	if ((btrfs_inode_in_log(inode, trans->transid) &&
 	     list_empty(&ctx->ordered_extents)) ||
-	    inode->vfs_inode.i_nlink == 0) {
-		ret = BTRFS_NO_LOG_SYNC;
-		goto end_no_trans;
-	}
+	    inode->vfs_inode.i_nlink == 0)
+		return BTRFS_NO_LOG_SYNC;
 
 	ret = start_log_trans(trans, root, ctx);
 	if (ret)
-		goto end_no_trans;
+		return ret;
 
 	ret = btrfs_log_inode(trans, inode, inode_only, ctx);
 	if (ret)
@@ -7158,7 +7150,7 @@ static int btrfs_log_inode_parent(struct btrfs_trans_handle *trans,
 	if (ret)
 		btrfs_remove_log_ctx(root, ctx);
 	btrfs_end_log_trans(root);
-end_no_trans:
+
 	return ret;
 }
 
-- 
2.45.2


