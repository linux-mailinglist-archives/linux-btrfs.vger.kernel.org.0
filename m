Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C6486E83A5
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Apr 2023 23:25:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232036AbjDSVZK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 19 Apr 2023 17:25:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232563AbjDSVYy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 19 Apr 2023 17:24:54 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AA3C83C9
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Apr 2023 14:24:25 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id 6a1803df08f44-5f6058c0761so35316d6.1
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Apr 2023 14:24:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20221208.gappssmtp.com; s=20221208; t=1681939464; x=1684531464;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PWY3Qt1r6Ey9H4egsgksV4AVNvmQ7AFAyqpK0XWjEjY=;
        b=bBcCCZxFX59fhW6Yg+SCcx2EQ2IDCaU0cwIBnYSBnvti8h6qs9VpBKhD2kB+zbGIhx
         V6egiBPEuokcsnNlFrZQ5uybAk7X+jZhNYsL86oRZ5Jk0IF3V6+27LJPU20g8qYf7Zph
         3alp2F8F0584ci87POm6UWnukPSUJY1FNFKT28I7Zybx5AD4vdx/RvSV7hCtYRfZ4MUX
         0FiSyjccxOqp4pjlk8lhtb+GkE9yVa1A5UQD/4Xa8e/EGPIGZffRC1CfYs0UmwZVz89j
         Z2XW/x8VoQkgVjUGoWRhZcvSy9h/sWHlFifuBNs5rWAnUFICnBCu8vJ8DqRONDT96UvJ
         wxnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681939464; x=1684531464;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PWY3Qt1r6Ey9H4egsgksV4AVNvmQ7AFAyqpK0XWjEjY=;
        b=gmWsKXcNxDlXNeemtB88crBWVEmWFyeRx4tiSfK5uNp6+WmDSWIle28qwo/asRxNTf
         Qr6S4ApmKHF+Fok0eyQGEYAj1CHlkLmhPFVnUOeNac0I67oFYUFSvhZakyz//fItERuO
         PdVcdxJZqEfM0kxLb0uxtPz6/BR783VFRVkDd2rtGEo01qzxYQeRKz3HZQV/aWvCmr5P
         SNDRlqMTbIc/i4UYuU+fMVNjX6GspucLq3W9y3IHMnl3SY/+d2YxbmUWAYcFE/J2u4gR
         cqtpB7c8EDNCcdXdokW2V5frmG9iemvV125mnL6UADMlMymWHme9Rf2PDBH31SDelQLq
         DY3g==
X-Gm-Message-State: AAQBX9dr2PxXAgAyt8Y1rZVOZPZQySLm54SKgm8ivzVLu/j5M4L5awcg
        6++ZQ6a9ylEGvVvZI/L751veslK8tRCdFmcX0r5c7g==
X-Google-Smtp-Source: AKy350bWzBNGP1r7lN36vKrDUwQIIfyr0ipTmjnY+6xH/9fixKkpw1CW8xc4zxHRXUWm5zfBj1Q/Lg==
X-Received: by 2002:a05:6214:509d:b0:5f1:31eb:1f21 with SMTP id kk29-20020a056214509d00b005f131eb1f21mr37556qvb.5.1681939463909;
        Wed, 19 Apr 2023 14:24:23 -0700 (PDT)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id x16-20020a0ce250000000b005ef6b124d39sm12882qvl.5.2023.04.19.14.24.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Apr 2023 14:24:23 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 08/18] btrfs-progs: update read_tree_block to match the kernel definition
Date:   Wed, 19 Apr 2023 17:23:59 -0400
Message-Id: <793acf814cf36b0359df1094ad8fc71608b41b78.1681939316.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <cover.1681939316.git.josef@toxicpanda.com>
References: <cover.1681939316.git.josef@toxicpanda.com>
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

The in-kernel version of read_tree_block adds some extra sanity checks
to make sure we don't return blocks that don't match what we expect.
This includes the owning root, the level, and the expected first key.
We don't actually do these checks in btrfs-progs, however kernel code
we're going to sync will expect this calling convention, so update it to
match the in-kernel code and then update all the callers.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 btrfs-corrupt-block.c      |  8 +++++---
 btrfs-find-root.c          |  2 +-
 check/main.c               |  9 ++++++---
 check/mode-common.c        |  4 ++--
 check/mode-lowmem.c        | 12 +++++++-----
 check/qgroup-verify.c      |  3 ++-
 check/repair.c             |  8 ++++++--
 cmds/inspect-dump-tree.c   | 12 +++++++-----
 cmds/inspect-tree-stats.c  |  4 +++-
 cmds/restore.c             |  6 ++++--
 image/main.c               | 11 ++++++-----
 kernel-shared/backref.c    |  6 ++++--
 kernel-shared/ctree.c      |  4 +++-
 kernel-shared/disk-io.c    |  8 +++++---
 kernel-shared/disk-io.h    |  5 +++--
 kernel-shared/print-tree.c |  4 +++-
 tune/change-uuid.c         |  2 +-
 17 files changed, 68 insertions(+), 40 deletions(-)

diff --git a/btrfs-corrupt-block.c b/btrfs-corrupt-block.c
index 35933854..98cfe598 100644
--- a/btrfs-corrupt-block.c
+++ b/btrfs-corrupt-block.c
@@ -166,7 +166,7 @@ static int corrupt_keys_in_block(struct btrfs_fs_info *fs_info, u64 bytenr)
 {
 	struct extent_buffer *eb;
 
-	eb = read_tree_block(fs_info, bytenr, 0);
+	eb = read_tree_block(fs_info, bytenr, 0, 0, 0, NULL);
 	if (!extent_buffer_uptodate(eb))
 		return -EIO;;
 
@@ -296,7 +296,9 @@ static void btrfs_corrupt_extent_tree(struct btrfs_trans_handle *trans,
 		struct extent_buffer *next;
 
 		next = read_tree_block(fs_info, btrfs_node_blockptr(eb, i),
-				       btrfs_node_ptr_generation(eb, i));
+				       btrfs_header_owner(eb),
+				       btrfs_node_ptr_generation(eb, i),
+				       btrfs_header_level(eb) - 1, NULL);
 		if (!extent_buffer_uptodate(next))
 			continue;
 		btrfs_corrupt_extent_tree(trans, root, next);
@@ -860,7 +862,7 @@ static int corrupt_metadata_block(struct btrfs_fs_info *fs_info, u64 block,
 		return -EINVAL;
 	}
 
-	eb = read_tree_block(fs_info, block, 0);
+	eb = read_tree_block(fs_info, block, 0, 0, 0, NULL);
 	if (!extent_buffer_uptodate(eb)) {
 		error("couldn't read in tree block %s", field);
 		return -EINVAL;
diff --git a/btrfs-find-root.c b/btrfs-find-root.c
index 9d7296c3..398d7f21 100644
--- a/btrfs-find-root.c
+++ b/btrfs-find-root.c
@@ -199,7 +199,7 @@ int btrfs_find_root_search(struct btrfs_fs_info *fs_info,
 		for (offset = chunk_offset;
 		     offset < chunk_offset + chunk_size;
 		     offset += nodesize) {
-			eb = read_tree_block(fs_info, offset, 0);
+			eb = read_tree_block(fs_info, offset, 0, 0, 0, NULL);
 			if (!eb || IS_ERR(eb))
 				continue;
 			ret = add_eb_to_result(eb, result, nodesize, filter,
diff --git a/check/main.c b/check/main.c
index 275f912b..610c3091 100644
--- a/check/main.c
+++ b/check/main.c
@@ -1898,7 +1898,9 @@ static int walk_down_tree(struct btrfs_root *root, struct btrfs_path *path,
 		if (!next || !btrfs_buffer_uptodate(next, ptr_gen)) {
 			free_extent_buffer(next);
 			reada_walk_down(root, cur, path->slots[*level]);
-			next = read_tree_block(gfs_info, bytenr, ptr_gen);
+			next = read_tree_block(gfs_info, bytenr,
+					       btrfs_header_owner(cur), ptr_gen,
+					       *level - 1, NULL);
 			if (!extent_buffer_uptodate(next)) {
 				struct btrfs_key node_key;
 
@@ -6269,7 +6271,7 @@ static int run_next_block(struct btrfs_root *root,
 	}
 
 	/* fixme, get the real parent transid */
-	buf = read_tree_block(gfs_info, bytenr, gen);
+	buf = read_tree_block(gfs_info, bytenr, 0, gen, 0, NULL);
 	if (!extent_buffer_uptodate(buf)) {
 		record_bad_block_io(extent_cache, bytenr, size);
 		goto out;
@@ -8615,7 +8617,8 @@ static int deal_root_from_list(struct list_head *list,
 		rec = list_entry(list->next,
 				 struct root_item_record, list);
 		last = 0;
-		buf = read_tree_block(gfs_info, rec->bytenr, 0);
+		buf = read_tree_block(gfs_info, rec->bytenr, rec->objectid, 0,
+				      rec->level, NULL);
 		if (!extent_buffer_uptodate(buf)) {
 			free_extent_buffer(buf);
 			ret = -EIO;
diff --git a/check/mode-common.c b/check/mode-common.c
index 394c35fe..a38d2afc 100644
--- a/check/mode-common.c
+++ b/check/mode-common.c
@@ -132,7 +132,7 @@ static int check_prealloc_shared_data_ref(u64 parent, u64 disk_bytenr)
 	int i;
 	int ret = 0;
 
-	eb = read_tree_block(gfs_info, parent, 0);
+	eb = read_tree_block(gfs_info, parent, 0, 0, 0, NULL);
 	if (!extent_buffer_uptodate(eb)) {
 		ret = -EIO;
 		goto out;
@@ -1127,7 +1127,7 @@ int get_extent_item_generation(u64 bytenr, u64 *gen_ret)
 	    BTRFS_EXTENT_FLAG_TREE_BLOCK) {
 		struct extent_buffer *eb;
 
-		eb = read_tree_block(gfs_info, bytenr, 0);
+		eb = read_tree_block(gfs_info, bytenr, 0, 0, 0, NULL);
 		if (extent_buffer_uptodate(eb)) {
 			*gen_ret = btrfs_header_generation(eb);
 			ret = 0;
diff --git a/check/mode-lowmem.c b/check/mode-lowmem.c
index 10f86161..83b86e63 100644
--- a/check/mode-lowmem.c
+++ b/check/mode-lowmem.c
@@ -3748,7 +3748,7 @@ static int query_tree_block_level(u64 bytenr)
 	btrfs_release_path(&path);
 
 	/* Get level from tree block as an alternative source */
-	eb = read_tree_block(gfs_info, bytenr, transid);
+	eb = read_tree_block(gfs_info, bytenr, 0, transid, 0, NULL);
 	if (!extent_buffer_uptodate(eb)) {
 		free_extent_buffer(eb);
 		return -EIO;
@@ -3800,7 +3800,7 @@ static int check_tree_block_backref(u64 root_id, u64 bytenr, int level)
 	}
 
 	/* Read out the tree block to get item/node key */
-	eb = read_tree_block(gfs_info, bytenr, 0);
+	eb = read_tree_block(gfs_info, bytenr, root_id, 0, 0, NULL);
 	if (!extent_buffer_uptodate(eb)) {
 		err |= REFERENCER_MISSING;
 		free_extent_buffer(eb);
@@ -3899,7 +3899,7 @@ static int check_shared_block_backref(u64 parent, u64 bytenr, int level)
 	int found_parent = 0;
 	int i;
 
-	eb = read_tree_block(gfs_info, parent, 0);
+	eb = read_tree_block(gfs_info, parent, 0, 0, 0, NULL);
 	if (!extent_buffer_uptodate(eb))
 		goto out;
 
@@ -4072,7 +4072,7 @@ static int check_shared_data_backref(u64 parent, u64 bytenr)
 	int found_parent = 0;
 	int i;
 
-	eb = read_tree_block(gfs_info, parent, 0);
+	eb = read_tree_block(gfs_info, parent, 0, 0, 0, NULL);
 	if (!extent_buffer_uptodate(eb))
 		goto out;
 
@@ -5046,7 +5046,9 @@ static int walk_down_tree(struct btrfs_root *root, struct btrfs_path *path,
 		if (!next || !btrfs_buffer_uptodate(next, ptr_gen)) {
 			free_extent_buffer(next);
 			reada_walk_down(root, cur, path->slots[*level]);
-			next = read_tree_block(gfs_info, bytenr, ptr_gen);
+			next = read_tree_block(gfs_info, bytenr,
+					       btrfs_header_owner(cur),
+					       ptr_gen, *level - 1, NULL);
 			if (!extent_buffer_uptodate(next)) {
 				struct btrfs_key node_key;
 
diff --git a/check/qgroup-verify.c b/check/qgroup-verify.c
index db49e3c9..1a62009b 100644
--- a/check/qgroup-verify.c
+++ b/check/qgroup-verify.c
@@ -720,7 +720,8 @@ static int travel_tree(struct btrfs_fs_info *info, struct btrfs_root *root,
 //	printf("travel_tree: bytenr: %llu\tnum_bytes: %llu\tref_parent: %llu\n",
 //	       bytenr, num_bytes, ref_parent);
 
-	eb = read_tree_block(info, bytenr, 0);
+	eb = read_tree_block(info, bytenr, btrfs_root_id(root), 0,
+			     0, NULL);
 	if (!extent_buffer_uptodate(eb))
 		return -EIO;
 
diff --git a/check/repair.c b/check/repair.c
index 07c432b3..ec8b0196 100644
--- a/check/repair.c
+++ b/check/repair.c
@@ -108,7 +108,9 @@ static int traverse_tree_blocks(struct extent_io_tree *tree,
 			 * in, but for now this doesn't actually use the root so
 			 * just pass in extent_root.
 			 */
-			tmp = read_tree_block(fs_info, bytenr, 0);
+			tmp = read_tree_block(fs_info, bytenr, key.objectid, 0,
+					      btrfs_disk_root_level(eb, ri),
+					      NULL);
 			if (!extent_buffer_uptodate(tmp)) {
 				fprintf(stderr, "Error reading root block\n");
 				return -EIO;
@@ -133,7 +135,9 @@ static int traverse_tree_blocks(struct extent_io_tree *tree,
 				continue;
 			}
 
-			tmp = read_tree_block(fs_info, bytenr, 0);
+			tmp = read_tree_block(fs_info, bytenr,
+					      btrfs_header_owner(eb), 0,
+					      level - 1, NULL);
 			if (!extent_buffer_uptodate(tmp)) {
 				fprintf(stderr, "Error reading tree block\n");
 				return -EIO;
diff --git a/cmds/inspect-dump-tree.c b/cmds/inspect-dump-tree.c
index 4c93056b..7c524b04 100644
--- a/cmds/inspect-dump-tree.c
+++ b/cmds/inspect-dump-tree.c
@@ -58,9 +58,10 @@ static void print_extents(struct extent_buffer *eb)
 
 	nr = btrfs_header_nritems(eb);
 	for (i = 0; i < nr; i++) {
-		next = read_tree_block(fs_info,
-				btrfs_node_blockptr(eb, i),
-				btrfs_node_ptr_generation(eb, i));
+		next = read_tree_block(fs_info, btrfs_node_blockptr(eb, i),
+				       btrfs_header_owner(eb),
+				       btrfs_node_ptr_generation(eb, i),
+				       btrfs_header_level(eb) - 1, NULL);
 		if (!extent_buffer_uptodate(next))
 			continue;
 		if (btrfs_is_leaf(next) && btrfs_header_level(eb) != 1) {
@@ -288,7 +289,7 @@ static int dump_print_tree_blocks(struct btrfs_fs_info *fs_info,
 			goto next;
 		}
 
-		eb = read_tree_block(fs_info, bytenr, 0);
+		eb = read_tree_block(fs_info, bytenr, 0, 0, 0, NULL);
 		if (!extent_buffer_uptodate(eb)) {
 			error("failed to read tree block %llu", bytenr);
 			ret = -EIO;
@@ -625,7 +626,8 @@ again:
 
 			offset = btrfs_item_ptr_offset(leaf, slot);
 			read_extent_buffer(leaf, &ri, offset, sizeof(ri));
-			buf = read_tree_block(info, btrfs_root_bytenr(&ri), 0);
+			buf = read_tree_block(info, btrfs_root_bytenr(&ri),
+					      key.objectid, 0, 0, NULL);
 			if (!extent_buffer_uptodate(buf))
 				goto next;
 			if (tree_id && found_key.objectid != tree_id) {
diff --git a/cmds/inspect-tree-stats.c b/cmds/inspect-tree-stats.c
index 08be1686..716aa008 100644
--- a/cmds/inspect-tree-stats.c
+++ b/cmds/inspect-tree-stats.c
@@ -153,7 +153,9 @@ static int walk_nodes(struct btrfs_root *root, struct btrfs_path *path,
 		path->slots[level] = i;
 		if ((level - 1) > 0 || find_inline) {
 			tmp = read_tree_block(root->fs_info, cur_blocknr,
-					      btrfs_node_ptr_generation(b, i));
+					      btrfs_header_owner(b),
+					      btrfs_node_ptr_generation(b, i),
+					      level - 1, NULL);
 			if (!extent_buffer_uptodate(tmp)) {
 				error("failed to read blocknr %llu",
 					btrfs_node_blockptr(b, i));
diff --git a/cmds/restore.c b/cmds/restore.c
index c38cb541..72fc7a07 100644
--- a/cmds/restore.c
+++ b/cmds/restore.c
@@ -1260,7 +1260,8 @@ static struct btrfs_root *open_fs(const char *dev, u64 root_location,
 			root_location = btrfs_super_root(fs_info->super_copy);
 		generation = btrfs_super_generation(fs_info->super_copy);
 		root->node = read_tree_block(fs_info, root_location,
-					     generation);
+					     btrfs_root_id(root), generation,
+					     0, NULL);
 		if (!extent_buffer_uptodate(root->node)) {
 			error("opening tree root failed");
 			close_ctree(root);
@@ -1527,7 +1528,8 @@ static int cmd_restore(const struct cmd_struct *cmd, int argc, char **argv)
 
 	if (fs_location != 0) {
 		free_extent_buffer(root->node);
-		root->node = read_tree_block(root->fs_info, fs_location, 0);
+		root->node = read_tree_block(root->fs_info, fs_location, 0, 0,
+					     0, NULL);
 		if (!extent_buffer_uptodate(root->node)) {
 			error("failed to read fs location");
 			ret = 1;
diff --git a/image/main.c b/image/main.c
index ae7acb96..92b0dbfa 100644
--- a/image/main.c
+++ b/image/main.c
@@ -707,7 +707,8 @@ static int flush_pending(struct metadump_struct *md, int done)
 			u64 this_read = min((u64)md->root->fs_info->nodesize,
 					size);
 
-			eb = read_tree_block(md->root->fs_info, start, 0);
+			eb = read_tree_block(md->root->fs_info, start, 0, 0, 0,
+					     NULL);
 			if (!extent_buffer_uptodate(eb)) {
 				free(async->buffer);
 				free(async);
@@ -811,7 +812,7 @@ static int copy_tree_blocks(struct btrfs_root *root, struct extent_buffer *eb,
 				continue;
 			ri = btrfs_item_ptr(eb, i, struct btrfs_root_item);
 			bytenr = btrfs_disk_root_bytenr(eb, ri);
-			tmp = read_tree_block(fs_info, bytenr, 0);
+			tmp = read_tree_block(fs_info, bytenr, 0, 0, 0, NULL);
 			if (!extent_buffer_uptodate(tmp)) {
 				error("unable to read log root block");
 				return -EIO;
@@ -822,7 +823,7 @@ static int copy_tree_blocks(struct btrfs_root *root, struct extent_buffer *eb,
 				return ret;
 		} else {
 			bytenr = btrfs_node_blockptr(eb, i);
-			tmp = read_tree_block(fs_info, bytenr, 0);
+			tmp = read_tree_block(fs_info, bytenr, 0, 0, 0, NULL);
 			if (!extent_buffer_uptodate(tmp)) {
 				error("unable to read log root block");
 				return -EIO;
@@ -2697,7 +2698,7 @@ static int iter_tree_blocks(struct btrfs_fs_info *fs_info,
 				continue;
 			ri = btrfs_item_ptr(eb, i, struct btrfs_root_item);
 			bytenr = btrfs_disk_root_bytenr(eb, ri);
-			tmp = read_tree_block(fs_info, bytenr, 0);
+			tmp = read_tree_block(fs_info, bytenr, 0, 0, 0, NULL);
 			if (!extent_buffer_uptodate(tmp)) {
 				error("unable to read log root block");
 				return -EIO;
@@ -2708,7 +2709,7 @@ static int iter_tree_blocks(struct btrfs_fs_info *fs_info,
 				return ret;
 		} else {
 			bytenr = btrfs_node_blockptr(eb, i);
-			tmp = read_tree_block(fs_info, bytenr, 0);
+			tmp = read_tree_block(fs_info, bytenr, 0, 0, 0, NULL);
 			if (!extent_buffer_uptodate(tmp)) {
 				error("unable to read log root block");
 				return -EIO;
diff --git a/kernel-shared/backref.c b/kernel-shared/backref.c
index 897cd089..3b979430 100644
--- a/kernel-shared/backref.c
+++ b/kernel-shared/backref.c
@@ -461,7 +461,8 @@ static int __add_missing_keys(struct btrfs_fs_info *fs_info,
 		ASSERT(!ref->parent);
 		ASSERT(!ref->key_for_search.type);
 		BUG_ON(!ref->wanted_disk_byte);
-		eb = read_tree_block(fs_info, ref->wanted_disk_byte, 0);
+		eb = read_tree_block(fs_info, ref->wanted_disk_byte,
+				     ref->root_id, 0, ref->level - 1, NULL);
 		if (!extent_buffer_uptodate(eb)) {
 			free_extent_buffer(eb);
 			return -EIO;
@@ -823,7 +824,8 @@ static int find_parent_nodes(struct btrfs_trans_handle *trans,
 			    ref->level == 0) {
 				struct extent_buffer *eb;
 
-				eb = read_tree_block(fs_info, ref->parent, 0);
+				eb = read_tree_block(fs_info, ref->parent, 0,
+						     0, ref->level, NULL);
 				if (!extent_buffer_uptodate(eb)) {
 					free_extent_buffer(eb);
 					ret = -EIO;
diff --git a/kernel-shared/ctree.c b/kernel-shared/ctree.c
index c3e9830a..35133268 100644
--- a/kernel-shared/ctree.c
+++ b/kernel-shared/ctree.c
@@ -874,7 +874,9 @@ struct extent_buffer *read_node_slot(struct btrfs_fs_info *fs_info,
 		return NULL;
 
 	ret = read_tree_block(fs_info, btrfs_node_blockptr(parent, slot),
-		       btrfs_node_ptr_generation(parent, slot));
+			      btrfs_header_owner(parent),
+			      btrfs_node_ptr_generation(parent, slot),
+			      level - 1, NULL);
 	if (!extent_buffer_uptodate(ret))
 		return ERR_PTR(-EIO);
 
diff --git a/kernel-shared/disk-io.c b/kernel-shared/disk-io.c
index 9d93f331..688b1c8e 100644
--- a/kernel-shared/disk-io.c
+++ b/kernel-shared/disk-io.c
@@ -337,8 +337,9 @@ int read_whole_eb(struct btrfs_fs_info *info, struct extent_buffer *eb, int mirr
 	return 0;
 }
 
-struct extent_buffer* read_tree_block(struct btrfs_fs_info *fs_info, u64 bytenr,
-		u64 parent_transid)
+struct extent_buffer *read_tree_block(struct btrfs_fs_info *fs_info, u64 bytenr,
+				      u64 owner_root, u64 parent_transid,
+				      int level, struct btrfs_key *first_key)
 {
 	int ret;
 	struct extent_buffer *eb;
@@ -510,7 +511,8 @@ static int read_root_node(struct btrfs_fs_info *fs_info,
 			  struct btrfs_root *root, u64 bytenr, u64 gen,
 			  int level)
 {
-	root->node = read_tree_block(fs_info, bytenr, gen);
+	root->node = read_tree_block(fs_info, bytenr, btrfs_root_id(root),
+				     gen, level, NULL);
 	if (!extent_buffer_uptodate(root->node))
 		goto err;
 	if (btrfs_header_level(root->node) != level) {
diff --git a/kernel-shared/disk-io.h b/kernel-shared/disk-io.h
index 2424060d..f349b3ef 100644
--- a/kernel-shared/disk-io.h
+++ b/kernel-shared/disk-io.h
@@ -138,8 +138,9 @@ static inline u64 btrfs_sb_offset(int mirror)
 struct btrfs_device;
 
 int read_whole_eb(struct btrfs_fs_info *info, struct extent_buffer *eb, int mirror);
-struct extent_buffer* read_tree_block(struct btrfs_fs_info *fs_info, u64 bytenr,
-		u64 parent_transid);
+struct extent_buffer *read_tree_block(struct btrfs_fs_info *fs_info, u64 bytenr,
+				      u64 owner_root, u64 parent_transid,
+				      int level, struct btrfs_key *first_key);
 
 void readahead_tree_block(struct btrfs_fs_info *fs_info, u64 bytenr,
 			  u64 parent_transid);
diff --git a/kernel-shared/print-tree.c b/kernel-shared/print-tree.c
index d536b2ff..6cdfdef7 100644
--- a/kernel-shared/print-tree.c
+++ b/kernel-shared/print-tree.c
@@ -1557,7 +1557,9 @@ static void dfs_print_children(struct extent_buffer *root_eb, unsigned int mode)
 
 	for (i = 0; i < nr; i++) {
 		next = read_tree_block(fs_info, btrfs_node_blockptr(root_eb, i),
-				btrfs_node_ptr_generation(root_eb, i));
+				       btrfs_header_owner(root_eb),
+				       btrfs_node_ptr_generation(root_eb, i),
+				       root_eb_level, NULL);
 		if (!extent_buffer_uptodate(next)) {
 			fprintf(stderr, "failed to read %llu in tree %llu\n",
 				btrfs_node_blockptr(root_eb, i),
diff --git a/tune/change-uuid.c b/tune/change-uuid.c
index 628a1bba..dae41056 100644
--- a/tune/change-uuid.c
+++ b/tune/change-uuid.c
@@ -111,7 +111,7 @@ static int change_extent_tree_uuid(struct btrfs_fs_info *fs_info, uuid_t new_fsi
 			goto next;
 
 		bytenr = key.objectid;
-		eb = read_tree_block(fs_info, bytenr, 0);
+		eb = read_tree_block(fs_info, bytenr, 0, 0, 0, NULL);
 		if (IS_ERR(eb)) {
 			error("failed to read tree block: %llu", bytenr);
 			ret = PTR_ERR(eb);
-- 
2.40.0

