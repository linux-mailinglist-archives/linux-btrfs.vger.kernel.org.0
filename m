Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9AE56140B73
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Jan 2020 14:49:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729047AbgAQNsg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Jan 2020 08:48:36 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:38071 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729039AbgAQNsg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Jan 2020 08:48:36 -0500
Received: by mail-qk1-f193.google.com with SMTP id k6so22683310qki.5
        for <linux-btrfs@vger.kernel.org>; Fri, 17 Jan 2020 05:48:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=PP4dVMcgyT8OTB+vOohtLtUZzvbmwfUKl46nd4xdSyk=;
        b=u2jK+eDz3VyfsBFMYcDxNH+LpuHoMUCSU+3vQQmFrkuYYo+MVCFhTPV1WsxQcDTcS0
         ybZ7UuDTB+TSd2EvL0mDfHJMH/KCB6/AicoDAovbjL8QbMFdMhYcIt4JB7fzYwOESofX
         iu//K+FUHg8eIFvm8aCns4aT6PxNJDZOYRl0xGOnnp20sdoFq3z9wCb6MVcxXrxV4YtK
         AZ9gQ++Rlu8RjpYqTo4oKcZoLeyMV/9DlTZUnfqzwyexzPW8ovh5ZrRmLDGqRuozDlbW
         sfYJAIQWIn5ojAkNAlwXCSVNHW+4PTTUZav6vZjnRznzvKnK9hhFBGZ/69uuR8qABJiD
         Bp3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PP4dVMcgyT8OTB+vOohtLtUZzvbmwfUKl46nd4xdSyk=;
        b=JDuYwpW+O8etAj94XhmkIrtTXEC4reOuuIHOYKzgG8+wmrHbnVJxK4mSwTOJe8Sgul
         bZNW/lzHz+v2HPso8wYkjlsCOgSTnm8Q8uWwOjDYEKx3ab+HpFkgE/vleb2hASfHLVW/
         ZvUg2Wp7ErpH3kYjVNDMIgirfZKN7n5H4e5p0CQ3UV+NsHdp4e+v629qa+aJA/WXrEgt
         h26hge5XwEAIU4R4PA3PeRHnqY4/Y80BdpXf8U46k4PM0S9MTd1YUcpD//Vdmz2f3jI2
         2Y3Yqm+sl7UcIuE56xU5TqI8h/7q3n4x5DPxwtJIx/uSnDdlj63YGVvmAHVqx+oJQx+0
         qnVg==
X-Gm-Message-State: APjAAAU/x5ul6VvnuNOYkBOSAM1yOCv2wwo8mSFSQkzKilmea0HkbeDA
        RpklV7EwqWl2oPC13qPPtzf1tjS/MbV2YQ==
X-Google-Smtp-Source: APXvYqzDVFkjghhn3yyGAOATE7nD941GpqTq+msILLPpoOgMRVgii+vjFpRocPOIvZwVYCfVFSZdQA==
X-Received: by 2002:a05:620a:13e7:: with SMTP id h7mr39093643qkl.235.1579268914688;
        Fri, 17 Jan 2020 05:48:34 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id s26sm12055091qkj.24.2020.01.17.05.48.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2020 05:48:34 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 20/43] btrfs: hold ref on root in btrfs_ioctl_default_subvol
Date:   Fri, 17 Jan 2020 08:47:35 -0500
Message-Id: <20200117134758.41494-21-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200117134758.41494-1-josef@toxicpanda.com>
References: <20200117134758.41494-1-josef@toxicpanda.com>
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

