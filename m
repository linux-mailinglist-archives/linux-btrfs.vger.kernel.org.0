Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 49F4D123087
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Dec 2019 16:37:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728501AbfLQPhT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 17 Dec 2019 10:37:19 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:35457 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728150AbfLQPhT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 17 Dec 2019 10:37:19 -0500
Received: by mail-qt1-f196.google.com with SMTP id e12so3933529qto.2
        for <linux-btrfs@vger.kernel.org>; Tue, 17 Dec 2019 07:37:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=wa/TiQ9rxnUiJWYhskdyV3ZEJ3PZuit08QhB03+OCzQ=;
        b=Xfly9CHMmbnCPObzghXQ5IhbrVREeyuEcL19CeHo6YrJyzHnln2aXLG/UJU2iE70s0
         yKlHs0pKTnUDH+ECaP7PAZ0u8o4+jOsYWmf6m4I0MsmVxcqHLAadHiA+285KvJgXEXR0
         BUgvKrfRQ8Z+r//OlphB10Dh4vnB+L6KV2moB06mjpjP3XeV8QSI7RDKgQFZA55NbLdM
         0LrWTSECSR3VdxuouYid5YAMYq6U/GYW8W/0XSabDRc1Tp8ucAWyS0wkXeLX0pIxPBHI
         ncHBW4TqyxQRXrLI9G+k3pvFCtHWbS9YQUJTcnAuWDP3qaq0UxJEdH1ExcKRwGnPInS7
         E1Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wa/TiQ9rxnUiJWYhskdyV3ZEJ3PZuit08QhB03+OCzQ=;
        b=Pc2M8gQGzB50Un8Ctk3ui9xEeBPlh5xBWFjCgh0/q0YMJCQc9TwAGLVASVEXZiPRZ/
         SiA8MkzfLhcgXEjE6UN0WZw0eCEt4f1n+KrIde+Y6z502tf/j/LP0dWvoMSYkFzuIYCn
         yiapo9tfzM334EPbNxikb+CWPFO7IA0vtFeP9gk5bMj7BS21WvqShXCrYrbMKp/lPNHQ
         B/rBVQ0dXid9jlKgC+8CEMc5ZnqcKSU22c1XU/+FVcTIavG+VEyLOHgxTIjy8nIZPjNT
         mM08thE4+0Fp5uhCakkJEyzfmOUAxaPMWvKk0RoSnguvrL2e5wDWwH6WWX+oeA/q/ti9
         QVrQ==
X-Gm-Message-State: APjAAAVjd4N42nYYUev9Uxlm+9MiWSFA7XXfS6PRwZ9YKiP/5VTtX6Me
        5ZexxrkRNpBFokpXKqifb5ez5UHem//H1g==
X-Google-Smtp-Source: APXvYqy0zWNs0be6+ulRTeP6gFyfBJRPV2Kkn0Z6KYR+Ftw0n5pC9UbW5oxHRuQAp8MJwU0cCypBbg==
X-Received: by 2002:ac8:7b4f:: with SMTP id m15mr5115601qtu.48.1576597038135;
        Tue, 17 Dec 2019 07:37:18 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id c13sm6792936qko.87.2019.12.17.07.37.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2019 07:37:17 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 22/45] btrfs: hold ref on root in btrfs_ioctl_default_subvol
Date:   Tue, 17 Dec 2019 10:36:12 -0500
Message-Id: <20191217153635.44733-23-josef@toxicpanda.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191217153635.44733-1-josef@toxicpanda.com>
References: <20191217153635.44733-1-josef@toxicpanda.com>
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

