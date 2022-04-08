Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F6FE4F8ED7
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Apr 2022 08:27:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234650AbiDHFLW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 8 Apr 2022 01:11:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234630AbiDHFLV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 8 Apr 2022 01:11:21 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C315247C1E
        for <linux-btrfs@vger.kernel.org>; Thu,  7 Apr 2022 22:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=FjgsWFFg4CUMKVxjirvekpD2+DHIEUdqrrrKYZoaiAs=; b=i25JmwX+hNh2SDw8VW61VKOZlY
        FFRl2ytgP30owlUTIA0zPqMBKAn78buGkU41BIozkwhp3yMl7Vt29hOoRnS6NyAWOoFXpQz0zp069
        AP+AvvAf/BoEcYyLEvgsWDrKBc09xQzlntDTIDROFQTIkfOdQj8EEO/E/LLYFyuQdfC460L5Nw5W2
        AAXjrHch/Fa4Aa68DbRLSPEmFrpDn83Gbx2jqTzh4jD1RsC3eNGBPp85BQG/2Gm1w2Lxc1bsE4DDk
        hD8BJQdy0DMzSc3aHzgX3HHP5BbcvJKz1kDfrrS8Qu2kVCjTUHHmxcEakgVxnLQoT3AxYYOqpteB7
        wGV2Hq2Q==;
Received: from 213-225-37-164.nat.highway.a1.net ([213.225.37.164] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ncgrz-00F19v-SM; Fri, 08 Apr 2022 05:09:16 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Qu Wenruo <wqu@suse.com>
Cc:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org
Subject: [PATCH 10/12] btrfs: don't allocate a btrfs_bio for raid56 per-stripe bios
Date:   Fri,  8 Apr 2022 07:08:37 +0200
Message-Id: <20220408050839.239113-11-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220408050839.239113-1-hch@lst.de>
References: <20220408050839.239113-1-hch@lst.de>
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

Except for the spurious initialization of ->device just after allocation
nothing uses the btrfs_bio, so just allocate a normal bio without extra
data.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/raid56.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
index 13a998628b90b..1ab77d658bf15 100644
--- a/fs/btrfs/raid56.c
+++ b/fs/btrfs/raid56.c
@@ -1082,11 +1082,8 @@ static int rbio_add_io_page(struct btrfs_raid_bio *rbio,
 	}
 
 	/* put a new bio on the list */
-	bio = btrfs_bio_alloc(bio_max_len >> PAGE_SHIFT ?: 1);
-	btrfs_bio(bio)->device = stripe->dev;
-	bio->bi_iter.bi_size = 0;
-	bio_set_dev(bio, stripe->dev->bdev);
-	bio->bi_opf = opf;
+	bio = bio_alloc(stripe->dev->bdev, max(bio_max_len >> PAGE_SHIFT, 1UL),
+			opf, GFP_NOFS);
 	bio->bi_iter.bi_sector = disk_start >> 9;
 	bio->bi_private = rbio;
 
-- 
2.30.2

