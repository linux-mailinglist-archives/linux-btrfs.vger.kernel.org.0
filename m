Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBB741D06FE
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 May 2020 08:16:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729385AbgEMGQY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 13 May 2020 02:16:24 -0400
Received: from mx2.suse.de ([195.135.220.15]:33970 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729339AbgEMGQX (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 13 May 2020 02:16:23 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 86F25AFE8
        for <linux-btrfs@vger.kernel.org>; Wed, 13 May 2020 06:16:24 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 2/2] btrfs: Don't set SHAREABLE flag for data reloc tree
Date:   Wed, 13 May 2020 14:16:11 +0800
Message-Id: <20200513061611.111807-3-wqu@suse.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200513061611.111807-1-wqu@suse.com>
References: <20200513061611.111807-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

SHAREABLE flag is set for subvolumes because users can create snapshot
for subvolumes, thus sharing tree blocks of them.

But users can't access data reloc tree as it's only an internal tree for
data relocation, thus it doesn't need the full path replacement treat at
all.

This patch will make data reloc tree just a non-shareable tree, and add
btrfs_fs_info::dreloc_root for data reloc tree, so relocation code can
grab it from fs_info directly.

This would slightly improve tree relocation, as now data reloc tree
can go through regular COW routine to get relocated, without bothering
the complex tree reloc tree routine.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/ctree.h      |  1 +
 fs/btrfs/disk-io.c    | 14 +++++++++++++-
 fs/btrfs/inode.c      |  7 ++++---
 fs/btrfs/relocation.c | 18 ++++--------------
 4 files changed, 22 insertions(+), 18 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 65c09aea4cb9..a9690f438a15 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -582,6 +582,7 @@ struct btrfs_fs_info {
 	struct btrfs_root *quota_root;
 	struct btrfs_root *uuid_root;
 	struct btrfs_root *free_space_root;
+	struct btrfs_root *dreloc_root;
 
 	/* the log root tree is a directory of all the other log roots */
 	struct btrfs_root *log_root_tree;
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 4dd3206c1ace..7355ebc648c5 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -1419,7 +1419,8 @@ static int btrfs_init_fs_root(struct btrfs_root *root)
 	if (ret)
 		goto fail;
 
-	if (root->root_key.objectid != BTRFS_TREE_LOG_OBJECTID) {
+	if (root->root_key.objectid != BTRFS_TREE_LOG_OBJECTID &&
+	    root->root_key.objectid != BTRFS_DATA_RELOC_TREE_OBJECTID) {
 		set_bit(BTRFS_ROOT_SHAREABLE, &root->state);
 		btrfs_check_and_init_root_item(&root->root_item);
 	}
@@ -1525,6 +1526,7 @@ void btrfs_free_fs_info(struct btrfs_fs_info *fs_info)
 	btrfs_put_root(fs_info->uuid_root);
 	btrfs_put_root(fs_info->free_space_root);
 	btrfs_put_root(fs_info->fs_root);
+	btrfs_put_root(fs_info->dreloc_root);
 	btrfs_check_leaked_roots(fs_info);
 	btrfs_extent_buffer_leak_debug_check(fs_info);
 	kfree(fs_info->super_copy);
@@ -1981,6 +1983,7 @@ static void free_root_pointers(struct btrfs_fs_info *info, bool free_chunk_root)
 	free_root_extent_buffers(info->quota_root);
 	free_root_extent_buffers(info->uuid_root);
 	free_root_extent_buffers(info->fs_root);
+	free_root_extent_buffers(info->dreloc_root);
 	if (free_chunk_root)
 		free_root_extent_buffers(info->chunk_root);
 	free_root_extent_buffers(info->free_space_root);
@@ -2287,6 +2290,15 @@ static int btrfs_read_roots(struct btrfs_fs_info *fs_info)
 	set_bit(BTRFS_ROOT_TRACK_DIRTY, &root->state);
 	fs_info->csum_root = root;
 
+	location.objectid = BTRFS_DATA_RELOC_TREE_OBJECTID;
+	root = btrfs_get_fs_root(fs_info, &location, true);
+	if (IS_ERR(root)) {
+		ret = PTR_ERR(root);
+		goto out;
+	}
+	set_bit(BTRFS_ROOT_TRACK_DIRTY, &root->state);
+	fs_info->dreloc_root = root;
+
 	location.objectid = BTRFS_QUOTA_TREE_OBJECTID;
 	root = btrfs_read_tree_root(tree_root, &location);
 	if (!IS_ERR(root)) {
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 13bbb6b0d495..6b7ba20eee52 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -4133,7 +4133,7 @@ int btrfs_truncate_inode_items(struct btrfs_trans_handle *trans,
 	 * inode.
 	 */
 	if (test_bit(BTRFS_ROOT_SHAREABLE, &root->state) ||
-	    root == fs_info->tree_root)
+	    root == fs_info->tree_root || root == fs_info->dreloc_root)
 		btrfs_drop_extent_cache(BTRFS_I(inode), ALIGN(new_size,
 					fs_info->sectorsize),
 					(u64)-1, 0);
@@ -4338,7 +4338,8 @@ int btrfs_truncate_inode_items(struct btrfs_trans_handle *trans,
 
 		if (found_extent &&
 		    (test_bit(BTRFS_ROOT_SHAREABLE, &root->state) ||
-		     root == fs_info->tree_root)) {
+		     root == fs_info->tree_root ||
+		     root == fs_info->dreloc_root)) {
 			struct btrfs_ref ref = { 0 };
 
 			bytes_deleted += extent_num_bytes;
@@ -5046,7 +5047,7 @@ void btrfs_evict_inode(struct inode *inode)
 		btrfs_end_transaction(trans);
 	}
 
-	if (!(root == fs_info->tree_root ||
+	if (!(root == fs_info->tree_root || root == fs_info->dreloc_root ||
 	      root->root_key.objectid == BTRFS_TREE_RELOC_OBJECTID))
 		btrfs_return_ino(root, btrfs_ino(BTRFS_I(inode)));
 
diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 437b782c57e6..cb45ae92f15d 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -1087,7 +1087,8 @@ int replace_file_extents(struct btrfs_trans_handle *trans,
 		 * if we are modifying block in fs tree, wait for readpage
 		 * to complete and drop the extent cache
 		 */
-		if (root->root_key.objectid != BTRFS_TREE_RELOC_OBJECTID) {
+		if (root->root_key.objectid != BTRFS_TREE_RELOC_OBJECTID &&
+		    root->root_key.objectid != BTRFS_DATA_RELOC_TREE_OBJECTID) {
 			if (first) {
 				inode = find_next_inode(root, key.objectid);
 				first = 0;
@@ -3470,15 +3471,11 @@ struct inode *create_reloc_inode(struct btrfs_fs_info *fs_info,
 {
 	struct inode *inode = NULL;
 	struct btrfs_trans_handle *trans;
-	struct btrfs_root *root;
+	struct btrfs_root *root = fs_info->dreloc_root;
 	struct btrfs_key key;
 	u64 objectid;
 	int err = 0;
 
-	root = read_fs_root(fs_info, BTRFS_DATA_RELOC_TREE_OBJECTID);
-	if (IS_ERR(root))
-		return ERR_CAST(root);
-
 	trans = btrfs_start_transaction(root, 6);
 	if (IS_ERR(trans)) {
 		btrfs_put_root(root);
@@ -3501,7 +3498,6 @@ struct inode *create_reloc_inode(struct btrfs_fs_info *fs_info,
 
 	err = btrfs_orphan_add(trans, BTRFS_I(inode));
 out:
-	btrfs_put_root(root);
 	btrfs_end_transaction(trans);
 	btrfs_btree_balance_dirty(fs_info);
 	if (err) {
@@ -3870,13 +3866,7 @@ int btrfs_recover_relocation(struct btrfs_root *root)
 
 	if (err == 0) {
 		/* cleanup orphan inode in data relocation tree */
-		fs_root = read_fs_root(fs_info, BTRFS_DATA_RELOC_TREE_OBJECTID);
-		if (IS_ERR(fs_root)) {
-			err = PTR_ERR(fs_root);
-		} else {
-			err = btrfs_orphan_cleanup(fs_root);
-			btrfs_put_root(fs_root);
-		}
+		err = btrfs_orphan_cleanup(fs_info->dreloc_root);
 	}
 	return err;
 }
-- 
2.26.2

