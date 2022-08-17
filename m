Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64886596D7E
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Aug 2022 13:25:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238756AbiHQLXJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 17 Aug 2022 07:23:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234664AbiHQLXH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 17 Aug 2022 07:23:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 015D83A1
        for <linux-btrfs@vger.kernel.org>; Wed, 17 Aug 2022 04:23:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 79B32614CA
        for <linux-btrfs@vger.kernel.org>; Wed, 17 Aug 2022 11:23:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59896C4347C
        for <linux-btrfs@vger.kernel.org>; Wed, 17 Aug 2022 11:23:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660735384;
        bh=pIunuBjFYNTXy/mp5LnmuXPkGncPY/TXKPICVC9QqPM=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=ofnlZGwHAozjZZMf7Wa1mK9sF8oRvhCQtnwFGBIPyaE/u44R6UwWUbP/KTo1VK79F
         Sygs69ZKRIoYCkTW5/axOsdILyVvZk6TlGU9fBHcPUoPyEdX7M5QJ8Uir1RD4syAfR
         AyS7rGSpm1F5leKN9t+MATWjaGe9YK3qedfLD0RJTOv2ZNMHSQ5h2N1akISfw3pWdQ
         cvJWt2py4T4jVa0hSo6ddJIjEx1GR7QcuuF5c6AP8hu1YShuZyGQ+iACAj+dHeIbvn
         AKxbjXh3kuPPuzIwH+3Uo5Mg3VSJ/r2wK6iklkSB394Y8t5PUTqlNVHP8bT9VVRHoM
         4xSQ4/jQ6VVPA==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 11/15] btrfs: move need_log_inode() to above log_conflicting_inodes()
Date:   Wed, 17 Aug 2022 12:22:44 +0100
Message-Id: <1b9e97795702dc77d449f4c83e3fcd5dd8612b3a.1660735025.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1660735024.git.fdmanana@suse.com>
References: <cover.1660735024.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

The static function need_log_inode() is defined below btrfs_log_inode()
and log_conflicting_inodes(), but in the next patches in the series we
will need to call need_log_inode() in a couple new functions that will be
used by btrfs_log_inode(). So move its definition to a location above
log_conflicting_inodes().

Also make its arguments 'const', since they are not supposed to be
modified.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/tree-log.c | 70 ++++++++++++++++++++++-----------------------
 1 file changed, 35 insertions(+), 35 deletions(-)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 4678bf5d6224..921f344a051f 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -5310,6 +5310,41 @@ static int btrfs_check_ref_name_override(struct extent_buffer *eb,
 	return ret;
 }
 
+/*
+ * Check if we need to log an inode. This is used in contexts where while
+ * logging an inode we need to log another inode (either that it exists or in
+ * full mode). This is used instead of btrfs_inode_in_log() because the later
+ * requires the inode to be in the log and have the log transaction committed,
+ * while here we do not care if the log transaction was already committed - our
+ * caller will commit the log later - and we want to avoid logging an inode
+ * multiple times when multiple tasks have joined the same log transaction.
+ */
+static bool need_log_inode(const struct btrfs_trans_handle *trans,
+			   const struct btrfs_inode *inode)
+{
+	/*
+	 * If a directory was not modified, no dentries added or removed, we can
+	 * and should avoid logging it.
+	 */
+	if (S_ISDIR(inode->vfs_inode.i_mode) && inode->last_trans < trans->transid)
+		return false;
+
+	/*
+	 * If this inode does not have new/updated/deleted xattrs since the last
+	 * time it was logged and is flagged as logged in the current transaction,
+	 * we can skip logging it. As for new/deleted names, those are updated in
+	 * the log by link/unlink/rename operations.
+	 * In case the inode was logged and then evicted and reloaded, its
+	 * logged_trans will be 0, in which case we have to fully log it since
+	 * logged_trans is a transient field, not persisted.
+	 */
+	if (inode->logged_trans == trans->transid &&
+	    !test_bit(BTRFS_INODE_COPY_EVERYTHING, &inode->runtime_flags))
+		return false;
+
+	return true;
+}
+
 struct btrfs_ino_list {
 	u64 ino;
 	u64 parent;
@@ -5946,41 +5981,6 @@ static int btrfs_log_inode(struct btrfs_trans_handle *trans,
 	return ret;
 }
 
-/*
- * Check if we need to log an inode. This is used in contexts where while
- * logging an inode we need to log another inode (either that it exists or in
- * full mode). This is used instead of btrfs_inode_in_log() because the later
- * requires the inode to be in the log and have the log transaction committed,
- * while here we do not care if the log transaction was already committed - our
- * caller will commit the log later - and we want to avoid logging an inode
- * multiple times when multiple tasks have joined the same log transaction.
- */
-static bool need_log_inode(struct btrfs_trans_handle *trans,
-			   struct btrfs_inode *inode)
-{
-	/*
-	 * If a directory was not modified, no dentries added or removed, we can
-	 * and should avoid logging it.
-	 */
-	if (S_ISDIR(inode->vfs_inode.i_mode) && inode->last_trans < trans->transid)
-		return false;
-
-	/*
-	 * If this inode does not have new/updated/deleted xattrs since the last
-	 * time it was logged and is flagged as logged in the current transaction,
-	 * we can skip logging it. As for new/deleted names, those are updated in
-	 * the log by link/unlink/rename operations.
-	 * In case the inode was logged and then evicted and reloaded, its
-	 * logged_trans will be 0, in which case we have to fully log it since
-	 * logged_trans is a transient field, not persisted.
-	 */
-	if (inode->logged_trans == trans->transid &&
-	    !test_bit(BTRFS_INODE_COPY_EVERYTHING, &inode->runtime_flags))
-		return false;
-
-	return true;
-}
-
 struct btrfs_dir_list {
 	u64 ino;
 	struct list_head list;
-- 
2.35.1

