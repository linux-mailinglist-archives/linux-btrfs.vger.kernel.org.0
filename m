Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 637176E3120
	for <lists+linux-btrfs@lfdr.de>; Sat, 15 Apr 2023 13:33:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbjDOLd1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 15 Apr 2023 07:33:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjDOLd0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 15 Apr 2023 07:33:26 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D94144BA
        for <linux-btrfs@vger.kernel.org>; Sat, 15 Apr 2023 04:33:23 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33F77shn031523
        for <linux-btrfs@vger.kernel.org>; Sat, 15 Apr 2023 11:33:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-03-30;
 bh=5jP4+jDFxODyBCdvaB/hJITBkdTHcOaCMCwoES8c8QM=;
 b=lvhFfhmRzzHHd2yhyHko/D2ONrLJ5heo4J3EjfkdJBnDoz49gQGatJ/TzLiGTTN5A64I
 XIg5UzBW4Z/ZWZWlVYixYR8ZiztbyNl+PzmXama/r5F7sUJX9ddiwT2rR89EKHIFBJDM
 Oj+WpWVPhKpSd1vOhw30S3avpnB12TKy2hl03tPi90rlURHan8Mj2aht8KJufm9JXkVW
 n9tNTaJ79hwey39DqG1PAjJjU2/7bdZQo9h3BQolvr0r9/Y2JfPt/LaCNpZozV0SjC3H
 HTuW/PALgt97Ncn/6+Mwq5pMDwwlyLGyr8x2SwEgauquCEnvivWW0bkAXaJ29GRy7AIU DA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pyjuc0fw8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Sat, 15 Apr 2023 11:33:23 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 33F80Mvw009604
        for <linux-btrfs@vger.kernel.org>; Sat, 15 Apr 2023 11:33:21 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2171.outbound.protection.outlook.com [104.47.55.171])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3pyjc8hfa7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Sat, 15 Apr 2023 11:33:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kxlWX7e6cOr2QHDMAQE1YcY7UGgLbSnuIUu+jIUi40qmAIS2+qSKrky2LPQMYxoyOzoLLddhaAOktWLSuY5FjpsZuVqtk1VN9TMJ9k3Qz7RZDAgSV8bFTds4DySZ9PzeEcfsRcVHSKYIu6fW5nCBs/0UVH4e3UqlZlXDOFiWztusuOPEUQctVeS/qwau6GqdrYG4LPupz8eDiR/pXTxUKQEMfOPy3Nw1iF9vAAGln8wK2lktKn07BG2IrgnDvhoPZXaSFpV8VT16lM9gHwHoZWwOV8TZdQgC1wcjNmrPqjLH5p28kclFuB5E8xXgdXYufir5BcJ3TSf2w0jN5zo/fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5jP4+jDFxODyBCdvaB/hJITBkdTHcOaCMCwoES8c8QM=;
 b=XETR7STmG8z8wN+jk+2BKeSCYzltszZLptcA0DLcDVhCIlKDo/AUoYpLvw2pPo047EyN/7bFhHHIKuIr6qi4OK3Scl1psFF1Hek2C14hDel1ZEUsZaQ2US9QWAWbcF8z222YeGuBTSAPdvJmBYsXiIYtsUmch9bvdPqd0zr1jIpztZV9slPFZUjHI66Y/+Q+zyUmlpOPKAGh7Y4qnFhHnzgSqpHZU7fot1WHaxtdzOKnlwWuABj/YaUzwWAjX7LqI6yFYnuoswLDi9xy9OpUmOGUu7QZtiUo5CSU1du2m8NG8SlCG3OKsMFYmBhEDn3bcGPR/qb5RzMliwBTRKRi1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5jP4+jDFxODyBCdvaB/hJITBkdTHcOaCMCwoES8c8QM=;
 b=S3f7ppAXSMVfKtflAdP1nVCRLpSs/Mr5zPNdg9kzVkBXFRK3zPDgBiby1uCJBggEEN2IUj58MeTpVih/e8lr+ARZifQ2/1OZygi2Hn9iREgQWEDbzoN8lTjKF1+CTPoZ3OEcxnN4TqQ/s8VixhK5NmW6aDeTjucntQokR+HPAQw=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by BLAPR10MB5185.namprd10.prod.outlook.com (2603:10b6:208:328::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Sat, 15 Apr
 2023 11:32:59 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e%6]) with mapi id 15.20.6277.038; Sat, 15 Apr 2023
 11:32:59 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Anand Jain <anand.jain@oracle.com>
Subject: [PATCH] btrfs: use SECTOR_SHIFT to convert lba to phys
Date:   Sat, 15 Apr 2023 19:32:38 +0800
Message-Id: <cdef73bfb8c39d3c45cb7af6479499e2473c669a.1681556598.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA0PR01CA0083.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ae::9) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|BLAPR10MB5185:EE_
X-MS-Office365-Filtering-Correlation-Id: c5898b1d-4560-4c36-4d48-08db3da529cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hiCoqCmXPtBLeyA8ExgOQ5m8b4RUI8FfPllsXt80PcZJP/w5bqeEwHyonR9qDbgHAci+rQqZKjTl4qh8ysREaRL7SFB/JMN3BHsiDpmLW62eXfUhf0305ZGPc5IEpzhJHLkghLcyqJyZm2CCPW3s1h5j0PHYPHTmbaLPL2BeFxSAxQClLt52R4O2TO8pnTSE0ofdMiUVA0N5KUfOtrhJxUXNhdBGA3c8N27J0n7bWcJe9NThpElst9eLhfxcu6LMRf3uCuU5fTYc4VnGrI/50TaZ652pI3C6Q+aqu1co8wU/GkxSLsDEduRuj+RZ0uSDbS8ivQp3llbMXuXCoj7G6+mLnxGkIWEXDhIxi36LDdTYJSUKycXCPM20GhRZ+f4Rp6CvWwQ73u0DZYnIsyZGe+rIVTa3vhPXWf01iwNRvanIwpTZehjXKFth8SSuVPycexCqFoS7imjs556wOmzEw1ucvZM/lFc2DpmFDZ0lOS4euxEe4i/Bg2LEOTgDFUDbFuhr0k863yk96eQu87oo2A53Y8R26pqidZeGRsZ3rSz1n1TxBBaXAYlYNeldX8NU
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(39860400002)(396003)(366004)(346002)(136003)(451199021)(2616005)(41300700001)(44832011)(5660300002)(83380400001)(2906002)(38100700002)(6506007)(8676002)(6512007)(8936002)(6486002)(6666004)(66476007)(36756003)(4326008)(6916009)(66946007)(86362001)(66556008)(107886003)(478600001)(316002)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tnWV89UDJYOqh81q8XPI+o8w6N8pgAL1jirQC7GKy+m8FSANgLNU55VWS21i?=
 =?us-ascii?Q?O2rV9dJ1RfwXUSrlqyYn7febA/Jloo1Xhoz4bVUuxMpOj1JBltA/Jb5XKGiG?=
 =?us-ascii?Q?X9evoYP3SK0e6FyQiXLDb+cyvMq/cm/jhf1OHIk3XhGHS2r4Qna+95ktdudM?=
 =?us-ascii?Q?5ZlZu5vmEPXKiyMcPt5YwXG6Yz8Bvcyl23ZXe+lyKaWEgSscLwkN/75SYJFx?=
 =?us-ascii?Q?Zey0IeStCMCnMccRmb1YRt9xL8NydorBvg59Hs0wQbt9Q0ms1THErCOQptki?=
 =?us-ascii?Q?9VW9mIGl4C+8ZPLoeZRvnNTsxeuCi03cBYAOpMp2sn0nhDiKz3ITUiqYxRrN?=
 =?us-ascii?Q?i8O8DV7Q5KWPaSVyCQKQIIirqCNMQzAB6LK8aidSnh+rJc3FjfU+yvklToP2?=
 =?us-ascii?Q?GM+2IsOT+1JEwTvIHG5fc5zguKWUeIOddX8VvofQcwKvwEngaPpLuTmFcCJY?=
 =?us-ascii?Q?K1IJR2me7o/lq8xsLW3lv0D80eR+qgrO9ngE1kRnFbeJTBfXUYFvFHj7Sl60?=
 =?us-ascii?Q?yrASZGg19Lp9/CPmD+dHzSPkfA7tzIy39hpeQXUkfmmkcR6oWevqCI8RT1gR?=
 =?us-ascii?Q?Dj1hS+S28K4p2Sxfbt0fdrwybMeDD1Tv7bF/tds5BsVV0/7DPkijawZXtsTd?=
 =?us-ascii?Q?mIujFB/CSj1jE+TiBD2ciZvJVR3UBvCWRm0/VDYLPXQE+Kso8d0GdRUDIPQd?=
 =?us-ascii?Q?WcD0MHweKXohNpCkNysx6wn/UUYN+dt7370mHzFEqP6nXfWQxZ6TiV+EcGAw?=
 =?us-ascii?Q?ow+Vg04K4YwSrACgN5+MNb2HTi9uIgeHLOq7oKiESA3Lwb/KZCk7GO11a0Bc?=
 =?us-ascii?Q?+A3aIev3gIXhyFVExgjRAmWBLSO5Jc5+e7VUR+REuiiegR964OlCEIWYnW/u?=
 =?us-ascii?Q?CEooijBvqvmmN0SUN4F0yIWU0ThR8cuvqm/iH2AZv3tweDVPiBj1DJU5P456?=
 =?us-ascii?Q?AHg2vWS3+G+XmqUXfYHlwOL6k5sf1pu8h5levyHMHUZ1NF5ttUEN4gLYa7KY?=
 =?us-ascii?Q?U+6EgKD7Nbr7vzYft8n459J4tgpfbNc4o/V6+x3fDo9osdTqCpgAgSj/v+U6?=
 =?us-ascii?Q?VI8Gl7KP9CwA2LcRQJMnbS/nUwiQRsIxyyeSZFyrlGmWYYr+f3HMM5BLkJot?=
 =?us-ascii?Q?JTXLWcXrpS9NKDVWpZh1D56nLhSr78/wC2KUBNu2JDilJyvFHbdUj2sUIxLp?=
 =?us-ascii?Q?ewz3iJiL3rNU0HGrEJfinUqCssaD1N9eaR+wcgOKB48lraAlbPOV5oUGPy2p?=
 =?us-ascii?Q?PwSBWWDyjI5muKsWRnI4YPIcp5pMFpVrxw1MYct672cBoML4vGRA3OmyqB+J?=
 =?us-ascii?Q?yqCuiG0g1D7tpEep4o6pkbkPzgxPb+UH7ztNjLRp+QXI+JTif4kJK/3nKqBY?=
 =?us-ascii?Q?xY9AIDroG67j+lPm8qK0U7cfFYV126GNqXTAJwgf8dmeS/QjdHuc+hysY0Je?=
 =?us-ascii?Q?P3t77EC/8C41fxfHG3mztTncGpgPyUutAHSit/ht75fPWpYMW+WXJBX0HGsn?=
 =?us-ascii?Q?Ikwx9Rt5FdnhgFuWq8yR/DXmLonMReKFrgV/MfP62KCpuHaFXXb/+z9lqqLE?=
 =?us-ascii?Q?sttGJW+S+gl7K4tDNoyfxMksxD1ZS6I1BrwrRm3iMPFem/0tsVW0b45WXYgf?=
 =?us-ascii?Q?NdE/l77G6Zb7iGfSyN6CVpr2Hqog+euwk8BTk6/s1hVzRLE2T660mALfNPej?=
 =?us-ascii?Q?yfzbOw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: yYzHIWqqY6pgWGbJ0FDjT4Z7l15C49gqBdQetrHhEejwJWkVyq1covUBpwX+Q6HaeQnfdDNFzVPw3e2LFa3rZUOVd4fA141qZ/KBis2ZkZwhiRYXCJiCZCsl8NGS1yGObvrASfRzT34u9jSSU4aXeCl9yZEToGMACI2I94i2YakK4tfKpu59NPee4u2mBbqrsCADdSNCg3ymGKbYtU0uYemARzQF1D8GT/CT0i41JuCR6eNY65ic1B+0F+gPagQ2f2Y5H7si2jfG5Ke+hap6tayn1G6nEFLljIo6Z8xyF5oKFxTME5Y8Kp96S0VacJ//ajchpDffM/LLXbRZVce7ppnTtDMEroYgd+d9M4ccU6OF6M6fyUUuEVNbK+2usYZiDCkI7yizPl2e+TQ/japr7yBWoqfxckGW2+EQobP0puCts+wJlgiUDrZOMj9bw+OhlfSOudHcAbH9hc96RWji3CjW7uF21/Yzt0Eb8LZTo+Z+s6SkqlhmKfBmHTZ9ekPVovZTJMoH8e69gb3nN0hN4+mYt76SVMM2zMxgCO8UD8TyEaZz5lbXErIqWlxlppU0MO10gdfw+cbyyjODaljCw7Xb4d48wF1IB/pgCX2K19itm7xdqELXj/6MZqtx5QQBzNyDeCC5eoxDGSLPvdFw/gsON1wmK/bTpme89a9uiIgBsRG9ShB3dLbmCRm2zRxH+Ifr+GueLeJq8Fg6WSsd4G1HOJcoxL5vHtayN5Ufn1LQTpOgXFxkbKO1HJKxrSX+uBX48rOAQkg7VdQCyRTf0Q==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5898b1d-4560-4c36-4d48-08db3da529cd
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2023 11:32:58.5402
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eur/YJrXe1RLvhvyUNqSTp2bJ418E6nqzPipxBKZF7EKPhg7y2Fm415VxsJfGtf4OtKW7DN95D+UzRdJOGZvpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5185
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-15_03,2023-04-14_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 bulkscore=0
 mlxscore=0 mlxlogscore=999 adultscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304150104
X-Proofpoint-GUID: AZY0pqvheHAJe60i-r4hSBkaUmdCO_nh
X-Proofpoint-ORIG-GUID: AZY0pqvheHAJe60i-r4hSBkaUmdCO_nh
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Using SECTOR_SHIFT to convert LBA to physical address makes it more
readable.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 fs/btrfs/bio.c         | 2 +-
 fs/btrfs/extent-tree.c | 4 ++--
 fs/btrfs/file-item.c   | 4 ++--
 fs/btrfs/raid56.c      | 2 +-
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
index 5379c4714905..4b5220509186 100644
--- a/fs/btrfs/bio.c
+++ b/fs/btrfs/bio.c
@@ -635,7 +635,7 @@ static bool btrfs_submit_chunk(struct btrfs_bio *bbio, int mirror_num)
 	struct btrfs_fs_info *fs_info = bbio->fs_info;
 	struct btrfs_bio *orig_bbio = bbio;
 	struct bio *bio = &bbio->bio;
-	u64 logical = bio->bi_iter.bi_sector << 9;
+	u64 logical = bio->bi_iter.bi_sector << SECTOR_SHIFT;
 	u64 length = bio->bi_iter.bi_size;
 	u64 map_length = length;
 	bool use_append = btrfs_use_zone_append(bbio);
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 7e3ee00a5000..678824eaa6a3 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -1208,11 +1208,11 @@ static int btrfs_issue_discard(struct block_device *bdev, u64 start, u64 len,
 {
 	int j, ret = 0;
 	u64 bytes_left, end;
-	u64 aligned_start = ALIGN(start, 1 << 9);
+	u64 aligned_start = ALIGN(start, 1 << SECTOR_SHIFT);
 
 	if (WARN_ON(start != aligned_start)) {
 		len -= aligned_start - start;
-		len = round_down(len, 1 << 9);
+		len = round_down(len, 1 << SECTOR_SHIFT);
 		start = aligned_start;
 	}
 
diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
index 018c711a0bc8..12bc79819fac 100644
--- a/fs/btrfs/file-item.c
+++ b/fs/btrfs/file-item.c
@@ -748,7 +748,7 @@ blk_status_t btrfs_csum_one_bio(struct btrfs_bio *bbio)
 	sums->len = bio->bi_iter.bi_size;
 	INIT_LIST_HEAD(&sums->list);
 
-	sums->bytenr = bio->bi_iter.bi_sector << 9;
+	sums->bytenr = bio->bi_iter.bi_sector << SECTOR_SHIFT;
 	index = 0;
 
 	shash->tfm = fs_info->csum_shash;
@@ -796,7 +796,7 @@ blk_status_t btrfs_csum_one_bio(struct btrfs_bio *bbio)
 				ordered = btrfs_lookup_ordered_extent(inode,
 								offset);
 				ASSERT(ordered); /* Logic error */
-				sums->bytenr = (bio->bi_iter.bi_sector << 9)
+				sums->bytenr = (bio->bi_iter.bi_sector << SECTOR_SHIFT)
 					+ total_bytes;
 				index = 0;
 			}
diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
index 734c65ad281e..c8ed54582cbb 100644
--- a/fs/btrfs/raid56.c
+++ b/fs/btrfs/raid56.c
@@ -1079,7 +1079,7 @@ static int rbio_add_io_sector(struct btrfs_raid_bio *rbio,
 
 	/* see if we can add this page onto our existing bio */
 	if (last) {
-		u64 last_end = last->bi_iter.bi_sector << 9;
+		u64 last_end = last->bi_iter.bi_sector << SECTOR_SHIFT;
 		last_end += last->bi_iter.bi_size;
 
 		/*
-- 
2.31.1

