Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 08D416A9F1
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Jul 2019 15:59:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387580AbfGPN7j (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 16 Jul 2019 09:59:39 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:51774 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726997AbfGPN7j (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 16 Jul 2019 09:59:39 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6GDxDn6168175;
        Tue, 16 Jul 2019 13:59:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2018-07-02;
 bh=dktfF5Kaw4qEQFp0vKB1lwsXrOToIbGgZ2tZ6Nui/54=;
 b=GZGlBhbVymBY6NG6iswyjcxS7KQwjPZzG6pTSvTyVvnCWIdFWRVc3wNjz/AlX1/rB0fX
 dMZLGYyHCJgpIff2eTRZrXBoeG5k2Z5EJqLAGWDUMwUKmXfUK2WtQ+d6PN4dOWKloMHk
 2FceIXlFpYh+bgvlDkCrwvL7JI7eMlk4/dKNf9mrmKqclMETifGV4ggbCQS+URQTkcqO
 0O+cJqIAGrSyhpNUCOMGCNlgm55KRdk+rrFEVJ1iGmpEuv29yBev1r3tRQh5vRa46PVu
 OIJ1xhPc4FZskBDy/iPOqynXSNLvTShKwlWp2x6naD267vGcOpoGjxNfAxTA1jR5+Gh/ gg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 2tq78pmnqk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Jul 2019 13:59:21 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6GDwIwb067148;
        Tue, 16 Jul 2019 13:59:21 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 2tq6mmwftd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Jul 2019 13:59:21 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x6GDxFYp011947;
        Tue, 16 Jul 2019 13:59:20 GMT
Received: from localhost.localdomain (/39.109.145.141)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 16 Jul 2019 06:59:15 -0700
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     g.btrfs@cobb.uk.net, calestyo@scientia.net
Subject: [PATCH] btrfs: ratelimit device path change info on mounted device
Date:   Tue, 16 Jul 2019 21:59:10 +0800
Message-Id: <20190716135910.848-1-anand.jain@oracle.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-120)
In-Reply-To: <5d8baf80-4fb3-221f-5ab4-e98a838f63e1@cobb.uk.net>
References: <5d8baf80-4fb3-221f-5ab4-e98a838f63e1@cobb.uk.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9320 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1907160171
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9320 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1907160172
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

If there are more than one path to a device, the last scanned path
will map to the mounted FS. In some Linux based os there appears to be a
system script (autofs?) which fails to notice that a device's alternative
path is already mounted, and so the change in device-path gets logged
every ~2mins whenever such a script is active.

kernel: [33017.407252] BTRFS info (device sdc3):
device fsid 4d1ba5af-8b89-4cb5-96c6-55d1f028a202 devid 4 moved
old:/dev/mapper/cryptdata4tb--vg-backup new:/dev/dm-13
kernel: [33017.522242] BTRFS info (device sdc3):
device fsid 4d1ba5af-8b89-4cb5-96c6-55d1f028a202 devid 4 moved
old:/dev/dm-13 new:/dev/mapper/cryptdata4tb--vg-backup
kernel: [33018.797161] BTRFS info (device sdc3):
device fsid 4d1ba5af-8b89-4cb5-96c6-55d1f028a202 devid 4 moved
old:/dev/mapper/cryptdata4tb--vg-backup new:/dev/dm-13
kernel: [33019.061631] BTRFS info (device sdc3):
device fsid 4d1ba5af-8b89-4cb5-96c6-55d1f028a202 devid 4 moved
old:/dev/dm-13 new:/dev/mapper/cryptdata4tb--vg-backup

Fix this by using the ratelimit printk.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
Reported-by: g.btrfs@cobb.uk.net
Reported-by: calestyo@scientia.net
---
 fs/btrfs/volumes.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index a13ddba1ebc3..b4c4add7b5e7 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -1086,7 +1086,7 @@ static noinline struct btrfs_device *device_list_add(const char *path,
 				return ERR_PTR(-EEXIST);
 			}
 			bdput(path_bdev);
-			btrfs_info_in_rcu(device->fs_info,
+			btrfs_info_rl_in_rcu(device->fs_info,
 				"device fsid %pU devid %llu moved old:%s new:%s",
 				disk_super->fsid, devid,
 				rcu_str_deref(device->name), path);
-- 
2.21.0 (Apple Git-120)

