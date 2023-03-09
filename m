Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FC656B1F62
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Mar 2023 10:07:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229758AbjCIJHv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 9 Mar 2023 04:07:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230309AbjCIJHP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 9 Mar 2023 04:07:15 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 233A462DAA
        for <linux-btrfs@vger.kernel.org>; Thu,  9 Mar 2023 01:06:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=kM5FQFYZolh/5Ygmla1w4+TIuoEClc8UVLsn6V1YF60=; b=K+j/lI2mfow0SFNCzdKGqeinSr
        DmsbOzvoqzaVpSaVtC5WTDE01uUuNX+Qsmybu4oFkDWvYGi07deMu8SwFneJH4FA03Zqo+GHsBSnP
        C+mAGMEtho5EC5FqTo3AN0ac8Fa0bCpJPm+WhIOpPbjJm071daIzFecoJgBv2gFJtimcamy2bw0vE
        fpuIPc70dm57rNFoRi8TlEvwbe6YM+dRdRVv/8zkwU28calKEZzlpPsKmvvoNGFtzFCctilgRmJgD
        Rl9FfGof44HHM8i79AM7G9Oa1fzuABph6fhoPFcUhm+lXmMSBFVRN+iPQWS2bQUgmdp56WgDpAaNE
        G+sSE4fA==;
Received: from [2001:4bb8:190:782d:bc9d:fa49:9fec:5662] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1paCEU-008huM-3g; Thu, 09 Mar 2023 09:06:42 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: [PATCH 13/20] btrfs: simplify the extent_buffer write end_io handler
Date:   Thu,  9 Mar 2023 10:05:19 +0100
Message-Id: <20230309090526.332550-14-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230309090526.332550-1-hch@lst.de>
References: <20230309090526.332550-1-hch@lst.de>
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

Now that we always use a single bio to write an extent_buffer, the buffer
can be passed to the end_io handler as private data.  This allows
to simplify the metadata write end I/O handler, and merge the subpage
version into the main one with just a single conditional.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/extent_io.c | 112 +++++++++----------------------------------
 1 file changed, 23 insertions(+), 89 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 1d7f48190ee9b9..16522bcf5d4a10 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -1663,13 +1663,11 @@ static bool lock_extent_buffer_for_io(struct extent_buffer *eb,
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
@@ -1683,7 +1681,7 @@ static void set_btree_ioerr(struct page *page, struct extent_buffer *eb)
 	 * return a 0 because we are readonly if we don't modify the err seq for
 	 * the superblock.
 	 */
-	mapping_set_error(page->mapping, -EIO);
+	mapping_set_error(eb->fs_info->btree_inode->i_mapping, -EIO);
 
 	/*
 	 * If writeback for a btree extent that doesn't belong to a log tree
@@ -1758,101 +1756,37 @@ static struct extent_buffer *find_extent_buffer_nolock(
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
-
-	fs_info = btrfs_sb(bio_first_page_all(bio)->mapping->host->i_sb);
-	ASSERT(fs_info->nodesize < PAGE_SIZE);
-
-	ASSERT(!bio_flagged(bio, BIO_CLONED));
-	bio_for_each_segment_all(bvec, bio, iter_all) {
-		struct page *page = bvec->bv_page;
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
-				ClearPageUptodate(page);
-				set_btree_ioerr(page, eb);
-			}
-
-			btrfs_subpage_clear_writeback(fs_info, page, eb->start,
-						      eb->len);
-			end_extent_buffer_writeback(eb);
-			/*
-			 * free_extent_buffer() will grab spinlock which is not
-			 * safe in endio context. Thus here we manually dec
-			 * the ref.
-			 */
-			atomic_dec(&eb->refs);
-		}
-	}
-	bio_put(bio);
-}
-
-static void end_bio_extent_buffer_writepage(struct btrfs_bio *bbio)
-{
-	struct bio *bio = &bbio->bio;
 	struct bio_vec *bvec;
-	struct extent_buffer *eb;
-	int done;
-	struct bvec_iter_all iter_all;
 
-	ASSERT(!bio_flagged(bio, BIO_CLONED));
-	bio_for_each_segment_all(bvec, bio, iter_all) {
+	if (!uptodate)
+		set_btree_ioerr(eb);
+
+	bio_for_each_segment_all(bvec, &bbio->bio, iter_all) {
 		struct page *page = bvec->bv_page;
 
-		eb = (struct extent_buffer *)page->private;
-		BUG_ON(!eb);
-		done = atomic_dec_and_test(&eb->io_pages);
+		atomic_dec(&eb->io_pages);
 
-		if (bio->bi_status ||
-		    test_bit(EXTENT_BUFFER_WRITE_ERR, &eb->bflags)) {
+		if (!uptodate) {
 			ClearPageUptodate(page);
-			set_btree_ioerr(page, eb);
+			btrfs_page_set_error(fs_info, page, eb->start, eb->len);
 		}
 
-		end_page_writeback(page);
-
-		if (!done)
-			continue;
+		if (fs_info->nodesize < PAGE_SIZE)
+			btrfs_subpage_clear_writeback(fs_info, page, eb->start,
+						      eb->len);
+		else
+			end_page_writeback(page);
 
-		end_extent_buffer_writeback(eb);
 	}
+	end_extent_buffer_writeback(eb);
 
-	bio_put(bio);
+	bio_put(&bbio->bio);
 }
 
 static void prepare_eb_write(struct extent_buffer *eb)
@@ -1911,7 +1845,7 @@ static void write_one_subpage_eb(struct extent_buffer *eb,
 	bbio = btrfs_bio_alloc(INLINE_EXTENT_BUFFER_PAGES,
 			       REQ_OP_WRITE | REQ_META | wbc_to_write_flags(wbc),
 			       BTRFS_I(eb->fs_info->btree_inode),
-			       end_bio_subpage_eb_writepage, NULL);
+			       extent_buffer_write_end_io, eb);
 	bbio->bio.bi_iter.bi_sector = eb->start >> SECTOR_SHIFT;
 	bbio->file_offset = eb->start;
 	__bio_add_page(&bbio->bio, page, eb->len, eb->start - page_offset(page));
@@ -1937,7 +1871,7 @@ static noinline_for_stack void write_one_eb(struct extent_buffer *eb,
 	bbio = btrfs_bio_alloc(INLINE_EXTENT_BUFFER_PAGES,
 			       REQ_OP_WRITE | REQ_META | wbc_to_write_flags(wbc),
 			       BTRFS_I(eb->fs_info->btree_inode),
-			       end_bio_extent_buffer_writepage, NULL);
+			       extent_buffer_write_end_io, eb);
 	bbio->bio.bi_iter.bi_sector = eb->start >> SECTOR_SHIFT;
 	bbio->file_offset = eb->start;
 
-- 
2.39.2

