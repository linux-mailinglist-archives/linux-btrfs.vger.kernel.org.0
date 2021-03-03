Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21C4532C53F
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Mar 2021 01:58:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1447856AbhCDATv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 3 Mar 2021 19:19:51 -0500
Received: from mx2.suse.de ([195.135.220.15]:56206 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240729AbhCCM4m (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 3 Mar 2021 07:56:42 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id BD28FAD29
        for <linux-btrfs@vger.kernel.org>; Wed,  3 Mar 2021 12:55:21 +0000 (UTC)
Date:   Wed, 3 Mar 2021 06:55:37 -0600
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: Remove mirror argument from btrfs_csum_verify_data()
Message-ID: <20210303125537.x2moj2kocknnsm6n@fiona>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Unused variable: mirror.

Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
---
 fs/btrfs/ctree.h     | 2 +-
 fs/btrfs/extent_io.c | 3 +--
 fs/btrfs/inode.c     | 3 +--
 3 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 014afeb8d626..5776026c532e 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -3083,7 +3083,7 @@ u64 btrfs_file_extent_end(const struct btrfs_path *path);
 blk_status_t btrfs_submit_data_bio(struct inode *inode, struct bio *bio,
 				   int mirror_num, unsigned long bio_flags);
 int btrfs_verify_data_csum(struct btrfs_io_bio *io_bio, u32 bio_offset,
-			   struct page *page, u64 start, u64 end, int mirror);
+			   struct page *page, u64 start, u64 end);
 struct extent_map *btrfs_get_extent_fiemap(struct btrfs_inode *inode,
 					   u64 start, u64 len);
 noinline int can_nocow_extent(struct inode *inode, u64 offset, u64 *len,
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 4dfb3ead1175..9fd7e8366119 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2954,8 +2954,7 @@ static void end_bio_extent_readpage(struct bio *bio)
 		if (likely(uptodate)) {
 			if (is_data_inode(inode))
 				ret = btrfs_verify_data_csum(io_bio,
-						bio_offset, page, start, end,
-						mirror);
+						bio_offset, page, start, end);
 			else
 				ret = btrfs_validate_metadata_buffer(io_bio,
 					page, start, end, mirror);
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index d5ac45c264e5..0b133fda4f5d 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -3145,10 +3145,9 @@ static int check_data_csum(struct inode *inode, struct btrfs_io_bio *io_bio,
  * @bio_offset:	offset to the beginning of the bio (in bytes)
  * @start:	file offset of the range start
  * @end:	file offset of the range end (inclusive)
- * @mirror:	mirror number
  */
 int btrfs_verify_data_csum(struct btrfs_io_bio *io_bio, u32 bio_offset,
-			   struct page *page, u64 start, u64 end, int mirror)
+			   struct page *page, u64 start, u64 end)
 {
 	struct inode *inode = page->mapping->host;
 	struct extent_io_tree *io_tree = &BTRFS_I(inode)->io_tree;
-- 
2.30.1
