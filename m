Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D5226B1F5B
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Mar 2023 10:07:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229798AbjCIJHV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 9 Mar 2023 04:07:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230380AbjCIJGy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 9 Mar 2023 04:06:54 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F5762B9D1
        for <linux-btrfs@vger.kernel.org>; Thu,  9 Mar 2023 01:06:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=fH0X1do/AeMyzE9bhkXzrssNJVE+F5tB5ZO3wj3FNcY=; b=CATBmb9eq8YUiv6aaeyESSwGgx
        NJcxcNtT5oexrOR7gZsv5U01zmz27w1TbZQklOGMboHi0dRLOOBqO5TerwmAGWUaVvRA27QQf1O+S
        BcmOPizKPYQv0mC0imYMRg547ntAuxtRBYsG2k1cahyh9arY2oc781zsq7RTfbzfH6IWCrAeGYxF1
        EYXDUSkz/RAiHCWWC8v5/iBebW/fn6Utn+bazPlSdmICsuGGaD46avtI24ehKvKQBI+pTzBtUqlRU
        N9z3qcqAMmSejJ53Whk2gPwQwHNeKCILodNmC/G/UcJ/2SfaSNT8tCFs/6dsqgrfUgjOFT3+3geoK
        8RbUqXLg==;
Received: from [2001:4bb8:190:782d:bc9d:fa49:9fec:5662] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1paCE7-008hjj-TK; Thu, 09 Mar 2023 09:06:20 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: [PATCH 08/20] btrfs: do not try to unlock the extent for non-subpage metadata reads
Date:   Thu,  9 Mar 2023 10:05:14 +0100
Message-Id: <20230309090526.332550-9-hch@lst.de>
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

Only subpage metadata reads lock the extent.  Don't try to unlock it and
waste cycles in the extent tree lookup for PAGE_SIZE or larger metadata.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/extent_io.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 738fcf5cbc71d6..c9121aed06000b 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -4206,8 +4206,10 @@ static void extent_buffer_read_end_io(struct btrfs_bio *bbio)
 		bio_offset += bvec->bv_len;
 	}
 
-	unlock_extent(&bbio->inode->io_tree, eb->start,
-		      eb->start + bio_offset - 1, NULL);
+	if (eb->fs_info->nodesize < PAGE_SIZE) {
+		unlock_extent(&bbio->inode->io_tree, eb->start,
+			      eb->start + bio_offset - 1, NULL);
+	}
 	free_extent_buffer(eb);
 
 	bio_put(&bbio->bio);
-- 
2.39.2

