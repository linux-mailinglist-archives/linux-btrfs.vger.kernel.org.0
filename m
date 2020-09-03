Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42BFB25C5B6
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Sep 2020 17:49:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728337AbgICPtr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 3 Sep 2020 11:49:47 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:50090 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726025AbgICPtr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 3 Sep 2020 11:49:47 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 083DT1qv153081
        for <linux-btrfs@vger.kernel.org>; Thu, 3 Sep 2020 13:30:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=oLR4RHUZ3OwtaTbCRrCnzVZBRYjRTVJfAKuyxO2T8c4=;
 b=EgifnIiHLcWbCDsFkVlXd5RoJ5Ee7701yVg1ost0dnO1GZjVifBjor6mFz1l9krUL6eH
 gLwAv3Iq0raM/1DycD+mUxcksh6rLmhvgxyAwK823LJNfVRxvh/pZfbL6zJpbM1eujRE
 zblHpBa4yKpGCdk2DwBQPnLJtzlhVJ+VBhr0w1LKIMyn+NCA5CGoNJap35rNzw/y+aZ1
 jyBaR4e7ofZnFMZQIlSElYMWH6rGsDTzExiFuAh1gKHqltzcLFebM0Dnzq5vfu9b9R5t
 rgCnw/KRJ4Ow83QHyHTbrm6K87ESUFtEFj2kif17+eXsC0T532X281P4ly+sWgv41LDI /Q== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 337eymgnwr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
        for <linux-btrfs@vger.kernel.org>; Thu, 03 Sep 2020 13:30:27 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 083DL7Il108420
        for <linux-btrfs@vger.kernel.org>; Thu, 3 Sep 2020 13:30:27 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 3380sw6ass-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Thu, 03 Sep 2020 13:30:27 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 083DUQTi020476
        for <linux-btrfs@vger.kernel.org>; Thu, 3 Sep 2020 13:30:26 GMT
Received: from localhost.localdomain (/39.109.231.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 03 Sep 2020 06:30:25 -0700
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2] btrfs: improve messages when devices rescanned
Date:   Thu,  3 Sep 2020 21:30:12 +0800
Message-Id: <674264e45246039a7d294415b2e0f42434ec8070.1599139776.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <77fc0b0c7c88b14c734b646d1969ccf45a063146.1599118052.git.anand.jain@oracle.com>
References: <77fc0b0c7c88b14c734b646d1969ccf45a063146.1599118052.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9732 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 phishscore=0 malwarescore=0 mlxscore=0 spamscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009030125
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9732 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 priorityscore=1501 phishscore=0 mlxlogscore=999 mlxscore=0
 lowpriorityscore=0 clxscore=1015 spamscore=0 bulkscore=0 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009030124
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Systems booting without the initramfs seems to scan an unusual kind
of device path. And at a later time, the device is updated to the
correct path. We generally print the process name and PID of the process
scanning the device but we don't capture the same information if the
device path is rescanned with a different pathname.

But the current message is too long, so drop the unwanted words and add
process name and PID.

While at this also update the duplicate device warning to include the
process name and PID.

Reported-by: https://bugzilla.kernel.org/show_bug.cgi?id=89721
Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
v2: adds devid and scanned

 fs/btrfs/volumes.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index dc81646b13c0..60f8ea7232b5 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -942,16 +942,18 @@ static noinline struct btrfs_device *device_list_add(const char *path,
 				bdput(path_bdev);
 				mutex_unlock(&fs_devices->device_list_mutex);
 				btrfs_warn_in_rcu(device->fs_info,
-			"duplicate device fsid:devid for %pU:%llu old:%s new:%s",
-					disk_super->fsid, devid,
-					rcu_str_deref(device->name), path);
+	"duplicate device %s devid %llu generation %llu scanned by %s (%d)",
+						  path, devid, found_transid,
+						  current->comm,
+						  task_pid_nr(current));
 				return ERR_PTR(-EEXIST);
 			}
 			bdput(path_bdev);
 			btrfs_info_in_rcu(device->fs_info,
-				"device fsid %pU devid %llu moved old:%s new:%s",
-				disk_super->fsid, devid,
-				rcu_str_deref(device->name), path);
+	"devid %llu device path %s changed to %s scanned by %s (pid %d)",
+					  devid, rcu_str_deref(device->name),
+					  path, current->comm,
+					  task_pid_nr(current));
 		}
 
 		name = rcu_string_strdup(path, GFP_NOFS);
-- 
2.25.1

