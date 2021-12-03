Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 690B1467FA5
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Dec 2021 23:04:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383314AbhLCWIP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 3 Dec 2021 17:08:15 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:31702 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1383281AbhLCWIO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 3 Dec 2021 17:08:14 -0500
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B3L6K0Q004808
        for <linux-btrfs@vger.kernel.org>; Fri, 3 Dec 2021 14:04:49 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=+Dr8QQvaH6LkmaLjYYPH7DGkBNaSFM4yIgJfNTMoG78=;
 b=GVa9Ixuz9LNfAXe+jsl+PRVQETwYGR5D9PGPMQPKir8lswxCiHzLmlCqoMKnQrLLDHG3
 FlNKnsPGecRk4knmCG0OpVQepGgrOVsukWc7qtVdh2s14GIOaBsJ1mBilo85bwQxActw
 evV+FocdJHnEBOJ5ed6nilc1HS7Syq4SJYk= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3cqsp08u11-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-btrfs@vger.kernel.org>; Fri, 03 Dec 2021 14:04:49 -0800
Received: from intmgw001.37.frc1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 3 Dec 2021 14:04:48 -0800
Received: by devvm225.atn0.facebook.com (Postfix, from userid 425415)
        id 3705976B31D7; Fri,  3 Dec 2021 14:04:47 -0800 (PST)
From:   Stefan Roesch <shr@fb.com>
To:     <linux-btrfs@vger.kernel.org>, <kernel-team@fb.com>
CC:     <shr@fb.com>
Subject: [PATCH v6 3/4] btrfs: add force_chunk_alloc sysfs entry to force allocation
Date:   Fri, 3 Dec 2021 14:04:44 -0800
Message-ID: <20211203220445.2312182-4-shr@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211203220445.2312182-1-shr@fb.com>
References: <20211203220445.2312182-1-shr@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-GUID: ZWYjwTT6z7AEMzhqz3aQb4jI0T6pcywK
X-Proofpoint-ORIG-GUID: ZWYjwTT6z7AEMzhqz3aQb4jI0T6pcywK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-03_11,2021-12-02_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxlogscore=994
 bulkscore=0 adultscore=0 spamscore=0 phishscore=0 malwarescore=0
 priorityscore=1501 mlxscore=0 clxscore=1015 impostorscore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112030142
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
index 39890ea21997..a421a95dea93 100644
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
+	trans =3D btrfs_start_transaction(fs_info->tree_root, 0);
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

