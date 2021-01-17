Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C9F52F94C7
	for <lists+linux-btrfs@lfdr.de>; Sun, 17 Jan 2021 20:03:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729182AbhAQTCi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 17 Jan 2021 14:02:38 -0500
Received: from smtp-36-i2.italiaonline.it ([213.209.12.36]:60579 "EHLO
        libero.it" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729570AbhAQTCb (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 17 Jan 2021 14:02:31 -0500
X-Greylist: delayed 401 seconds by postgrey-1.27 at vger.kernel.org; Sun, 17 Jan 2021 14:02:29 EST
Received: from venice.bhome ([94.37.172.193])
        by smtp-36.iol.local with ESMTPA
        id 1DCAlJgx8i3tS1DCBlXz6K; Sun, 17 Jan 2021 19:54:39 +0100
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2014;
        t=1610909679; bh=HRLvrp+RVHsIZGcj8Zr894mn4yg4p1oILWjB6reKLZM=;
        h=From;
        b=ual8YctovRrGnRjtaoQJTNlNEKTVoDEUSDVD9uPSJU9m42re0p3futyXLifGtM/IM
         FirWKGFpRWpyx7GJjRJFiFw2JGZlefALqdWg7MaQmAvZQ18Gke/K9n/QveyxmHrwoN
         UvLlkaJXZEgyNgcsZU2fIJQPSLVnBpbjJuEkqpPK8cZ9Be/V9zwq8LPVWbSNVMZCbG
         H5r3OBPYJVpCh52+UH53aVZMnx3rv/QMx5Kg7jkllQiWTlFqbsLG2O0n83WmdV+xd2
         PU7TH4vHR1bYO6q7patOwiiB0UTzFog/wMP1c/PhHMqID+eC1/uYgZackWtpCb1mlI
         0c1kgwFhV/BcQ==
X-CNFS-Analysis: v=2.4 cv=FqfAQ0nq c=1 sm=1 tr=0 ts=600487ef cx=a_exe
 a=z1y4hvBwYU35dpVEhKc0WA==:117 a=z1y4hvBwYU35dpVEhKc0WA==:17
 a=8PO0FKY24m408z_zBhMA:9
From:   Goffredo Baroncelli <kreijack@libero.it>
To:     linux-btrfs@vger.kernel.org
Cc:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        Goffredo Baroncelli <kreijack@inwind.it>
Subject: [PATCH 5/5] btrfs: add preferred_metadata mode mount option
Date:   Sun, 17 Jan 2021 19:54:35 +0100
Message-Id: <20210117185435.36263-6-kreijack@libero.it>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210117185435.36263-1-kreijack@libero.it>
References: <20210117185435.36263-1-kreijack@libero.it>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfOxzuVv6vOXgl1ERwkvz25hNFma0tmqiJOJr+/xS5vrd73p/7znYVfwyKiU+45TTBalP2nklPUvb7qERVXTNoZ4RIFkXVsAxDraVVFsUIfmIsIg80kHv
 6Tw1FTjXmWsxRLfDRnBf4cE+ZtOcJHDL2c0AalQVZE6+UgoVlzcBSwcptHRso/uQOpIB/txy7VJ/YjBo7j5nlZZt19mBTR4O/zdc2GrvScFM+YEp9AohtyxV
 odulQW5GVb9RhdC1W6vzFXQ/rrYEO/lMKDzeg2Af7f0=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Goffredo Baroncelli <kreijack@inwind.it>

When this mode is enabled, the chunk allocation policy is modified
giving a different precedence between the disks depending by the chunk type.
A disk may be marked with the preferred_metadata flag to have higher chance
to host metadata.

There are 4 modes:
- preferred_metadata=disabled
  The allocator is the standard one.

- preferred_metadata=soft
  The metadata chunk are allocated on the disks marked with the
  "preferred_metadata" flag.
  The data chunk are allocated on the disks not marked with the
  "preferred_metadata" flag.
  If the space isn't enough, then it is possible to use the other kind
  of disks.

- preferred_metadata=hard
  The metadata chunk are allocated on the disks marked with the
  "preferred_metadata" flag.
  The data chunk are allocated on the disks not marked with the
  "preferred_metadata" flag.
  If the space isn't enough, then "no space left" error is raised. It
  is not possible to use the other kind of disks.

- preferred_metadata=metadata
  The metadata chunk are allocated on the disks marked with the
  "preferred_metadata" flag.
  For metadata, if the space isn't enough, then it is possible to use the
  other kind of disks.
  The data chunk are allocated on the disks not marked with the
  "preferred_metadata" flag.
  For data, if the space isn't enough, then "no space left" error is raised.
  It is not possible to use the other kind of disks.

To mark a disk as "preferred_metadata", use the command
# btrfs properties set <disk> preferred_metadata 1

To remove the flag "preferred_metadata" from a disk, use the command
# btrfs properties set <disk> preferred_metadata 0

Signed-off-by: Goffredo Baroncelli <kreijack@inwind.it>
---
 fs/btrfs/volumes.c | 105 ++++++++++++++++++++++++++++++++++++++++++++-
 fs/btrfs/volumes.h |   1 +
 2 files changed, 104 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 68b346c5465d..9dc3f2473805 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -4824,6 +4824,56 @@ static int btrfs_cmp_device_info(const void *a, const void *b)
 	return 0;
 }
 
+/*
+ * sort the devices in descending order by preferred_metadata,
+ * max_avail, total_avail
+ */
+static int btrfs_cmp_device_info_metadata(const void *a, const void *b)
+{
+	const struct btrfs_device_info *di_a = a;
+	const struct btrfs_device_info *di_b = b;
+
+	/* metadata -> preferred_metadata first */
+	if (di_a->preferred_metadata && !di_b->preferred_metadata)
+		return -1;
+	if (!di_a->preferred_metadata && di_b->preferred_metadata)
+		return 1;
+	if (di_a->max_avail > di_b->max_avail)
+		return -1;
+	if (di_a->max_avail < di_b->max_avail)
+		return 1;
+	if (di_a->total_avail > di_b->total_avail)
+		return -1;
+	if (di_a->total_avail < di_b->total_avail)
+		return 1;
+	return 0;
+}
+
+/*
+ * sort the devices in descending order by !preferred_metadata,
+ * max_avail, total_avail
+ */
+static int btrfs_cmp_device_info_data(const void *a, const void *b)
+{
+	const struct btrfs_device_info *di_a = a;
+	const struct btrfs_device_info *di_b = b;
+
+	/* data -> preferred_metadata last */
+	if (di_a->preferred_metadata && !di_b->preferred_metadata)
+		return 1;
+	if (!di_a->preferred_metadata && di_b->preferred_metadata)
+		return -1;
+	if (di_a->max_avail > di_b->max_avail)
+		return -1;
+	if (di_a->max_avail < di_b->max_avail)
+		return 1;
+	if (di_a->total_avail > di_b->total_avail)
+		return -1;
+	if (di_a->total_avail < di_b->total_avail)
+		return 1;
+	return 0;
+}
+
 static void check_raid56_incompat_flag(struct btrfs_fs_info *info, u64 type)
 {
 	if (!(type & BTRFS_BLOCK_GROUP_RAID56_MASK))
@@ -4939,6 +4989,7 @@ static int gather_device_info(struct btrfs_fs_devices *fs_devices,
 	int ndevs = 0;
 	u64 max_avail;
 	u64 dev_offset;
+	int nr_preferred_metadata = 0;
 
 	/*
 	 * in the first pass through the devices list, we gather information
@@ -4991,15 +5042,65 @@ static int gather_device_info(struct btrfs_fs_devices *fs_devices,
 		devices_info[ndevs].max_avail = max_avail;
 		devices_info[ndevs].total_avail = total_avail;
 		devices_info[ndevs].dev = device;
+		devices_info[ndevs].preferred_metadata = !!(device->type &
+			BTRFS_DEV_PREFERRED_METADATA);
+		if (devices_info[ndevs].preferred_metadata)
+			nr_preferred_metadata++;
 		++ndevs;
 	}
 	ctl->ndevs = ndevs;
 
+	BUG_ON(nr_preferred_metadata > ndevs);
 	/*
 	 * now sort the devices by hole size / available space
 	 */
-	sort(devices_info, ndevs, sizeof(struct btrfs_device_info),
-	     btrfs_cmp_device_info, NULL);
+	if (((ctl->type & BTRFS_BLOCK_GROUP_DATA) &&
+	     (ctl->type & BTRFS_BLOCK_GROUP_METADATA)) ||
+	    info->preferred_metadata_mode == BTRFS_PM_DISABLED) {
+		/* mixed bg or PREFERRED_METADATA not set */
+		sort(devices_info, ctl->ndevs, sizeof(struct btrfs_device_info),
+			     btrfs_cmp_device_info, NULL);
+	} else {
+		/*
+		 * if PREFERRED_METADATA is set, sort the device considering
+		 * also the kind (preferred_metadata or not). Limit the
+		 * availables devices to the ones of the same kind, to avoid
+		 * that a striped profile, like raid5, spreads to all kind of
+		 * devices.
+		 * It is allowed to use different kinds of devices (if the ones
+		 * of the same kind are not enough alone) in the following
+		 * case:
+		 * - preferred_metadata_mode == BTRFS_PM_SOFT:
+		 *               use the device of the same kind until these
+		 *               are enough. Otherwise it is allowed to
+		 *               use all the devices
+		 * - preferred_metadata_mode == BTRFS_PM_HARD
+		 *               use the device of the same kind; if these are
+		 *		 not enough, then an error will be raised raised
+		 * - preferred_metadata_mode == BTRFS_PM_METADATA
+		 *               metadata/system -> as BTRFS_PM_SOFT
+		 *               data -> as BTRFS_PM_HARD
+		 */
+		if (ctl->type & BTRFS_BLOCK_GROUP_DATA) {
+			int nr_data = ctl->ndevs - nr_preferred_metadata;
+			sort(devices_info, ctl->ndevs,
+				     sizeof(struct btrfs_device_info),
+				     btrfs_cmp_device_info_data, NULL);
+			if (info->preferred_metadata_mode == BTRFS_PM_HARD ||
+			    info->preferred_metadata_mode == BTRFS_PM_METADATA)
+				ctl->ndevs = nr_data;
+			else if (nr_data >= ctl->devs_min)
+				ctl->ndevs = nr_data;
+		} else { /* non data -> metadata and system */
+			sort(devices_info, ctl->ndevs,
+				     sizeof(struct btrfs_device_info),
+				     btrfs_cmp_device_info_metadata, NULL);
+			if (info->preferred_metadata_mode == BTRFS_PM_HARD)
+				ctl->ndevs = nr_preferred_metadata;
+			else if (nr_preferred_metadata >= ctl->devs_min)
+				ctl->ndevs = nr_preferred_metadata;
+		}
+	}
 
 	return 0;
 }
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index d776b7f55d56..fc8da51e739b 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -364,6 +364,7 @@ struct btrfs_device_info {
 	u64 dev_offset;
 	u64 max_avail;
 	u64 total_avail;
+	int preferred_metadata:1;
 };
 
 struct btrfs_raid_attr {
-- 
2.30.0

