Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C43FB699A2D
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Feb 2023 17:35:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229718AbjBPQfG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 16 Feb 2023 11:35:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229888AbjBPQfF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 16 Feb 2023 11:35:05 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05ABB497C6
        for <linux-btrfs@vger.kernel.org>; Thu, 16 Feb 2023 08:35:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=2DlXquWkX4O+lYRhCi+1LOZ2WsriamW7VRzsBwrOMn4=; b=EhHt7CLoiiB6sBzNWYGizGvtlR
        p+/xenWgiUmu48h6NK2cOgZX46Pr9C07VBmAXferqZEZp+4kVgW9hT3u0Tvcuu3AU/UcRJfsfErp8
        oa9XFXyjaauD82kf8nKFiQttjt0VqGSYaItX/Vbg+dHL8ylO05OhPzNsxwK+7iwMjmcu/b3HPtlOI
        CN/JcwCPLUz7Rj+bkOytCy5Zz7BJHNCm5iDEPFkKUPjY7d9hlgfknPLBiYMj+C6puz7wkEtANDD9U
        Xh9/MMNto8/upezG4Z580U6Lzi38H1e6FwcMhFYab+r0lbjnURm13YsHWDbzhAD38mgaRONXpLft9
        OKQZqziQ==;
Received: from [2001:4bb8:181:6771:37af:42b9:3236:81df] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pShDo-00BD2e-Sb; Thu, 16 Feb 2023 16:35:01 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: [PATCH 08/12] btrfs: remove the compress_type argument to submit_extent_page
Date:   Thu, 16 Feb 2023 17:34:33 +0100
Message-Id: <20230216163437.2370948-9-hch@lst.de>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230216163437.2370948-1-hch@lst.de>
References: <20230216163437.2370948-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Update the compress_type in the btrfs_bio_ctrl after forcing out the
previous bio in btrfs_do_readpage, so that alloc_new_bio can just use
the compress_type member in struct btrfs_bio_ctrl instead of passing the
same information redudantly as a function argument.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/extent_io.c | 31 ++++++++++++++-----------------
 1 file changed, 14 insertions(+), 17 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 24a1e988dd0fab..10134db6057443 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -967,8 +967,7 @@ static void calc_bio_boundaries(struct btrfs_bio_ctrl *bio_ctrl,
 
 static void alloc_new_bio(struct btrfs_inode *inode,
 			  struct btrfs_bio_ctrl *bio_ctrl,
-			  u64 disk_bytenr, u32 offset, u64 file_offset,
-			  enum btrfs_compression_type compress_type)
+			  u64 disk_bytenr, u32 offset, u64 file_offset)
 {
 	struct btrfs_fs_info *fs_info = inode->root->fs_info;
 	struct bio *bio;
@@ -979,13 +978,12 @@ static void alloc_new_bio(struct btrfs_inode *inode,
 	 * For compressed page range, its disk_bytenr is always @disk_bytenr
 	 * passed in, no matter if we have added any range into previous bio.
 	 */
-	if (compress_type != BTRFS_COMPRESS_NONE)
+	if (bio_ctrl->compress_type != BTRFS_COMPRESS_NONE)
 		bio->bi_iter.bi_sector = disk_bytenr >> SECTOR_SHIFT;
 	else
 		bio->bi_iter.bi_sector = (disk_bytenr + offset) >> SECTOR_SHIFT;
 	btrfs_bio(bio)->file_offset = file_offset;
 	bio_ctrl->bio = bio;
-	bio_ctrl->compress_type = compress_type;
 	calc_bio_boundaries(bio_ctrl, inode, file_offset);
 
 	if (bio_ctrl->wbc) {
@@ -1006,7 +1004,6 @@ static void alloc_new_bio(struct btrfs_inode *inode,
  * @size:	portion of page that we want to write to
  * @pg_offset:	offset of the new bio or to check whether we are adding
  *              a contiguous page to the previous one
- * @compress_type:   compress type for current bio
  *
  * The will either add the page into the existing @bio_ctrl->bio, or allocate a
  * new one in @bio_ctrl->bio.
@@ -1015,8 +1012,7 @@ static void alloc_new_bio(struct btrfs_inode *inode,
  */
 static int submit_extent_page(struct btrfs_bio_ctrl *bio_ctrl,
 			      u64 disk_bytenr, struct page *page,
-			      size_t size, unsigned long pg_offset,
-			      enum btrfs_compression_type compress_type)
+			      size_t size, unsigned long pg_offset)
 {
 	struct btrfs_inode *inode = BTRFS_I(page->mapping->host);
 	unsigned int cur = pg_offset;
@@ -1035,14 +1031,13 @@ static int submit_extent_page(struct btrfs_bio_ctrl *bio_ctrl,
 		/* Allocate new bio if needed */
 		if (!bio_ctrl->bio) {
 			alloc_new_bio(inode, bio_ctrl, disk_bytenr,
-				      offset, page_offset(page) + cur,
-				      compress_type);
+				      offset, page_offset(page) + cur);
 		}
 		/*
 		 * We must go through btrfs_bio_add_page() to ensure each
 		 * page range won't cross various boundaries.
 		 */
-		if (compress_type != BTRFS_COMPRESS_NONE)
+		if (bio_ctrl->compress_type != BTRFS_COMPRESS_NONE)
 			added = btrfs_bio_add_page(bio_ctrl, page, disk_bytenr,
 					size - offset, pg_offset + offset);
 		else
@@ -1314,13 +1309,15 @@ static int btrfs_do_readpage(struct page *page, struct extent_map **em_cached,
 			continue;
 		}
 
-		if (bio_ctrl->compress_type != compress_type)
+		if (bio_ctrl->compress_type != compress_type) {
 			submit_one_bio(bio_ctrl);
+			bio_ctrl->compress_type = compress_type;
+		}
 	
 		if (force_bio_submit)
 			submit_one_bio(bio_ctrl);
 		ret = submit_extent_page(bio_ctrl, disk_bytenr, page, iosize,
-					 pg_offset, compress_type);
+					 pg_offset);
 		if (ret) {
 			/*
 			 * We have to unlock the remaining range, or the page
@@ -1626,7 +1623,7 @@ static noinline_for_stack int __extent_writepage_io(struct btrfs_inode *inode,
 		btrfs_page_clear_dirty(fs_info, page, cur, iosize);
 
 		ret = submit_extent_page(bio_ctrl, disk_bytenr, page,
-					 iosize, cur - page_offset(page), 0);
+					 iosize, cur - page_offset(page));
 		if (ret) {
 			has_error = true;
 			if (!saved_ret)
@@ -2118,7 +2115,7 @@ static int write_one_subpage_eb(struct extent_buffer *eb,
 	bio_ctrl->end_io_func = end_bio_subpage_eb_writepage;
 
 	ret = submit_extent_page(bio_ctrl, eb->start, page, eb->len,
-			eb->start - page_offset(page), 0);
+			eb->start - page_offset(page));
 	if (ret) {
 		btrfs_subpage_clear_writeback(fs_info, page, eb->start, eb->len);
 		set_btree_ioerr(page, eb);
@@ -2156,7 +2153,7 @@ static noinline_for_stack int write_one_eb(struct extent_buffer *eb,
 		clear_page_dirty_for_io(p);
 		set_page_writeback(p);
 		ret = submit_extent_page(bio_ctrl, disk_bytenr, p,
-					 PAGE_SIZE, 0, 0);
+					 PAGE_SIZE, 0);
 		if (ret) {
 			set_btree_ioerr(p, eb);
 			if (PageWriteback(p))
@@ -4427,7 +4424,7 @@ static int read_extent_buffer_subpage(struct extent_buffer *eb, int wait,
 
 	btrfs_subpage_start_reader(fs_info, page, eb->start, eb->len);
 	ret = submit_extent_page(&bio_ctrl, eb->start, page, eb->len,
-				 eb->start - page_offset(page), 0);
+				 eb->start - page_offset(page));
 	if (ret) {
 		/*
 		 * In the endio function, if we hit something wrong we will
@@ -4538,7 +4535,7 @@ int read_extent_buffer_pages(struct extent_buffer *eb, int wait, int mirror_num,
 			ClearPageError(page);
 			err = submit_extent_page(&bio_ctrl,
 						 page_offset(page), page,
-						 PAGE_SIZE, 0, 0);
+						 PAGE_SIZE, 0);
 			if (err) {
 				/*
 				 * We failed to submit the bio so it's the
-- 
2.39.1

