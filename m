Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5ED4C3D5787
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Jul 2021 12:29:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232902AbhGZJsy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 26 Jul 2021 05:48:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:35676 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232900AbhGZJsx (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 26 Jul 2021 05:48:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 305C860F22;
        Mon, 26 Jul 2021 10:29:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627295362;
        bh=3/h3UunTvPtsiyAxQ52cCP1o3Jyzr1Yu0sPuuzDtCuU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mVYA/9MoYDnAyRagNR3b0wHLsSF3bR/zDek+FjswNQx8jIVbXskMTXjjcIvXKAKiz
         7eBPNQ/xP7haHPRvfrmbWwu+S1YjhBUtueoj1QncVoBDLF9d860d20CcB8W6Jxvjkd
         zpSOnSJY/FZhL+3pWQHdqiRopfFfutkUfwYrFRgGcgqmqJ1QfkjVyS30RfIpBqTTDV
         9HBPDz69Th2DKYbxvM0ZUshNlwDvPDuoMXEABkLM6IKRdh1oRHRlIjNa8Kx7cWoKEY
         Kb563pI7LLadnoxCb1/4riQfnT1cP3vvFUgXT+TgufMP9GKEPwou51Z6bc5fZsUCFF
         JmLPKSx/z+nfA==
From:   Christian Brauner <brauner@kernel.org>
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, linux-btrfs@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: [PATCH v3 13/21] btrfs/inode: allow idmapped BTRFS_IOC_{SNAP,SUBVOL}_CREATE{_V2} ioctl
Date:   Mon, 26 Jul 2021 12:28:08 +0200
Message-Id: <20210726102816.612434-14-brauner@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210726102816.612434-1-brauner@kernel.org>
References: <20210726102816.612434-1-brauner@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=8241; h=from:subject; bh=9Wd0kCZFzhhH9Sjv9j2wc2z46o0nh4d7g45KrcsD2RI=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMST86zOJSnYUuzGXo6V58vIbNeFxt72cJsRIiz3KjQzZNVf5 v1xmRykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwESK7zIyLM4Tvt0T8Gr/w6lSz39knH 3Wu8oj4Wz2/Flde9Pnb6n+0MDIsNtTRNKbR2lW2UWtM9bpUnGnIlLb9O8uMGjbvS0vPzuOEwA=
X-Developer-Key: i=christian.brauner@ubuntu.com; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Christian Brauner <christian.brauner@ubuntu.com>

Creating subvolumes and snapshots is one of the core features of btrfs and is
even available to unprivileged users. Make it possible to use subvolume and
snapshot creation on idmapped mounts. This is a fairly straightforward
operation since all the permission checking helpers are already capable of
handling idmapped mounts. So we just need to pass down the mount's userns.

Cc: Chris Mason <clm@fb.com>
Cc: Josef Bacik <josef@toxicpanda.com>
Cc: Christoph Hellwig <hch@infradead.org>
Cc: David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
/* v2 */
unchanged

/* v3 */
unchanged
---
 fs/btrfs/ctree.h |  3 ++-
 fs/btrfs/inode.c |  5 +++--
 fs/btrfs/ioctl.c | 48 ++++++++++++++++++++++++++++--------------------
 3 files changed, 33 insertions(+), 23 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index e5e53e592d4f..ee1876571b3f 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -3145,7 +3145,8 @@ int btrfs_set_extent_delalloc(struct btrfs_inode *inode, u64 start, u64 end,
 			      struct extent_state **cached_state);
 int btrfs_create_subvol_root(struct btrfs_trans_handle *trans,
 			     struct btrfs_root *new_root,
-			     struct btrfs_root *parent_root);
+			     struct btrfs_root *parent_root,
+			     struct user_namespace *mnt_userns);
  void btrfs_set_delalloc_extent(struct inode *inode, struct extent_state *state,
 			       unsigned *bits);
 void btrfs_clear_delalloc_extent(struct inode *inode,
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 5e0b8e394ae1..30e22c6f83a3 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -8940,7 +8940,8 @@ static int btrfs_truncate(struct inode *inode, bool skip_writeback)
  */
 int btrfs_create_subvol_root(struct btrfs_trans_handle *trans,
 			     struct btrfs_root *new_root,
-			     struct btrfs_root *parent_root)
+			     struct btrfs_root *parent_root,
+			     struct user_namespace *mnt_userns)
 {
 	struct inode *inode;
 	int err;
@@ -8951,7 +8952,7 @@ int btrfs_create_subvol_root(struct btrfs_trans_handle *trans,
 	if (err < 0)
 		return err;
 
-	inode = btrfs_new_inode(trans, new_root, &init_user_ns, NULL, "..", 2,
+	inode = btrfs_new_inode(trans, new_root, mnt_userns, NULL, "..", 2,
 				ino, ino,
 				S_IFDIR | (~current_umask() & S_IRWXUGO),
 				&index);
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 7a6a886df7c4..be52891ba571 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -492,8 +492,8 @@ int __pure btrfs_is_empty_uuid(u8 *uuid)
 	return 1;
 }
 
-static noinline int create_subvol(struct inode *dir,
-				  struct dentry *dentry,
+static noinline int create_subvol(struct user_namespace *mnt_userns,
+				  struct inode *dir, struct dentry *dentry,
 				  const char *name, int namelen,
 				  struct btrfs_qgroup_inherit *inherit)
 {
@@ -638,7 +638,7 @@ static noinline int create_subvol(struct inode *dir,
 		goto fail;
 	}
 
-	ret = btrfs_create_subvol_root(trans, new_root, root);
+	ret = btrfs_create_subvol_root(trans, new_root, root, mnt_userns);
 	btrfs_put_root(new_root);
 	if (ret) {
 		/* We potentially lose an unused inode item here */
@@ -864,15 +864,16 @@ static int btrfs_may_delete(struct inode *dir, struct dentry *victim, int isdir)
 }
 
 /* copy of may_create in fs/namei.c() */
-static inline int btrfs_may_create(struct inode *dir, struct dentry *child)
+static inline int btrfs_may_create(struct user_namespace *mnt_userns,
+				   struct inode *dir, struct dentry *child)
 {
 	if (d_really_is_positive(child))
 		return -EEXIST;
 	if (IS_DEADDIR(dir))
 		return -ENOENT;
-	if (!fsuidgid_has_mapping(dir->i_sb, &init_user_ns))
+	if (!fsuidgid_has_mapping(dir->i_sb, mnt_userns))
 		return -EOVERFLOW;
-	return inode_permission(&init_user_ns, dir, MAY_WRITE | MAY_EXEC);
+	return inode_permission(mnt_userns, dir, MAY_WRITE | MAY_EXEC);
 }
 
 /*
@@ -881,6 +882,7 @@ static inline int btrfs_may_create(struct inode *dir, struct dentry *child)
  * inside this filesystem so it's quite a bit simpler.
  */
 static noinline int btrfs_mksubvol(const struct path *parent,
+				   struct user_namespace *mnt_userns,
 				   const char *name, int namelen,
 				   struct btrfs_root *snap_src,
 				   bool readonly,
@@ -895,12 +897,13 @@ static noinline int btrfs_mksubvol(const struct path *parent,
 	if (error == -EINTR)
 		return error;
 
-	dentry = lookup_one_len(name, parent->dentry, namelen);
+	dentry = lookup_mapped_one_len(mnt_userns, name,
+				       parent->dentry, namelen);
 	error = PTR_ERR(dentry);
 	if (IS_ERR(dentry))
 		goto out_unlock;
 
-	error = btrfs_may_create(dir, dentry);
+	error = btrfs_may_create(mnt_userns, dir, dentry);
 	if (error)
 		goto out_dput;
 
@@ -922,7 +925,7 @@ static noinline int btrfs_mksubvol(const struct path *parent,
 	if (snap_src)
 		error = create_snapshot(snap_src, dir, dentry, readonly, inherit);
 	else
-		error = create_subvol(dir, dentry, name, namelen, inherit);
+		error = create_subvol(mnt_userns, dir, dentry, name, namelen, inherit);
 
 	if (!error)
 		fsnotify_mkdir(dir, dentry);
@@ -936,6 +939,7 @@ static noinline int btrfs_mksubvol(const struct path *parent,
 }
 
 static noinline int btrfs_mksnapshot(const struct path *parent,
+				   struct user_namespace *mnt_userns,
 				   const char *name, int namelen,
 				   struct btrfs_root *root,
 				   bool readonly,
@@ -965,7 +969,7 @@ static noinline int btrfs_mksnapshot(const struct path *parent,
 
 	btrfs_wait_ordered_extents(root, U64_MAX, 0, (u64)-1);
 
-	ret = btrfs_mksubvol(parent, name, namelen,
+	ret = btrfs_mksubvol(parent, mnt_userns, name, namelen,
 			     root, readonly, inherit);
 out:
 	if (snapshot_force_cow)
@@ -1794,6 +1798,7 @@ static noinline int btrfs_ioctl_resize(struct file *file,
 }
 
 static noinline int __btrfs_ioctl_snap_create(struct file *file,
+				struct user_namespace *mnt_userns,
 				const char *name, unsigned long fd, int subvol,
 				bool readonly,
 				struct btrfs_qgroup_inherit *inherit)
@@ -1821,8 +1826,8 @@ static noinline int __btrfs_ioctl_snap_create(struct file *file,
 	}
 
 	if (subvol) {
-		ret = btrfs_mksubvol(&file->f_path, name, namelen,
-				     NULL, readonly, inherit);
+		ret = btrfs_mksubvol(&file->f_path, mnt_userns, name,
+				     namelen, NULL, readonly, inherit);
 	} else {
 		struct fd src = fdget(fd);
 		struct inode *src_inode;
@@ -1836,16 +1841,17 @@ static noinline int __btrfs_ioctl_snap_create(struct file *file,
 			btrfs_info(BTRFS_I(file_inode(file))->root->fs_info,
 				   "Snapshot src from another FS");
 			ret = -EXDEV;
-		} else if (!inode_owner_or_capable(&init_user_ns, src_inode)) {
+		} else if (!inode_owner_or_capable(mnt_userns, src_inode)) {
 			/*
 			 * Subvolume creation is not restricted, but snapshots
 			 * are limited to own subvolumes only
 			 */
 			ret = -EPERM;
 		} else {
-			ret = btrfs_mksnapshot(&file->f_path, name, namelen,
-					     BTRFS_I(src_inode)->root,
-					     readonly, inherit);
+			ret = btrfs_mksnapshot(&file->f_path, mnt_userns,
+					       name, namelen,
+					       BTRFS_I(src_inode)->root,
+					       readonly, inherit);
 		}
 		fdput(src);
 	}
@@ -1869,8 +1875,9 @@ static noinline int btrfs_ioctl_snap_create(struct file *file,
 		return PTR_ERR(vol_args);
 	vol_args->name[BTRFS_PATH_NAME_MAX] = '\0';
 
-	ret = __btrfs_ioctl_snap_create(file, vol_args->name, vol_args->fd,
-					subvol, false, NULL);
+	ret = __btrfs_ioctl_snap_create(file, file_mnt_user_ns(file),
+					vol_args->name, vol_args->fd, subvol,
+					false, NULL);
 
 	kfree(vol_args);
 	return ret;
@@ -1928,8 +1935,9 @@ static noinline int btrfs_ioctl_snap_create_v2(struct file *file,
 		}
 	}
 
-	ret = __btrfs_ioctl_snap_create(file, vol_args->name, vol_args->fd,
-					subvol, readonly, inherit);
+	ret = __btrfs_ioctl_snap_create(file, file_mnt_user_ns(file),
+					vol_args->name, vol_args->fd, subvol,
+					readonly, inherit);
 	if (ret)
 		goto free_inherit;
 free_inherit:
-- 
2.30.2

