Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C22129D30B
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Oct 2020 22:40:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725801AbgJ1VkT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 28 Oct 2020 17:40:19 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:35990 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727169AbgJ1Vj4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 28 Oct 2020 17:39:56 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09S4OWG3100414;
        Wed, 28 Oct 2020 04:25:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=6RNOUgtIQ7WG76hDcSAWH7Ws+b7Qq05Ls5gUPgTlyhM=;
 b=k4Tb/Vh/qOyB7Q/hPOTLYo0QLrmKddSxP2XDd/PNzsUc9Aj1UiUnzz8WYWwSeTTelVSH
 kC5bwsUAcaXeDynfbVzX81gv9zg58bBdpkmwB6SK009gpy2obUP7U4aLNmXRURb9IkZB
 FJK6eyyVxo0BEOKVrrVuYvCXKdXTNjBC7Cdvdenqt4JQLLdFKMPLiO7oKMd/OfcafGJJ
 loC8wsJiINoXLfWH/cHZTGBkQdvcn7pqjAaOVjGRgvyLajQnXcG77w/A/5/efx5T0Uz4
 f8PlXPuim0DaWxu+X4EnItxsRgY4CIYhb6dizrV4oTIAgivgcn14Xw1baYr/Ln2OFTdh 9w== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 34dgm42w0s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 28 Oct 2020 04:25:34 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09S4KRrF108493;
        Wed, 28 Oct 2020 04:25:33 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 34cwun51ja-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Oct 2020 04:25:33 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 09S4PXVS028735;
        Wed, 28 Oct 2020 04:25:33 GMT
Received: from localhost.localdomain (/39.109.231.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 27 Oct 2020 21:25:32 -0700
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH v10 2/3] btrfs: create read policy framework
Date:   Wed, 28 Oct 2020 12:25:03 +0800
Message-Id: <2dc8f9d04f2e9b62e1cc473d0a5d35fb6d314655.1603858308.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1603858308.git.anand.jain@oracle.com>
References: <cover.1603858308.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9787 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 bulkscore=0
 spamscore=0 adultscore=96 malwarescore=0 mlxlogscore=999 suspectscore=1
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010280025
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9787 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 impostorscore=0
 adultscore=89 bulkscore=0 spamscore=0 phishscore=0 mlxlogscore=999
 suspectscore=1 clxscore=1015 mlxscore=0 malwarescore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010280025
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

As of now, we use the %pid method to read striped mirrored data, which means
process id determines the stripe id to read. This type of routing
typically helps in a system with many small independent processes tying
to read random data. On the other hand, the %pid based read IO policy is
inefficient because if there is a single process trying to read a large
file, the overall disk bandwidth remains under-utilized.

So this patch introduces a read policy framework so that we could add more
read policies, such as IO routing based on the device's wait-queue or manual
when we have a read-preferred device or a policy based on the target
storage caching.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
---
v10: -
v9: -
v8: use fallthrough;
v7: Fix missing /* fall through */ in the switch
    Removed Reviewed-by: Josef Bacik <josef@toxicpanda.com>
v6:-
v5: Title renamed from:- btrfs: add read_policy framework
    Change log updated.
    Unnecessary comment dropped, added more where necessary.
    Optimize code in the switch remove duplicate code.
    Define BTRFS_READ_POLICY_DEFAULT dropped.
    Rename enum btrfs_read_policy_type to enum btrfs_read_policy.
    Rename BTRFS_READ_BY_PID to BTRFS_READ_POLICY_PID.
    (As its mainly renames. Reviewed-by retained).
v4: -
v3: Declare fs_devices::readmirror as enum btrfs_readmirror_policy_type
v2: Declare fs_devices::readmirror as u8 instead of atomic_t 
    A small change in comment and change log wordings.

 fs/btrfs/volumes.c | 15 ++++++++++++++-
 fs/btrfs/volumes.h | 14 ++++++++++++++
 2 files changed, 28 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 58b9c419a2b6..da31b11ceb61 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -1223,6 +1223,7 @@ static int open_fs_devices(struct btrfs_fs_devices *fs_devices,
 	fs_devices->latest_bdev = latest_dev->bdev;
 	fs_devices->total_rw_bytes = 0;
 	fs_devices->chunk_alloc_policy = BTRFS_CHUNK_ALLOC_REGULAR;
+	fs_devices->read_policy = BTRFS_READ_POLICY_PID;
 
 	return 0;
 }
@@ -5482,7 +5483,19 @@ static int find_live_mirror(struct btrfs_fs_info *fs_info,
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
+		fallthrough;
+	case BTRFS_READ_POLICY_PID:
+		preferred_mirror = first + current->pid % num_stripes;
+		break;
+	}
 
 	if (dev_replace_is_ongoing &&
 	    fs_info->dev_replace.cont_reading_from_srcdev_mode ==
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index bf27ac07d315..e3c36951742d 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -211,6 +211,15 @@ enum btrfs_chunk_allocation_policy {
 	BTRFS_CHUNK_ALLOC_REGULAR,
 };
 
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
@@ -264,6 +273,11 @@ struct btrfs_fs_devices {
 	struct completion kobj_unregister;
 
 	enum btrfs_chunk_allocation_policy chunk_alloc_policy;
+
+	/*
+	 * policy used to read the mirrored stripes
+	 */
+	enum btrfs_read_policy read_policy;
 };
 
 #define BTRFS_BIO_INLINE_CSUM_SIZE	64
-- 
2.25.1

