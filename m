Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44D491EC92D
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 Jun 2020 07:57:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726181AbgFCF4m (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 3 Jun 2020 01:56:42 -0400
Received: from mx2.suse.de ([195.135.220.15]:42464 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725959AbgFCFz4 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 3 Jun 2020 01:55:56 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 44E3EAFC3;
        Wed,  3 Jun 2020 05:55:58 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 16/46] btrfs: Make btrfs_submit_compressed_write take btrfs_inode
Date:   Wed,  3 Jun 2020 08:55:16 +0300
Message-Id: <20200603055546.3889-17-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200603055546.3889-1-nborisov@suse.com>
References: <20200603055546.3889-1-nborisov@suse.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Majority of its uses are for btrfs_inode so take it as an argument directly.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/compression.c | 15 +++++++--------
 fs/btrfs/compression.h |  4 +++-
 fs/btrfs/inode.c       |  2 +-
 3 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index 4f52cd8af517..c2d5ca583dbf 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -405,7 +405,7 @@ static void end_compressed_bio_write(struct bio *bio)
  * This also checksums the file bytes and gets things ready for
  * the end io hooks.
  */
-blk_status_t btrfs_submit_compressed_write(struct inode *inode, u64 start,
+blk_status_t btrfs_submit_compressed_write(struct btrfs_inode *inode, u64 start,
 				 unsigned long len, u64 disk_start,
 				 unsigned long compressed_len,
 				 struct page **compressed_pages,
@@ -413,7 +413,7 @@ blk_status_t btrfs_submit_compressed_write(struct inode *inode, u64 start,
 				 unsigned int write_flags,
 				 struct cgroup_subsys_state *blkcg_css)
 {
-	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
+	struct btrfs_fs_info *fs_info = inode->root->fs_info;
 	struct bio *bio = NULL;
 	struct compressed_bio *cb;
 	unsigned long bytes_left;
@@ -421,7 +421,7 @@ blk_status_t btrfs_submit_compressed_write(struct inode *inode, u64 start,
 	struct page *page;
 	u64 first_byte = disk_start;
 	blk_status_t ret;
-	int skip_sum = BTRFS_I(inode)->flags & BTRFS_INODE_NODATASUM;
+	int skip_sum = inode->flags & BTRFS_INODE_NODATASUM;

 	WARN_ON(!PAGE_ALIGNED(start));
 	cb = kmalloc(compressed_bio_size(fs_info, compressed_len), GFP_NOFS);
@@ -429,7 +429,7 @@ blk_status_t btrfs_submit_compressed_write(struct inode *inode, u64 start,
 		return BLK_STS_RESOURCE;
 	refcount_set(&cb->pending_bios, 0);
 	cb->errors = 0;
-	cb->inode = inode;
+	cb->inode = &inode->vfs_inode;
 	cb->start = start;
 	cb->len = len;
 	cb->mirror_num = 0;
@@ -455,7 +455,7 @@ blk_status_t btrfs_submit_compressed_write(struct inode *inode, u64 start,
 		int submit = 0;

 		page = compressed_pages[pg_index];
-		page->mapping = inode->i_mapping;
+		page->mapping = inode->vfs_inode.i_mapping;
 		if (bio->bi_iter.bi_size)
 			submit = btrfs_bio_fits_in_stripe(page, PAGE_SIZE, bio,
 							  0);
@@ -475,8 +475,7 @@ blk_status_t btrfs_submit_compressed_write(struct inode *inode, u64 start,
 			BUG_ON(ret); /* -ENOMEM */

 			if (!skip_sum) {
-				ret = btrfs_csum_one_bio(BTRFS_I(inode), bio,
-							 start, 1);
+				ret = btrfs_csum_one_bio(inode, bio, start, 1);
 				BUG_ON(ret); /* -ENOMEM */
 			}

@@ -508,7 +507,7 @@ blk_status_t btrfs_submit_compressed_write(struct inode *inode, u64 start,
 	BUG_ON(ret); /* -ENOMEM */

 	if (!skip_sum) {
-		ret = btrfs_csum_one_bio(BTRFS_I(inode), bio, start, 1);
+		ret = btrfs_csum_one_bio(inode, bio, start, 1);
 		BUG_ON(ret); /* -ENOMEM */
 	}

diff --git a/fs/btrfs/compression.h b/fs/btrfs/compression.h
index 284a3ad31350..9f3dbe372631 100644
--- a/fs/btrfs/compression.h
+++ b/fs/btrfs/compression.h
@@ -8,6 +8,8 @@

 #include <linux/sizes.h>

+struct btrfs_inode;
+
 /*
  * We want to make sure that amount of RAM required to uncompress an extent is
  * reasonable, so we limit the total size in ram of a compressed extent to
@@ -88,7 +90,7 @@ int btrfs_decompress_buf2page(const char *buf, unsigned long buf_start,
 			      unsigned long total_out, u64 disk_start,
 			      struct bio *bio);

-blk_status_t btrfs_submit_compressed_write(struct inode *inode, u64 start,
+blk_status_t btrfs_submit_compressed_write(struct btrfs_inode *inode, u64 start,
 				  unsigned long len, u64 disk_start,
 				  unsigned long compressed_len,
 				  struct page **compressed_pages,
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index a106c9857315..a527848c57d5 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -886,7 +886,7 @@ static noinline void submit_compressed_extents(struct async_chunk *async_chunk)
 				NULL, EXTENT_LOCKED | EXTENT_DELALLOC,
 				PAGE_UNLOCK | PAGE_CLEAR_DIRTY |
 				PAGE_SET_WRITEBACK);
-		if (btrfs_submit_compressed_write(inode,
+		if (btrfs_submit_compressed_write(BTRFS_I(inode),
 				    async_extent->start,
 				    async_extent->ram_size,
 				    ins.objectid,
--
2.17.1

