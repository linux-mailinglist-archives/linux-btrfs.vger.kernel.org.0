Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8BBD9184A93
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Mar 2020 16:23:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726946AbgCMPXZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 13 Mar 2020 11:23:25 -0400
Received: from mx2.suse.de ([195.135.220.15]:42192 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726622AbgCMPXZ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 13 Mar 2020 11:23:25 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id DE079AE61;
        Fri, 13 Mar 2020 15:23:23 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 3/3] btrfs: Remove async_transid btrfs_mksubvol/create_subvol/create_snapshot
Date:   Fri, 13 Mar 2020 17:23:20 +0200
Message-Id: <20200313152320.22723-4-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200313152320.22723-1-nborisov@suse.com>
References: <20200313152320.22723-1-nborisov@suse.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

With BTRFS_SUBVOL_CREATE_ASYNC support remove it's no longer required
to pass the async_transid parameter so remove it and any code using it.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/ioctl.c | 32 ++++++++------------------------
 1 file changed, 8 insertions(+), 24 deletions(-)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index e18a56d87553..88bb2c43f437 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -551,7 +551,6 @@ int __pure btrfs_is_empty_uuid(u8 *uuid)
 static noinline int create_subvol(struct inode *dir,
 				  struct dentry *dentry,
 				  const char *name, int namelen,
-				  u64 *async_transid,
 				  struct btrfs_qgroup_inherit *inherit)
 {
 	struct btrfs_fs_info *fs_info = btrfs_sb(dir->i_sb);
@@ -723,14 +722,7 @@ static noinline int create_subvol(struct inode *dir,
 	trans->bytes_reserved = 0;
 	btrfs_subvolume_release_metadata(fs_info, &block_rsv);
 
-	if (async_transid) {
-		*async_transid = trans->transid;
-		err = btrfs_commit_transaction_async(trans, 1);
-		if (err)
-			err = btrfs_commit_transaction(trans);
-	} else {
-		err = btrfs_commit_transaction(trans);
-	}
+	err = btrfs_commit_transaction(trans);
 	if (err && !ret)
 		ret = err;
 
@@ -748,8 +740,7 @@ static noinline int create_subvol(struct inode *dir,
 }
 
 static int create_snapshot(struct btrfs_root *root, struct inode *dir,
-			   struct dentry *dentry,
-			   u64 *async_transid, bool readonly,
+			   struct dentry *dentry, bool readonly,
 			   struct btrfs_qgroup_inherit *inherit)
 {
 	struct btrfs_fs_info *fs_info = btrfs_sb(dir->i_sb);
@@ -833,14 +824,8 @@ static int create_snapshot(struct btrfs_root *root, struct inode *dir,
 	list_add(&pending_snapshot->list,
 		 &trans->transaction->pending_snapshots);
 	spin_unlock(&fs_info->trans_lock);
-	if (async_transid) {
-		*async_transid = trans->transid;
-		ret = btrfs_commit_transaction_async(trans, 1);
-		if (ret)
-			ret = btrfs_commit_transaction(trans);
-	} else {
-		ret = btrfs_commit_transaction(trans);
-	}
+
+	ret = btrfs_commit_transaction(trans);
 	if (ret)
 		goto fail;
 
@@ -946,7 +931,7 @@ static inline int btrfs_may_create(struct inode *dir, struct dentry *child)
 static noinline int btrfs_mksubvol(const struct path *parent,
 				   const char *name, int namelen,
 				   struct btrfs_root *snap_src,
-				   u64 *async_transid, bool readonly,
+				   bool readonly,
 				   struct btrfs_qgroup_inherit *inherit)
 {
 	struct inode *dir = d_inode(parent->dentry);
@@ -983,11 +968,10 @@ static noinline int btrfs_mksubvol(const struct path *parent,
 		goto out_up_read;
 
 	if (snap_src) {
-		error = create_snapshot(snap_src, dir, dentry,
-					async_transid, readonly, inherit);
+		error = create_snapshot(snap_src, dir, dentry, readonly,
+					inherit);
 	} else {
-		error = create_subvol(dir, dentry, name, namelen,
-				      async_transid, inherit);
+		error = create_subvol(dir, dentry, name, namelen, inherit);
 	}
 	if (!error)
 		fsnotify_mkdir(dir, dentry);
-- 
2.17.1

