Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D8C681000AE
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Nov 2019 09:47:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726664AbfKRIrY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 18 Nov 2019 03:47:24 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:47800 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726595AbfKRIrX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 18 Nov 2019 03:47:23 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAI8i3JW093462
        for <linux-btrfs@vger.kernel.org>; Mon, 18 Nov 2019 08:47:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2019-08-05;
 bh=Fmbihwz7TwYMTRuvfY4VNpoGXhoK7kgf3v32UsZJroM=;
 b=MXf1xyf1komVCu9SBHQEoXAseSSErXOg3ltCgySR02EbMm4ep5APhzOux7N/8iM7Ge73
 w8ZBEmiReX4lAmz5N3O36rzm3MSNZGJIA2fdCVvQOhQeGnjMj714D+2tyQ9tAi9CZrHK
 ZIMVlhCjJ2B+FBbBOpN50IXlgJoItpdnea5SPc5YC1BFPrmw1f4JOUuwB7cr5/FWcILq
 /beibXkGJS4FlnzBkfoilKp3zwzmMCQSUfpWzhMZTnjSDBt7nlqb4ifQjq70wj86XDWh
 Vx8TMppNcFtABne83ZuB1NSyykW3XLD07sCj1lLBu7pa+rIepZ5sPEGolfBrXt0C5Al5 mA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 2wa92peka3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Mon, 18 Nov 2019 08:47:21 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAI8iL6Z152953
        for <linux-btrfs@vger.kernel.org>; Mon, 18 Nov 2019 08:47:21 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 2watmr3hap-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Mon, 18 Nov 2019 08:47:21 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id xAI8lLxR005657
        for <linux-btrfs@vger.kernel.org>; Mon, 18 Nov 2019 08:47:21 GMT
Received: from mb.wifi.oracle.com (/192.188.170.109)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 18 Nov 2019 00:47:20 -0800
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 09/15] btrfs: sysfs, merge btrfs_sysfs_add device_dir and fsid
Date:   Mon, 18 Nov 2019 16:46:50 +0800
Message-Id: <20191118084656.3089-10-anand.jain@oracle.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191118084656.3089-1-anand.jain@oracle.com>
References: <20191118084656.3089-1-anand.jain@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9444 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1911180079
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9444 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1911180079
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Merge btrfs_sysfs_add_fsid() and btrfs_sysfs_add_devices_dir() functions
these two are small and they are called one after the other.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 fs/btrfs/disk-io.c |  7 -------
 fs/btrfs/sysfs.c   | 22 +++++++++-------------
 fs/btrfs/sysfs.h   |  1 -
 3 files changed, 9 insertions(+), 21 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 3f6a26d9afcd..ab888d89d844 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -3089,13 +3089,6 @@ int __cold open_ctree(struct super_block *sb,
 		goto fail_block_groups;
 	}
 
-	ret = btrfs_sysfs_add_devices_dir(fs_devices);
-	if (ret) {
-		btrfs_err(fs_info, "failed to init sysfs device interface: %d",
-				ret);
-		goto fail_fsdev_sysfs;
-	}
-
 	ret = btrfs_sysfs_add_mounted(fs_info);
 	if (ret) {
 		btrfs_err(fs_info, "failed to init sysfs interface: %d", ret);
diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index 42aeb2375f2a..b42245104bc9 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -952,18 +952,6 @@ int btrfs_sysfs_remove_device_info(struct btrfs_fs_devices *fs_devices,
 	return 0;
 }
 
-int btrfs_sysfs_add_devices_dir(struct btrfs_fs_devices *fs_devs)
-{
-	if (!fs_devs->devices_dir_kobj)
-		fs_devs->devices_dir_kobj = kobject_create_and_add("devices",
-							&fs_devs->fsid_kobj);
-
-	if (!fs_devs->devices_dir_kobj)
-		return -ENOMEM;
-
-	return 0;
-}
-
 int btrfs_sysfs_add_device_info(struct btrfs_fs_devices *fs_devices,
 				struct btrfs_device *one_device)
 {
@@ -1134,10 +1122,18 @@ int btrfs_sysfs_add_fsid(struct btrfs_fs_devices *fs_devs)
 		return error;
 	}
 
+	fs_devs->devices_dir_kobj = kobject_create_and_add("devices",
+							&fs_devs->fsid_kobj);
+	if (!fs_devs->devices_dir_kobj) {
+		btrfs_err(fs_devs->fs_info,
+			  "failed to init sysfs device interface");
+		kobject_put(&fs_devs->fsid_kobj);
+		return -ENOMEM;
+	}
+
 	return 0;
 }
 
-
 /*
  * Change per-fs features in /sys/fs/btrfs/UUID/features to match current
  * values in superblock. Call after any changes to incompat/compat_ro flags
diff --git a/fs/btrfs/sysfs.h b/fs/btrfs/sysfs.h
index 6addc35deb67..e7ae91f68e36 100644
--- a/fs/btrfs/sysfs.h
+++ b/fs/btrfs/sysfs.h
@@ -19,7 +19,6 @@ int btrfs_sysfs_add_device_info(struct btrfs_fs_devices *fs_devices,
 int btrfs_sysfs_remove_device_info(struct btrfs_fs_devices *fs_devices,
                 struct btrfs_device *one_device);
 int btrfs_sysfs_add_fsid(struct btrfs_fs_devices *fs_devs);
-int btrfs_sysfs_add_devices_dir(struct btrfs_fs_devices *fs_devs);
 void btrfs_sysfs_remove_fsid(struct btrfs_fs_devices *fs_devs);
 void btrfs_sysfs_update_sprout_fsid(struct btrfs_fs_devices *fs_devices,
 				    const u8 *fsid);
-- 
2.23.0

