Return-Path: <linux-btrfs+bounces-4968-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DE618C57E7
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 May 2024 16:28:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BC186B212CA
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 May 2024 14:28:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B09C145321;
	Tue, 14 May 2024 14:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CuUD0zhL"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B72B51411DC
	for <linux-btrfs@vger.kernel.org>; Tue, 14 May 2024 14:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715696917; cv=none; b=pTk3Ps1/r3kXlE/2dHUKnzbKtjNZelFehvdRyO4wzFExb0GJrRpwu/q4xugFOP3bA9iL7uYE9ofiD9Y2YorhZxBd62s/LyKZfcgYXBcxjxYRRXfrJZYpRAiNlkfpWJmO9M/vRI6RWCIfTb/0auhiGwGHcxfxvYzmgTDf1pvJqEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715696917; c=relaxed/simple;
	bh=/QUqOBF20epiAtvFRsQP7DI6vEu38Y9pWlIHYiwTkdA=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=IYsiLJL5l/xQiubHu+lrgnYJMRFhBjkR38ynHtPVtNJ4htcxqKe8qAsf1JKYs3Xtd1dZc6gP2D/xlcLjIK+bofEqp5k3la0xcUABl1cCzkPf4/D8MusTFsjNKMfzwMgJ1ml4czVX02G2QR5AKXcVFESP79WyR9yNJ0JoLa6WGHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CuUD0zhL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10A80C2BD10
	for <linux-btrfs@vger.kernel.org>; Tue, 14 May 2024 14:28:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715696917;
	bh=/QUqOBF20epiAtvFRsQP7DI6vEu38Y9pWlIHYiwTkdA=;
	h=From:To:Subject:Date:From;
	b=CuUD0zhL2gj1enLXoAOniAcGB90tHNqPX8+UVHZspnuXWnqDVv44ePD2+w8Z9WHzt
	 VPjr0rszGsNroi7Hgee2e5mGopGyYVONhTAt6vyHxVKFkzk0an0nBoocU7wX9fXSOw
	 u0cs6F+UNP6kX+Aa+xwEJ7g1Z0B9t8aF8payXdxiyGjy1ZK8ZWyZ/OA7Ho7GpgQRSD
	 fFcn6rXQvbUxo2ibS20/h3jmxoxf5lPv7hjkH2phjhWVvP3dxVF+IzUZKcqr90TTed
	 gkQdPjCjv96AkaRbjjcEn6sjlENjbAWSt9c2CycgjASwstUs5kYB9uP/rNK071Q4jH
	 PZ2rByS5Gxt6g==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: reduce ordered_extent_lock section at btrfs_split_ordered_extent()
Date: Tue, 14 May 2024 15:28:34 +0100
Message-Id: <719ec85c5bda1d711067e5b1c20a2de336240140.1715688262.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

There's no need to hold the root's ordered_extent_lock for so long at
btrfs_split_ordered_extent(). We don't need to hold it in order to modify
the inode's rb tree of ordered extents, to modify the trimmed ordered
extent and move checksums between the trimmed and the new ordered extent.
That's only increasing contention of the root's ordered_extent_lock for
other writes that are starting or completing.

So lock the root's ordered_extent_lock only before we add the new ordered
extent to the root's ordered list and increment the root's counter for the
number of ordered extents.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/ordered-data.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
index c5bdd674f55c..a6c2b4e5edf1 100644
--- a/fs/btrfs/ordered-data.c
+++ b/fs/btrfs/ordered-data.c
@@ -1181,7 +1181,6 @@ struct btrfs_ordered_extent *btrfs_split_ordered_extent(
 	/* One ref for the tree. */
 	refcount_inc(&new->refs);
 
-	spin_lock_irq(&root->ordered_extent_lock);
 	spin_lock(&inode->ordered_tree_lock);
 	/* Remove from tree once */
 	node = &ordered->rb_node;
@@ -1234,6 +1233,7 @@ struct btrfs_ordered_extent *btrfs_split_ordered_extent(
 			new->file_offset);
 	spin_unlock(&inode->ordered_tree_lock);
 
+	spin_lock_irq(&root->ordered_extent_lock);
 	list_add_tail(&new->root_extent_list, &root->ordered_extents);
 	root->nr_ordered_extents++;
 	spin_unlock_irq(&root->ordered_extent_lock);
-- 
2.43.0


