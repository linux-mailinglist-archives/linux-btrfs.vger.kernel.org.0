Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 151013AE6C7
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Jun 2021 12:10:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230268AbhFUKM5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 21 Jun 2021 06:12:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:57988 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229621AbhFUKM4 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 21 Jun 2021 06:12:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 77A8960FE9
        for <linux-btrfs@vger.kernel.org>; Mon, 21 Jun 2021 10:10:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624270242;
        bh=a/f5mEuZPnPI7YdLRanTWZvmfGm7quseHbu0/BL6s4M=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=YZAJZlbwFEedtzKXnmr1BUMultoPvS9zd1mT6bPEwLbZ1xwIYRlB3vC0fLrJM91qg
         025tj4ha313v6NsW7ZbtlV0cUbYC5cmmmtU2RQlYo5vSieOH1IztIRi+Tsw2KsLFDf
         VlBCqLaiHb/AopLl63OIfgA8NndnEFn1CbQjWoI7+mtaSSJa5njW+bmoqihrX5QmEq
         oLZetDZudeECwvWhPBnvkEpXMKOKh3uytrED6cOysn5A9FvksBWfSGlfb1VloV211Z
         MIy5keDyIVqkUqVAm0c/h62iydTwcuAvQ2EU2VVoetfv2zS3kt4oauNu3lJiccwmF1
         uU2Cw/wGByUiQ==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 1/2] btrfs: ensure relocation never runs while we have send operations running
Date:   Mon, 21 Jun 2021 11:10:38 +0100
Message-Id: <d4d0d24f945c868a46aab082e8d5809806cfeffb.1624269734.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1624269734.git.fdmanana@suse.com>
References: <cover.1624269734.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

Relocation and send do not play well together because while send is
running a block group can be relocated, a transaction committed and
the respective disk extents get re-allocated and written to or discarded
while send is about to do something with the extents.

This was explained in commit 9e967495e0e0ae ("Btrfs: prevent send failures
and crashes due to concurrent relocation"), which prevented balance and
send from running in parallel but it did not address one remaining case
where chunk relocation can happen: shrinking a device (and device deletion
which shrinks a device's size to 0 before deleting the device).

We also have now one more case where relocation is triggered: on zoned
filesystems partially used block groups get relocated by a background
thread, introduced in commit 18bb8bbf13c183 ("btrfs: zoned: automatically
reclaim zones").

So make sure that instead of preventing balance from running when there
are ongoing send operations, we prevent relocation from happening.
This uses the infrastructure recently added by a patch that has the
subject: "btrfs: add cancellable chunk relocation support".

Also it adds a spinlock used exclusively for the exclusivity between
send and relocation, as before fs_info->balance_mutex was used, which
would make an attempt to run send to block waiting for balance to
finish, which can take a lot of time on large filesystems.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/block-group.c | 10 ++++++++--
 fs/btrfs/ctree.h       |  5 +++--
 fs/btrfs/disk-io.c     |  1 +
 fs/btrfs/relocation.c  | 13 +++++++++++++
 fs/btrfs/send.c        | 14 +++++++-------
 fs/btrfs/volumes.c     |  8 --------
 6 files changed, 32 insertions(+), 19 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 38885b29e6e5..cbcb3ec99e3f 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -1491,7 +1491,7 @@ void btrfs_reclaim_bgs_work(struct work_struct *work)
 		container_of(work, struct btrfs_fs_info, reclaim_bgs_work);
 	struct btrfs_block_group *bg;
 	struct btrfs_space_info *space_info;
-	int ret;
+	LIST_HEAD(again_list);
 
 	if (!test_bit(BTRFS_FS_OPEN, &fs_info->flags))
 		return;
@@ -1502,6 +1502,8 @@ void btrfs_reclaim_bgs_work(struct work_struct *work)
 	mutex_lock(&fs_info->reclaim_bgs_lock);
 	spin_lock(&fs_info->unused_bgs_lock);
 	while (!list_empty(&fs_info->reclaim_bgs)) {
+		int ret = 0;
+
 		bg = list_first_entry(&fs_info->reclaim_bgs,
 				      struct btrfs_block_group,
 				      bg_list);
@@ -1547,9 +1549,13 @@ void btrfs_reclaim_bgs_work(struct work_struct *work)
 				  bg->start);
 
 next:
-		btrfs_put_block_group(bg);
 		spin_lock(&fs_info->unused_bgs_lock);
+		if (ret == -EAGAIN && list_empty(&bg->bg_list))
+			list_add_tail(&bg->bg_list, &again_list);
+		else
+			btrfs_put_block_group(bg);
 	}
+	list_splice_tail(&again_list, &fs_info->reclaim_bgs);
 	spin_unlock(&fs_info->unused_bgs_lock);
 	mutex_unlock(&fs_info->reclaim_bgs_lock);
 	btrfs_exclop_finish(fs_info);
diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 6131b58f779f..0f56af5739fb 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -561,13 +561,13 @@ enum {
 	/*
 	 * Indicate that balance has been set up from the ioctl and is in the
 	 * main phase. The fs_info::balance_ctl is initialized.
-	 * Set and cleared while holding fs_info::balance_mutex.
 	 */
 	BTRFS_FS_BALANCE_RUNNING,
 
 	/*
 	 * Indicate that relocation of a chunk has started, it's set per chunk
 	 * and is toggled between chunks.
+	 * Set, tested and cleared while holding fs_info::send_reloc_lock.
 	 */
 	BTRFS_FS_RELOC_RUNNING,
 
@@ -995,9 +995,10 @@ struct btrfs_fs_info {
 
 	struct crypto_shash *csum_shash;
 
+	spinlock_t send_reloc_lock;
 	/*
 	 * Number of send operations in progress.
-	 * Updated while holding fs_info::balance_mutex.
+	 * Updated while holding fs_info::send_reloc_lock.
 	 */
 	int send_in_progress;
 
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 544bb7a82e57..3ded062d303c 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -2999,6 +2999,7 @@ void btrfs_init_fs_info(struct btrfs_fs_info *fs_info)
 	spin_lock_init(&fs_info->swapfile_pins_lock);
 	fs_info->swapfile_pins = RB_ROOT;
 
+	spin_lock_init(&fs_info->send_reloc_lock);
 	fs_info->send_in_progress = 0;
 
 	fs_info->bg_reclaim_threshold = BTRFS_DEFAULT_RECLAIM_THRESH;
diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 420a89869889..fc831597cb22 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -3789,14 +3789,25 @@ struct inode *create_reloc_inode(struct btrfs_fs_info *fs_info,
  *   0             success
  *   -EINPROGRESS  operation is already in progress, that's probably a bug
  *   -ECANCELED    cancellation request was set before the operation started
+ *   -EAGAIN       can not start because there are ongoing send operations
  */
 static int reloc_chunk_start(struct btrfs_fs_info *fs_info)
 {
+	spin_lock(&fs_info->send_reloc_lock);
+	if (fs_info->send_in_progress) {
+		btrfs_warn_rl(fs_info,
+"cannot run relocation while send operations are in progress (%d in progress)",
+			      fs_info->send_in_progress);
+		spin_unlock(&fs_info->send_reloc_lock);
+		return -EAGAIN;
+	}
 	if (test_and_set_bit(BTRFS_FS_RELOC_RUNNING, &fs_info->flags)) {
 		/* This should not happen */
+		spin_unlock(&fs_info->send_reloc_lock);
 		btrfs_err(fs_info, "reloc already running, cannot start");
 		return -EINPROGRESS;
 	}
+	spin_unlock(&fs_info->send_reloc_lock);
 
 	if (atomic_read(&fs_info->reloc_cancel_req) > 0) {
 		btrfs_info(fs_info, "chunk relocation canceled on start");
@@ -3818,7 +3829,9 @@ static void reloc_chunk_end(struct btrfs_fs_info *fs_info)
 	/* Requested after start, clear bit first so any waiters can continue */
 	if (atomic_read(&fs_info->reloc_cancel_req) > 0)
 		btrfs_info(fs_info, "chunk relocation canceled during operation");
+	spin_lock(&fs_info->send_reloc_lock);
 	clear_and_wake_up_bit(BTRFS_FS_RELOC_RUNNING, &fs_info->flags);
+	spin_unlock(&fs_info->send_reloc_lock);
 	atomic_set(&fs_info->reloc_cancel_req, 0);
 }
 
diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index 6e69302828ef..37e502b09a80 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -7416,23 +7416,23 @@ long btrfs_ioctl_send(struct file *mnt_file, struct btrfs_ioctl_send_args *arg)
 	if (ret)
 		goto out;
 
-	mutex_lock(&fs_info->balance_mutex);
-	if (test_bit(BTRFS_FS_BALANCE_RUNNING, &fs_info->flags)) {
-		mutex_unlock(&fs_info->balance_mutex);
+	spin_lock(&fs_info->send_reloc_lock);
+	if (test_bit(BTRFS_FS_RELOC_RUNNING, &fs_info->flags)) {
+		spin_unlock(&fs_info->send_reloc_lock);
 		btrfs_warn_rl(fs_info,
-		"cannot run send because a balance operation is in progress");
+		"cannot run send because a relocation operation is in progress");
 		ret = -EAGAIN;
 		goto out;
 	}
 	fs_info->send_in_progress++;
-	mutex_unlock(&fs_info->balance_mutex);
+	spin_unlock(&fs_info->send_reloc_lock);
 
 	current->journal_info = BTRFS_SEND_TRANS_STUB;
 	ret = send_subvol(sctx);
 	current->journal_info = NULL;
-	mutex_lock(&fs_info->balance_mutex);
+	spin_lock(&fs_info->send_reloc_lock);
 	fs_info->send_in_progress--;
-	mutex_unlock(&fs_info->balance_mutex);
+	spin_unlock(&fs_info->send_reloc_lock);
 	if (ret < 0)
 		goto out;
 
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 582695cee9d1..782e16795bc4 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -4217,14 +4217,6 @@ int btrfs_balance(struct btrfs_fs_info *fs_info,
 				btrfs_bg_type_to_raid_name(data_target));
 	}
 
-	if (fs_info->send_in_progress) {
-		btrfs_warn_rl(fs_info,
-"cannot run balance while send operations are in progress (%d in progress)",
-			      fs_info->send_in_progress);
-		ret = -EAGAIN;
-		goto out;
-	}
-
 	ret = insert_balance_item(fs_info, bctl);
 	if (ret && ret != -EEXIST)
 		goto out;
-- 
2.28.0

