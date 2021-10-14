Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B11F642DDEB
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Oct 2021 17:17:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232508AbhJNPTQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 14 Oct 2021 11:19:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231171AbhJNPTP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 14 Oct 2021 11:19:15 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3DE4C061570
        for <linux-btrfs@vger.kernel.org>; Thu, 14 Oct 2021 08:17:10 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id k29so3918214qve.6
        for <linux-btrfs@vger.kernel.org>; Thu, 14 Oct 2021 08:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uEg4gVKEuGMxLW3SHMoq7BD/ZzXwJUGRaCrus4XGO1E=;
        b=WMdgxZoVzFYQ1RhLmQUO0aHTswriu7SiQMFxXN4qNGPbLxRAJauKUrsr+oo6QkBX27
         VvhykyrvXZheaXvgpnWJoBXYT9QrqN5UhYpPSRvazFsuzZsCjC7SZC87C98p2SeE2u39
         bNIVgaYDHFC0JmlpiQroaNziBoeeyfmBSDDnHC4wz+swNb3/AXA6Z7oiQ9A+ETMLf28o
         kSIUKf5ST3xy3PoHYgVll8sKiQDcTeeXXjK6yNwyeYtOh13wZQKl9JhgKIC2BDPTlnHm
         cphM5h8eHuXVf3oXLiKKTXLW1mpJxwbVtGYpG2QjUXGcuuMw9vqAoWccqSSekfLzM9p/
         fROQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uEg4gVKEuGMxLW3SHMoq7BD/ZzXwJUGRaCrus4XGO1E=;
        b=4gIG0U5ZgU6K3A5aXW4h0Dnugha1tYYl8tm+Z76x15TN311dvLclpBZyr/mVIz+dWs
         lOD82NsC49xqRUg0GPD3aaappw9ceRegzgQ1XGQB9Hg+BNZWubh3rnTFrAJZdPZOeSgt
         LiwjPqJ8GAbnbAnYYz5ZVAEbMeeesA6rQilMqB/jD/NWDxIYksbkmbyQNXpEt0iLfHAL
         U3Sj86arUTNBO8qSPzV+T5qzUo2kq31fUA6u5iVd+aN7U6s+JMoKkZak5/Zp+Tsut93z
         oqhtonT6U1Qg1x9YRbk4nrVFwQ91CrBBlnrZ1NdHhTqwkgoaj5P0BnH26zHArWQRjpnn
         eDJA==
X-Gm-Message-State: AOAM531OFTNzb2gIsjNBcK9NfkIxVyY1gOKugAwGAe4JL6kNnOX0OzUG
        Hu8LmByQc7RpRl80/XhQdE4xwguD98o=
X-Google-Smtp-Source: ABdhPJyFdPYct74Wrybl5xaOE4dehbrn4FrLm59brKzKcA3q2gfu3a/X7lsjYPfLzMxnR9zjeODEiQ==
X-Received: by 2002:ad4:5fce:: with SMTP id jq14mr5991411qvb.33.1634224629434;
        Thu, 14 Oct 2021 08:17:09 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id a4sm1556547qtm.12.2021.10.14.08.17.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Oct 2021 08:17:09 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Christoph Hellwig <hch@lst.de>
Subject: [PATCH] btrfs: update device path inode time instead of bd_inode
Date:   Thu, 14 Oct 2021 11:17:08 -0400
Message-Id: <00b8cf32502e30403b9849a73e62f4ad5175fded.1634224611.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Christoph pointed out that I'm updating bdev->bd_inode for the device
time when we remove block devices from a btrfs file system, however this
isn't actually exposed to anything.  The inode we want to update is the
one that's associated with the path to the device, usually on devtmpfs,
so that blkid notices the difference.

We still don't want to do the blkdev_open, so use kern_path() to get the
path to the given device and do the update time on that inode.

Fixes: 8f96a5bfa150 ("btrfs: update the bdev time directly when closing")
Reported-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/volumes.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 6031e2f4c6bc..c460f76b7033 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -14,6 +14,7 @@
 #include <linux/semaphore.h>
 #include <linux/uuid.h>
 #include <linux/list_sort.h>
+#include <linux/namei.h>
 #include "misc.h"
 #include "ctree.h"
 #include "extent_map.h"
@@ -1882,18 +1883,22 @@ static int btrfs_add_dev_item(struct btrfs_trans_handle *trans,
 /*
  * Function to update ctime/mtime for a given device path.
  * Mainly used for ctime/mtime based probe like libblkid.
+ *
+ * We don't care about errors here, this is just to be kind to userspace.
  */
-static void update_dev_time(struct block_device *bdev)
+static void update_dev_time(const char *device_path)
 {
-	struct inode *inode = bdev->bd_inode;
+	struct path path;
 	struct timespec64 now;
+	int ret;
 
-	/* Shouldn't happen but just in case. */
-	if (!inode)
+	ret = kern_path(device_path, LOOKUP_FOLLOW, &path);
+	if (ret)
 		return;
 
-	now = current_time(inode);
-	generic_update_time(inode, &now, S_MTIME | S_CTIME);
+	now = current_time(d_inode(path.dentry));
+	generic_update_time(d_inode(path.dentry), &now, S_MTIME | S_CTIME);
+	path_put(&path);
 }
 
 static int btrfs_rm_dev_item(struct btrfs_device *device)
@@ -2069,7 +2074,7 @@ void btrfs_scratch_superblocks(struct btrfs_fs_info *fs_info,
 	btrfs_kobject_uevent(bdev, KOBJ_CHANGE);
 
 	/* Update ctime/mtime for device path for libblkid */
-	update_dev_time(bdev);
+	update_dev_time(device_path);
 }
 
 int btrfs_rm_device(struct btrfs_fs_info *fs_info, const char *device_path,
@@ -2728,7 +2733,7 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
 	btrfs_forget_devices(device_path);
 
 	/* Update ctime/mtime for blkid or udev */
-	update_dev_time(bdev);
+	update_dev_time(device_path);
 
 	return ret;
 
-- 
2.26.3

