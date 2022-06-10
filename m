Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54F4F546EDD
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Jun 2022 22:55:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350759AbiFJUzg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 10 Jun 2022 16:55:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350751AbiFJUzc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 10 Jun 2022 16:55:32 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59493483AD
        for <linux-btrfs@vger.kernel.org>; Fri, 10 Jun 2022 13:55:26 -0700 (PDT)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25AHiCZ5023658
        for <linux-btrfs@vger.kernel.org>; Fri, 10 Jun 2022 13:55:26 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : subject :
 date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=ZZHaCXj+hqBcu0oCoUKtIosYtcm+O84rPyychBRuwFM=;
 b=nbEW2kB4t2Z6vWt0zPe672LnCSyrw301aiIu+b01vhCpegcqyR8AaeEMmg2CQoFtvKJM
 qaiMuI1QIvy92J4u86rmMHLvDOFIF8bHFaxZOJxyI5nyYjSIa8BUcioPCvbYliprSto8
 enumngEHcJMloEvjYu2nd9q3L3QoqWfQTWk= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3gmam8s6n8-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-btrfs@vger.kernel.org>; Fri, 10 Jun 2022 13:55:26 -0700
Received: from twshared5131.09.ash9.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Fri, 10 Jun 2022 13:55:25 -0700
Received: by devvm7778.ftw0.facebook.com (Postfix, from userid 558217)
        id E03E4D39540; Fri, 10 Jun 2022 13:55:22 -0700 (PDT)
From:   Ioannis Angelakopoulos <iangelak@fb.com>
To:     <linux-btrfs@vger.kernel.org>, <kernel-team@fb.com>
Subject: [PATCH 2/2] btrfs: Expose the BTRFS commit stats through sysfs
Date:   Fri, 10 Jun 2022 13:54:09 -0700
Message-ID: <20220610205406.301397-3-iangelak@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220610205406.301397-1-iangelak@fb.com>
References: <20220610205406.301397-1-iangelak@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: G9vyu-BdqotXKwdBmN5BaWYmAo2-iKKG
X-Proofpoint-ORIG-GUID: G9vyu-BdqotXKwdBmN5BaWYmAo2-iKKG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-10_08,2022-06-09_02,2022-02-23_01
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Create a new sysfs entry named "commit_stats" for each mounted BTRFS
filesystem. The entry exposes: 1) The number of commits so far, 2) The
duration of the last commit in ms, 3) The maximum commit duration seen
so far in ms and 4) The total duration for all commits so far in ms.

The function "btrfs_commit_stats_show" is responsible for exposing the
stats to user space.

The function "btrfs_commit_stats_store" is responsible for resetting the
above values to zero.

Signed-off-by: Ioannis Angelakopoulos <iangelak@fb.com>
---
 fs/btrfs/sysfs.c | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index b6cb5551050e..f68fc73006c0 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -991,6 +991,53 @@ static ssize_t btrfs_sectorsize_show(struct kobject =
*kobj,
=20
 BTRFS_ATTR(, sectorsize, btrfs_sectorsize_show);
=20
+static ssize_t btrfs_commit_stats_show(struct kobject *kobj,
+				struct kobj_attribute *a, char *buf)
+{
+	struct btrfs_fs_info *fs_info =3D to_fs_info(kobj);
+
+	/*
+	 * Expose the commits so far, the duration of the last commit, the
+	 * maximum duration of a commit so far and the total duration of
+	 * all the commits so far
+	 */
+	return sysfs_emit(buf, "Commits: %llu, Last: %llu ms, Max: %llu ms, Tot=
al: %llu ms\n",
+					  fs_info->commit_stats->commit_counter,
+					  fs_info->commit_stats->last_commit_dur,
+					  fs_info->commit_stats->max_commit_dur,
+					  fs_info->commit_stats->total_commit_dur);
+}
+
+static ssize_t btrfs_commit_stats_store(struct kobject *kobj,
+						struct kobj_attribute *a,
+						const char *buf, size_t len)
+{
+	struct btrfs_fs_info *fs_info =3D to_fs_info(kobj);
+
+	if (!fs_info)
+		return -EPERM;
+
+	if (!capable(CAP_SYS_RESOURCE))
+		return -EPERM;
+
+	/*
+	 * Just reset everything
+	 * Also take the trans_lock to avoid race conditions with the udpates
+	 * in btrfs_commit_transaction()
+	 */
+	spin_lock(&fs_info->trans_lock);
+	fs_info->commit_stats->commit_counter =3D 0;
+	fs_info->commit_stats->last_commit_dur =3D 0;
+	fs_info->commit_stats->max_commit_dur =3D 0;
+	fs_info->commit_stats->total_commit_dur =3D 0;
+	spin_unlock(&fs_info->trans_lock);
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
@@ -1230,6 +1277,7 @@ static const struct attribute *btrfs_attrs[] =3D {
 	BTRFS_ATTR_PTR(, generation),
 	BTRFS_ATTR_PTR(, read_policy),
 	BTRFS_ATTR_PTR(, bg_reclaim_threshold),
+	BTRFS_ATTR_PTR(, commit_stats),
 	NULL,
 };
=20
--=20
2.30.2

