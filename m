Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 55F3B98C66
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Aug 2019 09:25:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731550AbfHVHZS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 22 Aug 2019 03:25:18 -0400
Received: from mx2.suse.de ([195.135.220.15]:36188 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729718AbfHVHZR (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 22 Aug 2019 03:25:17 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 13A0BAEBB
        for <linux-btrfs@vger.kernel.org>; Thu, 22 Aug 2019 07:25:16 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 2/2] btrfs: transaction: Cleanup unused TRANS_STATE_BLOCKED
Date:   Thu, 22 Aug 2019 15:25:00 +0800
Message-Id: <20190822072500.22730-2-wqu@suse.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190822072500.22730-1-wqu@suse.com>
References: <20190822072500.22730-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The state is introduced in commit 4a9d8bdee368 ("Btrfs: make the state
of the transaction more readable"), then in commit 302167c50b32
("btrfs: don't end the transaction for delayed refs in throttle") the
state is completely removed.

So we can just clean up the state since it's only compared but never
set.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/disk-io.c     |  2 +-
 fs/btrfs/transaction.c | 15 +++------------
 fs/btrfs/transaction.h |  1 -
 3 files changed, 4 insertions(+), 14 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 97beb351a10c..3866cca4ae5d 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -1771,7 +1771,7 @@ static int transaction_kthread(void *arg)
 		}
 
 		now = ktime_get_seconds();
-		if (cur->state < TRANS_STATE_BLOCKED &&
+		if (cur->state < TRANS_STATE_COMMIT_START &&
 		    !test_bit(BTRFS_FS_NEED_ASYNC_COMMIT, &fs_info->flags) &&
 		    (now < cur->start_time ||
 		     now - cur->start_time < fs_info->commit_interval)) {
diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index 6568eca28b43..bfd946427f80 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -94,7 +94,6 @@
  */
 static const unsigned int btrfs_blocked_trans_types[TRANS_STATE_MAX] = {
 	[TRANS_STATE_RUNNING]		= 0U,
-	[TRANS_STATE_BLOCKED]		=  __TRANS_START,
 	[TRANS_STATE_COMMIT_START]	= (__TRANS_START | __TRANS_ATTACH),
 	[TRANS_STATE_COMMIT_DOING]	= (__TRANS_START |
 					   __TRANS_ATTACH |
@@ -451,7 +450,7 @@ int btrfs_record_root_in_trans(struct btrfs_trans_handle *trans,
 
 static inline int is_transaction_blocked(struct btrfs_transaction *trans)
 {
-	return (trans->state >= TRANS_STATE_BLOCKED &&
+	return (trans->state >= TRANS_STATE_COMMIT_START &&
 		trans->state < TRANS_STATE_UNBLOCKED &&
 		!trans->aborted);
 }
@@ -638,7 +637,7 @@ start_transaction(struct btrfs_root *root, unsigned int num_items,
 	INIT_LIST_HEAD(&h->new_bgs);
 
 	smp_mb();
-	if (cur_trans->state >= TRANS_STATE_BLOCKED &&
+	if (cur_trans->state >= TRANS_STATE_COMMIT_START &&
 	    may_wait_transaction(fs_info, type)) {
 		current->journal_info = h;
 		btrfs_commit_transaction(h);
@@ -866,7 +865,7 @@ int btrfs_should_end_transaction(struct btrfs_trans_handle *trans)
 	struct btrfs_transaction *cur_trans = trans->transaction;
 
 	smp_mb();
-	if (cur_trans->state >= TRANS_STATE_BLOCKED ||
+	if (cur_trans->state >= TRANS_STATE_COMMIT_START ||
 	    cur_trans->delayed_refs.flushing)
 		return 1;
 
@@ -899,7 +898,6 @@ static int __btrfs_end_transaction(struct btrfs_trans_handle *trans,
 {
 	struct btrfs_fs_info *info = trans->fs_info;
 	struct btrfs_transaction *cur_trans = trans->transaction;
-	int lock = (trans->type != TRANS_JOIN_NOLOCK);
 	int err = 0;
 
 	if (refcount_read(&trans->use_count) > 1) {
@@ -915,13 +913,6 @@ static int __btrfs_end_transaction(struct btrfs_trans_handle *trans,
 
 	btrfs_trans_release_chunk_metadata(trans);
 
-	if (lock && READ_ONCE(cur_trans->state) == TRANS_STATE_BLOCKED) {
-		if (throttle)
-			return btrfs_commit_transaction(trans);
-		else
-			wake_up_process(info->transaction_kthread);
-	}
-
 	if (trans->type & __TRANS_FREEZABLE)
 		sb_end_intwrite(info->sb);
 
diff --git a/fs/btrfs/transaction.h b/fs/btrfs/transaction.h
index 2c5a6f6e5bb0..78b339fbc44f 100644
--- a/fs/btrfs/transaction.h
+++ b/fs/btrfs/transaction.h
@@ -13,7 +13,6 @@
 
 enum btrfs_trans_state {
 	TRANS_STATE_RUNNING,
-	TRANS_STATE_BLOCKED,
 	TRANS_STATE_COMMIT_START,
 	TRANS_STATE_COMMIT_DOING,
 	TRANS_STATE_UNBLOCKED,
-- 
2.23.0

