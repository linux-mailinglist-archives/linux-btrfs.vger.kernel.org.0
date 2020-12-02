Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EC4A2CB54B
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Dec 2020 07:50:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387552AbgLBGuB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Dec 2020 01:50:01 -0500
Received: from mx2.suse.de ([195.135.220.15]:53506 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387533AbgLBGuB (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 2 Dec 2020 01:50:01 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1606891729; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Dh0r33LSE6GDKqd+TH+OYgTaTqiyx2bcc67CEN3TAy0=;
        b=W86+vH1RG4CqaeftE6sVX4hhdH9bUMJycMT98i/LfnI0+HK3Kh4iZpKiUeYypA96d06DnF
        zeA0N9P8nTmH5VFYVohXnJsDVPHbJM8S58MHoQQoRdJjNHZfn0l6RVAZm4SD4GAbNmBk3n
        cn/RDJQ5ChSRaQXAMowTw6clFke7XnE=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 38BFAAEE6
        for <linux-btrfs@vger.kernel.org>; Wed,  2 Dec 2020 06:48:49 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v3 11/15] btrfs: scrub: reduce the width for extent_len/stripe_len from 64 bits to 32 bits
Date:   Wed,  2 Dec 2020 14:48:07 +0800
Message-Id: <20201202064811.100688-12-wqu@suse.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201202064811.100688-1-wqu@suse.com>
References: <20201202064811.100688-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Btrfs on-disk format choose to use u64 for almost everything, but there
are a lot of restriction that, we can't use more than u32 for things like
extent length (the maximum length is 128MiB for non-hole extents), or
stripe length (we have device number limit).

This means if we don't have extra handling to convert u64 to u32, we
will always have some questionable operations like
"u32 = u64 >> sectorsize_bits" in the code.

This patch will try to address the problem by reducing the width for the
following members/parameters:

- scrub_parity::stripe_len
- @len of scrub_pages()
- @extent_len of scrub_remap_extent()
- @len of scrub_parity_mark_sectors_error()
- @len of scrub_parity_mark_sectors_data()
- @len of scrub_extent()
- @len of scrub_pages_for_parity()
- @len of scrub_extent_for_parity()

For members extracted from on-disk structure, like map->stripe_len, they
will be kept as is. Since that modification would require on-disk format
change.

There will be cases like "u32 = u64 - u64" or "u32 = u64", for such call
sites, extra ASSERT() is added to be extra safe for debug build.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/scrub.c | 54 +++++++++++++++++++++++++++---------------------
 1 file changed, 31 insertions(+), 23 deletions(-)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 78759bc9c980..8026606f7510 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -130,7 +130,7 @@ struct scrub_parity {
 
 	int			nsectors;
 
-	u64			stripe_len;
+	u32			stripe_len;
 
 	refcount_t		refs;
 
@@ -233,7 +233,7 @@ static void scrub_parity_get(struct scrub_parity *sparity);
 static void scrub_parity_put(struct scrub_parity *sparity);
 static int scrub_add_page_to_rd_bio(struct scrub_ctx *sctx,
 				    struct scrub_page *spage);
-static int scrub_pages(struct scrub_ctx *sctx, u64 logical, u64 len,
+static int scrub_pages(struct scrub_ctx *sctx, u64 logical, u32 len,
 		       u64 physical, struct btrfs_device *dev, u64 flags,
 		       u64 gen, int mirror_num, u8 *csum,
 		       u64 physical_for_dev_replace);
@@ -241,7 +241,7 @@ static void scrub_bio_end_io(struct bio *bio);
 static void scrub_bio_end_io_worker(struct btrfs_work *work);
 static void scrub_block_complete(struct scrub_block *sblock);
 static void scrub_remap_extent(struct btrfs_fs_info *fs_info,
-			       u64 extent_logical, u64 extent_len,
+			       u64 extent_logical, u32 extent_len,
 			       u64 *extent_physical,
 			       struct btrfs_device **extent_dev,
 			       int *extent_mirror_num);
@@ -2147,7 +2147,7 @@ static void scrub_missing_raid56_pages(struct scrub_block *sblock)
 	spin_unlock(&sctx->stat_lock);
 }
 
-static int scrub_pages(struct scrub_ctx *sctx, u64 logical, u64 len,
+static int scrub_pages(struct scrub_ctx *sctx, u64 logical, u32 len,
 		       u64 physical, struct btrfs_device *dev, u64 flags,
 		       u64 gen, int mirror_num, u8 *csum,
 		       u64 physical_for_dev_replace)
@@ -2171,7 +2171,7 @@ static int scrub_pages(struct scrub_ctx *sctx, u64 logical, u64 len,
 
 	for (index = 0; len > 0; index++) {
 		struct scrub_page *spage;
-		u64 l = min_t(u64, len, PAGE_SIZE);
+		u32 l = min_t(u32, len, PAGE_SIZE);
 
 		spage = kzalloc(sizeof(*spage), GFP_KERNEL);
 		if (!spage) {
@@ -2292,10 +2292,9 @@ static void scrub_bio_end_io_worker(struct btrfs_work *work)
 
 static inline void __scrub_mark_bitmap(struct scrub_parity *sparity,
 				       unsigned long *bitmap,
-				       u64 start, u64 len)
+				       u64 start, u32 len)
 {
 	u64 offset;
-	u64 nsectors64;
 	u32 nsectors;
 	u32 sectorsize_bits = sparity->sctx->fs_info->sectorsize_bits;
 
@@ -2307,10 +2306,7 @@ static inline void __scrub_mark_bitmap(struct scrub_parity *sparity,
 	start -= sparity->logic_start;
 	start = div64_u64_rem(start, sparity->stripe_len, &offset);
 	offset = offset >> sectorsize_bits;
-	nsectors64 = len >> sectorsize_bits;
-
-	ASSERT(nsectors64 < UINT_MAX);
-	nsectors = (u32)nsectors64;
+	nsectors = len >> sectorsize_bits;
 
 	if (offset + nsectors <= sparity->nsectors) {
 		bitmap_set(bitmap, offset, nsectors);
@@ -2322,13 +2318,13 @@ static inline void __scrub_mark_bitmap(struct scrub_parity *sparity,
 }
 
 static inline void scrub_parity_mark_sectors_error(struct scrub_parity *sparity,
-						   u64 start, u64 len)
+						   u64 start, u32 len)
 {
 	__scrub_mark_bitmap(sparity, sparity->ebitmap, start, len);
 }
 
 static inline void scrub_parity_mark_sectors_data(struct scrub_parity *sparity,
-						  u64 start, u64 len)
+						  u64 start, u32 len)
 {
 	__scrub_mark_bitmap(sparity, sparity->dbitmap, start, len);
 }
@@ -2356,6 +2352,7 @@ static void scrub_block_complete(struct scrub_block *sblock)
 		u64 end = sblock->pagev[sblock->page_count - 1]->logical +
 			  PAGE_SIZE;
 
+		ASSERT(end - start <= U32_MAX);
 		scrub_parity_mark_sectors_error(sblock->sparity,
 						start, end - start);
 	}
@@ -2425,7 +2422,7 @@ static int scrub_find_csum(struct scrub_ctx *sctx, u64 logical, u8 *csum)
 
 /* scrub extent tries to collect up to 64 kB for each bio */
 static int scrub_extent(struct scrub_ctx *sctx, struct map_lookup *map,
-			u64 logical, u64 len,
+			u64 logical, u32 len,
 			u64 physical, struct btrfs_device *dev, u64 flags,
 			u64 gen, int mirror_num, u64 physical_for_dev_replace)
 {
@@ -2457,7 +2454,7 @@ static int scrub_extent(struct scrub_ctx *sctx, struct map_lookup *map,
 	}
 
 	while (len) {
-		u64 l = min_t(u64, len, blocksize);
+		u32 l = min(len, blocksize);
 		int have_csum = 0;
 
 		if (flags & BTRFS_EXTENT_FLAG_DATA) {
@@ -2480,7 +2477,7 @@ static int scrub_extent(struct scrub_ctx *sctx, struct map_lookup *map,
 }
 
 static int scrub_pages_for_parity(struct scrub_parity *sparity,
-				  u64 logical, u64 len,
+				  u64 logical, u32 len,
 				  u64 physical, struct btrfs_device *dev,
 				  u64 flags, u64 gen, int mirror_num, u8 *csum)
 {
@@ -2506,7 +2503,7 @@ static int scrub_pages_for_parity(struct scrub_parity *sparity,
 
 	for (index = 0; len > 0; index++) {
 		struct scrub_page *spage;
-		u64 l = min_t(u64, len, PAGE_SIZE);
+		u32 l = min_t(u32, len, PAGE_SIZE);
 
 		spage = kzalloc(sizeof(*spage), GFP_KERNEL);
 		if (!spage) {
@@ -2564,7 +2561,7 @@ static int scrub_pages_for_parity(struct scrub_parity *sparity,
 }
 
 static int scrub_extent_for_parity(struct scrub_parity *sparity,
-				   u64 logical, u64 len,
+				   u64 logical, u32 len,
 				   u64 physical, struct btrfs_device *dev,
 				   u64 flags, u64 gen, int mirror_num)
 {
@@ -2588,7 +2585,7 @@ static int scrub_extent_for_parity(struct scrub_parity *sparity,
 	}
 
 	while (len) {
-		u64 l = min_t(u64, len, blocksize);
+		u32 l = min(len, blocksize);
 		int have_csum = 0;
 
 		if (flags & BTRFS_EXTENT_FLAG_DATA) {
@@ -2792,7 +2789,8 @@ static noinline_for_stack int scrub_raid56_parity(struct scrub_ctx *sctx,
 	u64 generation;
 	u64 extent_logical;
 	u64 extent_physical;
-	u64 extent_len;
+	/* Check the comment in scrub_stripe() for why u32 is enough here */
+	u32 extent_len;
 	u64 mapped_length;
 	struct btrfs_device *extent_dev;
 	struct scrub_parity *sparity;
@@ -2801,6 +2799,7 @@ static noinline_for_stack int scrub_raid56_parity(struct scrub_ctx *sctx,
 	int extent_mirror_num;
 	int stop_loop = 0;
 
+	ASSERT(map->stripe_len <= U32_MAX);
 	nsectors = map->stripe_len >> fs_info->sectorsize_bits;
 	bitmap_len = scrub_calc_parity_bitmap_len(nsectors);
 	sparity = kzalloc(sizeof(struct scrub_parity) + 2 * bitmap_len,
@@ -2812,6 +2811,7 @@ static noinline_for_stack int scrub_raid56_parity(struct scrub_ctx *sctx,
 		return -ENOMEM;
 	}
 
+	ASSERT(map->stripe_len <= U32_MAX);
 	sparity->stripe_len = map->stripe_len;
 	sparity->nsectors = nsectors;
 	sparity->sctx = sctx;
@@ -2906,6 +2906,7 @@ static noinline_for_stack int scrub_raid56_parity(struct scrub_ctx *sctx,
 			}
 again:
 			extent_logical = key.objectid;
+			ASSERT(bytes <= U32_MAX);
 			extent_len = bytes;
 
 			if (extent_logical < logic_start) {
@@ -2984,9 +2985,11 @@ static noinline_for_stack int scrub_raid56_parity(struct scrub_ctx *sctx,
 		logic_start += map->stripe_len;
 	}
 out:
-	if (ret < 0)
+	if (ret < 0) {
+		ASSERT(logic_end - logic_start <= U32_MAX);
 		scrub_parity_mark_sectors_error(sparity, logic_start,
 						logic_end - logic_start);
+	}
 	scrub_parity_put(sparity);
 	scrub_submit(sctx);
 	mutex_lock(&sctx->wr_lock);
@@ -3028,7 +3031,11 @@ static noinline_for_stack int scrub_stripe(struct scrub_ctx *sctx,
 	u64 offset;
 	u64 extent_logical;
 	u64 extent_physical;
-	u64 extent_len;
+	/*
+	 * Unlike chunk length, extent length should never go beyond
+	 * BTRFS_MAX_EXTENT_SIZE, thus u32 is enough here.
+	 */
+	u32 extent_len;
 	u64 stripe_logical;
 	u64 stripe_end;
 	struct btrfs_device *extent_dev;
@@ -3277,6 +3284,7 @@ static noinline_for_stack int scrub_stripe(struct scrub_ctx *sctx,
 
 again:
 			extent_logical = key.objectid;
+			ASSERT(bytes <= U32_MAX);
 			extent_len = bytes;
 
 			/*
@@ -4074,7 +4082,7 @@ int btrfs_scrub_progress(struct btrfs_fs_info *fs_info, u64 devid,
 }
 
 static void scrub_remap_extent(struct btrfs_fs_info *fs_info,
-			       u64 extent_logical, u64 extent_len,
+			       u64 extent_logical, u32 extent_len,
 			       u64 *extent_physical,
 			       struct btrfs_device **extent_dev,
 			       int *extent_mirror_num)
-- 
2.29.2

