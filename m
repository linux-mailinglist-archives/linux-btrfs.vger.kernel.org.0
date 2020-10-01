Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9386227F93C
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Oct 2020 07:58:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730854AbgJAF6U (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 1 Oct 2020 01:58:20 -0400
Received: from mx2.suse.de ([195.135.220.15]:40428 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725892AbgJAF6U (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 1 Oct 2020 01:58:20 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1601531899;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=moPA+mPoNOnmuH6WQg8GDD500Y8nQ4VvSpBcd3qFQe4=;
        b=lJaxyEytsUP0TrFRATMlHgAF8koGs+yQQdCglhHLMrGoSSSUrgTmmf+GSwWEvaosqJVSLY
        1J6rIZSvKRkWIzD0E8ucqiGt+XzD3YGnEn7vaXCyvJX4bj00s/h6GRIqnOlM6eumm+NAV7
        sEePJASR4a5Vy7sEoD4mbIGDxdNHF28=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 0D697B320
        for <linux-btrfs@vger.kernel.org>; Thu,  1 Oct 2020 05:58:19 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 9 10/12] btrfs: volumes: update per-profile available space for device update
Date:   Thu,  1 Oct 2020 13:57:42 +0800
Message-Id: <20201001055744.103261-11-wqu@suse.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201001055744.103261-1-wqu@suse.com>
References: <20201001055744.103261-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

4 locations are involved, and we need to handle the extra error there:

- device removal
  The existing error handling is good enough to revert.

- device add
  We abort transaction when failed, just like the existing error
  patterns.

- device grow
  We revert the device size if we failed.

- device shrink
  The existing error handling is good enough to revert the device size.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/volumes.c | 44 ++++++++++++++++++++++++++++++++++++--------
 1 file changed, 36 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 12c08648f5b6..77276a6b172a 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -2251,7 +2251,10 @@ int btrfs_rm_device(struct btrfs_fs_info *fs_info, const char *device_path,
 		mutex_lock(&fs_info->chunk_mutex);
 		list_del_init(&device->dev_alloc_list);
 		device->fs_devices->rw_devices--;
+		ret = btrfs_update_per_profile_avail(fs_info);
 		mutex_unlock(&fs_info->chunk_mutex);
+		if (ret < 0)
+			goto error_undo;
 	}
 
 	mutex_unlock(&uuid_mutex);
@@ -2777,14 +2780,21 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
 	/* add sysfs device entry */
 	btrfs_sysfs_add_devices_dir(fs_devices, device);
 
-	/*
-	 * we've got more storage, clear any full flags on the space
-	 * infos
-	 */
-	btrfs_clear_space_info_full(fs_info);
+	ret = btrfs_update_per_profile_avail(fs_info);
+
+	if (!ret)
+		/*
+		 * we've got more storage, clear any full flags on the space
+		 * infos
+		 */
+		btrfs_clear_space_info_full(fs_info);
 
 	mutex_unlock(&fs_info->chunk_mutex);
 	mutex_unlock(&fs_devices->device_list_mutex);
+	if (ret < 0) {
+		btrfs_abort_transaction(trans, ret);
+		goto error_sysfs;
+	}
 
 	if (seeding_dev) {
 		mutex_lock(&fs_info->chunk_mutex);
@@ -2937,8 +2947,10 @@ int btrfs_grow_device(struct btrfs_trans_handle *trans,
 {
 	struct btrfs_fs_info *fs_info = device->fs_info;
 	struct btrfs_super_block *super_copy = fs_info->super_copy;
+	u64 old_dev_size;
 	u64 old_total;
 	u64 diff;
+	int ret;
 
 	if (!test_bit(BTRFS_DEV_STATE_WRITEABLE, &device->dev_state))
 		return -EACCES;
@@ -2947,6 +2959,7 @@ int btrfs_grow_device(struct btrfs_trans_handle *trans,
 
 	mutex_lock(&fs_info->chunk_mutex);
 	old_total = btrfs_super_total_bytes(super_copy);
+	old_dev_size = device->total_bytes;
 	diff = round_down(new_size - device->total_bytes, fs_info->sectorsize);
 
 	if (new_size <= device->total_bytes ||
@@ -2955,17 +2968,26 @@ int btrfs_grow_device(struct btrfs_trans_handle *trans,
 		return -EINVAL;
 	}
 
+	btrfs_device_set_total_bytes(device, new_size);
+	btrfs_device_set_disk_total_bytes(device, new_size);
+	ret = btrfs_update_per_profile_avail(fs_info);
+	if (ret < 0) {
+		btrfs_device_set_total_bytes(device, old_dev_size);
+		btrfs_device_set_disk_total_bytes(device, old_dev_size);
+		mutex_unlock(&fs_info->chunk_mutex);
+		return ret;
+	}
+
 	btrfs_set_super_total_bytes(super_copy,
 			round_down(old_total + diff, fs_info->sectorsize));
 	device->fs_devices->total_rw_bytes += diff;
-
-	btrfs_device_set_total_bytes(device, new_size);
-	btrfs_device_set_disk_total_bytes(device, new_size);
 	btrfs_clear_space_info_full(device->fs_info);
 	if (list_empty(&device->post_commit_list))
 		list_add_tail(&device->post_commit_list,
 			      &trans->transaction->dev_update_list);
 	mutex_unlock(&fs_info->chunk_mutex);
+	if (ret < 0)
+		return ret;
 
 	return btrfs_update_device(trans, device);
 }
@@ -4784,6 +4806,12 @@ int btrfs_shrink_device(struct btrfs_device *device, u64 new_size)
 		device->fs_devices->total_rw_bytes -= diff;
 		atomic64_sub(diff, &fs_info->free_chunk_space);
 	}
+	ret = btrfs_update_per_profile_avail(fs_info);
+	if (ret < 0) {
+		mutex_unlock(&fs_info->chunk_mutex);
+		btrfs_end_transaction(trans);
+		goto done;
+	}
 
 	/*
 	 * Once the device's size has been set to the new size, ensure all
-- 
2.28.0

