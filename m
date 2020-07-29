Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EC5F231B60
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Jul 2020 10:40:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727968AbgG2Ikq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 29 Jul 2020 04:40:46 -0400
Received: from mx2.suse.de ([195.135.220.15]:43092 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726993AbgG2Ikp (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 29 Jul 2020 04:40:45 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id A334BAC22
        for <linux-btrfs@vger.kernel.org>; Wed, 29 Jul 2020 08:40:55 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 1/3] btrfs-progs: convert: handle errors better in ext2_copy_inodes()
Date:   Wed, 29 Jul 2020 16:40:36 +0800
Message-Id: <20200729084038.78151-2-wqu@suse.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200729084038.78151-1-wqu@suse.com>
References: <20200729084038.78151-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This patch will enhance the error handling of ext2_copy_inodes by:
- Return more meaningful error number
  Instead of -1 (-EPERM), now return -EIO for ext2 calls error, and
  proper error number from btrfs calls.

- Commit transaction \if ext2fs_open_inode_scan() failed

- Call ext2fs_close_inode_scan() on error

- Hunt down the BUG_ON()s

- Add error messages for transaction related calls

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 convert/source-ext2.c | 42 +++++++++++++++++++++++++++++++-----------
 1 file changed, 31 insertions(+), 11 deletions(-)

diff --git a/convert/source-ext2.c b/convert/source-ext2.c
index d73684ef19e7..26514a09c9f1 100644
--- a/convert/source-ext2.c
+++ b/convert/source-ext2.c
@@ -797,7 +797,7 @@ static int ext2_copy_inodes(struct btrfs_convert_context *cctx,
 			    u32 convert_flags, struct task_ctx *p)
 {
 	ext2_filsys ext2_fs = cctx->fs_data;
-	int ret;
+	int ret = 0;
 	errcode_t err;
 	ext2_inode_scan ext2_scan;
 	struct ext2_inode ext2_inode;
@@ -810,8 +810,9 @@ static int ext2_copy_inodes(struct btrfs_convert_context *cctx,
 		return PTR_ERR(trans);
 	err = ext2fs_open_inode_scan(ext2_fs, 0, &ext2_scan);
 	if (err) {
-		fprintf(stderr, "ext2fs_open_inode_scan: %s\n", error_message(err));
-		return -1;
+		error("ext2fs_open_inode_scan failed: %s", error_message(err));
+		btrfs_commit_transaction(trans, root);
+		return -EIO;
 	}
 	while (!(err = ext2fs_get_next_inode(ext2_scan, &ext2_ino,
 					     &ext2_inode))) {
@@ -827,8 +828,11 @@ static int ext2_copy_inodes(struct btrfs_convert_context *cctx,
 		pthread_mutex_lock(&p->mutex);
 		p->cur_copy_inodes++;
 		pthread_mutex_unlock(&p->mutex);
-		if (ret)
-			return ret;
+		if (ret) {
+			error("failed to copy ext2 inode %u: %d", ext2_ino,
+			      ret);
+			goto out;
+		}
 		/*
 		 * blocks_used is the number of new tree blocks allocated in
 		 * current transaction.
@@ -842,17 +846,33 @@ static int ext2_copy_inodes(struct btrfs_convert_context *cctx,
 		 */
 		if (trans->blocks_used >= SZ_2M / root->fs_info->nodesize) {
 			ret = btrfs_commit_transaction(trans, root);
-			BUG_ON(ret);
+			if (ret < 0) {
+				error("failed to commit transaction: %d", ret);
+				goto out;
+			}
 			trans = btrfs_start_transaction(root, 1);
-			BUG_ON(IS_ERR(trans));
+			if (IS_ERR(trans)) {
+				ret = PTR_ERR(trans);
+				error("failed to start transaction: %d", ret);
+				trans = NULL;
+				goto out;
+			}
 		}
 	}
 	if (err) {
-		fprintf(stderr, "ext2fs_get_next_inode: %s\n", error_message(err));
-		return -1;
+		error("ext2fs_get_next_inode failed: %s", error_message(err));
+		ret = -EIO;
+		goto out;
+	}
+out:
+	if (ret < 0) {
+		if (trans)
+			btrfs_abort_transaction(trans, ret);
+	} else {
+		ret = btrfs_commit_transaction(trans, root);
+		if (ret < 0)
+			error("failed to commit transaction: %d", ret);
 	}
-	ret = btrfs_commit_transaction(trans, root);
-	BUG_ON(ret);
 	ext2fs_close_inode_scan(ext2_scan);
 
 	return ret;
-- 
2.27.0

