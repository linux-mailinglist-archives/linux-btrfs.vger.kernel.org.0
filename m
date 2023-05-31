Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A49C671792B
	for <lists+linux-btrfs@lfdr.de>; Wed, 31 May 2023 09:56:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234991AbjEaH4b (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 31 May 2023 03:56:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234931AbjEaH4O (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 31 May 2023 03:56:14 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC5A7E7B
        for <linux-btrfs@vger.kernel.org>; Wed, 31 May 2023 00:54:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=ibLQ++Bg9sFrc2540LrYTS2aDgwOXQh3mq6s1LpKv9Y=; b=jUXjhHN1jsU7uSWqzNMJASHzvF
        ZYDhNNxRWORXrOGQrgXhia1JdTLYmbR4ARmRFpe1X8JBi+7AShLfL2AkAotsjniprRvv7GRIvuWCH
        Pz8IvJ6P10K95mecsSsMDeXSthyeQdiRH7Fr12f3oLvJdIZBCa/as5Xzqix96E3R5aMcKpxO0Cor3
        /IcKulAiSq2/psNSwABrwW4MtVC4GkFJVcsWydkeXObq/kjVUmVOYP5h44xG+ZAjd3RwrsG0+SrFu
        zcrNegxXg0GL7/8RgxEeGRRHF0Tuqc3Pqn+mINfaMWH/TjKix6lJUUyf4O3M54vSdgTL7E8BuRdp1
        oUZfX9yg==;
Received: from [2001:4bb8:182:6d06:f5c3:53d7:b5aa:b6a7] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q4GfV-00GWxG-1T;
        Wed, 31 May 2023 07:54:53 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 14/17] btrfs: open code end_extent_writepage in end_bio_extent_writepage
Date:   Wed, 31 May 2023 09:54:07 +0200
Message-Id: <20230531075410.480499-15-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230531075410.480499-1-hch@lst.de>
References: <20230531075410.480499-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This prepares for switching to more efficient ordered_extent processing
and already removes the forth and back conversion from len to end back to
len.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/extent_io.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 645723d16d5979..08c46de4d712da 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -505,8 +505,6 @@ static void end_bio_extent_writepage(struct btrfs_bio *bbio)
 	struct bio *bio = &bbio->bio;
 	int error = blk_status_to_errno(bio->bi_status);
 	struct bio_vec *bvec;
-	u64 start;
-	u64 end;
 	struct bvec_iter_all iter_all;
 
 	ASSERT(!bio_flagged(bio, BIO_CLONED));
@@ -515,6 +513,8 @@ static void end_bio_extent_writepage(struct btrfs_bio *bbio)
 		struct inode *inode = page->mapping->host;
 		struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
 		const u32 sectorsize = fs_info->sectorsize;
+		u64 start = page_offset(page) + bvec->bv_offset;
+		u32 len = bvec->bv_len;
 
 		/* Our read/write should always be sector aligned. */
 		if (!IS_ALIGNED(bvec->bv_offset, sectorsize))
@@ -526,12 +526,13 @@ static void end_bio_extent_writepage(struct btrfs_bio *bbio)
 		"incomplete page write with offset %u and length %u",
 				   bvec->bv_offset, bvec->bv_len);
 
-		start = page_offset(page) + bvec->bv_offset;
-		end = start + bvec->bv_len - 1;
-
-		end_extent_writepage(page, error, start, end);
-
-		btrfs_page_clear_writeback(fs_info, page, start, bvec->bv_len);
+		btrfs_writepage_endio_finish_ordered(BTRFS_I(inode), page, start,
+						     start + len - 1, !error);
+		if (error) {
+			btrfs_page_clear_uptodate(fs_info, page, start, len);
+			mapping_set_error(page->mapping, error);
+		}
+		btrfs_page_clear_writeback(fs_info, page, start, len);
 	}
 
 	bio_put(bio);
-- 
2.39.2

