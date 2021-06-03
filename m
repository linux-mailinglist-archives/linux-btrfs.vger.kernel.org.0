Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C57F39A47E
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Jun 2021 17:23:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232123AbhFCPYx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 3 Jun 2021 11:24:53 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:40040 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232057AbhFCPYw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 3 Jun 2021 11:24:52 -0400
Received: from relay2.suse.de (unknown [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 479FB1FD4E;
        Thu,  3 Jun 2021 15:23:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1622733787; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TWsx6NeqnVVyC63q2+X5wkUlyBfwivB4pgyaqYqGT3U=;
        b=lxd65Z8bPRIzvZ0Qnzk3PIeSd9pK3PL1Kaw/kdqAt1DJMVAYnR4ceUdRdW31KqQpYKRH4N
        X5Lq9tAih05POCbkkKmYaJe4DNVqh6Ky3Vn87U2qmEbi0Nhh7fBTSouOCUuPbl7xgE5++S
        men/xSO1tPcM642tpWd8VHJ/8rDEkks=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 41B88A3B92;
        Thu,  3 Jun 2021 15:23:07 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 55A16DA734; Thu,  3 Jun 2021 17:20:26 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 3/4] btrfs: replace async commit by pending actions
Date:   Thu,  3 Jun 2021 17:20:26 +0200
Message-Id: <808c557f1ae3034fdfa2d2361e864aac90ba5a94.1622733245.git.dsterba@suse.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1622733245.git.dsterba@suse.com>
References: <cover.1622733245.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Note: this is a semantic change of what the async transaction ioctl
does. This used to be utilized by ceph, together with the now removed
user transaction ioctls. Last external code that can be found using this
ioctl is a test in ceph testsuite. As btrfs and ceph have taken
independent routes, we don't need to keep the code around.

The btrfs-progs use the start and wait transaction ioctls in a simpler
way, that does not require to block new transaction on the start. The
new semantics is to eventually get transaction id of the running
transaction if there is anything pending for a commit. The wait for
transaction ioctl will block until it's finished.

If there's nothing to be done since start, wait will return
immediately. This effectively implements "wait for current transaction,
if any".

Any action started before the start, like deleting a subvolume, may take
long time to finish. In case it's fast enough to finish before the
start, the following wait will also finish immediately. A long running
operation will catch the transaction and block at wait call until it's
done. Both cases are expected and shall be the new semantics.

This is implemented by the pending action infrastructure, that allows to
asynchronously and safely request a commit by just setting a bit and
waking the transaction kthread.

This is different, because originally start would block, but now it
returns immediately. However, the new behaviour still corresponds with
the documentation of libbtrfsutil so this should not cause any
surprises.

This also simplifies a few transaction commit things:

- another quirky freezing protection removed
- fs_info::transaction_blocked_wait is now never populated, so it's a
  no-op and can be simplified as well
- one less current->journal_info usage, that's been problematic in some
  cases

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/ioctl.c       | 12 +++----
 fs/btrfs/transaction.c | 74 ------------------------------------------
 fs/btrfs/transaction.h |  1 -
 3 files changed, 5 insertions(+), 82 deletions(-)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index f83eb4a225cc..445bb19d8a57 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -3629,9 +3629,9 @@ static long btrfs_ioctl_space_info(struct btrfs_fs_info *fs_info,
 static noinline long btrfs_ioctl_start_sync(struct btrfs_root *root,
 					    void __user *argp)
 {
+	struct btrfs_fs_info *fs_info = root->fs_info;
 	struct btrfs_trans_handle *trans;
 	u64 transid;
-	int ret;
 
 	trans = btrfs_attach_transaction_barrier(root);
 	if (IS_ERR(trans)) {
@@ -3639,15 +3639,13 @@ static noinline long btrfs_ioctl_start_sync(struct btrfs_root *root,
 			return PTR_ERR(trans);
 
 		/* No running transaction, don't bother */
-		transid = root->fs_info->last_trans_committed;
+		transid = fs_info->last_trans_committed;
 		goto out;
 	}
 	transid = trans->transid;
-	ret = btrfs_commit_transaction_async(trans);
-	if (ret) {
-		btrfs_end_transaction(trans);
-		return ret;
-	}
+	/* Trigger commit via the pending action */
+	btrfs_set_pending(fs_info, COMMIT);
+	wake_up_process(fs_info->transaction_kthread);
 out:
 	if (argp)
 		if (copy_to_user(argp, &transid, sizeof(transid)))
diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index 73df8b81496e..5f3c95c876c8 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -1870,80 +1870,6 @@ int btrfs_transaction_blocked(struct btrfs_fs_info *info)
 	return ret;
 }
 
-/*
- * commit transactions asynchronously. once btrfs_commit_transaction_async
- * returns, any subsequent transaction will not be allowed to join.
- */
-struct btrfs_async_commit {
-	struct btrfs_trans_handle *newtrans;
-	struct work_struct work;
-};
-
-static void do_async_commit(struct work_struct *work)
-{
-	struct btrfs_async_commit *ac =
-		container_of(work, struct btrfs_async_commit, work);
-
-	/*
-	 * We've got freeze protection passed with the transaction.
-	 * Tell lockdep about it.
-	 */
-	if (ac->newtrans->type & __TRANS_FREEZABLE)
-		__sb_writers_acquired(ac->newtrans->fs_info->sb, SB_FREEZE_FS);
-
-	current->journal_info = ac->newtrans;
-
-	btrfs_commit_transaction(ac->newtrans);
-	kfree(ac);
-}
-
-int btrfs_commit_transaction_async(struct btrfs_trans_handle *trans)
-{
-	struct btrfs_fs_info *fs_info = trans->fs_info;
-	struct btrfs_async_commit *ac;
-	struct btrfs_transaction *cur_trans;
-
-	ac = kmalloc(sizeof(*ac), GFP_NOFS);
-	if (!ac)
-		return -ENOMEM;
-
-	INIT_WORK(&ac->work, do_async_commit);
-	ac->newtrans = btrfs_join_transaction(trans->root);
-	if (IS_ERR(ac->newtrans)) {
-		int err = PTR_ERR(ac->newtrans);
-		kfree(ac);
-		return err;
-	}
-
-	/* take transaction reference */
-	cur_trans = trans->transaction;
-	refcount_inc(&cur_trans->use_count);
-
-	btrfs_end_transaction(trans);
-
-	/*
-	 * Tell lockdep we've released the freeze rwsem, since the
-	 * async commit thread will be the one to unlock it.
-	 */
-	if (ac->newtrans->type & __TRANS_FREEZABLE)
-		__sb_writers_release(fs_info->sb, SB_FREEZE_FS);
-
-	schedule_work(&ac->work);
-	/*
-	 * Wait for the current transaction commit to start and block
-	 * subsequent transaction joins
-	 */
-	wait_event(fs_info->transaction_blocked_wait,
-		   cur_trans->state >= TRANS_STATE_COMMIT_START ||
-		   TRANS_ABORTED(cur_trans));
-	if (current->journal_info == trans)
-		current->journal_info = NULL;
-
-	btrfs_put_transaction(cur_trans);
-	return 0;
-}
-
-
 static void cleanup_transaction(struct btrfs_trans_handle *trans, int err)
 {
 	struct btrfs_fs_info *fs_info = trans->fs_info;
diff --git a/fs/btrfs/transaction.h b/fs/btrfs/transaction.h
index 0702e8d9b30e..0bdb804fddcb 100644
--- a/fs/btrfs/transaction.h
+++ b/fs/btrfs/transaction.h
@@ -226,7 +226,6 @@ void btrfs_add_dead_root(struct btrfs_root *root);
 int btrfs_defrag_root(struct btrfs_root *root);
 int btrfs_clean_one_deleted_snapshot(struct btrfs_root *root);
 int btrfs_commit_transaction(struct btrfs_trans_handle *trans);
-int btrfs_commit_transaction_async(struct btrfs_trans_handle *trans);
 int btrfs_end_transaction_throttle(struct btrfs_trans_handle *trans);
 bool btrfs_should_end_transaction(struct btrfs_trans_handle *trans);
 void btrfs_throttle(struct btrfs_fs_info *fs_info);
-- 
2.31.1

