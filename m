Return-Path: <linux-btrfs+bounces-4980-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 460148C5AAD
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 May 2024 19:55:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76F361C21CE3
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 May 2024 17:55:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEDB8180A77;
	Tue, 14 May 2024 17:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AmcjRQy6"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0396A1802B1
	for <linux-btrfs@vger.kernel.org>; Tue, 14 May 2024 17:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715709263; cv=none; b=l+0aeaTi5chq2OHddCthrVIF07Hryn4aJ8sHSlizkRzNPhHfNQ1AyX2C8R3nbq5RV5HDuVZqR7jD1EHJC+vjuKpCdzcz/rmbZCSHz+ZG7lHW3hvZQtSXAI+BYWd9puIAnfQ5Q8gecsLCRFST3G+3ZDAHOCUv4TzZ+Tlsg+g6nss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715709263; c=relaxed/simple;
	bh=2dlUxuEK3lcHDYIe8ofm/sj97QtYY5Zus/jd/IJjKk4=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Sud/l6b4blTMGSOVfgfv2l6bvuu4eHupsjjLwrPIArs3aJDT03bq0Hl6XhslTRvLMFHJyeAssKVJutkm0/JXV/rTl2hb0V+OPnReeKEDsxSL9wL28GOMU0ryjPWNY40Mnbx8yWVr0Se0aneB4YWK8dMEWODinsQqQWaNEBTSShw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AmcjRQy6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09AA7C2BD10
	for <linux-btrfs@vger.kernel.org>; Tue, 14 May 2024 17:54:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715709262;
	bh=2dlUxuEK3lcHDYIe8ofm/sj97QtYY5Zus/jd/IJjKk4=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=AmcjRQy6NZHzF2HWJT64VBZOkgdilDG7tyZIia/YBFt0z3OMe6p0sCcBJ93HITmAT
	 A1s09f463/4XL9cCKzQYwQSUx6C1riSLCSwv9MwN44ZvgFukegYziHyuuSaTRSHxex
	 hsYAbRCvrJwiWBsTDowXNP/qalIrPMcQ2Kn5+b+fA82H/gfKuH+X/OOh1QAG+yeyHf
	 WqQMFEeGb4qg1ntJ3nLhwCtR2BbO0Eh5IQRq8RgULK6fzHERS6DYPDi5OWzeUxQHz4
	 KHloqFsM1x1tNMTEtCbfDc9aXY8i8dA/Ad73XtIcDHFWi/3FCK0LGNCtyYnITw+0LA
	 6sYNOpIdFuPGg==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2] btrfs: reduce ordered_extent_lock section at btrfs_split_ordered_extent()
Date: Tue, 14 May 2024 18:54:18 +0100
Message-Id: <6bd1663678f119791c1e2b6071f4973f35dcf049.1715708811.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <719ec85c5bda1d711067e5b1c20a2de336240140.1715688262.git.fdmanana@suse.com>
References: <719ec85c5bda1d711067e5b1c20a2de336240140.1715688262.git.fdmanana@suse.com>
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
 fs/btrfs/ordered-data.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

V2: Fix a bug where we woudn't disable irqs when taking the inode's
    ordered tree lock. Often triggered with generic/208.

diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
index c5bdd674f55c..e6025d9645f5 100644
--- a/fs/btrfs/ordered-data.c
+++ b/fs/btrfs/ordered-data.c
@@ -1181,8 +1181,7 @@ struct btrfs_ordered_extent *btrfs_split_ordered_extent(
 	/* One ref for the tree. */
 	refcount_inc(&new->refs);
 
-	spin_lock_irq(&root->ordered_extent_lock);
-	spin_lock(&inode->ordered_tree_lock);
+	spin_lock_irq(&inode->ordered_tree_lock);
 	/* Remove from tree once */
 	node = &ordered->rb_node;
 	rb_erase(node, &inode->ordered_tree);
@@ -1232,8 +1231,9 @@ struct btrfs_ordered_extent *btrfs_split_ordered_extent(
 		btrfs_panic(fs_info, -EEXIST,
 			"zoned: inconsistency in ordered tree at offset %llu",
 			new->file_offset);
-	spin_unlock(&inode->ordered_tree_lock);
+	spin_unlock_irq(&inode->ordered_tree_lock);
 
+	spin_lock_irq(&root->ordered_extent_lock);
 	list_add_tail(&new->root_extent_list, &root->ordered_extents);
 	root->nr_ordered_extents++;
 	spin_unlock_irq(&root->ordered_extent_lock);
-- 
2.43.0


