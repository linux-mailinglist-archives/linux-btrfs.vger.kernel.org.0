Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 53FD3184A94
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Mar 2020 16:23:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726922AbgCMPXZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 13 Mar 2020 11:23:25 -0400
Received: from mx2.suse.de ([195.135.220.15]:42180 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726695AbgCMPXZ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 13 Mar 2020 11:23:25 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 99CB6AE2A;
        Fri, 13 Mar 2020 15:23:23 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 2/3] btrfs: Remove transid argument from btrfs_ioctl_snap_create_transid
Date:   Fri, 13 Mar 2020 17:23:19 +0200
Message-Id: <20200313152320.22723-3-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200313152320.22723-1-nborisov@suse.com>
References: <20200313152320.22723-1-nborisov@suse.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

btrfs_ioctl_snap_create_transid no longer takes a transid argument, so
remove it and rename the function to __btrfs_ioctl_snap_create to
reflect it's an internal, worker function.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/ioctl.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index af1be567fec7..e18a56d87553 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -1729,9 +1729,9 @@ static noinline int btrfs_ioctl_resize(struct file *file,
 	return ret;
 }
 
-static noinline int btrfs_ioctl_snap_create_transid(struct file *file,
+static noinline int __btrfs_ioctl_snap_create(struct file *file,
 				const char *name, unsigned long fd, int subvol,
-				u64 *transid, bool readonly,
+				bool readonly,
 				struct btrfs_qgroup_inherit *inherit)
 {
 	int namelen;
@@ -1758,7 +1758,7 @@ static noinline int btrfs_ioctl_snap_create_transid(struct file *file,
 
 	if (subvol) {
 		ret = btrfs_mksubvol(&file->f_path, name, namelen,
-				     NULL, transid, readonly, inherit);
+				     NULL, readonly, inherit);
 	} else {
 		struct fd src = fdget(fd);
 		struct inode *src_inode;
@@ -1781,7 +1781,7 @@ static noinline int btrfs_ioctl_snap_create_transid(struct file *file,
 		} else {
 			ret = btrfs_mksubvol(&file->f_path, name, namelen,
 					     BTRFS_I(src_inode)->root,
-					     transid, readonly, inherit);
+					     readonly, inherit);
 		}
 		fdput(src);
 	}
@@ -1805,9 +1805,8 @@ static noinline int btrfs_ioctl_snap_create(struct file *file,
 		return PTR_ERR(vol_args);
 	vol_args->name[BTRFS_PATH_NAME_MAX] = '\0';
 
-	ret = btrfs_ioctl_snap_create_transid(file, vol_args->name,
-					      vol_args->fd, subvol,
-					      NULL, false, NULL);
+	ret = __btrfs_ioctl_snap_create(file, vol_args->name, vol_args->fd,
+					subvol, false, NULL);
 
 	kfree(vol_args);
 	return ret;
@@ -1848,9 +1847,8 @@ static noinline int btrfs_ioctl_snap_create_v2(struct file *file,
 		}
 	}
 
-	ret = btrfs_ioctl_snap_create_transid(file, vol_args->name,
-					      vol_args->fd, subvol, NULL,
-					      readonly, inherit);
+	ret = __btrfs_ioctl_snap_create(file, vol_args->name, vol_args->fd,
+					subvol, readonly, inherit);
 	if (ret)
 		goto free_inherit;
 free_inherit:
-- 
2.17.1

