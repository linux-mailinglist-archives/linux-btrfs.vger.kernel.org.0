Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25FDE2EB752
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Jan 2021 02:03:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726655AbhAFBC4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 5 Jan 2021 20:02:56 -0500
Received: from mx2.suse.de ([195.135.220.15]:45476 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725952AbhAFBC4 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 5 Jan 2021 20:02:56 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1609894929; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jGQetX9qPJI3T8fcvW++nwKGfCJBEitZEFtv1DPlYrQ=;
        b=X4yG5LrFE11K6na/hilTc5CoHiUmSXlKhd7oo/12raB8+1ZD1PRbcz6eHtrlR+wX6/3uo3
        RBrkf4CBy38madA0Gt5Lrkqf8B1RHUmZmnj8gZS9p/yCbYpJe6B08B1yXlJiQz0C1R1Rm6
        IwyYwUGJqO7/rER0ZQT6zA6cO3W0pIY=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B16E4ADC4;
        Wed,  6 Jan 2021 01:02:09 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH v3 02/22] btrfs: extent_io: refactor __extent_writepage_io() to improve readability
Date:   Wed,  6 Jan 2021 09:01:41 +0800
Message-Id: <20210106010201.37864-3-wqu@suse.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210106010201.37864-1-wqu@suse.com>
References: <20210106010201.37864-1-wqu@suse.com>
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

  @end is just assigned from @page_end and never modified, use "start +
   PAGE_SIZE - 1" directly and remove @page_end.

- remove some BUG_ON()s
  The BUG_ON()s are for extent map, which we have tree-checker to check
  on-disk extent data item and runtime check.
  ASSERT() should be enough.

Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent_io.c | 38 +++++++++++++++++---------------------
 1 file changed, 17 insertions(+), 21 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 99e04fc731a3..6f156ce501a1 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -3513,23 +3513,20 @@ static noinline_for_stack int __extent_writepage_io(struct btrfs_inode *inode,
 				 unsigned long nr_written,
 				 int *nr_ret)
 {
+	struct btrfs_fs_info *fs_info = inode->root->fs_info;
 	struct extent_io_tree *tree = &inode->io_tree;
 	u64 start = page_offset(page);
-	u64 page_end = start + PAGE_SIZE - 1;
-	u64 end;
+	u64 end = start + PAGE_SIZE - 1;
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
 	bool compressed;
 
-	ret = btrfs_writepage_cow_fixup(page, start, page_end);
+	ret = btrfs_writepage_cow_fixup(page, start, end);
 	if (ret) {
 		/* Fixup worker will requeue */
 		redirty_page_for_writepage(wbc, page);
@@ -3544,16 +3541,13 @@ static noinline_for_stack int __extent_writepage_io(struct btrfs_inode *inode,
 	 */
 	update_nr_written(wbc, nr_written + 1);
 
-	end = page_end;
-	blocksize = inode->vfs_inode.i_sb->s_blocksize;
-
 	while (cur <= end) {
 		u64 disk_bytenr;
 		u64 em_end;
+		u32 iosize;
 
 		if (cur >= i_size) {
-			btrfs_writepage_endio_finish_ordered(page, cur,
-							     page_end, 1);
+			btrfs_writepage_endio_finish_ordered(page, cur, end, 1);
 			break;
 		}
 		em = btrfs_get_extent(inode, NULL, 0, cur, end - cur + 1);
@@ -3565,16 +3559,20 @@ static noinline_for_stack int __extent_writepage_io(struct btrfs_inode *inode,
 
 		extent_offset = cur - em->start;
 		em_end = extent_map_end(em);
-		BUG_ON(em_end <= cur);
-		BUG_ON(end < cur);
-		iosize = min(em_end - cur, end - cur + 1);
-		iosize = ALIGN(iosize, blocksize);
-		disk_bytenr = em->block_start + extent_offset;
+		ASSERT(cur <= em_end);
+		ASSERT(cur < end);
+		ASSERT(IS_ALIGNED(em->start, fs_info->sectorsize));
+		ASSERT(IS_ALIGNED(em->len, fs_info->sectorsize));
 		block_start = em->block_start;
 		compressed = test_bit(EXTENT_FLAG_COMPRESSED, &em->flags);
+		disk_bytenr = em->block_start + extent_offset;
+
+		/* Note that em_end from extent_map_end() is exclusive */
+		iosize = min(em_end, end + 1) - cur;
 		free_extent_map(em);
 		em = NULL;
 
+
 		/*
 		 * compressed and inline extents are written through other
 		 * paths in the FS
@@ -3587,7 +3585,6 @@ static noinline_for_stack int __extent_writepage_io(struct btrfs_inode *inode,
 				btrfs_writepage_endio_finish_ordered(page, cur,
 							cur + iosize - 1, 1);
 			cur += iosize;
-			pg_offset += iosize;
 			continue;
 		}
 
@@ -3599,8 +3596,8 @@ static noinline_for_stack int __extent_writepage_io(struct btrfs_inode *inode,
 		}
 
 		ret = submit_extent_page(REQ_OP_WRITE | write_flags, wbc,
-					 page, disk_bytenr, iosize, pg_offset,
-					 &epd->bio,
+					 page, disk_bytenr, iosize,
+					 cur - page_offset(page), &epd->bio,
 					 end_bio_extent_writepage,
 					 0, 0, 0, false);
 		if (ret) {
@@ -3609,8 +3606,7 @@ static noinline_for_stack int __extent_writepage_io(struct btrfs_inode *inode,
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

