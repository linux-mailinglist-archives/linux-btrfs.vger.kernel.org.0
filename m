Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D89B41F2F26
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Jun 2020 02:48:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729990AbgFIArs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 8 Jun 2020 20:47:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:57952 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728870AbgFHXLQ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 8 Jun 2020 19:11:16 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2926320890;
        Mon,  8 Jun 2020 23:11:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591657874;
        bh=UYYNl0Yb/dq/K1p1LK/ZDi5h3/DWZcAP6Qa7A1d8NYA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=m2FhsHaNATtLcT+7a2uGsJZswE4RkB4JRKulfBb1QqRnsTrqdPzqT6CoG0xFoN0xm
         1eM4iFYvbH1v8sKQ+yS9cS/+bOT+dKLaewr3H/PuRCj6vEs6QK7yM2yIXOwiWVsQFg
         U6HEwyujYXiw/SmAtk50ORBOS5vF3et4ckOXDtkQ=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Josef Bacik <josef@toxicpanda.com>,
        Nikolay Borisov <nborisov@suse.com>,
        David Sterba <dsterba@suse.com>,
        Sasha Levin <sashal@kernel.org>, linux-btrfs@vger.kernel.org
Subject: [PATCH AUTOSEL 5.7 232/274] btrfs: improve global reserve stealing logic
Date:   Mon,  8 Jun 2020 19:05:25 -0400
Message-Id: <20200608230607.3361041-232-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200608230607.3361041-1-sashal@kernel.org>
References: <20200608230607.3361041-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Josef Bacik <josef@toxicpanda.com>

[ Upstream commit 7f9fe614407692f670601a634621138233ac00d7 ]

For unlink transactions and block group removal
btrfs_start_transaction_fallback_global_rsv will first try to start an
ordinary transaction and if it fails it will fall back to reserving the
required amount by stealing from the global reserve. This is problematic
because of all the same reasons we had with previous iterations of the
ENOSPC handling, thundering herd.  We get a bunch of failures all at
once, everybody tries to allocate from the global reserve, some win and
some lose, we get an ENSOPC.

Fix this behavior by introducing BTRFS_RESERVE_FLUSH_ALL_STEAL. It's
used to mark unlink reservation. To fix this we need to integrate this
logic into the normal ENOSPC infrastructure.  We still go through all of
the normal flushing work, and at the moment we begin to fail all the
tickets we try to satisfy any tickets that are allowed to steal by
stealing from the global reserve.  If this works we start the flushing
system over again just like we would with a normal ticket satisfaction.
This serializes our global reserve stealing, so we don't have the
thundering herd problem.

Reviewed-by: Nikolay Borisov <nborisov@suse.com>
Tested-by: Nikolay Borisov <nborisov@suse.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/block-group.c |  2 +-
 fs/btrfs/ctree.h       |  1 +
 fs/btrfs/inode.c       |  2 +-
 fs/btrfs/space-info.c  | 37 ++++++++++++++++++++++++++++++++++++-
 fs/btrfs/space-info.h  |  1 +
 fs/btrfs/transaction.c | 42 +++++-------------------------------------
 fs/btrfs/transaction.h |  3 +--
 7 files changed, 46 insertions(+), 42 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 696f47103cfc..233c5663f233 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -1175,7 +1175,7 @@ struct btrfs_trans_handle *btrfs_start_trans_remove_block_group(
 	free_extent_map(em);
 
 	return btrfs_start_transaction_fallback_global_rsv(fs_info->extent_root,
-							   num_items, 1);
+							   num_items);
 }
 
 /*
diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 8aa7b9dac405..3510e33706c1 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -2512,6 +2512,7 @@ enum btrfs_reserve_flush_enum {
 	BTRFS_RESERVE_FLUSH_LIMIT,
 	BTRFS_RESERVE_FLUSH_EVICT,
 	BTRFS_RESERVE_FLUSH_ALL,
+	BTRFS_RESERVE_FLUSH_ALL_STEAL,
 };
 
 enum btrfs_flush_state {
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 320d1062068d..259239b33370 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -3618,7 +3618,7 @@ static struct btrfs_trans_handle *__unlink_start_trans(struct inode *dir)
 	 * 1 for the inode ref
 	 * 1 for the inode
 	 */
-	return btrfs_start_transaction_fallback_global_rsv(root, 5, 5);
+	return btrfs_start_transaction_fallback_global_rsv(root, 5);
 }
 
 static int btrfs_unlink(struct inode *dir, struct dentry *dentry)
diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 3c0e9999bfd7..eee6748c49e4 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -862,6 +862,34 @@ static inline int need_do_async_reclaim(struct btrfs_fs_info *fs_info,
 		!test_bit(BTRFS_FS_STATE_REMOUNTING, &fs_info->fs_state));
 }
 
+static bool steal_from_global_rsv(struct btrfs_fs_info *fs_info,
+				  struct btrfs_space_info *space_info,
+				  struct reserve_ticket *ticket)
+{
+	struct btrfs_block_rsv *global_rsv = &fs_info->global_block_rsv;
+	u64 min_bytes;
+
+	if (global_rsv->space_info != space_info)
+		return false;
+
+	spin_lock(&global_rsv->lock);
+	min_bytes = div_factor(global_rsv->size, 5);
+	if (global_rsv->reserved < min_bytes + ticket->bytes) {
+		spin_unlock(&global_rsv->lock);
+		return false;
+	}
+	global_rsv->reserved -= ticket->bytes;
+	ticket->bytes = 0;
+	list_del_init(&ticket->list);
+	wake_up(&ticket->wait);
+	space_info->tickets_id++;
+	if (global_rsv->reserved < global_rsv->size)
+		global_rsv->full = 0;
+	spin_unlock(&global_rsv->lock);
+
+	return true;
+}
+
 /*
  * maybe_fail_all_tickets - we've exhausted our flushing, start failing tickets
  * @fs_info - fs_info for this fs
@@ -894,6 +922,10 @@ static bool maybe_fail_all_tickets(struct btrfs_fs_info *fs_info,
 		ticket = list_first_entry(&space_info->tickets,
 					  struct reserve_ticket, list);
 
+		if (ticket->steal &&
+		    steal_from_global_rsv(fs_info, space_info, ticket))
+			return true;
+
 		/*
 		 * may_commit_transaction will avoid committing the transaction
 		 * if it doesn't feel like the space reclaimed by the commit
@@ -1110,6 +1142,7 @@ static int handle_reserve_ticket(struct btrfs_fs_info *fs_info,
 
 	switch (flush) {
 	case BTRFS_RESERVE_FLUSH_ALL:
+	case BTRFS_RESERVE_FLUSH_ALL_STEAL:
 		wait_reserve_ticket(fs_info, space_info, ticket);
 		break;
 	case BTRFS_RESERVE_FLUSH_LIMIT:
@@ -1209,7 +1242,9 @@ static int __reserve_metadata_bytes(struct btrfs_fs_info *fs_info,
 		ticket.error = 0;
 		space_info->reclaim_size += ticket.bytes;
 		init_waitqueue_head(&ticket.wait);
-		if (flush == BTRFS_RESERVE_FLUSH_ALL) {
+		ticket.steal = (flush == BTRFS_RESERVE_FLUSH_ALL_STEAL);
+		if (flush == BTRFS_RESERVE_FLUSH_ALL ||
+		    flush == BTRFS_RESERVE_FLUSH_ALL_STEAL) {
 			list_add_tail(&ticket.list, &space_info->tickets);
 			if (!space_info->flush) {
 				space_info->flush = 1;
diff --git a/fs/btrfs/space-info.h b/fs/btrfs/space-info.h
index 0a5001ef1481..c3c64019950a 100644
--- a/fs/btrfs/space-info.h
+++ b/fs/btrfs/space-info.h
@@ -78,6 +78,7 @@ struct btrfs_space_info {
 struct reserve_ticket {
 	u64 bytes;
 	int error;
+	bool steal;
 	struct list_head list;
 	wait_queue_head_t wait;
 };
diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index 2d5498136e5e..b5da5d8342dc 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -563,7 +563,8 @@ start_transaction(struct btrfs_root *root, unsigned int num_items,
 		 * refill that amount for whatever is missing in the reserve.
 		 */
 		num_bytes = btrfs_calc_insert_metadata_size(fs_info, num_items);
-		if (delayed_refs_rsv->full == 0) {
+		if (flush == BTRFS_RESERVE_FLUSH_ALL &&
+		    delayed_refs_rsv->full == 0) {
 			delayed_refs_bytes = num_bytes;
 			num_bytes <<= 1;
 		}
@@ -699,43 +700,10 @@ struct btrfs_trans_handle *btrfs_start_transaction(struct btrfs_root *root,
 
 struct btrfs_trans_handle *btrfs_start_transaction_fallback_global_rsv(
 					struct btrfs_root *root,
-					unsigned int num_items,
-					int min_factor)
+					unsigned int num_items)
 {
-	struct btrfs_fs_info *fs_info = root->fs_info;
-	struct btrfs_trans_handle *trans;
-	u64 num_bytes;
-	int ret;
-
-	/*
-	 * We have two callers: unlink and block group removal.  The
-	 * former should succeed even if we will temporarily exceed
-	 * quota and the latter operates on the extent root so
-	 * qgroup enforcement is ignored anyway.
-	 */
-	trans = start_transaction(root, num_items, TRANS_START,
-				  BTRFS_RESERVE_FLUSH_ALL, false);
-	if (!IS_ERR(trans) || PTR_ERR(trans) != -ENOSPC)
-		return trans;
-
-	trans = btrfs_start_transaction(root, 0);
-	if (IS_ERR(trans))
-		return trans;
-
-	num_bytes = btrfs_calc_insert_metadata_size(fs_info, num_items);
-	ret = btrfs_cond_migrate_bytes(fs_info, &fs_info->trans_block_rsv,
-				       num_bytes, min_factor);
-	if (ret) {
-		btrfs_end_transaction(trans);
-		return ERR_PTR(ret);
-	}
-
-	trans->block_rsv = &fs_info->trans_block_rsv;
-	trans->bytes_reserved = num_bytes;
-	trace_btrfs_space_reservation(fs_info, "transaction",
-				      trans->transid, num_bytes, 1);
-
-	return trans;
+	return start_transaction(root, num_items, TRANS_START,
+				 BTRFS_RESERVE_FLUSH_ALL_STEAL, false);
 }
 
 struct btrfs_trans_handle *btrfs_join_transaction(struct btrfs_root *root)
diff --git a/fs/btrfs/transaction.h b/fs/btrfs/transaction.h
index 31ae8d273065..bf102e64bfb2 100644
--- a/fs/btrfs/transaction.h
+++ b/fs/btrfs/transaction.h
@@ -193,8 +193,7 @@ struct btrfs_trans_handle *btrfs_start_transaction(struct btrfs_root *root,
 						   unsigned int num_items);
 struct btrfs_trans_handle *btrfs_start_transaction_fallback_global_rsv(
 					struct btrfs_root *root,
-					unsigned int num_items,
-					int min_factor);
+					unsigned int num_items);
 struct btrfs_trans_handle *btrfs_join_transaction(struct btrfs_root *root);
 struct btrfs_trans_handle *btrfs_join_transaction_spacecache(struct btrfs_root *root);
 struct btrfs_trans_handle *btrfs_join_transaction_nostart(struct btrfs_root *root);
-- 
2.25.1

