Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 265D9785A9B
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Aug 2023 16:33:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236475AbjHWOd3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Aug 2023 10:33:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236454AbjHWOd0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Aug 2023 10:33:26 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 962E3E7B
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Aug 2023 07:33:16 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id 5614622812f47-3a85b9c6ccdso2310946b6e.0
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Aug 2023 07:33:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20221208.gappssmtp.com; s=20221208; t=1692801196; x=1693405996;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tfleQjaFJsXHG17PceH0WHvIOOmL6GRR1AUP0cpo0m0=;
        b=JcTjc3+f1xCzqZhrK8CpTvc/Z1OcjxeTQ6eSZiJVKPCFV1AFOvNbDn1jLc8X0g5j4U
         aGtevbIXhkMA+aIRDkBllpxLZ+jlUiXoW8f8H8JTMkl4v+slBsyomXy9timXfohGN81D
         I721wcqd2i8Ss9mCLt/DkDP7gErRCtV3Drmqf1KbiO8wGlukkg1EFy1FvRVBlVaYIU5l
         cFmT/rl5XjFbVGyICBw0kmSCh+iJTfnmhl8RXL9l2hp3juiBRjeYfkmpCb4r63i3ylEu
         A/ZQB7FEwOb4gCDm9ti1HNqitdpjq417PEzxWOWpP7aAUI08GcJjxYc5XvV2IdH2QByy
         VUJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692801196; x=1693405996;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tfleQjaFJsXHG17PceH0WHvIOOmL6GRR1AUP0cpo0m0=;
        b=HrEymtZJW/1/aBsJIyXVPVfAXx2vOoZkQHYbtZjBLChuQDParyr7+OOE+qlm3wnoXC
         QTPDBHUA0AMqT8xMZJ5n/dWTJu43gjGas5nAn0WsIK4FeVf9McUPJh6jFqzbIuojTx4a
         kApG+fpvA412qzSZvxAV0PmVkTGQMSMWA04gQ3XDpRbZ//qj7eButpiCjGKRn5Boo4IW
         6qKU+6TevOsl9cRxI5W9v0o4GZyzcYUlrWEP36Jjxy+Qybc2Cfg+w1sccJz74b/NbKrv
         2D6+Y5zCY8WG48M5c+ucob9Vz7WSyNHPnDEQbM2gqMGS3gpiYhfJACha5kCQLpUnRdDd
         ZTQA==
X-Gm-Message-State: AOJu0YwoeJYbaPo1xtBQtwllWNKrQsHBFua+MMjXHFsUN5DZdy8oWcz9
        QB6/QpFrVckzB7KnhP0zUKdIkozQImX6BCMRCAE=
X-Google-Smtp-Source: AGHT+IHt5bZqmMqCIoPRJCMN9eWadwo46kTZxtavcpZbu3DBAczkI7Xti7C7k+M2Jy6yoxFdVkt65A==
X-Received: by 2002:a05:6358:60c6:b0:135:acfd:8786 with SMTP id i6-20020a05635860c600b00135acfd8786mr10373035rwi.3.1692801195676;
        Wed, 23 Aug 2023 07:33:15 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id t10-20020a5b0dca000000b00d7497467d36sm1783368ybr.45.2023.08.23.07.33.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 07:33:15 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 06/38] btrfs-progs: update read_node_slot to match the kernel definition
Date:   Wed, 23 Aug 2023 10:32:32 -0400
Message-ID: <49aa985e67a6ee803cbbfa1992b4ec03e9eb7c6d.1692800904.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1692800904.git.josef@toxicpanda.com>
References: <cover.1692800904.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

In the kernel this is called btrfs_read_node_slot, and it doesn't take a
btrfs_fs_info.  Update the btrfs-progs version to match the kernel and
update all of the callers.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 cmds/restore.c             |  5 ++---
 kernel-shared/ctree.c      | 32 +++++++++++++++-----------------
 kernel-shared/ctree.h      |  4 ++--
 kernel-shared/print-tree.c |  2 +-
 4 files changed, 20 insertions(+), 23 deletions(-)

diff --git a/cmds/restore.c b/cmds/restore.c
index 7a360645..ba085f94 100644
--- a/cmds/restore.c
+++ b/cmds/restore.c
@@ -240,7 +240,6 @@ static int next_leaf(struct btrfs_root *root, struct btrfs_path *path)
 	int offset = 1;
 	struct extent_buffer *c;
 	struct extent_buffer *next = NULL;
-	struct btrfs_fs_info *fs_info = root->fs_info;
 
 again:
 	for (; level < BTRFS_MAX_LEVEL; level++) {
@@ -267,7 +266,7 @@ again:
 			continue;
 		}
 
-		next = read_node_slot(fs_info, c, slot);
+		next = btrfs_read_node_slot(c, slot);
 		if (extent_buffer_uptodate(next))
 			break;
 		offset++;
@@ -281,7 +280,7 @@ again:
 		path->slots[level] = 0;
 		if (!level)
 			break;
-		next = read_node_slot(fs_info, next, 0);
+		next = btrfs_read_node_slot(next, 0);
 		if (!extent_buffer_uptodate(next))
 			goto again;
 	}
diff --git a/kernel-shared/ctree.c b/kernel-shared/ctree.c
index a87a79b2..3b703f7c 100644
--- a/kernel-shared/ctree.c
+++ b/kernel-shared/ctree.c
@@ -833,9 +833,10 @@ int btrfs_bin_search(struct extent_buffer *eb, const struct btrfs_key *key,
 					  slot);
 }
 
-struct extent_buffer *read_node_slot(struct btrfs_fs_info *fs_info,
-				   struct extent_buffer *parent, int slot)
+struct extent_buffer *btrfs_read_node_slot(struct extent_buffer *parent,
+					   int slot)
 {
+	struct btrfs_fs_info *fs_info = parent->fs_info;
 	struct extent_buffer *ret;
 	int level = btrfs_header_level(parent);
 
@@ -909,7 +910,7 @@ static noinline int balance_level(struct btrfs_trans_handle *trans,
 			return 0;
 
 		/* promote the child to a root */
-		child = read_node_slot(fs_info, mid, 0);
+		child = btrfs_read_node_slot(mid, 0);
 		BUG_ON(!extent_buffer_uptodate(child));
 		ret = btrfs_cow_block(trans, root, child, mid, 0, &child);
 		BUG_ON(ret);
@@ -933,7 +934,7 @@ static noinline int balance_level(struct btrfs_trans_handle *trans,
 	    BTRFS_NODEPTRS_PER_BLOCK(fs_info) / 4)
 		return 0;
 
-	left = read_node_slot(fs_info, parent, pslot - 1);
+	left = btrfs_read_node_slot(parent, pslot - 1);
 	if (extent_buffer_uptodate(left)) {
 		wret = btrfs_cow_block(trans, root, left,
 				       parent, pslot - 1, &left);
@@ -942,7 +943,7 @@ static noinline int balance_level(struct btrfs_trans_handle *trans,
 			goto enospc;
 		}
 	}
-	right = read_node_slot(fs_info, parent, pslot + 1);
+	right = btrfs_read_node_slot(parent, pslot + 1);
 	if (extent_buffer_uptodate(right)) {
 		wret = btrfs_cow_block(trans, root, right,
 				       parent, pslot + 1, &right);
@@ -1097,7 +1098,7 @@ static noinline int push_nodes_for_insert(struct btrfs_trans_handle *trans,
 	if (!parent)
 		return 1;
 
-	left = read_node_slot(fs_info, parent, pslot - 1);
+	left = btrfs_read_node_slot(parent, pslot - 1);
 
 	/* first, try to make some room in the middle buffer */
 	if (extent_buffer_uptodate(left)) {
@@ -1137,7 +1138,7 @@ static noinline int push_nodes_for_insert(struct btrfs_trans_handle *trans,
 		}
 		free_extent_buffer(left);
 	}
-	right= read_node_slot(fs_info, parent, pslot + 1);
+	right= btrfs_read_node_slot(parent, pslot + 1);
 
 	/*
 	 * then try to empty the right most buffer into the middle
@@ -1389,7 +1390,7 @@ again:
 				reada_for_search(fs_info, p, level, slot,
 						 key->objectid);
 
-			b = read_node_slot(fs_info, b, slot);
+			b = btrfs_read_node_slot(b, slot);
 			if (!extent_buffer_uptodate(b))
 				return -EIO;
 		} else {
@@ -1941,7 +1942,6 @@ static int push_leaf_right(struct btrfs_trans_handle *trans, struct btrfs_root
 	struct extent_buffer *right;
 	struct extent_buffer *upper;
 	struct btrfs_disk_key disk_key;
-	struct btrfs_fs_info *fs_info = root->fs_info;
 	int slot;
 	u32 i;
 	int free_space;
@@ -1962,7 +1962,7 @@ static int push_leaf_right(struct btrfs_trans_handle *trans, struct btrfs_root
 	if (slot >= btrfs_header_nritems(upper) - 1)
 		return 1;
 
-	right = read_node_slot(fs_info, upper, slot + 1);
+	right = btrfs_read_node_slot(upper, slot + 1);
 	if (!extent_buffer_uptodate(right)) {
 		if (IS_ERR(right))
 			return PTR_ERR(right);
@@ -2090,7 +2090,6 @@ static int push_leaf_left(struct btrfs_trans_handle *trans, struct btrfs_root
 	struct btrfs_disk_key disk_key;
 	struct extent_buffer *right = path->nodes[0];
 	struct extent_buffer *left;
-	struct btrfs_fs_info *fs_info = root->fs_info;
 	int slot;
 	int i;
 	int free_space;
@@ -2114,7 +2113,7 @@ static int push_leaf_left(struct btrfs_trans_handle *trans, struct btrfs_root
 		return 1;
 	}
 
-	left = read_node_slot(fs_info, path->nodes[1], slot - 1);
+	left = btrfs_read_node_slot(path->nodes[1], slot - 1);
 	free_space = btrfs_leaf_free_space(left);
 	if (free_space < data_size) {
 		free_extent_buffer(left);
@@ -3046,7 +3045,6 @@ int btrfs_prev_leaf(struct btrfs_root *root, struct btrfs_path *path)
 	int level = 1;
 	struct extent_buffer *c;
 	struct extent_buffer *next = NULL;
-	struct btrfs_fs_info *fs_info = root->fs_info;
 
 	while(level < BTRFS_MAX_LEVEL) {
 		if (!path->nodes[level])
@@ -3062,7 +3060,7 @@ int btrfs_prev_leaf(struct btrfs_root *root, struct btrfs_path *path)
 		}
 		slot--;
 
-		next = read_node_slot(fs_info, c, slot);
+		next = btrfs_read_node_slot(c, slot);
 		if (!extent_buffer_uptodate(next)) {
 			if (IS_ERR(next))
 				return PTR_ERR(next);
@@ -3082,7 +3080,7 @@ int btrfs_prev_leaf(struct btrfs_root *root, struct btrfs_path *path)
 		path->slots[level] = slot;
 		if (!level)
 			break;
-		next = read_node_slot(fs_info, next, slot);
+		next = btrfs_read_node_slot(next, slot);
 		if (!extent_buffer_uptodate(next)) {
 			if (IS_ERR(next))
 				return PTR_ERR(next);
@@ -3125,7 +3123,7 @@ int btrfs_next_sibling_tree_block(struct btrfs_fs_info *fs_info,
 		if (path->reada)
 			reada_for_search(fs_info, path, level, slot, 0);
 
-		next = read_node_slot(fs_info, c, slot);
+		next = btrfs_read_node_slot(c, slot);
 		if (!extent_buffer_uptodate(next))
 			return -EIO;
 		break;
@@ -3148,7 +3146,7 @@ int btrfs_next_sibling_tree_block(struct btrfs_fs_info *fs_info,
 			break;
 		if (path->reada)
 			reada_for_search(fs_info, path, level, 0, 0);
-		next = read_node_slot(fs_info, next, 0);
+		next = btrfs_read_node_slot(next, 0);
 		if (!extent_buffer_uptodate(next))
 			return -EIO;
 	}
diff --git a/kernel-shared/ctree.h b/kernel-shared/ctree.h
index 15ac310e..dc11b246 100644
--- a/kernel-shared/ctree.h
+++ b/kernel-shared/ctree.h
@@ -949,8 +949,8 @@ int btrfs_convert_one_bg(struct btrfs_trans_handle *trans, u64 bytenr);
 int btrfs_comp_cpu_keys(const struct btrfs_key *k1, const struct btrfs_key *k2);
 int btrfs_del_ptr(struct btrfs_root *root, struct btrfs_path *path,
 		int level, int slot);
-struct extent_buffer *read_node_slot(struct btrfs_fs_info *fs_info,
-				   struct extent_buffer *parent, int slot);
+struct extent_buffer *btrfs_read_node_slot(struct extent_buffer *parent,
+					   int slot);
 int btrfs_previous_item(struct btrfs_root *root,
 			struct btrfs_path *path, u64 min_objectid,
 			int type);
diff --git a/kernel-shared/print-tree.c b/kernel-shared/print-tree.c
index d7ffeccd..38524971 100644
--- a/kernel-shared/print-tree.c
+++ b/kernel-shared/print-tree.c
@@ -1494,7 +1494,7 @@ static int search_leftmost_tree_block(struct btrfs_fs_info *fs_info,
 		struct extent_buffer *eb;
 
 		path->slots[i] = 0;
-		eb = read_node_slot(fs_info, path->nodes[i], 0);
+		eb = btrfs_read_node_slot(path->nodes[i], 0);
 		if (!extent_buffer_uptodate(eb)) {
 			ret = -EIO;
 			goto out;
-- 
2.41.0

