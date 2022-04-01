Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 200E24EEC51
	for <lists+linux-btrfs@lfdr.de>; Fri,  1 Apr 2022 13:24:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345516AbiDAL0A (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 1 Apr 2022 07:26:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345496AbiDALZ4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 1 Apr 2022 07:25:56 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45D1D196139
        for <linux-btrfs@vger.kernel.org>; Fri,  1 Apr 2022 04:24:06 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 0879E21612
        for <linux-btrfs@vger.kernel.org>; Fri,  1 Apr 2022 11:24:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1648812245; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DetKO2fpfHlrtsFb6AeF0ceMG/o5s5bZUsmhqaY/Lrg=;
        b=vYrKauN4Q6pg/pgDrmzlAfeEj1FW9OMgM6gIrnl5P621ujzCSPXucSipyPc+UxRzT9u1It
        I1vPOmzXL0/qdxEiSJhNJGOhwS+9/rEhvy7Gcev0uwXczcKe9+AkwL2xmJnA/SiclBT/do
        20YTSg9ueTVrWAAsV1Z7Z0bK/fRDfHU=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 66CC9132C1
        for <linux-btrfs@vger.kernel.org>; Fri,  1 Apr 2022 11:24:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id aCS3DNTgRmJeFwAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Fri, 01 Apr 2022 11:24:04 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 15/16] btrfs: make alloc_rbio_essential_pages() subpage compatible
Date:   Fri,  1 Apr 2022 19:23:30 +0800
Message-Id: <a65971704205419d5f7d28e968ee098dd7eb93cd.1648807440.git.wqu@suse.com>
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

The non-compatible part is only the bitmap iteration part, now the
bitmap size is extended to rbio::stripe_nsectors, not the old
rbio::stripe_npages.

Since we're here, also slightly improve the function by:

- Rename @i to @stripe
- Rename @bit to @sectornr
- Move @page and @index into the inner loop

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/raid56.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
index 01fe5414e013..7bfe8e8d8325 100644
--- a/fs/btrfs/raid56.c
+++ b/fs/btrfs/raid56.c
@@ -2456,14 +2456,16 @@ void raid56_add_scrub_pages(struct btrfs_raid_bio *rbio, struct page *page,
  */
 static int alloc_rbio_essential_pages(struct btrfs_raid_bio *rbio)
 {
-	int i;
-	int bit;
-	int index;
-	struct page *page;
+	const u32 sectorsize = rbio->bioc->fs_info->sectorsize;
+	int stripe;
+	int sectornr;
+
+	for_each_set_bit(sectornr, rbio->dbitmap, rbio->stripe_nsectors) {
+		for (stripe = 0; stripe < rbio->real_stripes; stripe++) {
+			struct page *page;
+			int index = (stripe * rbio->stripe_nsectors + sectornr) *
+				    sectorsize >> PAGE_SHIFT;
 
-	for_each_set_bit(bit, rbio->dbitmap, rbio->stripe_npages) {
-		for (i = 0; i < rbio->real_stripes; i++) {
-			index = i * rbio->stripe_npages + bit;
 			if (rbio->stripe_pages[index])
 				continue;
 
-- 
2.35.1

