Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62CE7212411
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Jul 2020 15:04:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729049AbgGBNEV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Jul 2020 09:04:21 -0400
Received: from mx2.suse.de ([195.135.220.15]:43516 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726343AbgGBNEV (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 2 Jul 2020 09:04:21 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id DC459AC6E;
        Thu,  2 Jul 2020 13:04:19 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 8/8] btrfs: sysfs: Add bdi link to the fsid dir
Date:   Thu,  2 Jul 2020 15:23:35 +0300
Message-Id: <20200702122335.9117-9-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200702122335.9117-1-nborisov@suse.com>
References: <20200702122335.9117-1-nborisov@suse.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Since BTRFS uses a private bdi it makes sense to create a link to this
bdi under /sys/fs/btrfs/<UUID>/bdi. This allows size of read ahead to
be controlled. Without this patch it's not possible to uniquely identify
which bdi pertains to which btrfs filesystem in the fase of multiple
btrfs filesystem.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/ctree.h |  2 ++
 fs/btrfs/sysfs.c | 16 ++++++++++++++--
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 4dd478b4fe3a..eb61f89e9e85 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -928,6 +928,8 @@ struct btrfs_fs_info {
 	u32 sectorsize;
 	u32 stripesize;
 
+	bool bdi_link_created;
+
 	/* Block groups and devices containing active swapfiles. */
 	spinlock_t swapfile_pins_lock;
 	struct rb_root swapfile_pins;
diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index 5885abe57c3e..e167ec584627 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -937,8 +937,13 @@ void btrfs_sysfs_remove_fsid(struct btrfs_fs_devices *fs_devs)
 
 void btrfs_sysfs_remove_mounted(struct btrfs_fs_info *fs_info)
 {
+	struct kobject *fsid_kobj = &fs_info->fs_devices->fsid_kobj;
+
 	btrfs_reset_fs_info_ptr(fs_info);
 
+	if (fs_info->bdi_link_created)
+		sysfs_remove_link(fsid_kobj, "bdi");
+
 	if (fs_info->space_info_kobj) {
 		sysfs_remove_files(fs_info->space_info_kobj, allocation_attrs);
 		kobject_del(fs_info->space_info_kobj);
@@ -958,8 +963,8 @@ void btrfs_sysfs_remove_mounted(struct btrfs_fs_info *fs_info)
 	}
 #endif
 	addrm_unknown_feature_attrs(fs_info, false);
-	sysfs_remove_group(&fs_info->fs_devices->fsid_kobj, &btrfs_feature_attr_group);
-	sysfs_remove_files(&fs_info->fs_devices->fsid_kobj, btrfs_attrs);
+	sysfs_remove_group(fsid_kobj, &btrfs_feature_attr_group);
+	sysfs_remove_files(fsid_kobj, btrfs_attrs);
 	btrfs_sysfs_remove_devices_dir(fs_info->fs_devices, NULL);
 }
 
@@ -1410,6 +1415,13 @@ int btrfs_sysfs_add_mounted(struct btrfs_fs_info *fs_info)
 	if (error)
 		goto failure;
 
+	error = sysfs_create_link(fsid_kobj, &fs_info->sb->s_bdi->dev->kobj,
+				  "bdi");
+	if (error)
+		goto failure;
+
+	fs_info->bdi_link_created = true;
+
 #ifdef CONFIG_BTRFS_DEBUG
 	fs_info->debug_kobj = kobject_create_and_add("debug", fsid_kobj);
 	if (!fs_info->debug_kobj) {
-- 
2.17.1

