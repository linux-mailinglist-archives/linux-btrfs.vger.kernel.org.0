Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 887F06B8B19
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Mar 2023 07:17:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230038AbjCNGRq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 14 Mar 2023 02:17:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229820AbjCNGRp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 14 Mar 2023 02:17:45 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1C4079B10
        for <linux-btrfs@vger.kernel.org>; Mon, 13 Mar 2023 23:17:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=OW11f27GQQsT39sXWyczPER17SlWvWW7NVzq19uz1aE=; b=z3uq7sXtFTGtjBeMEDLGXW+WC0
        2VRbtBnwVmiSk1QfiEpqgbTJezw8hfegd0GcvKqAYy6HRppql+/r/dZ0LTEMEjke8tMYyXlGOguE+
        uCEZbQs3+AhFHlszqbkFfXS+wDWTENCwxeTbM3TJTLxN90Xp7d6PreYW8RzVRT/9+lQHxvbdHTk36
        YsEFJa9VdPb0P5YU4DJz9qdddu8FQOQmBLuxP/9WTjrG7h2yljqmVAC7BUOitvTo+6J+PHxVyj3cc
        U4Lc/PrseHOVbL6hMQgNRIkK9LhVwSy5otbfK/A2NMRvowFixUsC18RQgD4simZ9vBLtmG5FPlwTR
        gs2iroag==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pbxyg-009Aoa-GN; Tue, 14 Mar 2023 06:17:42 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: [PATCH 14/21] btrfs: simplify the extent_buffer write end_io handler
Date:   Tue, 14 Mar 2023 07:16:48 +0100
Message-Id: <20230314061655.245340-15-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230314061655.245340-1-hch@lst.de>
References: <20230314061655.245340-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Now that we always use a single bio to write an extent_buffer, the buffer
can be passed to the end_io handler as private data.  This allows
to simplify the metadata write end I/O handler, and merge the subpage
end_io handler into the main one.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/extent_io.c | 127 +++++++++----------------------------------
 1 file changed, 27 insertions(+), 100 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index f813ce5c7e14da..d306f3a2df146e 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -1613,13 +1613,6 @@ void wait_on_extent_buffer_writeback(struct extent_buffer *eb)
 		       TASK_UNINTERRUPTIBLE);
 }
 
-static void end_extent_buffer_writeback(struct extent_buffer *eb)
-{
-	clear_bit(EXTENT_BUFFER_WRITEBACK, &eb->bflags);
-	smp_mb__after_atomic();
-	wake_up_bit(&eb->bflags, EXTENT_BUFFER_WRITEBACK);
-}
-
 /*
  * Lock extent buffer status and pages for writeback.
  *
@@ -1663,13 +1656,11 @@ static bool lock_extent_buffer_for_io(struct extent_buffer *eb,
 	return ret;
 }
 
-static void set_btree_ioerr(struct page *page, struct extent_buffer *eb)
+static void set_btree_ioerr(struct extent_buffer *eb)
 {
 	struct btrfs_fs_info *fs_info = eb->fs_info;
 
-	btrfs_page_set_error(fs_info, page, eb->start, eb->len);
-	if (test_and_set_bit(EXTENT_BUFFER_WRITE_ERR, &eb->bflags))
-		return;
+	set_bit(EXTENT_BUFFER_WRITE_ERR, &eb->bflags);
 
 	/*
 	 * A read may stumble upon this buffer later, make sure that it gets an
@@ -1683,7 +1674,7 @@ static void set_btree_ioerr(struct page *page, struct extent_buffer *eb)
 	 * return a 0 because we are readonly if we don't modify the err seq for
 	 * the superblock.
 	 */
-	mapping_set_error(page->mapping, -EIO);
+	mapping_set_error(eb->fs_info->btree_inode->i_mapping, -EIO);
 
 	/*
 	 * If writeback for a btree extent that doesn't belong to a log tree
@@ -1758,102 +1749,38 @@ static struct extent_buffer *find_extent_buffer_nolock(
 	return NULL;
 }
 
-/*
- * The endio function for subpage extent buffer write.
- *
- * Unlike end_bio_extent_buffer_writepage(), we only call end_page_writeback()
- * after all extent buffers in the page has finished their writeback.
- */
-static void end_bio_subpage_eb_writepage(struct btrfs_bio *bbio)
+static void extent_buffer_write_end_io(struct btrfs_bio *bbio)
 {
-	struct bio *bio = &bbio->bio;
-	struct btrfs_fs_info *fs_info;
-	struct bio_vec *bvec;
+	struct extent_buffer *eb = bbio->private;
+	struct btrfs_fs_info *fs_info = eb->fs_info;
+	bool uptodate = !bbio->bio.bi_status;
 	struct bvec_iter_all iter_all;
+	struct bio_vec *bvec;
+	u32 bio_offset = 0;
 
-	fs_info = btrfs_sb(bio_first_page_all(bio)->mapping->host->i_sb);
-	ASSERT(fs_info->nodesize < PAGE_SIZE);
+	if (!uptodate)
+		set_btree_ioerr(eb);
 
-	ASSERT(!bio_flagged(bio, BIO_CLONED));
-	bio_for_each_segment_all(bvec, bio, iter_all) {
+	bio_for_each_segment_all(bvec, &bbio->bio, iter_all) {
+		u64 start = eb->start + bio_offset;
 		struct page *page = bvec->bv_page;
-		u64 bvec_start = page_offset(page) + bvec->bv_offset;
-		u64 bvec_end = bvec_start + bvec->bv_len - 1;
-		u64 cur_bytenr = bvec_start;
-
-		ASSERT(IS_ALIGNED(bvec->bv_len, fs_info->nodesize));
-
-		/* Iterate through all extent buffers in the range */
-		while (cur_bytenr <= bvec_end) {
-			struct extent_buffer *eb;
-			int done;
-
-			/*
-			 * Here we can't use find_extent_buffer(), as it may
-			 * try to lock eb->refs_lock, which is not safe in endio
-			 * context.
-			 */
-			eb = find_extent_buffer_nolock(fs_info, cur_bytenr);
-			ASSERT(eb);
-
-			cur_bytenr = eb->start + eb->len;
-
-			ASSERT(test_bit(EXTENT_BUFFER_WRITEBACK, &eb->bflags));
-			done = atomic_dec_and_test(&eb->io_pages);
-			ASSERT(done);
-
-			if (bio->bi_status ||
-			    test_bit(EXTENT_BUFFER_WRITE_ERR, &eb->bflags)) {
-				btrfs_page_clear_uptodate(fs_info, page,
-							  eb->start, eb->len);
-				set_btree_ioerr(page, eb);
-			}
+		u32 len = bvec->bv_len;
+				                
+		atomic_dec(&eb->io_pages);
 
-			btrfs_subpage_clear_writeback(fs_info, page, eb->start,
-						      eb->len);
-			end_extent_buffer_writeback(eb);
-			/*
-			 * free_extent_buffer() will grab spinlock which is not
-			 * safe in endio context. Thus here we manually dec
-			 * the ref.
-			 */
-			atomic_dec(&eb->refs);
+		if (!uptodate) {
+			btrfs_page_clear_uptodate(fs_info, page, start, len);
+			btrfs_page_set_error(fs_info, page, start, len);
 		}
+		btrfs_page_clear_writeback(fs_info, page, start, len);
+		bio_offset += len;
 	}
-	bio_put(bio);
-}
-
-static void end_bio_extent_buffer_writepage(struct btrfs_bio *bbio)
-{
-	struct bio *bio = &bbio->bio;
-	struct bio_vec *bvec;
-	struct extent_buffer *eb;
-	int done;
-	struct bvec_iter_all iter_all;
 
-	ASSERT(!bio_flagged(bio, BIO_CLONED));
-	bio_for_each_segment_all(bvec, bio, iter_all) {
-		struct page *page = bvec->bv_page;
-
-		eb = (struct extent_buffer *)page->private;
-		BUG_ON(!eb);
-		done = atomic_dec_and_test(&eb->io_pages);
-
-		if (bio->bi_status ||
-		    test_bit(EXTENT_BUFFER_WRITE_ERR, &eb->bflags)) {
-			ClearPageUptodate(page);
-			set_btree_ioerr(page, eb);
-		}
-
-		end_page_writeback(page);
-
-		if (!done)
-			continue;
-
-		end_extent_buffer_writeback(eb);
-	}
+	clear_bit(EXTENT_BUFFER_WRITEBACK, &eb->bflags);
+	smp_mb__after_atomic();
+	wake_up_bit(&eb->bflags, EXTENT_BUFFER_WRITEBACK);
 
-	bio_put(bio);
+	bio_put(&bbio->bio);
 }
 
 static void prepare_eb_write(struct extent_buffer *eb)
@@ -1912,7 +1839,7 @@ static void write_one_subpage_eb(struct extent_buffer *eb,
 	bbio = btrfs_bio_alloc(INLINE_EXTENT_BUFFER_PAGES,
 			       REQ_OP_WRITE | REQ_META | wbc_to_write_flags(wbc),
 			       BTRFS_I(eb->fs_info->btree_inode),
-			       end_bio_subpage_eb_writepage, NULL);
+			       extent_buffer_write_end_io, eb);
 	bbio->bio.bi_iter.bi_sector = eb->start >> SECTOR_SHIFT;
 	bbio->file_offset = eb->start;
 	__bio_add_page(&bbio->bio, page, eb->len, eb->start - page_offset(page));
@@ -1938,7 +1865,7 @@ static noinline_for_stack void write_one_eb(struct extent_buffer *eb,
 	bbio = btrfs_bio_alloc(INLINE_EXTENT_BUFFER_PAGES,
 			       REQ_OP_WRITE | REQ_META | wbc_to_write_flags(wbc),
 			       BTRFS_I(eb->fs_info->btree_inode),
-			       end_bio_extent_buffer_writepage, NULL);
+			       extent_buffer_write_end_io, eb);
 	bbio->bio.bi_iter.bi_sector = eb->start >> SECTOR_SHIFT;
 	bbio->file_offset = eb->start;
 
-- 
2.39.2

