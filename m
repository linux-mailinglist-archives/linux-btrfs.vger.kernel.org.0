Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 59C98CB578
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Oct 2019 09:50:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387486AbfJDHuV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 4 Oct 2019 03:50:21 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:48520 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726811AbfJDHuV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 4 Oct 2019 03:50:21 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x947mvTn064680
        for <linux-btrfs@vger.kernel.org>; Fri, 4 Oct 2019 07:50:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references; s=corp-2019-08-05;
 bh=TIXS8NaLhISNKlyOqdXIVpj6mNg6d7lTQzs+T/sMNhs=;
 b=FU3S4rR0a/3EGdtRj5nnYV6azOqyqxkkYJlGrJ3mWPNSSuvLs2yqteBMF8QXutubcEIJ
 c/97hywWy3bCCkQAM20Mgqo7kEZXfNllBBmpohymu+YdNLaosIIia385hz6hKTq34Fif
 dkEBVCFwuffo8xF5v/mdwvDny6lnourPztNUX4Bgm05mscRCFT0BdNPdSVv/oOoLkDRG
 eKyQk7XeRr375yeVKaUZeGxVtb1BGu2qhStWHZ2SMpsXJv/mPRFJS7n7AmB/OeFabQEn
 dvTtqbKSchizVOqPLnQr5hf7iW3kAFRs86Opx8GpbRu1HKouRt0ewBgRTbOWmaZGeZGp IQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 2v9yfqshn5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Fri, 04 Oct 2019 07:50:19 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x947mLfE006173
        for <linux-btrfs@vger.kernel.org>; Fri, 4 Oct 2019 07:50:19 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 2vdxu89m6h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Fri, 04 Oct 2019 07:50:19 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x947oIBB029644
        for <linux-btrfs@vger.kernel.org>; Fri, 4 Oct 2019 07:50:18 GMT
Received: from tp.wifi.oracle.com (/192.188.170.104)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 04 Oct 2019 00:50:17 -0700
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 1/4] btrfs: drop useless goto in open_fs_devices
Date:   Fri,  4 Oct 2019 15:50:00 +0800
Message-Id: <1570175403-4073-2-git-send-email-anand.jain@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1570175403-4073-1-git-send-email-anand.jain@oracle.com>
References: <1570175403-4073-1-git-send-email-anand.jain@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9399 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910040072
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9399 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910040072
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

There is no need of goto out in open_fs_devices() as there is nothing
special done at %out:. So refactor it.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 fs/btrfs/volumes.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index e176346afed1..06ec3577c6b4 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -1330,7 +1330,6 @@ static int open_fs_devices(struct btrfs_fs_devices *fs_devices,
 {
 	struct btrfs_device *device;
 	struct btrfs_device *latest_dev = NULL;
-	int ret = 0;
 
 	flags |= FMODE_EXCL;
 
@@ -1343,15 +1342,14 @@ static int open_fs_devices(struct btrfs_fs_devices *fs_devices,
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

