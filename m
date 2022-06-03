Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CF7853C32F
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Jun 2022 04:14:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240929AbiFCBmw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Jun 2022 21:42:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240992AbiFCBmu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Jun 2022 21:42:50 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E061219022
        for <linux-btrfs@vger.kernel.org>; Thu,  2 Jun 2022 18:42:43 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2531ZEWc019372
        for <linux-btrfs@vger.kernel.org>; Fri, 3 Jun 2022 01:42:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : content-transfer-encoding :
 content-type : mime-version; s=corp-2021-07-09;
 bh=BgHqdKu7Qj72YuW3yMtITpTU9ZSp4MFuyeRA0Kgypa8=;
 b=05atDHx9QPzrq/9pf2/ysbcjenQCkuDvyo0FLGWPijfNo6qbjZtzup7/18dWvifqOs1Z
 ZgoKFKNqaJm5eiQBC2JguERlNwV7XK4Xe88YFhVVcMXKrixi3ZbWg5yYRM1cmIKR0xgO
 j1CYMxKqtN/Zci9GCnAUER3kuB2dCYl7aYqIvhM80tafRS775QlRUSIhTuYZ1ZBQ6ivw
 4KAUrpNeLqT2G5bTGfEusxeygIU6QliAP8AG55d/bzWTu4MLvNiuk9SeOYY8iY1TpntW
 JqTgEf4DiaIsG5rZ6wN4/BnwjKjVQoGP53peNCG73YmUggto72eUQ10X2bK8R5Wtrx9+ lg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gf8rwr07n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Fri, 03 Jun 2022 01:42:43 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 2531fc4n033863
        for <linux-btrfs@vger.kernel.org>; Fri, 3 Jun 2022 01:42:42 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2174.outbound.protection.outlook.com [104.47.56.174])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3gc8k207um-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Fri, 03 Jun 2022 01:42:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L+5/anfkFaLmVGY+2wQFwEeY40lBlq6SLLBPfpfzwakRY4nGFIVoiqUK0ygmHKZD9+MDAiPIvCk5udOMJqnFWf3RUjPTKqTUAL9NI7vaSdpYV89dpz4Em3qzoPsgQgoRKjX2+gzBbv1hyOlmEUk0AXy3RLoq9ZFHYsulJ5l/nO8gJd1IlFP/cVwBe9y1flIGZTkp+DtOHq7DGS/EqC7O2JHfzgWyEnm5EvpqPagsWS/Z/y6xIEPbRkr5RoaynQBd7mzkd+Bn7EkpQb1d+wD1bX7RjnWLYnfWDjXIKcO67COPZq8Sv7YdggIF218wRmeAey9m0+0+MREd4Gcsl2XS1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BgHqdKu7Qj72YuW3yMtITpTU9ZSp4MFuyeRA0Kgypa8=;
 b=Cj4iCG4zJF77PuLpaAM6R0tBUh0PJ9uq/T0cMmFqXZSI2gyctXBMJVtceRjO0w7EwrCihBJlJKWegHsvPrytR9lvIzc8OVZN6pIFH6MUZwvLg+9SR5oTwmhdZxMHzpkYz2DHoTc/0vSb1dLisvMD/D9190ZhRYemjn7nHfoJ36Iso0xOzl44El1MmvsF+i3k1mJhkXFG7arebwdBe418wkBNSLdams1POo21V6v7sF126P9VR9hIFJCsSlcVJmN1XI3vByZ4nvd4uPqyv69NHt1na0UcNXvJ7vvdcIxoAizXYp0rZrZnrETMkDuXh6QXVZyY5m2A9msUbJFtTxyYlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BgHqdKu7Qj72YuW3yMtITpTU9ZSp4MFuyeRA0Kgypa8=;
 b=x84w1/QVV05XTpjKV20hC6c2qqOLuYoCjrQj86IFzdX328ZHyv7yiOThpsan+fi1KvR8gCzE6IP+AAgEdjVy8Cunw3Dc8IsdJWJzN/t6qRGUeXzZUQ5z4gHnuMyV52c6UVG0fih0JBZQbZog8AxwbiM2AGELpLoqLlcVmNj60WQ=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by DM5PR10MB1530.namprd10.prod.outlook.com (2603:10b6:3:14::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.13; Fri, 3 Jun
 2022 01:42:39 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::138:2847:c75d:b5cf]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::138:2847:c75d:b5cf%3]) with mapi id 15.20.5314.013; Fri, 3 Jun 2022
 01:42:39 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [RESEND PATCH 2/3] btrfs: wrap check for BTRFS_FS_OPEN flag into function
Date:   Fri,  3 Jun 2022 07:12:10 +0530
Message-Id: <8d7f62714e07e97178741f88ba007b91a9151147.1654216941.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1654216941.git.anand.jain@oracle.com>
References: <cover.1654216941.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BM1PR01CA0144.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:68::14) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d8311aa2-39ea-4a75-4150-08da450257ab
X-MS-TrafficTypeDiagnostic: DM5PR10MB1530:EE_
X-Microsoft-Antispam-PRVS: <DM5PR10MB1530F419C22F3966406D8C45E5A19@DM5PR10MB1530.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CSxe0+A2HGrLww1U5y4UMN21TO1GnnUyBAW1Ak7nm5p9k3MvB2NnFlFIxuy5uosjwymOcjShqkJTVW4D93M/Mb+Rda5og1f8KS2gGhVn9W7qUrRnhbgYvBQRW8hn55DAmQg3+BqLOMF/O4/9nJBkXt/+stfpt5SzaX7qkpU9Aq4Vtj5EJHs8wN43COgXSjsq2/9x//aXxTozQXRqeVFafD6dO54mOd7YCqxxZISNdES7WGHSeEnkga2sBfshquumBaRVzbD0e1/jM4xF5zakPjiQvah+3yngSBYDI+7Z4wy1Dv9YDsczOekVnWWO+5+JoyYBx4NwhgcEle7+CG2QAhau9UdUaR4hKGa3FVVfwH7IB/EOLACYDUm3v5l7knfL9YuqqbdbS75B0wT28r3i+zC9gJBYFNPio4Lnr+7mrwvyg3UxgX1ETzXpIqqf6rJhAzepgmzm1SSfGJC7JncCquLTkyFSs9tClGHe0o/SNSkSudn7TiI4egpTQTd/iKJoPVxeSN6rEhKEXY0HGNCKbrXJmQmK+/+PFgxTP/+OYIKRLu6S/MtubTFVG54uvIhhGW7L/oAVUaHbbDXkRyelzxInL3cho0q3tz1jRdPjuS2PoQsNVjLg9r0SFbHF4ma/4ZNckmZaCHlO7m0etF1oCw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2616005)(83380400001)(26005)(66946007)(66476007)(36756003)(8676002)(186003)(316002)(66556008)(508600001)(6506007)(2906002)(86362001)(6512007)(44832011)(6666004)(38100700002)(8936002)(6486002)(5660300002)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7xkhAtNmzLE9fcC4WShnN+zmvwnailTjzGRdC+nR8wPgjo1iw/05KCfKanlw?=
 =?us-ascii?Q?NHFG2aStiVmwdoLYKr8yuX6BRpte/uKIVRgwph6B6OHYv3/NnCeDFzSnOOK0?=
 =?us-ascii?Q?gcEPgoSwIablH6bYiF6Ri1GjXVSBOsP6w3LakCCCtqq05DFXVgB98JfiJFxj?=
 =?us-ascii?Q?rX6wuQwiCg+w3swKpBStBDSBCOrY0xDOTHW14sYIwPO683Xc5T5VyNBY7Pt2?=
 =?us-ascii?Q?3ag9b3QN47FXGuEsD6qwfzNJO0Ro6Ea7lnWZMOkHsC+n0mIO+Wvcmuj0ZIm7?=
 =?us-ascii?Q?aLgJ7yhjaX9FWBaPrb0j1RLYuZAqYaE7OGQ9TvmUEaO6jEduLwHTDNFoFx+z?=
 =?us-ascii?Q?8A7nEgq4xOiHxap7Tbv0vLxZD4rbViE8vg6ps7uIgL9sGUi2uKq10riFnz/O?=
 =?us-ascii?Q?rRpHejvyvmChkx7juPugGE6CArMJBmf+EXcIoIe0nLiC+w+/6rUu94GoW4T0?=
 =?us-ascii?Q?Z859+VpyO17ntgVZbxQHV/hwLnmJ/ZUaBYkL6mqULFpjHcB5xHqHK5uuaIzs?=
 =?us-ascii?Q?tt/gk/KUnIKlfCaTy8+1iIGnfGKrB238ayXLFij2i9VW9QIV6X1CRfdhsXAc?=
 =?us-ascii?Q?gAK5McXlMiLenSLHJ0DgYImPgVMbmk5M1lYxXf1RMnQ9ZlNOUCVXlKiG3P8i?=
 =?us-ascii?Q?W9Ej/qK93OyfuzwsRPlWj0kHzZFeg9PVfn6QLePaP2w264yIbQK/IC/2yq/6?=
 =?us-ascii?Q?qmrObXP9cTtFxpy0cyhyf99Glr89r3PqzIz6l1Db5AYCK08Tf4TYCt1Hr5qf?=
 =?us-ascii?Q?3i9MyPzRtaMF77hj3GOq88vzO1BIRPZSxMJlU9eH7c3zZDuBdbgzwe+py7Sl?=
 =?us-ascii?Q?e/FxtDdtPWRsI8AfmUR/VlvNF2P3UlbAx6rdouDir5Q/QbZ7+pkyI39/eNWi?=
 =?us-ascii?Q?tLo63ON9uaa+OtucRZBr9eTeKzugLcBC+BdLzn1exFTeHFOLji/MJndqbe63?=
 =?us-ascii?Q?gMhc1LmRtG4NNr+sdCDrE1ZgDU8CkMP5+XAQ58UYuNf9FgjDSTpGETCBOpTh?=
 =?us-ascii?Q?kWHs4SeteQ/GmS6Wx/aTD8NwlkRoNriQgmaEefHZDRYqO+m7Lf6sJxsHL2Ep?=
 =?us-ascii?Q?sCTt2wzeaRDnfKpObJ2m1X6CAVJtGw8wJbYks9l5fu1fM/fU0wTAS2YSLSMZ?=
 =?us-ascii?Q?/BE5zBNRteub5l1ZZRB2Oqh9+gIVqlrOXKWa4c9x+ZnYPeSH1BrAn42coWxa?=
 =?us-ascii?Q?yFc+3e7C886U3t59+08PV4K2/ywp8yYBThtIPUy1XyMPT1wWE0UzlOA6RSHa?=
 =?us-ascii?Q?qFouDVX5jX6ixsmTK4HYIXkJmdlZh0++Q44murXFAK8GC7BW287f7ro4AKt8?=
 =?us-ascii?Q?6KjpEkO9zLHSlB2Ed+mpxr4/H9gQAgr/6FHqbvOv4zP8i/2opOO+/bc3k7Lq?=
 =?us-ascii?Q?GZbAh+QEXngqwmyAY2x1XHIWWBzbVJxNZM7mKQ1nHtJibK9+vOjFavIXeq3q?=
 =?us-ascii?Q?aub9PLH/DX5Pnv31Rewlwv7URbxfKZwSaRTwHO1+NSUQ+fwXNyddsiltWp+c?=
 =?us-ascii?Q?ZPc8m5FufKJoK1hy7pyl2SRY9sDpn/BxW8OQigDsGdkEif0oqfxuO4ZiRigP?=
 =?us-ascii?Q?Lkgn2pIbJLn2Ne41F3ZVz4TqFHFaDYNqmpNpvpfHE5+hAbQvYjG0vhv8eqYi?=
 =?us-ascii?Q?nUr7QgTHxm5gcgonbd4NKIy9LlkCUJlEQleKSgZuTRhwNP6meCa/oBfUOnPv?=
 =?us-ascii?Q?zuYFZ7evQRTe8VPELk2kMzoOCCAYgSaWobnryrlcPc0Fck+uPXarigHmd/QV?=
 =?us-ascii?Q?I8wFiAc9+A=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8311aa2-39ea-4a75-4150-08da450257ab
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2022 01:42:39.4750
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R08DnGSdiGiqy/l4m5h3/kPA/ZQYJParAn4BduGIlmW6sG97Om1D3Uc0zBYtzCQJ1oXsj4/hRXPapUqZPIyPrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR10MB1530
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.874
 definitions=2022-06-03_01:2022-06-02,2022-06-03 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 spamscore=0 phishscore=0 malwarescore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206030006
X-Proofpoint-GUID: P_TI1cr5_qz6qnb-yIppeW3pbOAkrdIX
X-Proofpoint-ORIG-GUID: P_TI1cr5_qz6qnb-yIppeW3pbOAkrdIX
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

2nd patch in preparation to make the BTRFS_FS_OPEN flag work irrespective
of the type of mount (rdonly or read-write-able). Bring the check for the
BTRFS_FS_OPEN flag into an inline function btrfs_fs_state_is_open_rw().

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 fs/btrfs/block-group.c | 4 ++--
 fs/btrfs/ctree.h       | 5 +++++
 fs/btrfs/disk-io.c     | 2 +-
 fs/btrfs/volumes.c     | 2 +-
 4 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 8f73dc120290..bdb4007ba15f 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -1313,7 +1313,7 @@ void btrfs_delete_unused_bgs(struct btrfs_fs_info *fs_info)
 	const bool async_trim_enabled = btrfs_test_opt(fs_info, DISCARD_ASYNC);
 	int ret = 0;
 
-	if (!test_bit(BTRFS_FS_OPEN, &fs_info->flags))
+	if (!btrfs_fs_state_is_open_rw(fs_info))
 		return;
 
 	/*
@@ -1552,7 +1552,7 @@ void btrfs_reclaim_bgs_work(struct work_struct *work)
 	struct btrfs_block_group *bg;
 	struct btrfs_space_info *space_info;
 
-	if (!test_bit(BTRFS_FS_OPEN, &fs_info->flags))
+	if (!btrfs_fs_state_is_open_rw(fs_info))
 		return;
 
 	if (!btrfs_should_reclaim(fs_info))
diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 171dd25def8b..1a77a0123c44 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -4039,6 +4039,11 @@ static inline bool btrfs_is_data_reloc_root(const struct btrfs_root *root)
 	return root->root_key.objectid == BTRFS_DATA_RELOC_TREE_OBJECTID;
 }
 
+static inline bool btrfs_fs_state_is_open_rw(const struct btrfs_fs_info *fs_info)
+{
+	return test_bit(BTRFS_FS_OPEN, &fs_info->flags);
+}
+
 /*
  * We use page status Private2 to indicate there is an ordered extent with
  * unfinished IO.
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 624070f144d0..e25e0104a9f0 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -1984,7 +1984,7 @@ static int cleaner_kthread(void *arg)
 		 * Do not do anything if we might cause open_ctree() to block
 		 * before we have finished mounting the filesystem.
 		 */
-		if (!test_bit(BTRFS_FS_OPEN, &fs_info->flags))
+		if (!btrfs_fs_state_is_open_rw(fs_info))
 			goto sleep;
 
 		if (!mutex_trylock(&fs_info->cleaner_mutex))
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 35b6b87464f7..a06a35dc8156 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -7610,7 +7610,7 @@ int btrfs_read_chunk_tree(struct btrfs_fs_info *fs_info)
 	 * and at this point there can't be any concurrent task modifying the
 	 * chunk tree, to keep it simple, just skip locking on the chunk tree.
 	 */
-	ASSERT(!test_bit(BTRFS_FS_OPEN, &fs_info->flags));
+	ASSERT(!btrfs_fs_state_is_open_rw(fs_info));
 	path->skip_locking = 1;
 
 	/*
-- 
2.33.1

