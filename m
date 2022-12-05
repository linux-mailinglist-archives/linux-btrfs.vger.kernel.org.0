Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69B0E642622
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 Dec 2022 10:52:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230286AbiLEJwQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 5 Dec 2022 04:52:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231464AbiLEJvo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 5 Dec 2022 04:51:44 -0500
Received: from synology.com (mail.synology.com [211.23.38.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80FE9F59F
        for <linux-btrfs@vger.kernel.org>; Mon,  5 Dec 2022 01:51:43 -0800 (PST)
From:   robbieko <robbieko@synology.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synology.com; s=123;
        t=1670233901; bh=z3wqk3fC71KAbfg9sguvuAErxJ2SlZc6MRLD69u5x0c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=uUcMDTmlkCd+y8xyqzt3uwBp2+g5oyPvPAX5mu3IrGr7778hFc0O00WjL4kBzZJ8w
         OzcSM60UOGR5bfBx8Uor4Mi0onq7yp/i+elE7KFVVOtchFxmOqfkZJLZZQ+jdYzerH
         RljlTR/SQ3QaKM+4GWPPFZckqrfZJaCC6Yog/+uY=
To:     linux-btrfs@vger.kernel.org
Cc:     Robbie Ko <robbieko@synology.com>
Subject: [PATCH 3/3] btrfs: add snapshot_lock to new_fs_root_args
Date:   Mon,  5 Dec 2022 17:51:22 +0800
Message-Id: <20221205095122.17011-4-robbieko@synology.com>
In-Reply-To: <20221205095122.17011-1-robbieko@synology.com>
References: <20221205095122.17011-1-robbieko@synology.com>
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

Add snapshot_lock into new_fs_root_args to prevent
percpu_counter_init enter unexpected -ENOMEM when
calling btrfs_init_fs_root.

Signed-off-by: Robbie Ko <robbieko@synology.com>
---
 fs/btrfs/disk-io.c | 44 +++++++++++++++++++++++++++++++-------------
 fs/btrfs/disk-io.h |  2 ++
 2 files changed, 33 insertions(+), 13 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 5760c2b1a100..5704c8f5873c 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -1437,6 +1437,16 @@ struct btrfs_new_fs_root_args *btrfs_new_fs_root_args_prepare(gfp_t gfp_mask)
 	if (err)
 		goto error;
 
+	args->snapshot_lock = kzalloc(sizeof(*args->snapshot_lock), gfp_mask);
+	if (!args->snapshot_lock) {
+		err = -ENOMEM;
+		goto error;
+	}
+	ASSERT((gfp_mask & GFP_KERNEL) == GFP_KERNEL);
+	err = btrfs_drew_lock_init(args->snapshot_lock);
+	if (err)
+		goto error;
+
 	return args;
 
 error:
@@ -1448,6 +1458,9 @@ void btrfs_new_fs_root_args_destroy(struct btrfs_new_fs_root_args *args)
 {
 	if (!args)
 		return;
+	if (args->snapshot_lock)
+		btrfs_drew_lock_destroy(args->snapshot_lock);
+	kfree(args->snapshot_lock);
 	if (args->anon_dev)
 		free_anon_bdev(args->anon_dev);
 	kfree(args);
@@ -1464,20 +1477,25 @@ static int btrfs_init_fs_root(struct btrfs_root *root,
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
+		 * resolution) which could deadlock if it triggers memory reclaim
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
index a7c91bfb0c16..0e84927859ce 100644
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

