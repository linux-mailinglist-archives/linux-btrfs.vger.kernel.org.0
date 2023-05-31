Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E1D7717506
	for <lists+linux-btrfs@lfdr.de>; Wed, 31 May 2023 06:18:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234210AbjEaESH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 31 May 2023 00:18:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233828AbjEaESF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 31 May 2023 00:18:05 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45D65BE
        for <linux-btrfs@vger.kernel.org>; Tue, 30 May 2023 21:18:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=i1rh7V/iayO3mizu1CCiCwMEqFdNP6bV8SU/UeT5HTg=; b=mThSe0WZ4MwJgL8vWBVf8RYTxP
        pxl2bE+MG8oSxoOLZevfORV2QPONt5nnEcBRewbknUeI3PR8Ay8gI7q0TQq2DRzXFgu+KnMI5wLS3
        tWVVKX7Pb8oDkF203qWoLelBGFH5DeinffMVoNFijzJTAYZVIj2/9spDSILtQdOeN68Ppa4R+9xl1
        Q3FgByeUMkgxyWCb8jUOsmzV5RZV0dJalQSI/LBH7A5V9c1BW9SgchMUDKCsJHbhwUJYA0wMjhljD
        eHZm3uKfBsjJvOSwfMLtSjUAKR89Mlhz+qwWQnDMHe7AQ+j5w7GMZBFL0aQMPwBJ4F0lTWzo2icfn
        AgDPaZ5A==;
Received: from [2001:4bb8:182:6d06:f5c3:53d7:b5aa:b6a7] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q4DHb-00G1Rb-29;
        Wed, 31 May 2023 04:18:00 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: [PATCH 6/6] btrfs: remove need_full_stripe
Date:   Wed, 31 May 2023 06:17:39 +0200
Message-Id: <20230531041740.375963-7-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230531041740.375963-1-hch@lst.de>
References: <20230531041740.375963-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

need_full_stripe is just a somewhat complicated way to say
"op != BTRFS_MAP_READ".  Just spell that explicit check out, which makes
a lot of the code currently using the helper easier to understand.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/volumes.c | 29 ++++++++++++-----------------
 1 file changed, 12 insertions(+), 17 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 6141a9fe5a28a0..8137c04f31c9cd 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -6173,11 +6173,6 @@ static void handle_ops_on_dev_replace(enum btrfs_map_op op,
 	bioc->replace_nr_stripes = nr_extra_stripes;
 }
 
-static bool need_full_stripe(enum btrfs_map_op op)
-{
-	return (op == BTRFS_MAP_WRITE || op == BTRFS_MAP_GET_READ_MIRRORS);
-}
-
 static u64 btrfs_max_io_len(struct map_lookup *map, enum btrfs_map_op op,
 			    u64 offset, u32 *stripe_nr, u64 *stripe_offset,
 			    u64 *full_stripe_start)
@@ -6290,21 +6285,21 @@ int btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
 	if (map->type & BTRFS_BLOCK_GROUP_RAID0) {
 		stripe_index = stripe_nr % map->num_stripes;
 		stripe_nr /= map->num_stripes;
-		if (!need_full_stripe(op))
+		if (op == BTRFS_MAP_READ)
 			mirror_num = 1;
 	} else if (map->type & BTRFS_BLOCK_GROUP_RAID1_MASK) {
-		if (need_full_stripe(op))
+		if (op != BTRFS_MAP_READ) {
 			num_stripes = map->num_stripes;
-		else if (mirror_num)
+		} else if (mirror_num) {
 			stripe_index = mirror_num - 1;
-		else {
+		} else {
 			stripe_index = find_live_mirror(fs_info, map, 0,
 					    dev_replace_is_ongoing);
 			mirror_num = stripe_index + 1;
 		}
 
 	} else if (map->type & BTRFS_BLOCK_GROUP_DUP) {
-		if (need_full_stripe(op)) {
+		if (op != BTRFS_MAP_READ) {
 			num_stripes = map->num_stripes;
 		} else if (mirror_num) {
 			stripe_index = mirror_num - 1;
@@ -6318,7 +6313,7 @@ int btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
 		stripe_index = (stripe_nr % factor) * map->sub_stripes;
 		stripe_nr /= factor;
 
-		if (need_full_stripe(op))
+		if (op != BTRFS_MAP_READ)
 			num_stripes = map->sub_stripes;
 		else if (mirror_num)
 			stripe_index += mirror_num - 1;
@@ -6331,7 +6326,7 @@ int btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
 		}
 
 	} else if (map->type & BTRFS_BLOCK_GROUP_RAID56_MASK) {
-		if (need_raid_map && (need_full_stripe(op) || mirror_num > 1)) {
+		if (need_raid_map && (op != BTRFS_MAP_READ || mirror_num > 1)) {
 			/*
 			 * Push stripe_nr back to the start of the full stripe
 			 * For those cases needing a full stripe, @stripe_nr
@@ -6366,7 +6361,7 @@ int btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
 
 			/* We distribute the parity blocks across stripes */
 			stripe_index = (stripe_nr + stripe_index) % map->num_stripes;
-			if (!need_full_stripe(op) && mirror_num <= 1)
+			if (op == BTRFS_MAP_READ && mirror_num <= 1)
 				mirror_num = 1;
 		}
 	} else {
@@ -6406,7 +6401,7 @@ int btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
 	 */
 	if (smap && num_alloc_stripes == 1 &&
 	    !((map->type & BTRFS_BLOCK_GROUP_RAID56_MASK) && mirror_num > 1) &&
-	    (!need_full_stripe(op) || !dev_replace_is_ongoing ||
+	    (op == BTRFS_MAP_READ || !dev_replace_is_ongoing ||
 	     !dev_replace->tgtdev)) {
 		set_io_stripe(smap, map, stripe_index, stripe_offset, stripe_nr);
 		*mirror_num_ret = mirror_num;
@@ -6430,7 +6425,7 @@ int btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
 	 * It's still mostly the same as other profiles, just with extra rotation.
 	 */
 	if (map->type & BTRFS_BLOCK_GROUP_RAID56_MASK && need_raid_map &&
-	    (need_full_stripe(op) || mirror_num > 1)) {
+	    (op != BTRFS_MAP_READ || mirror_num > 1)) {
 		/*
 		 * For RAID56 @stripe_nr is already the number of full stripes
 		 * before us, which is also the rotation value (needs to modulo
@@ -6457,11 +6452,11 @@ int btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
 		}
 	}
 
-	if (need_full_stripe(op))
+	if (op != BTRFS_MAP_READ)
 		max_errors = btrfs_chunk_max_errors(map);
 
 	if (dev_replace_is_ongoing && dev_replace->tgtdev != NULL &&
-	    need_full_stripe(op)) {
+	    op != BTRFS_MAP_READ) {
 		handle_ops_on_dev_replace(op, bioc, dev_replace, logical,
 					  &num_stripes, &max_errors);
 	}
-- 
2.39.2

