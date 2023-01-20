Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A2DF674FFC
	for <lists+linux-btrfs@lfdr.de>; Fri, 20 Jan 2023 09:56:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbjATI4z (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 20 Jan 2023 03:56:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbjATI4y (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 20 Jan 2023 03:56:54 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E25D3D903
        for <linux-btrfs@vger.kernel.org>; Fri, 20 Jan 2023 00:56:53 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id CC8275D9E2
        for <linux-btrfs@vger.kernel.org>; Fri, 20 Jan 2023 08:56:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1674205011; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=xvw/Z7mr9pYB1hINSYRVDWBYwR7etn084DmqIhJyh9w=;
        b=CughpGRqRFv0H2CvGwB0OGomPpy5GPW8ZXQ2thENaVLMUHyrUBjBbkON9MQjNFrvXoHLPs
        0oQyOnSS40Aq0vr0KqzXNuqBC9mTaavejc0iSMhREUH7T/IM4sibl/v22NhB5g02I4ws/r
        7j0O0hDhoCbLp/ZhY14zwocziyAUrAQ=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3DE8F13251
        for <linux-btrfs@vger.kernel.org>; Fri, 20 Jan 2023 08:56:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id MjQCBFNXymNqIAAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Fri, 20 Jan 2023 08:56:51 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: raid56: protect error_bitmap update with spinlock
Date:   Fri, 20 Jan 2023 16:56:34 +0800
Message-Id: <e21c9c44b8a88d381744e83dfd3b1505cc35e4e4.1674204981.git.wqu@suse.com>
X-Mailer: git-send-email 2.39.0
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

In the rework of raid56 code, there is very limited concurrency in the
endio context.

Most of works is done inside the sectors arrays, which different bios
will never touch the same sector.

But there is a cocurrency here for error_bitmap. Both read and write
endio functions need to touch them, and we can have multiple write bios
touching the same error bitmap if they all hit some errors.

And since bitmap_set() is not atomic, we need spinlock to protect the
error_bitmap, or we may miss some bits.

This patch will fix it by introducing btrfs_raid_bio::error_bitmap_lock,
and properly hold the spinlock during error_bitmap update.

Fixes: 2942a50dea74 ("btrfs: raid56: introduce btrfs_raid_bio::error_bitmap")
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/raid56.c | 4 ++++
 fs/btrfs/raid56.h | 7 +++++++
 2 files changed, 11 insertions(+)

diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
index 65ed4f326fb9..ee1b6b95a10b 100644
--- a/fs/btrfs/raid56.c
+++ b/fs/btrfs/raid56.c
@@ -951,6 +951,7 @@ static struct btrfs_raid_bio *alloc_rbio(struct btrfs_fs_info *fs_info,
 	init_waitqueue_head(&rbio->io_wait);
 	INIT_LIST_HEAD(&rbio->plug_list);
 	spin_lock_init(&rbio->bio_list_lock);
+	spin_lock_init(&rbio->error_bitmap_lock);
 	INIT_LIST_HEAD(&rbio->stripe_cache);
 	INIT_LIST_HEAD(&rbio->hash_list);
 	btrfs_get_bioc(bioc);
@@ -1426,12 +1427,15 @@ static void rbio_update_error_bitmap(struct btrfs_raid_bio *rbio, struct bio *bi
 	u32 bio_size = 0;
 	struct bio_vec *bvec;
 	struct bvec_iter_all iter_all;
+	unsigned long flags;
 
 	bio_for_each_segment_all(bvec, bio, iter_all)
 		bio_size += bvec->bv_len;
 
+	spin_lock_irqsave(&rbio->error_bitmap_lock, flags);
 	bitmap_set(rbio->error_bitmap, total_sector_nr,
 		   bio_size >> rbio->bioc->fs_info->sectorsize_bits);
+	spin_unlock_irqrestore(&rbio->error_bitmap_lock, flags);
 }
 
 /* Verify the data sectors at read time. */
diff --git a/fs/btrfs/raid56.h b/fs/btrfs/raid56.h
index 7c73a443939e..005612f5a312 100644
--- a/fs/btrfs/raid56.h
+++ b/fs/btrfs/raid56.h
@@ -119,6 +119,13 @@ struct btrfs_raid_bio {
 	/* Allocated with real_stripes-many pointers for finish_*() calls */
 	void **finish_pointers;
 
+	/*
+	 * Spinlock for error_bitmap.
+	 * Unlike sector arrays above, error_bitmap can be modified by
+	 * more than one bios at the same time.
+	 */
+	spinlock_t error_bitmap_lock;
+
 	/*
 	 * The bitmap recording where IO errors happened.
 	 * Each bit is corresponding to one sector in either bio_sectors[] or
-- 
2.39.0

