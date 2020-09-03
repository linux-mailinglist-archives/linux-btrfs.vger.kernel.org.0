Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BC7825B80B
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Sep 2020 02:58:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727897AbgICA6Y (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Sep 2020 20:58:24 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:57050 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727818AbgICA6V (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 2 Sep 2020 20:58:21 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0830swSh176869
        for <linux-btrfs@vger.kernel.org>; Thu, 3 Sep 2020 00:58:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=1DxNN5ByH8BK4fUsgKje1MSVlnbK7TsDgaBoY9hsDKE=;
 b=vIFvKxo3dn22HviV79zt/qMOTDsgAWPeRkBH+xI5uy2mM0fTbOrsocAUz3LfImMzJy0d
 sGtyHXhc1+kZDJbbxUXquRglJnMVp2aeLCBqSaoZkah4MDel0gvrR6TEZEjUg8Pmf36Y
 FcXcbtZPffLXKzK0omnoqIIX0mzhJeewMi4z3siJClTay9rTzADHkntWPxeasA6BWzWG
 N5r/oJKeAF37a0kV0tAGlILsz9aTikDVUPrH3FsLlYtOEHxHBCqR/r5NLzFX1hjoW2vs
 7cxi8Uq4afqe8opaSTjIJO7sQ8e4SYFr8Sr2x5TdDXBP+LxbcvbxyHnHwKWytIpWymmY ZA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 339dmn4b1j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
        for <linux-btrfs@vger.kernel.org>; Thu, 03 Sep 2020 00:58:20 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0830tEVN105147
        for <linux-btrfs@vger.kernel.org>; Thu, 3 Sep 2020 00:58:19 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 3380kqwuuq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Thu, 03 Sep 2020 00:58:19 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0830wIuN020208
        for <linux-btrfs@vger.kernel.org>; Thu, 3 Sep 2020 00:58:18 GMT
Received: from localhost.localdomain (/39.109.231.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 02 Sep 2020 17:58:18 -0700
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 07/15] btrfs: handle fail path for btrfs_sysfs_add_fs_devices
Date:   Thu,  3 Sep 2020 08:57:43 +0800
Message-Id: <32779bc42ae40eea707cc585624724ac91cd967e.1599091832.git.anand.jain@oracle.com>
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
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0
 mlxlogscore=999 adultscore=0 impostorscore=0 mlxscore=0 suspectscore=1
 spamscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009030004
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

btrfs_sysfs_add_fs_devices() is called by btrfs_sysfs_add_mounted().
btrfs_sysfs_add_mounted() assumes that btrfs_sysfs_add_fs_devices() will
either add sysfs entries for all the devices or none. So this patch keeps up
to its caller expecatation and cleans up the created sysfs entries if it
has to fail at some device in the list.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 fs/btrfs/sysfs.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index 98ce955a0879..a5a73b21d4af 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -1182,10 +1182,12 @@ void btrfs_sysfs_remove_device(struct btrfs_device *device)
 		sysfs_remove_link(devices_kobj, disk_kobj->name);
 	}
 
-	kobject_del(&device->devid_kobj);
-	kobject_put(&device->devid_kobj);
+	if (device->devid_kobj.state_initialized) {
+		kobject_del(&device->devid_kobj);
+		kobject_put(&device->devid_kobj);
+		wait_for_completion(&device->kobj_unregister);
+	}
 
-	wait_for_completion(&device->kobj_unregister);
 }
 
 static ssize_t btrfs_devinfo_in_fs_metadata_show(struct kobject *kobj,
@@ -1324,19 +1326,21 @@ int btrfs_sysfs_add_fs_devices(struct btrfs_fs_devices *fs_devices)
 
 	list_for_each_entry(device, &fs_devices->devices, dev_list) {
 		ret = btrfs_sysfs_add_device(device);
-		if (ret)
-			return ret;
+		goto fail;
 	}
 
 	list_for_each_entry(seed, &fs_devices->seed_list, seed_list) {
 		list_for_each_entry(device, &seed->devices, dev_list) {
 			ret = btrfs_sysfs_add_device(device);
-			if (ret)
-				return ret;
+			goto fail;
 		}
 	}
 
 	return 0;
+
+fail:
+	btrfs_sysfs_remove_fs_devices(fs_devices);
+	return ret;
 }
 
 void btrfs_kobject_uevent(struct block_device *bdev, enum kobject_action action)
-- 
2.25.1

