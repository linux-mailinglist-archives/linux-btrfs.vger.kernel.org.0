Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 490BE29D8F4
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Oct 2020 23:41:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389106AbgJ1WlI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 28 Oct 2020 18:41:08 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:56942 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388997AbgJ1Wk1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 28 Oct 2020 18:40:27 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09SDFjjP063536;
        Wed, 28 Oct 2020 13:17:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=GM1VVFkw/6F8yFGRdo2+BYlRxpi/5dufKB/au86tvU0=;
 b=oqNgBlxu4KJbUIqteEJTUNwJdmnrXUFYRXzdBuITkaZywKl6hvcGUgAaRsJhcEyIxudw
 hSQvkwfCyYtdgTWk3IyZDtggPipaPqxfF3mxJKOu2jzVlamxB3itHrbEpqX8NVV/gVzK
 9TOC2tEsgXaqqTnAdRo699ZdFO7V0Atec69fld347R6pGZlI3B+mGWxqTf6MAHSEvf5G
 L5vPli6cz/3j4s/CBm0TEivH8zdQOg+zGUkkEZdmvLvyJ1UIEO7PVS9UZk+ltEi4IUqA
 FD41MdjMJZj0vEr3xeWBBtJ5oay4XxVkki3MixGfGgBIxkLAOKNJaIhEw6PTaJqvNT8l Wg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2130.oracle.com with ESMTP id 34c9sayfsb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 28 Oct 2020 13:17:06 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09SDATNF183830;
        Wed, 28 Oct 2020 13:15:06 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 34cwunk2fc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Oct 2020 13:15:06 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 09SDF5gf011140;
        Wed, 28 Oct 2020 13:15:05 GMT
Received: from localhost.localdomain (/39.109.231.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 28 Oct 2020 06:15:05 -0700
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH v10 2/3] btrfs: create read policy framework
Date:   Wed, 28 Oct 2020 21:14:46 +0800
Message-Id: <6cf180d094035e0d9cd6544f60b80d79957a17d9.1603884513.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1603884513.git.anand.jain@oracle.com>
References: <cover.1603884513.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9787 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 bulkscore=0
 spamscore=0 adultscore=99 malwarescore=0 mlxlogscore=999 suspectscore=1
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010280089
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9787 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 malwarescore=0 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 spamscore=0 phishscore=0 clxscore=1015 suspectscore=1
 adultscore=97 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010280089
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
index b18e026424a6..6bf487626f23 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -1223,6 +1223,7 @@ static int open_fs_devices(struct btrfs_fs_devices *fs_devices,
 	fs_devices->latest_bdev = latest_dev->bdev;
 	fs_devices->total_rw_bytes = 0;
 	fs_devices->chunk_alloc_policy = BTRFS_CHUNK_ALLOC_REGULAR;
+	fs_devices->read_policy = BTRFS_READ_POLICY_PID;
 
 	return 0;
 }
@@ -5485,7 +5486,19 @@ static int find_live_mirror(struct btrfs_fs_info *fs_info,
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
index 232f02bd214f..97f075516696 100644
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

