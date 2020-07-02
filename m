Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76113211714
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Jul 2020 02:14:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727917AbgGBAOn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 1 Jul 2020 20:14:43 -0400
Received: from mx2.suse.de ([195.135.220.15]:35158 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727799AbgGBAOm (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 1 Jul 2020 20:14:42 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 37451AD65
        for <linux-btrfs@vger.kernel.org>; Thu,  2 Jul 2020 00:14:40 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 1/3] btrfs: Introduce extent_changeset_revert() for qgroup
Date:   Thu,  2 Jul 2020 08:14:32 +0800
Message-Id: <20200702001434.7745-2-wqu@suse.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200702001434.7745-1-wqu@suse.com>
References: <20200702001434.7745-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[PROBLEM]
Before this patch, when btrfs_qgroup_reserve_data() fails, we free all
reserved space of the changeset.

This means the following call is not possible:
	ret = btrfs_qgroup_reserve_data();
	if (ret == -EDQUOT) {
		/* Do something to free some qgroup space */
		ret = btrfs_qgroup_reserve_data();
	}

As if the first btrfs_qgroup_reserve_data() fails, it will free all
reserved qgroup space, so the next btrfs_qgroup_reserve_data() will
always success, and can go beyond qgroup limit.

[CAUSE]
This is mostly due to the fact that we don't have a good way to revert
changeset modification accurately.

Currently the changeset infrastructure is implemented using ulist, which
can only store two u64 values, used as start and length for each changed
extent range.

So we can't record which changed extent is modified in last
modification, thus unable to revert to previous status.

[FIX]
This patch will re-implement using pure rbtree, adding a new member,
changed_extent::seq, so we can remove changed extents which is
modified in previous modification.

This allows us to implement qgroup_revert(), which allow btrfs to revert
its modification to the io_tree.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent_io.c |  43 +++++++++++-
 fs/btrfs/extent_io.h |  24 ++++++-
 fs/btrfs/qgroup.c    | 155 +++++++++++++++++++++++++++++--------------
 3 files changed, 168 insertions(+), 54 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 8a7e9da74b87..21991d6716d9 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -142,6 +142,40 @@ struct extent_page_data {
 	unsigned int sync_io:1;
 };
 
+static int insert_changed_extent(struct extent_changeset *changeset,
+				 u64 start, u64 len)
+{
+	struct changed_extent *entry;
+	struct changed_extent *cur;
+	struct rb_node **p = &changeset->root.rb_node;
+	struct rb_node *parent = NULL;
+
+	entry = kzalloc(sizeof(*entry), GFP_ATOMIC);
+	if (!entry)
+		return -ENOMEM;
+
+	entry->start = start;
+	entry->len = len;
+	entry->seq = changeset->seq;
+
+	while (*p) {
+		parent = *p;
+		cur = rb_entry(parent, struct changed_extent, node);
+		if (cur->start < start) {
+			p = &(*p)->rb_right;
+		} else if (cur->start > start) {
+			p = &(*p)->rb_left;
+		} else {
+			kfree(entry);
+			return -EEXIST;
+		}
+	}
+	rb_link_node(&entry->node, parent, p);
+	rb_insert_color(&entry->node, &changeset->root);
+	changeset->bytes_changed += len;
+	return 0;
+}
+
 static int add_extent_changeset(struct extent_state *state, unsigned bits,
 				 struct extent_changeset *changeset,
 				 int set)
@@ -154,9 +188,8 @@ static int add_extent_changeset(struct extent_state *state, unsigned bits,
 		return 0;
 	if (!set && (state->state & bits) == 0)
 		return 0;
-	changeset->bytes_changed += state->end - state->start + 1;
-	ret = ulist_add(&changeset->range_changed, state->start, state->end,
-			GFP_ATOMIC);
+	ret = insert_changed_extent(changeset, state->start,
+				    state->end - state->start + 1);
 	return ret;
 }
 
@@ -718,6 +751,8 @@ int __clear_extent_bit(struct extent_io_tree *tree, u64 start, u64 end,
 
 	if (bits & (EXTENT_LOCKED | EXTENT_BOUNDARY))
 		clear = 1;
+	if (changeset)
+		changeset->seq++;
 again:
 	if (!prealloc && gfpflags_allow_blocking(mask)) {
 		/*
@@ -980,6 +1015,8 @@ __set_extent_bit(struct extent_io_tree *tree, u64 start, u64 end,
 	btrfs_debug_check_extent_io_range(tree, start, end);
 	trace_btrfs_set_extent_bit(tree, start, end - start + 1, bits);
 
+	if (changeset)
+		changeset->seq++;
 again:
 	if (!prealloc && gfpflags_allow_blocking(mask)) {
 		/*
diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
index 00a88f2eb5ab..ed00980e044b 100644
--- a/fs/btrfs/extent_io.h
+++ b/fs/btrfs/extent_io.h
@@ -131,18 +131,29 @@ struct extent_buffer {
 /*
  * Structure to record how many bytes and which ranges are set/cleared
  */
+struct changed_extent {
+	struct rb_node node;
+	u64 start;
+	u64 len;
+	u64 seq;	/* At which seqence number this extent is added */
+};
+
 struct extent_changeset {
+	/* Sequence number for current set/clear of this changeset */
+	u64 seq;
+
 	/* How many bytes are set/cleared in this operation */
 	unsigned int bytes_changed;
 
 	/* Changed ranges */
-	struct ulist range_changed;
+	struct rb_root root;
 };
 
 static inline void extent_changeset_init(struct extent_changeset *changeset)
 {
 	changeset->bytes_changed = 0;
-	ulist_init(&changeset->range_changed);
+	changeset->seq = 0;
+	changeset->root = RB_ROOT;
 }
 
 static inline struct extent_changeset *extent_changeset_alloc(void)
@@ -159,10 +170,17 @@ static inline struct extent_changeset *extent_changeset_alloc(void)
 
 static inline void extent_changeset_release(struct extent_changeset *changeset)
 {
+	struct changed_extent *entry;
+	struct changed_extent *next;
+
 	if (!changeset)
 		return;
 	changeset->bytes_changed = 0;
-	ulist_release(&changeset->range_changed);
+	changeset->seq = 0;
+	rbtree_postorder_for_each_entry_safe(entry, next, &changeset->root,
+					     node)
+		kfree(entry);
+	changeset->root = RB_ROOT;
 }
 
 static inline void extent_changeset_free(struct extent_changeset *changeset)
diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index ee0ad33b659c..5cfd2bcc55ef 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -3447,6 +3447,66 @@ btrfs_qgroup_rescan_resume(struct btrfs_fs_info *fs_info)
 	}
 }
 
+static void qgroup_revert(struct btrfs_inode *inode,
+			  struct extent_changeset *reserved, u64 start, u64 len)
+{
+	struct rb_node *n = reserved->root.rb_node;
+	struct changed_extent *entry = NULL;
+
+	while (n) {
+		entry = rb_entry(n, struct changed_extent, node);
+		if (entry->start < start)
+			n = n->rb_right;
+		if (entry->start > start)
+			n = n->rb_left;
+		else
+			break;
+	}
+	if (!entry)
+		goto out;
+
+	if (entry->start > start && rb_prev(&entry->node))
+		entry = rb_entry(rb_prev(&entry->node), struct changed_extent,
+				 node);
+
+	n = &entry->node;
+	while (n) {
+		struct rb_node *tmp = rb_next(n);
+
+		entry = rb_entry(n, struct changed_extent, node);
+
+		if (entry->start >= start + len)
+			break;
+		if (entry->start + entry->len <= start)
+			goto next;
+		if (entry->seq != reserved->seq)
+			goto next;
+		/*
+		 * Now the entry is in [start, start + len) and has the seq
+		 * matching reserved->seq, revert the EXTENT_QGROUP_RESERVED
+		 * bit.
+		 */
+		clear_extent_bits(&inode->io_tree,
+				entry->start, entry->start + entry->len - 1,
+				EXTENT_QGROUP_RESERVED);
+
+		rb_erase(&entry->node, &reserved->root);
+		RB_CLEAR_NODE(&entry->node);
+		if (likely(reserved->bytes_changed >= entry->len)) {
+			reserved->bytes_changed -= entry->len;
+		} else {
+			WARN_ON(1);
+			reserved->bytes_changed = 0;
+		}
+		kfree(entry);
+
+next:
+		n = tmp;
+	}
+out:
+	reserved->seq--;
+}
+
 /*
  * Reserve qgroup space for range [start, start + len).
  *
@@ -3466,11 +3526,10 @@ int btrfs_qgroup_reserve_data(struct btrfs_inode *inode,
 			u64 len)
 {
 	struct btrfs_root *root = inode->root;
-	struct ulist_node *unode;
-	struct ulist_iterator uiter;
 	struct extent_changeset *reserved;
 	u64 orig_reserved;
 	u64 to_reserve;
+	bool new_reserved = false;
 	int ret;
 
 	if (!test_bit(BTRFS_FS_QUOTA_ENABLED, &root->fs_info->flags) ||
@@ -3481,6 +3540,7 @@ int btrfs_qgroup_reserve_data(struct btrfs_inode *inode,
 	if (WARN_ON(!reserved_ret))
 		return -EINVAL;
 	if (!*reserved_ret) {
+		new_reserved = true;
 		*reserved_ret = extent_changeset_alloc();
 		if (!*reserved_ret)
 			return -ENOMEM;
@@ -3496,23 +3556,20 @@ int btrfs_qgroup_reserve_data(struct btrfs_inode *inode,
 	trace_btrfs_qgroup_reserve_data(&inode->vfs_inode, start, len,
 					to_reserve, QGROUP_RESERVE);
 	if (ret < 0)
-		goto cleanup;
+		goto out;
 	ret = qgroup_reserve(root, to_reserve, true, BTRFS_QGROUP_RSV_DATA);
 	if (ret < 0)
 		goto cleanup;
-
 	return ret;
 
 cleanup:
-	/* cleanup *ALL* already reserved ranges */
-	ULIST_ITER_INIT(&uiter);
-	while ((unode = ulist_next(&reserved->range_changed, &uiter)))
-		clear_extent_bit(&inode->io_tree, unode->val,
-				 unode->aux, EXTENT_QGROUP_RESERVED, 0, 0, NULL);
-	/* Also free data bytes of already reserved one */
-	btrfs_qgroup_free_refroot(root->fs_info, root->root_key.objectid,
-				  orig_reserved, BTRFS_QGROUP_RSV_DATA);
-	extent_changeset_release(reserved);
+	qgroup_revert(inode, reserved, start, len);
+out:
+	if (new_reserved) {
+		extent_changeset_release(reserved);
+		kfree(reserved);
+		*reserved_ret = NULL;
+	}
 	return ret;
 }
 
@@ -3521,8 +3578,7 @@ static int qgroup_free_reserved_data(struct btrfs_inode *inode,
 			struct extent_changeset *reserved, u64 start, u64 len)
 {
 	struct btrfs_root *root = inode->root;
-	struct ulist_node *unode;
-	struct ulist_iterator uiter;
+	struct rb_node *node;
 	struct extent_changeset changeset;
 	int freed = 0;
 	int ret;
@@ -3531,42 +3587,42 @@ static int qgroup_free_reserved_data(struct btrfs_inode *inode,
 	len = round_up(start + len, root->fs_info->sectorsize);
 	start = round_down(start, root->fs_info->sectorsize);
 
-	ULIST_ITER_INIT(&uiter);
-	while ((unode = ulist_next(&reserved->range_changed, &uiter))) {
-		u64 range_start = unode->val;
-		/* unode->aux is the inclusive end */
-		u64 range_len = unode->aux - range_start + 1;
-		u64 free_start;
-		u64 free_len;
+	node = rb_first(&reserved->root);
+	while (node) {
+		struct rb_node *tmp = rb_next(node);
+		struct changed_extent *entry;
+
+		entry = rb_entry(node, struct changed_extent, node);
 
 		extent_changeset_release(&changeset);
+		if (entry->start >= start + len)
+			break;
+		if (entry->start + entry->len <= start)
+			goto next;
+		ASSERT(entry->start >= start &&
+		       entry->start + len <= start + len);
 
-		/* Only free range in range [start, start + len) */
-		if (range_start >= start + len ||
-		    range_start + range_len <= start)
-			continue;
-		free_start = max(range_start, start);
-		free_len = min(start + len, range_start + range_len) -
-			   free_start;
-		/*
-		 * TODO: To also modify reserved->ranges_reserved to reflect
-		 * the modification.
-		 *
-		 * However as long as we free qgroup reserved according to
-		 * EXTENT_QGROUP_RESERVED, we won't double free.
-		 * So not need to rush.
-		 */
-		ret = clear_record_extent_bits(&inode->io_tree, free_start,
-				free_start + free_len - 1,
+		ret = clear_record_extent_bits(&inode->io_tree,
+				entry->start, entry->start + entry->len - 1,
 				EXTENT_QGROUP_RESERVED, &changeset);
-		if (ret < 0)
-			goto out;
 		freed += changeset.bytes_changed;
+		if (reserved->bytes_changed >= changeset.bytes_changed) {
+			reserved->bytes_changed -= changeset.bytes_changed;
+		} else {
+			WARN_ON(1);
+			reserved->bytes_changed = 0;
+		}
+
+		rb_erase(&entry->node, &reserved->root);
+		RB_CLEAR_NODE(&entry->node);
+		kfree(entry);
+next:
+		node = tmp;
 	}
+
 	btrfs_qgroup_free_refroot(root->fs_info, root->root_key.objectid, freed,
 				  BTRFS_QGROUP_RSV_DATA);
 	ret = freed;
-out:
 	extent_changeset_release(&changeset);
 	return ret;
 }
@@ -3813,8 +3869,6 @@ void btrfs_qgroup_convert_reserved_meta(struct btrfs_root *root, int num_bytes)
 void btrfs_qgroup_check_reserved_leak(struct btrfs_inode *inode)
 {
 	struct extent_changeset changeset;
-	struct ulist_node *unode;
-	struct ulist_iterator iter;
 	int ret;
 
 	extent_changeset_init(&changeset);
@@ -3823,12 +3877,17 @@ void btrfs_qgroup_check_reserved_leak(struct btrfs_inode *inode)
 
 	WARN_ON(ret < 0);
 	if (WARN_ON(changeset.bytes_changed)) {
-		ULIST_ITER_INIT(&iter);
-		while ((unode = ulist_next(&changeset.range_changed, &iter))) {
+		struct rb_node *n;
+
+		for (n = rb_first(&changeset.root); n; n = rb_next(n)) {
+			struct changed_extent *entry;
+
+			entry = rb_entry(n, struct changed_extent, node);
 			btrfs_warn(inode->root->fs_info,
-		"leaking qgroup reserved space, ino: %llu, start: %llu, end: %llu",
-				btrfs_ino(inode), unode->val, unode->aux);
+	"leaking qgroup reserved space, ino: %llu, start: %llu, len: %llu",
+				btrfs_ino(inode), entry->start, entry->len);
 		}
+
 		btrfs_qgroup_free_refroot(inode->root->fs_info,
 				inode->root->root_key.objectid,
 				changeset.bytes_changed, BTRFS_QGROUP_RSV_DATA);
-- 
2.27.0

