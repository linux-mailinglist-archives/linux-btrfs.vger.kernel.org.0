Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 931C5256EB7
	for <lists+linux-btrfs@lfdr.de>; Sun, 30 Aug 2020 16:42:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727918AbgH3Omp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 30 Aug 2020 10:42:45 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:58666 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726930AbgH3Olp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 30 Aug 2020 10:41:45 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07UEYlmE032347;
        Sun, 30 Aug 2020 14:41:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=n7VhY7Dr1n3fDbIqEsbZ5WD0qoPVey1JvV2XAR6H148=;
 b=sjbiRbnF+OwoMjuvhO81pbMUNiIyJ9uHmDLH325CwZV0bN5hLy32/pgO0bplspAIEmCF
 yZMdXQZ7j7iLGWNXYLdnwggywB0Do0hpkecUpMdaumhBpukV4GL9QMI9gi6nfvwdvhtl
 o/8boaC9a3EdzVXxIRQkXfhtuI+1e6tZqEUd8Iop5st+327Cfs2/sgNY5X96JzyxXvby
 5RWNsztMQ/+BJFNtpkQrk9EbK8pXw1h5ARwOt/MdHp7aS2/L8gSqPp88gCWLpmcY6I8V
 p4NE+GVKOMdr/kfHodge9LrIbmcrzru+H8W/6yGQinv05FHdTCzLlDtEjiEf40fBb8m/ eg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 337eeqk0r4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 30 Aug 2020 14:41:32 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07UEZY0k153328;
        Sun, 30 Aug 2020 14:41:32 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 3380xtr3xd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 30 Aug 2020 14:41:32 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 07UEfVX7002642;
        Sun, 30 Aug 2020 14:41:31 GMT
Received: from localhost.localdomain (/39.109.231.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 30 Aug 2020 07:41:31 -0700
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.com, josef@toxicpanda.com
Subject: [PATCH 06/11] btrfs: open code list_head pointer in btrfs_init_dev_replace_tgtdev
Date:   Sun, 30 Aug 2020 22:41:01 +0800
Message-Id: <65578c066d97a83bb220713966b0a2f5f9a8080b.1598792561.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1598792561.git.anand.jain@oracle.com>
References: <cover.1598792561.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9729 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 phishscore=0
 malwarescore=0 bulkscore=0 mlxscore=0 mlxlogscore=999 suspectscore=1
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008300118
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9729 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 adultscore=0 spamscore=0 mlxscore=0
 phishscore=0 impostorscore=0 mlxlogscore=999 bulkscore=0 suspectscore=1
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008300118
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

