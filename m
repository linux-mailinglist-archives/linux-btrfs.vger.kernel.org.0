Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 946BF284C0B
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Oct 2020 14:54:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726442AbgJFMy3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 6 Oct 2020 08:54:29 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:33340 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726362AbgJFMy3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 6 Oct 2020 08:54:29 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 096CneEb161956;
        Tue, 6 Oct 2020 12:54:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=U7pPameypAZH0mSHHIIjcBeCTfQHKmAXbCwzAHgWotk=;
 b=RH1iXHUV9Mc7h+tmcOSTG05tkJBtQK3AyiztwX/nsncuKZPmlpXgFhBeJGsNzUdZL/qP
 mq/HGBXcm+udMQ7RUdW8xv2pQx523P5yGFfLGeAEfJQTMqBhfigNcUGQvHWN9Y/mcXP/
 Ct6Y+UjHGYES8HdJ4Ov+5zbiueFQnS4frf3H5A0aZc7p1eIXgMs+MsW77Q6u42vtD/lq
 YEg0AKpKIphSie+CEXKFvvUQkj9Aex5Z7nDMSy5WJreZxrISUUJAJmJpd45fDf21b05O
 /fQGeKy/A/WSTwCm6UvmO9djHYNtCUbyvDBr3PI6gI/+W9BFf2UqVaf8ODhMmKMcCL1g cA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 33xhxmurgn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 06 Oct 2020 12:54:22 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 096CpG7g156701;
        Tue, 6 Oct 2020 12:54:22 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 33y2vmx6gw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Oct 2020 12:54:22 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 096CsLBF007029;
        Tue, 6 Oct 2020 12:54:21 GMT
Received: from localhost.localdomain (/39.109.231.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 06 Oct 2020 05:54:20 -0700
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     josef@toxicpanda.com, nborisov@suse.com, wqu@suse.com
Subject: [PATCH v2 1/2] btrfs: drop never met condition of disk_total_bytes == 0
Date:   Tue,  6 Oct 2020 20:54:11 +0800
Message-Id: <2b54dd9a6634a833cff4e4ac8ff030a6b802652e.1601988260.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <4fea8a706aedf7407d6af7a545126511168e15f5.1600940809.git.anand.jain@oracle.com>
References: <4fea8a706aedf7407d6af7a545126511168e15f5.1600940809.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9765 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 malwarescore=0 suspectscore=1 spamscore=0 phishscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2010060082
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9765 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 bulkscore=0
 impostorscore=0 lowpriorityscore=0 suspectscore=1 phishscore=0
 mlxlogscore=999 adultscore=0 clxscore=1015 spamscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2010060082
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

btrfs_device::disk_total_bytes is set even for a seed device (the
comment is wrong).

The function fill_device_from_item() does the job of reading it from the
item and updating btrfs_device::disk_total_bytes. So both the missing
device and the seed devices do have their disk_total_bytes updated.

Furthermore, while removing the device if there is a power loss, we could
have a device with its total_bytes = 0, that's still valid.

So this patch removes the check dev->disk_total_bytes == 0 in the
function verify_one_dev_extent(), which it does nothing in it.

And take this opportunity to introduce a check if the device::total_bytes
is more than the max device size in read_one_dev().

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
v2: add check if the total_bytes is more than the actual device size in
    read_one_dev().
    update change log.

 fs/btrfs/volumes.c | 25 ++++++++++---------------
 1 file changed, 10 insertions(+), 15 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 2a5397fb4175..0c6049f9ace3 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -6847,6 +6847,16 @@ static int read_one_dev(struct extent_buffer *leaf,
 	}
 
 	fill_device_from_item(leaf, dev_item, device);
+	if (device->bdev) {
+		u64 max_total_bytes = i_size_read(device->bdev->bd_inode);
+
+		if (device->total_bytes > max_total_bytes) {
+			btrfs_err(fs_info,
+			"device total_bytes should be below %llu but found %llu",
+				  max_total_bytes, device->total_bytes);
+			return -EINVAL;
+		}
+	}
 	set_bit(BTRFS_DEV_STATE_IN_FS_METADATA, &device->dev_state);
 	if (test_bit(BTRFS_DEV_STATE_WRITEABLE, &device->dev_state) &&
 	   !test_bit(BTRFS_DEV_STATE_REPLACE_TGT, &device->dev_state)) {
@@ -7579,21 +7589,6 @@ static int verify_one_dev_extent(struct btrfs_fs_info *fs_info,
 		goto out;
 	}
 
-	/* It's possible this device is a dummy for seed device */
-	if (dev->disk_total_bytes == 0) {
-		struct btrfs_fs_devices *devs;
-
-		devs = list_first_entry(&fs_info->fs_devices->seed_list,
-					struct btrfs_fs_devices, seed_list);
-		dev = btrfs_find_device(devs, devid, NULL, NULL, false);
-		if (!dev) {
-			btrfs_err(fs_info, "failed to find seed devid %llu",
-				  devid);
-			ret = -EUCLEAN;
-			goto out;
-		}
-	}
-
 	if (physical_offset + physical_len > dev->disk_total_bytes) {
 		btrfs_err(fs_info,
 "dev extent devid %llu physical offset %llu len %llu is beyond device boundary %llu",
-- 
2.25.1

