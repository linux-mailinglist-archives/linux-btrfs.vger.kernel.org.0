Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A92BFCECED
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Oct 2019 21:37:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728971AbfJGThd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Oct 2019 15:37:33 -0400
Received: from mx2.suse.de ([195.135.220.15]:44430 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729048AbfJGThd (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 7 Oct 2019 15:37:33 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 593FBAE6E;
        Mon,  7 Oct 2019 19:37:32 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id B94B0DA7FB; Mon,  7 Oct 2019 21:37:47 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 5/5] btrfs: drop bdev argument from submit_extent_page
Date:   Mon,  7 Oct 2019 21:37:47 +0200
Message-Id: <a042f54422f79769747a159653a419dcbd45053f.1570474492.git.dsterba@suse.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1570474492.git.dsterba@suse.com>
References: <cover.1570474492.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

After previous patches removing bdev being passed around to set it to
bio, it has become unused in submit_extent_page. So it now has "only" 13
parameters.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/extent_io.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index d3dda8388f93..f426a0a772b3 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2929,7 +2929,6 @@ struct bio *btrfs_bio_clone_partial(struct bio *orig, int offset, int size)
  *              a contiguous page to the previous one
  * @size:	portion of page that we want to write
  * @offset:	starting offset in the page
- * @bdev:	attach newly created bios to this bdev
  * @bio_ret:	must be valid pointer, newly allocated bio will be stored there
  * @end_io_func:     end_io callback for new bio
  * @mirror_num:	     desired mirror to read/write
@@ -2940,7 +2939,6 @@ static int submit_extent_page(unsigned int opf, struct extent_io_tree *tree,
 			      struct writeback_control *wbc,
 			      struct page *page, u64 offset,
 			      size_t size, unsigned long pg_offset,
-			      struct block_device *bdev,
 			      struct bio **bio_ret,
 			      bio_end_io_t end_io_func,
 			      int mirror_num,
@@ -3073,7 +3071,6 @@ static int __do_readpage(struct extent_io_tree *tree,
 	u64 block_start;
 	u64 cur_end;
 	struct extent_map *em;
-	struct block_device *bdev;
 	int ret = 0;
 	int nr = 0;
 	size_t pg_offset = 0;
@@ -3239,7 +3236,7 @@ static int __do_readpage(struct extent_io_tree *tree,
 
 		ret = submit_extent_page(REQ_OP_READ | read_flags, tree, NULL,
 					 page, offset, disk_io_size,
-					 pg_offset, bdev, bio,
+					 pg_offset, bio,
 					 end_bio_extent_readpage, mirror_num,
 					 *bio_flags,
 					 this_bio_flag,
@@ -3427,7 +3424,6 @@ static noinline_for_stack int __extent_writepage_io(struct inode *inode,
 	u64 block_start;
 	u64 iosize;
 	struct extent_map *em;
-	struct block_device *bdev;
 	size_t pg_offset = 0;
 	size_t blocksize;
 	int ret = 0;
@@ -3526,7 +3522,7 @@ static noinline_for_stack int __extent_writepage_io(struct inode *inode,
 
 		ret = submit_extent_page(REQ_OP_WRITE | write_flags, tree, wbc,
 					 page, offset, iosize, pg_offset,
-					 bdev, &epd->bio,
+					 &epd->bio,
 					 end_bio_extent_writepage,
 					 0, 0, 0, false);
 		if (ret) {
@@ -3855,7 +3851,6 @@ static noinline_for_stack int write_one_eb(struct extent_buffer *eb,
 			struct extent_page_data *epd)
 {
 	struct btrfs_fs_info *fs_info = eb->fs_info;
-	struct block_device *bdev = fs_info->fs_devices->latest_bdev;
 	struct extent_io_tree *tree = &BTRFS_I(fs_info->btree_inode)->io_tree;
 	u64 offset = eb->start;
 	u32 nritems;
@@ -3890,7 +3885,7 @@ static noinline_for_stack int write_one_eb(struct extent_buffer *eb,
 		clear_page_dirty_for_io(p);
 		set_page_writeback(p);
 		ret = submit_extent_page(REQ_OP_WRITE | write_flags, tree, wbc,
-					 p, offset, PAGE_SIZE, 0, bdev,
+					 p, offset, PAGE_SIZE, 0,
 					 &epd->bio,
 					 end_bio_extent_buffer_writepage,
 					 0, 0, 0, false);
-- 
2.23.0

