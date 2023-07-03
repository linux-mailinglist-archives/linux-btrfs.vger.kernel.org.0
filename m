Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5595745620
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Jul 2023 09:33:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230461AbjGCHdP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 3 Jul 2023 03:33:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230454AbjGCHdM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 3 Jul 2023 03:33:12 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFE4CE49
        for <linux-btrfs@vger.kernel.org>; Mon,  3 Jul 2023 00:32:59 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 81699218FC
        for <linux-btrfs@vger.kernel.org>; Mon,  3 Jul 2023 07:32:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1688369578; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bOvnv9Nbt7nFXdTtiHEAsDfSfiOyaLD2cerBH7QX9BQ=;
        b=DNwxcePOGVO6sZA4ZFkdPXAf61n27tj5GzFkEJE2CefrauvDjrlhdeQ8d4mrIRw+mfJxsH
        A5ITDRseuCRNsuZTkN3Gax/WZ6Ll5QCyOi7Za2PtNhicCRYohL0Z6qB7CguewU5UQbJ7sa
        viOe5OwXjpHvhmKusVPrkq4UM51avxw=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D2AC813276
        for <linux-btrfs@vger.kernel.org>; Mon,  3 Jul 2023 07:32:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id GFowJql5omRoVQAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Mon, 03 Jul 2023 07:32:57 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 01/14] btrfs: raid56: remove unnecessary parameter for raid56_parity_alloc_scrub_rbio()
Date:   Mon,  3 Jul 2023 15:32:25 +0800
Message-ID: <1f848dbf2089ca42a3c17e2f361e7aabe3e91507.1688368617.git.wqu@suse.com>
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

The parameter @stripe_nsectors is easily calculated using
BTRFS_STRIPE_LEN >> fs_info->sectorsize_bits, and is already cached in
rbio->stripe_nsectors.

Thus we don't need to pass that parameter from the caller, and can
remove it safely.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/raid56.c | 4 ++--
 fs/btrfs/raid56.h | 2 +-
 fs/btrfs/scrub.c  | 3 +--
 3 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
index 7d1cb4dd0f2c..cc783da065b4 100644
--- a/fs/btrfs/raid56.c
+++ b/fs/btrfs/raid56.c
@@ -2335,7 +2335,7 @@ static void rmw_rbio_work_locked(struct work_struct *work)
 struct btrfs_raid_bio *raid56_parity_alloc_scrub_rbio(struct bio *bio,
 				struct btrfs_io_context *bioc,
 				struct btrfs_device *scrub_dev,
-				unsigned long *dbitmap, int stripe_nsectors)
+				unsigned long *dbitmap)
 {
 	struct btrfs_fs_info *fs_info = bioc->fs_info;
 	struct btrfs_raid_bio *rbio;
@@ -2365,7 +2365,7 @@ struct btrfs_raid_bio *raid56_parity_alloc_scrub_rbio(struct bio *bio,
 	}
 	ASSERT(i < rbio->real_stripes);
 
-	bitmap_copy(&rbio->dbitmap, dbitmap, stripe_nsectors);
+	bitmap_copy(&rbio->dbitmap, dbitmap, rbio->stripe_nsectors);
 	return rbio;
 }
 
diff --git a/fs/btrfs/raid56.h b/fs/btrfs/raid56.h
index 45e6ff78316f..1871a2a16a1c 100644
--- a/fs/btrfs/raid56.h
+++ b/fs/btrfs/raid56.h
@@ -189,7 +189,7 @@ void raid56_parity_write(struct bio *bio, struct btrfs_io_context *bioc);
 struct btrfs_raid_bio *raid56_parity_alloc_scrub_rbio(struct bio *bio,
 				struct btrfs_io_context *bioc,
 				struct btrfs_device *scrub_dev,
-				unsigned long *dbitmap, int stripe_nsectors);
+				unsigned long *dbitmap);
 void raid56_parity_submit_scrub_rbio(struct btrfs_raid_bio *rbio);
 
 void raid56_parity_cache_data_pages(struct btrfs_raid_bio *rbio,
diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 38c103f13fd5..5a0626a3c23c 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -1914,8 +1914,7 @@ static int scrub_raid56_parity_stripe(struct scrub_ctx *sctx,
 		btrfs_bio_counter_dec(fs_info);
 		goto out;
 	}
-	rbio = raid56_parity_alloc_scrub_rbio(bio, bioc, scrub_dev, &extent_bitmap,
-				BTRFS_STRIPE_LEN >> fs_info->sectorsize_bits);
+	rbio = raid56_parity_alloc_scrub_rbio(bio, bioc, scrub_dev, &extent_bitmap);
 	btrfs_put_bioc(bioc);
 	if (!rbio) {
 		ret = -ENOMEM;
-- 
2.41.0

