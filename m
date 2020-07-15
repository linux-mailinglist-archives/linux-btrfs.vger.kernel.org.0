Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AE70220A70
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Jul 2020 12:49:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729456AbgGOKs4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 Jul 2020 06:48:56 -0400
Received: from [195.135.220.15] ([195.135.220.15]:37962 "EHLO mx2.suse.de"
        rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
        id S1727075AbgGOKsz (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 Jul 2020 06:48:55 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id EEB75B0B7;
        Wed, 15 Jul 2020 10:48:55 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 5/5] btrfs: Switch seed device to list api
Date:   Wed, 15 Jul 2020 13:48:50 +0300
Message-Id: <20200715104850.19071-6-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200715104850.19071-1-nborisov@suse.com>
References: <20200715104850.19071-1-nborisov@suse.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

While this patch touches a bunch of files the conversion is
straighforward. Instead of using the implicit linked list anchored at
btrfs_fs_devices::seed the code is switched to using
list_for_each_entry. Previous patches in the series already factored out
code that processed both main and seed devices so in those cases
the factored out functions are called on the main fs_devices and then
on every seed dev inside list_for_each_entry.

Using list api also allows to simplify deletion from the seed dev list
performed in btrfs_rm_device and btrfs_rm_dev_replace_free_srcdev by
substituting a while() loop with a simple list_del_init.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/disk-io.c |  39 ++++++++---------
 fs/btrfs/reada.c   |   9 ++--
 fs/btrfs/volumes.c | 102 ++++++++++++++++++++++-----------------------
 fs/btrfs/volumes.h |   2 +-
 4 files changed, 72 insertions(+), 80 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 2fb0b43bc1c5..8767d47f6e29 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -545,33 +545,30 @@ static int csum_dirty_buffer(struct btrfs_fs_info *fs_info, struct page *page)
 static int check_tree_block_fsid(struct extent_buffer *eb)
 {
 	struct btrfs_fs_info *fs_info = eb->fs_info;
-	struct btrfs_fs_devices *fs_devices = fs_info->fs_devices;
+	struct btrfs_fs_devices *fs_devices = fs_info->fs_devices, *seed_devs;
 	u8 fsid[BTRFS_FSID_SIZE];
-	int ret = 1;
+	u8 *metadata_uuid;
 
 	read_extent_buffer(eb, fsid, offsetof(struct btrfs_header, fsid),
 			   BTRFS_FSID_SIZE);
-	while (fs_devices) {
-		u8 *metadata_uuid;
+	/*
+	 * Checking the incompat flag is only valid for the current
+	 * fs. For seed devices it's forbidden to have their uuid
+	 * changed so reading ->fsid in this case is fine
+	 */
+	if (btrfs_fs_incompat(fs_info, METADATA_UUID))
+		metadata_uuid = fs_devices->metadata_uuid;
+	else
+		metadata_uuid = fs_devices->fsid;
 
-		/*
-		 * Checking the incompat flag is only valid for the current
-		 * fs. For seed devices it's forbidden to have their uuid
-		 * changed so reading ->fsid in this case is fine
-		 */
-		if (fs_devices == fs_info->fs_devices &&
-		    btrfs_fs_incompat(fs_info, METADATA_UUID))
-			metadata_uuid = fs_devices->metadata_uuid;
-		else
-			metadata_uuid = fs_devices->fsid;
+	if (!memcmp(fsid, metadata_uuid, BTRFS_FSID_SIZE))
+		return 0;
 
-		if (!memcmp(fsid, metadata_uuid, BTRFS_FSID_SIZE)) {
-			ret = 0;
-			break;
-		}
-		fs_devices = fs_devices->seed;
-	}
-	return ret;
+	list_for_each_entry(seed_devs, &fs_devices->seed_list, seed_list)
+		if (!memcmp(fsid, seed_devs->fsid, BTRFS_FSID_SIZE))
+			return 0;
+
+	return 1;
 }
 
 static int btree_readpage_end_io_hook(struct btrfs_io_bio *io_bio,
diff --git a/fs/btrfs/reada.c b/fs/btrfs/reada.c
index aa9d24ed56d7..ac5b07ded0fe 100644
--- a/fs/btrfs/reada.c
+++ b/fs/btrfs/reada.c
@@ -792,16 +792,13 @@ static int __reada_start_for_fsdevs(struct btrfs_fs_devices *fs_devices)
 
 static void __reada_start_machine(struct btrfs_fs_info *fs_info)
 {
-	struct btrfs_fs_devices *fs_devices = fs_info->fs_devices;
+	struct btrfs_fs_devices *fs_devices = fs_info->fs_devices, *seed_devs;
 	int i;
 	u64 enqueued = 0;
 
-again:
 	enqueued += __reada_start_for_fsdevs(fs_devices);
-	if (fs_devices->seed) {
-		fs_devices = fs_devices->seed;
-		goto again;
-	}
+	list_for_each_entry(seed_devs, &fs_devices->seed_list, seed_list)
+		enqueued += __reada_start_for_fsdevs(seed_devs);
 
 	if (enqueued == 0)
 		return;
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index a0cdd027e99c..7fce7a220a76 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -350,6 +350,7 @@ static struct btrfs_fs_devices *alloc_fs_devices(const u8 *fsid,
 	INIT_LIST_HEAD(&fs_devs->devices);
 	INIT_LIST_HEAD(&fs_devs->alloc_list);
 	INIT_LIST_HEAD(&fs_devs->fs_list);
+	INIT_LIST_HEAD(&fs_devs->seed_list);
 	if (fsid)
 		memcpy(fs_devs->fsid, fsid, BTRFS_FSID_SIZE);
 
@@ -1087,14 +1088,13 @@ void __btrfs_free_extra_devids(struct btrfs_fs_devices *fs_devices, int step,
 void btrfs_free_extra_devids(struct btrfs_fs_devices *fs_devices, int step)
 {
 	struct btrfs_device *latest_dev = NULL;
+	struct btrfs_fs_devices *seed_dev;
 
 	mutex_lock(&uuid_mutex);
-again:
 	__btrfs_free_extra_devids(fs_devices, step, &latest_dev);
-	if (fs_devices->seed) {
-		fs_devices = fs_devices->seed;
-		goto again;
-	}
+
+	list_for_each_entry(seed_dev, &fs_devices->seed_list, seed_list)
+		__btrfs_free_extra_devids(seed_dev, step, &latest_dev);
 
 	fs_devices->latest_bdev = latest_dev->bdev;
 
@@ -1168,20 +1168,18 @@ static void close_fs_devices(struct btrfs_fs_devices *fs_devices)
 
 void btrfs_close_devices(struct btrfs_fs_devices *fs_devices)
 {
-	struct btrfs_fs_devices *seed_devices = NULL;
+	LIST_HEAD(list);
+	struct btrfs_fs_devices *tmp;
 
 	mutex_lock(&uuid_mutex);
 	close_fs_devices(fs_devices);
-	if (!fs_devices->opened) {
-		seed_devices = fs_devices->seed;
-		fs_devices->seed = NULL;
-	}
+	if (!fs_devices->opened)
+		list_splice_init(&fs_devices->seed_list, &list);
 	mutex_unlock(&uuid_mutex);
 
-	while (seed_devices) {
-		fs_devices = seed_devices;
-		seed_devices = fs_devices->seed;
+	list_for_each_entry_safe(fs_devices, tmp, &list, seed_list) {
 		close_fs_devices(fs_devices);
+		list_del(&fs_devices->seed_list);
 		free_fs_devices(fs_devices);
 	}
 }
@@ -2154,14 +2152,7 @@ int btrfs_rm_device(struct btrfs_fs_info *fs_info, const char *device_path,
 	btrfs_free_device(device);
 
 	if (cur_devices->open_devices == 0) {
-		while (fs_devices) {
-			if (fs_devices->seed == cur_devices) {
-				fs_devices->seed = cur_devices->seed;
-				break;
-			}
-			fs_devices = fs_devices->seed;
-		}
-		cur_devices->seed = NULL;
+		list_del_init(&cur_devices->seed_list);
 		close_fs_devices(cur_devices);
 		free_fs_devices(cur_devices);
 	}
@@ -2236,14 +2227,7 @@ void btrfs_rm_dev_replace_free_srcdev(struct btrfs_device *srcdev)
 		ASSERT(fs_devices->seeding);
 
 		tmp_fs_devices = fs_info->fs_devices;
-		while (tmp_fs_devices) {
-			if (tmp_fs_devices->seed == fs_devices) {
-				tmp_fs_devices->seed = fs_devices->seed;
-				break;
-			}
-			tmp_fs_devices = tmp_fs_devices->seed;
-		}
-		fs_devices->seed = NULL;
+		list_del_init(&fs_devices->seed_list);
 		close_fs_devices(fs_devices);
 		free_fs_devices(fs_devices);
 	}
@@ -2397,7 +2381,7 @@ static int btrfs_prepare_sprout(struct btrfs_fs_info *fs_info)
 	fs_devices->open_devices = 0;
 	fs_devices->missing_devices = 0;
 	fs_devices->rotating = false;
-	fs_devices->seed = seed_devices;
+	list_add_tail(&seed_devices->seed_list, &fs_devices->seed_list);
 
 	generate_random_uuid(fs_devices->fsid);
 	memcpy(fs_devices->metadata_uuid, fs_devices->fsid, BTRFS_FSID_SIZE);
@@ -6430,11 +6414,23 @@ struct btrfs_device *btrfs_find_device(struct btrfs_fs_devices *fs_devices,
 				       bool seed)
 {
 	struct btrfs_device *device;
+	struct btrfs_fs_devices *seed_devs;
 
-	while (fs_devices) {
+	if (!fsid ||
+	    !memcmp(fs_devices->metadata_uuid, fsid, BTRFS_FSID_SIZE)) {
+		list_for_each_entry(device, &fs_devices->devices,
+				    dev_list) {
+			if (device->devid == devid &&
+			    (!uuid || memcmp(device->uuid, uuid,
+					     BTRFS_UUID_SIZE) == 0))
+				return device;
+		}
+	}
+
+	list_for_each_entry(seed_devs, &fs_devices->seed_list, seed_list) {
 		if (!fsid ||
-		    !memcmp(fs_devices->metadata_uuid, fsid, BTRFS_FSID_SIZE)) {
-			list_for_each_entry(device, &fs_devices->devices,
+		    !memcmp(seed_devs->metadata_uuid, fsid, BTRFS_FSID_SIZE)) {
+			list_for_each_entry(device, &seed_devs->devices,
 					    dev_list) {
 				if (device->devid == devid &&
 				    (!uuid || memcmp(device->uuid, uuid,
@@ -6442,11 +6438,8 @@ struct btrfs_device *btrfs_find_device(struct btrfs_fs_devices *fs_devices,
 					return device;
 			}
 		}
-		if (seed)
-			fs_devices = fs_devices->seed;
-		else
-			return NULL;
 	}
+
 	return NULL;
 }
 
@@ -6688,13 +6681,10 @@ static struct btrfs_fs_devices *open_seed_devices(struct btrfs_fs_info *fs_info,
 	lockdep_assert_held(&uuid_mutex);
 	ASSERT(fsid);
 
-	fs_devices = fs_info->fs_devices->seed;
-	while (fs_devices) {
+	list_for_each_entry(fs_devices, &fs_info->fs_devices->seed_list, seed_list)
 		if (!memcmp(fs_devices->fsid, fsid, BTRFS_FSID_SIZE))
 			return fs_devices;
 
-		fs_devices = fs_devices->seed;
-	}
 
 	fs_devices = find_fsid(fsid, NULL);
 	if (!fs_devices) {
@@ -6728,8 +6718,8 @@ static struct btrfs_fs_devices *open_seed_devices(struct btrfs_fs_info *fs_info,
 		goto out;
 	}
 
-	fs_devices->seed = fs_info->fs_devices->seed;
-	fs_info->fs_devices->seed = fs_devices;
+	ASSERT(list_empty(&fs_devices->seed_list));
+	list_add_tail(&fs_devices->seed_list, &fs_info->fs_devices->seed_list);
 out:
 	return fs_devices;
 }
@@ -7141,17 +7131,23 @@ int btrfs_read_chunk_tree(struct btrfs_fs_info *fs_info)
 
 void btrfs_init_devices_late(struct btrfs_fs_info *fs_info)
 {
-	struct btrfs_fs_devices *fs_devices = fs_info->fs_devices;
+	struct btrfs_fs_devices *fs_devices = fs_info->fs_devices, *seed_devs;
 	struct btrfs_device *device;
 
-	while (fs_devices) {
-		mutex_lock(&fs_devices->device_list_mutex);
-		list_for_each_entry(device, &fs_devices->devices, dev_list)
+	fs_devices->fs_info = fs_info;
+
+	mutex_lock(&fs_devices->device_list_mutex);
+	list_for_each_entry(device, &fs_devices->devices, dev_list)
+		device->fs_info = fs_info;
+	mutex_unlock(&fs_devices->device_list_mutex);
+
+	list_for_each_entry(seed_devs, &fs_devices->seed_list, seed_list) {
+		mutex_lock(&seed_devs->device_list_mutex);
+		list_for_each_entry(device, &seed_devs->devices, dev_list)
 			device->fs_info = fs_info;
-		mutex_unlock(&fs_devices->device_list_mutex);
+		mutex_unlock(&seed_devs->device_list_mutex);
 
-		fs_devices->fs_info = fs_info;
-		fs_devices = fs_devices->seed;
+		seed_devs->fs_info = fs_info;
 	}
 }
 
@@ -7527,8 +7523,10 @@ static int verify_one_dev_extent(struct btrfs_fs_info *fs_info,
 
 	/* It's possible this device is a dummy for seed device */
 	if (dev->disk_total_bytes == 0) {
-		dev = btrfs_find_device(fs_info->fs_devices->seed, devid, NULL,
-					NULL, false);
+		struct btrfs_fs_devices *devs;
+		devs = list_first_entry(&fs_info->fs_devices->seed_list,
+					struct btrfs_fs_devices, seed_list);
+		dev = btrfs_find_device(devs, devid, NULL, NULL, false);
 		if (!dev) {
 			btrfs_err(fs_info, "failed to find seed devid %llu",
 				  devid);
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index fc283fdbcece..709f4aacbd3f 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -246,7 +246,7 @@ struct btrfs_fs_devices {
 	 */
 	struct list_head alloc_list;
 
-	struct btrfs_fs_devices *seed;
+	struct list_head seed_list;
 	bool seeding;
 
 	int opened;
-- 
2.17.1

