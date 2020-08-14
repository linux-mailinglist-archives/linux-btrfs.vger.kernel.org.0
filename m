Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE1122441D7
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Aug 2020 02:04:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726653AbgHNAEJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 13 Aug 2020 20:04:09 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:36028 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726648AbgHNAEI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 13 Aug 2020 20:04:08 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07E03j3o070867
        for <linux-btrfs@vger.kernel.org>; Fri, 14 Aug 2020 00:04:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=L7sJIRI11BBcnWdg63hDbVoJQKqd0Nx0v4+Vs2ag72w=;
 b=mdTarCExfTti4J0ExIgrojdLYLCMUDgrBy4ixe5r39DAzl1FxQTkfYkvcZn25sSX2VGP
 p2iNpF+WM4op0JzhdGIeXsS8U3c639jFkom3vf9+i+7wbl21s1nE1bksi0xtR2cBKE3a
 4cfhfkvZjlOb8Sa2NMhDLQNpFYajD0pzhk9gbn5WMG//nuNTzPPazBYvlq76UKe7ap+Y
 daxCHCoAD6ALb0Q8hmIw2AQjxaNpeABTzCO1I8wfV5K08I00YVUBKGSUke2Wbn0Cn/LC
 mwT0DkaGCEegujGqqTscV13bZhirLjPHTz/bPXB9cReL8iMrRvUIB6aNfRxj2IZAFVjO gg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 32sm0n3jsa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
        for <linux-btrfs@vger.kernel.org>; Fri, 14 Aug 2020 00:04:07 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07DNwct6047035
        for <linux-btrfs@vger.kernel.org>; Fri, 14 Aug 2020 00:04:06 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 32t6046awb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Fri, 14 Aug 2020 00:04:06 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 07E045Vh003101
        for <linux-btrfs@vger.kernel.org>; Fri, 14 Aug 2020 00:04:05 GMT
Received: from localhost.localdomain (/39.109.231.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 14 Aug 2020 00:04:04 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 3/7] btrfs: open code list_head pointer in btrfs_init_dev_replace_tgtdev
Date:   Fri, 14 Aug 2020 08:03:48 +0800
Message-Id: <20200814000352.124179-4-anand.jain@oracle.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200814000352.124179-1-anand.jain@oracle.com>
References: <20200814000352.124179-1-anand.jain@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9712 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 phishscore=0
 bulkscore=0 adultscore=0 spamscore=0 suspectscore=1 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008130164
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9712 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 clxscore=1015
 suspectscore=1 mlxlogscore=999 priorityscore=1501 adultscore=0
 impostorscore=0 spamscore=0 bulkscore=0 mlxscore=0 lowpriorityscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008130164
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

In the function btrfs_init_dev_replace_tgtdev(), the local
variable struct list_head *devices is used only once, instead
just open code the same.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 fs/btrfs/dev-replace.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/btrfs/dev-replace.c b/fs/btrfs/dev-replace.c
index db93909b25e0..76dda11d441b 100644
--- a/fs/btrfs/dev-replace.c
+++ b/fs/btrfs/dev-replace.c
@@ -224,7 +224,6 @@ static int btrfs_init_dev_replace_tgtdev(struct btrfs_fs_info *fs_info,
 {
 	struct btrfs_device *device;
 	struct block_device *bdev;
-	struct list_head *devices;
 	struct rcu_string *name;
 	u64 devid = BTRFS_DEV_REPLACE_DEVID;
 	int ret = 0;
@@ -244,8 +243,7 @@ static int btrfs_init_dev_replace_tgtdev(struct btrfs_fs_info *fs_info,
 
 	sync_blockdev(bdev);
 
-	devices = &fs_info->fs_devices->devices;
-	list_for_each_entry(device, devices, dev_list) {
+	list_for_each_entry(device, &fs_info->fs_devices->devices, dev_list) {
 		if (device->bdev == bdev) {
 			btrfs_err(fs_info,
 				  "target device is in the filesystem!");
-- 
2.18.2

