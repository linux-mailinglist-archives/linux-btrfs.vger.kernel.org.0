Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B9597879C9
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Aug 2023 23:00:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243638AbjHXU7t (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 24 Aug 2023 16:59:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243636AbjHXU70 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 24 Aug 2023 16:59:26 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C17B19BF
        for <linux-btrfs@vger.kernel.org>; Thu, 24 Aug 2023 13:59:24 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id 3f1490d57ef6-d67869054bfso276963276.3
        for <linux-btrfs@vger.kernel.org>; Thu, 24 Aug 2023 13:59:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20221208.gappssmtp.com; s=20221208; t=1692910763; x=1693515563;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=C/GZ9oYf7aJTRoEcIozJSX+cIRgzo7ghiWmZ9xdPLuU=;
        b=0n/VOBKRH1/sjrT5XikRubROjBKhSDetYken03j2kmknnOKzc6010m2gTbTRmn8etB
         /DwHAmLji95O1QzCSgZSgsgTRzLBxWC8rvs1LEH1hL/zim73wuPForJ3V7Qjy8DeKuTS
         nWkaaOrcPqFvkMg8JW9enieWR/5wMI+ZuHLI1W9rS/kkSkYjJGnYDGPUVcPZfQlpvfvD
         YaL6Z/8Qm9SO8oFIxK/ovn/QZApghc97JHcypSdVbxj+ZOALKT2kkeGgwosjNcjJo6Mj
         gH+XdYK5mrvjPDtDRJo7KiRPMoOz7uBA/wto3jPPLc2IuZO+XQZWgerQgn8KbFsnpvqe
         0ZCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692910763; x=1693515563;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C/GZ9oYf7aJTRoEcIozJSX+cIRgzo7ghiWmZ9xdPLuU=;
        b=A6I0rptuWzPB8+7ZuKaqhEFFTVG6JU4Zn85iakPTt7SQx9uZkDwaNmXF+47tHecgKf
         m44KuygFKXlpHs3NBV7rg/ll0Oi22qBj2hwaoq430bPCVykIlR0AKvjcCmNdS1qpN38t
         WudqJZbr2bPcy6vzkKfPeWi784URNQby5VnZRVcCeWxoiv8ytzzin938rbuz7mgWWCQX
         KiTlD9NtJ//MCwq6HFDjjM71v1E3gOw3EMa0e8nl/3Lj2f+i5XAuvaqvr6PGFnGVBqVb
         iHQBXU7dYOWID77YOtQpO+ylALVBykbqJ1J8qpIF2KjRd3zLDXqrG01MgaOgcq4NNuse
         9O1A==
X-Gm-Message-State: AOJu0YylglEar145D7EW1kMqIAu6QSl8TiJ0bluga3o+faUumhzXpH50
        JhG0+P+aYDYeO3JEuGSh6nZAY9dsC0OluycBdw4=
X-Google-Smtp-Source: AGHT+IGhnpKNWBTbakSQ/9ZCr58m+afQ0k1cq2Gc7Oz8ZxXZl7UWw5SDIPjzRgckFvfcBwoSQwARBw==
X-Received: by 2002:a25:aa4e:0:b0:d09:33b0:f4e4 with SMTP id s72-20020a25aa4e000000b00d0933b0f4e4mr16031168ybi.4.1692910763354;
        Thu, 24 Aug 2023 13:59:23 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 15-20020a25090f000000b00d77928cdcf6sm55750ybj.15.2023.08.24.13.59.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Aug 2023 13:59:22 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH] btrfs: do not block starts waiting on previous transaction commit
Date:   Thu, 24 Aug 2023 16:59:22 -0400
Message-Id: <042d69d13a10b90a29b5e096db59b9669fac68d2.1692910751.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Internally I got a report of very long stalls on normal operations like
creating a new file when auto relocation was running.  The reporter used
the bpf offcputime tracer to show that we would get stuck in
start_transaction for 5 to 30 seconds, and were always being woken up by
the transaction commit.

Using my timing-everything script, which times how long a function takes
and what percentage of that total time is taken up by its children, I
saw several traces like this

1083 took 32812902424 ns
        29929002926 ns 91.2110% wait_for_commit_duration
        25568 ns 7.7920e-05% commit_fs_roots_duration
        1007751 ns 0.00307% commit_cowonly_roots_duration
        446855602 ns 1.36182% btrfs_run_delayed_refs_duration
        271980 ns 0.00082% btrfs_run_delayed_items_duration
        2008 ns 6.1195e-06% btrfs_apply_pending_changes_duration
        9656 ns 2.9427e-05% switch_commit_roots_duration
        1598 ns 4.8700e-06% btrfs_commit_device_sizes_duration
        4314 ns 1.3147e-05% btrfs_free_log_root_tree_duration

Here I was only tracing functions that happen where we are between
START_COMMIT and UNBLOCKED in order to see what would be keeping us
blocked for so long.  The wait_for_commit() we do is where we wait for a
previous transaction that hasn't completed it's commit.  This can
include all of the unpin work and other cleanups, which tends to be the
longest part of our transaction commit.

There is no reason we should be blocking new things from entering the
transaction at this point, it just adds to random latency spikes for no
reason.

Fix this by adding a PREP stage.  This allows us to properly deal with
multiple committers coming in at the same time, we retain the behavior
that the winner waits on the previous transaction and the losers all
wait for this transaction commit to occur.  Nothing else is blocked
during the PREP stage, and then once the wait is complete we switch to
COMMIT_START and all of the same behavior as before is maintained.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/disk-io.c     |  8 ++++----
 fs/btrfs/locking.h     |  2 +-
 fs/btrfs/transaction.c | 39 ++++++++++++++++++++++++---------------
 fs/btrfs/transaction.h |  1 +
 4 files changed, 30 insertions(+), 20 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 0a96ea8c1d3a..639f1e308e4c 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -1547,7 +1547,7 @@ static int transaction_kthread(void *arg)
 
 		delta = ktime_get_seconds() - cur->start_time;
 		if (!test_and_clear_bit(BTRFS_FS_COMMIT_TRANS, &fs_info->flags) &&
-		    cur->state < TRANS_STATE_COMMIT_START &&
+		    cur->state < TRANS_STATE_COMMIT_PREP &&
 		    delta < fs_info->commit_interval) {
 			spin_unlock(&fs_info->trans_lock);
 			delay -= msecs_to_jiffies((delta - 1) * 1000);
@@ -2682,8 +2682,8 @@ void btrfs_init_fs_info(struct btrfs_fs_info *fs_info)
 	btrfs_lockdep_init_map(fs_info, btrfs_trans_num_extwriters);
 	btrfs_lockdep_init_map(fs_info, btrfs_trans_pending_ordered);
 	btrfs_lockdep_init_map(fs_info, btrfs_ordered_extent);
-	btrfs_state_lockdep_init_map(fs_info, btrfs_trans_commit_start,
-				     BTRFS_LOCKDEP_TRANS_COMMIT_START);
+	btrfs_state_lockdep_init_map(fs_info, btrfs_trans_commit_prep,
+				     BTRFS_LOCKDEP_TRANS_COMMIT_PREP);
 	btrfs_state_lockdep_init_map(fs_info, btrfs_trans_unblocked,
 				     BTRFS_LOCKDEP_TRANS_UNBLOCKED);
 	btrfs_state_lockdep_init_map(fs_info, btrfs_trans_super_committed,
@@ -4870,7 +4870,7 @@ static int btrfs_cleanup_transaction(struct btrfs_fs_info *fs_info)
 	while (!list_empty(&fs_info->trans_list)) {
 		t = list_first_entry(&fs_info->trans_list,
 				     struct btrfs_transaction, list);
-		if (t->state >= TRANS_STATE_COMMIT_START) {
+		if (t->state >= TRANS_STATE_COMMIT_PREP) {
 			refcount_inc(&t->use_count);
 			spin_unlock(&fs_info->trans_lock);
 			btrfs_wait_for_commit(fs_info, t->transid);
diff --git a/fs/btrfs/locking.h b/fs/btrfs/locking.h
index edb9b4a0dba1..7d6ee1e609bf 100644
--- a/fs/btrfs/locking.h
+++ b/fs/btrfs/locking.h
@@ -79,7 +79,7 @@ enum btrfs_lock_nesting {
 };
 
 enum btrfs_lockdep_trans_states {
-	BTRFS_LOCKDEP_TRANS_COMMIT_START,
+	BTRFS_LOCKDEP_TRANS_COMMIT_PREP,
 	BTRFS_LOCKDEP_TRANS_UNBLOCKED,
 	BTRFS_LOCKDEP_TRANS_SUPER_COMMITTED,
 	BTRFS_LOCKDEP_TRANS_COMPLETED,
diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index ab09542f2170..341363beaf10 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -56,12 +56,17 @@ static struct kmem_cache *btrfs_trans_handle_cachep;
  * |  Call btrfs_commit_transaction() on any trans handle attached to
  * |  transaction N
  * V
+ * Transaction N [[TRANS_STATE_COMMIT_PREP]]
+ * |
+ * | If there are simultaneous calls to btrfs_commit_transaction() one will win
+ * | the race and the rest will wait for the winner to commit the transaction.
+ * |
+ * | The winner will wait for previous running transaction to completely finish
+ * | if there is one.
+ * |
  * Transaction N [[TRANS_STATE_COMMIT_START]]
  * |
- * | Will wait for previous running transaction to completely finish if there
- * | is one
- * |
- * | Then one of the following happes:
+ * | Then one of the following happens:
  * | - Wait for all other trans handle holders to release.
  * |   The btrfs_commit_transaction() caller will do the commit work.
  * | - Wait for current transaction to be committed by others.
@@ -112,6 +117,7 @@ static struct kmem_cache *btrfs_trans_handle_cachep;
  */
 static const unsigned int btrfs_blocked_trans_types[TRANS_STATE_MAX] = {
 	[TRANS_STATE_RUNNING]		= 0U,
+	[TRANS_STATE_COMMIT_PREP]	= 0U,
 	[TRANS_STATE_COMMIT_START]	= (__TRANS_START | __TRANS_ATTACH),
 	[TRANS_STATE_COMMIT_DOING]	= (__TRANS_START |
 					   __TRANS_ATTACH |
@@ -1983,7 +1989,7 @@ void btrfs_commit_transaction_async(struct btrfs_trans_handle *trans)
 	 * Wait for the current transaction commit to start and block
 	 * subsequent transaction joins
 	 */
-	btrfs_might_wait_for_state(fs_info, BTRFS_LOCKDEP_TRANS_COMMIT_START);
+	btrfs_might_wait_for_state(fs_info, BTRFS_LOCKDEP_TRANS_COMMIT_PREP);
 	wait_event(fs_info->transaction_blocked_wait,
 		   cur_trans->state >= TRANS_STATE_COMMIT_START ||
 		   TRANS_ABORTED(cur_trans));
@@ -2130,7 +2136,7 @@ static void add_pending_snapshot(struct btrfs_trans_handle *trans)
 		return;
 
 	lockdep_assert_held(&trans->fs_info->trans_lock);
-	ASSERT(cur_trans->state >= TRANS_STATE_COMMIT_START);
+	ASSERT(cur_trans->state >= TRANS_STATE_COMMIT_PREP);
 
 	list_add(&trans->pending_snapshot->list, &cur_trans->pending_snapshots);
 }
@@ -2154,7 +2160,7 @@ int btrfs_commit_transaction(struct btrfs_trans_handle *trans)
 	ktime_t interval;
 
 	ASSERT(refcount_read(&trans->use_count) == 1);
-	btrfs_trans_state_lockdep_acquire(fs_info, BTRFS_LOCKDEP_TRANS_COMMIT_START);
+	btrfs_trans_state_lockdep_acquire(fs_info, BTRFS_LOCKDEP_TRANS_COMMIT_PREP);
 
 	clear_bit(BTRFS_FS_NEED_TRANS_COMMIT, &fs_info->flags);
 
@@ -2214,7 +2220,7 @@ int btrfs_commit_transaction(struct btrfs_trans_handle *trans)
 	}
 
 	spin_lock(&fs_info->trans_lock);
-	if (cur_trans->state >= TRANS_STATE_COMMIT_START) {
+	if (cur_trans->state >= TRANS_STATE_COMMIT_PREP) {
 		enum btrfs_trans_state want_state = TRANS_STATE_COMPLETED;
 
 		add_pending_snapshot(trans);
@@ -2226,7 +2232,7 @@ int btrfs_commit_transaction(struct btrfs_trans_handle *trans)
 			want_state = TRANS_STATE_SUPER_COMMITTED;
 
 		btrfs_trans_state_lockdep_release(fs_info,
-						  BTRFS_LOCKDEP_TRANS_COMMIT_START);
+						  BTRFS_LOCKDEP_TRANS_COMMIT_PREP);
 		ret = btrfs_end_transaction(trans);
 		wait_for_commit(cur_trans, want_state);
 
@@ -2238,9 +2244,9 @@ int btrfs_commit_transaction(struct btrfs_trans_handle *trans)
 		return ret;
 	}
 
-	cur_trans->state = TRANS_STATE_COMMIT_START;
+	cur_trans->state = TRANS_STATE_COMMIT_PREP;
 	wake_up(&fs_info->transaction_blocked_wait);
-	btrfs_trans_state_lockdep_release(fs_info, BTRFS_LOCKDEP_TRANS_COMMIT_START);
+	btrfs_trans_state_lockdep_release(fs_info, BTRFS_LOCKDEP_TRANS_COMMIT_PREP);
 
 	if (cur_trans->list.prev != &fs_info->trans_list) {
 		enum btrfs_trans_state want_state = TRANS_STATE_COMPLETED;
@@ -2261,11 +2267,9 @@ int btrfs_commit_transaction(struct btrfs_trans_handle *trans)
 			btrfs_put_transaction(prev_trans);
 			if (ret)
 				goto lockdep_release;
-		} else {
-			spin_unlock(&fs_info->trans_lock);
+			spin_lock(&fs_info->trans_lock);
 		}
 	} else {
-		spin_unlock(&fs_info->trans_lock);
 		/*
 		 * The previous transaction was aborted and was already removed
 		 * from the list of transactions at fs_info->trans_list. So we
@@ -2273,11 +2277,16 @@ int btrfs_commit_transaction(struct btrfs_trans_handle *trans)
 		 * corrupt state (pointing to trees with unwritten nodes/leafs).
 		 */
 		if (BTRFS_FS_ERROR(fs_info)) {
+			spin_unlock(&fs_info->trans_lock);
 			ret = -EROFS;
 			goto lockdep_release;
 		}
 	}
 
+	cur_trans->state = TRANS_STATE_COMMIT_START;
+	wake_up(&fs_info->transaction_blocked_wait);
+	spin_unlock(&fs_info->trans_lock);
+
 	/*
 	 * Get the time spent on the work done by the commit thread and not
 	 * the time spent waiting on a previous commit
@@ -2587,7 +2596,7 @@ int btrfs_commit_transaction(struct btrfs_trans_handle *trans)
 	goto cleanup_transaction;
 
 lockdep_trans_commit_start_release:
-	btrfs_trans_state_lockdep_release(fs_info, BTRFS_LOCKDEP_TRANS_COMMIT_START);
+	btrfs_trans_state_lockdep_release(fs_info, BTRFS_LOCKDEP_TRANS_COMMIT_PREP);
 	btrfs_end_transaction(trans);
 	return ret;
 }
diff --git a/fs/btrfs/transaction.h b/fs/btrfs/transaction.h
index 8e9fa23bd7fe..6b309f8a99a8 100644
--- a/fs/btrfs/transaction.h
+++ b/fs/btrfs/transaction.h
@@ -14,6 +14,7 @@
 
 enum btrfs_trans_state {
 	TRANS_STATE_RUNNING,
+	TRANS_STATE_COMMIT_PREP,
 	TRANS_STATE_COMMIT_START,
 	TRANS_STATE_COMMIT_DOING,
 	TRANS_STATE_UNBLOCKED,
-- 
2.26.3

