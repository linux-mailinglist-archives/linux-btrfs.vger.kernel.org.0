Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31FDA2FCC13
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Jan 2021 08:53:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729027AbhATHxc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 20 Jan 2021 02:53:32 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:54118 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729524AbhATHxU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 20 Jan 2021 02:53:20 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10K7meGU162964;
        Wed, 20 Jan 2021 07:52:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=y937VeGWFB1iJucaXFao/WtEd31mdn6dclhagdvfEgA=;
 b=SqIK0b7VGxLdKNT+y8GXQ6VgekgB4NQj5dDIaKwRjbz7qbL3K1vuHakTsPgdUD5qJ5EU
 QYMnnZ3PGvK/0vDGkft6j3rDUIoyTEydheP1g8w01hjjqDMUjEjCU+vC3yjhpYMkAmjG
 zDt9YUqWg9UfwSYt8a896y1vmmyfq8Fd2Gcjl4KSSUKzsJQVCNHUziLrIYp70wrhw/PH
 h/rDt/7+CvvaaOzil2bXNHgbhLRBri8az9Demf6vNPYDk9ISsynvAsloSW0gm9+FzLo5
 hvEFaPFynMCTy+0lZWQ6jpiW50IqeJiKGGII1qtm7OXFFT8IB7spz4/3m8HRZvSYbtmr XQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2130.oracle.com with ESMTP id 3668qr9589-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Jan 2021 07:52:15 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10K7nnNQ162597;
        Wed, 20 Jan 2021 07:52:15 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 3668rdgmhe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Jan 2021 07:52:15 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 10K7qEZW002921;
        Wed, 20 Jan 2021 07:52:14 GMT
Received: from ca-dev104.us.oracle.com (/10.129.135.33)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 19 Jan 2021 23:52:14 -0800
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.com, josef@toxicpanda.com
Subject: [PATCH v4 1/3] btrfs: add read_policy latency
Date:   Tue, 19 Jan 2021 23:52:05 -0800
Message-Id: <63f6f00e2ecc741efd2200c3c87b5db52c6be2fd.1611114341.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1611114341.git.anand.jain@oracle.com>
References: <cover.1611114341.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9869 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 suspectscore=0
 adultscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101200043
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9869 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0 spamscore=0
 phishscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101200043
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The read policy type latency routes the read IO based on the historical
average wait-time experienced by the read IOs through the individual
device. This patch obtains the historical read IO stats from the kernel
block layer and calculates its average.

Example usage:
 echo "latency" > /sys/fs/btrfs/$uuid/read_policy

Signed-off-by: Anand Jain <anand.jain@oracle.com>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
---
v4: For btrfs_debug_rl() use fs_info instead of
    device->fs_devices->fs_info.

v3: The block layer commit 0d02129e76ed (block: merge struct block_device and
    struct hd_struct) has changed the first argument in the function
    part_stat_read_all() in 5.11-rc1. So the compilation will fail. This patch
    fixes it.
    Commit log updated.

v2: Use btrfs_debug_rl() instead of btrfs_info_rl()
    It is better we have this debug until we test this on at least few
    hardwares.
    Drop the unrelated changes.
    Update change log.

rfc->v1: Drop part_stat_read_all instead use part_stat_read
    Drop inflight

 fs/btrfs/sysfs.c   |  3 ++-
 fs/btrfs/volumes.c | 38 ++++++++++++++++++++++++++++++++++++++
 fs/btrfs/volumes.h |  2 ++
 3 files changed, 42 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index 4522a1c4cd08..7c0324fe97b2 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -915,7 +915,8 @@ static bool strmatch(const char *buffer, const char *string)
 	return false;
 }
 
-static const char * const btrfs_read_policy_name[] = { "pid" };
+/* Must follow the order as in enum btrfs_read_policy */
+static const char * const btrfs_read_policy_name[] = { "pid", "latency" };
 
 static ssize_t btrfs_read_policy_show(struct kobject *kobj,
 				      struct kobj_attribute *a, char *buf)
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 62d6a890fc50..f361f1c87eb6 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -14,6 +14,7 @@
 #include <linux/semaphore.h>
 #include <linux/uuid.h>
 #include <linux/list_sort.h>
+#include <linux/part_stat.h>
 #include "misc.h"
 #include "ctree.h"
 #include "extent_map.h"
@@ -5490,6 +5491,39 @@ int btrfs_is_parity_mirror(struct btrfs_fs_info *fs_info, u64 logical, u64 len)
 	return ret;
 }
 
+static int btrfs_find_best_stripe(struct btrfs_fs_info *fs_info,
+				  struct map_lookup *map, int first,
+				  int num_stripe)
+{
+	u64 est_wait = 0;
+	int best_stripe = 0;
+	int index;
+
+	for (index = first; index < first + num_stripe; index++) {
+		u64 read_wait;
+		u64 avg_wait = 0;
+		unsigned long read_ios;
+		struct btrfs_device *device = map->stripes[index].dev;
+
+		read_wait = part_stat_read(device->bdev, nsecs[READ]);
+		read_ios = part_stat_read(device->bdev, ios[READ]);
+
+		if (read_wait && read_ios && read_wait >= read_ios)
+			avg_wait = div_u64(read_wait, read_ios);
+		else
+			btrfs_debug_rl(fs_info,
+			"devid: %llu avg_wait ZERO read_wait %llu read_ios %lu",
+				       device->devid, read_wait, read_ios);
+
+		if (est_wait == 0 || est_wait > avg_wait) {
+			est_wait = avg_wait;
+			best_stripe = index;
+		}
+	}
+
+	return best_stripe;
+}
+
 static int find_live_mirror(struct btrfs_fs_info *fs_info,
 			    struct map_lookup *map, int first,
 			    int dev_replace_is_ongoing)
@@ -5519,6 +5553,10 @@ static int find_live_mirror(struct btrfs_fs_info *fs_info,
 	case BTRFS_READ_POLICY_PID:
 		preferred_mirror = first + (current->pid % num_stripes);
 		break;
+	case BTRFS_READ_POLICY_LATENCY:
+		preferred_mirror = btrfs_find_best_stripe(fs_info, map, first,
+							  num_stripes);
+		break;
 	}
 
 	if (dev_replace_is_ongoing &&
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index 1997a4649a66..71ba1f0e93f4 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -222,6 +222,8 @@ enum btrfs_chunk_allocation_policy {
 enum btrfs_read_policy {
 	/* Use process PID to choose the stripe */
 	BTRFS_READ_POLICY_PID,
+	/* Find and use device with the lowest latency */
+	BTRFS_READ_POLICY_LATENCY,
 	BTRFS_NR_READ_POLICY,
 };
 
-- 
2.28.0

