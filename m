Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88255743204
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 Jun 2023 02:57:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231804AbjF3A5E (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 29 Jun 2023 20:57:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231361AbjF3A5C (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 29 Jun 2023 20:57:02 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A0D41FC3
        for <linux-btrfs@vger.kernel.org>; Thu, 29 Jun 2023 17:57:00 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id EED7E21853
        for <linux-btrfs@vger.kernel.org>; Fri, 30 Jun 2023 00:56:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1688086617; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=QDYXopZ3ASNq6fGcRHOz4Qmem0Qx4OQPs4nXzCx0Xfc=;
        b=UAx9TqfvlRrKSWxsof5RSX5nXCv9yFiiEJ8Qy6Db1aGlrc0MeJmwXxjV84c4cHNFx0mdtg
        qYg5trS4YqO7LrRY1Rbm6h8Ly0iZZQz3bQxvh+MaWIF85KkU8JGlhKNDs/5XZmgVc30f6E
        0QCRj3h2wmy6Sqcxxu9fPkZnBcukPcU=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 636291391D
        for <linux-btrfs@vger.kernel.org>; Fri, 30 Jun 2023 00:56:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 2m55DVkonmTmIgAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Fri, 30 Jun 2023 00:56:57 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: raid56: always verify the P/Q contents for scrub
Date:   Fri, 30 Jun 2023 08:56:40 +0800
Message-ID: <9874fb351e4374c925d00f9cc1b56730f5d64067.1688086590.git.wqu@suse.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[REGRESSION]
Commit 75b470332965 ("btrfs: raid56: migrate recovery and scrub recovery
path to use error_bitmap") changed the behavior of scrub_rbio().

Initially if we have no error reading the raid bio, we will assign
@need_check to true, then finish_parity_scrub() would later verify the
content of P/Q stripes before writeback.

But after that commit we never verify the content of P/Q stripes and
just writeback them.

This can lead to unrepaired P/Q stripes during scrub, or already
corrupted P/Q copied to the dev-replace target.

[FIX]
The situation is more complex than the regression, in fact the initial
behavior is not 100% correct either.

If we have the following rare case, it can still lead to the same
problem using the old behavior:

		0	16K	32K	48K	64K
	Data 1:	|IIIIIII|                       |
	Data 2:	|				|
	Parity:	|	|CCCCCCC|		|

Where "I" means IO error, "C" means corruption.

In the above case, we're scrubbing the parity stripe, then read out all
the contents of Data 1, Data 2, Parity stripes.

But found IO error in Data 1, which leads to rebuild using Data 2 and
Parity and got the correct data.

In that case, we would not verify if the Pairty is correct for range
[16K, 32K).

So here we have to always verify the content of Parity no matter if we
did recovery or not.

This patch would remove the @need_check parameter of
finish_parity_scrub() completely, and would always do the P/Q
verification before writeback.

Fixes: 75b470332965 ("btrfs: raid56: migrate recovery and scrub recovery path to use error_bitmap")
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/raid56.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
index ed7235a73485..f61f82febe98 100644
--- a/fs/btrfs/raid56.c
+++ b/fs/btrfs/raid56.c
@@ -71,7 +71,7 @@ static void rmw_rbio_work_locked(struct work_struct *work);
 static void index_rbio_pages(struct btrfs_raid_bio *rbio);
 static int alloc_rbio_pages(struct btrfs_raid_bio *rbio);
 
-static int finish_parity_scrub(struct btrfs_raid_bio *rbio, int need_check);
+static int finish_parity_scrub(struct btrfs_raid_bio *rbio);
 static void scrub_rbio_work_locked(struct work_struct *work);
 
 static void free_raid_bio_pointers(struct btrfs_raid_bio *rbio)
@@ -2429,7 +2429,7 @@ static int alloc_rbio_essential_pages(struct btrfs_raid_bio *rbio)
 	return 0;
 }
 
-static int finish_parity_scrub(struct btrfs_raid_bio *rbio, int need_check)
+static int finish_parity_scrub(struct btrfs_raid_bio *rbio)
 {
 	struct btrfs_io_context *bioc = rbio->bioc;
 	const u32 sectorsize = bioc->fs_info->sectorsize;
@@ -2470,9 +2470,6 @@ static int finish_parity_scrub(struct btrfs_raid_bio *rbio, int need_check)
 	 */
 	clear_bit(RBIO_CACHE_READY_BIT, &rbio->flags);
 
-	if (!need_check)
-		goto writeback;
-
 	p_sector.page = alloc_page(GFP_NOFS);
 	if (!p_sector.page)
 		return -ENOMEM;
@@ -2541,7 +2538,6 @@ static int finish_parity_scrub(struct btrfs_raid_bio *rbio, int need_check)
 		q_sector.page = NULL;
 	}
 
-writeback:
 	/*
 	 * time to start writing.  Make bios for everything from the
 	 * higher layers (the bio_list in our rbio) and our p/q.  Ignore
@@ -2724,7 +2720,6 @@ static int scrub_assemble_read_bios(struct btrfs_raid_bio *rbio)
 
 static void scrub_rbio(struct btrfs_raid_bio *rbio)
 {
-	bool need_check = false;
 	int sector_nr;
 	int ret;
 
@@ -2747,7 +2742,7 @@ static void scrub_rbio(struct btrfs_raid_bio *rbio)
 	 * We have every sector properly prepared. Can finish the scrub
 	 * and writeback the good content.
 	 */
-	ret = finish_parity_scrub(rbio, need_check);
+	ret = finish_parity_scrub(rbio);
 	wait_event(rbio->io_wait, atomic_read(&rbio->stripes_pending) == 0);
 	for (sector_nr = 0; sector_nr < rbio->stripe_nsectors; sector_nr++) {
 		int found_errors;
-- 
2.41.0

