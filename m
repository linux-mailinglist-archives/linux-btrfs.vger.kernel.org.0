Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74420256EB4
	for <lists+linux-btrfs@lfdr.de>; Sun, 30 Aug 2020 16:42:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727861AbgH3Omc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 30 Aug 2020 10:42:32 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:58700 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726988AbgH3Olp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 30 Aug 2020 10:41:45 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07UEYvG3032403;
        Sun, 30 Aug 2020 14:41:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=zeZEIvEkZt7LYoUdCiKpvFSlqYk2jqpm7r1kBJnpVi8=;
 b=xEwFOlXsMvi2Smaed+VfSa7EqxDUc3Mpu9rBFSZr3etxtJ7SPFrTxobEU0hifzXX3vjT
 2rDRD4pMPhfnmLMexzAObnSxM8eyUQewDbhc263k6EkrpR1IO0yHi/j00ucI5ikHzK2p
 Oz92Z+5ZGzYfUzbK30NA/hNThIKvckY1jCHliChWrI+sGzqec89hlZ2fIRFhUXQvtONy
 dqbDMmBbu39srzyLDdXdVTcVdKcn8tZkMMrspCL/XBBxPC4wIvOupjg0JgARlPurPVNa
 1Jc880BevQUdYNHAhAejbZaTscrS/97Kz3ZnSw5Cc/39gsYa0zvGjMBq23y9ab8RWaEq vQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 337eeqk0ra-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 30 Aug 2020 14:41:37 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07UEZ4DG104562;
        Sun, 30 Aug 2020 14:41:37 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 3380kjq00j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 30 Aug 2020 14:41:37 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 07UEfZU0030248;
        Sun, 30 Aug 2020 14:41:35 GMT
Received: from localhost.localdomain (/39.109.231.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 30 Aug 2020 07:41:35 -0700
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.com, josef@toxicpanda.com
Subject: [PATCH 08/11] btrfs: cleanup btrfs_assign_next_active_device()
Date:   Sun, 30 Aug 2020 22:41:03 +0800
Message-Id: <61f2ef2654e87658d69024d34c2415a24448f67e.1598792561.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1598792561.git.anand.jain@oracle.com>
References: <cover.1598792561.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9729 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 adultscore=0
 mlxscore=0 suspectscore=1 malwarescore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008300118
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9729 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 adultscore=0 spamscore=0 mlxscore=0
 phishscore=0 impostorscore=0 mlxlogscore=999 bulkscore=0 suspectscore=1
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008300118
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

