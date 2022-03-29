Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A00E4EA9E4
	for <lists+linux-btrfs@lfdr.de>; Tue, 29 Mar 2022 10:56:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234315AbiC2I6C (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 29 Mar 2022 04:58:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234309AbiC2I6C (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 29 Mar 2022 04:58:02 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCECF190B50
        for <linux-btrfs@vger.kernel.org>; Tue, 29 Mar 2022 01:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1648544179; x=1680080179;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=abTpYunA56gGmpm+Mj2VxzblStbA760aAWX50CRhuL4=;
  b=oW/TRo3JCF50tGyNQ6spfbpBV3BSh1VgWNH50l/9Dwb4PSmv2bO6Ppat
   uH/zNb27MrzvF/yuMOremadSo5Ts8jVeDrp3xz2uYRpGU6yY1y/0VQrl+
   S2g7sWdACp/gjt63MM9qLgVO47LAUQ7dB47JgaOy12nZft4ZVvIDHGMk9
   YC5xyvODaz45+qB4iDbQgCbqYFAs+CCvk6iGOJk89IxobFGexg4xWn6XN
   k86M+8cG/v0fhyzb4eW7X6VmeemAVyZ1piL4Xc+wOk8rgT8Xi+iBiu1Ov
   NipY2LJFq247c/9/+PDG8U1J2MaL/wH4jFDnM9h7eyXlY/VzlnRaVvIz0
   Q==;
X-IronPort-AV: E=Sophos;i="5.90,219,1643644800"; 
   d="scan'208";a="308481658"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 29 Mar 2022 16:56:19 +0800
IronPort-SDR: rpuh3R47uj1SP6ryZOQxp5soYEAjF3ozZM5uozyfj34MUyNpahb2MWPh69UfWTRr95i8sA6dLs
 9+NefCRojS8e+LMrulzCA4ky0ihI4FfCPo7dI09n0DAoUlor6Sf23hFhYvwTXSNXgRE3ceo+t8
 wz9DEYlEIXWyfW9ei187H7+2UqqCa2TqwkDh/Rm3u0GYL6hFDQ5f/L11cP+VYh7YzB0wpyhvLe
 70DP04HzjzE4OWtr8cclN6pFBGFdyG0Zbze0Ciwyk2966zU+F4No8rM/n3BmxaAO/Fu+VH7q4v
 J5MoFksg4wwmFtOM6mb5Cpfm
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Mar 2022 01:28:04 -0700
IronPort-SDR: s/Sn3efMXtzadimZoMMVEyku0x5wvQc3QISRgyzvTgCZmSbb5VhujJtZopwUWD/I+hqRL7dazL
 NAYGUoa+qRLaSm3SKQScsaL5+IaDlDLu06ak7mzhayqPZ0gh1sO6BixU0FJs8CcF+auiNpfIaA
 aXGP6ap/Ey87YkFuqZdcs1C4msulwd+zB2jh4szwaYd2wd97O3H+8YGb82sRPC6VMXbm3fvYbP
 u7jxy3FQH/7N8u3rsbY/uwTIydLAM59fOzyGHm+wqHdgrzQAFoErSrwcVfIyIfDOTkcWeOa3no
 224=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.72])
  by uls-op-cesaip01.wdc.com with ESMTP; 29 Mar 2022 01:56:19 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.cz>
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Pankaj Raghav <p.raghav@samsung.com>,
        "linux-btrfs @ vger . kernel . org" <linux-btrfs@vger.kernel.org>
Subject: [PATCH v2 4/4] btrfs: zoned: make auto-reclaim less aggressive
Date:   Tue, 29 Mar 2022 01:56:09 -0700
Message-Id: <c69adfe62944e32a0d2e37b25c34cd49edc15f43.1648543951.git.johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1648543951.git.johannes.thumshirn@wdc.com>
References: <cover.1648543951.git.johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The current auto-reclaim algorithm starts reclaiming all block-group's
with a zone_unusable value above a configured threshold. This is causing a
lot of reclaim IO even if there would be enough free zones on the device.

Instead of only accounting a block-group's zone_unusable value, also take
the ratio of free and not usable (written as well as zone_unusable) bytes
a device has into account.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/block-group.c | 10 ++++++++++
 fs/btrfs/zoned.c       | 28 ++++++++++++++++++++++++++++
 fs/btrfs/zoned.h       |  6 ++++++
 3 files changed, 44 insertions(+)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 628741ecb97b..12454304bb85 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -1512,6 +1512,13 @@ static int reclaim_bgs_cmp(void *unused, const struct list_head *a,
 	return bg1->used > bg2->used;
 }
 
+static inline bool btrfs_should_reclaim(struct btrfs_fs_info *fs_info)
+{
+	if (btrfs_is_zoned(fs_info))
+		return btrfs_zoned_should_reclaim(fs_info);
+	return true;
+}
+
 void btrfs_reclaim_bgs_work(struct work_struct *work)
 {
 	struct btrfs_fs_info *fs_info =
@@ -1522,6 +1529,9 @@ void btrfs_reclaim_bgs_work(struct work_struct *work)
 	if (!test_bit(BTRFS_FS_OPEN, &fs_info->flags))
 		return;
 
+	if (!btrfs_should_reclaim(fs_info))
+		return;
+
 	sb_start_write(fs_info->sb);
 
 	if (!btrfs_exclop_start(fs_info, BTRFS_EXCLOP_BALANCE)) {
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 1b1b310c3c51..c0c460749b74 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -2079,3 +2079,31 @@ void btrfs_free_zone_cache(struct btrfs_fs_info *fs_info)
 	}
 	mutex_unlock(&fs_devices->device_list_mutex);
 }
+
+bool btrfs_zoned_should_reclaim(struct btrfs_fs_info *fs_info)
+{
+	struct btrfs_fs_devices *fs_devices = fs_info->fs_devices;
+	struct btrfs_device *device;
+	u64 used = 0;
+	u64 total = 0;
+	u64 factor;
+
+	ASSERT(btrfs_is_zoned(fs_info));
+
+	if (!fs_info->bg_reclaim_threshold)
+		return false;
+
+	mutex_lock(&fs_devices->device_list_mutex);
+	list_for_each_entry(device, &fs_devices->devices, dev_list) {
+		if (!device->bdev)
+			continue;
+
+		total += device->disk_total_bytes;
+		used += device->bytes_used;
+
+	}
+	mutex_unlock(&fs_devices->device_list_mutex);
+
+	factor = div64_u64(used * 100, total);
+	return factor >= fs_info->bg_reclaim_threshold;
+}
diff --git a/fs/btrfs/zoned.h b/fs/btrfs/zoned.h
index c489c08d7fd5..f2d16395087f 100644
--- a/fs/btrfs/zoned.h
+++ b/fs/btrfs/zoned.h
@@ -74,6 +74,7 @@ void btrfs_zone_finish_endio(struct btrfs_fs_info *fs_info, u64 logical,
 			     u64 length);
 void btrfs_clear_data_reloc_bg(struct btrfs_block_group *bg);
 void btrfs_free_zone_cache(struct btrfs_fs_info *fs_info);
+bool btrfs_zoned_should_reclaim(struct btrfs_fs_info *fs_info);
 #else /* CONFIG_BLK_DEV_ZONED */
 static inline int btrfs_get_dev_zone(struct btrfs_device *device, u64 pos,
 				     struct blk_zone *zone)
@@ -232,6 +233,11 @@ static inline void btrfs_zone_finish_endio(struct btrfs_fs_info *fs_info,
 static inline void btrfs_clear_data_reloc_bg(struct btrfs_block_group *bg) { }
 
 static inline void btrfs_free_zone_cache(struct btrfs_fs_info *fs_info) { }
+
+static inline bool btrfs_zoned_should_reclaim(struct btrfs_fs_info *fs_info)
+{
+	return false;
+}
 #endif
 
 static inline bool btrfs_dev_is_sequential(struct btrfs_device *device, u64 pos)
-- 
2.35.1

