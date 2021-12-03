Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B163B467FA6
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Dec 2021 23:04:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383315AbhLCWIP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 3 Dec 2021 17:08:15 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:25908 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1383313AbhLCWIO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 3 Dec 2021 17:08:14 -0500
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B3L6JDu016516
        for <linux-btrfs@vger.kernel.org>; Fri, 3 Dec 2021 14:04:50 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=lSMyFTa6/TYBIqI2AsPpOTRxrk8eDHHs7iuA/a5cSbk=;
 b=HAYzdllb5imhhs239UJmxN+JZDDgDwrh7sxwq0C4awatte073g5htDqtDrqyw7OVhFkS
 catxFhvt8BHE1hRrAsXTE0qhAZycVW1uIj+vnqGtiyKJtV7WqLt97orB2RhMSYjqqaHH
 mDQEB4UPg7qAAMLcjIG62ChxeMIzeZfx+p0= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3cqck4e7sb-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-btrfs@vger.kernel.org>; Fri, 03 Dec 2021 14:04:50 -0800
Received: from intmgw001.37.frc1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 3 Dec 2021 14:04:48 -0800
Received: by devvm225.atn0.facebook.com (Postfix, from userid 425415)
        id 2C41276B31D3; Fri,  3 Dec 2021 14:04:47 -0800 (PST)
From:   Stefan Roesch <shr@fb.com>
To:     <linux-btrfs@vger.kernel.org>, <kernel-team@fb.com>
CC:     <shr@fb.com>
Subject: [PATCH v6 1/4] btrfs: store chunk size in space-info struct.
Date:   Fri, 3 Dec 2021 14:04:42 -0800
Message-ID: <20211203220445.2312182-2-shr@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211203220445.2312182-1-shr@fb.com>
References: <20211203220445.2312182-1-shr@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-ORIG-GUID: q-taXw-jDm9-b3c_TaicuHMourshQgk_
X-Proofpoint-GUID: q-taXw-jDm9-b3c_TaicuHMourshQgk_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-03_11,2021-12-02_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 spamscore=0 adultscore=0
 impostorscore=0 mlxscore=0 suspectscore=0 bulkscore=0 phishscore=0
 lowpriorityscore=0 clxscore=1015 malwarescore=0 priorityscore=1501
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112030142
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The chunk size is stored in the btrfs_space_info structure.
It is initialized at the start and is then used.

A new api is added to update the current chunk size.

This api is used to be able to expose the chunk_size
as a sysfs setting.

Signed-off-by: Stefan Roesch <shr@fb.com>
---
 fs/btrfs/space-info.c | 41 +++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/space-info.h |  3 +++
 fs/btrfs/volumes.c    | 28 +++++++++-------------------
 3 files changed, 53 insertions(+), 19 deletions(-)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 79fe0ad17acf..437d1240f491 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -181,6 +181,46 @@ void btrfs_clear_space_info_full(struct btrfs_fs_inf=
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
+ * Compute chunk size depending on volume type.
+ */
+static u64 compute_chunk_size(struct btrfs_fs_info *info, u64 flags)
+{
+	if (btrfs_is_zoned(info))
+		return info->zone_size;
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
+					u64 chunk_size)
+{
+	atomic64_set(&space_info->chunk_size, chunk_size);
+}
+
 static int create_space_info(struct btrfs_fs_info *info, u64 flags)
 {
=20
@@ -202,6 +242,7 @@ static int create_space_info(struct btrfs_fs_info *in=
fo, u64 flags)
 	INIT_LIST_HEAD(&space_info->tickets);
 	INIT_LIST_HEAD(&space_info->priority_tickets);
 	space_info->clamp =3D 1;
+	btrfs_update_space_info_chunk_size(space_info, compute_chunk_size(info,=
 flags));
=20
 	ret =3D btrfs_sysfs_add_space_info_type(info, space_info);
 	if (ret)
diff --git a/fs/btrfs/space-info.h b/fs/btrfs/space-info.h
index d841fed73492..c1a64bbfb6d1 100644
--- a/fs/btrfs/space-info.h
+++ b/fs/btrfs/space-info.h
@@ -23,6 +23,7 @@ struct btrfs_space_info {
 	u64 max_extent_size;	/* This will hold the maximum extent size of
 				   the space info if we had an ENOSPC in the
 				   allocator. */
+	atomic64_t chunk_size;  /* chunk size in bytes */
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
+			     u64 chunk_size);
 struct btrfs_space_info *btrfs_find_space_info(struct btrfs_fs_info *inf=
o,
 					       u64 flags);
 u64 __pure btrfs_space_info_used(struct btrfs_space_info *s_info,
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index f38c230111be..546c39551648 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -5106,26 +5106,16 @@ static void init_alloc_chunk_ctl_policy_regular(
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
+	ctl->max_chunk_size =3D atomic64_read(&space_info->chunk_size);
+	ctl->max_stripe_size =3D ctl->max_chunk_size;
+
+	if (ctl->type & BTRFS_BLOCK_GROUP_SYSTEM)
+		ctl->devs_max =3D min_t(int, ctl->devs_max, BTRFS_MAX_DEVS_SYS_CHUNK);
=20
 	/* We don't want a chunk larger than 10% of writable space */
 	ctl->max_chunk_size =3D min(div_factor(fs_devices->total_rw_bytes, 1),
--=20
2.30.2

