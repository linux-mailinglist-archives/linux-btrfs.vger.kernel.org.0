Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36D4C5FE95B
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Oct 2022 09:17:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbiJNHRn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 14 Oct 2022 03:17:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbiJNHRi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 14 Oct 2022 03:17:38 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BAB715CB10
        for <linux-btrfs@vger.kernel.org>; Fri, 14 Oct 2022 00:17:37 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 27D9022021
        for <linux-btrfs@vger.kernel.org>; Fri, 14 Oct 2022 07:17:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1665731856; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NMNIMioz+hOVToNE2NXwuGAikME210tXdlLTvTjBbeI=;
        b=h9k10p0/utwuS34RczbyqX/+NMT4sy0Dllm7OO34OFdftISLwsl+q2S0x8DGUDgJJ4J/BW
        GkOZWkfUpwGxfdeQcSMpG1zmHkpPkWcKZsV1++9n2FaIyzMmYVDMk9UL35K4cSfejb7kee
        Le99S6ucIGm3fvW91svczE09UZ0oKhA=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 68EC813451
        for <linux-btrfs@vger.kernel.org>; Fri, 14 Oct 2022 07:17:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id WAZ9Cw8NSWOsUwAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Fri, 14 Oct 2022 07:17:35 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH RFC 4/5] btrfs: raid56: prepare data checksums for later sub-stripe verification
Date:   Fri, 14 Oct 2022 15:17:12 +0800
Message-Id: <1e3f5e809daa4e819e140b260e47755357b4a3dd.1665730948.git.wqu@suse.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <cover.1665730948.git.wqu@suse.com>
References: <cover.1665730948.git.wqu@suse.com>
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

And the memory will be released when the rbio is unlocked.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/raid56.c | 72 ++++++++++++++++++++++++++++++++++++++++++++++-
 fs/btrfs/raid56.h | 12 ++++++++
 2 files changed, 83 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
index 1b2899173ae1..8f7e25001a2b 100644
--- a/fs/btrfs/raid56.c
+++ b/fs/btrfs/raid56.c
@@ -19,6 +19,7 @@
 #include "volumes.h"
 #include "raid56.h"
 #include "async-thread.h"
+#include "ordered-data.h"
 
 /* set when additional merges to this rbio are not allowed */
 #define RBIO_RMW_LOCKED_BIT	1
@@ -854,6 +855,16 @@ static void rbio_orig_end_io(struct btrfs_raid_bio *rbio, blk_status_t err)
 	struct bio *cur = bio_list_get(&rbio->bio_list);
 	struct bio *extra;
 
+	/*
+	 * Also freeup the rbio->csum_*.
+	 * Every sub-stripe write should allocate their own csum buffer and
+	 * bitmap by their own, no cached result.
+	 */
+	kfree(rbio->csum_buf);
+	bitmap_free(rbio->csum_bitmap);
+	rbio->csum_buf = NULL;
+	rbio->csum_bitmap = NULL;
+
 	/*
 	 * Clear the data bitmap, as the rbio may be cached for later usage.
 	 * do this before before unlock_stripe() so there will be no new bio
@@ -1675,6 +1686,63 @@ static int full_stripe_write(struct btrfs_raid_bio *rbio)
 	return 0;
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
+		goto enomem;
+
+	ret = btrfs_lookup_csums_bitmap(csum_root, start, start + len - 1,
+					rbio->csum_buf, rbio->csum_bitmap);
+	if (ret < 0)
+		goto enomem;
+	return;
+
+enomem:
+	/*
+	 * We failed to allocated memory for rbio csum verification,
+	 * but it's not the end of day, we can still continue.
+	 * But better to warn users that RMW is no longer safe.
+	 */
+	btrfs_warn_rl(fs_info,
+"failed to allocated memory, sub-stripe write for full stripe %llu is not safe",
+			rbio->bioc->raid_map[0]);
+	kfree(rbio->csum_buf);
+	bitmap_free(rbio->csum_bitmap);
+	rbio->csum_buf = NULL;
+	rbio->csum_bitmap = NULL;
+}
+
 /*
  * partial stripe writes get handed over to async helpers.
  * We're really hoping to merge a few more writes into this
@@ -1685,8 +1753,10 @@ static int partial_stripe_write(struct btrfs_raid_bio *rbio)
 	int ret;
 
 	ret = lock_stripe_add(rbio);
-	if (ret == 0)
+	if (ret == 0) {
+		fill_data_csums(rbio);
 		start_async_work(rbio, rmw_work);
+	}
 	return 0;
 }
 
diff --git a/fs/btrfs/raid56.h b/fs/btrfs/raid56.h
index 91d5c0adad15..fa82ca158899 100644
--- a/fs/btrfs/raid56.h
+++ b/fs/btrfs/raid56.h
@@ -126,6 +126,18 @@ struct btrfs_raid_bio {
 
 	/* Allocated with real_stripes-many pointers for finish_*() calls */
 	void **finish_pointers;
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
2.37.3

