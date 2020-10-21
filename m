Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18A74294844
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Oct 2020 08:27:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440808AbgJUG13 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 21 Oct 2020 02:27:29 -0400
Received: from mx2.suse.de ([195.135.220.15]:44016 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2436568AbgJUG12 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 21 Oct 2020 02:27:28 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1603261646;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dDuFan7Aeq1BHQlsx4hjW1K4v3F3c0HWDMwkUlRqFBU=;
        b=Gujcd2XfE6X9AgLsDImKN2XRg4DGilo5HZA8rmdegIBplNP7A2LQY/v2GfMZRdX9kjyyg0
        by/rhfSFAkiqkhekPab2Lm75wWXEdxJv9CYPk5/APGCv72ub8ln2/I7c1s/L6gzGXmfslZ
        sIhzeA5cHHetBNznW8CS+jKuVP5IAek=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 55AACAC12
        for <linux-btrfs@vger.kernel.org>; Wed, 21 Oct 2020 06:27:26 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v4 40/68] btrfs: extent_io: introduce EXTENT_READ_SUBMITTED to handle subpage data read
Date:   Wed, 21 Oct 2020 14:25:26 +0800
Message-Id: <20201021062554.68132-41-wqu@suse.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201021062554.68132-1-wqu@suse.com>
References: <20201021062554.68132-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

In end_bio_extent_readpage(), we will unlock the page for each segment,
this is fine for regular sectorsize == PAGE_SIZE case.

But for subpage size case, we may have several bio segments for the same
page, and unlock the page unconditionally could easily screw up the
locking.

To address the problem:
- Introduce a new bit, EXTENT_READ_SUBMITTED
  Now for subpage data read, each submitted read bio will have its range
  with EXTENT_READ_SUBMITTED set.

- Set the EXTENT_READ_SUBMITTED in __do_readpage()
  Set the full page with EXTENT_READ_SUBMITTED set.

- Clear and test if we're the last owner of EXTENT_READ_SUBMITTED in
  end_bio_extent_readpage() and __do_readpage()
  This ensures that no matter who finishes filling the page, the last
  owner will unlock the page.

  This is quite different from regular sectorsize case, where one page
  either get unlocked in __do_readpage() or in
  end_bio_extent_readpage().

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent-io-tree.h |  22 ++++++++
 fs/btrfs/extent_io.c      | 115 +++++++++++++++++++++++++++++++++++---
 2 files changed, 129 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/extent-io-tree.h b/fs/btrfs/extent-io-tree.h
index bdafac1bd15f..d3b21c732634 100644
--- a/fs/btrfs/extent-io-tree.h
+++ b/fs/btrfs/extent-io-tree.h
@@ -26,6 +26,15 @@ struct io_failure_record;
 /* For subpage btree io tree, indicates there is an in-tree extent buffer */
 #define EXTENT_HAS_TREE_BLOCK	(1U << 15)
 
+/*
+ * For subpage data io tree, indicates there is an read bio submitted.
+ * The last one to clear the bit in the page will be responsible to unlock
+ * the containg page.
+ *
+ * TODO: Remove this if we use iomap for data read.
+ */
+#define EXTENT_READ_SUBMITTED	(1U << 16)
+
 #define EXTENT_DO_ACCOUNTING    (EXTENT_CLEAR_META_RESV | \
 				 EXTENT_CLEAR_DATA_RESV)
 #define EXTENT_CTLBITS		(EXTENT_DO_ACCOUNTING)
@@ -115,6 +124,19 @@ struct extent_io_extra_options {
 	 */
 	bool wake;
 	bool delete;
+
+	/*
+	 * For __clear_extent_bit(), to skip the spin lock and rely on caller
+	 * for the lock.
+	 * This allows the caller to do test-and-clear in a spinlock.
+	 */
+	bool skip_lock;
+
+	/*
+	 * For __clear_extent_bit(), paired with skip_lock, to provide the
+	 * preallocated extent_state.
+	 */
+	struct extent_state *prealloc;
 };
 
 int __init extent_state_cache_init(void);
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 37593b599522..5254a4ce2598 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -710,6 +710,7 @@ int __clear_extent_bit(struct extent_io_tree *tree, u64 start, u64 end,
 	struct rb_node *node;
 	bool wake;
 	bool delete;
+	bool skip_lock;
 	u64 last_end;
 	int err;
 	int clear = 0;
@@ -719,8 +720,13 @@ int __clear_extent_bit(struct extent_io_tree *tree, u64 start, u64 end,
 	changeset = extra_opts->changeset;
 	wake = extra_opts->wake;
 	delete = extra_opts->delete;
+	skip_lock = extra_opts->skip_lock;
 
-	btrfs_debug_check_extent_io_range(tree, start, end);
+	if (skip_lock)
+		ASSERT(!gfpflags_allow_blocking(mask));
+
+	if (!skip_lock)
+		btrfs_debug_check_extent_io_range(tree, start, end);
 	trace_btrfs_clear_extent_bit(tree, start, end - start + 1, bits);
 
 	if (bits & EXTENT_DELALLOC)
@@ -742,8 +748,11 @@ int __clear_extent_bit(struct extent_io_tree *tree, u64 start, u64 end,
 		 */
 		prealloc = alloc_extent_state(mask);
 	}
+	if (!prealloc && skip_lock)
+		prealloc = extra_opts->prealloc;
 
-	spin_lock(&tree->lock);
+	if (!skip_lock)
+		spin_lock(&tree->lock);
 	if (cached_state) {
 		cached = *cached_state;
 
@@ -848,15 +857,20 @@ int __clear_extent_bit(struct extent_io_tree *tree, u64 start, u64 end,
 search_again:
 	if (start > end)
 		goto out;
-	spin_unlock(&tree->lock);
-	if (gfpflags_allow_blocking(mask))
-		cond_resched();
+	if (!skip_lock) {
+		spin_unlock(&tree->lock);
+		if (gfpflags_allow_blocking(mask))
+			cond_resched();
+	}
 	goto again;
 
 out:
-	spin_unlock(&tree->lock);
+	if (!skip_lock)
+		spin_unlock(&tree->lock);
 	if (prealloc)
 		free_extent_state(prealloc);
+	if (skip_lock)
+		extra_opts->prealloc = NULL;
 
 	return 0;
 
@@ -2926,6 +2940,70 @@ endio_readpage_release_extent(struct extent_io_tree *tree, struct page *page,
 	unlock_extent_cached_atomic(tree, start, end, &cached);
 }
 
+/*
+ * Finish the read and unlock the page if needed.
+ *
+ * For regular sectorsize == PAGE_SIZE case, just unlock the page.
+ * For subpage case, clear the EXTENT_READ_SUBMITTED bit, then if and
+ * only if we're the last EXTENT_READ_SUBMITTED of the page.
+ */
+static void finish_and_unlock_read_page(struct btrfs_fs_info *fs_info,
+		struct extent_io_tree *tree, u64 start, u64 end,
+		struct page *page, bool in_endio_context)
+{
+	struct extent_io_extra_options extra_opts = {
+		.skip_lock = true,
+	};
+	u64 page_start = round_down(start, PAGE_SIZE);
+	u64 page_end = page_start + PAGE_SIZE - 1;
+	bool metadata = (tree->owner == IO_TREE_BTREE_INODE_IO);
+	bool has_bit = true;
+	bool last_owner = false;
+
+	/*
+	 * For subpage metadata, we don't lock page for read/write at all,
+	 * just exit.
+	 */
+	if (btrfs_is_subpage(fs_info) && metadata)
+		return;
+
+	/* For regular sector size, we need to unlock the full page for endio */
+	if (!btrfs_is_subpage(fs_info)) {
+		/*
+		 * This function can be called in __do_readpage(), in that case we
+		 * shouldn't unlock the page.
+		 */
+		if (in_endio_context)
+			unlock_page(page);
+		return;
+	}
+
+	/*
+	 * The remaining case is subpage data read, which we need to update
+	 * EXTENT_READ_SUBMITTED and unlock the page for the last reader.
+	 */
+	ASSERT(end <= page_end);
+
+	/* Will be freed in __clear_extent_bit() */
+	extra_opts.prealloc = alloc_extent_state(GFP_NOFS);
+
+	spin_lock(&tree->lock);
+	/* Check if we have the bit first */
+	if (IS_ENABLED(CONFIG_BTRFS_DEBUG)) {
+		has_bit = test_range_bit_nolock(tree, start, end,
+				EXTENT_READ_SUBMITTED, 1, NULL);
+		WARN_ON(!has_bit);
+	}
+
+	__clear_extent_bit(tree, start, end, EXTENT_READ_SUBMITTED, NULL,
+			   GFP_ATOMIC, &extra_opts);
+	last_owner = !test_range_bit_nolock(tree, page_start, page_end,
+					    EXTENT_READ_SUBMITTED, 0, NULL);
+	spin_unlock(&tree->lock);
+	if (has_bit && last_owner)
+		unlock_page(page);
+}
+
 /*
  * after a readpage IO is done, we need to:
  * clear the uptodate bits on error
@@ -3050,7 +3128,7 @@ static void end_bio_extent_readpage(struct bio *bio)
 		offset += len;
 
 		endio_readpage_release_extent(tree, page, start, end, uptodate);
-		unlock_page(page);
+		finish_and_unlock_read_page(fs_info, tree, start, end, page, true);
 	}
 
 	btrfs_io_bio_free_csum(io_bio);
@@ -3277,6 +3355,7 @@ __get_extent_map(struct inode *inode, struct page *page, size_t pg_offset,
 	}
 	return em;
 }
+
 /*
  * basic readpage implementation.  Locked extent state structs are inserted
  * into the tree that are removed when the IO is done (by the end_io
@@ -3292,6 +3371,7 @@ static int __do_readpage(struct page *page,
 			 u64 *prev_em_start)
 {
 	struct inode *inode = page->mapping->host;
+	struct btrfs_fs_info *fs_info = BTRFS_I(inode)->root->fs_info;
 	u64 start = page_offset(page);
 	const u64 end = start + PAGE_SIZE - 1;
 	u64 cur = start;
@@ -3330,6 +3410,9 @@ static int __do_readpage(struct page *page,
 			kunmap_atomic(userpage);
 		}
 	}
+
+	if (btrfs_is_subpage(fs_info))
+		set_extent_bits(tree, start, end, EXTENT_READ_SUBMITTED);
 	while (cur <= end) {
 		bool force_bio_submit = false;
 		u64 offset;
@@ -3347,6 +3430,8 @@ static int __do_readpage(struct page *page,
 					    &cached, GFP_NOFS);
 			unlock_extent_cached(tree, cur,
 					     cur + iosize - 1, &cached);
+			finish_and_unlock_read_page(fs_info, tree, cur,
+						cur + iosize - 1, page, false);
 			break;
 		}
 		em = __get_extent_map(inode, page, pg_offset, cur,
@@ -3354,6 +3439,8 @@ static int __do_readpage(struct page *page,
 		if (IS_ERR_OR_NULL(em)) {
 			SetPageError(page);
 			unlock_extent(tree, cur, end);
+			finish_and_unlock_read_page(fs_info, tree, cur,
+						cur + iosize - 1, page, false);
 			break;
 		}
 		extent_offset = cur - em->start;
@@ -3436,6 +3523,8 @@ static int __do_readpage(struct page *page,
 					    &cached, GFP_NOFS);
 			unlock_extent_cached(tree, cur,
 					     cur + iosize - 1, &cached);
+			finish_and_unlock_read_page(fs_info, tree, cur,
+						cur + iosize - 1, page, false);
 			cur = cur + iosize;
 			pg_offset += iosize;
 			continue;
@@ -3445,6 +3534,8 @@ static int __do_readpage(struct page *page,
 				   EXTENT_UPTODATE, 1, NULL)) {
 			check_page_uptodate(tree, page);
 			unlock_extent(tree, cur, cur + iosize - 1);
+			finish_and_unlock_read_page(fs_info, tree, cur,
+						cur + iosize - 1, page, false);
 			cur = cur + iosize;
 			pg_offset += iosize;
 			continue;
@@ -3455,6 +3546,8 @@ static int __do_readpage(struct page *page,
 		if (block_start == EXTENT_MAP_INLINE) {
 			SetPageError(page);
 			unlock_extent(tree, cur, cur + iosize - 1);
+			finish_and_unlock_read_page(fs_info, tree, cur,
+						cur + iosize - 1, page, false);
 			cur = cur + iosize;
 			pg_offset += iosize;
 			continue;
@@ -3482,7 +3575,13 @@ static int __do_readpage(struct page *page,
 	if (!nr) {
 		if (!PageError(page))
 			SetPageUptodate(page);
-		unlock_page(page);
+		/*
+		 * Subpage case will unlock the page in
+		 * finish_and_unlock_read_page() according to the
+		 * EXTENT_READ_SUBMITTED status.
+		 */
+		if (!btrfs_is_subpage(fs_info))
+			unlock_page(page);
 	}
 	return ret;
 }
-- 
2.28.0

