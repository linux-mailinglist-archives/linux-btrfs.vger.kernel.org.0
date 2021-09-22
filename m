Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 243ED4143BC
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Sep 2021 10:27:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233792AbhIVI3C (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 22 Sep 2021 04:29:02 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:40898 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233564AbhIVI25 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 22 Sep 2021 04:28:57 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 4561822279
        for <linux-btrfs@vger.kernel.org>; Wed, 22 Sep 2021 08:27:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1632299247; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6JHTDBd4ZhbSGVn23hbsXSPhCtdDkzpj8c6ojH2ZNyE=;
        b=iGjTTRXW0Luoh65IlCVv0TclCa7DCpHsCIkDb1Vd+pSm7EkBP9s5xa/JmPZKLLXcGK7BNw
        z9IZJncGNvj8eW1CSa9MbyxvjQXspqmgzBBtMTtZ6dTEAyVrDvJ/FKdYTOUC6pdnaw04aV
        O9Bk6MEMf95oxAgxExGnZITqN7prxLA=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7E7DD13D65
        for <linux-btrfs@vger.kernel.org>; Wed, 22 Sep 2021 08:27:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id WOyMEO7oSmEPDwAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Wed, 22 Sep 2021 08:27:26 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH RFC 2/3] btrfs: remove redundant parameters for submit_stripe_bio()
Date:   Wed, 22 Sep 2021 16:27:05 +0800
Message-Id: <20210922082706.55650-3-wqu@suse.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210922082706.55650-1-wqu@suse.com>
References: <20210922082706.55650-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Function submit_stripe_bio() is to submit bio using provided
btrfs_io_context, which will map the logical address to physical
address, and set the target device.

All the required info is already in bioc, including the device and
physical address, we only need to know which stripe we're targeting at.

This patch will replace @physical and @dev parameters with @stripe_nr.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/volumes.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 86ff268369ec..0c907a3eb3a7 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -6620,9 +6620,11 @@ static void btrfs_end_bio(struct bio *bio)
 }
 
 static void submit_stripe_bio(struct btrfs_io_context *bioc, struct bio *bio,
-			      u64 physical, struct btrfs_device *dev)
+			      unsigned int stripe_nr)
 {
 	struct btrfs_fs_info *fs_info = bioc->fs_info;
+	struct btrfs_device *dev = bioc->stripes[stripe_nr].dev;
+	const u64 physical = bioc->stripes[stripe_nr].physical;
 
 	btrfs_bio(bio)->bioc = bioc;
 	btrfs_bio(bio)->device = dev;
@@ -6674,7 +6676,6 @@ static void bioc_error(struct btrfs_io_context *bioc, struct bio *bio, u64 logic
 blk_status_t btrfs_map_bio(struct btrfs_fs_info *fs_info, struct bio *bio,
 			   int mirror_num)
 {
-	struct btrfs_device *dev;
 	struct bio *first_bio = bio;
 	u64 logical = bio->bi_iter.bi_sector << 9;
 	u64 length = 0;
@@ -6725,7 +6726,8 @@ blk_status_t btrfs_map_bio(struct btrfs_fs_info *fs_info, struct bio *bio,
 	}
 
 	for (dev_nr = 0; dev_nr < total_devs; dev_nr++) {
-		dev = bioc->stripes[dev_nr].dev;
+		struct btrfs_device *dev = bioc->stripes[dev_nr].dev;
+
 		if (!dev || !dev->bdev || test_bit(BTRFS_DEV_STATE_MISSING,
 						   &dev->dev_state) ||
 		    (btrfs_op(first_bio) == BTRFS_MAP_WRITE &&
@@ -6739,7 +6741,7 @@ blk_status_t btrfs_map_bio(struct btrfs_fs_info *fs_info, struct bio *bio,
 		else
 			bio = first_bio;
 
-		submit_stripe_bio(bioc, bio, bioc->stripes[dev_nr].physical, dev);
+		submit_stripe_bio(bioc, bio, dev_nr);
 	}
 	btrfs_bio_counter_dec(fs_info);
 	return BLK_STS_OK;
-- 
2.33.0

