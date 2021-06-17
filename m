Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F0B83AAAAF
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Jun 2021 07:15:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbhFQFRJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 17 Jun 2021 01:17:09 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:38160 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbhFQFRI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 17 Jun 2021 01:17:08 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id DA9501FDB1
        for <linux-btrfs@vger.kernel.org>; Thu, 17 Jun 2021 05:15:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1623906900; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XON5nCmsvI3qxikh4Rqpauc2m1jLGHVqA/XeIRkYLDo=;
        b=ZKmw1PlSvwMrj8mKljU28+DsnNRFHsl0SxzXFkrInBSQAgRNkN9pfKwlaIJLS6xYwERNY8
        oCJVEvCVM/lkUrPlsd4ZxBa0vmftcYhr/5sVRnAT0ehoz0iuS2L5WaFTeyKpvXKWKyIMir
        OoicYTI1F9JM8Vfxk9t1d7wK5wsmOEo=
Received: from adam-pc.lan (unknown [10.163.16.38])
        by relay2.suse.de (Postfix) with ESMTP id DE2E7A3BB9
        for <linux-btrfs@vger.kernel.org>; Thu, 17 Jun 2021 05:14:59 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v4 3/9] btrfs: handle errors properly inside btrfs_submit_compressed_read()
Date:   Thu, 17 Jun 2021 13:14:44 +0800
Message-Id: <20210617051450.206704-4-wqu@suse.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210617051450.206704-1-wqu@suse.com>
References: <20210617051450.206704-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

There are quite some BUG_ON()s inside btrfs_submit_compressed_read(),
namingly all errors inside the for() loop relies on BUG_ON() to handle
-ENOMEM.

Handle these errors properly by:

- Wait for submitted bios to finish first
  Using wake_var_event() APIs to wait without introducing extra memory
  overhead inside compressed_bio.
  This allows us to wait for any submitted bio to finish, while still
  keeps the compressed_bio from being freed.

- Introduce finish_compressed_bio_read() to finish the compressed_bio

- Properly end the bio and finish compressed_bio when error happens

Now in btrfs_submit_compressed_read() even when the bio submission
failed, we can properly handle the error without triggering BUG_ON().

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/compression.c | 121 ++++++++++++++++++++++++++---------------
 1 file changed, 77 insertions(+), 44 deletions(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index b84b9f7420c2..81278b04b111 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -223,9 +223,54 @@ static bool dec_and_test_compressed_bio(struct compressed_bio *cb,
 	last_io = refcount_sub_and_test(bi_size >> fs_info->sectorsize_bits,
 					&cb->pending_sectors);
 	atomic_dec(&cb->pending_bios);
+	/*
+	 * Here we must wake up the possible error handler after all other
+	 * operations on @cb finished, or we can race with
+	 * finish_compressed_bio_*() which may free @cb.
+	 */
+	wake_up_var(cb);
+
 	return last_io;
 }
 
+static void finish_compressed_bio_read(struct compressed_bio *cb,
+				       struct bio *bio)
+{
+	unsigned int index;
+	struct page *page;
+
+	/* Release the compressed pages */
+	for (index = 0; index < cb->nr_pages; index++) {
+		page = cb->compressed_pages[index];
+		page->mapping = NULL;
+		put_page(page);
+	}
+
+	/* Do io completion on the original bio */
+	if (cb->errors) {
+		bio_io_error(cb->orig_bio);
+	} else {
+		struct bio_vec *bvec;
+		struct bvec_iter_all iter_all;
+
+		ASSERT(bio);
+		ASSERT(!bio->bi_status);
+		/*
+		 * We have verified the checksum already, set page
+		 * checked so the end_io handlers know about it
+		 */
+		ASSERT(!bio_flagged(bio, BIO_CLONED));
+		bio_for_each_segment_all(bvec, cb->orig_bio, iter_all)
+			SetPageChecked(bvec->bv_page);
+
+		bio_endio(cb->orig_bio);
+	}
+
+	/* Finally free the cb struct */
+	kfree(cb->compressed_pages);
+	kfree(cb);
+}
+
 /* when we finish reading compressed pages from the disk, we
  * decompress them and then run the bio end_io routines on the
  * decompressed pages (in the inode address space).
@@ -240,8 +285,6 @@ static void end_compressed_bio_read(struct bio *bio)
 {
 	struct compressed_bio *cb = bio->bi_private;
 	struct inode *inode;
-	struct page *page;
-	unsigned int index;
 	unsigned int mirror = btrfs_io_bio(bio)->mirror_num;
 	int ret = 0;
 
@@ -276,36 +319,7 @@ static void end_compressed_bio_read(struct bio *bio)
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
@@ -791,20 +805,20 @@ blk_status_t btrfs_submit_compressed_read(struct inode *inode, struct bio *bio,
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
@@ -818,16 +832,16 @@ blk_status_t btrfs_submit_compressed_read(struct inode *inode, struct bio *bio,
 
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
 
@@ -843,6 +857,25 @@ blk_status_t btrfs_submit_compressed_read(struct inode *inode, struct bio *bio,
 out:
 	free_extent_map(em);
 	return ret;
+last_bio:
+	comp_bio->bi_status = ret;
+	/* This is the last bio, endio functions will free @cb */
+	bio_endio(comp_bio);
+	return ret;
+finish_cb:
+	if (comp_bio) {
+		comp_bio->bi_status = ret;
+		bio_endio(comp_bio);
+	}
+	wait_var_event(cb, atomic_read(&cb->pending_bios) == 0);
+	/*
+	 * Even with previous bio ended, we should still have io not yet
+	 * submitted, thus need to finish @cb manually.
+	 */
+	ASSERT(refcount_read(&cb->pending_sectors));
+	/* Now we are the only one referring @cb, can finish it safely. */
+	finish_compressed_bio_read(cb, NULL);
+	return ret;
 }
 
 /*
-- 
2.32.0

