Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 958024FDCBD
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Apr 2022 13:06:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353938AbiDLKie (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 12 Apr 2022 06:38:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354535AbiDLKdl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 12 Apr 2022 06:33:41 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 444B85643E
        for <linux-btrfs@vger.kernel.org>; Tue, 12 Apr 2022 02:33:43 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 01C4A21608
        for <linux-btrfs@vger.kernel.org>; Tue, 12 Apr 2022 09:33:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1649756022; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rXWvSxUUm9oXDIpljbPrcYj/ac8pdBPkaz35zqdU1Ao=;
        b=ISiRyiRYlLqAS85GRs8X7G6eeVsZdwXUe2SuGL5pEvo5y79CVN8r+2l9q3Ix41dpD2J+y0
        iovzjBgGC8KAR4PniA4foGOXcyy31vMZEZYO34ttixB+fwix1FrcEh1I4H8qnEiA559ia6
        mMpZZudKeBGhm+cy2sy3sUExx0cmcN8=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4F03013A99
        for <linux-btrfs@vger.kernel.org>; Tue, 12 Apr 2022 09:33:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id sFnrBXVHVWI8LwAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Tue, 12 Apr 2022 09:33:41 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 14/17] btrfs: make set_bio_pages_uptodate() subpage compatible
Date:   Tue, 12 Apr 2022 17:33:04 +0800
Message-Id: <c83a07af72d774e9d08e8c5e1f9f7c981c168cb4.1649753690.git.wqu@suse.com>
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

Unlike previous code, we can not directly set PageUptodate for stripe
pages now.

Instead we have to iterate through all the sectors and set
SECTOR_UPTODATE flag there.

Thus this patch introduced a new helper, find_stripe_sector(), to do the
work.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/raid56.c | 45 +++++++++++++++++++++++++++++++++++++++------
 1 file changed, 39 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
index af8ba1aff682..8de5294de7a5 100644
--- a/fs/btrfs/raid56.c
+++ b/fs/btrfs/raid56.c
@@ -1491,19 +1491,52 @@ static int fail_bio_stripe(struct btrfs_raid_bio *rbio,
 	return fail_rbio_index(rbio, failed);
 }
 
+/*
+ * For subpage case, we can no longer set page Uptodate directly for
+ * stripe_pages[], thus we need to locate the sector.
+ */
+static struct sector_ptr *find_stripe_sector(struct btrfs_raid_bio *rbio,
+					     struct page *page,
+					     unsigned int pgoff)
+{
+	int i;
+
+	for (i = 0; i < rbio->nr_sectors; i++) {
+		struct sector_ptr *sector = &rbio->stripe_sectors[i];
+
+		if (sector->page == page && sector->pgoff == pgoff)
+			return sector;
+	}
+	return NULL;
+}
+
 /*
  * this sets each page in the bio uptodate.  It should only be used on private
  * rbio pages, nothing that comes in from the higher layers
  */
-static void set_bio_pages_uptodate(struct bio *bio)
+static void set_bio_pages_uptodate(struct btrfs_raid_bio *rbio,
+				   struct bio *bio)
 {
+	const u32 sectorsize = rbio->bioc->fs_info->sectorsize;
 	struct bio_vec *bvec;
 	struct bvec_iter_all iter_all;
 
 	ASSERT(!bio_flagged(bio, BIO_CLONED));
 
-	bio_for_each_segment_all(bvec, bio, iter_all)
-		SetPageUptodate(bvec->bv_page);
+	bio_for_each_segment_all(bvec, bio, iter_all) {
+		struct sector_ptr *sector;
+		int pgoff;
+
+		for (pgoff = bvec->bv_offset;
+		     pgoff - bvec->bv_offset < bvec->bv_len;
+		     pgoff += sectorsize) {
+			sector = find_stripe_sector(rbio, bvec->bv_page, pgoff);
+			ASSERT(sector);
+			if (sector)
+				sector->uptodate = 1;
+		}
+
+	}
 }
 
 /*
@@ -1521,7 +1554,7 @@ static void raid_rmw_end_io(struct bio *bio)
 	if (bio->bi_status)
 		fail_bio_stripe(rbio, bio);
 	else
-		set_bio_pages_uptodate(bio);
+		set_bio_pages_uptodate(rbio, bio);
 
 	bio_put(bio);
 
@@ -2079,7 +2112,7 @@ static void raid_recover_end_io(struct bio *bio)
 	if (bio->bi_status)
 		fail_bio_stripe(rbio, bio);
 	else
-		set_bio_pages_uptodate(bio);
+		set_bio_pages_uptodate(rbio, bio);
 	bio_put(bio);
 
 	if (!atomic_dec_and_test(&rbio->stripes_pending))
@@ -2637,7 +2670,7 @@ static void raid56_parity_scrub_end_io(struct bio *bio)
 	if (bio->bi_status)
 		fail_bio_stripe(rbio, bio);
 	else
-		set_bio_pages_uptodate(bio);
+		set_bio_pages_uptodate(rbio, bio);
 
 	bio_put(bio);
 
-- 
2.35.1

