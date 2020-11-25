Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BD1C2C3FC7
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Nov 2020 13:19:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728947AbgKYMTe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 25 Nov 2020 07:19:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:44940 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725616AbgKYMTe (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 25 Nov 2020 07:19:34 -0500
Received: from localhost.localdomain (bl8-197-74.dsl.telepac.pt [85.241.197.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 598D5206F7
        for <linux-btrfs@vger.kernel.org>; Wed, 25 Nov 2020 12:19:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606306773;
        bh=N7CHilKL/jIBO8LegweHnlPvy3fbA6YSmsH1TbI4h3s=;
        h=From:To:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=i/jSmyquSx3RVflZCFE0DvDCrS6OQs9yR6CRjQFvT9aylLX3Iv+eB/akIsfd/sdL8
         n09cnWDbsxTpOKetsSAzIklGN88ouwsJGOzMZkbbcWBx7hQqPN8OTYhCCs3OBbJ7W7
         sQZwR2lNdnqqpKnokd8EPqR2vZHNLn8iEag+NmFY=
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 1/6] btrfs: fix race causing unnecessary inode logging during link and rename
Date:   Wed, 25 Nov 2020 12:19:23 +0000
Message-Id: <1c2b2e9144cd96308d66369175993bdf8419b5a0.1606305501.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1606305501.git.fdmanana@suse.com>
References: <cover.1606305501.git.fdmanana@suse.com>
In-Reply-To: <cover.1606305501.git.fdmanana@suse.com>
References: <cover.1606305501.git.fdmanana@suse.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

When we are doing a rename or a link operation for an inode that was logged
in the previous transaction and that transaction is still committing, we
have a time window where we incorrectly consider that the inode was logged
previously in the current transaction and therefore decide to log it to
update it in the log. The following steps give an example on how this
happens during a link operation:

1) Inode X is logged in transaction 1000, so its logged_trans field is set
   to 1000;

2) Task A starts to commit transaction 1000;

3) The state of transaction 1000 is changed to TRANS_STATE_UNBLOCKED;

4) Task B starts a link operation for inode X, and as a consequence it
   starts transaction 1001;

5) Task A is still committing transaction 1000, therefore the value stored
   at fs_info->last_trans_committed is still 999;

6) Task B calls btrfs_log_new_name(), it reads a value of 999 from
   fs_info->last_trans_committed and because the logged_trans field of
   inode X has a value of 1000, the function does not return immediately,
   instead it proceeds to logging the inode, which should not happen
   because the inode was logged in the previous transaction (1000) and
   not in the current one (1001).

This is not a functional problem, just wasted time and space logging an
inode that does not need to be logged, contributing to higher latency
for link and rename operations.

So fix this by comparing the inodes' logged_trans field with the
generation of the current transaction instead of comparing with the value
stored in fs_info->last_trans_committed.

This case is often hit when running dbench for a long enough duration, as
it does lots of rename operations.

This patch belongs to a patch set that is comprised of the following
patches:

  btrfs: fix race causing unnecessary inode logging during link and rename
  btrfs: fix race that results in logging old extents during a fast fsync
  btrfs: fix race that causes unnecessary logging of ancestor inodes
  btrfs: fix race that makes inode logging fallback to transaction commit
  btrfs: fix race leading to unnecessary transaction commit when logging inode
  btrfs: do not block inode logging for so long during transaction commit

Performance results are mentioned in the change log of the last patch.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/tree-log.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 80cf496226c2..b63f5c2b982a 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -6443,7 +6443,6 @@ void btrfs_log_new_name(struct btrfs_trans_handle *trans,
 			struct btrfs_inode *inode, struct btrfs_inode *old_dir,
 			struct dentry *parent)
 {
-	struct btrfs_fs_info *fs_info = trans->fs_info;
 	struct btrfs_log_ctx ctx;
 
 	/*
@@ -6457,8 +6456,8 @@ void btrfs_log_new_name(struct btrfs_trans_handle *trans,
 	 * if this inode hasn't been logged and directory we're renaming it
 	 * from hasn't been logged, we don't need to log it
 	 */
-	if (inode->logged_trans <= fs_info->last_trans_committed &&
-	    (!old_dir || old_dir->logged_trans <= fs_info->last_trans_committed))
+	if (inode->logged_trans < trans->transid &&
+	    (!old_dir || old_dir->logged_trans < trans->transid))
 		return;
 
 	btrfs_init_log_ctx(&ctx, &inode->vfs_inode);
-- 
2.28.0

