Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C644A42B65A
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Oct 2021 08:07:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbhJMGJN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 13 Oct 2021 02:09:13 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:25394 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237884AbhJMGHm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 13 Oct 2021 02:07:42 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19D5UorZ028773;
        Wed, 13 Oct 2021 06:05:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2021-07-09;
 bh=euiO9B6psYcl8LITQGrFzDjcfanfyLwkCdk8rkX8y+o=;
 b=JD8kGU3qQQ5sNR10vFzHspeO7ICkrOXWEnVTmbvsfh74HGWnzOJK1nywP8x7Zdt1k+zl
 cCQbahI6ry3Oivk0tvELD+GO6vNnWX2a0m5mezPcxWbgUoBe5R+5o/ZEkFRr+fMYqvmn
 wqZ8YhNIwBZhOIso/nm0MHuVwzl3rwgWBBKGu2VsR1AJ2IKpmlxkKFXIdK1VHHbh78iX
 pTdkWrWvhibk73+5CVbBcfUmdnpug4iXFjPq57LljtY+eJsttllLSlqzHMmdlV0TmQ4Z
 JETlYAS29k+Q25iHzNpkWAH5/WyJ3q2nYjpNVF61j7EFW2/kMH4+1zo2aIhYALaTMDWE 5Q== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bnkbh1h0w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Oct 2021 06:05:33 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 19D64lbE013717;
        Wed, 13 Oct 2021 06:05:32 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2107.outbound.protection.outlook.com [104.47.70.107])
        by aserp3020.oracle.com with ESMTP id 3bmae07xt1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Oct 2021 06:05:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jU23njx9hJh732ttVlS0uWGqiLj5eaGri/eFR43YgQCWAldR6KrIRy/DwpeG3R8jfXzygdhOhbqMBT7acvyEIeAe8HB/cw1418ufYF4LD/02pybGaMpOYYjc3gcFUyMo2tn+8mIPhiXTDiciRsr++PXb2FW7Y3stga9jy7lzFwyGY6Bm/JurotBRO3R4i/Fq6CuAFnVRiSkOhq2KI+bagwC9kNfv5TU/Fob0/a043qVJvoUta7tfHTXBSEsqPQxB4jt7oqCVOn7l8y3xXoPeAqgo07NFovEjm3KYOfIs1Djkv6Ke7eaDMSZyGng+Mk22rgKJeQRnHo5Sy6RmAWkFRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=euiO9B6psYcl8LITQGrFzDjcfanfyLwkCdk8rkX8y+o=;
 b=EsP0lFs/d72J0f8ZjHNq9U38Kwy+0ENs0mCTL4ZNnl9WJFMnCl4sLa6xWjIgeKlwwnPK07NS5jAxlQz2OrMWykdK+Zuqk8AUByEU87Q2Nt8TM6nNIKNq/Ai3Nnh4SMLZAKsq1Fqpq24yUIkSARreAhPOlqb2uzvhF545eaXWS0WsKSiwuVxNZSd5VYkMT3KMtMt+5ZonIPb5kf5gR9ye2TcGxgxnw4uD9qQ7ohhOf5OFHLMKfmcKB+bZYHM9e4FRPe1Plywu7C2YnxWVnmJPPLX8+QX9PTtF33e5CWjyWbX3mzmtklw399wO8ytwuMB78ujjRtpsMPig3E0T0XGxKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=euiO9B6psYcl8LITQGrFzDjcfanfyLwkCdk8rkX8y+o=;
 b=so4hxt40S7Mtz+DCNAehwQ/HIvVp2JwrchPWIctP1KE9R5inqm52qV47MbBUjEzKoePE0DjV9reKCtEs6VXcWJKYWu/Ea6h90WxJ3XLfC6qGPX9z90YiPERs3HCSEwRrwbwAPpYrHmsg+eX4fODsrX0ACWKWL3+bDUFG7AOW/iY=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by BLAPR10MB5314.namprd10.prod.outlook.com (2603:10b6:208:325::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.20; Wed, 13 Oct
 2021 06:05:30 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::49a5:5188:b83d:b6c9]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::49a5:5188:b83d:b6c9%8]) with mapi id 15.20.4587.026; Wed, 13 Oct 2021
 06:05:30 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Subject: [PATCH] btrfs: reduce btrfs_update_block_group alloc argument to bool
Date:   Wed, 13 Oct 2021 14:05:14 +0800
Message-Id: <5f0f20b2b0ad9c608357f5f3db27c8e5a9714f80.1634104229.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG3P274CA0016.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::28)
 To MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
MIME-Version: 1.0
Received: from localhost.localdomain (39.109.140.76) by SG3P274CA0016.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.15 via Frontend Transport; Wed, 13 Oct 2021 06:05:29 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 57249e71-7f80-46ae-3b3b-08d98e0f75f6
X-MS-TrafficTypeDiagnostic: BLAPR10MB5314:
X-Microsoft-Antispam-PRVS: <BLAPR10MB531445F8E5310C66C6A4DF23E5B79@BLAPR10MB5314.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:913;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q9lEmvHR+r1AkFByxv+cePfMddXR865E6J1HYGroy9vlDJie4hy73xjFlJ8BM1a1qOW/zRIGGei67AI32cZCqdqWqgaCbyMGGPu/tIZeCF4cYSL+5yoBkADDfbrhrL7N9EgQoizpydtSux8psCvtkQ2fl2gpAxf2FH36Hv3e2JhqQ4jg9lKNiIWvoJ4U1A0WRiz35PXUcYH0GBUOfd3xQx+2ieNlzRU9N056OQwEvyzrNCjeQVYElPmTT1cmSOYDzFOk7JyFDJlZH8HPupBv5taxr4aoidyUwFrsj/cssOKjeU0qiLRSsYrN+38rW1HjG+Sg+hUBJht34K5qXVbs/YvAvbG2atfRw393bMG6Gr65pWmymij7y5FS916F40/MHw224RZnO92+RUaF5vQWnUYup9X+nEhHHr9ZZ5dTRncE2hfJ/OPB+OGNZzOyqBZiaA1pbWz8Newf2/gJLPs5FyBLIoxN+ufL0vEBJ30QP6y0D45Ts5gZyqfc3hSGu9j1zl1hRwQYZi8RZ63gVRPRbaUwFpeNLK/pePMqPCWKqWZED6sIG2/0Pl4UfSSwB5iGCKnBoQF15ikRFu5n6R/S+O5pTEkyzz1LcjTjADnAm03esXn4sMQWyrtiYO85P4cbwaN4keqP7+t0Imtr/BU1mNsSI5huU7UVAHpaVnfCoWwYztJ2GTECZXLV4zQawnnF0GzwmmdMCwxxAmVoWcO+Gw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(86362001)(66556008)(8676002)(52116002)(83380400001)(26005)(508600001)(2616005)(6506007)(66476007)(66946007)(6666004)(956004)(8936002)(186003)(2906002)(6512007)(36756003)(5660300002)(316002)(6486002)(38100700002)(38350700002)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Xu93Ex0wL6BkzUMyv5P8O8D1b6q+yAGlxS/MfYBrq1+MIj2BqRS0GT/QxF1K?=
 =?us-ascii?Q?GYCjHKYyirxD6OU4h9VbwsE3EilKOvoltjT077K7IbPIkFIdI/WfVUCt5A8w?=
 =?us-ascii?Q?LIYSDQkzgJ0a7nYLDoR7hWdDKKpQz0bGcKDXbolzByiSauGXc5BVvWzOHUmy?=
 =?us-ascii?Q?oYMsnGFNxKvG24c4otl6bozBfXnrkOGNapKJ8G+rZrTAr19LxVgOnYjgXwlc?=
 =?us-ascii?Q?d0lxbmxduBj3EmzlFICuop3ZEXJdU0yeq77N1bvS63bdO2RoUJqOcmGezMkY?=
 =?us-ascii?Q?51uUqWvCol+4utZ7aicfxV3Ju5kcr2CjEOGvyKBql82/nTEO6HvnixKD0PhS?=
 =?us-ascii?Q?kmN+KlUiATOC83REjZabfVokvoi2zrzcNOSzcYj9eG3M/JuuQtWfFCKrY3I3?=
 =?us-ascii?Q?w2VmKPdkxA+aUmmx85CuAW6Y9dUKAmgXiRY1ujvHZ3Wlx7dB6xpqU7+NBF89?=
 =?us-ascii?Q?k83PUwWXlju73t4xcfSAtzscsQcrXYcp0BngXuWOPLfq+YPLPrVzCLOx4wdn?=
 =?us-ascii?Q?diBREbC+HS25rz6Hn5JUp1yW4VR4KYWodCXmD6SVJarVhOQQbmovDozgNujY?=
 =?us-ascii?Q?6yC618A5EYhPflNbvAXR3gko8iZVZhIgreV0CEAUMmGXB+hA9dqoaOaKEPqX?=
 =?us-ascii?Q?DHhCEIhwSKvYuxpwokzngErqtsOhJrTmpT4BvogpwIkEdzBHapTXxqp3IHJP?=
 =?us-ascii?Q?G3OnmUXhUIi2bMk+wwYET64l3KJWhFPZI0uYux2M/gg4FghN4zd0IcYhju/5?=
 =?us-ascii?Q?XkEhA94cSD8D2eRChM5gtcNOsp8uJA782aI9/tu7rcx7W6kVTY45IKXIvCu9?=
 =?us-ascii?Q?CqmkR805gURYl203Wl+klHMqpxL2TRFq7Ft/1MluXuF6IhbV4pDfDg7RuZg/?=
 =?us-ascii?Q?EDvfU6dX54YXarYBZwyMSJLxYZbCGZi0s/rbGk7liGX8VxO9tsKR3swCSzX4?=
 =?us-ascii?Q?dKZNRroKAA9avJNWPUrWGN87ZQXSqpwVn/hVwkMLq6YhaYNHzTS28N8w72zJ?=
 =?us-ascii?Q?s7pe0xBugW/ahwp7RyMfuJl5pZq84W0JplQRanZ81C2v5xlma8ttbTEUFs+A?=
 =?us-ascii?Q?21Exxk6tFmYjfoNTJ1fo/vuVpMNE5iLLQNwFFwdLRdKgzD57sMR3EPbJUsFz?=
 =?us-ascii?Q?fQfUjJ38gamVqoChj0RGq3vELUEysoNSi04XPrZrdliBeM3/Zvt5kVNH98jZ?=
 =?us-ascii?Q?W3kFvJafpDyGEILP1IJgeKbMHf1NKbiBnrTLExer1eaIkioyT2RaS78jIFFr?=
 =?us-ascii?Q?cecMg/JK8VXk7SquLQL0Jo+f9iwyq1ix8C5T9RwdUOa7YhncLllRTrVhueX6?=
 =?us-ascii?Q?dBJxEXu3lFyj12qAfFwlKYXh?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57249e71-7f80-46ae-3b3b-08d98e0f75f6
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2021 06:05:30.5764
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cvFXikNa6owza2sHcE3h39UOiI/aHzOl6qJNaCUXgddmwjQbZNLTz3BMbXYeAL1o0MRShlQJoxVib2X0naTJmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5314
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10135 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 suspectscore=0 mlxlogscore=999 bulkscore=0 mlxscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110130041
X-Proofpoint-GUID: ll2FAzjXES_142tN50wYA_G_RMuv7Mby
X-Proofpoint-ORIG-GUID: ll2FAzjXES_142tN50wYA_G_RMuv7Mby
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

btrfs_update_block_group() accounts for the number of bytes allocated or
freed. Argument %alloc specifies whether the call is for alloc or free.
Convert the argument %alloc type from int to bool.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 fs/btrfs/block-group.c | 2 +-
 fs/btrfs/block-group.h | 2 +-
 fs/btrfs/extent-tree.c | 6 +++---
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 46fdef7bbe20..7dba9028c80c 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -3160,7 +3160,7 @@ int btrfs_write_dirty_block_groups(struct btrfs_trans_handle *trans)
 }
 
 int btrfs_update_block_group(struct btrfs_trans_handle *trans,
-			     u64 bytenr, u64 num_bytes, int alloc)
+			     u64 bytenr, u64 num_bytes, bool alloc)
 {
 	struct btrfs_fs_info *info = trans->fs_info;
 	struct btrfs_block_group *cache = NULL;
diff --git a/fs/btrfs/block-group.h b/fs/btrfs/block-group.h
index f751b802b173..07f977d3816c 100644
--- a/fs/btrfs/block-group.h
+++ b/fs/btrfs/block-group.h
@@ -284,7 +284,7 @@ int btrfs_start_dirty_block_groups(struct btrfs_trans_handle *trans);
 int btrfs_write_dirty_block_groups(struct btrfs_trans_handle *trans);
 int btrfs_setup_space_cache(struct btrfs_trans_handle *trans);
 int btrfs_update_block_group(struct btrfs_trans_handle *trans,
-			     u64 bytenr, u64 num_bytes, int alloc);
+			     u64 bytenr, u64 num_bytes, bool alloc);
 int btrfs_add_reserved_bytes(struct btrfs_block_group *cache,
 			     u64 ram_bytes, u64 num_bytes, int delalloc);
 void btrfs_free_reserved_bytes(struct btrfs_block_group *cache,
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index ec5de19f0acd..6e7c03261d78 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -3195,7 +3195,7 @@ static int __btrfs_free_extent(struct btrfs_trans_handle *trans,
 			goto out;
 		}
 
-		ret = btrfs_update_block_group(trans, bytenr, num_bytes, 0);
+		ret = btrfs_update_block_group(trans, bytenr, num_bytes, false);
 		if (ret) {
 			btrfs_abort_transaction(trans, ret);
 			goto out;
@@ -4629,7 +4629,7 @@ static int alloc_reserved_file_extent(struct btrfs_trans_handle *trans,
 	if (ret)
 		return ret;
 
-	ret = btrfs_update_block_group(trans, ins->objectid, ins->offset, 1);
+	ret = btrfs_update_block_group(trans, ins->objectid, ins->offset, true);
 	if (ret) { /* -ENOENT, logic error */
 		btrfs_err(fs_info, "update block group failed for %llu %llu",
 			ins->objectid, ins->offset);
@@ -4718,7 +4718,7 @@ static int alloc_reserved_tree_block(struct btrfs_trans_handle *trans,
 		return ret;
 
 	ret = btrfs_update_block_group(trans, extent_key.objectid,
-				       fs_info->nodesize, 1);
+				       fs_info->nodesize, true);
 	if (ret) { /* -ENOENT, logic error */
 		btrfs_err(fs_info, "update block group failed for %llu %llu",
 			extent_key.objectid, extent_key.offset);
-- 
2.31.1

