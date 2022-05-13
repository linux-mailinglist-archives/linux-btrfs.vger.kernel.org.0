Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86F91525DB9
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 May 2022 10:39:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357049AbiEMIem (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 13 May 2022 04:34:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378340AbiEMIei (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 13 May 2022 04:34:38 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 245AC2A8074
        for <linux-btrfs@vger.kernel.org>; Fri, 13 May 2022 01:34:37 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id D0D5D21A83
        for <linux-btrfs@vger.kernel.org>; Fri, 13 May 2022 08:34:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1652430875; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Kgy1CThjhLh/4QLbQZH54yBNVq1NItCvEBYTKkQGhPA=;
        b=rxeS2RtKG37gAwrv7bty9ppw2AX4JMSxldQVTe/eExG/Wn06qr9rJNMmUYIhUAQkei1ZiM
        tzC4O9XpEvo7+G6PfMoI69m2O+nZvgXSEVk7SxgTv+QqIbbKzJU5yM4ZljqWJAyxMIwBgr
        L2aVSrNE8klcaylgCNN2TZjUo+N9thM=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3315C13446
        for <linux-btrfs@vger.kernel.org>; Fri, 13 May 2022 08:34:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 2PqMOxoYfmI2YQAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Fri, 13 May 2022 08:34:34 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 1/4] btrfs: remove @dev_extent_len argument from scrub_stripe() function
Date:   Fri, 13 May 2022 16:34:28 +0800
Message-Id: <550645c92bf0b903b98d6bea5a779b30dc4a6793.1652428644.git.wqu@suse.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1652428644.git.wqu@suse.com>
References: <cover.1652428644.git.wqu@suse.com>
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

For scrub_stripe() we can easily calculate the dev extent length as we
have the full info of the chunk.

Thus there is no need to pass @dev_extent_len from the caller, and we
introduce a helper, btrfs_calc_stripe_length(), to do the calculation
from extent_map structure.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/scrub.c   | 13 +++++++------
 fs/btrfs/volumes.c | 12 ++++++------
 fs/btrfs/volumes.h |  1 +
 3 files changed, 14 insertions(+), 12 deletions(-)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index e7b0323e6efd..84346faa4ff1 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -3429,20 +3429,22 @@ static int scrub_simple_stripe(struct scrub_ctx *sctx,
 
 static noinline_for_stack int scrub_stripe(struct scrub_ctx *sctx,
 					   struct btrfs_block_group *bg,
-					   struct map_lookup *map,
+					   struct extent_map *em,
 					   struct btrfs_device *scrub_dev,
-					   int stripe_index, u64 dev_extent_len)
+					   int stripe_index)
 {
 	struct btrfs_path *path;
 	struct btrfs_fs_info *fs_info = sctx->fs_info;
 	struct btrfs_root *root;
 	struct btrfs_root *csum_root;
 	struct blk_plug plug;
+	struct map_lookup *map = em->map_lookup;
 	const u64 profile = map->type & BTRFS_BLOCK_GROUP_PROFILE_MASK;
 	const u64 chunk_logical = bg->start;
 	int ret;
 	u64 physical = map->stripes[stripe_index].physical;
-	const u64 physical_end = physical + dev_extent_len;
+	const u64 dev_stripe_len = btrfs_calc_stripe_length(em);
+	const u64 physical_end = physical + dev_stripe_len;
 	u64 logical;
 	u64 logic_end;
 	/* The logical increment after finishing one stripe */
@@ -3570,7 +3572,7 @@ static noinline_for_stack int scrub_stripe(struct scrub_ctx *sctx,
 		spin_lock(&sctx->stat_lock);
 		if (stop_loop)
 			sctx->stat.last_physical = map->stripes[stripe_index].physical +
-						   dev_extent_len;
+						   dev_stripe_len;
 		else
 			sctx->stat.last_physical = physical;
 		spin_unlock(&sctx->stat_lock);
@@ -3639,8 +3641,7 @@ static noinline_for_stack int scrub_chunk(struct scrub_ctx *sctx,
 	for (i = 0; i < map->num_stripes; ++i) {
 		if (map->stripes[i].dev->bdev == scrub_dev->bdev &&
 		    map->stripes[i].physical == dev_offset) {
-			ret = scrub_stripe(sctx, bg, map, scrub_dev, i,
-					   dev_extent_len);
+			ret = scrub_stripe(sctx, bg, em, scrub_dev, i);
 			if (ret)
 				goto out;
 		}
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 748614b00ffa..a49d72d845b1 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -6977,11 +6977,12 @@ static void btrfs_report_missing_device(struct btrfs_fs_info *fs_info,
 			      devid, uuid);
 }
 
-static u64 calc_stripe_length(u64 type, u64 chunk_len, int num_stripes)
+u64 btrfs_calc_stripe_length(const struct extent_map *em)
 {
-	const int data_stripes = calc_data_stripes(type, num_stripes);
+	const struct map_lookup *map = em->map_lookup;
+	const int data_stripes = calc_data_stripes(map->type, map->num_stripes);
 
-	return div_u64(chunk_len, data_stripes);
+	return div_u64(em->len, data_stripes);
 }
 
 #if BITS_PER_LONG == 32
@@ -7120,8 +7121,7 @@ static int read_one_chunk(struct btrfs_key *key, struct extent_buffer *leaf,
 	map->type = type;
 	map->sub_stripes = btrfs_chunk_sub_stripes(leaf, chunk);
 	map->verified_stripes = 0;
-	em->orig_block_len = calc_stripe_length(type, em->len,
-						map->num_stripes);
+	em->orig_block_len = btrfs_calc_stripe_length(em);
 	for (i = 0; i < num_stripes; i++) {
 		map->stripes[i].physical =
 			btrfs_stripe_offset_nr(leaf, chunk, i);
@@ -8022,7 +8022,7 @@ static int verify_one_dev_extent(struct btrfs_fs_info *fs_info,
 	}
 
 	map = em->map_lookup;
-	stripe_len = calc_stripe_length(map->type, em->len, map->num_stripes);
+	stripe_len = btrfs_calc_stripe_length(em);
 	if (physical_len != stripe_len) {
 		btrfs_err(fs_info,
 "dev extent physical offset %llu on devid %llu length doesn't match chunk %llu, have %llu expect %llu",
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index 12b2af9260e9..1338bc251ff6 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -601,6 +601,7 @@ int btrfs_is_parity_mirror(struct btrfs_fs_info *fs_info,
 			   u64 logical, u64 len);
 unsigned long btrfs_full_stripe_len(struct btrfs_fs_info *fs_info,
 				    u64 logical);
+u64 btrfs_calc_stripe_length(const struct extent_map *em);
 int btrfs_chunk_alloc_add_chunk_item(struct btrfs_trans_handle *trans,
 				     struct btrfs_block_group *bg);
 int btrfs_remove_chunk(struct btrfs_trans_handle *trans, u64 chunk_offset);
-- 
2.36.1

