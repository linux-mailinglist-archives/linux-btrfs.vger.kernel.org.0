Return-Path: <linux-btrfs+bounces-20199-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 926CACFE39F
	for <lists+linux-btrfs@lfdr.de>; Wed, 07 Jan 2026 15:17:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F3D0B310C242
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Jan 2026 14:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DBBB3314C4;
	Wed,  7 Jan 2026 14:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=harmstone.com header.i=@harmstone.com header.b="jn6h0eTG"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail.burntcomma.com (mail2.burntcomma.com [217.169.27.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8945332ED24
	for <linux-btrfs@vger.kernel.org>; Wed,  7 Jan 2026 14:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.169.27.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767795033; cv=none; b=iU+RsgebhdpY/T6tNKc4k029vio9TzNedJwuxVQgOcsVtkyeNgJfAiuQO3vdVe2YpXbBFnlSUbWS9gXpN0xqptpQfM6i8MWhPJqcm6xkjZk0TzU7AeJ8IzMwU/f6EmGFENmGrmqI+PWU6Si2NotEdDCU5tMUtPcAZcYaMUu49BE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767795033; c=relaxed/simple;
	bh=ZV8zuSUfJcBs07Lt+fA7FZwKJwKnSmUeoqYkf/ssQzA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Mime-Version; b=k/1FoHAoeVJCgSaMYUaMoSgFVLX4ec0kXr8LlPXq/EsaAM6uQ4aF3ZaTQepSIACBHrJ34/lyJXWNIdIbES4jPFREJCVsu4Ph6FcXgKCoWa+79dZodEmJwM5HsggdNF9Aezwrqjd6gqNZgkEEZRHvsiAa6cwp8MaqzxhQgFwJ29k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=harmstone.com; spf=pass smtp.mailfrom=harmstone.com; dkim=pass (1024-bit key) header.d=harmstone.com header.i=@harmstone.com header.b=jn6h0eTG; arc=none smtp.client-ip=217.169.27.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=harmstone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=harmstone.com
Received: from beren (beren.burntcomma.com [IPv6:2a02:8012:8cf0:0:ce28:aaff:fe0d:6db2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.burntcomma.com (Postfix) with ESMTPSA id 690862F186E;
	Wed,  7 Jan 2026 14:10:18 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=harmstone.com;
	s=mail; t=1767795018;
	bh=J4pXhfdSTldvV5IG7IOdQ6WRt5wxkJyW2v2jMPVMLk4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jn6h0eTG73M/jrSw2Om0dMHKbOYowDYxA3jQObJ3MwtxKizf7zPh4u3Nw5S6fHfI3
	 BGWKLNVnwGtyVoTQFecNBEbMq6W6yCmtC61lDhh+BuU6lRdasxk0uIU32nL5TyhkTV
	 BOdwh4MpH3ZyYe1EvsDF6SoZR3Xu2H3GYykq4f/Q=
From: Mark Harmstone <mark@harmstone.com>
To: linux-btrfs@vger.kernel.org
Cc: Mark Harmstone <mark@harmstone.com>,
	Boris Burkov <boris@bur.io>
Subject: [PATCH v8 08/17] btrfs: allow mounting filesystems with remap-tree incompat flag
Date: Wed,  7 Jan 2026 14:09:08 +0000
Message-ID: <20260107141015.25819-9-mark@harmstone.com>
In-Reply-To: <20260107141015.25819-1-mark@harmstone.com>
References: <20260107141015.25819-1-mark@harmstone.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit

If we encounter a filesystem with the remap-tree incompat flag set,
valdiate its compatibility with the other flags, and load the remap tree
using the values that have been added to the superblock.

The remap-tree feature depends on the free space tere, but no-holes and
block-group-tree have been made dependencies to reduce the testing
matrix. Similarly I'm not aware of any reason why mixed-bg and zoned would be
incompatible with remap-tree, but this is blocked for the time being
until it can be fully tested.

Signed-off-by: Mark Harmstone <mark@harmstone.com>
Reviewed-by: Boris Burkov <boris@bur.io>
---
 fs/btrfs/Kconfig                |   2 +
 fs/btrfs/accessors.h            |   6 ++
 fs/btrfs/disk-io.c              | 111 ++++++++++++++++++++++++++++----
 fs/btrfs/extent-tree.c          |   2 +
 fs/btrfs/fs.h                   |   4 +-
 fs/btrfs/transaction.c          |   7 ++
 include/uapi/linux/btrfs_tree.h |   5 +-
 7 files changed, 122 insertions(+), 15 deletions(-)

diff --git a/fs/btrfs/Kconfig b/fs/btrfs/Kconfig
index bf7feff2fe44..ee2fdcb49719 100644
--- a/fs/btrfs/Kconfig
+++ b/fs/btrfs/Kconfig
@@ -115,4 +115,6 @@ config BTRFS_EXPERIMENTAL
 
 	  - large folio support
 
+	  - remap-tree - logical address remapping tree
+
 	  If unsure, say N.
diff --git a/fs/btrfs/accessors.h b/fs/btrfs/accessors.h
index 9797f9e8d4e5..8938357fcb40 100644
--- a/fs/btrfs/accessors.h
+++ b/fs/btrfs/accessors.h
@@ -883,6 +883,12 @@ BTRFS_SETGET_STACK_FUNCS(super_uuid_tree_generation, struct btrfs_super_block,
 			 uuid_tree_generation, 64);
 BTRFS_SETGET_STACK_FUNCS(super_nr_global_roots, struct btrfs_super_block,
 			 nr_global_roots, 64);
+BTRFS_SETGET_STACK_FUNCS(super_remap_root, struct btrfs_super_block,
+			 remap_root, 64);
+BTRFS_SETGET_STACK_FUNCS(super_remap_root_generation, struct btrfs_super_block,
+			 remap_root_generation, 64);
+BTRFS_SETGET_STACK_FUNCS(super_remap_root_level, struct btrfs_super_block,
+			 remap_root_level, 8);
 
 /* struct btrfs_file_extent_item */
 BTRFS_SETGET_STACK_FUNCS(stack_file_extent_type, struct btrfs_file_extent_item,
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index c36367f9017f..b03654ee91f5 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -1158,6 +1158,8 @@ static struct btrfs_root *btrfs_get_global_root(struct btrfs_fs_info *fs_info,
 		return btrfs_grab_root(btrfs_global_root(fs_info, &key));
 	case BTRFS_RAID_STRIPE_TREE_OBJECTID:
 		return btrfs_grab_root(fs_info->stripe_root);
+	case BTRFS_REMAP_TREE_OBJECTID:
+		return btrfs_grab_root(fs_info->remap_root);
 	default:
 		return NULL;
 	}
@@ -1248,6 +1250,7 @@ void btrfs_free_fs_info(struct btrfs_fs_info *fs_info)
 	btrfs_put_root(fs_info->data_reloc_root);
 	btrfs_put_root(fs_info->block_group_root);
 	btrfs_put_root(fs_info->stripe_root);
+	btrfs_put_root(fs_info->remap_root);
 	btrfs_check_leaked_roots(fs_info);
 	btrfs_extent_buffer_leak_debug_check(fs_info);
 	kfree(fs_info->super_copy);
@@ -1800,6 +1803,7 @@ static void free_root_pointers(struct btrfs_fs_info *info, bool free_chunk_root)
 	free_root_extent_buffers(info->data_reloc_root);
 	free_root_extent_buffers(info->block_group_root);
 	free_root_extent_buffers(info->stripe_root);
+	free_root_extent_buffers(info->remap_root);
 	if (free_chunk_root)
 		free_root_extent_buffers(info->chunk_root);
 }
@@ -2213,21 +2217,49 @@ static int btrfs_read_roots(struct btrfs_fs_info *fs_info)
 	if (ret)
 		goto out;
 
-	/*
-	 * This tree can share blocks with some other fs tree during relocation
-	 * and we need a proper setup by btrfs_get_fs_root
-	 */
-	root = btrfs_get_fs_root(tree_root->fs_info,
-				 BTRFS_DATA_RELOC_TREE_OBJECTID, true);
-	if (IS_ERR(root)) {
-		if (!btrfs_test_opt(fs_info, IGNOREBADROOTS)) {
-			location.objectid = BTRFS_DATA_RELOC_TREE_OBJECTID;
-			ret = PTR_ERR(root);
-			goto out;
+	if (btrfs_fs_incompat(fs_info, REMAP_TREE)) {
+		/*
+		 * The remap_root has already been loaded in
+		 * load_important_roots().
+		 */
+		root = fs_info->remap_root;
+
+		set_bit(BTRFS_ROOT_TRACK_DIRTY, &root->state);
+
+		root->root_key.objectid = BTRFS_REMAP_TREE_OBJECTID;
+		root->root_key.type = BTRFS_ROOT_ITEM_KEY;
+		root->root_key.offset = 0;
+
+		/* Check that data reloc tree doesn't also exist. */
+		location.objectid = BTRFS_DATA_RELOC_TREE_OBJECTID;
+		root = btrfs_read_tree_root(fs_info->tree_root, &location);
+		if (!IS_ERR(root)) {
+			btrfs_err(fs_info,
+			   "data reloc tree exists when remap-tree enabled");
+			btrfs_put_root(root);
+			return -EIO;
+		} else if (PTR_ERR(root) != -ENOENT) {
+			btrfs_warn(fs_info,
+			   "error %ld when checking for data reloc tree",
+				   PTR_ERR(root));
 		}
 	} else {
-		set_bit(BTRFS_ROOT_TRACK_DIRTY, &root->state);
-		fs_info->data_reloc_root = root;
+		/*
+		 * This tree can share blocks with some other fs tree during
+		 * relocation and we need a proper setup by btrfs_get_fs_root().
+		 */
+		root = btrfs_get_fs_root(tree_root->fs_info,
+					 BTRFS_DATA_RELOC_TREE_OBJECTID, true);
+		if (IS_ERR(root)) {
+			if (!btrfs_test_opt(fs_info, IGNOREBADROOTS)) {
+				location.objectid = BTRFS_DATA_RELOC_TREE_OBJECTID;
+				ret = PTR_ERR(root);
+				goto out;
+			}
+		} else {
+			set_bit(BTRFS_ROOT_TRACK_DIRTY, &root->state);
+			fs_info->data_reloc_root = root;
+		}
 	}
 
 	location.objectid = BTRFS_QUOTA_TREE_OBJECTID;
@@ -2467,6 +2499,36 @@ int btrfs_validate_super(const struct btrfs_fs_info *fs_info,
 		ret = -EINVAL;
 	}
 
+	if (btrfs_fs_incompat(fs_info, REMAP_TREE)) {
+		/*
+		 * Reduce test matrix for remap tree by requiring block-group-tree
+		 * and no-holes. Free-space-tree is a hard requirement.
+		 */
+		if (!btrfs_fs_compat_ro(fs_info, FREE_SPACE_TREE_VALID) ||
+		    !btrfs_fs_incompat(fs_info, NO_HOLES) ||
+		    !btrfs_fs_compat_ro(fs_info, BLOCK_GROUP_TREE)) {
+			btrfs_err(fs_info,
+"remap-tree feature requires free-space-tree, no-holes, and block-group-tree");
+			ret = -EINVAL;
+		}
+
+		if (btrfs_fs_incompat(fs_info, MIXED_GROUPS)) {
+			btrfs_err(fs_info, "remap-tree not supported with mixed-bg");
+			ret = -EINVAL;
+		}
+
+		if (btrfs_fs_incompat(fs_info, ZONED)) {
+			btrfs_err(fs_info, "remap-tree not supported with zoned devices");
+			ret = -EINVAL;
+		}
+
+		if (sectorsize > PAGE_SIZE) {
+			btrfs_err(fs_info,
+				  "remap-tree not supported when block size > page size");
+			ret = -EINVAL;
+		}
+	}
+
 	/*
 	 * Hint to catch really bogus numbers, bitflips or so, more exact checks are
 	 * done later
@@ -2625,6 +2687,18 @@ static int load_important_roots(struct btrfs_fs_info *fs_info)
 		btrfs_warn(fs_info, "couldn't read tree root");
 		return ret;
 	}
+
+	if (btrfs_fs_incompat(fs_info, REMAP_TREE)) {
+		bytenr = btrfs_super_remap_root(sb);
+		gen = btrfs_super_remap_root_generation(sb);
+		level = btrfs_super_remap_root_level(sb);
+		ret = load_super_root(fs_info->remap_root, bytenr, gen, level);
+		if (ret) {
+			btrfs_warn(fs_info, "couldn't read remap root");
+			return ret;
+		}
+	}
+
 	return 0;
 }
 
@@ -3245,6 +3319,7 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 	struct btrfs_fs_info *fs_info = btrfs_sb(sb);
 	struct btrfs_root *tree_root;
 	struct btrfs_root *chunk_root;
+	struct btrfs_root *remap_root;
 	int ret;
 	int level;
 
@@ -3375,6 +3450,16 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 	if (ret < 0)
 		goto fail_alloc;
 
+	if (btrfs_super_incompat_flags(disk_super) & BTRFS_FEATURE_INCOMPAT_REMAP_TREE) {
+		remap_root = btrfs_alloc_root(fs_info, BTRFS_REMAP_TREE_OBJECTID,
+					      GFP_KERNEL);
+		fs_info->remap_root = remap_root;
+		if (!remap_root) {
+			ret = -ENOMEM;
+			goto fail_alloc;
+		}
+	}
+
 	/*
 	 * At this point our mount options are validated, if we set ->max_inline
 	 * to something non-standard make sure we truncate it to sectorsize.
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 43473a6d91d7..3868a295be62 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -2589,6 +2589,8 @@ static u64 get_alloc_profile_by_root(struct btrfs_root *root, int data)
 		flags = BTRFS_BLOCK_GROUP_DATA;
 	else if (root == fs_info->chunk_root)
 		flags = BTRFS_BLOCK_GROUP_SYSTEM;
+	else if (root == fs_info->remap_root)
+		flags = BTRFS_BLOCK_GROUP_METADATA_REMAP;
 	else
 		flags = BTRFS_BLOCK_GROUP_METADATA;
 
diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
index 46c4f1dcec47..af11f2ce310a 100644
--- a/fs/btrfs/fs.h
+++ b/fs/btrfs/fs.h
@@ -307,7 +307,8 @@ enum {
 #define BTRFS_FEATURE_INCOMPAT_SUPP		\
 	(BTRFS_FEATURE_INCOMPAT_SUPP_STABLE |	\
 	 BTRFS_FEATURE_INCOMPAT_RAID_STRIPE_TREE | \
-	 BTRFS_FEATURE_INCOMPAT_EXTENT_TREE_V2)
+	 BTRFS_FEATURE_INCOMPAT_EXTENT_TREE_V2 | \
+	 BTRFS_FEATURE_INCOMPAT_REMAP_TREE)
 
 #else
 
@@ -467,6 +468,7 @@ struct btrfs_fs_info {
 	struct btrfs_root *data_reloc_root;
 	struct btrfs_root *block_group_root;
 	struct btrfs_root *stripe_root;
+	struct btrfs_root *remap_root;
 
 	/* The log root tree is a directory of all the other log roots */
 	struct btrfs_root *log_root_tree;
diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index e2f993b1783f..f4cc9e1a1b93 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -1967,6 +1967,13 @@ static void update_super_roots(struct btrfs_fs_info *fs_info)
 		super->cache_generation = 0;
 	if (test_bit(BTRFS_FS_UPDATE_UUID_TREE_GEN, &fs_info->flags))
 		super->uuid_tree_generation = root_item->generation;
+
+	if (btrfs_fs_incompat(fs_info, REMAP_TREE)) {
+		root_item = &fs_info->remap_root->root_item;
+		super->remap_root = root_item->bytenr;
+		super->remap_root_generation = root_item->generation;
+		super->remap_root_level = root_item->level;
+	}
 }
 
 int btrfs_transaction_blocked(struct btrfs_fs_info *info)
diff --git a/include/uapi/linux/btrfs_tree.h b/include/uapi/linux/btrfs_tree.h
index 86820a9644e8..f7843e6bb978 100644
--- a/include/uapi/linux/btrfs_tree.h
+++ b/include/uapi/linux/btrfs_tree.h
@@ -721,9 +721,12 @@ struct btrfs_super_block {
 	__u8 metadata_uuid[BTRFS_FSID_SIZE];
 
 	__u64 nr_global_roots;
+	__le64 remap_root;
+	__le64 remap_root_generation;
+	__u8 remap_root_level;
 
 	/* Future expansion */
-	__le64 reserved[27];
+	__u8 reserved[199];
 	__u8 sys_chunk_array[BTRFS_SYSTEM_CHUNK_ARRAY_SIZE];
 	struct btrfs_root_backup super_roots[BTRFS_NUM_BACKUP_ROOTS];
 
-- 
2.51.2


