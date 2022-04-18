Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 136E6504BBC
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Apr 2022 06:43:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236518AbiDREqC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 18 Apr 2022 00:46:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236515AbiDREqB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 18 Apr 2022 00:46:01 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8820F17052
        for <linux-btrfs@vger.kernel.org>; Sun, 17 Apr 2022 21:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=H1Y4bLJT4ePNgrjFJrEzc/Vb5pMH+rbcJCF4jvongn8=; b=W47GeY49pu0/PJNARLe7YeiBft
        5tt1i2mXbOZ82ykAGI4YCurth0kx6c+pE0tRDGD9o8A39kgelwkZsq8A4P0y0sYXcPZ3WvLjjpNbt
        diCinQvoLODfv3MG7rPMzUL0kGrre32TilO30fK8TCH6yBfP3R93w+uf/rcnrNrfxTylvkYr/npQg
        yOaLMFKzUJPXiSOy/c0pH27llIEPFVo5I1mcdmgItNCvvAo6IviqoSNwtJlER6M8935agFDexDw7q
        K8zI6kNw88BO/lJUTckFjaj6d1DJXoUj+vhGx0nARyuFMW9IP6N5OVadjefELB+XWtH1Yej4bRhpq
        fE/sMVIQ==;
Received: from [2a02:1205:504b:4280:f5dd:42a4:896c:d877] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ngJEN-00FYRH-S5; Mon, 18 Apr 2022 04:43:20 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Subject: [PATCH 2/3] btrfs: use normal workqueues for scrub
Date:   Mon, 18 Apr 2022 06:43:10 +0200
Message-Id: <20220418044311.359720-3-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220418044311.359720-1-hch@lst.de>
References: <20220418044311.359720-1-hch@lst.de>
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

All three scrub workqueues don't need ordered execution or thread
disabling threshold (as the thresh parameter is less than DFT_THRESHOLD).
Just switch to the normal workqueues that use a lot less resources,
especially in the work_struct vs btrfs_work structures.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/ctree.h |  6 ++--
 fs/btrfs/scrub.c | 76 ++++++++++++++++++++++--------------------------
 fs/btrfs/super.c |  2 --
 3 files changed, 38 insertions(+), 46 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 383aba168e1d2..59135f0850a6e 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -946,9 +946,9 @@ struct btrfs_fs_info {
 	 * running.
 	 */
 	refcount_t scrub_workers_refcnt;
-	struct btrfs_workqueue *scrub_workers;
-	struct btrfs_workqueue *scrub_wr_completion_workers;
-	struct btrfs_workqueue *scrub_parity_workers;
+	struct workqueue_struct *scrub_workers;
+	struct workqueue_struct *scrub_wr_completion_workers;
+	struct workqueue_struct *scrub_parity_workers;
 	struct btrfs_subpage_info *subpage_info;
 
 	struct btrfs_discard_ctl discard_ctl;
diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 13ba458c080ce..0be910baf2235 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -90,7 +90,7 @@ struct scrub_bio {
 	struct scrub_sector	*sectors[SCRUB_SECTORS_PER_BIO];
 	int			sector_count;
 	int			next_free;
-	struct btrfs_work	work;
+	struct work_struct	work;
 };
 
 struct scrub_block {
@@ -110,7 +110,7 @@ struct scrub_block {
 		/* It is for the data with checksum */
 		unsigned int	data_corrected:1;
 	};
-	struct btrfs_work	work;
+	struct work_struct	work;
 };
 
 /* Used for the chunks with parity stripe such RAID5/6 */
@@ -132,7 +132,7 @@ struct scrub_parity {
 	struct list_head	sectors_list;
 
 	/* Work of parity check and repair */
-	struct btrfs_work	work;
+	struct work_struct	work;
 
 	/* Mark the parity blocks which have data */
 	unsigned long		*dbitmap;
@@ -231,7 +231,7 @@ static int scrub_sectors(struct scrub_ctx *sctx, u64 logical, u32 len,
 			 u64 gen, int mirror_num, u8 *csum,
 			 u64 physical_for_dev_replace);
 static void scrub_bio_end_io(struct bio *bio);
-static void scrub_bio_end_io_worker(struct btrfs_work *work);
+static void scrub_bio_end_io_worker(struct work_struct *work);
 static void scrub_block_complete(struct scrub_block *sblock);
 static void scrub_remap_extent(struct btrfs_fs_info *fs_info,
 			       u64 extent_logical, u32 extent_len,
@@ -242,7 +242,7 @@ static int scrub_add_sector_to_wr_bio(struct scrub_ctx *sctx,
 				      struct scrub_sector *sector);
 static void scrub_wr_submit(struct scrub_ctx *sctx);
 static void scrub_wr_bio_end_io(struct bio *bio);
-static void scrub_wr_bio_end_io_worker(struct btrfs_work *work);
+static void scrub_wr_bio_end_io_worker(struct work_struct *work);
 static void scrub_put_ctx(struct scrub_ctx *sctx);
 
 static inline int scrub_is_page_on_raid56(struct scrub_sector *sector)
@@ -587,8 +587,7 @@ static noinline_for_stack struct scrub_ctx *scrub_setup_ctx(
 		sbio->index = i;
 		sbio->sctx = sctx;
 		sbio->sector_count = 0;
-		btrfs_init_work(&sbio->work, scrub_bio_end_io_worker, NULL,
-				NULL);
+		INIT_WORK(&sbio->work, scrub_bio_end_io_worker);
 
 		if (i != SCRUB_BIOS_PER_SCTX - 1)
 			sctx->bios[i]->next_free = i + 1;
@@ -1718,11 +1717,11 @@ static void scrub_wr_bio_end_io(struct bio *bio)
 	sbio->status = bio->bi_status;
 	sbio->bio = bio;
 
-	btrfs_init_work(&sbio->work, scrub_wr_bio_end_io_worker, NULL, NULL);
-	btrfs_queue_work(fs_info->scrub_wr_completion_workers, &sbio->work);
+	INIT_WORK(&sbio->work, scrub_wr_bio_end_io_worker);
+	queue_work(fs_info->scrub_wr_completion_workers, &sbio->work);
 }
 
-static void scrub_wr_bio_end_io_worker(struct btrfs_work *work)
+static void scrub_wr_bio_end_io_worker(struct work_struct *work)
 {
 	struct scrub_bio *sbio = container_of(work, struct scrub_bio, work);
 	struct scrub_ctx *sctx = sbio->sctx;
@@ -2119,10 +2118,10 @@ static void scrub_missing_raid56_end_io(struct bio *bio)
 
 	bio_put(bio);
 
-	btrfs_queue_work(fs_info->scrub_workers, &sblock->work);
+	queue_work(fs_info->scrub_workers, &sblock->work);
 }
 
-static void scrub_missing_raid56_worker(struct btrfs_work *work)
+static void scrub_missing_raid56_worker(struct work_struct *work)
 {
 	struct scrub_block *sblock = container_of(work, struct scrub_block, work);
 	struct scrub_ctx *sctx = sblock->sctx;
@@ -2208,7 +2207,7 @@ static void scrub_missing_raid56_pages(struct scrub_block *sblock)
 		raid56_add_scrub_pages(rbio, sector->page, sector->logical);
 	}
 
-	btrfs_init_work(&sblock->work, scrub_missing_raid56_worker, NULL, NULL);
+	INIT_WORK(&sblock->work, scrub_missing_raid56_worker);
 	scrub_block_get(sblock);
 	scrub_pending_bio_inc(sctx);
 	raid56_submit_missing_rbio(rbio);
@@ -2328,10 +2327,10 @@ static void scrub_bio_end_io(struct bio *bio)
 	sbio->status = bio->bi_status;
 	sbio->bio = bio;
 
-	btrfs_queue_work(fs_info->scrub_workers, &sbio->work);
+	queue_work(fs_info->scrub_workers, &sbio->work);
 }
 
-static void scrub_bio_end_io_worker(struct btrfs_work *work)
+static void scrub_bio_end_io_worker(struct work_struct *work)
 {
 	struct scrub_bio *sbio = container_of(work, struct scrub_bio, work);
 	struct scrub_ctx *sctx = sbio->sctx;
@@ -2761,7 +2760,7 @@ static void scrub_free_parity(struct scrub_parity *sparity)
 	kfree(sparity);
 }
 
-static void scrub_parity_bio_endio_worker(struct btrfs_work *work)
+static void scrub_parity_bio_endio_worker(struct work_struct *work)
 {
 	struct scrub_parity *sparity = container_of(work, struct scrub_parity,
 						    work);
@@ -2782,9 +2781,8 @@ static void scrub_parity_bio_endio(struct bio *bio)
 
 	bio_put(bio);
 
-	btrfs_init_work(&sparity->work, scrub_parity_bio_endio_worker, NULL,
-			NULL);
-	btrfs_queue_work(fs_info->scrub_parity_workers, &sparity->work);
+	INIT_WORK(&sparity->work, scrub_parity_bio_endio_worker);
+	queue_work(fs_info->scrub_parity_workers, &sparity->work);
 }
 
 static void scrub_parity_check_and_repair(struct scrub_parity *sparity)
@@ -3930,22 +3928,20 @@ static void scrub_workers_put(struct btrfs_fs_info *fs_info)
 {
 	if (refcount_dec_and_mutex_lock(&fs_info->scrub_workers_refcnt,
 					&fs_info->scrub_lock)) {
-		struct btrfs_workqueue *scrub_workers = NULL;
-		struct btrfs_workqueue *scrub_wr_comp = NULL;
-		struct btrfs_workqueue *scrub_parity = NULL;
-
-		scrub_workers = fs_info->scrub_workers;
-		scrub_wr_comp = fs_info->scrub_wr_completion_workers;
-		scrub_parity = fs_info->scrub_parity_workers;
+		struct workqueue_struct *scrub_workers = fs_info->scrub_workers;
+		struct workqueue_struct *scrub_wr_comp =
+			fs_info->scrub_wr_completion_workers;
+		struct workqueue_struct *scrub_parity =
+			fs_info->scrub_parity_workers;
 
 		fs_info->scrub_workers = NULL;
 		fs_info->scrub_wr_completion_workers = NULL;
 		fs_info->scrub_parity_workers = NULL;
 		mutex_unlock(&fs_info->scrub_lock);
 
-		btrfs_destroy_workqueue(scrub_workers);
-		btrfs_destroy_workqueue(scrub_wr_comp);
-		btrfs_destroy_workqueue(scrub_parity);
+		destroy_workqueue(scrub_workers);
+		destroy_workqueue(scrub_wr_comp);
+		destroy_workqueue(scrub_parity);
 	}
 }
 
@@ -3955,9 +3951,9 @@ static void scrub_workers_put(struct btrfs_fs_info *fs_info)
 static noinline_for_stack int scrub_workers_get(struct btrfs_fs_info *fs_info,
 						int is_dev_replace)
 {
-	struct btrfs_workqueue *scrub_workers = NULL;
-	struct btrfs_workqueue *scrub_wr_comp = NULL;
-	struct btrfs_workqueue *scrub_parity = NULL;
+	struct workqueue_struct *scrub_workers = NULL;
+	struct workqueue_struct *scrub_wr_comp = NULL;
+	struct workqueue_struct *scrub_parity = NULL;
 	unsigned int flags = WQ_FREEZABLE | WQ_UNBOUND;
 	int max_active = fs_info->thread_pool_size;
 	int ret = -ENOMEM;
@@ -3965,18 +3961,16 @@ static noinline_for_stack int scrub_workers_get(struct btrfs_fs_info *fs_info,
 	if (refcount_inc_not_zero(&fs_info->scrub_workers_refcnt))
 		return 0;
 
-	scrub_workers = btrfs_alloc_workqueue(fs_info, "scrub", flags,
-					      is_dev_replace ? 1 : max_active, 4);
+	scrub_workers = alloc_workqueue("btrfs-scrub", flags,
+					is_dev_replace ? 1 : max_active);
 	if (!scrub_workers)
 		goto fail_scrub_workers;
 
-	scrub_wr_comp = btrfs_alloc_workqueue(fs_info, "scrubwrc", flags,
-					      max_active, 2);
+	scrub_wr_comp = alloc_workqueue("btrfs-scrubwrc", flags, max_active);
 	if (!scrub_wr_comp)
 		goto fail_scrub_wr_completion_workers;
 
-	scrub_parity = btrfs_alloc_workqueue(fs_info, "scrubparity", flags,
-					     max_active, 2);
+	scrub_parity = alloc_workqueue("btrfs-scrubparity", flags, max_active);
 	if (!scrub_parity)
 		goto fail_scrub_parity_workers;
 
@@ -3997,11 +3991,11 @@ static noinline_for_stack int scrub_workers_get(struct btrfs_fs_info *fs_info,
 	mutex_unlock(&fs_info->scrub_lock);
 
 	ret = 0;
-	btrfs_destroy_workqueue(scrub_parity);
+	destroy_workqueue(scrub_parity);
 fail_scrub_parity_workers:
-	btrfs_destroy_workqueue(scrub_wr_comp);
+	destroy_workqueue(scrub_wr_comp);
 fail_scrub_wr_completion_workers:
-	btrfs_destroy_workqueue(scrub_workers);
+	destroy_workqueue(scrub_workers);
 fail_scrub_workers:
 	return ret;
 }
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 2236024aca648..b1fdc6a26c76e 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -1913,8 +1913,6 @@ static void btrfs_resize_thread_pool(struct btrfs_fs_info *fs_info,
 	btrfs_workqueue_set_max(fs_info->endio_write_workers, new_pool_size);
 	btrfs_workqueue_set_max(fs_info->endio_freespace_worker, new_pool_size);
 	btrfs_workqueue_set_max(fs_info->delayed_workers, new_pool_size);
-	btrfs_workqueue_set_max(fs_info->scrub_wr_completion_workers,
-				new_pool_size);
 }
 
 static inline void btrfs_remount_begin(struct btrfs_fs_info *fs_info,
-- 
2.30.2

