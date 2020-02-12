Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5F2F815A4C1
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Feb 2020 10:28:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728838AbgBLJ2Z (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 12 Feb 2020 04:28:25 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:47648 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728696AbgBLJ2Z (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 12 Feb 2020 04:28:25 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01C9NXdR169942
        for <linux-btrfs@vger.kernel.org>; Wed, 12 Feb 2020 09:28:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=Y1U3iExtXWE6VLniF0QJQzW6Pw/l3ciehVRdSVp494Q=;
 b=mhbGHfTibGQrXeaHm7TO6Ldyb5hpaJm552ZBYzrS2FhZhPBnEXEssCHVJwMYJLr3xSE+
 76WHK5KxS4GdbUTiPrkv+p7NuiAp/3q/6w2xp5WRi2eJdV2JILKOWPYAInABTmAF2LJ0
 RJgHzrLA0u7gajgOSgy6vlSEKB+jAZCImztsc9cr3SrfDCXAZNAlFh9xo9HLEdjgYgop
 T/zAM3n4nvcUyKNWkAvzO7sUQ98QWQNNbdGRWAUmr8eqf+CIKUYd0hulX+a+idkjFYiR
 UKVPzxBOsTyn0iBgF37j3lX6GG/SOI7WE4MclzP9zVQgtPa1S/dzkLbMkv1K/6fROqyS MA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 2y2p3sgt6r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
        for <linux-btrfs@vger.kernel.org>; Wed, 12 Feb 2020 09:28:24 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01C9MUBo041038
        for <linux-btrfs@vger.kernel.org>; Wed, 12 Feb 2020 09:28:23 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 2y26svwkbd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Wed, 12 Feb 2020 09:28:23 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 01C9SMcf010094
        for <linux-btrfs@vger.kernel.org>; Wed, 12 Feb 2020 09:28:22 GMT
Received: from tp.localdomain (/39.109.145.141)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 12 Feb 2020 01:28:22 -0800
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 1/4] btrfs: sysfs, add UUID/devinfo kobject
Date:   Wed, 12 Feb 2020 17:28:10 +0800
Message-Id: <1581499693-22407-2-git-send-email-anand.jain@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1581499693-22407-1-git-send-email-anand.jain@oracle.com>
References: <1581499693-22407-1-git-send-email-anand.jain@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9528 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 mlxscore=0
 malwarescore=0 bulkscore=0 spamscore=0 suspectscore=1 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002120075
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9528 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 malwarescore=0
 suspectscore=1 mlxlogscore=999 priorityscore=1501 clxscore=1015
 impostorscore=0 lowpriorityscore=0 phishscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002120075
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Creates kobject /sys/fs/btrfs/UUID/devinfo to hold
btrfs_fs_devices::dev_state attribute.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
v2: update change log.

 fs/btrfs/sysfs.c   | 15 +++++++++++++++
 fs/btrfs/volumes.h |  1 +
 2 files changed, 16 insertions(+)

diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index 7436422194da..6bac61c42c05 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -901,6 +901,12 @@ static int addrm_unknown_feature_attrs(struct btrfs_fs_info *fs_info, bool add)
 
 static void __btrfs_sysfs_remove_fsid(struct btrfs_fs_devices *fs_devs)
 {
+	if (fs_devs->devinfo_kobj) {
+		kobject_del(fs_devs->devinfo_kobj);
+		kobject_put(fs_devs->devinfo_kobj);
+		fs_devs->devinfo_kobj = NULL;
+	}
+
 	if (fs_devs->devices_kobj) {
 		kobject_del(fs_devs->devices_kobj);
 		kobject_put(fs_devs->devices_kobj);
@@ -1369,6 +1375,15 @@ int btrfs_sysfs_add_fsid(struct btrfs_fs_devices *fs_devs)
 		return -ENOMEM;
 	}
 
+	fs_devs->devinfo_kobj = kobject_create_and_add("devinfo",
+						       &fs_devs->fsid_kobj);
+	if (!fs_devs->devinfo_kobj) {
+		btrfs_err(fs_devs->fs_info,
+			  "failed to init sysfs devinfo kobject");
+		btrfs_sysfs_remove_fsid(fs_devs);
+		return -ENOMEM;
+	}
+
 	return 0;
 }
 
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index 690d4f5a0653..309cda477589 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -258,6 +258,7 @@ struct btrfs_fs_devices {
 	/* sysfs kobjects */
 	struct kobject fsid_kobj;
 	struct kobject *devices_kobj;
+	struct kobject *devinfo_kobj;
 	struct completion kobj_unregister;
 };
 
-- 
1.8.3.1

