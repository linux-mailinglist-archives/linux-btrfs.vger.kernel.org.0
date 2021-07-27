Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1EA03D73B9
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Jul 2021 12:51:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236455AbhG0KvF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 27 Jul 2021 06:51:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:56246 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236454AbhG0KvF (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 27 Jul 2021 06:51:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A2E7260FDB;
        Tue, 27 Jul 2021 10:51:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627383065;
        bh=6mKxMAPjsLzj7goh0VnGIg3kaeW647CzFz1ijYmFuyI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=c8mqXOrMix6NQrHTSwxtrmG/efB0xmohik11Qz+nzt7eOq0uL5u+pDvlK8rvVOONY
         rPYHurxteHjgn8kF1koUGq488QdOywc0WH/RA5uqQjJF6C+ggsiABJlBWhdD6kaY5y
         z6ZljlnDb2VfXg8ASFk3Akf5hULeWURuB0q8qMpbtQxs9jMrMma2wzKqa57FG/QhW+
         6k127qySnl/KzRGyL9CnKTUebrP14DHxZtqff3HW3KXhr8iNq2HyuXIAhrNnA3fZwf
         7aP0r7EJUzbKoNYa8vuRFukfY6SokokmbjcoMliMwNKy47DDcwL4hILjdmanBqzWJM
         uovxxB4hQFccQ==
From:   Christian Brauner <brauner@kernel.org>
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, linux-btrfs@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Christoph Hellwig <hch@infradead.org>, Qu Wenruo <wqu@suse.com>
Subject: [PATCH v4 15/21] btrfs/ioctl: relax restrictions for BTRFS_IOC_SNAP_DESTROY_V2 with subvolids
Date:   Tue, 27 Jul 2021 12:48:54 +0200
Message-Id: <20210727104900.829215-16-brauner@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210727104900.829215-1-brauner@kernel.org>
References: <20210727104900.829215-1-brauner@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2959; h=from:subject; bh=GVuvGzTE8hu4K3aYKWY6vqDa/KQO8VDRSKMkNDxu+eI=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMST8fzItbWZH8qbS6T93+3SdPvTGuZU36lkvm8Qpz9RtZxlz PJmaOkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACZyZirD/5KiGW1efKeXnc3a2p1ReH eXGkMhn1kus6dtTsj1LQf9TjD8FXPt2dd/KM/M5NSLrU/zOtnUenSuiMm8nHfiS45Y1K6FjAA=
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
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
/* v2 */
unchanged

/* v3 */
unchanged

/* v4 */
unchanged
---
 fs/btrfs/ioctl.c | 27 ++++++++++++++++-----------
 1 file changed, 16 insertions(+), 11 deletions(-)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 6295c9c6fc3e..5a8df000cc41 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -2943,17 +2943,7 @@ static noinline int btrfs_ioctl_snap_destroy(struct file *file,
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
-				err = -EOPNOTSUPP;
-				goto out;
-			}
+			struct inode *old_dir;
 
 			if (vol_args2->subvolid < BTRFS_FIRST_FREE_OBJECTID) {
 				err = -EINVAL;
@@ -2991,6 +2981,7 @@ static noinline int btrfs_ioctl_snap_destroy(struct file *file,
 				err = PTR_ERR(parent);
 				goto out_drop_write;
 			}
+			old_dir = dir;
 			dir = d_inode(parent);
 
 			/*
@@ -3001,6 +2992,20 @@ static noinline int btrfs_ioctl_snap_destroy(struct file *file,
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
+				err = -EOPNOTSUPP;
+				goto free_parent;
+			}
+
 			subvol_name_ptr = btrfs_get_subvol_name_from_objectid(
 						fs_info, vol_args2->subvolid);
 			if (IS_ERR(subvol_name_ptr)) {
-- 
2.30.2

