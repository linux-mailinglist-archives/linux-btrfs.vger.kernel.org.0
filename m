Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79B0B2578C6
	for <lists+linux-btrfs@lfdr.de>; Mon, 31 Aug 2020 13:54:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727799AbgHaLyH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 31 Aug 2020 07:54:07 -0400
Received: from mx2.suse.de ([195.135.220.15]:40246 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727077AbgHaLyE (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 31 Aug 2020 07:54:04 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 85D39B814;
        Mon, 31 Aug 2020 11:53:54 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 04/12] btrfs: Make btrfs_dec_test_ordered_pending take btrfs_inode
Date:   Mon, 31 Aug 2020 14:42:41 +0300
Message-Id: <20200831114249.8360-5-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200831114249.8360-1-nborisov@suse.com>
References: <20200831114249.8360-1-nborisov@suse.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/inode.c        | 8 ++++----
 fs/btrfs/ordered-data.c | 7 +++----
 fs/btrfs/ordered-data.h | 2 +-
 3 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 74321962cd0f..41e56ccf691d 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -2765,8 +2765,8 @@ void btrfs_writepage_endio_finish_ordered(struct page *page, u64 start,
 	trace_btrfs_writepage_end_io_hook(page, start, end, uptodate);
 
 	ClearPagePrivate2(page);
-	if (!btrfs_dec_test_ordered_pending(inode, &ordered_extent, start,
-					    end - start + 1, uptodate))
+	if (!btrfs_dec_test_ordered_pending(BTRFS_I(inode), &ordered_extent,
+					    start, end - start + 1, uptodate))
 		return;
 
 	if (btrfs_is_free_space_inode(BTRFS_I(inode)))
@@ -8112,8 +8112,8 @@ static void btrfs_invalidatepage(struct page *page, unsigned int offset,
 				ordered->truncated_len = new_len;
 			spin_unlock_irq(&tree->lock);
 
-			if (btrfs_dec_test_ordered_pending(inode, &ordered,
-							   start,
+			if (btrfs_dec_test_ordered_pending(BTRFS_I(inode),
+							   &ordered, start,
 							   end - start + 1, 1))
 				btrfs_finish_ordered_io(ordered);
 		}
diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
index 369ddad30d9c..168a5edd939d 100644
--- a/fs/btrfs/ordered-data.c
+++ b/fs/btrfs/ordered-data.c
@@ -378,17 +378,16 @@ int btrfs_dec_test_first_ordered_pending(struct btrfs_inode *inode,
  * test_and_set_bit on a flag in the struct btrfs_ordered_extent is used
  * to make sure this function only returns 1 once for a given ordered extent.
  */
-int btrfs_dec_test_ordered_pending(struct inode *inode,
+int btrfs_dec_test_ordered_pending(struct btrfs_inode *inode,
 				   struct btrfs_ordered_extent **cached,
 				   u64 file_offset, u64 io_size, int uptodate)
 {
-	struct btrfs_ordered_inode_tree *tree;
+	struct btrfs_ordered_inode_tree *tree = &inode->ordered_tree;
 	struct rb_node *node;
 	struct btrfs_ordered_extent *entry = NULL;
 	unsigned long flags;
 	int ret;
 
-	tree = &BTRFS_I(inode)->ordered_tree;
 	spin_lock_irqsave(&tree->lock, flags);
 	if (cached && *cached) {
 		entry = *cached;
@@ -409,7 +408,7 @@ int btrfs_dec_test_ordered_pending(struct inode *inode,
 	}
 
 	if (io_size > entry->bytes_left) {
-		btrfs_crit(BTRFS_I(inode)->root->fs_info,
+		btrfs_crit(inode->root->fs_info,
 			   "bad ordered accounting left %llu size %llu",
 		       entry->bytes_left, io_size);
 	}
diff --git a/fs/btrfs/ordered-data.h b/fs/btrfs/ordered-data.h
index b287a2a403e6..1610195c6097 100644
--- a/fs/btrfs/ordered-data.h
+++ b/fs/btrfs/ordered-data.h
@@ -153,7 +153,7 @@ btrfs_ordered_inode_tree_init(struct btrfs_ordered_inode_tree *t)
 void btrfs_put_ordered_extent(struct btrfs_ordered_extent *entry);
 void btrfs_remove_ordered_extent(struct inode *inode,
 				struct btrfs_ordered_extent *entry);
-int btrfs_dec_test_ordered_pending(struct inode *inode,
+int btrfs_dec_test_ordered_pending(struct btrfs_inode *inode,
 				   struct btrfs_ordered_extent **cached,
 				   u64 file_offset, u64 io_size, int uptodate);
 int btrfs_dec_test_first_ordered_pending(struct btrfs_inode *inode,
-- 
2.17.1

