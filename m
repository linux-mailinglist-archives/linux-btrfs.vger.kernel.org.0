Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CC285699DD
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 Jul 2022 07:34:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234978AbiGGFdr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 7 Jul 2022 01:33:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234982AbiGGFdq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 7 Jul 2022 01:33:46 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 966662F64E
        for <linux-btrfs@vger.kernel.org>; Wed,  6 Jul 2022 22:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=F+Mh/dPL3NaCXg1B1fFji4zj1Rsc7oXCNRiGsGl0zAQ=; b=zCnUrbGIBNn6KRX6tCQMXllAMr
        2dGqOiIxkznnAAD6uxgHe/hGqNLIjSiWwuf9hOsv6caQ3RtL3qO35rYKu6He1coa6U17++UWDeK38
        LBI2SpDaqC74gXS30jDxfj2v3+P969TcQm55N+cgiaQhdN0dQJWWPMcsIm9sed104nb6wrjsKAVsi
        5x8k1vByMMijZyG+6aZ2Mg9PTAYS6+OUp0RtXU5R5LyQGxFo4ApwyGW5cftHZt4MkETE+AP4UoRVV
        zNtRekmAyHYaqwp8upIBH+Z1feL9wzjo3kwJrqKyzfIikbXe45+er07ur3pOl00TGtOBm/E3m1tut
        SIsiGJBA==;
Received: from [2001:4bb8:189:3c4a:8caf:7f2b:dda6:253] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o9K90-00DlaG-TP; Thu, 07 Jul 2022 05:33:43 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: [PATCH 3/6] btrfs: pass a btrfs_bio to btrfs_repair_one_sector
Date:   Thu,  7 Jul 2022 07:33:28 +0200
Message-Id: <20220707053331.211259-4-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220707053331.211259-1-hch@lst.de>
References: <20220707053331.211259-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Pass the btrfs_bio instead of the plain bio to btrfs_repair_one_sector,
an remove the start and failed_mirror arguments in favor of deriving
them from the btrfs_bio.  For this to work ensure that the file_offset
field is also initialized for buffered I/O.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/extent_io.c | 47 ++++++++++++++++++++++++--------------------
 fs/btrfs/extent_io.h |  8 ++++----
 fs/btrfs/inode.c     |  5 ++---
 3 files changed, 32 insertions(+), 28 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 3778d58092dea..ec7bdb3fa0921 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -182,6 +182,7 @@ static int add_extent_changeset(struct extent_state *state, u32 bits,
 static void submit_one_bio(struct btrfs_bio_ctrl *bio_ctrl)
 {
 	struct bio *bio;
+	struct bio_vec *bv;
 	struct inode *inode;
 	int mirror_num;
 
@@ -189,12 +190,15 @@ static void submit_one_bio(struct btrfs_bio_ctrl *bio_ctrl)
 		return;
 
 	bio = bio_ctrl->bio;
-	inode = bio_first_page_all(bio)->mapping->host;
+	bv = bio_first_bvec_all(bio);
+	inode = bv->bv_page->mapping->host;
 	mirror_num = bio_ctrl->mirror_num;
 
 	/* Caller should ensure the bio has at least some range added */
 	ASSERT(bio->bi_iter.bi_size);
 
+	btrfs_bio(bio)->file_offset = page_offset(bv->bv_page) + bv->bv_offset;
+
 	if (!is_data_inode(inode))
 		btrfs_submit_metadata_bio(inode, bio, mirror_num);
 	else if (btrfs_op(bio) == BTRFS_MAP_WRITE)
@@ -2533,10 +2537,11 @@ void btrfs_free_io_failure_record(struct btrfs_inode *inode, u64 start, u64 end)
 }
 
 static struct io_failure_record *btrfs_get_io_failure_record(struct inode *inode,
-							     u64 start,
-							     int failed_mirror)
+							     struct btrfs_bio *bbio,
+							     unsigned int bio_offset)
 {
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
+	u64 start = bbio->file_offset + bio_offset;
 	struct io_failure_record *failrec;
 	struct extent_map *em;
 	struct extent_io_tree *failure_tree = &BTRFS_I(inode)->io_failure_tree;
@@ -2556,7 +2561,7 @@ static struct io_failure_record *btrfs_get_io_failure_record(struct inode *inode
 		 * (e.g. with a list for failed_mirror) to make
 		 * clean_io_failure() clean all those errors at once.
 		 */
-		ASSERT(failrec->this_mirror == failed_mirror);
+		ASSERT(failrec->this_mirror == bbio->mirror_num);
 		ASSERT(failrec->len == fs_info->sectorsize);
 		return failrec;
 	}
@@ -2567,7 +2572,7 @@ static struct io_failure_record *btrfs_get_io_failure_record(struct inode *inode
 
 	failrec->start = start;
 	failrec->len = sectorsize;
-	failrec->failed_mirror = failrec->this_mirror = failed_mirror;
+	failrec->failed_mirror = failrec->this_mirror = bbio->mirror_num;
 	failrec->compress_type = BTRFS_COMPRESS_NONE;
 
 	read_lock(&em_tree->lock);
@@ -2632,17 +2637,17 @@ static struct io_failure_record *btrfs_get_io_failure_record(struct inode *inode
 	return failrec;
 }
 
-int btrfs_repair_one_sector(struct inode *inode,
-			    struct bio *failed_bio, u32 bio_offset,
-			    struct page *page, unsigned int pgoff,
-			    u64 start, int failed_mirror,
+int btrfs_repair_one_sector(struct inode *inode, struct btrfs_bio *failed_bbio,
+			    u32 bio_offset, struct page *page,
+			    unsigned int pgoff,
 			    submit_bio_hook_t *submit_bio_hook)
 {
+	u64 start = failed_bbio->file_offset + bio_offset;
 	struct io_failure_record *failrec;
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
 	struct extent_io_tree *tree = &BTRFS_I(inode)->io_tree;
 	struct extent_io_tree *failure_tree = &BTRFS_I(inode)->io_failure_tree;
-	struct btrfs_bio *failed_bbio = btrfs_bio(failed_bio);
+	struct bio *failed_bio = &failed_bbio->bio;
 	const int icsum = bio_offset >> fs_info->sectorsize_bits;
 	struct bio *repair_bio;
 	struct btrfs_bio *repair_bbio;
@@ -2652,7 +2657,7 @@ int btrfs_repair_one_sector(struct inode *inode,
 
 	BUG_ON(bio_op(failed_bio) == REQ_OP_WRITE);
 
-	failrec = btrfs_get_io_failure_record(inode, start, failed_mirror);
+	failrec = btrfs_get_io_failure_record(inode, failed_bbio, bio_offset);
 	if (IS_ERR(failrec))
 		return PTR_ERR(failrec);
 
@@ -2750,9 +2755,10 @@ static void end_sector_io(struct page *page, u64 offset, bool uptodate)
 				    offset + sectorsize - 1, &cached);
 }
 
-static void submit_data_read_repair(struct inode *inode, struct bio *failed_bio,
+static void submit_data_read_repair(struct inode *inode,
+				    struct btrfs_bio *failed_bbio,
 				    u32 bio_offset, const struct bio_vec *bvec,
-				    int failed_mirror, unsigned int error_bitmap)
+				    unsigned int error_bitmap)
 {
 	const unsigned int pgoff = bvec->bv_offset;
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
@@ -2763,7 +2769,7 @@ static void submit_data_read_repair(struct inode *inode, struct bio *failed_bio,
 	const int nr_bits = (end + 1 - start) >> fs_info->sectorsize_bits;
 	int i;
 
-	BUG_ON(bio_op(failed_bio) == REQ_OP_WRITE);
+	BUG_ON(bio_op(&failed_bbio->bio) == REQ_OP_WRITE);
 
 	/* This repair is only for data */
 	ASSERT(is_data_inode(inode));
@@ -2775,7 +2781,7 @@ static void submit_data_read_repair(struct inode *inode, struct bio *failed_bio,
 	 * We only get called on buffered IO, thus page must be mapped and bio
 	 * must not be cloned.
 	 */
-	ASSERT(page->mapping && !bio_flagged(failed_bio, BIO_CLONED));
+	ASSERT(page->mapping && !bio_flagged(&failed_bbio->bio, BIO_CLONED));
 
 	/* Iterate through all the sectors in the range */
 	for (i = 0; i < nr_bits; i++) {
@@ -2792,10 +2798,9 @@ static void submit_data_read_repair(struct inode *inode, struct bio *failed_bio,
 			goto next;
 		}
 
-		ret = btrfs_repair_one_sector(inode, failed_bio,
-				bio_offset + offset,
-				page, pgoff + offset, start + offset,
-				failed_mirror, btrfs_submit_data_read_bio);
+		ret = btrfs_repair_one_sector(inode, failed_bbio,
+				bio_offset + offset, page, pgoff + offset,
+				btrfs_submit_data_read_bio);
 		if (!ret) {
 			/*
 			 * We have submitted the read repair, the page release
@@ -3127,8 +3132,8 @@ static void end_bio_extent_readpage(struct bio *bio)
 			 * submit_data_read_repair() will handle all the good
 			 * and bad sectors, we just continue to the next bvec.
 			 */
-			submit_data_read_repair(inode, bio, bio_offset, bvec,
-						mirror, error_bitmap);
+			submit_data_read_repair(inode, bbio, bio_offset, bvec,
+						error_bitmap);
 		} else {
 			/* Update page status and unlock */
 			end_page_read(page, uptodate, start, len);
diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
index 280af70c04953..a78051c7627c4 100644
--- a/fs/btrfs/extent_io.h
+++ b/fs/btrfs/extent_io.h
@@ -57,6 +57,7 @@ enum {
 #define BITMAP_LAST_BYTE_MASK(nbits) \
 	(BYTE_MASK >> (-(nbits) & (BITS_PER_BYTE - 1)))
 
+struct btrfs_bio;
 struct btrfs_root;
 struct btrfs_inode;
 struct btrfs_io_bio;
@@ -266,10 +267,9 @@ struct io_failure_record {
 	int num_copies;
 };
 
-int btrfs_repair_one_sector(struct inode *inode,
-			    struct bio *failed_bio, u32 bio_offset,
-			    struct page *page, unsigned int pgoff,
-			    u64 start, int failed_mirror,
+int btrfs_repair_one_sector(struct inode *inode, struct btrfs_bio *failed_bbio,
+			    u32 bio_offset, struct page *page,
+			    unsigned int pgoff,
 			    submit_bio_hook_t *submit_bio_hook);
 
 #ifdef CONFIG_BTRFS_FS_RUN_SANITY_TESTS
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 784c1ad4a9634..a627b2af9e243 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -7953,9 +7953,8 @@ static blk_status_t btrfs_check_read_dio_bio(struct btrfs_dio_private *dip,
 		} else {
 			int ret;
 
-			ret = btrfs_repair_one_sector(inode, &bbio->bio, offset,
-					bv.bv_page, bv.bv_offset, start,
-					bbio->mirror_num,
+			ret = btrfs_repair_one_sector(inode, bbio, offset,
+					bv.bv_page, bv.bv_offset,
 					submit_dio_repair_bio);
 			if (ret)
 				err = errno_to_blk_status(ret);
-- 
2.30.2

