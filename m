Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 693CA468F22
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Dec 2021 03:30:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234289AbhLFCdf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 5 Dec 2021 21:33:35 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:51846 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234249AbhLFCdb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 5 Dec 2021 21:33:31 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 88C371FDF2
        for <linux-btrfs@vger.kernel.org>; Mon,  6 Dec 2021 02:30:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1638757802; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=erPPHdibGMxT55fT53B2LNf+qi04tMj++6J9NGjVhXk=;
        b=fSjt5iCR1CwX73bZy5JFpP5/seCpgBLBTxjl59c3nJjOFqZSgetLXTqTD6bWEdiwTFCVTs
        sVjzYPMB/+ovN5XnxFsaxxFXZVleL4hC/A5YJwO3XF0XBeRHz78ifGIHQ0vztPnd5AR8LT
        CHQ00YsNzL0rxiJXqYURtUIOD9/moPg=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D9FD113451
        for <linux-btrfs@vger.kernel.org>; Mon,  6 Dec 2021 02:30:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id OM2GKKl1rWFEMgAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Mon, 06 Dec 2021 02:30:01 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 04/17] btrfs: refactor btrfs_map_bio()
Date:   Mon,  6 Dec 2021 10:29:24 +0800
Message-Id: <20211206022937.26465-5-wqu@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211206022937.26465-1-wqu@suse.com>
References: <20211206022937.26465-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Currently in btrfs_map_bio() we call __btrfs_map_block(), then using the
returned bioc to submit real stripes.

This is fine if we're only going to handle one bio a time.

For the incoming bio split at btrfs_map_bio() time, we want to handle
several different bios, thus there we introduce a new helper,
submit_one_mapped_range() to handle the submission part, making it much
easier to make it work in a loop.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/volumes.c | 67 ++++++++++++++++++++++++++++------------------
 1 file changed, 41 insertions(+), 26 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index cdf5725f1f32..1630a4d22122 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -6777,30 +6777,15 @@ static void bioc_error(struct btrfs_io_context *bioc, struct bio *bio, u64 logic
 	}
 }
 
-blk_status_t btrfs_map_bio(struct btrfs_fs_info *fs_info, struct bio *bio,
-			   int mirror_num)
+static int submit_one_mapped_range(struct btrfs_fs_info *fs_info, struct bio *bio,
+				   struct btrfs_io_context *bioc, u64 map_length,
+				   int mirror_num)
 {
-	struct btrfs_device *dev;
 	struct bio *first_bio = bio;
-	u64 logical = bio->bi_iter.bi_sector << 9;
-	u64 length = 0;
-	u64 map_length;
-	int ret;
-	int dev_nr;
+	u64 logical = bio->bi_iter.bi_sector << SECTOR_SHIFT;
 	int total_devs;
-	struct btrfs_io_context *bioc = NULL;
-
-	length = bio->bi_iter.bi_size;
-	map_length = length;
-
-	btrfs_bio_counter_inc_blocked(fs_info);
-	btrfs_bio_save_iter(btrfs_bio(bio));
-	ret = __btrfs_map_block(fs_info, btrfs_op(bio), logical,
-				&map_length, &bioc, mirror_num, 1);
-	if (ret) {
-		btrfs_bio_counter_dec(fs_info);
-		return errno_to_blk_status(ret);
-	}
+	int dev_nr;
+	int ret;
 
 	total_devs = bioc->num_stripes;
 	bioc->orig_bio = first_bio;
@@ -6819,18 +6804,19 @@ blk_status_t btrfs_map_bio(struct btrfs_fs_info *fs_info, struct bio *bio,
 						    mirror_num, 1);
 		}
 
-		btrfs_bio_counter_dec(fs_info);
-		return errno_to_blk_status(ret);
+		return ret;
 	}
 
-	if (map_length < length) {
+	if (map_length < bio->bi_iter.bi_size) {
 		btrfs_crit(fs_info,
-			   "mapping failed logical %llu bio len %llu len %llu",
-			   logical, length, map_length);
+			   "mapping failed logical %llu bio len %u len %llu",
+			   logical, bio->bi_iter.bi_size, map_length);
 		BUG();
 	}
 
 	for (dev_nr = 0; dev_nr < total_devs; dev_nr++) {
+		struct btrfs_device *dev;
+
 		dev = bioc->stripes[dev_nr].dev;
 		if (!dev || !dev->bdev || test_bit(BTRFS_DEV_STATE_MISSING,
 						   &dev->dev_state) ||
@@ -6847,6 +6833,35 @@ blk_status_t btrfs_map_bio(struct btrfs_fs_info *fs_info, struct bio *bio,
 
 		submit_stripe_bio(bioc, bio, bioc->stripes[dev_nr].physical, dev);
 	}
+	return 0;
+}
+
+blk_status_t btrfs_map_bio(struct btrfs_fs_info *fs_info, struct bio *bio,
+			   int mirror_num)
+{
+	u64 logical = bio->bi_iter.bi_sector << 9;
+	u64 length = 0;
+	u64 map_length;
+	int ret;
+	struct btrfs_io_context *bioc = NULL;
+
+	length = bio->bi_iter.bi_size;
+	map_length = length;
+
+	btrfs_bio_counter_inc_blocked(fs_info);
+	btrfs_bio_save_iter(btrfs_bio(bio));
+	ret = __btrfs_map_block(fs_info, btrfs_op(bio), logical,
+				&map_length, &bioc, mirror_num, 1);
+	if (ret) {
+		btrfs_bio_counter_dec(fs_info);
+		return errno_to_blk_status(ret);
+	}
+
+	ret = submit_one_mapped_range(fs_info, bio, bioc, map_length, mirror_num);
+	if (ret < 0) {
+		btrfs_bio_counter_dec(fs_info);
+		return errno_to_blk_status(ret);
+	}
 	btrfs_bio_counter_dec(fs_info);
 	return BLK_STS_OK;
 }
-- 
2.34.1

