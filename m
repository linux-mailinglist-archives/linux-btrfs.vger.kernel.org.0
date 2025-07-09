Return-Path: <linux-btrfs+bounces-15409-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E301BAFF459
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Jul 2025 00:04:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 913461C469CB
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Jul 2025 22:05:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC0D323C4F4;
	Wed,  9 Jul 2025 22:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bHLM72pi"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yb1-f196.google.com (mail-yb1-f196.google.com [209.85.219.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4CF113D2B2
	for <linux-btrfs@vger.kernel.org>; Wed,  9 Jul 2025 22:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752098684; cv=none; b=EidkyWmGyXV5eeMblDZeV0FsPfn3Li1ToUl+Nq15DuYziGlssPK185qHrFgVYTqPJC1vRgJjDx29yX8zbRaPmXPHyyBQyN6eNWifHJZRZpJEbT3nBOJc6h+q/U5EzC2slCOBfuQLcjZUFxAz0XH/HUu5tSwtbRti2PmtDxgkY84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752098684; c=relaxed/simple;
	bh=l01raLhrgWxKZGT51Vpgfm2vQgkg1culttpGXCmFA9Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eFWRsy+GJ7N4PNCJwYoIsvQtDGyT/sCl8G7HVng58DNcgPK+ILHc4B0/5p3Q15I/SCCEWpvP4VNQrDMW4MlK7wzyY/spWgV9kVQe5DydpcVeK4jEsj+X5S1e0/7+8z71AXC9AmN0WY3brxj4KbX4h3CODnR+82SpYENbCKL+hCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bHLM72pi; arc=none smtp.client-ip=209.85.219.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f196.google.com with SMTP id 3f1490d57ef6-e84207a8aa3so206141276.3
        for <linux-btrfs@vger.kernel.org>; Wed, 09 Jul 2025 15:04:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752098680; x=1752703480; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qsSYGozWFdpGEGBQMkn01kOyDQeVUwhDKxuSkwj52OA=;
        b=bHLM72pizVoTYfa6LR0XKSHiq4JvJm3drbiAKOHY/cdgoZ9TSKLG8zZgmU1OT0s6yy
         alPrALX4HB/ku6//tTK7GhZP6qKk/5Db31oNsLtcyZCT3zq23OqfZXj2WsuLM5UYht8Z
         DlDy/1378+3nlGUh0sWKDLnUqpKuhAuThdaidmjkDlxq/bZOUWvHwq0PJdGc9Of9kbeT
         +RN0ohAH8kc/6m3+AtwW3sIYyulGMzzFuLZ+ASGWQ99QARtc53GlcKIcrT6N02FMnHxu
         dziaWfu9KNJ6PgeLfKiCx0WIF0fi4B4Cj/lcoUXMyEOjA8CsFoyTAF7VTYf34cfWDZR+
         kSqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752098680; x=1752703480;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qsSYGozWFdpGEGBQMkn01kOyDQeVUwhDKxuSkwj52OA=;
        b=QcsFidRmoe9b6XVoIy8lV3HD5fX50p7dhBaSj+loGlpGClsLRwLKmYbJc0SlY7VlcB
         ko/59BMbNjM1RJaBVXic6AC38beKJN2ILVEBRZSONbnDFjRzWrBslr7N0HEoDbDvJsbI
         ZZHUhNXpLsdCVtzMRhf8KpPoQpCtTnyV55qjH5CZ2un1taqUQcmg1Q7q3deKhgqzyWvS
         LXFuoAKKOOI6u+LRDVb9clnv8UPwYFGWVmUrCDLTjEzPoLwTUye1IlYiAW9rmInbTsdz
         xLWchopOYwMK8hCP/Vi+Xq/FtKvv5zbolRx4ZfhaOzT5eZTCYEgEdUDFz0RnrTLn8/nM
         GndA==
X-Gm-Message-State: AOJu0YwtXi2joIwZkypcNUzQZ0AAypLyD6wuRMigEogsvwAWuIzCygaG
	yhbzLibkZ1sXr392gHvNJK4yE6+8azoatbIT8Xhws8JxMMnlQfjT+DVPVBHK3a5J
X-Gm-Gg: ASbGncusLlq5sd7nOqhC/Ltc/KVg5Yu/fHy9UCBz1X8yOawwna5gsB4N2XtpfaHDQJE
	r9NQFUytLORD/SMzN6uwozZFfNwM4ggn89Q15JG0AZwCdbxA2WbII4BAZGNlFwbFhrzEJW8Ms8B
	WG42QImwXKz1VTv+qNv5hGAGa5US/Halw85sAKddqpMnU+1P3XtfKPFQ4V7CQBtvXYa7jz3Tm7x
	xCyP5R6Zu/bt/pxzRotVx3Dd609RVTjtEi53PS56LiBPuofPAeBA9LRQ24mSpsTQYgiV70SvfZi
	ywtAI0+ZZVag0XRgq9uy6L8Z9iSFP15P+WYrlK4SICsEWw1qQw2hOpwoGA==
X-Google-Smtp-Source: AGHT+IE6DsBOGgoulaoNfvjoiyv75MzC+D75dVEeShdVdTq3+uPC2gewRpBcPv+/vyROYnoBfsnmUA==
X-Received: by 2002:a05:6902:260a:b0:e7d:d037:c78b with SMTP id 3f1490d57ef6-e8b7a35a28bmr300429276.15.1752098680275;
        Wed, 09 Jul 2025 15:04:40 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:5e::])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e8b738e18edsm442447276.45.2025.07.09.15.04.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 15:04:39 -0700 (PDT)
From: Leo Martins <loemra.dev@gmail.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Cc: jlayton@kernel.org
Subject: [PATCH] btrfs: implement ref_tracker for delayed_nodes
Date: Wed,  9 Jul 2025 15:04:35 -0700
Message-ID: <fa19acf9dc38e93546183fc083c365cdb237e89b.1752098515.git.loemra.dev@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch tracks references to btrfs_delayed_nodes using ref_tracker.
This patch introduces some btrfs_delayed_node_ref_tracker_* wrappers
around ref_tracker structures and functions. The wrappers ensure
that when the Kconfig is disabled everything compiles down to noops.
I was hesitant to lump this with BTRFS_DEBUG because of how expensive
it is, so I introduced a new Kconfig "BTRFS_DELAYED_NODE_REF_TRACKER".
If this isn't an issue I am happy to use BTRFS_DEBUG instead.

- btrfs_delayed_node_ref_tracker_dir
- btrfs_delayed_node_ref_tracker_dir_init()
- btrfs_delayed_node_ref_tracker_dir_exit()

- btrfs_delayed_node_ref_tracker
- btrfs_delayed_node_ref_tracker_alloc()
- btrfs_delayed_node_ref_tracker_free()

Along with being useful for tracking delayed node reference leaks,
this patch helps "document" via code where each ref count increase is
decreased.

Signed-off-by: Leo Martins <loemra.dev@gmail.com>
---
 fs/btrfs/Kconfig         |  14 +++
 fs/btrfs/delayed-inode.c | 209 ++++++++++++++++++++++++++++-----------
 fs/btrfs/delayed-inode.h |  56 ++++++++++-
 3 files changed, 218 insertions(+), 61 deletions(-)

diff --git a/fs/btrfs/Kconfig b/fs/btrfs/Kconfig
index c352f3ae0385c..d1bff4fdc8c05 100644
--- a/fs/btrfs/Kconfig
+++ b/fs/btrfs/Kconfig
@@ -72,6 +72,20 @@ config BTRFS_DEBUG
 
 	  If unsure, say N.
 
+config BTRFS_DELAYED_NODE_REF_TRACKER
+	bool "Btrfs delayed node reference tracking"
+	depends on BTRFS_DEBUG
+	select REF_TRACKER
+	help
+	  Enable run-time reference tracking for delayed nodes in btrfs filesystem.
+
+	  This option tracks stack traces when references to delayed nodes are taken
+	  and released. It will alert if there are outstanding references when a
+	  delayed node is freed. Note that enabling this option may negatively impact
+	  performance and is primarily intended for debugging purposes.
+
+	  If unsure, say N.
+
 config BTRFS_ASSERT
 	bool "Btrfs assert support"
 	depends on BTRFS_FS
diff --git a/fs/btrfs/delayed-inode.c b/fs/btrfs/delayed-inode.c
index 0f8d8e275143b..7e6e7532e70f5 100644
--- a/fs/btrfs/delayed-inode.c
+++ b/fs/btrfs/delayed-inode.c
@@ -4,6 +4,7 @@
  * Written by Miao Xie <miaox@cn.fujitsu.com>
  */
 
+#include "linux/gfp_types.h"
 #include <linux/slab.h>
 #include <linux/iversion.h>
 #include "ctree.h"
@@ -57,6 +58,8 @@ static inline void btrfs_init_delayed_node(
 	delayed_node->root = root;
 	delayed_node->inode_id = inode_id;
 	refcount_set(&delayed_node->refs, 0);
+	btrfs_delayed_node_ref_tracker_dir_init(&delayed_node->ref_dir, 16,
+						"delayed_node");
 	delayed_node->ins_root = RB_ROOT_CACHED;
 	delayed_node->del_root = RB_ROOT_CACHED;
 	mutex_init(&delayed_node->mutex);
@@ -64,8 +67,9 @@ static inline void btrfs_init_delayed_node(
 	INIT_LIST_HEAD(&delayed_node->p_list);
 }
 
-static struct btrfs_delayed_node *btrfs_get_delayed_node(
-		struct btrfs_inode *btrfs_inode)
+static struct btrfs_delayed_node *
+btrfs_get_delayed_node(struct btrfs_inode *btrfs_inode,
+		       btrfs_delayed_node_ref_tracker *tracker)
 {
 	struct btrfs_root *root = btrfs_inode->root;
 	u64 ino = btrfs_ino(btrfs_inode);
@@ -74,6 +78,8 @@ static struct btrfs_delayed_node *btrfs_get_delayed_node(
 	node = READ_ONCE(btrfs_inode->delayed_node);
 	if (node) {
 		refcount_inc(&node->refs);
+		btrfs_delayed_node_ref_tracker_alloc(&node->ref_dir, tracker,
+						     GFP_NOFS);
 		return node;
 	}
 
@@ -83,6 +89,8 @@ static struct btrfs_delayed_node *btrfs_get_delayed_node(
 	if (node) {
 		if (btrfs_inode->delayed_node) {
 			refcount_inc(&node->refs);	/* can be accessed */
+			btrfs_delayed_node_ref_tracker_alloc(
+				&node->ref_dir, tracker, GFP_ATOMIC);
 			BUG_ON(btrfs_inode->delayed_node != node);
 			xa_unlock(&root->delayed_nodes);
 			return node;
@@ -106,6 +114,11 @@ static struct btrfs_delayed_node *btrfs_get_delayed_node(
 		 */
 		if (refcount_inc_not_zero(&node->refs)) {
 			refcount_inc(&node->refs);
+			btrfs_delayed_node_ref_tracker_alloc(
+				&node->ref_dir, tracker, GFP_ATOMIC);
+			btrfs_delayed_node_ref_tracker_alloc(
+				&node->ref_dir, &node->inode_cache_tracker,
+				GFP_ATOMIC);
 			btrfs_inode->delayed_node = node;
 		} else {
 			node = NULL;
@@ -125,8 +138,9 @@ static struct btrfs_delayed_node *btrfs_get_delayed_node(
  *
  * Return the delayed node, or error pointer on failure.
  */
-static struct btrfs_delayed_node *btrfs_get_or_create_delayed_node(
-		struct btrfs_inode *btrfs_inode)
+static struct btrfs_delayed_node *
+btrfs_get_or_create_delayed_node(struct btrfs_inode *btrfs_inode,
+				 btrfs_delayed_node_ref_tracker *tracker)
 {
 	struct btrfs_delayed_node *node;
 	struct btrfs_root *root = btrfs_inode->root;
@@ -135,7 +149,7 @@ static struct btrfs_delayed_node *btrfs_get_or_create_delayed_node(
 	void *ptr;
 
 again:
-	node = btrfs_get_delayed_node(btrfs_inode);
+	node = btrfs_get_delayed_node(btrfs_inode, tracker);
 	if (node)
 		return node;
 
@@ -146,6 +160,9 @@ static struct btrfs_delayed_node *btrfs_get_or_create_delayed_node(
 
 	/* Cached in the inode and can be accessed. */
 	refcount_set(&node->refs, 2);
+	btrfs_delayed_node_ref_tracker_alloc(&node->ref_dir, tracker, GFP_NOFS);
+	btrfs_delayed_node_ref_tracker_alloc(
+		&node->ref_dir, &node->inode_cache_tracker, GFP_NOFS);
 
 	/* Allocate and reserve the slot, from now it can return a NULL from xa_load(). */
 	ret = xa_reserve(&root->delayed_nodes, ino, GFP_NOFS);
@@ -191,6 +208,8 @@ static void btrfs_queue_delayed_node(struct btrfs_delayed_root *root,
 		list_add_tail(&node->n_list, &root->node_list);
 		list_add_tail(&node->p_list, &root->prepare_list);
 		refcount_inc(&node->refs);	/* inserted into list */
+		btrfs_delayed_node_ref_tracker_alloc(
+			&node->ref_dir, &node->node_list_tracker, GFP_ATOMIC);
 		root->nodes++;
 		set_bit(BTRFS_DELAYED_NODE_IN_LIST, &node->flags);
 	}
@@ -204,6 +223,8 @@ static void btrfs_dequeue_delayed_node(struct btrfs_delayed_root *root,
 	spin_lock(&root->lock);
 	if (test_bit(BTRFS_DELAYED_NODE_IN_LIST, &node->flags)) {
 		root->nodes--;
+		btrfs_delayed_node_ref_tracker_free(&node->ref_dir,
+						    &node->node_list_tracker);
 		refcount_dec(&node->refs);	/* not in the list */
 		list_del_init(&node->n_list);
 		if (!list_empty(&node->p_list))
@@ -213,23 +234,28 @@ static void btrfs_dequeue_delayed_node(struct btrfs_delayed_root *root,
 	spin_unlock(&root->lock);
 }
 
-static struct btrfs_delayed_node *btrfs_first_delayed_node(
-			struct btrfs_delayed_root *delayed_root)
+static struct btrfs_delayed_node *
+btrfs_first_delayed_node(struct btrfs_delayed_root *delayed_root,
+			 btrfs_delayed_node_ref_tracker *tracker)
 {
 	struct btrfs_delayed_node *node;
 
 	spin_lock(&delayed_root->lock);
 	node = list_first_entry_or_null(&delayed_root->node_list,
 					struct btrfs_delayed_node, n_list);
-	if (node)
+	if (node) {
 		refcount_inc(&node->refs);
+		btrfs_delayed_node_ref_tracker_alloc(&node->ref_dir, tracker,
+						     GFP_ATOMIC);
+	}
 	spin_unlock(&delayed_root->lock);
 
 	return node;
 }
 
-static struct btrfs_delayed_node *btrfs_next_delayed_node(
-						struct btrfs_delayed_node *node)
+static struct btrfs_delayed_node *
+btrfs_next_delayed_node(struct btrfs_delayed_node *node,
+			btrfs_delayed_node_ref_tracker *tracker)
 {
 	struct btrfs_delayed_root *delayed_root;
 	struct list_head *p;
@@ -249,15 +275,17 @@ static struct btrfs_delayed_node *btrfs_next_delayed_node(
 
 	next = list_entry(p, struct btrfs_delayed_node, n_list);
 	refcount_inc(&next->refs);
+	btrfs_delayed_node_ref_tracker_alloc(&next->ref_dir, tracker,
+					     GFP_ATOMIC);
 out:
 	spin_unlock(&delayed_root->lock);
 
 	return next;
 }
 
-static void __btrfs_release_delayed_node(
-				struct btrfs_delayed_node *delayed_node,
-				int mod)
+static void
+__btrfs_release_delayed_node(struct btrfs_delayed_node *delayed_node, int mod,
+			     btrfs_delayed_node_ref_tracker *tracker)
 {
 	struct btrfs_delayed_root *delayed_root;
 
@@ -273,6 +301,7 @@ static void __btrfs_release_delayed_node(
 		btrfs_dequeue_delayed_node(delayed_root, delayed_node);
 	mutex_unlock(&delayed_node->mutex);
 
+	btrfs_delayed_node_ref_tracker_free(&delayed_node->ref_dir, tracker);
 	if (refcount_dec_and_test(&delayed_node->refs)) {
 		struct btrfs_root *root = delayed_node->root;
 
@@ -282,17 +311,21 @@ static void __btrfs_release_delayed_node(
 		 * back up.  We can delete it now.
 		 */
 		ASSERT(refcount_read(&delayed_node->refs) == 0);
+		btrfs_delayed_node_ref_tracker_dir_exit(&delayed_node->ref_dir);
 		kmem_cache_free(delayed_node_cache, delayed_node);
 	}
 }
 
-static inline void btrfs_release_delayed_node(struct btrfs_delayed_node *node)
+static inline void
+btrfs_release_delayed_node(struct btrfs_delayed_node *node,
+			   btrfs_delayed_node_ref_tracker *tracker)
 {
-	__btrfs_release_delayed_node(node, 0);
+	__btrfs_release_delayed_node(node, 0, tracker);
 }
 
-static struct btrfs_delayed_node *btrfs_first_prepared_delayed_node(
-					struct btrfs_delayed_root *delayed_root)
+static struct btrfs_delayed_node *
+btrfs_first_prepared_delayed_node(struct btrfs_delayed_root *delayed_root,
+				  btrfs_delayed_node_ref_tracker *tracker)
 {
 	struct btrfs_delayed_node *node;
 
@@ -302,16 +335,19 @@ static struct btrfs_delayed_node *btrfs_first_prepared_delayed_node(
 	if (node) {
 		list_del_init(&node->p_list);
 		refcount_inc(&node->refs);
+		btrfs_delayed_node_ref_tracker_alloc(&node->ref_dir, tracker,
+						     GFP_ATOMIC);
 	}
 	spin_unlock(&delayed_root->lock);
 
 	return node;
 }
 
-static inline void btrfs_release_prepared_delayed_node(
-					struct btrfs_delayed_node *node)
+static inline void
+btrfs_release_prepared_delayed_node(struct btrfs_delayed_node *node,
+				    btrfs_delayed_node_ref_tracker *tracker)
 {
-	__btrfs_release_delayed_node(node, 1);
+	__btrfs_release_delayed_node(node, 1, tracker);
 }
 
 static struct btrfs_delayed_item *btrfs_alloc_delayed_item(u16 data_len,
@@ -1126,6 +1162,8 @@ static int __btrfs_run_delayed_items(struct btrfs_trans_handle *trans, int nr)
 	struct btrfs_fs_info *fs_info = trans->fs_info;
 	struct btrfs_delayed_root *delayed_root;
 	struct btrfs_delayed_node *curr_node, *prev_node;
+	btrfs_delayed_node_ref_tracker curr_delayed_node_tracker,
+		prev_delayed_node_tracker;
 	struct btrfs_path *path;
 	struct btrfs_block_rsv *block_rsv;
 	int ret = 0;
@@ -1143,7 +1181,8 @@ static int __btrfs_run_delayed_items(struct btrfs_trans_handle *trans, int nr)
 
 	delayed_root = fs_info->delayed_root;
 
-	curr_node = btrfs_first_delayed_node(delayed_root);
+	curr_node = btrfs_first_delayed_node(delayed_root,
+					     &curr_delayed_node_tracker);
 	while (curr_node && (!count || nr--)) {
 		ret = __btrfs_commit_inode_delayed_items(trans, path,
 							 curr_node);
@@ -1153,7 +1192,9 @@ static int __btrfs_run_delayed_items(struct btrfs_trans_handle *trans, int nr)
 		}
 
 		prev_node = curr_node;
-		curr_node = btrfs_next_delayed_node(curr_node);
+		prev_delayed_node_tracker = curr_delayed_node_tracker;
+		curr_node = btrfs_next_delayed_node(curr_node,
+						    &curr_delayed_node_tracker);
 		/*
 		 * See the comment below about releasing path before releasing
 		 * node. If the commit of delayed items was successful the path
@@ -1161,7 +1202,8 @@ static int __btrfs_run_delayed_items(struct btrfs_trans_handle *trans, int nr)
 		 * point to locked extent buffers (a leaf at the very least).
 		 */
 		ASSERT(path->nodes[0] == NULL);
-		btrfs_release_delayed_node(prev_node);
+		btrfs_release_delayed_node(prev_node,
+					   &prev_delayed_node_tracker);
 	}
 
 	/*
@@ -1174,7 +1216,8 @@ static int __btrfs_run_delayed_items(struct btrfs_trans_handle *trans, int nr)
 	btrfs_free_path(path);
 
 	if (curr_node)
-		btrfs_release_delayed_node(curr_node);
+		btrfs_release_delayed_node(curr_node,
+					   &curr_delayed_node_tracker);
 	trans->block_rsv = block_rsv;
 
 	return ret;
@@ -1193,7 +1236,9 @@ int btrfs_run_delayed_items_nr(struct btrfs_trans_handle *trans, int nr)
 int btrfs_commit_inode_delayed_items(struct btrfs_trans_handle *trans,
 				     struct btrfs_inode *inode)
 {
-	struct btrfs_delayed_node *delayed_node = btrfs_get_delayed_node(inode);
+	btrfs_delayed_node_ref_tracker delayed_node_tracker;
+	struct btrfs_delayed_node *delayed_node =
+		btrfs_get_delayed_node(inode, &delayed_node_tracker);
 	BTRFS_PATH_AUTO_FREE(path);
 	struct btrfs_block_rsv *block_rsv;
 	int ret;
@@ -1204,14 +1249,14 @@ int btrfs_commit_inode_delayed_items(struct btrfs_trans_handle *trans,
 	mutex_lock(&delayed_node->mutex);
 	if (!delayed_node->count) {
 		mutex_unlock(&delayed_node->mutex);
-		btrfs_release_delayed_node(delayed_node);
+		btrfs_release_delayed_node(delayed_node, &delayed_node_tracker);
 		return 0;
 	}
 	mutex_unlock(&delayed_node->mutex);
 
 	path = btrfs_alloc_path();
 	if (!path) {
-		btrfs_release_delayed_node(delayed_node);
+		btrfs_release_delayed_node(delayed_node, &delayed_node_tracker);
 		return -ENOMEM;
 	}
 
@@ -1220,7 +1265,7 @@ int btrfs_commit_inode_delayed_items(struct btrfs_trans_handle *trans,
 
 	ret = __btrfs_commit_inode_delayed_items(trans, path, delayed_node);
 
-	btrfs_release_delayed_node(delayed_node);
+	btrfs_release_delayed_node(delayed_node, &delayed_node_tracker);
 	trans->block_rsv = block_rsv;
 
 	return ret;
@@ -1230,7 +1275,9 @@ int btrfs_commit_inode_delayed_inode(struct btrfs_inode *inode)
 {
 	struct btrfs_fs_info *fs_info = inode->root->fs_info;
 	struct btrfs_trans_handle *trans;
-	struct btrfs_delayed_node *delayed_node = btrfs_get_delayed_node(inode);
+	btrfs_delayed_node_ref_tracker delayed_node_tracker;
+	struct btrfs_delayed_node *delayed_node =
+		btrfs_get_delayed_node(inode, &delayed_node_tracker);
 	struct btrfs_path *path;
 	struct btrfs_block_rsv *block_rsv;
 	int ret;
@@ -1241,7 +1288,7 @@ int btrfs_commit_inode_delayed_inode(struct btrfs_inode *inode)
 	mutex_lock(&delayed_node->mutex);
 	if (!test_bit(BTRFS_DELAYED_NODE_INODE_DIRTY, &delayed_node->flags)) {
 		mutex_unlock(&delayed_node->mutex);
-		btrfs_release_delayed_node(delayed_node);
+		btrfs_release_delayed_node(delayed_node, &delayed_node_tracker);
 		return 0;
 	}
 	mutex_unlock(&delayed_node->mutex);
@@ -1275,7 +1322,7 @@ int btrfs_commit_inode_delayed_inode(struct btrfs_inode *inode)
 	btrfs_end_transaction(trans);
 	btrfs_btree_balance_dirty(fs_info);
 out:
-	btrfs_release_delayed_node(delayed_node);
+	btrfs_release_delayed_node(delayed_node, &delayed_node_tracker);
 
 	return ret;
 }
@@ -1289,7 +1336,8 @@ void btrfs_remove_delayed_node(struct btrfs_inode *inode)
 		return;
 
 	inode->delayed_node = NULL;
-	btrfs_release_delayed_node(delayed_node);
+	btrfs_release_delayed_node(delayed_node,
+				   &delayed_node->inode_cache_tracker);
 }
 
 struct btrfs_async_delayed_work {
@@ -1305,6 +1353,7 @@ static void btrfs_async_run_delayed_root(struct btrfs_work *work)
 	struct btrfs_trans_handle *trans;
 	struct btrfs_path *path;
 	struct btrfs_delayed_node *delayed_node = NULL;
+	btrfs_delayed_node_ref_tracker delayed_node_tracker;
 	struct btrfs_root *root;
 	struct btrfs_block_rsv *block_rsv;
 	int total_done = 0;
@@ -1321,7 +1370,8 @@ static void btrfs_async_run_delayed_root(struct btrfs_work *work)
 		    BTRFS_DELAYED_BACKGROUND / 2)
 			break;
 
-		delayed_node = btrfs_first_prepared_delayed_node(delayed_root);
+		delayed_node = btrfs_first_prepared_delayed_node(
+			delayed_root, &delayed_node_tracker);
 		if (!delayed_node)
 			break;
 
@@ -1330,7 +1380,8 @@ static void btrfs_async_run_delayed_root(struct btrfs_work *work)
 		trans = btrfs_join_transaction(root);
 		if (IS_ERR(trans)) {
 			btrfs_release_path(path);
-			btrfs_release_prepared_delayed_node(delayed_node);
+			btrfs_release_prepared_delayed_node(
+				delayed_node, &delayed_node_tracker);
 			total_done++;
 			continue;
 		}
@@ -1345,7 +1396,8 @@ static void btrfs_async_run_delayed_root(struct btrfs_work *work)
 		btrfs_btree_balance_dirty_nodelay(root->fs_info);
 
 		btrfs_release_path(path);
-		btrfs_release_prepared_delayed_node(delayed_node);
+		btrfs_release_prepared_delayed_node(delayed_node,
+						    &delayed_node_tracker);
 		total_done++;
 
 	} while ((async_work->nr == 0 && total_done < BTRFS_DELAYED_WRITEBACK)
@@ -1377,10 +1429,15 @@ static int btrfs_wq_run_delayed_node(struct btrfs_delayed_root *delayed_root,
 
 void btrfs_assert_delayed_root_empty(struct btrfs_fs_info *fs_info)
 {
-	struct btrfs_delayed_node *node = btrfs_first_delayed_node(fs_info->delayed_root);
+	btrfs_delayed_node_ref_tracker delayed_node_tracker;
+	struct btrfs_delayed_node *node = btrfs_first_delayed_node(
+		fs_info->delayed_root, &delayed_node_tracker);
 
-	if (WARN_ON(node))
+	if (WARN_ON(node)) {
+		btrfs_delayed_node_ref_tracker_free(&node->ref_dir,
+						    &delayed_node_tracker);
 		refcount_dec(&node->refs);
+	}
 }
 
 static bool could_end_wait(struct btrfs_delayed_root *delayed_root, int seq)
@@ -1454,13 +1511,15 @@ int btrfs_insert_delayed_dir_index(struct btrfs_trans_handle *trans,
 	struct btrfs_fs_info *fs_info = trans->fs_info;
 	const unsigned int leaf_data_size = BTRFS_LEAF_DATA_SIZE(fs_info);
 	struct btrfs_delayed_node *delayed_node;
+	btrfs_delayed_node_ref_tracker delayed_node_tracker;
 	struct btrfs_delayed_item *delayed_item;
 	struct btrfs_dir_item *dir_item;
 	bool reserve_leaf_space;
 	u32 data_len;
 	int ret;
 
-	delayed_node = btrfs_get_or_create_delayed_node(dir);
+	delayed_node =
+		btrfs_get_or_create_delayed_node(dir, &delayed_node_tracker);
 	if (IS_ERR(delayed_node))
 		return PTR_ERR(delayed_node);
 
@@ -1536,7 +1595,7 @@ int btrfs_insert_delayed_dir_index(struct btrfs_trans_handle *trans,
 	mutex_unlock(&delayed_node->mutex);
 
 release_node:
-	btrfs_release_delayed_node(delayed_node);
+	btrfs_release_delayed_node(delayed_node, &delayed_node_tracker);
 	return ret;
 }
 
@@ -1591,10 +1650,11 @@ int btrfs_delete_delayed_dir_index(struct btrfs_trans_handle *trans,
 				   struct btrfs_inode *dir, u64 index)
 {
 	struct btrfs_delayed_node *node;
+	btrfs_delayed_node_ref_tracker delayed_node_tracker;
 	struct btrfs_delayed_item *item;
 	int ret;
 
-	node = btrfs_get_or_create_delayed_node(dir);
+	node = btrfs_get_or_create_delayed_node(dir, &delayed_node_tracker);
 	if (IS_ERR(node))
 		return PTR_ERR(node);
 
@@ -1635,13 +1695,15 @@ int btrfs_delete_delayed_dir_index(struct btrfs_trans_handle *trans,
 	}
 	mutex_unlock(&node->mutex);
 end:
-	btrfs_release_delayed_node(node);
+	btrfs_release_delayed_node(node, &delayed_node_tracker);
 	return ret;
 }
 
 int btrfs_inode_delayed_dir_index_count(struct btrfs_inode *inode)
 {
-	struct btrfs_delayed_node *delayed_node = btrfs_get_delayed_node(inode);
+	btrfs_delayed_node_ref_tracker delayed_node_tracker;
+	struct btrfs_delayed_node *delayed_node =
+		btrfs_get_delayed_node(inode, &delayed_node_tracker);
 
 	if (!delayed_node)
 		return -ENOENT;
@@ -1652,12 +1714,12 @@ int btrfs_inode_delayed_dir_index_count(struct btrfs_inode *inode)
 	 * is updated now. So we needn't lock the delayed node.
 	 */
 	if (!delayed_node->index_cnt) {
-		btrfs_release_delayed_node(delayed_node);
+		btrfs_release_delayed_node(delayed_node, &delayed_node_tracker);
 		return -EINVAL;
 	}
 
 	inode->index_cnt = delayed_node->index_cnt;
-	btrfs_release_delayed_node(delayed_node);
+	btrfs_release_delayed_node(delayed_node, &delayed_node_tracker);
 	return 0;
 }
 
@@ -1668,8 +1730,9 @@ bool btrfs_readdir_get_delayed_items(struct btrfs_inode *inode,
 {
 	struct btrfs_delayed_node *delayed_node;
 	struct btrfs_delayed_item *item;
+	btrfs_delayed_node_ref_tracker delayed_node_tracker;
 
-	delayed_node = btrfs_get_delayed_node(inode);
+	delayed_node = btrfs_get_delayed_node(inode, &delayed_node_tracker);
 	if (!delayed_node)
 		return false;
 
@@ -1704,6 +1767,8 @@ bool btrfs_readdir_get_delayed_items(struct btrfs_inode *inode,
 	 * insert/delete delayed items in this period. So we also needn't
 	 * requeue or dequeue this delayed node.
 	 */
+	btrfs_delayed_node_ref_tracker_free(&delayed_node->ref_dir,
+					    &delayed_node_tracker);
 	refcount_dec(&delayed_node->refs);
 
 	return true;
@@ -1845,17 +1910,18 @@ int btrfs_fill_inode(struct btrfs_inode *inode, u32 *rdev)
 {
 	struct btrfs_fs_info *fs_info = inode->root->fs_info;
 	struct btrfs_delayed_node *delayed_node;
+	btrfs_delayed_node_ref_tracker delayed_node_tracker;
 	struct btrfs_inode_item *inode_item;
 	struct inode *vfs_inode = &inode->vfs_inode;
 
-	delayed_node = btrfs_get_delayed_node(inode);
+	delayed_node = btrfs_get_delayed_node(inode, &delayed_node_tracker);
 	if (!delayed_node)
 		return -ENOENT;
 
 	mutex_lock(&delayed_node->mutex);
 	if (!test_bit(BTRFS_DELAYED_NODE_INODE_DIRTY, &delayed_node->flags)) {
 		mutex_unlock(&delayed_node->mutex);
-		btrfs_release_delayed_node(delayed_node);
+		btrfs_release_delayed_node(delayed_node, &delayed_node_tracker);
 		return -ENOENT;
 	}
 
@@ -1895,7 +1961,7 @@ int btrfs_fill_inode(struct btrfs_inode *inode, u32 *rdev)
 		inode->index_cnt = (u64)-1;
 
 	mutex_unlock(&delayed_node->mutex);
-	btrfs_release_delayed_node(delayed_node);
+	btrfs_release_delayed_node(delayed_node, &delayed_node_tracker);
 	return 0;
 }
 
@@ -1904,9 +1970,11 @@ int btrfs_delayed_update_inode(struct btrfs_trans_handle *trans,
 {
 	struct btrfs_root *root = inode->root;
 	struct btrfs_delayed_node *delayed_node;
+	btrfs_delayed_node_ref_tracker delayed_node_tracker;
 	int ret = 0;
 
-	delayed_node = btrfs_get_or_create_delayed_node(inode);
+	delayed_node =
+		btrfs_get_or_create_delayed_node(inode, &delayed_node_tracker);
 	if (IS_ERR(delayed_node))
 		return PTR_ERR(delayed_node);
 
@@ -1926,7 +1994,7 @@ int btrfs_delayed_update_inode(struct btrfs_trans_handle *trans,
 	atomic_inc(&root->fs_info->delayed_root->items);
 release_node:
 	mutex_unlock(&delayed_node->mutex);
-	btrfs_release_delayed_node(delayed_node);
+	btrfs_release_delayed_node(delayed_node, &delayed_node_tracker);
 	return ret;
 }
 
@@ -1934,6 +2002,7 @@ int btrfs_delayed_delete_inode_ref(struct btrfs_inode *inode)
 {
 	struct btrfs_fs_info *fs_info = inode->root->fs_info;
 	struct btrfs_delayed_node *delayed_node;
+	btrfs_delayed_node_ref_tracker delayed_node_tracker;
 
 	/*
 	 * we don't do delayed inode updates during log recovery because it
@@ -1943,7 +2012,8 @@ int btrfs_delayed_delete_inode_ref(struct btrfs_inode *inode)
 	if (test_bit(BTRFS_FS_LOG_RECOVERING, &fs_info->flags))
 		return -EAGAIN;
 
-	delayed_node = btrfs_get_or_create_delayed_node(inode);
+	delayed_node =
+		btrfs_get_or_create_delayed_node(inode, &delayed_node_tracker);
 	if (IS_ERR(delayed_node))
 		return PTR_ERR(delayed_node);
 
@@ -1970,7 +2040,7 @@ int btrfs_delayed_delete_inode_ref(struct btrfs_inode *inode)
 	atomic_inc(&fs_info->delayed_root->items);
 release_node:
 	mutex_unlock(&delayed_node->mutex);
-	btrfs_release_delayed_node(delayed_node);
+	btrfs_release_delayed_node(delayed_node, &delayed_node_tracker);
 	return 0;
 }
 
@@ -2014,19 +2084,21 @@ static void __btrfs_kill_delayed_node(struct btrfs_delayed_node *delayed_node)
 void btrfs_kill_delayed_inode_items(struct btrfs_inode *inode)
 {
 	struct btrfs_delayed_node *delayed_node;
+	btrfs_delayed_node_ref_tracker delayed_node_tracker;
 
-	delayed_node = btrfs_get_delayed_node(inode);
+	delayed_node = btrfs_get_delayed_node(inode, &delayed_node_tracker);
 	if (!delayed_node)
 		return;
 
 	__btrfs_kill_delayed_node(delayed_node);
-	btrfs_release_delayed_node(delayed_node);
+	btrfs_release_delayed_node(delayed_node, &delayed_node_tracker);
 }
 
 void btrfs_kill_all_delayed_nodes(struct btrfs_root *root)
 {
 	unsigned long index = 0;
 	struct btrfs_delayed_node *delayed_nodes[8];
+	btrfs_delayed_node_ref_tracker delayed_node_trackers[8];
 
 	while (1) {
 		struct btrfs_delayed_node *node;
@@ -2045,6 +2117,10 @@ void btrfs_kill_all_delayed_nodes(struct btrfs_root *root)
 			 * about to be removed from the tree in the loop below
 			 */
 			if (refcount_inc_not_zero(&node->refs)) {
+				btrfs_delayed_node_ref_tracker_alloc(
+					&node->ref_dir,
+					&delayed_node_trackers[count],
+					GFP_ATOMIC);
 				delayed_nodes[count] = node;
 				count++;
 			}
@@ -2056,7 +2132,8 @@ void btrfs_kill_all_delayed_nodes(struct btrfs_root *root)
 
 		for (int i = 0; i < count; i++) {
 			__btrfs_kill_delayed_node(delayed_nodes[i]);
-			btrfs_release_delayed_node(delayed_nodes[i]);
+			btrfs_release_delayed_node(delayed_nodes[i],
+						   &delayed_node_trackers[i]);
 		}
 	}
 }
@@ -2064,14 +2141,20 @@ void btrfs_kill_all_delayed_nodes(struct btrfs_root *root)
 void btrfs_destroy_delayed_inodes(struct btrfs_fs_info *fs_info)
 {
 	struct btrfs_delayed_node *curr_node, *prev_node;
+	btrfs_delayed_node_ref_tracker curr_delayed_node_tracker,
+		prev_delayed_node_tracker;
 
-	curr_node = btrfs_first_delayed_node(fs_info->delayed_root);
+	curr_node = btrfs_first_delayed_node(fs_info->delayed_root,
+					     &curr_delayed_node_tracker);
 	while (curr_node) {
 		__btrfs_kill_delayed_node(curr_node);
 
 		prev_node = curr_node;
-		curr_node = btrfs_next_delayed_node(curr_node);
-		btrfs_release_delayed_node(prev_node);
+		prev_delayed_node_tracker = curr_delayed_node_tracker;
+		curr_node = btrfs_next_delayed_node(curr_node,
+						    &curr_delayed_node_tracker);
+		btrfs_release_delayed_node(prev_node,
+					   &prev_delayed_node_tracker);
 	}
 }
 
@@ -2081,8 +2164,9 @@ void btrfs_log_get_delayed_items(struct btrfs_inode *inode,
 {
 	struct btrfs_delayed_node *node;
 	struct btrfs_delayed_item *item;
+	btrfs_delayed_node_ref_tracker delayed_node_tracker;
 
-	node = btrfs_get_delayed_node(inode);
+	node = btrfs_get_delayed_node(inode, &delayed_node_tracker);
 	if (!node)
 		return;
 
@@ -2140,6 +2224,8 @@ void btrfs_log_get_delayed_items(struct btrfs_inode *inode,
 	 * delete delayed items.
 	 */
 	ASSERT(refcount_read(&node->refs) > 1);
+	btrfs_delayed_node_ref_tracker_free(&node->ref_dir,
+					    &delayed_node_tracker);
 	refcount_dec(&node->refs);
 }
 
@@ -2150,8 +2236,9 @@ void btrfs_log_put_delayed_items(struct btrfs_inode *inode,
 	struct btrfs_delayed_node *node;
 	struct btrfs_delayed_item *item;
 	struct btrfs_delayed_item *next;
+	btrfs_delayed_node_ref_tracker delayed_node_tracker;
 
-	node = btrfs_get_delayed_node(inode);
+	node = btrfs_get_delayed_node(inode, &delayed_node_tracker);
 	if (!node)
 		return;
 
@@ -2183,5 +2270,7 @@ void btrfs_log_put_delayed_items(struct btrfs_inode *inode,
 	 * delete delayed items.
 	 */
 	ASSERT(refcount_read(&node->refs) > 1);
+	btrfs_delayed_node_ref_tracker_free(&node->ref_dir,
+					    &delayed_node_tracker);
 	refcount_dec(&node->refs);
 }
diff --git a/fs/btrfs/delayed-inode.h b/fs/btrfs/delayed-inode.h
index e6e763ad2d421..d7e0ec020c4d0 100644
--- a/fs/btrfs/delayed-inode.h
+++ b/fs/btrfs/delayed-inode.h
@@ -7,6 +7,7 @@
 #ifndef BTRFS_DELAYED_INODE_H
 #define BTRFS_DELAYED_INODE_H
 
+#include "linux/ref_tracker.h"
 #include <linux/types.h>
 #include <linux/rbtree.h>
 #include <linux/spinlock.h>
@@ -44,6 +45,51 @@ struct btrfs_delayed_root {
 	wait_queue_head_t wait;
 };
 
+#ifdef CONFIG_BTRFS_DELAYED_NODE_REF_TRACKER
+typedef struct ref_tracker *btrfs_delayed_node_ref_tracker;
+typedef struct ref_tracker_dir btrfs_delayed_node_ref_tracker_dir;
+#else
+typedef struct {} btrfs_delayed_node_ref_tracker;
+typedef struct {} btrfs_delayed_node_ref_tracker_dir;
+#endif
+
+static inline void btrfs_delayed_node_ref_tracker_dir_init(btrfs_delayed_node_ref_tracker_dir *dir, 
+						       unsigned int quarantine_count,
+						       const char *name)
+{
+#ifdef CONFIG_BTRFS_DELAYED_NODE_REF_TRACKER
+	ref_tracker_dir_init(dir, quarantine_count, name);
+#endif
+}
+
+static inline void btrfs_delayed_node_ref_tracker_dir_exit(btrfs_delayed_node_ref_tracker_dir *dir)
+{
+#ifdef CONFIG_BTRFS_DELAYED_NODE_REF_TRACKER
+	ref_tracker_dir_exit(dir);
+#endif
+}
+
+static inline int btrfs_delayed_node_ref_tracker_alloc(btrfs_delayed_node_ref_tracker_dir *dir,
+						    btrfs_delayed_node_ref_tracker *tracker,
+						    gfp_t gfp)
+{
+#ifdef CONFIG_BTRFS_DELAYED_NODE_REF_TRACKER
+	return ref_tracker_alloc(dir, tracker, gfp);
+#else
+	return 0;
+#endif
+}
+
+static inline int btrfs_delayed_node_ref_tracker_free(btrfs_delayed_node_ref_tracker_dir *dir,
+						   btrfs_delayed_node_ref_tracker *tracker)
+{
+#ifdef CONFIG_BTRFS_DELAYED_NODE_REF_TRACKER
+	return ref_tracker_free(dir, tracker);
+#else
+	return 0;
+#endif
+}
+
 #define BTRFS_DELAYED_NODE_IN_LIST	0
 #define BTRFS_DELAYED_NODE_INODE_DIRTY	1
 #define BTRFS_DELAYED_NODE_DEL_IREF	2
@@ -63,10 +109,18 @@ struct btrfs_delayed_node {
 	struct rb_root_cached del_root;
 	struct mutex mutex;
 	struct btrfs_inode_item inode_item;
+
 	refcount_t refs;
-	int count;
+	/* Used to track all references to this delayed node. */
+	btrfs_delayed_node_ref_tracker_dir ref_dir;
+	/* Used to track delayed node reference stored in node list. */
+	btrfs_delayed_node_ref_tracker node_list_tracker;
+	/* Used to track delayed node reference stored in inode cache. */
+	btrfs_delayed_node_ref_tracker inode_cache_tracker;
+
 	u64 index_cnt;
 	unsigned long flags;
+	int count;
 	/*
 	 * The size of the next batch of dir index items to insert (if this
 	 * node is from a directory inode). Protected by @mutex.
-- 
2.47.1


