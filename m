Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3ADE25B815
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Sep 2020 02:58:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728001AbgICA6c (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Sep 2020 20:58:32 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:39232 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727932AbgICA60 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 2 Sep 2020 20:58:26 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0830u7T0048649
        for <linux-btrfs@vger.kernel.org>; Thu, 3 Sep 2020 00:58:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=Bx1/dRTyLHkIWOzbPa3Ysamw9/XsHqBDt3QfudzOZd8=;
 b=Kk5c8+GmIlO6RaOuSV8MTQ9BcmQBTkZRnG1zmGnG65vhJnrT9wNwCOoMQWWbpw7AtIfq
 PHQv1Zcy6DwfTA06B2D217tDhX09a5NDL3vnhC6n8UgGulD+7B7DgHNKcSYvbmnEGe/J
 0iomUOOf7oKb2UNG5fKHbB3f+JvbDGcf7eiYjAjl9HCbRovrZX7xhb6P+qmGE2HBr6ut
 4YFJIP3MSktln9YR/JGHMEMc/Hcg5nSwo3lGdZK2zW7bR5gF2okJG5oSL0juQ5iJl06M
 AU/TXfBVJXyzEdNDkoxsNT7F6p2EV9w1x3IRJmJiUo8KERbnD7vTyPh4u88KOqQK8TbU xQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 337eer5xaq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
        for <linux-btrfs@vger.kernel.org>; Thu, 03 Sep 2020 00:58:25 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0830tEqp105151
        for <linux-btrfs@vger.kernel.org>; Thu, 3 Sep 2020 00:58:24 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 3380kqwuw0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Thu, 03 Sep 2020 00:58:24 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0830wNha017171
        for <linux-btrfs@vger.kernel.org>; Thu, 3 Sep 2020 00:58:23 GMT
Received: from localhost.localdomain (/39.109.231.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 02 Sep 2020 17:58:23 -0700
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 10/15] btrfs: open code list_head pointer in btrfs_init_dev_replace_tgtdev
Date:   Thu,  3 Sep 2020 08:57:46 +0800
Message-Id: <25473568cb1a09ef14821a554055d9dffb009d3f.1599091832.git.anand.jain@oracle.com>
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
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 adultscore=0 spamscore=0 mlxscore=0
 phishscore=0 impostorscore=0 mlxlogscore=999 bulkscore=0 suspectscore=1
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009030004
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

In the function btrfs_init_dev_replace_tgtdev(), the local
variable struct list_head *devices is used only once, instead
just open code the same.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
Reviewed-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/dev-replace.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/btrfs/dev-replace.c b/fs/btrfs/dev-replace.c
index a7b1ad4e5706..aea1c782c009 100644
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
2.25.1

