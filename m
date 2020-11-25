Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D1812C3FCD
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Nov 2020 13:19:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729114AbgKYMTh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 25 Nov 2020 07:19:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:44972 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725616AbgKYMTh (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 25 Nov 2020 07:19:37 -0500
Received: from localhost.localdomain (bl8-197-74.dsl.telepac.pt [85.241.197.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4329C206F9
        for <linux-btrfs@vger.kernel.org>; Wed, 25 Nov 2020 12:19:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606306776;
        bh=9x+n3sq6dnlPWFSJOyBEQEIlVkJZTeP3Afd1Ru3ddu0=;
        h=From:To:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=iu1l6RkvCcZkyfrnE2BDYfic8Hi6p37Ch918zcyoKcRnikm8VexK7dNNpLEzisys9
         dQOYYZ+APZrewoD8Y4bmhmOqifmh9QPZG7kaIh0gnjpG/Gjbo8fT0hmeb6tMArkBIN
         licidtMxGIE9KtF/kwVa0DRfVnooElq6VBUygsEI=
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 5/6] btrfs: fix race leading to unnecessary transaction commit when logging inode
Date:   Wed, 25 Nov 2020 12:19:27 +0000
Message-Id: <854ce34eb81dff111952dd5937bc4afdaa41e25e.1606305501.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1606305501.git.fdmanana@suse.com>
References: <cover.1606305501.git.fdmanana@suse.com>
In-Reply-To: <cover.1606305501.git.fdmanana@suse.com>
References: <cover.1606305501.git.fdmanana@suse.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

When logging an inode we may often have to fallback to a full transaction
commit, either because a new block group was allocated, there is some case
we can not deal with wihout a transaction commit or some error like an
-ENOMEM happened. However after we fallback to a transaction commit, we
have a time window where we can make the next attempt to log any inode
commit the next transaction unnecessarily, adding additional overhead and
increasing latency.

A sequence of steps that leads to this issue is the following:

1) The current open transaction has a generation of 1000;

2) A new block group is allocated, and as a consequence we must make sure
   any attempts to commit a log fallback to a transaction commit, so
   btrfs_set_log_full_commit() is called from btrfs_make_block_group().
   This sets fs_info->last_trans_log_full_commit to 1000;

3) Task A is holding a handle on transaction 1000 and tries to log inode X.
   Once it gets to start_log_trans(), it calls btrfs_need_log_full_commit()
   which returns true, since fs_info->last_trans_log_full_commit has a
   value of 1000. So we end up returning -EAGAIN and propagating it up to
   btrfs_sync_file(), where we commit transaction 1000;

4) The transaction commit task (task A) sets the tansaction state to
   unblocked (TRANS_STATE_UNBLOCKED);

5) Some other task, task B, starts a new transaction with a generation of
   1001;

6) Some stuff is done with transaction 1001, some btree blocks COWed, etc;

7) Transaction 1000 has not fully committed yet, we are still writing all
   the extent buffers it created;

8) Some new task, task C, starts an fsync of inode Y, gets a handle for
   transaction 1001, and it gets to btrfs_log_inode_parent() which does
   the following check:

     if (fs_info->last_trans_log_full_commit > last_committed) {
         ret = 1;
         goto end_no_trans;
     }

   At that point last_trans_log_full_commit has a value of 1000 and
   last_committed (value of fs_info->last_trans_committed) has a value of
   999, since transaction 1000 has not yet committed - it is either still
   writing out dirty extent buffers, its super blocks or unpinning
   extents.

   As a consequence we return 1, which gets propagated up to
   btrfs_sync_file(), which will then call btrfs_commit_transaction()
   for transaction 1001.

   As a consequence we have an unnecessary second transaction commit, we
   previously committed transaction 1000 and now commit transaction 1001
   as well, resulting in more overhead and increased latency.

So fix this double transaction commit issue simply by removing that check,
because all we need to do is wait for the previous transaction to finish
its commit, which we already do later when starting the log transaction at
start_log_trans(), because there we acquire the tree_log_mutex lock, which
is held by a transaction commit and only released after the transaction
commits its super blocks.

Another issue that check has is that it reads last_trans_log_full_commit
without using READ_ONCE(), which is incorrect since that member of
struct btrfs_fs_info is always updated with WRITE_ONCE() through the
helper btrfs_set_log_full_commit().

This double transaction commit issue can actually be triggered quite often
in long runs of dbench, since besides the creation of new block groups
that force inode logging to fallback to a transaction commit, there are
cases where dbench asks to fsync a directory which had files in it that
were previously renamed or subdirectories that were removed, resulting in
the inode logging to fallback to a full transaction commit.

This patch belongs to a patch set that is comprised of the following
patches:

  btrfs: fix race causing unnecessary inode logging during link and rename
  btrfs: fix race that results in logging old extents during a fast fsync
  btrfs: fix race that causes unnecessary logging of ancestor inodes
  btrfs: fix race that makes inode logging fallback to transaction commit
  btrfs: fix race leading to unnecessary transaction commit when logging inode
  btrfs: do not block inode logging for so long during transaction commit

Performance results are mentioned in the change log of the last patch.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/tree-log.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 592a50d9697f..bc5b652f4f64 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -6031,16 +6031,6 @@ static int btrfs_log_inode_parent(struct btrfs_trans_handle *trans,
 		goto end_no_trans;
 	}
 
-	/*
-	 * The prev transaction commit doesn't complete, we need do
-	 * full commit by ourselves.
-	 */
-	if (fs_info->last_trans_log_full_commit >
-	    fs_info->last_trans_committed) {
-		ret = 1;
-		goto end_no_trans;
-	}
-
 	if (btrfs_root_refs(&root->root_item) == 0) {
 		ret = 1;
 		goto end_no_trans;
-- 
2.28.0

