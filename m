Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFE7066B7B9
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Jan 2023 08:04:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231251AbjAPHEq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 16 Jan 2023 02:04:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231890AbjAPHEo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 16 Jan 2023 02:04:44 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48AF27EEB
        for <linux-btrfs@vger.kernel.org>; Sun, 15 Jan 2023 23:04:43 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 0ADE334F25
        for <linux-btrfs@vger.kernel.org>; Mon, 16 Jan 2023 07:04:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1673852682; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tJD+1mVmApycgVpSVf70xmZY9L42dt56M3fkgDPaGqY=;
        b=Bqmvz+lCn4XEik0R244S6gsvnxUKjKQv/auy/g+IbbzPguq1uOTimKIvWmj3mWFthn/Anv
        WQM1GjNV2gPTaZ+RB9e3e/t+6LNXF/5bmMJW5nwz8FIzwJQ5LPJPFR32VThu+8P4Wfa/wZ
        z3b8GgdD/gC0ldPjJdNwq9+MZ0RCMZU=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 66A8F138FA
        for <linux-btrfs@vger.kernel.org>; Mon, 16 Jan 2023 07:04:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id GNX2DAn3xGMfZwAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Mon, 16 Jan 2023 07:04:41 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 02/11] btrfs: remove @root and @csum_root arguments from scrub_simple_mirror()
Date:   Mon, 16 Jan 2023 15:04:13 +0800
Message-Id: <6f42e541530e6b887fa4c3503b43a0909064d59a.1673851704.git.wqu@suse.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <cover.1673851704.git.wqu@suse.com>
References: <cover.1673851704.git.wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Grabbing extent/csum root for extent tree v2 is not that a huge
workload, it's just a rb tree search.

Thus there is really not much need to pre-fetch it and pass it all the
way from scrub_stripe().

And we already have more than enough arguments in scrub_simple_mirror()
and scrub_simple_stripe(), it's better to remove them and only grab
those roots in scrub_simple_mirror().

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/scrub.c | 28 +++++++++-------------------
 1 file changed, 9 insertions(+), 19 deletions(-)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index e241e2a35bfd..288d7e2a6cdf 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -3410,8 +3410,6 @@ static int sync_write_pointer_for_zoned(struct scrub_ctx *sctx, u64 logical,
  * and @logical_length parameter.
  */
 static int scrub_simple_mirror(struct scrub_ctx *sctx,
-			       struct btrfs_root *extent_root,
-			       struct btrfs_root *csum_root,
 			       struct btrfs_block_group *bg,
 			       struct map_lookup *map,
 			       u64 logical_start, u64 logical_length,
@@ -3419,6 +3417,8 @@ static int scrub_simple_mirror(struct scrub_ctx *sctx,
 			       u64 physical, int mirror_num)
 {
 	struct btrfs_fs_info *fs_info = sctx->fs_info;
+	struct btrfs_root *csum_root = btrfs_csum_root(fs_info, bg->start);
+	struct btrfs_root *extent_root = btrfs_extent_root(fs_info, bg->start);
 	const u64 logical_end = logical_start + logical_length;
 	/* An artificial limit, inherit from old scrub behavior */
 	const u32 max_length = SZ_64K;
@@ -3567,8 +3567,6 @@ static int simple_stripe_mirror_num(struct map_lookup *map, int stripe_index)
 }
 
 static int scrub_simple_stripe(struct scrub_ctx *sctx,
-			       struct btrfs_root *extent_root,
-			       struct btrfs_root *csum_root,
 			       struct btrfs_block_group *bg,
 			       struct map_lookup *map,
 			       struct btrfs_device *device,
@@ -3588,9 +3586,9 @@ static int scrub_simple_stripe(struct scrub_ctx *sctx,
 		 * just RAID1, so we can reuse scrub_simple_mirror() to scrub
 		 * this stripe.
 		 */
-		ret = scrub_simple_mirror(sctx, extent_root, csum_root, bg, map,
-					  cur_logical, map->stripe_len, device,
-					  cur_physical, mirror_num);
+		ret = scrub_simple_mirror(sctx, bg, map, cur_logical,
+					  map->stripe_len, device, cur_physical,
+					  mirror_num);
 		if (ret)
 			return ret;
 		/* Skip to next stripe which belongs to the target device */
@@ -3608,8 +3606,6 @@ static noinline_for_stack int scrub_stripe(struct scrub_ctx *sctx,
 					   int stripe_index)
 {
 	struct btrfs_fs_info *fs_info = sctx->fs_info;
-	struct btrfs_root *root;
-	struct btrfs_root *csum_root;
 	struct blk_plug plug;
 	struct map_lookup *map = em->map_lookup;
 	const u64 profile = map->type & BTRFS_BLOCK_GROUP_PROFILE_MASK;
@@ -3632,9 +3628,6 @@ static noinline_for_stack int scrub_stripe(struct scrub_ctx *sctx,
 		   atomic_read(&sctx->bios_in_flight) == 0);
 	scrub_blocked_if_needed(fs_info);
 
-	root = btrfs_extent_root(fs_info, bg->start);
-	csum_root = btrfs_csum_root(fs_info, bg->start);
-
 	/*
 	 * collect all data csums for the stripe to avoid seeking during
 	 * the scrub. This might currently (crc32) end up to be about 1MB
@@ -3666,16 +3659,14 @@ static noinline_for_stack int scrub_stripe(struct scrub_ctx *sctx,
 		 * Only @physical and @mirror_num needs to calculated using
 		 * @stripe_index.
 		 */
-		ret = scrub_simple_mirror(sctx, root, csum_root, bg, map,
-				bg->start, bg->length, scrub_dev,
-				map->stripes[stripe_index].physical,
+		ret = scrub_simple_mirror(sctx, bg, map, bg->start, bg->length,
+				scrub_dev, map->stripes[stripe_index].physical,
 				stripe_index + 1);
 		offset = 0;
 		goto out;
 	}
 	if (profile & (BTRFS_BLOCK_GROUP_RAID0 | BTRFS_BLOCK_GROUP_RAID10)) {
-		ret = scrub_simple_stripe(sctx, root, csum_root, bg, map,
-					  scrub_dev, stripe_index);
+		ret = scrub_simple_stripe(sctx, bg, map, scrub_dev, stripe_index);
 		offset = map->stripe_len * (stripe_index / map->sub_stripes);
 		goto out;
 	}
@@ -3721,8 +3712,7 @@ static noinline_for_stack int scrub_stripe(struct scrub_ctx *sctx,
 		 * We can reuse scrub_simple_mirror() here, as the repair part
 		 * is still based on @mirror_num.
 		 */
-		ret = scrub_simple_mirror(sctx, root, csum_root, bg, map,
-					  logical, map->stripe_len,
+		ret = scrub_simple_mirror(sctx, bg, map, logical, map->stripe_len,
 					  scrub_dev, physical, 1);
 		if (ret < 0)
 			goto out;
-- 
2.39.0

