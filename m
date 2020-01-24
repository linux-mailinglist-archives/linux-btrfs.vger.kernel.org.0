Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E731B14893E
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Jan 2020 15:34:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404576AbgAXOdp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 24 Jan 2020 09:33:45 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:46616 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404420AbgAXOdh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 24 Jan 2020 09:33:37 -0500
Received: by mail-qt1-f195.google.com with SMTP id e25so1608038qtr.13
        for <linux-btrfs@vger.kernel.org>; Fri, 24 Jan 2020 06:33:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=PP4dVMcgyT8OTB+vOohtLtUZzvbmwfUKl46nd4xdSyk=;
        b=y+82Ja5ffKbcoj4aBWSDmZ8dZUmV0L3G8Y1qwrxx/JeX39zM9uxcndkxO5RexlI/FX
         kDgzCBRYfypRATV8SpnzPtRb1iyCScvfFwGy52emG+8FR/naPBbwPyUdaQWGTGLDBWDG
         4MB3mnkVZrq2BlSCnLGzyOWHH21qcP2723Vlim9B7NtIieTEi7OB09mArg3nfBNEx3c3
         AXaUx4RpFrG3pyFO3buwd5EgiiTAuPN+QS1nSvzVWGRz+CBFFp6RClMJ48gEy7m/XvxO
         JH7NlZAXEpjk3i1Vc6OWv7T6XRixX7G+xa+/NDlhXvRt8MGBDLxR2B3NLYMta1zKOPvP
         OxQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PP4dVMcgyT8OTB+vOohtLtUZzvbmwfUKl46nd4xdSyk=;
        b=tJe6RgRhwkbtH+NhTZ+zqyq8lsloortrFGhKtFVmwusGvd3Gi9B79htkXnZwCAMGsc
         R2hZ7k53hKGn7MQTPkMBPJejvLQYt9jQ0/tJ8X/6EoWK2ivLC6A82yLG/Svjne4Ls7P3
         s/z6ezfEx2Pyl5T6ElUVHHiN/gtiVcu/3A0gE3MiiWB4Ez0+G0wmb9dKWvzQOjL4MxfU
         /RkQBoSKzYbfVVX07Q87RtKBV9XTmoGhk3BsCQu/rvT/O1NJFhE5NjNMoGXDOOxZdCvs
         QipA/YyclwqFMbr/4v54N9Y3y1SOPPXDN79HirFrBVfUBPDC7tzyr3VaaPZdc4eL7l0u
         k+Bg==
X-Gm-Message-State: APjAAAU7yfMiWuMN3HZcIX6jFgD6O9g6zHRkMAAe+Nr9WxE73n868q29
        C38GbiUVluxn0Wh52d2vjD2PJQ==
X-Google-Smtp-Source: APXvYqxV+jUIUZhrHQCPWtnjJNCc+Pn5HYAAhHteXWAeQPStb6YUWr0k2fzLivoi2a5sW4uw79FRNA==
X-Received: by 2002:ac8:7cb0:: with SMTP id z16mr2411754qtv.276.1579876416542;
        Fri, 24 Jan 2020 06:33:36 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id v55sm713492qtc.1.2020.01.24.06.33.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2020 06:33:35 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     kernel-team@fb.com, linux-btrfs@vger.kernel.org
Subject: [PATCH 20/44] btrfs: hold ref on root in btrfs_ioctl_default_subvol
Date:   Fri, 24 Jan 2020 09:32:37 -0500
Message-Id: <20200124143301.2186319-21-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200124143301.2186319-1-josef@toxicpanda.com>
References: <20200124143301.2186319-1-josef@toxicpanda.com>
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

