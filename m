Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2ACFD1628F0
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Feb 2020 15:56:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726750AbgBRO4P (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 18 Feb 2020 09:56:15 -0500
Received: from mx2.suse.de ([195.135.220.15]:48222 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726540AbgBRO4O (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 18 Feb 2020 09:56:14 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id EFCBCC137;
        Tue, 18 Feb 2020 14:56:11 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 3/3] btrfs: Make btrfs_check_uuid_tree private to disk-io.c
Date:   Tue, 18 Feb 2020 16:56:09 +0200
Message-Id: <20200218145609.13427-4-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200218145609.13427-1-nborisov@suse.com>
References: <20200218145609.13427-1-nborisov@suse.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

It's used only during fs mount as such it can be made private to
disk-io.c file. Also use the occassion to move btrfs_uuid_rescan_kthread
as btrfs_check_uuid_tree is its sole caller. No functional changes.
---
 fs/btrfs/disk-io.c | 35 +++++++++++++++++++++++++++++++++++
 fs/btrfs/volumes.c | 35 -----------------------------------
 fs/btrfs/volumes.h |  1 -
 3 files changed, 35 insertions(+), 36 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 9046bf0d4868..cf60385e0dfb 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -2836,6 +2836,41 @@ static int init_mount_fs_info(struct btrfs_fs_info *fs_info, struct super_block
 	return ret;
 }
 
+static int btrfs_uuid_rescan_kthread(void *data)
+{
+	struct btrfs_fs_info *fs_info = (struct btrfs_fs_info *)data;
+	int ret;
+
+	/*
+	 * 1st step is to iterate through the existing UUID tree and
+	 * to delete all entries that contain outdated data.
+	 * 2nd step is to add all missing entries to the UUID tree.
+	 */
+	ret = btrfs_uuid_tree_iterate(fs_info);
+	if (ret < 0) {
+		btrfs_warn(fs_info, "iterating uuid_tree failed %d", ret);
+		up(&fs_info->uuid_tree_rescan_sem);
+		return ret;
+	}
+	return btrfs_uuid_scan_kthread(data);
+}
+
+static int btrfs_check_uuid_tree(struct btrfs_fs_info *fs_info)
+{
+	struct task_struct *task;
+
+	down(&fs_info->uuid_tree_rescan_sem);
+	task = kthread_run(btrfs_uuid_rescan_kthread, fs_info, "btrfs-uuid");
+	if (IS_ERR(task)) {
+		/* fs_info->update_uuid_tree_gen remains 0 in all error case */
+		btrfs_warn(fs_info, "failed to start uuid_rescan task");
+		up(&fs_info->uuid_tree_rescan_sem);
+		return PTR_ERR(task);
+	}
+
+	return 0;
+}
+
 int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_devices,
 		      char *options)
 {
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 0b4da3557c27..91618be34e6c 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -4403,25 +4403,6 @@ int btrfs_uuid_scan_kthread(void *data)
 	return 0;
 }
 
-static int btrfs_uuid_rescan_kthread(void *data)
-{
-	struct btrfs_fs_info *fs_info = (struct btrfs_fs_info *)data;
-	int ret;
-
-	/*
-	 * 1st step is to iterate through the existing UUID tree and
-	 * to delete all entries that contain outdated data.
-	 * 2nd step is to add all missing entries to the UUID tree.
-	 */
-	ret = btrfs_uuid_tree_iterate(fs_info);
-	if (ret < 0) {
-		btrfs_warn(fs_info, "iterating uuid_tree failed %d", ret);
-		up(&fs_info->uuid_tree_rescan_sem);
-		return ret;
-	}
-	return btrfs_uuid_scan_kthread(data);
-}
-
 int btrfs_create_uuid_tree(struct btrfs_fs_info *fs_info)
 {
 	struct btrfs_trans_handle *trans;
@@ -4464,22 +4445,6 @@ int btrfs_create_uuid_tree(struct btrfs_fs_info *fs_info)
 	return 0;
 }
 
-int btrfs_check_uuid_tree(struct btrfs_fs_info *fs_info)
-{
-	struct task_struct *task;
-
-	down(&fs_info->uuid_tree_rescan_sem);
-	task = kthread_run(btrfs_uuid_rescan_kthread, fs_info, "btrfs-uuid");
-	if (IS_ERR(task)) {
-		/* fs_info->update_uuid_tree_gen remains 0 in all error case */
-		btrfs_warn(fs_info, "failed to start uuid_rescan task");
-		up(&fs_info->uuid_tree_rescan_sem);
-		return PTR_ERR(task);
-	}
-
-	return 0;
-}
-
 /*
  * shrinking a device means finding all of the device extents past
  * the new size, and then following the back refs to the chunks.
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index 311d03cf99a7..bb0fc7b35ba0 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -461,7 +461,6 @@ int btrfs_recover_balance(struct btrfs_fs_info *fs_info);
 int btrfs_pause_balance(struct btrfs_fs_info *fs_info);
 int btrfs_cancel_balance(struct btrfs_fs_info *fs_info);
 int btrfs_create_uuid_tree(struct btrfs_fs_info *fs_info);
-int btrfs_check_uuid_tree(struct btrfs_fs_info *fs_info);
 int btrfs_uuid_scan_kthread(void *data);
 int btrfs_chunk_readonly(struct btrfs_fs_info *fs_info, u64 chunk_offset);
 int find_free_dev_extent(struct btrfs_device *device, u64 num_bytes,
-- 
2.17.1

