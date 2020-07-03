Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29BBF213407
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Jul 2020 08:19:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726343AbgGCGTO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 3 Jul 2020 02:19:14 -0400
Received: from mx2.suse.de ([195.135.220.15]:49844 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725764AbgGCGTN (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 3 Jul 2020 02:19:13 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 769E0B020
        for <linux-btrfs@vger.kernel.org>; Fri,  3 Jul 2020 06:19:11 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 3/3] btrfs: qgroup: remove the ASYNC_COMMIT mechanism in favor of qgroup  reserve retry-after-EDQUOT
Date:   Fri,  3 Jul 2020 14:19:02 +0800
Message-Id: <20200703061902.33350-4-wqu@suse.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200703061902.33350-1-wqu@suse.com>
References: <20200703061902.33350-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

commit a514d63882c3 ("btrfs: qgroup: Commit transaction in advance to
reduce early EDQUOT") tries to reduce the early EDQUOT problems by
checking the qgroup free against threshold and try to wake up commit
kthread to free some space.

The problem of that mechanism is, it can only free qgroup per-trans
metadata space, can't do anything to data, nor prealloc qgroup space.

Now since we have the ability to flush qgroup space, and implements
retry-after-EDQUOT behavior, such mechanism is completely replaced.

So this patch will cleanup such mechanism in favor of
retry-after-EDQUOT.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/ctree.h       |  5 -----
 fs/btrfs/disk-io.c     |  1 -
 fs/btrfs/qgroup.c      | 43 ++----------------------------------------
 fs/btrfs/transaction.c |  1 -
 fs/btrfs/transaction.h | 14 --------------
 5 files changed, 2 insertions(+), 62 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 891f47c7891f..373567c168ac 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -545,11 +545,6 @@ enum {
 	 * (device replace, resize, device add/delete, balance)
 	 */
 	BTRFS_FS_EXCL_OP,
-	/*
-	 * To info transaction_kthread we need an immediate commit so it
-	 * doesn't need to wait for commit_interval
-	 */
-	BTRFS_FS_NEED_ASYNC_COMMIT,
 	/*
 	 * Indicate that balance has been set up from the ioctl and is in the
 	 * main phase. The fs_info::balance_ctl is initialized.
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 0116e0b487c9..3b80d88e6ab2 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -1746,7 +1746,6 @@ static int transaction_kthread(void *arg)
 
 		now = ktime_get_seconds();
 		if (cur->state < TRANS_STATE_COMMIT_START &&
-		    !test_bit(BTRFS_FS_NEED_ASYNC_COMMIT, &fs_info->flags) &&
 		    (now < cur->start_time ||
 		     now - cur->start_time < fs_info->commit_interval)) {
 			spin_unlock(&fs_info->trans_lock);
diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index bf9076bc33eb..fd313834013b 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -11,7 +11,6 @@
 #include <linux/slab.h>
 #include <linux/workqueue.h>
 #include <linux/btrfs.h>
-#include <linux/sizes.h>
 
 #include "ctree.h"
 #include "transaction.h"
@@ -2895,20 +2894,8 @@ int btrfs_qgroup_inherit(struct btrfs_trans_handle *trans, u64 srcid,
 	return ret;
 }
 
-/*
- * Two limits to commit transaction in advance.
- *
- * For RATIO, it will be 1/RATIO of the remaining limit as threshold.
- * For SIZE, it will be in byte unit as threshold.
- */
-#define QGROUP_FREE_RATIO		32
-#define QGROUP_FREE_SIZE		SZ_32M
-static bool qgroup_check_limits(struct btrfs_fs_info *fs_info,
-				const struct btrfs_qgroup *qg, u64 num_bytes)
+static bool qgroup_check_limits(const struct btrfs_qgroup *qg, u64 num_bytes)
 {
-	u64 free;
-	u64 threshold;
-
 	if ((qg->lim_flags & BTRFS_QGROUP_LIMIT_MAX_RFER) &&
 	    qgroup_rsv_total(qg) + (s64)qg->rfer + num_bytes > qg->max_rfer)
 		return false;
@@ -2917,32 +2904,6 @@ static bool qgroup_check_limits(struct btrfs_fs_info *fs_info,
 	    qgroup_rsv_total(qg) + (s64)qg->excl + num_bytes > qg->max_excl)
 		return false;
 
-	/*
-	 * Even if we passed the check, it's better to check if reservation
-	 * for meta_pertrans is pushing us near limit.
-	 * If there is too much pertrans reservation or it's near the limit,
-	 * let's try commit transaction to free some, using transaction_kthread
-	 */
-	if ((qg->lim_flags & (BTRFS_QGROUP_LIMIT_MAX_RFER |
-			      BTRFS_QGROUP_LIMIT_MAX_EXCL))) {
-		if (qg->lim_flags & BTRFS_QGROUP_LIMIT_MAX_EXCL) {
-			free = qg->max_excl - qgroup_rsv_total(qg) - qg->excl;
-			threshold = min_t(u64, qg->max_excl / QGROUP_FREE_RATIO,
-					  QGROUP_FREE_SIZE);
-		} else {
-			free = qg->max_rfer - qgroup_rsv_total(qg) - qg->rfer;
-			threshold = min_t(u64, qg->max_rfer / QGROUP_FREE_RATIO,
-					  QGROUP_FREE_SIZE);
-		}
-
-		/*
-		 * Use transaction_kthread to commit transaction, so we no
-		 * longer need to bother nested transaction nor lock context.
-		 */
-		if (free < threshold)
-			btrfs_commit_transaction_locksafe(fs_info);
-	}
-
 	return true;
 }
 
@@ -2990,7 +2951,7 @@ static int qgroup_reserve(struct btrfs_root *root, u64 num_bytes, bool enforce,
 
 		qg = unode_aux_to_qgroup(unode);
 
-		if (enforce && !qgroup_check_limits(fs_info, qg, num_bytes)) {
+		if (enforce && !qgroup_check_limits(qg, num_bytes)) {
 			ret = -EDQUOT;
 			goto out;
 		}
diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index b359d4b17658..d0a6150bf82d 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -2351,7 +2351,6 @@ int btrfs_commit_transaction(struct btrfs_trans_handle *trans)
 	 */
 	cur_trans->state = TRANS_STATE_COMPLETED;
 	wake_up(&cur_trans->commit_wait);
-	clear_bit(BTRFS_FS_NEED_ASYNC_COMMIT, &fs_info->flags);
 
 	spin_lock(&fs_info->trans_lock);
 	list_del_init(&cur_trans->list);
diff --git a/fs/btrfs/transaction.h b/fs/btrfs/transaction.h
index 6f65fff6cf50..0b18d25aa9b6 100644
--- a/fs/btrfs/transaction.h
+++ b/fs/btrfs/transaction.h
@@ -208,20 +208,6 @@ int btrfs_clean_one_deleted_snapshot(struct btrfs_root *root);
 int btrfs_commit_transaction(struct btrfs_trans_handle *trans);
 int btrfs_commit_transaction_async(struct btrfs_trans_handle *trans,
 				   int wait_for_unblock);
-
-/*
- * Try to commit transaction asynchronously, so this is safe to call
- * even holding a spinlock.
- *
- * It's done by informing transaction_kthread to commit transaction without
- * waiting for commit interval.
- */
-static inline void btrfs_commit_transaction_locksafe(
-		struct btrfs_fs_info *fs_info)
-{
-	set_bit(BTRFS_FS_NEED_ASYNC_COMMIT, &fs_info->flags);
-	wake_up_process(fs_info->transaction_kthread);
-}
 int btrfs_end_transaction_throttle(struct btrfs_trans_handle *trans);
 int btrfs_should_end_transaction(struct btrfs_trans_handle *trans);
 void btrfs_throttle(struct btrfs_fs_info *fs_info);
-- 
2.27.0

