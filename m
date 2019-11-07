Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D30F7F279F
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 Nov 2019 07:27:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726791AbfKGG1V (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 7 Nov 2019 01:27:21 -0500
Received: from mx2.suse.de ([195.135.220.15]:37600 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725938AbfKGG1U (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 7 Nov 2019 01:27:20 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 29C09B300
        for <linux-btrfs@vger.kernel.org>; Thu,  7 Nov 2019 06:27:18 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 3/3] btrfs: volumes: Allocate degraded chunks if rw devices can't fullfil a chunk
Date:   Thu,  7 Nov 2019 14:27:10 +0800
Message-Id: <20191107062710.67964-4-wqu@suse.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191107062710.67964-1-wqu@suse.com>
References: <20191107062710.67964-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[PROBLEM]
Btrfs degraded mount will fallback to SINGLE profile if there are not
enough devices:

 # mkfs.btrfs -f /dev/test/scratch[12] -m raid1 -d raid1
 # wipefs -fa /dev/test/scratch2
 # mount -o degraded /dev/test/scratch1 /mnt/btrfs
 # fallocate -l 1G /mnt/btrfs/foobar
 # btrfs ins dump-tree -t chunk /dev/test/scratch1
        item 7 key (FIRST_CHUNK_TREE CHUNK_ITEM 1674575872) itemoff 15511 itemsize 80
                length 536870912 owner 2 stripe_len 65536 type DATA
 New data chunk will fallback to SINGLE.

If user doesn't balance those SINGLE chunks, even with missing devices
replaced, the fs is no longer full RAID1, and a missing device can break
the tolerance.

[CAUSE]
The cause is pretty simple, when mounted degraded, missing devices can't
be used for chunk allocation.
Thus btrfs has to fall back to SINGLE profile.

[ENHANCEMENT]
To avoid such problem, this patch will:
- Make all profiler reducer/updater to consider missing devices as part
  of num_devices
- Make chunk allocator to fallback to missing_list as last resort

If we have enough rw_devices, then go regular chunk allocation code.
This can avoid allocating degraded chunks.
E.g. for 3 devices RAID1 degraded mount, we will use the 2 existing
devices to allocate chunk, avoid degraded chunk.

But if we don't have enough rw_devices, then we check missing devices to
allocate degraded chunks.
E.g. for 2 devices RAID1 degraded mount, we have to allocate degraded
chunks to keep the RAID1 profile.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/block-group.c | 10 +++++++---
 fs/btrfs/volumes.c     | 18 +++++++++++++++---
 2 files changed, 22 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index bf7e3f23bba7..1686fd31679b 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -52,11 +52,13 @@ static u64 get_restripe_target(struct btrfs_fs_info *fs_info, u64 flags)
  */
 static u64 btrfs_reduce_alloc_profile(struct btrfs_fs_info *fs_info, u64 flags)
 {
-	u64 num_devices = fs_info->fs_devices->rw_devices;
+	u64 num_devices;
 	u64 target;
 	u64 raid_type;
 	u64 allowed = 0;
 
+	num_devices = fs_info->fs_devices->rw_devices +
+		      fs_info->fs_devices->missing_devices;
 	/*
 	 * See if restripe for this chunk_type is in progress, if so try to
 	 * reduce to the target profile
@@ -1986,7 +1988,8 @@ static u64 update_block_group_flags(struct btrfs_fs_info *fs_info, u64 flags)
 	if (stripped)
 		return extended_to_chunk(stripped);
 
-	num_devices = fs_info->fs_devices->rw_devices;
+	num_devices = fs_info->fs_devices->rw_devices +
+		      fs_info->fs_devices->missing_devices;
 
 	stripped = BTRFS_BLOCK_GROUP_RAID0 | BTRFS_BLOCK_GROUP_RAID56_MASK |
 		BTRFS_BLOCK_GROUP_RAID1_MASK | BTRFS_BLOCK_GROUP_RAID10;
@@ -2981,7 +2984,8 @@ static u64 get_profile_num_devs(struct btrfs_fs_info *fs_info, u64 type)
 
 	num_dev = btrfs_raid_array[btrfs_bg_flags_to_raid_index(type)].devs_max;
 	if (!num_dev)
-		num_dev = fs_info->fs_devices->rw_devices;
+		num_dev = fs_info->fs_devices->rw_devices +
+			  fs_info->fs_devices->missing_devices;
 
 	return num_dev;
 }
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index a462d8de5d2a..4dee1974ceb7 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -5052,8 +5052,9 @@ static int __btrfs_alloc_chunk(struct btrfs_trans_handle *trans,
 	max_chunk_size = min(div_factor(fs_devices->total_rw_bytes, 1),
 			     max_chunk_size);
 
-	devices_info = kcalloc(fs_devices->rw_devices, sizeof(*devices_info),
-			       GFP_NOFS);
+	devices_info = kcalloc(fs_devices->rw_devices +
+			       fs_devices->missing_devices,
+			       sizeof(*devices_info), GFP_NOFS);
 	if (!devices_info)
 		return -ENOMEM;
 
@@ -5067,7 +5068,18 @@ static int __btrfs_alloc_chunk(struct btrfs_trans_handle *trans,
 			max_stripe_size, dev_stripes);
 	if (ret < 0)
 		goto error;
-
+	/*
+	 * If rw devices can't fullfil the request, fallback to missing devices
+	 * as last resort.
+	 */
+	if (ndevs < devs_min) {
+		ret = gather_dev_holes(info, devices_info + ndevs, &ndevs,
+				&fs_devices->missing_list,
+				fs_devices->missing_devices,
+				max_stripe_size, dev_stripes);
+		if (ret < 0)
+			goto error;
+	}
 	/*
 	 * now sort the devices by hole size / available space
 	 */
-- 
2.24.0

