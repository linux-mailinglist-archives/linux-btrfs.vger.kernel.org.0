Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D44102441D9
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Aug 2020 02:04:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726669AbgHNAEL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 13 Aug 2020 20:04:11 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:32824 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726658AbgHNAEL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 13 Aug 2020 20:04:11 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07E02Sbl184957
        for <linux-btrfs@vger.kernel.org>; Fri, 14 Aug 2020 00:04:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=2A1LOBwzgOIJ7wewBaIwuRGE7XsvupFcZcTE3HdvsyA=;
 b=fUSbTu08DGtKJ77ueHXFmQ9YCv6WmqqCwZK++1YbZc2baxEhaxcwqTJK41GAwF0Ma5P8
 eEwVnuogDMaQkKnI3yFx1TpRHfzN1IxjiQH1S3714L36WuFnuAii6jrHm8pkN7SIzHnv
 myB0RwxwXrEDYbLK+lATNHTO9ngpA18tqa//UrOPi4stE72TPac9CA4Km96Wy97hmpI/
 a2Mj891ZoFuybUiZF2bA/EcqBPT/wDBtVxXxQKW6QtsuRL9uLLU9UmQUal8wL6w8Ifr3
 pyK8dRzm9ZxLptEKq7cHiRLExLNCyPGEDJO94fFI7q1hI4F9JBaw+HNnkEV0vTAANAZG 1Q== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 32t2ye1yd6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
        for <linux-btrfs@vger.kernel.org>; Fri, 14 Aug 2020 00:04:09 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07DNvbIB157221
        for <linux-btrfs@vger.kernel.org>; Fri, 14 Aug 2020 00:04:09 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 32u3h64wuh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Fri, 14 Aug 2020 00:04:09 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 07E048bc003033
        for <linux-btrfs@vger.kernel.org>; Fri, 14 Aug 2020 00:04:08 GMT
Received: from localhost.localdomain (/39.109.231.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 14 Aug 2020 00:04:07 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 5/7] btrfs: cleanup btrfs_assign_next_active_device()
Date:   Fri, 14 Aug 2020 08:03:50 +0800
Message-Id: <20200814000352.124179-6-anand.jain@oracle.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200814000352.124179-1-anand.jain@oracle.com>
References: <20200814000352.124179-1-anand.jain@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9712 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999 mlxscore=0
 malwarescore=0 spamscore=0 suspectscore=1 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008130164
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9712 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 priorityscore=1501
 malwarescore=0 impostorscore=0 lowpriorityscore=0 mlxscore=0 bulkscore=0
 suspectscore=1 phishscore=0 adultscore=0 spamscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008130164
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Cleanup btrfs_assign_next_active_device(), drop %this_dev.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 fs/btrfs/volumes.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index dd867375478b..3e03371eade6 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -1956,16 +1956,13 @@ static struct btrfs_device * btrfs_find_next_active_device(
  * this_dev) which is active.
  */
 void __cold btrfs_assign_next_active_device(struct btrfs_device *device,
-				     struct btrfs_device *this_dev)
+					    struct btrfs_device *next_device)
 {
 	struct btrfs_fs_info *fs_info = device->fs_info;
-	struct btrfs_device *next_device;
 
-	if (this_dev)
-		next_device = this_dev;
-	else
+	if (!next_device)
 		next_device = btrfs_find_next_active_device(fs_info->fs_devices,
-								device);
+							    device);
 	ASSERT(next_device);
 
 	if (fs_info->sb->s_bdev &&
-- 
2.18.2

