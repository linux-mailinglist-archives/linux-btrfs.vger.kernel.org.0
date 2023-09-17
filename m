Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ADC77A3516
	for <lists+linux-btrfs@lfdr.de>; Sun, 17 Sep 2023 12:07:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbjIQKGu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 17 Sep 2023 06:06:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237024AbjIQKGs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 17 Sep 2023 06:06:48 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78C2D18F
        for <linux-btrfs@vger.kernel.org>; Sun, 17 Sep 2023 03:06:42 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 9CAD31F381
        for <linux-btrfs@vger.kernel.org>; Sun, 17 Sep 2023 10:06:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1694945200; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=6HhczCc6RXrdy7wOPwxhOQoX+FS22LXr/VdusHee09I=;
        b=rNgBO7jv9TzDUowEwu1xgWYkRAV4/CCacNb1xJmcgBkWjVwd4JC3VxmqlUfD90OfKIkPFG
        fEDq939oKBIWsuPrBGPaFrWEKrR7G+mamtPrHuqzlk9COHcmJKxkexO/tEYR2WZBVeNRZV
        uWNvwronDgFIarOK3AJxh7HZVu6tABg=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CE559134B2
        for <linux-btrfs@vger.kernel.org>; Sun, 17 Sep 2023 10:06:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id tQwFI6/PBmW5EQAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Sun, 17 Sep 2023 10:06:39 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: remove the need_raid_map parameter from btrfs_map_block()
Date:   Sun, 17 Sep 2023 19:36:21 +0930
Message-ID: <d62c0ce7de28645ae2a416153c67b4146ae36ba0.1694945159.git.wqu@suse.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The parameter @need_raid_map is mostly a legacy from the old days where
we don't yet have a solid definition on the @mirror_num, and only
check-integrity is still using that parameter, while all other call sites
just pass 1 for that parameter.

Now since we have removed check-integrity functionality, we can also
remove the @need_raid_map parameter.

This change would also remove the ability to read P/Q stripe directly
when passing 0 as @need_raid_map.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/bio.c     |  2 +-
 fs/btrfs/scrub.c   |  4 ++--
 fs/btrfs/volumes.c | 26 +++++++++-----------------
 fs/btrfs/volumes.h |  3 +--
 fs/btrfs/zoned.c   |  2 +-
 5 files changed, 14 insertions(+), 23 deletions(-)

diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
index 31ff36990404..964714258f86 100644
--- a/fs/btrfs/bio.c
+++ b/fs/btrfs/bio.c
@@ -656,7 +656,7 @@ static bool btrfs_submit_chunk(struct btrfs_bio *bbio, int mirror_num)
 
 	btrfs_bio_counter_inc_blocked(fs_info);
 	error = btrfs_map_block(fs_info, btrfs_op(bio), logical, &map_length,
-				&bioc, &smap, &mirror_num, 1);
+				&bioc, &smap, &mirror_num);
 	if (error) {
 		ret = errno_to_blk_status(error);
 		goto fail;
diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index f16220ce5fba..7bcab3899ae6 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -896,7 +896,7 @@ static void scrub_stripe_report_errors(struct scrub_ctx *sctx,
 		ASSERT(stripe->mirror_num >= 1);
 		ret = btrfs_map_block(fs_info, BTRFS_MAP_GET_READ_MIRRORS,
 				      stripe->logical, &mapped_len, &bioc,
-				      NULL, NULL, 1);
+				      NULL, NULL);
 		/*
 		 * If we failed, dev will be NULL, and later detailed reports
 		 * will just be skipped.
@@ -1951,7 +1951,7 @@ static int scrub_raid56_parity_stripe(struct scrub_ctx *sctx,
 
 	btrfs_bio_counter_inc_blocked(fs_info);
 	ret = btrfs_map_block(fs_info, BTRFS_MAP_WRITE, full_stripe_start,
-			      &length, &bioc, NULL, NULL, 1);
+			      &length, &bioc, NULL, NULL);
 	if (ret < 0) {
 		btrfs_put_bioc(bioc);
 		btrfs_bio_counter_dec(fs_info);
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 2f05d38980ce..4192f4c75276 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -6271,16 +6271,11 @@ static void set_io_stripe(struct btrfs_io_stripe *dst, const struct map_lookup *
  *			For RAID6 profile, mirror > 2 means mark another
  *			data/P stripe error and rebuild from the remaining
  *			stripes..
- *
- * @need_raid_map:	(Used only for integrity checker) whether the map wants
- *                      a full stripe map (including all data and P/Q stripes)
- *                      for RAID56. Should always be 1 except integrity checker.
  */
 int btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
 		    u64 logical, u64 *length,
 		    struct btrfs_io_context **bioc_ret,
-		    struct btrfs_io_stripe *smap, int *mirror_num_ret,
-		    int need_raid_map)
+		    struct btrfs_io_stripe *smap, int *mirror_num_ret)
 {
 	struct extent_map *em;
 	struct map_lookup *map;
@@ -6375,8 +6370,10 @@ int btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
 		}
 
 	} else if (map->type & BTRFS_BLOCK_GROUP_RAID56_MASK) {
-		if (need_raid_map && (op != BTRFS_MAP_READ || mirror_num > 1)) {
+		if (op != BTRFS_MAP_READ || mirror_num > 1) {
 			/*
+			 * Need full stripe mapping.
+			 *
 			 * Push stripe_nr back to the start of the full stripe
 			 * For those cases needing a full stripe, @stripe_nr
 			 * is the full stripe number.
@@ -6399,19 +6396,14 @@ int btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
 			stripe_index = 0;
 			stripe_offset = 0;
 		} else {
-			/*
-			 * Mirror #0 or #1 means the original data block.
-			 * Mirror #2 is RAID5 parity block.
-			 * Mirror #3 is RAID6 Q block.
-			 */
+			ASSERT(mirror_num <= 1);
+			/* Just grab the data stripe directly. */
 			stripe_index = stripe_nr % data_stripes;
 			stripe_nr /= data_stripes;
-			if (mirror_num > 1)
-				stripe_index = data_stripes + mirror_num - 2;
 
 			/* We distribute the parity blocks across stripes */
 			stripe_index = (stripe_nr + stripe_index) % map->num_stripes;
-			if (op == BTRFS_MAP_READ && mirror_num <= 1)
+			if (op == BTRFS_MAP_READ && mirror_num < 1)
 				mirror_num = 1;
 		}
 	} else {
@@ -6473,7 +6465,7 @@ int btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
 	 *
 	 * It's still mostly the same as other profiles, just with extra rotation.
 	 */
-	if (map->type & BTRFS_BLOCK_GROUP_RAID56_MASK && need_raid_map &&
+	if (map->type & BTRFS_BLOCK_GROUP_RAID56_MASK &&
 	    (op != BTRFS_MAP_READ || mirror_num > 1)) {
 		/*
 		 * For RAID56 @stripe_nr is already the number of full stripes
@@ -8102,7 +8094,7 @@ int btrfs_map_repair_block(struct btrfs_fs_info *fs_info,
 	ASSERT(mirror_num > 0);
 
 	ret = btrfs_map_block(fs_info, BTRFS_MAP_WRITE, logical, &map_length,
-			      &bioc, smap, &mirror_ret, true);
+			      &bioc, smap, &mirror_ret);
 	if (ret < 0)
 		return ret;
 
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index b513b2846793..0704c64cea1d 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -605,8 +605,7 @@ void btrfs_put_bioc(struct btrfs_io_context *bioc);
 int btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
 		    u64 logical, u64 *length,
 		    struct btrfs_io_context **bioc_ret,
-		    struct btrfs_io_stripe *smap, int *mirror_num_ret,
-		    int need_raid_map);
+		    struct btrfs_io_stripe *smap, int *mirror_num_ret);
 int btrfs_map_repair_block(struct btrfs_fs_info *fs_info,
 			   struct btrfs_io_stripe *smap, u64 logical,
 			   u32 length, int mirror_num);
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index d05510cb2cb2..0992ad6ee764 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -1890,7 +1890,7 @@ static int read_zone_info(struct btrfs_fs_info *fs_info, u64 logical,
 	int i, ret;
 
 	ret = btrfs_map_block(fs_info, BTRFS_MAP_GET_READ_MIRRORS, logical,
-			      &mapped_length, &bioc, NULL, NULL, 1);
+			      &mapped_length, &bioc, NULL, NULL);
 	if (ret || !bioc || mapped_length < PAGE_SIZE) {
 		ret = -EIO;
 		goto out_put_bioc;
-- 
2.42.0

