Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B7BE69761B
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Aug 2019 11:26:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727316AbfHUJ0l (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 21 Aug 2019 05:26:41 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:34466 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726530AbfHUJ0l (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 21 Aug 2019 05:26:41 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7L9OIrI021301
        for <linux-btrfs@vger.kernel.org>; Wed, 21 Aug 2019 09:26:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : mime-version : content-transfer-encoding;
 s=corp-2019-08-05; bh=oEDzQ2i6XHoYBBvrSQhc0YoGgcJeagUucisRkljajrE=;
 b=VbahspWeiHM1uMgJlf2tRW6FI4E0mgJx2EBK+Avrap65EfjacwxBzP/q+P/RHPLMMFog
 tKytjXo4ig5cKQIcinYdlMGZx7UK9oDOpuNVOvA/KdDoZggTaVXOSit3H0IEYVl7Jikt
 1GCfNPUseGS9c/OA5/ogdtcsQ7fCABr36Lfun6GJXQy1TU0Z6zygysjQR7J1lZDnsIGB
 dAmOoZ2NDoke1WQvvfj/EUKQokRRXyvU+RSGD0vdyiUHTsLh76UiH64OE1EE3llef2LQ
 yWX+YJCsc0N0A4TJgZOZo+BfUfgTQeQU0YC9c/8EuOxMnnUTil1QNM2UxZa1xDNsBiei +Q== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 2ue9hpm90y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Wed, 21 Aug 2019 09:26:40 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7L9OHaG192162
        for <linux-btrfs@vger.kernel.org>; Wed, 21 Aug 2019 09:26:39 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 2uh2q49e1c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Wed, 21 Aug 2019 09:26:39 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x7L9QcW8004285
        for <linux-btrfs@vger.kernel.org>; Wed, 21 Aug 2019 09:26:38 GMT
Received: from localhost.localdomain (/39.109.145.141)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 21 Aug 2019 02:26:38 -0700
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 1/3] btrfs: dev stat drop useless goto
Date:   Wed, 21 Aug 2019 17:26:32 +0800
Message-Id: <20190821092634.6778-1-anand.jain@oracle.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-120)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9355 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1908210102
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9355 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908210102
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

In the function btrfs_init_dev_stats() goto out is not needed, because the
alloc has failed. So just return -ENOMEM.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 fs/btrfs/volumes.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 9b684adad81c..bd279db0f760 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -7289,10 +7289,8 @@ int btrfs_init_dev_stats(struct btrfs_fs_info *fs_info)
 	int i;
 
 	path = btrfs_alloc_path();
-	if (!path) {
-		ret = -ENOMEM;
-		goto out;
-	}
+	if (!path)
+		return -ENOMEM;
 
 	mutex_lock(&fs_devices->device_list_mutex);
 	list_for_each_entry(device, &fs_devices->devices, dev_list) {
@@ -7332,7 +7330,6 @@ int btrfs_init_dev_stats(struct btrfs_fs_info *fs_info)
 	}
 	mutex_unlock(&fs_devices->device_list_mutex);
 
-out:
 	btrfs_free_path(path);
 	return ret < 0 ? ret : 0;
 }
-- 
2.21.0 (Apple Git-120)

