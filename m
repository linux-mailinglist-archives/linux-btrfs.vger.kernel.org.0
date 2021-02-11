Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B16AB3184DE
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Feb 2021 06:27:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229794AbhBKF0t (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 11 Feb 2021 00:26:49 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:46102 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229783AbhBKF0h (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 11 Feb 2021 00:26:37 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11B5Ols1153218;
        Thu, 11 Feb 2021 05:25:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=LC5M0UlFez7JCHyiZf8eaEbUTpwYNqKMmAweNOwqVTI=;
 b=urBoWjl9p+mTT8hUfwf5C/c/vD2S1ZIhFbRo++S7f2G4lG6YSJHUgSI7k5vhdGtoRw51
 YROP3RI8FPRXdvQxxgJ7/1eo/TNZhgqXxQUae1LT0TUXueAsi+jHyjtr8G2VmFHf9dyH
 EGRMnN94ZeBc1x/Kb39IkFv9icZAauM6v23poOC5SAqiXatdqnYt0+VjwYsGgrEviPJG
 BVL3CiuXLV99ISZDTU+XfgcSz1sO/LN8ZpqibX2lyNBX9Id6Of+z/tYFHnJ2vsr7lz70
 Tlp5mpP6OyO8XrHzTrHv3BZZae3bXuNv7r8VuqEzmpiz9VNjV2fS3OSWALPO5scXyHgE ew== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 36mv9dr927-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 11 Feb 2021 05:25:37 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11B5PXcD028259;
        Thu, 11 Feb 2021 05:25:36 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 36j513j1bs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 11 Feb 2021 05:25:36 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 11B5PZF9015025;
        Thu, 11 Feb 2021 05:25:35 GMT
Received: from ca-dev104.us.oracle.com (/10.129.135.33)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 10 Feb 2021 21:25:35 -0800
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     josef@toxicpanda.com
Subject: [PATCH 3/5] btrfs: scrub drop few function declarations
Date:   Wed, 10 Feb 2021 21:25:17 -0800
Message-Id: <0b82526e15e6d0cc33ec625f8eab3f42b8a76508.1613019838.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1613019838.git.anand.jain@oracle.com>
References: <cover.1613019838.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9891 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 adultscore=0
 mlxlogscore=972 phishscore=0 spamscore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102110045
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9891 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 mlxlogscore=985
 bulkscore=0 suspectscore=0 phishscore=0 adultscore=0 impostorscore=0
 mlxscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102110045
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Drop function declarations at the beginning of the file scrub.c. These
functions are defined before they are used in the same file.

No functional changes.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 fs/btrfs/scrub.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 70a90ca2c8da..029477dd77de 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -206,9 +206,6 @@ struct full_stripe_lock {
 	struct mutex mutex;
 };
 
-static void scrub_pending_bio_inc(struct scrub_ctx *sctx);
-static void scrub_pending_bio_dec(struct scrub_ctx *sctx);
-static int scrub_handle_errored_block(struct scrub_block *sblock_to_check);
 static int scrub_setup_recheck_block(struct scrub_block *original_sblock,
 				     struct scrub_block *sblocks_for_recheck);
 static void scrub_recheck_block(struct btrfs_fs_info *fs_info,
@@ -226,14 +223,11 @@ static int scrub_write_page_to_dev_replace(struct scrub_block *sblock,
 static int scrub_checksum_data(struct scrub_block *sblock);
 static int scrub_checksum_tree_block(struct scrub_block *sblock);
 static int scrub_checksum_super(struct scrub_block *sblock);
-static void scrub_block_get(struct scrub_block *sblock);
 static void scrub_block_put(struct scrub_block *sblock);
 static void scrub_page_get(struct scrub_page *spage);
 static void scrub_page_put(struct scrub_page *spage);
 static void scrub_parity_get(struct scrub_parity *sparity);
 static void scrub_parity_put(struct scrub_parity *sparity);
-static int scrub_add_page_to_rd_bio(struct scrub_ctx *sctx,
-				    struct scrub_page *spage);
 static int scrub_pages(struct scrub_ctx *sctx, u64 logical, u32 len,
 		       u64 physical, struct btrfs_device *dev, u64 flags,
 		       u64 gen, int mirror_num, u8 *csum,
@@ -251,8 +245,6 @@ static int scrub_add_page_to_wr_bio(struct scrub_ctx *sctx,
 static void scrub_wr_submit(struct scrub_ctx *sctx);
 static void scrub_wr_bio_end_io(struct bio *bio);
 static void scrub_wr_bio_end_io_worker(struct btrfs_work *work);
-static void __scrub_blocked_if_needed(struct btrfs_fs_info *fs_info);
-static void scrub_blocked_if_needed(struct btrfs_fs_info *fs_info);
 static void scrub_put_ctx(struct scrub_ctx *sctx);
 
 static inline int scrub_is_page_on_raid56(struct scrub_page *spage)
-- 
2.27.0

