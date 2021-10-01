Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FB7041EDDC
	for <lists+linux-btrfs@lfdr.de>; Fri,  1 Oct 2021 14:52:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231460AbhJAMyX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 1 Oct 2021 08:54:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:59988 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231458AbhJAMyW (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 1 Oct 2021 08:54:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 768BC61A8B
        for <linux-btrfs@vger.kernel.org>; Fri,  1 Oct 2021 12:52:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633092758;
        bh=KC808EPYIl0l3YYcE9/WlhH3gOCi/NN2UdBvjwZCMm4=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=hcYMwBpcazOty35PrJ1flOzDqGZDFpvx1rmymsWjyTdF9FIZjvoHiGXTZA1a0G5Jl
         jV8Gz1nuZl2LPiKcNiFetNe9om9dSOJUgZ5YgTumaEr8QJ7rXgZHT1eSeJ/Gpx7XOs
         BFNzcYrKXClVaCmWgnlfuAQO34Y0HJCJv3rG+/yukx1VdxH1TvaF7dGfUVtmSZy4Rg
         t2bMl9hfwOaJl8GUwgLSmk77/L5+J24+/dfPxKgIuOfQ2/GcN7krF6p4F4+fBqd0lH
         VHECi9GetowT0ZyneO8BvADYWx7ytn89OmoLIEqjbO80cJtVqu263Mge3m54STi/1b
         z1AdaKjrvD4Jg==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 4/4] btrfs: unify lookup return value when dir entry is missing
Date:   Fri,  1 Oct 2021 13:52:33 +0100
Message-Id: <017d760f34d1f85e8a8d0c8b6be6489b42c28998.1633082623.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1633082623.git.fdmanana@suse.com>
References: <cover.1633082623.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

btrfs_lookup_dir_index_item() and btrfs_lookup_dir_item() lookup for dir
entries and both are used during log replay or when updating a log tree
during an unlink.

However when the dir item does not exists, btrfs_lookup_dir_item() returns
NULL while btrfs_lookup_dir_index_item() returns PTR_ERR(-ENOENT), and if
the dir item exists but there is no matching entry for a given name or
index, both return NULL. This makes the call sites during log replay to
be more verbose than necessary and it makes it easy to miss this slight
difference. Since we don't need to distinguish between those two cases,
make btrfs_lookup_dir_index_item() always return NULL when there is no
matching directory entry - either because there isn't any dir entry or
because there is one but it does not match the given name and index.

Also rename the argument 'objectid' of btrfs_lookup_dir_index_item() to
'index' since it is supposed to match an index number, and the name
'objectid' is not very good because it can easily be confused with an
inode number (like the inode number a dir entry points to).

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/ctree.h    |  2 +-
 fs/btrfs/dir-item.c | 48 ++++++++++++++++++++++++++++++++++-----------
 fs/btrfs/tree-log.c | 14 ++++---------
 3 files changed, 42 insertions(+), 22 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 400ce90efbb0..ad674f092b4e 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -3075,7 +3075,7 @@ struct btrfs_dir_item *
 btrfs_lookup_dir_index_item(struct btrfs_trans_handle *trans,
 			    struct btrfs_root *root,
 			    struct btrfs_path *path, u64 dir,
-			    u64 objectid, const char *name, int name_len,
+			    u64 index, const char *name, int name_len,
 			    int mod);
 struct btrfs_dir_item *
 btrfs_search_dir_index_item(struct btrfs_root *root,
diff --git a/fs/btrfs/dir-item.c b/fs/btrfs/dir-item.c
index f1274d5c3805..7721ce0c0604 100644
--- a/fs/btrfs/dir-item.c
+++ b/fs/btrfs/dir-item.c
@@ -190,9 +190,20 @@ static struct btrfs_dir_item *btrfs_lookup_match_dir(
 }
 
 /*
- * lookup a directory item based on name.  'dir' is the objectid
- * we're searching in, and 'mod' tells us if you plan on deleting the
- * item (use mod < 0) or changing the options (use mod > 0)
+ * Lookup for a directory item by name.
+ *
+ * @trans:	The transaction handle to use. Can be NULL if @mod is 0.
+ * @root:	The root of the target tree.
+ * @path:	Path to use for the search.
+ * @dir:	The inode number (objectid) of the directory.
+ * @name:	The name associated to the directory entry we are looking for.
+ * @name_len:	The length of the name.
+ * @mod:	Used to indicate if the tree search is meant for a read only
+ *		lookup, for a modification lookup or for a deletion lookup, so
+ *		its value should be 0, 1 or -1, respectively.
+ *
+ * Returns: NULL if the dir item does not exists, an error pointer if an error
+ * happened, or a pointer to a dir item if a dir item exists for the given name.
  */
 struct btrfs_dir_item *btrfs_lookup_dir_item(struct btrfs_trans_handle *trans,
 					     struct btrfs_root *root,
@@ -273,27 +284,42 @@ int btrfs_check_dir_item_collision(struct btrfs_root *root, u64 dir,
 }
 
 /*
- * lookup a directory item based on index.  'dir' is the objectid
- * we're searching in, and 'mod' tells us if you plan on deleting the
- * item (use mod < 0) or changing the options (use mod > 0)
+ * Lookup for a directory index item by name and index number.
  *
- * The name is used to make sure the index really points to the name you were
- * looking for.
+ * @trans:	The transaction handle to use. Can be NULL if @mod is 0.
+ * @root:	The root of the target tree.
+ * @path:	Path to use for the search.
+ * @dir:	The inode number (objectid) of the directory.
+ * @index:	The index number.
+ * @name:	The name associated to the directory entry we are looking for.
+ * @name_len:	The length of the name.
+ * @mod:	Used to indicate if the tree search is meant for a read only
+ *		lookup, for a modification lookup or for a deletion lookup, so
+ *		its value should be 0, 1 or -1, respectively.
+ *
+ * Returns: NULL if the dir index item does not exists, an error pointer if an
+ * error happened, or a pointer to a dir item if the dir index item exists and
+ * matches the criteria (name and index number).
  */
 struct btrfs_dir_item *
 btrfs_lookup_dir_index_item(struct btrfs_trans_handle *trans,
 			    struct btrfs_root *root,
 			    struct btrfs_path *path, u64 dir,
-			    u64 objectid, const char *name, int name_len,
+			    u64 index, const char *name, int name_len,
 			    int mod)
 {
+	struct btrfs_dir_item *di;
 	struct btrfs_key key;
 
 	key.objectid = dir;
 	key.type = BTRFS_DIR_INDEX_KEY;
-	key.offset = objectid;
+	key.offset = index;
 
-	return btrfs_lookup_match_dir(trans, root, path, &key, name, name_len, mod);
+	di = btrfs_lookup_match_dir(trans, root, path, &key, name, name_len, mod);
+	if (di == ERR_PTR(-ENOENT))
+		return NULL;
+
+	return di;
 }
 
 struct btrfs_dir_item *
diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 0091ec39f57c..68d92835dd0f 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -985,8 +985,7 @@ static noinline int inode_in_dir(struct btrfs_root *root,
 	di = btrfs_lookup_dir_index_item(NULL, root, path, dirid,
 					 index, name, name_len, 0);
 	if (IS_ERR(di)) {
-		if (PTR_ERR(di) != -ENOENT)
-			ret = PTR_ERR(di);
+		ret = PTR_ERR(di);
 		goto out;
 	} else if (di) {
 		btrfs_dir_item_key_to_cpu(path->nodes[0], di, &location);
@@ -1219,8 +1218,7 @@ static inline int __add_inode_ref(struct btrfs_trans_handle *trans,
 	di = btrfs_lookup_dir_index_item(trans, root, path, btrfs_ino(dir),
 					 ref_index, name, namelen, 0);
 	if (IS_ERR(di)) {
-		if (PTR_ERR(di) != -ENOENT)
-			return PTR_ERR(di);
+		return PTR_ERR(di);
 	} else if (di) {
 		ret = drop_one_dir_item(trans, root, path, dir, di);
 		if (ret)
@@ -2022,9 +2020,6 @@ static noinline int replay_one_name(struct btrfs_trans_handle *trans,
 		goto out;
 	}
 
-	if (dst_di == ERR_PTR(-ENOENT))
-		dst_di = NULL;
-
 	if (IS_ERR(dst_di)) {
 		ret = PTR_ERR(dst_di);
 		goto out;
@@ -2332,7 +2327,7 @@ static noinline int check_item_in_log(struct btrfs_trans_handle *trans,
 						     dir_key->offset,
 						     name, name_len, 0);
 		}
-		if (!log_di || log_di == ERR_PTR(-ENOENT)) {
+		if (!log_di) {
 			btrfs_dir_item_key_to_cpu(eb, di, &location);
 			btrfs_release_path(path);
 			btrfs_release_path(log_path);
@@ -3591,8 +3586,7 @@ int btrfs_del_dir_entries_in_log(struct btrfs_trans_handle *trans,
 	if (err == -ENOSPC) {
 		btrfs_set_log_full_commit(trans);
 		err = 0;
-	} else if (err < 0 && err != -ENOENT) {
-		/* ENOENT can be returned if the entry hasn't been fsynced yet */
+	} else if (err < 0) {
 		btrfs_abort_transaction(trans, err);
 	}
 
-- 
2.33.0

