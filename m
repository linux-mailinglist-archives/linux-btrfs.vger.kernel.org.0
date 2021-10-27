Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9220343D2AD
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Oct 2021 22:16:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239054AbhJ0US5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 27 Oct 2021 16:18:57 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:24116 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239063AbhJ0US5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 27 Oct 2021 16:18:57 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19RK0WFs018920
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Oct 2021 13:16:31 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=retz7ctSqjwDZYaee7kV+1IVyjp0YxhL9VZn1qK87H0=;
 b=Z8U0DVwkovCHFv+lPeNFfpaPNjg1fDKgmhRDZQWfHUYHMsFwNJopf2pVCj9j8TUfyukO
 w2CGHzoHb+W15et5hzlyKaWnQoWd2uFfaR5FhiXqh7fdWmENGRi5MVQ5KPgOQ+hPDuWF
 /IRNw1KXg7EqZuM+aAWjW2pRDHfpnh3PMIo= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3by64s5na1-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Oct 2021 13:16:30 -0700
Received: from intmgw001.38.frc1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Wed, 27 Oct 2021 13:14:54 -0700
Received: by devvm225.atn0.facebook.com (Postfix, from userid 425415)
        id 2349E5A487CB; Wed, 27 Oct 2021 13:14:44 -0700 (PDT)
From:   Stefan Roesch <shr@fb.com>
To:     <linux-btrfs@vger.kernel.org>, <kernel-team@fb.com>
CC:     <shr@fb.com>
Subject: [PATCH v2 3/4] btrfs: add force_chunk_alloc sysfs entry to force allocation
Date:   Wed, 27 Oct 2021 13:14:40 -0700
Message-ID: <20211027201441.3813178-4-shr@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211027201441.3813178-1-shr@fb.com>
References: <20211027201441.3813178-1-shr@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-ORIG-GUID: njNAk8ZYLwxViD55DO1B-_ImGM7dhv41
X-Proofpoint-GUID: njNAk8ZYLwxViD55DO1B-_ImGM7dhv41
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-27_06,2021-10-26_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 impostorscore=0 phishscore=0 mlxlogscore=999 mlxscore=0 lowpriorityscore=0
 malwarescore=0 spamscore=0 suspectscore=0 clxscore=1015 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2110270115
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This adds the force_chunk_alloc sysfs entry to be able to force a
storage allocation. This is a debugging and test feature and is
enabled with the CONFIG_BTRFS_DEBUG configuration option.

It is stored at
/sys/fs/btrfs/<uuid>/allocation/<block_type>/force_chunk_alloc.

Signed-off-by: Stefan Roesch <shr@fb.com>
---
 fs/btrfs/sysfs.c | 65 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index bdfcd3d42bc4..7c701931540c 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -772,6 +772,64 @@ static ssize_t btrfs_stripe_size_store(struct kobjec=
t *kobj,
 	return val;
 }
=20
+#ifdef CONFIG_BTRFS_DEBUG
+/*
+ * Return if space info force allocation chunk flag is set.
+ */
+static ssize_t btrfs_force_chunk_alloc_show(struct kobject *kobj,
+					    struct kobj_attribute *a,
+					    char *buf)
+{
+	return snprintf(buf, PAGE_SIZE, "0\n");
+}
+
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
@@ -784,6 +842,10 @@ SPACE_INFO_ATTR(disk_used);
 SPACE_INFO_ATTR(disk_total);
 BTRFS_ATTR_RW(space_info, stripe_size, btrfs_stripe_size_show,
 	      btrfs_stripe_size_store);
+#ifdef CONFIG_BTRFS_DEBUG
+BTRFS_ATTR_RW(space_info, force_chunk_alloc, btrfs_force_chunk_alloc_sho=
w,
+	      btrfs_force_chunk_alloc_store);
+#endif
=20
 /*
  * Allocation information about block group types.
@@ -802,6 +864,9 @@ static struct attribute *space_info_attrs[] =3D {
 	BTRFS_ATTR_PTR(space_info, disk_used),
 	BTRFS_ATTR_PTR(space_info, disk_total),
 	BTRFS_ATTR_PTR(space_info, stripe_size),
+#ifdef CONFIG_BTRFS_DEBUG
+	BTRFS_ATTR_PTR(space_info, force_chunk_alloc),
+#endif
 	NULL,
 };
 ATTRIBUTE_GROUPS(space_info);
--=20
2.30.2

