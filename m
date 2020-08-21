Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02BB124D60A
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Aug 2020 15:19:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727926AbgHUNTB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 21 Aug 2020 09:19:01 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:49440 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726975AbgHUNTA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 21 Aug 2020 09:19:00 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07LDHXrF013180;
        Fri, 21 Aug 2020 13:18:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=fjsBqepLgYWHiKHfv2X2P7VrSN6lznqEqNOBVrp05nk=;
 b=hhSbPwJfLchfcd5iMNv911DNvIBen9tveZypZKcN8pg3mN/X0osbb9ZYvL0TR15qfCqR
 cHSxjA4/kCkHtBPJqVWHagA6+6CGRt52DzpjRsZJa19gzysuqDxWQRV5CEj43qEpYxGr
 cnuHFeaxFTxlh42uVdbEnW+x9e+gynkqJtOB+qX8QxOv7639oiqErzLjZOqp+MHwoNG7
 C/5fTR0cyYgUGcCxcfbZNGN0QaTS2iZTgPr+/8VDWDzqOqaTMyQjIfV4d1NRkaimFNMl
 IA/ds2S0YIFawnuS0eVRAo7Ear8i677F0LCozxuy4CHWQZ1yGFqzQR3UIaLZh2NtDAif wA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 3322bjjh4p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 21 Aug 2020 13:18:58 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07LD7tWO093590;
        Fri, 21 Aug 2020 13:16:58 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 330pvrs2kd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Aug 2020 13:16:58 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 07LDGvnV014075;
        Fri, 21 Aug 2020 13:16:57 GMT
Received: from localhost.localdomain (/39.109.231.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 21 Aug 2020 13:16:56 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     josef@toxicpanda.com
Subject: [PATCH 1/2] btrfs: initialize sysfs devid and device link for seed device
Date:   Fri, 21 Aug 2020 21:15:21 +0800
Message-Id: <2c7ca821f53d71d6c1a4e1f1c969c1d8e686021a.1598012410.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <d82dc7d38ac43d88381eaa5260cee3dc9907e810.1598011271.git.anand.jain@oracle.com>
References: <d82dc7d38ac43d88381eaa5260cee3dc9907e810.1598011271.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9719 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 phishscore=0
 malwarescore=0 adultscore=0 bulkscore=0 suspectscore=1 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008210121
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9719 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 adultscore=0 mlxscore=0 mlxlogscore=999 phishscore=0 suspectscore=1
 lowpriorityscore=0 spamscore=0 impostorscore=0 clxscore=1015 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008210122
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The following test case leads to null kobject-being-freed error.

 mount seed /mnt
 add sprout to /mnt
 umount /mnt
 mount sprout to /mnt
 delete seed

 kobject: '(null)' (00000000dd2b87e4): is not initialized, yet kobject_put() is being called.
 WARNING: CPU: 1 PID: 15784 at lib/kobject.c:736 kobject_put+0x80/0x350
 RIP: 0010:kobject_put+0x80/0x350
 ::
 Call Trace:
 btrfs_sysfs_remove_devices_dir+0x6e/0x160 [btrfs]
 btrfs_rm_device.cold+0xa8/0x298 [btrfs]
 btrfs_ioctl+0x206c/0x22a0 [btrfs]
 ksys_ioctl+0xe2/0x140
 __x64_sys_ioctl+0x1e/0x29
 do_syscall_64+0x96/0x150
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
 RIP: 0033:0x7f4047c6288b
 ::

This is because, at the end of the seed device-delete, we try to remove
the seed's devid sysfs entry. But for the seed devices under the sprout
fs, we don't initialize the devid kobject yet. So this patch initializes
the seed device devid kobject and the device link in the sysfs. This takes
care of the Warning.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 fs/btrfs/sysfs.c | 30 ++++++++++++++++++++----------
 1 file changed, 20 insertions(+), 10 deletions(-)

diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index 88fd4ce937b8..85403fc3d5c7 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -1154,20 +1154,20 @@ int btrfs_sysfs_add_space_info_type(struct btrfs_fs_info *fs_info,
 /* when one_device is NULL, it removes all device links */
 
 int btrfs_sysfs_remove_devices_dir(struct btrfs_fs_devices *fs_devices,
-		struct btrfs_device *one_device)
+				   struct btrfs_device *one_device)
 {
 	struct hd_struct *disk;
 	struct kobject *disk_kobj;
+	struct kobject *devices_kobj = fs_devices->devices_kobj;
 
-	if (!fs_devices->devices_kobj)
+	if (!devices_kobj)
 		return -EINVAL;
 
 	if (one_device) {
 		if (one_device->bdev) {
 			disk = one_device->bdev->bd_part;
 			disk_kobj = &part_to_dev(disk)->kobj;
-			sysfs_remove_link(fs_devices->devices_kobj,
-					  disk_kobj->name);
+			sysfs_remove_link(devices_kobj, disk_kobj->name);
 		}
 
 		kobject_del(&one_device->devid_kobj);
@@ -1178,19 +1178,23 @@ int btrfs_sysfs_remove_devices_dir(struct btrfs_fs_devices *fs_devices,
 		return 0;
 	}
 
+again:
 	list_for_each_entry(one_device, &fs_devices->devices, dev_list) {
 
 		if (one_device->bdev) {
 			disk = one_device->bdev->bd_part;
 			disk_kobj = &part_to_dev(disk)->kobj;
-			sysfs_remove_link(fs_devices->devices_kobj,
-					  disk_kobj->name);
+			sysfs_remove_link(devices_kobj, disk_kobj->name);
 		}
 		kobject_del(&one_device->devid_kobj);
 		kobject_put(&one_device->devid_kobj);
 
 		wait_for_completion(&one_device->kobj_unregister);
 	}
+	while (fs_devices->seed) {
+		fs_devices = fs_devices->seed;
+		goto again;
+	}
 
 	return 0;
 }
@@ -1279,8 +1283,11 @@ int btrfs_sysfs_add_devices_dir(struct btrfs_fs_devices *fs_devices,
 	int error = 0;
 	struct btrfs_device *dev;
 	unsigned int nofs_flag;
+	struct kobject *devices_kobj = fs_devices->devices_kobj;
+	struct kobject *devinfo_kobj = fs_devices->devinfo_kobj;
 
 	nofs_flag = memalloc_nofs_save();
+again:
 	list_for_each_entry(dev, &fs_devices->devices, dev_list) {
 
 		if (one_device && one_device != dev)
@@ -1293,21 +1300,24 @@ int btrfs_sysfs_add_devices_dir(struct btrfs_fs_devices *fs_devices,
 			disk = dev->bdev->bd_part;
 			disk_kobj = &part_to_dev(disk)->kobj;
 
-			error = sysfs_create_link(fs_devices->devices_kobj,
-						  disk_kobj, disk_kobj->name);
+			error = sysfs_create_link(devices_kobj, disk_kobj,
+						  disk_kobj->name);
 			if (error)
 				break;
 		}
 
 		init_completion(&dev->kobj_unregister);
 		error = kobject_init_and_add(&dev->devid_kobj, &devid_ktype,
-					     fs_devices->devinfo_kobj, "%llu",
-					     dev->devid);
+					     devinfo_kobj, "%llu", dev->devid);
 		if (error) {
 			kobject_put(&dev->devid_kobj);
 			break;
 		}
 	}
+	while(fs_devices->seed) {
+		fs_devices = fs_devices->seed;
+		goto again;
+	}
 	memalloc_nofs_restore(nofs_flag);
 
 	return error;
-- 
2.25.1

