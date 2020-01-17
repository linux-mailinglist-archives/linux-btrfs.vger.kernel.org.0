Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A8F88140B71
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Jan 2020 14:49:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729037AbgAQNsc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Jan 2020 08:48:32 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:38066 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728767AbgAQNsc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Jan 2020 08:48:32 -0500
Received: by mail-qk1-f194.google.com with SMTP id k6so22683157qki.5
        for <linux-btrfs@vger.kernel.org>; Fri, 17 Jan 2020 05:48:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Tqq9AWCcNSxr5Rv3Ka/wfb0mCX1ebqBK/iWKe9Ld2rI=;
        b=Wherq4YzbHEhoZ3Eb1ZrMIBEQRJD7GQLd872bRFyIZ5H42R7QLO0mQGir21XFMO9HU
         PUiyVy4y4ZkkJgnS/0tSxvbD5P8OAuEpDl2w7cDL978ZIIRRfTfw0qndMKaXSEarZtPB
         vxHIOMKrYkftnXLYX2Giy0DrDs6Acme0wgYif2GExHp6A7kS/d+pNkJCTovSeKsaBTc2
         x2ctX0x9h14rGrMJQEHAk6PuN6KZJ4pRDzD/9TrCE2aOpjvR3vJ9CD3HWIPiXV9KN27Z
         p8C8EIVbLSivikZdD6nIKPlFjb/k3CUMZehabh95iFzy6a3Um2px0wn/ntR3mOciUur7
         7eVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Tqq9AWCcNSxr5Rv3Ka/wfb0mCX1ebqBK/iWKe9Ld2rI=;
        b=fr4rInqTkdJp060OKl6BHQcKAyklYZPcW16YGTVGehbRn5IXmlFTJt9eABZ1Ly+Sqw
         3bRaZFyQXUz9f4C5NapY2bBHq5cnu6FS8GalVcGLcxsRL9w+2pPgfNK6C5Wom7Z5cREX
         /1ywAjQmjDN996fmq36flksvaZ5WnEAi0pvzjwjSlSkt8Wpz8RukhlgUUmuVchsKFmyS
         Ct561qB5FnjPU34gf7kMjtjMO0KdKH9T2Z5mIASUMTqlNSaPay2AD5pWNrtQhwEL4/j+
         ZP/J1XlnCntHlkS5DrcIml2qzvtHJ2etUI7hXDFdFCupnFiOhvbjQcEEN3Qhs8RQ5dGN
         6lGQ==
X-Gm-Message-State: APjAAAVRTmWyYBdI7OgP9QtEF8zJiDvz2YzIwOgcwQGg/UyBxGENPEwp
        uymgbE7w9j5SSJ04BGLWrT2zzITD+ZlbJw==
X-Google-Smtp-Source: APXvYqxl/99/bbeU14RbjnjQqATjZZeor4DX2+Z8LtUOPbiGVZBHlwg2l//p3fSnSO2tecta6tt/nA==
X-Received: by 2002:a37:ad17:: with SMTP id f23mr37731426qkm.24.1579268911313;
        Fri, 17 Jan 2020 05:48:31 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id t23sm12841864qto.88.2020.01.17.05.48.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2020 05:48:30 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 18/43] btrfs: hold a ref on the root in btrfs_search_path_in_tree_user
Date:   Fri, 17 Jan 2020 08:47:33 -0500
Message-Id: <20200117134758.41494-19-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200117134758.41494-1-josef@toxicpanda.com>
References: <20200117134758.41494-1-josef@toxicpanda.com>
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

