Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 278D24D0AE0
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Mar 2022 23:18:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343719AbiCGWTH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Mar 2022 17:19:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343717AbiCGWTD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Mar 2022 17:19:03 -0500
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B308443490
        for <linux-btrfs@vger.kernel.org>; Mon,  7 Mar 2022 14:18:08 -0800 (PST)
Received: by mail-qt1-x82f.google.com with SMTP id c4so14623754qtx.1
        for <linux-btrfs@vger.kernel.org>; Mon, 07 Mar 2022 14:18:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Fq3v1uDRXmslSeN4x/NtnJDVEFQe+KrsnFTFY/SrX14=;
        b=vCgNZ7v6LVaSAYDdjep4qZDQKlkSDV2ks7HE92fmixzK0bRzNlWW10GzbWdKWgiAPW
         XQ1KGYiicVzPKZpeTB3nVK6LWeHnjcH7KnPtc47yzXgzxBoq8DFO/sfoHJRu8p5+chFL
         qhNLE+3IgLlFtDP96lq66s7H3lqVKY8ljnB9TL04+ZwShqLxetc4gjnYRnUZfzVTMrDK
         colypHNVT5IJx2Lwj3cnrXreAgSQbtVNBtRHtliAg+TmwBrXQSzgEjMjNewLnC7c1Kgc
         EVtGvAchfw+1VnT+aTSDNJdgz9GjVLts6IytkET+1RdrN6gbbRrdlYBuGhC8Myu55Ey5
         CxkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Fq3v1uDRXmslSeN4x/NtnJDVEFQe+KrsnFTFY/SrX14=;
        b=O6OrspziPNb7aRBuwqCxBGFo81mJuo8PuNxRyBwHTq2up2xZ7e0eGB7JlE9BwD1fNM
         EVUvg4AhlZTwJT+L30iU0nOJE7SHjbgh6QyIBKKIhAsAROhIRLTwFzWy/3SB3nILDLLZ
         UQU0bpYrp3N3DVaRWTCOzPdd18SQvGqhy1FgUzCFBmk7t/Mu6mxMunRh4xqTAUsz9/bp
         EVuOfRdFgfjiZSW1Afa9nsh92fcH5Bvr/FSd1gEA08dNiME1hb18eEgKg+6nCkiquF9m
         4ZG/ARrx/WxsPw0IxRKeBjQhrlVVWDv/ZtWRkCJyevQc2XbWkdU5JRorfJSgs6TlTqyd
         eoKg==
X-Gm-Message-State: AOAM5319OuBGhOSbYazW5evVVBvea0xBPR0uiDINEMkJ/ee3YsxIAclj
        3rlEV49oIeZL7l9EqkS1PK7I/Ryt9o2dq1D0
X-Google-Smtp-Source: ABdhPJxPVskSTUF5/cL9LnVPjn5MP2KQeADD17tVWfMVa6GQBS2VtVWjAimhGBuw8SuFvAz0fhZcVA==
X-Received: by 2002:a05:622a:1a98:b0:2de:2c25:dcca with SMTP id s24-20020a05622a1a9800b002de2c25dccamr11130352qtc.121.1646691487519;
        Mon, 07 Mar 2022 14:18:07 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id o133-20020a37a58b000000b0067b36d0a5dfsm1258091qke.57.2022.03.07.14.18.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 14:18:07 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 12/15] btrfs-progs: delete the btrfs_create_root helper
Date:   Mon,  7 Mar 2022 17:17:46 -0500
Message-Id: <e44537ddaa769d95a5d91ff5469f2da2a8a2c32e.1646691255.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1646691255.git.josef@toxicpanda.com>
References: <cover.1646691255.git.josef@toxicpanda.com>
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

The only user of this is mkfs to make the quota root, everybody else
uses btrfs_create_tree().  Fix mkfs to use the btrfs_create_tree()
helper and delete btrfs_create_root().

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 kernel-shared/ctree.c | 98 -------------------------------------------
 kernel-shared/ctree.h |  2 -
 mkfs/main.c           | 12 ++++--
 3 files changed, 9 insertions(+), 103 deletions(-)

diff --git a/kernel-shared/ctree.c b/kernel-shared/ctree.c
index 6a578a41..c6ce82b0 100644
--- a/kernel-shared/ctree.c
+++ b/kernel-shared/ctree.c
@@ -198,104 +198,6 @@ int btrfs_copy_root(struct btrfs_trans_handle *trans,
 	return 0;
 }
 
-/*
- * Create a new tree root, with root objectid set to @objectid.
- *
- * NOTE: Doesn't support tree with non-zero offset, like data reloc tree.
- */
-int btrfs_create_root(struct btrfs_trans_handle *trans,
-		      struct btrfs_fs_info *fs_info, u64 objectid)
-{
-	struct extent_buffer *node;
-	struct btrfs_root *new_root;
-	struct btrfs_disk_key disk_key;
-	struct btrfs_key location;
-	struct btrfs_root_item root_item = { 0 };
-	int ret;
-
-	new_root = malloc(sizeof(*new_root));
-	if (!new_root)
-		return -ENOMEM;
-
-	btrfs_setup_root(new_root, fs_info, objectid);
-	if (!is_fstree(objectid))
-		new_root->track_dirty = 1;
-	add_root_to_dirty_list(new_root);
-
-	new_root->objectid = objectid;
-	new_root->root_key.objectid = objectid;
-	new_root->root_key.type = BTRFS_ROOT_ITEM_KEY;
-	new_root->root_key.offset = 0;
-
-	node = btrfs_alloc_free_block(trans, new_root, fs_info->nodesize,
-				      objectid, &disk_key, 0, 0, 0);
-	if (IS_ERR(node)) {
-		ret = PTR_ERR(node);
-		error("failed to create root node for tree %llu: %d (%m)",
-		      objectid, ret);
-		return ret;
-	}
-	new_root->node = node;
-
-	ret = btrfs_inc_ref(trans, new_root, node, 0);
-	if (ret < 0)
-		goto free;
-
-	/*
-	 * Special tree roots may need to modify pointers in @fs_info
-	 * Only quota is supported yet.
-	 */
-	switch (objectid) {
-	case BTRFS_QUOTA_TREE_OBJECTID:
-		if (fs_info->quota_root) {
-			error("quota root already exists");
-			ret = -EEXIST;
-			goto free;
-		}
-		fs_info->quota_root = new_root;
-		fs_info->quota_enabled = 1;
-		break;
-	/*
-	 * Essential trees can't be created by this function, yet.
-	 * As we expect such skeleton exists, or a lot of functions like
-	 * btrfs_alloc_free_block() doesn't work at all
-	 */
-	case BTRFS_ROOT_TREE_OBJECTID:
-	case BTRFS_EXTENT_TREE_OBJECTID:
-	case BTRFS_CHUNK_TREE_OBJECTID:
-	case BTRFS_FS_TREE_OBJECTID:
-		ret = -EEXIST;
-		goto free;
-	default:
-		/* Subvolume trees don't need special handling */
-		if (is_fstree(objectid))
-			break;
-		/* Other special trees are not supported yet */
-		ret = -ENOTTY;
-		goto free;
-	}
-	btrfs_mark_buffer_dirty(node);
-	btrfs_set_root_bytenr(&root_item, btrfs_header_bytenr(node));
-	btrfs_set_root_level(&root_item, 0);
-	btrfs_set_root_generation(&root_item, trans->transid);
-	btrfs_set_root_dirid(&root_item, 0);
-	btrfs_set_root_refs(&root_item, 1);
-	btrfs_set_root_used(&root_item, fs_info->nodesize);
-	location.objectid = objectid;
-	location.type = BTRFS_ROOT_ITEM_KEY;
-	location.offset = 0;
-
-	ret = btrfs_insert_root(trans, fs_info->tree_root, &location, &root_item);
-	if (ret < 0)
-		goto free;
-	return ret;
-
-free:
-	free_extent_buffer(node);
-	free(new_root);
-	return ret;
-}
-
 /*
  * check if the tree block can be shared by multiple trees
  */
diff --git a/kernel-shared/ctree.h b/kernel-shared/ctree.h
index 26a1db9a..8c4f6ed6 100644
--- a/kernel-shared/ctree.h
+++ b/kernel-shared/ctree.h
@@ -2758,8 +2758,6 @@ int btrfs_copy_root(struct btrfs_trans_handle *trans,
 		      struct btrfs_root *root,
 		      struct extent_buffer *buf,
 		      struct extent_buffer **cow_ret, u64 new_root_objectid);
-int btrfs_create_root(struct btrfs_trans_handle *trans,
-		      struct btrfs_fs_info *fs_info, u64 objectid);
 int btrfs_extend_item(struct btrfs_root *root, struct btrfs_path *path,
 		u32 data_size);
 int btrfs_truncate_item(struct btrfs_path *path, u32 new_size, int from_end);
diff --git a/mkfs/main.c b/mkfs/main.c
index 7bdbe64d..a2e6500e 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -918,12 +918,18 @@ static int setup_quota_root(struct btrfs_fs_info *fs_info)
 		error("failed to start transaction: %d (%m)", ret);
 		return ret;
 	}
-	ret = btrfs_create_root(trans, fs_info, BTRFS_QUOTA_TREE_OBJECTID);
-	if (ret < 0) {
+
+	key.objectid = BTRFS_QUOTA_TREE_OBJECTID;
+	key.type = BTRFS_ROOT_ITEM_KEY;
+	key.offset = 0;
+
+	quota_root = btrfs_create_tree(trans, fs_info, &key);
+	if (IS_ERR(quota_root)) {
+		ret = PTR_ERR(quota_root);
 		error("failed to create quota root: %d (%m)", ret);
 		goto fail;
 	}
-	quota_root = fs_info->quota_root;
+	fs_info->quota_root = quota_root;
 
 	key.objectid = 0;
 	key.type = BTRFS_QGROUP_STATUS_KEY;
-- 
2.26.3

