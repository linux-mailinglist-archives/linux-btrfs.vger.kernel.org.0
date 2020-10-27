Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1024129AC48
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Oct 2020 13:40:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2900089AbgJ0MkP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 27 Oct 2020 08:40:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:44532 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2900085AbgJ0MkK (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 27 Oct 2020 08:40:10 -0400
Received: from localhost.localdomain (bl8-197-74.dsl.telepac.pt [85.241.197.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5026F21D24
        for <linux-btrfs@vger.kernel.org>; Tue, 27 Oct 2020 12:40:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603802409;
        bh=mzIllUBEhzDbXuFkhCppl+DpxXYVdBMYtzu/WtjuHjI=;
        h=From:To:Subject:Date:From;
        b=SUZOtJ0DTINUaxLQfnJy3PH8sb3WQqxt/Ou4ilyQX1Srv8GQcs7Q/GVU0Cbtcaq/n
         d5ptxgb28WQO3DlbKKQECEIM/5JQOwBWWissR67+Ys0/kkkAOYz/cIunBYRXoxwPq/
         vlvjbdQO/5xvfjXeaBVxmd8RRaTpgXJBQHvOijhY=
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: do not start and wait for delalloc on snapshot roots on transaction commit
Date:   Tue, 27 Oct 2020 12:40:06 +0000
Message-Id: <bb2b1573dc60b8e743e8675fab5a13c15e7dcc85.1603802247.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

We do not need anymore to start writeback for delalloc of roots that are
being snapshoted and wait for it to complete. This was done in commit
609e804d771f59 ("Btrfs: fix file corruption after snapshotting due to mix
of buffered/DIO writes") to fix a type of file corruption where files in a
snapshot end up having their i_size updated in a non-ordered way, leaving
implicit file holes, when buffered IO writes that increase a file's size
are followed by direct IO writes that also increase the file's size.

This is not needed anymore because we now have a more generic mechanism
to prevent a non-ordered i_size update since commit 9ddc959e802bf7
("btrfs: use the file extent tree infrastructure"), which addresses this
scenario involving snapshots as well.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/transaction.c | 49 ++++++------------------------------------
 1 file changed, 6 insertions(+), 43 deletions(-)

diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index 52ada47aff50..8f70d7135497 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -1956,10 +1956,8 @@ static void btrfs_cleanup_pending_block_groups(struct btrfs_trans_handle *trans)
        }
 }
 
-static inline int btrfs_start_delalloc_flush(struct btrfs_trans_handle *trans)
+static inline int btrfs_start_delalloc_flush(struct btrfs_fs_info *fs_info)
 {
-	struct btrfs_fs_info *fs_info = trans->fs_info;
-
 	/*
 	 * We use writeback_inodes_sb here because if we used
 	 * btrfs_start_delalloc_roots we would deadlock with fs freeze.
@@ -1969,50 +1967,15 @@ static inline int btrfs_start_delalloc_flush(struct btrfs_trans_handle *trans)
 	 * from already being in a transaction and our join_transaction doesn't
 	 * have to re-take the fs freeze lock.
 	 */
-	if (btrfs_test_opt(fs_info, FLUSHONCOMMIT)) {
+	if (btrfs_test_opt(fs_info, FLUSHONCOMMIT))
 		writeback_inodes_sb(fs_info->sb, WB_REASON_SYNC);
-	} else {
-		struct btrfs_pending_snapshot *pending;
-		struct list_head *head = &trans->transaction->pending_snapshots;
-
-		/*
-		 * Flush dellaloc for any root that is going to be snapshotted.
-		 * This is done to avoid a corrupted version of files, in the
-		 * snapshots, that had both buffered and direct IO writes (even
-		 * if they were done sequentially) due to an unordered update of
-		 * the inode's size on disk.
-		 */
-		list_for_each_entry(pending, head, list) {
-			int ret;
-
-			ret = btrfs_start_delalloc_snapshot(pending->root);
-			if (ret)
-				return ret;
-		}
-	}
 	return 0;
 }
 
-static inline void btrfs_wait_delalloc_flush(struct btrfs_trans_handle *trans)
+static inline void btrfs_wait_delalloc_flush(struct btrfs_fs_info *fs_info)
 {
-	struct btrfs_fs_info *fs_info = trans->fs_info;
-
-	if (btrfs_test_opt(fs_info, FLUSHONCOMMIT)) {
+	if (btrfs_test_opt(fs_info, FLUSHONCOMMIT))
 		btrfs_wait_ordered_roots(fs_info, U64_MAX, 0, (u64)-1);
-	} else {
-		struct btrfs_pending_snapshot *pending;
-		struct list_head *head = &trans->transaction->pending_snapshots;
-
-		/*
-		 * Wait for any dellaloc that we started previously for the roots
-		 * that are going to be snapshotted. This is to avoid a corrupted
-		 * version of files in the snapshots that had both buffered and
-		 * direct IO writes (even if they were done sequentially).
-		 */
-		list_for_each_entry(pending, head, list)
-			btrfs_wait_ordered_extents(pending->root,
-						   U64_MAX, 0, U64_MAX);
-	}
 }
 
 int btrfs_commit_transaction(struct btrfs_trans_handle *trans)
@@ -2150,7 +2113,7 @@ int btrfs_commit_transaction(struct btrfs_trans_handle *trans)
 
 	extwriter_counter_dec(cur_trans, trans->type);
 
-	ret = btrfs_start_delalloc_flush(trans);
+	ret = btrfs_start_delalloc_flush(fs_info);
 	if (ret)
 		goto cleanup_transaction;
 
@@ -2166,7 +2129,7 @@ int btrfs_commit_transaction(struct btrfs_trans_handle *trans)
 	if (ret)
 		goto cleanup_transaction;
 
-	btrfs_wait_delalloc_flush(trans);
+	btrfs_wait_delalloc_flush(fs_info);
 
 	/*
 	 * Wait for all ordered extents started by a fast fsync that joined this
-- 
2.28.0

