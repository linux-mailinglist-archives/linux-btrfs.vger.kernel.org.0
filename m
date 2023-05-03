Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5997D6F5094
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 May 2023 09:06:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbjECHGa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 3 May 2023 03:06:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbjECHG3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 3 May 2023 03:06:29 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BEBA40FD
        for <linux-btrfs@vger.kernel.org>; Wed,  3 May 2023 00:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=Us70f+i1D33yBJSW8u7dYt/c0GCYYuIcO/ig5UHXzIQ=; b=cty5EFEWsFbSgTwD/9Rm4elhQM
        SHnnb9ajkksaJAIfTA2pnNigjetRj05jS78hQxGhp6K8JuWLcGtfjst1vLoHmjxSOeM72HwT8E1b8
        MlU3SJYnUnljZNihUX2MLdD0ilLmAP5IM514YT3Zvj2Eqxh11re1Y0qOaZ46Rh/UenE9Ob0JFl4hM
        KHSojvc5IHb0vA2XFpHWb9tXy+3KFnAzenwGidACW2MLkFiJbTCDU/ltPS+SQSBUMu8KcOhIyu/K4
        2t6lglwybMTJSWstI1QEM5C6BPJnt8NdOZa+iUfdqObYli/rPFNWbF8FEXaU1+Cm4vU+5A9eh80aT
        aIlR8+sA==;
Received: from 213-225-6-169.nat.highway.a1.net ([213.225.6.169] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pu6ZF-003aDt-2m;
        Wed, 03 May 2023 07:06:26 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: [PATCH 2/3] btrfs: don't reinvent synchronous writer detection logic
Date:   Wed,  3 May 2023 09:06:14 +0200
Message-Id: <20230503070615.1029820-3-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230503070615.1029820-1-hch@lst.de>
References: <20230503070615.1029820-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The writeback_control structure already passes down the information about
a writeback being synchronous from the core VM code, and thus information
is propagated into the bio REQ_SYNC flag through the wbc_to_write_flags
helper.

Use that information to decide if CRCs calculation is offloaded to a
workqueue instead of the sync_writers field in the btrfs_inode that
not only bloats the inode but also has too wide scope, being inode wide
instead of limited to the actual writeback request.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Chris Mason <clm@fb.com>
---
 fs/btrfs/bio.c         | 7 +++----
 fs/btrfs/btrfs_inode.h | 3 ---
 fs/btrfs/file.c        | 9 ---------
 fs/btrfs/inode.c       | 1 -
 fs/btrfs/transaction.c | 2 --
 5 files changed, 3 insertions(+), 19 deletions(-)

diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
index e8a55605ce22fa..49324388499cf1 100644
--- a/fs/btrfs/bio.c
+++ b/fs/btrfs/bio.c
@@ -581,11 +581,10 @@ static bool should_async_write(struct btrfs_bio *bbio)
 		return false;
 
 	/*
-	 * If the I/O is not issued by fsync and friends, (->sync_writers != 0),
-	 * then try to defer the submission to a workqueue to parallelize the
-	 * checksum calculation.
+	 * Try to defer the submission to a workqueue to parallelize the
+	 * checksum calculation unless the I/O is issued synchronously.
 	 */
-	if (atomic_read(&bbio->inode->sync_writers))
+	if (op_is_sync(bbio->bio.bi_opf))
 		return false;
 
 	/*
diff --git a/fs/btrfs/btrfs_inode.h b/fs/btrfs/btrfs_inode.h
index bb498448066981..3808aa5af21676 100644
--- a/fs/btrfs/btrfs_inode.h
+++ b/fs/btrfs/btrfs_inode.h
@@ -116,9 +116,6 @@ struct btrfs_inode {
 
 	unsigned long runtime_flags;
 
-	/* Keep track of who's O_SYNC/fsyncing currently */
-	atomic_t sync_writers;
-
 	/* full 64 bit generation number, struct vfs_inode doesn't have a big
 	 * enough field for this.
 	 */
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 5cc5a1faaef5b5..4b9433b96f4b8e 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -1651,7 +1651,6 @@ ssize_t btrfs_do_write_iter(struct kiocb *iocb, struct iov_iter *from,
 	struct file *file = iocb->ki_filp;
 	struct btrfs_inode *inode = BTRFS_I(file_inode(file));
 	ssize_t num_written, num_sync;
-	const bool sync = iocb_is_dsync(iocb);
 
 	/*
 	 * If the fs flips readonly due to some impossible error, although we
@@ -1664,9 +1663,6 @@ ssize_t btrfs_do_write_iter(struct kiocb *iocb, struct iov_iter *from,
 	if (encoded && (iocb->ki_flags & IOCB_NOWAIT))
 		return -EOPNOTSUPP;
 
-	if (sync)
-		atomic_inc(&inode->sync_writers);
-
 	if (encoded) {
 		num_written = btrfs_encoded_write(iocb, from, encoded);
 		num_sync = encoded->len;
@@ -1686,9 +1682,6 @@ ssize_t btrfs_do_write_iter(struct kiocb *iocb, struct iov_iter *from,
 			num_written = num_sync;
 	}
 
-	if (sync)
-		atomic_dec(&inode->sync_writers);
-
 	current->backing_dev_info = NULL;
 	return num_written;
 }
@@ -1733,9 +1726,7 @@ static int start_ordered_ops(struct inode *inode, loff_t start, loff_t end)
 	 * several segments of stripe length (currently 64K).
 	 */
 	blk_start_plug(&plug);
-	atomic_inc(&BTRFS_I(inode)->sync_writers);
 	ret = btrfs_fdatawrite_range(inode, start, end);
-	atomic_dec(&BTRFS_I(inode)->sync_writers);
 	blk_finish_plug(&plug);
 
 	return ret;
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index b9f88309bd4c43..5b0c827bb4c951 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -8459,7 +8459,6 @@ struct inode *btrfs_alloc_inode(struct super_block *sb)
 	ei->io_tree.inode = ei;
 	extent_io_tree_init(fs_info, &ei->file_extent_tree,
 			    IO_TREE_INODE_FILE_EXTENT);
-	atomic_set(&ei->sync_writers, 0);
 	mutex_init(&ei->log_mutex);
 	btrfs_ordered_inode_tree_init(&ei->ordered_tree);
 	INIT_LIST_HEAD(&ei->delalloc_inodes);
diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index 8b6a99b8d7f6d3..27c616fdfae274 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -1056,7 +1056,6 @@ int btrfs_write_marked_extents(struct btrfs_fs_info *fs_info,
 	u64 start = 0;
 	u64 end;
 
-	atomic_inc(&BTRFS_I(fs_info->btree_inode)->sync_writers);
 	while (!find_first_extent_bit(dirty_pages, start, &start, &end,
 				      mark, &cached_state)) {
 		bool wait_writeback = false;
@@ -1092,7 +1091,6 @@ int btrfs_write_marked_extents(struct btrfs_fs_info *fs_info,
 		cond_resched();
 		start = end + 1;
 	}
-	atomic_dec(&BTRFS_I(fs_info->btree_inode)->sync_writers);
 	return werr;
 }
 
-- 
2.39.2

