Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B47F16B1F5A
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Mar 2023 10:07:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231138AbjCIJHU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 9 Mar 2023 04:07:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230381AbjCIJGy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 9 Mar 2023 04:06:54 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62A0F19A1
        for <linux-btrfs@vger.kernel.org>; Thu,  9 Mar 2023 01:06:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=yQsWM1Bk3shMCIfHSxn1hgNLy48JF9IgPT5wJgPtrgc=; b=ZLXrcTCekFqISefYH0LHoK/FEo
        9+efILcxIu7txOOtyZdy75aOzP82Oqqp+HQDKau9gvY5lGKGP1pgk2MExE3mNRN47rcsnl7acS7Yc
        tkob5OpO+ZTOc+meNvOrh3z49Jy/ruR1ngnWsNAfRQZdPqhuJDYx/JonJaKUSzKolDAuAjsOzmcgd
        /9ho4CGJRyG2j2g3S9XnwdIs+jR8FYEhPTcJa3oe9YD8gOEGkCiK3fxioy+c2xjPWFAFbZnzzV5NW
        brB5maVOXpGk7fPadQPOJjbo5v8JIjah6X1njmdhjRzRTAyPzmYR0aQTcvCJYq4ucc+1Zm3RCYQzQ
        gkgEGqLA==;
Received: from [2001:4bb8:190:782d:bc9d:fa49:9fec:5662] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1paCE3-008hhk-QM; Thu, 09 Mar 2023 09:06:16 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: [PATCH 07/20] btrfs: simplify the read_extent_buffer end_io handler
Date:   Thu,  9 Mar 2023 10:05:13 +0100
Message-Id: <20230309090526.332550-8-hch@lst.de>
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

Now that we always use a single bio to read an extent_buffer, the buffer
can be passed to the end_io handler as private data.  This allows
implementing a much simplified dedicated end I/O handler for metadata
reads.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/disk-io.c   | 105 +------------------------------------------
 fs/btrfs/disk-io.h   |   5 +--
 fs/btrfs/extent_io.c |  80 +++++++++++++++------------------
 3 files changed, 41 insertions(+), 149 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index d03b431b07781c..6795acae476993 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -485,8 +485,8 @@ static int check_tree_block_fsid(struct extent_buffer *eb)
 }
 
 /* Do basic extent buffer checks at read time */
-static int validate_extent_buffer(struct extent_buffer *eb,
-				  struct btrfs_tree_parent_check *check)
+int btrfs_validate_extent_buffer(struct extent_buffer *eb,
+				 struct btrfs_tree_parent_check *check)
 {
 	struct btrfs_fs_info *fs_info = eb->fs_info;
 	u64 found_start;
@@ -599,107 +599,6 @@ static int validate_extent_buffer(struct extent_buffer *eb,
 	return ret;
 }
 
-static int validate_subpage_buffer(struct page *page, u64 start, u64 end,
-				   int mirror, struct btrfs_tree_parent_check *check)
-{
-	struct btrfs_fs_info *fs_info = btrfs_sb(page->mapping->host->i_sb);
-	struct extent_buffer *eb;
-	bool reads_done;
-	int ret = 0;
-
-	ASSERT(check);
-
-	/*
-	 * We don't allow bio merge for subpage metadata read, so we should
-	 * only get one eb for each endio hook.
-	 */
-	ASSERT(end == start + fs_info->nodesize - 1);
-	ASSERT(PagePrivate(page));
-
-	eb = find_extent_buffer(fs_info, start);
-	/*
-	 * When we are reading one tree block, eb must have been inserted into
-	 * the radix tree. If not, something is wrong.
-	 */
-	ASSERT(eb);
-
-	reads_done = atomic_dec_and_test(&eb->io_pages);
-	/* Subpage read must finish in page read */
-	ASSERT(reads_done);
-
-	eb->read_mirror = mirror;
-	if (test_bit(EXTENT_BUFFER_READ_ERR, &eb->bflags)) {
-		ret = -EIO;
-		goto err;
-	}
-	ret = validate_extent_buffer(eb, check);
-	if (ret < 0)
-		goto err;
-
-	set_extent_buffer_uptodate(eb);
-
-	free_extent_buffer(eb);
-	return ret;
-err:
-	/*
-	 * end_bio_extent_readpage decrements io_pages in case of error,
-	 * make sure it has something to decrement.
-	 */
-	atomic_inc(&eb->io_pages);
-	clear_extent_buffer_uptodate(eb);
-	free_extent_buffer(eb);
-	return ret;
-}
-
-int btrfs_validate_metadata_buffer(struct btrfs_bio *bbio,
-				   struct page *page, u64 start, u64 end,
-				   int mirror)
-{
-	struct extent_buffer *eb;
-	int ret = 0;
-	int reads_done;
-
-	ASSERT(page->private);
-
-	if (btrfs_sb(page->mapping->host->i_sb)->nodesize < PAGE_SIZE)
-		return validate_subpage_buffer(page, start, end, mirror,
-					       &bbio->parent_check);
-
-	eb = (struct extent_buffer *)page->private;
-
-	/*
-	 * The pending IO might have been the only thing that kept this buffer
-	 * in memory.  Make sure we have a ref for all this other checks
-	 */
-	atomic_inc(&eb->refs);
-
-	reads_done = atomic_dec_and_test(&eb->io_pages);
-	if (!reads_done)
-		goto err;
-
-	eb->read_mirror = mirror;
-	if (test_bit(EXTENT_BUFFER_READ_ERR, &eb->bflags)) {
-		ret = -EIO;
-		goto err;
-	}
-	ret = validate_extent_buffer(eb, &bbio->parent_check);
-	if (!ret)
-		set_extent_buffer_uptodate(eb);
-err:
-	if (ret) {
-		/*
-		 * our io error hook is going to dec the io pages
-		 * again, we have to make sure it has something
-		 * to decrement
-		 */
-		atomic_inc(&eb->io_pages);
-		clear_extent_buffer_uptodate(eb);
-	}
-	free_extent_buffer(eb);
-
-	return ret;
-}
-
 #ifdef CONFIG_MIGRATION
 static int btree_migrate_folio(struct address_space *mapping,
 		struct folio *dst, struct folio *src, enum migrate_mode mode)
diff --git a/fs/btrfs/disk-io.h b/fs/btrfs/disk-io.h
index 4d577233011023..2923b5d7cfca0b 100644
--- a/fs/btrfs/disk-io.h
+++ b/fs/btrfs/disk-io.h
@@ -84,9 +84,8 @@ void btrfs_btree_balance_dirty(struct btrfs_fs_info *fs_info);
 void btrfs_btree_balance_dirty_nodelay(struct btrfs_fs_info *fs_info);
 void btrfs_drop_and_free_fs_root(struct btrfs_fs_info *fs_info,
 				 struct btrfs_root *root);
-int btrfs_validate_metadata_buffer(struct btrfs_bio *bbio,
-				   struct page *page, u64 start, u64 end,
-				   int mirror);
+int btrfs_validate_extent_buffer(struct extent_buffer *eb,
+				 struct btrfs_tree_parent_check *check);
 #ifdef CONFIG_BTRFS_FS_RUN_SANITY_TESTS
 struct btrfs_root *btrfs_alloc_dummy_root(struct btrfs_fs_info *fs_info);
 #endif
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index d60a80572b8ba2..738fcf5cbc71d6 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -663,35 +663,6 @@ static void begin_page_read(struct btrfs_fs_info *fs_info, struct page *page)
 	btrfs_subpage_start_reader(fs_info, page, page_offset(page), PAGE_SIZE);
 }
 
-/*
- * Find extent buffer for a givne bytenr.
- *
- * This is for end_bio_extent_readpage(), thus we can't do any unsafe locking
- * in endio context.
- */
-static struct extent_buffer *find_extent_buffer_readpage(
-		struct btrfs_fs_info *fs_info, struct page *page, u64 bytenr)
-{
-	struct extent_buffer *eb;
-
-	/*
-	 * For regular sectorsize, we can use page->private to grab extent
-	 * buffer
-	 */
-	if (fs_info->nodesize >= PAGE_SIZE) {
-		ASSERT(PagePrivate(page) && page->private);
-		return (struct extent_buffer *)page->private;
-	}
-
-	/* For subpage case, we need to lookup buffer radix tree */
-	rcu_read_lock();
-	eb = radix_tree_lookup(&fs_info->buffer_radix,
-			       bytenr >> fs_info->sectorsize_bits);
-	rcu_read_unlock();
-	ASSERT(eb);
-	return eb;
-}
-
 /*
  * after a readpage IO is done, we need to:
  * clear the uptodate bits on error
@@ -713,7 +684,6 @@ static void end_bio_extent_readpage(struct btrfs_bio *bbio)
 	 * larger than UINT_MAX, u32 here is enough.
 	 */
 	u32 bio_offset = 0;
-	int mirror;
 	struct bvec_iter_all iter_all;
 
 	ASSERT(!bio_flagged(bio, BIO_CLONED));
@@ -753,11 +723,6 @@ static void end_bio_extent_readpage(struct btrfs_bio *bbio)
 		end = start + bvec->bv_len - 1;
 		len = bvec->bv_len;
 
-		mirror = bbio->mirror_num;
-		if (uptodate && !is_data_inode(inode) &&
-		    btrfs_validate_metadata_buffer(bbio, page, start, end, mirror))
-			uptodate = false;
-
 		if (likely(uptodate)) {
 			loff_t i_size = i_size_read(inode);
 			pgoff_t end_index = i_size >> PAGE_SHIFT;
@@ -778,13 +743,6 @@ static void end_bio_extent_readpage(struct btrfs_bio *bbio)
 				zero_user_segment(page, zero_start,
 						  offset_in_page(end) + 1);
 			}
-		} else if (!is_data_inode(inode)) {
-			struct extent_buffer *eb;
-
-			eb = find_extent_buffer_readpage(fs_info, page, start);
-			set_bit(EXTENT_BUFFER_READ_ERR, &eb->bflags);
-			eb->read_mirror = mirror;
-			atomic_dec(&eb->io_pages);
 		}
 
 		/* Update page status and unlock. */
@@ -4219,6 +4177,42 @@ void set_extent_buffer_uptodate(struct extent_buffer *eb)
 	}
 }
 
+static void extent_buffer_read_end_io(struct btrfs_bio *bbio)
+{
+	struct extent_buffer *eb = bbio->private;
+	bool uptodate = !bbio->bio.bi_status;
+	struct bvec_iter_all iter_all;
+	struct bio_vec *bvec;
+	u32 bio_offset = 0;
+
+	atomic_inc(&eb->refs);
+	eb->read_mirror = bbio->mirror_num;
+
+	if (uptodate &&
+	    btrfs_validate_extent_buffer(eb, &bbio->parent_check) < 0)
+		uptodate = false;
+
+	if (uptodate) {
+		set_extent_buffer_uptodate(eb);
+	} else {
+		clear_extent_buffer_uptodate(eb);
+		set_bit(EXTENT_BUFFER_READ_ERR, &eb->bflags);
+	}
+
+	bio_for_each_segment_all(bvec, &bbio->bio, iter_all) {
+		atomic_dec(&eb->io_pages);
+		end_page_read(bvec->bv_page, uptodate, eb->start + bio_offset,
+			      bvec->bv_len);
+		bio_offset += bvec->bv_len;
+	}
+
+	unlock_extent(&bbio->inode->io_tree, eb->start,
+		      eb->start + bio_offset - 1, NULL);
+	free_extent_buffer(eb);
+
+	bio_put(&bbio->bio);
+}
+
 static void __read_extent_buffer_pages(struct extent_buffer *eb, int mirror_num,
 				       struct btrfs_tree_parent_check *check)
 {
@@ -4233,7 +4227,7 @@ static void __read_extent_buffer_pages(struct extent_buffer *eb, int mirror_num,
 	bbio = btrfs_bio_alloc(INLINE_EXTENT_BUFFER_PAGES,
 			       REQ_OP_READ | REQ_META,
 			       BTRFS_I(eb->fs_info->btree_inode),
-			       end_bio_extent_readpage, NULL);
+			       extent_buffer_read_end_io, eb);
 	bbio->bio.bi_iter.bi_sector = eb->start >> SECTOR_SHIFT;
 	bbio->file_offset = eb->start;
 	memcpy(&bbio->parent_check, check, sizeof(*check));
-- 
2.39.2

