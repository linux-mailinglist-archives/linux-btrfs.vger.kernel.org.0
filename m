Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D91C25B813
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Sep 2020 02:58:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728022AbgICA6d (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Sep 2020 20:58:33 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:39272 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727986AbgICA6b (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 2 Sep 2020 20:58:31 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0830su21048033
        for <linux-btrfs@vger.kernel.org>; Thu, 3 Sep 2020 00:58:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=ngkeAJIBSiQmuqukPm1sf9idiSNbBa5zZ7EEexb9BuY=;
 b=i0tXzmkYu/tFDhrWKZ3bJUDJzv2eZqta2c4ye6d5Vkmr4HSk2Mti591SiA+0zJQ/gQ8G
 M/dQXwnHVsV7NVagyg4fbY5ZHgjjeG3ifpoxVSuzg62TrxZRSunxlV5pZSO034oryoNW
 KUuYA+vacizQpTS5Z86giDmBxk39/H0b55Ne7EMZyV8+IKVLQ0gqq7azB2kyWfGTq/+p
 BYA7XEYup/17YQprPltFk+2g4eHjuQ0J+M/Kw1dP5/7hdCmNJiANstbmLFIL1gVo1sN2
 9DFdoc0AgqKN/nTdGDd6sWgOG3uUpHxOT+WSthdLQ3glb02nGGy8Bwn4t9SY+BmzOYxN ww== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 337eer5xav-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
        for <linux-btrfs@vger.kernel.org>; Thu, 03 Sep 2020 00:58:30 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0830seKF036788
        for <linux-btrfs@vger.kernel.org>; Thu, 3 Sep 2020 00:58:29 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 3380x8anyw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Thu, 03 Sep 2020 00:58:29 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0830wSHh027565
        for <linux-btrfs@vger.kernel.org>; Thu, 3 Sep 2020 00:58:28 GMT
Received: from localhost.localdomain (/39.109.231.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 02 Sep 2020 17:58:27 -0700
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 13/15] btrfs: cleanup unnecessary goto in open_seed_device
Date:   Thu,  3 Sep 2020 08:57:49 +0800
Message-Id: <5a03a0bc3d94719c0587f6f62276bbc95838cc05.1599091832.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1599091832.git.anand.jain@oracle.com>
References: <cover.1599091832.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9732 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 phishscore=0
 mlxlogscore=999 adultscore=0 suspectscore=3 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009030004
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9732 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 adultscore=0 spamscore=0 mlxscore=0
 phishscore=0 impostorscore=0 mlxlogscore=999 bulkscore=0 suspectscore=3
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009030004
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

open_seed_devices() does goto to just return. So drop goto and just return
instead.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
Reviewed-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/volumes.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index c8b0d9eb4468..dc81646b13c0 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -6741,19 +6741,17 @@ static struct btrfs_fs_devices *open_seed_devices(struct btrfs_fs_info *fs_info,
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
 
 	list_add_tail(&fs_devices->seed_list, &fs_info->fs_devices->seed_list);
-out:
+
 	return fs_devices;
 }
 
-- 
2.25.1

