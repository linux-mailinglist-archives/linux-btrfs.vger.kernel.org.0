Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D79324C276
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Aug 2020 17:47:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729187AbgHTPrP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 20 Aug 2020 11:47:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729374AbgHTPqk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 20 Aug 2020 11:46:40 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4037DC061387
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Aug 2020 08:46:40 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id x7so1122173qvi.5
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Aug 2020 08:46:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=5x/iIxA9p/BClKdVPiNu5RHQCax1Jmu2hKg3SgtpzQY=;
        b=OzJIU1/AfYIZXJVPwKBlIaE67QnKpE5J8PWrB6oZ+IOUjBinQYaI8bSYWtU/qHVWFh
         GueiXb/arHnkvyk9PfTfaccBzJ/37ZP1iSWYj3FbVR/jiaWirW3S+52joCKkOG51pKKu
         G0sYLmskaCHXKYoExKVNpYnXjUKSnq7Q8y4FW/yXAG2FFepA9A1/L7dE0JmJJVRQrXrC
         Rs29oKiuoQm0+28X+tOQl8IVzIKRaoDNrc3njmdOwIDmKmmu6DetjXJm0iO2dGGbo7Av
         NfZdinyDw++ufbyCNOotVA55od0XThviWCKmVDvq73A3KHF1/itK6i/RUeEgp7AGp8KD
         qeVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5x/iIxA9p/BClKdVPiNu5RHQCax1Jmu2hKg3SgtpzQY=;
        b=UVUXmdwrMfywgXv0LO144dmKhP7qHKLDrCzcMvr/zhEcvHzxEJ0QdQZVAKFbLB8X0h
         CCpVLWXREHOvNWz90lWCeU0ehRDq3eiMp9KarCMOieJGyu/mj0df89WifCUtmU1Lf08Z
         1I95hzcymVuAY4/wjVIoSo/4MCEzA4NLb1GGh3aSKW2bSvw25m+ZOLSi6bIv4OsGRcXL
         qRxJJ5JBgBAEjMxAb45R3NC+dDkJrOW9ZKy2qWg2v1seUkmrNl3+ctmL9MWAgcOFs6ZP
         jsNmvnoSBbD3E7t+S4W0pQ/gImSat6qSBSz0tEs+/YyNX8/mf4yFq4NdQ8QDrglTbbuJ
         pPAA==
X-Gm-Message-State: AOAM533HE7XO7n/z4pSLpCEzzUU7rIAjuobNFSpii9bE5prb1aEC5t5E
        oaNp0DalOBeeyC99QPyT+tYTQFHWdgOFqM/X
X-Google-Smtp-Source: ABdhPJxXtzC+XWTIqc1jk0n6lbBZ4YPeHyfJRkmrlDVvY0W+aqg7gizWpUpojX+Rw3Y5fP1LgrkBEQ==
X-Received: by 2002:ad4:414b:: with SMTP id z11mr3460249qvp.116.1597938398533;
        Thu, 20 Aug 2020 08:46:38 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id 142sm2567602qki.130.2020.08.20.08.46.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2020 08:46:36 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 11/12] btrfs: remove all of the blocking helpers
Date:   Thu, 20 Aug 2020 11:46:10 -0400
Message-Id: <d4d439ecc794ac444a22eb9a979f69bf72538665.1597938191.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1597938190.git.josef@toxicpanda.com>
References: <cover.1597938190.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Now that we're using a rw_semaphore we no longer need to indicate if a
lock is blocking or not, nor do we need to flip the entire path from
blocking to spinning.  Remove these helpers and all the places they are
called.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/backref.c       | 10 ++---
 fs/btrfs/ctree.c         | 91 ++++++----------------------------------
 fs/btrfs/delayed-inode.c |  7 ----
 fs/btrfs/disk-io.c       |  8 +---
 fs/btrfs/extent-tree.c   | 19 +++------
 fs/btrfs/file.c          |  3 +-
 fs/btrfs/inode.c         |  1 -
 fs/btrfs/locking.c       | 74 --------------------------------
 fs/btrfs/locking.h       | 11 +----
 fs/btrfs/qgroup.c        |  9 ++--
 fs/btrfs/ref-verify.c    |  6 +--
 fs/btrfs/relocation.c    |  4 --
 fs/btrfs/transaction.c   |  2 -
 fs/btrfs/tree-defrag.c   |  1 -
 fs/btrfs/tree-log.c      |  3 --
 15 files changed, 30 insertions(+), 219 deletions(-)

diff --git a/fs/btrfs/backref.c b/fs/btrfs/backref.c
index ea1c28ccb44f..4410a6e2f8c6 100644
--- a/fs/btrfs/backref.c
+++ b/fs/btrfs/backref.c
@@ -1330,14 +1330,12 @@ static int find_parent_nodes(struct btrfs_trans_handle *trans,
 					goto out;
 				}
 
-				if (!path->skip_locking) {
+				if (!path->skip_locking)
 					btrfs_tree_read_lock(eb);
-					btrfs_set_lock_blocking_read(eb);
-				}
 				ret = find_extent_in_eb(eb, bytenr,
 							*extent_item_pos, &eie, ignore_offset);
 				if (!path->skip_locking)
-					btrfs_tree_read_unlock_blocking(eb);
+					btrfs_tree_read_unlock(eb);
 				free_extent_buffer(eb);
 				if (ret < 0)
 					goto out;
@@ -1674,7 +1672,7 @@ char *btrfs_ref_to_path(struct btrfs_root *fs_root, struct btrfs_path *path,
 					   name_off, name_len);
 		if (eb != eb_in) {
 			if (!path->skip_locking)
-				btrfs_tree_read_unlock_blocking(eb);
+				btrfs_tree_read_unlock(eb);
 			free_extent_buffer(eb);
 		}
 		ret = btrfs_find_item(fs_root, path, parent, 0,
@@ -1694,8 +1692,6 @@ char *btrfs_ref_to_path(struct btrfs_root *fs_root, struct btrfs_path *path,
 		eb = path->nodes[0];
 		/* make sure we can use eb after releasing the path */
 		if (eb != eb_in) {
-			if (!path->skip_locking)
-				btrfs_set_lock_blocking_read(eb);
 			path->nodes[0] = NULL;
 			path->locks[0] = 0;
 		}
diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index e4574ff3ba15..08e6cc8bd4c1 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -1272,14 +1272,11 @@ tree_mod_log_rewind(struct btrfs_fs_info *fs_info, struct btrfs_path *path,
 	if (!tm)
 		return eb;
 
-	btrfs_set_path_blocking(path);
-	btrfs_set_lock_blocking_read(eb);
-
 	if (tm->op == MOD_LOG_KEY_REMOVE_WHILE_FREEING) {
 		BUG_ON(tm->slot != 0);
 		eb_rewin = alloc_dummy_extent_buffer(fs_info, eb->start);
 		if (!eb_rewin) {
-			btrfs_tree_read_unlock_blocking(eb);
+			btrfs_tree_read_unlock(eb);
 			free_extent_buffer(eb);
 			return NULL;
 		}
@@ -1291,13 +1288,13 @@ tree_mod_log_rewind(struct btrfs_fs_info *fs_info, struct btrfs_path *path,
 	} else {
 		eb_rewin = btrfs_clone_extent_buffer(eb);
 		if (!eb_rewin) {
-			btrfs_tree_read_unlock_blocking(eb);
+			btrfs_tree_read_unlock(eb);
 			free_extent_buffer(eb);
 			return NULL;
 		}
 	}
 
-	btrfs_tree_read_unlock_blocking(eb);
+	btrfs_tree_read_unlock(eb);
 	free_extent_buffer(eb);
 
 	btrfs_set_buffer_lockdep_class(btrfs_header_owner(eb_rewin),
@@ -1367,9 +1364,8 @@ get_old_root(struct btrfs_root *root, u64 time_seq)
 		free_extent_buffer(eb_root);
 		eb = alloc_dummy_extent_buffer(fs_info, logical);
 	} else {
-		btrfs_set_lock_blocking_read(eb_root);
 		eb = btrfs_clone_extent_buffer(eb_root);
-		btrfs_tree_read_unlock_blocking(eb_root);
+		btrfs_tree_read_unlock(eb_root);
 		free_extent_buffer(eb_root);
 	}
 
@@ -1477,10 +1473,6 @@ noinline int btrfs_cow_block(struct btrfs_trans_handle *trans,
 
 	search_start = buf->start & ~((u64)SZ_1G - 1);
 
-	if (parent)
-		btrfs_set_lock_blocking_write(parent);
-	btrfs_set_lock_blocking_write(buf);
-
 	/*
 	 * Before CoWing this block for later modification, check if it's
 	 * the subtree root and do the delayed subtree trace if needed.
@@ -1598,8 +1590,6 @@ int btrfs_realloc_node(struct btrfs_trans_handle *trans,
 	if (parent_nritems <= 1)
 		return 0;
 
-	btrfs_set_lock_blocking_write(parent);
-
 	for (i = start_slot; i <= end_slot; i++) {
 		struct btrfs_key first_key;
 		int close = 1;
@@ -1657,7 +1647,6 @@ int btrfs_realloc_node(struct btrfs_trans_handle *trans,
 			search_start = last_block;
 
 		btrfs_tree_lock(cur);
-		btrfs_set_lock_blocking_write(cur);
 		err = __btrfs_cow_block(trans, root, cur, parent, i,
 					&cur, search_start,
 					min(16 * blocksize,
@@ -1829,8 +1818,7 @@ static noinline int balance_level(struct btrfs_trans_handle *trans,
 
 	mid = path->nodes[level];
 
-	WARN_ON(path->locks[level] != BTRFS_WRITE_LOCK &&
-		path->locks[level] != BTRFS_WRITE_LOCK_BLOCKING);
+	WARN_ON(path->locks[level] != BTRFS_WRITE_LOCK);
 	WARN_ON(btrfs_header_generation(mid) != trans->transid);
 
 	orig_ptr = btrfs_node_blockptr(mid, orig_slot);
@@ -1859,7 +1847,6 @@ static noinline int balance_level(struct btrfs_trans_handle *trans,
 		}
 
 		btrfs_tree_lock(child);
-		btrfs_set_lock_blocking_write(child);
 		ret = btrfs_cow_block(trans, root, child, mid, 0, &child,
 				      BTRFS_NESTING_COW);
 		if (ret) {
@@ -1898,7 +1885,6 @@ static noinline int balance_level(struct btrfs_trans_handle *trans,
 
 	if (left) {
 		__btrfs_tree_lock(left, BTRFS_NESTING_LEFT);
-		btrfs_set_lock_blocking_write(left);
 		wret = btrfs_cow_block(trans, root, left,
 				       parent, pslot - 1, &left,
 				       BTRFS_NESTING_LEFT_COW);
@@ -1914,7 +1900,6 @@ static noinline int balance_level(struct btrfs_trans_handle *trans,
 
 	if (right) {
 		__btrfs_tree_lock(right, BTRFS_NESTING_RIGHT);
-		btrfs_set_lock_blocking_write(right);
 		wret = btrfs_cow_block(trans, root, right,
 				       parent, pslot + 1, &right,
 				       BTRFS_NESTING_RIGHT_COW);
@@ -2078,7 +2063,6 @@ static noinline int push_nodes_for_insert(struct btrfs_trans_handle *trans,
 		u32 left_nr;
 
 		__btrfs_tree_lock(left, BTRFS_NESTING_LEFT);
-		btrfs_set_lock_blocking_write(left);
 
 		left_nr = btrfs_header_nritems(left);
 		if (left_nr >= BTRFS_NODEPTRS_PER_BLOCK(fs_info) - 1) {
@@ -2133,7 +2117,6 @@ static noinline int push_nodes_for_insert(struct btrfs_trans_handle *trans,
 		u32 right_nr;
 
 		__btrfs_tree_lock(right, BTRFS_NESTING_RIGHT);
-		btrfs_set_lock_blocking_write(right);
 
 		right_nr = btrfs_header_nritems(right);
 		if (right_nr >= BTRFS_NODEPTRS_PER_BLOCK(fs_info) - 1) {
@@ -2393,14 +2376,6 @@ read_block_for_search(struct btrfs_root *root, struct btrfs_path *p,
 			return 0;
 		}
 
-		/* the pages were up to date, but we failed
-		 * the generation number check.  Do a full
-		 * read for the generation number that is correct.
-		 * We must do this without dropping locks so
-		 * we can trust our generation number
-		 */
-		btrfs_set_path_blocking(p);
-
 		/* now we're allowed to do a blocking uptodate check */
 		ret = btrfs_read_buffer(tmp, gen, parent_level - 1, &first_key);
 		if (!ret) {
@@ -2420,7 +2395,6 @@ read_block_for_search(struct btrfs_root *root, struct btrfs_path *p,
 	 * out which blocks to read.
 	 */
 	btrfs_unlock_up_safe(p, level + 1);
-	btrfs_set_path_blocking(p);
 
 	if (p->reada != READA_NONE)
 		reada_for_search(fs_info, p, level, slot, key->objectid);
@@ -2474,7 +2448,6 @@ setup_nodes_for_search(struct btrfs_trans_handle *trans,
 			goto again;
 		}
 
-		btrfs_set_path_blocking(p);
 		reada_for_balance(fs_info, p, level);
 		sret = split_node(trans, root, p, level);
 
@@ -2494,7 +2467,6 @@ setup_nodes_for_search(struct btrfs_trans_handle *trans,
 			goto again;
 		}
 
-		btrfs_set_path_blocking(p);
 		reada_for_balance(fs_info, p, level);
 		sret = balance_level(trans, root, p, level);
 
@@ -2746,7 +2718,6 @@ int btrfs_search_slot(struct btrfs_trans_handle *trans, struct btrfs_root *root,
 				goto again;
 			}
 
-			btrfs_set_path_blocking(p);
 			if (last_level)
 				err = btrfs_cow_block(trans, root, b, NULL, 0,
 						      &b,
@@ -2816,7 +2787,6 @@ int btrfs_search_slot(struct btrfs_trans_handle *trans, struct btrfs_root *root,
 					goto again;
 				}
 
-				btrfs_set_path_blocking(p);
 				err = split_leaf(trans, root, key,
 						 p, ins_len, ret == 0);
 
@@ -2878,17 +2848,11 @@ int btrfs_search_slot(struct btrfs_trans_handle *trans, struct btrfs_root *root,
 		if (!p->skip_locking) {
 			level = btrfs_header_level(b);
 			if (level <= write_lock_level) {
-				if (!btrfs_try_tree_write_lock(b)) {
-					btrfs_set_path_blocking(p);
-					btrfs_tree_lock(b);
-				}
+				btrfs_tree_lock(b);
 				p->locks[level] = BTRFS_WRITE_LOCK;
 			} else {
-				if (!btrfs_tree_read_lock_atomic(b)) {
-					btrfs_set_path_blocking(p);
-					__btrfs_tree_read_lock(b, BTRFS_NESTING_NORMAL,
-							       p->recurse);
-				}
+				__btrfs_tree_read_lock(b, BTRFS_NESTING_NORMAL,
+						       p->recurse);
 				p->locks[level] = BTRFS_READ_LOCK;
 			}
 			p->nodes[level] = b;
@@ -2896,12 +2860,6 @@ int btrfs_search_slot(struct btrfs_trans_handle *trans, struct btrfs_root *root,
 	}
 	ret = 1;
 done:
-	/*
-	 * we don't really know what they plan on doing with the path
-	 * from here on, so for now just mark it as blocking
-	 */
-	if (!p->leave_spinning)
-		btrfs_set_path_blocking(p);
 	if (ret < 0 && !p->skip_release_on_error)
 		btrfs_release_path(p);
 	return ret;
@@ -2993,10 +2951,7 @@ int btrfs_search_old_slot(struct btrfs_root *root, const struct btrfs_key *key,
 		}
 
 		level = btrfs_header_level(b);
-		if (!btrfs_tree_read_lock_atomic(b)) {
-			btrfs_set_path_blocking(p);
-			btrfs_tree_read_lock(b);
-		}
+		btrfs_tree_read_lock(b);
 		b = tree_mod_log_rewind(fs_info, p, b, time_seq);
 		if (!b) {
 			ret = -ENOMEM;
@@ -3007,8 +2962,6 @@ int btrfs_search_old_slot(struct btrfs_root *root, const struct btrfs_key *key,
 	}
 	ret = 1;
 done:
-	if (!p->leave_spinning)
-		btrfs_set_path_blocking(p);
 	if (ret < 0)
 		btrfs_release_path(p);
 
@@ -3371,7 +3324,7 @@ static noinline int insert_new_root(struct btrfs_trans_handle *trans,
 	add_root_to_dirty_list(root);
 	atomic_inc(&c->refs);
 	path->nodes[level] = c;
-	path->locks[level] = BTRFS_WRITE_LOCK_BLOCKING;
+	path->locks[level] = BTRFS_WRITE_LOCK;
 	path->slots[level] = 0;
 	return 0;
 }
@@ -3744,7 +3697,6 @@ static int push_leaf_right(struct btrfs_trans_handle *trans, struct btrfs_root
 		return 1;
 
 	__btrfs_tree_lock(right, BTRFS_NESTING_RIGHT);
-	btrfs_set_lock_blocking_write(right);
 
 	free_space = btrfs_leaf_free_space(right);
 	if (free_space < data_size)
@@ -3977,7 +3929,6 @@ static int push_leaf_left(struct btrfs_trans_handle *trans, struct btrfs_root
 		return 1;
 
 	__btrfs_tree_lock(left, BTRFS_NESTING_LEFT);
-	btrfs_set_lock_blocking_write(left);
 
 	free_space = btrfs_leaf_free_space(left);
 	if (free_space < data_size) {
@@ -4368,7 +4319,6 @@ static noinline int setup_leaf_for_split(struct btrfs_trans_handle *trans,
 			goto err;
 	}
 
-	btrfs_set_path_blocking(path);
 	ret = split_leaf(trans, root, &key, path, ins_len, 1);
 	if (ret)
 		goto err;
@@ -4398,8 +4348,6 @@ static noinline int split_item(struct btrfs_path *path,
 	leaf = path->nodes[0];
 	BUG_ON(btrfs_leaf_free_space(leaf) < sizeof(struct btrfs_item));
 
-	btrfs_set_path_blocking(path);
-
 	item = btrfs_item_nr(path->slots[0]);
 	orig_offset = btrfs_item_offset(leaf, item);
 	item_size = btrfs_item_size(leaf, item);
@@ -4965,7 +4913,6 @@ int btrfs_del_items(struct btrfs_trans_handle *trans, struct btrfs_root *root,
 		if (leaf == root->node) {
 			btrfs_set_header_level(leaf, 0);
 		} else {
-			btrfs_set_path_blocking(path);
 			btrfs_clean_tree_block(leaf);
 			btrfs_del_leaf(trans, root, path, leaf);
 		}
@@ -4987,7 +4934,6 @@ int btrfs_del_items(struct btrfs_trans_handle *trans, struct btrfs_root *root,
 			slot = path->slots[1];
 			atomic_inc(&leaf->refs);
 
-			btrfs_set_path_blocking(path);
 			wret = push_leaf_left(trans, root, path, 1, 1,
 					      1, (u32)-1);
 			if (wret < 0 && wret != -ENOSPC)
@@ -5158,7 +5104,6 @@ int btrfs_search_forward(struct btrfs_root *root, struct btrfs_key *min_key,
 		 */
 		if (slot >= nritems) {
 			path->slots[level] = slot;
-			btrfs_set_path_blocking(path);
 			sret = btrfs_find_next_key(root, path, min_key, level,
 						  min_trans);
 			if (sret == 0) {
@@ -5175,7 +5120,6 @@ int btrfs_search_forward(struct btrfs_root *root, struct btrfs_key *min_key,
 			ret = 0;
 			goto out;
 		}
-		btrfs_set_path_blocking(path);
 		cur = btrfs_read_node_slot(cur, slot);
 		if (IS_ERR(cur)) {
 			ret = PTR_ERR(cur);
@@ -5192,7 +5136,6 @@ int btrfs_search_forward(struct btrfs_root *root, struct btrfs_key *min_key,
 	path->keep_locks = keep_locks;
 	if (ret == 0) {
 		btrfs_unlock_up_safe(path, path->lowest_level + 1);
-		btrfs_set_path_blocking(path);
 		memcpy(min_key, &found_key, sizeof(found_key));
 	}
 	return ret;
@@ -5402,7 +5345,6 @@ int btrfs_next_old_leaf(struct btrfs_root *root, struct btrfs_path *path,
 				goto again;
 			}
 			if (!ret) {
-				btrfs_set_path_blocking(path);
 				__btrfs_tree_read_lock(next,
 						       BTRFS_NESTING_RIGHT,
 						       path->recurse);
@@ -5437,13 +5379,8 @@ int btrfs_next_old_leaf(struct btrfs_root *root, struct btrfs_path *path,
 		}
 
 		if (!path->skip_locking) {
-			ret = btrfs_try_tree_read_lock(next);
-			if (!ret) {
-				btrfs_set_path_blocking(path);
-				__btrfs_tree_read_lock(next,
-						       BTRFS_NESTING_RIGHT,
-						       path->recurse);
-			}
+			__btrfs_tree_read_lock(next, BTRFS_NESTING_RIGHT,
+					       path->recurse);
 			next_rw_lock = BTRFS_READ_LOCK;
 		}
 	}
@@ -5451,8 +5388,6 @@ int btrfs_next_old_leaf(struct btrfs_root *root, struct btrfs_path *path,
 done:
 	unlock_up(path, 0, 1, 0, NULL);
 	path->leave_spinning = old_spinning;
-	if (!old_spinning)
-		btrfs_set_path_blocking(path);
 
 	return ret;
 }
@@ -5474,7 +5409,6 @@ int btrfs_previous_item(struct btrfs_root *root,
 
 	while (1) {
 		if (path->slots[0] == 0) {
-			btrfs_set_path_blocking(path);
 			ret = btrfs_prev_leaf(root, path);
 			if (ret != 0)
 				return ret;
@@ -5516,7 +5450,6 @@ int btrfs_previous_extent_item(struct btrfs_root *root,
 
 	while (1) {
 		if (path->slots[0] == 0) {
-			btrfs_set_path_blocking(path);
 			ret = btrfs_prev_leaf(root, path);
 			if (ret != 0)
 				return ret;
diff --git a/fs/btrfs/delayed-inode.c b/fs/btrfs/delayed-inode.c
index bf1595a42a98..b00b7ed47fc0 100644
--- a/fs/btrfs/delayed-inode.c
+++ b/fs/btrfs/delayed-inode.c
@@ -741,13 +741,6 @@ static int btrfs_batch_insert_items(struct btrfs_root *root,
 		goto out;
 	}
 
-	/*
-	 * we need allocate some memory space, but it might cause the task
-	 * to sleep, so we set all locked nodes in the path to blocking locks
-	 * first.
-	 */
-	btrfs_set_path_blocking(path);
-
 	keys = kmalloc_array(nitems, sizeof(struct btrfs_key), GFP_NOFS);
 	if (!keys) {
 		ret = -ENOMEM;
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index b85872a2ccca..11002fb15102 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -296,10 +296,8 @@ static int verify_parent_transid(struct extent_io_tree *io_tree,
 	if (atomic)
 		return -EAGAIN;
 
-	if (need_lock) {
+	if (need_lock)
 		btrfs_tree_read_lock(eb);
-		btrfs_set_lock_blocking_read(eb);
-	}
 
 	lock_extent_bits(io_tree, eb->start, eb->start + eb->len - 1,
 			 &cached_state);
@@ -328,7 +326,7 @@ static int verify_parent_transid(struct extent_io_tree *io_tree,
 	unlock_extent_cached(io_tree, eb->start, eb->start + eb->len - 1,
 			     &cached_state);
 	if (need_lock)
-		btrfs_tree_read_unlock_blocking(eb);
+		btrfs_tree_read_unlock(eb);
 	return ret;
 }
 
@@ -1071,8 +1069,6 @@ void btrfs_clean_tree_block(struct extent_buffer *buf)
 			percpu_counter_add_batch(&fs_info->dirty_metadata_bytes,
 						 -buf->len,
 						 fs_info->dirty_metadata_batch);
-			/* ugh, clear_extent_buffer_dirty needs to lock the page */
-			btrfs_set_lock_blocking_write(buf);
 			clear_extent_buffer_dirty(buf);
 		}
 	}
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 3c1178c11a32..fed2369a583f 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -4528,7 +4528,6 @@ btrfs_init_new_buffer(struct btrfs_trans_handle *trans, struct btrfs_root *root,
 	btrfs_clean_tree_block(buf);
 	clear_bit(EXTENT_BUFFER_STALE, &buf->bflags);
 
-	btrfs_set_lock_blocking_write(buf);
 	set_extent_buffer_uptodate(buf);
 
 	memzero_extent_buffer(buf, 0, sizeof(struct btrfs_header));
@@ -4917,7 +4916,6 @@ static noinline int do_walk_down(struct btrfs_trans_handle *trans,
 		reada = 1;
 	}
 	btrfs_tree_lock(next);
-	btrfs_set_lock_blocking_write(next);
 
 	ret = btrfs_lookup_extent_info(trans, fs_info, bytenr, level - 1, 1,
 				       &wc->refs[level - 1],
@@ -4977,7 +4975,6 @@ static noinline int do_walk_down(struct btrfs_trans_handle *trans,
 			return -EIO;
 		}
 		btrfs_tree_lock(next);
-		btrfs_set_lock_blocking_write(next);
 	}
 
 	level--;
@@ -4989,7 +4986,7 @@ static noinline int do_walk_down(struct btrfs_trans_handle *trans,
 	}
 	path->nodes[level] = next;
 	path->slots[level] = 0;
-	path->locks[level] = BTRFS_WRITE_LOCK_BLOCKING;
+	path->locks[level] = BTRFS_WRITE_LOCK;
 	wc->level = level;
 	if (wc->level == 1)
 		wc->reada_slot = 0;
@@ -5117,8 +5114,7 @@ static noinline int walk_up_proc(struct btrfs_trans_handle *trans,
 		if (!path->locks[level]) {
 			BUG_ON(level == 0);
 			btrfs_tree_lock(eb);
-			btrfs_set_lock_blocking_write(eb);
-			path->locks[level] = BTRFS_WRITE_LOCK_BLOCKING;
+			path->locks[level] = BTRFS_WRITE_LOCK;
 
 			ret = btrfs_lookup_extent_info(trans, fs_info,
 						       eb->start, level, 1,
@@ -5161,8 +5157,7 @@ static noinline int walk_up_proc(struct btrfs_trans_handle *trans,
 		if (!path->locks[level] &&
 		    btrfs_header_generation(eb) == trans->transid) {
 			btrfs_tree_lock(eb);
-			btrfs_set_lock_blocking_write(eb);
-			path->locks[level] = BTRFS_WRITE_LOCK_BLOCKING;
+			path->locks[level] = BTRFS_WRITE_LOCK;
 		}
 		btrfs_clean_tree_block(eb);
 	}
@@ -5330,9 +5325,8 @@ int btrfs_drop_snapshot(struct btrfs_root *root, int update_ref, int for_reloc)
 	if (btrfs_disk_key_objectid(&root_item->drop_progress) == 0) {
 		level = btrfs_header_level(root->node);
 		path->nodes[level] = btrfs_lock_root_node(root);
-		btrfs_set_lock_blocking_write(path->nodes[level]);
 		path->slots[level] = 0;
-		path->locks[level] = BTRFS_WRITE_LOCK_BLOCKING;
+		path->locks[level] = BTRFS_WRITE_LOCK;
 		memset(&wc->update_progress, 0,
 		       sizeof(wc->update_progress));
 	} else {
@@ -5360,8 +5354,7 @@ int btrfs_drop_snapshot(struct btrfs_root *root, int update_ref, int for_reloc)
 		level = btrfs_header_level(root->node);
 		while (1) {
 			btrfs_tree_lock(path->nodes[level]);
-			btrfs_set_lock_blocking_write(path->nodes[level]);
-			path->locks[level] = BTRFS_WRITE_LOCK_BLOCKING;
+			path->locks[level] = BTRFS_WRITE_LOCK;
 
 			ret = btrfs_lookup_extent_info(trans, fs_info,
 						path->nodes[level]->start,
@@ -5548,7 +5541,7 @@ int btrfs_drop_subtree(struct btrfs_trans_handle *trans,
 	level = btrfs_header_level(node);
 	path->nodes[level] = node;
 	path->slots[level] = 0;
-	path->locks[level] = BTRFS_WRITE_LOCK_BLOCKING;
+	path->locks[level] = BTRFS_WRITE_LOCK;
 
 	wc->refs[parent_level] = 1;
 	wc->flags[parent_level] = BTRFS_BLOCK_FLAG_FULL_BACKREF;
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 5177e076d6b9..2ce870ce0175 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -1042,8 +1042,7 @@ int __btrfs_drop_extents(struct btrfs_trans_handle *trans,
 	 * write lock.
 	 */
 	if (!ret && replace_extent && leafs_visited == 1 &&
-	    (path->locks[0] == BTRFS_WRITE_LOCK_BLOCKING ||
-	     path->locks[0] == BTRFS_WRITE_LOCK) &&
+	    path->locks[0] == BTRFS_WRITE_LOCK &&
 	    btrfs_leaf_free_space(leaf) >=
 	    sizeof(struct btrfs_item) + extent_item_size) {
 
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index d90b079a9dbc..68548164dc34 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -6695,7 +6695,6 @@ struct extent_map *btrfs_get_extent(struct btrfs_inode *inode,
 		em->orig_start = em->start;
 		ptr = btrfs_file_extent_inline_start(item) + extent_offset;
 
-		btrfs_set_path_blocking(path);
 		if (!PageUptodate(page)) {
 			if (btrfs_file_extent_compression(leaf, item) !=
 			    BTRFS_COMPRESS_NONE) {
diff --git a/fs/btrfs/locking.c b/fs/btrfs/locking.c
index fa2f50241693..6e4fd4335d04 100644
--- a/fs/btrfs/locking.c
+++ b/fs/btrfs/locking.c
@@ -40,31 +40,6 @@
  *
  */
 
-/*
- * Mark already held read lock as blocking. Can be nested in write lock by the
- * same thread.
- *
- * Use when there are potentially long operations ahead so other thread waiting
- * on the lock will not actively spin but sleep instead.
- *
- * The rwlock is released and blocking reader counter is increased.
- */
-void btrfs_set_lock_blocking_read(struct extent_buffer *eb)
-{
-}
-
-/*
- * Mark already held write lock as blocking.
- *
- * Use when there are potentially long operations ahead so other threads
- * waiting on the lock will not actively spin but sleep instead.
- *
- * The rwlock is released and blocking writers is set.
- */
-void btrfs_set_lock_blocking_write(struct extent_buffer *eb)
-{
-}
-
 /*
  * __btrfs_tree_read_lock: Lock the extent buffer for read.
  * @eb - the eb to be locked.
@@ -120,17 +95,6 @@ void btrfs_tree_read_lock(struct extent_buffer *eb)
 	__btrfs_tree_read_lock(eb, BTRFS_NESTING_NORMAL, false);
 }
 
-/*
- * Lock extent buffer for read, optimistically expecting that there are no
- * contending blocking writers. If there are, don't wait.
- *
- * Return 1 if the rwlock has been taken, 0 otherwise
- */
-int btrfs_tree_read_lock_atomic(struct extent_buffer *eb)
-{
-	return btrfs_try_tree_read_lock(eb);
-}
-
 /*
  * Try-lock for read.
  *
@@ -182,18 +146,6 @@ void btrfs_tree_read_unlock(struct extent_buffer *eb)
 	up_read(&eb->lock);
 }
 
-/*
- * Release read lock, previously set to blocking by a pairing call to
- * btrfs_set_lock_blocking_read(). Can be nested in write lock by the same
- * thread.
- *
- * State of rwlock is unchanged, last reader wakes waiting threads.
- */
-void btrfs_tree_read_unlock_blocking(struct extent_buffer *eb)
-{
-	btrfs_tree_read_unlock(eb);
-}
-
 /*
  * __btrfs_tree_lock: Lock for write.
  * @eb - the eb to lock.
@@ -229,32 +181,6 @@ void btrfs_tree_unlock(struct extent_buffer *eb)
 	up_write(&eb->lock);
 }
 
-/*
- * Set all locked nodes in the path to blocking locks.  This should be done
- * before scheduling
- */
-void btrfs_set_path_blocking(struct btrfs_path *p)
-{
-	int i;
-
-	for (i = 0; i < BTRFS_MAX_LEVEL; i++) {
-		if (!p->nodes[i] || !p->locks[i])
-			continue;
-		/*
-		 * If we currently have a spinning reader or writer lock this
-		 * will bump the count of blocking holders and drop the
-		 * spinlock.
-		 */
-		if (p->locks[i] == BTRFS_READ_LOCK) {
-			btrfs_set_lock_blocking_read(p->nodes[i]);
-			p->locks[i] = BTRFS_READ_LOCK_BLOCKING;
-		} else if (p->locks[i] == BTRFS_WRITE_LOCK) {
-			btrfs_set_lock_blocking_write(p->nodes[i]);
-			p->locks[i] = BTRFS_WRITE_LOCK_BLOCKING;
-		}
-	}
-}
-
 /*
  * This releases any locks held in the path starting at level and going all the
  * way up to the root.
diff --git a/fs/btrfs/locking.h b/fs/btrfs/locking.h
index 9c43c64de9c5..7e952d877bd9 100644
--- a/fs/btrfs/locking.h
+++ b/fs/btrfs/locking.h
@@ -13,8 +13,6 @@
 
 #define BTRFS_WRITE_LOCK 1
 #define BTRFS_READ_LOCK 2
-#define BTRFS_WRITE_LOCK_BLOCKING 3
-#define BTRFS_READ_LOCK_BLOCKING 4
 
 /*
  * We are limited in number of subclasses by MAX_LOCKDEP_SUBCLASSES, which at
@@ -93,12 +91,8 @@ void __btrfs_tree_read_lock(struct extent_buffer *eb, enum btrfs_lock_nesting ne
 			    bool recurse);
 void btrfs_tree_read_lock(struct extent_buffer *eb);
 void btrfs_tree_read_unlock(struct extent_buffer *eb);
-void btrfs_tree_read_unlock_blocking(struct extent_buffer *eb);
-void btrfs_set_lock_blocking_read(struct extent_buffer *eb);
-void btrfs_set_lock_blocking_write(struct extent_buffer *eb);
 int btrfs_try_tree_read_lock(struct extent_buffer *eb);
 int btrfs_try_tree_write_lock(struct extent_buffer *eb);
-int btrfs_tree_read_lock_atomic(struct extent_buffer *eb);
 struct extent_buffer *btrfs_lock_root_node(struct btrfs_root *root);
 struct extent_buffer *__btrfs_read_lock_root_node(struct btrfs_root *root,
 						  bool recurse);
@@ -117,15 +111,12 @@ static inline void btrfs_assert_tree_locked(struct extent_buffer *eb) {
 static inline void btrfs_assert_tree_locked(struct extent_buffer *eb) { }
 #endif
 
-void btrfs_set_path_blocking(struct btrfs_path *p);
 void btrfs_unlock_up_safe(struct btrfs_path *path, int level);
 
 static inline void btrfs_tree_unlock_rw(struct extent_buffer *eb, int rw)
 {
-	if (rw == BTRFS_WRITE_LOCK || rw == BTRFS_WRITE_LOCK_BLOCKING)
+	if (rw == BTRFS_WRITE_LOCK)
 		btrfs_tree_unlock(eb);
-	else if (rw == BTRFS_READ_LOCK_BLOCKING)
-		btrfs_tree_read_unlock_blocking(eb);
 	else if (rw == BTRFS_READ_LOCK)
 		btrfs_tree_read_unlock(eb);
 	else
diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index 580899bdb991..f8e83be739d0 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -1902,8 +1902,7 @@ static int qgroup_trace_extent_swap(struct btrfs_trans_handle* trans,
 			src_path->nodes[cur_level] = eb;
 
 			btrfs_tree_read_lock(eb);
-			btrfs_set_lock_blocking_read(eb);
-			src_path->locks[cur_level] = BTRFS_READ_LOCK_BLOCKING;
+			src_path->locks[cur_level] = BTRFS_READ_LOCK;
 		}
 
 		src_path->slots[cur_level] = dst_path->slots[cur_level];
@@ -2043,8 +2042,7 @@ static int qgroup_trace_new_subtree_blocks(struct btrfs_trans_handle* trans,
 		dst_path->slots[cur_level] = 0;
 
 		btrfs_tree_read_lock(eb);
-		btrfs_set_lock_blocking_read(eb);
-		dst_path->locks[cur_level] = BTRFS_READ_LOCK_BLOCKING;
+		dst_path->locks[cur_level] = BTRFS_READ_LOCK;
 		need_cleanup = true;
 	}
 
@@ -2218,8 +2216,7 @@ int btrfs_qgroup_trace_subtree(struct btrfs_trans_handle *trans,
 			path->slots[level] = 0;
 
 			btrfs_tree_read_lock(eb);
-			btrfs_set_lock_blocking_read(eb);
-			path->locks[level] = BTRFS_READ_LOCK_BLOCKING;
+			path->locks[level] = BTRFS_READ_LOCK;
 
 			ret = btrfs_qgroup_trace_extent(trans, child_bytenr,
 							fs_info->nodesize,
diff --git a/fs/btrfs/ref-verify.c b/fs/btrfs/ref-verify.c
index 7f03dbe5b609..d79c82928ba8 100644
--- a/fs/btrfs/ref-verify.c
+++ b/fs/btrfs/ref-verify.c
@@ -575,10 +575,9 @@ static int walk_down_tree(struct btrfs_root *root, struct btrfs_path *path,
 				return -EIO;
 			}
 			btrfs_tree_read_lock(eb);
-			btrfs_set_lock_blocking_read(eb);
 			path->nodes[level-1] = eb;
 			path->slots[level-1] = 0;
-			path->locks[level-1] = BTRFS_READ_LOCK_BLOCKING;
+			path->locks[level-1] = BTRFS_READ_LOCK;
 		} else {
 			ret = process_leaf(root, path, bytenr, num_bytes);
 			if (ret)
@@ -1000,11 +999,10 @@ int btrfs_build_ref_tree(struct btrfs_fs_info *fs_info)
 		return -ENOMEM;
 
 	eb = btrfs_read_lock_root_node(fs_info->extent_root);
-	btrfs_set_lock_blocking_read(eb);
 	level = btrfs_header_level(eb);
 	path->nodes[level] = eb;
 	path->slots[level] = 0;
-	path->locks[level] = BTRFS_READ_LOCK_BLOCKING;
+	path->locks[level] = BTRFS_READ_LOCK;
 
 	while (1) {
 		/*
diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 3602806d71bd..3dd3eda97e38 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -1196,7 +1196,6 @@ int replace_path(struct btrfs_trans_handle *trans, struct reloc_control *rc,
 	btrfs_node_key_to_cpu(path->nodes[lowest_level], &key, slot);
 
 	eb = btrfs_lock_root_node(dest);
-	btrfs_set_lock_blocking_write(eb);
 	level = btrfs_header_level(eb);
 
 	if (level < lowest_level) {
@@ -1210,7 +1209,6 @@ int replace_path(struct btrfs_trans_handle *trans, struct reloc_control *rc,
 				      BTRFS_NESTING_COW);
 		BUG_ON(ret);
 	}
-	btrfs_set_lock_blocking_write(eb);
 
 	if (next_key) {
 		next_key->objectid = (u64)-1;
@@ -1279,7 +1277,6 @@ int replace_path(struct btrfs_trans_handle *trans, struct reloc_control *rc,
 						      BTRFS_NESTING_COW);
 				BUG_ON(ret);
 			}
-			btrfs_set_lock_blocking_write(eb);
 
 			btrfs_tree_unlock(parent);
 			free_extent_buffer(parent);
@@ -2307,7 +2304,6 @@ static int do_relocation(struct btrfs_trans_handle *trans,
 			goto next;
 		}
 		btrfs_tree_lock(eb);
-		btrfs_set_lock_blocking_write(eb);
 
 		if (!node->eb) {
 			ret = btrfs_cow_block(trans, root, eb, upper->eb,
diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index 45bf7da3ce1c..51747f3622a3 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -1596,8 +1596,6 @@ static noinline int create_pending_snapshot(struct btrfs_trans_handle *trans,
 		goto fail;
 	}
 
-	btrfs_set_lock_blocking_write(old);
-
 	ret = btrfs_copy_root(trans, root, old, &tmp, objectid);
 	/* clean up in any case */
 	btrfs_tree_unlock(old);
diff --git a/fs/btrfs/tree-defrag.c b/fs/btrfs/tree-defrag.c
index d3f28b8f4ff9..7c45d960b53c 100644
--- a/fs/btrfs/tree-defrag.c
+++ b/fs/btrfs/tree-defrag.c
@@ -52,7 +52,6 @@ int btrfs_defrag_leaves(struct btrfs_trans_handle *trans,
 		u32 nritems;
 
 		root_node = btrfs_lock_root_node(root);
-		btrfs_set_lock_blocking_write(root_node);
 		nritems = btrfs_header_nritems(root_node);
 		root->defrag_max.objectid = 0;
 		/* from above we know this is not a leaf */
diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index e0ab3c906119..90f53276057b 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -2736,7 +2736,6 @@ static noinline int walk_down_log_tree(struct btrfs_trans_handle *trans,
 
 				if (trans) {
 					btrfs_tree_lock(next);
-					btrfs_set_lock_blocking_write(next);
 					btrfs_clean_tree_block(next);
 					btrfs_wait_tree_block_writeback(next);
 					btrfs_tree_unlock(next);
@@ -2805,7 +2804,6 @@ static noinline int walk_up_log_tree(struct btrfs_trans_handle *trans,
 
 				if (trans) {
 					btrfs_tree_lock(next);
-					btrfs_set_lock_blocking_write(next);
 					btrfs_clean_tree_block(next);
 					btrfs_wait_tree_block_writeback(next);
 					btrfs_tree_unlock(next);
@@ -2887,7 +2885,6 @@ static int walk_log_tree(struct btrfs_trans_handle *trans,
 
 			if (trans) {
 				btrfs_tree_lock(next);
-				btrfs_set_lock_blocking_write(next);
 				btrfs_clean_tree_block(next);
 				btrfs_wait_tree_block_writeback(next);
 				btrfs_tree_unlock(next);
-- 
2.24.1

