Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B15356F265C
	for <lists+linux-btrfs@lfdr.de>; Sat, 29 Apr 2023 22:21:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230016AbjD2UUU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 29 Apr 2023 16:20:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230155AbjD2UUT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 29 Apr 2023 16:20:19 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0E4F26B7
        for <linux-btrfs@vger.kernel.org>; Sat, 29 Apr 2023 13:20:12 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-54f8e823e47so16267317b3.2
        for <linux-btrfs@vger.kernel.org>; Sat, 29 Apr 2023 13:20:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20221208.gappssmtp.com; s=20221208; t=1682799611; x=1685391611;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/15BqUhxLLzxK50oeHbFym1ijxF6oOk1k4nxskxbyYQ=;
        b=gqu7l3XM6vyKx3u9g0QkaU5wW99hFAiXH3ywqY3Cp5Q13NONW4UWmwkL3+XqPdgh8I
         oHFAUIjB8wpt3Dfshtm9Im3sAcBR6ctljV96dRUt7gSMARI8KlkZHj09YvtgX7LSgHdF
         AIkJeHbUt6+9+HAoqrH1YTTyC3vM7U+kDrHCncWZ+I8/53fUcy9VO+sVmvVWFTrW3ApR
         6rlY1wn0Kl+3nWsH7A3IPUXSP3+SCKJJhVJduQyqWrxx1zyU/m/ZYRvb2Ls9TJoPSWTP
         Hxo7PBFqzkI41n635HFeSqS+CQ8LZVeAArZDWtddBLusC+M35fAK8eHPW9q5bvh02MbK
         /avA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682799611; x=1685391611;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/15BqUhxLLzxK50oeHbFym1ijxF6oOk1k4nxskxbyYQ=;
        b=ghTUYz0oZPC2Jmi/VvdRG6GwDLeRLI3evpE1mo8yjQqXhARnL+fTwKYGmD4r7+t/r1
         D2OuW3JVDsQIEATpKZj9tY4D2Ff4bYW1Aww6Lj6PTRxrW7yJHt9G3Me7L1VaCdeaY4fw
         NATvThBVoIp2PmOlp8KQVp5XZOHRLc/P8yp786iMOOS1FxXSiIq63194mr/8DrlU6q5U
         dd/yd9haCKRwyjp4hUb8vT7+tc9xDGKE9mk08cnCGEWXVhpEJYVPefZDYgxWfzteQM9b
         VTrAGhjJOBF75XjBL8LGV6rjCXlf8qJN6Rkf1zqtCxhlnI3iOobykyjQY9zFKGmvQS51
         Ho/g==
X-Gm-Message-State: AC+VfDxYi/c20ord/rFpr3sBQMcs8hmkcd31C1s9lCF3uETPzm6qh4J/
        rCxz50df9k4F1yBjtcyARUOTg4P8pKRnG9e3ZGZrUQ==
X-Google-Smtp-Source: ACHHUZ5HijgcSNYNen8rb73EkhIY+3gHcuC0N06/CrIR0rdzOzaM4LoHXElxyUR84s8Zu5kkn96Zlw==
X-Received: by 2002:a0d:f801:0:b0:55a:7c7:7b45 with SMTP id i1-20020a0df801000000b0055a07c77b45mr742243ywf.30.1682799611438;
        Sat, 29 Apr 2023 13:20:11 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id e204-20020a8169d5000000b0054605c23114sm596516ywc.66.2023.04.29.13.20.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Apr 2023 13:20:11 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 06/26] btrfs-progs: update read_node_slot to match the kernel definition
Date:   Sat, 29 Apr 2023 16:19:37 -0400
Message-Id: <a513866dca1fa1aa1b7393d944ffee6b1edbb96d.1682799405.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <cover.1682799405.git.josef@toxicpanda.com>
References: <cover.1682799405.git.josef@toxicpanda.com>
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
index 9fe7b4d2..31cad31f 100644
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
index b127dcf9..cbf735de 100644
--- a/kernel-shared/ctree.c
+++ b/kernel-shared/ctree.c
@@ -681,9 +681,10 @@ int btrfs_bin_search(struct extent_buffer *eb, const struct btrfs_key *key,
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
 
@@ -752,7 +753,7 @@ static int balance_level(struct btrfs_trans_handle *trans,
 			return 0;
 
 		/* promote the child to a root */
-		child = read_node_slot(fs_info, mid, 0);
+		child = btrfs_read_node_slot(mid, 0);
 		BUG_ON(!extent_buffer_uptodate(child));
 		ret = btrfs_cow_block(trans, root, child, mid, 0, &child);
 		BUG_ON(ret);
@@ -776,7 +777,7 @@ static int balance_level(struct btrfs_trans_handle *trans,
 	    BTRFS_NODEPTRS_PER_BLOCK(fs_info) / 4)
 		return 0;
 
-	left = read_node_slot(fs_info, parent, pslot - 1);
+	left = btrfs_read_node_slot(parent, pslot - 1);
 	if (extent_buffer_uptodate(left)) {
 		wret = btrfs_cow_block(trans, root, left,
 				       parent, pslot - 1, &left);
@@ -785,7 +786,7 @@ static int balance_level(struct btrfs_trans_handle *trans,
 			goto enospc;
 		}
 	}
-	right = read_node_slot(fs_info, parent, pslot + 1);
+	right = btrfs_read_node_slot(parent, pslot + 1);
 	if (extent_buffer_uptodate(right)) {
 		wret = btrfs_cow_block(trans, root, right,
 				       parent, pslot + 1, &right);
@@ -937,7 +938,7 @@ static int noinline push_nodes_for_insert(struct btrfs_trans_handle *trans,
 	if (!parent)
 		return 1;
 
-	left = read_node_slot(fs_info, parent, pslot - 1);
+	left = btrfs_read_node_slot(parent, pslot - 1);
 
 	/* first, try to make some room in the middle buffer */
 	if (extent_buffer_uptodate(left)) {
@@ -978,7 +979,7 @@ static int noinline push_nodes_for_insert(struct btrfs_trans_handle *trans,
 		}
 		free_extent_buffer(left);
 	}
-	right= read_node_slot(fs_info, parent, pslot + 1);
+	right= btrfs_read_node_slot(parent, pslot + 1);
 
 	/*
 	 * then try to empty the right most buffer into the middle
@@ -1230,7 +1231,7 @@ again:
 				reada_for_search(fs_info, p, level, slot,
 						 key->objectid);
 
-			b = read_node_slot(fs_info, b, slot);
+			b = btrfs_read_node_slot(b, slot);
 			if (!extent_buffer_uptodate(b))
 				return -EIO;
 		} else {
@@ -1789,7 +1790,6 @@ static int push_leaf_right(struct btrfs_trans_handle *trans, struct btrfs_root
 	struct extent_buffer *right;
 	struct extent_buffer *upper;
 	struct btrfs_disk_key disk_key;
-	struct btrfs_fs_info *fs_info = root->fs_info;
 	int slot;
 	u32 i;
 	int free_space;
@@ -1810,7 +1810,7 @@ static int push_leaf_right(struct btrfs_trans_handle *trans, struct btrfs_root
 	if (slot >= btrfs_header_nritems(upper) - 1)
 		return 1;
 
-	right = read_node_slot(fs_info, upper, slot + 1);
+	right = btrfs_read_node_slot(upper, slot + 1);
 	if (!extent_buffer_uptodate(right)) {
 		if (IS_ERR(right))
 			return PTR_ERR(right);
@@ -1938,7 +1938,6 @@ static int push_leaf_left(struct btrfs_trans_handle *trans, struct btrfs_root
 	struct btrfs_disk_key disk_key;
 	struct extent_buffer *right = path->nodes[0];
 	struct extent_buffer *left;
-	struct btrfs_fs_info *fs_info = root->fs_info;
 	int slot;
 	int i;
 	int free_space;
@@ -1962,7 +1961,7 @@ static int push_leaf_left(struct btrfs_trans_handle *trans, struct btrfs_root
 		return 1;
 	}
 
-	left = read_node_slot(fs_info, path->nodes[1], slot - 1);
+	left = btrfs_read_node_slot(path->nodes[1], slot - 1);
 	free_space = btrfs_leaf_free_space(left);
 	if (free_space < data_size) {
 		free_extent_buffer(left);
@@ -2898,7 +2897,6 @@ int btrfs_prev_leaf(struct btrfs_root *root, struct btrfs_path *path)
 	int level = 1;
 	struct extent_buffer *c;
 	struct extent_buffer *next = NULL;
-	struct btrfs_fs_info *fs_info = root->fs_info;
 
 	while(level < BTRFS_MAX_LEVEL) {
 		if (!path->nodes[level])
@@ -2914,7 +2912,7 @@ int btrfs_prev_leaf(struct btrfs_root *root, struct btrfs_path *path)
 		}
 		slot--;
 
-		next = read_node_slot(fs_info, c, slot);
+		next = btrfs_read_node_slot(c, slot);
 		if (!extent_buffer_uptodate(next)) {
 			if (IS_ERR(next))
 				return PTR_ERR(next);
@@ -2934,7 +2932,7 @@ int btrfs_prev_leaf(struct btrfs_root *root, struct btrfs_path *path)
 		path->slots[level] = slot;
 		if (!level)
 			break;
-		next = read_node_slot(fs_info, next, slot);
+		next = btrfs_read_node_slot(next, slot);
 		if (!extent_buffer_uptodate(next)) {
 			if (IS_ERR(next))
 				return PTR_ERR(next);
@@ -2977,7 +2975,7 @@ int btrfs_next_sibling_tree_block(struct btrfs_fs_info *fs_info,
 		if (path->reada)
 			reada_for_search(fs_info, path, level, slot, 0);
 
-		next = read_node_slot(fs_info, c, slot);
+		next = btrfs_read_node_slot(c, slot);
 		if (!extent_buffer_uptodate(next))
 			return -EIO;
 		break;
@@ -3000,7 +2998,7 @@ int btrfs_next_sibling_tree_block(struct btrfs_fs_info *fs_info,
 			break;
 		if (path->reada)
 			reada_for_search(fs_info, path, level, 0, 0);
-		next = read_node_slot(fs_info, next, 0);
+		next = btrfs_read_node_slot(next, 0);
 		if (!extent_buffer_uptodate(next))
 			return -EIO;
 	}
diff --git a/kernel-shared/ctree.h b/kernel-shared/ctree.h
index ce050cec..edf74fcc 100644
--- a/kernel-shared/ctree.h
+++ b/kernel-shared/ctree.h
@@ -948,8 +948,8 @@ int btrfs_convert_one_bg(struct btrfs_trans_handle *trans, u64 bytenr);
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
index 6cdfdef7..594c524f 100644
--- a/kernel-shared/print-tree.c
+++ b/kernel-shared/print-tree.c
@@ -1487,7 +1487,7 @@ static int search_leftmost_tree_block(struct btrfs_fs_info *fs_info,
 		struct extent_buffer *eb;
 
 		path->slots[i] = 0;
-		eb = read_node_slot(fs_info, path->nodes[i], 0);
+		eb = btrfs_read_node_slot(path->nodes[i], 0);
 		if (!extent_buffer_uptodate(eb)) {
 			ret = -EIO;
 			goto out;
-- 
2.40.0

