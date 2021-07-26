Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD8EB3D5788
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Jul 2021 12:29:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232507AbhGZJs4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 26 Jul 2021 05:48:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:35734 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233006AbhGZJsz (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 26 Jul 2021 05:48:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 695D560F57;
        Mon, 26 Jul 2021 10:29:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627295364;
        bh=yyMFOc9g6m0/zqm3+tVIqk41/E0f9Fd9n8V0G2JHjb8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YeDEqL4n2CyHsRLiWKhpuhKivnUvAXv1fdTau0YJlVLkRmDSA9SJjmmGveDo8fJ63
         6B4YMI0v8iFpOBnngTcwSyU6bUgeV03c/0mwZ/far/8jmJ+AWrFTN5AvEPbXPSQUXe
         OquFNwWOIPlTyNTELLhfRfoIvVmA9bGUZvGYpKX/dKwPtqHiFoNO1rdnVfMyMY6VnG
         mu4EfD8pRP2gwpnnUPyU+5+dxuGOz2wP/9xlurQBM6Pahl8S0JzstrJF1olNUwRXD1
         2q6WUPUh3RXOOYQhueGu0MNLZd1yUBLp/f2rgobKiE9G619wBGqsCZo6jntk9nQEXN
         oU+eqd2bXs89Q==
From:   Christian Brauner <brauner@kernel.org>
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, linux-btrfs@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: [PATCH v3 14/21] btrfs/ioctl: allow idmapped BTRFS_IOC_SNAP_DESTROY{_V2} ioctl
Date:   Mon, 26 Jul 2021 12:28:09 +0200
Message-Id: <20210726102816.612434-15-brauner@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210726102816.612434-1-brauner@kernel.org>
References: <20210726102816.612434-1-brauner@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=8002; h=from:subject; bh=PYjV6zTHbGQznPIZyBcY3ar0pwBZk6ZljbrDpNRSx8U=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMST86zN5vXnrteM3c6I5ZtW8fT8/7cnbtfNTktIeF74zTxCv P2b4taOUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAiRQoMf4X6DvtNtsu5b/B22uovyY IXS4I/5qxxcpybPr/kw+XoinRGhkl/mEPO7Dy17cOJDftb7c5pbV3heOQ5+7HTf7g4roX4dTACAA==
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
---
 fs/btrfs/ioctl.c | 27 +++++++++++++++++++++------
 1 file changed, 21 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index be52891ba571..488e2395034f 100644
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
+				err = -EOPNOTSUPP;
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

