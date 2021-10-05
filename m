Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04C49423164
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Oct 2021 22:13:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235995AbhJEUOr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 5 Oct 2021 16:14:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229920AbhJEUOq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 5 Oct 2021 16:14:46 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA7E6C061749
        for <linux-btrfs@vger.kernel.org>; Tue,  5 Oct 2021 13:12:55 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id p4so243577qki.3
        for <linux-btrfs@vger.kernel.org>; Tue, 05 Oct 2021 13:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=oihrko7GKF1vs34s7r2btrhez62QjVGVCfQQ7m7eNs8=;
        b=oafLegJVEHU+SzzLNTH5lMsXr22ZD392ba/pujROWyVgWWSCKcXTgYmSCVz9j0Dq5V
         hVh7juKGTpHC38LxmAy8DglBVESE+jSGKeQOZh9dt5aZY21mTmKAlJLUc1hmLHmFYnpk
         GzNYQtaMFBFuOqElPQLpnT6sv2oDgC6uLc8DAQjXq7tNPDIdAfNmQPZLfeV0C1ozTIlV
         9GAeQW53Hxt57AuSwJ0Be4kE0lUpLCiqdQxmX+XS90TecVDFNcpWY3AyN9gjMM3txO7l
         EYNNHSuthxcJHAvWvfWDfBfaqXg8muWpN6POx4NxC+3lV8Z3cscVsXPKr/P8MNLDR6w1
         EXVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oihrko7GKF1vs34s7r2btrhez62QjVGVCfQQ7m7eNs8=;
        b=gvjhArFTa5f2QzAjpTGl8RrSA/9oFb9uZIv2XJVnyn8kaLxUHxDE8BRUIFWhb4KCe9
         Vjcv3A1awrlBYjyuZQaNc9botweg67+dW2ntRt7sJDtd7KowEWa056u/YrNfoK7atafl
         qZnCOmuK8iiTmm8nz8NfZGb1y7DzZIm2uW7La7mlqJMFvKfah0iAJvPO+XhWsaIzvATY
         UBgxU8pGqqXV02lxb8dFIq+E+9+HsSOxDv4RB6t1kQ1vN7H1F6B+ayGc6QTRaJ/ou8TP
         KwrKVAdwKaw8cyBZ1EZMUaHx58g8/sLqbqesS7iCfbV8zatVwD8+2tV56hQp6onU+KIE
         bN6A==
X-Gm-Message-State: AOAM533Jn0tl2OxoSFHnr2zxCu7MbNHFIJeAEKeggbyVDaI3M1lrHhSA
        HDbgS5BSZUTsmjVcW5bN5iyJFguG8H8jRg==
X-Google-Smtp-Source: ABdhPJyxhn03syIgG07OPD82l8mufBqkPWLQL+jvXBnl1O1zrh1Z4pYHUqR00ansP1g7Ifad1jKqdg==
X-Received: by 2002:a37:b501:: with SMTP id e1mr16954790qkf.307.1633464774664;
        Tue, 05 Oct 2021 13:12:54 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id bj31sm11039724qkb.43.2021.10.05.13.12.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Oct 2021 13:12:54 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v4 5/6] btrfs: add a btrfs_get_dev_args_from_path helper
Date:   Tue,  5 Oct 2021 16:12:43 -0400
Message-Id: <b8fd2ecac3156cb0ea8d717f481182b25dce8841.1633464631.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1633464631.git.josef@toxicpanda.com>
References: <cover.1633464631.git.josef@toxicpanda.com>
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
 fs/btrfs/volumes.c | 95 ++++++++++++++++++++++++++++++----------------
 fs/btrfs/volumes.h |  4 ++
 2 files changed, 67 insertions(+), 32 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index a729f532749d..e490414e8987 100644
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

