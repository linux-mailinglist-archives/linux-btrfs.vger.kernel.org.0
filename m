Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D6442E14DB
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Dec 2020 03:48:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729921AbgLWCo7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 22 Dec 2020 21:44:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:50890 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728267AbgLWCWo (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 22 Dec 2020 21:22:44 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 38E1E22AAF;
        Wed, 23 Dec 2020 02:22:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608690148;
        bh=rcEd9V3PmUOto2lFO7lVARuSSzqF2uoUe7iAxMdSA/U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mfqOsb7hvvMtjSzHfGDQVWXchtlXJRsYJk31lUKdltazhQmh7Ss+lx66/uoN/6QO5
         bTnq4pAv0t8GM28jNng/fyMvgU0j4wBSArxufKnxvhlLLYNSkwrONESVTS/FaOU2SY
         yKwZ7uO14WWBmdwO3F+vWTk0flszCVQ3y3LjwjG2CXpJs3DIVuewCrq1Jqnj677Np7
         6HItfhwJemazSD7O3s8wq9+OPYx519RZm9vfeKuWgBA0rYCkD/6qxkzpIi5JM5M99b
         zhbhPNEayHe95JiyC3k9aOMfxJRAEoL1RLLH0o1hkYUnbA24zjMSbEcuPw1x8z9E5v
         I+rkTY6/ibGpg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Filipe Manana <fdmanana@suse.com>, David Sterba <dsterba@suse.com>,
        Sasha Levin <sashal@kernel.org>, linux-btrfs@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 69/87] btrfs: fix race leading to unnecessary transaction commit when logging inode
Date:   Tue, 22 Dec 2020 21:20:45 -0500
Message-Id: <20201223022103.2792705-69-sashal@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201223022103.2792705-1-sashal@kernel.org>
References: <20201223022103.2792705-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

[ Upstream commit 639bd575b7c7fa326abadd2ef3e374a5a24eb40b ]

When logging an inode we may often have to fallback to a full transaction
commit, either because a new block group was allocated, there is some case
we can not deal with without a transaction commit or some error like an
ENOMEM happened. However after we fallback to a transaction commit, we
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
   value of 1000. So we end up returning EAGAIN and propagating it up to
   btrfs_sync_file(), where we commit transaction 1000;

4) The transaction commit task (task A) sets the transaction state to
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
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/tree-log.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 7b940264c7b9d..865e1e6bf3d9a 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -5616,16 +5616,6 @@ static int btrfs_log_inode_parent(struct btrfs_trans_handle *trans,
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
2.27.0

