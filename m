Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3502A2A469B
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Nov 2020 14:33:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729322AbgKCNcc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 3 Nov 2020 08:32:32 -0500
Received: from mx2.suse.de ([195.135.220.15]:45490 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729405AbgKCNcc (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 3 Nov 2020 08:32:32 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1604410350;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GbHH2JHPNEM+uYbLlCAM8NRsL65dfAtsCgryFGF7fbA=;
        b=rLNuR96dlIWZUK4GIl69NGwvVqfxGGL2qSCfglxfhJfF48YiprI+1O3e4pe63ZgH3+X+5a
        8B8AkfFBsnT733ZTc8P9K1QyPLz8KN021JAlCfiAHkSNAhpaoKH2Ojm4975ycjVxVtS44q
        YqPmbhwkj/S90uC6KiLETQfvX6vEjew=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 90F5FAFAA
        for <linux-btrfs@vger.kernel.org>; Tue,  3 Nov 2020 13:32:30 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 27/32] btrfs: scrub: use flexible array for scrub_page::csums
Date:   Tue,  3 Nov 2020 21:31:03 +0800
Message-Id: <20201103133108.148112-28-wqu@suse.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201103133108.148112-1-wqu@suse.com>
References: <20201103133108.148112-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

There are several factors affecting how many checksum bytes are needed
for one scrub_page:

- Sector size and page size
  For subpage case, one page can contain several sectors, thus the csum
  size will differ.

- Checksum size
  Since btrfs supports different csum size now, which can vary from 4
  bytes for CRC32 to 32 bytes for SHA256.

So instead of using fixed BTRFS_CSUM_SIZE, now use flexible array for
scrub_page::csums, and determine the size at scrub_page allocation time.

This does not only provide the basis for later subpage scrub support,
but also reduce the memory usage for default btrfs on x86_64.
As the default CRC32 only uses 4 bytes, thus we can save 28 bytes for
each scrub page.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/scrub.c | 41 ++++++++++++++++++++++++++++++-----------
 1 file changed, 30 insertions(+), 11 deletions(-)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 7e6ed0b79006..cabc030d4bf9 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -76,9 +76,14 @@ struct scrub_page {
 		unsigned int	have_csum:1;
 		unsigned int	io_error:1;
 	};
-	u8			csum[BTRFS_CSUM_SIZE];
-
 	struct scrub_recover	*recover;
+
+	/*
+	 * The csums size for the page is deteremined by page size,
+	 * sector size and csum size.
+	 * Thus the length has to be determined at runtime.
+	 */
+	u8			csums[];
 };
 
 struct scrub_bio {
@@ -206,6 +211,19 @@ struct full_stripe_lock {
 	struct mutex mutex;
 };
 
+static struct scrub_page *alloc_scrub_page(struct scrub_ctx *sctx, gfp_t mask)
+{
+	u32 sectorsize = sctx->fs_info->sectorsize;
+	size_t size;
+
+	/* No support for multi-page sector size yet */
+	ASSERT(PAGE_SIZE >= sectorsize && IS_ALIGNED(PAGE_SIZE, sectorsize));
+
+	size = sizeof(struct scrub_page);
+	size += (PAGE_SIZE / sectorsize) * sctx->fs_info->csum_size;
+	return kzalloc(size, mask);
+}
+
 static void scrub_pending_bio_inc(struct scrub_ctx *sctx);
 static void scrub_pending_bio_dec(struct scrub_ctx *sctx);
 static int scrub_handle_errored_block(struct scrub_block *sblock_to_check);
@@ -1328,7 +1346,7 @@ static int scrub_setup_recheck_block(struct scrub_block *original_sblock,
 			sblock = sblocks_for_recheck + mirror_index;
 			sblock->sctx = sctx;
 
-			spage = kzalloc(sizeof(*spage), GFP_NOFS);
+			spage = alloc_scrub_page(sctx, GFP_NOFS);
 			if (!spage) {
 leave_nomem:
 				spin_lock(&sctx->stat_lock);
@@ -1345,8 +1363,8 @@ static int scrub_setup_recheck_block(struct scrub_block *original_sblock,
 			spage->logical = logical;
 			spage->have_csum = have_csum;
 			if (have_csum)
-				memcpy(spage->csum,
-				       original_sblock->pagev[0]->csum,
+				memcpy(spage->csums,
+				       original_sblock->pagev[0]->csums,
 				       sctx->fs_info->csum_size);
 
 			scrub_stripe_index_and_offset(logical,
@@ -1798,7 +1816,7 @@ static int scrub_checksum_data(struct scrub_block *sblock)
 	crypto_shash_init(shash);
 	crypto_shash_digest(shash, kaddr, PAGE_SIZE, csum);
 
-	if (memcmp(csum, spage->csum, sctx->fs_info->csum_size))
+	if (memcmp(csum, spage->csums, sctx->fs_info->csum_size))
 		sblock->checksum_error = 1;
 
 	return sblock->checksum_error;
@@ -2178,7 +2196,7 @@ static int scrub_pages(struct scrub_ctx *sctx, u64 logical, u64 len,
 		struct scrub_page *spage;
 		u64 l = min_t(u64, len, PAGE_SIZE);
 
-		spage = kzalloc(sizeof(*spage), GFP_KERNEL);
+		spage = alloc_scrub_page(sctx, GFP_KERNEL);
 		if (!spage) {
 leave_nomem:
 			spin_lock(&sctx->stat_lock);
@@ -2200,7 +2218,7 @@ static int scrub_pages(struct scrub_ctx *sctx, u64 logical, u64 len,
 		spage->mirror_num = mirror_num;
 		if (csum) {
 			spage->have_csum = 1;
-			memcpy(spage->csum, csum, sctx->fs_info->csum_size);
+			memcpy(spage->csums, csum, sctx->fs_info->csum_size);
 		} else {
 			spage->have_csum = 0;
 		}
@@ -2486,7 +2504,9 @@ static int scrub_pages_for_parity(struct scrub_parity *sparity,
 		struct scrub_page *spage;
 		u64 l = min_t(u64, len, PAGE_SIZE);
 
-		spage = kzalloc(sizeof(*spage), GFP_KERNEL);
+		BUG_ON(index >= SCRUB_MAX_PAGES_PER_BLOCK);
+
+		spage = alloc_scrub_page(sctx, GFP_KERNEL);
 		if (!spage) {
 leave_nomem:
 			spin_lock(&sctx->stat_lock);
@@ -2495,7 +2515,6 @@ static int scrub_pages_for_parity(struct scrub_parity *sparity,
 			scrub_block_put(sblock);
 			return -ENOMEM;
 		}
-		BUG_ON(index >= SCRUB_MAX_PAGES_PER_BLOCK);
 		/* For scrub block */
 		scrub_page_get(spage);
 		sblock->pagev[index] = spage;
@@ -2511,7 +2530,7 @@ static int scrub_pages_for_parity(struct scrub_parity *sparity,
 		spage->mirror_num = mirror_num;
 		if (csum) {
 			spage->have_csum = 1;
-			memcpy(spage->csum, csum, sctx->fs_info->csum_size);
+			memcpy(spage->csums, csum, sctx->fs_info->csum_size);
 		} else {
 			spage->have_csum = 0;
 		}
-- 
2.29.2

