Return-Path: <linux-btrfs+bounces-4967-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD6528C57E3
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 May 2024 16:26:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 522C3B224EC
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 May 2024 14:26:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECE33145332;
	Tue, 14 May 2024 14:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K2mEq9D0"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 236BB144D0B
	for <linux-btrfs@vger.kernel.org>; Tue, 14 May 2024 14:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715696787; cv=none; b=FAcgCJFWtLWFjKV6M6ii6tsmfUAzi6UC5tSeA1jDdgXAiCt+URoFomTUhYar03j+H8YnNrZYRxjBJB++txMKj4WY4MlZ+dZlkRP7Q+sX8BvLbnjpMrOQ+oV+JcnWt2A3qcZ/ShAg8D82+kSay3hYTn2PdwgD4IhEg8RYw/H0p0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715696787; c=relaxed/simple;
	bh=jTQVtWggmLfd+kMGUaq+5pfrNCWOTOjqID9DM8nltgU=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=FOHZiQOo/9DPCNyeUFv8z7jWVH3O9ZcsoRArByE9GcMplp4qEyZCIqcnHIgJ4shhXw8v47EWrrihlFgGvig7h+d1oyAfTxC3E/YzcTT/xNZqHkF1i35ggErYeK04vX7SoHNjzyiimc/aICJk1r9NHL58wHrCrbhbhFIdNJJ2GWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K2mEq9D0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DC05C2BD10
	for <linux-btrfs@vger.kernel.org>; Tue, 14 May 2024 14:26:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715696786;
	bh=jTQVtWggmLfd+kMGUaq+5pfrNCWOTOjqID9DM8nltgU=;
	h=From:To:Subject:Date:From;
	b=K2mEq9D0ijZAJH2EiZRF6o0v4JKiKTwmVC4750mxnlTwsyGXjltb0jOPD+cGmJymz
	 /d4rUNytPKVUZ4W+esSUkAN72FQtJ1xAT+CMeUJdlSJJBSivkqdWpUP9nMhKoVIn4y
	 51kRhFFdIPkrFn74NO15WUko5pw8WxKXoNxEMZWbHNwoGO9k/WaAXnAG+tvRX6v7lL
	 /MnSdpgBifLE2Y3DVqW1N3LuH93pDmXqXSLEBes7YNbwl996Yu1akG83gzRiMkPw2+
	 XxQBScZNTud7EerMv4LlzwlxvKWPKe0JekyK+9snPovBUXn2iuiqhp6xd9Yj+kSwQS
	 fs6hLQTejOUpQ==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: fix function name in comment for btrfs_remove_ordered_extent()
Date: Tue, 14 May 2024 15:26:23 +0100
Message-Id: <4a9fa14f2211dfc080061f65c2b95b718aa608fa.1715689538.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

Due to a refactoring introduced by commit 53d9981ca20e ("btrfs: split
btrfs_alloc_ordered_extent to allocation and insertion helpers"), the
function btrfs_alloc_ordered_extent() was renamed to
alloc_ordered_extent(), so the comment at btrfs_remove_ordered_extent()
is no longer very accurate. Update the comment to refer to the new
name "alloc_ordered_extent()".

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/ordered-data.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
index a6c2b4e5edf1..d7c59bf924fd 100644
--- a/fs/btrfs/ordered-data.c
+++ b/fs/btrfs/ordered-data.c
@@ -595,7 +595,7 @@ void btrfs_remove_ordered_extent(struct btrfs_inode *btrfs_inode,
 	freespace_inode = btrfs_is_free_space_inode(btrfs_inode);
 
 	btrfs_lockdep_acquire(fs_info, btrfs_trans_pending_ordered);
-	/* This is paired with btrfs_alloc_ordered_extent. */
+	/* This is paired with alloc_ordered_extent(). */
 	spin_lock(&btrfs_inode->lock);
 	btrfs_mod_outstanding_extents(btrfs_inode, -1);
 	spin_unlock(&btrfs_inode->lock);
-- 
2.43.0


