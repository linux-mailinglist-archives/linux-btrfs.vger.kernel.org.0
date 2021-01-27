Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6CB030589D
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Jan 2021 11:40:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236003AbhA0KiI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 27 Jan 2021 05:38:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:52530 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235846AbhA0Kfr (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 27 Jan 2021 05:35:47 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id EF93D2076E
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Jan 2021 10:35:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611743706;
        bh=bufW6tDsoD66RjDmrDgsTqL4yOOx4GgrF16MkUAG6yk=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=WlETU9iljMatmoWNge8xRTJ4dnY6vGaYp1V8bgCMA2oUEVjd59cs8TpPaOIIOH1os
         FsLagK4fMDnxyUs0YjKCiFbjLQi3PncU90fLYW2VgNBF6Lx+8CJEuNsRvUdD9ntxE4
         EAG0bb7B2yw1zlj3xMSqPdEatZ/+BzULInjVrnU2uipD7sTCKWbSLsYvFiVIJvsCAV
         VQUmo8y5TVYbroIs3HfBvstY7UoVmTMI1Mx/lOTIFcSBI+vea0r7WJN8swpeLFEqcM
         /NfZ827Fg0irXVfd9TSUYrHJk/RcwS0TuO4x3WIHwVIsf2XiRR59MWi66J7d5QSLyv
         uig1vzSrz4U9w==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 3/7] btrfs: avoid logging new ancestor inodes when logging new inode
Date:   Wed, 27 Jan 2021 10:34:56 +0000
Message-Id: <d6554a87bc248aa147c801717d64c7a80a45a78c.1611742865.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1611742865.git.fdmanana@suse.com>
References: <cover.1611742865.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

When we fsync a new file, created in the current transaction, we check
all its ancestor inodes and always log them if they were created in the
current transaction - even if we have already logged them before, which
is a waste of time.

So avoid logging new ancestor inodes if they were already logged before
and have no xattrs added/updated/removed since they were last logged.

This patch is part of a patchset comprised of the following patches:

  btrfs: remove unnecessary directory inode item update when deleting dir entry
  btrfs: stop setting nbytes when filling inode item for logging
  btrfs: avoid logging new ancestor inodes when logging new inode
  btrfs: skip logging directories already logged when logging all parents
  btrfs: skip logging inodes already logged when logging new entries
  btrfs: remove unnecessary check_parent_dirs_for_sync()
  btrfs: make concurrent fsyncs wait less when waiting for a transaction commit

Performance results, after applying all patches, are mentioned in the
change log of the last patch.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/tree-log.c | 35 +++++++++++++++++++++++++++++++++--
 1 file changed, 33 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index be62759f0aac..105cf316ee27 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -5272,6 +5272,7 @@ static int btrfs_log_inode(struct btrfs_trans_handle *trans,
 	if (S_ISDIR(inode->vfs_inode.i_mode)) {
 		int max_key_type = BTRFS_DIR_LOG_INDEX_KEY;
 
+		clear_bit(BTRFS_INODE_COPY_EVERYTHING, &inode->runtime_flags);
 		if (inode_only == LOG_INODE_EXISTS)
 			max_key_type = BTRFS_XATTR_ITEM_KEY;
 		ret = drop_objectid_items(trans, log, path, ino, max_key_type);
@@ -5520,6 +5521,34 @@ static noinline int check_parent_dirs_for_sync(struct btrfs_trans_handle *trans,
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
+static bool need_log_inode(struct btrfs_trans_handle *trans,
+			   struct btrfs_inode *inode)
+{
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
 struct btrfs_dir_list {
 	u64 ino;
 	struct list_head list;
@@ -5848,7 +5877,8 @@ static int log_new_ancestors(struct btrfs_trans_handle *trans,
 		if (IS_ERR(inode))
 			return PTR_ERR(inode);
 
-		if (BTRFS_I(inode)->generation >= trans->transid)
+		if (BTRFS_I(inode)->generation >= trans->transid &&
+		    need_log_inode(trans, BTRFS_I(inode)))
 			ret = btrfs_log_inode(trans, root, BTRFS_I(inode),
 					      LOG_INODE_EXISTS, ctx);
 		btrfs_add_delayed_iput(inode);
@@ -5902,7 +5932,8 @@ static int log_new_ancestors_fast(struct btrfs_trans_handle *trans,
 		if (root != inode->root)
 			break;
 
-		if (inode->generation >= trans->transid) {
+		if (inode->generation >= trans->transid &&
+		    need_log_inode(trans, inode)) {
 			ret = btrfs_log_inode(trans, root, inode,
 					      LOG_INODE_EXISTS, ctx);
 			if (ret)
-- 
2.28.0

