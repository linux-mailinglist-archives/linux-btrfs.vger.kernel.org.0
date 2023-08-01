Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A93476B02A
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Aug 2023 12:01:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231510AbjHAKBM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 1 Aug 2023 06:01:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233191AbjHAKAh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 1 Aug 2023 06:00:37 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BD40171B
        for <linux-btrfs@vger.kernel.org>; Tue,  1 Aug 2023 03:00:13 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 160A768BFE; Tue,  1 Aug 2023 12:00:08 +0200 (CEST)
Date:   Tue, 1 Aug 2023 12:00:06 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Wang Yugui <wangyugui@e16-tech.com>
Cc:     Christoph Hellwig <hch@lst.de>, linux-btrfs@vger.kernel.org
Subject: Re: btrfs write-bandwidth performance regression of 6.5-rc4/rc3
Message-ID: <20230801100006.GA30042@lst.de>
References: <20230801165652.760D.409509F4@e16-tech.com> <20230801090316.GA25781@lst.de> <20230801173208.4F08.409509F4@e16-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230801173208.4F08.409509F4@e16-tech.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Aug 01, 2023 at 05:32:13PM +0800, Wang Yugui wrote:
> dmesg output:
> [  250.596544] raid6: skipped pq benchmark and selected sse2x4
> [  250.602836] raid6: using ssse3x2 recovery algorithm
> [  250.612812] xor: automatically using best checksumming function   avx       
> [  250.895573] Btrfs loaded, assert=on, zoned=yes, fsverity=no
> [  250.905249] BTRFS: device fsid f5ebfdd6-6bf6-4c2b-b47b-79517bc00c8f devid 3 transid 6 /dev/nvme3n1 scanned by systemd-udevd (1726)
> [  250.922155] BTRFS: device fsid f5ebfdd6-6bf6-4c2b-b47b-79517bc00c8f devid 4 transid 6 /dev/nvme0n1 scanned by systemd-udevd (1729)
> [  250.935965] BTRFS: device fsid f5ebfdd6-6bf6-4c2b-b47b-79517bc00c8f devid 1 transid 6 /dev/nvme1n1 scanned by systemd-udevd (1724)
> [  250.968268] BTRFS: device fsid f5ebfdd6-6bf6-4c2b-b47b-79517bc00c8f devid 2 transid 6 /dev/nvme2n1 scanned by systemd-udevd (1723)
> [  251.070139] BTRFS info (device nvme1n1): using crc32c (crc32c-intel) checksum algorithm

So this is using the normal accelerated crc32c algorith that sets
BTRFS_FS_CSUM_IMPL_FAST.  Which means the commit doesn't change
behavior in should_async_write, which is the only place that checks
the sync_writers flag.  Can your retry the bisetion or apply the patch
below for a revert on top of latest mainline? 

---
From 9bdae7bbe4144b9bb49a28a4ee1de5c0f81f9b81 Mon Sep 17 00:00:00 2001
From: Christoph Hellwig <hch@lst.de>
Date: Tue, 1 Aug 2023 10:27:25 +0200
Subject: Revert "btrfs: determine synchronous writers from bio or writeback
 control"

This reverts commit e917ff56c8e7b117b590632fa40a08e36577d31f.
---
 fs/btrfs/bio.c         | 7 ++++---
 fs/btrfs/btrfs_inode.h | 3 +++
 fs/btrfs/file.c        | 8 ++++++++
 fs/btrfs/inode.c       | 1 +
 fs/btrfs/transaction.c | 2 ++
 5 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
index 12b12443efaabb..8fecf4e84da2bf 100644
--- a/fs/btrfs/bio.c
+++ b/fs/btrfs/bio.c
@@ -602,10 +602,11 @@ static bool should_async_write(struct btrfs_bio *bbio)
 		return false;
 
 	/*
-	 * Try to defer the submission to a workqueue to parallelize the
-	 * checksum calculation unless the I/O is issued synchronously.
+	 * If the I/O is not issued by fsync and friends, (->sync_writers != 0),
+	 * then try to defer the submission to a workqueue to parallelize the
+	 * checksum calculation.
 	 */
-	if (op_is_sync(bbio->bio.bi_opf))
+	if (atomic_read(&bbio->inode->sync_writers))
 		return false;
 
 	/* Zoned devices require I/O to be submitted in order. */
diff --git a/fs/btrfs/btrfs_inode.h b/fs/btrfs/btrfs_inode.h
index d47a927b3504d6..4efe895359dcf8 100644
--- a/fs/btrfs/btrfs_inode.h
+++ b/fs/btrfs/btrfs_inode.h
@@ -116,6 +116,9 @@ struct btrfs_inode {
 
 	unsigned long runtime_flags;
 
+	/* Keep track of who's O_SYNC/fsyncing currently */
+	atomic_t sync_writers;
+
 	/* full 64 bit generation number, struct vfs_inode doesn't have a big
 	 * enough field for this.
 	 */
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index fd03e689a6bedc..3e37a62a6b5db7 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -1648,6 +1648,7 @@ ssize_t btrfs_do_write_iter(struct kiocb *iocb, struct iov_iter *from,
 	struct file *file = iocb->ki_filp;
 	struct btrfs_inode *inode = BTRFS_I(file_inode(file));
 	ssize_t num_written, num_sync;
+	const bool sync = iocb_is_dsync(iocb);
 
 	/*
 	 * If the fs flips readonly due to some impossible error, although we
@@ -1660,6 +1661,9 @@ ssize_t btrfs_do_write_iter(struct kiocb *iocb, struct iov_iter *from,
 	if (encoded && (iocb->ki_flags & IOCB_NOWAIT))
 		return -EOPNOTSUPP;
 
+	if (sync)
+		atomic_inc(&inode->sync_writers);
+
 	if (encoded) {
 		num_written = btrfs_encoded_write(iocb, from, encoded);
 		num_sync = encoded->len;
@@ -1679,6 +1683,8 @@ ssize_t btrfs_do_write_iter(struct kiocb *iocb, struct iov_iter *from,
 			num_written = num_sync;
 	}
 
+	if (sync)
+		atomic_dec(&inode->sync_writers);
 	return num_written;
 }
 
@@ -1722,7 +1728,9 @@ static int start_ordered_ops(struct inode *inode, loff_t start, loff_t end)
 	 * several segments of stripe length (currently 64K).
 	 */
 	blk_start_plug(&plug);
+	atomic_inc(&BTRFS_I(inode)->sync_writers);
 	ret = btrfs_fdatawrite_range(inode, start, end);
+	atomic_dec(&BTRFS_I(inode)->sync_writers);
 	blk_finish_plug(&plug);
 
 	return ret;
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 49cef61f6a39f5..b9bad13ab75d19 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -8618,6 +8618,7 @@ struct inode *btrfs_alloc_inode(struct super_block *sb)
 	ei->io_tree.inode = ei;
 	extent_io_tree_init(fs_info, &ei->file_extent_tree,
 			    IO_TREE_INODE_FILE_EXTENT);
+	atomic_set(&ei->sync_writers, 0);
 	mutex_init(&ei->log_mutex);
 	btrfs_ordered_inode_tree_init(&ei->ordered_tree);
 	INIT_LIST_HEAD(&ei->delalloc_inodes);
diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index 91b6c2fdc420e7..cda2b86de18814 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -1060,6 +1060,7 @@ int btrfs_write_marked_extents(struct btrfs_fs_info *fs_info,
 	u64 start = 0;
 	u64 end;
 
+	atomic_inc(&BTRFS_I(fs_info->btree_inode)->sync_writers);
 	while (!find_first_extent_bit(dirty_pages, start, &start, &end,
 				      mark, &cached_state)) {
 		bool wait_writeback = false;
@@ -1095,6 +1096,7 @@ int btrfs_write_marked_extents(struct btrfs_fs_info *fs_info,
 		cond_resched();
 		start = end + 1;
 	}
+	atomic_dec(&BTRFS_I(fs_info->btree_inode)->sync_writers);
 	return werr;
 }
 
-- 
2.39.2

