Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 32E4C1412DC
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Jan 2020 22:26:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728842AbgAQV0n (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Jan 2020 16:26:43 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:44238 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726587AbgAQV0m (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Jan 2020 16:26:42 -0500
Received: by mail-qt1-f193.google.com with SMTP id w8so8492234qts.11
        for <linux-btrfs@vger.kernel.org>; Fri, 17 Jan 2020 13:26:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=PP4dVMcgyT8OTB+vOohtLtUZzvbmwfUKl46nd4xdSyk=;
        b=rM4O1IodizGrHjXDS2Svsdz0yUWJoPHNsVCzft8H3cNoXBo44mNR+QXMFcjCEnWA33
         V0Y+tMA8tiTTJWsPmYOI7TC0EZ6oqDZLFq1YWxw02z21+ImNgpTQEKppjmsR+bVJhfiL
         ylDT0pa13ijsJsJbMWCYvZ+WBc4G/ZVwJQ57B+k43VCmNzMJpCJN2ayTWlidnEB82fRH
         bmttbMfju70SVXHYwjX0xGIQhp8CnPKFpbJNPMgciyE6+FlylOGmpe7XL7hH+MhmukGA
         NKwR2SHAxsgEcyGGcY7wtyZ6Y6rdiBlj+Brx79bQuZ37FzX+V2G8wkdhTRgQwMWAf3Sn
         ZNGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PP4dVMcgyT8OTB+vOohtLtUZzvbmwfUKl46nd4xdSyk=;
        b=dNWzPZR6LSkXiZyW3ps37ynOpa8m6+1PXbHTllgC1QT0gCHIj+9eC4lXInTYF6NPCh
         Vb2mUajn6+l6SFv3kbhpkYsdJNTPzrn18QuELEqViesVvnB6+EvVANhKT4SkbzKcuguy
         FiXaP1LpqJE7JF7BLelj1GPCLKEtvbwN4GHJrB6YRLZqMN4pn3L+yHfLybEANSz0t5SI
         Hc6sqn47cn/9//RbOsdOUh9+jQDPyFtdMdXdRgx2SMiIRpOlv1+3/s8rEilFenOzumvA
         KVPGeDwbJcVtIV7NSKw9P96p+Uk9tLjh5V1DssQGb2kOg6Dq+G6HDgeC6bccNJjxRPCC
         SyAw==
X-Gm-Message-State: APjAAAVwz34R9lEwGzP3c/bj6vDZR6yY3TJ7uoWMB6fP/WY7rNbAjQ9S
        gjZaYrxu/3VXacV1mByYF4UcP6xSHHYngg==
X-Google-Smtp-Source: APXvYqyXvBIEL6OLr23WAO1ORono7Ww0l+ZOSqnr3cTRi2LHUJ6sck/AN+wQ4sHpCdCJac5ankeQ5Q==
X-Received: by 2002:ac8:1e8e:: with SMTP id c14mr8920818qtm.330.1579296401713;
        Fri, 17 Jan 2020 13:26:41 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id c6sm12128649qka.111.2020.01.17.13.26.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2020 13:26:41 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 20/43] btrfs: hold ref on root in btrfs_ioctl_default_subvol
Date:   Fri, 17 Jan 2020 16:25:39 -0500
Message-Id: <20200117212602.6737-21-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200117212602.6737-1-josef@toxicpanda.com>
References: <20200117212602.6737-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We look up an arbitrary fs root here, we need to hold a ref on the root
for the duration.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/ioctl.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 7d30c7821490..69c39b3d15a5 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -3987,7 +3987,7 @@ static long btrfs_ioctl_default_subvol(struct file *file, void __user *argp)
 	struct btrfs_root *new_root;
 	struct btrfs_dir_item *di;
 	struct btrfs_trans_handle *trans;
-	struct btrfs_path *path;
+	struct btrfs_path *path = NULL;
 	struct btrfs_key location;
 	struct btrfs_disk_key disk_key;
 	u64 objectid = 0;
@@ -4018,44 +4018,50 @@ static long btrfs_ioctl_default_subvol(struct file *file, void __user *argp)
 		ret = PTR_ERR(new_root);
 		goto out;
 	}
-	if (!is_fstree(new_root->root_key.objectid)) {
+	if (!btrfs_grab_fs_root(root)) {
 		ret = -ENOENT;
 		goto out;
 	}
+	if (!is_fstree(new_root->root_key.objectid)) {
+		ret = -ENOENT;
+		goto out_free;
+	}
 
 	path = btrfs_alloc_path();
 	if (!path) {
 		ret = -ENOMEM;
-		goto out;
+		goto out_free;
 	}
 	path->leave_spinning = 1;
 
 	trans = btrfs_start_transaction(root, 1);
 	if (IS_ERR(trans)) {
-		btrfs_free_path(path);
 		ret = PTR_ERR(trans);
-		goto out;
+		goto out_free;
 	}
 
 	dir_id = btrfs_super_root_dir(fs_info->super_copy);
 	di = btrfs_lookup_dir_item(trans, fs_info->tree_root, path,
 				   dir_id, "default", 7, 1);
 	if (IS_ERR_OR_NULL(di)) {
-		btrfs_free_path(path);
+		btrfs_release_path(path);
 		btrfs_end_transaction(trans);
 		btrfs_err(fs_info,
 			  "Umm, you don't have the default diritem, this isn't going to work");
 		ret = -ENOENT;
-		goto out;
+		goto out_free;
 	}
 
 	btrfs_cpu_key_to_disk(&disk_key, &new_root->root_key);
 	btrfs_set_dir_item_key(path->nodes[0], di, &disk_key);
 	btrfs_mark_buffer_dirty(path->nodes[0]);
-	btrfs_free_path(path);
+	btrfs_release_path(path);
 
 	btrfs_set_fs_incompat(fs_info, DEFAULT_SUBVOL);
 	btrfs_end_transaction(trans);
+out_free:
+	btrfs_put_fs_root(new_root);
+	btrfs_free_path(path);
 out:
 	mnt_drop_write_file(file);
 	return ret;
-- 
2.24.1

