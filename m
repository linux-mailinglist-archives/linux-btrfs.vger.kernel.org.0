Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50B8125E0E5
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Sep 2020 19:35:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727902AbgIDRfJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 4 Sep 2020 13:35:09 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:60284 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727867AbgIDRfI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 4 Sep 2020 13:35:08 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 084HZ2TF140942;
        Fri, 4 Sep 2020 17:35:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=vQz468VqBG8NLCy2IaVdPMZZMGfZdiu5QQIjHy7bZ8o=;
 b=0GP4aciGU0V9aO8JT4peDiowIm1b3tUhSlxpqRvyPurEAL9ZJ6P2ZrfUe6tyjJBUXlcx
 w2hFQZ7bHiwicf4VGwmlyxFKDR+G61yd8bkQ/awBr7iKh9/h8GHqgg/aP0MEvXfVpjOD
 bo7fxKcojcokGyWIfs811GWdVmO7uU3VVVEfFGN/aa1ZSoRGDfk+5B8iUISXepLJ/rDA
 FyPm4MNu8f/2T46vhbkr7GISqN66c/oxUQ+c4UjGgzmLHFnY/vpUcRfsVott1KQJzgLw
 GYqJT62S+HCefzZP3yFHK63x1HWsOy1v/Glw+Ta77nhw/uyKeL64v0Aj3ITSrVG3Rv6k NQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 337eerfr7h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 04 Sep 2020 17:35:02 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 084HVLmL083192;
        Fri, 4 Sep 2020 17:34:58 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 3380ktt9c0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 04 Sep 2020 17:34:58 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 084HYuNF008767;
        Fri, 4 Sep 2020 17:34:56 GMT
Received: from localhost.localdomain (/39.109.231.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 04 Sep 2020 10:34:56 -0700
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.com, josef@toxicpanda.com, nborisov@suse.com
Subject: [PATCH 04/16] btrfs: add btrfs_sysfs_remove_device helper
Date:   Sat,  5 Sep 2020 01:34:24 +0800
Message-Id: <a273cace2fd1a00364d4bce7780278c561cd5fc0.1599234146.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1599234146.git.anand.jain@oracle.com>
References: <cover.1599234146.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9734 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 adultscore=0
 mlxscore=0 suspectscore=1 malwarescore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009040152
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9734 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 adultscore=0 spamscore=0 mlxscore=0
 phishscore=0 impostorscore=0 mlxlogscore=999 bulkscore=0 suspectscore=1
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009040152
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

btrfs_sysfs_remove_devices_dir() removes device link and devid kobject
(sysfs entries) for a device or all the devices in the btrfs_fs_devices.
In preparation to remove these sysfs entries for the seed as well, add
a btrfs_sysfs_remove_device() helper function and avoid code
duplication.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
Reviewed-by: Nikolay Borisov <nborisov@suse.com>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/sysfs.c | 61 +++++++++++++++++++++---------------------------
 1 file changed, 27 insertions(+), 34 deletions(-)

diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index 4377b991f6d6..33703fe01c72 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -1149,50 +1149,43 @@ int btrfs_sysfs_add_space_info_type(struct btrfs_fs_info *fs_info,
 	return 0;
 }
 
-/* when one_device is NULL, it removes all device links */
-
-int btrfs_sysfs_remove_devices_dir(struct btrfs_fs_devices *fs_devices,
-		struct btrfs_device *one_device)
+static void btrfs_sysfs_remove_device(struct btrfs_device *device)
 {
 	struct hd_struct *disk;
 	struct kobject *disk_kobj;
+	struct kobject *devices_kobj;
 
-	if (!fs_devices->devices_kobj)
-		return -EINVAL;
-
-	if (one_device) {
-		if (one_device->bdev) {
-			disk = one_device->bdev->bd_part;
-			disk_kobj = &part_to_dev(disk)->kobj;
-			sysfs_remove_link(fs_devices->devices_kobj,
-					  disk_kobj->name);
-		}
+	/*
+	 * Seed fs_devices devices_kobj aren't used, fetch kobject from the
+	 * fs_info::fs_devices.
+	 */
+	devices_kobj = device->fs_info->fs_devices->devices_kobj;
+	ASSERT(devices_kobj);
 
-		if (one_device->devid_kobj.state_initialized) {
-			kobject_del(&one_device->devid_kobj);
-			kobject_put(&one_device->devid_kobj);
+	if (device->bdev) {
+		disk = device->bdev->bd_part;
+		disk_kobj = &part_to_dev(disk)->kobj;
+		sysfs_remove_link(devices_kobj, disk_kobj->name);
+	}
 
-			wait_for_completion(&one_device->kobj_unregister);
-		}
+	if (device->devid_kobj.state_initialized) {
+		kobject_del(&device->devid_kobj);
+		kobject_put(&device->devid_kobj);
+		wait_for_completion(&device->kobj_unregister);
+	}
+}
 
+/* when 2nd argument device is NULL, it removes all devices link */
+int btrfs_sysfs_remove_devices_dir(struct btrfs_fs_devices *fs_devices,
+				   struct btrfs_device *one_device)
+{
+	if (one_device) {
+		btrfs_sysfs_remove_device(one_device);
 		return 0;
 	}
 
-	list_for_each_entry(one_device, &fs_devices->devices, dev_list) {
-
-		if (one_device->bdev) {
-			disk = one_device->bdev->bd_part;
-			disk_kobj = &part_to_dev(disk)->kobj;
-			sysfs_remove_link(fs_devices->devices_kobj,
-					  disk_kobj->name);
-		}
-		if (one_device->devid_kobj.state_initialized) {
-			kobject_del(&one_device->devid_kobj);
-			kobject_put(&one_device->devid_kobj);
-
-			wait_for_completion(&one_device->kobj_unregister);
-		}
-	}
+	list_for_each_entry(one_device, &fs_devices->devices, dev_list)
+		btrfs_sysfs_remove_device(one_device);
 
 	return 0;
 }
-- 
2.25.1

