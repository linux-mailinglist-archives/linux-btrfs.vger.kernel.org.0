Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29BA3418FD4
	for <lists+linux-btrfs@lfdr.de>; Mon, 27 Sep 2021 09:22:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233249AbhI0HYS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 27 Sep 2021 03:24:18 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:56830 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233233AbhI0HYL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 27 Sep 2021 03:24:11 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 2A0D9200A3
        for <linux-btrfs@vger.kernel.org>; Mon, 27 Sep 2021 07:22:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1632727353; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0DLVdQGDBxYXRRiPRPikkDwWyLF8p9/OBCVDsPmlOi8=;
        b=TxDDsiZ/1Uowrm5cPGZSRD69TsBlw2tUxDkUss/xwII+VmNSehD3zHOGJRzrMYPd/imZ4P
        bTOkN8i5mIUiDO9znprZVbgThDTtWjDm2W4vjCAX0RC4OjskkmepMSdbyGWm0WAQd8lgY5
        qDCgu1LRMqGsdVJMAQ9nhYnvkeBM71Q=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7FDD113A1E
        for <linux-btrfs@vger.kernel.org>; Mon, 27 Sep 2021 07:22:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id kOgKEzhxUWEVLAAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Mon, 27 Sep 2021 07:22:32 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v3 06/26] btrfs: introduce compressed_bio::pending_sectors to trace compressed bio more elegantly
Date:   Mon, 27 Sep 2021 15:21:48 +0800
Message-Id: <20210927072208.21634-7-wqu@suse.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210927072208.21634-1-wqu@suse.com>
References: <20210927072208.21634-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

For btrfs_submit_compressed_read() and btrfs_submit_compressed_write(),
we have a pretty weird dance around compressed_bio::pending_bios:

  btrfs_submit_compressed_read/write()
  {
	cb = kmalloc()
	refcount_set(&cb->pending_bios, 0);
	bio = btrfs_alloc_bio();

	/* NOTE here, we haven't yet submitted any bio */
	refcount_set(&cb->pending_bios, 1);

	for (pg_index = 0; pg_index < cb->nr_pages; pg_index++) {
		if (submit) {
			/* Here we submit bio, but we always have one
			 * extra pending_bios */
			refcount_inc(&cb->pending_bios);
			ret = btrfs_map_bio();
		}
	}

	/* Submit the last bio */
	ret = btrfs_map_bio();
  }

There are two reasons why we do this:

- compressed_bio::pending_bios is a refcount
  Thus if it's reduced to 0, it can not be increased again.

- To ensure the compressed_bio is not freed by some submitted bios
  If the submitted bio is finished before the next bio submitted,
  we can free the compressed_bio completely.

But the above code is sometimes confusing, and we can do it better by
just introduce a new member, compressed_bio::pending_sectors.

Now we use compressed_bio::pending_sectors to indicate whether we have any
pending sectors under IO or not yet submitted.

If pending_sectors == 0, we're definitely the last bio of compressed_bio,
and is OK to release the compressed bio.

Now the workflow looks like this:

  btrfs_submit_compressed_read/write()
  {
	cb = kmalloc()
	atomic_set(&cb->pending_bios, 0);
	refcount_set(&cb->pending_sectors,
		     compressed_len >> sectorsize_bits);
	bio = btrfs_alloc_bio();

	for (pg_index = 0; pg_index < cb->nr_pages; pg_index++) {
		if (submit) {
			refcount_inc(&cb->pending_bios);
			ret = btrfs_map_bio();
		}
	}

	/* Submit the last bio */
	refcount_inc(&cb->pending_bios);
	ret = btrfs_map_bio();
  }

For now we still need pending_bios for later error handling, but will
remove pending_bios eventually after properly handling the errors.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/compression.c | 78 ++++++++++++++++++++++++------------------
 fs/btrfs/compression.h |  5 ++-
 2 files changed, 49 insertions(+), 34 deletions(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index 7a5d56eaceb7..a8f23f5f77c9 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -192,6 +192,39 @@ static int check_compressed_csum(struct btrfs_inode *inode, struct bio *bio,
 	return 0;
 }
 
+/*
+ * Reduce bio and io accounting for a compressed_bio with its coresponding bio.
+ *
+ * Return true if there is no pending bio nor io.
+ * Return false otherwise.
+ */
+static bool dec_and_test_compressed_bio(struct compressed_bio *cb,
+					struct bio *bio)
+{
+	struct btrfs_fs_info *fs_info = btrfs_sb(cb->inode->i_sb);
+	unsigned int bi_size = 0;
+	bool last_io = false;
+	struct bio_vec *bvec;
+	struct bvec_iter_all iter_all;
+
+	/*
+	 * At endio time, bi_iter.bi_size doesn't represent the real bio size.
+	 * Thus here we have to iterate through all segments to grab correct
+	 * bio size.
+	 */
+	bio_for_each_segment_all(bvec, bio, iter_all)
+		bi_size += bvec->bv_len;
+
+	if (bio->bi_status)
+		cb->errors = 1;
+
+	ASSERT(bi_size && bi_size <= cb->compressed_len);
+	last_io = refcount_sub_and_test(bi_size >> fs_info->sectorsize_bits,
+					&cb->pending_sectors);
+	atomic_dec(&cb->pending_bios);
+	return last_io;
+}
+
 /* when we finish reading compressed pages from the disk, we
  * decompress them and then run the bio end_io routines on the
  * decompressed pages (in the inode address space).
@@ -211,13 +244,7 @@ static void end_compressed_bio_read(struct bio *bio)
 	unsigned int mirror = btrfs_bio(bio)->mirror_num;
 	int ret = 0;
 
-	if (bio->bi_status)
-		cb->errors = 1;
-
-	/* if there are more bios still pending for this compressed
-	 * extent, just exit
-	 */
-	if (!refcount_dec_and_test(&cb->pending_bios))
+	if (!dec_and_test_compressed_bio(cb, bio))
 		goto out;
 
 	/*
@@ -335,13 +362,7 @@ static void end_compressed_bio_write(struct bio *bio)
 	struct page *page;
 	unsigned int index;
 
-	if (bio->bi_status)
-		cb->errors = 1;
-
-	/* if there are more bios still pending for this compressed
-	 * extent, just exit
-	 */
-	if (!refcount_dec_and_test(&cb->pending_bios))
+	if (!dec_and_test_compressed_bio(cb, bio))
 		goto out;
 
 	/* ok, we're the last bio for this extent, step one is to
@@ -407,7 +428,9 @@ blk_status_t btrfs_submit_compressed_write(struct btrfs_inode *inode, u64 start,
 	cb = kmalloc(compressed_bio_size(fs_info, compressed_len), GFP_NOFS);
 	if (!cb)
 		return BLK_STS_RESOURCE;
-	refcount_set(&cb->pending_bios, 0);
+	atomic_set(&cb->pending_bios, 0);
+	refcount_set(&cb->pending_sectors,
+		     compressed_len >> fs_info->sectorsize_bits);
 	cb->errors = 0;
 	cb->inode = &inode->vfs_inode;
 	cb->start = start;
@@ -441,7 +464,6 @@ blk_status_t btrfs_submit_compressed_write(struct btrfs_inode *inode, u64 start,
 		bio->bi_opf |= REQ_CGROUP_PUNT;
 		kthread_associate_blkcg(blkcg_css);
 	}
-	refcount_set(&cb->pending_bios, 1);
 
 	/* create and submit bios for the compressed pages */
 	bytes_left = compressed_len;
@@ -469,13 +491,7 @@ blk_status_t btrfs_submit_compressed_write(struct btrfs_inode *inode, u64 start,
 
 		page->mapping = NULL;
 		if (submit || len < PAGE_SIZE) {
-			/*
-			 * inc the count before we submit the bio so
-			 * we know the end IO handler won't happen before
-			 * we inc the count.  Otherwise, the cb might get
-			 * freed before we're done setting it up
-			 */
-			refcount_inc(&cb->pending_bios);
+			atomic_inc(&cb->pending_bios);
 			ret = btrfs_bio_wq_end_io(fs_info, bio,
 						  BTRFS_WQ_ENDIO_DATA);
 			BUG_ON(ret); /* -ENOMEM */
@@ -514,6 +530,7 @@ blk_status_t btrfs_submit_compressed_write(struct btrfs_inode *inode, u64 start,
 		cond_resched();
 	}
 
+	atomic_inc(&cb->pending_bios);
 	ret = btrfs_bio_wq_end_io(fs_info, bio, BTRFS_WQ_ENDIO_DATA);
 	BUG_ON(ret); /* -ENOMEM */
 
@@ -735,7 +752,9 @@ blk_status_t btrfs_submit_compressed_read(struct inode *inode, struct bio *bio,
 	if (!cb)
 		goto out;
 
-	refcount_set(&cb->pending_bios, 0);
+	atomic_set(&cb->pending_bios, 0);
+	refcount_set(&cb->pending_sectors,
+		     compressed_len >> fs_info->sectorsize_bits);
 	cb->errors = 0;
 	cb->inode = inode;
 	cb->mirror_num = mirror_num;
@@ -780,7 +799,6 @@ blk_status_t btrfs_submit_compressed_read(struct inode *inode, struct bio *bio,
 	comp_bio->bi_opf = REQ_OP_READ;
 	comp_bio->bi_private = cb;
 	comp_bio->bi_end_io = end_compressed_bio_read;
-	refcount_set(&cb->pending_bios, 1);
 
 	for (pg_index = 0; pg_index < nr_pages; pg_index++) {
 		u32 pg_len = PAGE_SIZE;
@@ -809,18 +827,11 @@ blk_status_t btrfs_submit_compressed_read(struct inode *inode, struct bio *bio,
 		if (submit || bio_add_page(comp_bio, page, pg_len, 0) < pg_len) {
 			unsigned int nr_sectors;
 
+			atomic_inc(&cb->pending_bios);
 			ret = btrfs_bio_wq_end_io(fs_info, comp_bio,
 						  BTRFS_WQ_ENDIO_DATA);
 			BUG_ON(ret); /* -ENOMEM */
 
-			/*
-			 * inc the count before we submit the bio so
-			 * we know the end IO handler won't happen before
-			 * we inc the count.  Otherwise, the cb might get
-			 * freed before we're done setting it up
-			 */
-			refcount_inc(&cb->pending_bios);
-
 			ret = btrfs_lookup_bio_sums(inode, comp_bio, sums);
 			BUG_ON(ret); /* -ENOMEM */
 
@@ -845,6 +856,7 @@ blk_status_t btrfs_submit_compressed_read(struct inode *inode, struct bio *bio,
 		cur_disk_byte += pg_len;
 	}
 
+	atomic_inc(&cb->pending_bios);
 	ret = btrfs_bio_wq_end_io(fs_info, comp_bio, BTRFS_WQ_ENDIO_DATA);
 	BUG_ON(ret); /* -ENOMEM */
 
diff --git a/fs/btrfs/compression.h b/fs/btrfs/compression.h
index 399be0b435bf..61955581e34f 100644
--- a/fs/btrfs/compression.h
+++ b/fs/btrfs/compression.h
@@ -29,7 +29,10 @@ struct btrfs_inode;
 
 struct compressed_bio {
 	/* number of bios pending for this compressed extent */
-	refcount_t pending_bios;
+	atomic_t pending_bios;
+
+	/* Number of sectors with unfinished IO (unsubmitted or unfinished) */
+	refcount_t pending_sectors;
 
 	/* Number of compressed pages in the array */
 	unsigned int nr_pages;
-- 
2.33.0

