Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D805058C2FB
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Aug 2022 07:46:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235437AbiHHFqQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 8 Aug 2022 01:46:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235001AbiHHFqN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 8 Aug 2022 01:46:13 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6978101C6
        for <linux-btrfs@vger.kernel.org>; Sun,  7 Aug 2022 22:46:12 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 6DFFC34974
        for <linux-btrfs@vger.kernel.org>; Mon,  8 Aug 2022 05:46:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1659937571; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yeSqolFv1XCR7eGOdUTolFhEJQ3iq5sOBKzeUcR9rmc=;
        b=Jm/hiSqs8WRxpIqsvww42B7RuzsghF4wNs5hPBCXu8FGUaNxDmMkSbL9Y7wPkrMUqryHP/
        hVMzJIUkWg84bLFlQv/RmDNIkb7ocwL0RHRaKO0Ti6bkwVcrOcO916vSmxyC53QF8SKQoe
        HF/LQ+AmdjisDCXG8ASgncJvf/ar65Q=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C764D13523
        for <linux-btrfs@vger.kernel.org>; Mon,  8 Aug 2022 05:46:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id gDR3JCKj8GJpfwAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Mon, 08 Aug 2022 05:46:10 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v3 7/7] btrfs: use larger blocksize for data extent scrub
Date:   Mon,  8 Aug 2022 13:45:43 +0800
Message-Id: <5eeff66dec955d3168ef2a4abb120a063d55e78c.1659936510.git.wqu@suse.com>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <cover.1659936510.git.wqu@suse.com>
References: <cover.1659936510.git.wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[PROBLEM]
The existing scrub code for data extents always limit the blocksize to
sectorsize.

This causes quite some extra scrub_block being allocated:
(there is a data extent at logical bytenr 298844160, length 64KiB)

 alloc_scrub_block: new block: logical=298844160 physical=298844160 mirror=1
 alloc_scrub_block: new block: logical=298848256 physical=298848256 mirror=1
 alloc_scrub_block: new block: logical=298852352 physical=298852352 mirror=1
 alloc_scrub_block: new block: logical=298856448 physical=298856448 mirror=1
 alloc_scrub_block: new block: logical=298860544 physical=298860544 mirror=1
 alloc_scrub_block: new block: logical=298864640 physical=298864640 mirror=1
 alloc_scrub_block: new block: logical=298868736 physical=298868736 mirror=1
 alloc_scrub_block: new block: logical=298872832 physical=298872832 mirror=1
 alloc_scrub_block: new block: logical=298876928 physical=298876928 mirror=1
 alloc_scrub_block: new block: logical=298881024 physical=298881024 mirror=1
 alloc_scrub_block: new block: logical=298885120 physical=298885120 mirror=1
 alloc_scrub_block: new block: logical=298889216 physical=298889216 mirror=1
 alloc_scrub_block: new block: logical=298893312 physical=298893312 mirror=1
 alloc_scrub_block: new block: logical=298897408 physical=298897408 mirror=1
 alloc_scrub_block: new block: logical=298901504 physical=298901504 mirror=1
 alloc_scrub_block: new block: logical=298905600 physical=298905600 mirror=1
 ...
 scrub_block_put: free block: logical=298844160 physical=298844160 len=4096 mirror=1
 scrub_block_put: free block: logical=298848256 physical=298848256 len=4096 mirror=1
 scrub_block_put: free block: logical=298852352 physical=298852352 len=4096 mirror=1
 scrub_block_put: free block: logical=298856448 physical=298856448 len=4096 mirror=1
 scrub_block_put: free block: logical=298860544 physical=298860544 len=4096 mirror=1
 scrub_block_put: free block: logical=298864640 physical=298864640 len=4096 mirror=1
 scrub_block_put: free block: logical=298868736 physical=298868736 len=4096 mirror=1
 scrub_block_put: free block: logical=298872832 physical=298872832 len=4096 mirror=1
 scrub_block_put: free block: logical=298876928 physical=298876928 len=4096 mirror=1
 scrub_block_put: free block: logical=298881024 physical=298881024 len=4096 mirror=1
 scrub_block_put: free block: logical=298885120 physical=298885120 len=4096 mirror=1
 scrub_block_put: free block: logical=298889216 physical=298889216 len=4096 mirror=1
 scrub_block_put: free block: logical=298893312 physical=298893312 len=4096 mirror=1
 scrub_block_put: free block: logical=298897408 physical=298897408 len=4096 mirror=1
 scrub_block_put: free block: logical=298901504 physical=298901504 len=4096 mirror=1
 scrub_block_put: free block: logical=298905600 physical=298905600 len=4096 mirror=1

This behavior will waste a lot of memory, especially after we have move
quite some members from scrub_sector to scrub_block.

[FIX]
To reduce the allocation of scrub_block, and reduce memory usage, this
patch will use BTRFS_STRIPE_LEN instead of sectorsize as the blocksize
to scrub data extents.

This results only one scrub_block to be allocated for above data extent:
 alloc_scrub_block: new block: logical=298844160 physical=298844160 mirror=1
 scrub_block_put: free block: logical=298844160 physical=298844160 len=65536 mirror=1

This would greatly reduce the memory usage (even it's just transient)
for larger data extents scrub.

For above example, the memory usage would be:

Old: num_sectors * (sizeof(scrub_block) + sizeof(scrub_sector))
     16          * (408                  + 96) = 8065

New: sizeof(scrub_block) + num_sectors * sizeof(scrub_sector)
     408                 + 16          * 96 = 1944

A good reduction of 75.9%.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/scrub.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 6c5be7cf00d0..ff251b7fbd47 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -2671,11 +2671,17 @@ static int scrub_extent(struct scrub_ctx *sctx, struct map_lookup *map,
 	u8 csum[BTRFS_CSUM_SIZE];
 	u32 blocksize;
 
+	/*
+	 * Block size determines how many scrub_block will be allocated.
+	 * Here we use BTRFS_STRIPE_LEN (64KiB) as default limit, so we
+	 * won't allocate too many scrub_block, while still won't cause
+	 * too large bios for large extents.
+	 */
 	if (flags & BTRFS_EXTENT_FLAG_DATA) {
 		if (map->type & BTRFS_BLOCK_GROUP_RAID56_MASK)
 			blocksize = map->stripe_len;
 		else
-			blocksize = sctx->fs_info->sectorsize;
+			blocksize = BTRFS_STRIPE_LEN;
 		spin_lock(&sctx->stat_lock);
 		sctx->stat.data_extents_scrubbed++;
 		sctx->stat.data_bytes_scrubbed += len;
-- 
2.37.0

