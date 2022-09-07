Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C27B95B004E
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Sep 2022 11:23:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229666AbiIGJXN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 7 Sep 2022 05:23:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230397AbiIGJW5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 7 Sep 2022 05:22:57 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09598B1BB2
        for <linux-btrfs@vger.kernel.org>; Wed,  7 Sep 2022 02:22:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=tqYAgBaKGcVZDNHyGQBfSfLR4nEoz7csSTLSLS+H0QM=; b=JwYf7QApcrJE7RV9Y5JdqoIMcU
        oNykfQy0pkQoz6GL5ljWqSFpt1Gc6o737ye2faKexLmOPDLaLj8FDCl/u/KtYUfeDsKCpWFoT3fw6
        LDO0ng6SU4IUpsJLDOUBA7a+YBcRE3yzAnlPAeTRRY5/ehPjHq2rx4MGe3uJMfCVmC5NtUM03xiVf
        pUS5uN06rjG9VEuWqkkKt6Sz9Iyl6riKI+Sc3VG2ywVkP/UtZuyaXQsXDkOFoV9ii2jhSfx5flfH1
        sDEgkp0Gvnxfe8H0QyLKgAj/wp7OKi3jKaRp7UpEAC+27hZIiD6FuW2ecUhKYIb8V5aKkovfaikwr
        zcI5Lygw==;
Received: from [2001:4bb8:198:38af:1dd2:d819:3b45:2048] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oVrGH-004oln-1P; Wed, 07 Sep 2022 09:22:21 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com
Cc:     naohiro.aota@wdc.com, johannes.thumshirn@wdc.com,
        linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: refactor btrfs_check_zoned_mode
Date:   Wed,  7 Sep 2022 11:22:14 +0200
Message-Id: <20220907092214.2569409-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

btrfs_check_zoned_mode is really hard to follow, mostly due to the
fact that a lot of the checks use duplicate conditions after support
for zone emulation for conventional devices on file systems with the
ZONED flag was added.  Fix this by splitting out the check for host
managed devices for !ZONED file systems into a separate helper and
then simplifying the rest of the code.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/zoned.c | 111 +++++++++++++++++------------------------------
 1 file changed, 41 insertions(+), 70 deletions(-)

diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index e12c0ca509fba..3cd3185fa8c34 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -652,80 +652,54 @@ int btrfs_get_dev_zone(struct btrfs_device *device, u64 pos,
 	return 0;
 }
 
+static int btrfs_check_for_zoned_device(struct btrfs_fs_info *fs_info)
+{
+	struct btrfs_device *device;
+
+	list_for_each_entry(device, &fs_info->fs_devices->devices, dev_list) {
+		if (device->bdev &&
+		    bdev_zoned_model(device->bdev) == BLK_ZONED_HM) {
+			btrfs_err(fs_info,
+				  "zoned: mode not enabled but zoned device found");
+			return -EINVAL;
+		}
+	}
+
+	return 0;
+}
+
 int btrfs_check_zoned_mode(struct btrfs_fs_info *fs_info)
 {
-	struct btrfs_fs_devices *fs_devices = fs_info->fs_devices;
 	struct btrfs_device *device;
-	u64 zoned_devices = 0;
-	u64 nr_devices = 0;
 	u64 zone_size = 0;
 	u64 max_zone_append_size = 0;
-	const bool incompat_zoned = btrfs_fs_incompat(fs_info, ZONED);
-	int ret = 0;
+	int ret;
 
-	/* Count zoned devices */
-	list_for_each_entry(device, &fs_devices->devices, dev_list) {
-		enum blk_zoned_model model;
+	/*
+	 * Host-Managed devices can't be used without the ZONED flag.  With the
+	 * ZONED all devices can be used, using zone emulation if required.
+	 */
+	if (!btrfs_fs_incompat(fs_info, ZONED))
+		return btrfs_check_for_zoned_device(fs_info);
+
+	list_for_each_entry(device, &fs_info->fs_devices->devices, dev_list) {
+		struct btrfs_zoned_device_info *zone_info = device->zone_info;
 
 		if (!device->bdev)
 			continue;
 
-		model = bdev_zoned_model(device->bdev);
-		/*
-		 * A Host-Managed zoned device must be used as a zoned device.
-		 * A Host-Aware zoned device and a non-zoned devices can be
-		 * treated as a zoned device, if ZONED flag is enabled in the
-		 * superblock.
-		 */
-		if (model == BLK_ZONED_HM ||
-		    (model == BLK_ZONED_HA && incompat_zoned) ||
-		    (model == BLK_ZONED_NONE && incompat_zoned)) {
-			struct btrfs_zoned_device_info *zone_info;
-
-			zone_info = device->zone_info;
-			zoned_devices++;
-			if (!zone_size) {
-				zone_size = zone_info->zone_size;
-			} else if (zone_info->zone_size != zone_size) {
-				btrfs_err(fs_info,
-		"zoned: unequal block device zone sizes: have %llu found %llu",
-					  device->zone_info->zone_size,
-					  zone_size);
-				ret = -EINVAL;
-				goto out;
-			}
-			if (!max_zone_append_size ||
-			    (zone_info->max_zone_append_size &&
-			     zone_info->max_zone_append_size < max_zone_append_size))
-				max_zone_append_size =
-					zone_info->max_zone_append_size;
+		if (!zone_size) {
+			zone_size = zone_info->zone_size;
+		} else if (zone_info->zone_size != zone_size) {
+			btrfs_err(fs_info,
+	"zoned: unequal block device zone sizes: have %llu found %llu",
+				  zone_info->zone_size, zone_size);
+			return -EINVAL;
 		}
-		nr_devices++;
-	}
-
-	if (!zoned_devices && !incompat_zoned)
-		goto out;
-
-	if (!zoned_devices && incompat_zoned) {
-		/* No zoned block device found on ZONED filesystem */
-		btrfs_err(fs_info,
-			  "zoned: no zoned devices found on a zoned filesystem");
-		ret = -EINVAL;
-		goto out;
-	}
-
-	if (zoned_devices && !incompat_zoned) {
-		btrfs_err(fs_info,
-			  "zoned: mode not enabled but zoned device found");
-		ret = -EINVAL;
-		goto out;
-	}
-
-	if (zoned_devices != nr_devices) {
-		btrfs_err(fs_info,
-			  "zoned: cannot mix zoned and regular devices");
-		ret = -EINVAL;
-		goto out;
+		if (!max_zone_append_size ||
+		    (zone_info->max_zone_append_size &&
+		     zone_info->max_zone_append_size < max_zone_append_size))
+			max_zone_append_size = zone_info->max_zone_append_size;
 	}
 
 	/*
@@ -737,14 +711,12 @@ int btrfs_check_zoned_mode(struct btrfs_fs_info *fs_info)
 		btrfs_err(fs_info,
 			  "zoned: zone size %llu not aligned to stripe %u",
 			  zone_size, BTRFS_STRIPE_LEN);
-		ret = -EINVAL;
-		goto out;
+		return -EINVAL;
 	}
 
 	if (btrfs_fs_incompat(fs_info, MIXED_GROUPS)) {
 		btrfs_err(fs_info, "zoned: mixed block groups not supported");
-		ret = -EINVAL;
-		goto out;
+		return -EINVAL;
 	}
 
 	fs_info->zone_size = zone_size;
@@ -760,11 +732,10 @@ int btrfs_check_zoned_mode(struct btrfs_fs_info *fs_info)
 	 */
 	ret = btrfs_check_mountopts_zoned(fs_info);
 	if (ret)
-		goto out;
+		return ret;
 
 	btrfs_info(fs_info, "zoned mode enabled with zone size %llu", zone_size);
-out:
-	return ret;
+	return 0;
 }
 
 int btrfs_check_mountopts_zoned(struct btrfs_fs_info *info)
-- 
2.30.2

