Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 787EC203C5E
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Jun 2020 18:20:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729545AbgFVQUd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 22 Jun 2020 12:20:33 -0400
Received: from mx2.suse.de ([195.135.220.15]:46118 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729521AbgFVQUd (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 22 Jun 2020 12:20:33 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 6B3CBC220;
        Mon, 22 Jun 2020 16:20:31 +0000 (UTC)
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     linux-btrfs@vger.kernel.org
Cc:     Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: [PATCH 3/8] btrfs: Introduce btrfs_write_check()
Date:   Mon, 22 Jun 2020 11:20:12 -0500
Message-Id: <20200622162017.21773-4-rgoldwyn@suse.de>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200622162017.21773-1-rgoldwyn@suse.de>
References: <20200622162017.21773-1-rgoldwyn@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Goldwyn Rodrigues <rgoldwyn@suse.com>

btrfs_write_check() checks for all parameters before the write.
This simplifies with error situations with respect to inode unlocking.

Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
---
 fs/btrfs/file.c | 138 +++++++++++++++++++++++++-----------------------
 1 file changed, 71 insertions(+), 67 deletions(-)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 9ec30ccbd67a..ba7c3b2cf1c5 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -1567,6 +1567,76 @@ static noinline int check_can_nocow(struct btrfs_inode *inode, loff_t pos,
 	return ret;
 }
 
+static void update_time_for_write(struct inode *inode)
+{
+	struct timespec64 now;
+
+	if (IS_NOCMTIME(inode))
+		return;
+
+	now = current_time(inode);
+	if (!timespec64_equal(&inode->i_mtime, &now))
+		inode->i_mtime = now;
+
+	if (!timespec64_equal(&inode->i_ctime, &now))
+		inode->i_ctime = now;
+
+	if (IS_I_VERSION(inode))
+		inode_inc_iversion(inode);
+}
+
+static size_t btrfs_write_check(struct kiocb *iocb, struct iov_iter *from)
+{
+	int err;
+	loff_t oldsize;
+	loff_t start_pos;
+	struct file *file = iocb->ki_filp;
+	struct inode *inode = file_inode(file);
+	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
+	loff_t pos = iocb->ki_pos;
+	size_t count = iov_iter_count(from);
+
+	err = generic_write_checks(iocb, from);
+	if (err <= 0)
+		return err;
+
+	if (iocb->ki_flags & IOCB_NOWAIT) {
+		/*
+		 * We will allocate space in case nodatacow is not set,
+		 * so bail
+		 */
+		if (!(BTRFS_I(inode)->flags & (BTRFS_INODE_NODATACOW |
+					      BTRFS_INODE_PREALLOC)) ||
+		    check_can_nocow(BTRFS_I(inode), pos, &count) <= 0)
+			return -EAGAIN;
+	}
+
+	current->backing_dev_info = inode_to_bdi(inode);
+	err = file_remove_privs(file);
+	if (err)
+		return err;
+
+	/*
+	 * We reserve space for updating the inode when we reserve space for the
+	 * extent we are going to write, so we will enospc out there.  We don't
+	 * need to start yet another transaction to update the inode as we will
+	 * update the inode when we finish writing whatever data we write.
+	 */
+	update_time_for_write(inode);
+
+	start_pos = round_down(pos, fs_info->sectorsize);
+	oldsize = i_size_read(inode);
+	if (start_pos > oldsize) {
+		/* Expand hole size to cover write data, preventing empty gap */
+		u64 end_pos = round_up(pos + count,
+				   fs_info->sectorsize);
+		err = btrfs_cont_expand(inode, oldsize, end_pos);
+		if (err)
+			return err;
+	}
+	return count;
+}
+
 static noinline ssize_t btrfs_buffered_write(struct kiocb *iocb,
 					       struct iov_iter *i)
 {
@@ -1898,24 +1968,6 @@ static ssize_t btrfs_direct_write(struct kiocb *iocb, struct iov_iter *from)
 	return written ? written : err;
 }
 
-static void update_time_for_write(struct inode *inode)
-{
-	struct timespec64 now;
-
-	if (IS_NOCMTIME(inode))
-		return;
-
-	now = current_time(inode);
-	if (!timespec64_equal(&inode->i_mtime, &now))
-		inode->i_mtime = now;
-
-	if (!timespec64_equal(&inode->i_ctime, &now))
-		inode->i_ctime = now;
-
-	if (IS_I_VERSION(inode))
-		inode_inc_iversion(inode);
-}
-
 static ssize_t btrfs_file_write_iter(struct kiocb *iocb,
 				    struct iov_iter *from)
 {
@@ -1923,14 +1975,9 @@ static ssize_t btrfs_file_write_iter(struct kiocb *iocb,
 	struct inode *inode = file_inode(file);
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
 	struct btrfs_root *root = BTRFS_I(inode)->root;
-	u64 start_pos;
-	u64 end_pos;
 	ssize_t num_written = 0;
 	const bool sync = iocb->ki_flags & IOCB_DSYNC;
 	ssize_t err;
-	loff_t pos;
-	size_t count;
-	loff_t oldsize;
 
 	/*
 	 * If BTRFS flips readonly due to some impossible error
@@ -1952,55 +1999,12 @@ static ssize_t btrfs_file_write_iter(struct kiocb *iocb,
 		inode_lock(inode);
 	}
 
-	err = generic_write_checks(iocb, from);
+	err = btrfs_write_check(iocb, from);
 	if (err <= 0) {
-		inode_unlock(inode);
-		return err;
-	}
-
-	pos = iocb->ki_pos;
-	count = iov_iter_count(from);
-	if (iocb->ki_flags & IOCB_NOWAIT) {
-		/*
-		 * We will allocate space in case nodatacow is not set,
-		 * so bail
-		 */
-		if (!(BTRFS_I(inode)->flags & (BTRFS_INODE_NODATACOW |
-					      BTRFS_INODE_PREALLOC)) ||
-		    check_can_nocow(BTRFS_I(inode), pos, &count) <= 0) {
-			inode_unlock(inode);
-			return -EAGAIN;
-		}
-	}
-
-	current->backing_dev_info = inode_to_bdi(inode);
-	err = file_remove_privs(file);
-	if (err) {
 		inode_unlock(inode);
 		goto out;
 	}
 
-	/*
-	 * We reserve space for updating the inode when we reserve space for the
-	 * extent we are going to write, so we will enospc out there.  We don't
-	 * need to start yet another transaction to update the inode as we will
-	 * update the inode when we finish writing whatever data we write.
-	 */
-	update_time_for_write(inode);
-
-	start_pos = round_down(pos, fs_info->sectorsize);
-	oldsize = i_size_read(inode);
-	if (start_pos > oldsize) {
-		/* Expand hole size to cover write data, preventing empty gap */
-		end_pos = round_up(pos + count,
-				   fs_info->sectorsize);
-		err = btrfs_cont_expand(inode, oldsize, end_pos);
-		if (err) {
-			inode_unlock(inode);
-			goto out;
-		}
-	}
-
 	if (sync)
 		atomic_inc(&BTRFS_I(inode)->sync_writers);
 
-- 
2.25.0

