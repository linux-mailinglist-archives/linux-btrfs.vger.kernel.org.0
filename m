Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C422213601
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Jul 2020 10:13:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726286AbgGCINT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 3 Jul 2020 04:13:19 -0400
Received: from mx2.suse.de ([195.135.220.15]:44354 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725764AbgGCINS (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 3 Jul 2020 04:13:18 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 10001B5E7;
        Fri,  3 Jul 2020 08:13:18 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH v2] btrfs: sysfs: Add bdi link to the fsid dir
Date:   Fri,  3 Jul 2020 11:13:15 +0300
Message-Id: <20200703081315.11824-1-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200702122335.9117-9-nborisov@suse.com>
References: <20200702122335.9117-9-nborisov@suse.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Since BTRFS uses a private bdi it makes sense to create a link to this
bdi under /sys/fs/btrfs/<UUID>/bdi. This allows size of read ahead to
be controlled. Without this patch it's not possible to uniquely identify
which bdi pertains to which btrfs filesystem in the fase of multiple
btrfs filesystem.

It's fine to simply call sysfs_remove_link without checking if the
link indeed has been created. The call path
sysfs_remove_link
 kernfs_remove_by_name
  kernfs_remove_by_name_ns

Will simply return -ENOENT in case it doesn't exist.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---

V2: Remove variable signalling whether the 'bdi' symlinkn is created. Turns out
it's not really neede for proper error handling.

 fs/btrfs/sysfs.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index 5885abe57c3e..e766bfecd874 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -937,8 +937,12 @@ void btrfs_sysfs_remove_fsid(struct btrfs_fs_devices *fs_devs)

 void btrfs_sysfs_remove_mounted(struct btrfs_fs_info *fs_info)
 {
+	struct kobject *fsid_kobj = &fs_info->fs_devices->fsid_kobj;
+
 	btrfs_reset_fs_info_ptr(fs_info);

+	sysfs_remove_link(fsid_kobj, "bdi");
+
 	if (fs_info->space_info_kobj) {
 		sysfs_remove_files(fs_info->space_info_kobj, allocation_attrs);
 		kobject_del(fs_info->space_info_kobj);
@@ -958,8 +962,8 @@ void btrfs_sysfs_remove_mounted(struct btrfs_fs_info *fs_info)
 	}
 #endif
 	addrm_unknown_feature_attrs(fs_info, false);
-	sysfs_remove_group(&fs_info->fs_devices->fsid_kobj, &btrfs_feature_attr_group);
-	sysfs_remove_files(&fs_info->fs_devices->fsid_kobj, btrfs_attrs);
+	sysfs_remove_group(fsid_kobj, &btrfs_feature_attr_group);
+	sysfs_remove_files(fsid_kobj, btrfs_attrs);
 	btrfs_sysfs_remove_devices_dir(fs_info->fs_devices, NULL);
 }

@@ -1439,6 +1443,11 @@ int btrfs_sysfs_add_mounted(struct btrfs_fs_info *fs_info)
 	if (error)
 		goto failure;

+	error = sysfs_create_link(fsid_kobj, &fs_info->sb->s_bdi->dev->kobj,
+				  "bdi");
+	if (error)
+		goto failure;
+
 	fs_info->space_info_kobj = kobject_create_and_add("allocation",
 						  fsid_kobj);
 	if (!fs_info->space_info_kobj) {
--
2.17.1

