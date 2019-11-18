Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6BF521000A2
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Nov 2019 09:47:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726460AbfKRIrI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 18 Nov 2019 03:47:08 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:47990 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726371AbfKRIrI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 18 Nov 2019 03:47:08 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAI8iNgZ105641
        for <linux-btrfs@vger.kernel.org>; Mon, 18 Nov 2019 08:47:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2019-08-05;
 bh=P05tu+xpF3YKGliIXO+MSkpkyem0W8pkrpCYNAOqUq4=;
 b=lA0HQPW3lXRX6mSDznm1m2eLoKWVp475w4/i2/STWTBTrCgrwgXRhoco3tqMaGlKsBYA
 SkLpxKK3Cp78sAMgrdlksg/+EEmeQ1RQUA97u6JYeR3D0ZoS1114662FNA/kpSOzJ2RB
 6QzZcKqqqy4eo6XKE9RpHUjRDUfoR8uBv3YXQ44Rvte2CU/TO+4k1bsZ/qPw6c5Kf1Y7
 0NcLP9X3dFefDWgsSAdbU6BdEr9kjQXTe8yBsV9N69iH0PnDN8F6cvajk4i6vT2ryz7q
 naOmO6vXYO4GRUZTRga1SP8jbz4tTE3Yu/67pUxqOh6cjxtzUnmH3/Ra2hKQi/r3iWWT bA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 2wa8htenpn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Mon, 18 Nov 2019 08:47:06 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAI8i2u3156200
        for <linux-btrfs@vger.kernel.org>; Mon, 18 Nov 2019 08:47:05 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 2wau946cxs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Mon, 18 Nov 2019 08:47:05 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id xAI8l4UN010634
        for <linux-btrfs@vger.kernel.org>; Mon, 18 Nov 2019 08:47:04 GMT
Received: from mb.wifi.oracle.com (/192.188.170.109)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 18 Nov 2019 00:47:03 -0800
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 01/15] btrfs: sysfs, rename device_link add,remove functions
Date:   Mon, 18 Nov 2019 16:46:42 +0800
Message-Id: <20191118084656.3089-2-anand.jain@oracle.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191118084656.3089-1-anand.jain@oracle.com>
References: <20191118084656.3089-1-anand.jain@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9444 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1911180079
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9444 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1911180079
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

In preparation to add btrfs_device::dev_state attribute in
  /sys/fs/btrfs/UUID/devices/

Rename btrfs_sysfs_add_device_link() and btrfs_sysfs_rm_device_link() to
btrfs_sysfs_add_device_info() and btrfs_sysfs_remove_device_info() as
these functions is going to create more attributes rather than just the
link to the disk. No functional changes.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 fs/btrfs/dev-replace.c |  4 ++--
 fs/btrfs/sysfs.c       | 10 +++++-----
 fs/btrfs/sysfs.h       |  4 ++--
 fs/btrfs/volumes.c     |  8 ++++----
 4 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/fs/btrfs/dev-replace.c b/fs/btrfs/dev-replace.c
index f639dde2a679..8184ddad28cf 100644
--- a/fs/btrfs/dev-replace.c
+++ b/fs/btrfs/dev-replace.c
@@ -472,7 +472,7 @@ static int btrfs_dev_replace_start(struct btrfs_fs_info *fs_info,
 	atomic64_set(&dev_replace->num_uncorrectable_read_errors, 0);
 	up_write(&dev_replace->rwsem);
 
-	ret = btrfs_sysfs_add_device_link(tgt_device->fs_devices, tgt_device);
+	ret = btrfs_sysfs_add_device_info(tgt_device->fs_devices, tgt_device);
 	if (ret)
 		btrfs_err(fs_info, "kobj add dev failed %d", ret);
 
@@ -706,7 +706,7 @@ static int btrfs_dev_replace_finishing(struct btrfs_fs_info *fs_info,
 	mutex_unlock(&fs_info->fs_devices->device_list_mutex);
 
 	/* replace the sysfs entry */
-	btrfs_sysfs_rm_device_link(fs_info->fs_devices, src_device);
+	btrfs_sysfs_remove_device_info(fs_info->fs_devices, src_device);
 	btrfs_rm_dev_replace_free_srcdev(src_device);
 
 	/* write back the superblocks */
diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index 343d535a8081..76ee266f0b8d 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -784,7 +784,7 @@ void btrfs_sysfs_remove_mounted(struct btrfs_fs_info *fs_info)
 	addrm_unknown_feature_attrs(fs_info, false);
 	sysfs_remove_group(&fs_info->fs_devices->fsid_kobj, &btrfs_feature_attr_group);
 	sysfs_remove_files(&fs_info->fs_devices->fsid_kobj, btrfs_attrs);
-	btrfs_sysfs_rm_device_link(fs_info->fs_devices, NULL);
+	btrfs_sysfs_remove_device_info(fs_info->fs_devices, NULL);
 }
 
 static const char * const btrfs_feature_set_names[FEAT_MAX] = {
@@ -973,7 +973,7 @@ int btrfs_sysfs_add_space_info_type(struct btrfs_fs_info *fs_info,
 
 /* when one_device is NULL, it removes all device links */
 
-int btrfs_sysfs_rm_device_link(struct btrfs_fs_devices *fs_devices,
+int btrfs_sysfs_remove_device_info(struct btrfs_fs_devices *fs_devices,
 		struct btrfs_device *one_device)
 {
 	struct hd_struct *disk;
@@ -1019,7 +1019,7 @@ int btrfs_sysfs_add_device(struct btrfs_fs_devices *fs_devs)
 	return 0;
 }
 
-int btrfs_sysfs_add_device_link(struct btrfs_fs_devices *fs_devices,
+int btrfs_sysfs_add_device_info(struct btrfs_fs_devices *fs_devices,
 				struct btrfs_device *one_device)
 {
 	int error = 0;
@@ -1105,13 +1105,13 @@ int btrfs_sysfs_add_mounted(struct btrfs_fs_info *fs_info)
 
 	btrfs_set_fs_info_ptr(fs_info);
 
-	error = btrfs_sysfs_add_device_link(fs_devs, NULL);
+	error = btrfs_sysfs_add_device_info(fs_devs, NULL);
 	if (error)
 		return error;
 
 	error = sysfs_create_files(fsid_kobj, btrfs_attrs);
 	if (error) {
-		btrfs_sysfs_rm_device_link(fs_devs, NULL);
+		btrfs_sysfs_remove_device_info(fs_devs, NULL);
 		return error;
 	}
 
diff --git a/fs/btrfs/sysfs.h b/fs/btrfs/sysfs.h
index e10c3adfc30f..4b624e7d97c1 100644
--- a/fs/btrfs/sysfs.h
+++ b/fs/btrfs/sysfs.h
@@ -14,9 +14,9 @@ enum btrfs_feature_set {
 
 char *btrfs_printable_features(enum btrfs_feature_set set, u64 flags);
 const char * const btrfs_feature_set_name(enum btrfs_feature_set set);
-int btrfs_sysfs_add_device_link(struct btrfs_fs_devices *fs_devices,
+int btrfs_sysfs_add_device_info(struct btrfs_fs_devices *fs_devices,
 		struct btrfs_device *one_device);
-int btrfs_sysfs_rm_device_link(struct btrfs_fs_devices *fs_devices,
+int btrfs_sysfs_remove_device_info(struct btrfs_fs_devices *fs_devices,
                 struct btrfs_device *one_device);
 int btrfs_sysfs_add_fsid(struct btrfs_fs_devices *fs_devs,
 				struct kobject *parent);
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index d8e5560db285..40d77b5846dc 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -2012,7 +2012,7 @@ int btrfs_rm_device(struct btrfs_fs_info *fs_info, const char *device_path,
 	if (device->bdev) {
 		cur_devices->open_devices--;
 		/* remove sysfs entry */
-		btrfs_sysfs_rm_device_link(fs_devices, device);
+		btrfs_sysfs_remove_device_info(fs_devices, device);
 	}
 
 	num_devices = btrfs_super_num_devices(fs_info->super_copy) - 1;
@@ -2133,7 +2133,7 @@ void btrfs_destroy_dev_replace_tgtdev(struct btrfs_device *tgtdev)
 	WARN_ON(!tgtdev);
 	mutex_lock(&fs_devices->device_list_mutex);
 
-	btrfs_sysfs_rm_device_link(fs_devices, tgtdev);
+	btrfs_sysfs_remove_device_info(fs_devices, tgtdev);
 
 	if (tgtdev->bdev)
 		fs_devices->open_devices--;
@@ -2481,7 +2481,7 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
 				    orig_super_num_devices + 1);
 
 	/* add sysfs device entry */
-	btrfs_sysfs_add_device_link(fs_devices, device);
+	btrfs_sysfs_add_device_info(fs_devices, device);
 
 	/*
 	 * we've got more storage, clear any full flags on the space
@@ -2549,7 +2549,7 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
 	return ret;
 
 error_sysfs:
-	btrfs_sysfs_rm_device_link(fs_devices, device);
+	btrfs_sysfs_remove_device_info(fs_devices, device);
 	mutex_lock(&fs_info->fs_devices->device_list_mutex);
 	mutex_lock(&fs_info->chunk_mutex);
 	list_del_rcu(&device->dev_list);
-- 
2.23.0

