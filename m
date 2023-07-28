Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C964766B7C
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Jul 2023 13:14:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236198AbjG1LOe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 28 Jul 2023 07:14:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236197AbjG1LOc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 28 Jul 2023 07:14:32 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE3D010FC
        for <linux-btrfs@vger.kernel.org>; Fri, 28 Jul 2023 04:14:30 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id A9536219BC
        for <linux-btrfs@vger.kernel.org>; Fri, 28 Jul 2023 11:14:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1690542869; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=InG9EpiRkRah1L+i6moJfcB+zHf0Go+AwdDp5lk2oDQ=;
        b=pJll6w9dneJpdJvSD7QnomOqZcz7bLvwXGTEF3pTa6r9UbS/N3gOOaOSLSGH6jzdrLixyN
        B8ki34wRgbfrq1e+puivmQTbCIWf8WTOIr0/HV+yKazWr1ZQyKOv7UB4LiYA61x+k+YAAP
        g+E5YrXXcA380XEKdS0BovuLXqdFi9I=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 01E5E133F7
        for <linux-btrfs@vger.kernel.org>; Fri, 28 Jul 2023 11:14:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id oHIOLxSjw2RBQAAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Fri, 28 Jul 2023 11:14:28 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 2/5] btrfs: scrub: avoid unnecessary csum tree search preparing stripes
Date:   Fri, 28 Jul 2023 19:14:05 +0800
Message-ID: <465e1424ef584659b72398b74171d8399d0e752d.1690542141.git.wqu@suse.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1690542141.git.wqu@suse.com>
References: <cover.1690542141.git.wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

One of the bottleneck of the new scrub code is the extra csum tree
search.

The old code would only do the csum tree search for each scrub bio,
which can be as large as 512KiB, thus they can afford to allocate a new
patch each time.

But the new scrub code is doing csum tree search for each stripe, which
is only 64KiB, this means we'd better re-use the same csum path during
each search.

This patch would introduce a per-sctx path for csum tree search, as we
don't need to re-allocate the path every time we need to do a csum tree
search.

With this change we can further improve the queue depth and improve the
scrub read performance:

Before (with regression and cached extent tree path):

 Device         r/s      rkB/s   rrqm/s  %rrqm r_await rareq-sz aqu-sz  %util
 nvme0n1p3 15875.00 1013328.00    12.00   0.08    0.08    63.83   1.35 100.00

After (with both cached extent/csum tree path):

 nvme0n1p3 17759.00 1133280.00    10.00   0.06    0.08    63.81   1.50 100.00

Fixes: e02ee89baa66 ("btrfs: scrub: switch scrub_simple_mirror() to scrub_stripe infrastructure")
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/file-item.c | 33 +++++++++++++++++++++------------
 fs/btrfs/file-item.h |  6 +++---
 fs/btrfs/raid56.c    |  4 ++--
 fs/btrfs/scrub.c     | 29 +++++++++++++++++++----------
 4 files changed, 45 insertions(+), 27 deletions(-)

diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
index 696bf695d8eb..21ee77d26c23 100644
--- a/fs/btrfs/file-item.c
+++ b/fs/btrfs/file-item.c
@@ -597,29 +597,36 @@ int btrfs_lookup_csums_list(struct btrfs_root *root, u64 start, u64 end,
  * Each bit represents a sector. Thus caller should ensure @csum_buf passed
  * in is large enough to contain all csums.
  */
-int btrfs_lookup_csums_bitmap(struct btrfs_root *root, u64 start, u64 end,
-			      u8 *csum_buf, unsigned long *csum_bitmap,
-			      bool search_commit)
+int btrfs_lookup_csums_bitmap(struct btrfs_root *root, struct btrfs_path *path,
+			      u64 start, u64 end, u8 *csum_buf,
+			      unsigned long *csum_bitmap)
 {
 	struct btrfs_fs_info *fs_info = root->fs_info;
 	struct btrfs_key key;
-	struct btrfs_path *path;
 	struct extent_buffer *leaf;
 	struct btrfs_csum_item *item;
 	const u64 orig_start = start;
+	bool free_path = false;
 	int ret;
 
 	ASSERT(IS_ALIGNED(start, fs_info->sectorsize) &&
 	       IS_ALIGNED(end + 1, fs_info->sectorsize));
 
-	path = btrfs_alloc_path();
-	if (!path)
-		return -ENOMEM;
+	if (!path) {
+		path = btrfs_alloc_path();
+		if (!path)
+			return -ENOMEM;
+		free_path = true;
+	}
 
-	if (search_commit) {
-		path->skip_locking = 1;
-		path->reada = READA_FORWARD;
-		path->search_commit_root = 1;
+	/* Check if we can reuse the previous path. */
+	if (path->nodes[0]) {
+		btrfs_item_key_to_cpu(path->nodes[0], &key, path->slots[0]);
+
+		if (key.objectid == BTRFS_EXTENT_CSUM_OBJECTID &&
+		    key.type == BTRFS_EXTENT_CSUM_KEY && key.offset <= start)
+			goto search_forward;
+		btrfs_release_path(path);
 	}
 
 	key.objectid = BTRFS_EXTENT_CSUM_OBJECTID;
@@ -656,6 +663,7 @@ int btrfs_lookup_csums_bitmap(struct btrfs_root *root, u64 start, u64 end,
 		}
 	}
 
+search_forward:
 	while (start <= end) {
 		u64 csum_end;
 
@@ -712,7 +720,8 @@ int btrfs_lookup_csums_bitmap(struct btrfs_root *root, u64 start, u64 end,
 	}
 	ret = 0;
 fail:
-	btrfs_free_path(path);
+	if (free_path)
+		btrfs_free_path(path);
 	return ret;
 }
 
diff --git a/fs/btrfs/file-item.h b/fs/btrfs/file-item.h
index 4ec669b69008..04bd2d34efb1 100644
--- a/fs/btrfs/file-item.h
+++ b/fs/btrfs/file-item.h
@@ -57,9 +57,9 @@ int btrfs_lookup_csums_range(struct btrfs_root *root, u64 start, u64 end,
 int btrfs_lookup_csums_list(struct btrfs_root *root, u64 start, u64 end,
 			    struct list_head *list, int search_commit,
 			    bool nowait);
-int btrfs_lookup_csums_bitmap(struct btrfs_root *root, u64 start, u64 end,
-			      u8 *csum_buf, unsigned long *csum_bitmap,
-			      bool search_commit);
+int btrfs_lookup_csums_bitmap(struct btrfs_root *root, struct btrfs_path *path,
+			      u64 start, u64 end, u8 *csum_buf,
+			      unsigned long *csum_bitmap);
 void btrfs_extent_item_to_extent_map(struct btrfs_inode *inode,
 				     const struct btrfs_path *path,
 				     struct btrfs_file_extent_item *fi,
diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
index f97fc62fbab2..3e014b9370a3 100644
--- a/fs/btrfs/raid56.c
+++ b/fs/btrfs/raid56.c
@@ -2105,8 +2105,8 @@ static void fill_data_csums(struct btrfs_raid_bio *rbio)
 		goto error;
 	}
 
-	ret = btrfs_lookup_csums_bitmap(csum_root, start, start + len - 1,
-					rbio->csum_buf, rbio->csum_bitmap, false);
+	ret = btrfs_lookup_csums_bitmap(csum_root, NULL, start, start + len - 1,
+					rbio->csum_buf, rbio->csum_bitmap);
 	if (ret < 0)
 		goto error;
 	if (bitmap_empty(rbio->csum_bitmap, len >> fs_info->sectorsize_bits))
diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index d10afe94096f..1748735f72c6 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -176,6 +176,7 @@ struct scrub_ctx {
 	struct scrub_stripe	*raid56_data_stripes;
 	struct btrfs_fs_info	*fs_info;
 	struct btrfs_path	extent_path;
+	struct btrfs_path	csum_path;
 	int			first_free;
 	int			cur_stripe;
 	atomic_t		cancel_req;
@@ -342,6 +343,8 @@ static noinline_for_stack struct scrub_ctx *scrub_setup_ctx(
 	sctx->fs_info = fs_info;
 	sctx->extent_path.search_commit_root = 1;
 	sctx->extent_path.skip_locking = 1;
+	sctx->csum_path.search_commit_root = 1;
+	sctx->csum_path.skip_locking = 1;
 	for (i = 0; i < SCRUB_STRIPES_PER_SCTX; i++) {
 		int ret;
 
@@ -1470,6 +1473,7 @@ static void scrub_stripe_reset_bitmaps(struct scrub_stripe *stripe)
  */
 static int scrub_find_fill_first_stripe(struct btrfs_block_group *bg,
 					struct btrfs_path *extent_path,
+					struct btrfs_path *csum_path,
 					struct btrfs_device *dev, u64 physical,
 					int mirror_num, u64 logical_start,
 					u32 logical_len,
@@ -1561,9 +1565,9 @@ static int scrub_find_fill_first_stripe(struct btrfs_block_group *bg,
 		 */
 		ASSERT(BITS_PER_LONG >= BTRFS_STRIPE_LEN >> fs_info->sectorsize_bits);
 
-		ret = btrfs_lookup_csums_bitmap(csum_root, stripe->logical,
-						stripe_end, stripe->csums,
-						&csum_bitmap, true);
+		ret = btrfs_lookup_csums_bitmap(csum_root, csum_path,
+						stripe->logical, stripe_end,
+						stripe->csums, &csum_bitmap);
 		if (ret < 0)
 			goto out;
 		if (ret > 0)
@@ -1765,9 +1769,9 @@ static int queue_scrub_stripe(struct scrub_ctx *sctx, struct btrfs_block_group *
 
 	/* We can queue one stripe using the remaining slot. */
 	scrub_reset_stripe(stripe);
-	ret = scrub_find_fill_first_stripe(bg, &sctx->extent_path, dev,
-					   physical, mirror_num, logical,
-					   length, stripe);
+	ret = scrub_find_fill_first_stripe(bg, &sctx->extent_path,
+			&sctx->csum_path, dev, physical, mirror_num, logical,
+			length, stripe);
 	/* Either >0 as no more extents or <0 for error. */
 	if (ret)
 		return ret;
@@ -1786,6 +1790,7 @@ static int scrub_raid56_parity_stripe(struct scrub_ctx *sctx,
 	struct btrfs_raid_bio *rbio;
 	struct btrfs_io_context *bioc = NULL;
 	struct btrfs_path extent_path = { 0 };
+	struct btrfs_path csum_path = { 0 };
 	struct bio *bio;
 	struct scrub_stripe *stripe;
 	bool all_empty = true;
@@ -1797,12 +1802,14 @@ static int scrub_raid56_parity_stripe(struct scrub_ctx *sctx,
 	ASSERT(sctx->raid56_data_stripes);
 
 	/*
-	 * For data stripe search, we can not re-use the same extent path, as
-	 * the data stripe bytenr may be smaller than previous extent.
-	 * Thus we have to use our own extent path.
+	 * For data stripe search, we can not re-use the same extent/csum paths,
+	 * as the data stripe bytenr may be smaller than previous extent.
+	 * Thus we have to use our own extent/csum paths.
 	 */
 	extent_path.search_commit_root = 1;
 	extent_path.skip_locking = 1;
+	csum_path.search_commit_root = 1;
+	csum_path.skip_locking = 1;
 
 	for (int i = 0; i < data_stripes; i++) {
 		int stripe_index;
@@ -1818,7 +1825,7 @@ static int scrub_raid56_parity_stripe(struct scrub_ctx *sctx,
 
 		scrub_reset_stripe(stripe);
 		set_bit(SCRUB_STRIPE_FLAG_NO_REPORT, &stripe->state);
-		ret = scrub_find_fill_first_stripe(bg, &extent_path,
+		ret = scrub_find_fill_first_stripe(bg, &extent_path, &csum_path,
 				map->stripes[stripe_index].dev, physical, 1,
 				full_stripe_start + btrfs_stripe_nr_to_offset(i),
 				BTRFS_STRIPE_LEN, stripe);
@@ -1947,6 +1954,7 @@ static int scrub_raid56_parity_stripe(struct scrub_ctx *sctx,
 	btrfs_bio_counter_dec(fs_info);
 
 	btrfs_release_path(&extent_path);
+	btrfs_release_path(&csum_path);
 out:
 	return ret;
 }
@@ -2236,6 +2244,7 @@ static noinline_for_stack int scrub_stripe(struct scrub_ctx *sctx,
 	if (!ret)
 		ret = ret2;
 	btrfs_release_path(&sctx->extent_path);
+	btrfs_release_path(&sctx->csum_path);
 
 	if (sctx->raid56_data_stripes) {
 		for (int i = 0; i < nr_data_stripes(map); i++)
-- 
2.41.0

