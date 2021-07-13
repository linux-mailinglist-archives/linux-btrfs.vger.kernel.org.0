Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FAE23C6A4C
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Jul 2021 08:15:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233784AbhGMGSZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 13 Jul 2021 02:18:25 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:59712 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233422AbhGMGSU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 13 Jul 2021 02:18:20 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 19B7820057
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Jul 2021 06:15:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1626156930; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iaXYRAR1w5DjptvvhXmLozsfMz82uyi2yC4BJw4hT/0=;
        b=L+FkznbVIX19wllZk+GR3tV/BYwwno/78W7cNABZGNCYZKv+ln3lmBFLjGmj299j57ykS8
        vIPxapveAy2f1fDM0XKaArnE2wCxf6Z+Qo2wB3pSHOSnRfdL1l++JMwlIh3h/ltc3QHec9
        6u5N7VufqSdn+gwETRLH/NdQWAbZbf8=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 54D47139AC
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Jul 2021 06:15:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id YDM5BoEv7WB0XgAAGKfGzw
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Jul 2021 06:15:29 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 08/27] btrfs: handle errors properly inside btrfs_submit_compressed_read()
Date:   Tue, 13 Jul 2021 14:14:57 +0800
Message-Id: <20210713061516.163318-9-wqu@suse.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210713061516.163318-1-wqu@suse.com>
References: <20210713061516.163318-1-wqu@suse.com>
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
 fs/btrfs/compression.c | 133 +++++++++++++++++++++++++----------------
 1 file changed, 83 insertions(+), 50 deletions(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index be81e34fbd56..51f83684dbb0 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -223,9 +223,60 @@ static bool dec_and_test_compressed_bio(struct compressed_bio *cb,
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
+		bio_for_each_segment_all(bvec, cb->orig_bio, iter_all) {
+			u64 bvec_start = page_offset(bvec->bv_page) +
+					 bvec->bv_offset;
+
+			btrfs_page_set_checked(btrfs_sb(cb->inode->i_sb),
+					bvec->bv_page, bvec_start,
+					bvec->bv_len);
+		}
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
@@ -240,8 +291,6 @@ static void end_compressed_bio_read(struct bio *bio)
 {
 	struct compressed_bio *cb = bio->bi_private;
 	struct inode *inode;
-	struct page *page;
-	unsigned int index;
 	unsigned int mirror = btrfs_io_bio(bio)->mirror_num;
 	int ret = 0;
 
@@ -276,42 +325,7 @@ static void end_compressed_bio_read(struct bio *bio)
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
-		bio_for_each_segment_all(bvec, cb->orig_bio, iter_all) {
-			u64 bvec_start = page_offset(bvec->bv_page) +
-					 bvec->bv_offset;
-
-			btrfs_page_set_checked(btrfs_sb(cb->inode->i_sb),
-					bvec->bv_page, bvec_start,
-					bvec->bv_len);
-		}
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
@@ -834,20 +848,20 @@ blk_status_t btrfs_submit_compressed_read(struct inode *inode, struct bio *bio,
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
@@ -861,16 +875,16 @@ blk_status_t btrfs_submit_compressed_read(struct inode *inode, struct bio *bio,
 
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
 
@@ -886,6 +900,25 @@ blk_status_t btrfs_submit_compressed_read(struct inode *inode, struct bio *bio,
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

