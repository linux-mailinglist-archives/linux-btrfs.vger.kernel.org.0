Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B4A0535BC2
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 May 2022 10:44:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349788AbiE0Inf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 27 May 2022 04:43:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238691AbiE0Ind (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 27 May 2022 04:43:33 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEF5C2AC64
        for <linux-btrfs@vger.kernel.org>; Fri, 27 May 2022 01:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=q1WJFJG/fxQxNU+bCa3zOYf9I1HWEMKAcH1bhOogkRo=; b=fQoImXxn6883oYrB1VNjCL3wjW
        C9KWKGrGDGiSPUa+6y+qA2I3Rv1fKSENTOuXEj13CUOG/m+ptcSbWpUQLyfTeWNajwS5FbqqiQWJ3
        6Dha5Hv7Eg8T8WLaonJ+iNDEZUlhtQJzee5AX6xzesE/Qeoa4NtKVbr3PNr16nGZWvQkWB8gMDXgo
        4rYtoekQF/1bwZKa2/CZIgYpnIhUY1rp51YBWa/SPEwRue+O6trsllZRnnizhrDk/bTJqjhm+MvNE
        Okc+Ulec3274d/CJk9Wj4Ls+PDYtDzfoZXvB9FUbADeqgu7W4RHhrL7kxBkeofExd6+7ghLymkF68
        rvjjRWow==;
Received: from [2001:4bb8:18c:7298:b5ab:7d49:c6be:2011] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nuVZ9-00H3V0-Cu; Fri, 27 May 2022 08:43:27 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Subject: [PATCH 2/9] btrfs: set ->file_offset in end_bio_extent_readpage
Date:   Fri, 27 May 2022 10:43:13 +0200
Message-Id: <20220527084320.2130831-3-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220527084320.2130831-1-hch@lst.de>
References: <20220527084320.2130831-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
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
Reviewed-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent_io.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 48463705ef0e6..54a0ec62c7b0d 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -3009,25 +3009,30 @@ static struct extent_buffer *find_extent_buffer_readpage(
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
@@ -3037,9 +3042,7 @@ static void end_bio_extent_readpage(struct bio *bio)
 		btrfs_debug(fs_info,
 			"end_bio_extent_readpage: bi_sector=%llu, err=%d, mirror=%u",
 			bio->bi_iter.bi_sector, bio->bi_status,
-			bbio->mirror_num);
-		tree = &BTRFS_I(inode)->io_tree;
-		failure_tree = &BTRFS_I(inode)->io_failure_tree;
+			mirror);
 
 		/*
 		 * We always issue full-sector reads, but if some block in a
@@ -3062,7 +3065,6 @@ static void end_bio_extent_readpage(struct bio *bio)
 		end = start + bvec->bv_len - 1;
 		len = bvec->bv_len;
 
-		mirror = bbio->mirror_num;
 		if (likely(uptodate)) {
 			if (is_data_inode(inode)) {
 				error_bitmap = btrfs_verify_data_csum(bbio,
-- 
2.30.2

