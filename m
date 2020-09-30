Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A34627DE26
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Sep 2020 03:57:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729988AbgI3B5U (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 29 Sep 2020 21:57:20 -0400
Received: from mx2.suse.de ([195.135.220.15]:51114 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729982AbgI3B5T (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 29 Sep 2020 21:57:19 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1601431037;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NLPSJIfF4OGBpgVkLYPrraboZachCT7dFv+9cncXCJo=;
        b=drOCzSIJYm7Qw742VjC/+AcmA0RyDh7Ilgu32rXkvClhHFEkrmNGiUJdPWIZ2uAnDVd3S0
        xune9dki6sFMqcvsRvScJZKKuY20KvKzg/ncWb8CdWcAxW4LMU4o4I1IynUqIw98b5GkOp
        ODgFPiRZk+iqtYyG1ZK+cNBIqxlQITM=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D3230AF99
        for <linux-btrfs@vger.kernel.org>; Wed, 30 Sep 2020 01:57:17 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v3 45/49] btrfs: extent_io: introduce write_one_subpage_eb() function
Date:   Wed, 30 Sep 2020 09:55:35 +0800
Message-Id: <20200930015539.48867-46-wqu@suse.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200930015539.48867-1-wqu@suse.com>
References: <20200930015539.48867-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The new function, write_one_subpage_eb(), as a subroutine for subpage
metadata write, will handle the extent buffer bio submission.

The main difference between the new write_one_subpage_eb() and
write_one_eb() is:
- Page unlock
  write_one_subpage_eb() will not unlock the page, and it's the caller
  to lock the page , submit all extent buffers in the page,
  then unlock the page.

- Extra EXTENT_* bits along with page status update
  New EXTENT_WRITEBACK bit is introduced to trace extent buffer write
  back.

  For page dirty bit, it will only be cleared if all dirty extent buffers
  in the page range has been cleaned.
  For page writeback bit, it will be set anyway, and cleared in the
  error path if no other extent buffers are under writeback.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent-io-tree.h |  3 ++
 fs/btrfs/extent_io.c      | 75 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 78 insertions(+)

diff --git a/fs/btrfs/extent-io-tree.h b/fs/btrfs/extent-io-tree.h
index 5c0a66146f05..12673bd50378 100644
--- a/fs/btrfs/extent-io-tree.h
+++ b/fs/btrfs/extent-io-tree.h
@@ -26,6 +26,9 @@ struct io_failure_record;
 /* For subpage btree io tree, indicates there is an in-tree extent buffer */
 #define EXTENT_HAS_TREE_BLOCK	(1U << 15)
 
+/* For subpage btree io tree, indicates the range is under writeback */
+#define EXTENT_WRITEBACK	(1U << 16)
+
 #define EXTENT_DO_ACCOUNTING    (EXTENT_CLEAR_META_RESV | \
 				 EXTENT_CLEAR_DATA_RESV)
 #define EXTENT_CTLBITS		(EXTENT_DO_ACCOUNTING)
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index f80ba4c13fe6..736bc33a0e64 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -3124,6 +3124,7 @@ static int submit_extent_page(unsigned int opf,
 	ASSERT(bio_ret);
 
 	if (*bio_ret) {
+		bool force_merge = false;
 		bool contig;
 		bool can_merge = true;
 
@@ -3149,6 +3150,7 @@ static int submit_extent_page(unsigned int opf,
 		if (prev_bio_flags != bio_flags || !contig || !can_merge ||
 		    force_bio_submit ||
 		    bio_add_page(bio, page, io_size, pg_offset) < io_size) {
+			ASSERT(!force_merge);
 			ret = submit_one_bio(bio, mirror_num, prev_bio_flags);
 			if (ret < 0) {
 				*bio_ret = NULL;
@@ -4007,6 +4009,76 @@ static void end_bio_extent_buffer_writepage(struct bio *bio)
 	bio_put(bio);
 }
 
+/*
+ * Unlike the work in write_one_eb(), we won't unlock the page even we
+ * succeeded submitting the extent buffer.
+ * It's callers responsibility to unlock the page after all extent
+ *
+ * Caller should still call write_one_eb() other than this function directly.
+ * As write_one_eb() has extra prepration before submitting the extent buffer.
+ */
+static int write_one_subpage_eb(struct extent_buffer *eb,
+				      struct writeback_control *wbc,
+				      struct extent_page_data *epd)
+{
+	struct btrfs_fs_info *fs_info = eb->fs_info;
+	struct extent_state *cached = NULL;
+	struct extent_io_tree *io_tree = info_to_btree_io_tree(fs_info);
+	struct page *page = eb->pages[0];
+	u64 page_start = page_offset(page);
+	u64 page_end = page_start + PAGE_SIZE - 1;
+	unsigned int write_flags = wbc_to_write_flags(wbc) | REQ_META;
+	bool no_dirty_ebs = false;
+	int ret;
+
+	ASSERT(PageLocked(page));
+
+	/* Convert the EXTENT_DIRTY to EXTENT_WRITEBACK for this eb */
+	ret = convert_extent_bit(io_tree, eb->start, eb->start + eb->len - 1,
+				 EXTENT_WRITEBACK, EXTENT_DIRTY, &cached);
+	if (ret < 0)
+		return ret;
+	/*
+	 * Only clear page dirty if there is no dirty extent buffer in the
+	 * page range
+	 */
+	if (!test_range_bit(io_tree, page_start, page_end, EXTENT_DIRTY, 0,
+			    cached)) {
+		clear_page_dirty_for_io(page);
+		no_dirty_ebs = true;
+	}
+	/* Any extent buffer writeback will mark the full page writeback */
+	set_page_writeback(page);
+
+	ret = submit_extent_page(REQ_OP_WRITE | write_flags, wbc, page,
+			eb->start, eb->len, eb->start - page_offset(page),
+			&epd->bio, end_bio_extent_buffer_writepage, 0, 0, 0,
+			false);
+	if (ret) {
+		clear_extent_bit(io_tree, eb->start, eb->start + eb->len - 1,
+				 EXTENT_WRITEBACK, 0, 0, &cached);
+		set_btree_ioerr(page, eb);
+		if (PageWriteback(page) &&
+		    !test_range_bit(io_tree, page_start, page_end,
+				    EXTENT_WRITEBACK, 0, cached))
+			end_page_writeback(page);
+
+		if (atomic_dec_and_test(&eb->io_pages))
+			end_extent_buffer_writeback(eb);
+		free_extent_state(cached);
+		return -EIO;
+	}
+	free_extent_state(cached);
+	/*
+	 * Submission finishes without problem, if no eb is dirty anymore, we
+	 * have submitted a page.
+	 * Update the nr_written in wbc.
+	 */
+	if (no_dirty_ebs)
+		update_nr_written(wbc, 1);
+	return ret;
+}
+
 static noinline_for_stack int write_one_eb(struct extent_buffer *eb,
 			struct writeback_control *wbc,
 			struct extent_page_data *epd)
@@ -4038,6 +4110,9 @@ static noinline_for_stack int write_one_eb(struct extent_buffer *eb,
 		memzero_extent_buffer(eb, start, end - start);
 	}
 
+	if (btrfs_is_subpage(eb->fs_info))
+		return write_one_subpage_eb(eb, wbc, epd);
+
 	for (i = 0; i < num_pages; i++) {
 		struct page *p = eb->pages[i];
 
-- 
2.28.0

