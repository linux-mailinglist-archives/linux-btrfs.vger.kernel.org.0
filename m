Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A607F4FDCA8
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Apr 2022 13:05:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241283AbiDLKhZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 12 Apr 2022 06:37:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354383AbiDLKdj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 12 Apr 2022 06:33:39 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56C195B3F6
        for <linux-btrfs@vger.kernel.org>; Tue, 12 Apr 2022 02:33:33 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id D9D6E21639
        for <linux-btrfs@vger.kernel.org>; Tue, 12 Apr 2022 09:33:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1649756011; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+DPlA0UJTHpcnljPOAFWSv22wxLIa8BhQ+r5KafyybM=;
        b=T7gK7uLFfSnRFAZPtZXl8SrJyiuZ6H7wvLh0aLAkyCS8iM89/hAxqHtX/fc2yewRZBsHcu
        FpdAFM8zZyw/idEUK+HfFFV8cYm8Ig3KAMndKWICZ5DjmvxelAwmNtnYG3jP4J3hiuxSOu
        I8a9b0djyVShfKu6LmG5kP5FCr4l4vs=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2E18313A99
        for <linux-btrfs@vger.kernel.org>; Tue, 12 Apr 2022 09:33:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id AKIGOWpHVWI8LwAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Tue, 12 Apr 2022 09:33:30 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 05/17] btrfs: introduce btrfs_raid_bio::stripe_sectors
Date:   Tue, 12 Apr 2022 17:32:55 +0800
Message-Id: <70896d3914f27aa5bf30445c751c9f559ee8a2b9.1649753690.git.wqu@suse.com>
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
 fs/btrfs/raid56.c | 65 +++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 60 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
index 92d464d4456a..0c7b6a06d5ce 100644
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
+};
+
 enum btrfs_rbio_ops {
 	BTRFS_RBIO_WRITE,
 	BTRFS_RBIO_READ_REBUILD,
@@ -171,8 +181,12 @@ struct btrfs_raid_bio {
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
@@ -291,6 +305,26 @@ static int rbio_bucket(struct btrfs_raid_bio *rbio)
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
@@ -317,6 +351,8 @@ static void steal_rbio(struct btrfs_raid_bio *src, struct btrfs_raid_bio *dest)
 		dest->stripe_pages[i] = s;
 		src->stripe_pages[i] = NULL;
 	}
+	index_stripe_sectors(dest);
+	index_stripe_sectors(src);
 }
 
 /*
@@ -978,6 +1014,7 @@ static struct btrfs_raid_bio *alloc_rbio(struct btrfs_fs_info *fs_info,
 	rbio = kzalloc(sizeof(*rbio) +
 		       sizeof(*rbio->stripe_pages) * num_pages +
 		       sizeof(*rbio->bio_pages) * num_pages +
+		       sizeof(*rbio->stripe_sectors) * num_sectors +
 		       sizeof(*rbio->finish_pointers) * real_stripes +
 		       sizeof(*rbio->dbitmap) * BITS_TO_LONGS(stripe_nsectors) +
 		       sizeof(*rbio->finish_pbitmap) *
@@ -1015,6 +1052,7 @@ static struct btrfs_raid_bio *alloc_rbio(struct btrfs_fs_info *fs_info,
 	} while (0)
 	CONSUME_ALLOC(rbio->stripe_pages, num_pages);
 	CONSUME_ALLOC(rbio->bio_pages, num_pages);
+	CONSUME_ALLOC(rbio->stripe_sectors, num_sectors);
 	CONSUME_ALLOC(rbio->finish_pointers, real_stripes);
 	CONSUME_ALLOC(rbio->dbitmap, BITS_TO_LONGS(stripe_nsectors));
 	CONSUME_ALLOC(rbio->finish_pbitmap, BITS_TO_LONGS(stripe_nsectors));
@@ -1031,19 +1069,35 @@ static struct btrfs_raid_bio *alloc_rbio(struct btrfs_fs_info *fs_info,
 	return rbio;
 }
 
-/* allocate pages for all the stripes in the bio, including parity */
+/*
+ * Allocate pages for all the stripes in the bio including parity, and map all
+ * sectors to their corresponding pages
+ */
 static int alloc_rbio_pages(struct btrfs_raid_bio *rbio)
 {
-	return btrfs_alloc_page_array(rbio->nr_pages, rbio->stripe_pages);
+	int ret;
+
+	ret = btrfs_alloc_page_array(rbio->nr_pages, rbio->stripe_pages);
+	if (ret < 0)
+		return ret;
+	/* Mapping all sectors */
+	index_stripe_sectors(rbio);
+	return 0;
 }
 
 /* only allocate pages for p/q stripes */
 static int alloc_rbio_parity_pages(struct btrfs_raid_bio *rbio)
 {
 	int data_pages = rbio_stripe_page_index(rbio, rbio->nr_data, 0);
+	int ret;
 
-	return btrfs_alloc_page_array(rbio->nr_pages - data_pages,
-				      rbio->stripe_pages + data_pages);
+	ret = btrfs_alloc_page_array(rbio->nr_pages - data_pages,
+				     rbio->stripe_pages + data_pages);
+	if (ret < 0)
+		return ret;
+
+	index_stripe_sectors(rbio);
+	return 0;
 }
 
 /*
@@ -2286,6 +2340,7 @@ static int alloc_rbio_essential_pages(struct btrfs_raid_bio *rbio)
 			rbio->stripe_pages[index] = page;
 		}
 	}
+	index_stripe_sectors(rbio);
 	return 0;
 }
 
-- 
2.35.1

