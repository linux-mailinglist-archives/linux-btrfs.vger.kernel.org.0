Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B1D3207842
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jun 2020 18:03:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404807AbgFXQDi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 24 Jun 2020 12:03:38 -0400
Received: from lists.nic.cz ([217.31.204.67]:48212 "EHLO mail.nic.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404781AbgFXQDd (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 24 Jun 2020 12:03:33 -0400
Received: from dellmb.labs.office.nic.cz (unknown [IPv6:2001:1488:fffe:6:cac7:3539:7f1f:463])
        by mail.nic.cz (Postfix) with ESMTP id 4C9F81409BE;
        Wed, 24 Jun 2020 18:03:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nic.cz; s=default;
        t=1593014606; bh=Cec40/S6GyDxClD9U1l/GMXTQLOdKl8jQy4gp9Km2QU=;
        h=From:To:Date;
        b=s08oeEf97kLoW5N7IXufCUW6sxctL35SwUF6r0kRmGE+6LX6A/EdBtXEMPihaj0b0
         on/6CwT96DLbVi5/cQlpuJo+iiwJxbviwIb2dioff/QafKL7DxoZ3c+PrZTf5g7k7y
         ZypQnci4G07+vAYSpMUap4koNTrcRDoSKdfd5K28=
From:   =?UTF-8?q?Marek=20Beh=C3=BAn?= <marek.behun@nic.cz>
To:     u-boot@lists.denx.de
Cc:     =?UTF-8?q?Alberto=20S=C3=A1nchez=20Molero?= <alsamolero@gmail.com>,
        Marek Vasut <marex@denx.de>,
        Pierre Bourdon <delroth@gmail.com>,
        Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
        Yevgeny Popovych <yevgenyp@pointgrab.com>,
        linux-btrfs@vger.kernel.org, Qu Wenruo <wqu@suse.com>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <marek.behun@nic.cz>
Subject: [PATCH U-BOOT v3 29/30] fs: btrfs: Cleanup the old implementation
Date:   Wed, 24 Jun 2020 18:03:15 +0200
Message-Id: <20200624160316.5001-30-marek.behun@nic.cz>
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

This cleans up the now unneeded code from the old btrfs implementation.

Signed-off-by: Qu Wenruo <wqu@suse.com>
Reviewed-by: Marek Behún <marek.behun@nic.cz>
---
 fs/btrfs/Makefile      |   4 +-
 fs/btrfs/btrfs.c       |  31 ----
 fs/btrfs/btrfs.h       |  47 ------
 fs/btrfs/chunk-map.c   | 178 -----------------------
 fs/btrfs/compression.c |   2 +-
 fs/btrfs/ctree.c       | 290 ------------------------------------
 fs/btrfs/ctree.h       |  63 --------
 fs/btrfs/dir-item.c    |  79 ----------
 fs/btrfs/disk-io.c     |  30 ----
 fs/btrfs/disk-io.h     |   3 -
 fs/btrfs/extent-io.c   | 116 ---------------
 fs/btrfs/inode.c       | 323 -----------------------------------------
 fs/btrfs/root.c        |  92 ------------
 fs/btrfs/subvolume.c   | 111 --------------
 14 files changed, 3 insertions(+), 1366 deletions(-)
 delete mode 100644 fs/btrfs/chunk-map.c
 delete mode 100644 fs/btrfs/root.c

diff --git a/fs/btrfs/Makefile b/fs/btrfs/Makefile
index 8d76422ce2..fc074c84d2 100644
--- a/fs/btrfs/Makefile
+++ b/fs/btrfs/Makefile
@@ -2,6 +2,6 @@
 #
 # 2017 Marek Behun, CZ.NIC, marek.behun@nic.cz
 
-obj-y := btrfs.o chunk-map.o compression.o ctree.o dev.o dir-item.o \
-	extent-io.o inode.o root.o subvolume.o crypto/hash.o disk-io.o \
+obj-y := btrfs.o compression.o ctree.o dev.o dir-item.o \
+	extent-io.o inode.o subvolume.o crypto/hash.o disk-io.o \
 	common/rbtree-utils.o extent-cache.o volumes.o root-tree.o
diff --git a/fs/btrfs/btrfs.c b/fs/btrfs/btrfs.c
index ffd96427cc..786bb4733f 100644
--- a/fs/btrfs/btrfs.c
+++ b/fs/btrfs/btrfs.c
@@ -13,7 +13,6 @@
 #include "crypto/hash.h"
 #include "disk-io.h"
 
-struct btrfs_info btrfs_info;
 struct btrfs_fs_info *current_fs_info;
 
 static int show_dir(struct btrfs_root *root, struct extent_buffer *eb,
@@ -120,36 +119,7 @@ int btrfs_probe(struct blk_desc *fs_dev_desc,
 	struct btrfs_fs_info *fs_info;
 	int ret = -1;
 
-	btrfs_blk_desc = fs_dev_desc;
-	btrfs_part_info = fs_partition;
-
-	memset(&btrfs_info, 0, sizeof(btrfs_info));
-
 	btrfs_hash_init();
-	if (btrfs_read_superblock())
-		return -1;
-
-	if (btrfs_chunk_map_init()) {
-		printf("%s: failed to init chunk map\n", __func__);
-		return -1;
-	}
-
-	btrfs_info.tree_root.objectid = 0;
-	btrfs_info.tree_root.bytenr = btrfs_info.sb.root;
-	btrfs_info.chunk_root.objectid = 0;
-	btrfs_info.chunk_root.bytenr = btrfs_info.sb.chunk_root;
-
-	if (__btrfs_read_chunk_tree()) {
-		printf("%s: failed to read chunk tree\n", __func__);
-		return -1;
-	}
-
-	if (btrfs_find_root(btrfs_get_default_subvol_objectid(),
-			    &btrfs_info.fs_root, NULL)) {
-		printf("%s: failed to find default subvolume\n", __func__);
-		return -1;
-	}
-
 	fs_info = open_ctree_fs_info(fs_dev_desc, fs_partition);
 	if (fs_info) {
 		current_fs_info = fs_info;
@@ -297,7 +267,6 @@ int btrfs_read(const char *file, void *buf, loff_t offset, loff_t len,
 
 void btrfs_close(void)
 {
-	btrfs_chunk_map_exit();
 	if (current_fs_info) {
 		close_ctree_fs_info(current_fs_info);
 		current_fs_info = NULL;
diff --git a/fs/btrfs/btrfs.h b/fs/btrfs/btrfs.h
index 268ca077d9..7d8b395b26 100644
--- a/fs/btrfs/btrfs.h
+++ b/fs/btrfs/btrfs.h
@@ -11,65 +11,18 @@
 #include <linux/rbtree.h>
 #include "conv-funcs.h"
 
-struct btrfs_info {
-	struct btrfs_super_block sb;
-
-	struct __btrfs_root tree_root;
-	struct __btrfs_root fs_root;
-	struct __btrfs_root chunk_root;
-
-	struct rb_root chunks_root;
-};
-
 extern struct btrfs_info btrfs_info;
 extern struct btrfs_fs_info *current_fs_info;
 
-/* dev.c */
-extern struct blk_desc *btrfs_blk_desc;
-extern struct disk_partition *btrfs_part_info;
-
-int btrfs_devread(u64, int, void *);
-
-/* chunk-map.c */
-u64 btrfs_map_logical_to_physical(u64);
-int btrfs_chunk_map_init(void);
-void btrfs_chunk_map_exit(void);
-int __btrfs_read_chunk_tree(void);
-
 /* compression.c */
 u32 btrfs_decompress(u8 type, const char *, u32, char *, u32);
 
-/* super.c */
-int btrfs_read_superblock(void);
-
-/* dir-item.c */
-int __btrfs_lookup_dir_item(const struct __btrfs_root *, u64, const char *, int,
-			   struct btrfs_dir_item *);
-/* root.c */
-int btrfs_find_root(u64, struct __btrfs_root *, struct btrfs_root_item *);
-u64 btrfs_lookup_root_ref(u64, struct btrfs_root_ref *, char *);
-
 /* inode.c */
-u64 __btrfs_lookup_inode_ref(struct __btrfs_root *, u64, struct btrfs_inode_ref *,
-			    char *);
-int __btrfs_lookup_inode(const struct __btrfs_root *, struct btrfs_key *,
-		        struct btrfs_inode_item *, struct __btrfs_root *);
-int __btrfs_readlink(const struct __btrfs_root *, u64, char *);
 int btrfs_readlink(struct btrfs_root *root, u64 ino, char *target);
-u64 __btrfs_lookup_path(struct __btrfs_root *, u64, const char *, u8 *,
-		       struct btrfs_inode_item *, int);
-u64 __btrfs_file_read(const struct __btrfs_root *, u64, u64, u64, char *);
 int btrfs_file_read(struct btrfs_root *root, u64 ino, u64 file_offset, u64 len,
 		    char *dest);
 
 /* subvolume.c */
 u64 btrfs_get_default_subvol_objectid(void);
 
-/* extent-io.c */
-u64 __btrfs_read_extent_inline(struct __btrfs_path *,
-			      struct btrfs_file_extent_item *, u64, u64,
-			      char *);
-u64 __btrfs_read_extent_reg(struct __btrfs_path *, struct btrfs_file_extent_item *,
-			   u64, u64, char *);
-
 #endif /* !__BTRFS_BTRFS_H__ */
diff --git a/fs/btrfs/chunk-map.c b/fs/btrfs/chunk-map.c
deleted file mode 100644
index bff83e4dc8..0000000000
--- a/fs/btrfs/chunk-map.c
+++ /dev/null
@@ -1,178 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * BTRFS filesystem implementation for U-Boot
- *
- * 2017 Marek Behun, CZ.NIC, marek.behun@nic.cz
- */
-
-#include "btrfs.h"
-#include <log.h>
-#include <malloc.h>
-
-struct chunk_map_item {
-	struct rb_node node;
-	u64 logical;
-	u64 length;
-	u64 physical;
-};
-
-static int add_chunk_mapping(struct btrfs_key *key, struct btrfs_chunk *chunk)
-{
-	struct btrfs_stripe *stripe;
-	u64 block_profile = chunk->type & BTRFS_BLOCK_GROUP_PROFILE_MASK;
-	struct rb_node **new = &(btrfs_info.chunks_root.rb_node), *prnt = NULL;
-	struct chunk_map_item *map_item;
-
-	if (block_profile && block_profile != BTRFS_BLOCK_GROUP_DUP) {
-		printf("%s: unsupported chunk profile %llu\n", __func__,
-		       block_profile);
-		return -1;
-	} else if (!chunk->length) {
-		printf("%s: zero length chunk\n", __func__);
-		return -1;
-	}
-
-	stripe = &chunk->stripe;
-	btrfs_stripe_to_cpu(stripe);
-
-	while (*new) {
-		struct chunk_map_item *this;
-
-		this = rb_entry(*new, struct chunk_map_item, node);
-
-		prnt = *new;
-		if (key->offset < this->logical) {
-			new = &((*new)->rb_left);
-		} else if (key->offset > this->logical) {
-			new = &((*new)->rb_right);
-		} else {
-			debug("%s: Logical address %llu already in map!\n",
-			      __func__, key->offset);
-			return 0;
-		}
-	}
-
-	map_item = malloc(sizeof(struct chunk_map_item));
-	if (!map_item)
-		return -1;
-
-	map_item->logical = key->offset;
-	map_item->length = chunk->length;
-	map_item->physical = le64_to_cpu(chunk->stripe.offset);
-	rb_link_node(&map_item->node, prnt, new);
-	rb_insert_color(&map_item->node, &btrfs_info.chunks_root);
-
-	debug("%s: Mapping %llu to %llu\n", __func__, map_item->logical,
-	      map_item->physical);
-
-	return 0;
-}
-
-u64 btrfs_map_logical_to_physical(u64 logical)
-{
-	struct rb_node *node = btrfs_info.chunks_root.rb_node;
-
-	while (node) {
-		struct chunk_map_item *item;
-
-		item = rb_entry(node, struct chunk_map_item, node);
-
-		if (item->logical > logical)
-			node = node->rb_left;
-		else if (logical >= item->logical + item->length)
-			node = node->rb_right;
-		else
-			return item->physical + logical - item->logical;
-	}
-
-	printf("%s: Cannot map logical address %llu to physical\n", __func__,
-	       logical);
-
-	return -1ULL;
-}
-
-void btrfs_chunk_map_exit(void)
-{
-	struct rb_node *now, *next;
-	struct chunk_map_item *item;
-
-	for (now = rb_first_postorder(&btrfs_info.chunks_root); now; now = next)
-	{
-		item = rb_entry(now, struct chunk_map_item, node);
-		next = rb_next_postorder(now);
-		free(item);
-	}
-}
-
-int btrfs_chunk_map_init(void)
-{
-	u8 sys_chunk_array_copy[sizeof(btrfs_info.sb.sys_chunk_array)];
-	u8 * const start = sys_chunk_array_copy;
-	u8 * const end = start + btrfs_info.sb.sys_chunk_array_size;
-	u8 *cur;
-	struct btrfs_key *key;
-	struct btrfs_chunk *chunk;
-
-	btrfs_info.chunks_root = RB_ROOT;
-
-	memcpy(sys_chunk_array_copy, btrfs_info.sb.sys_chunk_array,
-	       sizeof(sys_chunk_array_copy));
-
-	for (cur = start; cur < end;) {
-		key = (struct btrfs_key *) cur;
-		cur += sizeof(struct btrfs_key);
-		chunk = (struct btrfs_chunk *) cur;
-
-		btrfs_key_to_cpu(key);
-		btrfs_chunk_to_cpu(chunk);
-
-		if (key->type != BTRFS_CHUNK_ITEM_KEY) {
-			printf("%s: invalid key type %u\n", __func__,
-			       key->type);
-			return -1;
-		}
-
-		if (add_chunk_mapping(key, chunk))
-			return -1;
-
-		cur += sizeof(struct btrfs_chunk);
-		cur += sizeof(struct btrfs_stripe) * (chunk->num_stripes - 1);
-	}
-
-	return 0;
-}
-
-int __btrfs_read_chunk_tree(void)
-{
-	struct __btrfs_path path;
-	struct btrfs_key key, *found_key;
-	struct btrfs_chunk *chunk;
-	int res = 0;
-
-	key.objectid = BTRFS_FIRST_CHUNK_TREE_OBJECTID;
-	key.type = BTRFS_CHUNK_ITEM_KEY;
-	key.offset = 0;
-
-	if (btrfs_search_tree(&btrfs_info.chunk_root, &key, &path))
-		return -1;
-
-	do {
-		found_key = btrfs_path_leaf_key(&path);
-		if (btrfs_comp_keys_type(&key, found_key))
-			continue;
-
-		chunk = btrfs_path_item_ptr(&path, struct btrfs_chunk);
-		btrfs_chunk_to_cpu(chunk);
-		if (add_chunk_mapping(found_key, chunk)) {
-			res = -1;
-			break;
-		}
-	} while (!(res = btrfs_next_slot(&path)));
-
-	__btrfs_free_path(&path);
-
-	if (res < 0)
-		return -1;
-
-	return 0;
-}
diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index 59e4a94cb2..23efefa199 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -115,7 +115,7 @@ static u32 decompress_zlib(const u8 *_cbuf, u32 clen, u8 *dbuf, u32 dlen)
 	while (stream.total_in < clen) {
 		stream.next_in = cbuf + stream.total_in;
 		stream.avail_in = min((u32) (clen - stream.total_in),
-				      (u32) btrfs_info.sb.sectorsize);
+					current_fs_info->sectorsize);
 
 		ret = inflate(&stream, Z_NO_FLUSH);
 		if (ret != Z_OK)
diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index 98c08d353a..5ffced9160 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -70,296 +70,6 @@ void btrfs_release_path(struct btrfs_path *p)
 	memset(p, 0, sizeof(*p));
 }
 
-int __btrfs_comp_keys(struct btrfs_key *a, struct btrfs_key *b)
-{
-	if (a->objectid > b->objectid)
-		return 1;
-	if (a->objectid < b->objectid)
-		return -1;
-	if (a->type > b->type)
-		return 1;
-	if (a->type < b->type)
-		return -1;
-	if (a->offset > b->offset)
-		return 1;
-	if (a->offset < b->offset)
-		return -1;
-	return 0;
-}
-
-int btrfs_comp_keys_type(struct btrfs_key *a, struct btrfs_key *b)
-{
-	if (a->objectid > b->objectid)
-		return 1;
-	if (a->objectid < b->objectid)
-		return -1;
-	if (a->type > b->type)
-		return 1;
-	if (a->type < b->type)
-		return -1;
-	return 0;
-}
-
-/*
- * search for key in the extent_buffer.  The items start at offset p,
- * and they are item_size apart.  There are 'max' items in p.
- *
- * the slot in the array is returned via slot, and it points to
- * the place where you would insert key if it is not found in
- * the array.
- *
- * slot may point to max if the key is bigger than all of the keys
- */
-static int __generic_bin_search(void *addr, int item_size, struct btrfs_key *key,
-			      int max, int *slot)
-{
-	int low = 0, high = max, mid, ret;
-	struct btrfs_key *tmp;
-
-	while (low < high) {
-		mid = (low + high) / 2;
-
-		tmp = (struct btrfs_key *) ((u8 *) addr + mid*item_size);
-		ret = __btrfs_comp_keys(tmp, key);
-
-		if (ret < 0) {
-			low = mid + 1;
-		} else if (ret > 0) {
-			high = mid;
-		} else {
-			*slot = mid;
-			return 0;
-		}
-	}
-
-	*slot = low;
-	return 1;
-}
-
-int __btrfs_bin_search(union btrfs_tree_node *p, struct btrfs_key *key,
-		       int *slot)
-{
-	void *addr;
-	unsigned long size;
-
-	if (p->header.level) {
-		addr = p->node.ptrs;
-		size = sizeof(struct btrfs_key_ptr);
-	} else {
-		addr = p->leaf.items;
-		size = sizeof(struct btrfs_item);
-	}
-
-	return __generic_bin_search(addr, size, key, p->header.nritems, slot);
-}
-
-static void clear_path(struct __btrfs_path *p)
-{
-	int i;
-
-	for (i = 0; i < BTRFS_MAX_LEVEL; ++i) {
-		p->nodes[i] = NULL;
-		p->slots[i] = 0;
-	}
-}
-
-void __btrfs_free_path(struct __btrfs_path *p)
-{
-	int i;
-
-	for (i = 0; i < BTRFS_MAX_LEVEL; ++i) {
-		if (p->nodes[i])
-			free(p->nodes[i]);
-	}
-
-	clear_path(p);
-}
-
-static int read_tree_node(u64 physical, union btrfs_tree_node **buf)
-{
-	ALLOC_CACHE_ALIGN_BUFFER(struct btrfs_header, hdr,
-				 sizeof(struct btrfs_header));
-	unsigned long size, offset = sizeof(*hdr);
-	union btrfs_tree_node *res;
-	u32 i;
-
-	if (!btrfs_devread(physical, sizeof(*hdr), hdr))
-		return -1;
-
-	btrfs_header_to_cpu(hdr);
-
-	if (hdr->level)
-		size = sizeof(struct btrfs_node)
-		       + hdr->nritems * sizeof(struct btrfs_key_ptr);
-	else
-		size = btrfs_info.sb.nodesize;
-
-	res = malloc_cache_aligned(size);
-	if (!res) {
-		debug("%s: malloc failed\n", __func__);
-		return -1;
-	}
-
-	if (!btrfs_devread(physical + offset, size - offset,
-			   ((u8 *) res) + offset)) {
-		free(res);
-		return -1;
-	}
-
-	memcpy(&res->header, hdr, sizeof(*hdr));
-	if (hdr->level)
-		for (i = 0; i < hdr->nritems; ++i)
-			btrfs_key_ptr_to_cpu(&res->node.ptrs[i]);
-	else
-		for (i = 0; i < hdr->nritems; ++i)
-			btrfs_item_to_cpu(&res->leaf.items[i]);
-
-	*buf = res;
-
-	return 0;
-}
-
-int btrfs_search_tree(const struct __btrfs_root *root, struct btrfs_key *key,
-		      struct __btrfs_path *p)
-{
-	u8 lvl, prev_lvl;
-	int i, slot, ret;
-	u64 logical, physical;
-	union btrfs_tree_node *buf;
-
-	clear_path(p);
-
-	logical = root->bytenr;
-
-	for (i = 0; i < BTRFS_MAX_LEVEL; ++i) {
-		physical = btrfs_map_logical_to_physical(logical);
-		if (physical == -1ULL)
-			goto err;
-
-		if (read_tree_node(physical, &buf))
-			goto err;
-
-		lvl = buf->header.level;
-		if (i && prev_lvl != lvl + 1) {
-			printf("%s: invalid level in header at %llu\n",
-			       __func__, logical);
-			goto err;
-		}
-		prev_lvl = lvl;
-
-		ret = __btrfs_bin_search(buf, key, &slot);
-		if (ret < 0)
-			goto err;
-		if (ret && slot > 0 && lvl)
-			slot -= 1;
-
-		p->slots[lvl] = slot;
-		p->nodes[lvl] = buf;
-
-		if (lvl) {
-			logical = buf->node.ptrs[slot].blockptr;
-		} else {
-			/*
-			 * The path might be invalid if:
-			 *   cur leaf max < searched value < next leaf min
-			 *
-			 * Jump to the next valid element if it exists.
-			 */
-			if (slot >= buf->header.nritems)
-				if (btrfs_next_slot(p) < 0)
-					goto err;
-			break;
-		}
-	}
-
-	return 0;
-err:
-	__btrfs_free_path(p);
-	return -1;
-}
-
-static int jump_leaf(struct __btrfs_path *path, int dir)
-{
-	struct __btrfs_path p;
-	u32 slot;
-	int level = 1, from_level, i;
-
-	dir = dir >= 0 ? 1 : -1;
-
-	p = *path;
-
-	while (level < BTRFS_MAX_LEVEL) {
-		if (!p.nodes[level])
-			return 1;
-
-		slot = p.slots[level];
-		if ((dir > 0 && slot + dir >= p.nodes[level]->header.nritems)
-		    || (dir < 0 && !slot))
-			level++;
-		else
-			break;
-	}
-
-	if (level == BTRFS_MAX_LEVEL)
-		return 1;
-
-	p.slots[level] = slot + dir;
-	level--;
-	from_level = level;
-
-	while (level >= 0) {
-		u64 logical, physical;
-
-		slot = p.slots[level + 1];
-		logical = p.nodes[level + 1]->node.ptrs[slot].blockptr;
-		physical = btrfs_map_logical_to_physical(logical);
-		if (physical == -1ULL)
-			goto err;
-
-		if (read_tree_node(physical, &p.nodes[level]))
-			goto err;
-
-		if (dir > 0)
-			p.slots[level] = 0;
-		else
-			p.slots[level] = p.nodes[level]->header.nritems - 1;
-		level--;
-	}
-
-	/* Free rewritten nodes in path */
-	for (i = 0; i <= from_level; ++i)
-		free(path->nodes[i]);
-
-	*path = p;
-	return 0;
-
-err:
-	/* Free rewritten nodes in p */
-	for (i = level + 1; i <= from_level; ++i)
-		free(p.nodes[i]);
-	return -1;
-}
-
-int btrfs_prev_slot(struct __btrfs_path *p)
-{
-	if (!p->slots[0])
-		return jump_leaf(p, -1);
-
-	p->slots[0]--;
-	return 0;
-}
-
-int btrfs_next_slot(struct __btrfs_path *p)
-{
-	struct btrfs_leaf *leaf = &p->nodes[0]->leaf;
-
-	if (p->slots[0] + 1 >= leaf->header.nritems)
-		return jump_leaf(p, 1);
-
-	p->slots[0]++;
-	return 0;
-}
-
 int btrfs_comp_cpu_keys(const struct btrfs_key *k1, const struct btrfs_key *k2)
 {
 	if (k1->objectid > k2->objectid)
diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index c4b25189dc..219c410b18 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -1204,69 +1204,6 @@ union btrfs_tree_node {
 	struct btrfs_node node;
 };
 
-struct __btrfs_path {
-	union btrfs_tree_node *nodes[BTRFS_MAX_LEVEL];
-	u32 slots[BTRFS_MAX_LEVEL];
-};
-
-struct __btrfs_root {
-	u64 objectid;
-	u64 bytenr;
-	u64 root_dirid;
-};
-
-int __btrfs_comp_keys(struct btrfs_key *, struct btrfs_key *);
-int btrfs_comp_keys_type(struct btrfs_key *, struct btrfs_key *);
-int __btrfs_bin_search(union btrfs_tree_node *, struct btrfs_key *, int *);
-void __btrfs_free_path(struct __btrfs_path *);
-int btrfs_search_tree(const struct __btrfs_root *, struct btrfs_key *,
-		      struct __btrfs_path *);
-int btrfs_prev_slot(struct __btrfs_path *);
-int btrfs_next_slot(struct __btrfs_path *);
-
-static inline struct btrfs_key *btrfs_path_leaf_key(struct __btrfs_path *p) {
-	/* At tree read time we have converted the endian for btrfs_disk_key */
-	return (struct btrfs_key *)&p->nodes[0]->leaf.items[p->slots[0]].key;
-}
-
-static inline struct btrfs_key *
-btrfs_search_tree_key_type(const struct __btrfs_root *root, u64 objectid,
-			   u8 type, struct __btrfs_path *path)
-{
-	struct btrfs_key key, *res;
-
-	key.objectid = objectid;
-	key.type = type;
-	key.offset = 0;
-
-	if (btrfs_search_tree(root, &key, path))
-		return NULL;
-
-	res = btrfs_path_leaf_key(path);
-	if (btrfs_comp_keys_type(&key, res)) {
-		__btrfs_free_path(path);
-		return NULL;
-	}
-
-	return res;
-}
-
-static inline u32 btrfs_path_item_size(struct __btrfs_path *p)
-{
-	return p->nodes[0]->leaf.items[p->slots[0]].size;
-}
-
-static inline void *__btrfs_leaf_data(struct btrfs_leaf *leaf, u32 slot)
-{
-	return ((u8 *) leaf) + sizeof(struct btrfs_header)
-	       + leaf->items[slot].offset;
-}
-
-static inline void *btrfs_path_leaf_data(struct __btrfs_path *p)
-{
-	return __btrfs_leaf_data(&p->nodes[0]->leaf, p->slots[0]);
-}
-
 #define btrfs_path_item_ptr(p,t)		\
 	((t *) btrfs_path_leaf_data((p)))
 
diff --git a/fs/btrfs/dir-item.c b/fs/btrfs/dir-item.c
index 1a3929afdc..aab197a6d5 100644
--- a/fs/btrfs/dir-item.c
+++ b/fs/btrfs/dir-item.c
@@ -114,85 +114,6 @@ struct btrfs_dir_item *btrfs_lookup_dir_item(struct btrfs_trans_handle *trans,
 	return btrfs_match_dir_item_name(root, path, name, name_len);
 }
 
-static int __verify_dir_item(struct btrfs_dir_item *item, u32 start, u32 total)
-{
-	u16 max_len = BTRFS_NAME_LEN;
-	u32 end;
-
-	if (item->type >= BTRFS_FT_MAX) {
-		printf("%s: invalid dir item type: %i\n", __func__, item->type);
-		return 1;
-	}
-
-	if (item->type == BTRFS_FT_XATTR)
-		max_len = 255; /* XATTR_NAME_MAX */
-
-	end = start + sizeof(*item) + item->name_len;
-	if (item->name_len > max_len || end > total) {
-		printf("%s: invalid dir item name len: %u\n", __func__,
-		       item->name_len);
-		return 1;
-	}
-
-	return 0;
-}
-
-static struct btrfs_dir_item *
-__btrfs_match_dir_item_name(struct __btrfs_path *path, const char *name,
-			  int name_len)
-{
-	struct btrfs_dir_item *item;
-	u32 total_len, cur = 0, this_len;
-	const char *name_ptr;
-
-	item = btrfs_path_item_ptr(path, struct btrfs_dir_item);
-
-	total_len = btrfs_path_item_size(path);
-
-	while (cur < total_len) {
-		btrfs_dir_item_to_cpu(item);
-		this_len = sizeof(*item) + item->name_len + item->data_len;
-		name_ptr = (const char *) (item + 1);
-
-		if (__verify_dir_item(item, cur, total_len))
-			return NULL;
-		if (item->name_len == name_len && !memcmp(name_ptr, name,
-							  name_len))
-			return item;
-
-		cur += this_len;
-		item = (struct btrfs_dir_item *) ((u8 *) item + this_len);
-	}
-
-	return NULL;
-}
-
-int __btrfs_lookup_dir_item(const struct __btrfs_root *root, u64 dir,
-			  const char *name, int name_len,
-			  struct btrfs_dir_item *item)
-{
-	struct __btrfs_path path;
-	struct btrfs_key key;
-	struct btrfs_dir_item *res = NULL;
-
-	key.objectid = dir;
-	key.type = BTRFS_DIR_ITEM_KEY;
-	key.offset = btrfs_name_hash(name, name_len);
-
-	if (btrfs_search_tree(root, &key, &path))
-		return -1;
-
-	if (btrfs_comp_keys_type(&key, btrfs_path_leaf_key(&path)))
-		goto out;
-
-	res = __btrfs_match_dir_item_name(&path, name, name_len);
-	if (res)
-		*item = *res;
-out:
-	__btrfs_free_path(&path);
-	return res ? 0 : -1;
-}
-
 int btrfs_iter_dir(struct btrfs_root *root, u64 ino,
 		   btrfs_iter_dir_callback_t callback)
 {
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 4da1b80038..01e7cee520 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -310,36 +310,6 @@ int btrfs_read_dev_super(struct blk_desc *desc, struct disk_partition *part,
 	return 0;
 }
 
-int btrfs_read_superblock(void)
-{
-	ALLOC_CACHE_ALIGN_BUFFER(char, raw_sb, BTRFS_SUPER_INFO_SIZE);
-	struct btrfs_super_block *sb = (struct btrfs_super_block *) raw_sb;
-	int ret;
-
-
-	btrfs_info.sb.generation = 0;
-
-	ret = btrfs_read_dev_super(btrfs_blk_desc, btrfs_part_info, sb);
-	if (ret < 0) {
-		pr_debug("%s: No valid BTRFS superblock found!\n", __func__);
-		return ret;
-	}
-	btrfs_super_block_to_cpu(sb);
-	memcpy(&btrfs_info.sb, sb, sizeof(*sb));
-
-	if (btrfs_info.sb.num_devices != 1) {
-		printf("%s: Unsupported number of devices (%lli). This driver "
-		       "only supports filesystem on one device.\n", __func__,
-		       btrfs_info.sb.num_devices);
-		return -1;
-	}
-
-	pr_debug("Chosen superblock with generation = %llu\n",
-	      btrfs_info.sb.generation);
-
-	return 0;
-}
-
 static int __csum_tree_block_size(struct extent_buffer *buf, u16 csum_size,
 				  int verify, int silent, u16 csum_type)
 {
diff --git a/fs/btrfs/disk-io.h b/fs/btrfs/disk-io.h
index 424bb01dcd..a347912078 100644
--- a/fs/btrfs/disk-io.h
+++ b/fs/btrfs/disk-io.h
@@ -10,9 +10,6 @@
 #define BTRFS_SUPER_INFO_OFFSET SZ_64K
 #define BTRFS_SUPER_INFO_SIZE	SZ_4K
 
-/* U-boot specific */
-int btrfs_read_superblock(void);
-
 /* From btrfs-progs */
 int read_whole_eb(struct btrfs_fs_info *info, struct extent_buffer *eb, int mirror);
 struct extent_buffer* read_tree_block(struct btrfs_fs_info *fs_info, u64 bytenr,
diff --git a/fs/btrfs/extent-io.c b/fs/btrfs/extent-io.c
index ccf4da3177..774e29eb60 100644
--- a/fs/btrfs/extent-io.c
+++ b/fs/btrfs/extent-io.c
@@ -14,122 +14,6 @@
 #include "extent-io.h"
 #include "disk-io.h"
 
-u64 __btrfs_read_extent_inline(struct __btrfs_path *path,
-			     struct btrfs_file_extent_item *extent, u64 offset,
-			     u64 size, char *out)
-{
-	u32 clen, dlen, orig_size = size, res;
-	const char *cbuf;
-	char *dbuf;
-	const int data_off = offsetof(struct btrfs_file_extent_item,
-				      disk_bytenr);
-
-	clen = btrfs_path_item_size(path) - data_off;
-	cbuf = (const char *) extent + data_off;
-	dlen = extent->ram_bytes;
-
-	if (offset > dlen)
-		return -1ULL;
-
-	if (size > dlen - offset)
-		size = dlen - offset;
-
-	if (extent->compression == BTRFS_COMPRESS_NONE) {
-		memcpy(out, cbuf + offset, size);
-		return size;
-	}
-
-	if (dlen > orig_size) {
-		dbuf = malloc(dlen);
-		if (!dbuf)
-			return -1ULL;
-	} else {
-		dbuf = out;
-	}
-
-	res = btrfs_decompress(extent->compression, cbuf, clen, dbuf, dlen);
-	if (res == -1 || res != dlen)
-		goto err;
-
-	if (dlen > orig_size) {
-		memcpy(out, dbuf + offset, size);
-		free(dbuf);
-	} else if (offset) {
-		memmove(out, dbuf + offset, size);
-	}
-
-	return size;
-
-err:
-	if (dlen > orig_size)
-		free(dbuf);
-	return -1ULL;
-}
-
-u64 __btrfs_read_extent_reg(struct __btrfs_path *path,
-			  struct btrfs_file_extent_item *extent, u64 offset,
-			  u64 size, char *out)
-{
-	u64 physical, clen, dlen, orig_size = size;
-	u32 res;
-	char *cbuf, *dbuf;
-
-	clen = extent->disk_num_bytes;
-	dlen = extent->num_bytes;
-
-	if (offset > dlen)
-		return -1ULL;
-
-	if (size > dlen - offset)
-		size = dlen - offset;
-
-	/* sparse extent */
-	if (extent->disk_bytenr == 0) {
-		memset(out, 0, size);
-		return size;
-	}
-
-	physical = btrfs_map_logical_to_physical(extent->disk_bytenr);
-	if (physical == -1ULL)
-		return -1ULL;
-
-	if (extent->compression == BTRFS_COMPRESS_NONE) {
-		physical += extent->offset + offset;
-		if (!btrfs_devread(physical, size, out))
-			return -1ULL;
-
-		return size;
-	}
-
-	cbuf = malloc_cache_aligned(dlen > size ? clen + dlen : clen);
-	if (!cbuf)
-		return -1ULL;
-
-	if (dlen > orig_size)
-		dbuf = cbuf + clen;
-	else
-		dbuf = out;
-
-	if (!btrfs_devread(physical, clen, cbuf))
-		goto err;
-
-	res = btrfs_decompress(extent->compression, cbuf, clen, dbuf, dlen);
-	if (res == -1)
-		goto err;
-
-	if (dlen > orig_size)
-		memcpy(out, dbuf + offset, size);
-	else
-		memmove(out, dbuf + offset, size);
-
-	free(cbuf);
-	return res;
-
-err:
-	free(cbuf);
-	return -1ULL;
-}
-
 void extent_io_tree_init(struct extent_io_tree *tree)
 {
 	cache_tree_init(&tree->state);
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 0c2b2b5705..ff330280e0 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -12,81 +12,6 @@
 #include "disk-io.h"
 #include "volumes.h"
 
-u64 __btrfs_lookup_inode_ref(struct __btrfs_root *root, u64 inr,
-			   struct btrfs_inode_ref *refp, char *name)
-{
-	struct __btrfs_path path;
-	struct btrfs_key *key;
-	struct btrfs_inode_ref *ref;
-	u64 res = -1ULL;
-
-	key = btrfs_search_tree_key_type(root, inr, BTRFS_INODE_REF_KEY,
-					       &path);
-
-	if (!key)
-		return -1ULL;
-
-	ref = btrfs_path_item_ptr(&path, struct btrfs_inode_ref);
-	btrfs_inode_ref_to_cpu(ref);
-
-	if (refp)
-		*refp = *ref;
-
-	if (name) {
-		if (ref->name_len > BTRFS_NAME_LEN) {
-			printf("%s: inode name too long: %u\n", __func__,
-			        ref->name_len);
-			goto out;
-		}
-
-		memcpy(name, ref + 1, ref->name_len);
-	}
-
-	res = key->offset;
-out:
-	__btrfs_free_path(&path);
-	return res;
-}
-
-int __btrfs_lookup_inode(const struct __btrfs_root *root,
-		       struct btrfs_key *location,
-		       struct btrfs_inode_item *item,
-		       struct __btrfs_root *new_root)
-{
-	struct __btrfs_root tmp_root = *root;
-	struct __btrfs_path path;
-	int res = -1;
-
-	if (location->type == BTRFS_ROOT_ITEM_KEY) {
-		if (btrfs_find_root(location->objectid, &tmp_root, NULL))
-			return -1;
-
-		location->objectid = tmp_root.root_dirid;
-		location->type = BTRFS_INODE_ITEM_KEY;
-		location->offset = 0;
-	}
-
-	if (btrfs_search_tree(&tmp_root, location, &path))
-		return res;
-
-	if (__btrfs_comp_keys(location, btrfs_path_leaf_key(&path)))
-		goto out;
-
-	if (item) {
-		*item = *btrfs_path_item_ptr(&path, struct btrfs_inode_item);
-		btrfs_inode_item_to_cpu(item);
-	}
-
-	if (new_root)
-		*new_root = tmp_root;
-
-	res = 0;
-
-out:
-	__btrfs_free_path(&path);
-	return res;
-}
-
 /*
  * Read the content of symlink inode @ino of @root, into @target.
  * NOTE: @target will not be \0 termiated, caller should handle it properly.
@@ -143,28 +68,6 @@ out:
 	return ret;
 }
 
-int __btrfs_readlink(const struct __btrfs_root *root, u64 inr, char *target)
-{
-	struct btrfs_root *subvolume;
-	struct btrfs_fs_info *fs_info = current_fs_info;
-	struct btrfs_key key;
-	int ret;
-
-	ASSERT(fs_info);
-	key.objectid = root->objectid;
-	key.type = BTRFS_ROOT_ITEM_KEY;
-	key.offset = (u64)-1;
-	subvolume = btrfs_read_fs_root(fs_info, &key);
-	if (IS_ERR(subvolume))
-		return -1;
-
-	ret = btrfs_readlink(subvolume, inr, target);
-	if (ret < 0)
-		return -1;
-	target[ret] = '\0';
-	return 0;
-}
-
 static int lookup_root_ref(struct btrfs_fs_info *fs_info,
 			   u64 rootid, u64 *root_ret, u64 *dir_ret)
 {
@@ -274,58 +177,6 @@ out:
 	return ret;
 }
 
-/* inr must be a directory (for regular files with multiple hard links this
-   function returns only one of the parents of the file) */
-static u64 __get_parent_inode(struct __btrfs_root *root, u64 inr,
-			    struct btrfs_inode_item *inode_item)
-{
-	struct btrfs_key key;
-	u64 res;
-
-	if (inr == BTRFS_FIRST_FREE_OBJECTID) {
-		if (root->objectid != btrfs_info.fs_root.objectid) {
-			u64 parent;
-			struct btrfs_root_ref ref;
-
-			parent = btrfs_lookup_root_ref(root->objectid, &ref,
-						       NULL);
-			if (parent == -1ULL)
-				return -1ULL;
-
-			if (btrfs_find_root(parent, root, NULL))
-				return -1ULL;
-
-			inr = ref.dirid;
-		}
-
-		if (inode_item) {
-			key.objectid = inr;
-			key.type = BTRFS_INODE_ITEM_KEY;
-			key.offset = 0;
-
-			if (__btrfs_lookup_inode(root, &key, inode_item, NULL))
-				return -1ULL;
-		}
-
-		return inr;
-	}
-
-	res = __btrfs_lookup_inode_ref(root, inr, NULL, NULL);
-	if (res == -1ULL)
-		return -1ULL;
-
-	if (inode_item) {
-		key.objectid = res;
-		key.type = BTRFS_INODE_ITEM_KEY;
-		key.offset = 0;
-
-		if (__btrfs_lookup_inode(root, &key, inode_item, NULL))
-			return -1ULL;
-	}
-
-	return res;
-}
-
 static inline int next_length(const char *path)
 {
 	int res = 0;
@@ -493,180 +344,6 @@ next:
 	return ret;
 }
 
-u64 __btrfs_lookup_path(struct __btrfs_root *root, u64 inr, const char *path,
-		      u8 *type_p, struct btrfs_inode_item *inode_item_p,
-		      int symlink_limit)
-{
-	struct btrfs_dir_item item;
-	struct btrfs_inode_item inode_item;
-	u8 type = BTRFS_FT_DIR;
-	int len, have_inode = 0;
-	const char *cur = path;
-
-	if (*cur == '/') {
-		++cur;
-		inr = root->root_dirid;
-	}
-
-	do {
-		cur = skip_current_directories(cur);
-
-		len = next_length(cur);
-		if (len > BTRFS_NAME_LEN) {
-			printf("%s: Name too long at \"%.*s\"\n", __func__,
-			       BTRFS_NAME_LEN, cur);
-			return -1ULL;
-		}
-
-		if (len == 1 && cur[0] == '.')
-			break;
-
-		if (len == 2 && cur[0] == '.' && cur[1] == '.') {
-			cur += 2;
-			inr = __get_parent_inode(root, inr, &inode_item);
-			if (inr == -1ULL)
-				return -1ULL;
-
-			type = BTRFS_FT_DIR;
-			continue;
-		}
-
-		if (!*cur)
-			break;
-		
-		if (__btrfs_lookup_dir_item(root, inr, cur, len, &item))
-			return -1ULL;
-
-		type = item.type;
-		have_inode = 1;
-		if (__btrfs_lookup_inode(root, (struct btrfs_key *)&item.location,
-					&inode_item, root))
-			return -1ULL;
-
-		if (item.type == BTRFS_FT_SYMLINK && symlink_limit >= 0) {
-			char *target;
-
-			if (!symlink_limit) {
-				printf("%s: Too much symlinks!\n", __func__);
-				return -1ULL;
-			}
-
-			target = malloc(min(inode_item.size + 1,
-					    (u64) btrfs_info.sb.sectorsize));
-			if (!target)
-				return -1ULL;
-
-			if (__btrfs_readlink(root, item.location.objectid,
-					   target)) {
-				free(target);
-				return -1ULL;
-			}
-
-			inr = __btrfs_lookup_path(root, inr, target, &type,
-						&inode_item, symlink_limit - 1);
-
-			free(target);
-
-			if (inr == -1ULL)
-				return -1ULL;
-		} else if (item.type != BTRFS_FT_DIR && cur[len]) {
-			printf("%s: \"%.*s\" not a directory\n", __func__,
-			       (int) (cur - path + len), path);
-			return -1ULL;
-		} else {
-			inr = item.location.objectid;
-		}
-
-		cur += len;
-	} while (*cur);
-
-	if (type_p)
-		*type_p = type;
-
-	if (inode_item_p) {
-		if (!have_inode) {
-			struct btrfs_key key;
-
-			key.objectid = inr;
-			key.type = BTRFS_INODE_ITEM_KEY;
-			key.offset = 0;
-
-			if (__btrfs_lookup_inode(root, &key, &inode_item, NULL))
-				return -1ULL;
-		}
-
-		*inode_item_p = inode_item;
-	}
-
-	return inr;
-}
-
-u64 __btrfs_file_read(const struct __btrfs_root *root, u64 inr, u64 offset,
-		    u64 size, char *buf)
-{
-	struct __btrfs_path path;
-	struct btrfs_key key;
-	struct btrfs_file_extent_item *extent;
-	int res = 0;
-	u64 rd, rd_all = -1ULL;
-
-	key.objectid = inr;
-	key.type = BTRFS_EXTENT_DATA_KEY;
-	key.offset = offset;
-
-	if (btrfs_search_tree(root, &key, &path))
-		return -1ULL;
-
-	if (__btrfs_comp_keys(&key, btrfs_path_leaf_key(&path)) < 0) {
-		if (btrfs_prev_slot(&path))
-			goto out;
-
-		if (btrfs_comp_keys_type(&key, btrfs_path_leaf_key(&path)))
-			goto out;
-	}
-
-	rd_all = 0;
-
-	do {
-		if (btrfs_comp_keys_type(&key, btrfs_path_leaf_key(&path)))
-			break;
-
-		extent = btrfs_path_item_ptr(&path,
-					     struct btrfs_file_extent_item);
-
-		if (extent->type == BTRFS_FILE_EXTENT_INLINE) {
-			btrfs_file_extent_item_to_cpu_inl(extent);
-			rd = __btrfs_read_extent_inline(&path, extent, offset,
-						      size, buf);
-		} else {
-			btrfs_file_extent_item_to_cpu(extent);
-			rd = __btrfs_read_extent_reg(&path, extent, offset, size,
-						   buf);
-		}
-
-		if (rd == -1ULL) {
-			printf("%s: Error reading extent\n", __func__);
-			rd_all = -1;
-			goto out;
-		}
-
-		offset = 0;
-		buf += rd;
-		rd_all += rd;
-		size -= rd;
-
-		if (!size)
-			break;
-	} while (!(res = btrfs_next_slot(&path)));
-
-	if (res)
-		return -1ULL;
-
-out:
-	__btrfs_free_path(&path);
-	return rd_all;
-}
-
 /*
  * Read out inline extent.
  *
diff --git a/fs/btrfs/root.c b/fs/btrfs/root.c
deleted file mode 100644
index a424966df6..0000000000
--- a/fs/btrfs/root.c
+++ /dev/null
@@ -1,92 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * BTRFS filesystem implementation for U-Boot
- *
- * 2017 Marek Behun, CZ.NIC, marek.behun@nic.cz
- */
-
-#include "btrfs.h"
-
-static void read_root_item(struct __btrfs_path *p, struct btrfs_root_item *item)
-{
-	u32 len;
-	int reset = 0;
-
-	len = btrfs_path_item_size(p);
-	memcpy(item, btrfs_path_item_ptr(p, struct btrfs_root_item), len);
-	btrfs_root_item_to_cpu(item);
-
-	if (len < sizeof(*item))
-		reset = 1;
-	if (!reset && item->generation != item->generation_v2) {
-		if (item->generation_v2 != 0)
-			printf("%s: generation != generation_v2 in root item",
-			       __func__);
-		reset = 1;
-	}
-	if (reset) {
-		memset(&item->generation_v2, 0,
-		       sizeof(*item) - offsetof(struct btrfs_root_item,
-						generation_v2));
-	}
-}
-
-int btrfs_find_root(u64 objectid, struct __btrfs_root *root,
-		    struct btrfs_root_item *root_item)
-{
-	struct __btrfs_path path;
-	struct btrfs_root_item my_root_item;
-
-	if (!btrfs_search_tree_key_type(&btrfs_info.tree_root, objectid,
-					BTRFS_ROOT_ITEM_KEY, &path))
-		return -1;
-
-	if (!root_item)
-		root_item = &my_root_item;
-	read_root_item(&path, root_item);
-
-	if (root) {
-		root->objectid = objectid;
-		root->bytenr = root_item->bytenr;
-		root->root_dirid = root_item->root_dirid;
-	}
-
-	__btrfs_free_path(&path);
-	return 0;
-}
-
-u64 btrfs_lookup_root_ref(u64 subvolid, struct btrfs_root_ref *refp, char *name)
-{
-	struct __btrfs_path path;
-	struct btrfs_key *key;
-	struct btrfs_root_ref *ref;
-	u64 res = -1ULL;
-
-	key = btrfs_search_tree_key_type(&btrfs_info.tree_root, subvolid,
-					       BTRFS_ROOT_BACKREF_KEY, &path);
-
-	if (!key)
-		return -1ULL;
-
-	ref = btrfs_path_item_ptr(&path, struct btrfs_root_ref);
-	btrfs_root_ref_to_cpu(ref);
-
-	if (refp)
-		*refp = *ref;
-
-	if (name) {
-		if (ref->name_len > BTRFS_NAME_LEN) {
-			printf("%s: volume name too long: %u\n", __func__,
-			       ref->name_len);
-			goto out;
-		}
-
-		memcpy(name, ref + 1, ref->name_len);
-	}
-
-	res = key->offset;
-out:
-	__btrfs_free_path(&path);
-	return res;
-}
-
diff --git a/fs/btrfs/subvolume.c b/fs/btrfs/subvolume.c
index 6fc28d53e5..2815673bcd 100644
--- a/fs/btrfs/subvolume.c
+++ b/fs/btrfs/subvolume.c
@@ -221,117 +221,6 @@ out:
 	return ret;
 }
 
-static int get_subvol_name(u64 subvolid, char *name, int max_len)
-{
-	struct btrfs_root_ref rref;
-	struct btrfs_inode_ref iref;
-	struct __btrfs_root root;
-	u64 dir;
-	char tmp[BTRFS_NAME_LEN];
-	char *ptr;
-
-	ptr = name + max_len - 1;
-	*ptr = '\0';
-
-	while (subvolid != BTRFS_FS_TREE_OBJECTID) {
-		subvolid = btrfs_lookup_root_ref(subvolid, &rref, tmp);
-
-		if (subvolid == -1ULL)
-			return -1;
-
-		ptr -= rref.name_len + 1;
-		if (ptr < name)
-			goto too_long;
-
-		memcpy(ptr + 1, tmp, rref.name_len);
-		*ptr = '/';
-
-		if (btrfs_find_root(subvolid, &root, NULL))
-			return -1;
-
-		dir = rref.dirid;
-
-		while (dir != BTRFS_FIRST_FREE_OBJECTID) {
-			dir = __btrfs_lookup_inode_ref(&root, dir, &iref, tmp);
-
-			if (dir == -1ULL)
-				return -1;
-
-			ptr -= iref.name_len + 1;
-			if (ptr < name)
-				goto too_long;
-
-			memcpy(ptr + 1, tmp, iref.name_len);
-			*ptr = '/';
-		}
-	}
-
-	if (ptr == name + max_len - 1) {
-		name[0] = '/';
-		name[1] = '\0';
-	} else {
-		memmove(name, ptr, name + max_len - ptr);
-	}
-
-	return 0;
-
-too_long:
-	printf("%s: subvolume name too long\n", __func__);
-	return -1;
-}
-
-u64 btrfs_get_default_subvol_objectid(void)
-{
-	struct btrfs_dir_item item;
-
-	if (__btrfs_lookup_dir_item(&btrfs_info.tree_root,
-				  btrfs_info.sb.root_dir_objectid, "default", 7,
-				  &item))
-		return BTRFS_FS_TREE_OBJECTID;
-	return item.location.objectid;
-}
-
-static void list_subvols(u64 tree, char *nameptr, int max_name_len, int level)
-{
-	struct btrfs_key key, *found_key;
-	struct __btrfs_path path;
-	struct btrfs_root_ref *ref;
-	int res;
-
-	key.objectid = tree;
-	key.type = BTRFS_ROOT_REF_KEY;
-	key.offset = 0;
-
-	if (btrfs_search_tree(&btrfs_info.tree_root, &key, &path))
-		return;
-
-	do {
-		found_key = btrfs_path_leaf_key(&path);
-		if (btrfs_comp_keys_type(&key, found_key))
-			break;
-
-		ref = btrfs_path_item_ptr(&path, struct btrfs_root_ref);
-		btrfs_root_ref_to_cpu(ref);
-
-		printf("ID %llu parent %llu name ", found_key->offset, tree);
-		if (nameptr && !get_subvol_name(found_key->offset, nameptr,
-						max_name_len))
-			printf("%s\n", nameptr);
-		else
-			printf("%.*s\n", (int) ref->name_len,
-			       (const char *) (ref + 1));
-
-		if (level > 0)
-			list_subvols(found_key->offset, nameptr, max_name_len,
-				     level - 1);
-		else
-			printf("%s: Too much recursion, maybe skipping some "
-			       "subvolumes\n", __func__);
-	} while (!(res = btrfs_next_slot(&path)));
-
-	__btrfs_free_path(&path);
-}
-
 void btrfs_list_subvols(void)
 {
 	struct btrfs_fs_info *fs_info = current_fs_info;
-- 
2.26.2

