Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95681553E34
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Jun 2022 23:55:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355944AbiFUVzP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 Jun 2022 17:55:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354456AbiFUVzM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 Jun 2022 17:55:12 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A82F1E3CD
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Jun 2022 14:55:11 -0700 (PDT)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25LHIJ5P031383
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Jun 2022 14:55:10 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : subject :
 date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=a7WyxUWm80fDmSJEiTAGrWhV8PlbMMJxLrFGY39Lf0g=;
 b=bEqxr6a9lWxzcxEUZjdfIoYo57WA5hmu9oxOhnBNlrlKgJDEGMBDEBLPMQZvlKDwjeK1
 XPQOv8euL8XrTcvHLnPw6jFblnR/PbKVGBdBi9LZMA09T6jXr32GSXD4g5Q+meFRGD+T
 fZx8lOnWn8jwGSo6PqJQCXUL1nR/94rxT2o= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3guef4ksma-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Jun 2022 14:55:10 -0700
Received: from twshared5413.23.frc3.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::d) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Tue, 21 Jun 2022 14:55:08 -0700
Received: by devvm7778.ftw0.facebook.com (Postfix, from userid 558217)
        id A31D4137C7AE; Tue, 21 Jun 2022 14:55:04 -0700 (PDT)
From:   Ioannis Angelakopoulos <iangelak@fb.com>
To:     <linux-btrfs@vger.kernel.org>, <kernel-team@fb.com>
Subject: [PATCH v3 2/2] btrfs: Expose the BTRFS commit stats through sysfs
Date:   Tue, 21 Jun 2022 14:52:48 -0700
Message-ID: <20220621215245.3603198-3-iangelak@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220621215245.3603198-1-iangelak@fb.com>
References: <20220621215245.3603198-1-iangelak@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: 4G7U1c7idKuhWs3KpH3umhsBXKfE-wC_
X-Proofpoint-ORIG-GUID: 4G7U1c7idKuhWs3KpH3umhsBXKfE-wC_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-21_09,2022-06-21_01,2022-02-23_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Create a new sysfs entry named "commit_stats" under /sys/fs/btrfs/<UUID>/
for each mounted BTRFS filesystem. The entry exposes: 1) The number of
commits so far, 2) The duration of the last commit in ms, 3) The maximum
commit duration seen so far in ms and 4) The total duration for all commi=
ts
so far in ms.

The function "btrfs_commit_stats_show" in fs/btrfs/sysfs.c is responsible
for exposing the stats to user space.

The function "btrfs_commit_stats_store" in fs/btrfs/sysfs.c is responsibl=
e
for resetting the maximum commit duration to zero. This benefits
applications that want to sample the maximum commit duration over a long
time period. Only the maximum commit duration is reset to zero in order t=
o
avoid loss of data if multiple threads are trying to reset the commit sta=
ts
data at the same time.

Signed-off-by: Ioannis Angelakopoulos <iangelak@fb.com>
---
 fs/btrfs/sysfs.c | 45 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index db3736de14a5..0e13daa1a466 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -10,6 +10,7 @@
 #include <linux/completion.h>
 #include <linux/bug.h>
 #include <crypto/hash.h>
+#include <linux/math64.h>
=20
 #include "ctree.h"
 #include "discard.h"
@@ -991,6 +992,49 @@ static ssize_t btrfs_sectorsize_show(struct kobject =
*kobj,
=20
 BTRFS_ATTR(, sectorsize, btrfs_sectorsize_show);
=20
+static ssize_t btrfs_commit_stats_show(struct kobject *kobj,
+				struct kobj_attribute *a, char *buf)
+{
+	struct btrfs_fs_info *fs_info =3D to_fs_info(kobj);
+
+	return sysfs_emit(buf,
+		"commits %llu\n"
+		"last_commit_dur_ms %llu\n"
+		"max_commit_dur_ms %llu\n"
+		"total_commit_dur_ms %llu\n",
+		fs_info->commit_stats.commit_counter,
+		div_u64(fs_info->commit_stats.last_commit_dur / NSEC_PER_MSEC),
+		div_u64(fs_info->commit_stats.max_commit_dur / NSEC_PER_MSEC),
+		div_u64(fs_info->commit_stats.total_commit_dur / NSEC_PER_MSEC));
+}
+
+static ssize_t btrfs_commit_stats_store(struct kobject *kobj,
+						struct kobj_attribute *a,
+						const char *buf, size_t len)
+{
+	struct btrfs_fs_info *fs_info =3D to_fs_info(kobj);
+	unsigned long val;
+	int ret;
+
+	if (!fs_info)
+		return -EPERM;
+
+	if (!capable(CAP_SYS_RESOURCE))
+		return -EPERM;
+
+	ret =3D kstrtoul(buf, 10, &val);
+	if (ret)
+		return ret;
+	if (val)
+		return -EINVAL;
+
+	fs_info->commit_stats.max_commit_dur =3D 0;
+
+	return len;
+}
+BTRFS_ATTR_RW(, commit_stats, btrfs_commit_stats_show,
+			  btrfs_commit_stats_store);
+
 static ssize_t btrfs_clone_alignment_show(struct kobject *kobj,
 				struct kobj_attribute *a, char *buf)
 {
@@ -1230,6 +1274,7 @@ static const struct attribute *btrfs_attrs[] =3D {
 	BTRFS_ATTR_PTR(, generation),
 	BTRFS_ATTR_PTR(, read_policy),
 	BTRFS_ATTR_PTR(, bg_reclaim_threshold),
+	BTRFS_ATTR_PTR(, commit_stats),
 	NULL,
 };
=20
--=20
2.30.2

