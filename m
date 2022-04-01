Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E1114EEC4E
	for <lists+linux-btrfs@lfdr.de>; Fri,  1 Apr 2022 13:24:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345448AbiDALZq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 1 Apr 2022 07:25:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345489AbiDALZo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 1 Apr 2022 07:25:44 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76451191400
        for <linux-btrfs@vger.kernel.org>; Fri,  1 Apr 2022 04:23:55 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 34A771FD04
        for <linux-btrfs@vger.kernel.org>; Fri,  1 Apr 2022 11:23:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1648812234; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wbLLVgAaubLWttAvjA3e0Nk27gjYL9Rx4JA147q9S3w=;
        b=RnzoWcITO3lvDn/SJMZiDdFqk3Wjvljuw4ndOM1w3XtqAO5lnF7CkOi+uUjb9G5yadP2Yx
        D4q3Whxs8kBpHzMiELbLSso0panrhhbLApACeyDuZhxaLJ5YnwCxuom12teFf2ef35uDpK
        yRGbzTZdOzu8Ke/RA2xrrAnZACDuiqU=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8F358132C1
        for <linux-btrfs@vger.kernel.org>; Fri,  1 Apr 2022 11:23:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id uCiGFsngRmJeFwAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Fri, 01 Apr 2022 11:23:53 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 05/16] btrfs: introduce btrfs_raid_bio::bio_sectors
Date:   Fri,  1 Apr 2022 19:23:20 +0800
Message-Id: <5737a015d302fb7cb3774deb3115f0e8a26258db.1648807440.git.wqu@suse.com>
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

This new member is going to fully replace bio_pages in the future, but
for now let's keep them co-exist, until the full switch is done.

Currently cache_rbio_pages() and index_rbio_pages() will also populate
the new array.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/raid56.c | 54 ++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 53 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
index 8cfe00db79c9..f23fd282d298 100644
--- a/fs/btrfs/raid56.c
+++ b/fs/btrfs/raid56.c
@@ -60,6 +60,7 @@ struct btrfs_stripe_hash_table {
 struct sector_ptr {
 	struct page *page;
 	unsigned int pgoff;
+	unsigned int uptodate:1;
 } __attribute__ ((__packed__));
 
 enum btrfs_rbio_ops {
@@ -175,6 +176,9 @@ struct btrfs_raid_bio {
 	 */
 	struct page **stripe_pages;
 
+	/* Pointers to the sectors in the bio_list, for faster lookup */
+	struct sector_ptr *bio_sectors;
+
 	/* Pointers to the pages in the bio_list, for faster lookup */
 	struct page **bio_pages;
 
@@ -282,6 +286,24 @@ static void cache_rbio_pages(struct btrfs_raid_bio *rbio)
 		copy_highpage(rbio->stripe_pages[i], rbio->bio_pages[i]);
 		SetPageUptodate(rbio->stripe_pages[i]);
 	}
+
+	/*
+	 * TODO: This work is duplicated with above loop, should remove above
+	 * loop when the switch is fully done.
+	 */
+	for (i = 0; i < rbio->nr_sectors; i++) {
+		/* Some range not covered by bio (partial write), skip it */
+		if (!rbio->bio_sectors[i].page)
+			continue;
+
+		ASSERT(rbio->stripe_sectors[i].page);
+		memcpy_page(rbio->stripe_sectors[i].page,
+			    rbio->stripe_sectors[i].pgoff,
+			    rbio->bio_sectors[i].page,
+			    rbio->bio_sectors[i].pgoff,
+			    rbio->bioc->fs_info->sectorsize);
+		rbio->stripe_sectors[i].uptodate = 1;
+	}
 	set_bit(RBIO_CACHE_READY_BIT, &rbio->flags);
 }
 
@@ -1012,7 +1034,7 @@ static struct btrfs_raid_bio *alloc_rbio(struct btrfs_fs_info *fs_info,
 
 	rbio = kzalloc(sizeof(*rbio) +
 		       sizeof(*rbio->stripe_pages) * num_pages +
-		       sizeof(*rbio->bio_pages) * num_pages +
+		       sizeof(*rbio->bio_sectors) * num_sectors +
 		       sizeof(*rbio->stripe_sectors) * num_sectors +
 		       sizeof(*rbio->finish_pointers) * real_stripes +
 		       sizeof(*rbio->dbitmap) * BITS_TO_LONGS(stripe_nsectors) +
@@ -1051,6 +1073,7 @@ static struct btrfs_raid_bio *alloc_rbio(struct btrfs_fs_info *fs_info,
 	} while (0)
 	CONSUME_ALLOC(rbio->stripe_pages, num_pages);
 	CONSUME_ALLOC(rbio->bio_pages, num_pages);
+	CONSUME_ALLOC(rbio->bio_sectors, num_sectors);
 	CONSUME_ALLOC(rbio->stripe_sectors, num_sectors);
 	CONSUME_ALLOC(rbio->finish_pointers, real_stripes);
 	CONSUME_ALLOC(rbio->dbitmap, BITS_TO_LONGS(stripe_nsectors));
@@ -1184,6 +1207,31 @@ static void validate_rbio_for_rmw(struct btrfs_raid_bio *rbio)
 	}
 }
 
+static void index_one_bio(struct btrfs_raid_bio *rbio, struct bio *bio)
+{
+	const u32 sectorsize = rbio->bioc->fs_info->sectorsize;
+	struct bio_vec bvec;
+	struct bvec_iter iter;
+	u32 offset = (bio->bi_iter.bi_sector << SECTOR_SHIFT) -
+		     rbio->bioc->raid_map[0];
+
+	if (bio_flagged(bio, BIO_CLONED))
+		bio->bi_iter = btrfs_bio(bio)->iter;
+	bio_for_each_segment(bvec, bio, iter) {
+		u32 bvec_offset;
+
+		for (bvec_offset = 0; bvec_offset < bvec.bv_len;
+		     bvec_offset += sectorsize, offset += sectorsize) {
+			int index = offset / sectorsize;
+			struct sector_ptr *sector = &rbio->bio_sectors[index];
+
+			sector->page = bvec.bv_page;
+			sector->pgoff = bvec.bv_offset + bvec_offset;
+			ASSERT(sector->pgoff < PAGE_SIZE);
+		}
+	}
+}
+
 /*
  * helper function to walk our bio list and populate the bio_pages array with
  * the result.  This seems expensive, but it is faster than constantly
@@ -1217,6 +1265,10 @@ static void index_rbio_pages(struct btrfs_raid_bio *rbio)
 			i++;
 		}
 	}
+	/* TODO: This loop will replace above loop when the full switch is done */
+	bio_list_for_each(bio, &rbio->bio_list)
+		index_one_bio(rbio, bio);
+
 	spin_unlock_irq(&rbio->bio_list_lock);
 }
 
-- 
2.35.1

