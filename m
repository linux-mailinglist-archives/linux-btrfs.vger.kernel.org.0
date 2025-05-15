Return-Path: <linux-btrfs+bounces-14048-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5042EAB8C9A
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 May 2025 18:37:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 837DEA01484
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 May 2025 16:36:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71A25223DCA;
	Thu, 15 May 2025 16:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="SGsW5fy0"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF03C7262B
	for <linux-btrfs@vger.kernel.org>; Thu, 15 May 2025 16:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747327022; cv=none; b=Hvcd6ieQmWy5LPdA4mji9FZwg1H8bh4tkQjmRcVYYXaSXzL+n+Emipp0vkAPUV0bRFyfrXNgZSjsgrDiemjRftnXZ39Pc9p25z/pwo1pmKGC8MD6q5wkrUJJMP17wT3AXwhmH8Kfms+Xcr4qbNHNP0em3b1wb96nU2K14cSy+Qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747327022; c=relaxed/simple;
	bh=PMJdfbVFDpr9uFZzDRy84TGlgRuBiyvZCEZinyAWPjk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A88WRu5lxms2f87sM/ef2+3Q7lOZbsREWZFKsAas1x+Dwbm2tDfFcn7oQ1Bi8MqlTLCGhoArttCSTElf1q5igCpQCYLDFqLHkJ97MdogFAlG2n09UHuwWhfitUsJXoI5NpibV3vksSGvuZycd7T90ZosYd6xT+URBbLZS8wKJ0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b=SGsW5fy0; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.18.1.2/8.18.1.2) with ESMTP id 54FFiLt1032296
	for <linux-btrfs@vger.kernel.org>; Thu, 15 May 2025 09:36:59 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=facebook; bh=H
	w9zqXffNIt3EueSneKVO3R8pWjF76jLz36dgm5WajU=; b=SGsW5fy0wss9ij7eY
	WS+5HK9lluXUpmUfj4Y3xcS/ynn13ImuL1ZTh7DLs9aecIRhZeQw5T207EYaQuIo
	XBNFYs6TowxM+MJRYRPRKP+Ef9DzsWVtq5Rk8/nVVBhgATHfPok9u5Gf3cTUypt+
	CAplB48ccy3V10/BavTQpdRPfY=
Received: from mail.thefacebook.com ([163.114.134.16])
	by m0001303.ppops.net (PPS) with ESMTPS id 46mmw2mu9x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-btrfs@vger.kernel.org>; Thu, 15 May 2025 09:36:58 -0700 (PDT)
Received: from twshared11082.06.ash8.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1748.10; Thu, 15 May 2025 16:36:57 +0000
Received: by devbig276.nha1.facebook.com (Postfix, from userid 660015)
	id 02DDDF3BE10A; Thu, 15 May 2025 17:36:47 +0100 (BST)
From: Mark Harmstone <maharmstone@fb.com>
To: <linux-btrfs@vger.kernel.org>
CC: Mark Harmstone <maharmstone@fb.com>
Subject: [RFC PATCH 03/10] btrfs: allow remapped chunks to have zero stripes
Date: Thu, 15 May 2025 17:36:31 +0100
Message-ID: <20250515163641.3449017-4-maharmstone@fb.com>
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
X-Proofpoint-GUID: JlU5oz-buK1_nd3B5Ah8E7SV3EILiYjK
X-Proofpoint-ORIG-GUID: JlU5oz-buK1_nd3B5Ah8E7SV3EILiYjK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE1MDE2NCBTYWx0ZWRfXxEgdfEDWO9ml 6ZwyTnyYl7VaAWSsT+6GEhmxVhK+kIhjQQhBC+G2Ezzn4yjDC2LxRx2l332/Tod8oFoXmwtKIw/ ywvX5O+gDOYgVg/m4dzWLEB0vbeb5Debi9PSt4kMBZ/a5hRh2b7ezw7JO18oQ6YsXLtXWYn5P24
 GbpTJWAmw5L0aCKiRAP5jxRU4BuLOkUUwjrTXmm0QLd5wMzGDshWWtP7M0e4yZoYhKuxkDu4KrK nHKDkHEg5LGBBE/JZLCVc0qRG934a8041BDSmsNOjILC6fe09Kt2d8m+aU8DTjxedzrJIXZNoSl CWBLopzLzaGyNigdEx8JAj1MGcleJoezeKyemRQ3AhZAcJwzTnb0gSGD4bAd5+Ws2jB4Q7sG+P2
 +yPDp3pZF3FkaX/rgIntgA/olvpH5kDGxHUu7udOsX01xu7Su1DRuH/uQKReVER8Im6sKVl7
X-Authority-Analysis: v=2.4 cv=DtZW+H/+ c=1 sm=1 tr=0 ts=6826182a cx=c_pps a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17 a=dt9VzEwgFbYA:10 a=FOH2dFAWAAAA:8 a=SO1JP5Dnl31tz9C7ukcA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-15_07,2025-05-15_01,2025-03-28_01

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
index 0698613276d9..77194bb46b40 100644
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


