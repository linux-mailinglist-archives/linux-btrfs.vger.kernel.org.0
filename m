Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28B873D7EAE
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Jul 2021 21:48:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232163AbhG0TsD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 27 Jul 2021 15:48:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230382AbhG0TsC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 27 Jul 2021 15:48:02 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAADAC061757
        for <linux-btrfs@vger.kernel.org>; Tue, 27 Jul 2021 12:48:01 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id c9so9738895qkc.13
        for <linux-btrfs@vger.kernel.org>; Tue, 27 Jul 2021 12:48:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=yZxDUrf5YWF8xmdZRZwfW5IfNetp3a9EI1uOanSCoGY=;
        b=sFG3YHzEAetzC0ZjFmivOO94gUs35BRKgjeEzCzeZBsSjpHfkJzQH8leSnx+b8Mt+q
         zBNcfUHEi6BOZ3irYWbmcZyBN3dVoNoYZZF1ho81MBEgPFTvaCqbtbx2gSA+sx1wmLdQ
         ddLcl4p5cKsCOqsTm9WrPHZnklG9XGECwfcAdc7KBmjHGfQTd+V0IJzIlDd/SmmgvJzP
         WLuvGJczPO7SeZ1gI4ghGR3ZqXVAHJ9KXWkudiWeZZn6LcL2qgf0KaIVs8NNMrM+K1h0
         znV9dMoL+rCJLmwyP0r22XPU8EmnccAjfZmiJxgcmtLzSnlB05UyFxp/JeTB7WvkHCBz
         skfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yZxDUrf5YWF8xmdZRZwfW5IfNetp3a9EI1uOanSCoGY=;
        b=Noh0dQ2kCjKOqRh7o6KoqAYXrSobbfzAWmsFdPLRxL888KNUtmkqhhEaegpIOJC3Fc
         SmqBgCbjzfBnJc/iAonHh6tYmlxmCZ+u6+yMRDJCmR6pJIDQLWqB36mDxtfes+TAzljy
         GanZOe75TVCNlwF4TFyL1kXtsiDIZxCcddlGhJPmfTatudAiqG9P1EjphUfO3HnqP4Yd
         s7V0zAqMAitdZXrKaTqRhhSHFDdBuM8CiDPYYRmoi5TYP+NGpHZk8tEv8MM5jm27qnVa
         J3j9UpuwSJkO7+Rfug9wp1b99nzsiNw/9FJ5CCeQ9YyC5RCX6AoT5YIUFTgPmdmvQrXP
         eduA==
X-Gm-Message-State: AOAM533qh3mnWSYzle+j1nmFTeZ8vBUjViCtYCrSV/1ucxynmIAThISW
        JrZBr+yPEmsilmjlS+TPX1hGGBZ7kouxZ1bD
X-Google-Smtp-Source: ABdhPJzrWko93wz/2vM8kzqErT2mW475VQTk5FYMI71TQhZ3Q8dly5x6eKMdIpvVvJcMnSAmdn3L1g==
X-Received: by 2002:a37:a6d2:: with SMTP id p201mr24363893qke.98.1627415280646;
        Tue, 27 Jul 2021 12:48:00 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id n14sm1876693qti.47.2021.07.27.12.47.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jul 2021 12:48:00 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 6/6] btrfs: unify common code for the v1 and v2 versions of device remove
Date:   Tue, 27 Jul 2021 15:47:48 -0400
Message-Id: <41983424cf4871def20a428f4bcdddaee1f98754.1627414703.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1627414703.git.josef@toxicpanda.com>
References: <cover.1627414703.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

These things share a lot of common code, v2 simply allows you to specify
devid.  Abstract out this common code and use the helper by both the v1
and v2 interfaces to save us some lines of code.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/ioctl.c | 99 +++++++++++++++++++-----------------------------
 1 file changed, 38 insertions(+), 61 deletions(-)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index fabbfdfa56f5..e3a7e8544609 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -3200,15 +3200,14 @@ static long btrfs_ioctl_add_dev(struct btrfs_fs_info *fs_info, void __user *arg)
 	return ret;
 }
 
-static long btrfs_ioctl_rm_dev_v2(struct file *file, void __user *arg)
+static long btrfs_do_device_removal(struct file *file, const char *path,
+				    u64 devid, bool cancel)
 {
 	struct inode *inode = file_inode(file);
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
-	struct btrfs_ioctl_vol_args_v2 *vol_args;
 	struct block_device *bdev = NULL;
 	fmode_t mode;
 	int ret;
-	bool cancel = false;
 
 	if (!capable(CAP_SYS_ADMIN))
 		return -EPERM;
@@ -3217,11 +3216,37 @@ static long btrfs_ioctl_rm_dev_v2(struct file *file, void __user *arg)
 	if (ret)
 		return ret;
 
-	vol_args = memdup_user(arg, sizeof(*vol_args));
-	if (IS_ERR(vol_args)) {
-		ret = PTR_ERR(vol_args);
-		goto err_drop;
+	ret = exclop_start_or_cancel_reloc(fs_info, BTRFS_EXCLOP_DEV_REMOVE,
+					   cancel);
+	if (ret)
+		goto out;
+
+	/* Exclusive operation is now claimed */
+	ret = btrfs_rm_device(fs_info, path, devid, &bdev, &mode);
+	btrfs_exclop_finish(fs_info);
+
+	if (!ret) {
+		if (path)
+			btrfs_info(fs_info, "device deleted: %s", path);
+		else
+			btrfs_info(fs_info, "device deleted: id %llu", devid);
 	}
+out:
+	mnt_drop_write_file(file);
+	if (bdev)
+		blkdev_put(bdev, mode);
+	return ret;
+}
+
+static long btrfs_ioctl_rm_dev_v2(struct file *file, void __user *arg)
+{
+	struct btrfs_ioctl_vol_args_v2 *vol_args;
+	int ret = 0;
+	bool cancel = false;
+
+	vol_args = memdup_user(arg, sizeof(*vol_args));
+	if (IS_ERR(vol_args))
+		return PTR_ERR(vol_args);
 
 	if (vol_args->flags & ~BTRFS_DEVICE_REMOVE_ARGS_MASK) {
 		ret = -EOPNOTSUPP;
@@ -3232,79 +3257,31 @@ static long btrfs_ioctl_rm_dev_v2(struct file *file, void __user *arg)
 	    strcmp("cancel", vol_args->name) == 0)
 		cancel = true;
 
-	ret = exclop_start_or_cancel_reloc(fs_info, BTRFS_EXCLOP_DEV_REMOVE,
-					   cancel);
-	if (ret)
-		goto out;
-	/* Exclusive operation is now claimed */
-
 	if (vol_args->flags & BTRFS_DEVICE_SPEC_BY_ID)
-		ret = btrfs_rm_device(fs_info, NULL, vol_args->devid, &bdev,
-				      &mode);
+		ret = btrfs_do_device_removal(file, NULL, vol_args->devid,
+					      cancel);
 	else
-		ret = btrfs_rm_device(fs_info, vol_args->name, 0, &bdev,
-				      &mode);
-
-	btrfs_exclop_finish(fs_info);
-
-	if (!ret) {
-		if (vol_args->flags & BTRFS_DEVICE_SPEC_BY_ID)
-			btrfs_info(fs_info, "device deleted: id %llu",
-					vol_args->devid);
-		else
-			btrfs_info(fs_info, "device deleted: %s",
-					vol_args->name);
-	}
+		ret = btrfs_do_device_removal(file, vol_args->name, 0, cancel);
 out:
 	kfree(vol_args);
-err_drop:
-	mnt_drop_write_file(file);
-	if (bdev)
-		blkdev_put(bdev, mode);
 	return ret;
 }
 
 static long btrfs_ioctl_rm_dev(struct file *file, void __user *arg)
 {
-	struct inode *inode = file_inode(file);
-	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
 	struct btrfs_ioctl_vol_args *vol_args;
-	struct block_device *bdev = NULL;
-	fmode_t mode;
 	int ret;
 	bool cancel;
 
-	if (!capable(CAP_SYS_ADMIN))
-		return -EPERM;
-
-	ret = mnt_want_write_file(file);
-	if (ret)
-		return ret;
-
 	vol_args = memdup_user(arg, sizeof(*vol_args));
-	if (IS_ERR(vol_args)) {
-		ret = PTR_ERR(vol_args);
-		goto out_drop_write;
-	}
+	if (IS_ERR(vol_args))
+		return PTR_ERR(vol_args);
 	vol_args->name[BTRFS_PATH_NAME_MAX] = '\0';
 	cancel = (strcmp("cancel", vol_args->name) == 0);
 
-	ret = exclop_start_or_cancel_reloc(fs_info, BTRFS_EXCLOP_DEV_REMOVE,
-					   cancel);
-	if (ret == 0) {
-		ret = btrfs_rm_device(fs_info, vol_args->name, 0, &bdev,
-				      &mode);
-		if (!ret)
-			btrfs_info(fs_info, "disk deleted %s", vol_args->name);
-		btrfs_exclop_finish(fs_info);
-	}
+	ret = btrfs_do_device_removal(file, vol_args->name, 0, cancel);
 
 	kfree(vol_args);
-out_drop_write:
-	mnt_drop_write_file(file);
-
-	if (bdev)
-		blkdev_put(bdev, mode);
 	return ret;
 }
 
-- 
2.26.3

