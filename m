Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88E5F207858
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jun 2020 18:04:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404531AbgFXQED (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 24 Jun 2020 12:04:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404724AbgFXQD0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 24 Jun 2020 12:03:26 -0400
Received: from mail.nic.cz (mail.nic.cz [IPv6:2001:1488:800:400::400])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90BDEC0613ED
        for <linux-btrfs@vger.kernel.org>; Wed, 24 Jun 2020 09:03:25 -0700 (PDT)
Received: from dellmb.labs.office.nic.cz (unknown [IPv6:2001:1488:fffe:6:cac7:3539:7f1f:463])
        by mail.nic.cz (Postfix) with ESMTP id 5EFA31409B8;
        Wed, 24 Jun 2020 18:03:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nic.cz; s=default;
        t=1593014602; bh=zP63jdbOwg3WCScIiVnovGQMWrolCDXvUujHjS4DaTc=;
        h=From:To:Date;
        b=fKDcZLRIhUTUD93rWYl5w3c3UfWFpNgSx1QfCs3cS4CT2AbMSMayb4uRHuJ1FUAav
         HL0MA4zAl//fsKMDJiJ6oNyfb67fLGi3ukfphLPA/h61xGj5nKhNzS3A2WGjICvo1g
         Ma24Dh25x36/597AQlEsWXLdLto9TzBKOVAibyWI=
From:   =?UTF-8?q?Marek=20Beh=C3=BAn?= <marek.behun@nic.cz>
To:     u-boot@lists.denx.de
Cc:     =?UTF-8?q?Alberto=20S=C3=A1nchez=20Molero?= <alsamolero@gmail.com>,
        Marek Vasut <marex@denx.de>,
        Pierre Bourdon <delroth@gmail.com>,
        Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
        Yevgeny Popovych <yevgenyp@pointgrab.com>,
        linux-btrfs@vger.kernel.org, Qu Wenruo <wqu@suse.com>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <marek.behun@nic.cz>
Subject: [PATCH U-BOOT v3 06/30] fs: btrfs: Crossport extent-io.[ch] from btrfs-progs
Date:   Wed, 24 Jun 2020 18:02:52 +0200
Message-Id: <20200624160316.5001-7-marek.behun@nic.cz>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200624160316.5001-1-marek.behun@nic.cz>
References: <20200624160316.5001-1-marek.behun@nic.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on mail.nic.cz
X-Spam-Status: No, score=0.00
X-Spamd-Bar: /
X-Virus-Scanned: clamav-milter 0.102.2 at mail
X-Virus-Status: Clean
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Qu Wenruo <wqu@suse.com>

This brings the extent_io_tree infrastructure, with which we can finally
bring in proper btrfs_fs_info structure to ctree.h.

With read/write_extent_buffer() implemented we also backport
read/write_eb_member() to ctree.h.

Signed-off-by: Qu Wenruo <wqu@suse.com>
Reviewed-by: Marek Behún <marek.behun@nic.cz>
---
 fs/btrfs/ctree.h     |  55 +++
 fs/btrfs/extent-io.c | 801 ++++++++++++++++++++++++++++++++++++++++++-
 fs/btrfs/extent-io.h | 164 +++++++++
 3 files changed, 1019 insertions(+), 1 deletion(-)
 create mode 100644 fs/btrfs/extent-io.h

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 02125e5e10..c7528d1ac3 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -11,8 +11,10 @@
 
 #include <common.h>
 #include <compiler.h>
+#include <linux/rbtree.h>
 #include "kernel-shared/btrfs_tree.h"
 #include "compat.h"
+#include "extent-io.h"
 
 #define BTRFS_MAX_MIRRORS 3
 
@@ -48,6 +50,18 @@
 #define BTRFS_FS_STATE_DEV_REPLACING	3
 #define BTRFS_FS_STATE_DUMMY_FS_INFO	4
 
+#define read_eb_member(eb, ptr, type, member, result) (			\
+	read_extent_buffer(eb, (char *)(result),			\
+			   ((unsigned long)(ptr)) +			\
+			    offsetof(type, member),			\
+			   sizeof(((type *)0)->member)))
+
+#define write_eb_member(eb, ptr, type, member, result) (		\
+	write_extent_buffer(eb, (char *)(result),			\
+			   ((unsigned long)(ptr)) +			\
+			    offsetof(type, member),			\
+			   sizeof(((type *)0)->member)))
+
 #define BTRFS_SETGET_STACK_FUNCS(name, type, member, bits)		\
 static inline u##bits btrfs_##name(const type *s)			\
 {									\
@@ -75,6 +89,47 @@ struct btrfs_root {
 	u64 root_dirid;
 };
 
+struct btrfs_mapping_tree {
+	struct cache_tree cache_tree;
+};
+
+struct btrfs_device;
+struct btrfs_fs_info {
+	u8 chunk_tree_uuid[BTRFS_UUID_SIZE];
+	u8 *new_chunk_tree_uuid;
+	struct btrfs_root *fs_root;
+	struct btrfs_root *tree_root;
+	struct btrfs_root *chunk_root;
+	struct btrfs_root *csum_root;
+
+	struct rb_root fs_root_tree;
+
+	struct extent_io_tree extent_cache;
+	struct extent_io_tree free_space_cache;
+	struct extent_io_tree pinned_extents;
+	struct extent_io_tree extent_ins;
+	struct extent_io_tree *excluded_extents;
+
+	struct rb_root block_group_cache_tree;
+	/* logical->physical extent mapping */
+	struct btrfs_mapping_tree mapping_tree;
+
+	u64 generation;
+	u64 last_trans_committed;
+
+	struct btrfs_super_block *super_copy;
+
+	u64 super_bytenr;
+
+	/* Only support one device yet */
+	struct btrfs_devvice *dev;
+
+	/* Cached block sizes */
+	u32 nodesize;
+	u32 sectorsize;
+	u32 stripesize;
+};
+
 int btrfs_comp_keys(struct btrfs_key *, struct btrfs_key *);
 int btrfs_comp_keys_type(struct btrfs_key *, struct btrfs_key *);
 int btrfs_bin_search(union btrfs_tree_node *, struct btrfs_key *, int *);
diff --git a/fs/btrfs/extent-io.c b/fs/btrfs/extent-io.c
index 2e4599cf64..eec89d152e 100644
--- a/fs/btrfs/extent-io.c
+++ b/fs/btrfs/extent-io.c
@@ -5,9 +5,14 @@
  * 2017 Marek Behun, CZ.NIC, marek.behun@nic.cz
  */
 
-#include "btrfs.h"
+#include <linux/kernel.h>
+#include <linux/bug.h>
 #include <malloc.h>
 #include <memalign.h>
+#include "btrfs.h"
+#include "ctree.h"
+#include "extent-io.h"
+#include "disk-io.h"
 
 u64 btrfs_read_extent_inline(struct btrfs_path *path,
 			     struct btrfs_file_extent_item *extent, u64 offset,
@@ -124,3 +129,797 @@ err:
 	free(cbuf);
 	return -1ULL;
 }
+
+void extent_io_tree_init(struct extent_io_tree *tree)
+{
+	cache_tree_init(&tree->state);
+	cache_tree_init(&tree->cache);
+	tree->cache_size = 0;
+}
+
+static struct extent_state *alloc_extent_state(void)
+{
+	struct extent_state *state;
+
+	state = malloc(sizeof(*state));
+	if (!state)
+		return NULL;
+	state->cache_node.objectid = 0;
+	state->refs = 1;
+	state->state = 0;
+	state->xprivate = 0;
+	return state;
+}
+
+static void btrfs_free_extent_state(struct extent_state *state)
+{
+	state->refs--;
+	BUG_ON(state->refs < 0);
+	if (state->refs == 0)
+		free(state);
+}
+
+static void free_extent_state_func(struct cache_extent *cache)
+{
+	struct extent_state *es;
+
+	es = container_of(cache, struct extent_state, cache_node);
+	btrfs_free_extent_state(es);
+}
+
+static void free_extent_buffer_final(struct extent_buffer *eb);
+void extent_io_tree_cleanup(struct extent_io_tree *tree)
+{
+	cache_tree_free_extents(&tree->state, free_extent_state_func);
+}
+
+static inline void update_extent_state(struct extent_state *state)
+{
+	state->cache_node.start = state->start;
+	state->cache_node.size = state->end + 1 - state->start;
+}
+
+/*
+ * Utility function to look for merge candidates inside a given range.
+ * Any extents with matching state are merged together into a single
+ * extent in the tree. Extents with EXTENT_IO in their state field are
+ * not merged
+ */
+static int merge_state(struct extent_io_tree *tree,
+		       struct extent_state *state)
+{
+	struct extent_state *other;
+	struct cache_extent *other_node;
+
+	if (state->state & EXTENT_IOBITS)
+		return 0;
+
+	other_node = prev_cache_extent(&state->cache_node);
+	if (other_node) {
+		other = container_of(other_node, struct extent_state,
+				     cache_node);
+		if (other->end == state->start - 1 &&
+		    other->state == state->state) {
+			state->start = other->start;
+			update_extent_state(state);
+			remove_cache_extent(&tree->state, &other->cache_node);
+			btrfs_free_extent_state(other);
+		}
+	}
+	other_node = next_cache_extent(&state->cache_node);
+	if (other_node) {
+		other = container_of(other_node, struct extent_state,
+				     cache_node);
+		if (other->start == state->end + 1 &&
+		    other->state == state->state) {
+			other->start = state->start;
+			update_extent_state(other);
+			remove_cache_extent(&tree->state, &state->cache_node);
+			btrfs_free_extent_state(state);
+		}
+	}
+	return 0;
+}
+
+/*
+ * insert an extent_state struct into the tree.  'bits' are set on the
+ * struct before it is inserted.
+ */
+static int insert_state(struct extent_io_tree *tree,
+			struct extent_state *state, u64 start, u64 end,
+			int bits)
+{
+	int ret;
+
+	BUG_ON(end < start);
+	state->state |= bits;
+	state->start = start;
+	state->end = end;
+	update_extent_state(state);
+	ret = insert_cache_extent(&tree->state, &state->cache_node);
+	BUG_ON(ret);
+	merge_state(tree, state);
+	return 0;
+}
+
+/*
+ * split a given extent state struct in two, inserting the preallocated
+ * struct 'prealloc' as the newly created second half.  'split' indicates an
+ * offset inside 'orig' where it should be split.
+ */
+static int split_state(struct extent_io_tree *tree, struct extent_state *orig,
+		       struct extent_state *prealloc, u64 split)
+{
+	int ret;
+	prealloc->start = orig->start;
+	prealloc->end = split - 1;
+	prealloc->state = orig->state;
+	update_extent_state(prealloc);
+	orig->start = split;
+	update_extent_state(orig);
+	ret = insert_cache_extent(&tree->state, &prealloc->cache_node);
+	BUG_ON(ret);
+	return 0;
+}
+
+/*
+ * clear some bits on a range in the tree.
+ */
+static int clear_state_bit(struct extent_io_tree *tree,
+			    struct extent_state *state, int bits)
+{
+	int ret = state->state & bits;
+
+	state->state &= ~bits;
+	if (state->state == 0) {
+		remove_cache_extent(&tree->state, &state->cache_node);
+		btrfs_free_extent_state(state);
+	} else {
+		merge_state(tree, state);
+	}
+	return ret;
+}
+
+/*
+ * extent_buffer_bitmap_set - set an area of a bitmap
+ * @eb: the extent buffer
+ * @start: offset of the bitmap item in the extent buffer
+ * @pos: bit number of the first bit
+ * @len: number of bits to set
+ */
+void extent_buffer_bitmap_set(struct extent_buffer *eb, unsigned long start,
+			      unsigned long pos, unsigned long len)
+{
+	u8 *p = (u8 *)eb->data + start + BIT_BYTE(pos);
+	const unsigned int size = pos + len;
+	int bits_to_set = BITS_PER_BYTE - (pos % BITS_PER_BYTE);
+	u8 mask_to_set = BITMAP_FIRST_BYTE_MASK(pos);
+
+	while (len >= bits_to_set) {
+		*p |= mask_to_set;
+		len -= bits_to_set;
+		bits_to_set = BITS_PER_BYTE;
+		mask_to_set = ~0;
+		p++;
+	}
+	if (len) {
+		mask_to_set &= BITMAP_LAST_BYTE_MASK(size);
+		*p |= mask_to_set;
+	}
+}
+
+/*
+ * extent_buffer_bitmap_clear - clear an area of a bitmap
+ * @eb: the extent buffer
+ * @start: offset of the bitmap item in the extent buffer
+ * @pos: bit number of the first bit
+ * @len: number of bits to clear
+ */
+void extent_buffer_bitmap_clear(struct extent_buffer *eb, unsigned long start,
+				unsigned long pos, unsigned long len)
+{
+	u8 *p = (u8 *)eb->data + start + BIT_BYTE(pos);
+	const unsigned int size = pos + len;
+	int bits_to_clear = BITS_PER_BYTE - (pos % BITS_PER_BYTE);
+	u8 mask_to_clear = BITMAP_FIRST_BYTE_MASK(pos);
+
+	while (len >= bits_to_clear) {
+		*p &= ~mask_to_clear;
+		len -= bits_to_clear;
+		bits_to_clear = BITS_PER_BYTE;
+		mask_to_clear = ~0;
+		p++;
+	}
+	if (len) {
+		mask_to_clear &= BITMAP_LAST_BYTE_MASK(size);
+		*p &= ~mask_to_clear;
+	}
+}
+
+/*
+ * clear some bits on a range in the tree.
+ */
+int clear_extent_bits(struct extent_io_tree *tree, u64 start, u64 end, int bits)
+{
+	struct extent_state *state;
+	struct extent_state *prealloc = NULL;
+	struct cache_extent *node;
+	u64 last_end;
+	int err;
+	int set = 0;
+
+again:
+	if (!prealloc) {
+		prealloc = alloc_extent_state();
+		if (!prealloc)
+			return -ENOMEM;
+	}
+
+	/*
+	 * this search will find the extents that end after
+	 * our range starts
+	 */
+	node = search_cache_extent(&tree->state, start);
+	if (!node)
+		goto out;
+	state = container_of(node, struct extent_state, cache_node);
+	if (state->start > end)
+		goto out;
+	last_end = state->end;
+
+	/*
+	 *     | ---- desired range ---- |
+	 *  | state | or
+	 *  | ------------- state -------------- |
+	 *
+	 * We need to split the extent we found, and may flip
+	 * bits on second half.
+	 *
+	 * If the extent we found extends past our range, we
+	 * just split and search again.  It'll get split again
+	 * the next time though.
+	 *
+	 * If the extent we found is inside our range, we clear
+	 * the desired bit on it.
+	 */
+	if (state->start < start) {
+		err = split_state(tree, state, prealloc, start);
+		BUG_ON(err == -EEXIST);
+		prealloc = NULL;
+		if (err)
+			goto out;
+		if (state->end <= end) {
+			set |= clear_state_bit(tree, state, bits);
+			if (last_end == (u64)-1)
+				goto out;
+			start = last_end + 1;
+		} else {
+			start = state->start;
+		}
+		goto search_again;
+	}
+	/*
+	 * | ---- desired range ---- |
+	 *                        | state |
+	 * We need to split the extent, and clear the bit
+	 * on the first half
+	 */
+	if (state->start <= end && state->end > end) {
+		err = split_state(tree, state, prealloc, end + 1);
+		BUG_ON(err == -EEXIST);
+
+		set |= clear_state_bit(tree, prealloc, bits);
+		prealloc = NULL;
+		goto out;
+	}
+
+	start = state->end + 1;
+	set |= clear_state_bit(tree, state, bits);
+	if (last_end == (u64)-1)
+		goto out;
+	start = last_end + 1;
+	goto search_again;
+out:
+	if (prealloc)
+		btrfs_free_extent_state(prealloc);
+	return set;
+
+search_again:
+	if (start > end)
+		goto out;
+	goto again;
+}
+
+/*
+ * set some bits on a range in the tree.
+ */
+int set_extent_bits(struct extent_io_tree *tree, u64 start, u64 end, int bits)
+{
+	struct extent_state *state;
+	struct extent_state *prealloc = NULL;
+	struct cache_extent *node;
+	int err = 0;
+	u64 last_start;
+	u64 last_end;
+again:
+	if (!prealloc) {
+		prealloc = alloc_extent_state();
+		if (!prealloc)
+			return -ENOMEM;
+	}
+
+	/*
+	 * this search will find the extents that end after
+	 * our range starts
+	 */
+	node = search_cache_extent(&tree->state, start);
+	if (!node) {
+		err = insert_state(tree, prealloc, start, end, bits);
+		BUG_ON(err == -EEXIST);
+		prealloc = NULL;
+		goto out;
+	}
+
+	state = container_of(node, struct extent_state, cache_node);
+	last_start = state->start;
+	last_end = state->end;
+
+	/*
+	 * | ---- desired range ---- |
+	 * | state |
+	 *
+	 * Just lock what we found and keep going
+	 */
+	if (state->start == start && state->end <= end) {
+		state->state |= bits;
+		merge_state(tree, state);
+		if (last_end == (u64)-1)
+			goto out;
+		start = last_end + 1;
+		goto search_again;
+	}
+	/*
+	 *     | ---- desired range ---- |
+	 * | state |
+	 *   or
+	 * | ------------- state -------------- |
+	 *
+	 * We need to split the extent we found, and may flip bits on
+	 * second half.
+	 *
+	 * If the extent we found extends past our
+	 * range, we just split and search again.  It'll get split
+	 * again the next time though.
+	 *
+	 * If the extent we found is inside our range, we set the
+	 * desired bit on it.
+	 */
+	if (state->start < start) {
+		err = split_state(tree, state, prealloc, start);
+		BUG_ON(err == -EEXIST);
+		prealloc = NULL;
+		if (err)
+			goto out;
+		if (state->end <= end) {
+			state->state |= bits;
+			start = state->end + 1;
+			merge_state(tree, state);
+			if (last_end == (u64)-1)
+				goto out;
+			start = last_end + 1;
+		} else {
+			start = state->start;
+		}
+		goto search_again;
+	}
+	/*
+	 * | ---- desired range ---- |
+	 *     | state | or               | state |
+	 *
+	 * There's a hole, we need to insert something in it and
+	 * ignore the extent we found.
+	 */
+	if (state->start > start) {
+		u64 this_end;
+		if (end < last_start)
+			this_end = end;
+		else
+			this_end = last_start -1;
+		err = insert_state(tree, prealloc, start, this_end,
+				bits);
+		BUG_ON(err == -EEXIST);
+		prealloc = NULL;
+		if (err)
+			goto out;
+		start = this_end + 1;
+		goto search_again;
+	}
+	/*
+	 * | ---- desired range ---- |
+	 * | ---------- state ---------- |
+	 * We need to split the extent, and set the bit
+	 * on the first half
+	 */
+	err = split_state(tree, state, prealloc, end + 1);
+	BUG_ON(err == -EEXIST);
+
+	state->state |= bits;
+	merge_state(tree, prealloc);
+	prealloc = NULL;
+out:
+	if (prealloc)
+		btrfs_free_extent_state(prealloc);
+	return err;
+search_again:
+	if (start > end)
+		goto out;
+	goto again;
+}
+
+int set_extent_dirty(struct extent_io_tree *tree, u64 start, u64 end)
+{
+	return set_extent_bits(tree, start, end, EXTENT_DIRTY);
+}
+
+int clear_extent_dirty(struct extent_io_tree *tree, u64 start, u64 end)
+{
+	return clear_extent_bits(tree, start, end, EXTENT_DIRTY);
+}
+
+int find_first_extent_bit(struct extent_io_tree *tree, u64 start,
+			  u64 *start_ret, u64 *end_ret, int bits)
+{
+	struct cache_extent *node;
+	struct extent_state *state;
+	int ret = 1;
+
+	/*
+	 * this search will find all the extents that end after
+	 * our range starts.
+	 */
+	node = search_cache_extent(&tree->state, start);
+	if (!node)
+		goto out;
+
+	while(1) {
+		state = container_of(node, struct extent_state, cache_node);
+		if (state->end >= start && (state->state & bits)) {
+			*start_ret = state->start;
+			*end_ret = state->end;
+			ret = 0;
+			break;
+		}
+		node = next_cache_extent(node);
+		if (!node)
+			break;
+	}
+out:
+	return ret;
+}
+
+int test_range_bit(struct extent_io_tree *tree, u64 start, u64 end,
+		   int bits, int filled)
+{
+	struct extent_state *state = NULL;
+	struct cache_extent *node;
+	int bitset = 0;
+
+	node = search_cache_extent(&tree->state, start);
+	while (node && start <= end) {
+		state = container_of(node, struct extent_state, cache_node);
+
+		if (filled && state->start > start) {
+			bitset = 0;
+			break;
+		}
+		if (state->start > end)
+			break;
+		if (state->state & bits) {
+			bitset = 1;
+			if (!filled)
+				break;
+		} else if (filled) {
+			bitset = 0;
+			break;
+		}
+		start = state->end + 1;
+		if (start > end)
+			break;
+		node = next_cache_extent(node);
+		if (!node) {
+			if (filled)
+				bitset = 0;
+			break;
+		}
+	}
+	return bitset;
+}
+
+int set_state_private(struct extent_io_tree *tree, u64 start, u64 private)
+{
+	struct cache_extent *node;
+	struct extent_state *state;
+	int ret = 0;
+
+	node = search_cache_extent(&tree->state, start);
+	if (!node) {
+		ret = -ENOENT;
+		goto out;
+	}
+	state = container_of(node, struct extent_state, cache_node);
+	if (state->start != start) {
+		ret = -ENOENT;
+		goto out;
+	}
+	state->xprivate = private;
+out:
+	return ret;
+}
+
+int get_state_private(struct extent_io_tree *tree, u64 start, u64 *private)
+{
+	struct cache_extent *node;
+	struct extent_state *state;
+	int ret = 0;
+
+	node = search_cache_extent(&tree->state, start);
+	if (!node) {
+		ret = -ENOENT;
+		goto out;
+	}
+	state = container_of(node, struct extent_state, cache_node);
+	if (state->start != start) {
+		ret = -ENOENT;
+		goto out;
+	}
+	*private = state->xprivate;
+out:
+	return ret;
+}
+
+static struct extent_buffer *__alloc_extent_buffer(struct btrfs_fs_info *info,
+						   u64 bytenr, u32 blocksize)
+{
+	struct extent_buffer *eb;
+
+	eb = calloc(1, sizeof(struct extent_buffer));
+	if (!eb)
+		return NULL;
+	eb->data = malloc_cache_aligned(blocksize);
+	if (!eb->data) {
+		free(eb);
+		return NULL;
+	}
+
+	eb->start = bytenr;
+	eb->len = blocksize;
+	eb->refs = 1;
+	eb->flags = 0;
+	eb->cache_node.start = bytenr;
+	eb->cache_node.size = blocksize;
+	eb->fs_info = info;
+	memset_extent_buffer(eb, 0, 0, blocksize);
+
+	return eb;
+}
+
+struct extent_buffer *btrfs_clone_extent_buffer(struct extent_buffer *src)
+{
+	struct extent_buffer *new;
+
+	new = __alloc_extent_buffer(src->fs_info, src->start, src->len);
+	if (!new)
+		return NULL;
+
+	copy_extent_buffer(new, src, 0, 0, src->len);
+	new->flags |= EXTENT_BUFFER_DUMMY;
+
+	return new;
+}
+
+static void free_extent_buffer_final(struct extent_buffer *eb)
+{
+	BUG_ON(eb->refs);
+	if (!(eb->flags & EXTENT_BUFFER_DUMMY)) {
+		struct extent_io_tree *tree = &eb->fs_info->extent_cache;
+
+		remove_cache_extent(&tree->cache, &eb->cache_node);
+		BUG_ON(tree->cache_size < eb->len);
+		tree->cache_size -= eb->len;
+	}
+	free(eb->data);
+	free(eb);
+}
+
+static void free_extent_buffer_internal(struct extent_buffer *eb, bool free_now)
+{
+	if (!eb || IS_ERR(eb))
+		return;
+
+	eb->refs--;
+	BUG_ON(eb->refs < 0);
+	if (eb->refs == 0) {
+		if (eb->flags & EXTENT_DIRTY) {
+			error(
+			"dirty eb leak (aborted trans): start %llu len %u",
+				eb->start, eb->len);
+		}
+		if (eb->flags & EXTENT_BUFFER_DUMMY || free_now)
+			free_extent_buffer_final(eb);
+	}
+}
+
+void free_extent_buffer(struct extent_buffer *eb)
+{
+	free_extent_buffer_internal(eb, 1);
+}
+
+struct extent_buffer *find_extent_buffer(struct extent_io_tree *tree,
+					 u64 bytenr, u32 blocksize)
+{
+	struct extent_buffer *eb = NULL;
+	struct cache_extent *cache;
+
+	cache = lookup_cache_extent(&tree->cache, bytenr, blocksize);
+	if (cache && cache->start == bytenr &&
+	    cache->size == blocksize) {
+		eb = container_of(cache, struct extent_buffer, cache_node);
+		eb->refs++;
+	}
+	return eb;
+}
+
+struct extent_buffer *find_first_extent_buffer(struct extent_io_tree *tree,
+					       u64 start)
+{
+	struct extent_buffer *eb = NULL;
+	struct cache_extent *cache;
+
+	cache = search_cache_extent(&tree->cache, start);
+	if (cache) {
+		eb = container_of(cache, struct extent_buffer, cache_node);
+		eb->refs++;
+	}
+	return eb;
+}
+
+struct extent_buffer *alloc_extent_buffer(struct btrfs_fs_info *fs_info,
+					  u64 bytenr, u32 blocksize)
+{
+	struct extent_buffer *eb;
+	struct extent_io_tree *tree = &fs_info->extent_cache;
+	struct cache_extent *cache;
+
+	cache = lookup_cache_extent(&tree->cache, bytenr, blocksize);
+	if (cache && cache->start == bytenr &&
+	    cache->size == blocksize) {
+		eb = container_of(cache, struct extent_buffer, cache_node);
+		eb->refs++;
+	} else {
+		int ret;
+
+		if (cache) {
+			eb = container_of(cache, struct extent_buffer,
+					  cache_node);
+			free_extent_buffer(eb);
+		}
+		eb = __alloc_extent_buffer(fs_info, bytenr, blocksize);
+		if (!eb)
+			return NULL;
+		ret = insert_cache_extent(&tree->cache, &eb->cache_node);
+		if (ret) {
+			free(eb);
+			return NULL;
+		}
+		tree->cache_size += blocksize;
+	}
+	return eb;
+}
+
+/*
+ * Allocate a dummy extent buffer which won't be inserted into extent buffer
+ * cache.
+ *
+ * This mostly allows super block read write using existing eb infrastructure
+ * without pulluting the eb cache.
+ *
+ * This is especially important to avoid injecting eb->start == SZ_64K, as
+ * fuzzed image could have invalid tree bytenr covers super block range,
+ * and cause ref count underflow.
+ */
+struct extent_buffer *alloc_dummy_extent_buffer(struct btrfs_fs_info *fs_info,
+						u64 bytenr, u32 blocksize)
+{
+	struct extent_buffer *ret;
+
+	ret = __alloc_extent_buffer(fs_info, bytenr, blocksize);
+	if (!ret)
+		return NULL;
+
+	ret->flags |= EXTENT_BUFFER_DUMMY;
+
+	return ret;
+}
+
+int read_extent_from_disk(struct blk_desc *desc, struct disk_partition *part,
+			  u64 physical, struct extent_buffer *eb,
+			  unsigned long offset, unsigned long len)
+{
+	int ret;
+
+	ret = __btrfs_devread(desc, part, eb->data + offset, len, physical);
+	if (ret < 0)
+		goto out;
+	if (ret != len) {
+		ret = -EIO;
+		goto out;
+	}
+	ret = 0;
+out:
+	return ret;
+}
+
+int memcmp_extent_buffer(const struct extent_buffer *eb, const void *ptrv,
+			 unsigned long start, unsigned long len)
+{
+	return memcmp(eb->data + start, ptrv, len);
+}
+
+void read_extent_buffer(const struct extent_buffer *eb, void *dst,
+			unsigned long start, unsigned long len)
+{
+	memcpy(dst, eb->data + start, len);
+}
+
+void write_extent_buffer(struct extent_buffer *eb, const void *src,
+			 unsigned long start, unsigned long len)
+{
+	memcpy(eb->data + start, src, len);
+}
+
+void copy_extent_buffer(struct extent_buffer *dst, struct extent_buffer *src,
+			unsigned long dst_offset, unsigned long src_offset,
+			unsigned long len)
+{
+	memcpy(dst->data + dst_offset, src->data + src_offset, len);
+}
+
+void memmove_extent_buffer(struct extent_buffer *dst, unsigned long dst_offset,
+			   unsigned long src_offset, unsigned long len)
+{
+	memmove(dst->data + dst_offset, dst->data + src_offset, len);
+}
+
+void memset_extent_buffer(struct extent_buffer *eb, char c,
+			  unsigned long start, unsigned long len)
+{
+	memset(eb->data + start, c, len);
+}
+
+int extent_buffer_test_bit(struct extent_buffer *eb, unsigned long start,
+			   unsigned long nr)
+{
+	return le_test_bit(nr, (u8 *)eb->data + start);
+}
+
+int set_extent_buffer_dirty(struct extent_buffer *eb)
+{
+	struct extent_io_tree *tree = &eb->fs_info->extent_cache;
+	if (!(eb->flags & EXTENT_DIRTY)) {
+		eb->flags |= EXTENT_DIRTY;
+		set_extent_dirty(tree, eb->start, eb->start + eb->len - 1);
+		extent_buffer_get(eb);
+	}
+	return 0;
+}
+
+int clear_extent_buffer_dirty(struct extent_buffer *eb)
+{
+	struct extent_io_tree *tree = &eb->fs_info->extent_cache;
+	if (eb->flags & EXTENT_DIRTY) {
+		eb->flags &= ~EXTENT_DIRTY;
+		clear_extent_dirty(tree, eb->start, eb->start + eb->len - 1);
+		free_extent_buffer(eb);
+	}
+	return 0;
+}
diff --git a/fs/btrfs/extent-io.h b/fs/btrfs/extent-io.h
new file mode 100644
index 0000000000..6b0c87da96
--- /dev/null
+++ b/fs/btrfs/extent-io.h
@@ -0,0 +1,164 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+/*
+ * Crossported from btrfs-progs/extent_io.h
+ *
+ * Modification includes:
+ * - extent_buffer:data
+ *   Use pointer to provide better alignment.
+ * - Remove max_cache_size related interfaces
+ *   Includes free_extent_buffer_nocache()
+ *   As we don't cache eb in U-boot.
+ * - Include headers
+ *
+ * Write related functions are kept as we still need to modify dummy extent
+ * buffers even in RO environment.
+ */
+#ifndef __BTRFS_EXTENT_IO_H__
+#define __BTRFS_EXTENT_IO_H__
+
+#include <linux/types.h>
+#include <linux/list.h>
+#include <linux/err.h>
+#include <linux/bitops.h>
+#include <fs_internal.h>
+#include "extent-cache.h"
+
+#define EXTENT_DIRTY		(1U << 0)
+#define EXTENT_WRITEBACK	(1U << 1)
+#define EXTENT_UPTODATE		(1U << 2)
+#define EXTENT_LOCKED		(1U << 3)
+#define EXTENT_NEW		(1U << 4)
+#define EXTENT_DELALLOC		(1U << 5)
+#define EXTENT_DEFRAG		(1U << 6)
+#define EXTENT_DEFRAG_DONE	(1U << 7)
+#define EXTENT_BUFFER_FILLED	(1U << 8)
+#define EXTENT_CSUM		(1U << 9)
+#define EXTENT_BAD_TRANSID	(1U << 10)
+#define EXTENT_BUFFER_DUMMY	(1U << 11)
+#define EXTENT_IOBITS (EXTENT_LOCKED | EXTENT_WRITEBACK)
+
+#define BLOCK_GROUP_DATA	(1U << 1)
+#define BLOCK_GROUP_METADATA	(1U << 2)
+#define BLOCK_GROUP_SYSTEM	(1U << 4)
+
+/*
+ * The extent buffer bitmap operations are done with byte granularity instead of
+ * word granularity for two reasons:
+ * 1. The bitmaps must be little-endian on disk.
+ * 2. Bitmap items are not guaranteed to be aligned to a word and therefore a
+ *    single word in a bitmap may straddle two pages in the extent buffer.
+ */
+#define BIT_BYTE(nr) ((nr) / BITS_PER_BYTE)
+#define BYTE_MASK ((1 << BITS_PER_BYTE) - 1)
+#define BITMAP_FIRST_BYTE_MASK(start) \
+	((BYTE_MASK << ((start) & (BITS_PER_BYTE - 1))) & BYTE_MASK)
+#define BITMAP_LAST_BYTE_MASK(nbits) \
+	(BYTE_MASK >> (-(nbits) & (BITS_PER_BYTE - 1)))
+
+static inline int le_test_bit(int nr, const u8 *addr)
+{
+	return 1U & (addr[BIT_BYTE(nr)] >> (nr & (BITS_PER_BYTE-1)));
+}
+
+struct btrfs_fs_info;
+
+struct extent_io_tree {
+	struct cache_tree state;
+	struct cache_tree cache;
+	u64 cache_size;
+};
+
+struct extent_state {
+	struct cache_extent cache_node;
+	u64 start;
+	u64 end;
+	int refs;
+	unsigned long state;
+	u64 xprivate;
+};
+
+struct extent_buffer {
+	struct cache_extent cache_node;
+	u64 start;
+	u32 len;
+	int refs;
+	u32 flags;
+	struct btrfs_fs_info *fs_info;
+	char *data;
+};
+
+static inline void extent_buffer_get(struct extent_buffer *eb)
+{
+	eb->refs++;
+}
+
+void extent_io_tree_init(struct extent_io_tree *tree);
+void extent_io_tree_cleanup(struct extent_io_tree *tree);
+int set_extent_bits(struct extent_io_tree *tree, u64 start, u64 end, int bits);
+int clear_extent_bits(struct extent_io_tree *tree, u64 start, u64 end, int bits);
+int find_first_extent_bit(struct extent_io_tree *tree, u64 start,
+			  u64 *start_ret, u64 *end_ret, int bits);
+int test_range_bit(struct extent_io_tree *tree, u64 start, u64 end,
+		   int bits, int filled);
+int set_extent_dirty(struct extent_io_tree *tree, u64 start, u64 end);
+int clear_extent_dirty(struct extent_io_tree *tree, u64 start, u64 end);
+static inline int set_extent_buffer_uptodate(struct extent_buffer *eb)
+{
+	eb->flags |= EXTENT_UPTODATE;
+	return 0;
+}
+
+static inline int clear_extent_buffer_uptodate(struct extent_buffer *eb)
+{
+	eb->flags &= ~EXTENT_UPTODATE;
+	return 0;
+}
+
+static inline int extent_buffer_uptodate(struct extent_buffer *eb)
+{
+	if (!eb || IS_ERR(eb))
+		return 0;
+	if (eb->flags & EXTENT_UPTODATE)
+		return 1;
+	return 0;
+}
+
+int set_state_private(struct extent_io_tree *tree, u64 start, u64 xprivate);
+int get_state_private(struct extent_io_tree *tree, u64 start, u64 *xprivate);
+struct extent_buffer *find_extent_buffer(struct extent_io_tree *tree,
+					 u64 bytenr, u32 blocksize);
+struct extent_buffer *find_first_extent_buffer(struct extent_io_tree *tree,
+					       u64 start);
+struct extent_buffer *alloc_extent_buffer(struct btrfs_fs_info *fs_info,
+					  u64 bytenr, u32 blocksize);
+struct extent_buffer *btrfs_clone_extent_buffer(struct extent_buffer *src);
+struct extent_buffer *alloc_dummy_extent_buffer(struct btrfs_fs_info *fs_info,
+						u64 bytenr, u32 blocksize);
+void free_extent_buffer(struct extent_buffer *eb);
+int read_extent_from_disk(struct blk_desc *desc, struct disk_partition *part,
+			  u64 physical, struct extent_buffer *eb,
+			  unsigned long offset, unsigned long len);
+int memcmp_extent_buffer(const struct extent_buffer *eb, const void *ptrv,
+			 unsigned long start, unsigned long len);
+void read_extent_buffer(const struct extent_buffer *eb, void *dst,
+			unsigned long start, unsigned long len);
+void write_extent_buffer(struct extent_buffer *eb, const void *src,
+			 unsigned long start, unsigned long len);
+void copy_extent_buffer(struct extent_buffer *dst, struct extent_buffer *src,
+			unsigned long dst_offset, unsigned long src_offset,
+			unsigned long len);
+void memmove_extent_buffer(struct extent_buffer *dst, unsigned long dst_offset,
+			   unsigned long src_offset, unsigned long len);
+void memset_extent_buffer(struct extent_buffer *eb, char c,
+			  unsigned long start, unsigned long len);
+int extent_buffer_test_bit(struct extent_buffer *eb, unsigned long start,
+			   unsigned long nr);
+int set_extent_buffer_dirty(struct extent_buffer *eb);
+int clear_extent_buffer_dirty(struct extent_buffer *eb);
+void extent_buffer_bitmap_clear(struct extent_buffer *eb, unsigned long start,
+				unsigned long pos, unsigned long len);
+void extent_buffer_bitmap_set(struct extent_buffer *eb, unsigned long start,
+			      unsigned long pos, unsigned long len);
+
+#endif
-- 
2.26.2

