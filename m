Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28DD743D2AC
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Oct 2021 22:16:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239025AbhJ0USz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 27 Oct 2021 16:18:55 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:3804 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238937AbhJ0USy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 27 Oct 2021 16:18:54 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19RK0dGt022556
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Oct 2021 13:16:28 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=1mn+VR8um+mHuxZXNIzMakzVRLFDcBbY/Gw2sRb95Vs=;
 b=gIeyD6RnXHflSBzhZMI7Eg4dLmPSbf+/OhM1l7dxr5sN13jigLnIak/GM8zK+lxtV5NK
 OmCknx0eGxcvpD+aH0M5qsT79xfMfAGjE0zzv9q7YWItmugJLGG11ke2fSdLn736BiV0
 B/lnZZQK/VvR/flk2Wet/x2CFQaFwLj7VwE= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3bxwmx0v6b-19
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Oct 2021 13:16:28 -0700
Received: from intmgw006.03.ash8.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Wed, 27 Oct 2021 13:14:47 -0700
Received: by devvm225.atn0.facebook.com (Postfix, from userid 425415)
        id 137EE5A487C7; Wed, 27 Oct 2021 13:14:44 -0700 (PDT)
From:   Stefan Roesch <shr@fb.com>
To:     <linux-btrfs@vger.kernel.org>, <kernel-team@fb.com>
CC:     <shr@fb.com>
Subject: [PATCH v2 1/4] btrfs: store stripe size and chunk size in space-info struct.
Date:   Wed, 27 Oct 2021 13:14:38 -0700
Message-ID: <20211027201441.3813178-2-shr@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211027201441.3813178-1-shr@fb.com>
References: <20211027201441.3813178-1-shr@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-GUID: c_45Ye6nma_jODYbphDS7AkN1Dxit2Kn
X-Proofpoint-ORIG-GUID: c_45Ye6nma_jODYbphDS7AkN1Dxit2Kn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-27_06,2021-10-26_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 malwarescore=0 bulkscore=0 priorityscore=1501 clxscore=1015 mlxscore=0
 adultscore=0 spamscore=0 phishscore=0 suspectscore=0 impostorscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2110270115
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The stripe size and chunk size are stored in the btrfs_space_info
structure. They are initialized at the start and are then used.

Two api's are added to get the current value and one to update
the value.

These api's will be used to be able to expose the stripe_size
as a sysfs setting.

Signed-off-by: Stefan Roesch <shr@fb.com>
---
 fs/btrfs/space-info.c | 72 +++++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/space-info.h |  4 +++
 fs/btrfs/volumes.c    | 28 ++++++-----------
 3 files changed, 85 insertions(+), 19 deletions(-)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 48d77f360a24..570acfebeae4 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -181,6 +181,74 @@ void btrfs_clear_space_info_full(struct btrfs_fs_inf=
o *info)
 		found->full =3D 0;
 }
=20
+/*
+ * Compute stripe size depending on block type for regular volumes.
+ */
+static u64 compute_stripe_size_regular(struct btrfs_fs_info *info, u64 f=
lags)
+{
+	ASSERT(flags & BTRFS_BLOCK_GROUP_TYPE_MASK);
+
+	if (flags & BTRFS_BLOCK_GROUP_DATA)
+		return SZ_1G;
+	else if (flags & BTRFS_BLOCK_GROUP_SYSTEM)
+		return SZ_32M;
+
+	/* Handle BTRFS_BLOCK_GROUP_METADATA */
+	if (info->fs_devices->total_rw_bytes > 50ULL * SZ_1G)
+		return SZ_1G;
+
+	return SZ_256M;
+}
+
+/*
+ * Compute stripe size for zoned volumes.
+ */
+static u64 compute_stripe_size_zoned(struct btrfs_fs_info *info)
+{
+	return info->zone_size;
+}
+
+/*
+ * Compute stripe size depending on volume type.
+ */
+static u64 compute_stripe_size(struct btrfs_fs_info *info, u64 flags)
+{
+	if (btrfs_is_zoned(info))
+		return compute_stripe_size_zoned(info);
+
+	return compute_stripe_size_regular(info, flags);
+}
+
+/*
+ * Compute chunk size depending on block type and stripe size.
+ */
+static u64 compute_chunk_size(u64 flags, u64 max_stripe_size)
+{
+	ASSERT(flags & BTRFS_BLOCK_GROUP_TYPE_MASK);
+
+	if (flags & BTRFS_BLOCK_GROUP_DATA)
+		return BTRFS_MAX_DATA_CHUNK_SIZE;
+	else if (flags & BTRFS_BLOCK_GROUP_METADATA)
+		return max_stripe_size;
+
+	/* Handle BTRFS_BLOCK_GROUP_SYSTEM */
+	return 2 * max_stripe_size;
+}
+
+/*
+ * Update maximum stripe size and chunk size.
+ *
+ */
+void btrfs_update_space_info_max_alloc_sizes(struct btrfs_space_info *sp=
ace_info,
+					     u64 flags, u64 max_stripe_size)
+{
+	spin_lock(&space_info->lock);
+	space_info->max_stripe_size =3D max_stripe_size;
+	space_info->max_chunk_size =3D compute_chunk_size(flags,
+						space_info->max_stripe_size);
+	spin_unlock(&space_info->lock);
+}
+
 static int create_space_info(struct btrfs_fs_info *info, u64 flags)
 {
=20
@@ -203,6 +271,10 @@ static int create_space_info(struct btrfs_fs_info *i=
nfo, u64 flags)
 	INIT_LIST_HEAD(&space_info->priority_tickets);
 	space_info->clamp =3D 1;
=20
+	space_info->max_stripe_size =3D compute_stripe_size(info, flags);
+	space_info->max_chunk_size =3D compute_chunk_size(flags,
+						space_info->max_stripe_size);
+
 	ret =3D btrfs_sysfs_add_space_info_type(info, space_info);
 	if (ret)
 		return ret;
diff --git a/fs/btrfs/space-info.h b/fs/btrfs/space-info.h
index cb5056472e79..5ee3e381de38 100644
--- a/fs/btrfs/space-info.h
+++ b/fs/btrfs/space-info.h
@@ -23,6 +23,8 @@ struct btrfs_space_info {
 	u64 max_extent_size;	/* This will hold the maximum extent size of
 				   the space info if we had an ENOSPC in the
 				   allocator. */
+	u64 max_chunk_size; /* maximum chunk size in bytes */
+	u64 max_stripe_size; /* maximum stripe size in bytes */
=20
 	int clamp;		/* Used to scale our threshold for preemptive
 				   flushing. The value is >> clamp, so turns
@@ -115,6 +117,8 @@ void btrfs_update_space_info(struct btrfs_fs_info *in=
fo, u64 flags,
 			     u64 total_bytes, u64 bytes_used,
 			     u64 bytes_readonly, u64 bytes_zone_unusable,
 			     struct btrfs_space_info **space_info);
+void btrfs_update_space_info_max_alloc_sizes(struct btrfs_space_info *sp=
ace_info,
+			     u64 flags, u64 max_stripe_size);
 struct btrfs_space_info *btrfs_find_space_info(struct btrfs_fs_info *inf=
o,
 					       u64 flags);
 u64 __pure btrfs_space_info_used(struct btrfs_space_info *s_info,
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 6031e2f4c6bc..6408592d4461 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -5002,26 +5002,16 @@ static void init_alloc_chunk_ctl_policy_regular(
 				struct btrfs_fs_devices *fs_devices,
 				struct alloc_chunk_ctl *ctl)
 {
-	u64 type =3D ctl->type;
+	struct btrfs_space_info *space_info;
=20
-	if (type & BTRFS_BLOCK_GROUP_DATA) {
-		ctl->max_stripe_size =3D SZ_1G;
-		ctl->max_chunk_size =3D BTRFS_MAX_DATA_CHUNK_SIZE;
-	} else if (type & BTRFS_BLOCK_GROUP_METADATA) {
-		/* For larger filesystems, use larger metadata chunks */
-		if (fs_devices->total_rw_bytes > 50ULL * SZ_1G)
-			ctl->max_stripe_size =3D SZ_1G;
-		else
-			ctl->max_stripe_size =3D SZ_256M;
-		ctl->max_chunk_size =3D ctl->max_stripe_size;
-	} else if (type & BTRFS_BLOCK_GROUP_SYSTEM) {
-		ctl->max_stripe_size =3D SZ_32M;
-		ctl->max_chunk_size =3D 2 * ctl->max_stripe_size;
-		ctl->devs_max =3D min_t(int, ctl->devs_max,
-				      BTRFS_MAX_DEVS_SYS_CHUNK);
-	} else {
-		BUG();
-	}
+	space_info =3D btrfs_find_space_info(fs_devices->fs_info, ctl->type);
+	ASSERT(space_info);
+
+	ctl->max_stripe_size =3D space_info->max_stripe_size;
+	ctl->max_chunk_size =3D space_info->max_chunk_size;
+
+	if (ctl->type & BTRFS_BLOCK_GROUP_SYSTEM)
+		ctl->devs_max =3D min_t(int, ctl->devs_max, BTRFS_MAX_DEVS_SYS_CHUNK);
=20
 	/* We don't want a chunk larger than 10% of writable space */
 	ctl->max_chunk_size =3D min(div_factor(fs_devices->total_rw_bytes, 1),
--=20
2.30.2

