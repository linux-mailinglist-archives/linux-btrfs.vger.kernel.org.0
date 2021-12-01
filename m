Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F16104654FF
	for <lists+linux-btrfs@lfdr.de>; Wed,  1 Dec 2021 19:16:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbhLASTR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 1 Dec 2021 13:19:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244539AbhLASTD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 1 Dec 2021 13:19:03 -0500
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9909AC0613E0
        for <linux-btrfs@vger.kernel.org>; Wed,  1 Dec 2021 10:15:24 -0800 (PST)
Received: by mail-qv1-xf2e.google.com with SMTP id m17so22532232qvx.8
        for <linux-btrfs@vger.kernel.org>; Wed, 01 Dec 2021 10:15:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=QnkCVniF1guvZj/nG5J4jMpI4BWPXl1J45QuBunC7eE=;
        b=UBz6i1deAInnEWuUOak2cSrYkQ/4Qzj6u35uNRS9XKkTCjWcYLZ34APCnzISEwooy7
         7FcTuQYHzWbyZXizwbXk5KetwwTsqDw1Bn9dLaE9ILzWyQ0C1unL4X9Y0cLd3CxuJLkX
         Kr3eT9/e2kGA6Swz5bjXSQ7u7HG+39/NU9nEpuMf/sqNPLErG82OrbtmKrtbHyDMScCL
         Ne6xKEr41Jalyuprf6KVArA7pouKyeANxhlIeN67KMajapnJ8YQ7CaUEr5zxg7J0YshI
         xNqO3llXYJng4fgsbqyI+sfiF0Xv5kzs+cW1OlDtkF9QaICcPFIevYDEN6kc6aYmkbZM
         zLQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QnkCVniF1guvZj/nG5J4jMpI4BWPXl1J45QuBunC7eE=;
        b=7naTSXr6aVYR8aEj+yy6ytD65OrzC6SSFTCoZC3nsN/fteEtRAIZuTdjcWxFKXPn0t
         udax2R1zqSgKMTkqErvl7/yIhN1tHShmWr1PBygOelkeA3ysbzFDRDCC8MehRNayiVpg
         I7Q6j0rsuqaXhFahAOJ6ptK0X5HAiQwGZI8fFVBAiJItjvXfZRpVY3DKqLIy2rEzR8Rg
         lcnQL9/kukYDmCtILWxWQ17R2oizgRmtxPMCQMe85bHsr6aQbjhOPHtV2aGUz72IsPti
         2DjLwm59aTtkYCm9zXekMbkaSXGRVbS6rHD5hmf7BDwkkWFqPZggsa/CKkNuwy0LOl5I
         +SyQ==
X-Gm-Message-State: AOAM530PYOHekAaO3CzrE1YOZ2zhrgjA4AqZNnR1fbpWWRMrF9pMnt1m
        XkdIN7W0dPhVA4J3P+xEDSuk5Evd79Rd3g==
X-Google-Smtp-Source: ABdhPJx43QXyfdjEgWOEVG+quMyQaypiR5Z1RIdl8+rRcR79ohOLtH1NPSVFRkJHCVp5uxOjBaRQzg==
X-Received: by 2002:a05:6214:19e3:: with SMTP id q3mr8368570qvc.35.1638382523529;
        Wed, 01 Dec 2021 10:15:23 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id v5sm224306qtc.60.2021.12.01.10.15.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Dec 2021 10:15:23 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v3 8/8] btrfs-progs: common: search all extent roots for marking used space
Date:   Wed,  1 Dec 2021 13:15:10 -0500
Message-Id: <a9dc9a07a9c8ceae011107816ab265f3a3254a8a.1638382443.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1638382443.git.josef@toxicpanda.com>
References: <cover.1638382443.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We could have multiple extent roots, so add a helper to mark all the
used space in the FS based on any extent roots we find, and then use
this extent io tree to fixup the block group accounting.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 common/repair.c | 142 +++++++++++++++++++++++++++++++++---------------
 common/repair.h |   2 +
 2 files changed, 100 insertions(+), 44 deletions(-)

diff --git a/common/repair.c b/common/repair.c
index 41520b32..f8c3f89c 100644
--- a/common/repair.c
+++ b/common/repair.c
@@ -152,47 +152,27 @@ int btrfs_mark_used_tree_blocks(struct btrfs_fs_info *fs_info,
 	return ret;
 }
 
-/*
- * Fixup block accounting. The initial block accounting created by
- * make_block_groups isn't accuracy in this case.
- */
-int btrfs_fix_block_accounting(struct btrfs_trans_handle *trans)
+static int populate_used_from_extent_root(struct btrfs_root *root,
+					  struct extent_io_tree *io_tree)
 {
-	int ret = 0;
-	int slot;
-	u64 start = 0;
-	u64 bytes_used = 0;
+	struct btrfs_fs_info *fs_info = root->fs_info;
+	struct extent_buffer *leaf;
 	struct btrfs_path path;
 	struct btrfs_key key;
-	struct extent_buffer *leaf;
-	struct btrfs_block_group *cache;
-	struct btrfs_fs_info *fs_info = trans->fs_info;
-	struct btrfs_root *root = btrfs_extent_root(fs_info, 0);
-
-	ret = btrfs_run_delayed_refs(trans, -1);
-	if (ret)
-		return ret;
-
-	while(1) {
-		cache = btrfs_lookup_first_block_group(fs_info, start);
-		if (!cache)
-			break;
-
-		start = cache->start + cache->length;
-		cache->used = 0;
-		cache->space_info->bytes_used = 0;
-		if (list_empty(&cache->dirty_list))
-			list_add_tail(&cache->dirty_list, &trans->dirty_bgs);
-	}
+	int slot;
+	int ret;
 
 	btrfs_init_path(&path);
 	key.offset = 0;
 	key.objectid = 0;
 	key.type = BTRFS_EXTENT_ITEM_KEY;
-	ret = btrfs_search_slot(trans, root, &key, &path, 0, 0);
+	ret = btrfs_search_slot(NULL, root, &key, &path, 0, 0);
 	if (ret < 0)
 		return ret;
+
 	while(1) {
+		u64 start, end;
+
 		leaf = path.nodes[0];
 		slot = path.slots[0];
 		if (slot >= btrfs_header_nritems(leaf)) {
@@ -205,23 +185,97 @@ int btrfs_fix_block_accounting(struct btrfs_trans_handle *trans)
 			slot = path.slots[0];
 		}
 		btrfs_item_key_to_cpu(leaf, &key, slot);
-		if (key.type == BTRFS_EXTENT_ITEM_KEY) {
-			bytes_used += key.offset;
-			ret = btrfs_update_block_group(trans,
-				  key.objectid, key.offset, 1, 0);
-			BUG_ON(ret);
-		} else if (key.type == BTRFS_METADATA_ITEM_KEY) {
-			bytes_used += fs_info->nodesize;
-			ret = btrfs_update_block_group(trans,
-				  key.objectid, fs_info->nodesize, 1, 0);
-			if (ret)
-				goto out;
-		}
+		start = end = key.objectid;
+		if (key.type == BTRFS_EXTENT_ITEM_KEY)
+			end = start + key.offset - 1;
+		else if (key.type == BTRFS_METADATA_ITEM_KEY)
+			end = start + fs_info->nodesize - 1;
+
+		if (start != end)
+			set_extent_dirty(io_tree, start, end);
+
 		path.slots[0]++;
 	}
-	btrfs_set_super_bytes_used(root->fs_info->super_copy, bytes_used);
+	btrfs_release_path(&path);
+	return 0;
+}
+
+int btrfs_mark_used_blocks(struct btrfs_fs_info *fs_info,
+			   struct extent_io_tree *tree)
+{
+	struct btrfs_root *root;
+	struct rb_node *n;
+	int ret;
+
+	root = btrfs_extent_root(fs_info, 0);
+	while (1) {
+		ret = populate_used_from_extent_root(root, tree);
+		if (ret)
+			break;
+		n = rb_next(&root->rb_node);
+		if (!n)
+			break;
+		root = rb_entry(n, struct btrfs_root, rb_node);
+		if (root->root_key.objectid != BTRFS_EXTENT_TREE_OBJECTID)
+			break;
+	}
+
+	return ret;
+}
+
+/*
+ * Fixup block accounting. The initial block accounting created by
+ * make_block_groups isn't accuracy in this case.
+ */
+int btrfs_fix_block_accounting(struct btrfs_trans_handle *trans)
+{
+	struct extent_io_tree used;
+	struct btrfs_fs_info *fs_info = trans->fs_info;
+	struct btrfs_block_group *cache;
+	u64 start, end;
+	u64 bytes_used = 0;
+	int ret = 0;
+
+	ret = btrfs_run_delayed_refs(trans, -1);
+	if (ret)
+		return ret;
+
+	extent_io_tree_init(&used);
+
+	ret = btrfs_mark_used_blocks(fs_info, &used);
+	if (ret)
+		goto out;
+
+	start = 0;
+	while(1) {
+		cache = btrfs_lookup_first_block_group(fs_info, start);
+		if (!cache)
+			break;
+
+		start = cache->start + cache->length;
+		cache->used = 0;
+		cache->space_info->bytes_used = 0;
+		if (list_empty(&cache->dirty_list))
+			list_add_tail(&cache->dirty_list, &trans->dirty_bgs);
+	}
+
+	start = 0;
+	while (1) {
+		ret = find_first_extent_bit(&used, 0, &start, &end,
+					    EXTENT_DIRTY);
+		if (ret)
+			break;
+
+		bytes_used += end - start + 1;
+		ret = btrfs_update_block_group(trans, start, end - start + 1,
+					       1, 0);
+		if (ret)
+			goto out;
+		clear_extent_dirty(&used, start, end);
+	}
+	btrfs_set_super_bytes_used(fs_info->super_copy, bytes_used);
 	ret = 0;
 out:
-	btrfs_release_path(&path);
+	extent_io_tree_cleanup(&used);
 	return ret;
 }
diff --git a/common/repair.h b/common/repair.h
index 793ebcd2..1b19739d 100644
--- a/common/repair.h
+++ b/common/repair.h
@@ -35,5 +35,7 @@ int btrfs_add_corrupt_extent_record(struct btrfs_fs_info *info,
 int btrfs_fix_block_accounting(struct btrfs_trans_handle *trans);
 int btrfs_mark_used_tree_blocks(struct btrfs_fs_info *fs_info,
 				struct extent_io_tree *tree);
+int btrfs_mark_used_blocks(struct btrfs_fs_info *fs_info,
+			   struct extent_io_tree *tree);
 
 #endif
-- 
2.26.3

