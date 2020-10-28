Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E36CA29E308
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Oct 2020 03:46:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726583AbgJ2Coj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 28 Oct 2020 22:44:39 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:35108 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726482AbgJ1VeT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 28 Oct 2020 17:34:19 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09SDJFIU066564;
        Wed, 28 Oct 2020 13:26:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=JhGGSrLlM9dDv9kWlGdlBRvRFf4sQdUyVxB6oKRBZyY=;
 b=Y0W2jzi63gIk7P3WJSbLURBRjXOVSLmHC6vj28QguVH4it3SzsNZ+++dtXxulCpCrwbU
 wogfcosZrCVlEf3ydZKGmcqD/cfXXEs/p/FUBA5AuK2YOWHLlNlfWeB5g5AhsWRXyD8p
 HhQccOfEZ+Uh3e001O9cl1C/xaaPCsEYovKKXXlhTV2A15OOyqDHzdABa8VoNC73nNEx
 FB1dpsDuvIljFLqllShtMXjhfN55XaZcUogxzF/ZwyPgnLGQnSF8IDrafzeOgtcT66Om
 Zkf0Umax67fdEV7Ohn939x0oFDgSap+1qhABMNqo8LIFIn84BWVRlfXP7jWpWLWW6rl0 2g== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2130.oracle.com with ESMTP id 34c9sayh4a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 28 Oct 2020 13:26:27 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09SDPMiA031105;
        Wed, 28 Oct 2020 13:26:27 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 34cx6x7t1w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Oct 2020 13:26:27 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 09SDQQ6R011667;
        Wed, 28 Oct 2020 13:26:26 GMT
Received: from localhost.localdomain (/39.109.231.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 28 Oct 2020 06:26:25 -0700
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.com, josef@toxicpanda.com
Subject: [PATCH 1/4] btrfs: add read_policy latency
Date:   Wed, 28 Oct 2020 21:26:00 +0800
Message-Id: <ae5e526c1549d4e6f602c09d8235aa406c5a1404.1603884539.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1603884539.git.anand.jain@oracle.com>
References: <cover.1603884539.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9787 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 spamscore=0
 bulkscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0 suspectscore=1
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010280091
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9787 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 malwarescore=0 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 spamscore=0 phishscore=0 clxscore=1015 suspectscore=1
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010280090
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The read policy type latency routes the read IO based on the historical
average wait time experienced by the read IOs through the individual
device factored by 1/10 of inflight commands in the queue. The factor
1/10 is because generally the block device queue depth is more than 1,
so there can be commands in the queue even before the previous commands
have been completed. This patch obtains the historical read IO stats from
the kernel block layer.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
v1: Drop part_stat_read_all instead use part_stat_read
    Drop inflight
    
 fs/btrfs/sysfs.c   |  3 ++-
 fs/btrfs/volumes.c | 39 ++++++++++++++++++++++++++++++++++++++-
 fs/btrfs/volumes.h |  1 +
 3 files changed, 41 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index 4dbf90ff088a..88cbf7b2edf0 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -906,7 +906,8 @@ static bool btrfs_strmatch(const char *given, const char *golden)
 	return false;
 }
 
-static const char * const btrfs_read_policy_name[] = { "pid" };
+/* Must follow the order as in enum btrfs_read_policy */
+static const char * const btrfs_read_policy_name[] = { "pid", "latency" };
 
 static ssize_t btrfs_read_policy_show(struct kobject *kobj,
 				      struct kobj_attribute *a, char *buf)
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 6bf487626f23..48587009b656 100644
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
@@ -5468,6 +5469,39 @@ int btrfs_is_parity_mirror(struct btrfs_fs_info *fs_info, u64 logical, u64 len)
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
+		read_wait = part_stat_read(device->bdev->bd_part, nsecs[READ]);
+		read_ios = part_stat_read(device->bdev->bd_part, ios[READ]);
+
+		if (read_wait && read_ios && read_wait >= read_ios)
+			avg_wait = div_u64(read_wait, read_ios);
+		else
+			btrfs_info_rl(device->fs_devices->fs_info,
+			"devid: %llu avg_wait ZERO read_wait %llu read_ios %lu",
+				      device->devid, read_wait, read_ios);
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
@@ -5498,6 +5532,10 @@ static int find_live_mirror(struct btrfs_fs_info *fs_info,
 	case BTRFS_READ_POLICY_PID:
 		preferred_mirror = first + current->pid % num_stripes;
 		break;
+	case BTRFS_READ_POLICY_LATENCY:
+		preferred_mirror = btrfs_find_best_stripe(fs_info, map, first,
+							  num_stripes);
+		break;
 	}
 
 	if (dev_replace_is_ongoing &&
@@ -6114,7 +6152,6 @@ static int __btrfs_map_block(struct btrfs_fs_info *fs_info,
 
 	} else if (map->type & BTRFS_BLOCK_GROUP_RAID10) {
 		u32 factor = map->num_stripes / map->sub_stripes;
-
 		stripe_nr = div_u64_rem(stripe_nr, factor, &stripe_index);
 		stripe_index *= map->sub_stripes;
 
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index 97f075516696..24db586a9837 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -217,6 +217,7 @@ enum btrfs_chunk_allocation_policy {
  */
 enum btrfs_read_policy {
 	BTRFS_READ_POLICY_PID,
+	BTRFS_READ_POLICY_LATENCY,
 	BTRFS_NR_READ_POLICY,
 };
 
-- 
2.25.1

