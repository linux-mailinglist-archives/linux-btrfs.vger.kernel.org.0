Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B57E1000A3
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Nov 2019 09:47:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726488AbfKRIrK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 18 Nov 2019 03:47:10 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:47558 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726371AbfKRIrK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 18 Nov 2019 03:47:10 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAI8iOZQ094169
        for <linux-btrfs@vger.kernel.org>; Mon, 18 Nov 2019 08:47:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2019-08-05;
 bh=CGnq32Ivd/twgu8kzg/T9TaNUxZaHhwDceD2Wm4eE28=;
 b=OmiQVHPfPaZRwNuePa5pUT62NJOSj5GiigYmrc+rHF0KDdnCml8USETlG6hnnye8A1Xw
 pPz7TUOMbrftLtqPSVxgGttmQtJ3Ye/64q0Kf+lHCR3Mf4wfrx5eE0bgeDmuaaWjc8lS
 V1vVcZSE6T4GJ+odOwWgY6CBKYX0cGqSBUxMz7cKVENnOgbadS6eU3MlmYSEEN2jT/g/
 u+9JUDKz2CdCg2oOGlpTXESiP3h2Z+xrjftnEZnZmOyBT4XOCqfNWrwFjZF2gZNiKjod
 y8wArC2C5Vw4lgFgX9eAQqBVlHOynpBLxrDZuYq5/hYPzOyRVYoFXCJzycqF3K62Abyu Tg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 2wa92pek8m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Mon, 18 Nov 2019 08:47:08 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAI8hwIU021170
        for <linux-btrfs@vger.kernel.org>; Mon, 18 Nov 2019 08:47:07 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 2wau8mtacj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Mon, 18 Nov 2019 08:47:07 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xAI8l69K018801
        for <linux-btrfs@vger.kernel.org>; Mon, 18 Nov 2019 08:47:06 GMT
Received: from mb.wifi.oracle.com (/192.188.170.109)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 18 Nov 2019 00:47:05 -0800
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 02/15] btrfs: sysfs, rename btrfs_sysfs_add_device()
Date:   Mon, 18 Nov 2019 16:46:43 +0800
Message-Id: <20191118084656.3089-3-anand.jain@oracle.com>
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

btrfs_sysfs_add_device() creates the directory /sys/fs/btrfs/UUID/devices
but its function name is misleading. Rename it to
btrfs_sysfs_add_devices_dir() instead. No functional changes.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 fs/btrfs/disk-io.c | 2 +-
 fs/btrfs/sysfs.c   | 2 +-
 fs/btrfs/sysfs.h   | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index e0edfdc9c82b..72191c213ac4 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -3089,7 +3089,7 @@ int __cold open_ctree(struct super_block *sb,
 		goto fail_block_groups;
 	}
 
-	ret = btrfs_sysfs_add_device(fs_devices);
+	ret = btrfs_sysfs_add_devices_dir(fs_devices);
 	if (ret) {
 		btrfs_err(fs_info, "failed to init sysfs device interface: %d",
 				ret);
diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index 76ee266f0b8d..399b9c46790c 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -1007,7 +1007,7 @@ int btrfs_sysfs_remove_device_info(struct btrfs_fs_devices *fs_devices,
 	return 0;
 }
 
-int btrfs_sysfs_add_device(struct btrfs_fs_devices *fs_devs)
+int btrfs_sysfs_add_devices_dir(struct btrfs_fs_devices *fs_devs)
 {
 	if (!fs_devs->device_dir_kobj)
 		fs_devs->device_dir_kobj = kobject_create_and_add("devices",
diff --git a/fs/btrfs/sysfs.h b/fs/btrfs/sysfs.h
index 4b624e7d97c1..3dac8e163056 100644
--- a/fs/btrfs/sysfs.h
+++ b/fs/btrfs/sysfs.h
@@ -20,7 +20,7 @@ int btrfs_sysfs_remove_device_info(struct btrfs_fs_devices *fs_devices,
                 struct btrfs_device *one_device);
 int btrfs_sysfs_add_fsid(struct btrfs_fs_devices *fs_devs,
 				struct kobject *parent);
-int btrfs_sysfs_add_device(struct btrfs_fs_devices *fs_devs);
+int btrfs_sysfs_add_devices_dir(struct btrfs_fs_devices *fs_devs);
 void btrfs_sysfs_remove_fsid(struct btrfs_fs_devices *fs_devs);
 void btrfs_sysfs_update_sprout_fsid(struct btrfs_fs_devices *fs_devices,
 				    const u8 *fsid);
-- 
2.23.0

