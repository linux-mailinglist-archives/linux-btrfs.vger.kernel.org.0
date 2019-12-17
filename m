Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6090C123085
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Dec 2019 16:37:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728408AbfLQPhQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 17 Dec 2019 10:37:16 -0500
Received: from mail-qv1-f67.google.com ([209.85.219.67]:33833 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728150AbfLQPhP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 17 Dec 2019 10:37:15 -0500
Received: by mail-qv1-f67.google.com with SMTP id o18so4333811qvf.1
        for <linux-btrfs@vger.kernel.org>; Tue, 17 Dec 2019 07:37:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=oc0fPepNq7xu/SGSZfzXEwOFvheWAxvSaU04owUSiAc=;
        b=xo0iAtUAjfKCdOMYFEeOZ4b+yk5CnFYQlAEbbvfJkPJXwb1vUrAL0+FI2zsmD0M5YT
         2Z68fz3joupKqtq01x+FGPdZxgr4VT8A563B1wbi93/dfhos/+Jhoh1EcEyvA7kJK9Cy
         NIKNUUdhqLMkomQKSLFrZ9OmzMriW6wv1ed6M+Tba40vvDoNrvHua5mxFccaaifTgFSh
         5ztTSz9UwIz7NdkG/YYCLV24lthzXNBW+AInoiCXog+1anYuLo0wUDbLCvGlcEffkB3L
         7ifNvb5VFGUKq2un0UarZt2fdWPS+adIhBW/gHknVpQUowDU9GRk+TOgsNjRgbuXLP4d
         HkKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oc0fPepNq7xu/SGSZfzXEwOFvheWAxvSaU04owUSiAc=;
        b=Qk1V5/D8q7LM8oWO4zNGxRMX3DLQZQwp33+OMyF4IERaRmaXvV+ZRTFf5SXOz3jybi
         53HEiluM5q/FP4WPI/q1F2JFNaB55n9VYPWbWLVB7Ed5ynwanrdhDv8onKYCkSxU51Yx
         N3lZLzg5r3ou5zyuEbMddTeSs0F/sEcLtOUfCZ6+JNTsqcWv4rwK6/mLT/9UqHInvw+y
         /2EmeCA4koUjRlYlgE3Pj3cKvfx1FzwHRtja+P/rFEiHNtyBhjbs04nwYNJkGLp37Se6
         iAewlmRWsDoenB5ezU3ueTNLUGw99FdwugznHwDcwFKKgsVZzGAHtpsf7TMte5Ku13HD
         n79g==
X-Gm-Message-State: APjAAAUMKlS1yJvKRN+KbwbHtwIrreYVM4j4Pj4MvFSJ5jHabrw9k5hj
        CXzgoOee9wi0TMbCuz/311PSMVyiZjvksQ==
X-Google-Smtp-Source: APXvYqwmV58g/E8knUMZFY60+5lrKd5a2SZr6quv/4pUo9ldkjhTGm+WOVoeFr9w3mQ+Db35yTJTjQ==
X-Received: by 2002:ad4:4dce:: with SMTP id cw14mr5302159qvb.162.1576597034588;
        Tue, 17 Dec 2019 07:37:14 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id e2sm7115805qkl.3.2019.12.17.07.37.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2019 07:37:13 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 20/45] btrfs: hold a ref on the root in btrfs_search_path_in_tree_user
Date:   Tue, 17 Dec 2019 10:36:10 -0500
Message-Id: <20191217153635.44733-21-josef@toxicpanda.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191217153635.44733-1-josef@toxicpanda.com>
References: <20191217153635.44733-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We can wander into a different root, so grab a ref on the root we look
up.  Later on we make root = fs_info->tree_root so we need this separate
out label to make sure we do the right cleanup only in the case we're
looking up a different root.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/ioctl.c | 28 ++++++++++++++++++----------
 1 file changed, 18 insertions(+), 10 deletions(-)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index b8b5432423e6..2eb5a5dc07bd 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -2432,6 +2432,10 @@ static int btrfs_search_path_in_tree_user(struct inode *inode,
 			ret = PTR_ERR(root);
 			goto out;
 		}
+		if (!btrfs_grab_fs_root(root)) {
+			ret = -ENOENT;
+			goto out;
+		}
 
 		key.objectid = dirid;
 		key.type = BTRFS_INODE_REF_KEY;
@@ -2439,15 +2443,15 @@ static int btrfs_search_path_in_tree_user(struct inode *inode,
 		while (1) {
 			ret = btrfs_search_slot(NULL, root, &key, path, 0, 0);
 			if (ret < 0) {
-				goto out;
+				goto out_put;
 			} else if (ret > 0) {
 				ret = btrfs_previous_item(root, path, dirid,
 							  BTRFS_INODE_REF_KEY);
 				if (ret < 0) {
-					goto out;
+					goto out_put;
 				} else if (ret > 0) {
 					ret = -ENOENT;
-					goto out;
+					goto out_put;
 				}
 			}
 
@@ -2461,7 +2465,7 @@ static int btrfs_search_path_in_tree_user(struct inode *inode,
 			total_len += len + 1;
 			if (ptr < args->path) {
 				ret = -ENAMETOOLONG;
-				goto out;
+				goto out_put;
 			}
 
 			*(ptr + len) = '/';
@@ -2472,10 +2476,10 @@ static int btrfs_search_path_in_tree_user(struct inode *inode,
 			ret = btrfs_previous_item(root, path, dirid,
 						  BTRFS_INODE_ITEM_KEY);
 			if (ret < 0) {
-				goto out;
+				goto out_put;
 			} else if (ret > 0) {
 				ret = -ENOENT;
-				goto out;
+				goto out_put;
 			}
 
 			leaf = path->nodes[0];
@@ -2483,26 +2487,26 @@ static int btrfs_search_path_in_tree_user(struct inode *inode,
 			btrfs_item_key_to_cpu(leaf, &key2, slot);
 			if (key2.objectid != dirid) {
 				ret = -ENOENT;
-				goto out;
+				goto out_put;
 			}
 
 			temp_inode = btrfs_iget(sb, &key2, root);
 			if (IS_ERR(temp_inode)) {
 				ret = PTR_ERR(temp_inode);
-				goto out;
+				goto out_put;
 			}
 			ret = inode_permission(temp_inode, MAY_READ | MAY_EXEC);
 			iput(temp_inode);
 			if (ret) {
 				ret = -EACCES;
-				goto out;
+				goto out_put;
 			}
 
 			if (key.offset == upper_limit.objectid)
 				break;
 			if (key.objectid == BTRFS_FIRST_FREE_OBJECTID) {
 				ret = -EACCES;
-				goto out;
+				goto out_put;
 			}
 
 			btrfs_release_path(path);
@@ -2513,6 +2517,7 @@ static int btrfs_search_path_in_tree_user(struct inode *inode,
 
 		memmove(args->path, ptr, total_len);
 		args->path[total_len] = '\0';
+		btrfs_put_fs_root(root);
 		btrfs_release_path(path);
 	}
 
@@ -2551,6 +2556,9 @@ static int btrfs_search_path_in_tree_user(struct inode *inode,
 out:
 	btrfs_free_path(path);
 	return ret;
+out_put:
+	btrfs_put_fs_root(root);
+	goto out;
 }
 
 static noinline int btrfs_ioctl_ino_lookup(struct file *file,
-- 
2.23.0

