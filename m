Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C98740DB7E
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Sep 2021 15:40:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240260AbhIPNmD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 16 Sep 2021 09:42:03 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:13344 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240170AbhIPNmD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 16 Sep 2021 09:42:03 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18GDLEcs010932;
        Thu, 16 Sep 2021 13:40:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=XVxFx4hLzYCB1wWValaZRKrMPrBF+a91l8ErEOFw8yk=;
 b=cRz4qV9lM3ZM0vj04DhzuM67qWhI6eIHbuc4atCOdfpFR2aDqPQLr1YXWMBJY7UH/4mZ
 ToQ0K4N4UbTQRdcR4X+ck4oBlcrDRTa61QYbRxyRCapn3kWORVw2ozqFFx/kCA0qnJNd
 6+ZfutcdzUMBCRMKUASG7rdB1+MErLqgckPmsgAFoWWJBqsChVqQbtxoWE9QmEHbc0f2
 ywjqkPtXE5rmtCVpnr534eQlq58C1qpNPh3ZWrfrVVWpePWFZVzDTF+6M7d2EYZIdA+R
 0TgiYLAPR/kCwpgwly4EcEyYwOt0xnbb9vcQLoTpSrLB0RPN9naROOiXRvXDm3dVO07j +g== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=XVxFx4hLzYCB1wWValaZRKrMPrBF+a91l8ErEOFw8yk=;
 b=h4tyd5HTr1j0W5RQ0F/bh3Vp4QnFuKg+lPEzZWmneCfxZpDLmK8kdI8R0A4q/ASeSduP
 uTEMV/rYyfo7mMTZVo7AhMuE2aAcrA4q/WIIPJcfJRQO4MBKqQ+zZgXXKuY8AtJ4m/Kc
 rJDQvt4IjVvutsY11i8/Ko51hRB3FNHULe68HaF37/yJx7kb50avPEh3kICDWzI7Ur6L
 4cX4lKr8qfbIgS5vuLUptYqr/s//rEpHs/kiY6UsFrbyjZuZhe3y5E0p+yWVsdREB0aM
 Z1/lC4+CluCX9ru1Iz5yjaX0eeOQh99H0LAx/1ozA4JMb03Nihw9CQHR0HzJs5omEaSh Uw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3b3jysknnp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Sep 2021 13:40:37 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 18GDcjcN185922;
        Thu, 16 Sep 2021 13:40:33 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2174.outbound.protection.outlook.com [104.47.57.174])
        by aserp3020.oracle.com with ESMTP id 3b0m99bwqd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Sep 2021 13:40:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OrytzTFWUbKSYcnJBZ5a75BiE8hGzUYQ4AHOZbIzT8yS2k3BTyQnlHr+ZP1JDn5OwZ9o3kH8zvY3cygIcjdtM2YHPWyQrJMWIeVDcAwmD7NBNQuAskpunBGbzrilhVu9yGcIY4sZhvAuUi+Bt3oZcGpQ1lPpE79LqcEWou4QQxPrtFoeM3/ySz3rJ1wFzmpJB2bgW/WgIeNoWT9D0ATd8dwKGHfj/qMNPGTFz9KbhR/lBJupBNm7XqqA9LrTPUGB/lVeCIcM78qCDUn1eMkf0WCJ9iGOrE6PLZgxvRPErEJQdIOnatePZfIEkMHaBzxFXBAiaBbCB/zTrDtluQVR4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=XVxFx4hLzYCB1wWValaZRKrMPrBF+a91l8ErEOFw8yk=;
 b=ZRw1PRcres5yYd0EAz6erXW4VSV1tz93v/ncxgDx4DGMzVVY9jukjOwRlba0EO0IIHVxsftVfIE89FLeguSfkUsenpQCL+xacg4t4uFvWWNVYXF8kD3uVh8TaYWmeWmD/mlY37tBZw/fDffXUmVEZ0UsmG430wIRnXX+9ph8m54KESvyO5LQ8R5fFWVmnoMNsVD+jfxn2O49M8Am8jZdmqQ4anOeoQ+fzNu4umZI4epG/2RDm2RxxrqjkBtDNtWsu+7jJzVxqKB57oeHvqN1G0TwmIXl7SVAoPU4PNHLVSS5C4Pd8bkbpFtBoB4Z9kNYZhe0Am+qWWPrzgxlTDvNfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XVxFx4hLzYCB1wWValaZRKrMPrBF+a91l8ErEOFw8yk=;
 b=sgjRo/BTh9931j59e8UHq00yHfAMQNeeMgO4ETAqblzzStLOh+87ZtOUhzgwrR0RmmmeXDWR440qCvnBV4FYh8DWterzs7bM0jXTP8g+ej8If69G/TDiYDiDEWOyhWcJ9eOItPnajoN7en5XB2fQM6OlB+g98YmalBqEjp017a4=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by BLAPR10MB4820.namprd10.prod.outlook.com (2603:10b6:208:30c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Thu, 16 Sep
 2021 13:40:31 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::49a5:5188:b83d:b6c9]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::49a5:5188:b83d:b6c9%8]) with mapi id 15.20.4500.018; Thu, 16 Sep 2021
 13:40:31 +0000
Subject: Re: [PATCH] btrfs: prevent __btrfs_dump_space_info() to underflow its
 free space
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Cc:     Eli V <eliventer@gmail.com>
References: <20210916124329.65141-1-wqu@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <36506f2a-3147-b83c-4b74-af44a29d445c@oracle.com>
Date:   Thu, 16 Sep 2021 21:40:22 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <20210916124329.65141-1-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR0302CA0021.apcprd03.prod.outlook.com
 (2603:1096:3:2::31) To MN2PR10MB4128.namprd10.prod.outlook.com
 (2603:10b6:208:1d2::24)
MIME-Version: 1.0
Received: from [192.168.52.145] (203.116.164.13) by SG2PR0302CA0021.apcprd03.prod.outlook.com (2603:1096:3:2::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.5 via Frontend Transport; Thu, 16 Sep 2021 13:40:28 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b75e6167-de7c-4f25-7bc6-08d979178d42
X-MS-TrafficTypeDiagnostic: BLAPR10MB4820:
X-Microsoft-Antispam-PRVS: <BLAPR10MB4820324C211F0542C1928903E5DC9@BLAPR10MB4820.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V7UC8GQeifEu6wTAxj9pydIFaF/P2b2JjXED6cWxWlsDTlB8DcChDrL594WuFjUKK2OhYywohkvaMXmaOhifYXuR1QA/s+IvrKFFv39dw9gUaDXvbrAlCz2yqNLiwsPC8XNpLTQkbY3v4QXZj16+9GT1wp/FpqpxvHpQmLLetvhpssCYwb4fjvx3hO/SygEemyAvWxQm8HGXGWV33Qled3mPHCVhIacKQeSPjj6iYKATGLqe54kCQ9gbzTfenZXoQL0M8ZfP7krRnkpKbueE3tMra1VkOa/m9ysJ7oiaOmsz/O44WUisx9X8aKbpaH5UkRD6zYO4jSkK5YJNN975jGPDLM1h8y1RA9+kMpHl5sPDxkZ56SXyMdL/v7GOCNBM7XhGFwgcczCgC3jmJF40MPZ6WxCHzQHpVBnxITxMcxVwS/s7yN6LeYBRfSq3qa9JS+GRdWCDY6iK/CD/0apFFjqNNnFjZTcR/F5G+cZ+MFUx7+tppldaHuPXkQqR8f/3JjAUSbWifASjiEF4BilUPPcxD3hnkUqfmZejuO8ed+DyioeDiyOUmQMtyEIKUl0YUp3XlHDi96Xhcd6QeDAznvX/7d6sV+y0B0XmSH4+yzkl8DbQmoDNdSsmi94D/vS8K1X1QhtSG/eSwKib9Ym3WGjcSo419EmHIHaoy/b9SVDj4QBqVKqv2sPvFsHCXe+KLbulI19xCx+A/oNXyKhQdac4EowhTd6S7Jv+TlwTnSZ/i9zk09EGl/ChMFHx8TuO8pPtACmQOjBL/q3wJdM84FE8iPaTLbYALYGwAnkLq2xPSTyb4Hm3ErM+01rhHvim
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(136003)(396003)(366004)(346002)(39860400002)(8936002)(5660300002)(26005)(316002)(966005)(186003)(16576012)(38100700002)(31696002)(8676002)(6486002)(2616005)(478600001)(66946007)(956004)(66476007)(66556008)(4326008)(2906002)(53546011)(83380400001)(31686004)(44832011)(6666004)(36756003)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U21YTkV6SzBwTkIzZGFRQzk2WnpaejRUVTV1RW0wenBxNGtpaTNXUUFScE5H?=
 =?utf-8?B?K1VmZTE2dVZSTGdxR3cyK2hlVGMvMCtzbkxCTlo2SjZ4M25mUHhyNlNZMm1D?=
 =?utf-8?B?UFIvaUVwWExnUFp5M3FtL0pxbzlBUG5EQzEwRXZ3dG03L0sxVS8xWGFuZEhy?=
 =?utf-8?B?dXE0alBGU3NoaEdjcnlNNUhtNCtUMTV3ZFBYL3BLT0JNblY0Y3RGL3Z0RjRU?=
 =?utf-8?B?NVlVNGNhb2pBdnhHblFlM3hXWWpTcElHeUgydHJ3RmdhbEYxZUNjTDMvNU5Z?=
 =?utf-8?B?Y2Iwa3Z4QWRoUFdCbUlJcFF4VjdpNlFaSnBOeGRINmZuMmcrS043amhsUDVQ?=
 =?utf-8?B?c3lHZVpuT3VXM3BtQ00xSGJBK09zZHJ6Z2w3MmgwakwzWjN0K3FKQ0tVZXZt?=
 =?utf-8?B?NWc5anNhV2orcWhpenBIbkJ6MlBSeThDUVN2RVNGNktqVXdaWEhiM1JFWU9N?=
 =?utf-8?B?WGZpelFlTmd5TVdKUWJ4M3R1TDlEVGdTWmxpRHNWME92R1pya0xLU3VLek9u?=
 =?utf-8?B?WUdUbTVlcGdYbjBCLzVHaG9PNjlYd0RQY2E1dStrMFpNV3Q0b2ZEdG5oQ1Z4?=
 =?utf-8?B?K0NPb0czNElUY0V0RmlBWVlqdnIzTDJUeVVXa09HbUF6b3gwVXRIWnhkaDZB?=
 =?utf-8?B?U0h5NlBSd0pIeXBmUTJKbEZtU1I1eTRSRDVPbzM3dHVzWEF5dyswcDFVTUc2?=
 =?utf-8?B?UDdlZ2RXV2hRYTlGVHBGbDN0Tjc2OGE1RFE1cjg4VVVqNStGTk9SdVl1dWhG?=
 =?utf-8?B?OURvVjA5Z0FMRGZBUW1USkV0TW1ucHdmZ0Yxbm5qRCtYbE9pNE9XcUJOam4x?=
 =?utf-8?B?cGtKLytnek5qRGZXa2hyRytBc0ZiV0tDaTRXU0RXZk5YTnVMTVREMGE4cklp?=
 =?utf-8?B?Y3FOWVlrbytyMzl4dmUzbHE0ck56MlI5cjZ5ZHhMZWFtNldlcmZQQlFTV1ZY?=
 =?utf-8?B?a3pzM3RHNEVFVmoxUGs4M1p5V1hoVWYremxScmJJeE02R3BvTVlIVi91S3BJ?=
 =?utf-8?B?MDQ2M1BUVjhQa1VNaFAyRnFLWXpXSERDVEQvR01mblNLSC9GVmJ2S3MrQkU2?=
 =?utf-8?B?S2hUb2t3NDJQT3pVRFI1OGZlc05pY1AzY1JFbitUOWEzd2tHbHJuYVZidjdy?=
 =?utf-8?B?R3VjWCtKL0pQZk9RdldDYkRlcklJTXA1OTNxVXdqVE1MQ0NoVGVXaGh1cWFZ?=
 =?utf-8?B?Njl4V0V2dnpaQ0NnOFN1eXFaWXRQSG9xckJBOTdXSFBsWWQ1NlBHZE15YUpm?=
 =?utf-8?B?Rnlua3QrZ1ZYODM2OUNXOXUxeXF5L0w4bndmVHFUbmgyblBKZW9nRDFSTWV0?=
 =?utf-8?B?Rnl4cHQvaitJTFF2VjNQcHdNdGJ0eDgrRFBwYVdaU3hkOWRGY3pmS1dLbGFQ?=
 =?utf-8?B?a1BQZTI2OVk2b3NJZTZYTU0wRDdaQWZIdnYraXVySlAvcXVHNDV1UHNvbXhP?=
 =?utf-8?B?VEE1R29ISE5xQUcveHVxZWYvVXYveUpnMkQ5VE90ekVFY0tVMldsUllTWEJw?=
 =?utf-8?B?TERFcEZ3MG4ySHFCRVl1RFIzVXozTTBLTUJQSXZaRlphbFgvbjg2WHJFQTJ5?=
 =?utf-8?B?ellOL0FvQUlDUzc3WjlUd0Q3OXoxMkRtaVZ2ZnFlRkpWT0pYK1dmWDRUTWF6?=
 =?utf-8?B?T1lFeEk3RmoydHFYM1hFKzRlbVhwQXBlNFVwRjZVY3VsWGRFWnFFOERLZU1q?=
 =?utf-8?B?MzdyVkR3c2I4ZVRud1pwam1tQm93b2syNDkyVTJaQ05hbGZsUXk5Q3pGYkh4?=
 =?utf-8?Q?+unfeHTgJUUqpBWh0xn5Ey9RUR6daorGb8jXPQo?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b75e6167-de7c-4f25-7bc6-08d979178d42
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2021 13:40:31.4154
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Mkjfoa8HDOMd+yrrBkxJ34Fq9toppdOpAKCatdDfXzDuNRWcXoPNLu+l2VNHXyohkysjxuH9OeWn8rCxLGUOkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4820
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10109 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 malwarescore=0
 adultscore=0 mlxscore=0 mlxlogscore=999 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109030001
 definitions=main-2109160088
X-Proofpoint-GUID: scLEAsLTJK78E5W5JcmxnhVZk0nlHDk-
X-Proofpoint-ORIG-GUID: scLEAsLTJK78E5W5JcmxnhVZk0nlHDk-
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 16/09/2021 20:43, Qu Wenruo wrote:
> It's not uncommon where __btrfs_dump_space_info() get called
> under over-commit situations.
> 
> In that case free space would underflow as total allocated space is not
> enough to handle all the over-committed space.
> 
> Such underflow values can sometimes cause confusion for users enabled
> enospc_debug mount option, and takes some seconds for developers to
> convert the underflow value to signed result.
> 
> Just output the free space as s64 to avoid such problem.

  Yeah. I don't see any reason not to.

  Reviewed-by: Anand Jain <anand.jain@oracle.com>

Thanks, Anand

> 
> Reported-by: Eli V <eliventer@gmail.com>
> Link: https://lore.kernel.org/linux-btrfs/CAJtFHUSy4zgyhf-4d9T+KdJp9w=UgzC2A0V=VtmaeEpcGgm1-Q@mail.gmail.com/
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>   fs/btrfs/space-info.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
> index 5ada02e0e629..e9a562d96ba6 100644
> --- a/fs/btrfs/space-info.c
> +++ b/fs/btrfs/space-info.c
> @@ -414,9 +414,9 @@ static void __btrfs_dump_space_info(struct btrfs_fs_info *fs_info,
>   {
>   	lockdep_assert_held(&info->lock);
>   
> -	btrfs_info(fs_info, "space_info %llu has %llu free, is %sfull",
> +	btrfs_info(fs_info, "space_info %llu has %lld free, is %sfull",
>   		   info->flags,
> -		   info->total_bytes - btrfs_space_info_used(info, true),
> +		   (s64)(info->total_bytes - btrfs_space_info_used(info, true)),
>   		   info->full ? "" : "not ");
>   	btrfs_info(fs_info,
>   		"space_info total=%llu, used=%llu, pinned=%llu, reserved=%llu, may_use=%llu, readonly=%llu zone_unusable=%llu",
> 

