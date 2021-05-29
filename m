Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0933394B6F
	for <lists+linux-btrfs@lfdr.de>; Sat, 29 May 2021 11:49:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbhE2JvG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 29 May 2021 05:51:06 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:60096 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbhE2JvE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 29 May 2021 05:51:04 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14T9nQFr127207
        for <linux-btrfs@vger.kernel.org>; Sat, 29 May 2021 09:49:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=9VuPZmUK7yWiYAT6Ik1fnR/MVoMf7ks+1K0AnEeBnQQ=;
 b=FTrZNW0K0v18AaIcmKXmL2PqNeTsEIiIOIlgv1bsryuF74u0SGSp7GakxdaLyxH6YpRB
 arXTOgEKA+wpOdqpO52RgzZ3cV5fkgt1I6fwgwuWJuPUQSZvCIKYILqvUrAWONVRqDtL
 LVqZhVG2coFJ9lKzVGQHUzXg05cX0Bo84bQ6w+9dKDVFePhQgJk9i99PrYDORuc4xYZY
 CyiXtxjOEyBclRjwvqiihHSNNm1S4y9JuIOUsvjwBFURuBxDSneLUG2oZ9uEcB9Mz3/2
 6Kje+syo6izmVqljYyhjb+A8j19PZSqrTokv1v5FWi9iA9/Yd0wLdbCRAc2/zWSIrhLq rg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 38udjmgdte-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Sat, 29 May 2021 09:49:26 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14T9igIT036174
        for <linux-btrfs@vger.kernel.org>; Sat, 29 May 2021 09:49:25 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by aserp3020.oracle.com with ESMTP id 38ude2pq14-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Sat, 29 May 2021 09:49:25 +0000
Received: from aserp3020.oracle.com (aserp3020.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 14T9lXI9042646
        for <linux-btrfs@vger.kernel.org>; Sat, 29 May 2021 09:49:25 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 38ude2pq09-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 29 May 2021 09:49:25 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 14T9nOM1013636;
        Sat, 29 May 2021 09:49:24 GMT
Received: from localhost.localdomain (/39.109.186.25)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sat, 29 May 2021 02:49:23 -0700
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Anand Jain <anand.jain@oracle.com>
Subject: [PATCH 2/4] btrfs: optimize variables size in btrfs_submit_compressed_read
Date:   Sat, 29 May 2021 17:48:34 +0800
Message-Id: <1d1bbf21b9bf703875ab5e0bb115e20089e174e4.1622252932.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1622252932.git.anand.jain@oracle.com>
References: <cover.1622252932.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: sq8TGVeO5mkto5O5v7Tw4r0UqjV92QVd
X-Proofpoint-ORIG-GUID: sq8TGVeO5mkto5O5v7Tw4r0UqjV92QVd
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9998 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 impostorscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 adultscore=0 spamscore=0
 suspectscore=0 bulkscore=0 priorityscore=1501 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105290076
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Patch (btrfs: reduce compressed_bio member's types) reduced some
member's size. Declare the variables @compressed_len, @nr_pages and
@pg_index size as an unsigned int in the function
btrfs_submit_compressed_read.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 fs/btrfs/compression.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index e10041af8476..c1432a58f378 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -667,9 +667,9 @@ blk_status_t btrfs_submit_compressed_read(struct inode *inode, struct bio *bio,
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
 	struct extent_map_tree *em_tree;
 	struct compressed_bio *cb;
-	unsigned long compressed_len;
-	unsigned long nr_pages;
-	unsigned long pg_index;
+	unsigned int compressed_len;
+	unsigned int nr_pages;
+	unsigned int pg_index;
 	struct page *page;
 	struct bio *comp_bio;
 	u64 cur_disk_byte = bio->bi_iter.bi_sector << 9;
-- 
2.30.2

