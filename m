Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 16AF212E365
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Jan 2020 08:47:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727732AbgABHrS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Jan 2020 02:47:18 -0500
Received: from mx2.suse.de ([195.135.220.15]:48314 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726145AbgABHrS (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 2 Jan 2020 02:47:18 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id B84BAAD5E
        for <linux-btrfs@vger.kernel.org>; Thu,  2 Jan 2020 07:47:16 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 2/4] btrfs: Update per-profile available space when device size/used space get updated
Date:   Thu,  2 Jan 2020 15:47:03 +0800
Message-Id: <20200102074705.136348-3-wqu@suse.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200102074705.136348-1-wqu@suse.com>
References: <20200102074705.136348-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

There are 4 locations where device size or used space get updated:
- Chunk allocation
- Chunk removal
- Device grow
- Device shrink

Now also update per-profile available space at those timings.

Please note that, since we have to acquire device_list_mutex inside
__btrfs_alloc_chunk(), this could cause ABBA dead lock.

To work around above problem, we will unlock chunk_mutex at the end to
get a window to lock device_list_mutex.
This looks pretty ugly, but should be good enough before we do a rework
on device_list_mutex and chunk mutex.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/volumes.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index d08e24524ccc..368bceb2076a 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -2808,6 +2808,7 @@ int btrfs_grow_device(struct btrfs_trans_handle *trans,
 	struct btrfs_super_block *super_copy = fs_info->super_copy;
 	u64 old_total;
 	u64 diff;
+	int ret;
 
 	if (!test_bit(BTRFS_DEV_STATE_WRITEABLE, &device->dev_state))
 		return -EACCES;
@@ -2836,6 +2837,11 @@ int btrfs_grow_device(struct btrfs_trans_handle *trans,
 			      &trans->transaction->dev_update_list);
 	mutex_unlock(&fs_info->chunk_mutex);
 
+	mutex_lock(&fs_info->fs_devices->device_list_mutex);
+	ret = calc_per_profile_avail(fs_info);
+	mutex_unlock(&fs_info->fs_devices->device_list_mutex);
+	if (ret < 0)
+		return ret;
 	return btrfs_update_device(trans, device);
 }
 
@@ -3014,7 +3020,12 @@ int btrfs_remove_chunk(struct btrfs_trans_handle *trans, u64 chunk_offset)
 			goto out;
 		}
 	}
+	ret = calc_per_profile_avail(fs_info);
 	mutex_unlock(&fs_devices->device_list_mutex);
+	if (ret < 0) {
+		btrfs_abort_transaction(trans, ret);
+		goto out;
+	}
 
 	ret = btrfs_free_chunk(trans, chunk_offset);
 	if (ret) {
@@ -4830,6 +4841,10 @@ int btrfs_shrink_device(struct btrfs_device *device, u64 new_size)
 			device->fs_devices->total_rw_bytes += diff;
 		atomic64_add(diff, &fs_info->free_chunk_space);
 		mutex_unlock(&fs_info->chunk_mutex);
+	} else {
+		mutex_lock(&fs_info->fs_devices->device_list_mutex);
+		ret = calc_per_profile_avail(fs_info);
+		mutex_unlock(&fs_info->fs_devices->device_list_mutex);
 	}
 	return ret;
 }
@@ -5147,8 +5162,15 @@ static int __btrfs_alloc_chunk(struct btrfs_trans_handle *trans,
 	check_raid56_incompat_flag(info, type);
 	check_raid1c34_incompat_flag(info, type);
 
+	/* To avoid device_list_mutex and chunk_mutex ABBA lock */
+	mutex_unlock(&info->chunk_mutex);
+	mutex_lock(&info->fs_devices->device_list_mutex);
+	ret = calc_per_profile_avail(info);
+	mutex_unlock(&info->fs_devices->device_list_mutex);
+	mutex_lock(&info->chunk_mutex);
+
 	kfree(devices_info);
-	return 0;
+	return ret;
 
 error_del_extent:
 	write_lock(&em_tree->lock);
-- 
2.24.1

