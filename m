Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD36D4D0A97
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Mar 2022 23:11:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242331AbiCGWMG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Mar 2022 17:12:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231339AbiCGWME (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Mar 2022 17:12:04 -0500
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B33076E21
        for <linux-btrfs@vger.kernel.org>; Mon,  7 Mar 2022 14:11:08 -0800 (PST)
Received: by mail-qv1-xf36.google.com with SMTP id kl20so3542963qvb.10
        for <linux-btrfs@vger.kernel.org>; Mon, 07 Mar 2022 14:11:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=vXwiNw41dpMVHEAMwbd3zad5Tn8bkYaHOIE12AosY58=;
        b=jvr43T1k8T2nm3i+esx+xVRgk05CtZ9/vQMTkiPP3riyRD3TB+YllgRISiTzcJlf9X
         iSN1GK8KAGslXBmYZNx1CeAQuZ+eIP8WsT9DsPTUm3MD9EEhNsiYepe/Qr+GYvuOZ34N
         7izGXTZqtNKoowir3NZx/lLJ6bUBf0AVgx1pOyQ/WppQ9mq2FwdK4XwSvmExdmEYxSV6
         zGTv3WncaR/53N/tkQaZBq9FPd4y6PDS04dq0D+/odkfHBukp53Q4RAC7je/xX/DNtMy
         ZZF+M+EFzb8YVb6D8Xats93GBiyrPC+PJJZjRA9gpDqev80/vh/dM6/i0/qpftYq3R6l
         0Rtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vXwiNw41dpMVHEAMwbd3zad5Tn8bkYaHOIE12AosY58=;
        b=2LipuEFDxIfRJUzZlTp+kl9K+e+4zssmXLlizcn0j/Z5f59Njm1Unnu3GwMenHZHBo
         xzK/q/dKHX0yZIcngJeVFhvGQ35jh+vukO69sKC9u6lAVFgJb+je+iPxv93onyINQ9ZI
         T82gWOwXm8JQNzxWPbHLvyWwqNXv3CfspiXJUpjLB6ebEkdPOJPkmEOHKME6mS/Dkg7R
         s7ONGaIOSLdeLuOP7ooOGU12HkSs4Z/baFsKveKjgzuZbfmbcOMdEts/bSz1SwlUlnf0
         7qu1W7e0ZkpUXI+lFnaF/JQFCuh2n1P1sjr18zLbOoOOcbIohMEqMBrEvgDT0DXKTf8B
         TM1A==
X-Gm-Message-State: AOAM533AzWg16HGydBnxIUQjBURa7Bkwq3CmaHU+nC/uGPAIZRSnv280
        mP0bL+dpHJag/zhbUoWKs7x5W21mPdBpjEzm
X-Google-Smtp-Source: ABdhPJyY731C4e18W/avZIRJUskUvfR97nipgitjm54kiNwzFyTspg7w5B3eETwftqdxqW4l4njRbA==
X-Received: by 2002:a05:6214:19ed:b0:42c:289b:860e with SMTP id q13-20020a05621419ed00b0042c289b860emr10094412qvc.73.1646691067024;
        Mon, 07 Mar 2022 14:11:07 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id f9-20020a05620a15a900b00646d7cb7afbsm6611487qkk.19.2022.03.07.14.11.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 14:11:06 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v5 01/19] btrfs-progs: add support for loading the block group root
Date:   Mon,  7 Mar 2022 17:10:46 -0500
Message-Id: <705b3c799320c5a07b27d6c36919cd7698b384fc.1646690972.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1646690972.git.josef@toxicpanda.com>
References: <cover.1646690972.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This adds the ability to load the block group root, as well as make sure
the various backup super block and super block updates are made
appropriately.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 kernel-shared/ctree.h       |   1 +
 kernel-shared/disk-io.c     | 161 +++++++++++++++++++++++++++---------
 kernel-shared/disk-io.h     |  10 ++-
 kernel-shared/extent-tree.c |   8 +-
 kernel-shared/transaction.c |   2 +
 5 files changed, 138 insertions(+), 44 deletions(-)

diff --git a/kernel-shared/ctree.h b/kernel-shared/ctree.h
index addfafc7..b12dbff1 100644
--- a/kernel-shared/ctree.h
+++ b/kernel-shared/ctree.h
@@ -1201,6 +1201,7 @@ struct btrfs_fs_info {
 	struct btrfs_root *dev_root;
 	struct btrfs_root *quota_root;
 	struct btrfs_root *uuid_root;
+	struct btrfs_root *block_group_root;
 
 	struct rb_root global_roots_tree;
 	struct rb_root fs_root_tree;
diff --git a/kernel-shared/disk-io.c b/kernel-shared/disk-io.c
index 0434ed7d..3d1157ad 100644
--- a/kernel-shared/disk-io.c
+++ b/kernel-shared/disk-io.c
@@ -857,6 +857,9 @@ struct btrfs_root *btrfs_read_fs_root(struct btrfs_fs_info *fs_info,
 		root = btrfs_global_root(fs_info, location);
 		return root ? root : ERR_PTR(-ENOENT);
 	}
+	if (location->objectid == BTRFS_BLOCK_GROUP_TREE_OBJECTID)
+		return fs_info->block_group_root ? fs_info->block_group_root :
+						ERR_PTR(-ENOENT);
 
 	BUG_ON(location->objectid == BTRFS_TREE_RELOC_OBJECTID);
 
@@ -895,6 +898,7 @@ void btrfs_free_fs_info(struct btrfs_fs_info *fs_info)
 	free(fs_info->chunk_root);
 	free(fs_info->dev_root);
 	free(fs_info->uuid_root);
+	free(fs_info->block_group_root);
 	free(fs_info->super_copy);
 	free(fs_info->log_root_tree);
 	free(fs_info);
@@ -913,10 +917,12 @@ struct btrfs_fs_info *btrfs_new_fs_info(int writable, u64 sb_bytenr)
 	fs_info->dev_root = calloc(1, sizeof(struct btrfs_root));
 	fs_info->quota_root = calloc(1, sizeof(struct btrfs_root));
 	fs_info->uuid_root = calloc(1, sizeof(struct btrfs_root));
+	fs_info->block_group_root = calloc(1, sizeof(struct btrfs_root));
 	fs_info->super_copy = calloc(1, BTRFS_SUPER_INFO_SIZE);
 
 	if (!fs_info->tree_root || !fs_info->chunk_root || !fs_info->dev_root ||
-	    !fs_info->quota_root || !fs_info->uuid_root || !fs_info->super_copy)
+	    !fs_info->quota_root || !fs_info->uuid_root ||
+	    !fs_info->block_group_root || !fs_info->super_copy)
 		goto free_all;
 
 	extent_io_tree_init(&fs_info->extent_cache);
@@ -1040,7 +1046,7 @@ static int read_root_or_create_block(struct btrfs_fs_info *fs_info,
 static inline bool maybe_load_block_groups(struct btrfs_fs_info *fs_info,
 					   u64 flags)
 {
-	struct btrfs_root *root = btrfs_extent_root(fs_info, 0);
+	struct btrfs_root *root = btrfs_block_group_root(fs_info);
 
 	if (flags & OPEN_CTREE_NO_BLOCK_GROUPS)
 		return false;
@@ -1051,7 +1057,6 @@ static inline bool maybe_load_block_groups(struct btrfs_fs_info *fs_info,
 	return false;
 }
 
-
 static int load_global_roots_objectid(struct btrfs_fs_info *fs_info,
 				      struct btrfs_path *path, u64 objectid,
 				      unsigned flags, char *str)
@@ -1202,43 +1207,99 @@ out:
 	return ret;
 }
 
-int btrfs_setup_all_roots(struct btrfs_fs_info *fs_info, u64 root_tree_bytenr,
-			  unsigned flags)
+static int load_important_roots(struct btrfs_fs_info *fs_info,
+				u64 root_tree_bytenr, unsigned flags)
 {
 	struct btrfs_super_block *sb = fs_info->super_copy;
+	struct btrfs_root_backup *backup = NULL;
 	struct btrfs_root *root;
-	struct btrfs_key key;
-	u64 generation;
+	u64 bytenr, gen;
 	int level;
+	int index = -1;
 	int ret;
 
-	root = fs_info->tree_root;
-	btrfs_setup_root(root, fs_info, BTRFS_ROOT_TREE_OBJECTID);
-	generation = btrfs_super_generation(sb);
-	level = btrfs_super_root_level(sb);
-
-	if (!root_tree_bytenr && !(flags & OPEN_CTREE_BACKUP_ROOT)) {
-		root_tree_bytenr = btrfs_super_root(sb);
-	} else if (flags & OPEN_CTREE_BACKUP_ROOT) {
-		struct btrfs_root_backup *backup;
-		int index = find_best_backup_root(sb);
+	if (flags & OPEN_CTREE_BACKUP_ROOT) {
+		index = find_best_backup_root(sb);
 		if (index >= BTRFS_NUM_BACKUP_ROOTS) {
 			fprintf(stderr, "Invalid backup root number\n");
 			return -EIO;
 		}
-		backup = fs_info->super_copy->super_roots + index;
-		root_tree_bytenr = btrfs_backup_tree_root(backup);
-		generation = btrfs_backup_tree_root_gen(backup);
+		backup = sb->super_roots + index;
+	}
+
+	if (!btrfs_fs_incompat(fs_info, EXTENT_TREE_V2)) {
+		free(fs_info->block_group_root);
+		fs_info->block_group_root = NULL;
+		goto tree_root;
+	}
+
+	if (backup) {
+		bytenr = btrfs_backup_block_group_root(backup);
+		gen = btrfs_backup_block_group_root_gen(backup);
+		level = btrfs_backup_block_group_root_level(backup);
+	} else {
+		bytenr = btrfs_super_block_group_root(sb);
+		gen = btrfs_super_block_group_root_generation(sb);
+		level = btrfs_super_block_group_root_level(sb);
+	}
+	root = fs_info->block_group_root;
+	btrfs_setup_root(root, fs_info, BTRFS_BLOCK_GROUP_TREE_OBJECTID);
+
+	ret = read_root_node(fs_info, root, bytenr, gen, level);
+	if (ret) {
+		fprintf(stderr, "Couldn't read block group root\n");
+		return -EIO;
+	}
+
+	if (maybe_load_block_groups(fs_info, flags)) {
+		int ret = btrfs_read_block_groups(fs_info);
+		if (ret < 0 && ret != -ENOENT) {
+			errno = -ret;
+			error("failed to read block groups: %m");
+			return ret;
+		}
+	}
+
+tree_root:
+	if (backup) {
+		bytenr = btrfs_backup_tree_root(backup);
+		gen = btrfs_backup_tree_root_gen(backup);
 		level = btrfs_backup_tree_root_level(backup);
+	} else {
+		if (root_tree_bytenr)
+			bytenr = root_tree_bytenr;
+		else
+			bytenr = btrfs_super_root(sb);
+		gen = btrfs_super_generation(sb);
+		level = btrfs_super_root_level(sb);
 	}
 
-	ret = read_root_node(fs_info, root, root_tree_bytenr, generation,
-			     level);
+	fs_info->generation = gen;
+	fs_info->last_trans_committed = gen;
+	root = fs_info->tree_root;
+	btrfs_setup_root(root, fs_info, BTRFS_ROOT_TREE_OBJECTID);
+
+	ret = read_root_node(fs_info, root, bytenr, gen, level);
 	if (ret) {
 		fprintf(stderr, "Couldn't read tree root\n");
 		return -EIO;
 	}
 
+	return 0;
+}
+
+int btrfs_setup_all_roots(struct btrfs_fs_info *fs_info, u64 root_tree_bytenr,
+			  unsigned flags)
+{
+	struct btrfs_super_block *sb = fs_info->super_copy;
+	struct btrfs_root *root = fs_info->tree_root;
+	struct btrfs_key key;
+	int ret;
+
+	ret = load_important_roots(fs_info, root_tree_bytenr, flags);
+	if (ret)
+		return ret;
+
 	ret = load_global_roots(fs_info, flags);
 	if (ret)
 		return ret;
@@ -1276,9 +1337,8 @@ int btrfs_setup_all_roots(struct btrfs_fs_info *fs_info, u64 root_tree_bytenr,
 			return -EIO;
 	}
 
-	fs_info->generation = generation;
-	fs_info->last_trans_committed = generation;
-	if (maybe_load_block_groups(fs_info, flags)) {
+	if (!btrfs_fs_incompat(fs_info, EXTENT_TREE_V2) &&
+	    maybe_load_block_groups(fs_info, flags)) {
 		ret = btrfs_read_block_groups(fs_info);
 		/*
 		 * If we don't find any blockgroups (ENOENT) we're either
@@ -1321,6 +1381,8 @@ static void release_global_roots(struct btrfs_fs_info *fs_info)
 void btrfs_release_all_roots(struct btrfs_fs_info *fs_info)
 {
 	release_global_roots(fs_info);
+	if (fs_info->block_group_root)
+		free_extent_buffer(fs_info->block_group_root->node);
 	if (fs_info->quota_root)
 		free_extent_buffer(fs_info->quota_root->node);
 	if (fs_info->dev_root)
@@ -2066,8 +2128,6 @@ static int write_dev_supers(struct btrfs_fs_info *fs_info,
 static void backup_super_roots(struct btrfs_fs_info *info)
 {
 	struct btrfs_root_backup *root_backup;
-	struct btrfs_root *csum_root = btrfs_csum_root(info, 0);
-	struct btrfs_root *extent_root = btrfs_extent_root(info, 0);
 	int next_backup;
 	int last_backup;
 
@@ -2099,11 +2159,6 @@ static void backup_super_roots(struct btrfs_fs_info *info)
 	btrfs_set_backup_chunk_root_level(root_backup,
 			       btrfs_header_level(info->chunk_root->node));
 
-	btrfs_set_backup_extent_root(root_backup, extent_root->node->start);
-	btrfs_set_backup_extent_root_gen(root_backup,
-			       btrfs_header_generation(extent_root->node));
-	btrfs_set_backup_extent_root_level(root_backup,
-			       btrfs_header_level(extent_root->node));
 	/*
 	 * we might commit during log recovery, which happens before we set
 	 * the fs_root.  Make sure it is valid before we fill it in.
@@ -2123,18 +2178,37 @@ static void backup_super_roots(struct btrfs_fs_info *info)
 	btrfs_set_backup_dev_root_level(root_backup,
 				       btrfs_header_level(info->dev_root->node));
 
-	btrfs_set_backup_csum_root(root_backup, csum_root->node->start);
-	btrfs_set_backup_csum_root_gen(root_backup,
-			       btrfs_header_generation(csum_root->node));
-	btrfs_set_backup_csum_root_level(root_backup,
-			       btrfs_header_level(csum_root->node));
-
 	btrfs_set_backup_total_bytes(root_backup,
 			     btrfs_super_total_bytes(info->super_copy));
 	btrfs_set_backup_bytes_used(root_backup,
 			     btrfs_super_bytes_used(info->super_copy));
 	btrfs_set_backup_num_devices(root_backup,
 			     btrfs_super_num_devices(info->super_copy));
+
+	if (btrfs_fs_incompat(info, EXTENT_TREE_V2)) {
+		btrfs_set_backup_block_group_root(root_backup,
+				info->block_group_root->node->start);
+		btrfs_set_backup_block_group_root_gen(root_backup,
+			btrfs_header_generation(info->block_group_root->node));
+		btrfs_set_backup_block_group_root_level(root_backup,
+			btrfs_header_level(info->block_group_root->node));
+	} else {
+		struct btrfs_root *csum_root = btrfs_csum_root(info, 0);
+		struct btrfs_root *extent_root = btrfs_extent_root(info, 0);
+
+		btrfs_set_backup_csum_root(root_backup, csum_root->node->start);
+		btrfs_set_backup_csum_root_gen(root_backup,
+				btrfs_header_generation(csum_root->node));
+		btrfs_set_backup_csum_root_level(root_backup,
+				btrfs_header_level(csum_root->node));
+
+		btrfs_set_backup_extent_root(root_backup,
+					     extent_root->node->start);
+		btrfs_set_backup_extent_root_gen(root_backup,
+			btrfs_header_generation(extent_root->node));
+		btrfs_set_backup_extent_root_level(root_backup,
+			btrfs_header_level(extent_root->node));
+	}
 }
 
 int write_all_supers(struct btrfs_fs_info *fs_info)
@@ -2181,7 +2255,7 @@ int write_ctree_super(struct btrfs_trans_handle *trans)
 	struct btrfs_fs_info *fs_info = trans->fs_info;
 	struct btrfs_root *tree_root = fs_info->tree_root;
 	struct btrfs_root *chunk_root = fs_info->chunk_root;
-
+	struct btrfs_root *block_group_root = fs_info->block_group_root;
 	if (fs_info->readonly)
 		return 0;
 
@@ -2198,6 +2272,15 @@ int write_ctree_super(struct btrfs_trans_handle *trans)
 	btrfs_set_super_chunk_root_generation(fs_info->super_copy,
 				btrfs_header_generation(chunk_root->node));
 
+	if (btrfs_fs_incompat(fs_info, EXTENT_TREE_V2)) {
+		btrfs_set_super_block_group_root(fs_info->super_copy,
+						 block_group_root->node->start);
+		btrfs_set_super_block_group_root_generation(fs_info->super_copy,
+				btrfs_header_generation(block_group_root->node));
+		btrfs_set_super_block_group_root_level(fs_info->super_copy,
+				btrfs_header_level(block_group_root->node));
+	}
+
 	ret = write_all_supers(fs_info);
 	if (ret)
 		fprintf(stderr, "failed to write new super block err %d\n", ret);
diff --git a/kernel-shared/disk-io.h b/kernel-shared/disk-io.h
index d55ced1e..1e9044f8 100644
--- a/kernel-shared/disk-io.h
+++ b/kernel-shared/disk-io.h
@@ -223,9 +223,17 @@ struct btrfs_root *btrfs_create_tree(struct btrfs_trans_handle *trans,
 				     u64 objectid);
 struct btrfs_root *btrfs_csum_root(struct btrfs_fs_info *fs_info, u64 bytenr);
 struct btrfs_root *btrfs_extent_root(struct btrfs_fs_info *fs_inf, u64 bytenr);
-struct btrfs_root *btrfs_block_group_root(struct btrfs_fs_info *fs_info);
 struct btrfs_root *btrfs_global_root(struct btrfs_fs_info *fs_info,
 				     struct btrfs_key *key);
 int btrfs_global_root_insert(struct btrfs_fs_info *fs_info,
 			     struct btrfs_root *root);
+
+static inline struct btrfs_root *btrfs_block_group_root(
+						struct btrfs_fs_info *fs_info)
+{
+	if (btrfs_fs_incompat(fs_info, EXTENT_TREE_V2))
+		return fs_info->block_group_root;
+	return btrfs_extent_root(fs_info, 0);
+}
+
 #endif
diff --git a/kernel-shared/extent-tree.c b/kernel-shared/extent-tree.c
index e36745ca..b2b99d4f 100644
--- a/kernel-shared/extent-tree.c
+++ b/kernel-shared/extent-tree.c
@@ -1540,7 +1540,7 @@ static int update_block_group_item(struct btrfs_trans_handle *trans,
 {
 	int ret;
 	struct btrfs_fs_info *fs_info = trans->fs_info;
-	struct btrfs_root *root = btrfs_extent_root(fs_info, 0);
+	struct btrfs_root *root = btrfs_block_group_root(fs_info);
 	unsigned long bi;
 	struct btrfs_block_group_item bgi;
 	struct extent_buffer *leaf;
@@ -2731,7 +2731,7 @@ int btrfs_read_block_groups(struct btrfs_fs_info *fs_info)
 	int ret;
 	struct btrfs_key key;
 
-	root = btrfs_extent_root(fs_info, 0);
+	root = btrfs_block_group_root(fs_info);
 	key.objectid = 0;
 	key.offset = 0;
 	key.type = BTRFS_BLOCK_GROUP_ITEM_KEY;
@@ -2812,7 +2812,7 @@ static int insert_block_group_item(struct btrfs_trans_handle *trans,
 	key.type = BTRFS_BLOCK_GROUP_ITEM_KEY;
 	key.offset = block_group->length;
 
-	root = btrfs_extent_root(fs_info, 0);
+	root = btrfs_block_group_root(fs_info);
 	return btrfs_insert_item(trans, root, &key, &bgi, sizeof(bgi));
 }
 
@@ -2929,7 +2929,7 @@ static int remove_block_group_item(struct btrfs_trans_handle *trans,
 {
 	struct btrfs_fs_info *fs_info = trans->fs_info;
 	struct btrfs_key key;
-	struct btrfs_root *root = btrfs_extent_root(fs_info, 0);
+	struct btrfs_root *root = btrfs_block_group_root(fs_info);
 	int ret = 0;
 
 	key.objectid = block_group->start;
diff --git a/kernel-shared/transaction.c b/kernel-shared/transaction.c
index 5b991651..02012266 100644
--- a/kernel-shared/transaction.c
+++ b/kernel-shared/transaction.c
@@ -185,6 +185,8 @@ int btrfs_commit_transaction(struct btrfs_trans_handle *trans,
 		goto commit_tree;
 	if (root == root->fs_info->chunk_root)
 		goto commit_tree;
+	if (root == root->fs_info->block_group_root)
+		goto commit_tree;
 
 	free_extent_buffer(root->commit_root);
 	root->commit_root = NULL;
-- 
2.26.3

