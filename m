Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F47D25B80A
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Sep 2020 02:58:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727851AbgICA6V (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Sep 2020 20:58:21 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:38840 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727122AbgICA6Q (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 2 Sep 2020 20:58:16 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0830tcQ8125996
        for <linux-btrfs@vger.kernel.org>; Thu, 3 Sep 2020 00:58:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=Mlu6T6Cyogj5gjacEyCUIPPg2SxNoJbFfakFFXxQSxw=;
 b=rYgA0+TUMKXc29XCQid3fkiMYOE+UDcPW3Sc3PmPB5PDDeivBohBnjfJ1uqR/zHdUipu
 wIBMFJu66eVe1IMf0+sy17RmSBaT2b9Gw6RuLvnGMGTQmghYxbLwECDPBX3tQZB3wyLQ
 9mVKCuNfaktIvA6YLID6Ks2kKiL5bLzAXHmF5wYSdx9E0z0/DW15pVYkohuTNxBwe92b
 T/83Q+/JvA3hczU4kg9Mih7QAJ3KZZDbDfqPF1Bf3QZXRaW/ujtvw4TA9kFNfcvkPkvm
 uZuao0NcrT+2BiAEDRgJ2R/ZdwQRAa0bW28/23P2Opsr+p+caFpoE1AhP2hcUmNRzzYn Jw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 337eymdu2u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
        for <linux-btrfs@vger.kernel.org>; Thu, 03 Sep 2020 00:58:15 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0830tFe6105177
        for <linux-btrfs@vger.kernel.org>; Thu, 3 Sep 2020 00:58:15 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 3380kqwusp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Thu, 03 Sep 2020 00:58:15 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0830wE0H017156
        for <linux-btrfs@vger.kernel.org>; Thu, 3 Sep 2020 00:58:14 GMT
Received: from localhost.localdomain (/39.109.231.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 02 Sep 2020 17:58:13 -0700
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 04/15] btrfs: refactor btrfs_sysfs_add_devices_dir
Date:   Thu,  3 Sep 2020 08:57:40 +0800
Message-Id: <7f81bf1c3e80e7b558d17c1caf049e0c431033ab.1599091832.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1599091832.git.anand.jain@oracle.com>
References: <cover.1599091832.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9732 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 adultscore=0
 mlxscore=0 suspectscore=1 malwarescore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009030004
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9732 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 adultscore=0
 priorityscore=1501 phishscore=0 mlxlogscore=999 mlxscore=0
 lowpriorityscore=0 clxscore=1015 spamscore=0 bulkscore=0 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009030004
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

When we add device we need to add a device to the sysfs, so instead of
using the btrfs_sysfs_add_devices_dir() 2nd argument to specify whether
to add a device or all of fs_devices, call the helper function directly
btrfs_sysfs_add_device() and thus make it non static.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 fs/btrfs/dev-replace.c |  2 +-
 fs/btrfs/sysfs.c       | 15 ++++++---------
 fs/btrfs/sysfs.h       |  3 +--
 fs/btrfs/volumes.c     |  2 +-
 4 files changed, 9 insertions(+), 13 deletions(-)

diff --git a/fs/btrfs/dev-replace.c b/fs/btrfs/dev-replace.c
index 580e60fe07d0..979b40754cb4 100644
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
index 7448caf12c53..69a58666f351 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -1265,7 +1265,7 @@ static struct kobj_type devid_ktype = {
 	.release	= btrfs_release_devid_kobj,
 };
 
-static int btrfs_sysfs_add_device(struct btrfs_device *device)
+int btrfs_sysfs_add_device(struct btrfs_device *device)
 {
 	int ret;
 	unsigned int nofs_flag;
@@ -1315,16 +1315,13 @@ static int btrfs_sysfs_add_device(struct btrfs_device *device)
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
@@ -1419,7 +1416,7 @@ int btrfs_sysfs_add_mounted(struct btrfs_fs_info *fs_info)
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
index 3f8bd1af29eb..8952f7031f4b 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -2599,7 +2599,7 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
 				    orig_super_num_devices + 1);
 
 	/* add sysfs device entry */
-	btrfs_sysfs_add_devices_dir(fs_devices, device);
+	btrfs_sysfs_add_device(device);
 
 	/*
 	 * we've got more storage, clear any full flags on the space
-- 
2.25.1

