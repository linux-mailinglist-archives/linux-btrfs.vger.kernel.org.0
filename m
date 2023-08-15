Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43A9B77C86B
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Aug 2023 09:17:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235403AbjHOHRB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 15 Aug 2023 03:17:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235396AbjHOHQg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Aug 2023 03:16:36 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2065510DD
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Aug 2023 00:16:34 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id BE3531F8C1
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Aug 2023 07:16:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1692083792; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=s4qsIktXKPr5t7WN4eVXf6XyS9ohJYqomBG4obHNnWM=;
        b=EJfIZ44iKFXW/XcNRbWt9VJiyLKRMpYdI3SkHj5LNkv7BB1jn1yDpwe79h6AWUMX8b4YQW
        Qaacx9NsHk49g2aZMIyPrk8BOvv+F8w/L2wTJh566qbqvhTFVXr6J37zO/C0n4bcmAUm/Y
        JEzHJudi/Jjk4D+zEnUTfh7/reyuZMA=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 079AC1353E
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Aug 2023 07:16:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id RFW2Lk8m22SnAgAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Aug 2023 07:16:31 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: scrub: avoid unnecessary extent tree search for striped profiles
Date:   Tue, 15 Aug 2023 15:16:26 +0800
Message-ID: <88abe1beac119b714a62f5e622c673f418afede2.1692083778.git.wqu@suse.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[PROBLEM]
Since commit 8557635ed2b0 ("btrfs: scrub: introduce dedicated helper to
scrub simple-stripe based range"), the scrub speed of striped profiles
(RAID0/RAID10/RAID5/RAID6) are degraded, if the block group is mostly
empty or fragmented.

[CAUSE]
In scrub_simple_stripe(), which is the responsible for RAID0/RAID10
profiles, we just call scrub_simple_mirror() and increase our
@cur_logical and @cur_physical.

The problem is, if there are no more extents inside the block group, or
the next extent is far away from our current logical, we would call
scrub_simple_mirror() for the empty ranges again and again, until we
reach the next next.

This is completely a waste of CPU time, thus it greatly degrade the
scrub performance for stripped profiles.

This is also affecting RAID56, as we rely on scrub_simple_mirror() for
data stripes of RAID56.

[FIX]
- Introduce scrub_ctx::found_next to record the next extent we found
  This member would be updated by find_first_extent_item() calls inside
  scrub_find_fill_first_stripe().

- Skip to the next stripe directly in scrub_simple_stripe()
  If we detect sctx->found_next is beyond our current stripe, we just
  skip to the full stripe which covers the target bytenr.

- Skip to the next full stripe covering sctx->found_next
  Unlike RAID0/RAID10, we can not easily skip to the next stripe due to
  rotation.
  But we can still skip to the next full stripe, which can still save us
  a lot of time.

Fixes: 8557635ed2b0 ("btrfs: scrub: introduce dedicated helper to scrub simple-stripe based range")
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
This patch is based on the scrub_testing branch (which is misc-next +
scrub performance fixes).

Thus there would be quite some conflicts for stable branches and would
need manual backport.
---
 fs/btrfs/scrub.c | 96 +++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 82 insertions(+), 14 deletions(-)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 6d83f5ed1d93..c3f576537114 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -219,6 +219,14 @@ struct scrub_ctx {
 	 * doing the wakeup() call.
 	 */
 	refcount_t              refs;
+
+	/*
+	 * Indicate the next logical that is covered by an extent.
+	 *
+	 * This is for striped profiles to skip stripes which doesn't have
+	 * any extent.
+	 */
+	u64			found_next;
 };
 
 struct scrub_warning {
@@ -1365,7 +1373,8 @@ static int compare_extent_item_range(struct btrfs_path *path,
  */
 static int find_first_extent_item(struct btrfs_root *extent_root,
 				  struct btrfs_path *path,
-				  u64 search_start, u64 search_len)
+				  u64 search_start, u64 search_len,
+				  u64 *found_next_ret)
 {
 	struct btrfs_fs_info *fs_info = extent_root->fs_info;
 	struct btrfs_key key;
@@ -1401,8 +1410,11 @@ static int find_first_extent_item(struct btrfs_root *extent_root,
 search_forward:
 	while (true) {
 		btrfs_item_key_to_cpu(path->nodes[0], &key, path->slots[0]);
-		if (key.objectid >= search_start + search_len)
+		if (key.objectid >= search_start + search_len) {
+			if (found_next_ret)
+				*found_next_ret = key.objectid;
 			break;
+		}
 		if (key.type != BTRFS_METADATA_ITEM_KEY &&
 		    key.type != BTRFS_EXTENT_ITEM_KEY)
 			goto next;
@@ -1410,13 +1422,18 @@ static int find_first_extent_item(struct btrfs_root *extent_root,
 		ret = compare_extent_item_range(path, search_start, search_len);
 		if (ret == 0)
 			return ret;
-		if (ret > 0)
+		if (ret > 0) {
+			if (found_next_ret)
+				*found_next_ret = key.objectid;
 			break;
+		}
 next:
 		path->slots[0]++;
 		if (path->slots[0] >= btrfs_header_nritems(path->nodes[0])) {
 			ret = btrfs_next_leaf(extent_root, path);
 			if (ret) {
+				if (ret > 0 && found_next_ret)
+					*found_next_ret = U64_MAX;
 				/* Either no more item or fatal error */
 				btrfs_release_path(path);
 				return ret;
@@ -1518,7 +1535,8 @@ static int scrub_find_fill_first_stripe(struct btrfs_block_group *bg,
 					struct btrfs_device *dev, u64 physical,
 					int mirror_num, u64 logical_start,
 					u32 logical_len,
-					struct scrub_stripe *stripe)
+					struct scrub_stripe *stripe,
+					u64 *found_next_ret)
 {
 	struct btrfs_fs_info *fs_info = bg->fs_info;
 	struct btrfs_root *extent_root = btrfs_extent_root(fs_info, bg->start);
@@ -1540,7 +1558,7 @@ static int scrub_find_fill_first_stripe(struct btrfs_block_group *bg,
 	ASSERT(logical_start >= bg->start && logical_end <= bg->start + bg->length);
 
 	ret = find_first_extent_item(extent_root, extent_path, logical_start,
-				     logical_len);
+				     logical_len, found_next_ret);
 	/* Either error or not found. */
 	if (ret)
 		goto out;
@@ -1574,7 +1592,8 @@ static int scrub_find_fill_first_stripe(struct btrfs_block_group *bg,
 	/* Fill the extent info for the remaining sectors. */
 	while (cur_logical <= stripe_end) {
 		ret = find_first_extent_item(extent_root, extent_path, cur_logical,
-					     stripe_end - cur_logical + 1);
+					     stripe_end - cur_logical + 1,
+					     found_next_ret);
 		if (ret < 0)
 			goto out;
 		if (ret > 0) {
@@ -1809,7 +1828,7 @@ static int queue_scrub_stripe(struct scrub_ctx *sctx, struct btrfs_block_group *
 	scrub_reset_stripe(stripe);
 	ret = scrub_find_fill_first_stripe(bg, &sctx->extent_path,
 			&sctx->csum_path, dev, physical, mirror_num, logical,
-			length, stripe);
+			length, stripe, &sctx->found_next);
 	/* Either >0 as no more extents or <0 for error. */
 	if (ret)
 		return ret;
@@ -1881,7 +1900,7 @@ static int scrub_raid56_parity_stripe(struct scrub_ctx *sctx,
 		ret = scrub_find_fill_first_stripe(bg, &extent_path, &csum_path,
 				map->stripes[stripe_index].dev, physical, 1,
 				full_stripe_start + btrfs_stripe_nr_to_offset(i),
-				BTRFS_STRIPE_LEN, stripe);
+				BTRFS_STRIPE_LEN, stripe, NULL);
 		if (ret < 0)
 			goto out;
 		/*
@@ -2124,10 +2143,33 @@ static int scrub_simple_stripe(struct scrub_ctx *sctx,
 					  mirror_num);
 		if (ret)
 			return ret;
-		/* Skip to next stripe which belongs to the target device */
-		cur_logical += logical_increment;
-		/* For physical offset, we just go to next stripe */
-		cur_physical += BTRFS_STRIPE_LEN;
+
+		/* No more extent item. all done. */
+		if (sctx->found_next >= bg->start + bg->length) {
+			sctx->stat.last_physical = orig_physical +
+				bg->length / (map->num_stripes / map->sub_stripes);
+			return 0;
+		}
+		/*
+		 * The next found extent is already beyond our stripe.
+		 * Skip to the next extent.
+		 */
+		if (sctx->found_next >= cur_logical + BTRFS_STRIPE_LEN) {
+			unsigned int stripes_skipped;
+
+			/* Advance to the next stripe covering sctx->found_next. */
+			stripes_skipped = div_u64(sctx->found_next - cur_logical,
+						  logical_increment);
+			if (stripes_skipped == 0)
+				stripes_skipped = 1;
+			cur_logical += logical_increment * stripes_skipped;
+			cur_physical += BTRFS_STRIPE_LEN * stripes_skipped;
+		} else {
+			/* Skip to next stripe which belongs to the target device */
+			cur_logical += logical_increment;
+			/* For physical offset, we just go to next stripe */
+			cur_physical += BTRFS_STRIPE_LEN;
+		}
 	}
 	return ret;
 }
@@ -2158,6 +2200,7 @@ static noinline_for_stack int scrub_stripe(struct scrub_ctx *sctx,
 
 	/* Extent_path should be probably released. */
 	ASSERT(sctx->extent_path.nodes[0] == NULL);
+	sctx->found_next = chunk_logical;
 
 	scrub_blocked_if_needed(fs_info);
 
@@ -2235,8 +2278,13 @@ static noinline_for_stack int scrub_stripe(struct scrub_ctx *sctx,
 	 * using their physical offset.
 	 */
 	while (physical < physical_end) {
+		u64 full_stripe_start;
+		u32 full_stripe_len = increment;
+
 		ret = get_raid56_logic_offset(physical, stripe_index, map,
 					      &logical, &stripe_logical);
+		full_stripe_start = rounddown(logical, full_stripe_len) +
+				    chunk_logical;
 		logical += chunk_logical;
 		if (ret) {
 			/* it is parity strip */
@@ -2261,8 +2309,28 @@ static noinline_for_stack int scrub_stripe(struct scrub_ctx *sctx,
 		if (ret < 0)
 			goto out;
 next:
-		logical += increment;
-		physical += BTRFS_STRIPE_LEN;
+		/* No more extent in the block group. */
+		if (sctx->found_next >= bg->start + bg->length) {
+			spin_lock(&sctx->stat_lock);
+			sctx->stat.last_physical = physical_end;
+			spin_unlock(&sctx->stat_lock);
+			goto out;
+		}
+
+		if (sctx->found_next >= full_stripe_start + full_stripe_len) {
+			unsigned int stripes_skipped;
+
+			stripes_skipped = div_u64(sctx->found_next - full_stripe_start,
+						  full_stripe_len);
+			if (stripes_skipped == 0)
+				stripes_skipped = 1;
+			logical += increment * stripes_skipped;
+			physical += BTRFS_STRIPE_LEN * stripes_skipped;
+		} else {
+			logical += increment;
+			physical += BTRFS_STRIPE_LEN;
+		}
+
 		spin_lock(&sctx->stat_lock);
 		if (stop_loop)
 			sctx->stat.last_physical =
-- 
2.41.0

