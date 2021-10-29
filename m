Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAEE1440234
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Oct 2021 20:42:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230084AbhJ2SpF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 29 Oct 2021 14:45:05 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:44376 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229755AbhJ2SpF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 29 Oct 2021 14:45:05 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19THwOtU023523
        for <linux-btrfs@vger.kernel.org>; Fri, 29 Oct 2021 11:42:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=PhMjLyz00qPRmsaUiWAWs8e9QKYTov5mmdXFEWW0Wj0=;
 b=MmSfpWXG0ZEtgXUSgzdcaxaRaDOM6GqEqVEoSbroavGL4G5gJ41hnydkZEAu6RWc7EGG
 GQQpGfW1xQWCTeNHCVRk9o8zxIsCNbwufGARu1NV28CWEr4ygmquQTCxBScEKYnPUdYa
 MN5IjnkZFkWwojmdbVdj3hJ6WWqoeuIVIqs= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3c0mdnhaqn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-btrfs@vger.kernel.org>; Fri, 29 Oct 2021 11:42:35 -0700
Received: from intmgw001.05.ash9.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:11d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Fri, 29 Oct 2021 11:39:55 -0700
Received: by devvm225.atn0.facebook.com (Postfix, from userid 425415)
        id E68925BCD6F3; Fri, 29 Oct 2021 11:39:51 -0700 (PDT)
From:   Stefan Roesch <shr@fb.com>
To:     <linux-btrfs@vger.kernel.org>, <kernel-team@fb.com>
CC:     <shr@fb.com>
Subject: [PATCH v4 2/4] btrfs: expose chunk size in sysfs.
Date:   Fri, 29 Oct 2021 11:39:48 -0700
Message-ID: <20211029183950.3613491-3-shr@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211029183950.3613491-1-shr@fb.com>
References: <20211029183950.3613491-1-shr@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-GUID: B4bjtlUMxlFHksLAI4pr6O6WAwoNd9Ft
X-Proofpoint-ORIG-GUID: B4bjtlUMxlFHksLAI4pr6O6WAwoNd9Ft
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-29_04,2021-10-29_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0 clxscore=1015
 mlxlogscore=999 lowpriorityscore=0 spamscore=0 suspectscore=0
 malwarescore=0 impostorscore=0 priorityscore=1501 phishscore=0
 adultscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2110290101
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This adds a new sysfs entry in /sys/fs/btrfs/<uuid>/allocation/<block
type>/chunk_size. This allows to query the chunk size and also set the
chunk size.

Signed-off-by: Stefan Roesch <shr@fb.com>
---
 fs/btrfs/sysfs.c | 80 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 80 insertions(+)

diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index f9eff3b0f77c..3b0bcbc2ed2e 100644
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
@@ -708,6 +710,67 @@ static ssize_t btrfs_space_info_show_##field(struct =
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
+	return btrfs_show_u64(&sinfo->default_chunk_size, &sinfo->lock, buf);
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
+	ret =3D kstrtoull(buf, 10, &val);
+	if (ret)
+		return ret;
+
+	/*
+	 * Limit stripe size to 10% of available space.
+	 */
+	val =3D min(div_factor(fs_info->fs_devices->total_rw_bytes, 1), val);
+	btrfs_update_space_info_chunk_size(space_info, space_info->flags, val);
+
+	return val;
+}
+
 SPACE_INFO_ATTR(flags);
 SPACE_INFO_ATTR(total_bytes);
 SPACE_INFO_ATTR(bytes_used);
@@ -718,6 +781,8 @@ SPACE_INFO_ATTR(bytes_readonly);
 SPACE_INFO_ATTR(bytes_zone_unusable);
 SPACE_INFO_ATTR(disk_used);
 SPACE_INFO_ATTR(disk_total);
+BTRFS_ATTR_RW(space_info, chunk_size, btrfs_chunk_size_show,
+	      btrfs_chunk_size_store);
=20
 /*
  * Allocation information about block group types.
@@ -735,6 +800,7 @@ static struct attribute *space_info_attrs[] =3D {
 	BTRFS_ATTR_PTR(space_info, bytes_zone_unusable),
 	BTRFS_ATTR_PTR(space_info, disk_used),
 	BTRFS_ATTR_PTR(space_info, disk_total),
+	BTRFS_ATTR_PTR(space_info, chunk_size),
 	NULL,
 };
 ATTRIBUTE_GROUPS(space_info);
@@ -1099,6 +1165,20 @@ static inline struct btrfs_fs_info *to_fs_info(str=
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

