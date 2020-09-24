Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8961D276E50
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Sep 2020 12:11:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727388AbgIXKLv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 24 Sep 2020 06:11:51 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:44728 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727089AbgIXKLv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 24 Sep 2020 06:11:51 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08OA92kN114818;
        Thu, 24 Sep 2020 10:11:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=D2rugi7hcp49ohOqIujo53/yb5inOgXkAxLD5AnJArA=;
 b=q+djrPgUNc8APrgbGlZEFCGM9fzxQnJ6ZqrAdI/ZdQB7GfF/HedENwUvSIoDLBqHKvoP
 PtMu9ypg1UdoIJwAyUQeV25g9pY9jOwNtBGr58TAb/ZBcNnGF4dC5KLKL5s6lpS4BkhO
 7woydlDZd67GyG9nB9ZkQzzYdEGSyqDwF6UUYGDfTAruvL2WxRaFcCd9bJvugkIZM4Ua
 zyJaBmz/X6nLQGhEg5jDjI22vHGBIa48ieQBAH7+VPj1nrJj6J0Gxrr3M3BT7trL9SMe
 uOS/nRPutY0G6OICiyo9xclh7GX1Ycuh4ekbPOakReFx84uoXiUe009YoxHI5tUm3/DY Dg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 33ndnuqbh4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 24 Sep 2020 10:11:46 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08OAAAUd135089;
        Thu, 24 Sep 2020 10:11:45 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 33r28wt2fq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 24 Sep 2020 10:11:45 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 08OABhqO013725;
        Thu, 24 Sep 2020 10:11:44 GMT
Received: from localhost.localdomain (/39.109.231.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 24 Sep 2020 03:11:43 -0700
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     nborisov@suse.com, wqu@suse.com, dsterba@suse.com,
        Anand Jain <anand.jain@oracle.com>
Subject: [PATCH 2/2] btrfs: fix btrfs_find_device unused arg seed
Date:   Thu, 24 Sep 2020 18:11:24 +0800
Message-Id: <b9108a14773af7a899226f59a9dbd0953d20abe5.1600940809.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1600940809.git.anand.jain@oracle.com>
References: <cover.1600940809.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9753 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999
 suspectscore=3 adultscore=0 bulkscore=0 malwarescore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009240077
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9753 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 phishscore=0 adultscore=0 suspectscore=3 bulkscore=0
 clxscore=1015 impostorscore=0 mlxlogscore=999 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009240077
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

commit 343694eee8d8 (btrfs: switch seed device to list api), missed to
check if the last arg (seed) is true in the function btrfs_find_device().
This arg tells whether to traverse through the seed device list or not.

This means after the above commit the arg is always true, and the parent
function which set this arg to false aren't effective.

So we don't worry about the parent functions which set the last arg to
true, instead there is only one parent with calling btrfs_find_device
with the last arg false in device_list_add().

But in fact, even the device_list_add() has no purpose that it has to set
the last arg to false. Because the fs_devices always points to the
device's fs_devices. So with the devid+uuid matching, it shall find the
btrfs_device and returns. So naturally, it won't traverse through the
seed fs_devices (if) present.

So this patch makes it official that we don't need the last arg in the
function btrfs_find_device() and it shall always traverse through the
seed device list.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 fs/btrfs/dev-replace.c |  4 ++--
 fs/btrfs/ioctl.c       |  4 ++--
 fs/btrfs/scrub.c       |  4 ++--
 fs/btrfs/volumes.c     | 22 ++++++++++------------
 fs/btrfs/volumes.h     |  2 +-
 5 files changed, 17 insertions(+), 19 deletions(-)

diff --git a/fs/btrfs/dev-replace.c b/fs/btrfs/dev-replace.c
index 119721eeecf6..c58a99677cf9 100644
--- a/fs/btrfs/dev-replace.c
+++ b/fs/btrfs/dev-replace.c
@@ -149,10 +149,10 @@ int btrfs_init_dev_replace(struct btrfs_fs_info *fs_info)
 	case BTRFS_IOCTL_DEV_REPLACE_STATE_STARTED:
 	case BTRFS_IOCTL_DEV_REPLACE_STATE_SUSPENDED:
 		dev_replace->srcdev = btrfs_find_device(fs_info->fs_devices,
-						src_devid, NULL, NULL, true);
+						src_devid, NULL, NULL);
 		dev_replace->tgtdev = btrfs_find_device(fs_info->fs_devices,
 							BTRFS_DEV_REPLACE_DEVID,
-							NULL, NULL, true);
+							NULL, NULL);
 		/*
 		 * allow 'btrfs dev replace_cancel' if src/tgt device is
 		 * missing
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index ab408a23ba32..a3550b0fa9b0 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -1680,7 +1680,7 @@ static noinline int btrfs_ioctl_resize(struct file *file,
 		btrfs_info(fs_info, "resizing devid %llu", devid);
 	}
 
-	device = btrfs_find_device(fs_info->fs_devices, devid, NULL, NULL, true);
+	device = btrfs_find_device(fs_info->fs_devices, devid, NULL, NULL);
 	if (!device) {
 		btrfs_info(fs_info, "resizer unable to find device %llu",
 			   devid);
@@ -3323,7 +3323,7 @@ static long btrfs_ioctl_dev_info(struct btrfs_fs_info *fs_info,
 
 	rcu_read_lock();
 	dev = btrfs_find_device(fs_info->fs_devices, di_args->devid, s_uuid,
-				NULL, true);
+				NULL);
 
 	if (!dev) {
 		ret = -ENODEV;
diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index cf63f1e27a27..a0b5fb331791 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -3855,7 +3855,7 @@ int btrfs_scrub_dev(struct btrfs_fs_info *fs_info, u64 devid, u64 start,
 		goto out_free_ctx;
 
 	mutex_lock(&fs_info->fs_devices->device_list_mutex);
-	dev = btrfs_find_device(fs_info->fs_devices, devid, NULL, NULL, true);
+	dev = btrfs_find_device(fs_info->fs_devices, devid, NULL, NULL);
 	if (!dev || (test_bit(BTRFS_DEV_STATE_MISSING, &dev->dev_state) &&
 		     !is_dev_replace)) {
 		mutex_unlock(&fs_info->fs_devices->device_list_mutex);
@@ -4031,7 +4031,7 @@ int btrfs_scrub_progress(struct btrfs_fs_info *fs_info, u64 devid,
 	struct scrub_ctx *sctx = NULL;
 
 	mutex_lock(&fs_info->fs_devices->device_list_mutex);
-	dev = btrfs_find_device(fs_info->fs_devices, devid, NULL, NULL, true);
+	dev = btrfs_find_device(fs_info->fs_devices, devid, NULL, NULL);
 	if (dev)
 		sctx = dev->scrub_ctx;
 	if (sctx)
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 9be40eece8ed..29995f23aa75 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -822,7 +822,7 @@ static noinline struct btrfs_device *device_list_add(const char *path,
 	} else {
 		mutex_lock(&fs_devices->device_list_mutex);
 		device = btrfs_find_device(fs_devices, devid,
-				disk_super->dev_item.uuid, NULL, false);
+				disk_super->dev_item.uuid, NULL);
 
 		/*
 		 * If this disk has been pulled into an fs devices created by
@@ -2296,10 +2296,10 @@ static struct btrfs_device *btrfs_find_device_by_path(
 	dev_uuid = disk_super->dev_item.uuid;
 	if (btrfs_fs_incompat(fs_info, METADATA_UUID))
 		device = btrfs_find_device(fs_info->fs_devices, devid, dev_uuid,
-					   disk_super->metadata_uuid, true);
+					   disk_super->metadata_uuid);
 	else
 		device = btrfs_find_device(fs_info->fs_devices, devid, dev_uuid,
-					   disk_super->fsid, true);
+					   disk_super->fsid);
 
 	btrfs_release_disk_super(disk_super);
 	if (!device)
@@ -2319,7 +2319,7 @@ struct btrfs_device *btrfs_find_device_by_devspec(
 
 	if (devid) {
 		device = btrfs_find_device(fs_info->fs_devices, devid, NULL,
-					   NULL, true);
+					   NULL);
 		if (!device)
 			return ERR_PTR(-ENOENT);
 		return device;
@@ -2468,7 +2468,7 @@ static int btrfs_finish_sprout(struct btrfs_trans_handle *trans)
 		read_extent_buffer(leaf, fs_uuid, btrfs_device_fsid(dev_item),
 				   BTRFS_FSID_SIZE);
 		device = btrfs_find_device(fs_info->fs_devices, devid, dev_uuid,
-					   fs_uuid, true);
+					   fs_uuid);
 		BUG_ON(!device); /* Logic error */
 
 		if (device->fs_devices->seeding) {
@@ -6450,8 +6450,7 @@ blk_status_t btrfs_map_bio(struct btrfs_fs_info *fs_info, struct bio *bio,
  * If @seed is true, traverse through the seed devices.
  */
 struct btrfs_device *btrfs_find_device(struct btrfs_fs_devices *fs_devices,
-				       u64 devid, u8 *uuid, u8 *fsid,
-				       bool seed)
+				       u64 devid, u8 *uuid, u8 *fsid)
 {
 	struct btrfs_device *device;
 	struct btrfs_fs_devices *seed_devs;
@@ -6658,7 +6657,7 @@ static int read_one_chunk(struct btrfs_key *key, struct extent_buffer *leaf,
 				   btrfs_stripe_dev_uuid_nr(chunk, i),
 				   BTRFS_UUID_SIZE);
 		map->stripes[i].dev = btrfs_find_device(fs_info->fs_devices,
-							devid, uuid, NULL, true);
+							devid, uuid, NULL);
 		if (!map->stripes[i].dev &&
 		    !btrfs_test_opt(fs_info, DEGRADED)) {
 			free_extent_map(em);
@@ -6797,7 +6796,7 @@ static int read_one_dev(struct extent_buffer *leaf,
 	}
 
 	device = btrfs_find_device(fs_info->fs_devices, devid, dev_uuid,
-				   fs_uuid, true);
+				   fs_uuid);
 	if (!device) {
 		if (!btrfs_test_opt(fs_info, DEGRADED)) {
 			btrfs_report_missing_device(fs_info, devid,
@@ -7439,8 +7438,7 @@ int btrfs_get_dev_stats(struct btrfs_fs_info *fs_info,
 	int i;
 
 	mutex_lock(&fs_devices->device_list_mutex);
-	dev = btrfs_find_device(fs_info->fs_devices, stats->devid, NULL, NULL,
-				true);
+	dev = btrfs_find_device(fs_info->fs_devices, stats->devid, NULL, NULL);
 	mutex_unlock(&fs_devices->device_list_mutex);
 
 	if (!dev) {
@@ -7571,7 +7569,7 @@ static int verify_one_dev_extent(struct btrfs_fs_info *fs_info,
 	}
 
 	/* Make sure no dev extent is beyond device bondary */
-	dev = btrfs_find_device(fs_info->fs_devices, devid, NULL, NULL, true);
+	dev = btrfs_find_device(fs_info->fs_devices, devid, NULL, NULL);
 	if (!dev) {
 		btrfs_err(fs_info, "failed to find devid %llu", devid);
 		ret = -EUCLEAN;
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index 48bdca01e237..ebb7df93e63f 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -453,7 +453,7 @@ int btrfs_num_copies(struct btrfs_fs_info *fs_info, u64 logical, u64 len);
 int btrfs_grow_device(struct btrfs_trans_handle *trans,
 		      struct btrfs_device *device, u64 new_size);
 struct btrfs_device *btrfs_find_device(struct btrfs_fs_devices *fs_devices,
-				       u64 devid, u8 *uuid, u8 *fsid, bool seed);
+				       u64 devid, u8 *uuid, u8 *fsid);
 int btrfs_shrink_device(struct btrfs_device *device, u64 new_size);
 int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *path);
 int btrfs_balance(struct btrfs_fs_info *fs_info,
-- 
2.25.1

