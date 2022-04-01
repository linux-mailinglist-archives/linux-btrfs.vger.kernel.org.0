Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3EE34EEC59
	for <lists+linux-btrfs@lfdr.de>; Fri,  1 Apr 2022 13:24:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345518AbiDALZ7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 1 Apr 2022 07:25:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345509AbiDALZy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 1 Apr 2022 07:25:54 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 421B31965DE
        for <linux-btrfs@vger.kernel.org>; Fri,  1 Apr 2022 04:24:05 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 05A0821A99
        for <linux-btrfs@vger.kernel.org>; Fri,  1 Apr 2022 11:24:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1648812244; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oBPorPRJMRt09PCD+zNPK08jHq7u3SOKrSds9wowlew=;
        b=cNpbofNXEC9GDQ1+ChTqgHN93nsQ+wZB86Vie5EhzJWqI4YlZ2Fw4CD2dIOvKs+0XHOSYs
        PXcC/pvQKxfWP4xbVm7s16aPHY8H6xsfEcKVBWWnO9ic4bPVYUl3cDPC9mdjIpmlKgtx34
        31iPZNTdCh8f73RN3W9IXI6z4jTHWU8=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 652B1132C1
        for <linux-btrfs@vger.kernel.org>; Fri,  1 Apr 2022 11:24:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id eDb/C9PgRmJeFwAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Fri, 01 Apr 2022 11:24:03 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 14/16] btrfs: make steal_rbio() subpage compatible
Date:   Fri,  1 Apr 2022 19:23:29 +0800
Message-Id: <a0d5067f58018fcb833a26d44d90bd58492ea67e.1648807440.git.wqu@suse.com>
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

Function steal_rbio() will taking all the uptodate pages from the source
rbio to destination rbio.

With the new stripe_sectors[] array, we also need to do the extra check:

- Check sector::flags to make sure the full page is uptodate
  Now we don't use PageUptodate flag for subpage cases to indicate
  if the page is uptodate.

  Instead we need to check all the sectors belong to the page to be sure
  about whether it's full page uptodate.

  So here we introduce a new helper, full_page_sectors_uptodate() to do
  the check.

- Update rbio::stripe_sectors[] to use the new page pointer
  We only need to change the page pointer, no need to change anything
  else.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/raid56.c | 27 ++++++++++++++++++++++++---
 1 file changed, 24 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
index b57be9387740..01fe5414e013 100644
--- a/fs/btrfs/raid56.c
+++ b/fs/btrfs/raid56.c
@@ -310,6 +310,25 @@ static int rbio_bucket(struct btrfs_raid_bio *rbio)
 	return hash_64(num >> 16, BTRFS_STRIPE_HASH_TABLE_BITS);
 }
 
+static bool full_page_sectors_uptodate(struct btrfs_raid_bio *rbio,
+				       unsigned int page_nr)
+{
+	const u32 sectorsize = rbio->bioc->fs_info->sectorsize;
+	const u32 sectors_per_page = PAGE_SIZE / sectorsize;
+	bool uptodate = true;
+	int i;
+
+	ASSERT(page_nr < rbio->nr_pages);
+
+	for (i = sectors_per_page * page_nr;
+	     i < sectors_per_page * page_nr + sectors_per_page; i++) {
+		if (!rbio->stripe_sectors[i].uptodate) {
+			uptodate = false;
+			break;
+		}
+	}
+	return uptodate;
+}
 /*
  * Update the stripe_sectors[] array to use correct page and pgoff
  *
@@ -331,8 +350,11 @@ static void index_stripe_sectors(struct btrfs_raid_bio *rbio)
 }
 
 /*
- * stealing an rbio means taking all the uptodate pages from the stripe
+ * Stealing an rbio means taking all the uptodate pages from the stripe
  * array in the source rbio and putting them into the destination rbio
+ *
+ * This will also update the involved stripe_sectors[] which are referring to
+ * the old pages.
  */
 static void steal_rbio(struct btrfs_raid_bio *src, struct btrfs_raid_bio *dest)
 {
@@ -345,9 +367,8 @@ static void steal_rbio(struct btrfs_raid_bio *src, struct btrfs_raid_bio *dest)
 
 	for (i = 0; i < dest->nr_pages; i++) {
 		s = src->stripe_pages[i];
-		if (!s || !PageUptodate(s)) {
+		if (!s || !full_page_sectors_uptodate(src, i))
 			continue;
-		}
 
 		d = dest->stripe_pages[i];
 		if (d)
-- 
2.35.1

