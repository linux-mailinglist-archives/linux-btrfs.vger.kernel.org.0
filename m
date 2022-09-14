Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8FE15B90D9
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Sep 2022 01:08:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229926AbiINXIK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 14 Sep 2022 19:08:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229925AbiINXIG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 14 Sep 2022 19:08:06 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8852A88DEE
        for <linux-btrfs@vger.kernel.org>; Wed, 14 Sep 2022 16:08:04 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id c6so12923561qvn.6
        for <linux-btrfs@vger.kernel.org>; Wed, 14 Sep 2022 16:08:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date;
        bh=H3kx1/pzbmFkH8h4XKFPer63LjQi1HyWST01q1l5aTw=;
        b=CdnuouvkXl9Zm6dwhpZkSOTQSSOovQVMdQKZxm9jFi9nqbeMd98dlJ5/5dAPpwCNub
         MNybse6lpsitLwXEHLFsH7cQpQJ3+D1plJ63EM2puarKSf5kpn676gtrG6Miv2Q6WDW3
         Q8+uGRffC3vQVtwdSLB/Ul11OVD1ZYtt2FXWntFrmEAHcJ/MR7AhQK51q3JHqz5yeFrI
         qWoESKyIS/eEnHLfK202ZYzhYeEckU8Imo4BWCB/X47VEGxuBPUHiyA+1aAHFUFGmXIn
         q2NyT4QDiUwQU0DR685U3ZCT3xkY19rW548Y8PWstzDR93fyUCx87wcxUUjWuayfN+7k
         GxfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=H3kx1/pzbmFkH8h4XKFPer63LjQi1HyWST01q1l5aTw=;
        b=3udjgfmL+Ezf2sBxbTS5Jsc+7WvAKkpgehHmGnIM1Am08eEO+OORGJUXrDl9G94/H1
         GJbrkziH0EN/vXgnlY8nwv7f7CSu4MHEzxg+sAGbq87CQt69raL6rOdWDfPnIHNTp0pD
         PkvMoetFFO4c02HD+QCq7NtZbTrT2x7AN5ud1YRtOu4jYuFsM4xUK/l88CK5K/OiK+uf
         Cy5AoXDqD5uhLfcbBQ2ZBFm4E2Jh7m90HDK3nLmS+a4LQJBhZV194Bx0iscLLGcmplpQ
         7EaCKUhdxDu2lDAxCG0OxkmsnHKW4IKK7A04b36R+4E4V4sOYI1NBxuvf6pcBCNiFjW4
         Debg==
X-Gm-Message-State: ACgBeo0bzFtAN93C4Ptt0aJF3UQcrnKsHdFqh/XCdKbDaPf+nOsOjZbl
        nx8t6DQGAf6Mz9j47JZdsUFhxctAWLL0qg==
X-Google-Smtp-Source: AA6agR55raJaVzhWHcfy+CU+XdmycmtUvlZm9a5oJuPS+0oKMUhirm50auG5s3BA7XVxPnbTl3xtUw==
X-Received: by 2002:a0c:a901:0:b0:4aa:a283:ef4a with SMTP id y1-20020a0ca901000000b004aaa283ef4amr33473455qva.53.1663196883795;
        Wed, 14 Sep 2022 16:08:03 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id s11-20020a05620a29cb00b006b8e049cf08sm3008282qkp.2.2022.09.14.16.08.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Sep 2022 16:08:03 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 09/10] btrfs: make the zoned helpers take btrfs_zoned_device_info
Date:   Wed, 14 Sep 2022 19:07:49 -0400
Message-Id: <8ac50c0d42b9930f7e8305eabab314fe7f3845cc.1663196746.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1663196746.git.josef@toxicpanda.com>
References: <cover.1663196746.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

These helpers are doing btrfs_device->zone_info, but btrfs_device isn't
defined in zoned.h, which forces one to include files in a specific
order.  Fix the helpers to take btrfs_zoned_device_info instead, and
make the callers pass in the zone_info.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/extent-tree.c |  2 +-
 fs/btrfs/scrub.c       |  9 +++++----
 fs/btrfs/volumes.c     |  2 +-
 fs/btrfs/zoned.c       | 20 +++++++++++---------
 fs/btrfs/zoned.h       | 23 +++++++++++------------
 5 files changed, 29 insertions(+), 27 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 9c4ce3c100ec..7dac704071b9 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -1276,7 +1276,7 @@ static inline bool btrfs_can_zone_reset(struct btrfs_device *device,
 {
 	u64 zone_size;
 
-	if (!btrfs_dev_is_sequential(device, physical))
+	if (!btrfs_dev_is_sequential(device->zone_info, physical))
 		return false;
 
 	zone_size = device->zone_info->zone_size;
diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 927431217131..66f09202ba96 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -1792,7 +1792,7 @@ static int fill_writer_pointer_gap(struct scrub_ctx *sctx, u64 physical)
 	if (!btrfs_is_zoned(sctx->fs_info))
 		return 0;
 
-	if (!btrfs_dev_is_sequential(sctx->wr_tgtdev, physical))
+	if (!btrfs_dev_is_sequential(sctx->wr_tgtdev->zone_info, physical))
 		return 0;
 
 	if (sctx->write_pointer < physical) {
@@ -3367,7 +3367,7 @@ static int sync_write_pointer_for_zoned(struct scrub_ctx *sctx, u64 logical,
 				  "zoned: failed to recover write pointer");
 	}
 	mutex_unlock(&sctx->wr_lock);
-	btrfs_dev_clear_zone_empty(sctx->wr_tgtdev, physical);
+	btrfs_dev_clear_zone_empty(sctx->wr_tgtdev->zone_info, physical);
 
 	return ret;
 }
@@ -3627,7 +3627,7 @@ static noinline_for_stack int scrub_stripe(struct scrub_ctx *sctx,
 	blk_start_plug(&plug);
 
 	if (sctx->is_dev_replace &&
-	    btrfs_dev_is_sequential(sctx->wr_tgtdev, physical)) {
+	    btrfs_dev_is_sequential(sctx->wr_tgtdev->zone_info, physical)) {
 		mutex_lock(&sctx->wr_lock);
 		sctx->write_pointer = physical;
 		mutex_unlock(&sctx->wr_lock);
@@ -4146,7 +4146,8 @@ static inline bool btrfs_check_super_location(struct btrfs_device *device, u64 p
 	 * On a non-zoned device, any address is OK. On a zoned device,
 	 * non-SEQUENTIAL WRITE REQUIRED zones are capable.
 	 */
-	return device->zone_info == NULL || !btrfs_dev_is_sequential(device, pos);
+	return device->zone_info == NULL ||
+		!btrfs_dev_is_sequential(device->zone_info, pos);
 }
 
 static noinline_for_stack int scrub_supers(struct scrub_ctx *sctx,
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 29652323ef9b..ac3aca265a59 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -6853,7 +6853,7 @@ static void btrfs_submit_dev_bio(struct btrfs_device *dev, struct bio *bio)
 	if (bio_op(bio) == REQ_OP_ZONE_APPEND) {
 		u64 physical = bio->bi_iter.bi_sector << SECTOR_SHIFT;
 
-		if (btrfs_dev_is_sequential(dev, physical)) {
+		if (btrfs_dev_is_sequential(dev->zone_info, physical)) {
 			u64 zone_start = round_down(physical,
 						    dev->fs_info->zone_size);
 
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 4d6647925545..67751294f113 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -1012,7 +1012,7 @@ u64 btrfs_find_allocatable_zones(struct btrfs_device *device, u64 hole_start,
 			return hole_end;
 
 		/* Check if zones in the region are all empty */
-		if (btrfs_dev_is_sequential(device, pos) &&
+		if (btrfs_dev_is_sequential(zinfo, pos) &&
 		    find_next_zero_bit(zinfo->empty_zones, end, begin) != end) {
 			pos += zinfo->zone_size;
 			continue;
@@ -1098,7 +1098,7 @@ int btrfs_reset_device_zone(struct btrfs_device *device, u64 physical,
 
 	*bytes = length;
 	while (length) {
-		btrfs_dev_set_zone_empty(device, physical);
+		btrfs_dev_set_zone_empty(device->zone_info, physical);
 		btrfs_dev_clear_active_zone(device, physical);
 		physical += device->zone_info->zone_size;
 		length -= device->zone_info->zone_size;
@@ -1134,8 +1134,8 @@ int btrfs_ensure_empty_zones(struct btrfs_device *device, u64 start, u64 size)
 	for (pos = start; pos < start + size; pos += zinfo->zone_size) {
 		u64 reset_bytes;
 
-		if (!btrfs_dev_is_sequential(device, pos) ||
-		    btrfs_dev_is_empty_zone(device, pos))
+		if (!btrfs_dev_is_sequential(zinfo, pos) ||
+		    btrfs_dev_is_empty_zone(zinfo, pos))
 			continue;
 
 		/* Free regions should be empty */
@@ -1315,7 +1315,8 @@ int btrfs_load_block_group_zone_info(struct btrfs_block_group *cache, bool new)
 			continue;
 		}
 
-		is_sequential = btrfs_dev_is_sequential(device, physical[i]);
+		is_sequential = btrfs_dev_is_sequential(device->zone_info,
+							physical[i]);
 		if (is_sequential)
 			num_sequential++;
 		else
@@ -1337,12 +1338,13 @@ int btrfs_load_block_group_zone_info(struct btrfs_block_group *cache, bool new)
 		 * This zone will be used for allocation, so mark this zone
 		 * non-empty.
 		 */
-		btrfs_dev_clear_zone_empty(device, physical[i]);
+		btrfs_dev_clear_zone_empty(device->zone_info, physical[i]);
 
 		down_read(&dev_replace->rwsem);
 		dev_replace_is_ongoing = btrfs_dev_replace_is_ongoing(dev_replace);
 		if (dev_replace_is_ongoing && dev_replace->tgtdev != NULL)
-			btrfs_dev_clear_zone_empty(dev_replace->tgtdev, physical[i]);
+			btrfs_dev_clear_zone_empty(dev_replace->tgtdev->zone_info,
+						   physical[i]);
 		up_read(&dev_replace->rwsem);
 
 		/*
@@ -1720,7 +1722,7 @@ void btrfs_revert_meta_write_pointer(struct btrfs_block_group *cache,
 
 int btrfs_zoned_issue_zeroout(struct btrfs_device *device, u64 physical, u64 length)
 {
-	if (!btrfs_dev_is_sequential(device, physical))
+	if (!btrfs_dev_is_sequential(device->zone_info, physical))
 		return -EOPNOTSUPP;
 
 	return blkdev_issue_zeroout(device->bdev, physical >> SECTOR_SHIFT,
@@ -1784,7 +1786,7 @@ int btrfs_sync_zone_write_pointer(struct btrfs_device *tgt_dev, u64 logical,
 	u64 wp;
 	int ret;
 
-	if (!btrfs_dev_is_sequential(tgt_dev, physical_pos))
+	if (!btrfs_dev_is_sequential(tgt_dev->zone_info, physical_pos))
 		return 0;
 
 	ret = read_zone_info(fs_info, logical, &zone);
diff --git a/fs/btrfs/zoned.h b/fs/btrfs/zoned.h
index a94de42f9edb..eaaa4787fefb 100644
--- a/fs/btrfs/zoned.h
+++ b/fs/btrfs/zoned.h
@@ -267,30 +267,27 @@ static inline int btrfs_zoned_activate_one_bg(struct btrfs_fs_info *fs_info,
 
 #endif
 
-static inline bool btrfs_dev_is_sequential(struct btrfs_device *device, u64 pos)
+static inline bool btrfs_dev_is_sequential(struct btrfs_zoned_device_info *zone_info,
+					   u64 pos)
 {
-	struct btrfs_zoned_device_info *zone_info = device->zone_info;
-
 	if (!zone_info)
 		return false;
 
 	return test_bit(pos >> zone_info->zone_size_shift, zone_info->seq_zones);
 }
 
-static inline bool btrfs_dev_is_empty_zone(struct btrfs_device *device, u64 pos)
+static inline bool btrfs_dev_is_empty_zone(struct btrfs_zoned_device_info *zone_info,
+					   u64 pos)
 {
-	struct btrfs_zoned_device_info *zone_info = device->zone_info;
-
 	if (!zone_info)
 		return true;
 
 	return test_bit(pos >> zone_info->zone_size_shift, zone_info->empty_zones);
 }
 
-static inline void btrfs_dev_set_empty_zone_bit(struct btrfs_device *device,
+static inline void btrfs_dev_set_empty_zone_bit(struct btrfs_zoned_device_info *zone_info,
 						u64 pos, bool set)
 {
-	struct btrfs_zoned_device_info *zone_info = device->zone_info;
 	unsigned int zno;
 
 	if (!zone_info)
@@ -303,13 +300,15 @@ static inline void btrfs_dev_set_empty_zone_bit(struct btrfs_device *device,
 		clear_bit(zno, zone_info->empty_zones);
 }
 
-static inline void btrfs_dev_set_zone_empty(struct btrfs_device *device, u64 pos)
+static inline void btrfs_dev_set_zone_empty(struct btrfs_zoned_device_info *zone_info,
+					    u64 pos)
 {
-	btrfs_dev_set_empty_zone_bit(device, pos, true);
+	btrfs_dev_set_empty_zone_bit(zone_info, pos, true);
 }
 
-static inline void btrfs_dev_clear_zone_empty(struct btrfs_device *device, u64 pos)
+static inline void btrfs_dev_clear_zone_empty(struct btrfs_zoned_device_info *zone_info,
+					      u64 pos)
 {
-	btrfs_dev_set_empty_zone_bit(device, pos, false);
+	btrfs_dev_set_empty_zone_bit(zone_info, pos, false);
 }
 #endif
-- 
2.26.3

