Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0C4028594D
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Oct 2020 09:22:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727678AbgJGHWX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 7 Oct 2020 03:22:23 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:39012 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727672AbgJGHWW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 7 Oct 2020 03:22:22 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0977JQfY111898;
        Wed, 7 Oct 2020 07:22:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2020-01-29; bh=RX29MUHTMg/X8OvJ+pV50CFiPWU7iDxZ/vKIkJmp/eY=;
 b=WUS/fwxV+5GYuEDmAZfd4MRq04cJFZSdKlFGzs15JagSwk4sD0yJ+fwtL1XMth5m/lvO
 JSscJm1WjdYBwG01THTgbwWvmI43hfP1TiGzetreHoE6QuKTSqKNLWWQWt5JJyCk4ThA
 8YeNv1VlzH9bEcuAUOQNWDfcMWZXR6FVvwyfb7DqoeQtc2ACUxfGyZNhFPHuolOg7TrV
 pWE6Fk2OUV/brPHaF0hYF49KbYyyTc+6kx3HEHZYMsl4nwVh1fhKfTjc1Slrm5V3yzlS
 y/orFX8vaIJla5nSyUW4harDuErsZ7M4cvSlJq3RRXOGBqBZ5xTlOSPb5up4ujG1fkw2 Bw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 33xhxn00t7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 07 Oct 2020 07:22:18 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0977KEFU063030;
        Wed, 7 Oct 2020 07:20:18 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 33y37y6ds6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 07 Oct 2020 07:20:17 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0977KEc9015399;
        Wed, 7 Oct 2020 07:20:14 GMT
Received: from localhost.localdomain (/39.109.231.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 07 Oct 2020 00:20:14 -0700
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.com, Anand Jain <anand.jain@oracle.com>
Subject: [PATCH] btrfs: add fs_info generation to sysfs
Date:   Wed,  7 Oct 2020 15:20:03 +0800
Message-Id: <feba5530a78df4066d5052aed57d814eb6f95814.1602055130.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9766 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 spamscore=0
 mlxscore=0 malwarescore=0 suspectscore=1 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2010070047
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9766 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 bulkscore=0
 impostorscore=0 lowpriorityscore=0 suspectscore=1 phishscore=0
 mlxlogscore=999 adultscore=0 clxscore=1015 spamscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2010070047
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Matching with the information that's available from the ioctl
BTRFS_IOC_FS_INFO, this patch adds generation to the sysfs.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 fs/btrfs/sysfs.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index 279d9262b676..8424f5d0e5ed 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -854,6 +854,15 @@ static ssize_t btrfs_exclusive_operation_show(struct kobject *kobj,
 }
 BTRFS_ATTR(, exclusive_operation, btrfs_exclusive_operation_show);
 
+static ssize_t btrfs_generation_show(struct kobject *kobj,
+				     struct kobj_attribute *a, char *buf)
+{
+	struct btrfs_fs_info *fs_info = to_fs_info(kobj);
+
+	return scnprintf(buf, PAGE_SIZE, "%llu\n", fs_info->generation);
+}
+BTRFS_ATTR(, generation, btrfs_generation_show);
+
 static const struct attribute *btrfs_attrs[] = {
 	BTRFS_ATTR_PTR(, label),
 	BTRFS_ATTR_PTR(, nodesize),
@@ -863,6 +872,7 @@ static const struct attribute *btrfs_attrs[] = {
 	BTRFS_ATTR_PTR(, metadata_uuid),
 	BTRFS_ATTR_PTR(, checksum),
 	BTRFS_ATTR_PTR(, exclusive_operation),
+	BTRFS_ATTR_PTR(, generation),
 	NULL,
 };
 
-- 
2.25.1

