Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E4F657FB42
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Aug 2019 15:40:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436507AbfHBNjw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 2 Aug 2019 09:39:52 -0400
Received: from mx2.suse.de ([195.135.220.15]:60122 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2391798AbfHBNjv (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 2 Aug 2019 09:39:51 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5FE58AFA4
        for <linux-btrfs@vger.kernel.org>; Fri,  2 Aug 2019 13:39:50 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 3AAA9DADC0; Fri,  2 Aug 2019 15:40:24 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 10/13] btrfs: factor out sysfs code for updating sprout fsid
Date:   Fri,  2 Aug 2019 15:40:24 +0200
Message-Id: <62c272bb613701d56cf6b0da56516bbcbf68ead9.1564752900.git.dsterba@suse.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <cover.1564752900.git.dsterba@suse.com>
References: <cover.1564752900.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Wrap the fsid renaming code and move it to sysfs.c.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/sysfs.c   | 15 +++++++++++++++
 fs/btrfs/sysfs.h   |  2 ++
 fs/btrfs/volumes.c | 12 ++----------
 3 files changed, 19 insertions(+), 10 deletions(-)

diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index 2490144863ae..b7eb921e3fd3 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -935,6 +935,21 @@ void btrfs_kobject_uevent(struct block_device *bdev, enum kobject_action action)
 			&disk_to_dev(bdev->bd_disk)->kobj);
 }
 
+void btrfs_sysfs_update_sprout_fsid(struct btrfs_fs_devices *fs_devices,
+				    const u8 *fsid)
+{
+	char fsid_buf[BTRFS_UUID_UNPARSED_SIZE];
+
+	/*
+	 * Sprouting changes fsid of the mounted filesystem, rename the fsid
+	 * directory
+	 */
+	snprintf(fsid_buf, BTRFS_UUID_UNPARSED_SIZE, "%pU", fsid);
+	if (kobject_rename(&fs_devices->fsid_kobj, fsid_buf))
+		btrfs_warn(fs_devices->fs_info,
+				"sysfs: failed to create fsid for sprout");
+}
+
 /* /sys/fs/btrfs/ entry */
 static struct kset *btrfs_kset;
 
diff --git a/fs/btrfs/sysfs.h b/fs/btrfs/sysfs.h
index 857710e77775..aabc67a20ce5 100644
--- a/fs/btrfs/sysfs.h
+++ b/fs/btrfs/sysfs.h
@@ -93,6 +93,8 @@ int btrfs_sysfs_add_fsid(struct btrfs_fs_devices *fs_devs,
 				struct kobject *parent);
 int btrfs_sysfs_add_device(struct btrfs_fs_devices *fs_devs);
 void btrfs_sysfs_remove_fsid(struct btrfs_fs_devices *fs_devs);
+void btrfs_sysfs_update_sprout_fsid(struct btrfs_fs_devices *fs_devices,
+				    const u8 *fsid);
 void btrfs_sysfs_feature_update(struct btrfs_fs_info *fs_info,
 		u64 bit, enum btrfs_feature_set set);
 void btrfs_kobject_uevent(struct block_device *bdev, enum kobject_action action);
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index bc20e01f2f93..d32eaffbbcef 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -2680,22 +2680,14 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
 	}
 
 	if (seeding_dev) {
-		char fsid_buf[BTRFS_UUID_UNPARSED_SIZE];
-
 		ret = btrfs_finish_sprout(trans);
 		if (ret) {
 			btrfs_abort_transaction(trans, ret);
 			goto error_sysfs;
 		}
 
-		/* Sprouting would change fsid of the mounted root,
-		 * so rename the fsid on the sysfs
-		 */
-		snprintf(fsid_buf, BTRFS_UUID_UNPARSED_SIZE, "%pU",
-						fs_info->fs_devices->fsid);
-		if (kobject_rename(&fs_devices->fsid_kobj, fsid_buf))
-			btrfs_warn(fs_info,
-				   "sysfs: failed to create fsid for sprout");
+		btrfs_sysfs_update_sprout_fsid(fs_devices,
+				fs_info->fs_devices->fsid);
 	}
 
 	ret = btrfs_commit_transaction(trans);
-- 
2.22.0

