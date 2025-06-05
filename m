Return-Path: <linux-btrfs+bounces-14494-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BCCCACF431
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Jun 2025 18:25:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF98A188ACD7
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Jun 2025 16:25:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C754423F299;
	Thu,  5 Jun 2025 16:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="WXwwuBTa"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78B1F1F2BAB
	for <linux-btrfs@vger.kernel.org>; Thu,  5 Jun 2025 16:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749140664; cv=none; b=i0fXSfL8EtcngNLodrvP744V7obTqYFrFL4cXEF2iYEfgGD7H4i5TNVNOSSA/+Yr/GP56w50hn1N+c3RYHIRjEezyZUEhq6I5on0PNHszymD72lW5Hxz1WhOr+oDDQa6kCs3Ix+2dLfWLLPzCBZAOESxHy2Plr6ajMJoSKIL5r0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749140664; c=relaxed/simple;
	bh=P0asvX+LrwpUPfg8zfuzrz7exVzKtoGLeC3V+xdGBH8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Eo/pKzlc8gWZwPqZyNzg95MKqyWIw093OkPoaeWiuYGxFkhT3xO+BeigyBcWl2eIDLiDAY2W4VgvHPESPPE3/1CPsN9H0aCpSLiBKDb9rqJO08zg/fXX8mODhH0U/jmRzUMBN65ICJrzA4ueIFfYv74bBpVDqHZNe2vWhJecvLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b=WXwwuBTa; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 555Dw78q018125
	for <linux-btrfs@vger.kernel.org>; Thu, 5 Jun 2025 09:24:20 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=facebook; bh=y
	uEfC+bF4G4xtcnMPBaDiy2d7mCOMeQQH20qolfRSdg=; b=WXwwuBTa0HOI3yZz1
	rpjmtvje/zjHhgBupGtFHeDOPuQKTZaYqUJgzsj6JIhFpgAQM3FDgumjG7ZLRrPi
	u29aAAJbaZNjq8IcbiQ6zVBluaZ529A88jd0LzNILXMEZNMX1oCobfRgKosu7AC4
	DU6uqHOG7d8j4GZfpPOtH45/YE=
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4739svabq7-9
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-btrfs@vger.kernel.org>; Thu, 05 Jun 2025 09:24:20 -0700 (PDT)
Received: from twshared29376.33.frc3.facebook.com (2620:10d:c085:108::150d) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1748.24; Thu, 5 Jun 2025 16:24:01 +0000
Received: by devbig276.nha1.facebook.com (Postfix, from userid 660015)
	id 36E2AFEC2E60; Thu,  5 Jun 2025 17:23:48 +0100 (BST)
From: Mark Harmstone <maharmstone@fb.com>
To: <linux-btrfs@vger.kernel.org>
CC: Mark Harmstone <maharmstone@fb.com>
Subject: [PATCH 01/12] btrfs: add definitions and constants for remap-tree
Date: Thu, 5 Jun 2025 17:23:31 +0100
Message-ID: <20250605162345.2561026-2-maharmstone@fb.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA1MDE0NCBTYWx0ZWRfX0bubSSgYAYMP X3gdAOWdnMSDiDa0J8C2HbVEQN/GHez5MeX75R3WegwvAc6ALUfKwABC49Y149rNkil8L48nzcm /40+eS/fnf6nGe7HbRLfJZoepcdDClzuabHO3iLmxr07C0DNqv0QYtXkYs6jZoI6OFeDl1XR+c6
 uHjTehFEVtoMLAS4YR1Y2ZA2nDIsBGXsY3knD8AWd1teXts3qlyAgOAJdQfdczZG3aPRcdl2FZX 7+c6JXXQrjENhvY/6LstmVUfw/KJ1TRlCia1p5bpdumy65PqdhNpnfTLE5zg74ArMcPNUsF8EJY 97T4TmnX+Bc2s7BmDdbd93B13eQjDKcEWlN7CyIlitr+fWH+2lI0s35LgBG3/dpdM5bZS/9L8b0
 lx0zMnGVzPKoTFrz1Ds/qtlyMBv3qdbpeK899oH03yTiZON+JIbsUeBqvs9Ing0wCL0vzOjq
X-Proofpoint-ORIG-GUID: IzOLyUUE6Ti1t-mX9pT4VsMmV72T3AP9
X-Authority-Analysis: v=2.4 cv=EIwG00ZC c=1 sm=1 tr=0 ts=6841c4b4 cx=c_pps a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17 a=6IFa9wvqVegA:10 a=FOH2dFAWAAAA:8 a=KFvQRHhEJ8czjn08fOUA:9
X-Proofpoint-GUID: IzOLyUUE6Ti1t-mX9pT4VsMmV72T3AP9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-05_04,2025-06-05_01,2025-03-28_01

Add an incompat flag for the new remap-tree feature, and the constants
and definitions needed to support it.

Signed-off-by: Mark Harmstone <maharmstone@fb.com>
---
 fs/btrfs/accessors.h            |  3 +++
 fs/btrfs/sysfs.c                |  2 ++
 fs/btrfs/tree-checker.c         |  6 ++++--
 fs/btrfs/volumes.c              |  1 +
 include/uapi/linux/btrfs.h      |  1 +
 include/uapi/linux/btrfs_tree.h | 12 ++++++++++++
 6 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/accessors.h b/fs/btrfs/accessors.h
index 15ea6348800b..5f5eda8d6f9e 100644
--- a/fs/btrfs/accessors.h
+++ b/fs/btrfs/accessors.h
@@ -1046,6 +1046,9 @@ BTRFS_SETGET_STACK_FUNCS(stack_verity_descriptor_en=
cryption,
 BTRFS_SETGET_STACK_FUNCS(stack_verity_descriptor_size,
 			 struct btrfs_verity_descriptor_item, size, 64);
=20
+BTRFS_SETGET_FUNCS(remap_address, struct btrfs_remap, address, 64);
+BTRFS_SETGET_STACK_FUNCS(stack_remap_address, struct btrfs_remap, addres=
s, 64);
+
 /* Cast into the data area of the leaf. */
 #define btrfs_item_ptr(leaf, slot, type)				\
 	((type *)(btrfs_item_nr_offset(leaf, 0) + btrfs_item_offset(leaf, slot)=
))
diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index f186c8082eff..831c25c2fb25 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -292,6 +292,7 @@ BTRFS_FEAT_ATTR_COMPAT_RO(free_space_tree, FREE_SPACE=
_TREE);
 BTRFS_FEAT_ATTR_COMPAT_RO(block_group_tree, BLOCK_GROUP_TREE);
 BTRFS_FEAT_ATTR_INCOMPAT(raid1c34, RAID1C34);
 BTRFS_FEAT_ATTR_INCOMPAT(simple_quota, SIMPLE_QUOTA);
+BTRFS_FEAT_ATTR_INCOMPAT(remap_tree, REMAP_TREE);
 #ifdef CONFIG_BLK_DEV_ZONED
 BTRFS_FEAT_ATTR_INCOMPAT(zoned, ZONED);
 #endif
@@ -326,6 +327,7 @@ static struct attribute *btrfs_supported_feature_attr=
s[] =3D {
 	BTRFS_FEAT_ATTR_PTR(raid1c34),
 	BTRFS_FEAT_ATTR_PTR(block_group_tree),
 	BTRFS_FEAT_ATTR_PTR(simple_quota),
+	BTRFS_FEAT_ATTR_PTR(remap_tree),
 #ifdef CONFIG_BLK_DEV_ZONED
 	BTRFS_FEAT_ATTR_PTR(zoned),
 #endif
diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
index 8f4703b488b7..a83fb828723a 100644
--- a/fs/btrfs/tree-checker.c
+++ b/fs/btrfs/tree-checker.c
@@ -913,11 +913,13 @@ int btrfs_check_chunk_valid(const struct btrfs_fs_i=
nfo *fs_info,
 		return -EUCLEAN;
 	}
 	if (unlikely(type & ~(BTRFS_BLOCK_GROUP_TYPE_MASK |
-			      BTRFS_BLOCK_GROUP_PROFILE_MASK))) {
+			      BTRFS_BLOCK_GROUP_PROFILE_MASK |
+			      BTRFS_BLOCK_GROUP_REMAPPED))) {
 		chunk_err(fs_info, leaf, chunk, logical,
 			  "unrecognized chunk type: 0x%llx",
 			  ~(BTRFS_BLOCK_GROUP_TYPE_MASK |
-			    BTRFS_BLOCK_GROUP_PROFILE_MASK) & type);
+			    BTRFS_BLOCK_GROUP_PROFILE_MASK |
+			    BTRFS_BLOCK_GROUP_REMAPPED) & type);
 		return -EUCLEAN;
 	}
=20
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 1535a425e8f9..3e53bde0e605 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -234,6 +234,7 @@ void btrfs_describe_block_groups(u64 bg_flags, char *=
buf, u32 size_buf)
 	DESCRIBE_FLAG(BTRFS_BLOCK_GROUP_DATA, "data");
 	DESCRIBE_FLAG(BTRFS_BLOCK_GROUP_SYSTEM, "system");
 	DESCRIBE_FLAG(BTRFS_BLOCK_GROUP_METADATA, "metadata");
+	DESCRIBE_FLAG(BTRFS_BLOCK_GROUP_REMAPPED, "remapped");
=20
 	DESCRIBE_FLAG(BTRFS_AVAIL_ALLOC_BIT_SINGLE, "single");
 	for (i =3D 0; i < BTRFS_NR_RAID_TYPES; i++)
diff --git a/include/uapi/linux/btrfs.h b/include/uapi/linux/btrfs.h
index dd02160015b2..d857cdc7694a 100644
--- a/include/uapi/linux/btrfs.h
+++ b/include/uapi/linux/btrfs.h
@@ -336,6 +336,7 @@ struct btrfs_ioctl_fs_info_args {
 #define BTRFS_FEATURE_INCOMPAT_EXTENT_TREE_V2	(1ULL << 13)
 #define BTRFS_FEATURE_INCOMPAT_RAID_STRIPE_TREE	(1ULL << 14)
 #define BTRFS_FEATURE_INCOMPAT_SIMPLE_QUOTA	(1ULL << 16)
+#define BTRFS_FEATURE_INCOMPAT_REMAP_TREE	(1ULL << 17)
=20
 struct btrfs_ioctl_feature_flags {
 	__u64 compat_flags;
diff --git a/include/uapi/linux/btrfs_tree.h b/include/uapi/linux/btrfs_t=
ree.h
index fc29d273845d..4439d77a7252 100644
--- a/include/uapi/linux/btrfs_tree.h
+++ b/include/uapi/linux/btrfs_tree.h
@@ -76,6 +76,9 @@
 /* Tracks RAID stripes in block groups. */
 #define BTRFS_RAID_STRIPE_TREE_OBJECTID 12ULL
=20
+/* Holds details of remapped addresses after relocation. */
+#define BTRFS_REMAP_TREE_OBJECTID 13ULL
+
 /* device stats in the device tree */
 #define BTRFS_DEV_STATS_OBJECTID 0ULL
=20
@@ -282,6 +285,10 @@
=20
 #define BTRFS_RAID_STRIPE_KEY	230
=20
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
=20
@@ -1323,4 +1331,8 @@ struct btrfs_verity_descriptor_item {
 	__u8 encryption;
 } __attribute__ ((__packed__));
=20
+struct btrfs_remap {
+	__le64 address;
+} __attribute__ ((__packed__));
+
 #endif /* _BTRFS_CTREE_H_ */
--=20
2.49.0


