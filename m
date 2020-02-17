Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C9B321610C7
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Feb 2020 12:13:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728362AbgBQLNJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 17 Feb 2020 06:13:09 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:34018 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728296AbgBQLNJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 17 Feb 2020 06:13:09 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01HBD5P0105879;
        Mon, 17 Feb 2020 11:13:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=1o3fnj/omXneznfwHwJ6zDhr9rskZsg8Q4iKwqMgIYc=;
 b=bKFno/dacVawHw3uDWpFL7fV694kEVd86LqDNq1Yi/4uAwuwoKgcnj2OPXekrh3K/lkD
 +0EZqayA0EklJvuqzQxqzl5S0va0UTV86HYdZNNOQyyA2EKqRMbtBuBjYO9cTVSbG5LU
 vsz1cZ7Z37obWF15SioYBQt0mmfIwKQGZ/CQmokrQVYt2yrVItwOW8IDUPYMif0I7+wi
 0fNN29iW5r0Xz19L8qTlJLf75avHuOCpCLVqX3R4ygFFDr+hqxyHIRzFSMonHKYp7pRJ
 XgJ+o8NjUSxwJyg+jX01sbFsiyX2eV+8JeLofOiODKtBpSZfiTZik8/jfleJts+rCQl7 pQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 2y68kqqmn5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 17 Feb 2020 11:13:05 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01HBBsou101544;
        Mon, 17 Feb 2020 11:12:59 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 2y6tehey80-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 17 Feb 2020 11:12:59 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 01HBCxGP027534;
        Mon, 17 Feb 2020 11:12:59 GMT
Received: from tp.localdomain (/39.109.145.141)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 17 Feb 2020 03:12:58 -0800
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     josef@toxicpanda.com, dsterba@suse.com
Subject: [PATCH v5 2/5] btrfs: create read policy framework
Date:   Mon, 17 Feb 2020 19:12:42 +0800
Message-Id: <1581937965-16569-3-git-send-email-anand.jain@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1581937965-16569-1-git-send-email-anand.jain@oracle.com>
References: <1581937965-16569-1-git-send-email-anand.jain@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9533 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0 bulkscore=0
 suspectscore=1 mlxscore=0 mlxlogscore=999 adultscore=92 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002170097
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9533 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0
 lowpriorityscore=0 mlxlogscore=999 malwarescore=0 priorityscore=1501
 clxscore=1015 mlxscore=0 suspectscore=1 impostorscore=0 bulkscore=0
 adultscore=90 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002170097
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

As of now we use %pid method to read stripped mirrored data, which means
process id determines the stripe id to be read. This type of routing
typically helps in a system with many small independent processes tying
to read random data. On the other hand the %pid based read IO policy is
inefficient because if there is a single process trying to read large
data the overall disk bandwidth remains under-utilized.

So this patch introduces read policy framework so that we could add more
read policies, such as IO routing based on device's wait-queue or manual
when we have a read-preferred device or a policy based on the target
storage caching.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
---
v5: Title renamed from:- btrfs: add read_policy framework
    Change log updated.
    Unnecessary comment dropped, added more where necessary.
    Optimize code in the switch remove duplicate code.
    Define BTRFS_READ_POLICY_DEFAULT dropped.
    Rename enum btrfs_read_policy_type to enum btrfs_read_policy.
    Rename BTRFS_READ_BY_PID to BTRFS_READ_POLICY_PID.
v4: -
v3: Declare fs_devices::readmirror as enum btrfs_readmirror_policy_type
v2: Declare fs_devices::readmirror as u8 instead of atomic_t
    A small change in comment and change log wordings.

 fs/btrfs/volumes.c | 13 ++++++++++++-
 fs/btrfs/volumes.h | 14 ++++++++++++++
 2 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 387f80656476..b6efb87bb0ae 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -1209,6 +1209,7 @@ static int open_fs_devices(struct btrfs_fs_devices *fs_devices,
 	fs_devices->opened = 1;
 	fs_devices->latest_bdev = latest_dev->bdev;
 	fs_devices->total_rw_bytes = 0;
+	fs_devices->read_policy = BTRFS_READ_POLICY_PID;
 out:
 	return ret;
 }
@@ -5358,7 +5359,17 @@ static int find_live_mirror(struct btrfs_fs_info *fs_info,
 	else
 		num_stripes = map->num_stripes;
 
-	preferred_mirror = first + current->pid % num_stripes;
+	switch (fs_info->fs_devices->read_policy) {
+	default:
+		/*
+		 * Shouldn't happen, just warn and use pid instead of failing.
+		 */
+		btrfs_warn_rl(fs_info,
+			      "unknown read_policy type %u, fallback to pid",
+			      fs_info->fs_devices->read_policy);
+	case BTRFS_READ_POLICY_PID:
+		preferred_mirror = first + current->pid % num_stripes;
+	}
 
 	if (dev_replace_is_ongoing &&
 	    fs_info->dev_replace.cont_reading_from_srcdev_mode ==
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index f01552a0785e..ed2bba741b6e 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -209,6 +209,15 @@ struct btrfs_device {
 BTRFS_DEVICE_GETSET_FUNCS(disk_total_bytes);
 BTRFS_DEVICE_GETSET_FUNCS(bytes_used);
 
+/*
+ * Read policies for the mirrored block groups, read picks the stripe based
+ * on these policies.
+ */
+enum btrfs_read_policy {
+	BTRFS_READ_POLICY_PID,
+	BTRFS_NR_READ_POLICY,
+};
+
 struct btrfs_fs_devices {
 	u8 fsid[BTRFS_FSID_SIZE]; /* FS specific uuid */
 	u8 metadata_uuid[BTRFS_FSID_SIZE];
@@ -260,6 +269,11 @@ struct btrfs_fs_devices {
 	struct kobject *devices_kobj;
 	struct kobject *devinfo_kobj;
 	struct completion kobj_unregister;
+
+	/*
+	 * policy used to read the mirrored stripes
+	 */
+	enum btrfs_read_policy read_policy;
 };
 
 #define BTRFS_BIO_INLINE_CSUM_SIZE	64
-- 
1.8.3.1

