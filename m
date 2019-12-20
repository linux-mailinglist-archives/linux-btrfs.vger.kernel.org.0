Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 16EA11274DF
	for <lists+linux-btrfs@lfdr.de>; Fri, 20 Dec 2019 06:06:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725825AbfLTFGY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 20 Dec 2019 00:06:24 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:56504 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725267AbfLTFGX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 20 Dec 2019 00:06:23 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xBK546II119305
        for <linux-btrfs@vger.kernel.org>; Fri, 20 Dec 2019 05:06:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references; s=corp-2019-08-05;
 bh=/JPLWuI+38a8cVE7zm62SDO9feuXCnmmXGVFlUcy1Pk=;
 b=V+/izr9bHiocNrjrOy1LZSkOha3nDoTl+alznjsg4XE4ea5t0hcVuiU2LM9SjLWZf70J
 QnFgeuq9OJ31/3XkVLITkHqMFO6J3r1N2fTIPZAuT/CqdQERgKqo0qgleUx3jtFS7T96
 Z2EROQnB7g+kYOAg65KrEmVQeiUiT8jm2bu8sbG8oW5PihTgRHyntlDceb7J0EzDe7Ix
 UnYKc2xyFaQCGzNdjdVRZcqgJ7vaFcORpXGDBgnjjhK5dZbo9NEAmWA5pCUIjGjCdKJx
 B5miRLccOd7vd/m+T+c6X7t4szGEgMqXI53/XL319OjBykH80L1SHdL+WZNR/bdrI/6P 6w== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 2x01jaengp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Fri, 20 Dec 2019 05:06:22 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xBK54IRg121441
        for <linux-btrfs@vger.kernel.org>; Fri, 20 Dec 2019 05:06:21 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 2x0bgmxu32-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Fri, 20 Dec 2019 05:06:21 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id xBK56Kpq009118
        for <linux-btrfs@vger.kernel.org>; Fri, 20 Dec 2019 05:06:20 GMT
Received: from tp.wifi.oracle.com (/192.188.170.104)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 19 Dec 2019 21:06:19 -0800
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 1/3] btrfs: add readmirror type framework
Date:   Fri, 20 Dec 2019 13:06:03 +0800
Message-Id: <1576818365-20286-2-git-send-email-anand.jain@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1576818365-20286-1-git-send-email-anand.jain@oracle.com>
References: <1576818365-20286-1-git-send-email-anand.jain@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9476 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=1 classifier=spam adjust=0 reason=mlx scancount=1
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

As of now we use %pid method to read stripped mirrored data. So
application's process id determines the stripe id to be read. This type
of routing typically helps in a system with many small independent
applications tying to read random data. On the other hand the %pid
based read IO distribution policy is inefficient if there is a single
application trying to read large data and the overall disk bandwidth
remains under utilized.

So this patch introduces a framework where we could add more readmirror
policies, such as routing the IO based on device's waitqueue or manual
when we have a read-preferred device or a policy based on the target
storage caching.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 fs/btrfs/volumes.c | 16 +++++++++++++++-
 fs/btrfs/volumes.h |  8 ++++++++
 2 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index c95e47aa84f8..0c6caae29248 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -1162,6 +1162,8 @@ static int open_fs_devices(struct btrfs_fs_devices *fs_devices,
 	fs_devices->opened = 1;
 	fs_devices->latest_bdev = latest_dev->bdev;
 	fs_devices->total_rw_bytes = 0;
+	/* Set the default readmirror policy */
+	atomic_set(&fs_devices->readmirror, BTRFS_READMIRROR_DEFAULT);
 out:
 	return ret;
 }
@@ -5300,7 +5302,19 @@ static int find_live_mirror(struct btrfs_fs_info *fs_info,
 	else
 		num_stripes = map->num_stripes;
 
-	preferred_mirror = first + current->pid % num_stripes;
+	switch (atomic_read(&fs_info->fs_devices->readmirror)) {
+	case BTRFS_READMIRROR_BY_PID:
+		preferred_mirror = first + current->pid % num_stripes;
+		break;
+	default:
+		/*
+		 * Shouln't happen, just warn and use default instead of failing.
+		 */
+		btrfs_warn_rl(fs_info,
+			      "unknown readmirror type %u, fallback to by_pid",
+			      atomic_read(&fs_info->fs_devices->readmirror));
+		preferred_mirror = first + current->pid % num_stripes;
+	}
 
 	if (dev_replace_is_ongoing &&
 	    fs_info->dev_replace.cont_reading_from_srcdev_mode ==
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index 68021d1ee216..d9c4c4e1dbc2 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -209,6 +209,12 @@ struct btrfs_device {
 BTRFS_DEVICE_GETSET_FUNCS(disk_total_bytes);
 BTRFS_DEVICE_GETSET_FUNCS(bytes_used);
 
+/* readmirror_policy types */
+#define BTRFS_READMIRROR_DEFAULT	BTRFS_READMIRROR_BY_PID
+enum btrfs_readmirror_policy_type {
+	BTRFS_READMIRROR_BY_PID,
+};
+
 struct btrfs_fs_devices {
 	u8 fsid[BTRFS_FSID_SIZE]; /* FS specific uuid */
 	u8 metadata_uuid[BTRFS_FSID_SIZE];
@@ -260,6 +266,8 @@ struct btrfs_fs_devices {
 	struct kobject *devices_kobj;
 	struct kobject *devinfo_kobj;
 	struct completion kobj_unregister;
+
+	atomic_t readmirror;
 };
 
 #define BTRFS_BIO_INLINE_CSUM_SIZE	64
-- 
1.8.3.1

