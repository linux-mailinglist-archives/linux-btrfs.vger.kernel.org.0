Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 65AC51504CB
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Feb 2020 12:00:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727767AbgBCLAc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 3 Feb 2020 06:00:32 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:40478 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727236AbgBCLAc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 3 Feb 2020 06:00:32 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 013Arirw002463;
        Mon, 3 Feb 2020 11:00:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2019-08-05;
 bh=dROgZUuvjTrigPHObvub3oV/QkO0Sr5+RwSGNc7cnsE=;
 b=ablcXvDakAcx7SYy6UXVCXF0wjGv2uTZcneOI5pgfVVsLBcGaILMf2sJLS701JXpJRDB
 A+Q8cGX/uFtvOdjkmrDwbT9ySZgyBVFx8QWeBpppMrd1cOLxGpPyHauT6HZql7mE54lI
 egwBZl9PGYsONLffPuPi+ApfZlAdtAeD01NOu6UOyflX5HmMK4L4lCXHO/CR3LYz7GO2
 e86mKIFaHkG7duUxMrY1Yt0q/gCO2aF/sfju86qccIGdK5R4+vNedcpirPt7P7orstG7
 QewlI8ngrUMWCu95Q3utDsNn4ABzLCI4BpaWgB7EMaLbGNxJVsXD9y4LYb4Dhw+VCJt9 qA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 2xwyg9b7xt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 03 Feb 2020 11:00:27 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 013ArkBx023833;
        Mon, 3 Feb 2020 11:00:27 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 2xwkg8h6h3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 03 Feb 2020 11:00:26 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 013B0Ord011093;
        Mon, 3 Feb 2020 11:00:24 GMT
Received: from localhost.localdomain (/39.109.145.141)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 03 Feb 2020 03:00:24 -0800
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.com
Subject: [PATCH v5 4/4] btrfs: sysfs, add devid/dev_state kobject and device attribute
Date:   Mon,  3 Feb 2020 19:00:12 +0800
Message-Id: <20200203110012.5954-5-anand.jain@oracle.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200203110012.5954-1-anand.jain@oracle.com>
References: <20200203110012.5954-1-anand.jain@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9519 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2002030083
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9519 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2002030083
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

New sysfs attributes that track the filesystem status of devices, stored
in the per-filesystem directory in /sys/fs/btrfs/FSID/devinfo . There's
a directory for each device, with name corresponding to the numerical
device id.

  in_fs_metadata    - device is in the list of fs metadata
  missing           - device is missing (no device node or block device)
  replace_target    - device is target of replace
  writeable         - writes from fs are allowed

These attributes reflect the state of the device::dev_state and created
at mount time.

Sample output:
  $ pwd
   /sys/fs/btrfs/6e1961f1-5918-4ecc-a22f-948897b409f7/devinfo/1/
  $ ls
    in_fs_metadata  missing  replace_target  writeable
  $ cat missing
    0

The output from these attributes are 0 or 1. 0 indicates unset and 1
indicates set.  These attributes are readonly.

It is observed that the device delete thread and sysfs read thread will
not race because the delete thread calls sysfs kobject_put() which in
turn waits for existing sysfs read to complete.

Note for device replace devid swap:

During the replace the target device temporarily assumes devid 0 before
assigning the devid of the soruce device.

In btrfs_dev_replace_finishing() we remove source sysfs devid using the
function btrfs_sysfs_remove_devices_attr(), so after that call
kobject_rename() to update the devid in the sysfs.  This adds and calls
btrfs_sysfs_update_devid() helper function to update the device id.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
Reviewed-by: David Sterba <dsterba@suse.com>
[ update changelog ]
Signed-off-by: David Sterba <dsterba@suse.com>
---
v5: squash [PATCH] btrfs: update devid after replace
    import changes as in misc-next
      changelog
      rename btrfs_sysfs_xx to btrfs_devinfo_xx
      reorder devinfo attributes
      relocate btrfs_sysfs_update_devid with in sysfs.c
      add device in the title
    rename btrfs_sysfs_missing_show to btrfs_devinfo_missing_show

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
---
 fs/btrfs/dev-replace.c |   1 +
 fs/btrfs/sysfs.c       | 155 +++++++++++++++++++++++++++++++++++------
 fs/btrfs/sysfs.h       |   1 +
 fs/btrfs/volumes.h     |   4 ++
 4 files changed, 138 insertions(+), 23 deletions(-)

diff --git a/fs/btrfs/dev-replace.c b/fs/btrfs/dev-replace.c
index 13a4ebd04a7a..131d23de5f64 100644
--- a/fs/btrfs/dev-replace.c
+++ b/fs/btrfs/dev-replace.c
@@ -744,6 +744,7 @@ static int btrfs_dev_replace_finishing(struct btrfs_fs_info *fs_info,
 
 	/* replace the sysfs entry */
 	btrfs_sysfs_remove_devices_attr(fs_info->fs_devices, src_device);
+	btrfs_sysfs_update_devid(tgt_device);
 	btrfs_rm_dev_replace_free_srcdev(src_device);
 
 	/* write back the superblocks */
diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index 10b9bc551330..364c0db36a3f 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -1158,29 +1158,117 @@ int btrfs_sysfs_remove_devices_attr(struct btrfs_fs_devices *fs_devices,
 	if (!fs_devices->devices_kobj)
 		return -EINVAL;
 
-	if (one_device && one_device->bdev) {
-		disk = one_device->bdev->bd_part;
-		disk_kobj = &part_to_dev(disk)->kobj;
+	if (one_device) {
+		if (one_device->bdev) {
+			disk = one_device->bdev->bd_part;
+			disk_kobj = &part_to_dev(disk)->kobj;
+			sysfs_remove_link(fs_devices->devices_kobj,
+					  disk_kobj->name);
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
+			sysfs_remove_link(fs_devices->devices_kobj,
+					  disk_kobj->name);
+		}
+		kobject_del(&one_device->devid_kobj);
+		kobject_put(&one_device->devid_kobj);
 
-		sysfs_remove_link(fs_devices->devices_kobj, disk_kobj->name);
+		wait_for_completion(&one_device->kobj_unregister);
 	}
 
 	return 0;
 }
 
+static ssize_t btrfs_devinfo_in_fs_metadata_show(struct kobject *kobj,
+						 struct kobj_attribute *a,
+						 char *buf)
+{
+	int val;
+	struct btrfs_device *device = container_of(kobj, struct btrfs_device,
+						   devid_kobj);
+
+	val = !!test_bit(BTRFS_DEV_STATE_IN_FS_METADATA, &device->dev_state);
+
+	return snprintf(buf, PAGE_SIZE, "%d\n", val);
+}
+BTRFS_ATTR(devid, in_fs_metadata, btrfs_devinfo_in_fs_metadata_show);
+
+static ssize_t btrfs_devinfo_missing_show(struct kobject *kobj,
+					  struct kobj_attribute *a, char *buf)
+{
+	int val;
+	struct btrfs_device *device = container_of(kobj, struct btrfs_device,
+						   devid_kobj);
+
+	val = !!test_bit(BTRFS_DEV_STATE_MISSING, &device->dev_state);
+
+	return snprintf(buf, PAGE_SIZE, "%d\n", val);
+}
+BTRFS_ATTR(devid, missing, btrfs_devinfo_missing_show);
+
+static ssize_t btrfs_devinfo_replace_target_show(struct kobject *kobj,
+						 struct kobj_attribute *a,
+						 char *buf)
+{
+	int val;
+	struct btrfs_device *device = container_of(kobj, struct btrfs_device,
+						   devid_kobj);
+
+	val = !!test_bit(BTRFS_DEV_STATE_REPLACE_TGT, &device->dev_state);
+
+	return snprintf(buf, PAGE_SIZE, "%d\n", val);
+}
+BTRFS_ATTR(devid, replace_target, btrfs_devinfo_replace_target_show);
+
+static ssize_t btrfs_devinfo_writeable_show(struct kobject *kobj,
+					    struct kobj_attribute *a, char *buf)
+{
+	int val;
+	struct btrfs_device *device = container_of(kobj, struct btrfs_device,
+						   devid_kobj);
+
+	val = !!test_bit(BTRFS_DEV_STATE_WRITEABLE, &device->dev_state);
+
+	return snprintf(buf, PAGE_SIZE, "%d\n", val);
+}
+BTRFS_ATTR(devid, writeable, btrfs_devinfo_writeable_show);
+
+static struct attribute *devid_attrs[] = {
+	BTRFS_ATTR_PTR(devid, in_fs_metadata),
+	BTRFS_ATTR_PTR(devid, missing),
+	BTRFS_ATTR_PTR(devid, replace_target),
+	BTRFS_ATTR_PTR(devid, writeable),
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
+	.sysfs_ops 	= &kobj_sysfs_ops,
+	.default_groups = devid_groups,
+	.release 	= btrfs_release_devid_kobj,
+};
+
 int btrfs_sysfs_add_devices_attr(struct btrfs_fs_devices *fs_devices,
 				 struct btrfs_device *one_device)
 {
@@ -1188,22 +1276,31 @@ int btrfs_sysfs_add_devices_attr(struct btrfs_fs_devices *fs_devices,
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
+
+			error = sysfs_create_link(fs_devices->devices_kobj,
+						  disk_kobj, disk_kobj->name);
+			if (error)
+				break;
+		}
 
-		error = sysfs_create_link(fs_devices->devices_kobj,
-					  disk_kobj, disk_kobj->name);
-		if (error)
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
@@ -1235,6 +1332,18 @@ void btrfs_sysfs_update_sprout_fsid(struct btrfs_fs_devices *fs_devices,
 				"sysfs: failed to create fsid for sprout");
 }
 
+void btrfs_sysfs_update_devid(struct btrfs_device *device)
+{
+	char tmp[24];
+
+	snprintf(tmp, sizeof(tmp), "%llu", device->devid);
+
+	if (kobject_rename(&device->devid_kobj, tmp))
+		btrfs_warn(device->fs_devices->fs_info,
+			   "sysfs: failed to update devid for %llu",
+			   device->devid);
+}
+
 /* /sys/fs/btrfs/ entry */
 static struct kset *btrfs_kset;
 
diff --git a/fs/btrfs/sysfs.h b/fs/btrfs/sysfs.h
index 9d97b3c8db4e..ccf33eaf9e59 100644
--- a/fs/btrfs/sysfs.h
+++ b/fs/btrfs/sysfs.h
@@ -34,5 +34,6 @@ void btrfs_sysfs_add_block_group_type(struct btrfs_block_group *cache);
 int btrfs_sysfs_add_space_info_type(struct btrfs_fs_info *fs_info,
 				    struct btrfs_space_info *space_info);
 void btrfs_sysfs_remove_space_info(struct btrfs_space_info *space_info);
+void btrfs_sysfs_update_devid(struct btrfs_device *device);
 
 #endif
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index 98535f1e208e..309cda477589 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -136,6 +136,10 @@ struct btrfs_device {
 	atomic_t dev_stat_values[BTRFS_DEV_STAT_VALUES_MAX];
 
 	struct extent_io_tree alloc_state;
+
+	struct completion kobj_unregister;
+	/* For sysfs/FSID/devinfo/devid/ */
+	struct kobject devid_kobj;
 };
 
 /*
-- 
2.23.0

