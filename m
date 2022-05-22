Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 784915302C5
	for <lists+linux-btrfs@lfdr.de>; Sun, 22 May 2022 13:48:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245672AbiEVLsN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 22 May 2022 07:48:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237141AbiEVLsK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 22 May 2022 07:48:10 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2BB71659D
        for <linux-btrfs@vger.kernel.org>; Sun, 22 May 2022 04:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=3HkxywVfQ3AMsTMMjilPPtGwVSc3Tp2mwj9m7F2GFyk=; b=nIvzAoLIIel1K/2R0ohh2Wry9D
        c+BO6Btah58h0tZLAJDzOh9lpwb1AOFpk+bmUeKzaEhr9NdP4QCtldT9e/p/twZBieFws6A5JO6x4
        tSYc5Sk7pe0OYG5kAf7JfiobvHP6iAZbmjC8Z8+zv1BV01oPbvq2xfLylJWJYpE4Qju7FUdJfw1Jw
        v+mk3qeKJ37KCCachxqDhgz/LVq0GX11JiInXkJJAxT72vyLNEHTJ8FfPxl18vTFHC75PWFI3x2he
        ZS13WvqW3xoz0IgsNO9ZZW1eIidp1mKTNrDKDwGNdouZmXf092mzO36c79kJsLUok+B3she44L1V6
        aKWyTPpQ==;
Received: from [2001:4bb8:19a:6dab:76a3:f7ab:4f04:784a] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nsk44-001E2b-S0; Sun, 22 May 2022 11:48:05 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
        Nikolay Borisov <nborisov@suse.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 3/8] btrfs: remove duplicated parameters from submit_data_read_repair()
Date:   Sun, 22 May 2022 13:47:49 +0200
Message-Id: <20220522114754.173685-4-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220522114754.173685-1-hch@lst.de>
References: <20220522114754.173685-1-hch@lst.de>
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

From: Qu Wenruo <wqu@suse.com>

The function submit_data_read_repair() is only called for buffered data
read path, thus those members can be calculated using bvec directly:

- start
  start = page_offset(bvec->bv_page) + bvec->bv_offset;

- end
  end = start + bvec->bv_len - 1;

- page
  page = bvec->bv_page;

- pgoff
  pgoff = bvec->bv_offset;

Thus we can safely replace those 4 parameters with just one bio_vec.

Also remove the unused return value.

Signed-off-by: Qu Wenruo <wqu@suse.com>
[hch: also remove the return value]
Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Nikolay Borisov <nborisov@suse.com>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/extent_io.c | 28 +++++++++++-----------------
 1 file changed, 11 insertions(+), 17 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 588c7c606a2c6..dbec9be6daf9f 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2727,18 +2727,17 @@ static void end_page_read(struct page *page, bool uptodate, u64 start, u32 len)
 		btrfs_subpage_end_reader(fs_info, page, start, len);
 }
 
-static blk_status_t submit_data_read_repair(struct inode *inode,
-					    struct bio *failed_bio,
-					    u32 bio_offset, struct page *page,
-					    unsigned int pgoff,
-					    u64 start, u64 end,
-					    int failed_mirror,
-					    unsigned int error_bitmap)
+static void submit_data_read_repair(struct inode *inode, struct bio *failed_bio,
+		u32 bio_offset, const struct bio_vec *bvec, int failed_mirror,
+		unsigned int error_bitmap)
 {
+	const unsigned int pgoff = bvec->bv_offset;
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
+	struct page *page = bvec->bv_page;
+	const u64 start = page_offset(bvec->bv_page) + bvec->bv_offset;
+	const u64 end = start + bvec->bv_len - 1;
 	const u32 sectorsize = fs_info->sectorsize;
 	const int nr_bits = (end + 1 - start) >> fs_info->sectorsize_bits;
-	int error = 0;
 	int i;
 
 	BUG_ON(bio_op(failed_bio) == REQ_OP_WRITE);
@@ -2785,11 +2784,9 @@ static blk_status_t submit_data_read_repair(struct inode *inode,
 			continue;
 		}
 		/*
-		 * Repair failed, just record the error but still continue.
-		 * Or the remaining sectors will not be properly unlocked.
+		 * Continue on failed repair, otherwise the remaining sectors
+		 * will not be properly unlocked.
 		 */
-		if (!error)
-			error = ret;
 next:
 		end_page_read(page, uptodate, start + offset, sectorsize);
 		if (uptodate)
@@ -2802,7 +2799,6 @@ static blk_status_t submit_data_read_repair(struct inode *inode,
 				start + offset + sectorsize - 1,
 				&cached);
 	}
-	return errno_to_blk_status(error);
 }
 
 /* lots and lots of room for performance fixes in the end_bio funcs */
@@ -3093,10 +3089,8 @@ static void end_bio_extent_readpage(struct bio *bio)
 			 * submit_data_read_repair() will handle all the good
 			 * and bad sectors, we just continue to the next bvec.
 			 */
-			submit_data_read_repair(inode, bio, bio_offset, page,
-						start - page_offset(page),
-						start, end, mirror,
-						error_bitmap);
+			submit_data_read_repair(inode, bio, bio_offset, bvec,
+						mirror, error_bitmap);
 
 			ASSERT(bio_offset + len > bio_offset);
 			bio_offset += len;
-- 
2.30.2

