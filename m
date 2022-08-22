Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA5BA59BDE0
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Aug 2022 12:53:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233883AbiHVKwE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 22 Aug 2022 06:52:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233820AbiHVKwA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 22 Aug 2022 06:52:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 629452F671
        for <linux-btrfs@vger.kernel.org>; Mon, 22 Aug 2022 03:51:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F147C60FFD
        for <linux-btrfs@vger.kernel.org>; Mon, 22 Aug 2022 10:51:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE70BC433B5
        for <linux-btrfs@vger.kernel.org>; Mon, 22 Aug 2022 10:51:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661165518;
        bh=LBHv+MnMIFLoOR88t0KvNU1apoe8uRI+e6OrrRtgk9g=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=YIBgumOiWMla9i0vmxLlLtZ9um5xgplq4doaJr9yvO3XcwifBPo6u75oGM0YWXBsS
         tc6oRy+F1TVC1kAPxqKgyldJsmDKw8VdRU3PU0FyEazmdBDBb0EoTFGDkFvmYizqOQ
         2gYNp1NDVcuXqEVJE5c2Osq0Vko/OeQwCuZfCCdoHZnQXbDtnmKKEs1Jr8zbVjk6QP
         auYzEHUCko0wZOYqCpaAZvPdvSrLDMzrfjQS+6MdSiDVB6K9WQRlWMyNVWTFeVE9GB
         ljpUh5fl4bqflRx5EmMMUJkZ6V1XqMZgH/jSxFxnvMPGPgFAcBjLu6Wx7uM0moykmU
         gL/qIldVOOGVw==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 11/15] btrfs: move need_log_inode() to above log_conflicting_inodes()
Date:   Mon, 22 Aug 2022 11:51:40 +0100
Message-Id: <017ffcdd7d3943f2c6d34674f06676c617dd8a6e.1661165149.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1661165149.git.fdmanana@suse.com>
References: <cover.1661165149.git.fdmanana@suse.com>
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
index 1cfbd4503822..15a4a150cb27 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -5285,6 +5285,41 @@ static int btrfs_check_ref_name_override(struct extent_buffer *eb,
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
@@ -5921,41 +5956,6 @@ static int btrfs_log_inode(struct btrfs_trans_handle *trans,
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

