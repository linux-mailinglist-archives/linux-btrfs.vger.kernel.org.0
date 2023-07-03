Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AFD974562D
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Jul 2023 09:33:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231128AbjGCHd2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 3 Jul 2023 03:33:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230471AbjGCHdQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 3 Jul 2023 03:33:16 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C37DEE69
        for <linux-btrfs@vger.kernel.org>; Mon,  3 Jul 2023 00:33:04 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 61FB71F8B5
        for <linux-btrfs@vger.kernel.org>; Mon,  3 Jul 2023 07:33:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1688369583; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hC9OuQgd1HllIZBCrwKj7P2yFRVM1/HMtmhIvECImqo=;
        b=s9Z31II7MS/4gATGzwq9zaaH6EU3jtbwu5NyBLAOUPKsccbZiI336AJObnTAzIshtDScX2
        q65c5Qumg0jM1sov80czEArowi5g2h41Udidcp57omyFf8AbU3eClHG51FCHcVqG8tCE5U
        RI/F6574r2E0Fk/WkY6WHHFgTDXi11o=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AE3A713276
        for <linux-btrfs@vger.kernel.org>; Mon,  3 Jul 2023 07:33:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id WKL3HK55omRoVQAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Mon, 03 Jul 2023 07:33:02 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 05/14] btrfs: add the ability to read P/Q stripes directly
Date:   Mon,  3 Jul 2023 15:32:29 +0800
Message-ID: <0d54adfb390b3c9ffd8ff8f98db43de51df9c33e.1688368617.git.wqu@suse.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1688368617.git.wqu@suse.com>
References: <cover.1688368617.git.wqu@suse.com>
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

Currently there is no way to read P/Q stripes of a RAID56 full stripe
directly.

Normally caller should call btrfs_map_block() directly and fetch the
physical location directly of the P/Q stripes.

But for the recent scrub rework, it's no longer that elegant as the full
scrub code is based on mirror_num based solution, thus this patch would
add two special mirror_num for this usages:

- Mirror -1 for P stripes
- Mirror -2 for Q stripes

Both mirrors only support read for now, and caller should make sure the
range start is stripe aligned.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/scrub.c   |  2 +-
 fs/btrfs/volumes.c | 30 +++++++++++++++++++++++++++++-
 2 files changed, 30 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 1864856abb13..41c514db0793 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -1601,7 +1601,7 @@ static void scrub_submit_initial_read(struct scrub_ctx *sctx,
 	int mirror = stripe->mirror_num;
 
 	ASSERT(stripe->bg);
-	ASSERT(stripe->mirror_num > 0);
+	ASSERT(stripe->mirror_num);
 	ASSERT(test_bit(SCRUB_STRIPE_FLAG_INITIALIZED, &stripe->state));
 
 	bbio = btrfs_bio_alloc(SCRUB_STRIPE_PAGES, REQ_OP_READ, fs_info,
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index cd632b3f579f..c22007bd830b 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -6251,10 +6251,12 @@ static void set_io_stripe(struct btrfs_io_stripe *dst, const struct map_lookup *
  *
  *			For RAID56 profile, mirror 1 means rebuild from P and
  *			the remaining data stripes.
+ *			And mirror -1 means read P stripes directly, -2 means
+ *			read Q stripes directly.
  *
  *			For RAID6 profile, mirror > 2 means mark another
  *			data/P stripe error and rebuild from the remaining
- *			stripes..
+ *			stripes.
  *
  * @need_raid_map:	(Used only for integrity checker) whether the map wants
  *                      a full stripe map (including all data and P/Q stripes)
@@ -6297,6 +6299,12 @@ int btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
 		goto out_free_em;
 	}
 
+	/* Only allow mirror_num < 0 for RAID56. */
+	if (mirror_num < 0 && !(map->type & BTRFS_BLOCK_GROUP_RAID56_MASK)) {
+		free_extent_map(em);
+		return -EINVAL;
+	}
+
 	data_stripes = nr_data_stripes(map);
 
 	map_offset = logical - em->start;
@@ -6382,6 +6390,26 @@ int btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
 				  logical;
 			stripe_index = 0;
 			stripe_offset = 0;
+		} else if (mirror_num < 0) {
+			/* Only allow READ for direct P/Q operations. */
+			ASSERT(op == BTRFS_MAP_READ);
+			/*
+			 * Caller should make sure the range start is stripe
+			 * aligned.
+			 */
+			ASSERT(stripe_offset == 0);
+
+			/*
+			 * Stripes of @bioc is already sorted, stripes[0] is the
+			 * first data stripe and stripes[@data_stripes] is the
+			 * P stripe.
+			 * So we only need to update the @stripe_index to the
+			 * specified stripe, and set @stripe_nr/@stripe_offset
+			 * to 0, so we can return the beginning of the P/Q stripe.
+			 */
+			stripe_offset = 0;
+			stripe_nr = 0;
+			stripe_index = data_stripes + (-mirror_num - 1);
 		} else {
 			/*
 			 * Mirror #0 or #1 means the original data block.
-- 
2.41.0

