Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 819EE1504C9
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Feb 2020 12:00:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727741AbgBCLA0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 3 Feb 2020 06:00:26 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:50936 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727669AbgBCLAZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 3 Feb 2020 06:00:25 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 013Arf7L017842;
        Mon, 3 Feb 2020 11:00:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2019-08-05;
 bh=p54uBINHa8UN+TIHL8PzQuVKfxL+Opodx0R1K95iQmg=;
 b=kvIL03VnwZSKDyFTbM8imlJYCVjFEkzSZdMglx76oNoTXbWbY+X0I6IqAeu1Y/5hPJoA
 grr4P4yP5/KOWIleNTnS/jPEaGe0WrvI+kyFsoyX4teQR8Er/3g8AxHRKOYaaWAFuFzl
 gDbrkRKzMolutGblkBysgwK2BxLimoZ2WnkCSNUN227yy1zKh0Y34R8G3Jlyh5wftN8j
 yYh2w/p0o42vMQQ5qRZkQRqmqp/86S5JT117nSpYRVfx/NQSaL+S+pNO+wblxdV7KD4k
 VVWIgkQaldar6XnxSjntBRQm2lrxtnIn3AFjyHjJDQh+Ye3aNKTvb7X1LiMTmCZ7H3df UA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 2xw0rty2b7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 03 Feb 2020 11:00:22 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 013Areta082718;
        Mon, 3 Feb 2020 11:00:21 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 2xwjt3q6mh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 03 Feb 2020 11:00:21 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 013B0Lx5011052;
        Mon, 3 Feb 2020 11:00:21 GMT
Received: from localhost.localdomain (/39.109.145.141)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 03 Feb 2020 03:00:20 -0800
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.com
Subject: [PATCH resend 2/4] btrfs: sysfs, add UUID/devinfo kobject
Date:   Mon,  3 Feb 2020 19:00:10 +0800
Message-Id: <20200203110012.5954-3-anand.jain@oracle.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200203110012.5954-1-anand.jain@oracle.com>
References: <20200203110012.5954-1-anand.jain@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9519 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2002030083
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9519 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2002030083
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
index 8def038dc2bd..58ef2c04e5be 100644
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
@@ -1260,6 +1266,15 @@ int btrfs_sysfs_add_fsid(struct btrfs_fs_devices *fs_devs)
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
index 9c7d4fe5c39a..98535f1e208e 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -254,6 +254,7 @@ struct btrfs_fs_devices {
 	/* sysfs kobjects */
 	struct kobject fsid_kobj;
 	struct kobject *devices_kobj;
+	struct kobject *devinfo_kobj;
 	struct completion kobj_unregister;
 };
 
-- 
2.23.0

