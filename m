Return-Path: <linux-btrfs+bounces-15893-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B7EF8B1C4A4
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Aug 2025 13:11:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3B3B560C0C
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Aug 2025 11:11:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1576528B3F9;
	Wed,  6 Aug 2025 11:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qe+jSYTh"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ECFC28A72E
	for <linux-btrfs@vger.kernel.org>; Wed,  6 Aug 2025 11:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754478698; cv=none; b=GdRZ9o5PHa6VP0oD6eQG7RSsS/M6ronq6rhMdNlPEuj1Kg+1h5a004AHc4wol9QQYy7j/7smDQsQTILbwUknVKrR7cXhZIwSHbg67pQYG2aHsz6egHkkiF0hbImMTOZ4aPM3+nztr22jcMk6BsBsvUQN0DDcIZWKjUju+kzgw/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754478698; c=relaxed/simple;
	bh=2HYyX4CaBvgWRis/4zLQ6+MC3Y74r2lgjkANKwSODQs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O+YxRMcL+OUYp+YuKnHFP2XM/59ZninAd8PVECTF5RUcQQwyXaE0Bt+Z7G7OQ1gsRt/Fw8Bp34/4ckD+hk82c0g2EKNfa+tQZyXMlR8Vti9IAbEZHMSmoHPuB/HzDO9fwV3rmdHYHQvizu/OtkJ97Yvfq+OMtzRyaHETH5lvWp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qe+jSYTh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B41E2C4CEF6
	for <linux-btrfs@vger.kernel.org>; Wed,  6 Aug 2025 11:11:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754478698;
	bh=2HYyX4CaBvgWRis/4zLQ6+MC3Y74r2lgjkANKwSODQs=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=Qe+jSYThJGhGsDlI+53N6FyW6JtRGcoccovd0HZPLNM9m7Q6roCxbwH8uqeHlpMgT
	 JOOhkdsQ0rl+p3tq7cplS4gvkPGS25CS+vY641lHInkq3NJOYpjamI4wyTXoP1sFk0
	 rbNJIaK2k6TTREs+xSHUOSzKtXy8SWhB0tRviI+6MAkuQZt26itjyrqv0MEvNCx1kV
	 uTb3ksmCtWkHAVHId/pMostTgRk6bgVIsGwECQagmfx83Gfrx8XIjuXZMODBf0U3iG
	 6fLLFOGsQCDQ6jBcuJOTu7SJf3vY7+sZdV2ugTHJz3u1qW5Efmvs7/RFIz/u+1aOp6
	 vsMBzIgbeC5zw==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 1/3] btrfs: fix race between logging inode and checking if it was logged before
Date: Wed,  6 Aug 2025 12:11:30 +0100
Message-ID: <9ea30a4ed099801ad98010b29c43d8d9ee7ceac3.1754432806.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.1754432805.git.fdmanana@suse.com>
References: <cover.1754432805.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

There's a race between checking if an inode was logged before and logging
an inode that can cause us to mark an inode as not logged just after it
was logged by a concurrent task:

1) We have inode X which was not logged before neither in the current
   transaction not in past transaction since the inode was loaded into
   memory, so it's ->logged_trans value is 0;

2) We are at transaction N;

3) Task A calls inode_logged() against inode X, sees that ->logged_trans
   is 0 and there is a log tree and so it proceeds to search in the log
   tree for an inode item for inode X. It doesn't see any, but before
   it sets ->logged_trans to N - 1...

3) Task B calls btrfs_log_inode() against inode X, logs the inode and
   sets ->logged_trans to N;

4) Task A now sets ->logged_trans to N - 1;

5) At this point anyone calling inode_logged() gets 0 (inode not logged)
   since ->logged_trans is greater than 0 and less than N, but our inode
   was really logged. As a consequence operations like rename, unlink and
   link that happen afterwards in the current transaction end up not
   updating the log when they should.

Fix this by ensuring inode_logged() only updates ->logged_trans in case
the inode item is not found in the log tree if after tacking the inode's
lock (spinlock struct btrfs_inode::lock) the ->logged_trans value is still
zero, since the inode lock is what protects setting ->logged_trans at
btrfs_log_inode().

Fixes: 0f8ce49821de ("btrfs: avoid inode logging during rename and link when possible")
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/tree-log.c | 36 ++++++++++++++++++++++++++++++------
 1 file changed, 30 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 0f3f4de9ca9c..3d8090bc4b4e 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -3489,6 +3489,31 @@ int btrfs_free_log_root_tree(struct btrfs_trans_handle *trans,
 	return 0;
 }
 
+static bool mark_inode_as_not_logged(const struct btrfs_trans_handle *trans,
+				     struct btrfs_inode *inode)
+{
+	bool ret = false;
+
+	/*
+	 * Do this only if ->logged_trans is still 0 to prevent races with
+	 * concurrent logging as we may see the inode not logged when
+	 * inode_logged() is called but it gets logged after inode_logged() did
+	 * not find it in the log tree and we end up setting ->logged_trans to a
+	 * value less than trans->transid after the concurrent logging task has
+	 * set it to trans->transid. As a consequence, subsequent rename, unlink
+	 * and link operations may end up not logging new names and removing old
+	 * names from the log.
+	 */
+	spin_lock(&inode->lock);
+	if (inode->logged_trans == 0)
+		inode->logged_trans = trans->transid - 1;
+	else if (inode->logged_trans == trans->transid)
+		ret = true;
+	spin_unlock(&inode->lock);
+
+	return ret;
+}
+
 /*
  * Check if an inode was logged in the current transaction. This correctly deals
  * with the case where the inode was logged but has a logged_trans of 0, which
@@ -3523,10 +3548,8 @@ static int inode_logged(const struct btrfs_trans_handle *trans,
 	 * transaction's ID, to avoid the search below in a future call in case
 	 * a log tree gets created after this.
 	 */
-	if (!test_bit(BTRFS_ROOT_HAS_LOG_TREE, &inode->root->state)) {
-		inode->logged_trans = trans->transid - 1;
-		return 0;
-	}
+	if (!test_bit(BTRFS_ROOT_HAS_LOG_TREE, &inode->root->state))
+		return mark_inode_as_not_logged(trans, inode);
 
 	/*
 	 * We have a log tree and the inode's logged_trans is 0. We can't tell
@@ -3580,8 +3603,7 @@ static int inode_logged(const struct btrfs_trans_handle *trans,
 		 * Set logged_trans to a value greater than 0 and less then the
 		 * current transaction to avoid doing the search in future calls.
 		 */
-		inode->logged_trans = trans->transid - 1;
-		return 0;
+		return mark_inode_as_not_logged(trans, inode);
 	}
 
 	/*
@@ -3589,7 +3611,9 @@ static int inode_logged(const struct btrfs_trans_handle *trans,
 	 * the current transacion's ID, to avoid future tree searches as long as
 	 * the inode is not evicted again.
 	 */
+	spin_lock(&inode->lock);
 	inode->logged_trans = trans->transid;
+	spin_unlock(&inode->lock);
 
 	/*
 	 * If it's a directory, then we must set last_dir_index_offset to the
-- 
2.47.2


