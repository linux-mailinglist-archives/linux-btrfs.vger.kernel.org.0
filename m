Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2276512E5A5
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Jan 2020 12:28:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728179AbgABL2B (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Jan 2020 06:28:01 -0500
Received: from mx2.suse.de ([195.135.220.15]:42940 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728135AbgABL2B (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 2 Jan 2020 06:28:01 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 09A3CB2D9
        for <linux-btrfs@vger.kernel.org>; Thu,  2 Jan 2020 11:27:59 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 2/4] btrfs: Update per-profile available space when device size/used space get updated
Date:   Thu,  2 Jan 2020 19:27:44 +0800
Message-Id: <20200102112746.145045-3-wqu@suse.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200102112746.145045-1-wqu@suse.com>
References: <20200102112746.145045-1-wqu@suse.com>
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

For __btrfs_alloc_chunk() we can't acquire device_list_mutex as in
btrfs_finish_chunk_alloc() we could hold device_list_mutex and cause
dead lock.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/volumes.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index fa948f7eebc2..be8250332c60 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -2804,6 +2804,7 @@ int btrfs_grow_device(struct btrfs_trans_handle *trans,
 	struct btrfs_super_block *super_copy = fs_info->super_copy;
 	u64 old_total;
 	u64 diff;
+	int ret;
 
 	if (!test_bit(BTRFS_DEV_STATE_WRITEABLE, &device->dev_state))
 		return -EACCES;
@@ -2832,6 +2833,11 @@ int btrfs_grow_device(struct btrfs_trans_handle *trans,
 			      &trans->transaction->dev_update_list);
 	mutex_unlock(&fs_info->chunk_mutex);
 
+	mutex_lock(&fs_info->fs_devices->device_list_mutex);
+	ret = calc_per_profile_avail(fs_info);
+	mutex_unlock(&fs_info->fs_devices->device_list_mutex);
+	if (ret < 0)
+		return ret;
 	return btrfs_update_device(trans, device);
 }
 
@@ -3010,7 +3016,12 @@ int btrfs_remove_chunk(struct btrfs_trans_handle *trans, u64 chunk_offset)
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
@@ -4826,6 +4837,10 @@ int btrfs_shrink_device(struct btrfs_device *device, u64 new_size)
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
@@ -5143,8 +5158,14 @@ static int __btrfs_alloc_chunk(struct btrfs_trans_handle *trans,
 	check_raid56_incompat_flag(info, type);
 	check_raid1c34_incompat_flag(info, type);
 
+	/*
+	 * In this context we don't need device_list_mutex as chunk_mutex are
+	 * protecting us.
+	 */
+	ret = calc_per_profile_avail(info);
+
 	kfree(devices_info);
-	return 0;
+	return ret;
 
 error_del_extent:
 	write_lock(&em_tree->lock);
-- 
2.24.1

