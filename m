Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 42BBD1412D9
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Jan 2020 22:26:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728819AbgAQV0k (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Jan 2020 16:26:40 -0500
Received: from mail-qv1-f68.google.com ([209.85.219.68]:34668 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726587AbgAQV0j (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Jan 2020 16:26:39 -0500
Received: by mail-qv1-f68.google.com with SMTP id o18so11380987qvf.1
        for <linux-btrfs@vger.kernel.org>; Fri, 17 Jan 2020 13:26:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Tqq9AWCcNSxr5Rv3Ka/wfb0mCX1ebqBK/iWKe9Ld2rI=;
        b=bJM9aktF+/uA6jlHTRyDf3BxWmesisLO+N6mc+rs34724uZTvycT2DslHi0Gb9P/IG
         bIljieaxJDcbuVh7B6Z2f2u6CCSiZ2Nxsp2XmVMNzx4uF/zfxfrhkUsHngwdLgMXfALh
         XuRmFENA6apcDi6synU9H4Li/YJkJK88HwxBRzjEnJZr5cuCQ5tj22as/iJGGtIWPrCS
         bd3rLZUmxCJI4WcP6u+M8fimsA0hQJBaQrmvULTVekfXgb3JKCRTXwBM1e5OHX1+KD32
         MIn08rTqra9RGJcKt4eezdQ2dO3323mK27XlMSt1K7r7xrigTUpiScRSY/f+L3coJBL0
         u1Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Tqq9AWCcNSxr5Rv3Ka/wfb0mCX1ebqBK/iWKe9Ld2rI=;
        b=FS+1PT2P3J5wAsqsXAuZueKGAugV0OjwgIXmXmzUBoZyncO456R67Oi0LTmqB3hXPi
         jO25ToQnsI4lGGWK6LFR8/mGNL5f6/ifsD1hoC9Y36Dwtm9kWtX0+V/IuihU3IdTDknk
         siGvj+L92sNfqK2evu22R6chH1C8m1Evpoa8dx1b9SR3szqLEbIcnuSNU1rJ30Xm3oIC
         4Ftmnz0FMnk1lADOQ1VreN34HiVYHvd2Y5f8Bnztibju2FERShp+0oKW8K97aMCzYYLo
         MKM9JzW3B3Ll4W6jlYwA/22pnQz5hra4zWnhYtJS04+b79YBxjHl2jyfi/nazbbjrrdI
         SmjQ==
X-Gm-Message-State: APjAAAVRQ4809SIJU5j03HaE3n7yfvxWAwFpmBSumnT9ZA87ynQznG+H
        DIa3zDEopAZNZrRdauRkWio0xdRLw0kpJw==
X-Google-Smtp-Source: APXvYqxjRWlD4DwHzIyncm1l6WY1X0bN/iyjQgrMzlC80o/0P2WJLK49hmfYb8muLFsS2bsYPh9JbQ==
X-Received: by 2002:a0c:a563:: with SMTP id y90mr9587163qvy.78.1579296398399;
        Fri, 17 Jan 2020 13:26:38 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id q2sm12402434qkm.5.2020.01.17.13.26.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2020 13:26:37 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 18/43] btrfs: hold a ref on the root in btrfs_search_path_in_tree_user
Date:   Fri, 17 Jan 2020 16:25:37 -0500
Message-Id: <20200117212602.6737-19-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200117212602.6737-1-josef@toxicpanda.com>
References: <20200117212602.6737-1-josef@toxicpanda.com>
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

