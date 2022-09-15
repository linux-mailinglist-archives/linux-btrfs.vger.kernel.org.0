Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E003F5B99C8
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Sep 2022 13:40:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229953AbiIOLkV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 15 Sep 2022 07:40:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229903AbiIOLkO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 15 Sep 2022 07:40:14 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE5CC49B4B
        for <linux-btrfs@vger.kernel.org>; Thu, 15 Sep 2022 04:40:08 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28FBDc25032491;
        Thu, 15 Sep 2022 11:40:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=wwhlXeNzeDdpLLc65EY2CKRT5zHsCL/oQzdpcxD699c=;
 b=CZHZ/dcuKMzBoHwBfWcXUmIl+ehCw4bVZJCN7w1duGFU2y02VaJbo7EOVJS+Qnq0/EdL
 sqsE2TNNDMeGsgCu3fsnoaaZBL0BlWimsa4AamoqhdWMM4xbJg6qvdlVHmntWuCq+bqE
 +nCTNpA9F2evR+4IhsvnGhaqDbkB3GotUCkXe1O7+QcpmGlTY46KkElILpebMS/23VbH
 IYfroJTisAN1Fs7u+f45h6NC5nC6hofumMAutUKHBjdG40/UZl0cLx1hlMgGWLGABCZC
 qvFpkx0/DZZGhol05nRrwNWybrEtP9CuwEhECX22tzSVyN90ptIOcl026dNPWRWvKA/i 8Q== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jjxyf4tyc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Sep 2022 11:40:05 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 28FBUUbZ037139;
        Thu, 15 Sep 2022 11:40:04 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2176.outbound.protection.outlook.com [104.47.55.176])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3jjyejku74-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Sep 2022 11:40:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vd3S09ViP1kiPhxjRhtLhepxOWeCaQ6YNKfQK1pODRRCQ62G3vPHVzjWcTGIkcAN5yRhg520AhEKEZ+dLCVcHqM1YOo3RXdutcZYldwf3fiUAmdGA0nXazkuR9zAjbWe7oadhYjQQTePTNRF2eShMhyQoR+sec2cQVzfAPr+V5p2CTbIWX/g8tZYBbRgW0/g/Jh4uqliUgQZ03Am6OhvArWQ+WTlWIeBPFQyKmJQDW4W9Wl8hQA94VAjgti5Vu4jFCSOpfmPDQJaXHSxDBDRiO1PVjM2c3m/9Y12IfZDyLU4u42P05bwpwudsHErSfNEBKaoa62vOak55zDgzRAfsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wwhlXeNzeDdpLLc65EY2CKRT5zHsCL/oQzdpcxD699c=;
 b=GmLnsuEcPGQFCrLX+AA/5q015tuvlKbYREdOW5NSkNc60pTSyqvTXJYm+lUrXwIqT6PZxHmE2hc2MaY1zGB4qeD2gt93RbwM4AJrcWFVO9JVTeRfrRAVvuqiq/h8i5ZbUrwNf01tBRUePMAXwj9NTOpOBSwOhHOftfjBgabJpMUxUiveJg61dMG/lX7YDfzkKUzLF0EUrPiPSfzGdnBUl0zoZxcfYWy/asoB4thmnU63MBGpuPZ4oQZNld/W8ncfsiwGADBZK8G17Hy3J2Fp5G8Nrg7sQC71LtI9uH1Oz3joclDaHP+LmfJepSHZ7PpXLKSfYReyN6lxEEZimVOHgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wwhlXeNzeDdpLLc65EY2CKRT5zHsCL/oQzdpcxD699c=;
 b=qU6LKl7zY+BYQMpcrvw4ALOmM/gn2558UpDEB4UsNGAfhbzm8cq6ZICChGR8iaYXxjL7qpbEcD/pr0Ve4Luoc/hKbrJJUl8Sk3j0eoDKLp2Xagc+/YqSvOYGZlrHfWu9RTptdjvpXdH/TlLJZCsDdz5pTSUHSbrZdSTL82BlQpg=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by BY5PR10MB4259.namprd10.prod.outlook.com (2603:10b6:a03:212::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Thu, 15 Sep
 2022 11:40:02 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::74b2:acd4:6739:716f]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::74b2:acd4:6739:716f%5]) with mapi id 15.20.5612.022; Thu, 15 Sep 2022
 11:40:02 +0000
Message-ID: <e00758f8-f60f-36b5-40e6-efd3cf9f18b1@oracle.com>
Date:   Thu, 15 Sep 2022 19:39:54 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH 12/15] btrfs: delete btrfs_inode_sectorsize helper
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1663196541.git.josef@toxicpanda.com>
 <030e2b0b061a8ae57037f810ae3bfb2b4c9b0f4d.1663196541.git.josef@toxicpanda.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <030e2b0b061a8ae57037f810ae3bfb2b4c9b0f4d.1663196541.git.josef@toxicpanda.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR04CA0157.apcprd04.prod.outlook.com (2603:1096:4::19)
 To PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|BY5PR10MB4259:EE_
X-MS-Office365-Filtering-Correlation-Id: 53212564-bac9-4c34-bc91-08da970f06df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: p1H3hBq+aI/OT7HFSvC8XAzkc5wfdfS4l703Sb4GQhmNAPIStSjE0k7nosCuZphh3LE5fvo0z1HxahoevZWJAyKMMBwzs7PFNBKLG09aZ5HjcFkCAs/2I/NdhXKT7BbycCuxnrD3S+hd2x3wKLNarBlCuq+n/+nq09uJOLfFVDvJwXWUJrReCEAbQ1DwD3gd4LL3miPP/BHNBlBy7DTIGqHl4H1cacNRepcd2VX1GNQBY3LYka/da2Yd1qt8Jb2Q+XzDCDRINkbqcDu2+kZnS2IB1BD8sSKLjN7BLjLbR4+YzUk/NGA6RL8h5AogFG0rSsrz47WidYaO/ROC2xIIDgybP3GhNQNyFUgqB+jAWB82SC6WcR2MgS27lTG+E5TUybWoTPL/0YLQQMf0XG3N4+n2YBLSVdflpbz68DTY2pN14lXyCdfHu7AOM1tOh8vrl2i7Q+YobP/A2zWDc1e/49hInJ09U6RfrnHYfZgSDl5IGwqqybn/0BiFc4W0i6Oq9B6+UN2g2XARlkf29aW9s3GyDjGCxyMPMFtHDWObS1IupLzoA1p4gYgdrXC7dZjxld1VZ2V52c7apmsCi/NtyxnA1FtyrvoZOd1B2MUB+fX+wf97/5UFkDRIAkzgIQF8VCdvJvKbQsO+Vx8UboL+cFUujBIPy1vF4YI6HTyq4thu6t1PfImyaxmQ+qgorre2vdRw8ClucCkgq8vDMiuIjjKo4JX9xzr6icvDCFkawplR19A05U5OdJA2dgUjLBcU/dGdZ5IB/aO86m7jhKpTh9ACYIBCmFbjfnZvimAW2dw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(39860400002)(376002)(346002)(366004)(396003)(451199015)(44832011)(8936002)(6512007)(83380400001)(38100700002)(8676002)(26005)(31696002)(186003)(86362001)(478600001)(6506007)(66946007)(66476007)(66556008)(31686004)(4744005)(6486002)(53546011)(36756003)(2616005)(6666004)(2906002)(5660300002)(316002)(41300700001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dm1tV2hyaHZaNHZ5Nzk0R1Z3Ti9XUUlaVzNCOWI3VWFIbWRieFJCYkIwcWFG?=
 =?utf-8?B?T1JFMU04Vzk4T0tFQyt5M3N1R0pUN3IvNVJVRk5ScURBaVR4OS9QTDlYb0NJ?=
 =?utf-8?B?b2tBQXJobk1mcVFpUitXM2l2RDByc0w4d3oyUFdjMGIweTRycVFEM1huejF3?=
 =?utf-8?B?dzZBQlIxcUF1VmpTUmtqNTZaRnptb3hoRFB5S0gwQWV3SmMwdnlnVXNxeHNG?=
 =?utf-8?B?Q3lPeVFQQjRNTG9SSEtadnhhRDN0SjQ3OTFkZVZrTFk3NzdIbHkrQ2t1S3U5?=
 =?utf-8?B?dzh2Z3Uxd0VDcUFOdmNuSHJORERxOFUzUkNrMVBBZEFZNDFnVHFYM1VtTlhI?=
 =?utf-8?B?RklxdTFvQ3ZiYm03SDcxbEt5UHREZUZxNEVkZWFlZE9jelpUbFRwRWVMZCtY?=
 =?utf-8?B?dmVaaU9KNWNRaEp5L0lzb0p4YTRIeDk4RU03Q2w1azhDMjdqM1FYRjVydFU5?=
 =?utf-8?B?bHZtYVhjaFZGRzBidlYrcnpKcTVQYlZsNncrWkw2NEZjWWVFWkI1OGJ4UHRT?=
 =?utf-8?B?alY2ZXZCZERidGxUTFlndHg2Z3Nuc1U3TzJmMjYrbi9VOHVnUFRDTjhSRk45?=
 =?utf-8?B?MHdidE5DUEJ0Y0NOd0ZhWmdoQVkwRmpJTU10NDlEMlhVQjRrdkRpdXVKWWI3?=
 =?utf-8?B?ZGl3N2lqZmowWTR6OHllcDZsM0JCTGQxeUZiUWpKSzBCazNJZVIveHhhRjRC?=
 =?utf-8?B?a05KQ0pGcGdHMmwraS91cnhEMThBQUh1cnAxQmFud1E3UmVRS1kwUlMrd3hi?=
 =?utf-8?B?V0p6VEp5cXJyQ2hLZmJMZ3I2OG9lWGFtTzlvUUlORWFvT3J2cHljcUVPVWxP?=
 =?utf-8?B?bWJ2WmtHQ25EV21VYm1OdlB3VmI0YzN4UExBQlVrVDlRZFBTRDZ2aFVia0du?=
 =?utf-8?B?dEY4RWZyT2tEVlNCVGpSWXdGK3RqN1laYTAyNjZuQkZjZW1PTTQ5MnZCV25C?=
 =?utf-8?B?R0FWbzhiZnFXbkRYNmYwK1V0OUJibFBZVGQ2RzhzbTNvcTMxWFYwa3FXTUNK?=
 =?utf-8?B?NGFZT0pNdXZCRnA2ZFFUaHlaTHd1bmVlOHFkRUlFSlJjYUVoeW5Ba1U4YkN4?=
 =?utf-8?B?S0w3eDJwcitmM0JpYnRreFN2ZVAwdTgvSytnZUNDeHZ6YmhJR252V3NUdFc0?=
 =?utf-8?B?VjBhd0NmWU9kMVVaaWtadlFJYmlpMmhWQmlkemViK3FPWkhMcG95UHhmY2Q1?=
 =?utf-8?B?ZDh1SnVlckxzeWYwTnBLclJ6RXkvVGdPQzlYMGh5K1o3eDVxTUpxTi9LVDBE?=
 =?utf-8?B?ZlNlcVp5dHJSM0kzcjRHaDVVMll1ZDJFSUk4S1Q5TityNDV5dzV1a281eUZM?=
 =?utf-8?B?MVRYNlhwNm9pejhRRWxpSnQ4VWlobXVpS2ZUcmNCMkh2d3lUc1FvYUppdjAw?=
 =?utf-8?B?LzFXbU5wakRtekJPeHVxbUxVWlBYemJwZTlWWExVSlMrak9nRzl3NDVUV3Q2?=
 =?utf-8?B?WWtnWDRVL1JwY2lVSG5POGQrb3Z0M01BOTVMTm9mRmRsSGhEOHFtTlpGQmM1?=
 =?utf-8?B?RHZXOHlSNWVBVTVCN3FjY0lWZk02dGh4TDZxZ1FseE1mdWhkcGtqUG9YNlJm?=
 =?utf-8?B?dzJWY0p5MDZjc1MvZ0x5MHk0eUtBVllmMVJiakhHTEYvbUlOcTJyaWdVUGM4?=
 =?utf-8?B?YWpjbzd4RU9CVExwSEJpVERZVCtBN1UyTStpdHErTkllOVp2MThpS3ZoUHpT?=
 =?utf-8?B?d2J5MlE3MGFNNEZHb2dma1lFOENNUmNNeTVLZkdsR1F4T1A5cXFjYmF6aFJx?=
 =?utf-8?B?bGN0UytGdlBtTkJDT3ArcXFreFZTcmliZUI4TkRnaVBQKzNjZ0VjS2pUa2FO?=
 =?utf-8?B?MnR1OVEzaU1qbVJxRHBRZlZOM29iN3JneThZQktQekcyWGErek5nSFlDT3pR?=
 =?utf-8?B?SXlHQmFkaC9udkZOZ3VvaG1EODBJMWcyYy96SUUxQm8xUTNVVzJLdzdjeVE2?=
 =?utf-8?B?ZHhaNENOb2NrbHZleldvWjZuaXZBZk42K3h0b0xVb292dVZTTlZicEZmc09F?=
 =?utf-8?B?c3Z2Wm9BQ2I1TzZRWFYxeHN5VXpnRGhXL1J2Z1NvSDM2SVYvdUE1eTZxTVc5?=
 =?utf-8?B?WWxkTjhuaWJrWWxIaTZwcVhoQ0FGRW5PN0JXME41ODQ2N1g0eDY1bnVkSEhD?=
 =?utf-8?B?Unl3c0dxVTBFTEZBTjlTa1NnVDNRUm9rNWhRa2xpM2dtVFRnT2NFQVdZMU9i?=
 =?utf-8?B?ckE9PQ==?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53212564-bac9-4c34-bc91-08da970f06df
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2022 11:40:02.5401
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZNGpCRP+5Fq893vexmLw9pXI9Bw7pL24wAa+HDcAWG2JdCOCMzWJpkHm7drIzJhk587cdxmCSr+PrCVZc1wYjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4259
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-15_07,2022-09-14_04,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 bulkscore=0 phishscore=0 spamscore=0 suspectscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2208220000 definitions=main-2209150065
X-Proofpoint-GUID: sdMIQ3ZyByAZZ9wl30UvdUuysLVKFkTo
X-Proofpoint-ORIG-GUID: sdMIQ3ZyByAZZ9wl30UvdUuysLVKFkTo
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 15/09/2022 07:04, Josef Bacik wrote:
> This is defined in btrfs_inode.h, and dereferences btrfs_root and
> btrfs_fs_info, both of which aren't defined in btrfs_inode.h.
> Additionally, in many places we already have root or fs_info, so this
> helper often makes the code harder to read.  So delete the helper and
> simply open code it in the few places that we use it.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>


Reviewed-by: Anand Jain <anand.jain@oracle.com>
