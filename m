Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B25761816EF
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Mar 2020 12:36:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729222AbgCKLg2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 11 Mar 2020 07:36:28 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:39842 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725834AbgCKLgX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 11 Mar 2020 07:36:23 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02BBXZOr137468
        for <linux-btrfs@vger.kernel.org>; Wed, 11 Mar 2020 11:36:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id; s=corp-2020-01-29;
 bh=qXQUQ5/gUmXQOzy7kzGc1ZWa2ChnwJesjJRZlbo6CME=;
 b=bi/dYPsTMzIVmRFvkbl6HebmvpiZKH9GVVgPcOuFpWe5oc+i6AA/d0epxl80isnYyYY5
 dX2xpfIa1a+ei1pVuUhW4dv8nYDOPieXUpQ8VPPF1h7hHmt0/WBmqaO5ci5F8ChMReaB
 oDdVIUzjho5g89HrPCXdQLM62GHa6SnSSVD+aXrmsmZYsTTm8ixKa0DHgBGXIajcne/D
 GphxR8oF2b7ilCBuf8YegNAmyzWILRDgFAO/7G2zJjMyrugBZEcyjdfAGye7m8UZ71Q6
 c2f7MSIiBDqxy/LEbAMfJDEOZ1ag7l5ZOEzNP2zcnEJCyudUQxBZpiOVN83nzyhHXkxU HA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 2yp7hm7c12-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Wed, 11 Mar 2020 11:36:21 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02BBa4cb134625
        for <linux-btrfs@vger.kernel.org>; Wed, 11 Mar 2020 11:36:21 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 2ypv9u751e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Wed, 11 Mar 2020 11:36:05 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 02BBXwx7008501
        for <linux-btrfs@vger.kernel.org>; Wed, 11 Mar 2020 11:33:59 GMT
Received: from tp.localdomain (/39.109.145.141)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 11 Mar 2020 04:33:58 -0700
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs-progs: match the max chunk size to the kernel
Date:   Wed, 11 Mar 2020 19:33:49 +0800
Message-Id: <1583926429-28485-1-git-send-email-anand.jain@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9556 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 mlxlogscore=999
 spamscore=0 malwarescore=0 mlxscore=0 adultscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003110075
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9556 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0
 priorityscore=1501 clxscore=1015 mlxscore=0 impostorscore=0
 mlxlogscore=999 suspectscore=3 phishscore=0 malwarescore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003110075
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

For chunk type Single, %metadata_profile and %data_profile in
create_raid_groups() is NULL, so we continue to use the initially
created 8MB chunks for both metadata and data.

8MB is too small. Kernel default chunk size for type Single is 256MB.
Further the mkfs.btrfs created chunk will stay unless relocated or
cleanup during balance. Consider an ENOSPC case due to 8MB metadata
full.

I don't see any reason that mkfs.btrfs should create 8MB chunks for
chunk type Single instead it could match it with the kernel allocation
size of 256MB for the chunk type Single.

For other chunk-types the create_one_raid_group() is called and creates
the required bigger chunks and there is no change with this patch. Also
for fs sizes (-b option) smaller than 256MB there is no issue as the
chunks sizes are 10% of the requested fs-size until the maximum of
256MB.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
The fio in generic/299 is failing to create the files which shall be
deleted in the later part of the test case and the failure happens
only with the MKFS_OPTIONS="-n64K -msingle" only and not with other types
of chunks. This is bit inconsistent. And it appears that in case of
Single chunk type it fails to create (or touch) the necessary file
as the metadata is full, so increasing the metadata chunk size to the
sizes as kernel would create will add consistency.

 volumes.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/volumes.c b/volumes.c
index b46bf5988a95..d56f2fc897e3 100644
--- a/volumes.c
+++ b/volumes.c
@@ -1004,7 +1004,7 @@ int btrfs_alloc_chunk(struct btrfs_trans_handle *trans,
 	struct list_head *cur;
 	struct map_lookup *map;
 	int min_stripe_size = SZ_1M;
-	u64 calc_size = SZ_8M;
+	u64 calc_size = SZ_256M;
 	u64 min_free;
 	u64 max_chunk_size = 4 * calc_size;
 	u64 avail = 0;
-- 
1.8.3.1

