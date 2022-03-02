Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 913CB4C9FAD
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Mar 2022 09:45:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240044AbiCBIp3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Mar 2022 03:45:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240106AbiCBIpR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 2 Mar 2022 03:45:17 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92673BAB92
        for <linux-btrfs@vger.kernel.org>; Wed,  2 Mar 2022 00:44:33 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id E46181F37E
        for <linux-btrfs@vger.kernel.org>; Wed,  2 Mar 2022 08:44:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1646210671; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9pPf/VWT2Xoo1ONooEZLJ+pvzb1ELG35JSer9HoiNZs=;
        b=lKEZNvs5bPHtxn9o08zuerIzq5INT1QLpWnE6w4vW13MsiU4wF9tCOTn8TwEBrfmGjCntS
        9bdF1pCT8B2wGC9x04IE5+l4NA16jmKj5ZqhcTC+k21WOfOySY9NPIlXteO+q3+oLg7KcS
        m4QevY2cd6xaoVJRbjYjDPWIyWB7wa4=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1E8D413345
        for <linux-btrfs@vger.kernel.org>; Wed,  2 Mar 2022 08:44:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id sBZuNG4uH2JHTAAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Wed, 02 Mar 2022 08:44:30 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 3/5] btrfs: extract the allocation and initialization of scrub_sector into a helper
Date:   Wed,  2 Mar 2022 16:44:06 +0800
Message-Id: <8dc1db7e3961db24316ce1042e9dfc5e3146c1b8.1646210538.git.wqu@suse.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1646210538.git.wqu@suse.com>
References: <cover.1646210538.git.wqu@suse.com>
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
 fs/btrfs/scrub.c | 61 ++++++++++++++++++++++++------------------------
 1 file changed, 30 insertions(+), 31 deletions(-)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 8ccd25666986..bab717e80918 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -217,6 +217,33 @@ static struct scrub_block *alloc_scrub_block(struct scrub_ctx *sctx)
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
+	ASSERT(sblock->sectorv[sblock->sector_count] == NULL);
+	/* And the sector count should be smaller than the limit */
+	ASSERT(sblock->sector_count < SCRUB_MAX_SECTORS_PER_BLOCK);
+
+	sblock->sectorv[sblock->sector_count] = ssector;
+	sblock->sector_count++;
+
+	return ssector;
+}
+
 static int scrub_setup_recheck_block(struct scrub_block *original_sblock,
 				     struct scrub_block *sblocks_for_recheck[]);
 static void scrub_recheck_block(struct btrfs_fs_info *fs_info,
@@ -1336,18 +1363,14 @@ static int scrub_setup_recheck_block(struct scrub_block *original_sblock,
 			sblock = sblocks_for_recheck[mirror_index];
 			sblock->sctx = sctx;
 
-			ssector = kzalloc(sizeof(*ssector), GFP_NOFS);
+			ssector = alloc_scrub_sector(sblock, GFP_NOFS);
 			if (!ssector) {
-leave_nomem:
 				spin_lock(&sctx->stat_lock);
 				sctx->stat.malloc_errors++;
 				spin_unlock(&sctx->stat_lock);
 				scrub_put_recover(fs_info, recover);
 				return -ENOMEM;
 			}
-			scrub_sector_get(ssector);
-			sblock->sectorv[sector_index] = ssector;
-			ssector->sblock = sblock;
 			ssector->flags = flags;
 			ssector->generation = generation;
 			ssector->logical = logical;
@@ -1376,11 +1399,6 @@ static int scrub_setup_recheck_block(struct scrub_block *original_sblock,
 				physical_for_dev_replace;
 			/* for missing devices, dev->bdev is NULL */
 			ssector->mirror_num = mirror_index + 1;
-			sblock->sector_count++;
-			ssector->page = alloc_page(GFP_NOFS);
-			if (!ssector->page)
-				goto leave_nomem;
-
 			scrub_get_recover(recover);
 			ssector->recover = recover;
 		}
@@ -2293,19 +2311,14 @@ static int scrub_sectors(struct scrub_ctx *sctx, u64 logical, u32 len,
 		 */
 		u32 l = min(sectorsize, len);
 
-		ssector = kzalloc(sizeof(*ssector), GFP_KERNEL);
+		ssector = alloc_scrub_sector(sblock, GFP_KERNEL);
 		if (!ssector) {
-leave_nomem:
 			spin_lock(&sctx->stat_lock);
 			sctx->stat.malloc_errors++;
 			spin_unlock(&sctx->stat_lock);
 			scrub_block_put(sblock);
 			return -ENOMEM;
 		}
-		ASSERT(index < SCRUB_MAX_SECTORS_PER_BLOCK);
-		scrub_sector_get(ssector);
-		sblock->sectorv[index] = ssector;
-		ssector->sblock = sblock;
 		ssector->dev = dev;
 		ssector->flags = flags;
 		ssector->generation = gen;
@@ -2319,10 +2332,6 @@ static int scrub_sectors(struct scrub_ctx *sctx, u64 logical, u32 len,
 		} else {
 			ssector->have_csum = 0;
 		}
-		sblock->sector_count++;
-		ssector->page = alloc_page(GFP_KERNEL);
-		if (!ssector->page)
-			goto leave_nomem;
 		len -= l;
 		logical += l;
 		physical += l;
@@ -2637,23 +2646,18 @@ static int scrub_sectors_for_parity(struct scrub_parity *sparity,
 	for (index = 0; len > 0; index++) {
 		struct scrub_sector *ssector;
 
-		ssector = kzalloc(sizeof(*ssector), GFP_KERNEL);
+		ssector = alloc_scrub_sector(sblock, GFP_KERNEL);
 		if (!ssector) {
-leave_nomem:
 			spin_lock(&sctx->stat_lock);
 			sctx->stat.malloc_errors++;
 			spin_unlock(&sctx->stat_lock);
 			scrub_block_put(sblock);
 			return -ENOMEM;
 		}
-		ASSERT(index < SCRUB_MAX_SECTORS_PER_BLOCK);
-		/* For scrub block */
-		scrub_sector_get(ssector);
 		sblock->sectorv[index] = ssector;
 		/* For scrub parity */
 		scrub_sector_get(ssector);
 		list_add_tail(&ssector->list, &sparity->ssectors);
-		ssector->sblock = sblock;
 		ssector->dev = dev;
 		ssector->flags = flags;
 		ssector->generation = gen;
@@ -2666,11 +2670,6 @@ static int scrub_sectors_for_parity(struct scrub_parity *sparity,
 		} else {
 			ssector->have_csum = 0;
 		}
-		sblock->sector_count++;
-		ssector->page = alloc_page(GFP_KERNEL);
-		if (!ssector->page)
-			goto leave_nomem;
-
 
 		/* Iterate over the stripe range in sectorsize steps */
 		len -= sectorsize;
-- 
2.35.1

