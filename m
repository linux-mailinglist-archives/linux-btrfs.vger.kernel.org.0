Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD3155ED7EE
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Sep 2022 10:37:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233017AbiI1Ig1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 28 Sep 2022 04:36:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232838AbiI1IgT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 28 Sep 2022 04:36:19 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37B469DB66
        for <linux-btrfs@vger.kernel.org>; Wed, 28 Sep 2022 01:36:18 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id C323D21DB7
        for <linux-btrfs@vger.kernel.org>; Wed, 28 Sep 2022 08:36:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1664354176; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=x2wQvDiauNForzEsxBnevifNlUBXTVseAelN3Sq5D6U=;
        b=TFvKnYAH4QK9PIDJOrRwpDXmqVHPr+QrYiMffii6Rw9E5CNBO4/1Jr9/DaohyILrsjPWAw
        nkVYTJJaDQrkEnQjqlfc3C2TwU9pBO8o6Z7OI1i7ZDdL+ymsLz9zWnDdevlsf2pHCOkOgc
        VilFP77mfdKw6cqmCksNu6TV/BinZTg=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 19ACA13A84
        for <linux-btrfs@vger.kernel.org>; Wed, 28 Sep 2022 08:36:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id aDl/NH8HNGO2VgAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Wed, 28 Sep 2022 08:36:15 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH PoC v2 09/10] btrfs: scrub: implement the later stage of verification
Date:   Wed, 28 Sep 2022 16:35:46 +0800
Message-Id: <e89780f089df3575452f56619c15628a989217d9.1664353497.git.wqu@suse.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <cover.1664353497.git.wqu@suse.com>
References: <cover.1664353497.git.wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

At endio time we have verified all the data/metadata in each mirror
and updated sector->flags.

But we haven't yet to update the sfctx->stat, as one of the design is to
avoid concurrency access to sfctx->stat.
Furthermore at endio time we are not aware if other copies has the good
copy.

Thus we have to do the final veritication at the main thread, after all
endio functions finished.

At the later stage, we can update sfctx->stat in a single thread without
lock protection, and determine if we can repair certain sectors.

Furthermore if we found a good copy, we should copy the content to any
bad copy so later we can repair them.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/scrub.c | 108 +++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 104 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index efe49a04dceb..89735ff6143a 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -221,6 +221,9 @@ struct scrub_ctx {
 /* Only for metadata, transid mismatch. */
 #define SCRUB_FS_SECTOR_FLAG_TRANSID_MISMATCH	(1 << 10)
 
+/* For both metadata and data, to show we can and need to repair the sector. */
+#define SCRUB_FS_SECTOR_FLAG_RECOVERABLE	(1 << 11)
+
 /*
  * Represent a sector.
  *
@@ -5264,6 +5267,101 @@ static void submit_stripe_read_bio(struct scrub_fs_ctx *sfctx,
 	submit_bio(bio);
 }
 
+static void scrub_fs_copy_sector(struct scrub_fs_ctx *sfctx, int sector_nr,
+				 int good_mirror, int bad_mirror)
+{
+	struct page *good_page;
+	struct page *bad_page;
+	size_t offset;
+
+	scrub_fs_check_sector_mirror_nr(sfctx, sector_nr, good_mirror);
+	scrub_fs_check_sector_mirror_nr(sfctx, sector_nr, bad_mirror);
+
+	good_page = scrub_fs_get_page(sfctx, sector_nr, good_mirror);
+	bad_page = scrub_fs_get_page(sfctx, sector_nr, bad_mirror);
+
+	ASSERT(good_page);
+	ASSERT(bad_page);
+
+	/*
+	 * Since both good and bad sectors are in the same vertical stripe,
+	 * their page offset should be the same.
+	 */
+	offset = scrub_fs_get_page_offset(sfctx, sector_nr, good_mirror);
+	memcpy_page(bad_page, offset, good_page, offset, sfctx->fs_info->sectorsize);
+}
+
+static void scrub_fs_update_veritical(struct scrub_fs_ctx *sfctx,
+				      int sector_nr)
+{
+	int mirror_nr;
+	u32 sectorsize = sfctx->fs_info->sectorsize;
+	int good_mirror = -1;
+	bool is_data = (sfctx->sectors[sector_nr].flags &
+			SCRUB_FS_SECTOR_FLAG_DATA);
+
+	scrub_fs_check_sector_mirror_nr(sfctx, sector_nr, 0);
+
+	for (mirror_nr = 0; mirror_nr < sfctx->nr_copies; mirror_nr++) {
+		struct scrub_fs_sector *sector =
+			scrub_fs_get_sector(sfctx, sector_nr, mirror_nr);
+
+		if (sector->flags & SCRUB_FS_SECTOR_FLAG_UNUSED)
+			continue;
+
+		if (is_data)
+			sfctx->stat.data_scrubbed += sectorsize;
+		else
+			sfctx->stat.meta_scrubbed += sectorsize;
+
+		if (is_data && !sector->csum)
+			sfctx->stat.data_nocsum += sectorsize;
+
+		if (!(sector->flags & SCRUB_FS_SECTOR_FLAG_IO_DONE)) {
+			if (is_data)
+				sfctx->stat.data_io_fail += sectorsize;
+			else
+				sfctx->stat.meta_io_fail += sectorsize;
+		}
+		if (sector->flags & SCRUB_FS_SECTOR_FLAG_INVALID) {
+			ASSERT(!is_data);
+			sfctx->stat.meta_invalid += sectorsize;
+		}
+		if (sector->flags & SCRUB_FS_SECTOR_FLAG_TRANSID_MISMATCH) {
+			ASSERT(!is_data);
+			sfctx->stat.meta_bad_transid += sectorsize;
+		}
+		if (sector->flags & SCRUB_FS_SECTOR_FLAG_BAD_CSUM) {
+			if (is_data)
+				sfctx->stat.data_csum_mismatch += sectorsize;
+			else
+				sfctx->stat.meta_bad_csum += sectorsize;
+		}
+		if (sector->flags & SCRUB_FS_SECTOR_FLAG_GOOD)
+			good_mirror = mirror_nr;
+	}
+	if (good_mirror < 0)
+		return;
+
+	/* Mark the bad sectors as repairable. */
+	for (mirror_nr = 0; mirror_nr < sfctx->nr_copies; mirror_nr++) {
+		struct scrub_fs_sector *sector =
+			scrub_fs_get_sector(sfctx, sector_nr, mirror_nr);
+
+		if (!(sector->flags & SCRUB_FS_SECTOR_FLAG_GOOD)) {
+			if (is_data)
+				sfctx->stat.data_recoverable += sectorsize;
+			else
+				sfctx->stat.meta_recoverable += sectorsize;
+
+			/* Copy the content from the good sector for later repair. */
+			scrub_fs_copy_sector(sfctx, sector_nr, good_mirror, mirror_nr);
+
+			sector->flags |= SCRUB_FS_SECTOR_FLAG_RECOVERABLE;
+		}
+	}
+}
+
 static int scrub_fs_one_stripe(struct scrub_fs_ctx *sfctx)
 {
 	struct btrfs_fs_info *fs_info = sfctx->fs_info;
@@ -5308,12 +5406,14 @@ static int scrub_fs_one_stripe(struct scrub_fs_ctx *sfctx)
 	wait_event(sfctx->wait, atomic_read(&sfctx->bios_under_io) == 0);
 
 	/*
-	 * Place holder to update the accounting.
-	 *
 	 * Endio functions should have done the verification and updated
-	 * sector->flags, but they don't update the accounting as they
-	 * don't have the full view of other mirrors.
+	 * sector->flags of each mirror, but they don't update the accounting
+	 * as they don't have the full view of other mirrors.
 	 */
+	for (i = 0; i < sfctx->sectors_per_stripe; i++)
+		scrub_fs_update_veritical(sfctx, i);
+
+	/* Place holder for repair write-back code */
 out:
 	btrfs_put_bioc(bioc);
 	btrfs_bio_counter_dec(fs_info);
-- 
2.37.3

