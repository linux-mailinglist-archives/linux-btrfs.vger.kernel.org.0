Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 40090CCDF6
	for <lists+linux-btrfs@lfdr.de>; Sun,  6 Oct 2019 04:47:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726146AbfJFCrp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 5 Oct 2019 22:47:45 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:54828 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726074AbfJFCrp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sat, 5 Oct 2019 22:47:45 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x962iYeT108287;
        Sun, 6 Oct 2019 02:47:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2019-08-05;
 bh=RbbMjx4swX8MCfvObDazm1jJGI5ooZfieMESF79BEw8=;
 b=C4OQgXKrWnh+PVhEA1/21a9W4ezN2ToD3FZNxNyP4kFbMq4brhnmJOTkBamjzJglUQrs
 IBbMEfegmkhiZE59M1Djmj/kC+w/TyWaFsRplZhJtYrXIIpSsJTFulg5mciuHI90UaD2
 JQ863IALWvD5fOZCLY2sAOm4+JT/6arXxQCkgOk84So4LjrUrf++0hyBS4g91MlkwLIe
 BZwbn40gLBtJapDck2WyVlRODs4KlLDWhkSAmwcON2Rbh9TZUcclvG6Nj2iEW0Q5F8ma
 omJyADpu3sloLqcjF7+AxkT3Fh4vfVnMfaTFUKrOSROkDtHhtAbv0V472tnf3tm1jOcw pw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 2vejku2g59-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 06 Oct 2019 02:47:18 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x962i8s3174687;
        Sun, 6 Oct 2019 02:47:18 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 2vf4n677pm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 06 Oct 2019 02:47:17 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x962lGZ7003508;
        Sun, 6 Oct 2019 02:47:17 GMT
Received: from localhost.localdomain (/39.109.145.141)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sat, 05 Oct 2019 19:47:16 -0700
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     nborisov@suse.com
Subject: [PATCH v2 2/4] btrfs: delete identified alien device in open_fs_devices
Date:   Sun,  6 Oct 2019 10:47:11 +0800
Message-Id: <20191006024711.4666-1-anand.jain@oracle.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <66defad6-6757-76d2-8819-fd22b9cd1b9e@suse.com>
References: <66defad6-6757-76d2-8819-fd22b9cd1b9e@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9401 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910060027
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9401 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910060027
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
v2: Move free alien part to its parent function btrfs_open_one_device.
    Thanks Nikolay.

PS: Fundamentally its wrong approach that btrfs-progs deduces the device
missing state in the userland instead of obtaining it from the kernel.
I objected on the patch, but still those patches got merged, this bug is
one of its side effects. Ironically I wrote patches to read device_state
from the kernel using ioctl, procfs and sysfs but didn't get the due
attention till a merger.

 fs/btrfs/volumes.c | 32 +++++++++++++++++++++++---------
 1 file changed, 23 insertions(+), 9 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index c223a8147bfd..21aaf64c59b2 100644
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
@@ -1121,19 +1126,28 @@ int btrfs_close_devices(struct btrfs_fs_devices *fs_devices)
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
+		if (ret == 0 && (!latest_dev ||
+		    device->generation > latest_dev->generation)) {
 			latest_dev = device;
+			continue;
+		}
+		if (ret == -EUCLEAN) {
+			/* An alien device. Clean it up */
+			fs_devices->num_devices--;
+			list_del(&device->dev_list);
+			btrfs_free_device(device);
+		}
 	}
 	if (fs_devices->open_devices == 0)
 		return -EINVAL;
-- 
2.23.0

