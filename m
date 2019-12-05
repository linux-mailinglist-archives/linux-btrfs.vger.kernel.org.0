Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C9487114010
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Dec 2019 12:27:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729087AbfLEL1V (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 5 Dec 2019 06:27:21 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:35828 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728735AbfLEL1V (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 5 Dec 2019 06:27:21 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xB5BJ8Rf067956
        for <linux-btrfs@vger.kernel.org>; Thu, 5 Dec 2019 11:27:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2019-08-05;
 bh=YAhVpkDxn+jVk8i1zrUbZEn4rso2BVIzfmiRP0W39sI=;
 b=ik3IsTsX9vZiWe/xyA7aUC8n22EkXSCif/eZKK9Lsm9uYR7SESGHQ4FjaeARFp+a/+8p
 j2SJGGj+FEeVmS3LkDly07MotjpBeSsjKw8daYfL5ClCam1TGlUro+ZaXTVuIQgQmQYe
 vCGKHZr8s+X9MAz0OVRUYIHjPio7upNUqlb4S/azS+UvKIsaG/oOBvYar2qcl1AA6W/q
 kZb8v9HgMB/awiCxxZmk+H1be16dMeiH5bXGsebl8n8DpuTQO1Khszcf8XPkSqrR0TaB
 3shNasQ21Dp5Ou5KYKh0k/1MhLz9hcXBNEDC5Lm0xN2BIT2/qX/+0cDt5AW4v1FM36u7 CA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 2wkgcqmev6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Thu, 05 Dec 2019 11:27:19 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xB5BNWhN071910
        for <linux-btrfs@vger.kernel.org>; Thu, 5 Dec 2019 11:27:18 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 2wpp73ygnn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Thu, 05 Dec 2019 11:27:18 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xB5BRHlT007886
        for <linux-btrfs@vger.kernel.org>; Thu, 5 Dec 2019 11:27:17 GMT
Received: from localhost.localdomain (/39.109.145.141)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 05 Dec 2019 03:27:17 -0800
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 4/4] btrfs: sysfs, add devid/dev_state kobject and attribute
Date:   Thu,  5 Dec 2019 19:27:06 +0800
Message-Id: <20191205112706.8125-5-anand.jain@oracle.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191205112706.8125-1-anand.jain@oracle.com>
References: <20191205112706.8125-1-anand.jain@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9461 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1912050094
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9461 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1912050094
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

A new sysfs RW attribute
  UUID/devinfo/<devid>/dev_state
is added here. The dev_state here reflects the state of the device from
the kernel parameter btrfs_device::dev_state and this attribute is born
after the device is mounted and goes along with the dynamic nature of the
device add and delete. This attribute gets deleted at unmount.

For example:
pwd
 /sys/fs/btrfs/6e1961f1-5918-4ecc-a22f-948897b409f7/devinfo
cat 1/dev_state
 IN_FS_METADATA MISSING
cat 2/dev_state
 WRITABLE IN_FS_METADATA

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 fs/btrfs/sysfs.c   | 101 ++++++++++++++++++++++++++++++++++-----------
 fs/btrfs/volumes.h |   2 +
 2 files changed, 80 insertions(+), 23 deletions(-)

diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index 834f712ed60c..99c7269e0524 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -978,29 +978,76 @@ int btrfs_sysfs_remove_devices_attr(struct btrfs_fs_devices *fs_devices,
 	if (!fs_devices->devices_kobj)
 		return -EINVAL;
 
-	if (one_device && one_device->bdev) {
-		disk = one_device->bdev->bd_part;
-		disk_kobj = &part_to_dev(disk)->kobj;
+	if (one_device) {
+		if (one_device->bdev) {
+			disk = one_device->bdev->bd_part;
+			disk_kobj = &part_to_dev(disk)->kobj;
+			sysfs_remove_link(fs_devices->devices_kobj, disk_kobj->name);
+		}
 
-		sysfs_remove_link(fs_devices->devices_kobj, disk_kobj->name);
-	}
+		kobject_del(&one_device->devid_kobj);
+		kobject_put(&one_device->devid_kobj);
 
-	if (one_device)
 		return 0;
+	}
 
-	list_for_each_entry(one_device,
-			&fs_devices->devices, dev_list) {
-		if (!one_device->bdev)
-			continue;
-		disk = one_device->bdev->bd_part;
-		disk_kobj = &part_to_dev(disk)->kobj;
+	list_for_each_entry(one_device, &fs_devices->devices, dev_list) {
 
-		sysfs_remove_link(fs_devices->devices_kobj, disk_kobj->name);
+		if (one_device->bdev) {
+			disk = one_device->bdev->bd_part;
+			disk_kobj = &part_to_dev(disk)->kobj;
+			sysfs_remove_link(fs_devices->devices_kobj, disk_kobj->name);
+		}
+		kobject_del(&one_device->devid_kobj);
+		kobject_put(&one_device->devid_kobj);
 	}
 
 	return 0;
 }
 
+static void btrfs_dev_state_to_str(struct btrfs_device *device, char *dev_state_str, size_t n)
+{
+	int state;
+	const char *btrfs_dev_states[] = { "WRITEABLE", "IN_FS_METADATA",
+					   "MISSING", "REPLACE_TGT", "FLUSHING"
+					 };
+
+	n = n - strlen(dev_state_str) - 1;
+
+	for (state = 0; state < ARRAY_SIZE(btrfs_dev_states); state++) {
+		if (test_bit(state, &device->dev_state)) {
+			if (strlen(dev_state_str))
+				strncat(dev_state_str, " ", n);
+			strncat(dev_state_str, btrfs_dev_states[state], n);
+		}
+	}
+	strncat(dev_state_str, "\n", n);
+}
+
+static ssize_t btrfs_sysfs_dev_state_show(struct kobject *kobj,
+					  struct kobj_attribute *a, char *buf)
+{
+	struct btrfs_device *device = container_of(kobj, struct btrfs_device,
+						   devid_kobj);
+
+	btrfs_dev_state_to_str(device, buf, PAGE_SIZE);
+	return strlen(buf);
+}
+
+BTRFS_ATTR(, dev_state, btrfs_sysfs_dev_state_show);
+
+static struct attribute *devinfo_attrs[] = {
+	BTRFS_ATTR_PTR(, dev_state),
+	NULL
+};
+
+ATTRIBUTE_GROUPS(devinfo);
+
+static struct kobj_type devinfo_ktype = {
+	.sysfs_ops = &kobj_sysfs_ops,
+	.default_groups = devinfo_groups,
+};
+
 int btrfs_sysfs_add_devices_attr(struct btrfs_fs_devices *fs_devices,
 				 struct btrfs_device *one_device)
 {
@@ -1008,22 +1055,30 @@ int btrfs_sysfs_add_devices_attr(struct btrfs_fs_devices *fs_devices,
 	struct btrfs_device *dev;
 
 	list_for_each_entry(dev, &fs_devices->devices, dev_list) {
-		struct hd_struct *disk;
-		struct kobject *disk_kobj;
-
-		if (!dev->bdev)
-			continue;
 
 		if (one_device && one_device != dev)
 			continue;
 
-		disk = dev->bdev->bd_part;
-		disk_kobj = &part_to_dev(disk)->kobj;
+		if (dev->bdev) {
+			struct hd_struct *disk;
+			struct kobject *disk_kobj;
+
+			disk = dev->bdev->bd_part;
+			disk_kobj = &part_to_dev(disk)->kobj;
 
-		error = sysfs_create_link(fs_devices->devices_kobj,
-					  disk_kobj, disk_kobj->name);
-		if (error)
+			error = sysfs_create_link(fs_devices->devices_kobj,
+						  disk_kobj, disk_kobj->name);
+			if (error)
+				break;
+		}
+
+		error = kobject_init_and_add(&dev->devid_kobj, &devinfo_ktype,
+					     fs_devices->devinfo_kobj, "%llu",
+					     dev->devid);
+		if (error) {
+			kobject_put(&dev->devid_kobj);
 			break;
+		}
 	}
 
 	return error;
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index 38f2e8437b68..68021d1ee216 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -138,6 +138,8 @@ struct btrfs_device {
 	atomic_t dev_stat_values[BTRFS_DEV_STAT_VALUES_MAX];
 
 	struct extent_io_tree alloc_state;
+
+	struct kobject devid_kobj;
 };
 
 /*
-- 
2.23.0

