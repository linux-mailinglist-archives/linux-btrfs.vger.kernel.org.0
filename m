Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A569C25E0E6
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Sep 2020 19:35:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727924AbgIDRfK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 4 Sep 2020 13:35:10 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:60292 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727889AbgIDRfJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 4 Sep 2020 13:35:09 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 084HZ2mj140970;
        Fri, 4 Sep 2020 17:35:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=F27C1kYwrX2YewUEPgB3jC+QAIS2dVgJQ9YThlmeWrY=;
 b=HmLAz7zRXtddaQtkpEY3v07iGNoIiWhbh17Ek+8MUyHQZtTU1WjLoB5Px3mYpcmTkR2F
 qo+koLIuBpvLAQt/VfFUZbF0FoLxEwFKPnHZ3xhBkymBT7dr0ihaDQsrbxK5gFvNv9oc
 1JByz/BLzmnkvTHfgng9wpeeKDsZjSX6gd/xzTlt3DTQDOgttoL2TNf0aO5Nji5rNvBb
 7pKtxvJbKnuK8rlWAGhdcF1CYlM0bWtQqeRnX8EOd/3LVWKuP/Tlft4OfIsXqvWGgE22
 2cr9zIBX9tEFzV2slhNbbDyNqC2acSkow1SMB/CprTz0oaLW82+qYqzMyjX9cMT10Hyk FQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 337eerfr8b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 04 Sep 2020 17:35:03 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 084HTrnA187001;
        Fri, 4 Sep 2020 17:35:02 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 33b7v30u5y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 04 Sep 2020 17:35:02 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 084HZ14d005741;
        Fri, 4 Sep 2020 17:35:01 GMT
Received: from localhost.localdomain (/39.109.231.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 04 Sep 2020 10:35:01 -0700
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.com, josef@toxicpanda.com, nborisov@suse.com
Subject: [PATCH 06/16] btrfs: refactor btrfs_sysfs_add_devices_dir
Date:   Sat,  5 Sep 2020 01:34:26 +0800
Message-Id: <859039beb0c312de56d20246dd9cd78a080ee1ea.1599234146.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1599234146.git.anand.jain@oracle.com>
References: <cover.1599234146.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9734 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 spamscore=0
 mlxlogscore=999 phishscore=0 bulkscore=0 suspectscore=1 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009040152
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9734 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 adultscore=0 spamscore=0 mlxscore=0
 phishscore=0 impostorscore=0 mlxlogscore=999 bulkscore=0 suspectscore=1
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009040152
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

When we add device we need to add a device to the sysfs, so instead of
using the btrfs_sysfs_add_devices_dir() 2nd argument to specify whether
to add a device or all of fs_devices, call the helper function directly
btrfs_sysfs_add_device() and thus make it non static.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
Reviewed-by: Nikolay Borisov <nborisov@suse.com>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/dev-replace.c |  2 +-
 fs/btrfs/sysfs.c       | 15 ++++++---------
 fs/btrfs/sysfs.h       |  3 +--
 fs/btrfs/volumes.c     |  2 +-
 4 files changed, 9 insertions(+), 13 deletions(-)

diff --git a/fs/btrfs/dev-replace.c b/fs/btrfs/dev-replace.c
index 7637b1f02c63..2e54b8f4d053 100644
--- a/fs/btrfs/dev-replace.c
+++ b/fs/btrfs/dev-replace.c
@@ -512,7 +512,7 @@ static int btrfs_dev_replace_start(struct btrfs_fs_info *fs_info,
 	atomic64_set(&dev_replace->num_uncorrectable_read_errors, 0);
 	up_write(&dev_replace->rwsem);
 
-	ret = btrfs_sysfs_add_devices_dir(tgt_device->fs_devices, tgt_device);
+	ret = btrfs_sysfs_add_device(tgt_device);
 	if (ret)
 		btrfs_err(fs_info, "kobj add dev failed %d", ret);
 
diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index 5d7cb6a81f0d..1da1c3ba2143 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -1266,7 +1266,7 @@ static struct kobj_type devid_ktype = {
 	.release	= btrfs_release_devid_kobj,
 };
 
-static int btrfs_sysfs_add_device(struct btrfs_device *device)
+int btrfs_sysfs_add_device(struct btrfs_device *device)
 {
 	int ret;
 	unsigned int nofs_flag;
@@ -1316,16 +1316,13 @@ static int btrfs_sysfs_add_device(struct btrfs_device *device)
 	return ret;
 }
 
-int btrfs_sysfs_add_devices_dir(struct btrfs_fs_devices *fs_devices,
-				struct btrfs_device *one_device)
+int btrfs_sysfs_add_fs_devices(struct btrfs_fs_devices *fs_devices)
 {
 	int ret;
+	struct btrfs_device *device;
 
-	if (one_device)
-		return btrfs_sysfs_add_device(one_device);
-
-	list_for_each_entry(one_device, &fs_devices->devices, dev_list) {
-		ret = btrfs_sysfs_add_device(one_device);
+	list_for_each_entry(device, &fs_devices->devices, dev_list) {
+		ret = btrfs_sysfs_add_device(device);
 		if (ret)
 			return ret;
 	}
@@ -1420,7 +1417,7 @@ int btrfs_sysfs_add_mounted(struct btrfs_fs_info *fs_info)
 	struct btrfs_fs_devices *fs_devs = fs_info->fs_devices;
 	struct kobject *fsid_kobj = &fs_devs->fsid_kobj;
 
-	error = btrfs_sysfs_add_devices_dir(fs_devs, NULL);
+	error = btrfs_sysfs_add_fs_devices(fs_devs);
 	if (error)
 		return error;
 
diff --git a/fs/btrfs/sysfs.h b/fs/btrfs/sysfs.h
index bc995b0c1889..56c29257b5a7 100644
--- a/fs/btrfs/sysfs.h
+++ b/fs/btrfs/sysfs.h
@@ -14,8 +14,7 @@ enum btrfs_feature_set {
 
 char *btrfs_printable_features(enum btrfs_feature_set set, u64 flags);
 const char *btrfs_feature_set_name(enum btrfs_feature_set set);
-int btrfs_sysfs_add_devices_dir(struct btrfs_fs_devices *fs_devices,
-		struct btrfs_device *one_device);
+int btrfs_sysfs_add_device(struct btrfs_device *device);
 void btrfs_sysfs_remove_devices_dir(struct btrfs_fs_devices *fs_devices,
 				    struct btrfs_device *one_device);
 int btrfs_sysfs_add_fsid(struct btrfs_fs_devices *fs_devs);
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index df3a31fcc4d7..f858c4d9a6ae 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -2606,7 +2606,7 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
 	mutex_unlock(&fs_info->chunk_mutex);
 
 	/* Add sysfs device entry */
-	btrfs_sysfs_add_devices_dir(fs_devices, device);
+	btrfs_sysfs_add_device(device);
 
 	mutex_unlock(&fs_devices->device_list_mutex);
 
-- 
2.25.1

