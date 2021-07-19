Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B28433CD393
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Jul 2021 13:13:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236654AbhGSKbF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 19 Jul 2021 06:31:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:59790 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236405AbhGSKbE (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 19 Jul 2021 06:31:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8495F610FB;
        Mon, 19 Jul 2021 11:11:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626693104;
        bh=cFQdjzcLKe2a9GkeLcL6M18xT9nUijcqOzEruQE+HvA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XV0UZuzizgwLvohINyUigaZ0n3pWtFnkR8R2u8rffcKRXj7KLjFCAQGOa5S/Vfr2A
         VQ+h5sxvlDDWBo1a0YuUz869U54N8339C4l7uol2+Gs6hmT+filHYoRBAExqAu5PYz
         1+0xuONMNw5kip4T0UrVQzuh3gtI5ehJ+2ZCJrpY4WWpylI2eWcjLaK2qvGqB0Mkk4
         Cn9DpIg+Xrn87xOK7V2FMmcIEvUomCV1dbGopif97eqhWWd+rbbQOPmNsjOyreXqj8
         We3+DWZOBHJdz39r5NEliNQkCprEt61mIw6Hn+W/0akokneS9t1OkkvJ5NplCO7fV3
         /irQ99mi3AW2g==
From:   Christian Brauner <brauner@kernel.org>
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-btrfs@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: [PATCH v2 18/21] btrfs/ioctl: allow idmapped BTRFS_IOC_INO_LOOKUP_USER ioctl
Date:   Mon, 19 Jul 2021 13:10:49 +0200
Message-Id: <20210719111052.1626299-19-brauner@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210719111052.1626299-1-brauner@kernel.org>
References: <20210719111052.1626299-1-brauner@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3763; h=from:subject; bh=ulWrQVOrk9On280Ag/BL7PrE+pRWDj+/AiV+haHRk0Q=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSR8jd3B4ruR5Tnzk18RbIsn9bvl6SwMztz76ue9eLVvu7VP +c7801HKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjARJStGhkbTiRNu//Rbd6/S2ylY/Y jiL56uUoUXC4KLC6wm1NSGTWf4zfr5YoMYB9O9vH2aQa7Fifkq+y39ZybPv+iSu/Pl1l4DBgA=
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
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
/* v2 */
unchanged
---
 fs/btrfs/ioctl.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 73a477ead145..c96037d15bf7 100644
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

