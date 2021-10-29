Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C62D4401DA
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Oct 2021 20:28:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230136AbhJ2Sav (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 29 Oct 2021 14:30:51 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:5756 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229886AbhJ2Sau (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 29 Oct 2021 14:30:50 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19THwaON029589
        for <linux-btrfs@vger.kernel.org>; Fri, 29 Oct 2021 11:28:22 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=ICdOFFEZgf6bSeNkLmhyBQiT70HignU2GY2CK5/howo=;
 b=CpJsNZaZPZC9AH8PfmFry28Q9C/KtXyL5VexHDbzhyqtlskJz6isiHJTPYzE48hlmEma
 e4qYy6HDP/GvNR3XkBQX8PLWBdfbmTnVmTV6ZqmI7rjUG1uCx+CN0+ODYNNT92C5M7k/
 sS7522KDhQMd9Z5H37wZcssTe/kcYQQQ/aU= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3c03hk8a8m-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-btrfs@vger.kernel.org>; Fri, 29 Oct 2021 11:28:21 -0700
Received: from intmgw001.38.frc1.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:11d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Fri, 29 Oct 2021 11:28:17 -0700
Received: by devvm225.atn0.facebook.com (Postfix, from userid 425415)
        id DCE8F5BCB63A; Fri, 29 Oct 2021 11:28:15 -0700 (PDT)
From:   Stefan Roesch <shr@fb.com>
To:     <linux-btrfs@vger.kernel.org>, <kernel-team@fb.com>
CC:     <shr@fb.com>
Subject: [PATCH v3 1/4] btrfs: store stripe size and chunk size in space-info struct.
Date:   Fri, 29 Oct 2021 11:28:08 -0700
Message-ID: <20211029182812.3560677-3-shr@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211029182812.3560677-1-shr@fb.com>
References: <20211029182812.3560677-1-shr@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-ORIG-GUID: ukwUodlt2_POiK6ev5qqDD033J_Jp9ZD
X-Proofpoint-GUID: ukwUodlt2_POiK6ev5qqDD033J_Jp9ZD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-29_04,2021-10-29_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 suspectscore=0 phishscore=0 spamscore=0 malwarescore=0 clxscore=1015
 impostorscore=0 mlxlogscore=999 mlxscore=0 lowpriorityscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2110290100
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
 fs/btrfs/space-info.c | 51 +++++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/space-info.h |  3 +++
 fs/btrfs/volumes.c    | 28 ++++++++----------------
 3 files changed, 63 insertions(+), 19 deletions(-)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 48d77f360a24..7370c152ce8a 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -181,6 +181,56 @@ void btrfs_clear_space_info_full(struct btrfs_fs_inf=
o *info)
 		found->full =3D 0;
 }
=20
+/*
+ * Compute chunk size depending on block type for regular volumes.
+ */
+static u64 compute_chunk_size_regular(struct btrfs_fs_info *info, u64 fl=
ags)
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
+ * Compute chunk size for zoned volumes.
+ */
+static u64 compute_chunk_size_zoned(struct btrfs_fs_info *info)
+{
+	return info->zone_size;
+}
+
+/*
+ * Compute chunk size depending on volume type.
+ */
+static u64 compute_chunk_size(struct btrfs_fs_info *info, u64 flags)
+{
+	if (btrfs_is_zoned(info))
+		return compute_chunk_size_zoned(info);
+
+	return compute_chunk_size_regular(info, flags);
+}
+
+/*
+ * Update default chunk size.
+ *
+ */
+void btrfs_update_space_info_chunk_size(struct btrfs_space_info *space_i=
nfo,
+					u64 flags, u64 chunk_size)
+{
+	spin_lock(&space_info->lock);
+	space_info->default_chunk_size =3D chunk_size;
+	spin_unlock(&space_info->lock);
+}
+
 static int create_space_info(struct btrfs_fs_info *info, u64 flags)
 {
=20
@@ -202,6 +252,7 @@ static int create_space_info(struct btrfs_fs_info *in=
fo, u64 flags)
 	INIT_LIST_HEAD(&space_info->tickets);
 	INIT_LIST_HEAD(&space_info->priority_tickets);
 	space_info->clamp =3D 1;
+	space_info->default_chunk_size =3D compute_chunk_size(info, flags);
=20
 	ret =3D btrfs_sysfs_add_space_info_type(info, space_info);
 	if (ret)
diff --git a/fs/btrfs/space-info.h b/fs/btrfs/space-info.h
index cb5056472e79..aa8fc0f72ea6 100644
--- a/fs/btrfs/space-info.h
+++ b/fs/btrfs/space-info.h
@@ -23,6 +23,7 @@ struct btrfs_space_info {
 	u64 max_extent_size;	/* This will hold the maximum extent size of
 				   the space info if we had an ENOSPC in the
 				   allocator. */
+	u64 default_chunk_size; /* default chunk size in bytes */
=20
 	int clamp;		/* Used to scale our threshold for preemptive
 				   flushing. The value is >> clamp, so turns
@@ -115,6 +116,8 @@ void btrfs_update_space_info(struct btrfs_fs_info *in=
fo, u64 flags,
 			     u64 total_bytes, u64 bytes_used,
 			     u64 bytes_readonly, u64 bytes_zone_unusable,
 			     struct btrfs_space_info **space_info);
+void btrfs_update_space_info_chunk_size(struct btrfs_space_info *space_i=
nfo,
+			     u64 flags, u64 chunk_size);
 struct btrfs_space_info *btrfs_find_space_info(struct btrfs_fs_info *inf=
o,
 					       u64 flags);
 u64 __pure btrfs_space_info_used(struct btrfs_space_info *s_info,
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 546bf1146b2d..563e5b30060d 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -5063,26 +5063,16 @@ static void init_alloc_chunk_ctl_policy_regular(
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
+	ctl->max_chunk_size =3D space_info->default_chunk_size;
+	ctl->max_stripe_size =3D space_info->default_chunk_size;
+
+	if (ctl->type & BTRFS_BLOCK_GROUP_SYSTEM)
+		ctl->devs_max =3D min_t(int, ctl->devs_max, BTRFS_MAX_DEVS_SYS_CHUNK);
=20
 	/* We don't want a chunk larger than 10% of writable space */
 	ctl->max_chunk_size =3D min(div_factor(fs_devices->total_rw_bytes, 1),
--=20
2.30.2

