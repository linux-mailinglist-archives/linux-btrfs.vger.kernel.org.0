Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 033763D806D
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Jul 2021 23:04:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232730AbhG0VD4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 27 Jul 2021 17:03:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232005AbhG0VDp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 27 Jul 2021 17:03:45 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C839DC08EAF0
        for <linux-btrfs@vger.kernel.org>; Tue, 27 Jul 2021 14:01:30 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id az7so139744qkb.5
        for <linux-btrfs@vger.kernel.org>; Tue, 27 Jul 2021 14:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=yZxDUrf5YWF8xmdZRZwfW5IfNetp3a9EI1uOanSCoGY=;
        b=MKyTRBw7TRX2M5/S4IQfDS3OmHqcyJ6M0V6nfUbMrNyXVUABy1OOfQZz3G7uZF+jbK
         3eS6YVYMf4yCZ0ylcmfzDUTgqPfh8HWn9YQ90QH5CAeyoUZLAsZq9jWBT7ETpB9paxH+
         RCT0lWeXj3j5nHvLQ4hWCl7q53m/giylhEFE9ZcFcsgt7S0rsomJOpJS+IPfRelAVg+u
         oZ3Rway76Y0+oX2/g1aUS+SrZP9o2Bl5RKTtdC9gkmGhbPFaegJRvgoLp2zXbS0Qphek
         iCx5XFNPaECjl7NVCr38Ipw1d5FzAv9c3lIhy9VwjvXqVo60E4OiCrK99YKNpxehXe0Z
         S5nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yZxDUrf5YWF8xmdZRZwfW5IfNetp3a9EI1uOanSCoGY=;
        b=blb73VMIZwVgpnF222Sz21NTuaosy9xAmftTYcgiBK1TZ5Bb9BqQLZF9LKemuCQgvC
         Rw9OonN2ywpfu7YejKFgt2F+N4uuQ+Xwg0ArYWhc1c3IrarfYU6JLAFmjk4ZkfV5/bxw
         WjxrR1QixIVKK+BOyOdS3Excjc0J12/vrx/lR33ShGGH9YVzgs6YyxVH7vq9H2m5eZcw
         zYpfYWkXaNaE5UgI0II18oOmd5f2EVjHUgNd6gs55KE7rfRg5M6QytTUtzYb8A0ed6pr
         YHn0nSOKKqar+QrVyOJzP3Dy5WFHldTQqOnSgRVGjkXOJWsfIPPNQ48TXuHl223uxsew
         jE/w==
X-Gm-Message-State: AOAM532AY1OksPPfbeslVeASW8lffwk3BuNB5UJRXQiC0d+byA/cAAHO
        vmDxGq63hN8M6GsQRGjQuFZdEOo5pP+ddrlg
X-Google-Smtp-Source: ABdhPJwh+htlJlZTCkQW0u7Po2HcppcWmiICOkYXSnzesqp/P9vK5pHtM6l0akUuafGLDhaFs4eSqA==
X-Received: by 2002:ae9:e105:: with SMTP id g5mr24041237qkm.322.1627419689589;
        Tue, 27 Jul 2021 14:01:29 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id s3sm1936285qtn.4.2021.07.27.14.01.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jul 2021 14:01:29 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 6/7] btrfs: unify common code for the v1 and v2 versions of device remove
Date:   Tue, 27 Jul 2021 17:01:18 -0400
Message-Id: <2107b5db383aa3dfb54a30e5b0de015be1ff6d1f.1627419595.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1627419595.git.josef@toxicpanda.com>
References: <cover.1627419595.git.josef@toxicpanda.com>
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

