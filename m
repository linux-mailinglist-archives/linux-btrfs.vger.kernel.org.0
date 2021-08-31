Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F29F13FC9C5
	for <lists+linux-btrfs@lfdr.de>; Tue, 31 Aug 2021 16:31:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237944AbhHaObs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 31 Aug 2021 10:31:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:58404 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237828AbhHaObq (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 31 Aug 2021 10:31:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 763BE600AA
        for <linux-btrfs@vger.kernel.org>; Tue, 31 Aug 2021 14:30:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630420250;
        bh=XRF600o6A/PvQFf/+F0MKImzSKzz71GLnlitR7hqoB4=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=rCmesXiEw8AhCy1PZ/KFZ7F92jLNcqQO+1Cn329zOw2EMhRTQwbUIhyYuuqLwlduX
         M3cn+TNjqJ5gFg+HnPBDEFdYFetEvAgwSbX5F7g13+3cvfPqEujwM5+ECiR4fhyeoP
         H3oR2osXHoIxf5/kqc/U33o7vtsObpo3ozMw7l27FcGOeX/yLNjwaQB3WkSh/c1EB0
         Y2lj9taqUJO8Aqv1+7a0+dp6SZgRUKdrTfMcDU3NDCnqM9jFNvPwaxaYZX9w5AR1yN
         dq11AEMXV90LX1LqyhvnyMegi4LBhXMJVKiyS0BjP79EwRKYsbvM/PS9keWUFTQdTq
         ApbZEP2tDPbXg==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 09/10] btrfs: avoid attempt to drop extents when logging inode for the first time
Date:   Tue, 31 Aug 2021 15:30:39 +0100
Message-Id: <1da6a60fec6fc1b9d612779b372fb07220a140ac.1630419897.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1630419897.git.fdmanana@suse.com>
References: <cover.1630419897.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

When logging an extent, in the fast fsync path, we always attempt do drop
or trim any existing extents with a range that match or overlap the range
of the extent we are about to log. We do that through a call to
btrfs_drop_extents().

However this is not needed when we are logging the inode for the first
time in the current transaction, since we have no inode items of the
inode in the log tree. Calling btrfs_drop_extents() does a deletion search
on the log tree, which is expensive when we have concurrent tasks
accessing the log tree because a deletion search always acquires a write
lock on the extent buffers at levels 2, 1 and 0, adding significant lock
contention, specially taking into account the height of a log tree rarely
(if ever) goes beyond 2 or 3, due to its short life.

So skip the call to btrfs_drop_extents() when the inode was not previously
logged in the current transaction.

This patch is part of a patch set comprised of the following patches:

  btrfs: check if a log tree exists at inode_logged()
  btrfs: remove no longer needed checks for NULL log context
  btrfs: do not log new dentries when logging that a new name exists
  btrfs: always update the logged transaction when logging new names
  btrfs: avoid expensive search when dropping inode items from log
  btrfs: add helper to truncate inode items when logging inode
  btrfs: avoid expensive search when truncating inode items from the log
  btrfs: avoid search for logged i_size when logging inode if possible
  btrfs: avoid attempt to drop extents when logging inode for the first time
  btrfs: do not commit delayed inode when logging a file in full sync mode

This is patch 9/10 and test results are listed in the change log of the
last patch in the set.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/tree-log.c | 27 +++++++++++++++++++--------
 1 file changed, 19 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 206268aa42a4..630660408c2e 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -4358,14 +4358,25 @@ static int log_one_extent(struct btrfs_trans_handle *trans,
 	if (ret)
 		return ret;
 
-	drop_args.path = path;
-	drop_args.start = em->start;
-	drop_args.end = em->start + em->len;
-	drop_args.replace_extent = true;
-	drop_args.extent_item_size = sizeof(*fi);
-	ret = btrfs_drop_extents(trans, log, inode, &drop_args);
-	if (ret)
-		return ret;
+	/*
+	 * If this is the first time we are logging the inode in the current
+	 * transaction, we can avoid btrfs_drop_extents(), which is expensive
+	 * because it does a deletion search, which always acquires write locks
+	 * for extent buffers at levels 2, 1 and 0. This not only wastes time
+	 * but also adds significant contention in a log tree, since log trees
+	 * are small, with a root at level 2 or 3 at most, due to their short
+	 * life span.
+	 */
+	if (inode_logged(trans, inode)) {
+		drop_args.path = path;
+		drop_args.start = em->start;
+		drop_args.end = em->start + em->len;
+		drop_args.replace_extent = true;
+		drop_args.extent_item_size = sizeof(*fi);
+		ret = btrfs_drop_extents(trans, log, inode, &drop_args);
+		if (ret)
+			return ret;
+	}
 
 	if (!drop_args.extent_inserted) {
 		key.objectid = btrfs_ino(inode);
-- 
2.28.0

