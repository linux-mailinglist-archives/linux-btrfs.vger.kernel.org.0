Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62CA426B2B8
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Sep 2020 00:52:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727614AbgIOWwL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 15 Sep 2020 18:52:11 -0400
Received: from mx2.suse.de ([195.135.220.15]:45916 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726484AbgIOPlo (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Sep 2020 11:41:44 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 38828AC1D
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Sep 2020 15:41:59 +0000 (UTC)
Date:   Tue, 15 Sep 2020 10:41:40 -0500
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: use iosize while reading compressed pages
Message-ID: <20200915154140.mlmlwmctre2prf2s@fiona>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

While using compression, a submitted bio is mapped with a compressed bio
which performs the read from disk, decompresses and returns uncompressed
data to original bio. The original bio must reflect the uncompressed
size (iosize) of the I/O to be performed, or else the page just gets the
decompressed I/O length of data (disk_io_size). The compressed bio
checks the extent map and get the correct length while performing the
I/O from disk.

This came up in subpage work when only compressed length of the original
bio was filled in the page. This worked correctly for pagesize ==
sectorsize because both compressed and uncompressed data are at pagesize
boundaries, and would end up filling the requested page.

Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
---
 fs/btrfs/extent_io.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index afac70ef0cc5..98173580a948 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -3158,7 +3158,6 @@ int btrfs_do_readpage(struct page *page, struct extent_map **em_cached,
 	int nr = 0;
 	size_t pg_offset = 0;
 	size_t iosize;
-	size_t disk_io_size;
 	size_t blocksize = inode->i_sb->s_blocksize;
 	unsigned long this_bio_flag = 0;
 	struct extent_io_tree *tree = &BTRFS_I(inode)->io_tree;
@@ -3224,13 +3223,10 @@ int btrfs_do_readpage(struct page *page, struct extent_map **em_cached,
 		iosize = min(extent_map_end(em) - cur, end - cur + 1);
 		cur_end = min(extent_map_end(em) - 1, end);
 		iosize = ALIGN(iosize, blocksize);
-		if (this_bio_flag & EXTENT_BIO_COMPRESSED) {
-			disk_io_size = em->block_len;
+		if (this_bio_flag & EXTENT_BIO_COMPRESSED)
 			offset = em->block_start;
-		} else {
+		else
 			offset = em->block_start + extent_offset;
-			disk_io_size = iosize;
-		}
 		block_start = em->block_start;
 		if (test_bit(EXTENT_FLAG_PREALLOC, &em->flags))
 			block_start = EXTENT_MAP_HOLE;
@@ -3319,7 +3315,7 @@ int btrfs_do_readpage(struct page *page, struct extent_map **em_cached,
 		}
 
 		ret = submit_extent_page(REQ_OP_READ | read_flags, NULL,
-					 page, offset, disk_io_size,
+					 page, offset, iosize,
 					 pg_offset, bio,
 					 end_bio_extent_readpage, 0,
 					 *bio_flags,
-- 
2.26.2


-- 
Goldwyn
