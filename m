Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4274C6C4796
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Mar 2023 11:27:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229584AbjCVK1t (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 22 Mar 2023 06:27:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230250AbjCVK1q (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 22 Mar 2023 06:27:46 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1013C60D79
        for <linux-btrfs@vger.kernel.org>; Wed, 22 Mar 2023 03:27:27 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id AEC7A339D1
        for <linux-btrfs@vger.kernel.org>; Wed, 22 Mar 2023 10:27:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1679480844; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/noLLDzrdavLtuxhp0zUTXzlla/ToHF7gjE3X2Koyfg=;
        b=AI84Nelvn93VANZ65p/Bw0sJrJIBvRFcZ4VVASJ+wIwdvZduJfTTFWiIx0SqOkEKRWXbIW
        I14CoLQZIH8jFTxWeZtgJVMyfFFQhK4ptW8hhVytR86zE52ozDkkLLR6gT6lXQ4TuL1qmd
        OtEz2YHnlRN4jimHBUPob/tJvcY3o+0=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1115C138E9
        for <linux-btrfs@vger.kernel.org>; Wed, 22 Mar 2023 10:27:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id iHMvNAvYGmRyEgAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Wed, 22 Mar 2023 10:27:23 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 1/2] btrfs-progs: make check/clear-cache.c to be separate from check/main.c
Date:   Wed, 22 Mar 2023 18:27:04 +0800
Message-Id: <0230b3efffd148db3e1850ad085dc9ae65dbbea8.1679480445.git.wqu@suse.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1679480445.git.wqu@suse.com>
References: <cover.1679480445.git.wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Currently check/clear-cache.c still uses a lot of global variables like
gfs_info and g_task_ctx, which are only implemented in check/main.c.

Since we have separated clear-cache code into its own c and header files,
we should not utilize those global variables.

This provides the basis for later clear cache usage out of check realm.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 check/clear-cache.c | 84 ++++++++++++++++++++++++---------------------
 check/clear-cache.h |  8 +++--
 check/main.c        |  6 ++--
 3 files changed, 52 insertions(+), 46 deletions(-)

diff --git a/check/clear-cache.c b/check/clear-cache.c
index 0a3001a4a6aa..772d920fd397 100644
--- a/check/clear-cache.c
+++ b/check/clear-cache.c
@@ -35,7 +35,7 @@
  */
 #define NR_BLOCK_GROUP_CLUSTER		(16)
 
-static int clear_free_space_cache(void)
+static int clear_free_space_cache(struct btrfs_fs_info *fs_info)
 {
 	struct btrfs_trans_handle *trans;
 	struct btrfs_block_group *bg_cache;
@@ -43,7 +43,7 @@ static int clear_free_space_cache(void)
 	u64 current = 0;
 	int ret = 0;
 
-	trans = btrfs_start_transaction(gfs_info->tree_root, 0);
+	trans = btrfs_start_transaction(fs_info->tree_root, 0);
 	if (IS_ERR(trans)) {
 		ret = PTR_ERR(trans);
 		errno = -ret;
@@ -53,7 +53,7 @@ static int clear_free_space_cache(void)
 
 	/* Clear all free space cache inodes and its extent data */
 	while (1) {
-		bg_cache = btrfs_lookup_first_block_group(gfs_info, current);
+		bg_cache = btrfs_lookup_first_block_group(fs_info, current);
 		if (!bg_cache)
 			break;
 		ret = btrfs_clear_free_space_cache(trans, bg_cache);
@@ -64,13 +64,13 @@ static int clear_free_space_cache(void)
 		nr_handled++;
 
 		if (nr_handled == NR_BLOCK_GROUP_CLUSTER) {
-			ret = btrfs_commit_transaction(trans, gfs_info->tree_root);
+			ret = btrfs_commit_transaction(trans, fs_info->tree_root);
 			if (ret < 0) {
 				errno = -ret;
 				error_msg(ERROR_MSG_START_TRANS, "%m");
 				return ret;
 			}
-			trans = btrfs_start_transaction(gfs_info->tree_root, 0);
+			trans = btrfs_start_transaction(fs_info->tree_root, 0);
 			if (IS_ERR(trans)) {
 				ret = PTR_ERR(trans);
 				errno = -ret;
@@ -81,8 +81,8 @@ static int clear_free_space_cache(void)
 		current = bg_cache->start + bg_cache->length;
 	}
 
-	btrfs_set_super_cache_generation(gfs_info->super_copy, (u64)-1);
-	ret = btrfs_commit_transaction(trans, gfs_info->tree_root);
+	btrfs_set_super_cache_generation(fs_info->super_copy, (u64)-1);
+	ret = btrfs_commit_transaction(trans, fs_info->tree_root);
 	if (ret < 0) {
 		errno = -ret;
 		error_msg(ERROR_MSG_START_TRANS, "%m");
@@ -90,16 +90,17 @@ static int clear_free_space_cache(void)
 	return ret;
 }
 
-int do_clear_free_space_cache(int clear_version)
+int do_clear_free_space_cache(struct btrfs_fs_info *fs_info,
+			      int clear_version)
 {
 	int ret = 0;
 
 	if (clear_version == 1) {
-		if (btrfs_fs_compat_ro(gfs_info, FREE_SPACE_TREE))
+		if (btrfs_fs_compat_ro(fs_info, FREE_SPACE_TREE))
 			warning(
 "free space cache v2 detected, use --clear-space-cache v2, proceeding with clearing v1");
 
-		ret = clear_free_space_cache();
+		ret = clear_free_space_cache(fs_info);
 		if (ret) {
 			error("failed to clear free space cache");
 			ret = 1;
@@ -107,13 +108,13 @@ int do_clear_free_space_cache(int clear_version)
 			printf("Free space cache cleared\n");
 		}
 	} else if (clear_version == 2) {
-		if (!btrfs_fs_compat_ro(gfs_info, FREE_SPACE_TREE)) {
+		if (!btrfs_fs_compat_ro(fs_info, FREE_SPACE_TREE)) {
 			printf("no free space cache v2 to clear\n");
 			ret = 0;
 			goto close_out;
 		}
 		printf("Clear free space cache v2\n");
-		ret = btrfs_clear_free_space_tree(gfs_info);
+		ret = btrfs_clear_free_space_tree(fs_info);
 		if (ret) {
 			error("failed to clear free space cache v2: %d", ret);
 			ret = 1;
@@ -127,6 +128,7 @@ close_out:
 
 static int check_free_space_tree(struct btrfs_root *root)
 {
+	struct btrfs_fs_info *fs_info = root->fs_info;
 	struct btrfs_key key = { 0 };
 	struct btrfs_path path;
 	int ret = 0;
@@ -158,7 +160,7 @@ static int check_free_space_tree(struct btrfs_root *root)
 			goto out;
 		}
 
-		bg = btrfs_lookup_first_block_group(gfs_info, key.objectid);
+		bg = btrfs_lookup_first_block_group(fs_info, key.objectid);
 		if (!bg) {
 			fprintf(stderr,
 		"We have a space info key for a block group that doesn't exist\n");
@@ -187,7 +189,7 @@ static int check_free_space_trees(struct btrfs_root *root)
 	};
 	int ret = 0;
 
-	free_space_root = btrfs_global_root(gfs_info, &key);
+	free_space_root = btrfs_global_root(root->fs_info, &key);
 	while (1) {
 		ret = check_free_space_tree(free_space_root);
 		if (ret)
@@ -214,7 +216,7 @@ static int check_cache_range(struct btrfs_root *root,
 
 	for (i = 0; i < BTRFS_SUPER_MIRROR_MAX; i++) {
 		bytenr = btrfs_sb_offset(i);
-		ret = btrfs_rmap_block(gfs_info,
+		ret = btrfs_rmap_block(root->fs_info,
 				       cache->start, bytenr,
 				       &logical, &nr, &stripe_len);
 		if (ret)
@@ -340,8 +342,9 @@ static int verify_space_cache(struct btrfs_root *root,
 	return ret;
 }
 
-static int check_space_cache(struct btrfs_root *root)
+static int check_space_cache(struct btrfs_root *root, struct task_ctx *task_ctx)
 {
+	struct btrfs_fs_info *fs_info = root->fs_info;
 	struct extent_io_tree used;
 	struct btrfs_block_group *cache;
 	u64 start = BTRFS_SUPER_INFO_OFFSET + BTRFS_SUPER_INFO_SIZE;
@@ -349,20 +352,20 @@ static int check_space_cache(struct btrfs_root *root)
 	int error = 0;
 
 	extent_io_tree_init(&used);
-	ret = btrfs_mark_used_blocks(gfs_info, &used);
+	ret = btrfs_mark_used_blocks(fs_info, &used);
 	if (ret)
 		return ret;
 
 	while (1) {
-		g_task_ctx.item_count++;
-		cache = btrfs_lookup_first_block_group(gfs_info, start);
+		task_ctx->item_count++;
+		cache = btrfs_lookup_first_block_group(fs_info, start);
 		if (!cache)
 			break;
 
 		start = cache->start + cache->length;
 		if (!cache->free_space_ctl) {
 			if (btrfs_init_free_space_ctl(cache,
-						gfs_info->sectorsize)) {
+						fs_info->sectorsize)) {
 				ret = -ENOMEM;
 				break;
 			}
@@ -370,8 +373,8 @@ static int check_space_cache(struct btrfs_root *root)
 			btrfs_remove_free_space_cache(cache);
 		}
 
-		if (btrfs_fs_compat_ro(gfs_info, FREE_SPACE_TREE)) {
-			ret = exclude_super_stripes(gfs_info, cache);
+		if (btrfs_fs_compat_ro(fs_info, FREE_SPACE_TREE)) {
+			ret = exclude_super_stripes(fs_info, cache);
 			if (ret) {
 				errno = -ret;
 				fprintf(stderr,
@@ -379,8 +382,8 @@ static int check_space_cache(struct btrfs_root *root)
 				error++;
 				continue;
 			}
-			ret = load_free_space_tree(gfs_info, cache);
-			free_excluded_extents(gfs_info, cache);
+			ret = load_free_space_tree(fs_info, cache);
+			free_excluded_extents(fs_info, cache);
 			if (ret < 0) {
 				errno = -ret;
 				fprintf(stderr,
@@ -390,7 +393,7 @@ static int check_space_cache(struct btrfs_root *root)
 			}
 			error += ret;
 		} else {
-			ret = load_free_space_cache(gfs_info, cache);
+			ret = load_free_space_cache(fs_info, cache);
 			if (ret < 0)
 				error++;
 			if (ret <= 0)
@@ -409,33 +412,34 @@ static int check_space_cache(struct btrfs_root *root)
 }
 
 
-int validate_free_space_cache(struct btrfs_root *root)
+int validate_free_space_cache(struct btrfs_root *root, struct task_ctx *task_ctx)
 {
+	struct btrfs_fs_info *fs_info = root->fs_info;
 	int ret;
 
 	/*
 	 * If cache generation is between 0 and -1ULL, sb generation must be
 	 * equal to sb cache generation or the v1 space caches are outdated.
 	 */
-	if (btrfs_super_cache_generation(gfs_info->super_copy) != -1ULL &&
-	    btrfs_super_cache_generation(gfs_info->super_copy) != 0 &&
-	    btrfs_super_generation(gfs_info->super_copy) !=
-	    btrfs_super_cache_generation(gfs_info->super_copy)) {
+	if (btrfs_super_cache_generation(fs_info->super_copy) != -1ULL &&
+	    btrfs_super_cache_generation(fs_info->super_copy) != 0 &&
+	    btrfs_super_generation(fs_info->super_copy) !=
+	    btrfs_super_cache_generation(fs_info->super_copy)) {
 		printf(
 "cache and super generation don't match, space cache will be invalidated\n");
 		return 0;
 	}
 
-	ret = check_space_cache(root);
-	if (!ret && btrfs_fs_compat_ro(gfs_info, FREE_SPACE_TREE))
+	ret = check_space_cache(root, task_ctx);
+	if (!ret && btrfs_fs_compat_ro(fs_info, FREE_SPACE_TREE))
 		ret = check_free_space_trees(root);
-	if (ret && btrfs_fs_compat_ro(gfs_info, FREE_SPACE_TREE) &&
+	if (ret && btrfs_fs_compat_ro(fs_info, FREE_SPACE_TREE) &&
 	    opt_check_repair) {
-		ret = do_clear_free_space_cache(2);
+		ret = do_clear_free_space_cache(fs_info, 2);
 		if (ret)
 			goto out;
 
-		ret = btrfs_create_free_space_tree(gfs_info);
+		ret = btrfs_create_free_space_tree(fs_info);
 		if (ret)
 			error("couldn't repair freespace tree");
 	}
@@ -539,7 +543,7 @@ out:
 	return ret;
 }
 
-int clear_ino_cache_items(void)
+int clear_ino_cache_items(struct btrfs_fs_info *fs_info)
 {
 	int ret;
 	struct btrfs_path path;
@@ -550,7 +554,7 @@ int clear_ino_cache_items(void)
 	key.offset = 0;
 
 	btrfs_init_path(&path);
-	ret = btrfs_search_slot(NULL, gfs_info->tree_root, &key, &path,	0, 0);
+	ret = btrfs_search_slot(NULL, fs_info->tree_root, &key, &path,	0, 0);
 	if (ret < 0)
 		return ret;
 
@@ -563,7 +567,7 @@ int clear_ino_cache_items(void)
 			struct btrfs_root *root;
 
 			found_key.offset = (u64)-1;
-			root = btrfs_read_fs_root(gfs_info, &found_key);
+			root = btrfs_read_fs_root(fs_info, &found_key);
 			if (IS_ERR(root))
 				goto next;
 			ret = truncate_free_ino_items(root);
@@ -586,12 +590,12 @@ next:
 		if (key.objectid == BTRFS_FS_TREE_OBJECTID) {
 			key.objectid = BTRFS_FIRST_FREE_OBJECTID;
 			btrfs_release_path(&path);
-			ret = btrfs_search_slot(NULL, gfs_info->tree_root, &key,
+			ret = btrfs_search_slot(NULL, fs_info->tree_root, &key,
 						&path,	0, 0);
 			if (ret < 0)
 				return ret;
 		} else {
-			ret = btrfs_next_item(gfs_info->tree_root, &path);
+			ret = btrfs_next_item(fs_info->tree_root, &path);
 			if (ret < 0) {
 				goto out;
 			} else if (ret > 0) {
diff --git a/check/clear-cache.h b/check/clear-cache.h
index b8b71a89df93..78845e8d9557 100644
--- a/check/clear-cache.h
+++ b/check/clear-cache.h
@@ -17,11 +17,13 @@
 #ifndef __BTRFS_CHECK_CLEAR_CACHE_H__
 #define __BTRFS_CHECK_CLEAR_CACHE_H__
 
+struct btrfs_fs_info;
 struct btrfs_root;
+struct task_ctx;
 
-int do_clear_free_space_cache(int clear_version);
-int validate_free_space_cache(struct btrfs_root *root);
+int do_clear_free_space_cache(struct btrfs_fs_info *fs_info, int clear_version);
+int validate_free_space_cache(struct btrfs_root *root, struct task_ctx *task_ctx);
 int truncate_free_ino_items(struct btrfs_root *root);
-int clear_ino_cache_items(void);
+int clear_ino_cache_items(struct btrfs_fs_info *fs_info);
 
 #endif
diff --git a/check/main.c b/check/main.c
index 9a7f40e7d7fe..74ebd3b240d4 100644
--- a/check/main.c
+++ b/check/main.c
@@ -10234,13 +10234,13 @@ static int cmd_check(const struct cmd_struct *cmd, int argc, char **argv)
 	}
 
 	if (clear_space_cache) {
-		ret = do_clear_free_space_cache(clear_space_cache);
+		ret = do_clear_free_space_cache(gfs_info, clear_space_cache);
 		err |= !!ret;
 		goto close_out;
 	}
 
 	if (clear_ino_cache) {
-		ret = clear_ino_cache_items();
+		ret = clear_ino_cache_items(gfs_info);
 		err = ret;
 		goto close_out;
 	}
@@ -10406,7 +10406,7 @@ static int cmd_check(const struct cmd_struct *cmd, int argc, char **argv)
 		task_start(g_task_ctx.info, &g_task_ctx.start_time, &g_task_ctx.item_count);
 	}
 
-	ret = validate_free_space_cache(root);
+	ret = validate_free_space_cache(root, &g_task_ctx);
 	task_stop(g_task_ctx.info);
 	err |= !!ret;
 
-- 
2.39.2

