Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 797B016B857
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Feb 2020 04:57:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729000AbgBYD51 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 24 Feb 2020 22:57:27 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:34216 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728952AbgBYD5M (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 24 Feb 2020 22:57:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1582603032; x=1614139032;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=58e7jhwrOPqQXuahKyYyBxRkosy+3/SpZVRmVxJC8L0=;
  b=rxsZApzAUglAeDKWM2wOUL4U8tzEXuFaZTVJHTbUBQ2cQ2EaWK1S+sE/
   fSoAie4n+bH56u7rmTHrO7OPZFO1J/ASGzMVkLMzFiDhvhVL5BcqdmmgD
   m6kjCcn8WnUpoChgex9VqEDtFoB7SmyQa7mFjYqvxHGMTao9H1u8DZm0u
   bqpiDPNc53TwDDbpu6POIHkn5nAeyg4jobCTJw2oCEAs1l70WSXeV1jVm
   LK91dy7DVuNwloY8XtC6kHb3GJROVVDf9EnIX9dc11LOhMSvflHzfZrQL
   KHtooO3Uu/RtVv5ayhtwHO7fHHPxG9z/GStOxuAoUJV1zP19RXtsjxjVH
   Q==;
IronPort-SDR: YY6ftMzAFATfFmWdb9JS2Us2Oww7bh0Dt5vkooM2k7X0/WJHUStOHZtJFzO/V/mXOujh+qkXMe
 GRy2q130CjfxA3OQq7VvNbcvoxUhB4Ef6+7lzaK4X2LDthhU3W3NAOb9N5tLVLfQPLWS4ha6mB
 sSTmBgrRA+OytqctoXhLkwaJfnSn+g8yMVex6cGERcys0hT8q+VlNrZzQLBbUq+sTqUYdKTPg7
 yW0cvJbnGHrSgHtX6JSalHWe4fnT+ko3udZGrGVpb5Rr2EIOXeYmSHazBEvY0osR2o9mjb6dZO
 R3A=
X-IronPort-AV: E=Sophos;i="5.70,482,1574092800"; 
   d="scan'208";a="131168284"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 25 Feb 2020 11:57:04 +0800
IronPort-SDR: Heqydof3Bj3oZwZBzMzwfmIbGCV1hOeJxozE9AaY3D4F5XEf3cvQePEQXjSGUWdY0Ls4/o9gkP
 Pp6/l4w0CXAHNehZmoZbE0NLL4hX5kn3+A90kZjxcCXuMnyQ2UGkLnkbF9pZVYsbD4XkGpAMIz
 VZOWuIAGLsLvgHmdBL1z/bhB/9lRgd7RHBDmO6H67M1XbZ3tXNd2UgG3w7oy4IThQKaqF/ve8N
 +MO4Y269obTmUMeCzF55st0d3vqQHQXe+nSelmiZMXDnAuxUr2dM3bW5QwQWaoqstuGKDD9/uj
 ygJtyl3zQn3SaySCqQh2jxBd
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2020 19:49:32 -0800
IronPort-SDR: zTIjyhSa6neA6e2kEb8/I1AlCSTe57qT34k/tQJsoPearMC/PB58E1uE8aMlWz3UO20mQ0qft5
 EQA4lrUVIYs4si0Pploku1GZJiV35FPhL8Fmrz3uuhDAoN0XehZBdvSDE5G3YiSYeIDERFl5SP
 jEpNRCY/Fb3GT/q3hMlhUj3pn8F55pp1raFzpdKJiyOnS6ZI5oXfDJ/en//1BX8KrBsFg7b9Nz
 nuDzq13A1X0dUmhPqYcfDFnqr/A/p3hdRE9AzHyXKRshv2SCa6giKNcg7gflBB98CmYvOqN8Ry
 3GE=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip02.wdc.com with ESMTP; 24 Feb 2020 19:57:03 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Cc:     Josef Bacik <josef@toxicpanda.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v3 07/21] btrfs: factor out gather_device_info()
Date:   Tue, 25 Feb 2020 12:56:12 +0900
Message-Id: <20200225035626.1049501-8-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200225035626.1049501-1-naohiro.aota@wdc.com>
References: <20200225035626.1049501-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Factor out gather_device_info() from __btrfs_alloc_chunk(). This function
iterates over devices list and gather information about devices. This
commit also introduces "max_avail" and "dev_extent_min" to fold the same
calculation to one variable.

This commit has no functional changes.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/volumes.c | 121 +++++++++++++++++++++++++--------------------
 1 file changed, 67 insertions(+), 54 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index b15c2bb6f913..cd3a46a803d8 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -4896,60 +4896,25 @@ static void init_alloc_chunk_ctl(struct btrfs_fs_devices *fs_devices,
 	}
 }
 
-static int __btrfs_alloc_chunk(struct btrfs_trans_handle *trans,
-			       u64 start, u64 type)
+static int gather_device_info(struct btrfs_fs_devices *fs_devices,
+			      struct alloc_chunk_ctl *ctl,
+			      struct btrfs_device_info *devices_info)
 {
-	struct btrfs_fs_info *info = trans->fs_info;
-	struct btrfs_fs_devices *fs_devices = info->fs_devices;
+	struct btrfs_fs_info *info = fs_devices->fs_info;
 	struct btrfs_device *device;
-	struct map_lookup *map = NULL;
-	struct extent_map_tree *em_tree;
-	struct extent_map *em;
-	struct btrfs_device_info *devices_info = NULL;
-	struct alloc_chunk_ctl ctl;
 	u64 total_avail;
-	int data_stripes;	/* number of stripes that count for
-				   block group size */
+	u64 dev_extent_want = ctl->max_stripe_size * ctl->dev_stripes;
+	u64 dev_extent_min = BTRFS_STRIPE_LEN * ctl->dev_stripes;
 	int ret;
-	int ndevs;
-	int i;
-	int j;
-
-	if (!alloc_profile_is_valid(type, 0)) {
-		ASSERT(0);
-		return -EINVAL;
-	}
-
-	if (list_empty(&fs_devices->alloc_list)) {
-		if (btrfs_test_opt(info, ENOSPC_DEBUG))
-			btrfs_debug(info, "%s: no writable device", __func__);
-		return -ENOSPC;
-	}
-
-	if (!(type & BTRFS_BLOCK_GROUP_TYPE_MASK)) {
-		btrfs_err(info, "invalid chunk type 0x%llx requested", type);
-		ASSERT(0);
-		return -EINVAL;
-	}
-
-	ctl.start = start;
-	ctl.type = type;
-	init_alloc_chunk_ctl(fs_devices, &ctl);
-
-	devices_info = kcalloc(fs_devices->rw_devices, sizeof(*devices_info),
-			       GFP_NOFS);
-	if (!devices_info)
-		return -ENOMEM;
+	int ndevs = 0;
+	u64 max_avail;
+	u64 dev_offset;
 
 	/*
 	 * in the first pass through the devices list, we gather information
 	 * about the available holes on each device.
 	 */
-	ndevs = 0;
 	list_for_each_entry(device, &fs_devices->alloc_list, dev_alloc_list) {
-		u64 max_avail;
-		u64 dev_offset;
-
 		if (!test_bit(BTRFS_DEV_STATE_WRITEABLE, &device->dev_state)) {
 			WARN(1, KERN_ERR
 			       "BTRFS: read-only device in alloc_list\n");
@@ -4970,21 +4935,20 @@ static int __btrfs_alloc_chunk(struct btrfs_trans_handle *trans,
 		if (total_avail == 0)
 			continue;
 
-		ret = find_free_dev_extent(
-			device, ctl.max_stripe_size * ctl.dev_stripes,
-			&dev_offset, &max_avail);
+		ret = find_free_dev_extent(device, dev_extent_want, &dev_offset,
+					   &max_avail);
 		if (ret && ret != -ENOSPC)
-			goto error;
+			return ret;
 
 		if (ret == 0)
-			max_avail = ctl.max_stripe_size * ctl.dev_stripes;
+			max_avail = dev_extent_want;
 
-		if (max_avail < BTRFS_STRIPE_LEN * ctl.dev_stripes) {
+		if (max_avail < dev_extent_min) {
 			if (btrfs_test_opt(info, ENOSPC_DEBUG))
 				btrfs_debug(info,
-			"%s: devid %llu has no free space, have=%llu want=%u",
+			"%s: devid %llu has no free space, have=%llu want=%llu",
 					    __func__, device->devid, max_avail,
-					    BTRFS_STRIPE_LEN * ctl.dev_stripes);
+					    dev_extent_min);
 			continue;
 		}
 
@@ -4999,14 +4963,63 @@ static int __btrfs_alloc_chunk(struct btrfs_trans_handle *trans,
 		devices_info[ndevs].dev = device;
 		++ndevs;
 	}
-	ctl.ndevs = ndevs;
+	ctl->ndevs = ndevs;
 
 	/*
 	 * now sort the devices by hole size / available space
 	 */
-	sort(devices_info, ctl.ndevs, sizeof(struct btrfs_device_info),
+	sort(devices_info, ndevs, sizeof(struct btrfs_device_info),
 	     btrfs_cmp_device_info, NULL);
 
+	return 0;
+}
+
+static int __btrfs_alloc_chunk(struct btrfs_trans_handle *trans,
+			       u64 start, u64 type)
+{
+	struct btrfs_fs_info *info = trans->fs_info;
+	struct btrfs_fs_devices *fs_devices = info->fs_devices;
+	struct map_lookup *map = NULL;
+	struct extent_map_tree *em_tree;
+	struct extent_map *em;
+	struct btrfs_device_info *devices_info = NULL;
+	struct alloc_chunk_ctl ctl;
+	int data_stripes;	/* number of stripes that count for
+				   block group size */
+	int ret;
+	int i;
+	int j;
+
+	if (!alloc_profile_is_valid(type, 0)) {
+		ASSERT(0);
+		return -EINVAL;
+	}
+
+	if (list_empty(&fs_devices->alloc_list)) {
+		if (btrfs_test_opt(info, ENOSPC_DEBUG))
+			btrfs_debug(info, "%s: no writable device", __func__);
+		return -ENOSPC;
+	}
+
+	if (!(type & BTRFS_BLOCK_GROUP_TYPE_MASK)) {
+		btrfs_err(info, "invalid chunk type 0x%llx requested", type);
+		ASSERT(0);
+		return -EINVAL;
+	}
+
+	ctl.start = start;
+	ctl.type = type;
+	init_alloc_chunk_ctl(fs_devices, &ctl);
+
+	devices_info = kcalloc(fs_devices->rw_devices, sizeof(*devices_info),
+			       GFP_NOFS);
+	if (!devices_info)
+		return -ENOMEM;
+
+	ret = gather_device_info(fs_devices, &ctl, devices_info);
+	if (ret < 0)
+		goto error;
+
 	/*
 	 * Round down to number of usable stripes, devs_increment can be any
 	 * number so we can't use round_down()
-- 
2.25.1

