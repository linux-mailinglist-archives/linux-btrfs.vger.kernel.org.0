Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A4FBF153746
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Feb 2020 19:09:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727165AbgBESJk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 5 Feb 2020 13:09:40 -0500
Received: from mx2.suse.de ([195.135.220.15]:57558 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727083AbgBESJk (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 5 Feb 2020 13:09:40 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id B9006AD00;
        Wed,  5 Feb 2020 18:09:38 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 2782FDA735; Wed,  5 Feb 2020 19:09:26 +0100 (CET)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 1/8] btrfs: remove extent_page_data::tree
Date:   Wed,  5 Feb 2020 19:09:26 +0100
Message-Id: <9bca78d5ecd1eec04ebaa6fa760af3817f9345ab.1580925977.git.dsterba@suse.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <cover.1580925977.git.dsterba@suse.com>
References: <cover.1580925977.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

All functions that set up extent_page_data::tree set it to the inode
io_tree. That's passed down the callstack that accesses either the same
inode or its pages. In the end submit_extent_page can pull the tree out
of the page and we don't have to store it in the structure.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/extent_io.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index d91a48d73e8f..753fc92ad348 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -122,7 +122,6 @@ struct tree_entry {
 
 struct extent_page_data {
 	struct bio *bio;
-	struct extent_io_tree *tree;
 	/* tells writepage not to lock the state bits for this range
 	 * it still does the unlocking
 	 */
@@ -2967,6 +2966,7 @@ static int submit_extent_page(unsigned int opf, struct extent_io_tree *tree,
 	sector_t sector = offset >> 9;
 
 	ASSERT(bio_ret);
+	ASSERT(tree == &BTRFS_I(page->mapping->host)->io_tree);
 
 	if (*bio_ret) {
 		bool contig;
@@ -3434,7 +3434,7 @@ static noinline_for_stack int __extent_writepage_io(struct inode *inode,
 				 unsigned long nr_written,
 				 int *nr_ret)
 {
-	struct extent_io_tree *tree = epd->tree;
+	struct extent_io_tree *tree = &BTRFS_I(inode)->io_tree;
 	u64 start = page_offset(page);
 	u64 page_end = start + PAGE_SIZE - 1;
 	u64 end;
@@ -3908,11 +3908,9 @@ static noinline_for_stack int write_one_eb(struct extent_buffer *eb,
 int btree_write_cache_pages(struct address_space *mapping,
 				   struct writeback_control *wbc)
 {
-	struct extent_io_tree *tree = &BTRFS_I(mapping->host)->io_tree;
 	struct extent_buffer *eb, *prev_eb = NULL;
 	struct extent_page_data epd = {
 		.bio = NULL,
-		.tree = tree,
 		.extent_locked = 0,
 		.sync_io = wbc->sync_mode == WB_SYNC_ALL,
 	};
@@ -4201,7 +4199,6 @@ int extent_write_full_page(struct page *page, struct writeback_control *wbc)
 	int ret;
 	struct extent_page_data epd = {
 		.bio = NULL,
-		.tree = &BTRFS_I(page->mapping->host)->io_tree,
 		.extent_locked = 0,
 		.sync_io = wbc->sync_mode == WB_SYNC_ALL,
 	};
@@ -4223,14 +4220,12 @@ int extent_write_locked_range(struct inode *inode, u64 start, u64 end,
 {
 	int ret = 0;
 	struct address_space *mapping = inode->i_mapping;
-	struct extent_io_tree *tree = &BTRFS_I(inode)->io_tree;
 	struct page *page;
 	unsigned long nr_pages = (end - start + PAGE_SIZE) >>
 		PAGE_SHIFT;
 
 	struct extent_page_data epd = {
 		.bio = NULL,
-		.tree = tree,
 		.extent_locked = 1,
 		.sync_io = mode == WB_SYNC_ALL,
 	};
@@ -4274,7 +4269,6 @@ int extent_writepages(struct address_space *mapping,
 	int ret = 0;
 	struct extent_page_data epd = {
 		.bio = NULL,
-		.tree = &BTRFS_I(mapping->host)->io_tree,
 		.extent_locked = 0,
 		.sync_io = wbc->sync_mode == WB_SYNC_ALL,
 	};
-- 
2.25.0

