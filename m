Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0CE65104F56
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Nov 2019 10:34:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727046AbfKUJd4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 21 Nov 2019 04:33:56 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:48008 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727022AbfKUJdz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 21 Nov 2019 04:33:55 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAL9SwLB068047
        for <linux-btrfs@vger.kernel.org>; Thu, 21 Nov 2019 09:33:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references; s=corp-2019-08-05;
 bh=TESpf4gB8d8Q0n3klMPvZlshCq6tXocZaigQt8HusOM=;
 b=WDlk5ug2lBOU3VGz2/gGgOjBI2Z+kmXJKwoSf+WW3Hh4syCp2eQr5evjp2UG8K6QdPoD
 3imw7hSqYWLex8Hm1C+kYZjV8LffJoQFKhMH/pjp9is92cgtKfIXmhwVVhC+HVoCmzYs
 1+PT5E9JvDL7Td4gYKpLkmTYAgupUl8kemKF0iiTCd7nHJgoPwXSPfa1yczyCJSsoXJ6
 r9LhujabTXIl3IVZmLA876apxauH5fuM++MWJA2uoIWz9p+6q3JKbAIJSxuJCGjWotH0
 1r4e/28QlPV5uDl1uIaUGMQ7QjBaImn7tXuDjPXeVkH0oEPazG+3wLHADUefZo6qxRkZ cw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 2wa9rqtst1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Thu, 21 Nov 2019 09:33:54 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAL9WwCk067262
        for <linux-btrfs@vger.kernel.org>; Thu, 21 Nov 2019 09:33:53 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 2wd47wn9fs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Thu, 21 Nov 2019 09:33:53 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xAL9XqOu018419
        for <linux-btrfs@vger.kernel.org>; Thu, 21 Nov 2019 09:33:52 GMT
Received: from tp.localdomain (/39.109.145.141)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 21 Nov 2019 01:33:52 -0800
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 5/5] btrfs: sysfs, merge btrfs_sysfs_add devices_kobj and fsid
Date:   Thu, 21 Nov 2019 17:33:34 +0800
Message-Id: <1574328814-12263-6-git-send-email-anand.jain@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1574328814-12263-1-git-send-email-anand.jain@oracle.com>
References: <1574328814-12263-1-git-send-email-anand.jain@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9447 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1911210087
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9447 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1911210086
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Merge btrfs_sysfs_add_fsid() and btrfs_sysfs_add_devices_kobj() functions
as these two are small and they are called one after the other.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
v2: nothing in specific to this patch actually, but the changes
    before this patch makes v1 apply fail. So fixed in v2.

 fs/btrfs/disk-io.c |  7 -------
 fs/btrfs/sysfs.c   | 21 +++++++++------------
 fs/btrfs/sysfs.h   |  1 -
 3 files changed, 9 insertions(+), 20 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index c4cebc44f683..d93eeb048193 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -3090,13 +3090,6 @@ int __cold open_ctree(struct super_block *sb,
 		goto fail_block_groups;
 	}
 
-	ret = btrfs_sysfs_add_devices_kobj(fs_devices);
-	if (ret) {
-		btrfs_err(fs_info, "failed to init sysfs device interface: %d",
-				ret);
-		goto fail_fsdev_sysfs;
-	}
-
 	ret = btrfs_sysfs_add_mounted(fs_info);
 	if (ret) {
 		btrfs_err(fs_info, "failed to init sysfs interface: %d", ret);
diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index e8dfa2561909..61b4c04f5a1c 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -997,18 +997,6 @@ int btrfs_sysfs_remove_devices_attr(struct btrfs_fs_devices *fs_devices,
 	return 0;
 }
 
-int btrfs_sysfs_add_devices_kobj(struct btrfs_fs_devices *fs_devs)
-{
-	if (!fs_devs->devices_kobj)
-		fs_devs->devices_kobj = kobject_create_and_add("devices",
-							&fs_devs->fsid_kobj);
-
-	if (!fs_devs->devices_kobj)
-		return -ENOMEM;
-
-	return 0;
-}
-
 int btrfs_sysfs_add_devices_attr(struct btrfs_fs_devices *fs_devices,
 				struct btrfs_device *one_device)
 {
@@ -1085,6 +1073,15 @@ int btrfs_sysfs_add_fsid(struct btrfs_fs_devices *fs_devs)
 		return error;
 	}
 
+	fs_devs->devices_kobj = kobject_create_and_add("devices",
+						       &fs_devs->fsid_kobj);
+	if (!fs_devs->devices_kobj) {
+		btrfs_err(fs_devs->fs_info,
+			  "failed to init sysfs device interface");
+		kobject_put(&fs_devs->fsid_kobj);
+		return -ENOMEM;
+	}
+
 	return 0;
 }
 
diff --git a/fs/btrfs/sysfs.h b/fs/btrfs/sysfs.h
index f7ddcbf4a40d..9d97b3c8db4e 100644
--- a/fs/btrfs/sysfs.h
+++ b/fs/btrfs/sysfs.h
@@ -19,7 +19,6 @@ int btrfs_sysfs_add_devices_attr(struct btrfs_fs_devices *fs_devices,
 int btrfs_sysfs_remove_devices_attr(struct btrfs_fs_devices *fs_devices,
                 struct btrfs_device *one_device);
 int btrfs_sysfs_add_fsid(struct btrfs_fs_devices *fs_devs);
-int btrfs_sysfs_add_devices_kobj(struct btrfs_fs_devices *fs_devs);
 void btrfs_sysfs_remove_fsid(struct btrfs_fs_devices *fs_devs);
 void btrfs_sysfs_update_sprout_fsid(struct btrfs_fs_devices *fs_devices,
 				    const u8 *fsid);
-- 
1.8.3.1

