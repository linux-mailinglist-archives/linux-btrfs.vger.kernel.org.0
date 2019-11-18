Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DABEA1000B0
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Nov 2019 09:47:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726750AbfKRIra (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 18 Nov 2019 03:47:30 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:48386 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726721AbfKRIra (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 18 Nov 2019 03:47:30 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAI8i50f105280
        for <linux-btrfs@vger.kernel.org>; Mon, 18 Nov 2019 08:47:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2019-08-05;
 bh=fkE/WhsMJUadIyLQXTlpxnJg0tOtNrymqumRBL5m7Lo=;
 b=aO3p87qhr8Ojmt98H9cSPiyl2dMRM3pTzOL05uGwUGvU4Tppmye7ZG3ea4H3+WKwB6oG
 NmnyuACzcrNp8ELWV77pCd/tl8W7nnMt5jpX+oWUf13hzjiFks0ndpyUreE1IhNM5/7z
 TzJ/Z+YtI4JeOfJ1nGMbu2QdihgDnvictmuBc+pzB89p42FwrhOObLSiqSXqDMiI2amk
 Cxw5mxijQw5f/5zYc4RvRYrLZVcXDjwaNEeXx8svFTU5jcw+tdYFmztAh/CtxpY0KFfa
 quKX/6YNXFQvtpr9JtDXPcZh2JMslLVtKmUknTvHqYQEP0g/ORc240rC0VEE5rlbsIGT XA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 2wa8htens7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Mon, 18 Nov 2019 08:47:28 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAI8iKVj152788
        for <linux-btrfs@vger.kernel.org>; Mon, 18 Nov 2019 08:47:27 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 2watmr3j3n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Mon, 18 Nov 2019 08:47:27 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id xAI8lRIf005690
        for <linux-btrfs@vger.kernel.org>; Mon, 18 Nov 2019 08:47:27 GMT
Received: from mb.wifi.oracle.com (/192.188.170.109)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 18 Nov 2019 00:47:26 -0800
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 12/15] btrfs: sysfs, unexport btrfs_sysfs_add_mounted()
Date:   Mon, 18 Nov 2019 16:46:53 +0800
Message-Id: <20191118084656.3089-13-anand.jain@oracle.com>
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

In open_ctree() we call btrfs_sysfs_add_fsid() to create
/sys/fs/btrfs/UUID kobject, and in the following line of code in
open_ctree() we call btrfs_sysfs_add_mounted() to create its attributes.
And there is no other users of btrfs_sysfs_add_mounted(). So let
btrfs_sysfs_add_fsid() also create its attributes and make
btrfs_sysfs_add_mounted() a local static function.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 fs/btrfs/disk-io.c | 8 --------
 fs/btrfs/sysfs.c   | 9 ++++++++-
 fs/btrfs/sysfs.h   | 1 -
 3 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 85ec0a3d2019..8f6a08bef490 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -3089,12 +3089,6 @@ int __cold open_ctree(struct super_block *sb,
 		goto fail_block_groups;
 	}
 
-	ret = btrfs_sysfs_add_mounted(fs_info);
-	if (ret) {
-		btrfs_err(fs_info, "failed to init sysfs interface: %d", ret);
-		goto fail_fsdev_sysfs;
-	}
-
 	ret = btrfs_init_space_info(fs_info);
 	if (ret) {
 		btrfs_err(fs_info, "failed to initialize space info: %d", ret);
@@ -3306,8 +3300,6 @@ int __cold open_ctree(struct super_block *sb,
 
 fail_sysfs:
 	btrfs_sysfs_remove_mounted(fs_info);
-
-fail_fsdev_sysfs:
 	btrfs_sysfs_remove_fsid(fs_info);
 
 fail_block_groups:
diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index 806676ef008a..2ea27c2d9ef1 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -998,7 +998,7 @@ void btrfs_sysfs_remove_mounted(struct btrfs_fs_info *fs_info)
 	btrfs_sysfs_remove_device_info(fs_info->fs_devices, NULL);
 }
 
-int btrfs_sysfs_add_mounted(struct btrfs_fs_info *fs_info)
+static int btrfs_sysfs_add_mounted(struct btrfs_fs_info *fs_info)
 {
 	int error;
 	struct btrfs_fs_devices *fs_devs = fs_info->fs_devices;
@@ -1129,6 +1129,13 @@ int btrfs_sysfs_add_fsid(struct btrfs_fs_info *fs_info)
 		return -ENOMEM;
 	}
 
+	error = btrfs_sysfs_add_mounted(fs_info);
+	if (error) {
+		btrfs_err(fs_info, "failed to init sysfs interface: %d", error);
+		btrfs_sysfs_remove_fsid(fs_info);
+		return error;
+	}
+
 	return 0;
 }
 
diff --git a/fs/btrfs/sysfs.h b/fs/btrfs/sysfs.h
index 0648afbb40ca..a977fe3bec64 100644
--- a/fs/btrfs/sysfs.h
+++ b/fs/btrfs/sysfs.h
@@ -28,7 +28,6 @@ void btrfs_kobject_uevent(struct block_device *bdev, enum kobject_action action)
 
 int __init btrfs_init_sysfs(void);
 void __cold btrfs_exit_sysfs(void);
-int btrfs_sysfs_add_mounted(struct btrfs_fs_info *fs_info);
 void btrfs_sysfs_remove_mounted(struct btrfs_fs_info *fs_info);
 void btrfs_sysfs_add_block_group_type(struct btrfs_block_group *cache);
 int btrfs_sysfs_add_space_info_type(struct btrfs_fs_info *fs_info,
-- 
2.23.0

