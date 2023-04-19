Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99AA26E833A
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Apr 2023 23:14:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231508AbjDSVOo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 19 Apr 2023 17:14:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231627AbjDSVOW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 19 Apr 2023 17:14:22 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 411247A81
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Apr 2023 14:14:15 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id ay32so51054qtb.0
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Apr 2023 14:14:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20221208.gappssmtp.com; s=20221208; t=1681938854; x=1684530854;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j/qID2aK7guLS3RQBbBN2oiEtayDypekSvW8QS8Mam0=;
        b=sGgvGHu95egDROVS9xHTSZaL/H54pNg20489r3S2JyYkUzrE1cIX1EOCmzTctLalL1
         82Jya8lC0BEf/iunr2dhCct4v5bq+QwW4y+z/05+DTN+toSffWm1KO1fmCuKN7TGbQO0
         5qKq7D00Vin8HLhCRSQE9Jbzom3Nsx9Op4Puyr6l34EqG1veMjvJUxa8GqY67YQ/Qbt9
         ZKjiXtNJd11RQ2WWQO51NEYlpHwV/aLsNJX/T4m6IGgZVXcoLUa4Nn2xchcGpt9hF7oG
         so7u8wcabRV30MdKZOvset5q/e/KKLWIw8Wt7r+Sjr6cK5GJIW9ExGNSP0KtYd0ph6u/
         Jj5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681938854; x=1684530854;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j/qID2aK7guLS3RQBbBN2oiEtayDypekSvW8QS8Mam0=;
        b=fPqGmMS7PMd8aB/OYZr/5Fkz7VspkeNAS8rzqg2LT5Vt6elW3w4yHG0opsnGT886m4
         DnHMMedinF1ZepN9WhM2Rtl6xCpxRAA7KJ9xrucH1czN2YHyElYLw1sSadKNn/if1EvR
         ALWi3ZMBz6qjlm118Hntn5wv+SX8zXnhr4UQlc6pni3TCv2Df2aFvBnPpi+Bo17WJFdV
         ZF/RZYGTvHDqtYwgXuioJ5qTt4LQqwVzQI/RuqJXO+zFbxPlIiiGN/Wo6UU1ow7bhFOc
         55PMDelvT1FH6hmm4ybQb9emyurU09Pg9f3Vmxy0QDu54QSiVS9gKj2onf5xLPg6PtAC
         RJYA==
X-Gm-Message-State: AAQBX9fufmidzRuPYCRUQ9CWMLWta1LSo1ntzWwMwV/oHbJfQtDp5M2N
        InQb1Tp+brVyNFR0Ax5T1MpIZb2hznPPMmsi0RgQKA==
X-Google-Smtp-Source: AKy350ZGCIPdUUbnsz9gPR/4Ay+9aTlgTXablpATguNCHt7ZP1tsUHuEXpZNXDVm9maT98xPK3cyWw==
X-Received: by 2002:ac8:58d5:0:b0:3ed:4a17:8b04 with SMTP id u21-20020ac858d5000000b003ed4a178b04mr7616595qta.68.1681938854367;
        Wed, 19 Apr 2023 14:14:14 -0700 (PDT)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id u18-20020a05622a14d200b003eda962ed24sm39190qtx.22.2023.04.19.14.14.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Apr 2023 14:14:14 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 10/11] btrfs-progs: add a btrfs check helper for checking blocks
Date:   Wed, 19 Apr 2023 17:13:52 -0400
Message-Id: <4f7342dabcc239185623abebdac57a30d0db259e.1681938648.git.josef@toxicpanda.com>
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

btrfs check wants to be able to record corrupted extents if it finds any
bad blocks.  This has been done directly inside of the
btrfs_check_leaf/btrfs_check_node helpers, but these are going to be
sync'ed from the kernel in the future.  Add another helper and move the
corrupt block handling into this helper and keep it inside of the check
code.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 check/main.c          | 16 +++-------------
 check/mode-lowmem.c   | 11 ++++-------
 check/repair.c        | 29 +++++++++++++++++++++++++++++
 check/repair.h        |  3 ++-
 kernel-shared/ctree.c | 22 ++--------------------
 5 files changed, 40 insertions(+), 41 deletions(-)

diff --git a/check/main.c b/check/main.c
index 8c3a10a1..467c8a57 100644
--- a/check/main.c
+++ b/check/main.c
@@ -1920,10 +1920,7 @@ static int walk_down_tree(struct btrfs_root *root, struct btrfs_path *path,
 			goto out;
 		}
 
-		if (btrfs_is_leaf(next))
-			status = btrfs_check_leaf(NULL, next);
-		else
-			status = btrfs_check_node(NULL, next);
+		status = btrfs_check_block_for_repair(next, NULL);
 		if (status != BTRFS_TREE_BLOCK_CLEAN) {
 			free_extent_buffer(next);
 			err = -EIO;
@@ -3701,10 +3698,7 @@ static int check_fs_root(struct btrfs_root *root,
 	wc->root_level = level;
 
 	/* We may not have checked the root block, lets do that now */
-	if (btrfs_is_leaf(root->node))
-		status = btrfs_check_leaf(NULL, root->node);
-	else
-		status = btrfs_check_node(NULL, root->node);
+	status = btrfs_check_block_for_repair(root->node, NULL);
 	if (status != BTRFS_TREE_BLOCK_CLEAN)
 		return -EIO;
 
@@ -4607,11 +4601,7 @@ static int check_block(struct btrfs_root *root,
 	}
 	rec->info_level = level;
 
-	if (btrfs_is_leaf(buf))
-		status = btrfs_check_leaf(&rec->parent_key, buf);
-	else
-		status = btrfs_check_node(&rec->parent_key, buf);
-
+	status = btrfs_check_block_for_repair(buf, &rec->parent_key);
 	if (status != BTRFS_TREE_BLOCK_CLEAN) {
 		if (opt_check_repair)
 			status = try_to_fix_bad_block(root, buf, status);
diff --git a/check/mode-lowmem.c b/check/mode-lowmem.c
index 1672da26..3cf8d97f 100644
--- a/check/mode-lowmem.c
+++ b/check/mode-lowmem.c
@@ -2695,7 +2695,7 @@ static int check_inode_item(struct btrfs_root *root, struct btrfs_path *path)
 		 * we need to bail otherwise we could end up stuck.
 		 */
 		if (path->slots[0] == 0 &&
-		    btrfs_check_leaf(NULL, path->nodes[0]))
+		    btrfs_check_block_for_repair(path->nodes[0], NULL))
 			ret = -EIO;
 
 		if (ret < 0) {
@@ -5001,7 +5001,7 @@ static int walk_down_tree(struct btrfs_root *root, struct btrfs_path *path,
 		if (*level == 0) {
 			/* skip duplicate check */
 			if (check || !check_all) {
-				ret = btrfs_check_leaf(NULL, cur);
+				ret = btrfs_check_block_for_repair(cur, NULL);
 				if (ret != BTRFS_TREE_BLOCK_CLEAN) {
 					err |= -EIO;
 					break;
@@ -5018,7 +5018,7 @@ static int walk_down_tree(struct btrfs_root *root, struct btrfs_path *path,
 			break;
 		}
 		if (check || !check_all) {
-			ret = btrfs_check_node(NULL, cur);
+			ret = btrfs_check_block_for_repair(cur, NULL);
 			if (ret != BTRFS_TREE_BLOCK_CLEAN) {
 				err |= -EIO;
 				break;
@@ -5065,10 +5065,7 @@ static int walk_down_tree(struct btrfs_root *root, struct btrfs_path *path,
 		if (ret < 0)
 			break;
 
-		if (btrfs_is_leaf(next))
-			status = btrfs_check_leaf(NULL, next);
-		else
-			status = btrfs_check_node(NULL, next);
+		status = btrfs_check_block_for_repair(next, NULL);
 		if (status != BTRFS_TREE_BLOCK_CLEAN) {
 			free_extent_buffer(next);
 			err |= -EIO;
diff --git a/check/repair.c b/check/repair.c
index f84df9cf..71b2a277 100644
--- a/check/repair.c
+++ b/check/repair.c
@@ -299,3 +299,32 @@ out:
 	extent_io_tree_cleanup(&used);
 	return ret;
 }
+
+enum btrfs_tree_block_status btrfs_check_block_for_repair(struct extent_buffer *eb,
+							  struct btrfs_key *first_key)
+{
+	struct btrfs_fs_info *fs_info = eb->fs_info;
+	enum btrfs_tree_block_status status;
+
+	if (btrfs_is_leaf(eb))
+		status = btrfs_check_leaf(first_key, eb);
+	else
+		status = btrfs_check_node(first_key, eb);
+
+	if (status == BTRFS_TREE_BLOCK_CLEAN)
+		return status;
+
+	if (btrfs_header_owner(eb) == BTRFS_EXTENT_TREE_OBJECTID) {
+		struct btrfs_key key;
+
+		if (first_key)
+			memcpy(&key, first_key, sizeof(struct btrfs_key));
+		else
+			btrfs_node_key_to_cpu(eb, &key, 0);
+		btrfs_add_corrupt_extent_record(fs_info, &key,
+						eb->start, eb->len,
+						btrfs_header_level(eb));
+	}
+	return status;
+
+}
diff --git a/check/repair.h b/check/repair.h
index 3e6ffcf6..d4222600 100644
--- a/check/repair.h
+++ b/check/repair.h
@@ -43,5 +43,6 @@ int btrfs_mark_used_tree_blocks(struct btrfs_fs_info *fs_info,
 				struct extent_io_tree *tree);
 int btrfs_mark_used_blocks(struct btrfs_fs_info *fs_info,
 			   struct extent_io_tree *tree);
-
+enum btrfs_tree_block_status btrfs_check_block_for_repair(struct extent_buffer *eb,
+							  struct btrfs_key *first_key);
 #endif
diff --git a/kernel-shared/ctree.c b/kernel-shared/ctree.c
index fb56a863..c1c2059b 100644
--- a/kernel-shared/ctree.c
+++ b/kernel-shared/ctree.c
@@ -668,17 +668,8 @@ btrfs_check_node(struct btrfs_key *parent_key, struct extent_buffer *node)
 			goto fail;
 		}
 	}
-	return BTRFS_TREE_BLOCK_CLEAN;
+	ret = BTRFS_TREE_BLOCK_CLEAN;
 fail:
-	if (btrfs_header_owner(node) == BTRFS_EXTENT_TREE_OBJECTID) {
-		if (parent_key)
-			memcpy(&key, parent_key, sizeof(struct btrfs_key));
-		else
-			btrfs_node_key_to_cpu(node, &key, 0);
-		btrfs_add_corrupt_extent_record(fs_info, &key,
-						node->start, node->len,
-						btrfs_header_level(node));
-	}
 	return ret;
 }
 
@@ -782,17 +773,8 @@ btrfs_check_leaf(struct btrfs_key *parent_key, struct extent_buffer *leaf)
 		prev_key.offset = key.offset;
 	}
 
-	return BTRFS_TREE_BLOCK_CLEAN;
+	ret = BTRFS_TREE_BLOCK_CLEAN;
 fail:
-	if (btrfs_header_owner(leaf) == BTRFS_EXTENT_TREE_OBJECTID) {
-		if (parent_key)
-			memcpy(&key, parent_key, sizeof(struct btrfs_key));
-		else
-			btrfs_item_key_to_cpu(leaf, &key, 0);
-
-		btrfs_add_corrupt_extent_record(fs_info, &key,
-						leaf->start, leaf->len, 0);
-	}
 	return ret;
 }
 
-- 
2.39.1

