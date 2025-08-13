Return-Path: <linux-btrfs+bounces-16058-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B0C6B24C2D
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Aug 2025 16:41:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 280FB161A37
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Aug 2025 14:38:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4B13302CB5;
	Wed, 13 Aug 2025 14:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=harmstone.com header.i=@harmstone.com header.b="xXhAAIAb"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail.burntcomma.com (mail2.burntcomma.com [217.169.27.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3F632EAB8C
	for <linux-btrfs@vger.kernel.org>; Wed, 13 Aug 2025 14:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.169.27.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755095729; cv=none; b=E5MUYkDdQ5uB2qtQnHY66QuTPxgB62nRUiG+qb6nUoCxqwJ29+eEczvbPMZHwpVWkc5fJZ1/sktYsnMiZitIVFFh0r8kojTmWjBrhkON0aHLFgqb/8H+1z4krgGbbROLitttcQsd8GLR/CPGq2LBng8i6ZWburFlFiSEfZlYVlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755095729; c=relaxed/simple;
	bh=BqiFghIIDCZ/OlgCFsfIInT36BUT3n5+1SIjA5sE+fs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Mime-Version; b=jSfQ6aX/BSAc6ZI3+qmcBXznkLgJkMEnS7+G6wU8WN66XhTvLW61ZW6Liq/QyTE8G0q5NXUhIekH+frwS0wAF/JOUtnCyJbL8vOW8gKHxDPIhbGMlUO5izmWmvPUUIKALidOsB4Iey6lj4TlJpTkMe3QaukdBnIimHs5KSSMsYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=harmstone.com; spf=pass smtp.mailfrom=harmstone.com; dkim=pass (1024-bit key) header.d=harmstone.com header.i=@harmstone.com header.b=xXhAAIAb; arc=none smtp.client-ip=217.169.27.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=harmstone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=harmstone.com
Received: from localhost.localdomain (beren.burntcomma.com [IPv6:2a02:8012:8cf0:0:ce28:aaff:fe0d:6db2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.burntcomma.com (Postfix) with ESMTPSA id 4E5A52A7596;
	Wed, 13 Aug 2025 15:35:13 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=harmstone.com;
	s=mail; t=1755095713;
	bh=FBCdRAaCrIrBaceG9zTN5/nTXf9uF3MeLtBW0IcmpJk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=xXhAAIAbOXVoxc639s4CnYd/921C5edSyQVZWQJa9DBWgwbLV+cPg26pdEWbnyl4Q
	 KnaeD0GWngN923TEk/KDjd8fWjzmQ/wNDMAw2PWJJn2Ef/HMQWl0yCGMTE/2dazjMF
	 J99DwuJpO3ECm6bdexsgzsClS2Sq/WMLzzRY417Q=
From: Mark Harmstone <mark@harmstone.com>
To: linux-btrfs@vger.kernel.org
Cc: Mark Harmstone <mark@harmstone.com>
Subject: [PATCH v2 07/16] btrfs: allow mounting filesystems with remap-tree incompat flag
Date: Wed, 13 Aug 2025 15:34:49 +0100
Message-ID: <20250813143509.31073-8-mark@harmstone.com>
In-Reply-To: <20250813143509.31073-1-mark@harmstone.com>
References: <20250813143509.31073-1-mark@harmstone.com>
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
---
 fs/btrfs/Kconfig                |  2 +
 fs/btrfs/accessors.h            |  6 +++
 fs/btrfs/disk-io.c              | 86 ++++++++++++++++++++++++++++-----
 fs/btrfs/extent-tree.c          |  2 +
 fs/btrfs/fs.h                   |  4 +-
 fs/btrfs/transaction.c          |  7 +++
 include/uapi/linux/btrfs_tree.h |  5 +-
 7 files changed, 97 insertions(+), 15 deletions(-)

diff --git a/fs/btrfs/Kconfig b/fs/btrfs/Kconfig
index ea95c90c8474..598a4af4ce4b 100644
--- a/fs/btrfs/Kconfig
+++ b/fs/btrfs/Kconfig
@@ -116,6 +116,8 @@ config BTRFS_EXPERIMENTAL
 
 	  - large folio support
 
+	  - remap-tree - logical address remapping tree
+
 	  If unsure, say N.
 
 config BTRFS_FS_REF_VERIFY
diff --git a/fs/btrfs/accessors.h b/fs/btrfs/accessors.h
index 0dd161ee6863..392eaad75e72 100644
--- a/fs/btrfs/accessors.h
+++ b/fs/btrfs/accessors.h
@@ -882,6 +882,12 @@ BTRFS_SETGET_STACK_FUNCS(super_uuid_tree_generation, struct btrfs_super_block,
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
index 8e9520119d4f..563aea5e3b1b 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -1181,6 +1181,8 @@ static struct btrfs_root *btrfs_get_global_root(struct btrfs_fs_info *fs_info,
 		return btrfs_grab_root(btrfs_global_root(fs_info, &key));
 	case BTRFS_RAID_STRIPE_TREE_OBJECTID:
 		return btrfs_grab_root(fs_info->stripe_root);
+	case BTRFS_REMAP_TREE_OBJECTID:
+		return btrfs_grab_root(fs_info->remap_root);
 	default:
 		return NULL;
 	}
@@ -1271,6 +1273,7 @@ void btrfs_free_fs_info(struct btrfs_fs_info *fs_info)
 	btrfs_put_root(fs_info->data_reloc_root);
 	btrfs_put_root(fs_info->block_group_root);
 	btrfs_put_root(fs_info->stripe_root);
+	btrfs_put_root(fs_info->remap_root);
 	btrfs_check_leaked_roots(fs_info);
 	btrfs_extent_buffer_leak_debug_check(fs_info);
 	kfree(fs_info->super_copy);
@@ -1825,6 +1828,7 @@ static void free_root_pointers(struct btrfs_fs_info *info, bool free_chunk_root)
 	free_root_extent_buffers(info->data_reloc_root);
 	free_root_extent_buffers(info->block_group_root);
 	free_root_extent_buffers(info->stripe_root);
+	free_root_extent_buffers(info->remap_root);
 	if (free_chunk_root)
 		free_root_extent_buffers(info->chunk_root);
 }
@@ -2256,20 +2260,31 @@ static int btrfs_read_roots(struct btrfs_fs_info *fs_info)
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
-			ret = PTR_ERR(root);
-			goto out;
-		}
-	} else {
+	if (btrfs_fs_incompat(fs_info, REMAP_TREE)) {
+		/* remap_root already loaded in load_important_roots() */
+		root = fs_info->remap_root;
+
 		set_bit(BTRFS_ROOT_TRACK_DIRTY, &root->state);
-		fs_info->data_reloc_root = root;
+
+		root->root_key.objectid = BTRFS_REMAP_TREE_OBJECTID;
+		root->root_key.type = BTRFS_ROOT_ITEM_KEY;
+		root->root_key.offset = 0;
+	} else {
+		/*
+		 * This tree can share blocks with some other fs tree during
+		 * relocation and we need a proper setup by btrfs_get_fs_root
+		 */
+		root = btrfs_get_fs_root(tree_root->fs_info,
+					 BTRFS_DATA_RELOC_TREE_OBJECTID, true);
+		if (IS_ERR(root)) {
+			if (!btrfs_test_opt(fs_info, IGNOREBADROOTS)) {
+				ret = PTR_ERR(root);
+				goto out;
+			}
+		} else {
+			set_bit(BTRFS_ROOT_TRACK_DIRTY, &root->state);
+			fs_info->data_reloc_root = root;
+		}
 	}
 
 	location.objectid = BTRFS_QUOTA_TREE_OBJECTID;
@@ -2509,6 +2524,28 @@ int btrfs_validate_super(const struct btrfs_fs_info *fs_info,
 		ret = -EINVAL;
 	}
 
+	/* Ditto for remap_tree */
+	if (btrfs_fs_incompat(fs_info, REMAP_TREE) &&
+	    (!btrfs_fs_compat_ro(fs_info, FREE_SPACE_TREE_VALID) ||
+	     !btrfs_fs_incompat(fs_info, NO_HOLES) ||
+	     !btrfs_fs_compat_ro(fs_info, BLOCK_GROUP_TREE))) {
+		btrfs_err(fs_info,
+"remap-tree feature requires free-space-tree, no-holes, and block-group-tree");
+		ret = -EINVAL;
+	}
+
+	if (btrfs_fs_incompat(fs_info, REMAP_TREE) &&
+	    btrfs_fs_incompat(fs_info, MIXED_GROUPS)) {
+		btrfs_err(fs_info, "remap-tree not supported with mixed-bg");
+		ret = -EINVAL;
+	}
+
+	if (btrfs_fs_incompat(fs_info, REMAP_TREE) &&
+	    btrfs_fs_incompat(fs_info, ZONED)) {
+		btrfs_err(fs_info, "remap-tree not supported with zoned devices");
+		ret = -EINVAL;
+	}
+
 	/*
 	 * Hint to catch really bogus numbers, bitflips or so, more exact checks are
 	 * done later
@@ -2667,6 +2704,18 @@ static int load_important_roots(struct btrfs_fs_info *fs_info)
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
 
@@ -3278,6 +3327,7 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 	struct btrfs_fs_info *fs_info = btrfs_sb(sb);
 	struct btrfs_root *tree_root;
 	struct btrfs_root *chunk_root;
+	struct btrfs_root *remap_root;
 	int ret;
 	int level;
 
@@ -3312,6 +3362,16 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 		goto fail_alloc;
 	}
 
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
 	btrfs_info(fs_info, "first mount of filesystem %pU", disk_super->fsid);
 	/*
 	 * Verify the type first, if that or the checksum value are
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 5e038ae1a93f..c1b96c728fe6 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -2589,6 +2589,8 @@ static u64 get_alloc_profile_by_root(struct btrfs_root *root, int data)
 		flags = BTRFS_BLOCK_GROUP_DATA;
 	else if (root == fs_info->chunk_root)
 		flags = BTRFS_BLOCK_GROUP_SYSTEM;
+	else if (root == fs_info->remap_root)
+		flags = BTRFS_BLOCK_GROUP_REMAP;
 	else
 		flags = BTRFS_BLOCK_GROUP_METADATA;
 
diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
index 9ce75843b578..6ea96e76655e 100644
--- a/fs/btrfs/fs.h
+++ b/fs/btrfs/fs.h
@@ -288,7 +288,8 @@ enum {
 #define BTRFS_FEATURE_INCOMPAT_SUPP		\
 	(BTRFS_FEATURE_INCOMPAT_SUPP_STABLE |	\
 	 BTRFS_FEATURE_INCOMPAT_RAID_STRIPE_TREE | \
-	 BTRFS_FEATURE_INCOMPAT_EXTENT_TREE_V2)
+	 BTRFS_FEATURE_INCOMPAT_EXTENT_TREE_V2 | \
+	 BTRFS_FEATURE_INCOMPAT_REMAP_TREE)
 
 #else
 
@@ -438,6 +439,7 @@ struct btrfs_fs_info {
 	struct btrfs_root *data_reloc_root;
 	struct btrfs_root *block_group_root;
 	struct btrfs_root *stripe_root;
+	struct btrfs_root *remap_root;
 
 	/* The log root tree is a directory of all the other log roots */
 	struct btrfs_root *log_root_tree;
diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index c5c0d9cf1a80..64b9c427af6a 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -1953,6 +1953,13 @@ static void update_super_roots(struct btrfs_fs_info *fs_info)
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
index 500e3a7df90b..89bcb80081a6 100644
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
2.49.1


