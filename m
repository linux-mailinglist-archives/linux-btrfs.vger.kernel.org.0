Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C512D4AE255
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Feb 2022 20:35:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386132AbiBHTeW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 8 Feb 2022 14:34:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236908AbiBHTeV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 8 Feb 2022 14:34:21 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA236C0613CB
        for <linux-btrfs@vger.kernel.org>; Tue,  8 Feb 2022 11:34:20 -0800 (PST)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 218E75wp013818
        for <linux-btrfs@vger.kernel.org>; Tue, 8 Feb 2022 11:34:20 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=spLghyaNkasgs1pj91omZuVZWt/hRZqMG7h8RkhLgdc=;
 b=XlImwbCawYJwtHpgLpBHM3JiaI4RCKE7DzmzuPJIUkreZ/rrb9qMQLb81p9UN/ehUVBV
 0rb2MluxLsdVFXqmchAUJUMRWerp80E8hZskIDmHi/uZJi1w5w1PYSm17uhuniU/oipf
 qIcdnQIwM4ub2985oLUZvRqQAFTShI3/WCc= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3e3puw3pvw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-btrfs@vger.kernel.org>; Tue, 08 Feb 2022 11:34:20 -0800
Received: from twshared18912.14.frc2.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:21d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 8 Feb 2022 11:34:19 -0800
Received: by devvm225.atn0.facebook.com (Postfix, from userid 425415)
        id 3A556A7B5428; Tue,  8 Feb 2022 11:31:25 -0800 (PST)
From:   Stefan Roesch <shr@fb.com>
To:     <linux-btrfs@vger.kernel.org>, <kernel-team@fb.com>
CC:     <shr@fb.com>
Subject: [PATCH v1 2/3] btrfs: expose chunk size in sysfs.
Date:   Tue, 8 Feb 2022 11:31:21 -0800
Message-ID: <20220208193122.492533-3-shr@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220208193122.492533-1-shr@fb.com>
References: <20220208193122.492533-1-shr@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: _PNftxMIeDhkaZvXaoFX1gX_0LfA1lFo
X-Proofpoint-ORIG-GUID: _PNftxMIeDhkaZvXaoFX1gX_0LfA1lFo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-08_06,2022-02-07_02,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 malwarescore=0
 mlxlogscore=999 phishscore=0 mlxscore=0 suspectscore=0 lowpriorityscore=0
 bulkscore=0 spamscore=0 priorityscore=1501 impostorscore=0 adultscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202080114
X-FB-Internal: deliver
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
index beb7f72d50b8..ca337117f15b 100644
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

