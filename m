Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 826B425BB9E
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Sep 2020 09:27:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726855AbgICH1q (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 3 Sep 2020 03:27:46 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:39204 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726022AbgICH1p (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 3 Sep 2020 03:27:45 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0837OJlD127813
        for <linux-btrfs@vger.kernel.org>; Thu, 3 Sep 2020 07:27:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : mime-version : content-transfer-encoding;
 s=corp-2020-01-29; bh=qoiWEB+gcxA95wTmIxc9dMuQlnolfA9aKDHmktaZmlM=;
 b=NzuyAgNi/R81b+qKNFwtLu9Dc8WBkSPTnPFgMNxXYPK3xWQisVXttnXRct6YV2wijt1e
 7IdNhw0YIKuYJvoE+jMQY7mS3dLcF89doQnw0gn7QmaMSVDucheqbOOYm7SM5H2WiMJC
 PMNGRl0dk5sZWQd82lJydsaPNPPLf+9A82JdHWo8LT0EPX2Iyrj+5YHn9//93wwLqnva
 uQ56C9aI3i+bmilkdJ1UWyOlA9pGakO9Nptn0HHjG3hrmihsXx5fEtvFxA0pWugL8nOX
 iyKloMOhzRpK3XS5lMUq3HWN+ZdgdsFBNMY6EfZR0pTUAGbA0rZYa8YPlXcH3VrGtOiP /Q== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 337eymeyhf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
        for <linux-btrfs@vger.kernel.org>; Thu, 03 Sep 2020 07:27:44 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0837KgVO012679
        for <linux-btrfs@vger.kernel.org>; Thu, 3 Sep 2020 07:27:43 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 3380x94r6r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Thu, 03 Sep 2020 07:27:43 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0837RhMW028321
        for <linux-btrfs@vger.kernel.org>; Thu, 3 Sep 2020 07:27:43 GMT
Received: from localhost.localdomain (/39.109.231.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 03 Sep 2020 00:27:43 -0700
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: improve messages when devices rescanned
Date:   Thu,  3 Sep 2020 15:27:35 +0800
Message-Id: <77fc0b0c7c88b14c734b646d1969ccf45a063146.1599118052.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9732 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 phishscore=0
 mlxlogscore=999 adultscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009030065
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9732 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 priorityscore=1501 phishscore=0 mlxlogscore=999 mlxscore=0
 lowpriorityscore=0 clxscore=1015 spamscore=0 bulkscore=0 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009030065
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
 fs/btrfs/volumes.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index dc81646b13c0..c386ad722ae1 100644
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
+				"device path %s changed to %s by %s (pid %d)",
+					  rcu_str_deref(device->name),
+					  path, current->comm,
+					  task_pid_nr(current));
 		}
 
 		name = rcu_string_strdup(path, GFP_NOFS);
-- 
2.25.1

