Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C73624D5C87
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Mar 2022 08:39:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347233AbiCKHkT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 11 Mar 2022 02:40:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347227AbiCKHkQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 11 Mar 2022 02:40:16 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B2CF59386
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Mar 2022 23:39:14 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id DEDBC210FB
        for <linux-btrfs@vger.kernel.org>; Fri, 11 Mar 2022 07:39:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1646984352; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ToTySToHoR8Alm8850+iQHrh4/dcFDL+9rt3XVSgucs=;
        b=IY/485qcGxAP8CjAHCAiFpZgOfRD9sKDzylv9lXCDj5NTUjVmaxhCmZjctacFtXxTJ/XDR
        bZ6uuR6iV/kCpj6iXvIGOifCGPMNnTe103hGLOxaO78BJXZ1sf0Jy3mJMON9WRiqNd3FZr
        iY1L5lL/2tdYrKpXXOmnRmUeHrCNHUI=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 406D113A82
        for <linux-btrfs@vger.kernel.org>; Fri, 11 Mar 2022 07:39:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id COhSA6D8KmKkJgAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Fri, 11 Mar 2022 07:39:12 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v4 5/9] btrfs: scrub: cleanup the non-RAID56 branches in scrub_stripe()
Date:   Fri, 11 Mar 2022 15:38:45 +0800
Message-Id: <66cca5a810d76c685afc8b6f29b44cac1bfb79ad.1646984153.git.wqu@suse.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1646984153.git.wqu@suse.com>
References: <cover.1646984153.git.wqu@suse.com>
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

Since we have moved all other profiles handling into their own
functions, now the main body of scrub_stripe() is just handling RAID56
profiles.

There is no need to address other profiles in the main loop of
scrub_stripe(), so we can remove those dead branches.

Since we're here, also slightly change the timing of initialization of
variables like @offset, @increment and @logical.

Especially for @logical, we don't really need to initialize it for
btrfs_extent_root()/btrfs_csum_root(), we can use bg->start for that
purpose.

Now those variables are only initialize for RAID56 branches.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/scrub.c | 128 +++++++++++++++++++----------------------------
 1 file changed, 51 insertions(+), 77 deletions(-)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 04445ffd83c8..ddfbca03791b 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -3527,14 +3527,12 @@ static noinline_for_stack int scrub_stripe(struct scrub_ctx *sctx,
 	u64 flags;
 	int ret;
 	int slot;
-	u64 nstripes;
 	struct extent_buffer *l;
 	u64 physical = map->stripes[stripe_index].physical;
 	u64 logical;
 	u64 logic_end;
 	const u64 physical_end = physical + dev_extent_len;
 	u64 generation;
-	int mirror_num;
 	struct btrfs_key key;
 	u64 increment;
 	u64 offset;
@@ -3551,28 +3549,6 @@ static noinline_for_stack int scrub_stripe(struct scrub_ctx *sctx,
 	int extent_mirror_num;
 	int stop_loop = 0;
 
-	offset = 0;
-	nstripes = div64_u64(dev_extent_len, map->stripe_len);
-	mirror_num = 1;
-	increment = map->stripe_len;
-	if (map->type & BTRFS_BLOCK_GROUP_RAID0) {
-		offset = map->stripe_len * stripe_index;
-		increment = map->stripe_len * map->num_stripes;
-	} else if (map->type & BTRFS_BLOCK_GROUP_RAID10) {
-		int factor = map->num_stripes / map->sub_stripes;
-		offset = map->stripe_len * (stripe_index / map->sub_stripes);
-		increment = map->stripe_len * factor;
-		mirror_num = stripe_index % map->sub_stripes + 1;
-	} else if (map->type & BTRFS_BLOCK_GROUP_RAID1_MASK) {
-		mirror_num = stripe_index % map->num_stripes + 1;
-	} else if (map->type & BTRFS_BLOCK_GROUP_DUP) {
-		mirror_num = stripe_index % map->num_stripes + 1;
-	} else if (map->type & BTRFS_BLOCK_GROUP_RAID56_MASK) {
-		get_raid56_logic_offset(physical, stripe_index, map, &offset,
-					NULL);
-		increment = map->stripe_len * nr_data_stripes(map);
-	}
-
 	path = btrfs_alloc_path();
 	if (!path)
 		return -ENOMEM;
@@ -3586,20 +3562,12 @@ static noinline_for_stack int scrub_stripe(struct scrub_ctx *sctx,
 	path->skip_locking = 1;
 	path->reada = READA_FORWARD;
 
-	logical = chunk_logical + offset;
-	if (map->type & BTRFS_BLOCK_GROUP_RAID56_MASK) {
-		get_raid56_logic_offset(physical_end, stripe_index,
-					map, &logic_end, NULL);
-		logic_end += chunk_logical;
-	} else {
-		logic_end = logical + increment * nstripes;
-	}
 	wait_event(sctx->list_wait,
 		   atomic_read(&sctx->bios_in_flight) == 0);
 	scrub_blocked_if_needed(fs_info);
 
-	root = btrfs_extent_root(fs_info, logical);
-	csum_root = btrfs_csum_root(fs_info, logical);
+	root = btrfs_extent_root(fs_info, bg->start);
+	csum_root = btrfs_csum_root(fs_info, bg->start);
 
 	/*
 	 * collect all data csums for the stripe to avoid seeking during
@@ -3636,17 +3604,29 @@ static noinline_for_stack int scrub_stripe(struct scrub_ctx *sctx,
 				bg->start, bg->length, scrub_dev,
 				map->stripes[stripe_index].physical,
 				stripe_index + 1);
+		offset = 0;
 		goto out;
 	}
 	if (profile & (BTRFS_BLOCK_GROUP_RAID0 | BTRFS_BLOCK_GROUP_RAID10)) {
 		ret = scrub_simple_stripe(sctx, root, csum_root, bg, map,
 					  scrub_dev, stripe_index);
+		offset = map->stripe_len * (stripe_index / map->sub_stripes);
 		goto out;
 	}
 
 	/* Only RAID56 goes through the old code */
 	ASSERT(map->type & BTRFS_BLOCK_GROUP_RAID56_MASK);
 	ret = 0;
+
+	/* Calculate the logical end of the stripe */
+	get_raid56_logic_offset(physical_end, stripe_index,
+				map, &logic_end, NULL);
+	logic_end += chunk_logical;
+
+	/* Initialize @offset in case we need to go to out: label */
+	get_raid56_logic_offset(physical, stripe_index, map, &offset, NULL);
+	increment = map->stripe_len * nr_data_stripes(map);
+
 	while (physical < physical_end) {
 		/*
 		 * canceled?
@@ -3672,22 +3652,20 @@ static noinline_for_stack int scrub_stripe(struct scrub_ctx *sctx,
 			scrub_blocked_if_needed(fs_info);
 		}
 
-		if (map->type & BTRFS_BLOCK_GROUP_RAID56_MASK) {
-			ret = get_raid56_logic_offset(physical, stripe_index,
-						      map, &logical,
-						      &stripe_logical);
-			logical += chunk_logical;
-			if (ret) {
-				/* it is parity strip */
-				stripe_logical += chunk_logical;
-				stripe_end = stripe_logical + increment;
-				ret = scrub_raid56_parity(sctx, map, scrub_dev,
-							  stripe_logical,
-							  stripe_end);
-				if (ret)
-					goto out;
-				goto skip;
-			}
+		ret = get_raid56_logic_offset(physical, stripe_index,
+					      map, &logical,
+					      &stripe_logical);
+		logical += chunk_logical;
+		if (ret) {
+			/* it is parity strip */
+			stripe_logical += chunk_logical;
+			stripe_end = stripe_logical + increment;
+			ret = scrub_raid56_parity(sctx, map, scrub_dev,
+						  stripe_logical,
+						  stripe_end);
+			if (ret)
+				goto out;
+			goto skip;
 		}
 
 		if (btrfs_fs_incompat(fs_info, SKINNY_METADATA))
@@ -3805,7 +3783,8 @@ static noinline_for_stack int scrub_stripe(struct scrub_ctx *sctx,
 
 			extent_physical = extent_logical - logical + physical;
 			extent_dev = scrub_dev;
-			extent_mirror_num = mirror_num;
+			/* For RAID56 data stripes, mirror_num is fixed to 1 */
+			extent_mirror_num = 1;
 			if (sctx->is_dev_replace)
 				scrub_remap_extent(fs_info, extent_logical,
 						   extent_len, &extent_physical,
@@ -3836,33 +3815,28 @@ static noinline_for_stack int scrub_stripe(struct scrub_ctx *sctx,
 
 			if (extent_logical + extent_len <
 			    key.objectid + bytes) {
-				if (map->type & BTRFS_BLOCK_GROUP_RAID56_MASK) {
-					/*
-					 * loop until we find next data stripe
-					 * or we have finished all stripes.
-					 */
+				/*
+				 * loop until we find next data stripe
+				 * or we have finished all stripes.
+				 */
 loop:
-					physical += map->stripe_len;
-					ret = get_raid56_logic_offset(physical,
-							stripe_index, map,
-							&logical, &stripe_logical);
-					logical += chunk_logical;
-
-					if (ret && physical < physical_end) {
-						stripe_logical += chunk_logical;
-						stripe_end = stripe_logical +
-								increment;
-						ret = scrub_raid56_parity(sctx,
-							map, scrub_dev,
-							stripe_logical,
-							stripe_end);
-						if (ret)
-							goto out;
-						goto loop;
-					}
-				} else {
-					physical += map->stripe_len;
-					logical += increment;
+				physical += map->stripe_len;
+				ret = get_raid56_logic_offset(physical,
+						stripe_index, map,
+						&logical, &stripe_logical);
+				logical += chunk_logical;
+
+				if (ret && physical < physical_end) {
+					stripe_logical += chunk_logical;
+					stripe_end = stripe_logical +
+							increment;
+					ret = scrub_raid56_parity(sctx,
+						map, scrub_dev,
+						stripe_logical,
+						stripe_end);
+					if (ret)
+						goto out;
+					goto loop;
 				}
 				if (logical < key.objectid + bytes) {
 					cond_resched();
-- 
2.35.1

