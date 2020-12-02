Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCACD2CB54A
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Dec 2020 07:50:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387536AbgLBGuA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Dec 2020 01:50:00 -0500
Received: from mx2.suse.de ([195.135.220.15]:53504 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387531AbgLBGuA (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 2 Dec 2020 01:50:00 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1606891731; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YuOLdrngHaLfQKXDkj1I+F8EWFLJuhFrXifk6fLlGkA=;
        b=r493HqEItRhwPmBelp2gKkQcEccTSpZ2m1FFEqgqhf2CKas2GjRmGPTS7TBvpo1r4EUxoP
        GtGsTAY6Ra4jE/URMhfhOWhp058g9nvRIw2PuC/zX3Hf6OMTF7MtxgXspbp+sIwT00kpPg
        lyKVZxWF5N2VifbEieZZpfSgZB++NRU=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 1D789AEEE
        for <linux-btrfs@vger.kernel.org>; Wed,  2 Dec 2020 06:48:51 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v3 12/15] btrfs: scrub: always allocate one full page for one sector for RAID56
Date:   Wed,  2 Dec 2020 14:48:08 +0800
Message-Id: <20201202064811.100688-13-wqu@suse.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201202064811.100688-1-wqu@suse.com>
References: <20201202064811.100688-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

For scrub_pages() and scrub_pages_for_parity(), we currently allocate
one scrub_page structure for one page.

This is fine if we only read/write one sector one time.
But for cases like scrubing RAID56, we need to read/write the full
stripe, which is in 64K size.

For subpage size, we will submit the read in just one page, which is
normally a good thing, but for RAID56 case, it only expects to see one
sector, not the full stripe in its endio function.
This could lead to wrong parity checksum for RAID56 on subpage.

To make the existing code work well for subpage case, here we take a
shortcut, by always allocating a full page for one sector.

This should provide the basis to make RAID56 work for subpage case.

The cost is pretty obvious now, for one RAID56 stripe now we always need 16
pages. For support subpage situation (64K page size, 4K sector size),
this means we need full one megabyte to scrub just one RAID56 stripe.

And for data scrub, each 4K sector will also need one 64K page.

This is mostly just a workaround, the proper fix for this is a much
larger project, using scrub_block to replace scrub_page, and allow
scrub_block to handle multi pages, csums, and csum_bitmap to avoid
allocating one page for each sector.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/scrub.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 8026606f7510..efc6f5f2b8a4 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -2153,6 +2153,7 @@ static int scrub_pages(struct scrub_ctx *sctx, u64 logical, u32 len,
 		       u64 physical_for_dev_replace)
 {
 	struct scrub_block *sblock;
+	const u32 sectorsize = sctx->fs_info->sectorsize;
 	int index;
 
 	sblock = kzalloc(sizeof(*sblock), GFP_KERNEL);
@@ -2171,7 +2172,12 @@ static int scrub_pages(struct scrub_ctx *sctx, u64 logical, u32 len,
 
 	for (index = 0; len > 0; index++) {
 		struct scrub_page *spage;
-		u32 l = min_t(u32, len, PAGE_SIZE);
+		/*
+		 * Here we will allocate one page for one sector to scrub.
+		 * This is fine if PAGE_SIZE == sectorsize, but will cost
+		 * more memory for PAGE_SIZE > sectorsize case.
+		 */
+		u32 l = min(sectorsize, len);
 
 		spage = kzalloc(sizeof(*spage), GFP_KERNEL);
 		if (!spage) {
@@ -2483,8 +2489,11 @@ static int scrub_pages_for_parity(struct scrub_parity *sparity,
 {
 	struct scrub_ctx *sctx = sparity->sctx;
 	struct scrub_block *sblock;
+	u32 sectorsize = sctx->fs_info->sectorsize;
 	int index;
 
+	ASSERT(IS_ALIGNED(len, sectorsize));
+
 	sblock = kzalloc(sizeof(*sblock), GFP_KERNEL);
 	if (!sblock) {
 		spin_lock(&sctx->stat_lock);
@@ -2503,7 +2512,6 @@ static int scrub_pages_for_parity(struct scrub_parity *sparity,
 
 	for (index = 0; len > 0; index++) {
 		struct scrub_page *spage;
-		u32 l = min_t(u32, len, PAGE_SIZE);
 
 		spage = kzalloc(sizeof(*spage), GFP_KERNEL);
 		if (!spage) {
@@ -2538,9 +2546,12 @@ static int scrub_pages_for_parity(struct scrub_parity *sparity,
 		spage->page = alloc_page(GFP_KERNEL);
 		if (!spage->page)
 			goto leave_nomem;
-		len -= l;
-		logical += l;
-		physical += l;
+
+
+		/* Iterate over the stripe range in sectorsize steps */
+		len -= sectorsize;
+		logical += sectorsize;
+		physical += sectorsize;
 	}
 
 	WARN_ON(sblock->page_count == 0);
-- 
2.29.2

