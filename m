Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26C014D5C67
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Mar 2022 08:34:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347211AbiCKHfq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 11 Mar 2022 02:35:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347203AbiCKHfp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 11 Mar 2022 02:35:45 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6424E1B71AF
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Mar 2022 23:34:41 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 1102A218FE
        for <linux-btrfs@vger.kernel.org>; Fri, 11 Mar 2022 07:34:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1646984080; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MENnxvyzpoeaPTp2FT0S5oIyhOQFwvVBVxhjWuRgZIU=;
        b=a8iTrY8oedLbjxDnqX7ZmTU6NosOsc+rE+52tILRUxwsFhl13m7JTbMEoey2aaEFfbvlOS
        6YTuDa1PHlIgggpxm3/jka/74djTjyBNEVj6kLNptD4DLAgOcT8/CUJafRBmi2QarNhK9F
        LoIhN4QE06dSafCNi5kZwUwHpUBVtBA=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6044013A82
        for <linux-btrfs@vger.kernel.org>; Fri, 11 Mar 2022 07:34:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id qGBWCo/7KmIrJQAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Fri, 11 Mar 2022 07:34:39 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 1/3] btrfs: scrub: rename members related to scrub_block::pagev
Date:   Fri, 11 Mar 2022 15:34:18 +0800
Message-Id: <b971391a31a3cee8f7c19d02dd2a48328c580d1b.1646983771.git.wqu@suse.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1646983771.git.wqu@suse.com>
References: <cover.1646983771.git.wqu@suse.com>
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

The following will be renamed in this patch:

- scrub_block::pagev -> sectorv

- scrub_block::page_count -> sector_count

- SCRUB_MAX_PAGES_PER_BLOCK -> SCRUB_MAX_SECTORS_PER_BLOCK

- page_num -> sector_num to iterate scrub_block::sectorv

For now scrub_page is not yet renamed, as the current changeset is
already large enough.

The rename for scrub_page will come in a separate patch.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/scrub.c | 220 +++++++++++++++++++++++------------------------
 1 file changed, 110 insertions(+), 110 deletions(-)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 11089568b287..fd67e1acdba6 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -52,7 +52,7 @@ struct scrub_ctx;
  * The following value times PAGE_SIZE needs to be large enough to match the
  * largest node/leaf/sector size that shall be supported.
  */
-#define SCRUB_MAX_PAGES_PER_BLOCK	(BTRFS_MAX_METADATA_BLOCKSIZE / SZ_4K)
+#define SCRUB_MAX_SECTORS_PER_BLOCK	(BTRFS_MAX_METADATA_BLOCKSIZE / SZ_4K)
 
 struct scrub_recover {
 	refcount_t		refs;
@@ -94,8 +94,8 @@ struct scrub_bio {
 };
 
 struct scrub_block {
-	struct scrub_page	*pagev[SCRUB_MAX_PAGES_PER_BLOCK];
-	int			page_count;
+	struct scrub_page	*sectorv[SCRUB_MAX_SECTORS_PER_BLOCK];
+	int			sector_count;
 	atomic_t		outstanding_pages;
 	refcount_t		refs; /* free mem on transition to zero */
 	struct scrub_ctx	*sctx;
@@ -728,16 +728,16 @@ static void scrub_print_warning(const char *errstr, struct scrub_block *sblock)
 	u8 ref_level = 0;
 	int ret;
 
-	WARN_ON(sblock->page_count < 1);
-	dev = sblock->pagev[0]->dev;
+	WARN_ON(sblock->sector_count < 1);
+	dev = sblock->sectorv[0]->dev;
 	fs_info = sblock->sctx->fs_info;
 
 	path = btrfs_alloc_path();
 	if (!path)
 		return;
 
-	swarn.physical = sblock->pagev[0]->physical;
-	swarn.logical = sblock->pagev[0]->logical;
+	swarn.physical = sblock->sectorv[0]->physical;
+	swarn.logical = sblock->sectorv[0]->logical;
 	swarn.errstr = errstr;
 	swarn.dev = NULL;
 
@@ -817,16 +817,16 @@ static int scrub_handle_errored_block(struct scrub_block *sblock_to_check)
 	struct scrub_block *sblock_bad;
 	int ret;
 	int mirror_index;
-	int page_num;
+	int sector_num;
 	int success;
 	bool full_stripe_locked;
 	unsigned int nofs_flag;
 	static DEFINE_RATELIMIT_STATE(rs, DEFAULT_RATELIMIT_INTERVAL,
 				      DEFAULT_RATELIMIT_BURST);
 
-	BUG_ON(sblock_to_check->page_count < 1);
+	BUG_ON(sblock_to_check->sector_count < 1);
 	fs_info = sctx->fs_info;
-	if (sblock_to_check->pagev[0]->flags & BTRFS_EXTENT_FLAG_SUPER) {
+	if (sblock_to_check->sectorv[0]->flags & BTRFS_EXTENT_FLAG_SUPER) {
 		/*
 		 * if we find an error in a super block, we just report it.
 		 * They will get written with the next transaction commit
@@ -837,13 +837,13 @@ static int scrub_handle_errored_block(struct scrub_block *sblock_to_check)
 		spin_unlock(&sctx->stat_lock);
 		return 0;
 	}
-	logical = sblock_to_check->pagev[0]->logical;
-	BUG_ON(sblock_to_check->pagev[0]->mirror_num < 1);
-	failed_mirror_index = sblock_to_check->pagev[0]->mirror_num - 1;
-	is_metadata = !(sblock_to_check->pagev[0]->flags &
+	logical = sblock_to_check->sectorv[0]->logical;
+	BUG_ON(sblock_to_check->sectorv[0]->mirror_num < 1);
+	failed_mirror_index = sblock_to_check->sectorv[0]->mirror_num - 1;
+	is_metadata = !(sblock_to_check->sectorv[0]->flags &
 			BTRFS_EXTENT_FLAG_DATA);
-	have_csum = sblock_to_check->pagev[0]->have_csum;
-	dev = sblock_to_check->pagev[0]->dev;
+	have_csum = sblock_to_check->sectorv[0]->have_csum;
+	dev = sblock_to_check->sectorv[0]->dev;
 
 	if (!sctx->is_dev_replace && btrfs_repair_one_zone(fs_info, logical))
 		return 0;
@@ -1011,25 +1011,25 @@ static int scrub_handle_errored_block(struct scrub_block *sblock_to_check)
 			continue;
 
 		/* raid56's mirror can be more than BTRFS_MAX_MIRRORS */
-		if (!scrub_is_page_on_raid56(sblock_bad->pagev[0])) {
+		if (!scrub_is_page_on_raid56(sblock_bad->sectorv[0])) {
 			if (mirror_index >= BTRFS_MAX_MIRRORS)
 				break;
-			if (!sblocks_for_recheck[mirror_index].page_count)
+			if (!sblocks_for_recheck[mirror_index].sector_count)
 				break;
 
 			sblock_other = sblocks_for_recheck + mirror_index;
 		} else {
-			struct scrub_recover *r = sblock_bad->pagev[0]->recover;
+			struct scrub_recover *r = sblock_bad->sectorv[0]->recover;
 			int max_allowed = r->bioc->num_stripes - r->bioc->num_tgtdevs;
 
 			if (mirror_index >= max_allowed)
 				break;
-			if (!sblocks_for_recheck[1].page_count)
+			if (!sblocks_for_recheck[1].sector_count)
 				break;
 
 			ASSERT(failed_mirror_index == 0);
 			sblock_other = sblocks_for_recheck + 1;
-			sblock_other->pagev[0]->mirror_num = 1 + mirror_index;
+			sblock_other->sectorv[0]->mirror_num = 1 + mirror_index;
 		}
 
 		/* build and submit the bios, check checksums */
@@ -1078,16 +1078,16 @@ static int scrub_handle_errored_block(struct scrub_block *sblock_to_check)
 	 * area are unreadable.
 	 */
 	success = 1;
-	for (page_num = 0; page_num < sblock_bad->page_count;
-	     page_num++) {
-		struct scrub_page *spage_bad = sblock_bad->pagev[page_num];
+	for (sector_num = 0; sector_num < sblock_bad->sector_count;
+	     sector_num++) {
+		struct scrub_page *spage_bad = sblock_bad->sectorv[sector_num];
 		struct scrub_block *sblock_other = NULL;
 
 		/* skip no-io-error page in scrub */
 		if (!spage_bad->io_error && !sctx->is_dev_replace)
 			continue;
 
-		if (scrub_is_page_on_raid56(sblock_bad->pagev[0])) {
+		if (scrub_is_page_on_raid56(sblock_bad->sectorv[0])) {
 			/*
 			 * In case of dev replace, if raid56 rebuild process
 			 * didn't work out correct data, then copy the content
@@ -1100,10 +1100,10 @@ static int scrub_handle_errored_block(struct scrub_block *sblock_to_check)
 			/* try to find no-io-error page in mirrors */
 			for (mirror_index = 0;
 			     mirror_index < BTRFS_MAX_MIRRORS &&
-			     sblocks_for_recheck[mirror_index].page_count > 0;
+			     sblocks_for_recheck[mirror_index].sector_count > 0;
 			     mirror_index++) {
 				if (!sblocks_for_recheck[mirror_index].
-				    pagev[page_num]->io_error) {
+				    sectorv[sector_num]->io_error) {
 					sblock_other = sblocks_for_recheck +
 						       mirror_index;
 					break;
@@ -1125,7 +1125,7 @@ static int scrub_handle_errored_block(struct scrub_block *sblock_to_check)
 				sblock_other = sblock_bad;
 
 			if (scrub_write_page_to_dev_replace(sblock_other,
-							    page_num) != 0) {
+							    sector_num) != 0) {
 				atomic64_inc(
 					&fs_info->dev_replace.num_write_errors);
 				success = 0;
@@ -1133,7 +1133,7 @@ static int scrub_handle_errored_block(struct scrub_block *sblock_to_check)
 		} else if (sblock_other) {
 			ret = scrub_repair_page_from_good_copy(sblock_bad,
 							       sblock_other,
-							       page_num, 0);
+							       sector_num, 0);
 			if (0 == ret)
 				spage_bad->io_error = 0;
 			else
@@ -1186,18 +1186,18 @@ static int scrub_handle_errored_block(struct scrub_block *sblock_to_check)
 			struct scrub_block *sblock = sblocks_for_recheck +
 						     mirror_index;
 			struct scrub_recover *recover;
-			int page_index;
+			int sector_index;
 
-			for (page_index = 0; page_index < sblock->page_count;
-			     page_index++) {
-				sblock->pagev[page_index]->sblock = NULL;
-				recover = sblock->pagev[page_index]->recover;
+			for (sector_index = 0; sector_index < sblock->sector_count;
+			     sector_index++) {
+				sblock->sectorv[sector_index]->sblock = NULL;
+				recover = sblock->sectorv[sector_index]->recover;
 				if (recover) {
 					scrub_put_recover(fs_info, recover);
-					sblock->pagev[page_index]->recover =
+					sblock->sectorv[sector_index]->recover =
 									NULL;
 				}
-				scrub_page_put(sblock->pagev[page_index]);
+				scrub_page_put(sblock->sectorv[sector_index]);
 			}
 		}
 		kfree(sblocks_for_recheck);
@@ -1255,18 +1255,18 @@ static int scrub_setup_recheck_block(struct scrub_block *original_sblock,
 {
 	struct scrub_ctx *sctx = original_sblock->sctx;
 	struct btrfs_fs_info *fs_info = sctx->fs_info;
-	u64 length = original_sblock->page_count * fs_info->sectorsize;
-	u64 logical = original_sblock->pagev[0]->logical;
-	u64 generation = original_sblock->pagev[0]->generation;
-	u64 flags = original_sblock->pagev[0]->flags;
-	u64 have_csum = original_sblock->pagev[0]->have_csum;
+	u64 length = original_sblock->sector_count * fs_info->sectorsize;
+	u64 logical = original_sblock->sectorv[0]->logical;
+	u64 generation = original_sblock->sectorv[0]->generation;
+	u64 flags = original_sblock->sectorv[0]->flags;
+	u64 have_csum = original_sblock->sectorv[0]->have_csum;
 	struct scrub_recover *recover;
 	struct btrfs_io_context *bioc;
 	u64 sublen;
 	u64 mapped_length;
 	u64 stripe_offset;
 	int stripe_index;
-	int page_index = 0;
+	int sector_index = 0;
 	int mirror_index;
 	int nmirrors;
 	int ret;
@@ -1306,7 +1306,7 @@ static int scrub_setup_recheck_block(struct scrub_block *original_sblock,
 		recover->bioc = bioc;
 		recover->map_length = mapped_length;
 
-		ASSERT(page_index < SCRUB_MAX_PAGES_PER_BLOCK);
+		ASSERT(sector_index < SCRUB_MAX_SECTORS_PER_BLOCK);
 
 		nmirrors = min(scrub_nr_raid_mirrors(bioc), BTRFS_MAX_MIRRORS);
 
@@ -1328,7 +1328,7 @@ static int scrub_setup_recheck_block(struct scrub_block *original_sblock,
 				return -ENOMEM;
 			}
 			scrub_page_get(spage);
-			sblock->pagev[page_index] = spage;
+			sblock->sectorv[sector_index] = spage;
 			spage->sblock = sblock;
 			spage->flags = flags;
 			spage->generation = generation;
@@ -1336,7 +1336,7 @@ static int scrub_setup_recheck_block(struct scrub_block *original_sblock,
 			spage->have_csum = have_csum;
 			if (have_csum)
 				memcpy(spage->csum,
-				       original_sblock->pagev[0]->csum,
+				       original_sblock->sectorv[0]->csum,
 				       sctx->fs_info->csum_size);
 
 			scrub_stripe_index_and_offset(logical,
@@ -1352,13 +1352,13 @@ static int scrub_setup_recheck_block(struct scrub_block *original_sblock,
 					 stripe_offset;
 			spage->dev = bioc->stripes[stripe_index].dev;
 
-			BUG_ON(page_index >= original_sblock->page_count);
+			BUG_ON(sector_index >= original_sblock->sector_count);
 			spage->physical_for_dev_replace =
-				original_sblock->pagev[page_index]->
+				original_sblock->sectorv[sector_index]->
 				physical_for_dev_replace;
 			/* for missing devices, dev->bdev is NULL */
 			spage->mirror_num = mirror_index + 1;
-			sblock->page_count++;
+			sblock->sector_count++;
 			spage->page = alloc_page(GFP_NOFS);
 			if (!spage->page)
 				goto leave_nomem;
@@ -1369,7 +1369,7 @@ static int scrub_setup_recheck_block(struct scrub_block *original_sblock,
 		scrub_put_recover(fs_info, recover);
 		length -= sublen;
 		logical += sublen;
-		page_index++;
+		sector_index++;
 	}
 
 	return 0;
@@ -1392,7 +1392,7 @@ static int scrub_submit_raid56_bio_wait(struct btrfs_fs_info *fs_info,
 	bio->bi_private = &done;
 	bio->bi_end_io = scrub_bio_wait_endio;
 
-	mirror_num = spage->sblock->pagev[0]->mirror_num;
+	mirror_num = spage->sblock->sectorv[0]->mirror_num;
 	ret = raid56_parity_recover(bio, spage->recover->bioc,
 				    spage->recover->map_length,
 				    mirror_num, 0);
@@ -1406,9 +1406,9 @@ static int scrub_submit_raid56_bio_wait(struct btrfs_fs_info *fs_info,
 static void scrub_recheck_block_on_raid56(struct btrfs_fs_info *fs_info,
 					  struct scrub_block *sblock)
 {
-	struct scrub_page *first_page = sblock->pagev[0];
+	struct scrub_page *first_page = sblock->sectorv[0];
 	struct bio *bio;
-	int page_num;
+	int sector_num;
 
 	/* All pages in sblock belong to the same stripe on the same device. */
 	ASSERT(first_page->dev);
@@ -1418,8 +1418,8 @@ static void scrub_recheck_block_on_raid56(struct btrfs_fs_info *fs_info,
 	bio = btrfs_bio_alloc(BIO_MAX_VECS);
 	bio_set_dev(bio, first_page->dev->bdev);
 
-	for (page_num = 0; page_num < sblock->page_count; page_num++) {
-		struct scrub_page *spage = sblock->pagev[page_num];
+	for (sector_num = 0; sector_num < sblock->sector_count; sector_num++) {
+		struct scrub_page *spage = sblock->sectorv[sector_num];
 
 		WARN_ON(!spage->page);
 		bio_add_page(bio, spage->page, PAGE_SIZE, 0);
@@ -1436,8 +1436,8 @@ static void scrub_recheck_block_on_raid56(struct btrfs_fs_info *fs_info,
 
 	return;
 out:
-	for (page_num = 0; page_num < sblock->page_count; page_num++)
-		sblock->pagev[page_num]->io_error = 1;
+	for (sector_num = 0; sector_num < sblock->sector_count; sector_num++)
+		sblock->sectorv[sector_num]->io_error = 1;
 
 	sblock->no_io_error_seen = 0;
 }
@@ -1453,17 +1453,17 @@ static void scrub_recheck_block(struct btrfs_fs_info *fs_info,
 				struct scrub_block *sblock,
 				int retry_failed_mirror)
 {
-	int page_num;
+	int sector_num;
 
 	sblock->no_io_error_seen = 1;
 
 	/* short cut for raid56 */
-	if (!retry_failed_mirror && scrub_is_page_on_raid56(sblock->pagev[0]))
+	if (!retry_failed_mirror && scrub_is_page_on_raid56(sblock->sectorv[0]))
 		return scrub_recheck_block_on_raid56(fs_info, sblock);
 
-	for (page_num = 0; page_num < sblock->page_count; page_num++) {
+	for (sector_num = 0; sector_num < sblock->sector_count; sector_num++) {
 		struct bio *bio;
-		struct scrub_page *spage = sblock->pagev[page_num];
+		struct scrub_page *spage = sblock->sectorv[sector_num];
 
 		if (spage->dev->bdev == NULL) {
 			spage->io_error = 1;
@@ -1507,7 +1507,7 @@ static void scrub_recheck_block_checksum(struct scrub_block *sblock)
 	sblock->checksum_error = 0;
 	sblock->generation_error = 0;
 
-	if (sblock->pagev[0]->flags & BTRFS_EXTENT_FLAG_DATA)
+	if (sblock->sectorv[0]->flags & BTRFS_EXTENT_FLAG_DATA)
 		scrub_checksum_data(sblock);
 	else
 		scrub_checksum_tree_block(sblock);
@@ -1516,15 +1516,15 @@ static void scrub_recheck_block_checksum(struct scrub_block *sblock)
 static int scrub_repair_block_from_good_copy(struct scrub_block *sblock_bad,
 					     struct scrub_block *sblock_good)
 {
-	int page_num;
+	int sector_num;
 	int ret = 0;
 
-	for (page_num = 0; page_num < sblock_bad->page_count; page_num++) {
+	for (sector_num = 0; sector_num < sblock_bad->sector_count; sector_num++) {
 		int ret_sub;
 
 		ret_sub = scrub_repair_page_from_good_copy(sblock_bad,
 							   sblock_good,
-							   page_num, 1);
+							   sector_num, 1);
 		if (ret_sub)
 			ret = ret_sub;
 	}
@@ -1534,10 +1534,10 @@ static int scrub_repair_block_from_good_copy(struct scrub_block *sblock_bad,
 
 static int scrub_repair_page_from_good_copy(struct scrub_block *sblock_bad,
 					    struct scrub_block *sblock_good,
-					    int page_num, int force_write)
+					    int sector_num, int force_write)
 {
-	struct scrub_page *spage_bad = sblock_bad->pagev[page_num];
-	struct scrub_page *spage_good = sblock_good->pagev[page_num];
+	struct scrub_page *spage_bad = sblock_bad->sectorv[sector_num];
+	struct scrub_page *spage_good = sblock_good->sectorv[sector_num];
 	struct btrfs_fs_info *fs_info = sblock_bad->sctx->fs_info;
 	const u32 sectorsize = fs_info->sectorsize;
 
@@ -1581,7 +1581,7 @@ static int scrub_repair_page_from_good_copy(struct scrub_block *sblock_bad,
 static void scrub_write_block_to_dev_replace(struct scrub_block *sblock)
 {
 	struct btrfs_fs_info *fs_info = sblock->sctx->fs_info;
-	int page_num;
+	int sector_num;
 
 	/*
 	 * This block is used for the check of the parity on the source device,
@@ -1590,19 +1590,19 @@ static void scrub_write_block_to_dev_replace(struct scrub_block *sblock)
 	if (sblock->sparity)
 		return;
 
-	for (page_num = 0; page_num < sblock->page_count; page_num++) {
+	for (sector_num = 0; sector_num < sblock->sector_count; sector_num++) {
 		int ret;
 
-		ret = scrub_write_page_to_dev_replace(sblock, page_num);
+		ret = scrub_write_page_to_dev_replace(sblock, sector_num);
 		if (ret)
 			atomic64_inc(&fs_info->dev_replace.num_write_errors);
 	}
 }
 
 static int scrub_write_page_to_dev_replace(struct scrub_block *sblock,
-					   int page_num)
+					   int sector_num)
 {
-	struct scrub_page *spage = sblock->pagev[page_num];
+	struct scrub_page *spage = sblock->sectorv[sector_num];
 
 	BUG_ON(spage->page == NULL);
 	if (spage->io_error)
@@ -1786,8 +1786,8 @@ static int scrub_checksum(struct scrub_block *sblock)
 	sblock->generation_error = 0;
 	sblock->checksum_error = 0;
 
-	WARN_ON(sblock->page_count < 1);
-	flags = sblock->pagev[0]->flags;
+	WARN_ON(sblock->sector_count < 1);
+	flags = sblock->sectorv[0]->flags;
 	ret = 0;
 	if (flags & BTRFS_EXTENT_FLAG_DATA)
 		ret = scrub_checksum_data(sblock);
@@ -1812,8 +1812,8 @@ static int scrub_checksum_data(struct scrub_block *sblock)
 	struct scrub_page *spage;
 	char *kaddr;
 
-	BUG_ON(sblock->page_count < 1);
-	spage = sblock->pagev[0];
+	BUG_ON(sblock->sector_count < 1);
+	spage = sblock->sectorv[0];
 	if (!spage->have_csum)
 		return 0;
 
@@ -1852,12 +1852,12 @@ static int scrub_checksum_tree_block(struct scrub_block *sblock)
 	struct scrub_page *spage;
 	char *kaddr;
 
-	BUG_ON(sblock->page_count < 1);
+	BUG_ON(sblock->sector_count < 1);
 
-	/* Each member in pagev is just one block, not a full page */
-	ASSERT(sblock->page_count == num_sectors);
+	/* Each member in pagev is just one sector , not a full page */
+	ASSERT(sblock->sector_count == num_sectors);
 
-	spage = sblock->pagev[0];
+	spage = sblock->sectorv[0];
 	kaddr = page_address(spage->page);
 	h = (struct btrfs_header *)kaddr;
 	memcpy(on_disk_csum, h->csum, sctx->fs_info->csum_size);
@@ -1888,7 +1888,7 @@ static int scrub_checksum_tree_block(struct scrub_block *sblock)
 			    sectorsize - BTRFS_CSUM_SIZE);
 
 	for (i = 1; i < num_sectors; i++) {
-		kaddr = page_address(sblock->pagev[i]->page);
+		kaddr = page_address(sblock->sectorv[i]->page);
 		crypto_shash_update(shash, kaddr, sectorsize);
 	}
 
@@ -1911,8 +1911,8 @@ static int scrub_checksum_super(struct scrub_block *sblock)
 	int fail_gen = 0;
 	int fail_cor = 0;
 
-	BUG_ON(sblock->page_count < 1);
-	spage = sblock->pagev[0];
+	BUG_ON(sblock->sector_count < 1);
+	spage = sblock->sectorv[0];
 	kaddr = page_address(spage->page);
 	s = (struct btrfs_super_block *)kaddr;
 
@@ -1966,8 +1966,8 @@ static void scrub_block_put(struct scrub_block *sblock)
 		if (sblock->sparity)
 			scrub_parity_put(sblock->sparity);
 
-		for (i = 0; i < sblock->page_count; i++)
-			scrub_page_put(sblock->pagev[i]);
+		for (i = 0; i < sblock->sector_count; i++)
+			scrub_page_put(sblock->sectorv[i]);
 		kfree(sblock);
 	}
 }
@@ -2155,8 +2155,8 @@ static void scrub_missing_raid56_worker(struct btrfs_work *work)
 	u64 logical;
 	struct btrfs_device *dev;
 
-	logical = sblock->pagev[0]->logical;
-	dev = sblock->pagev[0]->dev;
+	logical = sblock->sectorv[0]->logical;
+	dev = sblock->sectorv[0]->dev;
 
 	if (sblock->no_io_error_seen)
 		scrub_recheck_block_checksum(sblock);
@@ -2193,8 +2193,8 @@ static void scrub_missing_raid56_pages(struct scrub_block *sblock)
 {
 	struct scrub_ctx *sctx = sblock->sctx;
 	struct btrfs_fs_info *fs_info = sctx->fs_info;
-	u64 length = sblock->page_count * PAGE_SIZE;
-	u64 logical = sblock->pagev[0]->logical;
+	u64 length = sblock->sector_count * fs_info->sectorsize;
+	u64 logical = sblock->sectorv[0]->logical;
 	struct btrfs_io_context *bioc = NULL;
 	struct bio *bio;
 	struct btrfs_raid_bio *rbio;
@@ -2227,8 +2227,8 @@ static void scrub_missing_raid56_pages(struct scrub_block *sblock)
 	if (!rbio)
 		goto rbio_out;
 
-	for (i = 0; i < sblock->page_count; i++) {
-		struct scrub_page *spage = sblock->pagev[i];
+	for (i = 0; i < sblock->sector_count; i++) {
+		struct scrub_page *spage = sblock->sectorv[i];
 
 		raid56_add_scrub_pages(rbio, spage->page, spage->logical);
 	}
@@ -2290,9 +2290,9 @@ static int scrub_pages(struct scrub_ctx *sctx, u64 logical, u32 len,
 			scrub_block_put(sblock);
 			return -ENOMEM;
 		}
-		ASSERT(index < SCRUB_MAX_PAGES_PER_BLOCK);
+		ASSERT(index < SCRUB_MAX_SECTORS_PER_BLOCK);
 		scrub_page_get(spage);
-		sblock->pagev[index] = spage;
+		sblock->sectorv[index] = spage;
 		spage->sblock = sblock;
 		spage->dev = dev;
 		spage->flags = flags;
@@ -2307,7 +2307,7 @@ static int scrub_pages(struct scrub_ctx *sctx, u64 logical, u32 len,
 		} else {
 			spage->have_csum = 0;
 		}
-		sblock->page_count++;
+		sblock->sector_count++;
 		spage->page = alloc_page(GFP_KERNEL);
 		if (!spage->page)
 			goto leave_nomem;
@@ -2317,7 +2317,7 @@ static int scrub_pages(struct scrub_ctx *sctx, u64 logical, u32 len,
 		physical_for_dev_replace += l;
 	}
 
-	WARN_ON(sblock->page_count == 0);
+	WARN_ON(sblock->sector_count == 0);
 	if (test_bit(BTRFS_DEV_STATE_MISSING, &dev->dev_state)) {
 		/*
 		 * This case should only be hit for RAID 5/6 device replace. See
@@ -2325,8 +2325,8 @@ static int scrub_pages(struct scrub_ctx *sctx, u64 logical, u32 len,
 		 */
 		scrub_missing_raid56_pages(sblock);
 	} else {
-		for (index = 0; index < sblock->page_count; index++) {
-			struct scrub_page *spage = sblock->pagev[index];
+		for (index = 0; index < sblock->sector_count; index++) {
+			struct scrub_page *spage = sblock->sectorv[index];
 			int ret;
 
 			ret = scrub_add_page_to_rd_bio(sctx, spage);
@@ -2456,8 +2456,8 @@ static void scrub_block_complete(struct scrub_block *sblock)
 	}
 
 	if (sblock->sparity && corrupted && !sblock->data_corrected) {
-		u64 start = sblock->pagev[0]->logical;
-		u64 end = sblock->pagev[sblock->page_count - 1]->logical +
+		u64 start = sblock->sectorv[0]->logical;
+		u64 end = sblock->sectorv[sblock->sector_count - 1]->logical +
 			  sblock->sctx->fs_info->sectorsize;
 
 		ASSERT(end - start <= U32_MAX);
@@ -2624,10 +2624,10 @@ static int scrub_pages_for_parity(struct scrub_parity *sparity,
 			scrub_block_put(sblock);
 			return -ENOMEM;
 		}
-		ASSERT(index < SCRUB_MAX_PAGES_PER_BLOCK);
+		ASSERT(index < SCRUB_MAX_SECTORS_PER_BLOCK);
 		/* For scrub block */
 		scrub_page_get(spage);
-		sblock->pagev[index] = spage;
+		sblock->sectorv[index] = spage;
 		/* For scrub parity */
 		scrub_page_get(spage);
 		list_add_tail(&spage->list, &sparity->spages);
@@ -2644,7 +2644,7 @@ static int scrub_pages_for_parity(struct scrub_parity *sparity,
 		} else {
 			spage->have_csum = 0;
 		}
-		sblock->page_count++;
+		sblock->sector_count++;
 		spage->page = alloc_page(GFP_KERNEL);
 		if (!spage->page)
 			goto leave_nomem;
@@ -2656,9 +2656,9 @@ static int scrub_pages_for_parity(struct scrub_parity *sparity,
 		physical += sectorsize;
 	}
 
-	WARN_ON(sblock->page_count == 0);
-	for (index = 0; index < sblock->page_count; index++) {
-		struct scrub_page *spage = sblock->pagev[index];
+	WARN_ON(sblock->sector_count == 0);
+	for (index = 0; index < sblock->sector_count; index++) {
+		struct scrub_page *spage = sblock->sectorv[index];
 		int ret;
 
 		ret = scrub_add_page_to_rd_bio(sctx, spage);
@@ -4058,18 +4058,18 @@ int btrfs_scrub_dev(struct btrfs_fs_info *fs_info, u64 devid, u64 start,
 	}
 
 	if (fs_info->nodesize >
-	    PAGE_SIZE * SCRUB_MAX_PAGES_PER_BLOCK ||
-	    fs_info->sectorsize > PAGE_SIZE * SCRUB_MAX_PAGES_PER_BLOCK) {
+	    SCRUB_MAX_SECTORS_PER_BLOCK * fs_info->sectorsize ||
+	    fs_info->sectorsize > PAGE_SIZE * SCRUB_MAX_SECTORS_PER_BLOCK) {
 		/*
 		 * would exhaust the array bounds of pagev member in
 		 * struct scrub_block
 		 */
 		btrfs_err(fs_info,
-			  "scrub: size assumption nodesize and sectorsize <= SCRUB_MAX_PAGES_PER_BLOCK (%d <= %d && %d <= %d) fails",
+			  "scrub: size assumption nodesize and sectorsize <= SCRUB_MAX_SECTORS_PER_BLOCK (%d <= %d && %d <= %d) fails",
 		       fs_info->nodesize,
-		       SCRUB_MAX_PAGES_PER_BLOCK,
+		       SCRUB_MAX_SECTORS_PER_BLOCK,
 		       fs_info->sectorsize,
-		       SCRUB_MAX_PAGES_PER_BLOCK);
+		       SCRUB_MAX_SECTORS_PER_BLOCK);
 		return -EINVAL;
 	}
 
-- 
2.35.1

