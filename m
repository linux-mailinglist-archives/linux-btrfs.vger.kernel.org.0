Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B38A3C6A51
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Jul 2021 08:15:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233889AbhGMGS2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 13 Jul 2021 02:18:28 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:36738 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233814AbhGMGS0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 13 Jul 2021 02:18:26 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 2B1B8221D2
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Jul 2021 06:15:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1626156936; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GPnaF2D7gBfPEU6QKdcmfaDlyqZ2J0sI70fJiV9fI7A=;
        b=Nv9AeZ16KJCkssmc7xo0JvQLcfEgfTZibbZ4vAmDHxF/d/2+DqUCFZHw1gaMStvClEOpY5
        I28NqjlHjNHadqnqM2vL94pdyUl3jCraN5d7P7J5QLzuorr0iwnEL+bkylu3/2Gt/avomY
        YhfwWnAtZowY+RZCsKKf6zXQvxhBGlk=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 6981F139AC
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Jul 2021 06:15:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id IMpQC4cv7WB0XgAAGKfGzw
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Jul 2021 06:15:35 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 13/27] btrfs: make btrfs_submit_compressed_write() to determine stripe boundary at bio allocation time
Date:   Tue, 13 Jul 2021 14:15:02 +0800
Message-Id: <20210713061516.163318-14-wqu@suse.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210713061516.163318-1-wqu@suse.com>
References: <20210713061516.163318-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Currently btrfs_submit_compressed_write() will check
btrfs_bio_fits_in_stripe() each time a new page is going to be added.

Even compressed extent is small, we don't really need to do that for
every page.

This patch will align the behavior to extent_io.c, by determining the
stripe boundary when allocating a bio.

Unlike extent_io.c, in compressed.c we don't need to bother things like
different bio flags, thus no need to re-use bio_ctrl.

Here we just manually introduce new local variable, next_stripe_start,
and use that value returned from alloc_compressed_bio() to calculate
the stripe boundary.

Then each time we add some page range into the bio, we check if we
reached the boundary.
And if reached, submit it.

Also, since we have @cur_disk_bytenr to determine whether we're the last
bio, we don't need a explicit last_bio: tag for error handling any more.

And since we use @cur_disk_bytenr to wait, there is no need for
pending_bios, also remove it to save some memory of compressed_bio.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/compression.c | 145 ++++++++++++++++++-----------------------
 fs/btrfs/compression.h |   3 -
 2 files changed, 62 insertions(+), 86 deletions(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index 30e10d8aeca0..70a4679799be 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -222,7 +222,6 @@ static bool dec_and_test_compressed_bio(struct compressed_bio *cb,
 	ASSERT(bi_size && bi_size <= cb->compressed_len);
 	last_io = refcount_sub_and_test(bi_size >> fs_info->sectorsize_bits,
 					&cb->pending_sectors);
-	atomic_dec(&cb->pending_bios);
 	/*
 	 * Here we must wake up the possible error handler after all other
 	 * operations on @cb finished, or we can race with
@@ -429,7 +428,6 @@ static blk_status_t submit_compressed_bio(struct btrfs_fs_info *fs_info,
 	blk_status_t ret;
 
 	ASSERT(bio->bi_iter.bi_size);
-	atomic_inc(&cb->pending_bios);
 	ret = btrfs_bio_wq_end_io(fs_info, bio, BTRFS_WQ_ENDIO_DATA);
 	if (ret)
 		return ret;
@@ -499,10 +497,7 @@ blk_status_t btrfs_submit_compressed_write(struct btrfs_inode *inode, u64 start,
 	struct btrfs_fs_info *fs_info = inode->root->fs_info;
 	struct bio *bio = NULL;
 	struct compressed_bio *cb;
-	unsigned long bytes_left;
-	int pg_index = 0;
-	struct page *page;
-	u64 first_byte = disk_start;
+	u64 cur_disk_bytenr = disk_start;
 	u64 next_stripe_start;
 	blk_status_t ret;
 	int skip_sum = inode->flags & BTRFS_INODE_NODATASUM;
@@ -513,7 +508,6 @@ blk_status_t btrfs_submit_compressed_write(struct btrfs_inode *inode, u64 start,
 	cb = kmalloc(compressed_bio_size(fs_info, compressed_len), GFP_NOFS);
 	if (!cb)
 		return BLK_STS_RESOURCE;
-	atomic_set(&cb->pending_bios, 0);
 	refcount_set(&cb->pending_sectors,
 		     compressed_len >> fs_info->sectorsize_bits);
 	cb->errors = 0;
@@ -526,45 +520,65 @@ blk_status_t btrfs_submit_compressed_write(struct btrfs_inode *inode, u64 start,
 	cb->orig_bio = NULL;
 	cb->nr_pages = nr_pages;
 
-	bio = alloc_compressed_bio(cb, first_byte, bio_op | write_flags,
-				   end_compressed_bio_write,
-				   &next_stripe_start);
-	if (IS_ERR(bio)) {
-		kfree(cb);
-		return errno_to_blk_status(PTR_ERR(bio));
-	}
-
-	if (blkcg_css) {
-		bio->bi_opf |= REQ_CGROUP_PUNT;
-		kthread_associate_blkcg(blkcg_css);
-	}
-
-	/* create and submit bios for the compressed pages */
-	bytes_left = compressed_len;
-	for (pg_index = 0; pg_index < cb->nr_pages; pg_index++) {
-		int submit = 0;
-		int len = 0;
+	while (cur_disk_bytenr < disk_start + compressed_len) {
+		u64 offset = cur_disk_bytenr - disk_start;
+		unsigned int index = offset >> PAGE_SHIFT;
+		unsigned int real_size;
+		unsigned int added;
+		struct page *page = compressed_pages[index];
+		bool submit = false;
 
-		page = compressed_pages[pg_index];
-		page->mapping = inode->vfs_inode.i_mapping;
-		if (bio->bi_iter.bi_size)
-			submit = btrfs_bio_fits_in_stripe(page, PAGE_SIZE, bio,
-							  0);
+		/* Allocate new bio if submitted or not yet allocated */
+		if (!bio) {
+			bio = alloc_compressed_bio(cb, cur_disk_bytenr,
+				bio_op | write_flags, end_compressed_bio_write,
+				&next_stripe_start);
+			if (IS_ERR(bio)) {
+				ret = errno_to_blk_status(PTR_ERR(bio));
+				bio = NULL;
+				goto finish_cb;
+			}
+		}
+		/*
+		 * We should never reach next_stripe_start start as we will
+		 * submit comp_bio when reach the boundary immediately.
+		 */
+		ASSERT(cur_disk_bytenr != next_stripe_start);
 
 		/*
-		 * Page can only be added to bio if the current bio fits in
-		 * stripe.
+		 * We have various limit on the real read size:
+		 * - stripe boundary
+		 * - page boundary
+		 * - compressed length boundary
 		 */
-		if (!submit) {
-			if (pg_index == 0 && use_append)
-				len = bio_add_zone_append_page(bio, page,
-							       PAGE_SIZE, 0);
-			else
-				len = bio_add_page(bio, page, PAGE_SIZE, 0);
-		}
+		real_size = min_t(u64, U32_MAX,
+				  next_stripe_start - cur_disk_bytenr);
+		real_size = min_t(u64, real_size,
+				  PAGE_SIZE - offset_in_page(offset));
+		real_size = min_t(u64, real_size,
+				  compressed_len - offset);
+		ASSERT(IS_ALIGNED(real_size, fs_info->sectorsize));
 
-		page->mapping = NULL;
-		if (submit || len < PAGE_SIZE) {
+		if (use_append)
+			added = bio_add_zone_append_page(bio, page, real_size,
+					offset_in_page(offset));
+		else
+			added = bio_add_page(bio, page, real_size,
+					offset_in_page(offset));
+		/* Reached zoned boundary */
+		if (added == 0)
+			submit = true;
+
+		cur_disk_bytenr += added;
+		/* Reached stripe boundary */
+		if (cur_disk_bytenr == next_stripe_start)
+			submit = true;
+
+		/* Finished the range */
+		if (cur_disk_bytenr == disk_start + compressed_len)
+			submit = true;
+
+		if (submit) {
 			if (!skip_sum) {
 				ret = btrfs_csum_one_bio(inode, bio, start, 1);
 				if (ret)
@@ -574,61 +588,27 @@ blk_status_t btrfs_submit_compressed_write(struct btrfs_inode *inode, u64 start,
 			ret = submit_compressed_bio(fs_info, cb, bio, 0);
 			if (ret)
 				goto finish_cb;
-
-			bio = alloc_compressed_bio(cb, first_byte,
-					bio_op | write_flags,
-					end_compressed_bio_write,
-					&next_stripe_start);
-			if (IS_ERR(bio)) {
-				ret = errno_to_blk_status(PTR_ERR(bio));
-				bio = NULL;
-				goto finish_cb;
-			}
-			if (blkcg_css)
-				bio->bi_opf |= REQ_CGROUP_PUNT;
-			/*
-			 * Use bio_add_page() to ensure the bio has at least one
-			 * page.
-			 */
-			bio_add_page(bio, page, PAGE_SIZE, 0);
-		}
-		if (bytes_left < PAGE_SIZE) {
-			btrfs_info(fs_info,
-					"bytes left %lu compress len %u nr %u",
-			       bytes_left, cb->compressed_len, cb->nr_pages);
+			bio = NULL;
 		}
-		bytes_left -= PAGE_SIZE;
-		first_byte += PAGE_SIZE;
 		cond_resched();
 	}
-
-	if (!skip_sum) {
-		ret = btrfs_csum_one_bio(inode, bio, start, 1);
-		if (ret)
-			goto last_bio;
-	}
-
-	ret = submit_compressed_bio(fs_info, cb, bio, 0);
-	if (ret)
-		goto last_bio;
-
 	if (blkcg_css)
 		kthread_associate_blkcg(NULL);
 
 	return 0;
-last_bio:
-	bio->bi_status = ret;
-	/* One of the bios' endio function will free @cb. */
-	bio_endio(bio);
-	return ret;
 
 finish_cb:
 	if (bio) {
 		bio->bi_status = ret;
 		bio_endio(bio);
 	}
+	/* Last byte of @cb is submitted, endio will free @cb */
+	if (cur_disk_bytenr == disk_start + compressed_len)
+		return ret;
 
-	wait_var_event(cb, atomic_read(&cb->pending_bios) == 0);
+	wait_var_event(cb, refcount_read(&cb->pending_sectors) ==
+			   (disk_start + compressed_len - cur_disk_bytenr) >>
+			   fs_info->sectorsize_bits);
 	/*
 	 * Even with previous bio ended, we should still have io not yet
 	 * submitted, thus need to finish manually.
@@ -841,7 +821,6 @@ blk_status_t btrfs_submit_compressed_read(struct inode *inode, struct bio *bio,
 	if (!cb)
 		goto out;
 
-	atomic_set(&cb->pending_bios, 0);
 	refcount_set(&cb->pending_sectors,
 		     compressed_len >> fs_info->sectorsize_bits);
 	cb->errors = 0;
diff --git a/fs/btrfs/compression.h b/fs/btrfs/compression.h
index 61955581e34f..56eef0821e3e 100644
--- a/fs/btrfs/compression.h
+++ b/fs/btrfs/compression.h
@@ -28,9 +28,6 @@ struct btrfs_inode;
 #define	BTRFS_ZLIB_DEFAULT_LEVEL		3
 
 struct compressed_bio {
-	/* number of bios pending for this compressed extent */
-	atomic_t pending_bios;
-
 	/* Number of sectors with unfinished IO (unsubmitted or unfinished) */
 	refcount_t pending_sectors;
 
-- 
2.32.0

