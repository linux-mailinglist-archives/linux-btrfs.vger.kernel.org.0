Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2229FCB579
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Oct 2019 09:50:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729936AbfJDHuX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 4 Oct 2019 03:50:23 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:33900 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726811AbfJDHuX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 4 Oct 2019 03:50:23 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x947mr14103644
        for <linux-btrfs@vger.kernel.org>; Fri, 4 Oct 2019 07:50:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references; s=corp-2019-08-05;
 bh=oyn5O2PqwBk1WbzNKfFMjpdu7aFVGMqdD0PFM4rjmsk=;
 b=GU7SKPVOPyJoKXgJ4N7VYfpy/3dfovjU9A8LK27vmGTZbEWlASeev2dm5+P/wkl1nG9X
 NwTmyplUS/E9SjU4SS1CTbLuMIlRjR+XH8nKk+IF/7ZLqEHDRmwi8TRAqZCPfatpKzde
 FIZ7OF5EI48MOI9OAmU+WG7250KCUQ1ee3aQq+54YjytvKz/rKsQq/+eLhbGjDBRemtz
 7ZsvTiRVTXLnIgMJT9bmu7k8L6mOiiSCatxfhCUwEsTjhTUCU20ln+Uo1Qf7iFWQ2aM2
 BCcaHojsGd9C0Ym4TORjNOopw8lJly6RxqrNCMf6rjwsvSepxxUM/gC1Zh/Z8maKe9BC kA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 2va05s9gaw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Fri, 04 Oct 2019 07:50:21 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x947mAQ0090590
        for <linux-btrfs@vger.kernel.org>; Fri, 4 Oct 2019 07:50:21 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 2vdt3p6qym-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Fri, 04 Oct 2019 07:50:20 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x947oJAS002948
        for <linux-btrfs@vger.kernel.org>; Fri, 4 Oct 2019 07:50:19 GMT
Received: from tp.wifi.oracle.com (/192.188.170.104)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 04 Oct 2019 00:50:19 -0700
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 2/4] btrfs: delete identified alien device in open_fs_devices
Date:   Fri,  4 Oct 2019 15:50:01 +0800
Message-Id: <1570175403-4073-3-git-send-email-anand.jain@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1570175403-4073-1-git-send-email-anand.jain@oracle.com>
References: <1570175403-4073-1-git-send-email-anand.jain@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9399 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910040072
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9399 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910040072
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
PS: Fundamentally its wrong approach that btrfs-progs deduces the device
missing state in the userland instead of obtaining it from the kernel.
I objected on the patch, but still those patches got merged, this bug is
one of its side effects. Ironically I wrote patches to read device_state
from the kernel using ioctl, procfs and sysfs but didn't get the due
attention till a merger.

 fs/btrfs/volumes.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 06ec3577c6b4..05ade8c7342b 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -803,10 +803,10 @@ static int btrfs_open_one_device(struct btrfs_fs_devices *fs_devices,
 	disk_super = (struct btrfs_super_block *)bh->b_data;
 	devid = btrfs_stack_device_id(&disk_super->dev_item);
 	if (devid != device->devid)
-		goto error_brelse;
+		goto free_alien;
 
 	if (memcmp(device->uuid, disk_super->dev_item.uuid, BTRFS_UUID_SIZE))
-		goto error_brelse;
+		goto free_alien;
 
 	device->generation = btrfs_super_generation(disk_super);
 
@@ -845,6 +845,11 @@ static int btrfs_open_one_device(struct btrfs_fs_devices *fs_devices,
 
 	return 0;
 
+free_alien:
+	fs_devices->num_devices--;
+	list_del(&device->dev_list);
+	btrfs_free_device(device);
+
 error_brelse:
 	brelse(bh);
 	blkdev_put(bdev, flags);
@@ -1329,11 +1334,13 @@ static int open_fs_devices(struct btrfs_fs_devices *fs_devices,
 				fmode_t flags, void *holder)
 {
 	struct btrfs_device *device;
+	struct btrfs_device *tmp_device;
 	struct btrfs_device *latest_dev = NULL;
 
 	flags |= FMODE_EXCL;
 
-	list_for_each_entry(device, &fs_devices->devices, dev_list) {
+	list_for_each_entry_safe(device, tmp_device, &fs_devices->devices,
+				 dev_list) {
 		/* Just open everything we can; ignore failures here */
 		if (btrfs_open_one_device(fs_devices, device, flags, holder))
 			continue;
-- 
1.8.3.1

