Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5188C77F060
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Aug 2023 08:07:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348169AbjHQGGn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 17 Aug 2023 02:06:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348138AbjHQGGb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 17 Aug 2023 02:06:31 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE5262D56
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Aug 2023 23:06:29 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 7DDF91F895
        for <linux-btrfs@vger.kernel.org>; Thu, 17 Aug 2023 06:06:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1692252388; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=p5emnawyjmAWAdVhKUeLwgHZXeqxIVmt1H61i/Ucv0U=;
        b=MeWFz8av9o620rAJJeCZiSKXC6yRtNSn0UMX+qpDZFbFIa6C4nY8KoR20bMI8lPr2bi1Je
        FW5HPd1bF5yCFfKDJFsZRoS5mpBvhwFxyt6jzn+0O5mhIJ8i0fa59Uo4bgTvrjthYs7DJN
        rz0p9Im966wV3l4HkHM/lXVWyCpqojg=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D13181392B
        for <linux-btrfs@vger.kernel.org>; Thu, 17 Aug 2023 06:06:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id NMpKJuO43WT4EQAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Thu, 17 Aug 2023 06:06:27 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2] btrfs: prevent metadata flush from being interrupted for del_balance_item()
Date:   Thu, 17 Aug 2023 14:06:24 +0800
Message-ID: <dfcb047887dbec9f252835fce458564f991fcd02.1692252334.git.wqu@suse.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[BUG]

There is an internal bug report that there are only 3 lines of btrfs
errors, then btrfs falls read-only:

 [358958.022131] BTRFS info (device dm-9): balance: canceled
 [358958.022148] BTRFS: error (device dm-9) in __cancel_balance:4014: errno=-4 unknown
 [358958.022150] BTRFS info (device dm-9): forced readonly

[CAUSE]
The error number -4 is -EINTR, and according to the code line (although
backported kernel, the code is still relevant upstream), it's the
btrfs_handle_fs_error() call inside reset_balance_state().

This can happen when we try to start a transaction which requires
metadata flushing.

This metadata flushing can be interrupted by signal, thus it can return
-EINTR.

For our case, the -EINTR is deadly because we are unable to handle the
interrupted metadata flushing at this timing, and would immediately mark
the fs read-only in the following call chain:

reset_balance_state()
|- del_balance_item()
|  `- btrfs_start_transation_fallback_global_rsv()
|     `- start_transaction()
|	 `- btrfs_block_rsv_add()
|	    `- __reserve_bytes()
|	       `- handle_reserve_ticket()
|		  `- wait_reserve_ticket()
|		     `- prepare_to_wait_event()
|			This wait has TASK_KILLABLE, thus can be
|			interrupted.
|			Thus we return -EINTR.
|
|- IS_ERR(trans) triggered
|- btrfs_handle_fs_error()
   The fs is marked read-only.

[FIX]
For this particular call site, we can not afford just erroring out with
-EINTR.

Thus here we introduce a new flush type,
BTRFS_RESERVE_FLUSH_ALL_STEAL_UNINTERRUPTIBLE, for this call site.

This new flush type would wait for the ticket using TASK_UNINTERRUPTIBLE
instead, thus it won't be interrupted by signal.

Since we're here, also enhance the error message a little to make it
more readable.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
Changelog:
v2:
- Instead retrying, introduce a new flush type
  The retrying can lead to dead loop as inside kernel space the signal
  won't be cleared until we reach user space.
  Thus we may retry forever.

  Instead going TASK_UNINTERRUPTIBLE for this particular callsite would
  be a safer bet.
---
 fs/btrfs/space-info.c  | 11 +++++++++--
 fs/btrfs/space-info.h  |  5 +++++
 fs/btrfs/transaction.c |  9 +++++++++
 fs/btrfs/transaction.h |  3 +++
 fs/btrfs/volumes.c     |  8 ++++++--
 5 files changed, 32 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index d7e8cd4f140c..6fce57c6f2a1 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -1454,15 +1454,21 @@ static void priority_reclaim_data_space(struct btrfs_fs_info *fs_info,
 
 static void wait_reserve_ticket(struct btrfs_fs_info *fs_info,
 				struct btrfs_space_info *space_info,
+				enum btrfs_reserve_flush_enum flush,
 				struct reserve_ticket *ticket)
 
 {
+	int state;
 	DEFINE_WAIT(wait);
 	int ret = 0;
 
+	if (flush == BTRFS_RESERVE_FLUSH_ALL_STEAL_UNINTERRUPTIBLE)
+		state = TASK_UNINTERRUPTIBLE;
+	else
+		state = TASK_KILLABLE;
 	spin_lock(&space_info->lock);
 	while (ticket->bytes > 0 && ticket->error == 0) {
-		ret = prepare_to_wait_event(&ticket->wait, &wait, TASK_KILLABLE);
+		ret = prepare_to_wait_event(&ticket->wait, &wait, state);
 		if (ret) {
 			/*
 			 * Delete us from the list. After we unlock the space
@@ -1511,7 +1517,8 @@ static int handle_reserve_ticket(struct btrfs_fs_info *fs_info,
 	case BTRFS_RESERVE_FLUSH_DATA:
 	case BTRFS_RESERVE_FLUSH_ALL:
 	case BTRFS_RESERVE_FLUSH_ALL_STEAL:
-		wait_reserve_ticket(fs_info, space_info, ticket);
+	case BTRFS_RESERVE_FLUSH_ALL_STEAL_UNINTERRUPTIBLE:
+		wait_reserve_ticket(fs_info, space_info, flush, ticket);
 		break;
 	case BTRFS_RESERVE_FLUSH_LIMIT:
 		priority_reclaim_metadata_space(fs_info, space_info, ticket,
diff --git a/fs/btrfs/space-info.h b/fs/btrfs/space-info.h
index 0bb9d14e60a8..e9d8243da0fc 100644
--- a/fs/btrfs/space-info.h
+++ b/fs/btrfs/space-info.h
@@ -50,6 +50,11 @@ enum btrfs_reserve_flush_enum {
 	 */
 	BTRFS_RESERVE_FLUSH_ALL_STEAL,
 
+	/*
+	 * The same as BTRFS_RESERVE_FLUSH_ALL_STEAL, but won't be interrupred.
+	 */
+	BTRFS_RESERVE_FLUSH_ALL_STEAL_UNINTERRUPTIBLE,
+
 	/*
 	 * This is for btrfs_use_block_rsv only.  We have exhausted our block
 	 * rsv and our global block rsv.  This can happen for things like
diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index ab09542f2170..6a09e80b6875 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -785,6 +785,15 @@ struct btrfs_trans_handle *btrfs_start_transaction_fallback_global_rsv(
 				 BTRFS_RESERVE_FLUSH_ALL_STEAL, false);
 }
 
+struct btrfs_trans_handle *btrfs_start_transaction_fallback_uninterruptible(
+					struct btrfs_root *root,
+					unsigned int num_items)
+{
+	return start_transaction(root, num_items, TRANS_START,
+				 BTRFS_RESERVE_FLUSH_ALL_STEAL_UNINTERRUPTIBLE,
+				 false);
+}
+
 struct btrfs_trans_handle *btrfs_join_transaction(struct btrfs_root *root)
 {
 	return start_transaction(root, 0, TRANS_JOIN, BTRFS_RESERVE_NO_FLUSH,
diff --git a/fs/btrfs/transaction.h b/fs/btrfs/transaction.h
index 8e9fa23bd7fe..06f245e6c546 100644
--- a/fs/btrfs/transaction.h
+++ b/fs/btrfs/transaction.h
@@ -233,6 +233,9 @@ struct btrfs_trans_handle *btrfs_start_transaction(struct btrfs_root *root,
 struct btrfs_trans_handle *btrfs_start_transaction_fallback_global_rsv(
 					struct btrfs_root *root,
 					unsigned int num_items);
+struct btrfs_trans_handle *btrfs_start_transaction_fallback_uninterruptible(
+					struct btrfs_root *root,
+					unsigned int num_items);
 struct btrfs_trans_handle *btrfs_join_transaction(struct btrfs_root *root);
 struct btrfs_trans_handle *btrfs_join_transaction_spacecache(struct btrfs_root *root);
 struct btrfs_trans_handle *btrfs_join_transaction_nostart(struct btrfs_root *root);
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 189da583bb67..389e14fc2c3e 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -3507,7 +3507,11 @@ static int del_balance_item(struct btrfs_fs_info *fs_info)
 	if (!path)
 		return -ENOMEM;
 
-	trans = btrfs_start_transaction_fallback_global_rsv(root, 0);
+	/*
+	 * Here we don't want this transaction start to be interrupted, or we
+	 * will mark the fs read-only.
+	 */
+	trans = btrfs_start_transaction_fallback_uninterruptible(root, 0);
 	if (IS_ERR(trans)) {
 		btrfs_free_path(path);
 		return PTR_ERR(trans);
@@ -3594,7 +3598,7 @@ static void reset_balance_state(struct btrfs_fs_info *fs_info)
 	kfree(bctl);
 	ret = del_balance_item(fs_info);
 	if (ret)
-		btrfs_handle_fs_error(fs_info, ret, NULL);
+		btrfs_handle_fs_error(fs_info, ret, "failed to delete balance item");
 }
 
 /*
-- 
2.41.0

