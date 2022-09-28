Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 099EF5ED7EC
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Sep 2022 10:37:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233151AbiI1Ig3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 28 Sep 2022 04:36:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232865AbiI1IgU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 28 Sep 2022 04:36:20 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AEE29DD9B
        for <linux-btrfs@vger.kernel.org>; Wed, 28 Sep 2022 01:36:19 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E1B9B21DB4
        for <linux-btrfs@vger.kernel.org>; Wed, 28 Sep 2022 08:36:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1664354177; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=q6Z7kImgjKXrU2muMIdcEPo/AZIhOyapgcSE6QX2GiE=;
        b=nokTEMv1ktcnUNnGkLrC4KrdGQ8H+nuVZHN9XOE6Fc6arVDNrTHNGO4UL7YHlkoLJzTvrZ
        Onep1yNRQ51Ze2kZMmNYLT5eHIxqJ3+m5zg1oI7IoSwU8FKsR65wi3FqjKjcmn6odonEME
        WNiqKUOQu5iWnbiJffWERYd6zaUnPPo=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 37F2313A84
        for <linux-btrfs@vger.kernel.org>; Wed, 28 Sep 2022 08:36:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 4CpUAIEHNGO2VgAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Wed, 28 Sep 2022 08:36:17 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH PoC v2 10/10] btrfs: scrub: implement the repair (writeback) functionality
Date:   Wed, 28 Sep 2022 16:35:47 +0800
Message-Id: <85c4ff6d001e19fca2cc44dcbb98c75f4558d8ff.1664353497.git.wqu@suse.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <cover.1664353497.git.wqu@suse.com>
References: <cover.1664353497.git.wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This adds the repair functionality for scrub_fs.

Since previous patch has implemented the final verification part, all
sectors that can be repaired will have SCRUB_FS_SECTOR_FLAG_RECOVERABLE,
we just need to submit write bios for them.

And just like the old scrub interface, we don't report writeback error.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/scrub.c | 96 +++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 95 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 89735ff6143a..27d96778206c 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -5362,6 +5362,93 @@ static void scrub_fs_update_veritical(struct scrub_fs_ctx *sfctx,
 	}
 }
 
+static void scrub_fs_write_endio(struct bio *bio)
+{
+	struct scrub_fs_ctx *sfctx = bio->bi_private;
+	struct bio_vec *bvec;
+	struct bvec_iter_all iter_all;
+	unsigned int bio_size = 0;
+
+	bio_for_each_segment_all(bvec, bio, iter_all)
+		bio_size += bvec->bv_len;
+
+	/* Repair should be inside one stripe. */
+	ASSERT(bio_size <= BTRFS_STRIPE_LEN);
+
+	atomic_dec(&sfctx->bios_under_io);
+	wake_up(&sfctx->wait);
+	bio_put(bio);
+}
+
+static void scrub_fs_repair_mirror(struct scrub_fs_ctx *sfctx,
+				   struct btrfs_io_context *bioc, int mirror_nr)
+{
+	struct bio *bio = NULL;
+	int last_sector = -1;
+	int i;
+
+	ASSERT(mirror_nr < bioc->num_stripes);
+
+	for (i = 0; i < sfctx->sectors_per_stripe; i++) {
+		struct scrub_fs_sector *sector =
+			scrub_fs_get_sector(sfctx, i, mirror_nr);
+
+		if (sector->flags & SCRUB_FS_SECTOR_FLAG_DEV_MISSING ||
+		    sector->flags & SCRUB_FS_SECTOR_FLAG_GOOD ||
+		    !(sector->flags & SCRUB_FS_SECTOR_FLAG_RECOVERABLE))
+			continue;
+
+		/* No bio allocated, alloc a new one. */
+		if (!bio) {
+			blk_opf_t opf = REQ_OP_WRITE | REQ_BACKGROUND;
+
+			if (sector->flags & SCRUB_FS_SECTOR_FLAG_META)
+				opf |= REQ_META;
+
+			bio = bio_alloc(bioc->stripes[mirror_nr].dev->bdev,
+					sfctx->sectors_per_stripe, opf,
+					GFP_KERNEL);
+			/* It's backed up by mempool. */
+			ASSERT(bio);
+
+			bio->bi_iter.bi_sector =
+				(bioc->stripes[mirror_nr].physical +
+				 (i << sfctx->fs_info->sectorsize_bits)) >>
+				SECTOR_SHIFT;
+			bio->bi_private = sfctx;
+			bio->bi_end_io = scrub_fs_write_endio;
+
+			last_sector = i - 1;
+		}
+
+		/* Can merge into preivous bio.*/
+		if (last_sector == i - 1) {
+			struct page *page =
+				scrub_fs_get_page(sfctx, i, mirror_nr);
+			unsigned int page_off =
+				scrub_fs_get_page_offset(sfctx, i, mirror_nr);
+			int ret;
+
+			ret = bio_add_page(bio, page, sfctx->fs_info->sectorsize,
+					   page_off);
+			ASSERT(ret == sfctx->fs_info->sectorsize);
+			last_sector = i;
+			continue;
+		}
+
+		/* Can not merge, has to submit the current one and retry. */
+		ASSERT(bio);
+		atomic_inc(&sfctx->bios_under_io);
+		submit_bio(bio);
+		bio = NULL;
+		i--;
+	}
+	if (bio) {
+		atomic_inc(&sfctx->bios_under_io);
+		submit_bio(bio);
+	}
+}
+
 static int scrub_fs_one_stripe(struct scrub_fs_ctx *sfctx)
 {
 	struct btrfs_fs_info *fs_info = sfctx->fs_info;
@@ -5413,7 +5500,14 @@ static int scrub_fs_one_stripe(struct scrub_fs_ctx *sfctx)
 	for (i = 0; i < sfctx->sectors_per_stripe; i++)
 		scrub_fs_update_veritical(sfctx, i);
 
-	/* Place holder for repair write-back code */
+	/* Submit repair*/
+	if (!sfctx->readonly) {
+		for (i = 0; i < sfctx->nr_copies; i++)
+			scrub_fs_repair_mirror(sfctx, bioc, i);
+		wait_event(sfctx->wait, atomic_read(&sfctx->bios_under_io) == 0);
+	}
+	ASSERT(atomic_read(&sfctx->bios_under_io) == 0);
+
 out:
 	btrfs_put_bioc(bioc);
 	btrfs_bio_counter_dec(fs_info);
-- 
2.37.3

