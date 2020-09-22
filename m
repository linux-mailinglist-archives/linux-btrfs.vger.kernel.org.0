Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63430273924
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Sep 2020 05:13:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728239AbgIVDNr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 21 Sep 2020 23:13:47 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:57868 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726818AbgIVDNr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 21 Sep 2020 23:13:47 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08M39PI3109772;
        Tue, 22 Sep 2020 03:13:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=flWvV1QoAJyIY0HmZijef149njLPDxEGD0Dnu3+gsZg=;
 b=MhWXx8Mp0koxroXGMQO9IxHIcZNWAtK8Eu4F6ifm0kPv6jPqrnSZK5fRPPC1fQoAzADc
 eXvLq6W38yOw7tpzteZhjGXRKxJ89en5UCrhMDlKfxQuTSnoJrCP1OBR1XAwF/LYUQ/k
 mx5650+LMhpmVF6kihH3zQPtUTPy27fbDSYAMXqqE3aCjE2c2LK3JXecVHCrwslYz5mO
 QgylQT3yWT8xOD9DWjPRcDn2xZYDX0GYO54SZrYTtAlvX8vC7wzxqIP+YGaxhrBqremb
 EGmeJClw+Atlp9g0fzJwE1adRnbGhA8GikjCVxO3mIJ2cn6Xxzv06TYZk7in9kwCHeI9 RQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2130.oracle.com with ESMTP id 33n7gad31t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 22 Sep 2020 03:13:45 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08M3BKCo078432;
        Tue, 22 Sep 2020 03:13:45 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 33nuwxj2ph-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 22 Sep 2020 03:13:44 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 08M3Dheb022438;
        Tue, 22 Sep 2020 03:13:43 GMT
Received: from localhost.localdomain (/39.109.231.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 21 Sep 2020 20:13:43 -0700
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Johannes.Thumshirn@wdc.com
Subject: [PATCH v2] btrfs: free device without BTRFS_MAGIC
Date:   Tue, 22 Sep 2020 11:13:34 +0800
Message-Id: <1ee9b318e3bb851aaec9c1efd1eadb117ad46638.1600741332.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <dbc067b24194241f6d87b8f9799d9b6484984a13.1600473987.git.anand.jain@oracle.com>
References: <dbc067b24194241f6d87b8f9799d9b6484984a13.1600473987.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9751 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 adultscore=0
 bulkscore=0 mlxlogscore=999 phishscore=0 suspectscore=3 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009220027
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9751 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 bulkscore=0
 mlxscore=0 suspectscore=3 impostorscore=0 malwarescore=0 spamscore=0
 phishscore=0 mlxlogscore=999 clxscore=1015 adultscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009220027
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
---
v2: Do not return ENODATA on `btrfs_super_bytenr(super) != bytenr`

 fs/btrfs/disk-io.c |  8 ++++++--
 fs/btrfs/volumes.c | 19 +++++++++++++------
 2 files changed, 19 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 160b485d2cc0..d84a49fe9639 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -3429,12 +3429,16 @@ struct btrfs_super_block *btrfs_read_dev_one_super(struct block_device *bdev,
 		return ERR_CAST(page);
 
 	super = page_address(page);
-	if (btrfs_super_bytenr(super) != bytenr ||
-		    btrfs_super_magic(super) != BTRFS_MAGIC) {
+	if (btrfs_super_bytenr(super) != bytenr) {
 		btrfs_release_disk_super(super);
 		return ERR_PTR(-EINVAL);
 	}
 
+	if (btrfs_super_magic(super) != BTRFS_MAGIC) {
+		btrfs_release_disk_super(super);
+		return ERR_PTR(-ENODATA);
+	}
+
 	return super;
 }
 
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 7cc677a7e544..ec9dac40b4f1 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -1198,17 +1198,24 @@ static int open_fs_devices(struct btrfs_fs_devices *fs_devices,
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

