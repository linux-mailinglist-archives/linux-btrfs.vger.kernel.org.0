Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CE2C299F86
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Oct 2020 01:23:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441373AbgJ0AXA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 26 Oct 2020 20:23:00 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:57290 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2410919AbgJZXzg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 26 Oct 2020 19:55:36 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09QNo3bf029885
        for <linux-btrfs@vger.kernel.org>; Mon, 26 Oct 2020 23:55:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=f9Xfc9DZZs+03wwRc745fik3dsA846wz/Vp6q+dlFPg=;
 b=zgpnUoqqCX/1zPsy021Id62BRfGy+2+GIsGyQt7iYZ3tlbZBRSTtjrhLxe2x/izB9vnW
 TWEh6/GYk8v3pXhlrG/84Pfm3u7YOWju7JV2Pr6B48V8RTPp4tmUjKDaEnA0jpgVicqZ
 fJBI3/dAobd+FhZhVoeS2wgpHDRhK+CvYr8p+IMj0uN8fJnqgxV0iLB9HZq6rO4zAe21
 2FgFHInyVpR7V/Tt8T9DlMgx27byuecYICcLcbwaRWJYe8ktBDIClZf+UF19EMu/JOA+
 biaFPa+27QDHbuUoBba4r667lauFheAlbycFJtN2iNWimXKJxp8bhnjlb1Y2N1ftIeYR qA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2130.oracle.com with ESMTP id 34c9saqe8c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
        for <linux-btrfs@vger.kernel.org>; Mon, 26 Oct 2020 23:55:34 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09QNpKM1172333
        for <linux-btrfs@vger.kernel.org>; Mon, 26 Oct 2020 23:55:34 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 34cx6vagv4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Mon, 26 Oct 2020 23:55:33 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 09QNtX0b016050
        for <linux-btrfs@vger.kernel.org>; Mon, 26 Oct 2020 23:55:33 GMT
Received: from localhost.localdomain (/39.109.231.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 26 Oct 2020 16:55:32 -0700
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH RFC 7/7] btrfs: introduce new read_policy round-robin
Date:   Tue, 27 Oct 2020 07:55:10 +0800
Message-Id: <4c4dd72374fdd51674cd1c909fe48fb6f3853d71.1603751876.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1603751876.git.anand.jain@oracle.com>
References: <cover.1603751876.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9786 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 spamscore=0
 bulkscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0 suspectscore=3
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010260155
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9786 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 malwarescore=0 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 spamscore=0 phishscore=0 clxscore=1015 suspectscore=3
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010260155
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
 fs/btrfs/sysfs.c   |  2 +-
 fs/btrfs/volumes.c | 68 ++++++++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/volumes.h |  2 ++
 3 files changed, 71 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index 677070bab1e0..45efc9755336 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -876,7 +876,7 @@ static int btrfs_strmatch(const char *given, const char *golden)
 
 /* Must follow the order as in enum btrfs_read_policy */
 static const char * const btrfs_read_policy_name[] = { "pid", "latency",
-						       "device" };
+						       "device", "roundrobin" };
 
 static ssize_t btrfs_read_policy_show(struct kobject *kobj,
 				      struct kobj_attribute *a, char *buf)
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index e71af8ab4ad8..d3023879bdf6 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -5466,6 +5466,69 @@ int btrfs_is_parity_mirror(struct btrfs_fs_info *fs_info, u64 logical, u64 len)
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
+				       int num_stripe, char *log, int logsz)
+{
+	struct stripe_mirror stripes[4] = {0}; //4: for testing, works for now.
+	struct btrfs_fs_devices *fs_devices;
+	u64 devid;
+	int index, j, cnt;
+	int lognr = 0;
+	int next_stripe;
+
+	index = 0;
+	lognr += scnprintf(log + lognr, logsz - lognr, "index=map:devid [");
+	for (j = first; j < first + num_stripe; j++) {
+		devid = map->stripes[j].dev->devid;
+
+		stripes[index].devid = devid;
+		stripes[index].map = j;
+
+		lognr += scnprintf(log + lognr, logsz - lognr, "%d=%d:%llu, ",
+				  index, j, devid);
+
+		index++;
+	}
+
+	sort(stripes, num_stripe, sizeof(struct stripe_mirror),
+	     btrfs_cmp_devid, NULL);
+
+	lognr += scnprintf(log + lognr, logsz - lognr, "] sorted=[");
+	for (index = 0; index < num_stripe; index++) {
+		j = stripes[index].map;
+		devid = stripes[index].devid;
+
+		lognr += scnprintf(log + lognr, logsz - lognr, "%d=%d:%llu, ",
+				  index, j, devid);
+	}
+
+	fs_devices = map->stripes[first].dev->fs_devices;
+	cnt = atomic_inc_return(&fs_devices->total_reads);
+	next_stripe = stripes[cnt % num_stripe].map;
+
+	lognr += scnprintf(log + lognr, logsz - lognr, "] next_stripe %d",
+			  next_stripe);
+
+	return next_stripe;
+}
+
 static u64 btrfs_estimate_read(struct btrfs_device *device,
 			       unsigned long *inflight)
 {
@@ -5608,6 +5671,11 @@ static int find_live_mirror(struct btrfs_fs_info *fs_info,
 			  first, num_stripes, current->comm, task_pid_nr(current),
 			  preferred_mirror);
 		break;
+	case BTRFS_READ_POLICY_ROUND_ROBIN:
+		preferred_mirror = btrfs_find_read_round_robin(map, first,
+							       num_stripes, log,
+							       logsz);
+		break;
 	}
 
 	/*
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index 40e56287204a..571b52afcaa1 100644
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

