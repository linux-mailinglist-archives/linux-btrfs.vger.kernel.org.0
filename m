Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6DACC1274E1
	for <lists+linux-btrfs@lfdr.de>; Fri, 20 Dec 2019 06:06:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725919AbfLTFGd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 20 Dec 2019 00:06:33 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:57976 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725267AbfLTFGd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 20 Dec 2019 00:06:33 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xBK53ti7102105
        for <linux-btrfs@vger.kernel.org>; Fri, 20 Dec 2019 05:06:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references; s=corp-2019-08-05;
 bh=9MyQERM+bXMho0njgx82bg41YtGpXA/o8Grm+feYmNA=;
 b=dipDi9ylUw7JBPl3sfaLQWgqBA3AK8ktJg0lGRopI/cS4xe8bq/jc1Y/hiyoIGX3306g
 fOs3eKXyk1/mp9GY0kTysAw/GJh8+Hh3RQLkV0tiH8UCDjhghk+6X1fMadVBwZawipy1
 bB28+RRL4MH+lEQudD/MZOLAKKV7kPEACSIjllnVFpEHNjqujVGWBsx35jEO6yQGOV2B
 4T1y7hW2pQxYdt52XLgyAfXVwYPeamB8gWl5zmX0ePNz+4CB5l94hNDR2BjtG8f+pC9W
 NYiraj67U3hpqWLvgcKbYXDDJype3+JIyXTnhHKH0xVBNG4L5j+xJ2n8uCNxw+LYdlz4 QA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 2x01knpp4b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Fri, 20 Dec 2019 05:06:31 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xBK53tBY075934
        for <linux-btrfs@vger.kernel.org>; Fri, 20 Dec 2019 05:06:31 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 2x0pcbawu6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Fri, 20 Dec 2019 05:06:30 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id xBK56T2f009222
        for <linux-btrfs@vger.kernel.org>; Fri, 20 Dec 2019 05:06:29 GMT
Received: from tp.wifi.oracle.com (/192.188.170.104)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 19 Dec 2019 21:06:29 -0800
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 3/3] btrfs: sysfs, create by_pid readmirror attribute
Date:   Fri, 20 Dec 2019 13:06:05 +0800
Message-Id: <1576818365-20286-4-git-send-email-anand.jain@oracle.com>
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

Add the exisiting %pid based readmirror policy as an attribute

 /sys/fs/btrfs/UUID/readmirror/by_pid

When read, this returns 0 or 1. 1 indicates the currently active policy.
When written with 1, it sets pid as the current active policy and when
written 0 it resets to the default readmirror policy which as of now is
pid as well. For any other value it returns EINVAL.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 fs/btrfs/sysfs.c | 54 +++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 53 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index da5e1938e9b9..5a09cf868328 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -355,7 +355,59 @@ static ssize_t supported_checksums_show(struct kobject *kobj,
 
 #endif
 
+#define readmirror_to_fs_devices(_kobj)	to_fs_devs((_kobj)->parent)
+/*
+ * Set the readmirror type to BTRFS_READMIRROR_BY_PID
+ */
+static ssize_t btrfs_sysfs_readmirror_by_pid_store(struct kobject *kobj,
+						   struct kobj_attribute *a,
+						   const char *buf, size_t count)
+{
+	int ret;
+	unsigned long val;
+	struct btrfs_fs_devices *fs_devices;
+
+	fs_devices = readmirror_to_fs_devices(kobj);
+
+	ret = kstrtoul(skip_spaces(buf), 0, &val);
+	if (ret)
+		return ret;
+
+	switch (val) {
+	case 0:
+		atomic_set(&fs_devices->readmirror, BTRFS_READMIRROR_DEFAULT);
+		break;
+	case 1:
+		atomic_set(&fs_devices->readmirror, BTRFS_READMIRROR_BY_PID);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return count;
+}
+
+static ssize_t btrfs_sysfs_readmirror_by_pid_show(struct kobject *kobj,
+						  struct kobj_attribute *a,
+						  char *buf)
+{
+	int val;
+	struct btrfs_fs_devices *fs_devices;
+
+	fs_devices = readmirror_to_fs_devices(kobj);
+
+	if (atomic_read(&fs_devices->readmirror) == BTRFS_READMIRROR_BY_PID)
+		val = 1;
+	else
+		val = 0;
+
+	return snprintf(buf, PAGE_SIZE, "%d\n", val);
+}
+BTRFS_ATTR_RW(readmirror, by_pid, btrfs_sysfs_readmirror_by_pid_show,
+	      btrfs_sysfs_readmirror_by_pid_store);
+
 static const struct attribute *btrfs_readmirror_attrs[] = {
+	BTRFS_ATTR_PTR(readmirror, by_pid),
 	NULL,
 };
 
@@ -1241,7 +1293,7 @@ int btrfs_sysfs_add_mounted(struct btrfs_fs_info *fs_info)
 		error = -ENOMEM;
 		goto failure;
 	}
-	error = sysfs_create_files(fs_info->readmirror_kobj,
+	error = sysfs_create_files(fs_devs->readmirror_kobj,
 				   btrfs_readmirror_attrs);
 	if (error)
 		goto failure;
-- 
1.8.3.1

