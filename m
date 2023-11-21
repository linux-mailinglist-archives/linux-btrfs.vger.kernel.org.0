Return-Path: <linux-btrfs+bounces-237-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8CF57F2E48
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Nov 2023 14:27:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E6CC281AEB
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Nov 2023 13:27:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFF3B51C49;
	Tue, 21 Nov 2023 13:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="YmqMA6qz"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81FED12C
	for <linux-btrfs@vger.kernel.org>; Tue, 21 Nov 2023 05:27:33 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out2.suse.de (Postfix) with ESMTP id 1C2BF1F8B8;
	Tue, 21 Nov 2023 13:27:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1700573252; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FUQ8QPTUG7jSquJMvOKepy8GTRd+jl5REvi9Cfns9IQ=;
	b=YmqMA6qzfHva611cFbviQx0IC4K0yGeNdf6lXktipmfTrBGBNFoU6F7Mm6UXcRTRA5WgMk
	twkSwnv9Ww0JJngFEmimNSL44lL28NWxFo0TBx8KGb559Fz1IuasmYqwQD39X60g2I6Qlg
	fIld2Z9Q3rGkXtGmd+VQnDv/zfM57UI=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
	by relay2.suse.de (Postfix) with ESMTP id 1E4592C146;
	Tue, 21 Nov 2023 13:27:32 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
	id 37CBEDA86C; Tue, 21 Nov 2023 14:20:24 +0100 (CET)
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 5/5] btrfs: always set extent_io_tree::inode and drop fs_info
Date: Tue, 21 Nov 2023 14:20:24 +0100
Message-ID: <b0c32e8c9b9dde6baae540e62ce593709a4ac577.1700572232.git.dsterba@suse.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <cover.1700572232.git.dsterba@suse.com>
References: <cover.1700572232.git.dsterba@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: ++++++++++++++++++++++
Authentication-Results: smtp-out2.suse.de;
	dkim=none;
	dmarc=fail reason="No valid SPF, No valid DKIM" header.from=suse.com (policy=quarantine);
	spf=softfail (smtp-out2.suse.de: 149.44.160.134 is neither permitted nor denied by domain of dsterba@suse.cz) smtp.mailfrom=dsterba@suse.cz
X-Rspamd-Server: rspamd2
X-Spamd-Result: default: False [22.00 / 50.00];
	 ARC_NA(0.00)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_SPAM_SHORT(3.00)[1.000];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 R_SPF_SOFTFAIL(4.60)[~all:c];
	 DMARC_POLICY_QUARANTINE(1.50)[suse.com : No valid SPF, No valid DKIM,quarantine];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_TWO(0.00)[2];
	 MID_CONTAINS_FROM(1.00)[];
	 RWL_MAILSPIKE_GOOD(-1.00)[149.44.160.134:from];
	 NEURAL_SPAM_LONG(3.50)[1.000];
	 VIOLATED_DIRECT_SPF(3.50)[];
	 FORGED_SENDER(0.30)[dsterba@suse.com,dsterba@suse.cz];
	 RCVD_NO_TLS_LAST(0.10)[];
	 R_DKIM_NA(2.20)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_COUNT_TWO(0.00)[2];
	 FROM_NEQ_ENVFROM(0.10)[dsterba@suse.com,dsterba@suse.cz];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Score: 22.00
X-Rspamd-Queue-Id: 1C2BF1F8B8

The extent_io_tree is embedded in several structures, notably in struct
btrfs_inode.  The fs_info is only used for reporting errors and for
reference in trace points. We can get to the pointer through the inode,
but not all io trees set it. However, we always know the owner and
can recognize if inode is valid.  For access helpers are provided, const
variant for the trace points.

This reduces size of extent_io_tree by 8 bytes and following structures
in turn:

- btrfs_inode		1104 -> 1088
- btrfs_device		 520 ->  512
- btrfs_root		1360 -> 1344
- btrfs_transaction	 456 ->  440
- btrfs_fs_info		3600 -> 3592
- reloc_control		1520 -> 1512

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/extent-io-tree.c    | 80 ++++++++++++++++++++++++++----------
 fs/btrfs/extent-io-tree.h    | 18 ++++++--
 fs/btrfs/inode.c             |  3 ++
 fs/btrfs/tests/btrfs-tests.c |  2 +-
 include/trace/events/btrfs.h | 45 +++++++-------------
 5 files changed, 93 insertions(+), 55 deletions(-)

diff --git a/fs/btrfs/extent-io-tree.c b/fs/btrfs/extent-io-tree.c
index 2d564ead9dbe..dbd201a99693 100644
--- a/fs/btrfs/extent-io-tree.c
+++ b/fs/btrfs/extent-io-tree.c
@@ -58,12 +58,13 @@ static inline void __btrfs_debug_check_extent_io_range(const char *caller,
 						       struct extent_io_tree *tree,
 						       u64 start, u64 end)
 {
-	struct btrfs_inode *inode = tree->inode;
+	const struct btrfs_inode *inode;
 	u64 isize;
 
-	if (!inode)
+	if (tree->owner != IO_TREE_INODE_IO)
 		return;
 
+	inode = extent_io_tree_to_inode_const(tree);
 	isize = i_size_read(&inode->vfs_inode);
 	if (end >= PAGE_SIZE && (end % 2) == 0 && end != isize - 1) {
 		btrfs_debug_rl(inode->root->fs_info,
@@ -79,13 +80,44 @@ static inline void __btrfs_debug_check_extent_io_range(const char *caller,
 #endif
 
 
+/*
+ * The only tree allowed to set the inode is IO_TREE_INODE_IO.
+ */
+static bool is_inode_io_tree(const struct extent_io_tree *tree)
+{
+	return tree->owner == IO_TREE_INODE_IO;
+}
+
+/* Return the inode if it's valid for the given tree, otherwise NULL. */
+struct btrfs_inode *extent_io_tree_to_inode(struct extent_io_tree *tree)
+{
+	if (tree->owner == IO_TREE_INODE_IO)
+		return tree->inode;
+	return NULL;
+}
+
+/* Read-only access to the inode. */
+const struct btrfs_inode *extent_io_tree_to_inode_const(const struct extent_io_tree *tree)
+{
+	if (tree->owner == IO_TREE_INODE_IO)
+		return tree->inode;
+	return NULL;
+}
+
+/* For read-only access to fs_info. */
+const struct btrfs_fs_info *extent_io_tree_to_fs_info(const struct extent_io_tree *tree)
+{
+	if (tree->owner == IO_TREE_INODE_IO)
+		return tree->inode->root->fs_info;
+	return tree->fs_info;
+}
+
 void extent_io_tree_init(struct btrfs_fs_info *fs_info,
 			 struct extent_io_tree *tree, unsigned int owner)
 {
-	tree->fs_info = fs_info;
 	tree->state = RB_ROOT;
 	spin_lock_init(&tree->lock);
-	tree->inode = NULL;
+	tree->fs_info = fs_info;
 	tree->owner = owner;
 }
 
@@ -318,7 +350,7 @@ static void extent_io_tree_panic(const struct extent_io_tree *tree,
 				 const char *opname,
 				 int err)
 {
-	btrfs_panic(tree->fs_info, err,
+	btrfs_panic(extent_io_tree_to_fs_info(tree), err,
 		    "extent io tree error on %s state start %llu end %llu",
 		    opname, state->start, state->end);
 }
@@ -329,8 +361,9 @@ static void merge_prev_state(struct extent_io_tree *tree, struct extent_state *s
 
 	prev = prev_state(state);
 	if (prev && prev->end == state->start - 1 && prev->state == state->state) {
-		if (tree->inode)
-			btrfs_merge_delalloc_extent(tree->inode, state, prev);
+		if (is_inode_io_tree(tree))
+			btrfs_merge_delalloc_extent(extent_io_tree_to_inode(tree),
+						    state, prev);
 		state->start = prev->start;
 		rb_erase(&prev->rb_node, &tree->state);
 		RB_CLEAR_NODE(&prev->rb_node);
@@ -344,8 +377,9 @@ static void merge_next_state(struct extent_io_tree *tree, struct extent_state *s
 
 	next = next_state(state);
 	if (next && next->start == state->end + 1 && next->state == state->state) {
-		if (tree->inode)
-			btrfs_merge_delalloc_extent(tree->inode, state, next);
+		if (is_inode_io_tree(tree))
+			btrfs_merge_delalloc_extent(extent_io_tree_to_inode(tree),
+						    state, next);
 		state->end = next->end;
 		rb_erase(&next->rb_node, &tree->state);
 		RB_CLEAR_NODE(&next->rb_node);
@@ -378,8 +412,8 @@ static void set_state_bits(struct extent_io_tree *tree,
 	u32 bits_to_set = bits & ~EXTENT_CTLBITS;
 	int ret;
 
-	if (tree->inode)
-		btrfs_set_delalloc_extent(tree->inode, state, bits);
+	if (is_inode_io_tree(tree))
+		btrfs_set_delalloc_extent(extent_io_tree_to_inode(tree), state, bits);
 
 	ret = add_extent_changeset(state, bits_to_set, changeset, 1);
 	BUG_ON(ret < 0);
@@ -424,9 +458,10 @@ static struct extent_state *insert_state(struct extent_io_tree *tree,
 		if (state->end < entry->start) {
 			if (try_merge && end == entry->start &&
 			    state->state == entry->state) {
-				if (tree->inode)
-					btrfs_merge_delalloc_extent(tree->inode,
-								    state, entry);
+				if (is_inode_io_tree(tree))
+					btrfs_merge_delalloc_extent(
+							extent_io_tree_to_inode(tree),
+							state, entry);
 				entry->start = state->start;
 				merge_prev_state(tree, entry);
 				state->state = 0;
@@ -436,9 +471,10 @@ static struct extent_state *insert_state(struct extent_io_tree *tree,
 		} else if (state->end > entry->end) {
 			if (try_merge && entry->end == start &&
 			    state->state == entry->state) {
-				if (tree->inode)
-					btrfs_merge_delalloc_extent(tree->inode,
-								    state, entry);
+				if (is_inode_io_tree(tree))
+					btrfs_merge_delalloc_extent(
+							extent_io_tree_to_inode(tree),
+							state, entry);
 				entry->end = state->end;
 				merge_next_state(tree, entry);
 				state->state = 0;
@@ -490,8 +526,9 @@ static int split_state(struct extent_io_tree *tree, struct extent_state *orig,
 	struct rb_node *parent = NULL;
 	struct rb_node **node;
 
-	if (tree->inode)
-		btrfs_split_delalloc_extent(tree->inode, orig, split);
+	if (is_inode_io_tree(tree))
+		btrfs_split_delalloc_extent(extent_io_tree_to_inode(tree), orig,
+					    split);
 
 	prealloc->start = orig->start;
 	prealloc->end = split - 1;
@@ -538,8 +575,9 @@ static struct extent_state *clear_state_bit(struct extent_io_tree *tree,
 	u32 bits_to_clear = bits & ~EXTENT_CTLBITS;
 	int ret;
 
-	if (tree->inode)
-		btrfs_clear_delalloc_extent(tree->inode, state, bits);
+	if (is_inode_io_tree(tree))
+		btrfs_clear_delalloc_extent(extent_io_tree_to_inode(tree), state,
+					    bits);
 
 	ret = add_extent_changeset(state, bits_to_clear, changeset, 0);
 	BUG_ON(ret < 0);
diff --git a/fs/btrfs/extent-io-tree.h b/fs/btrfs/extent-io-tree.h
index 5602b0137fcd..ebe6390d65e9 100644
--- a/fs/btrfs/extent-io-tree.h
+++ b/fs/btrfs/extent-io-tree.h
@@ -87,9 +87,17 @@ enum {
 
 struct extent_io_tree {
 	struct rb_root state;
-	struct btrfs_fs_info *fs_info;
-	/* Inode associated with this tree, or NULL. */
-	struct btrfs_inode *inode;
+	/*
+	 * The fs_info is needed for trace points, a tree attached to an inode
+	 * needs the inode.
+	 *
+	 * owner == IO_TREE_INODE_IO - then inode is valid and fs_info can be
+	 *                             accessed as inode->root->fs_info
+	 */
+	union {
+		struct btrfs_fs_info *fs_info;
+		struct btrfs_inode *inode;
+	};
 
 	/* Who owns this io tree, should be one of IO_TREE_* */
 	u8 owner;
@@ -112,6 +120,10 @@ struct extent_state {
 #endif
 };
 
+struct btrfs_inode *extent_io_tree_to_inode(struct extent_io_tree *tree);
+const struct btrfs_inode *extent_io_tree_to_inode_const(const struct extent_io_tree *tree);
+const struct btrfs_fs_info *extent_io_tree_to_fs_info(const struct extent_io_tree *tree);
+
 void extent_io_tree_init(struct btrfs_fs_info *fs_info,
 			 struct extent_io_tree *tree, unsigned int owner);
 void extent_io_tree_release(struct extent_io_tree *tree);
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 9e7b44c2fbce..3c23ce73c7a8 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -8511,8 +8511,11 @@ struct inode *btrfs_alloc_inode(struct super_block *sb)
 
 	inode = &ei->vfs_inode;
 	extent_map_tree_init(&ei->extent_tree);
+
+	/* This io tree sets the valid inode. */
 	extent_io_tree_init(fs_info, &ei->io_tree, IO_TREE_INODE_IO);
 	ei->io_tree.inode = ei;
+
 	extent_io_tree_init(fs_info, &ei->file_extent_tree,
 			    IO_TREE_INODE_FILE_EXTENT);
 	/* Lockdep class is set only for the file extent tree. */
diff --git a/fs/btrfs/tests/btrfs-tests.c b/fs/btrfs/tests/btrfs-tests.c
index ca09cf9afce8..63afda5eac67 100644
--- a/fs/btrfs/tests/btrfs-tests.c
+++ b/fs/btrfs/tests/btrfs-tests.c
@@ -102,7 +102,7 @@ struct btrfs_device *btrfs_alloc_dummy_device(struct btrfs_fs_info *fs_info)
 	if (!dev)
 		return ERR_PTR(-ENOMEM);
 
-	extent_io_tree_init(NULL, &dev->alloc_state, 0);
+	extent_io_tree_init(fs_info, &dev->alloc_state, 0);
 	INIT_LIST_HEAD(&dev->dev_list);
 	list_add(&dev->dev_list, &fs_info->fs_devices->devices);
 
diff --git a/include/trace/events/btrfs.h b/include/trace/events/btrfs.h
index 279a7a0c90c0..558847e41efd 100644
--- a/include/trace/events/btrfs.h
+++ b/include/trace/events/btrfs.h
@@ -2099,17 +2099,12 @@ TRACE_EVENT(btrfs_set_extent_bit,
 		__field(	unsigned,	set_bits)
 	),
 
-	TP_fast_assign_btrfs(tree->fs_info,
-		__entry->owner = tree->owner;
-		if (tree->inode) {
-			const struct btrfs_inode *inode = tree->inode;
+	TP_fast_assign_btrfs(extent_io_tree_to_fs_info(tree),
+		const struct btrfs_inode *inode = extent_io_tree_to_inode_const(tree);
 
-			__entry->ino	= btrfs_ino(inode);
-			__entry->rootid	= inode->root->root_key.objectid;
-		} else {
-			__entry->ino	= 0;
-			__entry->rootid	= 0;
-		}
+		__entry->owner		= tree->owner;
+		__entry->ino		= inode ? btrfs_ino(inode) : 0;
+		__entry->rootid		= inode ? inode->root->root_key.objectid : 0;
 		__entry->start		= start;
 		__entry->len		= len;
 		__entry->set_bits	= set_bits;
@@ -2137,17 +2132,12 @@ TRACE_EVENT(btrfs_clear_extent_bit,
 		__field(	unsigned,	clear_bits)
 	),
 
-	TP_fast_assign_btrfs(tree->fs_info,
-		__entry->owner = tree->owner;
-		if (tree->inode) {
-			const struct btrfs_inode *inode = tree->inode;
+	TP_fast_assign_btrfs(extent_io_tree_to_fs_info(tree),
+		const struct btrfs_inode *inode = extent_io_tree_to_inode_const(tree);
 
-			__entry->ino	= btrfs_ino(inode);
-			__entry->rootid	= inode->root->root_key.objectid;
-		} else {
-			__entry->ino	= 0;
-			__entry->rootid	= 0;
-		}
+		__entry->owner		= tree->owner;
+		__entry->ino		= inode ? btrfs_ino(inode) : 0;
+		__entry->rootid		= inode ? inode->root->root_key.objectid : 0;
 		__entry->start		= start;
 		__entry->len		= len;
 		__entry->clear_bits	= clear_bits;
@@ -2176,17 +2166,12 @@ TRACE_EVENT(btrfs_convert_extent_bit,
 		__field(	unsigned,	clear_bits)
 	),
 
-	TP_fast_assign_btrfs(tree->fs_info,
-		__entry->owner = tree->owner;
-		if (tree->inode) {
-			const struct btrfs_inode *inode = tree->inode;
+	TP_fast_assign_btrfs(extent_io_tree_to_fs_info(tree),
+		const struct btrfs_inode *inode = extent_io_tree_to_inode_const(tree);
 
-			__entry->ino	= btrfs_ino(inode);
-			__entry->rootid	= inode->root->root_key.objectid;
-		} else {
-			__entry->ino	= 0;
-			__entry->rootid	= 0;
-		}
+		__entry->owner		= tree->owner;
+		__entry->ino		= inode ? btrfs_ino(inode) : 0;
+		__entry->rootid		= inode ? inode->root->root_key.objectid : 0;
 		__entry->start		= start;
 		__entry->len		= len;
 		__entry->set_bits	= set_bits;
-- 
2.42.1


