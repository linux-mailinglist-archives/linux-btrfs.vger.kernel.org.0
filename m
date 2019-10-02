Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C7ADCC4B74
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Oct 2019 12:31:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727932AbfJBKbC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Oct 2019 06:31:02 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:42434 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726109AbfJBKbC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 2 Oct 2019 06:31:02 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x92ATJkl091172
        for <linux-btrfs@vger.kernel.org>; Wed, 2 Oct 2019 10:31:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id; s=corp-2019-08-05;
 bh=CzaQblrkEKiujNS7Yh2v6AUQAUHh71kMArbLwRx/ylA=;
 b=DD9yAbeunrtWT3x6rEJgI/ugMxB/JU3VmsaN/qpnPCY86dfQC+kpRkFTm19b7qv1pw/c
 z0MJ6F7uZJYAjCYhuXj9XR6dEUuPepS7WYh3l3LRIuHcs3gQhTIIVU/5KB2oimnIPjT6
 L8YYnUgxhnVB6b/YlWCxskEEm47UPeIy6NQQRAZY0pCHT6ci7TwhQLviPIx13GePrbdm
 dpTvmvCgvQvYr9K+t9AqtQN5BHMpQ+lrhTiLZNa/GSncalBD9CtbHPlLpno2wwad6Zf0
 CFCoCzAVEEu7KdrUaGVkwT+L0Ug0shLR9Gja6nzhuxhhBrWq6F2ebhLCSw9YiZDVYmnB sA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 2va05rv1j6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Wed, 02 Oct 2019 10:31:00 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x92AT1QL126643
        for <linux-btrfs@vger.kernel.org>; Wed, 2 Oct 2019 10:31:00 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 2vcg611vds-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Wed, 02 Oct 2019 10:31:00 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x92AUxIi015798
        for <linux-btrfs@vger.kernel.org>; Wed, 2 Oct 2019 10:30:59 GMT
Received: from tp.wifi.oracle.com (/192.188.170.104)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 02 Oct 2019 03:30:59 -0700
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: add device scanned-by process name in the scan message
Date:   Wed,  2 Oct 2019 18:30:48 +0800
Message-Id: <1570012248-16099-1-git-send-email-anand.jain@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9397 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910020098
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9397 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910020098
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Its very helpful if we had logged the device scanner process name
to debug the race condition between the systemd-udevd scan and the
user initiated device forget command.

This patch adds scanned-by process name to the scan message.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 fs/btrfs/volumes.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 788271649726..2c4c89bfafd1 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -1011,11 +1011,11 @@ static noinline struct btrfs_device *device_list_add(const char *path,
 		*new_device_added = true;
 
 		if (disk_super->label[0])
-			pr_info("BTRFS: device label %s devid %llu transid %llu %s\n",
-				disk_super->label, devid, found_transid, path);
+			pr_info("BTRFS: device label %s devid %llu transid %llu %s scanned-by %s\n",
+				disk_super->label, devid, found_transid, path, current->comm);
 		else
-			pr_info("BTRFS: device fsid %pU devid %llu transid %llu %s\n",
-				disk_super->fsid, devid, found_transid, path);
+			pr_info("BTRFS: device fsid %pU devid %llu transid %llu %s scanned-by %s\n",
+				disk_super->fsid, devid, found_transid, path, current->comm);
 
 	} else if (!device->name || strcmp(device->name->str, path)) {
 		/*
-- 
1.8.3.1

