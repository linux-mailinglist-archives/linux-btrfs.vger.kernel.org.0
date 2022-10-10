Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 451715F9CDA
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Oct 2022 12:36:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231873AbiJJKgj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 10 Oct 2022 06:36:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231861AbiJJKgf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 10 Oct 2022 06:36:35 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7579657BF6
        for <linux-btrfs@vger.kernel.org>; Mon, 10 Oct 2022 03:36:34 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 15FDC1F8AC
        for <linux-btrfs@vger.kernel.org>; Mon, 10 Oct 2022 10:36:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1665398193; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6FN53+vuNaglNa1weSXGDUxOI4HokZqQDNXJlz8gsvs=;
        b=rBsNPuI5GSubdznYQTiZKfIP0Nt7sS3rxMjjufTWD2w8WtWKmlQoJCVOANDQuvRlZMh04M
        juelUBXbobe5R8tUulCQZbuCLaXq4o/Vh2XN5XrdIFNG07JQAkx70WjLi3wQfPNjnIVoQf
        IGbpHSVqMTDRs1+LsftT1ztIzkjpPxI=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5820513ACA
        for <linux-btrfs@vger.kernel.org>; Mon, 10 Oct 2022 10:36:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id cEizB7D1Q2M9LgAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Mon, 10 Oct 2022 10:36:32 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 4/5] btrfs: raid56: allocate memory separately for rbio pointers
Date:   Mon, 10 Oct 2022 18:36:09 +0800
Message-Id: <bb8c75c82e82b44fa33698b42de91b805bbdd033.1665397731.git.wqu@suse.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <cover.1665397731.git.wqu@suse.com>
References: <cover.1665397731.git.wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Currently inside alloc_rbio(), we allocate a larger memory to contain
the following members:

- struct btrfs_raid_rbio itself
- stripe_pages array
- bio_sectors array
- stripe_sectors array
- finish_pointers array

Then update rbio pointers to point the extra space after the rbio
structure itself.

Thus it introduced a complex CONSUME_ALLOC() macro to help the thing.

This is too hacky, and is going to make later pointers expansion harder.

This patch will change it to use regular kcalloc() for each pointer
inside btrfs_raid_bio, making the later expansion much easier.

And introduce a helper free_raid_bio_pointers() to free up all the
pointer members in btrfs_raid_bio, which will be used in both
free_raid_bio() and error path of alloc_rbio().

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/raid56.c | 46 ++++++++++++++++++++++++----------------------
 1 file changed, 24 insertions(+), 22 deletions(-)

diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
index 371b2a182544..4ec211a58f15 100644
--- a/fs/btrfs/raid56.c
+++ b/fs/btrfs/raid56.c
@@ -76,6 +76,14 @@ static noinline void finish_parity_scrub(struct btrfs_raid_bio *rbio,
 					 int need_check);
 static void scrub_parity_work(struct work_struct *work);
 
+static void free_raid_bio_pointers(struct btrfs_raid_bio *rbio)
+{
+	kfree(rbio->stripe_pages);
+	kfree(rbio->bio_sectors);
+	kfree(rbio->stripe_sectors);
+	kfree(rbio->finish_pointers);
+}
+
 static void free_raid_bio(struct btrfs_raid_bio *rbio)
 {
 	int i;
@@ -95,6 +103,7 @@ static void free_raid_bio(struct btrfs_raid_bio *rbio)
 	}
 
 	btrfs_put_bioc(rbio->bioc);
+	free_raid_bio_pointers(rbio);
 	kfree(rbio);
 }
 
@@ -918,7 +927,6 @@ static struct btrfs_raid_bio *alloc_rbio(struct btrfs_fs_info *fs_info,
 		BTRFS_STRIPE_LEN >> fs_info->sectorsize_bits;
 	const unsigned int num_sectors = stripe_nsectors * real_stripes;
 	struct btrfs_raid_bio *rbio;
-	void *p;
 
 	/* PAGE_SIZE must also be aligned to sectorsize for subpage support */
 	ASSERT(IS_ALIGNED(PAGE_SIZE, fs_info->sectorsize));
@@ -928,14 +936,23 @@ static struct btrfs_raid_bio *alloc_rbio(struct btrfs_fs_info *fs_info,
 	 */
 	ASSERT(stripe_nsectors <= BITS_PER_LONG);
 
-	rbio = kzalloc(sizeof(*rbio) +
-		       sizeof(*rbio->stripe_pages) * num_pages +
-		       sizeof(*rbio->bio_sectors) * num_sectors +
-		       sizeof(*rbio->stripe_sectors) * num_sectors +
-		       sizeof(*rbio->finish_pointers) * real_stripes,
-		       GFP_NOFS);
+	rbio = kzalloc(sizeof(*rbio), GFP_NOFS);
 	if (!rbio)
 		return ERR_PTR(-ENOMEM);
+	rbio->stripe_pages = kcalloc(num_pages, sizeof(struct page *),
+				     GFP_NOFS);
+	rbio->bio_sectors = kcalloc(num_sectors, sizeof(struct sector_ptr),
+				    GFP_NOFS);
+	rbio->stripe_sectors = kcalloc(num_sectors, sizeof(struct sector_ptr),
+				       GFP_NOFS);
+	rbio->finish_pointers = kcalloc(real_stripes, sizeof(void *), GFP_NOFS);
+
+	if (!rbio->stripe_pages || !rbio->bio_sectors || !rbio->stripe_sectors ||
+	    !rbio->finish_pointers) {
+		free_raid_bio_pointers(rbio);
+		kfree(rbio);
+		return ERR_PTR(-ENOMEM);
+	}
 
 	bio_list_init(&rbio->bio_list);
 	INIT_LIST_HEAD(&rbio->plug_list);
@@ -955,21 +972,6 @@ static struct btrfs_raid_bio *alloc_rbio(struct btrfs_fs_info *fs_info,
 	atomic_set(&rbio->error, 0);
 	atomic_set(&rbio->stripes_pending, 0);
 
-	/*
-	 * The stripe_pages, bio_sectors, etc arrays point to the extra memory
-	 * we allocated past the end of the rbio.
-	 */
-	p = rbio + 1;
-#define CONSUME_ALLOC(ptr, count)	do {				\
-		ptr = p;						\
-		p = (unsigned char *)p + sizeof(*(ptr)) * (count);	\
-	} while (0)
-	CONSUME_ALLOC(rbio->stripe_pages, num_pages);
-	CONSUME_ALLOC(rbio->bio_sectors, num_sectors);
-	CONSUME_ALLOC(rbio->stripe_sectors, num_sectors);
-	CONSUME_ALLOC(rbio->finish_pointers, real_stripes);
-#undef  CONSUME_ALLOC
-
 	ASSERT(btrfs_nr_parity_stripes(bioc->map_type));
 	rbio->nr_data = real_stripes - btrfs_nr_parity_stripes(bioc->map_type);
 
-- 
2.37.3

