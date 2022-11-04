Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D43B96198EE
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Nov 2022 15:13:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230209AbiKDONW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 4 Nov 2022 10:13:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231691AbiKDONB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 4 Nov 2022 10:13:01 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69E0F2E6A2
        for <linux-btrfs@vger.kernel.org>; Fri,  4 Nov 2022 07:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1667571164; x=1699107164;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EbrA/PqgnUxN69c51DmxsQW6XE1awFW5WeMEFweI3cM=;
  b=peLUcnxKXsXh7wmGTnFtYokHHkvcm9GI9WNntusbHJXIOWYC2boMF+vP
   J4jHayJUxC8ik7H5vFrZ7joNnv0sO8bObQuq5T0tajlB+hZvK4H19kLV+
   awfTRnibQX4nSqYClOmNuqBK4hE4HUfOHFTW0Sm9Qv1r4Ma2I23xittyQ
   lZPMl2eSOfXtz0ngQB5RzpOSRQGf3Cgt8zZnSKuCI2dZ4kJst1yco9uEI
   H4CKzEKzmWPN/4jEn911Ml8sSUVLBbEgP8T5+JGqlKWNBoXd8I4Yv8HWo
   Trj61cT3KMKlwW98OIoCqqaVz8UlcWTf2yL0OLxd2O4dQZwIGZZBhjXOZ
   g==;
X-IronPort-AV: E=Sophos;i="5.96,137,1665417600"; 
   d="scan'208";a="327603635"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 04 Nov 2022 22:12:43 +0800
IronPort-SDR: comKqZUXubjSp1ala+OoqTmoFRsLMrK7obriYTv1eu90QLIH7lETfJccKyl1kssJJl+S0Hw8P1
 qzF08p3Rlr9UZk2H1ZqovqhJoaJt8NXbQB8TJnAE+xuVo/mkqddK5KGjc0a/uV6mnFpN5F0oVG
 GMD1N4UqHCymd2GcTGaKUqi/GPzWCUsZTLcuehN66SvvKaetIuecGvssFgkTzFD3BT/JNffasE
 6UNcRLPqNisUjMZubhCM5dfrGiIw3M6pMzXRo/eFNjv1Q7wsiY/m0TfjCbF6SaULRXRw5s9nIe
 kjQ=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Nov 2022 06:31:54 -0700
IronPort-SDR: K+/K5f1MhmJMCxLbFl+0kq4uyDcXl1X2iH3WUAMquvGD123utdEbaltnB7/GgMO+tVKOovg3fB
 9jViqz0SE09RBljp9cEEiNb2G/TmyHQTLy3T38ulZWVDg491e/RJvVwp9K/v6pyTKQ/u2cMVie
 B1baQWcFJS+D8Dz9bzddMOVc/WWrLBe7BlZUnGyFWtt/zGlmeChTtj79YxUD0gK+FroJYVHVPJ
 Y3DRsF6XjtFglV/9RdtQOiQS2uzDBoL3YMnPZ+LC7qlHAWahP8cHQERC5EMfoL8796bbut5pHr
 O6Q=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.72])
  by uls-op-cesaip02.wdc.com with ESMTP; 04 Nov 2022 07:12:43 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.cz>
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        linux-btrfs@vger.kernel.org, Naohiro Aota <Naohiro.Aota@wdc.com>
Subject: [PATCH 1/3] btrfs: zoned: clone zoned device info when cloning a device
Date:   Fri,  4 Nov 2022 07:12:33 -0700
Message-Id: <af4caecf1d6fac27654cfd47b72eea865cdcbf61.1667571005.git.johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <cover.1667571005.git.johannes.thumshirn@wdc.com>
References: <cover.1667571005.git.johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

When cloning a btrfs_device, we're not cloning the associated
btrfs_zoned_device_info structure of the device in case of a zoned
filesystem.

This then later leads to a nullptr dereference when accessing the device's
zone_info for instance when setting a zone as active.

This was uncovered by fstests' testcase btrfs/161.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/volumes.c | 12 ++++++++++++
 fs/btrfs/zoned.c   | 42 ++++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/zoned.h   | 10 ++++++++++
 3 files changed, 64 insertions(+)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index f81aa7f9ef19..f72ce52c67ce 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -1021,6 +1021,18 @@ static struct btrfs_fs_devices *clone_fs_devices(struct btrfs_fs_devices *orig)
 			rcu_assign_pointer(device->name, name);
 		}
 
+		if (orig_dev->zone_info) {
+			struct btrfs_zoned_device_info *zone_info;
+
+			zone_info = btrfs_clone_dev_zone_info(orig_dev);
+			if (!zone_info) {
+				btrfs_free_device(device);
+				ret = -ENOMEM;
+				goto error;
+			}
+			device->zone_info = zone_info;
+		}
+
 		list_add(&device->dev_list, &fs_devices->devices);
 		device->fs_devices = fs_devices;
 		fs_devices->num_devices++;
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 9d12a23e1a59..f830f70fc214 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -641,6 +641,48 @@ void btrfs_destroy_dev_zone_info(struct btrfs_device *device)
 	device->zone_info = NULL;
 }
 
+struct btrfs_zoned_device_info *btrfs_clone_dev_zone_info(struct btrfs_device *orig_dev)
+{
+	struct btrfs_zoned_device_info *zone_info;
+
+	zone_info = kmemdup(orig_dev->zone_info,
+			    sizeof(*zone_info), GFP_KERNEL);
+	if (!zone_info)
+		return NULL;
+
+
+	zone_info->seq_zones = bitmap_zalloc(zone_info->nr_zones, GFP_KERNEL);
+	if (!zone_info->seq_zones)
+		goto out;
+
+	bitmap_copy(zone_info->seq_zones, orig_dev->zone_info->seq_zones,
+		    zone_info->nr_zones);
+
+	zone_info->empty_zones = bitmap_zalloc(zone_info->nr_zones, GFP_KERNEL);
+	if (!zone_info->empty_zones)
+		goto out;
+
+	bitmap_copy(zone_info->empty_zones, orig_dev->zone_info->empty_zones,
+		    zone_info->nr_zones);
+
+	zone_info->active_zones = bitmap_zalloc(zone_info->nr_zones, GFP_KERNEL);
+	if (!zone_info->active_zones)
+		goto out;
+
+	bitmap_copy(zone_info->active_zones, orig_dev->zone_info->active_zones,
+		    zone_info->nr_zones);
+	zone_info->zone_cache = NULL;
+
+	return zone_info;
+
+out:
+	bitmap_free(zone_info->seq_zones);
+	bitmap_free(zone_info->empty_zones);
+	bitmap_free(zone_info->active_zones);
+	kfree(zone_info);
+	return NULL;
+}
+
 int btrfs_get_dev_zone(struct btrfs_device *device, u64 pos,
 		       struct blk_zone *zone)
 {
diff --git a/fs/btrfs/zoned.h b/fs/btrfs/zoned.h
index 8d7e6be853c6..69fb1af89a53 100644
--- a/fs/btrfs/zoned.h
+++ b/fs/btrfs/zoned.h
@@ -37,6 +37,7 @@ int btrfs_get_dev_zone(struct btrfs_device *device, u64 pos,
 int btrfs_get_dev_zone_info_all_devices(struct btrfs_fs_info *fs_info);
 int btrfs_get_dev_zone_info(struct btrfs_device *device, bool populate_cache);
 void btrfs_destroy_dev_zone_info(struct btrfs_device *device);
+struct btrfs_zoned_device_info *btrfs_clone_dev_zone_info(struct btrfs_device *orig_dev);
 int btrfs_check_zoned_mode(struct btrfs_fs_info *fs_info);
 int btrfs_check_mountopts_zoned(struct btrfs_fs_info *info);
 int btrfs_sb_log_location_bdev(struct block_device *bdev, int mirror, int rw,
@@ -104,6 +105,15 @@ static inline int btrfs_get_dev_zone_info(struct btrfs_device *device,
 
 static inline void btrfs_destroy_dev_zone_info(struct btrfs_device *device) { }
 
+/* In case the kernel is compiled without CONFIG_BLK_DEV_ZONED we'll never
+ * call into btrfs_clone_dev_zone_info() so it's save to return NULL here.
+ */
+static inline struct btrfs_zoned_device_info *btrfs_clone_dev_zone_info(
+						 struct btrfs_device *orig_dev)
+{
+	return NULL;
+}
+
 static inline int btrfs_check_zoned_mode(const struct btrfs_fs_info *fs_info)
 {
 	if (!btrfs_is_zoned(fs_info))
-- 
2.37.3

