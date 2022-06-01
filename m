Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B52F6539AFF
	for <lists+linux-btrfs@lfdr.de>; Wed,  1 Jun 2022 03:59:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349067AbiFAB7h (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 31 May 2022 21:59:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349062AbiFAB7c (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 31 May 2022 21:59:32 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC9CA8FFBE
        for <linux-btrfs@vger.kernel.org>; Tue, 31 May 2022 18:59:30 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 7C4B721BC2
        for <linux-btrfs@vger.kernel.org>; Wed,  1 Jun 2022 01:59:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1654048769; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=W1lbGVO45cYNHn2RcGrp6c7DZYYfrzkFbITIo2f/9Rc=;
        b=KEzB71sj/XCzq4EYuoJJcAn2jDoHxATI1KFRmqqq7eWDMVRuyDmvFBMYips5NM+zUb5rvO
        YNanGCfWojZHi1JKoHO8AVATKu2HRKTTBvH05OHVsCXh7Dj4B8p7LotWkrU7rj4bsmstwj
        zjw+vrKAOi/sj3KLJkRljW15V21cnHw=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BB30913443
        for <linux-btrfs@vger.kernel.org>; Wed,  1 Jun 2022 01:59:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id aICJHwDIlmI9QQAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Wed, 01 Jun 2022 01:59:28 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 2/3] btrfs: use integrated bitmaps for scrub_parity::dbitmap and ebitmap
Date:   Wed,  1 Jun 2022 09:59:07 +0800
Message-Id: <7d49124374f73251c413aff235918482cd506a8d.1654048515.git.wqu@suse.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1654048515.git.wqu@suse.com>
References: <cover.1654048515.git.wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Previously we use "unsigned long *" for those two bitmaps.

But since we only support fixed stripe length (64KiB, already checked in
tree-checker), "unsigned long *" is really a waste of memory, while we
can just use "unsigned long".

This saves us 8 bytes in total for scrub_parity.

To be extra safe, add an ASSERT() making sure calclulated @nsectors is
always smaller than BITS_PER_LONG.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/scrub.c | 32 +++++++++++++-------------------
 1 file changed, 13 insertions(+), 19 deletions(-)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index e7b0323e6efd..46cac7c7f292 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -135,15 +135,13 @@ struct scrub_parity {
 	struct work_struct	work;
 
 	/* Mark the parity blocks which have data */
-	unsigned long		*dbitmap;
+	unsigned long		dbitmap;
 
 	/*
 	 * Mark the parity blocks which have data, but errors happen when
 	 * read data or check data
 	 */
-	unsigned long		*ebitmap;
-
-	unsigned long		bitmap[];
+	unsigned long		ebitmap;
 };
 
 struct scrub_ctx {
@@ -2406,13 +2404,13 @@ static inline void __scrub_mark_bitmap(struct scrub_parity *sparity,
 static inline void scrub_parity_mark_sectors_error(struct scrub_parity *sparity,
 						   u64 start, u32 len)
 {
-	__scrub_mark_bitmap(sparity, sparity->ebitmap, start, len);
+	__scrub_mark_bitmap(sparity, &sparity->ebitmap, start, len);
 }
 
 static inline void scrub_parity_mark_sectors_data(struct scrub_parity *sparity,
 						  u64 start, u32 len)
 {
-	__scrub_mark_bitmap(sparity, sparity->dbitmap, start, len);
+	__scrub_mark_bitmap(sparity, &sparity->dbitmap, start, len);
 }
 
 static void scrub_block_complete(struct scrub_block *sblock)
@@ -2763,7 +2761,7 @@ static void scrub_free_parity(struct scrub_parity *sparity)
 	struct scrub_sector *curr, *next;
 	int nbits;
 
-	nbits = bitmap_weight(sparity->ebitmap, sparity->nsectors);
+	nbits = bitmap_weight(&sparity->ebitmap, sparity->nsectors);
 	if (nbits) {
 		spin_lock(&sctx->stat_lock);
 		sctx->stat.read_errors += nbits;
@@ -2795,8 +2793,8 @@ static void scrub_parity_bio_endio(struct bio *bio)
 	struct btrfs_fs_info *fs_info = sparity->sctx->fs_info;
 
 	if (bio->bi_status)
-		bitmap_or(sparity->ebitmap, sparity->ebitmap, sparity->dbitmap,
-			  sparity->nsectors);
+		bitmap_or(&sparity->ebitmap, &sparity->ebitmap,
+			  &sparity->dbitmap, sparity->nsectors);
 
 	bio_put(bio);
 
@@ -2814,8 +2812,8 @@ static void scrub_parity_check_and_repair(struct scrub_parity *sparity)
 	u64 length;
 	int ret;
 
-	if (!bitmap_andnot(sparity->dbitmap, sparity->dbitmap, sparity->ebitmap,
-			   sparity->nsectors))
+	if (!bitmap_andnot(&sparity->dbitmap, &sparity->dbitmap,
+			   &sparity->ebitmap, sparity->nsectors))
 		goto out;
 
 	length = sparity->logic_end - sparity->logic_start;
@@ -2833,7 +2831,7 @@ static void scrub_parity_check_and_repair(struct scrub_parity *sparity)
 
 	rbio = raid56_parity_alloc_scrub_rbio(bio, bioc, length,
 					      sparity->scrub_dev,
-					      sparity->dbitmap,
+					      &sparity->dbitmap,
 					      sparity->nsectors);
 	if (!rbio)
 		goto rbio_out;
@@ -2847,7 +2845,7 @@ static void scrub_parity_check_and_repair(struct scrub_parity *sparity)
 bioc_out:
 	btrfs_bio_counter_dec(fs_info);
 	btrfs_put_bioc(bioc);
-	bitmap_or(sparity->ebitmap, sparity->ebitmap, sparity->dbitmap,
+	bitmap_or(&sparity->ebitmap, &sparity->ebitmap, &sparity->dbitmap,
 		  sparity->nsectors);
 	spin_lock(&sctx->stat_lock);
 	sctx->stat.malloc_errors++;
@@ -3131,7 +3129,6 @@ static noinline_for_stack int scrub_raid56_parity(struct scrub_ctx *sctx,
 	int ret;
 	struct scrub_parity *sparity;
 	int nsectors;
-	int bitmap_len;
 
 	path = btrfs_alloc_path();
 	if (!path) {
@@ -3145,9 +3142,8 @@ static noinline_for_stack int scrub_raid56_parity(struct scrub_ctx *sctx,
 
 	ASSERT(map->stripe_len <= U32_MAX);
 	nsectors = map->stripe_len >> fs_info->sectorsize_bits;
-	bitmap_len = scrub_calc_parity_bitmap_len(nsectors);
-	sparity = kzalloc(sizeof(struct scrub_parity) + 2 * bitmap_len,
-			  GFP_NOFS);
+	ASSERT(nsectors <= BITS_PER_LONG);
+	sparity = kzalloc(sizeof(struct scrub_parity), GFP_NOFS);
 	if (!sparity) {
 		spin_lock(&sctx->stat_lock);
 		sctx->stat.malloc_errors++;
@@ -3165,8 +3161,6 @@ static noinline_for_stack int scrub_raid56_parity(struct scrub_ctx *sctx,
 	sparity->logic_end = logic_end;
 	refcount_set(&sparity->refs, 1);
 	INIT_LIST_HEAD(&sparity->sectors_list);
-	sparity->dbitmap = sparity->bitmap;
-	sparity->ebitmap = (void *)sparity->bitmap + bitmap_len;
 
 	ret = 0;
 	for (cur_logical = logic_start; cur_logical < logic_end;
-- 
2.36.1

