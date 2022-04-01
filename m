Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C3A14EEC57
	for <lists+linux-btrfs@lfdr.de>; Fri,  1 Apr 2022 13:24:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345492AbiDALZu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 1 Apr 2022 07:25:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345489AbiDALZq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 1 Apr 2022 07:25:46 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E65F177D0E
        for <linux-btrfs@vger.kernel.org>; Fri,  1 Apr 2022 04:23:57 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 3D7B31FD01
        for <linux-btrfs@vger.kernel.org>; Fri,  1 Apr 2022 11:23:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1648812236; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iv7bkY9R2p/FeFFm1PS2qIRfK6wY/6fphT1N1bw+5Vg=;
        b=EPnJidys35RCsC3QSpKNLQXr0V4cImtXdHZBnlY3/tVe/KpBAR9LpXz3ETyutJ9/uBU+Or
        A7XvjQnvwejpTAyGjdlbiB2GbX5xGp8fegmgUKA9Bpi4+Y1+TR/wjTgFs3On/ZW+TOIK54
        sah4gwQQXo+lOZzV2CKHZCJq3A99FvQ=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 973E3132C1
        for <linux-btrfs@vger.kernel.org>; Fri,  1 Apr 2022 11:23:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 0NhWGcvgRmJeFwAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Fri, 01 Apr 2022 11:23:55 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 07/16] btrfs: make finish_parity_scrub() subpage compatible
Date:   Fri,  1 Apr 2022 19:23:22 +0800
Message-Id: <d0a5f106303ee83daba01f65d6671b011791289a.1648807440.git.wqu@suse.com>
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

The core is to convert direct page usage into sector_ptr usage, and
use memcpy() to replace copy_page().

For pointers usage, we need to convert it to kmap_local_page() +
sector->pgoff.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/raid56.c | 56 +++++++++++++++++++++++++++--------------------
 1 file changed, 32 insertions(+), 24 deletions(-)

diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
index 07d0b26024dd..bd01e64ea4fc 100644
--- a/fs/btrfs/raid56.c
+++ b/fs/btrfs/raid56.c
@@ -2492,14 +2492,15 @@ static noinline void finish_parity_scrub(struct btrfs_raid_bio *rbio,
 					 int need_check)
 {
 	struct btrfs_io_context *bioc = rbio->bioc;
+	const u32 sectorsize = bioc->fs_info->sectorsize;
 	void **pointers = rbio->finish_pointers;
 	unsigned long *pbitmap = rbio->finish_pbitmap;
 	int nr_data = rbio->nr_data;
 	int stripe;
 	int sectornr;
 	bool has_qstripe;
-	struct page *p_page = NULL;
-	struct page *q_page = NULL;
+	struct sector_ptr p_sector = {};
+	struct sector_ptr q_sector = {};
 	struct bio_list bio_list;
 	struct bio *bio;
 	int is_replace = 0;
@@ -2529,51 +2530,56 @@ static noinline void finish_parity_scrub(struct btrfs_raid_bio *rbio,
 	if (!need_check)
 		goto writeback;
 
-	p_page = alloc_page(GFP_NOFS);
-	if (!p_page)
+	p_sector.page = alloc_page(GFP_NOFS);
+	if (!p_sector.page)
 		goto cleanup;
-	SetPageUptodate(p_page);
+	p_sector.pgoff = 0;
+	p_sector.uptodate = 1;
 
 	if (has_qstripe) {
 		/* RAID6, allocate and map temp space for the Q stripe */
-		q_page = alloc_page(GFP_NOFS);
-		if (!q_page) {
-			__free_page(p_page);
+		q_sector.page = alloc_page(GFP_NOFS);
+		if (!q_sector.page) {
+			__free_page(p_sector.page);
+			p_sector.page = NULL;
 			goto cleanup;
 		}
-		SetPageUptodate(q_page);
-		pointers[rbio->real_stripes - 1] = kmap_local_page(q_page);
+		q_sector.pgoff = 0;
+		q_sector.uptodate = 1;
+		pointers[rbio->real_stripes - 1] = kmap_local_page(q_sector.page);
 	}
 
 	atomic_set(&rbio->error, 0);
 
 	/* Map the parity stripe just once */
-	pointers[nr_data] = kmap_local_page(p_page);
+	pointers[nr_data] = kmap_local_page(p_sector.page);
 
 	for_each_set_bit(sectornr, rbio->dbitmap, rbio->stripe_nsectors) {
-		struct page *p;
+		struct sector_ptr *sector;
 		void *parity;
+
 		/* first collect one page from each data stripe */
 		for (stripe = 0; stripe < nr_data; stripe++) {
-			p = page_in_rbio(rbio, stripe, sectornr, 0);
-			pointers[stripe] = kmap_local_page(p);
+			sector = sector_in_rbio(rbio, stripe, sectornr, 0);
+			pointers[stripe] = kmap_local_page(sector->page) +
+					   sector->pgoff;
 		}
 
 		if (has_qstripe) {
 			/* RAID6, call the library function to fill in our P/Q */
-			raid6_call.gen_syndrome(rbio->real_stripes, PAGE_SIZE,
+			raid6_call.gen_syndrome(rbio->real_stripes, sectorsize,
 						pointers);
 		} else {
 			/* raid5 */
-			copy_page(pointers[nr_data], pointers[0]);
-			run_xor(pointers + 1, nr_data - 1, PAGE_SIZE);
+			memcpy(pointers[nr_data], pointers[0], sectorsize);
+			run_xor(pointers + 1, nr_data - 1, sectorsize);
 		}
 
 		/* Check scrubbing parity and repair it */
-		p = rbio_stripe_page(rbio, rbio->scrubp, sectornr);
-		parity = kmap_local_page(p);
-		if (memcmp(parity, pointers[rbio->scrubp], PAGE_SIZE))
-			copy_page(parity, pointers[rbio->scrubp]);
+		sector = rbio_stripe_sector(rbio, rbio->scrubp, sectornr);
+		parity = kmap_local_page(sector->page) + sector->pgoff;
+		if (memcmp(parity, pointers[rbio->scrubp], sectorsize))
+			memcpy(parity, pointers[rbio->scrubp], sectorsize);
 		else
 			/* Parity is right, needn't writeback */
 			bitmap_clear(rbio->dbitmap, sectornr, 1);
@@ -2584,10 +2590,12 @@ static noinline void finish_parity_scrub(struct btrfs_raid_bio *rbio,
 	}
 
 	kunmap_local(pointers[nr_data]);
-	__free_page(p_page);
-	if (q_page) {
+	__free_page(p_sector.page);
+	p_sector.page = NULL;
+	if (q_sector.page) {
 		kunmap_local(pointers[rbio->real_stripes - 1]);
-		__free_page(q_page);
+		__free_page(q_sector.page);
+		q_sector.page = NULL;
 	}
 
 writeback:
-- 
2.35.1

