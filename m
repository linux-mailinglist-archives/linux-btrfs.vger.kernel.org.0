Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A4420136960
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Jan 2020 10:06:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726877AbgAJJGD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 10 Jan 2020 04:06:03 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:41010 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726641AbgAJJGD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 10 Jan 2020 04:06:03 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00A93Zf0007119
        for <linux-btrfs@vger.kernel.org>; Fri, 10 Jan 2020 09:06:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : mime-version : content-transfer-encoding;
 s=corp-2019-08-05; bh=rvDqZsh9MRc21rGC4ExN8mhUY7YfUrqQmh553kYxJWo=;
 b=JDndvZnb+Kap1AcnjSs8V9whJNydj4y1H54P3aHE/6URh61xPFGF/dh7Ke938v/Q6++V
 reycMKV87VHX87EfGd0T+YkP+lIBZOqlSHF18D5yLgWD3KDt8Ljo3S8Sg0iZ2JWq8Opj
 hIBEHqPPBRCE14kmWjdU012UmygO68Vfu8Y9G7FrOrkBJFwk1XHhrcN61RB5KUsuHReB
 T/uE7E4bA5r9vo5/kK5h9TtqjWekcCBXxFubPwa06kuF6+0oWYc1kV8C3IKgvTagrlJt
 K2SvyVdA3/UAuq49G9ZqWCs2FYQuoW6zAa+d1ogvgint6j+9TVpn2ft3p8eIxRWH7nsQ YQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 2xakbr8kvn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Fri, 10 Jan 2020 09:06:01 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00A93eXx125024
        for <linux-btrfs@vger.kernel.org>; Fri, 10 Jan 2020 09:06:00 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 2xekkuhpag-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Fri, 10 Jan 2020 09:06:00 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 00A95xOi021701
        for <linux-btrfs@vger.kernel.org>; Fri, 10 Jan 2020 09:05:59 GMT
Received: from mb.wifi.oracle.com (/192.188.170.109)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 10 Jan 2020 01:05:59 -0800
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 1/2] btrfs: open code log helpers in device_list_add()
Date:   Fri, 10 Jan 2020 17:05:54 +0800
Message-Id: <20200110090555.7049-1-anand.jain@oracle.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9495 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001100077
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9495 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001100077
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

fs_info is born during mount, and operations before the mount such as
scanning and assembling of the device volume should happen without any
reference to fs_info.

However the patch commit a9261d4125c9 (btrfs: harden agaist duplicate
fsid on scanned devices) used fs_info to call btrfs_warn_in_rcu() and
btrfs_info_in_rcu(), so if fs_info is NULL, the stacked functions leads
to btrfs_printk() which shall print "unknown" instead of sb->s_id. Or
even might UAF as reported in [1].

So do the right thing, don't use btrfs_warn_in_rcu() and
btrfs_info_in_rcu() in device_list_add() instead just open code it.

Link:
[1] https://www.spinics.net/lists/linux-btrfs/msg96524.html
Fixes: a9261d4125c9 (btrfs: harden agaist duplicate fsid on scanned devices)
Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 fs/btrfs/volumes.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 6fd90270e2c7..1a419841fc99 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -889,17 +889,21 @@ static noinline struct btrfs_device *device_list_add(const char *path,
 			if (device->bdev != path_bdev) {
 				bdput(path_bdev);
 				mutex_unlock(&fs_devices->device_list_mutex);
-				btrfs_warn_in_rcu(device->fs_info,
-			"duplicate device fsid:devid for %pU:%llu old:%s new:%s",
+				rcu_read_lock();
+				printk_ratelimited(
+		"BTRFS: duplicate device fsid:devid for %pU:%llu old:%s new:%s",
 					disk_super->fsid, devid,
 					rcu_str_deref(device->name), path);
+				rcu_read_unlock();
 				return ERR_PTR(-EEXIST);
 			}
 			bdput(path_bdev);
-			btrfs_info_in_rcu(device->fs_info,
-				"device fsid %pU devid %llu moved old:%s new:%s",
+			rcu_read_lock();
+			printk_ratelimited(
+			"BTRFS: device fsid %pU devid %llu moved old:%s new:%s",
 				disk_super->fsid, devid,
 				rcu_str_deref(device->name), path);
+			rcu_read_unlock();
 		}
 
 		name = rcu_string_strdup(path, GFP_NOFS);
-- 
2.23.0

