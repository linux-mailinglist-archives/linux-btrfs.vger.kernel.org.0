Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5855539CD4
	for <lists+linux-btrfs@lfdr.de>; Wed,  1 Jun 2022 07:55:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349751AbiFAFyw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 1 Jun 2022 01:54:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349750AbiFAFyv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 1 Jun 2022 01:54:51 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79A559548F
        for <linux-btrfs@vger.kernel.org>; Tue, 31 May 2022 22:54:49 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 0E1FF21B4F
        for <linux-btrfs@vger.kernel.org>; Wed,  1 Jun 2022 05:54:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1654062888; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=0PoqMGtCTqP42y5+Hp28TNBFPlwcGDmG7zc7AlYNwww=;
        b=StMX6QRJryjWNGAamHyH+PUDrevJYONOs2NybkjTPMn7ES3b54VdUla9AZR/J3obTQ8kc7
        5vRLWOVXcMojEjMjtUzQ8/27Az1Q4HdSCQ5tvNvY/3/U+fIql3f16LoEJ9eTKo18wvfXQ+
        FiqqglPSO1ErWbe4t/zrhhky/fI5A/g=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3710B13443
        for <linux-btrfs@vger.kernel.org>; Wed,  1 Jun 2022 05:54:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id VhA4Oib/lmLeDQAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Wed, 01 Jun 2022 05:54:46 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: update stripe_sectors[]->uptodate in steal_rbio
Date:   Wed,  1 Jun 2022 13:54:28 +0800
Message-Id: <e7fce81204d47e527e3d6d34ebcd9c9a1b281533.1654062760.git.wqu@suse.com>
X-Mailer: git-send-email 2.36.1
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

[BUG]
With recent debug output patch, it turns out the following write
sequence would cause extra read which is unnecessary:

  # xfs_io -f -s -c "pwrite -b 32k 0 32k" -c "pwrite -b 32k 32k 32k" \
		 -c "pwrite -b 32k 64k 32k" -c "pwrite -b 32k 96k 32k" \
		 $mnt/file

The debug message looks like this (btrfs header skipped):

 partial rmw, full stripe=389152768 opf=0x0 devid=3 type=1 offset=32768 physical=323059712 len=32768
 partial rmw, full stripe=389152768 opf=0x0 devid=1 type=2 offset=0 physical=67174400 len=65536
 full stripe rmw, full stripe=389152768 opf=0x1 devid=3 type=1 offset=0 physical=323026944 len=32768
 full stripe rmw, full stripe=389152768 opf=0x1 devid=2 type=-1 offset=0 physical=323026944 len=32768
 partial rmw, full stripe=298844160 opf=0x0 devid=1 type=1 offset=32768 physical=22052864 len=32768
 partial rmw, full stripe=298844160 opf=0x0 devid=2 type=2 offset=0 physical=277872640 len=65536
 full stripe rmw, full stripe=298844160 opf=0x1 devid=1 type=1 offset=0 physical=22020096 len=32768
 full stripe rmw, full stripe=298844160 opf=0x1 devid=3 type=-1 offset=0 physical=277872640 len=32768
 partial rmw, full stripe=389152768 opf=0x0 devid=3 type=1 offset=0 physical=323026944 len=32768
 partial rmw, full stripe=389152768 opf=0x0 devid=1 type=2 offset=0 physical=67174400 len=65536
 ^^^^
  Still partial read, even 389152768 is already cached by the first.
  write.

 full stripe rmw, full stripe=389152768 opf=0x1 devid=3 type=1 offset=32768 physical=323059712 len=32768
 full stripe rmw, full stripe=389152768 opf=0x1 devid=2 type=-1 offset=32768 physical=323059712 len=32768
 partial rmw, full stripe=298844160 opf=0x0 devid=1 type=1 offset=0 physical=22020096 len=32768
 partial rmw, full stripe=298844160 opf=0x0 devid=2 type=2 offset=0 physical=277872640 len=65536
 ^^^^
  Still partial read for 298844160.

 full stripe rmw, full stripe=298844160 opf=0x1 devid=1 type=1 offset=32768 physical=22052864 len=32768
 full stripe rmw, full stripe=298844160 opf=0x1 devid=3 type=-1 offset=32768 physical=277905408 len=32768

This means every 32K writes, even they are in the same full stripe,
still trigger read for previously cached data.

This would cause extra RAID56 IO, making the btrfs raid56 cache useless.

[CAUSE]
Commit d4e28d9b5f04 ("btrfs: raid56: make steal_rbio() subpage
compatible") tries to make steal_rbio() subpage compatible, but during
that conversion, there is one thing missing.

We no longer rely on PageUptodate(rbio->stripe_pages[i]), but
rbio->stripe_nsectors[i].uptodate to determine if a sector is uptodate.

This means, previously if we switch the pointer, everything is done,
as the PageUptodate flag is still bond to that page.

But now we have to manually mark the involved sectors uptodate, or later
raid56_rmw_stripe() will find the stolen sector is not uptodate, and
assemble the read bio for it, wasting IO.

[FIX]
We can easily fix the bug, by also update the
rbio->stripe_sectors[].uptodate in steal_rbio().

With this fixed, now the same write patter no longer leads to the same
unnecessary read:

 partial rmw, full stripe=389152768 opf=0x0 devid=3 type=1 offset=32768 physical=323059712 len=32768
 partial rmw, full stripe=389152768 opf=0x0 devid=1 type=2 offset=0 physical=67174400 len=65536
 full stripe rmw, full stripe=389152768 opf=0x1 devid=3 type=1 offset=0 physical=323026944 len=32768
 full stripe rmw, full stripe=389152768 opf=0x1 devid=2 type=-1 offset=0 physical=323026944 len=32768
 partial rmw, full stripe=298844160 opf=0x0 devid=1 type=1 offset=32768 physical=22052864 len=32768
 partial rmw, full stripe=298844160 opf=0x0 devid=2 type=2 offset=0 physical=277872640 len=65536
 full stripe rmw, full stripe=298844160 opf=0x1 devid=1 type=1 offset=0 physical=22020096 len=32768
 full stripe rmw, full stripe=298844160 opf=0x1 devid=3 type=-1 offset=0 physical=277872640 len=32768
 ^^^ No more partial read, directly into the write path.
 full stripe rmw, full stripe=389152768 opf=0x1 devid=3 type=1 offset=32768 physical=323059712 len=32768
 full stripe rmw, full stripe=389152768 opf=0x1 devid=2 type=-1 offset=32768 physical=323059712 len=32768
 full stripe rmw, full stripe=298844160 opf=0x1 devid=1 type=1 offset=32768 physical=22052864 len=32768
 full stripe rmw, full stripe=298844160 opf=0x1 devid=3 type=-1 offset=32768 physical=277905408 len=32768

Fixes: d4e28d9b5f04 ("btrfs: raid56: make steal_rbio() subpage compatible")
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/raid56.c | 26 +++++++++++++++++++-------
 1 file changed, 19 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
index def0075e4938..db913eab9fa4 100644
--- a/fs/btrfs/raid56.c
+++ b/fs/btrfs/raid56.c
@@ -348,6 +348,24 @@ static void index_stripe_sectors(struct btrfs_raid_bio *rbio)
 	}
 }
 
+static void steal_rbio_page(struct btrfs_raid_bio *src,
+			    struct btrfs_raid_bio *dest, int page_nr)
+{
+	const u32 sectorsize = src->bioc->fs_info->sectorsize;
+	const u32 sectors_per_page = PAGE_SIZE / sectorsize;
+	int i;
+
+	if (dest->stripe_pages[page_nr])
+		__free_page(dest->stripe_pages[page_nr]);
+	dest->stripe_pages[page_nr] = src->stripe_pages[page_nr];
+	src->stripe_pages[page_nr] = NULL;
+
+	/* Also update the sector->uptodate bits. */
+	for (i = sectors_per_page * page_nr;
+	     i < sectors_per_page * page_nr + sectors_per_page; i++)
+		dest->stripe_sectors[i].uptodate = true;
+}
+
 /*
  * Stealing an rbio means taking all the uptodate pages from the stripe array
  * in the source rbio and putting them into the destination rbio.
@@ -359,7 +377,6 @@ static void steal_rbio(struct btrfs_raid_bio *src, struct btrfs_raid_bio *dest)
 {
 	int i;
 	struct page *s;
-	struct page *d;
 
 	if (!test_bit(RBIO_CACHE_READY_BIT, &src->flags))
 		return;
@@ -369,12 +386,7 @@ static void steal_rbio(struct btrfs_raid_bio *src, struct btrfs_raid_bio *dest)
 		if (!s || !full_page_sectors_uptodate(src, i))
 			continue;
 
-		d = dest->stripe_pages[i];
-		if (d)
-			__free_page(d);
-
-		dest->stripe_pages[i] = s;
-		src->stripe_pages[i] = NULL;
+		steal_rbio_page(src, dest, i);
 	}
 	index_stripe_sectors(dest);
 	index_stripe_sectors(src);
-- 
2.36.1

