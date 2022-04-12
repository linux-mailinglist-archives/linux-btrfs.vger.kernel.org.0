Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 641234FDCB9
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Apr 2022 13:06:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352931AbiDLKia (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 12 Apr 2022 06:38:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354496AbiDLKdl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 12 Apr 2022 06:33:41 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 872E45B3FF
        for <linux-btrfs@vger.kernel.org>; Tue, 12 Apr 2022 02:33:45 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 37CE521609
        for <linux-btrfs@vger.kernel.org>; Tue, 12 Apr 2022 09:33:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1649756024; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Fq8ocL1FRdC4cUlhpDvjkl5ml+OjEt95oGBGfmJ6UWg=;
        b=Sk6kGJkAYvTKT+yqxSHacB9yO1Q9B1UDFhKX0JEf2KXlA+hB/Eo55hcB12JIIRk2LoK16o
        7+Os+ldbfZ1ZGtyXmdK09UY7NkFnPRSfaG5hJzzKDzxoxSpRVrfgl/19SjIV+TtrHr/fFG
        hhLXEPI8w232SVN/XNI9KcBskvNPyzg=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 851D613A99
        for <linux-btrfs@vger.kernel.org>; Tue, 12 Apr 2022 09:33:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id KJxfE3dHVWI8LwAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Tue, 12 Apr 2022 09:33:43 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 16/17] btrfs: make alloc_rbio_essential_pages() subpage compatible
Date:   Tue, 12 Apr 2022 17:33:06 +0800
Message-Id: <d34b0f871c07b97fa528e5756d3c85e89a6e9eb2.1649753690.git.wqu@suse.com>
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
index d0f9bee0c10d..ef3d3b67098b 100644
--- a/fs/btrfs/raid56.c
+++ b/fs/btrfs/raid56.c
@@ -2422,14 +2422,16 @@ void raid56_add_scrub_pages(struct btrfs_raid_bio *rbio, struct page *page,
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

