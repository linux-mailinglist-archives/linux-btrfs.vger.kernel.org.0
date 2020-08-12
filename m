Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EECC6242A29
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Aug 2020 15:18:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728002AbgHLNSz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 12 Aug 2020 09:18:55 -0400
Received: from mx2.suse.de ([195.135.220.15]:54706 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726404AbgHLNSy (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 12 Aug 2020 09:18:54 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 4BD83B767;
        Wed, 12 Aug 2020 13:19:14 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH] btrfs: remove fsid argument from btrfs_sysfs_update_sprout_fsid
Date:   Wed, 12 Aug 2020 16:18:51 +0300
Message-Id: <20200812131851.9129-1-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

It can be accessed from 'fs_devices' as it's identical to
fs_info->fs_devices. Also add a comment about why we are calling the
function. No semantic changes.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/sysfs.c   | 6 +++---
 fs/btrfs/sysfs.h   | 3 +--
 fs/btrfs/volumes.c | 8 ++++++--
 3 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index 784a0f8a4cab..2d987b770a20 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -1322,8 +1322,8 @@ void btrfs_kobject_uevent(struct block_device *bdev, enum kobject_action action)
 			&disk_to_dev(bdev->bd_disk)->kobj);
 }
 
-void btrfs_sysfs_update_sprout_fsid(struct btrfs_fs_devices *fs_devices,
-				    const u8 *fsid)
+void btrfs_sysfs_update_sprout_fsid(struct btrfs_fs_devices *fs_devices)
+
 {
 	char fsid_buf[BTRFS_UUID_UNPARSED_SIZE];
 
@@ -1331,7 +1331,7 @@ void btrfs_sysfs_update_sprout_fsid(struct btrfs_fs_devices *fs_devices,
 	 * Sprouting changes fsid of the mounted filesystem, rename the fsid
 	 * directory
 	 */
-	snprintf(fsid_buf, BTRFS_UUID_UNPARSED_SIZE, "%pU", fsid);
+	snprintf(fsid_buf, BTRFS_UUID_UNPARSED_SIZE, "%pU", fs_devices->fsid);
 	if (kobject_rename(&fs_devices->fsid_kobj, fsid_buf))
 		btrfs_warn(fs_devices->fs_info,
 				"sysfs: failed to create fsid for sprout");
diff --git a/fs/btrfs/sysfs.h b/fs/btrfs/sysfs.h
index cf839c46a131..c9efa15f96e0 100644
--- a/fs/btrfs/sysfs.h
+++ b/fs/btrfs/sysfs.h
@@ -20,8 +20,7 @@ int btrfs_sysfs_remove_devices_dir(struct btrfs_fs_devices *fs_devices,
                 struct btrfs_device *one_device);
 int btrfs_sysfs_add_fsid(struct btrfs_fs_devices *fs_devs);
 void btrfs_sysfs_remove_fsid(struct btrfs_fs_devices *fs_devs);
-void btrfs_sysfs_update_sprout_fsid(struct btrfs_fs_devices *fs_devices,
-				    const u8 *fsid);
+void btrfs_sysfs_update_sprout_fsid(struct btrfs_fs_devices *fs_devices);
 void btrfs_sysfs_feature_update(struct btrfs_fs_info *fs_info,
 		u64 bit, enum btrfs_feature_set set);
 void btrfs_kobject_uevent(struct block_device *bdev, enum kobject_action action);
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 4bae30b9c944..631cb03b3513 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -2630,8 +2630,12 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
 			goto error_sysfs;
 		}
 
-		btrfs_sysfs_update_sprout_fsid(fs_devices,
-				fs_info->fs_devices->fsid);
+		/*
+		 * fs_devices now represents the newly sprouted filesystem and
+		 * its fsid has been changed by btrfs_prepare_sprout
+		 */
+		btrfs_sysfs_update_sprout_fsid(fs_devices);
+
 	}
 
 	ret = btrfs_commit_transaction(trans);
-- 
2.17.1

