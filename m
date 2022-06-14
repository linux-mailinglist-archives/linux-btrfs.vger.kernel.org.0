Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96AE754BD98
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Jun 2022 00:24:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242406AbiFNWYS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 14 Jun 2022 18:24:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233939AbiFNWYR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 14 Jun 2022 18:24:17 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF58F4ECDB
        for <linux-btrfs@vger.kernel.org>; Tue, 14 Jun 2022 15:24:16 -0700 (PDT)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25EM2jEc014343
        for <linux-btrfs@vger.kernel.org>; Tue, 14 Jun 2022 15:24:16 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : subject :
 date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=KjKYJuCs6/j8VgEWoWVg0CEECSofd8WFtlYEfWAMVYk=;
 b=lFQ/ASWzKOkKeLv6MKeqh3DsH57PJ0tscvB/z6O8zEcpxO7VdqIQFHqYUCs68/tfZ0FB
 FpE224NoOUq1QXeMZKZIVGhSd1VjVepqkt3l/BOEzwmPTmaL1CipH43Knnq1Tn86SusY
 sVFQbUlYk8gLxycDaqDSD+IWukMeMpcgO+Y= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3gpqw24r1q-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-btrfs@vger.kernel.org>; Tue, 14 Jun 2022 15:24:16 -0700
Received: from twshared5131.09.ash9.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Tue, 14 Jun 2022 15:24:14 -0700
Received: by devvm7778.ftw0.facebook.com (Postfix, from userid 558217)
        id D217DF8C89F; Tue, 14 Jun 2022 15:24:04 -0700 (PDT)
From:   Ioannis Angelakopoulos <iangelak@fb.com>
To:     <linux-btrfs@vger.kernel.org>, <kernel-team@fb.com>
Subject: [PATCH v2 2/2] btrfs: Expose the BTRFS commit stats through sysfs
Date:   Tue, 14 Jun 2022 15:22:34 -0700
Message-ID: <20220614222231.2582876-3-iangelak@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220614222231.2582876-1-iangelak@fb.com>
References: <20220614222231.2582876-1-iangelak@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: joda6Fh7Od5_87XaxlatD9ab3jEyCsK4
X-Proofpoint-ORIG-GUID: joda6Fh7Od5_87XaxlatD9ab3jEyCsK4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-14_10,2022-06-13_01,2022-02-23_01
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
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
for resetting the above values to zero.

Signed-off-by: Ioannis Angelakopoulos <iangelak@fb.com>
---
 fs/btrfs/sysfs.c | 51 +++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 50 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index db3736de14a5..54b26aef290b 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -991,6 +991,55 @@ static ssize_t btrfs_sectorsize_show(struct kobject =
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
+		"last_commit_dur %llu ms\n"
+		"max_commit_dur %llu ms\n"
+		"total_commit_dur %llu ms\n",
+		fs_info->commit_stats.commit_counter,
+		fs_info->commit_stats.last_commit_dur / NSEC_PER_MSEC,
+		fs_info->commit_stats.max_commit_dur / NSEC_PER_MSEC,
+		fs_info->commit_stats.total_commit_dur / NSEC_PER_MSEC);
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
+	spin_lock(&fs_info->super_lock);
+	fs_info->commit_stats.commit_counter =3D 0;
+	fs_info->commit_stats.last_commit_dur =3D 0;
+	fs_info->commit_stats.max_commit_dur =3D 0;
+	fs_info->commit_stats.total_commit_dur =3D 0;
+	spin_unlock(&fs_info->super_lock);
+
+	return len;
+}
+
+BTRFS_ATTR_RW(, commit_stats, btrfs_commit_stats_show,
+			  btrfs_commit_stats_store);
+
 static ssize_t btrfs_clone_alignment_show(struct kobject *kobj,
 				struct kobj_attribute *a, char *buf)
 {
@@ -1230,6 +1279,7 @@ static const struct attribute *btrfs_attrs[] =3D {
 	BTRFS_ATTR_PTR(, generation),
 	BTRFS_ATTR_PTR(, read_policy),
 	BTRFS_ATTR_PTR(, bg_reclaim_threshold),
+	BTRFS_ATTR_PTR(, commit_stats),
 	NULL,
 };
=20
@@ -2236,4 +2286,3 @@ void __cold btrfs_exit_sysfs(void)
 #endif
 	kset_unregister(btrfs_kset);
 }
-
--=20
2.30.2

