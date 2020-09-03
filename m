Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0420C25B80C
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Sep 2020 02:58:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727903AbgICA6Z (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Sep 2020 20:58:25 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:57030 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726686AbgICA6U (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 2 Sep 2020 20:58:20 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0830rcgW176210
        for <linux-btrfs@vger.kernel.org>; Thu, 3 Sep 2020 00:58:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=cNUY226Y6LnsBJdyW9ehkLDxsUdp44MJRKw77DRk+9A=;
 b=wVU0j4GTmlJh8tQ13fLn34UasEnUVJFmazvhfiTk7Y02Z4Vlk2uCSfmuva9qks2B4I9C
 Rhc8UfzOqj9F3TTe80AQ4v7C0+QKUvQindHOdKn6dlyPnglr6p+hSpXidungKgEdV/Ol
 9PHX/Df3g4fuT/+2Xn9Kh1TxXY9PmDBrEOb2WeeK9h70g8E66zr1p9d6q/yUvhPrkC1v
 NczET0fqsWzfaThdNbewaYPhw1SABy1BFjhT/KmqCnuuV6SPeVWxl9+Z0hvy2PkQ01Jv
 DQmnnCoyJWSJv/V1HLrGE7x1Y33zGPTYttW7d4mCG+r+J63gjL35oO7IyBgbkdUQuyn/ pQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 339dmn4b1g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
        for <linux-btrfs@vger.kernel.org>; Thu, 03 Sep 2020 00:58:18 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0830sfVv036864
        for <linux-btrfs@vger.kernel.org>; Thu, 3 Sep 2020 00:58:17 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 3380x8anuv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Thu, 03 Sep 2020 00:58:17 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0830wHCV020930
        for <linux-btrfs@vger.kernel.org>; Thu, 3 Sep 2020 00:58:17 GMT
Received: from localhost.localdomain (/39.109.231.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 02 Sep 2020 17:58:17 -0700
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 06/15] btrfs: initialize sysfs devid and device link for seed device
Date:   Thu,  3 Sep 2020 08:57:42 +0800
Message-Id: <0b11ff81143ebfcaa1da26296ee12afcfe41dbb5.1599091832.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1599091832.git.anand.jain@oracle.com>
References: <cover.1599091832.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9732 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 phishscore=0
 mlxlogscore=999 adultscore=0 suspectscore=1 bulkscore=0 malwarescore=0
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
fs, we don't initialize the devid kobject yet. So this patch initializes
the seed device devid kobject and the device link in the sysfs. This takes
care of the Warning.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 fs/btrfs/sysfs.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index 9853b9acd4bd..98ce955a0879 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -938,9 +938,15 @@ void btrfs_sysfs_remove_fsid(struct btrfs_fs_devices *fs_devs)
 void btrfs_sysfs_remove_fs_devices(struct btrfs_fs_devices *fs_devices)
 {
 	struct btrfs_device *device;
+	struct btrfs_fs_devices *seed;
 
 	list_for_each_entry(device, &fs_devices->devices, dev_list)
 		btrfs_sysfs_remove_device(device);
+
+	list_for_each_entry(seed, &fs_devices->seed_list, seed_list) {
+		list_for_each_entry(device, &seed->devices, dev_list)
+			btrfs_sysfs_remove_device(device);
+	}
 }
 
 void btrfs_sysfs_remove_mounted(struct btrfs_fs_info *fs_info)
@@ -1314,6 +1320,7 @@ int btrfs_sysfs_add_fs_devices(struct btrfs_fs_devices *fs_devices)
 {
 	int ret;
 	struct btrfs_device *device;
+	struct btrfs_fs_devices *seed;
 
 	list_for_each_entry(device, &fs_devices->devices, dev_list) {
 		ret = btrfs_sysfs_add_device(device);
@@ -1321,6 +1328,14 @@ int btrfs_sysfs_add_fs_devices(struct btrfs_fs_devices *fs_devices)
 			return ret;
 	}
 
+	list_for_each_entry(seed, &fs_devices->seed_list, seed_list) {
+		list_for_each_entry(device, &seed->devices, dev_list) {
+			ret = btrfs_sysfs_add_device(device);
+			if (ret)
+				return ret;
+		}
+	}
+
 	return 0;
 }
 
-- 
2.25.1

