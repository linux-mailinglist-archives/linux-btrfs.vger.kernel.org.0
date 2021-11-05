Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51C3A4469DE
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Nov 2021 21:41:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233634AbhKEUnw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 5 Nov 2021 16:43:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233501AbhKEUnt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 5 Nov 2021 16:43:49 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90111C061208
        for <linux-btrfs@vger.kernel.org>; Fri,  5 Nov 2021 13:41:09 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id w9so3222499qtk.13
        for <linux-btrfs@vger.kernel.org>; Fri, 05 Nov 2021 13:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=/NuTtoBNsybpfBVHpAeVbpWdKUn/l/A2EBdpVMoGPks=;
        b=kFaWrKi6o+KXMRDIAlyM0vFa61R344X/VUFBmcVote/kL5GDuRAt97/t7/SyuSJu3Q
         brB0IeTh8Cut8Q7Qhybsb/W9t/ZVrexAL222bpxoNzESy3efPlWxI2gDqx1x+VSPhPBB
         WtsLaopqdt+PkfkyRYdkcIVIhHsYgv51ks0bO0S7HPnbJWXAEuxmyEAfH4mjvWj8iWbF
         bYl/hOPJfsb0Hn0MFnJ6EAmgM4dTgs6AhVoA9u23qK2flrR6ZbVnlun/S3yQ8nFDKIBg
         RmR82Szphr9cxEbQ+TMbuyBRsq1gLIy0KQ1bbaf96TrNGVj0QDqNRR3aZEjLA3xXPOij
         F4rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/NuTtoBNsybpfBVHpAeVbpWdKUn/l/A2EBdpVMoGPks=;
        b=XUGNo5GZ0dlSZ31Zt86QorluXVwURw5iLpEGFc79eN21SEMoM5suXaufp/xMVhIThz
         dxfsjJ+bzvswLnJw1ONccKcmRzeHp8UCuzeIQTHTNSTq9WP73MgI1xk0AuJG06dC9OmM
         CPRQsajsyisOH2IBzDMDRujgBvqPzIglg5YCKY0IjQuL7XoebYjArlrdOTNRmNH/2BP0
         inxxQuX5jpvnOfS05I82+djYjVsjyQT+OelrsIOuAD+Y0fIdljsDK4h5ttgrs51yJVdN
         7BXN+cEF/4HFcbrV0atCDf24VRYKY2NTvA27UvOp3NYH6q3fe7juGQXLNZPZLErCwbRQ
         oUaA==
X-Gm-Message-State: AOAM533iN6jIU63SCDaVfaTWMyuXmjVwhp5OtI8GUOc9OrXpU/XR30FL
        1duZtcOkfoof89BqIpdSxYInZT0hFscHNw==
X-Google-Smtp-Source: ABdhPJzccxHaLbchzrRwOHHb8yocx628595/V7fmkwrxk6ddSh3PP+Rgbd0LpDiuwyRuSZUhSLLIRg==
X-Received: by 2002:a05:622a:118f:: with SMTP id m15mr8347416qtk.81.1636144868435;
        Fri, 05 Nov 2021 13:41:08 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id o15sm6221058qtm.8.2021.11.05.13.41.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Nov 2021 13:41:08 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 14/22] btrfs-progs: check: handle the block group tree properly
Date:   Fri,  5 Nov 2021 16:40:40 -0400
Message-Id: <ad2f04cc45755ce555cdb4a14df441493b8620dd.1636144275.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1636144275.git.josef@toxicpanda.com>
References: <cover.1636144275.git.josef@toxicpanda.com>
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
index 0feaf6c3..3e35ad44 100644
--- a/common/repair.c
+++ b/common/repair.c
@@ -150,6 +150,9 @@ int btrfs_mark_used_tree_blocks(struct btrfs_fs_info *fs_info,
 	if (!ret)
 		ret = traverse_tree_blocks(fs_info, tree,
 					   fs_info->tree_root->node, 1);
+	if (!ret && fs_info->block_group_root)
+		ret = traverse_tree_blocks(fs_info, tree,
+					   fs_info->block_group_root->node, 0);
 	return ret;
 }
 
-- 
2.26.3

