Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0663511400F
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Dec 2019 12:27:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729048AbfLEL1T (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 5 Dec 2019 06:27:19 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:35808 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728735AbfLEL1S (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 5 Dec 2019 06:27:18 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xB5BJ5ox067856
        for <linux-btrfs@vger.kernel.org>; Thu, 5 Dec 2019 11:27:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2019-08-05;
 bh=oO61Je4oaXusZAgH5fCk6zBXijQtaBB8na9k5bDTtiE=;
 b=SNSyt+cbGqaDx6apmv7JlzsiN4h6G++dg7UTZeJurZM2YMYewjlZBFDKI5Als5jOlK6H
 Q4XDkqX11GZDDTCHHha8i8PyLYit1Rx4/co/fFZdV79B/I8xfKL3gUgEQhUAB/tKQNcZ
 09BxjhRvRVYuyZmn08mJkbvcdj6w6RN6pPIo8DSbBB/uz1xo2HiAZnWUR57ldRqrc8l/
 k9flGbvcI/bSUMC55YStR/BMXaUHwuASBpocsyTFlxMEzi/MB8Z+/DaxTfAPw3dCSUX8
 LOveIHz4wucdMhiVttKMhyT3j6LkJZXf+obLSm8LF3LQegmQM+ALj1UoL2xem2l2kLUn JA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 2wkgcqmev0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Thu, 05 Dec 2019 11:27:17 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xB5BNoBm033437
        for <linux-btrfs@vger.kernel.org>; Thu, 5 Dec 2019 11:27:16 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 2wptnx9qj0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Thu, 05 Dec 2019 11:27:16 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id xB5BRGNY006843
        for <linux-btrfs@vger.kernel.org>; Thu, 5 Dec 2019 11:27:16 GMT
Received: from localhost.localdomain (/39.109.145.141)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 05 Dec 2019 03:27:15 -0800
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 3/4] btrfs: sysfs, rename device_link add,remove functions
Date:   Thu,  5 Dec 2019 19:27:05 +0800
Message-Id: <20191205112706.8125-4-anand.jain@oracle.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191205112706.8125-1-anand.jain@oracle.com>
References: <20191205112706.8125-1-anand.jain@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9461 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1912050094
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9461 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1912050094
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

In preparation to add btrfs_device::dev_state attribute in
  /sys/fs/btrfs/UUID/devinfo

Rename btrfs_sysfs_add_device_link() and btrfs_sysfs_rm_device_link() to
btrfs_sysfs_add_devices_attr() and btrfs_sysfs_remove_devices_attr() as
these functions is going to create dev_state attribute rather than just
the link to the disk. No functional changes.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
v2: Update change log. Change ..UUID/devices to ..UUID/devinfo

 fs/btrfs/dev-replace.c |  4 ++--
 fs/btrfs/sysfs.c       | 12 ++++++------
 fs/btrfs/sysfs.h       |  4 ++--
 fs/btrfs/volumes.c     |  8 ++++----
 4 files changed, 14 insertions(+), 14 deletions(-)

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
index af169970e818..834f712ed60c 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -780,7 +780,7 @@ void btrfs_sysfs_remove_mounted(struct btrfs_fs_info *fs_info)
 	addrm_unknown_feature_attrs(fs_info, false);
 	sysfs_remove_group(&fs_info->fs_devices->fsid_kobj, &btrfs_feature_attr_group);
 	sysfs_remove_files(&fs_info->fs_devices->fsid_kobj, btrfs_attrs);
-	btrfs_sysfs_rm_device_link(fs_info->fs_devices, NULL);
+	btrfs_sysfs_remove_devices_attr(fs_info->fs_devices, NULL);
 }
 
 static const char * const btrfs_feature_set_names[FEAT_MAX] = {
@@ -969,7 +969,7 @@ int btrfs_sysfs_add_space_info_type(struct btrfs_fs_info *fs_info,
 
 /* when one_device is NULL, it removes all device links */
 
-int btrfs_sysfs_rm_device_link(struct btrfs_fs_devices *fs_devices,
+int btrfs_sysfs_remove_devices_attr(struct btrfs_fs_devices *fs_devices,
 		struct btrfs_device *one_device)
 {
 	struct hd_struct *disk;
@@ -1001,8 +1001,8 @@ int btrfs_sysfs_rm_device_link(struct btrfs_fs_devices *fs_devices,
 	return 0;
 }
 
-int btrfs_sysfs_add_device_link(struct btrfs_fs_devices *fs_devices,
-				struct btrfs_device *one_device)
+int btrfs_sysfs_add_devices_attr(struct btrfs_fs_devices *fs_devices,
+				 struct btrfs_device *one_device)
 {
 	int error = 0;
 	struct btrfs_device *dev;
@@ -1106,13 +1106,13 @@ int btrfs_sysfs_add_mounted(struct btrfs_fs_info *fs_info)
 
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
index 3d27b39eaf94..9d97b3c8db4e 100644
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
 int btrfs_sysfs_add_fsid(struct btrfs_fs_devices *fs_devs);
 void btrfs_sysfs_remove_fsid(struct btrfs_fs_devices *fs_devs);
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index c565650639ee..1d80ac164fe3 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -2014,7 +2014,7 @@ int btrfs_rm_device(struct btrfs_fs_info *fs_info, const char *device_path,
 	if (device->bdev) {
 		cur_devices->open_devices--;
 		/* remove sysfs entry */
-		btrfs_sysfs_rm_device_link(fs_devices, device);
+		btrfs_sysfs_remove_devices_attr(fs_devices, device);
 	}
 
 	num_devices = btrfs_super_num_devices(fs_info->super_copy) - 1;
@@ -2135,7 +2135,7 @@ void btrfs_destroy_dev_replace_tgtdev(struct btrfs_device *tgtdev)
 	WARN_ON(!tgtdev);
 	mutex_lock(&fs_devices->device_list_mutex);
 
-	btrfs_sysfs_rm_device_link(fs_devices, tgtdev);
+	btrfs_sysfs_remove_devices_attr(fs_devices, tgtdev);
 
 	if (tgtdev->bdev)
 		fs_devices->open_devices--;
@@ -2483,7 +2483,7 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
 				    orig_super_num_devices + 1);
 
 	/* add sysfs device entry */
-	btrfs_sysfs_add_device_link(fs_devices, device);
+	btrfs_sysfs_add_devices_attr(fs_devices, device);
 
 	/*
 	 * we've got more storage, clear any full flags on the space
@@ -2551,7 +2551,7 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
 	return ret;
 
 error_sysfs:
-	btrfs_sysfs_rm_device_link(fs_devices, device);
+	btrfs_sysfs_remove_devices_attr(fs_devices, device);
 	mutex_lock(&fs_info->fs_devices->device_list_mutex);
 	mutex_lock(&fs_info->chunk_mutex);
 	list_del_rcu(&device->dev_list);
-- 
2.23.0

