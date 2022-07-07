Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25AAA5699DC
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 Jul 2022 07:34:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234986AbiGGFdz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 7 Jul 2022 01:33:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbiGGFdy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 7 Jul 2022 01:33:54 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D91592E9FF
        for <linux-btrfs@vger.kernel.org>; Wed,  6 Jul 2022 22:33:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=zhP/tccypvTkrGuTKwpLkl45TjcKt09LHehLljuq30U=; b=zT+hL459jIUsegbN2f+XmwbRPN
        TSpeZDPnFn9iL6OMYnYryuXGiJ+fhtfHelraSwiOwvnJd4wjwzxGTcFruer8wgME0h6oqZ8vwr9Bn
        IHSL83VHGnnLbikcifSgcibrhPscwXz7oSEZn30bn3k5EpnuwAYkaCRLp4lfgdM+xbkB3eG0GVfy6
        BvOmXf1ZBTBqcT39W/Mc7UzLwsTLIfBGojCLu3IEZ7MyfI5ycxT+S71ek4CDC0JGbrnvU9+UOuy7j
        C/jobiYEG2h+Dez/HsBTivD38vnzD0pAgCyTgNXS0Dpl6PB4BfKRvdIZwkqikJccuKJ33/NqWKB2b
        5RRg+ELQ==;
Received: from [2001:4bb8:189:3c4a:8caf:7f2b:dda6:253] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o9K99-00Dlh0-4W; Thu, 07 Jul 2022 05:33:51 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: [PATCH 6/6] btrfs: don't call btrfs_page_set_checked in finish_compressed_bio_read
Date:   Thu,  7 Jul 2022 07:33:31 +0200
Message-Id: <20220707053331.211259-7-hch@lst.de>
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

This flag was used to communicate that the low-level compression code
already did verify the checksum to the high-level I/O completion code.

But it has been unused for a long time as the upper btrfs_bio for the
decompressed data had a NULL csum pointer basically since that pointer
existed and the code already checks for that a little later.

Note that this does not affect the other use of the checked flag, which
is only used for the COW fixup worker.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/compression.c | 24 ++----------------------
 fs/btrfs/inode.c       |  5 -----
 2 files changed, 2 insertions(+), 27 deletions(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index c8b14a5bd89be..b6fb8b0682bae 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -152,29 +152,9 @@ static void finish_compressed_bio_read(struct compressed_bio *cb)
 	}
 
 	/* Do io completion on the original bio */
-	if (cb->status != BLK_STS_OK) {
+	if (cb->status != BLK_STS_OK)
 		cb->orig_bio->bi_status = cb->status;
-		bio_endio(cb->orig_bio);
-	} else {
-		struct bio_vec *bvec;
-		struct bvec_iter_all iter_all;
-
-		/*
-		 * We have verified the checksum already, set page checked so
-		 * the end_io handlers know about it
-		 */
-		ASSERT(!bio_flagged(cb->orig_bio, BIO_CLONED));
-		bio_for_each_segment_all(bvec, cb->orig_bio, iter_all) {
-			u64 bvec_start = page_offset(bvec->bv_page) +
-					 bvec->bv_offset;
-
-			btrfs_page_set_checked(btrfs_sb(cb->inode->i_sb),
-					bvec->bv_page, bvec_start,
-					bvec->bv_len);
-		}
-
-		bio_endio(cb->orig_bio);
-	}
+	bio_endio(cb->orig_bio);
 
 	/* Finally free the cb struct */
 	kfree(cb->compressed_pages);
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index eea351216db33..f218933d1367b 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -3460,11 +3460,6 @@ unsigned int btrfs_verify_data_csum(struct btrfs_bio *bbio,
 	u32 pg_off;
 	unsigned int result = 0;
 
-	if (btrfs_page_test_checked(fs_info, page, start, end + 1 - start)) {
-		btrfs_page_clear_checked(fs_info, page, start, end + 1 - start);
-		return 0;
-	}
-
 	/*
 	 * This only happens for NODATASUM or compressed read.
 	 * Normally this should be covered by above check for compressed read
-- 
2.30.2

