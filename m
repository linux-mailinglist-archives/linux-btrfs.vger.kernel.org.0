Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 086146B9C5D
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Mar 2023 17:59:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230155AbjCNQ7i (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 14 Mar 2023 12:59:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229951AbjCNQ7g (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 14 Mar 2023 12:59:36 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 730F88F500
        for <linux-btrfs@vger.kernel.org>; Tue, 14 Mar 2023 09:59:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=IRZWLv3n0s33lS4WUFwIdnCW+lb7UEVkTs0toqJiIiY=; b=EsQOloc+cpRNcfwEjMUxtCvGz1
        +hTeG41V+9xlugenYkDxFvhMpK3xxaDUYDdQFBqJ3H+1dqpPop1t2wAmBqoNqRxHk9t8uqlnHAhUb
        MbElcJGVuDJIhRLZuvXA+22p8+p+EDGGtUu2Qxyu5rWjXtKkJkA9RUupmDJf1UQLiFdjl/WPBJIZc
        wF0qnxEtNPOsvPIZ3V3Zs1iPhiBHBOsPQ4CqgfDjA3+qKeWCLEPHgSB0f9yNj97u60ZgJZI0K36fU
        y4NlOtCKQqSVxyvogjRYR6v4YFzJFREYQNnizGw36Pl/oc76vNNWqVpxYmFXwhscgjyuHeaJ1oHzw
        UnL7xksA==;
Received: from [2001:4bb8:182:2e36:91ea:d0e2:233a:8356] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pc7zo-00Avnj-0O;
        Tue, 14 Mar 2023 16:59:32 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Johannes Thumshirn <jth@kernel.org>, linux-btrfs@vger.kernel.org
Subject: [PATCH 04/10] btrfs: remove the compressed_write_workers workqueue
Date:   Tue, 14 Mar 2023 17:59:04 +0100
Message-Id: <20230314165910.373347-5-hch@lst.de>
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

Now that all writes completions happen in workqueues, there is no need
for an extra offload for compressed write completions.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/compression.c | 34 ++++++++++------------------------
 fs/btrfs/compression.h |  7 ++-----
 fs/btrfs/disk-io.c     |  5 -----
 fs/btrfs/fs.h          |  1 -
 4 files changed, 12 insertions(+), 35 deletions(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index c5839d04690d67..1641336a39d215 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -220,27 +220,6 @@ static noinline void end_compressed_writeback(const struct compressed_bio *cb)
 	/* the inode may be gone now */
 }
 
-static void btrfs_finish_compressed_write_work(struct work_struct *work)
-{
-	struct compressed_bio *cb =
-		container_of(work, struct compressed_bio, write_end_work);
-
-	/*
-	 * Ok, we're the last bio for this extent, step one is to call back
-	 * into the FS and do all the end_io operations.
-	 */
-	btrfs_writepage_endio_finish_ordered(cb->bbio.inode, NULL,
-			cb->start, cb->start + cb->len - 1,
-			cb->bbio.bio.bi_status == BLK_STS_OK);
-
-	if (cb->writeback)
-		end_compressed_writeback(cb);
-	/* Note, our inode could be gone now */
-
-	btrfs_free_compressed_pages(cb);
-	bio_put(&cb->bbio.bio);
-}
-
 /*
  * Do the cleanup once all the compressed pages hit the disk.  This will clear
  * writeback on the file pages and free the compressed pages.
@@ -251,9 +230,17 @@ static void btrfs_finish_compressed_write_work(struct work_struct *work)
 static void end_compressed_bio_write(struct btrfs_bio *bbio)
 {
 	struct compressed_bio *cb = to_compressed_bio(bbio);
-	struct btrfs_fs_info *fs_info = bbio->inode->root->fs_info;
 
-	queue_work(fs_info->compressed_write_workers, &cb->write_end_work);
+	btrfs_writepage_endio_finish_ordered(cb->bbio.inode, NULL,
+			cb->start, cb->start + cb->len - 1,
+			cb->bbio.bio.bi_status == BLK_STS_OK);
+
+	if (cb->writeback)
+		end_compressed_writeback(cb);
+	/* Note, our inode could be gone now */
+
+	btrfs_free_compressed_pages(cb);
+	bio_put(&bbio->bio);
 }
 
 static void btrfs_add_compressed_bio_pages(struct compressed_bio *cb,
@@ -329,7 +316,6 @@ void btrfs_submit_compressed_write(struct btrfs_inode *inode, u64 start,
 	cb->compressed_pages = compressed_pages;
 	cb->compressed_len = compressed_len;
 	cb->writeback = writeback;
-	INIT_WORK(&cb->write_end_work, btrfs_finish_compressed_write_work);
 	cb->nr_pages = nr_pages;
 
 	btrfs_add_compressed_bio_pages(cb, disk_start);
diff --git a/fs/btrfs/compression.h b/fs/btrfs/compression.h
index 5d5146e72a860b..65aaedba35a2ad 100644
--- a/fs/btrfs/compression.h
+++ b/fs/btrfs/compression.h
@@ -53,11 +53,8 @@ struct compressed_bio {
 	/* Whether this is a write for writeback. */
 	bool writeback;
 
-	union {
-		/* For reads, this is the bio we are copying the data into */
-		struct btrfs_bio *orig_bbio;
-		struct work_struct write_end_work;
-	};
+	/* For reads, this is the bio we are copying the data into */
+	struct btrfs_bio *orig_bbio;
 
 	/* Must be last. */
 	struct btrfs_bio bbio;
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 5b63a5161cedea..494081dda5fc66 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -1991,8 +1991,6 @@ static void btrfs_stop_all_workers(struct btrfs_fs_info *fs_info)
 		destroy_workqueue(fs_info->endio_workers);
 	if (fs_info->rmw_workers)
 		destroy_workqueue(fs_info->rmw_workers);
-	if (fs_info->compressed_write_workers)
-		destroy_workqueue(fs_info->compressed_write_workers);
 	if (fs_info->endio_write_workers)
 		destroy_workqueue(fs_info->endio_write_workers);
 	if (fs_info->endio_freespace_worker)
@@ -2211,8 +2209,6 @@ static int btrfs_init_workqueues(struct btrfs_fs_info *fs_info)
 	fs_info->rmw_workers = alloc_workqueue("btrfs-rmw", flags, max_active);
 	fs_info->endio_write_workers =
 		alloc_workqueue("btrfs-endio-write", flags, max_active);
-	fs_info->compressed_write_workers =
-		alloc_workqueue("btrfs-compressed-write", flags, max_active);
 	fs_info->endio_freespace_worker =
 		alloc_workqueue("btrfs-freespace-write", flags, max_active);
 	fs_info->delayed_workers =
@@ -2226,7 +2222,6 @@ static int btrfs_init_workqueues(struct btrfs_fs_info *fs_info)
 	if (!(fs_info->workers && fs_info->hipri_workers &&
 	      fs_info->delalloc_workers && fs_info->flush_workers &&
 	      fs_info->endio_workers && fs_info->endio_meta_workers &&
-	      fs_info->compressed_write_workers &&
 	      fs_info->endio_write_workers &&
 	      fs_info->endio_write_meta_workers &&
 	      fs_info->endio_freespace_worker && fs_info->rmw_workers &&
diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
index e2643bc5c039ad..d926a337d2be20 100644
--- a/fs/btrfs/fs.h
+++ b/fs/btrfs/fs.h
@@ -541,7 +541,6 @@ struct btrfs_fs_info {
 	struct workqueue_struct *endio_workers;
 	struct workqueue_struct *endio_meta_workers;
 	struct workqueue_struct *rmw_workers;
-	struct workqueue_struct *compressed_write_workers;
 	struct workqueue_struct *endio_write_workers;
 	struct workqueue_struct *endio_write_meta_workers;
 	struct workqueue_struct *endio_freespace_worker;
-- 
2.39.2

