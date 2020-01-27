Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 91B60149E4A
	for <lists+linux-btrfs@lfdr.de>; Mon, 27 Jan 2020 03:45:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbgA0Cpx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 26 Jan 2020 21:45:53 -0500
Received: from mail-qk1-f171.google.com ([209.85.222.171]:37101 "EHLO
        mail-qk1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726545AbgA0Cpx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 26 Jan 2020 21:45:53 -0500
Received: by mail-qk1-f171.google.com with SMTP id 21so8294384qky.4;
        Sun, 26 Jan 2020 18:45:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JHx4gcRlC1UzIsD5o65xFwW8PkRe4Nc60Ki5EvZDHZc=;
        b=vSGO2+Rgs3KK/3OBBFScTnP4fI0StO8a4Zp9XwuUaP7ENQ8B6kALlVW+HMPsmmJ7c8
         CP1eSL2eMkHKStmw5ZRlvzvts1kPDLxPfE+m+bT0lAQNgrrardKlyFbPNNdNIrFxAljb
         1eAtqljcULExg/oASTx35K7qi2yJdkO/CDuTC+CP57lduQbUCUJ80DNik1liq6OeINJ0
         BBsPZ+s0LTDWmgk5AfKEEbnV1CQ55RAfnvnC+uYMQ30jOfNuYh6oo/2KgXBTkVJwpZNT
         Fhzx+d29Bc7pgYQL9AVH1GspxxwkWAZVfd9obqe4x3otnPWW62kSu8ewkurZ7Y25BfDP
         KzpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JHx4gcRlC1UzIsD5o65xFwW8PkRe4Nc60Ki5EvZDHZc=;
        b=gbOUUkCjzHjk+ZBoWxFyYbMimY8ATdQulJ9IXUtT6Kj08xI+foPF+jCrT0IgiOdMwc
         E5pM15ifjp1hA761M12eF1DFc0ZrDiJETjqWkHjcWxKJk1unc8WclyjcX78ltzLIkjMA
         o8w7MVpriXqmZNMZ6IItxGmxs6/ruRqjVXuWONziPizeE8rldcaxQB5aOt4/b+cz5Xg8
         b7eXVihNis1Re/2XTzoGgXnXufumx3dFX9J1qD9Ph65ym7gLR8A5KKcTy2DOWz4cTtrG
         Y8EOosFHx5/e4zW93jIMcX6vsTiaSAcj2fb8I1I7hygwZ8vdQfm3gJoRTqG870j034eS
         vO7g==
X-Gm-Message-State: APjAAAXtVNkQd3VJuQolzvq/CM03Y1u97uZTT51w2DN0fFMq5wzitwc3
        V0OIpAd24eQq8xMcb2DRw22GMoZz
X-Google-Smtp-Source: APXvYqw/GjIJqzyFcO4j9RstlOUCQdR7vpEfs5faY1DXE4p2dwNQCkQ+BuJAdn9PcbNa6IjR0uFIFg==
X-Received: by 2002:a37:354:: with SMTP id 81mr14851869qkd.276.1580093151127;
        Sun, 26 Jan 2020 18:45:51 -0800 (PST)
Received: from localhost.localdomain (200.146.53.109.dynamic.dialup.gvt.net.br. [200.146.53.109])
        by smtp.gmail.com with ESMTPSA id x3sm9166552qts.35.2020.01.26.18.45.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jan 2020 18:45:50 -0800 (PST)
From:   Marcos Paulo de Souza <marcos.souza.org@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     dsterba@suse.com, josef@toxicpanda.com,
        linux-btrfs@vger.kernel.org,
        Marcos Paulo de Souza <mpdesouza@suse.com>
Subject: [PATCHv2] btrfs: Introduce new BTRFS_IOC_SNAP_DESTROY_V2 ioctl
Date:   Sun, 26 Jan 2020 23:48:17 -0300
Message-Id: <20200127024817.15587-1-marcos.souza.org@gmail.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Marcos Paulo de Souza <mpdesouza@suse.com>

This ioctl will be responsible for deleting a subvolume using it's id.
This can be used when a system has a file system mounted from a
subvolume, rather than the root file system, like below:

/
|- @subvol1
|- @subvol2
\- @subvol_default
If only @subvol_default is mounted, we have no path to reach
@subvol1 and @subvol2, thus no way to delete them.
This patch introduces a new flag to allow BTRFS_IOC_SNAP_DESTORY_V2
to delete subvolume using subvolid.

Also in this patch, export some functions, add BTRFS_SUBVOL_BY_ID flag
and add subvolid as a union member of name in struct btrfs_ioctl_vol_args_v2.

Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
---
 Changes from v1:
 * make btrfs_ioctl_snap_destroy handle both SNAP_DESTROY and SNAP_DESTROY_V2
   (suggested by Josef)
 * Change BTRFS_SUBVOL_DELETE_BY_ID to BTRFS_SUBVOL_BY_ID (David)
 * Send patches for btrfs-progs and xfstests along this change

 fs/btrfs/ctree.h           |  2 +
 fs/btrfs/export.c          |  4 +-
 fs/btrfs/export.h          |  5 ++
 fs/btrfs/ioctl.c           | 97 +++++++++++++++++++++++++++++++-------
 fs/btrfs/super.c           |  4 +-
 include/uapi/linux/btrfs.h | 12 ++++-
 6 files changed, 101 insertions(+), 23 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index f90b82050d2d..5847a34b5146 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -3010,6 +3010,8 @@ int btrfs_defrag_leaves(struct btrfs_trans_handle *trans,
 int btrfs_parse_options(struct btrfs_fs_info *info, char *options,
 			unsigned long new_flags);
 int btrfs_sync_fs(struct super_block *sb, int wait);
+char *btrfs_get_subvol_name_from_objectid(struct btrfs_fs_info *fs_info,
+					   u64 subvol_objectid);
 
 static inline __printf(2, 3) __cold
 void btrfs_no_printk(const struct btrfs_fs_info *fs_info, const char *fmt, ...)
diff --git a/fs/btrfs/export.c b/fs/btrfs/export.c
index 72e312cae69d..027411cdbae7 100644
--- a/fs/btrfs/export.c
+++ b/fs/btrfs/export.c
@@ -57,7 +57,7 @@ static int btrfs_encode_fh(struct inode *inode, u32 *fh, int *max_len,
 	return type;
 }
 
-static struct dentry *btrfs_get_dentry(struct super_block *sb, u64 objectid,
+struct dentry *btrfs_get_dentry(struct super_block *sb, u64 objectid,
 				       u64 root_objectid, u32 generation,
 				       int check_generation)
 {
@@ -152,7 +152,7 @@ static struct dentry *btrfs_fh_to_dentry(struct super_block *sb, struct fid *fh,
 	return btrfs_get_dentry(sb, objectid, root_objectid, generation, 1);
 }
 
-static struct dentry *btrfs_get_parent(struct dentry *child)
+struct dentry *btrfs_get_parent(struct dentry *child)
 {
 	struct inode *dir = d_inode(child);
 	struct btrfs_fs_info *fs_info = btrfs_sb(dir->i_sb);
diff --git a/fs/btrfs/export.h b/fs/btrfs/export.h
index 57488ecd7d4e..f981e8103d64 100644
--- a/fs/btrfs/export.h
+++ b/fs/btrfs/export.h
@@ -18,4 +18,9 @@ struct btrfs_fid {
 	u64 parent_root_objectid;
 } __attribute__ ((packed));
 
+struct dentry *btrfs_get_dentry(struct super_block *sb, u64 objectid,
+				       u64 root_objectid, u32 generation,
+				       int check_generation);
+struct dentry *btrfs_get_parent(struct dentry *child);
+
 #endif
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 1b1b6ff855aa..889cb43149f9 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -28,6 +28,7 @@
 #include <linux/iversion.h>
 #include "ctree.h"
 #include "disk-io.h"
+#include "export.h"
 #include "transaction.h"
 #include "btrfs_inode.h"
 #include "print-tree.h"
@@ -2836,7 +2837,8 @@ static int btrfs_ioctl_get_subvol_rootref(struct file *file, void __user *argp)
 }
 
 static noinline int btrfs_ioctl_snap_destroy(struct file *file,
-					     void __user *arg)
+					     void __user *arg,
+					     bool destroy_v2)
 {
 	struct dentry *parent = file->f_path.dentry;
 	struct btrfs_fs_info *fs_info = btrfs_sb(parent->d_sb);
@@ -2845,34 +2847,87 @@ static noinline int btrfs_ioctl_snap_destroy(struct file *file,
 	struct inode *inode;
 	struct btrfs_root *root = BTRFS_I(dir)->root;
 	struct btrfs_root *dest = NULL;
-	struct btrfs_ioctl_vol_args *vol_args;
+	struct btrfs_ioctl_vol_args *vol_args = NULL;
+	struct btrfs_ioctl_vol_args_v2 *vol_args2 = NULL;
+	char *name, *name_ptr = NULL;
 	int namelen;
 	int err = 0;
 
-	if (!S_ISDIR(dir->i_mode))
-		return -ENOTDIR;
+	if (destroy_v2) {
+		vol_args2 = memdup_user(arg, sizeof(*vol_args2));
+		if (IS_ERR(vol_args2))
+			return PTR_ERR(vol_args2);
 
-	vol_args = memdup_user(arg, sizeof(*vol_args));
-	if (IS_ERR(vol_args))
-		return PTR_ERR(vol_args);
+		if (vol_args2->subvolid == 0) {
+			err = -EINVAL;
+			goto out;
+		}
 
-	vol_args->name[BTRFS_PATH_NAME_MAX] = '\0';
-	namelen = strlen(vol_args->name);
-	if (strchr(vol_args->name, '/') ||
-	    strncmp(vol_args->name, "..", namelen) == 0) {
-		err = -EINVAL;
-		goto out;
+		if (!(vol_args2->flags & BTRFS_SUBVOL_BY_ID)) {
+			err = -EINVAL;
+			goto out;
+		}
+
+		dentry = btrfs_get_dentry(fs_info->sb, BTRFS_FIRST_FREE_OBJECTID,
+					vol_args2->subvolid, 0, 0);
+		if (IS_ERR(dentry)) {
+			err = PTR_ERR(dentry);
+			goto out;
+		}
+
+		/* 
+		 * change the default parent since the subvolume being deleted
+		 * can be outside of the current mount point
+		 */
+		parent = btrfs_get_parent(dentry);
+
+		/* 
+		 * the only use of dentry was to get the parent, so we can
+		 * release it now. Later on the dentry will be queried again to
+		 * make sure the dentry will reside in the dentry cache
+		 */
+		dput(dentry);
+		if (IS_ERR(parent)) {
+			err = PTR_ERR(parent);
+			goto out;
+		}
+		dir = d_inode(parent);
+
+		name_ptr = btrfs_get_subvol_name_from_objectid(fs_info, vol_args2->subvolid);
+		if (IS_ERR(name_ptr)) {
+			err = PTR_ERR(name_ptr);
+			goto free_parent;
+		}
+		name = (char *)kbasename(name_ptr);
+		namelen = strlen(name);
+	} else {
+		vol_args = memdup_user(arg, sizeof(*vol_args));
+		if (IS_ERR(vol_args))
+			return PTR_ERR(vol_args);
+
+		vol_args->name[BTRFS_PATH_NAME_MAX] = '\0';
+		namelen = strlen(vol_args->name);
+		if (strchr(vol_args->name, '/') ||
+		    strncmp(vol_args->name, "..", namelen) == 0) {
+			err = -EINVAL;
+			goto out;
+		}
+		name = vol_args->name;
+	}
+
+	if (!S_ISDIR(dir->i_mode)) {
+		err = -ENOTDIR;
+		goto free_subvol_name;
 	}
 
 	err = mnt_want_write_file(file);
 	if (err)
-		goto out;
-
+		goto free_subvol_name;
 
 	err = down_write_killable_nested(&dir->i_rwsem, I_MUTEX_PARENT);
 	if (err == -EINTR)
 		goto out_drop_write;
-	dentry = lookup_one_len(vol_args->name, parent, namelen);
+	dentry = lookup_one_len(name, parent, namelen);
 	if (IS_ERR(dentry)) {
 		err = PTR_ERR(dentry);
 		goto out_unlock_dir;
@@ -2943,7 +2998,13 @@ static noinline int btrfs_ioctl_snap_destroy(struct file *file,
 	inode_unlock(dir);
 out_drop_write:
 	mnt_drop_write_file(file);
+free_subvol_name:
+	kfree(name_ptr);
+free_parent:
+	if (destroy_v2)
+		dput(parent);
 out:
+	kfree(vol_args2);
 	kfree(vol_args);
 	return err;
 }
@@ -5464,7 +5525,9 @@ long btrfs_ioctl(struct file *file, unsigned int
 	case BTRFS_IOC_SUBVOL_CREATE_V2:
 		return btrfs_ioctl_snap_create_v2(file, argp, 1);
 	case BTRFS_IOC_SNAP_DESTROY:
-		return btrfs_ioctl_snap_destroy(file, argp);
+		return btrfs_ioctl_snap_destroy(file, argp, false);
+	case BTRFS_IOC_SNAP_DESTROY_V2:
+		return btrfs_ioctl_snap_destroy(file, argp, true);
 	case BTRFS_IOC_SUBVOL_GETFLAGS:
 		return btrfs_ioctl_subvol_getflags(file, argp);
 	case BTRFS_IOC_SUBVOL_SETFLAGS:
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index a906315efd19..4a8ce475d906 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -1024,7 +1024,7 @@ static int btrfs_parse_subvol_options(const char *options, char **subvol_name,
 	return error;
 }
 
-static char *get_subvol_name_from_objectid(struct btrfs_fs_info *fs_info,
+char *btrfs_get_subvol_name_from_objectid(struct btrfs_fs_info *fs_info,
 					   u64 subvol_objectid)
 {
 	struct btrfs_root *root = fs_info->tree_root;
@@ -1438,7 +1438,7 @@ static struct dentry *mount_subvol(const char *subvol_name, u64 subvol_objectid,
 				goto out;
 			}
 		}
-		subvol_name = get_subvol_name_from_objectid(btrfs_sb(mnt->mnt_sb),
+		subvol_name = btrfs_get_subvol_name_from_objectid(btrfs_sb(mnt->mnt_sb),
 							    subvol_objectid);
 		if (IS_ERR(subvol_name)) {
 			root = ERR_CAST(subvol_name);
diff --git a/include/uapi/linux/btrfs.h b/include/uapi/linux/btrfs.h
index 7a8bc8b920f5..d8619245f0dc 100644
--- a/include/uapi/linux/btrfs.h
+++ b/include/uapi/linux/btrfs.h
@@ -42,11 +42,14 @@ struct btrfs_ioctl_vol_args {
 
 #define BTRFS_DEVICE_SPEC_BY_ID		(1ULL << 3)
 
+#define BTRFS_SUBVOL_BY_ID	(1ULL << 4)
+
 #define BTRFS_VOL_ARG_V2_FLAGS_SUPPORTED		\
 			(BTRFS_SUBVOL_CREATE_ASYNC |	\
 			BTRFS_SUBVOL_RDONLY |		\
 			BTRFS_SUBVOL_QGROUP_INHERIT |	\
-			BTRFS_DEVICE_SPEC_BY_ID)
+			BTRFS_DEVICE_SPEC_BY_ID |	\
+			BTRFS_SUBVOL_BY_ID)
 
 #define BTRFS_FSID_SIZE 16
 #define BTRFS_UUID_SIZE 16
@@ -119,7 +122,10 @@ struct btrfs_ioctl_vol_args_v2 {
 		__u64 unused[4];
 	};
 	union {
-		char name[BTRFS_SUBVOL_NAME_MAX + 1];
+		union {
+			char name[BTRFS_SUBVOL_NAME_MAX + 1];
+			__u64 subvolid;
+		};
 		__u64 devid;
 	};
 };
@@ -949,5 +955,7 @@ enum btrfs_err_code {
 				struct btrfs_ioctl_get_subvol_rootref_args)
 #define BTRFS_IOC_INO_LOOKUP_USER _IOWR(BTRFS_IOCTL_MAGIC, 62, \
 				struct btrfs_ioctl_ino_lookup_user_args)
+#define BTRFS_IOC_SNAP_DESTROY_V2 _IOW(BTRFS_IOCTL_MAGIC, 63, \
+				struct btrfs_ioctl_vol_args_v2)
 
 #endif /* _UAPI_LINUX_BTRFS_H */
-- 
2.24.0

