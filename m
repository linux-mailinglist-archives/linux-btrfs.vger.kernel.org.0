Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC96B2A8287
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Nov 2020 16:46:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731492AbgKEPps (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 5 Nov 2020 10:45:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730977AbgKEPpq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 5 Nov 2020 10:45:46 -0500
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACEDCC0613CF
        for <linux-btrfs@vger.kernel.org>; Thu,  5 Nov 2020 07:45:46 -0800 (PST)
Received: by mail-qt1-x836.google.com with SMTP id g17so1370808qts.5
        for <linux-btrfs@vger.kernel.org>; Thu, 05 Nov 2020 07:45:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=I9bTXdv87ULyYoKeEPrY4mx+N80DypzG86xV/mWmdTs=;
        b=Z1Nxds/WQT1Rr/jVSrE9PJal1iB8ik0nFMOLdkKHJDCcRRiHsiMlzbaYq2hsQwp7OU
         bXxXSHma690QTaKAuQB3gXF7Inl6p/Naga9Kskam8xae4FJF7PgohcpTBeZ6UV7x3g0I
         ngBNmhoQ91uCLvk9c9nN6et0fWrUuevFg0RoKZMocmr4lCOryz+f3OkHMvBC20Vhy2ab
         yMvvmvgB2Pr9zvypuUES8nHSTRliRCSLEdblDbJFJpNurAk/g4OjQ21DjyWF0f6ikJ2q
         5CVf+sEjV7HTgT0+33OFWaOBVTr/vQNQQ8ojOHUHy6dhujq4Wgur5yqhAROoidJAWoUA
         Ic1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=I9bTXdv87ULyYoKeEPrY4mx+N80DypzG86xV/mWmdTs=;
        b=ZA+9SQqbU4r4axl4YcrXHbDqDIhoSfo9jmLof/RZPwNJv+kRr1edOSyHjZypUoNIRA
         ZRuPt93y3mu7H8NuSKFoS+x9/dRkR2K78SoMlCUjKCjL5MBVRi8Pumkz5zcfdvxGRqOG
         1yH22LfxCaxdMlqHyckYOdXUIXEMV2G7HVxUHWv7pZrCopZZVLnJMr9MpNFNbvDVfs0v
         Sb5ZMvYYG4XEbWA4mNi0BER4Iakr/LtatNLkJGWZiUE9M+NNDhzzDL5m8L7TZhHM+HSV
         wRBuf2FPw7oAeJW8dFdobz6f8HFgLiBa9cxcSyPfGyB6praIf2bot+sAFmAxbqyx3BT2
         6J0A==
X-Gm-Message-State: AOAM531ISKakeptc7XjjVWwOCVqv/aL+BUg5i8148CAS7nhWhzqaE4M9
        I4eucYgC1+MO9PDYgbME6Y/K0wTCvPykbIcw
X-Google-Smtp-Source: ABdhPJzN1CliWz7rRWQWxVeoGu5QzSjmvmQ5dq1as48+TnplI3esDw4G9nHJf67TD3nXHMSxHB9K9g==
X-Received: by 2002:ac8:1095:: with SMTP id a21mr2444403qtj.260.1604591144150;
        Thu, 05 Nov 2020 07:45:44 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id u24sm1067206qtv.83.2020.11.05.07.45.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 07:45:43 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 11/14] btrfs: pass root owner to read_tree_block
Date:   Thu,  5 Nov 2020 10:45:18 -0500
Message-Id: <9060bfcc7ea0806cb05ff8e7e8d7adb17d7b6e53.1604591048.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1604591048.git.josef@toxicpanda.com>
References: <cover.1604591048.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

In order to properly set the lockdep class of a newly allocated block we
need to know the owner of the block.  For non refcount'ed tree's this is
straightforward, we always know in advance what tree we're reading from.
For refcount'ed trees we don't necessarily know, however all refcount'ed
trees share the same lockdep class name, tree-<level>.

Fix all of the callers of read_tree_block() to pass in the root objectid
we're using.  In places like relocation and backref we could probably
unconditionally use 0, but just in case use the root when we have it,
otherwise use 0 in the cases we don't have the root as it's going to be
a refcount'ed tree anyway.

This is a preparation patch for further changes.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/backref.c     |  6 +++---
 fs/btrfs/ctree.c       |  8 +++++---
 fs/btrfs/disk-io.c     | 14 +++++++++-----
 fs/btrfs/disk-io.h     |  4 ++--
 fs/btrfs/extent-tree.c |  4 ++--
 fs/btrfs/print-tree.c  |  1 +
 fs/btrfs/qgroup.c      |  2 +-
 fs/btrfs/relocation.c  |  4 ++--
 8 files changed, 25 insertions(+), 18 deletions(-)

diff --git a/fs/btrfs/backref.c b/fs/btrfs/backref.c
index 86abe34e9444..02d7d7b2563b 100644
--- a/fs/btrfs/backref.c
+++ b/fs/btrfs/backref.c
@@ -783,8 +783,8 @@ static int add_missing_keys(struct btrfs_fs_info *fs_info,
 		BUG_ON(ref->key_for_search.type);
 		BUG_ON(!ref->wanted_disk_byte);
 
-		eb = read_tree_block(fs_info, ref->wanted_disk_byte, 0,
-				     ref->level - 1, NULL);
+		eb = read_tree_block(fs_info, ref->wanted_disk_byte,
+				     ref->root_id, 0, ref->level - 1, NULL);
 		if (IS_ERR(eb)) {
 			free_pref(ref);
 			return PTR_ERR(eb);
@@ -1331,7 +1331,7 @@ static int find_parent_nodes(struct btrfs_trans_handle *trans,
 				struct extent_buffer *eb;
 
 				eb = read_tree_block(fs_info, ref->parent, 0,
-						     ref->level, NULL);
+						     0, ref->level, NULL);
 				if (IS_ERR(eb)) {
 					ret = PTR_ERR(eb);
 					goto out;
diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index 5ec778e01222..35e5acbcc570 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -1353,7 +1353,8 @@ get_old_root(struct btrfs_root *root, u64 time_seq)
 	if (old_root && tm && tm->op != MOD_LOG_KEY_REMOVE_WHILE_FREEING) {
 		btrfs_tree_read_unlock(eb_root);
 		free_extent_buffer(eb_root);
-		old = read_tree_block(fs_info, logical, 0, level, NULL);
+		old = read_tree_block(fs_info, logical,
+				      root->root_key.objectid, 0, level, NULL);
 		if (WARN_ON(IS_ERR(old) || !extent_buffer_uptodate(old))) {
 			if (!IS_ERR(old))
 				free_extent_buffer(old);
@@ -1763,6 +1764,7 @@ struct extent_buffer *btrfs_read_node_slot(struct extent_buffer *parent,
 
 	btrfs_node_key_to_cpu(parent, &first_key, slot);
 	eb = read_tree_block(parent->fs_info, btrfs_node_blockptr(parent, slot),
+			     btrfs_header_owner(parent),
 			     btrfs_node_ptr_generation(parent, slot),
 			     level - 1, &first_key);
 	if (!IS_ERR(eb) && !extent_buffer_uptodate(eb)) {
@@ -2352,8 +2354,8 @@ read_block_for_search(struct btrfs_root *root, struct btrfs_path *p,
 		reada_for_search(fs_info, p, level, slot, key->objectid);
 
 	ret = -EAGAIN;
-	tmp = read_tree_block(fs_info, blocknr, gen, parent_level - 1,
-			      &first_key);
+	tmp = read_tree_block(fs_info, blocknr, root->root_key.objectid,
+			      gen, parent_level - 1, &first_key);
 	if (!IS_ERR(tmp)) {
 		/*
 		 * If the read above didn't mark this buffer up to date,
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index ec64e087520e..934723785ab8 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -958,13 +958,14 @@ struct extent_buffer *btrfs_find_create_tree_block(
  * Read tree block at logical address @bytenr and do variant basic but critical
  * verification.
  *
+ * @owner_root:		the objectid of the root owner for this block.
  * @parent_transid:	expected transid of this tree block, skip check if 0
  * @level:		expected level, mandatory check
  * @first_key:		expected key in slot 0, skip check if NULL
  */
 struct extent_buffer *read_tree_block(struct btrfs_fs_info *fs_info, u64 bytenr,
-				      u64 parent_transid, int level,
-				      struct btrfs_key *first_key)
+				      u64 owner_root, u64 parent_transid,
+				      int level, struct btrfs_key *first_key)
 {
 	struct extent_buffer *buf = NULL;
 	int ret;
@@ -1287,7 +1288,7 @@ static struct btrfs_root *read_tree_root_path(struct btrfs_root *tree_root,
 	level = btrfs_root_level(&root->root_item);
 	root->node = read_tree_block(fs_info,
 				     btrfs_root_bytenr(&root->root_item),
-				     generation, level, NULL);
+				     key->objectid, generation, level, NULL);
 	if (IS_ERR(root->node)) {
 		ret = PTR_ERR(root->node);
 		root->node = NULL;
@@ -2241,8 +2242,9 @@ static int btrfs_replay_log(struct btrfs_fs_info *fs_info,
 		return -ENOMEM;
 
 	log_tree_root->node = read_tree_block(fs_info, bytenr,
-					      fs_info->generation + 1,
-					      level, NULL);
+					      BTRFS_TREE_LOG_OBJECTID,
+					      fs_info->generation + 1, level,
+					      NULL);
 	if (IS_ERR(log_tree_root->node)) {
 		btrfs_warn(fs_info, "failed to read log tree");
 		ret = PTR_ERR(log_tree_root->node);
@@ -2628,6 +2630,7 @@ static int __cold init_tree_roots(struct btrfs_fs_info *fs_info)
 		generation = btrfs_super_generation(sb);
 		level = btrfs_super_root_level(sb);
 		tree_root->node = read_tree_block(fs_info, btrfs_super_root(sb),
+						  BTRFS_ROOT_TREE_OBJECTID,
 						  generation, level, NULL);
 		if (IS_ERR(tree_root->node)) {
 			handle_error = true;
@@ -3116,6 +3119,7 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 
 	chunk_root->node = read_tree_block(fs_info,
 					   btrfs_super_chunk_root(disk_super),
+					   BTRFS_CHUNK_TREE_OBJECTID,
 					   generation, level, NULL);
 	if (IS_ERR(chunk_root->node) ||
 	    !extent_buffer_uptodate(chunk_root->node)) {
diff --git a/fs/btrfs/disk-io.h b/fs/btrfs/disk-io.h
index 009f505d6c97..41588babf2ed 100644
--- a/fs/btrfs/disk-io.h
+++ b/fs/btrfs/disk-io.h
@@ -43,8 +43,8 @@ void btrfs_init_fs_info(struct btrfs_fs_info *fs_info);
 int btrfs_verify_level_key(struct extent_buffer *eb, int level,
 			   struct btrfs_key *first_key, u64 parent_transid);
 struct extent_buffer *read_tree_block(struct btrfs_fs_info *fs_info, u64 bytenr,
-				      u64 parent_transid, int level,
-				      struct btrfs_key *first_key);
+				      u64 owner_root, u64 parent_transid,
+				      int level, struct btrfs_key *first_key);
 struct extent_buffer *btrfs_find_create_tree_block(
 						struct btrfs_fs_info *fs_info,
 						u64 bytenr);
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index bf2f0af24e91..fe829bb528b5 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -5072,8 +5072,8 @@ static noinline int do_walk_down(struct btrfs_trans_handle *trans,
 	if (!next) {
 		if (reada && level == 1)
 			reada_walk_down(trans, root, wc, path);
-		next = read_tree_block(fs_info, bytenr, generation, level - 1,
-				       &first_key);
+		next = read_tree_block(fs_info, bytenr, root->root_key.objectid,
+				       generation, level - 1, &first_key);
 		if (IS_ERR(next)) {
 			return PTR_ERR(next);
 		} else if (!extent_buffer_uptodate(next)) {
diff --git a/fs/btrfs/print-tree.c b/fs/btrfs/print-tree.c
index 8db99117531d..fe5e0026129d 100644
--- a/fs/btrfs/print-tree.c
+++ b/fs/btrfs/print-tree.c
@@ -390,6 +390,7 @@ void btrfs_print_tree(struct extent_buffer *c, bool follow)
 
 		btrfs_node_key_to_cpu(c, &first_key, i);
 		next = read_tree_block(fs_info, btrfs_node_blockptr(c, i),
+				       btrfs_header_owner(c),
 				       btrfs_node_ptr_generation(c, i),
 				       level - 1, &first_key);
 		if (IS_ERR(next)) {
diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index 25e3b7105e8a..8a78783213f9 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -4140,7 +4140,7 @@ int btrfs_qgroup_trace_subtree_after_cow(struct btrfs_trans_handle *trans,
 	spin_unlock(&blocks->lock);
 
 	/* Read out reloc subtree root */
-	reloc_eb = read_tree_block(fs_info, block->reloc_bytenr,
+	reloc_eb = read_tree_block(fs_info, block->reloc_bytenr, 0,
 				   block->reloc_generation, block->level,
 				   &block->first_key);
 	if (IS_ERR(reloc_eb)) {
diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 465f5b4d3233..3e792bf31ecd 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -2413,7 +2413,7 @@ static int get_tree_block_key(struct btrfs_fs_info *fs_info,
 {
 	struct extent_buffer *eb;
 
-	eb = read_tree_block(fs_info, block->bytenr, block->key.offset,
+	eb = read_tree_block(fs_info, block->bytenr, 0, block->key.offset,
 			     block->level, NULL);
 	if (IS_ERR(eb)) {
 		return PTR_ERR(eb);
@@ -3039,7 +3039,7 @@ int add_data_references(struct reloc_control *rc,
 	while ((ref_node = ulist_next(leaves, &leaf_uiter))) {
 		struct extent_buffer *eb;
 
-		eb = read_tree_block(fs_info, ref_node->val, 0, 0, NULL);
+		eb = read_tree_block(fs_info, ref_node->val, 0, 0, 0, NULL);
 		if (IS_ERR(eb)) {
 			ret = PTR_ERR(eb);
 			break;
-- 
2.26.2

