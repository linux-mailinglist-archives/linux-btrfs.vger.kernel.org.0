Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7136011537C
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Dec 2019 15:46:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726535AbfLFOqT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 6 Dec 2019 09:46:19 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:46274 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726268AbfLFOqS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 6 Dec 2019 09:46:18 -0500
Received: by mail-qt1-f194.google.com with SMTP id 38so7297379qtb.13
        for <linux-btrfs@vger.kernel.org>; Fri, 06 Dec 2019 06:46:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=oc0fPepNq7xu/SGSZfzXEwOFvheWAxvSaU04owUSiAc=;
        b=X2noEWcLaHYQFK9TBPYSvRHEOYkf1AG7KWe8Pc6FVKM1/RU87s9rPchklRDeeMDQEj
         5jmK5Rdgey+E/FRKYQpZkNFndQZ+khWoDGqAbU+nBM4BCS5lRKOZmsXn0WccFS2KgUFM
         G2zmM0k+IzZJwOANjz2tZXdj5poyrorY1wsxpLJL76XkwkPkLopQhDHrnCho/y2jpy4e
         M01HKzT4PFrUdeIENernAASx8oB7NFZEXCsNvLr89RE9QySS5Egn4nXvJx+qrpyoWM4D
         JzUBfOljvbBhB6MyueBOLsYrRWZwCGZurXPFM0gjLBYEHZ+yvIi9+XNuyIu0vUsMGlwP
         gLpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oc0fPepNq7xu/SGSZfzXEwOFvheWAxvSaU04owUSiAc=;
        b=aBAJd7egi2JK8c6d/TVP7W2+1oiMEVYwhT8N3YSrVaXgn30xV1NIgZkp0+zE0vYT10
         CVMJQHdMj+NqSTuMeWqJH9yRnyhs8zg7F06+7FdahesyG3DCv/PndUJlEL/YRjsE8qMW
         aHQrzAt5+NxeZmOgOJGBwyRHiv6d4w6rxRRXtLHp/oXnU9ju+umZr7ZwFdBcY+Wt4v/M
         trPgPpaVb7IWhr3AQ17MZYg9M7lWbqK9m4VXtq4wKxkXRxsCICzDZw2dFuR16ZSDktBJ
         0eZMLULS4OixMYOdRA6OCQCifCgWLiTeeiqmkhU7KIbdlswYqfMYRQnDfdallusqH2Xe
         2qkA==
X-Gm-Message-State: APjAAAW28EgpRoMnkOuUIAYzO4PdrPnDm2Wl++9QaPvaAgeFSwNLOYSL
        nQjTeCcU68Um3Y32792zhYKWRk3Zwdlf+w==
X-Google-Smtp-Source: APXvYqx7Kh6RVIajzn1cJgAPDaoWvH3vh4IIr0rvy+rwbVlhATTJcslLS357WmOQO896O2fNcAtcuQ==
X-Received: by 2002:ac8:6f3b:: with SMTP id i27mr13091419qtv.145.1575643576874;
        Fri, 06 Dec 2019 06:46:16 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id e2sm2953368qkl.3.2019.12.06.06.46.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2019 06:46:16 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 20/44] btrfs: hold a ref on the root in btrfs_search_path_in_tree_user
Date:   Fri,  6 Dec 2019 09:45:14 -0500
Message-Id: <20191206144538.168112-21-josef@toxicpanda.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191206144538.168112-1-josef@toxicpanda.com>
References: <20191206144538.168112-1-josef@toxicpanda.com>
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

