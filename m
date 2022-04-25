Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7CBE50DAA7
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Apr 2022 09:56:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236418AbiDYH73 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 25 Apr 2022 03:59:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241821AbiDYH5x (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 25 Apr 2022 03:57:53 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC69312AB4
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Apr 2022 00:54:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=T7lWEjph/SypMnlzOnS9w29dhO3ZFDyDZrJi5aoI4vk=; b=DcKDWn9PyZUGx4PoRl0Olr+8Bg
        95yyI2nDw9qlniJZjGuuEApZPXsU8D353MopgAWDE+CbtXbAioHfdwnkYFD1HPjmwuBzjBg6GvKkH
        TfwZzun3570GBpwZr+Xt5oc1LdmdE9tE3wY/57nS/Zoa2h/L88DfBaByV1QcQXVbXS7X9frLJ/tDr
        Mm2gLU0W3+4WgNt0bdmOoNHaNQKOJHgPViAsDhrRqAdVlMqIFPZkJgDsPlX1N164AcJJv5rrX7iKc
        pWuP354crIfQnwiy+MNWrSwL2FxQ8i2apieiaaiZAo4AjTOwrR0mEubU5ZKJ7bAgVQrpAeY/t/NJB
        Ew6DDL5A==;
Received: from 80-254-69-104.dynamic.monzoon.net ([80.254.69.104] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nitYM-008gia-3M; Mon, 25 Apr 2022 07:54:38 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Qu Wenruo <wqu@suse.com>
Cc:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org
Subject: [PATCH 05/10] btrfs: defer I/O completion based on the btrfs_raid_bio
Date:   Mon, 25 Apr 2022 09:54:13 +0200
Message-Id: <20220425075418.2192130-6-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220425075418.2192130-1-hch@lst.de>
References: <20220425075418.2192130-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
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
 fs/btrfs/disk-io.c |  11 ++---
 fs/btrfs/disk-io.h |   1 -
 fs/btrfs/raid56.c  | 111 ++++++++++++++++++---------------------------
 4 files changed, 48 insertions(+), 77 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index ab9a0cfed7bb0..a76291e4594f2 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -852,7 +852,7 @@ struct btrfs_fs_info {
 	struct btrfs_workqueue *flush_workers;
 	struct btrfs_workqueue *endio_workers;
 	struct btrfs_workqueue *endio_meta_workers;
-	struct btrfs_workqueue *endio_raid56_workers;
+	struct workqueue_struct *endio_raid56_workers;
 	struct workqueue_struct *rmw_workers;
 	struct btrfs_workqueue *endio_meta_write_workers;
 	struct btrfs_workqueue *endio_write_workers;
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index c5dba8a39e952..cb8fe234fbc0c 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -754,14 +754,10 @@ static void end_workqueue_bio(struct bio *bio)
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
@@ -2282,7 +2278,7 @@ static void btrfs_stop_all_workers(struct btrfs_fs_info *fs_info)
 	btrfs_destroy_workqueue(fs_info->hipri_workers);
 	btrfs_destroy_workqueue(fs_info->workers);
 	btrfs_destroy_workqueue(fs_info->endio_workers);
-	btrfs_destroy_workqueue(fs_info->endio_raid56_workers);
+	destroy_workqueue(fs_info->endio_raid56_workers);
 	destroy_workqueue(fs_info->rmw_workers);
 	btrfs_destroy_workqueue(fs_info->endio_write_workers);
 	btrfs_destroy_workqueue(fs_info->endio_freespace_worker);
@@ -2490,8 +2486,7 @@ static int btrfs_init_workqueues(struct btrfs_fs_info *fs_info)
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
index 9340e3266e0ac..97255e3d7e524 100644
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
index a5b623ee6facd..1a3c1a9b10d0b 100644
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
 
@@ -2582,8 +2572,7 @@ static noinline void finish_parity_scrub(struct btrfs_raid_bio *rbio,
 	atomic_set(&rbio->stripes_pending, nr_data);
 
 	while ((bio = bio_list_pop(&bio_list))) {
-		bio->bi_end_io = raid_write_end_io;
-
+		bio->bi_end_io = raid56_bio_end_io;
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

