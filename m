Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 016B2614F04
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Nov 2022 17:16:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230443AbiKAQQQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 1 Nov 2022 12:16:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230413AbiKAQQN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 1 Nov 2022 12:16:13 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D048B1C916
        for <linux-btrfs@vger.kernel.org>; Tue,  1 Nov 2022 09:16:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 40F9BB81D9F
        for <linux-btrfs@vger.kernel.org>; Tue,  1 Nov 2022 16:16:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A91DC433B5
        for <linux-btrfs@vger.kernel.org>; Tue,  1 Nov 2022 16:16:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667319367;
        bh=gwnepN1AGl2YxeYhEAprjo9N3Z1TrFVA9NWB4LiH/RI=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=KlFzUtkKTVdhgIsT9TQ1yDmFFe7x1W0xW+/PxYLh/pGAYtEB/e0xMWofsOJIPoccb
         BE5bEjKR3ccN2frKi6RF+KM9rsOJ7Mv67kH84UE0tmBsLJctgJUFML+QfngBOexDPD
         A3j5WuFCB5jgLXQ/WkCURbPEWzFDHu+QiHeIwcB+GQhV/xtMmtcQeM7PnyfGDQuHKX
         7I67Tokuy98KaQ/fUVBnAS58tQtcuPluJrgfVp8tV0Fc05Aii0fi+xr3mBCEh8MSIk
         nRQbRUyf3Nb56cEplQwOmldqE+1JOhKY3nMb7PHOACzM4nr9T7TGr8QT5B1eqq59FM
         mvYuL+3PNdYLA==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 11/18] btrfs: use a structure to pass arguments to backref walking functions
Date:   Tue,  1 Nov 2022 16:15:47 +0000
Message-Id: <4676b4de2371f8aae5a195f2cd3625faf4085271.1667315100.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1667315100.git.fdmanana@suse.com>
References: <cover.1667315100.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

The public backref walking functions have quite a lot of arguments that
are passed down the call stack to find_parent_nodes(), the core function
of the backref walking code.

The next patches in series will need to add even arguments to these
functions that should be passed not only to find_parent_nodes(), but also
to other functions used by the later (directly or even lower in the call
stack).

So create a structure to hold all these arguments and state used by the
main backref walking function, find_parent_nodes(), and use it as the
argument for the public backref walking functions iterate_extent_inodes(),
btrfs_find_all_leafs() and btrfs_find_all_roots().

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/backref.c            | 343 +++++++++++++++++-----------------
 fs/btrfs/backref.h            |  76 ++++++--
 fs/btrfs/qgroup.c             |  38 ++--
 fs/btrfs/relocation.c         |  19 +-
 fs/btrfs/scrub.c              |  14 +-
 fs/btrfs/send.c               |  15 +-
 fs/btrfs/tests/qgroup-tests.c |  50 ++++-
 7 files changed, 328 insertions(+), 227 deletions(-)

diff --git a/fs/btrfs/backref.c b/fs/btrfs/backref.c
index 432064ee788e..a1a00a7bdba5 100644
--- a/fs/btrfs/backref.c
+++ b/fs/btrfs/backref.c
@@ -444,12 +444,12 @@ static int is_shared_data_backref(struct preftrees *preftrees, u64 bytenr)
 	return 0;
 }
 
-static int add_all_parents(struct btrfs_root *root, struct btrfs_path *path,
+static int add_all_parents(struct btrfs_backref_walk_ctx *ctx,
+			   struct btrfs_root *root, struct btrfs_path *path,
 			   struct ulist *parents,
 			   struct preftrees *preftrees, struct prelim_ref *ref,
-			   int level, u64 time_seq, u64 extent_item_pos)
+			   int level)
 {
-	const bool ignore_offset = (extent_item_pos == BTRFS_IGNORE_EXTENT_OFFSET);
 	int ret = 0;
 	int slot;
 	struct extent_buffer *eb;
@@ -484,10 +484,10 @@ static int add_all_parents(struct btrfs_root *root, struct btrfs_path *path,
 	if (path->slots[0] >= btrfs_header_nritems(eb) ||
 	    is_shared_data_backref(preftrees, eb->start) ||
 	    ref->root_id != btrfs_header_owner(eb)) {
-		if (time_seq == BTRFS_SEQ_LAST)
+		if (ctx->time_seq == BTRFS_SEQ_LAST)
 			ret = btrfs_next_leaf(root, path);
 		else
-			ret = btrfs_next_old_leaf(root, path, time_seq);
+			ret = btrfs_next_old_leaf(root, path, ctx->time_seq);
 	}
 
 	while (!ret && count < ref->count) {
@@ -508,10 +508,10 @@ static int add_all_parents(struct btrfs_root *root, struct btrfs_path *path,
 		if (slot == 0 &&
 		    (is_shared_data_backref(preftrees, eb->start) ||
 		     ref->root_id != btrfs_header_owner(eb))) {
-			if (time_seq == BTRFS_SEQ_LAST)
+			if (ctx->time_seq == BTRFS_SEQ_LAST)
 				ret = btrfs_next_leaf(root, path);
 			else
-				ret = btrfs_next_old_leaf(root, path, time_seq);
+				ret = btrfs_next_old_leaf(root, path, ctx->time_seq);
 			continue;
 		}
 		fi = btrfs_item_ptr(eb, slot, struct btrfs_file_extent_item);
@@ -525,9 +525,9 @@ static int add_all_parents(struct btrfs_root *root, struct btrfs_path *path,
 				count++;
 			else
 				goto next;
-			if (!ignore_offset) {
+			if (!ctx->ignore_extent_item_pos) {
 				ret = check_extent_in_eb(&key, eb, fi,
-							 extent_item_pos, &eie);
+							 ctx->extent_item_pos, &eie);
 				if (ret < 0)
 					break;
 			}
@@ -537,7 +537,7 @@ static int add_all_parents(struct btrfs_root *root, struct btrfs_path *path,
 						  eie, (void **)&old, GFP_NOFS);
 			if (ret < 0)
 				break;
-			if (!ret && !ignore_offset) {
+			if (!ret && !ctx->ignore_extent_item_pos) {
 				while (old->next)
 					old = old->next;
 				old->next = eie;
@@ -545,10 +545,10 @@ static int add_all_parents(struct btrfs_root *root, struct btrfs_path *path,
 			eie = NULL;
 		}
 next:
-		if (time_seq == BTRFS_SEQ_LAST)
+		if (ctx->time_seq == BTRFS_SEQ_LAST)
 			ret = btrfs_next_item(root, path);
 		else
-			ret = btrfs_next_old_item(root, path, time_seq);
+			ret = btrfs_next_old_item(root, path, ctx->time_seq);
 	}
 
 	if (ret > 0)
@@ -562,11 +562,10 @@ static int add_all_parents(struct btrfs_root *root, struct btrfs_path *path,
  * resolve an indirect backref in the form (root_id, key, level)
  * to a logical address
  */
-static int resolve_indirect_ref(struct btrfs_fs_info *fs_info,
-				struct btrfs_path *path, u64 time_seq,
+static int resolve_indirect_ref(struct btrfs_backref_walk_ctx *ctx,
+				struct btrfs_path *path,
 				struct preftrees *preftrees,
-				struct prelim_ref *ref, struct ulist *parents,
-				u64 extent_item_pos)
+				struct prelim_ref *ref, struct ulist *parents)
 {
 	struct btrfs_root *root;
 	struct extent_buffer *eb;
@@ -584,9 +583,9 @@ static int resolve_indirect_ref(struct btrfs_fs_info *fs_info,
 	 * here.
 	 */
 	if (path->search_commit_root)
-		root = btrfs_get_fs_root_commit_root(fs_info, path, ref->root_id);
+		root = btrfs_get_fs_root_commit_root(ctx->fs_info, path, ref->root_id);
 	else
-		root = btrfs_get_fs_root(fs_info, ref->root_id, false);
+		root = btrfs_get_fs_root(ctx->fs_info, ref->root_id, false);
 	if (IS_ERR(root)) {
 		ret = PTR_ERR(root);
 		goto out_free;
@@ -598,17 +597,17 @@ static int resolve_indirect_ref(struct btrfs_fs_info *fs_info,
 		goto out;
 	}
 
-	if (btrfs_is_testing(fs_info)) {
+	if (btrfs_is_testing(ctx->fs_info)) {
 		ret = -ENOENT;
 		goto out;
 	}
 
 	if (path->search_commit_root)
 		root_level = btrfs_header_level(root->commit_root);
-	else if (time_seq == BTRFS_SEQ_LAST)
+	else if (ctx->time_seq == BTRFS_SEQ_LAST)
 		root_level = btrfs_header_level(root->node);
 	else
-		root_level = btrfs_old_root_level(root, time_seq);
+		root_level = btrfs_old_root_level(root, ctx->time_seq);
 
 	if (root_level + 1 == level)
 		goto out;
@@ -636,12 +635,12 @@ static int resolve_indirect_ref(struct btrfs_fs_info *fs_info,
 	    search_key.offset >= LLONG_MAX)
 		search_key.offset = 0;
 	path->lowest_level = level;
-	if (time_seq == BTRFS_SEQ_LAST)
+	if (ctx->time_seq == BTRFS_SEQ_LAST)
 		ret = btrfs_search_slot(NULL, root, &search_key, path, 0, 0);
 	else
-		ret = btrfs_search_old_slot(root, &search_key, path, time_seq);
+		ret = btrfs_search_old_slot(root, &search_key, path, ctx->time_seq);
 
-	btrfs_debug(fs_info,
+	btrfs_debug(ctx->fs_info,
 		"search slot in root %llu (level %d, ref count %d) returned %d for key (%llu %u %llu)",
 		 ref->root_id, level, ref->count, ret,
 		 ref->key_for_search.objectid, ref->key_for_search.type,
@@ -659,8 +658,7 @@ static int resolve_indirect_ref(struct btrfs_fs_info *fs_info,
 		eb = path->nodes[level];
 	}
 
-	ret = add_all_parents(root, path, parents, preftrees, ref, level,
-			      time_seq, extent_item_pos);
+	ret = add_all_parents(ctx, root, path, parents, preftrees, ref, level);
 out:
 	btrfs_put_root(root);
 out_free:
@@ -705,10 +703,9 @@ static void free_leaf_list(struct ulist *ulist)
  * rbtree as they are encountered. The new backrefs are subsequently
  * resolved as above.
  */
-static int resolve_indirect_refs(struct btrfs_fs_info *fs_info,
-				 struct btrfs_path *path, u64 time_seq,
+static int resolve_indirect_refs(struct btrfs_backref_walk_ctx *ctx,
+				 struct btrfs_path *path,
 				 struct preftrees *preftrees,
-				 u64 extent_item_pos,
 				 struct share_check *sc)
 {
 	int err;
@@ -751,14 +748,13 @@ static int resolve_indirect_refs(struct btrfs_fs_info *fs_info,
 			ret = BACKREF_FOUND_SHARED;
 			goto out;
 		}
-		err = resolve_indirect_ref(fs_info, path, time_seq, preftrees,
-					   ref, parents, extent_item_pos);
+		err = resolve_indirect_ref(ctx, path, preftrees, ref, parents);
 		/*
 		 * we can only tolerate ENOENT,otherwise,we should catch error
 		 * and return directly.
 		 */
 		if (err == -ENOENT) {
-			prelim_ref_insert(fs_info, &preftrees->direct, ref,
+			prelim_ref_insert(ctx->fs_info, &preftrees->direct, ref,
 					  NULL);
 			continue;
 		} else if (err) {
@@ -787,7 +783,7 @@ static int resolve_indirect_refs(struct btrfs_fs_info *fs_info,
 			memcpy(new_ref, ref, sizeof(*ref));
 			new_ref->parent = node->val;
 			new_ref->inode_list = unode_aux_to_inode_list(node);
-			prelim_ref_insert(fs_info, &preftrees->direct,
+			prelim_ref_insert(ctx->fs_info, &preftrees->direct,
 					  new_ref, NULL);
 		}
 
@@ -795,7 +791,7 @@ static int resolve_indirect_refs(struct btrfs_fs_info *fs_info,
 		 * Now it's a direct ref, put it in the direct tree. We must
 		 * do this last because the ref could be merged/freed here.
 		 */
-		prelim_ref_insert(fs_info, &preftrees->direct, ref, NULL);
+		prelim_ref_insert(ctx->fs_info, &preftrees->direct, ref, NULL);
 
 		ulist_reinit(parents);
 		cond_resched();
@@ -1325,32 +1321,18 @@ static void store_backref_shared_cache(struct btrfs_backref_share_check_ctx *ctx
  * indirect refs to their parent bytenr.
  * When roots are found, they're added to the roots list
  *
- * If time_seq is set to BTRFS_SEQ_LAST, it will not search delayed_refs, and
- * behave much like trans == NULL case, the difference only lies in it will not
- * commit root.
- * The special case is for qgroup to search roots in commit_transaction().
- *
- * @sc - if !NULL, then immediately return BACKREF_FOUND_SHARED when a
- * shared extent is detected.
+ * @ctx:     Backref walking context object, must be not NULL.
+ * @sc:      If !NULL, then immediately return BACKREF_FOUND_SHARED when a
+ *           shared extent is detected.
  *
  * Otherwise this returns 0 for success and <0 for an error.
  *
- * @extent_item_pos is meaningful only if we are dealing with a data extent.
- * If its value is not BTRFS_IGNORE_EXTENT_OFFSET, then only collect references
- * from file extent items that refer to a section of the data extent that
- * contains @extent_item_pos. If its value is BTRFS_IGNORE_EXTENT_OFFSET then
- * collect references for every file extent item that points to the data extent.
- *
  * FIXME some caching might speed things up
  */
-static int find_parent_nodes(struct btrfs_trans_handle *trans,
-			     struct btrfs_fs_info *fs_info, u64 bytenr,
-			     u64 time_seq, struct ulist *refs,
-			     struct ulist *roots, u64 extent_item_pos,
+static int find_parent_nodes(struct btrfs_backref_walk_ctx *ctx,
 			     struct share_check *sc)
 {
-	const bool ignore_offset = (extent_item_pos == BTRFS_IGNORE_EXTENT_OFFSET);
-	struct btrfs_root *root = btrfs_extent_root(fs_info, bytenr);
+	struct btrfs_root *root = btrfs_extent_root(ctx->fs_info, ctx->bytenr);
 	struct btrfs_key key;
 	struct btrfs_path *path;
 	struct btrfs_delayed_ref_root *delayed_refs = NULL;
@@ -1368,11 +1350,11 @@ static int find_parent_nodes(struct btrfs_trans_handle *trans,
 
 	/* Roots ulist is not needed when using a sharedness check context. */
 	if (sc)
-		ASSERT(roots == NULL);
+		ASSERT(ctx->roots == NULL);
 
-	key.objectid = bytenr;
+	key.objectid = ctx->bytenr;
 	key.offset = (u64)-1;
-	if (btrfs_fs_incompat(fs_info, SKINNY_METADATA))
+	if (btrfs_fs_incompat(ctx->fs_info, SKINNY_METADATA))
 		key.type = BTRFS_METADATA_ITEM_KEY;
 	else
 		key.type = BTRFS_EXTENT_ITEM_KEY;
@@ -1380,12 +1362,12 @@ static int find_parent_nodes(struct btrfs_trans_handle *trans,
 	path = btrfs_alloc_path();
 	if (!path)
 		return -ENOMEM;
-	if (!trans) {
+	if (!ctx->trans) {
 		path->search_commit_root = 1;
 		path->skip_locking = 1;
 	}
 
-	if (time_seq == BTRFS_SEQ_LAST)
+	if (ctx->time_seq == BTRFS_SEQ_LAST)
 		path->skip_locking = 1;
 
 again:
@@ -1401,17 +1383,17 @@ static int find_parent_nodes(struct btrfs_trans_handle *trans,
 		goto out;
 	}
 
-	if (trans && likely(trans->type != __TRANS_DUMMY) &&
-	    time_seq != BTRFS_SEQ_LAST) {
+	if (ctx->trans && likely(ctx->trans->type != __TRANS_DUMMY) &&
+	    ctx->time_seq != BTRFS_SEQ_LAST) {
 		/*
 		 * We have a specific time_seq we care about and trans which
 		 * means we have the path lock, we need to grab the ref head and
 		 * lock it so we have a consistent view of the refs at the given
 		 * time.
 		 */
-		delayed_refs = &trans->transaction->delayed_refs;
+		delayed_refs = &ctx->trans->transaction->delayed_refs;
 		spin_lock(&delayed_refs->lock);
-		head = btrfs_find_delayed_ref_head(delayed_refs, bytenr);
+		head = btrfs_find_delayed_ref_head(delayed_refs, ctx->bytenr);
 		if (head) {
 			if (!mutex_trylock(&head->mutex)) {
 				refcount_inc(&head->refs);
@@ -1429,7 +1411,7 @@ static int find_parent_nodes(struct btrfs_trans_handle *trans,
 				goto again;
 			}
 			spin_unlock(&delayed_refs->lock);
-			ret = add_delayed_refs(fs_info, head, time_seq,
+			ret = add_delayed_refs(ctx->fs_info, head, ctx->time_seq,
 					       &preftrees, sc);
 			mutex_unlock(&head->mutex);
 			if (ret)
@@ -1447,14 +1429,14 @@ static int find_parent_nodes(struct btrfs_trans_handle *trans,
 		leaf = path->nodes[0];
 		slot = path->slots[0];
 		btrfs_item_key_to_cpu(leaf, &key, slot);
-		if (key.objectid == bytenr &&
+		if (key.objectid == ctx->bytenr &&
 		    (key.type == BTRFS_EXTENT_ITEM_KEY ||
 		     key.type == BTRFS_METADATA_ITEM_KEY)) {
-			ret = add_inline_refs(fs_info, path, bytenr,
+			ret = add_inline_refs(ctx->fs_info, path, ctx->bytenr,
 					      &info_level, &preftrees, sc);
 			if (ret)
 				goto out;
-			ret = add_keyed_refs(root, path, bytenr, info_level,
+			ret = add_keyed_refs(root, path, ctx->bytenr, info_level,
 					     &preftrees, sc);
 			if (ret)
 				goto out;
@@ -1483,7 +1465,7 @@ static int find_parent_nodes(struct btrfs_trans_handle *trans,
 	 * extent item pointing to the data extent) is shared, that is, if any
 	 * of the extent buffers in the path is referenced by other trees.
 	 */
-	if (sc && bytenr == sc->data_bytenr) {
+	if (sc && ctx->bytenr == sc->data_bytenr) {
 		/*
 		 * If our data extent is from a generation more recent than the
 		 * last generation used to snapshot the root, then we know that
@@ -1530,14 +1512,13 @@ static int find_parent_nodes(struct btrfs_trans_handle *trans,
 
 	btrfs_release_path(path);
 
-	ret = add_missing_keys(fs_info, &preftrees, path->skip_locking == 0);
+	ret = add_missing_keys(ctx->fs_info, &preftrees, path->skip_locking == 0);
 	if (ret)
 		goto out;
 
 	WARN_ON(!RB_EMPTY_ROOT(&preftrees.indirect_missing_keys.root.rb_root));
 
-	ret = resolve_indirect_refs(fs_info, path, time_seq, &preftrees,
-				    extent_item_pos, sc);
+	ret = resolve_indirect_refs(ctx, path, &preftrees, sc);
 	if (ret)
 		goto out;
 
@@ -1564,17 +1545,18 @@ static int find_parent_nodes(struct btrfs_trans_handle *trans,
 		 * e.g. different offsets would not be merged,
 		 * and would retain their original ref->count < 0.
 		 */
-		if (roots && ref->count && ref->root_id && ref->parent == 0) {
+		if (ctx->roots && ref->count && ref->root_id && ref->parent == 0) {
 			/* no parent == root of tree */
-			ret = ulist_add(roots, ref->root_id, 0, GFP_NOFS);
+			ret = ulist_add(ctx->roots, ref->root_id, 0, GFP_NOFS);
 			if (ret < 0)
 				goto out;
 		}
 		if (ref->count && ref->parent) {
-			if (!ignore_offset && !ref->inode_list && ref->level == 0) {
+			if (!ctx->ignore_extent_item_pos && !ref->inode_list &&
+			    ref->level == 0) {
 				struct extent_buffer *eb;
 
-				eb = read_tree_block(fs_info, ref->parent, 0,
+				eb = read_tree_block(ctx->fs_info, ref->parent, 0,
 						     0, ref->level, NULL);
 				if (IS_ERR(eb)) {
 					ret = PTR_ERR(eb);
@@ -1588,8 +1570,8 @@ static int find_parent_nodes(struct btrfs_trans_handle *trans,
 
 				if (!path->skip_locking)
 					btrfs_tree_read_lock(eb);
-				ret = find_extent_in_eb(eb, bytenr,
-							extent_item_pos, &eie);
+				ret = find_extent_in_eb(eb, ctx->bytenr,
+							ctx->extent_item_pos, &eie);
 				if (!path->skip_locking)
 					btrfs_tree_read_unlock(eb);
 				free_extent_buffer(eb);
@@ -1603,12 +1585,12 @@ static int find_parent_nodes(struct btrfs_trans_handle *trans,
 				 */
 				eie = NULL;
 			}
-			ret = ulist_add_merge_ptr(refs, ref->parent,
+			ret = ulist_add_merge_ptr(ctx->refs, ref->parent,
 						  ref->inode_list,
 						  (void **)&eie, GFP_NOFS);
 			if (ret < 0)
 				goto out;
-			if (!ret && !ignore_offset) {
+			if (!ret && !ctx->ignore_extent_item_pos) {
 				/*
 				 * We've recorded that parent, so we must extend
 				 * its inode list here.
@@ -1652,28 +1634,29 @@ static int find_parent_nodes(struct btrfs_trans_handle *trans,
 }
 
 /*
- * Finds all leafs with a reference to the specified combination of bytenr and
- * offset. key_list_head will point to a list of corresponding keys (caller must
- * free each list element). The leafs will be stored in the leafs ulist, which
- * must be freed with ulist_free.
+ * Finds all leaves with a reference to the specified combination of
+ * @ctx->bytenr and @ctx->extent_item_pos. The bytenr of the found leaves are
+ * added to the ulist at @ctx->refs, and that ulist is allocated by this
+ * function. The caller should free the ulist with free_leaf_list() if
+ * @ctx->ignore_extent_item_pos is false, otherwise a fimple ulist_free() is
+ * enough.
  *
- * returns 0 on success, <0 on error
+ * Returns 0 on success and < 0 on error. On error @ctx->refs is not allocated.
  */
-int btrfs_find_all_leafs(struct btrfs_trans_handle *trans,
-			 struct btrfs_fs_info *fs_info, u64 bytenr,
-			 u64 time_seq, struct ulist **leafs,
-			 u64 extent_item_pos)
+int btrfs_find_all_leafs(struct btrfs_backref_walk_ctx *ctx)
 {
 	int ret;
 
-	*leafs = ulist_alloc(GFP_NOFS);
-	if (!*leafs)
+	ASSERT(ctx->refs == NULL);
+
+	ctx->refs = ulist_alloc(GFP_NOFS);
+	if (!ctx->refs)
 		return -ENOMEM;
 
-	ret = find_parent_nodes(trans, fs_info, bytenr, time_seq,
-				*leafs, NULL, extent_item_pos, NULL);
+	ret = find_parent_nodes(ctx, NULL);
 	if (ret < 0 && ret != -ENOENT) {
-		free_leaf_list(*leafs);
+		free_leaf_list(ctx->refs);
+		ctx->refs = NULL;
 		return ret;
 	}
 
@@ -1681,7 +1664,7 @@ int btrfs_find_all_leafs(struct btrfs_trans_handle *trans,
 }
 
 /*
- * walk all backrefs for a given extent to find all roots that reference this
+ * Walk all backrefs for a given extent to find all roots that reference this
  * extent. Walking a backref means finding all extents that reference this
  * extent and in turn walk the backrefs of those, too. Naturally this is a
  * recursive process, but here it is implemented in an iterative fashion: We
@@ -1689,62 +1672,74 @@ int btrfs_find_all_leafs(struct btrfs_trans_handle *trans,
  * list. In turn, we find all referencing extents for those, further appending
  * to the list. The way we iterate the list allows adding more elements after
  * the current while iterating. The process stops when we reach the end of the
- * list. Found roots are added to the roots list.
+ * list.
+ *
+ * Found roots are added to @ctx->roots, which is allocated by this function and
+ * @ctx->roots should be NULL when calling this function. This function also
+ * requires @ctx->refs to be NULL, as it uses it for allocating a ulist to do
+ * temporary work, and frees it before returning.
  *
- * returns 0 on success, < 0 on error.
+ * Returns 0 on success, < 0 on error. On error @ctx->roots is always NULL.
  */
-static int btrfs_find_all_roots_safe(struct btrfs_trans_handle *trans,
-				     struct btrfs_fs_info *fs_info, u64 bytenr,
-				     u64 time_seq, struct ulist **roots)
+static int btrfs_find_all_roots_safe(struct btrfs_backref_walk_ctx *ctx)
 {
-	struct ulist *tmp;
-	struct ulist_node *node = NULL;
+	const u64 orig_bytenr = ctx->bytenr;
+	const bool orig_ignore_extent_item_pos = ctx->ignore_extent_item_pos;
 	struct ulist_iterator uiter;
-	int ret;
+	int ret = 0;
 
-	tmp = ulist_alloc(GFP_NOFS);
-	if (!tmp)
+	ASSERT(ctx->refs == NULL);
+	ASSERT(ctx->roots == NULL);
+
+	ctx->refs = ulist_alloc(GFP_NOFS);
+	if (!ctx->refs)
 		return -ENOMEM;
-	*roots = ulist_alloc(GFP_NOFS);
-	if (!*roots) {
-		ulist_free(tmp);
+
+	ctx->roots = ulist_alloc(GFP_NOFS);
+	if (!ctx->roots) {
+		ulist_free(ctx->refs);
+		ctx->refs = NULL;
 		return -ENOMEM;
 	}
 
+	ctx->ignore_extent_item_pos = true;
+
 	ULIST_ITER_INIT(&uiter);
 	while (1) {
-		ret = find_parent_nodes(trans, fs_info, bytenr, time_seq,
-					tmp, *roots, BTRFS_IGNORE_EXTENT_OFFSET,
-					NULL);
+		struct ulist_node *node;
+
+		ret = find_parent_nodes(ctx, NULL);
 		if (ret < 0 && ret != -ENOENT) {
-			ulist_free(tmp);
-			ulist_free(*roots);
-			*roots = NULL;
-			return ret;
+			ulist_free(ctx->roots);
+			ctx->roots = NULL;
+			break;
 		}
-		node = ulist_next(tmp, &uiter);
+		ret = 0;
+		node = ulist_next(ctx->refs, &uiter);
 		if (!node)
 			break;
-		bytenr = node->val;
+		ctx->bytenr = node->val;
 		cond_resched();
 	}
 
-	ulist_free(tmp);
-	return 0;
+	ulist_free(ctx->refs);
+	ctx->refs = NULL;
+	ctx->bytenr = orig_bytenr;
+	ctx->ignore_extent_item_pos = orig_ignore_extent_item_pos;
+
+	return ret;
 }
 
-int btrfs_find_all_roots(struct btrfs_trans_handle *trans,
-			 struct btrfs_fs_info *fs_info, u64 bytenr,
-			 u64 time_seq, struct ulist **roots,
+int btrfs_find_all_roots(struct btrfs_backref_walk_ctx *ctx,
 			 bool skip_commit_root_sem)
 {
 	int ret;
 
-	if (!trans && !skip_commit_root_sem)
-		down_read(&fs_info->commit_root_sem);
-	ret = btrfs_find_all_roots_safe(trans, fs_info, bytenr, time_seq, roots);
-	if (!trans && !skip_commit_root_sem)
-		up_read(&fs_info->commit_root_sem);
+	if (!ctx->trans && !skip_commit_root_sem)
+		down_read(&ctx->fs_info->commit_root_sem);
+	ret = btrfs_find_all_roots_safe(ctx);
+	if (!ctx->trans && !skip_commit_root_sem)
+		up_read(&ctx->fs_info->commit_root_sem);
 	return ret;
 }
 
@@ -1794,6 +1789,7 @@ int btrfs_is_data_extent_shared(struct btrfs_inode *inode, u64 bytenr,
 				u64 extent_gen,
 				struct btrfs_backref_share_check_ctx *ctx)
 {
+	struct btrfs_backref_walk_ctx walk_ctx = { 0 };
 	struct btrfs_root *root = inode->root;
 	struct btrfs_fs_info *fs_info = root->fs_info;
 	struct btrfs_trans_handle *trans;
@@ -1830,8 +1826,14 @@ int btrfs_is_data_extent_shared(struct btrfs_inode *inode, u64 bytenr,
 		down_read(&fs_info->commit_root_sem);
 	} else {
 		btrfs_get_tree_mod_seq(fs_info, &elem);
+		walk_ctx.time_seq = elem.seq;
 	}
 
+	walk_ctx.ignore_extent_item_pos = true;
+	walk_ctx.trans = trans;
+	walk_ctx.fs_info = fs_info;
+	walk_ctx.refs = &ctx->refs;
+
 	/* -1 means we are in the bytenr of the data extent. */
 	level = -1;
 	ULIST_ITER_INIT(&uiter);
@@ -1840,8 +1842,8 @@ int btrfs_is_data_extent_shared(struct btrfs_inode *inode, u64 bytenr,
 		bool is_shared;
 		bool cached;
 
-		ret = find_parent_nodes(trans, fs_info, bytenr, elem.seq, &ctx->refs,
-					NULL, BTRFS_IGNORE_EXTENT_OFFSET, &shared);
+		walk_ctx.bytenr = bytenr;
+		ret = find_parent_nodes(&walk_ctx, &shared);
 		if (ret == BACKREF_FOUND_SHARED ||
 		    ret == BACKREF_FOUND_NOT_SHARED) {
 			/* If shared must return 1, otherwise return 0. */
@@ -2279,73 +2281,81 @@ static int iterate_leaf_refs(struct btrfs_fs_info *fs_info,
  * the given parameters.
  * when the iterator function returns a non-zero value, iteration stops.
  */
-int iterate_extent_inodes(struct btrfs_fs_info *fs_info,
-				u64 extent_item_objectid, u64 extent_item_pos,
-				int search_commit_root,
-				iterate_extent_inodes_t *iterate, void *ctx)
+int iterate_extent_inodes(struct btrfs_backref_walk_ctx *ctx,
+			  bool search_commit_root,
+			  iterate_extent_inodes_t *iterate, void *user_ctx)
 {
 	int ret;
-	struct btrfs_trans_handle *trans = NULL;
-	struct ulist *refs = NULL;
-	struct ulist *roots = NULL;
-	struct ulist_node *ref_node = NULL;
-	struct ulist_node *root_node = NULL;
+	struct ulist *refs;
+	struct ulist_node *ref_node;
 	struct btrfs_seq_list seq_elem = BTRFS_SEQ_LIST_INIT(seq_elem);
 	struct ulist_iterator ref_uiter;
-	struct ulist_iterator root_uiter;
 
-	btrfs_debug(fs_info, "resolving all inodes for extent %llu",
-			extent_item_objectid);
+	btrfs_debug(ctx->fs_info, "resolving all inodes for extent %llu",
+		    ctx->bytenr);
+
+	ASSERT(ctx->trans == NULL);
 
 	if (!search_commit_root) {
-		trans = btrfs_attach_transaction(fs_info->tree_root);
+		struct btrfs_trans_handle *trans;
+
+		trans = btrfs_attach_transaction(ctx->fs_info->tree_root);
 		if (IS_ERR(trans)) {
 			if (PTR_ERR(trans) != -ENOENT &&
 			    PTR_ERR(trans) != -EROFS)
 				return PTR_ERR(trans);
 			trans = NULL;
 		}
+		ctx->trans = trans;
 	}
 
-	if (trans)
-		btrfs_get_tree_mod_seq(fs_info, &seq_elem);
-	else
-		down_read(&fs_info->commit_root_sem);
+	if (ctx->trans) {
+		btrfs_get_tree_mod_seq(ctx->fs_info, &seq_elem);
+		ctx->time_seq = seq_elem.seq;
+	} else {
+		down_read(&ctx->fs_info->commit_root_sem);
+	}
 
-	ret = btrfs_find_all_leafs(trans, fs_info, extent_item_objectid,
-				   seq_elem.seq, &refs, extent_item_pos);
+	ret = btrfs_find_all_leafs(ctx);
 	if (ret)
 		goto out;
+	refs = ctx->refs;
+	ctx->refs = NULL;
 
 	ULIST_ITER_INIT(&ref_uiter);
 	while (!ret && (ref_node = ulist_next(refs, &ref_uiter))) {
-		ret = btrfs_find_all_roots_safe(trans, fs_info, ref_node->val,
-						seq_elem.seq, &roots);
+		struct ulist_node *root_node;
+		struct ulist_iterator root_uiter;
+
+		ctx->bytenr = ref_node->val;
+		ret = btrfs_find_all_roots_safe(ctx);
 		if (ret)
 			break;
+
 		ULIST_ITER_INIT(&root_uiter);
-		while (!ret && (root_node = ulist_next(roots, &root_uiter))) {
-			btrfs_debug(fs_info,
+		while (!ret && (root_node = ulist_next(ctx->roots, &root_uiter))) {
+			btrfs_debug(ctx->fs_info,
 				    "root %llu references leaf %llu, data list %#llx",
 				    root_node->val, ref_node->val,
 				    ref_node->aux);
-			ret = iterate_leaf_refs(fs_info,
+			ret = iterate_leaf_refs(ctx->fs_info,
 						(struct extent_inode_elem *)
 						(uintptr_t)ref_node->aux,
-						root_node->val,
-						extent_item_objectid,
-						iterate, ctx);
+						root_node->val, ctx->bytenr,
+						iterate, user_ctx);
 		}
-		ulist_free(roots);
+		ulist_free(ctx->roots);
+		ctx->roots = NULL;
 	}
 
 	free_leaf_list(refs);
 out:
-	if (trans) {
-		btrfs_put_tree_mod_seq(fs_info, &seq_elem);
-		btrfs_end_transaction(trans);
+	if (ctx->trans) {
+		btrfs_put_tree_mod_seq(ctx->fs_info, &seq_elem);
+		btrfs_end_transaction(ctx->trans);
+		ctx->trans = NULL;
 	} else {
-		up_read(&fs_info->commit_root_sem);
+		up_read(&ctx->fs_info->commit_root_sem);
 	}
 
 	return ret;
@@ -2375,8 +2385,8 @@ int iterate_inodes_from_logical(u64 logical, struct btrfs_fs_info *fs_info,
 				struct btrfs_path *path,
 				void *ctx, bool ignore_offset)
 {
+	struct btrfs_backref_walk_ctx walk_ctx = { 0 };
 	int ret;
-	u64 extent_item_pos;
 	u64 flags = 0;
 	struct btrfs_key found_key;
 	int search_commit_root = path->search_commit_root;
@@ -2388,16 +2398,15 @@ int iterate_inodes_from_logical(u64 logical, struct btrfs_fs_info *fs_info,
 	if (flags & BTRFS_EXTENT_FLAG_TREE_BLOCK)
 		return -EINVAL;
 
+	walk_ctx.bytenr = found_key.objectid;
 	if (ignore_offset)
-		extent_item_pos = BTRFS_IGNORE_EXTENT_OFFSET;
+		walk_ctx.ignore_extent_item_pos = true;
 	else
-		extent_item_pos = logical - found_key.objectid;
+		walk_ctx.extent_item_pos = logical - found_key.objectid;
+	walk_ctx.fs_info = fs_info;
 
-	ret = iterate_extent_inodes(fs_info, found_key.objectid,
-					extent_item_pos, search_commit_root,
-					build_ino_list, ctx);
-
-	return ret;
+	return iterate_extent_inodes(&walk_ctx, search_commit_root,
+				     build_ino_list, ctx);
 }
 
 static int inode_to_path(u64 inum, u32 name_len, unsigned long name_off,
diff --git a/fs/btrfs/backref.h b/fs/btrfs/backref.h
index 2eb99f23cc8f..ce700dfcc016 100644
--- a/fs/btrfs/backref.h
+++ b/fs/btrfs/backref.h
@@ -13,11 +13,63 @@
 #include "extent_io.h"
 
 /*
- * Pass to backref walking functions to tell them to include references from
- * all file extent items that point to the target data extent, regardless if
- * they refer to the whole extent or just sections of it (bookend extents).
+ * Context and arguments for backref walking functions. Some of the fields are
+ * to be filled by the caller of such functions while other are filled by the
+ * functions themselves, as described below.
  */
-#define BTRFS_IGNORE_EXTENT_OFFSET   ((u64)-1)
+struct btrfs_backref_walk_ctx {
+	/*
+	 * The address of the extent for which we are doing backref walking.
+	 * Can be either a data extent or a metadata extent.
+	 *
+	 * Must always be set by the top level caller.
+	 */
+	u64 bytenr;
+	/*
+	 * Offset relative to the target extent. This is only used for data
+	 * extents, and it's meaningful because we can have file extent items
+	 * that point only to a section of a data extent ("bookend" extents),
+	 * and we want to filter out any that don't point to a section of the
+	 * data extent containing the given offset.
+	 *
+	 * Must always be set by the top level caller.
+	 */
+	u64 extent_item_pos;
+	/*
+	 * If true and bytenr corresponds to a data extent, then references from
+	 * all file extent items that point to the data extent are considered,
+	 * @extent_item_pos is ignored.
+	 */
+	bool ignore_extent_item_pos;
+	/* A valid transaction handle or NULL. */
+	struct btrfs_trans_handle *trans;
+	/*
+	 * The file system's info object, can not be NULL.
+	 *
+	 * Must always be set by the top level caller.
+	 */
+	struct btrfs_fs_info *fs_info;
+	/*
+	 * Time sequence acquired from btrfs_get_tree_mod_seq(), in case the
+	 * caller joined the tree mod log to get a consistent view of b+trees
+	 * while we do backref walking, or BTRFS_SEQ_LAST.
+	 * When using BTRFS_SEQ_LAST, delayed refs are not checked and it uses
+	 * commit roots when searching b+trees - this is a special case for
+	 * qgroups used during a transaction commit.
+	 */
+	u64 time_seq;
+	/*
+	 * Used to collect the bytenr of metadata extents that point to the
+	 * target extent.
+	 */
+	struct ulist *refs;
+	/*
+	 * List used to collect the IDs of the roots from which the target
+	 * extent is accessible. Can be NULL in case the caller does not care
+	 * about collecting root IDs.
+	 */
+	struct ulist *roots;
+};
 
 struct inode_fs_paths {
 	struct btrfs_path		*btrfs_path;
@@ -96,10 +148,9 @@ int tree_backref_for_extent(unsigned long *ptr, struct extent_buffer *eb,
 			    struct btrfs_key *key, struct btrfs_extent_item *ei,
 			    u32 item_size, u64 *out_root, u8 *out_level);
 
-int iterate_extent_inodes(struct btrfs_fs_info *fs_info,
-				u64 extent_item_objectid,
-				u64 extent_offset, int search_commit_root,
-				iterate_extent_inodes_t *iterate, void *ctx);
+int iterate_extent_inodes(struct btrfs_backref_walk_ctx *ctx,
+			  bool search_commit_root,
+			  iterate_extent_inodes_t *iterate, void *user_ctx);
 
 int iterate_inodes_from_logical(u64 logical, struct btrfs_fs_info *fs_info,
 				struct btrfs_path *path, void *ctx,
@@ -107,13 +158,8 @@ int iterate_inodes_from_logical(u64 logical, struct btrfs_fs_info *fs_info,
 
 int paths_from_inode(u64 inum, struct inode_fs_paths *ipath);
 
-int btrfs_find_all_leafs(struct btrfs_trans_handle *trans,
-			 struct btrfs_fs_info *fs_info, u64 bytenr,
-			 u64 time_seq, struct ulist **leafs,
-			 u64 extent_item_pos);
-int btrfs_find_all_roots(struct btrfs_trans_handle *trans,
-			 struct btrfs_fs_info *fs_info, u64 bytenr,
-			 u64 time_seq, struct ulist **roots,
+int btrfs_find_all_leafs(struct btrfs_backref_walk_ctx *ctx);
+int btrfs_find_all_roots(struct btrfs_backref_walk_ctx *ctx,
 			 bool skip_commit_root_sem);
 char *btrfs_ref_to_path(struct btrfs_root *fs_root, struct btrfs_path *path,
 			u32 name_len, unsigned long name_off,
diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index 34e8acf02227..35856ea28e32 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -1794,8 +1794,7 @@ int btrfs_qgroup_trace_extent_nolock(struct btrfs_fs_info *fs_info,
 int btrfs_qgroup_trace_extent_post(struct btrfs_trans_handle *trans,
 				   struct btrfs_qgroup_extent_record *qrecord)
 {
-	struct ulist *old_root;
-	u64 bytenr = qrecord->bytenr;
+	struct btrfs_backref_walk_ctx ctx = { 0 };
 	int ret;
 
 	/*
@@ -1822,8 +1821,10 @@ int btrfs_qgroup_trace_extent_post(struct btrfs_trans_handle *trans,
 	if (trans->fs_info->qgroup_flags & BTRFS_QGROUP_RUNTIME_FLAG_NO_ACCOUNTING)
 		return 0;
 
-	ret = btrfs_find_all_roots(NULL, trans->fs_info, bytenr, 0, &old_root,
-				   true);
+	ctx.bytenr = qrecord->bytenr;
+	ctx.fs_info = trans->fs_info;
+
+	ret = btrfs_find_all_roots(&ctx, true);
 	if (ret < 0) {
 		qgroup_mark_inconsistent(trans->fs_info);
 		btrfs_warn(trans->fs_info,
@@ -1839,7 +1840,7 @@ int btrfs_qgroup_trace_extent_post(struct btrfs_trans_handle *trans,
 	 *
 	 * So modifying qrecord->old_roots is safe here
 	 */
-	qrecord->old_roots = old_root;
+	qrecord->old_roots = ctx.roots;
 	return 0;
 }
 
@@ -2750,17 +2751,22 @@ int btrfs_qgroup_account_extents(struct btrfs_trans_handle *trans)
 
 		if (!ret && !(fs_info->qgroup_flags &
 			      BTRFS_QGROUP_RUNTIME_FLAG_NO_ACCOUNTING)) {
+			struct btrfs_backref_walk_ctx ctx = { 0 };
+
+			ctx.bytenr = record->bytenr;
+			ctx.fs_info = fs_info;
+
 			/*
 			 * Old roots should be searched when inserting qgroup
 			 * extent record
 			 */
 			if (WARN_ON(!record->old_roots)) {
 				/* Search commit root to find old_roots */
-				ret = btrfs_find_all_roots(NULL, fs_info,
-						record->bytenr, 0,
-						&record->old_roots, false);
+				ret = btrfs_find_all_roots(&ctx, false);
 				if (ret < 0)
 					goto cleanup;
+				record->old_roots = ctx.roots;
+				ctx.roots = NULL;
 			}
 
 			/* Free the reserved data space */
@@ -2773,10 +2779,11 @@ int btrfs_qgroup_account_extents(struct btrfs_trans_handle *trans)
 			 * which doesn't lock tree or delayed_refs and search
 			 * current root. It's safe inside commit_transaction().
 			 */
-			ret = btrfs_find_all_roots(trans, fs_info,
-			   record->bytenr, BTRFS_SEQ_LAST, &new_roots, false);
+			ctx.trans = trans;
+			ret = btrfs_find_all_roots(&ctx, false);
 			if (ret < 0)
 				goto cleanup;
+			new_roots = ctx.roots;
 			if (qgroup_to_skip) {
 				ulist_del(new_roots, qgroup_to_skip, 0);
 				ulist_del(record->old_roots, qgroup_to_skip,
@@ -3249,7 +3256,6 @@ static int qgroup_rescan_leaf(struct btrfs_trans_handle *trans,
 	struct btrfs_root *extent_root;
 	struct btrfs_key found;
 	struct extent_buffer *scratch_leaf = NULL;
-	struct ulist *roots = NULL;
 	u64 num_bytes;
 	bool done;
 	int slot;
@@ -3299,6 +3305,8 @@ static int qgroup_rescan_leaf(struct btrfs_trans_handle *trans,
 	mutex_unlock(&fs_info->qgroup_rescan_lock);
 
 	for (; slot < btrfs_header_nritems(scratch_leaf); ++slot) {
+		struct btrfs_backref_walk_ctx ctx = { 0 };
+
 		btrfs_item_key_to_cpu(scratch_leaf, &found, slot);
 		if (found.type != BTRFS_EXTENT_ITEM_KEY &&
 		    found.type != BTRFS_METADATA_ITEM_KEY)
@@ -3308,13 +3316,15 @@ static int qgroup_rescan_leaf(struct btrfs_trans_handle *trans,
 		else
 			num_bytes = found.offset;
 
-		ret = btrfs_find_all_roots(NULL, fs_info, found.objectid, 0,
-					   &roots, false);
+		ctx.bytenr = found.objectid;
+		ctx.fs_info = fs_info;
+
+		ret = btrfs_find_all_roots(&ctx, false);
 		if (ret < 0)
 			goto out;
 		/* For rescan, just pass old_roots as NULL */
 		ret = btrfs_qgroup_account_extent(trans, found.objectid,
-						  num_bytes, NULL, roots);
+						  num_bytes, NULL, ctx.roots);
 		if (ret < 0)
 			goto out;
 	}
diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 45690f7b5900..2ecca24e1001 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -3408,24 +3408,27 @@ int add_data_references(struct reloc_control *rc,
 			struct btrfs_path *path,
 			struct rb_root *blocks)
 {
-	struct btrfs_fs_info *fs_info = rc->extent_root->fs_info;
-	struct ulist *leaves = NULL;
+	struct btrfs_backref_walk_ctx ctx = { 0 };
 	struct ulist_iterator leaf_uiter;
 	struct ulist_node *ref_node = NULL;
-	const u32 blocksize = fs_info->nodesize;
+	const u32 blocksize = rc->extent_root->fs_info->nodesize;
 	int ret = 0;
 
 	btrfs_release_path(path);
-	ret = btrfs_find_all_leafs(NULL, fs_info, extent_key->objectid,
-				   0, &leaves, BTRFS_IGNORE_EXTENT_OFFSET);
+
+	ctx.bytenr = extent_key->objectid;
+	ctx.ignore_extent_item_pos = true;
+	ctx.fs_info = rc->extent_root->fs_info;
+
+	ret = btrfs_find_all_leafs(&ctx);
 	if (ret < 0)
 		return ret;
 
 	ULIST_ITER_INIT(&leaf_uiter);
-	while ((ref_node = ulist_next(leaves, &leaf_uiter))) {
+	while ((ref_node = ulist_next(ctx.refs, &leaf_uiter))) {
 		struct extent_buffer *eb;
 
-		eb = read_tree_block(fs_info, ref_node->val, 0, 0, 0, NULL);
+		eb = read_tree_block(ctx.fs_info, ref_node->val, 0, 0, 0, NULL);
 		if (IS_ERR(eb)) {
 			ret = PTR_ERR(eb);
 			break;
@@ -3441,7 +3444,7 @@ int add_data_references(struct reloc_control *rc,
 	}
 	if (ret < 0)
 		free_block_list(blocks);
-	ulist_free(leaves);
+	ulist_free(ctx.refs);
 	return ret;
 }
 
diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index dc178f59f34a..06c6626eae3d 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -909,7 +909,6 @@ static void scrub_print_warning(const char *errstr, struct scrub_block *sblock)
 	struct btrfs_extent_item *ei;
 	struct scrub_warning swarn;
 	unsigned long ptr = 0;
-	u64 extent_item_pos;
 	u64 flags = 0;
 	u64 ref_root;
 	u32 item_size;
@@ -941,7 +940,6 @@ static void scrub_print_warning(const char *errstr, struct scrub_block *sblock)
 	if (ret < 0)
 		goto out;
 
-	extent_item_pos = swarn.logical - found_key.objectid;
 	swarn.extent_item_size = found_key.offset;
 
 	eb = path->nodes[0];
@@ -964,12 +962,18 @@ static void scrub_print_warning(const char *errstr, struct scrub_block *sblock)
 		} while (ret != 1);
 		btrfs_release_path(path);
 	} else {
+		struct btrfs_backref_walk_ctx ctx = { 0 };
+
 		btrfs_release_path(path);
+
+		ctx.bytenr = found_key.objectid;
+		ctx.extent_item_pos = swarn.logical - found_key.objectid;
+		ctx.fs_info = fs_info;
+
 		swarn.path = path;
 		swarn.dev = dev;
-		iterate_extent_inodes(fs_info, found_key.objectid,
-					extent_item_pos, 1,
-					scrub_print_warning_inode, &swarn);
+
+		iterate_extent_inodes(&ctx, true, scrub_print_warning_inode, &swarn);
 	}
 
 out:
diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index b6d9200af2e3..95eaa9ce190b 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -1356,12 +1356,12 @@ static int find_extent_clone(struct send_ctx *sctx,
 	u64 logical;
 	u64 disk_byte;
 	u64 num_bytes;
-	u64 extent_item_pos;
 	u64 extent_refs;
 	u64 flags = 0;
 	struct btrfs_file_extent_item *fi;
 	struct extent_buffer *eb = path->nodes[0];
-	struct backref_ctx backref_ctx = {0};
+	struct backref_ctx backref_ctx = { 0 };
+	struct btrfs_backref_walk_ctx backref_walk_ctx = { 0 };
 	struct clone_root *cur_clone_root;
 	struct btrfs_key found_key;
 	struct btrfs_path *tmp_path;
@@ -1461,14 +1461,13 @@ static int find_extent_clone(struct send_ctx *sctx,
 	/*
 	 * Now collect all backrefs.
 	 */
+	backref_walk_ctx.bytenr = found_key.objectid;
 	if (compressed == BTRFS_COMPRESS_NONE)
-		extent_item_pos = logical - found_key.objectid;
-	else
-		extent_item_pos = 0;
-	ret = iterate_extent_inodes(fs_info, found_key.objectid,
-				    extent_item_pos, 1, __iterate_backrefs,
-				    &backref_ctx);
+		backref_walk_ctx.extent_item_pos = logical - found_key.objectid;
+	backref_walk_ctx.fs_info = fs_info;
 
+	ret = iterate_extent_inodes(&backref_walk_ctx, true, __iterate_backrefs,
+				    &backref_ctx);
 	if (ret < 0)
 		goto out;
 
diff --git a/fs/btrfs/tests/qgroup-tests.c b/fs/btrfs/tests/qgroup-tests.c
index 65b65d55d1f6..3fc8dc3fd980 100644
--- a/fs/btrfs/tests/qgroup-tests.c
+++ b/fs/btrfs/tests/qgroup-tests.c
@@ -205,6 +205,7 @@ static int remove_extent_ref(struct btrfs_root *root, u64 bytenr,
 static int test_no_shared_qgroup(struct btrfs_root *root,
 		u32 sectorsize, u32 nodesize)
 {
+	struct btrfs_backref_walk_ctx ctx = { 0 };
 	struct btrfs_trans_handle trans;
 	struct btrfs_fs_info *fs_info = root->fs_info;
 	struct ulist *old_roots = NULL;
@@ -220,16 +221,22 @@ static int test_no_shared_qgroup(struct btrfs_root *root,
 		return ret;
 	}
 
+	ctx.bytenr = nodesize;
+	ctx.trans = &trans;
+	ctx.fs_info = fs_info;
+
 	/*
 	 * Since the test trans doesn't have the complicated delayed refs,
 	 * we can only call btrfs_qgroup_account_extent() directly to test
 	 * quota.
 	 */
-	ret = btrfs_find_all_roots(&trans, fs_info, nodesize, 0, &old_roots, false);
+	ret = btrfs_find_all_roots(&ctx, false);
 	if (ret) {
 		test_err("couldn't find old roots: %d", ret);
 		return ret;
 	}
+	old_roots = ctx.roots;
+	ctx.roots = NULL;
 
 	ret = insert_normal_tree_ref(root, nodesize, nodesize, 0,
 				BTRFS_FS_TREE_OBJECTID);
@@ -238,12 +245,14 @@ static int test_no_shared_qgroup(struct btrfs_root *root,
 		return ret;
 	}
 
-	ret = btrfs_find_all_roots(&trans, fs_info, nodesize, 0, &new_roots, false);
+	ret = btrfs_find_all_roots(&ctx, false);
 	if (ret) {
 		ulist_free(old_roots);
 		test_err("couldn't find old roots: %d", ret);
 		return ret;
 	}
+	new_roots = ctx.roots;
+	ctx.roots = NULL;
 
 	ret = btrfs_qgroup_account_extent(&trans, nodesize, nodesize, old_roots,
 					  new_roots);
@@ -262,11 +271,13 @@ static int test_no_shared_qgroup(struct btrfs_root *root,
 		return -EINVAL;
 	}
 
-	ret = btrfs_find_all_roots(&trans, fs_info, nodesize, 0, &old_roots, false);
+	ret = btrfs_find_all_roots(&ctx, false);
 	if (ret) {
 		test_err("couldn't find old roots: %d", ret);
 		return ret;
 	}
+	old_roots = ctx.roots;
+	ctx.roots = NULL;
 
 	ret = remove_extent_item(root, nodesize, nodesize);
 	if (ret) {
@@ -274,12 +285,14 @@ static int test_no_shared_qgroup(struct btrfs_root *root,
 		return -EINVAL;
 	}
 
-	ret = btrfs_find_all_roots(&trans, fs_info, nodesize, 0, &new_roots, false);
+	ret = btrfs_find_all_roots(&ctx, false);
 	if (ret) {
 		ulist_free(old_roots);
 		test_err("couldn't find old roots: %d", ret);
 		return ret;
 	}
+	new_roots = ctx.roots;
+	ctx.roots = NULL;
 
 	ret = btrfs_qgroup_account_extent(&trans, nodesize, nodesize, old_roots,
 					  new_roots);
@@ -304,6 +317,7 @@ static int test_no_shared_qgroup(struct btrfs_root *root,
 static int test_multiple_refs(struct btrfs_root *root,
 		u32 sectorsize, u32 nodesize)
 {
+	struct btrfs_backref_walk_ctx ctx = { 0 };
 	struct btrfs_trans_handle trans;
 	struct btrfs_fs_info *fs_info = root->fs_info;
 	struct ulist *old_roots = NULL;
@@ -324,11 +338,17 @@ static int test_multiple_refs(struct btrfs_root *root,
 		return ret;
 	}
 
-	ret = btrfs_find_all_roots(&trans, fs_info, nodesize, 0, &old_roots, false);
+	ctx.bytenr = nodesize;
+	ctx.trans = &trans;
+	ctx.fs_info = fs_info;
+
+	ret = btrfs_find_all_roots(&ctx, false);
 	if (ret) {
 		test_err("couldn't find old roots: %d", ret);
 		return ret;
 	}
+	old_roots = ctx.roots;
+	ctx.roots = NULL;
 
 	ret = insert_normal_tree_ref(root, nodesize, nodesize, 0,
 				BTRFS_FS_TREE_OBJECTID);
@@ -337,12 +357,14 @@ static int test_multiple_refs(struct btrfs_root *root,
 		return ret;
 	}
 
-	ret = btrfs_find_all_roots(&trans, fs_info, nodesize, 0, &new_roots, false);
+	ret = btrfs_find_all_roots(&ctx, false);
 	if (ret) {
 		ulist_free(old_roots);
 		test_err("couldn't find old roots: %d", ret);
 		return ret;
 	}
+	new_roots = ctx.roots;
+	ctx.roots = NULL;
 
 	ret = btrfs_qgroup_account_extent(&trans, nodesize, nodesize, old_roots,
 					  new_roots);
@@ -357,11 +379,13 @@ static int test_multiple_refs(struct btrfs_root *root,
 		return -EINVAL;
 	}
 
-	ret = btrfs_find_all_roots(&trans, fs_info, nodesize, 0, &old_roots, false);
+	ret = btrfs_find_all_roots(&ctx, false);
 	if (ret) {
 		test_err("couldn't find old roots: %d", ret);
 		return ret;
 	}
+	old_roots = ctx.roots;
+	ctx.roots = NULL;
 
 	ret = add_tree_ref(root, nodesize, nodesize, 0,
 			BTRFS_FIRST_FREE_OBJECTID);
@@ -370,12 +394,14 @@ static int test_multiple_refs(struct btrfs_root *root,
 		return ret;
 	}
 
-	ret = btrfs_find_all_roots(&trans, fs_info, nodesize, 0, &new_roots, false);
+	ret = btrfs_find_all_roots(&ctx, false);
 	if (ret) {
 		ulist_free(old_roots);
 		test_err("couldn't find old roots: %d", ret);
 		return ret;
 	}
+	new_roots = ctx.roots;
+	ctx.roots = NULL;
 
 	ret = btrfs_qgroup_account_extent(&trans, nodesize, nodesize, old_roots,
 					  new_roots);
@@ -396,11 +422,13 @@ static int test_multiple_refs(struct btrfs_root *root,
 		return -EINVAL;
 	}
 
-	ret = btrfs_find_all_roots(&trans, fs_info, nodesize, 0, &old_roots, false);
+	ret = btrfs_find_all_roots(&ctx, false);
 	if (ret) {
 		test_err("couldn't find old roots: %d", ret);
 		return ret;
 	}
+	old_roots = ctx.roots;
+	ctx.roots = NULL;
 
 	ret = remove_extent_ref(root, nodesize, nodesize, 0,
 				BTRFS_FIRST_FREE_OBJECTID);
@@ -409,12 +437,14 @@ static int test_multiple_refs(struct btrfs_root *root,
 		return ret;
 	}
 
-	ret = btrfs_find_all_roots(&trans, fs_info, nodesize, 0, &new_roots, false);
+	ret = btrfs_find_all_roots(&ctx, false);
 	if (ret) {
 		ulist_free(old_roots);
 		test_err("couldn't find old roots: %d", ret);
 		return ret;
 	}
+	new_roots = ctx.roots;
+	ctx.roots = NULL;
 
 	ret = btrfs_qgroup_account_extent(&trans, nodesize, nodesize, old_roots,
 					  new_roots);
-- 
2.35.1

