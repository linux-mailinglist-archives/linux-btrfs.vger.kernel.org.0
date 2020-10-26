Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D041129873D
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Oct 2020 08:11:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1770926AbgJZHLa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 26 Oct 2020 03:11:30 -0400
Received: from mx2.suse.de ([195.135.220.15]:51310 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1770918AbgJZHLa (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 26 Oct 2020 03:11:30 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1603696288;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VFjSxUjsT05dCOK8ykeEDO2kZ9tFvMYjjxR/v2Plz58=;
        b=AQP7h/yafYuxdjKv5t1c4oUmykPILpW4IkXwYPEDFKJVW03l6Zx7tLlwylQawEGTIExCe1
        OGx8m0mDlsJsyA60uV4Gy51GA0F1VKMJq/dTxYhL6mOpo81cxNSE+O3foww/K0mBI0jpLp
        VbC9l6GT0+NXwYDNoXw8EU53hWwOYBA=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D8441ACA3
        for <linux-btrfs@vger.kernel.org>; Mon, 26 Oct 2020 07:11:28 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 3/8] btrfs: scrub: use flexible array for scrub_page::csums
Date:   Mon, 26 Oct 2020 15:11:10 +0800
Message-Id: <20201026071115.57225-4-wqu@suse.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20201026071115.57225-1-wqu@suse.com>
References: <20201026071115.57225-1-wqu@suse.com>
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
index 3cb51d1f061f..321d6d457942 100644
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
@@ -207,6 +212,19 @@ struct full_stripe_lock {
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
+	size += (PAGE_SIZE / sectorsize) * sctx->csum_size;
+	return kzalloc(size, mask);
+}
+
 static void scrub_pending_bio_inc(struct scrub_ctx *sctx);
 static void scrub_pending_bio_dec(struct scrub_ctx *sctx);
 static int scrub_handle_errored_block(struct scrub_block *sblock_to_check);
@@ -1330,7 +1348,7 @@ static int scrub_setup_recheck_block(struct scrub_block *original_sblock,
 			sblock = sblocks_for_recheck + mirror_index;
 			sblock->sctx = sctx;
 
-			spage = kzalloc(sizeof(*spage), GFP_NOFS);
+			spage = alloc_scrub_page(sctx, GFP_NOFS);
 			if (!spage) {
 leave_nomem:
 				spin_lock(&sctx->stat_lock);
@@ -1347,8 +1365,8 @@ static int scrub_setup_recheck_block(struct scrub_block *original_sblock,
 			spage->logical = logical;
 			spage->have_csum = have_csum;
 			if (have_csum)
-				memcpy(spage->csum,
-				       original_sblock->pagev[0]->csum,
+				memcpy(spage->csums,
+				       original_sblock->pagev[0]->csums,
 				       sctx->csum_size);
 
 			scrub_stripe_index_and_offset(logical,
@@ -1800,7 +1818,7 @@ static int scrub_checksum_data(struct scrub_block *sblock)
 	crypto_shash_init(shash);
 	crypto_shash_digest(shash, kaddr, PAGE_SIZE, csum);
 
-	if (memcmp(csum, spage->csum, sctx->csum_size))
+	if (memcmp(csum, spage->csums, sctx->csum_size))
 		sblock->checksum_error = 1;
 
 	return sblock->checksum_error;
@@ -2180,7 +2198,7 @@ static int scrub_pages(struct scrub_ctx *sctx, u64 logical, u64 len,
 		struct scrub_page *spage;
 		u64 l = min_t(u64, len, PAGE_SIZE);
 
-		spage = kzalloc(sizeof(*spage), GFP_KERNEL);
+		spage = alloc_scrub_page(sctx, GFP_KERNEL);
 		if (!spage) {
 leave_nomem:
 			spin_lock(&sctx->stat_lock);
@@ -2202,7 +2220,7 @@ static int scrub_pages(struct scrub_ctx *sctx, u64 logical, u64 len,
 		spage->mirror_num = mirror_num;
 		if (csum) {
 			spage->have_csum = 1;
-			memcpy(spage->csum, csum, sctx->csum_size);
+			memcpy(spage->csums, csum, sctx->csum_size);
 		} else {
 			spage->have_csum = 0;
 		}
@@ -2487,7 +2505,9 @@ static int scrub_pages_for_parity(struct scrub_parity *sparity,
 		struct scrub_page *spage;
 		u64 l = min_t(u64, len, PAGE_SIZE);
 
-		spage = kzalloc(sizeof(*spage), GFP_KERNEL);
+		BUG_ON(index >= SCRUB_MAX_PAGES_PER_BLOCK);
+
+		spage = alloc_scrub_page(sctx, GFP_KERNEL);
 		if (!spage) {
 leave_nomem:
 			spin_lock(&sctx->stat_lock);
@@ -2496,7 +2516,6 @@ static int scrub_pages_for_parity(struct scrub_parity *sparity,
 			scrub_block_put(sblock);
 			return -ENOMEM;
 		}
-		BUG_ON(index >= SCRUB_MAX_PAGES_PER_BLOCK);
 		/* For scrub block */
 		scrub_page_get(spage);
 		sblock->pagev[index] = spage;
@@ -2512,7 +2531,7 @@ static int scrub_pages_for_parity(struct scrub_parity *sparity,
 		spage->mirror_num = mirror_num;
 		if (csum) {
 			spage->have_csum = 1;
-			memcpy(spage->csum, csum, sctx->csum_size);
+			memcpy(spage->csums, csum, sctx->csum_size);
 		} else {
 			spage->have_csum = 0;
 		}
-- 
2.29.0

