Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 695A33375C6
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Mar 2021 15:32:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233913AbhCKOb6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 11 Mar 2021 09:31:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:57006 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233679AbhCKOb2 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 11 Mar 2021 09:31:28 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id EC94A64FE5;
        Thu, 11 Mar 2021 14:31:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615473087;
        bh=VstjVMeExBqD1S35M9kDaLcww9nD/ofjVwDjEkusemE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uVpwAWxOR6N/buaP9r6RX5Y2Bu8e4q51Gj043hkiwxYEiVwvo0Tq4t2tj1jiXNjGq
         24RskuwHHbhzzGQQ2RdE5Taok6ZTgfefpYNwGDjtxY+lsqDww8l1xauFROYIRu8ZLT
         +GqflRcqCdKIE0ZK4k2h9K3df3fXi48kiXMpRfrrs/JGmY5MeCEYAny60j2Arhsbi/
         YH3nOtUDdZ30Kr+lQ8pSkFebNVqg8YgfR5wY2u/fK3c9ZMAh9fOJ9Ai6JVdZ3JaRPl
         He+lIrSM/rvr8TKZ9LeYYpoG+ifyonQDSJuq+X1bC63w3IEymm1EGpMOEpkhJegmnm
         CKGjPG0wCzMTA==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Cc:     ce3g8jdj@umail.furryterror.org, Filipe Manana <fdmanana@suse.com>
Subject: [PATCH 4/9] btrfs: use booleans where appropriate for the tree mod log functions
Date:   Thu, 11 Mar 2021 14:31:08 +0000
Message-Id: <ad94e2466afa62fbc64ff66af85cb6ec0d1235fb.1615472583.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1615472583.git.fdmanana@suse.com>
References: <cover.1615472583.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

Several functions of the tree modification log use integers as booleans,
so change them to use booleans instead, making their use more clear.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/ctree.c        |  6 +++---
 fs/btrfs/tree-mod-log.c | 42 ++++++++++++++++++++---------------------
 fs/btrfs/tree-mod-log.h |  2 +-
 3 files changed, 25 insertions(+), 25 deletions(-)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index 2c6e525b3458..1b0f28f69cb3 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -500,7 +500,7 @@ static noinline int __btrfs_cow_block(struct btrfs_trans_handle *trans,
 			parent_start = buf->start;
 
 		atomic_inc(&cow->refs);
-		ret = btrfs_tree_mod_log_insert_root(root->node, cow, 1);
+		ret = btrfs_tree_mod_log_insert_root(root->node, cow, true);
 		BUG_ON(ret < 0);
 		rcu_assign_pointer(root->node, cow);
 
@@ -958,7 +958,7 @@ static noinline int balance_level(struct btrfs_trans_handle *trans,
 			goto enospc;
 		}
 
-		ret = btrfs_tree_mod_log_insert_root(root->node, child, 1);
+		ret = btrfs_tree_mod_log_insert_root(root->node, child, true);
 		BUG_ON(ret < 0);
 		rcu_assign_pointer(root->node, child);
 
@@ -2480,7 +2480,7 @@ static noinline int insert_new_root(struct btrfs_trans_handle *trans,
 	btrfs_mark_buffer_dirty(c);
 
 	old = root->node;
-	ret = btrfs_tree_mod_log_insert_root(root->node, c, 0);
+	ret = btrfs_tree_mod_log_insert_root(root->node, c, false);
 	BUG_ON(ret < 0);
 	rcu_assign_pointer(root->node, c);
 
diff --git a/fs/btrfs/tree-mod-log.c b/fs/btrfs/tree-mod-log.c
index fc7eb33ec383..f2a6da1b2903 100644
--- a/fs/btrfs/tree-mod-log.c
+++ b/fs/btrfs/tree-mod-log.c
@@ -158,40 +158,40 @@ static noinline int tree_mod_log_insert(struct btrfs_fs_info *fs_info,
 }
 
 /*
- * Determines if logging can be omitted. Returns 1 if it can. Otherwise, it
- * returns zero with the tree_mod_log_lock acquired. The caller must hold
+ * Determines if logging can be omitted. Returns true if it can. Otherwise, it
+ * returns false with the tree_mod_log_lock acquired. The caller must hold
  * this until all tree mod log insertions are recorded in the rb tree and then
  * write unlock fs_info::tree_mod_log_lock.
  */
-static inline int tree_mod_dont_log(struct btrfs_fs_info *fs_info,
+static inline bool tree_mod_dont_log(struct btrfs_fs_info *fs_info,
 				    struct extent_buffer *eb)
 {
 	smp_mb();
 	if (list_empty(&(fs_info)->tree_mod_seq_list))
-		return 1;
+		return true;
 	if (eb && btrfs_header_level(eb) == 0)
-		return 1;
+		return true;
 
 	write_lock(&fs_info->tree_mod_log_lock);
 	if (list_empty(&(fs_info)->tree_mod_seq_list)) {
 		write_unlock(&fs_info->tree_mod_log_lock);
-		return 1;
+		return true;
 	}
 
-	return 0;
+	return false;
 }
 
 /* Similar to tree_mod_dont_log, but doesn't acquire any locks. */
-static inline int tree_mod_need_log(const struct btrfs_fs_info *fs_info,
+static inline bool tree_mod_need_log(const struct btrfs_fs_info *fs_info,
 				    struct extent_buffer *eb)
 {
 	smp_mb();
 	if (list_empty(&(fs_info)->tree_mod_seq_list))
-		return 0;
+		return false;
 	if (eb && btrfs_header_level(eb) == 0)
-		return 0;
+		return false;
 
-	return 1;
+	return true;
 }
 
 static struct tree_mod_elem *alloc_tree_mod_elem(struct extent_buffer *eb,
@@ -252,7 +252,7 @@ int btrfs_tree_mod_log_insert_move(struct extent_buffer *eb,
 	struct tree_mod_elem **tm_list = NULL;
 	int ret = 0;
 	int i;
-	int locked = 0;
+	bool locked = false;
 
 	if (!tree_mod_need_log(eb->fs_info, eb))
 		return 0;
@@ -284,7 +284,7 @@ int btrfs_tree_mod_log_insert_move(struct extent_buffer *eb,
 
 	if (tree_mod_dont_log(eb->fs_info, eb))
 		goto free_tms;
-	locked = 1;
+	locked = true;
 
 	/*
 	 * When we override something during the move, we log these removals.
@@ -340,7 +340,7 @@ static inline int tree_mod_log_free_eb(struct btrfs_fs_info *fs_info,
 
 int btrfs_tree_mod_log_insert_root(struct extent_buffer *old_root,
 				   struct extent_buffer *new_root,
-				   int log_removal)
+				   bool log_removal)
 {
 	struct btrfs_fs_info *fs_info = old_root->fs_info;
 	struct tree_mod_elem *tm = NULL;
@@ -410,7 +410,7 @@ int btrfs_tree_mod_log_insert_root(struct extent_buffer *old_root,
 
 static struct tree_mod_elem *__tree_mod_log_search(struct btrfs_fs_info *fs_info,
 						   u64 start, u64 min_seq,
-						   int smallest)
+						   bool smallest)
 {
 	struct rb_root *tm_root;
 	struct rb_node *node;
@@ -458,7 +458,7 @@ static struct tree_mod_elem *__tree_mod_log_search(struct btrfs_fs_info *fs_info
 static struct tree_mod_elem *tree_mod_log_search_oldest(struct btrfs_fs_info *fs_info,
 							u64 start, u64 min_seq)
 {
-	return __tree_mod_log_search(fs_info, start, min_seq, 1);
+	return __tree_mod_log_search(fs_info, start, min_seq, true);
 }
 
 /*
@@ -469,7 +469,7 @@ static struct tree_mod_elem *tree_mod_log_search_oldest(struct btrfs_fs_info *fs
 static struct tree_mod_elem *tree_mod_log_search(struct btrfs_fs_info *fs_info,
 						 u64 start, u64 min_seq)
 {
-	return __tree_mod_log_search(fs_info, start, min_seq, 0);
+	return __tree_mod_log_search(fs_info, start, min_seq, false);
 }
 
 
@@ -484,7 +484,7 @@ int btrfs_tree_mod_log_eb_copy(struct extent_buffer *dst,
 	struct tree_mod_elem **tm_list = NULL;
 	struct tree_mod_elem **tm_list_add, **tm_list_rem;
 	int i;
-	int locked = 0;
+	bool locked = false;
 
 	if (!tree_mod_need_log(fs_info, NULL))
 		return 0;
@@ -517,7 +517,7 @@ int btrfs_tree_mod_log_eb_copy(struct extent_buffer *dst,
 
 	if (tree_mod_dont_log(fs_info, NULL))
 		goto free_tms;
-	locked = 1;
+	locked = true;
 
 	for (i = 0; i < nr_items; i++) {
 		ret = tree_mod_log_insert(fs_info, tm_list_rem[i]);
@@ -602,7 +602,7 @@ static struct tree_mod_elem *tree_mod_log_oldest_root(struct extent_buffer *eb_r
 	struct tree_mod_elem *tm;
 	struct tree_mod_elem *found = NULL;
 	u64 root_logical = eb_root->start;
-	int looped = 0;
+	bool looped = false;
 
 	if (!time_seq)
 		return NULL;
@@ -636,7 +636,7 @@ static struct tree_mod_elem *tree_mod_log_oldest_root(struct extent_buffer *eb_r
 
 		found = tm;
 		root_logical = tm->old_root.logical;
-		looped = 1;
+		looped = true;
 	}
 
 	/* if there's no old root to return, return what we found instead */
diff --git a/fs/btrfs/tree-mod-log.h b/fs/btrfs/tree-mod-log.h
index 15e7a4c4bb14..2f7396ea57ae 100644
--- a/fs/btrfs/tree-mod-log.h
+++ b/fs/btrfs/tree-mod-log.h
@@ -30,7 +30,7 @@ void btrfs_put_tree_mod_seq(struct btrfs_fs_info *fs_info,
 			    struct btrfs_seq_list *elem);
 int btrfs_tree_mod_log_insert_root(struct extent_buffer *old_root,
 				   struct extent_buffer *new_root,
-				   int log_removal);
+				   bool log_removal);
 int btrfs_tree_mod_log_insert_key(struct extent_buffer *eb, int slot,
 				  enum btrfs_mod_log_op op, gfp_t flags);
 int btrfs_tree_mod_log_free_eb(struct extent_buffer *eb);
-- 
2.28.0

