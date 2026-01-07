Return-Path: <linux-btrfs+bounces-20193-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 92B8ACFE396
	for <lists+linux-btrfs@lfdr.de>; Wed, 07 Jan 2026 15:17:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 10FCD3049E32
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Jan 2026 14:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C92A32D0C4;
	Wed,  7 Jan 2026 14:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=harmstone.com header.i=@harmstone.com header.b="UIcKJxQY"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail.burntcomma.com (mail2.burntcomma.com [217.169.27.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C30F2320393
	for <linux-btrfs@vger.kernel.org>; Wed,  7 Jan 2026 14:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.169.27.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767795029; cv=none; b=W6WvRoQkGonR1dXxZ+5e4FxvT2L3031lFXPOL1cAP0si9lr+pDywF2fKQadMzXKNzu/E8tqxxKkFLu74Ls8AwowHJSLL7OvCIlIRGjkFm+7uRwo4JC2zyOcYU3my7tP/ZQmVktpmfUTN/Mo5jytXCnVCuA2VA7lJaxjDfhmEmuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767795029; c=relaxed/simple;
	bh=DaXA3wt144oQGCKpuhMKnNgB7Gj1hf4ZSi4cP0Erlgk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Mime-Version; b=A4/ua/4GFb70rWoLH/puYi3voyoW5UMRRPQm84//o18UmuPISZXXNH+lTCi/BzgANaSDMkZwGzqF/Q1GG69vwv6fE8S/BZpqLpdCql/3DoLbqAwemmYZPif6oyprw7nhxCJOH9LRoU6BZEoFspaaJV0MrP/hfjqCErforqITwqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=harmstone.com; spf=pass smtp.mailfrom=harmstone.com; dkim=pass (1024-bit key) header.d=harmstone.com header.i=@harmstone.com header.b=UIcKJxQY; arc=none smtp.client-ip=217.169.27.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=harmstone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=harmstone.com
Received: from beren (beren.burntcomma.com [IPv6:2a02:8012:8cf0:0:ce28:aaff:fe0d:6db2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.burntcomma.com (Postfix) with ESMTPSA id 141C32F1867;
	Wed,  7 Jan 2026 14:10:18 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=harmstone.com;
	s=mail; t=1767795018;
	bh=jJZ+GHiBi35e3MgK3rYRc/1uzo133Fz8sw6a8qfWgdI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UIcKJxQYSEbkZmFPCfGNEpqgl+Ii17cTTYeSLigT5DjQuLS+S2qI0qH8dkUre5L+a
	 JbY7u7oWa43Em84WQzggcb6inDST65eyi58ehYG6Ik6mTntuWk8hY4G9m+4FLaEC/d
	 EeexHvCTu/91hGnqMsS2bunQTo5VJQvacUDWDtsI=
From: Mark Harmstone <mark@harmstone.com>
To: linux-btrfs@vger.kernel.org
Cc: Mark Harmstone <mark@harmstone.com>,
	Boris Burkov <boris@bur.io>
Subject: [PATCH v8 01/17] btrfs: add definitions and constants for remap-tree
Date: Wed,  7 Jan 2026 14:09:01 +0000
Message-ID: <20260107141015.25819-2-mark@harmstone.com>
In-Reply-To: <20260107141015.25819-1-mark@harmstone.com>
References: <20260107141015.25819-1-mark@harmstone.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit

Add an incompat flag for the new remap-tree feature, and the constants
and definitions needed to support it.

Signed-off-by: Mark Harmstone <mark@harmstone.com>
Reviewed-by: Boris Burkov <boris@bur.io>
---
 fs/btrfs/accessors.h            |  4 ++++
 fs/btrfs/locking.c              |  1 +
 fs/btrfs/sysfs.c                |  2 ++
 fs/btrfs/tree-checker.c         |  6 ++----
 fs/btrfs/tree-checker.h         |  5 +++++
 fs/btrfs/volumes.c              |  1 +
 include/uapi/linux/btrfs.h      |  1 +
 include/uapi/linux/btrfs_tree.h | 17 +++++++++++++++++
 8 files changed, 33 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/accessors.h b/fs/btrfs/accessors.h
index 78721412951c..09cdd6bfddf5 100644
--- a/fs/btrfs/accessors.h
+++ b/fs/btrfs/accessors.h
@@ -1010,6 +1010,10 @@ BTRFS_SETGET_STACK_FUNCS(stack_verity_descriptor_encryption,
 BTRFS_SETGET_STACK_FUNCS(stack_verity_descriptor_size,
 			 struct btrfs_verity_descriptor_item, size, 64);
 
+BTRFS_SETGET_FUNCS(remap_address, struct btrfs_remap_item, address, 64);
+BTRFS_SETGET_STACK_FUNCS(stack_remap_address, struct btrfs_remap_item,
+			 address, 64);
+
 /* Cast into the data area of the leaf. */
 #define btrfs_item_ptr(leaf, slot, type)				\
 	((type *)(btrfs_item_nr_offset(leaf, 0) + btrfs_item_offset(leaf, slot)))
diff --git a/fs/btrfs/locking.c b/fs/btrfs/locking.c
index 0035851d72b0..e3df5ca0b552 100644
--- a/fs/btrfs/locking.c
+++ b/fs/btrfs/locking.c
@@ -73,6 +73,7 @@ static struct btrfs_lockdep_keyset {
 	{ .id = BTRFS_FREE_SPACE_TREE_OBJECTID,	DEFINE_NAME("free-space") },
 	{ .id = BTRFS_BLOCK_GROUP_TREE_OBJECTID, DEFINE_NAME("block-group") },
 	{ .id = BTRFS_RAID_STRIPE_TREE_OBJECTID, DEFINE_NAME("raid-stripe") },
+	{ .id = BTRFS_REMAP_TREE_OBJECTID,      DEFINE_NAME("remap") },
 	{ .id = 0,				DEFINE_NAME("tree")	},
 };
 
diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index f0974f4c0ae4..0e2ed8072443 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -291,6 +291,7 @@ BTRFS_FEAT_ATTR_COMPAT_RO(free_space_tree, FREE_SPACE_TREE);
 BTRFS_FEAT_ATTR_COMPAT_RO(block_group_tree, BLOCK_GROUP_TREE);
 BTRFS_FEAT_ATTR_INCOMPAT(raid1c34, RAID1C34);
 BTRFS_FEAT_ATTR_INCOMPAT(simple_quota, SIMPLE_QUOTA);
+BTRFS_FEAT_ATTR_INCOMPAT(remap_tree, REMAP_TREE);
 #ifdef CONFIG_BLK_DEV_ZONED
 BTRFS_FEAT_ATTR_INCOMPAT(zoned, ZONED);
 #endif
@@ -331,6 +332,7 @@ static struct attribute *btrfs_supported_feature_attrs[] = {
 #ifdef CONFIG_BTRFS_EXPERIMENTAL
 	BTRFS_FEAT_ATTR_PTR(extent_tree_v2),
 	BTRFS_FEAT_ATTR_PTR(raid_stripe_tree),
+	BTRFS_FEAT_ATTR_PTR(remap_tree),
 #endif
 #ifdef CONFIG_FS_VERITY
 	BTRFS_FEAT_ATTR_PTR(verity),
diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
index c21c21adf61e..aedc208a95b8 100644
--- a/fs/btrfs/tree-checker.c
+++ b/fs/btrfs/tree-checker.c
@@ -913,12 +913,10 @@ int btrfs_check_chunk_valid(const struct btrfs_fs_info *fs_info,
 			  length, btrfs_stripe_nr_to_offset(U32_MAX));
 		return -EUCLEAN;
 	}
-	if (unlikely(type & ~(BTRFS_BLOCK_GROUP_TYPE_MASK |
-			      BTRFS_BLOCK_GROUP_PROFILE_MASK))) {
+	if (unlikely(type & ~BTRFS_BLOCK_GROUP_VALID)) {
 		chunk_err(fs_info, leaf, chunk, logical,
 			  "unrecognized chunk type: 0x%llx",
-			  ~(BTRFS_BLOCK_GROUP_TYPE_MASK |
-			    BTRFS_BLOCK_GROUP_PROFILE_MASK) & type);
+			  type & ~BTRFS_BLOCK_GROUP_VALID);
 		return -EUCLEAN;
 	}
 
diff --git a/fs/btrfs/tree-checker.h b/fs/btrfs/tree-checker.h
index eb201f4ec3c7..833e2fd989eb 100644
--- a/fs/btrfs/tree-checker.h
+++ b/fs/btrfs/tree-checker.h
@@ -57,6 +57,11 @@ enum btrfs_tree_block_status {
 	BTRFS_TREE_BLOCK_WRITTEN_NOT_SET,
 };
 
+
+#define BTRFS_BLOCK_GROUP_VALID	(BTRFS_BLOCK_GROUP_TYPE_MASK | \
+				 BTRFS_BLOCK_GROUP_PROFILE_MASK | \
+				 BTRFS_BLOCK_GROUP_REMAPPED)
+
 /*
  * Exported simply for btrfs-progs which wants to have the
  * btrfs_tree_block_status return codes.
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index ce0535c0264d..1134474926ff 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -231,6 +231,7 @@ void btrfs_describe_block_groups(u64 bg_flags, char *buf, u32 size_buf)
 	DESCRIBE_FLAG(BTRFS_BLOCK_GROUP_DATA, "data");
 	DESCRIBE_FLAG(BTRFS_BLOCK_GROUP_SYSTEM, "system");
 	DESCRIBE_FLAG(BTRFS_BLOCK_GROUP_METADATA, "metadata");
+	DESCRIBE_FLAG(BTRFS_BLOCK_GROUP_REMAPPED, "remapped");
 
 	DESCRIBE_FLAG(BTRFS_AVAIL_ALLOC_BIT_SINGLE, "single");
 	for (i = 0; i < BTRFS_NR_RAID_TYPES; i++)
diff --git a/include/uapi/linux/btrfs.h b/include/uapi/linux/btrfs.h
index e8fd92789423..9165154a274d 100644
--- a/include/uapi/linux/btrfs.h
+++ b/include/uapi/linux/btrfs.h
@@ -336,6 +336,7 @@ struct btrfs_ioctl_fs_info_args {
 #define BTRFS_FEATURE_INCOMPAT_EXTENT_TREE_V2	(1ULL << 13)
 #define BTRFS_FEATURE_INCOMPAT_RAID_STRIPE_TREE	(1ULL << 14)
 #define BTRFS_FEATURE_INCOMPAT_SIMPLE_QUOTA	(1ULL << 16)
+#define BTRFS_FEATURE_INCOMPAT_REMAP_TREE	(1ULL << 17)
 
 struct btrfs_ioctl_feature_flags {
 	__u64 compat_flags;
diff --git a/include/uapi/linux/btrfs_tree.h b/include/uapi/linux/btrfs_tree.h
index fc29d273845d..f011d34cb699 100644
--- a/include/uapi/linux/btrfs_tree.h
+++ b/include/uapi/linux/btrfs_tree.h
@@ -76,6 +76,9 @@
 /* Tracks RAID stripes in block groups. */
 #define BTRFS_RAID_STRIPE_TREE_OBJECTID 12ULL
 
+/* Holds details of remapped addresses after relocation. */
+#define BTRFS_REMAP_TREE_OBJECTID 13ULL
+
 /* device stats in the device tree */
 #define BTRFS_DEV_STATS_OBJECTID 0ULL
 
@@ -282,6 +285,10 @@
 
 #define BTRFS_RAID_STRIPE_KEY	230
 
+#define BTRFS_IDENTITY_REMAP_KEY 	234
+#define BTRFS_REMAP_KEY		 	235
+#define BTRFS_REMAP_BACKREF_KEY	 	236
+
 /*
  * Records the overall state of the qgroups.
  * There's only one instance of this key present,
@@ -1161,6 +1168,7 @@ struct btrfs_dev_replace_item {
 #define BTRFS_BLOCK_GROUP_RAID6         (1ULL << 8)
 #define BTRFS_BLOCK_GROUP_RAID1C3       (1ULL << 9)
 #define BTRFS_BLOCK_GROUP_RAID1C4       (1ULL << 10)
+#define BTRFS_BLOCK_GROUP_REMAPPED      (1ULL << 11)
 #define BTRFS_BLOCK_GROUP_RESERVED	(BTRFS_AVAIL_ALLOC_BIT_SINGLE | \
 					 BTRFS_SPACE_INFO_GLOBAL_RSV)
 
@@ -1323,4 +1331,13 @@ struct btrfs_verity_descriptor_item {
 	__u8 encryption;
 } __attribute__ ((__packed__));
 
+/*
+ * For a range identified by a BTRFS_REMAP_KEY item in the remap tree, gives
+ * the address that the start of the range will get remapped to.  This
+ * structure is also shared by BTRFS_REMAP_BACKREF_KEY.
+ */
+struct btrfs_remap_item {
+	__le64 address;
+} __attribute__ ((__packed__));
+
 #endif /* _BTRFS_CTREE_H_ */
-- 
2.51.2


