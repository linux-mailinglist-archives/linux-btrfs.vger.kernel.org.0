Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FFA625E0F4
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Sep 2020 19:36:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726928AbgIDRg5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 4 Sep 2020 13:36:57 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:51052 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726317AbgIDRgz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 4 Sep 2020 13:36:55 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 084HXjuK037383;
        Fri, 4 Sep 2020 17:36:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=A0wKJ2Vlgqg5rHp8ZIftxZbdcuvcmmG0pBIt2/4y9jM=;
 b=U4WYfpagtrtRUNT/JNHtCIETRxzkHhNkBP0+Duv1XDSJEY0UTAMiJgB9o+KBcTacOH6e
 uj+YMrOKZe1TBFF9NP/tTAFwbJudkQvjFL6IJH7sUCWtpsgaqyXgvqWZlfJxXrUDhFXt
 EdB0P7aX8+AC84F93++bHMQAgWv1L4TuMWMK+LVaMnqCvKaQb1BYWo0RTrC/qDwArVdS
 Za7iWVHAqI9s6NYBMl/d3zho+6lJg+EfV1Gj1rlBswEEAeG8DKhYeVco9PYuj339Kw6m
 sSGs/f+ZDqGkq7p3FpoEfydEugC4RvuvPb34WNPaXTlB5f9alZ6YNfWfETz30357wW8Z iQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 339dmne3gp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 04 Sep 2020 17:36:50 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 084HUlcw090386;
        Fri, 4 Sep 2020 17:34:49 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 3380xds5xm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 04 Sep 2020 17:34:49 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 084HYnIR014138;
        Fri, 4 Sep 2020 17:34:49 GMT
Received: from localhost.localdomain (/39.109.231.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 04 Sep 2020 10:34:48 -0700
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.com, josef@toxicpanda.com, nborisov@suse.com
Subject: [PATCH 01/16] btrfs: fix put of uninitialized kobject after seed device delete
Date:   Sat,  5 Sep 2020 01:34:21 +0800
Message-Id: <5432348a53c7ec3fb97d4a21121d435fd3a1be74.1599234146.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1599234146.git.anand.jain@oracle.com>
References: <cover.1599234146.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9734 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 phishscore=0
 mlxlogscore=999 adultscore=0 suspectscore=1 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009040152
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9734 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0
 mlxlogscore=999 adultscore=0 impostorscore=0 mlxscore=0 suspectscore=1
 spamscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009040152
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

Fixes: 668e48af btrfs: sysfs, add devid/dev_state kobject and device attributes
Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 fs/btrfs/sysfs.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index 190e59152be5..438a367371c4 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -1168,10 +1168,12 @@ int btrfs_sysfs_remove_devices_dir(struct btrfs_fs_devices *fs_devices,
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
@@ -1184,10 +1186,12 @@ int btrfs_sysfs_remove_devices_dir(struct btrfs_fs_devices *fs_devices,
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

