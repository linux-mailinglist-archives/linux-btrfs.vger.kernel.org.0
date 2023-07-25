Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A38F760CE5
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Jul 2023 10:25:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbjGYIZ2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 25 Jul 2023 04:25:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjGYIZ0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 25 Jul 2023 04:25:26 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A946E66
        for <linux-btrfs@vger.kernel.org>; Tue, 25 Jul 2023 01:25:25 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36P7oZ7p026565
        for <linux-btrfs@vger.kernel.org>; Tue, 25 Jul 2023 08:25:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : content-transfer-encoding :
 content-type : mime-version; s=corp-2023-03-30;
 bh=hMU55l4NWqOa/I/9JS2t2xTJlmX/6PRPJarAMJkOK8k=;
 b=e9Ft6zgGMXC3ZISGxFr4EUSjCdFJlPbKw3EJa30E9nejY0vwBsw6NHYA+NTcCuBl4OSk
 mrxFtbY4nS7tAT8HsseX0qWe795z1qzjRuLRmHg4bfZ7NlxE3m1hWvYM5tLr4ZcOpnNa
 8MhR1jUoTaCLigUwtUElaKLItDMdI4joQUI30FLcwHGptP/n70HfulJ+k5PbD1wgya86
 Cn2OSvUECYbadlhS0eDp+I1/W6Pepdv79rZOWLFo5DFVDKTDblh1RTqZ8DwmuBFXOS8g
 h+eodZh66cRboLCofyYXvQo34bMM5FKL51Vue9x7tK5cKOLSNTFfvQu8QM7X/yt/x3mC /Q== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s070avh0x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Tue, 25 Jul 2023 08:25:25 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36P8IWfo035501
        for <linux-btrfs@vger.kernel.org>; Tue, 25 Jul 2023 08:25:24 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3s05j4f1h9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Tue, 25 Jul 2023 08:25:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZAc2K8yPaLQPfEP8sGFmL5H3G9RDITvgW0hAfxOo0f+1iYoE34l8W3PGFVKt6VHFVDJStPo9xWptv5Af7zK8p4lT5ER86hXkEvJ5fQ5IA1M8XdCtbWATfoKPmsv7ppLcKP/sZT5Ntw894MZsrDgu31sbyJp16EKviYDlLovsOj9qPE/t43i3hpXywvhV0M4ty5FgAmsCi4k82KwFPuZI8nIcx/k28bVSNS8jxwNEA+pwqaxmTz2b/EFujn65DW6MSMARMiQnn6cVpdrd6mGCA7S3cA5IzA7IeV47Msy6ttfW8S6vZnntVBkmY/lUR1AhrnqHsEpTNVc9yJOCnmuBHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hMU55l4NWqOa/I/9JS2t2xTJlmX/6PRPJarAMJkOK8k=;
 b=Wf5b1grvrVa61AWo0Rr12wXsPJkItR0z2fGNCxnsGeUHrGdk51jyp03JFyam1Ky3Zlsh7bCjWw7rwnsFNmRuRCB+iV5ATNaDY/7JQO7iczQMHC7yndFhsG4q9VxoqtkdtDqP8ETiXx5iAYJbqkujenDQ4gDYwUeXzKxM/gLLiUASd29C4JR124pfoZKPPMY4F9Z708j+ocqyQ+7kU1HXdM5Z1J7KwvXUQkUivx/iE40IuvvQCW/2K73F3Hfm2CA/5twzkReZ0sroe1ZbBLm/9ty+ZgCObVxdXNoDBjAgciwQtpUc8O504+Fm62WC765fSxQJdJ12DtqVbZL56zLMQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hMU55l4NWqOa/I/9JS2t2xTJlmX/6PRPJarAMJkOK8k=;
 b=uoXlDcq00nPPwXhFcb4h8kksjUCMf0+BvPpSDkN1jRd7MV/IdHrFR/9sf4RRQo6fBndXT6AHYenuQXMoVp7g8GLCmFpFJnzAbIzWixvzVBhHDr1rwISl5v+BOe3QZKqfEJeCdj6PBGMX+UPZpP+fZx+kEWsinDvYo79qO6WMLjc=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by MW5PR10MB5876.namprd10.prod.outlook.com (2603:10b6:303:190::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.31; Tue, 25 Jul
 2023 08:25:22 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::b3cb:e0d9:ef96:aa56]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::b3cb:e0d9:ef96:aa56%4]) with mapi id 15.20.6609.032; Tue, 25 Jul 2023
 08:25:22 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 1/2] btrfs-progs: dump-super print actual metadata_uuid value
Date:   Tue, 25 Jul 2023 16:24:13 +0800
Message-Id: <fb866ae05c7694093f3ba60e7aee39779cd3630a.1689841911.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
In-Reply-To: <cover.1689841911.git.anand.jain@oracle.com>
References: <cover.1689841911.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGBP274CA0021.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::33)
 To PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|MW5PR10MB5876:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e8e5819-70a7-4d0e-ce28-08db8ce8b06f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zY+KcL8O1kf/fRFmVMCK+EsRLQ8T8r+pJpMMhRqSgtmLbkSlAejxKWdPwfV0kw9IdZwf9KytNj642Zq3M/JRxzP27rAPvooAg9ZNUP5hwja4ymXYFyyJwDohfKtusHpW2WjaR8SNtMsJkxzcXUI1cKeZe3f3yS3GEFi6NGj6OmOf4+Sq8PDIKAQZPNRWLxzVhddz1mwFJj1eOcLk0Xw96iJ4t+Oqc9RkGOHkoEEpQa2/aOf6Z3h7mcEzC4opneO69+pj5ZyDZO+m3l2F3rXn0THy8PX+kPuiOEB6IP5IUeLzUvC7m7x3fE89ItgservQm9O/mhPOor51JibOmGow9RNJPyMrvCyXhzLMowIIBRSwuyzPhVsFGWjppxMGjv/JhhBSXt/RsUulhmNMhNQV1I3UKqsXzc3mmlAE60laIL2N4r0sv9XG5boW6f8HPLWiubTdb4F+pDpG5aQxzULjbmUuMB2sGHJf7BnlxwoDdy4e98QlR0fOlxuYFr74WGcMvJk267kJx5ttsgKPS3mcwqZ2D4C3M8KxdSHUOWHPcwwjluMMr4+pI2R20RiHn9O2
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(376002)(396003)(366004)(136003)(346002)(451199021)(5660300002)(8676002)(44832011)(8936002)(316002)(41300700001)(2906002)(478600001)(6512007)(6486002)(6666004)(26005)(6506007)(186003)(2616005)(66556008)(66476007)(66946007)(6916009)(38100700002)(83380400001)(36756003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KJiCUj6ZdyynjWXbD1BZsC6kIcskOEAk5SpOS3dJZ3BLqaOvLwCWxRIxm42C?=
 =?us-ascii?Q?xEiJf2SpAL162RXtOWPK4yuE1vC9igStnbFOrtCj/YTlkgcNs0uaIsL/gjyl?=
 =?us-ascii?Q?d8e543yneMFtATmeO96dSWD6ulNSdAO9kZ3pxWeyuCs/kYNK9xOydBPAsiVn?=
 =?us-ascii?Q?a0jQV0Nr6qTJSTPmndM2XRFTvZSNXE0lmFA2dlIs6UO9uC/RwjufA6ByNS6h?=
 =?us-ascii?Q?O9Lb7nqgTuM0MkeCLtkRnGwo7uAO7MrgkoD6elUI7S8P7eAuqzvmqSpNXmrg?=
 =?us-ascii?Q?LEDRq4pUNBBysjTjNbncBMi/HbGQjiq3/4xS5XVV1xFz0ZRL8FoMaYtOf1+H?=
 =?us-ascii?Q?2MAVD9SZJk0SvtC8QK6EOimuFfs2ghHXma80uFLtsHvR2wbGyHgkrCPOyfbL?=
 =?us-ascii?Q?SF81BJKXiUjua7dGv+W4tXl0cuvO9ICoc58GMNtaSd8jhFeTuUqp82HjHzY9?=
 =?us-ascii?Q?8y7ZXh+CBRAMfmQvJ9NJvBCgmlMnSweJfsOP/T3pXUDSwYapR+6u7PKhCOi5?=
 =?us-ascii?Q?u2mxTietPceO0wsHX8I2syjAZTgUKXjghBJHo4IvF9wNBVliI4Exrn4YYl+q?=
 =?us-ascii?Q?iHUaydk60FHugdLiuyr+QSzPsq7xBQ488aqtIz5GTz8yrG1zlMqO0wN4qD+7?=
 =?us-ascii?Q?wZsTXMXsOm7wYIixZp04kKzQA1Sbn4RUx5XOGfFn6vDPd8FxJA7pMnFEc/4L?=
 =?us-ascii?Q?JNzjs85ORlGOQR4m691a4IfLAbWwURr12TgXYSV1P1LExhZMWnij/QWeTchV?=
 =?us-ascii?Q?ADYG6yFi1/wM45BDiKckXCtp5veFwFnRwkZM4yKbfRlNru8hHG0s4TloPpRb?=
 =?us-ascii?Q?Lwp80/80E+WW9u5Wom2z5sMi0HuhZlSPGI1L9PrVbKQkLGqt8luXK3HeQCAt?=
 =?us-ascii?Q?9iz0GDbm83JQfDwzA7Ex+NQHcv859FNgAYoTN6XotGruv/dq7JrVw1lFkFYd?=
 =?us-ascii?Q?iNY3PF4Twj9Sk3O3/VuETNkpVVtsnFO4tXeIw+fkscB0WQp01cuJAWS/lL3k?=
 =?us-ascii?Q?9eBULPsA8jNTjWq4G8ZzPG/lb0R8WYGKnNtflEu1hhVjEzQ5LUbUgEwkX4Ya?=
 =?us-ascii?Q?zGFRegn6WMU36cdA73zTLFJMh31gTu8UqgxQ7Pau2RlU+qXbjTumkRlptIJ8?=
 =?us-ascii?Q?yaBx39YkG0amfPMWlS19DF3B0G8wUx1ZZAwog74lhLP3rt0PxPLLWY/8xJO0?=
 =?us-ascii?Q?oJqA1QnS0NGM9bt/oFAUsGSy4bsomH9M3Cxf1XOnm5yL80VDwMF66vxlB6G4?=
 =?us-ascii?Q?LqUI/QMxM0RVD9p2Im95/05Vban1zrTaMre0JmVl3yjZzH3G6MEl1UTcioxo?=
 =?us-ascii?Q?8ajjYfLDrM51sY68b5QvLvNklkZeQiwPng7HX3alRRnlPUICkBpgSf3w3cgC?=
 =?us-ascii?Q?uGTF1WHuTzFPhNBGG3IuYUzd5sLDGzqpJHmnQtpBqhPmVnpVSHyesCWcDvrW?=
 =?us-ascii?Q?huUKN4xxCsjeCZPsFj9sUvdHlPfAg69FkITpF3oyRyVX/deqKt/EJgs8wd/3?=
 =?us-ascii?Q?DXJMIsWT4yqrsZotG1IkH+AO3eag6d87LSZx+vuLfdl1JD+yHr6w04RmS2l7?=
 =?us-ascii?Q?/lIolIxBpMh5aXOomaGdCPgIJmR6yWsoH2yzS4rq?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: EI1fOm/UDqA+YfGnApP0OD8yU6th4AuLSrYuM6pAe3vxfEu3uHeUk44z8zjxc8soKSwDcYiVWVgkqhaY//ZEq+B+3aCvM1ghR97lcXYqupB1tmmrhg4k1LdFGqP2hO2SsLWDEdyxKksVj+ISIFPSr6r9S/xYb0CYCtPaeBA+H7hXtWEY2wkSK/GkB0RWsofswnEMtLDC/hjLckL/dmamPn30C/vthrS8N6bM2IuUFA8Ay65F5VAkqh6HUkdAha7R0R48yo1ti3YDbNad1OyvFv2w6ItAzwdBtca3NrWsKG2mRwKLsPSX/n1DB4fQ3mYBxtoyl2M2FFstgfpTaWMdwh2U0mk37PH5CN5kvvbvxDEGSGdnMCWn6uDBffWhKXEJhCkwc3YCIwXn+d5mO5vGvg/BPUS/bXv6viYI5hy2YQJbi7vkR669ttBOS4S/vI0XawL3ulA6gpgX08L8x/7mIvxL2/TDIU79wM2Tzi6ujFNd3fJl2XjHkDsQBBaoGAVC2DP1/vCqWsksJj9IRTc3nHqq8gofxsSBTV6xJxGz2NzFtdPVQgx78EPl8w/FNIMlt9fq0M3Vn+8Ah1HcXSlCZUziAY7voN/Gpt39eJs3BJahpwjGCHiQ8noMQZys7gPvwh8niZEygj3gANd/4P8fPLP/iG2NTy2XkaIfDxgC0Ezn8c1o1da2LgjeeDOVrFFVqy5jYc2mYLJPzZPqP09m62DGvJJY3TwkZg5XpYB+L+up/OyZIGqDy/3myha84UuB5Cc3XtvqsZEy6mtrT81oBA==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e8e5819-70a7-4d0e-ce28-08db8ce8b06f
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2023 08:25:22.6751
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Nz16t/u/Xw7uKz6MLvBHMKosav6U506rZOQ7PvnGmi9rIMpIs0WKAIhXNpwizIHYdFKmA29+RtIsWqGPCFAWRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5876
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-25_04,2023-07-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 adultscore=0
 phishscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307250073
X-Proofpoint-GUID: jLRiaQQGopP8g2ee4pKwO_0A1rMkNpA5
X-Proofpoint-ORIG-GUID: jLRiaQQGopP8g2ee4pKwO_0A1rMkNpA5
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The function btrfs_print_superblock() prints all members of the
superblock as they are, except for the superblock::metadata_uuid.
If the METADATA_UUID flag is unset, it prints the fsid instead of
zero as in the superblock::metadata_uuid.

Perhaps this was done because to match with the kernel
btrfs_fs_devices::metadata_uuid value as it also sets fsid if
METADATA_UUID flag is unset.

However, the actual superblock::metadata_uuid is always zero if the
METADATA_UUID flag is unset. Just to mention the kernel does not alter
the superblock::metadata_uuid value any time.

The dump-super printing fsid instead of zero, is confusing because we
generally expect dump_super to print the superblock value in the raw
formet without modification.

Fix this by printing the actual metadata_uuid value instead of fsid.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 kernel-shared/print-tree.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/kernel-shared/print-tree.c b/kernel-shared/print-tree.c
index 0f7f7b72f96a..d7ffeccd1e89 100644
--- a/kernel-shared/print-tree.c
+++ b/kernel-shared/print-tree.c
@@ -2005,12 +2005,8 @@ void btrfs_print_superblock(struct btrfs_super_block *sb, int full)
 
 	uuid_unparse(sb->fsid, buf);
 	printf("fsid\t\t\t%s\n", buf);
-	if (metadata_uuid_present) {
-		uuid_unparse(sb->metadata_uuid, buf);
-		printf("metadata_uuid\t\t%s\n", buf);
-	} else {
-		printf("metadata_uuid\t\t%s\n", buf);
-	}
+	uuid_unparse(sb->metadata_uuid, buf);
+	printf("metadata_uuid\t\t%s\n", buf);
 
 	printf("label\t\t\t");
 	s = sb->label;
-- 
2.39.3

