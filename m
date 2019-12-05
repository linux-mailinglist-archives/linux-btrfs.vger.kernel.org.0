Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D2D09114019
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Dec 2019 12:29:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729290AbfLEL3R (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 5 Dec 2019 06:29:17 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:37566 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729167AbfLEL3Q (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 5 Dec 2019 06:29:16 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xB5BSdEH074845
        for <linux-btrfs@vger.kernel.org>; Thu, 5 Dec 2019 11:29:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2019-08-05;
 bh=V9vZwXX5fcKIr18s4hOMX8qBSjq90vItd86Wiazc0uY=;
 b=gQRrspNrVONq7Rz41bCF8neXBalpx1mjkCPdal9qWXASnmre3+SryuZuc8mQN3qmCnzw
 vDvomc2aAB0jGppN8Vss5u8Fi94F4GdWebtpz7M+ookXamxOxsbrmG+Oi47+ODdQcRli
 y4a/o+WolpIMjr/H6T9bSO8jsf5moriW998zvnv0yCGh1Pe/v9NY906icFLkvxd7Phw7
 QXJaAfk85agoGTxCuMwZbQgKfR1dIhpv16GDhglVhx0NwrzG7JDMGpHv7DvkhkPWuUHO
 walxbBnp/aNCuIWFqX3wMwiZi/m4mqaOCiDeT363g06RtNLKFOeg3iLIMe65HsJ2Zntq 3g== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 2wkgcqmf29-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Thu, 05 Dec 2019 11:29:15 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xB5BNVP2071796
        for <linux-btrfs@vger.kernel.org>; Thu, 5 Dec 2019 11:27:14 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 2wpp73ygk4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Thu, 05 Dec 2019 11:27:14 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xB5BRDtE007871
        for <linux-btrfs@vger.kernel.org>; Thu, 5 Dec 2019 11:27:13 GMT
Received: from localhost.localdomain (/39.109.145.141)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 05 Dec 2019 03:27:12 -0800
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 1/4] btrfs: sysfs, use btrfs_sysfs_remove_fsid in fail return in add_fsid
Date:   Thu,  5 Dec 2019 19:27:03 +0800
Message-Id: <20191205112706.8125-2-anand.jain@oracle.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191205112706.8125-1-anand.jain@oracle.com>
References: <20191205112706.8125-1-anand.jain@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9461 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=998
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1912050094
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9461 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1912050095
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We have one simple function btrfs_sysfs_remove_fsid() to cleanup
kobjects added by btrfs_sysfs_add_fsid() and calls kobject_put() and
kobject_delete() only if the kobject is initialized or not null.
So use this function while retreating in the function
btrfs_sysfs_add_fsid().

One difference though, earlier we did not call kobject_del() during
retreat in btrfs_sysfs_add_fsid() and I did experiment to figureout
if that's an error or warning, however I didn't notice any such issues
with or without kobject_del() not being called.

So this patch is just for cleanup.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 fs/btrfs/sysfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index 16379f491ca1..4cda410f0e6b 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -1076,7 +1076,7 @@ int btrfs_sysfs_add_fsid(struct btrfs_fs_devices *fs_devs)
 	if (!fs_devs->devices_kobj) {
 		btrfs_err(fs_devs->fs_info,
 			  "failed to init sysfs device interface");
-		kobject_put(&fs_devs->fsid_kobj);
+		btrfs_sysfs_remove_fsid(fs_devs);
 		return -ENOMEM;
 	}
 
-- 
2.23.0

