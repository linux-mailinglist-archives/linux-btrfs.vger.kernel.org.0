Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8AE13CD390
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Jul 2021 13:13:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236663AbhGSKa5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 19 Jul 2021 06:30:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:59686 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236654AbhGSKa4 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 19 Jul 2021 06:30:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E94D3600EF;
        Mon, 19 Jul 2021 11:11:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626693096;
        bh=W4JJ6om8tM1CH4IzxxTR/gN+k25qFaj0o+dLFrivocM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=V8Tej+zEhOLCgigoPvMlW/fYp6WIoksDsvlEzFInGn+AZAHBuQSpNDE8qw4OzWWBl
         2QiT6hRiNMrXywIfNTwR0ejaUUvPtl3R6j/1r3LLCxw1skmgrLsMVVh8dCJXWUiRAf
         RkWtryZ4XE5JkiMLEhx3MOeTxNvLdL2FiCUkZ23mmvjW9Wy19w1eNEV3er+xksYrBN
         Ys8uNC+aEZLlzaJnyB3q8vOpDLNbuA/Htnl43PQWBixlFR52IIZT7l2D+IkrjUUEv9
         ooFB4hzkGliiO5CFnb4YMo4FzCco417vAwgQvt2BuEZyYf8fdDTPSCIjtKf5ixt3G5
         BlljiCAG1eaYQ==
From:   Christian Brauner <brauner@kernel.org>
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-btrfs@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: [PATCH v2 15/21] btrfs/ioctl: relax restrictions for BTRFS_IOC_SNAP_DESTROY_V2 with subvolids
Date:   Mon, 19 Jul 2021 13:10:46 +0200
Message-Id: <20210719111052.1626299-16-brauner@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210719111052.1626299-1-brauner@kernel.org>
References: <20210719111052.1626299-1-brauner@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2817; h=from:subject; bh=qIbCHFEYDIr911mGBYy0Iivr1qf9vv7admrv3auwOsM=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSR8jd2eeKnxM3/c86XezJK90uu3yHKfT6l1TWN7cXZaU256 WlJcRykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwES2STMyHK/N5spbmX/ySrbKhIkx03 SXWgdV/P/ANr0vNXSyf+sLd4a/Arymy9wW+Ad/+jpvfoueZvGFlJzkD4n6h/dXCb4yVn7CCwA=
X-Developer-Key: i=christian.brauner@ubuntu.com; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Christian Brauner <christian.brauner@ubuntu.com>

So far we prevented the deletion of subvolumes and snapshots using subvolume
ids possible with the BTRFS_SUBVOL_SPEC_BY_ID flag.
This restriction is necessary on idmapped mounts as this allows filesystem wide
subvolume and snapshot deletions and thus can escape the scope of what's
exposed under the mount identified by the fd passed with the ioctl.

Deletion by subvolume id works by looking for an alias of the parent of the
subvolume or snapshot to be deleted. The parent alias can be anywhere in the
filesystem. However, as long as the alias of the parent that is found is the
same as the one identified by the file descriptor passed through the ioctl we
can allow the deletion.

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
 fs/btrfs/ioctl.c | 27 ++++++++++++++++-----------
 1 file changed, 16 insertions(+), 11 deletions(-)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 5416b0c0ee7a..72045ae30d1c 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -2944,17 +2944,7 @@ static noinline int btrfs_ioctl_snap_destroy(struct file *file,
 			if (err)
 				goto out;
 		} else {
-			/*
-			 * Deleting by subvolume id can be used to delete
-			 * subvolumes/snapshots anywhere in the filesystem.
-			 * Ensure that users can't abuse idmapped mounts of
-			 * btrfs subvolumes/snapshots to perform operations in
-			 * the whole filesystem.
-			 */
-			if (mnt_userns != &init_user_ns) {
-				err = -EINVAL;
-				goto out;
-			}
+			struct inode *old_dir;
 
 			if (vol_args2->subvolid < BTRFS_FIRST_FREE_OBJECTID) {
 				err = -EINVAL;
@@ -2992,6 +2982,7 @@ static noinline int btrfs_ioctl_snap_destroy(struct file *file,
 				err = PTR_ERR(parent);
 				goto out_drop_write;
 			}
+			old_dir = dir;
 			dir = d_inode(parent);
 
 			/*
@@ -3002,6 +2993,20 @@ static noinline int btrfs_ioctl_snap_destroy(struct file *file,
 			 */
 			destroy_parent = true;
 
+			/*
+			 * On idmapped mounts, deletion via subvolid is
+			 * restricted to subvolumes that are immediate
+			 * ancestors of the inode referenced by the file
+			 * descriptor in the ioctl. Otherwise the idmapping
+			 * could potentially be abused to delete subvolumes
+			 * anywhere in the filesystem the user wouldn't be able
+			 * to delete without an idmapped mount.
+			 */
+			if (old_dir != dir && mnt_userns != &init_user_ns) {
+				err = -EINVAL;
+				goto free_parent;
+			}
+
 			subvol_name_ptr = btrfs_get_subvol_name_from_objectid(
 						fs_info, vol_args2->subvolid);
 			if (IS_ERR(subvol_name_ptr)) {
-- 
2.30.2

