Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40EB33D73B8
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Jul 2021 12:51:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236427AbhG0KvE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 27 Jul 2021 06:51:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:56210 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236455AbhG0KvC (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 27 Jul 2021 06:51:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 01F7860F59;
        Tue, 27 Jul 2021 10:51:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627383063;
        bh=ZVdEwxARCnwrtv8KR7Uv/W3jGp+1li1RIDemiy1dWck=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gqgRAt0R2LK12Q4WIjMU5Vtmf0rsQP4VP8Wbhtl+eHxyPQq021+ypQbSKoEBu6Q7e
         mfkQidEYTfKCykEYUrxvgw9g90pxl8ACVaOO/7MKHcpOcttbHiE8BRkb69RYzmn1jS
         Erxjif4O1RAvDPy7oLw2AR/QGe6YxIVFqs3uFnkfYNOWcGJ7vtLpjtFUcVkkN55Xi6
         yjC8H0Iqs0Lr0GmML6QR1+gsuOTDYtK96qV0Cb5LwaRQSfALExRjGI++Q8/GXyt3kD
         iyugAFcMBHs8iErtzbk79USpDUUO9FWFxBsE5mubsZJhJ7nrfeKaGdI64VvH6AuMhQ
         v7VrTm0eLMLYQ==
From:   Christian Brauner <brauner@kernel.org>
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, linux-btrfs@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Christoph Hellwig <hch@infradead.org>, Qu Wenruo <wqu@suse.com>
Subject: [PATCH v4 14/21] btrfs/ioctl: allow idmapped BTRFS_IOC_SNAP_DESTROY{_V2} ioctl
Date:   Tue, 27 Jul 2021 12:48:53 +0200
Message-Id: <20210727104900.829215-15-brauner@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210727104900.829215-1-brauner@kernel.org>
References: <20210727104900.829215-1-brauner@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=8052; h=from:subject; bh=XDvcdhsUgM9IEU8Jd1xYGomj1Lq1mSRLnB//SXLofQU=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMST8fzLV/kTX6v83v9+/c2jzdXUWa0aLz4t2cT7/LXx8pocw k8d2vo5SFgYxLgZZMUUWh3aTcLnlPBWbjTI1YOawMoEMYeDiFICJRN9h+O8y306/SHCvXGHkQ3XLuy se3nJW7z3M3L36opRpzIFt5lsY/vCxGIYxbF1qL/xWK3evAsfik+o+6/ZGnL/+Y80vqxvWJvwA
X-Developer-Key: i=christian.brauner@ubuntu.com; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Christian Brauner <christian.brauner@ubuntu.com>

Destroying subvolumes and snapshots are important features of btrfs. Both
operations are available to unprivileged users if the filesystem has been
mounted with the "user_subvol_rm_allowed" mount option. Allow subvolume and
snapshot deletion on idmapped mounts. This is a fairly straightforward
operation since all the permission checking helpers are already capable of
handling idmapped mounts. So we just need to pass down the mount's userns.

Subvolumes and snapshots can either be deleted by specifying their name or - if
BTRFS_IOC_SNAP_DESTROY_V2 is used - by their subvolume or snapshot id if the
BTRFS_SUBVOL_SPEC_BY_ID is set.

This feature is blocked on idmapped mounts as this allows filesystem wide
subvolume deletions and thus can escape the scope of what's exposed under the
mount identified by the fd passed with the ioctl.

As David correctly pointed out this means that even the root or CAP_SYS_ADMIN
capable user can't delete a subvolume via BTRFS_SUBVOL_SPEC_BY_ID. This is
intentional. The root user is currently already subject to permission checks in
btrfs_may_delete() including whether the inode's i_uid/i_gid of the directory
the subvolume is located in have a mapping in the caller's idmapping. For this
to fail isn't currently possible since a btrfs filesystem can't be mounted with
a non-initial idmapping but it shows that even the root user would fail to
delete a subvolume if the relevant inode isn't mapped in their idmapping. The
idmapped mount case is the same in principle.

This isn't a huge problem a root user wanting to delete arbitrary subvolumes
can just always create another (even detached) mount without an idmapping
attached.

In addition, we will allow BTRFS_SUBVOL_SPEC_BY_ID for cases where the
subvolume to delete is directly located under inode referenced by the fd passed
for the ioctl() in a follow-up commit.

Here is an example where a btrfs subvolume is deleted through a subvolume mount
that does not expose the subvolume to be delete but it can still be deleted by
using the subvolume id:

 /* Compile the following program as "delete_by_spec". */

 #define _GNU_SOURCE
 #include <fcntl.h>
 #include <inttypes.h>
 #include <linux/btrfs.h>
 #include <stdio.h>
 #include <stdlib.h>
 #include <sys/ioctl.h>
 #include <sys/stat.h>
 #include <sys/types.h>
 #include <unistd.h>

 static int rm_subvolume_by_id(int fd, uint64_t subvolid)
 {
 	struct btrfs_ioctl_vol_args_v2 args = {};
 	int ret;

 	args.flags = BTRFS_SUBVOL_SPEC_BY_ID;
 	args.subvolid = subvolid;

 	ret = ioctl(fd, BTRFS_IOC_SNAP_DESTROY_V2, &args);
 	if (ret < 0)
 		return -1;

 	return 0;
 }

 int main(int argc, char *argv[])
 {
 	int subvolid = 0;

 	if (argc < 3)
 		exit(1);

 	fprintf(stderr, "Opening %s\n", argv[1]);
 	int fd = open(argv[1], O_CLOEXEC | O_DIRECTORY);
 	if (fd < 0)
 		exit(2);

 	subvolid = atoi(argv[2]);

 	fprintf(stderr, "Deleting subvolume with subvolid %d\n", subvolid);
 	int ret = rm_subvolume_by_id(fd, subvolid);
 	if (ret < 0)
 		exit(3);

 	exit(0);
 }
 #include <stdio.h>"
 #include <stdlib.h>"
 #include <linux/btrfs.h"

 truncate -s 10G btrfs.img
 mkfs.btrfs btrfs.img
 export LOOPDEV=$(sudo losetup -f --show btrfs.img)
 mount ${LOOPDEV} /mnt
 sudo chown $(id -u):$(id -g) /mnt
 btrfs subvolume create /mnt/A
 btrfs subvolume create /mnt/B/C
 # Get subvolume id via:
 sudo btrfs subvolume show /mnt/A
 # Save subvolid
 SUBVOLID=<nr>
 sudo umount /mnt
 sudo mount ${LOOPDEV} -o subvol=B/C,user_subvol_rm_allowed /mnt
 ./delete_by_spec /mnt ${SUBVOLID}

With idmapped mounts this can potentially be used by users to delete
subvolumes/snapshots they would otherwise not have access to as the idmapping
would be applied to an inode that is not exposed in the mount of the subvolume.

The fact that this is a filesystem wide operation suggests it might be a good
idea to expose this under a separate ioctl that clearly indicates this. In
essence, the file descriptor passed with the ioctl is merely used to identify
the filesystem on which to operate when BTRFS_SUBVOL_SPEC_BY_ID is used.

Cc: Chris Mason <clm@fb.com>
Cc: Josef Bacik <josef@toxicpanda.com>
Cc: Christoph Hellwig <hch@infradead.org>
Cc: David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
/* v2 */
unchanged

/* v3 */
- Christian Brauner <christian.brauner@ubuntu.com>:
  - Explain the restriction for the BTRFS_SUBVOL_SPEC_BY_ID flag in detail.k

- David Sterba <dsterba@suse.com>:
  - Replace the -EINVAL return value for BTRFS_SUBVOL_SPEC_BY_ID deletion
    requests with a more sensible one such as -EXDEV or -EOPNOTSUPP.

/* v4 */
non-semantical changes
---
 fs/btrfs/ioctl.c | 26 ++++++++++++++++++++------
 1 file changed, 20 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index bb4bda3bba98..6295c9c6fc3e 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -830,7 +830,8 @@ static int create_snapshot(struct btrfs_root *root, struct inode *dir,
  *     nfs_async_unlink().
  */
 
-static int btrfs_may_delete(struct inode *dir, struct dentry *victim, int isdir)
+static int btrfs_may_delete(struct user_namespace *mnt_userns,
+			    struct inode *dir, struct dentry *victim, int isdir)
 {
 	int error;
 
@@ -840,12 +841,12 @@ static int btrfs_may_delete(struct inode *dir, struct dentry *victim, int isdir)
 	BUG_ON(d_inode(victim->d_parent) != dir);
 	audit_inode_child(dir, victim, AUDIT_TYPE_CHILD_DELETE);
 
-	error = inode_permission(&init_user_ns, dir, MAY_WRITE | MAY_EXEC);
+	error = inode_permission(mnt_userns, dir, MAY_WRITE | MAY_EXEC);
 	if (error)
 		return error;
 	if (IS_APPEND(dir))
 		return -EPERM;
-	if (check_sticky(&init_user_ns, dir, d_inode(victim)) ||
+	if (check_sticky(mnt_userns, dir, d_inode(victim)) ||
 	    IS_APPEND(d_inode(victim)) || IS_IMMUTABLE(d_inode(victim)) ||
 	    IS_SWAPFILE(d_inode(victim)))
 		return -EPERM;
@@ -2914,6 +2915,7 @@ static noinline int btrfs_ioctl_snap_destroy(struct file *file,
 	struct btrfs_root *dest = NULL;
 	struct btrfs_ioctl_vol_args *vol_args = NULL;
 	struct btrfs_ioctl_vol_args_v2 *vol_args2 = NULL;
+	struct user_namespace *mnt_userns = file_mnt_user_ns(file);
 	char *subvol_name, *subvol_name_ptr = NULL;
 	int subvol_namelen;
 	int err = 0;
@@ -2941,6 +2943,18 @@ static noinline int btrfs_ioctl_snap_destroy(struct file *file,
 			if (err)
 				goto out;
 		} else {
+			/*
+			 * Deleting by subvolume id can be used to delete
+			 * subvolumes/snapshots anywhere in the filesystem.
+			 * Ensure that users can't abuse idmapped mounts of
+			 * btrfs subvolumes/snapshots to perform operations in
+			 * the whole filesystem.
+			 */
+			if (mnt_userns != &init_user_ns) {
+				err = -EOPNOTSUPP;
+				goto out;
+			}
+
 			if (vol_args2->subvolid < BTRFS_FIRST_FREE_OBJECTID) {
 				err = -EINVAL;
 				goto out;
@@ -3025,7 +3039,7 @@ static noinline int btrfs_ioctl_snap_destroy(struct file *file,
 	err = down_write_killable_nested(&dir->i_rwsem, I_MUTEX_PARENT);
 	if (err == -EINTR)
 		goto free_subvol_name;
-	dentry = lookup_one_len(subvol_name, parent, subvol_namelen);
+	dentry = lookup_one(mnt_userns, subvol_name, parent, subvol_namelen);
 	if (IS_ERR(dentry)) {
 		err = PTR_ERR(dentry);
 		goto out_unlock_dir;
@@ -3067,14 +3081,14 @@ static noinline int btrfs_ioctl_snap_destroy(struct file *file,
 		if (root == dest)
 			goto out_dput;
 
-		err = inode_permission(&init_user_ns, inode,
+		err = inode_permission(mnt_userns, inode,
 				       MAY_WRITE | MAY_EXEC);
 		if (err)
 			goto out_dput;
 	}
 
 	/* check if subvolume may be deleted by a user */
-	err = btrfs_may_delete(dir, dentry, 1);
+	err = btrfs_may_delete(mnt_userns, dir, dentry, 1);
 	if (err)
 		goto out_dput;
 
-- 
2.30.2

