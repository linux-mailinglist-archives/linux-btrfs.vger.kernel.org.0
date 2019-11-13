Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C2875FAE76
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Nov 2019 11:27:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727399AbfKMK1o (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 13 Nov 2019 05:27:44 -0500
Received: from mx2.suse.de ([195.135.220.15]:48192 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726422AbfKMK1i (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 13 Nov 2019 05:27:38 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id F251FB5F9;
        Wed, 13 Nov 2019 10:27:36 +0000 (UTC)
From:   Johannes Thumshirn <jthumshirn@suse.de>
To:     David Sterba <dsterba@suse.com>
Cc:     Qu Wenru <wqu@suse.com>,
        Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>,
        Johannes Thumshirn <jthumshirn@suse.de>
Subject: [PATCH v2 2/7] btrfs: handle device allocation failure in btrfs_close_one_device()
Date:   Wed, 13 Nov 2019 11:27:23 +0100
Message-Id: <20191113102728.8835-3-jthumshirn@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191113102728.8835-1-jthumshirn@suse.de>
References: <20191113102728.8835-1-jthumshirn@suse.de>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

In btrfs_close_one_device() we're allocating a new device and if this
fails we BUG().

Move the allocation to the top of the function and return an error in case
it failed.

The BUG_ON() is temporarily moved to close_fs_devices(), the caller of
btrfs_close_one_device() as further work is pending to untangle this.

Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
---
 fs/btrfs/volumes.c | 27 +++++++++++++++++++++------
 1 file changed, 21 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 5ee26e7fca32..0a2a73907563 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -1061,12 +1061,17 @@ static void btrfs_close_bdev(struct btrfs_device *device)
 	blkdev_put(device->bdev, device->mode);
 }
 
-static void btrfs_close_one_device(struct btrfs_device *device)
+static int btrfs_close_one_device(struct btrfs_device *device)
 {
 	struct btrfs_fs_devices *fs_devices = device->fs_devices;
 	struct btrfs_device *new_device;
 	struct rcu_string *name;
 
+	new_device = btrfs_alloc_device(NULL, &device->devid,
+					device->uuid);
+	if (IS_ERR(new_device))
+		goto err_close_device;
+
 	if (test_bit(BTRFS_DEV_STATE_WRITEABLE, &device->dev_state) &&
 	    device->devid != BTRFS_DEV_REPLACE_DEVID) {
 		list_del_init(&device->dev_alloc_list);
@@ -1080,10 +1085,6 @@ static void btrfs_close_one_device(struct btrfs_device *device)
 	if (device->bdev)
 		fs_devices->open_devices--;
 
-	new_device = btrfs_alloc_device(NULL, &device->devid,
-					device->uuid);
-	BUG_ON(IS_ERR(new_device)); /* -ENOMEM */
-
 	/* Safe because we are under uuid_mutex */
 	if (device->name) {
 		name = rcu_string_strdup(device->name->str, GFP_NOFS);
@@ -1096,18 +1097,32 @@ static void btrfs_close_one_device(struct btrfs_device *device)
 
 	synchronize_rcu();
 	btrfs_free_device(device);
+
+	return 0;
+
+err_close_device:
+	btrfs_close_bdev(device);
+	if (device->bdev) {
+		fs_devices->open_devices--;
+		btrfs_sysfs_rm_device_link(fs_devices, device);
+		device->bdev = NULL;
+	}
+
+	return -ENOMEM;
 }
 
 static int close_fs_devices(struct btrfs_fs_devices *fs_devices)
 {
 	struct btrfs_device *device, *tmp;
+	int ret;
 
 	if (--fs_devices->opened > 0)
 		return 0;
 
 	mutex_lock(&fs_devices->device_list_mutex);
 	list_for_each_entry_safe(device, tmp, &fs_devices->devices, dev_list) {
-		btrfs_close_one_device(device);
+		ret = btrfs_close_one_device(device);
+		BUG_ON(ret); /* -ENOMEM */
 	}
 	mutex_unlock(&fs_devices->device_list_mutex);
 
-- 
2.16.4

