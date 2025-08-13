Return-Path: <linux-btrfs+bounces-16052-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4DC0B24C2E
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Aug 2025 16:41:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F1DC681579
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Aug 2025 14:37:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D2F62FF17A;
	Wed, 13 Aug 2025 14:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=harmstone.com header.i=@harmstone.com header.b="0AoTNrJ3"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail.burntcomma.com (mail2.burntcomma.com [217.169.27.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 740B42E541C
	for <linux-btrfs@vger.kernel.org>; Wed, 13 Aug 2025 14:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.169.27.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755095725; cv=none; b=Y6czejgGS+ox6w7EQNLy6Xhtdg4pVyHaASUnuChQNpFf5d1Z1rw5bOBJaxOxwTfKlgFU2qCIPGU5h6RH2wGoprYAokCIm9UpB2XP7ncmFAIrD6Pf6bE6kAHIYAl2LS4DNDT0+oVULiSJ+BROORq3dwkj2IvsbOoEBd50FT05Bck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755095725; c=relaxed/simple;
	bh=tpAdISucuYb22Bje39ol+nvVKEkO1RJzGLsHZEeFHKA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Mime-Version; b=Pl8Zt3/N5hGV/hMbXrkGiVOpINEUDlK6lC/gRLP+jkvDLXa7e8lXSl64xjE8zeK3YSwzxQWbDhOYbChq96ZENZB+Qgx/T/BbmYltVR7N9Xhv45WBO5R27RvHc59JuNDtoMK2cjaM6HX18Nn3j2fN7hXk2hXaAfCqeJqBjlpocRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=harmstone.com; spf=pass smtp.mailfrom=harmstone.com; dkim=pass (1024-bit key) header.d=harmstone.com header.i=@harmstone.com header.b=0AoTNrJ3; arc=none smtp.client-ip=217.169.27.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=harmstone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=harmstone.com
Received: from localhost.localdomain (beren.burntcomma.com [IPv6:2a02:8012:8cf0:0:ce28:aaff:fe0d:6db2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.burntcomma.com (Postfix) with ESMTPSA id 1887E2A7590;
	Wed, 13 Aug 2025 15:35:13 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=harmstone.com;
	s=mail; t=1755095713;
	bh=ONYUtnXCmyLkUawaMMY7rBf+uVLZPstawd+IjIPf6FA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=0AoTNrJ3SiaCWXvnpn6hhK3VRk7bykyomm5D2viMfAFbRVnjIVELJdXsCT2RDGxno
	 Lblr1/Syq67JFIPcWFF/Xe6bF99SNnP8iixUvFYq+lUh4meI6Oz4tZAWRupj5mgZ7P
	 xa+y1bKy8HF6924+N4MrXSM1XzLrD9zob0Xb0I1s=
From: Mark Harmstone <mark@harmstone.com>
To: linux-btrfs@vger.kernel.org
Cc: Mark Harmstone <mark@harmstone.com>
Subject: [PATCH v2 01/16] btrfs: add definitions and constants for remap-tree
Date: Wed, 13 Aug 2025 15:34:43 +0100
Message-ID: <20250813143509.31073-2-mark@harmstone.com>
In-Reply-To: <20250813143509.31073-1-mark@harmstone.com>
References: <20250813143509.31073-1-mark@harmstone.com>
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
---
 fs/btrfs/accessors.h            |  3 +++
 fs/btrfs/locking.c              |  1 +
 fs/btrfs/sysfs.c                |  2 ++
 fs/btrfs/tree-checker.c         |  6 ++----
 fs/btrfs/tree-checker.h         |  5 +++++
 fs/btrfs/volumes.c              |  1 +
 include/uapi/linux/btrfs.h      |  1 +
 include/uapi/linux/btrfs_tree.h | 12 ++++++++++++
 8 files changed, 27 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/accessors.h b/fs/btrfs/accessors.h
index 99b3ced12805..95a1ca8c099b 100644
--- a/fs/btrfs/accessors.h
+++ b/fs/btrfs/accessors.h
@@ -1009,6 +1009,9 @@ BTRFS_SETGET_STACK_FUNCS(stack_verity_descriptor_encryption,
 BTRFS_SETGET_STACK_FUNCS(stack_verity_descriptor_size,
 			 struct btrfs_verity_descriptor_item, size, 64);
 
+BTRFS_SETGET_FUNCS(remap_address, struct btrfs_remap, address, 64);
+BTRFS_SETGET_STACK_FUNCS(stack_remap_address, struct btrfs_remap, address, 64);
+
 /* Cast into the data area of the leaf. */
 #define btrfs_item_ptr(leaf, slot, type)				\
 	((type *)(btrfs_item_nr_offset(leaf, 0) + btrfs_item_offset(leaf, slot)))
diff --git a/fs/btrfs/locking.c b/fs/btrfs/locking.c
index a3e6d9616e60..26f810258486 100644
--- a/fs/btrfs/locking.c
+++ b/fs/btrfs/locking.c
@@ -73,6 +73,7 @@ static struct btrfs_lockdep_keyset {
 	{ .id = BTRFS_FREE_SPACE_TREE_OBJECTID,	DEFINE_NAME("free-space") },
 	{ .id = BTRFS_BLOCK_GROUP_TREE_OBJECTID, DEFINE_NAME("block-group") },
 	{ .id = BTRFS_RAID_STRIPE_TREE_OBJECTID, DEFINE_NAME("raid-stripe") },
+	{ .id = BTRFS_REMAP_TREE_OBJECTID,      DEFINE_NAME("remap-tree") },
 	{ .id = 0,				DEFINE_NAME("tree")	},
 };
 
diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index 81f52c1f55ce..857d2772db1c 100644
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
@@ -325,6 +326,7 @@ static struct attribute *btrfs_supported_feature_attrs[] = {
 	BTRFS_FEAT_ATTR_PTR(raid1c34),
 	BTRFS_FEAT_ATTR_PTR(block_group_tree),
 	BTRFS_FEAT_ATTR_PTR(simple_quota),
+	BTRFS_FEAT_ATTR_PTR(remap_tree),
 #ifdef CONFIG_BLK_DEV_ZONED
 	BTRFS_FEAT_ATTR_PTR(zoned),
 #endif
diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
index 0f556f4de3f9..76ec3698f197 100644
--- a/fs/btrfs/tree-checker.c
+++ b/fs/btrfs/tree-checker.c
@@ -912,12 +912,10 @@ int btrfs_check_chunk_valid(const struct btrfs_fs_info *fs_info,
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
index fa7a929a0461..e067e9cd68a5 100644
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
index 8e710bbb688e..fba303ed49e6 100644
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
index fc29d273845d..4439d77a7252 100644
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
 
@@ -1323,4 +1331,8 @@ struct btrfs_verity_descriptor_item {
 	__u8 encryption;
 } __attribute__ ((__packed__));
 
+struct btrfs_remap {
+	__le64 address;
+} __attribute__ ((__packed__));
+
 #endif /* _BTRFS_CTREE_H_ */
-- 
2.49.1


