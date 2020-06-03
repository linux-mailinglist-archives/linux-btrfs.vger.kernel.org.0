Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7C281EC90F
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 Jun 2020 07:57:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725971AbgFCFz4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 3 Jun 2020 01:55:56 -0400
Received: from mx2.suse.de ([195.135.220.15]:42444 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725877AbgFCFzz (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 3 Jun 2020 01:55:55 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id D06BFAFF4;
        Wed,  3 Jun 2020 05:55:55 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 05/46] btrfs: Make create_io_em take btrfs_inode
Date:   Wed,  3 Jun 2020 08:55:05 +0300
Message-Id: <20200603055546.3889-6-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200603055546.3889-1-nborisov@suse.com>
References: <20200603055546.3889-1-nborisov@suse.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

It really wants a btrfs_inode and will allow submit_compressed_extents
to be completely converted to btrfs_inode in follow up patches.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/inode.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 56015fdd46c9..00ad7bdb7d34 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -83,8 +83,8 @@ static noinline int cow_file_range(struct inode *inode,
 				   struct page *locked_page,
 				   u64 start, u64 end, int *page_started,
 				   unsigned long *nr_written, int unlock);
-static struct extent_map *create_io_em(struct inode *inode, u64 start, u64 len,
-				       u64 orig_start, u64 block_start,
+static struct extent_map *create_io_em(struct btrfs_inode *inode, u64 start,
+				       u64 len, u64 orig_start, u64 block_start,
 				       u64 block_len, u64 orig_block_len,
 				       u64 ram_bytes, int compress_type,
 				       int type);
@@ -844,7 +844,7 @@ static noinline void submit_compressed_extents(struct async_chunk *async_chunk)
 		 * here we're doing allocation and writeback of the
 		 * compressed pages
 		 */
-		em = create_io_em(inode, async_extent->start,
+		em = create_io_em(BTRFS_I(inode), async_extent->start,
 				  async_extent->ram_size, /* len */
 				  async_extent->start, /* orig_start */
 				  ins.objectid, /* block_start */
@@ -1046,7 +1046,7 @@ static noinline int cow_file_range(struct inode *inode,
 		extent_reserved = true;

 		ram_size = ins.offset;
-		em = create_io_em(inode, start, ins.offset, /* len */
+		em = create_io_em(BTRFS_I(inode), start, ins.offset, /* len */
 				  start, /* orig_start */
 				  ins.objectid, /* block_start */
 				  ins.offset, /* block_len */
@@ -1679,7 +1679,7 @@ static noinline int run_delalloc_nocow(struct inode *inode,
 			u64 orig_start = found_key.offset - extent_offset;
 			struct extent_map *em;

-			em = create_io_em(inode, cur_offset, num_bytes,
+			em = create_io_em(BTRFS_I(inode), cur_offset, num_bytes,
 					  orig_start,
 					  disk_bytenr, /* block_start */
 					  num_bytes, /* block_len */
@@ -6843,7 +6843,7 @@ static struct extent_map *btrfs_create_dio_extent(struct inode *inode,
 	int ret;

 	if (type != BTRFS_ORDERED_NOCOW) {
-		em = create_io_em(inode, start, len, orig_start,
+		em = create_io_em(BTRFS_I(inode), start, len, orig_start,
 				  block_start, block_len, orig_block_len,
 				  ram_bytes,
 				  BTRFS_COMPRESS_NONE, /* compress_type */
@@ -7122,8 +7122,8 @@ static int lock_extent_direct(struct inode *inode, u64 lockstart, u64 lockend,
 }

 /* The callers of this must take lock_extent() */
-static struct extent_map *create_io_em(struct inode *inode, u64 start, u64 len,
-				       u64 orig_start, u64 block_start,
+static struct extent_map *create_io_em(struct btrfs_inode *inode, u64 start,
+				       u64 len, u64 orig_start, u64 block_start,
 				       u64 block_len, u64 orig_block_len,
 				       u64 ram_bytes, int compress_type,
 				       int type)
@@ -7137,7 +7137,7 @@ static struct extent_map *create_io_em(struct inode *inode, u64 start, u64 len,
 	       type == BTRFS_ORDERED_NOCOW ||
 	       type == BTRFS_ORDERED_REGULAR);

-	em_tree = &BTRFS_I(inode)->extent_tree;
+	em_tree = &inode->extent_tree;
 	em = alloc_extent_map();
 	if (!em)
 		return ERR_PTR(-ENOMEM);
@@ -7159,8 +7159,8 @@ static struct extent_map *create_io_em(struct inode *inode, u64 start, u64 len,
 	}

 	do {
-		btrfs_drop_extent_cache(BTRFS_I(inode), em->start,
-				em->start + em->len - 1, 0);
+		btrfs_drop_extent_cache(inode, em->start,
+					em->start + em->len - 1, 0);
 		write_lock(&em_tree->lock);
 		ret = add_extent_mapping(em_tree, em, 1);
 		write_unlock(&em_tree->lock);
--
2.17.1

