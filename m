Return-Path: <linux-btrfs+bounces-18299-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57B9DC07ACB
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Oct 2025 20:15:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 575603B393E
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Oct 2025 18:12:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18247346E6E;
	Fri, 24 Oct 2025 18:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=harmstone.com header.i=@harmstone.com header.b="EN9hi6Gm"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail.burntcomma.com (mail2.burntcomma.com [217.169.27.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 874CC344033
	for <linux-btrfs@vger.kernel.org>; Fri, 24 Oct 2025 18:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.169.27.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761329562; cv=none; b=llDyl0b1QowF6P0NmnpatODIINPyluxsfetdKO+LYDPjxOQ+FLZVdZMosrRAOM/lShKKyhvs5LoViXqSX4q4rI5pdXwlkXsKfGP5ZKgpcES4fETiWbUdn1X/tJXRGcs5ltfeoJieR3Kihlj67mlxif5ACclgErLz2iFyAFBy0b4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761329562; c=relaxed/simple;
	bh=YaaQ6wIDQy7GPVd0zM9el5Cjvqta5w0kXL0IMQeP9YU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Mime-Version; b=U8/KWR+6NCAm8hLSXa1vIvGBnVw918dxEfleEaLpRj0cC863HYjWqX0g48AqJfgCNslitFjdlFLpBPpl8I3BNBRQpwsRq3+TCSRDFeoWJW+NDj1tsuErm3d/MhXrc2CA8YmRw4mP8fFlbW6qTFUwJMBETVmQjFM0BiJhoowNmvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=harmstone.com; spf=pass smtp.mailfrom=harmstone.com; dkim=pass (1024-bit key) header.d=harmstone.com header.i=@harmstone.com header.b=EN9hi6Gm; arc=none smtp.client-ip=217.169.27.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=harmstone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=harmstone.com
Received: from localhost.localdomain (beren.burntcomma.com [IPv6:2a02:8012:8cf0:0:ce28:aaff:fe0d:6db2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.burntcomma.com (Postfix) with ESMTPSA id 4D6B42CFE47;
	Fri, 24 Oct 2025 19:12:30 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=harmstone.com;
	s=mail; t=1761329550;
	bh=ICNEiVIxvNBhDHDNESkZ/n9xGdRy90+3mL7HZhnU9bo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EN9hi6GmOb12AYIqELozdI1jwU0XSOyqPF7FTpIjCA3Oon2lnAaJRHkKP2gjE9hvJ
	 45UwC71SUmsp0ZErPvv0zf0ljZD/uQPeAusDic21G+Pr00H9dsEae8A/xjL/QE4JpA
	 r+hBX8e8pmkTWm/xRll9izy0cKQjMdmQ6/Gv4Og0=
From: Mark Harmstone <mark@harmstone.com>
To: linux-btrfs@vger.kernel.org
Cc: Mark Harmstone <mark@harmstone.com>,
	Boris Burkov <boris@bur.io>
Subject: [PATCH v4 02/16] btrfs: add REMAP chunk type
Date: Fri, 24 Oct 2025 19:12:03 +0100
Message-ID: <20251024181227.32228-3-mark@harmstone.com>
In-Reply-To: <20251024181227.32228-1-mark@harmstone.com>
References: <20251024181227.32228-1-mark@harmstone.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a new REMAP chunk type, which is a metadata chunk that holds the
remap tree.

This is needed for bootstrapping purposes: the remap tree can't itself
be remapped, and must be relocated the existing way, by COWing every
leaf. The remap tree can't go in the SYSTEM chunk as space there is
limited, because a copy of the chunk item gets placed in the superblock.

The changes in fs/btrfs/volumes.h are because we're adding a new block
group type bit after the profile bits, and so can no longer rely on the
const_ilog2 trick.

The sizing to 32MB per chunk, matching the SYSTEM chunk, is an estimate
here, we can adjust it later if it proves to be too big or too small.
This works out to be ~500,000 remap items, which for a 4KB block size
covers ~2GB of remapped data in the worst case and ~500TB in the best case.

Signed-off-by: Mark Harmstone <mark@harmstone.com>
Reviewed-by: Boris Burkov <boris@bur.io>
---
 fs/btrfs/block-rsv.c            |  8 ++++++++
 fs/btrfs/block-rsv.h            |  1 +
 fs/btrfs/disk-io.c              |  1 +
 fs/btrfs/fs.h                   |  2 ++
 fs/btrfs/space-info.c           | 13 ++++++++++++-
 fs/btrfs/sysfs.c                |  2 ++
 fs/btrfs/tree-checker.c         | 13 +++++++++++--
 fs/btrfs/volumes.c              |  3 +++
 fs/btrfs/volumes.h              | 11 +++++++++--
 include/uapi/linux/btrfs_tree.h |  4 +++-
 10 files changed, 52 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/block-rsv.c b/fs/btrfs/block-rsv.c
index 96cf7a162987..71bcaa6fa7ee 100644
--- a/fs/btrfs/block-rsv.c
+++ b/fs/btrfs/block-rsv.c
@@ -419,6 +419,9 @@ void btrfs_init_root_block_rsv(struct btrfs_root *root)
 	case BTRFS_TREE_LOG_OBJECTID:
 		root->block_rsv = &fs_info->treelog_rsv;
 		break;
+	case BTRFS_REMAP_TREE_OBJECTID:
+		root->block_rsv = &fs_info->remap_block_rsv;
+		break;
 	default:
 		root->block_rsv = NULL;
 		break;
@@ -432,6 +435,9 @@ void btrfs_init_global_block_rsv(struct btrfs_fs_info *fs_info)
 	space_info = btrfs_find_space_info(fs_info, BTRFS_BLOCK_GROUP_SYSTEM);
 	fs_info->chunk_block_rsv.space_info = space_info;
 
+	space_info = btrfs_find_space_info(fs_info, BTRFS_BLOCK_GROUP_REMAP);
+	fs_info->remap_block_rsv.space_info = space_info;
+
 	space_info = btrfs_find_space_info(fs_info, BTRFS_BLOCK_GROUP_METADATA);
 	fs_info->global_block_rsv.space_info = space_info;
 	fs_info->trans_block_rsv.space_info = space_info;
@@ -458,6 +464,8 @@ void btrfs_release_global_block_rsv(struct btrfs_fs_info *fs_info)
 	WARN_ON(fs_info->trans_block_rsv.reserved > 0);
 	WARN_ON(fs_info->chunk_block_rsv.size > 0);
 	WARN_ON(fs_info->chunk_block_rsv.reserved > 0);
+	WARN_ON(fs_info->remap_block_rsv.size > 0);
+	WARN_ON(fs_info->remap_block_rsv.reserved > 0);
 	WARN_ON(fs_info->delayed_block_rsv.size > 0);
 	WARN_ON(fs_info->delayed_block_rsv.reserved > 0);
 	WARN_ON(fs_info->delayed_refs_rsv.reserved > 0);
diff --git a/fs/btrfs/block-rsv.h b/fs/btrfs/block-rsv.h
index 79ae9d05cd91..8359fb96bc3c 100644
--- a/fs/btrfs/block-rsv.h
+++ b/fs/btrfs/block-rsv.h
@@ -22,6 +22,7 @@ enum btrfs_rsv_type {
 	BTRFS_BLOCK_RSV_DELALLOC,
 	BTRFS_BLOCK_RSV_TRANS,
 	BTRFS_BLOCK_RSV_CHUNK,
+	BTRFS_BLOCK_RSV_REMAP,
 	BTRFS_BLOCK_RSV_DELOPS,
 	BTRFS_BLOCK_RSV_DELREFS,
 	BTRFS_BLOCK_RSV_TREELOG,
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 0aa7e5d1b05f..0bf78ae2060d 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -2816,6 +2816,7 @@ void btrfs_init_fs_info(struct btrfs_fs_info *fs_info)
 			     BTRFS_BLOCK_RSV_GLOBAL);
 	btrfs_init_block_rsv(&fs_info->trans_block_rsv, BTRFS_BLOCK_RSV_TRANS);
 	btrfs_init_block_rsv(&fs_info->chunk_block_rsv, BTRFS_BLOCK_RSV_CHUNK);
+	btrfs_init_block_rsv(&fs_info->remap_block_rsv, BTRFS_BLOCK_RSV_REMAP);
 	btrfs_init_block_rsv(&fs_info->treelog_rsv, BTRFS_BLOCK_RSV_TREELOG);
 	btrfs_init_block_rsv(&fs_info->empty_block_rsv, BTRFS_BLOCK_RSV_EMPTY);
 	btrfs_init_block_rsv(&fs_info->delayed_block_rsv,
diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
index ad389fb1c01a..40a25f9f617e 100644
--- a/fs/btrfs/fs.h
+++ b/fs/btrfs/fs.h
@@ -495,6 +495,8 @@ struct btrfs_fs_info {
 	struct btrfs_block_rsv trans_block_rsv;
 	/* Block reservation for chunk tree */
 	struct btrfs_block_rsv chunk_block_rsv;
+	/* Block reservation for remap tree */
+	struct btrfs_block_rsv remap_block_rsv;
 	/* Block reservation for delayed operations */
 	struct btrfs_block_rsv delayed_block_rsv;
 	/* Block reservation for delayed refs */
diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 69237f5d6078..a2ce72d3e873 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -215,7 +215,7 @@ static u64 calc_chunk_size(const struct btrfs_fs_info *fs_info, u64 flags)
 
 	if (flags & BTRFS_BLOCK_GROUP_DATA)
 		return BTRFS_MAX_DATA_CHUNK_SIZE;
-	else if (flags & BTRFS_BLOCK_GROUP_SYSTEM)
+	else if (flags & (BTRFS_BLOCK_GROUP_SYSTEM | BTRFS_BLOCK_GROUP_REMAP))
 		return SZ_32M;
 
 	/* Handle BTRFS_BLOCK_GROUP_METADATA */
@@ -343,6 +343,8 @@ int btrfs_init_space_info(struct btrfs_fs_info *fs_info)
 	if (mixed) {
 		flags = BTRFS_BLOCK_GROUP_METADATA | BTRFS_BLOCK_GROUP_DATA;
 		ret = create_space_info(fs_info, flags);
+		if (ret)
+			goto out;
 	} else {
 		flags = BTRFS_BLOCK_GROUP_METADATA;
 		ret = create_space_info(fs_info, flags);
@@ -351,7 +353,15 @@ int btrfs_init_space_info(struct btrfs_fs_info *fs_info)
 
 		flags = BTRFS_BLOCK_GROUP_DATA;
 		ret = create_space_info(fs_info, flags);
+		if (ret)
+			goto out;
+	}
+
+	if (features & BTRFS_FEATURE_INCOMPAT_REMAP_TREE) {
+		flags = BTRFS_BLOCK_GROUP_REMAP;
+		ret = create_space_info(fs_info, flags);
 	}
+
 out:
 	return ret;
 }
@@ -587,6 +597,7 @@ static void dump_global_block_rsv(struct btrfs_fs_info *fs_info)
 	DUMP_BLOCK_RSV(fs_info, global_block_rsv);
 	DUMP_BLOCK_RSV(fs_info, trans_block_rsv);
 	DUMP_BLOCK_RSV(fs_info, chunk_block_rsv);
+	DUMP_BLOCK_RSV(fs_info, remap_block_rsv);
 	DUMP_BLOCK_RSV(fs_info, delayed_block_rsv);
 	DUMP_BLOCK_RSV(fs_info, delayed_refs_rsv);
 }
diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index 9e1ba524d26a..4ac68dc7e0c0 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -1973,6 +1973,8 @@ static const char *alloc_name(struct btrfs_space_info *space_info)
 	case BTRFS_BLOCK_GROUP_SYSTEM:
 		ASSERT(space_info->subgroup_id == BTRFS_SUB_GROUP_PRIMARY);
 		return "system";
+	case BTRFS_BLOCK_GROUP_REMAP:
+		return "remap";
 	default:
 		WARN_ON(1);
 		return "invalid-combination";
diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
index af9a26844113..681c5c7fae35 100644
--- a/fs/btrfs/tree-checker.c
+++ b/fs/btrfs/tree-checker.c
@@ -748,17 +748,26 @@ static int check_block_group_item(struct extent_buffer *leaf,
 		return -EUCLEAN;
 	}
 
+	if (flags & BTRFS_BLOCK_GROUP_REMAP &&
+		!btrfs_fs_incompat(fs_info, REMAP_TREE)) {
+		block_group_err(leaf, slot,
+"invalid flags, have 0x%llx (REMAP flag set) but no remap-tree incompat flag",
+				flags);
+		return -EUCLEAN;
+	}
+
 	type = flags & BTRFS_BLOCK_GROUP_TYPE_MASK;
 	if (unlikely(type != BTRFS_BLOCK_GROUP_DATA &&
 		     type != BTRFS_BLOCK_GROUP_METADATA &&
 		     type != BTRFS_BLOCK_GROUP_SYSTEM &&
+		     type != BTRFS_BLOCK_GROUP_REMAP &&
 		     type != (BTRFS_BLOCK_GROUP_METADATA |
 			      BTRFS_BLOCK_GROUP_DATA))) {
 		block_group_err(leaf, slot,
-"invalid type, have 0x%llx (%lu bits set) expect either 0x%llx, 0x%llx, 0x%llx or 0x%llx",
+"invalid type, have 0x%llx (%lu bits set) expect either 0x%llx, 0x%llx, 0x%llx, 0x%llx or 0x%llx",
 			type, hweight64(type),
 			BTRFS_BLOCK_GROUP_DATA, BTRFS_BLOCK_GROUP_METADATA,
-			BTRFS_BLOCK_GROUP_SYSTEM,
+			BTRFS_BLOCK_GROUP_SYSTEM, BTRFS_BLOCK_GROUP_REMAP,
 			BTRFS_BLOCK_GROUP_METADATA | BTRFS_BLOCK_GROUP_DATA);
 		return -EUCLEAN;
 	}
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 63e5a17f96f9..82b8189f3e81 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -231,6 +231,9 @@ void btrfs_describe_block_groups(u64 bg_flags, char *buf, u32 size_buf)
 	DESCRIBE_FLAG(BTRFS_BLOCK_GROUP_DATA, "data");
 	DESCRIBE_FLAG(BTRFS_BLOCK_GROUP_SYSTEM, "system");
 	DESCRIBE_FLAG(BTRFS_BLOCK_GROUP_METADATA, "metadata");
+	/* block groups containing the remap tree */
+	DESCRIBE_FLAG(BTRFS_BLOCK_GROUP_REMAP, "remap");
+	/* block group that has been remapped */
 	DESCRIBE_FLAG(BTRFS_BLOCK_GROUP_REMAPPED, "remapped");
 
 	DESCRIBE_FLAG(BTRFS_AVAIL_ALLOC_BIT_SINGLE, "single");
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index adbd9e6c09ff..7cf76bffcab6 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -58,8 +58,6 @@ static_assert(const_ilog2(BTRFS_STRIPE_LEN) == BTRFS_STRIPE_LEN_SHIFT);
  */
 static_assert(const_ffs(BTRFS_BLOCK_GROUP_RAID0) <
 	      const_ffs(BTRFS_BLOCK_GROUP_PROFILE_MASK & ~BTRFS_BLOCK_GROUP_RAID0));
-static_assert(const_ilog2(BTRFS_BLOCK_GROUP_RAID0) >
-	      ilog2(BTRFS_BLOCK_GROUP_TYPE_MASK));
 
 /* ilog2() can handle both constants and variables */
 #define BTRFS_BG_FLAG_TO_INDEX(profile)					\
@@ -81,6 +79,15 @@ enum btrfs_raid_types {
 	BTRFS_NR_RAID_TYPES
 };
 
+static_assert(BTRFS_RAID_RAID0 == 1);
+static_assert(BTRFS_RAID_RAID1 == 2);
+static_assert(BTRFS_RAID_DUP == 3);
+static_assert(BTRFS_RAID_RAID10 == 4);
+static_assert(BTRFS_RAID_RAID5 == 5);
+static_assert(BTRFS_RAID_RAID6 == 6);
+static_assert(BTRFS_RAID_RAID1C3 == 7);
+static_assert(BTRFS_RAID_RAID1C4 == 8);
+
 /*
  * Use sequence counter to get consistent device stat data on
  * 32-bit processors.
diff --git a/include/uapi/linux/btrfs_tree.h b/include/uapi/linux/btrfs_tree.h
index 4439d77a7252..9a36f0206d90 100644
--- a/include/uapi/linux/btrfs_tree.h
+++ b/include/uapi/linux/btrfs_tree.h
@@ -1169,12 +1169,14 @@ struct btrfs_dev_replace_item {
 #define BTRFS_BLOCK_GROUP_RAID1C3       (1ULL << 9)
 #define BTRFS_BLOCK_GROUP_RAID1C4       (1ULL << 10)
 #define BTRFS_BLOCK_GROUP_REMAPPED      (1ULL << 11)
+#define BTRFS_BLOCK_GROUP_REMAP         (1ULL << 12)
 #define BTRFS_BLOCK_GROUP_RESERVED	(BTRFS_AVAIL_ALLOC_BIT_SINGLE | \
 					 BTRFS_SPACE_INFO_GLOBAL_RSV)
 
 #define BTRFS_BLOCK_GROUP_TYPE_MASK	(BTRFS_BLOCK_GROUP_DATA |    \
 					 BTRFS_BLOCK_GROUP_SYSTEM |  \
-					 BTRFS_BLOCK_GROUP_METADATA)
+					 BTRFS_BLOCK_GROUP_METADATA | \
+					 BTRFS_BLOCK_GROUP_REMAP)
 
 #define BTRFS_BLOCK_GROUP_PROFILE_MASK	(BTRFS_BLOCK_GROUP_RAID0 |   \
 					 BTRFS_BLOCK_GROUP_RAID1 |   \
-- 
2.49.1


