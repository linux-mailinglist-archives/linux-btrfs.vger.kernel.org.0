Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B591B31EE1D
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Feb 2021 19:20:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231976AbhBRSRq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 18 Feb 2021 13:17:46 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:56294 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232105AbhBRRVc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 18 Feb 2021 12:21:32 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11IHIxca041928;
        Thu, 18 Feb 2021 17:20:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2020-01-29; bh=lySCUf+qEzKn817ISr5deK2JiRf1P+ZCW8uB+zSqd28=;
 b=ZDbMIYdpXGMtx6rHBQVI2P8YjMOEMqy+xMvV9u6ToNJlNChRRgS9X+2C1aHsaSZeiC2q
 SR8hNEBUv/m72ooTbDT+PTqtGSTGW6RwjYL6UJEVzsdqVYW21DH6ZB8bAs9W+tDxw2Bf
 +TDn1f0uRnbzx4LowfE11exqb4IVwfigPwTsC2IHVBhtO/wgZMR6Le4fCnQcTOl3jsvy
 nGkAZ8lGdGv7fhr+9ucr2AE6yDGdrOpojuSIE/yhqQn4ofSj2mY9/MkW9A1v4cb8AZfZ
 EfAkeRCnJ+YCx04cYTliN74WWE2MHdcf/ItY1UuCHUqILLqC0sYUkIPi2fvRiOPO5Ye1 xQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 36p66r6s4p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 Feb 2021 17:20:27 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11IHKKjN106799;
        Thu, 18 Feb 2021 17:20:26 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 36prp1su0g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 Feb 2021 17:20:26 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 11IHKQfJ006006;
        Thu, 18 Feb 2021 17:20:26 GMT
Received: from ca-dev104.us.oracle.com (/10.129.135.33)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 18 Feb 2021 17:20:25 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     josef@toxicpanda.com, kreijack@libero.it
Subject: [RFC][PATCH] btrfs: sysfs for chunk layout hint
Date:   Thu, 18 Feb 2021 09:20:19 -0800
Message-Id: <0ed770d6d5e37fc942f3034d917d2b38477d7d20.1613668002.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9898 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 bulkscore=0 suspectscore=0 spamscore=0 malwarescore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102180145
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9898 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 suspectscore=0
 impostorscore=0 priorityscore=1501 clxscore=1011 spamscore=0 mlxscore=0
 phishscore=0 malwarescore=0 bulkscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102180145
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

btrfs_chunk_alloc() uses dev_alloc_list to allocate new chunks. The
function's stack leading to btrfs_cmp_device_info() sorts the
dev_alloc_list in the descending order of unallocated space. This
sorting helps to maximize the filesystem space.

But, there might be other types of preferences when allocating the
chunks. For example, allocation by device latency, with which the
metadata could go to the device with the least latency.

This patch is a preparatory patch and makes the existing allocation
layout a configurable parameter using sysfs, as shown below.

cd /sys/fs/btrfs/863c787e-fdbd-49ca-a0ea-22f36934ff1f
cat chunk_layout_data
[size]
cat chunk_layout_metadata
[size]

We could add more chunk allocation types by adding to the list in
enum btrfs_chunk_layout{ }.

This is only a preparatory patch. The parameter is only an in-memory
as of now. A persistent disk structure can be added on top of this
when we have a consensus.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
This + sequential chunk layout hint (experimental) (patch not yet sent)
helped me get consistent performance numbers for read_policy pid.
As chunk layout hint is not set at mkfs, a balance after setting the
desired chunk layout hint is needed.

 fs/btrfs/ctree.h   |  3 ++
 fs/btrfs/disk-io.c |  3 ++
 fs/btrfs/sysfs.c   | 98 ++++++++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/volumes.c |  4 +-
 fs/btrfs/volumes.h | 10 +++++
 5 files changed, 117 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 3bc00aed13b2..c37bd2d7f5d4 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -993,6 +993,9 @@ struct btrfs_fs_info {
 	spinlock_t eb_leak_lock;
 	struct list_head allocated_ebs;
 #endif
+
+	int chunk_layout_data;
+	int chunk_layout_metadata;
 };
 
 static inline struct btrfs_fs_info *btrfs_sb(struct super_block *sb)
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index c2576c5fe62e..c81f95339a35 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -2890,6 +2890,9 @@ void btrfs_init_fs_info(struct btrfs_fs_info *fs_info)
 	fs_info->swapfile_pins = RB_ROOT;
 
 	fs_info->send_in_progress = 0;
+
+	fs_info->chunk_layout_data = BTRFS_CHUNK_LAYOUT_SIZE;
+	fs_info->chunk_layout_metadata = BTRFS_CHUNK_LAYOUT_SIZE;
 }
 
 static int init_mount_fs_info(struct btrfs_fs_info *fs_info, struct super_block *sb)
diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index 30e1cfcaa925..788784b1ed44 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -967,6 +967,102 @@ static ssize_t btrfs_read_policy_store(struct kobject *kobj,
 }
 BTRFS_ATTR_RW(, read_policy, btrfs_read_policy_show, btrfs_read_policy_store);
 
+static const char * const btrfs_chunk_layout_name[] = { "size" };
+
+static ssize_t btrfs_chunk_layout_data_show(struct kobject *kobj,
+					    struct kobj_attribute *a, char *buf)
+{
+	struct btrfs_fs_info *fs_info = to_fs_info(kobj);
+	ssize_t ret = 0;
+	int i;
+
+	for (i = 0; i < BTRFS_NR_CHUNK_LAYOUT; i++) {
+		if (fs_info->chunk_layout_data == i)
+			ret += scnprintf(buf + ret, PAGE_SIZE - ret, "%s[%s]",
+					 (ret == 0 ? "" : " "),
+					 btrfs_chunk_layout_name[i]);
+		else
+			ret += scnprintf(buf + ret, PAGE_SIZE - ret, "%s%s",
+					 (ret == 0 ? "" : " "),
+					 btrfs_chunk_layout_name[i]);
+	}
+
+	ret += scnprintf(buf + ret, PAGE_SIZE - ret, "\n");
+
+	return ret;
+}
+
+static ssize_t btrfs_chunk_layout_data_store(struct kobject *kobj,
+					     struct kobj_attribute *a,
+					     const char *buf, size_t len)
+{
+	struct btrfs_fs_info *fs_info = to_fs_info(kobj);
+	int i;
+
+	for (i = 0; i < BTRFS_NR_CHUNK_LAYOUT; i++) {
+		if (strmatch(buf, btrfs_chunk_layout_name[i])) {
+			if (i != fs_info->chunk_layout_data) {
+				fs_info->chunk_layout_data = i;
+				btrfs_info(fs_info, "chunk_layout_data set to '%s'",
+					   btrfs_chunk_layout_name[i]);
+			}
+			return len;
+		}
+	}
+
+	return -EINVAL;
+}
+BTRFS_ATTR_RW(, chunk_layout_data, btrfs_chunk_layout_data_show,
+	      btrfs_chunk_layout_data_store);
+
+static ssize_t btrfs_chunk_layout_metadata_show(struct kobject *kobj,
+						struct kobj_attribute *a,
+						char *buf)
+{
+	struct btrfs_fs_info *fs_info = to_fs_info(kobj);
+	ssize_t ret = 0;
+	int i;
+
+	for (i = 0; i < BTRFS_NR_CHUNK_LAYOUT; i++) {
+		if (fs_info->chunk_layout_metadata == i)
+			ret += scnprintf(buf + ret, PAGE_SIZE - ret, "%s[%s]",
+					 (ret == 0 ? "" : " "),
+					 btrfs_chunk_layout_name[i]);
+		else
+			ret += scnprintf(buf + ret, PAGE_SIZE - ret, "%s%s",
+					 (ret == 0 ? "" : " "),
+					 btrfs_chunk_layout_name[i]);
+	}
+
+	ret += scnprintf(buf + ret, PAGE_SIZE - ret, "\n");
+
+	return ret;
+}
+
+static ssize_t btrfs_chunk_layout_metadata_store(struct kobject *kobj,
+						 struct kobj_attribute *a,
+						 const char *buf, size_t len)
+{
+	struct btrfs_fs_info *fs_info = to_fs_info(kobj);
+	int i;
+
+	for (i = 0; i < BTRFS_NR_CHUNK_LAYOUT; i++) {
+		if (strmatch(buf, btrfs_chunk_layout_name[i])) {
+			if (i != fs_info->chunk_layout_metadata) {
+				fs_info->chunk_layout_metadata = i;
+				btrfs_info(fs_info,
+					   "chunk_layout_metadata set to '%s'",
+					   btrfs_chunk_layout_name[i]);
+			}
+			return len;
+		}
+	}
+
+	return -EINVAL;
+}
+BTRFS_ATTR_RW(, chunk_layout_metadata, btrfs_chunk_layout_metadata_show,
+	      btrfs_chunk_layout_metadata_store);
+
 static const struct attribute *btrfs_attrs[] = {
 	BTRFS_ATTR_PTR(, label),
 	BTRFS_ATTR_PTR(, nodesize),
@@ -978,6 +1074,8 @@ static const struct attribute *btrfs_attrs[] = {
 	BTRFS_ATTR_PTR(, exclusive_operation),
 	BTRFS_ATTR_PTR(, generation),
 	BTRFS_ATTR_PTR(, read_policy),
+	BTRFS_ATTR_PTR(, chunk_layout_data),
+	BTRFS_ATTR_PTR(, chunk_layout_metadata),
 	NULL,
 };
 
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index d1ba160ef73b..2223c4263d4a 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -5097,7 +5097,9 @@ static int gather_device_info(struct btrfs_fs_devices *fs_devices,
 	ctl->ndevs = ndevs;
 
 	/*
-	 * now sort the devices by hole size / available space
+	 * Now sort the devices by hole size / available space.
+	 * This sort helps to pick device(s) with larger space.
+	 * That is BTRFS_CHUNK_LAYOUT_SIZE.
 	 */
 	sort(devices_info, ndevs, sizeof(struct btrfs_device_info),
 	     btrfs_cmp_device_info, NULL);
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index d0a90dc7fc03..b514d09f4ba8 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -218,6 +218,16 @@ enum btrfs_chunk_allocation_policy {
 	BTRFS_CHUNK_ALLOC_ZONED,
 };
 
+/*
+ * If we have more than the required number of the devices for striping,
+ * chunk_layout let us know which device to use.
+ */
+enum btrfs_chunk_layout {
+	/* Use in the order of the size of the unallocated space on the device */
+	BTRFS_CHUNK_LAYOUT_SIZE,
+	BTRFS_NR_CHUNK_LAYOUT,
+};
+
 /*
  * Read policies for mirrored block group profiles, read picks the stripe based
  * on these policies.
-- 
2.27.0

