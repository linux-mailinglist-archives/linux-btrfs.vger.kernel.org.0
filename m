Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 789661000A6
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Nov 2019 09:47:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726563AbfKRIrR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 18 Nov 2019 03:47:17 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:48120 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726464AbfKRIrQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 18 Nov 2019 03:47:16 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAI8i4ST105082
        for <linux-btrfs@vger.kernel.org>; Mon, 18 Nov 2019 08:47:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2019-08-05;
 bh=0pozGaWXsrTEUL6y/hsdLeMKepkUZoPsXDxQaWTnnm4=;
 b=Uw+xgzN/64zeLqmk5exhSRmG2RGh9/DWNsJQ48+ssdu9AZOzOyv9O2SPv+LgSeMtRzru
 SbMvuj/Onf+K7E6b8RbVzaM+vvvjMDXlIhEBvWoYKWl2HqgnnPaW+zzRVhHXcEm4aIkp
 a6W1mPCAQ8+d0yo/1B+9G1bf1oqrpn5gmIePRcVeNTLbFupN94krmxafXMmDkPChvM6i
 eGpaTFEWrNGt5XYtIv9TgpAXZqh/6MCs+AXqIceodx2LKimHi1PcvWdfpRTtZtmLIpiS
 0xHQ6+DCEw0qh1PzjsDkuf0utkGAnklgr+crvbXL9apoqTHX53fn3sFGLbw69ogNW9TE aQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 2wa8htenqg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Mon, 18 Nov 2019 08:47:15 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAI8iKZK152767
        for <linux-btrfs@vger.kernel.org>; Mon, 18 Nov 2019 08:47:14 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 2watmr3gba-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Mon, 18 Nov 2019 08:47:14 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xAI8lD3q003100
        for <linux-btrfs@vger.kernel.org>; Mon, 18 Nov 2019 08:47:13 GMT
Received: from mb.wifi.oracle.com (/192.188.170.109)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 18 Nov 2019 00:47:12 -0800
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 05/15] btrfs: sysfs, move /sys/fs/btrfs/UUID related functions together
Date:   Mon, 18 Nov 2019 16:46:46 +0800
Message-Id: <20191118084656.3089-6-anand.jain@oracle.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191118084656.3089-1-anand.jain@oracle.com>
References: <20191118084656.3089-1-anand.jain@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9444 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1911180079
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9444 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1911180079
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

No functional changes. Move functions to bring btrfs_sysfs_remove_fsid()
and btrfs_sysfs_add_fsid() and its related functions together.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 fs/btrfs/sysfs.c | 60 ++++++++++++++++++++++++------------------------
 1 file changed, 30 insertions(+), 30 deletions(-)

diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index d54777d5c78e..370f30561001 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -742,36 +742,6 @@ static int addrm_unknown_feature_attrs(struct btrfs_fs_info *fs_info, bool add)
 	return 0;
 }
 
-static void __btrfs_sysfs_remove_fsid(struct btrfs_fs_devices *fs_devs)
-{
-	if (fs_devs->devices_dir_kobj) {
-		kobject_del(fs_devs->devices_dir_kobj);
-		kobject_put(fs_devs->devices_dir_kobj);
-		fs_devs->devices_dir_kobj = NULL;
-	}
-
-	if (fs_devs->fsid_kobj.state_initialized) {
-		kobject_del(&fs_devs->fsid_kobj);
-		kobject_put(&fs_devs->fsid_kobj);
-		wait_for_completion(&fs_devs->kobj_unregister);
-	}
-}
-
-/* when fs_devs is NULL it will remove all fsid kobject */
-void btrfs_sysfs_remove_fsid(struct btrfs_fs_devices *fs_devs)
-{
-	struct list_head *fs_uuids = btrfs_get_fs_uuids();
-
-	if (fs_devs) {
-		__btrfs_sysfs_remove_fsid(fs_devs);
-		return;
-	}
-
-	list_for_each_entry(fs_devs, fs_uuids, fs_list) {
-		__btrfs_sysfs_remove_fsid(fs_devs);
-	}
-}
-
 void btrfs_sysfs_remove_mounted(struct btrfs_fs_info *fs_info)
 {
 	btrfs_reset_fs_info_ptr(fs_info);
@@ -1076,6 +1046,36 @@ void btrfs_sysfs_update_sprout_fsid(struct btrfs_fs_devices *fs_devices,
 /* /sys/fs/btrfs/ entry */
 static struct kset *btrfs_kset;
 
+static void __btrfs_sysfs_remove_fsid(struct btrfs_fs_devices *fs_devs)
+{
+	if (fs_devs->devices_dir_kobj) {
+		kobject_del(fs_devs->devices_dir_kobj);
+		kobject_put(fs_devs->devices_dir_kobj);
+		fs_devs->devices_dir_kobj = NULL;
+	}
+
+	if (fs_devs->fsid_kobj.state_initialized) {
+		kobject_del(&fs_devs->fsid_kobj);
+		kobject_put(&fs_devs->fsid_kobj);
+		wait_for_completion(&fs_devs->kobj_unregister);
+	}
+}
+
+/* when fs_devs is NULL it will remove all fsid kobject */
+void btrfs_sysfs_remove_fsid(struct btrfs_fs_devices *fs_devs)
+{
+	struct list_head *fs_uuids = btrfs_get_fs_uuids();
+
+	if (fs_devs) {
+		__btrfs_sysfs_remove_fsid(fs_devs);
+		return;
+	}
+
+	list_for_each_entry(fs_devs, fs_uuids, fs_list) {
+		__btrfs_sysfs_remove_fsid(fs_devs);
+	}
+}
+
 /*
  * Can be called by the device discovery thread.
  * And parent can be specified for seed device
-- 
2.23.0

