Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91F4A2B1B5B
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Nov 2020 13:52:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726494AbgKMMwL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 13 Nov 2020 07:52:11 -0500
Received: from mx2.suse.de ([195.135.220.15]:46458 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726493AbgKMMwK (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 13 Nov 2020 07:52:10 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1605271929; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vHFiuJ/88gnoa4wltaOA9wAZJAkYFiy2zgGhWSoO9oU=;
        b=l9Sja1Oq+A8xRAYUFeGWR6lsIETeO8H/1BtYQ4Vx3hiGfhs8XllONZ2Rj6GfuPJVo5w4wX
        eOBJL9eNRMH4lbycohH42DVdHAG/R5uZxIz+/xv+onncLkH43ce+4C6eqY+CWsD04VQjQ5
        K9WC93kLmzsM0mZE6grr51f90jKysJM=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 2F47BABD9
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Nov 2020 12:52:09 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 03/24] btrfs: extent_io: replace extent_start/extent_len with better structure for end_bio_extent_readpage()
Date:   Fri, 13 Nov 2020 20:51:28 +0800
Message-Id: <20201113125149.140836-4-wqu@suse.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201113125149.140836-1-wqu@suse.com>
References: <20201113125149.140836-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

In end_bio_extent_readpage() we had a strange dance around
extent_start/extent_len.

Hides behind the strange dance is, it's just calling
endio_readpage_release_extent() on each bvec range.

Here is an example to explain the original work flow:
  Bio is for inode 257, containing 2 pages, for range [1M, 1M+8K)

  end_bio_extent_extent_readpage() entered
  |- extent_start = 0;
  |- extent_end = 0;
  |- bio_for_each_segment_all() {
  |  |- /* Got the 1st bvec */
  |  |- start = SZ_1M;
  |  |- end = SZ_1M + SZ_4K - 1;
  |  |- update = 1;
  |  |- if (extent_len == 0) {
  |  |  |- extent_start = start; /* SZ_1M */
  |  |  |- extent_len = end + 1 - start; /* SZ_1M */
  |  |  }
  |  |
  |  |- /* Got the 2nd bvec */
  |  |- start = SZ_1M + 4K;
  |  |- end = SZ_1M + 4K - 1;
  |  |- update = 1;
  |  |- if (extent_start + extent_len == start) {
  |  |  |- extent_len += end + 1 - start; /* SZ_8K */
  |  |  }
  |  } /* All bio vec iterated */
  |
  |- if (extent_len) {
     |- endio_readpage_release_extent(tree, extent_start, extent_len,
				      update);
	/* extent_start == SZ_1M, extent_len == SZ_8K, uptodate = 1 */

As the above flow shows, the existing code in end_bio_extent_readpage()
is just accumulate extent_start/extent_len, and when the contiguous range
breaks, call endio_readpage_release_extent() for the range.

However current behavior has something not really considered:
- The inode can change
  For bio, their pages don't need to have contig page_offset.
  This means, even pages from different inode can be packed into one
  bio.

- Bvec cross page boundary
  There is a feature called multi-page bvec, where bvec->bv_len can go
  beyond bvec->bv_page boundary.

- Poor readability

This patch will address the problem by:
- Introduce a proper structure, processed_extent, to record processed
  extent range
- Integrate inode/start/end/uptodate check into
  endio_readpage_release_extent()
- Add more comment on each step.
  This should greatly improve the readability, now in
  end_bio_extent_readpage() there are only two
  endio_readpage_release_extent() calls.

- Add inode contig check
  Now we also ensure the inode is the same before checking the range
  contig.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent_io.c | 102 +++++++++++++++++++++++++++++--------------
 1 file changed, 69 insertions(+), 33 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 3bbb3bdd395b..b5b3700943e0 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2779,16 +2779,74 @@ static void end_bio_extent_writepage(struct bio *bio)
 	bio_put(bio);
 }
 
+/*
+ * Records previously processed extent range.
+ *
+ * For endio_readpage_release_extent() to handle a full extent range, reducing
+ * the extent io operations.
+ */
+struct processed_extent {
+	struct btrfs_inode *inode;
+	u64 start;	/* file offset in @inode */
+	u64 end;	/* file offset in @inode */
+	bool uptodate;
+};
+
+/*
+ * Try to release processed extent range.
+ *
+ * May not release the extent range right now if the current range is contig
+ * with processed extent.
+ *
+ * Will release processed extent when any of @inode, @uptodate, the range is
+ * no longer contig with processed range.
+ * Pass @inode == NULL will force processed extent to be released.
+ */
 static void
-endio_readpage_release_extent(struct extent_io_tree *tree, u64 start, u64 len,
-			      int uptodate)
+endio_readpage_release_extent(struct processed_extent *processed,
+			      struct btrfs_inode *inode, u64 start, u64 end,
+			      bool uptodate)
 {
 	struct extent_state *cached = NULL;
-	u64 end = start + len - 1;
+	struct extent_io_tree *tree;
 
-	if (uptodate && tree->track_uptodate)
-		set_extent_uptodate(tree, start, end, &cached, GFP_ATOMIC);
-	unlock_extent_cached_atomic(tree, start, end, &cached);
+	/* We're the first extent, initialize @processed */
+	if (!processed->inode)
+		goto update;
+
+	/*
+	 * Contig with processed extent. Just uptodate the end
+	 *
+	 * Several things to notice:
+	 * - Bio can be merged as long as on-disk bytenr is contig
+	 *   This means we can have page belonging to other inodes, thus need to
+	 *   check if the inode matches.
+	 * - Bvec can contain range beyond current page for multi-page bvec
+	 *   Thus we need to do processed->end + 1 >= start check
+	 */
+	if (processed->inode == inode && processed->uptodate == uptodate &&
+	    processed->end + 1 >= start && end >= processed->end) {
+		processed->end = end;
+		return;
+	}
+
+	tree = &processed->inode->io_tree;
+	/*
+	 * Now we have a range not contig with processed range, release the
+	 * processed range now.
+	 */
+	if (processed->uptodate && tree->track_uptodate)
+		set_extent_uptodate(tree, processed->start, processed->end,
+				    &cached, GFP_ATOMIC);
+	unlock_extent_cached_atomic(tree, processed->start, processed->end,
+				    &cached);
+
+update:
+	/* Update @processed to current range */
+	processed->inode = inode;
+	processed->start = start;
+	processed->end = end;
+	processed->uptodate = uptodate;
 }
 
 /*
@@ -2808,12 +2866,11 @@ static void end_bio_extent_readpage(struct bio *bio)
 	int uptodate = !bio->bi_status;
 	struct btrfs_io_bio *io_bio = btrfs_io_bio(bio);
 	struct extent_io_tree *tree, *failure_tree;
+	struct processed_extent processed = { 0 };
 	u64 offset = 0;
 	u64 start;
 	u64 end;
 	u64 len;
-	u64 extent_start = 0;
-	u64 extent_len = 0;
 	int mirror;
 	int ret;
 	struct bvec_iter_all iter_all;
@@ -2922,32 +2979,11 @@ static void end_bio_extent_readpage(struct bio *bio)
 		unlock_page(page);
 		offset += len;
 
-		if (unlikely(!uptodate)) {
-			if (extent_len) {
-				endio_readpage_release_extent(tree,
-							      extent_start,
-							      extent_len, 1);
-				extent_start = 0;
-				extent_len = 0;
-			}
-			endio_readpage_release_extent(tree, start,
-						      end - start + 1, 0);
-		} else if (!extent_len) {
-			extent_start = start;
-			extent_len = end + 1 - start;
-		} else if (extent_start + extent_len == start) {
-			extent_len += end + 1 - start;
-		} else {
-			endio_readpage_release_extent(tree, extent_start,
-						      extent_len, uptodate);
-			extent_start = start;
-			extent_len = end + 1 - start;
-		}
+		endio_readpage_release_extent(&processed, BTRFS_I(inode),
+					      start, end, uptodate);
 	}
-
-	if (extent_len)
-		endio_readpage_release_extent(tree, extent_start, extent_len,
-					      uptodate);
+	/* Release the last extent */
+	endio_readpage_release_extent(&processed, NULL, 0, 0, 0);
 	btrfs_io_bio_free_csum(io_bio);
 	bio_put(bio);
 }
-- 
2.29.2

