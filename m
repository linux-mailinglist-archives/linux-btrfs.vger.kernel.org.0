Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D225F6FB4CE
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 May 2023 18:09:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233625AbjEHQJR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 8 May 2023 12:09:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233585AbjEHQJA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 8 May 2023 12:09:00 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAFC27287
        for <linux-btrfs@vger.kernel.org>; Mon,  8 May 2023 09:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=In6A8/bIfi/XcX1LUpSa5nRBoDlTnuaFGF7Tg/IbMTY=; b=VTw7Ddfbqt1LBl48RnZzGPYNJ4
        q6ZO7qQt2/hsRLnmgwXFWkzZ0MiOfbHQUWH0/W76YAFPuXuokJQrgSdbP9yPxv7id945izLjiI7IB
        JUZ7yvn9CkL3Cuf+5qBJvEyYQgNnpKuvy5FZBUB/AVEFWOPJNu0UuryQ+HqCeyZRpH4W16Is5+5/V
        3/EwKvNSD18GRLBprc0rUvTsb4swrqb76ns1WdjoSGKbUIsm8CpopcJvFxweXmvF8S0h0r7PU+GS4
        nNCLQiBQutRK140JQ90j7ZqR7lMaKgQeOEwzGAxyir9Z+aPB9RkR7uZCY8nJz3vfoYjp349TZ+TqI
        PuGBpntA==;
Received: from [208.98.210.70] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pw3Q0-000w4d-2q;
        Mon, 08 May 2023 16:08:56 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: [PATCH 20/21] btrfs: open code end_extent_writepage in end_bio_extent_writepage
Date:   Mon,  8 May 2023 09:08:42 -0700
Message-Id: <20230508160843.133013-21-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230508160843.133013-1-hch@lst.de>
References: <20230508160843.133013-1-hch@lst.de>
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

This prepares for switching to more efficient ordered_extent processing
and already removes the forth and back conversion from len to end back to
len.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/extent_io.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 7417ce759f6f48..f02564ad194050 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -574,8 +574,6 @@ static void end_bio_extent_writepage(struct btrfs_bio *bbio)
 	struct bio *bio = &bbio->bio;
 	int error = blk_status_to_errno(bio->bi_status);
 	struct bio_vec *bvec;
-	u64 start;
-	u64 end;
 	struct bvec_iter_all iter_all;
 
 	ASSERT(!bio_flagged(bio, BIO_CLONED));
@@ -584,6 +582,8 @@ static void end_bio_extent_writepage(struct btrfs_bio *bbio)
 		struct inode *inode = page->mapping->host;
 		struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
 		const u32 sectorsize = fs_info->sectorsize;
+		u64 start = page_offset(page) + bvec->bv_offset;
+		u32 len = bvec->bv_len;
 
 		/* Our read/write should always be sector aligned. */
 		if (!IS_ALIGNED(bvec->bv_offset, sectorsize))
@@ -595,12 +595,14 @@ static void end_bio_extent_writepage(struct btrfs_bio *bbio)
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
+			btrfs_page_set_error(fs_info, page, start, len);
+			mapping_set_error(page->mapping, error);
+		}
+		btrfs_page_clear_writeback(fs_info, page, start, len);
 	}
 
 	bio_put(bio);
-- 
2.39.2

