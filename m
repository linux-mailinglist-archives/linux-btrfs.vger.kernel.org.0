Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B4F6719F52A
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Apr 2020 13:51:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727769AbgDFLvi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 6 Apr 2020 07:51:38 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:60682 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727717AbgDFLvg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 6 Apr 2020 07:51:36 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 036Bm1EL079091
        for <linux-btrfs@vger.kernel.org>; Mon, 6 Apr 2020 11:51:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=U0SHMAK8qmXmvSrWMkcr793HwUl7gEh/nV+MFcBBSzE=;
 b=JvreHjuTM6ynt5VfaInjFWF0SL/XJi6TSo7QHXYJ59NfhJ3vadoFcgSJ41IDQTxjPrtu
 mi7bIIftrl6Hadd1byAkLvlUuqGR8GX1FoFbX0eyzl5PfAjvGIqR8/a70oCxmYD/2TIi
 YvVPuvQ2Od6OpfmAWr9aAG447GXncX0i2X5lTuA65i2NrPBhZ7KnN/NUsTUmqTbtrj7X
 KVDOHwK53srH8H1qoBwwYngjPOINLxUEG1HHHUpJfH5TdhCFu7/eIdhCu5QEYJUnNeqD
 LD1I8KFe1dHnlaCLuIth4VWJvEs3zPwkfIPteWGIOaCrbM1FQds/fr35AnLJFiHlBFe1 Pw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 306j6m6arf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Mon, 06 Apr 2020 11:51:34 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 036BlMQE043963
        for <linux-btrfs@vger.kernel.org>; Mon, 6 Apr 2020 11:51:34 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 30741a96gh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Mon, 06 Apr 2020 11:51:34 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 036BpXx1009318
        for <linux-btrfs@vger.kernel.org>; Mon, 6 Apr 2020 11:51:33 GMT
Received: from tp.localdomain (/39.109.145.141)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 06 Apr 2020 04:51:33 -0700
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v7 2/5] btrfs: create read policy framework
Date:   Mon,  6 Apr 2020 19:51:08 +0800
Message-Id: <1586173871-5559-3-git-send-email-anand.jain@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1586173871-5559-1-git-send-email-anand.jain@oracle.com>
References: <1586173871-5559-1-git-send-email-anand.jain@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9582 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 phishscore=0
 malwarescore=0 bulkscore=0 spamscore=0 adultscore=99 mlxlogscore=999
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004060104
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9582 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999 spamscore=0
 priorityscore=1501 suspectscore=1 lowpriorityscore=0 malwarescore=0
 impostorscore=0 mlxscore=0 phishscore=0 adultscore=99 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004060104
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
---
(rebased on 5.6)
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
index c1909e5f4506..bafcf10f72ea 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -1206,6 +1206,7 @@ static int open_fs_devices(struct btrfs_fs_devices *fs_devices,
 	fs_devices->latest_bdev = latest_dev->bdev;
 	fs_devices->total_rw_bytes = 0;
 	fs_devices->chunk_alloc_policy = BTRFS_CHUNK_ALLOC_REGULAR;
+	fs_devices->read_policy = BTRFS_READ_POLICY_PID;
 out:
 	return ret;
 }
@@ -5445,7 +5446,19 @@ static int find_live_mirror(struct btrfs_fs_info *fs_info,
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
+		/* fall through */
+	case BTRFS_READ_POLICY_PID:
+		preferred_mirror = first + current->pid % num_stripes;
+		break;
+	}
 
 	if (dev_replace_is_ongoing &&
 	    fs_info->dev_replace.cont_reading_from_srcdev_mode ==
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index f067b5934c46..f5ed864e4c5d 100644
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
2.23.0

