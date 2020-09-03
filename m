Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEF9825B807
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Sep 2020 02:58:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726922AbgICA6O (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Sep 2020 20:58:14 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:38782 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726377AbgICA6M (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 2 Sep 2020 20:58:12 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0830sAfA125306
        for <linux-btrfs@vger.kernel.org>; Thu, 3 Sep 2020 00:58:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=0QSkfpQDVXHlI3HV+SL9baFFNUfmaNcbEVhjAA71MZc=;
 b=iMxy/CwFAYadLD2JCyf6fYajgsN9/qzOpio/2tNbud8PojPy65MzqPXbJWzkt71deBl/
 VROTG3/Q6+NlZ9gBqI8r6pckpFgV/sBJGoagbx/ZrW4yikD2vOhkqKgcqtajhq1ApU7q
 Aj2bU6g2kwKabX5Lmn3HmpO071nrbdKHJKZ/6eSpz0JiukcT2fcnCvMzq0NqBC0LiIWs
 ZeqeqqSZk0Y2onRKFrpqwYRzlsfJNtVRcR5S2BQgCE+QHpDt6zXd9ikrUEA9Ogq7WFY8
 R79I86HVy5gD59YDIX8n3QmvwP4zavbBRbl+oqKr+0XHbIbR+oIw31WhhcoWbGa4pgb3 dQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 337eymdu2h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
        for <linux-btrfs@vger.kernel.org>; Thu, 03 Sep 2020 00:58:10 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0830t7IH179630
        for <linux-btrfs@vger.kernel.org>; Thu, 3 Sep 2020 00:58:09 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 3380sv1674-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Thu, 03 Sep 2020 00:58:09 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0830w9uf017142
        for <linux-btrfs@vger.kernel.org>; Thu, 3 Sep 2020 00:58:09 GMT
Received: from localhost.localdomain (/39.109.231.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 02 Sep 2020 17:58:08 -0700
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 01/15] btrfs: add btrfs_sysfs_add_device helper
Date:   Thu,  3 Sep 2020 08:57:37 +0800
Message-Id: <5f8aa8a03a1712adba0023fc1efa18623571c588.1599091832.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1599091832.git.anand.jain@oracle.com>
References: <cover.1599091832.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9732 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 phishscore=0 malwarescore=0 mlxscore=0 spamscore=0 bulkscore=0
 suspectscore=1 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009030004
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9732 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 adultscore=0
 priorityscore=1501 phishscore=0 mlxlogscore=999 mlxscore=0
 lowpriorityscore=0 clxscore=1015 spamscore=0 bulkscore=0 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009030004
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

btrfs_sysfs_add_devices_dir() adds device link and devid kobject
(sysfs entries) for a device or all the devices in the btrfs_fs_devices.
In preparation to add these sysfs entries for the seed as well, add
a btrfs_sysfs_add_device() helper function and avoid code duplication.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 fs/btrfs/sysfs.c | 79 ++++++++++++++++++++++++++++++++----------------
 1 file changed, 53 insertions(+), 26 deletions(-)

diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index 190e59152be5..3381a91d7deb 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -1271,44 +1271,71 @@ static struct kobj_type devid_ktype = {
 	.release	= btrfs_release_devid_kobj,
 };
 
-int btrfs_sysfs_add_devices_dir(struct btrfs_fs_devices *fs_devices,
-				struct btrfs_device *one_device)
+static int btrfs_sysfs_add_device(struct btrfs_device *device)
 {
-	int error = 0;
-	struct btrfs_device *dev;
+	int ret;
 	unsigned int nofs_flag;
+	struct kobject *devices_kobj;
+        struct kobject *devinfo_kobj;
 
-	nofs_flag = memalloc_nofs_save();
-	list_for_each_entry(dev, &fs_devices->devices, dev_list) {
+	/*
+	 * make sure we use the fs_info::fs_devices to fetch the kobjects
+	 * even for the seed fs_devices
+	 */
+	devices_kobj = device->fs_devices->fs_info->fs_devices->devices_kobj;
+	devinfo_kobj = device->fs_devices->fs_info->fs_devices->devinfo_kobj;
+	ASSERT(devices_kobj);
+	ASSERT(devinfo_kobj);
 
-		if (one_device && one_device != dev)
-			continue;
+	nofs_flag = memalloc_nofs_save();
 
-		if (dev->bdev) {
-			struct hd_struct *disk;
-			struct kobject *disk_kobj;
+	if (device->bdev) {
+		struct hd_struct *disk;
+		struct kobject *disk_kobj;
 
-			disk = dev->bdev->bd_part;
-			disk_kobj = &part_to_dev(disk)->kobj;
+		disk = device->bdev->bd_part;
+		disk_kobj = &part_to_dev(disk)->kobj;
 
-			error = sysfs_create_link(fs_devices->devices_kobj,
-						  disk_kobj, disk_kobj->name);
-			if (error)
-				break;
+		ret = sysfs_create_link(devices_kobj, disk_kobj,
+					disk_kobj->name);
+		if (ret) {
+			btrfs_warn(device->fs_info,
+			   "sysfs create device link failed %d devid %llu",
+				   ret, device->devid);
+			goto out;
 		}
+	}
 
-		init_completion(&dev->kobj_unregister);
-		error = kobject_init_and_add(&dev->devid_kobj, &devid_ktype,
-					     fs_devices->devinfo_kobj, "%llu",
-					     dev->devid);
-		if (error) {
-			kobject_put(&dev->devid_kobj);
-			break;
-		}
+	init_completion(&device->kobj_unregister);
+	ret = kobject_init_and_add(&device->devid_kobj, &devid_ktype,
+				   devinfo_kobj, "%llu", device->devid);
+	if (ret) {
+		kobject_put(&device->devid_kobj);
+		btrfs_warn(device->fs_info,
+			   "sysfs devinfo init failed %d devid %llu",
+			   ret, device->devid);
 	}
+
+out:
 	memalloc_nofs_restore(nofs_flag);
+	return ret;
+}
 
-	return error;
+int btrfs_sysfs_add_devices_dir(struct btrfs_fs_devices *fs_devices,
+				struct btrfs_device *one_device)
+{
+	int ret;
+
+	if (one_device)
+		return btrfs_sysfs_add_device(one_device);
+
+	list_for_each_entry(one_device, &fs_devices->devices, dev_list) {
+		ret = btrfs_sysfs_add_device(one_device);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
 }
 
 void btrfs_kobject_uevent(struct block_device *bdev, enum kobject_action action)
-- 
2.25.1

