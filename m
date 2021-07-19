Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 600AF3CD38F
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Jul 2021 13:13:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236606AbhGSKaz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 19 Jul 2021 06:30:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:59654 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236654AbhGSKay (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 19 Jul 2021 06:30:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 788B16113C;
        Mon, 19 Jul 2021 11:11:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626693094;
        bh=JVZJSiPoLcf87SE2d84C8rYEryh3+Fl8EOWxRg/TEGY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aJxMsHDikePiWPwqap2PQeNBRUevmgNA1C8iFiY2DuF4q19ymtyC3gLFU51o/V2IK
         Vi9C7R8cFen8m08Cdh5rPvYY+uE1LFQW38C5Q6ec42OHR9iumeRZkfwmHHHzpe20OQ
         cdfHGP4FpQLPaG4ZWaLceoZo34cCPr0Tf/FbRJx67rLtougqynljUYssTXgG/ofNTX
         /kREdBEW1OiDboacl/v5lRQKf2KU/e8stSKg590JXABCO9+cVvqG9qv/R1ITsDOPym
         N2Ll8p71/fRMd2g0YPt1XU43mRl3Iy6orJ9ycmv0mU5GPkIGi3dw9w86rJBD1/+af5
         7fM4fVo1zgCNw==
From:   Christian Brauner <brauner@kernel.org>
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-btrfs@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: [PATCH v2 14/21] btrfs/ioctl: allow idmapped BTRFS_IOC_SNAP_DESTROY{_V2} ioctl
Date:   Mon, 19 Jul 2021 13:10:45 +0200
Message-Id: <20210719111052.1626299-15-brauner@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210719111052.1626299-1-brauner@kernel.org>
References: <20210719111052.1626299-1-brauner@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6664; h=from:subject; bh=+/84HNBCIA8BKlk1P0cojefgH3oJoGOQx1chGyd57I8=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSR8jd2eervSbWnuTv3JQdsMPhx/vOvla/NFJa6PZ3Wvb3ne vzTbpKOUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAisrMY/qcsZF/4IXd50uuqmwfnmM r//msr0dL0Ib74y7fwf/vWyxgyMrzX+vG9K9vnyRI5s+0HzRv19oYWVzmt3Fxo/aU87UJMJx8A
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

In addition to regular subvolume or snapshot deletion by specifying the name of
the subvolume or snapshot the BTRFS_IOC_SNAP_DESTROY_V2 ioctl allows the
deletion of subvolumes and snapshots via subvolume and snapshot ids when the
BTRFS_SUBVOL_SPEC_BY_ID flag is raised.

This feature is blocked on idmapped mounts as this allows filesystem wide
subvolume deletions and thus can escape the scope of what's exposed under the
mount identified by the fd passed with the ioctl.

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
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
/* v2 */
unchanged
---
 fs/btrfs/ioctl.c | 27 +++++++++++++++++++++------
 1 file changed, 21 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index be52891ba571..5416b0c0ee7a 100644
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
@@ -2915,6 +2916,7 @@ static noinline int btrfs_ioctl_snap_destroy(struct file *file,
 	struct btrfs_root *dest = NULL;
 	struct btrfs_ioctl_vol_args *vol_args = NULL;
 	struct btrfs_ioctl_vol_args_v2 *vol_args2 = NULL;
+	struct user_namespace *mnt_userns = file_mnt_user_ns(file);
 	char *subvol_name, *subvol_name_ptr = NULL;
 	int subvol_namelen;
 	int err = 0;
@@ -2942,6 +2944,18 @@ static noinline int btrfs_ioctl_snap_destroy(struct file *file,
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
+				err = -EINVAL;
+				goto out;
+			}
+
 			if (vol_args2->subvolid < BTRFS_FIRST_FREE_OBJECTID) {
 				err = -EINVAL;
 				goto out;
@@ -3026,7 +3040,8 @@ static noinline int btrfs_ioctl_snap_destroy(struct file *file,
 	err = down_write_killable_nested(&dir->i_rwsem, I_MUTEX_PARENT);
 	if (err == -EINTR)
 		goto free_subvol_name;
-	dentry = lookup_one_len(subvol_name, parent, subvol_namelen);
+	dentry = lookup_mapped_one_len(mnt_userns, subvol_name,
+				       parent, subvol_namelen);
 	if (IS_ERR(dentry)) {
 		err = PTR_ERR(dentry);
 		goto out_unlock_dir;
@@ -3068,14 +3083,14 @@ static noinline int btrfs_ioctl_snap_destroy(struct file *file,
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

