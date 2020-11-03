Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A8882A3C36
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Nov 2020 06:52:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725988AbgKCFwI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 3 Nov 2020 00:52:08 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:46352 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725934AbgKCFwG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 3 Nov 2020 00:52:06 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0A35n5xR063429;
        Tue, 3 Nov 2020 05:51:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=vsBweBdOr+GvTUDJK8EYTjb38mTHhg/K0KfPLF2ZOD0=;
 b=UAAKwvMUNtMG9Wzhd1QsmztQE5e+WI6RZP5M7ecxyi/VlvNxYprl0hhs3M98yfa0pqFy
 1/IR/oh+fG9EIZuLKy0VsV73nXn3wZVIgqAB8dwG1Uz2FO1SZYVFRZHnrBT1Qa+MjcFc
 fBlR6BJFy2wD9Yfk31+hYyEXWcswRZCij6jal47aMM5IBoo4alxl3FHPEBnGYP+n9Wzq
 GJvvgMQWIg+BFPLIaBIClCVISy/8m38qRwvlufMb/PAsLKhRbqnb6AAr0W27B5K7cxhU
 kNuJ7F0mp9yQ5Xpz6k9s2AyHnqoZeMgMvr9Cnhiq/XvKvRT8zPZ9w1sbxh0wRzN/37vN Bw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 34hhw2fcnb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 03 Nov 2020 05:51:59 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0A35emDW017217;
        Tue, 3 Nov 2020 05:49:59 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 34jf47v443-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 Nov 2020 05:49:58 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0A35nv7R008599;
        Tue, 3 Nov 2020 05:49:57 GMT
Received: from localhost.localdomain (/39.109.231.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 02 Nov 2020 21:49:57 -0800
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.com, Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH RESEND v2 2/3] btrfs: fix btrfs_find_device unused arg seed
Date:   Tue,  3 Nov 2020 13:49:43 +0800
Message-Id: <0875530c9a86033600e6712ab11fec5c13af7855.1604372689.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1604372688.git.anand.jain@oracle.com>
References: <cover.1604372688.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9793 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=3 mlxscore=0
 bulkscore=0 malwarescore=0 mlxlogscore=999 phishscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011030042
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9793 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 mlxscore=0
 suspectscore=3 clxscore=1015 priorityscore=1501 impostorscore=0
 spamscore=0 lowpriorityscore=0 mlxlogscore=999 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011030043
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
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
---
v2: -
 fs/btrfs/dev-replace.c |  4 ++--
 fs/btrfs/ioctl.c       |  4 ++--
 fs/btrfs/scrub.c       |  4 ++--
 fs/btrfs/volumes.c     | 22 ++++++++++------------
 fs/btrfs/volumes.h     |  2 +-
 5 files changed, 17 insertions(+), 19 deletions(-)

diff --git a/fs/btrfs/dev-replace.c b/fs/btrfs/dev-replace.c
index 5b9e3f3ace22..ffab2758f991 100644
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
index 69a384145dc6..36e09a22068a 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -1678,7 +1678,7 @@ static noinline int btrfs_ioctl_resize(struct file *file,
 		btrfs_info(fs_info, "resizing devid %llu", devid);
 	}
 
-	device = btrfs_find_device(fs_info->fs_devices, devid, NULL, NULL, true);
+	device = btrfs_find_device(fs_info->fs_devices, devid, NULL, NULL);
 	if (!device) {
 		btrfs_info(fs_info, "resizer unable to find device %llu",
 			   devid);
@@ -3321,7 +3321,7 @@ static long btrfs_ioctl_dev_info(struct btrfs_fs_info *fs_info,
 
 	rcu_read_lock();
 	dev = btrfs_find_device(fs_info->fs_devices, di_args->devid, s_uuid,
-				NULL, true);
+				NULL);
 
 	if (!dev) {
 		ret = -ENODEV;
diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 58cd3278fbfe..c85b493380da 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -3858,7 +3858,7 @@ int btrfs_scrub_dev(struct btrfs_fs_info *fs_info, u64 devid, u64 start,
 		goto out_free_ctx;
 
 	mutex_lock(&fs_info->fs_devices->device_list_mutex);
-	dev = btrfs_find_device(fs_info->fs_devices, devid, NULL, NULL, true);
+	dev = btrfs_find_device(fs_info->fs_devices, devid, NULL, NULL);
 	if (!dev || (test_bit(BTRFS_DEV_STATE_MISSING, &dev->dev_state) &&
 		     !is_dev_replace)) {
 		mutex_unlock(&fs_info->fs_devices->device_list_mutex);
@@ -4035,7 +4035,7 @@ int btrfs_scrub_progress(struct btrfs_fs_info *fs_info, u64 devid,
 	struct scrub_ctx *sctx = NULL;
 
 	mutex_lock(&fs_info->fs_devices->device_list_mutex);
-	dev = btrfs_find_device(fs_info->fs_devices, devid, NULL, NULL, true);
+	dev = btrfs_find_device(fs_info->fs_devices, devid, NULL, NULL);
 	if (dev)
 		sctx = dev->scrub_ctx;
 	if (sctx)
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index e615ca393aab..04ef251d885e 100644
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
@@ -2300,10 +2300,10 @@ static struct btrfs_device *btrfs_find_device_by_path(
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
@@ -2323,7 +2323,7 @@ struct btrfs_device *btrfs_find_device_by_devspec(
 
 	if (devid) {
 		device = btrfs_find_device(fs_info->fs_devices, devid, NULL,
-					   NULL, true);
+					   NULL);
 		if (!device)
 			return ERR_PTR(-ENOENT);
 		return device;
@@ -2472,7 +2472,7 @@ static int btrfs_finish_sprout(struct btrfs_trans_handle *trans)
 		read_extent_buffer(leaf, fs_uuid, btrfs_device_fsid(dev_item),
 				   BTRFS_FSID_SIZE);
 		device = btrfs_find_device(fs_info->fs_devices, devid, dev_uuid,
-					   fs_uuid, true);
+					   fs_uuid);
 		BUG_ON(!device); /* Logic error */
 
 		if (device->fs_devices->seeding) {
@@ -6465,8 +6465,7 @@ blk_status_t btrfs_map_bio(struct btrfs_fs_info *fs_info, struct bio *bio,
  * If @seed is true, traverse through the seed devices.
  */
 struct btrfs_device *btrfs_find_device(struct btrfs_fs_devices *fs_devices,
-				       u64 devid, u8 *uuid, u8 *fsid,
-				       bool seed)
+				       u64 devid, u8 *uuid, u8 *fsid)
 {
 	struct btrfs_device *device;
 	struct btrfs_fs_devices *seed_devs;
@@ -6673,7 +6672,7 @@ static int read_one_chunk(struct btrfs_key *key, struct extent_buffer *leaf,
 				   btrfs_stripe_dev_uuid_nr(chunk, i),
 				   BTRFS_UUID_SIZE);
 		map->stripes[i].dev = btrfs_find_device(fs_info->fs_devices,
-							devid, uuid, NULL, true);
+							devid, uuid, NULL);
 		if (!map->stripes[i].dev &&
 		    !btrfs_test_opt(fs_info, DEGRADED)) {
 			free_extent_map(em);
@@ -6812,7 +6811,7 @@ static int read_one_dev(struct extent_buffer *leaf,
 	}
 
 	device = btrfs_find_device(fs_info->fs_devices, devid, dev_uuid,
-				   fs_uuid, true);
+				   fs_uuid);
 	if (!device) {
 		if (!btrfs_test_opt(fs_info, DEGRADED)) {
 			btrfs_report_missing_device(fs_info, devid,
@@ -7479,8 +7478,7 @@ int btrfs_get_dev_stats(struct btrfs_fs_info *fs_info,
 	int i;
 
 	mutex_lock(&fs_devices->device_list_mutex);
-	dev = btrfs_find_device(fs_info->fs_devices, stats->devid, NULL, NULL,
-				true);
+	dev = btrfs_find_device(fs_info->fs_devices, stats->devid, NULL, NULL);
 	mutex_unlock(&fs_devices->device_list_mutex);
 
 	if (!dev) {
@@ -7611,7 +7609,7 @@ static int verify_one_dev_extent(struct btrfs_fs_info *fs_info,
 	}
 
 	/* Make sure no dev extent is beyond device bondary */
-	dev = btrfs_find_device(fs_info->fs_devices, devid, NULL, NULL, true);
+	dev = btrfs_find_device(fs_info->fs_devices, devid, NULL, NULL);
 	if (!dev) {
 		btrfs_err(fs_info, "failed to find devid %llu", devid);
 		ret = -EUCLEAN;
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index 34fd440fd30b..bd95cea85a65 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -466,7 +466,7 @@ int btrfs_num_copies(struct btrfs_fs_info *fs_info, u64 logical, u64 len);
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

