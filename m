Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 248B012E4D8
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Jan 2020 11:13:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728034AbgABKNI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Jan 2020 05:13:08 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:41820 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728032AbgABKNH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Jan 2020 05:13:07 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 002AAx9f127352
        for <linux-btrfs@vger.kernel.org>; Thu, 2 Jan 2020 10:13:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references; s=corp-2019-08-05;
 bh=uy7UicLbvKh62MBn0T9yD/rOqRomaCvvSJALHrtEAfg=;
 b=fVQhSJK39yFg6eVxMr3c0sdnou5Rfvc2sd2Wr8evKPEeOjJMW7JXPky+BgeXwfyiekct
 UYzjp0WptIPjZ+ed5J/4rK2+JsEGNgbQjyMxruEBW7JlIwcSzlDPbIY+iLyzqPc0jf2r
 58qFNUFD0f8OB/TrP+XxXkv0JnmnpTk2pwUa6RndMKToX++KyFL8iVElzlWV++SyXMxO
 86DYi/EfACk3p8dwne8t5mDZO4epRqVn3sPDLlKimG0y6ch+SWHfRkuDIwL6RsP6uZCs
 QFWpPEciJBnsV6Ix6I6Z1ZYzMpoduBM2lMvzRQWTlWVu1KpSU8qy35duCZIahXX872LF 6A== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 2x5y0ppmbp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Thu, 02 Jan 2020 10:13:06 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 002A96sI019859
        for <linux-btrfs@vger.kernel.org>; Thu, 2 Jan 2020 10:13:05 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 2x8guq6m1n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Thu, 02 Jan 2020 10:13:05 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 002AD4Q0008235
        for <linux-btrfs@vger.kernel.org>; Thu, 2 Jan 2020 10:13:04 GMT
Received: from tp.localdomain (/39.109.145.141)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 02 Jan 2020 02:13:04 -0800
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 3/3] btrfs: sysfs, create by_pid readmirror attribute
Date:   Thu,  2 Jan 2020 18:12:48 +0800
Message-Id: <1577959968-19427-4-git-send-email-anand.jain@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1577959968-19427-1-git-send-email-anand.jain@oracle.com>
References: <1577959968-19427-1-git-send-email-anand.jain@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9487 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001020092
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9487 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001020092
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Add existing %pid based readmirror policy as an attribute

 /sys/fs/btrfs/UUID/readmirror/by_pid

When read, this returns 0 or 1. 1 indicates currently active policy.
When written with 1, it sets by_pid as the current active policy and
when written 0 it resets to the default readmirror policy, which as
of now is pid as well. For any other value returns EINVAL.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
v2: fs_devs::readmirror is no more atomic_t so update accordingly.

 fs/btrfs/sysfs.c | 52 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index e604f292b42b..123d1ef72059 100644
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
+		fs_devices->readmirror = BTRFS_READMIRROR_DEFAULT;
+		break;
+	case 1:
+		fs_devices->readmirror = BTRFS_READMIRROR_BY_PID;
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
+	if (fs_devices->readmirror == BTRFS_READMIRROR_BY_PID)
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
 
-- 
1.8.3.1

