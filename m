Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D67424EEC4D
	for <lists+linux-btrfs@lfdr.de>; Fri,  1 Apr 2022 13:24:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344444AbiDALZp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 1 Apr 2022 07:25:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345335AbiDALZn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 1 Apr 2022 07:25:43 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EE76182AF4
        for <linux-btrfs@vger.kernel.org>; Fri,  1 Apr 2022 04:23:53 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 2989A1FD00
        for <linux-btrfs@vger.kernel.org>; Fri,  1 Apr 2022 11:23:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1648812232; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1Q7DKGqJ0EyX7PFK1AWEWlYguMnkjkF0dNPwIIaYvKo=;
        b=JYo1631OBE4Vls79L2l4l93UUHu0XJO8ahAWn9/sdBzJYLaKnjJ1agjZLT7lVF/e5uuEmY
        uFlZZH6RX1vKqEgPPUnw7Mr75KtWfmvuXhn0XX1cp7/9x0SsHJaIfo1rRPGVtNJGxdV1z1
        uh40oLamiAn91wY6hGdioP7AODqMO5Q=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8368A132C1
        for <linux-btrfs@vger.kernel.org>; Fri,  1 Apr 2022 11:23:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id cBWyE8fgRmJeFwAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Fri, 01 Apr 2022 11:23:51 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 03/16] btrfs: introduce new cached members for btrfs_raid_bio
Date:   Fri,  1 Apr 2022 19:23:18 +0800
Message-Id: <a2f049f315b3c218d909c854ab117779d8842abe.1648807440.git.wqu@suse.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1648807440.git.wqu@suse.com>
References: <cover.1648807440.git.wqu@suse.com>
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

The new members are all related to number of sectors, but the existing
number of pages members are kept as is:

- nr_sectors
  Total sectors of the full stripe including P/Q.

- stripe_nsectors
  The sectors of a single stripe.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/raid56.c | 25 ++++++++++++++++++++-----
 1 file changed, 20 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
index 2553e1bb8bbf..1bad7d3a0331 100644
--- a/fs/btrfs/raid56.c
+++ b/fs/btrfs/raid56.c
@@ -115,6 +115,9 @@ struct btrfs_raid_bio {
 	/* How many pages there are for the full stripe including P/Q */
 	u16 nr_pages;
 
+	/* How many sectors there are for the full stripe including P/Q */
+	u16 nr_sectors;
+
 	/* Number of data stripes (no p/q) */
 	u8 nr_data;
 
@@ -124,6 +127,9 @@ struct btrfs_raid_bio {
 	/* How many pages there are for each stripe */
 	u8 stripe_npages;
 
+	/* How many sectors there are for each stripe */
+	u8 stripe_nsectors;
+
 	/* First bad stripe, -1 means no corruption */
 	s8 faila;
 
@@ -172,7 +178,7 @@ struct btrfs_raid_bio {
 	/* allocated with real_stripes-many pointers for finish_*() calls */
 	void **finish_pointers;
 
-	/* allocated with stripe_npages-many bits for finish_*() calls */
+	/* allocated with stripe_nsectors-many bits for finish_*() calls */
 	unsigned long *finish_pbitmap;
 };
 
@@ -958,18 +964,25 @@ static struct btrfs_raid_bio *alloc_rbio(struct btrfs_fs_info *fs_info,
 	const unsigned int real_stripes = bioc->num_stripes - bioc->num_tgtdevs;
 	const unsigned int num_pages = DIV_ROUND_UP(stripe_len, PAGE_SIZE) *
 				       real_stripes;
+	const unsigned int num_sectors = DIV_ROUND_UP(stripe_len * real_stripes,
+						      fs_info->sectorsize);
 	const unsigned int stripe_npages = DIV_ROUND_UP(stripe_len, PAGE_SIZE);
+	const unsigned int stripe_nsectors = DIV_ROUND_UP(stripe_len,
+							  fs_info->sectorsize);
 	struct btrfs_raid_bio *rbio;
 	int nr_data = 0;
 	void *p;
 
+	/* PAGE_SIZE must tbe aligned to sectorsize for subpage support */
+	ASSERT(IS_ALIGNED(PAGE_SIZE, fs_info->sectorsize));
+
 	rbio = kzalloc(sizeof(*rbio) +
 		       sizeof(*rbio->stripe_pages) * num_pages +
 		       sizeof(*rbio->bio_pages) * num_pages +
 		       sizeof(*rbio->finish_pointers) * real_stripes +
-		       sizeof(*rbio->dbitmap) * BITS_TO_LONGS(stripe_npages) +
+		       sizeof(*rbio->dbitmap) * BITS_TO_LONGS(stripe_nsectors) +
 		       sizeof(*rbio->finish_pbitmap) *
-				BITS_TO_LONGS(stripe_npages),
+				BITS_TO_LONGS(stripe_nsectors),
 		       GFP_NOFS);
 	if (!rbio)
 		return ERR_PTR(-ENOMEM);
@@ -982,8 +995,10 @@ static struct btrfs_raid_bio *alloc_rbio(struct btrfs_fs_info *fs_info,
 	rbio->bioc = bioc;
 	rbio->stripe_len = stripe_len;
 	rbio->nr_pages = num_pages;
+	rbio->nr_sectors = num_sectors;
 	rbio->real_stripes = real_stripes;
 	rbio->stripe_npages = stripe_npages;
+	rbio->stripe_nsectors = stripe_nsectors;
 	rbio->faila = -1;
 	rbio->failb = -1;
 	refcount_set(&rbio->refs, 1);
@@ -1002,8 +1017,8 @@ static struct btrfs_raid_bio *alloc_rbio(struct btrfs_fs_info *fs_info,
 	CONSUME_ALLOC(rbio->stripe_pages, num_pages);
 	CONSUME_ALLOC(rbio->bio_pages, num_pages);
 	CONSUME_ALLOC(rbio->finish_pointers, real_stripes);
-	CONSUME_ALLOC(rbio->dbitmap, BITS_TO_LONGS(stripe_npages));
-	CONSUME_ALLOC(rbio->finish_pbitmap, BITS_TO_LONGS(stripe_npages));
+	CONSUME_ALLOC(rbio->dbitmap, BITS_TO_LONGS(stripe_nsectors));
+	CONSUME_ALLOC(rbio->finish_pbitmap, BITS_TO_LONGS(stripe_nsectors));
 #undef  CONSUME_ALLOC
 
 	if (bioc->map_type & BTRFS_BLOCK_GROUP_RAID5)
-- 
2.35.1

