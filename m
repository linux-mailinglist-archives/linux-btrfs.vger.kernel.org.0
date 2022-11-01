Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDA97614EFD
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Nov 2022 17:16:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230396AbiKAQQM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 1 Nov 2022 12:16:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230392AbiKAQQJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 1 Nov 2022 12:16:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A046D1C914
        for <linux-btrfs@vger.kernel.org>; Tue,  1 Nov 2022 09:16:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 72E496118E
        for <linux-btrfs@vger.kernel.org>; Tue,  1 Nov 2022 16:16:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 641A6C43470
        for <linux-btrfs@vger.kernel.org>; Tue,  1 Nov 2022 16:16:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667319366;
        bh=xqa5zA8sPG37wW1NEo1dx9z1z0a0+tQeLEzmy+TfNeA=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=mWde60vQAvpm4FQUL3V3+uyUsfHze6v0KbSXagpEnYjFqCZpvHBURGUTgyMzyoV0u
         uM41MEPXF6sfLXt7alN6i+KbcP6dWqRXDx/nAqcpwP2sBx5tCwf4onUYKqFLVWdzEs
         7v15Ou+k7Qcek0hP3gTiBicb+d3Qf4sdNoK5jqQ4p78t3AQr2b7Lv5VY77FHGHa+Y4
         +4/vfpdrWLJqwixUR7O7gWvG+hNTVjGZGvNCfX7MSzsTioeV4oN+IanfWxeKG2qXJE
         rnziUdRW5CO1zTAfvzfKcWRlDrh+L5tLX2MdDoChOeNUwd664Acf59psRVjd+OOOBX
         GJjox0nppN+RA==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 10/18] btrfs: use a single argument for extent offset in backref walking functions
Date:   Tue,  1 Nov 2022 16:15:46 +0000
Message-Id: <3b49911721081d38fa62ff5a156d037ebd733a5e.1667315100.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1667315100.git.fdmanana@suse.com>
References: <cover.1667315100.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

The interface for find_parent_nodes() has two extent offset related
arguments:

1) One u64 pointer argument for the extent offset;

2) One boolean argument to tell if the extent offset should be ignored or
   not.

These are confusing, becase the extent offset pointer can be NULL and in
some cases callers pass a NULL value as a way to tell the backref walking
code to ignore offsets in file extent items (and simply consider all file
extent items that point to the target data extent).

The boolean argument was added in commit c995ab3cda3f ("btrfs: add a flag
to iterate_inodes_from_logical to find all extent refs for uncompressed
extents"), but it was never really necessary, it was enough if it could
find a way to get a NULL value passed to the "extent_item_pos" argument of
find_parent_nodes(). The arguments are also passed to functions called
by find_parent_nodes() and respective helper functions, which further
makes everything more complicated than needed.

Then we have several backref walking related functions that end up calling
find_parent_nodes(), either directly or through some other function that
they call, and for many we have to use an "extent_item_pos" (u64) argument
and a boolean "ignore_offset" argument too.

This is confusing and not really necessary. So use a single argument to
specify the extent offset, as a simple u64 and not as a pointer, but
using a special value of (u64)-1, defined as a documented constant, to
indicate when the extent offset should be ignored.

This is also preparation work for the upcoming patches in the series that
add other arguments to find_parent_nodes() and other related functions
that use it.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/backref.c    | 87 +++++++++++++++++++++----------------------
 fs/btrfs/backref.h    | 12 ++++--
 fs/btrfs/relocation.c |  2 +-
 fs/btrfs/scrub.c      |  2 +-
 fs/btrfs/send.c       |  2 +-
 5 files changed, 54 insertions(+), 51 deletions(-)

diff --git a/fs/btrfs/backref.c b/fs/btrfs/backref.c
index 9be11a342de5..432064ee788e 100644
--- a/fs/btrfs/backref.c
+++ b/fs/btrfs/backref.c
@@ -35,15 +35,13 @@ static int check_extent_in_eb(const struct btrfs_key *key,
 			      const struct extent_buffer *eb,
 			      const struct btrfs_file_extent_item *fi,
 			      u64 extent_item_pos,
-			      struct extent_inode_elem **eie,
-			      bool ignore_offset)
+			      struct extent_inode_elem **eie)
 {
 	const u64 data_len = btrfs_file_extent_num_bytes(eb, fi);
 	u64 offset = 0;
 	struct extent_inode_elem *e;
 
-	if (!ignore_offset &&
-	    !btrfs_file_extent_compression(eb, fi) &&
+	if (!btrfs_file_extent_compression(eb, fi) &&
 	    !btrfs_file_extent_encryption(eb, fi) &&
 	    !btrfs_file_extent_other_encoding(eb, fi)) {
 		u64 data_offset;
@@ -81,8 +79,7 @@ static void free_inode_elem_list(struct extent_inode_elem *eie)
 
 static int find_extent_in_eb(const struct extent_buffer *eb,
 			     u64 wanted_disk_byte, u64 extent_item_pos,
-			     struct extent_inode_elem **eie,
-			     bool ignore_offset)
+			     struct extent_inode_elem **eie)
 {
 	u64 disk_byte;
 	struct btrfs_key key;
@@ -111,7 +108,7 @@ static int find_extent_in_eb(const struct extent_buffer *eb,
 		if (disk_byte != wanted_disk_byte)
 			continue;
 
-		ret = check_extent_in_eb(&key, eb, fi, extent_item_pos, eie, ignore_offset);
+		ret = check_extent_in_eb(&key, eb, fi, extent_item_pos, eie);
 		if (ret < 0)
 			return ret;
 	}
@@ -450,9 +447,9 @@ static int is_shared_data_backref(struct preftrees *preftrees, u64 bytenr)
 static int add_all_parents(struct btrfs_root *root, struct btrfs_path *path,
 			   struct ulist *parents,
 			   struct preftrees *preftrees, struct prelim_ref *ref,
-			   int level, u64 time_seq, const u64 *extent_item_pos,
-			   bool ignore_offset)
+			   int level, u64 time_seq, u64 extent_item_pos)
 {
+	const bool ignore_offset = (extent_item_pos == BTRFS_IGNORE_EXTENT_OFFSET);
 	int ret = 0;
 	int slot;
 	struct extent_buffer *eb;
@@ -528,10 +525,9 @@ static int add_all_parents(struct btrfs_root *root, struct btrfs_path *path,
 				count++;
 			else
 				goto next;
-			if (extent_item_pos) {
+			if (!ignore_offset) {
 				ret = check_extent_in_eb(&key, eb, fi,
-						*extent_item_pos,
-						&eie, ignore_offset);
+							 extent_item_pos, &eie);
 				if (ret < 0)
 					break;
 			}
@@ -541,7 +537,7 @@ static int add_all_parents(struct btrfs_root *root, struct btrfs_path *path,
 						  eie, (void **)&old, GFP_NOFS);
 			if (ret < 0)
 				break;
-			if (!ret && extent_item_pos) {
+			if (!ret && !ignore_offset) {
 				while (old->next)
 					old = old->next;
 				old->next = eie;
@@ -570,7 +566,7 @@ static int resolve_indirect_ref(struct btrfs_fs_info *fs_info,
 				struct btrfs_path *path, u64 time_seq,
 				struct preftrees *preftrees,
 				struct prelim_ref *ref, struct ulist *parents,
-				const u64 *extent_item_pos, bool ignore_offset)
+				u64 extent_item_pos)
 {
 	struct btrfs_root *root;
 	struct extent_buffer *eb;
@@ -664,7 +660,7 @@ static int resolve_indirect_ref(struct btrfs_fs_info *fs_info,
 	}
 
 	ret = add_all_parents(root, path, parents, preftrees, ref, level,
-			      time_seq, extent_item_pos, ignore_offset);
+			      time_seq, extent_item_pos);
 out:
 	btrfs_put_root(root);
 out_free:
@@ -712,8 +708,8 @@ static void free_leaf_list(struct ulist *ulist)
 static int resolve_indirect_refs(struct btrfs_fs_info *fs_info,
 				 struct btrfs_path *path, u64 time_seq,
 				 struct preftrees *preftrees,
-				 const u64 *extent_item_pos,
-				 struct share_check *sc, bool ignore_offset)
+				 u64 extent_item_pos,
+				 struct share_check *sc)
 {
 	int err;
 	int ret = 0;
@@ -756,8 +752,7 @@ static int resolve_indirect_refs(struct btrfs_fs_info *fs_info,
 			goto out;
 		}
 		err = resolve_indirect_ref(fs_info, path, time_seq, preftrees,
-					   ref, parents, extent_item_pos,
-					   ignore_offset);
+					   ref, parents, extent_item_pos);
 		/*
 		 * we can only tolerate ENOENT,otherwise,we should catch error
 		 * and return directly.
@@ -1340,18 +1335,21 @@ static void store_backref_shared_cache(struct btrfs_backref_share_check_ctx *ctx
  *
  * Otherwise this returns 0 for success and <0 for an error.
  *
- * If ignore_offset is set to false, only extent refs whose offsets match
- * extent_item_pos are returned.  If true, every extent ref is returned
- * and extent_item_pos is ignored.
+ * @extent_item_pos is meaningful only if we are dealing with a data extent.
+ * If its value is not BTRFS_IGNORE_EXTENT_OFFSET, then only collect references
+ * from file extent items that refer to a section of the data extent that
+ * contains @extent_item_pos. If its value is BTRFS_IGNORE_EXTENT_OFFSET then
+ * collect references for every file extent item that points to the data extent.
  *
  * FIXME some caching might speed things up
  */
 static int find_parent_nodes(struct btrfs_trans_handle *trans,
 			     struct btrfs_fs_info *fs_info, u64 bytenr,
 			     u64 time_seq, struct ulist *refs,
-			     struct ulist *roots, const u64 *extent_item_pos,
-			     struct share_check *sc, bool ignore_offset)
+			     struct ulist *roots, u64 extent_item_pos,
+			     struct share_check *sc)
 {
+	const bool ignore_offset = (extent_item_pos == BTRFS_IGNORE_EXTENT_OFFSET);
 	struct btrfs_root *root = btrfs_extent_root(fs_info, bytenr);
 	struct btrfs_key key;
 	struct btrfs_path *path;
@@ -1539,7 +1537,7 @@ static int find_parent_nodes(struct btrfs_trans_handle *trans,
 	WARN_ON(!RB_EMPTY_ROOT(&preftrees.indirect_missing_keys.root.rb_root));
 
 	ret = resolve_indirect_refs(fs_info, path, time_seq, &preftrees,
-				    extent_item_pos, sc, ignore_offset);
+				    extent_item_pos, sc);
 	if (ret)
 		goto out;
 
@@ -1573,8 +1571,7 @@ static int find_parent_nodes(struct btrfs_trans_handle *trans,
 				goto out;
 		}
 		if (ref->count && ref->parent) {
-			if (extent_item_pos && !ref->inode_list &&
-			    ref->level == 0) {
+			if (!ignore_offset && !ref->inode_list && ref->level == 0) {
 				struct extent_buffer *eb;
 
 				eb = read_tree_block(fs_info, ref->parent, 0,
@@ -1592,7 +1589,7 @@ static int find_parent_nodes(struct btrfs_trans_handle *trans,
 				if (!path->skip_locking)
 					btrfs_tree_read_lock(eb);
 				ret = find_extent_in_eb(eb, bytenr,
-							*extent_item_pos, &eie, ignore_offset);
+							extent_item_pos, &eie);
 				if (!path->skip_locking)
 					btrfs_tree_read_unlock(eb);
 				free_extent_buffer(eb);
@@ -1611,7 +1608,7 @@ static int find_parent_nodes(struct btrfs_trans_handle *trans,
 						  (void **)&eie, GFP_NOFS);
 			if (ret < 0)
 				goto out;
-			if (!ret && extent_item_pos) {
+			if (!ret && !ignore_offset) {
 				/*
 				 * We've recorded that parent, so we must extend
 				 * its inode list here.
@@ -1665,7 +1662,7 @@ static int find_parent_nodes(struct btrfs_trans_handle *trans,
 int btrfs_find_all_leafs(struct btrfs_trans_handle *trans,
 			 struct btrfs_fs_info *fs_info, u64 bytenr,
 			 u64 time_seq, struct ulist **leafs,
-			 const u64 *extent_item_pos, bool ignore_offset)
+			 u64 extent_item_pos)
 {
 	int ret;
 
@@ -1674,7 +1671,7 @@ int btrfs_find_all_leafs(struct btrfs_trans_handle *trans,
 		return -ENOMEM;
 
 	ret = find_parent_nodes(trans, fs_info, bytenr, time_seq,
-				*leafs, NULL, extent_item_pos, NULL, ignore_offset);
+				*leafs, NULL, extent_item_pos, NULL);
 	if (ret < 0 && ret != -ENOENT) {
 		free_leaf_list(*leafs);
 		return ret;
@@ -1698,8 +1695,7 @@ int btrfs_find_all_leafs(struct btrfs_trans_handle *trans,
  */
 static int btrfs_find_all_roots_safe(struct btrfs_trans_handle *trans,
 				     struct btrfs_fs_info *fs_info, u64 bytenr,
-				     u64 time_seq, struct ulist **roots,
-				     bool ignore_offset)
+				     u64 time_seq, struct ulist **roots)
 {
 	struct ulist *tmp;
 	struct ulist_node *node = NULL;
@@ -1718,7 +1714,8 @@ static int btrfs_find_all_roots_safe(struct btrfs_trans_handle *trans,
 	ULIST_ITER_INIT(&uiter);
 	while (1) {
 		ret = find_parent_nodes(trans, fs_info, bytenr, time_seq,
-					tmp, *roots, NULL, NULL, ignore_offset);
+					tmp, *roots, BTRFS_IGNORE_EXTENT_OFFSET,
+					NULL);
 		if (ret < 0 && ret != -ENOENT) {
 			ulist_free(tmp);
 			ulist_free(*roots);
@@ -1745,8 +1742,7 @@ int btrfs_find_all_roots(struct btrfs_trans_handle *trans,
 
 	if (!trans && !skip_commit_root_sem)
 		down_read(&fs_info->commit_root_sem);
-	ret = btrfs_find_all_roots_safe(trans, fs_info, bytenr,
-					time_seq, roots, false);
+	ret = btrfs_find_all_roots_safe(trans, fs_info, bytenr, time_seq, roots);
 	if (!trans && !skip_commit_root_sem)
 		up_read(&fs_info->commit_root_sem);
 	return ret;
@@ -1845,7 +1841,7 @@ int btrfs_is_data_extent_shared(struct btrfs_inode *inode, u64 bytenr,
 		bool cached;
 
 		ret = find_parent_nodes(trans, fs_info, bytenr, elem.seq, &ctx->refs,
-					NULL, NULL, &shared, false);
+					NULL, BTRFS_IGNORE_EXTENT_OFFSET, &shared);
 		if (ret == BACKREF_FOUND_SHARED ||
 		    ret == BACKREF_FOUND_NOT_SHARED) {
 			/* If shared must return 1, otherwise return 0. */
@@ -2286,8 +2282,7 @@ static int iterate_leaf_refs(struct btrfs_fs_info *fs_info,
 int iterate_extent_inodes(struct btrfs_fs_info *fs_info,
 				u64 extent_item_objectid, u64 extent_item_pos,
 				int search_commit_root,
-				iterate_extent_inodes_t *iterate, void *ctx,
-				bool ignore_offset)
+				iterate_extent_inodes_t *iterate, void *ctx)
 {
 	int ret;
 	struct btrfs_trans_handle *trans = NULL;
@@ -2318,16 +2313,14 @@ int iterate_extent_inodes(struct btrfs_fs_info *fs_info,
 		down_read(&fs_info->commit_root_sem);
 
 	ret = btrfs_find_all_leafs(trans, fs_info, extent_item_objectid,
-				   seq_elem.seq, &refs,
-				   &extent_item_pos, ignore_offset);
+				   seq_elem.seq, &refs, extent_item_pos);
 	if (ret)
 		goto out;
 
 	ULIST_ITER_INIT(&ref_uiter);
 	while (!ret && (ref_node = ulist_next(refs, &ref_uiter))) {
 		ret = btrfs_find_all_roots_safe(trans, fs_info, ref_node->val,
-						seq_elem.seq, &roots,
-						ignore_offset);
+						seq_elem.seq, &roots);
 		if (ret)
 			break;
 		ULIST_ITER_INIT(&root_uiter);
@@ -2395,10 +2388,14 @@ int iterate_inodes_from_logical(u64 logical, struct btrfs_fs_info *fs_info,
 	if (flags & BTRFS_EXTENT_FLAG_TREE_BLOCK)
 		return -EINVAL;
 
-	extent_item_pos = logical - found_key.objectid;
+	if (ignore_offset)
+		extent_item_pos = BTRFS_IGNORE_EXTENT_OFFSET;
+	else
+		extent_item_pos = logical - found_key.objectid;
+
 	ret = iterate_extent_inodes(fs_info, found_key.objectid,
 					extent_item_pos, search_commit_root,
-					build_ino_list, ctx, ignore_offset);
+					build_ino_list, ctx);
 
 	return ret;
 }
diff --git a/fs/btrfs/backref.h b/fs/btrfs/backref.h
index 8d3598155f3b..2eb99f23cc8f 100644
--- a/fs/btrfs/backref.h
+++ b/fs/btrfs/backref.h
@@ -12,6 +12,13 @@
 #include "disk-io.h"
 #include "extent_io.h"
 
+/*
+ * Pass to backref walking functions to tell them to include references from
+ * all file extent items that point to the target data extent, regardless if
+ * they refer to the whole extent or just sections of it (bookend extents).
+ */
+#define BTRFS_IGNORE_EXTENT_OFFSET   ((u64)-1)
+
 struct inode_fs_paths {
 	struct btrfs_path		*btrfs_path;
 	struct btrfs_root		*fs_root;
@@ -92,8 +99,7 @@ int tree_backref_for_extent(unsigned long *ptr, struct extent_buffer *eb,
 int iterate_extent_inodes(struct btrfs_fs_info *fs_info,
 				u64 extent_item_objectid,
 				u64 extent_offset, int search_commit_root,
-				iterate_extent_inodes_t *iterate, void *ctx,
-				bool ignore_offset);
+				iterate_extent_inodes_t *iterate, void *ctx);
 
 int iterate_inodes_from_logical(u64 logical, struct btrfs_fs_info *fs_info,
 				struct btrfs_path *path, void *ctx,
@@ -104,7 +110,7 @@ int paths_from_inode(u64 inum, struct inode_fs_paths *ipath);
 int btrfs_find_all_leafs(struct btrfs_trans_handle *trans,
 			 struct btrfs_fs_info *fs_info, u64 bytenr,
 			 u64 time_seq, struct ulist **leafs,
-			 const u64 *extent_item_pos, bool ignore_offset);
+			 u64 extent_item_pos);
 int btrfs_find_all_roots(struct btrfs_trans_handle *trans,
 			 struct btrfs_fs_info *fs_info, u64 bytenr,
 			 u64 time_seq, struct ulist **roots,
diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index d119986d1599..45690f7b5900 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -3417,7 +3417,7 @@ int add_data_references(struct reloc_control *rc,
 
 	btrfs_release_path(path);
 	ret = btrfs_find_all_leafs(NULL, fs_info, extent_key->objectid,
-				   0, &leaves, NULL, true);
+				   0, &leaves, BTRFS_IGNORE_EXTENT_OFFSET);
 	if (ret < 0)
 		return ret;
 
diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index f9c58e39f7e1..dc178f59f34a 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -969,7 +969,7 @@ static void scrub_print_warning(const char *errstr, struct scrub_block *sblock)
 		swarn.dev = dev;
 		iterate_extent_inodes(fs_info, found_key.objectid,
 					extent_item_pos, 1,
-					scrub_print_warning_inode, &swarn, false);
+					scrub_print_warning_inode, &swarn);
 	}
 
 out:
diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index 4e175a8579ff..b6d9200af2e3 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -1467,7 +1467,7 @@ static int find_extent_clone(struct send_ctx *sctx,
 		extent_item_pos = 0;
 	ret = iterate_extent_inodes(fs_info, found_key.objectid,
 				    extent_item_pos, 1, __iterate_backrefs,
-				    &backref_ctx, false);
+				    &backref_ctx);
 
 	if (ret < 0)
 		goto out;
-- 
2.35.1

