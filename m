Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D5D544B516
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Nov 2021 23:02:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244712AbhKIWFT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 9 Nov 2021 17:05:19 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:64342 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237422AbhKIWFQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 9 Nov 2021 17:05:16 -0500
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1A9LviBD019749
        for <linux-btrfs@vger.kernel.org>; Tue, 9 Nov 2021 14:02:30 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=8qufuFiPOctj4aEwGygamM5nb7hRbgBQFF0u4nF9s/w=;
 b=ZcToQOwuVECdCS5Igc6q1tzUGLgRD2rmVKFPg5WbI5gJ4S6w4+TIF0zA1GI8mY2+6d86
 +UUDaIL0sR6qUhUG1YtVMIKrizD3/y/WpLiYKh/WlwM83g52UDCcU+DpAHBQ00Fqap2a
 Rk1JO4pC8YB0+6C+BG3GowebHFlGXyF1dLA= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3c7ys2rw4u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-btrfs@vger.kernel.org>; Tue, 09 Nov 2021 14:02:30 -0800
Received: from intmgw002.25.frc3.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::e) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Tue, 9 Nov 2021 14:02:29 -0800
Received: by devvm225.atn0.facebook.com (Postfix, from userid 425415)
        id 43B196326D84; Tue,  9 Nov 2021 14:02:21 -0800 (PST)
From:   Stefan Roesch <shr@fb.com>
To:     <linux-btrfs@vger.kernel.org>, <kernel-team@fb.com>
CC:     <shr@fb.com>
Subject: [PATCH v5 3/4] btrfs: add force_chunk_alloc sysfs entry to force allocation
Date:   Tue, 9 Nov 2021 14:02:17 -0800
Message-ID: <20211109220218.602995-4-shr@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211109220218.602995-1-shr@fb.com>
References: <20211109220218.602995-1-shr@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-ORIG-GUID: AoUePj2GoWTqbvokZFVOtjWv9wp6b6d_
X-Proofpoint-GUID: AoUePj2GoWTqbvokZFVOtjWv9wp6b6d_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-09_07,2021-11-08_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0 phishscore=0
 adultscore=0 mlxlogscore=999 spamscore=0 bulkscore=0 lowpriorityscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 impostorscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111090119
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This adds the force_chunk_alloc sysfs entry to be able to force a
storage allocation. This is a debugging and test feature and is
enabled with the CONFIG_BTRFS_DEBUG configuration option.

It is stored at
/sys/fs/btrfs/<uuid>/allocation/<block_type>/force_chunk_alloc.
---
 fs/btrfs/sysfs.c | 58 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index 39890ea21997..7eff8b8c4f1f 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -62,6 +62,10 @@ struct raid_kobject {
 	.store	=3D _store,						\
 }
=20
+#define BTRFS_ATTR_W(_prefix, _name, _store)			        \
+	static struct kobj_attribute btrfs_attr_##_prefix##_##_name =3D	\
+			__INIT_KOBJ_ATTR(_name, 0200, NULL, _store)
+
 #define BTRFS_ATTR_RW(_prefix, _name, _show, _store)			\
 	static struct kobj_attribute btrfs_attr_##_prefix##_##_name =3D	\
 			__INIT_KOBJ_ATTR(_name, 0644, _show, _store)
@@ -785,6 +789,54 @@ static ssize_t btrfs_chunk_size_store(struct kobject=
 *kobj,
 	return val;
 }
=20
+#ifdef CONFIG_BTRFS_DEBUG
+/*
+ * Request chunk allocation with current chunk size.
+ */
+static ssize_t btrfs_force_chunk_alloc_store(struct kobject *kobj,
+					     struct kobj_attribute *a,
+					     const char *buf, size_t len)
+{
+	struct btrfs_space_info *space_info =3D to_space_info(kobj);
+	struct btrfs_fs_info *fs_info =3D to_fs_info(get_btrfs_kobj(kobj));
+	struct btrfs_trans_handle *trans;
+	unsigned long val;
+	int ret;
+
+	if (!fs_info) {
+		pr_err("couldn't get fs_info\n");
+		return -EPERM;
+	}
+
+	if (!capable(CAP_SYS_ADMIN))
+		return -EPERM;
+
+	if (sb_rdonly(fs_info->sb))
+		return -EROFS;
+
+	ret =3D kstrtoul(buf, 10, &val);
+	if (ret)
+		return ret;
+
+	if (val =3D=3D 0)
+		return -EINVAL;
+
+	/*
+	 * Allocate new chunk.
+	 */
+	trans =3D btrfs_start_transaction(fs_info->extent_root, 0);
+	if (!trans)
+		return PTR_ERR(trans);
+	ret =3D btrfs_force_chunk_alloc(trans, space_info->flags);
+	btrfs_end_transaction(trans);
+
+	if (ret =3D=3D 1)
+		return len;
+
+	return -ENOSPC;
+}
+#endif
+
 SPACE_INFO_ATTR(flags);
 SPACE_INFO_ATTR(total_bytes);
 SPACE_INFO_ATTR(bytes_used);
@@ -797,6 +849,9 @@ SPACE_INFO_ATTR(disk_used);
 SPACE_INFO_ATTR(disk_total);
 BTRFS_ATTR_RW(space_info, chunk_size, btrfs_chunk_size_show,
 	      btrfs_chunk_size_store);
+#ifdef CONFIG_BTRFS_DEBUG
+BTRFS_ATTR_W(space_info, force_chunk_alloc, btrfs_force_chunk_alloc_stor=
e);
+#endif
=20
 /*
  * Allocation information about block group types.
@@ -815,6 +870,9 @@ static struct attribute *space_info_attrs[] =3D {
 	BTRFS_ATTR_PTR(space_info, disk_used),
 	BTRFS_ATTR_PTR(space_info, disk_total),
 	BTRFS_ATTR_PTR(space_info, chunk_size),
+#ifdef CONFIG_BTRFS_DEBUG
+	BTRFS_ATTR_PTR(space_info, force_chunk_alloc),
+#endif
 	NULL,
 };
 ATTRIBUTE_GROUPS(space_info);
--=20
2.30.2

