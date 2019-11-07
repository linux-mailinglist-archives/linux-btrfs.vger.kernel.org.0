Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EB269F279D
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 Nov 2019 07:27:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726651AbfKGG1S (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 7 Nov 2019 01:27:18 -0500
Received: from mx2.suse.de ([195.135.220.15]:37588 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725938AbfKGG1S (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 7 Nov 2019 01:27:18 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E7D9FAF8E
        for <linux-btrfs@vger.kernel.org>; Thu,  7 Nov 2019 06:27:15 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 1/3] btrfs: volumes: Refactor device holes gathering into a separate function
Date:   Thu,  7 Nov 2019 14:27:08 +0800
Message-Id: <20191107062710.67964-2-wqu@suse.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191107062710.67964-1-wqu@suse.com>
References: <20191107062710.67964-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

In __btrfs_alloc_chunk() we need to iterate through all rw devices and
gather the hole sizes of them.

This function can be refactor into a new function, gather_dev_holes(),
to gather holes info from a list_head.

This provides the basis for later degraded chunk feature.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/volumes.c | 129 ++++++++++++++++++++++++++-------------------
 1 file changed, 74 insertions(+), 55 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index cdd7af424033..eee5fc1d11f0 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -4898,17 +4898,84 @@ static void check_raid56_incompat_flag(struct btrfs_fs_info *info, u64 type)
 	btrfs_set_fs_incompat(info, RAID56);
 }
 
+static int gather_dev_holes(struct btrfs_fs_info *info,
+			    struct btrfs_device_info *devices_info,
+			    int *index, struct list_head *list,
+			    int max_nr_devs, u64 stripe_size, int dev_stripes)
+{
+	struct btrfs_device *device;
+	int ret;
+	int ndevs = 0;
+
+	list_for_each_entry(device, list, dev_alloc_list) {
+		u64 max_avail;
+		u64 dev_offset;
+		u64 total_avail;
+
+		if (!test_bit(BTRFS_DEV_STATE_WRITEABLE, &device->dev_state) &&
+		    !test_bit(BTRFS_DEV_STATE_MISSING, &device->dev_state)) {
+			WARN(1, KERN_ERR
+			       "BTRFS: read-only device in alloc_list\n");
+			continue;
+		}
+
+		if (!test_bit(BTRFS_DEV_STATE_IN_FS_METADATA,
+					&device->dev_state) ||
+		    test_bit(BTRFS_DEV_STATE_REPLACE_TGT, &device->dev_state))
+			continue;
+
+		if (device->total_bytes > device->bytes_used)
+			total_avail = device->total_bytes - device->bytes_used;
+		else
+			total_avail = 0;
+
+		/* If there is no space on this device, skip it. */
+		if (total_avail == 0)
+			continue;
+
+		ret = find_free_dev_extent(device,
+					   stripe_size * dev_stripes,
+					   &dev_offset, &max_avail);
+		if (ret && ret != -ENOSPC)
+			break;
+
+		if (ret == 0)
+			max_avail = stripe_size * dev_stripes;
+
+		if (max_avail < BTRFS_STRIPE_LEN * dev_stripes) {
+			if (btrfs_test_opt(info, ENOSPC_DEBUG))
+				btrfs_debug(info,
+			"%s: devid %llu has no free space, have=%llu want=%u",
+					    __func__, device->devid, max_avail,
+					    BTRFS_STRIPE_LEN * dev_stripes);
+			continue;
+		}
+
+		if (ndevs == max_nr_devs) {
+			WARN(1, "%s: found more than %u devices\n", __func__,
+			     max_nr_devs);
+			break;
+		}
+		ret = 0;
+		devices_info[ndevs].dev_offset = dev_offset;
+		devices_info[ndevs].max_avail = max_avail;
+		devices_info[ndevs].total_avail = total_avail;
+		devices_info[ndevs].dev = device;
+		++ndevs;
+	}
+	*index += ndevs;
+	return 0;
+}
+
 static int __btrfs_alloc_chunk(struct btrfs_trans_handle *trans,
 			       u64 start, u64 type)
 {
 	struct btrfs_fs_info *info = trans->fs_info;
 	struct btrfs_fs_devices *fs_devices = info->fs_devices;
-	struct btrfs_device *device;
 	struct map_lookup *map = NULL;
 	struct extent_map_tree *em_tree;
 	struct extent_map *em;
 	struct btrfs_device_info *devices_info = NULL;
-	u64 total_avail;
 	int num_stripes;	/* total number of stripes to allocate */
 	int data_stripes;	/* number of stripes that count for
 				   block group size */
@@ -4983,59 +5050,11 @@ static int __btrfs_alloc_chunk(struct btrfs_trans_handle *trans,
 	 * about the available holes on each device.
 	 */
 	ndevs = 0;
-	list_for_each_entry(device, &fs_devices->alloc_list, dev_alloc_list) {
-		u64 max_avail;
-		u64 dev_offset;
-
-		if (!test_bit(BTRFS_DEV_STATE_WRITEABLE, &device->dev_state)) {
-			WARN(1, KERN_ERR
-			       "BTRFS: read-only device in alloc_list\n");
-			continue;
-		}
-
-		if (!test_bit(BTRFS_DEV_STATE_IN_FS_METADATA,
-					&device->dev_state) ||
-		    test_bit(BTRFS_DEV_STATE_REPLACE_TGT, &device->dev_state))
-			continue;
-
-		if (device->total_bytes > device->bytes_used)
-			total_avail = device->total_bytes - device->bytes_used;
-		else
-			total_avail = 0;
-
-		/* If there is no space on this device, skip it. */
-		if (total_avail == 0)
-			continue;
-
-		ret = find_free_dev_extent(device,
-					   max_stripe_size * dev_stripes,
-					   &dev_offset, &max_avail);
-		if (ret && ret != -ENOSPC)
-			goto error;
-
-		if (ret == 0)
-			max_avail = max_stripe_size * dev_stripes;
-
-		if (max_avail < BTRFS_STRIPE_LEN * dev_stripes) {
-			if (btrfs_test_opt(info, ENOSPC_DEBUG))
-				btrfs_debug(info,
-			"%s: devid %llu has no free space, have=%llu want=%u",
-					    __func__, device->devid, max_avail,
-					    BTRFS_STRIPE_LEN * dev_stripes);
-			continue;
-		}
-
-		if (ndevs == fs_devices->rw_devices) {
-			WARN(1, "%s: found more than %llu devices\n",
-			     __func__, fs_devices->rw_devices);
-			break;
-		}
-		devices_info[ndevs].dev_offset = dev_offset;
-		devices_info[ndevs].max_avail = max_avail;
-		devices_info[ndevs].total_avail = total_avail;
-		devices_info[ndevs].dev = device;
-		++ndevs;
-	}
+	ret = gather_dev_holes(info, devices_info, &ndevs,
+			&fs_devices->alloc_list, fs_devices->rw_devices,
+			max_stripe_size, dev_stripes);
+	if (ret < 0)
+		goto error;
 
 	/*
 	 * now sort the devices by hole size / available space
-- 
2.24.0

