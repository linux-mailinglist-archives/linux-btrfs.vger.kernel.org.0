Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DC95270A46
	for <lists+linux-btrfs@lfdr.de>; Sat, 19 Sep 2020 04:53:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726119AbgISCxN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 18 Sep 2020 22:53:13 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:48852 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726104AbgISCxN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 18 Sep 2020 22:53:13 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08J2oTBn022261
        for <linux-btrfs@vger.kernel.org>; Sat, 19 Sep 2020 02:53:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2020-01-29; bh=r2AyDytRDR+7BOV3Gc77FaBi2VORXkniDWshkONFu6Y=;
 b=hWjocD/JaoKCH1EZOBx1Q/KsB4Usi9MZa8ytFIanCExG0hmhnMkXoEqkHIntyfDAPlCi
 u2O3Mwu1z7VGcx4lPS53zrdNECu6Lkk/hVcuPAICdGs9X0kBEVgwIHP7EqnMt4k4Bssn
 3RRsP2Ck2OHseYHnKZOFX5V2TbUkdfWrWj/kL6CEJgdxD2qoENr9dmRgXgLImf5ZYall
 EsK7mb3ljuGA0iyeW7oVpoRrqaWVYyJXDBdn+9dy0nGVT5MZzHDA9Vfox32e1pb6FqqX
 PYnDz8a3nZjJG53FnI0Fz5MSSDO5nOJjTc6pA0eJBy5bp1uK4VsIcguBDpxgJjUxjRex yw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 33n9dqr0fw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
        for <linux-btrfs@vger.kernel.org>; Sat, 19 Sep 2020 02:53:11 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08J2jdss073086
        for <linux-btrfs@vger.kernel.org>; Sat, 19 Sep 2020 02:53:11 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 33h88g7fcm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Sat, 19 Sep 2020 02:53:11 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 08J2rA7G023274
        for <linux-btrfs@vger.kernel.org>; Sat, 19 Sep 2020 02:53:10 GMT
Received: from localhost.localdomain (/39.109.231.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sat, 19 Sep 2020 02:52:56 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Anand Jain <anand.jain@oracle.com>
Subject: [PATCH] btrfs: free device without BTRFS_MAGIC
Date:   Sat, 19 Sep 2020 10:52:22 +0800
Message-Id: <dbc067b24194241f6d87b8f9799d9b6484984a13.1600473987.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9748 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 adultscore=0
 suspectscore=3 phishscore=0 malwarescore=0 bulkscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009190023
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9748 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 phishscore=0 priorityscore=1501 malwarescore=0 mlxscore=0 impostorscore=0
 clxscore=1015 lowpriorityscore=0 suspectscore=3 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009190023
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
when BTRFS_MAGIC check fails, so that its parent open_fs_devices()
shall free the device in the mount-thread.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
Now the fstests btrfs/198 pass with this fix.

 fs/btrfs/disk-io.c |  2 +-
 fs/btrfs/volumes.c | 19 +++++++++++++------
 2 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 160b485d2cc0..9c91d12530a6 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -3432,7 +3432,7 @@ struct btrfs_super_block *btrfs_read_dev_one_super(struct block_device *bdev,
 	if (btrfs_super_bytenr(super) != bytenr ||
 		    btrfs_super_magic(super) != BTRFS_MAGIC) {
 		btrfs_release_disk_super(super);
-		return ERR_PTR(-EINVAL);
+		return ERR_PTR(-ENODATA);
 	}
 
 	return super;
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

