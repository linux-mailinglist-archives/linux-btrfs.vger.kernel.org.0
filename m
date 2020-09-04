Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEDB925E0EC
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Sep 2020 19:35:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727995AbgIDRfY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 4 Sep 2020 13:35:24 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:60454 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727978AbgIDRfX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 4 Sep 2020 13:35:23 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 084HZ5vp141059;
        Fri, 4 Sep 2020 17:35:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=zFGpL86qwjJNYFzMDvrBxy/N0UGYe1q7SWZ5X3VZZPk=;
 b=AMpN49qzrmXBlyJV7NPUeQqlygm6MAp0zNrb6kacd9CyMXi4lSEqP7KO0rRF/NpqPPUe
 NAQFYfcjHC44ZZxeTeni7nbbu/HxYYAEeaKOL8OWvQ/ppzyDpGf5RbkGwKibyluqKLhN
 ld1VizPpzo7Zeeu0hztDcAOcGZXmamCruyB5fqQLbqr5/IhQlanV71oezfTAYcu6yBFL
 SoFcnfu2Kw7YhAmot8Jnb1adUjKJDMMW8mw/wLGCwBwCBmaI0Y1v23fcO+ctKXA1k9Zr
 Y0gYdiJGetpcv1kynh9Po+bKR0210d6i21ugfs2czfq/puYirtd1rF1A2xGwXTkGcgVs SQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 337eerfr9f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 04 Sep 2020 17:35:17 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 084HVLkV083118;
        Fri, 4 Sep 2020 17:35:16 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 3380ktt9yr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 04 Sep 2020 17:35:16 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 084HZFmp005784;
        Fri, 4 Sep 2020 17:35:15 GMT
Received: from localhost.localdomain (/39.109.231.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 04 Sep 2020 10:35:15 -0700
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.com, josef@toxicpanda.com, nborisov@suse.com
Subject: [PATCH 12/16] btrfs: open code list_head pointer in btrfs_init_dev_replace_tgtdev
Date:   Sat,  5 Sep 2020 01:34:32 +0800
Message-Id: <d08b8aba7c013a0f648a4aa2108bcb4d86f05b49.1599234146.git.anand.jain@oracle.com>
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
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 adultscore=0 spamscore=0 mlxscore=0
 phishscore=0 impostorscore=0 mlxlogscore=999 bulkscore=0 suspectscore=1
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009040152
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
index 70b4385a327c..f7325a748f89 100644
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

