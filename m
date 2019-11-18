Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C6BAC1000AB
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Nov 2019 09:47:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbfKRIrW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 18 Nov 2019 03:47:22 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:48206 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726464AbfKRIrW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 18 Nov 2019 03:47:22 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAI8i5qS105268
        for <linux-btrfs@vger.kernel.org>; Mon, 18 Nov 2019 08:47:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2019-08-05;
 bh=4J2mgIEJeKlPDqBt/T75o0ODJ82ciFy8HNQX7DU/JB8=;
 b=lXcS8G36O61njP1J2x756JFAAkf1vqkstKgne/gEVWJ6ij/+bQKrJeAgKkwNBXX2h6Bj
 qh0BsXw2mtfeF17hLk6DkcIai1RgssGOuqQPjWghsmT1lB6BE9CLaegtpLe+PhrW+B2k
 e1wfhLwae7aJ7wVrKACpgQl0Bv1J0+A6uKtjJzMiVYa6xQV8k46uye40V9uIC9Ldvf61
 n1N7PuR2RyjGC9FGhaBYIBxSMM12dZDPAEjjzH6cVWyEuOHrU0xmlfyZ03iHVywGtlrl
 19QR1B+lV534U6xuS3S4+LSXDrgDLzDfTmRu3kQtkElsiXEZnh3Q1HZcKesyZy4EZKUS KA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 2wa8htenr9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Mon, 18 Nov 2019 08:47:20 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAI8iJuV152713
        for <linux-btrfs@vger.kernel.org>; Mon, 18 Nov 2019 08:47:19 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 2watmr3h2g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Mon, 18 Nov 2019 08:47:19 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xAI8lJij018884
        for <linux-btrfs@vger.kernel.org>; Mon, 18 Nov 2019 08:47:19 GMT
Received: from mb.wifi.oracle.com (/192.188.170.109)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 18 Nov 2019 00:47:18 -0800
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 08/15] btrfs: sysfs, btrfs_sysfs_add_fsid() drop unused argument parent
Date:   Mon, 18 Nov 2019 16:46:49 +0800
Message-Id: <20191118084656.3089-9-anand.jain@oracle.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191118084656.3089-1-anand.jain@oracle.com>
References: <20191118084656.3089-1-anand.jain@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9444 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1911180079
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9444 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1911180079
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
 fs/btrfs/disk-io.c |  2 +-
 fs/btrfs/sysfs.c   | 11 +++++------
 fs/btrfs/sysfs.h   |  3 +--
 3 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 72191c213ac4..3f6a26d9afcd 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -3082,7 +3082,7 @@ int __cold open_ctree(struct super_block *sb,
 
 	btrfs_free_extra_devids(fs_devices, 1);
 
-	ret = btrfs_sysfs_add_fsid(fs_devices, NULL);
+	ret = btrfs_sysfs_add_fsid(fs_devices);
 	if (ret) {
 		btrfs_err(fs_info, "failed to init sysfs fsid interface: %d",
 				ret);
diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index 9494ccace624..42aeb2375f2a 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -1118,18 +1118,17 @@ void btrfs_sysfs_remove_fsid(struct btrfs_fs_devices *fs_devs)
 }
 
 /*
- * Can be called by the device discovery thread.
- * And parent can be specified for seed device
+ * Creates:
+ * 	/sys/fs/btrfs/UUID
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
index 3dac8e163056..6addc35deb67 100644
--- a/fs/btrfs/sysfs.h
+++ b/fs/btrfs/sysfs.h
@@ -18,8 +18,7 @@ int btrfs_sysfs_add_device_info(struct btrfs_fs_devices *fs_devices,
 		struct btrfs_device *one_device);
 int btrfs_sysfs_remove_device_info(struct btrfs_fs_devices *fs_devices,
                 struct btrfs_device *one_device);
-int btrfs_sysfs_add_fsid(struct btrfs_fs_devices *fs_devs,
-				struct kobject *parent);
+int btrfs_sysfs_add_fsid(struct btrfs_fs_devices *fs_devs);
 int btrfs_sysfs_add_devices_dir(struct btrfs_fs_devices *fs_devs);
 void btrfs_sysfs_remove_fsid(struct btrfs_fs_devices *fs_devs);
 void btrfs_sysfs_update_sprout_fsid(struct btrfs_fs_devices *fs_devices,
-- 
2.23.0

