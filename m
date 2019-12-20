Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A644B1274E0
	for <lists+linux-btrfs@lfdr.de>; Fri, 20 Dec 2019 06:06:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725903AbfLTFG1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 20 Dec 2019 00:06:27 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:57908 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725267AbfLTFG1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 20 Dec 2019 00:06:27 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xBK53u9p102144
        for <linux-btrfs@vger.kernel.org>; Fri, 20 Dec 2019 05:06:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references; s=corp-2019-08-05;
 bh=eJD90XkA0YuBoUlq4F/UrMu9Ry1HsslldlMMYlpNiJY=;
 b=RxR+buWPLIPMOPTbY3s1Ek6NQuO56jfXmgnQmAPqxZ/zIJddw5TUNxHFvyg5Oux0AXla
 s9FfOHro/1tl6tmFtottI7XcLnNiemKgKw5F9cn5IpO5nSM5EyM9QxpkE+/MxuUSwUW1
 hkQUEVgvM4AOPFX3+CFFtRvcDp33w3pjonDO8oPiNmS5L0+m+tDi1bMeaAS6FRAyuS2n
 rftkeoTe1/UbBxp4JEwdjw3X9kTeGTngW3BgGvkg9mAfx/rWLNJFJT8psDDXAhFCi8FR
 yQ7XJ0OEEzDbDv8523QjJA1stDVByrsFbTj0OlvvhCEZ7PrPjdnnoCsUVAKAGzWgTtJM AA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 2x01knpp41-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Fri, 20 Dec 2019 05:06:25 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xBK54If1121466
        for <linux-btrfs@vger.kernel.org>; Fri, 20 Dec 2019 05:06:24 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 2x0bgmxu4s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Fri, 20 Dec 2019 05:06:24 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id xBK56Okx009125
        for <linux-btrfs@vger.kernel.org>; Fri, 20 Dec 2019 05:06:24 GMT
Received: from tp.wifi.oracle.com (/192.188.170.104)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 19 Dec 2019 21:06:23 -0800
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 2/3] btrfs: sysfs, add readmirror kobject
Date:   Fri, 20 Dec 2019 13:06:04 +0800
Message-Id: <1576818365-20286-3-git-send-email-anand.jain@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1576818365-20286-1-git-send-email-anand.jain@oracle.com>
References: <1576818365-20286-1-git-send-email-anand.jain@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9476 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1912200038
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9476 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1912200038
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Add

 /sys/fs/btrfs/UUID/readmirror

kobject so that we can be the readmirror policies as attributes under it.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 fs/btrfs/sysfs.c   | 22 ++++++++++++++++++++++
 fs/btrfs/volumes.h |  1 +
 2 files changed, 23 insertions(+)

diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index d414b98fb27f..da5e1938e9b9 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -355,6 +355,10 @@ static ssize_t supported_checksums_show(struct kobject *kobj,
 
 #endif
 
+static const struct attribute *btrfs_readmirror_attrs[] = {
+	NULL,
+};
+
 static ssize_t btrfs_show_u64(u64 *value_ptr, spinlock_t *lock, char *buf)
 {
 	u64 val;
@@ -772,6 +776,13 @@ void btrfs_sysfs_remove_mounted(struct btrfs_fs_info *fs_info)
 {
 	btrfs_reset_fs_info_ptr(fs_info);
 
+	if (fs_info->fs_devices->readmirror_kobj) {
+		sysfs_remove_files(fs_info->fs_devices->readmirror_kobj,
+				   btrfs_readmirror_attrs);
+		kobject_del(fs_info->fs_devices->readmirror_kobj);
+		kobject_put(fs_info->fs_devices->readmirror_kobj);
+	}
+
 	if (fs_info->space_info_kobj) {
 		sysfs_remove_files(fs_info->space_info_kobj, allocation_attrs);
 		kobject_del(fs_info->space_info_kobj);
@@ -1224,6 +1235,17 @@ int btrfs_sysfs_add_mounted(struct btrfs_fs_info *fs_info)
 	if (error)
 		goto failure;
 
+	fs_devs->readmirror_kobj = kobject_create_and_add("readmirror",
+							  &fs_devs->fsid_kobj);
+	if (!fs_devs->readmirror_kobj) {
+		error = -ENOMEM;
+		goto failure;
+	}
+	error = sysfs_create_files(fs_info->readmirror_kobj,
+				   btrfs_readmirror_attrs);
+	if (error)
+		goto failure;
+
 	return 0;
 failure:
 	btrfs_sysfs_remove_mounted(fs_info);
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index d9c4c4e1dbc2..5a9fca16a8a6 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -268,6 +268,7 @@ struct btrfs_fs_devices {
 	struct completion kobj_unregister;
 
 	atomic_t readmirror;
+	struct kobject *readmirror_kobj;
 };
 
 #define BTRFS_BIO_INLINE_CSUM_SIZE	64
-- 
1.8.3.1

