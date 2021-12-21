Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 909A847B865
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Dec 2021 03:34:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233299AbhLUCeM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 20 Dec 2021 21:34:12 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:45546 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233250AbhLUCeL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 20 Dec 2021 21:34:11 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id C3B021F3A6
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Dec 2021 02:34:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1640054050; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3xYFFseNGONNETBDNqXiwSU5uDpeLgm02DpEifL6Rbs=;
        b=nnKpSkDclQMJLm+t6rhS9vKLQ97obEyteyzZ4GPLqdzoVsxIXVkffySrFl0A/mjqxyRUYo
        /3x5/ChukVfLFoq38SxzePp+Lr1phAycPz8ihiER8VWOAGDvfEkw2lHyrW4Erl/FUeCTYx
        xxfs2CAS2zF0fOq+oAT/gclRcIfIZVE=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1D7DC13BDA
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Dec 2021 02:34:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id OI2WNSE9wWEOLwAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Dec 2021 02:34:09 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH RFC 3/4] btrfs: introduce dedicated helper to scrub simple-stripe based range
Date:   Tue, 21 Dec 2021 10:33:48 +0800
Message-Id: <20211221023349.27696-4-wqu@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211221023349.27696-1-wqu@suse.com>
References: <20211221023349.27696-1-wqu@suse.com>
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
 fs/btrfs/scrub.c | 60 +++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 57 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index ddd069bd2375..aff9db6fbc7e 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -3446,6 +3446,55 @@ static int scrub_simple_mirror(struct scrub_ctx *sctx,
 	return ret;
 }
 
+static int scrub_simple_stripe(struct scrub_ctx *sctx,
+				struct btrfs_root *extent_root,
+				struct btrfs_root *csum_root,
+				struct btrfs_block_group *bg,
+				struct map_lookup *map,
+				struct btrfs_device *device,
+				int stripe_index)
+{
+	/* The increment of logical bytenr */
+	const u64 logical_increment = (map->num_stripes / map->sub_stripes) *
+				      map->stripe_len;
+	/*
+	 * Our starting logical bytenr needs to be calculated based on
+	 * stripe_index.
+	 *
+	 * stripe_index / sub_stripes gives how many data stripes we need to
+	 * skip.
+	 */
+	const u64 orig_logical = (stripe_index / map->sub_stripes) *
+				 map->stripe_len + bg->start;
+	const u64 orig_physical = map->stripes[stripe_index].physical;
+	/*
+	 * For RAID0, it's fixed to 1.
+	 * For RAID10, the mirror_num is always 0,1,0,1,...
+	 */
+	const int mirror_num = stripe_index % map->sub_stripes + 1;
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
@@ -3576,9 +3625,14 @@ static noinline_for_stack int scrub_stripe(struct scrub_ctx *sctx,
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

