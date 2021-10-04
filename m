Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 310E9421513
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Oct 2021 19:19:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234201AbhJDRVY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 4 Oct 2021 13:21:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234111AbhJDRVX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 4 Oct 2021 13:21:23 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4478C061745
        for <linux-btrfs@vger.kernel.org>; Mon,  4 Oct 2021 10:19:34 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id x12so6768753qkf.9
        for <linux-btrfs@vger.kernel.org>; Mon, 04 Oct 2021 10:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=XlDBdkU55njB/+JEAN1hWlQQ6hXcYqWLIbOSG2qbXI8=;
        b=huVHHgCTb5k160czEGPtwxFP9FkD6hcKImKA3i/fyC4kMWxncyY0HYP5J5W+pC55NW
         5cr/PMyat3VruV09QToA+NGvvO7zT7jR+yna+pvp59jmxb2wIhvRXtNUiH1sCt+dhG0J
         M2QQTqgzINtTuJ0DmTtpoGr07es9dABVS6Ol5nJGU04ny5cDjQ3KGcG/JvdpBt+/ziNT
         FwM2UV5i6O5BgUz+5wJZiXPd4KdczHJowjuOa5bxdXOfhQ/WvwMbI4bth0/M/+D0+Ucq
         4GZMz89eg0GR6MD8Eg3CqU+aL8cNAV3s5dEbabEakkj1PdzwubnV/ZAS55hDhA2fBp+Z
         UWMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XlDBdkU55njB/+JEAN1hWlQQ6hXcYqWLIbOSG2qbXI8=;
        b=xU9fkYw+1BxNSeKphOeGNFGvI3mlPXqqLjqpfmRFEI5WaDavAPP+ZXzOKcJDHgxUcQ
         z2g9UtOEdNqsmTsZD2G9yQMHBXoVli0flnkF437pBqh1FpuML7rmgEJC2YW943iPx0BC
         Um4QkCXyn1XLJRHZWjVaeUb3WGmkTzImDhUYUXR5fmIiTeggfUGNuFN9K42+DCg3deeU
         YLb7t1vkKxr5qezceYl8GMxarQVNd4oTNWsn7I8IYZUOtvff0hp1gbCZ3yfDw/foiEn7
         NEMmbrQy6pjotjc1/AA9sB6WYoiO6QR+/d0u4iBS/lDkoyLWo1Eozkz4RA/CfrpXqudu
         X9+g==
X-Gm-Message-State: AOAM531FoyAKJCJTHYFMuQL0FRnp7vHmDcmUj/gd5cYl0R1kLUmVRbyK
        fA0hfhB46krjGNQpmK8UBjrCctUNrRcPAw==
X-Google-Smtp-Source: ABdhPJwxAw6HPuAs4KSD3jOZyDKlCSu5pY+btnn04hESDSdjQ/IVhTz4U+BF8kkToi1V8SoYxgdxeQ==
X-Received: by 2002:a37:2f02:: with SMTP id v2mr10684651qkh.232.1633367973667;
        Mon, 04 Oct 2021 10:19:33 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id l7sm9251787qtr.87.2021.10.04.10.19.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Oct 2021 10:19:33 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v3 5/6] btrfs: add a btrfs_get_dev_args_from_path helper
Date:   Mon,  4 Oct 2021 13:19:21 -0400
Message-Id: <5070938448ea0730e642d4dcaad3c1ca95d95394.1633367810.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1633367810.git.josef@toxicpanda.com>
References: <cover.1633367810.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We are going to want to populate our device lookup args outside of any
locks and then do the actual device lookup later, so add a helper to do
this work and make btrfs_find_device_by_devspec() use this helper for
now.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/volumes.c | 99 ++++++++++++++++++++++++++++++----------------
 fs/btrfs/volumes.h |  4 ++
 2 files changed, 69 insertions(+), 34 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 191360e44a20..e490414e8987 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -2324,45 +2324,80 @@ void btrfs_destroy_dev_replace_tgtdev(struct btrfs_device *tgtdev)
 	btrfs_free_device(tgtdev);
 }
 
-static struct btrfs_device *btrfs_find_device_by_path(
-		struct btrfs_fs_info *fs_info, const char *device_path)
+/**
+ * btrfs_get_dev_args_from_path - populate args from device at path
+ *
+ * @fs_info: the filesystem
+ * @args: the args to populate
+ * @path: the path to the device
+ * Return: 0 for success, -errno for failure
+ *
+ * This will read the super block of the device at @path and populate @args with
+ * the devid, fsid, and uuid.  This is meant to be used for ioctl's that need to
+ * lookup a device to operate on, but need to do it before we take any locks.
+ * This properly handles the special case of "missing" that a user may pass in,
+ * and does some basic sanity checks.  The caller must make sure that @path is
+ * properly NULL terminated before calling in, and must call
+ * btrfs_put_dev_args_from_path() in order to free up the temporary fsid and
+ * uuid buffers.
+ */
+int btrfs_get_dev_args_from_path(struct btrfs_fs_info *fs_info,
+				 struct btrfs_dev_lookup_args *args,
+				 const char *path)
 {
-	BTRFS_DEV_LOOKUP_ARGS(args);
-	int ret = 0;
 	struct btrfs_super_block *disk_super;
 	struct block_device *bdev;
-	struct btrfs_device *device;
+	int ret;
 
-	ret = btrfs_get_bdev_and_sb(device_path, FMODE_READ,
-				    fs_info->bdev_holder, 0, &bdev, &disk_super);
-	if (ret)
-		return ERR_PTR(ret);
+	if (!path || !path[0])
+		return -EINVAL;
+	if (!strcmp(path, "missing")) {
+		args->missing = true;
+		return 0;
+	}
+
+	args->uuid = kzalloc(BTRFS_UUID_SIZE, GFP_KERNEL);
+	args->fsid = kzalloc(BTRFS_FSID_SIZE, GFP_KERNEL);
+	if (!args->uuid || !args->fsid) {
+		btrfs_put_dev_args_from_path(args);
+		return -ENOMEM;
+	}
 
-	args.devid = btrfs_stack_device_id(&disk_super->dev_item);
-	args.uuid = disk_super->dev_item.uuid;
+	ret = btrfs_get_bdev_and_sb(path, FMODE_READ, fs_info->bdev_holder, 0,
+				    &bdev, &disk_super);
+	if (ret)
+		return ret;
+	args->devid = btrfs_stack_device_id(&disk_super->dev_item);
+	memcpy(args->uuid, disk_super->dev_item.uuid, BTRFS_UUID_SIZE);
 	if (btrfs_fs_incompat(fs_info, METADATA_UUID))
-		args.fsid = disk_super->metadata_uuid;
+		memcpy(args->fsid, disk_super->metadata_uuid, BTRFS_FSID_SIZE);
 	else
-		args.fsid = disk_super->fsid;
-
-	device = btrfs_find_device(fs_info->fs_devices, &args);
-
+		memcpy(args->fsid, disk_super->fsid, BTRFS_FSID_SIZE);
 	btrfs_release_disk_super(disk_super);
-	if (!device)
-		device = ERR_PTR(-ENOENT);
 	blkdev_put(bdev, FMODE_READ);
-	return device;
+	return 0;
 }
 
 /*
- * Lookup a device given by device id, or the path if the id is 0.
+ * Only use this jointly with btrfs_get_dev_args_from_path() because we will
+ * allocate our ->uuid and ->fsid pointers, everybody else uses local variables
+ * that don't need to be freed.
  */
+void btrfs_put_dev_args_from_path(struct btrfs_dev_lookup_args *args)
+{
+	kfree(args->uuid);
+	kfree(args->fsid);
+	args->uuid = NULL;
+	args->fsid = NULL;
+}
+
 struct btrfs_device *btrfs_find_device_by_devspec(
 		struct btrfs_fs_info *fs_info, u64 devid,
 		const char *device_path)
 {
 	BTRFS_DEV_LOOKUP_ARGS(args);
 	struct btrfs_device *device;
+	int ret;
 
 	if (devid) {
 		args.devid = devid;
@@ -2372,18 +2407,14 @@ struct btrfs_device *btrfs_find_device_by_devspec(
 		return device;
 	}
 
-	if (!device_path || !device_path[0])
-		return ERR_PTR(-EINVAL);
-
-	if (strcmp(device_path, "missing") == 0) {
-		args.missing = true;
-		device = btrfs_find_device(fs_info->fs_devices, &args);
-		if (!device)
-			return ERR_PTR(-ENOENT);
-		return device;
-	}
-
-	return btrfs_find_device_by_path(fs_info, device_path);
+	ret = btrfs_get_dev_args_from_path(fs_info, &args, device_path);
+	if (ret)
+		return ERR_PTR(ret);
+	device = btrfs_find_device(fs_info->fs_devices, &args);
+	btrfs_put_dev_args_from_path(&args);
+	if (!device)
+		return ERR_PTR(-ENOENT);
+	return device;
 }
 
 /*
@@ -7049,7 +7080,7 @@ static int read_one_chunk(struct btrfs_key *key, struct extent_buffer *leaf,
 	for (i = 0; i < num_stripes; i++) {
 		map->stripes[i].physical =
 			btrfs_stripe_offset_nr(leaf, chunk, i);
-		args.devid = btrfs_stripe_devid_nr(leaf, chunk, i);
+		devid = args.devid = btrfs_stripe_devid_nr(leaf, chunk, i);
 		read_extent_buffer(leaf, uuid, (unsigned long)
 				   btrfs_stripe_dev_uuid_nr(chunk, i),
 				   BTRFS_UUID_SIZE);
@@ -7181,7 +7212,7 @@ static int read_one_dev(struct extent_buffer *leaf,
 	u8 fs_uuid[BTRFS_FSID_SIZE];
 	u8 dev_uuid[BTRFS_UUID_SIZE];
 
-	args.devid = btrfs_device_id(leaf, dev_item);
+	devid = args.devid = btrfs_device_id(leaf, dev_item);
 	read_extent_buffer(leaf, dev_uuid, btrfs_device_uuid(dev_item),
 			   BTRFS_UUID_SIZE);
 	read_extent_buffer(leaf, fs_uuid, btrfs_device_fsid(dev_item),
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index fa9a56c37d45..3fe5ac683f98 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -518,9 +518,13 @@ void btrfs_assign_next_active_device(struct btrfs_device *device,
 struct btrfs_device *btrfs_find_device_by_devspec(struct btrfs_fs_info *fs_info,
 						  u64 devid,
 						  const char *devpath);
+int btrfs_get_dev_args_from_path(struct btrfs_fs_info *fs_info,
+				 struct btrfs_dev_lookup_args *args,
+				 const char *path);
 struct btrfs_device *btrfs_alloc_device(struct btrfs_fs_info *fs_info,
 					const u64 *devid,
 					const u8 *uuid);
+void btrfs_put_dev_args_from_path(struct btrfs_dev_lookup_args *args);
 void btrfs_free_device(struct btrfs_device *device);
 int btrfs_rm_device(struct btrfs_fs_info *fs_info,
 		    const char *device_path, u64 devid,
-- 
2.26.3

