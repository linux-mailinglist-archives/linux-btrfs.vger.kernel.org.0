Return-Path: <linux-btrfs+bounces-14050-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 82ADDAB8C98
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 May 2025 18:37:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD1251897B73
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 May 2025 16:37:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9800122068D;
	Thu, 15 May 2025 16:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="j/1ELp+q"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B255218AA3
	for <linux-btrfs@vger.kernel.org>; Thu, 15 May 2025 16:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747327023; cv=none; b=FXXc6YiERw33B7J3mmr9scnu8d4PHmcP0TQ/bm5LK6YSHzH99Zum/OBTOLwrRzt7sy2lwS9kBVuE7LU63ZYg2RKoiJO3i9cY057qw1Ai2bjUgm+PpMcJgnIbyx+sMXVuFLr3hqFiWODsSWekQasX+Q8EugQBAZAz/gZZp4wkJOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747327023; c=relaxed/simple;
	bh=07o0JP5y2tI5j9o/ql1FY2dbMgqYL4TWRze05ssP7cI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KNMgBseqsLlmW4x+mKj0Bg3SVgRkc1kWmfLK+PeWldtxeajyhxuujRGNJ3ygzzd6uJyHKXSmPQkZ40qsit9lZdOiTTrwEDCrUOdnWCZvZhfByXuUeWerDFWBn9YssQ6LBy2jFSuxFONElOWJO3xSXF9qy4TWzoXlt+S7scKZTfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b=j/1ELp+q; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54FFi9Qg026893
	for <linux-btrfs@vger.kernel.org>; Thu, 15 May 2025 09:37:01 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=facebook; bh=1
	uVwLr2W++BBC+HV7NZeiSoPHIupB/8MH/T4WzKBCck=; b=j/1ELp+q0FqPdo0Ta
	uoIzASGQ3eMBVRKyz2GPao0OsfwdwIl+14T71FqwjOGo+KuNmliswY5eDHg8ujq+
	gnVS6kPXEr/mXrnndCeqn8PaZGrYSHZrcn+HwFzbJEyS7W+3oNF/GJ38YBRax++4
	rGBaLdaY/Fo+U9ieL7Vh9xsmZI=
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 46n9gfv9p5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-btrfs@vger.kernel.org>; Thu, 15 May 2025 09:37:01 -0700 (PDT)
Received: from twshared32179.32.frc3.facebook.com (2620:10d:c085:108::150d) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1748.10; Thu, 15 May 2025 16:37:00 +0000
Received: by devbig276.nha1.facebook.com (Postfix, from userid 660015)
	id 7EF51F3BE106; Thu, 15 May 2025 17:36:47 +0100 (BST)
From: Mark Harmstone <maharmstone@fb.com>
To: <linux-btrfs@vger.kernel.org>
CC: Mark Harmstone <maharmstone@fb.com>
Subject: [RFC PATCH 02/10] btrfs: add REMAP chunk type
Date: Thu, 15 May 2025 17:36:30 +0100
Message-ID: <20250515163641.3449017-3-maharmstone@fb.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250515163641.3449017-1-maharmstone@fb.com>
References: <20250515163641.3449017-1-maharmstone@fb.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: mvUfdiF9Sv3d-6QiPwev_QK48gcw_yO9
X-Authority-Analysis: v=2.4 cv=famty1QF c=1 sm=1 tr=0 ts=6826182d cx=c_pps a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17 a=dt9VzEwgFbYA:10 a=FOH2dFAWAAAA:8 a=H134O3fF1iUYwrnXQt4A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE1MDE2NCBTYWx0ZWRfXwVhOwvUj5MoX tlLgxEkPlkhy4CNvHOcSUIab0isk4cRxirD3Wn/skO9ErZV4x7ukJ6qTh8z9BGq7AFwL+HKI+9u ja4ZnxWA4rz4dR8m5K4VZv72/yJManfKozk2pYKd36LaUcZVAw+5hlVP69o6ZfFZreLv9LWk0uw
 7yWl1rLTa/1PKA1ElN/NgvDynmmjEHpgZ/+60tOtjConkrf50KwSQHrIsAmQKo8ctwhdjTO6On0 oANziVvH6bF3bOPuJ2mNNimlix32ETmBr2hVVIf7GoRQk1/VoO+6vc7R0iSd40mrdFShdHbgaQ4 HVuya2zUcparO9F5mhpLP+LwoqedjFScGRy3RHfXI62AS2OIwpN0jvD0gKCoCdbjgfZNMdBeA04
 Z+Si72/+B3eIZKTb++trX3KUjukAYTY3HQsQq0cBxNuPZOtCSCfMp8Wu/qWP0KQmltMuiWJF
X-Proofpoint-ORIG-GUID: mvUfdiF9Sv3d-6QiPwev_QK48gcw_yO9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-15_07,2025-05-15_01,2025-03-28_01

Add a new REMAP chunk type, which is a metadata chunk that holds the
remap tree.

This is needed for bootstrapping purposes: the remap tree can't itself
be remapped, and must be relocated the existing way, by COWing every
leaf. The remap tree can't go in the SYSTEM chunk as space there is
limited, because a copy of the chunk item gets placed in the superblock.

The changes in fs/btrfs/volumes.h are because we're adding a new block
group type bit after the profile bits, and so can no longer rely on the
const_ilog2 trick.

Signed-off-by: Mark Harmstone <maharmstone@fb.com>
---
 fs/btrfs/block-rsv.c            |  8 ++++++++
 fs/btrfs/block-rsv.h            |  1 +
 fs/btrfs/disk-io.c              |  1 +
 fs/btrfs/fs.h                   |  2 ++
 fs/btrfs/space-info.c           | 11 +++++++++++
 fs/btrfs/sysfs.c                |  2 ++
 fs/btrfs/tree-checker.c         |  5 +++--
 fs/btrfs/volumes.c              |  7 +++++++
 fs/btrfs/volumes.h              | 11 +++++++++--
 include/uapi/linux/btrfs_tree.h |  4 +++-
 10 files changed, 47 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/block-rsv.c b/fs/btrfs/block-rsv.c
index 5ad6de738aee..2678cd3bed29 100644
--- a/fs/btrfs/block-rsv.c
+++ b/fs/btrfs/block-rsv.c
@@ -421,6 +421,9 @@ void btrfs_init_root_block_rsv(struct btrfs_root *roo=
t)
 	case BTRFS_TREE_LOG_OBJECTID:
 		root->block_rsv =3D &fs_info->treelog_rsv;
 		break;
+	case BTRFS_REMAP_TREE_OBJECTID:
+		root->block_rsv =3D &fs_info->remap_block_rsv;
+		break;
 	default:
 		root->block_rsv =3D NULL;
 		break;
@@ -434,6 +437,9 @@ void btrfs_init_global_block_rsv(struct btrfs_fs_info=
 *fs_info)
 	space_info =3D btrfs_find_space_info(fs_info, BTRFS_BLOCK_GROUP_SYSTEM)=
;
 	fs_info->chunk_block_rsv.space_info =3D space_info;
=20
+	space_info =3D btrfs_find_space_info(fs_info, BTRFS_BLOCK_GROUP_REMAP);
+	fs_info->remap_block_rsv.space_info =3D space_info;
+
 	space_info =3D btrfs_find_space_info(fs_info, BTRFS_BLOCK_GROUP_METADAT=
A);
 	fs_info->global_block_rsv.space_info =3D space_info;
 	fs_info->trans_block_rsv.space_info =3D space_info;
@@ -460,6 +466,8 @@ void btrfs_release_global_block_rsv(struct btrfs_fs_i=
nfo *fs_info)
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
index 1beb9458f622..95058c9aa31b 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -2831,6 +2831,7 @@ void btrfs_init_fs_info(struct btrfs_fs_info *fs_in=
fo)
 			     BTRFS_BLOCK_RSV_GLOBAL);
 	btrfs_init_block_rsv(&fs_info->trans_block_rsv, BTRFS_BLOCK_RSV_TRANS);
 	btrfs_init_block_rsv(&fs_info->chunk_block_rsv, BTRFS_BLOCK_RSV_CHUNK);
+	btrfs_init_block_rsv(&fs_info->remap_block_rsv, BTRFS_BLOCK_RSV_REMAP);
 	btrfs_init_block_rsv(&fs_info->treelog_rsv, BTRFS_BLOCK_RSV_TREELOG);
 	btrfs_init_block_rsv(&fs_info->empty_block_rsv, BTRFS_BLOCK_RSV_EMPTY);
 	btrfs_init_block_rsv(&fs_info->delayed_block_rsv,
diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
index 4394de12a767..2dfdbfda5901 100644
--- a/fs/btrfs/fs.h
+++ b/fs/btrfs/fs.h
@@ -468,6 +468,8 @@ struct btrfs_fs_info {
 	struct btrfs_block_rsv trans_block_rsv;
 	/* Block reservation for chunk tree */
 	struct btrfs_block_rsv chunk_block_rsv;
+	/* Block reservation for remap tree */
+	struct btrfs_block_rsv remap_block_rsv;
 	/* Block reservation for delayed operations */
 	struct btrfs_block_rsv delayed_block_rsv;
 	/* Block reservation for delayed refs */
diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index d9087aa81b21..3f927a514643 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -343,6 +343,8 @@ int btrfs_init_space_info(struct btrfs_fs_info *fs_in=
fo)
 	if (mixed) {
 		flags =3D BTRFS_BLOCK_GROUP_METADATA | BTRFS_BLOCK_GROUP_DATA;
 		ret =3D create_space_info(fs_info, flags);
+		if (ret)
+			goto out;
 	} else {
 		flags =3D BTRFS_BLOCK_GROUP_METADATA;
 		ret =3D create_space_info(fs_info, flags);
@@ -351,7 +353,15 @@ int btrfs_init_space_info(struct btrfs_fs_info *fs_i=
nfo)
=20
 		flags =3D BTRFS_BLOCK_GROUP_DATA;
 		ret =3D create_space_info(fs_info, flags);
+		if (ret)
+			goto out;
+	}
+
+	if (features & BTRFS_FEATURE_INCOMPAT_REMAP_TREE) {
+		flags =3D BTRFS_BLOCK_GROUP_REMAP;
+		ret =3D create_space_info(fs_info, flags);
 	}
+
 out:
 	return ret;
 }
@@ -590,6 +600,7 @@ static void dump_global_block_rsv(struct btrfs_fs_inf=
o *fs_info)
 	DUMP_BLOCK_RSV(fs_info, global_block_rsv);
 	DUMP_BLOCK_RSV(fs_info, trans_block_rsv);
 	DUMP_BLOCK_RSV(fs_info, chunk_block_rsv);
+	DUMP_BLOCK_RSV(fs_info, remap_block_rsv);
 	DUMP_BLOCK_RSV(fs_info, delayed_block_rsv);
 	DUMP_BLOCK_RSV(fs_info, delayed_refs_rsv);
 }
diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index 3165194f62ab..b8c2d9a5ebeb 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -1962,6 +1962,8 @@ static const char *alloc_name(struct btrfs_space_in=
fo *space_info)
 	case BTRFS_BLOCK_GROUP_SYSTEM:
 		ASSERT(space_info->subgroup_id =3D=3D BTRFS_SUB_GROUP_PRIMARY);
 		return "system";
+	case BTRFS_BLOCK_GROUP_REMAP:
+		return "remap";
 	default:
 		WARN_ON(1);
 		return "invalid-combination";
diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
index a83fb828723a..0505f8d76581 100644
--- a/fs/btrfs/tree-checker.c
+++ b/fs/btrfs/tree-checker.c
@@ -751,13 +751,14 @@ static int check_block_group_item(struct extent_buf=
fer *leaf,
 	if (unlikely(type !=3D BTRFS_BLOCK_GROUP_DATA &&
 		     type !=3D BTRFS_BLOCK_GROUP_METADATA &&
 		     type !=3D BTRFS_BLOCK_GROUP_SYSTEM &&
+		     type !=3D BTRFS_BLOCK_GROUP_REMAP &&
 		     type !=3D (BTRFS_BLOCK_GROUP_METADATA |
 			      BTRFS_BLOCK_GROUP_DATA))) {
 		block_group_err(leaf, slot,
-"invalid type, have 0x%llx (%lu bits set) expect either 0x%llx, 0x%llx, =
0x%llx or 0x%llx",
+"invalid type, have 0x%llx (%lu bits set) expect either 0x%llx, 0x%llx, =
0x%llx, 0x%llx or 0x%llx",
 			type, hweight64(type),
 			BTRFS_BLOCK_GROUP_DATA, BTRFS_BLOCK_GROUP_METADATA,
-			BTRFS_BLOCK_GROUP_SYSTEM,
+			BTRFS_BLOCK_GROUP_SYSTEM, BTRFS_BLOCK_GROUP_REMAP,
 			BTRFS_BLOCK_GROUP_METADATA | BTRFS_BLOCK_GROUP_DATA);
 		return -EUCLEAN;
 	}
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index e041964d03c8..0698613276d9 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -234,6 +234,7 @@ void btrfs_describe_block_groups(u64 bg_flags, char *=
buf, u32 size_buf)
 	DESCRIBE_FLAG(BTRFS_BLOCK_GROUP_DATA, "data");
 	DESCRIBE_FLAG(BTRFS_BLOCK_GROUP_SYSTEM, "system");
 	DESCRIBE_FLAG(BTRFS_BLOCK_GROUP_METADATA, "metadata");
+	DESCRIBE_FLAG(BTRFS_BLOCK_GROUP_REMAP, "remap");
 	DESCRIBE_FLAG(BTRFS_BLOCK_GROUP_REMAPPED, "remapped");
=20
 	DESCRIBE_FLAG(BTRFS_AVAIL_ALLOC_BIT_SINGLE, "single");
@@ -3974,6 +3975,12 @@ static bool should_balance_chunk(struct extent_buf=
fer *leaf, struct btrfs_chunk
 	struct btrfs_balance_args *bargs =3D NULL;
 	u64 chunk_type =3D btrfs_chunk_type(leaf, chunk);
=20
+	/* treat REMAP chunks as METADATA */
+	if (chunk_type & BTRFS_BLOCK_GROUP_REMAP) {
+		chunk_type &=3D ~BTRFS_BLOCK_GROUP_REMAP;
+		chunk_type |=3D BTRFS_BLOCK_GROUP_METADATA;
+	}
+
 	/* type filter */
 	if (!((chunk_type & BTRFS_BLOCK_GROUP_TYPE_MASK) &
 	      (bctl->flags & BTRFS_BALANCE_TYPE_MASK))) {
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index 137cc232f58e..670d7bf18c40 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -59,8 +59,6 @@ static_assert(const_ilog2(BTRFS_STRIPE_LEN) =3D=3D BTRF=
S_STRIPE_LEN_SHIFT);
  */
 static_assert(const_ffs(BTRFS_BLOCK_GROUP_RAID0) <
 	      const_ffs(BTRFS_BLOCK_GROUP_PROFILE_MASK & ~BTRFS_BLOCK_GROUP_RAI=
D0));
-static_assert(const_ilog2(BTRFS_BLOCK_GROUP_RAID0) >
-	      ilog2(BTRFS_BLOCK_GROUP_TYPE_MASK));
=20
 /* ilog2() can handle both constants and variables */
 #define BTRFS_BG_FLAG_TO_INDEX(profile)					\
@@ -82,6 +80,15 @@ enum btrfs_raid_types {
 	BTRFS_NR_RAID_TYPES
 };
=20
+static_assert(BTRFS_RAID_RAID0 =3D=3D 1);
+static_assert(BTRFS_RAID_RAID1 =3D=3D 2);
+static_assert(BTRFS_RAID_DUP =3D=3D 3);
+static_assert(BTRFS_RAID_RAID10 =3D=3D 4);
+static_assert(BTRFS_RAID_RAID5 =3D=3D 5);
+static_assert(BTRFS_RAID_RAID6 =3D=3D 6);
+static_assert(BTRFS_RAID_RAID1C3 =3D=3D 7);
+static_assert(BTRFS_RAID_RAID1C4 =3D=3D 8);
+
 /*
  * Use sequence counter to get consistent device stat data on
  * 32-bit processors.
diff --git a/include/uapi/linux/btrfs_tree.h b/include/uapi/linux/btrfs_t=
ree.h
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
=20
 #define BTRFS_BLOCK_GROUP_TYPE_MASK	(BTRFS_BLOCK_GROUP_DATA |    \
 					 BTRFS_BLOCK_GROUP_SYSTEM |  \
-					 BTRFS_BLOCK_GROUP_METADATA)
+					 BTRFS_BLOCK_GROUP_METADATA | \
+					 BTRFS_BLOCK_GROUP_REMAP)
=20
 #define BTRFS_BLOCK_GROUP_PROFILE_MASK	(BTRFS_BLOCK_GROUP_RAID0 |   \
 					 BTRFS_BLOCK_GROUP_RAID1 |   \
--=20
2.49.0


