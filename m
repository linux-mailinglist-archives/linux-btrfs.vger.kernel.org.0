Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E48DB25B809
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Sep 2020 02:58:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727788AbgICA6Q (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Sep 2020 20:58:16 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:39120 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726312AbgICA6O (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 2 Sep 2020 20:58:14 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0830t8LO048110
        for <linux-btrfs@vger.kernel.org>; Thu, 3 Sep 2020 00:58:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=xt41m4RaskU4H5aFX0gKv69SQNFhf4FOaUH5pI/6+fk=;
 b=EmFRXVfX1dGdM2Xsvl529PyNuUc+LdblYza1wiL94yUnMOftSiFhy+m/j7Oyidc4l9i1
 OvgICdNXNVaWhiSyWVp3p8YsGKRGewTKTe0cTRP/JY2ww3XjE8nM5M+BQEvVh/T+29HU
 S98hIzrPmVot2Du44dXKGwwt/9nTaLX2jyePrPvVcv50pHtEvYsC+2F+fAej7WNIj6TA
 4f+qRn3W9oSedjgm9tnCme+0GCdMbHjBNvdMrgzKcFCoX0jCJFDeobUpt4Dg+QrA0TGf
 k+W5adoCnRWJUavE8Si0ILSrfigGv0pxylIxMZ8eGVNRgygSbJfLT1u95Te2hBWGbgJJ sw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 337eer5xa4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
        for <linux-btrfs@vger.kernel.org>; Thu, 03 Sep 2020 00:58:12 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0830sfoh036822
        for <linux-btrfs@vger.kernel.org>; Thu, 3 Sep 2020 00:58:12 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 3380x8ans7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Thu, 03 Sep 2020 00:58:11 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0830wAlA027447
        for <linux-btrfs@vger.kernel.org>; Thu, 3 Sep 2020 00:58:11 GMT
Received: from localhost.localdomain (/39.109.231.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 02 Sep 2020 17:58:10 -0700
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 02/15] btrfs: add btrfs_sysfs_remove_device helper
Date:   Thu,  3 Sep 2020 08:57:38 +0800
Message-Id: <e86c1cd026973f7b65ccf26a523cc2e476fb13fc.1599091832.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1599091832.git.anand.jain@oracle.com>
References: <cover.1599091832.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9732 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 phishscore=0
 mlxlogscore=999 adultscore=0 suspectscore=1 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009030004
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9732 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 adultscore=0 spamscore=0 mlxscore=0
 phishscore=0 impostorscore=0 mlxlogscore=999 bulkscore=0 suspectscore=1
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009030004
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
---
 fs/btrfs/sysfs.c | 54 ++++++++++++++++++++++--------------------------
 1 file changed, 25 insertions(+), 29 deletions(-)

diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index 3381a91d7deb..241ec0ad0379 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -1149,46 +1149,42 @@ int btrfs_sysfs_add_space_info_type(struct btrfs_fs_info *fs_info,
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
+	/*
+	 * Seed fs_devices devices_kobj aren't used, fetch kobject from the
+	 * fs_info::fs_devices.
+	 */
+	devices_kobj = device->fs_info->fs_devices->devices_kobj;
+	ASSERT(devices_kobj);
 
-	if (one_device) {
-		if (one_device->bdev) {
-			disk = one_device->bdev->bd_part;
-			disk_kobj = &part_to_dev(disk)->kobj;
-			sysfs_remove_link(fs_devices->devices_kobj,
-					  disk_kobj->name);
-		}
+	if (device->bdev) {
+		disk = device->bdev->bd_part;
+		disk_kobj = &part_to_dev(disk)->kobj;
+		sysfs_remove_link(devices_kobj, disk_kobj->name);
+	}
 
-		kobject_del(&one_device->devid_kobj);
-		kobject_put(&one_device->devid_kobj);
+	kobject_del(&device->devid_kobj);
+	kobject_put(&device->devid_kobj);
 
-		wait_for_completion(&one_device->kobj_unregister);
+	wait_for_completion(&device->kobj_unregister);
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
-		kobject_del(&one_device->devid_kobj);
-		kobject_put(&one_device->devid_kobj);
-
-		wait_for_completion(&one_device->kobj_unregister);
-	}
+	list_for_each_entry(one_device, &fs_devices->devices, dev_list)
+		btrfs_sysfs_remove_device(one_device);
 
 	return 0;
 }
-- 
2.25.1

