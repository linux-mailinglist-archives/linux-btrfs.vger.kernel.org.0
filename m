Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E67458C2F5
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Aug 2022 07:46:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235340AbiHHFqJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 8 Aug 2022 01:46:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231756AbiHHFqI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 8 Aug 2022 01:46:08 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C9C9DFD4
        for <linux-btrfs@vger.kernel.org>; Sun,  7 Aug 2022 22:46:05 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id EDF4234968
        for <linux-btrfs@vger.kernel.org>; Mon,  8 Aug 2022 05:46:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1659937562; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HfzZRuXMuFtOuWsuxXQO0p3Xn/HSWG4KaKQ8VJsTlmI=;
        b=INmiXKAO8kocLf8xw0LrSbJeO49CufhpbSo+uTaLF++qFr46VfAoqWyH2nOzdF3W9ASm0R
        hKhrhR8Vt6mbNRNheI5Ca0HJIx2D0d5vtuNPitl+XWowZtgq70OJdab+nYDw+3ehSKz0F1
        B2pS7WvMGaherD+X5APSO3gW7kmcT4E=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E0DF313523
        for <linux-btrfs@vger.kernel.org>; Mon,  8 Aug 2022 05:46:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id +HnWKhmj8GJpfwAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Mon, 08 Aug 2022 05:46:01 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v3 1/7] btrfs: scrub: use pointer array to replace @sblocks_for_recheck
Date:   Mon,  8 Aug 2022 13:45:37 +0800
Message-Id: <bc37c5c917fc3cee957127201ebcb04c33da61d8.1659936510.git.wqu@suse.com>
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

In function scrub_handle_errored_block(), we use @sblocks_for_recheck
pointer to hold one scrub_block for each mirror, and uses kcalloc() to
allocate an array.

But this one pointer for an array is not really reader friendly.

Just change this pointer to struct scrub_block *[BTRFS_MAX_MIRRORS],
this will slightly increase the stack memory usage.

Since function scrub_handle_errored_block() won't get iterative calls,
this extra cost would completely be acceptable.

And since we're here, also set sblock->refs and use scrub_block_put() to
clean them up, as later we will add extra members in scrub_block, which
needs scrub_block_put() to clean them up.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/scrub.c | 102 ++++++++++++++++++++++++++---------------------
 1 file changed, 56 insertions(+), 46 deletions(-)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index d05025034b0a..9beb293ac4b2 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -203,7 +203,7 @@ struct full_stripe_lock {
 };
 
 static int scrub_setup_recheck_block(struct scrub_block *original_sblock,
-				     struct scrub_block *sblocks_for_recheck);
+				     struct scrub_block *sblocks_for_recheck[]);
 static void scrub_recheck_block(struct btrfs_fs_info *fs_info,
 				struct scrub_block *sblock,
 				int retry_failed_mirror);
@@ -817,7 +817,8 @@ static int scrub_handle_errored_block(struct scrub_block *sblock_to_check)
 	unsigned int failed_mirror_index;
 	unsigned int is_metadata;
 	unsigned int have_csum;
-	struct scrub_block *sblocks_for_recheck; /* holds one for each mirror */
+	/* One scrub_block for each mirror */
+	struct scrub_block *sblocks_for_recheck[BTRFS_MAX_MIRRORS] = { 0 };
 	struct scrub_block *sblock_bad;
 	int ret;
 	int mirror_index;
@@ -910,17 +911,29 @@ static int scrub_handle_errored_block(struct scrub_block *sblock_to_check)
 	 * repaired area is verified in order to correctly maintain
 	 * the statistics.
 	 */
-
-	sblocks_for_recheck = kcalloc(BTRFS_MAX_MIRRORS,
-				      sizeof(*sblocks_for_recheck), GFP_KERNEL);
-	if (!sblocks_for_recheck) {
-		spin_lock(&sctx->stat_lock);
-		sctx->stat.malloc_errors++;
-		sctx->stat.read_errors++;
-		sctx->stat.uncorrectable_errors++;
-		spin_unlock(&sctx->stat_lock);
-		btrfs_dev_stat_inc_and_print(dev, BTRFS_DEV_STAT_READ_ERRS);
-		goto out;
+	for (mirror_index = 0; mirror_index < BTRFS_MAX_MIRRORS; mirror_index++) {
+		sblocks_for_recheck[mirror_index] =
+			kzalloc(sizeof(struct scrub_block), GFP_KERNEL);
+		if (!sblocks_for_recheck[mirror_index]) {
+			spin_lock(&sctx->stat_lock);
+			sctx->stat.malloc_errors++;
+			sctx->stat.read_errors++;
+			sctx->stat.uncorrectable_errors++;
+			spin_unlock(&sctx->stat_lock);
+			btrfs_dev_stat_inc_and_print(dev,
+						     BTRFS_DEV_STAT_READ_ERRS);
+			goto out;
+		}
+		/*
+		 * note: the two members refs and outstanding_sectors
+		 * are not used in the blocks that are used for the recheck
+		 * procedure.
+		 *
+		 * But to make the cleanup easier, we just put one ref for
+		 * each sblocks.
+		 */
+		refcount_set(&sblocks_for_recheck[mirror_index]->refs, 1);
+		sblocks_for_recheck[mirror_index]->sctx = sctx;
 	}
 
 	/* Setup the context, map the logical blocks and alloc the sectors */
@@ -934,7 +947,7 @@ static int scrub_handle_errored_block(struct scrub_block *sblock_to_check)
 		goto out;
 	}
 	BUG_ON(failed_mirror_index >= BTRFS_MAX_MIRRORS);
-	sblock_bad = sblocks_for_recheck + failed_mirror_index;
+	sblock_bad = sblocks_for_recheck[failed_mirror_index];
 
 	/* build and submit the bios for the failed mirror, check checksums */
 	scrub_recheck_block(fs_info, sblock_bad, 1);
@@ -1019,21 +1032,21 @@ static int scrub_handle_errored_block(struct scrub_block *sblock_to_check)
 		if (!scrub_is_page_on_raid56(sblock_bad->sectors[0])) {
 			if (mirror_index >= BTRFS_MAX_MIRRORS)
 				break;
-			if (!sblocks_for_recheck[mirror_index].sector_count)
+			if (!sblocks_for_recheck[mirror_index]->sector_count)
 				break;
 
-			sblock_other = sblocks_for_recheck + mirror_index;
+			sblock_other = sblocks_for_recheck[mirror_index];
 		} else {
 			struct scrub_recover *r = sblock_bad->sectors[0]->recover;
 			int max_allowed = r->bioc->num_stripes - r->bioc->num_tgtdevs;
 
 			if (mirror_index >= max_allowed)
 				break;
-			if (!sblocks_for_recheck[1].sector_count)
+			if (!sblocks_for_recheck[1]->sector_count)
 				break;
 
 			ASSERT(failed_mirror_index == 0);
-			sblock_other = sblocks_for_recheck + 1;
+			sblock_other = sblocks_for_recheck[1];
 			sblock_other->sectors[0]->mirror_num = 1 + mirror_index;
 		}
 
@@ -1105,12 +1118,11 @@ static int scrub_handle_errored_block(struct scrub_block *sblock_to_check)
 			/* Try to find no-io-error sector in mirrors */
 			for (mirror_index = 0;
 			     mirror_index < BTRFS_MAX_MIRRORS &&
-			     sblocks_for_recheck[mirror_index].sector_count > 0;
+			     sblocks_for_recheck[mirror_index]->sector_count > 0;
 			     mirror_index++) {
-				if (!sblocks_for_recheck[mirror_index].
+				if (!sblocks_for_recheck[mirror_index]->
 				    sectors[sector_num]->io_error) {
-					sblock_other = sblocks_for_recheck +
-						       mirror_index;
+					sblock_other = sblocks_for_recheck[mirror_index];
 					break;
 				}
 			}
@@ -1184,25 +1196,28 @@ static int scrub_handle_errored_block(struct scrub_block *sblock_to_check)
 	}
 
 out:
-	if (sblocks_for_recheck) {
-		for (mirror_index = 0; mirror_index < BTRFS_MAX_MIRRORS;
-		     mirror_index++) {
-			struct scrub_block *sblock = sblocks_for_recheck +
-						     mirror_index;
-			struct scrub_recover *recover;
-			int i;
-
-			for (i = 0; i < sblock->sector_count; i++) {
-				sblock->sectors[i]->sblock = NULL;
-				recover = sblock->sectors[i]->recover;
-				if (recover) {
-					scrub_put_recover(fs_info, recover);
-					sblock->sectors[i]->recover = NULL;
-				}
-				scrub_sector_put(sblock->sectors[i]);
+	for (mirror_index = 0; mirror_index < BTRFS_MAX_MIRRORS; mirror_index++) {
+		struct scrub_block *sblock = sblocks_for_recheck[mirror_index];
+		struct scrub_recover *recover;
+		int sector_index;
+
+		/* Not allocated, continue checking the next mirror */
+		if (!sblock)
+			continue;
+
+		for (sector_index = 0; sector_index < sblock->sector_count;
+		     sector_index++) {
+			/*
+			 * Here we just cleanup the recover, each sector will be
+			 * properly cleaned up by later scrub_block_put()
+			 */
+			recover = sblock->sectors[sector_index]->recover;
+			if (recover) {
+				scrub_put_recover(fs_info, recover);
+				sblock->sectors[sector_index]->recover = NULL;
 			}
 		}
-		kfree(sblocks_for_recheck);
+		scrub_block_put(sblock);
 	}
 
 	ret = unlock_full_stripe(fs_info, logical, full_stripe_locked);
@@ -1252,7 +1267,7 @@ static inline void scrub_stripe_index_and_offset(u64 logical, u64 map_type,
 }
 
 static int scrub_setup_recheck_block(struct scrub_block *original_sblock,
-				     struct scrub_block *sblocks_for_recheck)
+				     struct scrub_block *sblocks_for_recheck[])
 {
 	struct scrub_ctx *sctx = original_sblock->sctx;
 	struct btrfs_fs_info *fs_info = sctx->fs_info;
@@ -1272,11 +1287,6 @@ static int scrub_setup_recheck_block(struct scrub_block *original_sblock,
 	int nmirrors;
 	int ret;
 
-	/*
-	 * Note: the two members refs and outstanding_sectors are not used (and
-	 * not set) in the blocks that are used for the recheck procedure.
-	 */
-
 	while (length > 0) {
 		sublen = min_t(u64, length, fs_info->sectorsize);
 		mapped_length = sublen;
@@ -1315,7 +1325,7 @@ static int scrub_setup_recheck_block(struct scrub_block *original_sblock,
 			struct scrub_block *sblock;
 			struct scrub_sector *sector;
 
-			sblock = sblocks_for_recheck + mirror_index;
+			sblock = sblocks_for_recheck[mirror_index];
 			sblock->sctx = sctx;
 
 			sector = kzalloc(sizeof(*sector), GFP_NOFS);
-- 
2.37.0

