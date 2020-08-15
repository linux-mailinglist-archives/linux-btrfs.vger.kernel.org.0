Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 757B52454BF
	for <lists+linux-btrfs@lfdr.de>; Sun, 16 Aug 2020 00:44:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728151AbgHOWoQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 15 Aug 2020 18:44:16 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:58838 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726855AbgHOWoQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 15 Aug 2020 18:44:16 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07FHClGU092307
        for <linux-btrfs@vger.kernel.org>; Sat, 15 Aug 2020 17:15:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : mime-version : content-transfer-encoding;
 s=corp-2020-01-29; bh=ZkU87zAK2HOKvpFs0mdx4eA5Y6blUgh7bG0c+U68/4M=;
 b=RRD+DwnjrQP0jTpu7IpY4esChL7iZ2tq1E2wGRJIb/Tm5luAj+9lX6seFcFtNLbYuVux
 qeVW1LTgAqecrmC2YRDwdPRxAcW2QyTM7qtcu9nuYuymUvGBasBXYcp63RreeqWdPGA4
 8BUZErxk7r4ijJprCHUJ2wxkJyF6KRwui0TN02kQPIVVcx7E9/XXG2G/smW9GoyQh1KF
 e+xU0Xj8+v0n97pCrrgWjYutVLg/JWKaNkU1KvLP22NXsUL7CSCHUxNeCFEdNBJh9sF6
 hMrgCMEJ7n6tI+P3Uw6lvOVv+gU5ZCOSixSSdMnb30MUKHBySllD0YOa3C1cyouLnVjp EA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 32x8bms92e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
        for <linux-btrfs@vger.kernel.org>; Sat, 15 Aug 2020 17:15:24 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07FH8lqD150801
        for <linux-btrfs@vger.kernel.org>; Sat, 15 Aug 2020 17:15:24 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 32x4tsussu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Sat, 15 Aug 2020 17:15:24 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 07FHFNZj019507
        for <linux-btrfs@vger.kernel.org>; Sat, 15 Aug 2020 17:15:24 GMT
Received: from localhost.localdomain (/39.109.231.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sat, 15 Aug 2020 10:15:23 -0700
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: fix put of uninitialized kobject after seed device delete
Date:   Sun, 16 Aug 2020 01:15:14 +0800
Message-Id: <20200815171514.14105-1-anand.jain@oracle.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9714 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 adultscore=0
 suspectscore=1 malwarescore=0 mlxlogscore=999 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008150136
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9714 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 lowpriorityscore=0
 impostorscore=0 suspectscore=1 adultscore=0 spamscore=0 malwarescore=0
 mlxlogscore=999 priorityscore=1501 bulkscore=0 clxscore=1015 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008150136
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The following test case leads to null kobject-being-freed error.

 mount seed /mnt
 add sprout to /mnt
 umount /mnt
 mount sprout to /mnt
 delete seed

 kobject: '(null)' (00000000dd2b87e4): is not initialized, yet kobject_put() is being called.
 WARNING: CPU: 1 PID: 15784 at lib/kobject.c:736 kobject_put+0x80/0x350
 RIP: 0010:kobject_put+0x80/0x350
 ::
 Call Trace:
 btrfs_sysfs_remove_devices_dir+0x6e/0x160 [btrfs]
 btrfs_rm_device.cold+0xa8/0x298 [btrfs]
 btrfs_ioctl+0x206c/0x22a0 [btrfs]
 ksys_ioctl+0xe2/0x140
 __x64_sys_ioctl+0x1e/0x29
 do_syscall_64+0x96/0x150
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
 RIP: 0033:0x7f4047c6288b
 ::

This is because, at the end of the seed device-delete, we try to remove
the seed's devid sysfs entry. But for the seed devices under the sprout
fs, we don't initialize the devid kobject yet. So add a kobject state
check, which takes care of the Warning.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 fs/btrfs/sysfs.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index 104c80caaa74..9111b3b7caaf 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -1170,10 +1170,12 @@ int btrfs_sysfs_remove_devices_dir(struct btrfs_fs_devices *fs_devices,
 					  disk_kobj->name);
 		}
 
-		kobject_del(&one_device->devid_kobj);
-		kobject_put(&one_device->devid_kobj);
+		if (one_device->devid_kobj.state_initialized) {
+			kobject_del(&one_device->devid_kobj);
+			kobject_put(&one_device->devid_kobj);
 
-		wait_for_completion(&one_device->kobj_unregister);
+			wait_for_completion(&one_device->kobj_unregister);
+		}
 
 		return 0;
 	}
@@ -1186,10 +1188,12 @@ int btrfs_sysfs_remove_devices_dir(struct btrfs_fs_devices *fs_devices,
 			sysfs_remove_link(fs_devices->devices_kobj,
 					  disk_kobj->name);
 		}
-		kobject_del(&one_device->devid_kobj);
-		kobject_put(&one_device->devid_kobj);
+		if (one_device->devid_kobj.state_initialized) {
+			kobject_del(&one_device->devid_kobj);
+			kobject_put(&one_device->devid_kobj);
 
-		wait_for_completion(&one_device->kobj_unregister);
+			wait_for_completion(&one_device->kobj_unregister);
+		}
 	}
 
 	return 0;
-- 
2.25.1

