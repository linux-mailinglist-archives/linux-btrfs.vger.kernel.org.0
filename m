Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88DA22A3C32
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Nov 2020 06:50:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726018AbgKCFuD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 3 Nov 2020 00:50:03 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:49232 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725934AbgKCFuD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 3 Nov 2020 00:50:03 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0A35nw48114334;
        Tue, 3 Nov 2020 05:49:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=Bs4J//c1+FGDikh386xej+0LqBtYB0LtpD0K5vCaSgM=;
 b=fr9rMCmC6BIj3z2QD+6Pq2v/s59ekRgqvBcii0OmcEk8Q9gFEStNDSw038hb4lb9pSC5
 t2eF6HMSSBfNGNPCLx7DyB0rDlNsySqNRSIqg1dDXglLEmii6H4sKvo+06q8HbQd86JB
 6OJoPj4ItagAcj+swKdjEPANpS6BV+VdXzsI2VVOgx1ovbt9kQUI3xoF3C4JYZ6IKPG3
 4PrBGQshzoj4GNrciqGp86jZwGHkc8g5PwyRZYQl5Cq6Lyjm9r3p/Fn2pZhTercs7cQd
 rBN6hvGe36sBzxfCvOTxiJqhwvPXZ4zIj6eJXViiup7l4bultTwmjBaTCJnMlOU3zdOa kw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 34hhvc7bsb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 03 Nov 2020 05:49:58 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0A35ngSN080514;
        Tue, 3 Nov 2020 05:49:57 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 34hvrv8014-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 Nov 2020 05:49:57 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0A35ntc5021039;
        Tue, 3 Nov 2020 05:49:56 GMT
Received: from localhost.localdomain (/39.109.231.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 02 Nov 2020 21:49:55 -0800
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.com, Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH RESEND v2 1/3] btrfs: drop never met condition of disk_total_bytes == 0
Date:   Tue,  3 Nov 2020 13:49:42 +0800
Message-Id: <682907bcd58ffeece1a76c6ec3b866139a6381bd.1604372689.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1604372688.git.anand.jain@oracle.com>
References: <cover.1604372688.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9793 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 mlxscore=0
 malwarescore=0 mlxlogscore=999 suspectscore=1 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011030043
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9793 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=1
 impostorscore=0 malwarescore=0 priorityscore=1501 mlxlogscore=999
 bulkscore=0 phishscore=0 adultscore=0 mlxscore=0 lowpriorityscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011030043
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
Reviewed-by: Nikolay Borisov <nborisov@suse.com>
---
v2: add check if the total_bytes is more than the actual device size in
    read_one_dev().
    update change log.

 fs/btrfs/volumes.c | 25 ++++++++++---------------
 1 file changed, 10 insertions(+), 15 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index eb9ee7c2998f..e615ca393aab 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -6875,6 +6875,16 @@ static int read_one_dev(struct extent_buffer *leaf,
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
@@ -7608,21 +7618,6 @@ static int verify_one_dev_extent(struct btrfs_fs_info *fs_info,
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

