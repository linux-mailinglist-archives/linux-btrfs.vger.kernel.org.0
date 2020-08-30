Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 637A3256EB9
	for <lists+linux-btrfs@lfdr.de>; Sun, 30 Aug 2020 16:42:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727895AbgH3Oml (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 30 Aug 2020 10:42:41 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:58680 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726942AbgH3Olp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 30 Aug 2020 10:41:45 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07UEYuqO032392;
        Sun, 30 Aug 2020 14:41:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=lRVKiE6xJa82oF2d33fikSPvx8FLjE4sDM486eBHa0s=;
 b=s95KRs5w53jL9gdcEeXVUAxyqjX6GpCXrcRiJco4rDvv3JoCejmK5k/OFFImJ2/t5yUa
 RMJYBE1om2p9Yn7JnZn6gUt/8qsheBZBrDNbP/UmgzLGukd/9uIHpseB6HicL0NT6RH1
 Nii/O6cavgUyFchW1foaZn8makwpwgi3l7UlzZQb+ur5i7Nurdr/atrfzJL7+UGUZj18
 3aYVa3Y9N+dwpZFSAQsOqX/ouFZdxHzmxhWe3IvlHyv+M0qd2ZuPls5YxUVUE29TYdQn
 wrgFs0M4grPPVcf65uYALaH4XlTSVRY6gvG2Vwi7783Jmq9YAfb76+uZZbe/I68NLiit JA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 337eeqk0r7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 30 Aug 2020 14:41:34 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07UEZ4Ex104607;
        Sun, 30 Aug 2020 14:41:34 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 3380kjpyyt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 30 Aug 2020 14:41:34 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 07UEfX7C024961;
        Sun, 30 Aug 2020 14:41:33 GMT
Received: from localhost.localdomain (/39.109.231.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 30 Aug 2020 07:41:33 -0700
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.com, josef@toxicpanda.com
Subject: [PATCH 07/11] btrfs: cleanup btrfs_remove_chunk
Date:   Sun, 30 Aug 2020 22:41:02 +0800
Message-Id: <e8480a482baedb6dd044fae1aba78be8ac3992f4.1598792561.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1598792561.git.anand.jain@oracle.com>
References: <cover.1598792561.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9729 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 adultscore=0
 mlxscore=0 suspectscore=3 malwarescore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008300118
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9729 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 adultscore=0 spamscore=0 mlxscore=0
 phishscore=0 impostorscore=0 mlxlogscore=999 bulkscore=0 suspectscore=3
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008300118
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

In the function btrfs_remove_chunk() remove the local variable
%fs_devices, instead use the assigned pointer directly.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
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

