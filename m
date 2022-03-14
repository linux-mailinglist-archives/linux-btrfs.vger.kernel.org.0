Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A82B4D7E21
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Mar 2022 10:08:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235357AbiCNJJH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 14 Mar 2022 05:09:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231784AbiCNJJF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 14 Mar 2022 05:09:05 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEBA51FCEC
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Mar 2022 02:07:55 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 6B3171F388
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Mar 2022 09:07:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1647248874; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tUZvOY96EcPvi0cZawvo+EzWalylEsfkuWU9mruWxXY=;
        b=mq9UyHXQbkMRncKJt/2uVT7F9ak/2AYDan2yuwEwCZwzpnJed8z/8EHYBXWL+RylX/k3Mh
        cC0EUFc4MFBQ9s8qsVH4V4uAn8AodxoPxMoxrgt3deBkvvKhnbA5e9Ug919TDzWFPGPUGD
        6NES+XvM+0zLpTKw6lZvb4khqMVPqQY=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BFBA713ADA
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Mar 2022 09:07:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 4LEtIukFL2IaYgAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Mar 2022 09:07:53 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v3 04/18] btrfs: refactor btrfs_map_bio()
Date:   Mon, 14 Mar 2022 17:07:17 +0800
Message-Id: <f8105a1c9b9a770ab34776e6a3b2c28fd1080174.1647248613.git.wqu@suse.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1647248613.git.wqu@suse.com>
References: <cover.1647248613.git.wqu@suse.com>
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
index 9bc48a8368e8..10a5db07836b 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -6769,30 +6769,15 @@ static void bioc_error(struct btrfs_io_context *bioc, struct bio *bio, u64 logic
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
@@ -6811,18 +6796,19 @@ blk_status_t btrfs_map_bio(struct btrfs_fs_info *fs_info, struct bio *bio,
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
@@ -6839,6 +6825,35 @@ blk_status_t btrfs_map_bio(struct btrfs_fs_info *fs_info, struct bio *bio,
 
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
2.35.1

