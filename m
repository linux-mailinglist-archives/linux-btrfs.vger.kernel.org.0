Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCE474D99E1
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Mar 2022 12:03:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347217AbiCOLEU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 15 Mar 2022 07:04:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240764AbiCOLES (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Mar 2022 07:04:18 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EE31E47
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Mar 2022 04:03:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1647342183; x=1678878183;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Wn7cDQqXDVhfNSBXtYJozuVp5L8dOjJox2MAhI3hXSs=;
  b=rdW+aCMMVYz7Jh1+pLg/4vsGlLh862JlrODifpAWjTLR5mSK4/VboG4K
   ny2A+oQuN9rNZ/1+HegB5eTnGIlpqYdtNBWB/FYlf1ji4gcnG3090GN0M
   olSnHzWnD1HkimojFzEmhHqFY+eZpRWUGy8vjF6HLYC2DC04WJorQjzRs
   BULCtTyl1rzm5CVCTYaYk20wgYGcBH8oHQOpvAWiBtSqSuGzXd4SQ4oGJ
   tdx6OWz/0vIZigopaQjw0jjHraOQtR6z5vbOIAVhuDDjyP1Dv5qx0mOD6
   DP+IiiqIg9H3vLFPU3voNESwIVZXhtDcSqEGpa0+3lgPUvFpjzZpXgIJ3
   A==;
X-IronPort-AV: E=Sophos;i="5.90,183,1643644800"; 
   d="scan'208";a="200242221"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 15 Mar 2022 19:03:01 +0800
IronPort-SDR: m1BCkJqfidCqHI/nHkpgiLNKRsHjOlNAnsDlJFDvNyW89tePUxQ7KUTb3pSX+Ix9X9BsGdgOqN
 +8bRifIDrF5jqddjYrHl6k8/hNanKZlFaZ8b3gMTqGu0nHpi85rFqu11YqW9Ynqt7SDiX4p0yX
 OqpvoQbXhKwCrwB/m4zVCy3AZPaDR5OtxtJyghcNeJZiaFk+A//hasYWGBLhgVKFVRvCCIELnX
 7AMtiGR0pnLRm/MJifIMSwJ3O1t3DSJWS3MLXu62k8zGh9bQfoExNtV/3nOJa2lv/2/x/wXRhU
 jPboMKReEaw8J+kRbmhjdStB
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2022 03:34:09 -0700
IronPort-SDR: Yywa4vfNx1vjJgG1+XQcT4D5sTNVdqdBQSRpGMo15BpPH/hTZ1y10p/LiIkuVqo6yEVrWAAAGD
 DVEs52u1BVvpkaWcaaFVe16WHeEGNwwE1zi8F/Sh7juHX2JIPtk6UX2PDU5/MLpE+ETysGFjoF
 8r1lAwDQ23LbaozmEqSQOBebYrm09ZV6s/BPAu4s1+dfqgtxihmyFd/64O2aka7JEgy/spdIgd
 URjiry62Y2VGTtUphhissknxuxX+b+PuoA3+nXAffhQc15A9HvBos74Tri0F/ALe+uRMyf0dWs
 /Dk=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.72])
  by uls-op-cesaip01.wdc.com with ESMTP; 15 Mar 2022 04:03:01 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.com>
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org
Subject: [PATCH v3] btrfs: zoned: make auto-reclaim less aggressive
Date:   Tue, 15 Mar 2022 04:02:57 -0700
Message-Id: <74cbd8cdefe76136b3f9fb9b96bddfcbcd5b5861.1647342146.git.johannes.thumshirn@wdc.com>
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
Changes since v4:
* Use div_u64()

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
index 49446bb5a5d1..dc62a14594de 100644
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
+	factor = div_u64(bytes_used * 100, total_bytes);
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

