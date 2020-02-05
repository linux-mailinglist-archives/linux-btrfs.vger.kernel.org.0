Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 40EED153747
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Feb 2020 19:09:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727307AbgBESJn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 5 Feb 2020 13:09:43 -0500
Received: from mx2.suse.de ([195.135.220.15]:57574 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727149AbgBESJm (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 5 Feb 2020 13:09:42 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 1EC69ACE0;
        Wed,  5 Feb 2020 18:09:41 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 80264DA735; Wed,  5 Feb 2020 19:09:28 +0100 (CET)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 2/8] btrfs: drop argument tree from submit_extent_page
Date:   Wed,  5 Feb 2020 19:09:28 +0100
Message-Id: <a54487df38bbbd4f6149b2a7bbe86247fe5c532e.1580925977.git.dsterba@suse.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <cover.1580925977.git.dsterba@suse.com>
References: <cover.1580925977.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Now that we're sure the tree from argument is same as the one we can get
from the page's inode io_tree, drop the redundant argument.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/extent_io.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 753fc92ad348..6640336dd9ba 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2936,7 +2936,6 @@ struct bio *btrfs_bio_clone_partial(struct bio *orig, int offset, int size)
 
 /*
  * @opf:	bio REQ_OP_* and REQ_* flags as one value
- * @tree:	tree so we can call our merge_bio hook
  * @wbc:	optional writeback control for io accounting
  * @page:	page to add to the bio
  * @pg_offset:	offset of the new bio or to check whether we are adding
@@ -2949,7 +2948,7 @@ struct bio *btrfs_bio_clone_partial(struct bio *orig, int offset, int size)
  * @prev_bio_flags:  flags of previous bio to see if we can merge the current one
  * @bio_flags:	flags of the current bio to see if we can merge them
  */
-static int submit_extent_page(unsigned int opf, struct extent_io_tree *tree,
+static int submit_extent_page(unsigned int opf,
 			      struct writeback_control *wbc,
 			      struct page *page, u64 offset,
 			      size_t size, unsigned long pg_offset,
@@ -2964,9 +2963,9 @@ static int submit_extent_page(unsigned int opf, struct extent_io_tree *tree,
 	struct bio *bio;
 	size_t page_size = min_t(size_t, size, PAGE_SIZE);
 	sector_t sector = offset >> 9;
+	struct extent_io_tree *tree = &BTRFS_I(page->mapping->host)->io_tree;
 
 	ASSERT(bio_ret);
-	ASSERT(tree == &BTRFS_I(page->mapping->host)->io_tree);
 
 	if (*bio_ret) {
 		bool contig;
@@ -3253,7 +3252,7 @@ static int __do_readpage(struct extent_io_tree *tree,
 			continue;
 		}
 
-		ret = submit_extent_page(REQ_OP_READ | read_flags, tree, NULL,
+		ret = submit_extent_page(REQ_OP_READ | read_flags, NULL,
 					 page, offset, disk_io_size,
 					 pg_offset, bio,
 					 end_bio_extent_readpage, mirror_num,
@@ -3520,7 +3519,7 @@ static noinline_for_stack int __extent_writepage_io(struct inode *inode,
 			       page->index, cur, end);
 		}
 
-		ret = submit_extent_page(REQ_OP_WRITE | write_flags, tree, wbc,
+		ret = submit_extent_page(REQ_OP_WRITE | write_flags, wbc,
 					 page, offset, iosize, pg_offset,
 					 &epd->bio,
 					 end_bio_extent_writepage,
@@ -3842,7 +3841,6 @@ static noinline_for_stack int write_one_eb(struct extent_buffer *eb,
 			struct extent_page_data *epd)
 {
 	struct btrfs_fs_info *fs_info = eb->fs_info;
-	struct extent_io_tree *tree = &BTRFS_I(fs_info->btree_inode)->io_tree;
 	u64 offset = eb->start;
 	u32 nritems;
 	int i, num_pages;
@@ -3875,7 +3873,7 @@ static noinline_for_stack int write_one_eb(struct extent_buffer *eb,
 
 		clear_page_dirty_for_io(p);
 		set_page_writeback(p);
-		ret = submit_extent_page(REQ_OP_WRITE | write_flags, tree, wbc,
+		ret = submit_extent_page(REQ_OP_WRITE | write_flags, wbc,
 					 p, offset, PAGE_SIZE, 0,
 					 &epd->bio,
 					 end_bio_extent_buffer_writepage,
-- 
2.25.0

