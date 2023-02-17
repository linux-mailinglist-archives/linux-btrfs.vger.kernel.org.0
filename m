Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A2AB69A5E3
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Feb 2023 08:04:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbjBQHEZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Feb 2023 02:04:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjBQHEY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Feb 2023 02:04:24 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74AF4115
        for <linux-btrfs@vger.kernel.org>; Thu, 16 Feb 2023 23:04:22 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 2015A20D80
        for <linux-btrfs@vger.kernel.org>; Fri, 17 Feb 2023 07:04:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1676617461; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=uW1cuodaQ3jwche1cHy/p7NZCQbxnJoDHkdQl3jC5Eg=;
        b=aLqKEvOSCoXQO0TundSYRof28UYOEsetscqPWk1dUy+5vasVVg9pfHwhQCat4AXdnCn/sC
        Y4wXq2kvCt+cpfgMLu/GmNvMUHziUXZJxjZ2RHX+mRJYlI4L7/gt3UHopw/jiQ/dVGFdaa
        A18Z2q5uUR6/D42G8COOV1ELevCTnuE=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7879C138E3
        for <linux-btrfs@vger.kernel.org>; Fri, 17 Feb 2023 07:04:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id eloLEfQm72N1YQAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Fri, 17 Feb 2023 07:04:20 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: make dev-replace properly follow its read policy
Date:   Fri, 17 Feb 2023 15:04:03 +0800
Message-Id: <bedcd1c5bebd452ac43eb4fd385890582622a758.1676617361.git.wqu@suse.com>
X-Mailer: git-send-email 2.39.1
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

[BUG]
Although dev replace ioctl has a way to specify the policy on whether we
should read from the source device, it's not properly followed.

 # mkfs.btrfs -f -d raid1 -m raid1 $dev1 $dev2
 # mount $dev1 $mnt
 # xfs_io -f -c "pwrite 0 32M" $mnt/file
 # sync
 # btrfs replace start -r -f 1 $dev3 $mnt

And one extra trace is added to scrub_submit(), showing the detail about
the bio:

           btrfs-1115669 [005] .....  5437.027093: scrub_submit.part.0: devid=1 logical=22036480 phy=22036480 len=16384
           btrfs-1115669 [005] .....  5437.027372: scrub_submit.part.0: devid=1 logical=30457856 phy=30457856 len=32768
           btrfs-1115669 [005] .....  5437.027440: scrub_submit.part.0: devid=1 logical=30507008 phy=30507008 len=49152
           btrfs-1115669 [005] .....  5437.027487: scrub_submit.part.0: devid=1 logical=30605312 phy=30605312 len=32768
           btrfs-1115669 [005] .....  5437.027556: scrub_submit.part.0: devid=1 logical=30703616 phy=30703616 len=65536
           btrfs-1115669 [005] .....  5437.028186: scrub_submit.part.0: devid=1 logical=298844160 phy=298844160 len=131072
           ...
           btrfs-1115669 [005] .....  5437.076243: scrub_submit.part.0: devid=1 logical=322961408 phy=322961408 len=131072
           btrfs-1115669 [005] .....  5437.076248: scrub_submit.part.0: devid=1 logical=323092480 phy=323092480 len=131072

One can see that all the read are submitted to devid 1, even we have
specified "-r" option to avoid read from the source device.

[CAUSE]
The dev-replace read policy is only set but not followed by scrub code
at all.

In fact, only common read path is properly following the read policy,
but scrub itself has its own read path, thus not following the policy.

[FIX]
Here we enhance scrub_find_good_copy() to also follow the read policy.

The idea is pretty simple, in the first loop, we avoid the following
devices:

- Missing devices
  This is the existing condition

- The source device if the replace wants to avoid it.

And if above loop found no candidate (e.g. replace a single device),
then we discard the 2nd condition, and try again.

Since we're here, also enhance the function scrub_find_good_copy() by:

- Remove the forward declaration

- Makes it return int
  To indicates errors, e.g. no good mirror found.

- Add extra error messages

Now with the same trace, "btrfs replace start -r" works as expected:

           btrfs-1121013 [000] .....  5991.905971: scrub_submit.part.0: devid=2 logical=22036480 phy=1064960 len=16384
           btrfs-1121013 [000] .....  5991.906276: scrub_submit.part.0: devid=2 logical=30457856 phy=9486336 len=32768
           btrfs-1121013 [000] .....  5991.906365: scrub_submit.part.0: devid=2 logical=30507008 phy=9535488 len=49152
           btrfs-1121013 [000] .....  5991.906423: scrub_submit.part.0: devid=2 logical=30605312 phy=9633792 len=32768
           btrfs-1121013 [000] .....  5991.906504: scrub_submit.part.0: devid=2 logical=30703616 phy=9732096 len=65536
           btrfs-1121013 [000] .....  5991.907314: scrub_submit.part.0: devid=2 logical=298844160 phy=277872640 len=131072
           btrfs-1121013 [000] .....  5991.907575: scrub_submit.part.0: devid=2 logical=298975232 phy=278003712 len=131072
           btrfs-1121013 [000] .....  5991.907822: scrub_submit.part.0: devid=2 logical=299106304 phy=278134784 len=131072
           ...
           btrfs-1121013 [000] .....  5991.947417: scrub_submit.part.0: devid=2 logical=318504960 phy=297533440 len=131072
           btrfs-1121013 [000] .....  5991.947664: scrub_submit.part.0: devid=2 logical=318636032 phy=297664512 len=131072
           btrfs-1121013 [000] .....  5991.947920: scrub_submit.part.0: devid=2 logical=318767104 phy=297795584 len=131072

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/scrub.c | 131 +++++++++++++++++++++++++++++++++++------------
 1 file changed, 97 insertions(+), 34 deletions(-)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index ee3fe6c291fe..f9f86893f6bb 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -423,11 +423,6 @@ static int scrub_sectors(struct scrub_ctx *sctx, u64 logical, u32 len,
 static void scrub_bio_end_io(struct bio *bio);
 static void scrub_bio_end_io_worker(struct work_struct *work);
 static void scrub_block_complete(struct scrub_block *sblock);
-static void scrub_find_good_copy(struct btrfs_fs_info *fs_info,
-				 u64 extent_logical, u32 extent_len,
-				 u64 *extent_physical,
-				 struct btrfs_device **extent_dev,
-				 int *extent_mirror_num);
 static int scrub_add_sector_to_wr_bio(struct scrub_ctx *sctx,
 				      struct scrub_sector *sector);
 static void scrub_wr_submit(struct scrub_ctx *sctx);
@@ -2709,6 +2704,93 @@ static int scrub_find_csum(struct scrub_ctx *sctx, u64 logical, u8 *csum)
 	return 1;
 }
 
+static bool should_use_device(struct btrfs_fs_info *fs_info,
+			      struct btrfs_device *dev,
+			      bool follow_replace_policy)
+{
+	struct btrfs_device *replace_srcdev = fs_info->dev_replace.srcdev;
+	struct btrfs_device *replace_tgtdev = fs_info->dev_replace.tgtdev;
+
+	if (!dev->bdev)
+		return false;
+
+	/*
+	 * We're doing scrub/replace, if it's pure scrub, no tgtdev should be
+	 * here.
+	 * If it's replace, we're going to write data to tgtdev, thus the current
+	 * data of the tgtdev is all garbage, thus we can not use it at all.
+	 */
+	if (dev == replace_tgtdev)
+		return false;
+
+	/* No need to follow replace read policy, any existing device is fine. */
+	if (!follow_replace_policy)
+		return true;
+
+	/* Need to follow the policy. */
+	if (fs_info->dev_replace.cont_reading_from_srcdev_mode ==
+	    BTRFS_DEV_REPLACE_ITEM_CONT_READING_FROM_SRCDEV_MODE_AVOID)
+		return dev != replace_srcdev;
+	return true;
+}
+static int scrub_find_good_copy(struct btrfs_fs_info *fs_info,
+				u64 extent_logical, u32 extent_len,
+				u64 *extent_physical,
+				struct btrfs_device **extent_dev,
+				int *extent_mirror_num)
+{
+	u64 mapped_length;
+	struct btrfs_io_context *bioc = NULL;
+	int ret;
+	int i;
+
+	mapped_length = extent_len;
+	ret = btrfs_map_block(fs_info, BTRFS_MAP_GET_READ_MIRRORS,
+			      extent_logical, &mapped_length, &bioc, 0);
+	if (ret || !bioc || mapped_length < extent_len) {
+		btrfs_put_bioc(bioc);
+		btrfs_err_rl(fs_info, "btrfs_map_block() failed for logical %llu: %d",
+				extent_logical, ret);
+		return -EIO;
+	}
+
+	/*
+	 * First loop to exclude all missing devices and the source
+	 * device if needed.
+	 * And we don't want to use target device as mirror either,
+	 * as we're doing the replace, the target device range
+	 * contains nothing.
+	 */
+	for (i = 0; i < bioc->num_stripes - bioc->replace_nr_stripes; i++) {
+		struct btrfs_io_stripe *stripe = &bioc->stripes[i];
+
+		if (!should_use_device(fs_info, stripe->dev, true))
+			continue;
+		goto found;
+	}
+	/*
+	 * We didn't find any alternative mirrors, we have to break our
+	 * read policy, or we can not read at all.
+	 */
+	for (i = 0; i < bioc->num_stripes - bioc->replace_nr_stripes; i++) {
+		struct btrfs_io_stripe *stripe = &bioc->stripes[i];
+
+		if (!should_use_device(fs_info, stripe->dev, false))
+			continue;
+		goto found;
+	}
+
+	btrfs_err_rl(fs_info, "failed to find any live mirror for logical %llu",
+			extent_logical);
+	return -EIO;
+
+found:
+	*extent_physical = bioc->stripes[i].physical;
+	*extent_mirror_num = i + 1;
+	*extent_dev = bioc->stripes[i].dev;
+	btrfs_put_bioc(bioc);
+	return 0;
+}
 /* scrub extent tries to collect up to 64 kB for each bio */
 static int scrub_extent(struct scrub_ctx *sctx, struct map_lookup *map,
 			u64 logical, u32 len,
@@ -2746,7 +2828,8 @@ static int scrub_extent(struct scrub_ctx *sctx, struct map_lookup *map,
 	}
 
 	/*
-	 * For dev-replace case, we can have @dev being a missing device.
+	 * For dev-replace case, we can have @dev being a missing device, or
+	 * we want to avoid read from the source device if possible.
 	 * Regular scrub will avoid its execution on missing device at all,
 	 * as that would trigger tons of read error.
 	 *
@@ -2754,9 +2837,14 @@ static int scrub_extent(struct scrub_ctx *sctx, struct map_lookup *map,
 	 * increase unnecessarily.
 	 * So here we change the read source to a good mirror.
 	 */
-	if (sctx->is_dev_replace && !dev->bdev)
-		scrub_find_good_copy(sctx->fs_info, logical, len, &src_physical,
-				     &src_dev, &src_mirror);
+	if (sctx->is_dev_replace &&
+	    (!dev->bdev || sctx->fs_info->dev_replace.cont_reading_from_srcdev_mode ==
+	     BTRFS_DEV_REPLACE_ITEM_CONT_READING_FROM_SRCDEV_MODE_AVOID)) {
+		ret = scrub_find_good_copy(sctx->fs_info, logical, len,
+					   &src_physical, &src_dev, &src_mirror);
+		if (ret < 0)
+			return ret;
+	}
 	while (len) {
 		u32 l = min(len, blocksize);
 		int have_csum = 0;
@@ -4544,28 +4632,3 @@ int btrfs_scrub_progress(struct btrfs_fs_info *fs_info, u64 devid,
 
 	return dev ? (sctx ? 0 : -ENOTCONN) : -ENODEV;
 }
-
-static void scrub_find_good_copy(struct btrfs_fs_info *fs_info,
-				 u64 extent_logical, u32 extent_len,
-				 u64 *extent_physical,
-				 struct btrfs_device **extent_dev,
-				 int *extent_mirror_num)
-{
-	u64 mapped_length;
-	struct btrfs_io_context *bioc = NULL;
-	int ret;
-
-	mapped_length = extent_len;
-	ret = btrfs_map_block(fs_info, BTRFS_MAP_READ, extent_logical,
-			      &mapped_length, &bioc, 0);
-	if (ret || !bioc || mapped_length < extent_len ||
-	    !bioc->stripes[0].dev->bdev) {
-		btrfs_put_bioc(bioc);
-		return;
-	}
-
-	*extent_physical = bioc->stripes[0].physical;
-	*extent_mirror_num = bioc->mirror_num;
-	*extent_dev = bioc->stripes[0].dev;
-	btrfs_put_bioc(bioc);
-}
-- 
2.39.1

