Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 98851116E9F
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Dec 2019 15:08:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727861AbfLIOI0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 9 Dec 2019 09:08:26 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:51974 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727388AbfLIOI0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 9 Dec 2019 09:08:26 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xB9E5S3u128649;
        Mon, 9 Dec 2019 14:08:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2019-08-05;
 bh=Oofb54DPSCEnqGrAOU/mi6rqShSxWgUS85OSzdRqR50=;
 b=RfbSpwWtE9AavnHhn+Iap3aGgBdM536Pi+8qhDpniM4Rladxvc/HOVMLJF0dmk7Fg3hh
 btKa1+/F0n4ab3oi3fXAQPs4mObl3LmIlp6mU4vzTbP7DJwoGsukNKNHkZinKXcwNb3S
 BI47FV34+k+CxjSw+YWjP2jky11f/6L7BhArv5OlQQEEzHkgxGoo+8G+1egT0D9s4CvR
 C/NABnGgL4SO6f5VV5o00ns5OID98MLEqBG9vWW6eCIp6oguPozLSnQobTc7GmktvYvN
 I1rRz/pdEbJBq0uxpV8/kwHuKX+Ea52Ypw0uv36+7w98FX/fBLRHWtMNy6fmx2sY6Urg BQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 2wrw4mvk6b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 09 Dec 2019 14:08:22 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xB9E5HB1179126;
        Mon, 9 Dec 2019 14:06:21 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 2wrp85bd96-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 09 Dec 2019 14:06:21 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xB9E6J9T028944;
        Mon, 9 Dec 2019 14:06:20 GMT
Received: from tp.localdomain (/39.109.145.141)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 09 Dec 2019 06:06:19 -0800
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.cz
Subject: [PATCH v2 4/4] btrfs: sysfs, add devid/dev_state kobject and attribute
Date:   Mon,  9 Dec 2019 22:06:05 +0800
Message-Id: <1575900365-19509-1-git-send-email-anand.jain@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <20191205112706.8125-5-anand.jain@oracle.com>
References: <20191205112706.8125-5-anand.jain@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9465 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1912090122
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9465 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1912090122
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

New sysfs attributes
  in_fs_metadata  missing  replace_target  writeable
are added under a new kobject
  UUID/devinfo/<devid>

These attributes reflects the state of the device from the kernel
fed by %btrfs_device::dev_state.
These attributes are born during mount and goes along with the dynamic
nature of the device add and delete, otherwise these attribute and kobject
gets deleted at unmount.

Sample output:
pwd
 /sys/fs/btrfs/6e1961f1-5918-4ecc-a22f-948897b409f7/devinfo/1/
ls
  in_fs_metadata  missing  replace_target  writeable
cat missing
  0

The output from these attributes are 0 or 1. 0 indicates unset and 1
indicates set.

As of now these attributes are readonly.

It is observed that the device delete thread and sysfs read thread will
not race because the delete thread calls sysfs kobject_put() which in turn
waits for existing sysfs read to complete.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
V2:
  Make the devinfo attribute to carry one parameter, so now
  instead of dev_state attribute, we create in_fs_metadata,
  writeable, missing and replace_target attributes.

 fs/btrfs/sysfs.c   | 127 +++++++++++++++++++++++++++++++++++++++++++----------
 fs/btrfs/volumes.h |   2 +
 2 files changed, 106 insertions(+), 23 deletions(-)

diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index 834f712ed60c..bace9cda433a 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -978,29 +978,102 @@ int btrfs_sysfs_remove_devices_attr(struct btrfs_fs_devices *fs_devices,
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
 
+static ssize_t btrfs_sysfs_writeable_show(struct kobject *kobj,
+					  struct kobj_attribute *a, char *buf)
+{
+	int val;
+	struct btrfs_device *device = container_of(kobj, struct btrfs_device,
+						   devid_kobj);
+
+	val = test_bit(BTRFS_DEV_STATE_WRITEABLE, &device->dev_state) ? 1 : 0;
+
+	return snprintf(buf, PAGE_SIZE, "%d\n", val);
+}
+BTRFS_ATTR(, writeable, btrfs_sysfs_writeable_show);
+
+static ssize_t btrfs_sysfs_in_fs_metadata_show(struct kobject *kobj,
+					       struct kobj_attribute *a,
+					       char *buf)
+{
+	int val;
+	struct btrfs_device *device = container_of(kobj, struct btrfs_device,
+						   devid_kobj);
+
+	val = test_bit(BTRFS_DEV_STATE_IN_FS_METADATA,
+		       &device->dev_state) ? 1 : 0;
+
+	return snprintf(buf, PAGE_SIZE, "%d\n", val);
+}
+BTRFS_ATTR(, in_fs_metadata, btrfs_sysfs_in_fs_metadata_show);
+
+static ssize_t btrfs_sysfs_missing_show(struct kobject *kobj,
+					struct kobj_attribute *a, char *buf)
+{
+	int val;
+	struct btrfs_device *device = container_of(kobj, struct btrfs_device,
+						   devid_kobj);
+
+	val = test_bit(BTRFS_DEV_STATE_MISSING, &device->dev_state) ? 1 : 0;
+
+	return snprintf(buf, PAGE_SIZE, "%d\n", val);
+}
+BTRFS_ATTR(, missing, btrfs_sysfs_missing_show);
+
+static ssize_t btrfs_sysfs_replace_target_show(struct kobject *kobj,
+					       struct kobj_attribute *a,
+					       char *buf)
+{
+	int val;
+	struct btrfs_device *device = container_of(kobj, struct btrfs_device,
+						   devid_kobj);
+
+	val = test_bit(BTRFS_DEV_STATE_REPLACE_TGT, &device->dev_state) ? 1 : 0;
+
+	return snprintf(buf, PAGE_SIZE, "%d\n", val);
+}
+BTRFS_ATTR(, replace_target, btrfs_sysfs_replace_target_show);
+
+static struct attribute *devinfo_attrs[] = {
+	BTRFS_ATTR_PTR(, writeable),
+	BTRFS_ATTR_PTR(, in_fs_metadata),
+	BTRFS_ATTR_PTR(, missing),
+	BTRFS_ATTR_PTR(, replace_target),
+	NULL
+};
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
@@ -1008,22 +1081,30 @@ int btrfs_sysfs_add_devices_attr(struct btrfs_fs_devices *fs_devices,
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
1.8.3.1

