Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 222023FA947
	for <lists+linux-btrfs@lfdr.de>; Sun, 29 Aug 2021 07:25:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234701AbhH2F0G (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 29 Aug 2021 01:26:06 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:45782 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234689AbhH2F0F (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 29 Aug 2021 01:26:05 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id C66AF20017
        for <linux-btrfs@vger.kernel.org>; Sun, 29 Aug 2021 05:25:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1630214712; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=f47k+XJMMarp5qbcN7fJZw5wlCEvjLZiAXuVW250Vrk=;
        b=sj3HwCSAdue6V/G52deMxxGY/fASZ2UFj+unvIwDwePBK4nS8jJZk5LZcycb7nmOz2G30s
        N08WC/9UZVWCg28Pot6oMZUKdPoer2dbUe8IiGILgIwV7leMi17qcxQZeHvoADWy8kDKwe
        Coxp/ZDTOABXK32oEyMmhiHLQUBcerU=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 1159E13964
        for <linux-btrfs@vger.kernel.org>; Sun, 29 Aug 2021 05:25:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id YGZnMTcaK2HnPAAAGKfGzw
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Sun, 29 Aug 2021 05:25:11 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 09/26] btrfs: handle errors properly inside btrfs_submit_compressed_write()
Date:   Sun, 29 Aug 2021 13:24:41 +0800
Message-Id: <20210829052458.15454-10-wqu@suse.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210829052458.15454-1-wqu@suse.com>
References: <20210829052458.15454-1-wqu@suse.com>
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
 fs/btrfs/compression.c | 99 +++++++++++++++++++++++++++---------------
 1 file changed, 63 insertions(+), 36 deletions(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index d4b46d46b249..ece4d9ab3c65 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -368,50 +368,56 @@ static noinline void end_compressed_writeback(struct inode *inode,
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
 			!cb->errors);
 
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
@@ -514,18 +520,18 @@ blk_status_t btrfs_submit_compressed_write(struct btrfs_inode *inode, u64 start,
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
@@ -551,23 +557,44 @@ blk_status_t btrfs_submit_compressed_write(struct btrfs_inode *inode, u64 start,
 
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
+	bio->bi_status = ret;
+	/* One of the bios' endio function will free @cb. */
+	bio_endio(bio);
+	return ret;
+
+finish_cb:
+	if (bio) {
+		bio->bi_status = ret;
+		bio_endio(bio);
+	}
+
+	wait_var_event(cb, atomic_read(&cb->pending_bios) == 0);
+	/*
+	 * Even with previous bio ended, we should still have io not yet
+	 * submitted, thus need to finish manually.
+	 */
+	ASSERT(refcount_read(&cb->pending_sectors));
+	/* Now we are the only one referring @cb, can finish it safely. */
+	finish_compressed_bio_write(cb);
+	return ret;
 }
 
 static u64 bio_end_offset(struct bio *bio)
-- 
2.32.0

