Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1D8453002E
	for <lists+linux-btrfs@lfdr.de>; Sun, 22 May 2022 03:14:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233944AbiEVBNu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 21 May 2022 21:13:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbiEVBNs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 21 May 2022 21:13:48 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A58062B244;
        Sat, 21 May 2022 18:13:46 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24LFi5d8003988;
        Sun, 22 May 2022 01:13:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=43/Zxbj6geKxYmTWqSnyIxr0/V62vvi3BsvKZWVkkoc=;
 b=FItRQusikXOhVgYKuSZqkw8HFX6DH6mGhF2XieG+99MYnvGnh8ICJtZlD4ZYYDhtgFoK
 oj4Y/6pnB4sKfb5iv5EjDHBO80SwoSOZ65/EYY0LJF/Hohjgwj9h6Y/U4KX90FUH0+QX
 6VpzEpkq7xLK7xeKD1qw1CJylr+IcSAKHeqrqleZtFn8W+vG9TskJ6Mqk1i1x5HLCH4C
 9spNsSj+tX2SqBD6ybRoVH9GINjdtdAlSsO+feVs53mVicmHlfiLtw9lLtk4TrtlbI/l
 obvm8GXx9JzMOZ7QGXU3vGqvU/euGVuQJyWFh9LyWCBVthY/svgSR1Qs5G5yU11vnF2t Vg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3g6qya0x4c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 22 May 2022 01:13:39 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24M1C9jI027886;
        Sun, 22 May 2022 01:13:38 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2104.outbound.protection.outlook.com [104.47.70.104])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3g6ph6tymu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 22 May 2022 01:13:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ROtk8Acc0g9NDioQoD3Sfi37m2nnMyNk/bbpBRrCQNO/UrmG7CZ+hvDIuoG5ld9zl4IL0hYQ/4TuMVO9qTWp0VB1AU7KdmtjWBO0IIIlKb3Rc+I+7kvrjHI91ld/MUgQ/uhcE6mbpX5jqhBY2R44luQCNfRhMPIro1HfUPMLce6YD+Z3RT6GUBhA1C+l+gGY1RWEiaujW6phI1BAFSEydj2keEwZrsynDpRWkpVkxVrKM0Wl59Thkxvir7xa5IMK7BHMg0AwaGPkAPv3fISkkK2FVhqsY1LKrnAaFwz1YkgrE2mfqPimbkLkl5A7EgHj5fzaC4RNG3qyxPsQH3ESxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=43/Zxbj6geKxYmTWqSnyIxr0/V62vvi3BsvKZWVkkoc=;
 b=SBupZ9dVHXzmGe4LSqc88X7qhOO5AGu6qG7j4n1G4YLju1qOrOQn6D7EmAOPtLbw20OxjYuFjG0Irc0HednMjWvSJ2PTOif3XYEsPQsquyWhydDn+mNEoBOoL2RlOCmHyVBfMH5JKcPO2LmnwRshxPrKo9LwBWLO4iZqBp/PNyL8GeomIbaCWYZOgpxSAOBKqH4ctoh1CTItoiJCQdoyw8BX7misdPP9ieOw9y7YWvp6xRFu7/MlMyZ1HSowXUdMgB5bALam2Rb+JeX+gJx5pbELSj/5Db61oMPCeLFzYQveP44vyjK8tTzcEk7d25RncJoNQp5sd7t5cMGEq+LUbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=43/Zxbj6geKxYmTWqSnyIxr0/V62vvi3BsvKZWVkkoc=;
 b=j2tRDBXew6mgGDnpjjBcC4CtRP2Mj3SDwkE3ouKEnHKdKZdnRmcWwUzmX4+euoiNcGo2kgb2EEcOyX/vxHy6hwRsCh2c+23I3/qQAJ8dOeR0gbQ/Fk8B7QNW03eUHo7MiuXQYwo0Esi3TSKJ2yyqlKYNS1L4El7AeLLRdHmntxU=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by DM4PR10MB6136.namprd10.prod.outlook.com (2603:10b6:8:b8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.22; Sun, 22 May
 2022 01:13:36 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::b981:1ec3:a3a5:f3b]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::b981:1ec3:a3a5:f3b%5]) with mapi id 15.20.5273.021; Sun, 22 May 2022
 01:13:36 +0000
Message-ID: <03f21cf5-2e61-09ab-fda7-8291778b38b3@oracle.com>
Date:   Sun, 22 May 2022 06:43:26 +0530
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.0
Subject: Re: [PATCH 1/2] btrfs: test repair with sectors corrupted in multiple
 mirrors
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
References: <20220520164743.4023665-1-hch@lst.de>
 <20220520164743.4023665-2-hch@lst.de>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20220520164743.4023665-2-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BMXPR01CA0046.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:c::32) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 828a8f0d-054b-4b49-2450-08da3b904bf2
X-MS-TrafficTypeDiagnostic: DM4PR10MB6136:EE_
X-Microsoft-Antispam-PRVS: <DM4PR10MB613698750E61C175183BFF4AE5D59@DM4PR10MB6136.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NWuQG5xedBNlzrPI6zg217sQoXFvLrK6mPbPseysrdB+hB27FRCr5aPrPch2sAaoGfyL7DngZ+c4bdspdgaPXfx7utNx1CMsHSeBSmPYOhcAalwNZtpkZdM+1GlVC7egSTfXqbtXQInqrezJa63O+tPORWEWXaNhtDoIgagwP/ZAaTgvlnEMDCbtpY5qEahw+NDEnu7uKO59uxtScpc1XlUNY9vMEYEoGFE9YeOcnD5crUeGL4bHJjRfZ3L15b/bp2LknYkPBHpOojzeqYvDRh0IrbJW4otWAZgt3azD63rUmcj7fLoA+bVRDUcYgkWQtY3fvdkzxUTVfvxEnYs+VjXce8EwXpAYFpm7rCpFbS8bopeDlvMbiv9zP7Wz22g4d+bL+Lv2jXrfLvRNWszHdVUKNw8IewKjwXnOa1tz9cDSMp9zOcWJk5m45AnSRUS8RzhBj7t3X1xqcegFkkSd5Og+YLKxJSFFRm8IYfljobexcDDi6N09VM9+5fypLOuf6l8b9pE+C8gv9n+ACRgpFlF/YMMA0vtoP1H+D5PIQMs9103kRbVzPggKT3ThFp1Rsal/JS1P88kNlHceBlExMcOT8DucnG54J21nUf2mDGytzhhXppmte3+mmPWYfbNtTzgdM6e6qT7IKpSB3cCuYmL83DEE7WZRdyyLbcWrLhsaJcgK/KOKWYl7lzMr2lTQIvFhJjDhTagmYzy/CQlxzDXN6DRLI5lQf+0dlUR+d8KYYJVsqIv3FAZSFp7QctjNOtMqGVskRNkxvW/L28AP3g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6512007)(6486002)(30864003)(36756003)(31696002)(8936002)(5660300002)(508600001)(31686004)(38100700002)(6916009)(86362001)(2906002)(2616005)(66556008)(186003)(4326008)(8676002)(6506007)(66476007)(66946007)(53546011)(83380400001)(44832011)(316002)(6666004)(21314003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YjRNaUk0d0tuZXlKQTBVSnBRMXkvRUVJYVlHclk5TmxGODFmVDJoNU5WOUJN?=
 =?utf-8?B?MWpwMnNrSXZzc3E0Ri9vSUxhSXFzTDRwZWFKOGV6WHpoZGduZFNiS1hYZ0NO?=
 =?utf-8?B?R1Z5ZXduWHpoY3d1d2V4WDUrbjI4UnhzREljOUNIUWpEY1B1aHVEcnFtYWJP?=
 =?utf-8?B?VXVpQUk1elNVZ0hQN1ZBL0EzTlhram9xNDYxZEdtS3NZQ2h0cEwzcHJvUFNl?=
 =?utf-8?B?SVdSaHVpYWladmdBVGdBcFJyT2N2MTloSmQ2Um5JY1FiYzV5RFd4cGk5VmJH?=
 =?utf-8?B?NzZhckVhSXF5VHhQK2NBaVJrUVVOZjRGMWhoSnpaSXplWVVQa3lpTXpVL0ZL?=
 =?utf-8?B?d0FuTWRZNHpHUkJTeU5tN25nbi9UdTFNd041WVFxZEZaSElwYzFkNlBabm1D?=
 =?utf-8?B?YlhkaldVeHlpSER0V1BHczhobE1JVEh6YlcyY25CeGh4dzNJSVFiVFZsSTlp?=
 =?utf-8?B?TjVQVUlaR2FUMTJJSDhkRlQweFZZV0I5NFR1SkoxVlBWbFg0bGJoYW8rdk8z?=
 =?utf-8?B?YWpuZTI1a29wTm1xL24xOG84V3ZaT3pCQ3QyNXRGcE5GYVBocnpsZFJOLy9H?=
 =?utf-8?B?Y0ZqQzhOQVNvTGU5SGExK0krenhjNkZKRGRDeXpGeENxRDFjSEozR05PVGhL?=
 =?utf-8?B?S2hMZERwRzdodGNRZFFYOWltNGFaejFwWlE4djdHWXE2dXZnaHMxam5BYkY2?=
 =?utf-8?B?OGlwZzkvYjM3UkwwQmpTTzAwbUVHeURkbmh3VjNVbTVBcEY0KzN2d1pLbXl1?=
 =?utf-8?B?dUlmTSt0Wm5tRVVBYmJOQmpuQlg2d3VmNnlnOU9ra1FGWGZqbTBRUG0vY0FY?=
 =?utf-8?B?ZjhpSnpXNzdqM1NPWmdSQkFkTFhKNXhQTXVsa2hQSDFQdTlUR3BKM3RDZVM5?=
 =?utf-8?B?T3IvaE1qRXRoUTBPZWJJbHc4K2pnT3NmUUEwdkR2ci9jRW9ta2o4SWpxVEEy?=
 =?utf-8?B?cUdGVUlTRHRaNFJNTG1NWUZnOEhRcDd1VzR3NG9JaWcxZXpxM1gyd1hoKzBt?=
 =?utf-8?B?ekFBK3pudVJTN2ZLdHRNY3ZyTVJ2cXpETGtSVG9MME1XQjRJOHltYzdva0kw?=
 =?utf-8?B?SHZOTWxSVGVFQ0swaFZCMUlydTgzL1h3TTRvOE9Pb1Y1VUhyS3VYNDZoRU1Z?=
 =?utf-8?B?QTA3VkFEWUdMV1FYb2t4Q2d0eWFqa1pyM3hEVG1QQWJaUnlsWTJIZTRXUjdp?=
 =?utf-8?B?bWhxT0ZseXFSLzJnT21peDdLNlRkbTRkOWNxR1grU3kzeTN1ZnNGUk12bHBQ?=
 =?utf-8?B?c2ova1o4Um1Fb1ZSWHRtSk9uZ29iVk5xWDNGZWp4ZEZuQ1ZMUlBBZTNTVDZ0?=
 =?utf-8?B?MUR5UDhHbFNZNVh6ZjdqR0ZXZHpoeUhjNWR1Sm91cUtncWNFb2RGclJLSWZz?=
 =?utf-8?B?d1RQY0kwZVp3SENZanBLOUZKUEg3TmNNVThYQm5kTTV3dGZPSnVNRHl2VHU2?=
 =?utf-8?B?aEtid1VnZzBrd0ZvWE4vZkphSW9SZzZ5dVhkd1FZNk0xVStGcUplUHNVeWhh?=
 =?utf-8?B?STkyYkdweVpHSTZwS1pyeU5WbXRudFhoWUxIQWJMTENzQnVFVm5LOVBRVjJE?=
 =?utf-8?B?ZXRXQ1dHclUwNFdGV05KQmtPS2F1RTFIZnRvNitsbVpaSHVnWHpERWZUR3gz?=
 =?utf-8?B?Y0RRTU1pb1hJcjJqd1J1VFZiNmhEWTVxK0tGN253Y0l3aXNYN1IycDI2bGQ5?=
 =?utf-8?B?L05Fb3ZBeFVYaU1HamxrZk5oZ1piMm55QjJkY2J3U2s3NFNNZThZU1NXYnVN?=
 =?utf-8?B?S0wwOFpOTTdaTmk5S1FIZS9kVVJSQTdPaUxTS2F0cy9QUHpmNnFVS1hsUWQr?=
 =?utf-8?B?QVBYZjZKMUlhcWhYZTBtN2swY2NWMWNZK0ZDUnRGWGZGSEtIR1h5NmhKVFk0?=
 =?utf-8?B?NDJ4c0hONDhMZnVheDVMNUdUS3p4ZVRlWjVGTzhDemI3bGRoOTVMWE9MK0li?=
 =?utf-8?B?NWVVRkM0L3V4N0N3bW13Y0hicERaQUprZFMycy9obEwrblJNL1A5c3RrOEZq?=
 =?utf-8?B?bmVVcVV4VDRycUt4a2hPM1BLQk9wRjI5TUNlTGl1bjFGY1JwYVpGdHBTK2p4?=
 =?utf-8?B?RDV5T1BGWk5aY2xqeTdaYlY5STd3eEVyMzI2WFowU0VKVGZGdEhpZnJPekxT?=
 =?utf-8?B?ckhLczJxZ0ljZjMvTVRaOENUUnUyc09ZV2tIVHN5NnRMMTRLc1c3UStXdzVB?=
 =?utf-8?B?azVqQm5qb1JKeFk2VkpRSTBhOVVXZmVrRXYrRWJaVUljSkFnaGVaYXlIZGhP?=
 =?utf-8?B?OGw1ODVaTk9IM05CRmdoN3JwdXFLKzVDaHp1eHdndGpsMWNTR1ZvYnpjZVAv?=
 =?utf-8?B?S20xMWp2dEJHaXFBVlhNLzdTdXJWZXc0WWUxbHRxeW42Ym5LdndjVTRmb1dP?=
 =?utf-8?Q?eo9nqHUmK2ZXoBVJFytugTKefZtliC5303SVMobe5EXXN?=
X-MS-Exchange-AntiSpam-MessageData-1: 0JoyWI3DuPYF4kZErOiPrMNeUP19TyS93kw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 828a8f0d-054b-4b49-2450-08da3b904bf2
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2022 01:13:36.5742
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u8C0I3r2gzz2yU2+EqTv6xMbO17mV9AEXCmCGgRk0iNZoIWFVSabmvSkj97V2Jey+wPBrkegE7ifgtKI0RyPeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6136
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.874
 definitions=2022-05-21_08:2022-05-20,2022-05-21 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 bulkscore=0 malwarescore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2205220006
X-Proofpoint-GUID: qefeBqoZtg1fZgid6bPiNeG0NgLRc6T2
X-Proofpoint-ORIG-GUID: qefeBqoZtg1fZgid6bPiNeG0NgLRc6T2
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 5/20/22 22:17, Christoph Hellwig wrote:
> Test that repair handles the case where it needs to read from more than
> a single mirror on the raid1c3 profile.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good.
A few nits below.

> ---
>   tests/btrfs/265     | 127 ++++++++++++++++++++++++++++++++++++++++++++
>   tests/btrfs/265.out |  75 ++++++++++++++++++++++++++
>   2 files changed, 202 insertions(+)
>   create mode 100755 tests/btrfs/265
>   create mode 100644 tests/btrfs/265.out
> 
> diff --git a/tests/btrfs/265 b/tests/btrfs/265
> new file mode 100755
> index 00000000..96f37989
> --- /dev/null
> +++ b/tests/btrfs/265
> @@ -0,0 +1,127 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2017 Liu Bo.  All Rights Reserved.
> +# Copyright (c) 2022 Christoph Hellwig.
> +#
> +# FS QA Test 265
> +#
> +# Test that btrfs raid repair on a raid1c3 profile can repair corruption on two
> +# mirrors for the same logical offset.
> +#
> +. ./common/preamble
> +_begin_fstest auto quick read_repair
> +
> +# Import common functions.
> +. ./common/filter
> +
> +# real QA test starts here
> +
> +_supported_fs btrfs
> +_require_scratch_dev_pool 3
> +
> +BTRFS_MAP_LOGICAL_PROG=$(type -P btrfs-map-logical)
> +
> +_require_command "$BTRFS_MAP_LOGICAL_PROG" btrfs-map-logical
> +_require_command "$FILEFRAG_PROG" filefrag
> +_require_odirect
> +# Overwriting data is forbidden on a zoned block device
> +_require_non_zoned_device "${SCRATCH_DEV}"
> +


> +get_physical()
> +{
> +	local logical=$1
> +	local stripe=$2
> +
> +	$BTRFS_MAP_LOGICAL_PROG -l $logical $SCRATCH_DEV >> $seqres.full 2>&1
> +	$BTRFS_MAP_LOGICAL_PROG -l $logical $SCRATCH_DEV | \
> +		$AWK_PROG "(\$1 ~ /mirror/ && \$2 ~ /$stripe/) { print \$6 }"
> +}
> +			
> +get_device_path()
> +{
> +	local logical=$1
> +	local stripe=$2
> +
> +	$BTRFS_MAP_LOGICAL_PROG -l $logical $SCRATCH_DEV | \
> +		$AWK_PROG "(\$1 ~ /mirror/ && \$2 ~ /$stripe/) { print \$8 }"
> +}
> +

4-5 more test cases use these functions. Why not bring them to common/btrfs.

> +_scratch_dev_pool_get 3
> +# step 1, create a raid1 btrfs which contains one 128k file.
> +echo "step 1......mkfs.btrfs"
> +
> +mkfs_opts="-d raid1c3 -b 1G"
> +_scratch_pool_mkfs $mkfs_opts >>$seqres.full 2>&1
> +
> +# make sure data is written to the start position of the data chunk
> +_scratch_mount $(_btrfs_no_v1_cache_opt)
> +
> +$XFS_IO_PROG -f -d -c "pwrite -S 0xaa -b 128K 0 128K" \
> +	"$SCRATCH_MNT/foobar" | \
> +	_filter_xfs_io_offset
> +
> +# ensure btrfs-map-logical sees the tree updates
> +sync
> +
> +# step 2, corrupt the first 64k of one copy (on SCRATCH_DEV which is the first
> +# one in $SCRATCH_DEV_POOL
> +echo "step 2......corrupt file extent"
> +
> +${FILEFRAG_PROG} -v $SCRATCH_MNT/foobar >> $seqres.full
> +logical_in_btrfs=`${FILEFRAG_PROG} -v $SCRATCH_MNT/foobar | _filter_filefrag | cut -d '#' -f 1`
> +
> +physical1=$(get_physical ${logical_in_btrfs} 1)
> +devpath1=$(get_device_path ${logical_in_btrfs} 1)
> +
> +physical2=$(get_physical ${logical_in_btrfs} 2)
> +devpath2=$(get_device_path ${logical_in_btrfs} 2)
> +
> +_scratch_unmount
> +
> +echo " corrupt stripe #1, devpath $devpath1 physical $physical1" \
> +	>> $seqres.full
> +$XFS_IO_PROG -d -c "pwrite -S 0xbf -b 64K $physical1 64K" $devpath1 \
> +	> /dev/null
> +
> +echo " corrupt stripe #2, devpath $devpath2 physical $physical2" \
> +	>> $seqres.full
> +$XFS_IO_PROG -d -c "pwrite -S 0xbf -b 64K $physical2 64K" $devpath2 \
> +	> /dev/null
> +
> +_scratch_mount
> +
> +# step 3, 128k dio read (this read can repair bad copy)
> +echo "step 3......repair the bad copy"
> +
> +# since raid1c3 consists of three copies, and the bad copy was put on stripe #1
> +# while the good copy lies the other stripes, the bad copy only gets accessed
> +# when the reader's pid % 3 is 1


> +while true; do
> +	$XFS_IO_PROG -d -c "pread -b 128K 0 128K" "$SCRATCH_MNT/foobar" > /dev/null &
> +	pid=$!
> +	wait
> +	if [ $((pid % 3)) == 1 ]; then
> +	    break
> +	fi
> +done
> +while true; do
> +	$XFS_IO_PROG -d -c "pread -b 128K 0 128K" "$SCRATCH_MNT/foobar" > /dev/null &
> +	pid=$!
> +	wait
> +	if [ $((pid % 3)) == 2 ]; then
> +	    break
> +	fi
> +done

More test cases use the same logic. They can wrap into a helper.

Thanks, Anand

> +
> +_scratch_unmount
> +
> +echo "step 4......check if the repair works"
> +$XFS_IO_PROG -d -c "pread -v -b 512 $physical1 512" $devpath1 |\
> +	_filter_xfs_io_offset
> +$XFS_IO_PROG -d -c "pread -v -b 512 $physical2 512" $devpath2 |\
> +	_filter_xfs_io_offset
> +
> +_scratch_dev_pool_put
> +# success, all done
> +status=0
> +exit
> diff --git a/tests/btrfs/265.out b/tests/btrfs/265.out
> new file mode 100644
> index 00000000..4d3e7f80
> --- /dev/null
> +++ b/tests/btrfs/265.out
> @@ -0,0 +1,75 @@
> +QA output created by 265
> +step 1......mkfs.btrfs
> +wrote 131072/131072 bytes
> +XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +step 2......corrupt file extent
> +step 3......repair the bad copy
> +step 4......check if the repair works
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +read 512/512 bytes
> +XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +read 512/512 bytes
> +XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)

