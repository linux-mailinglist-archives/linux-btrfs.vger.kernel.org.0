Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 928412A469E
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Nov 2020 14:33:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729412AbgKCNco (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 3 Nov 2020 08:32:44 -0500
Received: from mx2.suse.de ([195.135.220.15]:45900 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729241AbgKCNcn (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 3 Nov 2020 08:32:43 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1604410362;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ctwAg40GrTIK+edjMSvgx6K0DPX8iUEnoZMyInNlE2c=;
        b=U9TorHGU9lSaMUyRdb32Q9l98sj71vvkvMY1hK4Kkrv4JySbsxjRmrNgtSbyhvVEXjP7DZ
        zCMOiz/ZSBxOi+4JbYsa25Cj7WemSwyxxTmxQyTK7LVEhlatUvotP8QhfVWIRPxit9jSAs
        jxrhWuHPq/GuCr8FX6V3yAan+46u36o=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 461C8ACC0
        for <linux-btrfs@vger.kernel.org>; Tue,  3 Nov 2020 13:32:42 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 30/32] btrfs: scrub: always allocate one full page for one sector for RAID56
Date:   Tue,  3 Nov 2020 21:31:06 +0800
Message-Id: <20201103133108.148112-31-wqu@suse.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201103133108.148112-1-wqu@suse.com>
References: <20201103133108.148112-1-wqu@suse.com>
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
 fs/btrfs/scrub.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 9f380009890f..230ba24a4fdf 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -2184,6 +2184,7 @@ static int scrub_pages(struct scrub_ctx *sctx, u64 logical, u64 len,
 		       u64 physical_for_dev_replace)
 {
 	struct scrub_block *sblock;
+	u32 sectorsize = sctx->fs_info->sectorsize;
 	bool force_submit = false;
 	int index;
 
@@ -2206,7 +2207,15 @@ static int scrub_pages(struct scrub_ctx *sctx, u64 logical, u64 len,
 
 	for (index = 0; len > 0; index++) {
 		struct scrub_page *spage;
-		u64 l = min_t(u64, len, PAGE_SIZE);
+		/*
+		 * Here we will allocate one page for one sector to scrub.
+		 * This is fine if PAGE_SIZE == sectorsize, but will cost
+		 * more memory for PAGE_SIZE > sectorsize case.
+		 *
+		 * TODO: Make scrub_block to handle multiple pages and csums,
+		 * so that we don't need scrub_page structure at all.
+		 */
+		u32 l = min_t(u32, sectorsize, len);
 
 		spage = alloc_scrub_page(sctx, GFP_KERNEL);
 		if (!spage) {
@@ -2526,8 +2535,11 @@ static int scrub_pages_for_parity(struct scrub_parity *sparity,
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
@@ -2546,7 +2558,8 @@ static int scrub_pages_for_parity(struct scrub_parity *sparity,
 
 	for (index = 0; len > 0; index++) {
 		struct scrub_page *spage;
-		u64 l = min_t(u64, len, PAGE_SIZE);
+		/* Check scrub_page() for the reason why we use sectorsize */
+		u32 l = sectorsize;
 
 		BUG_ON(index >= SCRUB_MAX_PAGES_PER_BLOCK);
 
-- 
2.29.2

