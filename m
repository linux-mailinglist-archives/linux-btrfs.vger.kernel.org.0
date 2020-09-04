Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2C2325E0E4
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Sep 2020 19:35:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727081AbgIDRfC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 4 Sep 2020 13:35:02 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:49688 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727867AbgIDRfA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 4 Sep 2020 13:35:00 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 084HXuZJ037485;
        Fri, 4 Sep 2020 17:34:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=2hm5BC6UQUnsQhK21lXDofiYIaavOLo82x5IAYusDWI=;
 b=cttq3Rbpla1jmOXDQ0weL0m+QMbK20DKeHT0XVjgw9RXAOWq/6SDvALJdUsPmpfILIPs
 6EdMb7OeD+JJD42gzoCcDKTaEbgC60cg/ersV5At56clW5O+1+jldJEY9cjmuW8cfn51
 ghGjnWSH/b1+epGtsGOklYzVzjHkjlLUyxj1Zc7nimodLsjJvxc6k70TmR0KguoQ3thT
 /QUI0BEFSUoqC/r3ZmUjS+ugSkBzvXS3xc1EluxtdWymhX3kePtqLHdY/X1Z2k9l8brs
 A1Asw61I4tRIyQ0n0DU2IVfcQi5x5zsL/IZWkJvaoKgnBZ/Ow8AIdNf2HH6oAKIFqmJd iw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 339dmne37g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 04 Sep 2020 17:34:55 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 084HUlq0090320;
        Fri, 4 Sep 2020 17:34:54 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 3380xds654-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 04 Sep 2020 17:34:54 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 084HYsEX014891;
        Fri, 4 Sep 2020 17:34:54 GMT
Received: from localhost.localdomain (/39.109.231.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 04 Sep 2020 10:34:53 -0700
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.com, josef@toxicpanda.com, nborisov@suse.com
Subject: [PATCH 03/16] btrfs: add btrfs_sysfs_add_device helper
Date:   Sat,  5 Sep 2020 01:34:23 +0800
Message-Id: <8b7426788aa04f0707e36e08ee866c589ba90cf5.1599234146.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1599234146.git.anand.jain@oracle.com>
References: <cover.1599234146.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9734 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 phishscore=0
 mlxlogscore=999 adultscore=0 suspectscore=1 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009040152
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9734 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0
 mlxlogscore=999 adultscore=0 impostorscore=0 mlxscore=0 suspectscore=1
 spamscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009040152
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

btrfs_sysfs_add_devices_dir() adds device link and devid kobject
(sysfs entries) for a device or all the devices in the btrfs_fs_devices.
In preparation to add these sysfs entries for the seed as well, add
a btrfs_sysfs_add_device() helper function and avoid code duplication.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
---
v3: Use device->fs_info instead of device->fs_devices->fs_info
    essentially both points to the same addr, but former is more
    efficient.
    Fix whitespace, which didn't appear red in the git diff earlier,
    strange.

 fs/btrfs/sysfs.c | 79 ++++++++++++++++++++++++++++++++----------------
 1 file changed, 53 insertions(+), 26 deletions(-)

diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index 438a367371c4..4377b991f6d6 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -1275,44 +1275,71 @@ static struct kobj_type devid_ktype = {
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
+	struct kobject *devinfo_kobj;
 
-	nofs_flag = memalloc_nofs_save();
-	list_for_each_entry(dev, &fs_devices->devices, dev_list) {
+	/*
+	 * make sure we use the fs_info::fs_devices to fetch the kobjects
+	 * even for the seed fs_devices
+	 */
+	devices_kobj = device->fs_info->fs_devices->devices_kobj;
+	devinfo_kobj = device->fs_info->fs_devices->devinfo_kobj;
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

