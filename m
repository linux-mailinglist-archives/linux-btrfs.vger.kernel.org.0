Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BD66F148936
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Jan 2020 15:34:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404426AbgAXOdg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 24 Jan 2020 09:33:36 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:36544 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404384AbgAXOde (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 24 Jan 2020 09:33:34 -0500
Received: by mail-qt1-f195.google.com with SMTP id t13so1233620qto.3
        for <linux-btrfs@vger.kernel.org>; Fri, 24 Jan 2020 06:33:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Tqq9AWCcNSxr5Rv3Ka/wfb0mCX1ebqBK/iWKe9Ld2rI=;
        b=tOc7i1auBLBmktUiOw4FgUeHqP23zODsp86/cCpj0Ln0WqvFFCXk3Qon+40ooUbL1p
         Eql+ky01yY3C15j5q3OLoV53rMXfJqfztSxUeFZdOqouibVRkfkbic4CiypBx4Z1ldNH
         3CjDbl8O4pHIfCRuhsZpP1fbargm0rPyRTCrJDYdcBtjcyID0Kf5T/B3lI2zMLWi9gwL
         IbTtkIsbG4wHaaaVg6ziqlMAiavx69Ku6/2b/dmP1gWIFrn9qoso3Cx14X4S5Zx8k2q8
         ALDby25l8j4YkdToKWXpQKXYKmXGYAz1K0KLiQ3UkaIrN/CTMkaP41KggKdy3a0WdYRe
         HC+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Tqq9AWCcNSxr5Rv3Ka/wfb0mCX1ebqBK/iWKe9Ld2rI=;
        b=f0fr9NLEPWc3twTxhvwe4wNlRoBX90Rn/BYToHnI8AkPSulWVlFJ1OG6U0buJ/r35L
         kWeau+9eoRoExAA1XjEsGqhD2W4qLq1jgClMl3XvFEMfWD/lv+Iy19TsEuayPN83OZM0
         9OzQLttWgL4ETzTQOr4gMOr+ZFKb8P/8E/vv8NVymxdbcVZXNqpVOb9gLiP2MdGsofWq
         ahss1hqaM7vzTiury8mRY+El+3z4rLSGlemxg+FeWB2e6bJ9VjL3WKhIM0K+hRDZcffK
         YXa1RKyfLOt/M/+hMW1BvT2tHN/84HXhfVgGMQQwhEvIHo4o/kcI//EKXIrBpsnaBy96
         Gw2A==
X-Gm-Message-State: APjAAAWGWBwhrurs7UmG2Ob6UiOUpgxgWNLjMC+W+vBlW0v1R1XicEFb
        hdk1yd0XOllTkcaSgmIAwkzuEQ==
X-Google-Smtp-Source: APXvYqxCWRc0/UzMHsIAuTqORI+5WzqWPLNQefaAMMTJnVjnUcJ/4d9HXaMX3Is6ozGJl0vhR/hwFg==
X-Received: by 2002:ac8:602:: with SMTP id d2mr2408338qth.245.1579876413458;
        Fri, 24 Jan 2020 06:33:33 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id v24sm3311710qtq.14.2020.01.24.06.33.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2020 06:33:32 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     kernel-team@fb.com, linux-btrfs@vger.kernel.org
Subject: [PATCH 18/44] btrfs: hold a ref on the root in btrfs_search_path_in_tree_user
Date:   Fri, 24 Jan 2020 09:32:35 -0500
Message-Id: <20200124143301.2186319-19-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200124143301.2186319-1-josef@toxicpanda.com>
References: <20200124143301.2186319-1-josef@toxicpanda.com>
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
index c721b4fce1c0..5fffa1b6f685 100644
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
2.24.1

