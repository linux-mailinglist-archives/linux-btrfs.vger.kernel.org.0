Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FEAE29D683
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Oct 2020 23:15:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731304AbgJ1WPS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 28 Oct 2020 18:15:18 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:60698 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731169AbgJ1WPD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 28 Oct 2020 18:15:03 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09SDSX8D092876;
        Wed, 28 Oct 2020 13:28:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=Hr+femSI2Zm5czL5JqkLRNSC8d/yU5iN2RzmjIF9Yzs=;
 b=HkrFWOPpKXbPu0QGt+Ai9Q2dL/1Xe3rbQ5MBbkgL0jXaqaVghvgv/5psu4xaN1hkyCOh
 fh9UeDvocojb0ipCone/gOQT9ux/SlXgSAsLobFeo704LEFm2rt56RPJZn2JbgixZUqG
 kTL/qBkUmavz7faVtpAdgT8LscIFr8Y5miTEoGHpMPz3ezkxqByF42lNZoG2QGHN/sNG
 8WheBHEMYVH4rJBehNYIo++sPSw5mVj9GyYNoYdQRomqftNARzpV5BWfJB9QyhQDwRca
 HyJD26lWOEknBmJ/jfvZpcuUniavs7lJq0uNxPF42+st3G458ugeL7XXZ4kS28179G+w fg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 34dgm450f2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 28 Oct 2020 13:28:34 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09SDQSZ4040361;
        Wed, 28 Oct 2020 13:26:34 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 34cwunkder-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Oct 2020 13:26:34 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 09SDQWrN011721;
        Wed, 28 Oct 2020 13:26:33 GMT
Received: from localhost.localdomain (/39.109.231.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 28 Oct 2020 06:26:32 -0700
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.com, josef@toxicpanda.com
Subject: [PATCH RFC 4/4] btrfs: introduce new read_policy round-robin
Date:   Wed, 28 Oct 2020 21:26:03 +0800
Message-Id: <3ef863dea2d61ab41e5767ee935d5411c3117fa0.1603884539.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1603884539.git.anand.jain@oracle.com>
References: <cover.1603884539.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9787 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 bulkscore=0
 spamscore=0 adultscore=0 malwarescore=0 mlxlogscore=999 suspectscore=3
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010280091
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9787 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 impostorscore=0
 adultscore=0 bulkscore=0 spamscore=0 phishscore=0 mlxlogscore=999
 suspectscore=3 clxscore=1015 mlxscore=0 malwarescore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010280091
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
RFC: because I am not too sure if any workload or block layer
configurations shall suit round-robin read_policy.

 fs/btrfs/sysfs.c   |  2 +-
 fs/btrfs/volumes.c | 50 ++++++++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/volumes.h |  2 ++
 3 files changed, 53 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index d2a974e1a1c4..293311c79321 100644
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
index 7ac675504051..fa1b1a3ebc87 100644
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

