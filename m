Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A3043A7E0A
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Jun 2021 14:18:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230334AbhFOMUx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 15 Jun 2021 08:20:53 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:33632 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230330AbhFOMUw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Jun 2021 08:20:52 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 5D2971FD81
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Jun 2021 12:18:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1623759527; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gm9o9K9yix+0Nha472yRcJrGz6kxwEHTotvYS8uosMY=;
        b=kqs+JXjldm5d2Xxe1IWqZNaCNtmpS+eoHr0K2cUdCPOG8swCfczC03SLlNRYnyi7mMsDIS
        PuV9pnSrEHsJOQMOTmg4RviPzdYTaoWz6fe3nUC2RAb7wkKZQnfIjhe9OQ42ah5hsnD2V/
        yiG06kcNZ+i+9MI0vGLvxa91kDh2MUU=
Received: from adam-pc.lan (unknown [10.163.16.38])
        by relay2.suse.de (Postfix) with ESMTP id 67350A3B8E
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Jun 2021 12:18:46 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v3 4/9] btrfs: hunt down the BUG_ON()s inside btrfs_submit_compressed_write()
Date:   Tue, 15 Jun 2021 20:18:31 +0800
Message-Id: <20210615121836.365105-5-wqu@suse.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210615121836.365105-1-wqu@suse.com>
References: <20210615121836.365105-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Just like btrfs_submit_compressed_read(), there are quite some BUG_ON()s
inside btrfs_submit_compressed_write() for the bio submission path.

Fix them using the same method:

- For last bio, just endio the bio
  As in that case, one of the endio function of all these submitted bio
  will be able to free the compressed_bio

- For half-submitted bio, wait and finish the compressed_bio manually
  In this case, as long as all other bio finishes, we're the only one
  referring the compressed bio, and can manually finish it.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/compression.c | 103 ++++++++++++++++++++++++++---------------
 1 file changed, 66 insertions(+), 37 deletions(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index abbdb8d35001..706efa2d1438 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -371,50 +371,56 @@ static noinline void end_compressed_writeback(struct inode *inode,
 	/* the inode may be gone now */
 }
 
-/*
- * do the cleanup once all the compressed pages hit the disk.
- * This will clear writeback on the file pages and free the compressed
- * pages.
- *
- * This also calls the writeback end hooks for the file pages so that
- * metadata and checksums can be updated in the file.
- */
-static void end_compressed_bio_write(struct bio *bio)
+static void finish_compressed_bio_write(struct compressed_bio *cb)
 {
-	struct compressed_bio *cb = bio->bi_private;
-	struct inode *inode;
-	struct page *page;
+	struct inode *inode = cb->inode;
 	unsigned int index;
 
-	if (!dec_and_test_compressed_bio(cb, bio))
-		goto out;
-
-	/* ok, we're the last bio for this extent, step one is to
-	 * call back into the FS and do all the end_io operations
+	/*
+	 * Ok, we're the last bio for this extent, step one is to
+	 * call back into the FS and do all the end_io operations.
 	 */
-	inode = cb->inode;
-	btrfs_record_physical_zoned(inode, cb->start, bio);
 	btrfs_writepage_endio_finish_ordered(BTRFS_I(inode), NULL,
 			cb->start, cb->start + cb->len - 1,
-			bio->bi_status == BLK_STS_OK);
+			!cb->errors);
 
 	end_compressed_writeback(inode, cb);
-	/* note, our inode could be gone now */
+	/* Note, our inode could be gone now */
 
 	/*
-	 * release the compressed pages, these came from alloc_page and
+	 * Release the compressed pages, these came from alloc_page and
 	 * are not attached to the inode at all
 	 */
-	index = 0;
 	for (index = 0; index < cb->nr_pages; index++) {
-		page = cb->compressed_pages[index];
+		struct page *page = cb->compressed_pages[index];
+
 		page->mapping = NULL;
 		put_page(page);
 	}
 
-	/* finally free the cb struct */
+	/* Finally free the cb struct */
 	kfree(cb->compressed_pages);
 	kfree(cb);
+}
+
+/*
+ * do the cleanup once all the compressed pages hit the disk.
+ * This will clear writeback on the file pages and free the compressed
+ * pages.
+ *
+ * This also calls the writeback end hooks for the file pages so that
+ * metadata and checksums can be updated in the file.
+ */
+static void end_compressed_bio_write(struct bio *bio)
+{
+	struct compressed_bio *cb = bio->bi_private;
+
+	if (!dec_and_test_compressed_bio(cb, bio))
+		goto out;
+
+	btrfs_record_physical_zoned(cb->inode, cb->start, bio);
+
+	finish_compressed_bio_write(cb);
 out:
 	bio_put(bio);
 }
@@ -517,18 +523,18 @@ blk_status_t btrfs_submit_compressed_write(struct btrfs_inode *inode, u64 start,
 			atomic_inc(&cb->pending_bios);
 			ret = btrfs_bio_wq_end_io(fs_info, bio,
 						  BTRFS_WQ_ENDIO_DATA);
-			BUG_ON(ret); /* -ENOMEM */
+			if (ret)
+				goto finish_cb;
 
 			if (!skip_sum) {
 				ret = btrfs_csum_one_bio(inode, bio, start, 1);
-				BUG_ON(ret); /* -ENOMEM */
+				if (ret)
+					goto finish_cb;
 			}
 
 			ret = btrfs_map_bio(fs_info, bio, 0);
-			if (ret) {
-				bio->bi_status = ret;
-				bio_endio(bio);
-			}
+			if (ret)
+				goto finish_cb;
 
 			bio = btrfs_bio_alloc(first_byte);
 			bio->bi_opf = bio_op | write_flags;
@@ -554,23 +560,46 @@ blk_status_t btrfs_submit_compressed_write(struct btrfs_inode *inode, u64 start,
 
 	atomic_inc(&cb->pending_bios);
 	ret = btrfs_bio_wq_end_io(fs_info, bio, BTRFS_WQ_ENDIO_DATA);
-	BUG_ON(ret); /* -ENOMEM */
+	if (ret)
+		goto last_bio;
 
 	if (!skip_sum) {
 		ret = btrfs_csum_one_bio(inode, bio, start, 1);
-		BUG_ON(ret); /* -ENOMEM */
+		if (ret)
+			goto last_bio;
 	}
 
 	ret = btrfs_map_bio(fs_info, bio, 0);
-	if (ret) {
-		bio->bi_status = ret;
-		bio_endio(bio);
-	}
+	if (ret)
+		goto last_bio;
 
 	if (blkcg_css)
 		kthread_associate_blkcg(NULL);
 
 	return 0;
+last_bio:
+	cb->errors = 1;
+	bio->bi_status = ret;
+	/* One of the bios' endio function will free @cb. */
+	bio_endio(bio);
+	return ret;
+
+finish_cb:
+	cb->errors = 1;
+	if (bio) {
+		bio->bi_status = ret;
+		bio_endio(bio);
+	}
+
+	/*
+	 * Even with previous bio ended, we should still have io not yet
+	 * submitted, thus need to finish manually.
+	 */
+	ASSERT(atomic_read(&cb->io_sectors));
+	wait_event(cb->pending_bio_wait, atomic_read(&cb->pending_bios) == 0);
+	/* Now we are the only one referring @cb, can finish it safely. */
+	finish_compressed_bio_write(cb);
+	return ret;
 }
 
 static u64 bio_end_offset(struct bio *bio)
-- 
2.32.0

