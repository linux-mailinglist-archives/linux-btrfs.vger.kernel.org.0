Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A0134EEC4F
	for <lists+linux-btrfs@lfdr.de>; Fri,  1 Apr 2022 13:24:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345513AbiDALZy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 1 Apr 2022 07:25:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345496AbiDALZv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 1 Apr 2022 07:25:51 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C68061959C7
        for <linux-btrfs@vger.kernel.org>; Fri,  1 Apr 2022 04:23:58 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 3E4C521612
        for <linux-btrfs@vger.kernel.org>; Fri,  1 Apr 2022 11:23:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1648812237; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=49awc+lRl4v9J/vZKhVCSgoJHwi/zDzavqfe1VlpH5M=;
        b=BuNcIiIknNbMTCH1FFy6UH28Rqq15JyP9q080jNGxfdFAebPkOw9RyxGkbny5PsZo6jwUQ
        ElXXFPuBWFSmbUn6nZgDj4YgPOVh+raYPKLIpGAuDEVSH1hp8d97JgC4DMrXTILSJDHVyi
        RzGRydSvy2EblAxU1HY1kjsgxxAOa68=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9A7C6132C1
        for <linux-btrfs@vger.kernel.org>; Fri,  1 Apr 2022 11:23:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id AGtnGczgRmJeFwAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Fri, 01 Apr 2022 11:23:56 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 08/16] btrfs: make __raid_recover_endio_io() subpage compatibable
Date:   Fri,  1 Apr 2022 19:23:23 +0800
Message-Id: <c9b9956372cb15890ddb172826c9a3e25aeffda3.1648807440.git.wqu@suse.com>
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

One trick involved is, since our pointers[] array has to have
sector::pgoff added, we can no longer use the address to unmap the page.

Thankfully we have another array for kunmap_local, so those two arrays
are no longer containing the same values, even before the rotation.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/raid56.c | 57 ++++++++++++++++++++++++++---------------------
 1 file changed, 32 insertions(+), 25 deletions(-)

diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
index bd01e64ea4fc..1fbeaf2909b4 100644
--- a/fs/btrfs/raid56.c
+++ b/fs/btrfs/raid56.c
@@ -1947,20 +1947,24 @@ int raid56_parity_write(struct bio *bio, struct btrfs_io_context *bioc,
 }
 
 /*
- * all parity reconstruction happens here.  We've read in everything
+ * All parity reconstruction happens here.  We've read in everything
  * we can find from the drives and this does the heavy lifting of
  * sorting the good from the bad.
  */
 static void __raid_recover_end_io(struct btrfs_raid_bio *rbio)
 {
-	int pagenr, stripe;
+	const u32 sectorsize = rbio->bioc->fs_info->sectorsize;
+	int sectornr, stripe;
 	void **pointers;
 	void **unmap_array;
 	int faila = -1, failb = -1;
-	struct page *page;
 	blk_status_t err;
 	int i;
 
+	/*
+	 * This array stores the pointer for each sector, thus it has the extra
+	 * pgoff value added from each sector
+	 */
 	pointers = kcalloc(rbio->real_stripes, sizeof(void *), GFP_NOFS);
 	if (!pointers) {
 		err = BLK_STS_RESOURCE;
@@ -1970,6 +1974,8 @@ static void __raid_recover_end_io(struct btrfs_raid_bio *rbio)
 	/*
 	 * Store copy of pointers that does not get reordered during
 	 * reconstruction so that kunmap_local works.
+	 * This array doesn't have pgoff added so we can safely call kunmap_local
+	 * on it.
 	 */
 	unmap_array = kcalloc(rbio->real_stripes, sizeof(void *), GFP_NOFS);
 	if (!unmap_array) {
@@ -1989,43 +1995,43 @@ static void __raid_recover_end_io(struct btrfs_raid_bio *rbio)
 
 	index_rbio_pages(rbio);
 
-	for (pagenr = 0; pagenr < rbio->stripe_npages; pagenr++) {
+	for (sectornr = 0; sectornr < rbio->stripe_nsectors; sectornr++) {
+		struct sector_ptr *sector;
+
 		/*
 		 * Now we just use bitmap to mark the horizontal stripes in
 		 * which we have data when doing parity scrub.
 		 */
 		if (rbio->operation == BTRFS_RBIO_PARITY_SCRUB &&
-		    !test_bit(pagenr, rbio->dbitmap))
+		    !test_bit(sectornr, rbio->dbitmap))
 			continue;
 
 		/*
-		 * Setup our array of pointers with pages from each stripe
+		 * Setup our array of pointers with sectors from each stripe
 		 *
 		 * NOTE: store a duplicate array of pointers to preserve the
 		 * pointer order
 		 */
 		for (stripe = 0; stripe < rbio->real_stripes; stripe++) {
 			/*
-			 * if we're rebuilding a read, we have to use
+			 * If we're rebuilding a read, we have to use
 			 * pages from the bio list
 			 */
 			if ((rbio->operation == BTRFS_RBIO_READ_REBUILD ||
 			     rbio->operation == BTRFS_RBIO_REBUILD_MISSING) &&
 			    (stripe == faila || stripe == failb)) {
-				page = page_in_rbio(rbio, stripe, pagenr, 0);
+				sector = sector_in_rbio(rbio, stripe, sectornr, 0);
 			} else {
-				page = rbio_stripe_page(rbio, stripe, pagenr);
+				sector = rbio_stripe_sector(rbio, stripe, sectornr);
 			}
-			pointers[stripe] = kmap_local_page(page);
-			unmap_array[stripe] = pointers[stripe];
+			ASSERT(sector->page);
+			unmap_array[stripe] = kmap_local_page(sector->page);
+			pointers[stripe] = unmap_array[stripe] + sector->pgoff;
 		}
 
-		/* all raid6 handling here */
+		/* All raid6 handling here */
 		if (rbio->bioc->map_type & BTRFS_BLOCK_GROUP_RAID6) {
-			/*
-			 * single failure, rebuild from parity raid5
-			 * style
-			 */
+			/* Single failure, rebuild from parity raid5 style */
 			if (failb < 0) {
 				if (faila == rbio->nr_data) {
 					/*
@@ -2068,10 +2074,10 @@ static void __raid_recover_end_io(struct btrfs_raid_bio *rbio)
 
 			if (rbio->bioc->raid_map[failb] == RAID5_P_STRIPE) {
 				raid6_datap_recov(rbio->real_stripes,
-						  PAGE_SIZE, faila, pointers);
+						  sectorsize, faila, pointers);
 			} else {
 				raid6_2data_recov(rbio->real_stripes,
-						  PAGE_SIZE, faila, failb,
+						  sectorsize, faila, failb,
 						  pointers);
 			}
 		} else {
@@ -2081,7 +2087,8 @@ static void __raid_recover_end_io(struct btrfs_raid_bio *rbio)
 			BUG_ON(failb != -1);
 pstripe:
 			/* Copy parity block into failed block to start with */
-			copy_page(pointers[faila], pointers[rbio->nr_data]);
+			memcpy(pointers[faila], pointers[rbio->nr_data],
+			       sectorsize);
 
 			/* rearrange the pointer array */
 			p = pointers[faila];
@@ -2090,7 +2097,7 @@ static void __raid_recover_end_io(struct btrfs_raid_bio *rbio)
 			pointers[rbio->nr_data - 1] = p;
 
 			/* xor in the rest */
-			run_xor(pointers, rbio->nr_data - 1, PAGE_SIZE);
+			run_xor(pointers, rbio->nr_data - 1, sectorsize);
 		}
 		/* if we're doing this rebuild as part of an rmw, go through
 		 * and set all of our private rbio pages in the
@@ -2099,14 +2106,14 @@ static void __raid_recover_end_io(struct btrfs_raid_bio *rbio)
 		 * other endio functions will fiddle the uptodate bits
 		 */
 		if (rbio->operation == BTRFS_RBIO_WRITE) {
-			for (i = 0;  i < rbio->stripe_npages; i++) {
+			for (i = 0;  i < rbio->stripe_nsectors; i++) {
 				if (faila != -1) {
-					page = rbio_stripe_page(rbio, faila, i);
-					SetPageUptodate(page);
+					sector = rbio_stripe_sector(rbio, faila, i);
+					sector->uptodate = 1;
 				}
 				if (failb != -1) {
-					page = rbio_stripe_page(rbio, failb, i);
-					SetPageUptodate(page);
+					sector = rbio_stripe_sector(rbio, failb, i);
+					sector->uptodate = 1;
 				}
 			}
 		}
-- 
2.35.1

