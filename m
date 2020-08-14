Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D52F2441DA
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Aug 2020 02:04:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726658AbgHNAEM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 13 Aug 2020 20:04:12 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:32846 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726664AbgHNAEM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 13 Aug 2020 20:04:12 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07E01xNR184786
        for <linux-btrfs@vger.kernel.org>; Fri, 14 Aug 2020 00:04:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=im0nlfop/ZUrfUOVz/64pNmGvfDrTqt0E9pMh8gqqno=;
 b=IcLfq3lmCTByPN38voD2TD+YdNWDw2JHe3ST4+gofiH4RRxMSoV9/sASm5cN+Gwdnts9
 2mzRE8kVdmeDJjHNA/fdVy5hwq2hsEvtg8uYdvCvUMbEbGwfELKdcBbfsf4iSFB9ogFj
 ZyyCkF45iJGdkDwETV5m4HVSWzmB6ZAeKV4lRGZPRawkaYjVzMy4Hf/S/N6tWdePkYM6
 P+foFwuZpYZqvdNyjOgxzAM+FeBko7qtVHisJulPU4yla6YJ5Ap4vK+Sjd1EQRN3ddPv
 8fs07JT3/Bx+xRATU/9Sd/XpGyX1AK9VJ9PUXnYV8qWrvq+F2YmuOKqzCuMwoiZUPhIA Pw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 32t2ye1ydc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
        for <linux-btrfs@vger.kernel.org>; Fri, 14 Aug 2020 00:04:11 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07DNvbGa157159
        for <linux-btrfs@vger.kernel.org>; Fri, 14 Aug 2020 00:04:10 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 32u3h64wv8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Fri, 14 Aug 2020 00:04:10 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 07E049Bx003040
        for <linux-btrfs@vger.kernel.org>; Fri, 14 Aug 2020 00:04:09 GMT
Received: from localhost.localdomain (/39.109.231.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 14 Aug 2020 00:04:09 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 6/7] btrfs: cleanup unnecessary goto in open_seed_device
Date:   Fri, 14 Aug 2020 08:03:51 +0800
Message-Id: <20200814000352.124179-7-anand.jain@oracle.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200814000352.124179-1-anand.jain@oracle.com>
References: <20200814000352.124179-1-anand.jain@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9712 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999 mlxscore=0
 malwarescore=0 spamscore=0 suspectscore=3 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008130164
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9712 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 priorityscore=1501
 malwarescore=0 impostorscore=0 lowpriorityscore=0 mlxscore=0 bulkscore=0
 suspectscore=3 phishscore=0 adultscore=0 spamscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008130164
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

open_seed_devices() does goto to just return. So drop goto and just return
instead.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 fs/btrfs/volumes.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 3e03371eade6..4f4e18c83a8e 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -6738,20 +6738,18 @@ static struct btrfs_fs_devices *open_seed_devices(struct btrfs_fs_info *fs_info,
 	ret = open_fs_devices(fs_devices, FMODE_READ, fs_info->bdev_holder);
 	if (ret) {
 		free_fs_devices(fs_devices);
-		fs_devices = ERR_PTR(ret);
-		goto out;
+		return ERR_PTR(ret);
 	}
 
 	if (!fs_devices->seeding) {
 		close_fs_devices(fs_devices);
 		free_fs_devices(fs_devices);
-		fs_devices = ERR_PTR(-EINVAL);
-		goto out;
+		return ERR_PTR(-EINVAL);
 	}
 
 	fs_devices->seed = fs_info->fs_devices->seed;
 	fs_info->fs_devices->seed = fs_devices;
-out:
+
 	return fs_devices;
 }
 
-- 
2.18.2

