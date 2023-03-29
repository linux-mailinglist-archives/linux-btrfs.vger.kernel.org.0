Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DB556CCE9C
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Mar 2023 02:13:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbjC2ANb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 28 Mar 2023 20:13:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjC2ANa (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 28 Mar 2023 20:13:30 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56FF5213B
        for <linux-btrfs@vger.kernel.org>; Tue, 28 Mar 2023 17:13:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=I/TD75OZMdIRuVbcb0TWfT9KmB3urDAo/g+cALin7CY=; b=ckLIurbXm1/aAV4bE4OHVFcMYE
        pzlv8r2oW9mfBCQm6Ca74nc2PlPj+mh0P+lXwvxmnvPTOcX69mc/heQ6aLqcEPGRMhuc8HrOGMvQz
        4BoU5vheSHWBQfAyhgshDV1ppAe0JeERsJ674H6JgyTAT041XZIrdWW1x/xRUyAxglUWS5tSKVRD2
        W8wPEHAKeDuBJhrATRQJeLzywbQ87ZK7YjAOrGD8l2PVMtaJYt2Ag9mBfNyz5PgB4y9Xbg8Znwr1e
        fHVLvGECCUUHP5/N/7Wn8Rw8bLbGG6HIussC+/lVt0N2FNLOFTmY4Qn9/CN7zCy5u22itoJTpIA4S
        VCQUcc2w==;
Received: from mo146-160-37-65.air.mopera.net ([146.160.37.65] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1phJRN-00GAzQ-2t;
        Wed, 29 Mar 2023 00:13:26 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: [PATCH 2/4] btrfs: remove the sync_writers field in struct btrfs_inode
Date:   Wed, 29 Mar 2023 09:13:06 +0900
Message-Id: <20230329001308.1275299-3-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230329001308.1275299-1-hch@lst.de>
References: <20230329001308.1275299-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The sync_writers field communicates if an inode has outstanding
synchronous writeback.  The better way is to look at the REQ_SYNC
flag in the bio, which is set by the writeback code for WB_SYNC_ALL
writeback and can communicate the need for sync writeback without
an inode field.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/bio.c         | 7 +++----
 fs/btrfs/btrfs_inode.h | 3 ---
 fs/btrfs/file.c        | 9 ---------
 fs/btrfs/inode.c       | 1 -
 fs/btrfs/transaction.c | 2 --
 5 files changed, 3 insertions(+), 19 deletions(-)

diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
index cf09c6271edbee..c851a3526911f6 100644
--- a/fs/btrfs/bio.c
+++ b/fs/btrfs/bio.c
@@ -552,11 +552,10 @@ static void run_one_async_free(struct btrfs_work *work)
 static bool should_async_write(struct btrfs_bio *bbio)
 {
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
index 9dc21622806ef4..8666ace8879302 100644
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
index 865d56ff2ce150..b505b205c1b142 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -8479,7 +8479,6 @@ struct inode *btrfs_alloc_inode(struct super_block *sb)
 	ei->io_tree.inode = ei;
 	extent_io_tree_init(fs_info, &ei->file_extent_tree,
 			    IO_TREE_INODE_FILE_EXTENT);
-	atomic_set(&ei->sync_writers, 0);
 	mutex_init(&ei->log_mutex);
 	btrfs_ordered_inode_tree_init(&ei->ordered_tree);
 	INIT_LIST_HEAD(&ei->delalloc_inodes);
diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index c8e503e5db4cdb..6587a13de0aedb 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -1055,7 +1055,6 @@ int btrfs_write_marked_extents(struct btrfs_fs_info *fs_info,
 	u64 start = 0;
 	u64 end;
 
-	atomic_inc(&BTRFS_I(fs_info->btree_inode)->sync_writers);
 	while (!find_first_extent_bit(dirty_pages, start, &start, &end,
 				      mark, &cached_state)) {
 		bool wait_writeback = false;
@@ -1091,7 +1090,6 @@ int btrfs_write_marked_extents(struct btrfs_fs_info *fs_info,
 		cond_resched();
 		start = end + 1;
 	}
-	atomic_dec(&BTRFS_I(fs_info->btree_inode)->sync_writers);
 	return werr;
 }
 
-- 
2.39.2

