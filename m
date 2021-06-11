Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC2DC3A4297
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Jun 2021 15:00:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231603AbhFKNCn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 11 Jun 2021 09:02:43 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:35840 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231161AbhFKNCm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 11 Jun 2021 09:02:42 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 6736521A5E
        for <linux-btrfs@vger.kernel.org>; Fri, 11 Jun 2021 13:00:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1623416444; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ecqP34H0mW5xRR5/LZdW8J8X61aINub2hgO7LOxHqk4=;
        b=SYQkDCFDhk5MHm+gjEQBXD5oypPozAaZV4oN6WQxEPQdNvdhCzQnMToUKhRkVpAJ4OImsi
        rslFZxqJV3AYg4EJlm2x2ZPDB1srN/QZempuG4ZxJqot3m8L4+5j09w+7x7esEfwMY9UKu
        RYip5p+SECDCbU+Kxk6p3c1WAJPy7WM=
Received: from adam-pc.lan (unknown [10.163.16.38])
        by relay2.suse.de (Postfix) with ESMTP id EF6F6A3BB1
        for <linux-btrfs@vger.kernel.org>; Fri, 11 Jun 2021 13:00:42 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 2/9] btrfs: introduce compressed_bio::io_sectors to trace compressed bio more elegantly
Date:   Fri, 11 Jun 2021 21:00:26 +0800
Message-Id: <20210611130033.329908-3-wqu@suse.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210611130033.329908-1-wqu@suse.com>
References: <20210611130033.329908-1-wqu@suse.com>
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
just introduce a new member, compressed_bio::io_sectors.

With that member, we can easily distinguish if we're really the last
bio at endio time, and even allows us to remove some BUG_ON() later,
as we now know how many bytes are not yet submitted.

With this new member, now compressed_bio::pending_bios really indicates
the pending bios, without any special handling needed.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/compression.c | 71 ++++++++++++++++++++++--------------------
 fs/btrfs/compression.h | 10 +++++-
 2 files changed, 47 insertions(+), 34 deletions(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index 9a023ae0f98b..4f11b6c79f02 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -193,6 +193,34 @@ static int check_compressed_csum(struct btrfs_inode *inode, struct bio *bio,
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
+	unsigned int bi_size = bio->bi_iter.bi_size;
+	bool last_bio = false;
+	bool last_io = false;
+
+	if (bio->bi_status)
+		cb->errors = 1;
+
+	last_bio = atomic_dec_and_test(&cb->pending_bios);
+	last_io = atomic_sub_and_test(bi_size >> fs_info->sectorsize_bits,
+				       &cb->io_sectors);
+
+	/*
+	 * We can only finish the compressed bio if no pending bio and all io
+	 * submitted.
+	 */
+	return last_bio && last_io;
+}
+
 /* when we finish reading compressed pages from the disk, we
  * decompress them and then run the bio end_io routines on the
  * decompressed pages (in the inode address space).
@@ -212,13 +240,7 @@ static void end_compressed_bio_read(struct bio *bio)
 	unsigned int mirror = btrfs_io_bio(bio)->mirror_num;
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
@@ -336,13 +358,7 @@ static void end_compressed_bio_write(struct bio *bio)
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
@@ -408,7 +424,8 @@ blk_status_t btrfs_submit_compressed_write(struct btrfs_inode *inode, u64 start,
 	cb = kmalloc(compressed_bio_size(fs_info, compressed_len), GFP_NOFS);
 	if (!cb)
 		return BLK_STS_RESOURCE;
-	refcount_set(&cb->pending_bios, 0);
+	atomic_set(&cb->pending_bios, 0);
+	atomic_set(&cb->io_sectors, compressed_len >> fs_info->sectorsize_bits);
 	cb->errors = 0;
 	cb->inode = &inode->vfs_inode;
 	cb->start = start;
@@ -441,7 +458,6 @@ blk_status_t btrfs_submit_compressed_write(struct btrfs_inode *inode, u64 start,
 		bio->bi_opf |= REQ_CGROUP_PUNT;
 		kthread_associate_blkcg(blkcg_css);
 	}
-	refcount_set(&cb->pending_bios, 1);
 
 	/* create and submit bios for the compressed pages */
 	bytes_left = compressed_len;
@@ -469,13 +485,7 @@ blk_status_t btrfs_submit_compressed_write(struct btrfs_inode *inode, u64 start,
 
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
@@ -513,6 +523,7 @@ blk_status_t btrfs_submit_compressed_write(struct btrfs_inode *inode, u64 start,
 		cond_resched();
 	}
 
+	atomic_inc(&cb->pending_bios);
 	ret = btrfs_bio_wq_end_io(fs_info, bio, BTRFS_WQ_ENDIO_DATA);
 	BUG_ON(ret); /* -ENOMEM */
 
@@ -696,7 +707,8 @@ blk_status_t btrfs_submit_compressed_read(struct inode *inode, struct bio *bio,
 	if (!cb)
 		goto out;
 
-	refcount_set(&cb->pending_bios, 0);
+	atomic_set(&cb->pending_bios, 0);
+	atomic_set(&cb->io_sectors, compressed_len >> fs_info->sectorsize_bits);
 	cb->errors = 0;
 	cb->inode = inode;
 	cb->mirror_num = mirror_num;
@@ -741,7 +753,6 @@ blk_status_t btrfs_submit_compressed_read(struct inode *inode, struct bio *bio,
 	comp_bio->bi_opf = REQ_OP_READ;
 	comp_bio->bi_private = cb;
 	comp_bio->bi_end_io = end_compressed_bio_read;
-	refcount_set(&cb->pending_bios, 1);
 
 	for (pg_index = 0; pg_index < nr_pages; pg_index++) {
 		u32 pg_len = PAGE_SIZE;
@@ -770,18 +781,11 @@ blk_status_t btrfs_submit_compressed_read(struct inode *inode, struct bio *bio,
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
 
@@ -805,6 +809,7 @@ blk_status_t btrfs_submit_compressed_read(struct inode *inode, struct bio *bio,
 		cur_disk_byte += pg_len;
 	}
 
+	atomic_inc(&cb->pending_bios);
 	ret = btrfs_bio_wq_end_io(fs_info, comp_bio, BTRFS_WQ_ENDIO_DATA);
 	BUG_ON(ret); /* -ENOMEM */
 
diff --git a/fs/btrfs/compression.h b/fs/btrfs/compression.h
index c359f20920d0..41dd0bf6d5db 100644
--- a/fs/btrfs/compression.h
+++ b/fs/btrfs/compression.h
@@ -29,7 +29,15 @@ struct btrfs_inode;
 
 struct compressed_bio {
 	/* number of bios pending for this compressed extent */
-	refcount_t pending_bios;
+	atomic_t pending_bios;
+
+	/*
+	 * Number of sectors which hasn't finished.
+	 *
+	 * Combined with pending_bios, we can manually finish the compressed_bio
+	 * if we hit some error while there is still some pages not added.
+	 */
+	atomic_t io_sectors;
 
 	/* Number of compressed pages in the array */
 	unsigned int nr_pages;
-- 
2.32.0

