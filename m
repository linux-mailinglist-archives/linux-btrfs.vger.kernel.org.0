Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ED635ABDCB
	for <lists+linux-btrfs@lfdr.de>; Sat,  3 Sep 2022 10:20:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232043AbiICIUF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 3 Sep 2022 04:20:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232476AbiICIUD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sat, 3 Sep 2022 04:20:03 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 310963AB13
        for <linux-btrfs@vger.kernel.org>; Sat,  3 Sep 2022 01:20:02 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id DA751337C4
        for <linux-btrfs@vger.kernel.org>; Sat,  3 Sep 2022 08:20:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1662193200; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tzaffeIf1OYhRn0wexY5jcn4Fovra8k8FsGlw3rrSSs=;
        b=Vtao4LRCDCKL088UBXy3tNProjOOMFe3uuxayC4N4AOUA+eBIeqcOxGqnUg4LaYKXr9QAw
        cb9o4cz/3oYOzpZeYfSsBRaQXKOnZsXIFJAnoDGZJBWDIv106p+HKtiHQbwKTccfG1pkK4
        7cJDbJTwdJWwDsk3t6DFB4GRa1aBpm0=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3694F139F9
        for <linux-btrfs@vger.kernel.org>; Sat,  3 Sep 2022 08:20:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id uIloADAOE2OzagAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Sat, 03 Sep 2022 08:20:00 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH PoC 9/9] btrfs: scrub: implement recoverable sectors report for scrub_fs
Date:   Sat,  3 Sep 2022 16:19:29 +0800
Message-Id: <06e4f67a9e50c2b6dfc49a086ee62053cbdcc0ae.1662191784.git.wqu@suse.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <cover.1662191784.git.wqu@suse.com>
References: <cover.1662191784.git.wqu@suse.com>
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

This patch introduces two new functions:
- scrub_fs_recover_meta()
- scrub_fs_recover_data()

Both of them are going to check if we can recovery the data/meta
sectors inside a vertical stripe, and if we can update the
stat->data/meta_recoverable accounting.

None of them has implemented the writeback function though.

For scrub_fs_recover_meta() it's not much different than the existing
scrub, just make sure we have one good copy them all the other copies
can be recoverable.

For scrub_fs_recover_data() besides the existing csum based
verification, for NODATASUM cases we will make sure all the copies match
each other.

If they don't match, we will report all the sectors as uncertain.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/scrub.c | 197 ++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 196 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 145bd5c9601d..fdac9b8e4cf1 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -212,6 +212,12 @@ struct scrub_ctx {
 /* This marks if the sector is a good one (aka, passed all checks). */
 #define SCRUB_FS_SECTOR_FLAG_GOOD		(1 << 7)
 
+/*
+ * This marks if the sectors is recovery (thus it should be corrupted in
+ * the first place )
+ */
+#define SCRUB_FS_SECTOR_FLAG_RECOVERABLE	(1 << 8)
+
 /*
  * Represent a sector.
  *
@@ -5280,6 +5286,177 @@ static void scrub_fs_verify_one_data(struct scrub_fs_ctx *sfctx, int sector_nr,
 	sector->flags |= SCRUB_FS_SECTOR_FLAG_GOOD;
 }
 
+static void scrub_fs_recover_meta(struct scrub_fs_ctx *sfctx, int sector_nr)
+{
+	struct btrfs_fs_info *fs_info = sfctx->fs_info;
+	int nr_good = 0;
+	int mirror_nr;
+	int cur_sector;
+
+	for (mirror_nr = 0; mirror_nr < sfctx->nr_copies; mirror_nr++) {
+		struct scrub_fs_sector *sector =
+			scrub_fs_get_sector(sfctx, sector_nr, mirror_nr);
+
+		if (sector->flags & SCRUB_FS_SECTOR_FLAG_GOOD)
+			nr_good++;
+	}
+
+	/* No good copy found, just error out. */
+	if (!nr_good)
+		return;
+	/*
+	 * We have at least one good copy, and we also have bad copies,
+	 * all those bad copies can be recovered.
+	 */
+	sfctx->stat.meta_recoverable += (sfctx->nr_copies - nr_good) *
+					fs_info->nodesize;
+
+	/* Mark those bad sectors recoverable. */
+	for (cur_sector = sector_nr; cur_sector < sector_nr +
+	     (fs_info->nodesize >> fs_info->sectorsize_bits); cur_sector++) {
+		for (mirror_nr = 0; mirror_nr < sfctx->nr_copies; mirror_nr++) {
+			struct scrub_fs_sector *sector =
+				scrub_fs_get_sector(sfctx, sector_nr, mirror_nr);
+
+			if (sector->flags & SCRUB_FS_SECTOR_FLAG_GOOD)
+				continue;
+
+			sector->flags |= SCRUB_FS_SECTOR_FLAG_RECOVERABLE;
+		}
+	}
+	/* Place holder for writeback. */
+}
+
+static int scrub_fs_memcmp_sectors(struct scrub_fs_ctx *sfctx,
+				   struct scrub_fs_sector *sector1,
+				   struct scrub_fs_sector *sector2)
+{
+	struct page *page1;
+	struct page *page2;
+	unsigned int page_off1;
+	unsigned int page_off2;
+	int sector_nr1;
+	int sector_nr2;
+
+	sector_nr1 = scrub_fs_sector_to_sector_index(sfctx, sector1);
+	sector_nr2 = scrub_fs_sector_to_sector_index(sfctx, sector2);
+
+	page1 = scrub_fs_get_page(sfctx, sector_nr1);
+	page_off1 = scrub_fs_get_page_offset(sfctx, sector_nr1);
+
+	page2 = scrub_fs_get_page(sfctx, sector_nr2);
+	page_off2 = scrub_fs_get_page_offset(sfctx, sector_nr2);
+
+	return memcmp(page_address(page1) + page_off1,
+		      page_address(page2) + page_off2,
+		      sfctx->fs_info->sectorsize);
+}
+
+/* Find the next sector in the same vertical stripe which has read IO done. */
+static struct scrub_fs_sector *scrub_fs_find_next_working_mirror(
+		struct scrub_fs_ctx *sfctx, int sector_nr, int mirror_nr)
+{
+	int i;
+
+	for (i = mirror_nr + 1; i < sfctx->nr_copies; i++) {
+		struct scrub_fs_sector *sector =
+			scrub_fs_get_sector(sfctx, sector_nr, i);
+
+		/* This copy has IO error, skip it. */
+		if (!(sector->flags & SCRUB_FS_SECTOR_FLAG_IO_DONE))
+			continue;
+
+		/* Found a good copy. */
+		return sector;
+	}
+	return NULL;
+}
+
+static void scrub_fs_recover_data(struct scrub_fs_ctx *sfctx, int sector_nr)
+{
+	struct btrfs_fs_info *fs_info = sfctx->fs_info;
+	const bool has_csum = !!sfctx->sectors[sector_nr].csum;
+	bool mismatch_found = false;
+	int nr_good = 0;
+	int io_fail = 0;
+	int mirror_nr;
+
+	for (mirror_nr = 0; mirror_nr < sfctx->nr_copies; mirror_nr++) {
+		struct scrub_fs_sector *sector =
+			scrub_fs_get_sector(sfctx, sector_nr, mirror_nr);
+
+		if (sector->flags & SCRUB_FS_SECTOR_FLAG_GOOD)
+			nr_good++;
+		if (!(sector->flags & SCRUB_FS_SECTOR_FLAG_IO_DONE))
+			io_fail++;
+	}
+
+	if (has_csum) {
+		/*
+		 * There is at least one good copy, thus all the other
+		 * corrupted sectors can also be recovered.
+		 */
+		for (mirror_nr = 0; mirror_nr < sfctx->nr_copies; mirror_nr++) {
+			struct scrub_fs_sector *sector =
+				scrub_fs_get_sector(sfctx, sector_nr, mirror_nr);
+
+			if (sector->flags & SCRUB_FS_SECTOR_FLAG_GOOD)
+				continue;
+			sector->flags |= SCRUB_FS_SECTOR_FLAG_RECOVERABLE;
+			sfctx->stat.data_recoverable += fs_info->sectorsize;
+		}
+
+		/* Place holder for writeback */
+		return;
+	}
+
+	/*
+	 * No datasum case, it's much harder.
+	 *
+	 * The idea is, we have to compare all the sectors to determine if they
+	 * match.
+	 *
+	 * Firstly rule out sectors which don't have extra working copies.
+	 */
+	if (sfctx->nr_copies - io_fail <= 1) {
+		sfctx->stat.data_nocsum_uncertain += fs_info->sectorsize;
+		return;
+	}
+
+	/*
+	 * For now, we can only support one case, all data read matches with each
+	 * other, or we consider them all uncertain.
+	 */
+	for (mirror_nr = 0; mirror_nr < sfctx->nr_copies - 1; mirror_nr++) {
+		struct scrub_fs_sector *sector =
+			scrub_fs_get_sector(sfctx, sector_nr, mirror_nr);
+		struct scrub_fs_sector *next_sector;
+		int ret;
+
+		/* The first sector has IO error, skip to the next run. */
+		if (!(sector->flags & SCRUB_FS_SECTOR_FLAG_IO_DONE))
+			continue;
+
+		next_sector = scrub_fs_find_next_working_mirror(sfctx,
+				sector_nr, mirror_nr);
+		/* We're already the last working copy, can break now. */
+		if (!next_sector)
+			break;
+
+		ret = scrub_fs_memcmp_sectors(sfctx, sector, next_sector);
+		if (ret)
+			mismatch_found = true;
+	}
+
+	/*
+	 * We have found mismatched contents, mark all those sectors
+	 * which doesn't have IO error as uncertain.
+	 */
+	if (mismatch_found)
+		sfctx->stat.data_nocsum_uncertain +=
+			(sfctx->nr_copies - io_fail) << fs_info->sectorsize_bits;
+}
+
 static void scrub_fs_verify_one_stripe(struct scrub_fs_ctx *sfctx)
 {
 	struct btrfs_fs_info *fs_info = sfctx->fs_info;
@@ -5316,7 +5493,25 @@ static void scrub_fs_verify_one_stripe(struct scrub_fs_ctx *sfctx)
 		for (mirror_nr = 0; mirror_nr < sfctx->nr_copies; mirror_nr++)
 			scrub_fs_verify_one_data(sfctx, sector_nr, mirror_nr);
 	}
-	/* Place holder for recoverable checks. */
+
+	/*
+	 * Now all sectors are checked, re-check which sectors are recoverable.
+	 */
+	for (sector_nr  = 0; sector_nr < sectors_per_stripe; sector_nr++) {
+		struct scrub_fs_sector *sector = &sfctx->sectors[sector_nr];
+
+		if (sector->flags & SCRUB_FS_SECTOR_FLAG_UNUSED)
+			continue;
+
+		if (sector->flags & SCRUB_FS_SECTOR_FLAG_META) {
+			scrub_fs_recover_meta(sfctx, sector_nr);
+			sector_nr += (fs_info->nodesize >>
+				      fs_info->sectorsize_bits) - 1;
+			continue;
+		}
+
+		scrub_fs_recover_data(sfctx, sector_nr);
+	}
 }
 
 static int scrub_fs_one_stripe(struct scrub_fs_ctx *sfctx)
-- 
2.37.3

