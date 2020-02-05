Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF37F15374B
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Feb 2020 19:09:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727394AbgBESJw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 5 Feb 2020 13:09:52 -0500
Received: from mx2.suse.de ([195.135.220.15]:57696 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727440AbgBESJw (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 5 Feb 2020 13:09:52 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 7CC09AD00;
        Wed,  5 Feb 2020 18:09:50 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id DC907DA735; Wed,  5 Feb 2020 19:09:37 +0100 (CET)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 6/8] btrfs: sink argument tree to __extent_read_full_page
Date:   Wed,  5 Feb 2020 19:09:37 +0100
Message-Id: <7df51ff5476573747dfd5a0a78033431a2363fc4.1580925977.git.dsterba@suse.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <cover.1580925977.git.dsterba@suse.com>
References: <cover.1580925977.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The tree pointer can be safely read from the inode, use it and drop the
redundant argument.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/extent_io.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 97e613e72ed4..015993ccf333 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -3303,8 +3303,7 @@ static inline void contiguous_readpages(struct extent_io_tree *tree,
 	}
 }
 
-static int __extent_read_full_page(struct extent_io_tree *tree,
-				   struct page *page,
+static int __extent_read_full_page(struct page *page,
 				   get_extent_t *get_extent,
 				   struct bio **bio, int mirror_num,
 				   unsigned long *bio_flags,
@@ -3313,10 +3312,9 @@ static int __extent_read_full_page(struct extent_io_tree *tree,
 	struct btrfs_inode *inode = BTRFS_I(page->mapping->host);
 	u64 start = page_offset(page);
 	u64 end = start + PAGE_SIZE - 1;
+	struct extent_io_tree *tree = &inode->io_tree;
 	int ret;
 
-	ASSERT(tree == &inode->io_tree);
-
 	btrfs_lock_and_flush_ordered_range(inode, start, end, NULL);
 
 	ret = __do_readpage(tree, page, get_extent, NULL, bio, mirror_num,
@@ -3329,10 +3327,9 @@ int extent_read_full_page(struct page *page, get_extent_t *get_extent,
 {
 	struct bio *bio = NULL;
 	unsigned long bio_flags = 0;
-	struct extent_io_tree *tree = &BTRFS_I(page->mapping->host)->io_tree;
 	int ret;
 
-	ret = __extent_read_full_page(tree, page, get_extent, &bio, mirror_num,
+	ret = __extent_read_full_page(page, get_extent, &bio, mirror_num,
 				      &bio_flags, 0);
 	if (bio)
 		ret = submit_one_bio(bio, mirror_num, bio_flags);
@@ -5415,13 +5412,10 @@ int read_extent_buffer_pages(struct extent_buffer *eb, int wait, int mirror_num)
 	unsigned long num_reads = 0;
 	struct bio *bio = NULL;
 	unsigned long bio_flags = 0;
-	struct extent_io_tree *tree = &BTRFS_I(eb->fs_info->btree_inode)->io_tree;
 
 	if (test_bit(EXTENT_BUFFER_UPTODATE, &eb->bflags))
 		return 0;
 
-	ASSERT(tree == &BTRFS_I(eb->pages[0]->mapping->host)->io_tree);
-
 	num_pages = num_extent_pages(eb);
 	for (i = 0; i < num_pages; i++) {
 		page = eb->pages[i];
@@ -5465,7 +5459,7 @@ int read_extent_buffer_pages(struct extent_buffer *eb, int wait, int mirror_num)
 			}
 
 			ClearPageError(page);
-			err = __extent_read_full_page(tree, page,
+			err = __extent_read_full_page(page,
 						      btree_get_extent, &bio,
 						      mirror_num, &bio_flags,
 						      REQ_META);
-- 
2.25.0

