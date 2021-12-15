Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81A90476385
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Dec 2021 21:40:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236319AbhLOUkY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 Dec 2021 15:40:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236226AbhLOUkY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 Dec 2021 15:40:24 -0500
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D87C9C061574
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Dec 2021 12:40:23 -0800 (PST)
Received: by mail-qv1-xf36.google.com with SMTP id fo11so202871qvb.4
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Dec 2021 12:40:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=OZ2iBcU2rrRugAa1l3QSs7g2x9M3+Id2q9pM7cKB9Z4=;
        b=SsgB+60+JQOSfxTf2AEh2DWnlkkrMB+JbyCB/+PxPCPt0/hYGpI3AOxTCJdL7fsXhn
         ikAwyM3yX6yGKXKK5KlTGOFOCVrsR9Cldrk9l4ec0rssJyGscxS97M9VDqAIe0cHKp9G
         sLADLdckB7YbZ5Tv9MGQJtmlG+A1wEILwqLHSGL9TFGCARpOBrwN7LSXpY+yhYQ7wPKh
         JMUzJBouUOEyUHiMTjU9wBimZ9dq8xwcgO61yqxwe2ZYBmRuhRCaJsF8xjzNQ8tBpkUb
         SYPeYFON32rI2pBRuhblFtygW2Ya4wt7bEVEJOhnKTb19B5SLVJn65tjvAeKznEaRAmN
         Rp6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OZ2iBcU2rrRugAa1l3QSs7g2x9M3+Id2q9pM7cKB9Z4=;
        b=7ZqOKzL2qt5ySM+pMX9yjxYG1sKsxHU1gJnRGgDwh6Ip7iQs3NIxJuUQP/6xczQ7lm
         YvXqTOajC8ZWQUDwEon726IRqeAWqAAPJIdFZwK/g36GquQ4oiVBzQWAxBhuI1/dr7/E
         q3UfbGoQ9EuMweMRSSFcEgyiQMgbPjxMbayqWDu5FM0Rkl1haMuswHpUZcNqISAksvJK
         mumDoRuvzwcgumN4PXzSgJpAWjj/Ycxb/bIuI9uBJFG+fTUIEfRimaMgdnpji8smycZi
         Fyos/Om7Tq4SQGVcfnFKRZ5ytprHqOlFvFcTg23+Wdcw+LB/vPE0fb+xD1OzSzi4Bcin
         QKrg==
X-Gm-Message-State: AOAM5305GTWbWSMBFvxj0s9diQpGpRQYOBWI9vuabRNF4SBwyNUblCsR
        hgNqoR4FbmDs+IXeIqD4nJlzGp1agmtBsg==
X-Google-Smtp-Source: ABdhPJyjwKGuXWZbnAFWdJV3wibN25a19lWhdoW9e+zbQIBfXBNtPQiplCv8Xvf4ORbAIXT9LlPE/g==
X-Received: by 2002:a0c:beca:: with SMTP id f10mr7407033qvj.97.1639600822704;
        Wed, 15 Dec 2021 12:40:22 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id h19sm2342603qth.63.2021.12.15.12.40.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Dec 2021 12:40:22 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 09/11] btrfs: abstract out loading the tree root
Date:   Wed, 15 Dec 2021 15:40:06 -0500
Message-Id: <fc9f1e2aa167dfe0d1b9b806246eb55e098092c9.1639600719.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1639600719.git.josef@toxicpanda.com>
References: <cover.1639600719.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We're going to be adding more roots that need to be loaded from the
super block, so abstract out the code to read the tree_root from the
super block, and use this helper for the chunk root as well.  This will
make it simpler to load the new trees in the future.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/disk-io.c | 82 ++++++++++++++++++++++++++--------------------
 1 file changed, 47 insertions(+), 35 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 5c598e124c25..ddc3b9fcbabc 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -2934,6 +2934,46 @@ static int btrfs_validate_write_super(struct btrfs_fs_info *fs_info,
 	return ret;
 }
 
+static int load_super_root(struct btrfs_root *root, u64 bytenr, u64 gen,
+			   int level)
+{
+	int ret = 0;
+
+	root->node = read_tree_block(root->fs_info, bytenr,
+				     root->root_key.objectid, gen, level, NULL);
+	if (IS_ERR(root->node)) {
+		ret = PTR_ERR(root->node);
+		root->node = NULL;
+	} else if (!extent_buffer_uptodate(root->node)) {
+		free_extent_buffer(root->node);
+		root->node = NULL;
+		ret = -EIO;
+	}
+
+	if (ret)
+		return ret;
+
+	btrfs_set_root_node(&root->root_item, root->node);
+	root->commit_root = btrfs_root_node(root);
+	btrfs_set_root_refs(&root->root_item, 1);
+	return ret;
+}
+
+static int load_important_roots(struct btrfs_fs_info *fs_info)
+{
+	struct btrfs_super_block *sb = fs_info->super_copy;
+	u64 gen, bytenr;
+	int level, ret;
+
+	bytenr = btrfs_super_root(sb);
+	gen = btrfs_super_generation(sb);
+	level = btrfs_super_root_level(sb);
+	ret = load_super_root(fs_info->tree_root, bytenr, gen, level);
+	if (ret)
+		btrfs_warn(fs_info, "couldn't read tree root");
+	return ret;
+}
+
 static int __cold init_tree_roots(struct btrfs_fs_info *fs_info)
 {
 	int backup_index = find_newest_super_backup(fs_info);
@@ -2944,9 +2984,6 @@ static int __cold init_tree_roots(struct btrfs_fs_info *fs_info)
 	int i;
 
 	for (i = 0; i < BTRFS_NUM_BACKUP_ROOTS; i++) {
-		u64 generation;
-		int level;
-
 		if (handle_error) {
 			if (!IS_ERR(tree_root->node))
 				free_extent_buffer(tree_root->node);
@@ -2971,29 +3008,13 @@ static int __cold init_tree_roots(struct btrfs_fs_info *fs_info)
 			if (ret < 0)
 				return ret;
 		}
-		generation = btrfs_super_generation(sb);
-		level = btrfs_super_root_level(sb);
-		tree_root->node = read_tree_block(fs_info, btrfs_super_root(sb),
-						  BTRFS_ROOT_TREE_OBJECTID,
-						  generation, level, NULL);
-		if (IS_ERR(tree_root->node)) {
-			handle_error = true;
-			ret = PTR_ERR(tree_root->node);
-			tree_root->node = NULL;
-			btrfs_warn(fs_info, "couldn't read tree root");
-			continue;
 
-		} else if (!extent_buffer_uptodate(tree_root->node)) {
+		ret = load_important_roots(fs_info);
+		if (ret) {
 			handle_error = true;
-			ret = -EIO;
-			btrfs_warn(fs_info, "error while reading tree root");
 			continue;
 		}
 
-		btrfs_set_root_node(&tree_root->root_item, tree_root->node);
-		tree_root->commit_root = btrfs_root_node(tree_root);
-		btrfs_set_root_refs(&tree_root->root_item, 1);
-
 		/*
 		 * No need to hold btrfs_root::objectid_mutex since the fs
 		 * hasn't been fully initialised and we are the only user
@@ -3013,8 +3034,8 @@ static int __cold init_tree_roots(struct btrfs_fs_info *fs_info)
 		}
 
 		/* All successful */
-		fs_info->generation = generation;
-		fs_info->last_trans_committed = generation;
+		fs_info->generation = btrfs_header_generation(tree_root->node);
+		fs_info->last_trans_committed = fs_info->generation;
 		fs_info->last_reloc_trans = 0;
 
 		/* Always begin writing backup roots after the one being used */
@@ -3602,21 +3623,12 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 
 	generation = btrfs_super_chunk_root_generation(disk_super);
 	level = btrfs_super_chunk_root_level(disk_super);
-
-	chunk_root->node = read_tree_block(fs_info,
-					   btrfs_super_chunk_root(disk_super),
-					   BTRFS_CHUNK_TREE_OBJECTID,
-					   generation, level, NULL);
-	if (IS_ERR(chunk_root->node) ||
-	    !extent_buffer_uptodate(chunk_root->node)) {
+	ret = load_super_root(chunk_root, btrfs_super_chunk_root(disk_super),
+			      generation, level);
+	if (ret) {
 		btrfs_err(fs_info, "failed to read chunk root");
-		if (!IS_ERR(chunk_root->node))
-			free_extent_buffer(chunk_root->node);
-		chunk_root->node = NULL;
 		goto fail_tree_roots;
 	}
-	btrfs_set_root_node(&chunk_root->root_item, chunk_root->node);
-	chunk_root->commit_root = btrfs_root_node(chunk_root);
 
 	read_extent_buffer(chunk_root->node, fs_info->chunk_tree_uuid,
 			   offsetof(struct btrfs_header, chunk_tree_uuid),
-- 
2.26.3

