Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBDBA2578BE
	for <lists+linux-btrfs@lfdr.de>; Mon, 31 Aug 2020 13:53:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727046AbgHaLxx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 31 Aug 2020 07:53:53 -0400
Received: from mx2.suse.de ([195.135.220.15]:38494 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726814AbgHaLxw (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 31 Aug 2020 07:53:52 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 577DEB7BF;
        Mon, 31 Aug 2020 11:53:49 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 06/12] btrfs: Make btrfs_invalidatepage work on btrfs_inode
Date:   Mon, 31 Aug 2020 14:42:43 +0300
Message-Id: <20200831114249.8360-7-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200831114249.8360-1-nborisov@suse.com>
References: <20200831114249.8360-1-nborisov@suse.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/inode.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 41e56ccf691d..0621fbbd08be 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -8052,15 +8052,15 @@ static int btrfs_migratepage(struct address_space *mapping,
 static void btrfs_invalidatepage(struct page *page, unsigned int offset,
 				 unsigned int length)
 {
-	struct inode *inode = page->mapping->host;
-	struct extent_io_tree *tree;
+	struct btrfs_inode *inode = BTRFS_I(page->mapping->host);
+	struct extent_io_tree *tree = &inode->io_tree;
 	struct btrfs_ordered_extent *ordered;
 	struct extent_state *cached_state = NULL;
 	u64 page_start = page_offset(page);
 	u64 page_end = page_start + PAGE_SIZE - 1;
 	u64 start;
 	u64 end;
-	int inode_evicting = inode->i_state & I_FREEING;
+	int inode_evicting = inode->vfs_inode.i_state & I_FREEING;
 
 	/*
 	 * we have the page locked, so new writeback can't start,
@@ -8071,7 +8071,6 @@ static void btrfs_invalidatepage(struct page *page, unsigned int offset,
 	 */
 	wait_on_page_writeback(page);
 
-	tree = &BTRFS_I(inode)->io_tree;
 	if (offset) {
 		btrfs_releasepage(page, GFP_NOFS);
 		return;
@@ -8081,8 +8080,7 @@ static void btrfs_invalidatepage(struct page *page, unsigned int offset,
 		lock_extent_bits(tree, page_start, page_end, &cached_state);
 again:
 	start = page_start;
-	ordered = btrfs_lookup_ordered_range(BTRFS_I(inode), start,
-					page_end - start + 1);
+	ordered = btrfs_lookup_ordered_range(inode, start, page_end - start + 1);
 	if (ordered) {
 		end = min(page_end,
 			  ordered->file_offset + ordered->num_bytes - 1);
@@ -8103,7 +8101,7 @@ static void btrfs_invalidatepage(struct page *page, unsigned int offset,
 			struct btrfs_ordered_inode_tree *tree;
 			u64 new_len;
 
-			tree = &BTRFS_I(inode)->ordered_tree;
+			tree = &inode->ordered_tree;
 
 			spin_lock_irq(&tree->lock);
 			set_bit(BTRFS_ORDERED_TRUNCATED, &ordered->flags);
@@ -8112,8 +8110,8 @@ static void btrfs_invalidatepage(struct page *page, unsigned int offset,
 				ordered->truncated_len = new_len;
 			spin_unlock_irq(&tree->lock);
 
-			if (btrfs_dec_test_ordered_pending(BTRFS_I(inode),
-							   &ordered, start,
+			if (btrfs_dec_test_ordered_pending(inode, &ordered,
+							   start,
 							   end - start + 1, 1))
 				btrfs_finish_ordered_io(ordered);
 		}
@@ -8142,7 +8140,7 @@ static void btrfs_invalidatepage(struct page *page, unsigned int offset,
 	 *    bit of its io_tree, and free the qgroup reserved data space.
 	 *    Since the IO will never happen for this page.
 	 */
-	btrfs_qgroup_free_data(BTRFS_I(inode), NULL, page_start, PAGE_SIZE);
+	btrfs_qgroup_free_data(inode, NULL, page_start, PAGE_SIZE);
 	if (!inode_evicting) {
 		clear_extent_bit(tree, page_start, page_end, EXTENT_LOCKED |
 				 EXTENT_DELALLOC | EXTENT_DELALLOC_NEW |
-- 
2.17.1

