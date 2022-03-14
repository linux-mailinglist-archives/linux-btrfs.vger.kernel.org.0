Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7374F4D87C0
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Mar 2022 16:08:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235568AbiCNPKF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 14 Mar 2022 11:10:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233706AbiCNPKE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 14 Mar 2022 11:10:04 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E30AD3D4A6
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Mar 2022 08:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1647270532; x=1678806532;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=qXnkv1/bOfshruGExAcbaR9XUb+8bOtHvDD0uk7bQ+0=;
  b=KpEFnexsnWz9bYxrpathw3Lj5/RTZ1pSGSZ1ikt38ouSVLIpmR2hejpu
   V/Dp5eKmgJhUjGxX1ZsBm/tUotRZ20YUN/tRsnPTUHKJfKcFW8QHhrT5F
   Y8clowj9upDmMbou++vmskGeiXqEWjyAs3yjktr3+qzbnYcEqxf9vqYFi
   6Db/Ho3KwlXqp4PboGrQ3hMkL+GWk3mjxdgW80s5dv7A2ylHrq1cOJqnH
   MyfGOR3M3cNy4ya2qly+mjQU6YYjjFPNG8R16jj2aGSuVLReF3EM0X6Du
   suRu1vhOIYYc08c5UkRCpJM32JB1ngy4qnoEd6jUAw/5NIGxP1HoT8D9B
   A==;
X-IronPort-AV: E=Sophos;i="5.90,181,1643644800"; 
   d="scan'208";a="299460509"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 14 Mar 2022 23:08:52 +0800
IronPort-SDR: JEkQ/iKEGZgEPpseBSh5kzecuD8tt1z3z9KGlwmjzZonNRqvjiquvKNnsg9JtVTiWatT/+7AWY
 JZOalE2OutyL0ZtQ4iFZD4eCUoPvrXbcN/3dxTjjn/+7i+2eelbabuo9ryWSwS1QeO5TJ3r+mZ
 v5IDY5iyOGIbJT84/vFwEUMLQm81R7Nhk5Pzi3W1TXlq+QZoP5hlU2NQ1yGA8crGZY1Kv6E5L7
 rhIIz/wP52kjCKWaYgjTgdZRiCfDiz35mIgFRNVeVwTfaLfmjIgy+I3HHYi4D2D1/cOKdBrgXU
 4WdJ7GOAqSLE8uFw7ZCnCfc2
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2022 07:40:00 -0700
IronPort-SDR: BsDFA0TxY6SBmHKjtXPWVu5+YFyGSJCc5VQRhzPctXnDT+HrLyr1i5e9pDJihBIM1wXdoVJY4X
 76yYfe7hq84fINP5CfCZdFtacmyxc5IH5Pj60IuzGwbdZXDxYqTzpuAwMafM5BKHIm89oeWIAr
 z4BH9PPo3hj626AdEBR7VzkRw7SuUkTe4rxylFhyhsXAuhm7CcphWk65Oc3yig2o5BpKxXqsiv
 Yv7X8Df85SMCdgtHW3wo44oBJ1l8tEPUW00De4LO9DmNRBYvK8yJj3Bao1KQk9Y2Tmm8PcVpVs
 iGw=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.72])
  by uls-op-cesaip02.wdc.com with ESMTP; 14 Mar 2022 08:08:51 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.com>
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org
Subject: [PATCH v2] btrfs: zoned: make auto-reclaim less aggressive
Date:   Mon, 14 Mar 2022 08:08:49 -0700
Message-Id: <d4e31fe56800bdc3bd8ed9230c6a5629ee555cd5.1647268601.git.johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.35.1
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
the number of empty zones into account.

Cc: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

---
Changes since RFC:
* Fix logic error
* Skip unavailable devices
* Use different metric working for non-zoned devices as well
---
 fs/btrfs/block-group.c |  3 +++
 fs/btrfs/zoned.c       | 30 ++++++++++++++++++++++++++++++
 fs/btrfs/zoned.h       |  6 ++++++
 3 files changed, 39 insertions(+)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index c22d287e020b..2e77b38c538b 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -1522,6 +1522,9 @@ void btrfs_reclaim_bgs_work(struct work_struct *work)
 	if (!test_bit(BTRFS_FS_OPEN, &fs_info->flags))
 		return;
 
+	if (!btrfs_zoned_should_reclaim(fs_info))
+		return;
+
 	sb_start_write(fs_info->sb);
 
 	if (!btrfs_exclop_start(fs_info, BTRFS_EXCLOP_BALANCE)) {
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 49446bb5a5d1..e60fa3c9be7c 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -15,6 +15,7 @@
 #include "transaction.h"
 #include "dev-replace.h"
 #include "space-info.h"
+#include "misc.h"
 
 /* Maximum number of zones to report per blkdev_report_zones() call */
 #define BTRFS_REPORT_NR_ZONES   4096
@@ -2078,3 +2079,32 @@ void btrfs_free_zone_cache(struct btrfs_fs_info *fs_info)
 	}
 	mutex_unlock(&fs_devices->device_list_mutex);
 }
+
+bool btrfs_zoned_should_reclaim(struct btrfs_fs_info *fs_info)
+{
+	struct btrfs_fs_devices *fs_devices = fs_info->fs_devices;
+	struct btrfs_device *device;
+	u64 bytes_used = 0;
+	u64 total_bytes = 0;
+	u64 factor;
+
+	if (!btrfs_is_zoned(fs_info))
+		return false;
+
+	if (!fs_info->bg_reclaim_threshold)
+		return false;
+
+	mutex_lock(&fs_devices->device_list_mutex);
+	list_for_each_entry(device, &fs_devices->devices, dev_list) {
+		if (!device->bdev)
+			continue;
+
+		total_bytes += device->disk_total_bytes;
+		bytes_used += device->bytes_used;
+
+	}
+	mutex_unlock(&fs_devices->device_list_mutex);
+
+	factor = (bytes_used * 100) / total_bytes;
+	return factor >= fs_info->bg_reclaim_threshold;
+}
diff --git a/fs/btrfs/zoned.h b/fs/btrfs/zoned.h
index cbf016a7bb5d..d0d0e5c02606 100644
--- a/fs/btrfs/zoned.h
+++ b/fs/btrfs/zoned.h
@@ -78,6 +78,7 @@ void btrfs_zone_finish_endio(struct btrfs_fs_info *fs_info, u64 logical,
 			     u64 length);
 void btrfs_clear_data_reloc_bg(struct btrfs_block_group *bg);
 void btrfs_free_zone_cache(struct btrfs_fs_info *fs_info);
+bool btrfs_zoned_should_reclaim(struct btrfs_fs_info *fs_info);
 #else /* CONFIG_BLK_DEV_ZONED */
 static inline int btrfs_get_dev_zone(struct btrfs_device *device, u64 pos,
 				     struct blk_zone *zone)
@@ -236,6 +237,11 @@ static inline void btrfs_zone_finish_endio(struct btrfs_fs_info *fs_info,
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

