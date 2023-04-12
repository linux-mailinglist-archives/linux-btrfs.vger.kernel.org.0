Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 136046DEC0F
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Apr 2023 08:48:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229578AbjDLGsP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 12 Apr 2023 02:48:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229765AbjDLGsN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 12 Apr 2023 02:48:13 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F63459D1
        for <linux-btrfs@vger.kernel.org>; Tue, 11 Apr 2023 23:48:10 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id B906D1F890
        for <linux-btrfs@vger.kernel.org>; Wed, 12 Apr 2023 06:48:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1681282088; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=Ov3M+qgi6Ij55XSnjuwiBpLBsajX+aB/TIBnWRgyE7c=;
        b=d81WvHcCmPmu9yBpz+1E1zI2BAdzP5EvuGMZmG9oziKWRQ9JvG+zwE3g2rhSIhNzN2osLW
        wPF0dq4albvOhf3jH3UeNXjyGLWhTqrE1fX4EHxvYLyFcD4MrGFuWurE+qe0qhLwUYsfry
        FaRsuhM3j15hIe2VGi79l3kPYcdKbzM=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 27C3513498
        for <linux-btrfs@vger.kernel.org>; Wed, 12 Apr 2023 06:48:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id IBe4OSdUNmRuJAAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Wed, 12 Apr 2023 06:48:07 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: remove unused raid56 functions which were dedicated for scrub
Date:   Wed, 12 Apr 2023 14:47:50 +0800
Message-Id: <db16bb361ef4fb39c71c236dd3985ed88b85ecd0.1681282065.git.wqu@suse.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Since the scrub rework, the following raid56 functions are no longer
called:

- raid56_add_scrub_pages()
- raid56_alloc_missing_rbio()
- raid56_submit_missing_rbio()

Those functions are all utilized by scrub to handle missing device cases
for RAID56.

However the new scrub code handle them in a completely different method:

- If it's data stripes, go recovery path through btrfs_submit_bio()
- If it's P/Q stripes, it would be handled through
  raid56_parity_submit_scrub_rbio()
  And that function would handle dev-replace and repair properly.

Thus we can safely remove those functions.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/raid56.c | 47 -----------------------------------------------
 fs/btrfs/raid56.h |  7 -------
 2 files changed, 54 deletions(-)

diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
index ed6343f566d4..2fab37f062de 100644
--- a/fs/btrfs/raid56.c
+++ b/fs/btrfs/raid56.c
@@ -2376,23 +2376,6 @@ struct btrfs_raid_bio *raid56_parity_alloc_scrub_rbio(struct bio *bio,
 	return rbio;
 }
 
-/* Used for both parity scrub and missing. */
-void raid56_add_scrub_pages(struct btrfs_raid_bio *rbio, struct page *page,
-			    unsigned int pgoff, u64 logical)
-{
-	const u32 sectorsize = rbio->bioc->fs_info->sectorsize;
-	int stripe_offset;
-	int index;
-
-	ASSERT(logical >= rbio->bioc->full_stripe_logical);
-	ASSERT(logical + sectorsize <= rbio->bioc->full_stripe_logical +
-				       BTRFS_STRIPE_LEN * rbio->nr_data);
-	stripe_offset = (int)(logical - rbio->bioc->full_stripe_logical);
-	index = stripe_offset / sectorsize;
-	rbio->bio_sectors[index].page = page;
-	rbio->bio_sectors[index].pgoff = pgoff;
-}
-
 /*
  * We just scrub the parity that we have correct data on the same horizontal,
  * so we needn't allocate all pages for all the stripes.
@@ -2764,33 +2747,3 @@ void raid56_parity_submit_scrub_rbio(struct btrfs_raid_bio *rbio)
 	if (!lock_stripe_add(rbio))
 		start_async_work(rbio, scrub_rbio_work_locked);
 }
-
-/* The following code is used for dev replace of a missing RAID 5/6 device. */
-
-struct btrfs_raid_bio *
-raid56_alloc_missing_rbio(struct bio *bio, struct btrfs_io_context *bioc)
-{
-	struct btrfs_fs_info *fs_info = bioc->fs_info;
-	struct btrfs_raid_bio *rbio;
-
-	rbio = alloc_rbio(fs_info, bioc);
-	if (IS_ERR(rbio))
-		return NULL;
-
-	rbio->operation = BTRFS_RBIO_REBUILD_MISSING;
-	bio_list_add(&rbio->bio_list, bio);
-	/*
-	 * This is a special bio which is used to hold the completion handler
-	 * and make the scrub rbio is similar to the other types
-	 */
-	ASSERT(!bio->bi_iter.bi_size);
-
-	set_rbio_range_error(rbio, bio);
-
-	return rbio;
-}
-
-void raid56_submit_missing_rbio(struct btrfs_raid_bio *rbio)
-{
-	start_async_work(rbio, recover_rbio_work);
-}
diff --git a/fs/btrfs/raid56.h b/fs/btrfs/raid56.h
index 6583c225b1bd..0f7f31c8cb98 100644
--- a/fs/btrfs/raid56.h
+++ b/fs/btrfs/raid56.h
@@ -187,19 +187,12 @@ void raid56_parity_recover(struct bio *bio, struct btrfs_io_context *bioc,
 			   int mirror_num);
 void raid56_parity_write(struct bio *bio, struct btrfs_io_context *bioc);
 
-void raid56_add_scrub_pages(struct btrfs_raid_bio *rbio, struct page *page,
-			    unsigned int pgoff, u64 logical);
-
 struct btrfs_raid_bio *raid56_parity_alloc_scrub_rbio(struct bio *bio,
 				struct btrfs_io_context *bioc,
 				struct btrfs_device *scrub_dev,
 				unsigned long *dbitmap, int stripe_nsectors);
 void raid56_parity_submit_scrub_rbio(struct btrfs_raid_bio *rbio);
 
-struct btrfs_raid_bio *
-raid56_alloc_missing_rbio(struct bio *bio, struct btrfs_io_context *bioc);
-void raid56_submit_missing_rbio(struct btrfs_raid_bio *rbio);
-
 int btrfs_alloc_stripe_hash_table(struct btrfs_fs_info *info);
 void btrfs_free_stripe_hash_table(struct btrfs_fs_info *info);
 
-- 
2.39.2

