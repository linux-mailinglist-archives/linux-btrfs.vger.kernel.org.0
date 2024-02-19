Return-Path: <linux-btrfs+bounces-2493-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8149785A1AD
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Feb 2024 12:13:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CF361F22153
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Feb 2024 11:13:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4148A2C1AE;
	Mon, 19 Feb 2024 11:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="uRGgrQZP";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="uRGgrQZP"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87C1A2C1A7
	for <linux-btrfs@vger.kernel.org>; Mon, 19 Feb 2024 11:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708341213; cv=none; b=p3ZpMzmpm7ImHRuljZgBh1BZ9s0gvVZMpUhlwdUN7k1GhmXL/Yvp7O2FrGI11nVlrlD8pwNk7gZSGiV1FeAX7x1rYSnp6IAzYDjbpNaCNgUvLIn5oCU8z1jX60Fcp31I1kXQ7qw/ePVzqpU/vddUBQEwqmq0fHkXJHxf/Vizo8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708341213; c=relaxed/simple;
	bh=pwknvToB8ZmrFPzq1VEkhRqtxFnkNskl/qJqTmLLV2c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qGf3xkM87zbvDJA9VLd55fzxOaoZXTbkBB/x4WCSo7dr8QdOuglQo+pKN5FV2S1jeBqWAJjxJovzwUj0OZk1tTraZ22u3s9mA+d4zTvA9dyZug1PAYHmKSo3AYk/9si1Kwdgg0AbdNxzbHvqVmv2iGHFFI2D70dsmh9Iz4S8qVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=uRGgrQZP; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=uRGgrQZP; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D36C51F7F2;
	Mon, 19 Feb 2024 11:13:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1708341209; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EXHR3BNzuFv5BysI6FuP2r5qmz/38PXQYPhGEiEgbKU=;
	b=uRGgrQZP/i818Gwmu3uNBzM+aj+/MMXZ89qNar7BnOrnmY80SO5K8pjl+8/kzTNXusp2MV
	STS7/v0lreBk8a6SyJitjXA1ey3AdyQDetRQ4jWb+Cj7lE1CZC5/upwVqzyjOhpE5GZiic
	e8KP+n8OFDR2DhjHOeq62qD8KkzV/Lo=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1708341209; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EXHR3BNzuFv5BysI6FuP2r5qmz/38PXQYPhGEiEgbKU=;
	b=uRGgrQZP/i818Gwmu3uNBzM+aj+/MMXZ89qNar7BnOrnmY80SO5K8pjl+8/kzTNXusp2MV
	STS7/v0lreBk8a6SyJitjXA1ey3AdyQDetRQ4jWb+Cj7lE1CZC5/upwVqzyjOhpE5GZiic
	e8KP+n8OFDR2DhjHOeq62qD8KkzV/Lo=
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id CC584139C6;
	Mon, 19 Feb 2024 11:13:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id aeThMdk302WJZgAAn2gu4w
	(envelope-from <dsterba@suse.com>); Mon, 19 Feb 2024 11:13:29 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 04/10] btrfs: uninline some static inline helpers from backref.h
Date: Mon, 19 Feb 2024 12:12:54 +0100
Message-ID: <5518300931e3ccefe43a50c59e2219543431d64f.1708339010.git.dsterba@suse.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <cover.1708339010.git.dsterba@suse.com>
References: <cover.1708339010.git.dsterba@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-2.10 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 REPLY(-4.00)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 RCPT_COUNT_TWO(0.00)[2];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-3.00)[100.00%];
	 ARC_NA(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 RCVD_TLS_ALL(0.00)[]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -2.10

There are many helpers doing simple things but not simple enough to
justify the static inline. None of them seems to be on a hot path so
move them to .c.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/backref.c |  90 +++++++++++++++++++++++++++++++++++++++
 fs/btrfs/backref.h | 104 ++++++---------------------------------------
 2 files changed, 102 insertions(+), 92 deletions(-)

diff --git a/fs/btrfs/backref.c b/fs/btrfs/backref.c
index 1b57c8289de6..6514cb1d404a 100644
--- a/fs/btrfs/backref.c
+++ b/fs/btrfs/backref.c
@@ -2856,6 +2856,16 @@ struct btrfs_backref_iter *btrfs_backref_iter_alloc(struct btrfs_fs_info *fs_inf
 	return ret;
 }
 
+static void btrfs_backref_iter_release(struct btrfs_backref_iter *iter)
+{
+	iter->bytenr = 0;
+	iter->item_ptr = 0;
+	iter->cur_ptr = 0;
+	iter->end_ptr = 0;
+	btrfs_release_path(iter->path);
+	memset(&iter->cur_key, 0, sizeof(iter->cur_key));
+}
+
 int btrfs_backref_iter_start(struct btrfs_backref_iter *iter, u64 bytenr)
 {
 	struct btrfs_fs_info *fs_info = iter->fs_info;
@@ -2948,6 +2958,14 @@ int btrfs_backref_iter_start(struct btrfs_backref_iter *iter, u64 bytenr)
 	return ret;
 }
 
+static bool btrfs_backref_iter_is_inline_ref(struct btrfs_backref_iter *iter)
+{
+	if (iter->cur_key.type == BTRFS_EXTENT_ITEM_KEY ||
+	    iter->cur_key.type == BTRFS_METADATA_ITEM_KEY)
+		return true;
+	return false;
+}
+
 /*
  * Go to the next backref item of current bytenr, can be either inlined or
  * keyed.
@@ -3048,6 +3066,19 @@ struct btrfs_backref_node *btrfs_backref_alloc_node(
 	return node;
 }
 
+void btrfs_backref_free_node(struct btrfs_backref_cache *cache,
+			     struct btrfs_backref_node *node)
+{
+	if (node) {
+		ASSERT(list_empty(&node->list));
+		ASSERT(list_empty(&node->lower));
+		ASSERT(node->eb == NULL);
+		cache->nr_nodes--;
+		btrfs_put_root(node->root);
+		kfree(node);
+	}
+}
+
 struct btrfs_backref_edge *btrfs_backref_alloc_edge(
 		struct btrfs_backref_cache *cache)
 {
@@ -3059,6 +3090,52 @@ struct btrfs_backref_edge *btrfs_backref_alloc_edge(
 	return edge;
 }
 
+void btrfs_backref_free_edge(struct btrfs_backref_cache *cache,
+			     struct btrfs_backref_edge *edge)
+{
+	if (edge) {
+		cache->nr_edges--;
+		kfree(edge);
+	}
+}
+
+void btrfs_backref_unlock_node_buffer(struct btrfs_backref_node *node)
+{
+	if (node->locked) {
+		btrfs_tree_unlock(node->eb);
+		node->locked = 0;
+	}
+}
+
+void btrfs_backref_drop_node_buffer(struct btrfs_backref_node *node)
+{
+	if (node->eb) {
+		btrfs_backref_unlock_node_buffer(node);
+		free_extent_buffer(node->eb);
+		node->eb = NULL;
+	}
+}
+
+/*
+ * Drop the backref node from cache without cleaning up its children
+ * edges.
+ *
+ * This can only be called on node without parent edges.
+ * The children edges are still kept as is.
+ */
+void btrfs_backref_drop_node(struct btrfs_backref_cache *tree,
+			     struct btrfs_backref_node *node)
+{
+	ASSERT(list_empty(&node->upper));
+
+	btrfs_backref_drop_node_buffer(node);
+	list_del_init(&node->list);
+	list_del_init(&node->lower);
+	if (!RB_EMPTY_NODE(&node->rb_node))
+		rb_erase(&node->rb_node, &tree->rb_root);
+	btrfs_backref_free_node(tree, node);
+}
+
 /*
  * Drop the backref node from cache, also cleaning up all its
  * upper edges and any uncached nodes in the path.
@@ -3130,6 +3207,19 @@ void btrfs_backref_release_cache(struct btrfs_backref_cache *cache)
 	ASSERT(!cache->nr_edges);
 }
 
+void btrfs_backref_link_edge(struct btrfs_backref_edge *edge,
+			     struct btrfs_backref_node *lower,
+			     struct btrfs_backref_node *upper,
+			     int link_which)
+{
+	ASSERT(upper && lower && upper->level == lower->level + 1);
+	edge->node[LOWER] = lower;
+	edge->node[UPPER] = upper;
+	if (link_which & LINK_LOWER)
+		list_add_tail(&edge->list[LOWER], &lower->upper);
+	if (link_which & LINK_UPPER)
+		list_add_tail(&edge->list[UPPER], &upper->lower);
+}
 /*
  * Handle direct tree backref
  *
diff --git a/fs/btrfs/backref.h b/fs/btrfs/backref.h
index 04b82c512bf1..e8c22cccb5c1 100644
--- a/fs/btrfs/backref.h
+++ b/fs/btrfs/backref.h
@@ -302,25 +302,6 @@ int btrfs_backref_iter_start(struct btrfs_backref_iter *iter, u64 bytenr);
 
 int btrfs_backref_iter_next(struct btrfs_backref_iter *iter);
 
-static inline bool btrfs_backref_iter_is_inline_ref(
-		struct btrfs_backref_iter *iter)
-{
-	if (iter->cur_key.type == BTRFS_EXTENT_ITEM_KEY ||
-	    iter->cur_key.type == BTRFS_METADATA_ITEM_KEY)
-		return true;
-	return false;
-}
-
-static inline void btrfs_backref_iter_release(struct btrfs_backref_iter *iter)
-{
-	iter->bytenr = 0;
-	iter->item_ptr = 0;
-	iter->cur_ptr = 0;
-	iter->end_ptr = 0;
-	btrfs_release_path(iter->path);
-	memset(&iter->cur_key, 0, sizeof(iter->cur_key));
-}
-
 /*
  * Backref cache related structures
  *
@@ -448,83 +429,22 @@ struct btrfs_backref_edge *btrfs_backref_alloc_edge(
 
 #define		LINK_LOWER	(1 << 0)
 #define		LINK_UPPER	(1 << 1)
-static inline void btrfs_backref_link_edge(struct btrfs_backref_edge *edge,
-					   struct btrfs_backref_node *lower,
-					   struct btrfs_backref_node *upper,
-					   int link_which)
-{
-	ASSERT(upper && lower && upper->level == lower->level + 1);
-	edge->node[LOWER] = lower;
-	edge->node[UPPER] = upper;
-	if (link_which & LINK_LOWER)
-		list_add_tail(&edge->list[LOWER], &lower->upper);
-	if (link_which & LINK_UPPER)
-		list_add_tail(&edge->list[UPPER], &upper->lower);
-}
 
-static inline void btrfs_backref_free_node(struct btrfs_backref_cache *cache,
-					   struct btrfs_backref_node *node)
-{
-	if (node) {
-		ASSERT(list_empty(&node->list));
-		ASSERT(list_empty(&node->lower));
-		ASSERT(node->eb == NULL);
-		cache->nr_nodes--;
-		btrfs_put_root(node->root);
-		kfree(node);
-	}
-}
-
-static inline void btrfs_backref_free_edge(struct btrfs_backref_cache *cache,
-					   struct btrfs_backref_edge *edge)
-{
-	if (edge) {
-		cache->nr_edges--;
-		kfree(edge);
-	}
-}
-
-static inline void btrfs_backref_unlock_node_buffer(
-		struct btrfs_backref_node *node)
-{
-	if (node->locked) {
-		btrfs_tree_unlock(node->eb);
-		node->locked = 0;
-	}
-}
-
-static inline void btrfs_backref_drop_node_buffer(
-		struct btrfs_backref_node *node)
-{
-	if (node->eb) {
-		btrfs_backref_unlock_node_buffer(node);
-		free_extent_buffer(node->eb);
-		node->eb = NULL;
-	}
-}
-
-/*
- * Drop the backref node from cache without cleaning up its children
- * edges.
- *
- * This can only be called on node without parent edges.
- * The children edges are still kept as is.
- */
-static inline void btrfs_backref_drop_node(struct btrfs_backref_cache *tree,
-					   struct btrfs_backref_node *node)
-{
-	ASSERT(list_empty(&node->upper));
-
-	btrfs_backref_drop_node_buffer(node);
-	list_del_init(&node->list);
-	list_del_init(&node->lower);
-	if (!RB_EMPTY_NODE(&node->rb_node))
-		rb_erase(&node->rb_node, &tree->rb_root);
-	btrfs_backref_free_node(tree, node);
-}
+void btrfs_backref_link_edge(struct btrfs_backref_edge *edge,
+			     struct btrfs_backref_node *lower,
+			     struct btrfs_backref_node *upper,
+			     int link_which);
+void btrfs_backref_free_node(struct btrfs_backref_cache *cache,
+			     struct btrfs_backref_node *node);
+void btrfs_backref_free_edge(struct btrfs_backref_cache *cache,
+			     struct btrfs_backref_edge *edge);
+void btrfs_backref_unlock_node_buffer(struct btrfs_backref_node *node);
+void btrfs_backref_drop_node_buffer(struct btrfs_backref_node *node);
 
 void btrfs_backref_cleanup_node(struct btrfs_backref_cache *cache,
 				struct btrfs_backref_node *node);
+void btrfs_backref_drop_node(struct btrfs_backref_cache *tree,
+			     struct btrfs_backref_node *node);
 
 void btrfs_backref_release_cache(struct btrfs_backref_cache *cache);
 
-- 
2.42.1


