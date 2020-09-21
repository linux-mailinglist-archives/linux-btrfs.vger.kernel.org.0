Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EC462728B8
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Sep 2020 16:46:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727750AbgIUOoy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 21 Sep 2020 10:44:54 -0400
Received: from mx2.suse.de ([195.135.220.15]:56440 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728323AbgIUOor (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 21 Sep 2020 10:44:47 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 1B37FB0D7;
        Mon, 21 Sep 2020 14:45:21 +0000 (UTC)
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, david@fromorbit.com, hch@lst.de,
        johannes.thumshirn@wdc.com, dsterba@suse.com,
        darrick.wong@oracle.com, josef@toxicpanda.com,
        Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: [PATCH 14/15] btrfs: Revert 09745ff88d93 ("btrfs: dio iomap DSYNC workaround")
Date:   Mon, 21 Sep 2020 09:43:52 -0500
Message-Id: <20200921144353.31319-15-rgoldwyn@suse.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200921144353.31319-1-rgoldwyn@suse.de>
References: <20200921144353.31319-1-rgoldwyn@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Goldwyn Rodrigues <rgoldwyn@suse.com>

iomap_dio_complete()->generic_write_sync() is not called under i_rwsem
anymore, revert the workaround.

Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
---
 fs/btrfs/ctree.h       |  1 -
 fs/btrfs/file.c        | 38 ++------------------------------
 fs/btrfs/inode.c       | 50 ------------------------------------------
 fs/btrfs/transaction.h |  1 -
 4 files changed, 2 insertions(+), 88 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index ea15771bf3da..bc96c52021b2 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -3051,7 +3051,6 @@ void btrfs_writepage_endio_finish_ordered(struct page *page, u64 start,
 extern const struct dentry_operations btrfs_dentry_operations;
 extern const struct iomap_ops btrfs_dio_iomap_ops;
 extern const struct iomap_dio_ops btrfs_dio_ops;
-extern const struct iomap_dio_ops btrfs_sync_dops;
 
 /* ilock flags definition */
 #define BTRFS_ILOCK_SHARED	(1 << 0)
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 9c7a2d4b4148..1d3363e7b09d 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -2094,44 +2094,10 @@ static ssize_t btrfs_file_write_iter(struct kiocb *iocb,
 	if (sync)
 		atomic_inc(&BTRFS_I(inode)->sync_writers);
 
-	if (iocb->ki_flags & IOCB_DIRECT) {
-		/*
-		 * 1. We must always clear IOCB_DSYNC in order to not deadlock
-		 *    in iomap, as it calls generic_write_sync() in this case.
-		 * 2. If we are async, we can call iomap_dio_complete() either
-		 *    in
-		 *
-		 *    2.1. A worker thread from the last bio completed.  In this
-		 *	   case we need to mark the btrfs_dio_data that it is
-		 *	   async in order to call generic_write_sync() properly.
-		 *	   This is handled by setting BTRFS_DIO_SYNC_STUB in the
-		 *	   current->journal_info.
-		 *    2.2  The submitter context, because all IO completed
-		 *         before we exited iomap_dio_rw().  In this case we can
-		 *         just re-set the IOCB_DSYNC on the iocb and we'll do
-		 *         the sync below.  If our ->end_io() gets called and
-		 *         current->journal_info is set, then we know we're in
-		 *         our current context and we will clear
-		 *         current->journal_info to indicate that we need to
-		 *         sync below.
-		 */
-		if (sync) {
-			ASSERT(current->journal_info == NULL);
-			iocb->ki_flags &= ~IOCB_DSYNC;
-			current->journal_info = BTRFS_DIO_SYNC_STUB;
-		}
+	if (iocb->ki_flags & IOCB_DIRECT)
 		num_written = btrfs_direct_write(iocb, from);
-
-		/*
-		 * As stated above, we cleared journal_info, so we need to do
-		 * the sync ourselves.
-		 */
-		if (sync && current->journal_info == NULL)
-			iocb->ki_flags |= IOCB_DSYNC;
-		current->journal_info = NULL;
-	} else {
+	else
 		num_written = btrfs_buffered_write(iocb, from);
-	}
 
 	/*
 	 * We also have to set last_sub_trans to the current log transid,
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 96ff8e4a3b45..41e32ef6b6ef 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -62,7 +62,6 @@ struct btrfs_dio_data {
 	loff_t length;
 	ssize_t submitted;
 	struct extent_changeset *data_reserved;
-	bool sync;
 };
 
 static const struct inode_operations btrfs_dir_inode_operations;
@@ -7362,17 +7361,6 @@ static int btrfs_dio_iomap_begin(struct inode *inode, loff_t start,
 	int ret = 0;
 	u64 len = length;
 	bool unlock_extents = false;
-	bool sync = (current->journal_info == BTRFS_DIO_SYNC_STUB);
-
-	/*
-	 * We used current->journal_info here to see if we were sync, but
-	 * there's a lot of tests in the enospc machinery to not do flushing if
-	 * we have a journal_info set, so we need to clear this out and re-set
-	 * it in iomap_end.
-	 */
-	ASSERT(current->journal_info == NULL ||
-	       current->journal_info == BTRFS_DIO_SYNC_STUB);
-	current->journal_info = NULL;
 
 	if (!write)
 		len = min_t(u64, len, fs_info->sectorsize);
@@ -7398,7 +7386,6 @@ static int btrfs_dio_iomap_begin(struct inode *inode, loff_t start,
 	if (!dio_data)
 		return -ENOMEM;
 
-	dio_data->sync = sync;
 	dio_data->length = length;
 	if (write) {
 		dio_data->reserve = round_up(length, fs_info->sectorsize);
@@ -7546,14 +7533,6 @@ static int btrfs_dio_iomap_end(struct inode *inode, loff_t pos, loff_t length,
 		extent_changeset_free(dio_data->data_reserved);
 	}
 out:
-	/*
-	 * We're all done, we can re-set the current->journal_info now safely
-	 * for our endio.
-	 */
-	if (dio_data->sync) {
-		ASSERT(current->journal_info == NULL);
-		current->journal_info = BTRFS_DIO_SYNC_STUB;
-	}
 	kfree(dio_data);
 	iomap->private = NULL;
 
@@ -7929,30 +7908,6 @@ static blk_qc_t btrfs_submit_direct(struct inode *inode, struct iomap *iomap,
 	return BLK_QC_T_NONE;
 }
 
-static inline int btrfs_maybe_fsync_end_io(struct kiocb *iocb, ssize_t size,
-					   int error, unsigned flags)
-{
-	/*
-	 * Now if we're still in the context of our submitter we know we can't
-	 * safely run generic_write_sync(), so clear our flag here so that the
-	 * caller knows to follow up with a sync.
-	 */
-	if (current->journal_info == BTRFS_DIO_SYNC_STUB) {
-		current->journal_info = NULL;
-		return error;
-	}
-
-	if (error)
-		return error;
-
-	if (size) {
-		iocb->ki_flags |= IOCB_DSYNC;
-		return generic_write_sync(iocb, size);
-	}
-
-	return 0;
-}
-
 const struct iomap_ops btrfs_dio_iomap_ops = {
 	.iomap_begin            = btrfs_dio_iomap_begin,
 	.iomap_end              = btrfs_dio_iomap_end,
@@ -7962,11 +7917,6 @@ const struct iomap_dio_ops btrfs_dio_ops = {
 	.submit_io		= btrfs_submit_direct,
 };
 
-const struct iomap_dio_ops btrfs_sync_dops = {
-	.submit_io		= btrfs_submit_direct,
-	.end_io			= btrfs_maybe_fsync_end_io,
-};
-
 static int btrfs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 			u64 start, u64 len)
 {
diff --git a/fs/btrfs/transaction.h b/fs/btrfs/transaction.h
index 858d9153a1cd..8241c050ba71 100644
--- a/fs/btrfs/transaction.h
+++ b/fs/btrfs/transaction.h
@@ -112,7 +112,6 @@ struct btrfs_transaction {
 #define TRANS_EXTWRITERS	(__TRANS_START | __TRANS_ATTACH)
 
 #define BTRFS_SEND_TRANS_STUB	((void *)1)
-#define BTRFS_DIO_SYNC_STUB	((void *)2)
 
 struct btrfs_trans_handle {
 	u64 transid;
-- 
2.26.2

