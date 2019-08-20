Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EC315966F5
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Aug 2019 18:58:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730273AbfHTQ6Y (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 20 Aug 2019 12:58:24 -0400
Received: from mx2.suse.de ([195.135.220.15]:39440 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730232AbfHTQ6Y (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 20 Aug 2019 12:58:24 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B5FBBAEE0
        for <linux-btrfs@vger.kernel.org>; Tue, 20 Aug 2019 16:58:22 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 1CA34DA7DA; Tue, 20 Aug 2019 18:58:49 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 3/3] btrfs: tie extent buffer and it's token together
Date:   Tue, 20 Aug 2019 18:58:49 +0200
Message-Id: <70782d343acc8cd87a329a564fd6413c3e440cc4.1566320094.git.dsterba@suse.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <cover.1566320094.git.dsterba@suse.com>
References: <cover.1566320094.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Further simplifaction of the get/set helpers is possible when the token
is uniquely tied to an extent buffer. A condition and an assignment can
be avoided.

The initializations are moved closer to the first use when the extent
buffer is valid. There's one exception in __push_leaf_left where the
token is reused.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/ctree.c        | 27 +++++++++++----------------
 fs/btrfs/ctree.h        |  4 +++-
 fs/btrfs/inode.c        |  2 +-
 fs/btrfs/struct-funcs.c |  6 ++----
 fs/btrfs/tree-log.c     |  7 +++----
 5 files changed, 20 insertions(+), 26 deletions(-)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index a2f3cd7a619c..7dbd2341967c 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -3574,7 +3574,7 @@ static int leaf_space_used(struct extent_buffer *l, int start, int nr)
 
 	if (!nr)
 		return 0;
-	btrfs_init_map_token(&token);
+	btrfs_init_map_token(&token, l);
 	start_item = btrfs_item_nr(start);
 	end_item = btrfs_item_nr(end);
 	data_len = btrfs_token_item_offset(l, start_item, &token) +
@@ -3632,8 +3632,6 @@ static noinline int __push_leaf_right(struct btrfs_path *path,
 	u32 data_end;
 	u32 this_item_size;
 
-	btrfs_init_map_token(&token);
-
 	if (empty)
 		nr = 0;
 	else
@@ -3706,6 +3704,7 @@ static noinline int __push_leaf_right(struct btrfs_path *path,
 		   push_items * sizeof(struct btrfs_item));
 
 	/* update the item pointers */
+	btrfs_init_map_token(&token, right);
 	right_nritems += push_items;
 	btrfs_set_header_nritems(right, right_nritems);
 	push_space = BTRFS_LEAF_DATA_SIZE(fs_info);
@@ -3860,8 +3859,6 @@ static noinline int __push_leaf_left(struct btrfs_path *path, int data_size,
 	u32 old_left_item_size;
 	struct btrfs_map_token token;
 
-	btrfs_init_map_token(&token);
-
 	if (empty)
 		nr = min(right_nritems, max_slot);
 	else
@@ -3915,6 +3912,7 @@ static noinline int __push_leaf_left(struct btrfs_path *path, int data_size,
 	old_left_nritems = btrfs_header_nritems(left);
 	BUG_ON(old_left_nritems <= 0);
 
+	btrfs_init_map_token(&token, left);
 	old_left_item_size = btrfs_item_offset_nr(left, old_left_nritems - 1);
 	for (i = old_left_nritems; i < old_left_nritems + push_items; i++) {
 		u32 ioff;
@@ -3946,6 +3944,8 @@ static noinline int __push_leaf_left(struct btrfs_path *path, int data_size,
 			     (btrfs_header_nritems(right) - push_items) *
 			     sizeof(struct btrfs_item));
 	}
+
+	btrfs_init_map_token(&token, right);
 	right_nritems -= push_items;
 	btrfs_set_header_nritems(right, right_nritems);
 	push_space = BTRFS_LEAF_DATA_SIZE(fs_info);
@@ -4076,8 +4076,6 @@ static noinline void copy_for_split(struct btrfs_trans_handle *trans,
 	struct btrfs_disk_key disk_key;
 	struct btrfs_map_token token;
 
-	btrfs_init_map_token(&token);
-
 	nritems = nritems - mid;
 	btrfs_set_header_nritems(right, nritems);
 	data_copy_size = btrfs_item_end_nr(l, mid) - leaf_data_end(l);
@@ -4093,6 +4091,7 @@ static noinline void copy_for_split(struct btrfs_trans_handle *trans,
 
 	rt_data_off = BTRFS_LEAF_DATA_SIZE(fs_info) - btrfs_item_end_nr(l, mid);
 
+	btrfs_init_map_token(&token, right);
 	for (i = 0; i < nritems; i++) {
 		struct btrfs_item *item = btrfs_item_nr(i);
 		u32 ioff;
@@ -4576,8 +4575,6 @@ void btrfs_truncate_item(struct btrfs_path *path, u32 new_size, int from_end)
 	int i;
 	struct btrfs_map_token token;
 
-	btrfs_init_map_token(&token);
-
 	leaf = path->nodes[0];
 	slot = path->slots[0];
 
@@ -4599,6 +4596,7 @@ void btrfs_truncate_item(struct btrfs_path *path, u32 new_size, int from_end)
 	 * item0..itemN ... dataN.offset..dataN.size .. data0.size
 	 */
 	/* first correct the data pointers */
+	btrfs_init_map_token(&token, leaf);
 	for (i = slot; i < nritems; i++) {
 		u32 ioff;
 		item = btrfs_item_nr(i);
@@ -4673,8 +4671,6 @@ void btrfs_extend_item(struct btrfs_path *path, u32 data_size)
 	int i;
 	struct btrfs_map_token token;
 
-	btrfs_init_map_token(&token);
-
 	leaf = path->nodes[0];
 
 	nritems = btrfs_header_nritems(leaf);
@@ -4699,6 +4695,7 @@ void btrfs_extend_item(struct btrfs_path *path, u32 data_size)
 	 * item0..itemN ... dataN.offset..dataN.size .. data0.size
 	 */
 	/* first correct the data pointers */
+	btrfs_init_map_token(&token, leaf);
 	for (i = slot; i < nritems; i++) {
 		u32 ioff;
 		item = btrfs_item_nr(i);
@@ -4750,8 +4747,6 @@ void setup_items_for_insert(struct btrfs_root *root, struct btrfs_path *path,
 	}
 	btrfs_unlock_up_safe(path, 1);
 
-	btrfs_init_map_token(&token);
-
 	leaf = path->nodes[0];
 	slot = path->slots[0];
 
@@ -4765,6 +4760,7 @@ void setup_items_for_insert(struct btrfs_root *root, struct btrfs_path *path,
 		BUG();
 	}
 
+	btrfs_init_map_token(&token, leaf);
 	if (slot != nritems) {
 		unsigned int old_data = btrfs_item_end_nr(leaf, slot);
 
@@ -4971,9 +4967,6 @@ int btrfs_del_items(struct btrfs_trans_handle *trans, struct btrfs_root *root,
 	int wret;
 	int i;
 	u32 nritems;
-	struct btrfs_map_token token;
-
-	btrfs_init_map_token(&token);
 
 	leaf = path->nodes[0];
 	last_off = btrfs_item_offset_nr(leaf, slot + nr - 1);
@@ -4985,12 +4978,14 @@ int btrfs_del_items(struct btrfs_trans_handle *trans, struct btrfs_root *root,
 
 	if (slot + nr != nritems) {
 		int data_end = leaf_data_end(leaf);
+		struct btrfs_map_token token;
 
 		memmove_extent_buffer(leaf, BTRFS_LEAF_DATA_OFFSET +
 			      data_end + dsize,
 			      BTRFS_LEAF_DATA_OFFSET + data_end,
 			      last_off - data_end);
 
+		btrfs_init_map_token(&token, leaf);
 		for (i = slot + nr; i < nritems; i++) {
 			u32 ioff;
 
diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 74233b193e89..b5fc948fdfce 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -1332,8 +1332,10 @@ struct btrfs_map_token {
 #define BTRFS_BYTES_TO_BLKS(fs_info, bytes) \
 				((bytes) >> (fs_info)->sb->s_blocksize_bits)
 
-static inline void btrfs_init_map_token (struct btrfs_map_token *token)
+static inline void btrfs_init_map_token(struct btrfs_map_token *token,
+					struct extent_buffer *eb)
 {
+	token->eb = eb;
 	token->kaddr = NULL;
 }
 
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index c094c7977b93..7e77c2ef076a 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -3831,7 +3831,7 @@ static void fill_inode_item(struct btrfs_trans_handle *trans,
 {
 	struct btrfs_map_token token;
 
-	btrfs_init_map_token(&token);
+	btrfs_init_map_token(&token, leaf);
 
 	btrfs_set_token_inode_uid(leaf, item, i_uid_read(inode), &token);
 	btrfs_set_token_inode_gid(leaf, item, i_gid_read(inode), &token);
diff --git a/fs/btrfs/struct-funcs.c b/fs/btrfs/struct-funcs.c
index 3a29b911d2e2..73f7987143df 100644
--- a/fs/btrfs/struct-funcs.c
+++ b/fs/btrfs/struct-funcs.c
@@ -53,9 +53,9 @@ u##bits btrfs_get_token_##bits(const struct extent_buffer *eb,		\
 	u##bits res;							\
 									\
 	ASSERT(token);							\
+	ASSERT(token->eb == eb);					\
 									\
 	if (token->kaddr && token->offset <= offset &&			\
-	    token->eb == eb &&						\
 	   (token->offset + PAGE_SIZE >= offset + size)) {	\
 		kaddr = token->kaddr;					\
 		p = kaddr + part_offset - token->offset;		\
@@ -74,7 +74,6 @@ u##bits btrfs_get_token_##bits(const struct extent_buffer *eb,		\
 	res = get_unaligned_le##bits(p + off);				\
 	token->kaddr = kaddr;						\
 	token->offset = map_start;					\
-	token->eb = eb;							\
 	return res;							\
 }									\
 u##bits btrfs_get_##bits(const struct extent_buffer *eb,		\
@@ -117,9 +116,9 @@ void btrfs_set_token_##bits(struct extent_buffer *eb,			\
 	int size = sizeof(u##bits);					\
 									\
 	ASSERT(token);							\
+	ASSERT(token->eb == eb);					\
 									\
 	if (token->kaddr && token->offset <= offset &&			\
-	    token->eb == eb &&						\
 	   (token->offset + PAGE_SIZE >= offset + size)) {	\
 		kaddr = token->kaddr;					\
 		p = kaddr + part_offset - token->offset;		\
@@ -139,7 +138,6 @@ void btrfs_set_token_##bits(struct extent_buffer *eb,			\
 	put_unaligned_le##bits(val, p + off);				\
 	token->kaddr = kaddr;						\
 	token->offset = map_start;					\
-	token->eb = eb;							\
 }									\
 void btrfs_set_##bits(struct extent_buffer *eb, void *ptr,		\
 		      unsigned long off, u##bits val)			\
diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 19a4b9dc669f..fdc52daf1baf 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -505,7 +505,7 @@ static noinline int overwrite_item(struct btrfs_trans_handle *trans,
 			    ino_size != 0) {
 				struct btrfs_map_token token;
 
-				btrfs_init_map_token(&token);
+				btrfs_init_map_token(&token, dst_eb);
 				btrfs_set_token_inode_size(dst_eb, dst_item,
 							   ino_size, &token);
 			}
@@ -3842,7 +3842,7 @@ static void fill_inode_item(struct btrfs_trans_handle *trans,
 {
 	struct btrfs_map_token token;
 
-	btrfs_init_map_token(&token);
+	btrfs_init_map_token(&token, leaf);
 
 	if (log_inode_only) {
 		/* set the generation to zero so the recover code
@@ -4302,8 +4302,6 @@ static int log_one_extent(struct btrfs_trans_handle *trans,
 	if (ret)
 		return ret;
 
-	btrfs_init_map_token(&token);
-
 	ret = __btrfs_drop_extents(trans, log, &inode->vfs_inode, path, em->start,
 				   em->start + em->len, NULL, 0, 1,
 				   sizeof(*fi), &extent_inserted);
@@ -4321,6 +4319,7 @@ static int log_one_extent(struct btrfs_trans_handle *trans,
 			return ret;
 	}
 	leaf = path->nodes[0];
+	btrfs_init_map_token(&token, leaf);
 	fi = btrfs_item_ptr(leaf, path->slots[0],
 			    struct btrfs_file_extent_item);
 
-- 
2.22.0

