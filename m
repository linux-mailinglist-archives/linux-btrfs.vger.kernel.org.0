Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89C1A3158A3
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Feb 2021 22:33:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234148AbhBIV1z (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 9 Feb 2021 16:27:55 -0500
Received: from mx2.suse.de ([195.135.220.15]:51930 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234152AbhBIUyW (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 9 Feb 2021 15:54:22 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 614F1B1E0;
        Tue,  9 Feb 2021 20:31:25 +0000 (UTC)
From:   Michal Rostecki <mrostecki@suse.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        linux-btrfs@vger.kernel.org (open list:BTRFS FILE SYSTEM),
        linux-kernel@vger.kernel.org (open list)
Cc:     Michal Rostecki <mrostecki@suse.com>
Subject: [PATCH RFC 4/6] btrfs: Check if the filesystem is has mixed type of devices
Date:   Tue,  9 Feb 2021 21:30:38 +0100
Message-Id: <20210209203041.21493-5-mrostecki@suse.de>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210209203041.21493-1-mrostecki@suse.de>
References: <20210209203041.21493-1-mrostecki@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Michal Rostecki <mrostecki@suse.com>

Add the btrfs_check_mixed() function which checks if the filesystem has
the mixed type of devices (non-rotational and rotational). This
information is going to be used in roundrobin raid1 read policy.

Signed-off-by: Michal Rostecki <mrostecki@suse.com>
---
 fs/btrfs/volumes.c | 44 ++++++++++++++++++++++++++++++++++++++++++--
 fs/btrfs/volumes.h |  7 +++++++
 2 files changed, 49 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 1ac364a2f105..1ad30a595722 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -617,6 +617,35 @@ static int btrfs_free_stale_devices(const char *path,
 	return ret;
 }
 
+/*
+ * Checks if after adding the new device the filesystem is going to have mixed
+ * types of devices (non-rotational and rotational).
+ *
+ * @fs_devices:          list of devices
+ * @new_device_rotating: if the new device is rotational
+ *
+ * Returns true if there are mixed types of devices, otherwise returns false.
+ */
+static bool btrfs_check_mixed(struct btrfs_fs_devices *fs_devices,
+			      bool new_device_rotating)
+{
+	struct btrfs_device *device, *prev_device;
+
+	list_for_each_entry(device, &fs_devices->devices, dev_list) {
+		if (prev_device == NULL &&
+		    device->rotating != new_device_rotating)
+			return true;
+		if (prev_device != NULL &&
+		    (device->rotating != prev_device->rotating ||
+		     device->rotating != new_device_rotating))
+			return true;
+
+		prev_device = device;
+	}
+
+	return false;
+}
+
 /*
  * This is only used on mount, and we are protected from competing things
  * messing with our fs_devices by the uuid_mutex, thus we do not need the
@@ -629,6 +658,7 @@ static int btrfs_open_one_device(struct btrfs_fs_devices *fs_devices,
 	struct request_queue *q;
 	struct block_device *bdev;
 	struct btrfs_super_block *disk_super;
+	bool rotating;
 	u64 devid;
 	int ret;
 
@@ -669,8 +699,12 @@ static int btrfs_open_one_device(struct btrfs_fs_devices *fs_devices,
 	}
 
 	q = bdev_get_queue(bdev);
-	if (!blk_queue_nonrot(q))
+	rotating = !blk_queue_nonrot(q);
+	device->rotating = rotating;
+	if (rotating)
 		fs_devices->rotating = true;
+	if (!fs_devices->mixed)
+		fs_devices->mixed = btrfs_check_mixed(fs_devices, rotating);
 
 	device->bdev = bdev;
 	clear_bit(BTRFS_DEV_STATE_IN_FS_METADATA, &device->dev_state);
@@ -2418,6 +2452,7 @@ static int btrfs_prepare_sprout(struct btrfs_fs_info *fs_info)
 	fs_devices->open_devices = 0;
 	fs_devices->missing_devices = 0;
 	fs_devices->rotating = false;
+	fs_devices->mixed = false;
 	list_add(&seed_devices->seed_list, &fs_devices->seed_list);
 
 	generate_random_uuid(fs_devices->fsid);
@@ -2522,6 +2557,7 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
 	int seeding_dev = 0;
 	int ret = 0;
 	bool locked = false;
+	bool rotating;
 
 	if (sb_rdonly(sb) && !fs_devices->seeding)
 		return -EROFS;
@@ -2621,8 +2657,12 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
 
 	atomic64_add(device->total_bytes, &fs_info->free_chunk_space);
 
-	if (!blk_queue_nonrot(q))
+	rotating = !blk_queue_nonrot(q);
+	device->rotating = rotating;
+	if (rotating)
 		fs_devices->rotating = true;
+	if (!fs_devices->mixed)
+		fs_devices->mixed = btrfs_check_mixed(fs_devices, rotating);
 
 	orig_super_total_bytes = btrfs_super_total_bytes(fs_info->super_copy);
 	btrfs_set_super_total_bytes(fs_info->super_copy,
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index 6e544317a377..594f1207281c 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -147,6 +147,9 @@ struct btrfs_device {
 	/* I/O stats for raid1 mirror selection */
 	struct percpu_counter inflight;
 	atomic_t last_offset;
+
+	/* If the device is rotational */
+	bool rotating;
 };
 
 /*
@@ -274,6 +277,10 @@ struct btrfs_fs_devices {
 	 * nonrot flag set
 	 */
 	bool rotating;
+	/* Set when we find or add both nonrot and rot disks in the
+	 * filesystem
+	 */
+	bool mixed;
 
 	struct btrfs_fs_info *fs_info;
 	/* sysfs kobjects */
-- 
2.30.0

