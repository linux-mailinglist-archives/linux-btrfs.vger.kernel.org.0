Return-Path: <linux-btrfs+bounces-15733-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E7EFB148EC
	for <lists+linux-btrfs@lfdr.de>; Tue, 29 Jul 2025 09:08:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A93054509F
	for <lists+linux-btrfs@lfdr.de>; Tue, 29 Jul 2025 07:08:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9A1825D216;
	Tue, 29 Jul 2025 07:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KLWCVFOA"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-f194.google.com (mail-yw1-f194.google.com [209.85.128.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 987CB2472BA
	for <linux-btrfs@vger.kernel.org>; Tue, 29 Jul 2025 07:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753772893; cv=none; b=nXmYQ80FuAAJx3xsl+9vNCCvG+g0v8sqZMd2FSG0oiiaH6QvgUTzYEEvjR4ODGtJGm1AVW++2RZPGSga7mT6rE4Yr90LDxisvdXUHE5313Z8ggBessil8WRKXEJKvprCdwkc4uwHIwNZQYcedyQJojSpb/faMdpsTNRvymGfvNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753772893; c=relaxed/simple;
	bh=H3ijD7kkIYnTxeSKk20160hyWk8VkITd/cg+TO02PzQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=RmamQTNIU2kMzY/quYo6y/H565dxvGNZAq81D+pIVz8TCAvoC7eFJ8fGFMlhtRs+3lAKOfmIoPyarZYI/VbMd41JqKi+hl+ofliF3dg/N2OdI17+0Cly2l5glp3QXxviR1cOoNh5hHsE8+eOYL2hQiKN8/tMSBklyCumDtXlj18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KLWCVFOA; arc=none smtp.client-ip=209.85.128.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f194.google.com with SMTP id 00721157ae682-719a4206caeso50101977b3.1
        for <linux-btrfs@vger.kernel.org>; Tue, 29 Jul 2025 00:08:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753772889; x=1754377689; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=KLIRE5NL4s5xX2OQ7lSvcH8nP5NyCO8vhwmrxIL6bI4=;
        b=KLWCVFOAarXmQTXQ+OuyPsnZOi5NbqCQhalqc/Ndz78XPJ7PHsslgZTi6NuSw2/nIc
         MZQS4Mf2Uo8K68HHjN3hCjQEnY2qJISjzJWXvTr9ebJb7eAY55JQkJ9gtpYvrH8IxCfS
         H445KxoLD6TQvMyd1esgDHxj0WsaINSOJFlLITZcemFKzffcV+2Uf9Dg1sd9bCiWqrF6
         bvfnF1Nw7o+OBm/P3d0BXF5a4JM1qrvWmBku/fz8e1+P+Z85+hqbWV0JqEOsnXyx4dNI
         W3TZYIVunbayxZl8cZPV7kUq8KTNVaSKDBcPXVH+g0sZTl555DNO9eynVLHpc+al0nVM
         Z+Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753772889; x=1754377689;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KLIRE5NL4s5xX2OQ7lSvcH8nP5NyCO8vhwmrxIL6bI4=;
        b=R+zOwRcKfLyy//mpCbwnGD/f1YQhxIG/Nmvtn6+BZkCgzqv8yl/NDUM0JjkMJlN1Fv
         tN8ZCgo/4JmkPW9dtC0/QjJ2FvC6SXgvxscppJVQZaORmLB984EwqQq8fapXShT40TCJ
         huJzNEDMdXmW2K3xsQM21X6eItCCzZqbkh7U4UiOTT8AX4O16/i2WD56jeVxz61u/XVA
         qoWf37P4PQVGec1IKtWMsp5AaU5cZf/SCaRFJN0iW/q/m/yE6TzdWdHqhVNr8jVFGSgS
         lQaVCLb7uxtuW9tt+e6OMu+szGDMHqW4Q+R5PZJiSE5IjT4W/etrTCXlByWdZEm7zTJL
         Ukyg==
X-Gm-Message-State: AOJu0YwKDaFmvTj35wUhQXQZBjMYDwVSTUTRFww39kJQBwljm9QBZdWm
	PwLYgCfY5n8mIGHcL7+EBsyXzOrD8B6ypnt726An9tbGLMoQ3TiEMmm2TbPSOCxx
X-Gm-Gg: ASbGnctuRmAi00+oNYHbF7bdoymULvTeJGFSmbe66Uyx1j6JFr/VO9xUBqIjfiPfT40
	4HY/ziIFV7lrm9V9IlLS1sH0oykCjpA27lje8Oabjmt/RFlCKzueqtoXazAMHrx4hu1BcKor4jh
	7AvSrpY3fodJ9O/fM8vzv9g/sJEGUW1M1jZ+9lQ7QAdnIpVsOB9183JcS/HuJL0gQC+gXjP45Bs
	Dt65zTHFpLJgZc8T8uu+C/zDH5gVmqThHlLfTaVZ5oDiQP/oqtO8NoCs0IS/ezmOUSI21ynwaDz
	cbrhYKN183sCxEbyJiYZr7FhV6S+LaKZSxy4NWCKTRvS/3w1FbPVkoEWknTZX4Ezm6uEYcw06Zk
	gTKZNSxyiNAmcjgL4/A==
X-Google-Smtp-Source: AGHT+IEzc5guMgQ50XpiJCKuVUz7QCQHRi89/mpKbde51KsJ4iTAZwElyQ/niY06RjKnyrehol84LQ==
X-Received: by 2002:a05:690c:6888:b0:71a:3518:d108 with SMTP id 00721157ae682-71a3518d546mr29872407b3.3.1753772888865;
        Tue, 29 Jul 2025 00:08:08 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:4b::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-719f21e6135sm16241587b3.40.2025.07.29.00.08.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jul 2025 00:08:08 -0700 (PDT)
From: Leo Martins <loemra.dev@gmail.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH v2] btrfs: implement ref_tracker for delayed_nodes
Date: Tue, 29 Jul 2025 00:08:04 -0700
Message-ID: <b3553e5bee047c081c32f5689aaf1db7143f21b1.1753746365.git.loemra.dev@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch adds ref_tracker infrastructure for btrfs_delayed_node.

A ref_tracker object is allocated every time the reference count is
increased and freed when the reference count is decreased. The
ref_tracker object contains stack_trace information about where the
ref count is increased and decreased. The ref_tracker_dir embedded in
btrfs_delayed_node keeps track of all current references, and some
previous references. This information allows for detection of reference
leaks or double frees.

Here is a common example of taking a reference to a delayed_node and
freeing it with ref_tracker.

```C
struct ref_tracker *tracker;
struct btrfs_delayed_node *node;

node = btrfs_get_delayed_node(inode, tracker);
// use delayed_node...
btrfs_release_delayed_node(node, tracker);
```

There are two special cases where the delayed_node reference is long
term, meaning that the thread that takes the reference and the thread
that frees the reference are different. The inode_cache which is the
btrfs_delayed_node reference stored in the associated btrfs_inode, and
the node_list which is the btrfs_delayed_node reference stored in the
btrfs_delayed_root node_list/prepare_list. In these cases the
ref_tracker is stored in the delayed_node itself.

This patch introduces some new wrappers (btrfs_delayed_node_ref_tracker_*)
to ensure that when BTRFS_DEBUG is disabled everything gets compiled out.

Signed-off-by: Leo Martins <loemra.dev@gmail.com>
---
v1: https://lore.kernel.org/linux-btrfs/fa19acf9dc38e93546183fc083c365cdb237e89b.1752098515.git.loemra.dev@gmail.com/

v1->v2:
- remove typedefs, now functions always take struct ref_tracker **
- put delayed_node::count back to original position to not change
  delayed_node struct size
- cleanup ref_tracker_dir if btrfs_get_or_create_delayed_node
  fails to create a delayed_node
- remove CONFIG_BTRFS_DELAYED_NODE_REF_TRACKER and use
  CONFIG_BTRFS_DEBUG
---
 fs/btrfs/delayed-inode.c | 229 ++++++++++++++++++++++++++++-----------
 fs/btrfs/delayed-inode.h |  61 ++++++++++-
 2 files changed, 226 insertions(+), 64 deletions(-)

diff --git a/fs/btrfs/delayed-inode.c b/fs/btrfs/delayed-inode.c
index 0f8d8e275143..0b40308c96a6 100644
--- a/fs/btrfs/delayed-inode.c
+++ b/fs/btrfs/delayed-inode.c
@@ -57,6 +57,8 @@ static inline void btrfs_init_delayed_node(
 	delayed_node->root = root;
 	delayed_node->inode_id = inode_id;
 	refcount_set(&delayed_node->refs, 0);
+	btrfs_delayed_node_ref_tracker_dir_init(delayed_node, 16,
+						"delayed_node");
 	delayed_node->ins_root = RB_ROOT_CACHED;
 	delayed_node->del_root = RB_ROOT_CACHED;
 	mutex_init(&delayed_node->mutex);
@@ -64,16 +66,19 @@ static inline void btrfs_init_delayed_node(
 	INIT_LIST_HEAD(&delayed_node->p_list);
 }
 
-static struct btrfs_delayed_node *btrfs_get_delayed_node(
-		struct btrfs_inode *btrfs_inode)
+static struct btrfs_delayed_node *
+btrfs_get_delayed_node(struct btrfs_inode *btrfs_inode,
+		       struct ref_tracker **tracker)
 {
 	struct btrfs_root *root = btrfs_inode->root;
 	u64 ino = btrfs_ino(btrfs_inode);
 	struct btrfs_delayed_node *node;
+	struct ref_tracker **inode_cache_tracker = NULL;
 
 	node = READ_ONCE(btrfs_inode->delayed_node);
 	if (node) {
 		refcount_inc(&node->refs);
+		btrfs_delayed_node_ref_tracker_alloc(node, tracker, GFP_NOFS);
 		return node;
 	}
 
@@ -83,6 +88,8 @@ static struct btrfs_delayed_node *btrfs_get_delayed_node(
 	if (node) {
 		if (btrfs_inode->delayed_node) {
 			refcount_inc(&node->refs);	/* can be accessed */
+			btrfs_delayed_node_ref_tracker_alloc(node, tracker,
+							     GFP_ATOMIC);
 			BUG_ON(btrfs_inode->delayed_node != node);
 			xa_unlock(&root->delayed_nodes);
 			return node;
@@ -106,6 +113,13 @@ static struct btrfs_delayed_node *btrfs_get_delayed_node(
 		 */
 		if (refcount_inc_not_zero(&node->refs)) {
 			refcount_inc(&node->refs);
+#ifdef CONFIG_BTRFS_DEBUG
+			inode_cache_tracker = &node->inode_cache_tracker;
+#endif
+			btrfs_delayed_node_ref_tracker_alloc(node, tracker,
+							     GFP_ATOMIC);
+			btrfs_delayed_node_ref_tracker_alloc(
+				node, inode_cache_tracker, GFP_ATOMIC);
 			btrfs_inode->delayed_node = node;
 		} else {
 			node = NULL;
@@ -125,17 +139,19 @@ static struct btrfs_delayed_node *btrfs_get_delayed_node(
  *
  * Return the delayed node, or error pointer on failure.
  */
-static struct btrfs_delayed_node *btrfs_get_or_create_delayed_node(
-		struct btrfs_inode *btrfs_inode)
+static struct btrfs_delayed_node *
+btrfs_get_or_create_delayed_node(struct btrfs_inode *btrfs_inode,
+				 struct ref_tracker **tracker)
 {
 	struct btrfs_delayed_node *node;
+	struct ref_tracker **inode_cache_tracker = NULL;
 	struct btrfs_root *root = btrfs_inode->root;
 	u64 ino = btrfs_ino(btrfs_inode);
 	int ret;
 	void *ptr;
 
 again:
-	node = btrfs_get_delayed_node(btrfs_inode);
+	node = btrfs_get_delayed_node(btrfs_inode, tracker);
 	if (node)
 		return node;
 
@@ -144,12 +160,10 @@ static struct btrfs_delayed_node *btrfs_get_or_create_delayed_node(
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
@@ -158,6 +172,7 @@ static struct btrfs_delayed_node *btrfs_get_or_create_delayed_node(
 	if (ptr) {
 		/* Somebody inserted it, go back and read it. */
 		xa_unlock(&root->delayed_nodes);
+		btrfs_delayed_node_ref_tracker_dir_exit(node);
 		kmem_cache_free(delayed_node_cache, node);
 		node = NULL;
 		goto again;
@@ -166,6 +181,15 @@ static struct btrfs_delayed_node *btrfs_get_or_create_delayed_node(
 	ASSERT(xa_err(ptr) != -EINVAL);
 	ASSERT(xa_err(ptr) != -ENOMEM);
 	ASSERT(ptr == NULL);
+
+	/* Cached in the inode and can be accessed. */
+	refcount_set(&node->refs, 2);
+#ifdef CONFIG_BTRFS_DEBUG
+	inode_cache_tracker = &node->inode_cache_tracker;
+#endif
+	btrfs_delayed_node_ref_tracker_alloc(node, tracker, GFP_ATOMIC);
+	btrfs_delayed_node_ref_tracker_alloc(node, inode_cache_tracker, GFP_ATOMIC);
+
 	btrfs_inode->delayed_node = node;
 	xa_unlock(&root->delayed_nodes);
 
@@ -181,6 +205,8 @@ static void btrfs_queue_delayed_node(struct btrfs_delayed_root *root,
 				     struct btrfs_delayed_node *node,
 				     int mod)
 {
+	struct ref_tracker **node_list_tracker = NULL;
+
 	spin_lock(&root->lock);
 	if (test_bit(BTRFS_DELAYED_NODE_IN_LIST, &node->flags)) {
 		if (!list_empty(&node->p_list))
@@ -191,6 +217,10 @@ static void btrfs_queue_delayed_node(struct btrfs_delayed_root *root,
 		list_add_tail(&node->n_list, &root->node_list);
 		list_add_tail(&node->p_list, &root->prepare_list);
 		refcount_inc(&node->refs);	/* inserted into list */
+#ifdef CONFIG_BTRFS_DEBUG
+		node_list_tracker = &node->node_list_tracker;
+#endif
+		btrfs_delayed_node_ref_tracker_alloc(node, node_list_tracker, GFP_ATOMIC);
 		root->nodes++;
 		set_bit(BTRFS_DELAYED_NODE_IN_LIST, &node->flags);
 	}
@@ -201,9 +231,15 @@ static void btrfs_queue_delayed_node(struct btrfs_delayed_root *root,
 static void btrfs_dequeue_delayed_node(struct btrfs_delayed_root *root,
 				       struct btrfs_delayed_node *node)
 {
+	struct ref_tracker **node_list_tracker = NULL;
+
 	spin_lock(&root->lock);
 	if (test_bit(BTRFS_DELAYED_NODE_IN_LIST, &node->flags)) {
 		root->nodes--;
+#ifdef CONFIG_BTRFS_DEBUG
+		node_list_tracker = &node->node_list_tracker;
+#endif
+		btrfs_delayed_node_ref_tracker_free(node, node_list_tracker);
 		refcount_dec(&node->refs);	/* not in the list */
 		list_del_init(&node->n_list);
 		if (!list_empty(&node->p_list))
@@ -213,23 +249,27 @@ static void btrfs_dequeue_delayed_node(struct btrfs_delayed_root *root,
 	spin_unlock(&root->lock);
 }
 
-static struct btrfs_delayed_node *btrfs_first_delayed_node(
-			struct btrfs_delayed_root *delayed_root)
+static struct btrfs_delayed_node *
+btrfs_first_delayed_node(struct btrfs_delayed_root *delayed_root,
+			 struct ref_tracker **tracker)
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
 
-static struct btrfs_delayed_node *btrfs_next_delayed_node(
-						struct btrfs_delayed_node *node)
+static struct btrfs_delayed_node *
+btrfs_next_delayed_node(struct btrfs_delayed_node *node,
+			struct ref_tracker **tracker)
 {
 	struct btrfs_delayed_root *delayed_root;
 	struct list_head *p;
@@ -249,15 +289,16 @@ static struct btrfs_delayed_node *btrfs_next_delayed_node(
 
 	next = list_entry(p, struct btrfs_delayed_node, n_list);
 	refcount_inc(&next->refs);
+	btrfs_delayed_node_ref_tracker_alloc(next, tracker, GFP_ATOMIC);
 out:
 	spin_unlock(&delayed_root->lock);
 
 	return next;
 }
 
-static void __btrfs_release_delayed_node(
-				struct btrfs_delayed_node *delayed_node,
-				int mod)
+static void
+__btrfs_release_delayed_node(struct btrfs_delayed_node *delayed_node, int mod,
+			     struct ref_tracker **tracker)
 {
 	struct btrfs_delayed_root *delayed_root;
 
@@ -273,6 +314,7 @@ static void __btrfs_release_delayed_node(
 		btrfs_dequeue_delayed_node(delayed_root, delayed_node);
 	mutex_unlock(&delayed_node->mutex);
 
+	btrfs_delayed_node_ref_tracker_free(delayed_node, tracker);
 	if (refcount_dec_and_test(&delayed_node->refs)) {
 		struct btrfs_root *root = delayed_node->root;
 
@@ -282,17 +324,20 @@ static void __btrfs_release_delayed_node(
 		 * back up.  We can delete it now.
 		 */
 		ASSERT(refcount_read(&delayed_node->refs) == 0);
+		btrfs_delayed_node_ref_tracker_dir_exit(delayed_node);
 		kmem_cache_free(delayed_node_cache, delayed_node);
 	}
 }
 
-static inline void btrfs_release_delayed_node(struct btrfs_delayed_node *node)
+static inline void btrfs_release_delayed_node(struct btrfs_delayed_node *node,
+					      struct ref_tracker **tracker)
 {
-	__btrfs_release_delayed_node(node, 0);
+	__btrfs_release_delayed_node(node, 0, tracker);
 }
 
-static struct btrfs_delayed_node *btrfs_first_prepared_delayed_node(
-					struct btrfs_delayed_root *delayed_root)
+static struct btrfs_delayed_node *
+btrfs_first_prepared_delayed_node(struct btrfs_delayed_root *delayed_root,
+				  struct ref_tracker **tracker)
 {
 	struct btrfs_delayed_node *node;
 
@@ -302,16 +347,18 @@ static struct btrfs_delayed_node *btrfs_first_prepared_delayed_node(
 	if (node) {
 		list_del_init(&node->p_list);
 		refcount_inc(&node->refs);
+		btrfs_delayed_node_ref_tracker_alloc(node, tracker, GFP_ATOMIC);
 	}
 	spin_unlock(&delayed_root->lock);
 
 	return node;
 }
 
-static inline void btrfs_release_prepared_delayed_node(
-					struct btrfs_delayed_node *node)
+static inline void
+btrfs_release_prepared_delayed_node(struct btrfs_delayed_node *node,
+				    struct ref_tracker **tracker)
 {
-	__btrfs_release_delayed_node(node, 1);
+	__btrfs_release_delayed_node(node, 1, tracker);
 }
 
 static struct btrfs_delayed_item *btrfs_alloc_delayed_item(u16 data_len,
@@ -1126,6 +1173,8 @@ static int __btrfs_run_delayed_items(struct btrfs_trans_handle *trans, int nr)
 	struct btrfs_fs_info *fs_info = trans->fs_info;
 	struct btrfs_delayed_root *delayed_root;
 	struct btrfs_delayed_node *curr_node, *prev_node;
+	struct ref_tracker *curr_delayed_node_tracker,
+		*prev_delayed_node_tracker;
 	struct btrfs_path *path;
 	struct btrfs_block_rsv *block_rsv;
 	int ret = 0;
@@ -1143,7 +1192,8 @@ static int __btrfs_run_delayed_items(struct btrfs_trans_handle *trans, int nr)
 
 	delayed_root = fs_info->delayed_root;
 
-	curr_node = btrfs_first_delayed_node(delayed_root);
+	curr_node = btrfs_first_delayed_node(delayed_root,
+					     &curr_delayed_node_tracker);
 	while (curr_node && (!count || nr--)) {
 		ret = __btrfs_commit_inode_delayed_items(trans, path,
 							 curr_node);
@@ -1153,7 +1203,9 @@ static int __btrfs_run_delayed_items(struct btrfs_trans_handle *trans, int nr)
 		}
 
 		prev_node = curr_node;
-		curr_node = btrfs_next_delayed_node(curr_node);
+		prev_delayed_node_tracker = curr_delayed_node_tracker;
+		curr_node = btrfs_next_delayed_node(curr_node,
+						    &curr_delayed_node_tracker);
 		/*
 		 * See the comment below about releasing path before releasing
 		 * node. If the commit of delayed items was successful the path
@@ -1161,7 +1213,8 @@ static int __btrfs_run_delayed_items(struct btrfs_trans_handle *trans, int nr)
 		 * point to locked extent buffers (a leaf at the very least).
 		 */
 		ASSERT(path->nodes[0] == NULL);
-		btrfs_release_delayed_node(prev_node);
+		btrfs_release_delayed_node(prev_node,
+					   &prev_delayed_node_tracker);
 	}
 
 	/*
@@ -1174,7 +1227,8 @@ static int __btrfs_run_delayed_items(struct btrfs_trans_handle *trans, int nr)
 	btrfs_free_path(path);
 
 	if (curr_node)
-		btrfs_release_delayed_node(curr_node);
+		btrfs_release_delayed_node(curr_node,
+					   &curr_delayed_node_tracker);
 	trans->block_rsv = block_rsv;
 
 	return ret;
@@ -1193,7 +1247,9 @@ int btrfs_run_delayed_items_nr(struct btrfs_trans_handle *trans, int nr)
 int btrfs_commit_inode_delayed_items(struct btrfs_trans_handle *trans,
 				     struct btrfs_inode *inode)
 {
-	struct btrfs_delayed_node *delayed_node = btrfs_get_delayed_node(inode);
+	struct ref_tracker *delayed_node_tracker;
+	struct btrfs_delayed_node *delayed_node =
+		btrfs_get_delayed_node(inode, &delayed_node_tracker);
 	BTRFS_PATH_AUTO_FREE(path);
 	struct btrfs_block_rsv *block_rsv;
 	int ret;
@@ -1204,14 +1260,14 @@ int btrfs_commit_inode_delayed_items(struct btrfs_trans_handle *trans,
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
 
@@ -1220,7 +1276,7 @@ int btrfs_commit_inode_delayed_items(struct btrfs_trans_handle *trans,
 
 	ret = __btrfs_commit_inode_delayed_items(trans, path, delayed_node);
 
-	btrfs_release_delayed_node(delayed_node);
+	btrfs_release_delayed_node(delayed_node, &delayed_node_tracker);
 	trans->block_rsv = block_rsv;
 
 	return ret;
@@ -1230,7 +1286,9 @@ int btrfs_commit_inode_delayed_inode(struct btrfs_inode *inode)
 {
 	struct btrfs_fs_info *fs_info = inode->root->fs_info;
 	struct btrfs_trans_handle *trans;
-	struct btrfs_delayed_node *delayed_node = btrfs_get_delayed_node(inode);
+	struct ref_tracker *delayed_node_tracker;
+	struct btrfs_delayed_node *delayed_node =
+		btrfs_get_delayed_node(inode, &delayed_node_tracker);
 	struct btrfs_path *path;
 	struct btrfs_block_rsv *block_rsv;
 	int ret;
@@ -1241,7 +1299,7 @@ int btrfs_commit_inode_delayed_inode(struct btrfs_inode *inode)
 	mutex_lock(&delayed_node->mutex);
 	if (!test_bit(BTRFS_DELAYED_NODE_INODE_DIRTY, &delayed_node->flags)) {
 		mutex_unlock(&delayed_node->mutex);
-		btrfs_release_delayed_node(delayed_node);
+		btrfs_release_delayed_node(delayed_node, &delayed_node_tracker);
 		return 0;
 	}
 	mutex_unlock(&delayed_node->mutex);
@@ -1275,7 +1333,7 @@ int btrfs_commit_inode_delayed_inode(struct btrfs_inode *inode)
 	btrfs_end_transaction(trans);
 	btrfs_btree_balance_dirty(fs_info);
 out:
-	btrfs_release_delayed_node(delayed_node);
+	btrfs_release_delayed_node(delayed_node, &delayed_node_tracker);
 
 	return ret;
 }
@@ -1283,13 +1341,20 @@ int btrfs_commit_inode_delayed_inode(struct btrfs_inode *inode)
 void btrfs_remove_delayed_node(struct btrfs_inode *inode)
 {
 	struct btrfs_delayed_node *delayed_node;
+	struct ref_tracker **tracker;
 
 	delayed_node = READ_ONCE(inode->delayed_node);
 	if (!delayed_node)
 		return;
 
 	inode->delayed_node = NULL;
-	btrfs_release_delayed_node(delayed_node);
+
+#ifdef CONFIG_BTRFS_DEBUG
+	tracker = &delayed_node->inode_cache_tracker;
+#else
+	tracker = NULL;
+#endif
+	btrfs_release_delayed_node(delayed_node, tracker);
 }
 
 struct btrfs_async_delayed_work {
@@ -1305,6 +1370,7 @@ static void btrfs_async_run_delayed_root(struct btrfs_work *work)
 	struct btrfs_trans_handle *trans;
 	struct btrfs_path *path;
 	struct btrfs_delayed_node *delayed_node = NULL;
+	struct ref_tracker *delayed_node_tracker;
 	struct btrfs_root *root;
 	struct btrfs_block_rsv *block_rsv;
 	int total_done = 0;
@@ -1321,7 +1387,8 @@ static void btrfs_async_run_delayed_root(struct btrfs_work *work)
 		    BTRFS_DELAYED_BACKGROUND / 2)
 			break;
 
-		delayed_node = btrfs_first_prepared_delayed_node(delayed_root);
+		delayed_node = btrfs_first_prepared_delayed_node(
+			delayed_root, &delayed_node_tracker);
 		if (!delayed_node)
 			break;
 
@@ -1330,7 +1397,8 @@ static void btrfs_async_run_delayed_root(struct btrfs_work *work)
 		trans = btrfs_join_transaction(root);
 		if (IS_ERR(trans)) {
 			btrfs_release_path(path);
-			btrfs_release_prepared_delayed_node(delayed_node);
+			btrfs_release_prepared_delayed_node(
+				delayed_node, &delayed_node_tracker);
 			total_done++;
 			continue;
 		}
@@ -1345,7 +1413,8 @@ static void btrfs_async_run_delayed_root(struct btrfs_work *work)
 		btrfs_btree_balance_dirty_nodelay(root->fs_info);
 
 		btrfs_release_path(path);
-		btrfs_release_prepared_delayed_node(delayed_node);
+		btrfs_release_prepared_delayed_node(delayed_node,
+						    &delayed_node_tracker);
 		total_done++;
 
 	} while ((async_work->nr == 0 && total_done < BTRFS_DELAYED_WRITEBACK)
@@ -1377,10 +1446,15 @@ static int btrfs_wq_run_delayed_node(struct btrfs_delayed_root *delayed_root,
 
 void btrfs_assert_delayed_root_empty(struct btrfs_fs_info *fs_info)
 {
-	struct btrfs_delayed_node *node = btrfs_first_delayed_node(fs_info->delayed_root);
+	struct ref_tracker *delayed_node_tracker;
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
@@ -1454,13 +1528,15 @@ int btrfs_insert_delayed_dir_index(struct btrfs_trans_handle *trans,
 	struct btrfs_fs_info *fs_info = trans->fs_info;
 	const unsigned int leaf_data_size = BTRFS_LEAF_DATA_SIZE(fs_info);
 	struct btrfs_delayed_node *delayed_node;
+	struct ref_tracker *delayed_node_tracker;
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
 
@@ -1536,7 +1612,7 @@ int btrfs_insert_delayed_dir_index(struct btrfs_trans_handle *trans,
 	mutex_unlock(&delayed_node->mutex);
 
 release_node:
-	btrfs_release_delayed_node(delayed_node);
+	btrfs_release_delayed_node(delayed_node, &delayed_node_tracker);
 	return ret;
 }
 
@@ -1591,10 +1667,11 @@ int btrfs_delete_delayed_dir_index(struct btrfs_trans_handle *trans,
 				   struct btrfs_inode *dir, u64 index)
 {
 	struct btrfs_delayed_node *node;
+	struct ref_tracker *delayed_node_tracker;
 	struct btrfs_delayed_item *item;
 	int ret;
 
-	node = btrfs_get_or_create_delayed_node(dir);
+	node = btrfs_get_or_create_delayed_node(dir, &delayed_node_tracker);
 	if (IS_ERR(node))
 		return PTR_ERR(node);
 
@@ -1635,13 +1712,15 @@ int btrfs_delete_delayed_dir_index(struct btrfs_trans_handle *trans,
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
+	struct ref_tracker *delayed_node_tracker;
+	struct btrfs_delayed_node *delayed_node =
+		btrfs_get_delayed_node(inode, &delayed_node_tracker);
 
 	if (!delayed_node)
 		return -ENOENT;
@@ -1652,12 +1731,12 @@ int btrfs_inode_delayed_dir_index_count(struct btrfs_inode *inode)
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
 
@@ -1668,8 +1747,9 @@ bool btrfs_readdir_get_delayed_items(struct btrfs_inode *inode,
 {
 	struct btrfs_delayed_node *delayed_node;
 	struct btrfs_delayed_item *item;
+	struct ref_tracker *delayed_node_tracker;
 
-	delayed_node = btrfs_get_delayed_node(inode);
+	delayed_node = btrfs_get_delayed_node(inode, &delayed_node_tracker);
 	if (!delayed_node)
 		return false;
 
@@ -1704,6 +1784,8 @@ bool btrfs_readdir_get_delayed_items(struct btrfs_inode *inode,
 	 * insert/delete delayed items in this period. So we also needn't
 	 * requeue or dequeue this delayed node.
 	 */
+	btrfs_delayed_node_ref_tracker_free(delayed_node,
+					    &delayed_node_tracker);
 	refcount_dec(&delayed_node->refs);
 
 	return true;
@@ -1845,17 +1927,18 @@ int btrfs_fill_inode(struct btrfs_inode *inode, u32 *rdev)
 {
 	struct btrfs_fs_info *fs_info = inode->root->fs_info;
 	struct btrfs_delayed_node *delayed_node;
+	struct ref_tracker *delayed_node_tracker;
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
 
@@ -1895,7 +1978,7 @@ int btrfs_fill_inode(struct btrfs_inode *inode, u32 *rdev)
 		inode->index_cnt = (u64)-1;
 
 	mutex_unlock(&delayed_node->mutex);
-	btrfs_release_delayed_node(delayed_node);
+	btrfs_release_delayed_node(delayed_node, &delayed_node_tracker);
 	return 0;
 }
 
@@ -1904,9 +1987,11 @@ int btrfs_delayed_update_inode(struct btrfs_trans_handle *trans,
 {
 	struct btrfs_root *root = inode->root;
 	struct btrfs_delayed_node *delayed_node;
+	struct ref_tracker *delayed_node_tracker;
 	int ret = 0;
 
-	delayed_node = btrfs_get_or_create_delayed_node(inode);
+	delayed_node =
+		btrfs_get_or_create_delayed_node(inode, &delayed_node_tracker);
 	if (IS_ERR(delayed_node))
 		return PTR_ERR(delayed_node);
 
@@ -1926,7 +2011,7 @@ int btrfs_delayed_update_inode(struct btrfs_trans_handle *trans,
 	atomic_inc(&root->fs_info->delayed_root->items);
 release_node:
 	mutex_unlock(&delayed_node->mutex);
-	btrfs_release_delayed_node(delayed_node);
+	btrfs_release_delayed_node(delayed_node, &delayed_node_tracker);
 	return ret;
 }
 
@@ -1934,6 +2019,7 @@ int btrfs_delayed_delete_inode_ref(struct btrfs_inode *inode)
 {
 	struct btrfs_fs_info *fs_info = inode->root->fs_info;
 	struct btrfs_delayed_node *delayed_node;
+	struct ref_tracker *delayed_node_tracker;
 
 	/*
 	 * we don't do delayed inode updates during log recovery because it
@@ -1943,7 +2029,8 @@ int btrfs_delayed_delete_inode_ref(struct btrfs_inode *inode)
 	if (test_bit(BTRFS_FS_LOG_RECOVERING, &fs_info->flags))
 		return -EAGAIN;
 
-	delayed_node = btrfs_get_or_create_delayed_node(inode);
+	delayed_node =
+		btrfs_get_or_create_delayed_node(inode, &delayed_node_tracker);
 	if (IS_ERR(delayed_node))
 		return PTR_ERR(delayed_node);
 
@@ -1970,7 +2057,7 @@ int btrfs_delayed_delete_inode_ref(struct btrfs_inode *inode)
 	atomic_inc(&fs_info->delayed_root->items);
 release_node:
 	mutex_unlock(&delayed_node->mutex);
-	btrfs_release_delayed_node(delayed_node);
+	btrfs_release_delayed_node(delayed_node, &delayed_node_tracker);
 	return 0;
 }
 
@@ -2014,19 +2101,21 @@ static void __btrfs_kill_delayed_node(struct btrfs_delayed_node *delayed_node)
 void btrfs_kill_delayed_inode_items(struct btrfs_inode *inode)
 {
 	struct btrfs_delayed_node *delayed_node;
+	struct ref_tracker *delayed_node_tracker;
 
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
+	struct ref_tracker *delayed_node_trackers[8];
 
 	while (1) {
 		struct btrfs_delayed_node *node;
@@ -2045,6 +2134,9 @@ void btrfs_kill_all_delayed_nodes(struct btrfs_root *root)
 			 * about to be removed from the tree in the loop below
 			 */
 			if (refcount_inc_not_zero(&node->refs)) {
+				btrfs_delayed_node_ref_tracker_alloc(
+					node, &delayed_node_trackers[count],
+					GFP_ATOMIC);
 				delayed_nodes[count] = node;
 				count++;
 			}
@@ -2056,7 +2148,8 @@ void btrfs_kill_all_delayed_nodes(struct btrfs_root *root)
 
 		for (int i = 0; i < count; i++) {
 			__btrfs_kill_delayed_node(delayed_nodes[i]);
-			btrfs_release_delayed_node(delayed_nodes[i]);
+			btrfs_release_delayed_node(delayed_nodes[i],
+						   &delayed_node_trackers[i]);
 		}
 	}
 }
@@ -2064,14 +2157,20 @@ void btrfs_kill_all_delayed_nodes(struct btrfs_root *root)
 void btrfs_destroy_delayed_inodes(struct btrfs_fs_info *fs_info)
 {
 	struct btrfs_delayed_node *curr_node, *prev_node;
+	struct ref_tracker *curr_delayed_node_tracker,
+		*prev_delayed_node_tracker;
 
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
 
@@ -2081,8 +2180,9 @@ void btrfs_log_get_delayed_items(struct btrfs_inode *inode,
 {
 	struct btrfs_delayed_node *node;
 	struct btrfs_delayed_item *item;
+	struct ref_tracker *delayed_node_tracker;
 
-	node = btrfs_get_delayed_node(inode);
+	node = btrfs_get_delayed_node(inode, &delayed_node_tracker);
 	if (!node)
 		return;
 
@@ -2140,6 +2240,7 @@ void btrfs_log_get_delayed_items(struct btrfs_inode *inode,
 	 * delete delayed items.
 	 */
 	ASSERT(refcount_read(&node->refs) > 1);
+	btrfs_delayed_node_ref_tracker_free(node, &delayed_node_tracker);
 	refcount_dec(&node->refs);
 }
 
@@ -2150,8 +2251,9 @@ void btrfs_log_put_delayed_items(struct btrfs_inode *inode,
 	struct btrfs_delayed_node *node;
 	struct btrfs_delayed_item *item;
 	struct btrfs_delayed_item *next;
+	struct ref_tracker *delayed_node_tracker;
 
-	node = btrfs_get_delayed_node(inode);
+	node = btrfs_get_delayed_node(inode, &delayed_node_tracker);
 	if (!node)
 		return;
 
@@ -2183,5 +2285,6 @@ void btrfs_log_put_delayed_items(struct btrfs_inode *inode,
 	 * delete delayed items.
 	 */
 	ASSERT(refcount_read(&node->refs) > 1);
+	btrfs_delayed_node_ref_tracker_free(node, &delayed_node_tracker);
 	refcount_dec(&node->refs);
 }
diff --git a/fs/btrfs/delayed-inode.h b/fs/btrfs/delayed-inode.h
index e6e763ad2d42..4377f60e3457 100644
--- a/fs/btrfs/delayed-inode.h
+++ b/fs/btrfs/delayed-inode.h
@@ -7,6 +7,7 @@
 #ifndef BTRFS_DELAYED_INODE_H
 #define BTRFS_DELAYED_INODE_H
 
+#include <linux/ref_tracker.h>
 #include <linux/types.h>
 #include <linux/rbtree.h>
 #include <linux/spinlock.h>
@@ -63,8 +64,19 @@ struct btrfs_delayed_node {
 	struct rb_root_cached del_root;
 	struct mutex mutex;
 	struct btrfs_inode_item inode_item;
-	refcount_t refs;
+
 	int count;
+	refcount_t refs;
+
+#ifdef CONFIG_BTRFS_DEBUG
+	/* Used to track all references to this delayed node. */
+	struct ref_tracker_dir ref_dir;
+	/* Used to track delayed node reference stored in node list. */
+	struct ref_tracker *node_list_tracker;
+	/* Used to track delayed node reference stored in inode cache. */
+	struct ref_tracker *inode_cache_tracker;
+#endif
+
 	u64 index_cnt;
 	unsigned long flags;
 	/*
@@ -106,6 +118,53 @@ struct btrfs_delayed_item {
 	char data[] __counted_by(data_len);
 };
 
+#ifdef CONFIG_BTRFS_DEBUG
+static inline void btrfs_delayed_node_ref_tracker_dir_init(struct btrfs_delayed_node *node, 
+						       unsigned int quarantine_count,
+						       const char *name)
+{
+	ref_tracker_dir_init(&node->ref_dir, quarantine_count, name);
+}
+
+static inline void btrfs_delayed_node_ref_tracker_dir_exit(struct btrfs_delayed_node *node)
+{
+	ref_tracker_dir_exit(&node->ref_dir);
+}
+
+static inline int btrfs_delayed_node_ref_tracker_alloc(struct btrfs_delayed_node *node,
+						    struct ref_tracker **tracker,
+						    gfp_t gfp)
+{
+	return ref_tracker_alloc(&node->ref_dir, tracker, gfp);
+}
+
+static inline int btrfs_delayed_node_ref_tracker_free(struct btrfs_delayed_node *node,
+						   struct ref_tracker **tracker)
+{
+	return ref_tracker_free(&node->ref_dir, tracker);
+}
+#else
+static inline void btrfs_delayed_node_ref_tracker_dir_init(struct btrfs_delayed_node *node, 
+						       unsigned int quarantine_count,
+						       const char *name) {}
+
+static inline void btrfs_delayed_node_ref_tracker_dir_exit(struct btrfs_delayed_node *node) {}
+
+static inline int btrfs_delayed_node_ref_tracker_alloc(struct btrfs_delayed_node *node,
+						    struct ref_tracker **tracker,
+						    gfp_t gfp)
+{
+	return 0;
+}
+
+static inline int btrfs_delayed_node_ref_tracker_free(struct btrfs_delayed_node *node,
+						   struct ref_tracker **tracker)
+{
+	return 0;
+}
+#endif
+
+
 void btrfs_init_delayed_root(struct btrfs_delayed_root *delayed_root);
 int btrfs_insert_delayed_dir_index(struct btrfs_trans_handle *trans,
 				   const char *name, int name_len,
-- 
2.47.3


