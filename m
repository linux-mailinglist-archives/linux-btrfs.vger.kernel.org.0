Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8177958C2FA
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Aug 2022 07:46:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235444AbiHHFqQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 8 Aug 2022 01:46:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233845AbiHHFqP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 8 Aug 2022 01:46:15 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AACADFD5
        for <linux-btrfs@vger.kernel.org>; Sun,  7 Aug 2022 22:46:14 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 6EFA2207FE
        for <linux-btrfs@vger.kernel.org>; Mon,  8 Aug 2022 05:46:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1659937565; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Us0COgSQYKpS+Y2R/5vA4bT8vpNRHaqiyLSZXDynGGs=;
        b=LlX2+99YjccTvjkskH6qKm5SwwFgKnwEfVz5KUiXfHZEt77xhHxbmwVVepadh7WVWqv/gI
        B7411uZ2cKLnsopKPXEPVrtBv44gxYRwuv7KD7DTgozbIhczwv5ZKPOiQSQU5IZkz7/KdL
        qLefnfGtSvLjCtq6z0650GuMyynBAh8=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C95E113523
        for <linux-btrfs@vger.kernel.org>; Mon,  8 Aug 2022 05:46:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id IG0CJRyj8GJpfwAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Mon, 08 Aug 2022 05:46:04 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v3 3/7] btrfs: extract the allocation and initialization of scrub_sector into a helper
Date:   Mon,  8 Aug 2022 13:45:39 +0800
Message-Id: <3566ee9e58a3dfd81fe71b01abda91f617f6e96f.1659936510.git.wqu@suse.com>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <cover.1659936510.git.wqu@suse.com>
References: <cover.1659936510.git.wqu@suse.com>
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

The allocation and initialization is shared by 3 call sites, and we're
going to change the initialization of some members in the upcoming
patches.

So extra the allocation and initialization of scrub_sector into a
helper, alloc_scrub_sector(), which will do the following work:

- Allocate the memory for scrub_sector

- Allocate a page for scrub_sector::page

- Initialize scrub_sector::refs to 1

- Attach the allocated scrub_sector to scrub_block
  The attachment is bidirectional, which means scrub_block::sectorv[]
  will be updated and scrub_sector::sblock will also be updated.

- Update scrub_block::sector_count and do extra sanity check on it

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/scrub.c | 63 ++++++++++++++++++++++++------------------------
 1 file changed, 31 insertions(+), 32 deletions(-)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 51d8e88a3486..d51925403eef 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -215,6 +215,33 @@ static struct scrub_block *alloc_scrub_block(struct scrub_ctx *sctx)
 	return sblock;
 }
 
+/* Allocate a new scrub sector and attach it to @sblock */
+static struct scrub_sector *alloc_scrub_sector(struct scrub_block *sblock,
+					       gfp_t gfp)
+{
+	struct scrub_sector *ssector;
+
+	ssector = kzalloc(sizeof(*ssector), gfp);
+	if (!ssector)
+		return NULL;
+	ssector->page = alloc_page(gfp);
+	if (!ssector->page) {
+		kfree(ssector);
+		return NULL;
+	}
+	atomic_set(&ssector->refs, 1);
+	ssector->sblock = sblock;
+	/* This sector to be added should not be used */
+	ASSERT(sblock->sectors[sblock->sector_count] == NULL);
+	/* And the sector count should be smaller than the limit */
+	ASSERT(sblock->sector_count < SCRUB_MAX_SECTORS_PER_BLOCK);
+
+	sblock->sectors[sblock->sector_count] = ssector;
+	sblock->sector_count++;
+
+	return ssector;
+}
+
 static int scrub_setup_recheck_block(struct scrub_block *original_sblock,
 				     struct scrub_block *sblocks_for_recheck[]);
 static void scrub_recheck_block(struct btrfs_fs_info *fs_info,
@@ -1338,18 +1365,14 @@ static int scrub_setup_recheck_block(struct scrub_block *original_sblock,
 			sblock = sblocks_for_recheck[mirror_index];
 			sblock->sctx = sctx;
 
-			sector = kzalloc(sizeof(*sector), GFP_NOFS);
+			sector = alloc_scrub_sector(sblock, GFP_NOFS);
 			if (!sector) {
-leave_nomem:
 				spin_lock(&sctx->stat_lock);
 				sctx->stat.malloc_errors++;
 				spin_unlock(&sctx->stat_lock);
 				scrub_put_recover(fs_info, recover);
 				return -ENOMEM;
 			}
-			scrub_sector_get(sector);
-			sblock->sectors[sector_index] = sector;
-			sector->sblock = sblock;
 			sector->flags = flags;
 			sector->generation = generation;
 			sector->logical = logical;
@@ -1375,13 +1398,8 @@ static int scrub_setup_recheck_block(struct scrub_block *original_sblock,
 			sector->physical_for_dev_replace =
 				original_sblock->sectors[sector_index]->
 				physical_for_dev_replace;
-			/* For missing devices, dev->bdev is NULL */
+			/* for missing devices, dev->bdev is NULL */
 			sector->mirror_num = mirror_index + 1;
-			sblock->sector_count++;
-			sector->page = alloc_page(GFP_NOFS);
-			if (!sector->page)
-				goto leave_nomem;
-
 			scrub_get_recover(recover);
 			sector->recover = recover;
 		}
@@ -2253,19 +2271,14 @@ static int scrub_sectors(struct scrub_ctx *sctx, u64 logical, u32 len,
 		 */
 		u32 l = min(sectorsize, len);
 
-		sector = kzalloc(sizeof(*sector), GFP_KERNEL);
+		sector = alloc_scrub_sector(sblock, GFP_KERNEL);
 		if (!sector) {
-leave_nomem:
 			spin_lock(&sctx->stat_lock);
 			sctx->stat.malloc_errors++;
 			spin_unlock(&sctx->stat_lock);
 			scrub_block_put(sblock);
 			return -ENOMEM;
 		}
-		ASSERT(index < SCRUB_MAX_SECTORS_PER_BLOCK);
-		scrub_sector_get(sector);
-		sblock->sectors[index] = sector;
-		sector->sblock = sblock;
 		sector->dev = dev;
 		sector->flags = flags;
 		sector->generation = gen;
@@ -2279,10 +2292,6 @@ static int scrub_sectors(struct scrub_ctx *sctx, u64 logical, u32 len,
 		} else {
 			sector->have_csum = 0;
 		}
-		sblock->sector_count++;
-		sector->page = alloc_page(GFP_KERNEL);
-		if (!sector->page)
-			goto leave_nomem;
 		len -= l;
 		logical += l;
 		physical += l;
@@ -2597,23 +2606,18 @@ static int scrub_sectors_for_parity(struct scrub_parity *sparity,
 	for (index = 0; len > 0; index++) {
 		struct scrub_sector *sector;
 
-		sector = kzalloc(sizeof(*sector), GFP_KERNEL);
+		sector = alloc_scrub_sector(sblock, GFP_KERNEL);
 		if (!sector) {
-leave_nomem:
 			spin_lock(&sctx->stat_lock);
 			sctx->stat.malloc_errors++;
 			spin_unlock(&sctx->stat_lock);
 			scrub_block_put(sblock);
 			return -ENOMEM;
 		}
-		ASSERT(index < SCRUB_MAX_SECTORS_PER_BLOCK);
-		/* For scrub block */
-		scrub_sector_get(sector);
 		sblock->sectors[index] = sector;
 		/* For scrub parity */
 		scrub_sector_get(sector);
 		list_add_tail(&sector->list, &sparity->sectors_list);
-		sector->sblock = sblock;
 		sector->dev = dev;
 		sector->flags = flags;
 		sector->generation = gen;
@@ -2626,11 +2630,6 @@ static int scrub_sectors_for_parity(struct scrub_parity *sparity,
 		} else {
 			sector->have_csum = 0;
 		}
-		sblock->sector_count++;
-		sector->page = alloc_page(GFP_KERNEL);
-		if (!sector->page)
-			goto leave_nomem;
-
 
 		/* Iterate over the stripe range in sectorsize steps */
 		len -= sectorsize;
-- 
2.37.0

