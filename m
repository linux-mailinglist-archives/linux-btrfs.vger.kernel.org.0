Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 44AD217E9E8
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Mar 2020 21:23:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726437AbgCIUX3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 9 Mar 2020 16:23:29 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:39892 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726096AbgCIUX2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 9 Mar 2020 16:23:28 -0400
Received: by mail-qk1-f193.google.com with SMTP id e16so10621166qkl.6
        for <linux-btrfs@vger.kernel.org>; Mon, 09 Mar 2020 13:23:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=63LpO6dYb/LHEHQztq+Eq95wgeKe8ztKpY5mOzbww1E=;
        b=z7Cvi5VOlvhkxCDc32OYWDel33L7JNLkHUBxSV0M5Igd00Pd50mo08CqFZHb16WDha
         wo+Z45lia6sU2Cx97wFt/9ryqoRjyUn0oSBb1gk+PjXf6Zh2GOJkErCoenGa7BKoNH/G
         DA+bJxAILfxmj6AgtgUCBeYiUFZU82gsK3dYGwrdlfsAPPXfl7Xq8uRccge15gL0hytC
         uYGryfVuXiGcb40XKeKz0VMJauyFXpMYzPq3iCpY0e7uryAyKXvAdZvVDSp3rCZba0jv
         +vE7Us1PVAi2peYZkwFEEMws4Mc6GVPydRKZw2mhCTyScT5lyxd5BpViUYrX2Fw9Wg9v
         mlnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=63LpO6dYb/LHEHQztq+Eq95wgeKe8ztKpY5mOzbww1E=;
        b=CrJ3aiKQXeTG9R6oTr07HNjkLQxpvgglnlWxIDW9A5Q9hjgCtLitVbTa6/vstUY+AX
         zWWHXO4R9AGJWdPfhOTEuc56ChMjGStgOiN3ydElColkjwwGTvJSsIzIr+5EJCp2FyqO
         r2uSG5tLFLcZUGyuPHPgOvuR3izeMvHR84gQzt7Q25TLnYJYZS/f7LBBZ7gSI38sWp0J
         88a7Z9zxLMvBo9QphDMgUfO/jXI9pxTS5fWQDYvCJOPmv+eLTKneUlXSCahoaePAIsN3
         JsyWOwLIz1dtkNVOfoS5OJ3qaKWfdZQuwy63ZuCFSKfRejsIBwcRNJWuNAHzm2bSqUXu
         LvMg==
X-Gm-Message-State: ANhLgQ2YQodbq+HAHdLnB5ASVg3XsIyJ3hMdF2DcqqUzaZVgkcVEJn2u
        K0rbt+d+tY2RtGkHgawbVlrYuj54HMQ=
X-Google-Smtp-Source: ADFU+vujr3TUf3d0o7qPWnZV0gwbN6SWbAmEnlcf/ZI1zAIOFoo1KcM2k0QyF2200FXiI/tKyyEodA==
X-Received: by 2002:ae9:f504:: with SMTP id o4mr3946999qkg.306.1583785407452;
        Mon, 09 Mar 2020 13:23:27 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id j4sm2602390qtn.78.2020.03.09.13.23.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2020 13:23:26 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 1/5] btrfs: Improve global reserve stealing logic
Date:   Mon,  9 Mar 2020 16:23:18 -0400
Message-Id: <20200309202322.12327-2-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200309202322.12327-1-josef@toxicpanda.com>
References: <20200309202322.12327-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

For unlink transactions and block group removal
btrfs_start_transaction_fallback_global_rsv will first try to start
an ordinary transaction and if it fails it will fall back to reserving
the required amount by stealing from the global reserve. This is sound
in theory but current code doesn't perform any locking or throttling so
if there are multiple concurrent unlink() callers they can deplete
the global reservation which will result in ENOSPC.

Fix this behavior by introducing BTRFS_RESERVE_FLUSH_ALL_STEAL. It's
used to mark unlink reservation. The flushing machinery is modified to
steal from global reservation when it sees such reservation being on the
brink of failure (in maybe_fail_all_tickets).

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/block-group.c |  2 +-
 fs/btrfs/ctree.h       |  1 +
 fs/btrfs/inode.c       |  2 +-
 fs/btrfs/space-info.c  | 38 +++++++++++++++++++++++++++++++++++++-
 fs/btrfs/space-info.h  |  1 +
 fs/btrfs/transaction.c | 42 +++++-------------------------------------
 fs/btrfs/transaction.h |  3 +--
 7 files changed, 47 insertions(+), 42 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 60e9bb136f34..faa04093b6b5 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -1171,7 +1171,7 @@ struct btrfs_trans_handle *btrfs_start_trans_remove_block_group(
 	free_extent_map(em);
 
 	return btrfs_start_transaction_fallback_global_rsv(fs_info->extent_root,
-							   num_items, 1);
+							   num_items);
 }
 
 /*
diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 2ccb2a090782..782c63f213e9 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -2528,6 +2528,7 @@ enum btrfs_reserve_flush_enum {
 	BTRFS_RESERVE_FLUSH_DATA,
 	BTRFS_RESERVE_FLUSH_FREE_SPACE_INODE,
 	BTRFS_RESERVE_FLUSH_ALL,
+	BTRFS_RESERVE_FLUSH_ALL_STEAL,
 };
 
 enum btrfs_flush_state {
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index b8dabffac767..4e3b115ef1d7 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -3617,7 +3617,7 @@ static struct btrfs_trans_handle *__unlink_start_trans(struct inode *dir)
 	 * 1 for the inode ref
 	 * 1 for the inode
 	 */
-	return btrfs_start_transaction_fallback_global_rsv(root, 5, 5);
+	return btrfs_start_transaction_fallback_global_rsv(root, 5);
 }
 
 static int btrfs_unlink(struct inode *dir, struct dentry *dentry)
diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 26e1c492b9b5..9c9a4933f72b 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -810,6 +810,35 @@ static inline int need_do_async_reclaim(struct btrfs_fs_info *fs_info,
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
+	min_bytes = div_factor(global_rsv->size, 1);
+	if (global_rsv->reserved < min_bytes + ticket->bytes) {
+		spin_unlock(&global_rsv->lock);
+		return false;
+	}
+	global_rsv->reserved -= ticket->bytes;
+	ticket->bytes = 0;
+	trace_printk("Satisfied ticket from global rsv\n");
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
@@ -842,6 +871,10 @@ static bool maybe_fail_all_tickets(struct btrfs_fs_info *fs_info,
 		ticket = list_first_entry(&space_info->tickets,
 					  struct reserve_ticket, list);
 
+		if (ticket->steal &&
+		    steal_from_global_rsv(fs_info, space_info, ticket))
+			return true;
+
 		/*
 		 * may_commit_transaction will avoid committing the transaction
 		 * if it doesn't feel like the space reclaimed by the commit
@@ -1195,6 +1228,7 @@ static int handle_reserve_ticket(struct btrfs_fs_info *fs_info,
 	switch (flush) {
 	case BTRFS_RESERVE_FLUSH_DATA:
 	case BTRFS_RESERVE_FLUSH_ALL:
+	case BTRFS_RESERVE_FLUSH_ALL_STEAL:
 		wait_reserve_ticket(fs_info, space_info, ticket);
 		break;
 	case BTRFS_RESERVE_FLUSH_LIMIT:
@@ -1300,8 +1334,10 @@ static int __reserve_bytes(struct btrfs_fs_info *fs_info,
 		ticket.bytes = orig_bytes;
 		ticket.error = 0;
 		init_waitqueue_head(&ticket.wait);
+		ticket.steal = (flush == BTRFS_RESERVE_FLUSH_ALL_STEAL);
 		if (flush == BTRFS_RESERVE_FLUSH_ALL ||
-		    flush == BTRFS_RESERVE_FLUSH_DATA) {
+		    flush == BTRFS_RESERVE_FLUSH_DATA ||
+		    flush == BTRFS_RESERVE_FLUSH_ALL_STEAL) {
 			list_add_tail(&ticket.list, &space_info->tickets);
 			if (!space_info->flush) {
 				space_info->flush = 1;
diff --git a/fs/btrfs/space-info.h b/fs/btrfs/space-info.h
index 179f757c4a6b..a7f600efb772 100644
--- a/fs/btrfs/space-info.h
+++ b/fs/btrfs/space-info.h
@@ -71,6 +71,7 @@ struct btrfs_space_info {
 struct reserve_ticket {
 	u64 bytes;
 	int error;
+	bool steal;
 	struct list_head list;
 	wait_queue_head_t wait;
 };
diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index 53af0f55f5f9..d171fd52c82b 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -559,7 +559,8 @@ start_transaction(struct btrfs_root *root, unsigned int num_items,
 		 * refill that amount for whatever is missing in the reserve.
 		 */
 		num_bytes = btrfs_calc_insert_metadata_size(fs_info, num_items);
-		if (delayed_refs_rsv->full == 0) {
+		if (flush == BTRFS_RESERVE_FLUSH_ALL &&
+		    delayed_refs_rsv->full == 0) {
 			delayed_refs_bytes = num_bytes;
 			num_bytes <<= 1;
 		}
@@ -686,43 +687,10 @@ struct btrfs_trans_handle *btrfs_start_transaction(struct btrfs_root *root,
 
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
index 453cea7c7a72..228e8b560e42 100644
--- a/fs/btrfs/transaction.h
+++ b/fs/btrfs/transaction.h
@@ -192,8 +192,7 @@ struct btrfs_trans_handle *btrfs_start_transaction(struct btrfs_root *root,
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
2.24.1

