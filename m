Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82D13476277
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Dec 2021 21:00:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234231AbhLOUAS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 Dec 2021 15:00:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234213AbhLOUAR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 Dec 2021 15:00:17 -0500
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F26BC061574
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Dec 2021 12:00:17 -0800 (PST)
Received: by mail-qk1-x729.google.com with SMTP id a11so21193906qkh.13
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Dec 2021 12:00:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=hvun/+HRL+6LYd2tOwl8rJy2nnu6TTIeUJki2EZxWtM=;
        b=5Uak4ODAdmPJMBqBF33lO2aWAI4Vntip4bFOAF38OF9bYqRxPSR5EVuYs63sexYz57
         m4nzbymwzKpwan4BzsbcWwrf6UgJ3lp2KsKDNHtOunv4DzY1vpAVP/tnrHG72GocnxSa
         9UN666+BcZdBJAuAlyYZ7qdBPjomlpF6sZ4ZXZl1eYqVRHsjVy3B3VRNOw2mzq4yXrKD
         X8kAthMFTChGyl2KKlwpEmZ6NuCWngrRw3rYyieOPw5OMMfVKguO5emkJXiAiz2zQaJh
         cBbMJC8RLcnumPLi3A9/NTL9BlSu7a3gVvexdt4jdMpSTpdlfkxSjKB4ne9MArQ5pgJS
         uS1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hvun/+HRL+6LYd2tOwl8rJy2nnu6TTIeUJki2EZxWtM=;
        b=JeSImsikydlaoePeLbmp3WUV6pQR6L7KQoBst6wAD57od0Q7rNJmh2TiWTFaxzjrDs
         NzDduDsvVUcoI17g63+v5pxjHKu+uPel43erRxUlWyxaDRuPt2tqOR9bKjdC90w5H9dh
         /y+lns4m69XAzz5BeonP9GCKLUO8WME/+4wSTXXyNpyr4in1Qhw/UrqTRoOt4RtSsXAt
         KMYWGMASDFw9rwNUOHDexI1Pukss6sYNqdEWJmQ0BXZGMIEootXkpT8JxK6RnjcV8Uu6
         F9rsnD2fa0pw8YGPYAJOBjSAX4YduhOMdHx4VkCO1QuXIrBQPBIfYhpdQnAB0EnoG9a2
         KfLg==
X-Gm-Message-State: AOAM530bvC861ut8H6Px5gbO82XPG5bhDIm7XAneiZgaQKmqt6E49wuA
        XMppCh8JbGVwy17SMwYabtddw8zIBdjfcA==
X-Google-Smtp-Source: ABdhPJzIeSCaCwnCnzhWcteTCKQTLXNvIKoPLHBsh4vl64yCwF/HSiQXWUmmerkqXemhWbFa1kfj7g==
X-Received: by 2002:a05:620a:1991:: with SMTP id bm17mr9936018qkb.459.1639598416406;
        Wed, 15 Dec 2021 12:00:16 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id i6sm2165949qti.40.2021.12.15.12.00.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Dec 2021 12:00:16 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v4 17/22] btrfs-progs: add a btrfs_delete_and_free_root helper
Date:   Wed, 15 Dec 2021 14:59:43 -0500
Message-Id: <d42290ff6cd2e211c492b663e7f0f3a5c97f7f16.1639598278.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1639598278.git.josef@toxicpanda.com>
References: <cover.1639598278.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The free space tree code already does this, but we need it for cleaning
up per block group roots.  Abstract this code out into a helper so that
we can use it in multiple places in the future.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 kernel-shared/disk-io.c         | 25 +++++++++++++++++++++++++
 kernel-shared/disk-io.h         |  2 ++
 kernel-shared/free-space-tree.c | 24 +++---------------------
 3 files changed, 30 insertions(+), 21 deletions(-)

diff --git a/kernel-shared/disk-io.c b/kernel-shared/disk-io.c
index 38118e1d..83977cec 100644
--- a/kernel-shared/disk-io.c
+++ b/kernel-shared/disk-io.c
@@ -2368,6 +2368,31 @@ int btrfs_set_buffer_uptodate(struct extent_buffer *eb)
 	return set_extent_buffer_uptodate(eb);
 }
 
+int btrfs_delete_and_free_root(struct btrfs_trans_handle *trans,
+			       struct btrfs_root *root)
+{
+	struct btrfs_fs_info *fs_info = root->fs_info;
+	struct btrfs_root *tree_root = fs_info->tree_root;
+	int ret;
+
+	ret = btrfs_del_root(trans, tree_root, &root->root_key);
+	if (ret)
+		return ret;
+
+	list_del(&root->dirty_list);
+	ret = clean_tree_block(root->node);
+	if (ret)
+		return ret;
+	ret = btrfs_free_tree_block(trans, root, root->node, 0, 1);
+	if (ret)
+		return ret;
+	rb_erase(&root->rb_node, &fs_info->global_roots_tree);
+	free_extent_buffer(root->node);
+	free_extent_buffer(root->commit_root);
+	kfree(root);
+	return 0;
+}
+
 struct btrfs_root *btrfs_create_tree(struct btrfs_trans_handle *trans,
 				     struct btrfs_fs_info *fs_info,
 				     u64 objectid)
diff --git a/kernel-shared/disk-io.h b/kernel-shared/disk-io.h
index 4f58cad1..6a64b620 100644
--- a/kernel-shared/disk-io.h
+++ b/kernel-shared/disk-io.h
@@ -214,6 +214,8 @@ int btrfs_fs_roots_compare_roots(struct rb_node *node1, struct rb_node *node2);
 struct btrfs_root *btrfs_create_tree(struct btrfs_trans_handle *trans,
 				     struct btrfs_fs_info *fs_info,
 				     u64 objectid);
+int btrfs_delete_and_free_root(struct btrfs_trans_handle *trans,
+			       struct btrfs_root *root);
 struct btrfs_root *btrfs_csum_root(struct btrfs_fs_info *fs_info, u64 bytenr);
 struct btrfs_root *btrfs_extent_root(struct btrfs_fs_info *fs_inf, u64 bytenr);
 struct btrfs_root *btrfs_global_root(struct btrfs_fs_info *fs_info,
diff --git a/kernel-shared/free-space-tree.c b/kernel-shared/free-space-tree.c
index a82865d3..0a13b1d6 100644
--- a/kernel-shared/free-space-tree.c
+++ b/kernel-shared/free-space-tree.c
@@ -1257,27 +1257,9 @@ int btrfs_clear_free_space_tree(struct btrfs_fs_info *fs_info)
 	if (ret)
 		goto abort;
 
-	ret = btrfs_del_root(trans, tree_root, &free_space_root->root_key);
-	if (ret)
-		goto abort;
-
-	list_del(&free_space_root->dirty_list);
-
-	ret = clean_tree_block(free_space_root->node);
-	if (ret)
-		goto abort;
-	ret = btrfs_free_tree_block(trans, free_space_root,
-				    free_space_root->node, 0, 1);
-	if (ret)
-		goto abort;
-
-	rb_erase(&free_space_root->rb_node, &fs_info->global_roots_tree);
-	free_extent_buffer(free_space_root->node);
-	free_extent_buffer(free_space_root->commit_root);
-	kfree(free_space_root);
-
-	ret = btrfs_commit_transaction(trans, tree_root);
-
+	ret = btrfs_delete_and_free_root(trans, free_space_root);
+	if (!ret)
+		ret = btrfs_commit_transaction(trans, tree_root);
 abort:
 	return ret;
 }
-- 
2.26.3

