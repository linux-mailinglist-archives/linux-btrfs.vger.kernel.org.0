Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 979AE374FBB
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 May 2021 09:05:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232700AbhEFHGB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 6 May 2021 03:06:01 -0400
Received: from mx2.suse.de ([195.135.220.15]:38858 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232433AbhEFHGA (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 6 May 2021 03:06:00 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1620284702; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=7242YEiyoLAR3EgY6VjcqfKT3RN2Akd2cSByo+XwMW0=;
        b=GFgfrNJYxivgHEMt/92q4NcdvSezPYrzD58Qbv7lbdwaE8SiFcWlRma2wt/56JUJBc2NIP
        CazB32s7EHuMCErO1/pQO9ttuJQXsuJFWPQ29G4FwpFesme1CRkd0IXSr9tnpSpUxWK44n
        ZyhEkQ08n5x1dEUhh8XQgDj/etzSFHQ=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 48F8FACF6
        for <linux-btrfs@vger.kernel.org>; Thu,  6 May 2021 07:05:02 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH RFC] btrfs: temporary disable inline extent creation for fallocate and reflink
Date:   Thu,  6 May 2021 15:04:58 +0800
Message-Id: <20210506070458.168945-1-wqu@suse.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Previously we disable inline extent creation completely for subpage
case, due to the fact that writeback for subpage still happens for full
page.

This makes btrfs_wait_ordered_range() trigger writeback for larger
range, thus can writeback the first sector even we don't want.

But the truth is, even for regular sectorsize, we still have a race
window there operations where fallocate and reflink can cause inline
extent being created.

For example, for the following operations:

 # xfs_io -f -c "pwrite 0 2k" -c "falloc 4k 4k" $file

The first "pwrite 0 2k" dirtied the first sector, while inode size is
updated to 2k.
At this point, if the first sector is written back, it will be inlined.

Then we enter "falloc 4k 4k" which will:
a) call btrfs_cont_expand() to insert holes
b) do the mainline to insert preallocated extents
c) call btrfs_fallocate_update_isize() to enlarge the isize

Until c), the isize is still 2K, and during that window, if the first
sector is written back due to whatever reasons (from memory pressure to
fadvice to writeback the pages), since the isize is still 2K, we will
write the first sector as inlined.

Then we have a case where we get mixed inline and regular extents.

Fix the problem by introducing a new runtime inode flag,
BTRFS_INODE_NOINLINE, to temporarily disable inline extent creation
until the isize get enlarged.

So that we don't need to disable inline extent creation completely for
subpage.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
Reason for RFC:

I'm not sure if this is the best solution, as the original race window
for regular sector has existed for a long long time.

I have also tried other solutions like switching the timing of
btrfs_cont_expand() and btrfs_wait_ordered_range(), to make
btrfs_wait_ordered_range() happens before btrfs_cont_expand().

So that we will writeback the first sector for subpage as inline, then
btrfs_cont_expand() will re-dirty the first sector.

This would solve the problem for subpage, but not the race window.

Another idea is to enlarge inode size first, but that would greatly
change the error path, may cause new regressions.

I'm all ears for advice on this problem.
---
 fs/btrfs/ctree.h         | 10 ++++++++++
 fs/btrfs/delayed-inode.c |  3 ++-
 fs/btrfs/file.c          | 19 +++++++++++++++++++
 fs/btrfs/inode.c         | 21 ++++-----------------
 fs/btrfs/reflink.c       | 14 ++++++++++++--
 fs/btrfs/root-tree.c     |  3 ++-
 fs/btrfs/tree-log.c      |  3 ++-
 7 files changed, 51 insertions(+), 22 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 7bb4212b90d3..7c74d57ad8fc 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -1488,6 +1488,16 @@ do {                                                                   \
 #define BTRFS_INODE_DIRSYNC		(1 << 10)
 #define BTRFS_INODE_COMPRESS		(1 << 11)
 
+/*
+ * Runtime bit to temporary disable inline extent creation.
+ * To prevent the first sector get written back as inline before the isize
+ * get enlarged.
+ *
+ * This flag is for runtime only, won't reach disk, thus is not included
+ * in BTRFS_INODE_FLAG_MASK.
+ */
+#define BTRFS_INODE_NOINLINE		(1 << 30)
+
 #define BTRFS_INODE_ROOT_ITEM_INIT	(1 << 31)
 
 #define BTRFS_INODE_FLAG_MASK						\
diff --git a/fs/btrfs/delayed-inode.c b/fs/btrfs/delayed-inode.c
index 1a88f6214ebc..64d931da083d 100644
--- a/fs/btrfs/delayed-inode.c
+++ b/fs/btrfs/delayed-inode.c
@@ -1717,7 +1717,8 @@ static void fill_stack_inode_item(struct btrfs_trans_handle *trans,
 				       inode_peek_iversion(inode));
 	btrfs_set_stack_inode_transid(inode_item, trans->transid);
 	btrfs_set_stack_inode_rdev(inode_item, inode->i_rdev);
-	btrfs_set_stack_inode_flags(inode_item, BTRFS_I(inode)->flags);
+	btrfs_set_stack_inode_flags(inode_item,
+			BTRFS_I(inode)->flags & BTRFS_INODE_FLAG_MASK);
 	btrfs_set_stack_inode_block_group(inode_item, 0);
 
 	btrfs_set_stack_timespec_sec(&inode_item->atime,
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 70a36852b680..a3559ce93780 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -3357,6 +3357,24 @@ static long btrfs_fallocate(struct file *file, int mode,
 			goto out;
 	}
 
+	/*
+	 * Disable inline extent creation until we enlarged the inode size.
+	 *
+	 * Since the inode size is only increased after we allocated all
+	 * extents, there are several cases to writeback the first sector,
+	 * which can be inlined, leaving inline extent mixed with regular
+	 * extents:
+	 *
+	 * - btrfs_wait_ordered_range() call for subpage case
+	 *   The writeback happens for the full page, thus can writeback
+	 *   the first sector of an inode.
+	 *
+	 * - Memory pressure
+	 *
+	 * So here we temporarily disable inline extent creation for the inode.
+	 */
+	BTRFS_I(inode)->flags |= BTRFS_INODE_NOINLINE;
+
 	/*
 	 * TODO: Move these two operations after we have checked
 	 * accurate reserved space, or fallocate can still fail but
@@ -3501,6 +3519,7 @@ static long btrfs_fallocate(struct file *file, int mode,
 	unlock_extent_cached(&BTRFS_I(inode)->io_tree, alloc_start, locked_end,
 			     &cached_state);
 out:
+	BTRFS_I(inode)->flags &= ~BTRFS_INODE_NOINLINE;
 	btrfs_inode_unlock(inode, BTRFS_ILOCK_MMAP);
 	/* Let go of our reservation. */
 	if (ret != 0 && !(mode & FALLOC_FL_ZERO_RANGE))
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 4fc6e6766234..59972cb2efce 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -666,11 +666,7 @@ static noinline int compress_file_range(struct async_chunk *async_chunk)
 		}
 	}
 cont:
-	/*
-	 * Check cow_file_range() for why we don't even try to create
-	 * inline extent for subpage case.
-	 */
-	if (start == 0 && fs_info->sectorsize == PAGE_SIZE) {
+	if (start == 0 && !(BTRFS_I(inode)->flags & BTRFS_INODE_NOINLINE)) {
 		/* lets try to make an inline extent */
 		if (ret || total_in < actual_end) {
 			/* we didn't compress the entire range, try
@@ -1068,17 +1064,7 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
 
 	inode_should_defrag(inode, start, end, num_bytes, SZ_64K);
 
-	/*
-	 * Due to the page size limit, for subpage we can only trigger the
-	 * writeback for the dirty sectors of page, that means data writeback
-	 * is doing more writeback than what we want.
-	 *
-	 * This is especially unexpected for some call sites like fallocate,
-	 * where we only increase isize after everything is done.
-	 * This means we can trigger inline extent even we didn't want.
-	 * So here we skip inline extent creation completely.
-	 */
-	if (start == 0 && fs_info->sectorsize == PAGE_SIZE) {
+	if (start == 0 && !(inode->flags & BTRFS_INODE_NOINLINE)) {
 		/* lets try to make an inline extent */
 		ret = cow_file_range_inline(inode, start, end, 0,
 					    BTRFS_COMPRESS_NONE, NULL);
@@ -3789,7 +3775,8 @@ static void fill_inode_item(struct btrfs_trans_handle *trans,
 	btrfs_set_token_inode_sequence(&token, item, inode_peek_iversion(inode));
 	btrfs_set_token_inode_transid(&token, item, trans->transid);
 	btrfs_set_token_inode_rdev(&token, item, inode->i_rdev);
-	btrfs_set_token_inode_flags(&token, item, BTRFS_I(inode)->flags);
+	btrfs_set_token_inode_flags(&token, item,
+			BTRFS_I(inode)->flags & BTRFS_INODE_FLAG_MASK);
 	btrfs_set_token_inode_block_group(&token, item, 0);
 }
 
diff --git a/fs/btrfs/reflink.c b/fs/btrfs/reflink.c
index e5680c03ead4..48f8bdd185de 100644
--- a/fs/btrfs/reflink.c
+++ b/fs/btrfs/reflink.c
@@ -701,12 +701,19 @@ static noinline int btrfs_clone_files(struct file *file, struct file *file_src,
 	if (off + len == src->i_size)
 		len = ALIGN(src->i_size, bs) - off;
 
+	/*
+	 * Temporarily disable inline extent creation, check btrfs_fallocate()
+	 * for details
+	 */
+	BTRFS_I(inode)->flags |= BTRFS_INODE_NOINLINE;
 	if (destoff > inode->i_size) {
 		const u64 wb_start = ALIGN_DOWN(inode->i_size, bs);
 
 		ret = btrfs_cont_expand(BTRFS_I(inode), inode->i_size, destoff);
-		if (ret)
+		if (ret) {
+			BTRFS_I(inode)->flags &= ~BTRFS_INODE_NOINLINE;
 			return ret;
+		}
 		/*
 		 * We may have truncated the last block if the inode's size is
 		 * not sector size aligned, so we need to wait for writeback to
@@ -718,8 +725,10 @@ static noinline int btrfs_clone_files(struct file *file, struct file *file_src,
 		 */
 		ret = btrfs_wait_ordered_range(inode, wb_start,
 					       destoff - wb_start);
-		if (ret)
+		if (ret) {
+			BTRFS_I(inode)->flags &= ~BTRFS_INODE_NOINLINE;
 			return ret;
+		}
 	}
 
 	/*
@@ -745,6 +754,7 @@ static noinline int btrfs_clone_files(struct file *file, struct file *file_src,
 				round_down(destoff, PAGE_SIZE),
 				round_up(destoff + len, PAGE_SIZE) - 1);
 
+	BTRFS_I(inode)->flags &= ~BTRFS_INODE_NOINLINE;
 	return ret;
 }
 
diff --git a/fs/btrfs/root-tree.c b/fs/btrfs/root-tree.c
index 702dc5441f03..5ce3a1dfaf3f 100644
--- a/fs/btrfs/root-tree.c
+++ b/fs/btrfs/root-tree.c
@@ -447,7 +447,8 @@ void btrfs_check_and_init_root_item(struct btrfs_root_item *root_item)
 
 	if (!(inode_flags & BTRFS_INODE_ROOT_ITEM_INIT)) {
 		inode_flags |= BTRFS_INODE_ROOT_ITEM_INIT;
-		btrfs_set_stack_inode_flags(&root_item->inode, inode_flags);
+		btrfs_set_stack_inode_flags(&root_item->inode,
+				inode_flags & BTRFS_INODE_FLAG_MASK);
 		btrfs_set_root_flags(root_item, 0);
 		btrfs_set_root_limit(root_item, 0);
 	}
diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index c1353b84ae54..f7e6abfc89c0 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -3943,7 +3943,8 @@ static void fill_inode_item(struct btrfs_trans_handle *trans,
 	btrfs_set_token_inode_sequence(&token, item, inode_peek_iversion(inode));
 	btrfs_set_token_inode_transid(&token, item, trans->transid);
 	btrfs_set_token_inode_rdev(&token, item, inode->i_rdev);
-	btrfs_set_token_inode_flags(&token, item, BTRFS_I(inode)->flags);
+	btrfs_set_token_inode_flags(&token, item,
+			BTRFS_I(inode)->flags & BTRFS_INODE_FLAG_MASK);
 	btrfs_set_token_inode_block_group(&token, item, 0);
 }
 
-- 
2.31.1

