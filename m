Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D701220A6F
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Jul 2020 12:49:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729428AbgGOKsy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 Jul 2020 06:48:54 -0400
Received: from [195.135.220.15] ([195.135.220.15]:37950 "EHLO mx2.suse.de"
        rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
        id S1729363AbgGOKsy (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 Jul 2020 06:48:54 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B33A8B0B6;
        Wed, 15 Jul 2020 10:48:55 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 4/5] btrfs: Simplify setting/clearing fs_info to btrfs_fs_devices
Date:   Wed, 15 Jul 2020 13:48:49 +0300
Message-Id: <20200715104850.19071-5-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200715104850.19071-1-nborisov@suse.com>
References: <20200715104850.19071-1-nborisov@suse.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

It makes no sense to have sysfs-related routines be responsible for
properly initialising the fs_info pointer of struct btrfs_fs_device.
Instead this can be streamlined by making it the responsibility of
btrfs_init_devices_late to initialize it. That function already
initializes fs_info of every individual device in btrfs_fs_devices.

As far as clearing it is concerned it makes sense to move it to
close_fs_devices. That function is only called when struct
btrfs_fs_devices is no longer in use - either for holding seeds or main
devices for a mounted filesystem.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/sysfs.c   |  4 ----
 fs/btrfs/volumes.c | 22 ++--------------------
 fs/btrfs/volumes.h |  2 --
 3 files changed, 2 insertions(+), 26 deletions(-)

diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index 38c0b95e0e7f..24f6bbd655e3 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -939,8 +939,6 @@ void btrfs_sysfs_remove_mounted(struct btrfs_fs_info *fs_info)
 {
 	struct kobject *fsid_kobj = &fs_info->fs_devices->fsid_kobj;
 
-	btrfs_reset_fs_info_ptr(fs_info);
-
 	sysfs_remove_link(fsid_kobj, "bdi");
 
 	if (fs_info->space_info_kobj) {
@@ -1397,8 +1395,6 @@ int btrfs_sysfs_add_mounted(struct btrfs_fs_info *fs_info)
 	struct btrfs_fs_devices *fs_devs = fs_info->fs_devices;
 	struct kobject *fsid_kobj = &fs_devs->fsid_kobj;
 
-	btrfs_set_fs_info_ptr(fs_info);
-
 	error = btrfs_sysfs_add_devices_dir(fs_devs, NULL);
 	if (error)
 		return error;
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 6de021c78277..a0cdd027e99c 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -1163,6 +1163,7 @@ static void close_fs_devices(struct btrfs_fs_devices *fs_devices)
 	WARN_ON(fs_devices->rw_devices);
 	fs_devices->opened = 0;
 	fs_devices->seeding = false;
+	fs_devices->fs_info = NULL;
 }
 
 void btrfs_close_devices(struct btrfs_fs_devices *fs_devices)
@@ -7149,6 +7150,7 @@ void btrfs_init_devices_late(struct btrfs_fs_info *fs_info)
 			device->fs_info = fs_info;
 		mutex_unlock(&fs_devices->device_list_mutex);
 
+		fs_devices->fs_info = fs_info;
 		fs_devices = fs_devices->seed;
 	}
 }
@@ -7447,24 +7449,6 @@ void btrfs_commit_device_sizes(struct btrfs_transaction *trans)
 	mutex_unlock(&trans->fs_info->chunk_mutex);
 }
 
-void btrfs_set_fs_info_ptr(struct btrfs_fs_info *fs_info)
-{
-	struct btrfs_fs_devices *fs_devices = fs_info->fs_devices;
-	while (fs_devices) {
-		fs_devices->fs_info = fs_info;
-		fs_devices = fs_devices->seed;
-	}
-}
-
-void btrfs_reset_fs_info_ptr(struct btrfs_fs_info *fs_info)
-{
-	struct btrfs_fs_devices *fs_devices = fs_info->fs_devices;
-	while (fs_devices) {
-		fs_devices->fs_info = NULL;
-		fs_devices = fs_devices->seed;
-	}
-}
-
 /*
  * Multiplicity factor for simple profiles: DUP, RAID1-like and RAID10.
  */
@@ -7475,8 +7459,6 @@ int btrfs_bg_type_to_factor(u64 flags)
 	return btrfs_raid_array[index].ncopies;
 }
 
-
-
 static int verify_one_dev_extent(struct btrfs_fs_info *fs_info,
 				 u64 chunk_offset, u64 devid,
 				 u64 physical_offset, u64 physical_len)
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index 76e5470e19a8..fc283fdbcece 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -569,8 +569,6 @@ static inline enum btrfs_raid_types btrfs_bg_flags_to_raid_index(u64 flags)
 void btrfs_commit_device_sizes(struct btrfs_transaction *trans);
 
 struct list_head * __attribute_const__ btrfs_get_fs_uuids(void);
-void btrfs_set_fs_info_ptr(struct btrfs_fs_info *fs_info);
-void btrfs_reset_fs_info_ptr(struct btrfs_fs_info *fs_info);
 bool btrfs_check_rw_degradable(struct btrfs_fs_info *fs_info,
 					struct btrfs_device *failing_dev);
 
-- 
2.17.1

