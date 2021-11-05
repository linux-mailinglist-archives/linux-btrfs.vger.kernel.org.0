Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49B3A4469C3
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Nov 2021 21:29:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233549AbhKEUcA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 5 Nov 2021 16:32:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233661AbhKEUb6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 5 Nov 2021 16:31:58 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7885C061205
        for <linux-btrfs@vger.kernel.org>; Fri,  5 Nov 2021 13:29:18 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id bq14so9861159qkb.1
        for <linux-btrfs@vger.kernel.org>; Fri, 05 Nov 2021 13:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=gu7HOXiHuQF5da9poC2RJM3rjxql9e+Hy+BIZIGmE94=;
        b=k+dkgEW3yoEWAceKFyi68WLlz2rscRGE5NXbquwdNSxCZo9R34ZuH6j6sB1MOv7gqk
         SAFvXUe9ZAVQoP0Wrw/YBsNTnNKPQlB0Zz3yME4kTZJS5kQCMjPjf5QrnEnCJdXrrirJ
         hIAG/m2U6xHXhA8fjRd4VSuN/k1A4iPi3XKRytlS2VXMMSxzkmICmeLapcF8x0W3vShR
         kQx2uxyxrT8lpc1l8e0npF2bySZEPoMXTTtfHCmpv+2Qr5BlyHyHJv1Bx+jOSUUbWU/0
         se56sEdVIpeQmuvZxKmzKzMYXP6B3cyNBLMvggXmaEZNTix78A7UYUxVEKoHEfHHLsbA
         wa2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gu7HOXiHuQF5da9poC2RJM3rjxql9e+Hy+BIZIGmE94=;
        b=1+9zj20YmgEdds1geiuBb9LMOKDgncDP6VdAS8WhDwU5gd+RJPrWnHTD+ZVKKeM3Ct
         llkP1ULUbkQrxgStbKYuy99ifyv8X8qA9wf1N1NWu0YaIi/dNYW47thBdA6qsInKS/wg
         lHTlJh8GLgOJd6axW/LSYr8H53k8SrU8pUFF+c6FQ4XtdRfx/0/RziOGO636U2t7/mdn
         yQFRefJ1B5QFxQgO/zGWrlagGkIy5YFMzqiWXsyByjUsQB75yoV+EaktJmOENERHiOYY
         ulNgxVeJwWg9yjlzm4lVvEfDPNRSy6Tjyo/9jWZrGRlZfsZbFBdtG6KnDILx10qbohwp
         GQnw==
X-Gm-Message-State: AOAM530WTOYJ/Jmf27t6wLt3N+CKNa/eIPmgTIw4zm4lD9yumBCSGncN
        wRjPysXQu2hK3zowKyqnn7FLJ01hNMR4Pw==
X-Google-Smtp-Source: ABdhPJyj6foBkwDy0jkOOlHMQYtwku3Nn4uu0vIPzL8hq5OPxSEN+dRP+Wj5Ym3vN8GWJrwimssdEw==
X-Received: by 2002:a05:620a:45aa:: with SMTP id bp42mr1451930qkb.3.1636144157690;
        Fri, 05 Nov 2021 13:29:17 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id z186sm5856408qke.59.2021.11.05.13.29.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Nov 2021 13:29:17 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 20/20] btrfs-progs: common: search all extent roots for marking used space
Date:   Fri,  5 Nov 2021 16:28:45 -0400
Message-Id: <0784692da4fce3f789d2a532ea9e0237f9312d8e.1636143924.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1636143924.git.josef@toxicpanda.com>
References: <cover.1636143924.git.josef@toxicpanda.com>
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
index c8624eaa..0feaf6c3 100644
--- a/common/repair.c
+++ b/common/repair.c
@@ -153,47 +153,27 @@ int btrfs_mark_used_tree_blocks(struct btrfs_fs_info *fs_info,
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
@@ -206,23 +186,97 @@ int btrfs_fix_block_accounting(struct btrfs_trans_handle *trans)
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

