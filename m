Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8008139A47D
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Jun 2021 17:23:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232116AbhFCPYu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 3 Jun 2021 11:24:50 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:46778 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232057AbhFCPYu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 3 Jun 2021 11:24:50 -0400
Received: from relay2.suse.de (unknown [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 02EAA21A04;
        Thu,  3 Jun 2021 15:23:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1622733785; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=z8t1pQ5q334oB5+59VWbTGd6Y+RfMp4CI9UYJ85kbHs=;
        b=Mfo3a57EW6vxgG9yRdSn9THgue808wMbePcTsR69rMX+6TpE/R8zaW4BHvMwOXaQErIuHg
        N2Tqi+7Mm6qxzQExe9u/YCt3h8An8F/2rg5qMB0bcvsSLIT6T7dNpN1scE2KiRPKWcrBgA
        1lqA3BCbNp6ccJH8M7qdDQd4F3NfIj0=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id F1F5CA3B93;
        Thu,  3 Jun 2021 15:23:04 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 12CE2DA734; Thu,  3 Jun 2021 17:20:24 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 2/4] btrfs: inline wait_current_trans_commit_start in its caller
Date:   Thu,  3 Jun 2021 17:20:24 +0200
Message-Id: <21a09105f7c7cc9bed5c565b32d3b37964806b82.1622733245.git.dsterba@suse.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1622733245.git.dsterba@suse.com>
References: <cover.1622733245.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Function wait_current_trans_commit_start is now fairly trivial so it can
be inlined in its only caller.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/transaction.c | 20 +++++++-------------
 1 file changed, 7 insertions(+), 13 deletions(-)

diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index 30347e660027..73df8b81496e 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -1870,18 +1870,6 @@ int btrfs_transaction_blocked(struct btrfs_fs_info *info)
 	return ret;
 }
 
-/*
- * wait for the current transaction commit to start and block subsequent
- * transaction joins
- */
-static void wait_current_trans_commit_start(struct btrfs_fs_info *fs_info,
-					    struct btrfs_transaction *trans)
-{
-	wait_event(fs_info->transaction_blocked_wait,
-		   trans->state >= TRANS_STATE_COMMIT_START ||
-		   TRANS_ABORTED(trans));
-}
-
 /*
  * commit transactions asynchronously. once btrfs_commit_transaction_async
  * returns, any subsequent transaction will not be allowed to join.
@@ -1941,7 +1929,13 @@ int btrfs_commit_transaction_async(struct btrfs_trans_handle *trans)
 		__sb_writers_release(fs_info->sb, SB_FREEZE_FS);
 
 	schedule_work(&ac->work);
-	wait_current_trans_commit_start(fs_info, cur_trans);
+	/*
+	 * Wait for the current transaction commit to start and block
+	 * subsequent transaction joins
+	 */
+	wait_event(fs_info->transaction_blocked_wait,
+		   cur_trans->state >= TRANS_STATE_COMMIT_START ||
+		   TRANS_ABORTED(cur_trans));
 	if (current->journal_info == trans)
 		current->journal_info = NULL;
 
-- 
2.31.1

