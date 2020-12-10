Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CFA52D53F1
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Dec 2020 07:40:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387479AbgLJGj5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 10 Dec 2020 01:39:57 -0500
Received: from mx2.suse.de ([195.135.220.15]:44098 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725789AbgLJGj5 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 10 Dec 2020 01:39:57 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1607582350; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YfOnHta0fEzKr+6XAB1v7VtZGz0rRZVR9Wst5PhJ9eU=;
        b=hlZGbyCn2if2epSEpvE7TA1OZKE1WsKiMWhmO0BBNMibK70Bi4g3j4Iaq7No/7YUxVY929
        XdB+Y/jOr9E/rrb9+tjwWABaM6XJSSRakB2R8vJ/EHul3tx8CMt6umiXjeMJ8nimKNcsXH
        FNEU+slVvE3xDk4Toz3v0swcahQRIiY=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id AC2A8AC6A
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Dec 2020 06:39:10 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 01/18] btrfs: extent_io: rename @offset parameter to @disk_bytenr for submit_extent_page()
Date:   Thu, 10 Dec 2020 14:38:48 +0800
Message-Id: <20201210063905.75727-2-wqu@suse.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201210063905.75727-1-wqu@suse.com>
References: <20201210063905.75727-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The parameter @offset can't be more confusing.
In fact that parameter is the disk bytenr for metadata/data.

Rename it to @disk_bytenr and update the comment to reduce confusion.

Since we're here, also rename all @offset passed into
submit_extent_page() to @disk_bytenr.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent_io.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 6e3b72e63e42..2650e8720394 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -3064,10 +3064,10 @@ struct bio *btrfs_bio_clone_partial(struct bio *orig, int offset, int size)
  * @opf:	bio REQ_OP_* and REQ_* flags as one value
  * @wbc:	optional writeback control for io accounting
  * @page:	page to add to the bio
+ * @disk_bytenr:the logical bytenr where the write will be
+ * @size:	portion of page that we want to write
  * @pg_offset:	offset of the new bio or to check whether we are adding
  *              a contiguous page to the previous one
- * @size:	portion of page that we want to write
- * @offset:	starting offset in the page
  * @bio_ret:	must be valid pointer, newly allocated bio will be stored there
  * @end_io_func:     end_io callback for new bio
  * @mirror_num:	     desired mirror to read/write
@@ -3076,7 +3076,7 @@ struct bio *btrfs_bio_clone_partial(struct bio *orig, int offset, int size)
  */
 static int submit_extent_page(unsigned int opf,
 			      struct writeback_control *wbc,
-			      struct page *page, u64 offset,
+			      struct page *page, u64 disk_bytenr,
 			      size_t size, unsigned long pg_offset,
 			      struct bio **bio_ret,
 			      bio_end_io_t end_io_func,
@@ -3088,7 +3088,7 @@ static int submit_extent_page(unsigned int opf,
 	int ret = 0;
 	struct bio *bio;
 	size_t io_size = min_t(size_t, size, PAGE_SIZE);
-	sector_t sector = offset >> 9;
+	sector_t sector = disk_bytenr >> 9;
 	struct extent_io_tree *tree = &BTRFS_I(page->mapping->host)->io_tree;
 
 	ASSERT(bio_ret);
@@ -3122,7 +3122,7 @@ static int submit_extent_page(unsigned int opf,
 		}
 	}
 
-	bio = btrfs_bio_alloc(offset);
+	bio = btrfs_bio_alloc(disk_bytenr);
 	bio_add_page(bio, page, io_size, pg_offset);
 	bio->bi_end_io = end_io_func;
 	bio->bi_private = tree;
@@ -3244,7 +3244,7 @@ int btrfs_do_readpage(struct page *page, struct extent_map **em_cached,
 	}
 	while (cur <= end) {
 		bool force_bio_submit = false;
-		u64 offset;
+		u64 disk_bytenr;
 
 		if (cur >= last_byte) {
 			char *userpage;
@@ -3282,9 +3282,9 @@ int btrfs_do_readpage(struct page *page, struct extent_map **em_cached,
 		cur_end = min(extent_map_end(em) - 1, end);
 		iosize = ALIGN(iosize, blocksize);
 		if (this_bio_flag & EXTENT_BIO_COMPRESSED)
-			offset = em->block_start;
+			disk_bytenr = em->block_start;
 		else
-			offset = em->block_start + extent_offset;
+			disk_bytenr = em->block_start + extent_offset;
 		block_start = em->block_start;
 		if (test_bit(EXTENT_FLAG_PREALLOC, &em->flags))
 			block_start = EXTENT_MAP_HOLE;
@@ -3373,7 +3373,7 @@ int btrfs_do_readpage(struct page *page, struct extent_map **em_cached,
 		}
 
 		ret = submit_extent_page(REQ_OP_READ | read_flags, NULL,
-					 page, offset, iosize,
+					 page, disk_bytenr, iosize,
 					 pg_offset, bio,
 					 end_bio_extent_readpage, 0,
 					 *bio_flags,
@@ -3550,8 +3550,8 @@ static noinline_for_stack int __extent_writepage_io(struct btrfs_inode *inode,
 	blocksize = inode->vfs_inode.i_sb->s_blocksize;
 
 	while (cur <= end) {
+		u64 disk_bytenr;
 		u64 em_end;
-		u64 offset;
 
 		if (cur >= i_size) {
 			btrfs_writepage_endio_finish_ordered(page, cur,
@@ -3571,7 +3571,7 @@ static noinline_for_stack int __extent_writepage_io(struct btrfs_inode *inode,
 		BUG_ON(end < cur);
 		iosize = min(em_end - cur, end - cur + 1);
 		iosize = ALIGN(iosize, blocksize);
-		offset = em->block_start + extent_offset;
+		disk_bytenr = em->block_start + extent_offset;
 		block_start = em->block_start;
 		compressed = test_bit(EXTENT_FLAG_COMPRESSED, &em->flags);
 		free_extent_map(em);
@@ -3601,7 +3601,7 @@ static noinline_for_stack int __extent_writepage_io(struct btrfs_inode *inode,
 		}
 
 		ret = submit_extent_page(REQ_OP_WRITE | write_flags, wbc,
-					 page, offset, iosize, pg_offset,
+					 page, disk_bytenr, iosize, pg_offset,
 					 &epd->bio,
 					 end_bio_extent_writepage,
 					 0, 0, 0, false);
@@ -3925,7 +3925,7 @@ static noinline_for_stack int write_one_eb(struct extent_buffer *eb,
 			struct writeback_control *wbc,
 			struct extent_page_data *epd)
 {
-	u64 offset = eb->start;
+	u64 disk_bytenr = eb->start;
 	u32 nritems;
 	int i, num_pages;
 	unsigned long start, end;
@@ -3958,7 +3958,7 @@ static noinline_for_stack int write_one_eb(struct extent_buffer *eb,
 		clear_page_dirty_for_io(p);
 		set_page_writeback(p);
 		ret = submit_extent_page(REQ_OP_WRITE | write_flags, wbc,
-					 p, offset, PAGE_SIZE, 0,
+					 p, disk_bytenr, PAGE_SIZE, 0,
 					 &epd->bio,
 					 end_bio_extent_buffer_writepage,
 					 0, 0, 0, false);
@@ -3971,7 +3971,7 @@ static noinline_for_stack int write_one_eb(struct extent_buffer *eb,
 			ret = -EIO;
 			break;
 		}
-		offset += PAGE_SIZE;
+		disk_bytenr += PAGE_SIZE;
 		update_nr_written(wbc, 1);
 		unlock_page(p);
 	}
-- 
2.29.2

