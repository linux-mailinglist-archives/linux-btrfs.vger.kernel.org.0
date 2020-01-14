Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CACB913A0DB
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Jan 2020 07:09:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726044AbgANGJd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 14 Jan 2020 01:09:33 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:50672 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725854AbgANGJc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 14 Jan 2020 01:09:32 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00E68XYw111867;
        Tue, 14 Jan 2020 06:09:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2019-08-05;
 bh=DE6IGAuQMUDNBsr4UzwDzizt520aywE1BmgfgzNWmnw=;
 b=SUKcGUdzBk0CAl8LRP0zied68SzQ4a/lbi8+A7NQhIEfS2lz10mNlvlifm8sZ/G+xb3+
 UCTX89IcSl2a2Cy6E1CKDyf4uewkOO4y+xhPu08/sUFLc783pZL53oXJ69fWUjdLRQ+i
 PQkoyBNA/xTAdT5z8HkaKTHPcCYnfwgW4mXybrHpwk47f+DyrqUpjq5Kh6o/HvBtEjoq
 MXDkNH9c6SlLRbdxGnXwDHB0vzQ8MpxkAEjvOm77GEV2zHAuHiIlbYkWZkqena2nQfNO
 37bsM7G+137JaUa4YK5rGfSgoW8fRX1IZ4IWi4Lxa5Usr11mxvfAyJbOQJ2BbhG73poV rQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 2xf73tknw7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Jan 2020 06:09:29 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00E68KJu159380;
        Tue, 14 Jan 2020 06:09:29 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 2xfrgk0prq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Jan 2020 06:09:29 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 00E69S7E021515;
        Tue, 14 Jan 2020 06:09:28 GMT
Received: from mb.wifi.oracle.com (/192.188.170.109)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 13 Jan 2020 22:09:27 -0800
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.cz
Subject: [PATCH 2/4] btrfs: stop using uninitiazlised fs_info in device_list_add()
Date:   Tue, 14 Jan 2020 14:09:18 +0800
Message-Id: <20200114060920.4527-2-anand.jain@oracle.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200114060920.4527-1-anand.jain@oracle.com>
References: <20200114060920.4527-1-anand.jain@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9499 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001140054
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9499 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001140054
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

fs_info is born during mount, and operations before the mount such as
scanning and assembling of the device volume should happen without any
reference to fs_info.

However the patch commit a9261d4125c9 (btrfs: harden agaist duplicate
fsid on scanned devices) used fs_info to call btrfs_warn_in_rcu() and
btrfs_info_in_rcu(), so if fs_info is NULL, the stacked functions which
leads to btrfs_printk() which shall print "unknown" instead of sb->s_id.
Or even might UAF as reported in [1].

So do the right thing, don't use fs_info instead use NO_FS_INFO in
btrfs_warn_in_rcu() and btrfs_info_in_rcu() for the btrfs_printk()
to take care of it properly.

Link:
 [1] https://www.spinics.net/lists/linux-btrfs/msg96524.html
Fixes: a9261d4125c9 (btrfs: harden agaist duplicate fsid on scanned devices)
Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 fs/btrfs/volumes.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 6fd90270e2c7..0301c3d693d8 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -889,14 +889,14 @@ static noinline struct btrfs_device *device_list_add(const char *path,
 			if (device->bdev != path_bdev) {
 				bdput(path_bdev);
 				mutex_unlock(&fs_devices->device_list_mutex);
-				btrfs_warn_in_rcu(device->fs_info,
+				btrfs_warn_in_rcu(NO_FS_INFO,
 			"duplicate device fsid:devid for %pU:%llu old:%s new:%s",
 					disk_super->fsid, devid,
 					rcu_str_deref(device->name), path);
 				return ERR_PTR(-EEXIST);
 			}
 			bdput(path_bdev);
-			btrfs_info_in_rcu(device->fs_info,
+			btrfs_info_in_rcu(NO_FS_INFO,
 				"device fsid %pU devid %llu moved old:%s new:%s",
 				disk_super->fsid, devid,
 				rcu_str_deref(device->name), path);
-- 
2.23.0

