Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 952C869BFF6
	for <lists+linux-btrfs@lfdr.de>; Sun, 19 Feb 2023 11:34:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229725AbjBSKeG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 19 Feb 2023 05:34:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjBSKeE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 19 Feb 2023 05:34:04 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0902BC66E
        for <linux-btrfs@vger.kernel.org>; Sun, 19 Feb 2023 02:34:01 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 645B622481;
        Sun, 19 Feb 2023 10:33:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1676802839; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=I3IZOrmLe+eoMBVRIPEj1/MJ9vnSsoVpenH60mU9x/c=;
        b=LhVp3gxuHRgf9UjZilft+YmjTKyd3qdPiJAt7xNYMz2TRahlMXiC/yOJlINmjkCxq8ax8C
        4Uc3YPKFL5CenZ93AmNEiMel4gAiQMM8WMpaotgsYsal2gc/w1tYNvZEkj85o07VP/5jJl
        UZ0SuMpCb24SakqSqKMr53AmH0TL2fw=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 07223131FD;
        Sun, 19 Feb 2023 10:33:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id EW1KLxT78WNUJwAAMHmgww
        (envelope-from <wqu@suse.com>); Sun, 19 Feb 2023 10:33:56 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Anand Jain <anand.jain@oracle.com>
Subject: [PATCH v2] btrfs: make dev-replace properly follow its read mode
Date:   Sun, 19 Feb 2023 18:33:38 +0800
Message-Id: <da81abd638ca83237b8b50671e72793c498dddd9.1676802781.git.wqu@suse.com>
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
Although dev replace ioctl has a way to specify the mode on whether we
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
The dev-replace read mode is only set but not followed by scrub code
at all.

In fact, only common read path is properly following the read mode,
but scrub itself has its own read path, thus not following the mode.

[FIX]
Here we enhance scrub_find_good_copy() to also follow the read mode.

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

Reviewed-by: Anand Jain <anand.jain@oracle.com>
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
Changelog:
v2:
- Rename "replace read policy" to "replace read mode" in comments
  This is avoid the confusion with the existing read policy.
  No behavior change.
---
 fs/btrfs/scrub.c | 131 +++++++++++++++++++++++++++++++++++------------
 1 file changed, 97 insertions(+), 34 deletions(-)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index ee3fe6c291fe..4c399a720bf1 100644
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
+			      bool follow_replace_read_mode)
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
+	if (!follow_replace_read_mode)
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
+	 * replace read mode, or we can not read at all.
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

