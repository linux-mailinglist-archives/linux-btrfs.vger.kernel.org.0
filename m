Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5D9A24C26F
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Aug 2020 17:46:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729379AbgHTPqo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 20 Aug 2020 11:46:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729333AbgHTPq0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 20 Aug 2020 11:46:26 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D1B4C061387
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Aug 2020 08:46:24 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id x7so1121584qvi.5
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Aug 2020 08:46:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Gp6qqrP3P2F9uERd9l/U86A3+cd7a2CtO9N91RFkqpk=;
        b=dcK7tawmSZkI24WyIiTa7FFu09IOcZGaE0ZOduR04r2FtpZr0nhKwsX2cyk813oJzX
         RIvF9ruqlqIK5UqbXBzDvl4l2OMKW4U6TYulOt5oDBXS4F766h/g8Xmb5DPre5vWdrm6
         5Lm9WevqWGzGdspI2sVmcPK9eSww7yONhodjs/c778VdcfLoQg35xybrjlYPqyT6oh57
         GCAOPEXSZQlLWc6YYzMHbx8mOxW90CMBG4aOoiZtGpoxBMAqrSROJRGE4xVk0f8d/2Xq
         ytiBmr/diZBydmsWd3c1t5gEyscDDQmduY6cUpCjUMrpZlDHJ+JWEXf0PQ4uMrlNYxbe
         spMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Gp6qqrP3P2F9uERd9l/U86A3+cd7a2CtO9N91RFkqpk=;
        b=tAcbwEXCNND/jntnAk31tSAPfrQ2kDV0tgFh23pHFwUv2V+fyRHqvLvV2JUDtP3TJg
         uy8HuAGBydTOQ4F+fTOTfy7sR5gnommWz+OkLHaeBcdGeT63S+QtV38aR5NaRU9E7cJK
         gNPuCPNOd5Jxfe0H6PRow746ftaIkpQ26xDXorKxcrHqndlMUuZMamyLsi+TfZC3uWaD
         yNtdF261j6TaRcSrqCgcx69JtCe6cppiqWc2PtDR76bjrHhUBQ1Iowukqf29NCbRGToY
         1bXmezzCVGvF/HinvT4/tf5hI8uEHB2AXFtNmMd3wJgr4LjrprAMkYyWt4uR6fxJSLaL
         TbOg==
X-Gm-Message-State: AOAM531XxfAObxFUcEl4l0rhra/QlhOcllrIS80teYG2ouB/JeJA9tit
        uCMSjJrUy0/R1A/TQMRSuh3gicEKB15frftb
X-Google-Smtp-Source: ABdhPJzZ/BgGsJu4vMNL3jXpQr3A5c8MMUX61kr++lpZjeU0rvIkYS4r+CMFoDylQD45Gi8/omEPEA==
X-Received: by 2002:ad4:438e:: with SMTP id s14mr3524265qvr.18.1597938382784;
        Thu, 20 Aug 2020 08:46:22 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id p34sm3678600qte.79.2020.08.20.08.46.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2020 08:46:21 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 04/12] btrfs: introduce BTRFS_NESTING_COW for cow'ing blocks
Date:   Thu, 20 Aug 2020 11:46:03 -0400
Message-Id: <2666e12e4ec5235d9054a4d9ba0aaa08cd8e2fe9.1597938191.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1597938190.git.josef@toxicpanda.com>
References: <cover.1597938190.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

When we COW a block we are holding a lock on the original block, and
then we lock the new COW block.  Because our lockdep maps are based on
root + level, this will make lockdep complain.  We need a way to
indicate a subclass for locking the COW'ed block, so plumb through our
btrfs_lock_nesting from btrfs_cow_block down to the btrfs_init_buffer,
and then introduce BTRFS_NESTING_COW to be used for cow'ing blocks.

The reason I've added all this extra infrastructure is because there
will be need of different nesting classes in follow up patches.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/ctree.c       | 52 ++++++++++++++++++++++++++----------------
 fs/btrfs/ctree.h       |  6 +++--
 fs/btrfs/disk-io.c     |  5 ++--
 fs/btrfs/extent-tree.c | 12 ++++++----
 fs/btrfs/ioctl.c       |  3 ++-
 fs/btrfs/locking.h     |  8 +++++++
 fs/btrfs/relocation.c  | 11 +++++----
 fs/btrfs/transaction.c |  5 ++--
 8 files changed, 66 insertions(+), 36 deletions(-)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index 41d0685d0e87..d8f0e128c7ba 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -198,7 +198,7 @@ int btrfs_copy_root(struct btrfs_trans_handle *trans,
 		btrfs_node_key(buf, &disk_key, 0);
 
 	cow = btrfs_alloc_tree_block(trans, root, 0, new_root_objectid,
-			&disk_key, level, buf->start, 0);
+			&disk_key, level, buf->start, 0, BTRFS_NESTING_NORMAL);
 	if (IS_ERR(cow))
 		return PTR_ERR(cow);
 
@@ -957,7 +957,8 @@ static struct extent_buffer *alloc_tree_block_no_bg_flush(
 					  const struct btrfs_disk_key *disk_key,
 					  int level,
 					  u64 hint,
-					  u64 empty_size)
+					  u64 empty_size,
+					  enum btrfs_lock_nesting nest)
 {
 	struct btrfs_fs_info *fs_info = root->fs_info;
 	struct extent_buffer *ret;
@@ -986,7 +987,7 @@ static struct extent_buffer *alloc_tree_block_no_bg_flush(
 
 	ret = btrfs_alloc_tree_block(trans, root, parent_start,
 				     root->root_key.objectid, disk_key, level,
-				     hint, empty_size);
+				     hint, empty_size, nest);
 	trans->can_flush_pending_bgs = true;
 
 	return ret;
@@ -1009,7 +1010,8 @@ static noinline int __btrfs_cow_block(struct btrfs_trans_handle *trans,
 			     struct extent_buffer *buf,
 			     struct extent_buffer *parent, int parent_slot,
 			     struct extent_buffer **cow_ret,
-			     u64 search_start, u64 empty_size)
+			     u64 search_start, u64 empty_size,
+			     enum btrfs_lock_nesting nest)
 {
 	struct btrfs_fs_info *fs_info = root->fs_info;
 	struct btrfs_disk_key disk_key;
@@ -1040,7 +1042,7 @@ static noinline int __btrfs_cow_block(struct btrfs_trans_handle *trans,
 		parent_start = parent->start;
 
 	cow = alloc_tree_block_no_bg_flush(trans, root, parent_start, &disk_key,
-					   level, search_start, empty_size);
+					   level, search_start, empty_size, nest);
 	if (IS_ERR(cow))
 		return PTR_ERR(cow);
 
@@ -1446,7 +1448,8 @@ static inline int should_cow_block(struct btrfs_trans_handle *trans,
 noinline int btrfs_cow_block(struct btrfs_trans_handle *trans,
 		    struct btrfs_root *root, struct extent_buffer *buf,
 		    struct extent_buffer *parent, int parent_slot,
-		    struct extent_buffer **cow_ret)
+		    struct extent_buffer **cow_ret,
+		    enum btrfs_lock_nesting nest)
 {
 	struct btrfs_fs_info *fs_info = root->fs_info;
 	u64 search_start;
@@ -1485,7 +1488,7 @@ noinline int btrfs_cow_block(struct btrfs_trans_handle *trans,
 	 */
 	btrfs_qgroup_trace_subtree_after_cow(trans, root, buf);
 	ret = __btrfs_cow_block(trans, root, buf, parent,
-				 parent_slot, cow_ret, search_start, 0);
+				 parent_slot, cow_ret, search_start, 0, nest);
 
 	trace_btrfs_cow_block(root, buf, *cow_ret);
 
@@ -1657,7 +1660,8 @@ int btrfs_realloc_node(struct btrfs_trans_handle *trans,
 		err = __btrfs_cow_block(trans, root, cur, parent, i,
 					&cur, search_start,
 					min(16 * blocksize,
-					    (end_slot - i) * blocksize));
+					    (end_slot - i) * blocksize),
+					BTRFS_NESTING_COW);
 		if (err) {
 			btrfs_tree_unlock(cur);
 			free_extent_buffer(cur);
@@ -1855,7 +1859,8 @@ static noinline int balance_level(struct btrfs_trans_handle *trans,
 
 		btrfs_tree_lock(child);
 		btrfs_set_lock_blocking_write(child);
-		ret = btrfs_cow_block(trans, root, child, mid, 0, &child);
+		ret = btrfs_cow_block(trans, root, child, mid, 0, &child,
+				      BTRFS_NESTING_COW);
 		if (ret) {
 			btrfs_tree_unlock(child);
 			free_extent_buffer(child);
@@ -1894,7 +1899,8 @@ static noinline int balance_level(struct btrfs_trans_handle *trans,
 		btrfs_tree_lock(left);
 		btrfs_set_lock_blocking_write(left);
 		wret = btrfs_cow_block(trans, root, left,
-				       parent, pslot - 1, &left);
+				       parent, pslot - 1, &left,
+				       BTRFS_NESTING_COW);
 		if (wret) {
 			ret = wret;
 			goto enospc;
@@ -1909,7 +1915,8 @@ static noinline int balance_level(struct btrfs_trans_handle *trans,
 		btrfs_tree_lock(right);
 		btrfs_set_lock_blocking_write(right);
 		wret = btrfs_cow_block(trans, root, right,
-				       parent, pslot + 1, &right);
+				       parent, pslot + 1, &right,
+				       BTRFS_NESTING_COW);
 		if (wret) {
 			ret = wret;
 			goto enospc;
@@ -2077,7 +2084,8 @@ static noinline int push_nodes_for_insert(struct btrfs_trans_handle *trans,
 			wret = 1;
 		} else {
 			ret = btrfs_cow_block(trans, root, left, parent,
-					      pslot - 1, &left);
+					      pslot - 1, &left,
+					      BTRFS_NESTING_COW);
 			if (ret)
 				wret = 1;
 			else {
@@ -2132,7 +2140,7 @@ static noinline int push_nodes_for_insert(struct btrfs_trans_handle *trans,
 		} else {
 			ret = btrfs_cow_block(trans, root, right,
 					      parent, pslot + 1,
-					      &right);
+					      &right, BTRFS_NESTING_COW);
 			if (ret)
 				wret = 1;
 			else {
@@ -2740,11 +2748,13 @@ int btrfs_search_slot(struct btrfs_trans_handle *trans, struct btrfs_root *root,
 			btrfs_set_path_blocking(p);
 			if (last_level)
 				err = btrfs_cow_block(trans, root, b, NULL, 0,
-						      &b);
+						      &b,
+						      BTRFS_NESTING_COW);
 			else
 				err = btrfs_cow_block(trans, root, b,
 						      p->nodes[level + 1],
-						      p->slots[level + 1], &b);
+						      p->slots[level + 1], &b,
+						      BTRFS_NESTING_COW);
 			if (err) {
 				ret = err;
 				goto done;
@@ -3332,7 +3342,8 @@ static noinline int insert_new_root(struct btrfs_trans_handle *trans,
 		btrfs_node_key(lower, &lower_key, 0);
 
 	c = alloc_tree_block_no_bg_flush(trans, root, 0, &lower_key, level,
-					 root->node->start, 0);
+					 root->node->start, 0,
+					 BTRFS_NESTING_NORMAL);
 	if (IS_ERR(c))
 		return PTR_ERR(c);
 
@@ -3462,7 +3473,7 @@ static noinline int split_node(struct btrfs_trans_handle *trans,
 	btrfs_node_key(c, &disk_key, mid);
 
 	split = alloc_tree_block_no_bg_flush(trans, root, 0, &disk_key, level,
-					     c->start, 0);
+					     c->start, 0, BTRFS_NESTING_NORMAL);
 	if (IS_ERR(split))
 		return PTR_ERR(split);
 
@@ -3740,7 +3751,7 @@ static int push_leaf_right(struct btrfs_trans_handle *trans, struct btrfs_root
 
 	/* cow and double check */
 	ret = btrfs_cow_block(trans, root, right, upper,
-			      slot + 1, &right);
+			      slot + 1, &right, BTRFS_NESTING_COW);
 	if (ret)
 		goto out_unlock;
 
@@ -3975,7 +3986,8 @@ static int push_leaf_left(struct btrfs_trans_handle *trans, struct btrfs_root
 
 	/* cow and double check */
 	ret = btrfs_cow_block(trans, root, left,
-			      path->nodes[1], slot - 1, &left);
+			      path->nodes[1], slot - 1, &left,
+			      BTRFS_NESTING_COW);
 	if (ret) {
 		/* we hit -ENOSPC, but it isn't fatal here */
 		if (ret == -ENOSPC)
@@ -4238,7 +4250,7 @@ static noinline int split_leaf(struct btrfs_trans_handle *trans,
 		btrfs_item_key(l, &disk_key, mid);
 
 	right = alloc_tree_block_no_bg_flush(trans, root, 0, &disk_key, 0,
-					     l->start, 0);
+					     l->start, 0, BTRFS_NESTING_NORMAL);
 	if (IS_ERR(right))
 		return PTR_ERR(right);
 
diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 0df7a593ddf0..86a620d1c3f7 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -2526,7 +2526,8 @@ struct extent_buffer *btrfs_alloc_tree_block(struct btrfs_trans_handle *trans,
 					     u64 parent, u64 root_objectid,
 					     const struct btrfs_disk_key *key,
 					     int level, u64 hint,
-					     u64 empty_size);
+					     u64 empty_size,
+					     enum btrfs_lock_nesting nest);
 void btrfs_free_tree_block(struct btrfs_trans_handle *trans,
 			   struct btrfs_root *root,
 			   struct extent_buffer *buf,
@@ -2667,7 +2668,8 @@ struct extent_buffer *btrfs_read_node_slot(struct extent_buffer *parent,
 int btrfs_cow_block(struct btrfs_trans_handle *trans,
 		    struct btrfs_root *root, struct extent_buffer *buf,
 		    struct extent_buffer *parent, int parent_slot,
-		    struct extent_buffer **cow_ret);
+		    struct extent_buffer **cow_ret,
+		    enum btrfs_lock_nesting nest);
 int btrfs_copy_root(struct btrfs_trans_handle *trans,
 		      struct btrfs_root *root,
 		      struct extent_buffer *buf,
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 93e4e565906e..b85872a2ccca 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -1209,7 +1209,8 @@ struct btrfs_root *btrfs_create_tree(struct btrfs_trans_handle *trans,
 	root->root_key.type = BTRFS_ROOT_ITEM_KEY;
 	root->root_key.offset = 0;
 
-	leaf = btrfs_alloc_tree_block(trans, root, 0, objectid, NULL, 0, 0, 0);
+	leaf = btrfs_alloc_tree_block(trans, root, 0, objectid, NULL, 0, 0, 0,
+				      BTRFS_NESTING_NORMAL);
 	if (IS_ERR(leaf)) {
 		ret = PTR_ERR(leaf);
 		leaf = NULL;
@@ -1281,7 +1282,7 @@ static struct btrfs_root *alloc_log_tree(struct btrfs_trans_handle *trans,
 	 */
 
 	leaf = btrfs_alloc_tree_block(trans, root, 0, BTRFS_TREE_LOG_OBJECTID,
-			NULL, 0, 0, 0);
+			NULL, 0, 0, 0, BTRFS_NESTING_NORMAL);
 	if (IS_ERR(leaf)) {
 		btrfs_put_root(root);
 		return ERR_CAST(leaf);
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 6c2373f65be2..3c1178c11a32 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -4500,7 +4500,8 @@ int btrfs_alloc_logged_file_extent(struct btrfs_trans_handle *trans,
 
 static struct extent_buffer *
 btrfs_init_new_buffer(struct btrfs_trans_handle *trans, struct btrfs_root *root,
-		      u64 bytenr, int level, u64 owner)
+		      u64 bytenr, int level, u64 owner,
+		      enum btrfs_lock_nesting nest)
 {
 	struct btrfs_fs_info *fs_info = root->fs_info;
 	struct extent_buffer *buf;
@@ -4523,7 +4524,7 @@ btrfs_init_new_buffer(struct btrfs_trans_handle *trans, struct btrfs_root *root,
 	}
 
 	btrfs_set_buffer_lockdep_class(owner, buf, level);
-	btrfs_tree_lock(buf);
+	__btrfs_tree_lock(buf, nest);
 	btrfs_clean_tree_block(buf);
 	clear_bit(EXTENT_BUFFER_STALE, &buf->bflags);
 
@@ -4569,7 +4570,8 @@ struct extent_buffer *btrfs_alloc_tree_block(struct btrfs_trans_handle *trans,
 					     u64 parent, u64 root_objectid,
 					     const struct btrfs_disk_key *key,
 					     int level, u64 hint,
-					     u64 empty_size)
+					     u64 empty_size,
+					     enum btrfs_lock_nesting nest)
 {
 	struct btrfs_fs_info *fs_info = root->fs_info;
 	struct btrfs_key ins;
@@ -4585,7 +4587,7 @@ struct extent_buffer *btrfs_alloc_tree_block(struct btrfs_trans_handle *trans,
 #ifdef CONFIG_BTRFS_FS_RUN_SANITY_TESTS
 	if (btrfs_is_testing(fs_info)) {
 		buf = btrfs_init_new_buffer(trans, root, root->alloc_bytenr,
-					    level, root_objectid);
+					    level, root_objectid, nest);
 		if (!IS_ERR(buf))
 			root->alloc_bytenr += blocksize;
 		return buf;
@@ -4602,7 +4604,7 @@ struct extent_buffer *btrfs_alloc_tree_block(struct btrfs_trans_handle *trans,
 		goto out_unuse;
 
 	buf = btrfs_init_new_buffer(trans, root, ins.objectid, level,
-				    root_objectid);
+				    root_objectid, nest);
 	if (IS_ERR(buf)) {
 		ret = PTR_ERR(buf);
 		goto out_free_reserved;
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 18713900a32b..f4d0d6c27f3c 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -628,7 +628,8 @@ static noinline int create_subvol(struct inode *dir,
 	if (ret)
 		goto fail;
 
-	leaf = btrfs_alloc_tree_block(trans, root, 0, objectid, NULL, 0, 0, 0);
+	leaf = btrfs_alloc_tree_block(trans, root, 0, objectid, NULL, 0, 0, 0,
+				      BTRFS_NESTING_NORMAL);
 	if (IS_ERR(leaf)) {
 		ret = PTR_ERR(leaf);
 		goto fail;
diff --git a/fs/btrfs/locking.h b/fs/btrfs/locking.h
index ffbbd33d8fd7..5a4fdef197f5 100644
--- a/fs/btrfs/locking.h
+++ b/fs/btrfs/locking.h
@@ -19,6 +19,14 @@
 enum btrfs_lock_nesting {
 	BTRFS_NESTING_NORMAL,
 
+	/*
+	 * When we COW a block we are holding the lock on the original block,
+	 * and since our lockdep maps are rootid+level, this confuses lockdep
+	 * when we lock the newly allocated COW'd block.  Handle this by having
+	 * a subclass for COW'ed blocks so that lockdep doesn't complain.
+	 */
+	BTRFS_NESTING_COW,
+
 	/*
 	 * We are limited to MAX_LOCKDEP_SUBLCLASSES number of subclasses, so
 	 * add this in here and add a static_assert to keep us from going over
diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 4ba1ab9cc76d..3602806d71bd 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -1206,7 +1206,8 @@ int replace_path(struct btrfs_trans_handle *trans, struct reloc_control *rc,
 	}
 
 	if (cow) {
-		ret = btrfs_cow_block(trans, dest, eb, NULL, 0, &eb);
+		ret = btrfs_cow_block(trans, dest, eb, NULL, 0, &eb,
+				      BTRFS_NESTING_COW);
 		BUG_ON(ret);
 	}
 	btrfs_set_lock_blocking_write(eb);
@@ -1274,7 +1275,8 @@ int replace_path(struct btrfs_trans_handle *trans, struct reloc_control *rc,
 			btrfs_tree_lock(eb);
 			if (cow) {
 				ret = btrfs_cow_block(trans, dest, eb, parent,
-						      slot, &eb);
+						      slot, &eb,
+						      BTRFS_NESTING_COW);
 				BUG_ON(ret);
 			}
 			btrfs_set_lock_blocking_write(eb);
@@ -1781,7 +1783,8 @@ static noinline_for_stack int merge_reloc_root(struct reloc_control *rc,
 	 * relocated and the block is tree root.
 	 */
 	leaf = btrfs_lock_root_node(root);
-	ret = btrfs_cow_block(trans, root, leaf, NULL, 0, &leaf);
+	ret = btrfs_cow_block(trans, root, leaf, NULL, 0, &leaf,
+			      BTRFS_NESTING_COW);
 	btrfs_tree_unlock(leaf);
 	free_extent_buffer(leaf);
 	if (ret < 0)
@@ -2308,7 +2311,7 @@ static int do_relocation(struct btrfs_trans_handle *trans,
 
 		if (!node->eb) {
 			ret = btrfs_cow_block(trans, root, eb, upper->eb,
-					      slot, &eb);
+					      slot, &eb, BTRFS_NESTING_COW);
 			btrfs_tree_unlock(eb);
 			free_extent_buffer(eb);
 			if (ret < 0) {
diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index 20c6ac1a5de7..45bf7da3ce1c 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -1182,7 +1182,7 @@ static noinline int commit_cowonly_roots(struct btrfs_trans_handle *trans)
 
 	eb = btrfs_lock_root_node(fs_info->tree_root);
 	ret = btrfs_cow_block(trans, fs_info->tree_root, eb, NULL,
-			      0, &eb);
+			      0, &eb, BTRFS_NESTING_COW);
 	btrfs_tree_unlock(eb);
 	free_extent_buffer(eb);
 
@@ -1587,7 +1587,8 @@ static noinline int create_pending_snapshot(struct btrfs_trans_handle *trans,
 	btrfs_set_root_otransid(new_root_item, trans->transid);
 
 	old = btrfs_lock_root_node(root);
-	ret = btrfs_cow_block(trans, root, old, NULL, 0, &old);
+	ret = btrfs_cow_block(trans, root, old, NULL, 0, &old,
+			      BTRFS_NESTING_COW);
 	if (ret) {
 		btrfs_tree_unlock(old);
 		free_extent_buffer(old);
-- 
2.24.1

