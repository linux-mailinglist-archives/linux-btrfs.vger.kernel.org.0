Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF0821E0709
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 May 2020 08:33:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388570AbgEYGdu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 25 May 2020 02:33:50 -0400
Received: from mx2.suse.de ([195.135.220.15]:33076 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388385AbgEYGdt (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 25 May 2020 02:33:49 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 2547EAF43;
        Mon, 25 May 2020 06:33:49 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org, u-boot@lists.denx.de
Cc:     marek.behun@nic.cz
Subject: [PATCH U-BOOT v2 13/30] fs: btrfs: Crossport btrfs_search_slot() from btrfs-progs
Date:   Mon, 25 May 2020 14:32:40 +0800
Message-Id: <20200525063257.46757-14-wqu@suse.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200525063257.46757-1-wqu@suse.com>
References: <20200525063257.46757-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This patch copies the core function, btrfs_search_slot() from
btrfs-progs.

This version has the following function removed:
- The ability to COW tree block
  Related code is commented, as we may still need this ability later.

- The readahead functionality
  That readahead is abused in kernel. Remove it completely.

With the core function in place, btrfs developers should feel at home now.

This also crossports supportive codes like btrfs_previous_item() to
ctree.[ch].

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/ctree.c | 536 ++++++++++++++++++++++++++++++++++++++++++++++-
 fs/btrfs/ctree.h |  61 +++++-
 2 files changed, 591 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index 2956fe2cea1e..ab3f32a30528 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -5,10 +5,12 @@
  * 2017 Marek Behun, CZ.NIC, marek.behun@nic.cz
  */
 
-#include "btrfs.h"
+#include <linux/kernel.h>
 #include <log.h>
 #include <malloc.h>
 #include <memalign.h>
+#include "btrfs.h"
+#include "disk-io.h"
 
 static const struct btrfs_csum {
 	u16 size;
@@ -42,6 +44,32 @@ u16 btrfs_csum_type_size(u16 csum_type)
 	return btrfs_csums[csum_type].size;
 }
 
+struct btrfs_path *btrfs_alloc_path(void)
+{
+	struct btrfs_path *path;
+	path = kzalloc(sizeof(struct btrfs_path), GFP_NOFS);
+	return path;
+}
+
+void btrfs_free_path(struct btrfs_path *p)
+{
+	if (!p)
+		return;
+	btrfs_release_path(p);
+	kfree(p);
+}
+
+void btrfs_release_path(struct btrfs_path *p)
+{
+	int i;
+	for (i = 0; i < BTRFS_MAX_LEVEL; i++) {
+		if (!p->nodes[i])
+			continue;
+		free_extent_buffer(p->nodes[i]);
+	}
+	memset(p, 0, sizeof(*p));
+}
+
 int __btrfs_comp_keys(struct btrfs_key *a, struct btrfs_key *b)
 {
 	if (a->objectid > b->objectid)
@@ -72,7 +100,17 @@ int btrfs_comp_keys_type(struct btrfs_key *a, struct btrfs_key *b)
 	return 0;
 }
 
-static int generic_bin_search(void *addr, int item_size, struct btrfs_key *key,
+/*
+ * search for key in the extent_buffer.  The items start at offset p,
+ * and they are item_size apart.  There are 'max' items in p.
+ *
+ * the slot in the array is returned via slot, and it points to
+ * the place where you would insert key if it is not found in
+ * the array.
+ *
+ * slot may point to max if the key is bigger than all of the keys
+ */
+static int __generic_bin_search(void *addr, int item_size, struct btrfs_key *key,
 			      int max, int *slot)
 {
 	int low = 0, high = max, mid, ret;
@@ -98,7 +136,7 @@ static int generic_bin_search(void *addr, int item_size, struct btrfs_key *key,
 	return 1;
 }
 
-int btrfs_bin_search(union btrfs_tree_node *p, struct btrfs_key *key,
+int __btrfs_bin_search(union btrfs_tree_node *p, struct btrfs_key *key,
 		     int *slot)
 {
 	void *addr;
@@ -112,7 +150,7 @@ int btrfs_bin_search(union btrfs_tree_node *p, struct btrfs_key *key,
 		size = sizeof(struct btrfs_item);
 	}
 
-	return generic_bin_search(addr, size, key, p->header.nritems, slot);
+	return __generic_bin_search(addr, size, key, p->header.nritems, slot);
 }
 
 static void clear_path(struct __btrfs_path *p)
@@ -209,7 +247,7 @@ int btrfs_search_tree(const struct __btrfs_root *root, struct btrfs_key *key,
 		}
 		prev_lvl = lvl;
 
-		ret = btrfs_bin_search(buf, key, &slot);
+		ret = __btrfs_bin_search(buf, key, &slot);
 		if (ret < 0)
 			goto err;
 		if (ret && slot > 0 && lvl)
@@ -464,6 +502,350 @@ fail:
 	return ret;
 }
 
+static int noinline check_block(struct btrfs_fs_info *fs_info,
+				struct btrfs_path *path, int level)
+{
+	struct btrfs_disk_key key;
+	struct btrfs_disk_key *key_ptr = NULL;
+	struct extent_buffer *parent;
+	enum btrfs_tree_block_status ret;
+
+	if (path->nodes[level + 1]) {
+		parent = path->nodes[level + 1];
+		btrfs_node_key(parent, &key, path->slots[level + 1]);
+		key_ptr = &key;
+	}
+	if (level == 0)
+		ret = btrfs_check_leaf(fs_info, key_ptr, path->nodes[0]);
+	else
+		ret = btrfs_check_node(fs_info, key_ptr, path->nodes[level]);
+	if (ret == BTRFS_TREE_BLOCK_CLEAN)
+		return 0;
+	return -EIO;
+}
+
+/*
+ * search for key in the extent_buffer.  The items start at offset p,
+ * and they are item_size apart.  There are 'max' items in p.
+ *
+ * the slot in the array is returned via slot, and it points to
+ * the place where you would insert key if it is not found in
+ * the array.
+ *
+ * slot may point to max if the key is bigger than all of the keys
+ */
+static int generic_bin_search(struct extent_buffer *eb, unsigned long p,
+			      int item_size, const struct btrfs_key *key,
+			      int max, int *slot)
+{
+	int low = 0;
+	int high = max;
+	int mid;
+	int ret;
+	unsigned long offset;
+	struct btrfs_disk_key *tmp;
+
+	while(low < high) {
+		mid = (low + high) / 2;
+		offset = p + mid * item_size;
+
+		tmp = (struct btrfs_disk_key *)(eb->data + offset);
+		ret = btrfs_comp_keys(tmp, key);
+
+		if (ret < 0)
+			low = mid + 1;
+		else if (ret > 0)
+			high = mid;
+		else {
+			*slot = mid;
+			return 0;
+		}
+	}
+	*slot = low;
+	return 1;
+}
+
+/*
+ * simple bin_search frontend that does the right thing for
+ * leaves vs nodes
+ */
+int btrfs_bin_search(struct extent_buffer *eb, const struct btrfs_key *key,
+		     int *slot)
+{
+	if (btrfs_header_level(eb) == 0)
+		return generic_bin_search(eb,
+					  offsetof(struct btrfs_leaf, items),
+					  sizeof(struct btrfs_item),
+					  key, btrfs_header_nritems(eb),
+					  slot);
+	else
+		return generic_bin_search(eb,
+					  offsetof(struct btrfs_node, ptrs),
+					  sizeof(struct btrfs_key_ptr),
+					  key, btrfs_header_nritems(eb),
+					  slot);
+}
+
+struct extent_buffer *read_node_slot(struct btrfs_fs_info *fs_info,
+				   struct extent_buffer *parent, int slot)
+{
+	struct extent_buffer *ret;
+	int level = btrfs_header_level(parent);
+
+	if (slot < 0)
+		return NULL;
+	if (slot >= btrfs_header_nritems(parent))
+		return NULL;
+
+	if (level == 0)
+		return NULL;
+
+	ret = read_tree_block(fs_info, btrfs_node_blockptr(parent, slot),
+		       btrfs_node_ptr_generation(parent, slot));
+	if (!extent_buffer_uptodate(ret))
+		return ERR_PTR(-EIO);
+
+	if (btrfs_header_level(ret) != level - 1) {
+		error(
+"child eb corrupted: parent bytenr=%llu item=%d parent level=%d child level=%d",
+		      btrfs_header_bytenr(parent), slot,
+		      btrfs_header_level(parent), btrfs_header_level(ret));
+		free_extent_buffer(ret);
+		return ERR_PTR(-EIO);
+	}
+	return ret;
+}
+
+int btrfs_find_item(struct btrfs_root *fs_root, struct btrfs_path *found_path,
+		u64 iobjectid, u64 ioff, u8 key_type,
+		struct btrfs_key *found_key)
+{
+	int ret;
+	struct btrfs_key key;
+	struct extent_buffer *eb;
+	struct btrfs_path *path;
+
+	key.type = key_type;
+	key.objectid = iobjectid;
+	key.offset = ioff;
+
+	if (found_path == NULL) {
+		path = btrfs_alloc_path();
+		if (!path)
+			return -ENOMEM;
+	} else
+		path = found_path;
+
+	ret = btrfs_search_slot(NULL, fs_root, &key, path, 0, 0);
+	if ((ret < 0) || (found_key == NULL))
+		goto out;
+
+	eb = path->nodes[0];
+	if (ret && path->slots[0] >= btrfs_header_nritems(eb)) {
+		ret = btrfs_next_leaf(fs_root, path);
+		if (ret)
+			goto out;
+		eb = path->nodes[0];
+	}
+
+	btrfs_item_key_to_cpu(eb, found_key, path->slots[0]);
+	if (found_key->type != key.type ||
+			found_key->objectid != key.objectid) {
+		ret = 1;
+		goto out;
+	}
+
+out:
+	if (path != found_path)
+		btrfs_free_path(path);
+	return ret;
+}
+
+/*
+ * look for key in the tree.  path is filled in with nodes along the way
+ * if key is found, we return zero and you can find the item in the leaf
+ * level of the path (level 0)
+ *
+ * If the key isn't found, the path points to the slot where it should
+ * be inserted, and 1 is returned.  If there are other errors during the
+ * search a negative error number is returned.
+ *
+ * if ins_len > 0, nodes and leaves will be split as we walk down the
+ * tree.  if ins_len < 0, nodes will be merged as we walk down the tree (if
+ * possible)
+ *
+ * NOTE: This version has no COW ability, thus we expect trans == NULL,
+ * ins_len == 0 and cow == 0.
+ */
+int btrfs_search_slot(struct btrfs_trans_handle *trans,
+		struct btrfs_root *root, const struct btrfs_key *key,
+		struct btrfs_path *p, int ins_len, int cow)
+{
+	struct extent_buffer *b;
+	int slot;
+	int ret;
+	int level;
+	struct btrfs_fs_info *fs_info = root->fs_info;
+	u8 lowest_level = 0;
+
+	assert(trans == NULL && ins_len == 0 && cow == 0);
+	lowest_level = p->lowest_level;
+	WARN_ON(lowest_level && ins_len > 0);
+	WARN_ON(p->nodes[0] != NULL);
+
+	b = root->node;
+	extent_buffer_get(b);
+	while (b) {
+		level = btrfs_header_level(b);
+		/*
+		if (cow) {
+			int wret;
+			wret = btrfs_cow_block(trans, root, b,
+					       p->nodes[level + 1],
+					       p->slots[level + 1],
+					       &b);
+			if (wret) {
+				free_extent_buffer(b);
+				return wret;
+			}
+		}
+		*/
+		BUG_ON(!cow && ins_len);
+		if (level != btrfs_header_level(b))
+			WARN_ON(1);
+		level = btrfs_header_level(b);
+		p->nodes[level] = b;
+		ret = check_block(fs_info, p, level);
+		if (ret)
+			return -1;
+		ret = btrfs_bin_search(b, key, &slot);
+		if (level != 0) {
+			if (ret && slot > 0)
+				slot -= 1;
+			p->slots[level] = slot;
+			/*
+			if ((p->search_for_split || ins_len > 0) &&
+			    btrfs_header_nritems(b) >=
+			    BTRFS_NODEPTRS_PER_BLOCK(fs_info) - 3) {
+				int sret = split_node(trans, root, p, level);
+				BUG_ON(sret > 0);
+				if (sret)
+					return sret;
+				b = p->nodes[level];
+				slot = p->slots[level];
+			} else if (ins_len < 0) {
+				int sret = balance_level(trans, root, p,
+							 level);
+				if (sret)
+					return sret;
+				b = p->nodes[level];
+				if (!b) {
+					btrfs_release_path(p);
+					goto again;
+				}
+				slot = p->slots[level];
+				BUG_ON(btrfs_header_nritems(b) == 1);
+			}
+			*/
+			/* this is only true while dropping a snapshot */
+			if (level == lowest_level)
+				break;
+
+			b = read_node_slot(fs_info, b, slot);
+			if (!extent_buffer_uptodate(b))
+				return -EIO;
+		} else {
+			p->slots[level] = slot;
+			/*
+			if (ins_len > 0 &&
+			    ins_len > btrfs_leaf_free_space(b)) {
+				int sret = split_leaf(trans, root, key,
+						      p, ins_len, ret == 0);
+				BUG_ON(sret > 0);
+				if (sret)
+					return sret;
+			}
+			*/
+			return ret;
+		}
+	}
+	return 1;
+}
+
+/*
+ * Helper to use instead of search slot if no exact match is needed but
+ * instead the next or previous item should be returned.
+ * When find_higher is true, the next higher item is returned, the next lower
+ * otherwise.
+ * When return_any and find_higher are both true, and no higher item is found,
+ * return the next lower instead.
+ * When return_any is true and find_higher is false, and no lower item is found,
+ * return the next higher instead.
+ * It returns 0 if any item is found, 1 if none is found (tree empty), and
+ * < 0 on error
+ */
+int btrfs_search_slot_for_read(struct btrfs_root *root,
+                               const struct btrfs_key *key,
+                               struct btrfs_path *p, int find_higher,
+                               int return_any)
+{
+        int ret;
+        struct extent_buffer *leaf;
+
+again:
+        ret = btrfs_search_slot(NULL, root, key, p, 0, 0);
+        if (ret <= 0)
+                return ret;
+        /*
+	 * A return value of 1 means the path is at the position where the item
+	 * should be inserted. Normally this is the next bigger item, but in
+	 * case the previous item is the last in a leaf, path points to the
+	 * first free slot in the previous leaf, i.e. at an invalid item.
+         */
+        leaf = p->nodes[0];
+
+        if (find_higher) {
+                if (p->slots[0] >= btrfs_header_nritems(leaf)) {
+                        ret = btrfs_next_leaf(root, p);
+                        if (ret <= 0)
+                                return ret;
+                        if (!return_any)
+                                return 1;
+                        /*
+			 * No higher item found, return the next lower instead
+                         */
+                        return_any = 0;
+                        find_higher = 0;
+                        btrfs_release_path(p);
+                        goto again;
+                }
+        } else {
+                if (p->slots[0] == 0) {
+                        ret = btrfs_prev_leaf(root, p);
+                        if (ret < 0)
+                                return ret;
+                        if (!ret) {
+                                leaf = p->nodes[0];
+                                if (p->slots[0] == btrfs_header_nritems(leaf))
+                                        p->slots[0]--;
+                                return 0;
+                        }
+                        if (!return_any)
+                                return 1;
+                        /*
+			 * No lower item found, return the next higher instead
+                         */
+                        return_any = 0;
+                        find_higher = 1;
+                        btrfs_release_path(p);
+                        goto again;
+                } else {
+                        --p->slots[0];
+                }
+        }
+        return 0;
+}
+
 /*
  * how many bytes are required to store the items in a leaf.  start
  * and nr indicate which items in the leaf to check.  This totals up the
@@ -505,3 +887,147 @@ int btrfs_leaf_free_space(struct extent_buffer *leaf)
 	}
 	return ret;
 }
+
+/*
+ * walk up the tree as far as required to find the previous leaf.
+ * returns 0 if it found something or 1 if there are no lesser leaves.
+ * returns < 0 on io errors.
+ */
+int btrfs_prev_leaf(struct btrfs_root *root, struct btrfs_path *path)
+{
+	int slot;
+	int level = 1;
+	struct extent_buffer *c;
+	struct extent_buffer *next = NULL;
+	struct btrfs_fs_info *fs_info = root->fs_info;
+
+	while(level < BTRFS_MAX_LEVEL) {
+		if (!path->nodes[level])
+			return 1;
+
+		slot = path->slots[level];
+		c = path->nodes[level];
+		if (slot == 0) {
+			level++;
+			if (level == BTRFS_MAX_LEVEL)
+				return 1;
+			continue;
+		}
+		slot--;
+
+		next = read_node_slot(fs_info, c, slot);
+		if (!extent_buffer_uptodate(next)) {
+			if (IS_ERR(next))
+				return PTR_ERR(next);
+			return -EIO;
+		}
+		break;
+	}
+	path->slots[level] = slot;
+	while(1) {
+		level--;
+		c = path->nodes[level];
+		free_extent_buffer(c);
+		slot = btrfs_header_nritems(next);
+		if (slot != 0)
+			slot--;
+		path->nodes[level] = next;
+		path->slots[level] = slot;
+		if (!level)
+			break;
+		next = read_node_slot(fs_info, next, slot);
+		if (!extent_buffer_uptodate(next)) {
+			if (IS_ERR(next))
+				return PTR_ERR(next);
+			return -EIO;
+		}
+	}
+	return 0;
+}
+
+/*
+ * Walk up the tree as far as necessary to find the next sibling tree block.
+ * More generic version of btrfs_next_leaf(), as it could find sibling nodes
+ * if @path->lowest_level is not 0.
+ *
+ * returns 0 if it found something or 1 if there are no greater leaves.
+ * returns < 0 on io errors.
+ */
+int btrfs_next_sibling_tree_block(struct btrfs_fs_info *fs_info,
+				  struct btrfs_path *path)
+{
+	int slot;
+	int level = path->lowest_level + 1;
+	struct extent_buffer *c;
+	struct extent_buffer *next = NULL;
+
+	BUG_ON(path->lowest_level + 1 >= BTRFS_MAX_LEVEL);
+	do {
+		if (!path->nodes[level])
+			return 1;
+
+		slot = path->slots[level] + 1;
+		c = path->nodes[level];
+		if (slot >= btrfs_header_nritems(c)) {
+			level++;
+			if (level == BTRFS_MAX_LEVEL)
+				return 1;
+			continue;
+		}
+
+		next = read_node_slot(fs_info, c, slot);
+		if (!extent_buffer_uptodate(next))
+			return -EIO;
+		break;
+	} while (level < BTRFS_MAX_LEVEL);
+	path->slots[level] = slot;
+	while(1) {
+		level--;
+		c = path->nodes[level];
+		free_extent_buffer(c);
+		path->nodes[level] = next;
+		path->slots[level] = 0;
+		if (level == path->lowest_level)
+			break;
+		next = read_node_slot(fs_info, next, 0);
+		if (!extent_buffer_uptodate(next))
+			return -EIO;
+	}
+	return 0;
+}
+
+int btrfs_previous_item(struct btrfs_root *root,
+			struct btrfs_path *path, u64 min_objectid,
+			int type)
+{
+	struct btrfs_key found_key;
+	struct extent_buffer *leaf;
+	u32 nritems;
+	int ret;
+
+	while(1) {
+		if (path->slots[0] == 0) {
+			ret = btrfs_prev_leaf(root, path);
+			if (ret != 0)
+				return ret;
+		} else {
+			path->slots[0]--;
+		}
+		leaf = path->nodes[0];
+		nritems = btrfs_header_nritems(leaf);
+		if (nritems == 0)
+			return 1;
+		if (path->slots[0] == nritems)
+			path->slots[0]--;
+
+		btrfs_item_key_to_cpu(leaf, &found_key, path->slots[0]);
+		if (found_key.objectid < min_objectid)
+			break;
+		if (found_key.type == type)
+			return 0;
+		if (found_key.objectid == min_objectid &&
+		    found_key.type < type)
+			break;
+	}
+	return 1;
+}
diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index ee42539a67c8..a5d22ac887e3 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -52,6 +52,15 @@ static inline unsigned long btrfs_chunk_item_size(int num_stripes)
 #define __BTRFS_LEAF_DATA_SIZE(bs) ((bs) - sizeof(struct btrfs_header))
 #define BTRFS_LEAF_DATA_SIZE(fs_info) \
 				(__BTRFS_LEAF_DATA_SIZE(fs_info->nodesize))
+
+struct btrfs_path {
+	struct extent_buffer *nodes[BTRFS_MAX_LEVEL];
+	int slots[BTRFS_MAX_LEVEL];
+
+	/* keep some upper locks as we walk down */
+	u8 lowest_level;
+};
+
 /* ioprio of readahead is set to idle */
 #define BTRFS_IOPRIO_READA (IOPRIO_PRIO_VALUE(IOPRIO_CLASS_IDLE, 0))
 
@@ -86,6 +95,7 @@ struct btrfs_root {
 	struct rb_node rb_node;
 };
 
+struct btrfs_trans_handle;
 struct btrfs_device;
 struct btrfs_fs_devices;
 struct btrfs_fs_info {
@@ -1207,7 +1217,7 @@ struct __btrfs_root {
 
 int __btrfs_comp_keys(struct btrfs_key *, struct btrfs_key *);
 int btrfs_comp_keys_type(struct btrfs_key *, struct btrfs_key *);
-int btrfs_bin_search(union btrfs_tree_node *, struct btrfs_key *, int *);
+int __btrfs_bin_search(union btrfs_tree_node *, struct btrfs_key *, int *);
 void __btrfs_free_path(struct __btrfs_path *);
 int btrfs_search_tree(const struct __btrfs_root *, struct btrfs_key *,
 		      struct __btrfs_path *);
@@ -1273,5 +1283,54 @@ btrfs_check_node(struct btrfs_fs_info *fs_info,
 enum btrfs_tree_block_status
 btrfs_check_leaf(struct btrfs_fs_info *fs_info,
 		 struct btrfs_disk_key *parent_key, struct extent_buffer *buf);
+struct extent_buffer *read_node_slot(struct btrfs_fs_info *fs_info,
+				   struct extent_buffer *parent, int slot);
+int btrfs_previous_item(struct btrfs_root *root,
+			struct btrfs_path *path, u64 min_objectid,
+			int type);
+int btrfs_next_sibling_tree_block(struct btrfs_fs_info *fs_info,
+				  struct btrfs_path *path);
+/*
+ * Walk up the tree as far as necessary to find the next leaf.
+ *
+ * returns 0 if it found something or 1 if there are no greater leaves.
+ * returns < 0 on io errors.
+ */
+static inline int btrfs_next_leaf(struct btrfs_root *root,
+				  struct btrfs_path *path)
+{
+	path->lowest_level = 0;
+	return btrfs_next_sibling_tree_block(root->fs_info, path);
+}
+
+static inline int btrfs_next_item(struct btrfs_root *root,
+				  struct btrfs_path *p)
+{
+	++p->slots[0];
+	if (p->slots[0] >= btrfs_header_nritems(p->nodes[0]))
+		return btrfs_next_leaf(root, p);
+	return 0;
+}
+
+int btrfs_prev_leaf(struct btrfs_root *root, struct btrfs_path *path);
 int btrfs_leaf_free_space(struct extent_buffer *leaf);
+int btrfs_search_slot(struct btrfs_trans_handle *trans,
+		struct btrfs_root *root, const struct btrfs_key *key,
+		struct btrfs_path *p, int ins_len, int cow);
+int btrfs_search_slot_for_read(struct btrfs_root *root,
+                               const struct btrfs_key *key,
+                               struct btrfs_path *p, int find_higher,
+                               int return_any);
+void btrfs_release_path(struct btrfs_path *p);
+struct btrfs_path *btrfs_alloc_path(void);
+void btrfs_free_path(struct btrfs_path *p);
+static inline void btrfs_init_path(struct btrfs_path *p)
+{
+	memset(p, 0, sizeof(*p));
+}
+int btrfs_bin_search(struct extent_buffer *eb, const struct btrfs_key *key,
+		     int *slot);
+int btrfs_find_item(struct btrfs_root *fs_root, struct btrfs_path *found_path,
+		u64 iobjectid, u64 ioff, u8 key_type,
+		struct btrfs_key *found_key);
 #endif /* __BTRFS_CTREE_H__ */
-- 
2.26.2

