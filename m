Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AD4C543953
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Jun 2022 18:48:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343523AbiFHQsA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 8 Jun 2022 12:48:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343518AbiFHQr7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 8 Jun 2022 12:47:59 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0928546B1F
        for <linux-btrfs@vger.kernel.org>; Wed,  8 Jun 2022 09:47:58 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id BCE511F997;
        Wed,  8 Jun 2022 16:47:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1654706876; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IVOhJVK9uwctxFNz7gB3ktCQhU7o5STATTlLWVTI8Ps=;
        b=Dzri54jVuFl9NL0TVKdD5a0zBDb+n9bQsnaKNd125LQwnCVZKcmClplrjOCwoaAI30wM6m
        k8UYY1T+8CalS9uTLpH0FpzCVbxBcabyErtmMo4yc4XgYUzM7Vt3LJL5hFyp1WltBjJ5b0
        jnzLOMQz0I+Q3VD/XJRgZCJexkA0ko4=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id B34712C141;
        Wed,  8 Jun 2022 16:47:56 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 2C511DA883; Wed,  8 Jun 2022 18:43:28 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 4/9] btrfs: pass bits by value not pointer for extent_state helpers
Date:   Wed,  8 Jun 2022 18:43:28 +0200
Message-Id: <2fbeb26c4e8b36c5727214827aa57cd374c4be15.1654706034.git.dsterba@suse.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1654706034.git.dsterba@suse.com>
References: <cover.1654706034.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The bits are passed to all extent state helpers for not apparent reason,
the value only read and never updated so remove the indirection and pass
directly. Also unify the type to u32 where needed.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/ctree.h     |  4 ++--
 fs/btrfs/extent_io.c | 46 +++++++++++++++++++++-----------------------
 fs/btrfs/inode.c     | 24 +++++++++++------------
 3 files changed, 36 insertions(+), 38 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index f7afdfd0bae7..13d74948c542 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -3320,9 +3320,9 @@ void btrfs_new_inode_args_destroy(struct btrfs_new_inode_args *args);
 struct inode *btrfs_new_subvol_inode(struct user_namespace *mnt_userns,
 				     struct inode *dir);
  void btrfs_set_delalloc_extent(struct inode *inode, struct extent_state *state,
-			       unsigned *bits);
+			        u32 bits);
 void btrfs_clear_delalloc_extent(struct inode *inode,
-				 struct extent_state *state, unsigned *bits);
+				 struct extent_state *state, u32 bits);
 void btrfs_merge_delalloc_extent(struct inode *inode, struct extent_state *new,
 				 struct extent_state *other);
 void btrfs_split_delalloc_extent(struct inode *inode,
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 1411286e5ef2..9b1dfe4363c9 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -510,7 +510,7 @@ static void merge_state(struct extent_io_tree *tree,
 }
 
 static void set_state_bits(struct extent_io_tree *tree,
-			   struct extent_state *state, u32 *bits,
+			   struct extent_state *state, u32 bits,
 			   struct extent_changeset *changeset);
 
 /*
@@ -527,7 +527,7 @@ static int insert_state(struct extent_io_tree *tree,
 			struct extent_state *state,
 			struct rb_node ***node_in,
 			struct rb_node **parent_in,
-			u32 *bits, struct extent_changeset *changeset)
+			u32 bits, struct extent_changeset *changeset)
 {
 	struct rb_node **node;
 	struct rb_node *parent;
@@ -639,11 +639,11 @@ static struct extent_state *next_state(struct extent_state *state)
  */
 static struct extent_state *clear_state_bit(struct extent_io_tree *tree,
 					    struct extent_state *state,
-					    u32 *bits, int wake,
+					    u32 bits, int wake,
 					    struct extent_changeset *changeset)
 {
 	struct extent_state *next;
-	u32 bits_to_clear = *bits & ~EXTENT_CTLBITS;
+	u32 bits_to_clear = bits & ~EXTENT_CTLBITS;
 	int ret;
 
 	if ((bits_to_clear & EXTENT_DIRTY) && (state->state & EXTENT_DIRTY)) {
@@ -805,8 +805,7 @@ int __clear_extent_bit(struct extent_io_tree *tree, u64 start, u64 end,
 		if (err)
 			goto out;
 		if (state->end <= end) {
-			state = clear_state_bit(tree, state, &bits, wake,
-						changeset);
+			state = clear_state_bit(tree, state, bits, wake, changeset);
 			goto next;
 		}
 		goto search_again;
@@ -827,13 +826,13 @@ int __clear_extent_bit(struct extent_io_tree *tree, u64 start, u64 end,
 		if (wake)
 			wake_up(&state->wq);
 
-		clear_state_bit(tree, prealloc, &bits, wake, changeset);
+		clear_state_bit(tree, prealloc, bits, wake, changeset);
 
 		prealloc = NULL;
 		goto out;
 	}
 
-	state = clear_state_bit(tree, state, &bits, wake, changeset);
+	state = clear_state_bit(tree, state, bits, wake, changeset);
 next:
 	if (last_end == (u64)-1)
 		goto out;
@@ -924,9 +923,9 @@ static void wait_extent_bit(struct extent_io_tree *tree, u64 start, u64 end,
 
 static void set_state_bits(struct extent_io_tree *tree,
 			   struct extent_state *state,
-			   u32 *bits, struct extent_changeset *changeset)
+			   u32 bits, struct extent_changeset *changeset)
 {
-	u32 bits_to_set = *bits & ~EXTENT_CTLBITS;
+	u32 bits_to_set = bits & ~EXTENT_CTLBITS;
 	int ret;
 
 	if (tree->private_data && is_data_inode(tree->private_data))
@@ -1022,7 +1021,7 @@ int set_extent_bit(struct extent_io_tree *tree, u64 start, u64 end, u32 bits,
 		BUG_ON(!prealloc);
 		prealloc->start = start;
 		prealloc->end = end;
-		err = insert_state(tree, prealloc, &p, &parent, &bits, changeset);
+		err = insert_state(tree, prealloc, &p, &parent, bits, changeset);
 		if (err)
 			extent_io_tree_panic(tree, err);
 
@@ -1048,7 +1047,7 @@ int set_extent_bit(struct extent_io_tree *tree, u64 start, u64 end, u32 bits,
 			goto out;
 		}
 
-		set_state_bits(tree, state, &bits, changeset);
+		set_state_bits(tree, state, bits, changeset);
 		cache_state(state, cached_state);
 		merge_state(tree, state);
 		if (last_end == (u64)-1)
@@ -1104,7 +1103,7 @@ int set_extent_bit(struct extent_io_tree *tree, u64 start, u64 end, u32 bits,
 		if (err)
 			goto out;
 		if (state->end <= end) {
-			set_state_bits(tree, state, &bits, changeset);
+			set_state_bits(tree, state, bits, changeset);
 			cache_state(state, cached_state);
 			merge_state(tree, state);
 			if (last_end == (u64)-1)
@@ -1140,7 +1139,7 @@ int set_extent_bit(struct extent_io_tree *tree, u64 start, u64 end, u32 bits,
 		 */
 		prealloc->start = start;
 		prealloc->end = this_end;
-		err = insert_state(tree, prealloc, NULL, NULL, &bits, changeset);
+		err = insert_state(tree, prealloc, NULL, NULL, bits, changeset);
 		if (err)
 			extent_io_tree_panic(tree, err);
 
@@ -1168,7 +1167,7 @@ int set_extent_bit(struct extent_io_tree *tree, u64 start, u64 end, u32 bits,
 		if (err)
 			extent_io_tree_panic(tree, err);
 
-		set_state_bits(tree, prealloc, &bits, changeset);
+		set_state_bits(tree, prealloc, bits, changeset);
 		cache_state(prealloc, cached_state);
 		merge_state(tree, prealloc);
 		prealloc = NULL;
@@ -1265,7 +1264,7 @@ int convert_extent_bit(struct extent_io_tree *tree, u64 start, u64 end,
 		}
 		prealloc->start = start;
 		prealloc->end = end;
-		err = insert_state(tree, prealloc, &p, &parent, &bits, NULL);
+		err = insert_state(tree, prealloc, &p, &parent, bits, NULL);
 		if (err)
 			extent_io_tree_panic(tree, err);
 		cache_state(prealloc, cached_state);
@@ -1284,9 +1283,9 @@ int convert_extent_bit(struct extent_io_tree *tree, u64 start, u64 end,
 	 * Just lock what we found and keep going
 	 */
 	if (state->start == start && state->end <= end) {
-		set_state_bits(tree, state, &bits, NULL);
+		set_state_bits(tree, state, bits, NULL);
 		cache_state(state, cached_state);
-		state = clear_state_bit(tree, state, &clear_bits, 0, NULL);
+		state = clear_state_bit(tree, state, clear_bits, 0, NULL);
 		if (last_end == (u64)-1)
 			goto out;
 		start = last_end + 1;
@@ -1325,10 +1324,9 @@ int convert_extent_bit(struct extent_io_tree *tree, u64 start, u64 end,
 		if (err)
 			goto out;
 		if (state->end <= end) {
-			set_state_bits(tree, state, &bits, NULL);
+			set_state_bits(tree, state, bits, NULL);
 			cache_state(state, cached_state);
-			state = clear_state_bit(tree, state, &clear_bits, 0,
-						NULL);
+			state = clear_state_bit(tree, state, clear_bits, 0, NULL);
 			if (last_end == (u64)-1)
 				goto out;
 			start = last_end + 1;
@@ -1364,7 +1362,7 @@ int convert_extent_bit(struct extent_io_tree *tree, u64 start, u64 end,
 		 */
 		prealloc->start = start;
 		prealloc->end = this_end;
-		err = insert_state(tree, prealloc, NULL, NULL, &bits, NULL);
+		err = insert_state(tree, prealloc, NULL, NULL, bits, NULL);
 		if (err)
 			extent_io_tree_panic(tree, err);
 		cache_state(prealloc, cached_state);
@@ -1389,9 +1387,9 @@ int convert_extent_bit(struct extent_io_tree *tree, u64 start, u64 end,
 		if (err)
 			extent_io_tree_panic(tree, err);
 
-		set_state_bits(tree, prealloc, &bits, NULL);
+		set_state_bits(tree, prealloc, bits, NULL);
 		cache_state(prealloc, cached_state);
-		clear_state_bit(tree, prealloc, &clear_bits, 0, NULL);
+		clear_state_bit(tree, prealloc, clear_bits, 0, NULL);
 		prealloc = NULL;
 		goto out;
 	}
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 7a54f964ff37..33ba4d22e143 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -2274,18 +2274,18 @@ static void btrfs_del_delalloc_inode(struct btrfs_root *root,
  * list of inodes that have pending delalloc work to be done.
  */
 void btrfs_set_delalloc_extent(struct inode *inode, struct extent_state *state,
-			       unsigned *bits)
+			       u32 bits)
 {
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
 
-	if ((*bits & EXTENT_DEFRAG) && !(*bits & EXTENT_DELALLOC))
+	if ((bits & EXTENT_DEFRAG) && !(bits & EXTENT_DELALLOC))
 		WARN_ON(1);
 	/*
 	 * set_bit and clear bit hooks normally require _irqsave/restore
 	 * but in this case, we are only testing for the DELALLOC
 	 * bit, which is only set or cleared with irqs on
 	 */
-	if (!(state->state & EXTENT_DELALLOC) && (*bits & EXTENT_DELALLOC)) {
+	if (!(state->state & EXTENT_DELALLOC) && (bits & EXTENT_DELALLOC)) {
 		struct btrfs_root *root = BTRFS_I(inode)->root;
 		u64 len = state->end + 1 - state->start;
 		u32 num_extents = count_max_extents(len);
@@ -2303,7 +2303,7 @@ void btrfs_set_delalloc_extent(struct inode *inode, struct extent_state *state,
 					 fs_info->delalloc_batch);
 		spin_lock(&BTRFS_I(inode)->lock);
 		BTRFS_I(inode)->delalloc_bytes += len;
-		if (*bits & EXTENT_DEFRAG)
+		if (bits & EXTENT_DEFRAG)
 			BTRFS_I(inode)->defrag_bytes += len;
 		if (do_list && !test_bit(BTRFS_INODE_IN_DELALLOC_LIST,
 					 &BTRFS_I(inode)->runtime_flags))
@@ -2312,7 +2312,7 @@ void btrfs_set_delalloc_extent(struct inode *inode, struct extent_state *state,
 	}
 
 	if (!(state->state & EXTENT_DELALLOC_NEW) &&
-	    (*bits & EXTENT_DELALLOC_NEW)) {
+	    (bits & EXTENT_DELALLOC_NEW)) {
 		spin_lock(&BTRFS_I(inode)->lock);
 		BTRFS_I(inode)->new_delalloc_bytes += state->end + 1 -
 			state->start;
@@ -2325,14 +2325,14 @@ void btrfs_set_delalloc_extent(struct inode *inode, struct extent_state *state,
  * accounting happens.
  */
 void btrfs_clear_delalloc_extent(struct inode *vfs_inode,
-				 struct extent_state *state, unsigned *bits)
+				 struct extent_state *state, u32 bits)
 {
 	struct btrfs_inode *inode = BTRFS_I(vfs_inode);
 	struct btrfs_fs_info *fs_info = btrfs_sb(vfs_inode->i_sb);
 	u64 len = state->end + 1 - state->start;
 	u32 num_extents = count_max_extents(len);
 
-	if ((state->state & EXTENT_DEFRAG) && (*bits & EXTENT_DEFRAG)) {
+	if ((state->state & EXTENT_DEFRAG) && (bits & EXTENT_DEFRAG)) {
 		spin_lock(&inode->lock);
 		inode->defrag_bytes -= len;
 		spin_unlock(&inode->lock);
@@ -2343,7 +2343,7 @@ void btrfs_clear_delalloc_extent(struct inode *vfs_inode,
 	 * but in this case, we are only testing for the DELALLOC
 	 * bit, which is only set or cleared with irqs on
 	 */
-	if ((state->state & EXTENT_DELALLOC) && (*bits & EXTENT_DELALLOC)) {
+	if ((state->state & EXTENT_DELALLOC) && (bits & EXTENT_DELALLOC)) {
 		struct btrfs_root *root = inode->root;
 		bool do_list = !btrfs_is_free_space_inode(inode);
 
@@ -2356,7 +2356,7 @@ void btrfs_clear_delalloc_extent(struct inode *vfs_inode,
 		 * don't need to call delalloc_release_metadata if there is an
 		 * error.
 		 */
-		if (*bits & EXTENT_CLEAR_META_RESV &&
+		if (bits & EXTENT_CLEAR_META_RESV &&
 		    root != fs_info->tree_root)
 			btrfs_delalloc_release_metadata(inode, len, false);
 
@@ -2366,7 +2366,7 @@ void btrfs_clear_delalloc_extent(struct inode *vfs_inode,
 
 		if (!btrfs_is_data_reloc_root(root) &&
 		    do_list && !(state->state & EXTENT_NORESERVE) &&
-		    (*bits & EXTENT_CLEAR_DATA_RESV))
+		    (bits & EXTENT_CLEAR_DATA_RESV))
 			btrfs_free_reserved_data_space_noquota(fs_info, len);
 
 		percpu_counter_add_batch(&fs_info->delalloc_bytes, -len,
@@ -2381,11 +2381,11 @@ void btrfs_clear_delalloc_extent(struct inode *vfs_inode,
 	}
 
 	if ((state->state & EXTENT_DELALLOC_NEW) &&
-	    (*bits & EXTENT_DELALLOC_NEW)) {
+	    (bits & EXTENT_DELALLOC_NEW)) {
 		spin_lock(&inode->lock);
 		ASSERT(inode->new_delalloc_bytes >= len);
 		inode->new_delalloc_bytes -= len;
-		if (*bits & EXTENT_ADD_INODE_BYTES)
+		if (bits & EXTENT_ADD_INODE_BYTES)
 			inode_add_bytes(&inode->vfs_inode, len);
 		spin_unlock(&inode->lock);
 	}
-- 
2.36.1

