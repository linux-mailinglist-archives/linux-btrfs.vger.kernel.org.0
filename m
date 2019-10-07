Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA831CECEB
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Oct 2019 21:37:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729005AbfJGThc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Oct 2019 15:37:32 -0400
Received: from mx2.suse.de ([195.135.220.15]:44430 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728079AbfJGThb (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 7 Oct 2019 15:37:31 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id AE232AE6E;
        Mon,  7 Oct 2019 19:37:29 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 1F1FEDA7FB; Mon,  7 Oct 2019 21:37:45 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 3/5] btrfs: drop bio_set_dev where not needed
Date:   Mon,  7 Oct 2019 21:37:45 +0200
Message-Id: <3ed385e2e7e5fd47884eddb2acdfacc4f4f31d40.1570474492.git.dsterba@suse.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1570474492.git.dsterba@suse.com>
References: <cover.1570474492.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

bio_set_dev sets a bdev to a bio and is not only setting a pointer bug
also changing some state bits if there was a different bdev set before.
This is one thing that's not needed.

Another thing is that setting a bdev at bio allocation time is too early
and actually does not work with plain redundancy profiles, where each
time we submit a bio to a device, the bdev is set correctly.

In many places the bio bdev is set to latest_bdev that seems to serve as
a stub pointer "just to put something to bio". But we don't have to do
that.

Where do we know which bdev to set:

* for regular IO: submit_stripe_bio that's called by btrfs_map_bio

* repair IO: repair_io_failure, read or write from specific device

* super block write (using buffer_heads but uses raw bdev) and barriers

* scrub: this does not use all regular IO paths as it needs to reach all
  copies, verify and fixup eventually, and for that all bdev management
  is independent

* raid56: rbio_add_io_page, for the RMW write

* integrity-checker: does it's own low-level block tracking

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/compression.c | 10 ----------
 fs/btrfs/extent_io.c   |  2 --
 2 files changed, 12 deletions(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index b05b361e2062..5e66da73ab34 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -320,7 +320,6 @@ blk_status_t btrfs_submit_compressed_write(struct inode *inode, u64 start,
 	int pg_index = 0;
 	struct page *page;
 	u64 first_byte = disk_start;
-	struct block_device *bdev;
 	blk_status_t ret;
 	int skip_sum = BTRFS_I(inode)->flags & BTRFS_INODE_NODATASUM;
 
@@ -339,10 +338,7 @@ blk_status_t btrfs_submit_compressed_write(struct inode *inode, u64 start,
 	cb->orig_bio = NULL;
 	cb->nr_pages = nr_pages;
 
-	bdev = fs_info->fs_devices->latest_bdev;
-
 	bio = btrfs_bio_alloc(first_byte);
-	bio_set_dev(bio, bdev);
 	bio->bi_opf = REQ_OP_WRITE | write_flags;
 	bio->bi_private = cb;
 	bio->bi_end_io = end_compressed_bio_write;
@@ -385,7 +381,6 @@ blk_status_t btrfs_submit_compressed_write(struct inode *inode, u64 start,
 			}
 
 			bio = btrfs_bio_alloc(first_byte);
-			bio_set_dev(bio, bdev);
 			bio->bi_opf = REQ_OP_WRITE | write_flags;
 			bio->bi_private = cb;
 			bio->bi_end_io = end_compressed_bio_write;
@@ -553,7 +548,6 @@ blk_status_t btrfs_submit_compressed_read(struct inode *inode, struct bio *bio,
 	unsigned long nr_pages;
 	unsigned long pg_index;
 	struct page *page;
-	struct block_device *bdev;
 	struct bio *comp_bio;
 	u64 cur_disk_byte = (u64)bio->bi_iter.bi_sector << 9;
 	u64 em_len;
@@ -604,8 +598,6 @@ blk_status_t btrfs_submit_compressed_read(struct inode *inode, struct bio *bio,
 	if (!cb->compressed_pages)
 		goto fail1;
 
-	bdev = fs_info->fs_devices->latest_bdev;
-
 	for (pg_index = 0; pg_index < nr_pages; pg_index++) {
 		cb->compressed_pages[pg_index] = alloc_page(GFP_NOFS |
 							      __GFP_HIGHMEM);
@@ -624,7 +616,6 @@ blk_status_t btrfs_submit_compressed_read(struct inode *inode, struct bio *bio,
 	cb->len = bio->bi_iter.bi_size;
 
 	comp_bio = btrfs_bio_alloc(cur_disk_byte);
-	bio_set_dev(comp_bio, bdev);
 	comp_bio->bi_opf = REQ_OP_READ;
 	comp_bio->bi_private = cb;
 	comp_bio->bi_end_io = end_compressed_bio_read;
@@ -675,7 +666,6 @@ blk_status_t btrfs_submit_compressed_read(struct inode *inode, struct bio *bio,
 			}
 
 			comp_bio = btrfs_bio_alloc(cur_disk_byte);
-			bio_set_dev(comp_bio, bdev);
 			comp_bio->bi_opf = REQ_OP_READ;
 			comp_bio->bi_private = cb;
 			comp_bio->bi_end_io = end_compressed_bio_read;
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 0f1d917c8bb3..5baade1bc1e1 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2544,7 +2544,6 @@ struct bio *btrfs_create_repair_bio(struct inode *inode, struct bio *failed_bio,
 	bio = btrfs_io_bio_alloc(1);
 	bio->bi_end_io = endio_func;
 	bio->bi_iter.bi_sector = failrec->logical >> 9;
-	bio_set_dev(bio, fs_info->fs_devices->latest_bdev);
 	bio->bi_iter.bi_size = 0;
 	bio->bi_private = data;
 
@@ -2987,7 +2986,6 @@ static int submit_extent_page(unsigned int opf, struct extent_io_tree *tree,
 	}
 
 	bio = btrfs_bio_alloc(offset);
-	bio_set_dev(bio, bdev);
 	bio_add_page(bio, page, page_size, pg_offset);
 	bio->bi_end_io = end_io_func;
 	bio->bi_private = tree;
-- 
2.23.0

