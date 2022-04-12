Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17B7F4FDCAE
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Apr 2022 13:06:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347085AbiDLKhv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 12 Apr 2022 06:37:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354382AbiDLKdj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 12 Apr 2022 06:33:39 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BAFA5B3F2
        for <linux-btrfs@vger.kernel.org>; Tue, 12 Apr 2022 02:33:32 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id C3DD7210EC
        for <linux-btrfs@vger.kernel.org>; Tue, 12 Apr 2022 09:33:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1649756010; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ciRvweAtbmh1s4SqG5hlczQcnQx6V83ZK3y0fUrbmYg=;
        b=JTX4SU9A//Z0VkkrWmjeJx0CUSbrYAGuBVQny5MS4JrIzsNFcYs8D0vJm1MD/4ZooxDV0r
        Siy4VsHaThNK+vKgnc7RS5hyksasbyfYdegMeOo3vA27CqcIUFTJHxNVS3k6Dq/OpZsoJ9
        mjWnAYx5+eCtKUmJh8bzJFfP8FUzfi4=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0C00113A99
        for <linux-btrfs@vger.kernel.org>; Tue, 12 Apr 2022 09:33:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id OBYwMWlHVWI8LwAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Tue, 12 Apr 2022 09:33:29 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 04/17] btrfs: introduce new cached members for btrfs_raid_bio
Date:   Tue, 12 Apr 2022 17:32:54 +0800
Message-Id: <38fdde8665c4765551fea3c5818bfa79b1214fa6.1649753690.git.wqu@suse.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1649753690.git.wqu@suse.com>
References: <cover.1649753690.git.wqu@suse.com>
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
 fs/btrfs/raid56.c | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
index 8cf0f368729a..92d464d4456a 100644
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
+	/* Allocated with stripe_nsectors-many bits for finish_*() calls */
 	unsigned long *finish_pbitmap;
 };
 
@@ -958,19 +964,24 @@ static struct btrfs_raid_bio *alloc_rbio(struct btrfs_fs_info *fs_info,
 	const unsigned int real_stripes = bioc->num_stripes - bioc->num_tgtdevs;
 	const unsigned int stripe_npages = stripe_len >> PAGE_SHIFT;
 	const unsigned int num_pages = stripe_npages * real_stripes;
+	const unsigned int stripe_nsectors = stripe_len >>
+					     fs_info->sectorsize_bits;
+	const unsigned int num_sectors = stripe_nsectors * real_stripes;
 	struct btrfs_raid_bio *rbio;
 	int nr_data = 0;
 	void *p;
 
 	ASSERT(IS_ALIGNED(stripe_len, PAGE_SIZE));
+	/* PAGE_SIZE must also be aligned to sectorsize for subpage support */
+	ASSERT(IS_ALIGNED(PAGE_SIZE, fs_info->sectorsize));
 
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
@@ -983,8 +994,10 @@ static struct btrfs_raid_bio *alloc_rbio(struct btrfs_fs_info *fs_info,
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
@@ -1003,8 +1016,8 @@ static struct btrfs_raid_bio *alloc_rbio(struct btrfs_fs_info *fs_info,
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

