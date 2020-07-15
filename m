Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13BB6220A71
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Jul 2020 12:49:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729444AbgGOKs6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 Jul 2020 06:48:58 -0400
Received: from [195.135.220.15] ([195.135.220.15]:37938 "EHLO mx2.suse.de"
        rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
        id S1729337AbgGOKsy (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 Jul 2020 06:48:54 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 7A129AD93;
        Wed, 15 Jul 2020 10:48:55 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 3/5] btrfs: Make close_fs_devices return void
Date:   Wed, 15 Jul 2020 13:48:48 +0300
Message-Id: <20200715104850.19071-4-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200715104850.19071-1-nborisov@suse.com>
References: <20200715104850.19071-1-nborisov@suse.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The return value of this function conveys absolutely no information.
All callers already check the state of  fs_devices->opened to decide
how to proceed. So conver the function to returning void. While at it
make btrfs_close_devices also return void.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/volumes.c | 12 ++++--------
 fs/btrfs/volumes.h |  2 +-
 2 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index db29fc4fbe89..6de021c78277 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -1146,12 +1146,12 @@ static void btrfs_close_one_device(struct btrfs_device *device)
 	ASSERT(atomic_read(&device->reada_in_flight) == 0);
 }
 
-static int close_fs_devices(struct btrfs_fs_devices *fs_devices)
+static void close_fs_devices(struct btrfs_fs_devices *fs_devices)
 {
 	struct btrfs_device *device, *tmp;
 
 	if (--fs_devices->opened > 0)
-		return 0;
+		return;
 
 	mutex_lock(&fs_devices->device_list_mutex);
 	list_for_each_entry_safe(device, tmp, &fs_devices->devices, dev_list) {
@@ -1163,17 +1163,14 @@ static int close_fs_devices(struct btrfs_fs_devices *fs_devices)
 	WARN_ON(fs_devices->rw_devices);
 	fs_devices->opened = 0;
 	fs_devices->seeding = false;
-
-	return 0;
 }
 
-int btrfs_close_devices(struct btrfs_fs_devices *fs_devices)
+void btrfs_close_devices(struct btrfs_fs_devices *fs_devices)
 {
 	struct btrfs_fs_devices *seed_devices = NULL;
-	int ret;
 
 	mutex_lock(&uuid_mutex);
-	ret = close_fs_devices(fs_devices);
+	close_fs_devices(fs_devices);
 	if (!fs_devices->opened) {
 		seed_devices = fs_devices->seed;
 		fs_devices->seed = NULL;
@@ -1186,7 +1183,6 @@ int btrfs_close_devices(struct btrfs_fs_devices *fs_devices)
 		close_fs_devices(fs_devices);
 		free_fs_devices(fs_devices);
 	}
-	return ret;
 }
 
 static int open_fs_devices(struct btrfs_fs_devices *fs_devices,
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index 5eea93916fbf..76e5470e19a8 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -435,7 +435,7 @@ int btrfs_open_devices(struct btrfs_fs_devices *fs_devices,
 struct btrfs_device *btrfs_scan_one_device(const char *path,
 					   fmode_t flags, void *holder);
 int btrfs_forget_devices(const char *path);
-int btrfs_close_devices(struct btrfs_fs_devices *fs_devices);
+void btrfs_close_devices(struct btrfs_fs_devices *fs_devices);
 void btrfs_free_extra_devids(struct btrfs_fs_devices *fs_devices, int step);
 void btrfs_assign_next_active_device(struct btrfs_device *device,
 				     struct btrfs_device *this_dev);
-- 
2.17.1

