Return-Path: <linux-btrfs+bounces-4840-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF1098BFCFD
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 May 2024 14:18:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DBA21C220C3
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 May 2024 12:18:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43B6384DEE;
	Wed,  8 May 2024 12:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YW3a0GCb"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7221884DE6
	for <linux-btrfs@vger.kernel.org>; Wed,  8 May 2024 12:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715170662; cv=none; b=Z/xwGqFLQNP0/nllcXLwfdBqGDDOKiSUGmtQrB+r0xB7Enqwx08CCoLchCOZ5dvWk2ecdprHrHxfAugAJm/L0jzB4uvPgFjNa3LyDV/0KtRzbiWkQ9t9A79EWv8EDkzk4QNY+AXHLXZtjIFqHghYDEBONUsGEDzNWJegdyBUZ+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715170662; c=relaxed/simple;
	bh=6GLB4NgNVTgt1bkzFVVg+BmYBVGWHex/BDe0GPzqsRw=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OGXlARUuvv/kUkOSQVh1Ntq7jQl/en1plVLypR76LKR1oA2rzUs4zuZ93dSU9lPp2Bdw1rmpR0dTwAptlDblWdOq8SSBUEJ+5yQSz66nZfINKOuoJBQZp+3pDv+Gr9rm2zosvPP+onhsdgAwvB0H7+aG7Hu2G/dN0YXfTHzr/iY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YW3a0GCb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87C3FC4AF17
	for <linux-btrfs@vger.kernel.org>; Wed,  8 May 2024 12:17:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715170662;
	bh=6GLB4NgNVTgt1bkzFVVg+BmYBVGWHex/BDe0GPzqsRw=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=YW3a0GCbAtuZESqXWshoA35W6IffU8PtbT69JTUNayGqxFkuEI2asB1FlFGOIKR1L
	 9V9RCDNI+wyXL/R4f8pWZBQWjm80m0kRsgH6UBNVXAUPXrm0FRTF+bBxesNiVHPoI5
	 +jAHt2LUOWXBDPHMC5puvh3lL8v4Ukm4BNgEc/vkclBcEDc8eNcrrlVT+zBunFpzD7
	 v7CZTxnqkEg6fHWF2BN4VsI2+/dYHU5LvhzOMHd7ioXT7NpT1LnJclIyKawVVuShV4
	 ztHTzyL6U9X+E2QG8Izgi0Mksm4BmIArgy4p8ZNs5ErEVOv7sAWlnCZBnvOmtxuqfB
	 WsWRkrC5Hfs9w==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 8/8] btrfs: remove objectid from struct btrfs_inode on 64 bits platforms
Date: Wed,  8 May 2024 13:17:31 +0100
Message-Id: <108152a5f5ca8023d76be4751764f52e9e81c0f2.1715169723.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1715169723.git.fdmanana@suse.com>
References: <cover.1715169723.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

On 64 bits platforms we don't really need to have a dedicated member (the
objectid field) for the inode's number since we store in the vfs inode's
i_ino member, which is an unsigned long and this type is 64 bits wide on
64 bits platforms. We only need that field in case we are on a 32 bits
platform because the unsigned long type is 32 bits wide on such platforms
See commit 33345d01522f ("Btrfs: Always use 64bit inode number") regarding
this 64/32 bits detail.

The objectid field of struct btrfs_inode is also used to store the ID of
a root for directories that are stubs for unreferenced roots. In such
cases the inode is a directory and has the BTRFS_INODE_ROOT_STUB runtime
flag set.

So in order to reduce the size of btrfs_inode structure on 64 bits
platforms we can remove the objectid member and use the vfs inode's i_ino
member instead whenever we need to get the inode number. In case the inode
is a root stub (BTRFS_INODE_ROOT_STUB set) we can use the member
last_reflink_trans to store the ID of the unreferenced root, since such
inode is a directory and reflinks can't be done against directories.

So remove the objectid fields for 64 bits platforms and alias the
last_reflink_trans field with a name of ref_root_id in a union.
On a release kernel config, this reduces the size of struct btrfs_inode
from 1024 bytes down to 1016 bytes, giving an 8 bytes slack space for
future expansion without decreasing the number of inodes we can have
per page (4 with a 4K page, 64 with a 64K page).

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/btrfs_inode.h       | 50 ++++++++++++++++++++++++------------
 fs/btrfs/disk-io.c           |  3 +--
 fs/btrfs/export.c            |  2 +-
 fs/btrfs/inode.c             | 17 +++++-------
 fs/btrfs/ioctl.c             |  4 +--
 fs/btrfs/tests/btrfs-tests.c |  3 +--
 6 files changed, 45 insertions(+), 34 deletions(-)

diff --git a/fs/btrfs/btrfs_inode.h b/fs/btrfs/btrfs_inode.h
index fa2f91396ae0..4d9299789a03 100644
--- a/fs/btrfs/btrfs_inode.h
+++ b/fs/btrfs/btrfs_inode.h
@@ -119,15 +119,14 @@ struct btrfs_inode {
 	/* which subvolume this inode belongs to */
 	struct btrfs_root *root;
 
+#if BITS_PER_LONG == 32
 	/*
-	 * This is either:
-	 *
-	 * 1) The objectid of the corresponding BTRFS_INODE_ITEM_KEY;
-	 *
-	 * 2) In case this a root stub inode (BTRFS_INODE_ROOT_STUB flag set),
-	 *    the ID of that root.
+	 * The objectid of the corresponding BTRFS_INODE_ITEM_KEY.
+	 * On 64 bits platforms we can get it from vfs_inode.i_ino, which is an
+	 * unsigned long and therefore 64 bits on such platforms.
 	 */
 	u64 objectid;
+#endif
 
 	/* Cached value of inode property 'compression'. */
 	u8 prop_compress;
@@ -291,16 +290,25 @@ struct btrfs_inode {
 	 */
 	u64 last_unlink_trans;
 
-	/*
-	 * The id/generation of the last transaction where this inode was
-	 * either the source or the destination of a clone/dedupe operation.
-	 * Used when logging an inode to know if there are shared extents that
-	 * need special care when logging checksum items, to avoid duplicate
-	 * checksum items in a log (which can lead to a corruption where we end
-	 * up with missing checksum ranges after log replay).
-	 * Protected by the vfs inode lock.
-	 */
-	u64 last_reflink_trans;
+	union {
+		/*
+		 * The id/generation of the last transaction where this inode
+		 * was either the source or the destination of a clone/dedupe
+		 * operation. Used when logging an inode to know if there are
+		 * shared extents that need special care when logging checksum
+		 * items, to avoid duplicate checksum items in a log (which can
+		 * lead to a corruption where we end up with missing checksum
+		 * ranges after log replay). Protected by the vfs inode lock.
+		 * Used for regular files only.
+		 */
+		u64 last_reflink_trans;
+
+		/*
+		 * In case this a root stub inode (BTRFS_INODE_ROOT_STUB flag set),
+		 * the ID of that root.
+		 */
+		u64 ref_root_id;
+	};
 
 	/* Backwards incompatible flags, lower half of inode_item::flags  */
 	u32 flags;
@@ -377,11 +385,19 @@ static inline u64 btrfs_ino(const struct btrfs_inode *inode)
 static inline void btrfs_get_inode_key(const struct btrfs_inode *inode,
 				       struct btrfs_key *key)
 {
-	key->objectid = inode->objectid;
+	key->objectid = btrfs_ino(inode);
 	key->type = BTRFS_INODE_ITEM_KEY;
 	key->offset = 0;
 }
 
+static inline void btrfs_set_inode_number(struct btrfs_inode *inode, u64 ino)
+{
+#if BITS_PER_LONG == 32
+	inode->objectid = ino;
+#endif
+	inode->vfs_inode.i_ino = ino;
+}
+
 static inline void btrfs_i_size_write(struct btrfs_inode *inode, u64 size)
 {
 	i_size_write(&inode->vfs_inode, size);
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index e3edaf510108..e6bf895b3547 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -1928,7 +1928,7 @@ static int btrfs_init_btree_inode(struct super_block *sb)
 	if (!inode)
 		return -ENOMEM;
 
-	inode->i_ino = BTRFS_BTREE_INODE_OBJECTID;
+	btrfs_set_inode_number(BTRFS_I(inode), BTRFS_BTREE_INODE_OBJECTID);
 	set_nlink(inode, 1);
 	/*
 	 * we set the i_size on the btree inode to the max possible int.
@@ -1944,7 +1944,6 @@ static int btrfs_init_btree_inode(struct super_block *sb)
 	extent_map_tree_init(&BTRFS_I(inode)->extent_tree);
 
 	BTRFS_I(inode)->root = btrfs_grab_root(fs_info->tree_root);
-	BTRFS_I(inode)->objectid = BTRFS_BTREE_INODE_OBJECTID;
 	set_bit(BTRFS_INODE_DUMMY, &BTRFS_I(inode)->runtime_flags);
 	__insert_inode_hash(inode, hash);
 	fs_info->btree_inode = inode;
diff --git a/fs/btrfs/export.c b/fs/btrfs/export.c
index 5526e25ebb3f..5da56e21ff73 100644
--- a/fs/btrfs/export.c
+++ b/fs/btrfs/export.c
@@ -40,7 +40,7 @@ static int btrfs_encode_fh(struct inode *inode, u32 *fh, int *max_len,
 	if (parent) {
 		u64 parent_root_id;
 
-		fid->parent_objectid = BTRFS_I(parent)->objectid;
+		fid->parent_objectid = btrfs_ino(BTRFS_I(parent));
 		fid->parent_gen = parent->i_generation;
 		parent_root_id = btrfs_root_id(BTRFS_I(parent)->root);
 
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 44dc82ff96db..5a1014122088 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -4340,7 +4340,7 @@ static int btrfs_unlink_subvol(struct btrfs_trans_handle *trans,
 	if (btrfs_ino(inode) == BTRFS_FIRST_FREE_OBJECTID) {
 		objectid = btrfs_root_id(inode->root);
 	} else if (btrfs_ino(inode) == BTRFS_EMPTY_SUBVOL_DIR_OBJECTID) {
-		objectid = inode->objectid;
+		objectid = inode->ref_root_id;
 	} else {
 		WARN_ON(1);
 		fscrypt_free_filename(&fname);
@@ -5581,8 +5581,7 @@ static int btrfs_init_locked_inode(struct inode *inode, void *p)
 {
 	struct btrfs_iget_args *args = p;
 
-	inode->i_ino = args->ino;
-	BTRFS_I(inode)->objectid = args->ino;
+	btrfs_set_inode_number(BTRFS_I(inode), args->ino);
 	BTRFS_I(inode)->root = btrfs_grab_root(args->root);
 
 	if (args->root && args->root == args->root->fs_info->tree_root &&
@@ -5596,7 +5595,7 @@ static int btrfs_find_actor(struct inode *inode, void *opaque)
 {
 	struct btrfs_iget_args *args = opaque;
 
-	return args->ino == BTRFS_I(inode)->objectid &&
+	return args->ino == btrfs_ino(BTRFS_I(inode)) &&
 		args->root == BTRFS_I(inode)->root;
 }
 
@@ -5673,11 +5672,11 @@ static struct inode *new_simple_dir(struct inode *dir,
 		return ERR_PTR(-ENOMEM);
 
 	BTRFS_I(inode)->root = btrfs_grab_root(root);
-	BTRFS_I(inode)->objectid = key->objectid;
+	BTRFS_I(inode)->ref_root_id = key->objectid;
 	set_bit(BTRFS_INODE_ROOT_STUB, &BTRFS_I(inode)->runtime_flags);
 	set_bit(BTRFS_INODE_DUMMY, &BTRFS_I(inode)->runtime_flags);
 
-	inode->i_ino = BTRFS_EMPTY_SUBVOL_DIR_OBJECTID;
+	btrfs_set_inode_number(BTRFS_I(inode), BTRFS_EMPTY_SUBVOL_DIR_OBJECTID);
 	/*
 	 * We only need lookup, the rest is read-only and there's no inode
 	 * associated with the dentry
@@ -6150,7 +6149,7 @@ static int btrfs_insert_inode_locked(struct inode *inode)
 {
 	struct btrfs_iget_args args;
 
-	args.ino = BTRFS_I(inode)->objectid;
+	args.ino = btrfs_ino(BTRFS_I(inode));
 	args.root = BTRFS_I(inode)->root;
 
 	return insert_inode_locked4(inode,
@@ -6282,7 +6281,7 @@ int btrfs_create_new_inode(struct btrfs_trans_handle *trans,
 	ret = btrfs_get_free_objectid(root, &objectid);
 	if (ret)
 		goto out;
-	inode->i_ino = objectid;
+	btrfs_set_inode_number(BTRFS_I(inode), objectid);
 
 	ret = xa_reserve(&root->inodes, objectid, GFP_NOFS);
 	if (ret)
@@ -6332,8 +6331,6 @@ int btrfs_create_new_inode(struct btrfs_trans_handle *trans,
 				BTRFS_INODE_NODATASUM;
 	}
 
-	BTRFS_I(inode)->objectid = objectid;
-
 	ret = btrfs_insert_inode_locked(inode);
 	if (ret < 0) {
 		if (!args->orphan)
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 2de8f06523b9..1d343cd2435b 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -1918,7 +1918,7 @@ static int btrfs_search_path_in_tree_user(struct mnt_idmap *idmap,
 {
 	struct btrfs_fs_info *fs_info = BTRFS_I(inode)->root->fs_info;
 	struct super_block *sb = inode->i_sb;
-	u64 upper_limit = BTRFS_I(inode)->objectid;
+	u64 upper_limit = btrfs_ino(BTRFS_I(inode));
 	u64 treeid = btrfs_root_id(BTRFS_I(inode)->root);
 	u64 dirid = args->dirid;
 	unsigned long item_off;
@@ -2140,7 +2140,7 @@ static int btrfs_ioctl_ino_lookup_user(struct file *file, void __user *argp)
 	inode = file_inode(file);
 
 	if (args->dirid == BTRFS_FIRST_FREE_OBJECTID &&
-	    BTRFS_I(inode)->objectid != BTRFS_FIRST_FREE_OBJECTID) {
+	    btrfs_ino(BTRFS_I(inode)) != BTRFS_FIRST_FREE_OBJECTID) {
 		/*
 		 * The subvolume does not exist under fd with which this is
 		 * called
diff --git a/fs/btrfs/tests/btrfs-tests.c b/fs/btrfs/tests/btrfs-tests.c
index b28a79935d8e..ce50847e1e01 100644
--- a/fs/btrfs/tests/btrfs-tests.c
+++ b/fs/btrfs/tests/btrfs-tests.c
@@ -61,8 +61,7 @@ struct inode *btrfs_new_test_inode(void)
 		return NULL;
 
 	inode->i_mode = S_IFREG;
-	inode->i_ino = BTRFS_FIRST_FREE_OBJECTID;
-	BTRFS_I(inode)->objectid = BTRFS_FIRST_FREE_OBJECTID;
+	btrfs_set_inode_number(BTRFS_I(inode), BTRFS_FIRST_FREE_OBJECTID);
 	inode_init_owner(&nop_mnt_idmap, inode, NULL, S_IFREG);
 
 	return inode;
-- 
2.43.0


