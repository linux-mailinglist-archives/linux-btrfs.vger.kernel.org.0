Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8937E4469F6
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Nov 2021 21:46:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233731AbhKEUsj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 5 Nov 2021 16:48:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233724AbhKEUsg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 5 Nov 2021 16:48:36 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB501C061205
        for <linux-btrfs@vger.kernel.org>; Fri,  5 Nov 2021 13:45:56 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id j9so8034767qvm.10
        for <linux-btrfs@vger.kernel.org>; Fri, 05 Nov 2021 13:45:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Gzm0QAOunUEnULgc5TIwl5ZukYTklD1Fq1MMp8p/OZE=;
        b=SpWn5SkyiUsSV9aoaFhYFrNSLC2R6A60GQVAbbHwYDA4D8/3goQYyXEoBwxaBC5j4J
         kGZ1gmPjuBr58HsYKjglmnNQ6q+SKljtD3nPm2plWUsF2zJJcXfBhlvvRvyCy55LlP4f
         vANh256eb1t6OJv4Hi7Nk8F2Eh9241E2J0YTbF2nrLQp+KcaiVIdIQgRxQ5GZRWGW5Hj
         ciaPIvc35Bm9pjttO+7+eINgnV5dK8Dde7GxNS9MndK63VG0B/jyftNfpxKu043oaPrb
         K/wFPSzCOvAHueH/He5l7uhDy308LXwKYoleyziVYA+l0ffmHrgnOiEFoP+Qo3Z40bEd
         uDTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Gzm0QAOunUEnULgc5TIwl5ZukYTklD1Fq1MMp8p/OZE=;
        b=l12gYkfuVwCPKGRoCy24xpBjcYeAcWjEtX+HGO4yon57WM183/KCkztt1zBjXhSUxr
         HOPXD4fsgMe5/cEOgoNEaI4bxvw6WPzjlghzrEZmT8sMhwriftyI5Opbr0uHj9fZlXNr
         irlsLc6b6n5r12XcwTNzlGVOpyZ86a6wVzEh4kf/Oc0kPImr+T/rLBbPVd8A846X2t0T
         Guu4Z8JxtxL5t7zrcl61GbmJXvivBpFpXscHulntKqzN/dyopB0Q/TA8y+gog+PNrlps
         Y7BVHwVHor9riP9zKxzqNsAnCYXwnxgopkGIquS6LAG0Tnr8jzdjO34fzzelq5fMTONW
         KfPg==
X-Gm-Message-State: AOAM533AqJFCsPqo5zdVu38xYvB82Ixy837iBO/NhWP47Re2GCedWkzm
        toSTokH89Jk3RU0I+aC9Ot/nmJr4tlR5Gg==
X-Google-Smtp-Source: ABdhPJzOTmbAa6x7llLc/1Cz7ww0G2BZ23U9KW1JA8orTk7oPEx/9ZCWmZRONh/sxAjOBUuRLARDiw==
X-Received: by 2002:a05:6214:509a:: with SMTP id kk26mr1485283qvb.43.1636145155509;
        Fri, 05 Nov 2021 13:45:55 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id h68sm5990755qkf.126.2021.11.05.13.45.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Nov 2021 13:45:55 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 02/25] btrfs: rework async transaction committing
Date:   Fri,  5 Nov 2021 16:45:28 -0400
Message-Id: <5a181fb41c864ca518a35defc2547abef30afb18.1636144971.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1636144971.git.josef@toxicpanda.com>
References: <cover.1636144971.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Currently we do this awful thing where we get another ref on a trans
handle, async off that handle and commit the transaction from that work.
Because we do this we have to mess with current->journal_info and the
freeze counting stuff.

We already have an async thing to kick for the transaction commit, the
transaction kthread.  Replace this work struct with a flag on the
fs_info to tell the kthread to go ahead and commit even if it's before
our timeout.  Then we can drastically simplify the async transaction
commit path.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/ctree.h       |  3 ++
 fs/btrfs/disk-io.c     |  3 +-
 fs/btrfs/ioctl.c       |  7 +----
 fs/btrfs/transaction.c | 64 ++++++++----------------------------------
 fs/btrfs/transaction.h |  2 +-
 5 files changed, 18 insertions(+), 61 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index ce48ff69c77f..fb49162311b9 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -595,6 +595,9 @@ enum {
 	/* Indicate whether there are any tree modification log users */
 	BTRFS_FS_TREE_MOD_LOG_USERS,
 
+	/* Indicate that we want the transaction kthread to commit right now. */
+	BTRFS_FS_COMMIT_TRANS,
+
 #if BITS_PER_LONG == 32
 	/* Indicate if we have error/warn message printed on 32bit systems */
 	BTRFS_FS_32BIT_ERROR,
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 8d36950800f4..4c4357724ed0 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -1926,7 +1926,8 @@ static int transaction_kthread(void *arg)
 		}
 
 		delta = ktime_get_seconds() - cur->start_time;
-		if (cur->state < TRANS_STATE_COMMIT_START &&
+		if (!test_and_clear_bit(BTRFS_FS_COMMIT_TRANS, &fs_info->flags) &&
+		    cur->state < TRANS_STATE_COMMIT_START &&
 		    delta < fs_info->commit_interval) {
 			spin_unlock(&fs_info->trans_lock);
 			delay -= msecs_to_jiffies((delta - 1) * 1000);
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index c474f7e24163..44372f1e61ac 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -3622,7 +3622,6 @@ static noinline long btrfs_ioctl_start_sync(struct btrfs_root *root,
 {
 	struct btrfs_trans_handle *trans;
 	u64 transid;
-	int ret;
 
 	trans = btrfs_attach_transaction_barrier(root);
 	if (IS_ERR(trans)) {
@@ -3634,11 +3633,7 @@ static noinline long btrfs_ioctl_start_sync(struct btrfs_root *root,
 		goto out;
 	}
 	transid = trans->transid;
-	ret = btrfs_commit_transaction_async(trans);
-	if (ret) {
-		btrfs_end_transaction(trans);
-		return ret;
-	}
+	btrfs_commit_transaction_async(trans);
 out:
 	if (argp)
 		if (copy_to_user(argp, &transid, sizeof(transid)))
diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index b958e0fdfe10..befe04019271 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -1861,50 +1861,14 @@ int btrfs_transaction_blocked(struct btrfs_fs_info *info)
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
+void btrfs_commit_transaction_async(struct btrfs_trans_handle *trans)
 {
 	struct btrfs_fs_info *fs_info = trans->fs_info;
-	struct btrfs_async_commit *ac;
 	struct btrfs_transaction *cur_trans;
 
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
+	/* Kick the transaction kthread. */
+	set_bit(BTRFS_FS_COMMIT_TRANS, &fs_info->flags);
+	wake_up_process(fs_info->transaction_kthread);
 
 	/* take transaction reference */
 	cur_trans = trans->transaction;
@@ -1912,14 +1876,6 @@ int btrfs_commit_transaction_async(struct btrfs_trans_handle *trans)
 
 	btrfs_end_transaction(trans);
 
-	/*
-	 * Tell lockdep we've released the freeze rwsem, since the
-	 * async commit thread will be the one to unlock it.
-	 */
-	if (ac->newtrans->type & __TRANS_FREEZABLE)
-		__sb_writers_release(fs_info->sb, SB_FREEZE_FS);
-
-	schedule_work(&ac->work);
 	/*
 	 * Wait for the current transaction commit to start and block
 	 * subsequent transaction joins
@@ -1927,14 +1883,9 @@ int btrfs_commit_transaction_async(struct btrfs_trans_handle *trans)
 	wait_event(fs_info->transaction_blocked_wait,
 		   cur_trans->state >= TRANS_STATE_COMMIT_START ||
 		   TRANS_ABORTED(cur_trans));
-	if (current->journal_info == trans)
-		current->journal_info = NULL;
-
 	btrfs_put_transaction(cur_trans);
-	return 0;
 }
 
-
 static void cleanup_transaction(struct btrfs_trans_handle *trans, int err)
 {
 	struct btrfs_fs_info *fs_info = trans->fs_info;
@@ -2200,6 +2151,13 @@ int btrfs_commit_transaction(struct btrfs_trans_handle *trans)
 	wait_event(cur_trans->writer_wait,
 		   atomic_read(&cur_trans->num_writers) == 1);
 
+	/*
+	 * We've started the commit, clear the flag in case we were triggered to
+	 * do an async commit but somebody else started before the transaction
+	 * kthread could do the work.
+	 */
+	clear_bit(BTRFS_FS_COMMIT_TRANS, &fs_info->flags);
+
 	if (TRANS_ABORTED(cur_trans)) {
 		ret = cur_trans->aborted;
 		goto scrub_continue;
diff --git a/fs/btrfs/transaction.h b/fs/btrfs/transaction.h
index ba45065f9451..e4b9b251a29e 100644
--- a/fs/btrfs/transaction.h
+++ b/fs/btrfs/transaction.h
@@ -217,7 +217,7 @@ void btrfs_add_dead_root(struct btrfs_root *root);
 int btrfs_defrag_root(struct btrfs_root *root);
 int btrfs_clean_one_deleted_snapshot(struct btrfs_root *root);
 int btrfs_commit_transaction(struct btrfs_trans_handle *trans);
-int btrfs_commit_transaction_async(struct btrfs_trans_handle *trans);
+void btrfs_commit_transaction_async(struct btrfs_trans_handle *trans);
 int btrfs_end_transaction_throttle(struct btrfs_trans_handle *trans);
 bool btrfs_should_end_transaction(struct btrfs_trans_handle *trans);
 void btrfs_throttle(struct btrfs_fs_info *fs_info);
-- 
2.26.3

