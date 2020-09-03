Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72FEC25B81D
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Sep 2020 03:00:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726979AbgICBAa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Sep 2020 21:00:30 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:40054 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726654AbgICBA3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 2 Sep 2020 21:00:29 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08310SOn141602
        for <linux-btrfs@vger.kernel.org>; Thu, 3 Sep 2020 01:00:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=lOVd1xg+WJTqWPeIJPYE4RY3UP9YAL44d8XEVvWhsuY=;
 b=bRlbMcWVrLuXKqzeTTu5IfUaZvFwSLarscRpOkJkDslEVEjYiXEdNva2W/aFVX2k4NVj
 97cyen/YzxQ/2wG3Y+Sj49fUenvoSQVpkR49wOXoLRJgKk7LN2oMx4/9qfCr7y7PZxhK
 uX5O+bYG73pcYDkBsh5qUnhUWXYuDRsw11Wz9pnaHsM/jZ4vdAHBEWi0qWE6bZbQNVlh
 0PwFuKW7PpteHT0IoNXIZe5LtKQS3tO//+IbksuxbzKlRn8MwB44lZl0Z50yW8wJtqnN
 qmXwYmK3YGNsrGjLDAJj2yMVFqaI7VGeBYXM3NnLJDOYu6p+95460DakdZ5DqoaKxj6G FA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 337eymdu72-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
        for <linux-btrfs@vger.kernel.org>; Thu, 03 Sep 2020 01:00:28 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0830t6mb179516
        for <linux-btrfs@vger.kernel.org>; Thu, 3 Sep 2020 00:58:27 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 3380sv16fm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Thu, 03 Sep 2020 00:58:27 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0830wQap027559
        for <linux-btrfs@vger.kernel.org>; Thu, 3 Sep 2020 00:58:26 GMT
Received: from localhost.localdomain (/39.109.231.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 02 Sep 2020 17:58:26 -0700
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 12/15] btrfs: cleanup btrfs_assign_next_active_device()
Date:   Thu,  3 Sep 2020 08:57:48 +0800
Message-Id: <a85e9653da23ab5ff16f9221a706bbbacbdd276a.1599091832.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1599091832.git.anand.jain@oracle.com>
References: <cover.1599091832.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9732 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 phishscore=0 malwarescore=0 mlxscore=0 spamscore=0 bulkscore=0
 suspectscore=1 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009030004
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9732 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 adultscore=0
 priorityscore=1501 phishscore=0 mlxlogscore=999 mlxscore=0
 lowpriorityscore=0 clxscore=1015 spamscore=0 bulkscore=0 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009030005
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Cleanup btrfs_assign_next_active_device(), drop %this_dev.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
Reviewed-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/volumes.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 3e7a7d94a211..c8b0d9eb4468 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -1961,16 +1961,13 @@ static struct btrfs_device * btrfs_find_next_active_device(
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
2.25.1

