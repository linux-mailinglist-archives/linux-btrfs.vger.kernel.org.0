Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 444C6229321
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Jul 2020 10:09:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728053AbgGVIJ2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 22 Jul 2020 04:09:28 -0400
Received: from mx2.suse.de ([195.135.220.15]:45718 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728760AbgGVIJ2 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 22 Jul 2020 04:09:28 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 4BF16AFF1;
        Wed, 22 Jul 2020 08:09:34 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 2/4] btrfs: Refactor locked condition in btrfs_init_new_device
Date:   Wed, 22 Jul 2020 11:09:23 +0300
Message-Id: <20200722080925.6802-3-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200722080925.6802-1-nborisov@suse.com>
References: <20200722080925.6802-1-nborisov@suse.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Invert unlocked to locked and exploit the fact it can only ever be
modified if we are adding a new device to a seed filesystem. This allows
to simplify the check in error: label. No semantics changes.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/volumes.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 0795ab511f8b..384614fe0e2a 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -2484,7 +2484,7 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
 	u64 orig_super_num_devices;
 	int seeding_dev = 0;
 	int ret = 0;
-	bool unlocked = false;
+	bool locked = false;
 
 	if (sb_rdonly(sb) && !fs_devices->seeding)
 		return -EROFS;
@@ -2498,6 +2498,7 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
 		seeding_dev = 1;
 		down_write(&sb->s_umount);
 		mutex_lock(&uuid_mutex);
+		locked = true;
 	}
 
 	filemap_write_and_wait(bdev->bd_inode->i_mapping);
@@ -2629,7 +2630,7 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
 	if (seeding_dev) {
 		mutex_unlock(&uuid_mutex);
 		up_write(&sb->s_umount);
-		unlocked = true;
+		locked = false;
 
 		if (ret) /* transaction commit */
 			return ret;
@@ -2690,7 +2691,7 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
 	btrfs_free_device(device);
 error:
 	blkdev_put(bdev, FMODE_EXCL);
-	if (seeding_dev && !unlocked) {
+	if (locked) {
 		mutex_unlock(&uuid_mutex);
 		up_write(&sb->s_umount);
 	}
-- 
2.17.1

