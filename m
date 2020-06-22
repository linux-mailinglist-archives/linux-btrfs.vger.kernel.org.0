Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F41E203C63
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Jun 2020 18:20:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729585AbgFVQUs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 22 Jun 2020 12:20:48 -0400
Received: from mx2.suse.de ([195.135.220.15]:46426 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729484AbgFVQUs (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 22 Jun 2020 12:20:48 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 46DDEC220;
        Mon, 22 Jun 2020 16:20:46 +0000 (UTC)
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     linux-btrfs@vger.kernel.org
Cc:     Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: [PATCH 8/8] btrfs: Move generic_write_sync() to  btrfs_buffered_write()
Date:   Mon, 22 Jun 2020 11:20:17 -0500
Message-Id: <20200622162017.21773-9-rgoldwyn@suse.de>
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

For direct I/O writes, generic_write_sync() gets called twice, once with
iomap_dio_complete() and the next time in btrfs_file_write_iter(). Move
it within btrfs_buffered_write(). In the process, we have to move
btrfs_inode->last_sub_trans as well to btrfs_buffered_write() and
btrfs_dio_iomap_end() respectively.

Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
---
 fs/btrfs/file.c  | 23 +++++++++++------------
 fs/btrfs/inode.c | 12 ++++++++----
 2 files changed, 19 insertions(+), 16 deletions(-)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index c8127406fcc6..8bbde5474297 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -1929,6 +1929,17 @@ static noinline ssize_t btrfs_buffered_write(struct kiocb *iocb,
 	}
 out:
 	btrfs_inode_unlock(inode, ilock_flags);
+	/*
+	 * We also have to set last_sub_trans to the current log transid,
+	 * otherwise subsequent syncs to a file that's been synced in this
+	 * transaction will appear to have already occurred.
+	 */
+	spin_lock(&BTRFS_I(inode)->lock);
+	BTRFS_I(inode)->last_sub_trans = root->log_transid;
+	spin_unlock(&BTRFS_I(inode)->lock);
+	if (num_written > 0)
+		num_written = generic_write_sync(iocb, num_written);
+
 	return num_written ? num_written : ret;
 }
 
@@ -2030,7 +2041,6 @@ static ssize_t btrfs_file_write_iter(struct kiocb *iocb,
 	struct file *file = iocb->ki_filp;
 	struct inode *inode = file_inode(file);
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
-	struct btrfs_root *root = BTRFS_I(inode)->root;
 	ssize_t num_written = 0;
 	const bool sync = iocb->ki_flags & IOCB_DSYNC;
 	ssize_t err = 0;
@@ -2057,17 +2067,6 @@ static ssize_t btrfs_file_write_iter(struct kiocb *iocb,
 		num_written = btrfs_buffered_write(iocb, from);
 	}
 
-	/*
-	 * We also have to set last_sub_trans to the current log transid,
-	 * otherwise subsequent syncs to a file that's been synced in this
-	 * transaction will appear to have already occurred.
-	 */
-	spin_lock(&BTRFS_I(inode)->lock);
-	BTRFS_I(inode)->last_sub_trans = root->log_transid;
-	spin_unlock(&BTRFS_I(inode)->lock);
-	if (num_written > 0)
-		num_written = generic_write_sync(iocb, num_written);
-
 	if (sync)
 		atomic_dec(&BTRFS_I(inode)->sync_writers);
 
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 7e71f42e7ec0..e0cfb1a5b952 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -7416,10 +7416,11 @@ static int btrfs_dio_iomap_end(struct inode *inode, loff_t pos, loff_t length,
 	struct btrfs_dio_data *dio_data = iomap->private;
 	size_t submitted = dio_data->submitted;
 	const bool write = !!(flags & IOMAP_WRITE);
+	struct btrfs_inode *bi = BTRFS_I(inode);
 
 	if (!write && (iomap->type == IOMAP_HOLE)) {
 		/* If reading from a hole, unlock and return */
-		unlock_extent(&BTRFS_I(inode)->io_tree, pos, pos + length - 1);
+		unlock_extent(&bi->io_tree, pos, pos + length - 1);
 		goto out;
 	}
 
@@ -7429,8 +7430,7 @@ static int btrfs_dio_iomap_end(struct inode *inode, loff_t pos, loff_t length,
 		if (write)
 			__endio_write_update_ordered(inode, pos, length, false);
 		else
-			unlock_extent(&BTRFS_I(inode)->io_tree, pos,
-				      pos + length - 1);
+			unlock_extent(&bi->io_tree, pos, pos + length - 1);
 		ret = -ENOTBLK;
 	}
 
@@ -7439,8 +7439,12 @@ static int btrfs_dio_iomap_end(struct inode *inode, loff_t pos, loff_t length,
 			btrfs_delalloc_release_space(inode,
 					dio_data->data_reserved, pos,
 					dio_data->reserve, true);
-		btrfs_delalloc_release_extents(BTRFS_I(inode), dio_data->length);
+		btrfs_delalloc_release_extents(bi, dio_data->length);
 		extent_changeset_free(dio_data->data_reserved);
+		spin_lock(&bi->lock);
+		bi->last_sub_trans = bi->root->log_transid;
+		spin_unlock(&bi->lock);
+
 	}
 out:
 	kfree(dio_data);
-- 
2.25.0

