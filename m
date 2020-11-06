Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E78F2A90FA
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Nov 2020 09:07:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726198AbgKFIG5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 6 Nov 2020 03:06:57 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:34246 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725830AbgKFIG4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 6 Nov 2020 03:06:56 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0A6844Bm066090
        for <linux-btrfs@vger.kernel.org>; Fri, 6 Nov 2020 08:06:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=aZ9MWo8N9C+8h6fLIo0J6ganJlIcnLvamoXcKBTxR+I=;
 b=xyUZXvkwWf+2TTeGt5cyMi3X2qZFMkWkuDmkHdVI9RVH+58amf6GNEX9kz/IEQ4ZZ4xo
 qmB1DgBTvuBDPcYlAuwVPMNo4RCmMq1WVbr3nSuZCs5RtJYaBSK+4inQu4KBhYh7vYUW
 b49UxZlbuBP6tAnksrK6bd2k7x/LwOgyTVWYGx2SXK+UArBoHwu/nOp6A51NEPvN2gNn
 Jd6JkjFP5JHHcabQ2iG4tAeF9oBoKr0AUPch6wzgLjP6nKMaF/65dDhV7vNQJoxwk37J
 EM9WgqiAZdt22iODmc6jsKiqLVWdIGqXiJNLZjcyfs4j9Ew63CXLewHQjfO54+H6Mbkq UA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 34hhvcqr3s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
        for <linux-btrfs@vger.kernel.org>; Fri, 06 Nov 2020 08:06:55 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0A684wvJ163259
        for <linux-btrfs@vger.kernel.org>; Fri, 6 Nov 2020 08:06:55 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 34jf4dkjb3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Fri, 06 Nov 2020 08:06:55 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0A686sCN022545
        for <linux-btrfs@vger.kernel.org>; Fri, 6 Nov 2020 08:06:54 GMT
Received: from localhost.localdomain (/39.109.231.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 06 Nov 2020 00:06:53 -0800
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Anand Jain <anand.jain@oracle.com>
Subject: [PATCH 1/1] btrfs: cleanup btrfs_free_extra_devids() drop arg step
Date:   Fri,  6 Nov 2020 16:06:33 +0800
Message-Id: <a20a37162b49e5b1de7a5ec70607102b61ac94eb.1604649817.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1604649817.git.anand.jain@oracle.com>
References: <cover.1604649817.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9796 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=3 mlxscore=0
 bulkscore=0 malwarescore=0 mlxlogscore=999 phishscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011060057
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9796 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=3
 impostorscore=0 malwarescore=0 priorityscore=1501 mlxlogscore=999
 bulkscore=0 phishscore=0 adultscore=0 mlxscore=0 lowpriorityscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011060057
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Following patch
 btrfs: dev-replace: fail mount if we don't have replace item with target device
dropped the multi ops of the function btrfs_free_extra_devids(), where now
it doesn't check the replace target device. So btrfs_free_extra_devid()
doesn't need the 2nd argument %step anymore. Perpetuate the related
changes back to the functions in the stack.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 fs/btrfs/disk-io.c | 12 ++++++------
 fs/btrfs/volumes.c |  8 ++++----
 fs/btrfs/volumes.h |  2 +-
 3 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 212806d59012..3b07cce1937e 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -3156,11 +3156,13 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 	}
 
 	/*
-	 * Keep the devid that is marked to be the target device for the
-	 * device replace procedure
+	 * At this point we know all the devices that make this FS, including
+	 * the seed devices but we don't know yet if the replace target is
+	 * required. So free devices not part of this FS but skip the replace
+	 * traget device if any. And the replace target is checked further
+	 * below in btrfs_init_dev_replace().
 	 */
-	btrfs_free_extra_devids(fs_devices, 0);
-
+	btrfs_free_extra_devids(fs_devices);
 	if (!fs_devices->latest_bdev) {
 		btrfs_err(fs_info, "failed to read devices");
 		goto fail_tree_roots;
@@ -3207,8 +3209,6 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 		goto fail_block_groups;
 	}
 
-	btrfs_free_extra_devids(fs_devices, 1);
-
 	ret = btrfs_sysfs_add_fsid(fs_devices);
 	if (ret) {
 		btrfs_err(fs_info, "failed to init sysfs fsid interface: %d",
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 9dd55a6f38de..b08f232170ee 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -1038,7 +1038,7 @@ static struct btrfs_fs_devices *clone_fs_devices(struct btrfs_fs_devices *orig)
 }
 
 static void __btrfs_free_extra_devids(struct btrfs_fs_devices *fs_devices,
-				      int step, struct btrfs_device **latest_dev)
+				      struct btrfs_device **latest_dev)
 {
 	struct btrfs_device *device, *next;
 
@@ -1083,16 +1083,16 @@ static void __btrfs_free_extra_devids(struct btrfs_fs_devices *fs_devices,
  * After we have read the system tree and know devids belonging to this
  * filesystem, remove the device which does not belong there.
  */
-void btrfs_free_extra_devids(struct btrfs_fs_devices *fs_devices, int step)
+void btrfs_free_extra_devids(struct btrfs_fs_devices *fs_devices)
 {
 	struct btrfs_device *latest_dev = NULL;
 	struct btrfs_fs_devices *seed_dev;
 
 	mutex_lock(&uuid_mutex);
-	__btrfs_free_extra_devids(fs_devices, step, &latest_dev);
+	__btrfs_free_extra_devids(fs_devices, &latest_dev);
 
 	list_for_each_entry(seed_dev, &fs_devices->seed_list, seed_list)
-		__btrfs_free_extra_devids(seed_dev, step, &latest_dev);
+		__btrfs_free_extra_devids(seed_dev, &latest_dev);
 
 	fs_devices->latest_bdev = latest_dev->bdev;
 
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index bd95cea85a65..5e08274d1252 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -449,7 +449,7 @@ struct btrfs_device *btrfs_scan_one_device(const char *path,
 					   fmode_t flags, void *holder);
 int btrfs_forget_devices(const char *path);
 void btrfs_close_devices(struct btrfs_fs_devices *fs_devices);
-void btrfs_free_extra_devids(struct btrfs_fs_devices *fs_devices, int step);
+void btrfs_free_extra_devids(struct btrfs_fs_devices *fs_devices);
 void btrfs_assign_next_active_device(struct btrfs_device *device,
 				     struct btrfs_device *this_dev);
 struct btrfs_device *btrfs_find_device_by_devspec(struct btrfs_fs_info *fs_info,
-- 
2.25.1

