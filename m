Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D898952A54F
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 May 2022 16:53:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349410AbiEQOvh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 17 May 2022 10:51:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349348AbiEQOvM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 17 May 2022 10:51:12 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FABF13F04
        for <linux-btrfs@vger.kernel.org>; Tue, 17 May 2022 07:51:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=vGWn1dZwE2gO5LfqnrnbPJHY0ObiJUgvwiDN/pjUIKI=; b=bcoyBSakBbhfWI4KjnK/Z7EFr0
        yN/U/uz5qmM9Ad6Yr/ren3Wzg12cRVcmVQBge7430fPABmZUOyck/4WaE3Tjk//ix0CzVTOsbn7es
        NaWIeFMTlxPrarPgQ7plWZQNmq3A2aMNcgGrDbiwGmCoa3Mc71VGfsZCEs8ZPpJsa2/gpobvh56zf
        RIexY5bzAptQ2NTNM9VWay/epOjL0e8iMXj5kts96KiDnNG/3uzx9DOIENjQW2TjZDqJw9cF8Afmb
        ZiR1y1VixKAUdk14SgOQUcsFchByzbO5ZSptA8MO9fSHhISMZJv3pRkeUC/4Eh3RA3vd4Tfyx4OZy
        0aV93h6g==;
Received: from [89.144.222.138] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nqyXS-00EXDH-IG; Tue, 17 May 2022 14:51:06 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Subject: [PATCH 07/15] btrfs: factor out a helper to end a single sector from submit_data_read_repair
Date:   Tue, 17 May 2022 16:50:31 +0200
Message-Id: <20220517145039.3202184-8-hch@lst.de>
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

Add a helper to end I/O on a single sector, which will come in handy with
the new read repair code.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/extent_io.c | 26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 75466747a252c..f96d5b7071813 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2740,6 +2740,20 @@ static void end_page_read(struct page *page, bool uptodate, u64 start, u32 len)
 		btrfs_subpage_end_reader(fs_info, page, start, len);
 }
 
+static void end_sector_io(struct page *page, u64 offset, bool uptodate)
+{
+	struct inode *inode = page->mapping->host;
+	u32 sectorsize = btrfs_sb(inode->i_sb)->sectorsize;
+	struct extent_state *cached = NULL;
+
+	end_page_read(page, uptodate, offset, sectorsize);
+	if (uptodate)
+		set_extent_uptodate(&BTRFS_I(inode)->io_tree, offset,
+				offset + sectorsize - 1, &cached, GFP_ATOMIC);
+	unlock_extent_cached_atomic(&BTRFS_I(inode)->io_tree, offset,
+			offset + sectorsize - 1, &cached);
+}
+
 static void submit_data_read_repair(struct inode *inode, struct bio *failed_bio,
 		u32 bio_offset, const struct bio_vec *bvec, int failed_mirror,
 		unsigned int error_bitmap)
@@ -2770,7 +2784,6 @@ static void submit_data_read_repair(struct inode *inode, struct bio *failed_bio,
 	/* Iterate through all the sectors in the range */
 	for (i = 0; i < nr_bits; i++) {
 		const unsigned int offset = i * sectorsize;
-		struct extent_state *cached = NULL;
 		bool uptodate = false;
 		int ret;
 
@@ -2801,16 +2814,7 @@ static void submit_data_read_repair(struct inode *inode, struct bio *failed_bio,
 		 * will not be properly unlocked.
 		 */
 next:
-		end_page_read(page, uptodate, start + offset, sectorsize);
-		if (uptodate)
-			set_extent_uptodate(&BTRFS_I(inode)->io_tree,
-					start + offset,
-					start + offset + sectorsize - 1,
-					&cached, GFP_ATOMIC);
-		unlock_extent_cached_atomic(&BTRFS_I(inode)->io_tree,
-				start + offset,
-				start + offset + sectorsize - 1,
-				&cached);
+		end_sector_io(page, start + offset, uptodate);
 	}
 }
 
-- 
2.30.2

