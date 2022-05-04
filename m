Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50223519F3B
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 May 2022 14:25:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349419AbiEDM3J (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 4 May 2022 08:29:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349424AbiEDM3I (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 4 May 2022 08:29:08 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 196CDD41
        for <linux-btrfs@vger.kernel.org>; Wed,  4 May 2022 05:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=oKwvNAmZbm9kOQyVWD3GDYHbEVh4TteXAq/i/JqGOX8=; b=Na9lZyMzbTqF5vmeEW4KLE2kNf
        3XGI9ui6pTFyrVkUGWWR1MkhRW2qyh2442KMWc+bklOAp4+W3wGw2Cv2CeHY2YSHeCXf5RVxAgxRW
        NlNBiQwv9WQbwzXIJUgLH6zbxIB76bq6U4ci/wUhn8LxAUDRhF6UwnWiZX8kD+aghyJMOCiqD+UeD
        pfR9q+lcpqQvf+6F74XKzlJJc/9aLWs6QENDtRM5OKmja4yngMSjZ0PJ0iKhEDoUnHMPvYvNnA2HW
        6rsso0FF7EUNHrlX1aPim2/j3KkFX1vjzck6U+Kq15XDZjmPcdteSlsfrih8VqNsBJ61n3R0YGr5v
        NePLdzuQ==;
Received: from [8.34.116.185] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nmE4Q-00AhnJ-VU; Wed, 04 May 2022 12:25:31 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     David Sterba <dsterba@suse.com>,
        Josef Bacik <josef@toxicpanda.com>, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: [PATCH 06/10] btrfs: don't use btrfs_bio_wq_end_io for compressed writes
Date:   Wed,  4 May 2022 05:25:20 -0700
Message-Id: <20220504122524.558088-7-hch@lst.de>
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

Compressed write bio completion is the only user of btrfs_bio_wq_end_io
for writes, and the use of btrfs_bio_wq_end_io is a little suboptimal
here as we only real need user context for the final completion of a
compressed_bio structure, and not every single bio completion.

Add a work_struct to struct compressed_bio instead and use that to call
finish_compressed_bio_write.  This allows to remove all handling of
write bios in the btrfs_bio_wq_end_io infrastructure.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/compression.c | 45 +++++++++++++++++++++---------------------
 fs/btrfs/compression.h |  7 +++++--
 fs/btrfs/ctree.h       |  2 +-
 fs/btrfs/disk-io.c     | 30 +++++++++++-----------------
 fs/btrfs/super.c       |  2 --
 5 files changed, 41 insertions(+), 45 deletions(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index f4564f32f6d93..9d5986a30a4a2 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -403,6 +403,14 @@ static void finish_compressed_bio_write(struct compressed_bio *cb)
 	kfree(cb);
 }
 
+static void btrfs_finish_compressed_write_work(struct work_struct *work)
+{
+	struct compressed_bio *cb =
+		container_of(work, struct compressed_bio, write_end_work);
+
+	finish_compressed_bio_write(cb);
+}
+
 /*
  * Do the cleanup once all the compressed pages hit the disk.  This will clear
  * writeback on the file pages and free the compressed pages.
@@ -414,29 +422,16 @@ static void end_compressed_bio_write(struct bio *bio)
 {
 	struct compressed_bio *cb = bio->bi_private;
 
-	if (!dec_and_test_compressed_bio(cb, bio))
-		goto out;
-
-	btrfs_record_physical_zoned(cb->inode, cb->start, bio);
+	if (dec_and_test_compressed_bio(cb, bio)) {
+		struct btrfs_fs_info *fs_info = btrfs_sb(cb->inode->i_sb);
 
-	finish_compressed_bio_write(cb);
-out:
+		btrfs_record_physical_zoned(cb->inode, cb->start, bio);
+		queue_work(fs_info->compressed_write_workers,
+			   &cb->write_end_work);
+	}
 	bio_put(bio);
 }
 
-static blk_status_t submit_compressed_bio(struct btrfs_fs_info *fs_info,
-					  struct bio *bio, int mirror_num)
-{
-	blk_status_t ret;
-
-	ASSERT(bio->bi_iter.bi_size);
-	ret = btrfs_bio_wq_end_io(fs_info, bio, BTRFS_WQ_ENDIO_DATA);
-	if (ret)
-		return ret;
-	ret = btrfs_map_bio(fs_info, bio, mirror_num);
-	return ret;
-}
-
 /*
  * Allocate a compressed_bio, which will be used to read/write on-disk
  * (aka, compressed) * data.
@@ -533,7 +528,7 @@ blk_status_t btrfs_submit_compressed_write(struct btrfs_inode *inode, u64 start,
 	cb->compressed_pages = compressed_pages;
 	cb->compressed_len = compressed_len;
 	cb->writeback = writeback;
-	cb->orig_bio = NULL;
+	INIT_WORK(&cb->write_end_work, btrfs_finish_compressed_write_work);
 	cb->nr_pages = nr_pages;
 
 	if (blkcg_css)
@@ -603,7 +598,8 @@ blk_status_t btrfs_submit_compressed_write(struct btrfs_inode *inode, u64 start,
 					goto finish_cb;
 			}
 
-			ret = submit_compressed_bio(fs_info, bio, 0);
+			ASSERT(bio->bi_iter.bi_size);
+			ret = btrfs_map_bio(fs_info, bio, 0);
 			if (ret)
 				goto finish_cb;
 			bio = NULL;
@@ -941,7 +937,12 @@ void btrfs_submit_compressed_read(struct inode *inode, struct bio *bio,
 						  fs_info->sectorsize);
 			sums += fs_info->csum_size * nr_sectors;
 
-			ret = submit_compressed_bio(fs_info, comp_bio, mirror_num);
+			ASSERT(comp_bio->bi_iter.bi_size);
+			ret = btrfs_bio_wq_end_io(fs_info, comp_bio,
+						  BTRFS_WQ_ENDIO_DATA);
+			if (ret)
+				goto finish_cb;
+			ret = btrfs_map_bio(fs_info, comp_bio, mirror_num);
 			if (ret)
 				goto finish_cb;
 			comp_bio = NULL;
diff --git a/fs/btrfs/compression.h b/fs/btrfs/compression.h
index 2707404389a5d..4a40725cbf1db 100644
--- a/fs/btrfs/compression.h
+++ b/fs/btrfs/compression.h
@@ -61,8 +61,11 @@ struct compressed_bio {
 	blk_status_t status;
 	int mirror_num;
 
-	/* for reads, this is the bio we are copying the data into */
-	struct bio *orig_bio;
+	union {
+		/* for reads, this is the bio we are copying the data into */
+		struct bio *orig_bio;
+		struct work_struct write_end_work;
+	};
 
 	/*
 	 * the start of a variable length array of checksums only
diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index a3739143bf44c..6cf699959286d 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -855,7 +855,7 @@ struct btrfs_fs_info {
 	struct btrfs_workqueue *endio_meta_workers;
 	struct workqueue_struct *endio_raid56_workers;
 	struct workqueue_struct *rmw_workers;
-	struct btrfs_workqueue *endio_meta_write_workers;
+	struct workqueue_struct *compressed_write_workers;
 	struct btrfs_workqueue *endio_write_workers;
 	struct btrfs_workqueue *endio_freespace_worker;
 	struct btrfs_workqueue *caching_workers;
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index ef117eaab468c..aa56ba9378e1f 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -748,19 +748,10 @@ static void end_workqueue_bio(struct bio *bio)
 	fs_info = end_io_wq->info;
 	end_io_wq->status = bio->bi_status;
 
-	if (btrfs_op(bio) == BTRFS_MAP_WRITE) {
-		if (end_io_wq->metadata == BTRFS_WQ_ENDIO_METADATA)
-			wq = fs_info->endio_meta_write_workers;
-		else if (end_io_wq->metadata == BTRFS_WQ_ENDIO_FREE_SPACE)
-			wq = fs_info->endio_freespace_worker;
-		else
-			wq = fs_info->endio_write_workers;
-	} else {
-		if (end_io_wq->metadata)
-			wq = fs_info->endio_meta_workers;
-		else
-			wq = fs_info->endio_workers;
-	}
+	if (end_io_wq->metadata)
+		wq = fs_info->endio_meta_workers;
+	else
+		wq = fs_info->endio_workers;
 
 	btrfs_init_work(&end_io_wq->work, end_workqueue_fn, NULL, NULL);
 	btrfs_queue_work(wq, &end_io_wq->work);
@@ -771,6 +762,9 @@ blk_status_t btrfs_bio_wq_end_io(struct btrfs_fs_info *info, struct bio *bio,
 {
 	struct btrfs_end_io_wq *end_io_wq;
 
+	if (WARN_ON_ONCE(btrfs_op(bio) != BTRFS_MAP_WRITE))
+		return BLK_STS_IOERR;
+
 	end_io_wq = kmem_cache_alloc(btrfs_end_io_wq_cache, GFP_NOFS);
 	if (!end_io_wq)
 		return BLK_STS_RESOURCE;
@@ -2273,6 +2267,8 @@ static void btrfs_stop_all_workers(struct btrfs_fs_info *fs_info)
 		destroy_workqueue(fs_info->endio_raid56_workers);
 	if (fs_info->rmw_workers)
 		destroy_workqueue(fs_info->rmw_workers);
+	if (fs_info->compressed_write_workers)
+		destroy_workqueue(fs_info->compressed_write_workers);
 	btrfs_destroy_workqueue(fs_info->endio_write_workers);
 	btrfs_destroy_workqueue(fs_info->endio_freespace_worker);
 	btrfs_destroy_workqueue(fs_info->delayed_workers);
@@ -2287,7 +2283,6 @@ static void btrfs_stop_all_workers(struct btrfs_fs_info *fs_info)
 	 * queues can do metadata I/O operations.
 	 */
 	btrfs_destroy_workqueue(fs_info->endio_meta_workers);
-	btrfs_destroy_workqueue(fs_info->endio_meta_write_workers);
 }
 
 static void free_root_extent_buffers(struct btrfs_root *root)
@@ -2469,15 +2464,14 @@ static int btrfs_init_workqueues(struct btrfs_fs_info *fs_info)
 	fs_info->endio_meta_workers =
 		btrfs_alloc_workqueue(fs_info, "endio-meta", flags,
 				      max_active, 4);
-	fs_info->endio_meta_write_workers =
-		btrfs_alloc_workqueue(fs_info, "endio-meta-write", flags,
-				      max_active, 2);
 	fs_info->endio_raid56_workers =
 		alloc_workqueue("btrfs-endio-raid56", flags, max_active);
 	fs_info->rmw_workers = alloc_workqueue("btrfs-rmw", flags, max_active);
 	fs_info->endio_write_workers =
 		btrfs_alloc_workqueue(fs_info, "endio-write", flags,
 				      max_active, 2);
+	fs_info->compressed_write_workers =
+		alloc_workqueue("btrfs-compressed-write", flags, max_active);
 	fs_info->endio_freespace_worker =
 		btrfs_alloc_workqueue(fs_info, "freespace-write", flags,
 				      max_active, 0);
@@ -2492,7 +2486,7 @@ static int btrfs_init_workqueues(struct btrfs_fs_info *fs_info)
 	if (!(fs_info->workers && fs_info->hipri_workers &&
 	      fs_info->delalloc_workers && fs_info->flush_workers &&
 	      fs_info->endio_workers && fs_info->endio_meta_workers &&
-	      fs_info->endio_meta_write_workers &&
+	      fs_info->compressed_write_workers &&
 	      fs_info->endio_write_workers && fs_info->endio_raid56_workers &&
 	      fs_info->endio_freespace_worker && fs_info->rmw_workers &&
 	      fs_info->caching_workers && fs_info->fixup_workers &&
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index b1fdc6a26c76e..9c683c466d585 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -1908,8 +1908,6 @@ static void btrfs_resize_thread_pool(struct btrfs_fs_info *fs_info,
 	btrfs_workqueue_set_max(fs_info->caching_workers, new_pool_size);
 	btrfs_workqueue_set_max(fs_info->endio_workers, new_pool_size);
 	btrfs_workqueue_set_max(fs_info->endio_meta_workers, new_pool_size);
-	btrfs_workqueue_set_max(fs_info->endio_meta_write_workers,
-				new_pool_size);
 	btrfs_workqueue_set_max(fs_info->endio_write_workers, new_pool_size);
 	btrfs_workqueue_set_max(fs_info->endio_freespace_worker, new_pool_size);
 	btrfs_workqueue_set_max(fs_info->delayed_workers, new_pool_size);
-- 
2.30.2

