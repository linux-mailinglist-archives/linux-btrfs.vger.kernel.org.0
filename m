Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 43F321000B3
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Nov 2019 09:47:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726776AbfKRIrg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 18 Nov 2019 03:47:36 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:47970 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726717AbfKRIrf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 18 Nov 2019 03:47:35 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAI8i5Cl093859
        for <linux-btrfs@vger.kernel.org>; Mon, 18 Nov 2019 08:47:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2019-08-05;
 bh=UQ+wJBcUY5IVaVy8nUdJ5n8RGJ7HfaobKp4r43nnlAs=;
 b=D62WD+auVgabcdgNc9/ZOHhNoCVJ8gGLzXlxQ6KnaziGTIguwd/DPzfPk7/RZY2pi6Yq
 Era1qZBvXlogNxpHMAYbc5o7FBucLSUmV1jUjlCNhQOdq5wapMGMq2vj/Bn9aqnToioE
 DCCNnr1t4/51gDZDFcI6EvjNzyqoZR6250/afDKX+/Vpe4Bd55LGSt5b7p9fjeqmiFlO
 VdaX/xegK5J1Hteg3+hExi5qswdHrtsw4WjdDNibc5LRa48jlCzWonh3YZa1SqaSAig6
 qiH7vvCXUBAzZiK39tIh3ckMENUCF9LFZrtrAhzpEZ9FH6FszDm6Y3Eq8DTJublAFQ1m kw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 2wa92pekb6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Mon, 18 Nov 2019 08:47:34 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAI8iL6e152953
        for <linux-btrfs@vger.kernel.org>; Mon, 18 Nov 2019 08:47:33 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 2watmr3jw8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Mon, 18 Nov 2019 08:47:33 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xAI8lXMC019036
        for <linux-btrfs@vger.kernel.org>; Mon, 18 Nov 2019 08:47:33 GMT
Received: from mb.wifi.oracle.com (/192.188.170.109)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 18 Nov 2019 00:47:32 -0800
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 15/15] btrfs: sysfs, unexport btrfs_sysfs_remove_mounted()
Date:   Mon, 18 Nov 2019 16:46:56 +0800
Message-Id: <20191118084656.3089-16-anand.jain@oracle.com>
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

btrfs_sysfs_remove_mounted() is always called along with
btrfs_sysfs_remove_fsid(), call btrfs_sysfs_remove_mounted() in
btrfs_sysfs_remove_fsid() as well. And unexport
btrfs_sysfs_remove_mounted().

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 fs/btrfs/disk-io.c | 2 --
 fs/btrfs/sysfs.c   | 4 +++-
 fs/btrfs/sysfs.h   | 1 -
 3 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 8f6a08bef490..28db7bbb437e 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -3299,7 +3299,6 @@ int __cold open_ctree(struct super_block *sb,
 	filemap_write_and_wait(fs_info->btree_inode->i_mapping);
 
 fail_sysfs:
-	btrfs_sysfs_remove_mounted(fs_info);
 	btrfs_sysfs_remove_fsid(fs_info);
 
 fail_block_groups:
@@ -3997,7 +3996,6 @@ void __cold close_ctree(struct btrfs_fs_info *fs_info)
 		btrfs_info(fs_info, "at unmount dio bytes count %lld",
 			   percpu_counter_sum(&fs_info->dio_bytes));
 
-	btrfs_sysfs_remove_mounted(fs_info);
 	btrfs_sysfs_remove_fsid(fs_info);
 
 	btrfs_free_fs_roots(fs_info);
diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index 74210ef59641..468a42c442cf 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -983,7 +983,7 @@ void btrfs_kobject_uevent(struct block_device *bdev, enum kobject_action action)
 			&disk_to_dev(bdev->bd_disk)->kobj);
 }
 
-void btrfs_sysfs_remove_mounted(struct btrfs_fs_info *fs_info)
+static void btrfs_sysfs_remove_mounted(struct btrfs_fs_info *fs_info)
 {
 	btrfs_reset_fs_info_ptr(fs_info);
 
@@ -1074,6 +1074,8 @@ void btrfs_sysfs_remove_fsid(struct btrfs_fs_info *fs_info)
 {
 	struct btrfs_fs_devices *fs_devices = fs_info->fs_devices;
 
+	btrfs_sysfs_remove_mounted(fs_info);
+
 	if (fs_devices->devices_dir_kobj) {
 		kobject_del(fs_devices->devices_dir_kobj);
 		kobject_put(fs_devices->devices_dir_kobj);
diff --git a/fs/btrfs/sysfs.h b/fs/btrfs/sysfs.h
index a977fe3bec64..2b01b3af5e50 100644
--- a/fs/btrfs/sysfs.h
+++ b/fs/btrfs/sysfs.h
@@ -28,7 +28,6 @@ void btrfs_kobject_uevent(struct block_device *bdev, enum kobject_action action)
 
 int __init btrfs_init_sysfs(void);
 void __cold btrfs_exit_sysfs(void);
-void btrfs_sysfs_remove_mounted(struct btrfs_fs_info *fs_info);
 void btrfs_sysfs_add_block_group_type(struct btrfs_block_group *cache);
 int btrfs_sysfs_add_space_info_type(struct btrfs_fs_info *fs_info,
 				    struct btrfs_space_info *space_info);
-- 
2.23.0

