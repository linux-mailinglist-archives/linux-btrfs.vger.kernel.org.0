Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0D7825D4BA
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Sep 2020 11:26:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728658AbgIDJ0H (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 4 Sep 2020 05:26:07 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:57036 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725812AbgIDJ0G (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 4 Sep 2020 05:26:06 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0849NugN167342;
        Fri, 4 Sep 2020 09:26:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=doPiPA8AIGvoROPXXlP8n+cE2DM9W3QlfpRyEtZyCtE=;
 b=kWOr3sbCcdiYaZer+D1tNZ+Hf0gQygokEtuHGLiQA1B7N0Saxr4LppDBEItLqSBVk7zj
 QQswJSg5NsIanJoG4AnN/ophjaXrQQ1lIfK7itdonlGk4VON3HCdw3sYEst5s9hlaiaQ
 BHwGx7bPHK5XYPlpgHJ48IFJNzc1rONWHJSTzeIGpX6y7Bu++F4VuUOpZ7cOOTBLs5Qt
 UWAR0F1YdDEwuIEr1go6HoCONOri+E2nH9ZXibFNr/7m1Z4+i62KPGGnUmEhY90uG742
 MYuiiju85aZWqVVuOkbPYmOzH5mV3N0EqlAY0pTpRL3NBEOMTKqaG8+BNuT75s3AsIlV +Q== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 339dmnc0dw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 04 Sep 2020 09:26:03 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0849PAVB192598;
        Fri, 4 Sep 2020 09:26:03 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 33bhs440sg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 04 Sep 2020 09:26:03 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0849Q18d022043;
        Fri, 4 Sep 2020 09:26:01 GMT
Received: from localhost.localdomain (/39.109.231.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 04 Sep 2020 02:26:01 -0700
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     josef@toxicpanda.com
Subject: [PATCH v3 04/15] btrfs: refactor btrfs_sysfs_add_devices_dir
Date:   Fri,  4 Sep 2020 17:25:53 +0800
Message-Id: <352f52343e26e26afd1355a6720762d729bfc088.1599193971.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1599193971.git.anand.jain@oracle.com>
References: <cover.1599193971.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9733 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 bulkscore=0
 mlxlogscore=999 spamscore=0 adultscore=0 suspectscore=1 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009040087
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9733 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0
 mlxlogscore=999 adultscore=0 impostorscore=0 mlxscore=0 suspectscore=1
 spamscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009040087
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
v3:
  Fix conflict due to the patch [1]
  [1]
   btrfs: sysfs: init devices outside of the chunk_mutex 

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
index 34899b59fcbc..713246af9137 100644
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

