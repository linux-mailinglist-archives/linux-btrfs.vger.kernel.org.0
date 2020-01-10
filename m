Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 23F28136961
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Jan 2020 10:06:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726916AbgAJJGE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 10 Jan 2020 04:06:04 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:60540 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726694AbgAJJGD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 10 Jan 2020 04:06:03 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00A93ovn026694
        for <linux-btrfs@vger.kernel.org>; Fri, 10 Jan 2020 09:06:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2019-08-05;
 bh=aR6c2Gjk5RhX0WSuwmAyGfUzIvFn4psBgZTwTBV6T1Q=;
 b=b71SkfLCZh1oKRasfBaskkmx2NhOKYHF7A0w4lr6uRZD6y2Pv4rFEC8xbgQTrTvSRH87
 MeogqtwXhq0dPC7uNRgU81Uk0fsXFHciG/qyBe1SEeM+72LGHqoL+TtsKPCSk9f/gtYU
 1x8SPxkz+48MZnzuamXyFr/FikRspOm52DHO5UU4nm+JYlLSpT+xLgEKqFhtsC1V0Rfl
 OnJeWZmH6DiccuYQI3n+Kc11FRsXIoKLBR1AjvunOugomthSj0J948wxX1RJF+cAeAAR
 1+mnSdPGLBYLn80sDYX+0SJziKn/1ZXC1U81W20UX9SACTvJ+BAV2SqzhdiVMWbIZPYi uA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 2xaj4ugutk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Fri, 10 Jan 2020 09:06:02 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00A93V6f005659
        for <linux-btrfs@vger.kernel.org>; Fri, 10 Jan 2020 09:06:01 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 2xenn8x7ne-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Fri, 10 Jan 2020 09:06:01 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 00A961M8032083
        for <linux-btrfs@vger.kernel.org>; Fri, 10 Jan 2020 09:06:01 GMT
Received: from mb.wifi.oracle.com (/192.188.170.109)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 10 Jan 2020 01:06:00 -0800
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 2/2] btrfs: make the scan logs consistent
Date:   Fri, 10 Jan 2020 17:05:55 +0800
Message-Id: <20200110090555.7049-2-anand.jain@oracle.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200110090555.7049-1-anand.jain@oracle.com>
References: <20200110090555.7049-1-anand.jain@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9495 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001100077
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9495 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001100077
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Typically we follow, a logging format <parameter> <value> and no ":"
so just follow that here.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
David,
If required you may roll this into the patch 1/2 in this series. I didn't
dare, as there may be some concerns that it isn't relevent there.

 fs/btrfs/volumes.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 1a419841fc99..e6c2bf9d9f53 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -891,7 +891,7 @@ static noinline struct btrfs_device *device_list_add(const char *path,
 				mutex_unlock(&fs_devices->device_list_mutex);
 				rcu_read_lock();
 				printk_ratelimited(
-		"BTRFS: duplicate device fsid:devid for %pU:%llu old:%s new:%s",
+		"BTRFS: duplicate device fsid %pU devid %llu old %s new %s",
 					disk_super->fsid, devid,
 					rcu_str_deref(device->name), path);
 				rcu_read_unlock();
@@ -900,7 +900,7 @@ static noinline struct btrfs_device *device_list_add(const char *path,
 			bdput(path_bdev);
 			rcu_read_lock();
 			printk_ratelimited(
-			"BTRFS: device fsid %pU devid %llu moved old:%s new:%s",
+			"BTRFS: device fsid %pU devid %llu moved old %s new %s",
 				disk_super->fsid, devid,
 				rcu_str_deref(device->name), path);
 			rcu_read_unlock();
-- 
2.23.0

