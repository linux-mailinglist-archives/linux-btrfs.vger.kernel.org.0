Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 564226E8336
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Apr 2023 23:14:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231411AbjDSVOl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 19 Apr 2023 17:14:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229991AbjDSVOP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 19 Apr 2023 17:14:15 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C16E9011
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Apr 2023 14:14:13 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id fg9so671406qtb.1
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Apr 2023 14:14:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20221208.gappssmtp.com; s=20221208; t=1681938852; x=1684530852;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YbfPxKg4s1QAD9wvrakSLQozJGyxPWm1Hoqc+IIgfvA=;
        b=fY6FY4kFAUnA4EpIBHOAD5LmyDS1KdjhuR3zhY4A2aXy0l0y7DIvAgm8WkXr/hT8KY
         MexUHhb65OIhJw4RXIg91wo7pMxvzT71diHSy88kVTuvTMF40UNtSRn3O55veOD0brB0
         PIghBrDh7cjKKHXr/mjO8NSqNii7yCg7Z4qT3fstjmYz/mA35NtXbNau1BuQKqQl9g2J
         kVoCKLgQlFSGa+6ViieoCTmLFO0b2jOmGp5kqXQ6KAuBkEvrMojaFk4wkiK/jphe2OGg
         2gqMcpbdW6uRJprx09HDmTZL0Zf0gP3D1jREGbt8QysSouQQilYxI4QiniOT0yVUv5Qs
         P91g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681938852; x=1684530852;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YbfPxKg4s1QAD9wvrakSLQozJGyxPWm1Hoqc+IIgfvA=;
        b=LfjGm18kXP1EE57AcOSEYoBn3OTRlKgENEU1n6fRn+CQbxX4AO/9+FeD7raRxlUHj2
         3chfJVXOBuh3Ez0zpRblmn6yKiAFnlg52juk8s/ghvtD5DW4y2GBur9XZ9f8/OlLhNkR
         e82o421MQWIeJjc7GnokSfPcw1D0soGC7vEbLsq2bEjZxcAF3FyGCf++3XIT4Ph0mPAb
         R9S4TYaXWI/XzbeqYwgj5piZ1g6QpiXImvlD/RXVAJ58xjmmR6PuP6Fg8VaCE9hu6rq/
         NbMAA/a7P1xDc8dw+WHvE47s9aiWsJg3Ks4ENGP+tglIg3ivqufQ+JktqelHqT7OG4Iy
         miaQ==
X-Gm-Message-State: AAQBX9clfgQe5syitWgXUnSeRislso2VGuqTjAo6lB9sg69X2XuLGiXf
        stR2qB/n46EN3tQXi3mhLUqO6eXcUTUg+cZ/9Uo9fg==
X-Google-Smtp-Source: AKy350YiqrRh8DqPPWVPw6VQQ+PxtwID4r4vhzpnkaMtpCmeRkY7Gq6uYcfCuHtbiKOTA6296itCpg==
X-Received: by 2002:a05:622a:1ba4:b0:3ef:2d98:ecdf with SMTP id bp36-20020a05622a1ba400b003ef2d98ecdfmr8264250qtb.55.1681938851986;
        Wed, 19 Apr 2023 14:14:11 -0700 (PDT)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id ea19-20020a05620a489300b0074ad0812747sm1387620qkb.77.2023.04.19.14.14.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Apr 2023 14:14:11 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 09/11] btrfs-progs: remove fs_info argument from btrfs_check_* helpers
Date:   Wed, 19 Apr 2023 17:13:51 -0400
Message-Id: <76907ec19d13a8bd8bb3ab860b5e7f1450716170.1681938648.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <cover.1681938648.git.josef@toxicpanda.com>
References: <cover.1681938648.git.josef@toxicpanda.com>
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

This can be pulled out of the extent buffer that is passed in, drop the
fs_info argument from the function.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 check/main.c            | 12 ++++++------
 check/mode-lowmem.c     | 10 +++++-----
 kernel-shared/ctree.c   | 12 ++++++------
 kernel-shared/ctree.h   |  6 ++----
 kernel-shared/disk-io.c |  4 ++--
 5 files changed, 21 insertions(+), 23 deletions(-)

diff --git a/check/main.c b/check/main.c
index 1a9ad50c..8c3a10a1 100644
--- a/check/main.c
+++ b/check/main.c
@@ -1921,9 +1921,9 @@ static int walk_down_tree(struct btrfs_root *root, struct btrfs_path *path,
 		}
 
 		if (btrfs_is_leaf(next))
-			status = btrfs_check_leaf(gfs_info, NULL, next);
+			status = btrfs_check_leaf(NULL, next);
 		else
-			status = btrfs_check_node(gfs_info, NULL, next);
+			status = btrfs_check_node(NULL, next);
 		if (status != BTRFS_TREE_BLOCK_CLEAN) {
 			free_extent_buffer(next);
 			err = -EIO;
@@ -3702,9 +3702,9 @@ static int check_fs_root(struct btrfs_root *root,
 
 	/* We may not have checked the root block, lets do that now */
 	if (btrfs_is_leaf(root->node))
-		status = btrfs_check_leaf(gfs_info, NULL, root->node);
+		status = btrfs_check_leaf(NULL, root->node);
 	else
-		status = btrfs_check_node(gfs_info, NULL, root->node);
+		status = btrfs_check_node(NULL, root->node);
 	if (status != BTRFS_TREE_BLOCK_CLEAN)
 		return -EIO;
 
@@ -4608,9 +4608,9 @@ static int check_block(struct btrfs_root *root,
 	rec->info_level = level;
 
 	if (btrfs_is_leaf(buf))
-		status = btrfs_check_leaf(gfs_info, &rec->parent_key, buf);
+		status = btrfs_check_leaf(&rec->parent_key, buf);
 	else
-		status = btrfs_check_node(gfs_info, &rec->parent_key, buf);
+		status = btrfs_check_node(&rec->parent_key, buf);
 
 	if (status != BTRFS_TREE_BLOCK_CLEAN) {
 		if (opt_check_repair)
diff --git a/check/mode-lowmem.c b/check/mode-lowmem.c
index f0e5f8d6..1672da26 100644
--- a/check/mode-lowmem.c
+++ b/check/mode-lowmem.c
@@ -2695,7 +2695,7 @@ static int check_inode_item(struct btrfs_root *root, struct btrfs_path *path)
 		 * we need to bail otherwise we could end up stuck.
 		 */
 		if (path->slots[0] == 0 &&
-		    btrfs_check_leaf(gfs_info, NULL, path->nodes[0]))
+		    btrfs_check_leaf(NULL, path->nodes[0]))
 			ret = -EIO;
 
 		if (ret < 0) {
@@ -5001,7 +5001,7 @@ static int walk_down_tree(struct btrfs_root *root, struct btrfs_path *path,
 		if (*level == 0) {
 			/* skip duplicate check */
 			if (check || !check_all) {
-				ret = btrfs_check_leaf(gfs_info, NULL, cur);
+				ret = btrfs_check_leaf(NULL, cur);
 				if (ret != BTRFS_TREE_BLOCK_CLEAN) {
 					err |= -EIO;
 					break;
@@ -5018,7 +5018,7 @@ static int walk_down_tree(struct btrfs_root *root, struct btrfs_path *path,
 			break;
 		}
 		if (check || !check_all) {
-			ret = btrfs_check_node(gfs_info, NULL, cur);
+			ret = btrfs_check_node(NULL, cur);
 			if (ret != BTRFS_TREE_BLOCK_CLEAN) {
 				err |= -EIO;
 				break;
@@ -5066,9 +5066,9 @@ static int walk_down_tree(struct btrfs_root *root, struct btrfs_path *path,
 			break;
 
 		if (btrfs_is_leaf(next))
-			status = btrfs_check_leaf(gfs_info, NULL, next);
+			status = btrfs_check_leaf(NULL, next);
 		else
-			status = btrfs_check_node(gfs_info, NULL, next);
+			status = btrfs_check_node(NULL, next);
 		if (status != BTRFS_TREE_BLOCK_CLEAN) {
 			free_extent_buffer(next);
 			err |= -EIO;
diff --git a/kernel-shared/ctree.c b/kernel-shared/ctree.c
index 7d1b1316..fb56a863 100644
--- a/kernel-shared/ctree.c
+++ b/kernel-shared/ctree.c
@@ -612,9 +612,9 @@ static void generic_err(const struct extent_buffer *buf, int slot,
 }
 
 enum btrfs_tree_block_status
-btrfs_check_node(struct btrfs_fs_info *fs_info,
-		 struct btrfs_key *parent_key, struct extent_buffer *node)
+btrfs_check_node(struct btrfs_key *parent_key, struct extent_buffer *node)
 {
+	struct btrfs_fs_info *fs_info = node->fs_info;
 	unsigned long nr = btrfs_header_nritems(node);
 	struct btrfs_key key, next_key;
 	int slot;
@@ -683,9 +683,9 @@ fail:
 }
 
 enum btrfs_tree_block_status
-btrfs_check_leaf(struct btrfs_fs_info *fs_info,
-		 struct btrfs_key *parent_key, struct extent_buffer *leaf)
+btrfs_check_leaf(struct btrfs_key *parent_key, struct extent_buffer *leaf)
 {
+	struct btrfs_fs_info *fs_info = leaf->fs_info;
 	/* No valid key type is 0, so all key should be larger than this key */
 	struct btrfs_key prev_key = {0, 0, 0};
 	struct btrfs_key key;
@@ -811,9 +811,9 @@ static int noinline check_block(struct btrfs_fs_info *fs_info,
 		parent_key_ptr = &key;
 	}
 	if (level == 0)
-		ret = btrfs_check_leaf(fs_info, parent_key_ptr, path->nodes[0]);
+		ret = btrfs_check_leaf(parent_key_ptr, path->nodes[0]);
 	else
-		ret = btrfs_check_node(fs_info, parent_key_ptr, path->nodes[level]);
+		ret = btrfs_check_node(parent_key_ptr, path->nodes[level]);
 	if (ret == BTRFS_TREE_BLOCK_CLEAN)
 		return 0;
 	return -EIO;
diff --git a/kernel-shared/ctree.h b/kernel-shared/ctree.h
index df7526d4..13264387 100644
--- a/kernel-shared/ctree.h
+++ b/kernel-shared/ctree.h
@@ -2705,11 +2705,9 @@ int btrfs_comp_cpu_keys(const struct btrfs_key *k1, const struct btrfs_key *k2);
 int btrfs_del_ptr(struct btrfs_root *root, struct btrfs_path *path,
 		int level, int slot);
 enum btrfs_tree_block_status
-btrfs_check_node(struct btrfs_fs_info *fs_info,
-		 struct btrfs_key *parent_key, struct extent_buffer *buf);
+btrfs_check_node(struct btrfs_key *parent_key, struct extent_buffer *buf);
 enum btrfs_tree_block_status
-btrfs_check_leaf(struct btrfs_fs_info *fs_info,
-		 struct btrfs_key *parent_key, struct extent_buffer *buf);
+btrfs_check_leaf(struct btrfs_key *parent_key, struct extent_buffer *buf);
 void reada_for_search(struct btrfs_fs_info *fs_info, struct btrfs_path *path,
 		      int level, int slot, u64 objectid);
 struct extent_buffer *read_node_slot(struct btrfs_fs_info *fs_info,
diff --git a/kernel-shared/disk-io.c b/kernel-shared/disk-io.c
index 3d2574d9..b5ad89c2 100644
--- a/kernel-shared/disk-io.c
+++ b/kernel-shared/disk-io.c
@@ -389,9 +389,9 @@ struct extent_buffer* read_tree_block(struct btrfs_fs_info *fs_info, u64 bytenr,
 			 * btrfs ins dump-tree.
 			 */
 			if (btrfs_header_level(eb))
-				ret = btrfs_check_node(fs_info, NULL, eb);
+				ret = btrfs_check_node(NULL, eb);
 			else
-				ret = btrfs_check_leaf(fs_info, NULL, eb);
+				ret = btrfs_check_leaf(NULL, eb);
 			if (!ret || candidate_mirror == mirror_num) {
 				btrfs_set_buffer_uptodate(eb);
 				return eb;
-- 
2.39.1

