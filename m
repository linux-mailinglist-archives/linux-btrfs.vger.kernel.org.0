Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D50BD4A8FA
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Jun 2019 19:59:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730191AbfFRR7a (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 18 Jun 2019 13:59:30 -0400
Received: from mx2.suse.de ([195.135.220.15]:45110 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727616AbfFRR7a (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 18 Jun 2019 13:59:30 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 83AEDAEBD
        for <linux-btrfs@vger.kernel.org>; Tue, 18 Jun 2019 17:59:28 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 85FA8DA871; Tue, 18 Jun 2019 20:00:16 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 6/6] btrfs: lift bio_set_dev from bio allocation helpers
Date:   Tue, 18 Jun 2019 20:00:16 +0200
Message-Id: <78e6abb1da3bb93961254526172dc70138f8f39b.1560880630.git.dsterba@suse.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1560880630.git.dsterba@suse.com>
References: <cover.1560880630.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The block device is passed around for the only purpose to set it in new
bios. Move the assignment one level up. This is a preparatory patch for
further bdev cleanups.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/compression.c | 12 ++++++++----
 fs/btrfs/extent_io.c   |  6 +++---
 fs/btrfs/extent_io.h   |  2 +-
 3 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index db41315f11eb..60c47b417a4b 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -340,7 +340,8 @@ blk_status_t btrfs_submit_compressed_write(struct inode *inode, u64 start,
 
 	bdev = fs_info->fs_devices->latest_bdev;
 
-	bio = btrfs_bio_alloc(bdev, first_byte);
+	bio = btrfs_bio_alloc(first_byte);
+	bio_set_dev(bio, bdev);
 	bio->bi_opf = REQ_OP_WRITE | write_flags;
 	bio->bi_private = cb;
 	bio->bi_end_io = end_compressed_bio_write;
@@ -382,7 +383,8 @@ blk_status_t btrfs_submit_compressed_write(struct inode *inode, u64 start,
 				bio_endio(bio);
 			}
 
-			bio = btrfs_bio_alloc(bdev, first_byte);
+			bio = btrfs_bio_alloc(first_byte);
+			bio_set_dev(bio, bdev);
 			bio->bi_opf = REQ_OP_WRITE | write_flags;
 			bio->bi_private = cb;
 			bio->bi_end_io = end_compressed_bio_write;
@@ -620,7 +622,8 @@ blk_status_t btrfs_submit_compressed_read(struct inode *inode, struct bio *bio,
 	/* include any pages we added in add_ra-bio_pages */
 	cb->len = bio->bi_iter.bi_size;
 
-	comp_bio = btrfs_bio_alloc(bdev, cur_disk_byte);
+	comp_bio = btrfs_bio_alloc(cur_disk_byte);
+	bio_set_dev(comp_bio, bdev);
 	comp_bio->bi_opf = REQ_OP_READ;
 	comp_bio->bi_private = cb;
 	comp_bio->bi_end_io = end_compressed_bio_read;
@@ -670,7 +673,8 @@ blk_status_t btrfs_submit_compressed_read(struct inode *inode, struct bio *bio,
 				bio_endio(comp_bio);
 			}
 
-			comp_bio = btrfs_bio_alloc(bdev, cur_disk_byte);
+			comp_bio = btrfs_bio_alloc(cur_disk_byte);
+			bio_set_dev(comp_bio, bdev);
 			comp_bio->bi_opf = REQ_OP_READ;
 			comp_bio->bi_private = cb;
 			comp_bio->bi_end_io = end_compressed_bio_read;
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index a6ad2f6f2bf7..f21be5d3724f 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2863,12 +2863,11 @@ static inline void btrfs_io_bio_init(struct btrfs_io_bio *btrfs_bio)
  * never fail.  We're returning a bio right now but you can call btrfs_io_bio
  * for the appropriate container_of magic
  */
-struct bio *btrfs_bio_alloc(struct block_device *bdev, u64 first_byte)
+struct bio *btrfs_bio_alloc(u64 first_byte)
 {
 	struct bio *bio;
 
 	bio = bio_alloc_bioset(GFP_NOFS, BIO_MAX_PAGES, &btrfs_bioset);
-	bio_set_dev(bio, bdev);
 	bio->bi_iter.bi_sector = first_byte >> 9;
 	btrfs_io_bio_init(btrfs_io_bio(bio));
 	return bio;
@@ -2979,7 +2978,8 @@ static int submit_extent_page(unsigned int opf, struct extent_io_tree *tree,
 		}
 	}
 
-	bio = btrfs_bio_alloc(bdev, offset);
+	bio = btrfs_bio_alloc(offset);
+	bio_set_dev(bio, bdev);
 	bio_add_page(bio, page, page_size, pg_offset);
 	bio->bi_end_io = end_io_func;
 	bio->bi_private = tree;
diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
index 844e595cde5b..6e13a62a2974 100644
--- a/fs/btrfs/extent_io.h
+++ b/fs/btrfs/extent_io.h
@@ -497,7 +497,7 @@ void extent_clear_unlock_delalloc(struct inode *inode, u64 start, u64 end,
 				 u64 delalloc_end, struct page *locked_page,
 				 unsigned bits_to_clear,
 				 unsigned long page_ops);
-struct bio *btrfs_bio_alloc(struct block_device *bdev, u64 first_byte);
+struct bio *btrfs_bio_alloc(u64 first_byte);
 struct bio *btrfs_io_bio_alloc(unsigned int nr_iovecs);
 struct bio *btrfs_bio_clone(struct bio *bio);
 struct bio *btrfs_bio_clone_partial(struct bio *orig, int offset, int size);
-- 
2.21.0

