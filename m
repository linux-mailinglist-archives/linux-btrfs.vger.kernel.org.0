Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A07EC4BB1A0
	for <lists+linux-btrfs@lfdr.de>; Fri, 18 Feb 2022 06:49:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230459AbiBRFtv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 18 Feb 2022 00:49:51 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230062AbiBRFtg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 18 Feb 2022 00:49:36 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E11403DA6D
        for <linux-btrfs@vger.kernel.org>; Thu, 17 Feb 2022 21:49:20 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id A04E2219A2
        for <linux-btrfs@vger.kernel.org>; Fri, 18 Feb 2022 05:49:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1645163359; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Aq7VGir9t5W+jWftrcGxFVWF15/ZHc8k8Wsny1t+1/g=;
        b=aU5GozNwqefJoRNNewzxDvZoBRrERjRj2cJ/tZc2e/hO+opV3yghGXDHB28xUSCXbennSL
        0Lh21h7j7xUO1lpoCMQt1a9zvhxiRuJhcNyI9Gy+DQ0fol5g/HSTjT4eX9C55XKhYU9JEW
        uhTY5S2zGwFt0bXJggzN6DgdtkwCbAM=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0529C13BF3
        for <linux-btrfs@vger.kernel.org>; Fri, 18 Feb 2022 05:49:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 8NO/MF4zD2JaFQAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Fri, 18 Feb 2022 05:49:18 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v3 8/9] btrfs: use find_first_extent_item() to replace the open-coded extent item search
Date:   Fri, 18 Feb 2022 13:48:51 +0800
Message-Id: <527dffff457e12d1c8d5d3f0987c13455235fdf2.1645101173.git.wqu@suse.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1645101173.git.wqu@suse.com>
References: <cover.1645101173.git.wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Since we have find_first_extent_item() to iterate the extent items of a
certain range, there is no need to use the open-coded version.

Replace the final scrub call site with find_first_extent_item().

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/scrub.c | 99 ++++++++++++------------------------------------
 1 file changed, 25 insertions(+), 74 deletions(-)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 97044957ed85..ddf337ac412d 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -3029,106 +3029,58 @@ static int scrub_raid56_data_stripe_for_parity(struct scrub_ctx *sctx,
 	struct btrfs_fs_info *fs_info = sctx->fs_info;
 	struct btrfs_root *extent_root = btrfs_extent_root(fs_info, logical);
 	struct btrfs_root *csum_root = btrfs_csum_root(fs_info, logical);
-	struct btrfs_key key;
 	u64 extent_start;
 	u64 extent_size;
+	u64 cur_logical = logical;
 	int ret;
 
 	ASSERT(map->type & BTRFS_BLOCK_GROUP_RAID56_MASK);
-
 	/* Path should not be populated */
 	ASSERT(!path->nodes[0]);
 
-	if (btrfs_fs_incompat(fs_info, SKINNY_METADATA))
-		key.type = BTRFS_METADATA_ITEM_KEY;
-	else
-		key.type = BTRFS_EXTENT_ITEM_KEY;
-	key.objectid = logical;
-	key.offset = (u64)-1;
-
-	ret = btrfs_search_slot(NULL, extent_root, &key, path, 0, 0);
-	if (ret < 0)
-		return ret;
-
-	if (ret > 0) {
-		ret = btrfs_previous_extent_item(extent_root, path, 0);
-		if (ret < 0)
-			return ret;
-		if (ret > 0) {
-			btrfs_release_path(path);
-			ret = btrfs_search_slot(NULL, extent_root, &key, path,
-						0, 0);
-			if (ret < 0)
-				return ret;
-		}
-	}
-
-	while (1) {
+	while (cur_logical < logical + map->stripe_len) {
 		struct btrfs_io_context *bioc = NULL;
 		struct btrfs_device *extent_dev;
-		struct btrfs_extent_item *ei;
-		struct extent_buffer *l;
-		int slot;
 		u64 mapped_length;
 		u64 extent_flags;
 		u64 extent_gen;
 		u64 extent_physical;
 		u64 extent_mirror_num;
 
-		l = path->nodes[0];
-		slot = path->slots[0];
-		if (slot >= btrfs_header_nritems(l)) {
-			ret = btrfs_next_leaf(extent_root, path);
-			if (ret == 0)
-				continue;
-
-			/* No more extent items or error, exit */
+		ret = find_first_extent_item(extent_root, path, cur_logical,
+					logical + map->stripe_len - cur_logical);
+		/* No more extent item in this data stripe */
+		if (ret > 0) {
+			ret = 0;
 			break;
 		}
-		btrfs_item_key_to_cpu(l, &key, slot);
-
-		if (key.type != BTRFS_EXTENT_ITEM_KEY &&
-		    key.type != BTRFS_METADATA_ITEM_KEY)
-			goto next;
-
-		if (key.type == BTRFS_METADATA_ITEM_KEY)
-			extent_size = fs_info->nodesize;
-		else
-			extent_size = key.offset;
-
-		if (key.objectid + extent_size <= logical)
-			goto next;
-
-		/* Beyond this data stripe */
-		if (key.objectid >= logical + map->stripe_len)
+		if (ret < 0)
 			break;
+		get_extent_info(path, &extent_start, &extent_size,
+				&extent_flags, &extent_gen);
 
-		ei = btrfs_item_ptr(l, slot, struct btrfs_extent_item);
-		extent_flags = btrfs_extent_flags(l, ei);
-		extent_gen = btrfs_extent_generation(l, ei);
-
+		/* Metadata should not cross stripe boundaries */
 		if ((extent_flags & BTRFS_EXTENT_FLAG_TREE_BLOCK) &&
-		    (key.objectid < logical || key.objectid + extent_size >
-		     logical + map->stripe_len)) {
+		    does_range_cross_boundary(extent_start, extent_size,
+					      logical, map->stripe_len)) {
 			btrfs_err(fs_info,
-				  "scrub: tree block %llu spanning stripes, ignored. logical=%llu",
-				  key.objectid, logical);
+	"scrub: tree block %llu spanning stripes, ignored. logical=%llu",
+				  extent_start, logical);
 			spin_lock(&sctx->stat_lock);
 			sctx->stat.uncorrectable_errors++;
 			spin_unlock(&sctx->stat_lock);
-			goto next;
+			cur_logical += extent_size;
+			continue;
 		}
 
-		extent_start = key.objectid;
-		ASSERT(extent_size <= U32_MAX);
+		/* Skip hole range which doesn't have any extent */
+		cur_logical = max(extent_start, cur_logical);
 
-		/* Truncate the range inside the data stripe */
-		if (extent_start < logical) {
-			extent_size -= logical - extent_start;
-			extent_start = logical;
-		}
-		if (extent_start + extent_size > logical + map->stripe_len)
-			extent_size = logical + map->stripe_len - extent_start;
+		/* Truncate the range inside this data stripe */
+		extent_size = min(extent_start + extent_size,
+				  logical + map->stripe_len) - cur_logical;
+		extent_start = cur_logical;
+		ASSERT(extent_size <= U32_MAX);
 
 		scrub_parity_mark_sectors_data(sparity, extent_start, extent_size);
 
@@ -3164,8 +3116,7 @@ static int scrub_raid56_data_stripe_for_parity(struct scrub_ctx *sctx,
 			break;
 
 		cond_resched();
-next:
-		path->slots[0]++;
+		cur_logical += extent_size;
 	}
 	if (ret < 0)
 		scrub_parity_mark_sectors_error(sparity, extent_start,
-- 
2.35.1

