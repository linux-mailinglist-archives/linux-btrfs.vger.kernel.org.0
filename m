Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 437D04EEC5E
	for <lists+linux-btrfs@lfdr.de>; Fri,  1 Apr 2022 13:24:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345509AbiDAL0A (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 1 Apr 2022 07:26:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345504AbiDALZy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 1 Apr 2022 07:25:54 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40FCD196137
        for <linux-btrfs@vger.kernel.org>; Fri,  1 Apr 2022 04:24:04 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 0237F1FD00
        for <linux-btrfs@vger.kernel.org>; Fri,  1 Apr 2022 11:24:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1648812243; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xbMISMu6cZDN7dPoM4O9ripxtUZMgAhURkuM8fffVVc=;
        b=PS/tP8khG8f/J/ItT6+OwNHssTg1XUWe7Hh6n2cjHuEZ2PtROSIRKgt/uFbDTMise8L4xV
        tprJpE7UmGPnKna1MAV+DD0rW0LN+GY6ndXVd2tkqGvdSWDp+qbHYuS7g8uV95nIyfpK0t
        BdEGtqEHcLilrxXk9fEomGkB4apNL4Y=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5FF45132C1
        for <linux-btrfs@vger.kernel.org>; Fri,  1 Apr 2022 11:24:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ELIPC9LgRmJeFwAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Fri, 01 Apr 2022 11:24:02 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 13/16] btrfs: make set_bio_pages_uptodate() subpage compatible
Date:   Fri,  1 Apr 2022 19:23:28 +0800
Message-Id: <4fe4a608f6f753e694cd1ac068d97ad414e64895.1648807440.git.wqu@suse.com>
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
index b45f63b40131..b57be9387740 100644
--- a/fs/btrfs/raid56.c
+++ b/fs/btrfs/raid56.c
@@ -1522,19 +1522,52 @@ static int fail_bio_stripe(struct btrfs_raid_bio *rbio,
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
@@ -1552,7 +1585,7 @@ static void raid_rmw_end_io(struct bio *bio)
 	if (bio->bi_status)
 		fail_bio_stripe(rbio, bio);
 	else
-		set_bio_pages_uptodate(bio);
+		set_bio_pages_uptodate(rbio, bio);
 
 	bio_put(bio);
 
@@ -2112,7 +2145,7 @@ static void raid_recover_end_io(struct bio *bio)
 	if (bio->bi_status)
 		fail_bio_stripe(rbio, bio);
 	else
-		set_bio_pages_uptodate(bio);
+		set_bio_pages_uptodate(rbio, bio);
 	bio_put(bio);
 
 	if (!atomic_dec_and_test(&rbio->stripes_pending))
@@ -2672,7 +2705,7 @@ static void raid56_parity_scrub_end_io(struct bio *bio)
 	if (bio->bi_status)
 		fail_bio_stripe(rbio, bio);
 	else
-		set_bio_pages_uptodate(bio);
+		set_bio_pages_uptodate(rbio, bio);
 
 	bio_put(bio);
 
-- 
2.35.1

