Return-Path: <linux-btrfs+bounces-5047-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B6F28C797E
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 May 2024 17:29:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1D7F1F21E11
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 May 2024 15:29:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B51F14E2DF;
	Thu, 16 May 2024 15:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DyYHz0JY"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 771E014E2CB
	for <linux-btrfs@vger.kernel.org>; Thu, 16 May 2024 15:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715873319; cv=none; b=rs7e3MbYPa0PXqC6P1jlHSjxaVkSdaHMIrXiZfrBLKdoFr44WIwVTWNDRGZQCCb9S5hdyYMGgEOZbvwXhBwVZ1jaUOWN/YVX724uBrCi6pTJHuTFpOzDpITg3jF7ttTyDmqH17j2Py/wjFO+f89wA4FPcOR/Vg5Qbmkb3xIG850=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715873319; c=relaxed/simple;
	bh=/pVNjv5or8dDAQgrN2LommAl5yCHdzkdpk299J3kpdk=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=kNgrsQSECT7tfAqLwObWq+1ONDGKa8m8NkTP0DwOxfd7hBIcUZ+H0PyZ7fD9CmVuM7+tbRB1vX5x2slThX0RVj7Q23sAdceRNrvD0g5tj2sXNxbU3UjWys2FHiSNgBmTd3lbzGe0bDSfpjBGP03U9TBa3t4c9Guez7DQS/jEfB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DyYHz0JY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0640C113CC
	for <linux-btrfs@vger.kernel.org>; Thu, 16 May 2024 15:28:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715873319;
	bh=/pVNjv5or8dDAQgrN2LommAl5yCHdzkdpk299J3kpdk=;
	h=From:To:Subject:Date:From;
	b=DyYHz0JYu711UqLmlxrQOrt1ONCB+sVHGRNVJP3nwk3r9lqPfv+b3Ul9DI5QmNoob
	 uhozZqcVPEi1jxfQ6QAvNi8+Pjdjiocw8T11MGwmgyrGlQz6cAoliL0RFWXXDpN47n
	 NNxRBJiNEx+UOZs+F8w6MHB/LACYXyZxi/J+L88OuRwtTcou2XvYk+yDOzVPvt1xJM
	 1naP+4MmMC2xdwgEfpH5btY/pFdtOZ/vQqeWRBTUbjm9jVmlWzfszAjvQcX3iCkbLl
	 6HiD+B0Efk/2+JNRCoYM5vH8UE7e6A1SgLCn7L62I2rTb1wYod0oQXYW7wPgiPRiuG
	 70GYGIfkt4CPg==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: always set an inode's delayed_inode with WRITE_ONCE()
Date: Thu, 16 May 2024 16:28:35 +0100
Message-Id: <a4dfaf8ca94754560f4d9196b04ba763256124ce.1715873248.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

Currently we have a couple places using READ_ONCE() to access an inode's
delayed_inode without taking the lock that protects the xarray for delayed
inodes, while all the other places access it while holding the lock.

However we never update the delayed_inode pointer of an inode with
WRITE_ONCE(), making the use of READ_ONCE() pointless since it should
always be paired with a WRITE_ONCE() in order to protect against issues
such as write tearing for example.

So change all the places that update struct btrfs_inode::delayed_inode to
use WRITE_ONCE() instead of simple assignments.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/delayed-inode.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/delayed-inode.c b/fs/btrfs/delayed-inode.c
index 483c141dc488..6df7e44d9d31 100644
--- a/fs/btrfs/delayed-inode.c
+++ b/fs/btrfs/delayed-inode.c
@@ -106,7 +106,7 @@ static struct btrfs_delayed_node *btrfs_get_delayed_node(
 		 */
 		if (refcount_inc_not_zero(&node->refs)) {
 			refcount_inc(&node->refs);
-			btrfs_inode->delayed_node = node;
+			WRITE_ONCE(btrfs_inode->delayed_node, node);
 		} else {
 			node = NULL;
 		}
@@ -161,7 +161,7 @@ static struct btrfs_delayed_node *btrfs_get_or_create_delayed_node(
 	ASSERT(xa_err(ptr) != -EINVAL);
 	ASSERT(xa_err(ptr) != -ENOMEM);
 	ASSERT(ptr == NULL);
-	btrfs_inode->delayed_node = node;
+	WRITE_ONCE(btrfs_inode->delayed_node, node);
 	xa_unlock(&root->delayed_nodes);
 
 	return node;
@@ -1312,7 +1312,7 @@ void btrfs_remove_delayed_node(struct btrfs_inode *inode)
 	if (!delayed_node)
 		return;
 
-	inode->delayed_node = NULL;
+	WRITE_ONCE(inode->delayed_node, NULL);
 	btrfs_release_delayed_node(delayed_node);
 }
 
-- 
2.43.0


