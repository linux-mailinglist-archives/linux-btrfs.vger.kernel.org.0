Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B26F184A92
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Mar 2020 16:23:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726779AbgCMPXZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 13 Mar 2020 11:23:25 -0400
Received: from mx2.suse.de ([195.135.220.15]:42170 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726676AbgCMPXY (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 13 Mar 2020 11:23:24 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 5F60DADEE;
        Fri, 13 Mar 2020 15:23:23 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 1/3] btrfs: Remove BTRFS_SUBVOL_CREATE_ASYNC support
Date:   Fri, 13 Mar 2020 17:23:18 +0200
Message-Id: <20200313152320.22723-2-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200313152320.22723-1-nborisov@suse.com>
References: <20200313152320.22723-1-nborisov@suse.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This functionality was deprecated in kernel 5.4. Since no one has
complained of the impending removal it's time we did so.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/ioctl.c           | 25 +------------------------
 include/uapi/linux/btrfs.h |  7 ++-----
 2 files changed, 3 insertions(+), 29 deletions(-)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index bdc3a6bab904..af1be567fec7 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -1818,8 +1818,6 @@ static noinline int btrfs_ioctl_snap_create_v2(struct file *file,
 {
 	struct btrfs_ioctl_vol_args_v2 *vol_args;
 	int ret;
-	u64 transid = 0;
-	u64 *ptr = NULL;
 	bool readonly = false;
 	struct btrfs_qgroup_inherit *inherit = NULL;
 
@@ -1836,15 +1834,6 @@ static noinline int btrfs_ioctl_snap_create_v2(struct file *file,
 		goto free_args;
 	}
 
-	if (vol_args->flags & BTRFS_SUBVOL_CREATE_ASYNC) {
-		struct inode *inode = file_inode(file);
-		struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
-
-		btrfs_warn(fs_info,
-"SNAP_CREATE_V2 ioctl with CREATE_ASYNC is deprecated and will be removed in kernel 5.7");
-
-		ptr = &transid;
-	}
 	if (vol_args->flags & BTRFS_SUBVOL_RDONLY)
 		readonly = true;
 	if (vol_args->flags & BTRFS_SUBVOL_QGROUP_INHERIT) {
@@ -1860,17 +1849,10 @@ static noinline int btrfs_ioctl_snap_create_v2(struct file *file,
 	}
 
 	ret = btrfs_ioctl_snap_create_transid(file, vol_args->name,
-					      vol_args->fd, subvol, ptr,
+					      vol_args->fd, subvol, NULL,
 					      readonly, inherit);
 	if (ret)
 		goto free_inherit;
-
-	if (ptr && copy_to_user(arg +
-				offsetof(struct btrfs_ioctl_vol_args_v2,
-					transid),
-				ptr, sizeof(*ptr)))
-		ret = -EFAULT;
-
 free_inherit:
 	kfree(inherit);
 free_args:
@@ -1930,11 +1912,6 @@ static noinline int btrfs_ioctl_subvol_setflags(struct file *file,
 		goto out_drop_write;
 	}
 
-	if (flags & BTRFS_SUBVOL_CREATE_ASYNC) {
-		ret = -EINVAL;
-		goto out_drop_write;
-	}
-
 	if (flags & ~BTRFS_SUBVOL_RDONLY) {
 		ret = -EOPNOTSUPP;
 		goto out_drop_write;
diff --git a/include/uapi/linux/btrfs.h b/include/uapi/linux/btrfs.h
index b5f3ea36d3cb..ed9c9612a5b4 100644
--- a/include/uapi/linux/btrfs.h
+++ b/include/uapi/linux/btrfs.h
@@ -36,7 +36,6 @@ struct btrfs_ioctl_vol_args {
 #define BTRFS_DEVICE_PATH_NAME_MAX	1024
 #define BTRFS_SUBVOL_NAME_MAX 		4039
 
-#define BTRFS_SUBVOL_CREATE_ASYNC	(1ULL << 0)
 #define BTRFS_SUBVOL_RDONLY		(1ULL << 1)
 #define BTRFS_SUBVOL_QGROUP_INHERIT	(1ULL << 2)
 
@@ -45,8 +44,7 @@ struct btrfs_ioctl_vol_args {
 #define BTRFS_SUBVOL_SPEC_BY_ID	(1ULL << 4)
 
 #define BTRFS_VOL_ARG_V2_FLAGS_SUPPORTED		\
-			(BTRFS_SUBVOL_CREATE_ASYNC |	\
-			BTRFS_SUBVOL_RDONLY |		\
+			(BTRFS_SUBVOL_RDONLY |		\
 			BTRFS_SUBVOL_QGROUP_INHERIT |	\
 			BTRFS_DEVICE_SPEC_BY_ID |	\
 			BTRFS_SUBVOL_SPEC_BY_ID)
@@ -116,8 +114,7 @@ struct btrfs_ioctl_qgroup_limit_args {
 
 /* Supported flags for BTRFS_IOC_SNAP_CREATE_V2 and BTRFS_IOC_SUBVOL_CREATE_V2 */
 #define BTRFS_SUBVOL_CREATE_ARGS_MASK					\
-	(BTRFS_SUBVOL_CREATE_ASYNC |					\
-	 BTRFS_SUBVOL_RDONLY |						\
+	 (BTRFS_SUBVOL_RDONLY |						\
 	 BTRFS_SUBVOL_QGROUP_INHERIT)
 
 /* Supported flags for BTRFS_IOC_SNAP_DESTROY_V2 */
-- 
2.17.1

