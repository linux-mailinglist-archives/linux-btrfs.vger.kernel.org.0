Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CCA26B9C5C
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Mar 2023 17:59:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230241AbjCNQ7d (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 14 Mar 2023 12:59:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230155AbjCNQ7c (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 14 Mar 2023 12:59:32 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CB4AA2C33
        for <linux-btrfs@vger.kernel.org>; Tue, 14 Mar 2023 09:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=YdteaEbv9gfHhF8ezsTAEuwWgOu/EQFpLiSWDnWiFHI=; b=4hGHvSlVekPLr1CNsznCkM1Wu1
        jnD6EXEnQ8DwnjAL+bCM3fz+5IE3C78qRd3PpTpMCgny4iEVeAmUAyNSRmX6arU+0CShFqWZgFdrQ
        Z4eo4UpWVskYYm7IsxgPD9l1g1pkpBOfLk1QkWf7pzFsMJ+aelnzMvwga+mga+6vDloA2DpOH7oBQ
        C2BgasF0yS1b5xRoCTYHw7aej7gpEOcwHdAk+xfDDQk/18THKeOhYDxfS46Fzj8UR84n2tThOFkwh
        3rk8pfi4mcxMIaoO3pgtoHmgO49dZN0qmmNjHNQWu7Gkja5LpOUsuJSJ1ABz0vQ+4dHo5t4A1YiY0
        v+rGv7BA==;
Received: from [2001:4bb8:182:2e36:91ea:d0e2:233a:8356] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pc7zj-00Avmu-1A;
        Tue, 14 Mar 2023 16:59:27 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Johannes Thumshirn <jth@kernel.org>, linux-btrfs@vger.kernel.org
Subject: [PATCH 03/10] btrfs: offload all write I/O completions to a workqueue
Date:   Tue, 14 Mar 2023 17:59:03 +0100
Message-Id: <20230314165910.373347-4-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230314165910.373347-1-hch@lst.de>
References: <20230314165910.373347-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Currently all reads are offloaded to workqueues for checksum
verification.  Writes are initially processed in the bi_end_io
context that usually happens in hard or soft interrupts, and are
only offloaded to a workqueue for ordered extent completion or
compressed extent handling, and in the future for raid stripe
tree handling.

Switch to offload all writes to workqueues instead of doing that
only for the final ordered extent processing.  This means that
there are slightly workqueue offloads for large writes as each
submitted btrfs_bio can only hold 1MiB worth of data on systems
with a 4K page size.  On the other hand this will allow large
simpliciations by always having a process context.

For metadata writes there was not offload at all before, which
creates various problems like not being able to drop the final
extent_buffered reference from the end_io handler.

With the entire series applied this shows no performance differences
on data heavy workload, while for metadata heavy workloads like
Filipes fs_mark there also is no change in averages, while it
seems to somewhat reduce the outliers in terms of best and worst
performance.  This is probably due to the removal of the irq
disabling in the next patches.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/bio.c          | 74 ++++++++++++++++++++++++++++-------------
 fs/btrfs/disk-io.c      |  5 +++
 fs/btrfs/fs.h           |  1 +
 fs/btrfs/ordered-data.c | 17 +---------
 fs/btrfs/ordered-data.h |  2 --
 5 files changed, 57 insertions(+), 42 deletions(-)

diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
index 85539964864a34..037eded3b33ba2 100644
--- a/fs/btrfs/bio.c
+++ b/fs/btrfs/bio.c
@@ -300,20 +300,33 @@ static struct workqueue_struct *btrfs_end_io_wq(struct btrfs_bio *bbio)
 {
 	struct btrfs_fs_info *fs_info = bbio->inode->root->fs_info;
 
-	if (bbio->bio.bi_opf & REQ_META)
-		return fs_info->endio_meta_workers;
-	return fs_info->endio_workers;
+	if (btrfs_op(&bbio->bio) == BTRFS_MAP_WRITE) {
+		if (btrfs_is_free_space_inode(bbio->inode))
+			return fs_info->endio_freespace_worker;
+		if (bbio->bio.bi_opf & REQ_META)
+			return fs_info->endio_write_meta_workers;
+		return fs_info->endio_write_workers;
+	} else {
+		if (bbio->bio.bi_opf & REQ_META)
+			return fs_info->endio_meta_workers;
+		return fs_info->endio_workers;
+	}
 }
 
-static void btrfs_end_bio_work(struct work_struct *work)
+static void btrfs_simple_end_bio_work(struct work_struct *work)
 {
 	struct btrfs_bio *bbio = container_of(work, struct btrfs_bio, end_io_work);
+	struct bio *bio = &bbio->bio;
+	struct btrfs_device *dev = bio->bi_private;
 
 	/* Metadata reads are checked and repaired by the submitter. */
-	if (bbio->bio.bi_opf & REQ_META)
-		bbio->end_io(bbio);
-	else
-		btrfs_check_read_bio(bbio, bbio->bio.bi_private);
+	if (bio_op(bio) == REQ_OP_READ && !(bio->bi_opf & REQ_META)) {
+		btrfs_check_read_bio(bbio, dev);
+	} else {
+		if (bio_op(bio) == REQ_OP_ZONE_APPEND)
+			btrfs_record_physical_zoned(bbio);
+		btrfs_orig_bbio_end_io(bbio);
+	}
 }
 
 static void btrfs_simple_end_io(struct bio *bio)
@@ -322,18 +335,19 @@ static void btrfs_simple_end_io(struct bio *bio)
 	struct btrfs_device *dev = bio->bi_private;
 
 	btrfs_bio_counter_dec(bbio->inode->root->fs_info);
-
 	if (bio->bi_status)
 		btrfs_log_dev_io_error(bio, dev);
 
-	if (bio_op(bio) == REQ_OP_READ) {
-		INIT_WORK(&bbio->end_io_work, btrfs_end_bio_work);
-		queue_work(btrfs_end_io_wq(bbio), &bbio->end_io_work);
-	} else {
-		if (bio_op(bio) == REQ_OP_ZONE_APPEND)
-			btrfs_record_physical_zoned(bbio);
-		btrfs_orig_bbio_end_io(bbio);
-	}
+	INIT_WORK(&bbio->end_io_work, btrfs_simple_end_bio_work);
+	queue_work(btrfs_end_io_wq(bbio), &bbio->end_io_work);
+}
+
+static void btrfs_write_end_bio_work(struct work_struct *work)
+{
+	struct btrfs_bio *bbio =
+		container_of(work, struct btrfs_bio, end_io_work);
+
+	btrfs_orig_bbio_end_io(bbio);
 }
 
 static void btrfs_raid56_end_io(struct bio *bio)
@@ -343,12 +357,23 @@ static void btrfs_raid56_end_io(struct bio *bio)
 
 	btrfs_bio_counter_dec(bioc->fs_info);
 	bbio->mirror_num = bioc->mirror_num;
-	if (bio_op(bio) == REQ_OP_READ && !(bbio->bio.bi_opf & REQ_META))
-		btrfs_check_read_bio(bbio, NULL);
-	else
-		btrfs_orig_bbio_end_io(bbio);
-
 	btrfs_put_bioc(bioc);
+
+	/*
+	 * The RAID5/6 code already completes all bios from workqueues, but for
+	 * writs we need to offload them again to avoid deadlocks in the ordered
+	 * extent processing.
+	 */
+	if (bio_op(bio) == REQ_OP_READ) {
+		/* Metadata reads are checked and repaired by the submitter. */
+		if (!(bio->bi_opf & REQ_META))
+			btrfs_check_read_bio(bbio, NULL);
+		else
+			btrfs_orig_bbio_end_io(bbio);
+	} else {
+		INIT_WORK(&btrfs_bio(bio)->end_io_work, btrfs_write_end_bio_work);
+		queue_work(btrfs_end_io_wq(bbio), &bbio->end_io_work);
+	}
 }
 
 static void btrfs_orig_write_end_io(struct bio *bio)
@@ -372,9 +397,10 @@ static void btrfs_orig_write_end_io(struct bio *bio)
 		bio->bi_status = BLK_STS_IOERR;
 	else
 		bio->bi_status = BLK_STS_OK;
-
-	btrfs_orig_bbio_end_io(bbio);
 	btrfs_put_bioc(bioc);
+
+	INIT_WORK(&bbio->end_io_work, btrfs_write_end_bio_work);
+	queue_work(btrfs_end_io_wq(bbio), &bbio->end_io_work);
 }
 
 static void btrfs_clone_write_end_io(struct bio *bio)
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 0889eb81e71a7d..5b63a5161cedea 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -2008,6 +2008,8 @@ static void btrfs_stop_all_workers(struct btrfs_fs_info *fs_info)
 	 * the queues used for metadata I/O, since tasks from those other work
 	 * queues can do metadata I/O operations.
 	 */
+	if (fs_info->endio_write_meta_workers)
+		destroy_workqueue(fs_info->endio_write_meta_workers);
 	if (fs_info->endio_meta_workers)
 		destroy_workqueue(fs_info->endio_meta_workers);
 }
@@ -2204,6 +2206,8 @@ static int btrfs_init_workqueues(struct btrfs_fs_info *fs_info)
 		alloc_workqueue("btrfs-endio", flags, max_active);
 	fs_info->endio_meta_workers =
 		alloc_workqueue("btrfs-endio-meta", flags, max_active);
+	fs_info->endio_write_meta_workers =
+		alloc_workqueue("btrfs-endio-write-meta", flags, max_active);
 	fs_info->rmw_workers = alloc_workqueue("btrfs-rmw", flags, max_active);
 	fs_info->endio_write_workers =
 		alloc_workqueue("btrfs-endio-write", flags, max_active);
@@ -2224,6 +2228,7 @@ static int btrfs_init_workqueues(struct btrfs_fs_info *fs_info)
 	      fs_info->endio_workers && fs_info->endio_meta_workers &&
 	      fs_info->compressed_write_workers &&
 	      fs_info->endio_write_workers &&
+	      fs_info->endio_write_meta_workers &&
 	      fs_info->endio_freespace_worker && fs_info->rmw_workers &&
 	      fs_info->caching_workers && fs_info->fixup_workers &&
 	      fs_info->delayed_workers && fs_info->qgroup_rescan_workers &&
diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
index 276a17780f2b1b..e2643bc5c039ad 100644
--- a/fs/btrfs/fs.h
+++ b/fs/btrfs/fs.h
@@ -543,6 +543,7 @@ struct btrfs_fs_info {
 	struct workqueue_struct *rmw_workers;
 	struct workqueue_struct *compressed_write_workers;
 	struct workqueue_struct *endio_write_workers;
+	struct workqueue_struct *endio_write_meta_workers;
 	struct workqueue_struct *endio_freespace_worker;
 	struct btrfs_workqueue *caching_workers;
 
diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
index 23f496f0d7b776..48c7510df80a0d 100644
--- a/fs/btrfs/ordered-data.c
+++ b/fs/btrfs/ordered-data.c
@@ -303,14 +303,6 @@ void btrfs_add_ordered_sum(struct btrfs_ordered_extent *entry,
 	spin_unlock_irq(&tree->lock);
 }
 
-static void finish_ordered_fn(struct work_struct *work)
-{
-	struct btrfs_ordered_extent *ordered_extent;
-
-	ordered_extent = container_of(work, struct btrfs_ordered_extent, work);
-	btrfs_finish_ordered_io(ordered_extent);
-}
-
 /*
  * Mark all ordered extents io inside the specified range finished.
  *
@@ -330,17 +322,11 @@ void btrfs_mark_ordered_io_finished(struct btrfs_inode *inode,
 {
 	struct btrfs_ordered_inode_tree *tree = &inode->ordered_tree;
 	struct btrfs_fs_info *fs_info = inode->root->fs_info;
-	struct workqueue_struct *wq;
 	struct rb_node *node;
 	struct btrfs_ordered_extent *entry = NULL;
 	unsigned long flags;
 	u64 cur = file_offset;
 
-	if (btrfs_is_free_space_inode(inode))
-		wq = fs_info->endio_freespace_worker;
-	else
-		wq = fs_info->endio_write_workers;
-
 	if (page)
 		ASSERT(page->mapping && page_offset(page) <= file_offset &&
 		       file_offset + num_bytes <= page_offset(page) + PAGE_SIZE);
@@ -439,8 +425,7 @@ void btrfs_mark_ordered_io_finished(struct btrfs_inode *inode,
 			refcount_inc(&entry->refs);
 			trace_btrfs_ordered_extent_mark_finished(inode, entry);
 			spin_unlock_irqrestore(&tree->lock, flags);
-			INIT_WORK(&entry->work, finish_ordered_fn);
-			queue_work(wq, &entry->work);
+			btrfs_finish_ordered_io(entry);
 			spin_lock_irqsave(&tree->lock, flags);
 		}
 		cur += len;
diff --git a/fs/btrfs/ordered-data.h b/fs/btrfs/ordered-data.h
index b8a92f040458f0..64a37d42e7a24a 100644
--- a/fs/btrfs/ordered-data.h
+++ b/fs/btrfs/ordered-data.h
@@ -146,8 +146,6 @@ struct btrfs_ordered_extent {
 	/* a per root list of all the pending ordered extents */
 	struct list_head root_extent_list;
 
-	struct work_struct work;
-
 	struct completion completion;
 	struct btrfs_work flush_work;
 	struct list_head work_list;
-- 
2.39.2

