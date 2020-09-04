Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51FBD25E0ED
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Sep 2020 19:35:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728004AbgIDRf1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 4 Sep 2020 13:35:27 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:60498 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727964AbgIDRfZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 4 Sep 2020 13:35:25 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 084HZ2ti140971;
        Fri, 4 Sep 2020 17:35:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=BCHES9HEMbriH+dpksZFq33pUsvTuMI5SNG7YMXjusI=;
 b=qGKdqhW0BYrh0uNbl0drP5pKAuiap02ACEh6jaOvrp63BSwzZo+RT06Iq2Y4o3h0AB/b
 eqKqwU1H/bmCfmdWaeQbL0By1b6lbTxyAed+4U5yIgGWfBZIsnH4v0hb5ZPcDRS1pOG8
 sq0KHqgjypb5gCDsUplRD/lTdoMrBQSWgRxE0juOCQuz/HSUalDEO/9zkVahFH0YND/B
 lQ3uQ5FcW08ofAdZyH5ygto5BIZJCVkmFqChcrMcUqkj1haJNMcvXwypE95MXulvWhxQ
 +hLkOTM2zT9b77+unumjgErGM4wtSJv6Fbpwq7eIO4Ijd3giQAPgpbUgm/CXLT8tmTcs kw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 337eerfr9p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 04 Sep 2020 17:35:19 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 084HVLGm083208;
        Fri, 4 Sep 2020 17:35:19 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 3380ktta1x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 04 Sep 2020 17:35:18 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 084HZI5P005867;
        Fri, 4 Sep 2020 17:35:18 GMT
Received: from localhost.localdomain (/39.109.231.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 04 Sep 2020 10:35:17 -0700
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.com, josef@toxicpanda.com, nborisov@suse.com
Subject: [PATCH 13/16] btrfs: cleanup btrfs_remove_chunk
Date:   Sat,  5 Sep 2020 01:34:33 +0800
Message-Id: <731ff89d22332c3e344f9ea4ca28012f01d50656.1599234146.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1599234146.git.anand.jain@oracle.com>
References: <cover.1599234146.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9734 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 adultscore=0
 mlxscore=0 suspectscore=3 malwarescore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009040152
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9734 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 adultscore=0 spamscore=0 mlxscore=0
 phishscore=0 impostorscore=0 mlxlogscore=999 bulkscore=0 suspectscore=3
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009040152
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
index f70b79eaa76d..f16c4a854a6c 100644
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

