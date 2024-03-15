Return-Path: <linux-btrfs+bounces-3323-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 42E6987CD7E
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Mar 2024 13:56:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66FC11C22448
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Mar 2024 12:56:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D5562577A;
	Fri, 15 Mar 2024 12:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yk/DCK/I"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC84325564
	for <linux-btrfs@vger.kernel.org>; Fri, 15 Mar 2024 12:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710507359; cv=none; b=S81C0ecHmHmekK9ep9EBAUa3cE2dM6WZsIdLTgtr1G06sItXp2r+e0CAoceTIk4L0pBMytwRGBTugezM83iiLTYHfj/f4rOlcTX6pKX8qbwHtZj/nX8brfMkZ03sm424fh1Xc5YonXIn19yO6MMKAmV+ditLe6DqHEQ8NXgBRCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710507359; c=relaxed/simple;
	bh=XNs34h/8H+2V5H9TqIqYzafDgXse7wKVlvLJL8/xPAk=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=a3fT5sx2vnsBNIkRu82jnn9B9YFnM3s2vytKRSxkEGIUN9g/ftDER6MBQE8QXg8qe74ulk86Nd/BT5JAdcUk8/z8aix26uqgw6eUXY/Qi4aSQzNgZfi2e32G13I81FLkMtg+TyE5PPN3aaYtqFltNbMkCXRVx2hIX6OsNYWvdUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yk/DCK/I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E19BC433C7
	for <linux-btrfs@vger.kernel.org>; Fri, 15 Mar 2024 12:55:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710507359;
	bh=XNs34h/8H+2V5H9TqIqYzafDgXse7wKVlvLJL8/xPAk=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=Yk/DCK/IUM2ncfvK/5XfRkWpWdBeuuqj+a1o2wNPXZEhNIW8rxWBLosE2yd4a52jQ
	 /6ihfANUT5ny1NXynRsKumobVG3a/AhwybLJB59JlbWn7eI1WR75vH62je+fqmBd8h
	 2tYiDOtHbN7gc/IxZDgdJBHf4WiH83PMgGs/ZL+L3Qk0xRkTo0E1ETeij+jXyXHTi8
	 J6faN2YwVDVZz2PC7EUbp5+sVIxLvSVgirH6X1BW2fcBwL1uCFGmw+SN8H4sI8hwdS
	 XakGGIQu9SCm6hE3i/1dIF4gY+adqoh/DexOeq8DamKIW6k4GWzOe+XDWAKnSPtCLs
	 1fyHfYBApx6Wg==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 2/2] btrfs: rename __btrfs_tree_lock() and __btrfs_tree_read_lock()
Date: Fri, 15 Mar 2024 12:55:53 +0000
Message-Id: <ba792d935e76901a16ed978115fa7a84d42f4cfb.1710506834.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1710506834.git.fdmanana@suse.com>
References: <cover.1710506834.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

The __btrfs_tree_lock() and __btrfs_tree_read_lock() are using a naming
with a double underscore prefix, which is specially not proper for
exported functions. Rename the double underscore from their name and add
the "_nested" prefix.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/ctree.c       | 12 ++++++------
 fs/btrfs/extent-tree.c |  2 +-
 fs/btrfs/locking.c     |  6 +++---
 fs/btrfs/locking.h     |  8 ++++----
 4 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index aaf53fd84358..f6a98e7cf006 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -1003,7 +1003,7 @@ static noinline int balance_level(struct btrfs_trans_handle *trans,
 			goto out;
 		}
 
-		__btrfs_tree_lock(left, BTRFS_NESTING_LEFT);
+		btrfs_tree_lock_nested(left, BTRFS_NESTING_LEFT);
 		wret = btrfs_cow_block(trans, root, left,
 				       parent, pslot - 1, &left,
 				       BTRFS_NESTING_LEFT_COW);
@@ -1021,7 +1021,7 @@ static noinline int balance_level(struct btrfs_trans_handle *trans,
 			goto out;
 		}
 
-		__btrfs_tree_lock(right, BTRFS_NESTING_RIGHT);
+		btrfs_tree_lock_nested(right, BTRFS_NESTING_RIGHT);
 		wret = btrfs_cow_block(trans, root, right,
 				       parent, pslot + 1, &right,
 				       BTRFS_NESTING_RIGHT_COW);
@@ -1205,7 +1205,7 @@ static noinline int push_nodes_for_insert(struct btrfs_trans_handle *trans,
 		if (IS_ERR(left))
 			return PTR_ERR(left);
 
-		__btrfs_tree_lock(left, BTRFS_NESTING_LEFT);
+		btrfs_tree_lock_nested(left, BTRFS_NESTING_LEFT);
 
 		left_nr = btrfs_header_nritems(left);
 		if (left_nr >= BTRFS_NODEPTRS_PER_BLOCK(fs_info) - 1) {
@@ -1265,7 +1265,7 @@ static noinline int push_nodes_for_insert(struct btrfs_trans_handle *trans,
 		if (IS_ERR(right))
 			return PTR_ERR(right);
 
-		__btrfs_tree_lock(right, BTRFS_NESTING_RIGHT);
+		btrfs_tree_lock_nested(right, BTRFS_NESTING_RIGHT);
 
 		right_nr = btrfs_header_nritems(right);
 		if (right_nr >= BTRFS_NODEPTRS_PER_BLOCK(fs_info) - 1) {
@@ -3267,7 +3267,7 @@ static int push_leaf_right(struct btrfs_trans_handle *trans, struct btrfs_root
 	if (IS_ERR(right))
 		return PTR_ERR(right);
 
-	__btrfs_tree_lock(right, BTRFS_NESTING_RIGHT);
+	btrfs_tree_lock_nested(right, BTRFS_NESTING_RIGHT);
 
 	free_space = btrfs_leaf_free_space(right);
 	if (free_space < data_size)
@@ -3483,7 +3483,7 @@ static int push_leaf_left(struct btrfs_trans_handle *trans, struct btrfs_root
 	if (IS_ERR(left))
 		return PTR_ERR(left);
 
-	__btrfs_tree_lock(left, BTRFS_NESTING_LEFT);
+	btrfs_tree_lock_nested(left, BTRFS_NESTING_LEFT);
 
 	free_space = btrfs_leaf_free_space(left);
 	if (free_space < data_size) {
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index beedd6ed64d3..1a1191efe59e 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -5093,7 +5093,7 @@ btrfs_init_new_buffer(struct btrfs_trans_handle *trans, struct btrfs_root *root,
 	 */
 	btrfs_set_buffer_lockdep_class(lockdep_owner, buf, level);
 
-	__btrfs_tree_lock(buf, nest);
+	btrfs_tree_lock_nested(buf, nest);
 	btrfs_clear_buffer_dirty(trans, buf);
 	clear_bit(EXTENT_BUFFER_STALE, &buf->bflags);
 	clear_bit(EXTENT_BUFFER_ZONED_ZEROOUT, &buf->bflags);
diff --git a/fs/btrfs/locking.c b/fs/btrfs/locking.c
index 1f355ca65910..508a3fdfcd58 100644
--- a/fs/btrfs/locking.c
+++ b/fs/btrfs/locking.c
@@ -129,14 +129,14 @@ static void btrfs_set_eb_lock_owner(struct extent_buffer *eb, pid_t owner) { }
  */
 
 /*
- * __btrfs_tree_read_lock - lock extent buffer for read
+ * btrfs_tree_read_lock_nested - lock extent buffer for read
  * @eb:		the eb to be locked
  * @nest:	the nesting level to be used for lockdep
  *
  * This takes the read lock on the extent buffer, using the specified nesting
  * level for lockdep purposes.
  */
-void __btrfs_tree_read_lock(struct extent_buffer *eb, enum btrfs_lock_nesting nest)
+void btrfs_tree_read_lock_nested(struct extent_buffer *eb, enum btrfs_lock_nesting nest)
 {
 	u64 start_ns = 0;
 
@@ -193,7 +193,7 @@ void btrfs_tree_read_unlock(struct extent_buffer *eb)
  *
  * Returns with the eb->lock write locked.
  */
-void __btrfs_tree_lock(struct extent_buffer *eb, enum btrfs_lock_nesting nest)
+void btrfs_tree_lock_nested(struct extent_buffer *eb, enum btrfs_lock_nesting nest)
 	__acquires(&eb->lock)
 {
 	u64 start_ns = 0;
diff --git a/fs/btrfs/locking.h b/fs/btrfs/locking.h
index c30aff66e86f..1bc8e6738879 100644
--- a/fs/btrfs/locking.h
+++ b/fs/btrfs/locking.h
@@ -163,20 +163,20 @@ enum btrfs_lockdep_trans_states {
 static_assert(BTRFS_NESTING_MAX <= MAX_LOCKDEP_SUBCLASSES,
 	      "too many lock subclasses defined");
 
-void __btrfs_tree_lock(struct extent_buffer *eb, enum btrfs_lock_nesting nest);
+void btrfs_tree_lock_nested(struct extent_buffer *eb, enum btrfs_lock_nesting nest);
 
 static inline void btrfs_tree_lock(struct extent_buffer *eb)
 {
-	__btrfs_tree_lock(eb, BTRFS_NESTING_NORMAL);
+	btrfs_tree_lock_nested(eb, BTRFS_NESTING_NORMAL);
 }
 
 void btrfs_tree_unlock(struct extent_buffer *eb);
 
-void __btrfs_tree_read_lock(struct extent_buffer *eb, enum btrfs_lock_nesting nest);
+void btrfs_tree_read_lock_nested(struct extent_buffer *eb, enum btrfs_lock_nesting nest);
 
 static inline void btrfs_tree_read_lock(struct extent_buffer *eb)
 {
-	__btrfs_tree_read_lock(eb, BTRFS_NESTING_NORMAL);
+	btrfs_tree_read_lock_nested(eb, BTRFS_NESTING_NORMAL);
 }
 
 void btrfs_tree_read_unlock(struct extent_buffer *eb);
-- 
2.43.0


