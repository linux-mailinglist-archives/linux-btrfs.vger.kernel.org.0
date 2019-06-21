Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A7ED14EB7A
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Jun 2019 17:03:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726052AbfFUPC6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 21 Jun 2019 11:02:58 -0400
Received: from mx2.suse.de ([195.135.220.15]:34958 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726018AbfFUPC6 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 21 Jun 2019 11:02:58 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A4422AFA5
        for <linux-btrfs@vger.kernel.org>; Fri, 21 Jun 2019 15:02:56 +0000 (UTC)
Date:   Fri, 21 Jun 2019 10:02:54 -0500
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: Evaluate io_tree in find_lock_delalloc_range()
Message-ID: <20190621150254.kql745ulwzqginhc@fiona>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20180716
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Simplification.
No point passing the tree variable when it can be evaluated
from inode. The tests now use the io_tree from btrfs_inode
as opposed to creating one.

Changes since v1:
 - included btrfs sanity tests

Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
---
 fs/btrfs/extent_io.c             |  6 ++----
 fs/btrfs/extent_io.h             |  2 +-
 fs/btrfs/tests/extent-io-tests.c | 30 ++++++++++++++++--------------
 3 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index db337e53aab3..e9475d7e11bf 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -1719,10 +1719,10 @@ static noinline int lock_delalloc_pages(struct inode *inode,
  */
 EXPORT_FOR_TESTS
 noinline_for_stack bool find_lock_delalloc_range(struct inode *inode,
-				    struct extent_io_tree *tree,
 				    struct page *locked_page, u64 *start,
 				    u64 *end)
 {
+	struct extent_io_tree *tree = &BTRFS_I(inode)->io_tree;
 	u64 max_bytes = BTRFS_MAX_EXTENT_SIZE;
 	u64 delalloc_start;
 	u64 delalloc_end;
@@ -3290,7 +3290,6 @@ static noinline_for_stack int writepage_delalloc(struct inode *inode,
 		struct page *page, struct writeback_control *wbc,
 		u64 delalloc_start, unsigned long *nr_written)
 {
-	struct extent_io_tree *tree = &BTRFS_I(inode)->io_tree;
 	u64 page_end = delalloc_start + PAGE_SIZE - 1;
 	bool found;
 	u64 delalloc_to_write = 0;
@@ -3300,8 +3299,7 @@ static noinline_for_stack int writepage_delalloc(struct inode *inode,
 
 
 	while (delalloc_end < page_end) {
-		found = find_lock_delalloc_range(inode, tree,
-					       page,
+		found = find_lock_delalloc_range(inode, page,
 					       &delalloc_start,
 					       &delalloc_end);
 		if (!found) {
diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
index aa18a16a6ed7..2919c3be1933 100644
--- a/fs/btrfs/extent_io.h
+++ b/fs/btrfs/extent_io.h
@@ -549,7 +549,7 @@ int free_io_failure(struct extent_io_tree *failure_tree,
 		    struct extent_io_tree *io_tree,
 		    struct io_failure_record *rec);
 #ifdef CONFIG_BTRFS_FS_RUN_SANITY_TESTS
-bool find_lock_delalloc_range(struct inode *inode, struct extent_io_tree *tree,
+bool find_lock_delalloc_range(struct inode *inode,
 			     struct page *locked_page, u64 *start,
 			     u64 *end);
 #endif
diff --git a/fs/btrfs/tests/extent-io-tests.c b/fs/btrfs/tests/extent-io-tests.c
index 7bf4d5734dbe..0518aeb4ba95 100644
--- a/fs/btrfs/tests/extent-io-tests.c
+++ b/fs/btrfs/tests/extent-io-tests.c
@@ -10,6 +10,7 @@
 #include "btrfs-tests.h"
 #include "../ctree.h"
 #include "../extent_io.h"
+#include "../btrfs_inode.h"
 
 #define PROCESS_UNLOCK		(1 << 0)
 #define PROCESS_RELEASE		(1 << 1)
@@ -58,7 +59,7 @@ static noinline int process_page_range(struct inode *inode, u64 start, u64 end,
 static int test_find_delalloc(u32 sectorsize)
 {
 	struct inode *inode;
-	struct extent_io_tree tmp;
+	struct extent_io_tree *tmp;
 	struct page *page;
 	struct page *locked_page = NULL;
 	unsigned long index = 0;
@@ -76,12 +77,13 @@ static int test_find_delalloc(u32 sectorsize)
 		test_std_err(TEST_ALLOC_INODE);
 		return -ENOMEM;
 	}
+	tmp = &BTRFS_I(inode)->io_tree;
 
 	/*
 	 * Passing NULL as we don't have fs_info but tracepoints are not used
 	 * at this point
 	 */
-	extent_io_tree_init(NULL, &tmp, IO_TREE_SELFTEST, NULL);
+	extent_io_tree_init(NULL, tmp, IO_TREE_SELFTEST, NULL);
 
 	/*
 	 * First go through and create and mark all of our pages dirty, we pin
@@ -108,10 +110,10 @@ static int test_find_delalloc(u32 sectorsize)
 	 * |--- delalloc ---|
 	 * |---  search  ---|
 	 */
-	set_extent_delalloc(&tmp, 0, sectorsize - 1, 0, NULL);
+	set_extent_delalloc(tmp, 0, sectorsize - 1, 0, NULL);
 	start = 0;
 	end = 0;
-	found = find_lock_delalloc_range(inode, &tmp, locked_page, &start,
+	found = find_lock_delalloc_range(inode, locked_page, &start,
 					 &end);
 	if (!found) {
 		test_err("should have found at least one delalloc");
@@ -122,7 +124,7 @@ static int test_find_delalloc(u32 sectorsize)
 			sectorsize - 1, start, end);
 		goto out_bits;
 	}
-	unlock_extent(&tmp, start, end);
+	unlock_extent(tmp, start, end);
 	unlock_page(locked_page);
 	put_page(locked_page);
 
@@ -139,10 +141,10 @@ static int test_find_delalloc(u32 sectorsize)
 		test_err("couldn't find the locked page");
 		goto out_bits;
 	}
-	set_extent_delalloc(&tmp, sectorsize, max_bytes - 1, 0, NULL);
+	set_extent_delalloc(tmp, sectorsize, max_bytes - 1, 0, NULL);
 	start = test_start;
 	end = 0;
-	found = find_lock_delalloc_range(inode, &tmp, locked_page, &start,
+	found = find_lock_delalloc_range(inode, locked_page, &start,
 					 &end);
 	if (!found) {
 		test_err("couldn't find delalloc in our range");
@@ -158,7 +160,7 @@ static int test_find_delalloc(u32 sectorsize)
 		test_err("there were unlocked pages in the range");
 		goto out_bits;
 	}
-	unlock_extent(&tmp, start, end);
+	unlock_extent(tmp, start, end);
 	/* locked_page was unlocked above */
 	put_page(locked_page);
 
@@ -176,7 +178,7 @@ static int test_find_delalloc(u32 sectorsize)
 	}
 	start = test_start;
 	end = 0;
-	found = find_lock_delalloc_range(inode, &tmp, locked_page, &start,
+	found = find_lock_delalloc_range(inode, locked_page, &start,
 					 &end);
 	if (found) {
 		test_err("found range when we shouldn't have");
@@ -194,10 +196,10 @@ static int test_find_delalloc(u32 sectorsize)
 	 *
 	 * We are re-using our test_start from above since it works out well.
 	 */
-	set_extent_delalloc(&tmp, max_bytes, total_dirty - 1, 0, NULL);
+	set_extent_delalloc(tmp, max_bytes, total_dirty - 1, 0, NULL);
 	start = test_start;
 	end = 0;
-	found = find_lock_delalloc_range(inode, &tmp, locked_page, &start,
+	found = find_lock_delalloc_range(inode, locked_page, &start,
 					 &end);
 	if (!found) {
 		test_err("didn't find our range");
@@ -213,7 +215,7 @@ static int test_find_delalloc(u32 sectorsize)
 		test_err("pages in range were not all locked");
 		goto out_bits;
 	}
-	unlock_extent(&tmp, start, end);
+	unlock_extent(tmp, start, end);
 
 	/*
 	 * Now to test where we run into a page that is no longer dirty in the
@@ -238,7 +240,7 @@ static int test_find_delalloc(u32 sectorsize)
 	 * this changes at any point in the future we will need to fix this
 	 * tests expected behavior.
 	 */
-	found = find_lock_delalloc_range(inode, &tmp, locked_page, &start,
+	found = find_lock_delalloc_range(inode, locked_page, &start,
 					 &end);
 	if (!found) {
 		test_err("didn't find our range");
@@ -256,7 +258,7 @@ static int test_find_delalloc(u32 sectorsize)
 	}
 	ret = 0;
 out_bits:
-	clear_extent_bits(&tmp, 0, total_dirty - 1, (unsigned)-1);
+	clear_extent_bits(tmp, 0, total_dirty - 1, (unsigned)-1);
 out:
 	if (locked_page)
 		put_page(locked_page);
-- 
2.16.4


-- 
Goldwyn
