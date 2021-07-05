Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9931C3BBD54
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 Jul 2021 15:07:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231149AbhGENKU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 5 Jul 2021 09:10:20 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:7514 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230188AbhGENKT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 5 Jul 2021 09:10:19 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 165D2q9T028114;
        Mon, 5 Jul 2021 13:07:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : cc : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=xIpZ/HbbSuBrZW2ZvVIB0r7/DT6CpAqnqHkrhKVYsDw=;
 b=uJxWK6KY00TcGEOoZxJmmihpweBlFyn2V3qDTv4NB7wcAD1b6awW/n6Khi0a+Fla4ACm
 Nv5CxKDcQnO4thVlYYbUnsP0/JKZjwnPDVQiIjOdYmVMhSk4yaj8QatO0JVKIJnnF2kn
 Bb2POmDjbI3FDskPvtuiGlMjVWfxDeVJBhJs8RzEANWiRRSl9TVjAy4CDLfGpmuVw/6G
 3OK7+SyX0enMeQC4AsS424U+5K4PzprEvHj/RoMgjSHkKOG5folBV9D0i0GNQaVujtRB
 ipSJ0U2VGIGujdjENHFYnddzrFfLCQon89oibgMja1LE/Og9x0AJReT2bnNwD93mjcLa Vg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 39jep1jm8k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 05 Jul 2021 13:07:40 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 165D0RuV056854;
        Mon, 5 Jul 2021 13:07:39 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2047.outbound.protection.outlook.com [104.47.51.47])
        by aserp3030.oracle.com with ESMTP id 39jdxfe4kq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 05 Jul 2021 13:07:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hqVfKTdIg3znpPBcKtFtzbFDmDBxy41B2nuIqzIdwgWxo998NEenJ59CAuY7e6m+jdwVe6RJZi42oha9L7jI/iHIDEKKdNP+OjdhKWCOl2UJnZG5XkuF3r5oT1NCC9maeRcsMFF6JkRCrAH/Q4L73HDKX6N64pU1/mDb3FVGWR2LE2siIs+ZNj5kSJiZL2t60+hmXfYKoaVlGszvg8VB9yAPhV03PeEAIwY7YuEU4zY9RvZUz9NXnxXTDfGG8Wvu+IupLPKEMvS467/LJEJA5pBq5oUNbE8b7jHZmh21AngfIjY4D3hTgKO8H13RR9wep4lm3+C4CL5U+SfOLZqI5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xIpZ/HbbSuBrZW2ZvVIB0r7/DT6CpAqnqHkrhKVYsDw=;
 b=QN2bv2m1UvO/MBkW6TMJtt6DVTq/drSN1GjeAJLwUyR/tjLiN6cl53JHmseOd5Em1qLrQhBcxEWw9irVMPeTWMo7twPPL+WEJ2cVmZDyzA0onXVu3fu03/JbSd+N3m4MLqBhYazI9vBcio2T4SHptyTj3K1QU9qV4dy3o+YzMbKaYYo9R6XztwvIqZ+HzqT06X5BNDujqqdyVc8mQBrdKffCayUFE6LAqmnefvybGxjCfwDmUJr1899XOCcECJc9mLmC6nZdm2XnAtlUIdxpvQ5Xb1qV9PO3xFNt8U1Eh972XRZCyhOAns0l09TjkpKu26wMjVzo05AkR+p6z4OsxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xIpZ/HbbSuBrZW2ZvVIB0r7/DT6CpAqnqHkrhKVYsDw=;
 b=kLYesIHeKPvvHynYkbeyiN1mOsMSWYFQ2MKXS5yTqRjsK5qw/NcTzv7h8l4Gd9Ljl/HQ5GHB1lk86zghiwLjuPcPYxZITE1h7cAt2Oy326ih4t+gSZ79tOorrzPlIVWl4RASS+uORV4GNRZ3+PgU74CKog4h5VQe47Ms3z1/sUM=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by BL0PR10MB3060.namprd10.prod.outlook.com (2603:10b6:208:79::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.22; Mon, 5 Jul
 2021 13:07:37 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::b10f:7144:1abb:4255]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::b10f:7144:1abb:4255%4]) with mapi id 15.20.4287.033; Mon, 5 Jul 2021
 13:07:37 +0000
Subject: Re: [PATCH v2] btrfs: rename btrfs_alloc_chunk to btrfs_create_chunk
To:     Nikolay Borisov <nborisov@suse.com>
References: <20210705091643.3404691-1-nborisov@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org
Message-ID: <111bbcf0-e6d7-9d0f-8287-3426853f7882@oracle.com>
Date:   Mon, 5 Jul 2021 21:07:29 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <20210705091643.3404691-1-nborisov@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [39.109.186.25]
X-ClientProxiedBy: SG2PR02CA0053.apcprd02.prod.outlook.com
 (2603:1096:4:54::17) To MN2PR10MB4128.namprd10.prod.outlook.com
 (2603:10b6:208:1d2::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.10.109] (39.109.186.25) by SG2PR02CA0053.apcprd02.prod.outlook.com (2603:1096:4:54::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.22 via Frontend Transport; Mon, 5 Jul 2021 13:07:36 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8d916671-bebb-416c-5ca5-08d93fb5dcc3
X-MS-TrafficTypeDiagnostic: BL0PR10MB3060:
X-Microsoft-Antispam-PRVS: <BL0PR10MB3060BF324A563BFA5DAA7893E51C9@BL0PR10MB3060.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iYCRo0/QW7ZcEwScseSGRQ1RkoLMCj8JmT5OEUI6VvXBkDtHoW4oUGLzeNmyDpLnu8ZALSi/7cPV9Dez9Rdc3rDGNZ6OzaXb+1O8gmTvqPDRQWaRMmmjeyWwjidY6Wq30TNoXGHMaHuY+2GW0QY+9uVa5tYfVk3oi8e5W8b74mviuoG9V+O15tHRmjtNkjKi0VtRGQP/vRkyKspjW0alxGg31flYPE4sOWd4VucvafZSBMNXubcx74i5RIaetBEDht0smH4lao61eMLXllTVEg3NB+KoWglEM+MVfl+jribOP1g5h30P6s8mYKsUMNpoO4wdEKR+o5uMfKuPDia7zMvU7plB7rqCQgGs7DU7ZoE9qph8C7s4lfgMLbM/2+0Xw/P8Bg0qFklXlfMIZavCwp53ljXCnTmg1b+tuM1gFOO3oExzb9wlLk2gpcglaBejPMvtA/QGuAwXRJlJWe5UA0SkWhFfPjrGPuwxfe5cVwF3raQ+bj9AdjZx+iFQrLFQ+aurbmVMBgSVeNvbsav70KjPkCKLOJFfuEHKqluT136/2AD4PG/Y5GjUbT1hcPCshjF7dZx2GQBvSr2aEm54sVD7UBm/CPaihb6e04dDyDo6lfNdw1dAFFEO+Ocxf4fTq0t3T3SEqu8zB7ROSdv/91ccS3j7R6vhPpvvKYKKF1jiHuanSeesLHGV81lJrAhNJPq5hTxw+x/K0UOTc7uEzmBC8p+mw7DeFZOpgWbAveQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(366004)(136003)(376002)(396003)(39860400002)(16576012)(6486002)(316002)(44832011)(8936002)(478600001)(6666004)(6916009)(36756003)(66946007)(8676002)(5660300002)(83380400001)(956004)(4326008)(86362001)(2616005)(31696002)(53546011)(2906002)(16526019)(66556008)(66476007)(31686004)(38100700002)(26005)(186003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bE01SDB5N1ZxRzJyc1o3cEkxcFRpa2lRaDJBWUtTTDI0cDgyWmw0THhVMFFy?=
 =?utf-8?B?ZTVRZjBjd3lNK25VNC9WdGxlTDBDM2QwYnpNRG9ZR1ZmNWxDQ29OMytEbWJK?=
 =?utf-8?B?cmVJbGgvWm5hL2JJSlVRUkliTzhQSVVOVzQ3V0swaXI1bEZ5OUNnT3Fpb0JR?=
 =?utf-8?B?L0piQ3JHOGdUcUhlVC9aS1lYVzliVmlqZ2trWTZSSm9nVDkydFUwNHVxSzkr?=
 =?utf-8?B?UnNCUEFTcDFOU2YwR2ZIL3ZuOTQ3Q0xLS1ErSHhGOHJheDdvNkcwOG53dmhq?=
 =?utf-8?B?T0ZiSWtJTUFIQldoSFVmVW9zb0MyU214TXN6d1BKOG9iNjgySWhwMEdaSk1k?=
 =?utf-8?B?UytoNExOWGpMK1cyM2pLM2hBZCtPdVUreFZzNzByZUFmUnlsZ2xtbzhxN016?=
 =?utf-8?B?VWdvVDVMQ0lsK2lqTTdrUk5LYlJIMkUzNjNCRk44QnJTS28rTjFVcENpZ3Ux?=
 =?utf-8?B?YnVCY2gzUGhvU2xNVzEzWTA0V3dCdWgwWnV0b2tyek1aZk4xRTFyL3NFeUJx?=
 =?utf-8?B?MlJnUHVaMWx5RUJIQzdnNUZmZzBOdDNkdlRMYjNpODRqTzdIL0FtM1V4QTl2?=
 =?utf-8?B?bTJjbDFYcmtMeW1PeVV5MVRRdS8xUDJNYjZyVnd4ZElORVFlL0JyRzZHUWNP?=
 =?utf-8?B?MmZwaTA2QUQ0Wm9IRHZKcmo2R3dHTHlkcFhCT1dKdWp5SkVQT2ZaQXczNFFU?=
 =?utf-8?B?ZkxSOGs3YTJZSU4wSStZSXU0ZDdMR1NKd0M4UjUxQ2VWaGMxY1hnNEc0d3F4?=
 =?utf-8?B?WDYrbFJQOTBYZFYvajZ2M0ZYL001YUZvKzBmNnFpZmRkemFlOVQvMHIvay9D?=
 =?utf-8?B?MUtrTDJ4U3p1MmpqMWdpWGo0M2RBSEk5SEFzRk5lZVlYdEFyOS9GSGIrSGw4?=
 =?utf-8?B?YjJqQS9ReU5hRk1BZEFMajZxNzkralJ0VjFzSzdSMSt5amgvVVlia1ExZnVr?=
 =?utf-8?B?dDNpZTNUTlErSUsxRjZFc0NOL3d2R1RBeWswTW8ybmxNQTNTaEk2TE1YUFZV?=
 =?utf-8?B?cldxTDBCMzhUUkNKN25ReGRaUGVsRTVkclppRlhISnd3cEZLODFhQTMvSHZs?=
 =?utf-8?B?Mk14Wk12L2x1YnM5TjdXRG0xWkZFcGRvRFNwWGpqa2RuRndqMW5GQ285UFF1?=
 =?utf-8?B?RytWcjZxaVVoVHFCdVhyZXpUc1oxUzV2eUVjZEJXcGJadnlUTW1zKzVCWGl3?=
 =?utf-8?B?YlNJM1BTZTI2Z0VuT1crZnBmVThQV0NQTGs1UjhzajByMWlKMlRmOUxuT0RF?=
 =?utf-8?B?RW5MVU5BeDdTRjFZZm1sNHViMmtXYVNqZC9KVC91QmF0akhhMXQ0M2ZyMTRr?=
 =?utf-8?B?MFR1YjRWOG5YZENTaVNuNlRPUmo2TjI0TmR1UHlNaVhxQjJ5OGhwcnVvUWVJ?=
 =?utf-8?B?aW1XRE9rZ1ppYklTakVWTUpXTzlUYllseFI2aVVvWmowMHNuWVpaUlFDTHpu?=
 =?utf-8?B?UWtBcThnMG1Cc0M2QVoyeVFpVnVucW1RRUNLQVQ5akU0OFUzOERyYXJ5eHlw?=
 =?utf-8?B?NzN0MEhpakc2ZUhPWlVJbWREWTBqNGRKbWp0VWlZT3VMdnNEL2gydTBCdGRP?=
 =?utf-8?B?am5LOXpFVURpZEgxWVMyTmhuSzNRSHozY1FWMzhkNWZSZHh3VEJ3OU8xZzlJ?=
 =?utf-8?B?OUZHdzFGY1JZQmRmQTJPdXBBN0dUTkY4L215ZWJMRHNqRmNycHc5RVUvbWIv?=
 =?utf-8?B?bElYbGVKcHVuUkxtZk9qVUdNSXRyeWNpTFdGV3d0UmU3VGVDTk1QL1M2UjNn?=
 =?utf-8?Q?IH5ZbgQnYEpfIrAuoi6AwXAo8AOe8Mtb5w1kTQR?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d916671-bebb-416c-5ca5-08d93fb5dcc3
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2021 13:07:37.6331
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d35SuYLKxokgvh1+gk0+7HD502q1/pO92jGfohtN2onqL2TlUSiYJ//9v06f91Du/C6OR2TjctqbvEx/hjdgkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR10MB3060
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10035 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 spamscore=0 adultscore=0 malwarescore=0 mlxscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107050070
X-Proofpoint-GUID: -2BYYMO67HHcv4-oJacb_3hRQFPMNY_H
X-Proofpoint-ORIG-GUID: -2BYYMO67HHcv4-oJacb_3hRQFPMNY_H
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 05/07/2021 17:16, Nikolay Borisov wrote:
> The user facing function used to allocate new chunks is
> btrfs_chunk_alloc, unfortunately there is yet another similar sounding
> function - btrfs_alloc_chunk. This creates confusion, especially since
> the latter function can be considered "private" in the sense that it
> implements the first stage of chunk creation and as such is called by
> btrfs_chunk_alloc.
> 
> To avoid the awkwardness that comes with having similarly named but
> distinctly different in their purpose function rename btrfs_alloc_chunk
> to btrfs_create_chunk, given that the main purpose of this function is
> to orchestrate the whole process of allocating a chunk - reserving space
> into devices, deciding on characteristics of the stripe size and
> creating the in-memory structures.
> 

Nits:

This is a kind of fixes:
  commit 11c67b1a40b0 (btrfs: Rename __btrfs_alloc_chunk to 
btrfs_alloc_chunk)


Can you also update the now stale reference to __btrfs_alloc_chunk under 
comments? as below.

volumes.c:
    5005  * Structure used internally for __btrfs_alloc_chunk() function.

zoned.c:
    588          * __btrfs_alloc_chunk(). Since we want stripe_len == 
zone_size,

With that,

Reviewed-by: Anand Jain <anand.jain@oracle.com>

Thanks, Anand


> Signed-off-by: Nikolay Borisov <nborisov@suse.com>
> ---
> V2:
>   * Fix changlog to reflect reality
> 
>   fs/btrfs/block-group.c | 6 +++---
>   fs/btrfs/volumes.c     | 8 ++++----
>   fs/btrfs/volumes.h     | 2 +-
>   3 files changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
> index 5c2361168363..500a85e4320f 100644
> --- a/fs/btrfs/block-group.c
> +++ b/fs/btrfs/block-group.c
> @@ -3358,7 +3358,7 @@ static int do_chunk_alloc(struct btrfs_trans_handle *trans, u64 flags)
>   	 */
>   	check_system_chunk(trans, flags);
> 
> -	bg = btrfs_alloc_chunk(trans, flags);
> +	bg = btrfs_create_chunk(trans, flags);
>   	if (IS_ERR(bg)) {
>   		ret = PTR_ERR(bg);
>   		goto out;
> @@ -3419,7 +3419,7 @@ static int do_chunk_alloc(struct btrfs_trans_handle *trans, u64 flags)
>   		const u64 sys_flags = btrfs_system_alloc_profile(trans->fs_info);
>   		struct btrfs_block_group *sys_bg;
> 
> -		sys_bg = btrfs_alloc_chunk(trans, sys_flags);
> +		sys_bg = btrfs_create_chunk(trans, sys_flags);
>   		if (IS_ERR(sys_bg)) {
>   			ret = PTR_ERR(sys_bg);
>   			btrfs_abort_transaction(trans, ret);
> @@ -3712,7 +3712,7 @@ void check_system_chunk(struct btrfs_trans_handle *trans, u64 type)
>   		 * could deadlock on an extent buffer since our caller may be
>   		 * COWing an extent buffer from the chunk btree.
>   		 */
> -		bg = btrfs_alloc_chunk(trans, flags);
> +		bg = btrfs_create_chunk(trans, flags);
>   		if (IS_ERR(bg)) {
>   			ret = PTR_ERR(bg);
>   		} else if (!(type & BTRFS_BLOCK_GROUP_SYSTEM)) {
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index f820c32f4a0d..4f84b5d871dd 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -3086,7 +3086,7 @@ int btrfs_remove_chunk(struct btrfs_trans_handle *trans, u64 chunk_offset)
>   		const u64 sys_flags = btrfs_system_alloc_profile(fs_info);
>   		struct btrfs_block_group *sys_bg;
> 
> -		sys_bg = btrfs_alloc_chunk(trans, sys_flags);
> +		sys_bg = btrfs_create_chunk(trans, sys_flags);
>   		if (IS_ERR(sys_bg)) {
>   			ret = PTR_ERR(sys_bg);
>   			btrfs_abort_transaction(trans, ret);
> @@ -5363,7 +5363,7 @@ static struct btrfs_block_group *create_chunk(struct btrfs_trans_handle *trans,
>   	return block_group;
>   }
> 
> -struct btrfs_block_group *btrfs_alloc_chunk(struct btrfs_trans_handle *trans,
> +struct btrfs_block_group *btrfs_create_chunk(struct btrfs_trans_handle *trans,
>   					    u64 type)
>   {
>   	struct btrfs_fs_info *info = trans->fs_info;
> @@ -5564,12 +5564,12 @@ static noinline int init_first_rw_device(struct btrfs_trans_handle *trans)
>   	 */
> 
>   	alloc_profile = btrfs_metadata_alloc_profile(fs_info);
> -	meta_bg = btrfs_alloc_chunk(trans, alloc_profile);
> +	meta_bg = btrfs_create_chunk(trans, alloc_profile);
>   	if (IS_ERR(meta_bg))
>   		return PTR_ERR(meta_bg);
> 
>   	alloc_profile = btrfs_system_alloc_profile(fs_info);
> -	sys_bg = btrfs_alloc_chunk(trans, alloc_profile);
> +	sys_bg = btrfs_create_chunk(trans, alloc_profile);
>   	if (IS_ERR(sys_bg))
>   		return PTR_ERR(sys_bg);
> 
> diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
> index 70c749eee3ad..f9e13e8ca703 100644
> --- a/fs/btrfs/volumes.h
> +++ b/fs/btrfs/volumes.h
> @@ -450,7 +450,7 @@ int btrfs_get_io_geometry(struct btrfs_fs_info *fs_info, struct extent_map *map,
>   			  struct btrfs_io_geometry *io_geom);
>   int btrfs_read_sys_array(struct btrfs_fs_info *fs_info);
>   int btrfs_read_chunk_tree(struct btrfs_fs_info *fs_info);
> -struct btrfs_block_group *btrfs_alloc_chunk(struct btrfs_trans_handle *trans,
> +struct btrfs_block_group *btrfs_create_chunk(struct btrfs_trans_handle *trans,
>   					    u64 type);
>   void btrfs_mapping_tree_free(struct extent_map_tree *tree);
>   blk_status_t btrfs_map_bio(struct btrfs_fs_info *fs_info, struct bio *bio,
> --
> 2.25.1
> 

