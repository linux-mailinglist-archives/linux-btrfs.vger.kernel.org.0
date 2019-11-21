Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2EF08104F52
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Nov 2019 10:34:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727004AbfKUJdt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 21 Nov 2019 04:33:49 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:47706 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726170AbfKUJds (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 21 Nov 2019 04:33:48 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAL9Sw9G068023
        for <linux-btrfs@vger.kernel.org>; Thu, 21 Nov 2019 09:33:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references; s=corp-2019-08-05;
 bh=5NPsEHh9YmmSiqmbgM4Ain1I42gyMV2kiY4MYBLTpfg=;
 b=GfUC/kiczeDF+A/6SZno4p1+ZoS49iDaoGy2z9GiRNP07A0L563T7OKf3aDSpWAC6dEh
 26Ia4vOtuDmkOf0Cqg2KzqG6ksRJuasGzL7AkovIepwC+1P1agmURuZddDCPSLt2CwMU
 LkXAI0+NYAxaWpXrLdbPmy32jofGpitwTd3n7hmiOQHii78Buo7196uNAcLO8QGknRjg
 kCJi4lblatmGgtCqrpHZfh/V33XRiyOSS39SVJIGYkfoURn0k5gYSVBWMoWYT/l18ypD
 jDIxWW8OPMpB42iPi1WBCpzU2jiKi7Q+sGn5/RQI3XTl/Ipurma9OqSlHGeIdg1ALQ1c Ow== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 2wa9rqtsrw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Thu, 21 Nov 2019 09:33:47 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAL9WkAk157075
        for <linux-btrfs@vger.kernel.org>; Thu, 21 Nov 2019 09:33:47 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 2wda05nyuq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Thu, 21 Nov 2019 09:33:46 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id xAL9XjaF017581
        for <linux-btrfs@vger.kernel.org>; Thu, 21 Nov 2019 09:33:46 GMT
Received: from tp.localdomain (/39.109.145.141)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 21 Nov 2019 01:33:45 -0800
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 1/5] btrfs: sysfs, rename devices kobject holder to devices_kobj
Date:   Thu, 21 Nov 2019 17:33:30 +0800
Message-Id: <1574328814-12263-2-git-send-email-anand.jain@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1574328814-12263-1-git-send-email-anand.jain@oracle.com>
References: <1574328814-12263-1-git-send-email-anand.jain@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9447 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1911210087
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9447 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1911210086
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The struct member btrfs_device::device_dir_kobj holds the kobj of the
sysfs directory /sys/fs/btrfs/UUID/devices, so rename it from
device_dir_kobj to devices_kobj. No functional changes.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
v2: Rename devices_dir_kobj to devices_kobj

 fs/btrfs/sysfs.c   | 28 ++++++++++++++--------------
 fs/btrfs/volumes.h |  2 +-
 2 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index 5ebbe8a5ee76..29e82832ff18 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -734,10 +734,10 @@ static int addrm_unknown_feature_attrs(struct btrfs_fs_info *fs_info, bool add)
 
 static void __btrfs_sysfs_remove_fsid(struct btrfs_fs_devices *fs_devs)
 {
-	if (fs_devs->device_dir_kobj) {
-		kobject_del(fs_devs->device_dir_kobj);
-		kobject_put(fs_devs->device_dir_kobj);
-		fs_devs->device_dir_kobj = NULL;
+	if (fs_devs->devices_kobj) {
+		kobject_del(fs_devs->devices_kobj);
+		kobject_put(fs_devs->devices_kobj);
+		fs_devs->devices_kobj = NULL;
 	}
 
 	if (fs_devs->fsid_kobj.state_initialized) {
@@ -969,15 +969,15 @@ int btrfs_sysfs_rm_device_link(struct btrfs_fs_devices *fs_devices,
 	struct hd_struct *disk;
 	struct kobject *disk_kobj;
 
-	if (!fs_devices->device_dir_kobj)
+	if (!fs_devices->devices_kobj)
 		return -EINVAL;
 
 	if (one_device && one_device->bdev) {
 		disk = one_device->bdev->bd_part;
 		disk_kobj = &part_to_dev(disk)->kobj;
 
-		sysfs_remove_link(fs_devices->device_dir_kobj,
-						disk_kobj->name);
+		sysfs_remove_link(fs_devices->devices_kobj,
+				  disk_kobj->name);
 	}
 
 	if (one_device)
@@ -990,8 +990,8 @@ int btrfs_sysfs_rm_device_link(struct btrfs_fs_devices *fs_devices,
 		disk = one_device->bdev->bd_part;
 		disk_kobj = &part_to_dev(disk)->kobj;
 
-		sysfs_remove_link(fs_devices->device_dir_kobj,
-						disk_kobj->name);
+		sysfs_remove_link(fs_devices->devices_kobj,
+				  disk_kobj->name);
 	}
 
 	return 0;
@@ -999,11 +999,11 @@ int btrfs_sysfs_rm_device_link(struct btrfs_fs_devices *fs_devices,
 
 int btrfs_sysfs_add_device(struct btrfs_fs_devices *fs_devs)
 {
-	if (!fs_devs->device_dir_kobj)
-		fs_devs->device_dir_kobj = kobject_create_and_add("devices",
-						&fs_devs->fsid_kobj);
+	if (!fs_devs->devices_kobj)
+		fs_devs->devices_kobj = kobject_create_and_add("devices",
+							&fs_devs->fsid_kobj);
 
-	if (!fs_devs->device_dir_kobj)
+	if (!fs_devs->devices_kobj)
 		return -ENOMEM;
 
 	return 0;
@@ -1028,7 +1028,7 @@ int btrfs_sysfs_add_device_link(struct btrfs_fs_devices *fs_devices,
 		disk = dev->bdev->bd_part;
 		disk_kobj = &part_to_dev(disk)->kobj;
 
-		error = sysfs_create_link(fs_devices->device_dir_kobj,
+		error = sysfs_create_link(fs_devices->devices_kobj,
 					  disk_kobj, disk_kobj->name);
 		if (error)
 			break;
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index fc1b564b9cfe..3c56ef571b00 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -255,7 +255,7 @@ struct btrfs_fs_devices {
 	struct btrfs_fs_info *fs_info;
 	/* sysfs kobjects */
 	struct kobject fsid_kobj;
-	struct kobject *device_dir_kobj;
+	struct kobject *devices_kobj;
 	struct completion kobj_unregister;
 };
 
-- 
1.8.3.1

