Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4676A25E0E7
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Sep 2020 19:35:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727947AbgIDRfP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 4 Sep 2020 13:35:15 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:42116 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727867AbgIDRfK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 4 Sep 2020 13:35:10 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 084HYOOv073970;
        Fri, 4 Sep 2020 17:35:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=ohTEUwJ/ZrMg9MpeiMqaT5kMAtpxvx0Kj6gnuihPwng=;
 b=MVL/dQ+G6rFU2ZHfAzHO+GDa3+iBXlxuVZqHHnvhxLvsC+7PRtTI/ad6f5SyjyrZ4gV0
 hhRg4Tw5/7X2JmJp0aIzR24sv4LoYKjreAn3ExyxDjP4a1frvRMKXwxbW+QUUcVvYwHP
 W+hTE2fufhZirZosh8NNmUND3onuY7RRWeb6V4WMFZuX/W1+eJ+eOIysAhf448aYQm33
 t5KsO+V+Fq4X7B+yAwWkzoovVXkRgwm4GWHDDPwls2LkNnOsoksDhS7RhPKslYywLQxW
 oZWeVq2nHfObOdHsiBKPvtqCSAVTWngm/PiiBixydec/qhJ1KLnfjhAahwW+1Q6dQda7 AQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 337eymqmha-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 04 Sep 2020 17:35:05 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 084HVDwl171497;
        Fri, 4 Sep 2020 17:35:05 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 33bhs4tc1x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 04 Sep 2020 17:35:05 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 084HZ4jA015549;
        Fri, 4 Sep 2020 17:35:04 GMT
Received: from localhost.localdomain (/39.109.231.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 04 Sep 2020 10:35:03 -0700
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.com, josef@toxicpanda.com, nborisov@suse.com
Subject: [PATCH 07/16] btrfs: refactor btrfs_sysfs_remove_devices_dir
Date:   Sat,  5 Sep 2020 01:34:27 +0800
Message-Id: <2999426cdd9713f6871b99598899fa69f4819725.1599234146.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1599234146.git.anand.jain@oracle.com>
References: <cover.1599234146.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9734 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 bulkscore=0
 mlxlogscore=999 spamscore=0 adultscore=0 suspectscore=3 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009040152
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9734 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 adultscore=0
 priorityscore=1501 phishscore=0 mlxlogscore=999 mlxscore=0
 lowpriorityscore=0 clxscore=1015 spamscore=0 bulkscore=0 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009040152
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Similar to btrfs_sysfs_add_devices_dir()'s refactor, refactor
btrfs_sysfs_remove_devices_dir() so that we don't have to use the 2nd
argument to indicate whether to free all devices or just one device.

Make btrfs_sysfs_remove_device() global as device operations outside of
sysfs.c now calls this instead of btrfs_sysfs_remove_devices_dir().

btrfs_sysfs_remove_devices_dir() is renamed to
btrfs_sysfs_remove_fs_devices() to suite its new role.

Now, no one outside of sysfs.c calls btrfs_sysfs_remove_fs_devices()
so it is redeclared as static. And the same function had to be moved
before its first caller.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
Reviewed-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/dev-replace.c |  2 +-
 fs/btrfs/sysfs.c       | 27 +++++++++++----------------
 fs/btrfs/sysfs.h       |  3 +--
 fs/btrfs/volumes.c     |  8 ++++----
 4 files changed, 17 insertions(+), 23 deletions(-)

diff --git a/fs/btrfs/dev-replace.c b/fs/btrfs/dev-replace.c
index 2e54b8f4d053..70b4385a327c 100644
--- a/fs/btrfs/dev-replace.c
+++ b/fs/btrfs/dev-replace.c
@@ -743,7 +743,7 @@ static int btrfs_dev_replace_finishing(struct btrfs_fs_info *fs_info,
 	mutex_unlock(&fs_info->fs_devices->device_list_mutex);
 
 	/* replace the sysfs entry */
-	btrfs_sysfs_remove_devices_dir(fs_info->fs_devices, src_device);
+	btrfs_sysfs_remove_device(src_device);
 	btrfs_sysfs_update_devid(tgt_device);
 	if (test_bit(BTRFS_DEV_STATE_WRITEABLE, &src_device->dev_state))
 		btrfs_scratch_superblocks(fs_info, src_device->bdev,
diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index 1da1c3ba2143..c5b8870b12bf 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -935,6 +935,14 @@ void btrfs_sysfs_remove_fsid(struct btrfs_fs_devices *fs_devs)
 	}
 }
 
+void btrfs_sysfs_remove_fs_devices(struct btrfs_fs_devices *fs_devices)
+{
+	struct btrfs_device *device;
+
+	list_for_each_entry(device, &fs_devices->devices, dev_list)
+		btrfs_sysfs_remove_device(device);
+}
+
 void btrfs_sysfs_remove_mounted(struct btrfs_fs_info *fs_info)
 {
 	struct kobject *fsid_kobj = &fs_info->fs_devices->fsid_kobj;
@@ -962,7 +970,7 @@ void btrfs_sysfs_remove_mounted(struct btrfs_fs_info *fs_info)
 	addrm_unknown_feature_attrs(fs_info, false);
 	sysfs_remove_group(fsid_kobj, &btrfs_feature_attr_group);
 	sysfs_remove_files(fsid_kobj, btrfs_attrs);
-	btrfs_sysfs_remove_devices_dir(fs_info->fs_devices, NULL);
+	btrfs_sysfs_remove_fs_devices(fs_info->fs_devices);
 }
 
 static const char * const btrfs_feature_set_names[FEAT_MAX] = {
@@ -1149,7 +1157,7 @@ int btrfs_sysfs_add_space_info_type(struct btrfs_fs_info *fs_info,
 	return 0;
 }
 
-static void btrfs_sysfs_remove_device(struct btrfs_device *device)
+void btrfs_sysfs_remove_device(struct btrfs_device *device)
 {
 	struct hd_struct *disk;
 	struct kobject *disk_kobj;
@@ -1175,19 +1183,6 @@ static void btrfs_sysfs_remove_device(struct btrfs_device *device)
 	}
 }
 
-/* when 2nd argument device is NULL, it removes all devices link */
-void btrfs_sysfs_remove_devices_dir(struct btrfs_fs_devices *fs_devices,
-				    struct btrfs_device *one_device)
-{
-	if (one_device) {
-		btrfs_sysfs_remove_device(one_device);
-		return;
-	}
-
-	list_for_each_entry(one_device, &fs_devices->devices, dev_list)
-		btrfs_sysfs_remove_device(one_device);
-}
-
 static ssize_t btrfs_devinfo_in_fs_metadata_show(struct kobject *kobj,
 					         struct kobj_attribute *a,
 					         char *buf)
@@ -1423,7 +1418,7 @@ int btrfs_sysfs_add_mounted(struct btrfs_fs_info *fs_info)
 
 	error = sysfs_create_files(fsid_kobj, btrfs_attrs);
 	if (error) {
-		btrfs_sysfs_remove_devices_dir(fs_devs, NULL);
+		btrfs_sysfs_remove_fs_devices(fs_devs);
 		return error;
 	}
 
diff --git a/fs/btrfs/sysfs.h b/fs/btrfs/sysfs.h
index 56c29257b5a7..bacef43f7267 100644
--- a/fs/btrfs/sysfs.h
+++ b/fs/btrfs/sysfs.h
@@ -15,8 +15,7 @@ enum btrfs_feature_set {
 char *btrfs_printable_features(enum btrfs_feature_set set, u64 flags);
 const char *btrfs_feature_set_name(enum btrfs_feature_set set);
 int btrfs_sysfs_add_device(struct btrfs_device *device);
-void btrfs_sysfs_remove_devices_dir(struct btrfs_fs_devices *fs_devices,
-				    struct btrfs_device *one_device);
+void btrfs_sysfs_remove_device(struct btrfs_device *device);
 int btrfs_sysfs_add_fsid(struct btrfs_fs_devices *fs_devs);
 void btrfs_sysfs_remove_fsid(struct btrfs_fs_devices *fs_devs);
 void btrfs_sysfs_update_sprout_fsid(struct btrfs_fs_devices *fs_devices);
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index f858c4d9a6ae..afdde29bce34 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -2039,7 +2039,7 @@ void btrfs_scratch_superblocks(struct btrfs_fs_info *fs_info,
 }
 
 int btrfs_rm_device(struct btrfs_fs_info *fs_info, const char *device_path,
-		u64 devid)
+		    u64 devid)
 {
 	struct btrfs_device *device;
 	struct btrfs_fs_devices *cur_devices;
@@ -2143,7 +2143,7 @@ int btrfs_rm_device(struct btrfs_fs_info *fs_info, const char *device_path,
 	if (device->bdev) {
 		cur_devices->open_devices--;
 		/* remove sysfs entry */
-		btrfs_sysfs_remove_devices_dir(fs_devices, device);
+		btrfs_sysfs_remove_device(device);
 	}
 
 	num_devices = btrfs_super_num_devices(fs_info->super_copy) - 1;
@@ -2244,7 +2244,7 @@ void btrfs_destroy_dev_replace_tgtdev(struct btrfs_device *tgtdev)
 
 	mutex_lock(&fs_devices->device_list_mutex);
 
-	btrfs_sysfs_remove_devices_dir(fs_devices, tgtdev);
+	btrfs_sysfs_remove_device(tgtdev);
 
 	if (tgtdev->bdev)
 		fs_devices->open_devices--;
@@ -2680,7 +2680,7 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
 	return ret;
 
 error_sysfs:
-	btrfs_sysfs_remove_devices_dir(fs_devices, device);
+	btrfs_sysfs_remove_device(device);
 	mutex_lock(&fs_info->fs_devices->device_list_mutex);
 	mutex_lock(&fs_info->chunk_mutex);
 	list_del_rcu(&device->dev_list);
-- 
2.25.1

