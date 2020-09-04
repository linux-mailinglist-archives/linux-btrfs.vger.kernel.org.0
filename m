Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF23225E0E8
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Sep 2020 19:35:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727952AbgIDRfP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 4 Sep 2020 13:35:15 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:49898 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727889AbgIDRfN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 4 Sep 2020 13:35:13 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 084HXrpW037461;
        Fri, 4 Sep 2020 17:35:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=pXtss5UAdhh6jxdkV1n+XQupBy9rqj4UhRvr3w6boy0=;
 b=pTB/+1AML/F60jScY/S/OvEMmI1x06tahx+a+Xe/Phtg+svgAEkj4pREPuTwmYBWZnwk
 XjKNauXG9XqnsXFVksgbeV1brmhjLkZWBrfS1AYwFBGVEDby6m6ardbJe8+fCp8gjaTu
 01Zv1mwgtF7u8S9DjRKsYS3/rYz+4m9UlzgKv3DyqhqvjGXXNWomQEjmaT8KLDV9+EnX
 Bk0rHhckgxfj2ik8wKr5uGs03iS7Hacvw2T4IiS1Lj/z0358fq6jypVHqVOcnjLti3a/
 2lfhZ6AmlCOFp/4mbEwORwgnxYL1A+eodyLyDU7vfUeNnast87FiUfihWsZtWQwaJml5 2Q== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 339dmne39f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 04 Sep 2020 17:35:08 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 084HUlAx090231;
        Fri, 4 Sep 2020 17:35:07 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 3380xds6tu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 04 Sep 2020 17:35:07 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 084HZ6SP008788;
        Fri, 4 Sep 2020 17:35:06 GMT
Received: from localhost.localdomain (/39.109.231.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 04 Sep 2020 10:35:05 -0700
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.com, josef@toxicpanda.com, nborisov@suse.com
Subject: [PATCH 08/16] btrfs: initialize sysfs devid and device link for seed device
Date:   Sat,  5 Sep 2020 01:34:28 +0800
Message-Id: <4168e0fed4945939eaba9848c9814970a2137d6f.1599234146.git.anand.jain@oracle.com>
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

We don't initialize the sysfs devid kobject and device-link yet for the
seed devices in an sprouted filesystem.
So this patch initializes the seed device devid kobject and the device
link in the sysfs.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 fs/btrfs/sysfs.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index c5b8870b12bf..5b81bb60c86e 100644
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
@@ -1315,6 +1321,7 @@ int btrfs_sysfs_add_fs_devices(struct btrfs_fs_devices *fs_devices)
 {
 	int ret;
 	struct btrfs_device *device;
+	struct btrfs_fs_devices *seed;
 
 	list_for_each_entry(device, &fs_devices->devices, dev_list) {
 		ret = btrfs_sysfs_add_device(device);
@@ -1322,6 +1329,14 @@ int btrfs_sysfs_add_fs_devices(struct btrfs_fs_devices *fs_devices)
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

