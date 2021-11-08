Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C9D3449C7A
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Nov 2021 20:27:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237454AbhKHTaD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 8 Nov 2021 14:30:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235382AbhKHTaC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 8 Nov 2021 14:30:02 -0500
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB87EC061570
        for <linux-btrfs@vger.kernel.org>; Mon,  8 Nov 2021 11:27:17 -0800 (PST)
Received: by mail-qt1-x829.google.com with SMTP id j17so2605451qtx.2
        for <linux-btrfs@vger.kernel.org>; Mon, 08 Nov 2021 11:27:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=dh5NtxXWMDOkNMYn+zVAvicOZRqF8E8tiSET5wEDzi8=;
        b=SMQ4lJBtN3/3Vgd7D/kbnCLQXH3y0rwg0ezbaIu9fs045lpeYWfKcTqEWhpMqlosf8
         P+6QQbdCs3if9/ht3hv8ixW1br3tYUUaMU5/ZAgEBJ0Ob6q8YuIVeaJBi76FRgTL7f3x
         WgHIxCBTGHdCyEUoOSchd5z+pXCY6UaKfDQ2GG4nUKtTDuiwT2NzqgFrHSmj4xkq2F4u
         skaLHja+SUBUlQ7oDX5VHHN+J87NoQBoXfdQPLuUSRr6OZd23ha7Y5BTlHs0Sp7tsRaK
         iTnUim1hhnvL5A/7XfwnXmGgSU5B8jmxfjkGte2+WGC5XaDjFkUEdRspj0TDsOJw3Akd
         T9IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dh5NtxXWMDOkNMYn+zVAvicOZRqF8E8tiSET5wEDzi8=;
        b=fWGDDXrzzTpO+ji0bMzUxIUEAZIMleSYH+4LUMb17Wilty40q3r6bguU4M1BBEDt0e
         IEz1Tn2O6wbZB872PxZwdJpEy24h1yJxVZNpySxR+Y2UgjczBj+oQTw2Zh6xbtQfhaKl
         VDqm9pw5DLJsuWh7wTAkowfGsRvtmU09/yzoZvPV6hVOeahGso4hd7T+hElqKpJiAG+g
         I1Qr5f4ADoib8yVIxWXkQNcsYuYeGXU6P96qalivrK4fHARAWwjTTQ76yR9fNfes1XSD
         rteuDn2qFEFOz0ZAkvGOtFMDJ9EZKxVnMdfCtv7K6H32ICDu5FQJyUNmey3Rme17ZAS6
         T1kg==
X-Gm-Message-State: AOAM530siNuQ6BSWZEnJXhHyQMPELIDMbwKFqTowRmD/va3hqHmXlhRi
        H1ockoUfXPs+0SygonVD7DmKRYBGsnPJsA==
X-Google-Smtp-Source: ABdhPJxI1cZ2GqBl5QBIEuKGxbmhHHwuJxg3KGECjYmxUQfVdo1m3w2JHADT3hdVfOaXdFIAv/uFrg==
X-Received: by 2002:ac8:5e89:: with SMTP id r9mr2231296qtx.70.1636399636856;
        Mon, 08 Nov 2021 11:27:16 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id j8sm11548036qta.79.2021.11.08.11.27.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Nov 2021 11:27:16 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 20/20] btrfs-progs: common: search all extent roots for marking used space
Date:   Mon,  8 Nov 2021 14:26:48 -0500
Message-Id: <6938c46001f8ba5fd6c5476b7148afbcb0b02804.1636399482.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1636399481.git.josef@toxicpanda.com>
References: <cover.1636399481.git.josef@toxicpanda.com>
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
index 5de1335d..c5ed6704 100644
--- a/common/repair.c
+++ b/common/repair.c
@@ -150,47 +150,27 @@ int btrfs_mark_used_tree_blocks(struct btrfs_fs_info *fs_info,
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
@@ -203,23 +183,97 @@ int btrfs_fix_block_accounting(struct btrfs_trans_handle *trans)
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

