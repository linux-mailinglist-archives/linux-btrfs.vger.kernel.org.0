Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2216E9DEEC
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Aug 2019 09:41:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728579AbfH0HlQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 27 Aug 2019 03:41:16 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:54846 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725890AbfH0HlP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 27 Aug 2019 03:41:15 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7R7cfnH061497
        for <linux-btrfs@vger.kernel.org>; Tue, 27 Aug 2019 07:41:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2019-08-05;
 bh=FMJTVtvL1oY8xXI8O2ypR3SuiH59RxnqPfJPPTy+cKo=;
 b=OLGsUUjrnHjSeTFuzzU7YuwcjRIsVDM+XwzZfKtf+qj4Rq9WcyvK9zTUuATrM5Kjkzfr
 toRJO79lx/GRm5Kea+l8nMZ9iXTTBgDp3iPpXd/pA9T77sdaKFjCigrpgV50f0E6Evh3
 cMdBADaeyM4TJN/PVE4v00o5lFmrmUxWwRJozDq9JCSYyP9eHFY66X5ZAVwuiZpWwtZ5
 E6XyVfrHpBKraJr95L4UKZRe1B+HYt8Gd9BcWWG4EuR4m5+gPgnft13kMGdM9zkS988R
 OqSKHSRU7uHvbiOfF8pjdB0zfV4XTnb/LX1LQOBvuv70tlQj3BFjzVCz2L2XoOM7nvFP SQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 2umyvt07pr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Tue, 27 Aug 2019 07:41:14 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7R7cdwl118871
        for <linux-btrfs@vger.kernel.org>; Tue, 27 Aug 2019 07:41:13 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 2umhu8cvft-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Tue, 27 Aug 2019 07:41:13 +0000
Received: from abhmp0022.oracle.com (abhmp0022.oracle.com [141.146.116.28])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x7R7fDAG006275
        for <linux-btrfs@vger.kernel.org>; Tue, 27 Aug 2019 07:41:13 GMT
Received: from localhost.localdomain (/183.90.37.214)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 27 Aug 2019 00:41:12 -0700
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 2/2] btrfs: fix error return on alloc fail in clone_fs_devices
Date:   Tue, 27 Aug 2019 15:40:45 +0800
Message-Id: <20190827074045.5563-3-anand.jain@oracle.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-120)
In-Reply-To: <20190827074045.5563-1-anand.jain@oracle.com>
References: <20190827074045.5563-1-anand.jain@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9361 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1908270085
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9361 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908270085
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Fix the fake ENOMEM return error code to the actual error in
clone_fs_devices().

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 fs/btrfs/volumes.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 36aa5f79fb6c..8d72098ccb4b 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -1115,6 +1115,7 @@ static struct btrfs_fs_devices *clone_fs_devices(struct btrfs_fs_devices *orig)
 	struct btrfs_fs_devices *fs_devices;
 	struct btrfs_device *device;
 	struct btrfs_device *orig_dev;
+	int ret = 0;
 
 	fs_devices = alloc_fs_devices(orig->fsid, NULL);
 	if (IS_ERR(fs_devices))
@@ -1128,8 +1129,10 @@ static struct btrfs_fs_devices *clone_fs_devices(struct btrfs_fs_devices *orig)
 
 		device = btrfs_alloc_device(NULL, &orig_dev->devid,
 					    orig_dev->uuid);
-		if (IS_ERR(device))
+		if (IS_ERR(device)) {
+			ret = PTR_ERR(device);
 			goto error;
+		}
 
 		/*
 		 * This is ok to do without rcu read locked because we hold the
@@ -1140,6 +1143,7 @@ static struct btrfs_fs_devices *clone_fs_devices(struct btrfs_fs_devices *orig)
 					GFP_KERNEL);
 			if (!name) {
 				btrfs_free_device(device);
+				ret = -ENOMEM;
 				goto error;
 			}
 			rcu_assign_pointer(device->name, name);
@@ -1154,7 +1158,7 @@ static struct btrfs_fs_devices *clone_fs_devices(struct btrfs_fs_devices *orig)
 error:
 	mutex_unlock(&orig->device_list_mutex);
 	free_fs_devices(fs_devices);
-	return ERR_PTR(-ENOMEM);
+	return ERR_PTR(ret);
 }
 
 /*
-- 
2.21.0 (Apple Git-120)

