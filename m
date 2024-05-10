Return-Path: <linux-btrfs+bounces-4897-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBE5D8C2953
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 May 2024 19:33:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0960F1C21DDD
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 May 2024 17:33:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75BFA18EA1;
	Fri, 10 May 2024 17:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AgmRU23g"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A06E21E525
	for <linux-btrfs@vger.kernel.org>; Fri, 10 May 2024 17:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715362384; cv=none; b=mn6DaWBb/zrt1cjWngh0O/VN6QAr/1OAxy6743HbL4e5EZIIAlDJ96TAM7jvRzR1dxWTnT4xTtRl/IwfWg+wU5C0hhiZX2khT/rqxIX/uNNaSq6JyY6bbMY5kl3tOjqPgixaacnblLWV60qkg1FBf9B3NWixMuCp0Xz9d02Fgk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715362384; c=relaxed/simple;
	bh=ScWppywJ/FMRvZpW/hyxffNOL2qRQVWnOywFtCydsQ4=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OcU1v02c9AKsJHBQz2215vK8mG6kdifRbRH7XiyZH+p7SXaN5Spx+tlY/vivaJm+JbzPazND6Gamj2Fmkew3XruKgj4q3HdCAGJlnPYtM7cHngTXJ0Ra9W8c2Oz45zzDpHzivcTW5O0oOgfV7UEZkMLknErJzR5iyVlCaRSEYRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AgmRU23g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04FD3C113CC
	for <linux-btrfs@vger.kernel.org>; Fri, 10 May 2024 17:33:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715362384;
	bh=ScWppywJ/FMRvZpW/hyxffNOL2qRQVWnOywFtCydsQ4=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=AgmRU23gK2xCnyRRlIbiXHrFLY2WTPoaIQTTqKeWMTllM76AlWS5NdGlpPnQD0A4o
	 vXzxnijCEatIL/Xo8EhPTZ5Scp2Mq1dmA4nkrznSYxkxIXrVrI6H3W9KZFIkuqJYwq
	 yODCYDKSxfdCsE5IHRLLukwfOZzO9JKK7GStIC5K2d2oSyieQe6Ujt07f8Gp6A2t7P
	 K2k2MWaJV1KSo7M/Z9RYcKCOamncpr4yNHeKESVJ1xjjLksTuam1A2+8xTnMJUDHcq
	 4K6LRAbr0xAU6nNFnEUUmNh4iZNMtafkmidCvZTnMghAMIMsRPltiUT0qL8UalcJzs
	 hvbDfpy7OGXUQ==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 03/10] btrfs: reduce nesting and deduplicate error handling at btrfs_iget_path()
Date: Fri, 10 May 2024 18:32:51 +0100
Message-Id: <de74190d6432cd9d12fae793bdadbc409058c09f.1715362104.git.fdmanana@suse.com>
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

Make btrfs_iget_path() simpler and easier to read by avoiding nesting of
if-then-else statements and having an error label to do all the error
handling instead of repeating it a couple times.

Reviewed-by: Qu Wenruo <wqu@suse.com>
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


