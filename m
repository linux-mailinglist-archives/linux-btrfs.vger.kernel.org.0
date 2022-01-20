Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C3EC494C5F
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Jan 2022 12:00:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230054AbiATLAT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 20 Jan 2022 06:00:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230048AbiATLAR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 20 Jan 2022 06:00:17 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96D53C06173F
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Jan 2022 03:00:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 37ACA61524
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Jan 2022 11:00:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EDA6C340E2
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Jan 2022 11:00:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642676416;
        bh=Kk+RtzZcdu8dAsrfljQQj5Kjb4E5n7YH6B3ZO2Hh0pU=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=lE9HZoq8uY3zXD0qaGmsH9u/l9PVuMvt4MbTgz9tZxqG/+4PhaizEdSB2py8pmtY3
         QE5/htYSmuBwx15xUjWvO5osAk15uwMF9C2vpMr4m2dLm37jrT3awMKysy4oWp49xq
         4zMBcy4xEGYsFDq+SATYGN5hbk+mBvUGEYHagYsyGbWZw6AmNj4f29x0s2u67C15L5
         ivaNyDPcxk4BC7LLZF4Wa9Zusa+TBBU/HiMp0BlRzZ28RXW7jC0Ho+IXSQRQsFsMSR
         5t5jpkmGhhruPSpHk1A7NJRPT9jmN6ZulUzVfhgI/vB2aHoOKPEWEV1Z5YxzSEil2S
         A1/nnMgXKCk1w==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 2/6] btrfs: pass the dentry to btrfs_log_new_name() instead of the inode
Date:   Thu, 20 Jan 2022 11:00:07 +0000
Message-Id: <1f0d5aaf498afa64ef3582cb9d9d24bc5f888ab2.1642676248.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1642676248.git.fdmanana@suse.com>
References: <cover.1642676248.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

In the next patch in the series, there will be the need to access the old
name, and its length, of an inode when logging the inode during a rename.
So instead of passing the inode to btrfs_log_new_name() pass the dentry,
because from the dentry we can get the inode, the name and its length.

This will avoid passing 3 new parameters to btrfs_log_new_name() in the
next patch - the name, its length and an index number. This way we end
up passing only 1 new parameter, the index number.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/inode.c    |  8 ++++----
 fs/btrfs/tree-log.c | 17 ++++++++++++++---
 fs/btrfs/tree-log.h |  2 +-
 3 files changed, 19 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index b17d14ec4d46..023041579a79 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -6531,7 +6531,7 @@ static int btrfs_link(struct dentry *old_dentry, struct inode *dir,
 				goto fail;
 		}
 		d_instantiate(dentry, inode);
-		btrfs_log_new_name(trans, BTRFS_I(inode), NULL, parent);
+		btrfs_log_new_name(trans, old_dentry, NULL, parent);
 	}
 
 fail:
@@ -9183,13 +9183,13 @@ static int btrfs_rename_exchange(struct inode *old_dir,
 		BTRFS_I(new_inode)->dir_index = new_idx;
 
 	if (root_log_pinned) {
-		btrfs_log_new_name(trans, BTRFS_I(old_inode), BTRFS_I(old_dir),
+		btrfs_log_new_name(trans, old_dentry, BTRFS_I(old_dir),
 				   new_dentry->d_parent);
 		btrfs_end_log_trans(root);
 		root_log_pinned = false;
 	}
 	if (dest_log_pinned) {
-		btrfs_log_new_name(trans, BTRFS_I(new_inode), BTRFS_I(new_dir),
+		btrfs_log_new_name(trans, new_dentry, BTRFS_I(new_dir),
 				   old_dentry->d_parent);
 		btrfs_end_log_trans(dest);
 		dest_log_pinned = false;
@@ -9470,7 +9470,7 @@ static int btrfs_rename(struct user_namespace *mnt_userns,
 		BTRFS_I(old_inode)->dir_index = index;
 
 	if (log_pinned) {
-		btrfs_log_new_name(trans, BTRFS_I(old_inode), BTRFS_I(old_dir),
+		btrfs_log_new_name(trans, old_dentry, BTRFS_I(old_dir),
 				   new_dentry->d_parent);
 		btrfs_end_log_trans(root);
 		log_pinned = false;
diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index fc0da7ee4e23..e253fa22ddba 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -6750,13 +6750,24 @@ void btrfs_record_snapshot_destroy(struct btrfs_trans_handle *trans,
 }
 
 /*
- * Call this after adding a new name for a file and it will properly
- * update the log to reflect the new name.
+ * Update the log after adding a new name for an inode.
+ *
+ * @trans:              Transaction handle.
+ * @old_dentry:         The dentry associated with the old name and the old
+ *                      parent directory.
+ * @old_dir:            The inode of the previous parent directory for the case
+ *                      of a rename. For a link operation, it must be NULL.
+ * @parent:             The dentry associated to the directory under which the
+ *                      new name is located.
+ *
+ * Call this after adding a new name for an inode, as a result of a link or
+ * rename operation, and it will properly update the log to reflect the new name.
  */
 void btrfs_log_new_name(struct btrfs_trans_handle *trans,
-			struct btrfs_inode *inode, struct btrfs_inode *old_dir,
+			struct dentry *old_dentry, struct btrfs_inode *old_dir,
 			struct dentry *parent)
 {
+	struct btrfs_inode *inode = BTRFS_I(d_inode(old_dentry));
 	struct btrfs_log_ctx ctx;
 
 	/*
diff --git a/fs/btrfs/tree-log.h b/fs/btrfs/tree-log.h
index f6811c3df38a..e69411f308ed 100644
--- a/fs/btrfs/tree-log.h
+++ b/fs/btrfs/tree-log.h
@@ -86,7 +86,7 @@ void btrfs_record_unlink_dir(struct btrfs_trans_handle *trans,
 void btrfs_record_snapshot_destroy(struct btrfs_trans_handle *trans,
 				   struct btrfs_inode *dir);
 void btrfs_log_new_name(struct btrfs_trans_handle *trans,
-			struct btrfs_inode *inode, struct btrfs_inode *old_dir,
+			struct dentry *old_dentry, struct btrfs_inode *old_dir,
 			struct dentry *parent);
 
 #endif
-- 
2.33.0

