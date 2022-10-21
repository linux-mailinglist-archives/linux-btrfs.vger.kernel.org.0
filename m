Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A013E606FC7
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Oct 2022 08:03:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229931AbiJUGDo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 21 Oct 2022 02:03:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbiJUGDn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 21 Oct 2022 02:03:43 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 143F74521A
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Oct 2022 23:03:37 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29L5OKNA028979;
        Fri, 21 Oct 2022 06:03:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=s7FQWjcFhD5c1J71TVv304LVAu4Dhzu9wabxSogzAjM=;
 b=Xq6u2pIw8KyB5NWttlX0m9Zm0usaKLPs1GIcRU8w1O3wldmfaAm8rn7/923miAGlxMoJ
 rX0TnKxi7HS7v97LgCHfWaJryQSfQ9/Ar4jth4SKgSRyapt9UA3Wq/0VERxiiyHqYELK
 CV8TWFxorz4G+RxK3dihlnkN1ZqVAez7MVx26KHx5y1Cjk9c29Vwd0pCzSnZ8OAtxbiR
 gyrq1vqLFkieftX/xQLaHGEJznnDV1NcTxXMwwHHDJCnjo3z33JsU89IXqhhUJjj/qDr
 jxphcCCQFU9UnmamY4NeoYL2yFyxZ9r+KvvQP6PMH/iw0oNCNut34pyHfoY3e12NReQF AA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3k7mw3q88a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Oct 2022 06:03:34 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29L4xgLJ027455;
        Fri, 21 Oct 2022 06:03:34 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2169.outbound.protection.outlook.com [104.47.73.169])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3k8htk9r2x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Oct 2022 06:03:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BdtlzDSqP2DNwM8RufkY5pp6BzStOCJhqkW3ftngT61bhyhft+j0GmTDk+OCTDDakfrTq2w3u+a9bQkVkntxvTiKsNdHdXzRvlsftRt/59DGCUpGdNUE9SLYoP+8csZB1SZV4mg9exbTVoyJvheA2sqbBr+eOz1303WzKzI549Hc3XJsN/bHwYlzpi54uYZ7vadklQmr7jhg6sCE/FHcfpQui2GnP5ybx0I8JCn7Zm4+3FalDtZXI4PimGneueKnS9fklbcbmzmog22EGKZQz7lgkIscKfjvx/EXRwGgYxclB6MKcKJpOxaNxXSMsqFhn5uW1Q3DsyCUzG8vPLTaLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s7FQWjcFhD5c1J71TVv304LVAu4Dhzu9wabxSogzAjM=;
 b=he6i2vvcgl8hKp4iKrTaKg0hoB8xCorPKmPRVVXTmMKqdXavvpFmeZF2ARPrDZeNwIxPlxNEtAc8BByeen362wGZRzJ2MjMknKh/cTwJ7aGUVah2aFhAMzppyN7Opv1jYY5En8bW+Zt0JD8mT7cifF3wKtiuzIe7e+He5iLBDjOZKOc9ouX70zrXBlNZhNmr0Uytl4ve1X6Sjdje34SkMgN60iXTcxkVSFIkAmhorU/hgj2Dr0kGnwK17RycxX1l4SzJSYdIHsbWQeK3y6ENLO5wxcP6Z07Fij+GYEG31aGxaZpDISn4s/1HIAPTlBaVGteQ1MQI0SPrmGBv8VDMxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s7FQWjcFhD5c1J71TVv304LVAu4Dhzu9wabxSogzAjM=;
 b=pfi02jskXcgqOXX5wZJAN0k3V43FirvpxT93utLwplHt+m9bOnPm6Xb2Qa+L9b7tIDlewyzjy4fbM9FpYJE68kVOhUk7OSjQv7y1jQIzJQ8xWdP/dtaAgUa4QrxkMCmbvL+KUHZBWxDSf+9NDYvqlYu2USkhJRNQu+g/JVfWps4=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by BLAPR10MB5380.namprd10.prod.outlook.com (2603:10b6:208:333::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.21; Fri, 21 Oct
 2022 06:03:31 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::c899:b523:4dc1:8f6a]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::c899:b523:4dc1:8f6a%6]) with mapi id 15.20.5723.034; Fri, 21 Oct 2022
 06:03:30 +0000
Message-ID: <2a07e1a8-8015-ff19-ba55-61fa2da16bdb@oracle.com>
Date:   Fri, 21 Oct 2022 14:03:24 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v3 09/15] btrfs: add a BTRFS_FS_NEED_TRANS_COMMIT flag
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
References: <cover.1666190849.git.josef@toxicpanda.com>
 <9c3c50c6a36b7d56e3bc9bb883f5f0209d0dbcd8.1666190849.git.josef@toxicpanda.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <9c3c50c6a36b7d56e3bc9bb883f5f0209d0dbcd8.1666190849.git.josef@toxicpanda.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0129.apcprd02.prod.outlook.com
 (2603:1096:4:188::19) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|BLAPR10MB5380:EE_
X-MS-Office365-Filtering-Correlation-Id: bbc22e45-8296-4c33-ac05-08dab329fa8d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xKWMvtNW9YcDOTQwvLoRc1BZCi+SClMqHBpuy+2q7cFO4Fu3TWvRkCw7ozP+/rxp1uHove5M/1Yndk3zXAwAdYyVVM9K2PHH1Ny0ACcLCP/GGQnhmLx/8cddWhnBa+p+gbIT/Fz/bPB2Reuou6CCjo0pqb9y5uonsKYPwUYe+Qs4NRbDmqcfVoy2x9QrHuaJvUGlhNcdAPfLYOaFW3LG9uhWoghyotl2KEV9SF3+OkahUtoaHcI1nAnDocdGcGn2MJzK/WAAGy1i5F7y/384fr09mXqHhq2NzWxXrVa3BWxieAJ0LHWNOV+cWJjNxFCa3C9mwaZYslxPlFujy9Rzk2EiNt5GpzTTCPhoXRlnbda8jYOiv9jny9YyWD47vH1wGHQA0uOvHKuogywGcKLLgqQp1cNClT/rFUhFZlHLRjWAhIYp3/8oQ3BxGMOThXDM1Rjh7IvYCHRSvd9g7l2TLwsmMO4TfVYt1t1ZOqDLqYmjFxQqgDx2lq+7kwXQdv14/GAzamUngMqRJtiwkZCBhFJnHi6Yw0PFfVyO8lYOuznhJeRG2/4meMvGHullrTFPUj+0pvzZ6gl8z9r7tHGZRJI7Akffh+N+V862dBld6g2W+JIekv0FAgOtXyJPaLmMwPR5pX6MYlFfU6QxWxWcl4rxJ5EfpVfAHwrM4bcr57SO/MJkFVKvvKADrsNnjCAFyf1f8hibNQxBQFgdiXrjWDPYr2f1vePgOXg/f2werI58pm0raw5zsYeqBdvnitYj9bHk/5vJ3DRA0cn8F9G1ntJerGXSgeG+XYHHe+FXDTE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(376002)(136003)(366004)(396003)(39860400002)(451199015)(316002)(478600001)(6486002)(6666004)(66556008)(66946007)(66476007)(53546011)(31686004)(8676002)(4326008)(6506007)(41300700001)(8936002)(2616005)(2906002)(44832011)(186003)(26005)(6512007)(5660300002)(36756003)(83380400001)(38100700002)(31696002)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MkNhM2M2WUh0bWovSm9QTE5BTGpRVWZEaVVUcTZhcWhtcCtpdHRhQ3cvaGtY?=
 =?utf-8?B?UlpQdUxZUkplOFJYMzNRU0hvWkNNN1RGUVBNL3hPRXplWjhuWHZnMjkyZUx0?=
 =?utf-8?B?Unc0YkFpNzJiQVUrVk5sOGsxTkdKcHBuL2RMQ3MrNmNpbG9oVWZkampZelVn?=
 =?utf-8?B?OWJBZUUxNng0YXlwRjJGd2lxeWRCYTZxM0Y1MXM3ZzZqLzlYUXcyUFR3eUNG?=
 =?utf-8?B?Sm9Ma2s1RFpFd1pJUi9HcEVrY1dxdFpGQmY3RlhTMFpqNDNNYjVGdnpuYjVu?=
 =?utf-8?B?TlNpSmJmZzRUUExnVitSOHg0aXh5aXNLY1Z3bzZPMHA2ZHptcjU0c2hrYm41?=
 =?utf-8?B?bFBxcmhnZ2kyNmV3Z2RZNlRldE1HRUZlMHl5RExMQStlVlV0Umd5QVE3WnZs?=
 =?utf-8?B?Wmwwa1pGR2dFNVg5ZmVLdVY1VlV5eUdSWkxsd2xTQ0ZjTGNzRzBieTlaK2lY?=
 =?utf-8?B?aHdhNDJTclY4NDZtdkgvVnVWTUU3Z05JcVZQdUNQNHVxMVovcHMyN25jMUd5?=
 =?utf-8?B?MEorRWVkcnZ0SmtqVDNFOG40c3ZFRU5Ddld1M0NGeFgxNXVRSG9Rc05HcWtl?=
 =?utf-8?B?akJXMEN6MVdkUmdmdThGbTd1NU9qcGZqNkxrc2RJTzBkUXQ3YnBxY0JScnV5?=
 =?utf-8?B?eEtoRVNzQjhKZkhQV2NhaXU1LzcvdkNFZnV1VFQvV1g1NzlGY21IVFQzVjRG?=
 =?utf-8?B?VFhmT254cGNjbC9aVFh3UFlxZXg0Sk02ZzMzZjc2a0w1bkxUa2RKQ1V2T2ht?=
 =?utf-8?B?cXlDM2J4WnRiSUNrQkl0Y3JaeUVpZDdtQ0pCVjlMWDJnSmlLR1Y5TXdoSzBB?=
 =?utf-8?B?NFpROVo1M3RKQ3JweDNkK3ZEaUxHZEd5NzVJMHlTWUxKeFJTN2luc1MyY3NN?=
 =?utf-8?B?UmlhRnJFUzlocHRkM0U4Nmx6TlpwSmpEakdYU0NoQWI1TWhhMnhjN0NUTXFj?=
 =?utf-8?B?QzRMSDBXbGcwWVRSSDl1TllqRDk2QzEzaXlTcmt2RGJZOUJDRGlvNk5pL0hT?=
 =?utf-8?B?d2hxWEU3NS9QUG4zN0hZaXNqK1VWQ0pPcVRxdWdRcm9lMDRXYmRVdHB3UGtk?=
 =?utf-8?B?WFlpVmk1eld4M1hSMG9rU3JMdml5ZmFzdFhpZzVsK1JZUnJxODlvL1BObHdT?=
 =?utf-8?B?TXZjbWlYMEpvTXZqMUh3QjNYR3FTTDJzemc2SVg1cCtYOEhpblpTcmM0Z0NO?=
 =?utf-8?B?akdWcjluWWsvcHF3Ylphc0RuU1JVYkxocm9tNHFEbytXNjVPVTNWUEFPWUJ3?=
 =?utf-8?B?Y0dvL2lpdEtKMUFORTRWR09GaUVCRnhoQkptR0liTW5kZDN2ZDBYTlJDSUpn?=
 =?utf-8?B?L3ZZUmllYXlCbUxOL0xXZ3lyaE8rTjFmSTRuRzRBNVllOEExWk04dzEvUDZU?=
 =?utf-8?B?TmdWTHJsL1lOckxEYmdDRGFTOGNROVZVQ1RHRnpzMHVBckhkbStMZ2I2NkN2?=
 =?utf-8?B?MFpWRXVSK0tVeStIdWp6eVhPM2F2c0NEd3BQUzdPaHRjZEg0RFc1dzUzMTY2?=
 =?utf-8?B?WGFtd1dGcDN4eEVHL2JDbnlacitBdlRvWk5rVDBEcy9vcTBwK1lDUHo4R2FK?=
 =?utf-8?B?bVpGdWZsZldoKzVJdldKeHFUcEg3SkRHVVlRM1pLdlRaVCt3TElkZjFiUFJN?=
 =?utf-8?B?cjFScDc1ZWFmcndyUmZCN2F6dG9PSG5rRm5nMTFNc1pGTlVDaW5KVktrRmZQ?=
 =?utf-8?B?ZmQxZ2M3SVhxK0ZWYk1KSkcwVGxhbDRzc0dsUDdTeTVHa0NDblR1TWVER0V2?=
 =?utf-8?B?alNmZlFFUlpVbkNsUG8xTElSa0hLTlVtVlFHMkN2Q3phSFgyZjMybVQxNy9L?=
 =?utf-8?B?U0xZS1QvY2RhWllyMWgxUVhreGdNNDVGNk1rZWFTcU0yNzhsdVpWTStReHRz?=
 =?utf-8?B?bWZrd1NNT01kUXN2cHMycW9BVWpvZFZaOXNRUWV4OExUNFhZRmkxZWd1dHZD?=
 =?utf-8?B?a0Z4WEV4b0NvUXcvUE1pZFYxbFh1djZWNDFVekZPQjNCdytaa1N3QUJQMmMz?=
 =?utf-8?B?Z2dyUktaMForSUpuOEhxTHBoWXJjVHhYQmFSWWdDK3Q0bDkvYWNKZ001cDBj?=
 =?utf-8?B?S2JqdGpMV1NzL0w2QVYzVXZwc1dxMHpuVjM5eTVUSlFmQ3M4VnFMZDZGVWw5?=
 =?utf-8?Q?5yU9tWa0GPI4aQgyt2tRaHQQt?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbc22e45-8296-4c33-ac05-08dab329fa8d
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2022 06:03:30.8090
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cKxu1QGlHb0i1pFtYRgGgm0nE9DStqnq9bcqkcmygjk4YTAdhLqXBeXdqS9UynEwT0exYBugqKCDxtY5XiR9tg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5380
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-21_01,2022-10-20_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 suspectscore=0 spamscore=0 adultscore=0 mlxscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210210036
X-Proofpoint-ORIG-GUID: r9DJqFxdP1-uZDtWqZeNJDm0tpY1N8jQ
X-Proofpoint-GUID: r9DJqFxdP1-uZDtWqZeNJDm0tpY1N8jQ
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 19/10/2022 22:50, Josef Bacik wrote:
> Currently we are only using fs_info->pending_changes to indicate that we
> need a transaction commit.  The original users for this were removed
> years ago, so this is the only remaining reason to have this field.  Add
> a flag so we can remove this code.
> 
> Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Why did we miss my rb though some of the patches have no code-change, 
for example this patch.

Hm. Let's move on. Copying RB from v1.

Reviewed-by: Anand Jain <anand.jain@oracle.com>


> ---
>   fs/btrfs/fs.h          | 3 +++
>   fs/btrfs/super.c       | 3 ++-
>   fs/btrfs/sysfs.c       | 4 ++--
>   fs/btrfs/transaction.c | 2 ++
>   4 files changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
> index 2d06add70695..7b221d37ad0e 100644
> --- a/fs/btrfs/fs.h
> +++ b/fs/btrfs/fs.h
> @@ -90,6 +90,9 @@ enum {
>   	/* Indicate we have to finish a zone to do next allocation. */
>   	BTRFS_FS_NEED_ZONE_FINISH,
>   
> +	/* Indicate that we want to commit the transaction. */
> +	BTRFS_FS_NEED_TRANS_COMMIT,
> +
>   #if BITS_PER_LONG == 32
>   	/* Indicate if we have error/warn message printed on 32bit systems */
>   	BTRFS_FS_32BIT_ERROR,
> diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
> index daab56b6a582..7e9c1bff2fd6 100644
> --- a/fs/btrfs/super.c
> +++ b/fs/btrfs/super.c
> @@ -1534,7 +1534,8 @@ int btrfs_sync_fs(struct super_block *sb, int wait)
>   			 * Exit unless we have some pending changes
>   			 * that need to go through commit
>   			 */
> -			if (fs_info->pending_changes == 0)
> +			if (!test_bit(BTRFS_FS_NEED_TRANS_COMMIT,
> +				      &fs_info->flags))
>   				return 0;
>   			/*
>   			 * A non-blocking test if the fs is frozen. We must not
> diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
> index 0d98984af0e9..eb1a98991ec3 100644
> --- a/fs/btrfs/sysfs.c
> +++ b/fs/btrfs/sysfs.c
> @@ -250,7 +250,7 @@ static ssize_t btrfs_feature_attr_store(struct kobject *kobj,
>   	/*
>   	 * We don't want to do full transaction commit from inside sysfs
>   	 */
> -	btrfs_set_pending(fs_info, COMMIT);
> +	set_bit(BTRFS_FS_NEED_TRANS_COMMIT, &fs_info->flags);
>   	wake_up_process(fs_info->transaction_kthread);
>   
>   	return count;
> @@ -961,7 +961,7 @@ static ssize_t btrfs_label_store(struct kobject *kobj,
>   	/*
>   	 * We don't want to do full transaction commit from inside sysfs
>   	 */
> -	btrfs_set_pending(fs_info, COMMIT);
> +	set_bit(BTRFS_FS_NEED_TRANS_COMMIT, &fs_info->flags);
>   	wake_up_process(fs_info->transaction_kthread);
>   
>   	return len;
> diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
> index bae77fb05e2b..7b6b68ab089a 100644
> --- a/fs/btrfs/transaction.c
> +++ b/fs/btrfs/transaction.c
> @@ -2104,6 +2104,8 @@ int btrfs_commit_transaction(struct btrfs_trans_handle *trans)
>   	ASSERT(refcount_read(&trans->use_count) == 1);
>   	btrfs_trans_state_lockdep_acquire(fs_info, BTRFS_LOCKDEP_TRANS_COMMIT_START);
>   
> +	clear_bit(BTRFS_FS_NEED_TRANS_COMMIT, &fs_info->flags);
> +
>   	/* Stop the commit early if ->aborted is set */
>   	if (TRANS_ABORTED(cur_trans)) {
>   		ret = cur_trans->aborted;

