Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 964CA4FDCB3
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Apr 2022 13:06:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351959AbiDLKiP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 12 Apr 2022 06:38:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354417AbiDLKdj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 12 Apr 2022 06:33:39 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85C7756228
        for <linux-btrfs@vger.kernel.org>; Tue, 12 Apr 2022 02:33:36 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 456DA210EC
        for <linux-btrfs@vger.kernel.org>; Tue, 12 Apr 2022 09:33:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1649756015; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IXuf5ecR6K1Nyrr+m+JNb24bE+JFGPep4/MStRWX3iM=;
        b=ua8gb1V1GaI1F0d/cIx04BQupOEF/6O14ApMQ+L5eegRoXwI9qPYDU34e8bpLM0zwWnzLu
        OVeltILfN94OEkbeTeQjwB6JA0tApFeO6B3D2VWgGwmLaIkNNIyZWqYLNhgEOkPrtbzMsM
        EFinoryiyS3Uri/PBKTeZOXHx9dC6so=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8F44D13A99
        for <linux-btrfs@vger.kernel.org>; Tue, 12 Apr 2022 09:33:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id GJQ5FW5HVWI8LwAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Tue, 12 Apr 2022 09:33:34 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 08/17] btrfs: make finish_parity_scrub() subpage compatible
Date:   Tue, 12 Apr 2022 17:32:58 +0800
Message-Id: <5c484dda324a1648a8f853d08ab2f3b6c8f58fe4.1649753690.git.wqu@suse.com>
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

The core is to convert direct page usage into sector_ptr usage, and
use memcpy() to replace copy_page().

For pointers usage, we need to convert it to kmap_local_page() +
sector->pgoff.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/raid56.c | 56 +++++++++++++++++++++++++++--------------------
 1 file changed, 32 insertions(+), 24 deletions(-)

diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
index 9c3e0201d032..6b2d75a09896 100644
--- a/fs/btrfs/raid56.c
+++ b/fs/btrfs/raid56.c
@@ -2467,14 +2467,15 @@ static noinline void finish_parity_scrub(struct btrfs_raid_bio *rbio,
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
+	struct sector_ptr p_sector = { 0 };
+	struct sector_ptr q_sector = { 0 };
 	struct bio_list bio_list;
 	struct bio *bio;
 	int is_replace = 0;
@@ -2504,51 +2505,56 @@ static noinline void finish_parity_scrub(struct btrfs_raid_bio *rbio,
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
@@ -2559,10 +2565,12 @@ static noinline void finish_parity_scrub(struct btrfs_raid_bio *rbio,
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

