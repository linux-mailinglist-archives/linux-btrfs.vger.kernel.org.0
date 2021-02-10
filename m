Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6010C316BDB
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Feb 2021 17:57:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233150AbhBJQ46 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 10 Feb 2021 11:56:58 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:36182 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232530AbhBJQzw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 10 Feb 2021 11:55:52 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11AGrwQo057508;
        Wed, 10 Feb 2021 16:55:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=3Ousc+Vlucnz1k57Jfy41a1AkVG8aa1T4X7PpiABuXM=;
 b=XJfGZatpX5UfvfiV2rVZF3e84fr2ImIbzWCLAH2dpxHkN3nKGeuglmqmsj+pkVFwugMO
 51sLQb+ymyP3ogLUQBBsSnKxsWEuLxQXijvrN4cgb6n8jhqMEiExjzQHXkedMqi5huD6
 fkONe+tQ7Q/BWA5ziH4va82BGX0xe8bddF+XDMN2EXax6ltF6NeC8+rN1+BM0EIP7Il1
 ivwm4q/VaefxMFz6KybiIM+ojOT85XAYGhZCBHRMA5EPW8gNUW9HCyGu8N9AjnZQlYgb
 4YbRDh8R3t71PvNw/qxm/mJnnUVacfgj0o21s98onhFD5yzMxpFlOfli5EZ5/SvKRuyd 1Q== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2130.oracle.com with ESMTP id 36hgmambd3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 10 Feb 2021 16:55:01 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11AGnwfI081317;
        Wed, 10 Feb 2021 16:55:00 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2174.outbound.protection.outlook.com [104.47.58.174])
        by aserp3030.oracle.com with ESMTP id 36j4pqd0c7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 10 Feb 2021 16:55:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oHsztcJsUNxzdH0YCzZhB0+7ABnE+6IXCxbH6xTVnR5KQVAeiv/8UK16v846agzTOqv/Fehr3bl7io9fJg1SGCEejXE8zZgOJnTkgwc1RB9R8Vlr4+x6Xhn9d3JK90EatBDKD5vbWCeW25NoLcatcOw4jX5ey+R5uR/J1mhmzn//oVm5qyzfDimdg3YDTZROeNPeuEWpoCJLK3lnnAh+js3ugXIktNQxvuCilHKtv6QufXDfJ+8ulNTNeWsQiycTi7AKbor2pZM+hMZFw60svN5IkqIM4+bwRu68H54BKyh3MrnGLdIfyo/Xw7QQeQyDByvnZaRui+2s8Ai3++6frQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Ousc+Vlucnz1k57Jfy41a1AkVG8aa1T4X7PpiABuXM=;
 b=cWYt2BpYvJaUB1E/MSugGu2yszry+L1GyGDs7Ssh/aK4GHGOLmxHwrSlH0jB+M1f6nsei+J7VjYj8agOUoU4bEsR+IovqTr7mF/eRLyL8JtDmX6VOGnWU4ggJLlXAuZaPwNDWHVO1aR8hJYnsFUwnzl66JlMvO2sW2JK/JcV6Fl1Z1a5FL5FKsWqLbsTgaYHeEiFZb/VOcMRPj1QNxwhm1LAyirBphespVO41442UMeBsowsXRk2o0oC/VKdCm2k5FAILcAMm+oRHO3EMnUtFsAuQdUXx5SQFYpasSqTN7mC/IJ+70+L3UW/Tcq+l2pabSrKP2DvMfZ2OmYloOQ+fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Ousc+Vlucnz1k57Jfy41a1AkVG8aa1T4X7PpiABuXM=;
 b=ilkyFdWNnoVsDD9Rrb8LRW8BRokUfKowD4CIUc/y3s4XvufcG9vuaPlWNJxxjHQXLgQP5/GR5HAcKKXx+5pMs/gWoYZ7rXtk/0hGNwhyJmKRo0c7dfuk9z8TjSH+aS1NwBHvYJzL4a3HlbHyJ2SJUMbFcYFYL3MAJSxbvheG++4=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from BN6PR10MB1683.namprd10.prod.outlook.com (2603:10b6:405:b::15)
 by BN7PR10MB2417.namprd10.prod.outlook.com (2603:10b6:406:c8::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.27; Wed, 10 Feb
 2021 16:54:58 +0000
Received: from BN6PR10MB1683.namprd10.prod.outlook.com
 ([fe80::9d63:7b79:33d4:a802]) by BN6PR10MB1683.namprd10.prod.outlook.com
 ([fe80::9d63:7b79:33d4:a802%3]) with mapi id 15.20.3825.032; Wed, 10 Feb 2021
 16:54:58 +0000
Subject: Re: [PATCH v2 2/3] btrfs: fix race between writes to swap files and
 scrub
To:     fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <cover.1612529182.git.fdmanana@suse.com>
 <e89b5c5bf4518471558237f359590118ae9c2145.1612529182.git.fdmanana@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <cad29e94-f215-ca24-32a2-fc5e0804a43e@oracle.com>
Date:   Thu, 11 Feb 2021 00:54:49 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
In-Reply-To: <e89b5c5bf4518471558237f359590118ae9c2145.1612529182.git.fdmanana@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2406:3003:2006:2288:7932:39e4:bc3:8319]
X-ClientProxiedBy: SG2P153CA0044.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::13)
 To BN6PR10MB1683.namprd10.prod.outlook.com (2603:10b6:405:b::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2406:3003:2006:2288:7932:39e4:bc3:8319] (2406:3003:2006:2288:7932:39e4:bc3:8319) by SG2P153CA0044.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.0 via Frontend Transport; Wed, 10 Feb 2021 16:54:56 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 69e4d642-bfe3-4d98-d3ef-08d8cde49904
X-MS-TrafficTypeDiagnostic: BN7PR10MB2417:
X-Microsoft-Antispam-PRVS: <BN7PR10MB241753AA43F3180B2E685251E58D9@BN7PR10MB2417.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UDpKrOYeeGTgGxgH2l3VAnLfu0xOwNES8BWO8oZ58ucnUK1Nn4a/k3Q0tvj+SuoalYJTAhsbzRSejzfv6xusjL1PzuNp7wTEVtAb5a7zBbMdXXTxG7UIPbg8sa3jlb3eV/Ius07VMJhsTJzkCw8JyMG/hCkSc+cZd/MNS7Gv+Q2WgT/mS/tt2tko4PwK3VahYHjE5QIa7Sx1Jhqr1h76BKbs8mB0AVW3a9W9HJadYHV2fpwJdBcu3Oed7qRq3sfCf+RxARWe2WXnUNy7vq0R+MEHBQI9ipg5lKjmlMa1tzVGfWGcQz51Eh1B9Ot/ZiySUuTHTYfIIY0hnYAu2V2abgkeT/zSCLOpWxlsY/NmNn5INxssp8bELZnx3u2EKoRKbZQCDVwqcfuqLfCJIvDs59C05IIRyGCv4TnQ1guKGmG74+L8pV2gjNDzk7s/z8KaBeSD0NTQFzZLIGJ7E7SNpoQtHhVQ2Bs3mFat0IDBuQWBbjY/rfoVVPsurZNyVemCeh31V06g02dv8ccyQuvaDM7xd4FuS1xm5fP9BgIWfNn4NhD4hYvGGsccCiege4HBZaygdA5JY070fV4ogS07jQ4Kz8FGe+HozsWATPoqgKk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR10MB1683.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(346002)(136003)(376002)(39860400002)(396003)(44832011)(316002)(53546011)(8936002)(2616005)(16526019)(186003)(8676002)(6666004)(6486002)(2906002)(5660300002)(478600001)(66946007)(66476007)(66556008)(86362001)(36756003)(31686004)(31696002)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?Y2xtblFxOGFPbkVGZFRvVXk1SVpaTVcvZUlMdkxoNkkzYzJKbTM3MHRNT0xj?=
 =?utf-8?B?aHZpMFJOTkFGb1poeGpGVGRuWTZrYnl6cE5aZFVQZ0h3YVVPcEdGa0ppMU10?=
 =?utf-8?B?N0lQY09WZlJyYmZiTnJlNm83Z3YxSnBpS3dJa0Y1OGs2M1A5UVJtQmJMeTEx?=
 =?utf-8?B?ZlZVdUQzekxrRWZqN0xrd3k4eE5YckdGaE93aW4xQVE0dDFBYXRjYkdqNkZK?=
 =?utf-8?B?ZmZiSFZ2bmp1Q21mWGtXdTI5VEYzZ2lQVzBJR09XRUJQcHkvd3c5dmdodDNL?=
 =?utf-8?B?TjBsWGZCWXkvQ24xYlRsdThEcjdLUTBFV3JHcTdUSGVaeUJidFcvVXpvOFNR?=
 =?utf-8?B?MkdQamV1bzAxZTJlZ1Y2MHpFY3R5TUVYV2hBeW00Vzd2TzYwZlFkcjhKd1Za?=
 =?utf-8?B?Y0dscDFwcjJORWhsSWJVb09zUnVvcDR1MHVmL3lYeFJmUGs0VzRnczBHcWoy?=
 =?utf-8?B?OVhLTGQvVDNKSGo4ejJtMXNubVl2VzVuaXhveHJBWGZFSWNNWW56UnNjWWh4?=
 =?utf-8?B?andPNmVudnZ4YUF0bkNtdDZpZEVOWDJ4ckdLTXgrSWRVWEtBbzk2YmVVT3py?=
 =?utf-8?B?UVVZeS9XV2FDR25odHQ0RlpXbWhYQTdoY0FGWVZuRlZJZXdFQlpTKzM4djA2?=
 =?utf-8?B?V3B1WjQvWnRGKzc5OEdNdEJyU3VaTllpbWtjVUYzSThCUjg1UnVYY2p6Y2tr?=
 =?utf-8?B?WFVQcVBLUkJXUTZZdzlwd3RlSGJlL2VWNlBQV09hWUx6a2xzanQzSnArZklv?=
 =?utf-8?B?WCt0QzRMQ2l2WWhCWWpNK0RHMThJZlgzd2VzaUM3dTFQVkJpTXRMSW93eFVV?=
 =?utf-8?B?amhOYzczS0JLT1dYM3oxcnYrR1ZVa0w2TUs1cENnZUJZRkJnalNpa3c4Q3Fm?=
 =?utf-8?B?VnFkLzI4TlhyYlhHRi84YnBMNzJlYmVsNkNUZ1BMODRMcXNDbFR2R0FNQlcy?=
 =?utf-8?B?S2tQK28xcDdyUll4eTl0MEtCY0Zqc3VmNVJZOXpTZVlxajBEWURNbVZiWUU3?=
 =?utf-8?B?b3c1RGhoT2NHTXNqUXlWUW5yTmtXZGhPVFRmWGo3Z3ZRbVBSVTJCWUQ5YVdu?=
 =?utf-8?B?alRCcGJOM090NVJHandiL2htNHZJd011OVMvNUZUcGZuNGNYeHpiRXI3bjMr?=
 =?utf-8?B?OE5hakpLYmcva2djSHpjV1lJU05PZklLU1lzenN2Rm5mOEtxZ29odGRCWWs0?=
 =?utf-8?B?ejVZR2tDWGwwMEtWMkgraExETkYvK3F0RFBvK1hKc29mUDYvWXhBbXlDbXc3?=
 =?utf-8?B?MEc0YXNDZHpiSlFxdGUvajJYSm9qaS9vc3ZlQzA3RjUvMnZQYWRWQk9XVXJD?=
 =?utf-8?B?aEc3MXV4NW5NSmowLzJmRVNmOWVVdmYrdDVmVU5vOWY2cEF0VTFUL3FpamVO?=
 =?utf-8?B?RjIwM1djcWFDVm91bTNFQ0l2bG1zUE44d29RYmNqWnRIRml2RWxwdlBEQ3Fz?=
 =?utf-8?B?Ym12a1FGZTUyOVZtNkhCM3cwN2lSUFQ0SitLejd2NExVeE84bU9MN0pjT3Br?=
 =?utf-8?B?MWFvNndraVZ1S3NLUkFDSmljdURSZE5jcm1SVXJTUU1IREdiYXZXbDVieFlJ?=
 =?utf-8?B?V0txUWMyTXk4a080SmRvc2svVUJNeTR2SnlNL3hwWFRrSGRKS1FkZUNuNFNi?=
 =?utf-8?B?Y0NwNlV1bVZGVUk4a0NnTEs0bjIxcW03YzJwaUVBV1RHL0xQMk40a2VNN0Jr?=
 =?utf-8?B?VVNIYUJnN3BGemx6UWRnSUVqS0RaRHNNbkk4citkMC93cE9LYTZkR29ESW1I?=
 =?utf-8?B?a1BReHh1TGxzRkg2Rmh5Z2xvQ2R5RndQUEdXdkppMWxCdkZlbGxzOEx6S25D?=
 =?utf-8?B?aXZMWTkvOWc2Nkd2L2ZBRW1rdW4zZjZPbDJvejgzVXJ4MWVxdFI2bDZJTTRo?=
 =?utf-8?Q?pnyy8nNE2D0vZ?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69e4d642-bfe3-4d98-d3ef-08d8cde49904
X-MS-Exchange-CrossTenant-AuthSource: BN6PR10MB1683.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2021 16:54:58.1440
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ETIf3PnwFrD5rGvcAwiJsKHHqAAC6pCl7tE4I+TxUcAjrjjhgau4Wsp7l1ivrytEwUcHzTlJbqIzCPSJpiJF9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR10MB2417
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9891 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 phishscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102100156
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9891 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 spamscore=0 lowpriorityscore=0 phishscore=0 adultscore=0 impostorscore=0
 suspectscore=0 mlxscore=0 clxscore=1015 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102100156
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 05/02/2021 20:55, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> When we active a swap file, at btrfs_swap_activate(), we acquire the
> exclusive operation lock to prevent the physical location of the swap
> file extents to be changed by operations such as balance and device
> replace/resize/remove. We also call there can_nocow_extent() which,
> among other things, checks if the block group of a swap file extent is
> currently RO, and if it is we can not use the extent, since a write
> into it would result in COWing the extent.
> 
> However we have no protection against a scrub operation running after we
> activate the swap file, which can result in the swap file extents to be
> COWed while the scrub is running and operating on the respective block
> group, because scrub turns a block group into RO before it processes it
> and then back again to RW mode after processing it. That means an attempt
> to write into a swap file extent while scrub is processing the respective
> block group, will result in COWing the extent, changing its physical
> location on disk.
> 
> Fix this by making sure that block groups that have extents that are used
> by active swap files can not be turned into RO mode, therefore making it
> not possible for a scrub to turn them into RO mode. When a scrub finds a
> block group that can not be turned to RO due to the existence of extents
> used by swap files, it proceeds to the next block group and logs a warning
> message that mentions the block group was skipped due to active swap
> files - this is the same approach we currently use for balance.
> 
> Fixes: ed46ff3d42378 ("Btrfs: support swap files")
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Looks good.
Reviewed-by: Anand Jain <anand.jain@oracle.com>

Thanks, Anand

> ---
>   fs/btrfs/block-group.c | 33 ++++++++++++++++++++++++++++++++-
>   fs/btrfs/block-group.h |  9 +++++++++
>   fs/btrfs/ctree.h       |  5 +++++
>   fs/btrfs/inode.c       | 19 ++++++++++++++++++-
>   fs/btrfs/scrub.c       |  9 ++++++++-
>   5 files changed, 72 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
> index 5fa6b3d540f4..c0a8ddf92ef8 100644
> --- a/fs/btrfs/block-group.c
> +++ b/fs/btrfs/block-group.c
> @@ -1150,6 +1150,11 @@ static int inc_block_group_ro(struct btrfs_block_group *cache, int force)
>   	spin_lock(&sinfo->lock);
>   	spin_lock(&cache->lock);
>   
> +	if (cache->swap_extents) {
> +		ret = -ETXTBSY;
> +		goto out;
> +	}
> +
>   	if (cache->ro) {
>   		cache->ro++;
>   		ret = 0;
> @@ -2260,7 +2265,7 @@ int btrfs_inc_block_group_ro(struct btrfs_block_group *cache,
>   	}
>   
>   	ret = inc_block_group_ro(cache, 0);
> -	if (!do_chunk_alloc)
> +	if (!do_chunk_alloc || ret == -ETXTBSY)
>   		goto unlock_out;
>   	if (!ret)
>   		goto out;
> @@ -2269,6 +2274,8 @@ int btrfs_inc_block_group_ro(struct btrfs_block_group *cache,
>   	if (ret < 0)
>   		goto out;
>   	ret = inc_block_group_ro(cache, 0);
> +	if (ret == -ETXTBSY)
> +		goto unlock_out;
>   out:
>   	if (cache->flags & BTRFS_BLOCK_GROUP_SYSTEM) {
>   		alloc_flags = btrfs_get_alloc_profile(fs_info, cache->flags);
> @@ -3352,6 +3359,7 @@ int btrfs_free_block_groups(struct btrfs_fs_info *info)
>   		ASSERT(list_empty(&block_group->io_list));
>   		ASSERT(list_empty(&block_group->bg_list));
>   		ASSERT(refcount_read(&block_group->refs) == 1);
> +		ASSERT(block_group->swap_extents == 0);
>   		btrfs_put_block_group(block_group);
>   
>   		spin_lock(&info->block_group_cache_lock);
> @@ -3418,3 +3426,26 @@ void btrfs_unfreeze_block_group(struct btrfs_block_group *block_group)
>   		__btrfs_remove_free_space_cache(block_group->free_space_ctl);
>   	}
>   }
> +
> +bool btrfs_inc_block_group_swap_extents(struct btrfs_block_group *bg)
> +{
> +	bool ret = true;
> +
> +	spin_lock(&bg->lock);
> +	if (bg->ro)
> +		ret = false;
> +	else
> +		bg->swap_extents++;
> +	spin_unlock(&bg->lock);
> +
> +	return ret;
> +}
> +
> +void btrfs_dec_block_group_swap_extents(struct btrfs_block_group *bg, int amount)
> +{
> +	spin_lock(&bg->lock);
> +	ASSERT(!bg->ro);
> +	ASSERT(bg->swap_extents >= amount);
> +	bg->swap_extents -= amount;
> +	spin_unlock(&bg->lock);
> +}
> diff --git a/fs/btrfs/block-group.h b/fs/btrfs/block-group.h
> index 8f74a96074f7..105094bd1821 100644
> --- a/fs/btrfs/block-group.h
> +++ b/fs/btrfs/block-group.h
> @@ -181,6 +181,12 @@ struct btrfs_block_group {
>   	 */
>   	int needs_free_space;
>   
> +	/*
> +	 * Number of extents in this block group used for swap files.
> +	 * All accesses protected by the spinlock 'lock'.
> +	 */
> +	int swap_extents;
> +
>   	/* Record locked full stripes for RAID5/6 block group */
>   	struct btrfs_full_stripe_locks_tree full_stripe_locks_root;
>   };
> @@ -296,6 +302,9 @@ static inline int btrfs_block_group_done(struct btrfs_block_group *cache)
>   void btrfs_freeze_block_group(struct btrfs_block_group *cache);
>   void btrfs_unfreeze_block_group(struct btrfs_block_group *cache);
>   
> +bool btrfs_inc_block_group_swap_extents(struct btrfs_block_group *bg);
> +void btrfs_dec_block_group_swap_extents(struct btrfs_block_group *bg, int amount);
> +
>   #ifdef CONFIG_BTRFS_FS_RUN_SANITY_TESTS
>   int btrfs_rmap_block(struct btrfs_fs_info *fs_info, u64 chunk_start,
>   		     u64 physical, u64 **logical, int *naddrs, int *stripe_len);
> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> index a9b0521d9e89..0597e85ab38c 100644
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -523,6 +523,11 @@ struct btrfs_swapfile_pin {
>   	 * points to a struct btrfs_device.
>   	 */
>   	bool is_block_group;
> +	/*
> +	 * Only used when 'is_block_group' is true and it is the number of
> +	 * extents used by a swapfile for this block group ('ptr' field).
> +	 */
> +	int bg_extent_count;
>   };
>   
>   bool btrfs_pinned_by_swapfile(struct btrfs_fs_info *fs_info, void *ptr);
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 76a0151ef05a..715ae1320383 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -10010,6 +10010,7 @@ static int btrfs_add_swapfile_pin(struct inode *inode, void *ptr,
>   	sp->ptr = ptr;
>   	sp->inode = inode;
>   	sp->is_block_group = is_block_group;
> +	sp->bg_extent_count = 1;
>   
>   	spin_lock(&fs_info->swapfile_pins_lock);
>   	p = &fs_info->swapfile_pins.rb_node;
> @@ -10023,6 +10024,8 @@ static int btrfs_add_swapfile_pin(struct inode *inode, void *ptr,
>   			   (sp->ptr == entry->ptr && sp->inode > entry->inode)) {
>   			p = &(*p)->rb_right;
>   		} else {
> +			if (is_block_group)
> +				entry->bg_extent_count++;
>   			spin_unlock(&fs_info->swapfile_pins_lock);
>   			kfree(sp);
>   			return 1;
> @@ -10048,8 +10051,11 @@ static void btrfs_free_swapfile_pins(struct inode *inode)
>   		sp = rb_entry(node, struct btrfs_swapfile_pin, node);
>   		if (sp->inode == inode) {
>   			rb_erase(&sp->node, &fs_info->swapfile_pins);
> -			if (sp->is_block_group)
> +			if (sp->is_block_group) {
> +				btrfs_dec_block_group_swap_extents(sp->ptr,
> +							   sp->bg_extent_count);
>   				btrfs_put_block_group(sp->ptr);
> +			}
>   			kfree(sp);
>   		}
>   		node = next;
> @@ -10264,6 +10270,17 @@ static int btrfs_swap_activate(struct swap_info_struct *sis, struct file *file,
>   			goto out;
>   		}
>   
> +		if (!btrfs_inc_block_group_swap_extents(bg)) {
> +			btrfs_warn(fs_info,
> +			   "block group for swapfile at %llu is read-only%s",
> +			   bg->start,
> +			   atomic_read(&fs_info->scrubs_running) ?
> +				   " (scrub running)" : "");
> +			btrfs_put_block_group(bg);
> +			ret = -EINVAL;
> +			goto out;
> +		}
> +
>   		ret = btrfs_add_swapfile_pin(inode, bg, true);
>   		if (ret) {
>   			btrfs_put_block_group(bg);
> diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
> index 5f4f88a4d2c8..c09a494be8c6 100644
> --- a/fs/btrfs/scrub.c
> +++ b/fs/btrfs/scrub.c
> @@ -3630,6 +3630,13 @@ int scrub_enumerate_chunks(struct scrub_ctx *sctx,
>   			 * commit_transactions.
>   			 */
>   			ro_set = 0;
> +		} else if (ret == -ETXTBSY) {
> +			btrfs_warn(fs_info,
> +		   "skipping scrub of block group %llu due to active swapfile",
> +				   cache->start);
> +			scrub_pause_off(fs_info);
> +			ret = 0;
> +			goto skip_unfreeze;
>   		} else {
>   			btrfs_warn(fs_info,
>   				   "failed setting block group ro: %d", ret);
> @@ -3719,7 +3726,7 @@ int scrub_enumerate_chunks(struct scrub_ctx *sctx,
>   		} else {
>   			spin_unlock(&cache->lock);
>   		}
> -
> +skip_unfreeze:
>   		btrfs_unfreeze_block_group(cache);
>   		btrfs_put_block_group(cache);
>   		if (ret)
> 

