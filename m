Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DCB352A546
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 May 2022 16:53:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349373AbiEQOvp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 17 May 2022 10:51:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349294AbiEQOvY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 17 May 2022 10:51:24 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13AE616582
        for <linux-btrfs@vger.kernel.org>; Tue, 17 May 2022 07:51:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=aitXVb0uhzjJZZSN139uRZBWQSR3EMcA5zQjmyjFTIE=; b=LUTYIQk4Ru1NGSQLM42MVVxP5z
        uiFtC7BC9g2o7rBtVimWG625RdFQTavtM/2N+6CFFuc1vza7h6c9XIk/FhcE6mFOuIEkN09Xx3AVE
        BLXHlYkH18FibFhfAxMRMCRjixWPZUWBcnTTlhvr1+b5/gqmuJWAKdfWGOFST/XafpMIbH/nFq1an
        6KKDews7PSZx8P7gqQawmP4S9cxljxA/CFf0arkA3Eiqfk7dz8DQTQ6UD5Yugu/NW0ajdvntmlgN9
        kO/9x9eSzWCp8Dcnb30Yf6dI1GSAAHnaAId3hfuae19iGyIx3PJyGUmBMfv3Cq8xctG/iQShBQDP6
        oim/MasA==;
Received: from [89.144.222.138] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nqyXf-00EXGN-GO; Tue, 17 May 2022 14:51:19 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Subject: [PATCH 11/15] btrfs: set ->file_offset in end_bio_extent_readpage
Date:   Tue, 17 May 2022 16:50:35 +0200
Message-Id: <20220517145039.3202184-12-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220517145039.3202184-1-hch@lst.de>
References: <20220517145039.3202184-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The new repair code expects ->file_offset to be set for all bios.  Set
it just after entering end_bio_extent_readpage.  As that requires looking
at the first vector before the first loop iteration also use that
opportunity to set various file-wide variables just once instead of once
per loop iteration.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/extent_io.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 1ba2d4b194f2e..cbe3ab24af9e5 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -3018,25 +3018,30 @@ static struct extent_buffer *find_extent_buffer_readpage(
  */
 static void end_bio_extent_readpage(struct bio *bio)
 {
+	struct bio_vec *first_vec = bio_first_bvec_all(bio);
+	struct inode *inode = first_vec->bv_page->mapping->host;
+	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
+	const u32 sectorsize = fs_info->sectorsize;
 	struct bio_vec *bvec;
 	struct btrfs_bio *bbio = btrfs_bio(bio);
-	struct extent_io_tree *tree, *failure_tree;
+	int mirror = bbio->mirror_num;
+	struct extent_io_tree *tree = &BTRFS_I(inode)->io_tree;
+	struct extent_io_tree *failure_tree = &BTRFS_I(inode)->io_failure_tree;
+	bool uptodate = !bio->bi_status;
 	struct processed_extent processed = { 0 };
 	/*
 	 * The offset to the beginning of a bio, since one bio can never be
 	 * larger than UINT_MAX, u32 here is enough.
 	 */
 	u32 bio_offset = 0;
-	int mirror;
 	struct bvec_iter_all iter_all;
 
+	btrfs_bio(bio)->file_offset =
+		page_offset(first_vec->bv_page) + first_vec->bv_offset;
+
 	ASSERT(!bio_flagged(bio, BIO_CLONED));
 	bio_for_each_segment_all(bvec, bio, iter_all) {
-		bool uptodate = !bio->bi_status;
 		struct page *page = bvec->bv_page;
-		struct inode *inode = page->mapping->host;
-		struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
-		const u32 sectorsize = fs_info->sectorsize;
 		unsigned int error_bitmap = (unsigned int)-1;
 		bool repair = false;
 		u64 start;
@@ -3046,9 +3051,7 @@ static void end_bio_extent_readpage(struct bio *bio)
 		btrfs_debug(fs_info,
 			"end_bio_extent_readpage: bi_sector=%llu, err=%d, mirror=%u",
 			bio->bi_iter.bi_sector, bio->bi_status,
-			bbio->mirror_num);
-		tree = &BTRFS_I(inode)->io_tree;
-		failure_tree = &BTRFS_I(inode)->io_failure_tree;
+			mirror);
 
 		/*
 		 * We always issue full-sector reads, but if some block in a
@@ -3071,7 +3074,6 @@ static void end_bio_extent_readpage(struct bio *bio)
 		end = start + bvec->bv_len - 1;
 		len = bvec->bv_len;
 
-		mirror = bbio->mirror_num;
 		if (likely(uptodate)) {
 			if (is_data_inode(inode)) {
 				error_bitmap = btrfs_verify_data_csum(bbio,
-- 
2.30.2

