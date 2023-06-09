Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7347D728F49
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Jun 2023 07:27:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229923AbjFIF1N (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 9 Jun 2023 01:27:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjFIF1M (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 9 Jun 2023 01:27:12 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14F16E46
        for <linux-btrfs@vger.kernel.org>; Thu,  8 Jun 2023 22:27:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=DhmJyvNqog2Mj5CLdTLgy/eLSm3xiLGKoxPqx7v9DTg=; b=Qp0zVL+Xs5wFSjcU1siuwL5498
        Pvte+jembCJ48x+v3yTE7aqO5d46xm4ScgPCyCyJgNVB+nHbA9nOeBIubInPvzjxiis308MLQc4Dd
        j1xqUOsKLCGQIzHPcEPDeAq2ij4nagDUNHbn3nkPe0yGmQPUTpoJoOXlSkWdUSfSYvlbm2D6M181j
        W0YK4MbGwQOf6bPBh0CfuBatl+Gb+aoUhCJDhrWjbeeVXPoczN9ilBdUQwf8YZBkgZ9t2ibJt0X8z
        nUPX0NMOe+gKSr85K4PuHMfB0GzRx2RIDGbyWdMIt/odevsW1dAwKf6L6X8tgNtTZ2kx0VhMbibus
        V0dR1RoQ==;
Received: from [213.208.157.39] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q7UeS-00Bim5-0p;
        Fri, 09 Jun 2023 05:27:08 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com
Cc:     johannes.thumshirn@wdc.com, linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: record orig_physical only for the original bio
Date:   Fri,  9 Jun 2023 07:27:04 +0200
Message-Id: <20230609052704.329148-1-hch@lst.de>
X-Mailer: git-send-email 2.39.2
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

btrfs_submit_dev_bio is also called for clone bios that aren't embeeded
into a btrfs_bio structure, but commit 177b0eb2c180 ("btrfs: optimize the
logical to physical mapping for zoned writes") added code to assign
btrfs_bio.orig_physical in it.  This is harmless right now as only the
single data profile can be used on zoned devices, but will blow up when
the RAID stripe tree is added.  Move it out into the single I/O specific
branch in the caller.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/bio.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
index 8c30febc46ef8f..12b12443efaabb 100644
--- a/fs/btrfs/bio.c
+++ b/fs/btrfs/bio.c
@@ -455,7 +455,6 @@ static void btrfs_submit_dev_bio(struct btrfs_device *dev, struct bio *bio)
 		u64 zone_start = round_down(physical, dev->fs_info->zone_size);
 
 		ASSERT(btrfs_dev_is_sequential(dev, physical));
-		btrfs_bio(bio)->orig_physical = physical;
 		bio->bi_iter.bi_sector = zone_start >> SECTOR_SHIFT;
 	}
 	btrfs_debug_in_rcu(dev->fs_info,
@@ -501,6 +500,8 @@ static void __btrfs_submit_bio(struct bio *bio, struct btrfs_io_context *bioc,
 		/* Single mirror read/write fast path. */
 		btrfs_bio(bio)->mirror_num = mirror_num;
 		bio->bi_iter.bi_sector = smap->physical >> SECTOR_SHIFT;
+		if (bio_op(bio) != REQ_OP_READ)
+			btrfs_bio(bio)->orig_physical = smap->physical;
 		bio->bi_private = smap->dev;
 		bio->bi_end_io = btrfs_simple_end_io;
 		btrfs_submit_dev_bio(smap->dev, bio);
-- 
2.39.2

