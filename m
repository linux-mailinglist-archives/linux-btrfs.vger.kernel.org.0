Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 193656273D9
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Nov 2022 01:27:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235617AbiKNA1R (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 13 Nov 2022 19:27:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235600AbiKNA1J (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 13 Nov 2022 19:27:09 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88D7CE001
        for <linux-btrfs@vger.kernel.org>; Sun, 13 Nov 2022 16:26:58 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 45AFE1FBA5
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Nov 2022 00:26:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1668385617; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CghSm/0+PDoxgCNfjcy52OL6m2FSHW4lpgi+Pzkuk1U=;
        b=HtaUUbiUsLhexfRd+ioiu0REdruJAFlgLMNiZ7LUfYEJKBhhR+fm6eoOneYBWOQfivAcxN
        kTi2YooydTASmZkhe/wNA0xgflj+Xb6maVKbDqwukbcIKuD5PUcE+LjfhBTnLwydbEkzZn
        Vztq2P4XFM47/lTZuuRICeFPMdh3UZg=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8ED6D13A18
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Nov 2022 00:26:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id YPdlFVCLcWN9dAAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Nov 2022 00:26:56 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 4/5] btrfs: raid56: prepare data checksums for later RMW data csum  verification
Date:   Mon, 14 Nov 2022 08:26:33 +0800
Message-Id: <6620c738ea5f959085bfad0c0c843880f4c4e6e2.1668384746.git.wqu@suse.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1668384746.git.wqu@suse.com>
References: <cover.1668384746.git.wqu@suse.com>
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

This is for later data verification at RMW time.

This patch will try to allocate the needed memory for a locked rbio if
the rbio is for data exclusively (we don't want to handle mixed bg yet).

And the memory will be released when the rbio is finished.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/raid56.c | 74 +++++++++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/raid56.h | 12 ++++++++
 2 files changed, 86 insertions(+)

diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
index 11be5d0a7eab..242d3611d2dd 100644
--- a/fs/btrfs/raid56.c
+++ b/fs/btrfs/raid56.c
@@ -20,6 +20,7 @@
 #include "volumes.h"
 #include "raid56.h"
 #include "async-thread.h"
+#include "file-item.h"
 
 /* set when additional merges to this rbio are not allowed */
 #define RBIO_RMW_LOCKED_BIT	1
@@ -835,6 +836,11 @@ static void rbio_orig_end_io(struct btrfs_raid_bio *rbio, blk_status_t err)
 	struct bio *cur = bio_list_get(&rbio->bio_list);
 	struct bio *extra;
 
+	kfree(rbio->csum_buf);
+	bitmap_free(rbio->csum_bitmap);
+	rbio->csum_buf = NULL;
+	rbio->csum_bitmap = NULL;
+
 	/*
 	 * Clear the data bitmap, as the rbio may be cached for later usage.
 	 * do this before before unlock_stripe() so there will be no new bio
@@ -2048,6 +2054,67 @@ void raid56_parity_recover(struct bio *bio, struct btrfs_io_context *bioc,
 	start_async_work(rbio, recover_rbio_work);
 }
 
+static void fill_data_csums(struct btrfs_raid_bio *rbio)
+{
+	struct btrfs_fs_info *fs_info = rbio->bioc->fs_info;
+	struct btrfs_root *csum_root = btrfs_csum_root(fs_info,
+						       rbio->bioc->raid_map[0]);
+	const u64 start = rbio->bioc->raid_map[0];
+	const u32 len = (rbio->nr_data * rbio->stripe_nsectors) <<
+			fs_info->sectorsize_bits;
+	int ret;
+
+	/* The rbio should not has its csum buffer initialized. */
+	ASSERT(!rbio->csum_buf && !rbio->csum_bitmap);
+
+	/*
+	 * Skip the csum search if:
+	 *
+	 * - The rbio doesn't belongs to data block groups
+	 *   Then we are doing IO for tree blocks, no need to
+	 *   search csums.
+	 *
+	 * - The rbio belongs to mixed block groups
+	 *   This is to avoid deadlock, as we're already holding
+	 *   the full stripe lock, if we trigger a metadata read, and
+	 *   it needs to do raid56 recovery, we will deadlock.
+	 */
+	if (!(rbio->bioc->map_type & BTRFS_BLOCK_GROUP_DATA) ||
+	    rbio->bioc->map_type & BTRFS_BLOCK_GROUP_METADATA)
+		return;
+
+	rbio->csum_buf = kzalloc(rbio->nr_data * rbio->stripe_nsectors *
+				 fs_info->csum_size, GFP_NOFS);
+	rbio->csum_bitmap = bitmap_zalloc(rbio->nr_data * rbio->stripe_nsectors,
+				 GFP_NOFS);
+	if (!rbio->csum_buf || !rbio->csum_bitmap)
+		goto error;
+
+	ret = btrfs_lookup_csums_bitmap(csum_root, start, start + len - 1,
+					rbio->csum_buf, rbio->csum_bitmap);
+	if (ret < 0)
+		goto error;
+	if (bitmap_empty(rbio->csum_bitmap, len >> fs_info->sectorsize_bits))
+		goto no_csum;
+	return;
+
+error:
+	/*
+	 * We failed to allocate memory or grab the csum,
+	 * but it's not the end of day, we can still continue.
+	 * But better to warn users that RMW is no longer safe for this
+	 * particular sub-stripe write.
+	 */
+	btrfs_warn_rl(fs_info,
+"sub-stripe write for full stripe %llu is not safe, failed to get csum: %d",
+			rbio->bioc->raid_map[0], ret);
+no_csum:
+	kfree(rbio->csum_buf);
+	bitmap_free(rbio->csum_bitmap);
+	rbio->csum_buf = NULL;
+	rbio->csum_bitmap = NULL;
+}
+
 static int rmw_read_and_wait(struct btrfs_raid_bio *rbio)
 {
 	struct bio_list bio_list;
@@ -2056,6 +2123,13 @@ static int rmw_read_and_wait(struct btrfs_raid_bio *rbio)
 
 	bio_list_init(&bio_list);
 
+	/*
+	 * Fill the data csum we need for data verification.
+	 * We need to fill the csum_bitmap/csum_buf first, as our endio
+	 * function will try to verify the data sectors.
+	 */
+	fill_data_csums(rbio);
+
 	ret = rmw_assemble_read_bios(rbio, &bio_list);
 	if (ret < 0)
 		goto out;
diff --git a/fs/btrfs/raid56.h b/fs/btrfs/raid56.h
index a2e653e93fd8..951acd52cd4f 100644
--- a/fs/btrfs/raid56.h
+++ b/fs/btrfs/raid56.h
@@ -129,6 +129,18 @@ struct btrfs_raid_bio {
 	 * Thus making it much harder to iterate.
 	 */
 	unsigned long *error_bitmap;
+
+	/*
+	 * Checksum buffer if the rbio is for data.
+	 * The buffer should cover all data sectors (exlcuding P/Q sectors).
+	 */
+	u8 *csum_buf;
+
+	/*
+	 * Each bit represents if the corresponding sector has data csum found.
+	 * Should only cover data sectors (excluding P/Q sectors).
+	 */
+	unsigned long *csum_bitmap;
 };
 
 /*
-- 
2.38.1

