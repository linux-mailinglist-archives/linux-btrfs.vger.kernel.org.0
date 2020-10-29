Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E15A729F6E2
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Oct 2020 22:30:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726723AbgJ2Vay (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 29 Oct 2020 17:30:54 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:49932 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726441AbgJ2Vay (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 29 Oct 2020 17:30:54 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09TLTPRj143740;
        Thu, 29 Oct 2020 21:30:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=4HUCWX/67vo4gWXw9GA6EXmAIWgnfUpk5mCd4s8H4UU=;
 b=s7Ap+0cXspqmwSpDptJZrxZHzkdjuH1c5Sy+8Y5473uTDEIHtH8a+QCOvJGZwzCIj4fD
 vRKXZxobsjQOFgMB60hvv7r7KmvfOXuz6y6B1lyNmvNgwWjHxAM6blLTVd++IzQ8C23O
 AJrGKBu0wy8RfAqYyT/14lCbAtYfTNp6m/twET5f8V35T5k0l63YoBf5lkFKXcRqD+hW
 U8Fw159AUmrWR/D+3SCw/KO4O5+Mti2GcdXtTBnwabD62LnN21nlR/aV5aLfJQofZRiw
 5YZF3urPSIbdwUgkXunr7n+BdV5m+8qtxiuxeA36i/BlPYkz1DGEHcBf3XjVtwIms/xc /A== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2130.oracle.com with ESMTP id 34c9sb7b15-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 29 Oct 2020 21:30:50 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09TLQX15034228;
        Thu, 29 Oct 2020 21:30:49 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 34cwuq8he3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 Oct 2020 21:30:49 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 09TLUmIl018369;
        Thu, 29 Oct 2020 21:30:48 GMT
Received: from localhost.localdomain (/39.109.231.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 29 Oct 2020 14:30:48 -0700
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.com, Anand Jain <anand.jain@oracle.com>,
        Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH RESEND v2 1/2] btrfs: drop never met condition of disk_total_bytes == 0
Date:   Fri, 30 Oct 2020 05:30:25 +0800
Message-Id: <2b54dd9a6634a833cff4e4ac8ff030a6b802652e.1601988260.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1600940809.git.anand.jain@oracle.com>
References: <cover.1600940809.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9789 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 bulkscore=0
 spamscore=0 adultscore=0 malwarescore=0 mlxlogscore=999 suspectscore=1
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010290149
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9789 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 malwarescore=0 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 spamscore=0 phishscore=0 clxscore=1015 suspectscore=1
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010290149
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

