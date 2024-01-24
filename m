Return-Path: <linux-btrfs+bounces-1691-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D9B183AF88
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jan 2024 18:20:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2BC32861D1
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jan 2024 17:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DED97F7DF;
	Wed, 24 Jan 2024 17:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="Punq1HmE"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C29AC823C2
	for <linux-btrfs@vger.kernel.org>; Wed, 24 Jan 2024 17:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706116773; cv=none; b=oIj+UJw/AbnnuXp2gvdSPkjgELaQzrGIUgmj/ZSSClqaM2M0ArstFP1JOiYfzUS6MAmvGVifiCInoViIfD6ksZz6/d0TVaVuS9gDqpqXwrazNDXswEuwL5JtopYX41Ci1jsmXfIuCW27NreSBz+bFAusWdEZrGiQi1k2awGbAIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706116773; c=relaxed/simple;
	bh=A91SEGVZ6w8WPo7EkD2yYVnZBgZRBSpmv8xgu+YqsXc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sTXFyjMYv8iu7ceGnVUbJ7RKSFRVHje9xgpd38EsuGDhf80ab7psT5IfjL5Nql9X/ed+fxK90+teJFdwmWFDLAb4rLIqQfcqh8/Yb713TeRgEa5KrCkYt54ZZftCYVN7Zj5gl8B7EnAmOgdXeNWmkbff5Etb5XySxhnG9ZGMOfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=Punq1HmE; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-5ffb07bdce2so44411757b3.2
        for <linux-btrfs@vger.kernel.org>; Wed, 24 Jan 2024 09:19:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1706116770; x=1706721570; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j7kcq+nbIyIhOBXk7WmxEmQC1W0JDTL0FPaZQmHC68U=;
        b=Punq1HmESyIS4TDnp7r5q0FCXYwFAhfBfJb6lonCtLVGvYRYPi0tBbE4ntru/12mrN
         FeEC1oxJvRculDSNdU4/z2W+A+S3A0yKIbB7JCVk6soONV/+CPKPmsfEweajthTN+v39
         d4b2QykegR8euhLMTh75sPJMau00OFyoESka65QB9JEtWLhpXL0XQTXYGPEZAerg+iHN
         CZs8TnCVrAxfx/bMQiLSzPUIyiext8C5HDWFQHPVWCPZmTwPIMJ9MJ9R5o2sWnXnX29M
         0SHqwLVFceyNKmmqbPUYRR56Obl9CD5EjanbMUBLXd6ViHWmBcm9bok7+s0FmXsP4hP+
         zUNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706116770; x=1706721570;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j7kcq+nbIyIhOBXk7WmxEmQC1W0JDTL0FPaZQmHC68U=;
        b=MitV849psymuVRQqugr9/xq+LV8u6xADOUeA8mGRjITGA+4rOvdkJcbEEV4Y4HghOt
         WsLEdGLvZGuKqZcz/7/VmSjrGMBmwE3jvKdniAT9HjxQ48ztN3u5eZvb/7E3QO0EOEWj
         7jitzJd7hwfOp5Z8OlAOCWomOTeNjz05LlV4sGJbOmK26nuKyisIwTGowenldSsHLDi2
         +tuYKGnAsYSokAqG5qkUwD5JOhbZ+1xIDpAPhJU168+9k6Uwjmv7apEHh6QKqoPEUxVu
         B7rYWtIgsra+Yj0NJ1yaXjfPDbeCh9pQUxiE3p65aJDXng2YCeijFxs8QO7EdMjujmr8
         85Vw==
X-Gm-Message-State: AOJu0Ywv50/qOIb3I5B2Kx3uJh/Nf5+rEttUh36QYwJ+aDUacRvuZYow
	DTScMackTjrI/WCcwckDzHq82vZ+ujEcXb77WZFj3Ikb3XWMvaze+TlcptjPF44HoOSlElYejBf
	U
X-Google-Smtp-Source: AGHT+IG2gzsPxrsdfQd9vQlqr9SIVXfSycekDIRJ7PhijTnfkvmYeakkrotuMT+WhLEMaZ2aoTzIrA==
X-Received: by 2002:a0d:e252:0:b0:5ef:f83d:ab23 with SMTP id l79-20020a0de252000000b005eff83dab23mr1202472ywe.5.1706116770603;
        Wed, 24 Jan 2024 09:19:30 -0800 (PST)
Received: from localhost (076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id cn23-20020a05690c0d1700b005ff95e9a554sm60004ywb.127.2024.01.24.09.19.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 09:19:30 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH v5 09/52] btrfs: add infrastructure for safe em freeing
Date: Wed, 24 Jan 2024 12:18:31 -0500
Message-ID: <6cf44f7860e94de68df242e69f4c5250bd061cff.1706116485.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1706116485.git.josef@toxicpanda.com>
References: <cover.1706116485.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When we add fscrypt support we're going to have fscrypt objects hanging
off of extent_maps.  This includes a block key, which if we're the last
one freeing the key we may have to unregister it from the block layer.
This requires taking a semaphore in the block layer, which means we
can't free em's under the extent map tree lock.

Thankfully we only do this in two places, one where we're dropping a
range of extent maps, and when we're freeing logged extents.  Add a
free_extent_map_safe() which will add the em to a list in the em_tree if
we free'd the object.  Currently this is unconditional but will be
changed to conditional on the fscrypt object we will add in a later
patch.

To process these delayed objects add a free_pending_extent_maps() that
is called after the lock has been dropped on the em_tree.  This will
process the extent maps on the freed list and do the appropriate freeing
work in a safe manner.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/extent_map.c | 76 +++++++++++++++++++++++++++++++++++++++++--
 fs/btrfs/extent_map.h | 10 ++++++
 fs/btrfs/tree-log.c   |  6 ++--
 3 files changed, 87 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/extent_map.c b/fs/btrfs/extent_map.c
index b61099bf97a8..f8705103819c 100644
--- a/fs/btrfs/extent_map.c
+++ b/fs/btrfs/extent_map.c
@@ -35,7 +35,9 @@ void __cold extent_map_exit(void)
 void extent_map_tree_init(struct extent_map_tree *tree)
 {
 	tree->map = RB_ROOT_CACHED;
+	tree->flags = 0;
 	INIT_LIST_HEAD(&tree->modified_extents);
+	INIT_LIST_HEAD(&tree->freed_extents);
 	rwlock_init(&tree->lock);
 }
 
@@ -52,9 +54,15 @@ struct extent_map *alloc_extent_map(void)
 	RB_CLEAR_NODE(&em->rb_node);
 	refcount_set(&em->refs, 1);
 	INIT_LIST_HEAD(&em->list);
+	INIT_LIST_HEAD(&em->free_list);
 	return em;
 }
 
+static void __free_extent_map(struct extent_map *em)
+{
+	kmem_cache_free(extent_map_cache, em);
+}
+
 /*
  * Drop the reference out on @em by one and free the structure if the reference
  * count hits zero.
@@ -66,10 +74,69 @@ void free_extent_map(struct extent_map *em)
 	if (refcount_dec_and_test(&em->refs)) {
 		WARN_ON(extent_map_in_tree(em));
 		WARN_ON(!list_empty(&em->list));
-		kmem_cache_free(extent_map_cache, em);
+		__free_extent_map(em);
 	}
 }
 
+/*
+ * Drop a ref for the extent map in the given tree.
+ *
+ * @tree:	tree that the em is a part of.
+ * @em:		the em to drop the reference to.
+ *
+ * Drop the reference count on @em by one, if the reference count hits 0 and
+ * there is an object on the em that can't be safely freed in the current
+ * context (if we are holding the extent_map_tree->lock for example), then add
+ * it to the freed_extents list on the extent_map_tree for later processing.
+ *
+ * This must be followed by a free_pending_extent_maps() to clear the pending
+ * frees.
+ */
+void free_extent_map_safe(struct extent_map_tree *tree,
+			  struct extent_map *em)
+{
+	lockdep_assert_held_write(&tree->lock);
+
+	if (!em)
+		return;
+
+	if (refcount_dec_and_test(&em->refs)) {
+		WARN_ON(extent_map_in_tree(em));
+		WARN_ON(!list_empty(&em->list));
+		list_add_tail(&em->free_list, &tree->freed_extents);
+		set_bit(EXTENT_MAP_TREE_PENDING_FREES, &tree->flags);
+	}
+}
+
+/*
+ * Free the em objects that exist on the em tree
+ *
+ * @tree:	the tree to free the objects from.
+ *
+ * If there are any objects on the em->freed_extents list go ahead and free them
+ * here in a safe way.  This is to be coupled with any uses of
+ * free_extent_map_safe().
+ */
+void free_pending_extent_maps(struct extent_map_tree *tree)
+{
+	struct extent_map *em;
+
+	/* Avoid taking the write lock if we don't have any pending frees. */
+	if (!test_and_clear_bit(EXTENT_MAP_TREE_PENDING_FREES, &tree->flags))
+		return;
+
+	write_lock(&tree->lock);
+	while ((em = list_first_entry_or_null(&tree->freed_extents,
+					      struct extent_map, free_list))) {
+		list_del_init(&em->free_list);
+		write_unlock(&tree->lock);
+		__free_extent_map(em);
+		cond_resched();
+		write_lock(&tree->lock);
+	}
+	write_unlock(&tree->lock);
+}
+
 /* Do the math around the end of an extent, handling wrapping. */
 static u64 range_end(u64 start, u64 len)
 {
@@ -654,10 +721,12 @@ static void drop_all_extent_maps_fast(struct extent_map_tree *tree)
 		em = rb_entry(node, struct extent_map, rb_node);
 		em->flags &= ~(EXTENT_FLAG_PINNED | EXTENT_FLAG_LOGGING);
 		remove_extent_mapping(tree, em);
-		free_extent_map(em);
+		free_extent_map_safe(tree, em);
 		cond_resched_rwlock_write(&tree->lock);
 	}
 	write_unlock(&tree->lock);
+
+	free_pending_extent_maps(tree);
 }
 
 /*
@@ -875,13 +944,14 @@ void btrfs_drop_extent_map_range(struct btrfs_inode *inode, u64 start, u64 end,
 		free_extent_map(em);
 next:
 		/* Once for us (for our lookup reference). */
-		free_extent_map(em);
+		free_extent_map_safe(em_tree, em);
 
 		em = next_em;
 	}
 
 	write_unlock(&em_tree->lock);
 
+	free_pending_extent_maps(em_tree);
 	free_extent_map(split);
 	free_extent_map(split2);
 }
diff --git a/fs/btrfs/extent_map.h b/fs/btrfs/extent_map.h
index e380fc08bbe4..d31f2a03670e 100644
--- a/fs/btrfs/extent_map.h
+++ b/fs/btrfs/extent_map.h
@@ -55,11 +55,18 @@ struct extent_map {
 	u32 flags;
 	refcount_t refs;
 	struct list_head list;
+	struct list_head free_list;
+};
+
+enum extent_map_flags {
+	EXTENT_MAP_TREE_PENDING_FREES,
 };
 
 struct extent_map_tree {
 	struct rb_root_cached map;
+	unsigned long flags;
 	struct list_head modified_extents;
+	struct list_head freed_extents;
 	rwlock_t lock;
 };
 
@@ -122,6 +129,9 @@ int split_extent_map(struct btrfs_inode *inode, u64 start, u64 len, u64 pre,
 
 struct extent_map *alloc_extent_map(void);
 void free_extent_map(struct extent_map *em);
+void free_extent_map_safe(struct extent_map_tree *tree,
+			  struct extent_map *em);
+void free_pending_extent_maps(struct extent_map_tree *tree);
 int __init extent_map_init(void);
 void __cold extent_map_exit(void);
 int unpin_extent_cache(struct btrfs_inode *inode, u64 start, u64 len, u64 gen);
diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 331fc7429952..916e54b91ecc 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -4884,7 +4884,7 @@ static int btrfs_log_changed_extents(struct btrfs_trans_handle *trans,
 		 */
 		if (ret) {
 			clear_em_logging(tree, em);
-			free_extent_map(em);
+			free_extent_map_safe(tree, em);
 			continue;
 		}
 
@@ -4893,11 +4893,13 @@ static int btrfs_log_changed_extents(struct btrfs_trans_handle *trans,
 		ret = log_one_extent(trans, inode, em, path, ctx);
 		write_lock(&tree->lock);
 		clear_em_logging(tree, em);
-		free_extent_map(em);
+		free_extent_map_safe(tree, em);
 	}
 	WARN_ON(!list_empty(&extents));
 	write_unlock(&tree->lock);
 
+	free_pending_extent_maps(tree);
+
 	if (!ret)
 		ret = btrfs_log_prealloc_extents(trans, inode, path);
 	if (ret)
-- 
2.43.0


