Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BDF0ACDE6E
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Oct 2019 11:45:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727522AbfJGJp1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Oct 2019 05:45:27 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:37044 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727506AbfJGJp0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Oct 2019 05:45:26 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x979cvxK055175
        for <linux-btrfs@vger.kernel.org>; Mon, 7 Oct 2019 09:45:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2019-08-05;
 bh=DohWxkfCt4g3rEVlPbAEZngxr7crwRtuveTVz1roRIg=;
 b=sQW3xn9iopjqExYDT3B/t4/cwW1l/iUu4TxfpOWAOmtQ/UAI6ultlll+YxfcBExdGfqK
 HnnNdnxjsjaqM4bBlWelTUPW+3qegsZHL003Zqw5ddk/B+k3n5KTSvPc4Mmq/50J19jT
 0G8Q2GniIGDo8i2sDc1PhAcSZr+1j7uBDaJaCDEJ6NKo676czH40JxUpuKHVZex39dYS
 WtyARf6zLi3P7b7kO3YZ9BtIorcE7J3i7rz8wH5o3gUzqcRJRZDWmt797N2CjDLs6DT7
 LtgmBcO2yHqmgRThk0M4NkCIF2cOgQMinbJz+pXeMvZdqx+7mc1/ntX6I5FR2OMjMBp/ RA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 2vektr5gej-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Mon, 07 Oct 2019 09:45:26 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x979cQSo077636
        for <linux-btrfs@vger.kernel.org>; Mon, 7 Oct 2019 09:45:25 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 2vg1ytjujm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Mon, 07 Oct 2019 09:45:25 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x979jOTg003988
        for <linux-btrfs@vger.kernel.org>; Mon, 7 Oct 2019 09:45:24 GMT
Received: from localhost.localdomain (/39.109.145.141)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 07 Oct 2019 02:45:23 -0700
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v3 3/5] btrfs: remove identified alien btrfs device in open_fs_devices
Date:   Mon,  7 Oct 2019 17:45:13 +0800
Message-Id: <20191007094515.925-4-anand.jain@oracle.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191007094515.925-1-anand.jain@oracle.com>
References: <20191007094515.925-1-anand.jain@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9402 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910070097
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9402 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910070097
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

In open_fs_devices() we identify alien device but we don't reset its
the device::name. So progs device list does not show the device missing
as shown in the script below.

mkfs.btrfs -fq /dev/sdd && mount /dev/sdd /btrfs
mkfs.btrfs -fq -draid1 -mraid1 /dev/sdc /dev/sdb
sleep 3 # avoid racing with udev's useless scans if needed
btrfs dev add -f /dev/sdb /btrfs
mount -o degraded /dev/sdc /btrfs1

No missing device:
btrfs fi show -m /btrfs1
Label: none  uuid: 3eb7cd50-4594-458f-9d68-c243cc49954d
	Total devices 2 FS bytes used 128.00KiB
	devid    1 size 12.00GiB used 1.26GiB path /dev/sdc
	devid    2 size 12.00GiB used 1.26GiB path /dev/sdb

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
v3: Fix nit, rearrange code to remove continue.
v2: Move free alien part to its parent function btrfs_open_one_device.
    Thanks Nikolay.

 fs/btrfs/volumes.c | 30 +++++++++++++++++++++---------
 1 file changed, 21 insertions(+), 9 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 0cc8d40b8bb9..81097c80ac4a 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -591,13 +591,18 @@ static int btrfs_open_one_device(struct btrfs_fs_devices *fs_devices,
 	if (ret)
 		return ret;
 
+	ret = -EINVAL;
 	disk_super = (struct btrfs_super_block *)bh->b_data;
 	devid = btrfs_stack_device_id(&disk_super->dev_item);
-	if (devid != device->devid)
+	if (devid != device->devid) {
+		ret = -EUCLEAN;
 		goto error_brelse;
+	}
 
-	if (memcmp(device->uuid, disk_super->dev_item.uuid, BTRFS_UUID_SIZE))
+	if (memcmp(device->uuid, disk_super->dev_item.uuid, BTRFS_UUID_SIZE)) {
+		ret = -EUCLEAN;
 		goto error_brelse;
+	}
 
 	device->generation = btrfs_super_generation(disk_super);
 
@@ -640,7 +645,7 @@ static int btrfs_open_one_device(struct btrfs_fs_devices *fs_devices,
 	brelse(bh);
 	blkdev_put(bdev, flags);
 
-	return -EINVAL;
+	return ret;
 }
 
 /*
@@ -1123,18 +1128,25 @@ int btrfs_close_devices(struct btrfs_fs_devices *fs_devices)
 static int open_fs_devices(struct btrfs_fs_devices *fs_devices,
 				fmode_t flags, void *holder)
 {
+	int ret;
 	struct btrfs_device *device;
+	struct btrfs_device *tmp_device;
 	struct btrfs_device *latest_dev = NULL;
 
 	flags |= FMODE_EXCL;
 
-	list_for_each_entry(device, &fs_devices->devices, dev_list) {
+	list_for_each_entry_safe(device, tmp_device, &fs_devices->devices,
+				 dev_list) {
 		/* Just open everything we can; ignore failures here */
-		if (btrfs_open_one_device(fs_devices, device, flags, holder))
-			continue;
-
-		if (!latest_dev ||
-		    device->generation > latest_dev->generation)
+		ret = btrfs_open_one_device(fs_devices, device, flags, holder);
+		if (ret == -EUCLEAN) {
+			/* Its an alien device, remove it from the list */
+			fs_devices->num_devices--;
+			list_del(&device->dev_list);
+			btrfs_free_device(device);
+		}
+		if (ret == 0 && (!latest_dev ||
+		    device->generation > latest_dev->generation))
 			latest_dev = device;
 	}
 	if (fs_devices->open_devices == 0)
-- 
1.8.3.1

