Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 904B053B400
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Jun 2022 09:07:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231533AbiFBHHF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Jun 2022 03:07:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231461AbiFBHHC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Jun 2022 03:07:02 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1112860B84
        for <linux-btrfs@vger.kernel.org>; Thu,  2 Jun 2022 00:07:00 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id A997721B00
        for <linux-btrfs@vger.kernel.org>; Thu,  2 Jun 2022 07:06:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1654153619; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8LFTR/Iy/whRasmG32YzPrBquan0Vm8KZo4e2D25BIY=;
        b=f7MBMestCoBd30ReyLThyY98qzFlmzHHtIKXmPvy9meIJx3NbKUgCLlnYULdmRMhBh4Vuh
        XbcZLZuYDYMhXz77WB6H7LNC5b8bjWb2akTBn3M3Zf0M3TshFbFdiroP/yz5CnVil+4+Sm
        CgYQyKW8P7ZxVZIQG68wGTD5cJkrt4A=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EE02D134F3
        for <linux-btrfs@vger.kernel.org>; Thu,  2 Jun 2022 07:06:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id kEJgLJJhmGKSAgAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Thu, 02 Jun 2022 07:06:58 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 3/5] btrfs: avoid double for loop inside alloc_rbio_essential_pages()
Date:   Thu,  2 Jun 2022 15:06:35 +0800
Message-Id: <78159f0e8ba96df617b1b95b34f08f542230540a.1654153382.git.wqu@suse.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1654153382.git.wqu@suse.com>
References: <cover.1654153382.git.wqu@suse.com>
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
index 7c17f35e0830..ffb9ed9c625c 100644
--- a/fs/btrfs/raid56.c
+++ b/fs/btrfs/raid56.c
@@ -2392,23 +2392,22 @@ void raid56_add_scrub_pages(struct btrfs_raid_bio *rbio, struct page *page,
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

