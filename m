Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FDBD44B518
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Nov 2021 23:02:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244776AbhKIWFU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 9 Nov 2021 17:05:20 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:18956 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S244705AbhKIWFU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 9 Nov 2021 17:05:20 -0500
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.1.2/8.16.1.2) with SMTP id 1A9M0akH017618
        for <linux-btrfs@vger.kernel.org>; Tue, 9 Nov 2021 14:02:33 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=XaCykFwXMCDAcNbB2ExNRUs+wHOEbi/f6LfQ6DxQcGs=;
 b=pKO7YIVj0CkonrrXUqgXF0zbLgrmudYzgbnfXI68jUUThl3yvEvPOv0IuosW57ufUbaU
 wdtjyRI+FOGALg+O6QIhmf+IZJQwPU/2PClIl/zcwDIIUYqYNphFK/VIXMQpvvGzC9Nn
 r+b791CU4G4EnOO75X+l5pGIyPagYpfPYRM= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0089730.ppops.net with ESMTP id 3c7w04jfgk-10
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-btrfs@vger.kernel.org>; Tue, 09 Nov 2021 14:02:33 -0800
Received: from intmgw006.03.ash8.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Tue, 9 Nov 2021 14:02:32 -0800
Received: by devvm225.atn0.facebook.com (Postfix, from userid 425415)
        id 3EA6D6326D82; Tue,  9 Nov 2021 14:02:21 -0800 (PST)
From:   Stefan Roesch <shr@fb.com>
To:     <linux-btrfs@vger.kernel.org>, <kernel-team@fb.com>
CC:     <shr@fb.com>
Subject: [PATCH v5 2/4] btrfs: expose chunk size in sysfs.
Date:   Tue, 9 Nov 2021 14:02:16 -0800
Message-ID: <20211109220218.602995-3-shr@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211109220218.602995-1-shr@fb.com>
References: <20211109220218.602995-1-shr@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-GUID: E2Je954UWtfzG1Usi3L7ISzUVYn2uyyX
X-Proofpoint-ORIG-GUID: E2Je954UWtfzG1Usi3L7ISzUVYn2uyyX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-09_07,2021-11-08_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 clxscore=1015 phishscore=0 adultscore=1 lowpriorityscore=0 mlxscore=0
 impostorscore=0 malwarescore=0 mlxlogscore=999 spamscore=0 suspectscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111090119
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This adds a new sysfs entry in /sys/fs/btrfs/<uuid>/allocation/<block
type>/chunk_size. This allows to query the chunk size and also set the
chunk size.

Signed-off-by: Stefan Roesch <shr@fb.com>
---
 fs/btrfs/sysfs.c | 94 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 94 insertions(+)

diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index f9eff3b0f77c..39890ea21997 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -21,6 +21,7 @@
 #include "space-info.h"
 #include "block-group.h"
 #include "qgroup.h"
+#include "misc.h"
=20
 /*
  * Structure name                       Path
@@ -92,6 +93,7 @@ static struct btrfs_feature_attr btrfs_attr_features_##=
_name =3D {	     \
=20
 static inline struct btrfs_fs_info *to_fs_info(struct kobject *kobj);
 static inline struct btrfs_fs_devices *to_fs_devs(struct kobject *kobj);
+static inline struct kobject *get_btrfs_kobj(struct kobject *kobj);
=20
 static struct btrfs_feature_attr *to_btrfs_feature_attr(struct kobj_attr=
ibute *a)
 {
@@ -708,6 +710,81 @@ static ssize_t btrfs_space_info_show_##field(struct =
kobject *kobj,	\
 }									\
 BTRFS_ATTR(space_info, field, btrfs_space_info_show_##field)
=20
+/*
+ * Return space info chunk size.
+ */
+static ssize_t btrfs_chunk_size_show(struct kobject *kobj,
+				     struct kobj_attribute *a, char *buf)
+{
+	struct btrfs_space_info *sinfo =3D to_space_info(kobj);
+
+	return sysfs_emit(buf, "%llu\n", atomic64_read(&sinfo->chunk_size));
+}
+
+/*
+ * Store new user supplied chunk size in space info.
+ *
+ * Note: If the new chunk size value is larger than 10% of free space it=
 is
+ *       reduced to match that limit.
+ */
+static ssize_t btrfs_chunk_size_store(struct kobject *kobj,
+				      struct kobj_attribute *a,
+				      const char *buf, size_t len)
+{
+	struct btrfs_space_info *space_info =3D to_space_info(kobj);
+	struct btrfs_fs_info *fs_info =3D to_fs_info(get_btrfs_kobj(kobj));
+	u64 val;
+	int ret;
+
+	if (!capable(CAP_SYS_ADMIN))
+		return -EPERM;
+
+	if (!fs_info) {
+		pr_err("couldn't get fs_info\n");
+		return -EPERM;
+	}
+
+	if (sb_rdonly(fs_info->sb))
+		return -EROFS;
+
+	if (!fs_info->fs_devices)
+		return -EINVAL;
+
+	if (btrfs_is_zoned(fs_info))
+		return -EINVAL;
+
+	if (!space_info) {
+		btrfs_err(fs_info, "couldn't get space_info\n");
+		return -EPERM;
+	}
+
+	/* System block type must not be changed. */
+	if (space_info->flags & BTRFS_BLOCK_GROUP_SYSTEM)
+		return -EINVAL;
+
+	ret =3D kstrtoull(buf, 10, &val);
+	if (ret)
+		return ret;
+
+	val =3D min(val, BTRFS_MAX_DATA_CHUNK_SIZE);
+
+	/*
+	 * Limit stripe size to 10% of available space.
+	 */
+	val =3D min(div_factor(fs_info->fs_devices->total_rw_bytes, 1), val);
+
+	/* Must be multiple of 256M. */
+	val &=3D ~(SZ_256M - 1);
+
+	/* Must be at least 256M. */
+	if (val < SZ_256M)
+		return -EINVAL;
+
+	btrfs_update_space_info_chunk_size(space_info, val);
+
+	return val;
+}
+
 SPACE_INFO_ATTR(flags);
 SPACE_INFO_ATTR(total_bytes);
 SPACE_INFO_ATTR(bytes_used);
@@ -718,6 +795,8 @@ SPACE_INFO_ATTR(bytes_readonly);
 SPACE_INFO_ATTR(bytes_zone_unusable);
 SPACE_INFO_ATTR(disk_used);
 SPACE_INFO_ATTR(disk_total);
+BTRFS_ATTR_RW(space_info, chunk_size, btrfs_chunk_size_show,
+	      btrfs_chunk_size_store);
=20
 /*
  * Allocation information about block group types.
@@ -735,6 +814,7 @@ static struct attribute *space_info_attrs[] =3D {
 	BTRFS_ATTR_PTR(space_info, bytes_zone_unusable),
 	BTRFS_ATTR_PTR(space_info, disk_used),
 	BTRFS_ATTR_PTR(space_info, disk_total),
+	BTRFS_ATTR_PTR(space_info, chunk_size),
 	NULL,
 };
 ATTRIBUTE_GROUPS(space_info);
@@ -1099,6 +1179,20 @@ static inline struct btrfs_fs_info *to_fs_info(str=
uct kobject *kobj)
 	return to_fs_devs(kobj)->fs_info;
 }
=20
+/*
+ * Get btrfs sysfs kobject.
+ */
+static inline struct kobject *get_btrfs_kobj(struct kobject *kobj)
+{
+	while (kobj) {
+		if (kobj->ktype =3D=3D &btrfs_ktype)
+			return kobj;
+		kobj =3D kobj->parent;
+	}
+
+	return NULL;
+}
+
 #define NUM_FEATURE_BITS 64
 #define BTRFS_FEATURE_NAME_MAX 13
 static char btrfs_unknown_feature_names[FEAT_MAX][NUM_FEATURE_BITS][BTRF=
S_FEATURE_NAME_MAX];
--=20
2.30.2

