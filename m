Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F37737FB40
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Aug 2019 15:40:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436514AbfHBNjr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 2 Aug 2019 09:39:47 -0400
Received: from mx2.suse.de ([195.135.220.15]:60096 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2436507AbfHBNjq (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 2 Aug 2019 09:39:46 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id BD8B3B62C
        for <linux-btrfs@vger.kernel.org>; Fri,  2 Aug 2019 13:39:45 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id A2F86DADC0; Fri,  2 Aug 2019 15:40:19 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 08/13] btrfs: factor out sysfs code for sending device uevent
Date:   Fri,  2 Aug 2019 15:40:19 +0200
Message-Id: <74407f83f95e5186bcb547fbdfda471dc192fc8b.1564752900.git.dsterba@suse.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <cover.1564752900.git.dsterba@suse.com>
References: <cover.1564752900.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The device uevent belongs to the sysfs API.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/sysfs.c   | 11 +++++++++++
 fs/btrfs/sysfs.h   |  1 +
 fs/btrfs/volumes.c | 13 -------------
 3 files changed, 12 insertions(+), 13 deletions(-)

diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index 0d37403a4733..0f7e97ceec4e 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -902,6 +902,17 @@ int btrfs_sysfs_add_device_link(struct btrfs_fs_devices *fs_devices,
 	return error;
 }
 
+void btrfs_kobject_uevent(struct block_device *bdev, enum kobject_action action)
+{
+	int ret;
+
+	ret = kobject_uevent(&disk_to_dev(bdev->bd_disk)->kobj, action);
+	if (ret)
+		pr_warn("BTRFS: Sending event '%d' to kobject: '%s' (%p): failed\n",
+			action, kobject_name(&disk_to_dev(bdev->bd_disk)->kobj),
+			&disk_to_dev(bdev->bd_disk)->kobj);
+}
+
 /* /sys/fs/btrfs/ entry */
 static struct kset *btrfs_kset;
 
diff --git a/fs/btrfs/sysfs.h b/fs/btrfs/sysfs.h
index f17faa5d5264..371fa9db5bbd 100644
--- a/fs/btrfs/sysfs.h
+++ b/fs/btrfs/sysfs.h
@@ -95,6 +95,7 @@ int btrfs_sysfs_add_device(struct btrfs_fs_devices *fs_devs);
 void btrfs_sysfs_remove_fsid(struct btrfs_fs_devices *fs_devs);
 void btrfs_sysfs_feature_update(struct btrfs_fs_info *fs_info,
 		u64 bit, enum btrfs_feature_set set);
+void btrfs_kobject_uevent(struct block_device *bdev, enum kobject_action action);
 
 int __init btrfs_init_sysfs(void);
 void __cold btrfs_exit_sysfs(void);
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index f85bbc819ab6..bc20e01f2f93 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -358,19 +358,6 @@ static void free_fs_devices(struct btrfs_fs_devices *fs_devices)
 	kfree(fs_devices);
 }
 
-static void btrfs_kobject_uevent(struct block_device *bdev,
-				 enum kobject_action action)
-{
-	int ret;
-
-	ret = kobject_uevent(&disk_to_dev(bdev->bd_disk)->kobj, action);
-	if (ret)
-		pr_warn("BTRFS: Sending event '%d' to kobject: '%s' (%p): failed\n",
-			action,
-			kobject_name(&disk_to_dev(bdev->bd_disk)->kobj),
-			&disk_to_dev(bdev->bd_disk)->kobj);
-}
-
 void __exit btrfs_cleanup_fs_uuids(void)
 {
 	struct btrfs_fs_devices *fs_devices;
-- 
2.22.0

