Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23A8E203C60
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Jun 2020 18:20:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729566AbgFVQUk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 22 Jun 2020 12:20:40 -0400
Received: from mx2.suse.de ([195.135.220.15]:46274 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729521AbgFVQUj (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 22 Jun 2020 12:20:39 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 6E433C247;
        Mon, 22 Jun 2020 16:20:37 +0000 (UTC)
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     linux-btrfs@vger.kernel.org
Cc:     Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: [PATCH 5/8] btrfs: Push inode locking and unlocking in buffered/direct write
Date:   Mon, 22 Jun 2020 11:20:14 -0500
Message-Id: <20200622162017.21773-6-rgoldwyn@suse.de>
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

Push inode locking and unlocking closer to where we perform the I/O. For
this we need to move the write checks inside the respective functions as
well.

Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
---
 fs/btrfs/file.c | 70 ++++++++++++++++++++++++++++++++-----------------
 1 file changed, 46 insertions(+), 24 deletions(-)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 1a9a0a9e4b3d..aa6be931620b 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -1672,7 +1672,7 @@ static noinline ssize_t btrfs_buffered_write(struct kiocb *iocb,
 					       struct iov_iter *i)
 {
 	struct file *file = iocb->ki_filp;
-	loff_t pos = iocb->ki_pos;
+	loff_t pos;
 	struct inode *inode = file_inode(file);
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
 	struct btrfs_root *root = BTRFS_I(inode)->root;
@@ -1687,14 +1687,29 @@ static noinline ssize_t btrfs_buffered_write(struct kiocb *iocb,
 	bool only_release_metadata = false;
 	bool force_page_uptodate = false;
 	loff_t old_isize = i_size_read(inode);
+	int ilock_flags = 0;
+
+	if (iocb->ki_flags & IOCB_NOWAIT)
+		ilock_flags |= BTRFS_ILOCK_TRY;
+
+	ret = btrfs_inode_lock(inode, ilock_flags);
+	if (ret < 0)
+		return ret;
+
+	ret = btrfs_write_check(iocb, i);
+	if (ret <= 0)
+		goto out;
+	pos = iocb->ki_pos;
 
 	nrptrs = min(DIV_ROUND_UP(iov_iter_count(i), PAGE_SIZE),
 			PAGE_SIZE / (sizeof(struct page *)));
 	nrptrs = min(nrptrs, current->nr_dirtied_pause - current->nr_dirtied);
 	nrptrs = max(nrptrs, 8);
 	pages = kmalloc_array(nrptrs, sizeof(struct page *), GFP_KERNEL);
-	if (!pages)
-		return -ENOMEM;
+	if (!pages) {
+		ret = -ENOMEM;
+		goto out;
+	}
 
 	while (iov_iter_count(i) > 0) {
 		struct extent_state *cached_state = NULL;
@@ -1912,6 +1927,8 @@ static noinline ssize_t btrfs_buffered_write(struct kiocb *iocb,
 		pagecache_isize_extended(inode, old_isize, iocb->ki_pos);
 		iocb->ki_pos += num_written;
 	}
+out:
+	btrfs_inode_unlock(inode, ilock_flags);
 	return num_written ? num_written : ret;
 }
 
@@ -1942,6 +1959,18 @@ static ssize_t btrfs_direct_write(struct kiocb *iocb, struct iov_iter *from)
 	size_t count = 0;
 	bool relock = false;
 	int flags = IOMAP_DIOF_PGINVALID_FAIL;
+	int ilock_flags = 0;
+
+	if (iocb->ki_flags & IOCB_NOWAIT)
+		ilock_flags |= BTRFS_ILOCK_TRY;
+
+	err = btrfs_inode_lock(inode, ilock_flags);
+	if (err < 0)
+		goto error;
+
+	err = btrfs_write_check(iocb, from);
+	if (err <= 0)
+		goto error;
 
 	if (check_direct_IO(fs_info, from, pos))
 		goto buffered;
@@ -1956,7 +1985,8 @@ static ssize_t btrfs_direct_write(struct kiocb *iocb, struct iov_iter *from)
 		inode_unlock(inode);
 		relock = true;
 	} else if (iocb->ki_flags & IOCB_NOWAIT) {
-		return -EAGAIN;
+		err = -EAGAIN;
+		goto out;
 	}
 
 	if (is_sync_kiocb(iocb))
@@ -1970,10 +2000,13 @@ static ssize_t btrfs_direct_write(struct kiocb *iocb, struct iov_iter *from)
 	if (relock)
 		inode_lock(inode);
 
-	if (written < 0 || !iov_iter_count(from))
-		return written;
+	if (written < 0 || !iov_iter_count(from)) {
+		err = written;
+		goto error;
+	}
 
 buffered:
+	btrfs_inode_unlock(inode, ilock_flags);
 	pos = iocb->ki_pos;
 	written_buffered = btrfs_buffered_write(iocb, from);
 	if (written_buffered < 0) {
@@ -1995,8 +2028,13 @@ static ssize_t btrfs_direct_write(struct kiocb *iocb, struct iov_iter *from)
 	iocb->ki_pos = pos + written_buffered;
 	invalidate_mapping_pages(file->f_mapping, pos >> PAGE_SHIFT,
 				 endbyte >> PAGE_SHIFT);
+
 out:
 	return written ? written : err;
+
+error:
+	btrfs_inode_unlock(inode, ilock_flags);
+	return err;
 }
 
 static ssize_t btrfs_file_write_iter(struct kiocb *iocb,
@@ -2008,8 +2046,7 @@ static ssize_t btrfs_file_write_iter(struct kiocb *iocb,
 	struct btrfs_root *root = BTRFS_I(inode)->root;
 	ssize_t num_written = 0;
 	const bool sync = iocb->ki_flags & IOCB_DSYNC;
-	ssize_t err;
-	int ilock_flags = 0;
+	ssize_t err = 0;
 
 	/*
 	 * If BTRFS flips readonly due to some impossible error
@@ -2024,19 +2061,6 @@ static ssize_t btrfs_file_write_iter(struct kiocb *iocb,
 	    (iocb->ki_flags & IOCB_NOWAIT))
 		return -EOPNOTSUPP;
 
-	if (iocb->ki_flags & IOCB_NOWAIT)
-		ilock_flags |= BTRFS_ILOCK_TRY;
-
-	err = btrfs_inode_lock(inode, ilock_flags);
-	if (err < 0)
-		goto out;
-
-	err = btrfs_write_check(iocb, from);
-	if (err <= 0) {
-		inode_unlock(inode);
-		goto out;
-	}
-
 	if (sync)
 		atomic_inc(&BTRFS_I(inode)->sync_writers);
 
@@ -2046,8 +2070,6 @@ static ssize_t btrfs_file_write_iter(struct kiocb *iocb,
 		num_written = btrfs_buffered_write(iocb, from);
 	}
 
-	btrfs_inode_unlock(inode, ilock_flags);
-
 	/*
 	 * We also have to set last_sub_trans to the current log transid,
 	 * otherwise subsequent syncs to a file that's been synced in this
@@ -2061,7 +2083,7 @@ static ssize_t btrfs_file_write_iter(struct kiocb *iocb,
 
 	if (sync)
 		atomic_dec(&BTRFS_I(inode)->sync_writers);
-out:
+
 	current->backing_dev_info = NULL;
 	return num_written ? num_written : err;
 }
-- 
2.25.0

