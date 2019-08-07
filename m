Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8B3FB84706
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Aug 2019 10:21:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387548AbfHGIV2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 7 Aug 2019 04:21:28 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:42686 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387539AbfHGIV2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 7 Aug 2019 04:21:28 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x778J0Ie192140
        for <linux-btrfs@vger.kernel.org>; Wed, 7 Aug 2019 08:21:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2018-07-02;
 bh=Rk80Lg7jEbs5bPN5GvYjXZR1c9HaA/agfd94UHkXDQU=;
 b=tEpSvbxAdGJXIYJuaWg5R5MwchHk80vuFLBZV/JoLQeF5qFyy0WIcDElx3/FI1G9b/Tk
 Ykutka6KpIzLvF657EPg3KPJmTYpEbLkgLPz9AnK7nOULQAEVIICU6OIhTTzcYBU9pPO
 bovgcS7/doJYBca16tHt11Usod0OaCO0CtQfjXt+LGna+co4I/lb1r/iCxbNEh0rBoj/
 +XwcMnO9Xh2t2wb9GAEPiaQX2ERQA01slk27DF3Q/0g2fU/P3qWnTaio9+iXh1K3aaPH
 kqj8jADBsEIFRKCoJrN3oELjorN982/pfOU8JZt7FuGDjMBTmlfsNe2VZcjHkkyvPT96 rg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 2u52wrarer-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Wed, 07 Aug 2019 08:21:26 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x778I8nW005596
        for <linux-btrfs@vger.kernel.org>; Wed, 7 Aug 2019 08:21:25 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 2u75bw799r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Wed, 07 Aug 2019 08:21:25 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x778LPhm016612
        for <linux-btrfs@vger.kernel.org>; Wed, 7 Aug 2019 08:21:25 GMT
Received: from mb.wifi.oracle.com (/192.188.170.109)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 07 Aug 2019 01:21:25 -0700
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 2/2] btrfs: opencode to reset all devices stat
Date:   Wed,  7 Aug 2019 16:21:20 +0800
Message-Id: <20190807082120.1973-2-anand.jain@oracle.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-120)
In-Reply-To: <20190807082120.1973-1-anand.jain@oracle.com>
References: <20190807082120.1973-1-anand.jain@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9341 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1908070090
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9341 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908070090
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

__btrfs_reset_dev_stats() is a small helper function to reset devices stat
values, and is used only once, instead just open code it.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 fs/btrfs/volumes.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 3eed7968fe16..492342973c3c 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -191,7 +191,6 @@ out_overflow:;
 
 static int init_first_rw_device(struct btrfs_trans_handle *trans);
 static int btrfs_relocate_sys_chunks(struct btrfs_fs_info *fs_info);
-static void __btrfs_reset_dev_stats(struct btrfs_device *dev);
 static void btrfs_dev_stat_print_on_error(struct btrfs_device *dev);
 static void btrfs_dev_stat_print_on_load(struct btrfs_device *device);
 static int __btrfs_map_block(struct btrfs_fs_info *fs_info,
@@ -7311,14 +7310,6 @@ void btrfs_init_devices_late(struct btrfs_fs_info *fs_info)
 	}
 }
 
-static void __btrfs_reset_dev_stats(struct btrfs_device *dev)
-{
-	int i;
-
-	for (i = 0; i < BTRFS_DEV_STAT_VALUES_MAX; i++)
-		btrfs_dev_stat_set(dev, i, 0);
-}
-
 int btrfs_init_dev_stats(struct btrfs_fs_info *fs_info)
 {
 	struct btrfs_key key;
@@ -7348,7 +7339,8 @@ int btrfs_init_dev_stats(struct btrfs_fs_info *fs_info)
 		key.offset = device->devid;
 		ret = btrfs_search_slot(NULL, dev_root, &key, path, 0, 0);
 		if (ret) {
-			__btrfs_reset_dev_stats(device);
+			for (i = 0; i < BTRFS_DEV_STAT_VALUES_MAX; i++)
+				btrfs_dev_stat_set(device, i, 0);
 			device->dev_stats_valid = 1;
 			btrfs_release_path(path);
 			continue;
-- 
2.21.0 (Apple Git-120)

