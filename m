Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A81812F6BF
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Jan 2020 11:31:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727524AbgACKbY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 3 Jan 2020 05:31:24 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:39636 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727220AbgACKbX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 3 Jan 2020 05:31:23 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 003ATDX6007277
        for <linux-btrfs@vger.kernel.org>; Fri, 3 Jan 2020 10:31:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2019-08-05;
 bh=hmIqDBHIPwK/Orjx6f17CWiu+cf6xugfizDha8LyS1Y=;
 b=CC6EzOG2WiWOt5n/lNasClqlMv3bHuqT1KGB6u9vXy6ni76/hL1PXG/wor+xocXEBg7N
 OJ0TCfPjMCJphJasLtNeWICN5NGueHG+LJMsJ8csDVhI0go+WBeCYdknMki5Sw5jaiTh
 jqrVJBowa1W4IB24oTiNMG4jbw0ZvfcMAWXmzC4ozlR3GY7syp+6HvIr5hit2gyeaDru
 tT+uPALSMjxBMOoQP4egbqp27eCnLdxzA0r6gjs8yNgGpfR7jbXD3NkS4xnFFZ0APtDQ
 gpTnTic3OveT0PxF5ACzSKCPqriQNqYfbZH7entSHkrf7p//R4CKcuFEGgTRRULcZHHJ 6A== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 2x5ypqup7t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Fri, 03 Jan 2020 10:31:22 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 003AUJxH148593
        for <linux-btrfs@vger.kernel.org>; Fri, 3 Jan 2020 10:31:21 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 2x9jm78r7k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Fri, 03 Jan 2020 10:31:21 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 003AVKxN017380
        for <linux-btrfs@vger.kernel.org>; Fri, 3 Jan 2020 10:31:20 GMT
Received: from mb.wifi.oracle.com (/192.188.170.109)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 03 Jan 2020 02:31:20 -0800
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v3 1/3] btrfs: add readmirror type framework
Date:   Fri,  3 Jan 2020 18:31:15 +0800
Message-Id: <20200103103115.7720-1-anand.jain@oracle.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <1577959968-19427-2-git-send-email-anand.jain@oracle.com>
References: <1577959968-19427-2-git-send-email-anand.jain@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9488 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001030100
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9488 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001030100
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

As of now we use %pid method to read stripped mirrored data, so
application's process id determines the stripe id to be read. This type
of read IO routing typically helps in a system with many small
independent applications tying to read random data. On the other hand
the %pid based read IO distribution policy is inefficient if there is a
single application trying to read large data as the overall disk
bandwidth remains under utilized.

So this patch introduces a framework where we could add more readmirror
policies, such as IO routing based on device's wait-queue or manual
when we have a read-preferred device or a policy based on the target
storage caching.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
v3: Declare fs_devices::readmirror as enum btrfs_readmirror_policy_type
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
index 68021d1ee216..513610a3e6b8 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -209,6 +209,12 @@ BTRFS_DEVICE_GETSET_FUNCS(total_bytes);
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
+	enum btrfs_readmirror_policy_type readmirror;
 };
 
 #define BTRFS_BIO_INLINE_CSUM_SIZE	64
-- 
2.23.0

