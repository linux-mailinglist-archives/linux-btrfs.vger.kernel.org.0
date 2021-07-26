Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D0DD3D578B
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Jul 2021 12:29:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233132AbhGZJtI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 26 Jul 2021 05:49:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:35936 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233060AbhGZJtE (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 26 Jul 2021 05:49:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1D20360F58;
        Mon, 26 Jul 2021 10:29:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627295373;
        bh=iWgE926CCyVowkforqFLZ2w+Vq+4GnJ51xEcGRn1WKQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gno7nhm9+lmWPnvEqsItvuYRZuydcrFfZIsNWg1ojhVNH13qgvCkjQP4ngDNFG1mz
         CXZ8Vwcn3DfZxuBy/4m+0tX5Fp497gyjv9w0zGlfjj/RwR+xI1g0VhyV5/I0DEwCre
         ljTRNy9jiQh9Wu+9r8o6tMz1iamjO+Mn5Y4LtzueeDbZf+KHfpT5cGbzOKmBm/BQxv
         G8TVAUf6nC2BivX0E1yfwpM53XuHVV04hCV3GdS3/O06CTJq6njBwDLR4Lj27nQbNk
         Nu9Eur2Gme/x41a9q0yIqSlMRMDQ5DiCYpiUEuB0eWD/RScm+rnDzDiKwf0QInDQWv
         /Yc7poXrLMtYw==
From:   Christian Brauner <brauner@kernel.org>
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, linux-btrfs@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: [PATCH v3 18/21] btrfs/ioctl: allow idmapped BTRFS_IOC_INO_LOOKUP_USER ioctl
Date:   Mon, 26 Jul 2021 12:28:13 +0200
Message-Id: <20210726102816.612434-19-brauner@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210726102816.612434-1-brauner@kernel.org>
References: <20210726102816.612434-1-brauner@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3835; h=from:subject; bh=nHK9LaSXzVTOpj7E8nQPoIN2myNEl0+yllknGwd4rtQ=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMST86zPluConvGvZ3xebXglaRzMYzLXr2rpxtdhOT+NpFzSM T7mJd5SyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEzk/EdGhuUxn9dPVJyafHT+DU5Lm5 XLhQPlLh19Xa8QcyZ2ZZnVfn2Gf7ZMWpkX1sSHnjc2ZgnuKF7Y3Lp/xoqI/EuiDHN+POV9yQoA
X-Developer-Key: i=christian.brauner@ubuntu.com; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Christian Brauner <christian.brauner@ubuntu.com>

The BTRFS_IOC_INO_LOOKUP_USER is an unprivileged version of the
BTRFS_IOC_INO_LOOKUP ioctl and has the following restrictions. The main
difference between the two is that BTRFS_IOC_INO_LOOKUP is filesystem wide
operation wheres BTRFS_IOC_INO_LOOKUP_USER is scoped beneath the file
descriptor passed with the ioctl. Specifically, BTRFS_IOC_INO_LOOKUP_USER must
adhere to the following restrictions:
- The caller must be privileged over each inode of each path component for the
  path they are trying to lookup.
- The path for the subvolume the caller is trying to lookup must be reachable
  from the inode associated with the file descriptor passed with the ioctl.
The second condition makes it possible to scope the lookup of the path to the
mount identified by the file descriptor passed with the ioctl. This allows us
to enable this ioctl on idmapped mounts.

Specifically, this is possible because all child subvolumes of a parent
subvolume are reachable when the parent subvolume is mounted. So if the user
had access to open the parent subvolume or has been given the fd then they can
lookup the path if they had access to it provided they were privileged over
each path component.

Note, the BTRFS_IOC_INO_LOOKUP_USER ioctl allows a user to learn the path and
name of a subvolume even though they would otherwise be restricted from doing
so via regular vfs-based lookup.
So think about a parent subvolume with multiple child subvolumes. Someone could
mount he parent subvolume and restrict access to the child subvolumes by
overmounting them with empty directories. At this point the user can't traverse
the child subvolumes and they can't open files in the child subvolumes.
However, they can still learn the path of child subvolumes as long as they have
access to the parent subvolume by using the BTRFS_IOC_INO_LOOKUP_USER ioctl.

The underlying assumption here is that it's ok that the lookup ioctls can't
really take mounts into account other than the original mount the fd belongs to
during lookup. Since this assumption is baked into the original
BTRFS_IOC_INO_LOOKUP_USER ioctl we can extend it to idmapped mounts.

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
 fs/btrfs/ioctl.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index e4571522427a..159bff0c07c1 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -2440,7 +2440,8 @@ static noinline int btrfs_search_path_in_tree(struct btrfs_fs_info *info,
 	return ret;
 }
 
-static int btrfs_search_path_in_tree_user(struct inode *inode,
+static int btrfs_search_path_in_tree_user(struct user_namespace *mnt_userns,
+				struct inode *inode,
 				struct btrfs_ioctl_ino_lookup_user_args *args)
 {
 	struct btrfs_fs_info *fs_info = BTRFS_I(inode)->root->fs_info;
@@ -2538,7 +2539,7 @@ static int btrfs_search_path_in_tree_user(struct inode *inode,
 				ret = PTR_ERR(temp_inode);
 				goto out_put;
 			}
-			ret = inode_permission(&init_user_ns, temp_inode,
+			ret = inode_permission(mnt_userns, temp_inode,
 					       MAY_READ | MAY_EXEC);
 			iput(temp_inode);
 			if (ret) {
@@ -2680,7 +2681,7 @@ static int btrfs_ioctl_ino_lookup_user(struct file *file, void __user *argp)
 		return -EACCES;
 	}
 
-	ret = btrfs_search_path_in_tree_user(inode, args);
+	ret = btrfs_search_path_in_tree_user(file_mnt_user_ns(file), inode, args);
 
 	if (ret == 0 && copy_to_user(argp, args, sizeof(*args)))
 		ret = -EFAULT;
-- 
2.30.2

