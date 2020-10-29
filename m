Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6025B29E540
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Oct 2020 08:55:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731553AbgJ2Hzs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 29 Oct 2020 03:55:48 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:44774 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731551AbgJ2Hyg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 29 Oct 2020 03:54:36 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09T7oDpR192270;
        Thu, 29 Oct 2020 07:54:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=s/dcFoT00KptmYmAvxHx0Ba3TyTSfPcDvd8PwztMLlM=;
 b=WHy8OxVi/2udNuiV+ZAvxR/xYTW6CCNXsWt6Mqfoof6wg3+JburRnHTasapsnEObZ5/n
 3qrR+2ZVCHRbu3lkwFVbVuv2MEnvSe4KTQxb4SPiHiEEOgj9SeEjGDi8s4CbPvdsZlru
 8pafBtstvG4Tb4USTTQHxE3Eqc29JGXTSGqt/tyzYes9LrTKsC4YaAAfR7JST37vJz6v
 ec9IJc2LG3RS7ZPsjFLjiZq8RKuyHosYlhyvi2cNQ94PSi9pNYerFx3SwT7BTzlJ2Z9s
 23w9s7Uf1Rnv5pR0/pQPqKk/e0baNHUeBU205+vh5qF5bsMyxFx0jZG0X8qhkG3WD2Rh OQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2130.oracle.com with ESMTP id 34c9sb3dpg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 29 Oct 2020 07:54:31 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09T7oVv3168459;
        Thu, 29 Oct 2020 07:54:31 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 34cwupgbue-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 Oct 2020 07:54:31 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 09T7sU95015159;
        Thu, 29 Oct 2020 07:54:30 GMT
Received: from localhost.localdomain (/39.109.231.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 29 Oct 2020 00:54:30 -0700
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.com, josef@toxicpanda.com
Subject: [PATCH RFC 4/4] btrfs: introduce new read_policy round-robin
Date:   Thu, 29 Oct 2020 15:54:11 +0800
Message-Id: <75edb0725a4c037b63037f15e0765af261171fe9.1603938305.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1603938304.git.anand.jain@oracle.com>
References: <cover.1603938304.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9788 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 bulkscore=0
 spamscore=0 adultscore=0 malwarescore=0 mlxlogscore=999 suspectscore=3
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010290056
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9788 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 malwarescore=0 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 spamscore=0 phishscore=0 clxscore=1015 suspectscore=3
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010290055
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Add round-robin read policy to route the read IO to the next device in the
round-robin order. The chunk allocation and thus the stripe-index follows
the order of free space available on devices. So to make the round-robin
effective it shall follow the devid order instead of the stripe-index
order.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
RFC because: I am not sure if any workload or any block layer configurations
that shall suit round-robin read_policy. So that round-robin performs better.

 fs/btrfs/sysfs.c   |  2 +-
 fs/btrfs/volumes.c | 50 ++++++++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/volumes.h |  2 ++
 3 files changed, 53 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index 11de4948b512..02634d9d38c5 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -908,7 +908,7 @@ static bool btrfs_strmatch(const char *given, const char *golden)
 
 /* Must follow the order as in enum btrfs_read_policy */
 static const char * const btrfs_read_policy_name[] = { "pid", "latency",
-						       "device" };
+						       "device", "roundrobin" };
 
 static ssize_t btrfs_read_policy_show(struct kobject *kobj,
 				      struct kobj_attribute *a, char *buf)
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 0cb7789a3199..7d25be8ff254 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -5469,6 +5469,52 @@ int btrfs_is_parity_mirror(struct btrfs_fs_info *fs_info, u64 logical, u64 len)
 	return ret;
 }
 
+struct stripe_mirror {
+	u64 devid;
+	int map;
+};
+
+static int btrfs_cmp_devid(const void *a, const void *b)
+{
+	struct stripe_mirror *s1 = (struct stripe_mirror *)a;
+	struct stripe_mirror *s2 = (struct stripe_mirror *)b;
+
+	if (s1->devid < s2->devid)
+		return -1;
+	if (s1->devid > s2->devid)
+		return 1;
+	return 0;
+}
+
+static int btrfs_find_read_round_robin(struct map_lookup *map, int first,
+				       int num_stripe)
+{
+	struct stripe_mirror stripes[4] = {0}; //4: for testing, works for now.
+	struct btrfs_fs_devices *fs_devices;
+	u64 devid;
+	int index, j, cnt;
+	int next_stripe;
+
+	index = 0;
+	for (j = first; j < first + num_stripe; j++) {
+		devid = map->stripes[j].dev->devid;
+
+		stripes[index].devid = devid;
+		stripes[index].map = j;
+
+		index++;
+	}
+
+	sort(stripes, num_stripe, sizeof(struct stripe_mirror),
+	     btrfs_cmp_devid, NULL);
+
+	fs_devices = map->stripes[first].dev->fs_devices;
+	cnt = atomic_inc_return(&fs_devices->total_reads);
+	next_stripe = stripes[cnt % num_stripe].map;
+
+	return next_stripe;
+}
+
 static int btrfs_find_best_stripe(struct btrfs_fs_info *fs_info,
 				  struct map_lookup *map, int first,
 				  int num_stripe)
@@ -5558,6 +5604,10 @@ static int find_live_mirror(struct btrfs_fs_info *fs_info,
 	case BTRFS_READ_POLICY_DEVICE:
 		preferred_mirror = btrfs_find_read_preferred(map, first, num_stripes);
 		break;
+	case BTRFS_READ_POLICY_ROUND_ROBIN:
+		preferred_mirror = btrfs_find_read_round_robin(map, first,
+							       num_stripes);
+		break;
 	}
 
 	if (dev_replace_is_ongoing &&
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index 1448adb8993d..fc00f9c7f1ab 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -220,6 +220,7 @@ enum btrfs_read_policy {
 	BTRFS_READ_POLICY_PID,
 	BTRFS_READ_POLICY_LATENCY,
 	BTRFS_READ_POLICY_DEVICE,
+	BTRFS_READ_POLICY_ROUND_ROBIN,
 	BTRFS_NR_READ_POLICY,
 };
 
@@ -281,6 +282,7 @@ struct btrfs_fs_devices {
 	 * policy used to read the mirrored stripes
 	 */
 	enum btrfs_read_policy read_policy;
+	atomic_t total_reads;
 };
 
 #define BTRFS_BIO_INLINE_CSUM_SIZE	64
-- 
2.25.1

