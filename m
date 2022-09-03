Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B48315ABDC3
	for <lists+linux-btrfs@lfdr.de>; Sat,  3 Sep 2022 10:20:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232509AbiICIUG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 3 Sep 2022 04:20:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232470AbiICIUD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sat, 3 Sep 2022 04:20:03 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C2D13A4A2
        for <linux-btrfs@vger.kernel.org>; Sat,  3 Sep 2022 01:20:01 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id C402C33800
        for <linux-btrfs@vger.kernel.org>; Sat,  3 Sep 2022 08:19:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1662193199; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TWq7dtKt8tQvNCZ0plBbnOU1Qx+vTTV3wI64GMjUF2U=;
        b=tPsLwU1Gs2oSTijl+MAn20SU2alfVM8XQfxZ68P6sQFYnRMHyCZs+UHoUmOn/Ak0dG2TlM
        5fKJDon1+jvyFYsUIspyY3cvmKiSrk/nMkhS5Av8/S5hx7NCGVcABLaU6jZXJx2vKezA8D
        cU17m/Ro0lhP/6Fj2ULTZTejHdHh1jo=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 20D6B139F9
        for <linux-btrfs@vger.kernel.org>; Sat,  3 Sep 2022 08:19:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id UMOwNi4OE2OzagAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Sat, 03 Sep 2022 08:19:58 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH PoC 8/9] btrfs: scrub: implement data verification code for scrub_fs
Date:   Sat,  3 Sep 2022 16:19:28 +0800
Message-Id: <c83d3feb9812f0c3047b39ef97db3c9d9ca3ab35.1662191784.git.wqu@suse.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <cover.1662191784.git.wqu@suse.com>
References: <cover.1662191784.git.wqu@suse.com>
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

For data verification it's much simpler, only need to do csum
verification and we have very handy helper for it.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/scrub.c | 58 +++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 57 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index f587d0373517..145bd5c9601d 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -5226,6 +5226,60 @@ static void scrub_fs_verify_meta(struct scrub_fs_ctx *sfctx, int sector_nr)
 		scrub_fs_verify_one_meta(sfctx, sector_nr, i);
 }
 
+/* Convert a sector pointer to its index inside sfctx->sectors[] array. */
+static int scrub_fs_sector_to_sector_index(struct scrub_fs_ctx *sfctx,
+					   struct scrub_fs_sector *sector)
+{
+	int i;
+
+	ASSERT(sector);
+	for (i = 0; i < sfctx->total_sectors; i++) {
+		if (&sfctx->sectors[i] == sector)
+			break;
+	}
+	/* As long as @sector is from sfctx->sectors[], we should have found it. */
+	ASSERT(i < sfctx->total_sectors);
+	return i; 
+}
+
+static void scrub_fs_verify_one_data(struct scrub_fs_ctx *sfctx, int sector_nr,
+				     int mirror_nr)
+{
+	struct btrfs_fs_info *fs_info = sfctx->fs_info;
+	struct scrub_fs_sector *sector =
+		scrub_fs_get_sector(sfctx, sector_nr, mirror_nr);
+	int index = scrub_fs_sector_to_sector_index(sfctx, sector);
+	struct page *data_page = scrub_fs_get_page(sfctx, index);
+	unsigned int data_page_off = scrub_fs_get_page_offset(sfctx, index);
+	u8 csum_result[BTRFS_CSUM_SIZE];
+	u8 *csum_expected = sector->csum;
+	int ret;
+
+	sfctx->stat.data_scrubbed += fs_info->sectorsize;
+
+	/* No IO done, just increase the accounting. */
+	if (!(sector->flags & SCRUB_FS_SECTOR_FLAG_IO_DONE)) {
+		sfctx->stat.data_io_fail += fs_info->sectorsize;
+		return;
+	}
+
+	/*
+	 * NODATASUM case, just skip, we will come back later to determine
+	 * the status when checking the sectors inside the same vertical stripe.
+	 */
+	if (!csum_expected)
+		return;
+
+	ret = btrfs_check_sector_csum(fs_info, data_page, data_page_off,
+				      csum_result, csum_expected);
+	if (ret < 0) {
+		sfctx->stat.data_csum_mismatch += fs_info->sectorsize;
+		return;
+	}
+	/* All good. */
+	sector->flags |= SCRUB_FS_SECTOR_FLAG_GOOD;
+}
+
 static void scrub_fs_verify_one_stripe(struct scrub_fs_ctx *sfctx)
 {
 	struct btrfs_fs_info *fs_info = sfctx->fs_info;
@@ -5236,6 +5290,7 @@ static void scrub_fs_verify_one_stripe(struct scrub_fs_ctx *sfctx)
 	for (sector_nr = 0; sector_nr < sectors_per_stripe; sector_nr++) {
 		struct scrub_fs_sector *sector =
 			scrub_fs_get_sector(sfctx, sector_nr, 0);
+		int mirror_nr;
 
 		/*
 		 * All sectors in the same veritical stripe should share
@@ -5258,7 +5313,8 @@ static void scrub_fs_verify_one_stripe(struct scrub_fs_ctx *sfctx)
 			continue;
 		}
 
-		/* Place holder for data verification. */
+		for (mirror_nr = 0; mirror_nr < sfctx->nr_copies; mirror_nr++)
+			scrub_fs_verify_one_data(sfctx, sector_nr, mirror_nr);
 	}
 	/* Place holder for recoverable checks. */
 }
-- 
2.37.3

