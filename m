Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 755B948707D
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Jan 2022 03:34:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344759AbiAGCex (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 6 Jan 2022 21:34:53 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:42464 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231945AbiAGCew (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 6 Jan 2022 21:34:52 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 98CEC1F39C
        for <linux-btrfs@vger.kernel.org>; Fri,  7 Jan 2022 02:34:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1641522891; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LGKbS5m3myWhFb3UFglVNvqExj/yPbyLVuJSI1QQlGU=;
        b=PvXNt0K6oHaxCIuLq0u91KwcHsLVzp/49ocEjgU/pkOdkdPZtgX9jXAY9rU0JrSpjjwpG0
        Z5GPfBe7O1+cZjmjZxg2fayLK12Vh6jBUOCGAeBqq5qGyU/oQMSbKJHxDAql/tthTNik4h
        ebVigEOYkpMBsYz7DgxclcYWIvmHA/E=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EF2C213C9D
        for <linux-btrfs@vger.kernel.org>; Fri,  7 Jan 2022 02:34:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 2BYGLsqm12FTUgAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Fri, 07 Jan 2022 02:34:50 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 3/4] btrfs: introduce dedicated helper to scrub simple-stripe based range
Date:   Fri,  7 Jan 2022 10:34:29 +0800
Message-Id: <20220107023430.28288-4-wqu@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220107023430.28288-1-wqu@suse.com>
References: <20220107023430.28288-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The new entrance will iterate through each data stripe which belongs to
the target device.

And since inside each data stripe, RAID0 is just SINGLE, while RAID10 is
just RAID1, we can reuse scrub_simple_mirror() to do the scrub properly.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/scrub.c | 100 +++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 88 insertions(+), 12 deletions(-)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 7b39705502b4..5dcdebd59b93 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -3010,6 +3010,15 @@ static void get_extent_info(struct btrfs_path *path, u64 *extent_start_ret,
 	*generation_ret = btrfs_extent_generation(path->nodes[0], ei);
 }
 
+static bool does_range_cross_boundary(u64 extent_start, u64 extent_len,
+				      u64 boundary_start, u64 boudary_len)
+{
+	return (extent_start < boundary_start &&
+		extent_start + extent_len > boundary_start) ||
+	       (extent_start < boundary_start + boudary_len &&
+		extent_start + extent_len > boundary_start + boudary_len);
+}
+
 static noinline_for_stack int scrub_raid56_parity(struct scrub_ctx *sctx,
 						  struct map_lookup *map,
 						  struct btrfs_device *sdev,
@@ -3293,15 +3302,6 @@ static int sync_write_pointer_for_zoned(struct scrub_ctx *sctx, u64 logical,
 	return ret;
 }
 
-static bool does_range_cross_boundary(u64 extent_start, u64 extent_len,
-				      u64 boundary_start, u64 boudary_len)
-{
-	return (extent_start < boundary_start &&
-		extent_start + extent_len > boundary_start) ||
-	       (extent_start < boundary_start + boudary_len &&
-		extent_start + extent_len > boundary_start + boudary_len);
-}
-
 /*
  * Scrub one range which can only has simple mirror based profile.
  * (Including all range in SINGLE/DUP/RAID1/RAID1C*, and each stripe in
@@ -3439,6 +3439,77 @@ static int scrub_simple_mirror(struct scrub_ctx *sctx,
 	return ret;
 }
 
+/* Calculate the full stripe length for simple stripe based profiles */
+static u64 simple_stripe_full_stripe_len(struct map_lookup *map)
+{
+	ASSERT(map->type & (BTRFS_BLOCK_GROUP_RAID0 |
+			    BTRFS_BLOCK_GROUP_RAID10));
+
+	return map->num_stripes / map->sub_stripes * map->stripe_len;
+}
+
+/* Get the logical bytenr for the stripe */
+static u64 simple_stripe_get_logical(struct map_lookup *map,
+				     struct btrfs_block_group *bg,
+				     int stripe_index)
+{
+	ASSERT(map->type & (BTRFS_BLOCK_GROUP_RAID0 |
+			    BTRFS_BLOCK_GROUP_RAID10));
+	ASSERT(stripe_index < map->num_stripes);
+
+	/*
+	 * (stripe_index / sub_stripes) gives how many data stripes we need to
+	 * skip.
+	 */
+	return (stripe_index / map->sub_stripes) * map->stripe_len + bg->start;
+}
+
+/* Get the mirror number for the stripe */
+static int simple_stripe_mirror_num(struct map_lookup *map, int stripe_index)
+{
+	ASSERT(map->type & (BTRFS_BLOCK_GROUP_RAID0 |
+			    BTRFS_BLOCK_GROUP_RAID10));
+	ASSERT(stripe_index < map->num_stripes);
+
+	/* For RAID0, it's fixed to 1, for RAID10 it's 0,1,0,1... */
+	return stripe_index % map->sub_stripes + 1;
+}
+
+static int scrub_simple_stripe(struct scrub_ctx *sctx,
+				struct btrfs_root *extent_root,
+				struct btrfs_root *csum_root,
+				struct btrfs_block_group *bg,
+				struct map_lookup *map,
+				struct btrfs_device *device,
+				int stripe_index)
+{
+	const u64 logical_increment = simple_stripe_full_stripe_len(map);
+	const u64 orig_logical = simple_stripe_get_logical(map, bg, stripe_index);
+	const u64 orig_physical = map->stripes[stripe_index].physical;
+	const int mirror_num = simple_stripe_mirror_num(map, stripe_index);
+	u64 cur_logical = orig_logical;
+	u64 cur_physical = orig_physical;
+	int ret = 0;
+
+	while (cur_logical < bg->start + bg->length) {
+		/*
+		 * Inside each stripe, RAID0 is just SINGLE, and RAID10 is
+		 * just RAID1, so we can reuse scrub_simple_mirror() to scrub
+		 * this stripe.
+		 */
+		ret = scrub_simple_mirror(sctx, extent_root, csum_root, bg, map,
+					  cur_logical, map->stripe_len, device,
+					  cur_physical, mirror_num);
+		if (ret)
+			return ret;
+		/* Skip to next stripe which belongs to the target device */
+		cur_logical += logical_increment;
+		/* For physical offset, we just go to next stripe */
+		cur_physical += map->stripe_len;
+	}
+	return ret;
+}
+
 static noinline_for_stack int scrub_stripe(struct scrub_ctx *sctx,
 					   struct btrfs_block_group *bg,
 					   struct map_lookup *map,
@@ -3569,9 +3640,14 @@ static noinline_for_stack int scrub_stripe(struct scrub_ctx *sctx,
 				stripe_index + 1);
 		goto out;
 	}
-	/*
-	 * now find all extents for each stripe and scrub them
-	 */
+	if (profile & (BTRFS_BLOCK_GROUP_RAID0 | BTRFS_BLOCK_GROUP_RAID10)) {
+		ret = scrub_simple_stripe(sctx, root, csum_root, bg, map,
+					  scrub_dev, stripe_index);
+		goto out;
+	}
+
+	/* Only RAID56 goes through the old code */
+	ASSERT(map->type & BTRFS_BLOCK_GROUP_RAID56_MASK);
 	ret = 0;
 	while (physical < physical_end) {
 		/*
-- 
2.34.1

