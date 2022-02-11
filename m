Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D5AE4B2773
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Feb 2022 14:55:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350682AbiBKNyL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 11 Feb 2022 08:54:11 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350681AbiBKNyL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 11 Feb 2022 08:54:11 -0500
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16B2B198
        for <linux-btrfs@vger.kernel.org>; Fri, 11 Feb 2022 05:54:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1644587648; x=1676123648;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=4pThJivJ6bqqgnB4rt2+93D4IOLMtdSVsyJKY4m1jXw=;
  b=Nv50AsV3dWilRE37M2EVOteaeL4RJIIafrLjov/iMtUvlWV7DfC7RiFQ
   NtjrMQ0YlC3t9PBzo88CRITSAL52oB7k4sQ2xMZ988Qp0GAEwrnjwbiNO
   vZmJ4KuPgInWJAx05VctsfVY7eIqNtE8yPoEAMZvuo4TpEvCr+RUOtRqq
   9pYT0KP3TBODhWCAM++XKM3/CPQ9R5o1KZ6XUPKO54hm1lHr6FaOtXya2
   P1afQ81yLdc0ir70t5laBXeJ5JMuiiaRKNiK2dti+wGMQmY4tYwS8vydD
   ImOFlcb+st88SiZ3bg9eZAh++Eq3m1is1FClb327eyVSxDVDiF09Gdnjr
   w==;
X-IronPort-AV: E=Sophos;i="5.88,361,1635177600"; 
   d="scan'208";a="197518052"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 11 Feb 2022 21:54:08 +0800
IronPort-SDR: pJwX38rmRnqirb21XJxk22DW/xOPR62/vn+jMoK5apjoTzY27aW+QvSC0IGvwJPe5MLWaUEZe0
 lJoP4jvbdQ9ma5LYqjRSrW8HBm7bUPexADWBmKrGoIH3NKorZnCeLk0YSwPbJpyp6o2g/oFDK2
 6z4IkOzS/rh7t9uMzWSRjYdzjsWr7kcjOL7SaIsSo/YW6fyRMVJII2NyqyHT6+IC7TBhIGNEAG
 Fc2R/Vam+Fzi5s4ubpO+nOA7tADQg/lN4MEslkhw/VlZMwHsAFT6CQJqbKvThVYlbC6awJoDzM
 jUukWg3xyqiRt2pP+/Vac+1T
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2022 05:25:55 -0800
IronPort-SDR: 7bRznoD9OvvffPBLNf6N4ZRX7WN1eoGMIIvzeVDlYkqF+WQt76XqLhc6j81DiZfPiXdrW0tvrb
 TLXmc12EyA9hW3zzHKDERFqMMvPlVS6crqkz1lW2zTS46At0UlU942+yz2DZSkGumbcnsMCNkf
 xouoKFfMbraMTbfUnxdRB6mZUlKmzZ5UEUQSEGs6fYVnVbI28KJW5TT9oU6b3VS1QNXfNexQgy
 JGxgXI/hbrR79RoKxKHIGbaP/9WZcWx+hXhTWtsgedfdW1g6JVsehpGojIkF5A7Ls+HSU+C/71
 srM=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.72])
  by uls-op-cesaip02.wdc.com with ESMTP; 11 Feb 2022 05:54:10 -0800
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.com>
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        linux-btrfs@vger.kernel.org,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH RFC] btrfs: zoned: make auto-reclaim less aggressive
Date:   Fri, 11 Feb 2022 05:54:02 -0800
Message-Id: <6e2f241b0f43111efd6fe42d736a90275bb985a9.1644587521.git.johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.34.1
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

RFC because I'm a bit unsure about the user interface. Should we use the
same value / sysfs file for both the number of non-empty zones and the
number of zone_unusable bytes per block_group or add another knob to fine
tune?

 fs/btrfs/block-group.c |  3 +++
 fs/btrfs/zoned.c       | 29 +++++++++++++++++++++++++++++
 fs/btrfs/zoned.h       |  6 ++++++
 3 files changed, 38 insertions(+)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 3113f6d7f335..c0f38f486deb 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -1522,6 +1522,9 @@ void btrfs_reclaim_bgs_work(struct work_struct *work)
 	if (!test_bit(BTRFS_FS_OPEN, &fs_info->flags))
 		return;
 
+	if (!btrfs_zoned_should_reclaim(fs_info))
+		return;
+
 	if (!btrfs_exclop_start(fs_info, BTRFS_EXCLOP_BALANCE))
 		return;
 
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index b7b5fac1c779..47204f38f02e 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -15,6 +15,7 @@
 #include "transaction.h"
 #include "dev-replace.h"
 #include "space-info.h"
+#include "misc.h"
 
 /* Maximum number of zones to report per blkdev_report_zones() call */
 #define BTRFS_REPORT_NR_ZONES   4096
@@ -2082,3 +2083,31 @@ void btrfs_free_zone_cache(struct btrfs_fs_info *fs_info)
 	}
 	mutex_unlock(&fs_devices->device_list_mutex);
 }
+
+bool btrfs_zoned_should_reclaim(struct btrfs_fs_info *fs_info)
+{
+	struct btrfs_fs_devices *fs_devices = fs_info->fs_devices;
+	struct btrfs_device *device;
+	u64 nr_free = 0;
+	u64 nr_zones = 0;
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
+		struct btrfs_zoned_device_info *zone_info = device->zone_info;
+
+		nr_zones += zone_info->nr_zones;
+		nr_free += bitmap_weight(zone_info->empty_zones,
+					 zone_info->nr_zones);
+	}
+	mutex_unlock(&fs_devices->device_list_mutex);
+
+	factor = div_factor_fine(nr_free, nr_zones);
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
2.34.1
