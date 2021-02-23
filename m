Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C183F322A51
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Feb 2021 13:13:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232452AbhBWMLl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 23 Feb 2021 07:11:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:41632 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232690AbhBWMJe (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 23 Feb 2021 07:09:34 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7009764E32
        for <linux-btrfs@vger.kernel.org>; Tue, 23 Feb 2021 12:08:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614082133;
        bh=Co0/NHNHWHYPqn528EX0MjRKqrULSIK1Jy+x6KpP4mI=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=PkbWuFBDaxL8WZ4SFbSOh7aIfI8bSwvM/63IOcVCwt5tShuPMrYDn7CpZl6oXxctU
         tEZy2T9C+/SvjnMLPTakdR1OhXJ69jrmmiFx1GnCJYtRshmdxusAWHS9Elx1CNT65Q
         SVjwWXVlB5UGukdHTDyVkmGHSAeCkijUmOlJ79XnCHEmns9zSBnnZRjcE82SvHhQD/
         +epRcBd5HSeKyjleP6P6C+4yys5fa3wDdsGX5crJwbCqzmV1lg4sNyLiuJP2y7eRE9
         POC+Hx9wsXhknAc+1zUK3yRfW5V0IXuyg9ClumIhZtIEcn1YgoMb9BhOrKEJeWMJ31
         1iYFfDuX+hThA==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 2/3] btrfs: fix race between marking inode needs to be logged and log syncing
Date:   Tue, 23 Feb 2021 12:08:48 +0000
Message-Id: <2afba65e798814e2a4a3af69f210c5a35a63fb3d.1614081281.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1614081281.git.fdmanana@suse.com>
References: <cover.1614081281.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

We have a race between marking that an inode needs to be logged, either
at btrfs_set_inode_last_trans() or at btrfs_page_mkwrite(), and between
btrfs_sync_log(). The following steps describe how the race happens.

1) We are at transaction N;

2) Inode I was previously fsynced in the current transaction so it has:

    inode->logged_trans set to N;

3) The inode's root currently has:

   root->log_transid set to 1
   root->last_log_commit set to 0

   Which means only one log transaction was committed to far, log
   transaction 0. When a log tree is created we set ->log_transid and
   ->last_log_commit of its parent root to 0 (at btrfs_add_log_tree());

4) One more range of pages is dirtied in inode I;

5) Some task A starts an fsync against some other inode J (same root), and
   so it joins log transaction 1.

   Before task A calls btrfs_sync_log()...

6) Task B starts an fsync against inode I, which currently has the full
   sync flag set, so it starts delalloc and waits for the ordered extent
   to complete before calling btrfs_inode_in_log() at btrfs_sync_file();

7) During ordered extent completion we have btrfs_update_inode() called
   against inode I, which in turn calls btrfs_set_inode_last_trans(),
   which does the following:

     spin_lock(&inode->lock);
     inode->last_trans = trans->transaction->transid;
     inode->last_sub_trans = inode->root->log_transid;
     inode->last_log_commit = inode->root->last_log_commit;
     spin_unlock(&inode->lock);

   So ->last_trans is set to N and ->last_sub_trans set to 1.
   But before setting ->last_log_commit...

8) Task A is at btrfs_sync_log():

   - it increments root->log_transid to 2
   - starts writeteback for all log tree extent buffers
   - waits for the writeback to complete
   - writes the super blocks
   - updates root->last_log_commit to 1

   It's a lot of slow steps between updating root->log_transid and
   root->last_log_commit;

9) The task doing the ordered extent completion, currently at
   btrfs_set_inode_last_trans(), then finally runs:

     inode->last_log_commit = inode->root->last_log_commit;
     spin_unlock(&inode->lock);

   Which results in inode->last_log_commit being set to 1.
   The ordered extent completes;

10) Task B is resumed, and it calls btrfs_inode_in_log() whichs returns
    true because we have all the following conditions met:

    inode->logged_trans == N which matches fs_info->generation &&
    inode->last_subtrans (1) <= inode->last_log_commit (1) &&
    inode->last_subtrans (1) <= root->last_log_commit (1) &&
    list inode->extent_tree.modified_extents is empty

    And as a consequence we return without logging the inode, so the
    existing logged version of the inode does not point to the extent
    that was written after the previous fsync.

It should be impossible in practice for one task be able to do so much
progress in btrfs_sync_log() while another task is at
btrfs_set_inode_last_trans() right after it reads root->log_transid and
before it reads root->last_log_commit. Even if kernel preemption is enabled
we know the task at btrfs_set_inode_last_trans() can not be preempted
because it is holding the inode's spinlock.

However there is another place where we do the same without holding the
spinlock, which is in the memory mapped write path at:

  vm_fault_t btrfs_page_mkwrite(struct vm_fault *vmf)
  {
     (...)
     BTRFS_I(inode)->last_trans = fs_info->generation;
     BTRFS_I(inode)->last_sub_trans = BTRFS_I(inode)->root->log_transid;
     BTRFS_I(inode)->last_log_commit = BTRFS_I(inode)->root->last_log_commit;
     (...)

So with preemption happening after setting ->last_sub_trans and before
setting ->last_log_commit, it is less of a stretch to have another task
do enough progress at btrfs_sync_log() such that the task doing the memory
mapped write ends up with ->last_sub_trans and ->last_log_commit set to
the same value. It is still a big stretch to get there, as the task doing
btrfs_sync_log() has to start writeback, wait for its completion and write
the super blocks.

So fix this in two different ways:

1) For btrfs_set_inode_last_trans(), simply set ->last_log_commit to the
   value of ->last_sub_trans minus 1;

2) For btrfs_page_mkwrite() only set the inode's ->last_sub_trans, just
   like we do for buffered and direct writes at btrfs_file_write_iter(),
   which is all we need to make sure multiple writes and fsyncs to an
   inode in the same transaction never result in an fsync missing that
   the inode changed and needs to be logged. Turn this into a helper
   function and use it both at btrfs_page_mkwrite() and at
   btrfs_file_write_iter() - this also fixes the problem that at
   btrfs_page_mkwrite() we were setting those fields without the
   protection of the inode's spinlock.

This is an extremely unlikely race to happen in pratice.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/btrfs_inode.h | 15 +++++++++++++++
 fs/btrfs/file.c        | 10 ++--------
 fs/btrfs/inode.c       |  4 +---
 fs/btrfs/transaction.h |  2 +-
 4 files changed, 19 insertions(+), 12 deletions(-)

diff --git a/fs/btrfs/btrfs_inode.h b/fs/btrfs/btrfs_inode.h
index 26837c3ca7f6..8011596e1eb3 100644
--- a/fs/btrfs/btrfs_inode.h
+++ b/fs/btrfs/btrfs_inode.h
@@ -300,6 +300,21 @@ static inline void btrfs_mod_outstanding_extents(struct btrfs_inode *inode,
 						  mod);
 }
 
+/*
+ * Called every time after doing a buffered, direct IO or memory mapped write.
+ *
+ * This is to ensure that if we write to a file that was previously fsynced in
+ * the current transaction, then try to fsync it again in the same transaction,
+ * we will know that there were changes in the file and that it needs to be
+ * logged.
+ */
+static inline void btrfs_set_inode_last_sub_trans(struct btrfs_inode *inode)
+{
+	spin_lock(&inode->lock);
+	inode->last_sub_trans = inode->root->log_transid;
+	spin_unlock(&inode->lock);
+}
+
 static inline int btrfs_inode_in_log(struct btrfs_inode *inode, u64 generation)
 {
 	int ret = 0;
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 809eee806505..2dcbe3602b6a 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -2014,14 +2014,8 @@ static ssize_t btrfs_file_write_iter(struct kiocb *iocb,
 	else
 		num_written = btrfs_buffered_write(iocb, from);
 
-	/*
-	 * We also have to set last_sub_trans to the current log transid,
-	 * otherwise subsequent syncs to a file that's been synced in this
-	 * transaction will appear to have already occurred.
-	 */
-	spin_lock(&inode->lock);
-	inode->last_sub_trans = inode->root->log_transid;
-	spin_unlock(&inode->lock);
+	btrfs_set_inode_last_sub_trans(inode);
+
 	if (num_written > 0)
 		num_written = generic_write_sync(iocb, num_written);
 
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 1710060eb2dc..ae3b439565b4 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -8623,9 +8623,7 @@ vm_fault_t btrfs_page_mkwrite(struct vm_fault *vmf)
 	set_page_dirty(page);
 	SetPageUptodate(page);
 
-	BTRFS_I(inode)->last_trans = fs_info->generation;
-	BTRFS_I(inode)->last_sub_trans = BTRFS_I(inode)->root->log_transid;
-	BTRFS_I(inode)->last_log_commit = BTRFS_I(inode)->root->last_log_commit;
+	btrfs_set_inode_last_sub_trans(BTRFS_I(inode));
 
 	unlock_extent_cached(io_tree, page_start, page_end, &cached_state);
 	up_read(&BTRFS_I(inode)->i_mmap_lock);
diff --git a/fs/btrfs/transaction.h b/fs/btrfs/transaction.h
index 6335716e513f..dd7c3eea08ad 100644
--- a/fs/btrfs/transaction.h
+++ b/fs/btrfs/transaction.h
@@ -175,7 +175,7 @@ static inline void btrfs_set_inode_last_trans(struct btrfs_trans_handle *trans,
 	spin_lock(&inode->lock);
 	inode->last_trans = trans->transaction->transid;
 	inode->last_sub_trans = inode->root->log_transid;
-	inode->last_log_commit = inode->root->last_log_commit;
+	inode->last_log_commit = inode->last_sub_trans - 1;
 	spin_unlock(&inode->lock);
 }
 
-- 
2.28.0

