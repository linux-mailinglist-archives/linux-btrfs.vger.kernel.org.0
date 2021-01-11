Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65F052F0F52
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Jan 2021 10:43:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728424AbhAKJmp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 11 Jan 2021 04:42:45 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:59916 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727915AbhAKJmo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 11 Jan 2021 04:42:44 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10B9XegS004674;
        Mon, 11 Jan 2021 09:42:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=jQL3jLomD27sn8CqUTq45lKemDjkd6GCO1FCpN8wvVw=;
 b=BEfoX2LIEetPjhIlx8B+0mq25mogtMcBqWhJi31zLkqIiNLmhggjcfjxnK9SoxCvYzEB
 hgEMRtpd12OqEae8/eMqCox6wkd5reV7CW1kYmUaCgwI7dUyH6dbifvN17QGXl8vIkiZ
 qN5VDv47iZWrECRfV5GyY19nYA7LnyotPTWekht18bSgACxcjsQYBVp0YXoMTYlmYu+p
 SqvxyqetvbBmo/17crC1xjvF4JE8bdYVHeaUD6FACVAlIv6B7QCRpdzCCmmHPAJ5AoQ3
 WuqMtoDser0YncRDS72w5O9XLXGtbPeOMbgtI4DI0G/x3/o5FFKIPyNbBV/jTyJEM597 vw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 360kcyg9au-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 11 Jan 2021 09:42:00 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10B9UNFw173421;
        Mon, 11 Jan 2021 09:41:59 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 360keet2hv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Jan 2021 09:41:59 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 10B9fwXh010899;
        Mon, 11 Jan 2021 09:41:58 GMT
Received: from localhost.localdomain (/39.109.186.25)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 11 Jan 2021 01:41:58 -0800
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.com, josef@toxicpanda.com,
        Anand Jain <anand.jain@oracle.com>
Subject: [PATCH RFC 4/4] btrfs: introduce new read_policy round-robin
Date:   Mon, 11 Jan 2021 17:41:37 +0800
Message-Id: <8e0afaa33f33d1a5efbf37fa4465954056ce3f59.1610324448.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <cover.1610324448.git.anand.jain@oracle.com>
References: <cover.1610324448.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9860 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 spamscore=0
 malwarescore=0 suspectscore=0 mlxlogscore=999 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101110057
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9860 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0
 impostorscore=0 bulkscore=0 adultscore=0 suspectscore=0 malwarescore=0
 lowpriorityscore=0 clxscore=1015 mlxlogscore=999 mlxscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101110057
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Add round-robin read policy to route the read IO to the next device in the
round-robin order. The chunk allocation and thus the stripe-index follows
the order of free space available on devices. So to make the round-robin
effective it shall follow the devid order instead of the stripe-index
order.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
--
RFC because: Provides terrible performance with the fio tests.
I am not yet sure if there is any io workload or a block layer
tuning that shall make this policy better. As of now just an
experimental patch.

 fs/btrfs/sysfs.c   |  2 +-
 fs/btrfs/volumes.c | 50 ++++++++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/volumes.h |  3 +++
 3 files changed, 54 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index 899b66c83db1..d40b0ff054ca 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -917,7 +917,7 @@ static bool strmatch(const char *buffer, const char *string)
 
 /* Must follow the order as in enum btrfs_read_policy */
 static const char * const btrfs_read_policy_name[] = { "pid", "latency",
-						       "device" };
+						       "device", "roundrobin" };
 
 static ssize_t btrfs_read_policy_show(struct kobject *kobj,
 				      struct kobj_attribute *a, char *buf)
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 50d4d54f7abd..60370b9121e0 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -5491,6 +5491,52 @@ int btrfs_is_parity_mirror(struct btrfs_fs_info *fs_info, u64 logical, u64 len)
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
@@ -5579,6 +5625,10 @@ static int find_live_mirror(struct btrfs_fs_info *fs_info,
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
index 8d5a2cddc0ab..ce4490437f53 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -227,6 +227,8 @@ enum btrfs_read_policy {
 	BTRFS_READ_POLICY_LATENCY,
 	/* Use the device marked with READ_PREFERRED state */
 	BTRFS_READ_POLICY_DEVICE,
+	/* Distribute read IO equally across striped devices */
+	BTRFS_READ_POLICY_ROUND_ROBIN,
 	BTRFS_NR_READ_POLICY,
 };
 
@@ -286,6 +288,7 @@ struct btrfs_fs_devices {
 
 	/* Policy used to read the mirrored stripes */
 	enum btrfs_read_policy read_policy;
+	atomic_t total_reads;
 };
 
 #define BTRFS_BIO_INLINE_CSUM_SIZE	64
-- 
2.30.0

