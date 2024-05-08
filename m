Return-Path: <linux-btrfs+bounces-4835-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAF738BFCF8
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 May 2024 14:17:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C08F285D11
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 May 2024 12:17:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3914784A39;
	Wed,  8 May 2024 12:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sE60Q8Ls"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67A5F8405C
	for <linux-btrfs@vger.kernel.org>; Wed,  8 May 2024 12:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715170657; cv=none; b=V7H3sy3+tnxLZH9GB33oIBoz+vjRNqyhyDObIugG11fDfhHZKYu3otrA00H4ntbJ79ZhkDH5NqWCP7WJL9IX2XpOM7wlr4TKjtObZc/857HfJl2vn3LbC5cznjnkDRVwODFfM3RrKqQi5GPmlwWYv9fYd8Kd2LPx360Fv/wbFDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715170657; c=relaxed/simple;
	bh=iQNe+PvtKbO1JDkFvIuzXNqeKwpNZ8IqIusUBnFkdos=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dJJjCipsCYJlm76A1LeYJFZjBj+KgY9k+HLaUpPPJSsGqLrENkUIov9LOtSeCwJBvf/aDNeSCsH1h0P7lVb9xG0WWKamfGgNuzoWJtpqdBssPWCuwjVTnaBwn0lqYhQE5zLFadFyXV0S24GamHhV9p/A0qc1DcvLkaiysu55uqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sE60Q8Ls; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81339C4AF18
	for <linux-btrfs@vger.kernel.org>; Wed,  8 May 2024 12:17:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715170657;
	bh=iQNe+PvtKbO1JDkFvIuzXNqeKwpNZ8IqIusUBnFkdos=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=sE60Q8LsJuGGpyD1bHlkpWCbHc5gwXOxyuaBRabarJWQSP1lQMJPRTlZTbmY5UEcc
	 ROhpmLcJxJWSPrSbOxwUMU4L3UEQMy6uucZgKx/cjV1wS9aDUA6IvaECDbXHLYUxB9
	 HmYm+WJQdtCzQDj11KeU6q8hDTqOmsitZv9nvcXkPuMxoXJa9gU8+GiUVA6U4DEgCw
	 lEQic+jVRFoc5hiQ9k9FzZGtQW92fULQR7hj65LZ0kYMjqBJSCtBdGwUW5pBztXpJB
	 nTpDhBA6b27n/dJpo1oRWML5lLWJkbz76YTRQVvIfQ7zIlEzP/EqIxCo548W0/n6YD
	 uvu6PkH49KScg==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 3/8] btrfs: reduce nesting and deduplicate error handling at btrfs_iget_path()
Date: Wed,  8 May 2024 13:17:26 +0100
Message-Id: <ca3427c0ca2b7984b0d074531cc31b0433b7eb56.1715169723.git.fdmanana@suse.com>
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

Make btrfs_iget_path() simpler and easier to read by avoiding nesting of
if-then-else statements and having an error label to do all the error
handling instead of repeating it a couple times.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/inode.c | 44 +++++++++++++++++++++-----------------------
 1 file changed, 21 insertions(+), 23 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 85dbc19c2f6f..8ea9fd4c2b66 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -5598,37 +5598,35 @@ struct inode *btrfs_iget_path(struct super_block *s, u64 ino,
 			      struct btrfs_root *root, struct btrfs_path *path)
 {
 	struct inode *inode;
+	int ret;
 
 	inode = btrfs_iget_locked(s, ino, root);
 	if (!inode)
 		return ERR_PTR(-ENOMEM);
 
-	if (inode->i_state & I_NEW) {
-		int ret;
+	if (!(inode->i_state & I_NEW))
+		return inode;
 
-		ret = btrfs_read_locked_inode(inode, path);
-		if (!ret) {
-			ret = btrfs_add_inode_to_root(BTRFS_I(inode), true);
-			if (ret) {
-				iget_failed(inode);
-				inode = ERR_PTR(ret);
-			} else {
-				unlock_new_inode(inode);
-			}
-		} else {
-			iget_failed(inode);
-			/*
-			 * ret > 0 can come from btrfs_search_slot called by
-			 * btrfs_read_locked_inode, this means the inode item
-			 * was not found.
-			 */
-			if (ret > 0)
-				ret = -ENOENT;
-			inode = ERR_PTR(ret);
-		}
-	}
+	ret = btrfs_read_locked_inode(inode, path);
+	/*
+	 * ret > 0 can come from btrfs_search_slot called by
+	 * btrfs_read_locked_inode(), this means the inode item was not found.
+	 */
+	if (ret > 0)
+		ret = -ENOENT;
+	if (ret < 0)
+		goto error;
+
+	ret = btrfs_add_inode_to_root(BTRFS_I(inode), true);
+	if (ret < 0)
+		goto error;
+
+	unlock_new_inode(inode);
 
 	return inode;
+error:
+	iget_failed(inode);
+	return ERR_PTR(ret);
 }
 
 struct inode *btrfs_iget(struct super_block *s, u64 ino, struct btrfs_root *root)
-- 
2.43.0


