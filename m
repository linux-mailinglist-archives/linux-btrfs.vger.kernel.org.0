Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 079BD44CA56
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Nov 2021 21:16:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232490AbhKJURs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 10 Nov 2021 15:17:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232179AbhKJURq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 10 Nov 2021 15:17:46 -0500
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AABDC061764
        for <linux-btrfs@vger.kernel.org>; Wed, 10 Nov 2021 12:14:59 -0800 (PST)
Received: by mail-qk1-x72c.google.com with SMTP id bm28so3669108qkb.9
        for <linux-btrfs@vger.kernel.org>; Wed, 10 Nov 2021 12:14:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=QnkCVniF1guvZj/nG5J4jMpI4BWPXl1J45QuBunC7eE=;
        b=3Csjp6DUlQhlncYxKtv0elq4/QDLFseEeBsPJ3ilwEIzcTqukOiELhNo6nB9QSJAM1
         gtGu0in6tRCYIGIEWZTwjqQEwyP4lsv5LxHbg4ni7Dx04U2XVuIxck6gFEICVErCEGgm
         vwF1t0PlFQwg2NPZum7XxrB/hOtnHtlTdfcUXOcs6/ES6msAKIDk2KGtes7jY60OqDSz
         K+HGbF8Ts+ZgwoHUd0cwjBDTnWQU1Ybxm5oEiE8hReYaAeSoKaEoG++ag7k6EmtLMOT+
         XhLqOFtv1BJy9G9OomRYpEBQjhMbVwG4SmKzV/P90sQfJsSXhqu/OaeieKIEeLeKzW+D
         XWoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QnkCVniF1guvZj/nG5J4jMpI4BWPXl1J45QuBunC7eE=;
        b=wP+DPqxtVjhkKS5RfP30SS+H+CA9U/cPBMAIKkZpQpmZwLjV6ZAEYXpyRRMIdBl2+u
         JvN3MLkqHqaCfhY9qm80uTEEzzIz7GuhlQSnQczQxWR2pQBxHWCqUd9WsIEqO92VsHfX
         j2JWk/cIRsJVTYXnOQ/JbuyRLv0Zk0Y0YZxDU43U6ws6E1TSItr93ucHwFj8Q/xsEp4n
         HpHL5C4VJa0JazrfpEXpMjPv12Txu2dBv3dOwqvk3H/TOQXhkjL2docB7b8EDGZbSSZZ
         iQXyDCVSkRiWVscpDmer8Xe8Jl1ey33UPxq/2zuA0pOkyDUjtjzXJhnTWX9euHcThraz
         3Zvw==
X-Gm-Message-State: AOAM532IE/qwGetit8eu8c6VVeg1Nlc8OUKRbsdkkGK5QTm9AyiAeMxv
        gO84zi+OITDKg7lzvVL1CkPMVehj3ggY3A==
X-Google-Smtp-Source: ABdhPJwaMNOgDTkWRVP1xJHmjvo/JCyECLrxsEhUnoSvLcYP9yN3Ih/LwzjiFk/ZAN5+RZ5tJE+Rbw==
X-Received: by 2002:a37:4041:: with SMTP id n62mr1669579qka.225.1636575297934;
        Wed, 10 Nov 2021 12:14:57 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id z10sm531377qtj.64.2021.11.10.12.14.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Nov 2021 12:14:57 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 08/30] btrfs-progs: common: search all extent roots for marking used space
Date:   Wed, 10 Nov 2021 15:14:20 -0500
Message-Id: <03e397030d8d3cf26f755873adf3a020d0d620b5.1636575146.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1636575146.git.josef@toxicpanda.com>
References: <cover.1636575146.git.josef@toxicpanda.com>
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

