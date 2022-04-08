Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9605C4F8D7E
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Apr 2022 08:25:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234659AbiDHFLb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 8 Apr 2022 01:11:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234630AbiDHFL3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 8 Apr 2022 01:11:29 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 642112571FF
        for <linux-btrfs@vger.kernel.org>; Thu,  7 Apr 2022 22:09:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=H9/ZpGN2QhB9z7/+4EiqTB6ElzT3ZSVwkBeN/Efpo9Q=; b=tMX00U0eskyb4QSjWnnI1Sp2el
        5j6NHKy09XG8skpZZ/CKqqogDN5+umLUZYwH0q9avkCYT72yPWCiv/AVBQ7kDgPZJhakuVPtSZuDr
        z+QCrlGJdytGPlwbNt3jAeUJrvkWImc819jaU3l7+TWu/1sRtWzX4jqZ5+k7pKm0yxq8k1fc5O1G8
        AdhQYDcizE1YiltqGdepus/aAyZCO3nfI1EGeMay0vC+FxmDJ9uDDYQXYkzFkddzoAYLWQ5oYJBoJ
        eS3nRkDX9Dg3iXLh9pnZf+8plU5QTqSlzupUJsdCPuryANFNuP5ImFMoDShqZ1M3YmO5akMF67/8n
        rA0x0mPQ==;
Received: from 213-225-37-164.nat.highway.a1.net ([213.225.37.164] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ncgs6-00F1Cc-0i; Fri, 08 Apr 2022 05:09:22 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Qu Wenruo <wqu@suse.com>
Cc:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org
Subject: [PATCH 12/12] btrfs: stop using the btrfs_bio saved iter in index_rbio_pages
Date:   Fri,  8 Apr 2022 07:08:39 +0200
Message-Id: <20220408050839.239113-13-hch@lst.de>
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

The bios added to ->bio_list are the original bios fed into
btrfs_map_bio, which are never advanced.  Just use the iter in the
bio itself.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/raid56.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
index 1ab77d658bf15..adc62a7352b82 100644
--- a/fs/btrfs/raid56.c
+++ b/fs/btrfs/raid56.c
@@ -1134,9 +1134,6 @@ static void index_rbio_pages(struct btrfs_raid_bio *rbio)
 		stripe_offset = start - rbio->bioc->raid_map[0];
 		page_index = stripe_offset >> PAGE_SHIFT;
 
-		if (bio_flagged(bio, BIO_CLONED))
-			bio->bi_iter = btrfs_bio(bio)->iter;
-
 		bio_for_each_segment(bvec, bio, iter) {
 			rbio->bio_pages[page_index + i] = bvec.bv_page;
 			i++;
-- 
2.30.2

