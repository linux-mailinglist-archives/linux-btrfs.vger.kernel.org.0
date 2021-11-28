Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DD9C4604C4
	for <lists+linux-btrfs@lfdr.de>; Sun, 28 Nov 2021 06:55:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232328AbhK1F6j (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 28 Nov 2021 00:58:39 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:35618 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232437AbhK1F4i (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 28 Nov 2021 00:56:38 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E216C21709;
        Sun, 28 Nov 2021 05:53:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1638078801; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KiHyqRTAUPhFLqPJbKlyhOfOxAOqdrwrtLHycG84yes=;
        b=VaJtssvwIJYxEYYKK7jcH6Sqq+ct4/C8xsu1LWuCwY+0FO//NiohUSx/oX2nW1j35HJKsr
        t58FE3pyi5k6GZqRPO+/zahJAtPrs6eWyCLGAJhXch/FrrbcF23+0Wpv52dDUBA7glszlb
        HoMD/qqm5mxEGaG2bPH6cVcJOG6bQH4=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E1B0A13446;
        Sun, 28 Nov 2021 05:53:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id kBf/K1AZo2G7fAAAMHmgww
        (envelope-from <wqu@suse.com>); Sun, 28 Nov 2021 05:53:20 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     linux-block@vger.kernel.org, dm-devel@redhat.com
Subject: [PATCH RFC 02/11] btrfs: refactor btrfs_map_bio()
Date:   Sun, 28 Nov 2021 13:52:50 +0800
Message-Id: <20211128055259.39249-3-wqu@suse.com>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20211128055259.39249-1-wqu@suse.com>
References: <20211128055259.39249-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Currently in btrfs_map_bio() we call __btrfs_map_block(), then using the
returned bioc to submit real stripes.

This is fine if we're only going to handle one bio a time.

For the incoming bio split at btrfs_map_bio() time, we want to handle
several differnet bios, thus there we introduce a new helper,
submit_one_mapped_range() to handle the submission part, making it much
easier to make it work in a loop.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/volumes.c | 65 ++++++++++++++++++++++++++++------------------
 1 file changed, 40 insertions(+), 25 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 3dc1de376966..1d40f4fa64a3 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -6772,29 +6772,15 @@ static void bioc_error(struct btrfs_io_context *bioc, struct bio *bio, u64 logic
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
@@ -6813,18 +6799,19 @@ blk_status_t btrfs_map_bio(struct btrfs_fs_info *fs_info, struct bio *bio,
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
@@ -6841,6 +6828,34 @@ blk_status_t btrfs_map_bio(struct btrfs_fs_info *fs_info, struct bio *bio,
 
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
2.34.0

