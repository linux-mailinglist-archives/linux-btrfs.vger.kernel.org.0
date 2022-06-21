Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D9AC553ED4
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Jun 2022 01:01:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354829AbiFUXBV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 Jun 2022 19:01:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354570AbiFUXBU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 Jun 2022 19:01:20 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86A5D2F659
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Jun 2022 16:01:19 -0700 (PDT)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25LMWWYA017376
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Jun 2022 16:01:19 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : subject :
 date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=yfxegV7gQj38gHtWOgm3aWD+JnBd5q5vChJIlMe7ekQ=;
 b=i4GQBiebre8vR/4GX4JgC+tXL3GYrIuXTnrOqzLqZGfN3PH51JlqT0vbuq6Sg3AO81Ug
 IPpJIj7wCe0t7W4FqCvmuZzfKnSoiRmJpNhh76vi25I92ItbSn30YPVhoX/U3w5P/9rb
 LrFqY+qBt0hwmMysRd6WBeVuCKJgVEqYeu0= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3gueeh46x5-9
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Jun 2022 16:01:19 -0700
Received: from snc-exhub201.TheFacebook.com (2620:10d:c085:21d::7) by
 snc-exhub101.TheFacebook.com (2620:10d:c085:11d::5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Tue, 21 Jun 2022 16:01:15 -0700
Received: from twshared5413.23.frc3.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:21d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Tue, 21 Jun 2022 16:01:13 -0700
Received: by devvm7778.ftw0.facebook.com (Postfix, from userid 558217)
        id 36D4F139CA87; Tue, 21 Jun 2022 16:01:04 -0700 (PDT)
From:   Ioannis Angelakopoulos <iangelak@fb.com>
To:     <linux-btrfs@vger.kernel.org>, <kernel-team@fb.com>
Subject: [PATCH v4 2/2] btrfs: Expose the commit stats through sysfs
Date:   Tue, 21 Jun 2022 15:59:21 -0700
Message-ID: <20220621225918.4114998-3-iangelak@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220621225918.4114998-1-iangelak@fb.com>
References: <20220621225918.4114998-1-iangelak@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: Y70b5Qd1IhAp5Apagqk4GyCkqTCjuUOM
X-Proofpoint-ORIG-GUID: Y70b5Qd1IhAp5Apagqk4GyCkqTCjuUOM
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
for each mounted btrfs filesystem. The entry exposes: 1) The number of
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
index db3736de14a5..c17e29f2f004 100644
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
+		div_u64(fs_info->commit_stats.last_commit_dur, NSEC_PER_MSEC),
+		div_u64(fs_info->commit_stats.max_commit_dur, NSEC_PER_MSEC),
+		div_u64(fs_info->commit_stats.total_commit_dur, NSEC_PER_MSEC));
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

