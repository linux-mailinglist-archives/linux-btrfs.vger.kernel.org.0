Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3886733E27
	for <lists+linux-btrfs@lfdr.de>; Sat, 17 Jun 2023 07:08:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232739AbjFQFH4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 17 Jun 2023 01:07:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232520AbjFQFHv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 17 Jun 2023 01:07:51 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 802B11FD5
        for <linux-btrfs@vger.kernel.org>; Fri, 16 Jun 2023 22:07:50 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 29BC021A86
        for <linux-btrfs@vger.kernel.org>; Sat, 17 Jun 2023 05:07:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1686978469; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YCidarLaw0PJF3mO3i+adQ9EbVpb+VpN/cKKpMDUyhY=;
        b=JlUvwTYmeLyCFvMz3ABTVQwmnhN6cg1EzaOFwTcxzpGtyLFC5XeNKp9Ima14sTtKmS19u1
        cjoDBNm8E5/jUH92VVWCngwuAVZTrHOaPX0JrFcOhmTiJloDais+6/sP6ql/Jz4fe2IH2W
        2nNGephTZ8B5x3qufshGA/o1CPXSJoM=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 92BC813915
        for <linux-btrfs@vger.kernel.org>; Sat, 17 Jun 2023 05:07:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id sOYdGaQ/jWTFEgAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Sat, 17 Jun 2023 05:07:48 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH RFC 4/5] btrfs: scrub: implement the basic extent iteration code
Date:   Sat, 17 Jun 2023 13:07:25 +0800
Message-ID: <19112293cb4c76cb407e70a29e05701cbba7e0a8.1686977659.git.wqu@suse.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1686977659.git.wqu@suse.com>
References: <cover.1686977659.git.wqu@suse.com>
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

Unlike the per-device scrub code, logical bytenr based scrub code is
much easier iterating the extents.

The difference is mainly in the stripe queueing part, as we need to
queue @nr_copies stripes at once.

So here we introduce a helper, scrub_copy_stripe(), and fill the first
stripe, then use that helper to fill the remaining copies.

For now, we still use the same flush_scrub_stripes(), but the repair
part is less efficient.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/scrub.c | 163 ++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 160 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index aa68cda5226f..2500737adff1 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -1465,7 +1465,7 @@ static void scrub_stripe_reset_bitmaps(struct scrub_stripe *stripe)
 static int scrub_find_fill_first_stripe(struct btrfs_block_group *bg,
 					struct btrfs_device *dev, u64 physical,
 					int mirror_num, u64 logical_start,
-					u32 logical_len,
+					u64 logical_len,
 					struct scrub_stripe *stripe)
 {
 	struct btrfs_fs_info *fs_info = bg->fs_info;
@@ -2988,6 +2988,164 @@ int btrfs_scrub_dev(struct btrfs_fs_info *fs_info, u64 devid, u64 start,
 	return ret;
 }
 
+static void scrub_copy_stripe(const struct scrub_stripe *src,
+			      struct scrub_stripe *dst)
+{
+	struct scrub_ctx *sctx = src->sctx;
+	struct btrfs_fs_info *fs_info = sctx->fs_info;
+
+	/* This function should only be called for logical scrub. */
+	ASSERT(sctx->scrub_logical);
+	scrub_reset_stripe(dst);
+
+	dst->bg = src->bg;
+	dst->dev = NULL;
+	dst->physical = 0;
+	dst->logical = src->logical;
+	dst->mirror_num = src->mirror_num;
+
+	bitmap_copy(&dst->extent_sector_bitmap, &src->extent_sector_bitmap,
+		    src->nr_sectors);
+	memcpy(dst->csums, src->csums,
+	       (BTRFS_STRIPE_LEN >> fs_info->sectorsize_bits) *
+		fs_info->csum_size);
+
+	for (int i = 0; i < src->nr_sectors; i++) {
+		dst->sectors[i].is_metadata = src->sectors[i].is_metadata;
+		if (src->sectors[i].is_metadata)
+			dst->sectors[i].generation = src->sectors[i].generation;
+		else if (src->sectors[i].csum)
+			dst->sectors[i].csum = dst->csums + i * fs_info->csum_size;
+	}
+	dst->nr_data_extents = src->nr_data_extents;
+	dst->nr_meta_extents = src->nr_meta_extents;
+	set_bit(SCRUB_STRIPE_FLAG_INITIALIZED, &dst->state);
+}
+
+/*
+ * Unlike queue_scrub_stripe() which only queue one stripe, this queue all
+ * mirrors for non-RAID56 profiles, or the full stripe for RAID56.
+ */
+static int queue_scrub_logical_stripes(struct scrub_ctx *sctx,
+			struct btrfs_block_group *bg, u64 logical)
+{
+	const int raid_index = btrfs_bg_flags_to_raid_index(bg->flags);
+	const int nr_copies = btrfs_raid_array[raid_index].ncopies;
+	const int old_cur = sctx->cur_stripe;
+	struct scrub_stripe *stripe;
+	int ret;
+
+	ASSERT(sctx->stripes);
+	ASSERT(sctx->nr_stripes);
+
+	if (sctx->cur_stripe + nr_copies > sctx->nr_stripes) {
+		ret = flush_scrub_stripes(sctx);
+		if (ret < 0)
+			return ret;
+	}
+
+	stripe = &sctx->stripes[old_cur];
+
+	scrub_reset_stripe(stripe);
+	ret = scrub_find_fill_first_stripe(bg, NULL, 0, 1,
+			logical, bg->start + bg->length - logical, stripe);
+	/* Either >0 as no more extents or <0 for error. */
+	if (ret)
+		return ret;
+
+	/* For the remaining slots, just copy the above mirror. */
+	for (int i = 1; i < nr_copies; i++) {
+		struct scrub_stripe *dst = &sctx->stripes[old_cur + i];
+
+		scrub_copy_stripe(stripe, dst);
+		dst->mirror_num = i + 1;
+	}
+	sctx->cur_stripe += nr_copies;
+	return 0;
+}
+
+static int scrub_logical_one_chunk(struct scrub_ctx *sctx,
+				   struct btrfs_block_group *bg)
+{
+	struct btrfs_fs_info *fs_info = sctx->fs_info;
+	struct extent_map_tree *map_tree = &fs_info->mapping_tree;
+	struct extent_map *em;
+	u64 cur = bg->start;
+	const int raid_index = btrfs_bg_flags_to_raid_index(bg->flags);
+	const int nr_copies = btrfs_raid_array[raid_index].ncopies;
+	int nr_stripes;
+	int ret = 0;
+	int flush_ret;
+
+	read_lock(&map_tree->lock);
+	em = lookup_extent_mapping(map_tree, bg->start, bg->length);
+	read_unlock(&map_tree->lock);
+	if (!em) {
+		/*
+		 * Might have been an unused block group deleted by the cleaner
+		 * kthread or relocation.
+		 */
+		spin_lock(&bg->lock);
+		if (!test_bit(BLOCK_GROUP_FLAG_REMOVED, &bg->runtime_flags))
+			ret = -EINVAL;
+		spin_unlock(&bg->lock);
+		return ret;
+	}
+
+	scrub_blocked_if_needed(fs_info);
+
+	/* RAID56 not yet supported. */
+	if (bg->flags & BTRFS_BLOCK_GROUP_RAID56_MASK) {
+		ret = -EOPNOTSUPP;
+		goto out;
+	}
+
+	nr_stripes = SCRUB_STRIPES_PER_SCTX * nr_copies;
+	ret = alloc_scrub_stripes(sctx, nr_stripes);
+	if (ret < 0)
+		goto out;
+
+	while (cur < bg->start + bg->length) {
+		/* Canceled? */
+		if (atomic_read(&fs_info->scrub_cancel_req) ||
+		    atomic_read(&sctx->cancel_req)) {
+			ret = -ECANCELED;
+			break;
+		}
+		/* Paused? */
+		if (atomic_read(&fs_info->scrub_pause_req)) {
+			/* Push queued extents */
+			scrub_blocked_if_needed(fs_info);
+		}
+		/* Block group removed? */
+		spin_lock(&bg->lock);
+		if (test_bit(BLOCK_GROUP_FLAG_REMOVED, &bg->runtime_flags)) {
+			spin_unlock(&bg->lock);
+			ret = 0;
+			break;
+		}
+		spin_unlock(&bg->lock);
+
+		ret = queue_scrub_logical_stripes(sctx, bg, cur);
+		if (ret > 0) {
+			ret = 0;
+			break;
+		}
+		if (ret < 0)
+			break;
+		ASSERT(sctx->cur_stripe >= 1);
+		cur = sctx->stripes[sctx->cur_stripe - 1].logical + BTRFS_STRIPE_LEN;
+	}
+out:
+	flush_ret = flush_scrub_stripes(sctx);
+	if (!ret)
+		ret = flush_ret;
+	free_scrub_stripes(sctx);
+	free_extent_map(em);
+	return ret;
+
+}
+
 static int scrub_logical_chunks(struct scrub_ctx *sctx, u64 start, u64 end)
 {
 	struct btrfs_fs_info *fs_info = sctx->fs_info;
@@ -3018,8 +3176,7 @@ static int scrub_logical_chunks(struct scrub_ctx *sctx, u64 start, u64 end)
 			break;
 		}
 
-		/* The real work starts here. */
-		ret = -EOPNOTSUPP;
+		ret = scrub_logical_one_chunk(sctx, bg);
 
 		if (ro_set)
 			btrfs_dec_block_group_ro(bg);
-- 
2.41.0

