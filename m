Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68E2C1BC35F
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 Apr 2020 17:25:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728556AbgD1PYq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 28 Apr 2020 11:24:46 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:55090 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728087AbgD1PYp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 28 Apr 2020 11:24:45 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03SFJKF7181664;
        Tue, 28 Apr 2020 15:24:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=egWcAgcJRWuK21nNwHczU9XRepvrfIwmPwjwirkUE+s=;
 b=QaHpMsxV5cuVDibDoj0eITlhbRUQlFMsEcqAYvrZfyXsZtlz7zlVZ+BHwA0DxbzS0kQ3
 xKnrkG/xtocPzK6uOy1MK95FDPmtFMEL1WPMtaLVQIzWzZcaqmAxNFjw18edE41rCy9z
 f/P01b2JICVuz5lxrRmqEgWRySz0BoyGoNVhChNA92Zb17RivCeuhLb/k2PCtt278iST
 NfN/7fln5nPd2dYNHdRhvt4G6r64YBYxNp3jPgO3VLQnz2+JPWQTDAsiVjUOSR7ZRJAi
 77NULqB458ZNw9a3uOMH2dJDDy9YsOvx/SKEFQZy94GTbYcBxnoWvoV9x62XA1cZ2Nhp RA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 30p01nq64e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Apr 2020 15:24:38 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03SFC2G6110996;
        Tue, 28 Apr 2020 15:22:37 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 30mxrsse6a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Apr 2020 15:22:37 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 03SFMbE2004847;
        Tue, 28 Apr 2020 15:22:37 GMT
Received: from localhost.localdomain (/39.109.243.230)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 28 Apr 2020 08:22:36 -0700
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.com, nborisov@suse.com, josef@toxicpanda.com
Subject: [PATCH 1/3] btrfs: drop useless goto in open_fs_devices
Date:   Tue, 28 Apr 2020 23:22:25 +0800
Message-Id: <20200428152227.8331-2-anand.jain@oracle.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200428152227.8331-1-anand.jain@oracle.com>
References: <20200428152227.8331-1-anand.jain@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9605 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 suspectscore=1
 mlxlogscore=999 malwarescore=0 bulkscore=0 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004280120
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9605 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 clxscore=1015
 phishscore=0 mlxlogscore=999 adultscore=0 priorityscore=1501 mlxscore=0
 suspectscore=1 malwarescore=0 lowpriorityscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004280120
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

There is no need of goto out in open_fs_devices() as there is nothing
special done at %out:. So refactor it.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
Reviewed-by: Nikolay Borisov <nborisov@suse.com>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/volumes.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index aa1e0ae32943..bf953c4895f3 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -1185,7 +1185,6 @@ static int open_fs_devices(struct btrfs_fs_devices *fs_devices,
 {
 	struct btrfs_device *device;
 	struct btrfs_device *latest_dev = NULL;
-	int ret = 0;
 
 	flags |= FMODE_EXCL;
 
@@ -1198,16 +1197,15 @@ static int open_fs_devices(struct btrfs_fs_devices *fs_devices,
 		    device->generation > latest_dev->generation)
 			latest_dev = device;
 	}
-	if (fs_devices->open_devices == 0) {
-		ret = -EINVAL;
-		goto out;
-	}
+	if (fs_devices->open_devices == 0)
+		return -EINVAL;
+
 	fs_devices->opened = 1;
 	fs_devices->latest_bdev = latest_dev->bdev;
 	fs_devices->total_rw_bytes = 0;
 	fs_devices->chunk_alloc_policy = BTRFS_CHUNK_ALLOC_REGULAR;
-out:
-	return ret;
+
+	return 0;
 }
 
 static int devid_cmp(void *priv, struct list_head *a, struct list_head *b)
-- 
2.23.0

