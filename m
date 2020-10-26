Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 406F3299C79
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Oct 2020 00:59:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436801AbgJZX5a (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 26 Oct 2020 19:57:30 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:50402 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436787AbgJZX53 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 26 Oct 2020 19:57:29 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09QNn1ke007434
        for <linux-btrfs@vger.kernel.org>; Mon, 26 Oct 2020 23:57:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=AZfR4bDNIoc8Grp7j/kSGep43cPqzxm/4VkinxYz9JE=;
 b=ZrFu47g7Vyew+RFW3ye5HPZGtKav7Q6ovBNb0ie7W870G5S+eXSIbm4rmQ6lhWfqqsG9
 +yS5KsWScdCkup46ICsIyrOknmAEozGJElkFwWDAk6xHTU92x/dghNAcAjTqX1Rrl7X+
 hSScASkWgzG9nsmoBf0PjZXROJmHlQs6f6sklMBC56FkNKjGqZIVpZfQsC9y+q56OhtM
 BZ/rz3dkP2r48JnWh99ufpixP6JtWOxVeTojNu/pDTS0QgnsnPs1cuMvfoh1cWnwhtR8
 xIHuUB/HCf6p9EGzTI5OqIkV82/mRqVvkSEVJZuF4f3H0rRioUqdmzdEVKy3qY0sriDA ag== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 34cc7kq9p6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
        for <linux-btrfs@vger.kernel.org>; Mon, 26 Oct 2020 23:57:28 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09QNnxar157990
        for <linux-btrfs@vger.kernel.org>; Mon, 26 Oct 2020 23:55:27 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 34cx5wg4a9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Mon, 26 Oct 2020 23:55:27 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 09QNtQNt003411
        for <linux-btrfs@vger.kernel.org>; Mon, 26 Oct 2020 23:55:26 GMT
Received: from localhost.localdomain (/39.109.231.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 26 Oct 2020 16:55:26 -0700
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH RFC 3/7] btrfs: add read_policy latency
Date:   Tue, 27 Oct 2020 07:55:06 +0800
Message-Id: <de0a28ed406c84c84d40d4bdad5f45250aabfdea.1603751876.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1603751876.git.anand.jain@oracle.com>
References: <cover.1603751876.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9786 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 mlxlogscore=999
 suspectscore=1 bulkscore=0 malwarescore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010260155
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9786 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 adultscore=0
 malwarescore=0 spamscore=0 clxscore=1015 mlxscore=0 suspectscore=1
 priorityscore=1501 impostorscore=0 bulkscore=0 phishscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010260155
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
 fs/btrfs/sysfs.c   |  3 +-
 fs/btrfs/volumes.c | 74 +++++++++++++++++++++++++++++++++++++++++++++-
 fs/btrfs/volumes.h |  1 +
 3 files changed, 76 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index d159f7c70bcd..6690abeeb889 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -874,7 +874,8 @@ static int btrfs_strmatch(const char *given, const char *golden)
 	return -EINVAL;
 }
 
-static const char * const btrfs_read_policy_name[] = { "pid" };
+/* Must follow the order as in enum btrfs_read_policy */
+static const char * const btrfs_read_policy_name[] = { "pid", "latency"};
 
 static ssize_t btrfs_read_policy_show(struct kobject *kobj,
 				      struct kobj_attribute *a, char *buf)
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index da31b11ceb61..9bab6080cebf 100644
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
@@ -5465,6 +5466,66 @@ int btrfs_is_parity_mirror(struct btrfs_fs_info *fs_info, u64 logical, u64 len)
 	return ret;
 }
 
+static u64 btrfs_estimate_read(struct btrfs_device *device,
+			       unsigned long *inflight)
+{
+	u64 read_wait;
+	u64 avg_wait = 0;
+	unsigned long read_ios;
+	struct disk_stats stat;
+
+	/* Commands in flight on this partition/device */
+	*inflight = part_stat_read_inflight(bdev_get_queue(device->bdev),
+					    device->bdev->bd_part);
+	part_stat_read_all(device->bdev->bd_part, &stat);
+
+	read_wait = stat.nsecs[STAT_READ];
+	read_ios = stat.ios[STAT_READ];
+
+	if (read_wait && read_ios && read_wait >= read_ios)
+		avg_wait = div_u64(read_wait, read_ios);
+	else
+		btrfs_info_rl(device->fs_devices->fs_info,
+			"devid: %llu avg_wait ZERO read_wait %llu read_ios %lu",
+			      device->devid, read_wait, read_ios);
+
+	return avg_wait;
+}
+
+static int btrfs_find_best_stripe(struct btrfs_fs_info *fs_info,
+				  struct map_lookup *map, int first,
+				  int num_stripe)
+{
+	int index;
+	int best_stripe = 0;
+	int est_wait = -EINVAL;
+	int last = first + num_stripe;
+	unsigned long inflight;
+
+	for (index = first; index < last; index++) {
+		struct btrfs_device *device = map->stripes[index].dev;
+
+		if (!blk_queue_io_stat(bdev_get_queue(device->bdev)))
+			return -ENOENT;
+	}
+
+	for (index = first; index < last; index++) {
+		struct btrfs_device *device = map->stripes[index].dev;
+		u64 avg_wait;
+		u64 final_wait;
+
+		avg_wait = btrfs_estimate_read(device, &inflight);
+		final_wait = avg_wait + (avg_wait * (inflight / 10));
+
+		if (est_wait == 0 || est_wait > final_wait) {
+			est_wait = final_wait;
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
@@ -5491,6 +5552,18 @@ static int find_live_mirror(struct btrfs_fs_info *fs_info,
 		btrfs_warn_rl(fs_info,
 			      "unknown read_policy type %u, fallback to pid",
 			      fs_info->fs_devices->read_policy);
+		fs_info->fs_devices->read_policy = BTRFS_READ_POLICY_PID;
+		preferred_mirror = first + current->pid % num_stripes;
+		break;
+	case BTRFS_READ_POLICY_LATENCY:
+		preferred_mirror = btrfs_find_best_stripe(fs_info, map, first,
+							  num_stripes);
+		if (preferred_mirror >= 0)
+			break;
+
+		btrfs_warn(fs_info,
+   "iostat is disabled, cannot set latency read_policy, fallback to pid");
+		fs_info->fs_devices->read_policy = BTRFS_READ_POLICY_PID;
 		fallthrough;
 	case BTRFS_READ_POLICY_PID:
 		preferred_mirror = first + current->pid % num_stripes;
@@ -6111,7 +6184,6 @@ static int __btrfs_map_block(struct btrfs_fs_info *fs_info,
 
 	} else if (map->type & BTRFS_BLOCK_GROUP_RAID10) {
 		u32 factor = map->num_stripes / map->sub_stripes;
-
 		stripe_nr = div_u64_rem(stripe_nr, factor, &stripe_index);
 		stripe_index *= map->sub_stripes;
 
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index e3c36951742d..8705d755d148 100644
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

