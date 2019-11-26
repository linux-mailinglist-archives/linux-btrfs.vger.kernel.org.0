Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6C182109A50
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Nov 2019 09:40:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbfKZIkK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 26 Nov 2019 03:40:10 -0500
Received: from mx2.suse.de ([195.135.220.15]:48196 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725943AbfKZIkJ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 26 Nov 2019 03:40:09 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 399AFAE99;
        Tue, 26 Nov 2019 08:40:08 +0000 (UTC)
From:   Johannes Thumshirn <jthumshirn@suse.de>
To:     David Sterba <dsterba@suse.com>
Cc:     Nikolay Borisov <nborisov@suse.com>, Qu Wenruo <wqu@suse.com>,
        Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>,
        Johannes Thumshirn <jthumshirn@suse.de>
Subject: [PATCH v4 2/2] btrfs: reset device back to allocation state when removing
Date:   Tue, 26 Nov 2019 09:40:06 +0100
Message-Id: <20191126084006.23262-3-jthumshirn@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191126084006.23262-1-jthumshirn@suse.de>
References: <20191126084006.23262-1-jthumshirn@suse.de>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

When closing a device, btrfs_close_one_device() first allocates a new
device, copies the device to close's name, replaces it in the dev_list
with the copy and then finally frees it.

This involves two memory allocation, which can potentially fail. As this
code path is tricky to unwind, the allocation failures where handled by
BUG_ON()s.

But this copying isn't strictly needed, all that is needed is resetting
the device in question to it's state it had after the allocation.

Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>

---
Changes to v3:
- Clear DEV_STATE_WRITABLE _after_ btrfs_close_bdev() (Nik)
---
 fs/btrfs/volumes.c | 38 +++++++++++++++++---------------------
 1 file changed, 17 insertions(+), 21 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 2398b071bcf6..efabffa54a45 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -1064,8 +1064,6 @@ static void btrfs_close_bdev(struct btrfs_device *device)
 static void btrfs_close_one_device(struct btrfs_device *device)
 {
 	struct btrfs_fs_devices *fs_devices = device->fs_devices;
-	struct btrfs_device *new_device;
-	struct rcu_string *name;
 
 	if (test_bit(BTRFS_DEV_STATE_WRITEABLE, &device->dev_state) &&
 	    device->devid != BTRFS_DEV_REPLACE_DEVID) {
@@ -1073,29 +1071,27 @@ static void btrfs_close_one_device(struct btrfs_device *device)
 		fs_devices->rw_devices--;
 	}
 
-	if (test_bit(BTRFS_DEV_STATE_MISSING, &device->dev_state))
+	if (test_bit(BTRFS_DEV_STATE_MISSING, &device->dev_state)) {
 		fs_devices->missing_devices--;
+		clear_bit(BTRFS_DEV_STATE_MISSING, &device->dev_state);
+	}
 
+	clear_bit(BTRFS_DEV_STATE_IN_FS_METADATA, &device->dev_state);
 	btrfs_close_bdev(device);
-	if (device->bdev)
+	if (device->bdev) {
 		fs_devices->open_devices--;
-
-	new_device = btrfs_alloc_device(NULL, &device->devid,
-					device->uuid);
-	BUG_ON(IS_ERR(new_device)); /* -ENOMEM */
-
-	/* Safe because we are under uuid_mutex */
-	if (device->name) {
-		name = rcu_string_strdup(device->name->str, GFP_NOFS);
-		BUG_ON(!name); /* -ENOMEM */
-		rcu_assign_pointer(new_device->name, name);
-	}
-
-	list_replace_rcu(&device->dev_list, &new_device->dev_list);
-	new_device->fs_devices = device->fs_devices;
-
-	synchronize_rcu();
-	btrfs_free_device(device);
+		device->bdev = NULL;
+	}
+	clear_bit(BTRFS_DEV_STATE_WRITEABLE, &device->dev_state);
+
+	/* Verify the device is back in a pristine state  */
+	ASSERT(!test_bit(BTRFS_DEV_STATE_FLUSH_SENT, &device->dev_state));
+	ASSERT(!test_bit(BTRFS_DEV_STATE_REPLACE_TGT, &device->dev_state));
+	ASSERT(list_empty(&device->dev_alloc_list));
+	ASSERT(list_empty(&device->post_commit_list));
+	ASSERT(atomic_read(&device->reada_in_flight) == 0);
+	ASSERT(atomic_read(&device->dev_stats_ccnt) == 0);
+	ASSERT(RB_EMPTY_ROOT(&device->alloc_state.state));
 }
 
 static int close_fs_devices(struct btrfs_fs_devices *fs_devices)
-- 
2.16.4

