Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55FA85700B4
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Jul 2022 13:32:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229942AbiGKLcc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 11 Jul 2022 07:32:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231526AbiGKLcQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 11 Jul 2022 07:32:16 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B0777AC16
        for <linux-btrfs@vger.kernel.org>; Mon, 11 Jul 2022 04:15:07 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26BAkd8E008365;
        Mon, 11 Jul 2022 11:15:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2021-07-09;
 bh=mDEDPwR2cQz17ZrxXzH+OInKwzDVBwYGkx4zTFpDpMM=;
 b=AwAklQP0vKOgbkZ2d933+9/uPCtGsJp9qVjaBwZ9mcMOQfnU+2I/fJKFNPb8Nj6C1Hnf
 m8c6mnKhQiFO4MSUTgpDupuiE3a/cCaqaZb+3Lxi5UKy6oSlWhbQD2cZLKdKThPlHzMv
 PIAYjTCFrPHiNBji45BsRRO00crJbmt8DvbewSae3PRDTbqibzqxVe9n+x6cI/pHCFN5
 Ac3C0NUrV6tuMTRZQgAsNS9XKLWk7Ieem7matBPhwYCB7AKwsJRaFuO9cyi+5pc31hvx
 LzKCpl543FEnvp1PQKltlXdgak5Sok1p7/zUq5wBWCKdw0udF1+kBUPXfBodRVPY2Fgz sA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3h71xrb3qb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Jul 2022 11:15:03 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 26BB5WoS005391;
        Mon, 11 Jul 2022 11:15:02 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2106.outbound.protection.outlook.com [104.47.55.106])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3h70420hes-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Jul 2022 11:15:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MQ+IPhgZYaikagS25YSHaSj2wz81KeM2mpvgg+EtN30S4pNvO43G9aR7ifmt/iA6pkJU+O/eZoMio9VWs1MXG2RhamdusFxsYO0NkilffV8zgjDzeCZSXTXUvhVJfihXmGLHM3Qj7V2c+lSjw+yPmSHxtJIGyjST/gxEcd7gRm2kHGSU14hgo4NtClC7CXIDuu/Naz//X5pnp8/BQDwV14i+dYw2EPyqUZx1YaklYpmdqDMR7ZNJ85CjjBaf262bbc1xXak5hEsyckN5mVVQPwosCuZMkmVH+l3KlfTz74HNv8E8fBFYB/uCZ4mwgBKysLvlwGKLw7tMbfC/E6xL0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mDEDPwR2cQz17ZrxXzH+OInKwzDVBwYGkx4zTFpDpMM=;
 b=TID1bc6GASNlVbuoGulQIUChWboeZLkNhT3yjE8PPKNufT1y616YffejJcSd87U9bnHuVMwfTc5Tz69CtyZrY7pOftzPDVka1lS/WIlF+gH6DJFIWAHPQvH+Cb07khFexqUkkpdkTEk9B5ACX/sySpIkKB1n2MXXVCRehLQSZPFV8Xx27+J/Dtz+IB5FtoovlKtV7kn+DO5jwxieY6XKV/5X0yqE8scjtMyupAu4gv5r11gs6/amdFytldSWGoQ/pSfJiR6tFRUw8/tzYwnM0GJFDU+0lKd7ZTKpzrRgfhnlGbM5NAGs8eq98fwYfAmmkEE42nh2l7z9d787u5570A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mDEDPwR2cQz17ZrxXzH+OInKwzDVBwYGkx4zTFpDpMM=;
 b=beNEkbAMljy+0X3ga56WdDlfAEuIB8HN8pkc0FTjTk9/Tn5QuakovFtN8+Ea2IA7DbwkHE/aKNq85qqEBNhoMETG0tkgb3DlnStWrttAVQtjpINUX8g/nKAWW2rAmHwZho23Q3iCLMQ9bC0ky4Rov21FUthfg+QlsJyqnCM0A8Y=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CH0PR10MB5001.namprd10.prod.outlook.com (2603:10b6:610:c2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.20; Mon, 11 Jul
 2022 11:15:00 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bcb9:f224:ac37:6044]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bcb9:f224:ac37:6044%7]) with mapi id 15.20.5417.016; Mon, 11 Jul 2022
 11:14:59 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.com
Subject: [PATCH 0/2 v2 RFC] device type and create chunk
Date:   Mon, 11 Jul 2022 19:14:50 +0800
Message-Id: <cover.1657275159.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.33.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0157.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::13) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 374804fa-deda-4b67-ddc3-08da632e97ec
X-MS-TrafficTypeDiagnostic: CH0PR10MB5001:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qUXgeMLavwBejOhZuLFT3RaPR4aNk9RXr9jb1GonsmL/35QJF8z71F8t9TRzZ3CIjOjAKC8ZuaWELDQ8TZNcmLXLXEJu0/C1D5GJe2CPTqzq2JaLX+M+kdDzOmH64KhtA1awiXWQCmaiSqyjTagm+ZwFdjDIQrO5p6wtQS4NrPzEAlcnpoqneZPOv1M4mSXXN0K1IFYv+es6eFS1AdVABo9RsNrfx2NkgI25McUB8Tld+CLJTr0hHjiFIsymlvSdko6pZM6HvaMNeLrJrJX8WtGqN9mO92wpTv8G7JzwBnhMp4bQWR7I3QsfLPF8mnX6ytJeMZK+N9tDFxr4bKsXy/E9ZWORCSBM0P3nh6JYt1s47J24tr/Ul76kJSill/Pa0qISfNgsY+4cMjx5Ibx8RhOXMzGCoROR6KchjVNQYWCDjZ4w2fscFxXvYisNuVM+ZceBqyPo8TOzQCMUbWPG3fBEpMoz1q4JeeGU132HvK90cSRAoTyfDzHzabdORuOSv6w5VlvEatEgobBHw1tQZ4F5xEH89J4DYey7St36o7aF7wviIYIrh0bFskg57EkbCkD3GY+JwUTtoubjSXlCl4t+nyGxOcJu1eCAcq72n87sBLWDj3laNXZ3PF+At9x3wGxy4oBv6RPPdWb00CQJ0lGUbGGwuLBvnd6s2sxubsHur9dzf/VBS8Dg51BN/bXLSwEjkG7gCQDXObNQ2ql9KGxNB1j3Rr8S5A3sY3Rq5sDWW0NAU3y36dJF+sE1LRZyD3odMibar8rsegOOM6RBGA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(376002)(136003)(39860400002)(396003)(366004)(66556008)(478600001)(41300700001)(6666004)(8676002)(2906002)(66476007)(966005)(36756003)(6916009)(86362001)(4326008)(6512007)(66946007)(6506007)(26005)(316002)(6486002)(83380400001)(38100700002)(2616005)(5660300002)(44832011)(8936002)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bow01XIJqh7QsC2BZD06dfhJRlujJLgbDC4n2nqn6eW1HcLoXPvdc5l2C7n6?=
 =?us-ascii?Q?qbeOLTQUp0n5ORdqNsentXZHtDfode5Im8g+0IleGErHAWM1jCkNbI8Fx8wT?=
 =?us-ascii?Q?zmYG4x6ZOFZ5BmEmgr9e6Zj7LjJ/x1FYOetz/HSvzhjBBrMBbr3UKX2n9IgI?=
 =?us-ascii?Q?CimtWeZwWZYG8VVIjziQRuOET8Gsk36pw4E91aKYXYyYChkbdfNOQagrFu8L?=
 =?us-ascii?Q?g9HjBGdKhmz2AwYuVp/6LExF9XVU7R/uwyEV/fuJObOCWQM41f7HuRUwKf5I?=
 =?us-ascii?Q?89z3D1lMcHyrKfKL69iVYF8Pqs3J1mqSVq3rcfFzYAWyFV0RKigo6nNKlj4a?=
 =?us-ascii?Q?Y0BTA0upxAR5HRfTgFg9rZEBkpnNseGb0mI92RJBVkRZFyeUIQLo3CQZ+5/M?=
 =?us-ascii?Q?KYhK6r3GYbCk9vez7lzRTUHOZZ2gUxlFhsjxEgp5XsQlQ4HmemWM7XAoH5wj?=
 =?us-ascii?Q?XlZOg4TFfXizzS+piOscj4CzlRShlQr3LiSeajPe9xsUAqlp5G3VvuGROckM?=
 =?us-ascii?Q?evjxP7Y7z8OKGfZopBAL+vmLaK7DVxNU2bWWoFeI2LY6WKX6g2Y1j+5SkTAo?=
 =?us-ascii?Q?CZPksdhk37JYhblV8LbUgoZQpdGBN66bieOs8H77zroXWnGwraX1yyg08DK6?=
 =?us-ascii?Q?Ii93ayhX7scUDBTVOzZrRJoFoKdqWau+aVOwg+yGAs3GIQE+AqXX5ckoHHQv?=
 =?us-ascii?Q?SlXYRY1A6bKBiqpXI+uCoUCO0ANijwR4kRUIacyCob+IVmyPYidg6Vu1EsyZ?=
 =?us-ascii?Q?RMMQlRl8N6ZM/3rx70P91BNSMYc8S2ngbMsa7ChxSWBYu0pab/6FwJRROdrE?=
 =?us-ascii?Q?l1tBGNgv6DLQGnn7CUfAMSzA5GT2/NTQabESE8ooQE3IuC4ifxFkqghVkcdU?=
 =?us-ascii?Q?9h1lh7iaGDiE/HYs9VfEHK6Pr0rMASkIf6yayJtOF+YRVnu8ggYaqhjLuBL/?=
 =?us-ascii?Q?SWI+clf3615jr/lpVRwQFsBv0mUTN42iMu43LkE+Y8SuM7Cn0+5PhY3gbdyn?=
 =?us-ascii?Q?nrFieOsTjBigs6no1pUqDAGw/2DLf8EL0iyh94dP1lZqbiHYBvcNohpFef+E?=
 =?us-ascii?Q?aDtze25qVoHkHLY17B5Ub9SCjavgO8utu+K33gRKiQofOhAuDMd+R0H97Wp5?=
 =?us-ascii?Q?dvLrBRJKIEaBYZe/Oz2miOAmD2iV5oG8nKdORTR4TSi9fowIDETnX5sM30mj?=
 =?us-ascii?Q?4P9cAXA+8qnqHgvrNXND+CYA8aezjfNsHiD0677o+gy5uwqQbd6HfEIKDki2?=
 =?us-ascii?Q?o5dNe6ZsofvySZIpVreZgwrGB8oEYGWJ+y77vBD09FHQhJPdocYECDE6VDI2?=
 =?us-ascii?Q?2GH7qbsgWUyit1QT2ccW9DOIqjRw2rYuN/pKZjtW4dsRgtiOexq2m0Tyk9lJ?=
 =?us-ascii?Q?jxEamAnB1o8MwDr8qnOZRa8d5pnmYV14UXpkpIYkWBCEAMS9BCA2JJG/ctjC?=
 =?us-ascii?Q?RItkDspWqe1VBBlYlEBeVoUfI+JhZjTeERX6IZ78/rrL/PAq1DR+nkILQiqx?=
 =?us-ascii?Q?1mRV7/G8yaCYwdcJl4MnKDRHIBzzBwM6xTuf9YWcwNrF5L3wodp1Dpg9tK3y?=
 =?us-ascii?Q?39Rt6YRI07cy0AuMI7y+NqBV/tpdAkpUWsLGEV1d?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 374804fa-deda-4b67-ddc3-08da632e97ec
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2022 11:14:59.8147
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uk3KtTXzT+hduWg0QBGDx0hHtYdUqCjy1P2CCpiht1kNMprUwaWUZfF/9NtFdGrm/yN8qrSRHLbbgFEBjkRSVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5001
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-07-11_17:2022-07-08,2022-07-11 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 suspectscore=0 mlxlogscore=999 mlxscore=0 spamscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207110048
X-Proofpoint-GUID: LZkFSdQY_YE5nsJB6exoyf1BXCdgqjjT
X-Proofpoint-ORIG-GUID: LZkFSdQY_YE5nsJB6exoyf1BXCdgqjjT
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

v2: Arrange devices by type and then by free space. Split device type and
     its latency into an enum array. (Kdave)
    Marked RFC to obtain more feedback.

v1: https://lore.kernel.org/linux-btrfs/cover.1642518245.git.anand.jain@oracle.com/t/

-------- original cover letter -----

I had these patches as part of experiments with the readpolicy I am
sending it now. This is different from the allocation_hint mode patch-set
where I use the device type to make the allocation destination automatic.

Patch 1/2 keeps the device's type in the struct btrfs_device so that we
could maintain the status if there are mixed devices in the
filesystem.

And if so, then patch 2/2 shall take care of arranging the disks by the
order of latency so that metadata chunks can pick disk with low latency
and data can pick the disk with higher latency.

By having fewer restrictions and not hard coding the chunk allocation
destination helps to cause the spillover to the available disk space
instead of causing the spurious ENOSPC.

Anand Jain (2):
  btrfs: keep device type in the struct btrfs_device
  btrfs: create chunk device type latency aware

 fs/btrfs/dev-replace.c |   1 +
 fs/btrfs/disk-io.c     |   2 +
 fs/btrfs/volumes.c     | 109 +++++++++++++++++++++++++++++++++++++++--
 fs/btrfs/volumes.h     |  24 ++++++++-
 4 files changed, 129 insertions(+), 7 deletions(-)

-- 
2.33.1

