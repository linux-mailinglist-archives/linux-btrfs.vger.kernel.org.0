Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D94D729E54B
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Oct 2020 08:56:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732276AbgJ2Hz6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 29 Oct 2020 03:55:58 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:53130 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731522AbgJ2Hya (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 29 Oct 2020 03:54:30 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09T7n7B3143752;
        Thu, 29 Oct 2020 07:54:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=O/qYn77Uzq6fpd0ZAVhARJ26iB2BpR8UgZlBv2/Ug/Y=;
 b=q/9a0w334DYjrADZn+PakuEfX9hbOsPwfwJrNkV08WxisGMWTAZUWG9wHjSfGwsAX71S
 fisu1Tn1R6s9TedlrOBsuBvKwOTR3ilgTZKH+2nOROymLSpdkQkUT183lWmlDTkBZfqD
 +KbNPy2zpjwkiDp5gLpoTH/6zvUPTN2roWq3Yzqbt8I2vqp5hhN7Q1PY/bUWg3nXzyAt
 A2AAuNblHdFHqkAKBlnzu4JMKfL1bfbeWwsBUYnsfz5CLd3L9embNqbAOGknXmytm18D
 bblGyQNoQHOFa90Qe42wYivR49WkdIAYsT7/cLBVYrRtcbwQgEV16TI1/8qndMHhgn3G Ew== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 34cc7m38k8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 29 Oct 2020 07:54:26 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09T7oOYD175494;
        Thu, 29 Oct 2020 07:54:25 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 34cx1sx006-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 Oct 2020 07:54:25 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 09T7sOKc006280;
        Thu, 29 Oct 2020 07:54:24 GMT
Received: from localhost.localdomain (/39.109.231.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 29 Oct 2020 00:54:24 -0700
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.com, josef@toxicpanda.com
Subject: [PATCH v2 1/4] btrfs: add read_policy latency
Date:   Thu, 29 Oct 2020 15:54:08 +0800
Message-Id: <df71f31c04177b7f5977944b0f1adcecca13391b.1603950490.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1603938304.git.anand.jain@oracle.com>
References: <cover.1603938304.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9788 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 bulkscore=0
 suspectscore=1 malwarescore=0 mlxlogscore=999 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010290056
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9788 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 adultscore=0
 malwarescore=0 spamscore=0 clxscore=1015 mlxscore=0 suspectscore=1
 priorityscore=1501 impostorscore=0 bulkscore=0 phishscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010290055
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The read policy type latency routes the read IO based on the historical
average wait time experienced by the read IOs through the individual
device. This patch obtains the historical read IO stats from the kernel
block layer.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
v2: Use btrfs_debug_rl() instead of btrfs_info_rl()
    It is better we have this debug until we test this on at least few
    hardwares.
    Drop the unrelated changes.
    Update change log.

v1: Drop part_stat_read_all instead use part_stat_read
    Drop inflight
    
 fs/btrfs/sysfs.c   |  3 ++-
 fs/btrfs/volumes.c | 38 ++++++++++++++++++++++++++++++++++++++
 fs/btrfs/volumes.h |  1 +
 3 files changed, 41 insertions(+), 1 deletion(-)

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
index 6bf487626f23..bce83740ddc6 100644
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

