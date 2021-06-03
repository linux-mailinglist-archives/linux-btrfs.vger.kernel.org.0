Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FA5239A47B
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Jun 2021 17:23:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232008AbhFCPYs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 3 Jun 2021 11:24:48 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:46758 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231376AbhFCPYs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 3 Jun 2021 11:24:48 -0400
Received: from relay2.suse.de (unknown [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id AF0F821A01;
        Thu,  3 Jun 2021 15:23:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1622733782; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ChSmtv2sbtzKIbixBJEYI0hyiOk1rXtHFUyiwV/GFik=;
        b=EdYX0kvosiKWeRGMQIpT+XCCXxV0KlqY8Sz4lc0QohWaq87B1Tk5vKvlaB098Kft/xemym
        ZcuzqNE8aMUlLIJgvMwMlhF7WwZ7kpAXiq3cPq9VzDx4mdNSbRH003YzTb6gsMsT4z46uJ
        TvQqGJrXhJ/ivg7V+eAyeRfzRFJvAJI=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id A9123A3BBB;
        Thu,  3 Jun 2021 15:23:02 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id C8122DA734; Thu,  3 Jun 2021 17:20:21 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 1/4] btrfs: sink wait_for_unblock parameter to async commit
Date:   Thu,  3 Jun 2021 17:20:21 +0200
Message-Id: <c3c791a112de00b3d915184da8cce7b634570b2a.1622733245.git.dsterba@suse.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1622733245.git.dsterba@suse.com>
References: <cover.1622733245.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

There's only one caller left btrfs_ioctl_start_sync that passes 0, so we
can remove the switch in btrfs_commit_transaction_async.

A cleanup 9babda9f33fd ("btrfs: Remove async_transid from
btrfs_mksubvol/create_subvol/create_snapshot") removed calls that passed
1, so this is a followup.

As this removes last call of wait_current_trans_commit_start_and_unblock,
remove the function as well.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/ioctl.c       |  2 +-
 fs/btrfs/transaction.c | 24 ++----------------------
 fs/btrfs/transaction.h |  3 +--
 3 files changed, 4 insertions(+), 25 deletions(-)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 2bdaf2018197..f83eb4a225cc 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -3643,7 +3643,7 @@ static noinline long btrfs_ioctl_start_sync(struct btrfs_root *root,
 		goto out;
 	}
 	transid = trans->transid;
-	ret = btrfs_commit_transaction_async(trans, 0);
+	ret = btrfs_commit_transaction_async(trans);
 	if (ret) {
 		btrfs_end_transaction(trans);
 		return ret;
diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index 22951621363f..30347e660027 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -1882,19 +1882,6 @@ static void wait_current_trans_commit_start(struct btrfs_fs_info *fs_info,
 		   TRANS_ABORTED(trans));
 }
 
-/*
- * wait for the current transaction to start and then become unblocked.
- * caller holds ref.
- */
-static void wait_current_trans_commit_start_and_unblock(
-					struct btrfs_fs_info *fs_info,
-					struct btrfs_transaction *trans)
-{
-	wait_event(fs_info->transaction_wait,
-		   trans->state >= TRANS_STATE_UNBLOCKED ||
-		   TRANS_ABORTED(trans));
-}
-
 /*
  * commit transactions asynchronously. once btrfs_commit_transaction_async
  * returns, any subsequent transaction will not be allowed to join.
@@ -1922,8 +1909,7 @@ static void do_async_commit(struct work_struct *work)
 	kfree(ac);
 }
 
-int btrfs_commit_transaction_async(struct btrfs_trans_handle *trans,
-				   int wait_for_unblock)
+int btrfs_commit_transaction_async(struct btrfs_trans_handle *trans)
 {
 	struct btrfs_fs_info *fs_info = trans->fs_info;
 	struct btrfs_async_commit *ac;
@@ -1955,13 +1941,7 @@ int btrfs_commit_transaction_async(struct btrfs_trans_handle *trans,
 		__sb_writers_release(fs_info->sb, SB_FREEZE_FS);
 
 	schedule_work(&ac->work);
-
-	/* wait for transaction to start and unblock */
-	if (wait_for_unblock)
-		wait_current_trans_commit_start_and_unblock(fs_info, cur_trans);
-	else
-		wait_current_trans_commit_start(fs_info, cur_trans);
-
+	wait_current_trans_commit_start(fs_info, cur_trans);
 	if (current->journal_info == trans)
 		current->journal_info = NULL;
 
diff --git a/fs/btrfs/transaction.h b/fs/btrfs/transaction.h
index c49e2266b28b..0702e8d9b30e 100644
--- a/fs/btrfs/transaction.h
+++ b/fs/btrfs/transaction.h
@@ -226,8 +226,7 @@ void btrfs_add_dead_root(struct btrfs_root *root);
 int btrfs_defrag_root(struct btrfs_root *root);
 int btrfs_clean_one_deleted_snapshot(struct btrfs_root *root);
 int btrfs_commit_transaction(struct btrfs_trans_handle *trans);
-int btrfs_commit_transaction_async(struct btrfs_trans_handle *trans,
-				   int wait_for_unblock);
+int btrfs_commit_transaction_async(struct btrfs_trans_handle *trans);
 int btrfs_end_transaction_throttle(struct btrfs_trans_handle *trans);
 bool btrfs_should_end_transaction(struct btrfs_trans_handle *trans);
 void btrfs_throttle(struct btrfs_fs_info *fs_info);
-- 
2.31.1

