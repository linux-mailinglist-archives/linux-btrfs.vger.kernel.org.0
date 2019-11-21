Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9DCE5104F53
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Nov 2019 10:34:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727010AbfKUJdv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 21 Nov 2019 04:33:51 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:36382 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726170AbfKUJdv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 21 Nov 2019 04:33:51 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAL9SwoT093045
        for <linux-btrfs@vger.kernel.org>; Thu, 21 Nov 2019 09:33:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references; s=corp-2019-08-05;
 bh=MZaBV5BNb56nwZ9U6/t+jYUCug4agt6JQQuqKzOkO0U=;
 b=K3TE1mJBgO/uFDhcTX6Lirt8XAOgp2gogZ0M5xcBSCUkhJfAQdrCO4z3CSlBOuymrq9Q
 r5MwOiDI1HKQ6a+0Xqke/hfPKDNvSWtOOXkHkAtDzjI0odvfYE60BfRa1l+zFLTJ4lRv
 nA0Krzh8wrm1qoNRv3kcZ0KIl/1iFFigaoLpvKOYb3nWx8UTSwDflUiS6SAhSJpsDLGG
 vl5nZETCriKQO5cqCZsaQb/IL8j3S7moiPSsggmqdrjRcV0oVLqqNted6fLbUcEcQJ1u
 WJKbJJ3OlhGkZQuXZOojQtzlFQ2hb1XtVboHp86Gs3Tmve9xM1jPey1rQoUQnD8oNUvp Nw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 2wa8hu2wkw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Thu, 21 Nov 2019 09:33:49 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAL9WaHV050419
        for <linux-btrfs@vger.kernel.org>; Thu, 21 Nov 2019 09:33:49 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 2wdfrrk7mx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Thu, 21 Nov 2019 09:33:48 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id xAL9XlNV001082
        for <linux-btrfs@vger.kernel.org>; Thu, 21 Nov 2019 09:33:48 GMT
Received: from tp.localdomain (/39.109.145.141)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 21 Nov 2019 01:33:47 -0800
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 2/5] btrfs: sysfs, rename device_link add,remove functions
Date:   Thu, 21 Nov 2019 17:33:31 +0800
Message-Id: <1574328814-12263-3-git-send-email-anand.jain@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1574328814-12263-1-git-send-email-anand.jain@oracle.com>
References: <1574328814-12263-1-git-send-email-anand.jain@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9447 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1911210087
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9447 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1911210086
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

In preparation to add btrfs_device::dev_state attribute in
  /sys/fs/btrfs/UUID/devices/

Rename btrfs_sysfs_add_device_link() and btrfs_sysfs_rm_device_link() to
btrfs_sysfs_add_devices_attr() and btrfs_sysfs_remove_devices_attr() as
these functions is going to create more attributes rather than just the
link to the disk. No functional changes.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
v2: rename to ..devices_attr() instead of ..device_info()

 fs/btrfs/dev-replace.c |  4 ++--
 fs/btrfs/sysfs.c       | 10 +++++-----
 fs/btrfs/sysfs.h       |  4 ++--
 fs/btrfs/volumes.c     |  8 ++++----
 4 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/fs/btrfs/dev-replace.c b/fs/btrfs/dev-replace.c
index f639dde2a679..9a29d6de9017 100644
--- a/fs/btrfs/dev-replace.c
+++ b/fs/btrfs/dev-replace.c
@@ -472,7 +472,7 @@ static int btrfs_dev_replace_start(struct btrfs_fs_info *fs_info,
 	atomic64_set(&dev_replace->num_uncorrectable_read_errors, 0);
 	up_write(&dev_replace->rwsem);
 
-	ret = btrfs_sysfs_add_device_link(tgt_device->fs_devices, tgt_device);
+	ret = btrfs_sysfs_add_devices_attr(tgt_device->fs_devices, tgt_device);
 	if (ret)
 		btrfs_err(fs_info, "kobj add dev failed %d", ret);
 
@@ -706,7 +706,7 @@ static int btrfs_dev_replace_finishing(struct btrfs_fs_info *fs_info,
 	mutex_unlock(&fs_info->fs_devices->device_list_mutex);
 
 	/* replace the sysfs entry */
-	btrfs_sysfs_rm_device_link(fs_info->fs_devices, src_device);
+	btrfs_sysfs_remove_devices_attr(fs_info->fs_devices, src_device);
 	btrfs_rm_dev_replace_free_srcdev(src_device);
 
 	/* write back the superblocks */
diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index 29e82832ff18..a9bb507a06f1 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -774,7 +774,7 @@ void btrfs_sysfs_remove_mounted(struct btrfs_fs_info *fs_info)
 	addrm_unknown_feature_attrs(fs_info, false);
 	sysfs_remove_group(&fs_info->fs_devices->fsid_kobj, &btrfs_feature_attr_group);
 	sysfs_remove_files(&fs_info->fs_devices->fsid_kobj, btrfs_attrs);
-	btrfs_sysfs_rm_device_link(fs_info->fs_devices, NULL);
+	btrfs_sysfs_remove_devices_attr(fs_info->fs_devices, NULL);
 }
 
 static const char * const btrfs_feature_set_names[FEAT_MAX] = {
@@ -963,7 +963,7 @@ int btrfs_sysfs_add_space_info_type(struct btrfs_fs_info *fs_info,
 
 /* when one_device is NULL, it removes all device links */
 
-int btrfs_sysfs_rm_device_link(struct btrfs_fs_devices *fs_devices,
+int btrfs_sysfs_remove_devices_attr(struct btrfs_fs_devices *fs_devices,
 		struct btrfs_device *one_device)
 {
 	struct hd_struct *disk;
@@ -1009,7 +1009,7 @@ int btrfs_sysfs_add_device(struct btrfs_fs_devices *fs_devs)
 	return 0;
 }
 
-int btrfs_sysfs_add_device_link(struct btrfs_fs_devices *fs_devices,
+int btrfs_sysfs_add_devices_attr(struct btrfs_fs_devices *fs_devices,
 				struct btrfs_device *one_device)
 {
 	int error = 0;
@@ -1095,13 +1095,13 @@ int btrfs_sysfs_add_mounted(struct btrfs_fs_info *fs_info)
 
 	btrfs_set_fs_info_ptr(fs_info);
 
-	error = btrfs_sysfs_add_device_link(fs_devs, NULL);
+	error = btrfs_sysfs_add_devices_attr(fs_devs, NULL);
 	if (error)
 		return error;
 
 	error = sysfs_create_files(fsid_kobj, btrfs_attrs);
 	if (error) {
-		btrfs_sysfs_rm_device_link(fs_devs, NULL);
+		btrfs_sysfs_remove_devices_attr(fs_devs, NULL);
 		return error;
 	}
 
diff --git a/fs/btrfs/sysfs.h b/fs/btrfs/sysfs.h
index e10c3adfc30f..4a9057def6ad 100644
--- a/fs/btrfs/sysfs.h
+++ b/fs/btrfs/sysfs.h
@@ -14,9 +14,9 @@ enum btrfs_feature_set {
 
 char *btrfs_printable_features(enum btrfs_feature_set set, u64 flags);
 const char * const btrfs_feature_set_name(enum btrfs_feature_set set);
-int btrfs_sysfs_add_device_link(struct btrfs_fs_devices *fs_devices,
+int btrfs_sysfs_add_devices_attr(struct btrfs_fs_devices *fs_devices,
 		struct btrfs_device *one_device);
-int btrfs_sysfs_rm_device_link(struct btrfs_fs_devices *fs_devices,
+int btrfs_sysfs_remove_devices_attr(struct btrfs_fs_devices *fs_devices,
                 struct btrfs_device *one_device);
 int btrfs_sysfs_add_fsid(struct btrfs_fs_devices *fs_devs,
 				struct kobject *parent);
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index d8e5560db285..c8d5a8af224c 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -2012,7 +2012,7 @@ int btrfs_rm_device(struct btrfs_fs_info *fs_info, const char *device_path,
 	if (device->bdev) {
 		cur_devices->open_devices--;
 		/* remove sysfs entry */
-		btrfs_sysfs_rm_device_link(fs_devices, device);
+		btrfs_sysfs_remove_devices_attr(fs_devices, device);
 	}
 
 	num_devices = btrfs_super_num_devices(fs_info->super_copy) - 1;
@@ -2133,7 +2133,7 @@ void btrfs_destroy_dev_replace_tgtdev(struct btrfs_device *tgtdev)
 	WARN_ON(!tgtdev);
 	mutex_lock(&fs_devices->device_list_mutex);
 
-	btrfs_sysfs_rm_device_link(fs_devices, tgtdev);
+	btrfs_sysfs_remove_devices_attr(fs_devices, tgtdev);
 
 	if (tgtdev->bdev)
 		fs_devices->open_devices--;
@@ -2481,7 +2481,7 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
 				    orig_super_num_devices + 1);
 
 	/* add sysfs device entry */
-	btrfs_sysfs_add_device_link(fs_devices, device);
+	btrfs_sysfs_add_devices_attr(fs_devices, device);
 
 	/*
 	 * we've got more storage, clear any full flags on the space
@@ -2549,7 +2549,7 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
 	return ret;
 
 error_sysfs:
-	btrfs_sysfs_rm_device_link(fs_devices, device);
+	btrfs_sysfs_remove_devices_attr(fs_devices, device);
 	mutex_lock(&fs_info->fs_devices->device_list_mutex);
 	mutex_lock(&fs_info->chunk_mutex);
 	list_del_rcu(&device->dev_list);
-- 
1.8.3.1

