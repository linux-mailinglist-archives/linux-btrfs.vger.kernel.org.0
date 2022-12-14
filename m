Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7CB964C229
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Dec 2022 03:11:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237054AbiLNCLi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 13 Dec 2022 21:11:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236997AbiLNCLh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 13 Dec 2022 21:11:37 -0500
Received: from synology.com (mail.synology.com [211.23.38.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF412220EB
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Dec 2022 18:11:35 -0800 (PST)
From:   robbieko <robbieko@synology.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synology.com; s=123;
        t=1670983893; bh=zn4dNxCU5vMMPp4VIoYINzrbGuPlkT9psjxltxwI4eQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=VLFCCEOPHY7uHBsGQozLl8nRUyEeom37H6c3RDBEeXeCdgEKMn5nYUsNvnm/fmYT7
         22kUH7KHheBWVB1axneH8Kdf60jtMgPqFxnk3txR4fXur4QOESZIy73ws5BTc2pbcb
         xU0PVdQPor5I886vpwlGrfzWUosomxGGDvx5UqGo=
To:     linux-btrfs@vger.kernel.org
Cc:     Robbie Ko <robbieko@synology.com>
Subject: [PATCH v2 3/3] btrfs: add snapshot_lock to new_fs_root_args
Date:   Wed, 14 Dec 2022 10:11:25 +0800
Message-Id: <20221214021125.28289-4-robbieko@synology.com>
In-Reply-To: <20221214021125.28289-1-robbieko@synology.com>
References: <20221214021125.28289-1-robbieko@synology.com>
X-Synology-MCP-Status: no
X-Synology-Spam-Flag: no
X-Synology-Spam-Status: score=0, required 6, WHITELIST_FROM_ADDRESS 0
X-Synology-Virus-Status: no
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Robbie Ko <robbieko@synology.com>

[Issue]
When creating subvolume/snapshot, the transaction may
be abort due to -ENOMEM.

[Cause]
During creating a subvolume/snapshot, it is necessary
to allocate memory for Initializing fs root.
Therefore, it can only use GFP_NOFS to allocate memory
to avoid deadlock issues.
However, atomic allocation is required when processing
percpu_counter_init without GFP_KERNEL due to the unique
structure of percpu_counter.
In this situation, allocating memory for initializing
fs root may cause unexpected -ENOMEM when free memory
is low and causes btrfs transaction to abort.

[Fix]
So we add snapshot_lock into new_fs_root_args to allocate
the memory before holding a transaction handle.
This way, we can reduce the chances of -ENOMEM when
calling btrfs_init_fs_root.
Furthermore, it can avoid aborting a transaction and
turn the fs to RO mode.

Signed-off-by: Robbie Ko <robbieko@synology.com>
---
 fs/btrfs/disk-io.c | 44 +++++++++++++++++++++++++++++++-------------
 fs/btrfs/disk-io.h |  2 ++
 2 files changed, 33 insertions(+), 13 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index ed2ce2dfbfcd..7ba1a019f5b0 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -1519,6 +1519,15 @@ struct btrfs_new_fs_root_args *btrfs_alloc_new_fs_root_args(void)
 	if (err)
 		goto error;
 
+	args->snapshot_lock = kzalloc(sizeof(*args->snapshot_lock), GFP_KERNEL);
+	if (!args->snapshot_lock) {
+		err = -ENOMEM;
+		goto error;
+	}
+	err = btrfs_drew_lock_init(args->snapshot_lock);
+	if (err)
+		goto error;
+
 	return args;
 
 error:
@@ -1530,6 +1539,10 @@ void btrfs_free_new_fs_root_args(struct btrfs_new_fs_root_args *args)
 {
 	if (!args)
 		return;
+	if (args->snapshot_lock) {
+		btrfs_drew_lock_destroy(args->snapshot_lock);
+		kfree(args->snapshot_lock);
+	}
 	if (args->anon_dev)
 		free_anon_bdev(args->anon_dev);
 	kfree(args);
@@ -1546,20 +1559,25 @@ static int btrfs_init_fs_root(struct btrfs_root *root,
 	int ret;
 	unsigned int nofs_flag;
 
-	root->snapshot_lock = kzalloc(sizeof(*root->snapshot_lock), GFP_NOFS);
-	if (!root->snapshot_lock) {
-		ret = -ENOMEM;
-		goto fail;
+	if (new_fs_root_args && new_fs_root_args->snapshot_lock) {
+		root->snapshot_lock = new_fs_root_args->snapshot_lock;
+		new_fs_root_args->snapshot_lock = NULL;
+	} else {
+		root->snapshot_lock = kzalloc(sizeof(*root->snapshot_lock), GFP_NOFS);
+		if (!root->snapshot_lock) {
+			ret = -ENOMEM;
+			goto fail;
+		}
+		/*
+		 * We might be called under a transaction (e.g. indirect backref
+		 * resolution) which could deadlock if it triggers memory reclaim.
+		 */
+		nofs_flag = memalloc_nofs_save();
+		ret = btrfs_drew_lock_init(root->snapshot_lock);
+		memalloc_nofs_restore(nofs_flag);
+		if (ret)
+			goto fail;
 	}
-	/*
-	 * We might be called under a transaction (e.g. indirect backref
-	 * resolution) which could deadlock if it triggers memory reclaim
-	 */
-	nofs_flag = memalloc_nofs_save();
-	ret = btrfs_drew_lock_init(root->snapshot_lock);
-	memalloc_nofs_restore(nofs_flag);
-	if (ret)
-		goto fail;
 
 	if (root->root_key.objectid != BTRFS_TREE_LOG_OBJECTID &&
 	    !btrfs_is_data_reloc_root(root)) {
diff --git a/fs/btrfs/disk-io.h b/fs/btrfs/disk-io.h
index 67c6625797ca..21c41cf8d115 100644
--- a/fs/btrfs/disk-io.h
+++ b/fs/btrfs/disk-io.h
@@ -28,6 +28,8 @@ static inline u64 btrfs_sb_offset(int mirror)
 struct btrfs_new_fs_root_args {
 	/* Preallocated anonymous block device number */
 	dev_t anon_dev;
+	/* Preallocated snapshot lock */
+	struct btrfs_drew_lock *snapshot_lock;
 };
 
 struct btrfs_device;
-- 
2.17.1

