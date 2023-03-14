Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DFB66B8B14
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Mar 2023 07:17:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229920AbjCNGRd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 14 Mar 2023 02:17:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229700AbjCNGRc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 14 Mar 2023 02:17:32 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28C2976F6D
        for <linux-btrfs@vger.kernel.org>; Mon, 13 Mar 2023 23:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=nkliL7/PV5NxqAfKFrVQuDY7ULiX7opspFI+9FZbZuE=; b=ZiJSZtSNBEhDHX2k/vSle8DV8K
        ApUd/DSKZO+hNs9V+GiA79UGz30aa0P0myPcmNUxm2yQBFVMR2rQ4aI3Rsi7c8jQ+awyfAHct3Y52
        yHRF3xwKEVK3sxEh+FzMIfKqbkpB9IxK9eTSpUSHqTUYoXEAL81bMf6s2Y9jlCqiQwKQCyMC99d4h
        gpsJLuyuMTW00BNiD6+o7QSLwi7Fp2NLzYxGRRmhmpU5rLdoWmtmhMYMIMiyJViUGpL8NBvqebWMl
        7+OLpdavpwrVKT+ZRML4q4lxiJnSto1URVcEtDa3X11df6k/LqJYj6to4s+0T9xwDYlYvI5eFXhEx
        ++fobCPw==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pbxyU-009AlF-34; Tue, 14 Mar 2023 06:17:30 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 09/21] btrfs: do not try to unlock the extent for non-subpage metadata reads
Date:   Tue, 14 Mar 2023 07:16:43 +0100
Message-Id: <20230314061655.245340-10-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230314061655.245340-1-hch@lst.de>
References: <20230314061655.245340-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Only subpage metadata reads lock the extent.  Don't try to unlock it and
waste cycles in the extent tree lookup for PAGE_SIZE or larger metadata.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/extent_io.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 5570f1050296c9..bc50163dd3b792 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -4207,8 +4207,10 @@ static void extent_buffer_read_end_io(struct btrfs_bio *bbio)
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

