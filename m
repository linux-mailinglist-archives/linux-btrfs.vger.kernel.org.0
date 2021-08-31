Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5377B3FC9BE
	for <lists+linux-btrfs@lfdr.de>; Tue, 31 Aug 2021 16:31:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237332AbhHaObl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 31 Aug 2021 10:31:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:58288 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235064AbhHaObk (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 31 Aug 2021 10:31:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DECD06103A
        for <linux-btrfs@vger.kernel.org>; Tue, 31 Aug 2021 14:30:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630420245;
        bh=BwGkgLxRwHPtT/YiIFdgelnN0mqD+sfG54Hvym8MoJc=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=GqWPv+teROKec4DdFok9/tI9fsAqTjlUKWihUc3rGVyeuRshfVA31TBJIKsWLUK2K
         YNqnuf6W1z6Zvtcvx/S26t0Ak05SJQJCga3tu6ofdmoC2xb7SKdAfBux1MKu6Au1jE
         XJ7i+jaWOmQgwztGcn2j8YZjNJGBOoh5/RIqX0MARqJgSQ4cSZhSlKqsykYJynevX4
         zSjkgSc7cjnFPkceMGtf8/XUAD3rXFfWvYrHML5HW84asDUEtzpZaSiD40mYTN/Z6v
         3ulGtT1FnZvOrHGa0Q5xX/rwOK5mAbbE/qxLMrj3unQEoflcLJIBg044eVkdqlaWm0
         dtjLpEOZUaNzQ==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 02/10] btrfs: remove no longer needed checks for NULL log context
Date:   Tue, 31 Aug 2021 15:30:32 +0100
Message-Id: <8274e3e690821c28331e59b35174ea787a32bf30.1630419897.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1630419897.git.fdmanana@suse.com>
References: <cover.1630419897.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

Since commit 75b463d2b47aef ("btrfs: do not commit logs and transactions
during link and rename operations"), we always pass a non-NULL log context
to btrfs_log_inode_parent() and therefore to all the functions that it
calls. So remove the checks we have all over the place that test for a
NULL log context, making the code shorter and easier to read, as well as
reducing the size of the generated code.

This patch is part of a patch set comprised of the following patches:

  btrfs: check if a log tree exists at inode_logged()
  btrfs: remove no longer needed checks for NULL log context
  btrfs: do not log new dentries when logging that a new name exists
  btrfs: always update the logged transaction when logging new names
  btrfs: avoid expensive search when dropping inode items from log
  btrfs: add helper to truncate inode items when logging inode
  btrfs: avoid expensive search when truncating inode items from the log
  btrfs: avoid search for logged i_size when logging inode if possible
  btrfs: avoid attempt to drop extents when logging inode for the first time
  btrfs: do not commit delayed inode when logging a file in full sync mode

This is patch 2/10 and test results are listed in the change log of the
last patch in the set.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/tree-log.c | 20 +++++++-------------
 1 file changed, 7 insertions(+), 13 deletions(-)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 0342b1614978..7f5c586efe3c 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -207,7 +207,7 @@ static int start_log_trans(struct btrfs_trans_handle *trans,
 	}
 
 	atomic_inc(&root->log_writers);
-	if (ctx && !ctx->logging_new_name) {
+	if (!ctx->logging_new_name) {
 		int index = root->log_transid % 2;
 		list_add_tail(&ctx->list, &root->log_ctxs[index]);
 		ctx->log_transid = root->log_transid;
@@ -3019,9 +3019,6 @@ static void wait_for_writer(struct btrfs_root *root)
 static inline void btrfs_remove_log_ctx(struct btrfs_root *root,
 					struct btrfs_log_ctx *ctx)
 {
-	if (!ctx)
-		return;
-
 	mutex_lock(&root->log_mutex);
 	list_del_init(&ctx->list);
 	mutex_unlock(&root->log_mutex);
@@ -3765,8 +3762,7 @@ static noinline int log_dir_items(struct btrfs_trans_handle *trans,
 			 */
 			di = btrfs_item_ptr(src, i, struct btrfs_dir_item);
 			btrfs_dir_item_key_to_cpu(src, di, &tmp);
-			if (ctx &&
-			    (btrfs_dir_transid(src, di) == trans->transid ||
+			if ((btrfs_dir_transid(src, di) == trans->transid ||
 			     btrfs_dir_type(src, di) == BTRFS_FT_DIR) &&
 			    tmp.type != BTRFS_ROOT_ITEM_KEY)
 				ctx->log_new_dentries = true;
@@ -5225,7 +5221,7 @@ static int copy_inode_items_to_log(struct btrfs_trans_handle *trans,
 					&other_ino, &other_parent);
 			if (ret < 0) {
 				return ret;
-			} else if (ret > 0 && ctx &&
+			} else if (ret > 0 &&
 				   other_ino != btrfs_ino(BTRFS_I(ctx->inode))) {
 				if (ins_nr > 0) {
 					ins_nr++;
@@ -5566,8 +5562,7 @@ static int btrfs_log_inode(struct btrfs_trans_handle *trans,
 	 * So keep it simple for this case and just don't flag the ancestors as
 	 * logged.
 	 */
-	if (!ctx ||
-	    !(S_ISDIR(inode->vfs_inode.i_mode) && ctx->logging_new_name &&
+	if (!(S_ISDIR(inode->vfs_inode.i_mode) && ctx->logging_new_name &&
 	      &inode->vfs_inode != ctx->inode)) {
 		spin_lock(&inode->lock);
 		inode->logged_trans = trans->transid;
@@ -5920,11 +5915,10 @@ static int btrfs_log_all_parents(struct btrfs_trans_handle *trans,
 				continue;
 			}
 
-			if (ctx)
-				ctx->log_new_dentries = false;
+			ctx->log_new_dentries = false;
 			ret = btrfs_log_inode(trans, root, BTRFS_I(dir_inode),
 					      LOG_INODE_ALL, ctx);
-			if (!ret && ctx && ctx->log_new_dentries)
+			if (!ret && ctx->log_new_dentries)
 				ret = log_new_dir_dentries(trans, root,
 						   BTRFS_I(dir_inode), ctx);
 			btrfs_add_delayed_iput(dir_inode);
@@ -6185,7 +6179,7 @@ static int btrfs_log_inode_parent(struct btrfs_trans_handle *trans,
 		goto end_trans;
 	}
 
-	if (S_ISDIR(inode->vfs_inode.i_mode) && ctx && ctx->log_new_dentries)
+	if (S_ISDIR(inode->vfs_inode.i_mode) && ctx->log_new_dentries)
 		log_dentries = true;
 
 	/*
-- 
2.28.0

