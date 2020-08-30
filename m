Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87EC0256EC0
	for <lists+linux-btrfs@lfdr.de>; Sun, 30 Aug 2020 16:43:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727015AbgH3Onj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 30 Aug 2020 10:43:39 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:60138 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726436AbgH3Ona (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 30 Aug 2020 10:43:30 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07UEXwBV130634;
        Sun, 30 Aug 2020 14:43:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=3VO4Bpjm4wWSHdAbSrO+cwdDXCqrF8yQhHDfHbwqmqs=;
 b=i18efS+VKYqfRnyvpDevpg9VO8D6PoPYvljIU0T6+JHQ61oS+pFhT1b2jmZeHcThgLEx
 5Va6lycCBVTpzddSqEk3vlHBkncd1pL1BErgmet2g9GJeEsIX8qhgD+NibYMEQIQIgyI
 LbgRWHxFCeMesD/LqxxBvSFMv1RWSY8io9QOrD1jzR3U/ZfG1ShOyKS4eykW0u/KRVof
 Eb838uW6owA+kgsJnJ8MOYvsF2lCvZKZbRE1s/jBmWYnRr3ygsGcBmWUl46AN3vhSTyk
 YiGmEEV1MCNU3QNq5YdpQZU6uWyL8L6J0UqNLVwKIhdzI+5pHItQi8dYLc0Eno1GBuST Wg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 337qrha2g6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 30 Aug 2020 14:43:24 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07UEaqFM138815;
        Sun, 30 Aug 2020 14:41:24 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 3380sp0uk0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 30 Aug 2020 14:41:24 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 07UEfN7r015546;
        Sun, 30 Aug 2020 14:41:23 GMT
Received: from localhost.localdomain (/39.109.231.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 30 Aug 2020 07:41:22 -0700
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.com, josef@toxicpanda.com
Subject: [PATCH 02/11] btrfs: refactor btrfs_sysfs_add_devices_dir
Date:   Sun, 30 Aug 2020 22:40:57 +0800
Message-Id: <767ff466ca3b74e435ecc679b7c4f58741d8516d.1598792561.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1598792561.git.anand.jain@oracle.com>
References: <cover.1598792561.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9728 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 phishscore=0 malwarescore=0 mlxscore=0 spamscore=0 bulkscore=0
 suspectscore=1 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008300118
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9729 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 adultscore=0 mlxscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015
 suspectscore=1 priorityscore=1501 spamscore=0 malwarescore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008300118
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
 fs/btrfs/sysfs.c       | 11 ++++-------
 fs/btrfs/sysfs.h       |  4 ++--
 fs/btrfs/volumes.c     |  2 +-
 4 files changed, 8 insertions(+), 11 deletions(-)

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
index 9b5e58091fae..afc2e2ab4d27 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -1274,7 +1274,7 @@ static struct kobj_type devid_ktype = {
 	.release	= btrfs_release_devid_kobj,
 };
 
-static int btrfs_sysfs_add_device(struct btrfs_device *device)
+int btrfs_sysfs_add_device(struct btrfs_device *device)
 {
 	int ret;
 	struct kobject *devices_kobj;
@@ -1319,18 +1319,15 @@ static int btrfs_sysfs_add_device(struct btrfs_device *device)
 	return ret;
 }
 
-int btrfs_sysfs_add_devices_dir(struct btrfs_fs_devices *fs_devices,
-				struct btrfs_device *device)
+int btrfs_sysfs_add_fs_devices(struct btrfs_fs_devices *fs_devices)
 {
 	int ret = 0;
 	unsigned int nofs_flag;
+	struct btrfs_device *device;
 	struct btrfs_fs_devices *seed_fs_devices;
 
 	nofs_flag = memalloc_nofs_save();
 
-	if (device)
-		return btrfs_sysfs_add_device(device);
-
 	list_for_each_entry(device, &fs_devices->devices, dev_list) {
 		ret = btrfs_sysfs_add_device(device);
 		if (ret)
@@ -1438,7 +1435,7 @@ int btrfs_sysfs_add_mounted(struct btrfs_fs_info *fs_info)
 	struct btrfs_fs_devices *fs_devs = fs_info->fs_devices;
 	struct kobject *fsid_kobj = &fs_devs->fsid_kobj;
 
-	error = btrfs_sysfs_add_devices_dir(fs_devs, NULL);
+	error = btrfs_sysfs_add_fs_devices(fs_devs);
 	if (error)
 		return error;
 
diff --git a/fs/btrfs/sysfs.h b/fs/btrfs/sysfs.h
index 4217823e255c..2a3a44aa0709 100644
--- a/fs/btrfs/sysfs.h
+++ b/fs/btrfs/sysfs.h
@@ -14,8 +14,8 @@ enum btrfs_feature_set {
 
 char *btrfs_printable_features(enum btrfs_feature_set set, u64 flags);
 const char *btrfs_feature_set_name(enum btrfs_feature_set set);
-int btrfs_sysfs_add_devices_dir(struct btrfs_fs_devices *fs_devices,
-		struct btrfs_device *one_device);
+int btrfs_sysfs_add_device(struct btrfs_device *device);
+int btrfs_sysfs_add_fs_devices(struct btrfs_fs_devices *fs_devices);
 int btrfs_sysfs_remove_devices_dir(struct btrfs_fs_devices *fs_devices,
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

