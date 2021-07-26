Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C77D73D5949
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Jul 2021 14:18:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233961AbhGZLhi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 26 Jul 2021 07:37:38 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:54752 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233904AbhGZLhh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 26 Jul 2021 07:37:37 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id B04F121F7A;
        Mon, 26 Jul 2021 12:18:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1627301885; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ae5UYDLi5r8GM/414pViSbICVCbXxp1ZH8q/BJLHxCk=;
        b=cjUsJhgqydJYlBLa3YjHvoZINv3b8tKu8A88PuEMBY2a236Ocr+DnhQspV7LS/ygyrs7jr
        2/v1k6knbWPAa6B48c5+Gsee2mmOaTkUcU173RRvO9L2d7UuOKPrft+STTj+3S6jFqrspl
        +aCQXn10Gf7pwKBsOTeP0oKSZnNc08Y=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id A8CE3A3C0B;
        Mon, 26 Jul 2021 12:18:05 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 08E9BDA8D8; Mon, 26 Jul 2021 14:15:21 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 07/10] btrfs: merge alloc_device helpers
Date:   Mon, 26 Jul 2021 14:15:21 +0200
Message-Id: <2d6e3c341f5ed60f5fe3cffe81ad301f9cdfdee5.1627300614.git.dsterba@suse.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1627300614.git.dsterba@suse.com>
References: <cover.1627300614.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The device allocation is split to two functions, but one just calls the
other and they're very far in the file. Merge them together.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/volumes.c | 66 ++++++++++++++++++----------------------------
 1 file changed, 25 insertions(+), 41 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 19feb64586fc..d98e29556d79 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -430,44 +430,6 @@ void __exit btrfs_cleanup_fs_uuids(void)
 	}
 }
 
-/*
- * Returns a pointer to a new btrfs_device on success; ERR_PTR() on error.
- * Returned struct is not linked onto any lists and must be destroyed using
- * btrfs_free_device.
- */
-static struct btrfs_device *__alloc_device(struct btrfs_fs_info *fs_info)
-{
-	struct btrfs_device *dev;
-
-	dev = kzalloc(sizeof(*dev), GFP_KERNEL);
-	if (!dev)
-		return ERR_PTR(-ENOMEM);
-
-	/*
-	 * Preallocate a bio that's always going to be used for flushing device
-	 * barriers and matches the device lifespan
-	 */
-	dev->flush_bio = bio_kmalloc(GFP_KERNEL, 0);
-	if (!dev->flush_bio) {
-		kfree(dev);
-		return ERR_PTR(-ENOMEM);
-	}
-
-	INIT_LIST_HEAD(&dev->dev_list);
-	INIT_LIST_HEAD(&dev->dev_alloc_list);
-	INIT_LIST_HEAD(&dev->post_commit_list);
-
-	atomic_set(&dev->reada_in_flight, 0);
-	atomic_set(&dev->dev_stats_ccnt, 0);
-	btrfs_device_data_ordered_init(dev);
-	INIT_RADIX_TREE(&dev->reada_zones, GFP_NOFS & ~__GFP_DIRECT_RECLAIM);
-	INIT_RADIX_TREE(&dev->reada_extents, GFP_NOFS & ~__GFP_DIRECT_RECLAIM);
-	extent_io_tree_init(fs_info, &dev->alloc_state,
-			    IO_TREE_DEVICE_ALLOC_STATE, NULL);
-
-	return dev;
-}
-
 static noinline struct btrfs_fs_devices *find_fsid(
 		const u8 *fsid, const u8 *metadata_fsid)
 {
@@ -6856,9 +6818,31 @@ struct btrfs_device *btrfs_alloc_device(struct btrfs_fs_info *fs_info,
 	if (WARN_ON(!devid && !fs_info))
 		return ERR_PTR(-EINVAL);
 
-	dev = __alloc_device(fs_info);
-	if (IS_ERR(dev))
-		return dev;
+	dev = kzalloc(sizeof(*dev), GFP_KERNEL);
+	if (!dev)
+		return ERR_PTR(-ENOMEM);
+
+	/*
+	 * Preallocate a bio that's always going to be used for flushing device
+	 * barriers and matches the device lifespan
+	 */
+	dev->flush_bio = bio_kmalloc(GFP_KERNEL, 0);
+	if (!dev->flush_bio) {
+		kfree(dev);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	INIT_LIST_HEAD(&dev->dev_list);
+	INIT_LIST_HEAD(&dev->dev_alloc_list);
+	INIT_LIST_HEAD(&dev->post_commit_list);
+
+	atomic_set(&dev->reada_in_flight, 0);
+	atomic_set(&dev->dev_stats_ccnt, 0);
+	btrfs_device_data_ordered_init(dev);
+	INIT_RADIX_TREE(&dev->reada_zones, GFP_NOFS & ~__GFP_DIRECT_RECLAIM);
+	INIT_RADIX_TREE(&dev->reada_extents, GFP_NOFS & ~__GFP_DIRECT_RECLAIM);
+	extent_io_tree_init(fs_info, &dev->alloc_state,
+			    IO_TREE_DEVICE_ALLOC_STATE, NULL);
 
 	if (devid)
 		tmp = *devid;
-- 
2.31.1

