Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 282E3D35B6
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Oct 2019 02:24:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726725AbfJKAVh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 10 Oct 2019 20:21:37 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:37435 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726310AbfJKAVh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 10 Oct 2019 20:21:37 -0400
Received: by mail-ed1-f65.google.com with SMTP id r4so7106895edy.4;
        Thu, 10 Oct 2019 17:21:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TnvHggbNdZnxLx93jjXuWj1lKLV5ZUH/jWX6zccU648=;
        b=oC4Fp5S8XZjQ/EHu2XVmd/wB456wr+Y51FM8HgElHSQFEPjS8mEKxHgCD4LDkPFo4+
         3GASddiWQef8qUYA2hgELKn0G3WQAxTMCWfmTqUT/b39ksZV+WvrIFce152sR4T/qp4b
         s+xtD9kyspjGotLgEOxG3kUpJAyh+47Rvn36aoTmT5eH/OFIcUpyQMooGH9R3a/hPHmE
         h819hjMR1f+3bEwrUi4r6gbPGEe8wnb/oq9fIWmyoQr8ZA/RfkPlteh1w+X+5BOshEBI
         NjxLSopm88N7+/nDBtpR0SWuMz9kXH4g5kNQRkawYbtre/gErwWhtYUg5jOdMmG/pb8L
         ftjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TnvHggbNdZnxLx93jjXuWj1lKLV5ZUH/jWX6zccU648=;
        b=FmE4xhCw9zlvVC+Cz+2vZPRIZH+/TahyXe7+clX8m70+yJyIhx1HRAFk0bYfCPLIZ4
         c7KPkq2Co1zqEPdvd+b0wt+ih5OnL23FBDHJmb6HrV5/5cp8Zze0Wpayfo1eFiyCio0+
         ULNaSB2QImnZZG9E67HM6gn6yFu7KXOqDpVe+u6Wmj+jhnUlPmI+HiVU5GfrLN1JJ5bz
         xdZ+0EBcrwj9bB6EzBDHiROchw4ejmEFBNchVib11Oz0LaIVGs2gLjmJGVSBmhAkSoKK
         iSwGg0s2WdvBCZ8FOVZSuUu0WMi9enO019rTaCEJLbvgWHAJF9qb1F2TQYk1lrH1SVlm
         X+jQ==
X-Gm-Message-State: APjAAAWU3NML+rjOAc5f3UUzt6ZlimpYq7CMaRvJ+djSq+twhyM4YcNZ
        mS2EzOm2pYp+6YFVXre5yYY2e68Gcoc=
X-Google-Smtp-Source: APXvYqx/5reMp+KKgPRIKqPQawTCneYc8u/1O8vhsGY9L9+jDzKJYaAKqPTkK+11x2lfw/oWLD2LeQ==
X-Received: by 2002:a05:6402:7ca:: with SMTP id u10mr10850683edy.20.1570753293536;
        Thu, 10 Oct 2019 17:21:33 -0700 (PDT)
Received: from continental.suse.de ([191.35.238.90])
        by smtp.gmail.com with ESMTPSA id 36sm1228582edz.92.2019.10.10.17.21.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2019 17:21:32 -0700 (PDT)
From:   Marcos Paulo de Souza <marcos.souza.org@gmail.com>
To:     dsterba@suse.com, clm@fb.com
Cc:     Marcos Paulo de Souza <marcos.souza.org@gmail.com>,
        Marcos Paulo de Souza <mpdesouza@suse.com>,
        Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org (open list:BTRFS FILE SYSTEM),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] btrfs: ioctl: Try to use btrfs_fs_info instead of *file
Date:   Thu, 10 Oct 2019 21:23:11 -0300
Message-Id: <20191011002311.12459-1-marcos.souza.org@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Some functions are doing some bikeshedding to reach the btrfs_fs_info
struct. Change these functions to receive a btrfs_fs_info struct instead
of a *file.

Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
---
 The kernel survived btrfs-progs tests with this patch applied.

 fs/btrfs/ioctl.c | 36 +++++++++++++++---------------------
 1 file changed, 15 insertions(+), 21 deletions(-)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index de730e56d3f5..870e5c48b362 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -479,10 +479,9 @@ static int btrfs_ioctl_getversion(struct file *file, int __user *arg)
 	return put_user(inode->i_generation, arg);
 }
 
-static noinline int btrfs_ioctl_fitrim(struct file *file, void __user *arg)
+static noinline int btrfs_ioctl_fitrim(struct btrfs_fs_info *fs_info,
+					void __user *arg)
 {
-	struct inode *inode = file_inode(file);
-	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
 	struct btrfs_device *device;
 	struct request_queue *q;
 	struct fstrim_range range;
@@ -4960,10 +4959,9 @@ static long btrfs_ioctl_quota_rescan(struct file *file, void __user *arg)
 	return ret;
 }
 
-static long btrfs_ioctl_quota_rescan_status(struct file *file, void __user *arg)
+static long btrfs_ioctl_quota_rescan_status(struct btrfs_fs_info *fs_info,
+						void __user *arg)
 {
-	struct inode *inode = file_inode(file);
-	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
 	struct btrfs_ioctl_quota_rescan_args *qsa;
 	int ret = 0;
 
@@ -4986,11 +4984,9 @@ static long btrfs_ioctl_quota_rescan_status(struct file *file, void __user *arg)
 	return ret;
 }
 
-static long btrfs_ioctl_quota_rescan_wait(struct file *file, void __user *arg)
+static long btrfs_ioctl_quota_rescan_wait(struct btrfs_fs_info *fs_info,
+						void __user *arg)
 {
-	struct inode *inode = file_inode(file);
-	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
-
 	if (!capable(CAP_SYS_ADMIN))
 		return -EPERM;
 
@@ -5162,10 +5158,9 @@ static long btrfs_ioctl_set_received_subvol(struct file *file,
 	return ret;
 }
 
-static int btrfs_ioctl_get_fslabel(struct file *file, void __user *arg)
+static int btrfs_ioctl_get_fslabel(struct btrfs_fs_info *fs_info,
+					void __user *arg)
 {
-	struct inode *inode = file_inode(file);
-	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
 	size_t len;
 	int ret;
 	char label[BTRFS_LABEL_SIZE];
@@ -5249,10 +5244,9 @@ int btrfs_ioctl_get_supported_features(void __user *arg)
 	return 0;
 }
 
-static int btrfs_ioctl_get_features(struct file *file, void __user *arg)
+static int btrfs_ioctl_get_features(struct btrfs_fs_info *fs_info,
+					void __user *arg)
 {
-	struct inode *inode = file_inode(file);
-	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
 	struct btrfs_super_block *super_block = fs_info->super_copy;
 	struct btrfs_ioctl_feature_flags features;
 
@@ -5453,11 +5447,11 @@ long btrfs_ioctl(struct file *file, unsigned int
 	case FS_IOC_GETVERSION:
 		return btrfs_ioctl_getversion(file, argp);
 	case FS_IOC_GETFSLABEL:
-		return btrfs_ioctl_get_fslabel(file, argp);
+		return btrfs_ioctl_get_fslabel(fs_info, argp);
 	case FS_IOC_SETFSLABEL:
 		return btrfs_ioctl_set_fslabel(file, argp);
 	case FITRIM:
-		return btrfs_ioctl_fitrim(file, argp);
+		return btrfs_ioctl_fitrim(fs_info, argp);
 	case BTRFS_IOC_SNAP_CREATE:
 		return btrfs_ioctl_snap_create(file, argp, 0);
 	case BTRFS_IOC_SNAP_CREATE_V2:
@@ -5562,15 +5556,15 @@ long btrfs_ioctl(struct file *file, unsigned int
 	case BTRFS_IOC_QUOTA_RESCAN:
 		return btrfs_ioctl_quota_rescan(file, argp);
 	case BTRFS_IOC_QUOTA_RESCAN_STATUS:
-		return btrfs_ioctl_quota_rescan_status(file, argp);
+		return btrfs_ioctl_quota_rescan_status(fs_info, argp);
 	case BTRFS_IOC_QUOTA_RESCAN_WAIT:
-		return btrfs_ioctl_quota_rescan_wait(file, argp);
+		return btrfs_ioctl_quota_rescan_wait(fs_info, argp);
 	case BTRFS_IOC_DEV_REPLACE:
 		return btrfs_ioctl_dev_replace(fs_info, argp);
 	case BTRFS_IOC_GET_SUPPORTED_FEATURES:
 		return btrfs_ioctl_get_supported_features(argp);
 	case BTRFS_IOC_GET_FEATURES:
-		return btrfs_ioctl_get_features(file, argp);
+		return btrfs_ioctl_get_features(fs_info, argp);
 	case BTRFS_IOC_SET_FEATURES:
 		return btrfs_ioctl_set_features(file, argp);
 	case FS_IOC_FSGETXATTR:
-- 
2.23.0

