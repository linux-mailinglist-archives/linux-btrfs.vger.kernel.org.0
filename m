Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 649F3351110
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Apr 2021 10:46:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233383AbhDAIpV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 1 Apr 2021 04:45:21 -0400
Received: from mx2.suse.de ([195.135.220.15]:52222 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232565AbhDAIow (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 1 Apr 2021 04:44:52 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1617266665; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=4MeJJ+p6s8QnUktoUjxRFKA6kdQxweogSBJI/jlu8lg=;
        b=BaJEDqgWIDw6/X7ed6rhaH6TjOn3t24Kk8URnQlVoytLHaIvia/EojIcUfdBxzM30PfJbt
        MO9WsZghWEWZGU3EGBxoHcLsfZub/kfG4TjHqrzIB+Ssln+xfY0GBwf2Cf32mcXfEcyG9/
        k0EaZoJ8e+s71udXI5NmzF1+qDWb/WY=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B19C0AE86
        for <linux-btrfs@vger.kernel.org>; Thu,  1 Apr 2021 08:44:25 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2] btrfs: use u32 for length related members of btrfs_ordered_extent
Date:   Thu,  1 Apr 2021 16:44:21 +0800
Message-Id: <20210401084421.96162-1-wqu@suse.com>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Unlike btrfs_file_extent_item, btrfs_ordered_extent has its length
limit (BTRFS_MAX_EXTENT_SIZE), which is far smaller than U32_MAX.

Using u64 for those length related members are just a waste of memory.

This patch will make the following members u32:
- num_bytes
- disk_num_bytes
- bytes_left
- truncated_len

This will save 16 bytes for btrfs_ordered_extent structure.

For btrfs_add_ordered_extent*() call sites, they are mostly deeply
inside other functions passing u64.
Thus this patch will keep those u64, but do internal ASSERT() to ensure
the correct length values are passed in.

For btrfs_dec_test_.*_ordered_extent() call sites, length related
parameters are converted to u32, with extra ASSERT() added to ensure we
get correct values passed in.

There is special convert needed in btrfs_remove_ordered_extent(), which
needs s64, using "-entry->num_bytes" from u32 directly will cause
underflow.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
Changelog:
v2:
- Fix a underflow caused by incorrect convert from u32 to s64
  This would cause error messages like
  "BTRFS info (device dm-3): at unmount dio bytes count 14478334754816"
  However this error message doesn't trigger any kernel calltrace, thus
  not exposed by previous fstests run.
---
 fs/btrfs/inode.c        |  8 ++++++--
 fs/btrfs/ordered-data.c | 21 ++++++++++++++-------
 fs/btrfs/ordered-data.h | 25 ++++++++++++++-----------
 3 files changed, 34 insertions(+), 20 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 9b87c3e4fa7b..0113598e6ba1 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -3070,6 +3070,7 @@ void btrfs_writepage_endio_finish_ordered(struct page *page, u64 start,
 	struct btrfs_ordered_extent *ordered_extent = NULL;
 	struct btrfs_workqueue *wq;
 
+	ASSERT(end + 1 - start < U32_MAX);
 	trace_btrfs_writepage_end_io_hook(page, start, end, uptodate);
 
 	ClearPagePrivate2(page);
@@ -7969,6 +7970,7 @@ static void __endio_write_update_ordered(struct btrfs_inode *inode,
 	else
 		wq = fs_info->endio_write_workers;
 
+	ASSERT(bytes < U32_MAX);
 	while (ordered_offset < offset + bytes) {
 		last_offset = ordered_offset;
 		if (btrfs_dec_test_first_ordered_pending(inode, &ordered,
@@ -8415,10 +8417,12 @@ static void btrfs_invalidatepage(struct page *page, unsigned int offset,
 		if (TestClearPagePrivate2(page)) {
 			spin_lock_irq(&inode->ordered_tree.lock);
 			set_bit(BTRFS_ORDERED_TRUNCATED, &ordered->flags);
-			ordered->truncated_len = min(ordered->truncated_len,
+			ASSERT(start - ordered->file_offset < U32_MAX);
+			ordered->truncated_len = min_t(u32, ordered->truncated_len,
 					start - ordered->file_offset);
 			spin_unlock_irq(&inode->ordered_tree.lock);
 
+			ASSERT(end - start + 1 < U32_MAX);
 			if (btrfs_dec_test_ordered_pending(inode, &ordered,
 							   start,
 							   end - start + 1, 1)) {
@@ -8937,7 +8941,7 @@ void btrfs_destroy_inode(struct inode *vfs_inode)
 			break;
 		else {
 			btrfs_err(root->fs_info,
-				  "found ordered extent %llu %llu on inode cleanup",
+				  "found ordered extent %llu %u on inode cleanup",
 				  ordered->file_offset, ordered->num_bytes);
 			btrfs_remove_ordered_extent(inode, ordered);
 			btrfs_put_ordered_extent(ordered);
diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
index 07b0b4218791..8e6d9d906bdd 100644
--- a/fs/btrfs/ordered-data.c
+++ b/fs/btrfs/ordered-data.c
@@ -160,6 +160,12 @@ static int __btrfs_add_ordered_extent(struct btrfs_inode *inode, u64 file_offset
 	struct btrfs_ordered_extent *entry;
 	int ret;
 
+	/*
+	 * Basic size check, all length related members should be smaller
+	 * than U32_MAX.
+	 */
+	ASSERT(num_bytes < U32_MAX && disk_num_bytes < U32_MAX);
+
 	if (type == BTRFS_ORDERED_NOCOW || type == BTRFS_ORDERED_PREALLOC) {
 		/* For nocow write, we can release the qgroup rsv right now */
 		ret = btrfs_qgroup_free_data(inode, NULL, file_offset, num_bytes);
@@ -186,7 +192,7 @@ static int __btrfs_add_ordered_extent(struct btrfs_inode *inode, u64 file_offset
 	entry->bytes_left = num_bytes;
 	entry->inode = igrab(&inode->vfs_inode);
 	entry->compress_type = compress_type;
-	entry->truncated_len = (u64)-1;
+	entry->truncated_len = (u32)-1;
 	entry->qgroup_rsv = ret;
 	entry->physical = (u64)-1;
 	entry->disk = NULL;
@@ -320,7 +326,7 @@ void btrfs_add_ordered_sum(struct btrfs_ordered_extent *entry,
  */
 bool btrfs_dec_test_first_ordered_pending(struct btrfs_inode *inode,
 				   struct btrfs_ordered_extent **finished_ret,
-				   u64 *file_offset, u64 io_size, int uptodate)
+				   u64 *file_offset, u32 io_size, int uptodate)
 {
 	struct btrfs_fs_info *fs_info = inode->root->fs_info;
 	struct btrfs_ordered_inode_tree *tree = &inode->ordered_tree;
@@ -330,7 +336,7 @@ bool btrfs_dec_test_first_ordered_pending(struct btrfs_inode *inode,
 	unsigned long flags;
 	u64 dec_end;
 	u64 dec_start;
-	u64 to_dec;
+	u32 to_dec;
 
 	spin_lock_irqsave(&tree->lock, flags);
 	node = tree_search(tree, *file_offset);
@@ -352,7 +358,7 @@ bool btrfs_dec_test_first_ordered_pending(struct btrfs_inode *inode,
 	to_dec = dec_end - dec_start;
 	if (to_dec > entry->bytes_left) {
 		btrfs_crit(fs_info,
-			   "bad ordered accounting left %llu size %llu",
+			   "bad ordered accounting left %u size %u",
 			   entry->bytes_left, to_dec);
 	}
 	entry->bytes_left -= to_dec;
@@ -397,7 +403,7 @@ bool btrfs_dec_test_first_ordered_pending(struct btrfs_inode *inode,
  */
 bool btrfs_dec_test_ordered_pending(struct btrfs_inode *inode,
 				    struct btrfs_ordered_extent **cached,
-				    u64 file_offset, u64 io_size, int uptodate)
+				    u64 file_offset, u32 io_size, int uptodate)
 {
 	struct btrfs_ordered_inode_tree *tree = &inode->ordered_tree;
 	struct rb_node *node;
@@ -422,7 +428,7 @@ bool btrfs_dec_test_ordered_pending(struct btrfs_inode *inode,
 
 	if (io_size > entry->bytes_left)
 		btrfs_crit(inode->root->fs_info,
-			   "bad ordered accounting left %llu size %llu",
+			   "bad ordered accounting left %u size %u",
 		       entry->bytes_left, io_size);
 
 	entry->bytes_left -= io_size;
@@ -495,7 +501,8 @@ void btrfs_remove_ordered_extent(struct btrfs_inode *btrfs_inode,
 		btrfs_delalloc_release_metadata(btrfs_inode, entry->num_bytes,
 						false);
 
-	percpu_counter_add_batch(&fs_info->ordered_bytes, -entry->num_bytes,
+	percpu_counter_add_batch(&fs_info->ordered_bytes,
+				 -(s64)entry->num_bytes,
 				 fs_info->delalloc_batch);
 
 	tree = &btrfs_inode->ordered_tree;
diff --git a/fs/btrfs/ordered-data.h b/fs/btrfs/ordered-data.h
index e60c07f36427..6906df0c946c 100644
--- a/fs/btrfs/ordered-data.h
+++ b/fs/btrfs/ordered-data.h
@@ -83,13 +83,22 @@ struct btrfs_ordered_extent {
 	/*
 	 * These fields directly correspond to the same fields in
 	 * btrfs_file_extent_item.
+	 *
+	 * But since ordered extents can't be larger than BTRFS_MAX_EXTENT_SIZE,
+	 * for length related members, they can use u32.
 	 */
 	u64 disk_bytenr;
-	u64 num_bytes;
-	u64 disk_num_bytes;
+	u32 num_bytes;
+	u32 disk_num_bytes;
 
 	/* number of bytes that still need writing */
-	u64 bytes_left;
+	u32 bytes_left;
+
+	/*
+	 * If we get truncated we need to adjust the file extent we enter for
+	 * this ordered extent so that we do not expose stale data.
+	 */
+	u32 truncated_len;
 
 	/*
 	 * the end of the ordered extent which is behind it but
@@ -98,12 +107,6 @@ struct btrfs_ordered_extent {
 	 */
 	u64 outstanding_isize;
 
-	/*
-	 * If we get truncated we need to adjust the file extent we enter for
-	 * this ordered extent so that we do not expose stale data.
-	 */
-	u64 truncated_len;
-
 	/* flags (described above) */
 	unsigned long flags;
 
@@ -174,10 +177,10 @@ void btrfs_remove_ordered_extent(struct btrfs_inode *btrfs_inode,
 				struct btrfs_ordered_extent *entry);
 bool btrfs_dec_test_ordered_pending(struct btrfs_inode *inode,
 				    struct btrfs_ordered_extent **cached,
-				    u64 file_offset, u64 io_size, int uptodate);
+				    u64 file_offset, u32 io_size, int uptodate);
 bool btrfs_dec_test_first_ordered_pending(struct btrfs_inode *inode,
 				   struct btrfs_ordered_extent **finished_ret,
-				   u64 *file_offset, u64 io_size,
+				   u64 *file_offset, u32 io_size,
 				   int uptodate);
 int btrfs_add_ordered_extent(struct btrfs_inode *inode, u64 file_offset,
 			     u64 disk_bytenr, u64 num_bytes, u64 disk_num_bytes,
-- 
2.30.1

