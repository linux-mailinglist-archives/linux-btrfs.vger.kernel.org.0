Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B960313BAD1
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Jan 2020 09:23:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726472AbgAOIX1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 Jan 2020 03:23:27 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:54922 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726088AbgAOIX0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 Jan 2020 03:23:26 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00F8IgQb186417
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Jan 2020 08:23:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2019-08-05;
 bh=+fOcqf/gRHyew8pAsPou7YANM+qfz/zfFBmk0JXJzEM=;
 b=ECF3yC8qSVRGXSDUcSp6cyLcfvLq/f+AaNa+XLoE/DwNa3zOg2wenwynLb3jP3xYsedT
 Ei4pIhtKEt/dpHcm5tZkZYQbbgEHZ83+don75UNkarYCyJBSfKVOgkrbYHK2a/yCE3Ks
 rAZx1uCUTXsheNVAGoRlYFzrdg9fAqIgB+HghYAIbsozP0/N76DnN54t+Hh0MHVZl9CV
 xlpQzgvyRi/ycv7GrJHcZh90bPXe6wNE67KlwAs2Ts8yYeyRIdKBsPPsQqAW4QntYiyX
 uAj58z6FlL2ncWSEv/SUJkb2uMa8HvqX1mps8VU7XUQ9wRyni5oOAzOSAl5FFEPQ6B7T +A== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 2xf73yjrxx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Jan 2020 08:23:25 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00F8J17m169258
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Jan 2020 08:23:24 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 2xh8etjahb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Jan 2020 08:23:24 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 00F8MsIn029347
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Jan 2020 08:22:54 GMT
Received: from mb.wifi.oracle.com (/192.188.170.109)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 15 Jan 2020 00:22:54 -0800
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: update devid after replace
Date:   Wed, 15 Jan 2020 16:22:50 +0800
Message-Id: <20200115082250.3064-1-anand.jain@oracle.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200114183958.GJ3929@twin.jikos.cz>
References: <20200114183958.GJ3929@twin.jikos.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9500 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=853
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001150069
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9500 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=920 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001150069
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

During the replace the target device temporarily assumes devid 0 before
assigning the devid of the soruce device.

In btrfs_dev_replace_finishing() we remove source sysfs devid using
the function btrfs_sysfs_remove_devices_attr(), so after that call
kobject_rename() to update the devid in the sysfs.
This adds and calls btrfs_sysfs_update_devid() helper function to update
the device id.

This patch must be squashed with the patch
 [PATCH v4] btrfs: sysfs, add devid/dev_state kobject and attribute
or its variant.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
David,
 I couldn't find the patch-series..
   [PATCH 0/4] btrfs, sysfs cleanup and add dev_state
 in your misc-next. And I believe there were changes like
 function rename and attribute list reorder in your workspace. So I am
 sending a fix-patch which must be squashed to the patch v4 4/4.

 With this patch, the test case btrfs/064 runs fine. And volume group
 tests are still running.
 
 fs/btrfs/dev-replace.c |  1 +
 fs/btrfs/sysfs.c       | 11 +++++++++++
 fs/btrfs/sysfs.h       |  1 +
 3 files changed, 13 insertions(+)

diff --git a/fs/btrfs/dev-replace.c b/fs/btrfs/dev-replace.c
index 9a29d6de9017..ccdb486bd4c3 100644
--- a/fs/btrfs/dev-replace.c
+++ b/fs/btrfs/dev-replace.c
@@ -707,6 +707,7 @@ static int btrfs_dev_replace_finishing(struct btrfs_fs_info *fs_info,
 
 	/* replace the sysfs entry */
 	btrfs_sysfs_remove_devices_attr(fs_info->fs_devices, src_device);
+	btrfs_sysfs_update_devid(tgt_device);
 	btrfs_rm_dev_replace_free_srcdev(src_device);
 
 	/* write back the superblocks */
diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index 0b615d99cedd..22971268e5b6 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -1189,6 +1189,17 @@ int btrfs_sysfs_remove_devices_attr(struct btrfs_fs_devices *fs_devices,
 	return 0;
 }
 
+void btrfs_sysfs_update_devid(struct btrfs_device *device)
+{
+	char tmp[64];
+
+	snprintf(tmp, sizeof(tmp), "%llu", device->devid);
+
+	if (kobject_rename(&device->devid_kobj, tmp))
+		btrfs_warn(device->fs_devices->fs_info,
+			   "sysfs: failed to update devid");
+}
+
 static ssize_t btrfs_sysfs_writeable_show(struct kobject *kobj,
 					  struct kobj_attribute *a, char *buf)
 {
diff --git a/fs/btrfs/sysfs.h b/fs/btrfs/sysfs.h
index 9d97b3c8db4e..ccf33eaf9e59 100644
--- a/fs/btrfs/sysfs.h
+++ b/fs/btrfs/sysfs.h
@@ -34,5 +34,6 @@ void btrfs_sysfs_add_block_group_type(struct btrfs_block_group *cache);
 int btrfs_sysfs_add_space_info_type(struct btrfs_fs_info *fs_info,
 				    struct btrfs_space_info *space_info);
 void btrfs_sysfs_remove_space_info(struct btrfs_space_info *space_info);
+void btrfs_sysfs_update_devid(struct btrfs_device *device);
 
 #endif
-- 
2.23.0

