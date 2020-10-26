Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 398D8298740
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Oct 2020 08:11:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1770934AbgJZHLg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 26 Oct 2020 03:11:36 -0400
Received: from mx2.suse.de ([195.135.220.15]:51328 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1770928AbgJZHLd (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 26 Oct 2020 03:11:33 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1603696292;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OvCh8+A/QvQlV5NBLohGKLUnJc7UaoGRrNywcohDy34=;
        b=puwjBySANm1cVDeS/yzvm5/bZUVeeqv4wLhDX39oB3VKihPDhn3t+BhpuDn8Rk0DYXb5GI
        LocQhs1pX/HLOSMy4i5WsxWAt7ubgNaikh2i5+UzK/p+0aZYjDHeeWTS7uQe+SsEaz0vUM
        5yPXvQrehPbyDx0Ie+3Cseg1BabCm5Q=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 2030CACA3
        for <linux-btrfs@vger.kernel.org>; Mon, 26 Oct 2020 07:11:32 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 5/8] btrfs: scrub: introduce scrub_page::page_len for subpage support
Date:   Mon, 26 Oct 2020 15:11:12 +0800
Message-Id: <20201026071115.57225-6-wqu@suse.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20201026071115.57225-1-wqu@suse.com>
References: <20201026071115.57225-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Currently scrub_page only has one csum for each page, this is fine if
page size == sector size, then each page has one csum for it.

But for subpage support, we could have cases where only part of the page
is utilized. E.g one 4K sector is read into a 64K page.
In that case, we need a way to determine which range is really utilized.

This patch will introduce scrub_page::page_len so that we can know
where the utilized range ends.

This is especially important for subpage. As write bio can overwrite
existing data if we just submit full page bio.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/scrub.c | 36 +++++++++++++++++++++++++-----------
 1 file changed, 25 insertions(+), 11 deletions(-)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 0d078393f986..bad88c651dd4 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -72,9 +72,15 @@ struct scrub_page {
 	u64			physical_for_dev_replace;
 	atomic_t		refs;
 	struct {
-		unsigned int	mirror_num:8;
-		unsigned int	have_csum:1;
-		unsigned int	io_error:1;
+		/*
+		 * For subpage case, where only part of the page is utilized
+		 * Note that 16 bits can only go 65535, not 65536, thus we have
+		 * to use 17 bits here.
+		 */
+		u32	page_len:17;
+		u32	mirror_num:8;
+		u32	have_csum:1;
+		u32	io_error:1;
 	};
 	struct scrub_recover	*recover;
 
@@ -217,6 +223,11 @@ static struct scrub_page *alloc_scrub_page(struct scrub_ctx *sctx, gfp_t mask)
 	u32 sectorsize = sctx->fs_info->sectorsize;
 	size_t size;
 
+	/*
+	 * The bits in scrub_page::page_len only supports up to 64K page size.
+	 */
+	BUILD_BUG_ON(PAGE_SIZE > SZ_64K);
+
 	/* No support for multi-page sector size yet */
 	ASSERT(PAGE_SIZE >= sectorsize && IS_ALIGNED(PAGE_SIZE, sectorsize));
 
@@ -1359,6 +1370,7 @@ static int scrub_setup_recheck_block(struct scrub_block *original_sblock,
 			}
 			scrub_page_get(spage);
 			sblock->pagev[page_index] = spage;
+			spage->page_len = sublen;
 			spage->sblock = sblock;
 			spage->flags = flags;
 			spage->generation = generation;
@@ -1452,7 +1464,7 @@ static void scrub_recheck_block_on_raid56(struct btrfs_fs_info *fs_info,
 		struct scrub_page *spage = sblock->pagev[page_num];
 
 		WARN_ON(!spage->page);
-		bio_add_page(bio, spage->page, PAGE_SIZE, 0);
+		bio_add_page(bio, spage->page, spage->page_len, 0);
 	}
 
 	if (scrub_submit_raid56_bio_wait(fs_info, bio, first_page)) {
@@ -1505,7 +1517,7 @@ static void scrub_recheck_block(struct btrfs_fs_info *fs_info,
 		bio = btrfs_io_bio_alloc(1);
 		bio_set_dev(bio, spage->dev->bdev);
 
-		bio_add_page(bio, spage->page, PAGE_SIZE, 0);
+		bio_add_page(bio, spage->page, spage->page_len, 0);
 		bio->bi_iter.bi_sector = spage->physical >> 9;
 		bio->bi_opf = REQ_OP_READ;
 
@@ -1588,8 +1600,8 @@ static int scrub_repair_page_from_good_copy(struct scrub_block *sblock_bad,
 		bio->bi_iter.bi_sector = spage_bad->physical >> 9;
 		bio->bi_opf = REQ_OP_WRITE;
 
-		ret = bio_add_page(bio, spage_good->page, PAGE_SIZE, 0);
-		if (PAGE_SIZE != ret) {
+		ret = bio_add_page(bio, spage_good->page, spage_good->page_len, 0);
+		if (ret != spage_good->page_len) {
 			bio_put(bio);
 			return -EIO;
 		}
@@ -1685,8 +1697,8 @@ static int scrub_add_page_to_wr_bio(struct scrub_ctx *sctx,
 		goto again;
 	}
 
-	ret = bio_add_page(sbio->bio, spage->page, PAGE_SIZE, 0);
-	if (ret != PAGE_SIZE) {
+	ret = bio_add_page(sbio->bio, spage->page, spage->page_len, 0);
+	if (ret != spage->page_len) {
 		if (sbio->page_count < 1) {
 			bio_put(sbio->bio);
 			sbio->bio = NULL;
@@ -2033,8 +2045,8 @@ static int scrub_add_page_to_rd_bio(struct scrub_ctx *sctx,
 	}
 
 	sbio->pagev[sbio->page_count] = spage;
-	ret = bio_add_page(sbio->bio, spage->page, PAGE_SIZE, 0);
-	if (ret != PAGE_SIZE) {
+	ret = bio_add_page(sbio->bio, spage->page, spage->page_len, 0);
+	if (ret != spage->page_len) {
 		if (sbio->page_count < 1) {
 			bio_put(sbio->bio);
 			sbio->bio = NULL;
@@ -2210,6 +2222,7 @@ static int scrub_pages(struct scrub_ctx *sctx, u64 logical, u64 len,
 		BUG_ON(index >= SCRUB_MAX_PAGES_PER_BLOCK);
 		scrub_page_get(spage);
 		sblock->pagev[index] = spage;
+		spage->page_len = l;
 		spage->sblock = sblock;
 		spage->dev = dev;
 		spage->flags = flags;
@@ -2554,6 +2567,7 @@ static int scrub_pages_for_parity(struct scrub_parity *sparity,
 		/* For scrub parity */
 		scrub_page_get(spage);
 		list_add_tail(&spage->list, &sparity->spages);
+		spage->page_len = l;
 		spage->sblock = sblock;
 		spage->dev = dev;
 		spage->flags = flags;
-- 
2.29.0

