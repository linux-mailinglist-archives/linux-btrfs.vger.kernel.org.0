Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D863C6152E5
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Nov 2022 21:13:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230103AbiKAUNF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 1 Nov 2022 16:13:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230115AbiKAUM5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 1 Nov 2022 16:12:57 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1DB11DA7A
        for <linux-btrfs@vger.kernel.org>; Tue,  1 Nov 2022 13:12:56 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 71474336C4;
        Tue,  1 Nov 2022 20:12:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1667333575; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1Jg1jzF4DSqhnH8GI2HuCf642o0RM6X9SkbO//JbGKs=;
        b=D/tVqdp1E80/mKtxnRQ10xdmjNqFW2VcHKej9Izdzxxku74D/2dr7Gph1pP7fcjUszkq0Q
        /t4jG+/AfIAxf/+V9N8F3OZD3LWI3pCm9cs26ZGG6lSRlDqlpQWEcRZL0HHPeSGqxPZX4/
        UOML7vfCDvUTM85H78xS8HgN0qk4rbk=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 6B2D62C141;
        Tue,  1 Nov 2022 20:12:55 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id BBBD8DA79D; Tue,  1 Nov 2022 21:12:38 +0100 (CET)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 27/40] btrfs: switch extent_io_tree::private_data to btrfs_inode and rename
Date:   Tue,  1 Nov 2022 21:12:38 +0100
Message-Id: <e9d99f0e7265eaad61e0d665942b5981ac61098d.1667331828.git.dsterba@suse.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <cover.1667331828.git.dsterba@suse.com>
References: <cover.1667331828.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_SOFTFAIL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The extent_io_tree::private_data was meant to be a preparatory work for
the metadata inode rework but that never materialized. Now it's used
only for an inode so it's better to change the appropriate type and
rename it.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/extent-io-tree.c    | 32 ++++++++++++++++----------------
 fs/btrfs/extent-io-tree.h    |  3 ++-
 fs/btrfs/inode.c             |  2 +-
 include/trace/events/btrfs.h | 27 ++++++++++++---------------
 4 files changed, 31 insertions(+), 33 deletions(-)

diff --git a/fs/btrfs/extent-io-tree.c b/fs/btrfs/extent-io-tree.c
index 81365870576f..bbcc65593d1d 100644
--- a/fs/btrfs/extent-io-tree.c
+++ b/fs/btrfs/extent-io-tree.c
@@ -58,17 +58,17 @@ static inline void __btrfs_debug_check_extent_io_range(const char *caller,
 						       struct extent_io_tree *tree,
 						       u64 start, u64 end)
 {
-	struct inode *inode = tree->private_data;
+	struct btrfs_inode *inode = tree->inode;
 	u64 isize;
 
 	if (!inode)
 		return;
 
-	isize = i_size_read(inode);
+	isize = i_size_read(&inode->vfs_inode);
 	if (end >= PAGE_SIZE && (end % 2) == 0 && end != isize - 1) {
-		btrfs_debug_rl(BTRFS_I(inode)->root->fs_info,
+		btrfs_debug_rl(inode->root->fs_info,
 		    "%s: ino %llu isize %llu odd range [%llu,%llu]",
-			caller, btrfs_ino(BTRFS_I(inode)), isize, start, end);
+			caller, btrfs_ino(inode), isize, start, end);
 	}
 }
 #else
@@ -99,7 +99,7 @@ void extent_io_tree_init(struct btrfs_fs_info *fs_info,
 	tree->fs_info = fs_info;
 	tree->state = RB_ROOT;
 	spin_lock_init(&tree->lock);
-	tree->private_data = NULL;
+	tree->inode = NULL;
 	tree->owner = owner;
 	if (owner == IO_TREE_INODE_FILE_EXTENT)
 		lockdep_set_class(&tree->lock, &file_extent_tree_class);
@@ -346,9 +346,9 @@ static void merge_state(struct extent_io_tree *tree, struct extent_state *state)
 	other = prev_state(state);
 	if (other && other->end == state->start - 1 &&
 	    other->state == state->state) {
-		if (tree->private_data)
-			btrfs_merge_delalloc_extent(tree->private_data,
-						    state, other);
+		if (tree->inode)
+			btrfs_merge_delalloc_extent(&tree->inode->vfs_inode, state,
+						    other);
 		state->start = other->start;
 		rb_erase(&other->rb_node, &tree->state);
 		RB_CLEAR_NODE(&other->rb_node);
@@ -357,8 +357,8 @@ static void merge_state(struct extent_io_tree *tree, struct extent_state *state)
 	other = next_state(state);
 	if (other && other->start == state->end + 1 &&
 	    other->state == state->state) {
-		if (tree->private_data)
-			btrfs_merge_delalloc_extent(tree->private_data, state,
+		if (tree->inode)
+			btrfs_merge_delalloc_extent(&tree->inode->vfs_inode, state,
 						    other);
 		state->end = other->end;
 		rb_erase(&other->rb_node, &tree->state);
@@ -374,8 +374,8 @@ static void set_state_bits(struct extent_io_tree *tree,
 	u32 bits_to_set = bits & ~EXTENT_CTLBITS;
 	int ret;
 
-	if (tree->private_data)
-		btrfs_set_delalloc_extent(tree->private_data, state, bits);
+	if (tree->inode)
+		btrfs_set_delalloc_extent(&tree->inode->vfs_inode, state, bits);
 
 	ret = add_extent_changeset(state, bits_to_set, changeset, 1);
 	BUG_ON(ret < 0);
@@ -462,8 +462,8 @@ static int split_state(struct extent_io_tree *tree, struct extent_state *orig,
 	struct rb_node *parent = NULL;
 	struct rb_node **node;
 
-	if (tree->private_data)
-		btrfs_split_delalloc_extent(tree->private_data, orig, split);
+	if (tree->inode)
+		btrfs_split_delalloc_extent(&tree->inode->vfs_inode, orig, split);
 
 	prealloc->start = orig->start;
 	prealloc->end = split - 1;
@@ -510,8 +510,8 @@ static struct extent_state *clear_state_bit(struct extent_io_tree *tree,
 	u32 bits_to_clear = bits & ~EXTENT_CTLBITS;
 	int ret;
 
-	if (tree->private_data)
-		btrfs_clear_delalloc_extent(tree->private_data, state, bits);
+	if (tree->inode)
+		btrfs_clear_delalloc_extent(&tree->inode->vfs_inode, state, bits);
 
 	ret = add_extent_changeset(state, bits_to_clear, changeset, 0);
 	BUG_ON(ret < 0);
diff --git a/fs/btrfs/extent-io-tree.h b/fs/btrfs/extent-io-tree.h
index 0e16642c28a3..cdee8c0854c8 100644
--- a/fs/btrfs/extent-io-tree.h
+++ b/fs/btrfs/extent-io-tree.h
@@ -80,7 +80,8 @@ enum {
 struct extent_io_tree {
 	struct rb_root state;
 	struct btrfs_fs_info *fs_info;
-	void *private_data;
+	/* Inode associated with this tree, or NULL. */
+	struct btrfs_inode *inode;
 
 	/* Who owns this io tree, should be one of IO_TREE_* */
 	u8 owner;
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 35b8aae4de5d..8b329a361096 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -8871,7 +8871,7 @@ struct inode *btrfs_alloc_inode(struct super_block *sb)
 	inode = &ei->vfs_inode;
 	extent_map_tree_init(&ei->extent_tree);
 	extent_io_tree_init(fs_info, &ei->io_tree, IO_TREE_INODE_IO);
-	ei->io_tree.private_data = inode;
+	ei->io_tree.inode = ei;
 	extent_io_tree_init(fs_info, &ei->file_extent_tree,
 			    IO_TREE_INODE_FILE_EXTENT);
 	ei->io_failure_tree = RB_ROOT;
diff --git a/include/trace/events/btrfs.h b/include/trace/events/btrfs.h
index ed50e81174bf..0bce0b4ff2fa 100644
--- a/include/trace/events/btrfs.h
+++ b/include/trace/events/btrfs.h
@@ -1993,12 +1993,11 @@ TRACE_EVENT(btrfs_set_extent_bit,
 
 	TP_fast_assign_btrfs(tree->fs_info,
 		__entry->owner = tree->owner;
-		if (tree->private_data) {
-			const struct inode *inode = tree->private_data;
+		if (tree->inode) {
+			const struct btrfs_inode *inode = tree->inode;
 
-			__entry->ino	= btrfs_ino(BTRFS_I(inode));
-			__entry->rootid	=
-				BTRFS_I(inode)->root->root_key.objectid;
+			__entry->ino	= btrfs_ino(inode);
+			__entry->rootid	= inode->root->root_key.objectid;
 		} else {
 			__entry->ino	= 0;
 			__entry->rootid	= 0;
@@ -2032,12 +2031,11 @@ TRACE_EVENT(btrfs_clear_extent_bit,
 
 	TP_fast_assign_btrfs(tree->fs_info,
 		__entry->owner = tree->owner;
-		if (tree->private_data) {
-			const struct inode *inode = tree->private_data;
+		if (tree->inode) {
+			const struct btrfs_inode *inode = tree->inode;
 
-			__entry->ino	= btrfs_ino(BTRFS_I(inode));
-			__entry->rootid	=
-				BTRFS_I(inode)->root->root_key.objectid;
+			__entry->ino	= btrfs_ino(inode);
+			__entry->rootid	= inode->root->root_key.objectid;
 		} else {
 			__entry->ino	= 0;
 			__entry->rootid	= 0;
@@ -2072,12 +2070,11 @@ TRACE_EVENT(btrfs_convert_extent_bit,
 
 	TP_fast_assign_btrfs(tree->fs_info,
 		__entry->owner = tree->owner;
-		if (tree->private_data) {
-			const struct inode *inode = tree->private_data;
+		if (tree->inode) {
+			const struct btrfs_inode *inode = tree->inode;
 
-			__entry->ino	= btrfs_ino(BTRFS_I(inode));
-			__entry->rootid	=
-				BTRFS_I(inode)->root->root_key.objectid;
+			__entry->ino	= btrfs_ino(inode);
+			__entry->rootid	= inode->root->root_key.objectid;
 		} else {
 			__entry->ino	= 0;
 			__entry->rootid	= 0;
-- 
2.37.3

