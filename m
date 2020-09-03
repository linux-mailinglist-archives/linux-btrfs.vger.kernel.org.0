Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9738A25B80F
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Sep 2020 02:58:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727984AbgICA6a (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Sep 2020 20:58:30 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:39236 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727951AbgICA61 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 2 Sep 2020 20:58:27 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0830tEUE048135
        for <linux-btrfs@vger.kernel.org>; Thu, 3 Sep 2020 00:58:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=VPB0h9o5bW+0d8HSJaqN6I2cDStj8lVXrh26oPtPXVE=;
 b=mpDkDTk+xXU2Orb2bFl/YxEzXOi+eI0upzUAxFODwplqrf0lbRuoxeDPRq9NthcZZ17b
 E7KbEgkfiRl+sFBvZvyK02fA/EhiKjWYmZT6h3sqCP2gNqAI/TvYVHqRKeEZqJcsUDpv
 xtl9PGOaIZJeqmf+EqwkbsqtmDnCcEHJZM0Pw3XI7Aj8nV/SzD4OhVYvItk3NQUhu+gA
 BSha4IJ4HfyK/7qGavgewAZIIWGZQct4D1jL5AOC6AsfCd+Mel2vsCQbhvIM4iUESe9B
 iWPbfmqYsVXpCW4giF3fEz0Y/dpfXiSJx208ZmYKHVAYRGUqElHVY45wLb8o1LpgAf0O 7g== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 337eer5xar-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
        for <linux-btrfs@vger.kernel.org>; Thu, 03 Sep 2020 00:58:26 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0830t56m179422
        for <linux-btrfs@vger.kernel.org>; Thu, 3 Sep 2020 00:58:26 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 3380sv16en-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Thu, 03 Sep 2020 00:58:26 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0830wP3O020220
        for <linux-btrfs@vger.kernel.org>; Thu, 3 Sep 2020 00:58:25 GMT
Received: from localhost.localdomain (/39.109.231.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 02 Sep 2020 17:58:24 -0700
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 11/15] btrfs: cleanup btrfs_remove_chunk
Date:   Thu,  3 Sep 2020 08:57:47 +0800
Message-Id: <c5ac11c96f44e38b5b108579730aa0301ed5926b.1599091832.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1599091832.git.anand.jain@oracle.com>
References: <cover.1599091832.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9732 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 phishscore=0 malwarescore=0 mlxscore=0 spamscore=0 bulkscore=0
 suspectscore=3 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009030004
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

In the function btrfs_remove_chunk() remove the local variable
%fs_devices, instead use the assigned pointer directly.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
Reviewed-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/volumes.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 7639a048c6cf..3e7a7d94a211 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -2922,7 +2922,6 @@ int btrfs_remove_chunk(struct btrfs_trans_handle *trans, u64 chunk_offset)
 	struct map_lookup *map;
 	u64 dev_extent_len = 0;
 	int i, ret = 0;
-	struct btrfs_fs_devices *fs_devices = fs_info->fs_devices;
 
 	em = btrfs_get_chunk_map(fs_info, chunk_offset, 1);
 	if (IS_ERR(em)) {
@@ -2944,14 +2943,14 @@ int btrfs_remove_chunk(struct btrfs_trans_handle *trans, u64 chunk_offset)
 	 * a device replace operation that replaces the device object associated
 	 * with map stripes (dev-replace.c:btrfs_dev_replace_finishing()).
 	 */
-	mutex_lock(&fs_devices->device_list_mutex);
+	mutex_lock(&fs_info->fs_devices->device_list_mutex);
 	for (i = 0; i < map->num_stripes; i++) {
 		struct btrfs_device *device = map->stripes[i].dev;
 		ret = btrfs_free_dev_extent(trans, device,
 					    map->stripes[i].physical,
 					    &dev_extent_len);
 		if (ret) {
-			mutex_unlock(&fs_devices->device_list_mutex);
+			mutex_unlock(&fs_info->fs_devices->device_list_mutex);
 			btrfs_abort_transaction(trans, ret);
 			goto out;
 		}
@@ -2967,12 +2966,12 @@ int btrfs_remove_chunk(struct btrfs_trans_handle *trans, u64 chunk_offset)
 
 		ret = btrfs_update_device(trans, device);
 		if (ret) {
-			mutex_unlock(&fs_devices->device_list_mutex);
+			mutex_unlock(&fs_info->fs_devices->device_list_mutex);
 			btrfs_abort_transaction(trans, ret);
 			goto out;
 		}
 	}
-	mutex_unlock(&fs_devices->device_list_mutex);
+	mutex_unlock(&fs_info->fs_devices->device_list_mutex);
 
 	ret = btrfs_free_chunk(trans, chunk_offset);
 	if (ret) {
-- 
2.25.1

