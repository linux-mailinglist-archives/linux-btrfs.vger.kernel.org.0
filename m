Return-Path: <linux-btrfs+bounces-16035-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A105B23C31
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Aug 2025 01:05:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57B7C1AA77DB
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Aug 2025 23:05:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB1712D9EF3;
	Tue, 12 Aug 2025 23:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NrV77Z+j"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yb1-f195.google.com (mail-yb1-f195.google.com [209.85.219.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A24621DF27F
	for <linux-btrfs@vger.kernel.org>; Tue, 12 Aug 2025 23:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755039891; cv=none; b=ZXCxykF7O12BQLGYwONE50QVCEmd/Nn6l9z+bHaRQMKGAWn5d0KT+GxXwuKqQnVQ0qyhNEfhA9o1Oo3jLd7CbLMiDOV9f7FH1wLcabQAOYLN9ts1ChYy/fhFGaxk1u+sX3kFvQTsH6wdp5348BNyza2n4YmSL0b1Ou7VC50SqxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755039891; c=relaxed/simple;
	bh=w5XERuX5gniOMmZ14yPq8RGXBWol4D7eqtsWBFV1Flg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZkvYN1IaWSUBKGwz6qQPTazRK/cKFFI2jqM42waNSUFYFy/savRvAwRD86KhnUzsiPI6WgfJwcNPrljofmbvVuUBBbGICC7kQxHwMYQM/6vtieH5YCY8p4q58PG+zxp8yA8YzfH/lXliarIxOnEGfHm78GOjzl0L/3KhaUCkNuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NrV77Z+j; arc=none smtp.client-ip=209.85.219.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f195.google.com with SMTP id 3f1490d57ef6-e90941d1675so2458471276.1
        for <linux-btrfs@vger.kernel.org>; Tue, 12 Aug 2025 16:04:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755039887; x=1755644687; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FDiXWzti2UC8b2ndVxMgIIoUvV1NdojuSw9xyyrmY00=;
        b=NrV77Z+jU4Wc1EHJojByQj6MqfHekMHqAVWwBBkxI/1vpiM6f0Cx206vCw2b+pTxgq
         I1SvLFOYJqeiZ6hT4x3m/+E3cTY1AfllfD4nvSTm0sVPy2Nc7bBMmbkfBHS2ilZdAALS
         uSZRv4IiJXlSPEdEvcrEMUnTb/qL22giWKaZK608ICg3G85Lg7WoGLtadR5EQqGHAf4B
         3xFTTtmTx1JHAhghB+a9tgBNrAsb4750/8YBQklR/yKuJmuRh5lgeQ7+zoWm/lfBCJy9
         178mxk8gi3IJWwhHt09r7bCgXrbG5tXoXnr6rcps1YtcNvlnPRDhvSNgQrtOp7WcEOfE
         IflA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755039887; x=1755644687;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FDiXWzti2UC8b2ndVxMgIIoUvV1NdojuSw9xyyrmY00=;
        b=qzV0iS69XCKc+LGSHqxAQoN+9QjKpHQ52bWvwjvn+04pVhe7dooW1OelCjtsVDRzyN
         0Itg1sRVwCtCZq+wOUkpn88xEKN/bE4HBTqPv/48D9cnqWmGaTeJzGKrHkCEYuHoRxkg
         vyBOzUn74kETuaJ6YNa9x9ch+Qa0YfEcPGxfL348eMi1EbBgvGwGJWzdyC8tXkoUKkQh
         K8jrzpwYC3eQGgksV75UOLke0JtcqcLJ4nvAx+0WrYR64L1EUnrXSOZt6M9XpYmj5bKH
         mozXaDhS9qNupnHMr03knytW0z/ME2+1lyfRSwx0E9tCZS2eW5FqlZoIDXBWvevQc75Q
         LwhQ==
X-Gm-Message-State: AOJu0YypHz1U+6IwtzsCMVTvc8i0CpaWxEMdLXs7D06+ZXqzBAJDjtlr
	LOxI/5OlKsmc/9UARoqX1GH7pXGkSvdSw9jThzQW5rsbOrcK34ohQYBJFfYXsShk
X-Gm-Gg: ASbGncvlcGkmTu0QMDA5ODvy1sDfoNtvP0YB3nBuxSTb7Usg/DpkFSV2/JaHegehk2x
	ox0vnlnI8OaEo2NdTV289Jn8YQZp8W2fAEMimRiHFCq7OmGBkLNju5Hheq+mcTRg5Cn91BzEfDB
	EszotOXUBsea8R30qjha44DHntCvjpbaTZjstn54cv95m7tjbU3FKclMqfX2ewiY95hPtUZBHZq
	FQjO725VbX4qEyihJy+oobCw+VSsByQVmI1vKoR2JrH+6D67T1kvnZ5UlAaUvgYWFp8ZfDlbHBD
	aiAaxYa7GEYzY8THlpWJ1D7VjujlonK8NhAsbVqy9fQYan3nkTREQ7JBAD+B854Qo6dW7k55Gd5
	kWZkbLOQZ1FfGK0DL7w==
X-Google-Smtp-Source: AGHT+IG7hZjyD8eH+9GV7Ou6fsLgeTgsi1AnkZ7g15gdKboSzGmhL3kJLtwYvo/AiUO8NzjHQwU5HA==
X-Received: by 2002:a05:6902:2602:b0:e8b:520f:62b0 with SMTP id 3f1490d57ef6-e930c0aca93mr1581241276.44.1755039886990;
        Tue, 12 Aug 2025 16:04:46 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:70::])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e90613ca6c3sm3285290276.2.2025.08.12.16.04.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 16:04:46 -0700 (PDT)
From: Leo Martins <loemra.dev@gmail.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH v4 1/3] btrfs: implement ref_tracker for delayed_nodes
Date: Tue, 12 Aug 2025 16:04:39 -0700
Message-ID: <f97312e56638279c286304398526b5d4dfb15d88.1755035080.git.loemra.dev@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1755035080.git.loemra.dev@gmail.com>
References: <cover.1755035080.git.loemra.dev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch adds ref_tracker infrastructure for btrfs_delayed_node.

It is a response to the largest btrfs related crash in our fleet.
We're seeing softlockups in btrfs_kill_all_delayed_nodes that seem
to be a result of delayed_nodes not being released properly.

A ref_tracker object is allocated on reference count increases and
freed on reference count decreases. The ref_tracker object stores
a stack trace of where it is allocated. The ref_tracker_dir object
is embedded in btrfs_delayed_node and keeps track of all current
and some old/freed ref_tracker objects. When a leak is detected
we can print the stack traces for all ref_trackers that have not
yet been freed.

Here is a common example of taking a reference to a delayed_node
and freeing it with ref_tracker.

```C
struct btrfs_ref_tracker tracker;
struct btrfs_delayed_node *node;

node = btrfs_get_delayed_node(inode, &tracker);
// use delayed_node...
btrfs_release_delayed_node(node, &tracker);
```

There are two special cases where the delayed_node reference is "long
lived", meaning that the thread that takes the reference and the thread
that releases the reference are different. The `inode_cache_tracker`
tracks the delayed_node stored in btrfs_inode. The `node_list_tracker`
tracks the delayed_node stored in the btrfs_delayed_root
node_list/prepare_list. These trackers are embedded in the
btrfs_delayed_node.

btrfs_ref_tracker and btrfs_ref_tracker_dir are wrappers that either
compile to the corresponding ref_tracker structs or empty structs
depending on CONFIG_BTRFS_DEBUG. There are also btrfs wrappers for
the ref_tracker API.

Signed-off-by: Leo Martins <loemra.dev@gmail.com>
---
 fs/btrfs/Kconfig         |   3 +-
 fs/btrfs/delayed-inode.c | 192 ++++++++++++++++++++++++++++-----------
 fs/btrfs/delayed-inode.h |  70 ++++++++++++++
 3 files changed, 209 insertions(+), 56 deletions(-)

diff --git a/fs/btrfs/Kconfig b/fs/btrfs/Kconfig
index c352f3ae0385..2745de514196 100644
--- a/fs/btrfs/Kconfig
+++ b/fs/btrfs/Kconfig
@@ -61,7 +61,8 @@ config BTRFS_FS_RUN_SANITY_TESTS
 
 config BTRFS_DEBUG
 	bool "Btrfs debugging support"
-	depends on BTRFS_FS
+	depends on BTRFS_FS && STACKTRACE_SUPPORT
+	select REF_TRACKER
 	help
 	  Enable run-time debugging support for the btrfs filesystem.
 
diff --git a/fs/btrfs/delayed-inode.c b/fs/btrfs/delayed-inode.c
index 0f8d8e275143..c4696c2d5b34 100644
--- a/fs/btrfs/delayed-inode.c
+++ b/fs/btrfs/delayed-inode.c
@@ -57,6 +57,7 @@ static inline void btrfs_init_delayed_node(
 	delayed_node->root = root;
 	delayed_node->inode_id = inode_id;
 	refcount_set(&delayed_node->refs, 0);
+	btrfs_delayed_node_ref_tracker_dir_init(delayed_node);
 	delayed_node->ins_root = RB_ROOT_CACHED;
 	delayed_node->del_root = RB_ROOT_CACHED;
 	mutex_init(&delayed_node->mutex);
@@ -65,7 +66,8 @@ static inline void btrfs_init_delayed_node(
 }
 
 static struct btrfs_delayed_node *btrfs_get_delayed_node(
-		struct btrfs_inode *btrfs_inode)
+		struct btrfs_inode *btrfs_inode,
+		struct btrfs_ref_tracker *tracker)
 {
 	struct btrfs_root *root = btrfs_inode->root;
 	u64 ino = btrfs_ino(btrfs_inode);
@@ -74,6 +76,7 @@ static struct btrfs_delayed_node *btrfs_get_delayed_node(
 	node = READ_ONCE(btrfs_inode->delayed_node);
 	if (node) {
 		refcount_inc(&node->refs);
+		btrfs_delayed_node_ref_tracker_alloc(node, tracker, GFP_NOFS);
 		return node;
 	}
 
@@ -83,6 +86,8 @@ static struct btrfs_delayed_node *btrfs_get_delayed_node(
 	if (node) {
 		if (btrfs_inode->delayed_node) {
 			refcount_inc(&node->refs);	/* can be accessed */
+			btrfs_delayed_node_ref_tracker_alloc(node, tracker,
+							     GFP_ATOMIC);
 			BUG_ON(btrfs_inode->delayed_node != node);
 			xa_unlock(&root->delayed_nodes);
 			return node;
@@ -106,6 +111,10 @@ static struct btrfs_delayed_node *btrfs_get_delayed_node(
 		 */
 		if (refcount_inc_not_zero(&node->refs)) {
 			refcount_inc(&node->refs);
+			btrfs_delayed_node_ref_tracker_alloc(node, tracker,
+							     GFP_ATOMIC);
+			btrfs_delayed_node_ref_tracker_alloc(
+				node, &node->inode_cache_tracker, GFP_ATOMIC);
 			btrfs_inode->delayed_node = node;
 		} else {
 			node = NULL;
@@ -126,7 +135,8 @@ static struct btrfs_delayed_node *btrfs_get_delayed_node(
  * Return the delayed node, or error pointer on failure.
  */
 static struct btrfs_delayed_node *btrfs_get_or_create_delayed_node(
-		struct btrfs_inode *btrfs_inode)
+		struct btrfs_inode *btrfs_inode,
+		struct btrfs_ref_tracker *tracker)
 {
 	struct btrfs_delayed_node *node;
 	struct btrfs_root *root = btrfs_inode->root;
@@ -135,7 +145,7 @@ static struct btrfs_delayed_node *btrfs_get_or_create_delayed_node(
 	void *ptr;
 
 again:
-	node = btrfs_get_delayed_node(btrfs_inode);
+	node = btrfs_get_delayed_node(btrfs_inode, tracker);
 	if (node)
 		return node;
 
@@ -144,12 +154,10 @@ static struct btrfs_delayed_node *btrfs_get_or_create_delayed_node(
 		return ERR_PTR(-ENOMEM);
 	btrfs_init_delayed_node(node, root, ino);
 
-	/* Cached in the inode and can be accessed. */
-	refcount_set(&node->refs, 2);
-
 	/* Allocate and reserve the slot, from now it can return a NULL from xa_load(). */
 	ret = xa_reserve(&root->delayed_nodes, ino, GFP_NOFS);
 	if (ret == -ENOMEM) {
+		btrfs_delayed_node_ref_tracker_dir_exit(node);
 		kmem_cache_free(delayed_node_cache, node);
 		return ERR_PTR(-ENOMEM);
 	}
@@ -158,6 +166,7 @@ static struct btrfs_delayed_node *btrfs_get_or_create_delayed_node(
 	if (ptr) {
 		/* Somebody inserted it, go back and read it. */
 		xa_unlock(&root->delayed_nodes);
+		btrfs_delayed_node_ref_tracker_dir_exit(node);
 		kmem_cache_free(delayed_node_cache, node);
 		node = NULL;
 		goto again;
@@ -166,6 +175,13 @@ static struct btrfs_delayed_node *btrfs_get_or_create_delayed_node(
 	ASSERT(xa_err(ptr) != -EINVAL);
 	ASSERT(xa_err(ptr) != -ENOMEM);
 	ASSERT(ptr == NULL);
+
+	/* Cached in the inode and can be accessed. */
+	refcount_set(&node->refs, 2);
+	btrfs_delayed_node_ref_tracker_alloc(node, tracker, GFP_ATOMIC);
+	btrfs_delayed_node_ref_tracker_alloc(node, &node->inode_cache_tracker,
+					     GFP_ATOMIC);
+
 	btrfs_inode->delayed_node = node;
 	xa_unlock(&root->delayed_nodes);
 
@@ -191,6 +207,8 @@ static void btrfs_queue_delayed_node(struct btrfs_delayed_root *root,
 		list_add_tail(&node->n_list, &root->node_list);
 		list_add_tail(&node->p_list, &root->prepare_list);
 		refcount_inc(&node->refs);	/* inserted into list */
+		btrfs_delayed_node_ref_tracker_alloc(
+			node, &node->node_list_tracker, GFP_ATOMIC);
 		root->nodes++;
 		set_bit(BTRFS_DELAYED_NODE_IN_LIST, &node->flags);
 	}
@@ -204,6 +222,8 @@ static void btrfs_dequeue_delayed_node(struct btrfs_delayed_root *root,
 	spin_lock(&root->lock);
 	if (test_bit(BTRFS_DELAYED_NODE_IN_LIST, &node->flags)) {
 		root->nodes--;
+		btrfs_delayed_node_ref_tracker_free(node,
+						    &node->node_list_tracker);
 		refcount_dec(&node->refs);	/* not in the list */
 		list_del_init(&node->n_list);
 		if (!list_empty(&node->p_list))
@@ -214,22 +234,26 @@ static void btrfs_dequeue_delayed_node(struct btrfs_delayed_root *root,
 }
 
 static struct btrfs_delayed_node *btrfs_first_delayed_node(
-			struct btrfs_delayed_root *delayed_root)
+			struct btrfs_delayed_root *delayed_root,
+			struct btrfs_ref_tracker *tracker)
 {
 	struct btrfs_delayed_node *node;
 
 	spin_lock(&delayed_root->lock);
 	node = list_first_entry_or_null(&delayed_root->node_list,
 					struct btrfs_delayed_node, n_list);
-	if (node)
+	if (node) {
 		refcount_inc(&node->refs);
+		btrfs_delayed_node_ref_tracker_alloc(node, tracker, GFP_ATOMIC);
+	}
 	spin_unlock(&delayed_root->lock);
 
 	return node;
 }
 
 static struct btrfs_delayed_node *btrfs_next_delayed_node(
-						struct btrfs_delayed_node *node)
+						struct btrfs_delayed_node *node,
+						struct btrfs_ref_tracker *tracker)
 {
 	struct btrfs_delayed_root *delayed_root;
 	struct list_head *p;
@@ -249,6 +273,7 @@ static struct btrfs_delayed_node *btrfs_next_delayed_node(
 
 	next = list_entry(p, struct btrfs_delayed_node, n_list);
 	refcount_inc(&next->refs);
+	btrfs_delayed_node_ref_tracker_alloc(next, tracker, GFP_ATOMIC);
 out:
 	spin_unlock(&delayed_root->lock);
 
@@ -257,7 +282,7 @@ static struct btrfs_delayed_node *btrfs_next_delayed_node(
 
 static void __btrfs_release_delayed_node(
 				struct btrfs_delayed_node *delayed_node,
-				int mod)
+				int mod, struct btrfs_ref_tracker *tracker)
 {
 	struct btrfs_delayed_root *delayed_root;
 
@@ -273,6 +298,7 @@ static void __btrfs_release_delayed_node(
 		btrfs_dequeue_delayed_node(delayed_root, delayed_node);
 	mutex_unlock(&delayed_node->mutex);
 
+	btrfs_delayed_node_ref_tracker_free(delayed_node, tracker);
 	if (refcount_dec_and_test(&delayed_node->refs)) {
 		struct btrfs_root *root = delayed_node->root;
 
@@ -282,17 +308,20 @@ static void __btrfs_release_delayed_node(
 		 * back up.  We can delete it now.
 		 */
 		ASSERT(refcount_read(&delayed_node->refs) == 0);
+		btrfs_delayed_node_ref_tracker_dir_exit(delayed_node);
 		kmem_cache_free(delayed_node_cache, delayed_node);
 	}
 }
 
-static inline void btrfs_release_delayed_node(struct btrfs_delayed_node *node)
+static inline void btrfs_release_delayed_node(struct btrfs_delayed_node *node,
+					      struct btrfs_ref_tracker *tracker)
 {
-	__btrfs_release_delayed_node(node, 0);
+	__btrfs_release_delayed_node(node, 0, tracker);
 }
 
 static struct btrfs_delayed_node *btrfs_first_prepared_delayed_node(
-					struct btrfs_delayed_root *delayed_root)
+					struct btrfs_delayed_root *delayed_root,
+					struct btrfs_ref_tracker *tracker)
 {
 	struct btrfs_delayed_node *node;
 
@@ -302,6 +331,7 @@ static struct btrfs_delayed_node *btrfs_first_prepared_delayed_node(
 	if (node) {
 		list_del_init(&node->p_list);
 		refcount_inc(&node->refs);
+		btrfs_delayed_node_ref_tracker_alloc(node, tracker, GFP_ATOMIC);
 	}
 	spin_unlock(&delayed_root->lock);
 
@@ -309,9 +339,10 @@ static struct btrfs_delayed_node *btrfs_first_prepared_delayed_node(
 }
 
 static inline void btrfs_release_prepared_delayed_node(
-					struct btrfs_delayed_node *node)
+					struct btrfs_delayed_node *node,
+					struct btrfs_ref_tracker *tracker)
 {
-	__btrfs_release_delayed_node(node, 1);
+	__btrfs_release_delayed_node(node, 1, tracker);
 }
 
 static struct btrfs_delayed_item *btrfs_alloc_delayed_item(u16 data_len,
@@ -1126,6 +1157,8 @@ static int __btrfs_run_delayed_items(struct btrfs_trans_handle *trans, int nr)
 	struct btrfs_fs_info *fs_info = trans->fs_info;
 	struct btrfs_delayed_root *delayed_root;
 	struct btrfs_delayed_node *curr_node, *prev_node;
+	struct btrfs_ref_tracker curr_delayed_node_tracker,
+		prev_delayed_node_tracker;
 	struct btrfs_path *path;
 	struct btrfs_block_rsv *block_rsv;
 	int ret = 0;
@@ -1143,7 +1176,8 @@ static int __btrfs_run_delayed_items(struct btrfs_trans_handle *trans, int nr)
 
 	delayed_root = fs_info->delayed_root;
 
-	curr_node = btrfs_first_delayed_node(delayed_root);
+	curr_node = btrfs_first_delayed_node(delayed_root,
+					     &curr_delayed_node_tracker);
 	while (curr_node && (!count || nr--)) {
 		ret = __btrfs_commit_inode_delayed_items(trans, path,
 							 curr_node);
@@ -1153,7 +1187,9 @@ static int __btrfs_run_delayed_items(struct btrfs_trans_handle *trans, int nr)
 		}
 
 		prev_node = curr_node;
-		curr_node = btrfs_next_delayed_node(curr_node);
+		prev_delayed_node_tracker = curr_delayed_node_tracker;
+		curr_node = btrfs_next_delayed_node(curr_node,
+						    &curr_delayed_node_tracker);
 		/*
 		 * See the comment below about releasing path before releasing
 		 * node. If the commit of delayed items was successful the path
@@ -1161,7 +1197,8 @@ static int __btrfs_run_delayed_items(struct btrfs_trans_handle *trans, int nr)
 		 * point to locked extent buffers (a leaf at the very least).
 		 */
 		ASSERT(path->nodes[0] == NULL);
-		btrfs_release_delayed_node(prev_node);
+		btrfs_release_delayed_node(prev_node,
+					   &prev_delayed_node_tracker);
 	}
 
 	/*
@@ -1174,7 +1211,8 @@ static int __btrfs_run_delayed_items(struct btrfs_trans_handle *trans, int nr)
 	btrfs_free_path(path);
 
 	if (curr_node)
-		btrfs_release_delayed_node(curr_node);
+		btrfs_release_delayed_node(curr_node,
+					   &curr_delayed_node_tracker);
 	trans->block_rsv = block_rsv;
 
 	return ret;
@@ -1193,7 +1231,9 @@ int btrfs_run_delayed_items_nr(struct btrfs_trans_handle *trans, int nr)
 int btrfs_commit_inode_delayed_items(struct btrfs_trans_handle *trans,
 				     struct btrfs_inode *inode)
 {
-	struct btrfs_delayed_node *delayed_node = btrfs_get_delayed_node(inode);
+	struct btrfs_ref_tracker delayed_node_tracker;
+	struct btrfs_delayed_node *delayed_node =
+		btrfs_get_delayed_node(inode, &delayed_node_tracker);
 	BTRFS_PATH_AUTO_FREE(path);
 	struct btrfs_block_rsv *block_rsv;
 	int ret;
@@ -1204,14 +1244,14 @@ int btrfs_commit_inode_delayed_items(struct btrfs_trans_handle *trans,
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
 
@@ -1220,7 +1260,7 @@ int btrfs_commit_inode_delayed_items(struct btrfs_trans_handle *trans,
 
 	ret = __btrfs_commit_inode_delayed_items(trans, path, delayed_node);
 
-	btrfs_release_delayed_node(delayed_node);
+	btrfs_release_delayed_node(delayed_node, &delayed_node_tracker);
 	trans->block_rsv = block_rsv;
 
 	return ret;
@@ -1230,7 +1270,9 @@ int btrfs_commit_inode_delayed_inode(struct btrfs_inode *inode)
 {
 	struct btrfs_fs_info *fs_info = inode->root->fs_info;
 	struct btrfs_trans_handle *trans;
-	struct btrfs_delayed_node *delayed_node = btrfs_get_delayed_node(inode);
+	struct btrfs_ref_tracker delayed_node_tracker;
+	struct btrfs_delayed_node *delayed_node =
+		btrfs_get_delayed_node(inode, &delayed_node_tracker);
 	struct btrfs_path *path;
 	struct btrfs_block_rsv *block_rsv;
 	int ret;
@@ -1241,7 +1283,7 @@ int btrfs_commit_inode_delayed_inode(struct btrfs_inode *inode)
 	mutex_lock(&delayed_node->mutex);
 	if (!test_bit(BTRFS_DELAYED_NODE_INODE_DIRTY, &delayed_node->flags)) {
 		mutex_unlock(&delayed_node->mutex);
-		btrfs_release_delayed_node(delayed_node);
+		btrfs_release_delayed_node(delayed_node, &delayed_node_tracker);
 		return 0;
 	}
 	mutex_unlock(&delayed_node->mutex);
@@ -1275,7 +1317,7 @@ int btrfs_commit_inode_delayed_inode(struct btrfs_inode *inode)
 	btrfs_end_transaction(trans);
 	btrfs_btree_balance_dirty(fs_info);
 out:
-	btrfs_release_delayed_node(delayed_node);
+	btrfs_release_delayed_node(delayed_node, &delayed_node_tracker);
 
 	return ret;
 }
@@ -1289,7 +1331,9 @@ void btrfs_remove_delayed_node(struct btrfs_inode *inode)
 		return;
 
 	inode->delayed_node = NULL;
-	btrfs_release_delayed_node(delayed_node);
+
+	btrfs_release_delayed_node(delayed_node,
+				   &delayed_node->inode_cache_tracker);
 }
 
 struct btrfs_async_delayed_work {
@@ -1305,6 +1349,7 @@ static void btrfs_async_run_delayed_root(struct btrfs_work *work)
 	struct btrfs_trans_handle *trans;
 	struct btrfs_path *path;
 	struct btrfs_delayed_node *delayed_node = NULL;
+	struct btrfs_ref_tracker delayed_node_tracker;
 	struct btrfs_root *root;
 	struct btrfs_block_rsv *block_rsv;
 	int total_done = 0;
@@ -1321,7 +1366,8 @@ static void btrfs_async_run_delayed_root(struct btrfs_work *work)
 		    BTRFS_DELAYED_BACKGROUND / 2)
 			break;
 
-		delayed_node = btrfs_first_prepared_delayed_node(delayed_root);
+		delayed_node = btrfs_first_prepared_delayed_node(
+			delayed_root, &delayed_node_tracker);
 		if (!delayed_node)
 			break;
 
@@ -1330,7 +1376,8 @@ static void btrfs_async_run_delayed_root(struct btrfs_work *work)
 		trans = btrfs_join_transaction(root);
 		if (IS_ERR(trans)) {
 			btrfs_release_path(path);
-			btrfs_release_prepared_delayed_node(delayed_node);
+			btrfs_release_prepared_delayed_node(
+				delayed_node, &delayed_node_tracker);
 			total_done++;
 			continue;
 		}
@@ -1345,7 +1392,8 @@ static void btrfs_async_run_delayed_root(struct btrfs_work *work)
 		btrfs_btree_balance_dirty_nodelay(root->fs_info);
 
 		btrfs_release_path(path);
-		btrfs_release_prepared_delayed_node(delayed_node);
+		btrfs_release_prepared_delayed_node(delayed_node,
+						    &delayed_node_tracker);
 		total_done++;
 
 	} while ((async_work->nr == 0 && total_done < BTRFS_DELAYED_WRITEBACK)
@@ -1377,10 +1425,15 @@ static int btrfs_wq_run_delayed_node(struct btrfs_delayed_root *delayed_root,
 
 void btrfs_assert_delayed_root_empty(struct btrfs_fs_info *fs_info)
 {
-	struct btrfs_delayed_node *node = btrfs_first_delayed_node(fs_info->delayed_root);
+	struct btrfs_ref_tracker delayed_node_tracker;
+	struct btrfs_delayed_node *node = btrfs_first_delayed_node(
+		fs_info->delayed_root, &delayed_node_tracker);
 
-	if (WARN_ON(node))
+	if (WARN_ON(node)) {
+		btrfs_delayed_node_ref_tracker_free(node,
+						    &delayed_node_tracker);
 		refcount_dec(&node->refs);
+	}
 }
 
 static bool could_end_wait(struct btrfs_delayed_root *delayed_root, int seq)
@@ -1454,13 +1507,15 @@ int btrfs_insert_delayed_dir_index(struct btrfs_trans_handle *trans,
 	struct btrfs_fs_info *fs_info = trans->fs_info;
 	const unsigned int leaf_data_size = BTRFS_LEAF_DATA_SIZE(fs_info);
 	struct btrfs_delayed_node *delayed_node;
+	struct btrfs_ref_tracker delayed_node_tracker;
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
 
@@ -1536,7 +1591,7 @@ int btrfs_insert_delayed_dir_index(struct btrfs_trans_handle *trans,
 	mutex_unlock(&delayed_node->mutex);
 
 release_node:
-	btrfs_release_delayed_node(delayed_node);
+	btrfs_release_delayed_node(delayed_node, &delayed_node_tracker);
 	return ret;
 }
 
@@ -1591,10 +1646,11 @@ int btrfs_delete_delayed_dir_index(struct btrfs_trans_handle *trans,
 				   struct btrfs_inode *dir, u64 index)
 {
 	struct btrfs_delayed_node *node;
+	struct btrfs_ref_tracker delayed_node_tracker;
 	struct btrfs_delayed_item *item;
 	int ret;
 
-	node = btrfs_get_or_create_delayed_node(dir);
+	node = btrfs_get_or_create_delayed_node(dir, &delayed_node_tracker);
 	if (IS_ERR(node))
 		return PTR_ERR(node);
 
@@ -1635,13 +1691,15 @@ int btrfs_delete_delayed_dir_index(struct btrfs_trans_handle *trans,
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
+	struct btrfs_ref_tracker delayed_node_tracker;
+	struct btrfs_delayed_node *delayed_node =
+		btrfs_get_delayed_node(inode, &delayed_node_tracker);
 
 	if (!delayed_node)
 		return -ENOENT;
@@ -1652,12 +1710,12 @@ int btrfs_inode_delayed_dir_index_count(struct btrfs_inode *inode)
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
 
@@ -1668,8 +1726,9 @@ bool btrfs_readdir_get_delayed_items(struct btrfs_inode *inode,
 {
 	struct btrfs_delayed_node *delayed_node;
 	struct btrfs_delayed_item *item;
+	struct btrfs_ref_tracker delayed_node_tracker;
 
-	delayed_node = btrfs_get_delayed_node(inode);
+	delayed_node = btrfs_get_delayed_node(inode, &delayed_node_tracker);
 	if (!delayed_node)
 		return false;
 
@@ -1704,6 +1763,8 @@ bool btrfs_readdir_get_delayed_items(struct btrfs_inode *inode,
 	 * insert/delete delayed items in this period. So we also needn't
 	 * requeue or dequeue this delayed node.
 	 */
+	btrfs_delayed_node_ref_tracker_free(delayed_node,
+					    &delayed_node_tracker);
 	refcount_dec(&delayed_node->refs);
 
 	return true;
@@ -1845,17 +1906,18 @@ int btrfs_fill_inode(struct btrfs_inode *inode, u32 *rdev)
 {
 	struct btrfs_fs_info *fs_info = inode->root->fs_info;
 	struct btrfs_delayed_node *delayed_node;
+	struct btrfs_ref_tracker delayed_node_tracker;
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
 
@@ -1895,7 +1957,7 @@ int btrfs_fill_inode(struct btrfs_inode *inode, u32 *rdev)
 		inode->index_cnt = (u64)-1;
 
 	mutex_unlock(&delayed_node->mutex);
-	btrfs_release_delayed_node(delayed_node);
+	btrfs_release_delayed_node(delayed_node, &delayed_node_tracker);
 	return 0;
 }
 
@@ -1904,9 +1966,11 @@ int btrfs_delayed_update_inode(struct btrfs_trans_handle *trans,
 {
 	struct btrfs_root *root = inode->root;
 	struct btrfs_delayed_node *delayed_node;
+	struct btrfs_ref_tracker delayed_node_tracker;
 	int ret = 0;
 
-	delayed_node = btrfs_get_or_create_delayed_node(inode);
+	delayed_node =
+		btrfs_get_or_create_delayed_node(inode, &delayed_node_tracker);
 	if (IS_ERR(delayed_node))
 		return PTR_ERR(delayed_node);
 
@@ -1926,7 +1990,7 @@ int btrfs_delayed_update_inode(struct btrfs_trans_handle *trans,
 	atomic_inc(&root->fs_info->delayed_root->items);
 release_node:
 	mutex_unlock(&delayed_node->mutex);
-	btrfs_release_delayed_node(delayed_node);
+	btrfs_release_delayed_node(delayed_node, &delayed_node_tracker);
 	return ret;
 }
 
@@ -1934,6 +1998,7 @@ int btrfs_delayed_delete_inode_ref(struct btrfs_inode *inode)
 {
 	struct btrfs_fs_info *fs_info = inode->root->fs_info;
 	struct btrfs_delayed_node *delayed_node;
+	struct btrfs_ref_tracker delayed_node_tracker;
 
 	/*
 	 * we don't do delayed inode updates during log recovery because it
@@ -1943,7 +2008,8 @@ int btrfs_delayed_delete_inode_ref(struct btrfs_inode *inode)
 	if (test_bit(BTRFS_FS_LOG_RECOVERING, &fs_info->flags))
 		return -EAGAIN;
 
-	delayed_node = btrfs_get_or_create_delayed_node(inode);
+	delayed_node =
+		btrfs_get_or_create_delayed_node(inode, &delayed_node_tracker);
 	if (IS_ERR(delayed_node))
 		return PTR_ERR(delayed_node);
 
@@ -1970,7 +2036,7 @@ int btrfs_delayed_delete_inode_ref(struct btrfs_inode *inode)
 	atomic_inc(&fs_info->delayed_root->items);
 release_node:
 	mutex_unlock(&delayed_node->mutex);
-	btrfs_release_delayed_node(delayed_node);
+	btrfs_release_delayed_node(delayed_node, &delayed_node_tracker);
 	return 0;
 }
 
@@ -2014,19 +2080,21 @@ static void __btrfs_kill_delayed_node(struct btrfs_delayed_node *delayed_node)
 void btrfs_kill_delayed_inode_items(struct btrfs_inode *inode)
 {
 	struct btrfs_delayed_node *delayed_node;
+	struct btrfs_ref_tracker delayed_node_tracker;
 
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
+	struct btrfs_ref_tracker delayed_node_trackers[8];
 
 	while (1) {
 		struct btrfs_delayed_node *node;
@@ -2045,6 +2113,9 @@ void btrfs_kill_all_delayed_nodes(struct btrfs_root *root)
 			 * about to be removed from the tree in the loop below
 			 */
 			if (refcount_inc_not_zero(&node->refs)) {
+				btrfs_delayed_node_ref_tracker_alloc(
+					node, &delayed_node_trackers[count],
+					GFP_ATOMIC);
 				delayed_nodes[count] = node;
 				count++;
 			}
@@ -2056,7 +2127,8 @@ void btrfs_kill_all_delayed_nodes(struct btrfs_root *root)
 
 		for (int i = 0; i < count; i++) {
 			__btrfs_kill_delayed_node(delayed_nodes[i]);
-			btrfs_release_delayed_node(delayed_nodes[i]);
+			btrfs_release_delayed_node(delayed_nodes[i],
+						   &delayed_node_trackers[i]);
 		}
 	}
 }
@@ -2064,14 +2136,20 @@ void btrfs_kill_all_delayed_nodes(struct btrfs_root *root)
 void btrfs_destroy_delayed_inodes(struct btrfs_fs_info *fs_info)
 {
 	struct btrfs_delayed_node *curr_node, *prev_node;
+	struct btrfs_ref_tracker curr_delayed_node_tracker,
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
 
@@ -2081,8 +2159,9 @@ void btrfs_log_get_delayed_items(struct btrfs_inode *inode,
 {
 	struct btrfs_delayed_node *node;
 	struct btrfs_delayed_item *item;
+	struct btrfs_ref_tracker delayed_node_tracker;
 
-	node = btrfs_get_delayed_node(inode);
+	node = btrfs_get_delayed_node(inode, &delayed_node_tracker);
 	if (!node)
 		return;
 
@@ -2140,6 +2219,7 @@ void btrfs_log_get_delayed_items(struct btrfs_inode *inode,
 	 * delete delayed items.
 	 */
 	ASSERT(refcount_read(&node->refs) > 1);
+	btrfs_delayed_node_ref_tracker_free(node, &delayed_node_tracker);
 	refcount_dec(&node->refs);
 }
 
@@ -2150,8 +2230,9 @@ void btrfs_log_put_delayed_items(struct btrfs_inode *inode,
 	struct btrfs_delayed_node *node;
 	struct btrfs_delayed_item *item;
 	struct btrfs_delayed_item *next;
+	struct btrfs_ref_tracker delayed_node_tracker;
 
-	node = btrfs_get_delayed_node(inode);
+	node = btrfs_get_delayed_node(inode, &delayed_node_tracker);
 	if (!node)
 		return;
 
@@ -2183,5 +2264,6 @@ void btrfs_log_put_delayed_items(struct btrfs_inode *inode,
 	 * delete delayed items.
 	 */
 	ASSERT(refcount_read(&node->refs) > 1);
+	btrfs_delayed_node_ref_tracker_free(node, &delayed_node_tracker);
 	refcount_dec(&node->refs);
 }
diff --git a/fs/btrfs/delayed-inode.h b/fs/btrfs/delayed-inode.h
index e6e763ad2d42..a01f2ab59adb 100644
--- a/fs/btrfs/delayed-inode.h
+++ b/fs/btrfs/delayed-inode.h
@@ -7,6 +7,7 @@
 #ifndef BTRFS_DELAYED_INODE_H
 #define BTRFS_DELAYED_INODE_H
 
+#include <linux/ref_tracker.h>
 #include <linux/types.h>
 #include <linux/rbtree.h>
 #include <linux/spinlock.h>
@@ -44,6 +45,22 @@ struct btrfs_delayed_root {
 	wait_queue_head_t wait;
 };
 
+struct btrfs_ref_tracker_dir {
+#ifdef CONFIG_BTRFS_DEBUG
+	struct ref_tracker_dir dir;
+#else
+	struct {} tracker;
+#endif
+};
+
+struct btrfs_ref_tracker {
+#ifdef CONFIG_BTRFS_DEBUG
+	struct ref_tracker *tracker;
+#else
+	struct {} tracker;
+#endif
+};
+
 #define BTRFS_DELAYED_NODE_IN_LIST	0
 #define BTRFS_DELAYED_NODE_INODE_DIRTY	1
 #define BTRFS_DELAYED_NODE_DEL_IREF	2
@@ -78,6 +95,12 @@ struct btrfs_delayed_node {
 	 * actual number of leaves we end up using. Protected by @mutex.
 	 */
 	u32 index_item_leaves;
+	/* Used to track all references to this delayed node. */
+	struct btrfs_ref_tracker_dir ref_dir;
+ 	/* Used to track delayed node reference stored in node list. */
+	struct btrfs_ref_tracker node_list_tracker;
+ 	/* Used to track delayed node reference stored in inode cache. */
+	struct btrfs_ref_tracker inode_cache_tracker;
 };
 
 struct btrfs_delayed_item {
@@ -169,4 +192,51 @@ void __cold btrfs_delayed_inode_exit(void);
 /* for debugging */
 void btrfs_assert_delayed_root_empty(struct btrfs_fs_info *fs_info);
 
+#define BTRFS_DELAYED_NODE_REF_TRACKER_QUARANTINE_COUNT 16
+#define BTRFS_DELAYED_NODE_REF_TRACKER_DISPLAY_LIMIT 16
+
+#ifdef CONFIG_BTRFS_DEBUG
+static inline void btrfs_delayed_node_ref_tracker_dir_init(struct btrfs_delayed_node *node)
+{
+	ref_tracker_dir_init(&node->ref_dir.dir, 
+			     BTRFS_DELAYED_NODE_REF_TRACKER_QUARANTINE_COUNT,
+			     "delayed_node");
+}
+
+static inline void btrfs_delayed_node_ref_tracker_dir_exit(struct btrfs_delayed_node *node)
+{
+	ref_tracker_dir_exit(&node->ref_dir.dir);
+}
+
+static inline int btrfs_delayed_node_ref_tracker_alloc(struct btrfs_delayed_node *node,
+						       struct btrfs_ref_tracker *tracker,
+						       gfp_t gfp)
+{
+	return ref_tracker_alloc(&node->ref_dir.dir, &tracker->tracker, gfp);
+}
+
+static inline int btrfs_delayed_node_ref_tracker_free(struct btrfs_delayed_node *node,
+						      struct btrfs_ref_tracker *tracker)
+{
+	return ref_tracker_free(&node->ref_dir.dir, &tracker->tracker);
+}
+#else
+static inline void btrfs_delayed_node_ref_tracker_dir_init(struct btrfs_delayed_node *node) { }
+
+static inline void btrfs_delayed_node_ref_tracker_dir_exit(struct btrfs_delayed_node *node) { }
+
+static inline int btrfs_delayed_node_ref_tracker_alloc(struct btrfs_delayed_node *node,
+						       struct btrfs_ref_tracker *tracker,
+						       gfp_t gfp)
+{
+	return 0;
+}
+
+static inline int btrfs_delayed_node_ref_tracker_free(struct btrfs_delayed_node *node,
+						      struct btrfs_ref_tracker *tracker)
+{
+	return 0;
+}
+#endif /* CONFIG_BTRFS_REF_TRACKER */
+
 #endif
-- 
2.47.3


