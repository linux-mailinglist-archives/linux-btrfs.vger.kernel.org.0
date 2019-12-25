Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4687612A842
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Dec 2019 14:40:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726410AbfLYNkI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 25 Dec 2019 08:40:08 -0500
Received: from mx2.suse.de ([195.135.220.15]:56412 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726106AbfLYNkH (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 25 Dec 2019 08:40:07 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 5CD8DAAA6
        for <linux-btrfs@vger.kernel.org>; Wed, 25 Dec 2019 13:40:06 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH RFC 2/3] btrfs: Update per-profile available space when device size/used space get updated
Date:   Wed, 25 Dec 2019 21:39:37 +0800
Message-Id: <20191225133938.115733-3-wqu@suse.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191225133938.115733-1-wqu@suse.com>
References: <20191225133938.115733-1-wqu@suse.com>
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

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/volumes.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 8d4be1d48f2f..92d45a406d98 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -2799,6 +2799,7 @@ int btrfs_grow_device(struct btrfs_trans_handle *trans,
 	struct btrfs_super_block *super_copy = fs_info->super_copy;
 	u64 old_total;
 	u64 diff;
+	int ret;
 
 	if (!test_bit(BTRFS_DEV_STATE_WRITEABLE, &device->dev_state))
 		return -EACCES;
@@ -2827,6 +2828,11 @@ int btrfs_grow_device(struct btrfs_trans_handle *trans,
 			      &trans->transaction->dev_update_list);
 	mutex_unlock(&fs_info->chunk_mutex);
 
+	mutex_lock(&fs_info->fs_devices->device_list_mutex);
+	ret = calc_per_profile_avail(fs_info);
+	mutex_unlock(&fs_info->fs_devices->device_list_mutex);
+	if (ret < 0)
+		return ret;
 	return btrfs_update_device(trans, device);
 }
 
@@ -3005,7 +3011,12 @@ int btrfs_remove_chunk(struct btrfs_trans_handle *trans, u64 chunk_offset)
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
@@ -4821,6 +4832,10 @@ int btrfs_shrink_device(struct btrfs_device *device, u64 new_size)
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
-- 
2.24.1

