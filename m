Return-Path: <linux-btrfs+bounces-14482-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B59F0ACF42A
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Jun 2025 18:24:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16F131886597
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Jun 2025 16:24:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A028921ABA4;
	Thu,  5 Jun 2025 16:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="Sd/gwX/0"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31CC727467A
	for <linux-btrfs@vger.kernel.org>; Thu,  5 Jun 2025 16:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749140635; cv=none; b=GClD2LYoNSue8GN4o1R1DgjL02HWWoxgkFBz0TB+hQIG7MVjA462h33SeFUdBCPHe9z9jJ48eepGXC38Nme+0pLY70vex4zNfvGxPEXkCWB0jzr87ihjZxALH7g8aootuYO9q+/L6lPv6MxRiyVwYjI+Y7wiSUrr96pYpcWP2Zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749140635; c=relaxed/simple;
	bh=t6G1/8PAw2iqE09WsgLV2p7FHErxy+GdSJ/UlnmfkpU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kQE8qOMxxx8V+SyIUAW0FDOOH9OswaalzKYNgqZ26Nzmubeju4MA8L0BLQg0cTsHDnLdTfXOSOH24Hcx3jcQSvFjemx/Dc9T+XRm0kyJAmVsjwi+vG9G6Fo+uJvqzRsJ6DZLhjI3L4hYpJhoBpUfVwV0UftHfWN1b+HkHT0gyaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b=Sd/gwX/0; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 555Dw0bP027778
	for <linux-btrfs@vger.kernel.org>; Thu, 5 Jun 2025 09:23:53 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=facebook; bh=x
	pAXVZfxBVfMVWjc01VXpLGCAfeNLuiCcXJsSf0neUw=; b=Sd/gwX/0jl65DmXP9
	avt0CKK28V/LkEhWoJ6RiY86PHqX9NgOEB2Ake3jEGJtnjr3tX0gVmkYmVGcaKjO
	rEjq/3xvUrjVz9pmBDvs+6ryQRHUFFJMx+ydrGDhUPlsZqGsV3MPPVYgy1u7RArx
	oaVsawFJ127o7wY+FNs0ZZh9sM=
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4739tktdmr-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-btrfs@vger.kernel.org>; Thu, 05 Jun 2025 09:23:53 -0700 (PDT)
Received: from twshared35278.32.frc3.facebook.com (2620:10d:c0a8:1b::30) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1748.24; Thu, 5 Jun 2025 16:23:50 +0000
Received: by devbig276.nha1.facebook.com (Postfix, from userid 660015)
	id 4534CFEC2E64; Thu,  5 Jun 2025 17:23:48 +0100 (BST)
From: Mark Harmstone <maharmstone@fb.com>
To: <linux-btrfs@vger.kernel.org>
CC: Mark Harmstone <maharmstone@fb.com>
Subject: [PATCH 03/12] btrfs: allow remapped chunks to have zero stripes
Date: Thu, 5 Jun 2025 17:23:33 +0100
Message-ID: <20250605162345.2561026-4-maharmstone@fb.com>
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
X-Authority-Analysis: v=2.4 cv=ZbEdNtVA c=1 sm=1 tr=0 ts=6841c499 cx=c_pps a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17 a=6IFa9wvqVegA:10 a=FOH2dFAWAAAA:8 a=SO1JP5Dnl31tz9C7ukcA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA1MDE0NCBTYWx0ZWRfXyPXtCGWbiNim wMXNwbqsQj74Ke8oTrkDu2eJGSAMjr87MkN283sA0SVpPB3WCG10N0jUeW/7mKVqDYttcRAxb7a QVdgQivysUQSwpSJEe7k+eSp++kmk3+IMr0dVz9melHywwmmbSB7M2SIit143a9jMWNyn1Rs/mR
 Mp9mApfiIs1k/+9U57GdOm/fVfdKotyHTVeC+oLRNa8AK9SYQlV+vgN2vltFdLCxNjvuQXlfLem JBTMCaoHNnFgMoWAXeeQidpBgodAsTU5cN9VRB+GLfSJ2U8sur1J/hK/13b+piak60ryFGxNdxO BFBmyz4LT6CvlL8XxXKvvw5kWADlme/7NbSWA2YNsKp6GZWpXLcTBuFTJIHjT4kqB4YmbSnRmBM
 tepN5250OzuGCDRiDp6F0Y5OJf//L+qftHlcZU5Z5oU6f82H34Av9ePrmPe0mdtM35GoGfa0
X-Proofpoint-GUID: Atu1KaLAiWQCy3NjboxTMcL0n9gD5QLP
X-Proofpoint-ORIG-GUID: Atu1KaLAiWQCy3NjboxTMcL0n9gD5QLP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-05_04,2025-06-05_01,2025-03-28_01

When a chunk has been fully remapped, we are going to set its
num_stripes to 0, as it will no longer represent a physical location on
disk.

Change tree-checker to allow for this, and fix a couple of
divide-by-zeroes seen elsewhere.

Signed-off-by: Mark Harmstone <maharmstone@fb.com>
---
 fs/btrfs/tree-checker.c | 16 +++++++++-------
 fs/btrfs/volumes.c      |  8 +++++++-
 2 files changed, 16 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
index 0505f8d76581..fd83df06e3fb 100644
--- a/fs/btrfs/tree-checker.c
+++ b/fs/btrfs/tree-checker.c
@@ -829,7 +829,7 @@ int btrfs_check_chunk_valid(const struct btrfs_fs_inf=
o *fs_info,
 	u64 type;
 	u64 features;
 	u32 chunk_sector_size;
-	bool mixed =3D false;
+	bool mixed =3D false, remapped;
 	int raid_index;
 	int nparity;
 	int ncopies;
@@ -853,12 +853,14 @@ int btrfs_check_chunk_valid(const struct btrfs_fs_i=
nfo *fs_info,
 	ncopies =3D btrfs_raid_array[raid_index].ncopies;
 	nparity =3D btrfs_raid_array[raid_index].nparity;
=20
-	if (unlikely(!num_stripes)) {
+	remapped =3D type & BTRFS_BLOCK_GROUP_REMAPPED;
+
+	if (unlikely(!remapped && !num_stripes)) {
 		chunk_err(fs_info, leaf, chunk, logical,
 			  "invalid chunk num_stripes, have %u", num_stripes);
 		return -EUCLEAN;
 	}
-	if (unlikely(num_stripes < ncopies)) {
+	if (unlikely(!remapped && num_stripes < ncopies)) {
 		chunk_err(fs_info, leaf, chunk, logical,
 			  "invalid chunk num_stripes < ncopies, have %u < %d",
 			  num_stripes, ncopies);
@@ -960,7 +962,7 @@ int btrfs_check_chunk_valid(const struct btrfs_fs_inf=
o *fs_info,
 		}
 	}
=20
-	if (unlikely((type & BTRFS_BLOCK_GROUP_RAID10 &&
+	if (unlikely(!remapped && ((type & BTRFS_BLOCK_GROUP_RAID10 &&
 		      sub_stripes !=3D btrfs_raid_array[BTRFS_RAID_RAID10].sub_stripes=
) ||
 		     (type & BTRFS_BLOCK_GROUP_RAID1 &&
 		      num_stripes !=3D btrfs_raid_array[BTRFS_RAID_RAID1].devs_min) ||
@@ -975,7 +977,7 @@ int btrfs_check_chunk_valid(const struct btrfs_fs_inf=
o *fs_info,
 		     (type & BTRFS_BLOCK_GROUP_DUP &&
 		      num_stripes !=3D btrfs_raid_array[BTRFS_RAID_DUP].dev_stripes) |=
|
 		     ((type & BTRFS_BLOCK_GROUP_PROFILE_MASK) =3D=3D 0 &&
-		      num_stripes !=3D btrfs_raid_array[BTRFS_RAID_SINGLE].dev_stripes=
))) {
+		      num_stripes !=3D btrfs_raid_array[BTRFS_RAID_SINGLE].dev_stripes=
)))) {
 		chunk_err(fs_info, leaf, chunk, logical,
 			"invalid num_stripes:sub_stripes %u:%u for profile %llu",
 			num_stripes, sub_stripes,
@@ -999,11 +1001,11 @@ static int check_leaf_chunk_item(struct extent_buf=
fer *leaf,
 	struct btrfs_fs_info *fs_info =3D leaf->fs_info;
 	int num_stripes;
=20
-	if (unlikely(btrfs_item_size(leaf, slot) < sizeof(struct btrfs_chunk)))=
 {
+	if (unlikely(btrfs_item_size(leaf, slot) < offsetof(struct btrfs_chunk,=
 stripe))) {
 		chunk_err(fs_info, leaf, chunk, key->offset,
 			"invalid chunk item size: have %u expect [%zu, %u)",
 			btrfs_item_size(leaf, slot),
-			sizeof(struct btrfs_chunk),
+			offsetof(struct btrfs_chunk, stripe),
 			BTRFS_LEAF_DATA_SIZE(fs_info));
 		return -EUCLEAN;
 	}
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index e7c467b6af46..9159d11cb143 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -6133,6 +6133,12 @@ struct btrfs_discard_stripe *btrfs_map_discard(str=
uct btrfs_fs_info *fs_info,
 		goto out_free_map;
 	}
=20
+	/* avoid divide by zero on fully-remapped chunks */
+	if (map->num_stripes =3D=3D 0) {
+		ret =3D -EOPNOTSUPP;
+		goto out_free_map;
+	}
+
 	offset =3D logical - map->start;
 	length =3D min_t(u64, map->start + map->chunk_len - logical, length);
 	*length_ret =3D length;
@@ -6953,7 +6959,7 @@ u64 btrfs_calc_stripe_length(const struct btrfs_chu=
nk_map *map)
 {
 	const int data_stripes =3D calc_data_stripes(map->type, map->num_stripe=
s);
=20
-	return div_u64(map->chunk_len, data_stripes);
+	return data_stripes ? div_u64(map->chunk_len, data_stripes) : 0;
 }
=20
 #if BITS_PER_LONG =3D=3D 32
--=20
2.49.0


