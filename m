Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D96BC25E0F5
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Sep 2020 19:37:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727797AbgIDRhI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 4 Sep 2020 13:37:08 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:51226 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726317AbgIDRhH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 4 Sep 2020 13:37:07 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 084HXjc1037389;
        Fri, 4 Sep 2020 17:37:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=jFcyZLSfu8fQx6f1v2arjHUfnMfAJT1+0Tk637IWpjc=;
 b=QyZBaciylYlJ45FZI2DH+UO8Bt5EuCA435gUcuhyWqo/sOcg4voGBp82g9LW2/r1neE4
 uImqm3UQdKN4QtpccctJ+we6Bh9i8TswZEuY69zJJFnZQbKB/aU9wHRkOpNyVR7x8Rba
 2cQlH/cZynzWX0uANc1uWSncdGqDmC+jlimVAnN3pi6PPSKgHqV5IAVSP83uVgLszaNX
 VjbdbZ44LQJ6NCE7/R5UtNhY2fqqZTDilgu2emUgdRg17qI57vFL/s4CrDNNEoniBJa7
 5JSlDxaBEcac9AK7yHEQOE8kB11silE1sGye+5voxyHB36bceD9U4JdtAP0QN8y4vlJq zg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 339dmne3hx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 04 Sep 2020 17:37:01 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 084HVLGs083121;
        Fri, 4 Sep 2020 17:35:00 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 3380ktt9fj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 04 Sep 2020 17:35:00 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 084HYxq6028151;
        Fri, 4 Sep 2020 17:34:59 GMT
Received: from localhost.localdomain (/39.109.231.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 04 Sep 2020 10:34:58 -0700
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.com, josef@toxicpanda.com, nborisov@suse.com
Subject: [PATCH 05/16] btrfs: btrfs_sysfs_remove_devices_dir drop return value
Date:   Sat,  5 Sep 2020 01:34:25 +0800
Message-Id: <700c25c3811b9dd770ce460bb654f76d66286a55.1599234146.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1599234146.git.anand.jain@oracle.com>
References: <cover.1599234146.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9734 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 adultscore=0
 mlxscore=0 suspectscore=1 malwarescore=0 mlxlogscore=999 bulkscore=0
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

btrfs_sysfs_remove_devices_dir() return value is unused declare it as
void.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
Reviewed-by: Nikolay Borisov <nborisov@suse.com>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/sysfs.c | 8 +++-----
 fs/btrfs/sysfs.h | 4 ++--
 2 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index 33703fe01c72..5d7cb6a81f0d 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -1176,18 +1176,16 @@ static void btrfs_sysfs_remove_device(struct btrfs_device *device)
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

