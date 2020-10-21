Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAD15294850
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Oct 2020 08:28:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440844AbgJUG16 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 21 Oct 2020 02:27:58 -0400
Received: from mx2.suse.de ([195.135.220.15]:44552 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2436568AbgJUG16 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 21 Oct 2020 02:27:58 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1603261676;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=idpZRZ1OBipN/QCRLaxG4YKvRobevBpJzIzLrSQyf+4=;
        b=RtGCL3zAIYg6uhAWjb0LAkWfiABIIM0aNnnkfBx7KYVHjTg2j7EPUrwbc4lWylMf9ZUl7r
        47paCXhA/IePzurfS3yJi+sa/n8HFZdIspfG7Ea05Y+eN25tNDE3y9vTPhRpQRLRzPBoBU
        cBjfNccnJQFl/tfrmRPpZztW7FoPXR0=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C8BA7AC12
        for <linux-btrfs@vger.kernel.org>; Wed, 21 Oct 2020 06:27:56 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v4 52/68] btrfs: extent_io: introduce end_bio_subpage_eb_writepage() function
Date:   Wed, 21 Oct 2020 14:25:38 +0800
Message-Id: <20201021062554.68132-53-wqu@suse.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201021062554.68132-1-wqu@suse.com>
References: <20201021062554.68132-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The new function, end_bio_subpage_eb_writepage(), will handle the
metadata writeback endio.

The major difference involved is:
- Page Writeback clear
  We will only clear the page writeback bit after all extent buffers in
  the same page has finished their writeback.
  This means we need to check the EXTENT_WRITEBACK bit for the page
  range.

- Clear EXTENT_WRITEBACK bit for btree inode
  This is the new bit for btree inode io tree. It emulates the same page
  status, but in sector size aligned range.
  The new bit is remapped from EXTENT_DEFRAG, as defrag is impossible
  for btree inode, it should be pretty safe to use.

Also since the new endio function needs quite some extent io tree
operations, change btree_submit_bio_hook() to queue the endio work into
metadata endio workqueue.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/disk-io.c   | 21 ++++++++++++-
 fs/btrfs/extent_io.c | 73 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 93 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index e466c30b52c8..2ac980f739dc 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -961,6 +961,7 @@ blk_status_t btrfs_wq_submit_bio(struct inode *inode, struct bio *bio,
 	async->mirror_num = mirror_num;
 	async->submit_bio_start = submit_bio_start;
 
+
 	btrfs_init_work(&async->work, run_one_async_start, run_one_async_done,
 			run_one_async_free);
 
@@ -1031,7 +1032,25 @@ static blk_status_t btree_submit_bio_hook(struct inode *inode, struct bio *bio,
 		if (ret)
 			goto out_w_error;
 		ret = btrfs_map_bio(fs_info, bio, mirror_num);
-	} else if (!async) {
+		if (ret < 0)
+			goto out_w_error;
+		return ret;
+	}
+
+	/*
+	 * For subpage metadata write, the endio involes several
+	 * extent_io_tree operations, which is not suitable for endio
+	 * context.
+	 * Thus we need to queue them into endio workqueue.
+	 */
+	if (btrfs_is_subpage(fs_info)) {
+		ret = btrfs_bio_wq_end_io(fs_info, bio,
+					  BTRFS_WQ_ENDIO_METADATA);
+		if (ret)
+			goto out_w_error;
+	}
+
+	if (!async) {
 		ret = btree_csum_one_bio(bio);
 		if (ret)
 			goto out_w_error;
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 3a2bb2656067..2a66bfae3414 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -4149,6 +4149,76 @@ static void set_btree_ioerr(struct page *page, struct extent_buffer *eb)
 	}
 }
 
+/*
+ * The endio function for subpage extent buffer write.
+ *
+ * Unlike end_bio_extent_buffer_writepage(), we only call end_page_writeback()
+ * after all extent buffers in the page has finished their writeback.
+ */
+static void end_bio_subpage_eb_writepage(struct bio *bio)
+{
+	struct bio_vec *bvec;
+	struct bvec_iter_all iter_all;
+
+	ASSERT(!bio_flagged(bio, BIO_CLONED));
+	bio_for_each_segment_all(bvec, bio, iter_all) {
+		struct page *page = bvec->bv_page;
+		struct btrfs_fs_info *fs_info = page_to_fs_info(page);
+		struct extent_buffer *eb;
+		u64 page_start = page_offset(page);
+		u64 page_end = page_start + PAGE_SIZE - 1;
+		u64 bvec_start = page_offset(page) + bvec->bv_offset;
+		u64 bvec_end = bvec_start + bvec->bv_len - 1;
+		u64 cur_bytenr = bvec_start;
+
+		ASSERT(IS_ALIGNED(bvec->bv_len, fs_info->nodesize));
+
+		/* Iterate through all extent buffers in the range */
+		while (cur_bytenr <= bvec_end) {
+			struct extent_state *cached = NULL;
+			struct extent_io_tree *io_tree =
+				info_to_btree_io_tree(fs_info);
+			int done;
+			int ret;
+
+			ret = btrfs_find_first_subpage_eb(fs_info, &eb,
+					cur_bytenr, bvec_end, 0);
+			if (ret > 0)
+				break;
+
+			cur_bytenr = eb->start + eb->len;
+
+			ASSERT(test_bit(EXTENT_BUFFER_WRITEBACK, &eb->bflags));
+			done = atomic_dec_and_test(&eb->io_pages);
+			ASSERT(done);
+
+			if (bio->bi_status ||
+			    test_bit(EXTENT_BUFFER_WRITE_ERR, &eb->bflags)) {
+				ClearPageUptodate(page);
+				set_btree_ioerr(page, eb);
+			}
+
+			clear_extent_bit(io_tree, eb->start,
+					eb->start + eb->len - 1,
+					EXTENT_WRITEBACK | EXTENT_LOCKED, 1, 0,
+					&cached);
+			lock_page(page);
+			/*
+			 * Only end the page writeback if there is no extent
+			 * buffer under writeback in the page anymore
+			 */
+			if (!test_range_bit(io_tree, page_start, page_end,
+					    EXTENT_WRITEBACK, 0, cached) &&
+			    PageWriteback(page))
+				end_page_writeback(page);
+			unlock_page(page);
+			free_extent_state(cached);
+			end_extent_buffer_writeback(eb);
+		}
+	}
+	bio_put(bio);
+}
+
 static void end_bio_extent_buffer_writepage(struct bio *bio)
 {
 	struct bio_vec *bvec;
@@ -4156,6 +4226,9 @@ static void end_bio_extent_buffer_writepage(struct bio *bio)
 	int done;
 	struct bvec_iter_all iter_all;
 
+	if (btrfs_is_subpage(page_to_fs_info(bio_first_page_all(bio))))
+		return end_bio_subpage_eb_writepage(bio);
+
 	ASSERT(!bio_flagged(bio, BIO_CLONED));
 	bio_for_each_segment_all(bvec, bio, iter_all) {
 		struct page *page = bvec->bv_page;
-- 
2.28.0

