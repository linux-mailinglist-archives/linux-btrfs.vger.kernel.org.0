Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B94B52D53F2
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Dec 2020 07:40:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387484AbgLJGj7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 10 Dec 2020 01:39:59 -0500
Received: from mx2.suse.de ([195.135.220.15]:44108 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387481AbgLJGj7 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 10 Dec 2020 01:39:59 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1607582352; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qmDjZY+tFrSsnqoJYWp4sxqtgO+W2q0468i3xz3L43c=;
        b=aIqrxn0oyk5QafTQtt582pBwOJbyC7dLAy96yvRUxZoyNUTvMYw+xQsQpgWY0ZtC32tDwl
        OP49kGnInODA6HP9iAigpOzOXT88p/YAqNgiGITL6Aspm7H+x2ZJCCjiRXNY+rIcMi9wcB
        1p3Pme18x/z+TRC+xQym0JannTMuD7w=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 58A93ACC6
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Dec 2020 06:39:12 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 02/18] btrfs: extent_io: refactor __extent_writepage_io() to improve readability
Date:   Thu, 10 Dec 2020 14:38:49 +0800
Message-Id: <20201210063905.75727-3-wqu@suse.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201210063905.75727-1-wqu@suse.com>
References: <20201210063905.75727-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The refactor involves the following modifications:
- iosize alignment
  In fact we don't really need to manually do alignment at all.
  All extent maps should already be aligned, thus basic ASSERT() check
  would be enough.

- redundant variables
  We have extra variable like blocksize/pg_offset/end.
  They are all unnecessary.

  @blocksize can be replaced by sectorsize size directly, and it's only
  used to verify the em start/size is aligned.

  @pg_offset can be easily calculated using @cur and page_offset(page).

  @end is just assigned to @page_end and never modified, use @page_end
  to replace it.

- remove some BUG_ON()s
  The BUG_ON()s are for extent map, which we have tree-checker to check
  on-disk extent data item and runtime check.
  ASSERT() should be enough.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent_io.c | 37 +++++++++++++++++--------------------
 1 file changed, 17 insertions(+), 20 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 2650e8720394..612fe60b367e 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -3515,17 +3515,14 @@ static noinline_for_stack int __extent_writepage_io(struct btrfs_inode *inode,
 				 unsigned long nr_written,
 				 int *nr_ret)
 {
+	struct btrfs_fs_info *fs_info = inode->root->fs_info;
 	struct extent_io_tree *tree = &inode->io_tree;
 	u64 start = page_offset(page);
 	u64 page_end = start + PAGE_SIZE - 1;
-	u64 end;
 	u64 cur = start;
 	u64 extent_offset;
 	u64 block_start;
-	u64 iosize;
 	struct extent_map *em;
-	size_t pg_offset = 0;
-	size_t blocksize;
 	int ret = 0;
 	int nr = 0;
 	const unsigned int write_flags = wbc_to_write_flags(wbc);
@@ -3546,19 +3543,17 @@ static noinline_for_stack int __extent_writepage_io(struct btrfs_inode *inode,
 	 */
 	update_nr_written(wbc, nr_written + 1);
 
-	end = page_end;
-	blocksize = inode->vfs_inode.i_sb->s_blocksize;
-
-	while (cur <= end) {
+	while (cur <= page_end) {
 		u64 disk_bytenr;
 		u64 em_end;
+		u32 iosize;
 
 		if (cur >= i_size) {
 			btrfs_writepage_endio_finish_ordered(page, cur,
 							     page_end, 1);
 			break;
 		}
-		em = btrfs_get_extent(inode, NULL, 0, cur, end - cur + 1);
+		em = btrfs_get_extent(inode, NULL, 0, cur, page_end - cur + 1);
 		if (IS_ERR_OR_NULL(em)) {
 			SetPageError(page);
 			ret = PTR_ERR_OR_ZERO(em);
@@ -3567,16 +3562,20 @@ static noinline_for_stack int __extent_writepage_io(struct btrfs_inode *inode,
 
 		extent_offset = cur - em->start;
 		em_end = extent_map_end(em);
-		BUG_ON(em_end <= cur);
-		BUG_ON(end < cur);
-		iosize = min(em_end - cur, end - cur + 1);
-		iosize = ALIGN(iosize, blocksize);
-		disk_bytenr = em->block_start + extent_offset;
+		ASSERT(cur <= em_end);
+		ASSERT(cur < page_end);
+		ASSERT(IS_ALIGNED(em->start, fs_info->sectorsize));
+		ASSERT(IS_ALIGNED(em->len, fs_info->sectorsize));
 		block_start = em->block_start;
 		compressed = test_bit(EXTENT_FLAG_COMPRESSED, &em->flags);
+		disk_bytenr = em->block_start + extent_offset;
+
+		/* Note that em_end from extent_map_end() is exclusive */
+		iosize = min(em_end, page_end + 1) - cur;
 		free_extent_map(em);
 		em = NULL;
 
+
 		/*
 		 * compressed and inline extents are written through other
 		 * paths in the FS
@@ -3589,7 +3588,6 @@ static noinline_for_stack int __extent_writepage_io(struct btrfs_inode *inode,
 				btrfs_writepage_endio_finish_ordered(page, cur,
 							cur + iosize - 1, 1);
 			cur += iosize;
-			pg_offset += iosize;
 			continue;
 		}
 
@@ -3597,12 +3595,12 @@ static noinline_for_stack int __extent_writepage_io(struct btrfs_inode *inode,
 		if (!PageWriteback(page)) {
 			btrfs_err(inode->root->fs_info,
 				   "page %lu not writeback, cur %llu end %llu",
-			       page->index, cur, end);
+			       page->index, cur, page_end);
 		}
 
 		ret = submit_extent_page(REQ_OP_WRITE | write_flags, wbc,
-					 page, disk_bytenr, iosize, pg_offset,
-					 &epd->bio,
+					 page, disk_bytenr, iosize,
+					 cur - page_offset(page), &epd->bio,
 					 end_bio_extent_writepage,
 					 0, 0, 0, false);
 		if (ret) {
@@ -3611,8 +3609,7 @@ static noinline_for_stack int __extent_writepage_io(struct btrfs_inode *inode,
 				end_page_writeback(page);
 		}
 
-		cur = cur + iosize;
-		pg_offset += iosize;
+		cur += iosize;
 		nr++;
 	}
 	*nr_ret = nr;
-- 
2.29.2

