Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5C6EF11537E
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Dec 2019 15:46:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726562AbfLFOqW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 6 Dec 2019 09:46:22 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:41229 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726527AbfLFOqV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 6 Dec 2019 09:46:21 -0500
Received: by mail-qt1-f193.google.com with SMTP id v2so7333853qtv.8
        for <linux-btrfs@vger.kernel.org>; Fri, 06 Dec 2019 06:46:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=wa/TiQ9rxnUiJWYhskdyV3ZEJ3PZuit08QhB03+OCzQ=;
        b=CJeKmP7N8Rdm7dQNhRw5QUzM9wFz3BxmniwuLqba6ZIxNS+KmwybwovFhhQKtcvoVO
         C08fCUFjs2SH1n7+6WFlpGsORMkJV+TcIaJ20nfCrw+GnlqpYslkHAsjh1nGcaImLGcX
         VV0frYvmUduNr51Ky8ejbUoMstJutHSdqR/d53VT0ebkr3GEH0T9vKHEhEuYLf3lWqe3
         E1r6eyeHNrsZqA72PUGfsHa1c+GqfTote+3VZRSluzviXs69rR7ctr5Mm5iXWiIkcw9z
         lTQ3QF02blCP4IecBM5UUU8lMMHPPZh2Lgoy58YF/qtwgNiM2P6m3xEfgCIxHa9h809g
         Z8UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wa/TiQ9rxnUiJWYhskdyV3ZEJ3PZuit08QhB03+OCzQ=;
        b=DMpk9azxP/KwrI7APjoMCQH1Rj9BkZCaPquUl4QtCoh8v7w361Mg+zCStc7mqDEabv
         EFdDhQs1GdzusZXRMG4sDKlZLCcTHhjNsLGYZZZlsVJPzy14t0rH0uJ6eljtxr5oVFCN
         t2rtoByf+jQd9MvfP4GB/3K3OU9+WX7HscO1sfWfzOdm3gEg5nhKTEn1ojcGyPDfqqxV
         DMS8bCErPIvf++9DHkTw6e8dJ/YLm/a/pUnaThxLngutZeMOiRsmjvLrFBmFeS1S1AL1
         Uz7qmkUhvZ3DpnCffRmvqyHvBn2htdLxoPd+8hEr/p59RaPyrw8bWWyuSUDEY9dnGxuI
         Fnng==
X-Gm-Message-State: APjAAAV1ZOPFOsIjDOhfZzMZe9vdeGqx968RVjyCYJPbilPom+ihC3tT
        CGZw7+Rn6TuVe14x5/mee0meoVBbtBtFqw==
X-Google-Smtp-Source: APXvYqxg5wwzZfEkZrNnJ+RiFbn80Pn3ro9BhbAoHCPwzppjwMsgaYbhggAvfkhR6WOQUxAObTYZOg==
X-Received: by 2002:ac8:7007:: with SMTP id x7mr12448244qtm.89.1575643580116;
        Fri, 06 Dec 2019 06:46:20 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id e6sm5854155qkg.89.2019.12.06.06.46.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2019 06:46:19 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 22/44] btrfs: hold ref on root in btrfs_ioctl_default_subvol
Date:   Fri,  6 Dec 2019 09:45:16 -0500
Message-Id: <20191206144538.168112-23-josef@toxicpanda.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191206144538.168112-1-josef@toxicpanda.com>
References: <20191206144538.168112-1-josef@toxicpanda.com>
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
index 2797a1249f25..a3223bec3f5b 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -3993,7 +3993,7 @@ static long btrfs_ioctl_default_subvol(struct file *file, void __user *argp)
 	struct btrfs_root *new_root;
 	struct btrfs_dir_item *di;
 	struct btrfs_trans_handle *trans;
-	struct btrfs_path *path;
+	struct btrfs_path *path = NULL;
 	struct btrfs_key location;
 	struct btrfs_disk_key disk_key;
 	u64 objectid = 0;
@@ -4024,44 +4024,50 @@ static long btrfs_ioctl_default_subvol(struct file *file, void __user *argp)
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
2.23.0

