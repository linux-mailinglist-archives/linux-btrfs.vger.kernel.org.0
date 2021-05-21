Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99A4938C951
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 May 2021 16:38:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230477AbhEUOkG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 21 May 2021 10:40:06 -0400
Received: from mx2.suse.de ([195.135.220.15]:45680 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230239AbhEUOkF (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 21 May 2021 10:40:05 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1621607921; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=ri04k4+vnOkspJouKn6TBKMB5kxTzjn7GZZTbSH0dJ8=;
        b=hS+kOK1V+Jxgm55H47Wb3Ac/jCR+Gu6wggsGFlrfaMCfi41YE2At9Z4C8lr3R1C3boe2NF
        rnU9Mk85CatbGyWf8BduauwziJEOKsw9ZraWbNXnSSDhWJce4Xeq3cUzYDOejRpRR+BBmL
        domAJl00aBIXjAzUszAuvUxE1nYN12E=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C75A0AAA6;
        Fri, 21 May 2021 14:38:41 +0000 (UTC)
From:   Marcos Paulo de Souza <mpdesouza@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.com, wqu@suse.com,
        Marcos Paulo de Souza <mpdesouza@suse.com>
Subject: [PATCH] btrfs: Add new flag to rescan quota after subvolume creation
Date:   Fri, 21 May 2021 11:38:11 -0300
Message-Id: <20210521143811.16227-1-mpdesouza@suse.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Adding a new subvolume/snapshot makes the qgroup data inconsistent, so
add a new flag to inform the subvolume ioctl to do a quota rescan right
after the subvolume/snapshot creation.

Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
---

 This is an attempt to help snapper to create snapshots with 'timeline'
 cleanup-policy to keep the qgroup data consistent after a new snapshot is
 created.

 Please let me know if you know a better place to add this functionality.

 fs/btrfs/ioctl.c           | 58 +++++++++++++++++++++++++++++---------
 include/uapi/linux/btrfs.h |  8 ++++--
 2 files changed, 51 insertions(+), 15 deletions(-)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 5dc2fd843ae3..64b4aa744486 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -1704,6 +1704,22 @@ static noinline int btrfs_ioctl_resize(struct file *file,
 	return ret;
 }
 
+static long do_quota_rescan(struct file *file)
+{
+	struct inode *inode = file_inode(file);
+	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
+	int ret;
+
+	ret = mnt_want_write_file(file);
+	if (ret)
+		return ret;
+
+	ret = btrfs_qgroup_rescan(fs_info);
+
+	mnt_drop_write_file(file);
+	return ret;
+}
+
 static noinline int __btrfs_ioctl_snap_create(struct file *file,
 				const char *name, unsigned long fd, int subvol,
 				bool readonly,
@@ -1793,6 +1809,7 @@ static noinline int btrfs_ioctl_snap_create_v2(struct file *file,
 	struct btrfs_ioctl_vol_args_v2 *vol_args;
 	int ret;
 	bool readonly = false;
+	bool quota_rescan = false;
 	struct btrfs_qgroup_inherit *inherit = NULL;
 
 	if (!S_ISDIR(file_inode(file)->i_mode))
@@ -1808,6 +1825,15 @@ static noinline int btrfs_ioctl_snap_create_v2(struct file *file,
 		goto free_args;
 	}
 
+	if (vol_args->flags & BTRFS_SUBVOL_QGROUP_RESCAN) {
+		if (!capable(CAP_SYS_ADMIN)) {
+			ret = -EPERM;
+			goto free_args;
+		}
+
+		quota_rescan = true;
+	}
+
 	if (vol_args->flags & BTRFS_SUBVOL_RDONLY)
 		readonly = true;
 	if (vol_args->flags & BTRFS_SUBVOL_QGROUP_INHERIT) {
@@ -1843,6 +1869,22 @@ static noinline int btrfs_ioctl_snap_create_v2(struct file *file,
 					subvol, readonly, inherit);
 	if (ret)
 		goto free_inherit;
+
+	if (quota_rescan) {
+		ret = do_quota_rescan(file);
+		/*
+		 * EINVAL is returned if quota is not enabled. There is already
+		 * a warning issued if quota rescan is started when quota is not
+		 * enabled, so skip a warning here if it is the case.
+		 */
+		if (ret < 0 && ret != -EINVAL)
+			btrfs_warn(btrfs_sb(file_inode(file)->i_sb),
+		"Couldn't execute quota rescan after snapshot creation: %d",
+					ret);
+		else
+			ret = 0;
+	}
+
 free_inherit:
 	kfree(inherit);
 free_args:
@@ -4277,35 +4319,25 @@ static long btrfs_ioctl_qgroup_limit(struct file *file, void __user *arg)
 
 static long btrfs_ioctl_quota_rescan(struct file *file, void __user *arg)
 {
-	struct inode *inode = file_inode(file);
-	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
 	struct btrfs_ioctl_quota_rescan_args *qsa;
 	int ret;
 
 	if (!capable(CAP_SYS_ADMIN))
 		return -EPERM;
 
-	ret = mnt_want_write_file(file);
-	if (ret)
-		return ret;
-
 	qsa = memdup_user(arg, sizeof(*qsa));
-	if (IS_ERR(qsa)) {
-		ret = PTR_ERR(qsa);
-		goto drop_write;
-	}
+	if (IS_ERR(qsa))
+		return PTR_ERR(qsa);
 
 	if (qsa->flags) {
 		ret = -EINVAL;
 		goto out;
 	}
 
-	ret = btrfs_qgroup_rescan(fs_info);
+	ret = do_quota_rescan(file);
 
 out:
 	kfree(qsa);
-drop_write:
-	mnt_drop_write_file(file);
 	return ret;
 }
 
diff --git a/include/uapi/linux/btrfs.h b/include/uapi/linux/btrfs.h
index 5df73001aad4..8779aa4b3aad 100644
--- a/include/uapi/linux/btrfs.h
+++ b/include/uapi/linux/btrfs.h
@@ -47,11 +47,14 @@ struct btrfs_ioctl_vol_args {
 
 #define BTRFS_SUBVOL_SPEC_BY_ID	(1ULL << 4)
 
+#define BTRFS_SUBVOL_QGROUP_RESCAN	(1ULL << 5)
+
 #define BTRFS_VOL_ARG_V2_FLAGS_SUPPORTED		\
 			(BTRFS_SUBVOL_RDONLY |		\
 			BTRFS_SUBVOL_QGROUP_INHERIT |	\
 			BTRFS_DEVICE_SPEC_BY_ID |	\
-			BTRFS_SUBVOL_SPEC_BY_ID)
+			BTRFS_SUBVOL_SPEC_BY_ID |	\
+			BTRFS_SUBVOL_QGROUP_RESCAN)
 
 #define BTRFS_FSID_SIZE 16
 #define BTRFS_UUID_SIZE 16
@@ -119,7 +122,8 @@ struct btrfs_ioctl_qgroup_limit_args {
 /* Supported flags for BTRFS_IOC_SNAP_CREATE_V2 and BTRFS_IOC_SUBVOL_CREATE_V2 */
 #define BTRFS_SUBVOL_CREATE_ARGS_MASK					\
 	 (BTRFS_SUBVOL_RDONLY |						\
-	 BTRFS_SUBVOL_QGROUP_INHERIT)
+	 BTRFS_SUBVOL_QGROUP_INHERIT |					\
+	 BTRFS_SUBVOL_QGROUP_RESCAN)
 
 /* Supported flags for BTRFS_IOC_SNAP_DESTROY_V2 */
 #define BTRFS_SUBVOL_DELETE_ARGS_MASK					\
-- 
2.26.2

