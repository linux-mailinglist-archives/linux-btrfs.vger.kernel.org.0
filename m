Return-Path: <linux-btrfs+bounces-4837-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 758E78BFCFA
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 May 2024 14:18:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03FFA1F24204
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 May 2024 12:18:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0100C84D10;
	Wed,  8 May 2024 12:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bt1FgT1S"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FD7683CDC
	for <linux-btrfs@vger.kernel.org>; Wed,  8 May 2024 12:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715170659; cv=none; b=WcubOnY6ahujM2FEn2AP+O3WSZUzHuiAdRQcGSeLtePPkeefqfjOpveGxcIkdwif4zSusMAJmBc6Oq4F7Nxdcu8tSTMgBEReF0qKJ9Ja4EfhPb2cg1+O0/0o2vlRrgl1EX4Mht7y7fsBUM0PiqW8G4XAIA7cKM41D7xYHTfK9ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715170659; c=relaxed/simple;
	bh=L1qTQoYBVjz1Zv4QybF5rZ/1skQYQ8tHpS2o2lnzfcQ=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hmZOENtWOW/4BJ4KSRUEdWj3DPMxUdj9PCbNATfPch5SXlfgB4tyFHDJfAJFn2sKbELpGhp7oWwOe3HjeEOUYGeZWBlEJJnjRv6ibaoeGbB/dEPlbU5Je14GDqbvuXlbQJj4GEvnmC5DbkXf3faeTiNktW8ZLDLuv+T0mjdWc6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bt1FgT1S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85885C3277B
	for <linux-btrfs@vger.kernel.org>; Wed,  8 May 2024 12:17:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715170659;
	bh=L1qTQoYBVjz1Zv4QybF5rZ/1skQYQ8tHpS2o2lnzfcQ=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=bt1FgT1S9tOwgv+oFtM6ocojFEeGnITxzu2y8hZPsIDj4F67IJU75hmXt35L8VXNp
	 L17YRv6UL7MNrlKDRQ6RxUKjF1ctBLfOmh9/0s2Fbgb6GnksiTj6l3I1UZQnH2eDcs
	 Tq1YUgwxdHH1ZLInJV58pe8GfKEPkA+Pbl57OORV2xVtZ0wx26RW8LDTxVB1xwzS7C
	 BeR2wYh/Bfuo0zOqtkaEb0GP/pMZqBHvVGHEi6H36MgPueT+PmsMiGMRSkyUKBlnjj
	 XySL6K+KLg47u+t0EcvGLeSO/S44arYWvYFYCZDnZCnemuMExUhchwUUVmnpTrvHQk
	 4s8/MBpkqunWw==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 5/8] btrfs: unify index_cnt and csum_bytes from struct btrfs_inode
Date: Wed,  8 May 2024 13:17:28 +0100
Message-Id: <a9cda79653d2aa3964dec05ec21b96ce8f8f8e4f.1715169723.git.fdmanana@suse.com>
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

The index_cnt field of struct btrfs_inode is used only for two purposes:

1) To store the index for the next entry added to a directory;

2) For the data relocation inode to track the logical start address of the
   block group currently being relocated.

For the relocation case we use index_cnt because it's not used for
anything else in the relocation use case - we could have used other fields
that are not used by relocation such as defrag_bytes, last_unlink_trans
or last_reflink_trans for example (amongs others).

Since the csum_bytes field is not used for directories, do the following
changes:

1) Put index_cnt and csum_bytes in a union, and index_cnt is only
   initialized when the inode is a directory. The csum_bytes is only
   accessed in IO paths for regular files, so we're fine here;

2) Use the defrag_bytes field for relocation, since the data relocation
   inode is never used for defrag purposes. And to make the naming better,
   alias it to reloc_block_group_start by using a union.

This reduces the size of struct btrfs_inode by 8 bytes in a release
kernel, from 1040 bytes down to 1032 bytes.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/btrfs_inode.h   | 46 +++++++++++++++++++++++++---------------
 fs/btrfs/delayed-inode.c |  3 ++-
 fs/btrfs/inode.c         | 21 ++++++++++++------
 fs/btrfs/relocation.c    | 12 +++++------
 fs/btrfs/tree-log.c      |  3 ++-
 5 files changed, 54 insertions(+), 31 deletions(-)

diff --git a/fs/btrfs/btrfs_inode.h b/fs/btrfs/btrfs_inode.h
index e577b9745884..19bb3d057414 100644
--- a/fs/btrfs/btrfs_inode.h
+++ b/fs/btrfs/btrfs_inode.h
@@ -215,11 +215,20 @@ struct btrfs_inode {
 		u64 last_dir_index_offset;
 	};
 
-	/*
-	 * Total number of bytes pending defrag, used by stat to check whether
-	 * it needs COW. Protected by 'lock'.
-	 */
-	u64 defrag_bytes;
+	union {
+		/*
+		 * Total number of bytes pending defrag, used by stat to check whether
+		 * it needs COW. Protected by 'lock'.
+		 * Used by inodes other than the data relocation inode.
+		 */
+		u64 defrag_bytes;
+
+		/*
+		 * Logical address of the block group being relocated.
+		 * Used only by the data relocation inode.
+		 */
+		u64 reloc_block_group_start;
+	};
 
 	/*
 	 * The size of the file stored in the metadata on disk.  data=ordered
@@ -228,12 +237,21 @@ struct btrfs_inode {
 	 */
 	u64 disk_i_size;
 
-	/*
-	 * If this is a directory then index_cnt is the counter for the index
-	 * number for new files that are created. For an empty directory, this
-	 * must be initialized to BTRFS_DIR_START_INDEX.
-	 */
-	u64 index_cnt;
+	union {
+		/*
+		 * If this is a directory then index_cnt is the counter for the
+		 * index number for new files that are created. For an empty
+		 * directory, this must be initialized to BTRFS_DIR_START_INDEX.
+		 */
+		u64 index_cnt;
+
+		/*
+		 * If this is not a directory, this is the number of bytes
+		 * outstanding that are going to need csums. This is used in
+		 * ENOSPC accounting. Protected by 'lock'.
+		 */
+		u64 csum_bytes;
+	};
 
 	/* Cache the directory index number to speed the dir/file remove */
 	u64 dir_index;
@@ -256,12 +274,6 @@ struct btrfs_inode {
 	 */
 	u64 last_reflink_trans;
 
-	/*
-	 * Number of bytes outstanding that are going to need csums.  This is
-	 * used in ENOSPC accounting. Protected by 'lock'.
-	 */
-	u64 csum_bytes;
-
 	/* Backwards incompatible flags, lower half of inode_item::flags  */
 	u32 flags;
 	/* Read-only compatibility flags, upper half of inode_item::flags */
diff --git a/fs/btrfs/delayed-inode.c b/fs/btrfs/delayed-inode.c
index 1373f474c9b6..e298a44eaf69 100644
--- a/fs/btrfs/delayed-inode.c
+++ b/fs/btrfs/delayed-inode.c
@@ -1914,7 +1914,8 @@ int btrfs_fill_inode(struct inode *inode, u32 *rdev)
 	BTRFS_I(inode)->i_otime_nsec = btrfs_stack_timespec_nsec(&inode_item->otime);
 
 	inode->i_generation = BTRFS_I(inode)->generation;
-	BTRFS_I(inode)->index_cnt = (u64)-1;
+	if (S_ISDIR(inode->i_mode))
+		BTRFS_I(inode)->index_cnt = (u64)-1;
 
 	mutex_unlock(&delayed_node->mutex);
 	btrfs_release_delayed_node(delayed_node);
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 4fd41d6b377f..9b98aa65cc63 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -3856,7 +3856,9 @@ static int btrfs_read_locked_inode(struct inode *inode,
 	inode->i_rdev = 0;
 	rdev = btrfs_inode_rdev(leaf, inode_item);
 
-	BTRFS_I(inode)->index_cnt = (u64)-1;
+	if (S_ISDIR(inode->i_mode))
+		BTRFS_I(inode)->index_cnt = (u64)-1;
+
 	btrfs_inode_split_flags(btrfs_inode_flags(leaf, inode_item),
 				&BTRFS_I(inode)->flags, &BTRFS_I(inode)->ro_flags);
 
@@ -6268,8 +6270,10 @@ int btrfs_create_new_inode(struct btrfs_trans_handle *trans,
 		if (ret)
 			goto out;
 	}
-	/* index_cnt is ignored for everything but a dir. */
-	BTRFS_I(inode)->index_cnt = BTRFS_DIR_START_INDEX;
+
+	if (S_ISDIR(inode->i_mode))
+		BTRFS_I(inode)->index_cnt = BTRFS_DIR_START_INDEX;
+
 	BTRFS_I(inode)->generation = trans->transid;
 	inode->i_generation = BTRFS_I(inode)->generation;
 
@@ -8435,8 +8439,12 @@ struct inode *btrfs_alloc_inode(struct super_block *sb)
 	ei->disk_i_size = 0;
 	ei->flags = 0;
 	ei->ro_flags = 0;
+	/*
+	 * ->index_cnt will be propertly initialized later when creating a new
+	 * inode (btrfs_create_new_inode()) or when reading an existing inode
+	 * from disk (btrfs_read_locked_inode()).
+	 */
 	ei->csum_bytes = 0;
-	ei->index_cnt = (u64)-1;
 	ei->dir_index = 0;
 	ei->last_unlink_trans = 0;
 	ei->last_reflink_trans = 0;
@@ -8511,9 +8519,10 @@ void btrfs_destroy_inode(struct inode *vfs_inode)
 	if (!S_ISDIR(vfs_inode->i_mode)) {
 		WARN_ON(inode->delalloc_bytes);
 		WARN_ON(inode->new_delalloc_bytes);
+		WARN_ON(inode->csum_bytes);
 	}
-	WARN_ON(inode->csum_bytes);
-	WARN_ON(inode->defrag_bytes);
+	if (!root || !btrfs_is_data_reloc_root(root))
+		WARN_ON(inode->defrag_bytes);
 
 	/*
 	 * This can happen where we create an inode, but somebody else also
diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 8b24bb5a0aa1..9f35524b6664 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -962,7 +962,7 @@ static int get_new_location(struct inode *reloc_inode, u64 *new_bytenr,
 	if (!path)
 		return -ENOMEM;
 
-	bytenr -= BTRFS_I(reloc_inode)->index_cnt;
+	bytenr -= BTRFS_I(reloc_inode)->reloc_block_group_start;
 	ret = btrfs_lookup_file_extent(NULL, root, path,
 			btrfs_ino(BTRFS_I(reloc_inode)), bytenr, 0);
 	if (ret < 0)
@@ -2797,7 +2797,7 @@ static noinline_for_stack int prealloc_file_extent_cluster(
 	u64 alloc_hint = 0;
 	u64 start;
 	u64 end;
-	u64 offset = inode->index_cnt;
+	u64 offset = inode->reloc_block_group_start;
 	u64 num_bytes;
 	int nr;
 	int ret = 0;
@@ -2951,7 +2951,7 @@ static int relocate_one_folio(struct inode *inode, struct file_ra_state *ra,
 			      int *cluster_nr, unsigned long index)
 {
 	struct btrfs_fs_info *fs_info = inode_to_fs_info(inode);
-	u64 offset = BTRFS_I(inode)->index_cnt;
+	u64 offset = BTRFS_I(inode)->reloc_block_group_start;
 	const unsigned long last_index = (cluster->end - offset) >> PAGE_SHIFT;
 	gfp_t mask = btrfs_alloc_write_mask(inode->i_mapping);
 	struct folio *folio;
@@ -3086,7 +3086,7 @@ static int relocate_one_folio(struct inode *inode, struct file_ra_state *ra,
 static int relocate_file_extent_cluster(struct inode *inode,
 					const struct file_extent_cluster *cluster)
 {
-	u64 offset = BTRFS_I(inode)->index_cnt;
+	u64 offset = BTRFS_I(inode)->reloc_block_group_start;
 	unsigned long index;
 	unsigned long last_index;
 	struct file_ra_state *ra;
@@ -3915,7 +3915,7 @@ static noinline_for_stack struct inode *create_reloc_inode(
 		inode = NULL;
 		goto out;
 	}
-	BTRFS_I(inode)->index_cnt = group->start;
+	BTRFS_I(inode)->reloc_block_group_start = group->start;
 
 	ret = btrfs_orphan_add(trans, BTRFS_I(inode));
 out:
@@ -4395,7 +4395,7 @@ int btrfs_reloc_clone_csums(struct btrfs_ordered_extent *ordered)
 {
 	struct btrfs_inode *inode = BTRFS_I(ordered->inode);
 	struct btrfs_fs_info *fs_info = inode->root->fs_info;
-	u64 disk_bytenr = ordered->file_offset + inode->index_cnt;
+	u64 disk_bytenr = ordered->file_offset + inode->reloc_block_group_start;
 	struct btrfs_root *csum_root = btrfs_csum_root(fs_info, disk_bytenr);
 	LIST_HEAD(list);
 	int ret;
diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 5146387b416b..0aee43466c52 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -1625,7 +1625,8 @@ static noinline int fixup_inode_link_count(struct btrfs_trans_handle *trans,
 		if (ret)
 			goto out;
 	}
-	BTRFS_I(inode)->index_cnt = (u64)-1;
+	if (S_ISDIR(inode->i_mode))
+		BTRFS_I(inode)->index_cnt = (u64)-1;
 
 	if (inode->i_nlink == 0) {
 		if (S_ISDIR(inode->i_mode)) {
-- 
2.43.0


