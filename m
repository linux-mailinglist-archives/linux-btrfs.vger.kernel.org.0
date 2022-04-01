Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C4904EEC5C
	for <lists+linux-btrfs@lfdr.de>; Fri,  1 Apr 2022 13:24:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235786AbiDALZq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 1 Apr 2022 07:25:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345470AbiDALZo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 1 Apr 2022 07:25:44 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7521118CD30
        for <linux-btrfs@vger.kernel.org>; Fri,  1 Apr 2022 04:23:54 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 316EA1FD03
        for <linux-btrfs@vger.kernel.org>; Fri,  1 Apr 2022 11:23:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1648812233; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qgPfDUdCJXwFp4JLLCINTr7oDPydMriIXn4BUarayds=;
        b=kXGS7z3wrDtqmlvWxkixRc9O1fcqjGcG7T32Mj6ICod2cceMGHGon9IAaj13iNB/Tt5LFD
        gHzgPJ2nkmCq/9LAL3CuLVLGRyaLGKhfhQJLS5MXlaOP1cFtP7S+0k3MWP5nINTOPUnz6a
        FH7gX4Q/iwlsLFieIA0XAZNtNvai6b8=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 87388132C1
        for <linux-btrfs@vger.kernel.org>; Fri,  1 Apr 2022 11:23:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id sAhaFcjgRmJeFwAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Fri, 01 Apr 2022 11:23:52 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 04/16] btrfs: introduce btrfs_raid_bio::stripe_sectors
Date:   Fri,  1 Apr 2022 19:23:19 +0800
Message-Id: <3a178d6547fc13b561535194f9dff41f9b4fa4d4.1648807440.git.wqu@suse.com>
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

The new member is an array of sector_ptr pointers, they will represent
all sectors inside a full stripe (including P/Q).

They co-operate with btrfs_raid_bio::stripe_pages:

stripe_pages:   | Page 0, range [0, 64K)   | Page 1 ...
stripe_sectors: |  |  | ...             |  |
                  |  |                    \- sector 15, page 0, pgoff=60K
                  |  \- sector 1, page 0, pgoff=4K
                  \---- sector 0, page 0, pfoff=0

With such structure, we can represent subpage sectors without using
extra pages.

Here we introduce a new helper, index_stripe_sectors(), to update
stripe_sectors[] to point to correct page and pgoff.

So every time rbio::stripe_pages[] pointer gets updated, the new helper
should be called.

The following functions have to call the new helper:

- steal_rbio()
- alloc_rbio_pages()
- alloc_rbio_parity_pages()
- alloc_rbio_essential_pages()

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/raid56.c | 62 +++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 54 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
index 1bad7d3a0331..8cfe00db79c9 100644
--- a/fs/btrfs/raid56.c
+++ b/fs/btrfs/raid56.c
@@ -52,6 +52,16 @@ struct btrfs_stripe_hash_table {
 	struct btrfs_stripe_hash table[];
 };
 
+/*
+ * A bvec like structure to present a sector inside a page.
+ *
+ * Unlike bvec we don't need bvlen, as it's fixed to sectorsize.
+ */
+struct sector_ptr {
+	struct page *page;
+	unsigned int pgoff;
+} __attribute__ ((__packed__));
+
 enum btrfs_rbio_ops {
 	BTRFS_RBIO_WRITE,
 	BTRFS_RBIO_READ_REBUILD,
@@ -154,25 +164,27 @@ struct btrfs_raid_bio {
 
 	atomic_t error;
 	/*
-	 * these are two arrays of pointers.  We allocate the
+	 * These are two arrays of pointers.  We allocate the
 	 * rbio big enough to hold them both and setup their
 	 * locations when the rbio is allocated
 	 */
 
-	/* pointers to pages that we allocated for
+	/*
+	 * Pointers to pages that we allocated for
 	 * reading/writing stripes directly from the disk (including P/Q)
 	 */
 	struct page **stripe_pages;
 
-	/*
-	 * pointers to the pages in the bio_list.  Stored
-	 * here for faster lookup
-	 */
+	/* Pointers to the pages in the bio_list, for faster lookup */
 	struct page **bio_pages;
 
 	/*
-	 * bitmap to record which horizontal stripe has data
+	 * For subpage support, we need to map each sector to above
+	 * stripe_pages.
 	 */
+	struct sector_ptr *stripe_sectors;
+
+	/* Bitmap to record which horizontal stripe has data */
 	unsigned long *dbitmap;
 
 	/* allocated with real_stripes-many pointers for finish_*() calls */
@@ -291,6 +303,26 @@ static int rbio_bucket(struct btrfs_raid_bio *rbio)
 	return hash_64(num >> 16, BTRFS_STRIPE_HASH_TABLE_BITS);
 }
 
+/*
+ * Update the stripe_sectors[] array to use correct page and pgoff
+ *
+ * Should be called every time any page pointer in stripes_pages[] got modified.
+ */
+static void index_stripe_sectors(struct btrfs_raid_bio *rbio)
+{
+	const u32 sectorsize = rbio->bioc->fs_info->sectorsize;
+	u32 offset;
+	int i;
+
+	for (i = 0, offset = 0; i < rbio->nr_sectors; i++, offset += sectorsize) {
+		int page_index = offset >> PAGE_SHIFT;
+
+		ASSERT(page_index < rbio->nr_pages);
+		rbio->stripe_sectors[i].page = rbio->stripe_pages[page_index];
+		rbio->stripe_sectors[i].pgoff = offset_in_page(offset);
+	}
+}
+
 /*
  * stealing an rbio means taking all the uptodate pages from the stripe
  * array in the source rbio and putting them into the destination rbio
@@ -317,6 +349,8 @@ static void steal_rbio(struct btrfs_raid_bio *src, struct btrfs_raid_bio *dest)
 		dest->stripe_pages[i] = s;
 		src->stripe_pages[i] = NULL;
 	}
+	index_stripe_sectors(dest);
+	index_stripe_sectors(src);
 }
 
 /*
@@ -979,6 +1013,7 @@ static struct btrfs_raid_bio *alloc_rbio(struct btrfs_fs_info *fs_info,
 	rbio = kzalloc(sizeof(*rbio) +
 		       sizeof(*rbio->stripe_pages) * num_pages +
 		       sizeof(*rbio->bio_pages) * num_pages +
+		       sizeof(*rbio->stripe_sectors) * num_sectors +
 		       sizeof(*rbio->finish_pointers) * real_stripes +
 		       sizeof(*rbio->dbitmap) * BITS_TO_LONGS(stripe_nsectors) +
 		       sizeof(*rbio->finish_pbitmap) *
@@ -1016,6 +1051,7 @@ static struct btrfs_raid_bio *alloc_rbio(struct btrfs_fs_info *fs_info,
 	} while (0)
 	CONSUME_ALLOC(rbio->stripe_pages, num_pages);
 	CONSUME_ALLOC(rbio->bio_pages, num_pages);
+	CONSUME_ALLOC(rbio->stripe_sectors, num_sectors);
 	CONSUME_ALLOC(rbio->finish_pointers, real_stripes);
 	CONSUME_ALLOC(rbio->dbitmap, BITS_TO_LONGS(stripe_nsectors));
 	CONSUME_ALLOC(rbio->finish_pbitmap, BITS_TO_LONGS(stripe_nsectors));
@@ -1032,12 +1068,16 @@ static struct btrfs_raid_bio *alloc_rbio(struct btrfs_fs_info *fs_info,
 	return rbio;
 }
 
-/* allocate pages for all the stripes in the bio, including parity */
+/*
+ * Allocate pages for all the stripes in the bio including parity, and map all
+ * sectors to their corresponding pages
+ */
 static int alloc_rbio_pages(struct btrfs_raid_bio *rbio)
 {
 	int i;
 	struct page *page;
 
+	/* Allocate all pages */
 	for (i = 0; i < rbio->nr_pages; i++) {
 		if (rbio->stripe_pages[i])
 			continue;
@@ -1046,6 +1086,9 @@ static int alloc_rbio_pages(struct btrfs_raid_bio *rbio)
 			return -ENOMEM;
 		rbio->stripe_pages[i] = page;
 	}
+
+	/* Mapping all sectors */
+	index_stripe_sectors(rbio);
 	return 0;
 }
 
@@ -1065,6 +1108,8 @@ static int alloc_rbio_parity_pages(struct btrfs_raid_bio *rbio)
 			return -ENOMEM;
 		rbio->stripe_pages[i] = page;
 	}
+
+	index_stripe_sectors(rbio);
 	return 0;
 }
 
@@ -2313,6 +2358,7 @@ static int alloc_rbio_essential_pages(struct btrfs_raid_bio *rbio)
 			rbio->stripe_pages[index] = page;
 		}
 	}
+	index_stripe_sectors(rbio);
 	return 0;
 }
 
-- 
2.35.1

