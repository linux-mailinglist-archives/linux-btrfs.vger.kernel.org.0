Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A964712E4D7
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Jan 2020 11:13:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728029AbgABKNG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Jan 2020 05:13:06 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:42974 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728019AbgABKNG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Jan 2020 05:13:06 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 002AB5Ca130651
        for <linux-btrfs@vger.kernel.org>; Thu, 2 Jan 2020 10:13:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references; s=corp-2019-08-05;
 bh=IQ6pbwhHCkUjb4X+3lpiq3au8n8aXwGQyU6m7stpuEk=;
 b=JipUwczY2byz27TJD7wpuVDHf00mG9g5kEDQIufPi2nDx86FJe9j5Eg1gzSXuuixqUPx
 r/wSuuJM9ovT77Yjn63rzANZhSUBRst4qgNF7oNF2YWT6XQkbQv7HYqeekdLf1G44zrA
 JW2FH36yI8AqgGsR7isDhHeHvMSDAmruy07rd2x21tpNt/PsPDVFEvE3uIZIprqaagAQ
 QhpR5w6rXQRszgLD6aDTONmcpvvXyKLc0LcpCgixowO1GPfxo/MekvmrTPnk726pNF15
 OOO1MpaHWDcPdJUmrHkC3vUMMKM3NemJOS2nk3ok5DLwCl2fhnaSCVdWPSrfOSS8Y4y7 Yg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 2x5ypqpk2c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Thu, 02 Jan 2020 10:13:04 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 002A8fiS091826
        for <linux-btrfs@vger.kernel.org>; Thu, 2 Jan 2020 10:13:04 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 2x8bssv3ns-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Thu, 02 Jan 2020 10:13:04 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 002AD3v7008431
        for <linux-btrfs@vger.kernel.org>; Thu, 2 Jan 2020 10:13:03 GMT
Received: from tp.localdomain (/39.109.145.141)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 02 Jan 2020 02:13:02 -0800
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 2/3] btrfs: sysfs, add readmirror kobject
Date:   Thu,  2 Jan 2020 18:12:47 +0800
Message-Id: <1577959968-19427-3-git-send-email-anand.jain@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1577959968-19427-1-git-send-email-anand.jain@oracle.com>
References: <1577959968-19427-1-git-send-email-anand.jain@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9487 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001020092
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9487 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001020092
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Add

 /sys/fs/btrfs/UUID/readmirror

kobject so that we can add readmirror policies as attributes under it.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
v2: Fix compile error fs_info::readmirror_kobj member not found. As its
    fix in v1 went into patch 3/3 instead it should be here.
    
 fs/btrfs/sysfs.c   | 22 ++++++++++++++++++++++
 fs/btrfs/volumes.h |  1 +
 2 files changed, 23 insertions(+)

diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index d414b98fb27f..e604f292b42b 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -355,6 +355,10 @@ static ssize_t supported_checksums_show(struct kobject *kobj,
 
 #endif
 
+static const struct attribute *btrfs_readmirror_attrs[] = {
+	NULL,
+};
+
 static ssize_t btrfs_show_u64(u64 *value_ptr, spinlock_t *lock, char *buf)
 {
 	u64 val;
@@ -772,6 +776,13 @@ void btrfs_sysfs_remove_mounted(struct btrfs_fs_info *fs_info)
 {
 	btrfs_reset_fs_info_ptr(fs_info);
 
+	if (fs_info->fs_devices->readmirror_kobj) {
+		sysfs_remove_files(fs_info->fs_devices->readmirror_kobj,
+				   btrfs_readmirror_attrs);
+		kobject_del(fs_info->fs_devices->readmirror_kobj);
+		kobject_put(fs_info->fs_devices->readmirror_kobj);
+	}
+
 	if (fs_info->space_info_kobj) {
 		sysfs_remove_files(fs_info->space_info_kobj, allocation_attrs);
 		kobject_del(fs_info->space_info_kobj);
@@ -1224,6 +1235,17 @@ int btrfs_sysfs_add_mounted(struct btrfs_fs_info *fs_info)
 	if (error)
 		goto failure;
 
+	fs_devs->readmirror_kobj = kobject_create_and_add("readmirror",
+							  &fs_devs->fsid_kobj);
+	if (!fs_devs->readmirror_kobj) {
+		error = -ENOMEM;
+		goto failure;
+	}
+	error = sysfs_create_files(fs_devs->readmirror_kobj,
+				   btrfs_readmirror_attrs);
+	if (error)
+		goto failure;
+
 	return 0;
 failure:
 	btrfs_sysfs_remove_mounted(fs_info);
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index f5f091f3c72b..b49afa1cfdd7 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -268,6 +268,7 @@ struct btrfs_fs_devices {
 	struct completion kobj_unregister;
 
 	u8 readmirror;
+	struct kobject *readmirror_kobj;
 };
 
 #define BTRFS_BIO_INLINE_CSUM_SIZE	64
-- 
1.8.3.1

