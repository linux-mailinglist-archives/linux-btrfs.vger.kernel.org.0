Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AE9127E93B
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Sep 2020 15:10:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728270AbgI3NKL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 30 Sep 2020 09:10:11 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:34838 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725771AbgI3NKL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 30 Sep 2020 09:10:11 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08UD95Vn068170;
        Wed, 30 Sep 2020 13:10:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=VAyJxC+JZhoBVxKTEmWKm006uRoDOeGzRpz2kMcqChM=;
 b=PDoZ4DF0mS2oj1goLBkXj8CUxk1uP3c5Iu3A79lBy/+UV6Aks30O5/Pcq3L6T4YlNDVv
 HVdYpsgDic+Sedpd5xAch4WBQpOdToPzYVmaSwnuCFzEe0d9lCmSFSmvrXlP8HBHR138
 8hVi1XU+LSvOlYywhaU3rnUpXUKv+PDuaSL/zfMtbZ+OThku42B2y27zA4jMk6MUaMDP
 Yz6qcqTj1sXu1tREl7EttKyzEigU2NmNJInxszbvY5JI0gK08f58g5X2SaRFawZ7kFIK
 PETwFA16vHvUaOIbx9sWZulDiWF6AY1NBUVGaXMCfhP5HoiLmbl6ci7n7hd2h61DbH/r hQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 33sx9n8axv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 30 Sep 2020 13:10:05 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08UD6hfd109823;
        Wed, 30 Sep 2020 13:10:04 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 33tfj03hgf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Sep 2020 13:10:04 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 08UDA1vw017731;
        Wed, 30 Sep 2020 13:10:02 GMT
Received: from localhost.localdomain (/39.109.231.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 30 Sep 2020 06:10:01 -0700
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Johannes.Thumshirn@wdc.com, nborisov@suse.com, josef@toxicpanda.com
Subject: [PATCH v3] btrfs: free device without BTRFS_MAGIC
Date:   Wed, 30 Sep 2020 21:09:52 +0800
Message-Id: <e15a2f44a540c1e036e19664fd3a8220045dd762.1601470709.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <dbc067b24194241f6d87b8f9799d9b6484984a13.1600473987.git.anand.jain@oracle.com>
References: <dbc067b24194241f6d87b8f9799d9b6484984a13.1600473987.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9759 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999 bulkscore=0
 phishscore=0 malwarescore=0 adultscore=0 suspectscore=3 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009300104
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9759 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=3
 phishscore=0 mlxscore=0 lowpriorityscore=0 adultscore=0 clxscore=1015
 spamscore=0 impostorscore=0 malwarescore=0 bulkscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009300105
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Many things can happen after the device is scanned and before the device
is mounted.

One such thing is losing the BTRFS_MAGIC on the device.

If it happens we still won't free that device from the memory and causes
the userland to confuse.

For example: As the BTRFS_IOC_DEV_INFO still carries the device path which
does not have the BTRFS_MAGIC, the btrfs fi show still shows device
which does not belong. As shown below.

mkfs.btrfs -fq -draid1 -mraid1 /dev/sda /dev/sdb

wipefs -a /dev/sdb
mount -o degraded /dev/sda /btrfs
btrfs fi show -m

/dev/sdb does not contain BTRFS_MAGIC and we still show it as part of
btrfs.
Label: none  uuid: 470ec6fb-646b-4464-b3cb-df1b26c527bd
        Total devices 2 FS bytes used 128.00KiB
        devid    1 size 3.00GiB used 571.19MiB path /dev/sda
        devid    2 size 3.00GiB used 571.19MiB path /dev/sdb

Fix is to return -ENODATA error code in btrfs_read_dev_one_super()
when BTRFS_MAGIC check fails, and its parent open_fs_devices() to
free the device in the mount-thread.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
---
v3: First check for the BTRFS_MAGIC and then the bytenr check.
    Add rb.
v2: Do not return ENODATA on `btrfs_super_bytenr(super) != bytenr`

 fs/btrfs/disk-io.c |  8 ++++++--
 fs/btrfs/volumes.c | 19 +++++++++++++------
 2 files changed, 19 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 3d39f5d47ad3..764001609a15 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -3424,8 +3424,12 @@ struct btrfs_super_block *btrfs_read_dev_one_super(struct block_device *bdev,
 		return ERR_CAST(page);
 
 	super = page_address(page);
-	if (btrfs_super_bytenr(super) != bytenr ||
-		    btrfs_super_magic(super) != BTRFS_MAGIC) {
+	if (btrfs_super_magic(super) != BTRFS_MAGIC) {
+		btrfs_release_disk_super(super);
+		return ERR_PTR(-ENODATA);
+	}
+
+	if (btrfs_super_bytenr(super) != bytenr) {
 		btrfs_release_disk_super(super);
 		return ERR_PTR(-EINVAL);
 	}
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index c69da5eb7636..a208043b4419 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -1197,17 +1197,24 @@ static int open_fs_devices(struct btrfs_fs_devices *fs_devices,
 {
 	struct btrfs_device *device;
 	struct btrfs_device *latest_dev = NULL;
+	struct btrfs_device *tmp_device;
 
 	flags |= FMODE_EXCL;
 
-	list_for_each_entry(device, &fs_devices->devices, dev_list) {
-		/* Just open everything we can; ignore failures here */
-		if (btrfs_open_one_device(fs_devices, device, flags, holder))
-			continue;
+	list_for_each_entry_safe(device, tmp_device, &fs_devices->devices,
+				 dev_list) {
+		int ret;
 
-		if (!latest_dev ||
-		    device->generation > latest_dev->generation)
+		/* Just open everything we can; ignore failures here */
+		ret = btrfs_open_one_device(fs_devices, device, flags, holder);
+		if (ret == 0 && (!latest_dev ||
+		    device->generation > latest_dev->generation)) {
 			latest_dev = device;
+		} else if (ret == -ENODATA) {
+			fs_devices->num_devices--;
+			list_del(&device->dev_list);
+			btrfs_free_device(device);
+		}
 	}
 	if (fs_devices->open_devices == 0)
 		return -EINVAL;
-- 
2.25.1

