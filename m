Return-Path: <linux-btrfs+bounces-14049-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F363AB8C9D
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 May 2025 18:37:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BAA50A016CA
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 May 2025 16:37:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DD4E223DE9;
	Thu, 15 May 2025 16:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="fsMVk2TS"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3039522330F
	for <linux-btrfs@vger.kernel.org>; Thu, 15 May 2025 16:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747327023; cv=none; b=NlU5WVJviW7icZM4owa+EARUeGJ5h8kMSD5seCun3v3eCwSCzF94BnjQzCE/ThjSMoDoOCwQ4nho3EzTSPe6hSuY0S8UarjIWT7P6ifUYB2h2Db+cSQXG5RIB5ESynhw6m/GBEOpAKdxQ4EbFF45+PFOApzjAxDiJ73ak/5FYZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747327023; c=relaxed/simple;
	bh=zMjV6yXZurSzG4+zBOlRgDOVYTiflAghESpyrUjulyU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ibm5iJ/BHS+IJgmYg2Ckt0WnvJyi0L0F3aWPFWC9aocQiAk37TDtQjEnr4QbzmhfMDOFyaL6K3v2B/gzgMjMf/DjqsiDKxTRxklS81SL5xbfsiUnS7JI24Ht47ZmP1pofsemhPlE6QZxFJhnWtov8KV4qH4EcXgusfq1D4YNesY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b=fsMVk2TS; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.18.1.2/8.18.1.2) with ESMTP id 54FFiLt3032296
	for <linux-btrfs@vger.kernel.org>; Thu, 15 May 2025 09:37:00 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=facebook; bh=Y
	oCrtATZ1r7Gfu1UYTAW0Nh9DB1m7ODUWLpgwLMEs1A=; b=fsMVk2TS3WAzu10YG
	7a3aiCsl5xbdxfcb4uSjcQaxHj4oLc0LeIoQ9MBKhviA/Rq0Jwgc+5yzfFfB1Vm6
	+SUx/GYgDWMv3Bw9Pslp0sj8wmLqNpYL+4P5phqFbi9EtuqX47787nL/zDw62+Km
	VMg7RP0WMRtiHIAjtkOsei+jwc=
Received: from mail.thefacebook.com ([163.114.134.16])
	by m0001303.ppops.net (PPS) with ESMTPS id 46mmw2mu9x-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-btrfs@vger.kernel.org>; Thu, 15 May 2025 09:36:59 -0700 (PDT)
Received: from twshared11082.06.ash8.facebook.com (2620:10d:c085:208::7cb7) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1748.10; Thu, 15 May 2025 16:36:57 +0000
Received: by devbig276.nha1.facebook.com (Postfix, from userid 660015)
	id 0EBA4F3BE104; Thu, 15 May 2025 17:36:46 +0100 (BST)
From: Mark Harmstone <maharmstone@fb.com>
To: <linux-btrfs@vger.kernel.org>
CC: Mark Harmstone <maharmstone@fb.com>
Subject: [RFC PATCH 01/10] btrfs: add definitions and constants for remap-tree
Date: Thu, 15 May 2025 17:36:29 +0100
Message-ID: <20250515163641.3449017-2-maharmstone@fb.com>
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
X-Proofpoint-GUID: Ozzp95JZ9zjRpUtjIslJpYzHZvOOx9rj
X-Proofpoint-ORIG-GUID: Ozzp95JZ9zjRpUtjIslJpYzHZvOOx9rj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE1MDE2NCBTYWx0ZWRfX89hnPhL8rvLP e/hcDK4dM/XsJomIjd8+c7vp/+sV6L/qAZCQe+34aPrqPf4/976WMC6tDUa8uVfznrXVYsHE8r5 Lsh8ZKgoKL5YRQ35zcz91MCi8kMjDmmY9zhWPr7XHEtX6XdjymBL7UtJnrDfGLWlk0oeT7viOnX
 q6WrSgzVInExqh3jN4VnvAgrtS6ynh/x3uP9vwWbT5OkxxUqxNGwhZixJOlNPZmo/0avp3qeMp0 pcv1K76RLsFERZ3r2OZZaXsCXPIZZUgscbKZR073sMlYiwU+4n8YghRZ22nDGnHoVVxPc2PehkS 0BLjX7QCzH3LKWAf5IQGhT5WGbhNiFPyrV1iE4+gvDc2lpW7A43YPQgjVLSGOeSTshj9u5XRKk+
 G5wQIK4VPbnR0oF9vfpQnzskWQvGUmiI+/6Gw3g6O85wTUXqdwEIhPbuFiHpvXOrkohyZ6qO
X-Authority-Analysis: v=2.4 cv=DtZW+H/+ c=1 sm=1 tr=0 ts=6826182b cx=c_pps a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17 a=dt9VzEwgFbYA:10 a=FOH2dFAWAAAA:8 a=KFvQRHhEJ8czjn08fOUA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-15_07,2025-05-15_01,2025-03-28_01

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
index 5d93d9dd2c12..3165194f62ab 100644
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
index 89835071cfea..e041964d03c8 100644
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


