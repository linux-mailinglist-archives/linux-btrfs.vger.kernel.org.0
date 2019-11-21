Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 247F1104F54
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Nov 2019 10:34:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727016AbfKUJdw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 21 Nov 2019 04:33:52 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:36394 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726343AbfKUJdw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 21 Nov 2019 04:33:52 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAL9SwgT093073
        for <linux-btrfs@vger.kernel.org>; Thu, 21 Nov 2019 09:33:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references; s=corp-2019-08-05;
 bh=aGSRDtHf7FTiyVJcYNSxUzBVK+szK2wRNaPDZdXt8Qo=;
 b=RS5Dad3Y+aYZ0bAzycuqfkIFQJvlmZFtMz124OKMpe1uugG9+3q1ZLvkiWt4IXJdB6BM
 o909twuUKJNyzMTLp88jhRGidnNUbDj24TUmIwl5wwdJdnRmTG649tWCtsvv9nGzSwZE
 mpq4q0nK/PHHkCsbBfh42ivAnrCHjJ1akGphjt1vNEYu0HLXq0ibHLviIrkKNZ4xs7Ge
 S+N8hkUveqohegPQJiMHUiXf1LAwzruCHW4HY3+/y8JYCX9s0gq1pw7c92DaNcInqAW4
 ojS9JzFGK1522uIVKnCqQvLMLv6jVzBaHS/nJZoKiSvhh58JLxQDagpdqlX+4UneLE// ig== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 2wa8hu2wm2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Thu, 21 Nov 2019 09:33:50 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAL9Wlxk017610
        for <linux-btrfs@vger.kernel.org>; Thu, 21 Nov 2019 09:33:50 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 2wd46y0apm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Thu, 21 Nov 2019 09:33:50 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id xAL9XnI5017705
        for <linux-btrfs@vger.kernel.org>; Thu, 21 Nov 2019 09:33:49 GMT
Received: from tp.localdomain (/39.109.145.141)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 21 Nov 2019 01:33:48 -0800
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 3/5] btrfs: sysfs, btrfs_sysfs_add_fsid() drop unused argument parent
Date:   Thu, 21 Nov 2019 17:33:32 +0800
Message-Id: <1574328814-12263-4-git-send-email-anand.jain@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1574328814-12263-1-git-send-email-anand.jain@oracle.com>
References: <1574328814-12263-1-git-send-email-anand.jain@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9447 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1911210087
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9447 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1911210086
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Commit 24bd69cb (Btrfs: sysfs: add support to add parent for fsid)
added parent argument in preparation to show the seed fsid under the
sprout fsid as in the patch [1] in the mailing list.

 [1] Btrfs: sysfs: support seed devices in the sysfs layout

But later this idea was superseded by another idea to rename the fsid
as in the commit f93c39970b1d (btrfs: factor out sysfs code for updating
sprout fsid).

So we don't need parent argument anymore.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
V2: comment updated.

 fs/btrfs/disk-io.c |  2 +-
 fs/btrfs/sysfs.c   | 11 ++++++-----
 fs/btrfs/sysfs.h   |  5 ++---
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index b521e9085228..264c8f0d7dfa 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -3083,7 +3083,7 @@ int __cold open_ctree(struct super_block *sb,
 
 	btrfs_free_extra_devids(fs_devices, 1);
 
-	ret = btrfs_sysfs_add_fsid(fs_devices, NULL);
+	ret = btrfs_sysfs_add_fsid(fs_devices);
 	if (ret) {
 		btrfs_err(fs_info, "failed to init sysfs fsid interface: %d",
 				ret);
diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index a9bb507a06f1..3fda2b3a74b8 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -1067,18 +1067,19 @@ void btrfs_sysfs_update_sprout_fsid(struct btrfs_fs_devices *fs_devices,
 static struct kset *btrfs_kset;
 
 /*
+ * Creates:
+ *		/sys/fs/btrfs/UUID
+ *
  * Can be called by the device discovery thread.
- * And parent can be specified for seed device
  */
-int btrfs_sysfs_add_fsid(struct btrfs_fs_devices *fs_devs,
-				struct kobject *parent)
+int btrfs_sysfs_add_fsid(struct btrfs_fs_devices *fs_devs)
 {
 	int error;
 
 	init_completion(&fs_devs->kobj_unregister);
 	fs_devs->fsid_kobj.kset = btrfs_kset;
-	error = kobject_init_and_add(&fs_devs->fsid_kobj,
-				&btrfs_ktype, parent, "%pU", fs_devs->fsid);
+	error = kobject_init_and_add(&fs_devs->fsid_kobj, &btrfs_ktype, NULL,
+				     "%pU", fs_devs->fsid);
 	if (error) {
 		kobject_put(&fs_devs->fsid_kobj);
 		return error;
diff --git a/fs/btrfs/sysfs.h b/fs/btrfs/sysfs.h
index 4a9057def6ad..f7ddcbf4a40d 100644
--- a/fs/btrfs/sysfs.h
+++ b/fs/btrfs/sysfs.h
@@ -18,9 +18,8 @@ int btrfs_sysfs_add_devices_attr(struct btrfs_fs_devices *fs_devices,
 		struct btrfs_device *one_device);
 int btrfs_sysfs_remove_devices_attr(struct btrfs_fs_devices *fs_devices,
                 struct btrfs_device *one_device);
-int btrfs_sysfs_add_fsid(struct btrfs_fs_devices *fs_devs,
-				struct kobject *parent);
-int btrfs_sysfs_add_device(struct btrfs_fs_devices *fs_devs);
+int btrfs_sysfs_add_fsid(struct btrfs_fs_devices *fs_devs);
+int btrfs_sysfs_add_devices_kobj(struct btrfs_fs_devices *fs_devs);
 void btrfs_sysfs_remove_fsid(struct btrfs_fs_devices *fs_devs);
 void btrfs_sysfs_update_sprout_fsid(struct btrfs_fs_devices *fs_devices,
 				    const u8 *fsid);
-- 
1.8.3.1

