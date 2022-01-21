Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46314496240
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Jan 2022 16:44:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351423AbiAUPop (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 21 Jan 2022 10:44:45 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:56516 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240481AbiAUPop (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 21 Jan 2022 10:44:45 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 14180B82057
        for <linux-btrfs@vger.kernel.org>; Fri, 21 Jan 2022 15:44:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41BA6C340E1
        for <linux-btrfs@vger.kernel.org>; Fri, 21 Jan 2022 15:44:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642779882;
        bh=rzivCurT4oRUGlMWYT8vX+I65+tks7707MqVuUAmF1E=;
        h=From:To:Subject:Date:From;
        b=D3oCz+vsUetzCmuWMHStFVrAUi8o5eFy5TKJjRG71CHN64yrAlcpBoJ305rMCYlyd
         d8FodyZMFdujUevpWL2sY7hRHzAI0ciBzvyPRCM0Z104SIjbHDau5b0jL+5c6dVJyI
         OUg2lfowRN8v0xKlzPOwOi0D45eOwNz26VxQahBLy/jx1tbqSLp7mY9/n2k0VeQ0MT
         KD7vokCdspm3hta99v2LDNkdHnM3qT1WMlT8MnDEC8haBjIKvbvuHC9/puriq4EDIR
         W8K5X/RiZIHYmUXSKKwnEcEjtYhiPz5SslpCC1CMyTbeU+CoZxm90r7F3R/+uqdR/I
         EzGQ3o3PD8xWg==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: fix use-after-free after failure to create a snapshot
Date:   Fri, 21 Jan 2022 15:44:39 +0000
Message-Id: <3ebda64ca2a8b55f924fbf2b9e850ff99e65938b.1642779802.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

At ioctl.c:create_snapshot(), we allocate a pending snapshot structure and
then attach it to the transaction's list of pending snapshots. After that
we call btrfs_commit_transaction(), and if that returns an error we jump
to 'fail' label, where we kfree() the pending snapshot structure. This can
result in a later use-after-free of the pending snapshot:

1) We allocated the pending snapshot and added it to the transaction's
   list of pending snapshots;

2) We call btrfs_commit_transaction(), and it fails either at the first
   call to btrfs_run_delayed_refs() or btrfs_start_dirty_block_groups().
   In both cases, we don't abort the transaction and we release our
   transaction handle. We jump to the 'fail' label and free the pending
   snapshot structure. We return with the pending snapshot still in the
   transaction's list;

3) Another task commits the transaction. This time there's no error at
   all, and then during the transaction commit it accesses a pointer
   to the pending snapshot structure that the snapshot creation task
   has already freed, resulting in a user-after-free.

This issue could actually be detected by smatch, which produced the
following warning:

  fs/btrfs/ioctl.c:843 create_snapshot() warn: '&pending_snapshot->list' not removed from list

So fix this by not having the snapshot creation ioctl directly add the
pending snapshot to the transaction's list. Instead add the pending
snapshot to the transaction handle, and then at btrfs_commit_transaction()
we add the snapshot to the list only when we can guarantee that any error
returned after that point will result in a transaction abort, in which
case the ioctl code can safely free the pending snapshot and no one can
access it anymore.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/ioctl.c       |  5 +----
 fs/btrfs/transaction.c | 24 ++++++++++++++++++++++++
 fs/btrfs/transaction.h |  2 ++
 3 files changed, 27 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 95d0e210f063..9a33d7fd91a0 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -803,10 +803,7 @@ static int create_snapshot(struct btrfs_root *root, struct inode *dir,
 		goto fail;
 	}
 
-	spin_lock(&fs_info->trans_lock);
-	list_add(&pending_snapshot->list,
-		 &trans->transaction->pending_snapshots);
-	spin_unlock(&fs_info->trans_lock);
+	trans->pending_snapshot = pending_snapshot;
 
 	ret = btrfs_commit_transaction(trans);
 	if (ret)
diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index 03de89b45f27..c43bbc7f623e 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -2000,6 +2000,27 @@ static inline void btrfs_wait_delalloc_flush(struct btrfs_fs_info *fs_info)
 		btrfs_wait_ordered_roots(fs_info, U64_MAX, 0, (u64)-1);
 }
 
+/*
+ * Add a pending snapshot associated with the given transaction handle to the
+ * respective handle. This must be called after the transaction commit started
+ * and while holding fs_info->trans_lock.
+ * This serves to guarantee a caller of btrfs_commit_transaction() that it can
+ * safely free the pending snapshot pointer in case btrfs_commit_transaction()
+ * returns an error.
+ */
+static void add_pending_snapshot(struct btrfs_trans_handle *trans)
+{
+	struct btrfs_transaction *cur_trans = trans->transaction;
+
+	if (!trans->pending_snapshot)
+		return;
+
+	lockdep_assert_held(&trans->fs_info->trans_lock);
+	ASSERT(cur_trans->state >= TRANS_STATE_COMMIT_START);
+
+	list_add(&trans->pending_snapshot->list, &cur_trans->pending_snapshots);
+}
+
 int btrfs_commit_transaction(struct btrfs_trans_handle *trans)
 {
 	struct btrfs_fs_info *fs_info = trans->fs_info;
@@ -2073,6 +2094,8 @@ int btrfs_commit_transaction(struct btrfs_trans_handle *trans)
 	if (cur_trans->state >= TRANS_STATE_COMMIT_START) {
 		enum btrfs_trans_state want_state = TRANS_STATE_COMPLETED;
 
+		add_pending_snapshot(trans);
+
 		spin_unlock(&fs_info->trans_lock);
 		refcount_inc(&cur_trans->use_count);
 
@@ -2163,6 +2186,7 @@ int btrfs_commit_transaction(struct btrfs_trans_handle *trans)
 	 * COMMIT_DOING so make sure to wait for num_writers to == 1 again.
 	 */
 	spin_lock(&fs_info->trans_lock);
+	add_pending_snapshot(trans);
 	cur_trans->state = TRANS_STATE_COMMIT_DOING;
 	spin_unlock(&fs_info->trans_lock);
 	wait_event(cur_trans->writer_wait,
diff --git a/fs/btrfs/transaction.h b/fs/btrfs/transaction.h
index 1852ed9de7fd..9402d8d94484 100644
--- a/fs/btrfs/transaction.h
+++ b/fs/btrfs/transaction.h
@@ -123,6 +123,8 @@ struct btrfs_trans_handle {
 	struct btrfs_transaction *transaction;
 	struct btrfs_block_rsv *block_rsv;
 	struct btrfs_block_rsv *orig_rsv;
+	/* Set by a task that wants to create a snapshot. */
+	struct btrfs_pending_snapshot *pending_snapshot;
 	refcount_t use_count;
 	unsigned int type;
 	/*
-- 
2.33.0

