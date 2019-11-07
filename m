Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 650A3F279E
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 Nov 2019 07:27:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726723AbfKGG1T (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 7 Nov 2019 01:27:19 -0500
Received: from mx2.suse.de ([195.135.220.15]:37594 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726467AbfKGG1T (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 7 Nov 2019 01:27:19 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 0F6EFAE4D
        for <linux-btrfs@vger.kernel.org>; Thu,  7 Nov 2019 06:27:17 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 2/3] btrfs: volumes: Add btrfs_fs_devices::missing_list to collect missing devices
Date:   Thu,  7 Nov 2019 14:27:09 +0800
Message-Id: <20191107062710.67964-3-wqu@suse.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191107062710.67964-1-wqu@suse.com>
References: <20191107062710.67964-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This enables btrfs to iterate missing devices separately, without
iterating all fs_devices.

This provides the basis for later degraded chunk enhancement.

The change includes:
- Add missing devices to btrfs_fs_devices::missing_list
  This happens at add_missing_dev() and other locations where
  missing_devices get increased.

- Remove missing devices from btrfs_fs_devices::missing_list
  This needs to cover all locations where missing_devices get decreased.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/volumes.c | 27 +++++++++++++++++++++------
 fs/btrfs/volumes.h |  6 ++++++
 2 files changed, 27 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index eee5fc1d11f0..a462d8de5d2a 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -324,6 +324,7 @@ static struct btrfs_fs_devices *alloc_fs_devices(const u8 *fsid,
 
 	INIT_LIST_HEAD(&fs_devs->devices);
 	INIT_LIST_HEAD(&fs_devs->alloc_list);
+	INIT_LIST_HEAD(&fs_devs->missing_list);
 	INIT_LIST_HEAD(&fs_devs->fs_list);
 	if (fsid)
 		memcpy(fs_devs->fsid, fsid, BTRFS_FSID_SIZE);
@@ -1089,6 +1090,7 @@ static noinline struct btrfs_device *device_list_add(const char *path,
 		if (test_bit(BTRFS_DEV_STATE_MISSING, &device->dev_state)) {
 			fs_devices->missing_devices--;
 			clear_bit(BTRFS_DEV_STATE_MISSING, &device->dev_state);
+			list_del_init(&device->dev_alloc_list);
 		}
 	}
 
@@ -1250,11 +1252,10 @@ static void btrfs_close_one_device(struct btrfs_device *device)
 	if (device->bdev)
 		fs_devices->open_devices--;
 
+	list_del_init(&device->dev_alloc_list);
 	if (test_bit(BTRFS_DEV_STATE_WRITEABLE, &device->dev_state) &&
-	    device->devid != BTRFS_DEV_REPLACE_DEVID) {
-		list_del_init(&device->dev_alloc_list);
+	    device->devid != BTRFS_DEV_REPLACE_DEVID)
 		fs_devices->rw_devices--;
-	}
 
 	if (test_bit(BTRFS_DEV_STATE_MISSING, &device->dev_state))
 		fs_devices->missing_devices--;
@@ -2140,6 +2141,12 @@ int btrfs_rm_device(struct btrfs_fs_info *fs_info, const char *device_path,
 		device->fs_devices->rw_devices--;
 		mutex_unlock(&fs_info->chunk_mutex);
 	}
+	if (test_bit(BTRFS_DEV_STATE_MISSING, &device->dev_state)) {
+		mutex_lock(&fs_info->chunk_mutex);
+		list_del_init(&device->dev_alloc_list);
+		device->fs_devices->missing_devices--;
+		mutex_unlock(&fs_info->chunk_mutex);
+	}
 
 	mutex_unlock(&uuid_mutex);
 	ret = btrfs_shrink_device(device, 0);
@@ -2184,9 +2191,6 @@ int btrfs_rm_device(struct btrfs_fs_info *fs_info, const char *device_path,
 	if (cur_devices != fs_devices)
 		fs_devices->total_devices--;
 
-	if (test_bit(BTRFS_DEV_STATE_MISSING, &device->dev_state))
-		cur_devices->missing_devices--;
-
 	btrfs_assign_next_active_device(device, NULL);
 
 	if (device->bdev) {
@@ -2236,6 +2240,13 @@ int btrfs_rm_device(struct btrfs_fs_info *fs_info, const char *device_path,
 		device->fs_devices->rw_devices++;
 		mutex_unlock(&fs_info->chunk_mutex);
 	}
+	if (test_bit(BTRFS_DEV_STATE_MISSING, &device->dev_state)) {
+		mutex_lock(&fs_info->chunk_mutex);
+		list_add(&device->dev_alloc_list,
+			 &fs_devices->missing_list);
+		device->fs_devices->missing_devices++;
+		mutex_unlock(&fs_info->chunk_mutex);
+	}
 	goto out;
 }
 
@@ -2438,6 +2449,7 @@ static int btrfs_prepare_sprout(struct btrfs_fs_info *fs_info)
 	seed_devices->opened = 1;
 	INIT_LIST_HEAD(&seed_devices->devices);
 	INIT_LIST_HEAD(&seed_devices->alloc_list);
+	INIT_LIST_HEAD(&seed_devices->missing_list);
 	mutex_init(&seed_devices->device_list_mutex);
 
 	mutex_lock(&fs_devices->device_list_mutex);
@@ -6640,6 +6652,7 @@ static struct btrfs_device *add_missing_dev(struct btrfs_fs_devices *fs_devices,
 	fs_devices->num_devices++;
 
 	set_bit(BTRFS_DEV_STATE_MISSING, &device->dev_state);
+	list_add(&device->dev_alloc_list, &fs_devices->missing_list);
 	fs_devices->missing_devices++;
 
 	return device;
@@ -6979,6 +6992,7 @@ static int read_one_dev(struct extent_buffer *leaf,
 			 */
 			device->fs_devices->missing_devices++;
 			set_bit(BTRFS_DEV_STATE_MISSING, &device->dev_state);
+			list_add(&device->dev_alloc_list, &fs_devices->missing_list);
 		}
 
 		/* Move the device to its own fs_devices */
@@ -6992,6 +7006,7 @@ static int read_one_dev(struct extent_buffer *leaf,
 
 			device->fs_devices->missing_devices--;
 			fs_devices->missing_devices++;
+			list_move(&device->dev_alloc_list, &fs_devices->missing_list);
 
 			device->fs_devices = fs_devices;
 		}
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index a7da1f3e3627..9cef4dc4b5be 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -253,6 +253,12 @@ struct btrfs_fs_devices {
 	 */
 	struct list_head alloc_list;
 
+	/*
+	 * Devices which can't be found. Projected by chunk_mutex.
+	 * This acts as a fallback allocation list for certain degraded mount.
+	 */
+	struct list_head missing_list;
+
 	struct btrfs_fs_devices *seed;
 	int seeding;
 
-- 
2.24.0

