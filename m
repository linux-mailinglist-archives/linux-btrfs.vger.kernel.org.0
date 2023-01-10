Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F8766643CB
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Jan 2023 15:57:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238778AbjAJO52 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 10 Jan 2023 09:57:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238751AbjAJO44 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 10 Jan 2023 09:56:56 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A217350065
        for <linux-btrfs@vger.kernel.org>; Tue, 10 Jan 2023 06:56:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0D2B1B81675
        for <linux-btrfs@vger.kernel.org>; Tue, 10 Jan 2023 14:56:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65F91C433EF
        for <linux-btrfs@vger.kernel.org>; Tue, 10 Jan 2023 14:56:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673362610;
        bh=Gy7KMkEcecrz0C7OP83NY1f/Vc4GQ6qoODEC33qAM10=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=J5cbnJG9PsZ6z8Ns30zIIZzbOXUSt0NmTVeDdhRUNNQwtVYRhNrQZTjugGEbCRzHR
         R15UXlheV14044Ppi8NvbjuQdHpudva6/zkjEsg4h7iaOq/MzCwqLMEInbJjXvXzBg
         HmzT51vqUe8z2GxEXW/m6/66B6G5tY36cAveVBcaT4IN9pYGiX9X7eYEI1Ty0aYHl0
         6WKqGeAP143f9/fCllcyyLMM0Bb+kvufBBF2vteBSF9FDRSv38bywMgykF5FbVBhwM
         5vYzP2Bih9D1NaM+Fd+047DSSCpiHVC4u7A8gHMd3Yu0DjW0vdSy2tlnbFpJJdlBzA
         VEV/iXJXY4JBQ==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 7/8] btrfs: use a negative value for BTRFS_LOG_FORCE_COMMIT
Date:   Tue, 10 Jan 2023 14:56:40 +0000
Message-Id: <776de7832fca78ad0e9297dab6105e889eb404c6.1673361215.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1673361215.git.fdmanana@suse.com>
References: <cover.1673361215.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

Currently we use the value 1 for BTRFS_LOG_FORCE_COMMIT, but that value
has a few inconveniences:

1) If it's ever used by btrfs_log_inode(), or any function down the call
   chain, we have to remember to btrfs_set_log_full_commit(), which is
   repetitive and has a chance to be forgotten in future use cases.
   btrfs_log_inode_parent() only calls btrfs_set_log_full_commit() when
   it gets a negative value from btrfs_log_inode();

2) Down the call chain of btrfs_log_inode(), we may have functions that
   need to force a log commit, but can return either an error (negative
   value), false (0) or true (1). So they are forced to return some
   random negative to force a log commit - using BTRFS_LOG_FORCE_COMMIT
   would make the intention more clear. Currently the only example is
   flush_dir_items_batch().

So turn BTRFS_LOG_FORCE_COMMIT into a negative value. The chosen value
is -(MAX_ERRNO + 1), so that it does not overlap any errno value and makes
it easier to debug.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/tree-log.c | 10 +++-------
 fs/btrfs/tree-log.h |  9 +++++++--
 2 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 58599189bd18..94fc8b08254c 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -3652,11 +3652,10 @@ static int flush_dir_items_batch(struct btrfs_trans_handle *trans,
 
 	/*
 	 * If for some unexpected reason the last item's index is not greater
-	 * than the last index we logged, warn and return an error to fallback
-	 * to a transaction commit.
+	 * than the last index we logged, warn and force a transaction commit.
 	 */
 	if (WARN_ON(last_index <= inode->last_dir_index_offset))
-		ret = -EUCLEAN;
+		ret = BTRFS_LOG_FORCE_COMMIT;
 	else
 		inode->last_dir_index_offset = last_index;
 out:
@@ -5604,10 +5603,8 @@ static int add_conflicting_inode(struct btrfs_trans_handle *trans,
 	 * LOG_INODE_EXISTS mode) and slow down other fsyncs or transaction
 	 * commits.
 	 */
-	if (ctx->num_conflict_inodes >= MAX_CONFLICT_INODES) {
-		btrfs_set_log_full_commit(trans);
+	if (ctx->num_conflict_inodes >= MAX_CONFLICT_INODES)
 		return BTRFS_LOG_FORCE_COMMIT;
-	}
 
 	inode = btrfs_iget(root->fs_info->sb, ino, root);
 	/*
@@ -6466,7 +6463,6 @@ static int btrfs_log_inode(struct btrfs_trans_handle *trans,
 	 * result in losing the file after a log replay.
 	 */
 	if (full_dir_logging && inode->last_unlink_trans >= trans->transid) {
-		btrfs_set_log_full_commit(trans);
 		ret = BTRFS_LOG_FORCE_COMMIT;
 		goto out_unlock;
 	}
diff --git a/fs/btrfs/tree-log.h b/fs/btrfs/tree-log.h
index 85cd24cb0540..bdeb5216718f 100644
--- a/fs/btrfs/tree-log.h
+++ b/fs/btrfs/tree-log.h
@@ -13,8 +13,13 @@
 /* return value for btrfs_log_dentry_safe that means we don't need to log it at all */
 #define BTRFS_NO_LOG_SYNC 256
 
-/* We can't use the tree log for whatever reason, force a transaction commit */
-#define BTRFS_LOG_FORCE_COMMIT				(1)
+/*
+ * We can't use the tree log for whatever reason, force a transaction commit.
+ * We use a negative value because there are functions through the logging code
+ * that need to return an error (< 0 value), false (0) or true (1). Any negative
+ * value will do, as it will cause the log to be marked for a full sync.
+ */
+#define BTRFS_LOG_FORCE_COMMIT				(-(MAX_ERRNO + 1))
 
 struct btrfs_log_ctx {
 	int log_ret;
-- 
2.35.1

