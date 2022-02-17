Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C8E24B9D9E
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Feb 2022 11:51:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239358AbiBQKwH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 17 Feb 2022 05:52:07 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239370AbiBQKwG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 17 Feb 2022 05:52:06 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBAC229413B
        for <linux-btrfs@vger.kernel.org>; Thu, 17 Feb 2022 02:51:51 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 5F8DB1F37D
        for <linux-btrfs@vger.kernel.org>; Thu, 17 Feb 2022 10:51:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1645095110; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AiuhBu/CmCs6lvMJoG5OfSduv4412IMoUxXtID1Eank=;
        b=g/Xg2Z8YDQcI4XiqafCbmqORgvpEsAaIMFt8fYg1tBRycCVRV7dBYVcYQM4t7oHbzsz7gL
        yzcpRd2CaaLMtkWNiHGVs6MjRxIHnyMQzv2VX0LzV06xzXtBLQKeMAiEWLogJnkR4kwLBO
        VPlE35yn599mWoYNectg1aDLBWXqZwU=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9E31A13DD8
        for <linux-btrfs@vger.kernel.org>; Thu, 17 Feb 2022 10:51:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id cNZfGMUoDmKESwAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Thu, 17 Feb 2022 10:51:49 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 6/7] btrfs: use find_first_extent_item() to replace the open-coded extent item search
Date:   Thu, 17 Feb 2022 18:51:23 +0800
Message-Id: <2baf3f41126c4bfbaf6a0722c2f3ed8bab62f600.1645094762.git.wqu@suse.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1645094762.git.wqu@suse.com>
References: <cover.1645094762.git.wqu@suse.com>
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
 fs/btrfs/scrub.c | 100 ++++++++++++-----------------------------------
 1 file changed, 26 insertions(+), 74 deletions(-)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index a830ae723a0c..e5e704ea1f2f 100644
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
@@ -3364,6 +3315,7 @@ static int scrub_simple_mirror(struct scrub_ctx *sctx,
 			break;
 		get_extent_info(&path, &extent_start, &extent_len,
 				&extent_flags, &extent_gen);
+
 		/* Skip hole range which doesn't have any extent */
 		cur_logical = max(extent_start, cur_logical);
 
-- 
2.35.1

