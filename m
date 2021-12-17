Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E43DE479464
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Dec 2021 19:53:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240500AbhLQSwb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Dec 2021 13:52:31 -0500
Received: from santino.mail.tiscali.it ([213.205.33.245]:53000 "EHLO
        smtp.tiscali.it" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S240519AbhLQSw0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Dec 2021 13:52:26 -0500
X-Greylist: delayed 304 seconds by postgrey-1.27 at vger.kernel.org; Fri, 17 Dec 2021 13:52:21 EST
Received: from venice.bhome ([78.12.25.242])
        by santino.mail.tiscali.it with 
        id XWnP2601f5DQHji01WnSru; Fri, 17 Dec 2021 18:47:27 +0000
X-Spam-Final-Verdict: clean
X-Spam-State: 0
X-Spam-Score: -100
X-Spam-Verdict: clean
x-auth-user: kreijack@tiscali.it
From:   Goffredo Baroncelli <kreijack@tiscali.it>
To:     linux-btrfs@vger.kernel.org
Cc:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.cz>,
        Sinnamohideen Shafeeq <shafeeqs@panasas.com>,
        Paul Jones <paul@pauljones.id.au>,
        Goffredo Baroncelli <kreijack@inwind.it>
Subject: [PATCH 5/6] btrfs: rename dev_item->type to dev_item->flags
Date:   Fri, 17 Dec 2021 19:47:21 +0100
Message-Id: <c03fe9a171e6e377a345dfebc56c6c49dfa494c3.1639766364.git.kreijack@inwind.it>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1639766364.git.kreijack@inwind.it>
References: <cover.1639766364.git.kreijack@inwind.it>
Reply-To: Goffredo Baroncelli <kreijack@libero.it>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tiscali.it; s=smtp;
        t=1639766847; bh=8qdEf8vUUxuTZ21PV9N1pj2eUYcmTxXdmeXdB/BTiyQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
        b=z6XZTqzovjedmVAS0GyG1SUzXZ5TAewK4k4Bml5ggxLJA0jh/4WihbLUEYj1Jjv1+
         HOiOyYzrM5LXxYv0T5ekB3JRxvfUUpjubsLF8ES3+k3HhGcHtASHASJbe7ALQFYf41
         Sv1//fx6VHSQb63z1VdckVHeVb4zVRKw5eQ52KFY=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Goffredo Baroncelli <kreijack@inwind.it>

Rename the field type of dev_item from 'type' to 'flags' changing the
struct btrfs_device and btrfs_dev_item.

Signed-off-by: Goffredo Baroncelli <krejack@inwind.it>
---
 fs/btrfs/ctree.h                |  4 ++--
 fs/btrfs/disk-io.c              |  2 +-
 fs/btrfs/sysfs.c                | 17 +++++++++--------
 fs/btrfs/volumes.c              | 10 +++++-----
 fs/btrfs/volumes.h              |  4 ++--
 include/uapi/linux/btrfs_tree.h |  4 ++--
 6 files changed, 21 insertions(+), 20 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 459d00211181..778c7c807289 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -1669,7 +1669,7 @@ static inline void btrfs_set_device_total_bytes(const struct extent_buffer *eb,
 }
 
 
-BTRFS_SETGET_FUNCS(device_type, struct btrfs_dev_item, type, 64);
+BTRFS_SETGET_FUNCS(device_flags, struct btrfs_dev_item, flags, 64);
 BTRFS_SETGET_FUNCS(device_bytes_used, struct btrfs_dev_item, bytes_used, 64);
 BTRFS_SETGET_FUNCS(device_io_align, struct btrfs_dev_item, io_align, 32);
 BTRFS_SETGET_FUNCS(device_io_width, struct btrfs_dev_item, io_width, 32);
@@ -1682,7 +1682,7 @@ BTRFS_SETGET_FUNCS(device_seek_speed, struct btrfs_dev_item, seek_speed, 8);
 BTRFS_SETGET_FUNCS(device_bandwidth, struct btrfs_dev_item, bandwidth, 8);
 BTRFS_SETGET_FUNCS(device_generation, struct btrfs_dev_item, generation, 64);
 
-BTRFS_SETGET_STACK_FUNCS(stack_device_type, struct btrfs_dev_item, type, 64);
+BTRFS_SETGET_STACK_FUNCS(stack_device_flags, struct btrfs_dev_item, flags, 64);
 BTRFS_SETGET_STACK_FUNCS(stack_device_total_bytes, struct btrfs_dev_item,
 			 total_bytes, 64);
 BTRFS_SETGET_STACK_FUNCS(stack_device_bytes_used, struct btrfs_dev_item,
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index fc7dd5109806..02ffb8bc7d6b 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -4342,7 +4342,7 @@ int write_all_supers(struct btrfs_fs_info *fs_info, int max_mirrors)
 			continue;
 
 		btrfs_set_stack_device_generation(dev_item, 0);
-		btrfs_set_stack_device_type(dev_item, dev->type);
+		btrfs_set_stack_device_flags(dev_item, dev->flags);
 		btrfs_set_stack_device_id(dev_item, dev->devid);
 		btrfs_set_stack_device_total_bytes(dev_item,
 						   dev->commit_total_bytes);
diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index 53acc66065dd..be4196a1645c 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -1582,7 +1582,7 @@ static ssize_t btrfs_devinfo_allocation_hint_show(struct kobject *kobj,
 						   devid_kobj);
 
 	return scnprintf(buf, PAGE_SIZE, "0x%08llx\n",
-		device->type & BTRFS_DEV_ALLOCATION_HINT_MASK );
+		device->flags & BTRFS_DEV_ALLOCATION_HINT_MASK );
 }
 
 static ssize_t btrfs_devinfo_allocation_hint_store(struct kobject *kobj,
@@ -1595,7 +1595,7 @@ static ssize_t btrfs_devinfo_allocation_hint_store(struct kobject *kobj,
 	int ret;
 	struct btrfs_trans_handle *trans;
 
-	u64 type, prev_type;
+	u64 flags, prev_flags;
 
 	device = container_of(kobj, struct btrfs_device, devid_kobj);
 	fs_info = device->fs_info;
@@ -1606,24 +1606,25 @@ static ssize_t btrfs_devinfo_allocation_hint_store(struct kobject *kobj,
 	if (sb_rdonly(fs_info->sb))
 		return -EROFS;
 
-	ret = kstrtou64(buf, 0, &type);
+	ret = kstrtou64(buf, 0, &flags);
 	if (ret < 0)
 		return -EINVAL;
 
 	/* for now, allow to touch only the 'allocation hint' bits */
-	if (type & ~BTRFS_DEV_ALLOCATION_HINT_MASK)
+	if (flags & ~BTRFS_DEV_ALLOCATION_HINT_MASK)
 		return -EINVAL;
 
 	/* check if a change is really needed */
-	if ((device->type & BTRFS_DEV_ALLOCATION_HINT_MASK) == type)
+	if ((device->flags & BTRFS_DEV_ALLOCATION_HINT_MASK) == flags)
 		return len;
 
 	trans = btrfs_start_transaction(root, 1);
 	if (IS_ERR(trans))
 		return PTR_ERR(trans);
 
-	prev_type = device->type;
-	device->type = (device->type & ~BTRFS_DEV_ALLOCATION_HINT_MASK) | type;
+	prev_flags = device->flags;
+	device->flags = (device->flags & ~BTRFS_DEV_ALLOCATION_HINT_MASK) |
+			flags;
 
 	ret = btrfs_update_device(trans, device);
 
@@ -1639,7 +1640,7 @@ static ssize_t btrfs_devinfo_allocation_hint_store(struct kobject *kobj,
 
 	return len;
 abort:
-	device->type = prev_type;
+	device->flags = prev_flags;
 	return  ret;
 }
 BTRFS_ATTR_RW(devid, allocation_hint, btrfs_devinfo_allocation_hint_show,
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index beee7d1ae79d..9184570c51b0 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -1876,7 +1876,7 @@ static int btrfs_add_dev_item(struct btrfs_trans_handle *trans,
 
 	btrfs_set_device_id(leaf, dev_item, device->devid);
 	btrfs_set_device_generation(leaf, dev_item, 0);
-	btrfs_set_device_type(leaf, dev_item, device->type);
+	btrfs_set_device_flags(leaf, dev_item, device->flags);
 	btrfs_set_device_io_align(leaf, dev_item, device->io_align);
 	btrfs_set_device_io_width(leaf, dev_item, device->io_width);
 	btrfs_set_device_sector_size(leaf, dev_item, device->sector_size);
@@ -2900,7 +2900,7 @@ noinline int btrfs_update_device(struct btrfs_trans_handle *trans,
 	dev_item = btrfs_item_ptr(leaf, path->slots[0], struct btrfs_dev_item);
 
 	btrfs_set_device_id(leaf, dev_item, device->devid);
-	btrfs_set_device_type(leaf, dev_item, device->type);
+	btrfs_set_device_flags(leaf, dev_item, device->flags);
 	btrfs_set_device_io_align(leaf, dev_item, device->io_align);
 	btrfs_set_device_io_width(leaf, dev_item, device->io_width);
 	btrfs_set_device_sector_size(leaf, dev_item, device->sector_size);
@@ -5285,7 +5285,7 @@ static int gather_device_info(struct btrfs_fs_devices *fs_devices,
 			 */
 			devices_info[ndevs].alloc_hint = 0;
 		} else if (ctl->type & BTRFS_BLOCK_GROUP_DATA) {
-			hint = device->type & BTRFS_DEV_ALLOCATION_HINT_MASK;
+			hint = device->flags & BTRFS_DEV_ALLOCATION_HINT_MASK;
 
 			/*
 			 * skip BTRFS_DEV_METADATA_ONLY disks
@@ -5299,7 +5299,7 @@ static int gather_device_info(struct btrfs_fs_devices *fs_devices,
 			 */
 			devices_info[ndevs].alloc_hint = -alloc_hint_map[hint];
 		} else { /* BTRFS_BLOCK_GROUP_METADATA */
-			hint = device->type & BTRFS_DEV_ALLOCATION_HINT_MASK;
+			hint = device->flags & BTRFS_DEV_ALLOCATION_HINT_MASK;
 
 			/*
 			 * skip BTRFS_DEV_DATA_ONLY disks
@@ -7293,7 +7293,7 @@ static void fill_device_from_item(struct extent_buffer *leaf,
 	device->commit_total_bytes = device->disk_total_bytes;
 	device->bytes_used = btrfs_device_bytes_used(leaf, dev_item);
 	device->commit_bytes_used = device->bytes_used;
-	device->type = btrfs_device_type(leaf, dev_item);
+	device->flags = btrfs_device_flags(leaf, dev_item);
 	device->io_align = btrfs_device_io_align(leaf, dev_item);
 	device->io_width = btrfs_device_io_width(leaf, dev_item);
 	device->sector_size = btrfs_device_sector_size(leaf, dev_item);
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index 61c0cba045e9..27ecf062d50c 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -96,8 +96,8 @@ struct btrfs_device {
 
 	/* optimal io width for this device */
 	u32 io_width;
-	/* type and info about this device */
-	u64 type;
+	/* device flags (e.g. allocation hint) */
+	u64 flags;
 
 	/* minimal io size for this device */
 	u32 sector_size;
diff --git a/include/uapi/linux/btrfs_tree.h b/include/uapi/linux/btrfs_tree.h
index 55da906c2eac..f9891c94a75e 100644
--- a/include/uapi/linux/btrfs_tree.h
+++ b/include/uapi/linux/btrfs_tree.h
@@ -421,8 +421,8 @@ struct btrfs_dev_item {
 	/* minimal io size for this device */
 	__le32 sector_size;
 
-	/* type and info about this device */
-	__le64 type;
+	/* device flags (e.g. allocation hint) */
+	__le64 flags;
 
 	/* expected generation for this device */
 	__le64 generation;
-- 
2.34.1

