Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43BB275AC55
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Jul 2023 12:48:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230521AbjGTKst (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 20 Jul 2023 06:48:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231207AbjGTKsm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 20 Jul 2023 06:48:42 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B2C71982
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Jul 2023 03:48:37 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 4C6EC20685
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Jul 2023 10:48:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1689850116; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=O+hkTnEFWJXRm8RA6hHepTutFMd26Z0baRk941a6BDk=;
        b=LU6A2DQrm/UPuB+aaYt90Pr7LXa7WU51IcDSemyOYpCg4AaFQD4IV5Wnh4FDtgi6SVAJz+
        ubuD0ALQFxLjDyqQtuDaaUEFVr0TfnN3W8eMuD0ePwFDgipMFH7lT9ckmBbTSMFa0w7ez+
        Hdlk1dYJP8damwA6mQI4BedcsT+fX7o=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 95573133DD
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Jul 2023 10:48:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id cB7dFgMRuWQBcQAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Jul 2023 10:48:35 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 2/5] btrfs: scrub: avoid unnecessary csum tree search preparing stripes
Date:   Thu, 20 Jul 2023 18:48:12 +0800
Message-ID: <f216b00b74f232105d3eb54f850b719ccf2bf6de.1689849582.git.wqu@suse.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1689849582.git.wqu@suse.com>
References: <cover.1689849582.git.wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
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

With this update, we can regain the scrub performance to 2.5 GiB/s on a
PCIE3 NVME device with large files (the worst case for the new scrub
code).

The improvement is mostly on the queue depth, now it's almost 4 times
the original depth compared to the introduce of stripe based scrub:

Device         r/s      rkB/s   rrqm/s  %rrqm r_await rareq-sz aqu-sz  %util
nvme0n1p3  5346.00 2642288.00 36075.00  87.09    0.75   494.26   4.00 100.00

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
index 2b6888ff4a50..5f8c95290e60 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -190,6 +190,7 @@ struct scrub_ctx {
 	struct scrub_stripe	*raid56_data_stripes;
 	struct btrfs_fs_info	*fs_info;
 	struct btrfs_path	extent_path;
+	struct btrfs_path	csum_path;
 	int			first_free;
 	int			cur_stripe;
 	atomic_t		cancel_req;
@@ -356,6 +357,8 @@ static noinline_for_stack struct scrub_ctx *scrub_setup_ctx(
 	sctx->fs_info = fs_info;
 	sctx->extent_path.search_commit_root = 1;
 	sctx->extent_path.skip_locking = 1;
+	sctx->csum_path.search_commit_root = 1;
+	sctx->csum_path.skip_locking = 1;
 	for (i = 0; i < SCRUB_STRIPES_PER_SCTX; i++) {
 		int ret;
 
@@ -1484,6 +1487,7 @@ static void scrub_stripe_reset_bitmaps(struct scrub_stripe *stripe)
  */
 static int scrub_find_fill_first_stripe(struct btrfs_block_group *bg,
 					struct btrfs_path *extent_path,
+					struct btrfs_path *csum_path,
 					struct btrfs_device *dev, u64 physical,
 					int mirror_num, u64 logical_start,
 					u32 logical_len,
@@ -1575,9 +1579,9 @@ static int scrub_find_fill_first_stripe(struct btrfs_block_group *bg,
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
@@ -1785,9 +1789,9 @@ static int queue_scrub_stripe(struct scrub_ctx *sctx, struct btrfs_block_group *
 	ASSERT(sctx->cur_stripe < SCRUB_STRIPES_PER_SCTX);
 	stripe = &sctx->stripes[sctx->cur_stripe];
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
@@ -1828,6 +1832,7 @@ static int scrub_raid56_parity_stripe(struct scrub_ctx *sctx,
 	struct btrfs_raid_bio *rbio;
 	struct btrfs_io_context *bioc = NULL;
 	struct btrfs_path extent_path = { 0 };
+	struct btrfs_path csum_path = { 0 };
 	struct bio *bio;
 	struct scrub_stripe *stripe;
 	bool all_empty = true;
@@ -1839,12 +1844,14 @@ static int scrub_raid56_parity_stripe(struct scrub_ctx *sctx,
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
@@ -1860,7 +1867,7 @@ static int scrub_raid56_parity_stripe(struct scrub_ctx *sctx,
 
 		scrub_reset_stripe(stripe);
 		set_bit(SCRUB_STRIPE_FLAG_NO_REPORT, &stripe->state);
-		ret = scrub_find_fill_first_stripe(bg, &extent_path,
+		ret = scrub_find_fill_first_stripe(bg, &extent_path, &csum_path,
 				map->stripes[stripe_index].dev, physical, 1,
 				full_stripe_start + btrfs_stripe_nr_to_offset(i),
 				BTRFS_STRIPE_LEN, stripe);
@@ -1989,6 +1996,7 @@ static int scrub_raid56_parity_stripe(struct scrub_ctx *sctx,
 	btrfs_bio_counter_dec(fs_info);
 
 	btrfs_release_path(&extent_path);
+	btrfs_release_path(&csum_path);
 out:
 	return ret;
 }
@@ -2277,6 +2285,7 @@ static noinline_for_stack int scrub_stripe(struct scrub_ctx *sctx,
 	if (!ret)
 		ret = ret2;
 	btrfs_release_path(&sctx->extent_path);
+	btrfs_release_path(&sctx->csum_path);
 
 	if (sctx->raid56_data_stripes) {
 		for (int i = 0; i < nr_data_stripes(map); i++)
-- 
2.41.0

