Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00DFA1E0703
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 May 2020 08:33:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388923AbgEYGdi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 25 May 2020 02:33:38 -0400
Received: from mx2.suse.de ([195.135.220.15]:60890 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388710AbgEYGdi (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 25 May 2020 02:33:38 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id AA5AFAF43;
        Mon, 25 May 2020 06:33:38 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org, u-boot@lists.denx.de
Cc:     marek.behun@nic.cz
Subject: [PATCH U-BOOT v2 10/30] fs: btrfs: Rename struct btrfs_path to struct __btrfs_path
Date:   Mon, 25 May 2020 14:32:37 +0800
Message-Id: <20200525063257.46757-11-wqu@suse.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200525063257.46757-1-wqu@suse.com>
References: <20200525063257.46757-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

To avoid name conflicting between the extent buffer based btrfs_path
from btrfs-progs.

Also rename btrfs_free_path() to __btrfs_free_path() to avoid conflicts.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/btrfs.h     |  4 ++--
 fs/btrfs/chunk-map.c |  4 ++--
 fs/btrfs/ctree.c     | 16 ++++++++--------
 fs/btrfs/ctree.h     | 20 ++++++++++----------
 fs/btrfs/dir-item.c  | 10 +++++-----
 fs/btrfs/extent-io.c |  4 ++--
 fs/btrfs/inode.c     | 16 ++++++++--------
 fs/btrfs/root.c      | 10 +++++-----
 fs/btrfs/subvolume.c |  4 ++--
 9 files changed, 44 insertions(+), 44 deletions(-)

diff --git a/fs/btrfs/btrfs.h b/fs/btrfs/btrfs.h
index 1aacbc8cbb83..a52fd34489c4 100644
--- a/fs/btrfs/btrfs.h
+++ b/fs/btrfs/btrfs.h
@@ -67,10 +67,10 @@ u64 btrfs_file_read(const struct btrfs_root *, u64, u64, u64, char *);
 u64 btrfs_get_default_subvol_objectid(void);
 
 /* extent-io.c */
-u64 btrfs_read_extent_inline(struct btrfs_path *,
+u64 btrfs_read_extent_inline(struct __btrfs_path *,
 			      struct btrfs_file_extent_item *, u64, u64,
 			      char *);
-u64 btrfs_read_extent_reg(struct btrfs_path *, struct btrfs_file_extent_item *,
+u64 btrfs_read_extent_reg(struct __btrfs_path *, struct btrfs_file_extent_item *,
 			   u64, u64, char *);
 
 #endif /* !__BTRFS_BTRFS_H__ */
diff --git a/fs/btrfs/chunk-map.c b/fs/btrfs/chunk-map.c
index 2e5be6506721..8e3d13c4a949 100644
--- a/fs/btrfs/chunk-map.c
+++ b/fs/btrfs/chunk-map.c
@@ -144,7 +144,7 @@ int btrfs_chunk_map_init(void)
 
 int btrfs_read_chunk_tree(void)
 {
-	struct btrfs_path path;
+	struct __btrfs_path path;
 	struct btrfs_key key, *found_key;
 	struct btrfs_chunk *chunk;
 	int res = 0;
@@ -169,7 +169,7 @@ int btrfs_read_chunk_tree(void)
 		}
 	} while (!(res = btrfs_next_slot(&path)));
 
-	btrfs_free_path(&path);
+	__btrfs_free_path(&path);
 
 	if (res < 0)
 		return -1;
diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index d97e195e5ec9..7bd12c2a1bc4 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -115,7 +115,7 @@ int btrfs_bin_search(union btrfs_tree_node *p, struct btrfs_key *key,
 	return generic_bin_search(addr, size, key, p->header.nritems, slot);
 }
 
-static void clear_path(struct btrfs_path *p)
+static void clear_path(struct __btrfs_path *p)
 {
 	int i;
 
@@ -125,7 +125,7 @@ static void clear_path(struct btrfs_path *p)
 	}
 }
 
-void btrfs_free_path(struct btrfs_path *p)
+void __btrfs_free_path(struct __btrfs_path *p)
 {
 	int i;
 
@@ -182,7 +182,7 @@ static int read_tree_node(u64 physical, union btrfs_tree_node **buf)
 }
 
 int btrfs_search_tree(const struct btrfs_root *root, struct btrfs_key *key,
-		      struct btrfs_path *p)
+		      struct __btrfs_path *p)
 {
 	u8 lvl, prev_lvl;
 	int i, slot, ret;
@@ -236,13 +236,13 @@ int btrfs_search_tree(const struct btrfs_root *root, struct btrfs_key *key,
 
 	return 0;
 err:
-	btrfs_free_path(p);
+	__btrfs_free_path(p);
 	return -1;
 }
 
-static int jump_leaf(struct btrfs_path *path, int dir)
+static int jump_leaf(struct __btrfs_path *path, int dir)
 {
-	struct btrfs_path p;
+	struct __btrfs_path p;
 	u32 slot;
 	int level = 1, from_level, i;
 
@@ -302,7 +302,7 @@ err:
 	return -1;
 }
 
-int btrfs_prev_slot(struct btrfs_path *p)
+int btrfs_prev_slot(struct __btrfs_path *p)
 {
 	if (!p->slots[0])
 		return jump_leaf(p, -1);
@@ -311,7 +311,7 @@ int btrfs_prev_slot(struct btrfs_path *p)
 	return 0;
 }
 
-int btrfs_next_slot(struct btrfs_path *p)
+int btrfs_next_slot(struct __btrfs_path *p)
 {
 	struct btrfs_leaf *leaf = &p->nodes[0]->leaf;
 
diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index c2a108af2148..e657e89b8653 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -1177,7 +1177,7 @@ union btrfs_tree_node {
 	struct btrfs_node node;
 };
 
-struct btrfs_path {
+struct __btrfs_path {
 	union btrfs_tree_node *nodes[BTRFS_MAX_LEVEL];
 	u32 slots[BTRFS_MAX_LEVEL];
 };
@@ -1191,20 +1191,20 @@ struct btrfs_root {
 int __btrfs_comp_keys(struct btrfs_key *, struct btrfs_key *);
 int btrfs_comp_keys_type(struct btrfs_key *, struct btrfs_key *);
 int btrfs_bin_search(union btrfs_tree_node *, struct btrfs_key *, int *);
-void btrfs_free_path(struct btrfs_path *);
+void __btrfs_free_path(struct __btrfs_path *);
 int btrfs_search_tree(const struct btrfs_root *, struct btrfs_key *,
-		      struct btrfs_path *);
-int btrfs_prev_slot(struct btrfs_path *);
-int btrfs_next_slot(struct btrfs_path *);
+		      struct __btrfs_path *);
+int btrfs_prev_slot(struct __btrfs_path *);
+int btrfs_next_slot(struct __btrfs_path *);
 
-static inline struct btrfs_key *btrfs_path_leaf_key(struct btrfs_path *p) {
+static inline struct btrfs_key *btrfs_path_leaf_key(struct __btrfs_path *p) {
 	/* At tree read time we have converted the endian for btrfs_disk_key */
 	return (struct btrfs_key *)&p->nodes[0]->leaf.items[p->slots[0]].key;
 }
 
 static inline struct btrfs_key *
 btrfs_search_tree_key_type(const struct btrfs_root *root, u64 objectid,
-			   u8 type, struct btrfs_path *path)
+			   u8 type, struct __btrfs_path *path)
 {
 	struct btrfs_key key, *res;
 
@@ -1217,14 +1217,14 @@ btrfs_search_tree_key_type(const struct btrfs_root *root, u64 objectid,
 
 	res = btrfs_path_leaf_key(path);
 	if (btrfs_comp_keys_type(&key, res)) {
-		btrfs_free_path(path);
+		__btrfs_free_path(path);
 		return NULL;
 	}
 
 	return res;
 }
 
-static inline u32 btrfs_path_item_size(struct btrfs_path *p)
+static inline u32 btrfs_path_item_size(struct __btrfs_path *p)
 {
 	return p->nodes[0]->leaf.items[p->slots[0]].size;
 }
@@ -1235,7 +1235,7 @@ static inline void *__btrfs_leaf_data(struct btrfs_leaf *leaf, u32 slot)
 	       + leaf->items[slot].offset;
 }
 
-static inline void *btrfs_path_leaf_data(struct btrfs_path *p)
+static inline void *btrfs_path_leaf_data(struct __btrfs_path *p)
 {
 	return __btrfs_leaf_data(&p->nodes[0]->leaf, p->slots[0]);
 }
diff --git a/fs/btrfs/dir-item.c b/fs/btrfs/dir-item.c
index 1ff446a45a85..5595542dabaa 100644
--- a/fs/btrfs/dir-item.c
+++ b/fs/btrfs/dir-item.c
@@ -32,7 +32,7 @@ static int verify_dir_item(struct btrfs_dir_item *item, u32 start, u32 total)
 }
 
 static struct btrfs_dir_item *
-btrfs_match_dir_item_name(struct btrfs_path *path, const char *name,
+btrfs_match_dir_item_name(struct __btrfs_path *path, const char *name,
 			  int name_len)
 {
 	struct btrfs_dir_item *item;
@@ -65,7 +65,7 @@ int btrfs_lookup_dir_item(const struct btrfs_root *root, u64 dir,
 			  const char *name, int name_len,
 			  struct btrfs_dir_item *item)
 {
-	struct btrfs_path path;
+	struct __btrfs_path path;
 	struct btrfs_key key;
 	struct btrfs_dir_item *res = NULL;
 
@@ -83,14 +83,14 @@ int btrfs_lookup_dir_item(const struct btrfs_root *root, u64 dir,
 	if (res)
 		*item = *res;
 out:
-	btrfs_free_path(&path);
+	__btrfs_free_path(&path);
 	return res ? 0 : -1;
 }
 
 int btrfs_readdir(const struct btrfs_root *root, u64 dir,
 		  btrfs_readdir_callback_t callback)
 {
-	struct btrfs_path path;
+	struct __btrfs_path path;
 	struct btrfs_key key, *found_key;
 	struct btrfs_dir_item *item;
 	int res = 0;
@@ -119,7 +119,7 @@ int btrfs_readdir(const struct btrfs_root *root, u64 dir,
 			break;
 	} while (!(res = btrfs_next_slot(&path)));
 
-	btrfs_free_path(&path);
+	__btrfs_free_path(&path);
 
 	return res < 0 ? -1 : 0;
 }
diff --git a/fs/btrfs/extent-io.c b/fs/btrfs/extent-io.c
index 360ed77f48f8..43f770b579f8 100644
--- a/fs/btrfs/extent-io.c
+++ b/fs/btrfs/extent-io.c
@@ -14,7 +14,7 @@
 #include "extent-io.h"
 #include "disk-io.h"
 
-u64 btrfs_read_extent_inline(struct btrfs_path *path,
+u64 btrfs_read_extent_inline(struct __btrfs_path *path,
 			     struct btrfs_file_extent_item *extent, u64 offset,
 			     u64 size, char *out)
 {
@@ -66,7 +66,7 @@ err:
 	return -1ULL;
 }
 
-u64 btrfs_read_extent_reg(struct btrfs_path *path,
+u64 btrfs_read_extent_reg(struct __btrfs_path *path,
 			  struct btrfs_file_extent_item *extent, u64 offset,
 			  u64 size, char *out)
 {
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 55f431a28900..c0778726a0ec 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -11,7 +11,7 @@
 u64 btrfs_lookup_inode_ref(struct btrfs_root *root, u64 inr,
 			   struct btrfs_inode_ref *refp, char *name)
 {
-	struct btrfs_path path;
+	struct __btrfs_path path;
 	struct btrfs_key *key;
 	struct btrfs_inode_ref *ref;
 	u64 res = -1ULL;
@@ -40,7 +40,7 @@ u64 btrfs_lookup_inode_ref(struct btrfs_root *root, u64 inr,
 
 	res = key->offset;
 out:
-	btrfs_free_path(&path);
+	__btrfs_free_path(&path);
 	return res;
 }
 
@@ -50,7 +50,7 @@ int btrfs_lookup_inode(const struct btrfs_root *root,
 		       struct btrfs_root *new_root)
 {
 	struct btrfs_root tmp_root = *root;
-	struct btrfs_path path;
+	struct __btrfs_path path;
 	int res = -1;
 
 	if (location->type == BTRFS_ROOT_ITEM_KEY) {
@@ -79,13 +79,13 @@ int btrfs_lookup_inode(const struct btrfs_root *root,
 	res = 0;
 
 out:
-	btrfs_free_path(&path);
+	__btrfs_free_path(&path);
 	return res;
 }
 
 int btrfs_readlink(const struct btrfs_root *root, u64 inr, char *target)
 {
-	struct btrfs_path path;
+	struct __btrfs_path path;
 	struct btrfs_key key;
 	struct btrfs_file_extent_item *extent;
 	const char *data_ptr;
@@ -131,7 +131,7 @@ int btrfs_readlink(const struct btrfs_root *root, u64 inr, char *target)
 	target[extent->ram_bytes] = '\0';
 	res = 0;
 out:
-	btrfs_free_path(&path);
+	__btrfs_free_path(&path);
 	return res;
 }
 
@@ -320,7 +320,7 @@ u64 btrfs_lookup_path(struct btrfs_root *root, u64 inr, const char *path,
 u64 btrfs_file_read(const struct btrfs_root *root, u64 inr, u64 offset,
 		    u64 size, char *buf)
 {
-	struct btrfs_path path;
+	struct __btrfs_path path;
 	struct btrfs_key key;
 	struct btrfs_file_extent_item *extent;
 	int res = 0;
@@ -379,6 +379,6 @@ u64 btrfs_file_read(const struct btrfs_root *root, u64 inr, u64 offset,
 		return -1ULL;
 
 out:
-	btrfs_free_path(&path);
+	__btrfs_free_path(&path);
 	return rd_all;
 }
diff --git a/fs/btrfs/root.c b/fs/btrfs/root.c
index 61155e8918b8..9b5f645015ae 100644
--- a/fs/btrfs/root.c
+++ b/fs/btrfs/root.c
@@ -7,7 +7,7 @@
 
 #include "btrfs.h"
 
-static void read_root_item(struct btrfs_path *p, struct btrfs_root_item *item)
+static void read_root_item(struct __btrfs_path *p, struct btrfs_root_item *item)
 {
 	u32 len;
 	int reset = 0;
@@ -34,7 +34,7 @@ static void read_root_item(struct btrfs_path *p, struct btrfs_root_item *item)
 int btrfs_find_root(u64 objectid, struct btrfs_root *root,
 		    struct btrfs_root_item *root_item)
 {
-	struct btrfs_path path;
+	struct __btrfs_path path;
 	struct btrfs_root_item my_root_item;
 
 	if (!btrfs_search_tree_key_type(&btrfs_info.tree_root, objectid,
@@ -51,13 +51,13 @@ int btrfs_find_root(u64 objectid, struct btrfs_root *root,
 		root->root_dirid = root_item->root_dirid;
 	}
 
-	btrfs_free_path(&path);
+	__btrfs_free_path(&path);
 	return 0;
 }
 
 u64 btrfs_lookup_root_ref(u64 subvolid, struct btrfs_root_ref *refp, char *name)
 {
-	struct btrfs_path path;
+	struct __btrfs_path path;
 	struct btrfs_key *key;
 	struct btrfs_root_ref *ref;
 	u64 res = -1ULL;
@@ -86,7 +86,7 @@ u64 btrfs_lookup_root_ref(u64 subvolid, struct btrfs_root_ref *refp, char *name)
 
 	res = key->offset;
 out:
-	btrfs_free_path(&path);
+	__btrfs_free_path(&path);
 	return res;
 }
 
diff --git a/fs/btrfs/subvolume.c b/fs/btrfs/subvolume.c
index dbe92d13cb81..fa5ef1e0acb7 100644
--- a/fs/btrfs/subvolume.c
+++ b/fs/btrfs/subvolume.c
@@ -81,7 +81,7 @@ u64 btrfs_get_default_subvol_objectid(void)
 static void list_subvols(u64 tree, char *nameptr, int max_name_len, int level)
 {
 	struct btrfs_key key, *found_key;
-	struct btrfs_path path;
+	struct __btrfs_path path;
 	struct btrfs_root_ref *ref;
 	int res;
 
@@ -116,7 +116,7 @@ static void list_subvols(u64 tree, char *nameptr, int max_name_len, int level)
 			       "subvolumes\n", __func__);
 	} while (!(res = btrfs_next_slot(&path)));
 
-	btrfs_free_path(&path);
+	__btrfs_free_path(&path);
 }
 
 void btrfs_list_subvols(void)
-- 
2.26.2

