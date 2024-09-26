Return-Path: <linux-btrfs+bounces-8268-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 776E3987681
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Sep 2024 17:28:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 996A21C21386
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Sep 2024 15:28:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B349014D70F;
	Thu, 26 Sep 2024 15:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="ziWqze4j"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26200132139
	for <linux-btrfs@vger.kernel.org>; Thu, 26 Sep 2024 15:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727364485; cv=none; b=GLAPiQstj2Rn6ONTBfHVZ6DRmhUmEBo1TtD74morzaDobr4q0B3uh+JLrxCKlAscO9pz5PkkDgMmbLHUhe+IK8bYYBLV/ZBxoIficd793vignzR+qVyTnwGHy3qvizva9GR2hGRdVFIz0FM7b0I6Xbj5Bg3iIyi4WKLEpkuuT2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727364485; c=relaxed/simple;
	bh=rEfB5Hpjcg7xRZHA0gQSGFbP4BGJq/Y5/N+J7RTlKac=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rTVKtN0ooAeSPGGdyAawWJs7ssMlDcNAXi0b5aNjz1Yyr/13dY359YIDBCrO3O8FN2DyIoqkiEJoSowqpEN71kdI2StOqNDKN3ivNTFJRxGRCvQhfBJ+nmptluZl2HcMA1fk/FXjwewh/xr9pJlananHhnvUD1icIzCigVsf44k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=ziWqze4j; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e25cf3c7278so777904276.3
        for <linux-btrfs@vger.kernel.org>; Thu, 26 Sep 2024 08:28:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1727364482; x=1727969282; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IYxTMIJYtEcyqMbG1j/lJfbh1tgoURUED47VmaAmgG4=;
        b=ziWqze4jonRhNJEG9eCuqpOkbn4dWWhzLEQ+pn25P9ya2IQkboyfhUVON7lSdwGTLX
         ZsSWemhP26EHluvFc6VY8qnwdingTvOercHTPHXL9UmvooFp2Cd+9Ini11QJhJJl+5gA
         GvX9NnlfDC/g+fguQF345IZamek7/UlFGfFT18PqFn8n/xb7A4rKfzfto+KGCBHoP3tE
         XkybDBBsH6FMD9JFRSY78T1Q8bW7CNQqES5qGLXBLoAFX6AMoxeaLrdW0d4500P1u+gF
         AdQJrsgmNMY+O7n6KJnFRaQDLXLV0qZYZnDKWLvHiwRLruul1lzjGKR1oi4OrmRyJDvR
         yhSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727364482; x=1727969282;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IYxTMIJYtEcyqMbG1j/lJfbh1tgoURUED47VmaAmgG4=;
        b=lXXFoa9xhw/usCsuiBpLfeMVKrG/xonPjdn1oCgg8UEKCI/NizoUWDA/n6odnSsLff
         bGZp/2XXl5wEITlqdFWQ5/2jmtm0HQ+t9nlBxuzFG2Nm/qQlJz8Y03l3Sf7S755ATfYW
         Khze3vd6WKM8tIVfiThSljVVKX/0wSHxnBZqM1ZuIC6l4sOuStU19GsQBsTtVDmrGKjl
         vQBQel4eNCQwfcVavvGpttXaiExREL5vnSRFUjsBAamoFMJEH0b67YzhUl7DSSw+zj4l
         AGDRssV8lJUaHCKOAm31Gg80mWdJUs/4hBuAxL3SjHjzXJbTQBpYFSlHoyl6hGDIIIV2
         azwg==
X-Gm-Message-State: AOJu0YzpFP8RvGNSm3V82jURjmE3X0aeSkELAxeSj9sCzbfkNIAhnnaZ
	BlnUMsvVDkP+U+sIW+1ImxYKCgaeyC177ESEyviXIxOdP5BjM+qAOfAolLLlZWq+ouLx4fLyOwZ
	J
X-Google-Smtp-Source: AGHT+IH81f1Xl63uVw5FJxSyiQADqcbWbHehBGRcauaW624fvJFG8y2FfHau3Oz0W/eTfvLh51lL2w==
X-Received: by 2002:a05:6902:118f:b0:e1d:ad92:d748 with SMTP id 3f1490d57ef6-e24d7823d82mr5418917276.8.1727364482532;
        Thu, 26 Sep 2024 08:28:02 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e25e6c31c4bsm15937276.62.2024.09.26.08.28.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2024 08:28:01 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Cc: stable@vger.kernel.org,
	Boris Burkov <boris@bur.io>
Subject: [PATCH v2] btrfs: drop the backref cache during relocation if we commit
Date: Thu, 26 Sep 2024 11:27:56 -0400
Message-ID: <6db9c462e7fd4c4923c222c9f4cc286946e12afc.1727364472.git.josef@toxicpanda.com>
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
Reviewed-by: Boris Burkov <boris@bur.io>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/backref.c    | 12 ++++---
 fs/btrfs/relocation.c | 75 ++-----------------------------------------
 2 files changed, 11 insertions(+), 76 deletions(-)

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
index ea4ed85919ec..cf1dfeaaf2d8 100644
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
@@ -3698,11 +3631,9 @@ static noinline_for_stack int relocate_block_group(struct reloc_control *rc)
 			break;
 		}
 restart:
-		if (update_backref_cache(trans, &rc->backref_cache)) {
-			btrfs_end_transaction(trans);
-			trans = NULL;
-			continue;
-		}
+		if (rc->backref_cache.last_trans != trans->transid)
+			btrfs_backref_release_cache(&rc->backref_cache);
+		rc->backref_cache.last_trans = trans->transid;
 
 		ret = find_next_extent(rc, path, &key);
 		if (ret < 0)
-- 
2.43.0


