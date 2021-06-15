Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3B5F3A7E09
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Jun 2021 14:18:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230321AbhFOMUv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 15 Jun 2021 08:20:51 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:33606 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230288AbhFOMUu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Jun 2021 08:20:50 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id A20FB1FD7C
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Jun 2021 12:18:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1623759525; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pXMZgLbyNTMjNxOGmqr69Kkt9N8GcLEly5TMiv320Ew=;
        b=Ei1wMoRcn/d+xO8Dtd0xe3bZv5CW6dN7peqzCH1Gm/hh+ZODWdeieM+KJROpbzYnRqYASP
        sequlDlnB9dADZmHYGlp4L9eJff54RGejvhNw+EmNKzxYYQJmk4p4EmskOJDMo/V06aOI3
        sd3Nn/fZbnzprNaZn21aF+5d0UzORNo=
Received: from adam-pc.lan (unknown [10.163.16.38])
        by relay2.suse.de (Postfix) with ESMTP id AE4A8A3B89
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Jun 2021 12:18:44 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v3 3/9] btrfs: hunt down the BUG_ON()s inside btrfs_submit_compressed_read()
Date:   Tue, 15 Jun 2021 20:18:30 +0800
Message-Id: <20210615121836.365105-4-wqu@suse.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210615121836.365105-1-wqu@suse.com>
References: <20210615121836.365105-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

There are quite some BUG_ON()s inside btrfs_submit_compressed_read(),
namingly all errors inside the for() loop relies on BUG_ON() to handle
-ENOMEM.

Hunt down these BUG_ON()s properly by:

- Introduce compressed_bio::pending_bios_wait
  This allows us to wait for any submitted bio to finish, while still
  keeps the compressed_bio from being freed, as we should have
  compressed_bio::io_sectors not zero.

- Introduce finish_compressed_bio_read() to finish the compressed_bio

- Properly end the bio and finish compressed_bio when error happens

Now in btrfs_submit_compressed_read() even when the bio submission
failed, we can properly handle the error without triggering BUG_ON().

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/compression.c | 127 ++++++++++++++++++++++++++---------------
 fs/btrfs/compression.h |   3 +
 2 files changed, 85 insertions(+), 45 deletions(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index bbfee9ffd20a..abbdb8d35001 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -220,7 +220,6 @@ static bool dec_and_test_compressed_bio(struct compressed_bio *cb,
 		cb->errors = 1;
 
 	ASSERT(bi_size && bi_size <= cb->compressed_len);
-	atomic_dec(&cb->pending_bios);
 
 	/*
 	 * Here we only need to check io_sectors, as if that is 0, we definily
@@ -232,9 +231,55 @@ static bool dec_and_test_compressed_bio(struct compressed_bio *cb,
 	ASSERT(atomic_read(&cb->io_sectors) <
 	       (cb->compressed_len >> fs_info->sectorsize_bits));
 
+	/*
+	 * Here we must wake up pending_bio_wait after all other operations on
+	 * @cb finished, or we can race with finish_compressed_bio_*() in
+	 * error path.
+	 */
+	atomic_dec(&cb->pending_bios);
+	wake_up(&cb->pending_bio_wait);
+
 	return last_io;
 }
 
+static void finish_compressed_bio_read(struct compressed_bio *cb,
+				       struct bio *bio)
+{
+	unsigned int index;
+	struct page *page;
+
+	/* release the compressed pages */
+	for (index = 0; index < cb->nr_pages; index++) {
+		page = cb->compressed_pages[index];
+		page->mapping = NULL;
+		put_page(page);
+	}
+
+	/* do io completion on the original bio */
+	if (cb->errors) {
+		bio_io_error(cb->orig_bio);
+	} else {
+		struct bio_vec *bvec;
+		struct bvec_iter_all iter_all;
+
+		ASSERT(bio);
+		ASSERT(!bio->bi_status);
+		/*
+		 * we have verified the checksum already, set page
+		 * checked so the end_io handlers know about it
+		 */
+		ASSERT(!bio_flagged(bio, BIO_CLONED));
+		bio_for_each_segment_all(bvec, cb->orig_bio, iter_all)
+			SetPageChecked(bvec->bv_page);
+
+		bio_endio(cb->orig_bio);
+	}
+
+	/* finally free the cb struct */
+	kfree(cb->compressed_pages);
+	kfree(cb);
+}
+
 /* when we finish reading compressed pages from the disk, we
  * decompress them and then run the bio end_io routines on the
  * decompressed pages (in the inode address space).
@@ -249,8 +294,6 @@ static void end_compressed_bio_read(struct bio *bio)
 {
 	struct compressed_bio *cb = bio->bi_private;
 	struct inode *inode;
-	struct page *page;
-	unsigned int index;
 	unsigned int mirror = btrfs_io_bio(bio)->mirror_num;
 	int ret = 0;
 
@@ -285,36 +328,7 @@ static void end_compressed_bio_read(struct bio *bio)
 csum_failed:
 	if (ret)
 		cb->errors = 1;
-
-	/* release the compressed pages */
-	index = 0;
-	for (index = 0; index < cb->nr_pages; index++) {
-		page = cb->compressed_pages[index];
-		page->mapping = NULL;
-		put_page(page);
-	}
-
-	/* do io completion on the original bio */
-	if (cb->errors) {
-		bio_io_error(cb->orig_bio);
-	} else {
-		struct bio_vec *bvec;
-		struct bvec_iter_all iter_all;
-
-		/*
-		 * we have verified the checksum already, set page
-		 * checked so the end_io handlers know about it
-		 */
-		ASSERT(!bio_flagged(bio, BIO_CLONED));
-		bio_for_each_segment_all(bvec, cb->orig_bio, iter_all)
-			SetPageChecked(bvec->bv_page);
-
-		bio_endio(cb->orig_bio);
-	}
-
-	/* finally free the cb struct */
-	kfree(cb->compressed_pages);
-	kfree(cb);
+	finish_compressed_bio_read(cb, bio);
 out:
 	bio_put(bio);
 }
@@ -440,6 +454,7 @@ blk_status_t btrfs_submit_compressed_write(struct btrfs_inode *inode, u64 start,
 		return BLK_STS_RESOURCE;
 	atomic_set(&cb->pending_bios, 0);
 	atomic_set(&cb->io_sectors, compressed_len >> fs_info->sectorsize_bits);
+	init_waitqueue_head(&cb->pending_bio_wait);
 	cb->errors = 0;
 	cb->inode = &inode->vfs_inode;
 	cb->start = start;
@@ -723,6 +738,7 @@ blk_status_t btrfs_submit_compressed_read(struct inode *inode, struct bio *bio,
 
 	atomic_set(&cb->pending_bios, 0);
 	atomic_set(&cb->io_sectors, compressed_len >> fs_info->sectorsize_bits);
+	init_waitqueue_head(&cb->pending_bio_wait);
 	cb->errors = 0;
 	cb->inode = inode;
 	cb->mirror_num = mirror_num;
@@ -798,20 +814,20 @@ blk_status_t btrfs_submit_compressed_read(struct inode *inode, struct bio *bio,
 			atomic_inc(&cb->pending_bios);
 			ret = btrfs_bio_wq_end_io(fs_info, comp_bio,
 						  BTRFS_WQ_ENDIO_DATA);
-			BUG_ON(ret); /* -ENOMEM */
+			if (ret)
+				goto finish_cb;
 
 			ret = btrfs_lookup_bio_sums(inode, comp_bio, sums);
-			BUG_ON(ret); /* -ENOMEM */
+			if (ret)
+				goto finish_cb;
 
 			nr_sectors = DIV_ROUND_UP(comp_bio->bi_iter.bi_size,
 						  fs_info->sectorsize);
 			sums += fs_info->csum_size * nr_sectors;
 
 			ret = btrfs_map_bio(fs_info, comp_bio, mirror_num);
-			if (ret) {
-				comp_bio->bi_status = ret;
-				bio_endio(comp_bio);
-			}
+			if (ret)
+				goto finish_cb;
 
 			comp_bio = btrfs_bio_alloc(cur_disk_byte);
 			comp_bio->bi_opf = REQ_OP_READ;
@@ -825,16 +841,16 @@ blk_status_t btrfs_submit_compressed_read(struct inode *inode, struct bio *bio,
 
 	atomic_inc(&cb->pending_bios);
 	ret = btrfs_bio_wq_end_io(fs_info, comp_bio, BTRFS_WQ_ENDIO_DATA);
-	BUG_ON(ret); /* -ENOMEM */
+	if (ret)
+		goto last_bio;
 
 	ret = btrfs_lookup_bio_sums(inode, comp_bio, sums);
-	BUG_ON(ret); /* -ENOMEM */
+	if (ret)
+		goto last_bio;
 
 	ret = btrfs_map_bio(fs_info, comp_bio, mirror_num);
-	if (ret) {
-		comp_bio->bi_status = ret;
-		bio_endio(comp_bio);
-	}
+	if (ret)
+		goto last_bio;
 
 	return 0;
 
@@ -850,6 +866,27 @@ blk_status_t btrfs_submit_compressed_read(struct inode *inode, struct bio *bio,
 out:
 	free_extent_map(em);
 	return ret;
+last_bio:
+	cb->errors = 1;
+	comp_bio->bi_status = ret;
+	/* This is the last bio, endio functions will free @cb */
+	bio_endio(comp_bio);
+	return ret;
+finish_cb:
+	cb->errors = 1;
+	if (comp_bio) {
+		comp_bio->bi_status = ret;
+		bio_endio(comp_bio);
+	}
+	/*
+	 * Even with previous bio ended, we should still have io not yet
+	 * submitted, thus need to finish @cb manually.
+	 */
+	ASSERT(atomic_read(&cb->io_sectors));
+	wait_event(cb->pending_bio_wait, atomic_read(&cb->pending_bios) == 0);
+	/* Now we are the only one referring @cb, can finish it safely. */
+	finish_compressed_bio_read(cb, NULL);
+	return ret;
 }
 
 /*
diff --git a/fs/btrfs/compression.h b/fs/btrfs/compression.h
index 41dd0bf6d5db..6f6c14f83c74 100644
--- a/fs/btrfs/compression.h
+++ b/fs/btrfs/compression.h
@@ -39,6 +39,9 @@ struct compressed_bio {
 	 */
 	atomic_t io_sectors;
 
+	/* To wait for any submitted bio, used in error handling */
+	wait_queue_head_t pending_bio_wait;
+
 	/* Number of compressed pages in the array */
 	unsigned int nr_pages;
 
-- 
2.32.0

