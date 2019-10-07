Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D3E06CDE6C
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Oct 2019 11:45:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727509AbfJGJpZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Oct 2019 05:45:25 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:33520 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726010AbfJGJpY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Oct 2019 05:45:24 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x979dI28065891
        for <linux-btrfs@vger.kernel.org>; Mon, 7 Oct 2019 09:45:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2019-08-05;
 bh=V9tib0wsL/GdEx7feZAGzq0ied+zxMxr68qEnb04CXw=;
 b=qI4IgdFTZV0w3iuaps7CkJzPZUUBazsgjcI05UbGGX69wfW43RS+j6bSKF+VromQg8SK
 2HQuPaw4MTjoLgT+LMgLkBmVk4nhoXz42/btxeWSvvPYW6aZR/fEhbUsdVfU6aq7IUSI
 9rWyU2zkcTHclfPiGmkOd3rTB7HW1WjZp6io6FBJ6923u8t4h3F8RmzBgUBuK/1DpfIO
 lXeNI1g+8eXYdWY4ngyyMF5Wk74+p7a5XroWhN5J4vYR7sigbG5iujfMictdLAnhX65I
 AAzGC0kCIhKMjI2ZVgJjOk12fX8DSxOxNVpEEzzvHSn0qxrUt8w/lqx3tTpeuNUudNA5 MA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 2vejku5qa4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Mon, 07 Oct 2019 09:45:23 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x979cQ40077608
        for <linux-btrfs@vger.kernel.org>; Mon, 7 Oct 2019 09:45:22 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 2vg1ytjug9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Mon, 07 Oct 2019 09:45:22 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x979jLSJ003933
        for <linux-btrfs@vger.kernel.org>; Mon, 7 Oct 2019 09:45:21 GMT
Received: from localhost.localdomain (/39.109.145.141)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 07 Oct 2019 02:45:20 -0700
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 1/5] btrfs: drop useless goto in open_fs_devices
Date:   Mon,  7 Oct 2019 17:45:11 +0800
Message-Id: <20191007094515.925-2-anand.jain@oracle.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191007094515.925-1-anand.jain@oracle.com>
References: <20191007094515.925-1-anand.jain@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9402 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910070097
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9402 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910070097
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

There is no need of goto out in open_fs_devices() as there is nothing
special done at %out:. So refactor it.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
Reviewed-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/volumes.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index bba74e3bd9d8..c223a8147bfd 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -1123,7 +1123,6 @@ static int open_fs_devices(struct btrfs_fs_devices *fs_devices,
 {
 	struct btrfs_device *device;
 	struct btrfs_device *latest_dev = NULL;
-	int ret = 0;
 
 	flags |= FMODE_EXCL;
 
@@ -1136,15 +1135,14 @@ static int open_fs_devices(struct btrfs_fs_devices *fs_devices,
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
-out:
-	return ret;
+
+	return 0;
 }
 
 static int devid_cmp(void *priv, struct list_head *a, struct list_head *b)
-- 
1.8.3.1

