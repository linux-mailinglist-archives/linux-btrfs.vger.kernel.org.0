Return-Path: <linux-btrfs+bounces-8204-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BAAF6984C95
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Sep 2024 23:11:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45CD51F24991
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Sep 2024 21:11:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EF4713DDB9;
	Tue, 24 Sep 2024 21:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="tagKePUV"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DF6013CFA5
	for <linux-btrfs@vger.kernel.org>; Tue, 24 Sep 2024 21:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727212306; cv=none; b=VUWcIvaImKM804hXZ3mSQ1ongiMvuR1lpvWXY1hhxZ16rqWmqtdKwTda/Stt/zx1g2rJYz281piya4N5PXCAwE/U6oIsBK0yhjG7HRQkE2mEkD4wpC42SeisRpHk1+YoVumkRKQSdCFiX96uuOc/cjU5ZEBgz3SPD6sT5fYn4NM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727212306; c=relaxed/simple;
	bh=tnqLo0XIue4Z3wHUlnSUUK4HL/FiRaMM4yEFDQbxv5o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eYkzTAIkRgyI939DL2rb4uINaXfOVuC7HwliSkLnlDllDi5jbOSrObZ8U50FSxQU4eBZ77WpyCmo4MwpkSRmTkyxsE1e9Yg8EXY1yyO3O0yV1GrlHi7OFomI7LclHbMqLY44nLdNGf9HyRwtDezszxcS5grgDShG/GEqZEDO6/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=tagKePUV; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-6e1f48e7c18so23247097b3.3
        for <linux-btrfs@vger.kernel.org>; Tue, 24 Sep 2024 14:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1727212303; x=1727817103; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=p4gSwcrx2D3Z2LvMOpdxJci412zEjS/9V/3phabBvE0=;
        b=tagKePUVhde6FBo6yC7gAcAPG7q2PhjwbqjJqAhMrHtDpFXuPH3xnczPzyHixb8C9i
         X4dSZzS2fKO3CVKuQaa1iaUXi5zSjeOv5oCK0psY9os3QpM1k89UsPk72b626m2BFOqM
         EMw3ZyV5A6gs6+Sr/7dnfeFb5nuQH8SBPp6Sj9KbZqKxuhJh400HYA7DXMyVFY4uFOfS
         yHMizI/x3OUivO/VPi3FIY4fEJtjJFgPkXo9UWChHGpVyMFmTLISpcsvwsLz2zVgcb1A
         KQEe5/T2q85f9SROF8Eky5nYClywwGIxh5la4mhTEFjxkOSiJg2+lk5NPAUyIehPVh58
         VIxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727212303; x=1727817103;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p4gSwcrx2D3Z2LvMOpdxJci412zEjS/9V/3phabBvE0=;
        b=qlSfnFlSFZr3tuHmew348QgN3hvoJixxt1ncYJDRBwUqZ8zGFZPR5KHd+8P9iucJ8z
         ZQJOOUrhV3heyy+orjBpSFFjYH9t8utHsUrVFuRT08lwIiWZQJXW1syGA3kgRM4UTGPO
         pgOgMq0xnefh97uE0o74iRSu3nM9djc4pbVE3wvh+8MtNqJXOJNgfPypq05EgsKwhQGD
         Rq1mphyaoos6JlzFz9EcBEJQKDmFDu+9vYlzTtbqShiArZLC8dVXDYIvW6glHYIijq/e
         yXINdh4XL+nrqTcZ7H7ySbBLuyVe1Pu36Kuw4il39GVOrPr2Y+nZh1AGJT6s1AEmjcLX
         9RPQ==
X-Gm-Message-State: AOJu0YwPjnwZxMsGDfGvVOW1+t11z629bT2+0jdY7PrgVs/p0BQMgPxy
	prbWjYBsG8bjTbAoeJtaqub/ExCTGt3E55FW7umINA2wjkReOUMd4auW3fuFTPp9aUoxEI59bW/
	E
X-Google-Smtp-Source: AGHT+IGOJn1SA8z0t9ifuOGYmhYI7orQ3ak5PAjYWiVCNbieRdTwopcqXtciyMVHil2XBvTq936lFA==
X-Received: by 2002:a05:690c:112:b0:6e2:1570:2d4a with SMTP id 00721157ae682-6e21da61dd8mr6919587b3.30.1727212302864;
        Tue, 24 Sep 2024 14:11:42 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e20d28062dsm3791977b3.125.2024.09.24.14.11.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2024 14:11:41 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Cc: stable@vger.kernel.org
Subject: [PATCH] btrfs: drop the backref cache during relocation if we commit
Date: Tue, 24 Sep 2024 17:11:37 -0400
Message-ID: <68766e66ed15ca2e7550585ed09434249db912a2.1727212293.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since the inception of relocation we have maintained the backref cache
across transaction commits, updating the backref cache with the new
bytenr whenever we COW'ed blocks that were in the cache, and then
updating their bytenr once we detected a transaction id change.

This works as long as we're only ever modifying blocks, not changing the
structure of the tree.

However relocation does in fact change the structure of the tree.  For
example, if we are relocating a data extent, we will look up all the
leaves that point to this data extent.  We will then call
do_relocation() on each of these leaves, which will COW down to the leaf
and then update the file extent location.

But, a key feature of do_relocation is the pending list.  This is all
the pending nodes that we modified when we updated the file extent item.
We will then process all of these blocks via finish_pending_nodes, which
calls do_relocation() on all of the nodes that led up to that leaf.

The purpose of this is to make sure we don't break sharing unless we
absolutely have to.  Consider the case that we have 3 snapshots that all
point to this leaf through the same nodes, the initial COW would have
created a whole new path.  If we did this for all 3 snapshots we would
end up with 3x the number of nodes we had originally.  To avoid this we
will cycle through each of the snapshots that point to each of these
nodes and update their pointers to point at the new nodes.

Once we update the pointer to the new node we will drop the node we
removed the link for and all of its children via btrfs_drop_subtree().
This is essentially just btrfs_drop_snapshot(), but for an arbitrary
point in the snapshot.

The problem with this is that we will never reflect this in the backref
cache.  If we do this btrfs_drop_snapshot() for a node that is in the
backref tree, we will leave the node in the backref tree.  This becomes
a problem when we change the transid, as now the backref cache has
entire subtrees that no longer exist, but exist as if they still are
pointed to by the same roots.

In the best case scenario you end up with "adding refs to an existing
tree ref" errors from insert_inline_extent_backref(), where we attempt
to link in nodes on roots that are no longer valid.

Worst case you will double free some random block and re-use it when
there's still references to the block.

This is extremely subtle, and the consequences are quite bad.  There
isn't a way to make sure our backref cache is consistent between
transid's.

In order to fix this we need to simply evict the entire backref cache
anytime we cross transid's.  This reduces performance in that we have to
rebuild this backref cache every time we change transid's, but fixes the
bug.

This has existed since relocation was added, and is a pretty critical
bug.  There's a lot more cleanup that can be done now that this
functionality is going away, but this patch is as small as possible in
order to fix the problem and make it easy for us to backport it to all
the kernels it needs to be backported to.

Followup series will dismantle more of this code and simplify relocation
drastically to remove this functionality.

We have a reproducer that reproduced the corruption within a few minutes
of running.  With this patch it survives several iterations/hours of
running the reproducer.

Fixes: 3fd0a5585eb9 ("Btrfs: Metadata ENOSPC handling for balance")
Cc: stable@vger.kernel.org
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/backref.c    | 12 ++++---
 fs/btrfs/relocation.c | 76 +++----------------------------------------
 2 files changed, 13 insertions(+), 75 deletions(-)

diff --git a/fs/btrfs/backref.c b/fs/btrfs/backref.c
index e2f478ecd7fd..f8e1d5b2c512 100644
--- a/fs/btrfs/backref.c
+++ b/fs/btrfs/backref.c
@@ -3179,10 +3179,14 @@ void btrfs_backref_release_cache(struct btrfs_backref_cache *cache)
 		btrfs_backref_cleanup_node(cache, node);
 	}
 
-	cache->last_trans = 0;
-
-	for (i = 0; i < BTRFS_MAX_LEVEL; i++)
-		ASSERT(list_empty(&cache->pending[i]));
+	for (i = 0; i < BTRFS_MAX_LEVEL; i++) {
+		while (!list_empty(&cache->pending[i])) {
+			node = list_first_entry(&cache->pending[i],
+						struct btrfs_backref_node,
+						list);
+			btrfs_backref_cleanup_node(cache, node);
+		}
+	}
 	ASSERT(list_empty(&cache->pending_edge));
 	ASSERT(list_empty(&cache->useless_node));
 	ASSERT(list_empty(&cache->changed));
diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index ea4ed85919ec..aaa9cac213f1 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -232,70 +232,6 @@ static struct btrfs_backref_node *walk_down_backref(
 	return NULL;
 }
 
-static void update_backref_node(struct btrfs_backref_cache *cache,
-				struct btrfs_backref_node *node, u64 bytenr)
-{
-	struct rb_node *rb_node;
-	rb_erase(&node->rb_node, &cache->rb_root);
-	node->bytenr = bytenr;
-	rb_node = rb_simple_insert(&cache->rb_root, node->bytenr, &node->rb_node);
-	if (rb_node)
-		btrfs_backref_panic(cache->fs_info, bytenr, -EEXIST);
-}
-
-/*
- * update backref cache after a transaction commit
- */
-static int update_backref_cache(struct btrfs_trans_handle *trans,
-				struct btrfs_backref_cache *cache)
-{
-	struct btrfs_backref_node *node;
-	int level = 0;
-
-	if (cache->last_trans == 0) {
-		cache->last_trans = trans->transid;
-		return 0;
-	}
-
-	if (cache->last_trans == trans->transid)
-		return 0;
-
-	/*
-	 * detached nodes are used to avoid unnecessary backref
-	 * lookup. transaction commit changes the extent tree.
-	 * so the detached nodes are no longer useful.
-	 */
-	while (!list_empty(&cache->detached)) {
-		node = list_entry(cache->detached.next,
-				  struct btrfs_backref_node, list);
-		btrfs_backref_cleanup_node(cache, node);
-	}
-
-	while (!list_empty(&cache->changed)) {
-		node = list_entry(cache->changed.next,
-				  struct btrfs_backref_node, list);
-		list_del_init(&node->list);
-		BUG_ON(node->pending);
-		update_backref_node(cache, node, node->new_bytenr);
-	}
-
-	/*
-	 * some nodes can be left in the pending list if there were
-	 * errors during processing the pending nodes.
-	 */
-	for (level = 0; level < BTRFS_MAX_LEVEL; level++) {
-		list_for_each_entry(node, &cache->pending[level], list) {
-			BUG_ON(!node->pending);
-			if (node->bytenr == node->new_bytenr)
-				continue;
-			update_backref_node(cache, node, node->new_bytenr);
-		}
-	}
-
-	cache->last_trans = 0;
-	return 1;
-}
-
 static bool reloc_root_is_dead(const struct btrfs_root *root)
 {
 	/*
@@ -551,9 +487,6 @@ static int clone_backref_node(struct btrfs_trans_handle *trans,
 	struct btrfs_backref_edge *new_edge;
 	struct rb_node *rb_node;
 
-	if (cache->last_trans > 0)
-		update_backref_cache(trans, cache);
-
 	rb_node = rb_simple_search(&cache->rb_root, src->commit_root->start);
 	if (rb_node) {
 		node = rb_entry(rb_node, struct btrfs_backref_node, rb_node);
@@ -3698,10 +3631,11 @@ static noinline_for_stack int relocate_block_group(struct reloc_control *rc)
 			break;
 		}
 restart:
-		if (update_backref_cache(trans, &rc->backref_cache)) {
-			btrfs_end_transaction(trans);
-			trans = NULL;
-			continue;
+		if (rc->backref_cache.last_trans == 0) {
+			rc->backref_cache.last_trans = trans->transid;
+		} else if (rc->backref_cache.last_trans != trans->transid) {
+			btrfs_backref_release_cache(&rc->backref_cache);
+			rc->backref_cache.last_trans = trans->transid;
 		}
 
 		ret = find_next_extent(rc, path, &key);
-- 
2.43.0


