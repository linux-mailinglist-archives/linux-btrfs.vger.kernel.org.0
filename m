Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 671A22441D8
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Aug 2020 02:04:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726663AbgHNAEK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 13 Aug 2020 20:04:10 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:33638 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726205AbgHNAEI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 13 Aug 2020 20:04:08 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07E03uxR173994
        for <linux-btrfs@vger.kernel.org>; Fri, 14 Aug 2020 00:04:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=cK2kifqj2ll3kcL7s9nVPjCc6qZ6p3lYrKsI7fq5yoM=;
 b=x5/m+6tQd4kzJYX5ENFRgIRkMYXlOo2J01J2VZaNmGfqcuWDsYonJ2WVdfxexNc4S/or
 dhfJbjsyd0iWzGDSWcEjhZzT8BwOLE8UCm5wRpleKft8sfsespPMr2uaRj3oAC+CLwCh
 wqEgogvCs8DvJSOZOEtvUuf+xXEPrmVr2vtvY7EkNI92rjBSNrheuWd4XchG92G30YGR
 feKduHiNVHIWTZVLLfym4mFwOnw2V6ar50+khzvSzl2r+/Dkg6ZzpgBRvMxX0Rh1sAHW
 OOfxxglOb+086Ua3nsVda5wr6hrx+cuBFyfT8CeLUyOfqAuPe3Akmn7PPhy1VLbHHXDY sw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 32w73capmt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
        for <linux-btrfs@vger.kernel.org>; Fri, 14 Aug 2020 00:04:08 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07DNvUgE092070
        for <linux-btrfs@vger.kernel.org>; Fri, 14 Aug 2020 00:04:07 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 32t5yb2gp2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Fri, 14 Aug 2020 00:04:07 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 07E046o9003104
        for <linux-btrfs@vger.kernel.org>; Fri, 14 Aug 2020 00:04:06 GMT
Received: from localhost.localdomain (/39.109.231.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 14 Aug 2020 00:04:06 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 4/7] btrfs: cleanup unused return in btrfs_close_devices
Date:   Fri, 14 Aug 2020 08:03:49 +0800
Message-Id: <20200814000352.124179-5-anand.jain@oracle.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200814000352.124179-1-anand.jain@oracle.com>
References: <20200814000352.124179-1-anand.jain@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9712 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0
 suspectscore=3 mlxscore=0 adultscore=0 bulkscore=0 phishscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008130164
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9712 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 bulkscore=0 phishscore=0 suspectscore=3 mlxscore=0 priorityscore=1501
 spamscore=0 clxscore=1015 lowpriorityscore=0 adultscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008130164
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

In the function btrfs_close_devices() and its helper function
close_fs_devices(), the return value aren't used as there isn't error
return from these functions. So clean up the return argument.

Also in the function btrfs_remove_chunk() remove the local variable
%fs_devices, instead use the assigned pointer directly.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 fs/btrfs/volumes.c | 21 ++++++++-------------
 fs/btrfs/volumes.h |  2 +-
 2 files changed, 9 insertions(+), 14 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 66691416ca8f..dd867375478b 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -1148,12 +1148,12 @@ static void btrfs_close_one_device(struct btrfs_device *device)
 	ASSERT(atomic_read(&device->reada_in_flight) == 0);
 }
 
-static int close_fs_devices(struct btrfs_fs_devices *fs_devices)
+static void close_fs_devices(struct btrfs_fs_devices *fs_devices)
 {
 	struct btrfs_device *device, *tmp;
 
 	if (--fs_devices->opened > 0)
-		return 0;
+		return;
 
 	mutex_lock(&fs_devices->device_list_mutex);
 	list_for_each_entry_safe(device, tmp, &fs_devices->devices, dev_list) {
@@ -1165,17 +1165,14 @@ static int close_fs_devices(struct btrfs_fs_devices *fs_devices)
 	WARN_ON(fs_devices->rw_devices);
 	fs_devices->opened = 0;
 	fs_devices->seeding = false;
-
-	return 0;
 }
 
-int btrfs_close_devices(struct btrfs_fs_devices *fs_devices)
+void btrfs_close_devices(struct btrfs_fs_devices *fs_devices)
 {
 	struct btrfs_fs_devices *seed_devices = NULL;
-	int ret;
 
 	mutex_lock(&uuid_mutex);
-	ret = close_fs_devices(fs_devices);
+	close_fs_devices(fs_devices);
 	if (!fs_devices->opened) {
 		seed_devices = fs_devices->seed;
 		fs_devices->seed = NULL;
@@ -1188,7 +1185,6 @@ int btrfs_close_devices(struct btrfs_fs_devices *fs_devices)
 		close_fs_devices(fs_devices);
 		free_fs_devices(fs_devices);
 	}
-	return ret;
 }
 
 static int open_fs_devices(struct btrfs_fs_devices *fs_devices,
@@ -2933,7 +2929,6 @@ int btrfs_remove_chunk(struct btrfs_trans_handle *trans, u64 chunk_offset)
 	struct map_lookup *map;
 	u64 dev_extent_len = 0;
 	int i, ret = 0;
-	struct btrfs_fs_devices *fs_devices = fs_info->fs_devices;
 
 	em = btrfs_get_chunk_map(fs_info, chunk_offset, 1);
 	if (IS_ERR(em)) {
@@ -2955,14 +2950,14 @@ int btrfs_remove_chunk(struct btrfs_trans_handle *trans, u64 chunk_offset)
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
@@ -2978,12 +2973,12 @@ int btrfs_remove_chunk(struct btrfs_trans_handle *trans, u64 chunk_offset)
 
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
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index 5eea93916fbf..76e5470e19a8 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -435,7 +435,7 @@ int btrfs_open_devices(struct btrfs_fs_devices *fs_devices,
 struct btrfs_device *btrfs_scan_one_device(const char *path,
 					   fmode_t flags, void *holder);
 int btrfs_forget_devices(const char *path);
-int btrfs_close_devices(struct btrfs_fs_devices *fs_devices);
+void btrfs_close_devices(struct btrfs_fs_devices *fs_devices);
 void btrfs_free_extra_devids(struct btrfs_fs_devices *fs_devices, int step);
 void btrfs_assign_next_active_device(struct btrfs_device *device,
 				     struct btrfs_device *this_dev);
-- 
2.18.2

