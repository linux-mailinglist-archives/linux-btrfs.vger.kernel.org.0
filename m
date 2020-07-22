Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF430229320
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Jul 2020 10:09:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729114AbgGVIJ2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 22 Jul 2020 04:09:28 -0400
Received: from mx2.suse.de ([195.135.220.15]:45710 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727819AbgGVIJ1 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 22 Jul 2020 04:09:27 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 1A067AFEA;
        Wed, 22 Jul 2020 08:09:34 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 1/4] btrfs: Use rcu when iterating devices in btrfs_init_new_device
Date:   Wed, 22 Jul 2020 11:09:22 +0300
Message-Id: <20200722080925.6802-2-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200722080925.6802-1-nborisov@suse.com>
References: <20200722080925.6802-1-nborisov@suse.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

When adding a new device there's a mandatory check to see if a device is
being duplicated to the filesystem it's added to. Since this is a
read-only operations not necessary to take device_list_mutex and can simply
make do with an rcu-readlock. No semantics changes.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/volumes.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 9f338d9db51b..0795ab511f8b 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -2502,16 +2502,15 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
 
 	filemap_write_and_wait(bdev->bd_inode->i_mapping);
 
-	mutex_lock(&fs_devices->device_list_mutex);
-	list_for_each_entry(device, &fs_devices->devices, dev_list) {
+	rcu_read_lock();
+	list_for_each_entry_rcu(device, &fs_devices->devices, dev_list) {
 		if (device->bdev == bdev) {
 			ret = -EEXIST;
-			mutex_unlock(
-				&fs_devices->device_list_mutex);
+			rcu_read_unlock();
 			goto error;
 		}
 	}
-	mutex_unlock(&fs_devices->device_list_mutex);
+	rcu_read_unlock();
 
 	device = btrfs_alloc_device(fs_info, NULL, NULL);
 	if (IS_ERR(device)) {
-- 
2.17.1

