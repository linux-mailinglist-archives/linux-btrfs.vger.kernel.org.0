Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0721112E4D6
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Jan 2020 11:13:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728027AbgABKNF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Jan 2020 05:13:05 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:42954 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727990AbgABKNE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Jan 2020 05:13:04 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 002AAmRH130466
        for <linux-btrfs@vger.kernel.org>; Thu, 2 Jan 2020 10:13:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references; s=corp-2019-08-05;
 bh=oPelsfMcCkuTCh8JkSFXa4mMalucJ8DwROMJiGbtGhY=;
 b=ENRgEjVEGMmkCxZPdmwGJsLew1pU7Rjd4qgtWifqTuWrrbLnYUCsT1TQ9wdTABsYiUeh
 buNi33jOKg4TNovk/7lmCiZ7yOQlWaJsWjJddgsFdgPdWNnQEKp0nLtyKDvRGZ00pEC4
 VkVVRAadrpsA3PH7j9VEZjaQOTKxGhosQ3bXmAz228nFY13t/+Vufu2VaaSV4BixeIcJ
 33wOJSYf1tEmfWc0zsVGs+O23c5TZa3OefSNyfmgO6wGdwOPdMsUIyAlr6dd+y0KSwWi
 knS2zcqmjk0nGHi8hFrE1PO7/PrnNIsy5/jRhGpLp5Sn+WcIbvd7bfFmbs7mOKirSn2B BQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 2x5ypqpk27-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Thu, 02 Jan 2020 10:13:03 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 002A9KOl090707
        for <linux-btrfs@vger.kernel.org>; Thu, 2 Jan 2020 10:13:02 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 2x8gjad5t7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Thu, 02 Jan 2020 10:13:02 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 002AD1me006577
        for <linux-btrfs@vger.kernel.org>; Thu, 2 Jan 2020 10:13:01 GMT
Received: from tp.localdomain (/39.109.145.141)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 02 Jan 2020 02:13:01 -0800
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 1/3] btrfs: add readmirror type framework
Date:   Thu,  2 Jan 2020 18:12:46 +0800
Message-Id: <1577959968-19427-2-git-send-email-anand.jain@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1577959968-19427-1-git-send-email-anand.jain@oracle.com>
References: <1577959968-19427-1-git-send-email-anand.jain@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9487 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=1 classifier=spam adjust=0 reason=mlx scancount=1
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

As of now we use %pid method to read stripped mirrored data. So
application's process id determines the stripe id to be read. This type
of read IO routing typically helps in a system with many small
independent applications tying to read random data. On the other hand
the %pid based read IO distribution policy is inefficient if there is a
single application trying to read large data and the overall disk
bandwidth remains under utilized.

So this patch introduces a framework where we could add more readmirror
policies, such as routing the IO based on device's wait-queue or manual
when we have a read-preferred device or a policy based on the target
storage caching.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
v2: Declare fs_devices::readmirror as u8 instead of atomic_t
    A small change in comment and change log wordings.

 fs/btrfs/volumes.c | 16 +++++++++++++++-
 fs/btrfs/volumes.h |  8 ++++++++
 2 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index c95e47aa84f8..e26af766f2b9 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -1162,6 +1162,8 @@ static int open_fs_devices(struct btrfs_fs_devices *fs_devices,
 	fs_devices->opened = 1;
 	fs_devices->latest_bdev = latest_dev->bdev;
 	fs_devices->total_rw_bytes = 0;
+	/* Set the default readmirror policy */
+	fs_devices->readmirror = BTRFS_READMIRROR_DEFAULT;
 out:
 	return ret;
 }
@@ -5300,7 +5302,19 @@ static int find_live_mirror(struct btrfs_fs_info *fs_info,
 	else
 		num_stripes = map->num_stripes;
 
-	preferred_mirror = first + current->pid % num_stripes;
+	switch (fs_info->fs_devices->readmirror) {
+	case BTRFS_READMIRROR_BY_PID:
+		preferred_mirror = first + current->pid % num_stripes;
+		break;
+	default:
+		/*
+		 * Shouln't happen, just warn and use by_pid instead of failing.
+		 */
+		btrfs_warn_rl(fs_info,
+			      "unknown readmirror type %u, fallback to by_pid",
+			      fs_info->fs_devices->readmirror);
+		preferred_mirror = first + current->pid % num_stripes;
+	}
 
 	if (dev_replace_is_ongoing &&
 	    fs_info->dev_replace.cont_reading_from_srcdev_mode ==
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index 68021d1ee216..f5f091f3c72b 100644
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
+	u8 readmirror;
 };
 
 #define BTRFS_BIO_INLINE_CSUM_SIZE	64
-- 
1.8.3.1

