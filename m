Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25CED449C6A
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Nov 2021 20:27:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237350AbhKHT3l (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 8 Nov 2021 14:29:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237334AbhKHT3l (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 8 Nov 2021 14:29:41 -0500
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E4C6C061570
        for <linux-btrfs@vger.kernel.org>; Mon,  8 Nov 2021 11:26:56 -0800 (PST)
Received: by mail-qk1-x734.google.com with SMTP id n15so16513388qkp.12
        for <linux-btrfs@vger.kernel.org>; Mon, 08 Nov 2021 11:26:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=ywRd49RF0MstrK6f5cLCsNUMASHUsZ4Ly6fOCupP39Y=;
        b=gvR9mO1hlbKENd31yuUTS2a70nB7Iifcztp8i35g3V3txcYq/w38FwiikufRqutzzy
         iKQjeZb+Av8+ZSTuG5K+U91cgB3NC+DfkXU/F2jGP4YHwkmG/UPSaBndywVs7SBIC0GW
         VmzVRa0zBLJ/PLV1GblHOBckB9PIqaMr3Y5FVzR4/oigZCKDK7LFseE1DmpK8cwIUGRe
         86iSGBAaA3gBnDL6LYzn7/JqP7CiQJvf5HNQOOR+tIEbavGTg0wXT85SSeWLryW1IOwT
         3L/9PBQ09FZwKUw27mb0kx3DO2qjLppQYARDa3dSfqFZaMt+QdcCkOkIiTOJJkQ9Pq7b
         ZOPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ywRd49RF0MstrK6f5cLCsNUMASHUsZ4Ly6fOCupP39Y=;
        b=LtQnClyQfcfolPsAdoSoCN7kUYaT6Qp0tcWHnp0nHfz1iwS8BSJ7gsjOZK1xwi5VGM
         OTS8plmsyEZWBf8t2JQ2ZrwC4PczgCciKvWp5cJnoX3v0K8cQHY0M9OWPfn9o7ErHUOH
         O3XifLSKztrcELNj7WQNWQeg2D0w29H9tbKS6PZr20bIOVNQ1fchkcDU4Um59OkTMIsI
         CxU1uxHZlgicVjV2LllVYPoA0efd9c+f27RSNowKSxXCYg8/Gfhsg/7dJcpz1/qs2WCD
         9HqbCZxXD/tUeYcrHl7mTdEuMQFBMWEuCz/ZXiw5504oHJ0b7Ld8lu/a8BW8OQmUP+9Q
         BZUg==
X-Gm-Message-State: AOAM532P27/HYFK/GdJoIREifVB1gsd00sIbFXD2eg6Wyb/JJJVF5I19
        Mkq4ZEZsV8jLM5FyXRMbdimRwhvwoXLWKw==
X-Google-Smtp-Source: ABdhPJyIdr7GQAnnHzFv8CCzRDyMgh2fXKrtguFSfw+x01dVsSJs2lA6gcboENatYZwD/uzHhwuuCw==
X-Received: by 2002:a37:6295:: with SMTP id w143mr1239333qkb.86.1636399615373;
        Mon, 08 Nov 2021 11:26:55 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id z5sm11332590qtw.71.2021.11.08.11.26.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Nov 2021 11:26:54 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 04/20] btrfs-progs: add a helper for setting up a root node
Date:   Mon,  8 Nov 2021 14:26:32 -0500
Message-Id: <30280548dca2ebfdd8e92dcdf5fc5cc185984dd2.1636399481.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1636399481.git.josef@toxicpanda.com>
References: <cover.1636399481.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We use this pattern in a few places, and will use it more with different
roots in the future.  Extract out this helper to read the root nodes.

There is a behavior change here in that we're now checking the root
levels, whereas before we were not.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 kernel-shared/disk-io.c | 73 +++++++++++++++++++++++++----------------
 1 file changed, 45 insertions(+), 28 deletions(-)

diff --git a/kernel-shared/disk-io.c b/kernel-shared/disk-io.c
index 3b3c4523..7a797801 100644
--- a/kernel-shared/disk-io.c
+++ b/kernel-shared/disk-io.c
@@ -578,12 +578,31 @@ void btrfs_setup_root(struct btrfs_root *root, struct btrfs_fs_info *fs_info,
 	root->root_key.objectid = objectid;
 }
 
+static int read_root_node(struct btrfs_fs_info *fs_info,
+			  struct btrfs_root *root, u64 bytenr, u64 gen,
+			  int level)
+{
+	root->node = read_tree_block(fs_info, bytenr, gen);
+	if (!extent_buffer_uptodate(root->node))
+		goto err;
+	if (btrfs_header_level(root->node) != level) {
+		error("root [%llu %llu] level %d does not match %d\n",
+		      root->root_key.objectid, root->root_key.offset,
+		      btrfs_header_level(root->node), level);
+		goto err;
+	}
+	return 0;
+err:
+	free_extent_buffer(root->node);
+	root->node = NULL;
+	return -EIO;
+}
+
 static int find_and_setup_root(struct btrfs_root *tree_root,
 			       struct btrfs_fs_info *fs_info,
 			       u64 objectid, struct btrfs_root *root)
 {
 	int ret;
-	u64 generation;
 
 	btrfs_setup_root(root, fs_info, objectid);
 	ret = btrfs_find_last_root(tree_root, objectid,
@@ -591,13 +610,10 @@ static int find_and_setup_root(struct btrfs_root *tree_root,
 	if (ret)
 		return ret;
 
-	generation = btrfs_root_generation(&root->root_item);
-	root->node = read_tree_block(fs_info,
-			btrfs_root_bytenr(&root->root_item), generation);
-	if (!extent_buffer_uptodate(root->node))
-		return -EIO;
-
-	return 0;
+	return read_root_node(fs_info, root,
+			      btrfs_root_bytenr(&root->root_item),
+			      btrfs_root_generation(&root->root_item),
+			      btrfs_root_level(&root->root_item));
 }
 
 static int find_and_setup_log_root(struct btrfs_root *tree_root,
@@ -606,6 +622,7 @@ static int find_and_setup_log_root(struct btrfs_root *tree_root,
 {
 	u64 blocknr = btrfs_super_log_root(disk_super);
 	struct btrfs_root *log_root = malloc(sizeof(struct btrfs_root));
+	int ret;
 
 	if (!log_root)
 		return -ENOMEM;
@@ -615,20 +632,16 @@ static int find_and_setup_log_root(struct btrfs_root *tree_root,
 		return 0;
 	}
 
-	btrfs_setup_root(log_root, fs_info,
-			 BTRFS_TREE_LOG_OBJECTID);
-
-	log_root->node = read_tree_block(fs_info, blocknr,
-				     btrfs_super_generation(disk_super) + 1);
-
-	fs_info->log_root_tree = log_root;
-
-	if (!extent_buffer_uptodate(log_root->node)) {
-		free_extent_buffer(log_root->node);
+	btrfs_setup_root(log_root, fs_info, BTRFS_TREE_LOG_OBJECTID);
+	ret = read_root_node(fs_info, log_root, blocknr,
+			     btrfs_super_generation(disk_super) + 1,
+			     btrfs_super_log_root_level(disk_super));
+	if (ret) {
 		free(log_root);
 		fs_info->log_root_tree = NULL;
-		return -EIO;
+		return ret;
 	}
+	fs_info->log_root_tree = log_root;
 
 	return 0;
 }
@@ -704,9 +717,10 @@ out:
 		return ERR_PTR(ret);
 	}
 	generation = btrfs_root_generation(&root->root_item);
-	root->node = read_tree_block(fs_info,
-			btrfs_root_bytenr(&root->root_item), generation);
-	if (!extent_buffer_uptodate(root->node)) {
+	ret = read_root_node(fs_info, root,
+			     btrfs_root_bytenr(&root->root_item), generation,
+			     btrfs_root_level(&root->root_item));
+	if (ret) {
 		free(root);
 		return ERR_PTR(-EIO);
 	}
@@ -950,11 +964,13 @@ int btrfs_setup_all_roots(struct btrfs_fs_info *fs_info, u64 root_tree_bytenr,
 	struct btrfs_root *root;
 	struct btrfs_key key;
 	u64 generation;
+	int level;
 	int ret;
 
 	root = fs_info->tree_root;
 	btrfs_setup_root(root, fs_info, BTRFS_ROOT_TREE_OBJECTID);
 	generation = btrfs_super_generation(sb);
+	level = btrfs_super_root_level(sb);
 
 	if (!root_tree_bytenr && !(flags & OPEN_CTREE_BACKUP_ROOT)) {
 		root_tree_bytenr = btrfs_super_root(sb);
@@ -968,10 +984,12 @@ int btrfs_setup_all_roots(struct btrfs_fs_info *fs_info, u64 root_tree_bytenr,
 		backup = fs_info->super_copy->super_roots + index;
 		root_tree_bytenr = btrfs_backup_tree_root(backup);
 		generation = btrfs_backup_tree_root_gen(backup);
+		level = btrfs_backup_tree_root_level(backup);
 	}
 
-	root->node = read_tree_block(fs_info, root_tree_bytenr, generation);
-	if (!extent_buffer_uptodate(root->node)) {
+	ret = read_root_node(fs_info, root, root_tree_bytenr, generation,
+			     level);
+	if (ret) {
 		fprintf(stderr, "Couldn't read tree root\n");
 		return -EIO;
 	}
@@ -1179,10 +1197,9 @@ int btrfs_setup_chunk_tree_and_device_map(struct btrfs_fs_info *fs_info,
 	else
 		generation = 0;
 
-	fs_info->chunk_root->node = read_tree_block(fs_info,
-						    chunk_root_bytenr,
-						    generation);
-	if (!extent_buffer_uptodate(fs_info->chunk_root->node)) {
+	ret = read_root_node(fs_info, fs_info->chunk_root, chunk_root_bytenr,
+			     generation, btrfs_super_chunk_root_level(sb));
+	if (ret) {
 		if (fs_info->ignore_chunk_tree_error) {
 			warning("cannot read chunk root, continue anyway");
 			fs_info->chunk_root = NULL;
-- 
2.26.3

