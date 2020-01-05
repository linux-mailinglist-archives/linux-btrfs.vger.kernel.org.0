Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0768813089B
	for <lists+linux-btrfs@lfdr.de>; Sun,  5 Jan 2020 16:14:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726360AbgAEPO2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 5 Jan 2020 10:14:28 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:49062 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726212AbgAEPO2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 5 Jan 2020 10:14:28 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 005FBOA1050187;
        Sun, 5 Jan 2020 15:14:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2019-08-05;
 bh=p65lPcU6xxsXNenLFYfyHZf0TphKQKiaoOpF4cDEeX8=;
 b=j95P5Wl9eR5iHwGzQkG0DoHBFI8m1cjtCBrXSTwKT4n3IX6v5MHvb22h4sjF3cnM1uG1
 AmM/xnceu9kXB+t3APDUG8DlBvwqGql/SEBrVnSzvPTUUb3lMfi3A1pLZhFLDaqS/zik
 SUc8v9hDCnJxbjK4hcFVyIPY4Om5nCz79mgu8QrIHrOf+S5SIcgnH0DwbwFlWWJkIw/w
 4nN5K/gZxLl2L5i5kw5TJvapqNBf3bwbBbZiA2R9voukdPOvFSyeM8qSb41pDoKWzeXc
 hIBcVoqwKTJDJ8Huq/IZfBlrPUoBZOZ3CQKeqEy1DOhKSJS79g9ImNS/kUtVGWqixCUr jA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 2xakbqb7c3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 05 Jan 2020 15:14:23 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 005F9XM1039690;
        Sun, 5 Jan 2020 15:14:23 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 2xb4771yg8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 05 Jan 2020 15:14:22 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 005FELTC004111;
        Sun, 5 Jan 2020 15:14:21 GMT
Received: from localhost.localdomain (/39.109.145.141)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 05 Jan 2020 07:14:21 -0800
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     josef@toxicpanda.com, btrfs-list@steev.me.uk
Subject: [PATCH 1/2] btrfs: add read_policy framework
Date:   Sun,  5 Jan 2020 23:14:01 +0800
Message-Id: <20200105151402.1440-2-anand.jain@oracle.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200105151402.1440-1-anand.jain@oracle.com>
References: <20200105151402.1440-1-anand.jain@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9490 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001050138
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9490 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001050138
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

As of now we use %pid method to read stripped mirrored data, which means
application's process id determines the stripe id to be read. This type
of read IO routing typically helps in a system with many small
independent applications tying to read random data. On the other hand
the %pid based read IO distribution policy is inefficient because if
there is a single application trying to read large data the overall disk
bandwidth remains under-utilized.

So this patch introduces read policy framework so that we could add more
read policies, such as IO routing based on device's wait-queue or manual
when we have a read-preferred device or a policy based on the target
storage caching.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
[Patch name changed]

v3: Declare fs_devices::readmirror as enum btrfs_readmirror_policy_type
v2: Declare fs_devices::readmirror as u8 instead of atomic_t
    A small change in comment and change log wordings.

 fs/btrfs/volumes.c | 16 +++++++++++++++-
 fs/btrfs/volumes.h |  9 +++++++++
 2 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index c95e47aa84f8..2ffffdf1d314 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -1162,6 +1162,8 @@ static int open_fs_devices(struct btrfs_fs_devices *fs_devices,
 	fs_devices->opened = 1;
 	fs_devices->latest_bdev = latest_dev->bdev;
 	fs_devices->total_rw_bytes = 0;
+	/* Set the default read policy */
+	fs_devices->read_policy = BTRFS_READ_POLICY_DEFAULT;
 out:
 	return ret;
 }
@@ -5300,7 +5302,19 @@ static int find_live_mirror(struct btrfs_fs_info *fs_info,
 	else
 		num_stripes = map->num_stripes;
 
-	preferred_mirror = first + current->pid % num_stripes;
+	switch (fs_info->fs_devices->read_policy) {
+	case BTRFS_READ_BY_PID:
+		preferred_mirror = first + current->pid % num_stripes;
+		break;
+	default:
+		/*
+		 * Shouln't happen, just warn and use by_pid instead of failing.
+		 */
+		btrfs_warn_rl(fs_info,
+			      "unknown read_policy type %u, fallback to by_pid",
+			      fs_info->fs_devices->read_policy);
+		preferred_mirror = first + current->pid % num_stripes;
+	}
 
 	if (dev_replace_is_ongoing &&
 	    fs_info->dev_replace.cont_reading_from_srcdev_mode ==
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index 68021d1ee216..3bbf0e51433f 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -209,6 +209,13 @@ BTRFS_DEVICE_GETSET_FUNCS(total_bytes);
 BTRFS_DEVICE_GETSET_FUNCS(disk_total_bytes);
 BTRFS_DEVICE_GETSET_FUNCS(bytes_used);
 
+/* read_policy types */
+#define BTRFS_READ_POLICY_DEFAULT	BTRFS_READ_BY_PID
+enum btrfs_read_policy_type {
+	BTRFS_READ_BY_PID,
+	BTRFS_NR_READ_POLICY_TYPE,
+};
+
 struct btrfs_fs_devices {
 	u8 fsid[BTRFS_FSID_SIZE]; /* FS specific uuid */
 	u8 metadata_uuid[BTRFS_FSID_SIZE];
@@ -260,6 +267,8 @@ struct btrfs_fs_devices {
 	struct kobject *devices_kobj;
 	struct kobject *devinfo_kobj;
 	struct completion kobj_unregister;
+
+	enum btrfs_read_policy_type read_policy;
 };
 
 #define BTRFS_BIO_INLINE_CSUM_SIZE	64
-- 
2.23.0

