Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8458D1000A4
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Nov 2019 09:47:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726472AbfKRIrM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 18 Nov 2019 03:47:12 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:48028 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726464AbfKRIrL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 18 Nov 2019 03:47:11 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAI8i5qR105268
        for <linux-btrfs@vger.kernel.org>; Mon, 18 Nov 2019 08:47:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2019-08-05;
 bh=sV0W/6Zpjeyn8J6xzbbJL1by47YfLsxaZwHUPBIPmNU=;
 b=CdOLikqC/+53TsoHSKlc9IhIcZQ15GMGX/Waj6SC2ADTzH0J9dtS6py7DYm7EYTR2MAl
 dCMFBL3i00cp1mOS4hScKfBHVwe9X6FtjXdC8eZ+d2mzUHVu5cJPLP4J331MJ+UoXpw1
 BezNy3UB6wyWBgM6N8G+jzWILRaPVtH0DB5XUWblRIUFeJzKWvKE9a+wLh9GIP4a7Pwf
 ErZgq5aNQC9rBuVvAI80KjuDk6Mpr/DCuzkO8vCvtWmbZQWMUJw4mTBIcMBgrLoIzyrC
 wirGgCG/NkPtT1zP9luK9XlANM7fKQHUGhh4Dc1+qZuLTOwKUBoQPSbc840oVrSd1hrE BA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 2wa8htenpv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Mon, 18 Nov 2019 08:47:09 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAI8iNr8091218
        for <linux-btrfs@vger.kernel.org>; Mon, 18 Nov 2019 08:47:09 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 2watjx33jn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Mon, 18 Nov 2019 08:47:09 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id xAI8l87N010655
        for <linux-btrfs@vger.kernel.org>; Mon, 18 Nov 2019 08:47:08 GMT
Received: from mb.wifi.oracle.com (/192.188.170.109)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 18 Nov 2019 00:47:08 -0800
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 03/15] btrfs: sysfs, rename btrfs_device member device_dir_kobj
Date:   Mon, 18 Nov 2019 16:46:44 +0800
Message-Id: <20191118084656.3089-4-anand.jain@oracle.com>
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

The struct member btrfs_device::device_dir_kobj holds the kobj of the
sysfs directory /sys/fs/btrfs/UUID/devices, so rename its holder from
device_dir_kobj to devices_dir_kobj. No functional changes.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 fs/btrfs/sysfs.c   | 28 ++++++++++++++--------------
 fs/btrfs/volumes.h |  2 +-
 2 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index 399b9c46790c..1d58187a6b33 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -744,10 +744,10 @@ static int addrm_unknown_feature_attrs(struct btrfs_fs_info *fs_info, bool add)
 
 static void __btrfs_sysfs_remove_fsid(struct btrfs_fs_devices *fs_devs)
 {
-	if (fs_devs->device_dir_kobj) {
-		kobject_del(fs_devs->device_dir_kobj);
-		kobject_put(fs_devs->device_dir_kobj);
-		fs_devs->device_dir_kobj = NULL;
+	if (fs_devs->devices_dir_kobj) {
+		kobject_del(fs_devs->devices_dir_kobj);
+		kobject_put(fs_devs->devices_dir_kobj);
+		fs_devs->devices_dir_kobj = NULL;
 	}
 
 	if (fs_devs->fsid_kobj.state_initialized) {
@@ -979,15 +979,15 @@ int btrfs_sysfs_remove_device_info(struct btrfs_fs_devices *fs_devices,
 	struct hd_struct *disk;
 	struct kobject *disk_kobj;
 
-	if (!fs_devices->device_dir_kobj)
+	if (!fs_devices->devices_dir_kobj)
 		return -EINVAL;
 
 	if (one_device && one_device->bdev) {
 		disk = one_device->bdev->bd_part;
 		disk_kobj = &part_to_dev(disk)->kobj;
 
-		sysfs_remove_link(fs_devices->device_dir_kobj,
-						disk_kobj->name);
+		sysfs_remove_link(fs_devices->devices_dir_kobj,
+				  disk_kobj->name);
 	}
 
 	if (one_device)
@@ -1000,8 +1000,8 @@ int btrfs_sysfs_remove_device_info(struct btrfs_fs_devices *fs_devices,
 		disk = one_device->bdev->bd_part;
 		disk_kobj = &part_to_dev(disk)->kobj;
 
-		sysfs_remove_link(fs_devices->device_dir_kobj,
-						disk_kobj->name);
+		sysfs_remove_link(fs_devices->devices_dir_kobj,
+				  disk_kobj->name);
 	}
 
 	return 0;
@@ -1009,11 +1009,11 @@ int btrfs_sysfs_remove_device_info(struct btrfs_fs_devices *fs_devices,
 
 int btrfs_sysfs_add_devices_dir(struct btrfs_fs_devices *fs_devs)
 {
-	if (!fs_devs->device_dir_kobj)
-		fs_devs->device_dir_kobj = kobject_create_and_add("devices",
-						&fs_devs->fsid_kobj);
+	if (!fs_devs->devices_dir_kobj)
+		fs_devs->devices_dir_kobj = kobject_create_and_add("devices",
+							&fs_devs->fsid_kobj);
 
-	if (!fs_devs->device_dir_kobj)
+	if (!fs_devs->devices_dir_kobj)
 		return -ENOMEM;
 
 	return 0;
@@ -1038,7 +1038,7 @@ int btrfs_sysfs_add_device_info(struct btrfs_fs_devices *fs_devices,
 		disk = dev->bdev->bd_part;
 		disk_kobj = &part_to_dev(disk)->kobj;
 
-		error = sysfs_create_link(fs_devices->device_dir_kobj,
+		error = sysfs_create_link(fs_devices->devices_dir_kobj,
 					  disk_kobj, disk_kobj->name);
 		if (error)
 			break;
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index fc1b564b9cfe..012e75f29fe0 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -255,7 +255,7 @@ struct btrfs_fs_devices {
 	struct btrfs_fs_info *fs_info;
 	/* sysfs kobjects */
 	struct kobject fsid_kobj;
-	struct kobject *device_dir_kobj;
+	struct kobject *devices_dir_kobj;
 	struct completion kobj_unregister;
 };
 
-- 
2.23.0

