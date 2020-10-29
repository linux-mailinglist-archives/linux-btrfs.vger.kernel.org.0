Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6568929E4BB
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Oct 2020 08:47:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731303AbgJ2HqM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 29 Oct 2020 03:46:12 -0400
Received: from out20-61.mail.aliyun.com ([115.124.20.61]:44541 "EHLO
        out20-61.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733208AbgJ2HqI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 29 Oct 2020 03:46:08 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.05600743|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.0726242-0.000948886-0.926427;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047190;MF=wangyugui@e16-tech.com;NM=1;PH=DS;RN=3;RT=3;SR=0;TI=SMTPD_---.IptkHuJ_1603949757;
Received: from T640.e16-tech.com(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.IptkHuJ_1603949757)
          by smtp.aliyun-inc.com(10.147.42.241);
          Thu, 29 Oct 2020 13:35:58 +0800
From:   wangyugui <wangyugui@e16-tech.com>
To:     linux-btrfs@vger.kernel.org
Cc:     kreijack@libero.it, wangyugui <wangyugui@e16-tech.com>
Subject: [PATCH 1/4] btrfs: add tier score to device
Date:   Thu, 29 Oct 2020 13:35:53 +0800
Message-Id: <20201029053556.10619-2-wangyugui@e16-tech.com>
X-Mailer: git-send-email 2.29.1
In-Reply-To: <20201029053556.10619-1-wangyugui@e16-tech.com>
References: <20201029053556.10619-1-wangyugui@e16-tech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We use a single score value to define the tier level of a device.
Different score means different tier, and bigger is faster.
    DAX device(dax=1)
    SSD device(rotational=0)
    HDD device(rotational=1)
TODO/FIXME: FIXME: detect bus(DIMM, NVMe, SCSI, SATA, Virtio, ...)
TODO/FIXME: user-assigned property(refactoring the coming 'read_preferred' property?) to
            set to the max score for some not-well-supported case.

In most case, only 1 or 2 tiers are used at the same time, so we group them into
top tier and other tier(s).

Signed-off-by: wangyugui <wangyugui@e16-tech.com>
---
 fs/btrfs/volumes.c | 18 ++++++++++++++++++
 fs/btrfs/volumes.h |  5 +++++
 2 files changed, 23 insertions(+)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 58b9c41..efffcbc 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -608,6 +608,22 @@ static int btrfs_free_stale_devices(const char *path,
 	return ret;
 }
 
+/*
+ * Get the tier score to the device, bigger score is faster.
+ * FIXME: detect bus(DIMM, NVMe, SCSI, SATA, Virtio, ...)
+ * FIXME: detect media inside(SLC/MLC of SSD, SMR/PMR of HDD, ...)
+ * FIXME: user-assigned property to set to max score for some complex case.
+ */
+static void dev_get_tier_score(struct btrfs_device *device, struct request_queue *q)
+{
+	if (blk_queue_dax(q))
+		device->tier_score = 50;
+	else if (blk_queue_nonrot(q))
+		device->tier_score = 10;
+	else
+		device->tier_score = 0;
+}
+
 /*
  * This is only used on mount, and we are protected from competing things
  * messing with our fs_devices by the uuid_mutex, thus we do not need the
@@ -660,6 +676,7 @@ static int btrfs_open_one_device(struct btrfs_fs_devices *fs_devices,
 	}
 
 	q = bdev_get_queue(bdev);
+	dev_get_tier_score(device,q);
 	if (!blk_queue_nonrot(q))
 		fs_devices->rotating = true;
 
@@ -2590,6 +2607,7 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
 
 	atomic64_add(device->total_bytes, &fs_info->free_chunk_space);
 
+	dev_get_tier_score(device,q);
 	if (!blk_queue_nonrot(q))
 		fs_devices->rotating = true;
 
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index bf27ac0..cf426ec 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -138,6 +138,11 @@ struct btrfs_device {
 	struct completion kobj_unregister;
 	/* For sysfs/FSID/devinfo/devid/ */
 	struct kobject devid_kobj;
+
+	/* Storage tier score, bigger score is faster.
+	 * In most case, only 1 or 2 tiers are used at the same time, so we group them
+	 * into top tier and other tier(s). */
+	u8 tier_score;
 };
 
 /*
-- 
2.29.1

