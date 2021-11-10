Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75F8A44CA64
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Nov 2021 21:16:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233004AbhKJUSS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 10 Nov 2021 15:18:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232705AbhKJUSK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 10 Nov 2021 15:18:10 -0500
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 467D6C061764
        for <linux-btrfs@vger.kernel.org>; Wed, 10 Nov 2021 12:15:22 -0800 (PST)
Received: by mail-qt1-x82a.google.com with SMTP id v4so3269614qtw.8
        for <linux-btrfs@vger.kernel.org>; Wed, 10 Nov 2021 12:15:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=z+IJLZcvD3oJ305oxDfRwffTMJaiUlJ2jT0X4QnGJE0=;
        b=RkljGn9Lfp5w4hFx+4n2xZmWGnprHMA1EMkwgIdc1uvJZITRHRTref5rF4/xDXm9p1
         ue8CFwBIaC9PSCtjCe+RA6I66rRzQOtE5XVTf+KDa6lBnYfu0cK4hsiyXuMD+2yNJ6T0
         h8gJfwws5VRrJKbOzAzuAe16xR+juYHNdKFSNznlVaQEIhmqggIDpt/f/pV49fe7WiUy
         ObJy4n93u7UipL38hqQ2/6cGlLERFYvzGrFNzB2+PBjz8zyCGGX7zsnIvl1HBcLbMAnS
         rKT6RAw2kWVO4mynbmdPMw/ZQEfMiCZgS02LIKsmGss3II74Yprs0jF5wvOCfsClDl6R
         Z/WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=z+IJLZcvD3oJ305oxDfRwffTMJaiUlJ2jT0X4QnGJE0=;
        b=16j1q347mrIX7qtMwZJb4KgRCZ0+sXMEB9SKZ9pNzjybwlj8jacXZQvKnu+7rZGO1e
         z5YlpzFAU4iu1EjHbKFtI/Op3WjVOyON23a5CmohpWFJW78DiTZ2rV5hM8PMkocG1S/q
         mntKrxIxBkTP8miVQwZvvAP2S9Fu2rDtafeYsiB/F1bPIlKS736u8jJ1g/CbGLP08kXl
         UKMKCWoctRFSwxp4UrDLn+WxhoDf/Gm4sfDNwrkSqN0Q+MU5B9mGhlgfC6IRpFAZYDVs
         nttColsJgPDLfXmw7N1lraIKCm/se6Sc6aqmRwIq9d7Q2Eb9P9ETqnNB/FkvD9N3rNP0
         DC6g==
X-Gm-Message-State: AOAM533V4mkdCdL3iTDdhbkRjFHPTCpe0Rfp5F12/twvEs8IaLNKjBDI
        ZI+aZxmVF2LRV5xX21ZhmG8zONouD+B4EA==
X-Google-Smtp-Source: ABdhPJx5pYtZaLeBbGD8NiJbXcwdP75czsTA1lZQo2SZREL7W3kqDYKE/D+M/J58ddYcKHNaD6CJJw==
X-Received: by 2002:a05:622a:5cd:: with SMTP id d13mr1845153qtb.361.1636575320776;
        Wed, 10 Nov 2021 12:15:20 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id w10sm519570qkp.121.2021.11.10.12.15.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Nov 2021 12:15:20 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 22/30] btrfs-progs: check: handle the block group tree properly
Date:   Wed, 10 Nov 2021 15:14:34 -0500
Message-Id: <97d52f7d44916c71203ee49c9e11ac5f863e7bd1.1636575147.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1636575146.git.josef@toxicpanda.com>
References: <cover.1636575146.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We need to make sure we process the block group root, and mark its
blocks as used for the free space tree checking.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 check/main.c    | 27 +++++++++++++++++----------
 common/repair.c |  3 +++
 2 files changed, 20 insertions(+), 10 deletions(-)

diff --git a/check/main.c b/check/main.c
index d2d27694..c28fa2f3 100644
--- a/check/main.c
+++ b/check/main.c
@@ -8908,6 +8908,18 @@ out:
 	return ret;
 }
 
+static int load_super_root(struct list_head *head, struct btrfs_root *root)
+{
+	u8 level;
+
+	if (!root)
+		return 0;
+
+	level = btrfs_header_level(root->node);
+	return add_root_item_to_list(head, root->root_key.objectid,
+				     root->node->start, 0, level, 0, NULL);
+}
+
 static int check_chunks_and_extents(void)
 {
 	struct rb_root dev_cache;
@@ -8926,9 +8938,7 @@ static int check_chunks_and_extents(void)
 	int bits_nr;
 	struct list_head dropping_trees;
 	struct list_head normal_trees;
-	struct btrfs_root *root1;
 	struct btrfs_root *root;
-	u8 level;
 
 	root = gfs_info->fs_root;
 	dev_cache = RB_ROOT;
@@ -8961,16 +8971,13 @@ static int check_chunks_and_extents(void)
 	}
 
 again:
-	root1 = gfs_info->tree_root;
-	level = btrfs_header_level(root1->node);
-	ret = add_root_item_to_list(&normal_trees, root1->root_key.objectid,
-				    root1->node->start, 0, level, 0, NULL);
+	ret = load_super_root(&normal_trees, gfs_info->tree_root);
+	if (ret < 0)
+		goto out;
+	ret = load_super_root(&normal_trees, gfs_info->chunk_root);
 	if (ret < 0)
 		goto out;
-	root1 = gfs_info->chunk_root;
-	level = btrfs_header_level(root1->node);
-	ret = add_root_item_to_list(&normal_trees, root1->root_key.objectid,
-				    root1->node->start, 0, level, 0, NULL);
+	ret = load_super_root(&normal_trees, gfs_info->block_group_root);
 	if (ret < 0)
 		goto out;
 
diff --git a/common/repair.c b/common/repair.c
index f8c3f89c..9071e627 100644
--- a/common/repair.c
+++ b/common/repair.c
@@ -149,6 +149,9 @@ int btrfs_mark_used_tree_blocks(struct btrfs_fs_info *fs_info,
 	ret = traverse_tree_blocks(tree, fs_info->chunk_root->node, 0);
 	if (!ret)
 		ret = traverse_tree_blocks(tree, fs_info->tree_root->node, 1);
+	if (!ret && fs_info->block_group_root)
+		ret = traverse_tree_blocks(tree,
+					   fs_info->block_group_root->node, 0);
 	return ret;
 }
 
-- 
2.26.3

