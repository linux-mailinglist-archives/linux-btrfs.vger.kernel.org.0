Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F19E31000A7
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Nov 2019 09:47:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726578AbfKRIrT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 18 Nov 2019 03:47:19 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:52786 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726552AbfKRIrS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 18 Nov 2019 03:47:18 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAI8iPv6077416
        for <linux-btrfs@vger.kernel.org>; Mon, 18 Nov 2019 08:47:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2019-08-05;
 bh=EQa4J8uURlLZb7+mC4vxj6zWBoCDnNgEvN6dbIa3Vk0=;
 b=b3ab3HFLzw4NbeyXWGJIhWx/oM0uUwEytTGmcQdQPOa4uDAIBitb3ARHXmkBuu34LQlP
 X1rIhOFci0mZd7mxyVWTONzJd56hC8MV8rpsVQe1/mJM3PcVRG1QPEG12V3zbaj+vnwE
 FVifJtLtQITmBdHDtmqOZGTrKKUh8oSqiIXHrrPQtx69B68MUOAxwohEE104SuWDNZsM
 GPRaopfy9oUUtaNXv7a7eLFSaZ44Fepat1FyuaPk2W3NcuTNZReuGZZS/QzsynVBoksE
 0nrWMhG0D8HTuX1BDwQRKNPX5oYm8q628vdEdiWyQiABGy7D1qRPzEPlsJF8f9x68LX9 Cg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 2wa9rq6gjr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Mon, 18 Nov 2019 08:47:16 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAI8iLCs090874
        for <linux-btrfs@vger.kernel.org>; Mon, 18 Nov 2019 08:47:16 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 2watjx33qx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Mon, 18 Nov 2019 08:47:16 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id xAI8lFLs010751
        for <linux-btrfs@vger.kernel.org>; Mon, 18 Nov 2019 08:47:15 GMT
Received: from mb.wifi.oracle.com (/192.188.170.109)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 18 Nov 2019 00:47:15 -0800
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 06/15] btrfs: sysfs, move add remove _mounted function together
Date:   Mon, 18 Nov 2019 16:46:47 +0800
Message-Id: <20191118084656.3089-7-anand.jain@oracle.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191118084656.3089-1-anand.jain@oracle.com>
References: <20191118084656.3089-1-anand.jain@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9444 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1911180079
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9444 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1911180079
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The functions btrfs_sysfs_add_mounted() and btrfs_sysfs_remove_mounted()
which add and remove files and directory under /sys/fs/btrfs/UUID keep
them together to improve readability. No functional changes.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 fs/btrfs/sysfs.c | 132 +++++++++++++++++++++++------------------------
 1 file changed, 66 insertions(+), 66 deletions(-)

diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index 370f30561001..724af1322dce 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -742,21 +742,6 @@ static int addrm_unknown_feature_attrs(struct btrfs_fs_info *fs_info, bool add)
 	return 0;
 }
 
-void btrfs_sysfs_remove_mounted(struct btrfs_fs_info *fs_info)
-{
-	btrfs_reset_fs_info_ptr(fs_info);
-
-	if (fs_info->space_info_kobj) {
-		sysfs_remove_files(fs_info->space_info_kobj, allocation_attrs);
-		kobject_del(fs_info->space_info_kobj);
-		kobject_put(fs_info->space_info_kobj);
-	}
-	addrm_unknown_feature_attrs(fs_info, false);
-	sysfs_remove_group(&fs_info->fs_devices->fsid_kobj, &btrfs_feature_attr_group);
-	sysfs_remove_files(&fs_info->fs_devices->fsid_kobj, btrfs_attrs);
-	btrfs_sysfs_remove_device_info(fs_info->fs_devices, NULL);
-}
-
 static const char * const btrfs_feature_set_names[FEAT_MAX] = {
 	[FEAT_COMPAT]	 = "compat",
 	[FEAT_COMPAT_RO] = "compat_ro",
@@ -1028,6 +1013,72 @@ void btrfs_kobject_uevent(struct block_device *bdev, enum kobject_action action)
 			&disk_to_dev(bdev->bd_disk)->kobj);
 }
 
+void btrfs_sysfs_remove_mounted(struct btrfs_fs_info *fs_info)
+{
+	btrfs_reset_fs_info_ptr(fs_info);
+
+	if (fs_info->space_info_kobj) {
+		sysfs_remove_files(fs_info->space_info_kobj, allocation_attrs);
+		kobject_del(fs_info->space_info_kobj);
+		kobject_put(fs_info->space_info_kobj);
+	}
+	addrm_unknown_feature_attrs(fs_info, false);
+	sysfs_remove_group(&fs_info->fs_devices->fsid_kobj, &btrfs_feature_attr_group);
+	sysfs_remove_files(&fs_info->fs_devices->fsid_kobj, btrfs_attrs);
+	btrfs_sysfs_remove_device_info(fs_info->fs_devices, NULL);
+}
+
+int btrfs_sysfs_add_mounted(struct btrfs_fs_info *fs_info)
+{
+	int error;
+	struct btrfs_fs_devices *fs_devs = fs_info->fs_devices;
+	struct kobject *fsid_kobj = &fs_devs->fsid_kobj;
+
+	btrfs_set_fs_info_ptr(fs_info);
+
+	error = btrfs_sysfs_add_device_info(fs_devs, NULL);
+	if (error)
+		return error;
+
+	error = sysfs_create_files(fsid_kobj, btrfs_attrs);
+	if (error) {
+		btrfs_sysfs_remove_device_info(fs_devs, NULL);
+		return error;
+	}
+
+	error = sysfs_create_group(fsid_kobj,
+				   &btrfs_feature_attr_group);
+	if (error)
+		goto failure;
+
+#ifdef CONFIG_BTRFS_DEBUG
+	error = sysfs_create_group(fsid_kobj,
+				   &btrfs_debug_feature_attr_group);
+	if (error)
+		goto failure;
+#endif
+
+	error = addrm_unknown_feature_attrs(fs_info, true);
+	if (error)
+		goto failure;
+
+	fs_info->space_info_kobj = kobject_create_and_add("allocation",
+						  fsid_kobj);
+	if (!fs_info->space_info_kobj) {
+		error = -ENOMEM;
+		goto failure;
+	}
+
+	error = sysfs_create_files(fs_info->space_info_kobj, allocation_attrs);
+	if (error)
+		goto failure;
+
+	return 0;
+failure:
+	btrfs_sysfs_remove_mounted(fs_info);
+	return error;
+}
+
 void btrfs_sysfs_update_sprout_fsid(struct btrfs_fs_devices *fs_devices,
 				    const u8 *fsid)
 {
@@ -1097,57 +1148,6 @@ int btrfs_sysfs_add_fsid(struct btrfs_fs_devices *fs_devs,
 	return 0;
 }
 
-int btrfs_sysfs_add_mounted(struct btrfs_fs_info *fs_info)
-{
-	int error;
-	struct btrfs_fs_devices *fs_devs = fs_info->fs_devices;
-	struct kobject *fsid_kobj = &fs_devs->fsid_kobj;
-
-	btrfs_set_fs_info_ptr(fs_info);
-
-	error = btrfs_sysfs_add_device_info(fs_devs, NULL);
-	if (error)
-		return error;
-
-	error = sysfs_create_files(fsid_kobj, btrfs_attrs);
-	if (error) {
-		btrfs_sysfs_remove_device_info(fs_devs, NULL);
-		return error;
-	}
-
-	error = sysfs_create_group(fsid_kobj,
-				   &btrfs_feature_attr_group);
-	if (error)
-		goto failure;
-
-#ifdef CONFIG_BTRFS_DEBUG
-	error = sysfs_create_group(fsid_kobj,
-				   &btrfs_debug_feature_attr_group);
-	if (error)
-		goto failure;
-#endif
-
-	error = addrm_unknown_feature_attrs(fs_info, true);
-	if (error)
-		goto failure;
-
-	fs_info->space_info_kobj = kobject_create_and_add("allocation",
-						  fsid_kobj);
-	if (!fs_info->space_info_kobj) {
-		error = -ENOMEM;
-		goto failure;
-	}
-
-	error = sysfs_create_files(fs_info->space_info_kobj, allocation_attrs);
-	if (error)
-		goto failure;
-
-	return 0;
-failure:
-	btrfs_sysfs_remove_mounted(fs_info);
-	return error;
-}
-
 
 /*
  * Change per-fs features in /sys/fs/btrfs/UUID/features to match current
-- 
2.23.0

