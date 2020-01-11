Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E9D29137B62
	for <lists+linux-btrfs@lfdr.de>; Sat, 11 Jan 2020 05:42:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728351AbgAKEmY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 10 Jan 2020 23:42:24 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:35216 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728324AbgAKEmY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 10 Jan 2020 23:42:24 -0500
Received: by mail-qt1-f194.google.com with SMTP id e12so4025108qto.2;
        Fri, 10 Jan 2020 20:42:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OqWCD1yRjztYDKxIKLGjCLQ3xtPyl8nK3kd2bFFxD5A=;
        b=f+V+lOGlT3HYbv6MA7atnQBNSJrwu03RQK8LGaBMnlCS5lXhhTgNQRgr/Tl6ib8O6H
         ZPKVXpT1sjTAW1KI+u3yNsZpThQ0ZF/3+KO7iJY1TYS2KbuhfjpJqyG14Vot+5xSHkkr
         1bRZwEy1Fe4hHohyEGpBM2PK1frUvQsv4707HaeC9zGnqmJrTHYUiCqV8/NjOoAIKn5K
         sULIZeYGVd2Ya90yoJtuK3dqkkAvuD/SR4JaHPHmIE/Sz9DZEWQQwtk1f+A1P/uvHP38
         7GykpoB4T4LDlvm5fSMalgCTqWCJ8VHspPZguzUYN1c/1GNd73H/wtY52Qir7MiU6WKJ
         tCog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OqWCD1yRjztYDKxIKLGjCLQ3xtPyl8nK3kd2bFFxD5A=;
        b=o3OTaSxW/M34u6jbK4n9xY6zR22WhasGTYH9lW06C4Xfub6ERnjeC+bhJHrEwILzt4
         K5P0QFk8klemtzxBDScpbNz7hg2dAFCDMEZ5Gzw3u8vmSX2b5C7aYAmO4zgdqTDusR7E
         8FP/4yqYl6yVVG+tR0PuvalVY8DUJ0BYGh/rL2xcPftJg5S8oLYEQrDmFK/yBkcIDmlv
         DeZDUGhE2uWuzuGMj26O9OUSVxNDjvmKuYqTLnhkIMeE7UuUiksNDJpVctQ+qa75ZM7O
         j3KlfVFC6mwU+EXqdekIp0FLP/n9Pvd6kwKXrNip1PMRp7H0A4MpmY6mIXfyF6XuCYcy
         VbNA==
X-Gm-Message-State: APjAAAV1Z1lg0JSQ0aNfqfNQ28axouQhP3d1bXo8VxpXfIYA2uOAnDQP
        gB8gbQ5hnd7tIgdMnVhZlrcP03Gr
X-Google-Smtp-Source: APXvYqxlDiTl+tzyviXx6D29e9VRPqwu0tRUV2urXIMMqtNF/6o7jq9tmv1+m6D/DWtoysllnxBVxw==
X-Received: by 2002:ac8:4708:: with SMTP id f8mr1619286qtp.129.1578717743128;
        Fri, 10 Jan 2020 20:42:23 -0800 (PST)
Received: from localhost.localdomain (200.146.48.138.dynamic.dialup.gvt.net.br. [200.146.48.138])
        by smtp.gmail.com with ESMTPSA id s20sm1861162qkg.131.2020.01.10.20.42.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2020 20:42:22 -0800 (PST)
From:   Marcos Paulo de Souza <marcos.souza.org@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     dsterba@suse.com, linux-btrfs@vger.kernel.org,
        Marcos Paulo de Souza <mpdesouza@suse.com>, wqu@suse.com,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH 1/2] btrfs: ioctl: Move the subvolume deleter code into a new function
Date:   Sat, 11 Jan 2020 01:39:41 -0300
Message-Id: <20200111043942.15366-2-marcos.souza.org@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200111043942.15366-1-marcos.souza.org@gmail.com>
References: <20200111043942.15366-1-marcos.souza.org@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Marcos Paulo de Souza <mpdesouza@suse.com>

This new function will be used by the next patch.

Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
---
 fs/btrfs/ioctl.c | 66 ++++++++++++++++++++++++++++--------------------
 1 file changed, 39 insertions(+), 27 deletions(-)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 0fa1c386d020..dcceae4c5d28 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -2835,44 +2835,27 @@ static int btrfs_ioctl_get_subvol_rootref(struct file *file, void __user *argp)
 	return ret;
 }
 
-static noinline int btrfs_ioctl_snap_destroy(struct file *file,
-					     void __user *arg)
+static noinline int btrfs_subvolume_deleter(struct file *file,
+				struct dentry *parent, const char *subvol_name,
+				size_t namelen)
 {
-	struct dentry *parent = file->f_path.dentry;
-	struct btrfs_fs_info *fs_info = btrfs_sb(parent->d_sb);
 	struct dentry *dentry;
-	struct inode *dir = d_inode(parent);
+	struct btrfs_root *dest;
 	struct inode *inode;
+	struct inode *dir = d_inode(parent);
 	struct btrfs_root *root = BTRFS_I(dir)->root;
-	struct btrfs_root *dest = NULL;
-	struct btrfs_ioctl_vol_args *vol_args;
-	int namelen;
+	struct btrfs_fs_info *fs_info = root->fs_info;
 	int err = 0;
 
-	if (!S_ISDIR(dir->i_mode))
-		return -ENOTDIR;
-
-	vol_args = memdup_user(arg, sizeof(*vol_args));
-	if (IS_ERR(vol_args))
-		return PTR_ERR(vol_args);
-
-	vol_args->name[BTRFS_PATH_NAME_MAX] = '\0';
-	namelen = strlen(vol_args->name);
-	if (strchr(vol_args->name, '/') ||
-	    strncmp(vol_args->name, "..", namelen) == 0) {
-		err = -EINVAL;
-		goto out;
-	}
-
 	err = mnt_want_write_file(file);
 	if (err)
-		goto out;
-
+		return err;
 
 	err = down_write_killable_nested(&dir->i_rwsem, I_MUTEX_PARENT);
 	if (err == -EINTR)
 		goto out_drop_write;
-	dentry = lookup_one_len(vol_args->name, parent, namelen);
+
+	dentry = lookup_one_len(subvol_name, parent, namelen);
 	if (IS_ERR(dentry)) {
 		err = PTR_ERR(dentry);
 		goto out_unlock_dir;
@@ -2880,7 +2863,7 @@ static noinline int btrfs_ioctl_snap_destroy(struct file *file,
 
 	if (d_really_is_negative(dentry)) {
 		err = -ENOENT;
-		goto out_dput;
+		goto out_unlock_dir;
 	}
 
 	inode = d_inode(dentry);
@@ -2943,6 +2926,35 @@ static noinline int btrfs_ioctl_snap_destroy(struct file *file,
 	inode_unlock(dir);
 out_drop_write:
 	mnt_drop_write_file(file);
+
+	return err;
+}
+
+static noinline int btrfs_ioctl_snap_destroy(struct file *file,
+					     void __user *arg)
+{
+	struct dentry *parent = file->f_path.dentry;
+	struct inode *dir = d_inode(parent);
+	struct btrfs_ioctl_vol_args *vol_args;
+	int namelen;
+	int err = 0;
+
+	if (!S_ISDIR(dir->i_mode))
+		return -ENOTDIR;
+
+	vol_args = memdup_user(arg, sizeof(*vol_args));
+	if (IS_ERR(vol_args))
+		return PTR_ERR(vol_args);
+
+	vol_args->name[BTRFS_PATH_NAME_MAX] = '\0';
+	namelen = strlen(vol_args->name);
+	if (strchr(vol_args->name, '/') ||
+	    strncmp(vol_args->name, "..", namelen) == 0) {
+		err = -EINVAL;
+		goto out;
+	}
+
+	err = btrfs_subvolume_deleter(file, parent, vol_args->name, namelen);
 out:
 	kfree(vol_args);
 	return err;
-- 
2.24.0

