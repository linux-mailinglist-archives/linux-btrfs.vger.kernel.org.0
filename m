Return-Path: <linux-btrfs+bounces-14492-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24584ACF43C
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Jun 2025 18:26:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D2E077AAC3C
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Jun 2025 16:23:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95048274FF4;
	Thu,  5 Jun 2025 16:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="EQ2vOxkk"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21E33225A34
	for <linux-btrfs@vger.kernel.org>; Thu,  5 Jun 2025 16:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749140646; cv=none; b=lE/muC+8Pl9VnA7AhtGs2imUuRH4+gWPuufDH2I5/AZUlSHmJBZp4wAF/yT/mZ+Y0/KD2xSEZmVyYpBC8eNg9TWXfT1amTFTAEHgam9ETXEw52P5asODQhGI7wlz0tQu5tHi8Wo/Af9ZcZ9oNyA2ouu5NeKsZt0Do4qOB9zNi1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749140646; c=relaxed/simple;
	bh=YXt6VxCWRio+6Bk0wvORbtOCle6f/6gSFhOxezRzJuA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SAK6CMEVixsx/DX4+wj0o7dvUD++p/Gb8tGu+eWOSZMBJoV57FFjLhc5Xtq0ray0lubjMtEzol7VcqeJ7YkmU3ns8T4m91Ai6hkthMt8no2+q/0IRu3SShv0ilZB29ij9HDAb9cNuOgxNrwXufdK/pofMhoOaOuJ0rHzrbWMkWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b=EQ2vOxkk; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 555DwI93006437
	for <linux-btrfs@vger.kernel.org>; Thu, 5 Jun 2025 09:24:03 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=facebook; bh=R
	xu3GaIznF8g9KDY/1ny0RHdyu+yWn8ywGvT48/DU4k=; b=EQ2vOxkkgm0xxkcu0
	ZUuH+dmIdILDp2Szn8kq1oalwtEiTEDXJfsAiMtl+SWEEslcn4qQUGFUZccZA8Qa
	DXwUZNdzpFqK76YOqbc9byAtaNWA9bDaBC9yViVe2jrQhUfLr2sGKTAh149ZdEs3
	d5PgLWplojS4LgFVHKScY7Ciec=
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4739uca8x8-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-btrfs@vger.kernel.org>; Thu, 05 Jun 2025 09:24:03 -0700 (PDT)
Received: from twshared9216.15.frc2.facebook.com (2620:10d:c0a8:1b::8e35) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1748.24; Thu, 5 Jun 2025 16:24:00 +0000
Received: by devbig276.nha1.facebook.com (Postfix, from userid 660015)
	id 3A8EFFEC2E62; Thu,  5 Jun 2025 17:23:48 +0100 (BST)
From: Mark Harmstone <maharmstone@fb.com>
To: <linux-btrfs@vger.kernel.org>
CC: Mark Harmstone <maharmstone@fb.com>
Subject: [PATCH 02/12] btrfs: add REMAP chunk type
Date: Thu, 5 Jun 2025 17:23:32 +0100
Message-ID: <20250605162345.2561026-3-maharmstone@fb.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250605162345.2561026-1-maharmstone@fb.com>
References: <20250605162345.2561026-1-maharmstone@fb.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: XiHWJbrgkkfkuwlRpIkIES83U5VkuhvZ
X-Proofpoint-ORIG-GUID: XiHWJbrgkkfkuwlRpIkIES83U5VkuhvZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA1MDE0NCBTYWx0ZWRfX27MKVw3soMhj 3pIH1G0LxPcqEju30ZcejSy518wK4EPZxbOK8WG6JkKzOB46iTOqw2QLHQwMTCrbrP8TKVHgHJ0 VCmPTzlEwREwjlxtJVhEKth+HmCiz48M6S/IkH3o8ry+0h/wSIUYmaeZAo62ScyHxVcANoTOrxR
 YB2evGt7V0ORrpr3CGn77En0OSkK/o6gy4HhH7VvupiY0DFWwITP2ayKO4FvEzQXbURC93AFCHS m0rZ9RQFBfX7jqWCfcZzKOfR89glwh53wI7KgVeUk6an+/03d+PSgy/D/MdMH6MOi87dF06Iu4a 4VqtcBX98OUsVyHswB7jtPyR6TWOS9pszk5tWUmIsIyd0Q7Bc4MYdiw5QZu5bfehwZzwMRDy7rn
 SzyotqgiEM96xIln0rEmWRnrP0Qg9hRLdS8JYEt2ntNWx9z9GJfmXpnJfvuhcCprgQr/NAX2
X-Authority-Analysis: v=2.4 cv=MNhgmNZl c=1 sm=1 tr=0 ts=6841c4a3 cx=c_pps a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17 a=6IFa9wvqVegA:10 a=FOH2dFAWAAAA:8 a=H134O3fF1iUYwrnXQt4A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-05_04,2025-06-05_01,2025-03-28_01

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
 fs/btrfs/space-info.c           | 13 ++++++++++++-
 fs/btrfs/sysfs.c                |  2 ++
 fs/btrfs/tree-checker.c         |  5 +++--
 fs/btrfs/volumes.c              |  1 +
 fs/btrfs/volumes.h              | 11 +++++++++--
 include/uapi/linux/btrfs_tree.h |  4 +++-
 10 files changed, 42 insertions(+), 6 deletions(-)

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
index 5a565bf96bf8..60cce96a9ec4 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -2830,6 +2830,7 @@ void btrfs_init_fs_info(struct btrfs_fs_info *fs_in=
fo)
 			     BTRFS_BLOCK_RSV_GLOBAL);
 	btrfs_init_block_rsv(&fs_info->trans_block_rsv, BTRFS_BLOCK_RSV_TRANS);
 	btrfs_init_block_rsv(&fs_info->chunk_block_rsv, BTRFS_BLOCK_RSV_CHUNK);
+	btrfs_init_block_rsv(&fs_info->remap_block_rsv, BTRFS_BLOCK_RSV_REMAP);
 	btrfs_init_block_rsv(&fs_info->treelog_rsv, BTRFS_BLOCK_RSV_TREELOG);
 	btrfs_init_block_rsv(&fs_info->empty_block_rsv, BTRFS_BLOCK_RSV_EMPTY);
 	btrfs_init_block_rsv(&fs_info->delayed_block_rsv,
diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
index 5e48ed252fd0..07ac1a96477a 100644
--- a/fs/btrfs/fs.h
+++ b/fs/btrfs/fs.h
@@ -476,6 +476,8 @@ struct btrfs_fs_info {
 	struct btrfs_block_rsv trans_block_rsv;
 	/* Block reservation for chunk tree */
 	struct btrfs_block_rsv chunk_block_rsv;
+	/* Block reservation for remap tree */
+	struct btrfs_block_rsv remap_block_rsv;
 	/* Block reservation for delayed operations */
 	struct btrfs_block_rsv delayed_block_rsv;
 	/* Block reservation for delayed refs */
diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 517916004f21..6471861c4b25 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -215,7 +215,7 @@ static u64 calc_chunk_size(const struct btrfs_fs_info=
 *fs_info, u64 flags)
=20
 	if (flags & BTRFS_BLOCK_GROUP_DATA)
 		return BTRFS_MAX_DATA_CHUNK_SIZE;
-	else if (flags & BTRFS_BLOCK_GROUP_SYSTEM)
+	else if (flags & (BTRFS_BLOCK_GROUP_SYSTEM | BTRFS_BLOCK_GROUP_REMAP))
 		return SZ_32M;
=20
 	/* Handle BTRFS_BLOCK_GROUP_METADATA */
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
index 831c25c2fb25..aa98d99833fd 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -1985,6 +1985,8 @@ static const char *alloc_name(struct btrfs_space_in=
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
index 3e53bde0e605..e7c467b6af46 100644
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
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index 6d8b1f38e3ee..9fb8fe4312a5 100644
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


