Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EE44446A26
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Nov 2021 21:49:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233859AbhKEUwh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 5 Nov 2021 16:52:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233848AbhKEUwg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 5 Nov 2021 16:52:36 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99423C061714
        for <linux-btrfs@vger.kernel.org>; Fri,  5 Nov 2021 13:49:56 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id h17so6008237qtx.9
        for <linux-btrfs@vger.kernel.org>; Fri, 05 Nov 2021 13:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=yVh8JU65F4zOB3zyPEhTQfAsfAg/XCMiyD3uV0grP54=;
        b=ENkrKW7jpJiqsUIPKpIsmEpPd4E2bpqxE3X9ANo0JgMAR7iosp++uKfVDI2Sd1u2CQ
         MK9Tev9jRfgCJqLDGU0J4okymnI+ci7LOZWGeUzEXbhw5t0rh0UMYSIsmODkFi//2KLV
         P1relOCrIMTneNk9aIsqnk3oKF/iHEB3dYm95U3DRwoLiExU1YVtUKV7mtROwdAjgw+L
         bur5B34mcg+rPG9R/si4bRXa3gHhOOtsb0GPDqog5J0B80RBdDcmAYxIZlAu0Oje8VGN
         XR9oW7hu+cjskQCA9rPJqvwUw57pnUZB+xxbKlJwSXsuUqzN/vDNNxsLZNBRZ3n0i/Di
         zq1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yVh8JU65F4zOB3zyPEhTQfAsfAg/XCMiyD3uV0grP54=;
        b=TyZ9c6QLujnv1F+Sk5lZCxCLBWQRalN+AybQiB/tfOzO6QViduJoTdIu0KLpUcNGGd
         bxOnDDarO0TJ//rNFTcWD+lT3lHNaEbdtQ5HMZSNiXcmouWaiydhsGiIaWRKiMnTVTFv
         qWpMtWVX09PjPQRfP/NvPypURwIRakkPbNNEZzodK0GI9mi16UEWddYHBpSIoMNra4s/
         WxeFybep1ZRZQL1FPIIkcRLfxnHEZqoCxJS2ERfYe9735QiLotS+Lp65NfICNox8iRB2
         rpzoCIwSfpHY50lfAu20s9XhwH0SBOXCsukiKavqQW63p4+/37yobzhrd3Tgj4UxisDU
         Nv2w==
X-Gm-Message-State: AOAM531Azyz4DEGhNwTE/6oSA5FlhdSPlvIgpZVLtTikklVOqbglGBFO
        Ik9kby1fEGx+wiGGR5eh639X0+7BKU1W8w==
X-Google-Smtp-Source: ABdhPJyC8ViyTezOGzsoFnmEvX34GcY//M67KWsbsmRnDmUB0B3jMyhIlSz9JvQY81w0Q7zyn0PbiA==
X-Received: by 2002:ac8:5c49:: with SMTP id j9mr59690343qtj.234.1636145395440;
        Fri, 05 Nov 2021 13:49:55 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id z12sm899608qta.31.2021.11.05.13.49.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Nov 2021 13:49:55 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 6/8] btrfs: abstract out loading the tree root
Date:   Fri,  5 Nov 2021 16:49:43 -0400
Message-Id: <bbc75e31517cd654f51d8477839a4e057b494e3f.1636145221.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1636145221.git.josef@toxicpanda.com>
References: <cover.1636145221.git.josef@toxicpanda.com>
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
index 2a80b9b6d52d..db8e4856364e 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -2935,6 +2935,46 @@ static int btrfs_validate_write_super(struct btrfs_fs_info *fs_info,
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
@@ -2945,9 +2985,6 @@ static int __cold init_tree_roots(struct btrfs_fs_info *fs_info)
 	int i;
 
 	for (i = 0; i < BTRFS_NUM_BACKUP_ROOTS; i++) {
-		u64 generation;
-		int level;
-
 		if (handle_error) {
 			if (!IS_ERR(tree_root->node))
 				free_extent_buffer(tree_root->node);
@@ -2972,29 +3009,13 @@ static int __cold init_tree_roots(struct btrfs_fs_info *fs_info)
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
@@ -3014,8 +3035,8 @@ static int __cold init_tree_roots(struct btrfs_fs_info *fs_info)
 		}
 
 		/* All successful */
-		fs_info->generation = generation;
-		fs_info->last_trans_committed = generation;
+		fs_info->generation = btrfs_header_generation(tree_root->node);
+		fs_info->last_trans_committed = fs_info->generation;
 
 		/* Always begin writing backup roots after the one being used */
 		if (backup_index < 0) {
@@ -3605,21 +3626,12 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 
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

