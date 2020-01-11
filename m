Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 47943137B65
	for <lists+linux-btrfs@lfdr.de>; Sat, 11 Jan 2020 05:42:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728371AbgAKEm3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 10 Jan 2020 23:42:29 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:33382 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728324AbgAKEm2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 10 Jan 2020 23:42:28 -0500
Received: by mail-qt1-f195.google.com with SMTP id d5so4030946qto.0;
        Fri, 10 Jan 2020 20:42:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0VIVO5I9jB0tobLGREUfwsqsbqPrK58MyM1+n6J4HcU=;
        b=NfNA6jVGvl5Im8tu8yBiWrG7qnoyuBIikHbbx4mO82q72tsspww7fpOQ5PgqTaFTH3
         PrHp616lWV/2BZyym7Bv+dokxxTAu5mL7T/qkeJqeLfPIh6U29N7y0xnBRHvpbFmnvUw
         jntsruaxouhWXW0vYzzPM7sgEYj2pSsT+1Eck9NRnMxv0HWXQvMm6Q3heZDWsP5TZObB
         MljNoNVPMIYb+2mQmhWgSVypBPxWvE30p5wfPE9KRw0rk3pN9KuDpEvwAmFaRBi4fxUU
         tGJGwS+e9zqmTv6A2rr6OPDbZbZOnG0r2Yheg1RAskbEvnUr9fBgJ7qpErEoA5YTyRxH
         67mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0VIVO5I9jB0tobLGREUfwsqsbqPrK58MyM1+n6J4HcU=;
        b=IrgSKZPyoRg1R1KwRaKTrC8SUkv0jOnlOZWbmYvUcWjqVE4nSH5pgRFAFUgL7XJieJ
         8vjqDf3ww1J5fVqzSe+GrEqgeqljo3JhVNL6chTwqOf/Iq82WH+PEjf/0NhLLvso8CXR
         Jv4CQeKbWTsey1v/IMY2C3ZKLj28m0I61VkSJKTI42B8Q+l4YrCyF+SIfYQdzPcXlzCM
         hONU3iAxSwB2PmBoxwT0+elTw0kXLyXXKNw36yDhHGaJ3WA1Y/ij+Lu1w8B/8NtiIWRs
         EWzvs4NoR74n8MpM0C5dAbdJUmwbwBllhcPIlNTqdmR9pciGyjQU+nGq/QjepkwKPm6D
         xyDQ==
X-Gm-Message-State: APjAAAXfGU4H8eHU7GDKMxAbZEdNdVMYe6vwqvE7v9Bu8BkoeTPgBtIF
        ZG2Q7E6jcewP1N1249GPdNmL7w7L
X-Google-Smtp-Source: APXvYqwsA4Zh9qyFtavcl+YlYGo56/xPgq6dAb2UfN2GhDqIgz/E8gm3c496TBQgpNsM6DdmGd1X6Q==
X-Received: by 2002:aed:2022:: with SMTP id 31mr1554709qta.321.1578717747359;
        Fri, 10 Jan 2020 20:42:27 -0800 (PST)
Received: from localhost.localdomain (200.146.48.138.dynamic.dialup.gvt.net.br. [200.146.48.138])
        by smtp.gmail.com with ESMTPSA id s20sm1861162qkg.131.2020.01.10.20.42.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2020 20:42:26 -0800 (PST)
From:   Marcos Paulo de Souza <marcos.souza.org@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     dsterba@suse.com, linux-btrfs@vger.kernel.org,
        Marcos Paulo de Souza <mpdesouza@suse.com>, wqu@suse.com,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH 2/2] btrfs: Introduce new BTRFS_IOC_SNAP_DESTROY_V2 ioctl
Date:   Sat, 11 Jan 2020 01:39:42 -0300
Message-Id: <20200111043942.15366-3-marcos.souza.org@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200111043942.15366-1-marcos.souza.org@gmail.com>
References: <20200111043942.15366-1-marcos.souza.org@gmail.com>
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

Also in this patch, add BTRFS_SUBVOL_DELETE_BY_ID flag and add subvolid
as a union member of fd in struct btrfs_ioctl_vol_args_v2.

Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
---
 fs/btrfs/ctree.h           |  8 ++++++
 fs/btrfs/export.c          |  4 +--
 fs/btrfs/ioctl.c           | 53 ++++++++++++++++++++++++++++++++++++++
 fs/btrfs/super.c           |  2 +-
 include/uapi/linux/btrfs.h | 12 +++++++--
 5 files changed, 74 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 569931dd0ce5..421a2f57f9ec 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -3010,6 +3010,8 @@ int btrfs_defrag_leaves(struct btrfs_trans_handle *trans,
 int btrfs_parse_options(struct btrfs_fs_info *info, char *options,
 			unsigned long new_flags);
 int btrfs_sync_fs(struct super_block *sb, int wait);
+char *get_subvol_name_from_objectid(struct btrfs_fs_info *fs_info,
+					   u64 subvol_objectid);
 
 static inline __printf(2, 3) __cold
 void btrfs_no_printk(const struct btrfs_fs_info *fs_info, const char *fmt, ...)
@@ -3442,6 +3444,12 @@ int btrfs_reada_wait(void *handle);
 void btrfs_reada_detach(void *handle);
 int btree_readahead_hook(struct extent_buffer *eb, int err);
 
+/* export.c */
+struct dentry *btrfs_get_dentry(struct super_block *sb, u64 objectid,
+				       u64 root_objectid, u32 generation,
+				       int check_generation);
+struct dentry *btrfs_get_parent(struct dentry *child);
+
 static inline int is_fstree(u64 rootid)
 {
 	if (rootid == BTRFS_FS_TREE_OBJECTID ||
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
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index dcceae4c5d28..68da45ad4904 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -2960,6 +2960,57 @@ static noinline int btrfs_ioctl_snap_destroy(struct file *file,
 	return err;
 }
 
+static noinline int btrfs_ioctl_snap_destroy_v2(struct file *file,
+					     void __user *arg)
+{
+	struct btrfs_fs_info *fs_info = btrfs_sb(file->f_path.dentry->d_sb);
+	struct dentry *dentry, *pdentry;
+	struct btrfs_ioctl_vol_args_v2 *vol_args;
+	char *name, *p;
+	size_t namelen;
+	int err = 0;
+
+	vol_args = memdup_user(arg, sizeof(*vol_args));
+	if (IS_ERR(vol_args))
+		return PTR_ERR(vol_args);
+
+	if (vol_args->subvolid == 0)
+		return -EINVAL;
+
+	if (!(vol_args->flags & BTRFS_SUBVOL_DELETE_BY_ID))
+		return -EINVAL;
+
+	dentry = btrfs_get_dentry(fs_info->sb, BTRFS_FIRST_FREE_OBJECTID,
+				vol_args->subvolid, 0, 0);
+	if (IS_ERR(dentry)) {
+		err = PTR_ERR(dentry);
+		return err;
+	}
+
+	pdentry = btrfs_get_parent(dentry);
+	if (IS_ERR(pdentry)) {
+		err = PTR_ERR(pdentry);
+		goto out_dentry;
+	}
+
+	name = get_subvol_name_from_objectid(fs_info, vol_args->subvolid);
+	if (IS_ERR(name)) {
+		err = PTR_ERR(name);
+		goto out_pdentry;
+	}
+	p = (char *)kbasename(name);
+	namelen = strlen(p);
+
+	err = btrfs_subvolume_deleter(file, pdentry, p, namelen);
+
+	kfree(name);
+out_pdentry:
+	dput(pdentry);
+out_dentry:
+	dput(dentry);
+	return err;
+}
+
 static int btrfs_ioctl_defrag(struct file *file, void __user *argp)
 {
 	struct inode *inode = file_inode(file);
@@ -5465,6 +5516,8 @@ long btrfs_ioctl(struct file *file, unsigned int
 		return btrfs_ioctl_snap_create_v2(file, argp, 1);
 	case BTRFS_IOC_SNAP_DESTROY:
 		return btrfs_ioctl_snap_destroy(file, argp);
+	case BTRFS_IOC_SNAP_DESTROY_V2:
+		return btrfs_ioctl_snap_destroy_v2(file, argp);
 	case BTRFS_IOC_SUBVOL_GETFLAGS:
 		return btrfs_ioctl_subvol_getflags(file, argp);
 	case BTRFS_IOC_SUBVOL_SETFLAGS:
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index a906315efd19..a448d2bb93e6 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -1024,7 +1024,7 @@ static int btrfs_parse_subvol_options(const char *options, char **subvol_name,
 	return error;
 }
 
-static char *get_subvol_name_from_objectid(struct btrfs_fs_info *fs_info,
+char *get_subvol_name_from_objectid(struct btrfs_fs_info *fs_info,
 					   u64 subvol_objectid)
 {
 	struct btrfs_root *root = fs_info->tree_root;
diff --git a/include/uapi/linux/btrfs.h b/include/uapi/linux/btrfs.h
index 7a8bc8b920f5..1be03082e49a 100644
--- a/include/uapi/linux/btrfs.h
+++ b/include/uapi/linux/btrfs.h
@@ -42,11 +42,14 @@ struct btrfs_ioctl_vol_args {
 
 #define BTRFS_DEVICE_SPEC_BY_ID		(1ULL << 3)
 
+#define BTRFS_SUBVOL_DELETE_BY_ID	(1ULL << 4)
+
 #define BTRFS_VOL_ARG_V2_FLAGS_SUPPORTED		\
 			(BTRFS_SUBVOL_CREATE_ASYNC |	\
 			BTRFS_SUBVOL_RDONLY |		\
 			BTRFS_SUBVOL_QGROUP_INHERIT |	\
-			BTRFS_DEVICE_SPEC_BY_ID)
+			BTRFS_DEVICE_SPEC_BY_ID |	\
+			BTRFS_SUBVOL_DELETE_BY_ID)
 
 #define BTRFS_FSID_SIZE 16
 #define BTRFS_UUID_SIZE 16
@@ -108,7 +111,10 @@ struct btrfs_ioctl_qgroup_limit_args {
  */
 
 struct btrfs_ioctl_vol_args_v2 {
-	__s64 fd;
+	union {
+		__s64 fd;
+		__u64 subvolid;
+	};
 	__u64 transid;
 	__u64 flags;
 	union {
@@ -949,5 +955,7 @@ enum btrfs_err_code {
 				struct btrfs_ioctl_get_subvol_rootref_args)
 #define BTRFS_IOC_INO_LOOKUP_USER _IOWR(BTRFS_IOCTL_MAGIC, 62, \
 				struct btrfs_ioctl_ino_lookup_user_args)
+#define BTRFS_IOC_SNAP_DESTROY_V2 _IOW(BTRFS_IOCTL_MAGIC, 63, \
+				struct btrfs_ioctl_vol_args_v2)
 
 #endif /* _UAPI_LINUX_BTRFS_H */
-- 
2.24.0

