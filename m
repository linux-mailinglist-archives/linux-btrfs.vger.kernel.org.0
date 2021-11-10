Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5ADDE44CA67
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Nov 2021 21:16:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233102AbhKJUSU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 10 Nov 2021 15:18:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232898AbhKJUSO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 10 Nov 2021 15:18:14 -0500
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04BE6C061767
        for <linux-btrfs@vger.kernel.org>; Wed, 10 Nov 2021 12:15:26 -0800 (PST)
Received: by mail-qk1-x733.google.com with SMTP id az8so3705941qkb.2
        for <linux-btrfs@vger.kernel.org>; Wed, 10 Nov 2021 12:15:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=hK+DUEse65OIeR4kIxbcnXMkjLbLFWKs91jzLeYR7rg=;
        b=uy0LSjMBkq9wreFbne3KD4lFHqm87y96McLu5z9aj75tHbT4AHaDYJkCJWrC1Fh9zd
         4tL8wJ4j5Rz+qiPjrSoTt9EoRyFj8KOgTvraNjgUiBRMuAgAqg3TMiMuSywK002aBD5q
         gzOKN6liS0UTTm1yZRNBmIV5IJ19kufe9snQEk8LDLs8DH4zHchOeh7BfqDyHrkoVWty
         BkY5RQKsH/xcYIrs7VqyMWS+r/+j562fkXZlydinBq71Wh+uh/wr3W3CBV7N/iah5g71
         KilhjON7fzeIBVC6fjtxDsOcrUNO3KdzJjiKMpBmgC1phCk6ZKXivJwVNj4h0GNB71+Y
         DMeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hK+DUEse65OIeR4kIxbcnXMkjLbLFWKs91jzLeYR7rg=;
        b=8FPTRpw2chql5gQCXsBJ9D56xQI3v+SvaUaC/7XED8VyIolL6/IXpWq3FwzfLIuMsr
         EXvGNe5BTVxi5FcgN60Wx0em5n2yhN6Z7EaEJYJiee7nzgTGutpZQL7L94wECw0fIZ+5
         ri5CxC3gNgaRC/QuRLFWTyO7jZt5vKzc+BSrEQWg39Ozud+FOTNzCBFwR5OpTfklWXCt
         lcWJFd0e8AnJOSP2DoJ8Tj5A5UyGehBTc5WiKJOwfylnAxaGE7IQ2Gd8dR5qgZyIEZXK
         rjsDa+UdQATs2WkR2HG96mV4KaTjb/SvCDN8eBDRUkb4LtEAJUAwImFgBMUBvPusvFJE
         zyqQ==
X-Gm-Message-State: AOAM533iiGlt4G53fOpq7/L7ctsyv8zSsS6iQe/bjg7P9tJyJyyV9ukX
        l7qz97T526GTIBUM8v9hUzIproEEcjEEog==
X-Google-Smtp-Source: ABdhPJyURuLY1Wb+92mpgYarvRZSeaxhxv9W3rCnOl+DwsLcv4KO93EU/qSArDbctHo3HlVHPhPt0A==
X-Received: by 2002:a05:620a:d81:: with SMTP id q1mr1801278qkl.432.1636575325858;
        Wed, 10 Nov 2021 12:15:25 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id i67sm379823qkd.90.2021.11.10.12.15.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Nov 2021 12:15:25 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 25/30] btrfs-progs: add a btrfs_delete_and_free_root helper
Date:   Wed, 10 Nov 2021 15:14:37 -0500
Message-Id: <97aad5a2f5d87b260b407bcea2b62bb6f3a26d76.1636575147.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1636575146.git.josef@toxicpanda.com>
References: <cover.1636575146.git.josef@toxicpanda.com>
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
index cb871db7..13234605 100644
--- a/kernel-shared/disk-io.c
+++ b/kernel-shared/disk-io.c
@@ -2367,6 +2367,31 @@ int btrfs_set_buffer_uptodate(struct extent_buffer *eb)
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
index e2c2f3d9..fa4d41f3 100644
--- a/kernel-shared/disk-io.h
+++ b/kernel-shared/disk-io.h
@@ -217,6 +217,8 @@ int btrfs_fs_roots_compare_roots(struct rb_node *node1, struct rb_node *node2);
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

