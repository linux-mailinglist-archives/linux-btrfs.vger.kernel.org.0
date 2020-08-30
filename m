Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F1FC256EBD
	for <lists+linux-btrfs@lfdr.de>; Sun, 30 Aug 2020 16:43:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727793AbgH3OnC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 30 Aug 2020 10:43:02 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:59114 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726887AbgH3Olc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 30 Aug 2020 10:41:32 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07UEYmrR087603;
        Sun, 30 Aug 2020 14:41:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=Nf5JLZxWS4HAyPK9q3QV7jUXU8UMqy9q/8IG6v9lTqo=;
 b=odPyE1LmD9NKQmQs6XIKHl+Y2NAFRG0S9XwXZkrfLGBsIU+9NP2vjXtxqtbJQYSgLgv2
 qs1xYT2rv091692OTq31FaYeJtA6z23DX2hdHcpz8f6U72V2KN7x9sT1JZ/3LuE4Lv4Z
 3iQ1D+wAlTPB9AYEigz1aasJflSg47GzAq/B4/Af7qyIyuBfGmLHuYbEZnnuvHpmhuMk
 FeCUASu+3zogMHh0tJ70+EQd4cOuoE5cMD+ANm3fj8sah5sebOUrwSXDcN6Gs7hSW0N/
 qeAxKp3cdNpmURooMKUpfVXlQJqe+dEUyXRUAoirECfvTNTQfNqi0MLN3gLysF8DyNwO mQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 337eyktych-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 30 Aug 2020 14:41:26 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07UEZ4GG104630;
        Sun, 30 Aug 2020 14:41:26 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 3380kjpyw8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 30 Aug 2020 14:41:26 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 07UEfP7w024903;
        Sun, 30 Aug 2020 14:41:25 GMT
Received: from localhost.localdomain (/39.109.231.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 30 Aug 2020 07:41:24 -0700
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.com, josef@toxicpanda.com
Subject: [PATCH 03/11] btrfs: refactor btrfs_sysfs_remove_devices_dir
Date:   Sun, 30 Aug 2020 22:40:58 +0800
Message-Id: <170b1d35e76fc68131223839eb74c90557b5da3c.1598792561.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1598792561.git.anand.jain@oracle.com>
References: <cover.1598792561.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9729 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 adultscore=0
 mlxscore=0 suspectscore=3 malwarescore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008300118
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9729 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 adultscore=0
 priorityscore=1501 phishscore=0 mlxlogscore=999 mlxscore=0
 lowpriorityscore=0 clxscore=1015 spamscore=0 bulkscore=0 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008300118
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Similar to btrfs_sysfs_add_devices_dir() refactor, refactor
btrfs_sysfs_remove_devices_dir() so that we don't have to use the 2nd
argument to indicate whether to free all devices or just one device. So
this patch also adds a bit of cleanups and return value is dropped to
void.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 fs/btrfs/dev-replace.c |  2 +-
 fs/btrfs/sysfs.c       | 18 +++++-------------
 fs/btrfs/sysfs.h       |  4 ++--
 fs/btrfs/volumes.c     |  8 ++++----
 4 files changed, 12 insertions(+), 20 deletions(-)

diff --git a/fs/btrfs/dev-replace.c b/fs/btrfs/dev-replace.c
index 979b40754cb4..a7b1ad4e5706 100644
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
index afc2e2ab4d27..69e5b57a33b4 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -962,7 +962,7 @@ void btrfs_sysfs_remove_mounted(struct btrfs_fs_info *fs_info)
 	addrm_unknown_feature_attrs(fs_info, false);
 	sysfs_remove_group(fsid_kobj, &btrfs_feature_attr_group);
 	sysfs_remove_files(fsid_kobj, btrfs_attrs);
-	btrfs_sysfs_remove_devices_dir(fs_info->fs_devices, NULL);
+	btrfs_sysfs_remove_fs_devices(fs_info->fs_devices);
 }
 
 static const char * const btrfs_feature_set_names[FEAT_MAX] = {
@@ -1149,7 +1149,7 @@ int btrfs_sysfs_add_space_info_type(struct btrfs_fs_info *fs_info,
 	return 0;
 }
 
-static void btrfs_sysfs_remove_device(struct btrfs_device *device)
+void btrfs_sysfs_remove_device(struct btrfs_device *device)
 {
 	struct hd_struct *disk;
 	struct kobject *disk_kobj;
@@ -1174,17 +1174,11 @@ static void btrfs_sysfs_remove_device(struct btrfs_device *device)
 	wait_for_completion(&device->kobj_unregister);
 }
 
-/* when 2nd argument device is NULL, it removes all devices link */
-int btrfs_sysfs_remove_devices_dir(struct btrfs_fs_devices *fs_devices,
-				   struct btrfs_device *device)
+void btrfs_sysfs_remove_fs_devices(struct btrfs_fs_devices *fs_devices)
 {
+	struct btrfs_device *device;
 	struct btrfs_fs_devices *seed_fs_devices;
 
-	if (device) {
-		btrfs_sysfs_remove_device(device);
-		return 0;
-	}
-
 	list_for_each_entry(device, &fs_devices->devices, dev_list)
 		btrfs_sysfs_remove_device(device);
 
@@ -1192,8 +1186,6 @@ int btrfs_sysfs_remove_devices_dir(struct btrfs_fs_devices *fs_devices,
 		list_for_each_entry(device, &seed_fs_devices->devices, dev_list)
 			btrfs_sysfs_remove_device(device);
 	}
-
-	return 0;
 }
 
 static ssize_t btrfs_devinfo_in_fs_metadata_show(struct kobject *kobj,
@@ -1441,7 +1433,7 @@ int btrfs_sysfs_add_mounted(struct btrfs_fs_info *fs_info)
 
 	error = sysfs_create_files(fsid_kobj, btrfs_attrs);
 	if (error) {
-		btrfs_sysfs_remove_devices_dir(fs_devs, NULL);
+		btrfs_sysfs_remove_fs_devices(fs_devs);
 		return error;
 	}
 
diff --git a/fs/btrfs/sysfs.h b/fs/btrfs/sysfs.h
index 2a3a44aa0709..085e34b81fba 100644
--- a/fs/btrfs/sysfs.h
+++ b/fs/btrfs/sysfs.h
@@ -16,8 +16,8 @@ char *btrfs_printable_features(enum btrfs_feature_set set, u64 flags);
 const char *btrfs_feature_set_name(enum btrfs_feature_set set);
 int btrfs_sysfs_add_device(struct btrfs_device *device);
 int btrfs_sysfs_add_fs_devices(struct btrfs_fs_devices *fs_devices);
-int btrfs_sysfs_remove_devices_dir(struct btrfs_fs_devices *fs_devices,
-                struct btrfs_device *one_device);
+void btrfs_sysfs_remove_device(struct btrfs_device *device);
+void btrfs_sysfs_remove_fs_devices(struct btrfs_fs_devices *fs_devices);
 int btrfs_sysfs_add_fsid(struct btrfs_fs_devices *fs_devs);
 void btrfs_sysfs_remove_fsid(struct btrfs_fs_devices *fs_devs);
 void btrfs_sysfs_update_sprout_fsid(struct btrfs_fs_devices *fs_devices);
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 8952f7031f4b..9921b43ef839 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -2040,7 +2040,7 @@ void btrfs_scratch_superblocks(struct btrfs_fs_info *fs_info,
 }
 
 int btrfs_rm_device(struct btrfs_fs_info *fs_info, const char *device_path,
-		u64 devid)
+		    u64 devid)
 {
 	struct btrfs_device *device;
 	struct btrfs_fs_devices *cur_devices;
@@ -2144,7 +2144,7 @@ int btrfs_rm_device(struct btrfs_fs_info *fs_info, const char *device_path,
 	if (device->bdev) {
 		cur_devices->open_devices--;
 		/* remove sysfs entry */
-		btrfs_sysfs_remove_devices_dir(fs_devices, device);
+		btrfs_sysfs_remove_device(device);
 	}
 
 	num_devices = btrfs_super_num_devices(fs_info->super_copy) - 1;
@@ -2245,7 +2245,7 @@ void btrfs_destroy_dev_replace_tgtdev(struct btrfs_device *tgtdev)
 
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

