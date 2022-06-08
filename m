Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40E81542560
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Jun 2022 08:54:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240142AbiFHDR4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 7 Jun 2022 23:17:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349371AbiFHDO5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 7 Jun 2022 23:14:57 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0303157EA0
        for <linux-btrfs@vger.kernel.org>; Tue,  7 Jun 2022 17:35:19 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 26CAB1FA14
        for <linux-btrfs@vger.kernel.org>; Wed,  8 Jun 2022 00:34:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1654648498; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bk442qxnoootIQjBA4PkyXCeB4wL1p/VkspfHSMs3ag=;
        b=Ub917UFgTpVx2MgZP64MvguY0jp3EA+Py+DG6l2vBgPcuXHNtnLkPPn5QS3nqkz0jEbldI
        9se8hTfiQNCnDdPENQ+HsCWpYoASgVf/ZcbbtCrAP3k0mVk2DEijWAb9tIjBZB2Py2a3eZ
        bU70dh86++Cs0C51IUBwmddLWyY/RxU=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7CACF137FA
        for <linux-btrfs@vger.kernel.org>; Wed,  8 Jun 2022 00:34:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id +FMfErHun2LiHQAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Wed, 08 Jun 2022 00:34:57 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v3 3/5] btrfs: avoid double for loop inside alloc_rbio_essential_pages()
Date:   Wed,  8 Jun 2022 08:34:34 +0800
Message-Id: <5a1bc3467c9d5efc972629ee2d5199475ec45796.1654648358.git.wqu@suse.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1654648358.git.wqu@suse.com>
References: <cover.1654648358.git.wqu@suse.com>
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

The double loop is just checking if the page for the vertical stripe
is allocated.

We can easily convert it to single loop and get rid of @stripe variable.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/raid56.c | 29 ++++++++++++++---------------
 1 file changed, 14 insertions(+), 15 deletions(-)

diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
index b5fcc6dd1c0f..29b623be5b61 100644
--- a/fs/btrfs/raid56.c
+++ b/fs/btrfs/raid56.c
@@ -2381,23 +2381,22 @@ void raid56_add_scrub_pages(struct btrfs_raid_bio *rbio, struct page *page,
 static int alloc_rbio_essential_pages(struct btrfs_raid_bio *rbio)
 {
 	const u32 sectorsize = rbio->bioc->fs_info->sectorsize;
-	int stripe;
-	int sectornr;
-
-	for_each_set_bit(sectornr, &rbio->dbitmap, rbio->stripe_nsectors) {
-		for (stripe = 0; stripe < rbio->real_stripes; stripe++) {
-			struct page *page;
-			int index = (stripe * rbio->stripe_nsectors + sectornr) *
-				    sectorsize >> PAGE_SHIFT;
+	int total_sector_nr;
 
-			if (rbio->stripe_pages[index])
-				continue;
+	for (total_sector_nr = 0; total_sector_nr < rbio->nr_sectors;
+	     total_sector_nr++) {
+		struct page *page;
+		int sectornr = total_sector_nr % rbio->stripe_nsectors;
+		int index = (total_sector_nr * sectorsize) >> PAGE_SHIFT;
 
-			page = alloc_page(GFP_NOFS);
-			if (!page)
-				return -ENOMEM;
-			rbio->stripe_pages[index] = page;
-		}
+		if (!test_bit(sectornr, &rbio->dbitmap))
+			continue;
+		if (rbio->stripe_pages[index])
+			continue;
+		page = alloc_page(GFP_NOFS);
+		if (!page)
+			return -ENOMEM;
+		rbio->stripe_pages[index] = page;
 	}
 	index_stripe_sectors(rbio);
 	return 0;
-- 
2.36.1

