Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B5A74401DD
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Oct 2021 20:28:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230168AbhJ2SbD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 29 Oct 2021 14:31:03 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:32114 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230022AbhJ2SbA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 29 Oct 2021 14:31:00 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.1.2/8.16.1.2) with SMTP id 19THwT0d003926
        for <linux-btrfs@vger.kernel.org>; Fri, 29 Oct 2021 11:28:31 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=rsL5NlHP8KxKUy5s4fmzSbQhrgL5xu9r+MiCXbOhROQ=;
 b=oz3if4gtfC2+bgyv93uG8NWG8lxJpUJvTBNAwNeJiI4HJ3poOi8xFE03F0R+DNMS27wv
 mIGhuQPAsNy+DVvj3m0XK0UR+c76k6seeVvlzZ1b6TeY90AYw0TjSH22Uo2cE5xFGxJf
 2+Ko9vDSnszac7WEPw8xJ2S7/SPwoyHmi4s= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0001303.ppops.net with ESMTP id 3c0b94np5b-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-btrfs@vger.kernel.org>; Fri, 29 Oct 2021 11:28:31 -0700
Received: from intmgw001.05.ash7.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Fri, 29 Oct 2021 11:28:18 -0700
Received: by devvm225.atn0.facebook.com (Postfix, from userid 425415)
        id EC7D45BCB640; Fri, 29 Oct 2021 11:28:15 -0700 (PDT)
From:   Stefan Roesch <shr@fb.com>
To:     <linux-btrfs@vger.kernel.org>, <kernel-team@fb.com>
CC:     <shr@fb.com>
Subject: [PATCH v3 3/4] btrfs: add force_chunk_alloc sysfs entry to force allocation
Date:   Fri, 29 Oct 2021 11:28:11 -0700
Message-ID: <20211029182812.3560677-6-shr@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211029182812.3560677-1-shr@fb.com>
References: <20211029182812.3560677-1-shr@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-GUID: xfyEsRF4t5uOSsxUIPR0hd5KfsfFsVQT
X-Proofpoint-ORIG-GUID: xfyEsRF4t5uOSsxUIPR0hd5KfsfFsVQT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-29_04,2021-10-29_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0 suspectscore=0
 priorityscore=1501 mlxlogscore=999 phishscore=0 bulkscore=0 clxscore=1015
 spamscore=0 impostorscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2110290100
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
 fs/btrfs/sysfs.c | 65 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index 3b0bcbc2ed2e..983c53b76aa6 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -771,6 +771,64 @@ static ssize_t btrfs_chunk_size_store(struct kobject=
 *kobj,
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
@@ -783,6 +841,10 @@ SPACE_INFO_ATTR(disk_used);
 SPACE_INFO_ATTR(disk_total);
 BTRFS_ATTR_RW(space_info, chunk_size, btrfs_chunk_size_show,
 	      btrfs_chunk_size_store);
+#ifdef CONFIG_BTRFS_DEBUG
+BTRFS_ATTR_RW(space_info, force_chunk_alloc, btrfs_force_chunk_alloc_sho=
w,
+	      btrfs_force_chunk_alloc_store);
+#endif
=20
 /*
  * Allocation information about block group types.
@@ -801,6 +863,9 @@ static struct attribute *space_info_attrs[] =3D {
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

