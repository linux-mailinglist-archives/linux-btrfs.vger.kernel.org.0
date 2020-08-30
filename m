Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBB21256EB2
	for <lists+linux-btrfs@lfdr.de>; Sun, 30 Aug 2020 16:42:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727852AbgH3OmF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 30 Aug 2020 10:42:05 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:59070 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726845AbgH3Olb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 30 Aug 2020 10:41:31 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07UEZ5gl087948;
        Sun, 30 Aug 2020 14:41:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=LGvMGpCp0x+cFiqWb67lSF/6uZrbLrxkw79QuduH+Iw=;
 b=V8nBH1kHh9NFS2S4f6Mv5lpsvVIFeC0UO7SG0oCtb0cW6N0qeKN1szTiaE1buln4FB/N
 29duVOyzxuOdivFSVlQS9P+bvzvjrfMwXGiz3HtMBivQJDkfeRPwWmxewkY36o1UGXDT
 kFjKRhVXiUxM1S3IQqMzdQEDoPkdvw4wLtME+EelMm4tY1dAdLTmP3nDgBhuosLvVbfN
 TfsEXXcV1a5qzt20tjF7feYfGSPOPjj+rdJccjBveoEbI2LOCUF63UBkoUeZ8wy+xnWP
 5fDDsRY0nbydqAHAXyhst+SgWJvElMvofRlhEF569szT3O/VZJm1Q8vYygWkPGOK+Kc6 HA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 337eyktyce-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 30 Aug 2020 14:41:22 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07UEZZxo153459;
        Sun, 30 Aug 2020 14:41:21 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 3380xtr3uw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 30 Aug 2020 14:41:21 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 07UEfLaN002494;
        Sun, 30 Aug 2020 14:41:21 GMT
Received: from localhost.localdomain (/39.109.231.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 30 Aug 2020 07:41:20 -0700
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.com, josef@toxicpanda.com
Subject: [PATCH 01/11] btrfs: initialize sysfs devid and device link for seed device
Date:   Sun, 30 Aug 2020 22:40:56 +0800
Message-Id: <2db650ec206db1cb3e68590951b59e222fb10116.1598792561.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1598792561.git.anand.jain@oracle.com>
References: <cover.1598792561.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9729 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 phishscore=0
 malwarescore=0 bulkscore=0 mlxscore=0 mlxlogscore=999 suspectscore=1
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008300118
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9729 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 adultscore=0
 priorityscore=1501 phishscore=0 mlxlogscore=999 mlxscore=0
 lowpriorityscore=0 clxscore=1015 spamscore=0 bulkscore=0 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008300118
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
 fs/btrfs/sysfs.c | 146 ++++++++++++++++++++++++++++++-----------------
 1 file changed, 93 insertions(+), 53 deletions(-)

diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index 190e59152be5..9b5e58091fae 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -1149,45 +1149,48 @@ int btrfs_sysfs_add_space_info_type(struct btrfs_fs_info *fs_info,
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
+				   struct btrfs_device *device)
+{
+	struct btrfs_fs_devices *seed_fs_devices;
+
+	if (device) {
+		btrfs_sysfs_remove_device(device);
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
+	list_for_each_entry(device, &fs_devices->devices, dev_list)
+		btrfs_sysfs_remove_device(device);
 
-		wait_for_completion(&one_device->kobj_unregister);
+	list_for_each_entry(seed_fs_devices, &fs_devices->seed_list, seed_list) {
+		list_for_each_entry(device, &seed_fs_devices->devices, dev_list)
+			btrfs_sysfs_remove_device(device);
 	}
 
 	return 0;
@@ -1271,44 +1274,81 @@ static struct kobj_type devid_ktype = {
 	.release	= btrfs_release_devid_kobj,
 };
 
+static int btrfs_sysfs_add_device(struct btrfs_device *device)
+{
+	int ret;
+	struct kobject *devices_kobj;
+        struct kobject *devinfo_kobj;
+
+	/*
+	 * make sure we use the fs_info::fs_devices to fetch the kobjects
+	 * even for the seed fs_devices
+	 */
+	devices_kobj = device->fs_devices->fs_info->fs_devices->devices_kobj;
+	devinfo_kobj = device->fs_devices->fs_info->fs_devices->devinfo_kobj;
+	ASSERT(devices_kobj);
+	ASSERT(devinfo_kobj);
+
+	if (device->bdev) {
+		struct hd_struct *disk;
+		struct kobject *disk_kobj;
+
+		disk = device->bdev->bd_part;
+		disk_kobj = &part_to_dev(disk)->kobj;
+
+		ret = sysfs_create_link(devices_kobj, disk_kobj,
+					disk_kobj->name);
+		if (ret) {
+			btrfs_warn(device->fs_info,
+			   "sysfs create device link failed %d devid %llu",
+				   ret, device->devid);
+			return ret;
+		}
+	}
+
+	init_completion(&device->kobj_unregister);
+	ret = kobject_init_and_add(&device->devid_kobj, &devid_ktype,
+				   devinfo_kobj, "%llu", device->devid);
+	if (ret) {
+		kobject_put(&device->devid_kobj);
+		btrfs_warn(device->fs_info,
+			   "sysfs devinfo init failed %d devid %llu",
+			   ret, device->devid);
+	}
+
+	return ret;
+}
+
 int btrfs_sysfs_add_devices_dir(struct btrfs_fs_devices *fs_devices,
-				struct btrfs_device *one_device)
+				struct btrfs_device *device)
 {
-	int error = 0;
-	struct btrfs_device *dev;
+	int ret = 0;
 	unsigned int nofs_flag;
+	struct btrfs_fs_devices *seed_fs_devices;
 
 	nofs_flag = memalloc_nofs_save();
-	list_for_each_entry(dev, &fs_devices->devices, dev_list) {
 
-		if (one_device && one_device != dev)
-			continue;
+	if (device)
+		return btrfs_sysfs_add_device(device);
 
-		if (dev->bdev) {
-			struct hd_struct *disk;
-			struct kobject *disk_kobj;
-
-			disk = dev->bdev->bd_part;
-			disk_kobj = &part_to_dev(disk)->kobj;
-
-			error = sysfs_create_link(fs_devices->devices_kobj,
-						  disk_kobj, disk_kobj->name);
-			if (error)
-				break;
-		}
+	list_for_each_entry(device, &fs_devices->devices, dev_list) {
+		ret = btrfs_sysfs_add_device(device);
+		if (ret)
+			goto out;
+	}
 
-		init_completion(&dev->kobj_unregister);
-		error = kobject_init_and_add(&dev->devid_kobj, &devid_ktype,
-					     fs_devices->devinfo_kobj, "%llu",
-					     dev->devid);
-		if (error) {
-			kobject_put(&dev->devid_kobj);
-			break;
+	list_for_each_entry(seed_fs_devices, &fs_devices->seed_list, seed_list) {
+		list_for_each_entry(device, &seed_fs_devices->devices, dev_list) {
+			ret = btrfs_sysfs_add_device(device);
+			if (ret)
+				goto out;
 		}
 	}
+
+out:
 	memalloc_nofs_restore(nofs_flag);
 
-	return error;
+	return ret;
 }
 
 void btrfs_kobject_uevent(struct block_device *bdev, enum kobject_action action)
-- 
2.25.1

