Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7F61811401A
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Dec 2019 12:29:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729297AbfLEL3S (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 5 Dec 2019 06:29:18 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:43378 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729260AbfLEL3R (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 5 Dec 2019 06:29:17 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xB5BTCQk069664
        for <linux-btrfs@vger.kernel.org>; Thu, 5 Dec 2019 11:29:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2019-08-05;
 bh=GnN/TWHCTabHIKgRFTwqlgZy/Z0reto2dzy9zYeRrH8=;
 b=r1SSWYWi6Q96rkoz/hok+QvuCgncNsO326kgXz0uaqcH+HL/tX6yPCMDoDEER0OAS45u
 a9YkvkhBluEf2hcnFx+yJWud3mHqIn1WPq7CjhZDaeKBl3T/stjm2pWmJzNrOrY+21qC
 oBlAQ/9dTi1xaLG43x/quqo333Slk+d35EVG1b0i2MyADoacZLqbx3FCBBjwBhQuu2wQ
 npTlsx1MnlxU86uqSZKRNcGqwqKQeeGmLFp57tx7I49oH/uHGv+OvlTkmwslPIgtWT5b
 OZUNjgSVILqJt7uZu1SR9TiOoRJm75faYdz27wt1GGiJOihq/ory3q3YxJL1uDjZR3r9 LA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 2wkh2rmdag-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Thu, 05 Dec 2019 11:29:16 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xB5BNVo1071754
        for <linux-btrfs@vger.kernel.org>; Thu, 5 Dec 2019 11:27:15 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 2wpp73ygm0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Thu, 05 Dec 2019 11:27:15 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xB5BRE4T007878
        for <linux-btrfs@vger.kernel.org>; Thu, 5 Dec 2019 11:27:14 GMT
Received: from localhost.localdomain (/39.109.145.141)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 05 Dec 2019 03:27:14 -0800
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 2/4] btrfs: sysfs, add UUID/devinfo kobject
Date:   Thu,  5 Dec 2019 19:27:04 +0800
Message-Id: <20191205112706.8125-3-anand.jain@oracle.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191205112706.8125-1-anand.jain@oracle.com>
References: <20191205112706.8125-1-anand.jain@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9461 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1912050094
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9461 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1912050095
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Preparatory patch creates kobject /sys/fs/btrfs/UUID/devinfo to hold
btrfs_fs_devices::dev_state attribute.

This is being added in the mount context, that means we don't see
UUID/devinfo before the mount (yet).

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 fs/btrfs/sysfs.c   | 15 +++++++++++++++
 fs/btrfs/volumes.h |  1 +
 2 files changed, 16 insertions(+)

diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index 4cda410f0e6b..af169970e818 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -734,6 +734,12 @@ static int addrm_unknown_feature_attrs(struct btrfs_fs_info *fs_info, bool add)
 
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
@@ -1080,6 +1086,15 @@ int btrfs_sysfs_add_fsid(struct btrfs_fs_devices *fs_devs)
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
index 3c56ef571b00..38f2e8437b68 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -256,6 +256,7 @@ struct btrfs_fs_devices {
 	/* sysfs kobjects */
 	struct kobject fsid_kobj;
 	struct kobject *devices_kobj;
+	struct kobject *devinfo_kobj;
 	struct completion kobj_unregister;
 };
 
-- 
2.23.0

