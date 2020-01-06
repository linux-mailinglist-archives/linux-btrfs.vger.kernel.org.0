Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 07D2113117B
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Jan 2020 12:39:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726281AbgAFLjP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 6 Jan 2020 06:39:15 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:46748 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725787AbgAFLjP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 6 Jan 2020 06:39:15 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 006BdEdh082498
        for <linux-btrfs@vger.kernel.org>; Mon, 6 Jan 2020 11:39:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references; s=corp-2019-08-05;
 bh=cXD2oy037+6uAWKMOdkzGrS8FHkzwBU+/2AF/SPwjrM=;
 b=gTBmhiyKNdb9zGOt+cVOpVpfzZfoj03ObQEooFyZ5opZ81CweWO5R65o+/wy5p4SmKmJ
 qV6BpO7EoJY2l1+ubWsKl4D62ZXCM5zxaelcTdYJ3DK1bEdFx8eHTp9uhRysYyHVUTAa
 PME+bQJi873LfKmVt8kjnRHBK8ASw14ggqu5bnP11Ar6ZLHD2VRbTO740sGPLvR8qLsq
 r+XEx/DBpVzAs+ITx4URaNT0pPdv4EGcZpS7RmSC2G6U/KpxMMDk5527OYkEj0A258X7
 ooqxcEAaxT98Wy9Q/95PMCuMTpNbeLPj5hLAw5x6qZCgWTi16BMhNEMtONuWjixvb0pe 1A== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 2xajnpppaq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Mon, 06 Jan 2020 11:39:13 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 006BdCJu183788
        for <linux-btrfs@vger.kernel.org>; Mon, 6 Jan 2020 11:39:13 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 2xb4unp8e2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Mon, 06 Jan 2020 11:39:12 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 006Bcfdc005580
        for <linux-btrfs@vger.kernel.org>; Mon, 6 Jan 2020 11:38:43 GMT
Received: from tp.wifi.oracle.com (/192.188.170.104)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 06 Jan 2020 03:38:41 -0800
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v4] btrfs: sysfs, add devid/dev_state kobject and attribute
Date:   Mon,  6 Jan 2020 19:38:31 +0800
Message-Id: <1578310711-20887-1-git-send-email-anand.jain@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <20191205112706.8125-5-anand.jain@oracle.com>
References: <20191205112706.8125-5-anand.jain@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9491 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001060107
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9491 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001060107
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
v4:
   after patch
   [PATCH v5 2/2] btrfs: reset device back to allocation state when removing
   in misc-next, the device::devid_kobj remains stale, fix it by using
   release.

v3:
  Use optional groupid devid in BTRFS_ATTR(), it was blank in v2.

V2:
  Make the devinfo attribute to carry one parameter, so now
  instead of dev_state attribute, we create in_fs_metadata,
  writeable, missing and replace_target attributes.

 fs/btrfs/sysfs.c   | 142 ++++++++++++++++++++++++++++++++++++++++++++---------
 fs/btrfs/volumes.h |   3 ++
 2 files changed, 122 insertions(+), 23 deletions(-)

diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index 834f712ed60c..18dac99188ce 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -978,29 +978,116 @@ int btrfs_sysfs_remove_devices_attr(struct btrfs_fs_devices *fs_devices,
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
+
+		wait_for_completion(&one_device->kobj_unregister);
 
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
+
+		if (one_device->bdev) {
+			disk = one_device->bdev->bd_part;
+			disk_kobj = &part_to_dev(disk)->kobj;
+			sysfs_remove_link(fs_devices->devices_kobj, disk_kobj->name);
+		}
+		kobject_del(&one_device->devid_kobj);
+		kobject_put(&one_device->devid_kobj);
 
-		sysfs_remove_link(fs_devices->devices_kobj, disk_kobj->name);
+		wait_for_completion(&one_device->kobj_unregister);
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
+BTRFS_ATTR(devid, writeable, btrfs_sysfs_writeable_show);
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
+BTRFS_ATTR(devid, in_fs_metadata, btrfs_sysfs_in_fs_metadata_show);
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
+BTRFS_ATTR(devid, missing, btrfs_sysfs_missing_show);
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
+BTRFS_ATTR(devid, replace_target, btrfs_sysfs_replace_target_show);
+
+static struct attribute *devid_attrs[] = {
+	BTRFS_ATTR_PTR(devid, writeable),
+	BTRFS_ATTR_PTR(devid, in_fs_metadata),
+	BTRFS_ATTR_PTR(devid, missing),
+	BTRFS_ATTR_PTR(devid, replace_target),
+	NULL
+};
+ATTRIBUTE_GROUPS(devid);
+
+static void btrfs_release_devid_kobj(struct kobject *kobj)
+{
+	struct btrfs_device *device = container_of(kobj, struct btrfs_device,
+						   devid_kobj);
+
+	memset(&device->devid_kobj, 0, sizeof(struct kobject));
+	complete(&device->kobj_unregister);
+}
+
+static struct kobj_type devid_ktype = {
+	.sysfs_ops = &kobj_sysfs_ops,
+	.default_groups = devid_groups,
+	.release = btrfs_release_devid_kobj,
+};
+
 int btrfs_sysfs_add_devices_attr(struct btrfs_fs_devices *fs_devices,
 				 struct btrfs_device *one_device)
 {
@@ -1008,22 +1095,31 @@ int btrfs_sysfs_add_devices_attr(struct btrfs_fs_devices *fs_devices,
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
+		init_completion(&dev->kobj_unregister);
+		error = kobject_init_and_add(&dev->devid_kobj, &devid_ktype,
+					     fs_devices->devinfo_kobj, "%llu",
+					     dev->devid);
+		if (error) {
+			kobject_put(&dev->devid_kobj);
 			break;
+		}
 	}
 
 	return error;
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index 38f2e8437b68..da9c6e1b843a 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -138,6 +138,9 @@ struct btrfs_device {
 	atomic_t dev_stat_values[BTRFS_DEV_STAT_VALUES_MAX];
 
 	struct extent_io_tree alloc_state;
+
+	struct completion kobj_unregister;
+	struct kobject devid_kobj;
 };
 
 /*
-- 
1.8.3.1

