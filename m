Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC3E646552A
	for <lists+linux-btrfs@lfdr.de>; Wed,  1 Dec 2021 19:18:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352271AbhLASVN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 1 Dec 2021 13:21:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352221AbhLASVE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 1 Dec 2021 13:21:04 -0500
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2649C06174A
        for <linux-btrfs@vger.kernel.org>; Wed,  1 Dec 2021 10:17:42 -0800 (PST)
Received: by mail-qt1-x832.google.com with SMTP id f20so24960575qtb.4
        for <linux-btrfs@vger.kernel.org>; Wed, 01 Dec 2021 10:17:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=hvun/+HRL+6LYd2tOwl8rJy2nnu6TTIeUJki2EZxWtM=;
        b=p1f7gqqgfShGUqmanrvY8WXrD7ZqBUDnG+4EblxJMpIQIZDZpGJDW6Rnaribl/jKGS
         MhM8lzi6dekM9n8KsMhJfrDugiWDkaM/Z34ebBsIreUpaii0hITSqiFE41hbwkCDE31Z
         AyKXqvfXNiEA5aqJdPpndrX89F7ZFmkvUdHXTZQjd4LmJ4FqWP8J8HKSYizRvw16B9ry
         Qk4YDikIOt4z6J2/2q20ETDtD0VIOsYNzN/3Wge1M8xdqpyP9boR2qkwUTOssdbis7Th
         0Dz24cJD72j7dQY1wde9Y+daFbTt1Emgr8ip9tmIVAbG2DwL5/Sjr+6jynJSF5laBtn9
         zNRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hvun/+HRL+6LYd2tOwl8rJy2nnu6TTIeUJki2EZxWtM=;
        b=fPqiJu16ygEiDu7nB6v/qOzHSI5IgL23K16B5t/G93IdbbrCFJJ88SO3GxRshBeR+a
         AiFJBu2dofw9A40RUY65dHu50NCf49P1MC5KR4LpbcCXro0OMpdxYe0+ao066LkH9qyv
         0pnzXzeEL5AiKL5yk45uK9nwXzp9bOXYq5JeOMXQ+OiyEa9dhbMVBy9lJp7OibwlPVO2
         Cfb3MssQEUGm4YEDWQYVdPG4KdanBLkZuf8MfFyJ/7GPh7aOljJjCJpP2h/vFqXxLGwu
         W+U7B6wroi5DCM/5MUsy7C+VcAp8rCGGbtgsJzbfyWYc46sAIwVi2SYJ/JAaFpbts2s8
         4Duw==
X-Gm-Message-State: AOAM533y6ck8Wn3TSNFXmvCRJiyZMdMFEIZODeqSFA1HqlGq3/NTQ3lc
        qT5XO4a3ef2gIW9C6K+9RKSFejC7h8U/+Q==
X-Google-Smtp-Source: ABdhPJz0SgyiS7Q3j4ZmmMXLRFWY8f87XNWS9WP8XPeVWa4FGPI9JtC0qcjrnIeTk+NXnWESglqPVg==
X-Received: by 2002:ac8:5713:: with SMTP id 19mr8690361qtw.642.1638382661531;
        Wed, 01 Dec 2021 10:17:41 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id b5sm238860qka.51.2021.12.01.10.17.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Dec 2021 10:17:41 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 17/22] btrfs-progs: add a btrfs_delete_and_free_root helper
Date:   Wed,  1 Dec 2021 13:17:11 -0500
Message-Id: <e8604664f476e958ce44dfff9872bb25561370ed.1638382588.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1638382588.git.josef@toxicpanda.com>
References: <cover.1638382588.git.josef@toxicpanda.com>
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

