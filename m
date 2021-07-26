Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 131AA3D5789
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Jul 2021 12:29:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233080AbhGZJs6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 26 Jul 2021 05:48:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:35798 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233060AbhGZJs5 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 26 Jul 2021 05:48:57 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 73F2360F6F;
        Mon, 26 Jul 2021 10:29:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627295366;
        bh=l339qKbv+7vkm+hLeAZ6MnCZgWAk9HtNqHGY9Zi5wUc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tOLh0LM231z4RkCY09luCsxRQMAs/9NDcaeaJZjIFECSg7gmwDkrB2mnSquROP6vG
         clEykxVseAo1Qb6t7RAS6MTx7H4wuQ41tPzp44sZkOeJxGl9vlwDNRwPWt9IFlw9eE
         Gd2zj9h2f9SSsDi9Vttoazw0pzXfEEvi3/BAg2IYf8PoJISOUzOBEI3OQz4KDrOLoX
         2YL++9T4qRjKKEv82tn1kv/9Yqok98MfeDZOaQPajOOCF+eEEISHl7Ja61cYX0Eujj
         2wbToaquLWDnt94oa8QsZ4/YrQ7Le+uKC4dd7aGc6af4ustncFJGnTANxq1lvm/aVo
         kVhfSv0+hl8MA==
From:   Christian Brauner <brauner@kernel.org>
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, linux-btrfs@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: [PATCH v3 15/21] btrfs/ioctl: relax restrictions for BTRFS_IOC_SNAP_DESTROY_V2 with subvolids
Date:   Mon, 26 Jul 2021 12:28:10 +0200
Message-Id: <20210726102816.612434-16-brauner@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210726102816.612434-1-brauner@kernel.org>
References: <20210726102816.612434-1-brauner@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2897; h=from:subject; bh=qRkKrST/903chvQyBuvEhRegfPOGUOR8j4rrrB7NSfU=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMST86zNdpzs1h4k7x81WP5MnsmndXU+vyUluM1d5qE5e8ott JsPTjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIk4dzD8r5H0EyxL2uIrP9kvTHNqV4 zuHt8D5onPnlWmBArtZfhixciwe2L42Zf/Sj/8a3T7kVSbmHSw4u+pFce3HGBib1YWfarLCAA=
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
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
/* v2 */
unchanged

/* v3 */
unchanged
---
 fs/btrfs/ioctl.c | 27 ++++++++++++++++-----------
 1 file changed, 16 insertions(+), 11 deletions(-)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 488e2395034f..b9864d63ffbf 100644
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
-				err = -EOPNOTSUPP;
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
+				err = -EOPNOTSUPP;
+				goto free_parent;
+			}
+
 			subvol_name_ptr = btrfs_get_subvol_name_from_objectid(
 						fs_info, vol_args2->subvolid);
 			if (IS_ERR(subvol_name_ptr)) {
-- 
2.30.2

