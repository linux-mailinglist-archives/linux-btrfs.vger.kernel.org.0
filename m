Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64C662F0F4E
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Jan 2021 10:43:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728123AbhAKJmj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 11 Jan 2021 04:42:39 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:33708 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727915AbhAKJmi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 11 Jan 2021 04:42:38 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10B9Z5co046617;
        Mon, 11 Jan 2021 09:41:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=hMaF5jeU7Eoqnqnzvp13s1szsRwqIRAf041qRv92RuU=;
 b=ZTq47s5szruulIr8u8TPIwWuXHOQkd3fejjo/Ow2fUpOO+OiSWqnWEQgOfYwmIQgKqDW
 aLdMmKYtTGQPHxgniM7E/n5eu0M8WjYsicp7dRLhcdrsmcbDkEFk/mInqi+ZmhkB6fgB
 s/1ZLB5N4suAQkj3870JncuqE+zkpj8cUMUGE6lg47GlsDB0wm8qbeW8MW+iqFLppGs3
 Y7paKAVPsYo3MkY5evsyr0sRgHNFccpascWOWrPNm/ZYkYTzLLIul8XrlYozsrlQRRcQ
 Xu1ESy6aSLhr1SYJD3xI2fH8+8QU9xPiD7OBLtYOYggqnFgnJV+Yl0H0l08PScU7EhpH oQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 360kvjr4y0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 11 Jan 2021 09:41:52 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10B9UQkc014746;
        Mon, 11 Jan 2021 09:41:52 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 360kf39hrb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Jan 2021 09:41:52 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 10B9fpsj031385;
        Mon, 11 Jan 2021 09:41:51 GMT
Received: from localhost.localdomain (/39.109.186.25)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 11 Jan 2021 01:41:50 -0800
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.com, josef@toxicpanda.com,
        Anand Jain <anand.jain@oracle.com>
Subject: [PATCH v3 1/4] btrfs: add read_policy latency
Date:   Mon, 11 Jan 2021 17:41:34 +0800
Message-Id: <64bb4905dc4b77e9fa22d8ba2635a36d15a33469.1610324448.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <cover.1610324448.git.anand.jain@oracle.com>
References: <cover.1610324448.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9860 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 mlxlogscore=999 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101110057
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9860 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 malwarescore=0
 clxscore=1015 impostorscore=0 spamscore=0 mlxscore=0 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101110057
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
---
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

v1: Drop part_stat_read_all instead use part_stat_read
    Drop inflight


 fs/btrfs/sysfs.c   |  3 ++-
 fs/btrfs/volumes.c | 38 ++++++++++++++++++++++++++++++++++++++
 fs/btrfs/volumes.h |  2 ++
 3 files changed, 42 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index 19b9fffa2c9c..96ca7bef6357 100644
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
index f4037a6bd926..f7a0a83d2cd4 100644
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
+			btrfs_debug_rl(device->fs_devices->fs_info,
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
2.30.0

