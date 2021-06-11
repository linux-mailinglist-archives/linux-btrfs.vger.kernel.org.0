Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D65913A394C
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Jun 2021 03:31:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231159AbhFKBda (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 10 Jun 2021 21:33:30 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:60776 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230190AbhFKBda (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 10 Jun 2021 21:33:30 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 15DAD21992
        for <linux-btrfs@vger.kernel.org>; Fri, 11 Jun 2021 01:31:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1623375092; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uPIIWpxmKE2jgKRJKiiQZdV8qn12dcMI6YWAPlMhczc=;
        b=L27Cw6uBsLzwUEpXmU8Te74zz6JAG0dj5O+hxdyFNa7+RUk2b9yrOPpwmefxL517Ttki1R
        0emFl/dCS2STWR5ECB3hk9QY+2eQ2d0jNZ24XexRUc1YCSg5eonnJCNjzRv3RwtYxSmlwu
        wxfvGr1vGINUlAX7C14YMo51CQo+H0Y=
Received: from adam-pc.lan (unknown [10.163.16.38])
        by relay2.suse.de (Postfix) with ESMTP id 28D97A3B91
        for <linux-btrfs@vger.kernel.org>; Fri, 11 Jun 2021 01:31:30 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 8/9] btrfs: make btrfs_submit_compressed_read() to determine stripe boundary at bio allocation time
Date:   Fri, 11 Jun 2021 09:31:13 +0800
Message-Id: <20210611013114.57264-9-wqu@suse.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210611013114.57264-1-wqu@suse.com>
References: <20210611013114.57264-1-wqu@suse.com>
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

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/compression.c | 122 ++++++++++++++++++++---------------------
 1 file changed, 59 insertions(+), 63 deletions(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index 71d7b1b9b4bf..de91489b92c0 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -491,10 +491,7 @@ blk_status_t btrfs_submit_compressed_write(struct btrfs_inode *inode, u64 start,
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
@@ -518,38 +515,58 @@ blk_status_t btrfs_submit_compressed_write(struct btrfs_inode *inode, u64 start,
 	cb->orig_bio = NULL;
 	cb->nr_pages = nr_pages;
 
-	bio = alloc_compressed_bio(cb, first_byte, bio_op | write_flags,
-				   end_compressed_bio_write,
-				   &next_stripe_start);
-	if (IS_ERR(bio)) {
-		kfree(cb);
-		return errno_to_blk_status(PTR_ERR(bio));
-	}
+	while (cur_disk_bytenr < disk_start + compressed_len) {
+		u64 offset = cur_disk_bytenr - disk_start;
+		int index = offset >> PAGE_SHIFT;
+		unsigned int real_size;
+		unsigned int added;
+		struct page *page = compressed_pages[index];
 
-	if (blkcg_css) {
-		bio->bi_opf |= REQ_CGROUP_PUNT;
-		kthread_associate_blkcg(blkcg_css);
-	}
+		/* Allocate new bio if not allocated or already submitted */
+		if (!bio) {
+			bio = alloc_compressed_bio(cb, cur_disk_bytenr,
+				bio_op | write_flags,
+				end_compressed_bio_write,
+				&next_stripe_start);
+			if (IS_ERR(bio)) {
+				ret = errno_to_blk_status(PTR_ERR(bio));
+				bio = NULL;
+				goto finish_cb;
+			}
+		}
+		/*
+		 * We should never reach next_stripe_start, as if we reach the
+		 * boundary we will submit the bio immediately.
+		 */
+		ASSERT(cur_disk_bytenr != next_stripe_start);
+
+		/*
+		 * We have various limit on the real read size:
+		 * - stripe boundary
+		 * - page boundary
+		 * - compressed length boundary
+		 */
+		real_size = min_t(u64, U32_MAX,
+				  next_stripe_start - cur_disk_bytenr);
+		real_size = min_t(u64, real_size,
+				  PAGE_SIZE - offset_in_page(offset));
+		real_size = min_t(u64, real_size,
+				  compressed_len - offset);
+		ASSERT(IS_ALIGNED(real_size, fs_info->sectorsize));
 
-	/* create and submit bios for the compressed pages */
-	bytes_left = compressed_len;
-	for (pg_index = 0; pg_index < cb->nr_pages; pg_index++) {
-		int submit = 0;
-		int len;
+		added = bio_add_page(bio, page, real_size,
+				     offset_in_page(offset));
+		/*
+		 * Maximum compressed extent size is 128K, we should never
+		 * reach bio size limit.
+		 */
+		ASSERT(added == real_size);
 
-		page = compressed_pages[pg_index];
-		page->mapping = inode->vfs_inode.i_mapping;
-		if (bio->bi_iter.bi_size)
-			submit = btrfs_bio_fits_in_stripe(page, PAGE_SIZE, bio,
-							  0);
+		cur_disk_bytenr += added;
 
-		if (pg_index == 0 && use_append)
-			len = bio_add_zone_append_page(bio, page, PAGE_SIZE, 0);
-		else
-			len = bio_add_page(bio, page, PAGE_SIZE, 0);
+		/* Reached boundary stripe, need to submit */
+		if (cur_disk_bytenr == next_stripe_start) {
 
-		page->mapping = NULL;
-		if (submit || len < PAGE_SIZE) {
 			if (!skip_sum) {
 				ret = btrfs_csum_one_bio(inode, bio, start, 1);
 				if (ret)
@@ -559,47 +576,26 @@ blk_status_t btrfs_submit_compressed_write(struct btrfs_inode *inode, u64 start,
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
-					"bytes left %lu compress len %lu nr %lu",
-			       bytes_left, cb->compressed_len, cb->nr_pages);
+			bio = NULL;
 		}
-		bytes_left -= PAGE_SIZE;
-		first_byte += PAGE_SIZE;
 		cond_resched();
 	}
 
-	if (!skip_sum) {
-		ret = btrfs_csum_one_bio(inode, bio, start, 1);
+	/* Submit the last bio */
+	if (bio) {
+		if (!skip_sum) {
+			ret = btrfs_csum_one_bio(inode, bio, start, 1);
+			if (ret)
+				goto last_bio;
+		}
+
+		ret = submit_compressed_bio(fs_info, cb, bio, 0);
 		if (ret)
 			goto last_bio;
-	}
-
-	ret = submit_compressed_bio(fs_info, cb, bio, 0);
-	if (ret)
-		goto last_bio;
 
+	}
 	if (blkcg_css)
 		kthread_associate_blkcg(NULL);
-
 	return 0;
 
 last_bio:
-- 
2.32.0

