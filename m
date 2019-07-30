Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F71B7AF02
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Jul 2019 19:09:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729599AbfG3RJk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 30 Jul 2019 13:09:40 -0400
Received: from mx2.suse.de ([195.135.220.15]:41778 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729502AbfG3RJi (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 30 Jul 2019 13:09:38 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 67C4FAD08
        for <linux-btrfs@vger.kernel.org>; Tue, 30 Jul 2019 17:09:37 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 629A2DA808; Tue, 30 Jul 2019 19:10:12 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 2/2] btrfs: delete debugfs code
Date:   Tue, 30 Jul 2019 19:10:12 +0200
Message-Id: <dfdd7cdaa0e85eb57dea16823c16f6040d64c72b.1564505777.git.dsterba@suse.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <cover.1564505777.git.dsterba@suse.com>
References: <cover.1564505777.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Replaced by the sysfs exports that provide a more fine grained interface
for filesystem debugging.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/sysfs.c | 36 ------------------------------------
 fs/btrfs/sysfs.h |  5 -----
 2 files changed, 41 deletions(-)

diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index 6eef46556d75..db9fa801ec2d 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -9,7 +9,6 @@
 #include <linux/completion.h>
 #include <linux/kobject.h>
 #include <linux/bug.h>
-#include <linux/debugfs.h>
 
 #include "ctree.h"
 #include "disk-io.h"
@@ -826,12 +825,6 @@ int btrfs_sysfs_add_device_link(struct btrfs_fs_devices *fs_devices,
 /* /sys/fs/btrfs/ entry */
 static struct kset *btrfs_kset;
 
-/* /sys/kernel/debug/btrfs */
-static struct dentry *btrfs_debugfs_root_dentry;
-
-/* Debugging tunables and exported data */
-u64 btrfs_debugfs_test;
-
 /*
  * Can be called by the device discovery thread.
  * And parent can be specified for seed device
@@ -937,28 +930,6 @@ void btrfs_sysfs_feature_update(struct btrfs_fs_info *fs_info,
 	ret = sysfs_create_group(fsid_kobj, &btrfs_feature_attr_group);
 }
 
-static int btrfs_init_debugfs(void)
-{
-#ifdef CONFIG_DEBUG_FS
-	btrfs_debugfs_root_dentry = debugfs_create_dir("btrfs", NULL);
-	if (!btrfs_debugfs_root_dentry)
-		return -ENOMEM;
-
-	/*
-	 * Example code, how to export data through debugfs.
-	 *
-	 * file:        /sys/kernel/debug/btrfs/test
-	 * contents of: btrfs_debugfs_test
-	 */
-#ifdef CONFIG_BTRFS_DEBUG
-	debugfs_create_u64("test", S_IRUGO | S_IWUSR, btrfs_debugfs_root_dentry,
-			&btrfs_debugfs_test);
-#endif
-
-#endif
-	return 0;
-}
-
 int __init btrfs_init_sysfs(void)
 {
 	int ret;
@@ -967,10 +938,6 @@ int __init btrfs_init_sysfs(void)
 	if (!btrfs_kset)
 		return -ENOMEM;
 
-	ret = btrfs_init_debugfs();
-	if (ret)
-		goto out1;
-
 	init_feature_attrs();
 	ret = sysfs_create_group(&btrfs_kset->kobj, &btrfs_feature_attr_group);
 	if (ret)
@@ -991,8 +958,6 @@ int __init btrfs_init_sysfs(void)
 out_remove_group:
 	sysfs_remove_group(&btrfs_kset->kobj, &btrfs_feature_attr_group);
 out2:
-	debugfs_remove_recursive(btrfs_debugfs_root_dentry);
-out1:
 	kset_unregister(btrfs_kset);
 
 	return ret;
@@ -1004,6 +969,5 @@ void __cold btrfs_exit_sysfs(void)
 			    &btrfs_static_feature_attr_group);
 	sysfs_remove_group(&btrfs_kset->kobj, &btrfs_feature_attr_group);
 	kset_unregister(btrfs_kset);
-	debugfs_remove_recursive(btrfs_debugfs_root_dentry);
 }
 
diff --git a/fs/btrfs/sysfs.h b/fs/btrfs/sysfs.h
index 40716b357c1d..4bb4fe96d4bd 100644
--- a/fs/btrfs/sysfs.h
+++ b/fs/btrfs/sysfs.h
@@ -3,11 +3,6 @@
 #ifndef BTRFS_SYSFS_H
 #define BTRFS_SYSFS_H
 
-/*
- * Data exported through sysfs
- */
-extern u64 btrfs_debugfs_test;
-
 enum btrfs_feature_set {
 	FEAT_COMPAT,
 	FEAT_COMPAT_RO,
-- 
2.22.0

