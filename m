Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 58C54FAE75
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Nov 2019 11:27:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727388AbfKMK1n (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 13 Nov 2019 05:27:43 -0500
Received: from mx2.suse.de ([195.135.220.15]:48200 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726613AbfKMK1i (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 13 Nov 2019 05:27:38 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 0AFDCB5FA;
        Wed, 13 Nov 2019 10:27:37 +0000 (UTC)
From:   Johannes Thumshirn <jthumshirn@suse.de>
To:     David Sterba <dsterba@suse.com>
Cc:     Qu Wenru <wqu@suse.com>,
        Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>,
        Johannes Thumshirn <jthumshirn@suse.de>
Subject: [PATCH v2 3/7] btrfs: handle allocation failure in strdup
Date:   Wed, 13 Nov 2019 11:27:24 +0100
Message-Id: <20191113102728.8835-4-jthumshirn@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191113102728.8835-1-jthumshirn@suse.de>
References: <20191113102728.8835-1-jthumshirn@suse.de>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Gracefully handle allocation failures in btrfs_close_one_device()'s
rcu_string_strdup() instead of crashing the machine.

Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
---
 fs/btrfs/volumes.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 0a2a73907563..e5864ca3bb3b 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -1064,7 +1064,7 @@ static void btrfs_close_bdev(struct btrfs_device *device)
 static int btrfs_close_one_device(struct btrfs_device *device)
 {
 	struct btrfs_fs_devices *fs_devices = device->fs_devices;
-	struct btrfs_device *new_device;
+	struct btrfs_device *new_device = NULL;
 	struct rcu_string *name;
 
 	new_device = btrfs_alloc_device(NULL, &device->devid,
@@ -1072,6 +1072,15 @@ static int btrfs_close_one_device(struct btrfs_device *device)
 	if (IS_ERR(new_device))
 		goto err_close_device;
 
+	/* Safe because we are under uuid_mutex */
+	if (device->name) {
+		name = rcu_string_strdup(device->name->str, GFP_NOFS);
+		if (!name)
+			goto err_free_device;
+
+		rcu_assign_pointer(new_device->name, name);
+	}
+
 	if (test_bit(BTRFS_DEV_STATE_WRITEABLE, &device->dev_state) &&
 	    device->devid != BTRFS_DEV_REPLACE_DEVID) {
 		list_del_init(&device->dev_alloc_list);
@@ -1085,13 +1094,6 @@ static int btrfs_close_one_device(struct btrfs_device *device)
 	if (device->bdev)
 		fs_devices->open_devices--;
 
-	/* Safe because we are under uuid_mutex */
-	if (device->name) {
-		name = rcu_string_strdup(device->name->str, GFP_NOFS);
-		BUG_ON(!name); /* -ENOMEM */
-		rcu_assign_pointer(new_device->name, name);
-	}
-
 	list_replace_rcu(&device->dev_list, &new_device->dev_list);
 	new_device->fs_devices = device->fs_devices;
 
@@ -1100,6 +1102,10 @@ static int btrfs_close_one_device(struct btrfs_device *device)
 
 	return 0;
 
+err_free_device:
+	if (new_device)
+		btrfs_free_device(new_device);
+
 err_close_device:
 	btrfs_close_bdev(device);
 	if (device->bdev) {
-- 
2.16.4

