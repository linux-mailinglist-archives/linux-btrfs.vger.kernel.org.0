Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A4B6299D14
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Oct 2020 01:04:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2411018AbgJZX4A (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 26 Oct 2020 19:56:00 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:57226 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2410907AbgJZXza (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 26 Oct 2020 19:55:30 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09QNnATw029303
        for <linux-btrfs@vger.kernel.org>; Mon, 26 Oct 2020 23:55:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=eG+oqWyzMsfQ4bgr90MTUGJ5/QZAYB5EEQL0CAGfpOI=;
 b=E7LgM97YtpoHniPzK5lw3hYRzEkhfoWv17v9sLblaWv3F1Z8+/4V2Luleov5K7vIrHrt
 OqvUkvD9I/K178MYG+TQjyot78bOEbQFusv3wQR/yR033KJKRJSWZTGyn8Huqj475LiB
 iS+yfYmc9YJ35M4w2TpRRlGefJn+O9UKJN978KRAOUkWGPU2nIh8Jc/p8ChxYTMloZ1X
 hNmtaYiP+mspbwrsHIIbv4K6rn2d2QEqyXRRHpg53ODLbSQJRfAYdpysuXhem2ND5mJS
 SRHqD0Le6jTPPz+gmtx4niUleicy2VGrJ/04rY6xmMidza9/5MstSPNJabLw1ak6KBOI sQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2130.oracle.com with ESMTP id 34c9saqe85-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
        for <linux-btrfs@vger.kernel.org>; Mon, 26 Oct 2020 23:55:28 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09QNnxOi157934
        for <linux-btrfs@vger.kernel.org>; Mon, 26 Oct 2020 23:55:28 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 34cx5wg4aj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Mon, 26 Oct 2020 23:55:28 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 09QNtSUx017539
        for <linux-btrfs@vger.kernel.org>; Mon, 26 Oct 2020 23:55:28 GMT
Received: from localhost.localdomain (/39.109.231.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 26 Oct 2020 16:55:27 -0700
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH RFC 4/7] btrfs: trace, add event btrfs_read_policy
Date:   Tue, 27 Oct 2020 07:55:07 +0800
Message-Id: <e6e5c40113cd3e939441ab3ece823282049a596f.1603751876.git.anand.jain@oracle.com>
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
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 malwarescore=0 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 spamscore=0 phishscore=0 clxscore=1015 suspectscore=1
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010260155
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This patch adds trace event btrfs_read_policy, which is common to all the
read policies.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 fs/btrfs/volumes.c           | 28 ++++++++++++++++++++++++++--
 include/trace/events/btrfs.h | 20 ++++++++++++++++++++
 2 files changed, 46 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 9bab6080cebf..b51e690b3b18 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -5494,9 +5494,10 @@ static u64 btrfs_estimate_read(struct btrfs_device *device,
 
 static int btrfs_find_best_stripe(struct btrfs_fs_info *fs_info,
 				  struct map_lookup *map, int first,
-				  int num_stripe)
+				  int num_stripe, char *log, int logsz)
 {
 	int index;
+	int lognr;
 	int best_stripe = 0;
 	int est_wait = -EINVAL;
 	int last = first + num_stripe;
@@ -5509,6 +5510,8 @@ static int btrfs_find_best_stripe(struct btrfs_fs_info *fs_info,
 			return -ENOENT;
 	}
 
+	lognr = scnprintf(log, logsz, ": first %d num_stripe %d [",
+			  first, num_stripe);
 	for (index = first; index < last; index++) {
 		struct btrfs_device *device = map->stripes[index].dev;
 		u64 avg_wait;
@@ -5517,11 +5520,19 @@ static int btrfs_find_best_stripe(struct btrfs_fs_info *fs_info,
 		avg_wait = btrfs_estimate_read(device, &inflight);
 		final_wait = avg_wait + (avg_wait * (inflight / 10));
 
+		lognr = lognr + scnprintf(log + lognr, logsz - lognr,
+		 " stripe %d devid %llu wait %llu inflight %lu final %llu,",
+					  index, device->devid, avg_wait,
+					  inflight, final_wait);
+
 		if (est_wait == 0 || est_wait > final_wait) {
 			est_wait = final_wait;
 			best_stripe = index;
 		}
 	}
+	lognr = lognr + scnprintf(log + lognr, logsz - lognr,
+				  "] best_stripe %d devid %llu", best_stripe,
+				  map->stripes[best_stripe].dev->devid);
 
 	return best_stripe;
 }
@@ -5535,6 +5546,8 @@ static int find_live_mirror(struct btrfs_fs_info *fs_info,
 	int preferred_mirror;
 	int tolerance;
 	struct btrfs_device *srcdev;
+	int logsz = 400;
+	char log[400] = {0};
 
 	ASSERT((map->type &
 		 (BTRFS_BLOCK_GROUP_RAID1_MASK | BTRFS_BLOCK_GROUP_RAID10)));
@@ -5557,7 +5570,8 @@ static int find_live_mirror(struct btrfs_fs_info *fs_info,
 		break;
 	case BTRFS_READ_POLICY_LATENCY:
 		preferred_mirror = btrfs_find_best_stripe(fs_info, map, first,
-							  num_stripes);
+							  num_stripes, log,
+							  logsz);
 		if (preferred_mirror >= 0)
 			break;
 
@@ -5567,9 +5581,19 @@ static int find_live_mirror(struct btrfs_fs_info *fs_info,
 		fallthrough;
 	case BTRFS_READ_POLICY_PID:
 		preferred_mirror = first + current->pid % num_stripes;
+		scnprintf(log, logsz,
+			  "first %d num_stripe %d %s (%d) preferred %d",
+			  first, num_stripes, current->comm, task_pid_nr(current),
+			  preferred_mirror);
 		break;
 	}
 
+	/*
+	 * we could enhance tracing to trace other policies as well, so please
+	 * keep this in the parent function.
+	 */
+	trace_btrfs_read_policy(fs_info, log);
+
 	if (dev_replace_is_ongoing &&
 	    fs_info->dev_replace.cont_reading_from_srcdev_mode ==
 	     BTRFS_DEV_REPLACE_ITEM_CONT_READING_FROM_SRCDEV_MODE_AVOID)
diff --git a/include/trace/events/btrfs.h b/include/trace/events/btrfs.h
index ecd24c719de4..8df7e7d0b336 100644
--- a/include/trace/events/btrfs.h
+++ b/include/trace/events/btrfs.h
@@ -2148,6 +2148,26 @@ DEFINE_EVENT(btrfs__space_info_update, update_bytes_pinned,
 	TP_ARGS(fs_info, sinfo, old, diff)
 );
 
+TRACE_EVENT(btrfs_read_policy,
+
+	TP_PROTO(const struct btrfs_fs_info *fs_info, const char *log),
+
+	TP_ARGS(fs_info, log),
+
+	TP_STRUCT__entry_btrfs(
+		__string(	log,	log		)
+		__field(	int,	read_policy	)
+	),
+
+	TP_fast_assign_btrfs(fs_info,
+		__assign_str(log, log);
+		__entry->read_policy	= fs_info->fs_devices->read_policy;
+	),
+
+	TP_printk_btrfs("read_policy %d %s",
+			__entry->read_policy, __get_str(log))
+);
+
 #endif /* _TRACE_BTRFS_H */
 
 /* This part must be outside protection */
-- 
2.25.1

