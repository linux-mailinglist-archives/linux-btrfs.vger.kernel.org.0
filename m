Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57CFA4FDCA4
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Apr 2022 13:05:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238513AbiDLKhQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 12 Apr 2022 06:37:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354410AbiDLKdj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 12 Apr 2022 06:33:39 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4236B5B3F8
        for <linux-btrfs@vger.kernel.org>; Tue, 12 Apr 2022 02:33:34 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id F38811F868
        for <linux-btrfs@vger.kernel.org>; Tue, 12 Apr 2022 09:33:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1649756012; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ulli860WTBrAaOyKlw3kz8CK274mMLuTF3sNDrK9jog=;
        b=IKkaL0XQt4xLPiCzgF+k6EfGq/3wMMB7LP+I1B3pY6RT2eAOZAI0R0C9s28ByF3KxU19l0
        YcK9irmQuSZlH+i+OAy9LzFdbO3SSr0zzNyy2RXVLN0zfk0+dC8jXEnYSNsxIGvwtxCfNm
        MacrJIkYyea5hrFrQxsk3OFCuVAY7Uc=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4C1B813A99
        for <linux-btrfs@vger.kernel.org>; Tue, 12 Apr 2022 09:33:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id YP+aBWxHVWI8LwAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Tue, 12 Apr 2022 09:33:32 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 06/17] btrfs: introduce btrfs_raid_bio::bio_sectors
Date:   Tue, 12 Apr 2022 17:32:56 +0800
Message-Id: <a1616217ca122be7877d20a82b1b1e7b5cac4888.1649753690.git.wqu@suse.com>
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

This new member is going to fully replace bio_pages in the future, but
for now let's keep them co-exist, until the full switch is done.

Currently cache_rbio_pages() and index_rbio_pages() will also populate
the new array.

And cache_rbio_pages() need to record which sectors are uptodate, so we
also need to introduce sector_ptr::uptodate bit.

To avoid extra memory usage, we let the new @uptodate bit to share bits
with @pgoff.
Now pgoff only have at most 31 bits, which is already more than enough,
as even for 256K page size, we only need 18 bits.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/raid56.c | 51 +++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 49 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
index 0c7b6a06d5ce..f88dd11a208d 100644
--- a/fs/btrfs/raid56.c
+++ b/fs/btrfs/raid56.c
@@ -59,7 +59,8 @@ struct btrfs_stripe_hash_table {
  */
 struct sector_ptr {
 	struct page *page;
-	unsigned int pgoff;
+	unsigned int pgoff:24;
+	unsigned int uptodate:8;
 };
 
 enum btrfs_rbio_ops {
@@ -174,6 +175,9 @@ struct btrfs_raid_bio {
 	 */
 	struct page **stripe_pages;
 
+	/* Pointers to the sectors in the bio_list, for faster lookup */
+	struct sector_ptr *bio_sectors;
+
 	/*
 	 * pointers to the pages in the bio_list.  Stored
 	 * here for faster lookup
@@ -284,6 +288,20 @@ static void cache_rbio_pages(struct btrfs_raid_bio *rbio)
 		copy_highpage(rbio->stripe_pages[i], rbio->bio_pages[i]);
 		SetPageUptodate(rbio->stripe_pages[i]);
 	}
+
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
 
@@ -1013,7 +1031,7 @@ static struct btrfs_raid_bio *alloc_rbio(struct btrfs_fs_info *fs_info,
 
 	rbio = kzalloc(sizeof(*rbio) +
 		       sizeof(*rbio->stripe_pages) * num_pages +
-		       sizeof(*rbio->bio_pages) * num_pages +
+		       sizeof(*rbio->bio_sectors) * num_sectors +
 		       sizeof(*rbio->stripe_sectors) * num_sectors +
 		       sizeof(*rbio->finish_pointers) * real_stripes +
 		       sizeof(*rbio->dbitmap) * BITS_TO_LONGS(stripe_nsectors) +
@@ -1052,6 +1070,7 @@ static struct btrfs_raid_bio *alloc_rbio(struct btrfs_fs_info *fs_info,
 	} while (0)
 	CONSUME_ALLOC(rbio->stripe_pages, num_pages);
 	CONSUME_ALLOC(rbio->bio_pages, num_pages);
+	CONSUME_ALLOC(rbio->bio_sectors, num_sectors);
 	CONSUME_ALLOC(rbio->stripe_sectors, num_sectors);
 	CONSUME_ALLOC(rbio->finish_pointers, real_stripes);
 	CONSUME_ALLOC(rbio->dbitmap, BITS_TO_LONGS(stripe_nsectors));
@@ -1171,6 +1190,31 @@ static void validate_rbio_for_rmw(struct btrfs_raid_bio *rbio)
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
@@ -1201,6 +1245,9 @@ static void index_rbio_pages(struct btrfs_raid_bio *rbio)
 			i++;
 		}
 	}
+	bio_list_for_each(bio, &rbio->bio_list)
+		index_one_bio(rbio, bio);
+
 	spin_unlock_irq(&rbio->bio_list_lock);
 }
 
-- 
2.35.1

