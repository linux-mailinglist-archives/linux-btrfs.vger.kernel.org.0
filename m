Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 92BD5104F55
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Nov 2019 10:34:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727031AbfKUJdy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 21 Nov 2019 04:33:54 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:47928 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726343AbfKUJdy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 21 Nov 2019 04:33:54 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAL9T0V1068133
        for <linux-btrfs@vger.kernel.org>; Thu, 21 Nov 2019 09:33:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references; s=corp-2019-08-05;
 bh=1YZ30ni7OUtRq5IpOVL6W5KPwbpJWjaRb+U6nfXUl/c=;
 b=pjAX7zTmJqmRgOtYwZEDCfBmB+ol4cKzsbCHReJYaT0UPj5QyYzWkV6+OEd/+M3jM6D3
 eT8K6tBe2nXbq7hc/dk+NEk/QDk+lKObfZqETwphctYt6OXt1BaQz3GNq+PwcX/9GBL2
 uqZ4nWhHR7PAFaTgfjYxe5BjPqvIEqeOwAH8eNalzho6cjWl6B3611VBGPF7r+hbTbc1
 HbmmR39tMREqrb1iF2cihN4ont/f3RpcItILr6y7aXReoRd8uE6Ykg90Im61eKsiIrQf
 aTuzF/OT5ur8KeVqQ/oTZFB9SjQEXRztKUEAAq2RuIz63eUTZJmeCH1hCOsNAYh0puPw cw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 2wa9rqtsss-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Thu, 21 Nov 2019 09:33:52 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAL9Wwnn067251
        for <linux-btrfs@vger.kernel.org>; Thu, 21 Nov 2019 09:33:51 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 2wd47wn9e9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Thu, 21 Nov 2019 09:33:51 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id xAL9Xpud017731
        for <linux-btrfs@vger.kernel.org>; Thu, 21 Nov 2019 09:33:51 GMT
Received: from tp.localdomain (/39.109.145.141)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 21 Nov 2019 01:33:50 -0800
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 4/5] btrfs: sysfs, rename btrfs_sysfs_add_device()
Date:   Thu, 21 Nov 2019 17:33:33 +0800
Message-Id: <1574328814-12263-5-git-send-email-anand.jain@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1574328814-12263-1-git-send-email-anand.jain@oracle.com>
References: <1574328814-12263-1-git-send-email-anand.jain@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9447 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1911210087
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9447 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1911210086
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

btrfs_sysfs_add_device() creates the directory /sys/fs/btrfs/UUID/devices
but its function name is misleading. Rename it to
btrfs_sysfs_add_devices_kobj() instead. No functional changes.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
V2: rename to btrfs_sysfs_add_devices_kobj, instead of
    btrfs_sysfs_add_devices_dir

 fs/btrfs/disk-io.c | 2 +-
 fs/btrfs/sysfs.c   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 264c8f0d7dfa..c4cebc44f683 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -3090,7 +3090,7 @@ int __cold open_ctree(struct super_block *sb,
 		goto fail_block_groups;
 	}
 
-	ret = btrfs_sysfs_add_device(fs_devices);
+	ret = btrfs_sysfs_add_devices_kobj(fs_devices);
 	if (ret) {
 		btrfs_err(fs_info, "failed to init sysfs device interface: %d",
 				ret);
diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index 3fda2b3a74b8..e8dfa2561909 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -997,7 +997,7 @@ int btrfs_sysfs_remove_devices_attr(struct btrfs_fs_devices *fs_devices,
 	return 0;
 }
 
-int btrfs_sysfs_add_device(struct btrfs_fs_devices *fs_devs)
+int btrfs_sysfs_add_devices_kobj(struct btrfs_fs_devices *fs_devs)
 {
 	if (!fs_devs->devices_kobj)
 		fs_devs->devices_kobj = kobject_create_and_add("devices",
-- 
1.8.3.1

