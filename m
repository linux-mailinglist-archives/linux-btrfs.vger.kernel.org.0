Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96458519F44
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 May 2022 14:25:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231473AbiEDM3Q (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 4 May 2022 08:29:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349414AbiEDM3L (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 4 May 2022 08:29:11 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3059D41
        for <linux-btrfs@vger.kernel.org>; Wed,  4 May 2022 05:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=Pxb2r/N2hy8zNx+jRbFQWSB2Gef2Um+UIwyMBitCtQA=; b=kVe16NoIPKrwrNN94HSmo2U0Gs
        AFX0ZxSiprJzEM43HmmXCwhAuqMV9HnSB585gA1/TK5jcHesS3hh8yBkTX6ArTlyNXr36LfFq+rKx
        zqDDKJi8DNcrt/JT9JHyY+etx7+7FjAy5NoPg8vsEhinOpUdLmHkOFyDBbcCoG7VBo2bfSOZlELTG
        u7ZZxLsN1C/VsVwSCMwWLqxky2oRvHf3dzZbD+b7CNw9je22AknRiIi0yS1fo0LNcGJ4eR6S4rUH0
        blMcwy8VrXxPh/jaqH0ojvuQ3IHCfvb79VaD4CsOD6oyEU4W9k1Ld5a2lPjKNq5HI3MphICl7goxs
        QCpFTdBw==;
Received: from [8.34.116.185] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nmE4Q-00Ahmx-9Z; Wed, 04 May 2022 12:25:30 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     David Sterba <dsterba@suse.com>,
        Josef Bacik <josef@toxicpanda.com>, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: [PATCH 05/10] btrfs: defer I/O completion based on the btrfs_raid_bio
Date:   Wed,  4 May 2022 05:25:19 -0700
Message-Id: <20220504122524.558088-6-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220504122524.558088-1-hch@lst.de>
References: <20220504122524.558088-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Instead of attaching a an extra allocation an indirect call to each
low-level bio issued by the RAID code, add a work_struct to struct
btrfs_raid_bio and only defer the per-rbio completion action.  The
per-bio action for all the I/Os are trivial and can be safely done
from interrupt context.

As a nice side effect this also allows sharing the boilerplate code
for the per-bio completions

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/ctree.h   |   2 +-
 fs/btrfs/disk-io.c |  12 ++---
 fs/btrfs/disk-io.h |   1 -
 fs/btrfs/raid56.c  | 109 ++++++++++++++++++---------------------------
 4 files changed, 48 insertions(+), 76 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 6f539ddf7467a..a3739143bf44c 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -853,7 +853,7 @@ struct btrfs_fs_info {
 	struct btrfs_workqueue *flush_workers;
 	struct btrfs_workqueue *endio_workers;
 	struct btrfs_workqueue *endio_meta_workers;
-	struct btrfs_workqueue *endio_raid56_workers;
+	struct workqueue_struct *endio_raid56_workers;
 	struct workqueue_struct *rmw_workers;
 	struct btrfs_workqueue *endio_meta_write_workers;
 	struct btrfs_workqueue *endio_write_workers;
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 56d4d4db976bd..ef117eaab468c 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -753,14 +753,10 @@ static void end_workqueue_bio(struct bio *bio)
 			wq = fs_info->endio_meta_write_workers;
 		else if (end_io_wq->metadata == BTRFS_WQ_ENDIO_FREE_SPACE)
 			wq = fs_info->endio_freespace_worker;
-		else if (end_io_wq->metadata == BTRFS_WQ_ENDIO_RAID56)
-			wq = fs_info->endio_raid56_workers;
 		else
 			wq = fs_info->endio_write_workers;
 	} else {
-		if (end_io_wq->metadata == BTRFS_WQ_ENDIO_RAID56)
-			wq = fs_info->endio_raid56_workers;
-		else if (end_io_wq->metadata)
+		if (end_io_wq->metadata)
 			wq = fs_info->endio_meta_workers;
 		else
 			wq = fs_info->endio_workers;
@@ -2273,7 +2269,8 @@ static void btrfs_stop_all_workers(struct btrfs_fs_info *fs_info)
 	btrfs_destroy_workqueue(fs_info->hipri_workers);
 	btrfs_destroy_workqueue(fs_info->workers);
 	btrfs_destroy_workqueue(fs_info->endio_workers);
-	btrfs_destroy_workqueue(fs_info->endio_raid56_workers);
+	if (fs_info->endio_raid56_workers)
+		destroy_workqueue(fs_info->endio_raid56_workers);
 	if (fs_info->rmw_workers)
 		destroy_workqueue(fs_info->rmw_workers);
 	btrfs_destroy_workqueue(fs_info->endio_write_workers);
@@ -2476,8 +2473,7 @@ static int btrfs_init_workqueues(struct btrfs_fs_info *fs_info)
 		btrfs_alloc_workqueue(fs_info, "endio-meta-write", flags,
 				      max_active, 2);
 	fs_info->endio_raid56_workers =
-		btrfs_alloc_workqueue(fs_info, "endio-raid56", flags,
-				      max_active, 4);
+		alloc_workqueue("btrfs-endio-raid56", flags, max_active);
 	fs_info->rmw_workers = alloc_workqueue("btrfs-rmw", flags, max_active);
 	fs_info->endio_write_workers =
 		btrfs_alloc_workqueue(fs_info, "endio-write", flags,
diff --git a/fs/btrfs/disk-io.h b/fs/btrfs/disk-io.h
index 4ee8c42c9f783..809ef065f1666 100644
--- a/fs/btrfs/disk-io.h
+++ b/fs/btrfs/disk-io.h
@@ -21,7 +21,6 @@ enum btrfs_wq_endio_type {
 	BTRFS_WQ_ENDIO_DATA,
 	BTRFS_WQ_ENDIO_METADATA,
 	BTRFS_WQ_ENDIO_FREE_SPACE,
-	BTRFS_WQ_ENDIO_RAID56,
 };
 
 static inline u64 btrfs_sb_offset(int mirror)
diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
index a5b623ee6facd..8e089fb4212ff 100644
--- a/fs/btrfs/raid56.c
+++ b/fs/btrfs/raid56.c
@@ -164,6 +164,9 @@ struct btrfs_raid_bio {
 	atomic_t stripes_pending;
 
 	atomic_t error;
+
+	struct work_struct end_io_work;
+
 	/*
 	 * these are two arrays of pointers.  We allocate the
 	 * rbio big enough to hold them both and setup their
@@ -1552,15 +1555,7 @@ static void set_bio_pages_uptodate(struct btrfs_raid_bio *rbio, struct bio *bio)
 	}
 }
 
-/*
- * end io for the read phase of the rmw cycle.  All the bios here are physical
- * stripe bios we've read from the disk so we can recalculate the parity of the
- * stripe.
- *
- * This will usually kick off finish_rmw once all the bios are read in, but it
- * may trigger parity reconstruction if we had any errors along the way
- */
-static void raid_rmw_end_io(struct bio *bio)
+static void raid56_bio_end_io(struct bio *bio)
 {
 	struct btrfs_raid_bio *rbio = bio->bi_private;
 
@@ -1571,23 +1566,34 @@ static void raid_rmw_end_io(struct bio *bio)
 
 	bio_put(bio);
 
-	if (!atomic_dec_and_test(&rbio->stripes_pending))
-		return;
+	if (atomic_dec_and_test(&rbio->stripes_pending))
+		queue_work(rbio->bioc->fs_info->endio_raid56_workers,
+			   &rbio->end_io_work);
+}
 
-	if (atomic_read(&rbio->error) > rbio->bioc->max_errors)
-		goto cleanup;
+/*
+ * End io handler for the read phase of the rmw cycle.  All the bios here are
+ * physical stripe bios we've read from the disk so we can recalculate the
+ * parity of the stripe.
+ *
+ * This will usually kick off finish_rmw once all the bios are read in, but it
+ * may trigger parity reconstruction if we had any errors along the way
+ */
+static void raid56_rmw_end_io_work(struct work_struct *work)
+{
+	struct btrfs_raid_bio *rbio =
+		container_of(work, struct btrfs_raid_bio, end_io_work);
+
+	if (atomic_read(&rbio->error) > rbio->bioc->max_errors) {
+		rbio_orig_end_io(rbio, BLK_STS_IOERR);
+		return;
+	}
 
 	/*
-	 * this will normally call finish_rmw to start our write
-	 * but if there are any failed stripes we'll reconstruct
-	 * from parity first
+	 * This will normally call finish_rmw to start our write but if there
+	 * are any failed stripes we'll reconstruct from parity first.
 	 */
 	validate_rbio_for_rmw(rbio);
-	return;
-
-cleanup:
-
-	rbio_orig_end_io(rbio, BLK_STS_IOERR);
 }
 
 /*
@@ -1662,11 +1668,9 @@ static int raid56_rmw_stripe(struct btrfs_raid_bio *rbio)
 	 * touch it after that.
 	 */
 	atomic_set(&rbio->stripes_pending, bios_to_read);
+	INIT_WORK(&rbio->end_io_work, raid56_rmw_end_io_work);
 	while ((bio = bio_list_pop(&bio_list))) {
-		bio->bi_end_io = raid_rmw_end_io;
-
-		btrfs_bio_wq_end_io(rbio->bioc->fs_info, bio, BTRFS_WQ_ENDIO_RAID56);
-
+		bio->bi_end_io = raid56_bio_end_io;
 		submit_bio(bio);
 	}
 	/* the actual write will happen once the reads are done */
@@ -2108,25 +2112,13 @@ static void __raid_recover_end_io(struct btrfs_raid_bio *rbio)
 }
 
 /*
- * This is called only for stripes we've read from disk to
- * reconstruct the parity.
+ * This is called only for stripes we've read from disk to reconstruct the
+ * parity.
  */
-static void raid_recover_end_io(struct bio *bio)
+static void raid_recover_end_io_work(struct work_struct *work)
 {
-	struct btrfs_raid_bio *rbio = bio->bi_private;
-
-	/*
-	 * we only read stripe pages off the disk, set them
-	 * up to date if there were no errors
-	 */
-	if (bio->bi_status)
-		fail_bio_stripe(rbio, bio);
-	else
-		set_bio_pages_uptodate(rbio, bio);
-	bio_put(bio);
-
-	if (!atomic_dec_and_test(&rbio->stripes_pending))
-		return;
+	struct btrfs_raid_bio *rbio =
+		container_of(work, struct btrfs_raid_bio, end_io_work);
 
 	if (atomic_read(&rbio->error) > rbio->bioc->max_errors)
 		rbio_orig_end_io(rbio, BLK_STS_IOERR);
@@ -2209,11 +2201,9 @@ static int __raid56_parity_recover(struct btrfs_raid_bio *rbio)
 	 * touch it after that.
 	 */
 	atomic_set(&rbio->stripes_pending, bios_to_read);
+	INIT_WORK(&rbio->end_io_work, raid_recover_end_io_work);
 	while ((bio = bio_list_pop(&bio_list))) {
-		bio->bi_end_io = raid_recover_end_io;
-
-		btrfs_bio_wq_end_io(rbio->bioc->fs_info, bio, BTRFS_WQ_ENDIO_RAID56);
-
+		bio->bi_end_io = raid56_bio_end_io;
 		submit_bio(bio);
 	}
 
@@ -2583,7 +2573,6 @@ static noinline void finish_parity_scrub(struct btrfs_raid_bio *rbio,
 
 	while ((bio = bio_list_pop(&bio_list))) {
 		bio->bi_end_io = raid_write_end_io;
-
 		submit_bio(bio);
 	}
 	return;
@@ -2671,24 +2660,14 @@ static void validate_rbio_for_parity_scrub(struct btrfs_raid_bio *rbio)
  * This will usually kick off finish_rmw once all the bios are read in, but it
  * may trigger parity reconstruction if we had any errors along the way
  */
-static void raid56_parity_scrub_end_io(struct bio *bio)
+static void raid56_parity_scrub_end_io_work(struct work_struct *work)
 {
-	struct btrfs_raid_bio *rbio = bio->bi_private;
-
-	if (bio->bi_status)
-		fail_bio_stripe(rbio, bio);
-	else
-		set_bio_pages_uptodate(rbio, bio);
-
-	bio_put(bio);
-
-	if (!atomic_dec_and_test(&rbio->stripes_pending))
-		return;
+	struct btrfs_raid_bio *rbio =
+		container_of(work, struct btrfs_raid_bio, end_io_work);
 
 	/*
-	 * this will normally call finish_rmw to start our write
-	 * but if there are any failed stripes we'll reconstruct
-	 * from parity first
+	 * This will normally call finish_rmw to start our write, but if there
+	 * are any failed stripes we'll reconstruct from parity first
 	 */
 	validate_rbio_for_parity_scrub(rbio);
 }
@@ -2758,11 +2737,9 @@ static void raid56_parity_scrub_stripe(struct btrfs_raid_bio *rbio)
 	 * touch it after that.
 	 */
 	atomic_set(&rbio->stripes_pending, bios_to_read);
+	INIT_WORK(&rbio->end_io_work, raid56_parity_scrub_end_io_work);
 	while ((bio = bio_list_pop(&bio_list))) {
-		bio->bi_end_io = raid56_parity_scrub_end_io;
-
-		btrfs_bio_wq_end_io(rbio->bioc->fs_info, bio, BTRFS_WQ_ENDIO_RAID56);
-
+		bio->bi_end_io = raid56_bio_end_io;
 		submit_bio(bio);
 	}
 	/* the actual write will happen once the reads are done */
-- 
2.30.2

