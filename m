Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30EF4745622
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Jul 2023 09:33:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229986AbjGCHdT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 3 Jul 2023 03:33:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230464AbjGCHdP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 3 Jul 2023 03:33:15 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82A2FE6A
        for <linux-btrfs@vger.kernel.org>; Mon,  3 Jul 2023 00:33:03 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 45590218F9
        for <linux-btrfs@vger.kernel.org>; Mon,  3 Jul 2023 07:33:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1688369582; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=x2Gn273D3eJJXiPy8q7PfiNedvrhXMd8qPQSyE8veiE=;
        b=CRotMnnjoF6tILG0z7z016LMS+3xnBLj//B/ub7gzSisROZ8jrkB3TPTq6yX7Mdjzis2tl
        ZI2T5aLxZEps0geGUCZWQl5ItWwq1maAbltrtFn+5wq/YqVpEFDNB2QbwHGuKvXYFWJ0Vk
        PiozJ44KOCjyqnR24YE3jxvjq98/Zy0=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2A03113276
        for <linux-btrfs@vger.kernel.org>; Mon,  3 Jul 2023 07:33:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id WL50OKx5omRoVQAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Mon, 03 Jul 2023 07:33:00 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 04/14] btrfs: raid56: add the interfaces to submit recovery rbio
Date:   Mon,  3 Jul 2023 15:32:28 +0800
Message-ID: <33215d978e2d8423aedde0c79d733204010c2adb.1688368617.git.wqu@suse.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1688368617.git.wqu@suse.com>
References: <cover.1688368617.git.wqu@suse.com>
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

The incoming scrub_logical would need to recover raid56 data sectors
with cached pages.

This means we can not go regular btrfs_submit_bio() path, but go a
similar path like raid56_parity_alloc_scrub_rbio().

So this patch adds the following new functions to allow recover rbio to
be allocated and submitted out of the btrfs_submit_bio() path:

- raid56_parity_alloc_recover_rbio()
- raid56_parity_submit_scrub_rbio()

This means now we can go a full cached recover without reading any pages
from disk.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/raid56.c | 31 +++++++++++++++++++++++++++++++
 fs/btrfs/raid56.h |  3 +++
 2 files changed, 34 insertions(+)

diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
index b2eb7e60a137..0340220463c6 100644
--- a/fs/btrfs/raid56.c
+++ b/fs/btrfs/raid56.c
@@ -2383,6 +2383,31 @@ struct btrfs_raid_bio *raid56_parity_alloc_scrub_rbio(struct bio *bio,
 	return rbio;
 }
 
+/*
+ * Alloc a recovery rbio out of the regular btrfs_submit_bio() path.
+ *
+ * This allows scrub caller to use cached pages to reduce IO.
+ */
+struct btrfs_raid_bio *raid56_parity_alloc_recover_rbio(struct bio *bio,
+				struct btrfs_io_context *bioc, int mirror_num)
+{
+	struct btrfs_fs_info *fs_info = bioc->fs_info;
+	struct btrfs_raid_bio *rbio;
+
+	rbio = alloc_rbio(fs_info, bioc);
+	if (IS_ERR(rbio))
+		return NULL;
+	/* We should have some sectors that really need to be recovered. */
+	ASSERT(bio->bi_iter.bi_size);
+	bio_list_add(&rbio->bio_list, bio);
+	set_rbio_range_error(rbio, bio);
+	rbio->operation = BTRFS_RBIO_READ_REBUILD;
+	if (mirror_num > 2)
+		set_rbio_raid6_extra_error(rbio, mirror_num);
+
+	return rbio;
+}
+
 /*
  * We just scrub the parity that we have correct data on the same horizontal,
  * so we needn't allocate all pages for all the stripes.
@@ -2771,6 +2796,12 @@ void raid56_parity_submit_scrub_rbio(struct btrfs_raid_bio *rbio)
 		start_async_work(rbio, scrub_rbio_work_locked);
 }
 
+void raid56_parity_submit_recover_rbio(struct btrfs_raid_bio *rbio)
+{
+	if (!lock_stripe_add(rbio))
+		start_async_work(rbio, recover_rbio_work_locked);
+}
+
 /*
  * This is for scrub call sites where we already have correct stripe contents.
  * This allows us to avoid reading on-disk stripes again.
diff --git a/fs/btrfs/raid56.h b/fs/btrfs/raid56.h
index 41354a9f158a..6f146eb86832 100644
--- a/fs/btrfs/raid56.h
+++ b/fs/btrfs/raid56.h
@@ -197,7 +197,10 @@ struct btrfs_raid_bio *raid56_parity_alloc_scrub_rbio(struct bio *bio,
 				struct btrfs_io_context *bioc,
 				struct btrfs_device *scrub_dev,
 				unsigned long *dbitmap);
+struct btrfs_raid_bio *raid56_parity_alloc_recover_rbio(struct bio *bio,
+				struct btrfs_io_context *bioc, int mirror_num);
 void raid56_parity_submit_scrub_rbio(struct btrfs_raid_bio *rbio);
+void raid56_parity_submit_recover_rbio(struct btrfs_raid_bio *rbio);
 void raid56_parity_cache_pages(struct btrfs_raid_bio *rbio, struct page **pages,
 			       int stripe_num);
 
-- 
2.41.0

