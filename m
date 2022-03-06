Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72DF34CED23
	for <lists+linux-btrfs@lfdr.de>; Sun,  6 Mar 2022 19:16:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232542AbiCFSQt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 6 Mar 2022 13:16:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231678AbiCFSQr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 6 Mar 2022 13:16:47 -0500
Received: from smtp.tiscali.it (michael.mail.tiscali.it [213.205.33.246])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6FABC65D1A
        for <linux-btrfs@vger.kernel.org>; Sun,  6 Mar 2022 10:15:54 -0800 (PST)
Received: from venice.bhome ([78.12.27.75])
        by michael.mail.tiscali.it with 
        id 36El2700C1dDdji016EpJh; Sun, 06 Mar 2022 18:14:49 +0000
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
        Paul Jones <paul@pauljones.id.au>, Boris Burkov <boris@bur.io>,
        Goffredo Baroncelli <kreijack@inwind.it>
Subject: [PATCH 5/5] btrfs: rename dev_item->type to dev_item->flags
Date:   Sun,  6 Mar 2022 19:14:43 +0100
Message-Id: <7c805844c54fab100402ac7392d1a8c9d28372b9.1646589622.git.kreijack@inwind.it>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1646589622.git.kreijack@inwind.it>
References: <cover.1646589622.git.kreijack@inwind.it>
Reply-To: Goffredo Baroncelli <kreijack@libero.it>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tiscali.it; s=smtp;
        t=1646590489; bh=vBjL+Gr66VOY8EXQkOc5K7KSwkkB/VnlPpI4scTqCb8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
        b=ydwiBBuKRjEu/cNSrPn0jh+vHSoTKipzmfci/EuiwdoJxcf6cZe8q1nxLyCGgRKXF
         UqWMcWPzu8wcIK+rAnD/Tq8ITJluwLk8bWShv99thOr3qQfOTgY91VKcnMaBBvRiTv
         lodpDuzwmllranK2i74z/2Nhk8T7rkywi376mqE4=
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Goffredo Baroncelli <kreijack@inwind.it>

Rename the field type of dev_item from 'type' to 'flags' changing the
struct btrfs_device and btrfs_dev_item.

Signed-off-by: Goffredo Baroncelli <kreijack@inwind.it>
---
 fs/btrfs/ctree.h                |  4 ++--
 fs/btrfs/disk-io.c              |  2 +-
 fs/btrfs/sysfs.c                | 15 ++++++++-------
 fs/btrfs/volumes.c              | 10 +++++-----
 fs/btrfs/volumes.h              |  4 ++--
 include/uapi/linux/btrfs_tree.h |  4 ++--
 6 files changed, 20 insertions(+), 19 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 4db17bd05a21..afa47061a47a 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -1707,7 +1707,7 @@ static inline void btrfs_set_device_total_bytes(const struct extent_buffer *eb,
 }
 
 
-BTRFS_SETGET_FUNCS(device_type, struct btrfs_dev_item, type, 64);
+BTRFS_SETGET_FUNCS(device_flags, struct btrfs_dev_item, flags, 64);
 BTRFS_SETGET_FUNCS(device_bytes_used, struct btrfs_dev_item, bytes_used, 64);
 BTRFS_SETGET_FUNCS(device_io_align, struct btrfs_dev_item, io_align, 32);
 BTRFS_SETGET_FUNCS(device_io_width, struct btrfs_dev_item, io_width, 32);
@@ -1720,7 +1720,7 @@ BTRFS_SETGET_FUNCS(device_seek_speed, struct btrfs_dev_item, seek_speed, 8);
 BTRFS_SETGET_FUNCS(device_bandwidth, struct btrfs_dev_item, bandwidth, 8);
 BTRFS_SETGET_FUNCS(device_generation, struct btrfs_dev_item, generation, 64);
 
-BTRFS_SETGET_STACK_FUNCS(stack_device_type, struct btrfs_dev_item, type, 64);
+BTRFS_SETGET_STACK_FUNCS(stack_device_flags, struct btrfs_dev_item, flags, 64);
 BTRFS_SETGET_STACK_FUNCS(stack_device_total_bytes, struct btrfs_dev_item,
 			 total_bytes, 64);
 BTRFS_SETGET_STACK_FUNCS(stack_device_bytes_used, struct btrfs_dev_item,
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 6a0b4dbd70e9..0c2f5a98b9df 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -4407,7 +4407,7 @@ int write_all_supers(struct btrfs_fs_info *fs_info, int max_mirrors)
 			continue;
 
 		btrfs_set_stack_device_generation(dev_item, 0);
-		btrfs_set_stack_device_type(dev_item, dev->type);
+		btrfs_set_stack_device_flags(dev_item, dev->flags);
 		btrfs_set_stack_device_id(dev_item, dev->devid);
 		btrfs_set_stack_device_total_bytes(dev_item,
 						   dev->commit_total_bytes);
diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index c6723456c0e1..8d0581c5383d 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -1597,7 +1597,7 @@ static ssize_t btrfs_devinfo_allocation_hint_show(struct kobject *kobj,
 						   devid_kobj);
 
 	for (i = 0 ; i < ARRAY_SIZE(allocation_hint_name) ; i++) {
-		if ((device->type & BTRFS_DEV_ALLOCATION_HINT_MASK) !=
+		if ((device->flags & BTRFS_DEV_ALLOCATION_HINT_MASK) !=
 		    allocation_hint_name[i].value)
 			continue;
 
@@ -1617,7 +1617,7 @@ static ssize_t btrfs_devinfo_allocation_hint_store(struct kobject *kobj,
 	int ret;
 	struct btrfs_trans_handle *trans;
 	int i, l;
-	u64 type, prev_type;
+	u64 flags, prev_flags;
 
 	if (len < 1)
 		return -EINVAL;
@@ -1634,7 +1634,7 @@ static ssize_t btrfs_devinfo_allocation_hint_store(struct kobject *kobj,
 		if (strncasecmp(allocation_hint_name[i].name, buf, l))
 			continue;
 
-		type = allocation_hint_name[i].value;
+		flags = allocation_hint_name[i].value;
 		break;
 	}
 
@@ -1651,15 +1651,16 @@ static ssize_t btrfs_devinfo_allocation_hint_store(struct kobject *kobj,
 		return -EROFS;
 
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
 
@@ -1675,7 +1676,7 @@ static ssize_t btrfs_devinfo_allocation_hint_store(struct kobject *kobj,
 
 	return len;
 abort:
-	device->type = prev_type;
+	device->flags = prev_flags;
 	return  ret;
 }
 BTRFS_ATTR_RW(devid, allocation_hint, btrfs_devinfo_allocation_hint_show,
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 7b37db9bb887..728e3a7582bc 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -1871,7 +1871,7 @@ static int btrfs_add_dev_item(struct btrfs_trans_handle *trans,
 
 	btrfs_set_device_id(leaf, dev_item, device->devid);
 	btrfs_set_device_generation(leaf, dev_item, 0);
-	btrfs_set_device_type(leaf, dev_item, device->type);
+	btrfs_set_device_flags(leaf, dev_item, device->flags);
 	btrfs_set_device_io_align(leaf, dev_item, device->io_align);
 	btrfs_set_device_io_width(leaf, dev_item, device->io_width);
 	btrfs_set_device_sector_size(leaf, dev_item, device->sector_size);
@@ -2898,7 +2898,7 @@ noinline int btrfs_update_device(struct btrfs_trans_handle *trans,
 	dev_item = btrfs_item_ptr(leaf, path->slots[0], struct btrfs_dev_item);
 
 	btrfs_set_device_id(leaf, dev_item, device->devid);
-	btrfs_set_device_type(leaf, dev_item, device->type);
+	btrfs_set_device_flags(leaf, dev_item, device->flags);
 	btrfs_set_device_io_align(leaf, dev_item, device->io_align);
 	btrfs_set_device_io_width(leaf, dev_item, device->io_width);
 	btrfs_set_device_sector_size(leaf, dev_item, device->sector_size);
@@ -5288,7 +5288,7 @@ static int gather_device_info(struct btrfs_fs_devices *fs_devices,
 			 */
 			devices_info[ndevs].alloc_hint = 0;
 		} else if (ctl->type & BTRFS_BLOCK_GROUP_DATA) {
-			hint = device->type & BTRFS_DEV_ALLOCATION_HINT_MASK;
+			hint = device->flags & BTRFS_DEV_ALLOCATION_HINT_MASK;
 
 			/*
 			 * skip BTRFS_DEV_METADATA_ONLY disks
@@ -5302,7 +5302,7 @@ static int gather_device_info(struct btrfs_fs_devices *fs_devices,
 			 */
 			devices_info[ndevs].alloc_hint = -alloc_hint_map[hint];
 		} else { /* BTRFS_BLOCK_GROUP_METADATA */
-			hint = device->type & BTRFS_DEV_ALLOCATION_HINT_MASK;
+			hint = device->flags & BTRFS_DEV_ALLOCATION_HINT_MASK;
 
 			/*
 			 * skip BTRFS_DEV_DATA_ONLY disks
@@ -7308,7 +7308,7 @@ static void fill_device_from_item(struct extent_buffer *leaf,
 	device->commit_total_bytes = device->disk_total_bytes;
 	device->bytes_used = btrfs_device_bytes_used(leaf, dev_item);
 	device->commit_bytes_used = device->bytes_used;
-	device->type = btrfs_device_type(leaf, dev_item);
+	device->flags = btrfs_device_flags(leaf, dev_item);
 	device->io_align = btrfs_device_io_align(leaf, dev_item);
 	device->io_width = btrfs_device_io_width(leaf, dev_item);
 	device->sector_size = btrfs_device_sector_size(leaf, dev_item);
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index b066f9af216a..6230d911e7af 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -101,8 +101,8 @@ struct btrfs_device {
 
 	/* optimal io width for this device */
 	u32 io_width;
-	/* type and info about this device */
-	u64 type;
+	/* device flags (e.g. allocation hint) */
+	u64 flags;
 
 	/* minimal io size for this device */
 	u32 sector_size;
diff --git a/include/uapi/linux/btrfs_tree.h b/include/uapi/linux/btrfs_tree.h
index e0d842c2e616..bfe0b1a7f3a1 100644
--- a/include/uapi/linux/btrfs_tree.h
+++ b/include/uapi/linux/btrfs_tree.h
@@ -424,8 +424,8 @@ struct btrfs_dev_item {
 	/* minimal io size for this device */
 	__le32 sector_size;
 
-	/* type and info about this device */
-	__le64 type;
+	/* device flags (e.g. allocation hint) */
+	__le64 flags;
 
 	/* expected generation for this device */
 	__le64 generation;
-- 
2.35.1

