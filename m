Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EB5175ABA2
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Jul 2023 12:05:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230479AbjGTKFL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 20 Jul 2023 06:05:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbjGTKFK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 20 Jul 2023 06:05:10 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0005AB7
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Jul 2023 03:05:08 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36K94Gs2032453
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Jul 2023 09:04:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-03-30;
 bh=Ejl3Gzs2iD72kUvAdittupk2Pa/bqIz2sxP5a5Sh1tc=;
 b=zeF6bSQ3z/xtpSCFBJof/4b3bisVcPdKFDy7nRsmYZUze8LIauVsswMfuCvBhtff88up
 aAEtm5ADK90hJHMBjAq4OJyXbAh+zAVVM4JGgILg01buiYBNAeJARGIztuEEaUZpr/py
 XTflZW8mPNpYJ9mISGewe/S4gxlEA49lG+zQlEf+/33CA6XVlWkZIvI+GR2NZQ6Bx23M
 X7bnrNAyQwWyfqkPpMyc8ktGQO6oJaUe0bOEH/MwaFFM0Ad31JZdSoDUUDhJf0/BUK0Z
 TSgX6B6KwSb1da3R55iXMxVuglZ0x2adX/TF9MR883GrypL0cXWy0NczCqijfP7XrWhx yA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3run8a9b7p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Jul 2023 09:04:16 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36K7qREP038249
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Jul 2023 09:04:08 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2104.outbound.protection.outlook.com [104.47.58.104])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ruhw8b4g4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Jul 2023 09:04:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cA1UeInqqxzkMubxn86dmAIvwRdJ15AI7hHthwuoPL8bsBJ+c8c2TA3HICH5gQSsx8pMlva+FA6scSi/I3XBT7MMstnkR5bNiP7oG66v+QUoBxDBE6vzFcte4KMjoFuySlsWoi8XDBVcANjiOHgixk5AQvGl/KNQODepJDaWXG4JzTQIL1JPyWSKkg87X5G3+8tMfVBSGNDhgEJiEjyA1llKTJxV1H8OgdLX/xFTlhd7lTTA3bVI/bM3s7Nyb9v5VfaTBfgFx6wSpKj2f1tyljj+jjBkgTKt5q/RXSCBQpaWlLNwn1fMzGT8I2h+hh4BvwwSE4ZZJj6RIYQj+2Kzhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ejl3Gzs2iD72kUvAdittupk2Pa/bqIz2sxP5a5Sh1tc=;
 b=cwks3gCCzwCxsCrX2XuOPqkCTKAwuq2DI3xlGnJpm+sp/zYmfiFDY2PMymenwpmEMTNOKiSSk2p0oucu4tFqFIe8wT2AY0GgXMpa5+a6eN8gX3Gc4N6MTpuw2wE8bHqZvvrRiAneIpwOBDIHXi5l8Qqh5NnXhTH0hjNM/1c4J37tqNpoN+6kXelsZekLxT/ezx/H0vtEazCsWtmqr0Jx2MEqmfM8aO5BZTVVzhsesmpOXq3XeaeXNVNatCL/pPxXc7PeJzvo2rz9mYzSPm9mLxqMxtXztDReqBRkJPvDxFKVNFqab5grLeCaxkKhVXbNVvTswIc7ySVd7Y4sV8GpQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ejl3Gzs2iD72kUvAdittupk2Pa/bqIz2sxP5a5Sh1tc=;
 b=LBZZKPJ3j79/PXJUcOurO+xtnREJuux8vf6x8pgiyTADGEpLF+OV6bb9dFmCus6IeZICo15ZQabgDpLf8IJFNy8YLeE/Z68dvD2ZhdYFK5kymvPaFVdzmoNQyRt41/6RnnT81mgNC/hp27JNk6yzlzih7ui9ywtjhNYlguiISxk=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by DS7PR10MB5181.namprd10.prod.outlook.com (2603:10b6:5:3a1::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.27; Thu, 20 Jul
 2023 09:04:06 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::b3cb:e0d9:ef96:aa56]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::b3cb:e0d9:ef96:aa56%4]) with mapi id 15.20.6609.024; Thu, 20 Jul 2023
 09:04:06 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 0/2] btrfs-progs: fix dump-super metadata_uuid
Date:   Thu, 20 Jul 2023 17:03:55 +0800
Message-Id: <cover.1689841911.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.38.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0010.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::13) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|DS7PR10MB5181:EE_
X-MS-Office365-Filtering-Correlation-Id: f7aab2bc-cd38-4806-f8d1-08db89004598
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 43SvpkyMpCCK0JOW1CG8Oe0gdgnVMQi47gXjw88YTk3c/FH3NwJF5wgf/L8B055Sw/EN7JbmasvPQ0qWCm4v4WJjpZ7dwYiWEsDYaZpwE0IdE/XYwmAwOSggvHIQueoNkSCvToT+ZNOL66jBdUlUWaLKMSOdrA16s+QF0F2GshCzwTiSisTtwtS1wPOKOxZ2DDcyIpXJHEvAVQL2J6L7Q7uujBSIa0MtZI+Zkl2nk72KHIVwsvhGlGHZgwdMIy/1bDRt2mUMOBmwX30qhrXjZEjrJVLwo5wYxiEnZE2d7EDiXvxsKCeHZWoVSm+vFZj7a8iSzb+sEexFHkPvDII+VWaSJhKZHE8P9ultFvi6mxt6ClFfUIqjz3EJLRxAMdVdnCxXBFoDYdw3GId6kRpIA4m089Z4Iwc5VqJGOy+PQ26TH8R1NAEMixqX58a2OLwFm/1dmfGKmiFOISUGwqUjcmILa/4Qqkj6s4OUcqTUcZVko10KoyACdLBYNmmEUuZ08np9ygU2ntzXiQDuyFQwoM6II1CBH8rfBUPxcGUd528u+O8rAA6aElE5rSbDKxMc
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(366004)(396003)(376002)(39860400002)(346002)(451199021)(6666004)(6916009)(316002)(6486002)(6512007)(26005)(186003)(41300700001)(6506007)(478600001)(5660300002)(8936002)(66556008)(66476007)(66946007)(8676002)(44832011)(2616005)(83380400001)(4744005)(2906002)(38100700002)(36756003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ESioCVZagfXoBd252aGuPL/PtlKNzs9JIxIcl1nySHWfJKkqM+chrrub8NkL?=
 =?us-ascii?Q?KtIT0oM0Pb67sIr2/YjAivz015LeqFYTUKsxVR35uR95/pRHnuKj22JVInTU?=
 =?us-ascii?Q?QLJTZo9l7chi63RSStjGMntoXOtdG3cLC2SppadsQzTUPrOJoh+YhRVBWFVE?=
 =?us-ascii?Q?HgkbxjPlk92UywJMkWr7ZhG+4TN4kVTsHAG54imq7MscxkA45fTCmIMYdaim?=
 =?us-ascii?Q?jDbK+oEbZuUM4C47hOePZI6Dl7IMIiQ1liE8EPAw7u4hEz+BOT8NmQFU50oz?=
 =?us-ascii?Q?Vrh9bL0CGPYPZ9YYTdHO7tR3C2a8XomvsAAJIMF69012/tMVLp94fx6Sp1dQ?=
 =?us-ascii?Q?KLA5tFK5AJP2DcaqO//UGEfUuq0vEEhA0+ZBVJkRhGwTQwkG5LZ7ulMz8ygU?=
 =?us-ascii?Q?5RlBM/H5NxMS5MXbIbs/TFfOiHXvhtjeV6OuDJRQEn1O5s9Xx/M9FX879q98?=
 =?us-ascii?Q?/rMgeadNqEWtYoVb5AkH6T6r+j1DxyML/TTFsc9szfS8QGvxdhdjfLGZDXTl?=
 =?us-ascii?Q?6TmDg+NREZ+oHktfvdkW7aAYZUBpNFWfv8lnjwDgwkSnAdOd8rSbos5NvIlx?=
 =?us-ascii?Q?YCxcbEpg479mjpFRsVn4s6iJp0ftDvbV/ybX3FPKPjyCiwIQmc9Tn637mgEI?=
 =?us-ascii?Q?kvWD83Xiut47GKhRjTls5rnFLhfMQIdbQeqcds8BVLtvKquSUxWx0A/4M9cA?=
 =?us-ascii?Q?Slci9u+JiH1H7XWHW0GSndaJ9o3CrzYNiSLJAMeB8gv5HfftUBCVKScNxbcN?=
 =?us-ascii?Q?E5Byx+8xjuKN/pRjHT6zINc6EFo49lMSXaPjFkKRvHgePAs9v6A0HgOUPytI?=
 =?us-ascii?Q?kGnwjdtsCLhfEFTuy7QTVZk7kevyqziNW9LkUilziL7iRdoEYauTtacEJ5+y?=
 =?us-ascii?Q?WNpotLait2jAADXYJxAmMKLxSxLruzvt4bAPz3N1WAmxEQ5a+PWyRIvx3lcx?=
 =?us-ascii?Q?vYNunLOYOI3ebxmv+M1aVxkKnDDq6QnBVt2Ep50MiI/K9oUNkLAIst4/9Xez?=
 =?us-ascii?Q?6lCmaxFTv9udXBhl64iGXHSm/tRgFPSDG5vJAABYQtRYh03abDcDnkreLMkW?=
 =?us-ascii?Q?uGaukisHs/vHWvsYAZMbZhquXku8pIeCc1S+Lc/WX4Gs2DezwzhhMJ8dMqdR?=
 =?us-ascii?Q?5SD1+TEIGLS4ZY+xVFqRx0YImEQ0gf06T8bxZw68InPo9/bHha1ho6xzTuIX?=
 =?us-ascii?Q?6fuc7nZsP2IEGvTopUug3xGRtXslSePVVyaG9j8uKmO1UiMPoRuJwhaSMzoW?=
 =?us-ascii?Q?zAM1wDyP4dBThYky4tKcBVPFsPjNe85wC8Tyvf8f3TA14qCHkRus6H4iYLBS?=
 =?us-ascii?Q?K87Sw33TMKg7Bf/+mdFh5RQYot5Q9aXr7TC1dzibOmQmCqgI6pjkRxCp2f/h?=
 =?us-ascii?Q?EkJS6rZZTuuebJX1d4jTkRPRxW8Q8EDD0vzfn899WTwZLf8J6RkjHnjhMegw?=
 =?us-ascii?Q?7+geytXa7BeU973/k3d9UbS+yNNftpwcTDhA84A8Q4hVN0rYBQXYaMYzcAI5?=
 =?us-ascii?Q?S1mnBojkBYqnGF2hylITnGFUPUog5U5+9/EYLVn8ChXNMMxveUaGV0eFaVyz?=
 =?us-ascii?Q?PdemejKReOyoREh+RcyIwfg7O15eTquBtAlfd/fr?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: aQ0xrBIDnA30g9NMo0QX2rJaN9gJS+IlZtZb/TSeZ7EiZjpKXCT2j4KuRKcIDoRpsbiyvzpItZ3t5+neuszQG67T3RjOM2TVnw+e7uyWfuol7ypBTjEqRxh0shmQ/G68qsPnayhTT50elbOX92RcUhu6wAnxSCUt2WhKmVrvSuFiBpj2hcoCFbwMXwVHohOdc/xeCzD57w9YviJ+TQ0JgvttJFCI5InZK57PnYbKYXIggdxnk8anZsR0PHUoJyIvMSqgbaHzOhRTHfyZYgqxWsFLkvCE43KkfsGCxSEOkoaEXmn4S8G7G6SYUaxik05eh3dp41ogZfWikd8DmLua/1cfkAeFuVVfbsZXh7QN9qQf8nCer5P1Px8vIETXjWeaLfCugra36dHD3X0fe8wEMfjRZGIhURakbqaIuFbpufdAzlbnfQRoqX00HTG4+FQ8TtjMUZ0ZE5Gm58iEKBKHhdY0vhupiRgUEaG8j1y96Q0WnhSiGNWHbPOIWEAEhvonyZcqsG7Ze48bSArR3d54n4cHW1IyEiznyqrwxRWOtmrmeFxzVuJ87oQ/EUiYRUTqcXkFoICLklZO+T9TYCMQdyO021mfAjMXkJmwgsxbh/BdjQmDVlgdU0cay3RHKfBKA9E++JDKy3b6yt6bwPx8L1O8U4hoG2IzM7fyQHBq4KB94wuTlnoIkP7MFjSSkfr084zwVfa6kt+SvS5DzLuixu+wXTWfBPTU75UN9EIGi5vjN68H53D5OLG0e6PhN5tgutq0zvvJ0mK4pLRJsDhpxQ==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7aab2bc-cd38-4806-f8d1-08db89004598
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2023 09:04:06.4679
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gdl1pQg1HkBUWT2ft4Lb2AsrqWD7anS3jQgW0UzER/h6qu7fn64KJMZ814d0qg+OxO/RWYSwbcys7N1HgDOmAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5181
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-20_03,2023-07-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 phishscore=0
 adultscore=0 spamscore=0 bulkscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307200075
X-Proofpoint-ORIG-GUID: CTq4vLz_GPNG2riYQaFyNiDStDZnwaYf
X-Proofpoint-GUID: CTq4vLz_GPNG2riYQaFyNiDStDZnwaYf
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This can be integrated independently; so sending it out separately while
I continue to revise the other patches.

This has passed Btrfs-progs tests, and Fstests tests need no fix.

Patch 1 fixes the dump-super output, and patch 2 fixes the test cases
depending on the dump-super output.

Anand Jain (2):
  btrfs-progs: dump-super print actual metadata_uuid value
  btrfs-progs: tests: return metadata_uuid or fsid as per METADATA_UUID
    flag

 kernel-shared/print-tree.c                 |  8 ++------
 tests/misc-tests/034-metadata-uuid/test.sh | 24 +++++++++++++++++++---
 2 files changed, 23 insertions(+), 9 deletions(-)

-- 
2.39.3

