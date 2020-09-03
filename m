Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 773B325B808
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Sep 2020 02:58:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726994AbgICA6P (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Sep 2020 20:58:15 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:38818 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726877AbgICA6O (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 2 Sep 2020 20:58:14 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0830sgMe125431
        for <linux-btrfs@vger.kernel.org>; Thu, 3 Sep 2020 00:58:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=PYnPc8IiVLp1la8aIs82hI+M1GDbV0csbJYs01Xo3qQ=;
 b=kjNDej2c50OEjkDuY3AQQhSKJeJVhFOZUZUFM4HE2+S7q1v2tYnXqSS45sODub6gxWB6
 BFoT51+Oal8ARWzJ+PddFTtGb/dNqFRVFT2A2+Uc1fVvcvzrp9xo3q8NASXyHqSpBFuk
 7WbPy4hT+5WmCyjav6CWq0IzRsxWjJVgX/DMWj1RkY3C1Z5Yqw/MVUYl0fIVg9+S8imH
 cEJAWUXjlDlszAXfUOXoLBx5yHaDYPkWAWJZ3vNXTW1g1Z0r1eR27kFvjHCU8HB/NURR
 d5XFaHQgKe2RdwbUIWbnZfO+wZdFg0zD2zlzmbiX40b88ShW81+IqUAhH6i9zjWEnFgR UA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 337eymdu2q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
        for <linux-btrfs@vger.kernel.org>; Thu, 03 Sep 2020 00:58:13 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0830tFnH105201
        for <linux-btrfs@vger.kernel.org>; Thu, 3 Sep 2020 00:58:12 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 3380kqwus8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Thu, 03 Sep 2020 00:58:12 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0830wC63020195
        for <linux-btrfs@vger.kernel.org>; Thu, 3 Sep 2020 00:58:12 GMT
Received: from localhost.localdomain (/39.109.231.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 02 Sep 2020 17:58:12 -0700
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 03/15] btrfs: btrfs_sysfs_remove_devices_dir drop return value
Date:   Thu,  3 Sep 2020 08:57:39 +0800
Message-Id: <5ff561bc46063a3fc7eb12a51600fe754b12ad0d.1599091832.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1599091832.git.anand.jain@oracle.com>
References: <cover.1599091832.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9732 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 adultscore=0
 mlxscore=0 suspectscore=1 malwarescore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009030004
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9732 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 adultscore=0
 priorityscore=1501 phishscore=0 mlxlogscore=999 mlxscore=0
 lowpriorityscore=0 clxscore=1015 spamscore=0 bulkscore=0 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009030004
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

btrfs_sysfs_remove_devices_dir() return value is unused declare it as
void.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 fs/btrfs/sysfs.c | 8 +++-----
 fs/btrfs/sysfs.h | 4 ++--
 2 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index 241ec0ad0379..7448caf12c53 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -1175,18 +1175,16 @@ static void btrfs_sysfs_remove_device(struct btrfs_device *device)
 }
 
 /* when 2nd argument device is NULL, it removes all devices link */
-int btrfs_sysfs_remove_devices_dir(struct btrfs_fs_devices *fs_devices,
-				   struct btrfs_device *one_device)
+void btrfs_sysfs_remove_devices_dir(struct btrfs_fs_devices *fs_devices,
+				    struct btrfs_device *one_device)
 {
 	if (one_device) {
 		btrfs_sysfs_remove_device(one_device);
-		return 0;
+		return;
 	}
 
 	list_for_each_entry(one_device, &fs_devices->devices, dev_list)
 		btrfs_sysfs_remove_device(one_device);
-
-	return 0;
 }
 
 static ssize_t btrfs_devinfo_in_fs_metadata_show(struct kobject *kobj,
diff --git a/fs/btrfs/sysfs.h b/fs/btrfs/sysfs.h
index 4217823e255c..bc995b0c1889 100644
--- a/fs/btrfs/sysfs.h
+++ b/fs/btrfs/sysfs.h
@@ -16,8 +16,8 @@ char *btrfs_printable_features(enum btrfs_feature_set set, u64 flags);
 const char *btrfs_feature_set_name(enum btrfs_feature_set set);
 int btrfs_sysfs_add_devices_dir(struct btrfs_fs_devices *fs_devices,
 		struct btrfs_device *one_device);
-int btrfs_sysfs_remove_devices_dir(struct btrfs_fs_devices *fs_devices,
-                struct btrfs_device *one_device);
+void btrfs_sysfs_remove_devices_dir(struct btrfs_fs_devices *fs_devices,
+				    struct btrfs_device *one_device);
 int btrfs_sysfs_add_fsid(struct btrfs_fs_devices *fs_devs);
 void btrfs_sysfs_remove_fsid(struct btrfs_fs_devices *fs_devs);
 void btrfs_sysfs_update_sprout_fsid(struct btrfs_fs_devices *fs_devices);
-- 
2.25.1

